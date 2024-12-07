import Foundation

class PopulationGroupDatabase {
    static func getInitialPopulationGroups() -> [PopulationGroup] {
        return [
            PopulationGroup(name: "Workers", satisfaction: 50, imageName: "workersIcon"),
            PopulationGroup(name: "Scientists", satisfaction: 50, imageName: "scientistsIcon"),
            PopulationGroup(name: "Entrepreneurs", satisfaction: 50, imageName: "entrepreneursIcon"),
            PopulationGroup(name: "Environmentalists", satisfaction: 50, imageName: "environmentalistsIcon")
        ]
    }
    
    static func getAdditionalPopulationGroup(for turn: Int) -> PopulationGroup? {
        // Beispiel: Neue Bevölkerungsgruppe alle 12 Monate hinzufügen
        if turn % 12 == 0 {
            return PopulationGroup(name: "Religious", satisfaction: 50, imageName: "religiousIcon")
        }
        return nil
    }
}
