//
//  ApiResponse.swift
//  Tenzortest
//
//  Created by Иван Суслов on 27.05.2021.
//

import Foundation

struct MoviesApiResponse: ApiResponse {
    var page: Int
    var movies: [Movie]
    var total_results: Int
    var total_pages: Int
}
