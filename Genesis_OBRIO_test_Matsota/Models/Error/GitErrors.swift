//
//  GitError.swift
//  Genesis_OBRIO_test_Matsota
//
//  Created by Andrew Matsota on 07.12.2020.
//

import Foundation


struct GitError: Decodable {
    let message: String
    
    let errors: [String: String]?
}
