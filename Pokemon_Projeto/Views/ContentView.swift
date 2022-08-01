//
//  ContentView.swift
//  Pokemon_Projeto
//
//  A DATA ORIGINAL DO COMECO DO PROJETO É DIA 19/07/2022, simplesmente peguei nesse
//  projeto e "passeio a limpo" num projeto novo
//
//  Created by Developer on 29/07/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var pokemonparty: [PartyDetalhe] = [PartyDetalhe]()
    let coreDP: CoreDataParty
    
    private func populatePokemon(){ pokemonparty = coreDP.getPartyMon() }
    
    var body: some View {
        NavigationView{
            VStack{

                List
                {
                    ForEach(pokemonparty, id: \.self){
                        pokemon in
                        
                        HStack{
                            
                            PokemonFrontSprite(imageLink: "\(pokemon.imagemtras ?? "")")
                                .padding(.trailing, 20)
                            
                            NavigationLink("\(pokemon.nome ?? "")")
                            {
                                PokemonParty(nome: "\(pokemon.nome ?? "")", imglink:
                                "\(pokemon.imagem ?? "")", tipodomon:"\(pokemon.tipo ?? "")", vidamon: Int(pokemon.vida),ataquemon: Int(pokemon.ataque), defesamon: Int(pokemon.defesa))
                            }
                            
                        }
                        
                        
                    }.onDelete(perform: {
                        indexSet in
                        indexSet.forEach
                        {
                            index in
                            let pokemon = pokemonparty[index]
                            coreDP.deletePartyMon(pokemon: pokemon)
                            populatePokemon()
                            
                        }
                    })
                    
                    
                }
                
            }
             .navigationTitle("Pokémon Party")
             .toolbar{
                 
                 
                 ToolbarItem(placement: .navigationBarLeading){
                     NavigationLink("Historico")
                     {
                         PokemonViewHistorico(coreDH: CoreDataRegisto())
                     }
                 }
                 
                 
                 ToolbarItem(placement: .navigationBarTrailing){
                     
                     NavigationLink("Adicionar Pokémon") {
                         PokemonListAPI()
                     }
                     
                 }
                 
                 
             }
            
             .onAppear(perform: {populatePokemon()})
        }
        
    }
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(coreDP: CoreDataParty())
    }
}
