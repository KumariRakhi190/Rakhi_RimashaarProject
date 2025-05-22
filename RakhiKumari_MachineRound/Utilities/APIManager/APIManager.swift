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
        var finalURL = url
        
        var urlRequest = URLRequest(url: finalURL)
        
        urlRequest.httpMethod = httpMethodType.rawValue
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let jsonData = try? JSONSerialization.data(withJSONObject: parameter, options: .prettyPrinted)
        urlRequest.httpBody = jsonData

        
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
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
            if (200...209).contains(httpResponse.statusCode) {
                do {
                    let decoded = try JSONDecoder().decode(T.self, from: data!)
                    DispatchQueue.main.async {
                        completion(true, decoded, "Success", httpResponse.statusCode)
                    }
                } catch let decodingError {
                    DispatchQueue.main.async {
                        completion(false, nil, "Decoding error", httpResponse.statusCode)
                    }
                    debugPrint("Decoding Error: \(decodingError)")
                }
            } else {
                DispatchQueue.main.async {
                    let failureMessage = "Failure: Status code \(httpResponse.statusCode)"
                    Toast.show(message: failureMessage)
                    completion(false, nil, failureMessage, httpResponse.statusCode)
                }
            }
        }).resume()
    }
}
