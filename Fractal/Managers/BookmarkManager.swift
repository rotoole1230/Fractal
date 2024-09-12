import Foundation
import Combine

class BookmarkManager: ObservableObject {
    @Published private(set) var bookmarkedArticles: [Article] = []
    private let userDefaults = UserDefaults.standard
    private let bookmarksKey = "bookmarkedArticles"
    
    init() {
        loadBookmarks()
    }
    
    func toggleBookmark(for article: Article) {
        if let index = bookmarkedArticles.firstIndex(where: { $0.url == article.url }) {
            bookmarkedArticles.remove(at: index)
        } else {
            bookmarkedArticles.append(article)
        }
        saveBookmarks()
    }
    
    func isBookmarked(_ article: Article) -> Bool {
        bookmarkedArticles.contains(where: { $0.url == article.url })
    }
    
    private func loadBookmarks() {
        if let data = userDefaults.data(forKey: bookmarksKey),
           let decodedArticles = try? JSONDecoder().decode([Article].self, from: data) {
            bookmarkedArticles = decodedArticles
        }
    }
    
    private func saveBookmarks() {
        if let encodedData = try? JSONEncoder().encode(bookmarkedArticles) {
            userDefaults.set(encodedData, forKey: bookmarksKey)
        }
    }
}