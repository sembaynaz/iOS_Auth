//
//  ChangePasswordViewController.swift
//  neobis_auth
//
//  Created by Nazerke Sembay on 01.10.2023.
//

import UIKit
import SnapKit
import UserNotifications

class CreateChangePasswordViewController: UIViewController {
    var isPasswordChange = false
    
    var firstPasswordTextField: TextField = {
       let textField = TextField()
        textField.setPlaceholderText("Придумайте пароль")
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setPasswordTextField(true)
        return textField
    }()
    var secondPasswordTextField: TextField = {
        let textField = TextField()
        textField.setPlaceholderText("Повторите пароль")
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setPasswordTextField(true)
        return textField
    }()
    let signupButton: Button = {
        let button = Button()
        button.setActive(false)
        button.setTitle("Далее", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let stackCaseLabels: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    let caseUpperCharacterLabel: UILabel = {
        let label = UILabel()
        let font = UIFont(name: "GothamPro-Medium", size: 16)
        label.font = font
        label.text = "● Заглавная буква"
        label.textColor = UIColor(named: "Grey")
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let caseDigitsCharacterLabel: UILabel = {
        let label = UILabel()
        let font = UIFont(name: "GothamPro-Medium", size: 16)
        label.font = font
        label.text = "● Цифры"
        label.textColor = UIColor(named: "Grey")
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let caseSymbolLabel: UILabel = {
        let label = UILabel()
        let font = UIFont(name: "GothamPro-Medium", size: 16)
        label.font = font
        label.text = "● Специальные символы"
        label.textColor = UIColor(named: "Grey")
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let casePasswordsMachesLabel: UILabel = {
        let label = UILabel()
        let font = UIFont(name: "GothamPro-Medium", size: 16)
        label.font = font
        label.text = "● Совпадение пароля"
        label.textColor = UIColor(named: "Grey")
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    @objc var nextButton: Button = {
        let button = Button()
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

extension CreateChangePasswordViewController {
    func setup() {
        view.backgroundColor = .white
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        setFirstPasswordTextField()
        setSecondPasswordTextField()
        setStackCaseLabels()
        setNextButton()
        hideKeyboardWhenTappedAround()
    }
    func setFirstPasswordTextField () {
        view.addSubview(firstPasswordTextField)
        firstPasswordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        firstPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
    }
    func setSecondPasswordTextField () {
        view.addSubview(secondPasswordTextField)
        secondPasswordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        secondPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(firstPasswordTextField.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
    }
    func setStackCaseLabels () {
        view.addSubview(stackCaseLabels)
        
        stackCaseLabels.addArrangedSubview(caseUpperCharacterLabel)
        stackCaseLabels.addArrangedSubview(caseDigitsCharacterLabel)
        stackCaseLabels.addArrangedSubview(caseSymbolLabel)
        stackCaseLabels.addArrangedSubview(casePasswordsMachesLabel)
        
        stackCaseLabels.snp.makeConstraints { make in
            make.top.equalTo(secondPasswordTextField.snp.bottom).offset(40)
            make.horizontalEdges.equalToSuperview().inset(20)
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

extension CreateChangePasswordViewController {
    @objc private func textFieldDidChange(_ textField: UITextField) {
        var count = 0
        
        if let text = firstPasswordTextField.text {
            if text.contains(where: { $0.isUppercase }) {
                caseUpperCharacterLabel.textColor = UIColor(named: "Blue")
                count += 1
            } else {
                caseUpperCharacterLabel.textColor = UIColor(named: "Grey")
            }
            
            if text.contains(where: { $0.isNumber }) {
                caseDigitsCharacterLabel.textColor = UIColor(named: "Blue")
                count += 1
            } else {
                caseDigitsCharacterLabel.textColor = UIColor(named: "Grey")
            }
            
            let specialCharacters = "!@#$%^&*()_+"
            if text.contains(where: { specialCharacters.contains($0) }) {
                caseSymbolLabel.textColor = UIColor(named: "Blue")
                count += 1
            } else {
                caseSymbolLabel.textColor = UIColor(named: "Grey")
            }
        }
        
        if let text = secondPasswordTextField.text, text == firstPasswordTextField.text &&
            (!secondPasswordTextField.text!.isEmpty && !firstPasswordTextField.text!.isEmpty) {
            
            casePasswordsMachesLabel.textColor = UIColor(named: "Blue")
            count += 1
        } else {
            casePasswordsMachesLabel.textColor = UIColor(named: "Grey")
        }
        
        if count == 4 {
            nextButton.setActive(true)
            nextButton.addTarget(
                self,
                action: #selector(nextButtonTapped),
                for: .touchUpInside
            )
        } else {
            nextButton.setActive(false)
        }
    }
    
    @objc func nextButtonTapped() {
        let splashVC = SplashViewController()
        splashVC.modalPresentationStyle = .fullScreen
        if isPasswordChange {
            splashVC.isPasswordChanged = true
        }
        self.view.window?.rootViewController = UINavigationController(rootViewController: splashVC)
        self.view.window?.makeKeyAndVisible()
    }
}

extension CreateChangePasswordViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
/*
 
 */
