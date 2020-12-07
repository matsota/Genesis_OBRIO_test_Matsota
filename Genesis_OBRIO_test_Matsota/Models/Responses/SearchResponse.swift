//
//  SearchResponse.swift
//  Genesis_OBRIO_test_Matsota
//
//  Created by Andrew Matsota on 07.12.2020.
//

import Foundation


struct SearchResponse: Decodable {
    let total_count: Int
    let items: [Item]
    
    struct Item: Decodable {
        let id: Int
        let name: String
        let `private`: Bool
        let description: String?
        let html_url: String
        let owner: Owner

        struct Owner: Decodable {
            let id: Int
            let login: String
            let avatar_url: String
        }
    }
}
