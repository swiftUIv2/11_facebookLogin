//
//  facebookLogin_11App.swift
//  facebookLogin_11
//
//  Created by emm on 14/01/2021.
//

import SwiftUI
import FBSDKCoreKit

@main
struct facebookLogin_11App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL(perform: { url in
                 
                    ApplicationDelegate.shared.application(UIApplication.shared, open: url, sourceApplication: nil, annotation: UIApplication.OpenURLOptionsKey.annotation)
                    
                })
        }
    }
}
