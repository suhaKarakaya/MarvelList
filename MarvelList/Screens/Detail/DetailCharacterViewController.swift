//
//  DetailCharacterViewController.swift
//  MarvelList
//
//  Created by Süha Karakaya on 12.03.2025.
//

import UIKit
import RxSwift

class DetailCharacterViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var iv_character: UIImageView!
    
    let marvelService: MarvelServiceProtocol! = MarvelService()
    let disposeBag = DisposeBag()
 
    var segueData: ResultCharacter?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false

        scrollView.contentInsetAdjustmentBehavior = .never
        
        let customButton = UIBarButtonItem(title: "Click", style: .plain, target: self, action: #selector(buttonTapped))
        navigationItem.rightBarButtonItem = customButton
        
        
        if let data = segueData {
            marvelService.loadImage(from: data.thumbnail?.url ?? "")
                        .observe(on: MainScheduler.instance)
                        .bind(to: iv_character.rx.image)
                        .disposed(by: disposeBag)
            
            if let name = data.name, !name.isEmpty {
                let lblName = UILabel()
                lblName.text = name
                stackView.addArrangedSubview(lblName)

            }
            
            if let desc = data.description, !desc.isEmpty {
                let lblDesc = UILabel()
                lblDesc.text = desc
                lblDesc.numberOfLines = 0
                stackView.addArrangedSubview(lblDesc)

            }
        }
        
        marvelService.fetchComics(ComicsRequest(limit: 10, orderBy: "-modified", startYear: 2005, characterId: segueData?.id),  overlayTarget: self.view)
            .subscribe(onNext: { [weak self] response in
                for item in response.data?.results ?? [] {
                    let lblTemp = UILabel()
                    lblTemp.text = item.title
                    lblTemp.numberOfLines = 0
                    self?.stackView.addArrangedSubview(lblTemp)
                }
                
      
            }, onError: { error in
                print("Hata: \(error.localizedDescription)")
            })
            .disposed(by: disposeBag)
        
        
       
        
        
        
        
        

       
        
 
    }
    
    @objc func buttonTapped() {
        print("Custom button tapped!")
    }
    

}
