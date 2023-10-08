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
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        let attributedString = NSMutableAttributedString(string: label.text!)
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
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
    
    let nextButton: Button = {
        let button = Button()
        button.setActive(false)
        button.setTitle("Далее", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let errorLabel: UILabel = {
        let label = UILabel()
        let font = UIFont(name: "GothamPro-Medium", size: 14)
        label.font = font
        label.isHidden = true
        label.text = "Данная почта уже зарегистривана"
        label.textColor = .red
        label.numberOfLines = 0
        return label
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
        emailTextField.delegate = self
        
        setNextButton()
        setTitleLabel()
        setEmailTextField()
        setErrorLabel()
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
    
    func setErrorLabel() {
        view.addSubview(errorLabel)
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(16)
            make.centerX.equalTo(emailTextField.snp.centerX)
        }
    }
}

//MARK: Functionality
extension SignupViewController: UITextFieldDelegate {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func nextButtonTapped() {
        let updatedText = emailTextField.text ?? ""
        
        let alertVC = AlertViewController()
        alertVC.emailText = updatedText
        alertVC.modalPresentationStyle = .overFullScreen
        present(alertVC, animated: false)
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text,
              let range = Range(range, in: currentText) else {
            return true
        }
        
        let updatedText = currentText.replacingCharacters(in: range, with: string)
        let isValid = isValidEmail(email: updatedText)
        nextButton.setActive(isValid)
        emailTextField.isEror(!isValid)
        
        if updatedText.isEmpty {
            errorLabel.isHidden = true
        } else {
            if isValid {
                nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
                errorLabel.isHidden = true
            } else {
                errorLabel.isHidden = false
            }
        }
        return true
    }
}
