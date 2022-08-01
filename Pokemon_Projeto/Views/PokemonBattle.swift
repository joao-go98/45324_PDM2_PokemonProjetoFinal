//
//  PokemonBattle.swift
//  Pokemon_Projeto
//
//  Created by Developer on 29/07/2022.
//

import SwiftUI

struct PokemonBattle: View {
    //valores vindos da view anterior
    @State var pokenome: String = ""
    @State var poketipo : String = ""
    @State var pokeforte: String = ""
    @State var pokefraqueza: String = ""
    @State var pokehp: Int = 150
    @State var pokeatk: Int = 10
    @State var pokedef: Int = 40
    @State var pokeimg: String = ""
    
    //maximo de vida - valor defaut igual ao valor passado da view anterior que nao se altera
    @State var pokemaxhp: Int = 150
    
    @State private var showingPopover = false
    
    //XP para o vencedor da batalha
    @State var xp: Int = Int.random(in: 30..<100)
    
    //pokemon adversario
    @State var poke2 = PokeModelo()
    
    @State var poke2maxhp = 100
    @State var metadevidarival: Int = 0
    @State var quartovidarival: Int = 0
    
    @State var player_vivo: Bool = true
    @State var inimigo_vivo: Bool = true
            
    @State var acao: String = "A espera do jogador"
    @State var turno: Int = 1
    
    @State var metadevida: Int = 0
    @State var quartovida: Int = 0
    
    let rng_player = Int.random(in: 3..<9)
    
    let rng_rival = Int.random(in: 3..<6)
    
    func jogador_ataca(vidatira: Int)
    {
        let dano = (poke2.defesa + vidatira) / rng_player
        poke2.vida = poke2.vida - dano
    }
    
    func inimigo_ataca(vidatira: Int)
    {
        let dano = (pokedef + vidatira)  / rng_rival
        pokehp = pokehp - dano
    }
    
    @State var passturno: String = "Atacar"
    
    @State var bar_color = Color(red: 0.0, green: 0.50, blue: 0.0)
    @State var bar_color2 = Color(red: 0.0, green: 0.50, blue: 0.0)
    
    @State var batalha_terminada = false
    
    func verificacoes(){
        metadevida = pokemaxhp / 2
        if(metadevida >= pokehp)
        {
            bar_color = Color(red: 0.84, green: 0.84, blue: 0.0)
        }
        
        quartovida = pokemaxhp / 4
        if(quartovida >= pokehp)
        {
            bar_color = Color(red: 0.80, green: 0.0, blue: 0.0)
        }
        
        metadevidarival = poke2maxhp / 2
        if(metadevidarival >= poke2.vida)
        {
            bar_color2 = Color(red: 0.84, green: 0.84, blue: 0.0)
        }
        
        quartovidarival = poke2maxhp / 4
        if(quartovidarival >= poke2.vida)
        {
            bar_color2 = Color(red: 0.80, green: 0.0, blue: 0.0)
        }
    }
    
    @State private var historicos: [Historico] = [Historico]()
    let coreDH: CoreDataRegisto
    
    private func populateHistorico(){
        historicos = coreDH.getHistorico()
    }
    
    let horas = Date.now
    
    let date = Date()
    let calendar = Calendar.current
    
    @State var testes: String = ""
    
