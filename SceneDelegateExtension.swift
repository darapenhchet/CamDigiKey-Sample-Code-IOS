//
//  SceneDelegateExtension.swift
//  SampleCamDigiKeyClient
//
//  Created by Techo Startup Center on 2022/02/22.
//

import UIKit
import CamDigiKeyClient

extension SceneDelegate {
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        let rootVC = window?.rootViewController
        if let awaitingVC = rootVC?.presentedViewController as? CamDigiKeyAwaitingAuthorizationViewController {
            if let urlContext = URLContexts.first, let host = urlContext.url.host, host == "camdigikey_login_callback" {
                let data = URLComponents(url: urlContext.url, resolvingAgainstBaseURL: false)?.queryItems?.first
                if data?.name == "authToken" {
                    awaitingVC.dismiss(animated: true) {
                        if let authToken = data?.value {
                            awaitingVC.delegate?.didAuthorizedLoginRequest(authToken: authToken)
                        } else {
                            awaitingVC.delegate?.didFailAuthorizedLoginRequest(message: "No Auth Token")
                        }
                    }
                } else {
                    awaitingVC.dismiss(animated: true) {
                        awaitingVC.delegate?.didFailAuthorizedLoginRequest(message: data?.value ?? "no errorMessage")
                    }
                }
            }
        } else {
            let alert = UIAlertController(title: "Login Failed", message: "Login Request Has Been Canceled! Please Try Again", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                rootVC?.dismiss(animated: true, completion: nil)
            })
            rootVC?.present(alert, animated: true, completion: nil)
        }
    }
}