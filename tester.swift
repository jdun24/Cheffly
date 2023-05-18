//
//  tester.swift
//  chefflyApp
//
//  Created by Lil Uzi on 5/12/23.
//

import SwiftUI

//let allRecipes = recipesManager.getAllRecipes()

struct tester: View, RetrieveAccountManager {
    var newRecipe: Recipe = Recipe(name: "sandwhich", ingredients: ["bread", "ham", "cheese"], instructions: ["put ham on bread", "put cheese on bread", "eat sammich"], description: "its a sammich")
    //recipesManager.printAllRecipes()
    @State private var username: String = ""
    
    var body: some View {
        VStack{
            List{
                Button{
                    print(currentAccount?.accountData.username)
                }label: {
                    Text("check current account name")
                }
                Button{
                    currentAccount?.writeAccountToJson()
                }label: {
                    Text("writeAccountToJson()")
                }
                Button{
                    currentAccount?.accountData = currentAccount?.loadAccount(username: "Tay") ?? UserData.init(username: "N/A", myRecipeBook: [])
                }label: {
                    Text("loadAccount() load account from json")
                }
                Button{
                    currentAccount?.printAllAccounts()
                }label: {
                    Text("printAllAccount")
                }
                Button{
                    currentAccount?.deleteJsonAccountEntry()
                }label:{
                    Text("deleteJsonAccountEntry()")
                }
            }
            TextField("Username", text: $username)
                .padding()
                .background(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
                .padding(.bottom, 20)
            Button{
                currentAccount?.accountData.username = username
            }label: {
                Text("update account to textfield")
            }
        }
    }
}


struct tester_Previews: PreviewProvider {
    static var previews: some View {
        tester()
    }
}

