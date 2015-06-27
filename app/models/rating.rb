class Rating < ActiveRecord::Base

  belongs_to :user
  belongs_to :game

  validates :user, presence: true
  validates :game, presence: true

  validates :framerate,    presence: true
  validates :resolution,   presence: true
  validates :optimization, presence: true
  validates :mods,         presence: true
  validates :servers,      presence: true
  validates :dlc,          presence: true
  validates :bugs,         presence: true
  validates :settings,     presence: true
  validates :controls,     presence: true

  enum framerate: {
    :"May be capped to 30 FPS" => 0,
    :"May be capped to 60 FPS" => 1,
    :"60 FPS capped" => 2,
    :"60 FPS capped, potentially limitless" => 3,
    :"Limitless (like your dreams)" => 4,
  }

  enum resolution: {
    :"Does not support 1080p" => 0,
    :"Limited 1080p support" => 1,
    :"Supports 1080p" => 2,
    :"Supports 1080p" => 3,
    :"4k and beyond" => 4,
  }

  enum optimization: {
    :"Poor" => 0,
    :"Passable" => 1,
    :"Good" => 2,
    :"Great" => 3,
    :"Glorious!" => 4,
  }

  enum mods: {
    :"No support/May result in online bans" => 0,
    :"Unofficial support/Heavily restricted" => 1,
    :"Unofficial support, may be limited to cosmetic changes" => 2,
    :"Official support, modding tools are limited" => 3,
    :"Complete support, modding tools close to tools developers used" => 4,
  }

  enum servers: {
    :"Unstable servers. Likely to shut down early." => 0,
    :"Partially stable servers." => 1,
    :"Servers unstable at high volume." => 2,
    :"Acceptable servers" => 3,
    :"Reliable servers or dedicated server software available" => 4,
  }

  enum dlc: {
    :"Day 1 DLC, affects online game balance" => 0,
    :"Day 1 DLC, cosmetic only" => 1,
    :"No Day 1 DLC" => 2,
    :"Day 1 DLC is free and provides useful content" => 3,
    :"Repeated large content patches that are free or very cheap, equivalent of old-style expansions" => 4,
  }

  enum bugs: {
    :"Constant game breaking bugs. Unplayable" => 0,
    :"Excessively buggy, mostly playable" => 1,
    :"Playable but often encounter bugs" => 2,
    :"A few bugs here and there, but rarely do they affect enjoyment" => 3,
    :"Rare bugs. Possible to go entire game without encountering" => 4,
  }

  enum settings: {
    :"No settings to cange" => 0,
    :"Limited settings, no video options" => 1,
    :"Preset video settings only (Low, Medium, High)" => 2,
    :"Acceptable video settings, can change most things" => 3,
    :"Complete video settings, can change and turn off everything" => 4,
  }

  enum controls: {
    :"Cannot configure controls. Controls still displayed as console buttons in in interface" => 0,
    :"Cannot configure controls. Gamepad support" => 1,
    :"Sensitivity options, can remap some keys" => 2,
    :"Can remap most keys, gamepad support, sensitivity controls" => 3,
    :"Can use a range of devises, remap all keys, have alternate control sets, and set sensitivity" => 4,
  }

  def self.ranking score
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

  def get_stat stat
    self[stat]
  end

  def ranking
    Rating.ranking(total)
  end

  def total
    total = 0
    total += self[:framerate]     * 8
    total += self[:resolution]    * 7
    total += self[:optimization]  * 9
    total += self[:mods]          * 3
    total += self[:servers]       * 5
    total += self[:dlc]           * 4
    total += self[:bugs]          * 6
    total += self[:settings]      * 2
    total += self[:controls]      * 1

    return total
  end

end