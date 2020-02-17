Object subclass: Contact [
  <category: 'iAddress'>
  | name emailAddress |
  Database := nil.
  
  emailAddress [ ^ emailAddress ]
  emailAddress: aString [ emailAddress := aString ]
  name [ ^ name ]
  name: aString [ name := aString ]
  
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
    html render: aContact name; render: ' '; render: aContact emailAddress
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
]

ContactListView registerAsApplication:'contacts'.