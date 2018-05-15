//
//  ViewController.swift
//  MyFutureBox
//
//  Created by Ben Ormos on 22/04/2018.
//  Copyright © 2018 com.benormos. All rights reserved.
//

import UIKit
import KeychainSwift
import NVActivityIndicatorView

private let spinnerSize: CGFloat = 48.0

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var gradientLayer: CAGradientLayer!
    var loadingView = UIView()
    var loadingSpinner = NVActivityIndicatorView(frame: CGRect.zero)
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        createGradientLayer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }

    private func setupLayout() {
        loginButton.roundedButton()
        userNameTextField.roundedTextField("Username")
        passwordTextField.roundedTextField("Password")
        
        loadingView = UIView(frame: self.view.bounds)
        loadingView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        
        loadingSpinner = NVActivityIndicatorView(frame: CGRect(x: self.view.bounds.midX - spinnerSize/2, y: self.view.bounds.midY - spinnerSize/2, width: spinnerSize, height: spinnerSize) , type: .circleStrokeSpin, color: .white, padding: 0.0)
        loadingView.addSubview(loadingSpinner)
        self.view.addSubview(loadingView)
        loadingView.isHidden = true
    }
    
    private func createGradientLayer() {
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.lightGray.cgColor]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func navigateToLoggedInPage() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "loginSegue", sender: self)
//            self.clearTextFields()
        }
    }

    @IBAction func loginUser(_ sender: UIButton) {
        
        if let username = userNameTextField.text, let password = passwordTextField.text {
            
            if isEmailValid(username) && isPasswordValid(password) {
                self.startLoading()
                APIClient().loginUser(username, password: password, completion: { (response, error) in
                    self.stopLoading()
                    if error == nil {
                        
                        do {
                            let json = try JSONSerialization.jsonObject(with: response!) as! [String: Any]
                            
                            if let session = json["Session"] as? [String: Any] {
                                if let bearerToken = session["BearerToken"] as? String {
                                    KeychainSwift.setAuthToken(bearerToken)
                                    self.navigateToLoggedInPage()
                                }
                            }
                        } catch let error as NSError {
                            print("Failed to load: \(error.localizedDescription)")
                        }
                    } else {
                        self.presentAlertView("Login Error", message: "There were some issues logging you in")
                    }
                })
            } else {
                self.presentAlertView("Wrong credentials", message: "Please make sure you provide the correct login details")
            }
        }
    }
    
    private func startLoading() {
        
        UIView.animate(withDuration: 0.3) {
            self.loadingView.isHidden = false
        }
        loadingSpinner.startAnimating()
    }
    
    private func stopLoading() {
        DispatchQueue.main.async {
            self.loadingView.isHidden = true
            self.loadingSpinner.stopAnimating()
        }
    }
    
    private func clearTextFields() {
        userNameTextField.text = nil
        passwordTextField.text = nil
    }
    
    private func isEmailValid(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    private func isPasswordValid(_ password: String) -> Bool {
        return (password.count < 6) ? false : true
    }
    
    private func presentAlertView(_ title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    deinit {
        self.loadingView.removeFromSuperview()
    }
}


