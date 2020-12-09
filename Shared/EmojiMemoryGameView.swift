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
                        withAnimation(.linear(duration: 0.75)){
                            viewModel.choose(card: card)
                        }
                        
                    }
                    .padding(5)
                }
            HStack(spacing: 30) {
                Text("Score: \(viewModel.score)")
                Button(action: {
                    withAnimation(.easeInOut) {
                        viewModel.reset()
                    }
                       
                       })  {
                        Text("New Game")
                            .fontWeight(.bold)
                            .font(.subheadline)
                }
                .padding()
                .foregroundColor(.white)
                .background(viewModel.themeColor)
                .cornerRadius(10)
                Text("Time: 10")
            }
            .padding(5)
            
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
    
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    @ViewBuilder
    func body(for size: CGSize) -> some View {
        //Media Query size?
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBonusRemaining*360-90), clockWise: true)
                            .onAppear {
                                self.startBonusTimeAnimation()
                            }
                    } else {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBonusRemaining*360-90), clockWise: true)
                    }
                }
                .padding(5)
                .opacity(0.4)
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false): .default)
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.scale)
            
        }
    }
    
    // MARK: - Drawing Constants
    private let fontScaleFactor: CGFloat = 0.65
  
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScaleFactor
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView()
    }
}
