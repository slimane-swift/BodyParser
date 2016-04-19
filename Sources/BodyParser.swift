//
//  BodyParser.swift
//  Slimane
//
//  Created by Yuki Takei on 4/19/16.
//
//

@_exported import Middleware
@_exported import JSON
@_exported import S4
@_exported import C7

extension Request {
    public var json: JSON? {
        get {
            return self.storage["jsonBody"] as? JSON
        }

        set {
            self.storage["jsonBody"] = newValue
        }
    }

    public var formData: URLEncodedForm? {
        get {
            return self.storage["formData"] as? URLEncodedForm
        }

        set {
            self.storage["formData"] = newValue
        }
    }
}

public struct BodyParser: MiddlewareType {
    public func respond(req: Request, res: Response, next: MiddlewareChain) {
        var req = req
        guard let contentType = req.contentType else {
            return next(.Chain(req, res))
        }

        do {
            switch (contentType.type, contentType.subtype) {
                case ("application", "json"):
                    req.json = try JSONParser().parse(req.body.becomeBuffer())
                case ("application", "x-www-form-urlencoded"):
                    try URLEncodedFormParser().parse(req.body.becomeBuffer())
                default:
                    print("Unkown Content-Type.")
            }
        } catch {
            return next(.Error(error))
        }

        next(.Chain(req, res))
    }
}
