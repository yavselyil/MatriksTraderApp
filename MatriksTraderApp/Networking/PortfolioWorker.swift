//
//  PortfolioWorker.swift
//  MatriksTraderApp
//
//  Created by Selim Yılmaz on 9.02.2025.
//

import Foundation
import Alamofire

protocol PortfolioWorking {
    func fetchData(username: String, password: String, accountId: String, completion: @escaping (Result<PortfolioResponse, AFError>) -> Void)
}

final class PortfolioWorker: PortfolioWorking {
    func fetchData(username: String,
                   password: String,
                   accountId: String,
                   completion: @escaping (Result<PortfolioResponse, AFError>) -> Void) {
        let path = APIEndpoints.portfolio(username: username, password: password, accountID: accountId).path
        NetworkManager.shared.request(path, completion: completion)
    }
}
