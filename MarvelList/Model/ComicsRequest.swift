//
//  ComicsRequest.swift
//  MarvelList
//
//  Created by Süha Karakaya on 12.03.2025.
//

import Foundation

struct ComicsRequest {
    
    var endPoint: String {
        return String(format: "%@%@", characterId, "comics")
    }
    
    let limit: Int
    let orderBy: String?
    let startYear: Int?
    let characterId: String
    
    public init(limit: Int, orderBy: String = "", startYear: Int = 0, characterId: Int?) {
        self.limit = limit
        self.orderBy = orderBy
        self.startYear = startYear
        self.characterId = String(format: "%@%@/", "characters/", String(characterId ?? 0))
    }
}

