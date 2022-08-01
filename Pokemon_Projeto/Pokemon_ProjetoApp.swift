//
//  Pokemon_ProjetoApp.swift
//  Pokemon_Projeto
//
//  Created by Developer on 29/07/2022.
//

import SwiftUI

@main
struct Pokemon_ProjetoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(coreDP: CoreDataParty())
        }
    }
}
