//
//  ProfileModel.swift
//  GalleryOfPhotos
//
//  Created by rafiul hasan on 10/6/22.
//

import Foundation

// MARK: - ProfileModel
struct ProfileModel: Codable {
    let id: String
    //let updatedAt: Date
    let username, name, firstName, lastName: String
    let twitterUsername, portfolioURL, bio, location: String?
    let links: Links
    let profileImage: ProfileImage
    let instagramUsername: String?
    let totalCollections, totalLikes, totalPhotos: Int
    let acceptedTos, forHire: Bool
    //let social: Social
    let followedByUser: Bool
    let photos: [Photo]
    let badge: String?
    let tags: Tags
    let followersCount, followingCount: Int
    let allowMessages: Bool
    let numericID, downloads: Int

    enum CodingKeys: String, CodingKey {
        case id
        //case updatedAt = "updated_at"
        case username, name
        case firstName = "first_name"
        case lastName = "last_name"
        case twitterUsername = "twitter_username"
        case portfolioURL = "portfolio_url"
        case bio, location, links
        case profileImage = "profile_image"
        case instagramUsername = "instagram_username"
        case totalCollections = "total_collections"
        case totalLikes = "total_likes"
        case totalPhotos = "total_photos"
        case acceptedTos = "accepted_tos"
        case forHire = "for_hire"
        //case social
        case followedByUser = "followed_by_user"
        case photos, badge, tags
        case followersCount = "followers_count"
        case followingCount = "following_count"
        case allowMessages = "allow_messages"
        case numericID = "numeric_id"
        case downloads
    }
}

// MARK: - Links
struct Links: Codable {
    let linksSelf, html, photos, likes: String
    let portfolio, following, followers: String

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, photos, likes, portfolio, following, followers
    }
}

// MARK: - Meta
struct Meta: Codable {
    let index: Bool
}

// MARK: - Photo
struct Photo: Codable {
    let id: String
    let createdAt, updatedAt: Date
    let blurHash: String
    let urls: Urls

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case blurHash = "blur_hash"
        case urls
    }
}

// MARK: - Tags
struct Tags: Codable {
    let custom, aggregated: [String]
}
