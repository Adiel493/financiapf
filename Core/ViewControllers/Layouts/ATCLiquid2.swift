//
//  ATCLiquid2.swift
//  FinanceApp
//
//  Created by Alumnos on 06/05/23.
//  Copyright © 2023 Instamobile. All rights reserved.
//

import UIKit

public class ATCLiquid2: ATCCollectionViewFlowLayout {

    var textField1: UITextField?
    var textField2: UITextField?
    var textField3: UITextField?
    var textField4: UITextField?
    
    var textField1Text: String?
    var textField2Text: String?
    var textField3Text: String?
    var textField4Text: String?
    
    var segmentControl: UISegmentedControl?

    public override func prepare() {
        super.prepare()

        // Create text fields with desired properties
            textField1 = UITextField()
               textField2 = UITextField()
               textField3 = UITextField()
        textField4 = UITextField()
               
               textField1?.placeholder = "Categoría"
               textField2?.placeholder = "Meses por pagar"
               textField3?.placeholder = "Fecha"
        textField4?.placeholder = "Cantidad"
               
               textField1?.borderStyle = .roundedRect
               textField2?.borderStyle = .roundedRect
               textField3?.borderStyle = .roundedRect
        textField4?.borderStyle = .roundedRect
               
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
                   
                   collectionView.addSubview(textField1!)
                   collectionView.addSubview(textField2!)
                   collectionView.addSubview(textField3!)
                   collectionView.addSubview(textField4!)
                   collectionView.addSubview(segmentControl!)
                   collectionView.addSubview(button)
                   
                   // Position text fields, segmented control, and button in the center of the collection view
                   textField1?.translatesAutoresizingMaskIntoConstraints = false
                   textField2?.translatesAutoresizingMaskIntoConstraints = false
                   textField3?.translatesAutoresizingMaskIntoConstraints = false
                   textField4?.translatesAutoresizingMaskIntoConstraints = false
                   segmentControl?.translatesAutoresizingMaskIntoConstraints = false
                   button.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                textField1!.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
                textField1!.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor, constant: -220),
                textField1!.widthAnchor.constraint(equalToConstant: 250),
                textField1!.heightAnchor.constraint(equalToConstant: 40),
                
                textField2!.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
                textField2!.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor, constant: -80),
                textField2!.widthAnchor.constraint(equalToConstant: 250),
                textField2!.heightAnchor.constraint(equalToConstant: 40),
                
                textField3!.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
                textField3!.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor, constant: -10),
                textField3!.widthAnchor.constraint(equalToConstant: 250),
                textField3!.heightAnchor.constraint(equalToConstant: 40),
                
                textField4!.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
                textField4!.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor, constant: -150),
                textField4!.widthAnchor.constraint(equalToConstant: 250),
                textField4!.heightAnchor.constraint(equalToConstant: 40),
                
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
        
        // Assign text field values to variables
        textField1Text = textField1?.text
        textField2Text = textField2?.text
        textField3Text = textField3?.text
        textField4Text = textField3?.text
    }
    
    
    @objc func buttonTapped() {
        // Retrieve text field values and store in variables
        textField1Text = textField1?.text
        let selectedSegment = segmentControl?.selectedSegmentIndex
        textField2Text = textField2?.text
        textField3Text = textField3?.text
        textField4Text = textField3?.text
        
        // Print values to console
        print("Text Field 1: \(textField1Text ?? "")")
        print("Text Field 2: \(textField2Text ?? "")")
        print("Text Field 3: \(textField3Text ?? "")")
        print("Text Field 4: \(textField4Text ?? "")")
        print("Selected segment: \(selectedSegment ?? 0)")
    }
}
