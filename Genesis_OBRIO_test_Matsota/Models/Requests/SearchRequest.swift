//
//  SearchRequest.swift
//  Genesis_OBRIO_test_Matsota
//
//  Created by Andrew Matsota on 07.12.2020.
//

import Foundation

struct SearchRequest {
    var text: String
    let page: Int
    
    enum Keys: String {
        case text = "q"
        case page = "page"
    }
    
    var parameters: [String: Any] {
        return [Keys.text.rawValue: text,
                Keys.page.rawValue: page]
    }
    
}
