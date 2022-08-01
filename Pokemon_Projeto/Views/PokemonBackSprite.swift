//
//  PokemonBackSprite.swift
//  Pokemon_Projeto
//
//  Created by Developer on 29/07/2022.
//

import SwiftUI

struct PokemonBackSprite: View {
    
    var imageLink = ""
    @State private var pokemonSprite = ""
    
    var body: some View {
        
        AsyncImage(url: URL(string: pokemonSprite))
            .frame(width: 90, height: 80)
            .onAppear {
                let loadedData = UserDefaults.standard.string(forKey: imageLink)
                
                if loadedData == nil {
                    getSprite(url: imageLink)
                    UserDefaults.standard.set(imageLink, forKey: imageLink)
                } else {
                    getSprite(url: loadedData!)
                }
            }
            .foregroundColor(Color.gray.opacity(0.0))
        
    }
    
    func getSprite(url: String) {
        var tempSprite: String?
        PokemonImagemApi().getSprite(url: url) { sprite in
            tempSprite = sprite.back_default
            self.pokemonSprite = tempSprite ?? "placeholder"
        }
        
    }
    
}

struct PokemonBackSprite_Previews: PreviewProvider {
    static var previews: some View {
        PokemonBackSprite()
    }
}
