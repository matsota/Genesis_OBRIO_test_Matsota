//
//  UIRouter.swift
//  Genesis_OBRIO_test_Matsota
//
//  Created by Andrew Matsota on 07.12.2020.
//

import UIKit

class UIRouter {
    
    //MARK: - Implementation
    public static var instance: UIRouter!
    
    //MARK: - Init
    init() {
        
        mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        UIRouter.instance = self
    }
    
    private var mainStoryboard: UIStoryboard!
}









//MARK: - Main Storyboard
extension UIRouter {
    
    public func showWebView(_ parent: UIViewController,
                            _ url: URL) {
        let vc = WebViewViewController.instantiate(from: mainStoryboard)
        
        vc.url = url
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        
        parent.navigationController?.pushViewController(vc, animated: true)
    }
    
}

//MARK: - Alert Storyboard
extension UIRouter {
    
    public func presentAlert(_ parent: UIViewController,
                             configure: AlertConfiguration, onDidDismiss: (() -> Void)? = nil) {
        let storyboard = UIStoryboard(name: "Alerts", bundle: nil)
        let vc = AlertWithOK.instantiate(from: storyboard)
        
        vc.configure = configure
        vc.prepareFirstEnter = onDidDismiss
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        
        parent.present(vc, animated: true)
    }
    
}
