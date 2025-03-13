//
//  AuthenticationParams.swift
//  MarvelList
//
//  Created by Süha Karakaya on 11.03.2025.
//

import Foundation


class ListParams: BaseParams {
    
    static func generateParams(_ limit: Int, _ offset: Int?) -> [String: Any] {
        var authDict = generateCommonParams()
        authDict[ParamType.LIMIT.rawValue] = limit
        authDict[ParamType.OFFSET.rawValue] = offset
        
        return authDict
    }
}
