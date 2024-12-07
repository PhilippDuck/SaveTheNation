import SpriteKit

class PopulationGrid: SKNode {
    private var populationItems: [PopulationNode] = [] // Speichert PopulationItems
    
    init(size: CGSize, groups: [PopulationGroup], margin: CGFloat, gap: CGFloat) {
        super.init()
        
        let groupCount = groups.count
        let totalGap = gap * CGFloat(groupCount - 1) // Gesamtbreite der Gaps
        let availableWidth = size.width - (2 * margin) - totalGap // Verfügbare Breite
        let itemWidth = availableWidth / CGFloat(groupCount) // Breite jedes Objekts
        let itemSize = CGSize(width: itemWidth, height: size.height)
        
        for (i, group) in groups.enumerated() {
            let populationNode = PopulationNode(size: itemSize, imageName: group.imageName, initialSatisfaction: group.satisfaction)
            
            // Position der PopulationItem
            let xPosition = margin + (itemWidth / 2) + (CGFloat(i) * (itemWidth + gap)) - (size.width / 2)
            populationNode.position = CGPoint(x: xPosition, y: 0)
            
            addChild(populationNode)
            populationItems.append(populationNode)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Aktualisiere eine Population
    func updatePopulation(at index: Int, satisfaction: Int) {
        guard index >= 0 && index < populationItems.count else { return }
        populationItems[index].updateSatisfaction(to: satisfaction)
    }
}
