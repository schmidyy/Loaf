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
        case success = "Success"
        case error = "Error"
        case warning = "Warning"
        case info = "Info"
        case longMessage = "Long Message"
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
            Loaf("This is a toast with a long message. It should span multiple lines and still look good.", state: .info, sender: self).show()
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
