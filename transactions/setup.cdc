import NonFungibleToken from "../contracts/standard/NonFungibleToken.cdc"
import SolarpupsNFT from "../contracts/SolarpupsNFT.cdc"
import FungibleToken from "../contracts/standard/FungibleToken.cdc"
transaction() {
  prepare(acct: AuthAccount) {
      let Public  = SolarpupsNFT.SolarpupsNFTPublicPath
      let Private = SolarpupsNFT.SolarpupsNFTPrivatePath
      let Storage = SolarpupsNFT.SolarpupsNFTStoragePath

      if acct.borrow<&SolarpupsNFT.Collection>(from: Storage) == nil {
          let collection <- SolarpupsNFT.createEmptyCollection()
          acct.save(<-collection, to: Storage)
          acct.link<&{NonFungibleToken.Receiver, SolarpupsNFT.CollectionPublic}>(Public, target: Storage)
          acct.link<&{NonFungibleToken.Provider, SolarpupsNFT.CollectionPublic}>(Private, target: Storage)
      }
  }
}
