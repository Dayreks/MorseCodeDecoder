//
//  UIButton.swift
//  MorseCodeDecoder
//
//  Created by Bohdan Arkhypchuk on 19.02.2023.
//

import UIKit

class Button: UIButton {
    
    private let textColor: UIColor
    private let buttonColor: UIColor
    private let title: String
    
    init(textColor: UIColor, buttonColor: UIColor, title: String) {
        self.textColor = textColor
        self.buttonColor = buttonColor
        self.title = title
        super.init(frame: .zero)
        
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        self.setTitle(title, for: .normal)
        self.titleLabel?.textAlignment = .center
        self.backgroundColor = self.buttonColor
        self.setTitleColor(textColor, for: .normal)
    }
    
}
