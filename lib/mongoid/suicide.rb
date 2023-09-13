# frozen_string_literal: true

require 'mongoid'
require 'mongoid/suicide/version'

# :nodoc:
module Mongoid
  # This module allows remove fields.
  module Suicide
    extend ActiveSupport::Concern

    # :nodoc:
    module ClassMethods
      # Removes the field from the Document.
      # A getter and setter will be removed.
      #
      # @example Remove the field
      #   Model.remove_field :score
      #
      # @param [ Symbol ] name The name of the field.
      #
      # @return [ Field ] The removed field
      def remove_field(name)
        name = name.to_s
        return unless fields[name]

        aliased = fields[name].options[:as]

        remove_accessors(name, name)
        remove_accessors(name, aliased) if aliased
        remove_dirty_methods(name)
        remove_dirty_methods(aliased) if aliased

        remove_defaults(name)

        remove_field_in_descendants(name)
        remove_validations_for(name)

        aliased_fields.delete(aliased.to_s) if aliased
        fields.delete(name)
      end

      # Remove the field accessors.
      #
      # @example Remove the accessors.
      #   Person.remove_accessors(:name, "name")
      #   person.name #=> undefined
      #   person.name = "" #=> undefined
      #   person.name? #=> undefined
      #   person.name_before_type_cast #=> undefined
      #   person.name_translations #=> undefined
      #   person.name_translations = "" #=> undefined
      #   person.name_t #=> undefined
      #   person.name_t = "" #=> undefined
      #
      # @param [ Symbol ] name The name of the field.
      # @param [ Symbol ] meth The name of the accessor.
      def remove_accessors(name, meth)
        field = fields[name]

        remove_field_getter(meth)
        remove_field_getter_before_typecast(meth)
        remove_field_setter(meth)
        remove_field_check(meth)

        return unless field.options[:localize]

        remove_translations_getter(meth)
        remove_translations_setter(meth)
        localized_fields.delete(name)
      end

      # Removes the dirty change methods.
      #
      # @example Remove the accessors.
      #   Person.remove_dirty_change_accessor(:name, "name")
      #   person.name_change #=> undefined
      #   person.name_changed? #=> undefined
      #   person.name_will_change! #=> undefined
      #   person.name_changed_from_default? #=> undefined
      #   person.name_was #=> undefined
      #   person.reset_name! #=> undefined
      #   person.reset_name_to_default! #=> undefined
      #
      # @param [ Symbol ] name The attribute name.
      # @param [ String ] meth The name of the accessor.
      def remove_dirty_methods(meth)
        remove_dirty_change_accessor(meth)
        remove_dirty_change_check(meth)
        remove_dirty_change_flag(meth)
        remove_dirty_default_change_check(meth)
        remove_dirty_previous_value_accessor(meth)
        remove_dirty_reset(meth)
        remove_dirty_reset_to_default(meth)
      end

      # Removes the field from descendants.
      #
      # @param [ String ] name The name of the field
      def remove_field_in_descendants(name)
        descendants.each { |descendant| descendant.remove_field(name) }
      end

      # Removes validations for the field.
      #
      # @example Remove validations.
      #   Model.remove_validations_for("name")
      #
      # @param [ String ] name The attribute name.
      def remove_validations_for(name)
        name = name.to_sym
        a_name = [name]

        _validators.reject! { |key, _| key == name }
        remove_validate_callbacks a_name
      end

      # Removes validate callbacks for the field.
      #
      # @example Remove validate callbacks.
      #   Model.remove_validate_callbacks([:name])
      #
      # @param [ Array<Symbol> ] a_name The attribute name.
      def remove_validate_callbacks(a_name)
        chain = _validate_callbacks.dup.reject do |callback|
          f = callback.filter
          f.respond_to?(:attributes) && f.attributes == a_name
        end
        reset_callbacks(:validate)
        chain.each do |callback|
          set_callback 'validate', callback.filter
        end
      end

      # Remove the getter method for the provided field.
      #
      # @example Remove the getter.
      #   Model.remove_field_getter("name")
      #
      # @param [ String ] meth The name of the method.
      def remove_field_getter(meth)
        generated_methods.module_eval do
          undef_method(meth) if method_defined?(meth)
        end
      end

      # Remove the getter_before_type_cast method for the provided field.
      #
      # @example Remove the getter_before_type_cast.
      #   Model.remove_field_getter_before_type_cast("name")
      #
      # @param [ String ] meth The name of the method.
      def remove_field_getter_before_typecast(meth)
        generated_methods.module_eval do
          undef_method("#{meth}_before_type_cast") if method_defined?("#{meth}_before_type_cast")
        end
      end

      # Remove the setter method for the provided field.
      #
      # @example Remove the setter.
      #   Model.remove_field_setter("name")
      #
      # @param [ String ] meth The name of the method.
      def remove_field_setter(meth)
        generated_methods.module_eval do
          undef_method("#{meth}=") if method_defined?("#{meth}=")
        end
      end

      # Remove the check method for the provided field.
      #
      # @example Remove the check.
      #   Model.remove_field_check("name")
      #
      # @param [ String ] meth The name of the method.
      def remove_field_check(meth)
        generated_methods.module_eval do
          undef_method("#{meth}?") if method_defined?("#{meth}?")
        end
      end

      # Remove the translation getter method for the provided field.
      #
      # @example Remove the translation getter.
      #   Model.remove_translations_getter("name")
      #
      # @param [ String ] meth The name of the method.
      def remove_translations_getter(meth)
        generated_methods.module_eval do
          undef_method("#{meth}_translations") if method_defined?("#{meth}_translations")
          undef_method("#{meth}_t") if method_defined?("#{meth}_t")
        end
      end

      # Remove the translation setter method for the provided field.
      #
      # @example Remove the translation setter.
      #   Model.remove_translations_setter("name")
      #
      # @param [ String ] meth The name of the method.
      def remove_translations_setter(meth)
        generated_methods.module_eval do
          undef_method("#{meth}_translations=") if method_defined?("#{meth}_translations=")
          undef_method("#{meth}_t=") if method_defined?("#{meth}_t=")
        end
      end

      # Removes the dirty change accessor.
      #
      # @example Remove the accessor.
      #   Model.remove_dirty_change_accessor("name")
      #
      # @param [ String ] meth The name of the accessor.
      def remove_dirty_change_accessor(meth)
        generated_methods.module_eval do
          undef_method("#{meth}_change") if method_defined?("#{meth}_change")
        end
      end

      # Removes the dirty change check.
      #
      # @example Remove the check.
      #   Model.remove_dirty_change_check("name")
      #
      # @param [ String ] meth The name of the accessor.
      def remove_dirty_change_check(meth)
        generated_methods.module_eval do
          undef_method("#{meth}_changed?") if method_defined?("#{meth}_changed?")
        end
      end

      # Removes the dirty change flag.
      #
      # @example Remove the flag.
      #   Model.remove_dirty_change_flag("name")
      #
      # @param [ String ] meth The name of the accessor.
      def remove_dirty_change_flag(meth)
        generated_methods.module_eval do
          undef_method("#{meth}_will_change!") if method_defined?("#{meth}_will_change!")
        end
      end

      # Removes the dirty default change check.
      #
      # @example Remove the check.
      #   Model.remove_dirty_default_change_check("name")
      #
      # @param [ String ] meth The name of the accessor.
      def remove_dirty_default_change_check(meth)
        generated_methods.module_eval do
          undef_method("#{meth}_changed_from_default?") if method_defined?("#{meth}_changed_from_default?")
        end
      end

      # Removes the dirty change previous value accessor.
      #
      # @example Remove the accessor.
      #   Model.remove_dirty_previous_value_accessor("name")
      #
      # @param [ String ] meth The name of the accessor.
      def remove_dirty_previous_value_accessor(meth)
        generated_methods.module_eval do
          undef_method("#{meth}_was") if method_defined?("#{meth}_was")
        end
      end

      # Removes the dirty change reset.
      #
      # @example Remove the reset.
      #   Model.remove_dirty_reset("name")
      #
      # @param [ String ] meth The name of the accessor.
      def remove_dirty_reset(meth)
        generated_methods.module_eval do
          undef_method("reset_#{meth}!") if method_defined?("reset_#{meth}!")
        end
      end

      # Removes the dirty change reset to default.
      #
      # @example Remove the reset.
      #   Model.remove_dirty_reset_to_default("name")
      #
      # @param [ String ] meth The name of the accessor.
      def remove_dirty_reset_to_default(meth)
        generated_methods.module_eval do
          undef_method("reset_#{meth}_to_default!") if method_defined?("reset_#{meth}_to_default!")
        end
      end
    end
  end
end

# Mongoid::Document.send :include, Mongoid::Suicide
