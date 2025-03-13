//
//  CharacterReequest.swift
//  MarvelList
//
//  Created by Süha Karakaya on 12.03.2025.
//

import Foundation

struct CharactersRequest {
    
    var endPoint: String {
        return "characters"
    }
    
    let limit: Int
    let offset: Int?
    
    public init(limit: Int, offset: Int = 0) {
        self.limit = limit
        self.offset = offset
    }
}
