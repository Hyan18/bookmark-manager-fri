require 'database_connection'

describe DatabaseConnection do

  describe "#setup" do
    it "should set up a connection to a database via PG" do
      expect(PG).to receive(:connect).with(dbname: 'bookmark_manager_test')

      DatabaseConnection.setup('bookmark_manager_test')
    end

    it "should be a persistent connection" do
      connection = DatabaseConnection.setup('bookmark_manager_test')

      expect(DatabaseConnection.connection).to eq connection
    end
  end

  describe "#query" do
    it "executes a query via PG" do
      connection = DatabaseConnection.setup('bookmark_manager_test')

      expect(connection).to receive(:exec).with("SELECT * FROM bookmarks;")

      DatabaseConnection.query("SELECT * FROM bookmarks;")
    end
  end

end