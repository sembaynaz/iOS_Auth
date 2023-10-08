//
//  SigninViewController.swift
//  neobis_auth
//
//  Created by Nazerke Sembay on 01.10.2023.
//

import UIKit
import SnapKit

class SigninViewController: UIViewController {

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
    let passeordTextField: TextField = {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
    }
}

extension SigninViewController {
    func setup() {
        view.backgroundColor = .white
        
        setLogoImageView()
        setEmailTextField()
        setPasswordTextField()
        setSigninButton()
        setForgotPassword()
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
        view.addSubview(passeordTextField)
        passeordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
    }
    func setSigninButton() {
        view.addSubview(signinButton)
        signinButton.snp.makeConstraints { make in
            make.top.equalTo(passeordTextField.snp.bottom).offset(60)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(65)
        }
    }
    func setForgotPassword() {
        view.addSubview(forgotPasswordButton)
        forgotPasswordButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(65)
            make.bottom.equalTo(view.snp.bottom).offset(-44)
        }
    }
}
