//
//  List.swift
//  DoItList
//
//  Created by João Victor Ipirajá de Alencar on 08/01/21.
//

import SwiftUI

struct Task: Identifiable{
    var id:UUID
    var name:String    
}

struct Division: Identifiable{
    
    
    var id: UUID
    var name: String
    var tasks: [Task]
    var color:Color
    
    #if DEBUG
    static let example = Division(id: UUID(), name: "College", tasks: [Task(id: UUID(), name: "Study for Calculus Quiz")], color: Color(#colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)))
    #endif
}


