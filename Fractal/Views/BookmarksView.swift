import SwiftUI

struct BookmarksView: View {
    @EnvironmentObject var bookmarkManager: BookmarkManager
    
    var body: some View {
        NavigationView {
            List(bookmarkManager.bookmarkedArticles) { article in
                ArticleRowView(article: article, isBookmarked: true) {
                    bookmarkManager.toggleBookmark(for: article)
                }
            }
            .navigationTitle("Bookmarks")
        }
        .accentColor(Color.customSolanaPurple)
    }
}
