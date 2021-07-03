//
//  MainPresenter.swift
//  Tenzortest
//
//  Created by Иван Суслов on 22.05.2021.
//

import Foundation

protocol MainViewProtocol:class {
    func success()
    func failure(error: Error)
}

protocol MainViewPresenterProtocol:class {
    init(view: MainViewProtocol, network: NetworkProtocol)
    func getMovies()
    var movies: [Movie] {get set}
    
}

class MainPresenter: MainViewPresenterProtocol {
    weak var view: MainViewProtocol?
    let network:NetworkProtocol!
    var movies: [Movie] = []

    required init(view: MainViewProtocol, network:NetworkProtocol) {
        self.view = view
        self.network = network
        getMovies()
    }
    
    func getMovies() {
        network.makeQuery(params: MoviesQueryParams(genre: 12, page: 1)) {[weak self] result in
            guard let self = self else {return}
            DispatchQueue.main.async {
                switch result {
                case .success(let apiResponse):
                        self.movies = (apiResponse as? MoviesApiResponse)?.movies ?? []
                        self.view?.success()
                    case .failure(let error):
                        self.view?.failure(error: error)
                    }
            }
        }
    }
}
