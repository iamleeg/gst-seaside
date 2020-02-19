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
  
  renderNameOn: html [
      html text: 'Name: '.
      html textInput on: #name of: self contact.
      html break.
  ]
  
  renderEmailOn: html [
      html text: 'Email address: '.
      html textInput on: #emailAddress of: self contact.
      html break.
  ]

  renderGenderOn: html [
    | group |
      html text: 'Gender: '.
      group := html radioGroup.
      group radioButton
        selected: self contact isMale;
        callback: [ self contact beMale ].
      html text: 'Male'.
      group radioButton
        selected: self contact isFemale;
        callback: [ self contact beFemale ].
      html text: 'Female'.
      html break.
  ]

  renderSendUpdatesOn: html [
      html text: 'Send email updates: '.
      html checkbox on: #requestsEmailUpdates of: self contact.
      html break.
  ]

  renderDateOn: html [
      html text: 'Birthday: '.
      html dateInput
        callback: [ :value | self contact birthdate: value ];
        with: self contact birthdate.
      html break.
  ]

  renderSaveOn: html [
      html submitButton on: #cancel of: self.
      html submitButton on: #save of: self.
  ]
  
  renderContentOn: html [
    html form: [
      self renderNameOn: html.
      self renderEmailOn: html.
      self renderGenderOn: html.      
      self renderSendUpdatesOn: html.
      self renderDateOn: html.      
      self renderSaveOn: html.
    ]
  ]
  
  save [
    self answer: true.
  ]
  
  cancel [
    self answer: false.
  ]
]

ContactView registerAsApplication: 'contact'.
