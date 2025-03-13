//
//  MarvelListTests.swift
//  MarvelListTests
//
//  Created by Süha Karakaya on 12.03.2025.
//

import XCTest
import RxSwift
@testable import MarvelList

class CharacterListViewControllerTests: XCTestCase {
    
    var viewController: CharacterListViewController!
    var mockMarvelService: MockMarvelService!
    var window: UIWindow!
    
    override func setUp() {
        super.setUp()
        window = UIWindow()
        let storyboard = UIStoryboard(name: "CharacterList", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "CharacterListViewController") as? CharacterListViewController
        mockMarvelService = MockMarvelService()
        viewController.marvelService = mockMarvelService
        window.addSubview(viewController.view)
        RunLoop.current.run(until: Date())
    }
    
    override func tearDown() {
        viewController = nil
        mockMarvelService = nil
        window = nil
        super.tearDown()
    }
    
    func testGetList() {
        
//        viewController.getList()
        
        XCTAssertEqual(viewController.tableViewList.count, 1)
        XCTAssertEqual(viewController.tableViewList.first?.name, "Spider-Man")
    }
}

class MockMarvelService: MarvelServiceProtocol {
    func fetchCharacters(_ request: CharactersRequest, overlayTarget: UIView?) -> Observable<MarvelBaseResponse<ResultCharacter>> {
        
        let mockResponse = MarvelBaseResponse(
            code: 200,
            status: "Ok",
            copyright: "© 2025 MARVEL",
            attributionText: "Data provided by Marvel. © 2025 MARVEL",
            attributionHTML: nil,
            etag: "mockEtag",
            data: MarvelData(
                offset: 0,
                limit: 30,
                total: 1,
                count: 1,
                results: [
                    ResultCharacter(
                        id: 1,
                        name: "Spider-Man",
                        description: "Friendly neighborhood Spider-Man.",
                        thumbnail: nil
                    )
                ]
            )
        )
        
        return Observable.just(mockResponse)
    }
    
    func fetchComics(_ req: MarvelList.ComicsRequest, overlayTarget: UIView?) -> RxSwift.Observable<MarvelList.MarvelBaseResponse<MarvelList.ResultComic>> {
        
        let mockResponse = MarvelBaseResponse(
            code: 200,
            status: "Ok",
            copyright: "© 2025 MARVEL",
            attributionText: "Data provided by Marvel. © 2025 MARVEL",
            attributionHTML: nil,
            etag: "mockEtag",
            data: MarvelData(
                offset: 0,
                limit: 30,
                total: 1,
                count: 1,
                results: [ResultComic(
                   title: "deneme"
                )]
            )
        )
        
        return Observable.just(mockResponse)
    }
    
    func loadImage(from url: String) -> RxSwift.Observable<UIImage?> {
        return Observable.just(nil)
    }
    
    var charactersResponse: MarvelBaseResponse<ResultCharacter>!
    
    
}
