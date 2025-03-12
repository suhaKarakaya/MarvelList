//
//  LoadingIndicator.swift
//  MarvelList
//
//  Created by Süha Karakaya on 12.03.2025.
//

import UIKit

class LoadingIndicatorView {
    
    static var currentOverlay : UIView?
    static var currentOverlayTarget : UIView?
    
    
    static func show(_ overlayTarget : UIView) {
        // Clear it first in case it was already shown
        hide()
        
        // Create the overlay
        let overlay = UIView()
        overlay.alpha = 0
        overlay.backgroundColor = UIColor.black
        overlay.translatesAutoresizingMaskIntoConstraints = false
        overlayTarget.addSubview(overlay)
        overlayTarget.bringSubviewToFront(overlay)
        
        overlay.widthAnchor.constraint(equalTo: overlayTarget.widthAnchor).isActive = true
        overlay.heightAnchor.constraint(equalTo: overlayTarget.heightAnchor).isActive = true
        
        // Create and animate the activity indicator
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.white)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()
        overlay.addSubview(indicator)
        
        indicator.centerXAnchor.constraint(equalTo: overlay.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: overlay.centerYAnchor).isActive = true
        
        
        // Animate the overlay to show
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.5)
        overlay.alpha = overlay.alpha > 0 ? 0 : 0.5
        UIView.commitAnimations()
        
        currentOverlay = overlay
        currentOverlayTarget = overlayTarget
    }
    
    static func hide() {
        if currentOverlay != nil {
            currentOverlay?.removeFromSuperview()
            currentOverlay =  nil
            currentOverlayTarget = nil
        }
    }
}



