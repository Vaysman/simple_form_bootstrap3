module SimpleForm
  module Inputs
    class DatePickerInput < Base
      def input
        template.content_tag(:div, class: 'input-group date datepicker') do
          template.concat span_calendar
          template.concat @builder.datetime_field(attribute_name, input_html_options)
        end
      end

      private

      def input_html_options
        if options.key? :value
          value = options[:value]
        elsif object.respond_to?(attribute_name)
          value = object.send(attribute_name)
        else
          value = ''
        end

        value = Time.zone.parse(value) if value.is_a?(String)
        value = value.strftime("%Y-%m-%d") if value.respond_to?(:strftime)

        {
          class: 'form-control',
          data: {
            provide: :datepicker,
            "date-format" => "dd.mm.yyyy",
            "date-language" => "ru",
            "date-autoclose" => true,
            "date-today-highlight" => true
          },
          value: value.presence || ''
        }
      end

      def span_calendar
        template.content_tag(:span, class: 'input-group-addon') do
          template.concat icon_calendar
        end
      end

      def icon_calendar
        '<i class="glyphicon glyphicon-calendar"></i>'.html_safe
      end
    end
  end
end
