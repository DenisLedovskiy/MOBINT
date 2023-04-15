//
//  CompanyListRequest.swift
//  MOBINT
//
//  Created by Денис Ледовский on 14.04.2023.
//

import Foundation
import Alamofire

protocol CompanyListFactory {

    func getCompanyList(offset: Int, completionHandler: @escaping (AFDataResponse<Company>) -> Void)
}
