//
//  ATCFirebaseUserManager.swift
//  MultiVendorApp
//
//  Created by Mac  on 23/06/20.
//  Copyright © 2020 Instamobile. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Geofirestore
import CoreLocation

class ATCFirebaseUserManager {
    var observerSignalRef: DocumentReference?
    var signalListener: ListenerRegistration?
    
    func observerOrderUpdateRequestSignal(user: ATCUser) {
        if let uid = user.uid {
            self.observerSignalRef = Firestore.firestore().collection("users").document(uid)
            self.observerSignalRef?.addSnapshotListener({ [weak self] (document, error) in
                if let data = document?.data() {
                    if let needOrdersUpdate = data["needOrdersUpdate"] as? Bool, needOrdersUpdate {
                        NotificationCenter.default.post(name: kOrderUpdateNotificationName, object: nil)
                        self?.updateUserNeedOrderStatus(customerID: uid)
                    }
                }
            })
        }
    }
    
    func updateUserNeedOrderStatus(customerID: String) {
        Firestore.firestore().collection("users").document(customerID).updateData(
            ["needOrdersUpdate" : false]
        )
    }
    
    func removeOrderUpdateRequestSignal() {
        if let signalListener = signalListener {
            signalListener.remove()
            self.signalListener = nil
        }
    }
}
