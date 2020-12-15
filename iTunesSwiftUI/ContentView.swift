//
//  ContentView.swift
//  iTunesSwiftUI
//
//  Created by Fernando Olivares on 28/03/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var artistName = ""
    @State var artistGenre = ""
    
    var body: some View {
        VStack() {
            
            Text("Search for artists with iTunes API")
            SearchBar(artistName: $artistName, artistGenre: $artistGenre)
            
            Text(artistName)
                .font(.largeTitle)
//                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .bold()
                .multilineTextAlignment(.center)
                .lineLimit(3)
                .padding([.leading, .bottom, .trailing], 12)
            
//            TextField("Artist Name", text: $artistName)
//            TextField("Artist Genre", text: $artistGenre)
            
            HStack {
                if !artistGenre.isEmpty {
                Text("Artist Genre:")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }
                Text(artistGenre)
                    .font(.subheadline)
                    .foregroundColor(.primary)
            }
            
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            
            NavigationView {
                ContentView()
            }.environment(\.colorScheme, .dark)
            
        }
    }
}
