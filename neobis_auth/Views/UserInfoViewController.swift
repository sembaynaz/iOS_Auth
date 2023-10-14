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
    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker(frame: .zero)
        
        datePicker.datePickerMode = .date
        datePicker.timeZone = TimeZone.current
        datePicker.locale = .autoupdatingCurrent
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "dd.MM.yyyy"
        let currentDate = Date()
        let dateString = dateFormatter.string(from: currentDate)
        self.dateString = dateString
        datePicker.date = currentDate
        
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
        
        return datePicker
    }()
    
    lazy var toolbar: UIToolbar = {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(doneButtonAction))
        
        done.setTitleTextAttributes([
            .foregroundColor: UIColor.link
        ], for: .normal)
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        return doneToolbar
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
        birthDateTextField.inputView = datePicker
        birthDateTextField.inputAccessoryView = toolbar
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
    
    @objc func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        dateString = dateFormatter.string(from: sender.date)
        dateFormat()
        
        textFieldDidChange(birthDateTextField)
    }
    
    @objc func doneButtonAction(){
        birthDateTextField.setTextToTextField(dateString)
        textFieldDidChange(birthDateTextField)
        birthDateTextField.resignFirstResponder()
    }
    
    func dateFormat() {
        birthDateTextField.setTextToTextField(dateString)
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
