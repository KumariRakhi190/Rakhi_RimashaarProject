//
//  ValidationManager.swift
//  RakhiKumari_MachineRound
//
//  Created by Rakhi Kumari on 22/05/25.
//


import Foundation

struct ValidationManager {

    static func validateFirstName(_ name: String) -> String? {
        return name.trimmingCharacters(in: .whitespaces).isEmpty ? "Please enter first name" : nil
    }

    static func validateLastName(_ name: String) -> String? {
        return name.trimmingCharacters(in: .whitespaces).isEmpty ? "Please enter last name" : nil
    }

    static func validateContactInput(_ input: String) -> String? {
        let trimmed = input.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed.isEmpty {
            return "Please enter phone number or email"
        }

        if isValidEmail(trimmed) || isValidPhone(trimmed) {
            return nil
        } else {
            return "Please enter a valid email or phone number"
        }
    }

    static func validatePassword(_ password: String) -> String? {
        return password.trimmingCharacters(in: .whitespaces).isEmpty ? "Please enter password" : nil
    }

    // MARK: - Private helpers
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return NSPredicate(format:"SELF MATCHES %@", emailRegEx).evaluate(with: email)
    }

    static func isValidPhone(_ phone: String) -> Bool {
        let phoneRegex = #"^[0-9]{7,15}$"#
        return NSPredicate(format: "SELF MATCHES %@", phoneRegex).evaluate(with: phone)
    }
    
    static func validateOTPAndReturnDict(otpFields: [String?]) -> (isValid: Bool, message: String?, dict: String?) {
        let trimmedOTPs = otpFields.compactMap { $0?.trimmed() }
        guard trimmedOTPs.count == otpFields.count, !trimmedOTPs.isEmpty else {
            return (false, "Please enter the complete OTP.", nil)
        }
        let otp = trimmedOTPs.joined()
        if otp.count != 5 {
            return (false, "Please enter a 5-digit OTP.", nil)
        }
        if !otp.allSatisfy({ $0.isNumber }) {
            return (false, "OTP must contain only numeric digits.", nil)
        }
        let finalOtp = otp
        return (true, nil, finalOtp)
    }
}
