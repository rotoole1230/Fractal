import Foundation

class CacheManager {
    static let shared = CacheManager()
    private let userDefaults = UserDefaults.standard
    private let cachedArticlesKey = "cachedArticles"
    private let lastFetchDateKey = "lastFetchDate"
    
    private init() {}
    
    func getCachedArticles() -> [Article]? {
        guard let data = userDefaults.data(forKey: cachedArticlesKey),
              let articles = try? JSONDecoder().decode([Article].self, from: data) else {
            return nil
        }
        return articles
    }
    
    func saveArticles(_ articles: [Article]) {
        if let encodedData = try? JSONEncoder().encode(articles) {
            userDefaults.set(encodedData, forKey: cachedArticlesKey)
            userDefaults.set(Date(), forKey: lastFetchDateKey)
        }
    }
    
    var lastFetchDate: Date? {
        return userDefaults.object(forKey: lastFetchDateKey) as? Date
    }
}