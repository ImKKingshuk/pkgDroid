<h1 align="center">pkgDroid</h1>
<h3 align="center">v1.2.1</h3>

pkgDroid is a versatile and lightweight command-line tool crafted for comprehensive Android APK manipulation. Packed with advanced functionalities, pkgDroid goes beyond the basics to offer a robust toolkit for APK modding, cracking, extreme modification, and reverse engineering. Dive into the depths of Android app internals with pkgDroid and unleash a new realm of possibilities!

## Whats New ( v1.2.1 )

- Added APK Comparison (Resources, Smali, Manifest etc.)
- Added Rebuild APK
- Added Sign APK
- Added Extract APK
- Optimized Tool
- Enhanced User Menu

## Features

- 📦 **APK Decompilation**: Easily decompile Android APK files for in-depth analysis and modification.
- 🛠️ **Resource Modification**: Seamlessly modify resources such as layouts, images, and strings within APKs.
- 🔍 **Smali Code Analysis**: Analyze and modify Smali code directly for precise app behavior adjustments.
- 🛡️ **Obfuscation Bypass**: Bypass obfuscation techniques to understand and manipulate app logic and flow.
- 🧩 **APK Rebuilding**: Effortlessly rebuild modified APKs for testing or distribution.
- 🛠️ **Advanced Modding**: Dive into advanced modding capabilities to customize APKs to your requirements.
- 🕵️‍♂️ **Reverse Engineering**: Explore app internals, classes, and methods for deep reverse engineering insights.
- 📄 **Manifest Analysis**: View and modify AndroidManifest.xml for fine-grained control over app behavior.
- 📂 **Directory Structure Viewing**: Easily navigate and view the APK's directory structure for quick insights.
- 🚀 **Lightweight**: A lightweight and efficient tool designed for swift APK manipulation.
- ⚙️ **Cross-Platform**: Works seamlessly across macOS, Linux, and Windows environments.
- 💻 **Terminal-Based**: Operate entirely from the terminal for focused and efficient APK modifications.

## Requirements

- macOS, Linux, Windows
- Bash-compatible environment
- Java Development Kit (JDK) installed
- APKs for manipulation
- Internet connectivity for fetching updates

## Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/ImKKingshuk/pkgDroid.git
   cd pkgDroid
   ```

## Usage

1. **Decompile an APK**:

   ```bash
   bash pkgDroid.sh decompile your_app.apk
   ```

2. **Modify Resources**:

   ```bash
   bash pkgDroid.sh modify -r resource_folder/ your_app
   ```

3. **Edit Smali Code**:

   ```bash
   bash pkgDroid.sh edit -s smali_folder/ your_app
   ```

4. **Rebuild the APK**:

   ```bash
   bash pkgDroid.sh rebuild your_app
   ```

5. **Explore More Options**:

   For a full list of commands and options, run:

   ```bash
   bash pkgDroid.sh --help
   ```

## Contributing

Contributions to `pkgDroid` are highly welcomed! Feel free to report issues, suggest enhancements, or submit pull requests. Let's together make APK manipulation more accessible, powerful, and secure!

## Disclaimer

⚠️ **Use responsibly** ⚠️

The developer of `pkgDroid` is not responsible for any misuse or illegal activities conducted with this tool. Ensure proper authorization before using `pkgDroid` for APK manipulation or reverse engineering. Always adhere to ethical hacking practices and comply with all applicable laws and regulations.

## Acknowledgments

`pkgDroid` is developed for educational and research purposes. It should be used with caution and in compliance with legal guidelines. The developer of this tool is not responsible for any misuse of this tool.
