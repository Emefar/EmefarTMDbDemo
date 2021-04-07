//
//  LoginViewController.swift
//  EmefarTMDbDemo
//
//  Created by Emefar on 6.04.2021.
//  Copyright © 2021 Emefar. All rights reserved.
//

import UIKit
import Lottie

class LoginViewController: UIViewController {
    
    private lazy var animation = AnimationView()

    private lazy var topImg: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "director") // 128x128
        return imageView
    }()
    
    
    private lazy var topImgLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "The Movie Manager"
        label.font = .boldSystemFont(ofSize: 27.0)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private lazy var bottomLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "This product uses to TMDb API but is not endorsed or certified by TMDb."
        label.font = .systemFont(ofSize: 16.0)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    
    private lazy var middleView: UIView = {
        let middleView = UIView()
        middleView.translatesAutoresizingMaskIntoConstraints = false
        return middleView
    }()
    
    
    private lazy var loginEmailLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Login with email"
        label.font = .systemFont(ofSize: 16.0)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private lazy var emailTF: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "Email"
        textfield.keyboardType = .emailAddress
        textfield.textColor = .white
        textfield.tintColor = .blue
        textfield.autocapitalizationType = .none
        textfield.backgroundColor = UIColor.blue.withAlphaComponent(0.3)
        textfield.layer.cornerRadius = 5.0
        
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 35))
        textfield.leftView = paddingView
        textfield.leftViewMode = .always
        
        return textfield
    }()
    
    private lazy var passwordTF: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "Password"
        textfield.textColor = .white
        textfield.tintColor = .blue
        textfield.backgroundColor = UIColor.blue.withAlphaComponent(0.3)
        textfield.layer.cornerRadius = 5.0
        textfield.isSecureTextEntry = true
        
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 35))
        textfield.leftView = paddingView
        textfield.leftViewMode = .always
        
        return textfield
    }()
    
    private lazy var loginBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.blue
        button.layer.cornerRadius = 5.0
        button.setTitle("Login", for: .normal)
        button.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var orLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "OR"
        label.font = .systemFont(ofSize: 16.0)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    
    private lazy var loginViaWebBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.blue
        button.layer.cornerRadius = 5.0
        button.setTitle("Login via Website", for: .normal)
        button.addTarget(self, action: #selector(loginViaWebAction), for: .touchUpInside)
        return button
    }()
    
    
    @objc func loginAction() {
        
        if emailTF.text!.isEmail {
            
            animation.showLoading(onView: self.view)
            
            // For show loading indicator
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000), execute: {
                self.viewModel.login(email: self.emailTF.text!, password: self.passwordTF.text!)
            })

        } else {
            var style = ToastStyle()
            style.backgroundColor = .red
            self.view.makeToast("Email format is not valid", duration: 1.5, position: .bottom, style: style)
        }
        
    }
    
    @objc func loginViaWebAction() {
        self.view.makeToast("Coming Soon")
    }
    
    let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareViewModelObserver()
        prepareUI()
        
    }
    
    func prepareViewModelObserver() {
        self.viewModel.loginResponse = { (result) in
            
            self.animation.stopAnimation()
            if result {
                var style = ToastStyle()
                style.backgroundColor = .green
                self.view.makeToast("Success!", duration: 1.0, position: .bottom, style: style)
                Caches.setCacheBool(key: "isUserLoggedIn", value: true)
                
                let vc = TabbarViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
                
            }else{
                var style = ToastStyle()
                style.backgroundColor = .red
                self.view.makeToast("Check your credentials!", duration: 1.5, position: .bottom, style: style)
            }
        }
    }
    
    
    func prepareUI(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1).cgColor, #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1).cgColor]
        gradientLayer.shouldRasterize = true
        self.view.layer.addSublayer(gradientLayer)
        
        
        self.view.addSubview(topImg)
        NSLayoutConstraint.activate([
            topImg.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 15),
            topImg.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            topImg.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.3),
            topImg.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.3)
            
        ])
        
        self.view.addSubview(topImgLbl)
        NSLayoutConstraint.activate([
            topImgLbl.topAnchor.constraint(equalTo: topImg.bottomAnchor, constant: 10),
            topImgLbl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        
        
        self.view.addSubview(middleView)
        NSLayoutConstraint.activate([
            middleView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            middleView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            middleView.heightAnchor.constraint(equalToConstant: 210.0),
            middleView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9)
        ])
        
        
        self.middleView.addSubview(loginEmailLbl)
        NSLayoutConstraint.activate([
            loginEmailLbl.centerXAnchor.constraint(equalTo: self.middleView.centerXAnchor)
        ])
        
        self.middleView.addSubview(emailTF)
        NSLayoutConstraint.activate([
            emailTF.leadingAnchor.constraint(equalTo: self.middleView.leadingAnchor),
            emailTF.trailingAnchor.constraint(equalTo: self.middleView.trailingAnchor),
            emailTF.topAnchor.constraint(equalTo: self.loginEmailLbl.bottomAnchor, constant: 5.0),
            emailTF.heightAnchor.constraint(equalToConstant: 35.0)
        ])
        
        self.middleView.addSubview(passwordTF)
        NSLayoutConstraint.activate([
            passwordTF.leadingAnchor.constraint(equalTo: self.middleView.leadingAnchor),
            passwordTF.trailingAnchor.constraint(equalTo: self.middleView.trailingAnchor),
            passwordTF.topAnchor.constraint(equalTo: self.emailTF.bottomAnchor, constant: 5.0),
            passwordTF.heightAnchor.constraint(equalToConstant: 35.0)
        ])
        
        
        self.middleView.addSubview(loginBtn)
        NSLayoutConstraint.activate([
            loginBtn.leadingAnchor.constraint(equalTo: self.middleView.leadingAnchor),
            loginBtn.trailingAnchor.constraint(equalTo: self.middleView.trailingAnchor),
            loginBtn.topAnchor.constraint(equalTo: self.passwordTF.bottomAnchor, constant: 5.0),
            loginBtn.heightAnchor.constraint(equalToConstant: 35.0)
        ])
        
        
        self.middleView.addSubview(orLbl)
        NSLayoutConstraint.activate([
            orLbl.leadingAnchor.constraint(equalTo: self.middleView.leadingAnchor),
            orLbl.trailingAnchor.constraint(equalTo: self.middleView.trailingAnchor),
            orLbl.topAnchor.constraint(equalTo: self.loginBtn.bottomAnchor, constant: 5.0),
            orLbl.heightAnchor.constraint(equalToConstant: 35.0)
        ])
        
        
        self.middleView.addSubview(loginViaWebBtn)
        NSLayoutConstraint.activate([
            loginViaWebBtn.leadingAnchor.constraint(equalTo: self.middleView.leadingAnchor),
            loginViaWebBtn.trailingAnchor.constraint(equalTo: self.middleView.trailingAnchor),
            loginViaWebBtn.topAnchor.constraint(equalTo: self.orLbl.bottomAnchor, constant: 5.0),
            loginViaWebBtn.heightAnchor.constraint(equalToConstant: 35.0)
        ])
        
        
        self.view.addSubview(bottomLbl)
        NSLayoutConstraint.activate([
            bottomLbl.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            bottomLbl.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10.0),
            bottomLbl.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10.0),
            
        ])
        
        
        
    }
    

    
    
    
    
}
