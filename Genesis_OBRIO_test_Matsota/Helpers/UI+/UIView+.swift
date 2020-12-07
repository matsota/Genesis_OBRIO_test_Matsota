//
//  UIView+.swift
//  Genesis_OBRIO_test_Matsota
//
//  Created by Andrew Matsota on 07.12.2020.
//

import UIKit

//MARK: - Blur
extension UIView {
    
    func addBlurEffect() {
        var blur = UIVisualEffectView(frame: .zero)
        blur = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
        blur.frame = self.bounds
        blur.isUserInteractionEnabled = false
        self.insertSubview(blur, at: 0)
    }
    
}
