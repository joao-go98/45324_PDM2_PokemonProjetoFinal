//
//  PokemonDetailAPI.swift
//  Pokemon_Projeto
//
//  Created by Developer on 29/07/2022.
//

import SwiftUI

struct PokemonDetailAPI: View {
    //variaveis recebidas da view anterior
    @State var nome: String = "bulbasaur"
    @State var imgfront: String = ""
    @State var imgback: String = ""
    @State var number: Int = 1
    
    //valores default dos pokemons "costumizaveis"
    @State var type: String = ""
    @State var hp: Double = 1
    @State var atk: Double = 1
    @State var def: Double = 1
    @State var spatk: Double = 1
    @State var spdef: Double = 1
    @State var speed: Double = 1
    
    //Informaçoes dos tipos e dos stats vindas da API
    @State var pokemon = [PokemonDetalhesTipo]()
    @State var pokemon3 = [PokemonDetalhesStats]()
    
    //Boolean
    @State private var showingPopover = false
    @State private var cliked = false
    
    //Textos Placeholders
    @State var textotipo: String = "Selecionar Tipo"
    @State var textin: String = "Adicionar á equipa"
    
    //CORE DATA
    @State private var pokemonparty: [PartyDetalhe] = [PartyDetalhe]()
    let coreDP: CoreDataParty
    
    private func populatePokemon(){ pokemonparty = coreDP.getPartyMon() }
    
    
    var body: some View {
        
        VStack{
                        
            List {
                //para cada pokemon criar uma entrada na lista
                Section(header: Text("Costumizar \(nome)".capitalized)) {
                    
                    HStack{
                        PokemonFrontSprite(imageLink: imgfront)
                        PokemonBackSprite(imageLink: imgback)
                    }
                    
                    Text("Nome: \(nome)".capitalized)
                    Text("Numero: \(number)")
                    }
                    .headerProminence(.increased)
                
                Section(header: Text("Tipo"))
                    {
                        
                        Menu(textotipo){
                            ForEach(pokemon) {
                                entry in
                                Button(entry.type!.name.capitalized)
                                {
                                    self.type = entry.type!.name.capitalized
                                    textotipo = entry.type!.name.capitalized
                                }
                            }
                        }
                        
                    }
                    .headerProminence(.increased)
                
                Section(header: Text("Stats"))
                    {
                        ForEach(pokemon3)
                        {
                            entra in
                        
                            HStack{
                                
                                if (entra.stat!.name == "hp")
                                {
                                    Text("HP: \(Int(hp))")
                                    Slider(value: $hp, in: 1...Double(entra.base_stat))
                                }
                                
                                if (entra.stat!.name == "attack")
                                {
                                    Text("ATK: \(Int(atk))")
                                    Slider(value: $atk, in: 1...Double(entra.base_stat))
                                }
                               
                                if (entra.stat!.name == "defense")
                                {
                                    Text("DEF: \(Int(def))")
                                    Slider(value: $def, in: 1...Double(entra.base_stat))
                                }
                                
                                if (entra.stat!.name == "special-attack")
                                {
                                    Text("SPATK: \(Int(spatk))").foregroundColor(.red)
                                    Slider(value: $spatk, in: 1...Double(entra.base_stat)).disabled(true)
                                }
                                
                                if (entra.stat!.name == "special-defense")
                                {
                                    Text("SPDEF: \(Int(spdef))").foregroundColor(.red)
                                    Slider(value: $spdef, in: 1...Double(entra.base_stat)).disabled(true)
                                }
                                
                                if (entra.stat!.name == "speed")
                                {
                                    Text("SPEED: \(Int(speed))").foregroundColor(.red)
                                    Slider(value: $speed, in: 1...Double(entra.base_stat)).disabled(true)
                                }
                                
                            }
                            
                        }
                        
                        
                    }
                    .headerProminence(.increased)
                 
                if(type == "")
                {
                    Text("Selecione o Tipo do \(nome)".capitalized)
                }
                else{
                    Button("Adicionar á equipa") {
                        showingPopover = true
                    }
                    .popover(isPresented: $showingPopover) {
                        
                        PokemonFrontSprite(imageLink: imgfront)
                        Text("Adicionar \(nome)?".capitalized)
                            .padding([.bottom], 10)
                        
                        HStack{
                            Text("Tipo:")
                            Text("\(type)")
                            
                        }
                        
                        HStack{
                            Text("HP:")
                            Text("\(Int(hp))")
                        }
                        
                        HStack{
                            Text("Ataque:")
                            Text("\(Int(atk))")
                        }
                        
                        HStack{
                            Text("Defesa:")
                            Text("\(Int(def))")
                        }
                        
                        Button(textin){
                            
                            coreDP.savePartyMon(nome: nome.capitalized, img: imgfront, imgtras: imgback, tipo: type.capitalized, vida: Int(hp), ataque: Int(atk), defesa: Int(def))
                            
                            cliked = true
                        }.padding()
                            .disabled(cliked)
                        
                    }
                    
                }
                
            }
            .onAppear {
                PokemonApi2().getTypes(nome: nome) {
                    pokemon in
                    self.pokemon = pokemon
                }
                
                PokemonApi3().getStats(nome: nome) {
                    pokemon in
                    self.pokemon3 = pokemon
                }
                
            }
            .navigationTitle("\(nome)".capitalized)
            
        }
        
        
        
        
    }
    
    
}

struct PokemonDetailAPI_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailAPI(coreDP: CoreDataParty())
    }
}
