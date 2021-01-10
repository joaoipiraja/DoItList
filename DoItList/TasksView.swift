//
//  TasksView.swift
//  DoItList
//
//  Created by João Victor Ipirajá de Alencar on 09/01/21.
//

import SwiftUI


struct TasksView: View {
    @EnvironmentObject var listManager :ListManager
    @ObservedObject var division:Division
    @State var isPresented:Bool = false


    var body: some View {
            
        if(!division.isDeleted){
            
            
            VStack{
                ZStack(alignment: .center){
                    Color(UIColor(division.color)).cornerRadius(10.0)
                    Text(division.name).font(.title).fontWeight(.bold).foregroundColor(.white)
                }.padding()
                Spacer()
                List{
                    ForEach(division.tasks){ t in
                        HStack{
                            Image(systemName: "checkmark").resizable().frame(width: 20, height: 20).foregroundColor(division.color)
                            
                            Text(t.name).font(.title3).foregroundColor(division.color)
                        }.padding()
                        
                    }
                    
                    .onDelete{ row in
                        self.listManager.removeTask(at: row, division: division)
                    }
                }
            }
            .navigationBarHidden(false)
            .navigationBarItems(trailing:
                                
                                    Button(action:{
                                        
                                        isPresented.toggle()
                                        
                                    }){
                                        Image(systemName: "plus.circle").resizable().frame(width: 25, height: 25).foregroundColor(division.color)
                                        
                                    })
                                    .sheet(isPresented: $isPresented){
                                        RegisterTaskView(showModal: $isPresented, division: division)
                                    }
            
        
        
        }else{
            HStack{
                
                Text("Select Something...").font(.title)
                
            }.foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
            .navigationBarTitle("")
                .navigationBarHidden(true)
        }
     
    }
}

struct TasksView_Previews: PreviewProvider {
    static let listManager = ListManager()
    static var previews: some View {
        TasksView(division: Division.example).environmentObject(listManager)
    }
}
