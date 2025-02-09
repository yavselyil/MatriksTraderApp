//
//  PortfolioResponse.swift
//  MatriksTraderApp
//
//  Created by Selim Yılmaz on 9.02.2025.
//

import Foundation

struct PortfolioResponse: Decodable {
    let items: [PortfolioItem]
    
    enum CodingKeys: String, CodingKey {
        case items = "Item"
    }
}

struct PortfolioItem: Decodable {
    let symbol: String
    let qtyT2: Int
    let lastPx: Double
    
    var amount: Double {
        return Double(qtyT2) * lastPx
    }
    
    enum CodingKeys: String, CodingKey {
        case symbol = "Symbol"
        case qtyT2 = "Qty_T2"
        case lastPx = "LastPx"
    }
}

