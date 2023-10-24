#!/bin/bash


change_package_name() {
  apk_path="$1"
  new_package_name="$2"


  temp_folder="temp"
  unzip -q "$apk_path" -d "$temp_folder"


  manifest_path="$temp_folder/AndroidManifest.xml"


  sed -i "s/package=\"[^\"]*\"/package=\"$new_package_name\"/" "$manifest_path"


  new_apk_path="new_app.apk"
  cd "$temp_folder" || exit 1
  zip -qr "../$new_apk_path" .


  cd ..
  rm -rf "$temp_folder"

  echo "New APK file generated: $new_apk_path"
}


read -p "Enter the APK file path: " apk_file


read -p "Enter the new package name: " new_package


read -p "To change the package name to '$new_package', type 'yes' or 'y' (or 'no' or 'n' to cancel): " confirm_response


confirm_response="${confirm_response,,}"


if [[ "$confirm_response" == "yes" || "$confirm_response" == "y" ]]; then
  change_package_name "$apk_file" "$new_package"
elif [[ "$confirm_response" == "no" || "$confirm_response" == "n" ]]; then
  echo "Package name change canceled."
else
  echo "Invalid response. Package name change canceled."
fi
