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
    @State private var offset = CGSize.zero
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var accessibilityVoiceOverEnabled
    var removal : (() -> Void)? = nil
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 22)
                .fill(.white.opacity( 1 - Double(abs(offset.width / 50 ))))
                .shadow(radius: 10)
                .background(
                    accessibilityDifferentiateWithoutColor ?
                    nil
                    : RoundedRectangle(cornerRadius: 25)
                    .fill(offset.width > 0 ? .green : .red)
            )
            
            VStack{
                if accessibilityVoiceOverEnabled{
                    Text(isSHowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundStyle(.black)
                }else{
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundStyle(.black)
                    
                    if isSHowingAnswer{
                        Text(card.answer)
                            .font(.title)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
            
      
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(offset.width / 5.0))
        .offset(x: offset.width * 5)
        .opacity(2 - Double(abs(offset.width / 50 )))
        .accessibilityAddTraits(.isButton)
        .gesture(
            DragGesture()
                .onChanged{ gesture in
                    offset = gesture.translation
                    
                }
                .onEnded{ _ in
                    if abs(offset.width) > 100{
                        //remove the card
                        removal?()
                    }else{
                        offset = .zero
                    }
                }
        
        )
        .onTapGesture {
            isSHowingAnswer.toggle()
        }
        .animation(.bouncy, value: offset)
    }
}

#Preview {
    CardView(card: .example)
}
