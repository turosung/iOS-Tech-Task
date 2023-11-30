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
    
    
    @IBAction func loginPressed(_ sender: UIButton) {
        guard let email = emailTextField.text,
            !email.isEmpty else {
            showErrorAlert(title: "Invalid Email", message: "Email or Username cannot be empty")
            return
        }
        guard let password = passwordTextField.text,
            !password.isEmpty else {
            showErrorAlert(title: "Invalid Password", message: "Password cannot be empty")
            return
        }

        let dataProvider = DataProvider()
        dataProvider.login(request: LoginRequest(email: email, password: password)) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let success):
                let user = success.user
                let session = success.session
                Authentication.token = session.bearerToken
                SessionService.shared.user = UserModel(firstName: user.firstName, lastName: user.lastName)
                let homeStoryboard = UIStoryboard(name: "Home", bundle: nil)
                let homeViewController = homeStoryboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                let navVC = UINavigationController(rootViewController: homeViewController)
                if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window {
                    DispatchQueue.main.async {
                        window.rootViewController = navVC
                    }
                }
            case .failure(let failure):
                let errorMessage = failure.localizedDescription
                DispatchQueue.main.async {
                    strongSelf.showErrorAlert(title: "Login Failed", message: errorMessage)
                }
            }
        }

    }
}
