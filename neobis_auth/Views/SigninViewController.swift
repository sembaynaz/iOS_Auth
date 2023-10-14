//
//  SigninViewController.swift
//  neobis_auth
//
//  Created by Nazerke Sembay on 01.10.2023.
//

import UIKit
import SnapKit

class SigninViewController: UIViewController {
    let viewModel: UserViewModel
    
    let logoImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Logo")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    let emailTextField: TextField = {
        let textfield = TextField()
        textfield.setPlaceholderText("Электронная почта")
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    let passwordTextField: TextField = {
        let textfield = TextField()
        textfield.setPlaceholderText("Пароль")
        textfield.setPasswordTextField(true)
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    let signinButton: Button = {
        let button = Button()
        button.setTitle("Войти", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let forgotPasswordButton: UIButton = {
        let button = UIButton()
        let font = UIFont(name: "GothamPro-Bold", size: 16)
        button.backgroundColor = nil
        button.setTitle("Забыли пароль?", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = font
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let errorLabel: UILabel = {
        let label = UILabel()
        let font = UIFont(name: "GothamPro-Medium", size: 14)
        label.font = font
        label.isHidden = true
        label.text = "Неверный логин или пароль"
        label.textColor = .red
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.customize()
        
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

extension SigninViewController {
    func setup() {
        view.backgroundColor = .white
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        setLogoImageView()
        setEmailTextField()
        setPasswordTextField()
        setSigninButton()
        setForgotPassword()
        setErrorLabel()
        hideKeyboardWhenTappedAround()
    }
    func setLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.height.width.equalTo(120)
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalToSuperview().inset(76)
        }
    }
    func setEmailTextField() {
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(40)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
    }
    func setPasswordTextField() {
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
    }
    func setSigninButton() {
        view.addSubview(signinButton)
        signinButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(60)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(65)
        }
    }
    func setForgotPassword() {
        view.addSubview(forgotPasswordButton)
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordButtonTapped), for: .touchUpInside)
        forgotPasswordButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(65)
            make.bottom.equalTo(view.snp.bottom).offset(-44)
        }
    }
    func setErrorLabel() {
        view.addSubview(errorLabel)
        
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(16)
            make.centerX.equalTo(view.snp.centerX)
        }
    }
}

extension SigninViewController: UITextFieldDelegate {

    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func forgotPasswordButtonTapped() {
        let signupVC = SignupAndCheckEmailViewController()
        signupVC.title = "Cброс пароля"
        signupVC.isPasswordChange = true
        navigationItem.title = ""
        navigationController?.show(signupVC, sender: self)
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = emailTextField.text,
              let range = Range(range, in: currentText) else {
            return true
        }
        
        let updatedText = currentText.replacingCharacters(in: range, with: string)
        let isValid = isValidEmail(email: updatedText)
        signinButton.setActive(isValid)
        emailTextField.isEror(!isValid)
        passwordTextField.isEror(!isValid)
        
        if updatedText.isEmpty {
            errorLabel.isHidden = true
        } else {
            if isValid {
                errorLabel.isHidden = true
            } else {
                errorLabel.isHidden = false
            }
        }
        return true
    }
}
