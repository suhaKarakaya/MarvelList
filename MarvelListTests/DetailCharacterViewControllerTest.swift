//
//  DetailCharacterViewControllerTest.swift
//  MarvelListTests
//
//  Created by Süha Karakaya on 13.03.2025.
//

import XCTest
import RxSwift
import RxCocoa
@testable import MarvelList

class DetailCharacterViewControllerTests: XCTestCase {
    
    var viewController: DetailCharacterViewController!
    var mockMarvelService: MockMarvelService!
    var window: UIWindow!
    
    override func setUp() {
        super.setUp()
        window = UIWindow()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "DetailCharacterViewController") as? DetailCharacterViewController
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
    
    func testViewDidLoad_LoadsCharacterData() {
        // Arrange
        let character = ResultCharacter(
            id: 1,
            name: "Spider-Man",
            description: "Friendly neighborhood Spider-Man.",
            thumbnail: nil
        )
        viewController.segueData = character
        
        // Act
        viewController.loadViewIfNeeded()
        
        // Assert
        XCTAssertEqual(viewController.stackView.arrangedSubviews.count, 2) // Name and Description
    }
    
    func testViewDidLoad_LoadsComics() {
        // Arrange
        let character = ResultCharacter(
            id: 1,
            name: "Spider-Man",
            description: "Friendly neighborhood Spider-Man.",
            thumbnail: nil
        )
        viewController.segueData = character
        
        // Act
        viewController.loadViewIfNeeded()
        
        // Assert
        XCTAssertEqual(viewController.stackView.arrangedSubviews.count, 3) // Name, Description, and Comic
    }
    
    func testButtonTapped() {
        // Arrange
        let character = ResultCharacter(
            id: 1,
            name: "Spider-Man",
            description: "Friendly neighborhood Spider-Man.",
            thumbnail: nil
        )
        viewController.segueData = character
        
        // Act
        viewController.loadViewIfNeeded()
        viewController.buttonTapped()
        
    }
}
