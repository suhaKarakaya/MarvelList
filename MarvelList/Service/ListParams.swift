//
//  AuthenticationParams.swift
//  MarvelList
//
//  Created by Süha Karakaya on 11.03.2025.
//

import Foundation


class ListParams {
    
    public enum ParamType: String {
        case HASH = "hash"
        case TIMESTAMP = "ts"
        case APIKEY = "apikey"
        case LIMIT = "limit"
        case OFFSET = "offset"
    }
    
    static func generateParams(_ limit: Int, _ offset: Int?) -> [String : Any] {
        let ts = String(Date().timeIntervalSince1970)
        let hash = (ts + ApiKeys.getPrivateKey() + ApiKeys.getPublicKey()).md5()


        var authDict = [String : Any]()
        authDict[ParamType.HASH.rawValue] = hash
        authDict[ParamType.TIMESTAMP.rawValue] = ts
        authDict[ParamType.APIKEY.rawValue] = ApiKeys.getPublicKey()
        authDict[ParamType.LIMIT.rawValue] = limit
        authDict[ParamType.OFFSET.rawValue] = offset
        
        return authDict
    }
    
}
