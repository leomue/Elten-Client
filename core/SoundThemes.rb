#Elten Code
#Copyright (C) 2014-2016 Dawid Pieper
#All rights reserved.


#Open Public License is used to licensing this app!

class Scene_SoundThemes
  def main(canceled=false)
    @return = false
stmp = Win32API.new($eltenlib,"FilesInDir",'p','p').call($soundthemesdata + "\\inis")
stm = []
c = 0
stm[c] = ""
for i in 0..imax = stmp.size - 1
  stm[c] += stmp[i..i]
  if stmp[i..i] == "\n"
    c += 1
    stm[c] = "" if i != imax
    end
  end
  st = []
  for i in 0..stm.size - 1
    stm[i].delete!("\n")
    st.push(stm[i]) if stm[i] != "." and stm[i] != ".."
    end
@st = st
$soundtheme = [0..st.size - 1]
for i in 0..st.size - 1
      $soundtheme[i] = "\0" * 64
    Win32API.new("kernel32","GetPrivateProfileString",'pppplp','i').call("SoundTheme","Name","\0",$soundtheme[i],$soundtheme[i].size,$soundthemesdata + "\\inis\\" + st[i])
    $soundtheme[i].delete!("\0")
  end
  if st.size <= 0
    speech("Brak tematów dźwiękowych.")
    speech_wait
    if canceled == false
    stdownload
  else
    $scene = Scene_Main.new
    end
return
  end
  @stsize = $soundtheme.size
  $soundtheme.push("Temat Domyślny")
  Graphics.update
  speech("Tematy dźwiękowe.")
  speech_wait
  @selt = $soundtheme
  @selt.push("Pobierz tematy dźwiękowe")
  @sel = Select.new(@selt)
  loop do
loop_update
    @sel.update
    update
    if $scene != self or @return == true
      break
      end
    end
  end
  def update
    if escape
      delay
      $scene = Scene_Main.new
    end
    if enter
            if @sel.index < @stsize
      $soundthemepath = "\0" * 64
    Win32API.new("kernel32","GetPrivateProfileString",'pppplp','i').call("SoundTheme","Path","\0",$soundthemepath,$soundthemepath.size,$soundthemesdata + "\\inis\\" + @st[@sel.index])
    $soundthemepath.delete!("\0")
    tmp = $soundthemesdata + "\\" + $soundthemepath
    @name = $soundthemepath
    if $soundthemepath.size < 1
      $soundthemepath = ""
      @name = ""
      speech("Błąd.")
      speech_wait
      delay(1)
    else
      $soundthemepath = tmp
      end
    elsif @sel.index == @st.size
            $soundthemepath = ""
            @name = ""
          else
            stdownload
            @return = true
            return
    end
                   iniw = Win32API.new('kernel32','WritePrivateProfileString','pppp','i')
                iniw.call('SoundTheme','Path',@name,$configdata + "\\soundtheme.ini") 
                speech("Zapisano.")
                speech_wait
                          $soundthemespath = "\0" * 64
    Win32API.new("kernel32","GetPrivateProfileString",'pppplp','i').call("SoundTheme","Path","",$soundthemespath,$soundthemespath.size,$configdata + "\\soundtheme.ini")
    $soundthemespath.delete!("\0")
    if $soundthemespath.size > 0
    $soundthemepath = $soundthemesdata + "\\" + $soundthemespath
  else
    $soundthemepath = "Audio"
    end
    $scene = Scene_Main.new
      end
    end
    def stdownload
      sttemp = srvproc("soundthemes","name=#{$name}\&token=#{$token}")
            err = sttemp[0].to_i
      if err < 0
        speech("Błąd.")
        speech_wait
        $scene = Scene_Main.new
        return
      end
      @st_name = []
      @st_path = []
      @st_file = []
   for i in 1..sttemp.size - 1
     sttemp[i].delete!("\n")
     download($url + sttemp[i],"st.ini")
     @st_file[i] = sttemp[i]
   st_name = "\0" * 256
   st_path = "\0" * 256
   Win32API.new("kernel32","GetPrivateProfileString",'pppplp','i').call("SoundTheme","Name","\0",st_name,st_name.size,".\\st.ini")
   Win32API.new("kernel32","GetPrivateProfileString",'pppplp','i').call("SoundTheme","Path","\0",st_path,st_path.size,".\\st.ini")
   @st_name[i] = st_name
   @st_path[i] = st_path
   @st_name[i].delete!("\0")
   @st_path[i].delete!("\0")
   File.delete("st.ini") if $DEBUG != true
 end
 speech("Wybierz temat do pobrania.")
 speech_wait
 @sel = Select.new(@st_name)
 for i in 0..@st_name.size - 1
   if @st_name[i] != nil
   if @st_name[i].size > 0
     speech(@st_name[i])
     break
   end
   end
   end
 loop do
   loop_update
   @sel.update
   if escape
     delay
     main(canceled=true)
     return
   end
   if enter
     delay
     downloadtheme(@st_file[@sel.index + 1],@st_name[@sel.index + 1],@st_path[@sel.index + 1])
     return
     end
   end
 end
 def downloadtheme(ini,name,path)
