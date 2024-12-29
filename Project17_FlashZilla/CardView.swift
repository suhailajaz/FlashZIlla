//
//  CardView.swift
//  Project17_FlashZilla
//
//  Created by suhail on 29/12/24.
//

import SwiftUI

struct CardView: View {
    let card: Card
    @State private var isSHowingAnswer = false
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 12)
                .fill(.white)
                .shadow(radius: 10)
            
            VStack{
                Text(card.prompt)
                    .font(.largeTitle)
                    .foregroundStyle(.black)
                
                if isSHowingAnswer{
                    Text(card.answer)
                        .font(.title)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .onTapGesture {
            isSHowingAnswer.toggle()
        }
    }
}

#Preview {
    CardView(card: .example)
}
