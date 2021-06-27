//
//  GitHubAPI.swift
//  InfiniteScrollingSwiftUI
//
//  Created by Tuan Hoang Anh on 6/12/21.
//

import Foundation
import Combine

enum GitHubAPI {
    static let pageSize =  10
    static func searchRepos( query: String, page: Int)->AnyPublisher<[Repository], Error>{
        let  url = URL(string: "https://api.github.com/search/repositories?q=\(query)&sort=stars&per_page=\(Self.pageSize)&page=\(page)")!
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .handleEvents(receiveOutput: {
                print(NSString(data: $0.data, encoding: String.Encoding.utf8.rawValue)!)
            })
            .tryMap {try JSONDecoder().decode(GitHubSearchResult<Repository>.self, from: $0.data).items}
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
    }
}

struct GitHubSearchResult<T: Codable>: Codable {
    let items: [T]
}
struct Repository: Codable, Identifiable,Equatable {
    let id: Int
    let name: String
    let description: String?
    let stargazers_count: Int
}
