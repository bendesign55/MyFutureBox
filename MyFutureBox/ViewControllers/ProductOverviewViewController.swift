//
//  ProductOverviewViewController.swift
//  MyFutureBox
//
//  Created by Ben Ormos on 22/04/2018.
//  Copyright © 2018 com.benormos. All rights reserved.
//

import UIKit

class ProductOverviewViewController: UIViewController {

    @IBOutlet weak var coinStackImageView: UIImageView!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var productCollectionView: UICollectionView!
    @IBOutlet weak var logOutButton: UIButton!
    
    var products = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        fetchProductInfo()
    }
    
    private func setupView() {
        
        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        
        logOutButton.roundedButton()
        
        guard let coinStackImage = coinStackImageView.image else { return }
        coinStackImageView.image = coinStackImage.withRenderingMode(.alwaysTemplate)
        coinStackImageView.tintColor = .white

    }
    
    private func fetchProductInfo() {
        APIClient().fetchWeeklyInfo { (response, error) in
            if error == nil {
                let currentWeekInfo = try? JSONDecoder().decode(CurrentWeeklyInfo.self, from: response!)
                guard let products = currentWeekInfo?.products else { return }
                self.products = products
                self.productCollectionView.reloadData()
                self.productCollectionView.reloadInputViews()
            } else {
                self.presentAlertView("Error Fetching data", message: "There was an error getting your weekly feed 😖")
            }
        }
    }
    
    private func presentAlertView(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func logoutUser(_ sender: UIButton) {
        APIClient().logoutUser { (respone, error) in
            if error == nil {
                self.navigationController?.dismiss(animated: true, completion: nil)
            } else {
                self.presentAlertView("Oopps", message: "There was a problem logging out.")
            }
        }
    }
}

extension ProductOverviewViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as? ProductCollectionViewCell else { return UICollectionViewCell() }

        cell.setupCell(products[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productVC = self.storyboard?.instantiateViewController(withIdentifier: "IndividualProductViewController") as! IndividualProductViewController
        self.navigationController?.pushViewController(productVC, animated: true)
    }
    
}
