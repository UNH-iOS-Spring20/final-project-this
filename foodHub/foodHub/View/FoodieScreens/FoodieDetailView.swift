//
//  FoodieDetailView.swift
//  foodHub
//
//  Created by Ehiremen Ekore on 8/12/20.
//  Copyright © 2020 Ekore, Ehiremen Alex. All rights reserved.
//

import SwiftUI


struct FoodieDetailView: View {
    var foodie: FoodieUser
    @ObservedObject var menuItems = FirebaseCollection<MenuItem> (query: queryMenuItems)
//    var menuItems: [MenuItemDetail]
    
    var body: some View {
        VStack {
            List{
                ForEach(foodie.menu, id: \.self) { item in
                    NavigationLink(destination: MenuView(menuItem: getMenuItemName(menuItems: self.menuItems, item: item))
                    ){
                        Text(fetchItemName(menuItems: self.menuItems, item: item))
                    }
                } //.onDelete(perform: removeMenuItem)
                //.navigationBarItems(leading: EditButton())
                /*
                if FoodieLandingView.sessionFoodieUser?.id == foodie.id {
                    .onDelete
                }
                */
                Spacer()
            }
            NavigationLink(
                destination: StoreInfoView(foodie: self.foodie)
            ){
             Text("Store Info!")
                .font(.body)
            }
            .padding(10)
            .navigationBarTitle(foodie.name)
        }.padding()
    }
    
    /*
    func removeMenuItem (at offsets: IndexSet) {
        foodie.menu.deleteItem(index: offsets.first!)
    }
 */
}

struct FoodieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FoodieDetailView(foodie: FoodieUser(allFields: "Test", name: "Test", address: "nil", email: "nil", phone: "nil", isActive: true, zipCode: "00000", city: "nil", state: "nil", menu: ["N/A"])!)
    }
}

func fetchItemName (menuItems: FirebaseCollection<MenuItem>, item: String) -> (String) {
    for temp in menuItems.items {
        if temp.id == item {
            return (temp.name)
        }
    }
    return ""
}

func getMenuItemName (menuItems: FirebaseCollection<MenuItem>, item: String) -> (MenuItem) {
    for temp in menuItems.items {
        if temp.id == item {
            return (temp)
        }
    }
    return MenuItem()
}

/*
 func fetchItemName (item: String) -> String {
     let docRef = queryMenuItems.document(item)
     
     docRef.getDocument { (document, error) in
         if let document = document, document.exists {
             
             out = document.data()!["name"] as! String
             print("Document found: \(item), \(out)")
         }
     }
     return out
 }
 */
