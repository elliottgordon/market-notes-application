desc "Fill the database tables with some sample data"
task({ sample_data: :environment }) do
  # Market Synthesis — Sample Data
  # Paste this into rails console after running rails db:migrate
  # Make sure you have at least one User created first (sign up via the app or create below)

  # Uncomment the line below if you need to create a user first:
  # User.create!(email: "analyst@example.com", password: "appdev", username: "marketanalyst")

  user = User.first

  # ============================================================
  # NOTES
  # ============================================================

  n1 = Note.create!(
    user_id: user.id,
    title: "Tech selloff on Fed minutes",
    market_date: "2026-01-07",
    body: "The S&P 500 fell 1.3% today after the December Fed minutes revealed a more hawkish tone than expected. Several committee members expressed concern that inflation remains sticky in the services sector, particularly shelter and healthcare costs. The Nasdaq bore the brunt of the selling, dropping 2.1% as rate-sensitive growth names led the decline.

The 10-year Treasury yield climbed to 4.62%, its highest level since mid-November. This move pressured equity valuations broadly but hit long-duration tech names especially hard. NVDA fell 4.2% and MSFT dropped 2.8%. Semis were weak across the board with the SOX index down 3.1%.

Bond market pricing now reflects roughly a 35% chance of a rate cut at the March meeting, down from over 50% just a week ago. The dollar strengthened against major currencies, with DXY pushing above 104.5. Credit spreads widened modestly — IG about 3bps and HY about 12bps — but nothing alarming yet.

Gold pulled back to $2,620 despite the risk-off tone, weighed down by dollar strength. Crude oil was relatively flat at $73.40 as geopolitical supply concerns offset the macro headwinds.",
  )

  n2 = Note.create!(
    user_id: user.id,
    title: "Strong jobs report complicates rate cut narrative",
    market_date: "2026-01-10",
    body: "December nonfarm payrolls came in at 278K vs. consensus of 195K. The unemployment rate ticked down to 3.9% from 4.0%. Average hourly earnings rose 0.4% month-over-month, above the 0.3% expected. This was a blowout report by any measure.

Markets initially sold off hard on the data — S&P futures dropped 45 points in the first 10 minutes. However, an interesting reversal developed through the session. By the close, the S&P was down only 0.4% and the Nasdaq actually finished flat. The buy-the-dip crowd seems to be interpreting strong employment as positive for earnings, even if it delays rate cuts.

The 2-year Treasury yield spiked 14bps to 4.38%, reflecting rapidly diminishing rate cut expectations. Fed funds futures now price the first full cut no earlier than June. Regional bank stocks actually rallied — KRE up 1.8% — as the steeper yield curve benefits net interest margins.

The VIX popped to 17.5 intraday but settled back to 15.8. I'm watching whether this labor strength translates into stronger-than-expected Q4 earnings or whether companies start flagging wage pressure on margins.",
  )

  n3 = Note.create!(
    user_id: user.id,
    title: "Q4 earnings season kicks off — banks beat",
    market_date: "2026-01-17",
    body: "JPMorgan, Citi, and Wells Fargo all reported Q4 earnings above consensus this morning. JPM posted EPS of $4.81 vs $4.11 expected, driven by a 49% surge in investment banking revenue and strong trading results. The stock gained 3.2% and pulled the XLF higher by 1.4%.

Net interest income at JPM came in at $23.5B, roughly flat year-over-year but above estimates. Management guided for NII of $90B in 2026, slightly ahead of Street expectations. Loan growth was modest at 2% but credit quality remains solid — net charge-offs were in line and reserves were stable.

Citi's turnaround story gained some credibility today. Revenue beat by $800M and the efficiency ratio improved to 63% from 68% a year ago. The stock jumped 5.1%. Wells Fargo beat on both lines but flagged softness in commercial real estate, noting increased reserves for office exposure.

Broader market was constructive — S&P up 0.6%, small caps outperformed with IWM up 1.1%. The strong bank earnings set a positive tone. The blended Q4 earnings growth estimate for the S&P 500 is now tracking around 9.2% year-over-year. Tech megacaps report next week and expectations are high.",
  )

  n4 = Note.create!(
    user_id: user.id,
    title: "Nvidia guidance shock — AI capex concerns surface",
    market_date: "2026-01-29",
    body: "Nvidia reported after the close and while Q4 revenue of $38.2B beat the $37.1B estimate, the Q1 guidance of $39.5B came in below the whisper number of $41B+. More importantly, management commentary around data center capex moderation spooked investors. The stock dropped 7.3% in after-hours trading.

Jensen Huang mentioned that some hyperscaler customers are 'optimizing deployment efficiency' which the market interpreted as slowing order growth. Microsoft and Amazon both recently noted they are being more disciplined about AI infrastructure spend in their own earnings calls this week.

This is the first real crack in the AI infrastructure narrative since the bull run began in early 2023. The broader AI supply chain sold off in sympathy — AMD down 5.1%, AVGO down 4.8%, MRVL down 6.2% in after-hours. Even utility stocks that had been riding the data center power demand theme (VST, CEG) pulled back 3-4%.

I think this is a crucial inflection point to watch. The question is whether this is a temporary pause in hyperscaler spending or the beginning of a more sustained deceleration. If the next round of cloud capex guidance confirms moderation, the entire AI trade needs to be re-evaluated. The S&P concentration risk in mega-cap tech remains extreme — top 7 names are 32% of the index.",
  )

  n5 = Note.create!(
    user_id: user.id,
    title: "CPI comes in cool — market rips higher",
    market_date: "2026-02-12",
    body: "January CPI printed 0.2% month-over-month headline and 0.2% core, both below the 0.3% consensus. Year-over-year core CPI decelerated to 3.1% from 3.3%. This was the friendliest inflation print in three months and immediately rekindled rate cut hopes.

The S&P 500 surged 1.8% with breadth remarkably strong — over 85% of S&P constituents were positive. Small caps led with IWM up 2.9%, a sign that rate-sensitive cyclicals are pricing in monetary easing. The equal-weight S&P 500 (RSP) outperformed the cap-weighted index for the first time in weeks.

Treasury yields dropped sharply. The 10-year fell 11bps to 4.41% and the 2-year dropped 15bps to 4.18%. The yield curve steepened modestly. Fed funds futures shifted to price nearly two full cuts by year-end, up from 1.5 cuts before the print.

Housing-related names were among the top performers — XHB up 3.4%, homebuilders like DHI and LEN up 4%+. The shelter component of CPI showed its first meaningful deceleration in months, which is significant because shelter has been the biggest drag keeping core inflation elevated. If this trend continues, the Fed has cover to start easing by mid-year.",
  )

  n6 = Note.create!(
    user_id: user.id,
    title: "Rotation into defensives — risk appetite fading",
    market_date: "2026-02-19",
    body: "Interesting price action today. The S&P 500 was essentially flat (-0.1%) but the internals told a very different story. Utilities (XLU) were the best sector, up 1.3%. Staples (XLP) gained 0.9%. Healthcare (XLV) up 0.7%. Meanwhile, consumer discretionary (XLY) fell 1.1% and communication services dropped 0.8%.

This defensive rotation has been building for about a week now. Since February 12th, XLU has outperformed XLK by over 300 basis points. The last time we saw this kind of divergence was September 2024, just before a 5% correction in the S&P.

Credit markets are sending cautious signals too. IG spreads have widened 8bps over the past two weeks to 98bps. HY spreads are at 345bps, up from 320bps at the start of the month. Not blowout levels by any means, but the direction of travel is worth noting.

The CNN Fear & Greed Index has dropped to 38 (Fear) from 62 (Greed) three weeks ago. Put/call ratios have been elevated for five consecutive sessions. I'm also noticing fund flow data showing outflows from equity ETFs for the first time since November. The accumulation of these signals suggests positioning is getting more cautious even though headlines remain benign.",
  )

  n7 = Note.create!(
    user_id: user.id,
    title: "Oil spikes on Middle East escalation",
    market_date: "2026-02-26",
    body: "WTI crude surged 4.8% to $79.20 after reports of a significant military escalation in the Red Sea involving direct confrontation between U.S. naval forces and Houthi militants. Two commercial tankers were hit, and shipping companies immediately announced diversions around the Cape of Good Hope, adding 10-14 days to transit times.

Energy stocks were the clear winner today — XLE up 3.2%, with E&P names like EOG, PXD, and DVN all up 4-6%. Interestingly, refiners outperformed even more as the crack spread widened. Valero and Marathon Petroleum both up over 5%.

The broader market was surprisingly resilient. S&P 500 finished down just 0.3% despite the geopolitical shock. However, small caps (IWM) dropped 1.2%, suggesting the risk premium hit rate-sensitive names harder. The VIX popped to 19.8 intraday but closed at 17.2.

Gold finally broke through $2,700, settling at $2,712. Defense stocks also rallied — LMT up 2.8%, RTX up 2.3%, NOC up 1.9%. I'm watching whether this geopolitical premium sustains or fades within a week as these events typically do. The bigger risk is if shipping disruptions start flowing through to goods inflation data in March and April, which could complicate the Fed's easing path.",
  )

  n8 = Note.create!(
    user_id: user.id,
    title: "ISM Manufacturing returns to expansion",
    market_date: "2026-03-03",
    body: "The February ISM Manufacturing PMI printed 52.1, above the 50.0 expansion threshold for the first time since October 2024. This ends a 15-month contraction streak. New orders were particularly strong at 55.3, the highest reading since March 2024. Employment also improved to 50.8, back into expansion territory.

Industrial names rallied on the data — XLI up 1.6%, CAT up 2.4%, DE up 2.1%. Copper futures rose 1.8% to $4.32/lb, a 6-month high, confirming the manufacturing recovery signal. Steel stocks (X, NUE, STLD) were up 2-4%.

This is a meaningful data point because the manufacturing sector has been a drag on the economy for over a year. If this recovery sustains, it supports the soft landing narrative and broadens the earnings recovery beyond just tech and services.

The flip side is that stronger manufacturing activity could keep the Fed cautious on rate cuts. The prices paid component came in at 54.9, suggesting some input cost pressures. The market seems to be treating this as net positive for now — S&P up 0.9% — but I'll be watching how the February jobs report and CPI interact with this data. A re-acceleration in manufacturing inflation would be a headwind for the rate cut timeline.",
  )

  n9 = Note.create!(
    user_id: user.id,
    title: "Yield curve steepening accelerates",
    market_date: "2026-03-10",
    body: "The 2s10s spread turned positive last week and has now steepened to +18bps, the widest since early 2022. The 10-year yield is at 4.55% while the 2-year has dropped to 4.37%, reflecting diverging expectations: the front end is pricing rate cuts while the long end is adjusting to stronger growth and persistent fiscal deficits.

This steepening is being driven by the long end selling off — the so-called 'bear steepener.' The 30-year yield touched 4.78% today. The term premium, as estimated by the ACM model, has risen to its highest level since 2014. Markets are demanding more compensation for holding duration, partly reflecting concerns about Treasury supply with the deficit projected at $1.9 trillion for fiscal 2026.

Banks and financials continue to benefit from this dynamic. KBE (bank ETF) has outperformed the S&P by 800bps year-to-date. Net interest margin expansion is a powerful earnings tailwind for the sector. Regional banks in particular are seeing analyst upgrades.

On the other side, long-duration assets are under pressure. The 20+ year Treasury ETF (TLT) is down 4.2% YTD. High-multiple growth stocks that benefited from the falling rate environment are facing headwinds. The rate-sensitive housing sector is also feeling it — mortgage applications dropped 8% last week as the 30-year mortgage rate climbed back to 7.1%.",
  )

  n10 = Note.create!(
    user_id: user.id,
    title: "Breadth improvement signals potential breakout",
    market_date: "2026-03-17",
    body: "The S&P 500 advance-decline line hit a new 52-week high today even as the index itself is still 1.2% below its January peak. This kind of breadth thrust — where participation broadens ahead of a new price high — has historically been a very bullish signal. The last time this happened was November 2023, just before a 15% rally.

The equal-weight S&P 500 (RSP) has outperformed the cap-weighted index by 340bps over the past month. Mid-caps (MDY) and small-caps (IWM) have both outperformed as well. Over 72% of S&P 500 stocks are trading above their 50-day moving average, up from just 45% in mid-February.

Sector rotation has been constructive. The leadership is broadening from just tech and communications into industrials, financials, materials, and healthcare. XLI is at an all-time high. XLF is within 1% of its high. Even XLB (materials) is showing signs of life with a 3-week winning streak.

Volume patterns are also supportive. Up-volume has exceeded down-volume for 8 of the last 10 sessions. The NYSE McClellan Oscillator crossed above +100, a reading that has preceded positive 3-month returns in the S&P about 82% of the time historically. If the index can push through the January high with this breadth backdrop, the rally could have meaningful legs into Q2.",
  )

  # ============================================================
  # INSIGHTS
  # ============================================================

  i1 = Insight.create!(
    user_id: user.id,
    title: "Fed rate path increasingly data-dependent — June cut base case",
    body: "Across multiple observations from January through February, the Fed narrative has shifted significantly. The strong December jobs report and hawkish minutes initially crushed rate cut expectations, but the cooler-than-expected January CPI revived them. The market is now pricing roughly two cuts by year-end with June as the earliest plausible start date. The push-and-pull between strong employment data and moderating inflation suggests the Fed will remain patient, making each upcoming CPI and jobs print a potential volatility catalyst.",
    category: "trend",
  )

  i2 = Insight.create!(
    user_id: user.id,
    title: "AI infrastructure trade showing first signs of fatigue",
    body: "Nvidia's below-whisper guidance and commentary about hyperscaler capex optimization marks a potential inflection in the AI infrastructure buildout narrative. With Microsoft and Amazon also flagging more disciplined AI spending, the supply chain beneficiaries (AMD, AVGO, MRVL, and data center utilities) face re-rating risk. While AI adoption itself is likely to continue, the pace of hardware spending may moderate, making semiconductor valuations vulnerable. This warrants reducing exposure to pure AI hardware plays and watching the next round of cloud capex guidance closely.",
    category: "trade opportunity",
  )

  i3 = Insight.create!(
    user_id: user.id,
    title: "Financials emerging as durable leadership amid steepening curve",
    body: "The yield curve steepening from inversion to +18bps, combined with strong bank earnings and improving net interest margins, positions financials as a sector with fundamental tailwinds that could persist through 2026. JPMorgan's earnings beat and constructive NII guidance, plus the broader KBE outperformance of 800bps YTD, confirm that the sector is benefiting from both the rate environment and a manufacturing recovery. Regional banks in particular are seeing analyst upgrades and offer compelling relative value.",
    category: "trade opportunity",
  )

  i4 = Insight.create!(
    user_id: user.id,
    title: "Geopolitical supply-chain risk re-emerging as inflation wildcard",
    body: "The Red Sea escalation and resulting shipping diversions represent a tangible risk to the disinflation narrative. If transit disruptions persist, goods inflation could reaccelerate in March-April data, potentially complicating the Fed's easing timeline just as the market prices in mid-year cuts. The spike in crude oil and widening crack spreads suggest the market is beginning to price this risk, but the knock-on effects to broader inflation measures have not yet materialized. This creates an asymmetric setup where any upside surprise in goods CPI could trigger a sharp repricing of rate expectations.",
    category: "trend",
  )

  i5 = Insight.create!(
    user_id: user.id,
    title: "Broadening market breadth supports constructive Q2 outlook",
    body: "The improving advance-decline line, rising percentage of stocks above their 50-day moving average, and consistent outperformance of equal-weight over cap-weight indices all point to a healthier, more sustainable rally structure. Combined with the ISM Manufacturing returning to expansion and leadership broadening into industrials, financials, and materials, the market appears to be transitioning from a narrow mega-cap-driven rally to a broader participation regime. Historically, breadth thrusts of this magnitude have preceded positive 3-month returns over 80% of the time.",
    category: "trend",
  )

  # ============================================================
  # NOTE-INSIGHT LINKS
  # ============================================================

  # i1: Fed rate path — draws from Fed minutes, jobs report, CPI
  NoteInsight.create!(note_id: n1.id, insight_id: i1.id)
  NoteInsight.create!(note_id: n2.id, insight_id: i1.id)
  NoteInsight.create!(note_id: n5.id, insight_id: i1.id)

  # i2: AI infrastructure fatigue — draws from Nvidia guidance
  NoteInsight.create!(note_id: n4.id, insight_id: i2.id)
  NoteInsight.create!(note_id: n3.id, insight_id: i2.id)

  # i3: Financials leadership — draws from bank earnings, yield curve, ISM
  NoteInsight.create!(note_id: n3.id, insight_id: i3.id)
  NoteInsight.create!(note_id: n9.id, insight_id: i3.id)
  NoteInsight.create!(note_id: n8.id, insight_id: i3.id)

  # i4: Geopolitical inflation risk — draws from oil spike, CPI, Fed path
  NoteInsight.create!(note_id: n7.id, insight_id: i4.id)
  NoteInsight.create!(note_id: n5.id, insight_id: i4.id)
  NoteInsight.create!(note_id: n1.id, insight_id: i4.id)

  # i5: Breadth improvement — draws from breadth note, defensives rotation, ISM
  NoteInsight.create!(note_id: n10.id, insight_id: i5.id)
  NoteInsight.create!(note_id: n6.id, insight_id: i5.id)
  NoteInsight.create!(note_id: n8.id, insight_id: i5.id)

  # ============================================================
  # VERIFY
  # ============================================================

  puts "Created #{Note.count} notes"
  puts "Created #{Insight.count} insights"
  puts "Created #{NoteInsight.count} note-insight links"
  puts "Done!"
end
