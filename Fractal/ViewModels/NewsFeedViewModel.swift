import Foundation
import Combine

class NewsFeedViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var isLoading = false
    @Published var error: Error?
    
    private var cancellables = Set<AnyCancellable>()
    private let cacheManager = CacheManager.shared
    private let refreshInterval: TimeInterval = 300 // 5 minutes
    
    init() {
        loadCachedArticles()
    }
    
    func fetchArticles() {
        if !articles.isEmpty && Date().timeIntervalSince(cacheManager.lastFetchDate ?? .distantPast) < refreshInterval {
            return
        }
        
        isLoading = true
        error = nil
        
        let publishers = NewsSources.sources.map { RSSFeedManager.shared.fetchNews(from: $0) }
        
        Publishers.MergeMany(publishers)
            .collect()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.handleError(error)
                }
            } receiveValue: { [weak self] articleArrays in
                let allArticles = articleArrays.flatMap { $0 }
                self?.handleNewArticles(allArticles)
            }
            .store(in: &cancellables)
    }
    
    private func loadCachedArticles() {
        if let cachedArticles = cacheManager.getCachedArticles() {
            self.articles = cachedArticles
        }
    }
    
    private func handleError(_ error: Error) {
        self.error = error
        print("Error fetching articles: \(error.localizedDescription)")
        loadCachedArticles() // Fallback to cached articles on error
    }
    
    private func handleNewArticles(_ newArticles: [Article]) {
        let sortedArticles = newArticles.sorted(by: { $0.publishedAt > $1.publishedAt })
        self.articles = sortedArticles
        cacheManager.saveArticles(sortedArticles)
    }
}
