//
//  EmojiMemoryGameView.swift
//  Shared
//
//  Created by Brando Lugo on 11/29/20.
//

import SwiftUI

//View
struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Grid(viewModel.cards) { card in
                    CardView(card: card).onTapGesture {
                        viewModel.choose(card: card)
                    }
                    .padding(5)
                }
            NewGameButtonView(viewModel: viewModel)
            }
        .padding()
        .foregroundColor(Color.orange)
    }
}

struct NewGameButtonView: View {
    
    var viewModel: EmojiMemoryGame
    //Get the ref to the view model
    
    var body: some View {
        Button(action: {
                viewModel.newGame()
               }, label: {
            Text("New Game")
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .font(.subheadline)
                .padding()
                .background(Color.orange)
                .foregroundColor(Color.white)
                .cornerRadius(25)
        })
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
    
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3.0
    let fontScaleFactor: CGFloat = 0.75
    
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScaleFactor
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
