//
//  TabOne.swift
//  LoafExamples
//
//  Created by sk on 5/8/19.
//  Copyright © 2019 Mat Schmid. All rights reserved.
//

import UIKit
import Loaf

class TabOne: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func success(_ sender: Any) {
         Loaf("success message tp", state: .success, sender: self).show()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
