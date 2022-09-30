--[[
                                      
    Based on Powerarrow Dark Awesome WM theme 
    github.com/copycat-killer    
                                      
--]]


local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local math = require("math")
local weather_widget = require("awesome-wm-widgets.weather-widget.weather")
local os    = { getenv = os.getenv }


local theme                                     = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/powerarrow-dark"
theme.wallpaper                                 = theme.dir .. "/walls/ocean.jpg"
theme.font                                      = "Inconsolata 10"--"Source Code Pro for Powerline Regular 10"
theme.fg_normal                                 = "#B3BDCB"--"#DDDDFF"
theme.fg_focus                                  = "#3276C7" --"#EA6F81"
theme.fg_urgent                                 = "#CC9393"
theme.bg_normal                                 = "#2F343F"---"#282828"---"#1A1A1A"
theme.bg_focus                                  = "#2F343F"
theme.bg_urgent                                 = "#282828"
theme.border_width                              = 2
theme.border_normal                             = "#3F3F3F"
theme.border_focus                              = "#6E9AC6" ---"#000000"--theme.bg_normal --"#3276C7"--"#7F7F7F"
theme.border_marked                             = "#CC9393"
theme.tasklist_bg_focus                         = "#1A1A1A"
theme.taglist_bg_focus				            = "#3276C7"--"#22252E"
theme.taglist_fg_focus                          = "#C6C8DC"--"#D3D4EF"
theme.titlebar_bg_focus                         = theme.bg_normal --"#6E9AC6"
theme.titlebar_bg_normal                        = theme.bg_normal
theme.titlebar_fg_focus                         = "#B3BDCB"
theme.hide_client_name_in_titlebar              = true
theme.menu_height                               = 16
theme.menu_width                                = 140
theme.menu_border_width                         = 20
theme.menu_border_color                         = theme.bg_normal
theme.bg_systray                                = theme.bg_normal .. "E6"

theme.useless_gaps                              = 13


-- | Notification | --
--theme.notification_border_width                 = 5
--theme.notification_border_color                 = theme.bg_normal
--theme.notification_opacity                      = 0.95
--theme.notification_margin                       = 40
--theme.font_name = "SF Pro Display "
--theme.font = theme.font_name .. "Medium 9"
--theme.notification_font                         = "Inconsolata 200"

--theme.notification_width                        = 100
--theme.notification_height                       = 100

--theme.notification_shape                        = function (cr, h, w)
--                                                    radius = 5,
--                                                    gears.shape.rounded_rect(
--                                                        cr,
--                                                        h,
--                                                        w,
--                                                        radius
--                                                    ) 
--                                                  end
--
-- | Taglist | --
theme.taglist_bg_empty                          = "png:".. theme.dir .. "/icons/bg_unsel.png"
theme.taglist_bg_occupied                       = "png:".. theme.dir .. "/icons/bg_unsel.png"
theme.taglist_bg_urgent                         = "png:" ..theme.dir .. "/icons/bg_urgent.png"
theme.taglist_bg_focus                          = "png:".. theme.dir .. "/icons/bg_sel.png"

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
theme.widget_hdd_full                                = theme.dir .. "/icons/hdd_full.png"
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
theme.titlebar_close_button_focus               = theme.dir .. "/icons/titlebar/close_focus_no_hover.png"
theme.titlebar_close_button_focus_hover              = theme.dir .. "/icons/titlebar/close_focus_hover.png"
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
--[[micon = wibox.widget.imagebox(theme.micon_off)]]
--on_off = false
--micon:buttons(awful.util.table.join(awful.button({ }, 1,
--function () 
    --on_off = not on_off
    --if on_off == true then 
        --io.popen("rm /home/getz/python/SpeechRecognition/my_pid")
        --io.popen("cd /home/getz/python/SpeechRecognition/ && ./speech")
        --micon:set_image(theme.micon_on)
    --else
        --pid = io.popen("cat /home/getz/python/SpeechRecognition/my_pid")
        --for i in pid:lines() do 
            --io.popen("kill " .. i)
        --end
        --micon:set_image(theme.micon_off)
    --end
--end  )))

-- Textclock
local clock = lain.widget.watch({
    timeout  = 60,
    cmd      = "date +'%a %d %b %R'",
    settings = function()
        widget:set_markup("".. markup.font(theme.font, " " .. output))

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
   --[[ str = io.popen("lsmod | grep uvcvideo > .cam_detection && head -1 .cam_detection"):read()     ]]
	--if str:sub(string.len(str)) ~= "0" then
		--io.popen("notify-send 'Watch out!'")
		--io.popen("notify-send 'webcam is being used!'")
		--io.popen("notify-send 'You are being watched by a filthy pervert!'")
   --[[ end  ]]
    end
})
clock.widget:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.spawn("gnome-calendar") end)))

