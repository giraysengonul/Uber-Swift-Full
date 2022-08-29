//
//  AuthButton.swift
//  Uber-Swift-Full
//
//  Created by hakkı can şengönül on 29.08.2022.
//

import UIKit
class AuthButton: UIButton {
    // MARK: - Properties
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - Helpers
extension AuthButton{
    private func style(){
        setTitleColor(UIColor(white: 1, alpha: 0.85), for: .normal)
        backgroundColor = .mainBlue
        layer.cornerRadius = 5
        titleLabel?.adjustsFontSizeToFitWidth = true
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .title2)
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
}
