//
//  UserAccountsViewController.swift
//  MoneyBox
//
//  Created by Nuhu Sulemana on 27/11/2023.
//

import UIKit
import Networking

class UserAccountsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    let dataProvider = DataProvider()
    // If I have access to the network protocol here, I can get the Users name, their total plan value and their different accounts data here
    
    // Thinking I will use UITableView to show the accounts and their balances on this screen
    //  I was initially thinking of using UIButtons but the TableView has a cursor to navigate to the next screen
    /* Add this code to the first view controller before navigation
         First View Controller
         The code for the First View Controller is
         import UIKit
     
         class FirstViewController: UIViewController {
     
             @IBOutlet weak var textField: UITextField!
     
             // This function is called before the segue
             override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
                 // Get a reference to the second view controller
                 let secondViewController = segue.destination as! SecondViewController
     
                 // Set a variable in the second view controller with the String to pass
                 secondViewController.receivedString = textField.text!
             }
         }
     */
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
