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
    let signupButton: ActiveButton = {
        let button = ActiveButton()
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
        stackTextFields.addArrangedSubview(nameTextField)
    }
    func setSecondNameTextField() {
        stackTextFields.addArrangedSubview(lastNameTextField)
    }
    func setBirthDateTextField() {
        stackTextFields.addArrangedSubview(birthDateTextField)
    }
    func setEmailTextField() {
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
        let changePasswordVC = ChangePasswordViewController()
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
    
//    func checkTextFields() {
//        print(
//            !emailTextField.text!.isEmpty,
//            !nameTextField.text!.isEmpty,
//            !lastNameTextField.text!.isEmpty,
//            !birthDateTextField.text!.isEmpty,
//            emailTextField.text!,
//            nameTextField.text!,
//            lastNameTextField.text!,
//            birthDateTextField.text!
//        )
//        
//        if !emailTextField.text!.isEmpty &&
//            !nameTextField.text!.isEmpty &&
//            !lastNameTextField.text!.isEmpty &&
//            !birthDateTextField.text!.isEmpty {
//            signupButton.setActive(true)
//            signupButton.addTarget(
//                self,
//                action: #selector(signupButtonTapped),
//                for: .touchUpInside
//            )
//        } else {
//            signupButton.setActive(false)
//            signupButton.removeTarget(nil, action: nil, for: .allEvents)
//        }
//    }
    
    func handleBirthDateInput() {
        if let text = birthDateTextField.text, text.count == 8 {
            let formattedText = "\(text.prefix(2)).\(text.dropFirst(2).prefix(2)).\(text.dropFirst(4))"
            birthDateTextField.text = formattedText
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = birthDateTextField.text as NSString? else {
            return true
        }
        let allowedCharacterSet = CharacterSet(charactersIn: "0123456789")
        let characterSet = CharacterSet(charactersIn: string)
        let isNumber = allowedCharacterSet.isSuperset(of: characterSet)
        
        let newLength = currentText.replacingCharacters(in: range, with: string).count
        if isNumber && newLength <= 10 {
            if newLength == 3 || newLength == 6 {
                let formattedText = "\(currentText)."
                textField.text = formattedText
            }
            return true
        } else {
            return false
        }
    }

    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == birthDateTextField {
            handleBirthDateInput()
        }
    }

}
