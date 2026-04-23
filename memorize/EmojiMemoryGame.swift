//
//  EmojiMemoryGame.swift
//  memorize
//
//  Created by wjn on 2026/4/13.
//

import Foundation

@Observable
class EmojiMemoryGame {
    //private static var emojis =
   //["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    
    //private static func createMemoryGame() -> MemoryGame<String> {
        //MemoryGame<String>(numberOfPairsOfCards: 4,createCardContent:{index in emojis[index]} )}
    //private var model: MemoryGame<String> = createMemoryGame()
    
    //新增 - 替換原本的 static var emojis
    private var themePool: ThemePool<String>
    private(set) var currentTheme: ThemePool<String>.Theme
    private var model: MemoryGame<String>
    init() {
        let pool = EmojiMemoryGame.createThemePool()
        self.themePool = pool
        
        let selectedTheme = pool.themes.randomElement()!
        self.currentTheme = selectedTheme
        
        self.model = EmojiMemoryGame.createMemoryGame(with: selectedTheme)
        }
    private static func createThemePool() -> ThemePool<String> {
        var pool = ThemePool<String>()
        pool.addTheme(name: "字母", color: "blue", pairs: 8, items: ["A","B","C","D","E","F","G","H"])
        pool.addTheme(name: "表情", color: "orange", pairs: 8, items: ["A","B","C","D","E","F","G","H"])
            //["😀","😂","😍","😎","🥳","😱","👻","🤖"])
        pool.addTheme(name: "植物", color: "green", pairs: 8, items: ["A","B","C","D","E","F","G","H"])
            //["🌵","🌲","🌳","🌴","🌱","🌿"])
        return pool
    }
    private static func createMemoryGame(with theme: ThemePool<String>.Theme) -> MemoryGame<String> {
            let shuffledItems = theme.items.shuffled()
            return MemoryGame<String>(numberOfPairsOfCards: theme.actualPairs) { index in
                shuffledItems[index]
            }
        }
    
//新增
    func newGame() {
        //隨機主題
        if let nextTheme = themePool.themes.randomElement() {
                    currentTheme = nextTheme
                    model = EmojiMemoryGame.createMemoryGame(with: nextTheme)
        }
    }
    
    var cards: [MemoryGame<String>.Card] {
        model.cards
    }
    
    //MARK: - intent
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    //新增
    var score: Int {
        model.score
    }
}
