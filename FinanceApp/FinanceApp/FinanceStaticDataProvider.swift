//
//  FinanceStaticDataProvider.swift
//  FinanceApp
//
//  Creado por Adiel Luna on 3/10/19.
//  Copyright © 2019 Instamobile. All rights reserved.
//

import Charts
import UIKit
import FirebaseFirestore

var backArrowUnicode = "\u{2190}"


class FinanceStaticDataProvider: NSObject {
    static let walkthroughs = [
        ATCWalkthroughModel(title: "Administrador de ingresos", subtitle: "Visualiza tus ingresos y ten control de ellos", icon: "analytics-icon"),
        ATCWalkthroughModel(title: "Control de gastos", subtitle: "Monitorea tus gastos y visualizalos por categoría", icon: "expenses-pie-icon"),
        ]

    static let notifications: [ATCNotification] = [
        ATCNotification(category: "TRANSACTIONS", content: "You paid $25 with your BofA credit card for Safeway.", icon: "calendar-grid-icon", isNotSeen: true, createdAt: Date().fiveHoursAgo),
        ATCNotification(category: "SALARY RECEIVED", content: "You received $5,002 salary from your employer.", icon: "coins-filled-icon", isNotSeen: true, createdAt: Date().twoDaysAgo),
        ATCNotification(category: "PORTFOLIO MILESTONE", content: "Congratulations! Your net worth just surpassed $10,000!", icon: "caret-icon", isNotSeen: false, createdAt: Date().threeDaysAgo),
        ATCNotification(category: "DIVIDEND RECEIVED", content: "You received a dividend in the amount of @27.73 (from XLE)", icon: "bubbles-icon", isNotSeen: true, createdAt: Date().threeDaysAgo),
        ATCNotification(category: "SHARES BOUGHT", content: "You've just bought 53 shares of $NFLX for $4,023.", icon: "customers-icon", isNotSeen: true, createdAt: Date().twoDaysAgo),
        ATCNotification(category: "DEPOSIT", content: "A deposit of $250 is scheduled for Mar 29 into your Wealthfront Savings account.", icon: "binoculars-icon", isNotSeen: false, createdAt: Date().threeDaysAgo),
        ATCNotification(category: "INTEREST", content: "You received an interest in the amount of $2,76 on your Cash account.", icon: "customers-icon", isNotSeen: false, createdAt: Date().fourDaysAgo),
        ]

    static let numericKeys: [ATCKeyboardKey] = [
        ATCKeyboardKey(value: "1", displayValue: "1"),
        ATCKeyboardKey(value: "2", displayValue: "2"),
        ATCKeyboardKey(value: "3", displayValue: "3"),
        ATCKeyboardKey(value: "4", displayValue: "4"),
        ATCKeyboardKey(value: "5", displayValue: "5"),
        ATCKeyboardKey(value: "6", displayValue: "6"),
        ATCKeyboardKey(value: "7", displayValue: "7"),
        ATCKeyboardKey(value: "8", displayValue: "8"),
        ATCKeyboardKey(value: "9", displayValue: "9"),
        ATCKeyboardKey(value: ".", displayValue: "."),
        ATCKeyboardKey(value: "0", displayValue: "0"),
        ATCKeyboardKey(value: backArrowUnicode, displayValue: backArrowUnicode),
        ]

    static let expensesChart = ATCPieChart(entries: [
        PieChartDataEntry(value: 25, label: "Renta"),
        PieChartDataEntry(value: 19, label: "Restaurantes"),
        PieChartDataEntry(value: 30, label: "Bebidas"),
        PieChartDataEntry(value: 10, label: "Transporte"),
        PieChartDataEntry(value: 18, label: "Comida"),
        ],
                                           name: "",
                                           format: "%.00f%%",
                                           descriptionText: "")


    static let porfolioChart = ATCPieChart(entries: [
        PieChartDataEntry(value: 25, label: "Stocks"),
        PieChartDataEntry(value: 19, label: "Bonds"),
        PieChartDataEntry(value: 30, label: "Real Estate"),
        PieChartDataEntry(value: 10, label: "Cash"),
        PieChartDataEntry(value: 10, label: "Cryto"),
        PieChartDataEntry(value: 18, label: "Gold"),
        ],
                                           name: "",
                                           format: "%.00f%%",
                                           descriptionText: "")

