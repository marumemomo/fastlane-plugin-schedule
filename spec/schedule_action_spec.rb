describe Fastlane::Actions::ScheduleAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The schedule plugin is working!")

      Fastlane::Actions::ScheduleAction.run(nil)
    end
  end
end
