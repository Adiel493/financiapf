//
//  FinanceDataSourceProvider.swift
//  FinanceApp
//
//  Creado por Adiel Luna on 3/16/19.
//  Copyright © 2019 Instamobile. All rights reserved.
//

import UIKit

class FinanceDataSourceProvider: ATCFinanceDataSourceProviderProtocol {
    let uiConfig: ATCUIGenericConfigurationProtocol
    var user: ATCUser?

    init(uiConfig: ATCUIGenericConfigurationProtocol) {
        self.uiConfig = uiConfig
    }

    func fetchLineChart(for selectedDate: ATCChartDate, completion: (_ chart: ATCLineChart?) -> Void) -> Void {
        completion(FinanceStaticDataProvider.lineChart)
    }

    func fetchStockChart(for selectedDate: ATCChartDate, completion: (_ chart: ATCLineChart?) -> Void) -> Void {
        completion(FinanceStaticDataProvider.lineChart)
    }

    func fetchBankAccountChart(for account: ATCFinanceAccount, selectedDate: ATCChartDate, completion: (_ chart: ATCLineChart?) -> Void) -> Void {
        completion(FinanceStaticDataProvider.lineChart)
    }

    func fetchCryptosChart(for selectedDate: ATCChartDate, completion: (_ chart: ATCLineChart?) -> Void) -> Void {
        completion(FinanceStaticDataProvider.lineChart)
    }

    func fetchAssetChart(for asset: ATCFinanceAsset, selectedDate: ATCChartDate, completion: (_ chart: ATCLineChart?) -> Void) -> Void {
        completion(FinanceStaticDataProvider.lineChart)
    }

    func fetchAssetDetails(for user: ATCUser?, asset: ATCFinanceAsset, completion: (_ position: ATCFinanceAssetPosition?, _ stats: ATCFinanceAssetStats, _ news: [ATCFinanceNewsModel]) -> Void) -> Void {
        completion(FinanceStaticDataProvider.assetPosition, FinanceStaticDataProvider.assetStats, FinanceStaticDataProvider.news)
    }

    var chartConfig: ATCLineChartConfiguration {
        return ATCLineChartConfiguration(circleHoleColor: uiConfig.mainThemeForegroundColor,
                                         gradientStartColor: UIColor(hexString: "#e9973d", alpha: 0.6),
                                         gradientEndColor: UIColor(hexString: "#e9973d", alpha: 0.6),
                                         lineColor: UIColor(hexString: "#e9973d"),
                                         leftAxisColor: uiConfig.mainSubtextColor,
                                         backgroundColor: uiConfig.mainThemeBackgroundColor,
                                         descriptionFont: uiConfig.regularLargeFont,
                                         descriptionColor: uiConfig.mainThemeForegroundColor)
    }

    var stocksHomeDataSource: ATCGenericCollectionViewControllerDataSource {
        return ATCGenericLocalHeteroDataSource(items:
            [CardHeaderModel(title: "Stocks")] +
                FinanceStaticDataProvider.stocks +
                [CardFooterModel(title: "View all stocks")]
        )
    }

    var cryptoHomeDataSource: ATCGenericCollectionViewControllerDataSource {
        return ATCGenericLocalHeteroDataSource(items:
            [CardHeaderModel(title: "Cryptocurrencies")] +
                FinanceStaticDataProvider.cryptos +
                [CardFooterModel(title: "View all cryptocurrencies")]
        )    }

    var newsHomeDataSource: ATCGenericCollectionViewControllerDataSource {
        return ATCGenericLocalHeteroDataSource(items:
            [CardHeaderModel(title: "Top Stories")] +
                FinanceStaticDataProvider.news +
                [CardFooterModel(title: "View more news")]
        )
    }
    
    func expenseCategoriesDataSource(completion: @escaping (ATCGenericLocalHeteroDataSource) -> Void) {
        getExpenses { expenses in
            let dataSource = ATCGenericLocalHeteroDataSource(items: [CardHeaderModel(title: "Top Categorías de Gastos")] + expenses)
            completion(dataSource)
        }
    }


