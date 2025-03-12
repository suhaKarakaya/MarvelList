//
//  ApiKeys.swift
//  MarvelList
//
//  Created by Süha Karakaya on 11.03.2025.
//

import Foundation

class ApiKeys {
    
    private static func valueForAPIKey(named keyname: String) -> String {
        let filePath = Bundle.main.path(forResource: "keys", ofType: "plist")
        let plist = NSDictionary(contentsOfFile:filePath!)
        let value = plist?.object(forKey: keyname) as! String
        return value
    }
    
    static func getPublicKey() -> String {
        return self.valueForAPIKey(named: "public_key")
    }
    
    static func getPrivateKey() -> String {
        return self.valueForAPIKey(named: "private_key")
    }
    
    static func getBaseURL() -> String {
        return self.valueForAPIKey(named: "base_url")
    }
    
}
