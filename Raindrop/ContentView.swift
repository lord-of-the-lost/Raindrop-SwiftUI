//
//  ContentView.swift
//  Raindrop
//
//  Created by Николай Игнатов on 23.10.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var dragOffset: CGSize = .zero
    
    var body: some View {
        Canvas { context, size in
            context.addFilter(.alphaThreshold(min: 0.5, color: .black))
            context.addFilter(.blur(radius: 30))
            
            context.drawLayer { ctx in
                for index in [1, 2] {
                    if let resolvedView = context.resolveSymbol(id: index) {
                        ctx.draw(resolvedView, at: CGPoint(x: size.width / 2, y: size.height / 2))
                    }
                }
            }
        } symbols: {
            Circle()
                .fill(.black)
                .frame(width: 150, height: 150)
                .offset(.zero)
                .tag(1)
            
            Circle()
                .fill(.black)
                .frame(width: 150, height: 150)
                .offset(dragOffset)
                .tag(2)
            
        }
        .gesture(
            DragGesture()
                .onChanged({ value in
                    dragOffset = value.translation
                })
                .onEnded({ _ in
                    withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                        dragOffset = .zero
                    }
                })
        )
    }
}

#Preview {
    ContentView()
}
