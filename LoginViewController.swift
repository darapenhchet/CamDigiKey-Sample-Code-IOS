//
//  LoginViewController.swift
//  SampleCamDigiKeyClient
//
//  Created by Techo Startup Center on 2022/02/22.
//

import UIKit
import CamDigiKeyClient

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Add Your Logic
    }
    
    @IBAction func loginButtonClick(_ sender: UIButton) {
        // MARK : Step 1. Add Your Logic to request `loginToken` from Client API Server
        let loginToken = "<LOGIN_TOKEN_RESPONDED_FROM_CLIENT_API_SERVER>"
        // MARK : Step 2. Generate Login Request with `loginToken` to CamDigiKey App 
        CamDigiKeyClient.default.loginWithCamDigiKey(viewController: self, delegate: self, loginToken: loginToken)
    }
    
}

extension LoginViewController: CamDigiKeyClientDelegate {
    // MARK : 3. Request for `access_token` with `auth_token` from Client API Server
    func didAuthorizedLoginRequest(authToken: String) {
        print("Login success, authToken: \(authToken)")
        // MARK : Step 3. Add Your Logic to request for `accessToken` with `authToken` from Client API Server
        // MARK : Step 4. Add Your Logic to request for user information with `accessToken` from Client API Server
    }
    
    func didFailAuthorizedLoginRequest(message: String) {
        print("Login failed, message: \(message)")
    }
    
}