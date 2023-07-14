//
//  File.swift
//  
//
//  Created by David Tacite on 14/07/2023.
//

import Foundation

open class Elements {
    static public let shared : Elements = Elements()
    var elements = [Element]()
    
    private init() {}
    
    public func fillData() {
        guard let fileURL = Bundle.module.url(forResource: "Data", withExtension: "json") else {
            fatalError("Fichier introuvable zebi")
        }
        do {
            let jsonData = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            elements = try decoder.decode([Element].self, from: jsonData)
        } catch {
            print("erreur lors du decodage des données")
        }
    }
    
    public func getElements() -> [Element] {
        return elements
    }
}
