// URLEncodedFormParser.swift
//
// The MIT License (MIT)
//
// Copyright (c) 2015 Zewo
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

@_exported import C7
@_exported import String

enum URLEncodedFormParseError: ErrorProtocol {
    case unsupportedEncoding
    case malformedURLEncodedForm
}

public struct URLEncodedFormParser {
    public init() {}

    public func parse(data: Data) throws -> URLEncodedForm {
        guard let string = try? String(data: data) else {
            throw URLEncodedFormParseError.unsupportedEncoding
        }

        var urlEncodedForm: URLEncodedForm = [:]

        for parameter in string.split("&") {
            let tokens = parameter.split("=")

            if tokens.count == 2 {
                let key = try String(percentEncoded: tokens[0])
                let value = try String(percentEncoded: tokens[1])

                urlEncodedForm[key] = value
            } else {
                throw URLEncodedFormParseError.malformedURLEncodedForm
            }
        }

        return urlEncodedForm
    }
}