    var body: some View {
        
        NavigationView{
            if player_vivo{
                if inimigo_vivo{
                    
                    VStack{
            
                        ZStack{
                            Text(acao)
                                .shadow(color: .black, radius: 6)
                        }.background(Color.white)
                        
                        //layout do rival
                        HStack{
                            Text("HP:")
                            ProgressView(value: Double(poke2.vida), total: Double(poke2maxhp))
                                .accentColor(bar_color2)
                                .cornerRadius(5)
                                .padding([.trailing], 50)
                        }
                        
                        
                        
                        Button {showingPopover = true}
                        label: {
                            AsyncImage(url: URL(string: poke2.imagem))
                                .frame(width: 75, height: 75)
                            .padding([.bottom], 50)
                            .padding([.leading], 125)
                            .foregroundColor(Color.gray.opacity(0.60))
                            .scaledToFit()
                        }
                        .popover(isPresented: $showingPopover) {
                            AsyncImage(url: URL(string: poke2.imagem))
                                .frame(width: 75, height: 75)
                            Text("Vida maxima do adversario: \(poke2maxhp)")
                            Text("Vida do adversario: \(poke2.vida)")
                            Text("Ataque do adversario: \(poke2.ataque)")
                            Text("Defesa do adversario: \(poke2.defesa)")
                        }
                        .shadow(color: .black, radius: 3)
                        
                        //layout do player
                        HStack{
                            Text("HP:")
                                .padding([.leading], 50)
                            
                            ProgressView(value: Double(pokehp), total: Double(pokemaxhp))
                                .accentColor(bar_color)
                                .cornerRadius(5)
                                .padding([.trailing], 5)
                        }
                        
                        Text("\(pokehp)/\(pokemaxhp)")
                            .foregroundColor(bar_color)
                            .padding([.leading], 250)
                        
                        PokemonBackSprite(imageLink: pokeimg)
                            .frame(width: 75, height: 75)
                            .padding([.top], 50)
                            .padding([.trailing], 125)
                        
                        Button(passturno)
                        {
                            //Sistema de Turnos
                            if(turno == 1)
                            {
                                //Caso Estejamos no primeiro turno
                                if(acao == "A espera do jogador")
                                {
                                    acao = "O jogador atacou"
                                    jogador_ataca(vidatira: pokeatk)
                                    turno += 1
                                    passturno = "Proximo turno"
                                }
                            }
                            else{
                                //Caso nao estejamos no primeiro turno
                                if(acao == "O jogador atacou")
                                {
                                    acao = "O inimigo atacou"
                                    inimigo_ataca(vidatira: poke2.ataque)
                                }
                                else{
                                    if(acao == "O inimigo atacou")
                                    {
                                        acao = "A espera do jogador"
                                        turno = 1
                                        passturno = "Atacar"
                                    }
                                }
                                
                            }
                            
                            verificacoes()
                            
                            //verificar se o player está vivo
                            if(pokehp <= 0)
                            {
                                pokehp = 0
                                //Registar o mes
                                let registomes = calendar.dateComponents([.month], from: date)
                                let mes = registomes.month
                                //Registar o dia
                                let registodia = calendar.dateComponents([.day], from: date)
                                let dia = registodia.day
                                coreDH.saveHistorico(vencedor: "Adversario", xp: xp ,mes: mes ?? 1 ,dia: dia ?? 1 ,hora: horas)
                                populateHistorico()
                                player_vivo = false
                                acao = ""
                            }
                            //verificar se o adversario está vivo
                            if(poke2.vida <= 0)
                            {
                                poke2.vida = 0
                                //Registar o mes
                                let registomes = calendar.dateComponents([.month], from: date)
                                let mes = registomes.month
                                //Registar o dia
                                let registodia = calendar.dateComponents([.day], from: date)
                                let dia = registodia.day
                                coreDH.saveHistorico(vencedor: "Jogador", xp: xp , mes: mes ?? 1 ,dia: dia ?? 1 ,hora: horas)
                                populateHistorico()
                                inimigo_vivo =  false
                                acao = ""
                            }
                             
                             
                        }
                        .padding([.bottom], 100)
                         
                    }
                    
                }
                else{
                    Text("Parabens! \nGanhaste \(xp) pontos de XP")
                }
            }
            else{
                Text("Perdeste! \nO adversario ganhou \(xp) pontos de XP")
            }
        }
         
    }


}

struct PokemonBattle_Previews: PreviewProvider {
    static var previews: some View {
        PokemonBattle(coreDH: CoreDataRegisto())
    }
}
