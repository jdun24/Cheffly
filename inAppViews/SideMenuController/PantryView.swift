//
//  PantryView.swift
//  chefflyApp
//
//  Created by Lil Uzi on 4/9/23.
//

import SwiftUI

let screenSize = UIScreen.main.bounds.size
let rectangleWidth = screenSize.width // subtracting 40 for left and right margins
let rectangleHeight: CGFloat = 50


struct PantryView: View {
    let items: [SFMenu] = [.Refridgerator, .Aromatics, .Cupboard]
    @State private var descriptionText = "Sample text description"
    
    var body: some View {
        VStack{
            List(items, children: \.subMenuItems){ row in
                if let subMenuItems = row.subMenuItems {//only the children items are buttons
                    Image(systemName: row.sfSymbol)
                    Text(row.name)
                }else{
                    Button{
                        //printWorked()
                    }label: {
                        Image(systemName: row.sfSymbol)
                    }
                    Text(row.name)
                }
            }//end of List
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: "book")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .cornerRadius(25)
                    Text("Product Name")
                        .font(.title2)
                        .fontWeight(.semibold)
                }
                Text("Bought on: 12/05/2023")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                TextField("Enter a description", text: $descriptionText)
                  .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding()
        }
    }//end of some View
    
}

struct PantryView_Previews: PreviewProvider {
    static var previews: some View {
        PantryView()
    }
}

func expandContainer(){
    
}


