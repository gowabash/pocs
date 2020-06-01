package main

import (
  "fmt"
  "flag"
  "regexp"


  "github.com/mmcdole/gofeed"
  "jaytaylor.com/html2text"
)

const URL = "https://naptownfitness.com/feed/"

func main() {

  getAll := flag.Bool("a", false, "Show all workouts")
  flag.Parse()

  fp := gofeed.NewParser()
  feed, _ := fp.ParseURL(URL)
  for _, item := range feed.Items {
    matched, _ := regexp.MatchString(`SWIFT`, item.Title)
    if  matched {
      fmt.Println(item.Title)
      text, err := html2text.FromString(item.Content, html2text.Options{PrettyTables: true})
      if err != nil {
        panic(err)
      }
      fmt.Println(text)
      if !*getAll {
        break
      }
    }
  }
}
