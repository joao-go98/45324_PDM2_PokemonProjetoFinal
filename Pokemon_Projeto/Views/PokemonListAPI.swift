//
//  PokemonListAPI.swift
//  Pokemon_Projeto
//
//  Created by Developer on 29/07/2022.
//

import SwiftUI

struct PokemonListAPI: View {
    
    @State var pokemon = [PokemonDetalhes]()
    @State private var showingPopover = false
    @State var searchText = ""
    
    var body: some View {
        
        List {
            
            if(searchText == "")
            {
                //para cada pokemon criar uma entrada na lista
                ForEach(pokemon) {
                    entry in
                    //passar de opcional para valor absoluto para poder depois passar o valor numerico onde cliquei na lista
                    let index = pokemon.firstIndex(of: entry)
                    let teste = pokemon.index(after: index!)
                                    
                    HStack {
                        PokemonFrontSprite(imageLink: "\(entry.url)")
                            .padding(.trailing, 20)
                        
                        NavigationLink(destination: PokemonDetailAPI(nome: "\(entry.name)", imgfront: entry.url , imgback: entry.url , number: teste, coreDP: CoreDataParty()))
                        {Text("\(entry.name)".capitalized)}
                                                 
                    }
                    
                }
            }
            else{
                
                //para cada pokemon criar uma entrada na lista
                ForEach(pokemon) {
                    entry in
                    //passar de opcional para nao opcional
                    let index = pokemon.firstIndex(of: entry)
                    let teste = pokemon.index(after: index!)
                    
                    if searchText == entry.name.capitalized
                    {
                        HStack {
                            PokemonFrontSprite(imageLink: "\(entry.url)")
                                .padding(.trailing, 20)
                            
                            NavigationLink(destination: PokemonDetailAPI(nome: "\(entry.name)", imgfront: entry.url , imgback: entry.url, number: teste, coreDP: CoreDataParty()))
                            {Text("\(entry.name)".capitalized)}
                           
                        }
                    }
                    
                    
                    
                    
                }
                
            }
            
            
            
            
        }
        .onAppear {
                               
            PokemonApi1().getResults() { pokemon in
                self.pokemon = pokemon
            }
            
        }
        
        .searchable(text: $searchText)
        .navigationTitle("Adicionar Pokémon")
        
    }
    
    
    
}

struct PokemonListAPI_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListAPI()
    }
}
