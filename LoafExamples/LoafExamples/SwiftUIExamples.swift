//
//  SwiftUIExamples.swift
//  LoafExamples
//
//  Created by Joseph Roque on 2020-01-16.
//  Copyright © 2020 Mat Schmid. All rights reserved.
//

import SwiftUI
import Loaf

@available(iOS 13.0, *)
struct SwiftUIExamples: View {
    let onDismiss: () -> Void
    @State var loaf: Loaf?
    
    init(onDismiss: @escaping () -> Void) {
        self.onDismiss = onDismiss
        self.loaf = nil
    }
    
    var dismissButton: some View {
        Button("Done") {
            self.onDismiss()
        }
    }
    
    var body: some View {
        VStack {
            Text("SwiftUI Loafs")
                .font(.system(size: 24))
                .padding()
            List {
                ForEach(ExampleGroup.allCases, id: \.rawValue) { group in
                    Section(header: Text(group.rawValue)) {
                        ForEach(group.loafs, id: \.rawValue) { loaf in
                            Button(loaf.title) {
                                self.loaf = loaf.create()
                            }
                        }
                    }
                }
            }
            .loaf(
                $loaf,
                onDismiss: { reason in
                    print("Dismissed: \(reason)")
                }
            )
        }
    }
}
