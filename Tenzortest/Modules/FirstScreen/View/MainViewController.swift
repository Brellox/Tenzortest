//
//  MainViewController.swift
//  Tenzortest
//
//  Created by Иван Суслов on 23.05.2021.
//

import UIKit

class MainViewController: UIViewController, MainViewProtocol, UITableViewDataSource, UITableViewDelegate {
    
    var tableView = UITableView()
    
    var presenter: MainViewPresenterProtocol!
    var urlString = "https://image.tmdb.org/t/p/w500"
    
    override func viewDidLoad() {
        super.viewDidLoad()
       setupTableView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell",for: indexPath) as! MovieCell
        let movie = presenter.movies[indexPath.row]
        cell.titleLabel?.text = movie.original_title
        cell.ratingLabel?.text = String(movie.popularity)
        var tempString = urlString + movie.poster_path!
        cell.poster.load(url: URL(string: tempString)!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let movie = presenter.movies[indexPath.row]
        let detailViewController = ModuleBuilder.createDetailModule(movie: movie)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func success() {
        tableView.reloadData()
        
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "movieCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
      }
}


