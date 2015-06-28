class Rating < ActiveRecord::Base

  acts_as_votable

  belongs_to :user
  belongs_to :game

  validates_uniqueness_of :user_id, scope: :game_id

  validates :user, :game, :framerate, :resolution, :optimization, presence: true
  validates :dlc, :bugs, :settings, :controls, :servers, :mods, presence: true

  # TODO: Pull out of this class
  CATEGORY_WEIGHTS = {
    framerate: 8, resolution: 7, optimization: 9, mods: 3,
    servers: 5, dlc: 4, bugs: 6, settings: 2, controls: 1
  }

  # TODO: Move these enums elsewhere, they're clogging up the class.
  enum framerate: {
    :'May be capped to 30 FPS' => 0,
    :'May be capped to 60 FPS' => 1,
    :'60 FPS capped' => 2,
    :'60 FPS capped, potentially limitless' => 3,
    :'Limitless (like your dreams)' => 4
  }

  enum resolution: {
    :'Does not support 1080p' => 0,
    :'Limited 1080p support' => 1,
    :'Supports 1080p' => 2,
    :'Supports 1080p with multi-monitor support' => 3,
    :'4k and beyond' => 4
  }

  enum optimization: {
    Poor: 0,
    Passable: 1,
    Good: 2,
    Great: 3,
    Glorious: 4
  }

  enum mods: {
    :'No support/May result in online bans' => 0,
    :'Unofficial support/Heavily restricted' => 1,
    :'Unofficial support, may be limited to cosmetic changes' => 2,
    :'Official support, modding tools are limited' => 3,
    :'Complete support, modding tools close to tools developers used' => 4
  }

  enum servers: {
    :'Unstable servers. Likely to shut down early.' => 0,
    :'Partially stable servers.' => 1,
    :'Servers unstable at high volume.' => 2,
    :'Acceptable servers' => 3,
    :'Reliable servers or dedicated server software available (or Single Player)' => 4
  }

  enum dlc: {
    :'Day 1 DLC, affects game balance' => 0,
    :'Day 1 DLC, cosmetic only' => 1,
    :'No Day 1 DLC' => 2,
    :'Day 1 DLC is free and provides useful content' => 3,
    :'Large content patches in the style of old expansions or no DLC' => 4
  }

  enum bugs: {
    :'Constant game breaking bugs. Unplayable' => 0,
    :'Excessively buggy, mostly playable' => 1,
    :'Playable but often encounter bugs' => 2,
    :'A few bugs here and there, but rarely do they affect enjoyment' => 3,
    :'Rare bugs. Possible to go entire game without encountering' => 4
  }

  enum settings: {
    :'No settings to change' => 0,
    :'Limited settings, no video options' => 1,
    :'Preset video settings only (Low, Medium, High)' => 2,
    :'Acceptable video settings, can change most things' => 3,
    :'Complete video settings, can change and turn off everything' => 4
  }

  enum controls: {
    :'Cannot configure controls. Controls still displayed as console buttons in in interface' => 0,
    :'Cannot configure controls. Gamepad support' => 1,
    :'Sensitivity options, can remap some keys' => 2,
    :'Can remap most keys, gamepad support, sensitivity controls' => 3,
    :'Can use a range of devices, remap all keys, have alternate control sets, and set sensitivity' => 4
  }

  def self.ranking(score)
    case score
    when 0..35
      :p
    when 36..71
      :c
    when 71..107
      :m
    when 108..143
      :r
    when 143..180
      :g
    else
      :no_ratings
    end
  end

  def self.visible
    all.select do |rating|
      !rating.hidden?
    end
  end

  def hidden?
    score < -3
  end

  def score
    cached_votes_score
  end

  def get_stat(stat)
    self[stat]
  end

  def get_rounded_stat(stat)
    get_stat(stat).round
  end

  def ranking
    Rating.ranking(total)
  end

  def total
    total = 0
    CATEGORY_WEIGHTS.each do |category, weight|
      total += self[category] * weight
    end

    total
  end

end
