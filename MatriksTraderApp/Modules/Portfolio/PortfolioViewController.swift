//
//  PortfoliViewController.swift
//  MatriksTraderApp
//
//  Created by Selim Yılmaz on 9.02.2025.
//

import UIKit
import SnapKit

protocol PortfolioDisplayLayer: AnyObject {
    func reloadData()
    func startLoading()
    func stopLoading()
}

final class PortfolioViewController: BaseViewController, PortfolioDisplayLayer {
    private var viewModel: PortfolioBusinessLayer
    private let tableView = UITableView()
    
    init(viewModel: PortfolioBusinessLayer) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        (viewModel as? PortfolioViewModel)?.view = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.fetchData()
    }
    
    private func setupUI() {
        title = "Portfolio"
        tableView.register(PortfolioTableViewCell.self, forCellReuseIdentifier: "PortfolioCell")
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func startLoading() {
        showLoader()
    }
    
    func stopLoading() {
        hideLoader()
    }
}

extension PortfolioViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PortfolioCell", for: indexPath) as! PortfolioTableViewCell
        let cellViewModel = viewModel.cellViewModel(for: indexPath)
        cell.configure(with: cellViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}
