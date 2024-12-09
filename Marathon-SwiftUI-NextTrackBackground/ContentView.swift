//
//  ContentView.swift
//  Marathon-SwiftUI-NextTrackBackground
//
//  Created by Sergey Leontiev on 8.12.24..
//

import SwiftUI

struct ContentView: View {
    @State var buttonTapped: Bool = false
    private let imageName = "play.fill"
    
    var body: some View {
        Button {
            guard !buttonTapped else { return }
            withAnimation(.interpolatingSpring(stiffness: 170, damping: 15)) {
                buttonTapped = true
            } completion: {
                buttonTapped = false
            }
        } label: {
            GeometryReader { proxy in
                let size = proxy.size.width / 2
                HStack(alignment: .center, spacing: 0) {
                    Image(systemName: imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: buttonTapped ? size : 0)
                        .opacity(buttonTapped ? 1 : 0)
                    Image(systemName: imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: size)
                    Image(systemName: imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: buttonTapped ? 1 : size)
                        .opacity(buttonTapped ? 0 : 1)
                }.frame(maxHeight: .infinity, alignment: .center)
            }
        }
        .buttonStyle(ResultButtonStyle())
    }
}

struct ResultButtonStyle: ButtonStyle {
    @State var buttonTapped: Bool = false
    private let animationDuration: CGFloat = 0.22
    private let size: CGFloat = 60
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: size, maxHeight: size)
            .scaleEffect(buttonTapped ? 0.86 : 1)
            .background {
                Circle()
                    .foregroundStyle(.gray)
                    .scaleEffect(1.4)
                    .opacity(buttonTapped ? 0.1 : 0)
            }
            .onChange(of: configuration.isPressed) { _, newValue in
                guard !newValue else { return }
                guard !buttonTapped else { return }
                withAnimation(.easeInOut(duration: animationDuration)) {
                    buttonTapped = true
                } completion: {
                    withAnimation(.easeInOut(duration: animationDuration)) {
                        buttonTapped = false
                    }
                }
            }
    }
}

#Preview {
    ContentView()
}
