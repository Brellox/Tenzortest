//
//  DetaleViewController.swift
//  Tenzortest
//
//  Created by Иван Суслов on 24.05.2021.
//

import UIKit

class DetailViewController: UIViewController, DetailViewProtocol, UITableViewDataSource, UITableViewDelegate  {

    var tableView = UITableView()
    
    var presenter: DetailViewPresenterProtocol!
    var urlString = "https://image.tmdb.org/t/p/w500"
   
    
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "posterCell",for: indexPath) as! PosterCell
            urlString.append(presenter.movie.poster_path!)
            cell.poster.load(url: URL(string: urlString)!)
            return cell
            
        } else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell",for: indexPath) as! InfoCell
            cell.infoLabel.text = presenter.movie.title
            return cell
        } else if indexPath.row == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell",for: indexPath) as! InfoCell
            cell.infoLabel.text = String(presenter.movie.popularity)
            return cell
        } else if indexPath.row == 3{
            let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell",for: indexPath) as! InfoCell
            cell.infoLabel.text = presenter.crew.first(where: {$0.job == "Director"})?.name
            return cell
        } else if indexPath.row == 4{
            let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell",for: indexPath) as! InfoCell
            cell.infoLabel.text = presenter.cast.first?.name
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell",for: indexPath) as! InfoCell
            cell.infoLabel.text = presenter.movie.overview
            return cell
        }
        
    }

    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
    
    func success() {
        tableView.reloadData()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.register(UINib(nibName: "InfoCell", bundle: nil), forCellReuseIdentifier: "infoCell")
        tableView.register(UINib(nibName: "PosterCell", bundle: nil), forCellReuseIdentifier: "posterCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
      }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
