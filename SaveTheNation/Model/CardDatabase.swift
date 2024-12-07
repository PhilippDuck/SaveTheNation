import Foundation

class CardDatabase {
    static func getInitialDeck() -> [Card] {
        return [
            Card(
                title: "Increase Taxes",
                description: "Raise taxes to balance the budget.",
                type: .demand,
                acceptEffects: [
                    Effect(group: "Workers", value: -5),
                    Effect(group: "Entrepreneurs", value: 5)
                ],
                rejectEffects: [
                    Effect(group: "Workers", value: 5)
                ],
                imageName: "taxesIcon"
            ),
            Card(
                title: "Build Solar Plants",
                description: "Invest in renewable energy sources.",
                type: .building,
                acceptEffects: [
                    Effect(group: "Environmentalists", value: 10)
                ],
                rejectEffects: [
                    Effect(group: "Entrepreneurs", value: -5)
                ],
                imageName: "solarIcon"
            )
        ]
    }
}
