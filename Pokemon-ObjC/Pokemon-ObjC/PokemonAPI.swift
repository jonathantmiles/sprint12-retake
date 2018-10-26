//
//  PokemonAPI.swift
//  Pokemon-ObjC
//
//  Created by Jonathan T. Miles on 10/26/18.
//  Copyright © 2018 Jonathan T. Miles. All rights reserved.
//

import Foundation

@objc class PokemonAPI: NSObject {
    
    @objc(sharedController) static let shared: PokemonAPI = PokemonAPI()
    
    @objc func fetchAllPokemon(completion: @escaping ([JTMPokemonObject]?, Error?) -> Void) {
        
        URLSession.shared.dataTask(with: baseURL) { (data, _, error) in
            if let error = error {
                NSLog("Error with dataTask: \(error)")
                completion(nil, error)
                return
            }
            guard let data = data else { return }
            
            do {
                let pokemonDictionary: Dictionary<String, AnyHashable> = try JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String, AnyHashable>
                
                let pokemonResults = pokemonDictionary["results"] as! [Dictionary<String, String>]
                
                var pokemonArray: [JTMPokemonObject] = []

                for result in pokemonResults {
                    
                    if let name = result["name"] {
                        let pokemon = JTMPokemonObject(name: name, id: nil, spriteURL: nil, abilities: nil)
                        pokemonArray.append(pokemon)
                    }
                    
                }
                
                completion(pokemonArray, nil)
                return
            } catch {
                NSLog("Error decoding into pokemonArray")
                return
            }
        }.resume()
    }
    
    @objc func fillInDetails(for pokemon: JTMPokemonObject) {
        
        let url = baseURL.appendingPathComponent("\(pokemon.name)")
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                NSLog("Error handling data: \(error)")
                return
            }
            guard let data = data else { return }
            
            do {
                let pokemonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String, AnyHashable>
                pokemon.id = pokemonDictionary["id"] as? NSNumber
                let pokemonSprites = pokemonDictionary["sprites"] as! Dictionary<String, String>
                pokemon.spriteURL = URL(string: pokemonSprites["front_default"]!)
                let pokemonAbilities = pokemonDictionary["abilities"] as! [Dictionary<String, AnyHashable>]
                for ability in pokemonAbilities {
                    let name = ability["name"] as! String
                    pokemon.abilities?.append(name)
                }
            } catch {
                NSLog("Error setting attributes of pokemon inside of JSONSerialization habitat")
                return
            }
        }.resume()
    }
    
    // var pokemonArray = [JTMPokemonObject]()
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
}
