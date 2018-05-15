//
//  IndividualProductViewController.swift
//  MyFutureBox
//
//  Created by Ben Ormos on 23/04/2018.
//  Copyright © 2018 com.benormos. All rights reserved.
//

import UIKit

class IndividualProductViewController: UIViewController {
    
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var addAmountButton: UIButton!
    
    var product: Product?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        addAmountButton.roundedButton()
        
        guard let product = product else { return }
        productTitleLabel.text = product.productFriendlyName
    }

    @IBAction func addToCurrentMoneybox(_ sender: UIButton) {
        guard let product = product else { return }
        APIClient().addAmountToProduct(product.investorProductId) { (response, error) in
            if error == nil {
                self.presentAlertView("Success ⭐️", message: "You have successfully contributed to your future savings. Well done!")
            } else {
                self.presentAlertView("Connection Issue", message: "There was a connection issue while trying to add your payment. Please come back later.")
            }
        }
    }
    
    private func presentAlertView(_ title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
