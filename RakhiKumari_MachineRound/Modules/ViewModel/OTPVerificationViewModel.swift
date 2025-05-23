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
    
    func otpVerificationRequest(param: [String: Any]) {
        APIManager.shared.apiRequest(type: OTPVerificationModel.self,
                                   url: APIEndpoints.verifyOTP,
                                   httpMethodType: .post,
                                   parameter: param) { success, myResponse, error, httpStatusCode in
            DispatchQueue.main.async {
                if success,
                   let response = myResponse,
                   response.status == 200 {
                    // Only proceed if API's status is 200
                    self.isVerificationDone = true
                    self.errorMessage = nil
                } else {
                    // Show error message
                    self.isVerificationDone = false
                    let errorMessage = error ?? (myResponse)?.message ?? "Verification failed"
                    self.errorMessage = errorMessage
                    Toast.show(message: errorMessage)
                }
            }
        }
    }
}
