//
//  APIManager.swift
//  RakhiKumari_MachineRound
//
//  Created by Rakhi Kumari on 19/05/25.
//


import Foundation

class APIManager {
    
    static let shared = APIManager()
    
    private init() {}
    
    func apiRequest<T: Decodable>(type: T.Type, url: URL, httpMethodType: MethodType, parameter: [String: Any?], _ completion: @escaping(_ success: Bool, _ myResponse: T?, _ msgString: String?, _ httpStatusCode: Int?) -> ()) {
        
        let finalURL = url
        var urlRequest = URLRequest(url: finalURL)
        urlRequest.httpMethod = httpMethodType.rawValue
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let jsonData = try? JSONSerialization.data(withJSONObject: parameter, options: .prettyPrinted)
        urlRequest.httpBody = jsonData
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            Loader.hide()
            
            if let error = error {
                debugPrint("Error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    Toast.show(message: error.localizedDescription)
                    completion(false, nil, "Error: \(error.localizedDescription)", nil)
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(false, nil, "Something Went Wrong!", nil)
                }
                return
            }
            
            debugPrint("STATUS CODE FOR \(finalURL) : \(httpResponse.statusCode)")
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(false, nil, "No data received", httpResponse.statusCode)
                }
                return
            }
            
            if let responseString = String(data: data, encoding: .utf8) {
                print("Raw API Response: \(responseString)")
            }
            
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                
                // Check both HTTP status and API's status field
                if httpResponse.statusCode == 200 {
                    if let otpResponse = decoded as? OTPVerificationModel {
                        if otpResponse.status == 200 {
                            DispatchQueue.main.async {
                                completion(true, decoded, otpResponse.message, httpResponse.statusCode)
                            }
                        } else {
                            DispatchQueue.main.async {
                                Toast.show(message: otpResponse.message)
                                completion(false, decoded, otpResponse.message, httpResponse.statusCode)
                            }
                        }
                    } else {
                        // For other API calls that don't have the status field
                        DispatchQueue.main.async {
                            completion(true, decoded, "Success", httpResponse.statusCode)
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(false, nil, "HTTP Error: \(httpResponse.statusCode)", httpResponse.statusCode)
                    }
                }
            } catch let decodingError {
                DispatchQueue.main.async {
                    completion(false, nil, "Decoding error: \(decodingError.localizedDescription)", httpResponse.statusCode)
                }
                debugPrint("Decoding Error: \(decodingError)")
            }
        }.resume()
    }
}
