import Foundation
import Combine

protocol NewsSource {
    func fetchNews() -> AnyPublisher<[Article], Error>
}