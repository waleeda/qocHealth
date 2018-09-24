//
//  WebService.swift
//  qocHealthAssesment
//
//  Created by Waleed Azhar on 2018-09-24.
//  Copyright © 2018 Waleed Azhar. All rights reserved.
//

import Foundation

enum WebServiceEndPoints: String {
    case appList = "http://phobos.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/toppaidapplications/limit=100/json"
}

extension URL {
    
    init?(endpoint: WebServiceEndPoints) {
        self.init(string: endpoint.rawValue)
    }
    
}

extension URLRequest {
    
    init?(endPoint: WebServiceEndPoints) {
        guard let url = URL(endpoint: endPoint) else { return nil }
        self.init(url: url )
        self.httpMethod = "GET"
    }
    
}


enum DecodingError: Error {
    case decoding(String)
}


final class WebService {
    
    let decoder = JSONDecoder()
    
    func get<A: Codable>(endPoint: WebServiceEndPoints, callBack: @escaping  ( A?, Error? ) -> Void ) {
        
        guard let request = URLRequest(endPoint: endPoint) else { return }
 
        URLSession.shared.dataTask(with: request) { (dataOptional, _, errorOptional) in
            
            guard let data = dataOptional else {
                DispatchQueue.main.async { callBack( nil, errorOptional! ) }
                return
            }
            
            if let model = try? self.decoder.decode( A.self , from: data ) {
                
                DispatchQueue.main.async { callBack(model , nil) }
            }
            else {
                DispatchQueue.main.async { callBack( nil, DecodingError.decoding( "Cannot Decode" ) ) }
            }
            
        }.resume()
            
    }
    
}
