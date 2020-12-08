//
//  EmojiMemoryGameView.swift
//  Shared
//
//  Created by Brando Lugo on 11/29/20.
//

import SwiftUI

//View
struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame = EmojiMemoryGame()
    
    init() {
        self.viewModel.reset()
    }
    
    var body: some View {
        VStack {
            Grid(viewModel.cards) { card in
                    CardView(card: card).onTapGesture {
                        viewModel.choose(card: card)
                    }
                    .padding(5)
                }
            HStack(spacing: 45) {
                Text("Score: \(viewModel.score)")
                Button(action: {
                        viewModel.reset()
                       })  {
                        Text("New Game")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .font(.subheadline)
                }
                .padding()
                .foregroundColor(.white)
                .background(viewModel.themeColor)
                .cornerRadius(10)
                Text("Time: ")
            }
            
            }
        .padding()
        .foregroundColor(viewModel.themeColor)
        
        
    }
}

struct CardView: View {
    //Get the card from the view model
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            body(for: geometry.size)
        }
    }
    
    func body(for size: CGSize) -> some View {
        //Media Query size?
            ZStack {
                if card.isFaceUp {
                    RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                    RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                    Text(card.content)
                } else {
                    if !card.isMatched {
                        RoundedRectangle(cornerRadius: cornerRadius).fill()
                    }
                }
            }
            .font(Font.system(size: fontSize(for: size)))
    }
    
    // MARK: - Drawing Constants
    
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3.0
    private let fontScaleFactor: CGFloat = 0.75
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScaleFactor
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView()
    }
}
