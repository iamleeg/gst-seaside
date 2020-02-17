Seaside.WAComponent subclass: ScrapBook [
  ScrapBook class >> canBeRoot [ ^true ]
  
  style [
    ^ 'h1 { text-align: center; }'
  ]
  
  items [
    ^ #('Calendars' 'Todo lists' 'Shopping carts' 'And lots more...')
  ]
  
  renderContentOn: html [
    html heading: 'Fun with Smalltalk and Seaside.'.
    html paragraph: 'Here are the applications I have yet to write:'.
    html orderedList: [
      self items do: [ :each | html listItem: each ]
    ]
  ]
]

ScrapBook registerAsApplication: 'hello'.

