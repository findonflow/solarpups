import NonFungibleToken from "../contracts/standard/NonFungibleToken.cdc"
import SolarpupsNFT from "../contracts/SolarpupsNFT.cdc"

pub fun main(user: Address, id: UInt64): UInt64{

	let p = SolarpupsNFT.SolarpupsNFTStoragePath
  let c = getAuthAccount(user).borrow<&{NonFungibleToken.CollectionPublic}>(from: p) ?? panic("collection not found")
  let nft = c.borrowNFT(id: id)
	return nft.uuid
}

