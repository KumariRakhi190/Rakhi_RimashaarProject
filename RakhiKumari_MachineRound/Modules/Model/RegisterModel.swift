//
//  RegisterModel.swift
//  RakhiKumari_MachineRound
//
//  Created by Rakhi Kumari on 22/05/25.
//

import Foundation

struct RegisterResponse: Decodable {
    let status: Int?
    let message: String?
    let responseData: ResponseData?

    enum CodingKeys: String, CodingKey {
        case status
        case message
        case responseData = "data"
    }

}

struct ResponseData: Decodable{
    let id: Int?
}
