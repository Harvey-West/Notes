# Firefox

<https://github.com/piroor/treestyletab/wiki/Code-snippets-for-custom-style-rules#on-firefox-69-and-later>

## UserChrome

You need to set toolkit.legacyUserProfileCustomizations.stylesheets to true with about:config, otherwise userChrome.css in your profile is simply ignored by Firefox.

C:\Users\harve\AppData\Roaming\Mozilla\Firefox\Profiles\vebnwh4u.dev-edition-default\chrome

``` css
#main-window[tabsintitlebar="true"]:not([extradragspace="true"]) #TabsToolbar > .toolbar-items {
  opacity: 0;
  pointer-events: none;
}

#main-window #TabsToolbar {
    visibility: collapse !important;
}

#nav-bar {
   margin-top: -24px;
}
```
