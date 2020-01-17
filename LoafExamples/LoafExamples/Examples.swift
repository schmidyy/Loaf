//
//  Examples.swift
//  LoafExamples
//
//  Created by Mat Schmid on 2019-02-24.
//  Copyright © 2019 Mat Schmid. All rights reserved.
//

import SwiftUI
import UIKit
import Loaf

class Examples: UITableViewController {
    
    private var isDarkMode = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var trailingBarButtonItems = [
            UIBarButtonItem(image: UIImage(named: "moon"), style: .done, target: self, action: #selector(toggleDarkMode))
        ]
        
        if #available(iOS 13.0, *) {
            trailingBarButtonItems.append(UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(openSwiftUIExamples)))
        }

        self.navigationItem.rightBarButtonItems = trailingBarButtonItems
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(dismissLoaf))
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
	
	@objc private func dismissLoaf() {
		// Manually dismisses the currently presented Loaf
		Loaf.dismiss(sender: self)
	}
    
    @objc private func openSwiftUIExamples() {
        if #available(iOS 13.0, *) {
            let rootView = SwiftUIExamples { [weak self] in
                self?.dismiss(animated: true)
            }
            present(UIHostingController(rootView: rootView), animated: true)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return ExampleGroup.allCases.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ExampleGroup.allCases[section].loafs.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ExampleGroup.allCases[indexPath.section].loafs[indexPath.row].show(withSender: self)
        
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
