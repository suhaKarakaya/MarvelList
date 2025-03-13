//
//  DetailCharacterViewController.swift
//  MarvelList
//
//  Created by Süha Karakaya on 12.03.2025.
//

import UIKit
import RxSwift
import Lottie

class DetailCharacterViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var iv_character: UIImageView!
    
    var marvelService: MarvelServiceProtocol! = MarvelService()
    let disposeBag = DisposeBag()
 
    var segueData: ResultCharacter?
    let starButton = UIButton(type: .system)
    let animationView = LottieAnimationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false
        scrollView.contentInsetAdjustmentBehavior = .never
        
        setupStarButton()
        fetchComics()
    }
    
    private func fetchComics() {
        guard let characterId = segueData?.id else { return }
        
        let comicsRequest = ComicsRequest(limit: 10, orderBy: "-modified", startYear: 2005, characterId: characterId)
        
        marvelService.fetchComics(comicsRequest, overlayTarget: self.view)
            .subscribe(onNext: { [weak self] response in
                self?.updateUI(with: response)
            }, onError: { error in
                print("Hata: \(error.localizedDescription)")
            })
            .disposed(by: disposeBag)
    }
    
    private func updateUI(with response: MarvelBaseResponse<ResultComic>) {
        guard let data = segueData else { return }
        
        marvelService.loadImage(from: data.thumbnail?.url ?? "")
            .observe(on: MainScheduler.instance)
            .bind(to: iv_character.rx.image)
            .disposed(by: disposeBag)
        
        if let name = data.name, !name.isEmpty {
            addLabelToStackView(text: name, font: UIFont.systemFont(ofSize: 25, weight: .bold), textColor: .white)
        }
        
        if let desc = data.description, !desc.isEmpty {
            addLabelToStackView(text: desc, font: UIFont.italicSystemFont(ofSize: 20), textColor: .white, numberOfLines: 0)
        }
        
        if let comicsList = response.data?.results, !comicsList.isEmpty {
            setComicsList(comicsList)
        }
    }
    
    private func setComicsList(_ list: [ResultComic]) {
        addLabelToStackView(text: "Comics", font: UIFont.systemFont(ofSize: 15), textColor: .red)
        
        for item in list {
            addLabelToStackView(text: "- \(item.title ?? "")", font: UIFont.systemFont(ofSize: 15, weight: .bold), textColor: .white, numberOfLines: 0)
        }
    }
    
    private func addLabelToStackView(text: String, font: UIFont, textColor: UIColor, numberOfLines: Int = 1) {
        let label = UILabel()
        label.textColor = textColor
        label.text = text
        label.numberOfLines = numberOfLines
        label.font = font
        
        let containerView = UIView()
        containerView.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            label.topAnchor.constraint(equalTo: containerView.topAnchor),
            label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        stackView.addArrangedSubview(containerView)
    }
    
    private func setupStarButton() {
        guard let itemId = segueData?.id else { return }
        
        let isFavorite = UserDefaultsManager.shared.read(forKey: "favoriteList", as: [Int].self)?.contains(itemId) ?? false
        let starImage = isFavorite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        
        starButton.setImage(starImage, for: .normal)
        starButton.tintColor = UIColor(named: "marvelYellow")!
        starButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        starButton.addTarget(self, action: #selector(starButtonTapped), for: .touchUpInside)
        
        let barButtonItem = UIBarButtonItem(customView: starButton)
        navigationItem.rightBarButtonItem = barButtonItem
        
        animationView.animation = LottieAnimation.named("star_animation")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.isUserInteractionEnabled = false
    }
    
    @objc private func starButtonTapped() {
        guard let itemId = segueData?.id else { return }
        
        var favoriteList = UserDefaultsManager.shared.read(forKey: "favoriteList", as: [Int].self) ?? []
        
        if let index = favoriteList.firstIndex(of: itemId) {
            favoriteList.remove(at: index)
            updateStarButton(filled: false)
        } else {
            favoriteList.append(itemId)
            playStarAnimation()
        }
        
        UserDefaultsManager.shared.save(favoriteList, forKey: "favoriteList")
    }

    private func playStarAnimation() {
        animationView.frame = starButton.bounds
        starButton.addSubview(animationView)
        
        animationView.play { [weak self] _ in
            self?.updateStarButton(filled: true)
            self?.animationView.removeFromSuperview()
        }
    }

    private func updateStarButton(filled: Bool) {
        let starImage = filled ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        starButton.setImage(starImage, for: .normal)
    }
}
