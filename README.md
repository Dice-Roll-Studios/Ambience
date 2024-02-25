# Ambience v1.0.0
Ambience is a ROBLOX studio plugin that enables game developers to save "presets" in module scripts which can be loaded later. Furthermore, Ambience offers a catalog of presets which can be viewed and loaded all in studio!

# Contribution

Want to contribute a preset to Ambience's public library? Read the contribution guide in `CONTRIBUTE.md`.

# Plugin Explained

Ambience stores a big table containing lots of lighting properties such as ambience, brightness and color shifts. When generating a preset based off of your current lighting settings, Ambience stores the table in a module script in the `AMBIENCE` folder under Server Storage.

To load presets, Ambience reads through the properties defined in the table to decide how to configure the game's lighting. Furthermore, presets contain a meta sub-table which contain information such as the presets name, description, author as well as a banner which would be displayed on the preset library if the preset were to be published.

The Ambience preset library is composed of files within the Github repository under the `PublicPresets` directory. When the preset library window is opened, the plugin uses the Github API to fetch and load all the public presets available. Public presets on the Github are stored in JSON format so that they can easily be serialized and deserialized without much work.
