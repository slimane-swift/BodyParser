# BodyParser
Body Parser Middleware for Slimane


## Usage

Just register BodyParser into the middleware chains

```swift
import Slimane
import BodyParser

let app = Slimane()

app.use(BodyParser())
```

## Accessing parsed data

#### application/json

`req.json`: Zewo.JSON

```swift
app.get("/") { req, _ in
    print(req.json["user"])
}
```

#### application/x-www-form-urlencoded

`req.formData`: [String: String]

```swift
app.get("/") { req, _ in
    print(req.formData["user"])
}
```

### Package.swift
```swift
import PackageDescription

let package = Package(
	name: "SlimaneApp",
	dependencies: [
      .Package(url: "https://github.com/slimane-swift/BodyParser.git", majorVersion: 0, minor: 1)
  ]
)
```

## License

BodyParser is released under the MIT license. See LICENSE for details.
