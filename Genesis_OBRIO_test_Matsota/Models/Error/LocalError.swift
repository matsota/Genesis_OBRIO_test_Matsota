//
//  LocalError.swift
//  Genesis_OBRIO_test_Matsota
//
//  Created by Andrew Matsota on 07.12.2020.
//

import Foundation


enum LocalError: Error {
    case unknown
    case badRequest
    case connectionLost
    case sessionExpired
    
    var localizedDescription: String {
        debugPrint(comment)
        
        switch self {
        case .unknown:
            return "Error unknown"
            
        case .badRequest:
            return "Bad request"

        case .connectionLost:
            return "Server connection lost"
            
        case .sessionExpired:
            return "Your session has expired.\nPlease contact your service provider"
        }
    }
    
    private var comment: String {
        switch self {
        default: return "CUSTOM ERROR: LocalErrors: \(self)"
        }
    }
    
}
