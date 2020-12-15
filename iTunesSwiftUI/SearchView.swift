//
//  SearchView.swift
//  iTunesSwiftUI
//
//  Created by Jeff Kang on 12/14/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation
import SwiftUI

final class SearchBar: NSObject, UIViewRepresentable {
    typealias UIViewType = UISearchBar
    
    @Binding var artistName: String
    @Binding var artistGenre: String
    
    internal init(artistName: Binding<String> = .constant(""), artistGenre: Binding<String> = .constant("")) {
        _artistName = artistName
        _artistGenre = artistGenre
    }
    
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.autocapitalizationType = .none
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        // update our view whenever the SwiftUI state changes
        uiView.delegate = self
    }
}

extension SearchBar: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Search for \(searchBar.text!)")
        searchBar.endEditing(false)
        
        guard let query = searchBar.text else { return }
        
        iTunesAPI.searchArtists(for: query) { (result) in
            do {
                let artists = try result.get()
                
                guard let artist = artists.first else {
//                    print("No Artists Found")
                    self.artistName = "No Artists Found"
                    self.artistGenre = ""
                    return
                }
//                print(artist)
                self.artistName = artist.artistName
                self.artistGenre = artist.primaryGenreName
            } catch {
//                print(error)
                self.artistName = "Error Searching For Artists"
                self.artistGenre = ""
            }
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchBar()
        }
    }
}
