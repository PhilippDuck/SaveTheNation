import SpriteKit

class CardNode: SKNode {

    // Eigenschaften der Karte
    var backgroundNode: SKShapeNode!
    var titleLabel: SKLabelNode!
    var descriptionLabel: SKLabelNode!
    let margin: CGFloat = 10.0

    init(size: CGSize, title: String, description: String) {
        super.init()

        let cardFont = "AvenirNext"

        
        // Hintergrund mit abgerundeten Ecken
        backgroundNode = SKShapeNode(rectOf: size, cornerRadius: 20)
        backgroundNode.fillColor = .darkGray
        backgroundNode.strokeColor = .clear
        addChild(backgroundNode)
        
        // Titel hinzufügen
        titleLabel = SKLabelNode(text: title)
        titleLabel.fontSize = 24
        titleLabel.fontColor = .white
        titleLabel.fontName = cardFont
        titleLabel.position = CGPoint(x: 0, y: size.height / 2 - 50)
        titleLabel.horizontalAlignmentMode = .center
        backgroundNode.addChild(titleLabel)
        
        // Beschreibung hinzufügen
        descriptionLabel = SKLabelNode(text: description)
        descriptionLabel.fontSize = 20
        descriptionLabel.fontName = cardFont
        descriptionLabel.fontColor = .lightGray
        descriptionLabel.position = CGPoint(x: 0, y: 0)
        descriptionLabel.horizontalAlignmentMode = .center
        descriptionLabel.numberOfLines = 0
        descriptionLabel.preferredMaxLayoutWidth = size.width - (2 * margin)
        backgroundNode.addChild(descriptionLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
