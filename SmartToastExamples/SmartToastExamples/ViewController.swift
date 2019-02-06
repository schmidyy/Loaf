//
//  ViewController.swift
//  SmartToastExamples
//
//  Created by Mat Schmid on 2019-02-04.
//  Copyright © 2019 Mat Schmid. All rights reserved.
//

import UIKit
import SmartToast

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        SmartToast("Hello! This is a warning toast because something might have gone bad", icon: UIImage(named: "warning")!, sender: self).show()
    }
}

