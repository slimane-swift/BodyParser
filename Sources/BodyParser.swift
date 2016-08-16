//
//  BodyParser.swift
//  Slimane
//
//  Created by Yuki Takei on 4/19/16.
//
//

@_exported import JSON
@_exported import HTTP

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

public struct BodyParser {
    
    public struct URLEncoded: AsyncMiddleware {
        public init(){}
        
        public func respond(to request: Request, chainingTo next: AsyncResponder, result: @escaping ((Void) throws -> Response) -> Void) {
            guard let contentType = request.contentType else {
                return next.respond(to: request, result: result)
            }
            var request = request
            
            do {
                if case .buffer(let data) = request.body {
                    switch (contentType.type, contentType.subtype) {
                    case ("application", "x-www-form-urlencoded"):
                        request.formData = try URLEncodedFormParser().parse(data: data)
                    default:
                        break
                    }
                }
            } catch {
                result {
                    throw error
                }
            }
            
            next.respond(to: request, result: result)
        }
    }
    
    public struct JSON: AsyncMiddleware {
        public init(){}
        
        public func respond(to request: Request, chainingTo next: AsyncResponder, result: @escaping ((Void) throws -> Response) -> Void) {
            guard let contentType = request.contentType else {
                return next.respond(to: request, result: result)
            }
            var request = request
            
            do {
                if case .buffer(let data) = request.body {
                    switch (contentType.type, contentType.subtype) {
                    case ("application", "json"):
                        request.json = try JSONParser().parse(data: data)
                    default:
                        break
                    }
                }
            } catch {
                result {
                    throw error
                }
            }
            
            next.respond(to: request, result: result)
        }
    }
}
