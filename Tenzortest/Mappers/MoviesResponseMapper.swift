//
//  MoviesResponseMapper.swift
//  Tenzortest
//
//  Created by Иван Суслов on 28.05.2021.
//

import Foundation


class MoviesResponseMapper {
    
    private let movieMapper = MovieJsonToMovieMapper()
    
    func map(data: Data?) throws -> MoviesApiResponse {
        let json = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
        let page = json.value(forKey: "page") as! Int
        let total_pages = json.value(forKey: "total_pages") as! Int
        let total_results = json.value(forKey: "total_results") as! Int
        let movies = try (json["results"] as! NSArray).map { try self.movieMapper.map(data: $0 as! NSDictionary) }
        
        return MoviesApiResponse(page: page, movies: movies, total_results: total_results, total_pages: total_pages)
    }
}


class MovieJsonToMovieMapper {
    
    func map(data: NSDictionary) throws -> Movie {
        return Movie(
            adult: data.value(forKey: "adult") as! Bool,
            backdrop_path: data.value(forKey: "backdrop_path") as? String,
            genre_idsarray: (data.value(forKey: "genre_ids") as! NSArray).map { $0 as! Int },
            id: data.value(forKey: "id") as! Int,
            original_language: data.value(forKey: "original_language") as! String,
            original_title: data.value(forKey: "original_title") as! String,
            overview: data.value(forKey: "overview") as! String,
            popularity: data.value(forKey: "popularity") as! Double,
            poster_path: data.value(forKey: "poster_path") as? String,
            release_date: data.value(forKey: "release_date") as! String,
            title: data.value(forKey: "title") as! String,
            video: data.value(forKey: "video") as! Bool,
            vote_average: data.value(forKey: "vote_average") as! Double,
            vote_count: data.value(forKey: "vote_count") as! Int
        )
    }
}
