_.templateSettings.variable = 'ctx'

programSlotPrecompiledTemplate = _.template $('#program_slot_template').html()
speakerPrecompiledTemplate = _.template $('#speaker_template').html()


class ProgramSlot extends Backbone.Model
  defaults:
    start: ''
    title: ''
    icon: ''
    speaker:
      id: ''
      name: ''

class Speaker extends Backbone.Model
  defaults:
    id: ''
    name: ''
    img: ''
    personalPage: ''
    resume: ''
    company:
      name: ''
      url: ''


class ProgramSlotView extends Backbone.View
  tagName: 'tr'

  render: ->
    @$el.append(programSlotPrecompiledTemplate(slot: @model))

class SpeakerView extends Backbone.View
  tagName: 'div'

  render: ->
    @$el.addClass('lector')
    @$el.html(speakerPrecompiledTemplate(speaker: @model))


class Program extends Backbone.Collection
  model: ProgramSlot
  url: './data/program.json'

class Speakers extends Backbone.Collection
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
        slotView = new ProgramSlotView(model: slot)
        $('#agenda-table table').append(slotView.render())

  speakers = new Speakers()
  speakers.fetch
    success: (collection) ->
      li = $('#lectors-info')
      collection.each (speaker) ->
        li.append(new SpeakerView(model: speaker)

