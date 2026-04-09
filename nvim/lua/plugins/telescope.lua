return {
    'nvim-telescope/telescope.nvim',
    tag = 'v0.2.0',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local telescope = require('telescope')
        local builtin = require('telescope.builtin')

        -- Inclui arquivos ocultos e ignora .git
        local vimgrep_arguments = { unpack(require('telescope.config').values.vimgrep_arguments) }
        table.insert(vimgrep_arguments, '--hidden')
        table.insert(vimgrep_arguments, '--glob')
        table.insert(vimgrep_arguments, '!.git/')

        telescope.setup({
            defaults = {
                vimgrep_arguments = vimgrep_arguments,
                file_ignore_patterns = { '.git/' },
            },
            pickers = {
                find_files = {
                    hidden = true,
                },
            },
        })

        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
    end

}
