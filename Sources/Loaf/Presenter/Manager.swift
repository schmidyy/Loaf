//
//  Manager.swift
//  Loaf
//
//  Created by Mat Schmid on 2019-02-05.
//  Copyright © 2019 Mat Schmid. All rights reserved.
//

import UIKit

final class Manager: NSObject, UIViewControllerTransitioningDelegate {
    private let loaf: Loaf
    private let size: CGSize
    var animator: Animator
    
    init(loaf: Loaf, size: CGSize) {
        self.loaf = loaf
        self.size = size
        self.animator = Animator(duration: 0.4, loaf: loaf, size: size)
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return Controller(
            presentedViewController: presented,
            presenting: presenting,
            loaf: loaf,
            size: size
        )
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.presenting = true
        return animator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.presenting = false
        return animator
    }
}
