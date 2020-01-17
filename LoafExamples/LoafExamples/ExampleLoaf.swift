//
//  ExampleLoaf.swift
//  LoafExamples
//
//  Created by Joseph Roque on 2020-01-16.
//  Copyright © 2020 Mat Schmid. All rights reserved.
//

import SwiftUI
import Loaf

enum ExampleGroup: String, CaseIterable {
    case basic = "Basic States"
    case locations = "Locations"
    case directions = "Directions"
    case custom = "Custom"
    
    var loafs: [ExampleLoaf] {
        switch self {
        case .basic: return [.success, .error, .warning, .info]
        case .locations: return [.bottom, .top]
        case .directions: return [.vertical, .left, .right, .mix]
        case .custom: return [.custom1, .custom2, .custom3]
        }
    }
}

enum ExampleLoaf: String, CaseIterable {
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
    case custom3  = "This will showcase using no icon and 80% screen size width"
    
    var title: String {
        switch self {
        case .success: return "Success"
        case .error: return "Error"
        case .warning: return "Warning"
        case .info: return "Info"
        case .bottom: return "Bottom"
        case .top: return "Top"
        case .vertical: return "Vertical"
        case .left: return "Left"
        case .right: return "Right"
        case .mix: return "Mix"
        case .custom1: return "Colors and font"
        case .custom2: return "Right icon alignment"
        case .custom3: return "No icon + custom width"
        }
    }
    
    func show(withSender sender: UIViewController) {
        switch self {
        case .success: Loaf(self.rawValue, state: .success, sender: sender).show()
        case .error: Loaf(self.rawValue, state: .error, sender: sender).show()
        case .warning: Loaf(self.rawValue, state: .warning, sender: sender).show()
        case .info: Loaf(self.rawValue, state: .info, sender: sender).show()
        
        case .bottom: Loaf(self.rawValue, sender: sender).show { dismissalType in
            switch dismissalType {
            case .tapped: print("Tapped!")
            case .timedOut: print("Timmed out!")
            }
        }
        case .top: Loaf(self.rawValue, location: .top, sender: sender).show()
        
        case .vertical: Loaf(self.rawValue).show(.short)
        case .left: Loaf(self.rawValue, presentingDirection: .left, dismissingDirection: .left, sender: sender).show(.short)
        case .right: Loaf(self.rawValue, presentingDirection: .right, dismissingDirection: .right, sender: sender).show(.short)
        case .mix: Loaf(self.rawValue, presentingDirection: .left, dismissingDirection: .vertical, sender: sender).show(.short)
        
        case .custom1: Loaf(self.rawValue, state: .custom(.init(backgroundColor: .purple, textColor: .yellow, tintColor: .green, font: .systemFont(ofSize: 18, weight: .bold), icon: Loaf.Icon.success)), sender: sender).show()
        case .custom2: Loaf(self.rawValue, state: .custom(.init(backgroundColor: .purple, iconAlignment: .right)), sender: sender).show()
        case .custom3: Loaf(self.rawValue, state: .custom(.init(backgroundColor: .black, icon: nil, textAlignment: .center, width: .screenPercentage(0.8))), sender: sender).show()
        }
    }
    
    func create() -> Loaf {
        switch self {
        case .success: return Loaf(self.rawValue, state: .success)
        case .error: return Loaf(self.rawValue, state: .error)
        case .warning: return Loaf(self.rawValue, state: .warning)
        case .info: return Loaf(self.rawValue, state: .info)
        
        case .bottom: return Loaf(self.rawValue)
        case .top: return Loaf(self.rawValue, location: .top)
        
        case .vertical: return Loaf(self.rawValue, duration: .short)
        case .left: return Loaf(self.rawValue, presentingDirection: .left, dismissingDirection: .left, duration: .short)
        case .right: return Loaf(self.rawValue, presentingDirection: .right, dismissingDirection: .right, duration: .short)
        case .mix: return Loaf(self.rawValue, presentingDirection: .left, dismissingDirection: .vertical, duration: .short)
        
        case .custom1: return Loaf(self.rawValue, state: .custom(.init(backgroundColor: .purple, textColor: .yellow, tintColor: .green, font: .systemFont(ofSize: 18, weight: .bold), icon: Loaf.Icon.success)))
        case .custom2: return Loaf(self.rawValue, state: .custom(.init(backgroundColor: .purple, iconAlignment: .right)))
        case .custom3: return Loaf(self.rawValue, state: .custom(.init(backgroundColor: .black, icon: nil, textAlignment: .center, width: .screenPercentage(0.8))))
        }
    }
}
