//
//  DetailParams.swift
//  MarvelList
//
//  Created by Süha Karakaya on 12.03.2025.
//

import Foundation

class DetailParams {
    
    public enum ParamType: String {
        case HASH = "hash"
        case TIMESTAMP = "ts"
        case APIKEY = "apikey"
        case LIMIT = "limit"
        case ORDERBY = "orderBy"
        case STARTYEAR = "startYear"
    }
    

    
    static func generateParams(_ limit: Int, _ orderBy: String?, _ startYear: Int?) -> [String : Any] {
        let ts = String(Date().timeIntervalSince1970)
        let hash = (ts + ApiKeys.getPrivateKey() + ApiKeys.getPublicKey()).md5()


        var authDict = [String : Any]()
        authDict[ParamType.HASH.rawValue] = hash
        authDict[ParamType.TIMESTAMP.rawValue] = ts
        authDict[ParamType.APIKEY.rawValue] = ApiKeys.getPublicKey()
        authDict[ParamType.LIMIT.rawValue] = limit
        authDict[ParamType.ORDERBY.rawValue] = orderBy
        authDict[ParamType.STARTYEAR.rawValue] = startYear
        
        return authDict
    }
    
}
