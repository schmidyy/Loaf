// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "Loaf",
    platforms: [
        .iOS(.v9)
    ],
    products: [
        .library(
            name: "Loaf",
            targets: ["Loaf"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Loaf",
            dependencies: []),
        .testTarget(
            name: "LoafTests",
            dependencies: ["Loaf"]),
    ]
)
