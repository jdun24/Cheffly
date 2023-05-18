//
//  RegisterView.swift
//  chefflyApp
//
//  Created by Lil Uzi on 5/14/23.
//

import SwiftUI


struct RegisterView: View, RetrieveAccountManager {
    let rectangleWidth = screenSize.width - 40 // subtracting 40 for left and right margins
    @State private var uName: String = ""
    @State private var pWord: String = ""
    @State private var pWordConfirm: String = ""
    @State private var showPW_noMatch: Bool = false
    
    
    var signUpAction: () -> Void
    
    var body: some View {
        
        VStack(spacing: 0) {
            Text("Register")
                .font(.largeTitle)
                .padding(.bottom, 30)
            TextField("Username", text: $uName)
                .padding()
                .background(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
                .padding(.bottom, 20)
            
            Rectangle()
                .frame(width: rectangleWidth, height: 5, alignment: .center)
                .padding(.bottom, 20)
                .foregroundColor(.gray)
            
            SecureField("Password", text: $pWord)
                .padding()
                .background(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
                .padding(.bottom, 15)
            SecureField("Confirm Password", text: $pWordConfirm)
                .padding()
                .background(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
                .padding(.bottom, 30)
            
            if showPW_noMatch == true{
                Text("Passwords do not match!")
                    .foregroundColor(.red)
                    .padding(.bottom, 10)
            }
            
            Button(action: { //sign up button
                if passwordConfirmed(pWordField1: pWord, pWordField2: pWordConfirm) == true{
                    saveUserCredentials(username: uName, password: pWord)
                    // ----- Entry 01 ----- Potential Security Risk // CODE_NEEDING_FIXING
                    currentAccount?.populateUserData(uName: uName)
                    currentAccount?.writeAccountToJson()
                    currentAccount?.logout()
                    signUpAction()
                }else{
                    showPW_noMatch = true
                }
            }) {
                Text("Sign Up")
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 200, height: 50)
                    .background(RoundedRectangle(cornerRadius: 25).fill(Color.blue))
                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5)
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 10)
    }
}

func passwordConfirmed(pWordField1: String, pWordField2: String) -> Bool{
    if pWordField1 == pWordField2{
        return true
    }else{
        return false
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(signUpAction:{})
    }
}

