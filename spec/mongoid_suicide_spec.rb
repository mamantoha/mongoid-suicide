require 'spec_helper'

describe Mongoid::Suicide do
  describe "#remove_field" do
    context "remove accessors" do

      before do
        Person.field(:remove_testing, type: String)
      end

      let(:person) do
        Person.new
      end

      before(:each) do
        Person.remove_field(:remove_testing)
      end

      it "removes field getter" do
        expect {
          person.remove_testing
        }.to raise_error(NoMethodError)
      end

      it "removes field setter" do
        expect {
          person.remove_testing = 'test'
        }.to raise_error(NoMethodError)
      end

      it "removes field _before_type_cast getter" do
        expect {
          person.remove_testing_before_type_cast
        }.to raise_error(NoMethodError)
      end

      it "removes field check method" do
        expect {
          person.remove_testing?
        }.to raise_error(NoMethodError)
      end

      it "removes field from fields" do
        expect(Person.fields).to_not include("remove_testing")
      end
    end

    context "remove accessors for aliasing field" do

      before do
        Person.field(:remove_testing, type: String, as: :rt)
      end

      let(:person) do
        Person.new
      end

      before(:each) do
        Person.remove_field(:remove_testing)
      end

      it "removes field getter" do
        expect {
          person.rt
        }.to raise_error(NoMethodError)
      end

      it "removes field setter" do
        expect {
          person.rt = 'test'
        }.to raise_error(NoMethodError)
      end

      it "removes field _before_type_cast getter" do
        expect {
          person.rt_before_type_cast
        }.to raise_error(NoMethodError)
      end

      it "removes field check method" do
        expect {
          person.rt?
        }.to raise_error(NoMethodError)
      end

      it "removes field from aliased_fields" do
        expect(Person.aliased_fields).to_not include("rt")
      end

    end

    context "remove translations" do

      before do
        Person.field(:remove_testing, type: String, localize: true)
      end

      let(:person) do
        Person.new
      end

      before(:each) do
        Person.remove_field(:remove_testing)
      end

      it "removes field translation getter" do
        expect {
          person.remove_testing_translations
        }.to raise_error(NoMethodError)
      end

      it "removes field translation setter" do
        expect {
          person.remove_testing_translations = { de: 'test' }
        }.to raise_error(NoMethodError)
      end

      it "removes field translation getter alias" do
        expect {
          person.remove_testing_t
        }.to raise_error(NoMethodError)
      end

      it "removes field translation setter alias" do
        expect {
          person.remove_testing_t = { de: 'test' }
        }.to raise_error(NoMethodError)
      end

      it "localized_fields should not have removed field" do
        expect(person.localized_fields).to_not include('remove_testing')
      end

    end

    context "remove translations for aliasing field" do

      before do
        Person.field(:remove_testing, type: String, localize: true, as: :rt)
      end

      let(:person) do
        Person.new
      end

      before(:each) do
        Person.remove_field(:remove_testing)
      end

      it "removes field translation getter" do
        expect {
          person.rt_translations
        }.to raise_error(NoMethodError)
      end

      it "removes field translation setter" do
        expect {
          person.rt_translations = { de: 'test' }
        }.to raise_error(NoMethodError)
      end

      it "removes field translation getter alias" do
        expect {
          person.rt_t
        }.to raise_error(NoMethodError)
      end

      it "removes field translation setter alias" do
        expect {
          person.rt_t = { de: 'test' }
        }.to raise_error(NoMethodError)
      end

    end

    context "remove dirty change methods" do

      before do
        Person.field(:remove_testing, type: String)
      end

      let(:person) do
        Person.new
      end

      before(:each) do
        Person.remove_field(:remove_testing)
      end

      it "removes the dirty change accessor" do
        expect {
          person.remove_testing_change
        }.to raise_error(NoMethodError)
      end

      it "removes the dirty change check" do
        expect {
          person.remove_testing_changed?
        }.to raise_error(NoMethodError)
      end

      it "removes the dirty change flag" do
        expect {
          person.remove_testing_will_change!
        }.to raise_error(NoMethodError)
      end

      it "removes the dirty default change check" do
        expect {
          person.remove_testing_changed_from_default?
        }.to raise_error(NoMethodError)
      end

      it "removes the dirty change previous value accessor" do
        expect {
          person.remove_testing_was
        }.to raise_error(NoMethodError)
      end

      it "removes the dirty change reset" do
        expect {
          person.reset_remove_testing!
        }.to raise_error(NoMethodError)
      end

      it "removes the dirty change reset to default" do
        expect {
          person.reset_remove_testing_to_default!
        }.to raise_error(NoMethodError)
      end

    end

    context "remove dirty change methods for aliasing field" do

      before do
        Person.field(:remove_testing, type: String, as: :rt)
      end

      let(:person) do
        Person.new
      end

      before(:each) do
        Person.remove_field(:remove_testing)
      end

      it "removes the dirty change accessor" do
        expect {
          person.rt_change
        }.to raise_error(NoMethodError)
      end

      it "removes the dirty change check" do
        expect {
          person.rt_changed?
        }.to raise_error(NoMethodError)
      end

      it "removes the dirty change flag" do
        expect {
          person.rt_will_change!
        }.to raise_error(NoMethodError)
      end

      it "removes the dirty default change check" do
        expect {
          person.rt_changed_from_default?
        }.to raise_error(NoMethodError)
      end

      it "removes the dirty change previous value accessor" do
        expect {
          person.rt_was
        }.to raise_error(NoMethodError)
      end

      it "removes the dirty change reset" do
        expect {
          person.reset_rt!
        }.to raise_error(NoMethodError)
      end

      it "removes the dirty change reset to default" do
        expect {
          person.reset_rt_to_default!
        }.to raise_error(NoMethodError)
      end

    end

    context "remove validators" do
      before do
        Person.field(:remove_testing, type: String)
        Person.validates(:remove_testing, uniqueness: true)
      end

      before(:each) do
        Person.remove_field(:remove_testing)
      end

      it "validators should not have removed field" do
        expect(Person._validators).to_not include(:remove_testing)
      end
    end
  end

end
