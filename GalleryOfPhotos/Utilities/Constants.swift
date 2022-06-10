//
//  Constants.swift
//  GalleryOfPhotos
//
//  Created by rafiul hasan on 3/6/22.
//

import Foundation

struct Constants {
    //MARK: APIs Point
    static let baseurl = "https://api.unsplash.com/"
    static let photos = "photos"
    static let clientId = "Vn0osf3lWAHbbe276LeNI2OHPcjQP3mba4MqxtKZEU8"
    static let orderBy = "latest"
    static let perPage = 30
    static let url = "\(Constants.baseurl)\(Constants.photos)?client_id=\(Constants.clientId)&per_page=\(perPage)&order_by=\(Constants.orderBy)"
    
    //MARK: identifiers for Controller
    static let photoDetailVC = "PhotoDetailViewController"
    static let SavedPhotoVC = "SavedPhotoViewController"
    
    //MARK: identifiers for cell
    static let photoCVCell = "PhotoCollectionViewCell"
    static let loadingReusableView = "LoadingCollectionReusableView"
    static let loadingCRV = "loadingCRV"
}
