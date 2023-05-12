//
//  FinanceHostViewController.swift
//  FinanceApp
//
//  Creado por Adiel Luna on 3/10/19.
//  Copyright © 2019 Instamobile. All rights reserved.
//

import UIKit

class FinanceHostViewController: UIViewController, UITabBarControllerDelegate {

    let uiConfig: FinanceUIConfiguration
    let serverConfig: ATCOnboardingServerConfigurationProtocol

    let homeVC: ATCHomeViewController
    let expensesVC: ExpensesViewController
    let bankAccountsVC: BankAccountsViewController
    let newsVC: NewsViewController
    let notificationsVC: FinanceNotificationsViewController
    var profileVC: ATCProfileViewController?
    let dsProvider: ATCFinanceDataSourceProviderProtocol

    init(uiConfig: FinanceUIConfiguration,
         serverConfig: ATCOnboardingServerConfigurationProtocol,
         dsProvider: FinanceDataSourceProvider) {
        self.uiConfig = uiConfig
        self.serverConfig = serverConfig
        self.dsProvider = dsProvider

        self.homeVC = ATCHomeViewController(uiConfig: uiConfig, dsProvider: dsProvider)
        self.expensesVC = ExpensesViewController(uiConfig: uiConfig, dsProvider: dsProvider)
        self.bankAccountsVC = BankAccountsViewController(uiConfig: uiConfig, dsProvider: dsProvider)
        self.newsVC = NewsViewController(dsProvider: dsProvider, uiConfig: uiConfig)
        self.notificationsVC = FinanceNotificationsViewController(dsProvider: dsProvider, uiConfig: uiConfig)

        super.init(nibName: nil, bundle: nil)
        self.profileVC = self.profileViewController()

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var hostController: ATCHostViewController = { [unowned self] in
        guard let profileVC = profileVC else {
            fatalError()
        }
        let menuItems: [ATCNavigationItem] = [
            ATCNavigationItem(title: "",
                              viewController: homeVC,
                              image: uiConfig.homeImage,
                              type: .viewController,
                              leftTopViews: nil,
                              rightTopViews: nil),
            ATCNavigationItem(title: "",
                              viewController: expensesVC,
                              image: uiConfig.expensesImage,
                              type: .viewController),
            ATCNavigationItem(title: "",
                              viewController: notificationsVC,
                              image: uiConfig.portfolioImage,
                              type: .viewController),
            ATCNavigationItem(title: "",
                              viewController: profileVC,
                              image: uiConfig.profileImage,
                              type: .viewController)
        ]
        let menuConfiguration = ATCMenuConfiguration(user: nil,
                                                     cellClass: ATCCircledIconMenuCollectionViewCell.self,
                                                     headerHeight: 0,
                                                     items: menuItems,
                                                     uiConfig: ATCMenuUIConfiguration(itemFont: uiConfig.regularMediumFont,
                                                                                      tintColor: uiConfig.mainTextColor,
                                                                                      itemHeight: 45.0,
                                                                                      backgroundColor: uiConfig.mainThemeBackgroundColor))

        let config = ATCHostConfiguration(menuConfiguration: menuConfiguration,
                                          style: .tabBar,
                                          topNavigationRightViews: nil,
                                          titleView: nil,
                                          topNavigationLeftImage: UIImage.localImage("three-equal-lines-icon", template: true),
                                          topNavigationTintColor: uiConfig.mainThemeForegroundColor,
                                          statusBarStyle: uiConfig.statusBarStyle,
                                          uiConfig: uiConfig,
                                          pushNotificationsEnabled: true, locationUpdatesEnabled: true)
        
        let userManager: ATCSocialUserManagerProtocol? = (serverConfig.isFirebaseAuthEnabled ? ATCSocialFirebaseUserManager() : nil)
        let onboardingCoordinator = self.onboardingCoordinator(uiConfig: uiConfig, serverConfig: serverConfig, userManager: userManager)
        let walkthroughVC = self.walkthroughVC(uiConfig: uiConfig)
        let vc = ATCHostViewController(configuration: config, onboardingCoordinator: onboardingCoordinator, walkthroughVC: walkthroughVC, profilePresenter: nil)
        vc.delegate = self
        return vc
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addChildViewControllerWithView(hostController)
        hostController.view.backgroundColor = uiConfig.mainThemeBackgroundColor
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return uiConfig.statusBarStyle
    }

    fileprivate func onboardingCoordinator(uiConfig: FinanceUIConfiguration, serverConfig: ATCOnboardingServerConfigurationProtocol, userManager: ATCSocialUserManagerProtocol?) -> ATCOnboardingCoordinatorProtocol {
        let landingViewModel = ATCLandingScreenViewModel(imageIcon: "finance-app-icon-1",
                                                         title: "Bienvenido a Financia".localizedInApp,
                                                         subtitle: "".localizedInApp,
                                                         loginString: "Iniciar Sesión".localizedInApp,
                                                         signUpString: "Crear Cuenta".localizedInApp)
        
        let loginViewModel = ATCLoginScreenViewModel(contactPointField: "E-mail".localizedInApp,
                                                     passwordField: "Contraseña".localizedInApp,
                                                     title: "Iniciar Sesión".localizedInApp,
                                                     loginString: "Iniciar Sesión".localizedInApp,
                                                     facebookString: "Iniciar sesión con Facebook".localizedInApp,
                                                     separatorString: "OR".localizedInApp,
                                                     forgotPasswordString: "¿Olvidó su contraseña?".localizedInApp)
        
        let phoneLoginViewModel = ATCPhoneLoginScreenViewModel(contactPointField: "E-mail".localizedCore,
                                                               passwordField: "Password".localizedCore,
                                                               title: "Sign In".localizedCore,
                                                               loginString: "Log In".localizedCore,
                                                               sendCodeString: "Send Code".localizedCore,
                                                               submitCodeString: "Submit Code".localizedCore,
                                                               facebookString: "Facebook Login".localizedCore,
                                                               phoneNumberString: "Phone number".localizedCore,
                                                               phoneNumberLoginString: "Login with phone number".localizedCore,
                                                               emailLoginString: "Sign in with E-mail".localizedCore,
                                                               separatorString: "OR".localizedCore,
                                                               contactPoint: .email,
                                                               phoneCodeString: kPhoneVerificationConfig.phoneCode,
                                                               forgotPasswordString: "Forgot Password?".localizedCore)
        
        let signUpViewModel = ATCSignUpScreenViewModel(nameField: "Nombre Completo".localizedInApp,
                                                       phoneField: "Teléfono Móvil".localizedInApp,
                                                       emailField: "E-mail".localizedInApp,
                                                       passwordField: "Contraseña".localizedInApp,
                                                       title: "Crear una cuenta".localizedInApp,
                                                       signUpString: "Crear cuenta".localizedInApp)
        
        let phoneSignUpViewModel = ATCPhoneSignUpScreenViewModel(firstNameField: "First Name".localizedCore,
                                                                 lastNameField: "Last Name".localizedCore,
                                                                 phoneField: "Phone Number".localizedCore,
                                                                 emailField: "E-mail Address".localizedCore,
                                                                 passwordField: "Password".localizedCore,
                                                                 title: "Create new account".localizedCore,
                                                                 signUpString: "Sign Up".localizedCore,
                                                                 separatorString: "OR".localizedCore,
                                                                 contactPoint: .email,
                                                                 phoneNumberString: "Phone number".localizedCore,
                                                                 phoneNumberSignUpString: "Sign up with phone number".localizedCore,
                                                                 emailSignUpString: "Sign up with E-mail".localizedCore,
                                                                 sendCodeString: "Send Code".localizedCore,
                                                                 phoneCodeString: kPhoneVerificationConfig.phoneCode,
                                                                 submitCodeString: "Submit Code".localizedCore)
        
        let resetPasswordViewModel = ATCResetPasswordScreenViewModel(title: "Recuperar contraseña".localizedCore,
                                                                     emailField: "E-mail".localizedCore,
                                                                     resetPasswordString: "Recuperar".localizedCore)
        
        return ATCClassicOnboardingCoordinator(landingViewModel: landingViewModel,
                                               loginViewModel: loginViewModel,
                                               phoneLoginViewModel: phoneLoginViewModel,
                                               signUpViewModel: signUpViewModel,
                                               phoneSignUpViewModel: phoneSignUpViewModel,
                                               resetPasswordViewModel: resetPasswordViewModel,
                                               uiConfig: FinanceOnboardingConfiguration(config: uiConfig),
                                               serverConfig: serverConfig,
                                               userManager: userManager)
    }

    fileprivate func walkthroughVC(uiConfig: FinanceUIConfiguration) -> ATCWalkthroughViewController {
        let viewControllers = FinanceStaticDataProvider.walkthroughs.map { ATCClassicWalkthroughViewController(model: $0, uiConfig: uiConfig, nibName: "ATCClassicWalkthroughViewController", bundle: nil) }
        return ATCWalkthroughViewController(nibName: "ATCWalkthroughViewController",
                                            bundle: nil,
                                            viewControllers: viewControllers,
                                            uiConfig: uiConfig)
    }

    fileprivate func profileViewController() -> ATCProfileViewController {
        let vc = ATCProfileViewController(items: self.selfProfileItems(),
                                          uiConfig: uiConfig,
                                          selectionBlock: {[weak self] (nav, model, index) in
                                            guard let `self` = self else { return }
                                            if let _ = model as? ATCProfileButtonItem {
                                                // Logout
                                                NotificationCenter.default.post(name: kLogoutNotificationName, object: nil)
                                            } else if let item = model as? ATCProfileItem {
                                                if item.title == "Ajustes", let user = self.dsProvider.user {
                                                    let settingsVC = SettingsViewController(user: user)
                                                    self.profileVC?.navigationController?.pushViewController(settingsVC, animated: true)
                                                } else if item.title == "Cuenta", let user = self.dsProvider.user  {
                                                    let accountSettingsVC = FinanceAccountDetailsViewController(user: user, updater: self.dsProvider.profileUpdater)
                                                    self.profileVC?.navigationController?.pushViewController(accountSettingsVC, animated: true)
                                                }else if item.title == "Ayuda", let user = self.dsProvider.user  {
                                                    
                                                }
                                            }
            }
        )
        vc.title = "Ajustes"
        return vc
    }
    

    fileprivate func selfProfileItems() -> [ATCGenericBaseModel] {
        var items: [ATCGenericBaseModel] = []
        items.append(contentsOf: [ATCProfileItem(icon: UIImage.localImage("account-male-icon", template: true),
                                                 title: "Cuenta",
                                                 type: .arrow,
                                                 color: UIColor(hexString: "#136CE1")),
                                  ATCProfileItem(icon: UIImage.localImage("contact-call-icon", template: true),
                                                 title: "Ayuda",
                                                 type: .arrow,
                                                 color: UIColor(hexString: "#136CE1"))
            ]);
        return items
    }
}

extension FinanceHostViewController: ATCHostViewControllerDelegate {
    func hostViewController(_ hostViewController: ATCHostViewController, didLogin user: ATCUser) {
        self.dsProvider.user = user
        self.profileVC?.user = user
    }

    func hostViewController(_ hostViewController: ATCHostViewController, didSync user: ATCUser) {
        self.dsProvider.user = user
        self.profileVC?.user = user
    }
}
