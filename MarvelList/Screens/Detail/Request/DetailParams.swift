//
//  DetailParams.swift
//  MarvelList
//
//  Created by Süha Karakaya on 12.03.2025.
//

import Foundation

class DetailParams: BaseParams {
    
    static func generateParams(_ limit: Int, _ orderBy: String?, _ startYear: Int?) -> [String: Any] {
        var authDict = generateCommonParams()
        authDict[ParamType.LIMIT.rawValue] = limit
        authDict[ParamType.ORDERBY.rawValue] = orderBy
        authDict[ParamType.STARTYEAR.rawValue] = startYear
        
        return authDict
    }
}
