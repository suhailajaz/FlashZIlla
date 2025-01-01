//
//  EditCard.swift
//  Project17_FlashZilla
//
//  Created by suhail on 31/12/24.
//

import SwiftUI

struct EditCard: View {
    @Environment(\.dismiss) var dismiss
    @State private var cards = [Card]()
    @State private var newPrompt = ""
    @State private var newAnswer = ""
    
    var body: some View {
        NavigationStack{
            List{
                Section("Add new card"){
                    TextField("Prompt", text: $newPrompt)
                    TextField("Answer", text: $newAnswer)
                    Button("Add Card", action: addCard)
                }
                
                Section("My Cards"){
                    ForEach(0..<cards.count, id: \.self){ index in
                        VStack(alignment: .leading){
                            Text(cards[index].prompt)
                                .font(.headline)
                            Text(cards[index].answer)
                                .foregroundStyle(.secondary)
                        }
                        
                    }
                    .onDelete(perform: removeCards)
                }
            }
            .navigationTitle("Edit Cards")
            .toolbar{
                Button("Done", action: done)
            }
            .onAppear(perform: loadData)
        }
    }
    func done(){
        dismiss()
    }
    func loadData(){
        if let data = UserDefaults.standard.data(forKey: "Cards"){
            if let decoded = try? JSONDecoder().decode([Card].self, from: data){
                cards = decoded
            }
        }
        
    }
    func addCard(){
        let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
        guard !trimmedAnswer.isEmpty && !trimmedAnswer.isEmpty else { return }
        let card = Card(prompt: trimmedPrompt, answer: trimmedAnswer)
        cards.insert(card, at: 0)
        saveData()
        
        newPrompt = ""
        newAnswer = ""
    }
    func saveData(){
        if let data = try? JSONEncoder().encode(cards){
            UserDefaults.standard.setValue(data, forKey: "Cards")
        }
    }
    func removeCards(at offsets: IndexSet){
        cards.remove(atOffsets: offsets)
        saveData()
    }
}

#Preview {
    EditCard()
}
