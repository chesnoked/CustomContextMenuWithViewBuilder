//
//  ColorPaletteExtension.swift
//  ForPeople
//
//  Created by Evgeniy Safin on 03.10.2022.
//

import Foundation
import SwiftUI

extension Color {
    static let palette = Palette()
}

struct Palette {
    
    private let myColorTheme: MyColorTheme = MyColorTheme()
    
    func defaultColorTheme() {
        myColorTheme.defaultColorTheme()
    }
    
    var parent: Color {
        return myColorTheme.loadColor(forKey: "parent_color") ?? Color("parent")
    }
    var child: Color {
        return myColorTheme.loadColor(forKey: "child_color") ?? Color("child")
    }
}

struct MyColorTheme {
    
    private let userDefaults = UserDefaults.standard
    
    func defaultColorTheme() {
        saveColor(color: Color("parent"), forKey: "parent_color")
        saveColor(color: Color("child"), forKey: "child_color")
    }
    
    func saveColor(color: Color, forKey: String) {
        if let components = UIColor(color).cgColor.components {
            userDefaults.set(components, forKey: forKey)
        }
    }
    
    func loadColor(forKey: String) -> Color? {
        guard let components = userDefaults.object(forKey: forKey) as? [CGFloat] else { return nil }
        return Color(.sRGB,
                     red: components[0],
                     green: components[1],
                     blue: components[2],
                     opacity: components[3])
    }
    
}
