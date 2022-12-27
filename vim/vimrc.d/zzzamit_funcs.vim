" {{{ s:DiffWithSaved
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

" }}}

" {{{ s:DiffWithCVSCheckedOut
function! s:DiffWithCVSCheckedOut()
  let filetype=&ft
  diffthis
  vnew | r !cvs up -pr BASE #
  1,6d
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffCVS call s:DiffWithCVSCheckedOut()
" }}}

" {{{ s:DiffWithSVNCheckedOut
function! s:DiffWithSVNCheckedOut()
  let filetype=&ft
  diffthis
  vnew | exe "%!svn cat " . expand("#:p:h")
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSVN call s:DiffWithSVNCheckedOut()
" }}}

" {{{ s:DiffWithGITCheckedOut
function! s:DiffWithGITCheckedOut()
  let filetype=&ft
  diffthis
  vnew | exe "%!git diff " . expand("#:p:h") . "| patch -p 1 -Rs -o /dev/stdout"
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
  diffthis
endfunction
com! DiffGIT call s:DiffWithGITCheckedOut()
" }}}

" {{{ TimeStampFoldExpr
"From :: http://www.mail-archive.com/vim_use@googlegroups.com/msg24833.html
let s:levels = [ 4, 7, 10, 13, 16, 19 ]

fun! s:TimeStamp(lnum,i)
        let off = s:levels[a:i < 0 ? 0 : a:i]
        return getline(a:lnum)[:off]
endfun

fun! TimeStampFoldExpr()
        let prefix = ''
        for i in reverse(range(len(s:levels)))
                let lev = i + 2
                let offset = levels[i]
                if s:TimeStamp(v:lnum,i) == s:TimeStamp(v:lnum+1,i)
                        return prefix . lev
                endif
                let prefix = '<'
        endfor
        return prefix . '1'
endfun

fun! TimeStampFoldText()
        return v:folddashes . s:TimeStamp(v:foldstart, v:foldlevel-2)
endfun

" }}}


" {{{ Modeline
"Modeline append.
function! AppendModeline()
  let l:modeline = printf(" vim: set filetype=%s ts=%d sw=%d tw=%d :",
        \ &filetype,
        \ &tabstop, &shiftwidth, &textwidth)
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction
nnoremap <silent> <LocalLeader>ml :call AppendModeline()<CR>
" }}}

" {{{ Paste_on_off
"Change the paste mode.
let paste_mode = 0 " 0 = normal, 1 = paste

func! Paste_on_off()
   if g:paste_mode == 0
      set paste
      let g:paste_mode = 1
   else
      set nopaste
      let g:paste_mode = 0
   endif
   return
endfunc
nnoremap <silent> <F9> :call Paste_on_off()<CR>
" }}}

" {{{ s:Underline
"Other useful functions.
function! s:Underline(chars)
  let chars = empty(a:chars) ? '-' : a:chars
  let nr_columns = virtcol('$') - 1
  let uline = repeat(chars, (nr_columns / len(chars)) + 1)
  put =strpart(uline, 0, nr_columns)
endfunction
command! -nargs=? Underline call s:Underline(<q-args>)
" }}}

