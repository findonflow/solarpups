package main

import "github.com/bjartek/overflow"

func main() {

	o := overflow.Overflow()

	o.Tx("mint",
		overflow.WithSignerServiceAccount(),
		overflow.WithArg("assets", map[string]string{
			"623bc4df-6005-4309-aea4-437390f78e98": "https://cdn.krikeyapp.com/nft_web/metadata/623bc4df-6005-4309-aea4-437390f78e98.json"}),
		overflow.WithArg("recipient", "account"),
	)

	o.Script("getEditions", overflow.WithArg("user", "account"), overflow.WithArg("id", 0))
}
