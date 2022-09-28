//
//  LocationInputView.swift
//  Uber-Swift-Full
//
//  Created by hakkı can şengönül on 17.09.2022.
//

import UIKit

protocol LocationInputViewDelegate: AnyObject {
    func dismissLocationInputView()
}

class LocationInputView: UIView {
    // MARK: - Properties
    weak var delegate: LocationInputViewDelegate?
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        let image = #imageLiteral(resourceName: "baseline_arrow_back_black_36dp-1")
        button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleBackTapped), for: .touchUpInside)
        return button
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    private let startLocationIndicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    private let linkingView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    private let destinationIndicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    private lazy var startingLocationTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Current Location"
        textField.backgroundColor = .systemGray6
        textField.isEnabled = false
        textField.font = UIFont.systemFont(ofSize: 14)
        let paddingView = UIView()
        paddingView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        paddingView.widthAnchor.constraint(equalToConstant: 8).isActive = true
        textField.leftView = paddingView
        textField.leftViewMode = .always
        return textField
    }()
    private lazy var destinationLocationTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter a destination.."
        textField.backgroundColor = .lightGray
        textField.returnKeyType = .search
        textField.font = UIFont.systemFont(ofSize: 14)
        let paddingView = UIView()
        paddingView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        paddingView.widthAnchor.constraint(equalToConstant: 8).isActive = true
        textField.leftView = paddingView
        textField.leftViewMode = .always
        return textField
    }()
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - Helpers
extension LocationInputView{
    private func style(){
        backgroundColor = .white
        addShadow()
        //backButton Style
        backButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(backButton)
        //titleLabel Style
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        //startingLocationTextField Style
        startingLocationTextField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(startingLocationTextField)
        //destinationLocationTextField Style
        destinationLocationTextField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(destinationLocationTextField)
        //startLocationIndicatorView Style
        startLocationIndicatorView.layer.cornerRadius = 6 / 2
        startLocationIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(startLocationIndicatorView)
        //destinationIndicatorView Style
        destinationIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(destinationIndicatorView)
        //linkingView Style
        linkingView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(linkingView)
        
    }
    private func layout(){
        //backButton Layout
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: topAnchor, constant: 44),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            backButton.widthAnchor.constraint(equalToConstant: 24),
            backButton.heightAnchor.constraint(equalToConstant: 25),
        ])
        //titleLabel Layout
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        //startingLocationTextField Layout
        NSLayoutConstraint.activate([
            startingLocationTextField.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 4),
            startingLocationTextField.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 40),
            startingLocationTextField.heightAnchor.constraint(equalToConstant: 30),
            trailingAnchor.constraint(equalTo: startingLocationTextField.trailingAnchor,constant: 40)
        ])
        //destinationLocationTextField Layout
        NSLayoutConstraint.activate([
            destinationLocationTextField.topAnchor.constraint(equalTo: startingLocationTextField.bottomAnchor, constant: 12),
            destinationLocationTextField.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 40),
            destinationLocationTextField.heightAnchor.constraint(equalToConstant: 30),
            trailingAnchor.constraint(equalTo: destinationLocationTextField.trailingAnchor,constant: 40)
        ])
        //startLocationIndicatorView Layout
        NSLayoutConstraint.activate([
            startLocationIndicatorView.centerYAnchor.constraint(equalTo: startingLocationTextField.centerYAnchor),
            startLocationIndicatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            startLocationIndicatorView.heightAnchor.constraint(equalToConstant: 6),
            startLocationIndicatorView.widthAnchor.constraint(equalToConstant: 6)
        ])
        //destinationIndicatorView Layout
        NSLayoutConstraint.activate([
            destinationIndicatorView.centerYAnchor.constraint(equalTo: destinationLocationTextField.centerYAnchor),
            destinationIndicatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            destinationIndicatorView.heightAnchor.constraint(equalToConstant: 6),
            destinationIndicatorView.widthAnchor.constraint(equalToConstant: 6)
        ])
        //linkingView Layout
        NSLayoutConstraint.activate([
            linkingView.centerXAnchor.constraint(equalTo: startLocationIndicatorView.centerXAnchor),
            linkingView.topAnchor.constraint(equalTo: startLocationIndicatorView.bottomAnchor, constant: 4),
            destinationIndicatorView.topAnchor.constraint(equalTo: linkingView.bottomAnchor, constant: 4),
            linkingView.widthAnchor.constraint(equalToConstant: 0.5)
        ])
    }
}
// MARK: - Actions, Selectors
extension LocationInputView{
    @objc func handleBackTapped(_ sender: UIButton){
        delegate?.dismissLocationInputView()
    }
}