" {{{ RotateColorTheme
let themeindex=0
function! RotateColorTheme()
   let y = -1
   "Generate this string with 
   " echo *|sed 's/ /\n/g'|sort -R |tr -d '\n'|sed -e 's/\.vim/#/g' -e 's/ //g' |xclip -i
   " better yet with:
   " echo "let colorstring = '#$(ls -1 *.vim|sed 's/.vim$/ /'|sort -R |tr  '\n' '#'|sed 's/ //g')'"|xclip -i
   "in .vim/colors directory
   while y == -1
      let colorstring = 'no_quarter#carrot#beauty256#vj#arcadia#af#charon#github#Atelier_SulphurpoolLight#simpleandfriendly#ayumi#calmar256-dark#vimicks#thinkpad#Railscasts#feral#mophiaDark#dusk#bclear#midnight#Dark#skyweb#maroloccio3#paramount#bigbang#professional#srcery-drk#rcg_term#scame#nocturne#mrkn256#boa#nightwish#Atelier_LakesideLight#nature#fnaqevan#gemcolors#sorcerer#Fluidvision#capsulapigmentorum#disciple#d8g_04#win9xblueback#wikipedia#ChocolatePapaya#Django(Smoothy)#MultiMarkdown#DimGreen#olive#nu42dark#rainbow_autumn#new-railscasts#elisex#desert256#hilal#h80#monokain#peaksea#base16-railscasts#tango-morning#elrond#fu#256-jungle#PapayaWhip#tomatosoup#hemisu#darth#base16-atelierestuary#navajo-night#legiblelight#flattown#calm#grape#stefan#BusyBee#afterglow#cobalt2#xterm16#stonewashed-gui#Mahewincs#campfire#Monokai#sean#simple_dark#Tomorrow#xmaslights#lizard#xorium#beekai#autumn2#asmdev#breeze#bocau#lxvc#soda#PerfectDark#zendnb#tango_1#seoul256-light#intellij#eva01#Atelier_SavannaLight#tools#osx_like#xian#chlordane#mirodark#less#vividchalk#darkglass#nofrils-sepia#festoon#vilight_1#bubblegum-256-dark#lingodirector#chrysoprase#CSSEdit#scala#psclone#settlemyer#Atelier_HeathDark#lightdiff#Atelier_SulphurpoolDark#detailed#gothic#yaml#spring#earthburn#primary#print_bw#sonofobsidian#babymate256#hhviolet#aurora#graywh#FriendshipBracelet#eclm_wombat#vcbc#pw_1#twitchy#manxome#bvemu#IR_Black#dw_cyan#base16-atelierseaside#spectro#northland#potts#parsec#mud#abbott#dracula_bold#Spink#nets-away#putty#cobalt#jaime#desertedocean#iceberg#icansee#despacio#BlackboardBlack#lizard256#risto#blackbeauty#chela_light#toothpik#stormpetrel#tony_light#pride#obsidian2#kruby#itsasoa#smarties#brighton#xemacs#vanzan_color#BlackPearlII#jelleybeans#navajo#flatlandia#seashell#literal_tango#colorsbox-greenish#plasticine#wombat256dave#gryffin#adaryn#Lowlight#sierra#paradox#SerialExperimentsLain#simplon#pink#royaltango#orangeocean256#golded#understated#chance-of-storm#blugrine#summerfruit#twilight#Atelier_HeathLight#skittles_dark#ayu#michael#aldmeris#triplejelly#blues#relaxedgreen#perfect#billw#solarized8_dark#rainbow_sea#darkbone#textmate16#tesla#neutron#Spectacular#immortals#coldgreen#greyblue#mohammad#Dev_Delight#dark-ruby#stackoverflow#duotone-darkmeadow#norwaytoday#stonewashed-dark-gui#SummerCampMod#penultimate#simplewhite#woju#vilight#strange#duotone-darklake#shobogenzo#tatami#night#django#sea#256_adaryn#deepblue#hybrid-light#darker-robin#coffee#revolutions#MountainDew#vim-material#dejavu#adobe#pyte#colorzone#golden#quagmire#solarized#Atelier_SeasideLight#latte#oceanlight#hydrangea#tango#tchaba2#Putty#vimbrains#neuromancer#nazca#d8g_01#happy_hacking#fruit#darkdevel#donbass#mopkai#bog#desert256v2#off#lilydjwg_dark#fight-in-the-shade#goodwolf#duotone-darkspace#earendel_1#alduin#kalisi#C64#mojave#sialoquent#primaries#atom#crayon#hhorange#mac_classic#kolor#thestars#beachcomber#taqua#rakr-light#Atelier_SavannaDark#candy#rockets-away#sky#default#FadetoGrey#blueshift#quantum#sandydune#neverland2-darker#abyss#tidy#jhlight#deep-space#DimGrey#darkspectrum#caramel#boltzmann#LightSlate#mustang#zenesque#southernlights#flattr#underwater-mod#underwater#flattened_light#colorful#genericdc#spring-night#ForLaTeX#synthwave#freya#derefined#evolution#ecostation#yeller#solarized8_light#desert#magellan#moonshine#ps_color#wombat256#vc#README.txt#sand#bubblegum#DarkDefault#impact#colorsbox-faff#random#EmacsStrict#baobaozhu#hornet#pt_black#frozen#zenburn#angr#highlighter_term_bright#Atelier_CaveLight#gor#itg_flat#morning#turtles#cake#greygull#onedark#donttouchme#dull#neonwave#mickeysoft#robokai#moonshine_minimal#deepsea#blackdust#base16-ateliersulphurpool#rootwater#mrpink#pychimp#rainbow_neon#calmar256_dark#summerfruit256#fake#blue_1#ambient#py-darcula#moria#petrel#eva#aqua#selenitic#mayansmoke#vexorian#devbox-dark-256#hual#archery#denim#codeblocks_dark#Django#GlitterBomb#hybrid_material#robinhood#toxic#nofrils-light#zen#darkburn#dracula#vylight#visualstudio#Tango#CandyPaper#neverness#materialtheme#made_of_code#miko#genericdc-light#Atelier_PlateauDark#pacific#VIvid#soruby#hhdgray#ironman#phphaxor#tigrana-256-light#space-vim-dark#vombato#cool#simple_b#zmrok#codeschool#true-monochrome#asmdev2#mellow#louver#crunchbang#bluechia#moonshine_lowcontrast#flatland#scheakur#corn#advantage#thegoodluck#nofrils-acme#256_darkdot#last256#sprinkles#clarity#magicwb#Happyhappyjoyjoy2#corporation#256-grayvim#Pastie#smp#cobalt_1#basic-light#tcsoft#base16-atelierheath#RailsEnvy#phd#synic#Smoothy#editplus#monoacc#kkruby#fisa#Atelier_ForestLight#hickop#sol#ekvoli#sf#autumnleaf#darkblue2#dubs#northsky#almost-default#fruity#telstar#hybrid#calmar256_light#materialbox#vo_dark#AllHallowsEveCustom#nightshimmer#pf_earth#lemon256#ansi_blows#colorsbox-stbright#shades-of-teal#khaki#fine_blue2#cobaltish#zazen_1#coda#fine_blue#darkblue#omen#welpe#typofree#winterd#kib_darktango#busierbee#developer#montz#kyle#sven#cmd#rgbr#reliable#universal-blue#mophiaSmoke#dw_green#asmanian_blood#base#sunburst#monoindustrial#blackboard#softblue#wombat256i#scooby#paintbox#neon-pk#industry#tir_black#greenwint#Tomorrow-Night#rme#apprentice#PaperColor#SweetCandy#basic#night_vision#kalt#highlighter_term#nofrils-dark#pixelmuerto#distill#wuye#metacosm#koehler#simple-dark#edo_sea#codeburn#phpx#Atelier_ForestDark#cthulhian#Atelier_DuneLight#martin_krischik#duotone-darksea#mango#inori#256_noir#monochrome#base16-ateliersavanna#clearance#Tomorrow-Night-Bright#blaquemagick#brookstream#d8g_03#moss#BlackPearl#oh-la-la#pleasant#spiderhawk#neverland#prmths#railscasts2#adrian#enigma#gentooish#getfresh#tutticolori#SlateDark#chocolate#whitedust#chroma#mushroom#slate2#nes#mod8#orange#warriors-away#macvim-light#solarized8_light_high#dzo#itg_flat_transparent#Espresso#darkroom#codepaper#nefertiti#OceanicNext#eclipse#manuscript#earth#native#inkpot#phoenix#calmbreeze#brogrammer#sole#wf#zazen#zellner#eddie#DimSlate#flattened_dark#navajo_night#celtics_away#murphy#Atelier_LakesideDark#automation#sourcerer#habiLight#thinkpad_nerdtree#busybee#seagull#sienna#felipec#silent#mod_tcsoft#gobo#more#stingray#buddy#ex_lightgray#kiss#White#solarized8_dark_flat#fx#Atelier_DuneDark#Atelier_EstuaryDark#Black#hhdmagenta#earendel#whitebox#mourning#tchaba#solarized8_dark_low#horseradish256#jellyx#birds-of-paradise#BBEdit#doorhinge#playroom#cherryblossom#anokha#idleFingers#ego#cleanroom#aquamarine#quiet#royalking#gotham#luna-term#diablo3#contrasty#shadesofamber#rcg_gui#TextExMachina#vim-online#emacs#base16-atelierforest#borland#herald#SORuby#burnttoast256#dawn#tango-desert#zephyr#rainbow_fine_blue#nevfn#adam#vice#ron#tigrana-256-dark#wargrey#highlights_for_radiologist#jellygrass#GitHub#wellsokai#Benokai#pablo#duotone-darkforest#256_automation#wintersday#iLife05#lanzarotta#jitterbug#anotherdark#darkerdesert#rainbow_fruit#cleanphp#astroboy#lilypink#tayra#bw#paper#znake#codedark#ex#saturn#nightshade#skittles_autumn#blink#luinnar#railscasts#White2#elrodeo#nour#rtl#gravity#autumnleaf_modified#OceanicNextLight#nightflight2#Tomorrow-Night-Eighties#peppers#base16-atelierlakeside#laederon#gotham256#smpl#leo#ancient#Mustang#jammy#greens#torte#tango2#vertLaiton#EspressoTutti#desert-warm-256#CloudsMidnight#base16-atelierdune#lucid#vividchalk_1#bluedrake#evokai#up#compot#lanox#carvedwood#ir_black#vydark#badwolf#kib_plastic#clean#dw_blue#gummybears#material#biogoo#SwyphsII#tibet#delphi#twilight256#askapache#google#maroloccio2#shiny-white#3dglasses#nuvola#cgpro#Tomorrow-Night-Blue#kaltex#xoria256#harlequin#mdark#duotone-darkdesert#nicotine#tender#tortex#darkZ#herokudoc-gvim#luna#heroku-terminal#fruidle#evening1#psql#blueprint#redstring#cabin#tetragrammaton#wood#void#bwn#Blue2#oh-l_l#surveyor#janah#idle#lodestone#VibrantInk#colorsbox-steighties#hhdcyan#lettuce#brown#forneus#LightDefault#unicon#python#werks#MerbivoreSoft#white#blue#liquidcarbon#lyla#hhteal#material-theme#ashen#two2tango#LightYellow#colorful256#peachpuff#diokai#nedit#hybrid_reverse#lakers_away#kate#firewatch#refactor#satori#camo#tropikos#elda#moriarty#fog#strawimodo#scite#lilydjwg_green#vorange#nightshade_print#nightflight#Revolution#newsprint#monokai-chris#solarized8_light_low#ubloh#SummerCamp#darkrobot#hhdblue#widower#abra#breezy#matrix#vimhut#hhdyellow#pw#impactjs#hhpink#dragon#late_evening#sorcerer_1#heroku#smyck#dual#Slate#garden#c16gui#gardener#sift#japanesque#raggi#bitterjug#dagon#seattle#bjornenki-colorscheme#deveiate#calmar256-light#contrastneed#shekhar#vimbrant#mizore#blue_sky#nightVision#fairyfloss#thor#candycode#minimal#falcon#stonewashed-dark-256#google-prettify#fahrenheit#duotone-darkpool#DimRed#LightTan#LightGrey#bluish#messy#baycomb#highwayman#buttercream#asmanian2#charged-256#ghostbuster#rslate#bluegreen#Bongzilla#muon#dw_red#kkruby_1#masmed#monokai-phoenix#trogdor#neodark#duotone-darkcave#wwdc16#otaku#obsidian#grey2#cascadia#wasabi256#ibmedit#lilac#pyte_2#neverland-darker#darkeclipse#Light#preto#Atelier_PlateauLight#enzyme#frood#skittles_berry#256_blackdust#eldar#greenvision#hhdgreen#goldenrod#256_asu1dark#desertEx#softbluev2#kings-away#Coda#industrial#RyanLight#stonewashed-256#kellys#ingretu#maui#ciscoacl#BlackSea#bluez#blazer#spurs_away#desertink#aiseered#turbo#colorsbox-stblue#eva01-LCL#Atelier_SeasideDark#herokudoc#Dark2#colorscheme_template#clue#Green#flatui#tangoshady#nightsky#nerv-ous#darkblue_1#rdark-terminal#midnight2#1989#trivial256#colorsbox-stnight#distinguished#Starlight#sweater#molokai_dark#IR_White#vo_light#imperial#spacegray#gaea#simplergb#my_inkpot#duotone-darkpark#DevC++#darkslategray#twilight_1#simple256#graywh_1#tangolight#desertedoceanburnt#deus#heliotrope#CodeFactoryv3#jiks#Atelier_EstuaryLight#Dim2#railscasts_1#gruvbox#motus#lazarus#0x7A69_dark#winter#darkocean#ekinivim#light2011#bensday#bubblegum-256-light#autumn_2#slate#darkBlue#jhdark#bandit#kalahari#greyhouse#Tubster#nord#termschool#inkpot_1#moody#doriath#LightDefaultGrey#DimBlue#dw_purple#guardian#lightcolors#jellybeans#grayorange#broduo#xcode#darktango#foursee#iangenzo#oceanblack256#impactG#warm_grey#two-firewatch#predawn#delek#nordisk#elise#darkzen#evening_2#duotone-dark#amethyst#adventurous#stereokai#spartan#reloaded#pspad#krTheme#256_redblack#valloric#RDark#wombat#thermopylae#Freckle#colorer#d8g_02#oceandeep#vibrantink#basic-dark#tolerable#behelit#pencil#xoria256m#erez#rdark#darkdot#eink#umber-green#black_angus#marklar#c#elflord#madeofcode#custom#Atelier_CaveDark#flatcolor#VibrantTango#dante#crt#lightning#Argonaut#candyman#hhspring#bayQua#anderson#newspaper#habamax#hhdred#Chasing_Logic#guepardo#antares#asu1dark#silent_1#grishin#mint#symfony#rainbow_night#seoul#grb256#holokai#bluenes#cyberpunk#neon#base16-atelierplateau#lucius#white_1#wombat256mod#mars#thornbird#duotone-darkearth#solarized8_light_flat#Blue#wolfpack#base16-ateliercave#Red#fokus#cloudy#pic#oceanblack#dw_yellow#autumn_1#northpole#blacklight#mythos#watermark#swamplight#sonoma#solarized8_dark_high#leya#southwest-fog#hhazure#yuejiu#maroloccio#soso#lunaperche#leglight2#radicalgoodspeed#tabula#duotone-darkheath#shine#benlight#oxeded#Merbivore#warez#chalkboard#Dim#redblack#molokai#darkblack#rainbow_breeze#nedit2#dw_orange#briofita#fluka#terse#spacemacs-theme#sol-term#Clouds#argonaut#minimalist#DimGreens#lumberjack#softlight#srcery#tangoX#noclown#lapis256#rastafari#astronaut#evening#LightGreen#rhinestones#xedit#landscape#carvedwoodcool#neopro#transparent#xcode-default#far#bmichaelsen#sexy-railscasts#loogica#seoul256#proton#getafe#colorsbox-material#ubaryd#seti#cake16#ChocolateLiquor#neverland2#meta5#hotpot#VibrantFin#wwdc17#autumn#sadek1'



      let x = match( colorstring, "#", g:themeindex )
      let y = match( colorstring, "#", x + 1 )
      let g:themeindex = x + 1
      if y == -1
         let g:themeindex = 0
      else
         let themestring = strpart(colorstring, x + 1, y - x - 1)
         return ":colorscheme ".themestring
      endif
   endwhile
