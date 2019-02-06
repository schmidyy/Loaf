//
//  Animator.swift
//  Loaf
//
//  Created by Mat Schmid on 2019-02-05.
//  Copyright © 2019 Mat Schmid. All rights reserved.
//

import UIKit

final class Animator: NSObject {
    private let presenting: Bool
    private let duration: TimeInterval
    private let direction: Loaf.Direction
    
    init(presenting: Bool, duration: TimeInterval, direction: Loaf.Direction) {
        self.presenting = presenting
        self.duration = duration
        self.direction = direction
        
        super.init()
    }
}

extension Animator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let key: UITransitionContextViewControllerKey = presenting ? .to : .from
        let controller = transitionContext.viewController(forKey: key)!
        
        if presenting {
            transitionContext.containerView.addSubview(controller.view)
        }
        
        let presentedFrame = transitionContext.finalFrame(for: controller)
        var dismissedFrame = presentedFrame
        
        switch direction {
        default:
            // TODO: Handle all cases
            dismissedFrame.origin.y = transitionContext.containerView.frame.height
        }
        
        let initialFrame = presenting ? dismissedFrame : presentedFrame
        let finalFrame = presenting ? presentedFrame : dismissedFrame
        let animationOption: UIView.AnimationOptions = presenting ? .curveEaseOut : .curveEaseIn
        
        let animationDuration = transitionDuration(using: transitionContext)
        controller.view.frame = initialFrame
        
        UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.65, options: animationOption, animations: {
            controller.view.frame = finalFrame
        }, completion: { finished in
            transitionContext.completeTransition(finished)
        })
    }
    
    
}
