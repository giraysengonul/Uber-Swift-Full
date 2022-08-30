//
//  LoginController.swift
//  Uber-Swift-Full
//
//  Created by hakkı can şengönül on 27.08.2022.
//

import UIKit
class LoginController: UIViewController {
    // MARK: - Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "UBER"
        label.font = UIFont(name: "Avenir-Light", size: 36)
        label.textColor = UIColor(white: 1, alpha: 0.8)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private let stackView = UIStackView()
    private lazy var emailContainerView: UIView = {
        let image = #imageLiteral(resourceName: "ic_mail_outline_white_2x")
        let view = UIView().inputContainerView(withImage: image, withTextField: emailTextFiled)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    private lazy var passwordContainerView: UIView = {
        let image = #imageLiteral(resourceName: "ic_lock_outline_white_2x")
        let view = UIView().inputContainerView(withImage: image, withTextField: passwordTextFiled)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    private let emailTextFiled: UITextField = {
        return UITextField().textField(withPlaceHolder: "Email", isSecuritetextEntry: false)
    }()
    private let passwordTextFiled: UITextField = {
        return UITextField().textField(withPlaceHolder: "Password", isSecuritetextEntry: true)
    }()
    private let loginButton: AuthButton = {
        let button = AuthButton(type: .system)
        button.setTitle("Log In", for: .normal)
        return button
    }()
    private let dontHaveActionButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account? ", attributes: [.font : UIFont.preferredFont(forTextStyle: .body),.foregroundColor : UIColor.lightGray])
        attributedTitle.append(NSAttributedString(string: " Sign Up", attributes: [.font: UIFont.preferredFont(forTextStyle: .body), .foregroundColor : UIColor.mainBlue]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    // MARK: - Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}
// MARK: - Helpers
extension LoginController{
    private func style(){
        //viewController Style
        view.backgroundColor = .backgroundColor
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true
        //titleLabel Style
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        //emailContainerView Style
        emailContainerView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(emailContainerView)
        //passwordContainerView Style
        passwordContainerView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(passwordContainerView)
        //loginButton Style
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(loginButton)
        //stackView Style
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        //dontHaveActionButton Style
        dontHaveActionButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dontHaveActionButton)
    }
    private func layout(){
        //titleLabel Layout
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0)
        ])
        //stackView Layout
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
        ])
        //dontHaveActionButton Layout
        NSLayoutConstraint.activate([
            dontHaveActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            dontHaveActionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
// MARK: - Actions
extension LoginController{
    @objc func handleShowSignUp(_ sender: UIButton){
        let controller = SignUpController()
        navigationController?.pushViewController(controller, animated: true)
    }
}
