//
//  Worker.swift
//  MatriksTraderApp
//
//  Created by Selim Yılmaz on 9.02.2025.
//

import Foundation
import Alamofire

protocol LoginWorking {
    func login(username: String, password: String, completion: @escaping (Result<LoginResponse, AFError>) -> Void)
}

final class LoginWorker: LoginWorking {
    func login(username: String, password: String, completion: @escaping (Result<LoginResponse, AFError>) -> Void) {
        let path = APIEndpoints.login(username: username, password: password).path
        NetworkManager.shared.request(path, completion: completion)
    }
}

