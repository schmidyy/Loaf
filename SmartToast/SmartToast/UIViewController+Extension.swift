//
//  UIViewController+Extension.swift
//  SmartToast
//
//  Created by Mat Schmid on 2019-02-04.
//  Copyright © 2019 Mat Schmid. All rights reserved.
//

import Foundation

extension UIViewController {
    func presentToast(_ smartToastViewController: SmartToastViewController) {
        let transitionDelegate = Manager(direction: .vertical, size: CGSize(width: 250, height: 40))
        smartToastViewController.transitioningDelegate = transitionDelegate
        smartToastViewController.modalPresentationStyle = .custom
        smartToastViewController.view.clipsToBounds = true
        smartToastViewController.view.layer.cornerRadius = 6
        present(smartToastViewController, animated: true)
    }
}

extension UIView {
    func constrainToFill(_ view: UIView, againstLayoutMargins: Bool = false, inset: UIEdgeInsets = UIEdgeInsets()) {
        if againstLayoutMargins {
            NSLayoutConstraint.activate([
                leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: inset.left),
                trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -inset.right),
                topAnchor.constraint(equalTo: view.topAnchor, constant: inset.top),
                bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: inset.bottom)
            ])
        } else {
            NSLayoutConstraint.activate([
                leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: inset.left),
                trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -inset.right),
                topAnchor.constraint(equalTo: view.topAnchor, constant: inset.top),
                bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: inset.bottom)
            ])
        }
    }
}
