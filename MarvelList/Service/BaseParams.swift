//
//  BaseParams.swift
//  MarvelList
//
//  Created by Süha Karakaya on 13.03.2025.
//

import Foundation

class BaseParams {
    
    public enum ParamType: String {
        case HASH = "hash"
        case TIMESTAMP = "ts"
        case APIKEY = "apikey"
        case LIMIT = "limit"
        case OFFSET = "offset"
        case ORDERBY = "orderBy"
        case STARTYEAR = "startYear"
    }
    
    static func generateCommonParams() -> [String: Any] {
        let ts = String(Date().timeIntervalSince1970)
        let hash = (ts + ApiKeys.getPrivateKey() + ApiKeys.getPublicKey()).md5()
        
        var authDict = [String: Any]()
        authDict[ParamType.HASH.rawValue] = hash
        authDict[ParamType.TIMESTAMP.rawValue] = ts
        authDict[ParamType.APIKEY.rawValue] = ApiKeys.getPublicKey()
        
        return authDict
    }
}
