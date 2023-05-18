//
//  loginHandler.swift
//  chefflyApp
//
//  Created by Lil Uzi on 5/14/23.
//

import Foundation
import Security


func saveUserCredentials(username: String, password: String) {
    let passwordData = password.data(using: String.Encoding.utf8)!
    
    let query: [NSString: AnyObject] = [
        kSecClass: kSecClassInternetPassword,
        kSecAttrServer: "cheffly" as AnyObject,
        kSecAttrAccount: username as AnyObject,
        kSecValueData: passwordData as AnyObject
    ]
    
    let status = SecItemAdd(query as CFDictionary, nil)
    guard status == errSecSuccess else {
        print("Error saving user credentials: \(status)")
        return
    }
}

func retrieveUserCredentials(username: String) -> String? {
    let query: [NSString: AnyObject] = [
        kSecClass: kSecClassInternetPassword,
        kSecAttrServer: "cheffly" as AnyObject,
        kSecAttrAccount: username as AnyObject,
        kSecMatchLimit: kSecMatchLimitOne,
        kSecReturnAttributes: true as AnyObject,
        kSecReturnData: true as AnyObject
    ]
    
    var item: CFTypeRef?
    let status = SecItemCopyMatching(query as CFDictionary, &item)
    guard status == errSecSuccess, let existingItem = item as? [NSString: AnyObject],
        let passwordData = existingItem[kSecValueData] as? Data,
        let password = String(data: passwordData, encoding: String.Encoding.utf8)
        else {
            print("Error retrieving user credentials: \(status)")
            return nil
    }
    
    return password
}


func deleteStoredCredentials(forUsername username: String) throws {
    let query: [NSString: AnyObject] = [
        kSecClass: kSecClassInternetPassword,
        kSecAttrServer: "cheffly" as AnyObject,
        kSecAttrAccount: username as AnyObject
    ]
    
    let status = SecItemDelete(query as CFDictionary)
    
    if status != errSecSuccess && status != errSecItemNotFound {
        print("Account not found! -- deleteStoredCredentials inFile loginHandler")
    }
}

