//
//  Pokemon.swift
//  Pokemon_Projeto
//
//  Created by Developer on 29/07/2022.
//

import Foundation

//MODELO DO POKÉMON LOCAL (É USADO NO POKÉMON ADVERSARIO)
struct PokeModelo {
    //os pokemon adversarios serao sempre pokemon shiny
    var imagem: String = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/\(Int.random(in: 1..<251)).png"
    var vida: Int = Int.random(in: 70..<100)
    var ataque: Int  = Int.random(in: 1..<100)
    var defesa: Int =  Int.random(in: 1..<100)
    var tipo: String = ""
}

//CHAMADAS A API
//Obter os nomes e sprites de frente de cada um dos primeiros 251 pokémon
struct Pokemon : Codable{
    var results: [PokemonDetalhes]
}

struct PokemonDetalhes : Codable, Identifiable, Equatable  {
    let id = UUID()
    var name: String
    var url: String
}

class PokemonApi1  {
    func getResults(completion:@escaping ([PokemonDetalhes]) -> ()) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=251") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            let pokemonList = try! JSONDecoder().decode(Pokemon.self, from: data)
            
            DispatchQueue.main.async {
                completion(pokemonList.results)
            }
            
        }.resume()
    }
}

//Guardar Os sprites de frente e de trás dos Pokémon
struct PokemonImagem : Codable {
    var sprites: PokemonSprites
}

struct PokemonSprites : Codable {
    var front_default: String?
    var back_default: String?
}

class PokemonImagemApi  {
    func getSprite(url: String, completion:@escaping (PokemonSprites) -> ()) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            let pokemonSprite = try! JSONDecoder().decode(PokemonImagem.self, from: data)
            
            DispatchQueue.main.async {
                completion(pokemonSprite.sprites)
            }
        }.resume()
    }
}


//Obter Informaçao especifica sobre o pokémon no qual clicamos para ver mais detalhes

//TIPO DO POKEMON
struct Pokemon2 : Codable{
    var types: [PokemonDetalhesTipo]
}

struct PokemonDetalhesTipo : Codable, Identifiable  {
    let id = UUID()
    var slot: Int
    var type: types?
}

struct types: Codable{
    var name: String
    var url: String
}

class PokemonApi2  {
    func getTypes(nome: String , _ completion:@escaping ([PokemonDetalhesTipo]) -> ()) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(nome)") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            let pokemonList = try! JSONDecoder().decode(Pokemon2.self, from: data)
            
            DispatchQueue.main.async {
                completion(pokemonList.types)
            }
            
        }.resume()
    }
}

//STATS DO POKÉMON
struct Pokemon3 : Codable{
    var stats: [PokemonDetalhesStats]
}

struct PokemonDetalhesStats : Codable, Identifiable  {
    let id = UUID()
    var base_stat: Int
    var stat: stats?
}

struct stats: Codable{
    var name: String
}

class PokemonApi3  {
    func getStats(nome: String , _ completion:@escaping ([PokemonDetalhesStats]) -> ()) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(nome)") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            let pokemonList = try! JSONDecoder().decode(Pokemon3.self, from: data)
            
            DispatchQueue.main.async {
                completion(pokemonList.stats)
            }
            
        }.resume()
    }
}

