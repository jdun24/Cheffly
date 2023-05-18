//
//  MainView.swift
//  chefflyApp
//
//  Created by Lil Uzi on 5/14/23.
//

import SwiftUI

var appName: String = "Cheffly"
var appNavBottomWidth: CGFloat = 75
var appNavBottomHeight: CGFloat = 75
var botNavRed: CGFloat = 1 //#000000
var botNavGreen: CGFloat = 1
var botNavBlue: CGFloat = 1


struct MainView: View {
    @State var isMenuOpen: Bool = false
    @State private var showPantryView = false
    @State private var showRecBook = false
    @State private var showNewRec = false
    @State private var showDiscover = false
    @State private var showReels = true
    @State private var showTester = false
    
    var leaveAction: () -> Void
    let rectangleWidth = screenSize.width // subtracting 40 for left and right margins

    var body: some View {
        
        ZStack {
            VStack{
                HStack{//Top border
                    Button{
                        isMenuOpen.toggle()
                    }label:{
                        Image(systemName: "line.3.horizontal")
                            .font(.system(size: 30))
                    }
                    Spacer()
                    Text(appName)
                        .font(.title)
                    Spacer()
                    Image(systemName: "paperplane.fill")
                        .padding(.horizontal, 10)

                }.frame(height: 50)
                    .border(Color(.red))
                    
                
                NavigationView{ // main body
                    if showPantryView == true{
                        PantryView()
                    }else if showRecBook == true{
                        RecipeBookView()
                    }else if showNewRec == true{
                        addRecipeView()
                    }else if showDiscover == true{
                        DiscoverView()
                    }else if showReels == true{
                        ReelsView()
                    }else if showTester == true{
                        tester()
                    }
                    
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
                    .border(Color(.green))
                    .animation(.default, value: false)
                
                HStack(spacing: 3){//Bottom Navigation
                    Rectangle()
                        .fill(Color(red: botNavRed, green: botNavGreen, blue: botNavBlue))
                        .frame(width: appNavBottomWidth, height: appNavBottomHeight)
                        .overlay(
                            Button{
                                toggleViews(what_to_toggle: "showReels",
                                            showPantryView: &showPantryView,
                                            showRecBook: &showRecBook,
                                            showNewRec: &showNewRec,
                                            showDiscover: &showDiscover,
                                            showReels: &showReels)
                            }label: {
                                Image(systemName: "globe.americas")
                                    .font(.system(size: 30))
                            }
                        )
                    Rectangle()
                        .fill(Color(red: botNavRed, green: botNavGreen, blue: botNavBlue))
                        .frame(width: appNavBottomWidth, height: appNavBottomHeight)
                        .overlay(
                            Button{
                                toggleViews(what_to_toggle: "showDiscover",
                                            showPantryView: &showPantryView,
                                            showRecBook: &showRecBook,
                                            showNewRec: &showNewRec,
                                            showDiscover: &showDiscover,
                                            showReels: &showReels)
                            }label: {
                                Image(systemName: "magnifyingglass")
                                    .font(.system(size: 30))
                            }
                        )
                    Rectangle()
                        .fill(Color(red: botNavRed, green: botNavGreen, blue: botNavBlue))
                        .frame(width: appNavBottomWidth, height: appNavBottomHeight)
                        .overlay(
                            Button{
                                toggleViews(what_to_toggle: "showNewRec",
                                            showPantryView: &showPantryView,
                                            showRecBook: &showRecBook,
                                            showNewRec: &showNewRec,
                                            showDiscover: &showDiscover,
                                            showReels: &showReels)
                            }label: {
                                Image(systemName: "plus.circle")
                                    .font(.system(size: 30))
                            }
                        )
                    Rectangle()
                        .fill(Color(red: botNavRed, green: botNavGreen, blue: botNavBlue))
                        .frame(width: appNavBottomWidth, height: appNavBottomHeight)
                        .overlay(
                            Button{
                                toggleViews(what_to_toggle: "showRecBook",
                                            showPantryView: &showPantryView,
                                            showRecBook: &showRecBook,
                                            showNewRec: &showNewRec,
                                            showDiscover: &showDiscover,
                                            showReels: &showReels)
                            }label: {
                                Image(systemName: "book")
                                    .font(.system(size: 30))
                            }
                        )
                    Rectangle()
                        .fill(Color(red: botNavRed, green: botNavGreen, blue: botNavBlue))
                        .frame(width: appNavBottomWidth, height: appNavBottomHeight)
                        .overlay(
                            Button{
                                toggleViews(what_to_toggle: "showPantryView",
                                            showPantryView: &showPantryView,
                                            showRecBook: &showRecBook,
                                            showNewRec: &showNewRec,
                                            showDiscover: &showDiscover,
                                            showReels: &showReels)
                            }label: {
                                Image(systemName: "refrigerator")
                                    .font(.system(size: 30))
                            }
                        )
                }
                .background(Color(red: 0.65, green: 0.65, blue: 0.65))
                .overlay(
                    // create a shape with a stroke only on the top edge
                    Rectangle()
                        .stroke(Color(red: 0.65, green: 0.65, blue: 0.65), lineWidth: 1.6)
                        .frame(height: 2)
                        .offset(y: -1) // offset the shape so that it overlays the top edge of the HStack
                    , alignment: .top
                )

                
            }.offset(x: isMenuOpen ? 250 : 0)
                .animation(.easeOut(duration: 0.5))
                .edgesIgnoringSafeArea(.bottom)
            SideMenuView(isMenuOpen: $isMenuOpen, nested_leaveAction: {self.leaveAction()}, testShow: {self.showTesterNow()})
                    .frame(width: UIScreen.main.bounds.width * 0.8)
                    .offset(x: isMenuOpen ? 0 : -UIScreen.main.bounds.width * 0.8)
                    .animation(.easeOut(duration: 0.5))
        }//ZStack closer

    }
    public func showTesterNow(){
        showPantryView = false
        showRecBook = false
        showNewRec = false
        showDiscover = false
        showReels = false
        showTester = true
    }

}

func toggleViews(what_to_toggle: String,showPantryView: inout Bool, showRecBook: inout Bool, showNewRec: inout Bool, showDiscover: inout Bool, showReels: inout Bool) {
    switch what_to_toggle {
        case "showPantryView":
            showPantryView = true
            showRecBook = false
            showNewRec = false
            showDiscover = false
            showReels = false
        case "showRecBook":
            showPantryView = false
            showRecBook = true
            showNewRec = false
            showDiscover = false
            showReels = false
        case "showNewRec":
            showPantryView = false
            showRecBook = false
            showNewRec = true
            showDiscover = false
            showReels = false
        case "showDiscover":
            showPantryView = false
            showRecBook = false
            showNewRec = false
            showDiscover = true
            showReels = false
        case "showReels":
            showPantryView = false
            showRecBook = false
            showNewRec = false
            showDiscover = false
            showReels = true
        default:
            print("Error inside toggleViews")
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(leaveAction: {})
    }
}


