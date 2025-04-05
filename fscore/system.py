import platform
import sys


def is_linux() -> bool:
    return sys.platform.startswith("linux")


def is_macos() -> bool:
    return sys.platform == "darwin"


def is_windows() -> bool:
    return sys.platform == "win32"


def is_64_bit() -> bool:
    return platform.architecture()[0] == "64bit"


def is_x86_family() -> bool:
    return platform.machine().lower() in [
        "x86_64",
        "x86-64",
        "amd64",
        "i386",
        "i486",
        "i586",
        "i686",
    ]


def is_x86_64() -> bool:
    return is_64_bit() and is_x86_family()

X86_MACHINES = ["x86", "i386", "i486", "i586", "i686"]
X86_64_MACHINES = ["x86_64", "x86-64", "amd64"]
ARM_64_MACHINES = ["aarch64", "arm64"]
ARM_32_MACHINES = ["armhf", "armv8", "armv7l", "armv7", "armv6"]

X86_ANY_MACHINES = X86_MACHINES + X86_64_MACHINES
ARM_ANY_MACHINES = ARM_32_MACHINES + ARM_64_MACHINES

class System:
    linux = is_linux()
    macos = is_macos()
    windows = is_windows()
    x86_64 = is_x86_64()

    if linux:
        platform = "linux"
        _operatingSystem = "Linux"
    elif macos:
        platform = "macos"
        _operatingSystem = "macOS"
    elif windows:
        platform = "windows"
        _operatingSystem = "Windows"
    else:
        platform = "unknown"
        _operatingSystem = "Unknown"

    @classmethod
    def getOperatingSystem(cls) -> str:
        return cls._operatingSystem

    @classmethod
    def getCpuArchitecture(cls) -> str:
        machine = platform.machine().lower()
        if machine in X86_ANY_MACHINES:
            if platform.architecture()[0] == "64bit":
                return "x86-64"
            else:
                return "x86"
        elif machine in ARM_ANY_MACHINES:
            if platform.architecture()[0] == "64bit":
                return "ARM64"
            else:
                return "ARM32"
        return "Unknown"

    @classmethod
    def isWindows(cls) -> bool:
        return cls.windows

    @classmethod
    def isLinux(cls) -> bool:
        return cls.linux

    @classmethod
    def isMacOS(cls) -> bool:
        return cls.macos
