//
//  SignUPViewModel.swift
//  RakhiKumari_MachineRound
//
//  Created by Rakhi Kumari on 22/05/25.
//

import Foundation
import Combine

class SignUPViewModel {
    
    @Published var registeredUserID: Int?
    @Published var errorMessage: String?
    var cancellables: Set<AnyCancellable> = []
    
    func registerNewUserRequest(param: [String: Any]){
        APIManager.shared.apiRequest(type: RegisterResponse.self,
                                     url: APIEndpoints.regiterNew,
                                     httpMethodType: .post,
                                     parameter: param){ success, myResponse, error, httpStatusCode in
            switch success {
            case true:
                if let response = myResponse {
                    self.registeredUserID = response.userID
                }
            case false:
                self.errorMessage = error
            }
        }
    }
    
}
