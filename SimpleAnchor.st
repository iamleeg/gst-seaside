Seaside.WAComponent subclass: SimpleAnchor [
  SimpleAnchor class >> canBeRoot [ ^true ]

  renderContentOn: html [
    html anchor url: 'http://www.seaside.st';
      with: 'Seaside Website'
  ]
  
]

SimpleAnchor registerAsApplication:'simple-anchor'.
