//
//  MovieDetailViewController.swift
//  EmefarTMDbDemo
//
//  Created by Emefar on 6.04.2021.
//  Copyright © 2021 Emefar. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    
    private lazy var coverImg: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "placeholder") // For placeholder
        return imageView
    }()
    
    private lazy var releaseLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    private lazy var movieNameLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    private lazy var starImg: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "star")
        return imageView
    }()
    
    private lazy var calendarImg: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "schedule")
        return imageView
    }()
    
    private lazy var starLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var descLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var darkBgView: UIView = {
        let darkBg = UIView()
        darkBg.translatesAutoresizingMaskIntoConstraints = false
        darkBg.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        return darkBg
    }()
    
    
    private lazy var addToWatchlistBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitle("Add To Watchlist", for: .normal)
        button.addTarget(self, action: #selector(addToWatchlist), for: .touchUpInside)
        return button
    }()
    
    
    private lazy var addToFavBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        button.setTitle("Add To Favorites", for: .normal)
        button.addTarget(self, action: #selector(addToFav), for: .touchUpInside)
        return button
    }()
    
    
    var movieItem: Movie? {
        
        didSet {
            
            if let movie = movieItem {
                self.movieNameLbl.text = movie.title ?? ""
                self.starLbl.text = "\(movie.vote_average ?? 0.0)"
                self.descLbl.text = movie.overview ?? ""
                self.releaseLbl.text = movie.release_date ?? ""
                self.coverImg.setImage(urlString: movie.poster_path ?? "")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = movieItem?.title ?? ""
        
        prepareUI()
                
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.tabBarController?.tabBar.isHidden = false
    }
        
    
    @objc func addToFav(){
        
        do {
            let preferencesDirectoryURL = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first!.appendingPathComponent("Preferences", isDirectory: true)
            let fileURL = preferencesDirectoryURL.appendingPathComponent("favorites.json")
            
            if let data = try? Data(contentsOf: fileURL) {
                var decoded = try JSONDecoder().decode([Movie].self, from: data)
                
                for item in decoded {
                    if item.id == movieItem?.id {
                        var style = ToastStyle()
                        style.backgroundColor = .red
                        self.view.makeToast("You are alredy added to favorites!", duration: 1.0, position: .bottom, style: style)
                        return
                    }
                }
                
                do {
                    decoded.append(movieItem!)
                    let encoded = try JSONEncoder().encode(decoded)
                    let preferencesDirectoryURL = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first!.appendingPathComponent("Preferences", isDirectory: true)
                    let fileURL = preferencesDirectoryURL.appendingPathComponent("favorites.json")
                    try encoded.write(to: fileURL)
                    
                    var style = ToastStyle()
                    style.backgroundColor = .systemGreen
                    self.view.makeToast("Successfully added to favorites", duration: 1.0, position: .bottom, style: style)
                } catch { print("err4: ", error) }
                
                
            }else{
                
                do {
                    var currentMovies = [Movie]()
                    currentMovies.append(movieItem!)
                    let encoded = try JSONEncoder().encode(currentMovies)
                    let preferencesDirectoryURL = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first!.appendingPathComponent("Preferences", isDirectory: true)
                    let fileURL = preferencesDirectoryURL.appendingPathComponent("favorites.json")
                    try encoded.write(to: fileURL)
                } catch { print("err1: ", error) }
                
                
            }
        } catch { print("err2: ", error) }
        
        
        
    }
    
    @objc func addToWatchlist(){
        
        do {
            let preferencesDirectoryURL = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first!.appendingPathComponent("Preferences", isDirectory: true)
            let fileURL = preferencesDirectoryURL.appendingPathComponent("watchlist.json")
            
            if let data = try? Data(contentsOf: fileURL) {
                var decoded = try JSONDecoder().decode([Movie].self, from: data)
                
                for item in decoded {
                    if item.id == movieItem?.id {
                        var style = ToastStyle()
                        style.backgroundColor = .red
                        self.view.makeToast("You are alredy added to watchlist!", duration: 1.0, position: .bottom, style: style)
                        return
                    }
                }
                
                do {
                    decoded.append(movieItem!)
                    let encoded = try JSONEncoder().encode(decoded)
                    let preferencesDirectoryURL = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first!.appendingPathComponent("Preferences", isDirectory: true)
                    let fileURL = preferencesDirectoryURL.appendingPathComponent("watchlist.json")
                    try encoded.write(to: fileURL)
                    
                    var style = ToastStyle()
                    style.backgroundColor = .systemGreen
                    self.view.makeToast("Successfully added to watchlist", duration: 1.0, position: .bottom, style: style)
                } catch { print("err4: ", error) }
                
                
            }else{
                
                do {
                    var currentMovies = [Movie]()
                    currentMovies.append(movieItem!)
                    let encoded = try JSONEncoder().encode(currentMovies)
                    let preferencesDirectoryURL = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first!.appendingPathComponent("Preferences", isDirectory: true)
                    let fileURL = preferencesDirectoryURL.appendingPathComponent("watchlist.json")
                    try encoded.write(to: fileURL)
                } catch { print("err1: ", error) }
                
                
            }
        } catch { print("err2: ", error) }
        
    }
    
    
    func prepareUI(){
        self.view.backgroundColor = .systemGray2
        self.view.addSubview(coverImg)
        self.coverImg.addSubview(darkBgView)
        
        NSLayoutConstraint.activate([
            coverImg.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            coverImg.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0.0),
            coverImg.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0.0),
            coverImg.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0)
        ])
        
        self.coverImg.addSubview(calendarImg)
        NSLayoutConstraint.activate([
            calendarImg.trailingAnchor.constraint(equalTo: self.coverImg.trailingAnchor, constant: -10.0),
            calendarImg.bottomAnchor.constraint(equalTo: self.coverImg.bottomAnchor, constant: -5.0),
            calendarImg.heightAnchor.constraint(equalToConstant: 15.0),
            calendarImg.widthAnchor.constraint(equalToConstant: 15.0)
        ])
        
        
        self.coverImg.addSubview(releaseLbl)
        NSLayoutConstraint.activate([
            releaseLbl.trailingAnchor.constraint(equalTo: self.calendarImg.leadingAnchor, constant: -10.0),
            releaseLbl.bottomAnchor.constraint(equalTo: self.coverImg.bottomAnchor, constant: -5.0),
            releaseLbl.centerYAnchor.constraint(equalTo: self.calendarImg.centerYAnchor, constant: 0.0)
            
        ])
        
        self.coverImg.addSubview(starImg)
        NSLayoutConstraint.activate([
            starImg.leadingAnchor.constraint(equalTo: self.coverImg.leadingAnchor, constant: 10.0),
            starImg.bottomAnchor.constraint(equalTo: self.coverImg.bottomAnchor, constant: -5.0),
            starImg.heightAnchor.constraint(equalToConstant: 15.0),
            starImg.widthAnchor.constraint(equalToConstant: 15.0)
        ])
        
        
        self.coverImg.addSubview(starLbl)
        NSLayoutConstraint.activate([
            starLbl.leadingAnchor.constraint(equalTo: self.starImg.trailingAnchor, constant: 10.0),
            starLbl.centerYAnchor.constraint(equalTo: self.starImg.centerYAnchor, constant: 0.0)
        ])
        
        
        self.coverImg.addSubview(movieNameLbl)
        NSLayoutConstraint.activate([
            movieNameLbl.leadingAnchor.constraint(equalTo: self.coverImg.leadingAnchor, constant: 10.0),
            movieNameLbl.bottomAnchor.constraint(equalTo: self.starImg.topAnchor, constant: -5.0)
        ])
        
        NSLayoutConstraint.activate([
            darkBgView.leadingAnchor.constraint(equalTo: self.coverImg.leadingAnchor, constant: 0.0),
            darkBgView.trailingAnchor.constraint(equalTo: self.coverImg.trailingAnchor, constant: 0.0),
            darkBgView.topAnchor.constraint(equalTo: self.movieNameLbl.topAnchor, constant: -7.0),
            darkBgView.bottomAnchor.constraint(equalTo: self.coverImg.bottomAnchor, constant: 0.0)
        ])
        
        self.view.addSubview(descLbl)
        NSLayoutConstraint.activate([
            descLbl.leadingAnchor.constraint(equalTo: self.coverImg.leadingAnchor, constant: 10.0),
            descLbl.trailingAnchor.constraint(equalTo: self.coverImg.trailingAnchor, constant: -10.0),
            descLbl.topAnchor.constraint(equalTo: self.coverImg.bottomAnchor, constant: 10.0)
        ])
        
        
        
        self.view.addSubview(addToFavBtn)
        NSLayoutConstraint.activate([
            addToFavBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            addToFavBtn.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
            addToFavBtn.heightAnchor.constraint(equalToConstant: 75.0),
            addToFavBtn.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5)
        ])
        
        self.view.addSubview(addToWatchlistBtn)
        NSLayoutConstraint.activate([
            addToWatchlistBtn.leadingAnchor.constraint(equalTo: self.addToFavBtn.trailingAnchor, constant: 0),
            addToWatchlistBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            addToWatchlistBtn.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
            addToWatchlistBtn.heightAnchor.constraint(equalToConstant: 75.0)
        ])
        
        
        
    }
    
    
}
