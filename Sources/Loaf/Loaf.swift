//
//  Loaf.swift
//  Loaf
//
//  Created by Mat Schmid on 2019-02-04.
//  Copyright © 2019 Mat Schmid. All rights reserved.
//

import UIKit

final public class Loaf {
    
    // MARK: - Specifiers
    
    /// Define a custom style for the loaf.
    public struct Style {
        /// Specifies the position of the icon on the loaf. (Default is `.left`)
        ///
        /// - left: The icon will be on the left of the text
        /// - right: The icon will be on the right of the text
        public enum IconAlignment {
            case left
            case right
        }
		
        /// Specifies the width of the Loaf. (Default is `.fixed(280)`)
        ///
        /// - fixed: Specified as pixel size. i.e. 280
        /// - screenPercentage: Specified as a ratio to the screen size. This value must be between 0 and 1. i.e. 0.8
        public enum Width {
            case fixed(CGFloat)
            case screenPercentage(CGFloat)
        }
        
        /// The background color of the loaf.
        let backgroundColor: UIColor
        
        /// The color of the label's text
        let textColor: UIColor
        
        /// The color of the icon (Assuming it's rendered as template)
        let tintColor: UIColor
        
        /// The font of the label
        let font: UIFont
        
        /// The icon on the loaf
        let icon: UIImage?
        
        /// The alignment of the text within the Loaf
        let textAlignment: NSTextAlignment
        
        /// The position of the icon
        let iconAlignment: IconAlignment
		
        /// The width of the loaf
        let width: Width
		
        public init(
            backgroundColor: UIColor,
            textColor: UIColor = .white,
            tintColor: UIColor = .white,
            font: UIFont = .systemFont(ofSize: 14, weight: .medium),
            icon: UIImage? = Icon.info,
            textAlignment: NSTextAlignment = .left,
            iconAlignment: IconAlignment = .left,
            width: Width = .fixed(280)) {
            self.backgroundColor = backgroundColor
            self.textColor = textColor
            self.tintColor = tintColor
            self.font = font
            self.icon = icon
            self.textAlignment = textAlignment
            self.iconAlignment = iconAlignment
            self.width = width
        }
    }
    
    /// Defines the loaf's status. (Default is `.info`)
    ///
    /// - success: Represents a success message
    /// - error: Represents an error message
    /// - warning: Represents a warning message
    /// - info: Represents an info message
    /// - custom: Represents a custom loaf with a specified style.
    public enum State {
        case success
        case error
        case warning
        case info
        case custom(Style)
    }
    
    /// Defines the loaction to display the loaf. (Default is `.bottom`)
    ///
    /// - top: Top of the display
    /// - bottom: Bottom of the display
    public enum Location {
        case top
        case bottom
    }
    
    /// Defines either the presenting or dismissing direction of loaf. (Default is `.vertical`)
    ///
    /// - left: To / from the left
    /// - right: To / from the right
    /// - vertical: To / from the top or bottom (depending on the location of the loaf)
    public enum Direction {
        case left
        case right
        case vertical
    }
    
    /// Defines the duration of the loaf presentation. (Default is .`avergae`)
    ///
    /// - short: 2 seconds
    /// - average: 4 seconds
    /// - long: 8 seconds
    /// - custom: A custom duration (usage: `.custom(5.0)`)
    public enum Duration {
        case short
        case average
        case long
        case custom(TimeInterval)
        
        var length: TimeInterval {
            switch self {
            case .short:   return 2.0
            case .average: return 4.0
            case .long:    return 8.0
            case .custom(let timeInterval):
                return timeInterval
            }
        }
    }
    
    /// Icons used in basic states
    public enum Icon {
        public static let success = Icons.imageOfSuccess().withRenderingMode(.alwaysTemplate)
        public static let error = Icons.imageOfError().withRenderingMode(.alwaysTemplate)
        public static let warning = Icons.imageOfWarning().withRenderingMode(.alwaysTemplate)
        public static let info = Icons.imageOfInfo().withRenderingMode(.alwaysTemplate)
    }
    
    // Reason a Loaf was dismissed
    public enum DismissalReason {
        case tapped
        case timedOut
    }
    
    // MARK: - Properties
    public typealias LoafCompletionHandler = ((DismissalReason) -> Void)?
    var message: String
    var state: State
    var location: Location
    var duration: Duration = .average
    var presentingDirection: Direction
    var dismissingDirection: Direction
    var completionHandler: LoafCompletionHandler = nil
    weak var sender: UIViewController?
    
    // MARK: - Public methods
    public init(_ message: String,
                state: State = .info,
                location: Location = .bottom,
                presentingDirection: Direction = .vertical,
                dismissingDirection: Direction = .vertical,
                sender: UIViewController) {
        self.message = message
        self.state = state
        self.location = location
        self.presentingDirection = presentingDirection
        self.dismissingDirection = dismissingDirection
        self.sender = sender
    }
    
    /// Show the loaf for a specified duration. (Default is `.average`)
    ///
    /// - Parameter duration: Length the loaf will be presented
    public func show(_ duration: Duration = .average, completionHandler: LoafCompletionHandler = nil) {
        self.duration = duration
        self.completionHandler = completionHandler
        LoafManager.shared.queueAndPresent(self)
    }
	
