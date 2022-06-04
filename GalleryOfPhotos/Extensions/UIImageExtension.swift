//
//  UIImageExtension.swift
//  GalleryOfPhotos
//
//  Created by rafiul hasan on 4/6/22.
//

import Foundation
import UIKit

extension UIImage {
    //MARK: Image loading method
    public static func loadFrom(url: URL, completion: @escaping (_ image: UIImage?) -> ()) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    completion(UIImage(data: data))
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
}
