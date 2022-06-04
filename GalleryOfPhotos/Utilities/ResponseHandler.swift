//
//  ResponseHandler.swift
//  GalleryOfPhotos
//
//  Created by rafiul hasan on 4/6/22.
//

import Foundation

class ResponseHandler {
    func fetchModel<T: Codable>(type: T.Type, data: Data, completion: (Result<T, CustomError>) -> Void) {
        let commentResponse = try? JSONDecoder().decode(type.self, from: data)
        if let commentResponse = commentResponse {
            return completion(.success(commentResponse))
        } else {
            completion(.failure(.DecodingError))
        }
    }
}

