//
//  Button.swift
//  neobis_auth
//
//  Created by Nazerke Sembay on 01.10.2023.
//

import Foundation
import UIKit

class Button: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        custumize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        custumize()
    }
    
}

private extension Button {
    func custumize() {
        backgroundColor = UIColor(named: "Blue")
        layer.cornerRadius = 12
        
        titleLabel?.font = UIFont(name: "GothamPro-Bold", size: 16)
    }
}
