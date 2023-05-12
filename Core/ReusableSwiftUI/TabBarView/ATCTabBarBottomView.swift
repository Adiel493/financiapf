//
//  ATCTabBarBottomView.swift
//  FitnessApp
//
//  Copyright © 2020 iOSAppTemplates. All rights reserved.
//

import SwiftUI

struct ATCTabBarBottomView : View {
    @Binding var selected : Int
    var body : some View {
        HStack{
            Button(action: {
                self.selected = 0
            }) {
                Image("fitness-home-tabBar-icon")
                    .renderingMode(self.selected == 0 ? .template : .original)
            }.foregroundColor(self.selected == 0 ? .black : .gray)
            Spacer(minLength: 12)
            Button(action: {
                self.selected = 1
            }) {
                Image("fitness-podcast-tabBar-icon")
                    .renderingMode(self.selected == 1 ? .template : .original)
            }.foregroundColor(self.selected == 1 ? .black : .gray)
            Spacer().frame(width: 120)
            Button(action: {
                self.selected = 2
            }) {
                Image("fitness-feed-tabBar-icon")
                    .renderingMode(self.selected == 2 ? .template : .original)
            }.foregroundColor(self.selected == 2 ? .black : .gray)
                .offset(x: -10)
            Spacer(minLength: 12)
            Button(action: {
                self.selected = 3
            }) {
                Image("fitness-profile-tabBar-icon")
                    .renderingMode(self.selected == 3 ? .template : .original)
            }.foregroundColor(self.selected == 3 ? .black : .gray)
        }
    }
}
