module ApicallsHelper
  def check_params
    browse_release_country(params[:country]) unless params[:country].nil?
  end

  def browse_artists(arg1, arg2, arg3, arg4, arg5)
    return unless arg5.blank?

    c_index = country_names.index(arg5)
    country = country_codes[c_index]

    resp = RestClient.get("https://api.spotify.com/v1/browse/new-releases?country=#{country}&offset=0&limit=20",
                          { Authorization: "Bearer #{Apicall.first.token}" })
    JSON.parse(resp)[arg1][arg2][arg3.to_i][arg4]
    # JSON.parse(resp)['albums']['items'][0]['artists'][0]['name']
  end

  def browse_release_country(prm)
    return render 'datamsg' if prm.blank?

    c_index = country_names.index(prm)
    country = country_codes[c_index]

    resp = RestClient.get("https://api.spotify.com/v1/browse/new-releases?country=#{country}&offset=0&limit=20",
                          { Authorization: "Bearer #{Apicall.first.token}" })
    b_country = JSON.parse(resp)['albums']['items']
    delete_previous_data
    save_search(b_country)
    render 'release_data'
  end

  def save_search(b_country)
    b_country.each do |r|
      Newrelease.create(artist: r['name'], album: r['external_urls']['spotify'], image: r['images'][1]['url'],
                        track: r['total_tracks'], release_date: r['release_date'], album_id: r['id'])
    end
  end

  def delete_previous_data
    Newrelease.data_destroy
  end

  def country_codes
    %w[AD AE AF AG AI AL AM AO AQ AR AS AT AU AW AX AZ BA BB BD BE BF BG BH BI BJ BL
       BM BN BO BQ BR BS BT BV BW BY BZ CA CC CD CF CG CH CI CK CL CM CN CO CR
       CU CV CW CX CY CZ DE DJ DK DM DO DZ EC EE EG EH ER ES ET FI FJ FK FM FO FR GA
       GB GD GE GF GG GH GI GL GM GN GP GQ GR GS GT GU GW GY HK HM HN HR HT HU ID IE
       IL IM IN IO IQ IR IS IT JE JM JO JP KE KG KH KI KM KN KP KR KW KY KZ LA LB LC
       LI LK LR LS LT LU LV LY MA MC MD ME MF MG MH MK ML MM MN MO MP MQ MR MS MT MU
       MV MW MX MY MZ NA NC NE NF NG NI NL NO NP NR NU NZ OM PA PE PF PG PH PK PL PM
       PN PR PS PT PW PY QA RE RO RS RU RW SA SB SC SD SE SG SH SI SJ SK SL SM SN SO
       SR SS ST SV SX SY SZ TC TD TF TG TH TJ TK TL TM TN TO TR TT TV TW TZ UA UG UM
       US UY UZ VA VC VE VG VI VN VU WF WS YE YT ZA ZM ZW]
  end

  def country_names
    ['Andorra', 'Unite Arab Emirates', 'Afghanistan', 'Antigua and Barbuda', 'Anguilla', 'Albania',
     'Armenia', 'Angola', 'Antarctica', 'Argentina', 'American Samoa', 'Austria', 'Australia',
     'Aruba', 'Ålan Islands', 'Azerbaijan', 'Bosnia and Herzegovina',
     'Barbados', 'Bangladesh', 'Belgium', 'Burkin Faso', 'Bulgaria',
     'Bahrain', 'Burundi', 'Benin', 'Sain Barthélemy', 'Bermuda',
     'Brune Darussalam', 'Bolivi', 'Bonaire, Sint Eustatius and Saba',
     'Brazil', 'Bahamas', 'Bhutan', 'Bouvet Island', 'Botswana',
     'Belarus', 'Belize', 'Canada', 'Cocos (Keeling) Islands',
     'Congo, Democratic Republic of the', 'Central African Republic', 'Congo',
     'Switzerland', "Côte d'Ivoire", 'Cook Islands', 'Chile',
     'Cameroon', 'China', 'Colombia', 'Costa Rica', 'Cuba', 'Cabo Verde', 'Curaçao',
     'Christmas Island', 'Cyprus', 'Czechia', 'Germany', 'Djibouti', 'Denmark',
     'Dominica', 'Dominican Republic', 'Algeria', 'Ecuador', 'Estonia',
     'Egypt', 'Western Sahara', 'Eritrea', 'Spain', 'Ethiopia', 'Finland',
     'Fiji', 'Falkland Islands (Malvinas)', 'Micronesia (Federated States of)',
     'Faroe Islands', 'France', 'Gabon', 'United Kingdom of Great Britain and Northern Ireland',
     'Grenada', 'Georgia', 'French Guiana', 'Guernsey',
     'Ghana', 'Gibraltar', 'Greenland', 'Gambia', 'Guinea',
     'Guadeloupe', 'Equatorial Guinea', 'Greece', 'South Georgia and the South Sandwich Islands',
     'Guatemala', 'Guam', 'Guinea-Bissau', 'Guyana', 'Hong Kong',
     'Heard Island and McDonald Islands', 'Honduras', 'Croatia',
     'Haiti', 'Hungary', 'Indonesia', 'Ireland', 'Israel', 'Isle of Man', 'India',
     'British Indian Ocean Territory', 'Iraq', 'Iran (Islamic Republic of)',
     'Iceland', 'Italy', 'Jersey',
     'Jamaica', 'Jordan', 'Japan', 'Kenya', 'Kyrgyzstan', 'Cambodia',
     'Kiribati', 'Comoros', 'Saint Kitts and Nevis',
     'North Korea', 'South Korea', 'Kuwait',
     'Cayman Islands', 'Kazakhstan', "Lao People's Democratic Republic",
     'Lebanon', 'Saint Lucia', 'Liechtenstein', 'Sri Lanka', 'Liberia',
     'Lesotho', 'Lithuania',
     'Luxembourg', 'Latvia', 'Libya', 'Morocco', 'Monaco',
     'Moldova', 'Montenegro', 'Saint Martin (French part)',
     'Madagascar', 'Marshall Islands', 'North Macedonia',
     'Mali', 'Myanmar', 'Mongolia', 'Macao', 'Northern Mariana Islands',
     'Martinique', 'Mauritania', 'Montserrat', 'Malta', 'Mauritius',
     'Maldives', 'Malawi', 'Mexico', 'Malaysia', 'Mozambique',
     'Namibia', 'New Caledonia', 'Niger', 'Norfolk Island', 'Nigeria', 'Nicaragua', 'Netherlands',
     'Norway', 'Nepal', 'Nauru',
     'Niue', 'New Zealand', 'Oman', 'Panama', 'Peru', 'French Polynesia', 'Papua New Guin', 'Philippines', 'Pakistan',
     'Poland', 'Saint Pierre and Miquelon',
     'Pitcairn', 'Puerto Rico', 'Palestine, State of', 'Portugal', 'Palau', 'Paraguay', 'Qatar', 'Réunion', 'Romania',
     'Serbia', 'Russian Federation', 'Rwanda', 'Saudi Arabia', 'Solomon Islands', 'Seychelles',
     'Sudan', 'Sweden', 'Singapore',
     'Saint Helena, Ascension and Tristan da Cunha', 'Slovenia',
     'Svalbard and Jan Mayen', 'Slovakia', 'Sierra Leone', 'San Marino',
     'Senegal', 'Somalia', 'Suriname', 'South Sudan', 'Sao Tome and Principe',
     'El Salvador', 'Sint Maarten (Dutch part)', 'Syrian Arab Republic', 'Eswatini', 'Turks and Caicos Islands', 'Chad',
     'French Southern Territories', 'Togo', 'Thailand', 'Tajikistan', 'Tokelau',
     'Timor-Leste', 'Turkmenistan', 'Tunisia', 'Tonga', 'Turkey',
     'Trinidad and Tobago', 'Tuvalu', 'Taiwan, Province of China',
     'Tanzania, United Republic of', 'Ukraine', 'Uganda', 'United States Minor Outlying Islands',
     'United States of America', 'Uruguay', 'Uzbekistan', 'Holy See',
     'Saint Vincent and the Grenadines', 'Venezuela (Bolivarian Republic of)',
     'Virgin Islands (British)', 'Virgin Islands (U.S.)', 'Vietnam', 'Vanuatu',
     'Wallis and Futuna', 'Samoa', 'Yemen', 'Mayotte', 'South Africa', 'Zambia']
  end
end
