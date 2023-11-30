//
//  HomeRowTableViewCell.swift
//  MoneyBox
//
//  Created by Nuhu Sulemana on 29/11/2023.
//

import UIKit
import Networking

class HomeRowTableViewCell: UITableViewCell {
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var planValueLabel: UILabel!
    @IBOutlet weak var moneyboxLabel: UILabel!
    static let identifier = "HomeRowTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(productResponse: ProductResponse) {
        let numberFormater = NumberFormatter()
        numberFormater.numberStyle = .currency
        numberFormater.locale = Locale(identifier: "en_GB")
        typeLabel.text = productResponse.product?.name
        if let planValue = productResponse.planValue {
            planValueLabel.text = "Plan Value: \(numberFormater.string(from: planValue as NSNumber) ?? "")"
        }
        else {
            planValueLabel.text = "Plan Value: £0"
        }
        if let moneybox = productResponse.moneybox {
            moneyboxLabel.text = "Moneybox: \(numberFormater.string(from: moneybox as NSNumber) ?? "")"
        }
        else {
            moneyboxLabel.text = "Moneybox: £0"
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
