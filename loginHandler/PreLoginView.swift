//
//  PreLoginView.swift
//  chefflyApp
//
//  Created by Lil Uzi on 5/14/23.
//

import SwiftUI

struct PreLoginView: View {
    
    @State private var loginClicked = false
    @State private var registerClicked = false
    

    
    var loginAction: () -> Void
    
    var body: some View {
        
        VStack{
            HStack{
                Text("Sign In")
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                Text("      Register")
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 189/255, green: 189/255, blue: 189/255))
            }
            if loginClicked == true || registerClicked == true{
                VStack{
                    if loginClicked == true{
                        LoginView(nested_loginAction: {self.loginAction()})
                            
                    }else if registerClicked == true{
                        RegisterView(signUpAction:{self.showLoginView()})
                    }
                }
            }
            VStack{
                if loginClicked == false{
                    Button(action: {    // login button
                        loginClicked = true
                        registerClicked = false
                    }) {
                        if registerClicked == false{    //changes login and register button based on state
                            Text("Login")
                                .foregroundColor(.white)
                                .font(.system(size: 18, weight: .bold))
                                .frame(width: 200, height: 50)
                                .background(Color.blue)
                                .cornerRadius(25)
                                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5)
                        }else{
                            Text("Login")
                                .foregroundColor(.gray)
                                .font(.system(size: 18, weight: .bold))
                                .frame(width: 200, height: 50)
                                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5)
                                .underline(true, color: Color(red: 189/255, green: 189/255, blue: 189/255))
                        }
                    }
                }
                
                if registerClicked == false{
                    Button(action: {    //register button
                        registerClicked = true
                        loginClicked = false
                    }) {
                        if loginClicked == false{
                            Text("Register")
                                .foregroundColor(.white)
                                .font(.system(size: 18, weight: .bold))
                                .frame(width: 200, height: 50)
                                .background(Color.blue)
                                .cornerRadius(25)
                                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5)
                        }else{
                            Text("Register")
                                .foregroundColor(.gray)
                                .font(.system(size: 18, weight: .bold))
                                .frame(width: 200, height: 50)
                                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5)
                                .underline(true, color: Color(red: 189/255, green: 189/255, blue: 189/255))
                        }
                    }
                }
            }
        }//end of Main VStack login screen
        .padding()
    }
    func showLoginView(){
        loginClicked = true
        registerClicked = false
    }
}

struct PreLoginView_Previews: PreviewProvider {
    static var previews: some View {
        PreLoginView(loginAction: {})
    }
}
