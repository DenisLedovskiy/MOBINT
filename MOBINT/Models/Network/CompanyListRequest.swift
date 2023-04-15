//
//  CompanyListRequest.swift
//  MOBINT
//
//  Created by Денис Ледовский on 14.04.2023.
//

import Foundation
import Alamofire

class CompanyListRequest: AbstractRequestFactory {

    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl = Network.baseUrl

    init(
        errorParser: AbstractErrorParser,
        sessionManager: Session,
        queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
            self.errorParser = errorParser
            self.sessionManager = sessionManager
            self.queue = queue
        }
}

extension CompanyListRequest: CompanyListFactory {

    func getCompanyList(offset: Int, completionHandler: @escaping (Alamofire.AFDataResponse<Company>) -> Void) {
        guard let url = baseUrl else {return}
        let requestModel = CompanyListStruct(baseUrl: url, encoding: .json,  offset: offset, headers: [
            "TOKEN":"123"
        ])
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension CompanyListRequest {

    struct CompanyListStruct: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "/getAllCompanies"
        let encoding: RequestRouterEncoding
        let offset: Int
        let headers: HTTPHeaders
        var parameters: Parameters? {
            return [ "offset" : offset ]
        }
    }
}

