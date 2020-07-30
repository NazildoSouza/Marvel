//
//  MarvelData.swift
//  Marvel
//
//  Created by Nazildo Souza on 30/04/20.
//  Copyright © 2020 Nazildo Souza. All rights reserved.
//

import SwiftUI
import SwiftHash

class ApiData: ObservableObject {
    @Published var data = [Character.Results]()
    @Published var dataEndPoint = [EndPoint.Results]()
    @Published var totalCharacter = 0
    @Published var totalEndPoint = 0
    @Published var codeCharacter = 0
    @Published var codeEndPoint = 0
    @Published var currentPage = 0
    @Published var busca = ""
    @Published var idCharacter = 0
    @Published var endPoint = "comics"
    @Published var showingBusca = false
    @Published var showingBusca2 = CGSize.zero
    @Published var showHeroView = false
    let limit = 50

    init() { self.loadCharacters() }
    
    func loadCharacters() {
        let characterURL = "https://gateway.marvel.com/v1/public/characters"
        
        let offset = currentPage * limit
        var startsWith: String
        
        if !self.busca.isEmpty {
            startsWith = "nameStartsWith=\(busca.replacingOccurrences(of: " ", with: ""))&"
        } else {
            startsWith = ""
        }
   
        let url = characterURL + "?offset=\(offset)&limit=\(limit)&" + startsWith + getCredentials()
        print(url)
        
        guard let urls = URL(string: url) else {return}
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: urls) { (data, response, error) in
            
            guard let data = data else {return}
            
            do {
                let json = try JSONDecoder().decode(Character.self, from: data)
                if json.code == 200 {
                    let oldData = self.data
                    
                    DispatchQueue.main.async {
                        self.data = oldData + json.data.results
                        self.totalCharacter = json.data.total
                        self.codeCharacter = json.code
                        
                    }
                } else {
                    print("Erro no código de resposta: \(json.code)")
                }
                
            } catch {
                print("Erro ao decodificar:\n\(error)")
            }
        }.resume()
    }
    
    func loadEndPoint() {
        let urlEndPoint = "https://gateway.marvel.com/v1/public/characters/\(idCharacter)/\(endPoint.lowercased())"
         
         let offset = currentPage * limit
         var startsWith: String
         
         if !self.busca.isEmpty {
             startsWith = "nameStartsWith=\(busca.replacingOccurrences(of: " ", with: ""))&"
         } else {
             startsWith = ""
         }
    
         let url = urlEndPoint + "?offset=\(offset)&limit=\(limit)&" + startsWith + getCredentials()
         print(url)
         
         guard let urls = URL(string: url) else {return}
         let session = URLSession(configuration: .default)
         
         session.dataTask(with: urls) { (data, response, error) in
             
             guard let data = data else {return}
             
             do {
                 let json = try JSONDecoder().decode(EndPoint.self, from: data)
                 if json.code == 200 {
                     let oldData = self.dataEndPoint
                     
                     DispatchQueue.main.async {
                         self.dataEndPoint = oldData + json.data.results
                         self.totalEndPoint = json.data.total
                         self.codeEndPoint = json.code
                         
                     }
                 } else {
                     print("Erro no código de resposta: \(json.code)")
                 }
                 
             } catch {
                 print("Erro ao decodificar:\n\(error)")
             }
         }.resume()
     }
    
    func getCredentials() -> String {
        let publicKey = "8657413b8c517b2e9e62a2f6c047f05a"
        let privateKey = "6166da4e14c857f3cf40763246fddbfb66fbe123"
        
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(ts+privateKey+publicKey).lowercased()
        return "ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
    }
}
