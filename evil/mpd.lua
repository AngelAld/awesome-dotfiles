-- Provides:
-- evil::mpd
--      artist (string)
--      song (string)
--      paused (boolean)
-- evil::mpd_volume
--      value (integer from 0 to 100)
-- evil::mpd_options
--      loop (boolean)
--      random (boolean)
local awful = require("awful")

local function emit_info()
    awful.spawn.easy_async_with_shell("playerctl metadata --format '{{artist}}@{{title}}@{{status}}'",
        function(stdout)
            local artist, title, status = stdout:match('([^@]+)@([^@]+)@([^@]+)')

            if not artist or artist == "" then
                artist = "N/A"
            end
            if not title or title == "" then
                title = "N/A"
            end

            local paused
            if status == "Playing" then
                paused = false
            else
                paused = true
            end

            awesome.emit_signal("evil::mpd", artist, title, paused)
        end
    )
end

-- Run once to initialize widgets
emit_info()

-- Sleeps until player status changes (pause/play/next/prev)
local player_script = [[
  sh -c '
    playerctl --follow metadata
  ']]

-- Kill old playerctl metadata process
awful.spawn.easy_async_with_shell("ps x | grep \"playerctl --follow metadata\" | grep -v grep | awk '{print $1}' | xargs kill", function ()
    -- Emit song info with each line printed
    awful.spawn.with_line_callback(player_script, {
        stdout = function(line)
            emit_info()
        end
    })
end)

----------------------------------------------------------

-- MPD Volume
local function emit_volume_info()
    awful.spawn.easy_async_with_shell("playerctl metadata volume",
        function(stdout)
            local volume = tonumber(stdout)
            if volume then
                awesome.emit_signal("evil::mpd_volume", volume)
            end
        end
    )
end

-- Run once to initialize widgets
emit_volume_info()

-- Sleeps until volume changes
local volume_script = [[
  sh -c '
    playerctl --follow volume
  ']]

-- Kill old playerctl volume process
awful.spawn.easy_async_with_shell("ps x | grep \"playerctl --follow volume\" | grep -v grep | awk '{print $1}' | xargs kill", function ()
    -- Emit volume info with each line printed
    awful.spawn.with_line_callback(volume_script, {
        stdout = function(line)
            emit_volume_info()
        end
    })
end)

-- Emit options info function
local function emit_options_info()
    -- Implementa la lógica para obtener las opciones de Playerctl
    -- utilizando `playerctl` y emite las señales "evil::mpd_options"
    -- con los valores adecuados.
end

-- Run once to initialize widgets
emit_options_info()

-- Implementa la lógica para detectar los cambios en las opciones
-- de Playerctl y emitir las señales "evil::mpd_options" en consecuencia.