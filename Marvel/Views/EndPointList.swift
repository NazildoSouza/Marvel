//
//  ComicTeste.swift
//  Marvel
//
//  Created by Nazildo Souza on 02/05/20.
//  Copyright © 2020 Nazildo Souza. All rights reserved.
//

import SwiftUI

struct EndPointList: View {
    @ObservedObject var listData = ApiData()
    
    var body: some View {
        ZStack {
            if self.listData.codeEndPoint != 200 {
                
                Loading(animating: .constant(true))
                
            } else if self.listData.totalEndPoint == 0 {
                Text("Não há itens atualmente.")
                    .font(.headline)
                    .navigationBarTitle(Text("\(self.listData.endPoint)"), displayMode: .large)
                    .navigationViewStyle(StackNavigationViewStyle())
                
            } else {
                
                List(0..<self.listData.dataEndPoint.count, id: \.self) { i in
                    NavigationLink(destination: URLView(data: self.listData.dataEndPoint[i])) {
                        
                        if i == self.listData.dataEndPoint.count - 20 {
                            EndPointRow(data: self.listData.dataEndPoint[i], isLast: true, listData: self.listData)
                        } else {
                            EndPointRow(data: self.listData.dataEndPoint[i], isLast: false, listData: self.listData)
                        }
                    }
                }
                .navigationBarTitle(Text("\(self.listData.endPoint)"), displayMode: .large)
                .navigationViewStyle(StackNavigationViewStyle())
            }
        }
    }
}
struct ComicList_Previews: PreviewProvider {
    static var previews: some View {
        EndPointList()
    }
}
