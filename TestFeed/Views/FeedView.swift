//
//  ContentView.swift
//  TestFeed
//
//  Created by Ilya Matveev on 21.11.2021.
//

import SwiftUI

struct FeedView: View {
    @ObservedObject var model: FeedViewModel
    
    var body: some View {
        Filter(
            filter: model.state.filter,
            period: model.state.period,
            selectFilter: { filter, period in
                model.filterPosts(filter, period: period)
            }
        )
        FeedList(
            posts: model.state.posts,
            isLoading: model.state.canLoadNextPage,
            onScrolledAtBottom: model.fetchNextPage
        )
            .onAppear {
                UITableView.appearance().backgroundColor = .clear
            }
            .onAppear(perform: model.fetchNextPage)
            .padding(.top)
    }
}
