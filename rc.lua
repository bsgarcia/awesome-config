--[[

     Awesome WM configuration template
     github.com/copycat-killer

--]]

-- {{{ Required libraries
local awesome, client, screen, tag = awesome, client, screen, tag
local ipairs, string, os, table, tostring, tonumber, type = ipairs, string,
      os, table, tostring, tonumber, type

--local Animation     = require("animation.Animation")
local gears         = require("gears")
local awful         = require("awful")
                      require("awful.autofocus")
local wibox         = require("wibox")
local beautiful     = require("beautiful")
local naughty       = require("naughty")
local lain          = require("lain")
local freedesktop   = require("freedesktop")
local opacity       = require("awesome-opacity")
local hotkeys_popup = require("awful.hotkeys_popup").widget
local weather_widget = require("awesome-wm-widgets.weather-widget.weather")
-- }}}
package.loaded["naughty.dbus"] = {} 

-- {{{ Runs a shell asynchronously command and returns output
local function run_async(cmd)
    stdout = awful.spawn.easy_async(cmd, 
        function(stdout, stderr, reason, exit_code)
        return stdout
    end)
    return string.format("%s", stdout)
end
-- {{{

local function split(inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        if not string.gmatch(inputstr, "([^"..sep.."]+)") then
            return inputstr
        end
        local t={} ; i=1
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                t[i] = str
                i = i + 1
        end
        return t
end

--naughty.config.defaults.icon_size = 34



-- {{{ Error handling
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}
--
--

-- {{{ Autostart windowless processes
local function run_once(cmd_arr)
    for _, cmd in ipairs(cmd_arr) do
        findme = cmd
        firstspace = cmd:find(" ")
        if firstspace then
            findme = cmd:sub(0, firstspace-1)
        end
        awful.spawn.with_shell(string.format("pgrep -u $USER -x %s > /dev/null || (%s)", findme, cmd))
        --_cmd = _cmd:gsub(string.sub(_cmd, 1, 1), "[" ..  string.sub(_cmd, 1, 1) .. "]")
        
        --check_cmd = "ps -efww | grep -w '" .. _cmd .. "' | awk -vpid=$$ '$2 != pid { print $2 }' "
        --
        --_cmd = split(cmd)[1]
        --check_cmd = "pgrep " .. _cmd

        --naughty.notify({text=check_cmd})

        --[[if not run_async(check_cmd):gmatch("%d%d%d%") then]]
            --findme = cmd
            --firstspace = cmd:find(" ")
            --if firstspace then
                --findme = cmd:sub(0, firstspace-1)
            --end
            --awful.spawn.with_shell(string.format("pgrep -u $USER -x %s > /dev/null || (%s)", findme, cmd))

        --[[end]]
    end
end

---- {{{ Run at startup }}}
run_once({
  --  "volnoti -a 0.0 - r 20 -t 1",
	"nm-applet",
    "synclient HorizTwoFingerScroll=1",
    "synclient TapButton1=1",
    "xfce4-clipman",
    "synclient PalmDetect=1",
    "picom -b --config ~/.config/picom/picom.conf --experimental-backend" --"franz"
})

--"emacs --daemon", 

-- {{{ Variable definitions
local chosen_theme = "powerarrow-dark"
local modkey       = "Mod4"
local altkey       = "Mod1"
local terminal     = "gnome-terminal" or "xterm"
local editor       = os.getenv("EDITOR") or "nano" or "vi"
local gui_editor   = "gvim"
local browser      = "firefox"


awful.util.terminal = terminal
awful.util.tagnames = {"  ", "  ","  ", "  ", "  "} --{ "  ", "  ", "  ", "  ", "  " }
awful.layout.layouts = {
    awful.layout.suit.floating,
--    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.floating,
    awful.layout.suit.floating,
    awful.layout.suit.floating
    --lain.layout.centerwork,
    --lain.layout.centerwork.horizontal,
    --lain.layout.termfair,
    --lain.layout.termfair.center,
}


awful.util.taglist_buttons = awful.util.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )
awful.util.tasklist_buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() and c.first_tag then
                                                      c.first_tag:view_only()
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function()
                         local instance = nil

                         return function ()
                             if instance and instance.wibox.visible then
                                 instance:hide()
                                 instance = nil
                             else
                                 instance = awful.menu.clients({ theme = { width = 250 } })
                             end
                        end
                     end),

                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

lain.layout.termfair.nmaster           = 3
lain.layout.termfair.ncol              = 1
lain.layout.termfair.center.nmaster    = 3
lain.layout.termfair.center.ncol       = 1
lain.layout.cascade.tile.offset_x      = 2
lain.layout.cascade.tile.offset_y      = 32
lain.layout.cascade.tile.extra_padding = 5
lain.layout.cascade.tile.nmaster       = 5
lain.layout.cascade.tile.ncol          = 2

local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme)
beautiful.init(theme_path)
-- }}}



-- {{{ Menu
local myawesomemenu = {
    { "hotkeys", function() return false, hotkeys_popup.show_help end },
    { "manual", terminal .. " -e man awesome" },
    { "edit config", string.format("%s -e %s %s", terminal, editor, awesome.conffile) },
    { "restart", awesome.restart },
    { "quit", function() awesome.quit() end }
}

awful.util.mymainmenu = freedesktop.menu.build({
    icon_size = beautiful.menu_height or 16,
    before = {
        { "Awesome", myawesomemenu, beautiful.awesome_icon },
        -- other triads can be put here
    },
    after = {
        { "Open terminal", terminal, beautiful.awesome_icon },
        --{ "Lock", "dm-tool lock" },
        --{ "Suspend", "systemctl suspend" },
        -- other triads can be put here
    }
})
--menubar.utils.terminal = terminal -- Set the Menubar terminal for applications that require it
-- }}}

-- {{{ Screen
-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", function(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end)

--naughty.notify({preset=naughty.config.preset.critical, text=s})

-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s) beautiful.at_screen_connect(s) end)
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () awful.util.mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    -- Take a screenshot
    -- https://github.com/copycat-killer/dots/blob/master/bin/screenshot
    awful.key({ altkey }, "p", function() run_async("screenshot") end),

    -- Hotkeys
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),

    -- Expose mode
    awful.key({modkey, },  'Escape',     function () run_async("skippy-xd") end),

    -- Tag browsing
--    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
--              {description = "view previous", group = "tag"}),
--    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
--              {description = "view next", group = "tag"}),
--
--    --awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
     --         {description = "go back", group = "tag"}),

    -- Non-empty tag browsing
    --awful.key({ altkey }, "Left", function () lain.util.tag_view_nonempty(-1) end,
      --        {description = "view  previous nonempty", group = "tag"}),
    --awful.key({ altkey }, "Right", function () lain.util.tag_view_nonempty(1) end,
      --        {description = "view  previous nonempty", group = "tag"}),

    -- Default client focus
    awful.key({ modkey,           }, "Tab",

        function ()
            awful.client.focus.byidx(1)
        end,

        {description = "focus next by index", group = "client"}
    ),
    awful.key({ altkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),

    -- By direction client focus
    awful.key({ modkey }, "j",
        function()
            awful.client.focus.bydirection("down")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey }, "k",
        function()
            awful.client.focus.bydirection("up")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey }, "h",
        function()
            awful.client.focus.bydirection("left")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey }, "l",
        function()
            awful.client.focus.bydirection("right")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () awful.util.mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "" }, "Right", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "" }, "Left", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),

    -- Show/Hide Wibox
    awful.key({ modkey }, "b", function ()
        for s in screen do
            s.mywibox.visible = not s.mywibox.visible
            if s.mybottomwibox then
                s.mybottomwibox.visible = not s.mybottomwibox.visible
            end
        end
    end),

    -- On the fly useless gaps change
    awful.key({ altkey, "Control" }, "p",
        function ()
            lain.util.useless_gaps_resize(1)
            --[[local scr = awful.screen.focused()]]
            --if scr.selected_tag.gap ~= 0 then
                --run_async("compton --vsync opengl-swc --xrender-sync --xrender-sync-fence")
            --[[end]]
    end),

    awful.key({ altkey, "Control" }, "m",
        function ()
            lain.util.useless_gaps_resize(-1)
            --[[local scr = awful.screen.focused()]]
            --if scr.selected_tag.gap == 0 then
                --run_async("compton --vsync opengl-swc --xrender-sync --xrender-sync-fence -o 0")
            --[[end]]
    end),

    -- Dynamic tagging
    awful.key({ modkey, "Shift" }, "n", function () lain.util.add_tag() end),
    awful.key({ modkey, "Shift" }, "r", function () lain.util.rename_tag() end),
    awful.key({ modkey, "Shift" }, "Left", function () lain.util.move_tag(1) end),   -- move to next tag
    awful.key({ modkey, "Shift" }, "Right", function () lain.util.move_tag(-1) end), -- move to previous tag
    awful.key({ modkey, "Shift" }, "d", function () lain.util.delete_tag() end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ altkey, "Shift"   }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ altkey, "Shift"   }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function ()
        awful.layout.inc( 1)
        awful.screen.focused().selected_tag.gap = beautiful.useless_gaps
    end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),
    awful.key({ modkey, "Control" }, "=", function () lain.util.useless_gaps_resize(1) end,
		{description = "increase gaps", group = "customise"}),
    awful.key({ modkey, "Control" }, "-", function () lain.util.useless_gaps_resize(-1) end,		 
		{description = "decrease gaps", group = "customise"}),


    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                      client.focus = c
                      c:raise()
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Dropdown application
    --awful.key({ modkey, }, "z", function () awful.screen.focused().quake:toggle() end),

    -- Widgets popups
    --[[awful.key({ altkey, }, "c", function () lain.widget.calendar.show(7) end),]]
    --awful.key({ altkey, }, "h", function () if beautiful.fs then beautiful.fs.show(7) end end),
    --awful.key({ altkey, }, "w", function () if beautiful.weather then beautiful.weather.show(7) end end),

    -- ALSA volume control
    awful.key({ }, "XF86AudioRaiseVolume",
        function ()
            run_async(string.format("amixer -q set %s 5%%+", beautiful.volume.channel))
            --run_async("pactl set-sink-volume 0 +5%")
            vol, status = beautiful.volume.update()
            if vol ~= nil then
                run_async(string.format("volnoti-show  %i", vol-30))
            end
        end),
    awful.key({ }, "XF86AudioLowerVolume",
        function ()
            run_async(string.format("amixer -q set %s 5%%-", beautiful.volume.channel))
            --run_async("pactl set-sink-volume 0 -5%")
            vol, status = beautiful.volume.update()
            if vol ~= nil then
                run_async(string.format("volnoti-show  %i", vol-30))
            end
        end),
    awful.key({ }, "XF86AudioMute",
        function ()
            run_async(string.format("amixer -q set %s toggle", beautiful.volume.togglechannel or beautiful.volume.channel))

            vol, status = beautiful.volume.update()
            if status ~= "on" then
                run_async(string.format("volnoti-show  %i", vol))
            else
                run_async("volnoti-show -m") 
            end

        end),
		awful.key({ altkey, "Control" }, "0",
				function ()
						run_async(string.format("amixer -q set %s 0%%", beautiful.volume.channel))
						beautiful.volume.update()
				end),

    -- Brightness

    awful.key({ }, "XF86MonBrightnessDown", function ()

        level = math.floor(tonumber(run_async("xbacklight")))
        
        if level < 30 then
            bright_icon = "-s '/usr/share/icons/Papirus/48x48/status/notification-display-brightness-low.svg'"
        elseif level < 50 then
            bright_icon = "-s '/usr/share/icons/Papirus/48x48/status/notification-display-brightness-medium.svg'"
        elseif level < 100 then
            bright_icon = "-s '/usr/share/icons/Papirus/48x48/status/notification-display-brightness-high.svg'"
        end

        run_async(string.format("volnoti-show %s %i", bright_icon, level))
        run_async("xbacklight -dec 5") 

    end),

    awful.key({ }, "XF86MonBrightnessUp", function ()

        level = tonumber(run_async("xbacklight"))

        if level < 30 then
            bright_icon = 
            "-s '/usr/share/icons/Papirus/48x48/status/notification-display-brightness-low.svg'"
        elseif level < 50 then
            bright_icon = 
            "-s '/usr/share/icons/Papirus/48x48/status/notification-display-brightness-medium.svg'"
        elseif level < 100 then
            bright_icon = 
            "-s '/usr/share/icons/Papirus/48x48/status/notification-display-brightness-high.svg'"
        end

        run_async(string.format("volnoti-show %s %i", bright_icon, level))

        run_async("xbacklight -inc 5") 
    end),

    -- MPD control
    awful.key({ altkey, "Control" }, "Up",
        function ()
            awful.spawn.with_shell("mpc toggle")
            beautiful.mpd.update()
        end),
    awful.key({ altkey, "Control" }, "Down",
        function ()
            awful.spawn.with_shell("mpc stop")
            beautiful.mpd.update()
        end),
    awful.key({ altkey, "Control" }, "Left",
        function ()
            awful.spawn.with_shell("mpc prev")
            beautiful.mpd.update()
        end),
    awful.key({ altkey, "Control" }, "Right",
        function ()
            awful.spawn.with_shell("mpc next")
            beautiful.mpd.update()
        end),
    awful.key({ altkey }, "0",
        function ()
            local common = { text = "MPD widget ", position = "top_middle", timeout = 2 }
            if beautiful.mpd.timer.started then
                beautiful.mpd.timer:stop()
                common.text = common.text .. lain.util.markup.bold("OFF")
            else
                beautiful.mpd.timer:start()
                common.text = common.text .. lain.util.markup.bold("ON")
            end
            naughty.notify(common)
        end),

    -- Copy primary to clipboard (terminals to gtk)
    --awful.key({ modkey }, "c", function () awful.spawn("xsel | xsel -i -b") end),
    -- Copy clipboard to primary (gtk to terminals)
    --awful.key({ modkey }, "v", function () awful.spawn("xsel -b | xsel") end),

    -- User programs
    awful.key({ modkey }, "e", function () awful.spawn(gui_editor) end),
    awful.key({ modkey }, "q", function () awful.spawn(browser) end),
    awful.key({ modkey }, "a", function () awful.spawn("nautilus -w --geometry=500x400") end),
    awful.key({ modkey }, "z", function () awful.spawn("gnome-terminal") end),

    -- Default
    --[[ Menubar
    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"})
    --]]
    --[[ dmenu
    awful.key({ modkey }, "x", function ()
        awful.spawn(string.format("dmenu_run -i -fn 'Monospace' -nb '%s' -nf '%s' -sb '%s' -sf '%s'",
        beautiful.bg_normal, beautiful.fg_normal, beautiful.bg_focus, beautiful.fg_focus))
		end)
    --]]
    -- Prompt
    awful.key({ modkey }, "r", 
        function ()
            awful.spawn("rofi -show drun")
        end
    ),
             -- {description = "run prompt", group = "launcher"}),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"})
    --]]
)

