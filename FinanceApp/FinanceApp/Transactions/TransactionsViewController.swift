//
//  TransactionsViewController.swift
//  FinanceApp
//
//  Creado por Adiel Luna on 3/20/19.
//  Copyright © 2019 Instamobile. All rights reserved.
//

import UIKit

class TransactionsViewController: ATCGenericCollectionViewController {
    let uiConfig: ATCUIGenericConfigurationProtocol
    let dsProvider: FinanceDataSourceProvider

    init(transactionDataSource: ATCGenericCollectionViewControllerDataSource,
         dsProvider: FinanceDataSourceProvider,
         scrollingEnabled: Bool,
         uiConfig: ATCUIGenericConfigurationProtocol) {
        self.uiConfig = uiConfig
        self.dsProvider = dsProvider

        let layout = ATCCollectionViewFlowLayout()
        let emptyViewModel = CPKEmptyViewModel(image: nil, title: "No Transactions", description: "We don't see any records from your history.", callToAction: nil)
        let config = ATCGenericCollectionViewControllerConfiguration(pullToRefreshEnabled: true,
                                                                     pullToRefreshTintColor: .white,
                                                                     collectionViewBackgroundColor: uiConfig.mainThemeBackgroundColor,
                                                                     collectionViewLayout: layout,
                                                                     collectionPagingEnabled: false,
                                                                     hideScrollIndicators: true,
                                                                     hidesNavigationBar: false,
                                                                     headerNibName: nil,
                                                                     scrollEnabled: scrollingEnabled,
                                                                     uiConfig: uiConfig,
                                                                     emptyViewModel: emptyViewModel)
        super.init(configuration: config)
        self.genericDataSource = transactionDataSource
        self.use(adapter: TransactionsRowAdapter(uiConfig: uiConfig), for: "ATCFinanceTransaction")
        self.title = "Transactions"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
