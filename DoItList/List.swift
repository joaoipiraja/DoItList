//
//  List.swift
//  DoItList
//
//  Created by João Victor Ipirajá de Alencar on 08/01/21.
//

import SwiftUI

class Task: Identifiable, ObservableObject{
    @Published var id:UUID
    @Published var name:String
    
    init(id:UUID, name:String){
        self.id = id
        self.name = name
    }
}

class Division: Identifiable, ObservableObject{
    
    @Published var id: UUID
    @Published var name: String
    @Published var tasks: [Task]
    @Published var color:Color
    @Published var isDeleted:Bool
    
    init(id:UUID, name:String,tasks: [Task], color:Color ){
        self.id = id
        self.name = name
        self.tasks = tasks
        self.color = color
        self.isDeleted = false
    }
    
    #if DEBUG
    static let example = Division(id: UUID(), name: "College", tasks: [Task(id: UUID(), name: "Study for Calculus Quiz")], color: Color(#colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)))
    #endif
}