clientkeys = awful.util.table.join(
    awful.key({ altkey, "Shift"   }, "m",      lain.util.magnify_client                         ),
    awful.key({ modkey,           }, "f",
        function (c)
            fullscreen = not c.fullscreen
            if fullscreen then
                c.border_width = 0
            else
                c.border_width = beautiful.border_width
                c.border_color = beautiful.border_focus
                c.focus = true

            end
            c.fullscreen = fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),

    awful.key({ modkey,           }, "c",
    function (c)
        --[[if get_nb_of_client(awful.tag.selected()) == 1 then]]
            --run_async("python /usr/bin/blur.py off")
            --is_blurred = false
        --[[end]]
        c:kill()
    end,
        {description = "close", group = "client"}),

    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            maximized = not c.maximized
            if maximized then
                c.border_color = beautiful.border_focus
                --beautiful.titlebar_bg_focus = beautiful.bg_normal.. "F4"
                --awful.titlebar(c)
                --c.border_width = 0
                c.focus = true
            else
                c.border_color = beautiful.border_focus
                c.border_width = beautiful.border_width
                --beautiful.titlebar_bg_focus = beautiful.bg_focus
                --awful.titlebar(c)
                c.focus = true
            end
           -- c.maximized = maximized
            --c:raise()

            if maximized then
                c.prev_width = c.width
                c.prev_height = c.height
                c.prev_x = c.x
                c.prev_y = c.y
                c.width = 2500
                c.height = 1400
                c.x = 6 --+ (1500 * c.screen)
		--naughty.notify({text='test'})
	
                c.y = 35
            else
                c.width = c.prev_width
                c.height = c.prev_height
                c.x = c.prev_x
                c.y = c.prev_y
            end

        end ,
        {description = "maximize", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        screen.selected_tag.gap = beautiful.useless_gaps
                        if tag then
                            tag:view_only()
                            naughty.notify({
                                    text = tostring(i),
                                    font = beautiful.font,
                                    timeout = 0.3,
                                    height = 200,
                                    position = "center",
                                    fg = "#FFFFFF",
                                    bg = beautiful.bg_normal,
                                    border_color = beautiful.bg_normal,
                                    opacity = 0.8
                            })
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                        awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
     
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen+awful.placement.centered,
                     size_hints_honor = false,
                     maximized_horizontal = false,
                     maximized_vertical = false,
                     maximized = false,
     }
    },

    -- Titlebars
    { rule_any = { type = { "dialog", "normal" } },
      properties = { titlebars_enabled = true} },

    --[[{rule = { class = "plank" },]]
      --properties = {
          --border_width = 0,
          --floating = true,
          --sticky = true,
          --ontop = false,
          --focusable = false,
          --below = true
      --}
    --[[},]]

    -- Set chromium to always map on the first tag on screen 1.
    { rule = { class = "Chromium" },
      properties = { screen = 1} },

    { rule = { class = "Unity" },
      properties = { screen = 1} },
        
    { rule = { class = "Pycharm" },
      properties = { screen = 1} },

    { rule = { name = "Figure", class = "Matlab"},
      properties = { floating = true} },

    { rule = { class = "Gimp", role = "gimp-image-window" },
          properties = { maximized = true } },

    {rule = { class = "nautilus", "Nautilus", "sushi-start", "Sushi-start"},
          properties = { maximized = false, titlebars_enabled = false}},

    {rule = { class = "main.py"},
          properties = { floating = true }},

    {rule = { 
        class = "jetbrains-pycharm",
        instance = "sun-awt-X11-XWindowPeer",
        name = "win.*"
        },
          properties = {
                floating = true,
                focus = true,
                focusable = false,
                ontop = true,
                placement = awful.placement.restore,
                buttons = {},
                titlebars_enabled = false,
        }
    },

    {rule = { class = "evince", "Evince"},
          properties = {}}
      },

    {rule = { class = "albert"},
          properties = { focusable = false, border_width = 0 }
      },

    {rule = { type = { "dialog", "normal" }, properties =  { fullscreen = true } },
         properties = { border_witch = 0 }}

    --{rule = { class = "thunar"},
          --properties = { maximized = false, floating = false},
      --[[}}]]
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end
    
    -- Manual rule to disable software titlebars
    local gnome_app = { 
        "io.github.celluloid_player.Celluloid",
        "nautilus",
        "org.gnome.Nautilus",
        "com.github.babluboy.bookworm",
        "lollypop",
        "evince",
        "baobab",
        "eog",
        "gnome-mpv",
        "gnome-calendar",
        "gnome-system-monitor",
        "sushi-start",
        "butter",
        "livres",
        "file-roller",
        "wps",
        "et",
        "wpp",
        "gthumb",
        "wakfu",
        "vlc"
    }

    local no_title = {
        "urxvt",
        "gnome-terminal"
    }

    local make_float_app = {
        "sqlitebrowser",
        "evince"
    }

    if c.class ~= nil then
        class = c.class:lower()
    else 
        class = ""
    end

    if c.name ~= nil then
        name = c.name:lower()
    else
        class = ""
    end

    for _, v in pairs(gnome_app) do
        if class == v:lower() or name == v:lower() then
            awful.titlebar.hide(c)
        break
        end
    end

    for _, v in pairs(make_float_app) do
        if class == v or name == v then
            c.maximized = false
            c.fullscreen = false
        break
        end
    end

    -- plank (dock) manual rule
    if class:lower() == "plank" then
       c.border_width = 0
       --c.height = 600
       --c.y = 300
       c.floating = true
       c.sticky = true
       c.focusable = true
    end

    --[[if c.name ~= nil and string.match(c.name, 'python ~/python/tex/main.py') then]]
        --c.minimized = true
    --end

    -- resize clients larger than screen
