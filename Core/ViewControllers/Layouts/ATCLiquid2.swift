//
//  ATCLiquid2.swift
//  FinanceApp
//
//  Created by Alumnos on 06/05/23.
//  Copyright © 2023 Instamobile. All rights reserved.
//

import UIKit
import FirebaseFirestore

public class ATCLiquid2: ATCCollectionViewFlowLayout, UIPickerViewDelegate, UIPickerViewDataSource{

    var pickerView: UIPickerView?
    
    var datePicker: UIDatePicker?
    var textField3: UITextField?
    var dollarLabel: UILabel?
    var centsLabel: UILabel?
    var dollarTextField: UITextField?
    var centsTextField: UITextField?

    
    var textField3Text: String?
    var dollarText: String!
    var centsText: String!

    
    var segmentControl: UISegmentedControl?
    
    let categories = [" ","Hogar y utilidades", "Viajes", "Transporte", "Comida","Bebidas","Renta", "Otro"]

    public override func prepare() {
        super.prepare()
        
        // Create picker view with desired properties
        pickerView = UIPickerView()
        pickerView?.delegate = self
        pickerView?.dataSource = self

        // Create text fields with desired properties
           
        textField3 = UITextField()
        dollarTextField = UITextField()
        centsTextField = UITextField()
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.locale = Locale.current
        if #available(iOS 13.4, *) {
            datePicker?.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
               
        
        textField3?.placeholder = "Meses por pagar (Gasto)"
        dollarTextField?.placeholder = "0"
        centsTextField?.placeholder = "00"
               
        textField3?.borderStyle = .roundedRect
        dollarTextField?.borderStyle = .roundedRect
        centsTextField?.borderStyle = .roundedRect
        
        // Create labels for dollar sign and decimal point
        dollarLabel = UILabel()
        dollarLabel?.text = "$"
        centsLabel = UILabel()
        centsLabel?.text = "."
               
               // Create a segmented control with two segments
               segmentControl = UISegmentedControl(items: ["Gasto", "Ingreso"])
               
               // Set the initial selected segment to "Gasto"
               segmentControl?.selectedSegmentIndex = 0
               
               // Create a button with desired properties
               let button = UIButton(type: .system)
               button.setTitle("Agregar", for: .normal)
               button.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
               button.backgroundColor = .blue
               button.tintColor = .white
               button.layer.cornerRadius = 8
               button.layer.shadowColor = UIColor.black.cgColor
               button.layer.shadowOffset = CGSize(width: 0, height: 2)
               button.layer.shadowOpacity = 0.3
               button.layer.shadowRadius = 4
               
               // Add text fields, segmented control, and button as subviews of the collection view
               if let collectionView = collectionView {
                   // Set the background color of the collection view
                   collectionView.backgroundColor = UIColor(red: 238/255, green: 240/255, blue: 243/255, alpha: 1)
                   collectionView.addSubview(dollarLabel!)
                   collectionView.addSubview(dollarTextField!)
                   collectionView.addSubview(centsLabel!)
                   collectionView.addSubview(centsTextField!)
                   collectionView.addSubview(pickerView!)
                   collectionView.addSubview(datePicker!)
                   collectionView.addSubview(textField3!)
                   
                   collectionView.addSubview(segmentControl!)
                   collectionView.addSubview(button)
                   
                   // Position text fields, segmented control, and button in the center of the collection view
                   pickerView?.translatesAutoresizingMaskIntoConstraints = false
                   datePicker?.translatesAutoresizingMaskIntoConstraints = false
                   textField3?.translatesAutoresizingMaskIntoConstraints = false
                   dollarLabel?.translatesAutoresizingMaskIntoConstraints = false
                   dollarTextField?.translatesAutoresizingMaskIntoConstraints = false
                   centsLabel?.translatesAutoresizingMaskIntoConstraints = false
                   centsTextField?.translatesAutoresizingMaskIntoConstraints = false
                   segmentControl?.translatesAutoresizingMaskIntoConstraints = false
                   button.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                pickerView!.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
                pickerView!.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor, constant: -220),
                pickerView!.widthAnchor.constraint(equalToConstant: 250),
                pickerView!.heightAnchor.constraint(equalToConstant: 80),
                
                datePicker!.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
                datePicker!.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor, constant: -80),
                datePicker!.widthAnchor.constraint(equalToConstant: 250),
                datePicker!.heightAnchor.constraint(equalToConstant: 80),
                
