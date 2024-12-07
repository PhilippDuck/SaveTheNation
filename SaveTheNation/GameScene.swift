import SpriteKit

class GameScene: SKScene {
    
    private var gameManager: GameManager!
    private var currentCardNode: CardNode?
    private let margin: CGFloat = 15 // Margin links und rechts
    private var isDraggingCard = false
    
    override func didMove(to view: SKView) {
        backgroundColor = backgroundColor
        
        // GameManager initialisieren
        gameManager = GameManager()
        
        // Runde starten
        startTurn()
        

        // Platzhalter: Bevölkerungsgrid
        let gridSize = CGSize(width: size.width, height: size.height * 0.85)
        let populationGrid = PopulationGrid(size: gridSize, groupCount: 3, margin: margin, gap: 5)
        populationGrid.position = CGPoint(x: size.width / 2, y: size.height * 0.85) // Positionierung in der oberen Hälfte
        addChild(populationGrid)



        // Platzhalter: Monatszähler
        let monthLabel = SKLabelNode(text: "Regierungszeit: 0")
        monthLabel.fontSize = 24
        monthLabel.fontName = "AvenirNext"
        monthLabel.fontColor = .white
        monthLabel.position = CGPoint(x: size.width / 2, y: size.height * 0.1)
        addChild(monthLabel)
    }
    
    // Starte eine neue Runde
    func startTurn() {
        // Ziehe die nächste Karte
        guard let card = gameManager.startTurn() else {
            print("Keine Karten mehr verfügbar!")
            return
        }
        
        // Zeige die Karte an
        displayCard(card)
    }
    

    
    private func displayCard(_ card: Card) {
        // Entferne die aktuelle Karte, falls vorhanden
        currentCardNode?.removeFromParent()
        
        // Definiere die Größe und den Corner Radius
        let cardSize = CGSize(width: size.width - (2 * margin), height: 500) // Dynamische Breite
        let cornerRadius: CGFloat = 20 // Fester Corner Radius
        
        // Erstelle eine neue Karte
        let newCardNode = CardNode(card: card, size: cardSize, cornerRadius: cornerRadius)
        
        // Starte die Karte außerhalb des Bildschirms (unterhalb)
        newCardNode.position = CGPoint(x: size.width / 2, y: -cardSize.height)
        addChild(newCardNode)
        currentCardNode = newCardNode
        
        // Zielposition (Mitte des Bildschirms)
        let targetPosition = CGPoint(x: size.width / 2, y: size.height / 2)
        
        // Erstelle die Animation
        let moveAction = SKAction.move(to: targetPosition, duration: 0.5)
        moveAction.timingMode = .easeInEaseOut // Sanfter Bewegungsablauf
        
        // Führe die Animation aus
        newCardNode.run(moveAction)
    }

        
        // Berührung starten
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            guard let touch = touches.first, let cardNode = currentCardNode else { return }
            let location = touch.location(in: self)
            
            // Prüfen, ob die Berührung auf der Karte liegt
            if cardNode.contains(location) {
                isDraggingCard = true
            }
        }
        
        // Karte bewegen
        override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            guard let touch = touches.first, let cardNode = currentCardNode, isDraggingCard else { return }
            let location = touch.location(in: self)
            let previousLocation = touch.previousLocation(in: self)
            
            // Bewegung und Rotation berechnen
            let dx = location.x - previousLocation.x
            let dy = location.y - previousLocation.y
            
            // Aktualisiere die Position
            cardNode.position.x += dx * 1.2 // Überproportionale Bewegung in x-Richtung
            cardNode.position.y += dy * 0.8 // Leichte Bewegung in y-Richtung
            
            // Drehung proportional zur x-Bewegung
            let rotationFactor: CGFloat = 0.002 // Winkel pro Pixel
            cardNode.zRotation += dx * rotationFactor
        }
        
        // Berührung loslassen
        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            guard let touch = touches.first, let cardNode = currentCardNode, isDraggingCard else { return }
            isDraggingCard = false
            
            // Prüfen, ob die Karte weit genug nach rechts oder links gezogen wurde
            if cardNode.position.x > size.width * 0.75 {
                swipeCard(accepted: true)
            } else if cardNode.position.x < size.width * 0.25 {
                swipeCard(accepted: false)
            } else {
                // Zurück zur Mitte bewegen
                resetCardPosition(cardNode)
            }
        }
        
        // Karte swipen (Akzeptieren/Ablehnen)
        private func swipeCard(accepted: Bool) {
            guard let cardNode = currentCardNode else { return }
            
            // Zielposition (rechts oder links außerhalb des Bildschirms)
            let targetX = accepted ? size.width + cardNode.size.width : -cardNode.size.width
            let moveAction = SKAction.moveTo(x: targetX, duration: 0.3)
            moveAction.timingMode = .easeIn
            
            // Entferne die Karte mit einer Animation
            cardNode.run(moveAction) { [weak self] in
                cardNode.removeFromParent()
                self?.currentCardNode = nil
                self?.gameManager.endTurn(accepted: accepted, card: cardNode.card) // Übergabe an GameManager
                self?.startTurn()
            }
        }
        
        // Karte zurück zur Mitte bewegen
        private func resetCardPosition(_ cardNode: CardNode) {
            let resetPosition = CGPoint(x: size.width / 2, y: size.height / 2)
            let resetRotation = SKAction.rotate(toAngle: 0, duration: 0.2, shortestUnitArc: true)
            let resetMove = SKAction.move(to: resetPosition, duration: 0.2)
            let resetGroup = SKAction.group([resetRotation, resetMove])
            cardNode.run(resetGroup)
        }
    
    
    


}
