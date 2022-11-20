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
      let colorstring = 'mayansmoke#256-jungle#sienna#wood#hhspring#darkblue2#DimGreens#breeze#parsec#cabin#pt_black#beauty256#molokai_dark#late_evening#ut.vim#white_1#cleanroom#lucius#bluechia#ChocolateLiquor#guepardo#advantage#wombat256i#VibrantInk#Black#antares#corn#base16-railscasts#textmate16#cleanphp#RailsEnvy#leo#robokai#neverland2-darker#luinnar#dawn#clean#desertedoceanburnt#bluedrake#vividchalk#ansi_blows#kib_plastic#maroloccio2#fx#base16-atelierseaside#codeblocks_dark#midnight#ibmedit#peachpuff#monoindustrial#woju#corporation#selenitic#cascadia#moonshine_lowcontrast#bandit#colorsbox-stnight#mud#DarkDefault#desertEx#lizard256#256_redblack#southwest-fog#chela_light#twilight256#desertink#psclone#getfresh#dusk#asmdev#warez#materialbox#sunburst#koehler#vc#OceanicNext#widower#birds-of-paradise#sol-term#relaxedgreen#grayorange#lumberjack#VIvid#desert#phphaxor#gotham#dragon#TextExMachina#codepaper#pyte#visualstudio#CSSEdit#codeburn#pic#mango#gobo#magicwb#lettuce#imperial#blackboard#carvedwoodcool#montz#ekin.vim#rme#hhdmagenta#dagon#gemcolors#hybrid#Django#duotone-darkpool#fruit#BlackPearlII#neverland2#LightSlate#synic#fine_blue#trogdor#penultimate#nedit#rcg_gui#base#zen#badwolf#stonewashed-256#neon#tolerable#skittles_berry#bubblegum-256-dark#dual#PaperColor#kalahari#nightshade_print#vcbc#eclipse#softbluev2#Blue2#darkocean#cobaltish#hotpot#toxic#no_quarter#ChocolatePapaya#behelit#silent#grb256#darkZ#kkruby_1#icansee#lapis256#tidy#vexorian#paradox#tangoshady#base16-atelierlakeside#dw_cyan#tango_1#prmths#miko#elflord#michael#underwater-mod#pw#seashell#mushroom#kellys#blugrine#abbott#heroku#af#swamplight#candyman#navajo-night#base16-atelierheath#256_noir#typofree#hhdgreen#rdark-terminal#oh-la-la#fu#Freckle#tcsoft#base16-atelierdune#coldgreen#xoria256#soda#nuvola#blueshift#LightDefaultGrey#materialtheme#simple256#nightflight2#kaltex#mrpink#cake16#flatlandia#rgbr#nightsky#benlight#sprinkles#colorsbox-faff#pencil#zenburn#pf_earth#obsidian#nicotine#tibet#charon#darktango#yaml#whitebox#darkroom#settlemyer#dw_green#hybrid-light#coffee#SlateDark#rainbow_fine_blue#robinhood#mod_tcsoft#morning#neon-pk#hhpink#gruvbox#autumn_1#colorscheme_template#MultiMarkdown#gor#hhdcyan#cobalt_1#osx_like#yeller#stackoverflow#ego#mophiaDark#LightGreen#lizard#murphy#Dark#rainbow_sea#kruby#colorful256#simplewhite#felipec#scite#manuscript#deepsea#my_inkpot#duotone-darkpark#freya#VibrantTango#ps_color#vylight#256_darkdot#jellyx#zazen_1#sonofobsidian#grape#terse#lanzarotta#mrkn256#radicalgoodspeed#preto#doriath#dw_orange#rslate#FadetoGrey#evening_2#calmar256-dark#moria#brown#bluegreen#graywh#kib_darktango#asmdev2#tabula#google-prettify#twilight#calmar256_light#zellner#xian#vilight#fnaqevan#hhdblue#sonoma#colorsbox-steighties#oh-l_l#oceanblack#seoul256#taqua#colorsbox-stblue#zazen#flattened_dark#predawn#base16-ateliersavanna##rant.vim#silent_1#mdark#northsky#oxeded#charged-256#mellow#orange#elisex#neverness#obsidian2#LightTan#256_blackdust#maroloccio#rgb_colors#lilydjwg_dark#eddie#c16gui#oceandeep#sexy-railscasts#IR_Black#elrodeo#idleFingers#chrysoprase#wuye#ForLaTeX#neverland-darker#xorium#baobaozhu#d8g_04#harlequin#astroboy#slate2#gardener#hybrid_reverse#earthburn#wombat256mod#sift#buddy#torte#softlight#monokai-chris#lightning#d8g_02#Tomorrow-Night-Bright#lxvc#genericdc#delek#symfony#LightGrey#darkdot#monokain#apprentice#rainbow_night#thor#golden#native#bclear#dw_yellow#print_bw#256-gra.vim#cake#kalisi#gaea#pychimp#monoacc#devbox-dark-256#SweetCandy#simplergb#loogica#python#laederon#hornet#up#smpl#vombato#base16-ateliercave#amethyst#bigbang#chance-of-storm#sole#cool#Coda#railscasts_1#duotone-darksea#C64#IR_White#znake#tetragrammaton#BlackPearl#omen#olive#blue_sky#newspaper#flatcolor#duotone-darkheath#inkpot_1#calmbreeze#pride#thestars#blackdust#blazer#darkspectrum#Pastie#nline.vim#tomatosoup#Putty#frood#duotone-darkearth#hhdgray#royalking#underwater#professional#onedark#editplus#phpx#busierbee#inori#256_automation#ron#wombat256#louver#desertedocean#spring#contrasty#rainbow_neon#darkburn#babymate256#pacific#seoul256-light#calm#Green#gryffin#darker-robin#latte#brogrammer#simple-dark#gotham256#industrial#base16-atelierplateau#dull#darth#enzyme#default#wolfpack#eva#almost-default#aldmeris#eva01#cgpro#blink#billw#Spink#shekhar#emacs#mirodark#custom#paintbox#Smoothy#ecostation#nightshimmer#herokudoc#light2011#darkzen#kkruby#orangeocean256#pw_1#darkdevel#golded#cthulhian#Tomorrow#literal_tango#Benokai#reliable#earth#mojave#bluez#xoria256m#rainbow_fruit#neonwave#jellybeans#pleasant#ubloh#jhdark#vividchalk_1#inkpot#intellij#graywh_1#tchaba#reloaded#manxome#valloric#dw_red#blue_1#autumn#nightflight#mophiaSmoke#colorsbox-stbright#jaime#simpleandfriendly#fluka#tortex#duotone-darkmeadow#nevfn#blackbeauty#base16-atelierestuary#hemisu#Mustang#nazca#earendel#CodeFactoryv3#nu42dark#madeofcode#wombat#motus#Blue#sky#martin_krischik#toothpik#astronaut#Tomorrow-Night-Blue#vo_dark#bayQua#carvedwood#EspressoTutti#nightshade#basic#pablo#leglight2#proton#PapayaWhip#oceanblack256#blueprint#xemacs#shobogenzo#tchaba2#RDark#desert-warm-256#risto#base16-atelierforest#scooby#cobalt#peaksea#understated#wargrey#termschool#vanzan_color#vilight_1#Red#FriendshipBracelet#simplon#flattr#RyanLight#base16-ateliersulphurpool#neopro#google#railscasts2#hhorange#zmrok#revolutions#darkrobot#fruity#dark-ruby#blacklight#mac_classic#Fluidvision#midnight2#peppers#smyck#SwyphsII#scheakur#MountainDew#darkblack#LightDefault#leya#herald#alduin#greyblue#redblack#GlitterBomb#random#VibrantFin#phoenix#thornbird#skittles_dark#c#thinkpad#zephyr#shades-of-teal#crayon#lightcolors#khaki#Chasing_Logic#genericdc-light#colorsbox-greenish#ashen#win9xblueback#solarized#BBEdit#atom#adrian#Dark2#primary#briofita#autumn2#umber-green#chocolate#pyte_2#moonshine#bocau#White#256_asu1dark#habiLight#getafe#northland#bubblegum-256-light#donbass#ex_lightgray#askapache#grishin#tony_light#duotone-darkspace#autumnleaf#Railscasts#Starlight#navajo_night#hhteal#spectro#bog#dejavu#Tubster#dw_blue#h80#rhinestones#lucid#frozen#pspad#doorhinge#summerfruit#jammy#brookstream#forneus#industry#edo_sea#watermark#ciscoacl#simple_b#lodestone#delphi#otaku#candy#strawimodo#perfect#Revolution#3dglasses#made_of_code#krTheme#paper#playroom#tangolight#BlackboardBlack#tangoX#GitHub#vj#calmar256_dark#lightdiff#anotherdark#aqua#meta5#night_vision#elrond#sol#black_angus#heroku-terminal#duotone-darkcave#d8g_03#ayumi#SummerCamp#Tomorrow-Night-Eighties#void#compot#bjornenki-colorscheme#triplejelly#molokai#sven#seoul#spiderhawk#rainbow_autumn#deveiate#xterm16#tango-desert#jiks#seti#clue#MerbivoreSoft#asmanian_blood#nour#hhdred#automation#bubblegum#bwn#twitchy#lingodirector#tir_black#wf#nightwish#iceberg#camo#elise#psql#desert256#tutticolori#masmed#colorsbox-material#sean#darkeclipse#night#hickop#less#tayra#autumnleaf_modified#nefertiti#tropikos#legiblelight#erez#luna-term#kalt#sorcerer#ubaryd#1989#material#tango-morning#vydark#skyweb#norwaytoday#sand#tesla#eclm_wombat#summerfruit256#CandyPaper#DimRed#adaryn#diablo3#idle#mizore#maui#oceanlight#itg_flat#warm_grey#transparent#rakr-light#neutron#flattown#asu1dark#adam#iangenzo#rastafari#phd#asmanian2#chlordane#darkBlue#zenesque#fake#stingray#disciple#trivial256#SORuby#vo_light#muon#dante#mint#shine#fruidle#White2#deepblue#marklar#impact#fisa#Lowlight#caramel#smp#mickeysoft#hybrid_material#CloudsMidnight#Happyhappyjoyjoy2#biogoo#elda#surveyor#telstar#shadesofamber#SummerCampMod#capsulapigmentorum#flatui#AllHallowsEveCustom#ex#fine_blue2#DimSlate#far#Argonaut#wellsokai#colorzone#material-theme#strange#duotone-darkforest#carrot#mopkai#Tango#scala#anderson#BlackSea#bvemu#jhlight#desert256v2#xmaslights.bak#xmaslights.bak#anokha#southernlights#Light#rcg_term#kiss#hhazure#d8g_01#earendel_1#potts#moss#developer#Spectacular#hhviolet#liquidcarbon#nightVision#pink#jelleybeans#DevC++#Mahewincs#herokudoc-.vim#navajo#Clouds#colorer#detailed#baycomb#sf#lilydjwg_green#nedit2#hhdyellow#darkbone#greenvision#saturn#evening#0x7A69_dark#nature#highlights_for_radiologist#duotone-dark#wintersday#ekvoli#sandydune#greens#royaltango#werks#dw_purple#sorcerer_1#aiseered#soso#matrix#impactG#cobalt2#gothic#Tomorrow-Night#LightYellow#neverland#burnttoast256#dubs#beekai#janah#duotone-darkdesert#enigma#darkblue_1#candycode#impactjs#quagmire#cmd#autumn_2#whitedust#borland#fokus#darkerdesert#ironman#feral#lilac#tango2#scame#lilypink#heliotrope#kolor#two2tango#buttercream#EmacsStrict#last256#refactor#thinkpad_nerdtree#Slate#sourcerer#twilight_1#stonewashed-gui#kate#lazarus#Bongzilla#evolution#Monokai#Dim2#beachcomber#grey2#cloudy#mod8#darkslategray#bw#Django'



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
