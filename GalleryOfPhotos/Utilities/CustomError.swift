//
//  CustomError.swift
//  GalleryOfPhotos
//
//  Created by rafiul hasan on 4/6/22.
//

import Foundation

//MARK: custom enum
enum CustomError: Error {
    case BadURL
    case NoData
    case DecodingError
    case badResponse
}
