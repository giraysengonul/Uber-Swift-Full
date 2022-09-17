//
//  LocationInputActivationView.swift
//  Uber-Swift-Full
//
//  Created by hakkı can şengönül on 11.09.2022.
//

import UIKit

protocol LocationInputActivationViewDelegate: AnyObject {
    func presentLocationInputView()
}

class LocationInputActivationView: UIView {
    // MARK: - Properties
    weak var delegate: LocationInputActivationViewDelegate?
    
    private let indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = "Where to?"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .darkGray
        return label
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
extension LocationInputActivationView{
    private func style() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(presentLocationInputView))
        addGestureRecognizer(tap)
        backgroundColor = .white
        addShadow()
        //indicatorView Style
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(indicatorView)
        //placeholderLabel Style
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(placeholderLabel)
    }
    private func layout() {
        //indicatorView Layout
        NSLayoutConstraint.activate([
            indicatorView.centerYAnchor.constraint(equalTo: centerYAnchor),
            indicatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            indicatorView.heightAnchor.constraint(equalToConstant: 6),
            indicatorView.widthAnchor.constraint(equalToConstant: 6)
        ])
        //placeholderLabel Layout
        NSLayoutConstraint.activate([
            placeholderLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            placeholderLabel.leadingAnchor.constraint(equalTo: indicatorView.trailingAnchor, constant: 20)
        ])
    }
}
// MARK: - Action
extension LocationInputActivationView{
    @objc func presentLocationInputView(_ sender: UITapGestureRecognizer){
        delegate?.presentLocationInputView()
    }
}
