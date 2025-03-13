//
//  SplashViewController.swift
//  MarvelList
//
//  Created by Süha Karakaya on 12.03.2025.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {

    private var animationView: LottieAnimationView?

    override func viewDidLoad() {
        super.viewDidLoad()

        animationView = .init(name: "splash_animation")

        animationView!.frame = view.bounds
        animationView!.contentMode = .scaleAspectFit
        animationView!.loopMode = .playOnce

        view.addSubview(animationView!)

        animationView!.play { [weak self] (finished) in
            self?.navigateToCharacterList()
        }
    }
    
    private func navigateToCharacterList() {
        let storyboard = UIStoryboard(name: "CharacterList", bundle: nil)
        if let navigationController = storyboard.instantiateViewController(withIdentifier: "CharacterListNavigationControllerID") as? UINavigationController {
            
            if let window = self.view.window {
                window.rootViewController = navigationController
                UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {}, completion: nil)
            }
        }
    }
}
