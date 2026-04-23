//
//  ContentView.swift
//  memorize
//
//  Created by wjn on 2026/3/16.
//

import SwiftUI

struct ContentView: View {
    var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack{
            //新增 - 顯示目前分數
            HStack {
                Text("主題: \(viewModel.currentTheme.name)")
                Spacer()
                Text("Score: \(viewModel.score)")
            }
            .font(.headline)
            .padding(.horizontal)
            
            cardList.animation(.default, value: viewModel.cards)
            Spacer()
            //Button("Shuffle"){ viewModel.shuffle()} .font(.largeTitle)
            //新增
            Button {
                viewModel.newGame()
            } label: {
                VStack(spacing: 5) {
                    Image(systemName: "arrow.clockwise.circle.fill")
                        .font(.system(size: 40)) // 較大的圖示
                    Text("New Game")
                        .font(.caption) // 較小的文字
                }
            }
        }
        .padding()
        //更改
        .foregroundStyle(themeColor)
    }
    var cardList: some View {
        ScrollView{
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
                ForEach(viewModel.cards){ card in
                    CardView(card: card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .padding(4)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
        }
    }
    var themeColor: Color {
        switch viewModel.currentTheme.color {
        case "blue": return .blue
        case "orange": return .orange
        case "green": return .green // 新增支援綠色
        default: return .gray
        }
    }
    
    struct CardView: View {
        var card: MemoryGame<String>.Card
        
        var body: some View {
            ZStack {
                let shape = RoundedRectangle(cornerRadius: 20)
                Group{
                    shape.fill(.white)
                    shape.strokeBorder(lineWidth: 3)
                    Text(card.content)
                        .font(Font.system(size:300))
                        .minimumScaleFactor(0.01)
                        .aspectRatio(1, contentMode: .fit)
                }
                .opacity(card.isFaceUp ? 1 : 0)
                
                shape.opacity(card.isFaceUp ? 0 : 1)
            }
            .opacity(card.isMatched && !card.isFaceUp ? 0 : 1)
        }
    }
}



#Preview {
ContentView(viewModel: EmojiMemoryGame())
}

