schema GameState
(
  Luminance(84, 336) pixels
)

schema PlayerMove
(
  Int8{-1, 0, 1} move
)

schema BreakoutConfig
(
  UInt32 level,
  UInt8{1:4} paddle_width,
  Float32 bricks_percent
)

concept ball_location : (Matrix(UInt32, 1, 2) location)
  is estimator
  follows input(GameState)

concept keep_paddle_under_ball : (PlayerMove)
  is classifier
  follows ball_location, input(GameState)

concept high_score : (PlayerMove)
  is classifier
  follows keep_paddle_under_ball, input(GameState)
  feeds output

curriculum ball_location_curriculum
  train ball_location
  with simulator breakout_simulator(BreakoutConfig):(GameState)
  objective ball_location_distance
    lesson no_bricks
      configure
        constrain bricks_percent with Float32{0.5},
        constrain level with UInt32{1},
        constrain paddle_width with UInt8{4}
      train
        from frame in breakout_simulator
        select frame
        send frame                        
      test
        from frame in breakout_simulator
        select frame
        send frame                        
      until
        minimize ball_location_distance

    lesson more_bricks follows no_bricks
      configure
        constrain bricks_percent with Float32{0.1:0.01:1.0},
        constrain level with UInt32{1:100},
        constrain paddle_width with UInt8{1:4}
      train
        from frame in breakout_simulator
        select frame
        send frame                        
      test
        from frame in breakout_simulator
        select frame
        send frame                        
      until
        minimize ball_location_distance
end

curriculum keep_paddle_under_ball_curriculum
  train keep_paddle_under_ball
  with simulator breakout_simulator(BreakoutConfig):(GameState)
  objective ball_paddle_distance
    lesson track_ball
      configure
        constrain bricks_percent with Float32{1.0},
        constrain level with UInt32{1:100},
        constrain paddle_width with UInt8{1:4}
      train
        from frame in breakout_simulator
        select frame
        send frame                        
      test
        from frame in breakout_simulator
        select frame
        send frame                        
      until
        minimize ball_paddle_distance
end

curriculum high_score_curriculum
  train high_score
  with simulator breakout_simulator(BreakoutConfig):(GameState)
  objective score
    lesson score_lesson
      configure
        constrain bricks_percent with Float32{1.0},
        constrain level with UInt32{1:100},
        constrain paddle_width with UInt8{1:4}
      train
        from frame in breakout_simulator
        select frame
        send frame                        
      test
        from frame in breakout_simulator
        select frame
        send frame                        
      until
        maximize score
end
