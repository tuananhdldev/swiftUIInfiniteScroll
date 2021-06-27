//
//  ContentView.swift
//  Shared
//
//  Created by Tuan Hoang Anh on 6/11/21.
//

import SwiftUI

struct ContentView: View {
    let viewmodel = RepositoriesViewModel()
    
    var body: some View {
        
        RepositoriesListContainer(viewModel: viewmodel )
    }
}


struct RepositoriesListContainer: View {
    @ObservedObject var viewModel: RepositoriesViewModel
    var body: some View
    {
        RepositoriesList(repos: viewModel.state.repos, isLoading: viewModel.state.canLoadNextPage, onScrolledAtBottom: viewModel.fetchNextPageIfPossible)
            .onAppear(perform: {
                viewModel.fetchNextPageIfPossible()
            })
    }
}