--[[    if c.height > 1079 or c.width > 1919 then]]
        --c.height = 1000 
        --c.width = 1900
        --awful.placement.centered(c)
    --end

    if awesome.startup and
      not c.size_hints.user_position 
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end

--[[    -- rounded borders]]
    --c.shape = function(cr, w, h)
        --radius = 4
        --gears.shape.partially_rounded_rect(
            --cr,
            --w,
            --h,
            --true,
            --true,
            --false,
            --false,
            --radius
        --)
    --[[end]]

end)


-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- Custom
    if beautiful.titlebar_fun then
        beautiful.titlebar_fun(c)
        return
    end

    -- Default
    -- buttons for the titlebar
    local buttons = awful.util.table.join(
        awful.button({ }, 1, function()
            client.focus = c
            c:raise()
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            client.focus = c
            c:raise()
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c, {size = 16}) : setup {
        { -- Left
            --uncomment to set icons on titlebars
            --awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },

        { -- Middle
            { -- Title
               align  = "center",
               widget = wibox.widget{
    			markup = '',
    			align  = 'center',
    			valign = 'center',
    			widget = wibox.widget.textbox
		}

	       --awful.titlebar.widget.titlewidget(
                    --c,
                    --beautiful.hide_client_name_in_titlebar
               -- )
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c) 
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
        and awful.client.focus.filter(c) then
        client.focus = c
    end

    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
        and c.class and c.class:lower() == "plank" then
        client.focus = c
    end

end)

-- No border for maximized clients
client.connect_signal("focus",
    function(c)
        -- exclude plank dock
        if c.class and c.class:lower() ~= "plank" then
            if c.maximized then -- no borders if only 1 client visible
                c.border_width = 0
            elseif c.fullscreen then
                c.border_width = 0
            elseif #awful.screen.focused().clients > 0 then
                c.border_width = beautiful.border_width
                c.border_color = beautiful.border_focus
           end
        else
            c.below = false
            c.ontop = true
        end
end)

client.connect_signal("unfocus",
    function(c)
        -- exclude plank
        if c.class and c.class:lower() ~= "plank" then
            c.border_color = beautiful.border_normal
        else
            c.below = true 
            c.ontop = false
        end
end)

-- Function to count number of clients in a tag
function is_empty(tag)
  count = 0
  for _, c in pairs(tag:clients()) do
      count = count + 1
  end
  if count > 0 then
    return false
  end
  return true
end

-- used in order to count nb of client when a client is killed
function get_nb_of_client(tag)
  count = 0
  for _, c in pairs(tag:clients()) do
      count = count + 1
  end
  return count
end
-- }}}
