//
//  BackGroundView.swift
//  Bullseye
//
//  Created by AbdulKadir Akkaş on 8.02.2022.
//

import SwiftUI

struct BackGroundView: View {
    @Binding var game: Game
    
    var body: some View {
        VStack{
            TopView(game: $game)
            Spacer()
            BottomView(game: $game)
        }
        .padding()
        .background(
            RingsView()
        )
    }
}

struct TopView: View {
    @Binding var game: Game
    @State private var leaderBoardIsShowing = false

    var body: some View {
        HStack{
            Button {
                game.restart()
            } label: {
                RoundedImageViewStroked(systemName: "arrow.counterclockwise")
            }
            Spacer()
            Button {
                leaderBoardIsShowing = true
            } label: {
                RoundedImageViewFilled(systemName: "list.dash")
            }.sheet(isPresented: $leaderBoardIsShowing) {
            } content: {
                LeaderboardView(leaderBoardIsShowing: $leaderBoardIsShowing, game: $game)
            }
        }
    }
}

struct NumberView: View {
    var tittle: String
    var text: String

    var body: some View {
        VStack(spacing: 5){
            LabelText(text: tittle.uppercased())
            RoundedRectTextView(text: text)
        }
    }
}

struct BottomView: View {
    @Binding var game: Game

    var body: some View {
        HStack{
            NumberView(tittle: "Score", text: String(game.score))
            Spacer()
            NumberView(tittle: "Round", text: String(game.round))
        }
    }
}

struct RingsView: View {

    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ZStack{
            Color("BackgroundColor")
                .ignoresSafeArea(.all)
            ForEach(1..<6){ ring in
                let size = CGFloat(ring * 100)
                let opacity = colorScheme == .dark ? 0.1 : 0.3
                Circle()
                    .stroke(lineWidth: 20)
                    .fill(
                        RadialGradient(gradient: Gradient(colors: [Color("RingsColor").opacity(opacity), Color("RingsColor").opacity(0)]), center: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, startRadius: 100, endRadius: 300)
                    )
                    .frame(width: size, height: size)
            }
        }
    }
}

struct BackGroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackGroundView(game: .constant(Game()))
    }
}
