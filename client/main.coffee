Template.chat.helpers
  'messages': ->
    Messages.find {},
      sort:
        creaedAt: 1

Template.message.helpers
  'messageCssClass': ->
    if Template.currentData().senderId is Meteor.userId()
      'direct-chat-msg right'
    else
      'direct-chat-msg'

Template.chat.events
  'submit #messageForm': (e)->
    e.preventDefault()
#    alert $('#messageInput').val()

    unless Meteor.user()?
      alert '가입 해주시기 바랍니다'
      return

    if Meteor.user().profile? # 페이스북 유저
      name = Meteor.user().profile.name
    else # 이메일 가입 유저
      name = Meteor.user().emails[0].address

    message =
      sender: name
      senderId: Meteor.userId()
      message: $('#messageInput').val()
      createdAt: new Date()

    Messages.insert message, (error, _id)->
      if error
        alert error.reason

    $('#messageInput').val('')

Template.registerHelper 'formatAgo',  (date)->
  moment(date).fromNow()