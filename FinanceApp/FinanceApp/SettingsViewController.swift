//
//  SettingsViewController.swift
//  FinanceApp
//
//  Creado por Adiel Luna on 3/10/19.
//  Copyright © 2019 Instamobile. All rights reserved.
//

import Eureka
import UIKit

class SettingsViewController: FormViewController {
    var user: ATCUser

    init(user: ATCUser) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save ,target: self, action: #selector(didTapDone))
        self.title = "Configuración"

        form +++ Eureka.Section("Ajustes generales")
            <<< Eureka.SwitchRow() { row in
                row.title = "Permitir notificaciones"
                row.value = true
                row.tag = "pushnotifications"
            }
            <<< Eureka.SwitchRow() { row in
                row.title = "Notificar pagos pendientes"
                row.value = false
                row.tag = "pushnotificationstransactions"
            }
            <<< Eureka.SwitchRow() { row in
                row.title = "Permitir acceso a la ubicación"
                row.value = true
                row.tag = "location"
            }
    }

    @objc private func didTapDone() {
    }

    @objc private func didTapCancel() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}
