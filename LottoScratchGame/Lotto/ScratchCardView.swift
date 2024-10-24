// ScratchCardView.swift

import SwiftUI

struct ScratchCardView: View {
  var viewModel: LottoScratchGameViewModel
  @Namespace private var animationNamespace

  var body: some View {
    VStack {
      // Display the target symbol or game title
//      HStack {
//        Text("Match")
//        Image(systemName: viewModel.targetSymbol)
//          .foregroundColor(.symbol)
//        Text("to Win!")
//      }
//      .font(.headline)
//      .padding()

      ZStack {
        symbolsBackgroundView()
        
        if viewModel.showConfetti {
          ConfettiView()
            .transition(.opacity)
            .animation(.easeOut(duration: 1), value: viewModel.showConfetti)
        }
      }
      .padding()

      // Add the reset button
      Button(action: {
        viewModel.resetGame()
      }) {
        Text("Reset Game")
          .font(.headline)
          .padding()
          .frame(maxWidth: .infinity)
          .background(Color.card.opacity(0.8))
          .foregroundColor(.black)
          .cornerRadius(10)
      }
      .padding()
    }
  }

  // MARK: - Symbols Background View

  @ViewBuilder
  private func symbolsBackgroundView() -> some View {
    RoundedRectangle(cornerRadius: 20)
      .fill(Color.card)
      .frame(width: viewModel.cardSize.width, height: viewModel.cardSize.height)
      .overlay {
        ForEach(viewModel.symbols) { symbolWrapper in
          SymbolView(
            symbol: symbolWrapper,
            animationNamespace: animationNamespace
          )
        }
      }
  }
}

#Preview {
  ScratchCardView(viewModel: LottoScratchGameViewModel())
}
