//
//  ExpenseDataProvider.swift
//  FinanceApp
//
//  Created by Adiel on 05/05/23.
//  Copyright © 2023 Instamobile. All rights reserved.
//

import Foundation
import FirebaseFirestore


class ExpenseDataProvider: ATCGenericCollectionViewControllerDataSource{
    weak var delegate: ATCGenericCollectionViewControllerDataSourceDelegate?
    
    
    let db = Firestore.firestore()
    var expenses : [ATCExpenseCategory] = [ATCExpenseCategory] ()
    
    func object(at index: Int) -> ATCGenericBaseModel? {
        if (index < expenses.count) {
            return expenses[index]
        }
        return nil
    }
    func numberOfObjects() -> Int {
        return expenses.count
    }
    func loadFirst() {
        
        var results : [ATCExpenseCategory] = [ATCExpenseCategory] ()
        
        db.collection("expenses").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error al obtener documento: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let ti = data["title"] as! String
                    let co = data["color"] as! String
                    let url = data["logoURL"] as! String
                    let sp = data["spending"] as! String
                    let expense = ATCExpenseCategory(title: ti, color: co, logoURL: url, spending: sp)
                    
                    results.append(expense)
                }
                self.expenses = results
            }
        }

        
        self.delegate?.genericCollectionViewControllerDataSource(self, didLoadFirst: expenses)
        
        
    }
    func loadBottom() {} // this is optional, only if you do pagination
    func loadTop() {} // this is optional, only if you want pull to refresh
    
}
