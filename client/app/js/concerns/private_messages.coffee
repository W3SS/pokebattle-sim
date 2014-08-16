# Clicking a person's name will open a private message session with that person.
$(document).on 'click', '.open_pm', ->
  $this = $(this)
  message = PokeBattle.messages.add(id: $this.data('user-id'))
  message.trigger('open', message)
  message.trigger('focus', message)

# Receive private message events
PokeBattle.primus.on 'privateMessage', (messageId, fromUserId, messageText) ->
  message = PokeBattle.messages.add(id: messageId)
  message.add(fromUserId, messageText)

# Challenges
PokeBattle.primus.on 'challenge', (fromUserId, generation, conditions) ->
  message = PokeBattle.messages.add(id: fromUserId)
  message.add(fromUserId, "You have been challenged!", type: "alert")
  message.openChallenge(fromUserId, generation, conditions)

PokeBattle.primus.on 'cancelChallenge', (fromUserId) ->
  message = PokeBattle.messages.add(id: fromUserId)
  message.add(fromUserId, "The challenge was canceled!", type: "alert")
  message.closeChallenge(fromUserId)

PokeBattle.primus.on 'rejectChallenge', (fromUserId) ->
  message = PokeBattle.messages.add(id: fromUserId)
  message.add(fromUserId, "The challenge was rejected!", type: "alert")
  message.closeChallenge(fromUserId)

PokeBattle.primus.on 'challengeSuccess', (fromUserId) ->
  message = PokeBattle.messages.add(id: fromUserId)
  message.closeChallenge(fromUserId)
