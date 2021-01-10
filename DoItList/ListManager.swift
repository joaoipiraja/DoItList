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

   
    func addTask(at division:Division, with name:String){
        
        print(division.name)
        if let index = listDivision.firstIndex(where: {
            
           $0.id == division.id
        }){
            let task_aux = Task(id: UUID(), name: name)
            print(index,task_aux)
            listDivision[index].tasks.append(task_aux)
            
        }
        
        
        
    }
    
    func removeDivision(at offsets: IndexSet){
    
        if let index = offsets.first{
            listDivision[index].isDeleted = true
            listDivision.remove(at: index)
        }
        
        
    }
    
    func removeTask(at offsets: IndexSet, division:Division){
    
        if let index_task = offsets.first{
            
            if let index_division = listDivision.firstIndex(where: {$0.id == division.id}){
                listDivision[index_division].tasks.remove(at: index_task)
            }
            
        }
    }
    
    
    
    

    
 
    
    
}

/*
 (255, 255, 153)
 (255, 204, 153)
 
 */






