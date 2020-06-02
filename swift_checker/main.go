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
  workoutMessage := "The workout you want to see.\n\t1 - SWIFT\n\t2 - CROSSFIT\n\t3 - HOME"
  getAll := flag.Bool("a", false, "Show all workouts")
  workout := flag.Int("w", 1, workoutMessage)
  flag.Parse()

  fp := gofeed.NewParser()
  feed, _ := fp.ParseURL(URL)
  for _, item := range feed.Items {
    var matched bool
    if *workout == 1 { 
      matched, _ = regexp.MatchString(`SWIFT`, item.Title)
    } else if *workout == 2 {
      matched, _ = regexp.MatchString(`CrossFit`, item.Title)
    } else if *workout == 3 {
      matched, _ = regexp.MatchString(`Home`, item.Title)
    }
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
