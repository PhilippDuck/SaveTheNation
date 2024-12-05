import SpriteKit

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        backgroundColor = .black

        // Platzhalter: Grid für Bevölkerungsgruppen
        let populationGrid = SKNode()
        populationGrid.position = CGPoint(x: size.width / 2, y: size.height * 0.85) // Positionierung in der oberen Hälfte
        addChild(populationGrid)

        // Dynamische Berechnung der Breite und Positionen
        let groupCount = 6 // Anzahl der Gruppen
        let margin: CGFloat = 15 // Margin links und rechts
        let gap: CGFloat = 5 // Abstand zwischen den Objekten

        // Berechnung der Breite jedes Kästchens
        let totalGap = gap * CGFloat(groupCount - 1) // Gesamtbreite der Gaps
        let availableWidth = size.width - (2 * margin) - totalGap // Verfügbare Breite für Kästchen
        let itemWidth = availableWidth / CGFloat(groupCount) // Dynamische Breite jedes Objekts
        let itemSize = CGSize(width: itemWidth, height: 80) // Quadratische Kästchen

        // Platzhalter-Icons für Bevölkerungsgruppen hinzufügen
        for i in 0..<groupCount {
            let groupPlaceholder = SKSpriteNode(color: .darkGray, size: itemSize)

            // Position der Objekte im Grid
            let xPosition = margin + (itemWidth / 2) + (CGFloat(i) * (itemWidth + gap)) - (size.width / 2)
            groupPlaceholder.position = CGPoint(x: xPosition, y: 0)

            populationGrid.addChild(groupPlaceholder)
        }

        // Platzhalter: Aktuelle Karte
        let cardPlaceholder = SKSpriteNode(color: .darkGray, size: CGSize(width: size.width - (2 * margin), height: 500))
        cardPlaceholder.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(cardPlaceholder)

        // Platzhalter: Monatszähler
        let monthLabel = SKLabelNode(text: "Regierungszeit: 0")
        monthLabel.fontSize = 24
        monthLabel.fontColor = .white
        monthLabel.position = CGPoint(x: size.width / 2, y: size.height * 0.1)
        addChild(monthLabel)
    }

}
