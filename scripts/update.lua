-- プラグイン(Lazy)・treesitterパーサー・Masonパッケージをまとめて更新するスクリプト
-- 使い方: nvim --headless -c "luafile ~/.config/nvim/scripts/update.lua"
-- headlessではvim.notifyが画面に出ないため、標準出力へ進捗を書き出す

local TIMEOUT_MS = 10 * 60 * 1000 -- 固まった時に強制終了するまでの時間
local HEARTBEAT_MS = 10 * 1000 -- 実行中のパッケージを表示する間隔

-- 時刻付きで1行出力する
local function log(msg)
  io.stdout:write(os.date "[%H:%M:%S] " .. msg .. "\n")
  io.stdout:flush()
end

-- AstroNvim/Masonの通知(更新対象や完了メッセージ)も標準出力に流す
vim.notify = function(msg) log(tostring(msg)) end

vim.defer_fn(function()
  log "タイムアウトしたため終了します"
  vim.cmd "quitall!"
end, TIMEOUT_MS)

log "== 1/3 プラグイン(Lazy)を更新"
require("lazy").sync { wait = true }

log "== 2/3 treesitterパーサーを更新"
vim.cmd "TSUpdateSync"

log "== 3/3 Masonパッケージ(LSPなど)を更新"
local registry = require "mason-registry"
local running = {} -- インストール中のパッケージ名の集合

registry:on("package:handle", function(pkg) running[pkg.name] = true end)
registry:on("package:install:success", function(pkg)
  running[pkg.name] = nil
  log("  ✓ " .. pkg.name)
end)
registry:on("package:install:failed", function(pkg)
  running[pkg.name] = nil
  log("  ✗ " .. pkg.name .. " (失敗)")
end)

-- go installのように時間がかかるものがあるので、何を待っているかを定期的に表示する
local timer = vim.uv.new_timer()
timer:start(HEARTBEAT_MS, HEARTBEAT_MS, vim.schedule_wrap(function()
  local names = vim.tbl_keys(running)
  if #names > 0 then
    table.sort(names)
    log("  更新中: " .. table.concat(names, ", "))
  end
end))

-- update_allは非同期なので、完了イベントを受けて終了する
vim.api.nvim_create_autocmd("User", {
  pattern = "AstroMasonUpdateCompleted",
  callback = function()
    log "== すべての更新が完了しました"
    vim.cmd "quitall!"
  end,
})
require("astrocore.mason").update_all()
