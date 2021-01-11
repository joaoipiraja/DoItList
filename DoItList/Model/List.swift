//
//  List.swift
//  DoItList
//
//  Created by João Victor Ipirajá de Alencar on 08/01/21.
//

import SwiftUI



class Cor : Codable,ObservableObject {
    
    @Published private var red : CGFloat = 0.0
    @Published private var green: CGFloat = 0.0
    @Published private var blue: CGFloat = 0.0
    @Published private var alpha: CGFloat = 0.0

    var get_uiColor : UIColor {
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    var get_Color : Color {
        return Color(UIColor(red: red, green: green, blue: blue, alpha: alpha))
    }
    
    private enum CodingKeys : CodingKey {
        case red
        case green
        case blue
        case alpha
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(red, forKey: .red)
        try container.encode(green, forKey: .green)
        try container.encode(blue, forKey: .blue)
        try container.encode(alpha, forKey: .alpha)
    }
    
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.red = try container.decode(CGFloat.self, forKey: .red)
        self.green = try container.decode(CGFloat.self, forKey: .green)
        self.blue = try container.decode(CGFloat.self, forKey: .blue)
        self.alpha = try container.decode(CGFloat.self, forKey: .alpha)
    }
    
    init(color : Color) {
        let uiColor = UIColor(color)
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    }
    
    init(uiColor : UIColor) {
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    }
    
  

    
}


class Task: Identifiable, ObservableObject, Codable{
    @Published var id:UUID
    @Published var name:String
    
    init(id:UUID, name:String){
        self.id = id
        self.name = name
    }
    
    private enum CodingKeys : CodingKey {
        case id
        case name 
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
    }
    
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        
    }
}

class Division: Identifiable, ObservableObject, Codable{
    
    @Published var id: UUID
    @Published var name: String
    @Published var tasks: [Task]
    @Published var color:Cor
    @Published var isDeleted:Bool
    
    init(id:UUID, name:String,tasks: [Task], color:Cor ){
        self.id = id
        self.name = name
        self.tasks = tasks
        self.color = color
        self.isDeleted = false
    }
    
    private enum CodingKeys : CodingKey {
        case id
        case name
        case tasks
        case color
        case isDeleted
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(tasks, forKey: .tasks)
        try container.encode(color, forKey: .color)
        try container.encode(isDeleted, forKey: .isDeleted)
    }
    
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.tasks = try container.decode([Task].self, forKey: .tasks)
        self.isDeleted = try container.decode(Bool.self, forKey: .isDeleted)
        self.color = try container.decode(Cor.self, forKey: .color)

    }
    
    
    
    
    #if DEBUG
    static let example = Division(id: UUID(), name: "College", tasks: [Task(id: UUID(), name: "Study for Calculus Quiz")], color: Cor(uiColor: UIColor.red))
    #endif
}


