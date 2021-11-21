//
//  Environment.swift
//  TestFeed
//
//  Created by Ilya Matveev on 21.11.2021.
//

import Foundation

struct Environment {
    /// Posts management service
    private(set) var postsSvc: PostsService = .init()
    /// HTTP Gateway
    var http: HTTPGateway = .init(url: "https://stage.apianon.ru/")
}

var Current: Environment = .init()