--[[-- Calendar]]
--theme.cal = lain.widget.calendar({
    --attach_to = { clock.widget },
    --notification_preset = {
        --font = "xos4 Terminus 10",
        --fg   = theme.fg_normal,
        --bg   = theme.bg_normal
    --}
--})

-- Mail IMAP check
--[[local mailicon = wibox.widget.imagebox(theme.widget_mail)]]

--mailicon:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.spawn(mail) end)))
--local mail = lain.widget.imap({
    --timeout  = 15,
    --server   = "imap.gmail.com",
    --mail     = "basilegarcia@gmail.com",
    --password = "Mangas!3319",
    --settings = function()
            --count = io.open("/home/getz/.count", "r"):read("*all")
            --io.open("/home/getz/.count", "w"):write(mailcount)
            --if count ~= nil or count ~= "" then
                --new_count = tonumber(mailcount) - tonumber(count)
                --if new_count > 0 then
                    --io.popen(
                        --"notify-send -i ".. theme.widget_mail .. " 'Vous avez " .. new_count .. " nouveaux mails.'"
                    --)
                --end
            --end
        --end
--})

-- MPD
--[[local mpdicon = wibox.widget.imagebox(theme.widget_music)]]
--mpdicon:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.spawn.with_shell(musicplr) end)))
--theme.mpd = lain.widget.mpd({
    --settings = function()
        --if mpd_now.state == "play" then
            --artist = " " .. mpd_now.artist .. " "
            --title  = mpd_now.title  .. " "
            --mpdicon:set_image(theme.widget_music_on)
        --elseif mpd_now.state == "pause" then
            --artist = " mpd "
            --title  = "paused "
        --else
            --artist = ""
            --title  = ""
            --mpdicon:set_image(theme.widget_music)
        --end

        --widget:set_markup(markup.font(theme.font, markup("#5294E2", artist)))
    --end
--})

---- MEM
local memicon = wibox.widget.imagebox(theme.widget_mem)
local mem = lain.widget.mem({
    settings = function()
        widget:set_markup(markup.font(theme.font, " " .. mem_now.used .. "MB "))
    end
})

---- CPU
local cpuicon = wibox.widget.imagebox(theme.widget_cpu)
local cpu = lain.widget.cpu({
    settings = function()
        widget:set_markup(markup.font(theme.font, " " .. cpu_now.usage .. "% "))
    end
})

---- Coretemp
--local tempicon = wibox.widget.imagebox(theme.widget_temp)
--local temp = lain.widget.temp({
    --settings = function()
        --widget:set_markup(markup.font(theme.font, " " .. coretemp_now .. "°C "))
    --end
--})

-- / fs
--[[local fsicon = wibox.widget.imagebox(theme.widget_hdd)]]
--theme.fs = lain.widget.fs({
    --options  = "--exclude-type=tmpfs",
    --notification_preset = { fg = theme.fg_normal, bg = theme.bg_normal, font = "xos4 Terminus 10" },
    --settings = function()
        --widget:set_markup(markup.font(theme.font, " " .. fs_now.used .. "% "))
        --if fs_now.used > 95 then
            --widget:set_image(theme.widget_hdd_full)
        --end
    --end
--})

-- Battery
--[[local baticon = wibox.widget.imagebox(theme.widget_battery)<]]
--local bat = lain.widget.bat({
    --settings = function()
        --if bat_now.status ~= "N/A" then
            --if bat_now.ac_status == 1 then
                --widget:set_markup(markup.font(theme.font, " AC "))
                --baticon:set_image(theme.widget_ac)
                --return
            --elseif not bat_now.perc and tonumber(bat_now.perc) <= 5 then
                
                ----autosuspend when battery is low
                --baticon:set_image(theme.widget_battery_empty)
            
            --elseif not bat_now.perc and tonumber(bat_now.perc) <= 15 then
                --baticon:set_image(theme.widget_battery_low)
            --else
                --baticon:set_image(theme.widget_battery)
            --end
            --widget:set_markup(markup.font(theme.font, " " .. bat_now.perc .. "% "))
        --else
            --widget:set_markup(markup.font(theme.font, " AC "))
            --baticon:set_image(theme.widget_ac)
        --end
    --end
--})

