//
//  MainProtocol.swift
//  MOBINT
//
//  Created by Денис Ледовский on 15.04.2023.
//

import Foundation

protocol MainViewInput: AnyObject {
    var companysArray: [CompanyViewStruct] { get set }
    var footerHeight: Int { get set }
    var isLoading: Bool { get set }
    var isMorePage: Bool { get set }
    func showError(errorMessage: String)
    func reloadTable()
}

protocol MainViewOutput: AnyObject {
    func makeCompanyListRequest(currentCount: Int)
}
