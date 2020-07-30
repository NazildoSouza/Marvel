//
//  URLView.swift
//  Marvel
//
//  Created by Nazildo Souza on 02/05/20.
//  Copyright © 2020 Nazildo Souza. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct URLView: View {
    var data: EndPoint.Results
   
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var dismiss
    @State private var indexSheet = 0
    @State private var showSheet = false
    @State private var backPage = true
    @State private var dragAmount = CGSize.zero
    
    var body: some View {
        Group {
        ScrollView(.vertical, showsIndicators: false) {

                GeometryReader { geometry in
                    Image("marvel3")
                        .resizable()
                        .scaledToFill()
                        .offset(y: -geometry.frame(in: .global).minY)
                        .frame(width: UIScreen.main.bounds.width, height:  geometry.frame(in: .global).minY + 300)
                      //  .frame(width: geometry.size.width, height: geometry.size.height / 2)
                    //   .offset(y: geometry.frame(in: .global).minY - 60 /*< 5 ? -geometry.frame(in: .global).minY : 0*/)
                        .shadow(color: Color.primary.opacity(0.3), radius: 10, x: 0, y: 0)
                    
                }
                .frame(height: 300)
                
                VStack {
                    
                    WebImage(url: URL(string: self.data.thumbnail.image), options: .highPriority, context: nil)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 216, height: 324)
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                        .shadow(color: Color.primary.opacity(0.4), radius: 10, x: 0, y: 0)
                        .zIndex(1)
                    
                    VStack {
                    Text(self.data.title)
                        .font(.title)
                        .padding()
                        .layoutPriority(1)
                        .multilineTextAlignment(.center)
                    
                    Text(self.data.description ?? "")
                        .font(.caption)
                        .padding(.horizontal)
                        .padding(.bottom, 15)
                        .layoutPriority(1)
                    
                    Spacer(minLength: 50)
                    
                    Text("Paginas Relacionadas")
                        .font(.subheadline)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .center, spacing: 40) {
                            ForEach(0..<self.data.urls.count, id: \.self) { i in
                                Button(action: {
                                    self.showSheet.toggle()
                                }) {
                                    Text(self.data.urls[i].type)
                                    .padding()
                                    .foregroundColor(.primary)
                                    .background(self.colorScheme == .light ? Color.white : Color(#colorLiteral(red: 0.1169430092, green: 0.1222703382, blue: 0.1330153644, alpha: 1)))
                                    .cornerRadius(10)
                                    .shadow(color: Color.primary.opacity(0.4), radius: 4, x: 0, y: 0)
                                }                          
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        .padding(.vertical)
                        .padding(.horizontal, UIScreen.main.bounds.width / 5)
                    }
                    }
                    .padding(.top)
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemBackground))
                    .cornerRadius(20)
            
                }
                .offset(y: -100)
                .padding(.bottom, -100)
                
                Spacer(minLength: 100)

        }
    }
        .sheet(isPresented: self.$showSheet) {
            WebView(url: self.data.urls[self.indexSheet].url).edgesIgnoringSafeArea(.all)
        }
        .navigationBarTitle(Text(self.data.title), displayMode: .inline)
    }
}
