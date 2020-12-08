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
    var themeColor: Color
    
    
    init() {
        self.theme = Theme()
        self.themeColor = theme.themeColor
    }
    
    //Published calls objectWillChange.send() kind of like provider redraw subscribers
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame(emojis: ["🥲","🥲","🥲","🥲","🥲","🥲"])
  
    static func createMemoryGame(emojis: Array<String>) -> MemoryGame<String> {
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count) {
            pairIndex in
            return emojis[pairIndex]
        }
    }
    
    //MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    
    //MARK: - Intent(s)
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
     
    func newGame() {
        self.theme = Theme()
        self.themeColor = theme.themeColor
        model = EmojiMemoryGame.createMemoryGame(emojis: theme.themeEmojis)
    }
}

