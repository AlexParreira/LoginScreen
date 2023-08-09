//
//  ContentView.swift
//  LoginScreen
//
//  Created by Alexander Parreira on 09/08/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = ViewModel()
    
    var body: some View {
        if vm.authenticated{
            VStack{
                Text("Welcome back **\(vm.username.lowercased())**!")
                Text("Today is: ***\(Date().formatted(.dateTime))*")
                Button("Log out", action: vm.logOut)
                    .tint(.red)
                    .buttonStyle(.bordered)
            }
        } else {
            ZStack{
                Image("StarsAndMoon")
                    .resizable()
                    .cornerRadius(20)
                    .ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 20){
                    Spacer()
                    Text("Log in")
                        .foregroundColor(.white)
                        .font(.system(size: 50, weight: .medium, design: .rounded))
                        
                    TextField("Username", text: $vm.username)
                        .textFieldStyle(.roundedBorder)
                        .textInputAutocapitalization(.never)
                    SecureField("Password", text: $vm.password)
                        .textFieldStyle(.roundedBorder)
                        .textInputAutocapitalization(.never)
                        .privacySensitive()
                    HStack{
                        Spacer()
                        Button("Forgot password?", action: vm.logPressed )
                            .tint(.black.opacity(0.8))
                        Spacer()
                        Button("Log in", action: vm.authenticate)
                            .buttonStyle(.bordered)
                            .tint(.white)
                        Spacer()
                    }
                    Spacer()
                }
                .alert("Access denied", isPresented: $vm.invalid){
                    Button("Dismiss", action: vm.logPressed)
                }
                .frame(width: 300)
                .padding()
            }
            .transition(.offset(x:0, y:850))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
