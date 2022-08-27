//
//  Extension.swift
//  Uber-Swift-Full
//
//  Created by hakkı can şengönül on 27.08.2022.
//

import UIKit

extension UIColor{
    static func rgb(withRed red: CGFloat, withGreen green: CGFloat, withBlue blue: CGFloat) -> UIColor{
        return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    static let backgroundColor = UIColor.rgb(withRed: 25, withGreen: 25, withBlue: 25)
    static let mainBlue = UIColor.rgb(withRed: 17, withGreen: 154, withBlue: 237)
}

extension UITextField{
    
    func textField(withPlaceHolder placeHolder: String,
                   isSecuritetextEntry: Bool) -> UITextField {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        textField.adjustsFontSizeToFitWidth = true
        textField.keyboardAppearance = .dark
        textField.textColor = .white
        textField.isSecureTextEntry = isSecuritetextEntry
        textField.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [.foregroundColor : UIColor.lightGray])
        return textField
    }
}

extension UIView{
    func inputContainerView(withImage image: UIImage, withTextField textField: UITextField) -> UIView {
        let view = UIView()
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            imageView.widthAnchor.constraint(equalToConstant: 24),
            imageView.heightAnchor.constraint(equalToConstant: 24)
        ])
        textField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textField)
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textField.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            textField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 8)
        ])
        let seperatorView = UIView()
        seperatorView.backgroundColor = .lightGray
        seperatorView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(seperatorView)
        NSLayoutConstraint.activate([
            seperatorView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            seperatorView.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
            seperatorView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            seperatorView.heightAnchor.constraint(equalToConstant: 0.75)
        ])
        return view
    }
}
