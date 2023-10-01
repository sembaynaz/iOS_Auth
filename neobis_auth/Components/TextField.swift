//
//  TextField.swift
//  neobis_auth
//
//  Created by Nazerke Sembay on 01.10.2023.
//

import Foundation
import UIKit

class TextField: UITextField, UITextFieldDelegate {
    private var placeholderLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTextField()
    }
    
    private func setupTextField() {
        backgroundColor = UIColor(named: "GreyLight")
        layer.cornerRadius = 8
        font = UIFont(name: "GothamPro-Medium", size: 16)
        
        placeholderLabel = UILabel()
        placeholderLabel.numberOfLines = 0
        placeholderLabel.text = "Введите текст             "
        placeholderLabel.font = UIFont(name: "GothamPro", size: 16)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.sizeToFit()
        placeholderLabel.frame.origin = CGPoint(x: 10, y: 25)
        addSubview(placeholderLabel)
        
        addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, !text.isEmpty {
            UIView.animate(withDuration: 0.3) {
                self.placeholderLabel.frame.origin = CGPoint(x: 10, y: 13)
                self.placeholderLabel.font = UIFont(name: "GothamPro", size: 12)
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.placeholderLabel.font = UIFont(name: "GothamPro", size: 16)
                self.placeholderLabel.frame.origin = CGPoint(x: 10, y: 25)
            }
        }
    }
    
    func setPlaceholderText(_ text: String) {
        placeholderLabel.text = text
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 32, left: 10, bottom: 9, right: 10))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 32, left: 10, bottom: 9, right: 10))
    }
}

