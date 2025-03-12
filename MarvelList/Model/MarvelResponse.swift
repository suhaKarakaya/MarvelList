//
//  MarvelResponse.swift
//  MarvelList
//
//  Created by Süha Karakaya on 11.03.2025.
//

import Foundation

// MARK: - MarvelBaseResponse
struct MarvelBaseResponse<T: Codable>: Codable {
    let code: Int?
    let status, copyright, attributionText, attributionHTML: String?
    let etag: String?
    let data: MarvelData<T>?
}

// MARK: - MarvelData
struct MarvelData<T: Codable>: Codable {
    let offset, limit, total, count: Int?
    let results: [T]?
}

// MARK: - Result
struct ResultCharacter: Codable {
    let id: Int?
    let name, description: String?
    let thumbnail: Thumbnail?
}

struct ResultComic: Codable {
    let title: String?
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let url: String
    enum ImageKeys: String, CodingKey {
        case path = "path"
        case fileExtension = "extension"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ImageKeys.self)
        let path = try container.decode(String.self, forKey: .path)
        let fileExtension = try container.decode(String.self, forKey: .fileExtension)
        self.url = String(format: "%@.%@", path, fileExtension)
    }
}

