//
//  Button.swift
//  neobis_auth
//
//  Created by Nazerke Sembay on 01.10.2023.
//

import Foundation
import UIKit

class ActiveButton: UIButton {
    var isActive: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        custumize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        custumize()
    }
    
    func custumize() {
        let font = UIFont(name: "GothamPro-Bold", size: 16)
        titleLabel?.font = font
        layer.cornerRadius = 16
        backgroundColor = isActive ? UIColor(named: "Blue") : UIColor(named: "GreyLight")
        setTitleColor(
            isActive ? .white :
                UIColor(
                    red: 156/255,
                    green: 164/255,
                    blue: 171/255,
                    alpha: 1
                ),
            for: .normal
        )
    }
    
    func setActive(_ isActive: Bool) {
        self.isActive = isActive
        custumize()
    }
}
