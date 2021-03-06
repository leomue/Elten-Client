require("win32api")
require("seven_zip_ruby")
def run(file)
  params = 'LPLLLLLLPP'
createprocess = Win32API.new('kernel32','CreateProcess', params, 'I')
    env = 0
           env = "Windows".split(File::PATH_SEPARATOR) << nil
                  env = env.pack('p*').unpack('L').first
         startinfo = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    startinfo = startinfo.pack('LLLLLLLLLLLLSSLLLL')
    procinfo  = [0,0,0,0].pack('LLLL')
        createprocess.call(0, file, 0, 0, 0, 0, 0, 0, startinfo, procinfo)
            return procinfo[8,4].unpack('L').first # pid
          end
begin
    $appdata = "\0" * 16384
Win32API.new("kernel32","GetEnvironmentVariable",'ppi','i').call("appdata",$appdata,$appdata.size)
for i in 0..$appdata.size - 1
$appdata = $appdata.sub("\0","")
end
$eltendata = $appdata + "\\elten"
$configdata = $eltendata + "\\config"
$bindata = $eltendata + "\\bin"
$langdata = $eltendata + "\\lng"
cmd = $*.to_s
cmd.gsub("/wait") do
sleep(3)
end
$url = "https://elten-net.eu/"
Win32API.new("urlmon","URLDownloadToFile",'ppplp','i').call(nil,$url + "redirect","redirect",0,nil)
Win32API.new("wininet","DeleteUrlCacheEntry",'p','i').call($url + "redirect")
    if FileTest.exist?("redirect")
      rdr = IO.readlines("redirect")
      File.delete("redirect") if $DEBUG != true
      if rdr.size > 0
          if rdr[0].size > 0
            $url = rdr[0].delete("\r\n")
            end
        end
      end
Win32API.new("user32","MessageBeep",'i','i').call(0)
Win32API.new("kernel32","CreateDirectory",'pp','i').call($bindata,nil)
Win32API.new("kernel32","CreateDirectory",'pp','i').call($configdata,nil)
Win32API.new("kernel32","CreateDirectory",'pp','i').call($langdata,nil)
Win32API.new("urlmon","URLDownloadToFile",'pppip','i').call(nil,url = $url + "bin/elten.exe",$bindata + "\\elten.exe",0,nil)
Win32API.new("wininet","DeleteUrlCacheEntry",'p','i').call(url)
Win32API.new("urlmon","URLDownloadToFile",'pppip','i').call(nil,url = $url + "bin/elten.ini",$bindata + "\\elten.ini",0,nil)
Win32API.new("wininet","DeleteUrlCacheEntry",'p','i').call(url)
Win32API.new("user32","MessageBeep",'i','i').call(0)
if Win32API.new("kernel32","GetUserDefaultUILanguage",'v','i').call != 1045
Win32API.new("urlmon","URLDownloadToFile",'pppip','i').call(nil,url = $url + "lng/EN_US.elg",$langdata + "\\EN_US.elg",0,nil)
Win32API.new("wininet","DeleteUrlCacheEntry",'p','i').call(url)
iniw = Win32API.new('kernel32','WritePrivateProfileString','pppp','i')
iniw.call('Language','Language',"EN_US",$configdata + "\\language.ini")
end
Win32API.new("urlmon","URLDownloadToFile",'ppplp','i').call(nil,$url + "bin/download/elten.7z",$bindata + "\\elten.7z",0,nil)
Win32API.new("wininet","DeleteUrlCacheEntry",'p','i').call($url + "bin/download/elten.7z")
SevenZipRuby::Reader.open_file($bindata + "\\elten.7z") do |szr|
  szr.extract(:all, $bindata + "\\elten")
end
run("#{$bindata}\\elten.exe")
end