include Nanoc3::Helpers::Blogging
include Nanoc3::Helpers::LinkTo
include Nanoc3::Helpers::Rendering

module JavascriptHelper
  JS_ESCAPE_MAP = {
    '\\'    => '\\\\',
    '</'    => '<\/',
    "\r\n"  => '\n',
    "\n"    => '\n',
    "\r"    => '\n',
    '"'     => '\\"',
    "'"     => "\\'" }

  # Escape carrier returns and single and double quotes for JavaScript segments.
  def escape_javascript(javascript)
    if javascript
      javascript.gsub(/(\\|<\/|\r\n|[\n\r"'])/) { JS_ESCAPE_MAP[$1] }
    else
      ''
    end
  end
end