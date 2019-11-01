//
//  Controller.swift
//  Loaf
//
//  Created by Mat Schmid on 2019-02-05.
//  Copyright © 2019 Mat Schmid. All rights reserved.
//

import UIKit

final class Controller: UIPresentationController {
    private let loaf: Loaf
    private let size: CGSize
    
    init(
        presentedViewController: UIViewController,
        presenting presentingViewController: UIViewController?,
        loaf: Loaf,
        size: CGSize) {
        
        self.loaf = loaf
        self.size = size
        
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }
    
    //MARK: - Transitions
    
    override func containerViewWillLayoutSubviews() {
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    override func presentationTransitionWillBegin() {
        guard let containerView = containerView else { return }
        
        let yPosition: CGFloat
        switch loaf.location {
        case .bottom:
            let bottomMargin:CGFloat = containerView.frame.height - size.height
            if let tabBar = loaf.sender?.parent as? UITabBarController{
                yPosition = bottomMargin - 10 - tabBar.tabBar.frame.height
            }else{
                yPosition = bottomMargin - 40
            }
        case .top:
            yPosition = 50
        }
        
        containerView.frame.origin = CGPoint(
            x: (containerView.frame.width - frameOfPresentedViewInContainerView.width) / 4,
            y: yPosition
        )
        containerView.frame.size = size
    }
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return size
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return .zero }
        let containerSize = size(forChildContentContainer: presentedViewController,
                                 withParentContainerSize: containerView.bounds.size)
        
        let yPosition: CGFloat
        switch loaf.location {
        case .bottom:
            yPosition = containerView.bounds.height - containerSize.height
        case .top:
            yPosition = 0
        }
        
        let toastSize = CGRect(x: containerView.center.x - (containerSize.width / 2),
                               y: yPosition,
                               width: containerSize.width,
                               height: containerSize.height
        )
        
        return toastSize
    }
}
