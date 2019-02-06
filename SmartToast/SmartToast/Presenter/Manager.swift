//
//  Manager.swift
//  SmartToast
//
//  Created by Mat Schmid on 2019-02-05.
//  Copyright © 2019 Mat Schmid. All rights reserved.
//

import UIKit

final class Manager: NSObject {
    private let direction: SmartToast.Direction
    private let size: CGSize
    
    init(direction: SmartToast.Direction, size: CGSize) {
        self.direction = direction
        self.size = size
    }
}

extension Manager: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return Controller(
            presentedViewController: presented,
            presenting: presenting,
            direction: direction,
            size: size
        )
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return Animator(presenting: true, duration: 0.5, direction: direction)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return Animator(presenting: false, duration: 0.5, direction: direction)
    }
}
