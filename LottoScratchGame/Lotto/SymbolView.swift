// SymbolView.swift

import SwiftUI

struct SymbolView: View {
  @ObservedObject var symbol: ScratchSymbolWrapper
  let animationNamespace: Namespace.ID
  let gridSize = 10

//  @State private var rotationAngle: Double = 0 // Track rotation state

  var body: some View {
    ZStack {
      // The symbol image is always displayed
      Image(systemName: symbol.symbol.symbolName)
        .resizable()
        .frame(width: symbol.symbol.position.width, height: symbol.symbol.position.height)
        .position(x: symbol.symbol.position.midX, y: symbol.symbol.position.midY)
        .foregroundStyle(Color.symbol)
//        .scaleEffect(symbol.isMatched ? 1.5 : 1) // Animate scale when matched
        .opacity(symbol.isMatched ? 1 : 0.6)     // Adjust opacity for unrevealed symbols
        .matchedGeometryEffect(id: symbol.symbol.id, in: animationNamespace)
        .accessibilityElement()
        .accessibilityLabel(Text(symbol.symbol.symbolName))
        .accessibilityHidden(!symbol.symbol.isFullyRevealed)

      // The scratchable overlay
      if !symbol.symbol.isFullyRevealed {
        ScratchableOverlay(
          symbol: symbol,
          gridSize: gridSize
        )
        .frame(width: symbol.symbol.position.width, height: symbol.symbol.position.height)
        .position(x: symbol.symbol.position.midX, y: symbol.symbol.position.midY)
      }
    }
  }
}
