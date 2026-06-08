class Club < ApplicationRecord
  has_one_attached :logo

  has_many :home_matches, class_name: "Match", foreign_key: "home_team_id"
  has_many :away_matches, class_name: "Match", foreign_key: "away_team_id"
  has_many :players
  belongs_to :league

  def matches
    Match.where("home_team_id = ? OR away_team_id = ?", id, id)
  end

  def matches_on(year = nil)
    return nil unless year

    matches.where(
      kicked_off_at: Date.new(year, 1, 1).in_time_zone.all_year
    )
  end

  def won?(match)
    match.winner == self
  end

  def lost?(match)
    match.loser == self
  end

  def draw?(match)
    match.draw?
  end

  def win_on(year)
    result_count(year, :won?)
  end

  def lost_on(year)
    result_count(year, :lost?)
  end

  def draw_on(year)
    result_count(year, :draw?)
  end

  def homebase
    "#{hometown}, #{country}"
  end

  private

  def result_count(year, result_method)
    matches_on(year).count do |match|
      send(result_method, match)
    end
  end
end