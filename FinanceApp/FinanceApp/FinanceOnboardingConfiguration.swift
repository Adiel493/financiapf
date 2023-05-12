//
//  FinanceOnboardingConfiguration.swift
//  FinanceApp
//
//  Creado por Adiel Luna on 3/10/19.
//  Copyright © 2019 Instamobile. All rights reserved.
//

import UIKit

class FinanceOnboardingConfiguration: ATCOnboardingConfigurationProtocol {
    var backgroundColor: UIColor
    var titleColor: UIColor
    var titleFont: UIFont
    var logoTintColor: UIColor?

    var subtitleColor: UIColor
    var subtitleFont: UIFont

    var loginButtonFont: UIFont
    var loginButtonBackgroundColor: UIColor
    var loginButtonTextColor: UIColor

    var signUpButtonFont: UIFont
    var signUpButtonBackgroundColor: UIColor
    var signUpButtonTextColor: UIColor
    var signUpButtonBorderColor: UIColor

    var separatorFont: UIFont
    var separatorColor: UIColor

    var textFieldColor: UIColor
    var textFieldFont: UIFont
    var textFieldBorderColor: UIColor
    var textFieldBackgroundColor: UIColor

    var signUpTextFieldFont: UIFont
    var signUpScreenButtonFont: UIFont
    
    var otpTextFieldBackgroundColor: UIColor
    var otpTextFieldBorderColor: UIColor

    init(config: FinanceUIConfiguration) {
        backgroundColor = config.mainThemeBackgroundColor
        titleColor = config.mainThemeForegroundColor
        titleFont = config.boldSuperLargeFont
        logoTintColor = config.mainThemeForegroundColor
        subtitleFont = config.regularLargeFont
        subtitleColor = config.mainTextColor
        loginButtonFont = config.boldLargeFont
        loginButtonBackgroundColor = config.mainThemeForegroundColor
        loginButtonTextColor = config.mainThemeBackgroundColor

        signUpButtonFont = config.boldLargeFont
        signUpButtonBackgroundColor = config.mainThemeBackgroundColor
        signUpButtonTextColor = UIColor.darkModeColor(hexString: "#414665")
        signUpButtonBorderColor = UIColor.darkModeColor(hexString: "#B0B3C6")
        separatorColor = config.mainTextColor
        separatorFont = config.mediumBoldFont

        textFieldColor = UIColor.darkModeColor(hexString: "#B0B3C6")
        textFieldFont = config.regularLargeFont
        textFieldBorderColor = UIColor.darkModeColor(hexString: "#B0B3C6")
        textFieldBackgroundColor = config.mainThemeBackgroundColor

        signUpTextFieldFont = config.regularMediumFont
        signUpScreenButtonFont = config.mediumBoldFont
        
        otpTextFieldBackgroundColor = UIColor.white
        otpTextFieldBorderColor = UIColor(hexString: "#B0B3C6")
    }
}
