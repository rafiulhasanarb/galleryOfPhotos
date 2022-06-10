//
//  SavedPhotoViewController.swift
//  GalleryOfPhotos
//
//  Created by rafiul hasan on 5/6/22.
//

import UIKit
import Photos

class SavedPhotoViewController: UIViewController {

    //MARK: outlets
    @IBOutlet weak var savedPhotoCollectionView: UICollectionView!
    
    //MARK: prperties
    var photo: UIImage?
    var images = [UIImage]()
    
    //MARK: view life cycle
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
        
        self.getPhoto()
    }
    
    //MARK: methods
    fileprivate func getPhoto() {
        let manager = PHImageManager.default()
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = false
        requestOptions.deliveryMode = .highQualityFormat
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        let results: PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        if results.count > 0 {
            for i in 0..<results.count {
                let asset = results.object(at: i)
                let size = CGSize(width: 150, height: 150)
                manager.requestImage(for: asset, targetSize: size, contentMode: .aspectFill, options: requestOptions) { (image, _) in
                    if let image = image {
                        self.images.append(image)
                        self.savedPhotoCollectionView.reloadData()
                    } else {
                        print("error asset to image")
                    }
                }
            }
        } else {
            print("no photos to display")
        }
    }
    
    //MARK: fetch from custom Album
    func fetchCustomAlbumPhotos() {
        let albumName = "Unsplash"
        var assetCollection = PHAssetCollection()
        var albumFound: Bool = false
        var photoAssets = PHFetchResult<AnyObject>()
        let fetchOptions = PHFetchOptions()

        fetchOptions.predicate = NSPredicate(format: "title = %@", albumName)
        let collection:PHFetchResult = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)

        if let firstObject = collection.firstObject {
            assetCollection = firstObject
            albumFound = true
        } else { albumFound = false }
        _ = collection.count
        
        photoAssets = PHAsset.fetchAssets(in: assetCollection, options: nil) as! PHFetchResult<AnyObject>
        let imageManager = PHCachingImageManager()
        photoAssets.enumerateObjects{(object: AnyObject!, count: Int, stop: UnsafeMutablePointer<ObjCBool>) in
            if object is PHAsset {
                let asset = object as! PHAsset
                print("Inside  If object is PHAsset, This is number 1")
                let imageSize = CGSize(width: asset.pixelWidth, height: asset.pixelHeight)

                let options = PHImageRequestOptions()
                options.deliveryMode = .fastFormat
                options.isSynchronous = true

                imageManager.requestImage(for: asset, targetSize: imageSize, contentMode: .aspectFill, options: options, resultHandler: { (image, info) -> Void in
                    self.photo = image!
                    self.addImgToArray(uploadImage: self.photo!)
                    print("enum for image, This is number 2")
                })
            }
        }
    }

    func addImgToArray(uploadImage: UIImage) {
        self.images.append(uploadImage)
    }
}

//MARK: extensions for delegate and datasource
extension SavedPhotoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(images.count)
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.photoCVCell, for: indexPath) as! PhotoCollectionViewCell
        cell.photoView.image = images[indexPath.item]
        return cell
    }
}

//MARK: extensions for delegate
extension SavedPhotoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = (collectionView.frame.size.width - 2) / 3
        if UIDevice.current.orientation.isLandscape {
            size = (collectionView.frame.size.width - 2) / 6
        }
        return CGSize(width: size, height: size)
    }
}
