module.exports = {
    /**
     * Ref：https://v1.vuepress.vuejs.org/config/#title
     */
    title: "DevOps",
    /**
     * Ref：https://v1.vuepress.vuejs.org/config/#description
     */
    description: "Cursus DevOps IT Graduaten Thomas More",

    /**
     * Extra tags to be injected to the page HTML `<head>`
     *
     * ref：https://v1.vuepress.vuejs.org/config/#head
     */
    head: [
        ["meta", { name: "theme-color", content: "#3eaf7c" }],
        ["meta", { name: "apple-mobile-web-app-capable", content: "yes" }],
        ["meta", { name: "apple-mobile-web-app-status-bar-style", content: "black" }]
    ],

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
        nav: [
            {
                text: "Intro",
                link: "/intro/"
            },
            {
                text: "Culture",
                items: [
                    { text: "Agile", link: "/agile/" },
                    { text: "Environments", link: "/concepts/environments/" }
                ]
            },
            {
                text: "Tools",
                items: [
                    //{ text: "Kanban op GitHub", link: "/agile/kanban/" },
                    { text: "Git", link: "/tools/git/" },
                    { text: "YAML", link: "/tools/yaml/" },
                    { text: "Ansible", link: "/tools/ansible/" },
                    { text: "Docker", link: "/tools/docker/" }
                ]
            },
            {
                text: "Canvas LMS",
                link: "https://thomasmore.instructure.com/courses/18975"
            }
        ],
        sidebar: "auto"
    },

    /**
     * Apply plugins，ref：https://v1.vuepress.vuejs.org/zh/plugin/
     */
    plugins: [
        "@vuepress/plugin-back-to-top",
        "@vuepress/plugin-medium-zoom",
        [
            "md-enhance",
            {
                // Enable Footnote
                footnote: true
            }
        ]
    ]
};