    var allExpenseCategoriesDataSource: ATCGenericCollectionViewControllerDataSource {
        return ATCGenericLocalHeteroDataSource(items:
            [CardHeaderModel(title: "All Spending Categories")] +
                FinanceStaticDataProvider.expenseCategories
        )
    }
    
    func portfolioCashDataSource(completion: @escaping (ATCGenericLocalHeteroDataSource) -> Void) {
        getIncome { incomes in
            let dataSource = ATCGenericLocalHeteroDataSource(items: [CardHeaderModel(title: "Por pagar")] + incomes)
            completion(dataSource)
        }
    }

    var portfolioCashDataSource: ATCGenericCollectionViewControllerDataSource {
        return ATCGenericLocalHeteroDataSource(items:
            [CardHeaderModel(title: "Por Pagar")] +
                FinanceStaticDataProvider.portfolioCashAccounts
        )
    }
    
    var portfolioInvestmentsDataSource: ATCGenericCollectionViewControllerDataSource {
        return ATCGenericLocalHeteroDataSource(items:
            [CardHeaderModel(title: "Investments")] +
                FinanceStaticDataProvider.portfolioInvestmentsAccounts
        )
    }

    var portfolioLiabilitiesDataSource: ATCGenericCollectionViewControllerDataSource {
        return ATCGenericLocalHeteroDataSource(items:
            [CardHeaderModel(title: "Liabilities")] +
                FinanceStaticDataProvider.portfolioLiabilitiesAccounts
        )
    }

    var bankAccountsDataSource: ATCGenericCollectionViewControllerDataSource {
        return ATCGenericLocalHeteroDataSource(items:
            FinanceStaticDataProvider.bankAccounts + [AddBankAccountModel()]
        )
    }

    var allStocksListDataSource: ATCGenericCollectionViewControllerDataSource {
        return ATCGenericLocalHeteroDataSource(items:
            FinanceStaticDataProvider.stocks
        )
    }

    var allCryptosListDataSource: ATCGenericCollectionViewControllerDataSource {
        return ATCGenericLocalHeteroDataSource(items:
            FinanceStaticDataProvider.cryptos
        )
    }

    var allNewsDataSource: ATCGenericCollectionViewControllerDataSource {
        return ATCGenericLocalHeteroDataSource(items:
            FinanceStaticDataProvider.news
        )
    }
    
    func transactionsDataSource(account: ATCFinanceAccount) -> ATCGenericCollectionViewControllerDataSource {
        return ATCGenericLocalHeteroDataSource(items: FinanceStaticDataProvider.transactions)
    }

    func transactionsDataSource(category: ATCExpenseCategory) -> ATCGenericCollectionViewControllerDataSource {
        return ATCGenericLocalHeteroDataSource(items: FinanceStaticDataProvider.transactions)
    }

    func notificationsDataSource() -> ATCGenericCollectionViewControllerDataSource {
        return ATCGenericLocalHeteroDataSource(items: FinanceStaticDataProvider.notifications)
    }

    var profileUpdater: ATCProfileUpdaterProtocol {
        return ATCProfileFirebaseUpdater(usersTable: "users")
    }

    var stocksSearchDataSource: ATCGenericSearchViewControllerDataSource {
        return ATCGenericLocalSearchDataSource(items: FinanceStaticDataProvider.stocks)
    }

    var cryptoSearchDataSource: ATCGenericSearchViewControllerDataSource {
        return ATCGenericLocalSearchDataSource(items: FinanceStaticDataProvider.cryptos)
    }

    var institutionsDataSource: ATCGenericCollectionViewControllerDataSource {
        return ATCGenericLocalHeteroDataSource(items: FinanceStaticDataProvider.institutions)
    }

    var tradingNumericKeys: [ATCKeyboardKey] {
        return FinanceStaticDataProvider.numericKeys
    }
}
