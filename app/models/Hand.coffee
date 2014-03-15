class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->
    @busted = false;

  checkscores: ->
    if @maxScore() > 21 
      @busted = true;
      @trigger 'bust'

  dealerHit: -> 
    if not @busted then @first().flip()
    while @maxScore() < 17
      @hit()

    if not @busted then @trigger 'dealerFinished'

  hit: -> 
    if not @busted
      @add(@deck.pop()).checkscores()
      @last()

  stand: -> @trigger 'stand'

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if hasAce then [score, score + 10] else [score]

  maxScore: ->
    if @scores()[1] <= 21 then @scores()[1] else @scores()[0]