    static let barChart = ATCBarChart(groups: [ATCBarChartGroup(numbers: [4000, 5500, 7400, 6500], name: "United States"),
                                               ATCBarChartGroup(numbers: [4000, 5000, 6000, 5500], name: "United Kingdom"),
                                               ATCBarChartGroup(numbers: [4400, 4900, 5500, 7200], name: "India")],
                                      name: "Revenue by Country",
                                      labels: ["Q4 17", "Q1", "Q2", "Q3"],
                                      valueFormat: "$%.00f")

    static let netWorthNumbers: [Double] = [7000, 7500, 6900, 7300, 7300, 7100, 7200,
                                            6800, 8000, 8100, 7900, 8500, 9000, 7000, 9500, 11000,
                                            10500, 10000, 9500, 9300, 9200, 10000, 10500, 10600, 11000,
                                            12000, 11500, 11500, 11500, 11300, 10500,
                                            11000, 10600, 10500, 9200, 10000]
    static var lineChart: ATCLineChart {
        return ATCLineChart(numbers: netWorthNumbers.map({$0 + Double.random(in: -2000 ..< 2000)}), name: "Net Worth")
    }
    static let currencyString = "$"

    static let stocks = [
        ATCFinanceAsset(title: "Twitter",
                        ticker: "TWTR",
                        priceChange: "0.25%",
                        isPositive: false,
                        price: "$31.05",
                        color: "#1CA1F2",
                        logoURL: "https://cfcdnpull-creativefreedoml.netdna-ssl.com/wp-content/uploads/2017/06/Twitter-featured.png"),
        ATCFinanceAsset(title: "Facebook",
                        ticker: "FB",
                        priceChange: "2.4%",
                        isPositive: true,
                        price: "$175",
                        color: "#1CA1F2",
                        logoURL: "https://images-na.ssl-images-amazon.com/images/I/21-leKb-zsL._SY355_.png"),
        ATCFinanceAsset(title: "Netflix",
                        ticker: "NFLX",
                        priceChange: "1.43%",
                        isPositive: false,
                        price: "$180",
                        color: "#ffffff",
                        logoURL: "https://pbs.twimg.com/profile_images/1089957236221329409/rsMZ82D3_400x400.jpg"),
        ATCFinanceAsset(title: "Google",
                        ticker: "GOOG",
                        priceChange: "0.75%",
                        isPositive: true,
                        price: "$1106",
                        color: "#ffffff",
                        logoURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/1024px-Google_%22G%22_Logo.svg.png"),
        ATCFinanceAsset(title: "Amazon",
                        ticker: "AMZN",
                        priceChange: "0.25%",
                        isPositive: true,
                        price: "$1875",
                        color: "#ffffff",
                        logoURL: "https://www.fineprintart.com/images/blog/amazon-logo/amazon_logo_history_5.jpg")
    ]
    
    static let cryptos = [
        ATCFinanceAsset(title: "Bitcoin",
                        ticker: "BTC",
                        priceChange: "5.25%",
                        isPositive: true,
                        price: "$3900",
                        color: "#1CA1F2",
                        logoURL: "https://en.bitcoin.it/w/images/en/2/29/BC_Logo_.png"),
        ATCFinanceAsset(title: "Ethereum",
                        ticker: "ETH",
                        priceChange: "2.65%",
                        isPositive: true,
                        price: "$157.08",
                        color: "#1CA1F2",
                        logoURL: "https://yt3.ggpht.com/a-/AAuE7mAn0bQ1H-wrEoxpkz03RNleGHvt0EmcSx4O4w=s288-mo-c-c0xffffffff-rj-k-no"),
        ATCFinanceAsset(title: "Litecoin",
                        ticker: "LTC",
                        priceChange: "7.95%",
                        isPositive: true,
                        price: "$59.94",
                        color: "#1CA1F2",
                        logoURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e3/Litecoin_Logo.jpg/600px-Litecoin_Logo.jpg"),
        ATCFinanceAsset(title: "Bitcoin Cash",
                        ticker: "BCH",
                        priceChange: "8.43%",
                        isPositive: true,
                        price: "$147.17",
                        color: "#1CA1F2",
                        logoURL: "https://cfcdnpull-creativefreedoml.netdna-ssl.com/wp-content/uploads/2017/06/Twitter-featured.png"),
    ]

    static var url = "https://www.bloomberg.com/news/articles/2019-03-25/stocks-in-asia-look-mixed-as-yields-extend-decline-markets-wrap"
    static var news = [
        ATCFinanceNewsModel(title: "Why the worst may already be over for the global economy",
                            publication: "Bloomberg",
                            createdAt: Date().twoHoursAgo,
                            url: url),
        ATCFinanceNewsModel(title: "Boeing ended the week worth $25 billion less than it started",
                            publication: "Quartz", createdAt: Date().twoDaysAgo,
                            url: url),
        ATCFinanceNewsModel(title: "Better economic data needed before Wall Street can rise back to all-time highs",
                            publication: "CNBC", createdAt: Date().oneWeekAgo,
                            url: url),
        ATCFinanceNewsModel(title: "Apple Watch detects irregular heart beat in large U.S. study",
                            publication: "Reuters", createdAt: Date().oneWeekAgo,
                            url: url),
        ATCFinanceNewsModel(title: "Trump urges General Motors to reopen Ohio plant in tweet",
                            publication: "Reuters", createdAt: Date().oneMonthAgo,
                            url: url),
        ATCFinanceNewsModel(title: "Why thw worst may already be over for the global economy",
                            publication: "Bloomberg", createdAt: Date().oneMonthAgo,
                            url: url),
        ATCFinanceNewsModel(title: "Why thw worst may already be over for the global economy",
                            publication: "Bloomberg", createdAt: Date().oneMonthAgo,
                            url: url),
        ]

    static var expenseCategories: [ATCExpenseCategory] = [
        ATCExpenseCategory(title: "Hogar y utilidades",
                           color: "#342323",
                           logoURL: "https://www.instamobile.io/wp-content/uploads/2019/03/Screen-Shot-2019-03-27-at-10.02.12-PM.png",
                           spending: "$10,400.00"),
        ATCExpenseCategory(title: "Viajes",
                           color: "#342323",
                           logoURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4tbiIUHkvzkHaMH4vC2h-ifNgo2IxGxq5pjZ8_kuoXJKqpPbBHA",
                           spending: "$8,325.89"),
        ATCExpenseCategory(title: "Transporte",
                           color: "#342323",
                           logoURL: "https://mondrian.mashable.com/uploads%252Fcard%252Fimage%252F312644%252FUber_Logobit_Digital_black.png%252F950x534__filters%253Aquality%252890%2529.png?signature=EovGBFsXq2bCP9auiawtB-cJKVY=&source=https%3A%2F%2Fblueprint-api-production.s3.amazonaws.com",
                           spending: "$5,023.44"),
        ATCExpenseCategory(title: "Comida",
                           color: "#342323",
                           logoURL: "https://www.instamobile.io/wp-content/uploads/2019/03/Screen-Shot-2019-03-27-at-10.02.54-PM.png",
                           spending: "$4,003.00"),
        ATCExpenseCategory(title: "Bebidas",
                           color: "#342323",
                           logoURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRFRaXksljpUSIJWBcxVMPnPFY0pqHiNaORIBW_CXghyVIjYvbmvg",
                           spending: "$3,998.23"),
        ATCExpenseCategory(title: "Renta",
                           color: "#342323",
                           logoURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ49JG1ISq63JuSM_-WKjag4Mb018qXbgAqutn63s7yGjILtk3O",
                           spending: "$3,500.98"),
        ]

    static var portfolioCashAccounts: [ATCFinanceAccount] = [
        ATCFinanceAccount(title: "Personal Savings",
                          color: "#342323",
                          logoURL: "https://theme.zdassets.com/theme_assets/586236/49e4904c4910a8ebf63b67d41f9b98b6b0933275.png",
                          amount: "$9,2875",
                          isPositive: true,
                          institution: "Wealthfront"),
        ATCFinanceAccount(title: "BofA Checkings",
                          color: "#342323",
                          logoURL: "https://static1.squarespace.com/static/5634e954e4b0f9cec0c16373/t/5bcc7f24085229820cd48c9e/1540128588808/Bofa-logo.jpg",
                          amount: "$12,030",
                          isPositive: true,
                          institution: "Bank of America"),
        ATCFinanceAccount(title: "Robinhood Cash",
                          color: "#342323",
                          logoURL: "https://c93fea60bb98e121740fc38ff31162a8.s3.amazonaws.com/wp-content/uploads/2017/04/robinhood.jpg",
                          amount: "$7,123",
                          isPositive: true,
                          institution: "Robinhood"),
        ATCFinanceAccount(title: "Coinbase USD",
                          color: "#342323",
                          logoURL: "https://assets.coingecko.com/markets/images/23/large/fe290a14-ac8f-4c90-9aed-5e72abf271f0.jpeg?1527171545",
                          amount: "$15,712",
                          isPositive: true,
                          institution: "Coinbase Pro"),
        ATCFinanceAccount(title: "BofA Savings",
                          color: "#342323",
                          logoURL: "https://static1.squarespace.com/static/5634e954e4b0f9cec0c16373/t/5bcc7f24085229820cd48c9e/1540128588808/Bofa-logo.jpg",
                          amount: "$12,030",
                          isPositive: true,
                          institution: "Bank of America"),
    ]

    static var portfolioInvestmentsAccounts: [ATCFinanceAccount] = [
        ATCFinanceAccount(title: "Personal Investment",
                          color: "#342323",
                          logoURL: "https://theme.zdassets.com/theme_assets/586236/49e4904c4910a8ebf63b67d41f9b98b6b0933275.png",
                          amount: "$9,2875",
                          isPositive: true,
                          institution: "Wealthfront"),
        ATCFinanceAccount(title: "Robinhood Personal",
                          color: "#342323",
                          logoURL: "https://c93fea60bb98e121740fc38ff31162a8.s3.amazonaws.com/wp-content/uploads/2017/04/robinhood.jpg",
                          amount: "$7,123",
                          isPositive: true,
                          institution: "Robinhood"),
        ATCFinanceAccount(title: "Personal crypto",
                          color: "#342323",
                          logoURL: "https://assets.coingecko.com/markets/images/23/large/fe290a14-ac8f-4c90-9aed-5e72abf271f0.jpeg?1527171545",
                          amount: "$15,712",
                          isPositive: true,
                          institution: "Coinbase Pro"),
        ATCFinanceAccount(title: "401(K)",
                          color: "#342323",
                          logoURL: "https://is3-ssl.mzstatic.com/image/thumb/Purple124/v4/e5/b4/12/e5b412b9-e3e6-2656-f68b-cff004ab695c/AppIcon-1x_U007emarketing-0-0-GLES2_U002c0-512MB-sRGB-0-0-0-85-220-0-0-0-9.png/246x0w.jpg",
                          amount: "$12,030",
                          isPositive: true,
                          institution: "Fidelity"),
        ATCFinanceAccount(title: "231 Brokerage",
                          color: "#342323",
                          logoURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4b/Charles_Schwab_Corporation_logo.svg/220px-Charles_Schwab_Corporation_logo.svg.png",
                          amount: "$41,802",
                          isPositive: true,
                          institution: "Charles Schwab"),
        ]

    static var portfolioLiabilitiesAccounts: [ATCFinanceAccount] = [
        ATCFinanceAccount(title: "Travel Credit Card",
                          color: "#342323",
                          logoURL: "https://static1.squarespace.com/static/5634e954e4b0f9cec0c16373/t/5bcc7f24085229820cd48c9e/1540128588808/Bofa-logo.jpg",
                          amount: "$1,200",
                          isPositive: true,
                          institution: "Bank of America"),
        ATCFinanceAccount(title: "American Express basic",
                          color: "#342323",
                          logoURL: "https://blockchainstocks.com/wp-content/uploads/2018/08/American-Express_Pentagram_Boteco-Design_04-696x522.jpg",
                          amount: "$500",
                          isPositive: true,
                          institution: "American Express"),
        ATCFinanceAccount(title: "Saphire Reserved",
                          color: "#342323",
                          logoURL: "https://uponarriving.com/wp-content/uploads/2016/02/Chase-Logo-300x270.png",
                          amount: "$2,114",
                          isPositive: true,
                          institution: "Chase Bank"),
        ]

    static var bankAccounts: [ATCFinanceAccount] = [
        ATCFinanceAccount(title: "Personal Investment",
                          color: "#342323",
                          logoURL: "https://theme.zdassets.com/theme_assets/586236/49e4904c4910a8ebf63b67d41f9b98b6b0933275.png",
                          amount: "$9,2875",
                          isPositive: true,
                          institution: "Wealthfront"),
        ATCFinanceAccount(title: "Robinhood Personal",
                          color: "#342323",
                          logoURL: "https://c93fea60bb98e121740fc38ff31162a8.s3.amazonaws.com/wp-content/uploads/2017/04/robinhood.jpg",
                          amount: "$7,123",
                          isPositive: true,
                          institution: "Robinhood"),
        ATCFinanceAccount(title: "Personal crypto",
                          color: "#342323",
                          logoURL: "https://assets.coingecko.com/markets/images/23/large/fe290a14-ac8f-4c90-9aed-5e72abf271f0.jpeg?1527171545",
                          amount: "$15,712",
                          isPositive: true,
                          institution: "Coinbase Pro"),
        ATCFinanceAccount(title: "401(K)",
                          color: "#342323",
                          logoURL: "https://is3-ssl.mzstatic.com/image/thumb/Purple124/v4/e5/b4/12/e5b412b9-e3e6-2656-f68b-cff004ab695c/AppIcon-1x_U007emarketing-0-0-GLES2_U002c0-512MB-sRGB-0-0-0-85-220-0-0-0-9.png/246x0w.jpg",
                          amount: "$12,030",
                          isPositive: true,
                          institution: "Fidelity"),
        ATCFinanceAccount(title: "231 Brokerage",
                          color: "#342323",
                          logoURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4b/Charles_Schwab_Corporation_logo.svg/220px-Charles_Schwab_Corporation_logo.svg.png",
                          amount: "$41,802",
                          isPositive: true,
                          institution: "Charles Schwab"),
        ATCFinanceAccount(title: "Travel Credit Card",
                          color: "#342323",
                          logoURL: "https://static1.squarespace.com/static/5634e954e4b0f9cec0c16373/t/5bcc7f24085229820cd48c9e/1540128588808/Bofa-logo.jpg",
                          amount: "$1,200",
                          isPositive: true,
                          institution: "Bank of America"),
        ATCFinanceAccount(title: "American Express basic",
                          color: "#342323",
                          logoURL: "https://blockchainstocks.com/wp-content/uploads/2018/08/American-Express_Pentagram_Boteco-Design_04-696x522.jpg",
                          amount: "$500",
                          isPositive: true,
                          institution: "American Express"),
        ATCFinanceAccount(title: "Saphire Reserved",
                          color: "#342323",
                          logoURL: "https://uponarriving.com/wp-content/uploads/2016/02/Chase-Logo-300x270.png",
                          amount: "$2,114",
                          isPositive: true,
                          institution: "Chase Bank"),
        ]
    
    static var transactions: [ATCFinanceTransaction] = [
        ATCFinanceTransaction(title: "Proper SF Hotel San Francisco", isPositive: false, price: "$55.00", date: Date()),
        ATCFinanceTransaction(title: "The Grind Cafe San Francisco", isPositive: false, price: "$26.39", date: Date().twoHoursAgo),
        ATCFinanceTransaction(title: "Payment Received - Mark Cuban", isPositive: true, price: "$14.99", date: Date().yesterday),
        ATCFinanceTransaction(title: "Prime Video * MW30C9AK", isPositive: false, price: "$14.99", date: Date().yesterday),
        ATCFinanceTransaction(title: "Chez Maman West CA", isPositive: false, price: "$72.00", date: Date().yesterday),
        ATCFinanceTransaction(title: "Netflix.com CA", isPositive: false, price: "$7.99", date: Date().twoDaysAgo),
        ATCFinanceTransaction(title: "Payment Received - Instamobile", isPositive: true, price: "$99.00", date: Date().yesterday),
        ATCFinanceTransaction(title: "Bank of America Credit Card Bill", isPositive: false, price: "$1771.23", date: Date().oneWeekAgo),
        ATCFinanceTransaction(title: "Safeway Groceries", isPositive: false, price: "$89.05", date: Date().oneWeekAgo),
        ATCFinanceTransaction(title: "Uber.com Ride sharing", isPositive: false, price: "$28.74", date: Date().oneMonthAgo),
        ATCFinanceTransaction(title: "Bar & Lounge SFO", isPositive: false, price: "$59.65", date: Date().oneMonthAgo),
        ]

    static var assetPosition = ATCFinanceAssetPosition(title: "Your Position",
                                                       shares: 5,
                                                       equity: "$955.00",
                                                       avgCost: "171.46",
                                                       portfolioDiversity: "7.12%",
                                                       totalReturn: "+$97.71 (+11.40%)",
                                                       todayReturn: "-$20.45 (-2.10%)")

    static var assetStats = ATCFinanceAssetStats(open: "195.30",
                                                 high: "197.69",
                                                 low: "190.79",
                                                 wk52High: "233.47",
                                                 wk52Low: "142.00",
                                                 volume: "19.49M",
                                                 avgVol: "32.65M",
                                                 mktCap: "903.63B",
                                                 peRatio: "15.71",
                                                 divYield: "1.20")

    static var institutions = [
        ATCFinanceInstitution(title: "Chase Bank", imageUrl: "https://uponarriving.com/wp-content/uploads/2016/02/Chase-Logo-300x270.png"),
        ATCFinanceInstitution(title: "Fidelity NetBenefits", imageUrl: "https://is3-ssl.mzstatic.com/image/thumb/Purple124/v4/e5/b4/12/e5b412b9-e3e6-2656-f68b-cff004ab695c/AppIcon-1x_U007emarketing-0-0-GLES2_U002c0-512MB-sRGB-0-0-0-85-220-0-0-0-9.png/246x0w.jpg"),
        ATCFinanceInstitution(title: "Wells Fargo Bank", imageUrl: "https://www.wfae.org/sites/wfae/files/styles/x_large/public/201901/wells-logo.jpg"),
        ATCFinanceInstitution(title: "Vanguard", imageUrl: "https://i1.wp.com/millennialmoney.com/wp-content/uploads/2015/09/vanguard.logo_.png"),
        ATCFinanceInstitution(title: "Fidelity", imageUrl: "https://is3-ssl.mzstatic.com/image/thumb/Purple124/v4/e5/b4/12/e5b412b9-e3e6-2656-f68b-cff004ab695c/AppIcon-1x_U007emarketing-0-0-GLES2_U002c0-512MB-sRGB-0-0-0-85-220-0-0-0-9.png/246x0w.jpg"),
        ATCFinanceInstitution(title: "Capital One", imageUrl: "https://uponarriving.com/wp-content/uploads/2017/11/CapitalOne.png"),
        ATCFinanceInstitution(title: "Ally Financial", imageUrl: "https://pbs.twimg.com/profile_images/762644570568024064/Az3Nca2s_400x400.jpg"),
        ATCFinanceInstitution(title: "Wealthfront", imageUrl: "https://theme.zdassets.com/theme_assets/586236/49e4904c4910a8ebf63b67d41f9b98b6b0933275.png"),
        ATCFinanceInstitution(title: "Robinhood", imageUrl: "https://c93fea60bb98e121740fc38ff31162a8.s3.amazonaws.com/wp-content/uploads/2017/04/robinhood.jpg"),
        ATCFinanceInstitution(title: "Real Estate", imageUrl: "https://img1-placeit-net.s3-accelerate.amazonaws.com/uploads/stage/stage_image/21703/large_thumb_placeit__15_.jpg"),
        ATCFinanceInstitution(title: "Charles Schwab", imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4b/Charles_Schwab_Corporation_logo.svg/220px-Charles_Schwab_Corporation_logo.svg.png"),
        ATCFinanceInstitution(title: "Bank of America", imageUrl: "https://static1.squarespace.com/static/5634e954e4b0f9cec0c16373/t/5bcc7f24085229820cd48c9e/1540128588808/Bofa-logo.jpg"),
        ATCFinanceInstitution(title: "Coinbase", imageUrl: "https://assets.coingecko.com/markets/images/23/large/fe290a14-ac8f-4c90-9aed-5e72abf271f0.jpeg?1527171545"),
        ]
}

class ExpenseObject: NSObject {
    static var expenses : [ATCExpenseCategory] = [ATCExpenseCategory] ()
}


func fetchExpenses(completion: @escaping ([ATCExpenseCategory]) -> Void) {
    let collectionRef = Firestore.firestore().collection("expenses")
    
    collectionRef.getDocuments { (querySnapshot, error) in
        if let error = error {
            print("Error al obtener documentos: \(error)")
        } else {
            for document in querySnapshot!.documents {
                let data = document.data()
                let color = data["color"] as? String ?? ""
                let logoURL = data["logoURL"] as? String ?? ""
                let spending = data["spending"] as? String ?? ""
                let title = data["title"] as? String ?? ""
                
                let expenseCategory = ATCExpenseCategory(title: title, color: color,
                                                         logoURL: logoURL,
                                                         spending: spending)
                ExpenseObject.expenses.append(expenseCategory)
            }
        }
        // Call the completion handler and pass in the mexpenses array
        completion(ExpenseObject.expenses)
    }
    
}



