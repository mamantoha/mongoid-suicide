# frozen_string_literal: true

require 'spec_helper'

describe Mongoid::Suicide do
  describe '#remove_field' do
    context 'remove accessors' do
      before do
        Person.field(:remove_testing, type: String)
      end

      let(:person) do
        Person.new
      end

      before(:each) do
        Person.remove_field(:remove_testing)
      end

      it 'removes field getter' do
        expect do
          person.remove_testing
        end.to raise_error(NoMethodError)
      end

      it 'removes field setter' do
        expect do
          person.remove_testing = 'test'
        end.to raise_error(NoMethodError)
      end

      it 'removes field _before_type_cast getter' do
        expect do
          person.remove_testing_before_type_cast
        end.to raise_error(NoMethodError)
      end

      it 'removes field check method' do
        expect do
          person.remove_testing?
        end.to raise_error(NoMethodError)
      end

      it 'removes field from fields' do
        expect(Person.fields).to_not include('remove_testing')
      end
    end

    context 'remove accessors for aliasing field' do
      before do
        Person.field(:remove_testing, type: String, as: :rt)
      end

      let(:person) do
        Person.new
      end

      before(:each) do
        Person.remove_field(:remove_testing)
      end

      it 'removes field getter' do
        expect do
          person.rt
        end.to raise_error(NoMethodError)
      end

      it 'removes field setter' do
        expect do
          person.rt = 'test'
        end.to raise_error(NoMethodError)
      end

      it 'removes field _before_type_cast getter' do
        expect do
          person.rt_before_type_cast
        end.to raise_error(NoMethodError)
      end

      it 'removes field check method' do
        expect do
          person.rt?
        end.to raise_error(NoMethodError)
      end

      it 'removes field from aliased_fields' do
        expect(Person.aliased_fields).to_not include('rt')
      end
    end

    context 'remove translations' do
      before do
        Person.field(:remove_testing, type: String, localize: true)
      end

      let(:person) do
        Person.new
      end

      before(:each) do
        Person.remove_field(:remove_testing)
      end

      it 'removes field translation getter' do
        expect do
          person.remove_testing_translations
        end.to raise_error(NoMethodError)
      end

      it 'removes field translation setter' do
        expect do
          person.remove_testing_translations = { de: 'test' }
        end.to raise_error(NoMethodError)
      end

      it 'removes field translation getter alias' do
        expect do
          person.remove_testing_t
        end.to raise_error(NoMethodError)
      end

      it 'removes field translation setter alias' do
        expect do
          person.remove_testing_t = { de: 'test' }
        end.to raise_error(NoMethodError)
      end

      it 'localized_fields should not have removed field' do
        expect(person.localized_fields).to_not include('remove_testing')
      end
    end

    context 'remove translations for aliasing field' do
      before do
        Person.field(:remove_testing, type: String, localize: true, as: :rt)
      end

      let(:person) do
        Person.new
      end

      before(:each) do
        Person.remove_field(:remove_testing)
      end

      it 'removes field translation getter' do
        expect do
          person.rt_translations
        end.to raise_error(NoMethodError)
      end

      it 'removes field translation setter' do
        expect do
          person.rt_translations = { de: 'test' }
        end.to raise_error(NoMethodError)
      end

      it 'removes field translation getter alias' do
        expect do
          person.rt_t
        end.to raise_error(NoMethodError)
      end

      it 'removes field translation setter alias' do
        expect do
          person.rt_t = { de: 'test' }
        end.to raise_error(NoMethodError)
      end
    end

    context 'remove dirty change methods' do
      before do
        Person.field(:remove_testing, type: String)
      end

      let(:person) do
        Person.new
      end

      before(:each) do
        Person.remove_field(:remove_testing)
      end

      it 'removes the dirty change accessor' do
        expect do
          person.remove_testing_change
        end.to raise_error(NoMethodError)
      end

      it 'removes the dirty change check' do
        expect do
          person.remove_testing_changed?
        end.to raise_error(NoMethodError)
      end

      it 'removes the dirty change flag' do
        expect do
          person.remove_testing_will_change!
        end.to raise_error(NoMethodError)
      end

      it 'removes the dirty default change check' do
        expect do
          person.remove_testing_changed_from_default?
        end.to raise_error(NoMethodError)
      end

      it 'removes the dirty change previous value accessor' do
        expect do
          person.remove_testing_was
        end.to raise_error(NoMethodError)
      end

      it 'removes the dirty change reset' do
        expect do
          person.reset_remove_testing!
        end.to raise_error(NoMethodError)
      end

      it 'removes the dirty change reset to default' do
        expect do
          person.reset_remove_testing_to_default!
        end.to raise_error(NoMethodError)
      end
    end

    context 'remove dirty change methods for aliasing field' do
      before do
        Person.field(:remove_testing, type: String, as: :rt)
      end

      let(:person) do
        Person.new
      end

      before(:each) do
        Person.remove_field(:remove_testing)
      end

      it 'removes the dirty change accessor' do
        expect do
          person.rt_change
        end.to raise_error(NoMethodError)
      end

      it 'removes the dirty change check' do
        expect do
          person.rt_changed?
        end.to raise_error(NoMethodError)
      end

      it 'removes the dirty change flag' do
        expect do
          person.rt_will_change!
        end.to raise_error(NoMethodError)
      end

      it 'removes the dirty default change check' do
        expect do
          person.rt_changed_from_default?
        end.to raise_error(NoMethodError)
      end

      it 'removes the dirty change previous value accessor' do
        expect do
          person.rt_was
        end.to raise_error(NoMethodError)
      end

      it 'removes the dirty change reset' do
        expect do
          person.reset_rt!
        end.to raise_error(NoMethodError)
      end

      it 'removes the dirty change reset to default' do
        expect do
          person.reset_rt_to_default!
        end.to raise_error(NoMethodError)
      end
    end

    context 'remove validators' do
      before do
        Person.field(:remove_testing, type: String)
        Person.validates(:remove_testing, uniqueness: true)
      end

      before(:each) do
        Person.remove_field(:remove_testing)
      end

      it 'validators should not have removed field' do
        expect(Person._validators).to_not include(:remove_testing)
      end
    end
  end
end
