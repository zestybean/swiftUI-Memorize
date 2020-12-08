//
//  Theme.swift
//  Memorize
//
//  Created by Brando Lugo on 12/7/20.
//

import SwiftUI

struct Theme {
    var themeDictionary: [String: [String]] = ["Spooky": ["👻", "🤡", "💀", "😈", "🧟‍♂️", "🎃"], "Holiday": ["🎄", "🎁", "🎅", "☃️", "❄️", "🌟"],
                                               "Sports": ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐"], "Faces": ["😞", "😏", "😘", "😍", "😤", "😅"],
                                               "Hands": ["👋", "✋", "🤘", "👇", "☝️", "🤙"], "Food" : ["🍜", "🍔", "🌮", "🍕", "🍗", "🥪"]]
    
    var themeName: String
    var themeEmojis: Array<String>
    var themeColor: Color
    
    init() {
        let randomTheme = themeDictionary.randomElement()
        themeName = randomTheme?.key ?? "BadKey"
        themeEmojis = randomTheme?.value ?? ["🥲","🥲","🥲","🥲","🥲","🥲"]
        switch themeName {
            case "Spooky":
                themeColor = .orange
            case "Holiday":
                themeColor = .red
            case "Sports":
                themeColor = .blue
            case "Faces":
                themeColor = .yellow
            case "Hands":
                themeColor = .purple
            case "Food":
                themeColor = .green
            default:
                themeColor = .pink
        }
    }
    
   
}
