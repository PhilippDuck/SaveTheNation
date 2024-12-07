import SpriteKit

class GameScene: SKScene {
    
    private var gameManager: GameManager!
    private var currentCardNode: CardNode?
    private let margin: CGFloat = 15 // Margin links und rechts
    private var isDraggingCard = false
    private var populationGrid: PopulationGrid?
    
    
    override func didMove(to view: SKView) {
        backgroundColor = backgroundColor
        
        // GameManager initialisieren
        gameManager = GameManager()
        

        // Platzhalter: Bevölkerungsgrid
        let initialGroups = Array(gameManager.populationGroups.prefix(2))
        let gridSize = CGSize(width: size.width, height: size.height * 0.1)
        populationGrid = PopulationGrid(size: gridSize, groups: initialGroups, margin: 15, gap: 10)
                if let populationGrid = populationGrid {
                    populationGrid.position = CGPoint(x: size.width / 2, y: size.height * 0.85)
                    addChild(populationGrid) // Füge das Grid zur Szene hinzu
                }



        // Platzhalter: Monatszähler
        let monthLabel = SKLabelNode(text: "Regierungszeit: 0")
        monthLabel.fontSize = 24
        monthLabel.fontName = "AvenirNext"
        monthLabel.fontColor = .white
        monthLabel.position = CGPoint(x: size.width / 2, y: size.height * 0.1)
        addChild(monthLabel)
        
        // Runde starten
        startTurn()
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
        let cardSize = CGSize(width: size.width - (2 * margin), height: 450) // Dynamische Breite
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
    
    private func showSwipeText(_ text: String, color: UIColor, position: CGPoint) {
        let labelTag = 999 // Tag, um den Text eindeutig zu identifizieren
        
        // Entferne vorherige Texte
        hideSwipeText()
        
        // Teile den Text in einzelne Wörter
        let words = text.split(separator: " ")
        
        // Erstelle einen Node, der alle Wörter enthält
        let parentNode = SKNode()
        parentNode.name = "\(labelTag)"
        parentNode.position = position
        parentNode.zPosition = -1 // Hinter der Karte
        
        // Füge für jedes Wort ein Label hinzu
        let lineHeight: CGFloat = 30 // Abstand zwischen den Zeilen
        for (index, word) in words.enumerated() {
            let wordLabel = SKLabelNode(text: String(word))
            wordLabel.fontName = "AvenirNext-Bold"
            wordLabel.fontSize = 24
            wordLabel.fontColor = color
            wordLabel.position = CGPoint(x: 0, y: -CGFloat(index) * lineHeight) // Vertikale Position
            wordLabel.horizontalAlignmentMode = .center
            wordLabel.verticalAlignmentMode = .center
            parentNode.addChild(wordLabel)
        }
        
        // Füge den Node zur Szene hinzu
        addChild(parentNode)
    }

    
    private func hideSwipeText() {
        let labelTag = 999
        childNode(withName: "\(labelTag)")?.removeFromParent()
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
        let rotationFactor: CGFloat = -0.002 // Winkel pro Pixel
        cardNode.zRotation += dx * rotationFactor
        
        // Färbung und Text basierend auf der Swipe-Distanz
        let centerX = size.width / 2
        let distanceFromCenter = abs(cardNode.position.x - centerX)
        let maxDistance = centerX // Maximale Distanz entspricht der halben Breite
        let intensity = min(distanceFromCenter / maxDistance, 0.6) // Begrenzung auf 1.0

        // Swipe-Richtung und Textbewegung
        if cardNode.position.x < centerX {
            // Links swipen: Akzeptieren (Grün)
            cardNode.color = .green // Setze die Farbe nur bei Bedarf
            cardNode.colorBlendFactor = intensity
            showSwipeText(cardNode.card.acceptText, color: .white, position: CGPoint(x: distanceFromCenter + 200, y: size.height / 2 + 150))
        } else {
            // Rechts swipen: Ablehnen (Rot)
            cardNode.color = .red // Setze die Farbe nur bei Bedarf
            cardNode.colorBlendFactor = intensity
            showSwipeText(cardNode.card.rejectText, color: .white, position: CGPoint(x: size.width - distanceFromCenter - 200, y: size.height / 2 + 150))
        }
    }





        
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let cardNode = currentCardNode, isDraggingCard else { return }
        isDraggingCard = false
        
        // Prüfen, ob die Karte weit genug nach rechts oder links gezogen wurde
        if cardNode.position.x > size.width * 0.75 {
            swipeCard(accepted: false) // Ablehnen
        } else if cardNode.position.x < size.width * 0.25 {
            swipeCard(accepted: true) // Akzeptieren
        } else {
            // Zurück zur Mitte bewegen
            resetCardPosition(cardNode)
        }
    }


        
    private func swipeCard(accepted: Bool) {
        guard let cardNode = currentCardNode else { return }
        
        let labelTag = 999
        guard let textNode = childNode(withName: "\(labelTag)") else { return }
        
        // Zielpositionen für Karte und Text
        let cardTargetX = accepted ? -cardNode.size.width : size.width + cardNode.size.width
        let textTargetX = accepted ? size.width * 1.5 : -size.width * 0.5 // Text fliegt in die entgegengesetzte Richtung
        
        // Karte herausfliegen lassen
        let cardMoveAction = SKAction.moveTo(x: cardTargetX, duration: 0.3)
        cardMoveAction.timingMode = .easeIn
        
        // Text in entgegengesetzte Richtung herausfliegen lassen
        let textMoveAction = SKAction.moveTo(x: textTargetX, duration: 0.3)
        textMoveAction.timingMode = .easeIn
        
        // Führe die Animationen aus
        cardNode.run(cardMoveAction) { [weak self] in
            guard let self = self else { return }
            
            // Karte entfernen
            cardNode.removeFromParent()
            self.currentCardNode = nil
            
            // Effekte anwenden und Populationen aktualisieren
            let effects = accepted ? cardNode.card.acceptEffects : cardNode.card.rejectEffects

            for effect in effects {
                if let index = self.gameManager.populationGroups.firstIndex(where: { $0.name == effect.group }) {
                    let group = self.gameManager.populationGroups[index]
                    let oldSatisfaction = group.satisfaction
                    
                    // Zufriedenheit aktualisieren
                    group.adjustSatisfaction(by: effect.value)
                    let updatedSatisfaction = group.satisfaction
                    
                    // Population im Grid aktualisieren
                    self.populationGrid?.updatePopulation(at: index, satisfaction: updatedSatisfaction)
                    
                    // Debugging-Ausgabe
                    print("""
                    Effekt angewendet:
                    Gruppe: \(group.name)
                    Effektwert: \(effect.value)
                    Alte Zufriedenheit: \(oldSatisfaction)
                    Neue Zufriedenheit: \(updatedSatisfaction)
                    """)
                } else {
                    // Debugging-Ausgabe, wenn die Gruppe nicht gefunden wird
                    print("Warnung: Gruppe '\(effect.group)' wurde nicht gefunden.")
                }
            }

            
            // Beende den Zug
            self.gameManager.endTurn(accepted: accepted, card: cardNode.card)
            self.startTurn()
        }
        
        // Text herausfliegen lassen
        textNode.run(textMoveAction) {
            textNode.removeFromParent()
        }
    }





        
        // Karte zurück zur Mitte bewegen
    private func resetCardPosition(_ cardNode: CardNode) {
        // Zurücksetzen der Farbblendung
        let resetColor = SKAction.customAction(withDuration: 0.2) { node, _ in
            if let spriteNode = node as? SKSpriteNode {
                spriteNode.colorBlendFactor = 0 // Entferne Farbüberlagerung
            }
        }

        // Zurück zur Mitte bewegen
        let resetPosition = CGPoint(x: size.width / 2, y: size.height / 2)
        let resetRotation = SKAction.rotate(toAngle: 0, duration: 0.2, shortestUnitArc: true)
        let resetMove = SKAction.move(to: resetPosition, duration: 0.2)
        let resetGroup = SKAction.group([resetRotation, resetMove, resetColor])
        cardNode.run(resetGroup)
        
        // Entferne den Swipe-Text
        hideSwipeText()
    }


}
