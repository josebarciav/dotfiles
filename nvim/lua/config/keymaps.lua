vim.g.mapleader = " " -- Establece la tecla líder como <Espacio>
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- 🗂️ Archivos y navegación
map("n", "<leader>e", ":NvimTreeToggle<CR>", opts)-- <Space>e: Alternar el árbol de archivos
map("n", "<leader>fe", ":NvimTreeFocus<CR>", {desc = "Ir al panel de archivos"})
map("n", "<leader>pv", vim.cmd.Ex, opts)                 -- <Space>pv: Abrir vista de archivos con :Ex

-- 🔍 Telescope (búsquedas)
map("n", "<leader>ff", ":Telescope find_files<CR>", opts)  -- <Space>ff: Buscar archivos
map("n", "<leader>fg", ":Telescope live_grep<CR>", opts)   -- <Space>fg: Buscar texto (live grep)
map("n", "<leader>fb", ":Telescope buffers<CR>", opts)     -- <Space>fb: Listar buffers abiertos
map("n", "<leader>fh", ":Telescope help_tags<CR>", opts)   -- <Space>fh: Buscar en ayuda
map("n", "<leader>fo", ":Telescope oldfiles<CR>", opts)    -- <Space>fo: Archivos recientes

-- 🧠 LSP (Lenguaje + diagnóstico)
map("n", "gd", vim.lsp.buf.definition, opts)               -- Ir a definición
map("n", "K", vim.lsp.buf.hover, opts)                     -- Mostrar documentación flotante
map("n", "<leader>rn", vim.lsp.buf.rename, opts)           -- <Space>rn: Renombrar símbolo
map("n", "<leader>ca", vim.lsp.buf.code_action, opts)      -- <Space>ca: Sugerencias de código
map("n", "gr", vim.lsp.buf.references, opts)               -- Buscar referencias
map("n", "[d", vim.diagnostic.goto_prev, opts)             -- Ir a diagnóstico anterior
map("n", "]d", vim.diagnostic.goto_next, opts)             -- Ir a siguiente diagnóstico
map("n", "<leader>dl", ":Telescope diagnostics<CR>", opts) -- <Space>dl: Lista de diagnósticos
map("n", "<leader>lf", vim.lsp.buf.format, opts)           -- <Space>lf: Formatear buffer actual

-- 🐍 Treesitter
map("n", "<leader>ts", ":TSHighlightCapturesUnderCursor<CR>", opts) -- <Space>ts: Ver captura de syntax highlight

-- 🧠 Snippets (LuaSnip)
map({ "i", "s" }, "<C-j>", function() require("luasnip").jump(1) end, opts)   -- <C-j>: Siguiente snippet
map({ "i", "s" }, "<C-k>", function() require("luasnip").jump(-1) end, opts)  -- <C-k>: Anterior snippet

-- 🛢️ Base de datos (vim-dadbod)
map("n", "<leader>db", ":DBUIToggle<CR>", opts)           -- <Space>db: Mostrar/ocultar interfaz DB
map("n", "<leader>dc", ":DBUIAddConnection<CR>", opts)    -- <Space>dc: Añadir conexión
map("n", "<leader>dq", ":DB<CR>", opts)                   -- <Space>dq: Ejecutar consulta (query)

-- 📑 Buffers y pestañas
map("n", "<leader>bn", ":enew<CR>", opts)                 -- <Space>bn: Nuevo buffer
map("n", "<leader>bd", ":bd<CR>", opts)                   -- <Space>bd: Cerrar buffer
map("n", "<leader>bp", ":bp<CR>", opts)                   -- <Space>bp: Buffer anterior
map("n", "<leader>bn", ":bn<CR>", opts)                   -- <Space>bn: Buffer siguiente

-- ⏬ Movimiento mejorado
map("n", "J", "mzJ`z", opts)                              -- Mantiene cursor centrado al unir líneas
map("n", "<C-d>", "<C-d>zz", opts)                        -- Centrar tras scroll hacia abajo
map("n", "<C-u>", "<C-u>zz", opts)                        -- Centrar tras scroll hacia arriba
map("n", "n", "nzzzv", opts)                              -- Centrar tras buscar siguiente
map("n", "N", "Nzzzv", opts)                              -- Centrar tras buscar anterior

-- 📋 Copiar/pegar inteligente
map("x", "<leader>p", [["_dP]], opts)                     -- <Space>p: Pegar sin machacar portapapeles
map({ "n", "v" }, "<leader>y", [["+y]], opts)             -- <Space>y: Copiar al portapapeles del sistema
map("n", "<leader>Y", [["+Y]], opts)                      -- <Space>Y: Copiar línea al portapapeles
map({ "n", "v" }, "<leader>d", [["_d]], opts)             -- <Space>d: Borrar sin guardar en portapapeles

-- 🧼 Limpieza
map("n", "<leader>nh", ":nohlsearch<CR>", opts)           -- <Space>nh: Quitar resaltado de búsqueda

-- 💾 Guardado y cierre
map("n", "<leader>w", ":w<CR>", opts)                     -- <Space>w: Guardar archivo
map("n", "<leader>q", ":q<CR>", opts)                     -- <Space>q: Cerrar archivo

-- 🧪 Misceláneo
map("n", "<leader>so", ":source %<CR>", opts)             -- <Space>so: Recargar archivo actual
map("n", "<leader>ch", ":checkhealth<CR>", opts)          -- <Space>ch: Revisar salud de Neovim
-- Git
vim.keymap.set("n", "<leader>gg", ":LazyGit<CR>", { noremap = true, silent = true, desc = "Abrir LazyGit" })


