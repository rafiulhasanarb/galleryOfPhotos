//
//  PhotoListViewController.swift
//  GalleryOfPhotos
//
//  Created by rafiul hasan on 2/6/22.
//

import UIKit

class PhotoListViewController: UIViewController {
    //MARK: Outlets
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    //MARK: Properties
    var photoList: [PhotosResponseModel] = []
    var page = 1
    var totalPage = 346
    var isLoading = false
    var loadingView: LoadingCollectionReusableView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        photoCollectionView.dataSource = self
        photoCollectionView.delegate = self
        photoCollectionView.register(UINib(nibName: Constants.photoCVCell, bundle: nil), forCellWithReuseIdentifier: Constants.photoCVCell)
        //Register Loading Reuseable View
        let loadingReusableNib = UINib(nibName: Constants.loadingReusableView, bundle: nil)
        photoCollectionView.register(loadingReusableNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: Constants.loadingCRV)
        //MARK: CollectionView layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        photoCollectionView.collectionViewLayout = layout
        
        self.getPhotos()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    private func getPhotos() {
        NetworkManager().fetchRequest(type: [PhotosResponseModel].self, url: URL(string: Constants.url+"&page=\(self.page)")!) { [weak self] photos in
            switch photos {
            case .success(let photo):
                self!.showSpinner(onView: self!.view)
                self!.photoList.append(contentsOf: photo)
                DispatchQueue.main.async {
                    self!.photoCollectionView.reloadData()
                    self!.removeSpinner()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension PhotoListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(photoList.count)
        return photoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.photoCVCell, for: indexPath) as! PhotoCollectionViewCell
        
        let photo = self.photoList[indexPath.row]
        cell.image = nil
        let representedIdentifier = photo.id
        cell.representedIdentifier = representedIdentifier
        
        func image(data: Data?) -> UIImage? {
            if let data = data {
                return UIImage(data: data)
            }
            return UIImage(systemName: "photo")
        }
        
        NetworkManager().loadImage(photo: photo) { data, error  in
            let img = image(data: data)
            DispatchQueue.main.async {
                if (cell.representedIdentifier == representedIdentifier) {
                    cell.image = img
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: Constants.photoDetailVC) as! PhotoDetailViewController
        vc.photoDetail = photoList[indexPath.item]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if self.isLoading {
            return CGSize.zero
        } else {
            return CGSize(width: collectionView.bounds.size.width, height: 44)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let aFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constants.loadingCRV, for: indexPath) as! LoadingCollectionReusableView
            loadingView = aFooterView
            loadingView?.backgroundColor = UIColor.clear
            return aFooterView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.loadingView?.activityIndicator.startAnimating()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.loadingView?.activityIndicator.stopAnimating()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if page < totalPage && indexPath.row == photoList.count - 1 {
            self.page += 1
            self.getPhotos()
        }
    }
}

extension PhotoListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = (collectionView.frame.size.width - 2) / 3
        if UIDevice.current.orientation.isLandscape {
            size = (collectionView.frame.size.width - 2) / 6
        }
        return CGSize(width: size, height: size)
    }
}
