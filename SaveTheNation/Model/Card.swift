struct Card {
    let title: String
    let description: String
    let type: CardType
    let acceptEffects: [Effect]
    let rejectEffects: [Effect]
    let imageName: String
}

enum CardType {
    case event
    case demand
    case building
}

struct Effect {
    let group: String
    let value: Int
}
