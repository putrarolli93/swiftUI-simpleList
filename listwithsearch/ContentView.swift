//
//  ContentView.swift
//  listwithsearch
//
//  Created by putra rolli on 09/10/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var listData = [ListData]()
    @State private var searchText = ""
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(searchResults, id: \.title) { i in
                    NavigationLink(destination: Text(i.body)) {
                        Text(i.title)
                    }
                }
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .navigationTitle("Home")
        }.onAppear(perform: runSearch)
    }
    
    var searchResults: [ListData] {
        if searchText.isEmpty {
            return viewModel.list
        } else {
            return viewModel.list.filter {
                $0.title.contains(searchText)
            }
        }
    }
    
    func runSearch() {
        Task {
            listData = viewModel.list
        }
    }
}
