import Foundation
import Combine
import Fuzi

class RSSFeedManager {
    static let shared = RSSFeedManager()
    
    private init() {}
    
    func fetchNews(from source: NewsSource) -> AnyPublisher<[Article], Error> {
        return URLSession.shared.dataTaskPublisher(for: source.url)
            .tryMap { data, response -> HTMLDocument in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return try HTMLDocument(data: data)
            }
            .flatMap { document -> AnyPublisher<[Article], Error> in
                let articles = self.parseArticles(from: document, using: source)
                return Just(articles)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    private func parseArticles(from document: HTMLDocument, using source: NewsSource) -> [Article] {
        return document.xpath(source.articleSelector).compactMap { element -> Article? in
            guard let title = element.firstChild(xpath: source.titleSelector)?.stringValue,
                  let link = element.firstChild(xpath: source.linkSelector)?["href"],
                  let url = URL(string: link, relativeTo: source.url),
                  let description = element.firstChild(xpath: source.descriptionSelector)?.stringValue,
                  let dateString = element.firstChild(xpath: source.dateSelector)?.stringValue,
                  let date = DateFormatter.articleDateFormatter.date(from: dateString) else {
                return nil
            }
            
            let imageUrl = source.imageSelector.flatMap { selector in
                element.firstChild(xpath: selector)?["src"].flatMap { URL(string: $0) }
            }
            
            return Article(
                title: title,
                description: description,
                url: url,
                urlToImage: imageUrl?.absoluteString,
                publishedAt: ISO8601DateFormatter().string(from: date),
                source: Article.Source(name: source.name)
            )
        }
    }
}

extension DateFormatter {
    static let articleDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()
}
