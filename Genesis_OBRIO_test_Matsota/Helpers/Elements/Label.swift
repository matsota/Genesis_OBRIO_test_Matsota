//
//  Label.swift
//  Genesis_OBRIO_test_Matsota
//
//  Created by Andrew Matsota on 07.12.2020.
//

import UIKit

class TitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupAppearance()
    }
    
    private func setupAppearance() {
        self.numberOfLines = 0
        self.minimumScaleFactor = 0.6
        self.textAlignment  = .center
        self.adjustsFontSizeToFitWidth = true
        self.font = UIFont.systemFont(ofSize: 30, weight: .thin)
    }
    
}

class TextLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupAppearance()
    }
    
    private func setupAppearance() {
        self.numberOfLines = 2
        self.minimumScaleFactor = 0.6
        self.adjustsFontSizeToFitWidth = true
        self.font = UIFont.systemFont(ofSize: 14, weight: .thin)
    }
    
}