endfunction
nnoremap <F8> :execute RotateColorTheme()<CR>:syn on<CR>
" nnoremap <F8> :execute RotateColorTheme()<CR>
" nnoremap <F8> :execute RotateColorTheme()<CR>:call SetColors()<CR>
" }}}

" {{{ CustomFoldText
"http://www.gregsexton.org/2011/03/improving-the-text-displayed-in-a-fold/
function! CustomFoldText()
    "get first non-blank line
    let fs = v:foldstart
    while getline(fs) =~ '^\s*$' | let fs = nextnonblank(fs + 1)
    endwhile
    if fs > v:foldend
        let line = getline(v:foldstart)
    else
        let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
    endif

    let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
    let foldSize = 1 + v:foldend - v:foldstart
    let foldSizeStr = " " . foldSize . " lines "
    let foldLevelStr = repeat("+--", v:foldlevel)
    let lineCount = line("$")
    let foldPercentage = printf("[%.1f", (foldSize*1.0)/lineCount*100) . "%] "
    let expansionString = repeat(".", w - strwidth(foldSizeStr.line.foldLevelStr.foldPercentage))
    return line . expansionString . foldSizeStr . foldPercentage . foldLevelStr
endf

:set foldtext=CustomFoldText()
" }}}

" {{{ MaximizeToggle
function! MaximizeToggle()
  if exists("s:maximize_session")
    exec "source " . s:maximize_session
    call delete(s:maximize_session)
    unlet s:maximize_session
    let &hidden=s:maximize_hidden_save
    unlet s:maximize_hidden_save
  else
    let s:maximize_hidden_save = &hidden
    let s:maximize_session = tempname()
    set hidden
    exec "mksession! " . s:maximize_session
    only
  endif
