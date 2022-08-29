const { config } = require("vuepress-theme-hope");

module.exports = config({
    /**
     * Ref：https://v1.vuepress.vuejs.org/config/#title
     */
    title: "DevOps",
    /**
     * Ref：https://v1.vuepress.vuejs.org/config/#description
     */
    description: "Cursus DevOps IT Graduaten Thomas More",

    dest: "./dist",

    head: [
        ["script", { src: "https://cdn.jsdelivr.net/npm/react/umd/react.production.min.js" }],
        [
            "script",
            {
                src: "https://cdn.jsdelivr.net/npm/react-dom/umd/react-dom.production.min.js"
            }
        ],
        ["script", { src: "https://cdn.jsdelivr.net/npm/vue/dist/vue.min.js" }],
        ["script", { src: "https://cdn.jsdelivr.net/npm/@babel/standalone/babel.min.js" }]
    ],

    locales: {
        "/": {
            lang: "nl-BE"
        }
    },

    /**
     * Theme configuration, here is the default theme configuration for VuePress.
     *
     * ref：https://v1.vuepress.vuejs.org/theme/default-theme-config.html
     */
    themeConfig: {
        repo: "",
        editLinks: false,
        docsDir: "",
        editLinkText: "",
        lastUpdated: false,
        copyright: "CC-BY-SA Maartje Eyskens @ Thomas More Kempen",
        iconPrefix: "",
        pageInfo: [],
        nav: [
            {
                text: "Intro",
                link: "/intro/",
                icon: "fas fa-home"
            },
            {
                text: "Culture",
                items: [
                    { text: "Agile", link: "/agile/" },
                    { text: "Environments", link: "/concepts/environments/" },
                    { text: "Monitoring", link: "/concepts/monitoring/" },
                    { text: "Security", link: "/concepts/security/" }
                ]
            },
            {
                text: "Tools",
                items: [
                    { text: "Git", link: "/tools/git/" },
                    { text: "YAML", link: "/tools/yaml/" },
                    { text: "Ansible", link: "/tools/ansible/" },
                    { text: "Grafana + Prometheus", link: "/tools/grafana-prometheus/" },
                    { text: "Loadbalancing", link: "/tools/loadbalancing/" },
                    { text: "Deployment Pipeline", link: "/tools/deployment-pipeline/" },
                    { text: "GitHub Projects", link: "/tools/github-projects/" }
                ]
            }
        ],
        sidebar: "auto",
        anchorDisplay: false,
        footer: {
            display: false,
            content: ""
        },

        mdEnhance: {
            enableAll: true,
            presentation: {
                plugins: ["highlight", "math", "search", "notes", "zoom", "anything", "audio", "chalkboard"]
            }
        },

        git: {
            contributor: true,
            timezone: "Europe/Brussels"
        }
    },

    plugins: [
        [
            "md-enhance",
            {
                enableAll: true,
                presentation: {
                    plugins: ["highlight", "math", "search", "notes", "zoom", "anything", "audio", "chalkboard"]
                }
            }
        ]
    ]
});

