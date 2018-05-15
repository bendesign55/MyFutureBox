//
//  APIClient.swift
//  MyFutureBox
//
//  Created by Ben Ormos on 23/04/2018.
//  Copyright © 2018 com.benormos. All rights reserved.
//

import Foundation
import KeychainSwift
import AdSupport

class APIClient {
    
    private let keychain = KeychainSwift()
    
    var session = URLSession.shared
    
    enum HTTPMethod: String {
        case GET
        case PUT
        case POST
        case DEL
    }
    
    
    func loginUser(_ username: String, password: String, completion: @escaping (Data?, Error?) -> Void) {
        makeRequest(.POST,
                    url: URLManager.loginURL(),
                    params: ["Email": username as AnyObject,
                             "Password": password as AnyObject,
                             "Idfa": ASIdentifierManager.shared().advertisingIdentifier.uuidString as AnyObject],
                    headers: Header.header(.unauthenticated),
                    onSuccess: { (jsonData) in
            completion(jsonData, nil)
        }) { (error) in
            completion(nil, error)
        }
    }
    
    func fetchWeeklyInfo(_ completion: @escaping (Data?, Error?) -> Void) {
        makeRequest(.POST,
                    url: URLManager.offpaymentsURL(),
                    params: nil,
                    headers: Header.header(.tokenJson),
                    onSuccess: { (jsonData) in
                        completion(jsonData, nil)
        }) { (error) in
            completion(nil, error)
        }
    }
    
    func addAmountToProduct(_ productId: Int, completion: @escaping (Data?, Error?) -> Void) {
        makeRequest(.POST,
                    url: URLManager.offpaymentsURL(),
                    params: ["Amount": 10 as AnyObject,
                             "InvestorProductId": productId as AnyObject],
                    headers: Header.header(.tokenJson),
                    onSuccess: { (jsonData) in
            completion(jsonData, nil)
        }) { (error) in
            completion(nil, error)
        }
    }
    
    func logoutUser(completion: @escaping (Data?, Error?) -> Void) {
        makeRequest(.POST,
                    url: URLManager.logoutURL(),
                    params: nil,
                    headers: Header.header(.tokenJson),
                    onSuccess: { (jsonData) in
            completion(jsonData, nil)
        }) { (error) in
            completion(nil, error)
        }
    }
    
    fileprivate func makeRequest(_ method: HTTPMethod,
                                 url: String,
                                 params: [String: AnyObject]?,
                                 headers: [String: String]?,
                                 onSuccess: @escaping(_ jsonData: Data) -> Void,
                                 onError: @escaping(_ error: Error?) -> Void) {
        
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        if params != nil {
            let jsonData = try? JSONSerialization.data(withJSONObject: params as Any)
            request.httpBody = jsonData
        }
        
        session.dataTask(with: request) { (data, response, err) in
            if err == nil {
                if let data = data, let response = response as? HTTPURLResponse {
                    if 200...299 ~= response.statusCode {
                        onSuccess(data)
                    } else {
                        let errorTemp = NSError(domain:"", code:response.statusCode, userInfo:nil)
                        onError(errorTemp)
                    }
                }
            } else {
                onError(err)
            }
            
        }.resume()
        
    }
    
}
