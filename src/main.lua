import("CoreLibs/graphics")
import("CoreLibs/easing")

-- 2 min audio buffer is arbitrary, but large values will cause the device to run out of memory and crash
local buffer = playdate.sound.sample.new(120, playdate.sound.kFormat16bitMono)
local source = playdate.sound.sampleplayer.new(buffer)
local lastSample = {}
local isRecording = false

-- audio is often too quiet, so use gain effect to increase volume
local gain = 0.0
local effect = playdate.sound.overdrive.new()
effect:setMix(1)
effect:setGain(1)
playdate.sound.addEffect(effect)

playdate.sound.getHeadphoneState(function() 
  if playdate.isSimulator then
    -- playback on both when in simulator
    playdate.sound.setOutputsActive(true, true)
  else
    -- force playback on speaker (normal PD behavior is to only playback on headphones when plugged in)
    playdate.sound.setOutputsActive(false, true)
  end
end)

function onComplete(sample)
  lastSample = sample
  playdate.sound.micinput.stopListening()
  isRecording = false
end

function playdate.update()
  if playdate.buttonJustPressed("a") then
    if isRecording then
      playdate.sound.micinput.stopListening()
      playdate.sound.micinput.stopRecording()
      isRecording = false
    else
      playdate.sound.micinput.startListening()
      playdate.sound.micinput.recordToSample(buffer, onComplete)
      isRecording = true
    end
  end

  if playdate.buttonJustPressed("b") then
    if source:isPlaying() then
      source:stop()
    else
      source:play(0)
    end
  end

  local crankChange = playdate.getCrankChange()
  if crankChange ~= 0 then
    gain = math.max(1, gain + crankChange / 100)
    effect:setGain(gain)
  end

  local micLevel = playdate.sound.micinput.getLevel()
  -- use ease so that quiet sounds are still noticable in the bar
  micLevel = playdate.easingFunctions.outQuart(micLevel, 0, 1, 1) 

  playdate.graphics.clear()
  playdate.graphics.drawText("Ⓐrecording: "..tostring(isRecording), 0, 0)
  playdate.graphics.drawText("mic activity:", 0, 17)
  playdate.graphics.drawRect(90, 17, 50, 16)
  playdate.graphics.fillRect(90, 17, 50 * micLevel, 16)
  playdate.graphics.drawText("mic source: "..playdate.sound.micinput.getSource(), 0, 34)
  playdate.graphics.drawText("Ⓑplayback: "..tostring(source:isPlaying()), 0, 50)
  playdate.graphics.drawText("🎣gain: "..gain, 0, 66)
end