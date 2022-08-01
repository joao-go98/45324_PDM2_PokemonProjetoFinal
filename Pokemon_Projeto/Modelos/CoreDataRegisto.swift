//
//  CoreDataRegisto.swift
//  Pokemon_Projeto
//
//  Created by Developer on 29/07/2022.
//

import Foundation
import CoreData

class CoreDataRegisto {
    
    let persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name: "Historico")
        persistentContainer.loadPersistentStores{
            (description, error) in
            if let error = error { fatalError("Core data falhou \(error.localizedDescription)") }
            }
    }
    
    func getHistorico() -> [Historico]
    {
        let fetchRequest: NSFetchRequest<Historico> = Historico.fetchRequest()
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        }
        catch {
            return []
        }
    }
    
    func saveHistorico(vencedor: String, xp:Int ,mes: Int ,dia: Int, hora: Date){
        
        let historico = Historico(context: persistentContainer.viewContext)
        historico.vencedor = vencedor
        historico.xp = Int32(xp)
        historico.mes = Int32(mes)
        historico.dia = Int32(dia)
        historico.hora = hora
        
        do{
            try persistentContainer.viewContext.save()
        }
        catch{
            print("augh \(error)")
        }
        
    }
    
    func deleteHistorico(historico: Historico){
        persistentContainer.viewContext.delete(historico)
        
        do{
            try persistentContainer.viewContext.save()
        }
        catch{
            persistentContainer.viewContext.rollback()
            print("Falhou \(error)")
        }
        
    }

}
