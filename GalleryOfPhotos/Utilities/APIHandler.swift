//
//  APIHandler.swift
//  GalleryOfPhotos
//
//  Created by rafiul hasan on 4/6/22.
//

import Foundation

class APIHandler {
    func fetchData(url: URL, completion: @escaping(Result<Data, CustomError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.NoData))
            }
            completion(.success(data))
        }.resume()
    }
}
