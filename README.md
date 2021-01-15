[<img src="/DoItList/Assets.xcassets/AppIcon.appiconset/120.png"/>](120.png)
# DoItList
DoItList IOS APP using SwiftUI



### Screenshots 📸
[<img src="/screenshots/screenshot1.jpg" width="500" />](screenshot1.jpg)
[<img src="/screenshots/screenshot3.jpg" width="500" />](screenshot3.jpg)
[<img src="/screenshots/screenshot2.jpg" width="500" />](screenshot2.jpg)
[<img src="/screenshots/screenshot4.jpg" width="500" />](screenshot4.jpg)


### Learn 📝

### Implement App Life Cycle and Tap Gesture Delegate

```Swift

import SwiftUI

@main
struct DoItListApp: App {
    
    @Environment(\.scenePhase) var scenePhase

    var body: some Scene {

        WindowGroup {
            ContentView().onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
        }
        .onChange(of: scenePhase){(newScenePhase) in
            switch newScenePhase{
            case .background:
                print("App in background")
            case .inactive:
                print("App is inactive")
            case .active:
                print("App is Active")
    
            @unknown default:
                print("App is in unknown state.")
            }
        }
    }
}

extension UIApplication {
    func addTapGestureRecognizer() {
        guard let window = windows.first else { return }
        let tapGesture = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
        tapGesture.requiresExclusiveTouchType = false
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self
        window.addGestureRecognizer(tapGesture)
    }
}

extension UIApplication: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool      {
        return true // set to `false` if you don't want to detect tap during other gestures
    }
}

```

### Data Structuring:

#### @EnvironmentObject and ContentView().environmentObject(listManager)

Turn the "View Model" (```ListManager()```) accessible for all "Views"


```Swift
@main
struct DoItListApp: App {

    var listManager = ListManager()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(listManager)
        }
        }
    }
}
```


#### @Binding and @State

@Binding receive a @State which is exclusive from View. They call each other!

#### Data Model

```Swift

//Creates a color class in order to encode/decode it

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

```
#### View Model

```Swift

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




```


