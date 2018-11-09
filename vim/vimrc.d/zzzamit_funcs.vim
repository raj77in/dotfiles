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
      "let colorstring = "inkpot#ron#blue#elflord#evening#koehler#murphy#pablo#desert#torte#"
      let colorstring = 'dw_cyan#CSSEdit#disciple#dull#seoul256-light#herald#tabula#reloaded#anokha#feral#stackoverflow#lilydjwg_dark#redblack#neverland2#whitebox#oh-la-la#michael#muon#neopro#kolor#chlordane#256_blackdust#rtl#sky#spiderhawk#skyweb#vimhut#solarized#ir_black#cake#oceanblack#adrian#mellow#zellner#kyle#tangoshady#Fluidvision#win9xblueback#sexy-railscasts#lanzarotta#lightning#Blue2#coldgreen#d8g_01#desert256#compot#256-grayvim#editplus#scala#darker-robin#blueshift#warm_grey#paintbox#dracula#mopkai#graywh#elisex#xian#bwn#woju#ChocolateLiquor#manxome#taqua#predawn#evening#eclm_wombat#default#benlight#busybee#pw#aiseered#twilight#dagon#elflord#rainbow_sea#Django#BlackboardBlack#Putty#deepsea#flatui#biogoo#colorsbox-faff#luna-term#idleFingers#wuye#rslate#Mahewincs#krTheme#twilight_1#fluka#google-prettify#oceanblack256#twitchy#aurora#silent_1#selenitic#relaxedgreen#lilypink#hhdred#cobalt2#earendel_1#nightshade_print#cloudy#mophiaDark#devbox-dark-256#basic#brogrammer#neon#billw#vim-online#base16-atelierplateau#widower#ChocolatePapaya#colorsbox-stnight#behelit#xmaslights.bak#sea#moria#blacklight#codefactoryv3#alduin#simplewhite#PapayaWhip#paper#southwest-fog#dual#briofita#sourcerer#dubs#abbott#spacegray#pspad#Argonaut#CandyPaper#Espresso#duotone-darkheath#orange#habiLight#aqua#asmanian2#tchaba2#ubaryd#symfony#tangolight#beachcomber#vj#nightwish#termschool#Light#rainbow_neon#github#bensday#trogdor#zenesque#hhpink#bigbang#tango2#material-theme#amethyst#ron#colorer#wombat256i#blueprint#wood#tibet#Dark2#adam#motus#VibrantTango#radicalgoodspeed#ecostation#duotone-darkspace#campfire#nicotine#deveiate#vc#textmate16#felipec#shine#DarkDefault#cleanphp#beekai#midnight#preto#scite#White#softlight#atom#industrial#flatlandia#jhlight#rgb_colors#ForLaTeX#surveyor#IR_White#telstar#doriath#scooby#peaksea#midnight2#colorsbox-steighties#mud#DimGrey#frozen#anderson#neverland2-darker#codeschool#monochrome#no_quarter#kib_darktango#CloudsMidnight#base16-atelierheath#nerv-ous#duotone-darkcave#donbass#hhteal#Monokai#pride#base16-ateliersulphurpool#rastafari#materialtheme#graywh_1#gentooish#liquidcarbon#sf#lightcolors#herokudoc-gvim#molokai#Coda#kate#tango#seoul#256-jungle#oceandeep#bayqua#duotone-darkforest#darkocean#light2011#kruby#habilight#elda#desertedocean#nu42dark#dw_purple#jelleybeans#kkruby_1#enigma#bclear#robokai#slate2#chocolate#codepaper#greens#wintersday#colorsbox-stbright#grey2#thinkpad_nerdtree#almost-default#Tomorrow-Night-Blue#asmdev#koehler#tutticolori#cgpro#ex_lightgray#simple256#darkz#blackbeauty#cabin#base16-atelierlakeside#parsec#thegoodluck#coda#VibrantInk#enzyme#sadek1#universal-blue#lemon256#moonshine_lowcontrast#flatland#neverness#tortex#base16-atelierdune#elrodeo#frood#heroku-terminal#mickeysoft#duotone-darkmeadow#DimGreens#omen#visualstudio#elise#desertedoceanburnt#clean#carvedwoodcool#morning#256_noir#carvedwood#MerbivoreSoft#sol-term#duotone-darkearth#base#tony_light#tesla#nedit2#olive#256_asu1dark#MultiMarkdown#two2tango#rainbow_fine_blue#prmths#256_redblack#bluechia#Smoothy#norwaytoday#LightDefaultGrey#fokus#phoenix#dejavu#bandit#Lowlight#hhorange#d8g_02#potts#impactG#vydark#buttercream#quagmire#DimBlue#python#playroom#delphi#white#colorzone#nefertiti#vo_light#imperial#tayra#brookstream#masmed#wombat256mod#rme#colorscheme_template#calmar256_light#lodestone#xmaslights#railscasts#pychimp#louver#kib_plastic#dragon#vibrantink#obsidian2#corporation#Merbivore#vilight#industry#vividchalk#far#maroloccio3#buddy#simple-dark#railscasts2#mophiasmoke#Dim2#otaku#nevfn#EspressoTutti#cmd#trivial256#nightflight2#dw_red#zephyr#sorcerer#vylight#tango-morning#0x7A69_dark#duotone-darkpool#asu1dark#emacs#rainbow_fruit#satori#impactg#duotone-darksea#neverland#desert-warm-256#legiblelight#zen#whitedust#fu#mophiadark#desertex#gothic#dusk#kkruby#idle#southernlights#mango#maroloccio#clearance#nuvola#getfresh#Red#d8g_04#royaltango#manuscript#custom#Clouds#hhdgray#zazen#hhdmagenta#gummybears#eva01#dw_green#strawimodo#borland#rdark-terminal#neverland-darker#vanzan_color#evening1#OceanicNext#duotone-darklake#lizard#goodwolf#devc++#yaml#genericdc#underwater#soda#tetragrammaton#rhinestones#inori#darkroom#jiks#candy#summerfruit256#simple_b#phphaxor#sol#evolution#vexorian#lxvc#royalking#Blue#autumn_1#seashell#sift#darkblue_1#evening_2#pf_earth#DimRed#ashen#dw_blue#calm#beauty256#gryffin#simplergb#LightSlate#murphy#harlequin#BlackSea#scame#montz#bog#kalisi#asmanian_blood#professional#256_adaryn#hhviolet#iangenzo#colorsbox-material#molokai_dark#perfect#kiss#shekhar#mophiaSmoke#desertEx#tcsoft#maui#Railscasts#pt_black#base16-atelierestuary#VibrantFin#blazer#redstring#underwater-mod#spectro#hhdgreen#c#chela_light#meta5#pencil#festoon#itg_flat#calmar256-light#hotpot#black_angus#flattened_dark#navajo_night#crayon#base16-ateliercave#sorcerer_1#grishin#darktango#blugrine#colorful#spring#fruit#rakr-light#paradox#camo#blue_1#ambient#putty#dante#dawn#darth#bayQua#metacosm#jammy#heroku#late_evening#leglight2#shadesofamber#gotham256#gruvbox#askapache#monoacc#ego#xoria256#1989#hybrid_material#abra#simpleandfriendly#bubblegum-256-light#darkslategray#anotherdark#Benokai#obsidian#SummerCampMod#autumn_2#fruidle#sonofobsidian#stingray#freya#jaime#wombat256#luna#skittles_berry#baycomb#SORuby#intellij#genericdc-light#kellys#my_inkpot#BBEdit#hhdblue#blackdust#Tubster#ibmedit#navajo#Slate#print_bw#corn#material#night_vision#rainbow_autumn#soso#SlateDark#osx_like#ironman#grape#toothpik#bw#gemcolors#Tomorrow#warez#base16-atelierseaside#base16-railscasts#cobalt_1#flattened_light#forneus#GitHub#CodeFactoryv3#xemacs#seti#eddie#highlights_for_radiologist#mars#monokai-chris#autumn2#impactjs#chance-of-storm#nightshimmer#mushroom#Dev_Delight#rgbr#codeblocks_dark#vilight_1#SweetCandy#hhdcyan#SwyphsII#umber-green#Django(Smoothy)#caramel#smpl#hhazure#nour#lightdiff#mojave#vividchalk_1#leya#void#bubblegum#blaquemagick#shades-of-teal#greyhouse#ex#pleasant#nedit#leo#darkblack#tir_black#argonaut#White2#bmichaelsen#BusyBee#cobalt#navajo-night#developer#Happyhappyjoyjoy2#ps_color#jellyx#SummerCamp#onedark#3dglasses#oceanlight#Tomorrow-Night#sean#blink#Starlight#kalt#pic#fnaqevan#flatcolor#mrkn256#zmrok#skittles_dark#getafe#phpx#scheakur#calmbreeze#darkBlue#thestars#capsulapigmentorum#zenburn#pyte#softbluev2#darkerdesert#vo_dark#derefined#ayumi#mustang#breeze#asmdev2#AllHallowsEveCustom#orangeocean256#ingretu#toxic#synic#literal_tango#h80#golden#sven#Dim#papayawhip#transparent#Freckle#cthulhian#RailsEnvy#latte#LightYellow#adobe#winter#bluez#LightDefault#random#mrpink#GlitterBomb#BlackPearlII#darkdevel#gardener#bjornenki-colorscheme#znake#EmacsStrict#hybrid-light#fx#babymate256#eva#grb256#guardian#neon-pk#neutron#refactor#desertink#lazarus#rainbow_breeze#badwolf#pink#contrasty#greenvision#apprentice#grayorange#nazca#Black#c16gui#peppers#typofree#denim#darkbone#candyman#darkrobot#mountaindew#seattle#VIvid#mdark#cobaltish#ekinivim#blue_sky#ir_black.vim.1#astronaut#tropikos#carrot#oxeded#coffee#ciscoacl#twilight256#earth#psql#IR_Black#blacksea#oh-l_l#cleanroom#Pastie#martin_krischik#dw_orange#tolerable#sand#brown#Tomorrow-Night-Bright#erez#jellybeans#darkblue2#FadetoGrey#gravity#flattr#dark-ruby#softblue#pw_1#base16-ateliersavanna#maroloccio2#eclipse#soruby#birds-of-paradise#torte#advantage#pyte_2#penultimate#ekvoli#af#gotham#hhdyellow#gaea#rcg_gui#hybrid_reverse#calmar256-dark#chocolateliquor#burnttoast256#werks#candycode#colorsbox-greenish#northland#vombato#nightsky#made_of_code#inkpot_1#robinhood#baobaozhu#mayansmoke#codeburn#deepblue#earthburn#nightVision#wf#gor#RDark#lilac#nightvision#triplejelly#bluegreen#xmaslights.vim.bak#khaki#astroboy#diablo3#matrix#cascadia#google#colorful256#bluedrake#laederon#monoindustrial#native#hornet#moonshine#sweater#adaryn#nightflight#fine_blue#darkeclipse#256_automation#aldmeris#hhspring#Tomorrow-Night-Eighties#RyanLight#mirodark#materialbox#holokai#rdark#autumnleaf#yeller#sprinkles#charon#cake16#DimSlate#colorsbox-stblue#reliable#ubloh#seoul256#icansee#proton#inkpot#FriendshipBracelet#sierra#fake#herokudoc#fruity#landscape#silent#LightGreen#loogica#smyck#Spectacular#Chasing_Logic#slate#iceberg#hilal#base16-atelierforest#django#jhdark#newsprint#kalahari#thor#lapis256#pacific#minimalist#clarity#lucid#sandydune#xterm16#wasabi256#Revolution#Tango#rcg_term#moss#luinnar#clue#last256#LightGrey#shobogenzo#marklar#swamplight#lilydjwg_green#cool#MountainDew#tangoX#doorhinge#hybrid#sienna#less#blue#monokain#flattown#peachpuff#tango-desert#antares#elrond#revolutions#desert256v2#tomatosoup#vimbrant#ansi_blows#miko#xoria256m#phd#madeofcode#turbo#distinguished#mod_tcsoft#busierbee#thornbird#desert#up#tango_1#calmar256_dark#wolfpack#lumberjack#thinkpad#valloric#autumnleaf_modified#darkZ#smp#golded#bvemu#256_darkdot#simplon#sole#darkburn#risto#mizore#watermark#psclone#neonwave#chrysoprase#tchaba#gobo#janah#zendnb#crt#darkspectrum#TextExMachina#dw_yellow#bubblegum-256-dark#Dark#rainbow_night#hemisu#zazen_1#chocolatepapaya#fisa#Spink#DimGreen#duotone-dark#impact#lettuce#terse#kaltex#bocau#hickop#earendel#mac_classic#lizard256#greyblue#automation#darkblue#darkdot#d8g_03#iLife05#darkzen#night#duotone-darkdesert#white_1#summerfruit#delek#stonewashed-gui#primary#tidy#edo_sea#stonewashed-256#nightshade#Bongzilla#fine_blue2#C64#Green#blackboard#saturn#xorium#BlackPearl#mint#magicwb#duotone-darkpark#newspaper#LightTan#wellsokai#detailed#vcbc#settlemyer#strange#wargrey#sonoma#mod8#northsky#sunburst#fog#nature#railscasts_1#PaperColor#lingodirector#rootwater#guepardo#autumn#Mustang#DevC++#lucius#pablo#wombat#heliotrope#understated#charged-256'



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
