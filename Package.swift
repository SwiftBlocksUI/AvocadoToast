// swift-tools-version:5.1

import PackageDescription

let package = Package(
  
  name: "AvocadoToast",

  platforms: [
    .macOS(.v10_15), .iOS(.v13)
  ],
  
  products: [
    .executable(name: "AvocadoToast", targets: [ "AvocadoToast" ]),
  ],
  
  dependencies: [
    .package(url: "https://github.com/SwiftBlocksUI/SwiftBlocksUI.git",
             from: "0.9.3")
  ],
  
  targets: [
    .target(name: "AvocadoToast", dependencies: [ "SwiftBlocksUI" ])
  ]
)
