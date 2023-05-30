//
//  Extensions.swift
//  Loaf
//
//  Created by Mat Schmid on 2019-02-04.
//  Copyright © 2019 Mat Schmid. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentToast(_ smartToastViewController: LoafViewController) {
        smartToastViewController.transDelegate = Manager(loaf: smartToastViewController.loaf, size: smartToastViewController.preferredContentSize)
        smartToastViewController.transitioningDelegate = smartToastViewController.transDelegate
        smartToastViewController.modalPresentationStyle = .custom
        smartToastViewController.view.clipsToBounds = true
        smartToastViewController.view.layer.cornerRadius = 6
        present(smartToastViewController, animated: true)
    }
}

extension String {
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont, lineSpacing: CGFloat?) -> CGFloat {
        var attributes: [NSAttributedString.Key : Any] = [:]
        if let lineSpacing = lineSpacing {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = lineSpacing
            attributes[NSAttributedString.Key.paragraphStyle] = paragraphStyle
        }
        attributes[NSAttributedString.Key.font] = font

        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(
            with: constraintRect,
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: attributes,
            context: nil
        )
        return boundingBox.height
    }
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

extension UILabel {
    func setLineSpacing(lineSpacing: CGFloat) {
        // Create a mutable attributed string with the label's text
        guard let labelText = text else { return }
        let attributedString = NSMutableAttributedString(string: labelText)

        // Create an instance of NSMutableParagraphStyle to configure the paragraph style
        let paragraphStyle = NSMutableParagraphStyle()

        // Set the desired line spacing value
        paragraphStyle.lineSpacing = lineSpacing

        // Preserve existing label properties
        let labelFont = font ?? UIFont.systemFont(ofSize: 17.0) // Default font size
        let labelColor = textColor ?? UIColor.black
        let labelAlignment = textAlignment

        // Apply the label properties to the attributed string
        attributedString.addAttribute(.font, value: labelFont, range: NSMakeRange(0, attributedString.length))
        attributedString.addAttribute(.foregroundColor, value: labelColor, range: NSMakeRange(0, attributedString.length))
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))

        // Set the attributed string and preserved properties on the label
        self.attributedText = attributedString
    }
}
