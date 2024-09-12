import Foundation

public struct Article: Identifiable, Codable {
    public let id = UUID()
    public let title: String
    public let description: String
    public let url: URL
    public let urlToImage: String?
    public let publishedAt: String
    public let source: Source
    public var category: Category = .general
    public var isBookmarked: Bool = false
    
    public enum Category: String, CaseIterable, Codable {
        case general = "General"
        case defi = "DeFi"
        case nft = "NFTs"
        case technical = "Technical Updates"
    }
    
    public struct Source: Codable, CustomStringConvertible {
        public let name: String
        
        public var description: String {
            return name
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case title, description, url, urlToImage, publishedAt, source
    }
}