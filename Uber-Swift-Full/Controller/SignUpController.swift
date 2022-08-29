//
//  SignUpController.swift
//  Uber-Swift-Full
//
//  Created by hakkı can şengönül on 29.08.2022.
//

import UIKit
class SignUpController: UIViewController {
    // MARK: - Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "UBER"
        label.font = UIFont(name: "Avenir-Light", size: 36)
        label.textColor = UIColor(white: 1, alpha: 0.8)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private lazy var emailContainerView: UIView = {
        let image = #imageLiteral(resourceName: "ic_mail_outline_white_2x")
        let view = UIView().inputContainerView(withImage: image, withTextField: emailTextFiled)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    private lazy var fullnameContainerView: UIView = {
        let image = #imageLiteral(resourceName: "ic_person_outline_white_2x")
        let view = UIView().inputContainerView(withImage: image, withTextField: fullnameTextFiled)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    private lazy var passwordContainerView: UIView = {
        let image = #imageLiteral(resourceName: "ic_lock_outline_white_2x")
        let view = UIView().inputContainerView(withImage: image, withTextField: passwordTextFiled)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    private lazy var accountTypeContainerView: UIView = {
        let image = #imageLiteral(resourceName: "ic_account_box_white_2x")
        let view = UIView().inputContainerView(withImage: image, withsegmentedControl: accountTypeSegmentedControl)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    private let emailTextFiled: UITextField = {
        return UITextField().textField(withPlaceHolder: "Email", isSecuritetextEntry: false)
    }()
    private let fullnameTextFiled: UITextField = {
        return UITextField().textField(withPlaceHolder: "Fullname", isSecuritetextEntry: false)
    }()
    private let passwordTextFiled: UITextField = {
        return UITextField().textField(withPlaceHolder: "Password", isSecuritetextEntry: true)
    }()
    private let accountTypeSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Rider", "Driver"])
        segmentedControl.backgroundColor = .backgroundColor
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.selectedSegmentTintColor = UIColor(white: 1, alpha: 0.85)
        return segmentedControl
    }()
    private let signUpButton: AuthButton = {
        let button = AuthButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        return button
    }()
    private let stackView = UIStackView()
    private let alreadyhaveActionButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Already have an account? ", attributes: [.font : UIFont.preferredFont(forTextStyle: .body),.foregroundColor : UIColor.lightGray])
        attributedTitle.append(NSAttributedString(string: " Log In", attributes: [.font: UIFont.preferredFont(forTextStyle: .body), .foregroundColor : UIColor.mainBlue]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}
// MARK: - Helpers
extension SignUpController{
    private func style(){
        view.backgroundColor = .backgroundColor
        //titleLabel Style
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        //stackView Style
        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        //emailContainerView Style
        emailContainerView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(emailContainerView)
        //fullnameContainerView Style
        fullnameContainerView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(fullnameContainerView)
        //passwordContainerView Style
        passwordContainerView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(passwordContainerView)
        //accountTypeContainerView Style
        accountTypeContainerView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(accountTypeContainerView)
        //loginButton Style
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(signUpButton)
        //alreadyhaveActionButton Style
        alreadyhaveActionButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(alreadyhaveActionButton)
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
        //alreadyhaveActionButton Layout
        NSLayoutConstraint.activate([
            alreadyhaveActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            alreadyhaveActionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
// MARK: - Actions
extension SignUpController{
    @objc func handleShowLogin(){
        navigationController?.popViewController(animated: true)
    }
}
