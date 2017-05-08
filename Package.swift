// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "Patterns",
    targets: [
        Target(name: "PatternsApp", dependencies: ["PatternsLib"]),
        Target(name: "PatternsLib", dependencies: [])
    ], 
    dependencies: [
//        .Package(url: "https://github.com/kylef/Commander.git", majorVersion: 0)
    ]
)
