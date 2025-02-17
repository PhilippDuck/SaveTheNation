class CardDatabase {
    static func getGameOverCard() -> Card {
        return Card(
            title: "Game Over",
            description: "Das Spiel ist vorbei. Wischen Sie, um neu zu starten.",
            type: .demand,
            acceptEffects: [],
            rejectEffects: [],
            imageName: "gameoverIcon", // Ein spezielles Game-Over-Symbol
            acceptText: "Neustart",
            rejectText: "Neustart"
        )
    }
    static func getInitialDeck() -> [Card] {
        return [
            Card(
                title: "Steuern erhöhen",
                description: "Erhöhe die Steuern, um das Budget auszugleichen.",
                type: .demand,
                acceptEffects: [
                    Effect(group: "Staatskasse", value: 10),
                    Effect(group: "Volk", value: -5)
                ],
                rejectEffects: [
                    Effect(group: "Staatskasse", value: -10)
                ],
                imageName: "taxesIcon",
                acceptText: "Budget gesichert.",
                rejectText: "Steuern unverändert."
            ),
            Card(
                title: "Solaranlagen bauen",
                description: "Investiere in erneuerbare Energien.",
                type: .building,
                acceptEffects: [
                    Effect(group: "Volk", value: 5),
                    Effect(group: "Staatskasse", value: -5)
                ],
                rejectEffects: [
                    Effect(group: "Volk", value: -5),
                    Effect(group: "Staatskasse", value: 5)
                ],
                imageName: "solarIcon",
                acceptText: "Umwelt freut sich.",
                rejectText: "Projekt abgelehnt."
            ),
            Card(
                title: "Arbeitszeit verkürzen",
                description: "Arbeitszeit der Arbeiter auf 35 Stunden pro Woche reduzieren.",
                type: .demand,
                acceptEffects: [
                    Effect(group: "Volk", value: 10),
                    Effect(group: "Staatskasse", value: -10)
                ],
                rejectEffects: [
                    Effect(group: "Volk", value: -5),
                    Effect(group: "Staatskasse", value: 5)
                ],
                imageName: "worktimeIcon",
                acceptText: "Mehr Freizeit.",
                rejectText: "Es bleibt gleich."
            ),
            Card(
                title: "Militärausgaben erhöhen",
                description: "Das Militärbudget zur Landesverteidigung erhöhen.",
                type: .demand,
                acceptEffects: [
                    Effect(group: "Staatskasse", value: -15),
                    Effect(group: "Volk", value: -5)
                ],
                rejectEffects: [
                    Effect(group: "Staatskasse", value: 10),
                    Effect(group: "Volk", value: 5)
                ],
                imageName: "militaryIcon",
                acceptText: "Budget steigt.",
                rejectText: "Keine Erhöhung."
            ),
            Card(
                title: "Bildung fördern",
                description: "Budget zur Verbesserung der Schulen bereitstellen.",
                type: .building,
                acceptEffects: [
                    Effect(group: "Volk", value: 10),
                    Effect(group: "Staatskasse", value: -10)
                ],
                rejectEffects: [
                    Effect(group: "Volk", value: -5),
                    Effect(group: "Staatskasse", value: 5)
                ],
                imageName: "educationIcon",
                acceptText: "Schulen gefördert.",
                rejectText: "Keine Förderung."
            )
        ]
    }
}
