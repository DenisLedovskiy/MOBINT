//
//  UITableViewCell.swift
//  MOBINT
//
//  Created by Денис Ледовский on 14.04.2023.
//

import UIKit

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
