//
//  FeedViewModel.swift
//  TestFeed
//
//  Created by Ilya Matveev on 21.11.2021.
//

import Foundation
import Combine

final class FeedViewModel: ObservableObject {
    @Published private(set) var state: State = .init()
    private var subscriptions: Set<AnyCancellable> = .init()
    
    func filterPosts(_ filter: PostFilter, period: PostPeriod?) {
        state.canLoadNextPage = true
        state.cursor = nil
        state.filter = filter
        state.period = period
        fetchNextPage()
    }
    
    func fetchNextPage() {
        guard state.canLoadNextPage else { return }
        
        Current.postsSvc.getPosts(state.filter, for: state.period, after: state.cursor)
            .sink(receiveCompletion: onReceive,
                  receiveValue: onReceive)
            .store(in: &subscriptions)
    }
    
    private func onReceive(_ completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure:
            break
        }
    }
    
    private func onReceive(_ data: PostsData) {
        if data.cursor == nil {
            state.canLoadNextPage = false
        }
        
        state.posts += data.items
        state.cursor = data.cursor
    }
    
}

extension FeedViewModel {
    struct State {
        var filter: PostFilter = .newest
        var period: PostPeriod?
        var cursor: String?
        var posts: [Post] = []
        var canLoadNextPage: Bool = true
    }
}
