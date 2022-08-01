//
//  PokemonViewHistorico.swift
//  Pokemon_Projeto
//
//  Created by Developer on 29/07/2022.
//

import SwiftUI

struct PokemonViewHistorico: View {
    
    @State private var historicos: [Historico] = [Historico]()
    let coreDH: CoreDataRegisto
    
    private func populateHistorico(){
        historicos = coreDH.getHistorico()
    }
    
    var body: some View {
        
        VStack{
            
           List
           {
               
               ForEach(historicos, id: \.self){
                   historico in
                   
                   VStack{
                       Text("Vencedor: \(historico.vencedor ?? "")")
                       Text("XP Recebido: \(historico.xp)")
                       Text("Mes: \(historico.mes )")
                       Text("Dia: \(historico.dia )")
                       Text("Hora: \(historico.hora ?? Date.now, format: .dateTime.hour().minute())")
                       
                   }
                   
                   
               }.onDelete(perform: {
                   indexSet in
                   indexSet.forEach
                   {
                       index in
                       let historico = historicos[index]
                       coreDH.deleteHistorico(historico: historico)
                       populateHistorico()
                       
                   }
               })
           }
           .onAppear(perform: {populateHistorico()})
           .navigationTitle("Historico de Batalhas")
            
        }
        
        
    }
}

struct PokemonViewHistorico_Previews: PreviewProvider {
    static var previews: some View {
        PokemonViewHistorico(coreDH: CoreDataRegisto())
    }
}
