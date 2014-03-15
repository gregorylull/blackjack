class window.HandView extends Backbone.View

  className: 'hand'

  #todo: switch to mustache
  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'

  initialize: ->
    @collection.on 'add remove change', => @render()
    @collection.on 'bust', => @render 'bust'
    @render()

  render: (arg) ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    @$('.score').text @collection.scores()[0]
    # my code
    # busted logic
    if arg is 'bust' then $('h2', @$el).text ((if @collection.isDealer then 'Dealer' else 'You') + ' BUSTED!') 
