import PackageDescription

let package = Package(
	name: "BodyParser",
	dependencies: [
      .Package(url: "https://github.com/slimane-swift/Middleware.git", majorVersion: 0, minor: 3),
      .Package(url: "https://github.com/slimane-swift/JSON.git", majorVersion: 0, minor: 7)
  ]
)
