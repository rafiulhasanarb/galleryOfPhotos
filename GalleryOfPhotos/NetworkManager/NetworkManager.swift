//
//  NetworkManager.swift
//  GalleryOfPhotos
//
//  Created by rafiul hasan on 3/6/22.
//

import Foundation
import UIKit

class NetworkManager {
    //MARK: objects
    let aPIHandler: APIHandler
    let responseHandler: ResponseHandler
    //MARK: Cache Images
    private var images = NSCache<NSString, NSData>()
    
    //MARK: initialization
    init(aPIHandler: APIHandler = APIHandler(), responseHandler: ResponseHandler = ResponseHandler()) {
        self.aPIHandler = aPIHandler
        self.responseHandler = responseHandler
    }
    
    //MARK: Parsing method
    func fetchRequest<T: Codable>(type: T.Type, url: URL, completion: @escaping(Result<T, CustomError>) -> Void) {
        aPIHandler.fetchData(url: url) { result in
            switch result {
            case .success(let data):
                self.responseHandler.fetchModel(type: type, data: data) { decodedResult in
                    switch decodedResult {
                    case .success(let model):
                        DispatchQueue.main.async {
                            completion(.success(model))
                        }
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchProfile<T: Codable>(type: T.Type, url: URL, completion: @escaping(Result<T, CustomError>) -> Void) {
        aPIHandler.fetchData(url: url) { result in
            switch result {
            case .success(let data):
                self.responseHandler.fetchModel(type: type, data: data) { decodedResult in
                    switch decodedResult {
                    case .success(let model):
                        DispatchQueue.main.async {
                            completion(.success(model))
                        }
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    //MARK: Cache method
    func loadImage(photo: PhotosResponseModel, completion: @escaping (Data?, Error?) -> (Void)) {
        let url = URL(string: photo.urls.small)!
        download(imageURL: url, completion: completion)
    }
    
    private func download(imageURL: URL, completion: @escaping (Data?, Error?) -> (Void)) {
        if let imageData = images.object(forKey: imageURL.absoluteString as NSString) {
            completion(imageData as Data, nil)
            return
        }
        
        let task = URLSession.shared.downloadTask(with: imageURL) { localUrl, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(nil, CustomError.badResponse)
                return
            }
            
            guard let localUrl = localUrl else {
                completion(nil, CustomError.BadURL)
                return
            }
            
            do {
                let data = try Data(contentsOf: localUrl)
                self.images.setObject(data as NSData, forKey: imageURL.absoluteString as NSString)
                completion(data, nil)
            } catch let error {
                completion(nil, error)
            }
        }
        task.resume()
    }
}
