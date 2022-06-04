//
//  NetworkManager.swift
//  GalleryOfPhotos
//
//  Created by rafiul hasan on 3/6/22.
//

import Foundation

class NetworkManager {
    let aPIHandler: APIHandler
    let responseHandler: ResponseHandler
    
    init(aPIHandler: APIHandler = APIHandler(), responseHandler: ResponseHandler = ResponseHandler()) {
        self.aPIHandler = aPIHandler
        self.responseHandler = responseHandler
    }
    
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
}
