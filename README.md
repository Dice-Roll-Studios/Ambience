# Ambience v1.0.0
Ambience is a ROBLOX studio plugin that enables game developers to save "presets" in module scripts which can be loaded later. Furthermore, Ambience offers a catalog of presets which can be viewed and loaded all in studio!

### **This project uses [Repr](https://devforum.roblox.com/t/repr-–-function-for-printing-tables/276575) to serialize and deserialize tables!**

# Usage

## Generating a preset

To generate a preset, press the "Generate Preset" button found under the Ambience section on your plugins tab. The first time you generate a preset, you may be asked to give the plugin script injection permissions. Don't worry! This is just so the plugin is able to write the preset table in a module script. After allowing the plugin to have script injection permissions, you'll find a module script named "Generated Preset" in the `AMBIENCE` folder in Server Storage.

# Contribution

Want to contribute a preset to Ambience's public library? Read the contribution guide in `CONTRIBUTE.md`.

# Plugin Explained

Ambience stores a big table containing lots of lighting properties such as ambience, brightness and color shifts. When generating a preset based off of your current lighting settings, Ambience stores the table in a module script in the `AMBIENCE` folder under Server Storage.

To load presets, Ambience reads through the properties defined in the table to decide how to configure the game's lighting. Furthermore, presets contain a meta sub-table which contain information such as the presets name, description, author as well as a banner which would be displayed on the preset library if the preset were to be published.

The Ambience preset library is composed of files within the Github repository under the `PublicPresets` directory. When the preset library window is opened, the plugin uses the Github API to fetch and load all the public presets available. Public presets on the Github are stored in JSON format so that they can easily be serialized and deserialized without much work.
