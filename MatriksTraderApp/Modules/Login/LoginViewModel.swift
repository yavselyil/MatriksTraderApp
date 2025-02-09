//
//  LoginViewModel.swift
//  MatriksTraderApp
//
//  Created by Selim Yılmaz on 9.02.2025.
//

import Foundation
import Alamofire

protocol LoginBusinessLayer {
    var coordinator: Coordinator? { get }
    
    func login(username: String, password: String)
    func push()
}

final class LoginViewModel: LoginBusinessLayer {
    private let worker: LoginWorking
    weak var view: LoginDisplayLayer?
    weak var coordinator: Coordinator?

    init(worker: LoginWorking = LoginWorker(),
         view: LoginDisplayLayer? = nil,
         coordinator: Coordinator? = nil) {
        self.worker = worker
        self.view = view
        self.coordinator = coordinator
    }

    func login(username: String, password: String) {
        worker.login(username: username, password: password) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.handleLoginResult(result, username: username, password: password)
            }
        }
    }
    
    func push() {
        coordinator?.pushToPortfolio()
    }
}

private extension LoginViewModel {
    func handleLoginResult(_ result: Result<LoginResponse, AFError>, username: String, password: String) {
        switch result {
        case .success(let response):
            handleLoginSuccess(response, username: username, password: password)
        case .failure(let error):
            view?.displayLoginFailure(errorMessage: error.localizedDescription)
        }
    }
    
    func handleLoginSuccess(_ response: LoginResponse, username: String, password: String) {
        if response.result.state {
            saveUserCredentials(username: username,
                              password: password,
                              accountId: response.accountList?.first)
            view?.displayLoginSuccess()
        } else {
            view?.displayLoginFailure(errorMessage: response.result.description)
        }
    }
    
    func saveUserCredentials(username: String, password: String, accountId: String?) {
        if let accountId = accountId {
            KeychainManager.save(key: BaseConstants.StorageKeys.userAccountId, value: accountId)
        }
        KeychainManager.save(key: BaseConstants.StorageKeys.username, value: username)
        KeychainManager.save(key: BaseConstants.StorageKeys.password, value: password)
    }
}
