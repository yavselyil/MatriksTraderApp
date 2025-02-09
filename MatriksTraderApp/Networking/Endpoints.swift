//
//  Endpoints.swift
//  MatriksTraderApp
//
//  Created by Selim Yılmaz on 9.02.2025.
//

import Foundation

enum APIEndpoints {
    case login(username: String, password: String)
    case portfolio(username: String, password: String, accountID: String)
    
    var path: String {
        switch self {
        case .login(let username, let password):
            return "?MsgType=A&CustomerNo=0&Username=\(username)&Password=\(password)&AccountID=0&ExchangeID=4&OutputType=2"
        case .portfolio(let username, let password, let accountID):
            return "?MsgType=AN&CustomerNo=0&Username=\(username)&Password=\(password)&AccountID=\(accountID)&ExchangeID=4&OutputType=2"
        }
    }
}
