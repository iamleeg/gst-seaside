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
    | group |
    html form: [
      html text: 'Name: '.
      html textInput on: #name of: self contact.
      html break.
      html text: 'Email address: '.
      html textInput on: #emailAddress of: self contact.
      html break.
      
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
      
      html text: 'Send email updates: '.
      html checkbox on: #requestsEmailUpdates of: self contact.
      html break.

      html text: 'Birthday: '.
      html dateInput
        callback: [ :value | self contact birthdate: value ];
        with: self contact birthdate.
        
      html break.
      
      html submitButton on: #save of: self.
    ]
  ]
  
  save [
    "For now, let's just display the information."
    self inform: self contact name, '--', self contact emailAddress, '--', self contact gender, '--', self contact requestsEmailUpdates printString, '--', self contact birthdate printString.
  ]
]

ContactView registerAsApplication: 'contact'.
