//
//  ListManager.swift
//  DoItList
//
//  Created by João Victor Ipirajá de Alencar on 08/01/21.
//

import Foundation
import SwiftUI


class ListManager: ObservableObject{
    @Published var listDivision = [Division]()
    
    
    
    
    func addSection(name:String, color:Color){
        
       
            let tasks_aux = [Task]()
            let sec_aux = Division(id: UUID(), name: name, tasks: tasks_aux, color: color)
            listDivision.append(sec_aux)
        
        
    }
    
    func removeSection(at section:Division){
        if let index = listDivision.firstIndex(where: {$0.id == section.id}){
            listDivision.remove(at: index)
        }
    }
    
    func addTask(at sec_id: UUID, with name:String){
        
        
        if let index = listDivision.firstIndex(where: {$0.id == sec_id}){
           let color_aux = listDivision[index].color.opacity(0.5)
           let task_aux = Task(id: UUID(), name: name, color: color_aux)
            listDivision[index].tasks.append(task_aux)
        }
    }
    
    
    
}

/*
 (255, 255, 153)
 (255, 204, 153)
 
 */






