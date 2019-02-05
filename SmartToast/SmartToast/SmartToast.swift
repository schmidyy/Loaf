//
//  SmartToast.swift
//  SmartToast
//
//  Created by Mat Schmid on 2019-02-04.
//  Copyright © 2019 Mat Schmid. All rights reserved.
//

import UIKit

public class SmartToast {
    public struct Style {
        public enum IconAlignment {
            case left
            case right
        }
        
        let backgroundColor: UIColor
        let icon: UIImage
        let iconAlignment: IconAlignment
    }
    
    public enum State {
        case success
        case error
        case warning
        case info
        case custom(style: Style)
    }
    
    let message: String
    
    public init(_ message: String, state: State = .info) {
        self.message = message
    }
    
    public func show() {
        print(message)
    }
}
