//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Brando Lugo on 11/29/20.
//

import SwiftUI

//View Model

class EmojiMemoryGame: ObservableObject {
    var theme: Theme
    var themeColor: Color = .orange
    
    
    init() {
        self.theme = Theme()
        self.themeColor = theme.themeColor
    }
    
    //Published calls objectWillChange.send() kind of like provider redraw subscribers
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame(emojis: ["🥲","🥲","🥲","🥲","🥲","🥲"])
  
    private static func createMemoryGame(emojis: Array<String>) -> MemoryGame<String> {
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count) {
            pairIndex in
            return emojis[pairIndex]
        }
    }
    
    //MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    var score: Int {
        return model.score
    }
    
    
    //MARK: - Intent(s)
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
     
    func reset() {
        self.theme = Theme()
        self.themeColor = theme.themeColor
        model = EmojiMemoryGame.createMemoryGame(emojis: theme.themeEmojis)
    }
}

