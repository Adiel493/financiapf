//
//  ATCSettingsViewController.swift
//  DatingApp
//
//  Created by Duy Bui on 6/18/20.
//  Copyright © 2020 Instamobile. All rights reserved.
//

import UIKit
import Firebase

protocol ATCSettingsViewControllerDelegate: class {
    func settingsViewControllerDidUpdateSettings()
}

class ATCSettingsViewController: QuickTableViewController {
    
    // MARK: - Properties
    /// UI components
    private var toggles = [SwitchRow<SwitchCell>]()
    private var sections = [ATCSettingsSection]()
    private var items = [ATCSettingsItem]()
    private var saveButton: TapActionRow<TapActionCell>!
    
    /// Properties
    private var user: ATCUser?
    private var profileUpdater: ATCProfileUpdaterProtocol?
    
    /// Delegate
    weak var delegate: ATCSettingsViewControllerDelegate?
    
    init(user: ATCUser?,
         sections: [ATCSettingsSection],
         profileUpdater: ATCProfileUpdaterProtocol?) {
        self.user = user
        self.sections = sections
        self.profileUpdater = profileUpdater
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings".localizedSettings
        
        /// Initialize toggle UIs
        tableContents = sections.compactMap { section in
            Section(title: section.title, rows: section.options.compactMap { settingItem in
                let settingRow = convert(settingItem: settingItem, action: didToggleSelection)
                toggles.append(settingRow)
                return settingRow
            },footer: section.description)
        }
        
        /// Initialize save button
        saveButton = TapActionRow(text: "Save".localizedSettings, action: buttonPressed())
        tableContents.append(Section(title: "", rows: [saveButton]))
        
        /// Flatten items from all sections
        sections.forEach { items.append(contentsOf: $0.options) }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        guard let user = user else { return }
        
        /// Get real value from user which was fetched from the server
        for (key, value) in user.settings {
            if let index = items.firstIndex(where: { $0.key == key }) {
                let value = value as? Bool ?? false
                items[index].value = value
                toggles[index].switchValue = value
            }
        }
    }
    
    private func convert(settingItem: ATCSettingsItem, action: () -> (Row) -> Void) -> SwitchRow<SwitchCell> {
        return SwitchRow(text: settingItem.displayName,
                         switchValue: settingItem.value,
                         action: action())
    }
    
    private func didToggleSelection() -> (Row) -> Void {
        return { [unowned self] in
            switch $0 {
            case let row as SwitchRow<SwitchCell>:
                if let index = self.toggles.firstIndex(where: { $0 == row }) {
                    self.toggles[index].switchValue = row.switchValue
                    self.items[index].value = row.switchValue
                }
            default:
                break
            }
        }
    }
    
    // MARK: - Actions
    private func buttonPressed() -> (Row) -> Void {
        return { [unowned self] in
            switch $0 {
            case let row as TapActionRow<TapActionCell> where row == self.saveButton:
                self.handleSaveButton()
            default:
                break
            }
        }
    }
    
    //MARK: - Saving settings to Firebase
    func handleSaveButton() {
        guard let user = user else { return }
        var userSettingsJSON = [String: Bool]()
        items.forEach { userSettingsJSON[$0.key] = $0.value }
        profileUpdater?.updateSettings(user: user,
                                      settings: userSettingsJSON,
                                      completion: { [weak self] isSuccess in
                                        if isSuccess {
                                            self?.delegate?.settingsViewControllerDidUpdateSettings()
                                        }
        })
    }
}
