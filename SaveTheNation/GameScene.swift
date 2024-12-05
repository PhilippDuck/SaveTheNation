import SpriteKit

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        backgroundColor = backgroundColor
        let margin: CGFloat = 15 // Margin links und rechts

        // Platzhalter: Bevölkerungsgrid
        let gridSize = CGSize(width: size.width, height: size.height * 0.85)
        let populationGrid = PopulationGrid(size: gridSize, groupCount: 3, margin: margin, gap: 5)
        populationGrid.position = CGPoint(x: size.width / 2, y: size.height * 0.85) // Positionierung in der oberen Hälfte
        addChild(populationGrid)

        // Patzhalterkarte
        let cardSize = CGSize(width: size.width - (2 * margin), height: 500)
        let card = CardNode(size: cardSize, title: "Example Card", description: "This is a placeholder card description.")
        card.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(card)

        // Platzhalter: Monatszähler
        let monthLabel = SKLabelNode(text: "Regierungszeit: 0")
        monthLabel.fontSize = 24
        monthLabel.fontName = "AvenirNext"
        monthLabel.fontColor = .white
        monthLabel.position = CGPoint(x: size.width / 2, y: size.height * 0.1)
        addChild(monthLabel)
    }

}
