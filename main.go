package main

import (
	"flag"
	"log/slog"
	"os"

	"github.com/noemacias/webz"
)

func main() {
	argv := os.Args
	directory := "."

	listen := flag.String("l", ":8080", "listen port")

	flag.Parse()

	if len(argv) > 1 {
		directory = argv[1]
	}

	s := webz.NewServer(
		webz.WithServerAddr(*listen),
	)

	s.Webz.FileServer("/", directory)

	if err := s.Start(); err != nil {
		slog.Error("Failed to start server", "error", err)
	}
}
