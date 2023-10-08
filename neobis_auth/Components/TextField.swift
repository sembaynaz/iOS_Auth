//
//  TextField.swift
//  neobis_auth
//
//  Created by Nazerke Sembay on 01.10.2023.
//

import Foundation
import UIKit
import SnapKit

class TextField: UITextField, UITextFieldDelegate {
    private var placeholderLabel: UILabel!
    private var isError: Bool = false
    private var isPassword: Bool = false
    
    private let showPasswordButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "Secure"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
        setupTextFieldPlaceholder()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTextField()
        setupTextFieldPlaceholder()
    }
    
    private func setupTextFieldPlaceholder() {
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
    
    private func setupTextField() {
        backgroundColor = UIColor(named: "GreyLight")
        layer.cornerRadius = 8
        font = UIFont(name: "GothamPro-Medium", size: 16)
        layer.borderWidth = 1
        layer.borderColor = isError ? UIColor.red.cgColor : UIColor(named: "GreyLight")?.cgColor 
        textColor = isError ? .red : .black
        
        if isPassword {
            textContentType = .password
            isSecureTextEntry = true
            isUserInteractionEnabled = true
            addSubview(showPasswordButton)
            showPasswordButton.addTarget(
                self,
                action: #selector(showPasswordButtonTapped),
                for: .touchUpInside
            )
            
            showPasswordButton.snp.makeConstraints { make in
                make.height.width.equalTo(40)
                make.right.equalTo(-10)
                make.top.equalTo(20)
            }
        }
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, !text.isEmpty {
            UIView.animate(withDuration: 0.3) {
                self.placeholderLabel.frame.origin = CGPoint(x: 10, y: 13)
                self.placeholderLabel.font = UIFont(name: "GothamPro", size: 12)
                self.showPasswordButton.isHidden = false
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.placeholderLabel.font = UIFont(name: "GothamPro", size: 16)
                self.placeholderLabel.frame.origin = CGPoint(x: 10, y: 25)
                self.isError = false
                self.showPasswordButton.isHidden = true
                self.setupTextField()
            }
        }
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 32, left: 10, bottom: 9, right: 50))
    }
    
    override func editingRect (forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 32, left: 10, bottom: 9, right: 50))
    }
}

extension TextField {
    func setPlaceholderText (_ text: String) {
        placeholderLabel.text = text
    }
    
    func isEror (_ isError: Bool) {
        self.isError = isError
        setupTextField()
    }
    
    func setTextToTextField (_ text: String) {
        self.text = text
        textFieldDidChange(self)
    }
    
    func setPasswordTextField (_ isPassword: Bool) {
        self.isPassword  = isPassword
        setupTextField()
        textFieldDidChange(self)
    }
    
    @objc func showPasswordButtonTapped () {
        isSecureTextEntry.toggle()
        let imageName = isSecureTextEntry ? "Secure" : "Show"
        showPasswordButton.setImage(UIImage(named: imageName), for: .normal)
    }
}

