Seaside.WAComponent subclass: WebCounter [
  |count|
  WebCounter class >> canBeRoot [ ^true ]

  initialize [
    super initialize.
    count :=0.
  ]

  states [ ^{ self } ]
  renderContentOn: html [
    html heading: count.
    html anchor callback: [ count := count + 1 ]; with: '++'.
    html space.
    html anchor callback: [ count := count - 1 ]; with: '--'.
  ]
]

WebCounter registerAsApplication: 'webcounter'
