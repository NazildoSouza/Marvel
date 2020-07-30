//
//  BuscaView.swift
//  Marvel
//
//  Created by Nazildo Souza on 01/05/20.
//  Copyright © 2020 Nazildo Souza. All rights reserved.
//

import SwiftUI

struct BuscaView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var listData: ApiData
    @State private var dragAmount = CGSize.zero
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Text("Busque pelo nome em inglês do personagem.")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .padding()

                TextField("Nome do personagem", text: self.$listData.busca)
                   // .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(10)
                    .background(Color(.secondarySystemBackground))
                    .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous).stroke(Color.gray, lineWidth: 1))
                    .cornerRadius(8)
                
                Button("Buscar") {
                    self.hiddenKeyboard()
                    self.listData.data.removeAll()
                    self.listData.currentPage = 0
                    self.listData.totalCharacter = 0
                    self.listData.codeCharacter = 0
                    self.listData.loadCharacters()
                    self.listData.busca = ""
                    self.listData.showingBusca = false
                    
                }
                .padding()
               // .background(self.colorScheme == .light ? Color.white : Color(#colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.2352941176, alpha: 1)))
                .background(Color(.tertiarySystemBackground))
                .cornerRadius(10)
                .shadow(radius: 4)
                .padding(.top)
                
            }
            .padding(30)
            .frame(width: geo.size.width / 1.2)
            .background(Color(.systemBackground).onTapGesture {
                    self.hiddenKeyboard()
                })
            .cornerRadius(30)
            .shadow(radius: 15)
                
            .offset(x: self.dragAmount.width / 2, y: self.dragAmount.height / 3)
            .gesture(
                DragGesture()
                    .onChanged { self.dragAmount = $0.translation }
                    .onEnded { value in
                        if self.dragAmount.height > 250 || self.dragAmount.width > 250 || self.dragAmount.width < -250 {
                            withAnimation {
                                self.dragAmount = CGSize(width: geo.size.width / 2, height: 0)

                                DispatchQueue.main.async {
                                    self.listData.showingBusca = false
                                    self.dragAmount = .zero
                                    self.hiddenKeyboard()
                                }
                            }
                        } else {
                            self.dragAmount = .zero
                        }
                }
            )
                .animation(.spring())
        }
    }
    
    func hiddenKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}

struct BuscaView_Previews: PreviewProvider {
    static var previews: some View {
        BuscaView(listData: ApiData())
    }
}
