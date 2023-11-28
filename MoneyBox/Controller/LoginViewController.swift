//
//  LoginViewController.swift
//  MoneyBox
//
//  Created by Zeynep Kara on 16.01.2022.
//

import UIKit
import Networking

class LoginViewController: UIViewController {
    // Design Login
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
//    override func viewDidLoad() {
//        view.backgroundColor = .blue
//
//    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        guard let email = emailTextField.text,
            !email.isEmpty else {
            showAlert(title: "Invalid Email", message: "Email or Username cannot be empty")
            return
        }
        guard let password = passwordTextField.text,
            !password.isEmpty else {
            showAlert(title: "Invalid Password", message: "Password cannot be empty")
            return
        }
        
        let dataProvider = DataProvider()
        dataProvider.login(request: LoginRequest(email: email, password: password)) { result in
            switch result {
            case .success(let success):
                let user = success.user
                let session = success.session
                DispatchQueue.main.async {
                    self.showAlert(title: "Login Success", message: "Welcome!!")
                }
                // Add segue to take user to their Accounts page when login is successful
                self.performSegue(withIdentifier: "goToAccScreen", sender: self)
                
            case .failure(let failure):
                let errorMessage = failure.localizedDescription
                DispatchQueue.main.async {
                    self.showAlert(title: "Login Failed", message: errorMessage)
                }
            }
        }

    }
}

////MARK: - Code to show alert when logging into app.
//
//extension UIViewController {
//
//    func showAlert(title: String, message: String) {
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "Ok", style: .default)
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
//        alert.addAction(okAction)
//        alert.addAction(cancelAction)
//        present(alert, animated: true)
//    }
//}
