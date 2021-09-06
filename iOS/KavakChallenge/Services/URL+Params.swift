//
//  URL+Params.swift
//  KavakChallenge
//
//  Created by Juan Tocino on 19/08/2021.
//

import Foundation
import Alamofire

extension URL {
    
  func params() -> [String:Any] {
    
    var dict = [String:Any]()

    if let components = URLComponents(url: self, resolvingAgainstBaseURL: false) {
      if let queryItems = components.queryItems {
        for item in queryItems {
          dict[item.name] = item.value!
        }
      }
      return dict
    } else {
      return [:]
    }
  }
    
}

extension URLRequest {
    
    static func buildRequest(httpMethod: String = HTTPMethod.post.rawValue, url: URL, json: Data? = nil, headers: [String:String]) -> URLRequest {
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        
        for item in headers {
            request.setValue(item.value, forHTTPHeaderField: item.key)
        }
        
        if json != nil {
            let jsonString = String(data: json!, encoding: .utf8)!
            let jsonData = jsonString.data(using: .utf8, allowLossyConversion: false)!
            request.httpBody = jsonData
        }
        
        return request
    }
}


