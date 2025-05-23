//
//  OTPVerificationModel.swift
//  RakhiKumari_MachineRound
//
//  Created by Rakhi Kumari on 22/05/25.
//

import Foundation

struct OTPVerificationModel: Decodable {
    let success: Bool
    let status: Int  // This is the actual status from the API
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case success, status, message
    }
    
}
