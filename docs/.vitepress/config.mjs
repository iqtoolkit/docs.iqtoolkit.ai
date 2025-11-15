import { defineConfig } from 'vitepress'

export default defineConfig({
  title: 'IQToolkit Documentation',
  description: 'Comprehensive documentation hub for the IQToolkit open-source ecosystem',
  base: '/',
  
  // Theme configuration
  themeConfig: {
    
    nav: [
      { text: 'Home', link: '/' },
      { text: 'Guide', link: '/guide/getting-started' },
      { text: 'Tools', link: '/tools/' },
      {
        text: 'Resources',
        items: [
          { text: 'GitHub', link: 'https://github.com/iqtoolkit' }
        ]
      }
    ],

    sidebar: {
      '/guide/': [
        {
          text: 'Getting Started',
          items: [
            { text: 'Introduction', link: '/guide/introduction' },
            { text: 'Quick Start', link: '/guide/getting-started' },
            { text: 'Installation', link: '/guide/installation' },
            { text: 'Configuration', link: '/guide/configuration' }
          ]
        },
        {
          text: 'Development',
          items: [
            { text: 'Contributing', link: '/guide/contributing' },
            { text: 'Testing Guide', link: '/guide/testing' }
          ]
        }
      ],
      '/tools/': [
        {
          text: 'Tools Overview',
          items: [
            { text: 'All Tools', link: '/tools/' }
          ]
        },
        {
          text: 'Database Tools',
          items: [
            { text: 'Slow Query Doctor', link: '/tools/slow-query-doctor/' }
          ]
        }
      ],
      '/tools/slow-query-doctor/': [
        {
          text: 'Slow Query Doctor',
          items: [
            { text: 'Overview', link: '/tools/slow-query-doctor/' },
            { text: 'Getting Started', link: '/tools/slow-query-doctor/getting-started' },
            { text: 'Configuration', link: '/tools/slow-query-doctor/configuration' },
            { text: 'Examples', link: '/tools/slow-query-doctor/examples' },
            { text: 'Advanced Features', link: '/tools/slow-query-doctor/advanced-features' },
            { text: 'FAQ', link: '/tools/slow-query-doctor/faq' }
          ]
        },
        {
          text: 'Resources',
          items: [
            { text: 'Sample Data', link: '/tools/slow-query-doctor/sample-data' },
            { text: 'Release Process', link: '/tools/slow-query-doctor/release-process' }
          ]
        }
      ]
    },

    socialLinks: [
      { icon: 'github', link: 'https://github.com/iqtoolkit' }
    ],

    footer: {
      message: 'Released under the MIT License.',
      copyright: 'Copyright © 2025 IQToolkit'
    },

    search: {
      provider: 'local'
    },

    editLink: {
      pattern: 'https://github.com/iqtoolkit/docs.iqtoolkit.ai/edit/main/docs/:path'
    }
  },

  // Markdown configuration
  markdown: {
    theme: 'github-dark',
    lineNumbers: true
  },

  // Head configuration
  head: [
    ['meta', { name: 'theme-color', content: '#3c82f6' }],
    ['meta', { property: 'og:type', content: 'website' }],
    ['meta', { property: 'og:locale', content: 'en' }],
    ['meta', { property: 'og:title', content: 'IQToolkit Documentation' }],
    ['meta', { property: 'og:site_name', content: 'IQToolkit Documentation' }],
    ['meta', { property: 'og:url', content: 'https://docs.iqtoolkit.ai/' }]
  ]
})