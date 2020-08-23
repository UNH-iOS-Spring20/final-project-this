//
//  FoodieLandingView.swift
//  foodHub
//
//  Created by Ekore, Ehiremen Alex on 3/1/20.
//  Copyright © 2020 Ekore, Ehiremen Alex. All rights reserved.
//

import SwiftUI
import FirebaseFirestore

struct FoodieLandingView: View {
    @EnvironmentObject var sessionUser: SessionUser
    
    var body: some View {
        
        VStack {
            if !sessionUser.isFoodie && !sessionUser.isEater {
                NavigationLink(
                    destination: CreateFoodieView()
                ){
                    Text("New foodie")
                        .font(.largeTitle)
                }
                .padding(10)
                
                NavigationLink(
                    destination: SelectFoodiesView()
                ){
                    Text("Login")
                        .font(.largeTitle)
                }
                .padding(10)
            }
            else {
                FoodieHomeView(fromHomeTab: true)
            }
        }
        
    }
    
    struct SelectFoodiesView: View {
        @EnvironmentObject var sessionUser: SessionUser
        @Environment(\.presentationMode) var presentationMode
        @ObservedObject private var foodies = FirebaseCollection<FoodieUser> (collectionRef: foodiesCollectionRef)
        
        @State private var showingConfirmLogin = false
        
        var body: some View {
            VStack{
                Text("Select your user: ")
                List {
                    ForEach(foodies.items) { foodie in
                        
                        Button(action: {
                            self.setSessionFoodie(foodie: foodie)
                        }){
                            HStack{
                                ImageViewController(imageUrl: foodie.data["photo"] as! String)
                                Text(foodie.data["name"] as! String)
                            }
                        }
                    }
                }
            }.alert(isPresented: $showingConfirmLogin){
                Alert(title: Text("Successful Login!"), message: Text("Session user set as \((sessionUser.sessionUser as! FoodieUser).name)"), dismissButton: .default(Text("OK ")))
            }
        }
        
        private func setSessionFoodie(foodie: FoodieUser) {
            sessionUser.setFoodie(foodie: foodie)
            self.showingConfirmLogin.toggle()
            dismiss()
        }
        
        func dismiss() {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

struct FoodieView_Previews: PreviewProvider {
    static var previews: some View {
        FoodieLandingView()
    }
}

