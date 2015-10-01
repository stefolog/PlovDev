var Program, ProgramSlot, ProgramSlotView, Speaker, SpeakerView, Speakers;

_.templateSettings.variable = "ctx";

ProgramSlot = Backbone.Model.extend({
  defaults: {
    start: '',
    title: '',
    icon: '',
    speaker: {
      id: '',
      name: ''
    }
  }
});

Speaker = Backbone.Model.extend({
  defaults: {
    id: '',
    name: '',
    img: '',
    personalPage: '',
    resume: '',
    company: {
      name: '',
      url: ''
    }
  }
});

ProgramSlotView = Backbone.View.extend({
  tagName: 'tr',
  initialize: function() {
    _.bindAll(this, 'render');
  },
  render: function() {
    var template;
    template = _.template($('#program_slot_template').html());
    $(this.el).append(template({
      slot: this.model
    }));
    return this.el;
  }
});

SpeakerView = Backbone.View.extend({
  tagName: 'div',
  initialize: function() {
    _.bindAll(this, 'render');
  },
  render: function() {
    var template;
    template = _.template($('#speaker_template').html());
    $(this.el).addClass("lector");
    $(this.el).html(template({
      speaker: this.model
    }));
    return this.el;
  }
});

Program = Backbone.Collection.extend({
  model: ProgramSlot,
  url: './data/program.json'
});

Speakers = Backbone.Collection.extend({
  model: Speaker,
  url: './data/speakers.json'
});

$(function() {
  var program, speakers;
  program = new Program();
  program.fetch({
    success: function(collection) {
      var slot, slotView, _i, _len, _ref, _results;
      if (!collection.models.length) {
        $('#agenda').detach();
        $('#nav-agenda').detach();
      }
      _ref = collection.models;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        slot = _ref[_i];
        slotView = new ProgramSlotView({
          model: slot
        });
        _results.push($('#agenda-table table').append(slotView.render()));
      }
      return _results;
    }
  });
  speakers = new Speakers();
  return speakers.fetch({
    success: function(collection) {
      var speaker, _i, _len, _ref, _results;
      _ref = collection.models;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        speaker = _ref[_i];
        speaker = new SpeakerView({
          model: speaker
        });
        _results.push($('#lectors-info').append(speaker.render()));
      }
      return _results;
    }
  });
});
