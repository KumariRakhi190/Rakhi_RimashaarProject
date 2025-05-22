//
//  RegisterModel.swift
//  RakhiKumari_MachineRound
//
//  Created by Rakhi Kumari on 22/05/25.
//

import Foundation

struct RegisterResponse: Codable {
    let status: Int?
    let message: String?
    let userID: Int?
    let code: String?

    enum CodingKeys: String, CodingKey {
        case status
        case message
        case userID = "user_id"
        case code
    }

}