bgmt = Win32API.new($eltenlib,"FilesInDir",'p','p').call(".\\Audio\\BGM")
bgst = Win32API.new($eltenlib,"FilesInDir",'p','p').call(".\\Audio\\BGS")
met = Win32API.new($eltenlib,"FilesInDir",'p','p').call(".\\Audio\\ME")
set = Win32API.new($eltenlib,"FilesInDir",'p','p').call(".\\Audio\\SE")
bgm = []
c = 0
bgm[c] = ""
for i in 0..imax = bgmt.size - 1
    bgm[c] += bgmt[i..i] if bgmt[i..i] != "\n"
  if bgmt[i..i] == "\n"
    c += 1
    bgm[c] = "" if i != imax
    end
  end
  bgs = []
c = 0
bgs[c] = ""
for i in 0..imax = bgst.size - 1
  bgs[c] += bgst[i..i] if bgst[i..i] != "\n"
  if bgst[i..i] == "\n"
    c += 1
    bgs[c] = "" if i != imax
    end
  end
  me = []
c = 0
me[c] = ""
for i in 0..imax = met.size - 1
  me[c] += met[i..i] if met[i..i] != "\n"
  if met[i..i] == "\n"
    c += 1
    me[c] = "" if i != imax
    end
  end
  se = []
c = 0
se[c] = ""
for i in 0..imax = set.size - 1
  se[c] += set[i..i] if set[i..i] != "\n"
  if set[i..i] == "\n"
    c += 1
    se[c] = "" if i != imax
    end
  end
  Win32API.new("kernel32","CreateDirectory",'pp','i').call($soundthemesdata + "\\" + path, nil)
  Win32API.new("kernel32","CreateDirectory",'pp','i').call($soundthemesdata + "\\" + path + "\\BGM",nil)
  Win32API.new("kernel32","CreateDirectory",'pp','i').call($soundthemesdata + "\\" + path + "\\BGS", nil)
  Win32API.new("kernel32","CreateDirectory",'pp','i').call($soundthemesdata + "\\" + path + "\\ME", nil)
  Win32API.new("kernel32","CreateDirectory",'pp','i').call($soundthemesdata + "\\" + path + "\\SE", nil)
  for i in 0..bgm.size - 1
    download(url = $url + "soundthemes/" + path + "/BGM/" + bgm[i],$soundthemesdata + "\\" + path + "\\BGM\\" + bgm[i])
    loop_update
  end
  for i in 0..bgs.size - 1
    download(url = $url + "soundthemes/" + path + "/BGS/" + bgs[i],$soundthemesdata + "\\" + path + "\\BGS\\" + bgs[i])
    loop_update
  end
    for i in 0..me.size - 1
    download(url = $url + "soundthemes/" + path + "/ME/" + me[i],$soundthemesdata + "\\" + path + "\\ME\\" + me[i])
    loop_update
  end
    for i in 0..se.size - 1
    download(url = $url + "soundthemes/" + path + "/SE/" + se[i],$soundthemesdata + "\\" + path + "\\SE\\" + se[i])
    loop_update
  end
  download(url = $url + ini,$eltendata + "/" + ini)
  speech("Zapisano")
  speech_wait
  main
  return
   end
end
#Copyright (C) 2014-2016 Dawid Pieper