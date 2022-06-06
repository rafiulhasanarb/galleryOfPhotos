//
//  SavedPhotoViewController.swift
//  GalleryOfPhotos
//
//  Created by rafiul hasan on 5/6/22.
//

import UIKit

class SavedPhotoViewController: UIViewController {

    @IBOutlet weak var savedPhotoCollectionView: UICollectionView!
    
    var savedPhotoList: [PhotosResponseModel] = []
    var savedPhotos = [DownloadedImageModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        savedPhotoCollectionView.dataSource = self
        savedPhotoCollectionView.delegate = self
        savedPhotoCollectionView.register(UINib(nibName: Constants.photoCVCell, bundle: nil), forCellWithReuseIdentifier: Constants.photoCVCell)
        //MARK: CollectionView layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        savedPhotoCollectionView.collectionViewLayout = layout
        savedPhotoCollectionView.reloadData()
        
        self.getPhotos()
    }
    
    func getPhotos() {
        let photo = [String: String]()
        var photoDir = DownloadedImageModel(info: photo)
        let directoryURL = getDocumentsDirectory()
        let imageURL = URL(string: photoDir.url ?? "")
        let imagePath = directoryURL.appendingPathComponent("photo/\(String(describing: imageURL?.lastPathComponent))")
        
        if FileManager().fileExists(atPath: "\(imagePath)") {
            photoDir.image = UIImage(contentsOfFile: "\(imagePath)")
            print(photoDir.url!)
        }
    }

    func getDocumentsDirectory() -> URL {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        return directoryURL!
    }
}

extension SavedPhotoViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(savedPhotos.count)
        return savedPhotos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.photoCVCell, for: indexPath) as! PhotoCollectionViewCell
        let url = URL(string: savedPhotos[indexPath.row].url!)
        UIImage.loadFrom(url: url!) { image in
            cell.photoView.image = image
        }
        return cell
    }
}

extension SavedPhotoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = (collectionView.frame.size.width - 2) / 3
        if UIDevice.current.orientation.isLandscape {
            size = (collectionView.frame.size.width - 2) / 6
        }
        return CGSize(width: size, height: size)
    }
}
