//
//  HomeNewsStoriesViewController.swift
//  FinanceApp
//
//  Creado por Adiel Luna on 3/16/19.
//  Copyright © 2019 Instamobile. All rights reserved.
//

import UIKit

class NewsPreviewStoriesViewController: ATCGenericCollectionViewController {
    var uiConfig: ATCUIGenericConfigurationProtocol
    var dsProvider: FinanceDataSourceProvider

    init(dsProvider: FinanceDataSourceProvider, uiConfig: ATCUIGenericConfigurationProtocol) {
        self.uiConfig = uiConfig
        self.dsProvider = dsProvider

        let layout = ATCCollectionViewFlowLayout()
        let config = ATCGenericCollectionViewControllerConfiguration(pullToRefreshEnabled: false,
                                                                     pullToRefreshTintColor: uiConfig.mainThemeBackgroundColor,
                                                                     collectionViewBackgroundColor: uiConfig.mainThemeBackgroundColor,
                                                                     collectionViewLayout: layout,
                                                                     collectionPagingEnabled: false,
                                                                     hideScrollIndicators: true,
                                                                     hidesNavigationBar: false,
                                                                     headerNibName: nil,
                                                                     scrollEnabled: false,
                                                                     uiConfig: uiConfig,
                                                                     emptyViewModel: nil)
        super.init(configuration: config)
        self.genericDataSource = dsProvider.newsHomeDataSource
        self.use(adapter: CardHeaderRowAdapter(uiConfig: uiConfig), for: "CardHeaderModel")
        self.use(adapter: CardFooterRowAdapter(uiConfig: uiConfig), for: "CardFooterModel")
        self.use(adapter: FinanceNewsRowAdapter(uiConfig: uiConfig), for: "ATCFinanceNewsModel")

        self.selectionBlock = {[weak self] (navController, object, indexPath) in
            guard let strongSelf = self else { return }
            if object is CardFooterModel {
                let vc = NewsViewController(dsProvider: strongSelf.dsProvider, uiConfig: strongSelf.uiConfig)
                strongSelf.navigationController?.pushViewController(vc, animated: true)
            } else if let news = object as? ATCFinanceNewsModel {
                if let url = URL(string: news.url) {
                    let vc = ATCWebViewController(url: url, title: news.publication)
                    strongSelf.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
