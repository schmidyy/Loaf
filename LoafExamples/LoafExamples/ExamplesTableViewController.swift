//
//  ExamplesTableViewController.swift
//  LoafExamples
//
//  Created by Mat Schmid on 2019-02-06.
//  Copyright © 2019 Mat Schmid. All rights reserved.
//

import UIKit
import Loaf

class ExamplesTableViewController: UITableViewController {
    
    enum Example: String, CaseIterable {
        case success     = "Success"
        case error       = "Error"
        case warning     = "Warning"
        case info        = "Info"
        case longMessage = "Long Message"
        case top         = "Top Location"
        case short       = "Short duration"
        case long        = "Long duration"
        case right       = "Right dismissal"
        case left        = "Left dismissal"
        case completion  = "With completion handler"
        case custom1     = "Custom 1"
        case custom2     = "Custom 2"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Example.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let example = Example.allCases[indexPath.row]
        let cell = UITableViewCell()
        cell.textLabel?.text = example.rawValue
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let example = Example.allCases[indexPath.row]
        
        switch example {
        case .success:
            Loaf("This is a success!", state: .success, sender: self).show()
        case .error:
            Loaf("This is an error", state: .error, sender: self).show()
        case .warning:
            Loaf("This is a warning", state: .warning, sender: self).show()
        case .info:
            Loaf("This is a bit of info", state: .info, sender: self).show()
        case .longMessage:
            Loaf("This is a toast with a long message. It should span multiple lines and still look good. I'm making this span many multiple lines in the hopes of seeing if it will break", state: .info, sender: self).show()
        case .top:
            Loaf("This should be shown at the top of the view", state: .success, location: .top, presentingDirection: .left, dismissingDirection: .right, sender: self).show()
        case.short:
            Loaf("This is should be shown for 2 seconds", state: .warning, sender: self).show(.short)
        case.long:
            Loaf("This is should be shown for 8 seconds", state: .success, sender: self).show(.long)
        case .right:
            Loaf("This will dismiss on the right of the screen", dismissingDirection: .right, sender: self).show(.short)
        case .left:
            Loaf("This will dismiss on the left of the screen", dismissingDirection: .left, sender: self).show(.short)
        case .completion:
            Loaf("This will print to the console when dismissed", sender: self) {
                print("Completed!")
            }.show()
        case .custom1:
            let style = Loaf.Style(backgroundColor: .purple, textColor: .yellow, font: .systemFont(ofSize: 18, weight: .bold), icon: nil)
            Loaf("This is a custom loaf", state: .custom(style), sender: self).show()
        case .custom2:
            let style = Loaf.Style(backgroundColor: .purple, textColor: .yellow, font: .systemFont(ofSize: 18, weight: .bold), icon: nil, iconAlignment: .right)
            Loaf("This is a custom loaf with a longer message to test wrapping", state: .custom(style), sender: self).show()
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
