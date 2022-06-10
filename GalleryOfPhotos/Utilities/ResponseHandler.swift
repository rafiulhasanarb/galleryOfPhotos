//
//  ResponseHandler.swift
//  GalleryOfPhotos
//
//  Created by rafiul hasan on 4/6/22.
//

import Foundation

class ResponseHandler {
    //MARK: Response handler method
    func fetchModel<T: Codable>(type: T.Type, data: Data, completion: (Result<T, CustomError>) -> Void) {
        let photoResponse = try? JSONDecoder().decode(type.self, from: data)
        if let photoResponse = photoResponse {
            return completion(.success(photoResponse))
        } else {
            completion(.failure(.DecodingError))
        }
    }
}

