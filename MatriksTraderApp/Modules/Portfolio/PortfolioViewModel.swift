//
//  PortfolioViewModel.swift
//  MatriksTraderApp
//
//  Created by Selim Yılmaz on 9.02.2025.
//

import Foundation
import Alamofire

protocol PortfolioBusinessLayer {
    var items: [PortfolioItem] { get }
    var numberOfRows: Int { get }
    
    func cellViewModel(for indexPath: IndexPath) -> PortfolioTableViewCell.ViewModel
    func fetchData()
}

final class PortfolioViewModel: PortfolioBusinessLayer {
    private let worker: PortfolioWorking
    weak var view: PortfolioDisplayLayer?
    weak var coordinator: Coordinator?
    var items: [PortfolioItem] = []

    init(worker: PortfolioWorking = PortfolioWorker(),
         view: PortfolioDisplayLayer? = nil,
         coordinator: Coordinator? = nil) {
        self.worker = worker
        self.view = view
        self.coordinator = coordinator
    }
    
    var numberOfRows: Int {
        return items.count + 2 // header + footer cell
    }

    func fetchData() {
        view?.startLoading()
        guard let username = KeychainManager.get(key: BaseConstants.StorageKeys.username),
              let password = KeychainManager.get(key: BaseConstants.StorageKeys.password),
              let accountId = KeychainManager.get(key: BaseConstants.StorageKeys.userAccountId) else {
            return
        }
        worker.fetchData(username: username, password: password, accountId: accountId) { [weak self] result in
            guard let self else { return }
            self.view?.stopLoading()
            switch result {
            case .success(let response):
                self.items = response.items
                DispatchQueue.main.async {
                    self.view?.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func cellViewModel(for indexPath: IndexPath) -> PortfolioTableViewCell.ViewModel {
        if indexPath.row == 0 {
            return PortfolioTableViewCell.ViewModel(cellType: .header)
        } else if indexPath.row == items.count + 1 {
            let totalAmount = items.reduce(0) { $0 + $1.amount }
            return PortfolioTableViewCell.ViewModel(cellType: .footer(total: totalAmount))
        } else {
            let item = items[indexPath.row - 1]
            return PortfolioTableViewCell.ViewModel(
                cellType: .data(symbol: item.symbol,
                                qtyT2: item.qtyT2,
                                lastPx: item.lastPx,
                                amount: item.amount)
            )
        }
    }
}
