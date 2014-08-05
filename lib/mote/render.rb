require "mote"

module Mote::Render
  include Mote::Helpers

  def self.setup(app)
    app.settings[:mote] ||= {}
    app.settings[:mote][:views] ||= File.expand_path("views", Dir.pwd)
    app.settings[:mote][:layout] ||= "layout"
  end

  def render(template, locals = {}, layout = settings[:mote][:layout])
    res.write view(template, locals, layout)
  end

  def view(template, locals = {}, layout = settings[:mote][:layout])
    partial(layout, locals.merge(content: partial(template, locals)))
  end

  def partial(template, locals = {})
    mote(mote_path(template), locals.merge(app: self), TOPLEVEL_BINDING)
  end

  def mote_path(template)
    return File.join(settings[:mote][:views], "#{template}.mote")
  end
end
