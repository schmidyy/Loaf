//
//  Manager.swift
//  Loaf
//
//  Created by Mat Schmid on 2019-02-05.
//  Copyright © 2019 Mat Schmid. All rights reserved.
//

import UIKit

final class Manager: NSObject {
    private let loaf: Loaf
    private let size: CGSize
    
    init(loaf: Loaf, size: CGSize) {
        self.loaf = loaf
        self.size = size
    }
}

extension Manager: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return Controller(
            presentedViewController: presented,
            presenting: presenting,
            loaf: loaf,
            size: size
        )
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return Animator(presenting: true, duration: 0.5, direction: loaf.presentingDirection)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return Animator(presenting: false, duration: 0.5, direction: loaf.dismissingDirection)
    }
}
