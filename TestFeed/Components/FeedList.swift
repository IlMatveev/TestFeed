//
//  FeedList.swift
//  TestFeed
//
//  Created by Ilya Matveev on 21.11.2021.
//

import SwiftUI

struct FeedList: View {
    let posts: [Post]
    let isLoading: Bool
    let onScrolledAtBottom: () -> Void
    
    var body: some View {
        List {
            postsList
            if isLoading {
                loadingIndicator
            }
        }
    }
    
    private var postsList: some View {
        ForEach(posts) { post in
            PostRow(post: post)
                .onAppear {
                    if self.posts.last == post {
                        self.onScrolledAtBottom()
                    }
                }
                .listRowSeparator(.hidden)
        }
    }
    
    private var loadingIndicator: some View {
        ProgressView()
    }
}
