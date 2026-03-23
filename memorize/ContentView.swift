//
//  ContentView.swift
//  memorize
//
//  Created by wjn on 2026/3/16.
//

import SwiftUI

struct ContentView: View {
    var emojis = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q"]
    @State var emojiCount = 6
    
    var body: some View {
        VStack{
            HStack{
                ForEach(emojis[0..<emojiCount], id: \.self){ emoji in
                    CardView(contant: emoji)
                }
            }
            
            HStack{
                remove
                Spacer()
                add
            }
            .font(.largeTitle)
        }
        .padding()
        .foregroundStyle(.orange)
    }
    var remove: some View{
        Button{
            if emojiCount > 1{
                emojiCount -= 1
            }
        }label: {
            Image(systemName: "minus.circle")
        }
        //Button(action: {
        //  if emojiCount > 1{
        //      emojiCount -= 1
        //  }
        //}, label: {
        //     Text("Remove Card")
        //})
    }
    
    var add: some View{
        Button{
            if emojiCount < emojis.count {
                emojiCount += 1
            }
        }label: {
            Image(systemName: "plus.circle")
        }
        //Button(action: {
        //  if emojiCount < emojis.count {
        //      emojiCount += 1
        //  }
        //}, label: {
        //     Text("Add Game")
        //})
    }
}

struct CardView: View {
    @State var isFaceUp: Bool = true
    var contant: String
    var body: some View {
        ZStack {
            var shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.fill(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(contant).font(.largeTitle)
            }
            else{
                shape
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
        //.onTapGesture (perform: {
        //    isFaceUp = !isFaceUp
        //})
    }
}

#Preview {
    ContentView()
    
}
