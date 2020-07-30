//
//  Indicator.swift
//  Marvel
//
//  Created by Nazildo Souza on 02/05/20.
//  Copyright © 2020 Nazildo Souza. All rights reserved.
//

import SwiftUI

struct Loading: View {
    @Binding var animating: Bool
    
    var body: some View {
        ZStack {
            Blur(style: .systemMaterial)
                VStack {
                    Indicator(animating: $animating, style: .large)
                    Text("Aguarde")
                        .foregroundColor(.primary)
                        .padding(.top, 8)
                }
        }
        .frame(width: 110, height: 110)
        .cornerRadius(15)
    }
}

struct Indicator: UIViewRepresentable {
    @Binding var animating: Bool
    let style: UIActivityIndicatorView.Style
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: style)
        return indicator
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        animating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

struct Blur: UIViewRepresentable {
    let style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let effect = UIBlurEffect(style: style)
        let view = UIVisualEffectView(effect: effect)
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
}
