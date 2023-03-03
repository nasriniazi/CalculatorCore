// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CalculatorCore",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "CalculatorCore",
            targets: ["CalculatorCore"]),
    ],
    dependencies: [
        .package(url: "https://github.com/nasriniazi/LogManager.git", branch: "main") ,.package(url:"https://github.com/ReactiveX/RxSwift.git", .exact("6.5.0") )  ],
    targets: [
        .target(
            name: "CalculatorCore",
            dependencies: [.product(name: "LogManager", package: "LogManager"),.product(name: "RxSwift", package: "RxSwift"),.product(name: "RxCocoa", package: "RxSwift")]),
        .testTarget(
            name: "CalculatorCoreTests",
            dependencies: ["CalculatorCore"]),
    ]
)