	/// Manually dismiss a currently presented Loaf
	///
	/// - Parameter animated: Whether the dismissal will be animated
	public static func dismiss(sender: UIViewController, animated: Bool = true){
		guard LoafManager.shared.isPresenting else { return }
		guard let vc = sender.presentedViewController as? LoafViewController else { return }
		vc.dismiss(animated: animated) {
			vc.delegate?.loafDidDismiss()
		}
	}
}

final fileprivate class LoafManager: LoafDelegate {
    static let shared = LoafManager()
    
    fileprivate var queue = Queue<Loaf>()
    fileprivate var isPresenting = false
    
    fileprivate func queueAndPresent(_ loaf: Loaf) {
        queue.enqueue(loaf)
        presentIfPossible()
    }
    
    func loafDidDismiss() {
        isPresenting = false
        presentIfPossible()
    }
    
    fileprivate func presentIfPossible() {
        guard isPresenting == false, let loaf = queue.dequeue(), let sender = loaf.sender else { return }
        isPresenting = true
        let loafVC = LoafViewController(loaf)
        loafVC.delegate = self
        sender.presentToast(loafVC)
    }
}

protocol LoafDelegate: AnyObject {
    func loafDidDismiss()
}

final class LoafViewController: UIViewController {
    var loaf: Loaf
    
    let label = UILabel()
    let imageView = UIImageView(image: nil)
    var font = UIFont.systemFont(ofSize: 14, weight: .medium)
    var textAlignment: NSTextAlignment = .left
    var transDelegate: UIViewControllerTransitioningDelegate
    weak var delegate: LoafDelegate?
    
    init(_ toast: Loaf) {
        self.loaf = toast
        self.transDelegate = Manager(loaf: toast, size: .zero)
        super.init(nibName: nil, bundle: nil)
		
        var width: CGFloat?
        if case let Loaf.State.custom(style) = loaf.state {
            self.font = style.font
            self.textAlignment = style.textAlignment
			
            switch style.width {
            case .fixed(let value):
                width = value
            case .screenPercentage(let percentage):
                guard 0...1 ~= percentage else { return }
                width = UIScreen.main.bounds.width * percentage
            }
        }
        
        let height = max(toast.message.heightWithConstrainedWidth(width: 240, font: font) + 12, 40)
        preferredContentSize = CGSize(width: width ?? 280, height: height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = loaf.message
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .white
        label.font = font
        label.textAlignment = textAlignment
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        switch loaf.state {
        case .success:
            imageView.image = Loaf.Icon.success
            view.backgroundColor = UIColor(hexString: "#2ecc71")
            constrainWithIconAlignment(.left)
        case .warning:
            imageView.image = Loaf.Icon.warning
            view.backgroundColor = UIColor(hexString: "##f1c40f")
            constrainWithIconAlignment(.left)
        case .error:
            imageView.image = Loaf.Icon.error
            view.backgroundColor = UIColor(hexString: "##e74c3c")
            constrainWithIconAlignment(.left)
        case .info:
            imageView.image = Loaf.Icon.info
            view.backgroundColor = UIColor(hexString: "##34495e")
            constrainWithIconAlignment(.left)
        case .custom(style: let style):
            imageView.image = style.icon
            view.backgroundColor = style.backgroundColor
            imageView.tintColor = style.tintColor
            label.textColor = style.textColor
            label.font = style.font
            constrainWithIconAlignment(style.iconAlignment, showsIcon: imageView.image != nil)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + loaf.duration.length, execute: {
            self.dismiss(animated: true) { [weak self] in
                self?.delegate?.loafDidDismiss()
                self?.loaf.completionHandler?(.timedOut)
            }
        })
    }
    
    @objc private func handleTap() {
        dismiss(animated: true) { [weak self] in
            self?.delegate?.loafDidDismiss()
            self?.loaf.completionHandler?(.tapped)
        }
    }
    
    private func constrainWithIconAlignment(_ alignment: Loaf.Style.IconAlignment, showsIcon: Bool = true) {
        view.addSubview(label)
        
        if showsIcon {
            view.addSubview(imageView)
            
            switch alignment {
            case .left:
                NSLayoutConstraint.activate([
                    imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                    imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                    imageView.heightAnchor.constraint(equalToConstant: 28),
                    imageView.widthAnchor.constraint(equalToConstant: 28),
                    
                    label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
                    label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -4),
                    label.topAnchor.constraint(equalTo: view.topAnchor),
                    label.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                ])
            case .right:
                NSLayoutConstraint.activate([
                    imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
                    imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                    imageView.heightAnchor.constraint(equalToConstant: 28),
                    imageView.widthAnchor.constraint(equalToConstant: 28),
                    
                    label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                    label.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -4),
                    label.topAnchor.constraint(equalTo: view.topAnchor),
                    label.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                ])
            }
        } else {
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
                label.topAnchor.constraint(equalTo: view.topAnchor),
                label.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
    }
}

private struct Queue<T> {
    fileprivate var array = [T]()
    
    mutating func enqueue(_ element: T) {
        array.append(element)
    }
    
    mutating func dequeue() -> T? {
        if array.isEmpty {
            return nil
        } else {
            return array.removeFirst()
        }
    }
}

