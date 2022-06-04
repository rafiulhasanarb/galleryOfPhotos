//
//  PhotoListViewController.swift
//  GalleryOfPhotos
//
//  Created by rafiul hasan on 2/6/22.
//

import UIKit

class PhotoListViewController: UIViewController {

    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    private let cache = NSCache<NSNumber, UIImage>()
    private let utilityQueue = DispatchQueue.global(qos: .utility)
    
    var photoList: [PhotosResponseModel] = []
    var page = 1
    var totalPage = 100
    //var url = "https://api.unsplash.com/photos?page=1&client_id=Vn0osf3lWAHbbe276LeNI2OHPcjQP3mba4MqxtKZEU8&per_page=100&order_by=latest"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        photoCollectionView.dataSource = self
        photoCollectionView.delegate = self
        photoCollectionView.register(UINib(nibName: Constants.photoCVCell, bundle: nil), forCellWithReuseIdentifier: Constants.photoCVCell)
        //MARK: CollectionView layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        photoCollectionView.collectionViewLayout = layout
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getPhotos()
    }
    
    private func getPhotos() {
        NetworkManager().fetchRequest(type: [PhotosResponseModel].self, url: URL(string: Constants.url)!) { photos in
            switch photos {
            case .success(let photo):
                self.showSpinner(onView: self.view)
                self.photoList.append(contentsOf: photo)
                DispatchQueue.main.async {
                    self.photoCollectionView.reloadData()
                    self.removeSpinner()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension PhotoListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.photoCVCell, for: indexPath) as! PhotoCollectionViewCell
        let url = URL(string: photoList[indexPath.row].urls.raw)
        UIImage.loadFrom(url: url!) { image in
            cell.photoView.image = image
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: Constants.photoDetailVC) as! PhotoDetailViewController
        vc.photoDetail = photoList[indexPath.item]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if page < totalPage && indexPath.row == photoList.count - 1 {
            page += 1
            self.getPhotos()
        }
    }
}

extension PhotoListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width - 2) / 3
        return CGSize(width: size, height: size)
    }
}
