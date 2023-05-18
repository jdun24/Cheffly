//
//  ingredientHandler.swift
//  chefflyApp
//
//  Created by Lil Uzi on 5/12/23.
//

import Foundation

struct SFMenu: Identifiable {
    var id = UUID()
    var name: String
    var sfSymbol: String
    var subMenuItems: [SFMenu]?
    
    // List
    static let iPhone = SFMenu(name: "iPhone", sfSymbol: "iphone")
    static let keyboard = SFMenu(name: "Keyboard", sfSymbol: "keyboard")
    static let mouse = SFMenu(name: "Magicmouse", sfSymbol: "magicmouse")
    
    static let person = SFMenu(name: "Person", sfSymbol: "person")
    static let faceSmiling = SFMenu(name: "Smiling", sfSymbol: "face.smiling")
    
    static let cross = SFMenu(name: "Cross", sfSymbol: "cross")
    static let faceMask = SFMenu(name: "Face Mask", sfSymbol: "facemask.fill")
    
    // Groups
    static let Refridgerator = SFMenu(name: "Refridgerator", sfSymbol: "refrigerator", subMenuItems: [
        .iPhone, .keyboard, .mouse
    ])
    static let Aromatics = SFMenu(name: "Aromatics", sfSymbol: "takeoutbag.and.cup.and.straw", subMenuItems: [
        .person, .faceSmiling
    ])
    static let Cupboard = SFMenu(name: "Cupboard", sfSymbol: "light.panel", subMenuItems: [
        .cross, .faceMask
    ])
    
}
