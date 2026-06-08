module ClubDecorator
  def total_result_on(year = nil)
    year ||= Date.current.year

    "matches: #{matches_on(year).count} " \
    "won: #{win_on(year)} " \
    "lost: #{lost_on(year)} " \
    "draw: #{draw_on(year)}"
  end

  def players_average_age
    return 0 if players.empty?

    players.sum(&:age).to_f / players.size
  end
end