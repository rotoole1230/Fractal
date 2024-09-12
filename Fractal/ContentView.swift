//
//  ContentView.swift
//  Fractal
//
//  Created by Ryan OToole on 9/11/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var bookmarkManager = BookmarkManager()
    @AppStorage("isDarkMode") private var isDarkMode = false
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        TabView {
            NewsFeedView()
                .tabItem {
                    Label("News", systemImage: "newspaper")
                }
            
            BookmarksView()
                .tabItem {
                    Label("Bookmarks", systemImage: "bookmark")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
        .accentColor(Color.customSolanaPurple)
        .environmentObject(bookmarkManager)
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try PersistenceController.shared.save()
            } catch {
                // Handle the error appropriately
                print("Failed to save item: \(error.localizedDescription)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try PersistenceController.shared.save()
            } catch {
                // Handle the error appropriately
                print("Failed to delete items: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    ContentView()
}
