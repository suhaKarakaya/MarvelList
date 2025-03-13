//
//  UserDefaultsManager.swift
//  MarvelList
//
//  Created by Süha Karakaya on 13.03.2025.
//

import Foundation

final class UserDefaultsManager {

    static let shared = UserDefaultsManager()

    private let userDefaults: UserDefaults

    private init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    func save<T: Codable>(_ value: T, forKey key: String) {
        do {
            let data = try JSONEncoder().encode(value)
            userDefaults.set(data, forKey: key)
        } catch {
            print("Error saving data to UserDefaults: \(error.localizedDescription)")
        }
    }

    func read<T: Codable>(forKey key: String, as type: T.Type) -> T? {
        guard let data = userDefaults.data(forKey: key) else { return nil }
        do {
            let value = try JSONDecoder().decode(type, from: data)
            return value
        } catch {
            print("Error reading data from UserDefaults: \(error.localizedDescription)")
            return nil
        }
    }

    func delete(forKey key: String) {
        userDefaults.removeObject(forKey: key)
    }

    func contains(key: String) -> Bool {
        return userDefaults.object(forKey: key) != nil
    }
}
