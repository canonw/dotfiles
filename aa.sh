#!/usr/bin/env bash
# -*-mode:bash-*- vim:ft=bash

Not working - screw the
https://macos-defaults.com/
function defaults_input_sources() {
    # # Enable `Automatically switch to a document's input source'`
    # defaults write com.apple.HIToolbox AppleGlobalTextInputProperties -dict TextInputGlobalPropertyPerContextInput -bool true

    # # `Select the previous input source` as Command + `
    # defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 60 \
    #     "<dict>
    #         <key>enabled</key><true/>
    #         <key>value</key>
    #             <dict>
    #                 <key>parameters</key>
    #                     <array>
    #                         <integer>96</integer>
    #                         <integer>50</integer>
    #                         <integer>1048576</integer>
    #                     </array>
    #                 <key>type</key>
    #                     <string>standard</string>
    #             </dict>
    #     </dict>"

    # Temporarily delete IME input language settings
    defaults delete com.apple.HIToolbox AppleEnabledInputSources

    # Add US IME input source
    defaults write com.apple.HIToolbox AppleEnabledInputSources -array-add \
        "<dict>
            <key>InputSourceKind</key><string>Keyboard Layout</string>
            <key>KeyboardLayout ID</key><integer>0</integer>
            <key>KeyboardLayout Name</key><string>U.S.</string>
        </dict>"

    defaults write com.apple.HIToolbox AppleEnabledInputSources -array-add \
        "<dict>
            <key>Bundle ID</key><string>com.apple.CharacterPaletteIM</string>
            <key>InputSourceKind</key><string>Non Keyboard Input Method</string>
        </dict>"

    defaults write com.apple.HIToolbox AppleEnabledInputSources -array-add \
        "<dict>
            <key>Bundle ID</key><string>com.apple.PressAndHold</string>
            <key>InputSourceKind</key><string>Non Keyboard Input Method</string>
        </dict>"

    # Add additional input
    defaults write com.apple.HIToolbox AppleEnabledInputSources -array-add \
        "<dict>
            <key>Bundle ID</key><string>com.apple.inputmethod.TYIM</string>
            <key>InputSourceKind</key><string>Keyboard Input Method</string>
        </dict>"
    defaults write com.apple.HIToolbox AppleEnabledInputSources -array-add \
        "<dict>
            <key>Bundle ID</key><string>com.apple.inputmethod.TYIM</string>
            <key>InputSourceKind</key><string>Keyboard Input Method</string>
        </dict>"
    defaults write com.apple.HIToolbox AppleEnabledInputSources -array-add \
        "<dict>
            <key>Bundle ID</key><string>com.apple.inputmethod.TYIM</string>
            <key>Input Mode</key><string>com.apple.inputmethod.TYIM.Cangjie</string>
            <key>InputSourceKind</key><string>Input Method</string>
        </dict>"
    defaults write com.apple.HIToolbox AppleEnabledInputSources -array-add \
        "<dict>
            <key>Bundle ID</key><string>com.apple.inputmethod.TYIM</string>
            <key>Input Mode</key><string>com.apple.inputmethod.TYIM.Sucheng</string>
            <key>InputSourceKind</key><string>Input Method</string>
        </dict>"
    defaults write com.apple.HIToolbox AppleEnabledInputSources -array-add \
        "<dict>
            <key>Bundle ID</key><string>com.apple.inputmethod.ChineseHandwriting</string>
            <key>InputSourceKind</key><string>Non Keyboard Input Method</string>
        </dict>"

    # # Add Google Japanese IME input source
    # defaults write com.apple.HIToolbox AppleEnabledInputSources -array-add \
    #     "<dict>
    #         <key>Bundle ID</key><string>com.google.inputmethod.Japanese</string>
    #         <key>Input Mode</key><string>com.apple.inputmethod.Japanese</string>
    #         <key>InputSourceKind</key><string>Input Mode</string>
    #     </dict>"
    # defaults write com.apple.HIToolbox AppleEnabledInputSources -array-add \
    #     "<dict>
    #         <key>Bundle ID</key><string>com.google.inputmethod.Japanese</string>
    #         <key>InputSourceKind</key><string>Keyboard Input Method</string>
    #     </dict>"
}

# // defaults read com.apple.HIToolbox AppleEnabledInputSources
# (
#         {
#         InputSourceKind = "Keyboard Layout";
#         "KeyboardLayout ID" = 0;
#         "KeyboardLayout Name" = "U.S.";
#     },
#         {
#         "Bundle ID" = "com.apple.CharacterPaletteIM";
#         InputSourceKind = "Non Keyboard Input Method";
#     },
#         {
#         "Bundle ID" = "com.apple.PressAndHold";
#         InputSourceKind = "Non Keyboard Input Method";
#     },
#         {
#         "Bundle ID" = "com.apple.inputmethod.TYIM";
#         InputSourceKind = "Keyboard Input Method";
#     },
#         {
#         "Bundle ID" = "com.apple.inputmethod.TYIM";
#         "Input Mode" = "com.apple.inputmethod.TYIM.Cangjie";
#         InputSourceKind = "Input Mode";
#     },
#         {
#         "Bundle ID" = "com.apple.inputmethod.TYIM";
#         "Input Mode" = "com.apple.inputmethod.TYIM.Sucheng";
#         InputSourceKind = "Input Mode";
#     },
#         {
#         "Bundle ID" = "com.apple.inputmethod.ChineseHandwriting";
#         InputSourceKind = "Non Keyboard Input Method";
#     }
# )

function kill_affected_applications() {
    local apps=(
        "Activity Monitor"
        "Calendar"
        "cfprefsd"
        "Dock"
        "Finder"
        # "Google Chrome Canary"
        # "Google Chrome"
        "SizeUp"
        "Rectangle"
        "SystemUIServer"
        # "Terminal" # disable because the setup script is running in the Terminal
        "Transmission"
        "Twitter"
    )
    for app in "${apps[@]}"; do
        killall "${app}" || echo "Process \`${app}\` was not running."
    done
}

defaults_input_sources
kill_affected_applications