---- ALSA volume
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
        return tonumber(volume_now.level)
    end
})

--[[local volicon = wibox.widget.imagebox(theme.widget_vol)]]
--theme.volume = lain.widget.alsabar({
    --width = 59, border_width = 0, ticks = false , 
    --notification_preset = { font = theme.font },
    --togglechannel = "IEC958,3",
    --settings = function()
        --if volume_now.status == "off" then
            --volicon:set_image(theme.widget_vol_mute)
        --elseif volume_now.level == 0 then
            --volicon:set_image(theme.widget_vol_no)
        --elseif volume_now.level <= 50 then
            --volicon:set_image(theme.widget_vol_low)
        --else
            --volicon:set_image(theme.widget_vol)
        --end
    --end,
    --colors = {
        --background   = theme.bg_normal,
        --mute         = theme.fg_normal,
        --unmute       = theme.fg_focus
    --}
--})

--theme.volume.tooltip.wibox.fg = theme.fg_focus
--local volumebg = wibox.container.background(theme.volume.bar, "#474747", gears.shape.rectangle)
--local volumewidget = wibox.container.margin(volumebg, 2, 4, 6, 6)

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

---- Weather
local weather = weather_widget({
    api_key='fb55e8ac1711a0b5b3eabae65b32a603',
    coordinates = {48.84631959894373, 2.347615781636001},
    --time_format_12h = true,
    --units = 'imperial',
    --both_units_widget = true,
    font_name = 'Carter One',
    icons = 'weather-underground-icons',
    icons_extension = '.png',
    show_hourly_forecast = true,
    show_daily_forecast = true,
})


-- Separators
local spr     = wibox.widget.textbox('  ')
local arrl_dl = separators.arrow_left(theme.bg_normal, "alpha")
local arrl_ld = separators.arrow_left("alpha", theme.bg_normal)

-- systray widget 
--
--local cr = require("cairo")
--local outline = gears.shape.rectangle(cr, 3, 20)
--local systray = wibox.container.margin(sysbg, 0, 0, 0, 1)


function theme.at_screen_connect(s)
    -- Quake application
    s.quake = lain.util.quake({ app = awful.util.terminal })

    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, false)

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

    RADIUS = 3

    function custom_shape(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, RADIUS)
    end


    -- Create the wibox
    s.mywibox = awful.wibar({type ="dock",  position = "top", screen = s, width = s.geometry.width - 50,
                              height = 27, bg = theme.bg_normal, fg = theme.fg_normal, shape=custom_shape})

	awful.placement.top(s.mywibox, { margins = 2 * 2 })
    -- s.mywibox.opacity = 0.9
    --s.mywibox.border_width = 15
    
   -- s.mywibox.y = -1.5
    --s.mywibox.x = s.mywibox.x - 1.5
    s.mywibox.y = s.mywibox.y + 7
    
    --s.mywibox.border_color = "#1A1A1A"--"#2F343F"

    --s.mywibox.border_color = "[CC]#002F343F"
    --s.mywibox.border_width = 0.8
    
    -- in order to expand the middle widget to the center
    local wiboxlayout = wibox.layout.align.horizontal()
    wiboxlayout.expand = "none"-- Add widgets to the wibox

    s.mywibox:setup {
        layout = wiboxlayout,
        {
            { -- Left widgets
                s.mytaglist,
                layout = wibox.layout.fixed.horizontal,
                widget = wibox.container.background,
--                bg="#565965"

            },
                bg= theme.bg_normal,
                shape_border_color=theme.bg_normal,
                shape_border_width=4,
                shape = custom_shape,
                layout   = wibox.container.background
        },
        {
            { -- Middle widgets
                clock.widget,
                bottom=4,
                color=theme.fg_focus,
                widget=wibox.container.margin
            },
                left = 3,
                right = 3,
                layout   = wibox.container.margin
        },

        { 
            {-- Right widgets

                layout = wibox.layout.fixed.horizontal,
                widget=wibox.container.margin,
                wibox.widget.systray(),
                --mpdicon,
                --theme.mpd.widget,
                --[[micon,]]
                spr,
                volicon,
                theme.volume,
                spr,
                memicon,
                mem.widget,
                spr,
                cpuicon,
                cpu.widget,
                spr,
                --fsicon,
                --theme.fs.widget,
                --baticon,
                --bat.widget,
                --spr,
                weather,
                s.mylayoutbox,
        
            },
            layout = wibox.container.margin,
            top=1,
            bottom=1,
            left=1,
            right=1,

        }
}
end

return theme
