//
//  MainViewPresenter.swift
//  MOBINT
//
//  Created by Денис Ледовский on 15.04.2023.
//

import Foundation
import Alamofire

final class MainViewPresenter {

    weak var viewInput: (UIViewController & MainViewInput)?

    private var requestFactory = RequestFactory()

    private func makeCompanyArray(_ companys: Company) -> [CompanyViewStruct] {
        var companyArray = [CompanyViewStruct]()

        companys.forEach({ company in
            let newCompany = CompanyViewStruct(id: company.company.companyID,
                                               titleCompany: company.mobileAppDashboard.companyName,
                                               urlLogo: company.mobileAppDashboard.logo,
                                               score: company.customerMarkParameters.mark,
                                               cashback: company.customerMarkParameters.loyaltyLevel.cashToMark.description,
                                               level: company.customerMarkParameters.loyaltyLevel.name)
            companyArray.append(newCompany)
        })
        return companyArray
    }

    internal func getCompanyList(currentCount: Int) {
        let companyList = requestFactory.makeCompanyListRequestFatory()
        companyList.getCompanyList(offset: currentCount) {
            response in
            self.viewInput?.isLoading = false
            switch response.result {
            case .success(let result):
                if result.isEmpty {
                    self.viewInput?.isMorePage = false
                    self.viewInput?.footerHeight = 0
                    self.viewInput?.reloadTable()
                } else {
                    if self.viewInput?.companysArray.count == 0 {
                        self.viewInput?.companysArray = self.makeCompanyArray(result)
                    } else {
                        self.viewInput?.companysArray += self.makeCompanyArray(result)
                    }
                }
            case .failure(let error):
                if let customError = error.underlyingError as? APIError {
                    DispatchQueue.main.async {
                        self.viewInput?.showError(errorMessage: customError.message ?? "Ошибка сети")
                    }
                } else {
                    DispatchQueue.main.async {
                        self.viewInput?.showError(errorMessage: "Ошибка сети")
                    }
                    print(error)
                }
            }
        }
    }
}

extension MainViewPresenter: MainViewOutput {

    func makeCompanyListRequest(currentCount: Int) {
        self.getCompanyList(currentCount: currentCount)
    }
}

