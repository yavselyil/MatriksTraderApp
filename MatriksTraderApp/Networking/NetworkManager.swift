//
//  NetworkManager.swift
//  MatriksTraderApp
//
//  Created by Selim Yılmaz on 9.02.2025.
//

import Alamofire
import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://tbpilot.matriksdata.com/9999/Integration.aspx"

    private init() {}

    func request<T: Decodable>(_ endpoint: String, completion: @escaping (Result<T, AFError>) -> Void) {
        let fullURL = "\(baseURL)\(endpoint)"
        AF.request(fullURL)
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}

