//
//  LoginViewModel.swift
//  EmefarTMDbDemo
//
//  Created by Emefar on 6.04.2021.
//  Copyright © 2021 Emefar. All rights reserved.
//

import UIKit

protocol LoginViewModelProtocol {
    var loginResponse: ((Bool) -> Void)? { get set }
    func login(email: String, password: String)

}

class LoginViewModel: LoginViewModelProtocol {
    var loginResponse: ((Bool) -> Void)?
    
    func login(email: String, password: String) { // Normal şartlar altında burası API'ye bağlanması lazım. Fakat şuan aktif API yok.
        
        if (email == "mervan@gmail.com" && password == "123456"){
            loginResponse!(true)
        }else{
            loginResponse!(false)
        }
        
    }
    
    

    
}
