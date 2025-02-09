//
//  BaseViewController.swift
//  MatriksTraderApp
//
//  Created by Selim Yılmaz on 9.02.2025.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {

    private let activityIndicator = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGestureRecognizer()
        setupLoader()
        view.backgroundColor = .white
    }

    private func setupGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    private func setupLoader() {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .systemBlue
        view.addSubview(activityIndicator)

        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    func showLoader() {
        view.bringSubviewToFront(activityIndicator)
        activityIndicator.startAnimating()
    }

    func hideLoader() {
        activityIndicator.stopAnimating()
    }
}

