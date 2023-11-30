//
//  ProductDetailViewController.swift
//  MoneyBox
//
//  Created by Nuhu Sulemana on 30/11/2023.
//

import UIKit
import Networking

class ProductDetailViewController: UIViewController {
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var planValueLabel: UILabel!
    @IBOutlet weak var moneyboxLabel: UILabel!
    var product: ProductResponse?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let product = product else { return }
            productNameLabel.text = product.product?.name
            let numberFormater = NumberFormatter()
            numberFormater.numberStyle = .currency
            numberFormater.locale = Locale(identifier: "en_GB")
        if let planValue = product.planValue {
            planValueLabel.text = "Plan Value: \(numberFormater.string(from: planValue as NSNumber) ?? "")"
        }
        else {
            planValueLabel.text = "Plan Value: £0"
        }
        
        if let moneybox = product.moneybox {
            moneyboxLabel.text = "Moneybox: \(numberFormater.string(from: moneybox as NSNumber) ?? "")"
        }
        else {
            moneyboxLabel.text = "Moneybox: £0"
        }
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        guard let investorProductID = product?.id else {
            showErrorAlert(title: "Error", message: "Cannot Add to moneybox right now!")
            return}
        let dataProvider = DataProvider()
        dataProvider.addMoney(request: OneOffPaymentRequest(amount: 10, investorProductID: investorProductID)) {[weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(_):
                let alert = UIAlertController(title: "Success", message: "£10 was added to your moneybox", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
                    alert.dismiss(animated: true) {
                        strongSelf.navigationController?.popToRootViewController(animated: true)
                    }
                }
                alert.addAction(okAction)
                DispatchQueue.main.async {
                    strongSelf.present(alert, animated: true)
                }
            case .failure(let failure):
                let errorMessage = failure.localizedDescription
                DispatchQueue.main.async {
                    strongSelf.showErrorAlert(title: "Error", message: errorMessage)
                }
            }
        }
    }
}
