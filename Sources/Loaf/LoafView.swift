//
//  LoafView.swift
//  Loaf
//
//  Created by Joseph Roque on 2020-01-16.
//  Copyright © 2020 Mat Schmid. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
extension Loaf: Identifiable {
    public var id: String {
        return message
    }
}

@available(iOS 13.0, *)
public extension View {
    /// Presents a Loaf.
    ///
    /// - Parameters:
    ///   - loaf: A binding to a Loaf. If the loaf changes, the system will dismiss the currently-presented Loaf
    ///     and replace it with a new Loaf.
    ///   - onDismiss: called when the Loaf times out or is tapped
    func loaf(_ loaf: Binding<Loaf?>, onDismiss: Loaf.LoafCompletionHandler = nil) -> some View {
        ZStack {
            LoafView(loaf, onDismiss: onDismiss)
            self
        }
    }
}

@available(iOS 13.0, *)
struct LoafView: UIViewControllerRepresentable {
    @Binding var loaf: Loaf?
    private let onDismiss: Loaf.LoafCompletionHandler
    
    init(_ loaf: Binding<Loaf?>, onDismiss: Loaf.LoafCompletionHandler) {
        _loaf = loaf
        self.onDismiss = onDismiss
    }
    
    func makeUIViewController(context: Context) -> LoafWrappedViewController {
        return LoafWrappedViewController(loaf: loaf)
    }
    
    func updateUIViewController(_ uiViewController: LoafWrappedViewController, context: Context) {
        if let loaf = self.loaf {
            if let presentedLoaf = uiViewController.loaf, presentedLoaf.id != loaf.id {
                Loaf.dismiss(sender: uiViewController, animated: true)
            }
            
            uiViewController.loaf = loaf
            uiViewController.loaf?.show { reason in
                self.loaf = nil
                self.onDismiss?(reason)
            }
        }
    }
}

@available(iOS 13.0, *)
class LoafWrappedViewController: UIViewController {
    var loaf: Loaf? {
        didSet {
            if let loaf = loaf {
                loaf.sender = self
            }
        }
    }
    
    fileprivate init(loaf: Loaf?) {
        self.loaf = loaf
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        view.isUserInteractionEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
