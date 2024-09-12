import SwiftUI

struct NewsFeedView: View {
    @StateObject private var viewModel = NewsFeedViewModel()
    @EnvironmentObject var bookmarkManager: BookmarkManager
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView()
                } else if let error = viewModel.error {
                    ErrorView(error: error, retryAction: viewModel.fetchArticles)
                } else {
                    List {
                        ForEach(viewModel.articles) { article in
                            ArticleRowView(article: article, isBookmarked: bookmarkManager.isBookmarked(article)) {
                                bookmarkManager.toggleBookmark(for: article)
                            }
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button {
                                    bookmarkManager.toggleBookmark(for: article)
                                } label: {
                                    Label("Bookmark", systemImage: "bookmark")
                                }
                                .tint(Color.customSolanaPurple)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Solana News")
            .refreshable {
                viewModel.fetchArticles()
            }
        }
        .onAppear {
            viewModel.fetchArticles()
        }
    }
}

struct ErrorView: View {
    let error: Error
    let retryAction: () -> Void
    
    var body: some View {
        VStack {
            Text("An error occurred:")
            Text(error.localizedDescription)
                .foregroundColor(.red)
            Button("Retry") {
                retryAction()
            }
            .padding()
            .background(Color.customSolanaPurple)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
    }
}