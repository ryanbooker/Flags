// Copyright © 2025 Ryan Booker. All rights reserved.

import Domain
import StoreKit
public import SwiftUI
import Vexil

public struct AppRoot: View {
  @State private var isPresentingConfig: Bool = false
  @Environment(\.appValidator) private var appValidator
  @Environment(\.flagPole) private var flagPole

  public var body: some View {
    NavigationStack {
      List {
        Section {
          LabeledContent("Environment") {
            Text(flagPole.configuration.environment.rawValue)
          }
        } header: {
          VStack(alignment: .leading) {
            Text(flagPole.configuration.welcome)
            Text("I'm an app that does lots of cool things.")
              .font(.footnote)
          }
        } footer: {
          Text("Triple tap somewhere on the screen to reveal Configuration options.")
        }

        // I realise this isn't reactive and just displays teh launch value.
        Section("Features") {
          LabeledContent("Onboarding Uplift") {
            Text(flagPole.features.enableOnboardingUplift ? "Enabled" : "Disabled")
          }

          LabeledContent("Home Uplift") {
            Text(flagPole.features.enableHomeUplift ? "Enabled" : "Disabled")
          }

          LabeledContent("Category Uplift") {
            Text(flagPole.features.enableCatgeoryUplift ? "Enabled" : "Disabled")
          }

          LabeledContent("Channel Uplift") {
            Text(flagPole.features.enableChannelUplift ? "Enabled" : "Disabled")
          }
        }
      }
    }
    .onTapGesture(count: 3) {
      Task {
        isPresentingConfig = await appValidator.shouldShouldInternalFeatures
      }
    }
    .sheet(isPresented: $isPresentingConfig) {
      ConfigRoot()
    }
  }

  public init() {
    // Intentionally left emtpy
  }
}
