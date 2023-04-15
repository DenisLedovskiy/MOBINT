//
//  AbstractErrorParser.swift
//  MOBINT
//
//  Created by Денис Ледовский on 14.04.2023.
//

import Foundation

protocol AbstractErrorParser {

    func parse(_ result: Error, statusCode: Int) -> APIError
    func parseCustomError(_ message: String?) -> APIError
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error?
}
