import MetadataViews from "../contracts/standard/MetadataViews.cdc"
import SolarpupsNFT from "../contracts/SolarpupsNFT.cdc"

pub fun main(user: Address, id: UInt64) : AnyStruct? {

	let pp = SolarpupsNFT.SolarpupsNFTPublicPath
	let account = getAccount(user)
	let collection= account.getCapability(pp).borrow<&{MetadataViews.ResolverCollection}>()!.borrowViewResolver(id: id)


	return MetadataViews.getEditions(collection)
}

