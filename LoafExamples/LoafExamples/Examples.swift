//
//  Examples.swift
//  LoafExamples
//
//  Created by Mat Schmid on 2019-02-24.
//  Copyright © 2019 Mat Schmid. All rights reserved.
//

import UIKit
import Loaf

class Examples: UITableViewController {
    
    private enum Example: String, CaseIterable {
        case success  = "An action was successfully completed"
        case error    = "An error has occured"
        case warning  = "A warning has occured"
        case info     = "This is some information"
        
        case bottom   = "This will be shown at the bottom of the view"
        case top      = "This will be shown at the top of the view"
        
        case vertical = "The loaf will be presented and dismissed vertically"
        case left     = "The loaf will be presented and dismissed from the left"
        case right    = "The loaf will be presented and dismissed from the right"
        case mix      = "The loaf will be presented from the left and dismissed vertically"
        
        case custom1  = "This will showcase using custom colors and font"
        case custom2  = "This will showcase using right icon alignment"
        case custom3  = "This will showcase using no icon"
        
        static let grouped: [[Example]] = [[.success, .error, .warning, .info],
                                           [.bottom, .top],
                                           [.vertical, .left, .right, .mix],
                                           [.custom1, .custom2, .custom3]]
    }
    
    private var isDarkMode = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "moon"), style: .done, target: self, action: #selector(toggleDarkMode))
    }
    
    @objc private func toggleDarkMode() {
        navigationController?.navigationBar.tintColor    = isDarkMode ? .black : .white
        navigationController?.navigationBar.barTintColor = isDarkMode ? .white : .black
        navigationController?.navigationBar.barStyle     = isDarkMode ? .default : .black
        tableView.backgroundColor                        = isDarkMode ? .groupTableViewBackground : .black
        
        if isDarkMode {
            Loaf("Switched to light mode", state: .custom(.init(backgroundColor: .black, icon: UIImage(named: "moon"))), sender: self).show(.short)
        } else {
            Loaf("Switched to dark mode", state: .custom(.init(backgroundColor: .white, textColor: .black, tintColor: .black, icon: UIImage(named: "moon"))), sender: self).show(.short)
        }
        
        tableView.reloadData()
        isDarkMode = !isDarkMode
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return Example.grouped.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Example.grouped[section].count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let example = Example.grouped[indexPath.section][indexPath.row]
        switch example {
        case .success:
            Loaf(example.rawValue, state: .success, sender: self).show()
        case .error:
            Loaf(example.rawValue, state: .error, sender: self).show()
        case .warning:
            Loaf(example.rawValue, state: .warning, sender: self).show()
        case .info:
            Loaf(example.rawValue, state: .info, sender: self).show()
            
        case .bottom:
            Loaf(example.rawValue, sender: self).show {
                print("Dismissed!")
            }
        case .top:
            Loaf(example.rawValue, location: .top, sender: self).show()
            
        case .vertical:
            Loaf(example.rawValue, sender: self).show(.short)
        case .left:
            Loaf(example.rawValue, presentingDirection: .left, dismissingDirection: .left, sender: self).show(.short)
        case .right:
            Loaf(example.rawValue, presentingDirection: .right, dismissingDirection: .right, sender: self).show(.short)
        case .mix:
            Loaf(example.rawValue, presentingDirection: .left, dismissingDirection: .vertical, sender: self).show(.short)
            
        case .custom1:
            Loaf(example.rawValue, state: .custom(.init(backgroundColor: .purple, textColor: .yellow, tintColor: .green, font: .systemFont(ofSize: 18, weight: .bold), icon: Loaf.Icon.success)), sender: self).show()
        case .custom2:
            Loaf(example.rawValue, state: .custom(.init(backgroundColor: .purple, iconAlignment: .right)), sender: self).show()
        case .custom3:
            Loaf(example.rawValue, state: .custom(.init(backgroundColor: .black, icon: nil)), sender: self).show()
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = isDarkMode ? .black : .white
        cell.textLabel?.textColor = isDarkMode ? .white : .darkGray
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = isDarkMode ? .white : .darkGray
    }
}
