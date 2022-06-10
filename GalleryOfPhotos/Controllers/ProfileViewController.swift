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
    @IBOutlet weak var locationlbl: UILabel!
    @IBOutlet weak var totalLikelbl: UILabel!
    @IBOutlet weak var totalPhotoslbl: UILabel!
    @IBOutlet weak var usernamelbl: UILabel!
    
    //MARK: prperties
    var profileData: ProfileModel?
    
    //MARK: view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        getProfileData()
    }
    
    private func getProfileData() {
        NetworkManager().fetchRequest(type: User.self, url: URL(string: Constants.profileURL)!) { [weak self] photos in
            switch photos {
            case .success(let profileData):
                self!.showSpinner(onView: self!.view)
                DispatchQueue.main.async {
                    self!.namelbl.text = profileData.name
                    self!.usernamelbl.text = profileData.username
                    self!.totalLikelbl.text = profileData.location
                    self!.totalLikelbl.text = String(profileData.totalLikes)
                    self!.totalPhotoslbl.text = String(profileData.totalPhotos)
                    let url = URL(string: profileData.profileImage.large)
                    self!.profileImageView.load(url: url!)
                    self!.removeSpinner()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
