import Foundation

struct NewsSource: Identifiable {
    let id: String
    let name: String
    let url: URL
    let articleSelector: String
    let titleSelector: String
    let linkSelector: String
    let descriptionSelector: String
    let dateSelector: String
    let imageSelector: String?
}