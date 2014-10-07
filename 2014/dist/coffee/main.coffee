_.templateSettings.variable = "ctx"

ProgramSlot = Backbone.Model.extend
  defaults:
    start: ''
    title: ''
    icon: ''
    speaker:
      id: ''
      name: ''

Speaker = Backbone.Model.extend
  defaults:
    id: ''
    name: ''
    img: ''
    personalPage: ''
    resume: ''
    company:
      name: ''
      url: ''


ProgramSlotView = Backbone.View.extend {
  tagName: 'tr'

  initialize: () ->
    _.bindAll(this, 'render')
    return

  render: () ->
    template = _.template $('#program_slot_template').html()
    $(this.el).append(
      template
        slot: this.model
    )
    return this.el
}


SpeakerView = Backbone.View.extend {
  tagName: 'div'

  initialize: () ->
    _.bindAll(this, 'render')
    return

  render: () ->
    template = _.template $('#speaker_template').html()

    $(this.el).addClass("lector");

    $(this.el).html(
      template
        speaker: this.model
    )

    return this.el
}


Program = Backbone.Collection.extend
  model: ProgramSlot
  url: './data/program.json'

Speakers = Backbone.Collection.extend
  model: Speaker
  url: './data/speakers.json'


$( () ->
  program = new Program()
  program.fetch
    success: (collection) ->
      unless collection.models.length
        $('#agenda').detach()
        $('#nav-agenda').detach()

      for slot in collection.models
        slotView = new ProgramSlotView( { model: slot })
        $('#agenda-table table').append(slotView.render())

  speakers = new Speakers()
  speakers.fetch
    success: (collection) ->
      for speaker in collection.models
        speaker = new SpeakerView( { model: speaker })
        $('#lectors-info').append(speaker.render())
)
