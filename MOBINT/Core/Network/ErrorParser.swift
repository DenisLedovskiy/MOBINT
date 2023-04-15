//
//  rrorParser.swift
//  MOBINT
//
//  Created by Денис Ледовский on 14.04.2023.
//

import Foundation

class ErrorParser: AbstractErrorParser {
    func parse(_ result: Error, statusCode: Int) -> APIError {
        return APIError(message: setErrorMessage(statusCode))
    }

    func parseCustomError(_ message: String?) -> APIError {
        return APIError(message: message ?? "Ошибка работы с сетью")
    }

    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error? {
        return error
    }
}

extension ErrorParser {

    private func setErrorMessage(_ errorCode: Int) -> String {

        switch errorCode {
        case 401:
            return "Ошибка авторизации"
        case 500:
            return "Все упало"
        default:
            return "Ошибка работы с сетью. Проверьте подключение к интернету."
        }
    }
}
