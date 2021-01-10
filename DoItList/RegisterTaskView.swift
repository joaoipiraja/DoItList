//
//  RegisterTaskView.swift
//  DoItList
//
//  Created by João Victor Ipirajá de Alencar on 09/01/21.
//

import SwiftUI

struct RegisterTaskView: View {
    @EnvironmentObject var listManager :ListManager
    @Binding var showModal:Bool
    @State private var taskName = ""
    var division:Division
    
   
    var body: some View {
        
        VStack(alignment: .trailing){
            
            Button(action:{
                showModal.toggle()
            }){
                Image(systemName: "xmark.circle.fill").resizable().frame(width: 25, height: 25).foregroundColor(division.color)
                
            }.padding()
           
            VStack{
                
                Form{
                    Section(header: Text("Task").font(.headline)){
                        TextField("Buy strawberries, study for calculus quiz", text: $taskName.animation())
                    }
                  
                   
                }
                
                if(!self.taskName.isEmpty){
                    Button(action:{
                        listManager.addTask(at: division, with: taskName)
                        showModal.toggle()
                    }){
                        HStack(alignment: .center){
                            Image(systemName: "folder.badge.plus")
                            Text("Save")
                        }.padding()
                    }.background(division.color).foregroundColor(.white).cornerRadius(8)
                }
               
            }
          
            
            
        }
    }
}

struct RegisterTaskView_Previews: PreviewProvider {
    static let listManager = ListManager()
    static var previews: some View {
        RegisterTaskView(showModal: .constant(false), division: Division.example).environmentObject(listManager)
    }
}
