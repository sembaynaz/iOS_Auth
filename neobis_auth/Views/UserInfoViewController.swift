//
//  UserInfoViewController.swift
//  neobis_auth
//
//  Created by Nazerke Sembay on 01.10.2023.
//

import UIKit
import SnapKit

class UserInfoViewController: UIViewController {
    let viewModel: UserViewModel
    var dateString = ""
    
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
    
    init(_ viewModel: UserViewModel = UserViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        hideKeyboardWhenTappedAround()
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
        emailTextField.setTextToTextField(viewModel.user.email)
        stackTextFields.addArrangedSubview(emailTextField)
    }
    func setSignupButton() {
        view.addSubview(signupButton)
        signupButton.addTarget(
            self,
            action: #selector(signupButtonTapped),
            for: .touchUpInside
        )
        signupButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.keyboardLayoutGuide.snp.top).offset(-16)
            make.height.equalTo(65)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
    }
}

extension UserInfoViewController: UITextFieldDelegate {
    @objc func signupButtonTapped() {
        let changePasswordVC = CreateChangePasswordViewController()
        changePasswordVC.title = "Создать пароль"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.customize()
        navigationController?.show(changePasswordVC, sender: self)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard !nameTextField.text!.isEmpty,
              !lastNameTextField.text!.isEmpty,
              !birthDateTextField.text!.isEmpty,
              !emailTextField.text!.isEmpty
        else {
            signupButton.setActive(false)
            signupButton.removeTarget(nil, action: nil, for: .allEvents)
            return
        }
        
        signupButton.setActive(true)
        signupButton.addTarget(
            self,
            action: #selector(signupButtonTapped),
            for: .touchUpInside
        )
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
            let formattedText = formatNumber(text: newText)
            textField.text = formattedText
            
            birthDateTextField.setTextToTextField(formattedText)
            textFieldDidChange(birthDateTextField)
        }
        
        
        return false
    }
    func handleBirthDateInput() {
        if let text = birthDateTextField.text, text.count == 8 {
            let formattedText = "\(text.prefix(2)).\(text.dropFirst(2).prefix(2)).\(text.dropFirst(4))"
            birthDateTextField.text = formattedText
        }
    }
    func formatNumber(text: String) -> String {
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

extension UserInfoViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
