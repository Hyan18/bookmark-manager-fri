require 'bookmark'

describe 'Bookmark' do

  let(:bookmarks) {Bookmarks.new}

  describe "#all" do
    it "should return a list of bookmarks" do
      connection = PG.connect(dbname: 'bookmark_manager_test')
   
      bookmark = Bookmark.create(url: "http://www.makersacademy.com", title: "Makers Academy")
      Bookmark.create(url: "http://www.destroyallsoftware.com", title: "Destroy All Software")
      Bookmark.create(url: "http://www.google.com", title: "Google")
   
      bookmarks = Bookmark.all
   
      expect(bookmarks.length).to eq 3
      expect(bookmarks.first).to be_a Bookmark
      expect(bookmarks.first.id).to eq bookmark.id
      expect(bookmarks.first.title).to eq 'Makers Academy'
      expect(bookmarks.first.url).to eq 'http://www.makersacademy.com'
     end
   end

   describe "#create" do
    it "should create a new bookmark" do
      bookmark = Bookmark.create(url: 'http://www.testbookmark.com', title: 'Test Bookmark')
      persisted_data = PG.connect(dbname: 'bookmark_manager_test').query("SELECT * FROM bookmarks WHERE id = #{bookmark.id};")
  
      expect(bookmark).to be_a Bookmark
      expect(bookmark.id).to eq persisted_data.first['id']
      expect(bookmark.title).to eq 'Test Bookmark'
      expect(bookmark.url).to eq 'http://www.testbookmark.com'
    end

    it "does not create a new bookmark if the URL is not valid" do
      Bookmark.create(url: 'invalid bookmark', title: 'invalid bookmark')
      expect(Bookmark.all).to be_empty
    end
  end

  describe "#delete" do
    it "should delete an existing bookmark" do
      bookmark_to_delete = Bookmark.create(url: 'http://www.testbookmark.com', title: 'Test Bookmark')
      Bookmark.delete(id: bookmark_to_delete.id)

      expect(Bookmark.all.length).to eq 0
    end
  end

  describe "#update" do
    it "should update an existing bookmark" do
      bookmark = Bookmark.create(url: 'http://www.testbookmark.com', title: 'Test Bookmark')
      updated_bookmark = Bookmark.update(id: bookmark.id, url: 'new_url', title: 'Updated Test Bookmark')

      expect(updated_bookmark).to be_a Bookmark
      expect(updated_bookmark.id).to eq bookmark.id
      expect(updated_bookmark.url).to eq('new_url')
      expect(updated_bookmark.title).to eq('Updated Test Bookmark')
    end
  end

  describe "#find" do
    it "should return a bookmark" do
      bookmark = Bookmark.create(url: 'http://www.testbookmark.com', title: 'Test Bookmark')
      found_bookmark = Bookmark.find(id: bookmark.id)

      expect(found_bookmark).to be_a Bookmark
      expect(found_bookmark.id).to eq bookmark.id
      expect(found_bookmark.url).to eq(bookmark.url)
      expect(found_bookmark.title).to eq(bookmark.title)
    end
  end

  describe '#comments' do
    it 'returns a list of comments on the bookmark' do
      bookmark = Bookmark.create(title: 'Makers Academy', url: 'http://www.makersacademy.com')
      DatabaseConnection.query("INSERT INTO comments (id, text, bookmark_id) VALUES(1, 'Test comment', #{bookmark.id})")

      comment = bookmark.comments.first

      expect(comment['text']).to eq 'Test comment'
    end
  end

end
