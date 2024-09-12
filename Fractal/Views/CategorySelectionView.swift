import SwiftUI

struct CategorySelectionView: View {
    @Binding var selectedCategories: Set<Article.Category>
    
    var body: some View {
        List {
            ForEach(Article.Category.allCases, id: \.self) { category in
                Button(action: {
                    if selectedCategories.contains(category) {
                        selectedCategories.remove(category)
                    } else {
                        selectedCategories.insert(category)
                    }
                }) {
                    HStack {
                        Text(category.rawValue)
                        Spacer()
                        if selectedCategories.contains(category) {
                            Image(systemName: "checkmark")
                                .foregroundColor(Color.customSolanaPurple)
                        }
                    }
                }
            }
        }
        .navigationTitle("Select Categories")
    }
}
