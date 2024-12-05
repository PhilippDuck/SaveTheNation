import SpriteKit

class PopulationGrid: SKNode {
    
    private var groupNodes: [SKShapeNode] = [] // Speichert die Populationen
    
    init(size: CGSize, groupCount: Int, margin: CGFloat, gap: CGFloat) {
        super.init()
        
        // Dynamische Berechnung der Breite und Positionen
        let totalGap = gap * CGFloat(groupCount - 1) // Gesamtbreite der Gaps
        let availableWidth = size.width - (2 * margin) - totalGap // Verfügbare Breite für Kästchen
        let itemWidth = availableWidth / CGFloat(groupCount) // Dynamische Breite jedes Objekts
        let itemSize = CGSize(width: itemWidth, height: 60) // Größe jedes Platzhalters

        for i in 0..<groupCount {
            // Erstelle SKShapeNode mit abgerundeten Ecken
            let groupNode = SKShapeNode(rectOf: itemSize, cornerRadius: 15)
            groupNode.fillColor = .darkGray
            groupNode.strokeColor = .clear

            // Position der Objekte im Grid
            let xPosition = margin + (itemWidth / 2) + (CGFloat(i) * (itemWidth + gap)) - (size.width / 2)
            groupNode.position = CGPoint(x: xPosition, y: 0)
            
            addChild(groupNode)
            groupNodes.append(groupNode)
        }
    }

    // Methode zum Aktualisieren der Farbe einer Population
    func updateGroupColor(index: Int, color: UIColor) {
        guard index >= 0 && index < groupNodes.count else { return }
        groupNodes[index].fillColor = color
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
