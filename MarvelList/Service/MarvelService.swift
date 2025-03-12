//
//  MarvelService.swift
//  MarvelList
//
//  Created by Süha Karakaya on 11.03.2025.
//

import RxSwift
import Foundation
import RxAlamofire
import UIKit

protocol MarvelServiceProtocol {
    func fetchCharacters(_ req: CharactersRequest, overlayTarget: UIView?) -> Observable<MarvelBaseResponse<ResultCharacter>>
    func fetchComics(_ req: ComicsRequest, overlayTarget: UIView?) -> Observable<MarvelBaseResponse<ResultComic>>
    func loadImage(from url: String) -> Observable<UIImage>
}


class MarvelService: MarvelServiceProtocol {
    
    private let networkManager = NetworkManager.shared
    
    private let imageCache = NSCache<NSString, UIImage>()
    private let unknownImage = UIImage(named: "unknown")
    
    func fetchCharacters(_ req: CharactersRequest, overlayTarget: UIView?) -> Observable<MarvelBaseResponse<ResultCharacter>> {
        return networkManager.request(url: String(format: "%@%@", ApiKeys.getBaseURL(), req.endPoint),
                                      parameters: ListParams.generateParams(req.limit, req.offset),
                                      overlayTarget: overlayTarget)
    }
    
    func fetchComics(_ req: ComicsRequest, overlayTarget: UIView? = nil) -> Observable<MarvelBaseResponse<ResultComic>> {
        return networkManager.request(url: String(format: "%@%@", ApiKeys.getBaseURL(), req.endPoint),
                                      parameters: DetailParams.generateParams(req.limit, req.orderBy, req.startYear),
                                      overlayTarget: overlayTarget)
        
    }
    
    func loadImage(from url: String) -> Observable<UIImage> {
            guard let imageURL = URL(string: url) else {
                return Observable.just(unknownImage ?? UIImage())
            }
            
            if let cachedImage = imageCache.object(forKey: url as NSString) {
                return Observable.just(cachedImage)
            }
            
            return RxAlamofire.data(.get, imageURL)
                .map { data in
                    guard let image = UIImage(data: data) else {
                        throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Görsel verisi geçersiz"])
                    }
                    
                    self.imageCache.setObject(image, forKey: url as NSString)
                    return image
                }
                .catch { error in
                    return Observable.just(self.unknownImage ?? UIImage())
                }
        }
}
