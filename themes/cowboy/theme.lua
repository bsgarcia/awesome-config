

--[[
                                      
     Powerarrow Dark Awesome WM theme 
     github.com/copycat-killer        
                                      
--]]


local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local os    = { getenv = os.getenv }

local theme                                     = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/cowboy"
theme.wallpaper                                 = theme.dir .. "/wall.jpg"
theme.font                                      = "xos4 Terminus 9"
theme.fg_normal                                 = "#DDDDFF"
theme.fg_focus                                  = "#ADA9A7" --"#EA6F81"
theme.fg_urgent                                 = "#CC9393"
theme.bg_normal                                 = "#404040"---"#2F343F"---"#282828"---"#1A1A1A"
theme.bg_focus                                  = "#383838"--"#2F343F"
theme.bg_urgent                                 = "#282828"
theme.border_width                              = 1.45
theme.border_normal                             = "#3F3F3F"
theme.border_focus                              = "#ADA9A7"--"#7F7F7F"
theme.border_marked                             = "#CC9393"
theme.tasklist_bg_focus                         = "#1A1A1A"
theme.taglist_bg_focus				            = "#22252E"
theme.titlebar_bg_focus                         = theme.bg_focus
theme.titlebar_bg_normal                        = theme.bg_normal
theme.titlebar_fg_focus                         = theme.fg_focus
theme.menu_height                               = 16
theme.menu_width                                = 140

-- | Taglist | --
theme.taglist_bg_empty                          = "png:".. theme.dir .. "/icons/bg_unsel2.png"
theme.taglist_bg_occupied                       = "png:".. theme.dir .. "/icons/bg_unsel2.png"
theme.taglist_bg_urgent                        = "png:" ..theme.dir .. "/icons/bg_urgent.png"
theme.taglist_bg_focus                          = "png:".. theme.dir .. "/icons/bg_not_empty.png"
--\theme.menu_submenu_icon                         = theme.dir .. "/icons/submenu.png"

--theme.taglist_squares_sel                       = theme.dir .. "/icons/square_sel.png"
--theme.taglist_squares_unsel                     = theme.dir .. "/icons/square_unsel.png"
theme.layout_tile                               = theme.dir .. "/icons/tile.png"
theme.layout_tileleft                           = theme.dir .. "/icons/tileleft.png"
theme.layout_tilebottom                         = theme.dir .. "/icons/tilebottom.png"
theme.layout_tiletop                            = theme.dir .. "/icons/tiletop.png"
theme.layout_fairv                              = theme.dir .. "/icons/fairv.png"
theme.layout_fairh                              = theme.dir .. "/icons/fairh.png"
theme.layout_spiral                             = theme.dir .. "/icons/spiral.png"
theme.layout_dwindle                            = theme.dir .. "/icons/dwindle.png"
theme.layout_max                                = theme.dir .. "/icons/max.png"
theme.layout_fullscreen                         = theme.dir .. "/icons/fullscreen.png"
theme.layout_magnifier                          = theme.dir .. "/icons/magnifier.png"
theme.layout_floating                           = theme.dir .. "/icons/floating.png"
theme.widget_ac                                 = theme.dir .. "/icons/ac.png"
theme.widget_battery                            = theme.dir .. "/icons/battery.png"
theme.widget_battery_low                        = theme.dir .. "/icons/battery_low.png"
theme.widget_battery_empty                      = theme.dir .. "/icons/battery_empty.png"
theme.widget_mem                                = theme.dir .. "/icons/mem.png"
theme.widget_cpu                                = theme.dir .. "/icons/cpu.png"
theme.widget_temp                               = theme.dir .. "/icons/temp.png"
theme.widget_net                                = theme.dir .. "/icons/net.png"
theme.widget_hdd                                = theme.dir .. "/icons/hdd.png"
theme.widget_music                              = theme.dir .. "/icons/note.png"
theme.widget_music_on                           = theme.dir .. "/icons/note_on.png"
theme.widget_vol                                = theme.dir .. "/icons/vol.png"
theme.widget_vol_low                            = theme.dir .. "/icons/vol_low.png"
theme.widget_vol_no                             = theme.dir .. "/icons/vol_no.png"
theme.widget_vol_mute                           = theme.dir .. "/icons/vol_mute.png"
theme.widget_mail                               = theme.dir .. "/icons/mail.png"
theme.widget_mail_on                            = theme.dir .. "/icons/mail_on.png"
theme.micon_on                                  = theme.dir .. "/icons/micon_on.png"
theme.micon_off                                 = theme.dir .. "/icons/micon_off.png"
theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = true
theme.useless_gap                               = 3
theme.titlebar_close_button_focus               = theme.dir .. "/icons/titlebar/close_focus.png"
theme.titlebar_close_button_normal              = theme.dir .. "/icons/titlebar/close_normal.png"
theme.titlebar_ontop_button_focus_active        = theme.dir .. "/icons/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active       = theme.dir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive      = theme.dir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive     = theme.dir .. "/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_sticky_button_focus_active       = theme.dir .. "/icons/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active      = theme.dir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive     = theme.dir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive    = theme.dir .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_floating_button_focus_active     = theme.dir .. "/icons/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active    = theme.dir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive   = theme.dir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive  = theme.dir .. "/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_maximized_button_focus_active    = theme.dir .. "/icons/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active   = theme.dir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_normal_active   = theme.dir .. "/icons/titlebar/maximized_normal_active.png"

