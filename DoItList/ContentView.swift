//
//  ContentView.swift
//  DoItList
//
//  Created by João Victor Ipirajá de Alencar on 08/01/21.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var listManager :ListManager
    @State var isPresented:Bool = false
    
    var body: some View {
        NavigationView{
            List{
                ForEach(listManager.listDivision){ d in
                    
                   
                    HStack{
                        
                        Image(systemName: "checkmark").resizable().frame(width: 20, height: 20).foregroundColor(d.color)
                        Text(d.name).font(.title2)
                            /*Button("Clique"){
                                isPresented.toggle()
                                
                            }.buttonStyle(PlainButtonStyle())*/
                            
                            
                            
                    }
                    
                }
                .onDelete(perform: deleteItem)
            }
            .navigationTitle("DoItList")
            .navigationBarItems(trailing:
                                    Button(action:{
                                        
                                        isPresented.toggle()
                                        
                                    }){
                                        Image(systemName: "plus.circle").resizable().frame(width: 25, height: 25).foregroundColor(Color(#colorLiteral(red: 0.07910548896, green: 0.5533952117, blue: 0.3261781335, alpha: 1)))
                                        
                                    }.sheet(isPresented: $isPresented){
                                        RegisterView(showModal: self.$isPresented)
                                    }
            )
           
        }
        
    }
    
    func deleteItem(at offsets: IndexSet){
        self.listManager.listDivision.remove(at: offsets.first!)
    }
}

struct ContentView_Previews: PreviewProvider {
    static let listManager = ListManager()
    
    static var previews: some View {
        ContentView().environmentObject(listManager)
    }
}
