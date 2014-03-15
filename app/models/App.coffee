#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    # access to player and dealer hands
    playerHand = @get 'playerHand'
    dealerHand = @get 'dealerHand'

    # when player hits and busts
    playerHand.on 'bust', -> console.log 'player busted'

    # when player stands
    playerHand.on 'stand', => dealerHand.dealerHit()

    # score comparison after play stands and after dealer is done dealing
    dealerHand.on 'dealerFinished', => @compareScores();

  compareScores: -> 
    playerScore = (@get 'playerHand').scores()[0]
    dealerScore = (@get 'dealerHand').scores()[0]
    if playerScore > dealerScore then @trigger 'won', 'won'
    else if playerScore < dealerScore then @trigger 'lost', 'lost'
    else @trigger 'tie', 'tie'