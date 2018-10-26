//
//  PokemonDetailViewController.swift
//  Pokemon-ObjC
//
//  Created by Jonathan T. Miles on 10/26/18.
//  Copyright © 2018 Jonathan T. Miles. All rights reserved.
//

import UIKit

//class Observer: NSObject {
//    var observation: NSKeyValueObservation
//    @objc var pokemon: JTMPokemonObject?
//    
//    init(object: JTMPokemonObject) {
//         = object
//        super.init()
//    }
//}

@objc class PokemonDetailViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let pokemon = pokemon {
            PokemonAPI.shared.fillInDetails(for: pokemon)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

    // MARK: - Properties
    
    @objc dynamic var pokemon: JTMPokemonObject?
    
    var observation: NSKeyValueObservation?

    @IBOutlet weak var spriteImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var abilitiesListLabel: UILabel!
}
