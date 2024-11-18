{% macro parse_json_simple(json_column, alias_prefix, keys) %}
  {% set extracted_columns = [] %}

  {% for key in keys %}
    {% set column_name = alias_prefix ~ key | lower %}
    {% set column_sql = json_column ~ ':' ~ key ~ '::FLOAT AS ' ~ column_name %}
    {% do extracted_columns.append(column_sql) %}
  {% endfor %}

  {{ return(extracted_columns | join(',\n  ')) }}
{% endmacro %}
