//
//  PhotoDetailViewController.swift
//  GalleryOfPhotos
//
//  Created by rafiul hasan on 4/6/22.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    //MARK: Outlets
    @IBOutlet weak var detailImageView: UIImageView!
    
    //MARK: Properties
    var photoDetail: PhotosResponseModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: photoDetail!.urls.full)
        UIImage.loadFrom(url: url!) { image in
            self.detailImageView.image = image
        }
        tabBarController?.tabBar.isHidden = true
    }
    
    //MARK: Save photo action
    @IBAction func savePhoto(_ sender: UIButton) {
        let imageURLString = photoDetail!.links.download
        guard let imageURL = URL(string: imageURLString) else { return }
        self.getDataFromUrl(url: imageURL) { (data, response, error) in
            guard let data = data/*, let jpegData = self.detailImageView.image?.jpegData(compressionQuality: 1) */,let imageFromData = UIImage(data: data) else { return }
            DispatchQueue.main.async() {
                UIImageWriteToSavedPhotosAlbum(imageFromData, nil, nil, nil)
                self.detailImageView.image = imageFromData
                let alert = UIAlertController(title: "Save Photo", message: "Your favorit photo has been saved", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default)
                alert.addAction(okAction)
                self.present(alert, animated: true)
            }
        }
    }
    
    private func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
        }.resume()
    }
    
    //MARK: Share photo action
    @IBAction func shareImageButton(_ sender: UIButton) {
        let imageURLString = photoDetail!.links.download
        guard let imageURL = URL(string: imageURLString) else { return }
        let imageToShare = [ imageURL]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook, UIActivity.ActivityType.postToVimeo, UIActivity.ActivityType.postToFlickr, UIActivity.ActivityType.mail, UIActivity.ActivityType.sharePlay]
        self.present(activityViewController, animated: true, completion: nil)
    }
}
