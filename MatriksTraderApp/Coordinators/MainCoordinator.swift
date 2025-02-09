//
//  MainCoordinator.swift
//  MatriksTraderApp
//
//  Created by Selim Yılmaz on 9.02.2025.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    
    func start()
    func pushToPortfolio()
}

final class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = LoginViewModel(worker: LoginWorker(), coordinator: self)
        let controller = LoginViewController(viewModel: viewModel)
        
        navigationController.viewControllers = [controller]
    }
    
    func pushToPortfolio() {
        let viewModel = PortfolioViewModel(coordinator: self)
        let controller = PortfolioViewController(viewModel: viewModel)
        controller.navigationItem.hidesBackButton = true
        navigationController.pushViewController(controller, animated: false)
    }
}
