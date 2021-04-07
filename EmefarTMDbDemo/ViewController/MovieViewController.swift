//
//  MovieViewController.swift
//  EmefarTMDbDemo
//
//  Created by Emefar on 6.04.2021.


import UIKit

class MovieViewController: UIViewController {
    
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar:UISearchBar = UISearchBar()
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = "Search a movie"
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.delegate = self
        return searchBar
    }()
    
    private lazy var refresh : UIRefreshControl = {
        let r = UIRefreshControl()
        r.addTarget(self, action: #selector(refreshRequest), for: .valueChanged)
        return r
    }()
    
    
    let viewModel = MovieViewModel()
    private var pendingRequestWorkItem: DispatchWorkItem?
    var isNewDataLoading = false
    var currentPage = 1
    var currentSearchText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        prepareSearchBar()
        prepareTableView()
        prepareViewModelObserver()
        
    }
    
    @objc func refreshRequest() {
        currentPage = 1
        isNewDataLoading = false
        viewModel.searchMovie(searchText: currentSearchText, page: "\(currentPage)")
    }
    
    
    func prepareSearchBar(){
        
        self.view.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 15.0),
            searchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0.0),
            searchBar.heightAnchor.constraint(equalToConstant: 45.0),
            searchBar.widthAnchor.constraint(equalTo: self.view.widthAnchor)
        ])
        
    }
    
    
    func prepareTableView() {
        self.view.backgroundColor = .white
        //self.tableView.separatorStyle = .none
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.setEmptyMessage("Please search a movie")
        tableView.refreshControl = refresh
        self.tableView.register(UINib(nibName: "MovieViewCell", bundle: nil), forCellReuseIdentifier: "MovieViewCell")
        
        self.view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor, constant: 0.0),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0.0),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0.0),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0.0),
        ])
        
    }
    
    func prepareViewModelObserver() {
        self.viewModel.movieDidChanges = { (finished, error) in
            if !error {
                if self.refresh.isRefreshing { self.refresh.endRefreshing() }
                self.tableView.reloadData()
                self.isNewDataLoading = false
            }
        }
    }
    

}

extension MovieViewController: UISearchBarDelegate {
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Emefar: ", searchText)
        
        currentSearchText = searchText
        currentPage = 1 // If type anything, reset currentPage
        
        pendingRequestWorkItem?.cancel()
        
        let requestWorkItem = DispatchWorkItem { [weak self] in
            self?.viewModel.searchMovie(searchText: searchText, page: "\(self?.currentPage ?? 1)")
        }
        
        
        pendingRequestWorkItem = requestWorkItem
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000),
                                      execute: requestWorkItem)
        
    }
}


extension MovieViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       guard let cell: MovieViewCell = tableView.dequeueReusableCell(withIdentifier: "MovieViewCell", for: indexPath as IndexPath) as? MovieViewCell else {
            fatalError("MovieViewCell cell is not found")
        }
        
        cell.movieItem = viewModel.movies[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.estimatedRowHeight = 160
        tableView.rowHeight = UITableView.automaticDimension
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let lastElement = viewModel.movies.count - 1
        if !isNewDataLoading && indexPath.row == lastElement {
            print("Emefar Load More")
            isNewDataLoading = true
            currentPage += 1
            viewModel.searchMovie(searchText: currentSearchText, page: "\(currentPage)")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let vc = MovieDetailViewController()
        vc.movieItem = self.viewModel.movies[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    
}
