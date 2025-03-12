//
//  NetworkManager.swift
//  MarvelList
//
//  Created by Süha Karakaya on 11.03.2025.
//

import Alamofire
import RxSwift
import Foundation
import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
       
    private init() {}
    
    func request<T: Decodable>(url: String, parameters: [String: Any]? = nil, overlayTarget: UIView? = nil) -> Observable<T> {
        return Observable.create { observer in
            
            if let overlayTarget = overlayTarget {
                DispatchQueue.main.async {
                    LoadingIndicatorView.show(overlayTarget)
                }
            }
            
            
            AF.request(url, parameters: parameters, encoding: URLEncoding.default)
                .validate()
                .responseDecodable(of: T.self) { response in
                    
                    if overlayTarget != nil {
                        DispatchQueue.main.async {
                            LoadingIndicatorView.hide()
                        }
                    }
                    
                    switch response.result {
                    case .success(let value):
                        observer.onNext(value)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
            
            return Disposables.create()
        }
    }
}
