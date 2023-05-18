//
//  ContentView.swift
//  chefflyApp
//
//  Created by Lil Uzi on 4/9/23.
//

import SwiftUI


struct ContentView: View {

    @State public var inApp = false
    
    var body: some View {
        
        VStack{//main stage
            VStack{//fluffer
                
            }.frame(height: 45)
            
            if inApp == true{
                MainView(leaveAction: {self.leaveApp()})
            }else{
                PreLoginView(loginAction: {self.goIntoApp()})
            }//End of else
        }
        //.border(Color(.purple), width: 5)
        .padding()
        .padding(.bottom ,35)
        .edgesIgnoringSafeArea(.all) // to fill the entire screen
    }
    public func goIntoApp(){
        inApp = true
    }
    public func leaveApp(){
        inApp = false
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
