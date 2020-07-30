//
//  ContentView.swift
//  Marvel
//
//  Created by Nazildo Souza on 30/04/20.
//  Copyright © 2020 Nazildo Souza. All rights reserved.
//

import SwiftUI

struct CharactersList: View {
    @ObservedObject var listData = ApiData()
    @State private var value: CGFloat = 0
    
    var body: some View {
        ZStack {
            if self.listData.codeCharacter != 200 {

                Loading(animating: .constant(true))
                
            } else if self.listData.totalCharacter == 0 {
                    Text("nâo há itens atualmente.")
                        .font(.headline)
                
            } else {
            
                NavigationView {
                    List(0..<self.listData.data.count, id: \.self) { i in
                        NavigationLink(destination: HeroView(data: self.listData.data[i], listData: self.listData)) {
                            
                            if i == self.listData.data.count - 20 {
                                HeroRow(data: self.listData.data[i], isLast: true, listData: self.listData)
                                
                            } else {
                                HeroRow(data: self.listData.data[i], isLast: false, listData: self.listData)
                            }
                        }
                    }
                    .navigationBarTitle("Heróis Marvel")
                    .navigationBarItems(trailing: Button(action: {
                        withAnimation(.easeInOut(duration: 0.4)) {
                            
                            self.listData.showingBusca.toggle()
                        }
                    }){
                        Image(systemName: "magnifyingglass")
                            .imageScale(.large)
                    })
                }
                .navigationViewStyle(StackNavigationViewStyle())
                
                if self.listData.showingBusca {
                    Blur(style: .systemMaterial)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            self.hiddenKeyboard()
                            self.listData.showingBusca = false
                    }
                }
                
                BuscaView(listData: self.listData)
                    .offset(y: -self.value / 2).animation(.easeInOut)
                    //    .offset(x: !self.listData.showingBusca ? -UIScreen.main.bounds.width : 0)
                    .opacity(self.listData.showingBusca ? 1 : 0).animation(.default)
                    .onAppear {
                        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (noti) in
                            let value = noti.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                            let height = value.height
                            self.value = height
                        }

                        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (noti) in
                            self.value = 0
                        }
                }
                .frame(maxWidth: 550)
            } 
        }
        
    }
    
    func hiddenKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct CharactersList_Previews: PreviewProvider {
    static var previews: some View {
        CharactersList()
    }
}
