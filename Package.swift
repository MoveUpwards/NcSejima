// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "NcSejima",
    platforms: [
        .iOS(.v10),
    ],
    products: [
        .library(
            name: "NcSejima",
            targets: ["NcSejima"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "NcSejima",
            dependencies: [],
            path: "Sources"
        ),
        .testTarget(
            name: "NcSejimaTests",
            dependencies: [],
            path: "Tests"
        ),
    ]
)
