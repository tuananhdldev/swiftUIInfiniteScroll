//
//  RepositoriesList.swift
//  InfiniteScrollingSwiftUI
//
//  Created by Tuan Hoang Anh on 6/24/21.
//

import Foundation
import SwiftUI
struct RepositoriesList: View {
  
    let repos: [Repository]
    let isLoading: Bool
    let onScrolledAtBottom:()->Void
    
    var body: some View
    {
        List{
            reposList
            if isLoading
            {
                loadingIndicator
            }
            
        }
        
    }
    private var reposList: some View {
        ForEach(repos){repos in
            RepositoryRow(repo: repos).onAppear
            {
                if self.repos.last == repos
                {
                    self.onScrolledAtBottom()
                }
            }
        }
        
    }
    
    struct RepositoryRow: View {
        let repo: Repository
        var body: some View {
            VStack{
                Text(repo.name).font(.title)
                Text("⭐️ \(repo.stargazers_count) ")
                repo.description.map(Text.init)?.font(.body)
            }
            .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .center)
        }
        
    }
    
    private var loadingIndicator: some View {
       
        Spinner(style: .medium)
            .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .center)
    }
    
}
