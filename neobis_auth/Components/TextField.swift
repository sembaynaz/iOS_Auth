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
    private var placeholderLabel: UILabel = {
        let label = UILabel()
        let font = UIFont(name: "GothamPro-Medium", size: 16)
        label.font = font
        label.textColor = UIColor(named: "Grey")
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPlaceholderLabel()
        delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        placeholderLabel.text = placeholder
        placeholderLabel.sizeToFit()
        setupPlaceholderLabel()
        delegate = self
    }
    
    private func setupPlaceholderLabel() {
        addSubview(placeholderLabel)
        updatePlaceholderPosition()
    }
    
    private func updatePlaceholderPosition() {
        let placeholderY: CGFloat = isEditing ? 5 : 25
        placeholderLabel.font = UIFont(name: "GothamPro-Medium", size: 12)
        placeholderLabel.frame.origin = CGPoint(x: 10, y: placeholderY)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        updatePlaceholderPosition()
    }
}
