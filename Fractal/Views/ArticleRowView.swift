import SwiftUI

struct ArticleRowView: View {
    let article: Article
    let isBookmarked: Bool
    let bookmarkAction: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(article.title)
                .font(.headline)
                .fontWeight(.bold)
            Text(article.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
            HStack {
                Text(article.source.name)  // Change this line
                    .font(.caption)
                Spacer()
                Text(article.category.rawValue)
                    .font(.caption)
                    .padding(4)
                    .background(Color.customSolanaGreen.opacity(0.1))
                    .foregroundColor(Color.customSolanaGreen)
                    .cornerRadius(4)
                Button(action: bookmarkAction) {
                    Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                        .foregroundColor(Color.customSolanaPurple)
                }
            }
        }
        .padding(.vertical, 8)
    }
}
