class GroupNodeCollection
  include Mongoid::Document
  include RandomId
  include Nillable
  include Sluggable
  include Treeable
  
  DEFAULT_NAME = 'New Collection'
  
  POSTING_ANYONE = :anyone
  POSTING_MEMBERS  = :members
  POSTING_ADMINS = :admins
  POSTING_INHERIT = :inherit
  
  field :name, type: String, default: -> { self.class::DEFAULT_NAME }
  field :posting, type: Symbol, default: POSTING_MEMBERS
  
  validates :posting, inclusion: { in: [POSTING_ANYONE, POSTING_MEMBERS, POSTING_ADMINS, POSTING_INHERIT] }
  
  normalize_attribute :name, with: [:blank, :squish]
  
  embedded_in :group
  
  def posting
    if read_attribute(:posting) == POSTING_INHERIT
      if self.root?
        POSTING_ADMINS
      else
        self.root.posting
      end
    else
      super
    end
  end
end