                textField3!.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
                textField3!.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor, constant: -10),
                textField3!.widthAnchor.constraint(equalToConstant: 250),
                textField3!.heightAnchor.constraint(equalToConstant: 40),
                
                dollarLabel!.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor, constant: -90),
                dollarLabel!.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor, constant: -150),
                dollarLabel!.widthAnchor.constraint(equalToConstant: 20),
                dollarLabel!.heightAnchor.constraint(equalToConstant: 40),
                
                dollarTextField!.centerXAnchor.constraint(equalTo: dollarLabel!.trailingAnchor, constant: 50),
                dollarTextField!.centerYAnchor.constraint(equalTo: dollarLabel!.centerYAnchor),
                dollarTextField!.widthAnchor.constraint(equalToConstant: 100),
                dollarTextField!.heightAnchor.constraint(equalToConstant: 40),
                
                centsLabel!.centerXAnchor.constraint(equalTo: dollarTextField!.trailingAnchor, constant: 10),
                centsLabel!.centerYAnchor.constraint(equalTo: dollarLabel!.centerYAnchor),
                centsLabel!.widthAnchor.constraint(equalToConstant: 10),
                centsLabel!.heightAnchor.constraint(equalToConstant: 40),
                
                centsTextField!.centerXAnchor.constraint(equalTo: centsLabel!.trailingAnchor, constant: 10),
                centsTextField!.centerYAnchor.constraint(equalTo: dollarLabel!.centerYAnchor),
                centsTextField!.widthAnchor.constraint(equalToConstant: 40),
                centsTextField!.heightAnchor.constraint(equalToConstant: 40),
            
                segmentControl!.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
                segmentControl!.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor, constant: -300),
                segmentControl!.widthAnchor.constraint(equalToConstant: 250),
                segmentControl!.heightAnchor.constraint(equalToConstant: 40),
                
                button.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
                button.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor, constant: 80),
                button.widthAnchor.constraint(equalToConstant: 100),
                button.heightAnchor.constraint(equalToConstant: 50)
            ])
            
            // Add onClick function to button
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        }
        
    }
    
    
    @objc func buttonTapped() {
        // Retrieve text field values and store in variables
        let selectedCategoryIndex = pickerView?.selectedRow(inComponent: 0)
        let selectedCategory = categories[selectedCategoryIndex ?? 0]
        let selectedSegment = segmentControl?.selectedSegmentIndex
        let selectedDate = datePicker?.date
        textField3Text = textField3?.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        dollarText = dollarTextField!.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        centsText = centsTextField!.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if(dollarText == ""){
            dollarText = "0"
        }
        
        if(centsText == ""){
            centsText = "00"
        }
        var url = ""
        if selectedCategory == "Hogar y utilidades" {
            url = "https://www.instamobile.io/wp-content/uploads/2019/03/Screen-Shot-2019-03-27-at-10.02.12-PM.png"
            
        } else if selectedCategory == "Viajes" {
            url = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4tbiIUHkvzkHaMH4vC2h-ifNgo2IxGxq5pjZ8_kuoXJKqpPbBHA"
            
        } else if selectedCategory == "Transporte" {
            url = "https://mondrian.mashable.com/uploads%252Fcard%252Fimage%252F312644%252FUber_Logobit_Digital_black.png%252F950x534__filters%253Aquality%252890%2529.png?signature=EovGBFsXq2bCP9auiawtB-cJKVY=&source=https%3A%2F%2Fblueprint-api-production.s3.amazonaws.com"
        } else if selectedCategory == "Comida" {
            url = "https://www.instamobile.io/wp-content/uploads/2019/03/Screen-Shot-2019-03-27-at-10.02.54-PM.png"

        } else if selectedCategory == "Bebidas" {
            url = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRFRaXksljpUSIJWBcxVMPnPFY0pqHiNaORIBW_CXghyVIjYvbmvg"

        } else if selectedCategory == "Renta" {
            url = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ49JG1ISq63JuSM_-WKjag4Mb018qXbgAqutn63s7yGjILtk3O"

        }else {
            url = "https://assets.coingecko.com/markets/images/23/large/fe290a14-ac8f-4c90-9aed-5e72abf271f0.jpeg?1527171545"
        }
        
        if(selectedCategory == " " || selectedCategory == nil || textField3Text == nil || textField3Text == ""){
            let alertController = UIAlertController(title: "Favor de llenar todos los campos", message: nil, preferredStyle: .alert)

            // Add an action to the alert controller
            let okAction = UIAlertAction(title: "OK", style: .default) { [self] (_) in
                pickerView?.selectRow(0, inComponent: 0, animated: true)
                datePicker?.date = Date()
                textField3?.text = nil
                dollarTextField?.text = nil
                centsTextField?.text = nil

            }
            alertController.addAction(okAction)
            // Present the alert controller
            if let viewController = UIApplication.shared.keyWindow?.rootViewController {
                viewController.present(alertController, animated: true, completion: nil)
            }
        }else{
            if (selectedSegment == 0){
                let db = Firestore.firestore()
                db.collection("expenses").document().setData([
                    "color": "#342323",
                    "logoURL": url,
                    "spending": "$"+dollarText+"."+centsText,
                    "title":selectedCategory
                ]) { err in
                    if let err = err {
                        // Create an alert controller
                            let alertController = UIAlertController(title: "Ha habido un error, por favor vuelva a intentar más tarde", message: nil, preferredStyle: .alert)

                            // Add an action to the alert controller
                            let okAction = UIAlertAction(title: "OK", style: .default) { [self] (_) in
                                datePicker?.date = Date()
                                textField3?.text = nil
                                dollarTextField?.text = nil
                                centsTextField?.text = nil
                                pickerView?.selectRow(0, inComponent: 0, animated: true)
                            }
                            alertController.addAction(okAction)

                            // Present the alert controller
                            if let viewController = UIApplication.shared.keyWindow?.rootViewController {
                                viewController.present(alertController, animated: true, completion: nil)
                            }
                    } else {
                        // Create an alert controller
                            let alertController = UIAlertController(title: "Registro agregado exitosamente", message: nil, preferredStyle: .alert)

                            // Add an action to the alert controller
                            let okAction = UIAlertAction(title: "OK", style: .default) { [self] (_) in
                                pickerView?.selectRow(0, inComponent: 0, animated: true)
                                datePicker?.date = Date()
                                textField3?.text = nil
                                dollarTextField?.text = nil
                                centsTextField?.text = nil

                            }
                            alertController.addAction(okAction)

                            // Present the alert controller
                            if let viewController = UIApplication.shared.keyWindow?.rootViewController {
                                viewController.present(alertController, animated: true, completion: nil)
                            }
                    }
                }
            }else{

                let db = Firestore.firestore()
                db.collection("incomes").document().setData([
                    "color": "#342323",
                    "logoURL": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4tbiIUHkvzkHaMH4vC2h-ifNgo2IxGxq5pjZ8_kuoXJKqpPbBHA",
                    "spending": "$"+dollarText+"."+centsText,
                    "title":selectedCategory
                ]) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                       
                    }
                }
            }
        }
        
        
    }
    
    
    @objc(numberOfComponentsInPickerView:) public func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
    @objc public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return categories.count
        }
        
    @objc public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return categories[row]
        }
}
