//
//  RequestModel.swift
//  Genesis_OBRIO_test_Matsota
//
//  Created by Andrew Matsota on 07.12.2020.
//

import Foundation


struct RequestModel {
    let method: API
    let params: [String: Any]?
    let request: Requests
    
    enum Requests: String {
        case get = "GET"
    }
    
}
