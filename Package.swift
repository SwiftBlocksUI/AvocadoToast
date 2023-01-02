// swift-tools-version:5.5

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
             from: "0.9.4")
  ],
  
  targets: [
    .executableTarget(name: "AvocadoToast", dependencies: [ "SwiftBlocksUI" ])
  ]
)
