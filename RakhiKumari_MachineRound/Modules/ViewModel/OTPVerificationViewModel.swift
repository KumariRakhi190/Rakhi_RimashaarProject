//
//  OTPVerificationViewModel.swift
//  RakhiKumari_MachineRound
//
//  Created by Rakhi Kumari on 22/05/25.
//

import Foundation
import Combine

class OTPVerificationViewModel {
    
    @Published var isVerificationDone: Bool = false
    @Published var errorMessage: String?
    var cancellables: Set<AnyCancellable> = []
    
    func otpVerificationRequest(param: [String: Any]){
        APIManager.shared.apiRequest(type: OTPVerificationModel.self,
                                     url: APIEndpoints.verifyOTP,
                                     httpMethodType: .post,
                                     parameter: param){ success, myResponse, error, httpStatusCode in
            switch success {
            case true:
                if let response = myResponse {
                    self.isVerificationDone = true
                }
            case false:
                self.errorMessage = error
            }
        }
    }
    
}

