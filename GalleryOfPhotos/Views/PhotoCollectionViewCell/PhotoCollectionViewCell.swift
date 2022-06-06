//
//  PhotoCollectionViewCell.swift
//  GalleryOfPhotos
//
//  Created by rafiul hasan on 3/6/22.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoView: UIImageView!
    var representedIdentifier: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var image: UIImage? {
        didSet {
            photoView.image = image
        }
    }
}
