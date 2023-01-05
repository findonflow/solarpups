import SolarpupsNFT from "../contracts/SolarpupsNFT.cdc"

transaction(assets: {String:String}, recipient: Address) {
    let assetRegistry: &SolarpupsNFT.AssetRegistry
    let factory: &SolarpupsNFT.MinterFactory
    let receiver:  &{SolarpupsNFT.CollectionPublic}
		let address:Address

    prepare(Solarpups: AuthAccount) {
        let ex = "could not borrow asset registry reference"
        let ex1 = "could not borrow minter factory reference"
        let ex2 = "could not get receiver reference to the NFT Collection"

				self.address=Solarpups.address
        self.assetRegistry = Solarpups.borrow<&SolarpupsNFT.AssetRegistry>(from: SolarpupsNFT.AssetRegistryStoragePath) ?? panic(ex)
        let Public  = SolarpupsNFT.SolarpupsNFTPublicPath
        let Storage = SolarpupsNFT.MinterFactoryStoragePath

        self.factory  = Solarpups.borrow<&SolarpupsNFT.MinterFactory>(from: Storage) ?? panic(ex1)
        self.receiver = getAccount(recipient).getCapability(Public).borrow<&{SolarpupsNFT.CollectionPublic}>() ?? panic(ex2)
    }

    execute {
        let minter <- self.factory.createMinter()
        for assetId in assets.keys {
					let asset = SolarpupsNFT.Asset(creators: { self.address : 1.0}, assetId: assetId, content: assets[assetId]!)
            self.assetRegistry.store(asset: asset)

            let tokens <- minter.mint(assetId: assetId)
            self.receiver.batchDeposit(tokens: <- tokens)
        }
        destroy minter
    }
}
