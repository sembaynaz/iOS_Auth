//
//  ViewController.swift
//  neobis_auth
//
//  Created by Nazerke Sembay on 01.10.2023.
//

import UIKit
import SnapKit

//MARK: UI Elements
class SplashViewController: UIViewController {
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
    
    let signinButton: UIButton = {
        let button = UIButton()
        let font = UIFont(name: "GothamPro-Bold", size: 16)
        button.backgroundColor = nil
        button.setTitle("Есть аккаунт? Войти", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = font
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let signupButton: ActiveButton = {
        let button = ActiveButton()
        button.setActive(true)
        button.setTitle("Начать пользоваться", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.customize()
    }
}

//MARK: Setup UI
extension SplashViewController {
    func setupUI() {
        setSigninButton()
        setSignupButton()
        setTitleLabel()
        setLogo()
        
        signupButton.addTarget(
            self,
            action: #selector(signupButtonTapped),
            for: .touchUpInside
        )
        
        signinButton.addTarget(
            self,
            action: #selector(signinButtonTapped),
            for: .touchUpInside
        )
    }
    
    func setLogo() {
        view.addSubview(logoImage)
        logoImage.snp.makeConstraints { make in
            make.bottom.equalTo(titleLabel.snp.top).offset(-60)
            make.horizontalEdges.equalToSuperview().inset(88)
        }
    }
    
    func setTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(signupButton.snp.top).offset(-64)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
    }
    
    func setSignupButton() {
        view.addSubview(signupButton)
        signupButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(65)
            make.bottom.equalTo(signinButton.snp.top).offset(-16)
        }
    }
    
    func setSigninButton() {
        view.addSubview(signinButton)
        signinButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(65)
            make.bottom.equalTo(view.snp.bottom).offset(-44)
        }
    }
}

//MARK: Functionality
extension SplashViewController {
    @objc func signupButtonTapped() {
        let signupVC = SignupViewController()
        navigationController?.show(signupVC, sender: self)
    }
    
    @objc func signinButtonTapped() {
        let signinVC = SigninViewController()
        navigationController?.show(signinVC, sender: self)
    }
}
