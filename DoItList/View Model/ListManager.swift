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
    private let defaults = UserDefaults.standard
    
    init(){
        getBackDatabase()
    }
    
    private func isKeyPresentInUserDefaults(key: String) -> Bool {
        return defaults.object(forKey: key) != nil
    }
    
    
    private func saveInDatabase(){
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData: Data = try jsonEncoder.encode(listDivision)
            if let jsonString =  String(data: jsonData, encoding: String.Encoding.utf8) {
                self.defaults.set(jsonString, forKey: "listDivision")
                print(jsonString)
            }
        } catch let error as NSError {
            print("Array convertIntoJSON - \(error.description)")
        }
    }
    
    private func getBackDatabase(){
        let decoder = JSONDecoder()
        
        do{
            
            if(!isKeyPresentInUserDefaults(key: "listDivision")){
                saveInDatabase()
            }
            
            let data = defaults.string(forKey: "listDivision") as! String
            let dataDecodedUTF8 = data.data(using: .utf8)!
            self.listDivision = try decoder.decode(Array<Division>.self, from: dataDecodedUTF8)
            
        }catch{
            print(error)
        }
        
    }
    
    func addSection(name:String, color:Cor){
        let tasks_aux = [Task]()
        let sec_aux = Division(id: UUID(), name: name, tasks: tasks_aux, color: color)
        listDivision.append(sec_aux)
        saveInDatabase()
    }
    
    
    func addTask(at division:Division, with name:String){
        
        print(division.name)
        if let index = listDivision.firstIndex(where: {$0.id == division.id}){
            let task_aux = Task(id: UUID(), name: name)
            print(index,task_aux)
            listDivision[index].tasks.append(task_aux)
            saveInDatabase()
        }
        
    }
    
    func removeDivision(at offsets: IndexSet){
        
        if let index = offsets.first{
            listDivision[index].isDeleted = true
            listDivision.remove(at: index)
            saveInDatabase()
        }
    }
    
    func removeTask(at offsets: IndexSet, division:Division){
        
        if let index_task = offsets.first{
            
            if let index_division = listDivision.firstIndex(where: {$0.id == division.id}){
                listDivision[index_division].tasks.remove(at: index_task)
                saveInDatabase()
            }
            
        }
    }
    
}







