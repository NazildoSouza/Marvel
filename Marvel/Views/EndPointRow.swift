//
//  EndPointRow.swift
//  Marvel
//
//  Created by Nazildo Souza on 02/05/20.
//  Copyright © 2020 Nazildo Souza. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct EndPointRow: View {
    var data: EndPoint.Results
    var isLast: Bool
    @ObservedObject var listData: ApiData
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            WebImage(url: URL(string: self.data.thumbnail.image), options: .highPriority, context: nil)
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .overlay(Circle().stroke(self.colorScheme == .light ? Color.red : Color(#colorLiteral(red: 0.541807109, green: 0.1609815513, blue: 0.3068930662, alpha: 1)), lineWidth: 2))
                .shadow(color: Color.primary.opacity(0.4), radius: 4, x: 0, y: 0)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(self.data.title)
                    .font(.headline)
                
                if self.isLast {
                    Text(self.data.description ?? "")
                        .font(.subheadline)
                        .lineLimit(2)
                        .onAppear {
                            if self.listData.dataEndPoint.count != self.listData.totalEndPoint {
                                self.listData.currentPage += 1
                                self.listData.loadEndPoint()
                                print("Load Data: baixados \(self.listData.dataEndPoint.count), total \(self.listData.totalEndPoint)")
                            }
                    }
                    
                } else {
                    Text(self.data.description ?? "")
                        .font(.subheadline)
                        .lineLimit(2)
                }
                
            }
        }
    }
}
