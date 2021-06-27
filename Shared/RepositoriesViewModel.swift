//
//  RepositoriesViewModel.swift
//  InfiniteScrollingSwiftUI
//
//  Created by Tuan Hoang Anh on 6/24/21.
//

import Foundation
import Combine
class RepositoriesViewModel: ObservableObject {
    @Published private(set) var state = State()
    private var subscriptions =  Set<AnyCancellable>()
    
    func fetchNextPageIfPossible()  {
        guard state.canLoadNextPage else {
            return
        }
        GitHubAPI.searchRepos(query: "swift", page: state.page)
            .sink(receiveCompletion: onRecieve, receiveValue: onRecieve)
            .store(in: &subscriptions)
        
    }
    
    
    private func onRecieve(_ completion: Subscribers.Completion<Error>)
    {
        switch completion {
        case .finished:
            break
        case .failure:
            state.canLoadNextPage = false
        }
    }
    
    private func onRecieve(_ batch: [Repository])
    {
        state.repos += batch
        state.page += 1
        state.canLoadNextPage = batch.count == GitHubAPI.pageSize
    }
    
    
    struct State {
        var repos:[Repository] = []
        var page: Int = 1
        var canLoadNextPage = true
    }
}