local markup = lain.util.markup
local separators = lain.util.separators

-- {{{ Voice commander
micon = wibox.widget.imagebox(theme.micon_off)
on_off = false
micon:buttons(awful.util.table.join(awful.button({ }, 1,
function () 
    on_off = not on_off
    if on_off == true then 
        io.popen("rm /home/getz/python/SpeechRecognition/my_pid")
        io.popen("cd /home/getz/python/SpeechRecognition/ && ./speech")
        micon:set_image(theme.micon_on)
    else
        pid = io.popen("cat /home/getz/python/SpeechRecognition/my_pid")
        for i in pid:lines() do 
            io.popen("kill " .. i)
        end
        micon:set_image(theme.micon_off)
    end
end  )))


-- Textclock
local clockicon = wibox.widget.imagebox(theme.widget_clock)
local clock = lain.widget.watch({
    timeout  = 60,
    cmd      = "date +'%R'", --" date +'%a %d %b %R'",
    settings = function()
        widget:set_markup("".. markup.font(theme.font, output))

	--xflux launcher 
        --check if evening, then launch xflux
        --[[str = string.match(output, "%d%d:")]]
        --str = string.gsub(str, ":", "")
        --if io.popen("pgrep xflux"):read() == nil then
                --if tonumber(str) >= 20 or tonumber(str) <= 7 then
                    --io.popen("xflux -l 44.8351 -g  -0.5686")
		--end
	--[[end]]

	--webcam checker
	str = io.popen("lsmod | grep uvcvideo > .cam_detection && head -1 .cam_detection"):read()     
	if str:sub(string.len(str)) ~= "0" then
		io.popen("notify-send 'Watch out!'")
		io.popen("notify-send 'webcam is being used!'")
		io.popen("notify-send 'You are being watched by a filthy pervert!'")
	end 
    end
})


-- Calendar
theme.cal = lain.widget.calendar({
    attach_to = { clock.widget },
    notification_preset = {
        font = "xos4 Terminus 10",
        fg   = theme.fg_normal,
        bg   = theme.bg_normal
    }
})

-- Mail IMAP check
local mailicon = wibox.widget.imagebox(theme.widget_mail)
--[[ commented because it needs to be set before use
mailicon:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.spawn(mail) end)))
local mail = lain.widget.imap({
    timeout  = 180,
    server   = "server",
    mail     = "mail",
    password = "keyring get mail",
    settings = function()
        if mailcount > 0 then
            widget:set_text(" " .. mailcount .. " ")
            mailicon:set_image(theme.widget_mail_on)
        else
            widget:set_text("")
            mailicon:set_image(theme.widget_mail)
        end
    end
})
--]]

-- MPD
local mpdicon = wibox.widget.imagebox(theme.widget_music)
mpdicon:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.spawn_with_shell(musicplr) end)))
theme.mpd = lain.widget.mpd({
    settings = function()
        if mpd_now.state == "play" then
            artist = " " .. mpd_now.artist .. " "
            title  = mpd_now.title  .. " "
            mpdicon:set_image(theme.widget_music_on)
        elseif mpd_now.state == "pause" then
            artist = " mpd "
            title  = "paused "
        else
            artist = ""
            title  = ""
            mpdicon:set_image(theme.widget_music)
        end

        widget:set_markup(markup.font(theme.font, markup("#5294E2", artist)))
    end
})

-- MEM
local memicon = wibox.widget.imagebox(theme.widget_mem)
local mem = lain.widget.mem({
    settings = function()
        widget:set_markup(markup.font(theme.font, " " .. mem_now.used .. "MB "))
    end
})

-- CPU
local cpuicon = wibox.widget.imagebox(theme.widget_cpu)
local cpu = lain.widget.cpu({
    settings = function()
        widget:set_markup(markup.font(theme.font, " " .. cpu_now.usage .. "% "))
    end
})

-- Coretemp
local tempicon = wibox.widget.imagebox(theme.widget_temp)
local temp = lain.widget.temp({
    settings = function()
        widget:set_markup(markup.font(theme.font, " " .. coretemp_now .. "°C "))
    end
})

