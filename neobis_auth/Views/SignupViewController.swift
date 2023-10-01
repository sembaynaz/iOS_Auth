//
//  SignupViewController.swift
//  neobis_auth
//
//  Created by Nazerke Sembay on 01.10.2023.
//

import UIKit
import SnapKit

class SignupViewController: UIViewController {
    let logoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Logo")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        let font = UIFont(name: "GothamPro-Medium", size: 40)
        label.font = font
        label.text = "Смейся \nи улыбайся \nкаждый день"
        label.textColor = UIColor(named: "Blue")
        label.numberOfLines = 0
        let lineHeight: CGFloat = 40 * 1.2
        let attributedString = NSMutableAttributedString(string: label.text ?? "")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineHeight - label.font.lineHeight
        attributedString.addAttribute(
            .paragraphStyle,
            value: paragraphStyle,
            range: NSMakeRange(0, attributedString.length)
        )
        label.attributedText = attributedString
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emailTextField: TextField = {
        let textfield = TextField()
        textfield.setPlaceholderText("Электронная почта")
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    let nextButton: ActiveButton = {
        let button = ActiveButton()
        button.setActive(false)
        button.setTitle("Далее", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
}

extension SignupViewController {
    func setup() {
        view.backgroundColor = .white
        title = "Регистрация"
        
        setNextButton()
        setTitleLabel()
        setEmailTextField()
        setLogoImage()
        hideKeyboardWhenTappedAround()
    }
    
    func setLogoImage() {
        view.addSubview(logoImage)
        logoImage.snp.makeConstraints { make in
            make.height.width.equalTo(80)
            make.right.equalTo(titleLabel.snp.right)
            make.top.equalTo(titleLabel.snp.top).offset(-20)
        }
    }
    
    func setTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(120)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
    }
    
    func setEmailTextField() {
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(60)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
    }
    
    func setNextButton() {
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.keyboardLayoutGuide.snp.top).offset(-16)
            make.height.equalTo(65)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
    }
}
//MARK: Functionality
extension SignupViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
