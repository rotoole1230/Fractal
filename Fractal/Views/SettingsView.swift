import SwiftUI

struct SettingsView: View {
    @AppStorage("enableNotifications") private var enableNotifications = false
    @AppStorage("selectedCategories") private var selectedCategoriesData = Data()
    @State private var selectedCategories: Set<Article.Category> = Set(Article.Category.allCases)
    @EnvironmentObject var bookmarkManager: BookmarkManager
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Notifications")) {
                    Toggle("Enable Notifications", isOn: $enableNotifications)
                        .tint(Color.customSolanaPurple)
                }
                
                Section(header: Text("Personalization")) {
                    NavigationLink(destination: CategorySelectionView(selectedCategories: $selectedCategories)) {
                        Text("Select Categories")
                    }
                }
                
                Section(header: Text("Data")) {
                    Button("Clear Bookmarks") {
                        bookmarkManager.bookmarkedArticles.removeAll()
                    }
                    .foregroundColor(Color.customSolanaPurple)
                }
                
                Section(header: Text("About")) {
                    Text("Solana News Aggregator")
                    Text("Version 1.0")
                }
            }
            .navigationTitle("Settings")
        }
        .onAppear(perform: loadSelectedCategories)
        .onDisappear(perform: saveSelectedCategories)
    }
    
    private func loadSelectedCategories() {
        if let categories = try? JSONDecoder().decode(Set<Article.Category>.self, from: selectedCategoriesData) {
            selectedCategories = categories
        }
    }
    
    private func saveSelectedCategories() {
        if let data = try? JSONEncoder().encode(selectedCategories) {
            selectedCategoriesData = data
        }
    }
}