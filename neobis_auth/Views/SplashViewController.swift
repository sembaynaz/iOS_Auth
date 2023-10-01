//
//  ViewController.swift
//  neobis_auth
//
//  Created by Nazerke Sembay on 01.10.2023.
//

import UIKit
import SnapKit

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
        let lineHeight: CGFloat = 40 * 1.2
        let attributedString = NSMutableAttributedString(string: label.text ?? "")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineHeight - label.font.lineHeight
        attributedString.addAttribute(
            .paragraphStyle,
            value: paragraphStyle,
            range: NSMakeRange(0, attributedString.length)
        )
        label.attributedText = attributedString
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let signupButton: UIButton = {
        let button = UIButton()
        let font = UIFont(name: "GothamPro-Bold", size: 16)
        button.backgroundColor = nil
        button.setTitle("Есть аккаунт? Войти", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = font
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let signinButton: UIButton = {
        let button = UIButton()
        let font = UIFont(name: "GothamPro-Bold", size: 16)
        button.backgroundColor = UIColor(named: "Blue")
        button.setTitle("Начать пользоваться", for: .normal)
        button.titleLabel?.font = font
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
}

extension SplashViewController {
    func setupUI() {
        setSignupButton()
        setSigninButton()
        setTitleLabel()
        setLogo()
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
            make.bottom.equalTo(signinButton.snp.top).offset(-64)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
    }
    
    func setSigninButton() {
        view.addSubview(signinButton)
        signinButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(65)
            make.bottom.equalTo(signupButton.snp.top).offset(-16)
        }
    }
    
    func setSignupButton() {
        view.addSubview(signupButton)
        signupButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(65)
            make.bottom.equalTo(view.snp.bottom).offset(-44)
        }
    }
}
