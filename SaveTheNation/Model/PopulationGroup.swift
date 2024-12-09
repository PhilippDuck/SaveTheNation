import Foundation

class PopulationGroup {
    
    // MARK: - Eigenschaften
    let name: String              // Name der Bevölkerungsgruppe
    var satisfaction: Int         // Zufriedenheit der Gruppe (z. B. 0 bis 100)
    let imageName: String         // Name des Icons/Bildes für die Darstellung
    
    // MARK: - Initialisierung
    init(name: String, satisfaction: Int = 50, imageName: String) {
        self.name = name
        self.satisfaction = satisfaction
        self.imageName = imageName
    }
    
    // MARK: - Methoden
    
    // Methode zum Anpassen der Zufriedenheit
    func adjustSatisfaction(by value: Int) {
        satisfaction += value
        satisfaction = max(0, min(100, satisfaction)) // Begrenze Zufriedenheit auf [0, 100]
    }
    
    // Methode, um zu prüfen, ob die Gruppe unzufrieden ist
    func isUnhappy() -> Bool {
        return satisfaction <= 0
    }
    
    // Beschreibung für Debugging oder Logging
    func description() -> String {
        return "\(name): \(satisfaction) (Image: \(imageName))"
    }
}
