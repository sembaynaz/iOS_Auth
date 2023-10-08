//
//  UserInfoViewController.swift
//  neobis_auth
//
//  Created by Nazerke Sembay on 01.10.2023.
//

import UIKit
import SnapKit

class UserInfoViewController: UIViewController {
    var user = User()
    
    var nameTextField: TextField = {
        let textfield = TextField()
        textfield.setPlaceholderText("Имя")
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    var lastNameTextField: TextField = {
        let textfield = TextField()
        textfield.setPlaceholderText("Фамилия")
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    var birthDateTextField: TextField = {
        let textfield = TextField()
        textfield.setPlaceholderText("Дата рождения")
        textfield.keyboardType = .numberPad
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    var emailTextField: TextField = {
        let textfield = TextField()
        textfield.setPlaceholderText("Электронная почта")
        textfield.keyboardType = .emailAddress
        textfield.isUserInteractionEnabled = false
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    let signupButton: Button = {
        let button = Button()
        button.setActive(false)
        button.setTitle("Зарегистрироваться", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let stackTextFields: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 24
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension UserInfoViewController {
    func setup() {
        view.backgroundColor = .white
        birthDateTextField.delegate = self

        setStackTextFields()
        setSignupButton()
        setNameTextField()
        setSecondNameTextField()
        setBirthDateTextField()
        setEmailTextField()
        signupButton.addTarget(
            self,
            action: #selector(signupButtonTapped),
            for: .touchUpInside
        )
    }
    func setStackTextFields() {
        view.addSubview(stackTextFields)
        
        stackTextFields.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(84)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
    }
    func setNameTextField() {
        nameTextField.addTarget(
            self,
            action: #selector(textFieldDidChange(_:)),
            for: .editingChanged
        )
        stackTextFields.addArrangedSubview(nameTextField)
    }
    func setSecondNameTextField() {
        lastNameTextField.addTarget(
            self,
            action: #selector(textFieldDidChange(_:)),
            for: .editingChanged
        )
        stackTextFields.addArrangedSubview(lastNameTextField)
    }
    func setBirthDateTextField() {
        birthDateTextField.addTarget(
            self,
            action: #selector(textFieldDidChange(_:)),
            for: .editingChanged
        )
        stackTextFields.addArrangedSubview(birthDateTextField)
    }
    func setEmailTextField() {
        emailTextField.addTarget(
            self,
            action: #selector(textFieldDidChange(_:)),
            for: .editingChanged
        )
        emailTextField.setTextToTextField(user.email)
        stackTextFields.addArrangedSubview(emailTextField)
    }
    func setSignupButton() {
        view.addSubview(signupButton)
        
        signupButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.keyboardLayoutGuide.snp.top).offset(-16)
            make.height.equalTo(65)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
    }
}

extension UserInfoViewController: UITextFieldDelegate {
    @objc func signupButtonTapped() {
        saveUserData()
        handleBirthDateInput()
        let changePasswordVC = CreateChangePasswordViewController()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.customize()
        navigationController?.show(changePasswordVC, sender: self)
    }
    
    func saveUserData() {
        print("Имя: \(user.name)")
        print("Фамилия: \(user.lastName)")
        print("Email: \(user.email)")
        print("Дата рождения: \(user.birthDate)")
        
        user.birthDate = birthDateTextField.text!
        user.name = nameTextField.text!
        user.lastName = lastNameTextField.text!
        user.email = emailTextField.text!
    }
    
    func handleBirthDateInput() {
        if let text = birthDateTextField.text, text.count == 8 {
            let formattedText = "\(text.prefix(2)).\(text.dropFirst(2).prefix(2)).\(text.dropFirst(4))"
            birthDateTextField.text = formattedText
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = birthDateTextField.text as NSString? else {
            return false
        }
        
        let allowedCharacterSet = CharacterSet(charactersIn: "0123456789")
        let characterSet = CharacterSet(charactersIn: string)
        let isNumber = allowedCharacterSet.isSuperset(of: characterSet)
        let newText = currentText.replacingCharacters(in: range, with: string)
        
        if string.isEmpty {
            return true
        }
        
        let newLength = newText.count
        if isNumber && newLength <= 10 {
            let formattedText = formatPhoneNumber(text: newText)
            textField.text = formattedText
            
            if newLength == 1 {
                birthDateTextField.placesolderToTop()
            }
        }
        
        return false
    }

    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if !emailTextField.text!.isEmpty &&
            !nameTextField.text!.isEmpty &&
            !lastNameTextField.text!.isEmpty &&
            !birthDateTextField.text!.isEmpty {
            signupButton.setActive(true)
            signupButton.addTarget(
                self,
                action: #selector(signupButtonTapped),
                for: .touchUpInside
            )
            
            print(
                !emailTextField.text!.isEmpty,
                !nameTextField.text!.isEmpty,
                !lastNameTextField.text!.isEmpty,
                !birthDateTextField.text!.isEmpty,
                emailTextField.text!,
                nameTextField.text!,
                lastNameTextField.text!,
                birthDateTextField.text!
            )
        } else {
            signupButton.setActive(false)
            signupButton.removeTarget(nil, action: nil, for: .allEvents)
        }
    }
    
    func formatPhoneNumber(text: String) -> String {
        var formattedText = text.replacingOccurrences(of: ".", with: "")
        if formattedText.count >= 2 {
            formattedText.insert(".", at: formattedText.index(formattedText.startIndex, offsetBy: 2))
        }
        if formattedText.count >= 5 {
            formattedText.insert(".", at: formattedText.index(formattedText.startIndex, offsetBy: 5))
        }
        return formattedText
    }
}
