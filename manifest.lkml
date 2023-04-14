# project_name: "kevmccarthy_playground"

constant: stringify_input_string_with_underscores {
  value: "{% assign words_array = input | split:'_' %}{% for word in words_array %}{{word | capitalize}}{% if forloop.last %}{%else%} {%endif%}{%endfor%}"
}
