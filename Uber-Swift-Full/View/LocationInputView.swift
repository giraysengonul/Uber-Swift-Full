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
    }
    private func layout(){
        //backButton Layout
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: topAnchor, constant: 44),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            backButton.widthAnchor.constraint(equalToConstant: 24),
            backButton.heightAnchor.constraint(equalToConstant: 25),
        ])
    }
}
// MARK: - Actions, Selectors
extension LocationInputView{
    @objc func handleBackTapped(_ sender: UIButton){
        delegate?.dismissLocationInputView()
    }
}
