//
//  Extension+UIViewController.swift
//  MoneyBox
//
//  Created by Nuhu Sulemana on 27/11/2023.
//

import Foundation
import UIKit

extension UIViewController {

    func showErrorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
