//
//  ApiErro.swift
//  MOBINT
//
//  Created by Денис Ледовский on 14.04.2023.
//

import Foundation

struct APIError: Codable, Error {
    var message: String?
}

//struct APIErrorServer: Codable, Error {
//    var message: String?
//}

