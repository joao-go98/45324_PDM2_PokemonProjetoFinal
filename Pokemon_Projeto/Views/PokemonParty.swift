//
//  PokemonParty.swift
//  Pokemon_Projeto
//
//  Created by Developer on 29/07/2022.
//

import SwiftUI

struct PokemonParty: View {
    @State var nome: String = ""
    @State var imglink: String = ""
    @State var tipodomon: String = ""
    @State var vidamon: Int = 0
    @State var ataquemon: Int = 0
    @State var defesamon: Int = 0
    
    var body: some View {
        
        VStack{
            
            PokemonFrontSprite(imageLink: imglink)
            Text("Nome: \(nome)")
            Text("Tipo: \(tipodomon)")
            Text("Vida: \(vidamon)")
            Text("Ataque: \(String(ataquemon))")
            Text("Defesa: \(String(defesamon))")
            
            NavigationLink(destination: PokemonBattle(pokenome: nome ,pokehp: vidamon, pokeimg: imglink, pokemaxhp: vidamon, coreDH: CoreDataRegisto()))
            {Text("Combater com: \(nome)".capitalized)}
            
             
             
        }
        
        
        
    }
    
    
    
}

struct PokemonParty_Previews: PreviewProvider {
    static var previews: some View {
        PokemonParty()
    }
}