-- / fs
local fsicon = wibox.widget.imagebox(theme.widget_hdd)
theme.fs = lain.widget.fs({
    options  = "--exclude-type=tmpfs",
    notification_preset = { fg = theme.fg_normal, bg = theme.bg_normal, font = "xos4 Terminus 10" },
    settings = function()
        widget:set_markup(markup.font(theme.font, " " .. fs_now.used .. "% "))
    end
})

-- Battery
local baticon = wibox.widget.imagebox(theme.widget_battery)
local bat = lain.widget.bat({
    settings = function()
        if bat_now.status ~= "N/A" then
            if bat_now.ac_status == 1 then
                widget:set_markup(markup.font(theme.font, " AC "))
                baticon:set_image(theme.widget_ac)
                return
            elseif not bat_now.perc and tonumber(bat_now.perc) <= 5 then
                
                --autosuspend when battery is low
                baticon:set_image(theme.widget_battery_empty)
            
            elseif not bat_now.perc and tonumber(bat_now.perc) <= 15 then
                baticon:set_image(theme.widget_battery_low)
            else
                baticon:set_image(theme.widget_battery)
            end
            widget:set_markup(markup.font(theme.font, " " .. bat_now.perc .. "% "))
        else
            widget:set_markup(markup.font(theme.font, " AC "))
            baticon:set_image(theme.widget_ac)
        end
    end
})

-- ALSA volume
local volicon = wibox.widget.imagebox(theme.widget_vol)
theme.volume = lain.widget.alsa({
    settings = function()
        if volume_now.status == "off" then
            volicon:set_image(theme.widget_vol_mute)
        elseif tonumber(volume_now.level) == 0 then
            volicon:set_image(theme.widget_vol_no)
        elseif tonumber(volume_now.level) <= 50 then
            volicon:set_image(theme.widget_vol_low)
        else
            volicon:set_image(theme.widget_vol)
        end

        widget:set_markup(markup.font(theme.font, " " .. volume_now.level .. "% "))
    end
})

-- Net
local neticon = wibox.widget.imagebox(theme.widget_net)
local net = lain.widget.net({
    settings = function()
        widget:set_markup(markup.font(theme.font,
                          markup("#7AC82E", " " .. net_now.received)
                          .. " " ..
                          markup("#46A8C3", " " .. net_now.sent .. " ")))
    end
})

-- Separators
local spr     = wibox.widget.textbox(' ')
local arrl_dl = separators.arrow_left(theme.bg_normal, "alpha")
local arrl_ld = separators.arrow_left("alpha", theme.bg_normal)

function theme.at_screen_connect(s)
    -- Quake application
    s.quake = lain.util.quake({ app = awful.util.terminal })

    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.layout.layouts)

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s,"" , awful.util.tasklist_buttons)--awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = 18, bg = theme.bg_normal, fg = theme.fg_normal })
    s.mywibox.opacity = 0.98
    s.mywibox.border_width = 1.6 
    s.mywibox.y = -1.5
    --s.mywibox.x = s.mywibox.x - 1.5
    --s.mywibox.y = s.mywibox.y + -10 
    --s.mywibox.width = s.mywibox.width + 10 
    s.mywibox.border_color = "#404040"
    
    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            --spr,
            s.mytaglist,
            s.mypromptbox,
            spr,
        },
	spr,--clock.widget, --middle
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),
            spr,
            --arrl_ld,
            wibox.container.background(mpdicon, theme.bg_normal),
            wibox.container.background(theme.mpd.widget, theme.bg_normal),
            spr,--arrl_dl,
            micon,
            spr,
            volicon,
            theme.volume.widget,
	    spr,
            --arrl_ld,
            --wibox.container.background(mailicon, theme.bg_normal),
            --spr,--wibox.container.background(mail.widget, theme.bg_focus),
            --arrl_dl,
            memicon,
            mem.widget,
            spr,--arrl_ld,
            wibox.container.background(cpuicon, theme.bg_normal),
            wibox.container.background(cpu.widget, theme.bg_normal),
            spr, --arrl_dl,
            --tempicon,
            --temp.widget,
            --arrl_ld,
            wibox.container.background(fsicon, theme.bg_normal),
            wibox.container.background(theme.fs.widget, theme.bg_normal),
            spr,--arrl_dl,
            baticon,
            bat.widget,
	    spr,
            --arrl_ld,
            -- wibox.container.background(neticon, theme.bg_focus),
            --wibox.container.background(net.widget, theme.bg_focus),
            --arrl_dl,
	    spr,
            clock.widget,
            spr,
            --arrl_ld,
            wibox.container.background(s.mylayoutbox, theme.bg_normal),
        },
    }
end

return theme
