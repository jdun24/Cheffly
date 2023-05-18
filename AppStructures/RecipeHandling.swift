//
//  RecipeStructs.swift
//  chefflyApp
//
//  Created by Lil Uzi on 5/15/23.
//

import Foundation


struct Recipe: Codable {
    let name: String
    let ingredients: [String]
    let instructions: [String]
    let description: String
}

class RecipesManager {
    static let shared = RecipesManager()
    
    private let recipesFileName = "user_recipes.json"
    
    private var recipes: [Recipe] = []
    
    private init() {
        // Load recipes from the JSON file on initialization
        recipes = self.loadRecipes()
    }
    
    private func loadRecipes() -> [Recipe] {
        guard let fileURL = getRecipesFileURL(),
              let data = try? Data(contentsOf: fileURL) else {
            return []
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([Recipe].self, from: data)
        } catch {
            print("Error loading recipes: \(error)")
            return []
        }
    }
    
    private func saveRecipes() {
        guard let fileURL = getRecipesFileURL() else {
            return
        }
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(recipes)
            try data.write(to: fileURL)
        } catch {
            print("Error saving recipes: \(error)")
        }
    }
    
    private func getRecipesFileURL() -> URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        print(documentsDirectory.appendingPathComponent(recipesFileName))
        return documentsDirectory.appendingPathComponent(recipesFileName)
    }
    
    func getAllRecipes() -> [Recipe] {
        return recipes
    }
    
    func addRecipe(_ recipe: Recipe) {
        recipes.append(recipe)
        saveRecipes()
    }
    
    func removeRecipe(at index: Int) {
        recipes.remove(at: index)
        saveRecipes()
    }
    
    func printAllRecipes() {
            for (index, recipe) in recipes.enumerated() {
                print("Recipe #\(index + 1):")
                print("Name: \(recipe.name)")
                print("Ingredients: \(recipe.ingredients.joined(separator: ", "))")
                print("Instructions: \(recipe.instructions.joined(separator: "\n"))")
                print("Description: \(recipe.description)")
                print("------------------------")
            }
        }
}
