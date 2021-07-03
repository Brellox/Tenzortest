//
//  DetailPresenter.swift
//  Tenzortest
//
//  Created by Иван Суслов on 24.05.2021.
//

import Foundation

protocol DetailViewProtocol: class {
    func success()
    func failure(error: Error)
   // func setDetails(movie:Movie, crew: [Crew], cast: [Cast])
}

protocol DetailViewPresenterProtocol {
    init(view: DetailViewProtocol, network: NetworkProtocol, movie: Movie)
  //  func setDetails()
    var movie: Movie {get set}
    var cast: [Cast] {get set}
    var crew: [Crew] {get set}
}

class DetailPresenter: DetailViewPresenterProtocol {
    
    weak var view: DetailViewProtocol?
    let network:NetworkProtocol!
    var movie: Movie
    var cast: [Cast] = []
    var crew: [Crew] = []
    
    required init(view: DetailViewProtocol, network: NetworkProtocol, movie: Movie) {
        self.view = view
        self.network = network
        self.movie = movie
        getDetails()
    }
    
    
    func getDetails() {
        network.makeQuery(params: DetailsQueryParams(id: self.movie.id)) {[weak self] result in
            guard let self = self else {return}
            DispatchQueue.main.async {
                switch result {
                case .success(let apiResponse):
                        self.cast = (apiResponse as? DetailsApiResponse)?.cast ?? []
                        self.crew = (apiResponse as? DetailsApiResponse)?.crew ?? []
                        self.view?.success()
                    case .failure(let error):
                        self.view?.failure(error: error)
                    }
    
}
        }
    }
}
