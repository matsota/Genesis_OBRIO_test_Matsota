//
//  UIVC+.swift
//  Genesis_OBRIO_test_Matsota
//
//  Created by Andrew Matsota on 07.12.2020.
//

import UIKit


//MARK: Keyboard
extension UIViewController {
    
    @objc func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tap.cancelsTouchesInView = true
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
    
}

//MARK: - Button
extension UIViewController {
    
    func preventDoubleTap(_ sender: UIButton) {
        sender.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            sender.isUserInteractionEnabled = true
        }
    }
    
}
