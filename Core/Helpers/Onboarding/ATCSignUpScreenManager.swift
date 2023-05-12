//
//  ATCSignUpScreenManager.swift
//  DashboardApp
//
//  Creado por Adiel Luna on 8/10/18.
//  Copyright © 2018 Instamobile. All rights reserved.
//

import FirebaseAuth
import UIKit

protocol ATCSignUpScreenManagerDelegate: class {
    func signUpManagerDidCompleteSignUp(_ signUpManager: ATCSignUpScreenManager, user: ATCUser?)
}

class ATCSignUpScreenManager: ATCSignUpScreenDelegate {
    let signUpScreen: ATCSignUpScreenProtocol
    let viewModel: ATCSignUpScreenViewModel
    let uiConfig: ATCOnboardingConfigurationProtocol
    let serverConfig: ATCOnboardingServerConfigurationProtocol
    let firebaseLoginManager: ATCFirebaseLoginManager?

    weak var delegate: ATCSignUpScreenManagerDelegate?

    init(signUpScreen: ATCSignUpScreenProtocol,
         viewModel: ATCSignUpScreenViewModel,
         uiConfig: ATCOnboardingConfigurationProtocol,
         serverConfig: ATCOnboardingServerConfigurationProtocol,
         userManager: ATCSocialUserManagerProtocol?) {
        self.signUpScreen = signUpScreen
        self.viewModel = viewModel
        self.uiConfig = uiConfig
        self.serverConfig = serverConfig
        self.firebaseLoginManager = serverConfig.isFirebaseAuthEnabled ? ATCFirebaseLoginManager(userManager: userManager) : nil
    }

    func signUpScreenDidLoadView(_ signUpScreen: ATCSignUpScreenProtocol) {
        if let titleLabel = signUpScreen.titleLabel {
            titleLabel.font = uiConfig.titleFont
            titleLabel.text = viewModel.title
            titleLabel.textColor = uiConfig.titleColor
        }

        if let nameField = signUpScreen.nameTextField {
            nameField.configure(color: uiConfig.textFieldColor,
                                font: uiConfig.signUpTextFieldFont,
                                cornerRadius: 40/2,
                                borderColor: uiConfig.textFieldBorderColor,
                                backgroundColor: uiConfig.textFieldBackgroundColor,
                                borderWidth: 1.0)
            nameField.placeholder = viewModel.nameField
            nameField.clipsToBounds = true
        }

        if let emailField = signUpScreen.emailTextField {
            emailField.configure(color: uiConfig.textFieldColor,
                                font: uiConfig.signUpTextFieldFont,
                                cornerRadius: 40/2,
                                borderColor: uiConfig.textFieldBorderColor,
                                backgroundColor: uiConfig.textFieldBackgroundColor,
                                borderWidth: 1.0)
            emailField.placeholder = viewModel.emailField
            emailField.clipsToBounds = true
        }

        if let phoneNumberTextField = signUpScreen.phoneNumberTextField {
            phoneNumberTextField.configure(color: uiConfig.textFieldColor,
                                           font: uiConfig.signUpTextFieldFont,
                                           cornerRadius: 40/2,
                                           borderColor: uiConfig.textFieldBorderColor,
                                           backgroundColor: uiConfig.textFieldBackgroundColor,
                                           borderWidth: 1.0)
            phoneNumberTextField.placeholder = viewModel.phoneField
            phoneNumberTextField.clipsToBounds = true
        }

        if let passwordField = signUpScreen.passwordTextField {
            passwordField.configure(color: uiConfig.textFieldColor,
                                    font: uiConfig.signUpTextFieldFont,
                                    cornerRadius: 40/2,
                                    borderColor: uiConfig.textFieldBorderColor,
                                    backgroundColor: uiConfig.textFieldBackgroundColor,
                                    borderWidth: 1.0)
            passwordField.placeholder = viewModel.passwordField
            passwordField.isSecureTextEntry = true
            passwordField.clipsToBounds = true
        }
        
        if let signUpButton = signUpScreen.signUpButton {
            signUpButton.setTitle(viewModel.signUpString, for: .normal)
            signUpButton.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
            signUpButton.configure(color: uiConfig.loginButtonTextColor,
                                     font: uiConfig.signUpScreenButtonFont,
                                     cornerRadius: 40/2,
                                     backgroundColor: UIColor(hexString: "#334D92"))
        }
    }
    
