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
        
        // Setze Inhalte (Titel und Beschreibung)
        setupCardContent(title: card.title, description: card.description, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Textur mit abgerundeten Ecken erstellen
    static func createRoundedRectTexture(size: CGSize, color: UIColor, cornerRadius: CGFloat) -> SKTexture {
        // Rechteck für den Zeichenbereich
        let rect = CGRect(origin: .zero, size: size)
        
        // Erstelle einen Kontext für das Zeichnen
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let context = UIGraphicsGetCurrentContext()
        
        // Zeichne ein abgerundetes Rechteck
        let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
        context?.setFillColor(color.cgColor) // Fülle mit der angegebenen Farbe
        path.fill()
        
        // Hole das Bild aus dem Kontext
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Konvertiere das Bild in eine SKTexture
        return SKTexture(image: image!)
    }
    
    // MARK: - Inhalte für die Karte setzen
    private func setupCardContent(title: String, description: String, size: CGSize) {
        // Titel (oben auf der Karte)
        let titleLabel = SKLabelNode(text: title)
        titleLabel.fontName = "AvenirNext-Bold"
        titleLabel.fontSize = 24
        titleLabel.fontColor = .white
        titleLabel.position = CGPoint(x: 0, y: size.height / 4) // Oben zentriert
        titleLabel.zPosition = 1 // Über der Textur
        addChild(titleLabel)
        
        // Beschreibung (Mitte der Karte)
        let descriptionLabel = SKLabelNode(text: description)
        descriptionLabel.fontName = "AvenirNext-Regular"
        descriptionLabel.fontSize = 16
        descriptionLabel.fontColor = .white
        descriptionLabel.position = CGPoint(x: 0, y: -size.height / 8) // Unterhalb des Titels
        descriptionLabel.zPosition = 1 // Über der Textur
        descriptionLabel.numberOfLines = 0 // Mehrzeiliger Text
        descriptionLabel.preferredMaxLayoutWidth = size.width - 20 // Begrenzung auf Kartenbreite
        descriptionLabel.verticalAlignmentMode = .top
        addChild(descriptionLabel)
    }
}
