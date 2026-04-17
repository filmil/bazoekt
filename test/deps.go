//go:build tools
// +build tools

package tools

import (
	_ "github.com/google/zoekt/cmd/zoekt-index"
	_ "github.com/google/zoekt/cmd/zoekt-webserver"
)