endfunction

nnoremap <C-W>O :call MaximizeToggle ()<CR>
nnoremap <C-W>o :call MaximizeToggle ()<CR>
nnoremap <C-W><C-O> :call MaximizeToggle ()<CR>
" }}}


" {{{ Watch for changes
" From :::http://vim.wikia.com/wiki/Have_Vim_check_automatically_if_the_file_has_changed_externally
" Autoload changed files ...
" If you are using a console version of Vim, or dealing
" with a file that changes externally (e.g. a web server log)
" then Vim does not always check to see if the file has been changed.
" The GUI version of Vim will check more often (for example on Focus change),
" and prompt you if you want to reload the file.
"
" There can be cases where you can be working away, and Vim does not
" realize the file has changed. This command will force Vim to check
" more often.
"
" Calling this command sets up autocommands that check to see if the
" current buffer has been modified outside of vim (using checktime)
" and, if it has, reload it for you.
"
" This check is done whenever any of the following events are triggered:
" * BufEnter
" * CursorMoved
" * CursorMovedI
" * CursorHold
" * CursorHoldI
"
" In other words, this check occurs whenever you enter a buffer, move the cursor,
" or just wait without doing anything for 'updatetime' milliseconds.
"
" Normally it will ask you if you want to load the file, even if you haven't made
" any changes in vim. This can get annoying, however, if you frequently need to reload
" the file, so if you would rather have it to reload the buffer *without*
" prompting you, add a bang (!) after the command (WatchForChanges!).
" This will set the autoread option for that buffer in addition to setting up the
" autocommands.
"
" If you want to turn *off* watching for the buffer, just call the command again while
" in the same buffer. Each time you call the command it will toggle between on and off.
"
" WatchForChanges sets autocommands that are triggered while in *any* buffer.
" If you want vim to only check for changes to that buffer while editing the buffer
" that is being watched, use WatchForChangesWhileInThisBuffer instead.
"
command! -bang WatchForChanges                  :call WatchForChanges(@%,  {'toggle': 1, 'autoread': <bang>0})
command! -bang WatchForChangesWhileInThisBuffer :call WatchForChanges(@%,  {'toggle': 1, 'autoread': <bang>0, 'while_in_this_buffer_only': 1})
command! -bang WatchForChangesAllFile           :call WatchForChanges('*', {'toggle': 1, 'autoread': <bang>0})

