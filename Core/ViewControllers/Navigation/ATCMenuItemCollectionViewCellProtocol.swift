//
//  ATCMenuItemCellProtocol.swift
//  MagicShop
//
//  Creado por Adiel Luna on 3/21/18.
//  Copyright © 2018 Magic Shop. All rights reserved.
//
import UIKit

protocol ATCMenuItemCollectionViewCellProtocol: ATCMenuCollectionViewCellConfigurable {
    var menuImageView: UIImageView! {get set}
    var menuLabel: UILabel! {get set}
}
