//
//  Posts.swift
//  TestFeed
//
//  Created by Ilya Matveev on 21.11.2021.
//

import Foundation

struct Posts: Codable {
    let data: PostsData
}

struct PostsData: Codable {
    let items: [Post]
    let cursor: String?
}

struct Post: Codable, Identifiable, Equatable {
    let id: String
    let isCreatedByPage: Bool?
    let isCommentable, hasAdultContent, isAuthorHidden, isHiddenInProfile: Bool
    let contents: [Content]
    let createdAt, updatedAt: Int
    let isSecret: Bool
    let isMyFavorite: Bool

    enum CodingKeys: String, CodingKey {
        case id, isCreatedByPage
        case isCommentable, hasAdultContent, isAuthorHidden, isHiddenInProfile, contents, createdAt, updatedAt, isSecret, isMyFavorite
    }
    
    static func == (lhs: Post, rhs: Post) -> Bool {
        lhs.id == rhs.id
    }
}

struct Auth: Codable {
    let isDisabled: Bool
    let lastSeenAt, level: Int
}

struct Banner: Codable {
    let type: BannerType
    let id: String
    let data: BannerData
}

struct BannerData: Codable {
    let extraSmall, small: Image?
    let medium, large: Image?
    let original: Image
    let extraLarge: Image?
}

struct Image: Codable {
    let url: String
    let size: Size
}

struct Size: Codable {
    let width, height: Int
}

enum BannerType: String, Codable {
    case image = "IMAGE"
    case imageGIF = "IMAGE_GIF"
}

struct Content: Codable {
    let type: ContentType
    let id: String?
    let data: ContentData
}

struct ContentData: Codable {
    let extraSmall, small, medium, large: Image?
    let original: Image?
    let value: String?
    let values: [String]?
    let duration: Double?
    let url: String?
    let size: Size?
    let previewImage: Banner?
    let extraLarge: Image?
}

enum ContentType: String, Codable {
    case image = "IMAGE"
    case tags = "TAGS"
    case text = "TEXT"
    case video = "VIDEO"
}
