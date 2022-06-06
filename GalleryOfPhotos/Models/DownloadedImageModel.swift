//
//  DownloadedImageModel.swift
//  GalleryOfPhotos
//
//  Created by rafiul hasan on 6/6/22.
//

import Foundation
import UIKit

struct DownloadedImageModel: Codable {
    var name: String?
    var url: String?
    var image: UIImage?
    
    enum CodingKeys: String, CodingKey {
        case name, url
    }
    
    init(info: [String: String]) {
        self.name = info["name"]
        self.url = info["url"]
    }
}
