//
//  LoginViewModel.swift
//  EmefarTMDbDemo
//
//  Created by Mervan Şahinkaya on 15.03.2022.
//  Copyright © 2022 Mervan Şahinkaya. All rights reserved.
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
            loginResponse?(true)
        }else{
            loginResponse?(false)
        }
        
    }
    
    

    
}
