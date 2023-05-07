//
//  FinanceProfileViewController.swift
//  FinanceApp
//
//  Creado por Adiel Luna on 3/24/19.
//  Copyright © 2019 Instamobile. All rights reserved.
//

import Eureka
import UIKit

class FinanceAccountDetailsViewController: FormViewController {
    var user: ATCUser
    var updater: ATCProfileUpdaterProtocol

    init(user: ATCUser,
         updater: ATCProfileUpdaterProtocol) {
        self.user = user
        self.updater = updater
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(didTapDone))
        //        if (cancelEnabled) {
        //            self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancel))
        //        }
        self.title = "Cuenta"
        form +++ Eureka.Section("Perfil")
            <<< TextRow(){ row in
                row.title = "Nombre"
                row.placeholder = "Tu nombre"
                row.value = user.firstName
                row.tag = "firstname"
            }
            <<< TextRow(){ row in
                row.title = "Apellido"
                row.placeholder = "Tu apellido"
                row.value = user.lastName
                row.tag = "lastname"
            }
            <<< TextRow(){ row in
                row.title = "Usuario"
                row.placeholder = "Tu nombre de usuario"
                row.value = user.username
                row.tag = "username"
            }
            <<< ActionSheetRow<String>() {
                $0.title = "Genero"
                $0.selectorTitle = "Escoge tu genero"
                $0.options = ["No seleccionado", "Mujer", "Hombre"]
                    $0.value = ""
                    $0.tag = "gender"
            }
            +++ Eureka.Section("Detalles Privados")
            <<< TextRow(){ row in
                row.title = "E-mail"
                row.placeholder = "Tu correo electrónico"
                row.value = user.email
                row.tag = "email"
        }
    }

    @objc private func didTapDone() {
        var lastName = ""
        var firstName = ""
        var email = ""
        var username = ""
        var gender = ""

        if let row = form.rowBy(tag: "lastname") as? TextRow {
            lastName = row.value ?? ""
        }
        if let row = form.rowBy(tag: "firstname") as? TextRow {
            firstName = row.value ?? ""
        }
        if let row = form.rowBy(tag: "email") as? TextRow {
            email = row.value ?? ""
        }
        if let row = form.rowBy(tag: "username") as? TextRow {
            username = row.value ?? ""
        }
        if let row = form.rowBy(tag: "gender") as? ActionSheetRow<String> {
            gender = row.value ?? ""
        }
        if  email == "" || firstName == "" || gender == "" {
            let alertVC = UIAlertController(title: "Por favor completa tu perfil",
                                            message: "Llena todos los campos",
                                            preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
            return
        }
        self.updater.update(user: user, email: email, firstName: firstName, lastName: lastName, username: username) { (success) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }

    @objc private func didTapCancel() {
        self.dismiss(animated: true, completion: nil)
    }
}
