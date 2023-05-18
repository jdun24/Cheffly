//
//  userStructs.swift
//  chefflyApp
//
//  Created by Lil Uzi on 5/13/23.
//

import Foundation

func clearUserData(dataToClear: inout UserData){
    dataToClear.username = "N/A"
    dataToClear.myRecipeBook = []
}

struct UserData: Codable {
    var username: String
    var myRecipeBook: [Recipe]

    private enum CodingKeys: String, CodingKey {
        case username = "_username"
        case myRecipeBook
    }
    
}

class AccountManager {
    var accountData: UserData
    static let shared = AccountManager()
    
    //private let DB_FileName = "db.json"
    private let DB_FileName = "user_recipes.json"
    
    enum AccountError: Error{
        case accountAlreadyExists
    }
    
    private init() {
        // Load the account from storage or set it to nil
        print("new account manager initalized")
        accountData = UserData(username: "N/A", myRecipeBook: [])
    }
    
    private func getDBFileURL() -> URL?{
        guard let documentsDirectory = FileManager.default.urls(for:
                .documentDirectory, in: .userDomainMask).first else{
            print("DB File not found!!! getDBFileURL() inFile userStructs.swift")
            return nil
        }
        return documentsDirectory.appendingPathComponent(DB_FileName)
    }
    
    
    func logout() {
        // Set the current account to nil
        clearUserData(dataToClear: &accountData)
    }

    
    func deleteAccount() {
        
        do{
            print(accountData.username)
            try deleteStoredCredentials(forUsername: accountData.username)
        }catch{
            print("Error deleting Account -- deleteAccount() inFile userStruct \(error)")
        }
        // Clear the current account
        clearUserData(dataToClear: &accountData)
        // Clear the stored account from storage
        deleteJsonAccountEntry()
    }
    
    func loadAccount(username: String) -> UserData? {
        guard let fileURL = getDBFileURL() else {
            print("File URL is nil.")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let allAccounts = try decoder.decode([UserData].self, from: data)
            
            if let accountData = allAccounts.first(where: { $0.username == username }) {
                return accountData
            } else {
                print("Account not found for username: \(username)")
                return nil
            }
        } catch let error as NSError {
            print("Error loading account: \(error.localizedDescription)")
            return nil
        }
    }
    
    func deleteJsonAccountEntry() {//gets rid of account in json
        guard let fileURL = getDBFileURL() else {
            return
        }
        
        do {
            // Check if the account file exists at the specified fileURL
            if FileManager.default.fileExists(atPath: fileURL.path) {
                try FileManager.default.removeItem(at: fileURL)
            }
        } catch {
            print("Error clearing Account -- clearAccount() -- inFile userStructs: \(error)")
        }
    }
    
    func writeAccountToJson() {
        guard let fileURL = getDBFileURL() else {
            return
        }
        
        // Read existing accounts
        var existingAccounts: [UserData] = []
        if let data = try? Data(contentsOf: fileURL) {
            do {
                let decoder = JSONDecoder()
                existingAccounts = try decoder.decode([UserData].self, from: data)
            } catch {
                print("Error loading existing accounts: \(error)")
            }
        }
        
        // Append new account entry
        existingAccounts.append(accountData)
        
        // Write all accounts back to the file
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted // Make the JSON output human-readable
            let data = try encoder.encode(existingAccounts)
            try data.write(to: fileURL)
        } catch {
            print("Error saving Account: \(error)")
        }
    }
    
    func printAllAccounts() {
        guard let fileURL = getDBFileURL(),
              let data = try? Data(contentsOf: fileURL) else {
            print("No accounts found.")
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let accounts = try decoder.decode([UserData].self, from: data)
            
            if accounts.isEmpty {
                print("No accounts found.")
            } else {
                print("All Accounts:")
                for account in accounts {
                    print("Username: \(account.username)")
                    print("RecipeBook: \(account.myRecipeBook)")
                }
            }
        } catch {
            print("Error loading accounts: \(error)")
        }
        
    }
    
    func populateUserData(uName: String){
        accountData.username = uName
    }
}

