import UIKit

class Finance2UIConfiguration: ATCUIGenericConfigurationProtocol, ATCOnboardingServerConfigurationProtocol {
        
    let mainThemeBackgroundColor: UIColor = UIColor.modedColor(light: "#ffffff", dark: "#121212")
    let mainThemeForegroundColor: UIColor = UIColor(hexString: "#7DA5E0")
    let mainTextColor: UIColor = UIColor.darkModeColor(hexString: "#136CE1")
    let mainSubtextColor: UIColor = UIColor.darkModeColor(hexString: "#7DA5E0")
    let statusBarStyle: UIStatusBarStyle = .lightContent
    let hairlineColor: UIColor = UIColor.darkModeColor(hexString: "#7DA5E0")

    let colorGray0: UIColor = UIColor.darkModeColor(hexString: "#000000")
    let colorGray3: UIColor = UIColor.darkModeColor(hexString: "#333333")
    let colorGray9: UIColor = UIColor.darkModeColor(hexString: "#f4f4f4")

    let regularSmallFont = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)!
    let regularMediumFont = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)!
    let regularLargeFont = UIFont(name: "AppleSDGothicNeo-Regular", size: 20)!
    let mediumBoldFont = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)!
    let boldLargeFont = UIFont(name: "AppleSDGothicNeo-Bold", size: 20)!
    let boldSmallFont = UIFont(name: "AppleSDGothicNeo-Bold", size: 12)!
    let boldSuperSmallFont = UIFont(name: "AppleSDGothicNeo-Bold", size: 10)!
    let boldSuperLargeFont = UIFont(name: "AppleSDGothicNeo-Bold", size: 28)!

    let italicMediumFont = UIFont(name: "TrebuchetMS-Italic", size: 14)!

    let homeImage = UIImage.localImage("home-icon", template: true)
    let expensesImage = UIImage.localImage("expenses-pie-icon", template: true)
    let accountsImage = UIImage.localImage("accounts-list-icon", template: true)
    let portfolioImage = UIImage.localImage("add-filled-icon", template: true)
    let notificationsImage = UIImage.localImage("bell-icon", template: true)
    let profileImage = UIImage.localImage("settings-menu-item", template: true)
    let newsImage = UIImage.localImage("news-icon", template: true)
    let settingsImage = UIImage.localImage("settings-menu-item", template: true)

    func regularFont(size: CGFloat) -> UIFont {
        return UIFont(name: "AppleSDGothicNeo-Regular", size: size)!
    }

    func boldFont(size: CGFloat) -> UIFont {
        return UIFont(name: "AppleSDGothicNeo-Bold", size: size)!
    }

    func lightFont(size: CGFloat) -> UIFont {
        return UIFont(name: "AppleSDGothicNeo-Light", size: size)!
    }
    
    func configureUI() {
        UITabBar.appearance().barTintColor = self.mainThemeBackgroundColor
        UITabBar.appearance().tintColor = self.mainThemeForegroundColor
        UITabBar.appearance().unselectedItemTintColor = self.mainTextColor
        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor : self.mainTextColor,
                                                          .font: self.boldSuperSmallFont],
                                                         for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor : self.mainThemeForegroundColor,
                                                          .font: self.boldSuperSmallFont],
                                                         for: .selected)

//        UITabBar.appearance().backgroundImage = UIImage.colorForNavBar(self.mainThemeBackgroundColor)
//        UITabBar.appearance().shadowImage = UIImage.colorForNavBar(self.hairlineColor)
        
 
        UINavigationBar.appearance().barTintColor = self.mainThemeForegroundColor
        UINavigationBar.appearance().tintColor = UIColor(hexString: "#136CE1")
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        //        UINavigationBar.appearance().isTranslucent = false
        //
        //        UITabBar.appearance().tintColor = ATCUIConfiguration.shared.mainThemeColor
        //        UITabBar.appearance().barTintColor = ATCUIConfiguration.shared.tabBarBarTintColor
        //        if #available(iOS 10.0, *) {
        //            UITabBar.appearance().unselectedItemTintColor = ATCUIConfiguration.shared.mainThemeColor
        //        }
    }

    var isFirebaseAuthEnabled: Bool {
        return true
    }
    
    var isFirebaseDatabaseEnabled: Bool {
        return true
    }
    
    var isInstagramIntegrationEnabled: Bool {
        return true
    }
    
    var isPhoneAuthEnabled: Bool {
        return false
    }
    
    var appIdentifier: String {
        return "Finance - iOSAppTemplates"
    }
}
