//
//  RegisterView.swift
//  DoItList
//
//  Created by João Victor Ipirajá de Alencar on 09/01/21.
//

import SwiftUI

struct RegisterDivisionView: View {
    @EnvironmentObject var listManager :ListManager
    @Binding private var showModal:Bool
    @State private var selectedColor = Color.red
    @State private var divisionName = ""
    
    
    
    #if DEBUG
    init(){
        self._showModal = .constant(true)
    }
    #endif
    
    
    init(showModal:Binding<Bool>){
        self._showModal = showModal
    }
    
    
    
    var body: some View {
        
        VStack(alignment: .trailing){
            
            Button(action:{
                showModal.toggle()
            }){
                Image(systemName: "xmark.circle.fill").resizable().frame(width: 25, height: 25).foregroundColor(Color(#colorLiteral(red: 0.07910548896, green: 0.5533952117, blue: 0.3261781335, alpha: 1)))
                
            }.padding()
           
            VStack{
                
                Form{
                    Section(header: Text("Name").font(.headline)){
                        TextField("College Exams, Shopping List", text: $divisionName.animation())
                    }
                    Section(header: Text("Select a color").font(.headline)){
                         
                       ColorPicker("",selection: $selectedColor).padding()
                        
                    }
                    
                   
                }
                
                if(!self.divisionName.isEmpty){
                    Button(action:{
                        listManager.addSection(name: self.divisionName, color: self.selectedColor)
                        showModal.toggle()
                    }){
                        HStack(alignment: .center){
                            Image(systemName: "folder.badge.plus")
                            Text("Save")
                        }.padding()
                    }.background(Color(#colorLiteral(red: 0.07910548896, green: 0.5533952117, blue: 0.3261781335, alpha: 1))).foregroundColor(.white).cornerRadius(8)
                }
               
            }
          
            
            
        }
       
    }
}

struct RegisterView_Previews: PreviewProvider {
    static let listManager = ListManager()
    static var previews: some View {
        RegisterDivisionView().environmentObject(listManager)
    }
}
