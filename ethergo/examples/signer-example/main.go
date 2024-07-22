// Package main provides the command line interface for the example signer.
package main

import (
	"fmt"
	"os"

	"github.com/synapsecns/sanguine/ethergo/examples/signer-example/cmd"
	"github.com/synapsecns/sanguine/ethergo/examples/signer-example/metadata"
)

func main() {
	fmt.Println("some change")
	cmd.Start(os.Args, metadata.BuildInfo())
}
