//
//  PokemonDetailViewController.swift
//  Pokemon-ObjC
//
//  Created by Jonathan T. Miles on 10/26/18.
//  Copyright © 2018 Jonathan T. Miles. All rights reserved.
//

import UIKit

@objc class PokemonDetailViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let pokemon = pokemon {
            PokemonAPI.shared.fillInDetails(for: pokemon)
        }
        
        observation = observe(\.pokemon, changeHandler: { (object, change) in
            self.updateViews()
        })
    }
    
    private func updateViews() {
        if let pokemon = pokemon,
            let idString = pokemon.id?.stringValue,
            let abilities = pokemon.abilities,
            let imageURL = pokemon.spriteURL {
            
            var abilityString = ""
            for ability in abilities {
                abilityString.append(contentsOf: "\(ability) \n")
            }
            
            DispatchQueue.main.async {
                self.title = pokemon.name
                self.nameLabel.text = "Name: \(pokemon.name)"
                self.idLabel.text = "ID: \(idString)"
                self.abilitiesListLabel.text = abilityString
            }
            
            URLSession.shared.dataTask(with: imageURL) { (data, _, error) in
                if let error = error {
                    NSLog("Error with imageURL dataTask: \(error)")
                    return
                }
                guard let data = data else { return }
                
                DispatchQueue.main.async {
                    self.spriteImageView.image = UIImage(data: data)
                    
                }
            }.resume()
            
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Properties
    
    //let pokemonAPI = PokemonAPI()
    
    @objc var pokemon: JTMPokemonObject?
    
    var observation: NSKeyValueObservation?
    
    //private var image: UIImage?

    @IBOutlet weak var spriteImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var abilitiesListLabel: UILabel!
}
