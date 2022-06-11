//
//  ProfileViewController.swift
//  GalleryOfPhotos
//
//  Created by rafiul hasan on 10/6/22.
//

import UIKit

class ProfileViewController: UIViewController {
    //MARK: outlets
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var namelbl: UILabel!
    @IBOutlet weak var usernamelbl: UILabel!
    @IBOutlet weak var locationlbl: UILabel!
    @IBOutlet weak var totalLikelbl: UILabel!
    @IBOutlet weak var followerlbl: UILabel!
    @IBOutlet weak var followinglbl: UILabel!
    @IBOutlet weak var totalCollectionlbl: UILabel!
    @IBOutlet weak var totalPhotoslbl: UILabel!
    @IBOutlet weak var profileCollectionView: UICollectionView!
    
    //MARK: prperties
    var profileData: ProfileModel?
    var photoList: [Photo] = []
    
    //MARK: view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = UIColor.lightGray.cgColor
        // collectionView registration
        profileCollectionView.dataSource = self
        profileCollectionView.delegate = self
        profileCollectionView.register(UINib(nibName: Constants.photoCVCell, bundle: nil), forCellWithReuseIdentifier: Constants.photoCVCell)
        //MARK: CollectionView layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        profileCollectionView.collectionViewLayout = layout
        profileCollectionView.reloadData()
        
        getProfileData()
    }
    
    private func getProfileData() {
        NetworkManager().fetchRequest(type: ProfileModel.self, url: URL(string: Constants.profileURL)!) { [weak self] photos in
            switch photos {
            case .success(let profileData):
                self!.showSpinner(onView: self!.view)
                DispatchQueue.main.async {
                    self!.namelbl.text = profileData.name
                    self!.usernamelbl.text = profileData.username
                    self!.locationlbl.text = profileData.location
                    self!.totalLikelbl.text = String(profileData.totalLikes)
                    self!.followerlbl.text = String(profileData.followersCount)
                    self!.followinglbl.text = String(profileData.followingCount)
                    self!.totalCollectionlbl.text = String(profileData.totalCollections)
                    self!.totalPhotoslbl.text = String(profileData.totalPhotos)
                    let url = URL(string: profileData.profileImage.large)
                    self!.profileImageView.load(url: url!)
                    for photo in profileData.photos {
                        self!.photoList.append(photo)
                        self!.profileCollectionView.reloadData()
                    }
                    self!.removeSpinner()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

//MARK: extensions for delegate and datasource
extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(photoList.count)
        return photoList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.photoCVCell, for: indexPath) as! PhotoCollectionViewCell
        let url = URL(string: self.photoList[indexPath.item].urls.full)
        cell.photoView.load(url: url!)
        return cell
    }
}

//MARK: extensions for delegate
extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = (collectionView.frame.size.width - 2) / 3
        if UIDevice.current.orientation.isLandscape {
            size = (collectionView.frame.size.width - 2) / 6
        }
        return CGSize(width: size, height: size)
    }
}
