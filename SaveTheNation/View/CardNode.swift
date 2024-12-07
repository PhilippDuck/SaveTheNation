import SpriteKit

class CardNode: SKSpriteNode {
    // MARK: - Eigenschaften
    let card: Card // Verweist auf die Daten der Karte

    // MARK: - Initialisierung
    init(card: Card, size: CGSize, cornerRadius: CGFloat) {
        self.card = card // Speichere die Kartendaten
        // Erstelle eine abgerundete Textur
        let texture = CardNode.createRoundedRectTexture(size: size, color: .darkGray, cornerRadius: cornerRadius)
        super.init(texture: texture, color: .clear, size: size)
        
        // Setze Inhalte (Titel, Beschreibung und Bild)
        setupCardContent(title: card.title, description: card.description, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Textur mit abgerundeten Ecken erstellen
    static func createRoundedRectTexture(size: CGSize, color: UIColor, cornerRadius: CGFloat) -> SKTexture {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let context = UIGraphicsGetCurrentContext()
        let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
        context?.setFillColor(color.cgColor)
        path.fill()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return SKTexture(image: image!)
    }
    
    // MARK: - Inhalte für die Karte setzen
    private func setupCardContent(title: String, description: String, size: CGSize) {
        // Titel (oben auf der Karte)
        let titleLabel = SKLabelNode(text: title)
        titleLabel.fontName = "AvenirNext-Bold"
        titleLabel.fontSize = 24
        titleLabel.fontColor = .white
        titleLabel.position = CGPoint(x: 0, y: size.height / 2 - 50)
        titleLabel.zPosition = 1
        addChild(titleLabel)
        
        // Beschreibung (Mitte der Karte)
        let descriptionLabel = SKLabelNode(text: description)
        descriptionLabel.fontName = "AvenirNext-Regular"
        descriptionLabel.fontSize = 20
        descriptionLabel.fontColor = .white
        descriptionLabel.position = CGPoint(x: 0, y: size.height / 2 - 60)
        descriptionLabel.zPosition = 1
        descriptionLabel.numberOfLines = 0
        descriptionLabel.preferredMaxLayoutWidth = size.width - 20
        descriptionLabel.verticalAlignmentMode = .top
        addChild(descriptionLabel)
        
        // Bild unterhalb der Beschreibung
        let imageNode = ladeBild(named: card.imageName)
        imageNode.size = CGSize(width: size.width * 0.8, height: size.width * 0.8)
        imageNode.position = CGPoint(x: 0, y: -size.height / 8)
        imageNode.zPosition = 1
        addChild(imageNode)
    }
    
    // MARK: - Bildladefunktion mit Fallback
    private func ladeBild(named imageName: String) -> SKSpriteNode {
        if UIImage(named: imageName) != nil {
            // Das Bild existiert
            return SKSpriteNode(imageNamed: imageName)
        } else {
            // Fallback-Bild verwenden
            print("Bild '\(imageName)' nicht gefunden. Fallback auf 'dummy.png'.")
            return SKSpriteNode(imageNamed: "dummy")
        }
    }
}
