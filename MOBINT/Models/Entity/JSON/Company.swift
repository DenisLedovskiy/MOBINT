//
//  CompanyJSON.swift
//  MOBINT
//
//  Created by Денис Ледовский on 14.04.2023.
//

import Foundation

typealias Company = [CompanyElement]

// MARK: - CompanyElement
struct CompanyElement: Codable {
    let company: CompanyClass
    let customerMarkParameters: CustomerMarkParameters
    let mobileAppDashboard: MobileAppDashboard
}

// MARK: - CompanyClass
struct CompanyClass: Codable {
    let companyID: String

    enum CodingKeys: String, CodingKey {
        case companyID = "companyId"
    }
}

// MARK: - CustomerMarkParameters
struct CustomerMarkParameters: Codable {
    let loyaltyLevel: LoyaltyLevel
    let mark: Int
}

// MARK: - LoyaltyLevel
struct LoyaltyLevel: Codable {
    let number: Int
    let name: String
    let requiredSum, markToCash, cashToMark: Int
}

// MARK: - MobileAppDashboard
struct MobileAppDashboard: Codable {
    let companyName: String
    let logo: String
    let backgroundColor, mainColor, cardBackgroundColor, textColor: String
    let highlightTextColor, accentColor: String
}
