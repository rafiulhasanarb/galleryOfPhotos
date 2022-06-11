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
    //let color, blurHash: String
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
        case width, height//, color
        //case blurHash = "blur_hash"
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
