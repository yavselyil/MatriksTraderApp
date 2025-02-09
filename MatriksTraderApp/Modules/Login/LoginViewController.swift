//
//  LoginViewController.swift
//  MatriksTraderApp
//
//  Created by Selim Yılmaz on 9.02.2025.
//

import UIKit

protocol LoginDisplayLayer: AnyObject {
    func displayLoginSuccess()
    func displayLoginFailure(errorMessage: String)
}

final class LoginViewController: BaseViewController, LoginDisplayLayer {
    private var viewModel: LoginBusinessLayer
    
    private let usernameTextField = UITextField()
    private let passwordTextField = UITextField()
    private let loginButton = UIButton(type: .system)
    private let errorLabel = UILabel()
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    init(viewModel: LoginBusinessLayer) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        (viewModel as? LoginViewModel)?.view = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func displayLoginSuccess() {
        hideLoader()
        viewModel.push()
    }
    
    func displayLoginFailure(errorMessage: String) {
        hideLoader()
        errorLabel.text = errorMessage
        errorLabel.isHidden = false
    }
}

private extension LoginViewController {
    func setupViews() {
        view.backgroundColor = .white
        configureUserNameTextField()
        configurePasswordTextField()
        configureLoginButtonTextField()
        configureErrorLabel()
        configureActivityIndicator()
        setupConstraints()
        
        [usernameTextField, passwordTextField, loginButton, errorLabel, activityIndicator].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    func configureUserNameTextField() {
        usernameTextField.placeholder = "Kullanıcı Adı"
        usernameTextField.borderStyle = .roundedRect
        view.addSubview(usernameTextField)
    }
    
    func configurePasswordTextField() {
        passwordTextField.placeholder = "Şifre"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.borderStyle = .roundedRect
        view.addSubview(passwordTextField)
    }
    
    func configureLoginButtonTextField() {
        loginButton.setTitle("Giriş Yap", for: .normal)
        loginButton.backgroundColor = .systemBlue
        loginButton.tintColor = .white
        loginButton.layer.cornerRadius = 8
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        view.addSubview(loginButton)
    }
    
    func configureErrorLabel() {
        errorLabel.textColor = .red
        errorLabel.textAlignment = .center
        errorLabel.numberOfLines = 0
        errorLabel.isHidden = true
        view.addSubview(errorLabel)
    }
    
    func configureActivityIndicator() {
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
    }
    
    func setupConstraints() {
        usernameTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(BaseConstants.topOffset)
            make.leading.trailing.equalToSuperview().inset(BaseConstants.size32)
            make.height.equalTo(BaseConstants.textFieldHeight)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(BaseConstants.size16)
            make.leading.trailing.equalTo(usernameTextField)
            make.height.equalTo(BaseConstants.textFieldHeight)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(BaseConstants.size16)
            make.leading.trailing.equalTo(usernameTextField)
            make.height.equalTo(BaseConstants.size50)
        }
        
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(BaseConstants.size16)
            make.leading.trailing.equalTo(usernameTextField)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(errorLabel.snp.bottom).offset(BaseConstants.size20)
        }
    }
    
    @objc func loginButtonTapped() {
        view.endEditing(true)
        errorLabel.isHidden = true
        showLoader()
        
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        viewModel.login(username: username, password: password)
    }
}
