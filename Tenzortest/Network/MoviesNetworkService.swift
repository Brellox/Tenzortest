//
//  File.swift
//  Tenzortest
//
//  Created by Иван Суслов on 27.05.2021.
//

import Foundation


class MoviesQueryParams: QueryParams {
    let genre: Int
    let page: Int
    
    init(genre: Int, page: Int) {
        self.genre = genre
        self.page = page
    }
}


struct MoviesApiResponse: ApiResponse {
    let page: Int
    let movies: [Movie]
    let total_results: Int
    let total_pages: Int
}


class MoviesNetworkService: NetworkProtocol {
    
    private let mapper = MoviesResponseMapper()
    
    let query = "https://api.themoviedb.org/3/discover/movie?api_key=%@&language=en-US&sort_by=popularity.desc&include_video=false&with_watch_monetization_types=free&with_genres=%d&page=%d"
    
    func makeQuery(params: QueryParams, completion: @escaping (Result<ApiResponse, Error>) -> Void) {
        if let queryParams = params as? MoviesQueryParams {
            guard let url = URL(string: String.init(format: query, getApiKey(), queryParams.genre, queryParams.page)) else { return }
            
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
            //completion(.failure(Failure("Invalid query params instance")))
        }
    }
}
