//
//  LoadingCollectionReusableView.swift
//  GalleryOfPhotos
//
//  Created by rafiul hasan on 7/6/22.
//

import UIKit

class LoadingCollectionReusableView: UICollectionReusableView {
    
    //MARK: outlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        activityIndicator.color = UIColor.white
    }    
}
