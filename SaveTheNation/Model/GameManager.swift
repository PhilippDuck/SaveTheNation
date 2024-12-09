import Foundation

class GameManager {
    
    // MARK: - Eigenschaften
    var turnCounter: Int = 0
    var treasury: Int = 100
    var populationGroups: [PopulationGroup] = []
    var deck: [Card] = []
    var discardPile: [Card] = []
    
    // MARK: - Initialisierung
    init() {
        setupGame()
    }
    
    // Spiel initialisieren
    func setupGame() {
        // Spielzustand initialisieren
        turnCounter = 0
        treasury = 100
        
        // Bevölkerungsgruppen und Karten initialisieren
        populationGroups = PopulationGroupDatabase.getInitialPopulationGroups()
        

        
        deck = CardDatabase.getInitialDeck()
        discardPile.removeAll() // Ablagestapel leeren
    }

    
    // MARK: - Zuglogik
    func startTurn() -> Card? {
        // Prüfen, ob das Spiel verloren wurde
        if checkGameOver() {
            print("Game Over!") // Debugging-Ausgabe
            return CardDatabase.getGameOverCard() // GameOver-Karte zurückgeben
        }
        
        // Normale Zuglogik
        if deck.isEmpty {
            shuffleDiscardPileIntoDeck()
        }
        return deck.isEmpty ? nil : deck.removeFirst()
    }
    
    func endTurn(accepted: Bool, card: Card) {
        // Effekte basierend auf der Entscheidung anwenden
        applyEffects(from: card, accepted: accepted)
        
        // Karte in den Ablagestapel verschieben
        discardPile.append(card)
        
        // Monatszähler erhöhen
        turnCounter += 1
        
        // Prüfen, ob das Spiel verloren wurde
        if checkGameOver() {
            print("Game Over!")
        }
        
        // Prüfen, ob eine neue Bevölkerungsgruppe hinzugefügt werden soll
        if let newGroup = PopulationGroupDatabase.getAdditionalPopulationGroup(for: turnCounter) {
            populationGroups.append(newGroup)
            print("New population group added: \(newGroup.name)")
        }
    }


    
    private func applyEffects(from card: Card, accepted: Bool) {
        let effects = accepted ? card.acceptEffects : card.rejectEffects
        for effect in effects {
            if let group = populationGroups.first(where: { $0.name == effect.group }) {
                group.adjustSatisfaction(by: effect.value)
                print("\(group.name) satisfaction is now \(group.satisfaction)")
            }
        }
    }

    
    func checkGameOver() -> Bool {
        if populationGroups.contains(where: { $0.satisfaction <= 0 }) || treasury <= 0 {
            return true
        }
        return false
    }
    
    private func shuffleDiscardPileIntoDeck() {
        deck = discardPile.shuffled()
        discardPile.removeAll()
    }
    
    func resetGame() {
        // Alle Eigenschaften auf Anfangswerte zurücksetzen
        turnCounter = 0
        treasury = 100
        populationGroups = PopulationGroupDatabase.getInitialPopulationGroups()
        deck = CardDatabase.getInitialDeck()
        discardPile.removeAll()
    }
}
