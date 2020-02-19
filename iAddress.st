Object subclass: Contact [
  <category: 'iAddress'>
  | name emailAddress gender requestsEmailUpdates birthdate |
  Database := nil.
  
  emailAddress [ ^ emailAddress ]
  emailAddress: aString [ emailAddress := aString ]
  name [ ^ name ]
  name: aString [ name := aString ]
  gender [ ^ gender ifNil: [ gender := #Male ] ]
  birthdate [ ^ birthdate ]
  birthdate: aDate [ birthdate := aDate ]
  isMale [ ^ self gender = #Male ]
  isFemale [ ^ self gender = #Female ]
  beMale [ gender := #Male ]
  beFemale [ gender := #Female ]
  
  requestsEmailUpdates [ ^ requestsEmailUpdates ifNil: [ requestsEmailUpdates := false ] ]
  requestsEmailUpdates: aBoolean [
    requestsEmailUpdates := aBoolean
  ]
  
  Contact class >> name: nameString emailAddress: emailString [
    ^ self new
      name: nameString;
      emailAddress: emailString;
      yourself
  ]
  
  Contact class >> createSampleDatabase [
    Database := OrderedCollection new
      add: (self name: 'Bob Jones' emailAddress: 'bob@nowhere.com');
      add: (self name: 'Steve Smith' emailAddress: 'steve@nowhere.com');
      yourself
  ]
  
  Contact class >> contacts [
    Database isNil ifTrue: [ self createSampleDatabase ].
    ^ Database
  ]
  
  Contact class >> addContact: aContact [
    self contacts add: aContact.
  ]
  
  Contact class >> removeContact: aContact [
    self contacts remove: aContact.
  ]
]

Seaside.WAComponent subclass: ContactListView [
  <category: 'iAddress'>
  ContactListView class >> canBeRoot [ ^ true ]
    
  renderContentOn: html [
    html anchor
      callback: [ self addContact ];
      with: 'Add contact'.
    html unorderedList: [
      Contact contacts do: [ :contact |
        html listItem: [ self renderContact: contact on: html ]
      ]
    ]
  ]
  
  renderContact: aContact on: html [
    html text: aContact name.
    html space.
    html anchor
      url: 'mailto:', aContact emailAddress;
      with: aContact emailAddress.
    html text: ' ('.
    html anchor
      callback: [ self editContact: aContact ];
      with: 'edit'.
    html space.
    html anchor
      callback: [ self removeContact: aContact ];
      with: 'remove'.
    html text: ')'.
  ]
]

ContactListView extend [
  addContact [
    | name email contact |
    name := self request: 'Name'.
    email := self request: 'Email Address'.
    contact := Contact name: name emailAddress: email.
    Contact addContact: contact.
  ]
  
  removeContact: aContact [
    (self confirm: 'Are you sure that you want to remove this contact?')
      ifTrue: [Contact removeContact: aContact]
  ]
  
  editContact: aContact [
    | view copy |
    view := ContactView new.
    copy := aContact copy.
    view contact: copy.
    (self call: view)
      ifTrue: [ Contact removeContact: aContact; addContact: copy ]
  ]
]

ContactListView registerAsApplication:'contacts'.
