//
//  CoreDataParty.swift
//  Pokemon_Projeto
//
//  Created by Developer on 29/07/2022.
//

import Foundation
import CoreData

class CoreDataParty {
    
    let persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name: "Pokemon")
        persistentContainer.loadPersistentStores{
            (description, error) in
            if let error = error { fatalError("Core data falhou \(error.localizedDescription)") }
            }
    }
    
    func getPartyMon() -> [PartyDetalhe]
    {
        let fetchRequest: NSFetchRequest<PartyDetalhe> = PartyDetalhe.fetchRequest()
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        }
        catch {
            return []
        }
        
    }
    
    func deletePartyMon(pokemon: PartyDetalhe){
        persistentContainer.viewContext.delete(pokemon)
        
        do{
            try persistentContainer.viewContext.save()
        }
        catch{
            persistentContainer.viewContext.rollback()
            print("Core Data Crashou \(error)")
        }
        
    }
    
    func savePartyMon(nome: String, img: String, imgtras: String, tipo: String, vida: Int,ataque: Int, defesa: Int){
        
        let pokemon = PartyDetalhe(context: persistentContainer.viewContext)
        pokemon.nome = nome
        pokemon.imagem = img
        pokemon.imagemtras = imgtras
        pokemon.tipo = tipo
        pokemon.vida = Int32(vida)
        pokemon.ataque = Int32(ataque)
        pokemon.defesa = Int32(defesa)
        
        do{
            try persistentContainer.viewContext.save()
        }
        catch{
            print("augh \(error)")
        }
        
        
    }
    
}

