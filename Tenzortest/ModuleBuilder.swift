//
//  ModuleBuilder.swift
//  Tenzortest
//
//  Created by Иван Суслов on 23.05.2021.
//

import UIKit

protocol Builder {
    static func createMainModule()->UIViewController
    static func createDetailModule(movie:Movie)->UIViewController
}

class ModuleBuilder: Builder {
    static func createMainModule() -> UIViewController {
        let view = MainViewController()
        let network = MoviesNetworkService()
        let presenter = MainPresenter(view: view, network: network)
        view.presenter = presenter
        return view
    }
    
    static func createDetailModule(movie:Movie)->UIViewController{
        let view = DetailViewController()
        let network = DetailsNetworkService()
        let presenter = DetailPresenter(view: view, network: network, movie: movie)
        view.presenter = presenter
        return view
    }
}
