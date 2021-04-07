//
//  WatchlistViewController.swift
//  EmefarTMDbDemo
//
//  Created by Emefar on 6.04.2021.
//  Copyright © 2021 Emefar. All rights reserved.
//

import UIKit

class WatchlistViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    

    let viewModel = WatchlistViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
                
        prepareTableView()
        prepareViewModelObserver()
     //   viewModel.getWatchlist()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        viewModel.getWatchlist()

    }
    
    func prepareViewModelObserver() {
        self.viewModel.movieDidChanges = { (finished, error) in
            if !error {
                self.tableView.reloadData()
            }
        }
    }
  
    func prepareTableView() {
        self.view.backgroundColor = .white
        self.tableView.separatorStyle = .none
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "BaseItemCell", bundle: nil), forCellReuseIdentifier: "BaseItemCell")
        
        self.view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0.0),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0.0),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0.0),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0.0),
        ])
        
    }
    
    
    
}

extension WatchlistViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell: BaseItemCell = tableView.dequeueReusableCell(withIdentifier: "BaseItemCell", for: indexPath as IndexPath) as? BaseItemCell else {
             fatalError("BaseItemCell cell is not found")
         }
        
        cell.movieItem = viewModel.movies[indexPath.row]
         
         
         return cell
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { (action, view, completion) in
            
            let deleteAction = UIAlertAction(title: "Yes", style: .default) { (_) in
                self.viewModel.removeIndex(index: indexPath.row)
            }
            self.cancelableBasicAlert(title: "Are you sure?", text: (self.viewModel.movies[indexPath.row].title ?? "Your item") + " will be remove your watchlist.", alert: deleteAction)
            
        }
        
        deleteAction.backgroundColor = .systemRed
        
        return UISwipeActionsConfiguration(actions: [deleteAction])

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       // tableView.estimatedRowHeight = 160
       // tableView.rowHeight = UITableView.automaticDimension
        return 125
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let vc = MovieDetailViewController()
        vc.movieItem = self.viewModel.movies[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
 
    }
    
    
}
