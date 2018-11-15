module ApplicationHelper

  def auth_token
    "<input
  type=\"hidden\"
  name=\"authenticity_token\"
  value='#{h(form_authenticity_token)}'/>"
  end
end
