//
//  ChangePasswordViewController.swift
//  neobis_auth
//
//  Created by Nazerke Sembay on 01.10.2023.
//

import UIKit
import SnapKit

class ChangePasswordViewController: UIViewController {
    
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
    let signupButton: ActiveButton = {
        let button = ActiveButton()
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
    let casePasswordsMathesLabel: UILabel = {
        let label = UILabel()
        let font = UIFont(name: "GothamPro-Medium", size: 16)
        label.font = font
        label.text = "● Совпадение пароля"
        label.textColor = UIColor(named: "Grey")
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    @objc var nextButton: ActiveButton = {
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

extension ChangePasswordViewController {
    func setup() {
        view.backgroundColor = .white
        title = "Создать пароль"
        setFirstPasswordTextField()
        setSecondPasswordTextField()
        setStackCaseLabels()
        setNextButton()
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
        stackCaseLabels.addArrangedSubview(casePasswordsMathesLabel)
        
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

extension ChangePasswordViewController {
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
        
        if let text = secondPasswordTextField.text, text == firstPasswordTextField.text {
            casePasswordsMathesLabel.textColor = UIColor(named: "Blue")
            count += 1
        } else {
            casePasswordsMathesLabel.textColor = UIColor(named: "Grey")
        }
        
        if count == 4 {
            nextButton.setActive(true)
        } else {
            nextButton.setActive(false)
        }
    }
}