" WatchForChanges function
"
" This is used by the WatchForChanges* commands, but it can also be
" useful to call this from scripts. For example, if your script executes a
" long-running process, you can have your script run that long-running process
" in the background so that you can continue editing other files, redirects its
" output to a file, and open the file in another buffer that keeps reloading itself
" as more output from the long-running command becomes available.
"
" Arguments:
" * bufname: The name of the buffer/file to watch for changes.
"     Use '*' to watch all files.
" * options (optional): A Dict object with any of the following keys:
"   * autoread: If set to 1, causes autoread option to be turned on for the buffer in
"     addition to setting up the autocommands.
"   * toggle: If set to 1, causes this behavior to toggle between on and off.
"     Mostly useful for mappings and commands. In scripts, you probably want to
"     explicitly enable or disable it.
"   * disable: If set to 1, turns off this behavior (removes the autocommand group).
"   * while_in_this_buffer_only: If set to 0 (default), the events will be triggered no matter which
"     buffer you are editing. (Only the specified buffer will be checked for changes,
"     though, still.) If set to 1, the events will only be triggered while
"     editing the specified buffer.
"   * more_events: If set to 1 (the default), creates autocommands for the events
"     listed above. Set to 0 to not create autocommands for CursorMoved, CursorMovedI,
"     (Presumably, having too much going on for those events could slow things down,
"     since they are triggered so frequently...)
function! WatchForChanges(bufname, ...)
  " Figure out which options are in effect
  if a:bufname == '*'
    let id = 'WatchForChanges'.'AnyBuffer'
    " If you try to do checktime *, you'll get E93: More than one match for * is given
    let bufspec = ''
  else
    if bufnr(a:bufname) == -1
      echoerr "Buffer " . a:bufname . " doesn't exist"
      return
    end
    let id = 'WatchForChanges'.bufnr(a:bufname)
    let bufspec = a:bufname
  end

  if len(a:000) == 0
    let options = {}
  else
    if type(a:1) == type({})
      let options = a:1
    else
      echoerr "Argument must be a Dict"
    end
  end
  let autoread    = has_key(options, 'autoread')    ? options['autoread']    : 0
  let toggle      = has_key(options, 'toggle')      ? options['toggle']      : 0
  let disable     = has_key(options, 'disable')     ? options['disable']     : 0
  let more_events = has_key(options, 'more_events') ? options['more_events'] : 1
  let while_in_this_buffer_only = has_key(options, 'while_in_this_buffer_only') ? options['while_in_this_buffer_only'] : 0

  if while_in_this_buffer_only
    let event_bufspec = a:bufname
  else
    let event_bufspec = '*'
  end

  let reg_saved = @"
  "let autoread_saved = &autoread
  let msg = "\n"

  " Check to see if the autocommand already exists
  redir @"
    silent! exec 'au '.id
  redir END
  let l:defined = (@" !~ 'E216: No such group or event:')

  " If not yet defined...
  if !l:defined
    if l:autoread
      let msg = msg . 'Autoread enabled - '
      if a:bufname == '*'
        set autoread
      else
        setlocal autoread
      end
    end
    silent! exec 'augroup '.id
      if a:bufname != '*'
        "exec "au BufDelete    ".a:bufname . " :silent! au! ".id . " | silent! augroup! ".id
        "exec "au BufDelete    ".a:bufname . " :echomsg 'Removing autocommands for ".id."' | au! ".id . " | augroup! ".id
        exec "au BufDelete    ".a:bufname . " execute 'au! ".id."' | execute 'augroup! ".id."'"
      end
        exec "au BufEnter     ".event_bufspec . " :checktime ".bufspec
        exec "au CursorHold   ".event_bufspec . " :checktime ".bufspec
        exec "au CursorHoldI  ".event_bufspec . " :checktime ".bufspec

      " The following events might slow things down so we provide a way to disable them...
      " vim docs warn:
      "   Careful: Don't do anything that the user does
      "   not expect or that is slow.
      if more_events
        exec "au CursorMoved  ".event_bufspec . " :checktime ".bufspec
        exec "au CursorMovedI ".event_bufspec . " :checktime ".bufspec
      end
    augroup END
    let msg = msg . 'Now watching ' . bufspec . ' for external updates...'
  end

  " If they want to disable it, or it is defined and they want to toggle it,
  if l:disable || (l:toggle && l:defined)
    if l:autoread
      let msg = msg . 'Autoread disabled - '
      if a:bufname == '*'
        set noautoread
      else
        setlocal noautoread
      end
    end
    " Using an autogroup allows us to remove it easily with the following
    " command. If we do not use an autogroup, we cannot remove this
    " single :checktime command
    " augroup! checkforupdates
    silent! exec 'au! '.id
    silent! exec 'augroup! '.id
    let msg = msg . 'No longer watching ' . bufspec . ' for external updates.'
  elseif l:defined
    let msg = msg . 'Already watching ' . bufspec . ' for external updates'
  end

  echo msg
  let @"=reg_saved
endfunction

" From here : http://vim.wikia.com/wiki/Resize_splits_more_quickly
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
" }}}

" {{{ Jump List
" From :: http://vim.1045645.n5.nabble.com/redir-of-command-output-to-window-td1176134.html
" Here is a tiny plugin to open a quickfix window with the results of the
"jumps' command.
let jumps = {}
function! jumps.list()
    redir => jumplist
    silent jumps
    redir END
    return split(jumplist, "\n")[1:-2]
endfunction
function! jumps.makeqfix(list)
    let self['quickfixlist'] = {}
    if !empty(getqflist())
        call setqflist([])
    endif
    for jump in a:list
        if len(split(jump)) >= 4
            let filename = split(jump)[3]
            if filename !~ '^\(\/tmp\/\)\?v\d*'
                let self.quickfixlist['filename'] = filename
                let self.quickfixlist['lnum'] = split(jump)[1]
                let self.quickfixlist['col'] = split(jump)[2]
                " After the first jump the following becomes useless
                "let self.quickfixlist['text'] = "Nr: ".(split(jump)[0]+1)
                call setqflist([self.quickfixlist], 'a')
            endif
        endif
    endfor
endfunction
command! Getjumps call jumps.makeqfix(jumps.list())| copen
" }}}


" {{{ List Files in quickfix
" Added to list files in quickfix window
function! Listfiles()
    let l:list=system("find . -type f")
    set nomore
    let tmpfile = tempname()
    exe "redir! > " . tmpfile
    silent echon l:list
    redir END
    let old_efm = &efm
    set efm=%f

    if exists(":cgetfile")
        execute "silent! cgetfile " . tmpfile
    else
        execute "silent! cfile " . tmpfile
    endif

    let &efm = old_efm

    " Open the quickfix window below the current window
    botright copen

    call delete(tmpfile)
endfunction
map ,ls :call Listfiles()<CR>
" }}}

" {{{ Bullet List
function Bullet_list()
    " Using the options from http://stackoverflow.com/questions/1047400/how-to-make-vim-continue-bullet-points
    " in a function to set correct options for bullet list.
    setlocal formatoptions=ctnqro
    setlocal comments=n:*,n:#,n:#,n:->,n:-
endfunction
" }}}

" {{{ Change ColorScheme for working file
" http://vim.wikia.com/wiki/Change_the_color_scheme_to_show_where_you_are
" which file you are working on....

function Change_File_CS()
    if has('autocmd')
        " change colorscheme depending on current buffer
        " if desired, you may set a user-default colorscheme before this point,
        " otherwise we'll use the Vim default.
        " Variables used:
            " g:colors_name : current colorscheme at any moment
            " b:colors_name (if any): colorscheme to be used for the current buffer
            " s:colors_name : default colorscheme, to be used where b:colors_name hasn't been set
        if has('user_commands')
            " User commands defined:
                " ColorScheme <name>
                    " set the colorscheme for the current buffer
                " ColorDefault <name>
                    " change the default colorscheme
            command -nargs=1 -bar ColorScheme
                \ colorscheme <args>
                \ | let b:colors_name = g:colors_name
            command -nargs=1 -bar ColorDefault
                \ let s:colors_name = <q-args>
                \ | if !exists('b:colors_name')
                    \ | colors <args>
                \ | endif
        endif
        if !exists('g:colors_name')
            let g:colors_name = 'default'
        endif
        let s:colors_name = g:colors_name
        au BufEnter *
            \ let s:new_colors = (exists('b:colors_name')?(b:colors_name):(s:colors_name))
            \ | if s:new_colors != g:colors_name
                \ | exe 'colors' s:new_colors
            \ | endif
    endif
endfunc
" }}}

" {{{ Automatic Post/put file to server
function Aupost ()
    call inputsave()
    let server = input ("Which server?")
    call inputrestore()
    exec "autocmd BufWritePost * :!scp % " . input ( "Which server ?").":/opt/Roamware/scripts/operations/monitor/"
endfunction
" }}}


" {{{  MyFunction - can be used for foldtext
function! MyFunction()
  let line = getline(v:foldstart)
  let sub = substitute(line, '/\*\|\*/\|{{{\d\=', '', 'g')
  return v:folddashes . sub
endfunction
" }}}

" {{{ http://amix.dk - amix@amix.dk
" http://amix.dk/blog/post/19691#The-ultimate-Vim-configuration-on-Github
" https://github.com/amix/vimrc
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" {{{  CmdLine
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction
" }}}

" {{{ VisualSelection
function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
" }}}



" {{{ HasPaste
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction
" }}}

" {{{ BufcloseCloseIt
" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction
" }}}

" }}}



function! StartUp()
    if !exists("s:std_in") && 0 == argc()
        "NERDTree
    end
endfunction

" }}}
"
" {{{ Remove all unwanted quored lines from mail :)
"
function! RemoveUnwantedNewLines()
    :%s/\s\+$//e
    :%s/>$//e
    :%s/\n\{2,}/\r/e
endfunction

" }}}

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * call StartUp()


" {{{ Create incremental number list with selected numbers
" Source : http://vim.wikia.com/wiki/Making_a_list_of_numbers
function! Incr()
  let a = line('.') - line("'<")
  let c = virtcol("'<")
  if a > 0
    execute 'normal! '.c.'|'.a."\<C-a>"
  endif
  normal `<
endfunction
vnoremap <C-a> :call Incr()<CR>


" }}} 

" {{{  .LOG in the top of file, creates a log file
"
" create Microsoft Notepad-style log entries
" because Notepad should not have features that Vim doesn't
" uses Unix date command 
function! DateTimeStamp()
    if line('$') != 1
        if getbufline(1,1) == ['.LOG'] && line('$') == 2
            call append('$', '')
        else
            call append('$', '')
            call append('$', '')
        endif
    endif
    normal G
    " normal <C-R>=strftime("%d/%m/%Y %H:%M:%S")<CR>
    keepjumps exe 's#^#+ <' . strftime("%d/%m/%Y %H:%M:%S") . '>#e'

    call append('$', '')
    normal G
endfunction

augroup actions
    autocmd!
    "autocmd FileType work call DateTimeStamp()
    autocmd BufRead * if getbufline(1,1) == ['.LOG'] | call DateTimeStamp() | endif
augroup end
" nnoremap <F10> :call DateTimeStamp()<cr>i
" inoremap <F10> <Esc><F5>

" inoremap <f5> <esc>:call DateTimeStamp()<cr>i

" }}}
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Here begins my automated wordcount addition.
" This combines several ideas from:
" http://stackoverflow.com/questions/114431/fast-word-count-function-in-vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:word_count="<unknown>"
function WordCount()
    return g:word_count
endfunction
function UpdateWordCount()
    let lnum = 1
    let n = 0
    while lnum <= line('$')
        let n = n + len(split(getline(lnum)))
        let lnum = lnum + 1
    endwhile
    let g:word_count = n
endfunction
" Update the count when cursor is idle in command or insert mode.
" Update when idle for 1000 msec (default is 4000 msec).
set updatetime=1000
augroup WordCounter
    au! CursorHold,CursorHoldI * call UpdateWordCount()
augroup END
" Set statusline, shown here a piece at a time
highlight User1 ctermbg=green guibg=green ctermfg=black guifg=black
