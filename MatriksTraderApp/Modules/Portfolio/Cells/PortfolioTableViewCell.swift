//
//  PortfolioTableViewCell.swift
//  MatriksTraderApp
//
//  Created by Selim Yılmaz on 9.02.2025.
//

import UIKit
import SnapKit

final class PortfolioTableViewCell: UITableViewCell {
    
    struct ViewModel {
        var cellType: CellType
    }
    
    private var viewModel: ViewModel?

    private let symbolLabel = UILabel()
    private let qtyLabel = UILabel()
    private let priceLabel = UILabel()
    private let amountLabel = UILabel()

    enum CellType {
        case header
        case data(symbol: String, qtyT2: Int, lastPx: Double, amount: Double)
        case footer(total: Double)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        let stackView = UIStackView(arrangedSubviews: [symbolLabel, qtyLabel, priceLabel, amountLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 8

        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(BaseConstants.size8)
            make.leading.trailing.equalToSuperview().inset(BaseConstants.size16)
        }
    }

    func configure(with viewModel: ViewModel) {
        self.viewModel = viewModel
        
        switch viewModel.cellType {
        case .header:
            createHeaderCell()
            applyStyle(font: .boldSystemFont(ofSize: 12), textColor: .white, backgroundColor: .systemGreen)
            
        case .data(let symbol, let qtyT2, let lastPx, let amount):
            symbolLabel.text = symbol
            qtyLabel.text = "\(qtyT2)"
            priceLabel.text = String(format: "%.2f", lastPx)
            amountLabel.text = amount.amountString
            
            applyStyle(font: .systemFont(ofSize: 12), textColor: .black, backgroundColor: .white)
            
        case .footer(let total):
            createFooterCell(total: total)
            applyStyle(font: .boldSystemFont(ofSize: 12), textColor: .black, backgroundColor: .systemGray)
        }
    }
}

private extension PortfolioTableViewCell {
    func createHeaderCell() {
        symbolLabel.text = "Menkul"
        qtyLabel.text = "Miktar T2"
        priceLabel.text = "Fiyat"
        amountLabel.text = "Tutar"
    }
    
    func createFooterCell(total: Double) {
        symbolLabel.text = nil
        qtyLabel.text = nil
        priceLabel.text = "Toplam:"
        amountLabel.text = total.amountString
        
        [symbolLabel, qtyLabel].forEach { $0.isHidden = true }
    }
    
    func applyStyle(font: UIFont, textColor: UIColor, backgroundColor: UIColor) {
        [symbolLabel, qtyLabel, priceLabel, amountLabel].forEach {
            $0.font = font
            $0.textColor = textColor
            $0.textAlignment = .center
            $0.isHidden = false
        }
        self.backgroundColor = backgroundColor
    }
}


