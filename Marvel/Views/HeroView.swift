//
//  ComicView.swift
//  Marvel
//
//  Created by Nazildo Souza on 02/05/20.
//  Copyright © 2020 Nazildo Souza. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct HeroView: View {
    var data: Character.Results
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var dismiss
    @ObservedObject var listData: ApiData
    @State private var showingComicsView = false
    @State private var showingEventsView = false
    @State private var showingSeriesView = false
    @State private var showSheet = false
    @State private var indexSheet = 0
    @State private var backPage = true
    @State private var dragAmount = CGSize.zero
    
    var body: some View {
        Group {
            ScrollView(.vertical, showsIndicators: false) {
                GeometryReader { geometry in
                    Image("marvel1")
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width, height:  geometry.frame(in: .global).minY + 300)
                        .offset(y: -geometry.frame(in: .global).minY)
                        //  .frame(width: geometry.size.width, height: geometry.size.height / 2)
                        //   .offset(y: geometry.frame(in: .global).minY - 60 /*< 0 ? -geometry.frame(in: .global).minY : 0*/)
                        .shadow(color: Color.primary.opacity(0.3), radius: 10, x: 0, y: 0)
                    
                }
                .frame(height: 300)
                
                VStack {
                    WebImage(url: URL(string: self.data.thumbnail.image), options: .highPriority, context: nil)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 250, height: 250)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(self.colorScheme == .light ? Color.red : Color(#colorLiteral(red: 0.541807109, green: 0.1609815513, blue: 0.3068930662, alpha: 1)), lineWidth: 3))
                        .shadow(color: Color.primary.opacity(0.4), radius: 10, x: 0, y: 0)
                        .zIndex(1)
                    
                    VStack {
                        Text(self.data.name)
                            .font(.title)
                            .padding([.bottom, .horizontal])
                            .multilineTextAlignment(.center)
                        
                        Text(self.data.description ?? "")
                            .font(.caption)
                            .padding(.horizontal)
                            .padding(.bottom, 15)
                            .layoutPriority(1)
                        
                        
                        VStack {
                            Text("Detalhes do Personagem")
                                .font(.subheadline)
                                .padding()
                            HStack(spacing: 50) {
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
                            }
                                
                            .padding(.top)
                            Spacer(minLength: 30)
                            
                            Text("Relacionados ao Pesonagem")
                                .font(.subheadline)
                                .padding()
                            HStack(spacing: 50) {
                                
                                Button(action: {
                                    self.listData.idCharacter = self.data.id
                                    self.listData.endPoint = "Comics"
                                    if !self.listData.dataEndPoint.isEmpty {
                                        self.listData.dataEndPoint.removeAll()
                                    }
                                    self.listData.currentPage = 0
                                    self.listData.totalEndPoint = 0
                                    self.listData.codeEndPoint = 0
                                    print(self.data.id)
                                    
                                    self.listData.loadEndPoint()
                                    
                                    self.showingComicsView.toggle()
                                }) {
                                    Text("Comics")
                                        .padding()
                                        .foregroundColor(.primary)
                                        .background(self.colorScheme == .light ? Color.white : Color(#colorLiteral(red: 0.1169430092, green: 0.1222703382, blue: 0.1330153644, alpha: 1)))
                                        .cornerRadius(10)
                                        .shadow(color: Color.primary.opacity(0.4), radius: 4, x: 0, y: 0)
                                }
                                
                                Button(action: {
                                    self.listData.idCharacter = self.data.id
                                    self.listData.endPoint = "Events"
                                    if !self.listData.dataEndPoint.isEmpty {
                                        self.listData.dataEndPoint.removeAll()
                                    }
                                    self.listData.currentPage = 0
                                    self.listData.totalEndPoint = 0
                                    self.listData.codeEndPoint = 0
                                    print(self.data.id)
                                    
                                    self.listData.loadEndPoint()
                                    
                                    self.showingEventsView.toggle()
                                }) {
                                    Text("Events")
                                        .padding()
                                        .foregroundColor(.primary)
                                        .background(self.colorScheme == .light ? Color.white : Color(#colorLiteral(red: 0.1169430092, green: 0.1222703382, blue: 0.1330153644, alpha: 1)))
                                        .cornerRadius(10)
                                        .shadow(color: Color.primary.opacity(0.4), radius: 4, x: 0, y: 0)
                                }
                                
                                Button(action: {
                                    self.listData.idCharacter = self.data.id
                                    self.listData.endPoint = "Series"
                                    if !self.listData.dataEndPoint.isEmpty {
                                        self.listData.dataEndPoint.removeAll()
                                    }
                                    self.listData.currentPage = 0
                                    self.listData.totalEndPoint = 0
                                    self.listData.codeEndPoint = 0
                                    print(self.data.id)
                                    
                                    self.listData.loadEndPoint()
                                    
                                    self.showingSeriesView.toggle()
                                }) {
                                    Text("Series")
                                        .padding()
                                        .foregroundColor(.primary)
                                        .background(self.colorScheme == .light ? Color.white : Color(#colorLiteral(red: 0.1169430092, green: 0.1222703382, blue: 0.1330153644, alpha: 1)))
                                        .cornerRadius(10)
                                        .shadow(color: Color.primary.opacity(0.4), radius: 4, x: 0, y: 0)
                                    
                                }
                                
                            }
                            .padding(.top)
                            Spacer()
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Spacer(minLength: 100)
                        
                        NavigationLink(destination: EndPointList(listData: self.listData), isActive: self.$showingComicsView) { EmptyView() }
                        NavigationLink(destination: EndPointList(listData: self.listData), isActive: self.$showingEventsView) { EmptyView() }
                        NavigationLink(destination: EndPointList(listData: self.listData), isActive: self.$showingSeriesView) { EmptyView() }
                    }
                    .padding(.top)
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemBackground))
                    .cornerRadius(20)
                    
                }
                .offset(y: -100)
                .padding(.bottom, -100)
                
            }
        }
        .sheet(isPresented: self.$showSheet) {
            WebView(url: self.data.urls[self.indexSheet].url).edgesIgnoringSafeArea(.all)
        }
        .navigationBarTitle(Text(self.data.name), displayMode: .inline)
        
    }
    
}
