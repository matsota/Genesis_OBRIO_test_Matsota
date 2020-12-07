//
//  AlertWithOK.swift
//  Genesis_OBRIO_test_Matsota
//
//  Created by Andrew Matsota on 07.12.2020.
//

import UIKit

final class AlertWithOK: UIViewController, Storyboarding {
    
    //MARK: - Implementation
    public var prepareFirstEnter: (() -> Void)?
    public var configure: AlertConfiguration?

    //MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// - Preparation
        prepareFirstEnter?()
        
        /// - View
        alertView.clipsToBounds = true
        alertView.backgroundColor = .clear
        
        /// - ImageView
        xMarkImageView.tintColor = .black
        
        /// - Label
        titleLabel.text = configure?.alertTitle
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        
        bodyLabel.text = configure?.alertBody
        bodyLabel.font = UIFont.systemFont(ofSize: 24, weight: .thin)

        labelCollection.forEach { (label) in
            let dismissGesture = UITapGestureRecognizer(target: self, action: #selector(dismissByLabel(_:)))
            label.isUserInteractionEnabled = true
            label.addGestureRecognizer(dismissGesture)
        }
        
        /// - Button
        dismissButton.addBlurEffect()
    }

    //MARK: - Private Actions
    @IBAction private func dismissAction(_ sender: UIButton) {
        preventDoubleTap(sender)
        dismiss(animated: true)
    }
    
    //MARK: - Private Implementation
    
    /// - View
    @IBOutlet private weak var alertView: UIView!
    
    /// - ImageView
    @IBOutlet private weak var xMarkImageView: UIImageView!
    
    /// - Label
    @IBOutlet private weak var bodyLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private var labelCollection: [UILabel]!
    
    /// - Button
    @IBOutlet private weak var dismissButton: UIButton!
}









//MARK: - Private Methods
private extension AlertWithOK {
    
    @objc func dismissByLabel(_ gestureRecognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
}