    @objc func didTapSignUpButton() {
        ATCHapticsFeedbackGenerator.generateHapticFeedback(.mediumImpact)
        
        #if SHOPIFY_ENABLED
        if let serverConfig = serverConfig as? ShopertinoServerConfig,
            let email = signUpScreen.emailTextField.text,
            let password = signUpScreen.passwordTextField.text,
            let firstName = signUpScreen.nameTextField.text,
            let phoneNumber = signUpScreen.phoneNumberTextField.text {
            if serverConfig.isShopifyEnabled {
                let hud = CPKProgressHUD.progressHUD(style: .loading(text: "Loading".localizedCore))
                hud.show(in: signUpScreen.view)
                ATCShopifyManager.sharedClient.customerSignup(email: email,
                                                              password: password,
                                                              firstName: firstName,
                                                              phoneNumber: phoneNumber) { (result) in
                    hud.dismiss()
                    switch result {
                    case .success(_):
                        let alert = UIAlertController(title: "Congratulations".localizedCore,
                                                      message: "Your account has been successfully created".localizedCore,
                                                      preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "OK".localizedCore, style: .default, handler: { (action) in
                            self.signUpScreen.didTapBackButton()
                        }))
                        self.signUpScreen.display(alertController: alert)
                    case .failure(let error):
                        if error.localizedDescription.isEmpty {
                            self.showGenericSignUpError()
                        } else {
                            self.showSignUpError(text: error.localizedDescription)
                        }
                    }
                }
                return
            }
        }
        #endif
        
        if serverConfig.isFirebaseAuthEnabled {
            if let email = signUpScreen.emailTextField.text,
                let password = signUpScreen.passwordTextField.text,
                let firstName = signUpScreen.nameTextField.text {
                let trimmedEmail = email.atcTrimmed()
                let trimmedPass = password.atcTrimmed()
                if (!isValid(email: trimmedEmail, pass: trimmedPass, firstName: firstName)) {
                    return
                }
                let hud = CPKProgressHUD.progressHUD(style: .loading(text: "Loading".localizedCore))
                hud.show(in: signUpScreen.view)
                Auth.auth().createUser(withEmail: trimmedEmail, password: trimmedPass) {[weak self] (authResult, error) in
                    hud.dismiss()
                    if let user = authResult?.user {
                        if let self = self {
                            let atcUser = ATCUser(uid: user.uid,
                                                  firstName: user.displayName ?? self.signUpScreen.nameTextField.text ?? "",
                                                  lastName: "",
                                                  avatarURL: user.photoURL?.absoluteString ?? "",
                                                  email: user.email ?? "",
                                                  role: self.serverConfig.role.rawValue)
                            self.firebaseLoginManager?.saveUserToServerIfNeeded(user: atcUser, appIdentifier: self.serverConfig.appIdentifier)
                            self.delegate?.signUpManagerDidCompleteSignUp(self, user: atcUser)
                        }
                    } else {
                        self?.showSignUpError(text: error?.localizedDescription ?? "There was an error. Please try again later".localizedCore)
                    }
                }
            } else {
                self.showGenericSignUpError()
            }
            return
        }
        self.delegate?.signUpManagerDidCompleteSignUp(self, user: nil)
    }

    fileprivate func isValid(email: String, pass: String, firstName: String) -> Bool {
        if firstName.count < 2 {
            showSignUpError(text: "El nombre debe ser más largo que 2 caracteres.".localizedCore)
            return false
        }

        if email.count < 2 {
            showSignUpError(text: "El e-mail debe estar vacío.".localizedCore)
            return false
        }

        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if !emailPred.evaluate(with: email) {
            showSignUpError(text: "El e-mail debe tener un formato correcto.".localizedCore)
            return false
        }
        
        let passRegEx = "^(?=.*[a-z])(?=.*[$@$#!%*?&.])(?=.*[A-Z]).{6,}$"
        let passPred = NSPredicate(format:"SELF MATCHES %@", passRegEx)
        if !passPred.evaluate(with: pass){
            showSignUpError(text: "La contraseña debe tener al menos 6 caracteres, al menos un dígito, al menos una minúscula, al menos una mayúscula y al menos un caracter no alfanumérico".localizedCore)
            return false
        }
        
        
        return true
    }

    fileprivate func showGenericSignUpError() {
        self.showSignUpError(text: "Hubo un error en el proceso de registro. Por favor, cheque todos los campos y vuelva a intentar".localizedCore)
    }

    fileprivate func showSignUpError(text: String) {
        let alert = UIAlertController(title: text, message: "", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK".localizedCore, style: .default, handler: nil))
        self.signUpScreen.display(alertController: alert)
    }
}
