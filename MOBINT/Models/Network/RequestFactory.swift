//
//  RequestBuilder.swift
//  MOBINT
//
//  Created by Денис Ледовский on 14.04.2023.
//

import Foundation
import Alamofire

class RequestFactory {

    func makeErrorParser() -> AbstractErrorParser {
        return ErrorParser()
    }

    lazy var commonSession: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let manager = Session(configuration: configuration)
        return manager
    }()

    let sessionQueue = DispatchQueue.global(qos: .utility)

    func makeCompanyListRequestFatory() -> CompanyListFactory {
        let errorParser = makeErrorParser()
        return CompanyListRequest(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
}

