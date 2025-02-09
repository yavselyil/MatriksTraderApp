//
//  LoginResponse.swift
//  MatriksTraderApp
//
//  Created by Selim Yılmaz on 9.02.2025.
//

struct LoginResponse: Decodable {
    let result: ResultData
    let accountList: [String]?
    let defaultAccount: String?
    let customerID: String?
    let userRights: [UserRight]?

    enum CodingKeys: String, CodingKey {
        case result = "Result"
        case accountList = "AccountList"
        case defaultAccount = "DefaultAccount"
        case customerID = "CustomerID"
        case userRights = "UserRights"
    }
}

struct ResultData: Decodable {
    let state: Bool
    let code: Int
    let description: String
    let sessionKey: String
    let duration: Int
    let msgType: String
    let timestamp: String?
    let clordID: String?

    enum CodingKeys: String, CodingKey {
        case state = "State"
        case code = "Code"
        case description = "Description"
        case sessionKey = "SessionKey"
        case duration = "Duration"
        case msgType = "MsgType"
        case timestamp = "Timestamp"
        case clordID = "ClordID"
    }
}

struct UserRight: Decodable {
    let code: String
    let key: String
    let value: String
    let timestamp: Int

    enum CodingKeys: String, CodingKey {
        case code = "Code"
        case key = "Key"
        case value = "Value"
        case timestamp = "Timestamp"
    }
}
