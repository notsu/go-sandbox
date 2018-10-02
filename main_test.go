package main

import "testing"

func TestMain(t *testing.T) {
	got := Hello()
	want := "Hello, World"

	if got != want {
		t.Errorf("got '%s' want '%s'", got, want)
	}
}

func TestMain2(t *testing.T) {
	got := Hello2()
	want := "Hello, World 2"

	if got != want {
		t.Errorf("goh '%s' want '%s'", got, want)
	}
}
