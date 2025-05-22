//
//  APIEndpoints.swift
//  RakhiKumari_MachineRound
//
//  Created by Rakhi Kumari on 19/05/25.
//


import Foundation

class APIEndpoints{
    
//    https://admin-cp.rimashaar.com/api/v1/register-new?lang=en
//    https://admin-cp.rimashaar.com/api/v1/verify-code?lang=en
    
    private static let baseUrl = URL(string: "https://admin-cp.rimashaar.com/api/v1/")!
    static let regiterNew = baseUrl.appendingPathComponent("register-new")
    static let verifyOTP = baseUrl.appendingPathComponent("verify-code")
}
