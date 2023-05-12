//
//  ATCSettingsItem.swift
//  DatingApp
//
//  Copyright © 2020 Instamobile. All rights reserved.
//

import Foundation

enum SettingType {
    case toggle
    case button
}

struct ATCSettingsItem {
    var displayName: String
    var settingType: SettingType
    var editable: Bool
    var key: String
    var value: Bool
    
    init(displayName: String,
         settingType: SettingType,
         editable: Bool,
         key: String,
         defaultValue: Bool) {
        self.displayName = displayName
        self.settingType = settingType
        self.editable = editable
        self.key = key
        self.value = defaultValue
    }
}

struct ATCSettingsSection {
    var title: String
    var description: String?
    var options: [ATCSettingsItem]
    
    init(title: String, description: String? = nil, options: [ATCSettingsItem]) {
        self.title = title
        self.description = description
        self.options = options
    }
}
