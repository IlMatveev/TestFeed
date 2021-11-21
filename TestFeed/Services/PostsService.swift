//
//  PostsService.swift
//  TestFeed
//
//  Created by Ilya Matveev on 21.11.2021.
//

import Foundation
import Combine

enum PostFilter: String, Encodable {
    case myMix = "MY_MIX"
    case newest = "NEWEST"
    case top = "TOP"
}

enum PostPeriod: String, Encodable {
    case lastYear = "LAST_YEAR"
    case lastMonth = "LAST_MONTH"
}

final class PostsService {
    func getPosts(_ filter: PostFilter, for period: PostPeriod?, after cursor: String?) -> AnyPublisher<PostsData, Error> {
        return Current
            .http
            .get(value: (filter, period, cursor), at: .posts, source: .postsRequest, target: .identity)
            .map(\.data)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

// MARK: - Data sources

private extension ExchangePath {
    static var posts: ExchangePath<(PostFilter, PostPeriod?, String?), Posts> {
        .init(path: "posts/v1/main")
    }
}

// MARK: - DTO

private struct PostsRequestParams: ParametersConvertable {
    let filter: PostFilter
    let periodOfTime: PostPeriod?
    let first: String = "20"
    let after: String?
}

// MARK: - Converters

private extension Converter {
    static var postsRequest: Converter<(PostFilter, PostPeriod?, String?), PostsRequestParams> {
        .init(convert: PostsRequestParams.init)
    }
}
