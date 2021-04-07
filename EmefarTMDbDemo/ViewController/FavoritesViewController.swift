//
//  FavoritesViewController.swift
//  EmefarTMDbDemo
//
//  Created by Emefar on 6.04.2021.
//  Copyright © 2021 Emefar. All rights reserved.
//

import UIKit
import Lottie

class FavoritesViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    private lazy var logoutBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.red
        button.layer.cornerRadius = 5.0
        button.setTitle("Logout", for: .normal)
        button.addTarget(self, action: #selector(logoutAction), for: .touchUpInside)
        return button
    }()
    


    private lazy var animation = AnimationView()

    let viewModel = FavoritesViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
                
        prepareUI()
        prepareViewModelObserver()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        viewModel.getWatchlist()

    }
    
    @objc func logoutAction() {
        
        
        let action = UIAlertAction(title: "Yes", style: .default) { (_) in
            self.animation.showLoading(onView: self.view)
            
            // For show loading indicator.
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                self.animation.stopAnimation()
                Caches.setCacheBool(key: "isUserLoggedIn", value: false)
                
                let vc = LoginViewController()
                
                vc.modalPresentationStyle = .fullScreen
                vc.modalTransitionStyle = .crossDissolve
                
                self.present(vc, animated: true, completion: nil)
              
            })
            
        }
        
        self.cancelableBasicAlert(title: "Are you sure want to logout?", text: "", alert: action)
   

    }
 
    func prepareViewModelObserver() {
        self.viewModel.movieDidChanges = { (finished, error) in
            if !error {
                self.tableView.reloadData()
            }
        }
    }
  
    func prepareUI() {
        self.view.backgroundColor = .white
        self.tableView.separatorStyle = .none
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "BaseItemCell", bundle: nil), forCellReuseIdentifier: "BaseItemCell")
        

        self.view.addSubview(logoutBtn)

        NSLayoutConstraint.activate([
            logoutBtn.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0.0),
            logoutBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            logoutBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            logoutBtn.heightAnchor.constraint(equalToConstant: 45.0)
        ])
        
        
        self.view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0.0),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0.0),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0.0),
            tableView.bottomAnchor.constraint(equalTo: self.logoutBtn.topAnchor, constant: 0),
        ])
 
    }
    
    
    
}

extension FavoritesViewController:UITableViewDelegate,UITableViewDataSource{
    
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
            self.cancelableBasicAlert(title: "Are you sure?", text: (self.viewModel.movies[indexPath.row].title ?? "Your item") + " will be remove your favorites.", alert: deleteAction)
            
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
