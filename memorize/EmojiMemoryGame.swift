//
//  EmojiMemoryGame.swift
//  memorize
//
//  Created by wjn on 2026/4/13.
//

import Foundation

@Observable
class EmojiMemoryGame {
    private static var emojis =
    //["✈️","😍","😂","❤️","😘","😳","👀","😌","😄","🙈","😴","🎶","😎","💕","😜","😄","✌🏻","🥳","🐶","🐷","🐱","🐰","🦊","🐻‍❄️","🦁","🐨","🐯","🐮","🐻","🐭","🐹","🐼","🐸","🐈","🐈‍⬛"]
    ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 4,createCardContent:{index in emojis[index]} )
        
    }
    private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: [MemoryGame<String>.Card] {
        model.cards
    }
    
    //MARK: - intent
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    func shuffle() {
        model.shuffle()
    }
}
