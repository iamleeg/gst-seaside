Seaside.WAComponent subclass: ContactView [
  < category: 'iAddress'>
  | contact |
  
  ContactView class >> canBeRoot [^true]
  
  contact [
    ^ contact ifNil: [ contact := Contact contacts first ]
  ]
  
  contact: aContact [
    contact := aContact
  ]
  
  renderContentOn: html [
    html form: [
      html text: 'Name: '.
      html textInput on: #name of: self contact.
      html break.
      html text: 'Email address: '.
      html textInput on: #emailAddress of: self contact.
      html break.
      html submitButton on: #save of: self.
    ]
  ]
  
  save [
    "For now, let's just display the information."
    self inform: self contact name, '--', self contact emailAddress.
  ]
]

ContactView registerAsApplication: 'contact'.
