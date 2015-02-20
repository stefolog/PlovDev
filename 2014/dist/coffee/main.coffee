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

programSlotPrecompiledTemplate = _.template $('#program_slot_template').html()
speakerPrecompiledTemplate = _.template $('#speaker_template').html()

class ProgramSlotView extends Backbone.View
  tagName: 'tr'

  render: ->
    @$el.append(programSlotPrecompiledTemplate(slot: this.model))


class SpeakerView extends Backbone.View
  tagName: 'div'

  render: ->
    @$el.addClass('lector')
    @$el.html(speakerPrecompiledTemplate(speaker: this.model))


Program = Backbone.Collection.extend
  model: ProgramSlot
  url: './data/program.json'

Speakers = Backbone.Collection.extend
  model: Speaker
  url: './data/speakers.json'


$ ->
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
      collection.each (speaker) ->
        $('#lectors-info').append(new SpeakerView( { model: speaker }).render())

