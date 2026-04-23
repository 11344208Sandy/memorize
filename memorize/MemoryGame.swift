//
//  MemoryGame.swift
//  memorize
//
//  Created by meishuo on 2026/3/30.
//

import Foundation
//新增
// MARK: - ThemePool Model
struct ThemePool<ItemType> where ItemType: Equatable {
    //讓外部可讀取但不可從外部修改主題陣列
    private(set) var themes: [Theme] = []

    struct Theme: Identifiable {
        var id = UUID()
        var name: String
        var color: String
        var numberOfPairs: Int
        var items: [ItemType]
        // 計算 - 確保成對數不會超過現有元素數量
        var actualPairs: Int {
            min(numberOfPairs, items.count)
        }
    }

    mutating func addTheme(name: String, color: String, pairs: Int, items: [ItemType]) {
        let newTheme = Theme(name: name, color: color, numberOfPairs: pairs, items: items)
        themes.append(newTheme)
    }
}

//原有的程式碼
struct MemoryGame<CardContent> where CardContent: Equatable{
    var cards: [Card]
    var score = 0 //新增 - 分數
    
    init(numberOfPairsOfCards: Int,
         createCardContent: (Int) -> CardContent) {
        cards = []
        for index in 0..<numberOfPairsOfCards {
            let cardContent: CardContent = createCardContent(index)
            cards.append(Card(content: cardContent, id: "\(index)a"))
            cards.append(Card(content: cardContent, id: "\(index)b"))
        }
        shuffle()
    }
    
    var lastFaceUpIndex: Int?
    mutating func choose(_ card: Card) {
        if let chosenIndex = index(of: card),
           //新增
            !cards[chosenIndex].isFaceUp,
            !cards[chosenIndex].isMatched
        {
            if let lastIndex = lastFaceUpIndex{
                if cards[lastIndex].content == cards[chosenIndex].content {
                    cards[lastIndex].isMatched = true
                    cards[chosenIndex].isMatched = true
                    //新增 - 對比兩張牌，對的會加2分
                    score += 2
                }else {
                    // 新增 - 沒對中、檢查是否先前翻開過
                    if cards[chosenIndex].hasBeenSeen {
                        score -= 1 //任一張牌被重複翻過第二次以上且沒match時-1
                    }
                    if cards[lastIndex].hasBeenSeen {
                        score -= 1 //若兩張都是先前翻開過則共-2
                    }
                }
            lastFaceUpIndex = nil
        }else{
            //原本 - for i in 0..<cards.count {
            //更改 - 翻第一張牌
            for i in cards.indices {
                //新增
                if cards[i].isFaceUp {
                    cards[i].hasBeenSeen = true
                }
                cards[i].isFaceUp = false
            }
            lastFaceUpIndex = chosenIndex
        }
        //原本 - cards[chosenIndex].isFaceUp.toggle()
        // 新增 - 在卡片翻回背面後，標記它已經被看過，通常在下一次點擊或翻開時記錄
        cards[chosenIndex].isFaceUp = true
}
        print("cards: \(cards)")
    }
    
    func index(of card: Card) -> Int? {
        for i in 0..<cards.count {
            if cards[i].id == card.id {
                return i
            }
        }
        return nil
    }
    
    mutating func shuffle() {
        cards.shuffle()
        print("shuffle cards: \(cards)")
    }
    
    struct Card: Equatable,Identifiable {

        static func == (lhs: MemoryGame<CardContent>.Card, rhs: MemoryGame<CardContent>.Card) -> Bool {
            lhs.content == rhs.content && lhs.isFaceUp == rhs.isFaceUp && lhs.isMatched == rhs.isMatched && lhs.id == rhs.id
        }
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: String
        //新增
        var hasBeenSeen: Bool = false
    }
}
