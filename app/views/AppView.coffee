class window.AppView extends Backbone.View

  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('playerHand').stand()

  initialize: -> 
    @model.on 'won tie lost', (eventName) => 
      console.log eventName
      @render(eventName)
    @render()

  render: (arg) ->
    @$el.children().detach()
    @$el.html @template()
    if arg then @$el.prepend $('<h2></h2>').text arg.toUpperCase()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
