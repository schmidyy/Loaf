//
//  Controller.swift
//  Loaf
//
//  Created by Mat Schmid on 2019-02-05.
//  Copyright © 2019 Mat Schmid. All rights reserved.
//

import UIKit

final class Controller: UIPresentationController {
    private let direction: Loaf.Direction
    private let size: CGSize
    
    init(
        presentedViewController: UIViewController,
        presenting presentingViewController: UIViewController?,
        direction: Loaf.Direction,
        size: CGSize) {
        
        self.direction = direction
        self.size = size
        
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }
    
    //MARK: - Transitions
    override func containerViewWillLayoutSubviews() {
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return size
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return .zero }
        let containerSize = size(forChildContentContainer: presentedViewController,
                                 withParentContainerSize: containerView.bounds.size)
        
        let toastSize = CGRect(x: containerView.center.x - (containerSize.width / 2),
                               y: containerView.bounds.height - containerSize.height - 30,
                               width: containerSize.width,
                               height: containerSize.height)
        
        return toastSize
    }
}
