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
      html textInput
        callback: [ :value | self contact name: value ];
        value: self contact name.
      html break.
      html text: 'Email address: '.
      html textInput
        callback: [ :value | self contact emailAddress: value ];
        value: self contact emailAddress.
      html break.
      html submitButton
        callback: [ self save ];
        value:'Save'.
    ]
  ]
  
  save [
    "For now, let's just display the information."
    self inform: self contact name, '--', self contact emailAddress.
  ]
]

ContactView registerAsApplication: 'contact'.
