//
//  PhotoListResponse.swift
//  GalleryOfPhotos
//
//  Created by rafiul hasan on 3/6/22.
//

import Foundation

// MARK: - PhotosResponseModel
struct PhotosResponseModel: Codable {
    let id: String
    let width, height: Int
    let color, blurHash: String
    let photoResponseDescription, altDescription: String?
    let urls: Urls
    let links: PhotoResponseLinks
    let categories: [String]
    let likes: Int
    let likedByUser: Bool
    let currentUserCollections: [String]
    let sponsorship: Sponsorship?
    let user: User

    enum CodingKeys: String, CodingKey {
        case id
        case width, height, color
        case blurHash = "blur_hash"
        case photoResponseDescription = "description"
        case altDescription = "alt_description"
        case urls, links, categories, likes
        case likedByUser = "liked_by_user"
        case currentUserCollections = "current_user_collections"
        case sponsorship
        case user
    }
}

// MARK: - PhotoResponseLinks
struct PhotoResponseLinks: Codable {
    let linksSelf, html, download, downloadLocation: String

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, download
        case downloadLocation = "download_location"
    }
}

// MARK: - Sponsorship
struct Sponsorship: Codable {
    let impressionUrls: [String]
    let tagline: String
    let taglineURL: String
    let sponsor: User

    enum CodingKeys: String, CodingKey {
        case impressionUrls = "impression_urls"
        case tagline
        case taglineURL = "tagline_url"
        case sponsor
    }
}

// MARK: - User
struct User: Codable {
    let id: String
    let username, name, firstName: String
    let lastName, twitterUsername: String?
    let portfolioURL: String?
    let bio, location: String?
    let links: UserLinks
    let profileImage: ProfileImage
    let instagramUsername: String?
    let totalCollections, totalLikes, totalPhotos: Int
    let acceptedTos, forHire: Bool
    let social: Social

    enum CodingKeys: String, CodingKey {
        case id
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
        case social
    }
}

// MARK: - UserLinks
struct UserLinks: Codable {
    let linksSelf, html, photos, likes: String
    let portfolio, following, followers: String

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, photos, likes, portfolio, following, followers
    }
}

// MARK: - ProfileImage
struct ProfileImage: Codable {
    let small, medium, large: String
}

// MARK: - Social
struct Social: Codable {
    let instagramUsername: String?
    let portfolioURL: String?
    let twitterUsername: String?
    let paypalEmail: String?

    enum CodingKeys: String, CodingKey {
        case instagramUsername = "instagram_username"
        case portfolioURL = "portfolio_url"
        case twitterUsername = "twitter_username"
        case paypalEmail = "paypal_email"
    }
}

// MARK: - TopicSubmissions
struct TopicSubmissions: Codable {
    let blockchain: Blockchain?
    let experimental, streetPhotography: Experimental?

    enum CodingKeys: String, CodingKey {
        case blockchain, experimental
        case streetPhotography = "street-photography"
    }
}

// MARK: - Blockchain
struct Blockchain: Codable {
    let status: String
    let approvedOn: Date

    enum CodingKeys: String, CodingKey {
        case status
        case approvedOn = "approved_on"
    }
}

// MARK: - Experimental
struct Experimental: Codable {
    let status: String
}

// MARK: - Urls
struct Urls: Codable {
    let raw, full, regular, small: String
    let thumb, smallS3: String

    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb
        case smallS3 = "small_s3"
    }
}
