//
//  ContentView.swift
//  facebookLogin_11
//
//  Created by emm on 14/01/2021.
//

import SwiftUI
import FBSDKLoginKit


struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct Home: View {
    
    // Setting App Storages => User Defaults...
    @AppStorage("logged") var logged = false
    @AppStorage("email") var email = ""
    @State var manager = LoginManager()
    
    var body: some View {
        VStack(spacing: 25) {
            
            //Custom Login Button...
            
            Button(action: {
                
                // if logged means logging out ...
                if logged {
                    manager.logOut()
                    email = ""
                    logged = false
                } else {
                    
                    // logging in user ...
                    
                    // you can give any permissions...
                    // im reading profile and email...
                    manager.logIn(permissions: ["public_profile", "email"], from: nil) {
                        (result, err) in
                        if err != nil{
                            print(err!.localizedDescription)
                            return
                        }
                        
                        // checking if user cancel the flow...
                        if !result!.isCancelled {
                            
                            // logged success...
                            logged = true
                            
                            // getting user details using FB Graph request...
                            
                            let request =  GraphRequest(graphPath: "me", parameters: ["fields": "email"])
                            request.start { (_, res, _) in
                                
                                // it will return as dictionary...
                                guard let profileData = res as? [String : Any] else {return}
                                
                                // Saving email...
                                email = profileData["email"] as! String
                            }
                        }
                        
                    }
                }
                
            }, label: {
                
                Text(logged ? "LogOut" : "Login with FB")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 35)
                    .background(Color.blue)
                    .clipShape(Capsule())
            })
            
            Text(email)
                .fontWeight(.bold)
            
        }
    }
}


// with native button => ...

struct FBlog : UIViewRepresentable {
    func makeUIView(context: Context) -> FBLoginButton {
                
        let button = FBLoginButton()
        button.delegate = context.coordinator
        return button
                    }
    
    func updateUIView(_ uiView: FBLoginButton, context: Context) {
        
        
    }
    class Coordinator : NSObject, LoginButtonDelegate {
        func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
            <#code#>
        }
        
        func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
            <#code#>
        }
        
        
    }
}
