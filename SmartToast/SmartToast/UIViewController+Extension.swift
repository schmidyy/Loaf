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
        smartToastViewController.modalPresentationStyle = .custom
        smartToastViewController.view.clipsToBounds = true
        smartToastViewController.view.layer.cornerRadius = 6
        present(smartToastViewController, animated: true)
    }
}
