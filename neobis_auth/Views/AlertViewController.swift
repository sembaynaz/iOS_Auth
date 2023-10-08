//
//  AlertViewController.swift
//  neobis_auth
//
//  Created by Nazerke Sembay on 02.10.2023.
//

import UIKit

class AlertViewController: UIViewController {
    
    var viewTranslation = CGPoint(x: 0, y: 0)
    var emailText = ""

    let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 32
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let logoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Logo")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    let messageLabel: UILabel = {
        let label = UILabel()
        let font = UIFont(name: "GothamPro-Medium", size: 18)
        label.font = font
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        let message = "На вашу почту \n«» было \nотправлено письмо"
        let attributedString = NSMutableAttributedString(string: message)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
        let lineHeight: CGFloat = 21 * 1.2
        paragraphStyle.lineSpacing = lineHeight - label.font.lineHeight
        attributedString.addAttribute(
            .paragraphStyle,
            value: paragraphStyle,
            range: NSMakeRange(0, attributedString.length)
        )
        label.attributedText = attributedString
        return label
    }()

    let closeButton: ActiveButton = {
        let button = ActiveButton()
        button.setActive(true)
        button.setTitle("Закрыть", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
}

extension AlertViewController {
    func setup() {
        view.backgroundColor = UIColor(
            red: 19/255,
            green: 19/255,
            blue: 19/255,
            alpha: 0.4
        )

        setBackgroundView()
        setCloseButton()
        setMessageLabel()
        setLogoImage()
        
        closeButton.addTarget(
            self,
            action: #selector(closeButtonTapped),
            for: .touchUpInside
        )
    }
    func setBackgroundView() {
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(343)
        }
    }

    func setCloseButton() {
        backgroundView.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.bottom.equalTo(backgroundView.snp.bottom).offset(-24)
            make.height.equalTo(44)
            make.horizontalEdges.equalToSuperview().inset(32)
        }
    }

    func setMessageLabel() {
        let message = "На вашу почту \n«\(emailText)» было \nотправлено письмо"
        messageLabel.text = message
        let attributedString = NSMutableAttributedString(string: message)
        if let emailRange = message.range(of: "\(emailText)") {
            attributedString.addAttribute(.foregroundColor, value: UIColor(named: "Blue")!, range: NSRange(emailRange, in: message))
        }
        messageLabel.attributedText = attributedString
        backgroundView.addSubview(messageLabel)
        messageLabel.snp.makeConstraints { make in
            make.bottom.equalTo(closeButton.snp.top).offset(-41)
            make.horizontalEdges.equalTo(backgroundView.snp.horizontalEdges).inset(-16)
        }
    }

    func setLogoImage() {
        backgroundView.addSubview(logoImage)
        logoImage.snp.makeConstraints { make in
            make.height.width.equalTo(120)
            make.centerX.equalTo(backgroundView.snp.centerX)
            make.top.equalTo(backgroundView.snp.top).inset(24)
        }
    }
}

//MARK: Functionality
extension AlertViewController {
    @objc func closeButtonTapped() {
        let userInfoVC = UserInfoViewController()
        userInfoVC.modalPresentationStyle = .fullScreen
        userInfoVC.user.email = emailText
        self.view.window?.rootViewController = UINavigationController(rootViewController: userInfoVC)
        self.view.window?.makeKeyAndVisible()
    }
}
