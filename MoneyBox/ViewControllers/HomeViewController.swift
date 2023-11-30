//
//  HomeViewController.swift
//  MoneyBox
//
//  Created by Nuhu Sulemana on 29/11/2023.
//

import UIKit
import Networking

class HomeViewController: UIViewController {
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var totalPlanValueLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var products:[ProductResponse] = []
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowProductDetailSegue" {
            let destinationVC = segue.destination as! ProductDetailViewController
            let product = sender as! ProductResponse
            destinationVC.product = product
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        if let firstName = SessionService.shared.user?.firstName {
            greetingLabel.text = "Hello, \(firstName)!"
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchProducts()

    }
    
    private func fetchProducts() {
        let dataProvider = DataProvider()
        dataProvider.fetchProducts { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let success):
                if let products = success.productResponses {
                    strongSelf.products = products
                    let totalPlanValue = products.reduce(0) { $0 + ($1.planValue ?? 0) }
                    let numberFormater = NumberFormatter()
                    numberFormater.numberStyle = .currency
                    numberFormater.locale = Locale(identifier: "en_GB")
                    DispatchQueue.main.async {
                        strongSelf.tableView.reloadData()
                        strongSelf.totalPlanValueLabel.text = "Total Plan Value: \(numberFormater.string(from: totalPlanValue as NSNumber) ?? "")"
                    }
                }
            case .failure(let failure):
                let errorMessage = failure.localizedDescription
                DispatchQueue.main.async {
                    strongSelf.showErrorAlert(title: "Fetch Products Failed", message: errorMessage)
                }
            }
        }
        
    }
    
    

}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeRowTableViewCell.identifier, for: indexPath) as! HomeRowTableViewCell
        cell.configure(productResponse: products[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120 
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = products[indexPath.row]
        performSegue(withIdentifier: "ShowProductDetailSegue", sender: product)
    }
    
}
