//
//  Utilities.swift
//  RakhiKumari_MachineRound
//
//  Created by Rakhi Kumari on 19/05/25.
//


import Foundation

class Utilities {
    
    static func convertToStringDict(_ dict: [String: Any?]) -> [String: String] {
        var newDict = [String: String]()
        for (key, value) in dict {
            if let value {
                newDict[key] = "\(value)"
            }
        }
        return newDict
    }
    
    
}
