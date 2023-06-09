//
//  ATCCircledIconMenuCollectionViewCell.swift
//  DashboardApp
//
//  Creado por Adiel Luna on 8/4/18.
//  Copyright © 2018 Instamobile. All rights reserved.
//

import UIKit

class ATCCircledIconMenuCollectionViewCell: UICollectionViewCell, ATCMenuItemCollectionViewCellProtocol {
    @IBOutlet var menuImageView: UIImageView!
    @IBOutlet var menuLabel: UILabel!
    @IBOutlet var imageContainerView: UIView!
    
    func configure(item: ATCNavigationItem) {
        menuImageView.image = item.image
        menuLabel.text = item.title

        imageContainerView.layer.cornerRadius = 30 / 2
        imageContainerView.layer.borderColor = UIColor.gray.darkModed.cgColor
        imageContainerView.layer.borderWidth = 1.0
        imageContainerView.backgroundColor = UIColor.white.darkModed
    }
}
