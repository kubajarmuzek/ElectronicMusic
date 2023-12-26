;;; ***************************;;; * DEFTEMPLATES & DEFFACTS *;;; ***************************(deftemplate UI-state   (slot id (default-dynamic (gensym*)))   (slot display)   (slot relation-asserted (default none))   (slot response (default none))   (slot response2 (default none))   (multislot valid-answers)   (slot state (default middle)))   (deftemplate state-list   (slot current)   (multislot sequence))  (deffacts startup   (state-list))   ;;;****************;;;* STARTUP RULE *;;;****************(defrule system-banner ""  =>    (assert (UI-state (display "Welcome to Electronic music expert system")                    (relation-asserted start)                    (state initial)                    (valid-answers))));;;***************;;;* QUERY RULES *;;;***************(defrule determine-genre ""   (logical (start))   =>   (assert (UI-state (display "What music genre do you like?")                     (relation-asserted genre)                     (response No)                     (valid-answers rap rock))))   (defrule determine-kanye-west ""   (logical (genre rap))   =>   (assert (UI-state (display "Kanye West - 808s & Heartbreak")                     (relation-asserted kanye-west)                     (response Give_me_some_nice_hip_hop_beats)                     (valid-answers Give_me_some_nice_hip_hop_beats Come_on_i_want_some_REAL_rap_music))))(defrule determine-nujabes ""   (or (kanye-west Give_me_some_nice_hip_hop_beats)       (dj-shadow Im_liking_these_instrumental_beats_more_please))   =>   (assert (UI-state (display "Nujabes - Metaphorical Music")                     (relation-asserted nujabes)                     (response Stranger_Wonkier)                     (valid-answers Stranger_Wonkier I_need_more_of_these_lush_organic_sounds))))(defrule determine-girl-talk ""    (logical (kanye-west Come_on_i_want_some_REAL_rap_music))    =>    (assert (UI-state (display "Girl Talk - Feed the Animals")                     (relation-asserted girl-talk)                     (response No)                     (valid-answers Whoa_sampling_is_cool_more_like_this))))(defrule determine-the-avalanches ""   (logical (girl-talk Whoa_sampling_is_cool_more_like_this))   =>   (assert (UI-state (display "The Avalanches - Since I left You")                     (relation-asserted the-avalanches)                     (response More_sampling_with_a_hip_hop_vibe_to_it)                     (valid-answers More_sampling_with_a_hip_hop_vibe_to_it Darker_sadder_the_samples_could_messed_with_a_little_more))))(defrule determine-dj-shadow ""    (logical (the-avalanches More_sampling_with_a_hip_hop_vibe_to_it))    =>        (assert (UI-state (display "Dj Shadow - Endtroducing")                     (relation-asserted dj-shadow)                     (response Im_liking_these_instrumental_beats_more_please)                     (valid-answers Im_liking_these_instrumental_beats_more_please))))(defrule determine-tokimonsta ""    (or (nujabes Stranger_Wonkier)        (burial Happier_lighter_Focus_on_beats_not_the_vocals)        (the-knife Take_out_the_vocals_Focus_it))    =>        (assert (UI-state (display "TOKiMONSTA - Midnight Menu")                     (relation-asserted tokimonsta)                     (response Keep_the_beats_but_make_it_dark_and_operatic)                     (valid-answers Even_stranger_Even_Wonkier Keep_the_beats_but_make_it_dark_and_operatic I_like_those_beats_What_if_they_were_a_bit_spaced_out I_can_deal_with_the_weird_parts_I_think_Im_ready_for_the_classics))))(defrule determine-flying-lotus ""    (or (tokimonsta Even_stranger_Even_Wonkier)        (aphex-twin That_sounds_dated_Something_more_recent))    =>        (assert (UI-state (display "Flying Lotus - Cosmogramma")                     (relation-asserted flying-lotus)                     (response I_want_this_but_in_a_jungle)                     (valid-answers I_want_this_but_in_a_jungle))))(defrule determine-burial ""    (or (tokimonsta Keep_the_beats_but_make_it_dark_and_operatic)        (the-avalanches Darker_sadder_the_samples_could_messed_with_a_little_more))    =>        (assert (UI-state (display "Burial - Untrue")                     (relation-asserted burial)                     (response Happier_lighter_Focus_on_beats_not_the_vocals)                     (valid-answers Happier_lighter_Focus_on_beats_not_the_vocals Drop_the_samples_keep_the_nice_beats_and_dark_atmosphere))))(defrule determine-massive-attack ""    (logical (burial Drop_the_samples_keep_the_nice_beats_and_dark_atmosphere))    =>    (assert (UI-state (display "Massive Attack - Mezzanine")                     (relation-asserted massive-attack)                     (response I_liked_the_feel_of_Burial_a_little_better)                     (valid-answers I_liked_the_feel_of_Burial_a_little_better))))(defrule determine-lone ""    (logical (flying-lotus I_want_this_but_in_a_jungle))    =>    (assert (UI-state (display "Lone - Galaxy Garden")                     (relation-asserted lone)                     (response I_love_the_strange_vocals_that_a_few_of_the_tracks_had_And_the_drums)                     (valid-answers I_love_the_strange_vocals_that_a_few_of_the_tracks_had_And_the_drums Rainforest_music_but_slightly_less_crazy))))(defrule determine-machinedrum ""    (or (lone I_love_the_strange_vocals_that_a_few_of_the_tracks_had_And_the_drums)        (aphex-twin These_complex_beats_are_awesome_can_they_get_wider))    =>    (assert (UI-state (display "Machinedrum - Room(s)")                     (relation-asserted machinedrum)                     (response Those_drums_10_times_louder_10_times_crazier)                     (valid-answers Those_drums_10_times_louder_10_times_crazier))))(defrule determine-venetian-snares ""    (logical (machinedrum Those_drums_10_times_louder_10_times_crazier))    =>    (assert (UI-state (display "Venetian Snares - Rossz Csilag Alatt Szuletett")                     (relation-asserted venetian-snares)                     (response Calm_down_those_drums_I_like_the_orchestral_samples_though)                     (valid-answers Calm_down_those_drums_I_like_the_orchestral_samples_though))))(defrule determine-the-future-sound-of-london ""    (or (lone Rainforest_music_but_slightly_less_crazy)        (orbital More))     =>    (assert (UI-state (display "The Future Sound of London - Lifeforms")                     (relation-asserted the-future-sound-of-london)                     (response I_think_Im_ready_for_some_ambient_now)                     (valid-answers I_think_Im_ready_for_some_ambient_now))))(defrule determine-global-communication ""    (or (the-future-sound-of-london I_think_Im_ready_for_some_ambient_now)        (orbital I_liked_On_ON))    =>    (assert (UI-state (display "Global Communication - 76:14")                     (relation-asserted global-communication)                     (response even_more_ambient)                     (valid-answers even_more_ambient))))(defrule determine-brian-eno1 ""    (logical (global-communication even_more_ambient))    =>    (assert (UI-state (display "Brian Eno - Ambient 2: The Plateaux of Mirror")                     (relation-asserted brian-eno1)                     (response this_album_is_to_busy_for_me)                     (valid-answers This_album_is_to_busy_for_me))))(defrule determine-boards-of-canada ""    (or (tokimonsta I_like_those_beats_What_if_they_were_a_bit_spaced_out)        (tycho Make_it_stranger_I_want_to_listen_to_educational_film_from_the_eighties))    =>    (assert (UI-state (display "Boards of Canada - Music has the Right to Children")                     (relation-asserted boards-of-canada)                     (response I_want_something_more_electric_feeling)                     (valid-answers I_want_something_more_electric_feeling))))(defrule determine-aphex-twin ""    (or (boards-of-canada I_want_something_more_electric_feeling )        (autechre Cool_I_guess_electronic_music_isnt_just_talentless_button_pushing_More_like_this)        (radiohead I_actually_liked_the_drums_and_bleeps_they_had_going_on_More_of_that))    =>    (assert (UI-state (display "Aphex Twin - Selected Ambient Works / Aphex Twin - Drukqs")                     (relation-asserted aphex-twin)                     (response That_sounds_dated_Something_more_recent)                     (valid-answers That_sounds_dated_Something_more_recent These_complex_beats_are_awesome_can_they_get_wider                     I_cant_wrap_my_head_around_these_drums_but_I_like_the_rest_of_it Lets_get_a_steady_beat_on_that))))(defrule determine-orb ""    (or (aphex-twin Lets_get_a_steady_beat_on_that)         (klaus-schulze Lets_get_a_steady_beat_on_that))    =>    (assert (UI-state (display "Orb - The Orb's Adventures Beyond the Ultraworld")                     (relation-asserted orb)                     (response Something_a_little_bit_less_ambient_maybe)                     (valid-answers Something_a_little_bit_less_ambient_maybe))))(defrule determine-orbital ""    (or (orb Something_a_little_bit_less_ambient_maybe)         (daft-punk I_dont_ever_want_to_stop_dancing))    =>    (assert (UI-state (display "The Future Sound of London - Accelerator / Orbital- Brown Album")                     (relation-asserted orbital)                     (response More)                     (valid-answers More Focus_on_fast_hard_hitting_drums I_want_to_feel_like_Im_on_drugs I_dont_ever_want_to_stop_dancing                      Mix_the_two I_liked_On_ON Less_melody_more_subtle))))(defrule determine-goldie ""    (or (orbital Focus_on_fast_hard_hitting_drums)         (shpongle Focus_on_fast_hard_hitting_drums))    =>    (assert (UI-state (display "Goldie - Timeless")                     (relation-asserted goldie)                     (response This_but_I_want_to_feel_like_Im_exploring_a_frozen_wasteland)                     (valid-answers This_but_I_want_to_feel_like_Im_exploring_a_frozen_wasteland))))(defrule determine-klaus-schulze ""    (or (aphex-twin I_cant_wrap_my_head_around_these_drums_but_I_like_the_rest_of_it)        (kashiwa-daisuke I_like_the_more_ambient_parts)        (neu This_but_electronic)        (fuck-buttons More_quiter_though)        (manuel-gottsching Fully_electronic_now))    =>    (assert (UI-state (display "Klaus Schulze - Timewind / Tangerine Dream - Phaedra")                     (relation-asserted klaus-schulze)                     (response More_ambient_stuff)                     (valid-answers More_ambient_stuff Lets_get_a_steady_beat_on_that More_drums This_style_of_synths_but_shorter_songs_and_carelessly_happy))))(defrule determine-shpongle ""    (or (orbital I_want_to_feel_like_Im_on_drugs)        (daft-punk Fun_stuff_but_could_it_get_a_little_more_tribal))    =>    (assert (UI-state (display "Shpongle - Are You Shpongled?")                     (relation-asserted shpongle)                     (response Focus_on_fast_hard_hitting_drums)                     (valid-answers Focus_on_fast_hard_hitting_drums I_like_the_careless_fun_music_I_can_kid_of_dance_to This_but_I_want_to_feel_like_Im_exploring_a_frozen_wasteland))))(defrule determine-daft-punk ""    (or (jon-hopkins I_liked_the_heavier_bits_Collider_for_example)        (orbital I_dont_ever_want_to_stop_dancing))    =>    (assert(UI-state (display "Daft Punk - Discovery" )                    (relation-asserted daft-punk)                    (response DIRTIER)                    (valid-answers DIRTIER I_like_the_careless_fun_music_I_can_kid_of_dance_to))))(defrule determine-jon-hopkins ""    (logical (orbital Mix_the_two))    =>    (assert (UI-state (display "Jon Hopkins - Immunity")                     (relation-asserted jon-hopkins)                     (response I_liked_the_heavier_bits_Collider_for_example)                     (valid-answers I_liked_the_heavier_bits_Collider_for_example I_liked_the_piano_but_not_the_heavy_parts))))(defrule determine-autechre ""    (or (klaus-schulze More_drums)        (kashiwa-daisuke I_like_the_glitchy_drums)        (radiohead I_actually_liked_the_drums_and_bleeps_they_had_going_on_More_of_that))    =>    (assert(UI-state (display "Autechre - Amber" )                    (relation-asserted autechre)                    (response  Cool_I_guess_electronic_music_isnt_just_talenties_button_pushing_More_like_this)                    (valid-answers Cool_I_guess_electronic_music_isnt_just_talentless_button_pushing_More_like_this))))(defrule determine-radiohead1 ""    (logical (genre rock))    =>    (assert(UI-state (display "Radiohead - Ok computer" )                    (relation-asserted radiohead1)                    (response Cool_But_thats_basically_just_rock_music)                    (valid-answers Cool_But_thats_basically_just_rock_music))))(defrule determine-radiohead ""    (logical (radiohead1 Cool_But_thats_basically_just_rock_music))    =>    (assert(UI-state (display "Radiohead - Kid A" )                    (relation-asserted radiohead)                    (response  Cool_but_Im_not_quite_ready_to_lose_the_guitars_quite_yet)                    (valid-answers Weird_but_good_Maybe_more_electronics_but_I_still_want_vocals Cool_but_Im_not_quite_ready_to_lose_the_guitars_quite_yet                     I_actually_liked_the_drums_and_bleeps_they_had_going_on_More_of_that Even_this_is_too_much_electronic_for_me))))(defrule determine-the-knife ""    (logical (radiohead Weird_but_good_Maybe_more_electronics_but_I_still_want_vocals))    =>    (assert(UI-state (display "The Knife - Silent Shout" )                    (relation-asserted the-knife)                    (response Too_weird)                    (valid-answers Too_weird Take_out_the_vocals_Focus_it))))(defrule determine-darkside ""    (or (the-knife Too_weird)        (radiohead Cool_but_Im_not_quite_ready_to_lose_the_guitars_quite_yet))    =>    (assert(UI-state (display "Darkside - Psycho" )                    (relation-asserted darkside)                    (response I_like_this_We_can_lose_the_guitars_and_stuff_Im_ready)                    (valid-answers I_like_this_We_can_lose_the_guitars_and_stuff_Im_ready More_of_the_same_but_I_think_Im_ready_for_electronic_music_now Where_can_I_go_from_here))))(defrule determine-nicolas-jarr ""    (logical (darkside More_of_the_same_but_I_think_Im_ready_for_electronic_music_now))    =>    (assert(UI-state (display "Nicolas Jarr - Space is Only Noise" )                    (relation-asserted nicolas-jarr)                    (response More_of_vocal_focus)                    (valid-answers More_of_vocal_focus This_is_much_to_busy_and_melodius_for_my_tastes))))(defrule determine-bonobo ""    (or (nujabes I_need_more_of_these_lush_organic_sounds)        (darkside Where_can_I_go_from_here))    =>    (assert(UI-state (display "Bonobo - Black Sands" )                    (relation-asserted bonobo)                    (response Chill_it_out)                    (valid-answers Chill_it_out))))(defrule determine-tycho ""    (logical (bonobo Chill_it_out))    =>    (assert(UI-state (display "Tycho - Dive" )                    (relation-asserted tycho)                    (response Make_it_stranger_I_want_to_listen_to_educational_film_from_the_eighties)                    (valid-answers Make_it_stranger_I_want_to_listen_to_educational_film_from_the_eighties))))(defrule determine-godspeed-you-black-emperor ""    (logical (radiohead Even_this_is_too_much_electronic_for_me))    =>    (assert(UI-state (display "Godspeed You! Black Emperor - Lift Your Skinny Fists Like Antenas to Heaven" )                    (relation-asserted godspeed-you-black-emperor)                    (response I_love_those_buildups_I_Could_try_some_electronic_music_that_does_that)                    (valid-answers I_love_those_buildups_I_Could_try_some_electronic_music_that_does_that I_think_I_could_handle_that_but_way_more_minimal I_like_the_post_rock_song_structure_and_scale))))(defrule determine-fuck-buttons ""    (logical (godspeed-you-black-emperor I_love_those_buildups_I_Could_try_some_electronic_music_that_does_that))    =>    (assert(UI-state (display "Fuck Buttons - Tarot Sport" )                    (relation-asserted fuck-buttons)                    (response More_quiter_though)                    (valid-answers More_quiter_though))))(defrule determine-kashiwa_daisuke ""    (logical (godspeed-you-black-emperor I_like_the_post_rock_song_structure_and_scale))    =>    (assert(UI-state (display "Kashiwa Daisuke - Program Music" )                    (relation-asserted kashiwa-daisuke)                    (response I_like_the_glitchy_drums)                    (valid-answers I_like_the_glitchy_drums I_like_the_more_ambient_parts))))(defrule determine-neu ""    (logical (godspeed-you-black-emperor I_think_I_could_handle_that_but_way_more_minimal))    =>    (assert(UI-state (display "Neu! - Neu!" )                    (relation-asserted neu)                    (response This_but_electronic)                    (valid-answers This_but_electronic More_electronic_influence))))(defrule determine-manuel-gottsching ""    (logical (neu More_electronic_influence))    =>    (assert(UI-state (display "Manuel Gottsching - e2 - e4 " )                    (relation-asserted manuel-gottsching)                    (response Fully_electronic_now)                    (valid-answers Fully_electronic_now))));;;****************;;;* RESULT ALBUMS *;;;****************(defrule determine-villalobos ""    (or (orbital Less_melody_more_subtle)        (nicolas-jarr This_is_much_to_busy_and_melodius_for_my_tastes))    =>    (assert (UI-state (display "Villalobos - Alcachofa")                     (state final))))(defrule determine-helios ""    (logical (jon-hopkins I_liked_the_piano_but_not_the_heavy_parts))    =>    (assert (UI-state (display "Helios - Eingya")                     (state final))))(defrule determine-sasha ""    (or (goldie This_but_I_want_to_feel_like_Im_exploring_a_frozen_wasteland)        (shpongle This_but_I_want_to_feel_like_Im_exploring_a_frozen_wasteland)        (shpongle I_like_the_careless_fun_music_I_can_kid_of_dance_to)        (daft-punk I_like_the_careless_fun_music_I_can_kid_of_dance_to))    =>    (assert (UI-state (display "Sasha & John Digweed - Northern Exposure")                     (state final))))(defrule determine-justice ""    (logical (daft-punk DIRTIER))    =>    (assert (UI-state (display "Justice - Cross")                     (state final))))(defrule determine-mort-garrison ""    (logical (klaus-schulze This_style_of_synths_but_shorter_songs_and_carelessly_happy))    =>    (assert (UI-state (display "Mort Garrison - Plantasia")                     (state final))))(defrule determine-brian-eno2 ""    (logical (brian-eno1 This_album_is_to_busy_for_me))    =>    (assert (UI-state (display "Brian Eno - Ambient 1: Music for Airports")                     (state final))))(defrule determine-kashiwa-daisuke ""    (logical (venetian-snares Calm_down_those_drums_I_like_the_orchestral_samples_though))    =>    (assert (UI-state (display "Kashiwa Daisuke - Program music")                     (state final))))(defrule determine-james-blake    (or (burial Drop_the_samples_keep_the_nice_beats_and_dark_atmosphere)        (nicolas-jarr More_of_vocal_focus)        (darkside I_like_this_We_can_lose_the_guitars_and_stuff_Im_ready))    =>    (assert (UI-state (display "James Blake - James Blake")                     (state final)                    )))(defrule no-repairs ""   (declare (salience -10))   (logical (UI-state (id ?id)))   (state-list (current ?id))   =>   (assert (UI-state (display "Error occured.")                     (state final))))                     ;;;*************************;;;* GUI INTERACTION RULES *;;;*************************(defrule ask-question   (declare (salience 5))      (UI-state (id ?id))      ?f <- (state-list (sequence $?s&:(not (member$ ?id ?s))))                =>      (modify ?f (current ?id)              (sequence ?id ?s))      (halt))(defrule handle-next-no-change-none-middle-of-chain   (declare (salience 10))      ?f1 <- (next ?id)   ?f2 <- (state-list (current ?id) (sequence $? ?nid ?id $?))                         =>         (retract ?f1)      (modify ?f2 (current ?nid))      (halt))(defrule handle-next-response-none-end-of-chain   (declare (salience 10))      ?f <- (next ?id)   (state-list (sequence ?id $?))      (UI-state (id ?id)             (relation-asserted ?relation))                      =>         (retract ?f)   (assert (add-response ?id)))   (defrule handle-next-no-change-middle-of-chain   (declare (salience 10))      ?f1 <- (next ?id ?response)   ?f2 <- (state-list (current ?id) (sequence $? ?nid ?id $?))        (UI-state (id ?id) (response ?response))      =>         (retract ?f1)      (modify ?f2 (current ?nid))      (halt))(defrule handle-next-change-middle-of-chain   (declare (salience 10))      (next ?id ?response)   ?f1 <- (state-list (current ?id) (sequence ?nid $?b ?id $?e))        (UI-state (id ?id) (response ~?response))      ?f2 <- (UI-state (id ?nid))      =>            (modify ?f1 (sequence ?b ?id ?e))      (retract ?f2))   (defrule handle-next-response-end-of-chain   (declare (salience 10))      ?f1 <- (next ?id ?response)      (state-list (sequence ?id $?))      ?f2 <- (UI-state (id ?id)                    (response ?expected)                    (relation-asserted ?relation))                   =>         (retract ?f1)   (if (neq ?response ?expected)      then      (modify ?f2 (response ?response)))         (assert (add-response ?id ?response)))   (defrule handle-add-response   (declare (salience 10))      (logical (UI-state (id ?id)                      (relation-asserted ?relation)))      ?f1 <- (add-response ?id ?response)                   =>         (str-assert (str-cat "(" ?relation " " ?response ")"))      (retract ?f1))   (defrule handle-add-response-none   (declare (salience 10))      (logical (UI-state (id ?id)                      (relation-asserted ?relation)))      ?f1 <- (add-response ?id)                   =>         (str-assert (str-cat "(" ?relation ")"))      (retract ?f1))   (defrule handle-prev   (declare (salience 10))         ?f1 <- (prev ?id)      ?f2 <- (state-list (sequence $?b ?id ?p $?e))                   =>      (retract ?f1)      (modify ?f2 (current ?p))      (halt))   