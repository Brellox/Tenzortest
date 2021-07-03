//
//  DetailsNetworkService.swift
//  Tenzortest
//
//  Created by Иван Суслов on 31.05.2021.
//

import Foundation

class DetailsQueryParams: QueryParams {
    let id: Int
    
    init(id: Int) {
        self.id = id
    }
}


struct DetailsApiResponse: ApiResponse {
    let id: Int
    let cast: [Cast]
    let crew: [Crew]
}


class DetailsNetworkService: NetworkProtocol {
    
    private let mapper = DetailsResponseMapper()
    
    
    let query = "https://api.themoviedb.org/3/movie/%d/credits?api_key=%@&language=en-US"
    
    func makeQuery(params: QueryParams, completion: @escaping (Result<ApiResponse, Error>) -> Void) {
        if let queryParams = params as? DetailsQueryParams {
            guard let url = URL(string: String.init(format: query, queryParams.id, getApiKey())) else { return }
            
            URLSession.shared.dataTask(with: url) {data, _, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                do {
                    let result = try self.mapper.map(data: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        } else {
           // completion(.failure(failure("Invalid query params instance")))
        }
    }
}
