require 'agnostic_slugs/slug'

module AgnosticSlugs
  describe Slug do
    describe '#to_s' do

      subject { Slug.new(input, counter).to_s }
      let(:counter) { 1 }

      describe 'simple input' do
        let(:input) { 'Simple string' }
        it { should eq('simple-string') }
      end

      describe 'accented input' do
        let(:input) { 'Hellø Wårld' }
        it { should eq('hello-warld') }
      end

      describe 'punctuations' do
        let(:input) { 'Hello world!' }
        it { should eq('hello-world') }
      end

      describe 'with a counter' do
        let(:input) { 'hello-world' }
        let(:counter) { 2 }
        it { should eq('hello-world-2') }
      end

      describe 'with leading and trailing spaces' do
        let(:input) { '  Hello  world  ' }
        it { should eq('hello-world') }
      end
    end

    describe '#next' do
      it 'should increment counter' do
        actual = Slug.new('foo').next.counter
        expect(actual).to eq(2)
      end

      it 'should be immutable' do
        slug = Slug.new('foo')
        next_slug = slug.next

        expect(slug.counter).to eq(1)
      end
    end
  end
end
