//
//  AssetSectionView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 18/05/2024.
//

import SwiftUI

struct AssetSectionView: View {
    @State var selectedTab: NFTGridTabBar.Options = .house
    @StateObject var vm: AssetSectionViewModel
    @FocusState private var searchBarIsFocused: Bool
    @EnvironmentObject var accountManger: AccountManager

    var onSearchBarFocused: (Bool) -> Void

//    init(vm: AssetSectionViewModel = AssetSectionViewModel(),
//         onSearchBarFocused: @escaping (Bool) -> Void) {
//        self.onSearchBarFocused = onSearchBarFocused
//        self.vm = vm
//    }

    var body: some View {
        VStack(spacing: 0) {
            searchBar
                .padding(20)

            NFTGridTabBar() {tab in
                selectedTab = tab
            }
            .padding(.horizontal, 20)

            ZStack {
                houseGrid
                    .opacity(selectedTab == .house ? 1 :0)
                bookmarkGrid
                    .opacity(selectedTab == .bookmark ? 1 :0)
            }
            .padding(.bottom, 80)
            .padding(.top, 8)
        }
        .task {
            await vm.fetchNFTs(userPublicKey: accountManger.account.publicKey)
            await vm.fetchBookmarkedNFT()
        }
    }

    var searchBar: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search", text: $vm.searchWord)
                    .focused($searchBarIsFocused)
                    .placeholder(when: vm.searchWord.isEmpty) {
                        Text("Search")
                            .foregroundColor(.white.opacity(0.7))
                    }
                    .accentColor(.red)
                    .foregroundColor(.white)
                    .onChange(of: searchBarIsFocused) { oldValue, newValue in
                        onSearchBarFocused(newValue)
                    }
            }
            .foregroundColor(Color.white.opacity(0.7))
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .frame(height: 48)
            .background(.white.opacity(0.07))
            .cornerRadius(6)
            .overlay {
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.white.opacity(0.3))
            }

            Image(systemName: "slider.horizontal.3")
                .foregroundColor(.white.opacity(0.7))
        }
    }

    var houseGrid: some View {
        NFTGrid(NFTs: vm.nfts, showBidTime: false)

    }

    var bookmarkGrid: some View {
        NFTGrid(NFTs: vm.bookmarkedNFTs, showBidTime: false)
    }
}

#Preview {
    AssetSectionView(vm: AssetSectionViewModel(nftService: NFTServiceDouble(),
                                               assetService: AssetServiceDouble())) {_ in }
        .background(Color._grey800)
        .environmentObject(AccountManager.mock())
}


import Solana

class AssetSectionViewModel: ObservableObject {
    @Published var nfts: [String] = []
    @Published var bookmarkedNFTs: [String] = []
    @Published var searchWord = ""
    let nftService: INFTService
    let assetService: IAssetService

    init(nftService: INFTService = NFTService(),
         assetService: IAssetService = AssetService())
    {
        self.nftService = nftService
        self.assetService = assetService
    }

    @MainActor
    func fetchNFTs(userPublicKey: PublicKey) async {
        do {
            let result = try await nftService.fetchNFts()
            self.nfts = result.filter({ nft in
                nft.owner == userPublicKey
            }).map(\.id)
        } catch {
            print(error.localizedDescription)
        }
//        DispatchQueue.main.async {
//            self.nfts = ["", "b"]
//        }
    }

    @MainActor
    func fetchBookmarkedNFT() async {
        do {
            let result = try await assetService.fetchBookmarkedAssets()
            self.bookmarkedNFTs = result
        } catch {
            print(error.localizedDescription)
        }
    }
}