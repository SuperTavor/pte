import glob
import os
import shutil
import subprocess

import toml
from art import text2art
from halo import Halo
from lxml import etree as ET
from termcolor import colored

config = toml.load('config.toml')


def find_apk_file():
    apk_files = glob.glob("apk/*.apk")
    return next(iter(apk_files), None)


def execute(cmd, print_error=True, print_output=False):
    try:
        # Execute the command and wait for it to complete
        print(f"Executing command: {cmd}")
        completed_process = subprocess.run(
            cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True
        )

        # Print the output if it has content
        if completed_process.stdout and print_output:
            print(completed_process.stdout)

        # Print the error if it has content
        if completed_process.stderr and print_error:
            print(colored("Error:", "red", attrs=["bold"]))
            print(colored(completed_process.stderr, "red"))

        # Check the return code
        return_code = completed_process.returncode
        if return_code != 0:
            print(colored(f"Return code: {return_code}", "red", attrs=["bold"]))

        return return_code

    except Exception as e:
        print(colored("Error:", "red", attrs=["bold"]))
        print(colored(str(e), "red"))
        return 1


def change_android_manifest(file):
    # Parse the xml file
    parser = ET.XMLParser(remove_blank_text=True)
    tree = ET.parse(file, parser)
    root = tree.getroot()

    ns = {'android': 'http://schemas.android.com/apk/res/android'}

    print("Changing the AndroidManifest.xml...")

    application = root.find('application', namespaces=ns)
    if application is not None and '{http://schemas.android.com/apk/res/android}manageSpace' in application.attrib:
        del application.attrib['{http://schemas.android.com/apk/res/android}manageSpace']

    if application is not None and '{http://schemas.android.com/apk/res/android}label' in application.attrib:
        application.attrib['{http://schemas.android.com/apk/res/android}label'] = "PTE"

    main_activity = root.find(
        ".//activity[@{http://schemas.android.com/apk/res/android}name='com.example.sgf.MainActivity']")

    if main_activity is not None:
        intent_filter = main_activity.find("intent-filter")
        if intent_filter is not None:
            category = intent_filter.find(
                "category[@{http://schemas.android.com/apk/res/android}name='android.intent.category.LAUNCHER']")
            if category is not None:
                intent_filter.remove(category)

            action = intent_filter.find(
                "action[@{http://schemas.android.com/apk/res/android}name='android.intent.action.MAIN']")
            if action is not None:
                intent_filter.remove(action)

    main_activity_xml = ET.fromstring("""
        <activity android:name="com.example.patch.PatchActivity" android:exported="true" xmlns:android="http://schemas.android.com/apk/res/android">
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>
    """)

    if application is not None:
        application.append(main_activity_xml)

    with open(file, 'wb') as f:
        f.write(ET.tostring(root, pretty_print=True, xml_declaration=True, encoding='utf-8'))


def build_apk():
    print("Building the APK...")
    shutil.rmtree(f"patched_apk/", ignore_errors=True)
    os.makedirs(f"patched_apk/", exist_ok=True)
    execute(f"{config['apktool']} b -o patched_apk/punipuni-unsigned-unaligned.apk cache/")
    execute(
        f"{config['zipalign']} -v -p 4 patched_apk/punipuni-unsigned-unaligned.apk patched_apk/punipuni-unsigned-aligned.apk")
    execute(
        f"{config['apksigner']} sign --ks release.keystore --ks-pass pass:ywpptp --out patched_apk/punipuni.apk patched_apk/punipuni-unsigned-aligned.apk")
    for file in glob.glob("patched_apk\*.apk"):
        if file != "patched_apk\punipuni.apk":
            os.remove(file)


def copy_mod_files():
    print("Copying the MOD files to the cache directory...")
    import os
    import shutil

    os.makedirs("cache/assets/mods", exist_ok=True)

    shutil.copytree("mod/image", "cache/assets/mods/image", dirs_exist_ok=True)
    shutil.copytree("mod/movie", "cache/assets/mods/movie", dirs_exist_ok=True)
    shutil.copytree("mod/skill", "cache/assets/mods/skill", dirs_exist_ok=True)
    shutil.copytree("mod/sound", "cache/assets/mods/sound", dirs_exist_ok=True)
    shutil.copytree("mod/ywp_cud", "cache/assets/mods/ywp_cud", dirs_exist_ok=True)

    shutil.rmtree("cache/assets/Application", ignore_errors=True)

    shutil.copytree("mod/Application", "cache/assets/", dirs_exist_ok=True)


def copy_patcher_smali():
    print("Copying Patcher smali files to the cache directory...")
    os.makedirs("cache/smali/com/example/patch/", exist_ok=True)
    shutil.copy("gen_smali/PatchActivity$CopyAssetsTask.smali", "cache/smali/com/example/patch/")
    shutil.copy("gen_smali/PatchActivity.smali", "cache/smali/com/example/patch/")


def check_prerequisites():
    print("Checking prerequisites...")
    missing_tools = []

    if execute(f"{config['apktool']} --version", print_error=True, print_output=True) != 0:
        missing_tools.append("apktool")
    if execute("java -version", print_error=False) != 0:
        missing_tools.append("java")

    if missing_tools:
        print(f"{len(missing_tools)} Tools are missing:")
        for tool in missing_tools:
            print(f" - {tool}")
        exit(1)

    if not os.path.isdir("mod/image"):
        print("The mod/ directory should contain the PuniTranslationProject files.\nDownload from: https://www.punitranslation.com/source-code")
        exit(1)

    if not os.path.isdir("gen_smali"):
        print("The gen_smali/ directory should contain two PatchActivity.smali files.")


def main():
    print(text2art("PUNIDEV"))
    print(colored("Starting the PuniTranslationProject APK Patching Script...", 'yellow', attrs=['bold']))

    print("Finding APK file...")
    apk = find_apk_file()

    check_prerequisites()

    if apk:
        print(colored(f"Found APK file: {apk}", 'green'))
        with Halo(text='Decompiling APK File...', text_color='green', spinner='dots'):
            execute(f"{config['apktool']} d -f -o cache/ {apk}")

        with Halo(text='Patching AndroidManifest.xml...', text_color='green', spinner='dots'):
            change_android_manifest('cache/AndroidManifest.xml')

        with Halo(text='Copying the MOD files to the cache directory...', text_color='green', spinner='dots'):
            copy_mod_files()

        with Halo(text='Copying Patcher smali files to the cache directory...', text_color='green', spinner='dots'):
            copy_patcher_smali()

        with Halo(text='Building the patched APK...', text_color='green', spinner='dots'):
            build_apk()

        print(colored(f"Done! Patched APK should be under patched_apk/", "green"))

    else:
        print(colored("No APK file found under the apk/ directory.", "red"))


if __name__ == "__main__":
    main()
