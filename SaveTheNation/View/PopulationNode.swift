import SpriteKit

class PopulationNode: SKNode {
    private let iconNode: SKSpriteNode
    private let satisfactionBar: SKShapeNode
    private let maxBarWidth: CGFloat
    
    init(size: CGSize, imageName: String, initialSatisfaction: Int) {
        self.maxBarWidth = size.width * 0.7
        
        // Icon erstellen
        iconNode = SKSpriteNode(imageNamed: imageName)
        iconNode.size = CGSize(width: size.width * 0.4, height: size.width * 0.4)
        iconNode.position = CGPoint(x: 0, y: size.height * 0.15)
        
        // Ladebalken erstellen
        let barHeight: CGFloat = 20
        let initialBarWidth = maxBarWidth * CGFloat(initialSatisfaction) / 100.0
        satisfactionBar = SKShapeNode(rectOf: CGSize(width: initialBarWidth, height: barHeight), cornerRadius: barHeight / 2)
        satisfactionBar.fillColor = PopulationNode.getColor(for: initialSatisfaction)
        satisfactionBar.strokeColor = .clear
        satisfactionBar.position = CGPoint(x: 0, y: -iconNode.size.height * 0.5)
        
        super.init()
        
        // Füge die Elemente hinzu
        addChild(iconNode)
        addChild(satisfactionBar)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Zufriedenheit mit Animation aktualisieren
    func updateSatisfaction(to newSatisfaction: Int) {
        let newWidth = maxBarWidth * CGFloat(newSatisfaction) / 100.0
        let barHeight = satisfactionBar.frame.height
        
        // Animation für die Breite des Ladebalkens
        let animationDuration = 0.3
        let scaleAction = SKAction.customAction(withDuration: animationDuration) { [weak self] node, elapsedTime in
            guard let self = self else { return }
            
            let currentWidth = self.satisfactionBar.frame.width
            let deltaWidth = newWidth - currentWidth
            let progress = CGFloat(elapsedTime / CGFloat(animationDuration))
            let interpolatedWidth = currentWidth + deltaWidth * progress
            
            self.satisfactionBar.path = CGPath(roundedRect: CGRect(x: -interpolatedWidth / 2, y: -barHeight / 2, width: interpolatedWidth, height: barHeight),
                                               cornerWidth: barHeight / 2, cornerHeight: barHeight / 2, transform: nil)
        }
        
        // Aktualisiere die Farbe nach der Animation
        let colorUpdate = SKAction.run { [weak self] in
            self?.satisfactionBar.fillColor = PopulationNode.getColor(for: newSatisfaction)
        }
        
        // Animation kombinieren
        let animationSequence = SKAction.sequence([scaleAction, colorUpdate])
        satisfactionBar.run(animationSequence)
    }
    
    // Farbe basierend auf Zufriedenheit
    private static func getColor(for satisfaction: Int) -> UIColor {
        switch satisfaction {
        case 0..<20: return .red
        case 20..<50: return .yellow
        default: return .green
        }
    }
}
