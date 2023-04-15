//
//  UIViewController.swift
//  MOBINT
//
//  Created by Денис Ледовский on 14.04.2023.
//

import UIKit

fileprivate var activityView: UIView?

//MARK: - Alerts
extension UIViewController {

    func setAlert(title: String, message: String) {

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }

    func setErrorAlert(message: String) {

        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}
