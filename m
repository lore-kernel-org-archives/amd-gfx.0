From: =?UTF-8?Q?Yusuf_Alt=C4=B1parmak?= <yusufalti1997-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [Error] amdgpu for powerpc64 on kernel version 4.19.26
Date: Mon, 25 Nov 2019 16:54:53 +0300
Message-ID: <CAGzVRjyWG8mJKfn04=_KMPxB=YXnaSVC6yUwWy-0E0ndarJs0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0635624013=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============0635624013==
Content-Type: multipart/alternative; boundary="000000000000565e8b05982c1ce5"

--000000000000565e8b05982c1ce5
Content-Type: text/plain; charset="UTF-8"

Hello,

I am trying to use AMD E9171 with T1042D4RDB-64B(
https://www.nxp.com/products/processors-and-microcontrollers/power-architecture/qoriq-communication-processors/t-series/qoriq-t1042-and-t1022-multicore-communications-processors:T1042).

Software documentation is here (
https://www.nxp.com/docs/en/supporting-information/QORIQ-SDK-2.0-IC-REV0.pdf
).


*I tried to compile 'amdgpu' in linux kernel.*

*I successfully compiled linux kernel for powerpc e5500 architecture. I
enabled amdgpu and its prerequisites in menuconfig. All drivers compiled
successfully.*


*But when I try to install 'amdgpu.ko' module, it's not initializing gpu
hardware. Console messages from 'dmesg' and U-boot is below. Hardware is
connected to board via PCI and connected to monitor via HDMI-DVI converter.
I am using HDMI port on monitor.*

* Any suggestion/solutions for this situation?*

Regards.



Dmesg messages from linux about amdgpu:

[5.866162] [drm] amdgpu kernel modesetting enabled.
[5.870293] [drm] initializing kernel modesetting (POLARIS12 0x1002:0x6987
0x1787:0x2389 0x80).

[5.877719] amdgpu 0001:01:00.0: Fatal error during GPU init

[5.882363] amdgpu: probe of 0001:01:00.0 failed with error -12


'dmesg' messages from Linux


[    0.464934] pci 0000:00:00.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[    0.473580] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    0.477426] pci 0000:00:00.0:   bridge window [io
 0x8000080000010000-0x8000080000010fff]
[    0.477431] pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
[    0.477438] pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff
64bit pref]
[    0.477451] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
[    0.477456] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 01
[    0.477584] fsl-pci ffe250000.pcie: PCI host bridge to bus 0001:00
[    0.482383] pci_bus 0001:00: root bus resource [io
 0x8000080000021000-0x8000080000030fff] (bus address [0x0000-0xffff])
[    0.491940] pci_bus 0001:00: root bus resource [mem
0xc10000000-0xc1fffffff] (bus address [0xe0000000-0xefffffff])
[    0.500980] pci_bus 0001:00: root bus resource [bus 00-01]
[    0.505153] pci_bus 0001:00: busn_res: [bus 00-01] end is updated to ff
[    0.505172] pci 0001:00:00.0: [1957:0824] type 01 class 0x0b2000
[    0.505191] pci 0001:00:00.0: reg 0x10: [mem 0xff000000-0xffffffff]
[    0.505236] pci 0001:00:00.0: supports D1 D2
[    0.505239] pci 0001:00:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.505346] iommu: Removing device ffe250000.pcie from group 20
[    0.509901] iommu: Adding device 0001:00:00.0 to group 19
[    0.516106] pci 0001:01:00.0: [1002:6987] type 00 class 0x030000
[    0.516160] pci 0001:01:00.0: reg 0x10: [mem 0xc10000000-0xc1fffffff
64bit pref]
[    0.516175] pci 0001:01:00.0: reg 0x18: [mem
0x1000ffe00000-0x1000ffffffff 64bit pref]
[    0.516186] pci 0001:01:00.0: reg 0x20: [io
 0x8000080000022100-0x80000800000221ff]
[    0.516196] pci 0001:01:00.0: reg 0x24: [mem 0xfffc0000-0xffffffff]
[    0.516207] pci 0001:01:00.0: reg 0x30: [mem 0xfffe0000-0xffffffff pref]
[    0.516219] pci 0001:01:00.0: enabling Extended Tags
[    0.519920] pci 0001:01:00.0: supports D1 D2
[    0.519923] pci 0001:01:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.519958] pci 0001:01:00.0: 4.000 Gb/s available PCIe bandwidth,
limited by 5 GT/s x1 link at 0001:00:00.0 (capable of 63.008 Gb/s with 8
GT/s x8 link)
[    0.532404] iommu: Adding device 0001:01:00.0 to group 19
[    0.536460] pci 0001:01:00.1: [1002:aae0] type 00 class 0x040300
[    0.536500] pci 0001:01:00.1: reg 0x10: [mem
0x1200ffffc000-0x1200ffffffff 64bit]
[    0.536553] pci 0001:01:00.1: enabling Extended Tags
[    0.540200] pci 0001:01:00.1: supports D1 D2
[    0.540291] iommu: Adding device 0001:01:00.1 to group 19
[    0.546301] pci 0001:00:00.0: PCI bridge to [bus 01-ff]
[    0.550147] pci 0001:00:00.0:   bridge window [io
 0x8000080000022000-0x8000080000022fff]
[    0.550152] pci 0001:00:00.0:   bridge window [mem
0xc10000000-0xc1fffffff]
[    0.550235] pci_bus 0001:01: busn_res: [bus 01-ff] end is updated to 01
[    0.550242] pci_bus 0001:00: busn_res: [bus 00-ff] end is updated to 01
[    0.550376] fsl-pci ffe260000.pcie: PCI host bridge to bus 0002:00
[    0.555177] pci_bus 0002:00: root bus resource [io
 0x8000080000032000-0x8000080000041fff] (bus address [0x0000-0xffff])
[    0.564732] pci_bus 0002:00: root bus resource [mem
0xc20000000-0xc2fffffff] (bus address [0xe0000000-0xefffffff])
[    0.573773] pci_bus 0002:00: root bus resource [bus 00]
[    0.577680] pci_bus 0002:00: busn_res: [bus 00] end is updated to ff
[    0.577698] pci 0002:00:00.0: [1957:0824] type 01 class 0x0b2000
[    0.577718] pci 0002:00:00.0: reg 0x10: [mem 0xff000000-0xffffffff]
[    0.577764] pci 0002:00:00.0: supports D1 D2
[    0.577767] pci 0002:00:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.577880] iommu: Removing device ffe260000.pcie from group 21
[    0.582434] iommu: Adding device 0002:00:00.0 to group 20
[    0.588545] pci 0002:00:00.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[    0.597194] pci 0002:00:00.0: PCI bridge to [bus 01-ff]
[    0.601040] pci 0002:00:00.0:   bridge window [io
 0x8000080000032000-0x8000080000032fff]
[    0.601045] pci 0002:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
[    0.601052] pci 0002:00:00.0:   bridge window
Dmesg messages from linux about amdgpu:
[5.866162] [drm] amdgpu kernel modesetting enabled.
[5.870293] [drm] initializing kernel modesetting (POLARIS12 0x1002:0x6987
0x1787:0x2389 0x80).

[5.877719] amdgpu 0001:01:00.0: Fatal error during GPU init

[5.882363] amdgpu: probe of 0001:01:00.0 failed with error -12 [mem
0x00000000-0x000fffff 64bit pref]
[    0.601064] pci_bus 0002:01: busn_res: [bus 01-ff] end is updated to 01
[    0.601070] pci_bus 0002:00: busn_res: [bus 00-ff] end is updated to 01
[    0.601197] fsl-pci ffe270000.pcie: PCI host bridge to bus 0003:00
[    0.605995] pci_bus 0003:00: root bus resource [io
 0x8000080000043000-0x8000080000052fff] (bus address [0x0000-0xffff])
[    0.615553] pci_bus 0003:00: root bus resource [mem
0xc30000000-0xc3fffffff] (bus address [0xe0000000-0xefffffff])
[    0.624593] pci_bus 0003:00: root bus resource [bus 00]
[    0.628501] pci_bus 0003:00: busn_res: [bus 00] end is updated to ff
[    0.628519] pci 0003:00:00.0: [1957:0824] type 01 class 0x0b2000
[    0.628538] pci 0003:00:00.0: reg 0x10: [mem 0xff000000-0xffffffff]
[    0.628584] pci 0003:00:00.0: supports D1 D2
[    0.628588] pci 0003:00:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.628703] iommu: Removing device ffe270000.pcie from group 22
[    0.633257] iommu: Adding device 0003:00:00.0 to group 21
[    0.639362] pci 0003:00:00.0: bridge configuration invalid ([bus
00-00]), reconfiguring
Dmesg messages from linux about amdgpu:
[5.866162] [drm] amdgpu kernel modesetting enabled.
[5.870293] [drm] initializing kernel modesetting (POLARIS12 0x1002:0x6987
0x1787:0x2389 0x80).

[5.877719] amdgpu 0001:01:00.0: Fatal error during GPU init

[5.882363] amdgpu: probe of 0001:01:00.0 failed with error -12[
 0.648066] pci 0003:00:00.0: PCI bridge to [bus 01-ff]
[    0.651912] pci 0003:00:00.0:   bridge window [io
 0x8000080000043000-0x8000080000043fff]
[    0.651917] pci 0003:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
[    0.651923] pci 0003:00:00.0:   bridge window [mem 0x00000000-0x000fffff
64bit pref]
[    0.651936] pci_bus 0003:01: busn_res: [bus 01-ff] end is updated to 01
[    0.651942] pci_bus 0003:00: busn_res: [bus 00-ff] end is updated to 01
[    0.651988] PCI: Cannot allocate resource region 0 of device
0000:00:00.0, will remap
[    0.658435] PCI: Cannot allocate resource region 0 of device
0001:00:00.0, will remap
[    0.664953] PCI: Cannot allocate resource region 2 of device
0001:01:00.0, will remap
[    0.671469] PCI: Cannot allocate resource region 5 of device
0001:01:00.0, will remap
[    0.677989] PCI: Cannot allocate resource region 6 of device
0001:01:00.0, will remap
[    0.684514] PCI: Cannot allocate resource region 0 of device
0001:01:00.1, will remap
[    0.691033] PCI: Cannot allocate resource region 0 of device
0002:00:00.0, will remap
[    0.697552] PCI: Cannot allocate resource region 0 of device
0003:00:00.0, will remap
[    0.704083] PCI 0000:00 Cannot reserve Legacy IO [io
 0x8000080000010000-0x10fff]
[    0.704086] PCI 0001:00 Cannot reserve Legacy IO [io
 0x8000080000021000-0x21fff]
[    0.704089] PCI 0002:00 Cannot reserve Legacy IO [io
 0x8000080000032000-0x32fff]
[    0.704092] PCI 0003:00 Cannot reserve Legacy IO [io
 0x8000080000043000-0x43fff]
[    0.704107] pci 0000:00:00.0: BAR 0: no space for [mem size 0x01000000]
[    0.709375] pci 0000:00:00.0: BAR 0: failed to assign [mem size
0x01000000]
[    0.715026] pci 0000:00:00.0: PCI bridge to [bus 01]
[    0.718673] pci 0000:00:00.0:   bridge window [io
 0x8000080000010000-0x800008000001ffff]
[    0.725545] pci 0000:00:00.0:   bridge window [mem
0xc00000000-0xc0fffffff]
[    0.731196] pci_bus 0000:00: Some PCI device resources are unassigned,
try booting with pci=realloc
[    0.738932] pci_bus 0000:00: resource 4 [io
 0x8000080000010000-0x800008000001ffff]
[    0.738935] pci_bus 0000:00: resource 5 [mem 0xc00000000-0xc0fffffff]
[    0.738939] pci_bus 0000:01: resource 0 [io
 0x8000080000010000-0x800008000001ffff]
[    0.738942] pci_bus 0000:01: resource 1 [mem 0xc00000000-0xc0fffffff]
[    0.738953] pci 0001:00:00.0: BAR 0: no space for [mem size 0x01000000]
[    0.744235] pci 0001:00:00.0: BAR 0: failed to assign [mem size
0x01000000]
[    0.749887] pci 0001:00:00.0: BAR 9: no space for [mem size 0x00200000
64bit pref]
[    0.756144] pci 0001:00:00.0: BAR 9: failed to assign [mem size
0x00200000 64bit pref]
[    0.762754] pci 0001:01:00.0: BAR 2: no space for [mem size 0x00200000
64bit pref]
[    0.769010] pci 0001:01:00.0: BAR 2: failed to assign [mem size
0x00200000 64bit pref]
[    0.775617] pci 0001:01:00.0: BAR 5: no space for [mem size 0x00040000]
[    0.780920] pci 0001:01:00.0: BAR 5: failed to assign [mem size
0x00040000]
[    0.786571] pci 0001:01:00.0: BAR 6: no space for [mem size 0x00020000
pref]
[    0.792308] pci 0001:01:00.0: BAR 6: failed to assign [mem size
0x00020000 pref]
[    0.798394] pci 0001:01:00.1: BAR 0: no space for [mem size 0x00004000
64bit]
[    0.804218] pci 0001:01:00.1: BAR 0: failed to assign [mem size
0x00004000 64bit]
[    0.810391] pci 0001:00:00.0: PCI bridge to [bus 01]
[    0.814038] pci 0001:00:00.0:   bridge window [io
 0x8000080000021000-0x8000080000030fff]
[    0.820910] pci 0001:00:00.0:   bridge window [mem
0xc10000000-0xc1fffffff]
[    0.826561] pci_bus 0001:00: Some PCI device resources are unassigned,
try booting with pci=realloc
[    0.834298] pci_bus 0001:00: resource 4 [io
 0x8000080000021000-0x8000080000030fff]
[    0.834301] pci_bus 0001:00: resource 5 [mem 0xc10000000-0xc1fffffff]
[    0.834305] pci_bus 0001:01: resource 0 [io
 0x8000080000021000-0x8000080000030fff]
[    0.834308] pci_bus 0001:01: resource 1 [mem 0xc10000000-0xc1fffffff]
[    0.834318] pci 0002:00:00.0: BAR 0: no space for [mem size 0x01000000]
[    0.839600] pci 0002:00:00.0: BAR 0: failed to assign [mem size
0x01000000]
[    0.845251] pci 0002:00:00.0: PCI bridge to [bus 01]
[    0.848898] pci 0002:00:00.0:   bridge window [io
 0x8000080000032000-0x8000080000041fff]
[    0.855780] pci 0002:00:00.0:   bridge window [mem
0xc20000000-0xc2fffffff]
[    0.861422] pci_bus 0002:00: Some PCI device resources are unassigned,
try booting with pci=realloc
[    0.869158] pci_bus 0002:00: resource 4 [io
 0x8000080000032000-0x8000080000041fff]
[    0.869161] pci_bus 0002:00: resource 5 [mem 0xc20000000-0xc2fffffff]
[    0.869165] pci_bus 0002:01: resource 0 [io
 0x8000080000032000-0x8000080000041fff]
[    0.869168] pci_bus 0002:01: resource 1 [mem 0xc20000000-0xc2fffffff]
[    0.869178] pci 0003:00:00.0: BAR 0: no space for [mem size 0x01000000]
[    0.874468] pci 0003:00:00.0: BAR 0: failed to assign [mem size
0x01000000]
[    0.880112] pci 0003:00:00.0: PCI bridge to [bus 01]
[    0.883759] pci 0003:00:00.0:   bridge window [io
 0x8000080000043000-0x8000080000052fff]
[    0.890632] pci 0003:00:00.0:   bridge window [mem
0xc30000000-0xc3fffffff]
[    0.896284] pci_bus 0003:00: Some PCI device resources are unassigned,
try booting with pci=realloc
[    0.904018] pci_bus 0003:00: resource 4 [io
 0x8000080000043000-0x8000080000052fff]
[    0.904022] pci_bus 0003:00: resource 5 [mem 0xc30000000-0xc3fffffff]
[    0.904025] pci_bus 0003:01: resource 0 [io
 0x8000080000043000-0x8000080000052fff]
[    0.904028] pci_bus 0003:01: resource 1 [mem 0xc30000000-0xc3fffffff]
[    0.904030] PCI: Probing PCI hardware done



PCI console messages from U-BOOT


PCI: Probing PCI hardware
fsl-pci ffe240000.pcie: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io
 0x8000080000010000-0x800008000001ffff] (bus address [0x0000-0xffff])
pci_bus 0000:00: root bus resource [mem 0xc00000000-0xc0fffffff] (bus
address [0xe0000000-0xefffffff])
pci_bus 0000:00: root bus resource [bus 00]
iommu: Removing device ffe240000.pcie from group 19
iommu: Adding device 0000:00:00.0 to group 24
pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:00:00.0: PCI bridge to [bus 01-ff]
fsl-pci ffe250000.pcie: PCI host bridge to bus 0001:00
pci_bus 0001:00: root bus resource [io
 0x8000080000021000-0x8000080000030fff] (bus address [0x0000-0xffff])
pci_bus 0001:00: root bus resource [mem 0xc10000000-0xc1fffffff] (bus
address [0xe0000000-0xefffffff])
pci_bus 0001:00: root bus resource [bus 00-01]
iommu: Removing device ffe250000.pcie from group 20
iommu: Adding device 0001:00:00.0 to group 19
pci 0001:01:00.0: enabling Extended Tags
pci 0001:01:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 5 GT/s x1
link at 0001:00:00.0 (capable of 63.008 Gb/s with 8 GT/s x8 link)
iommu: Adding device 0001:01:00.0 to group 19
pci 0001:01:00.1: enabling Extended Tags
iommu: Adding device 0001:01:00.1 to group 19
pci 0001:00:00.0: PCI bridge to [bus 01-ff]
fsl-pci ffe260000.pcie: PCI host bridge to bus 0002:00
pci_bus 0002:00: root bus resource [io
 0x8000080000032000-0x8000080000041fff] (bus address [0x0000-0xffff])
pci_bus 0002:00: root bus resource [mem 0xc20000000-0xc2fffffff] (bus
address [0xe0000000-0xefffffff])
pci_bus 0002:00: root bus resource [bus 00]
iommu: Removing device ffe260000.pcie from group 21
iommu: Adding device 0002:00:00.0 to group 20
pci 0002:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0002:00:00.0: PCI bridge to [bus 01-ff]
fsl-pci ffe270000.pcie: PCI host bridge to bus 0003:00
pci_bus 0003:00: root bus resource [io
 0x8000080000043000-0x8000080000052fff] (bus address [0x0000-0xffff])
pci_bus 0003:00: root bus resource [mem 0xc30000000-0xc3fffffff] (bus
address [0xe0000000-0xefffffff])
pci_bus 0003:00: root bus resource [bus 00]
iommu: Removing device ffe270000.pcie from group 22
iommu: Adding device 0003:00:00.0 to group 21
pci 0003:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0003:00:00.0: PCI bridge to [bus 01-ff]
PCI: Cannot allocate resource region 0 of device 0000:00:00.0, will remap
PCI: Cannot allocate resource region 0 of device 0001:00:00.0, will remap
PCI: Cannot allocate resource region 2 of device 0001:01:00.0, will remap
PCI: Cannot allocate resource region 5 of device 0001:01:00.0, will remap
PCI: Cannot allocate resource region 6 of device 0001:01:00.0, will remap
PCI: Cannot allocate resource region 0 of device 0001:01:00.1, will remap
PCI: Cannot allocate resource region 0 of device 0002:00:00.0, will remap
PCI: Cannot allocate resource region 0 of device 0003:00:00.0, will remap
pci 0000:00:00.0: BAR 0: no space for [mem size 0x01000000]
pci 0000:00:00.0: BAR 0: failed to assign [mem size 0x01000000]
pci 0000:00:00.0: PCI bridge to [bus 01]
pci 0000:00:00.0:   bridge window [io
 0x8000080000010000-0x800008000001ffff]
pci 0000:00:00.0:   bridge window [mem 0xc00000000-0xc0fffffff]
pci_bus 0000:00: Some PCI device resources are unassigned, try booting with
pci=realloc
pci 0001:00:00.0: BAR 0: no space for [mem size 0x01000000]
pci 0001:00:00.0: BAR 0: failed to assign [mem size 0x01000000]
pci 0001:00:00.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
pci 0001:00:00.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
pci 0001:01:00.0: BAR 2: no space for [mem size 0x00200000 64bit pref]
pci 0001:01:00.0: BAR 2: failed to assign [mem size 0x00200000 64bit pref]
pci 0001:01:00.0: BAR 5: no space for [mem size 0x00040000]
pci 0001:01:00.0: BAR 5: failed to assign [mem size 0x00040000]
pci 0001:01:00.0: BAR 6: no space for [mem size 0x00020000 pref]
pci 0001:01:00.0: BAR 6: failed to assign [mem size 0x00020000 pref]
pci 0001:01:00.1: BAR 0: no space for [mem size 0x00004000 64bit]
pci 0001:01:00.1: BAR 0: failed to assign [mem size 0x00004000 64bit]
pci 0001:00:00.0: PCI bridge to [bus 01]
pci 0001:00:00.0:   bridge window [io
 0x8000080000021000-0x8000080000030fff]
pci 0001:00:00.0:   bridge window [mem 0xc10000000-0xc1fffffff]
pci_bus 0001:00: Some PCI device resources are unassigned, try booting with
pci=realloc
pci 0002:00:00.0: BAR 0: no space for [mem size 0x01000000]
pci 0002:00:00.0: BAR 0: failed to assign [mem size 0x01000000]
pci 0002:00:00.0: PCI bridge to [bus 01]
pci 0002:00:00.0:   bridge window [io
 0x8000080000032000-0x8000080000041fff]
pci 0002:00:00.0:   bridge window [mem 0xc20000000-0xc2fffffff]
pci_bus 0002:00: Some PCI device resources are unassigned, try booting with
pci=realloc
pci 0003:00:00.0: BAR 0: no space for [mem size 0x01000000]
pci 0003:00:00.0: BAR 0: failed to assign [mem size 0x01000000]
pci 0003:00:00.0: PCI bridge to [bus 01]
pci 0003:00:00.0:   bridge window [io
 0x8000080000043000-0x8000080000052fff]
pci 0003:00:00.0:   bridge window [mem 0xc30000000-0xc3fffffff]
pci_bus 0003:00: Some PCI device resources are unassigned, try booting with
pci=realloc

--000000000000565e8b05982c1ce5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello,</div><div><br></div><div> I am trying to use A=
MD E9171 with T1042D4RDB-64B(<a href=3D"https://www.nxp.com/products/proces=
sors-and-microcontrollers/power-architecture/qoriq-communication-processors=
/t-series/qoriq-t1042-and-t1022-multicore-communications-processors:T1042">=
https://www.nxp.com/products/processors-and-microcontrollers/power-architec=
ture/qoriq-communication-processors/t-series/qoriq-t1042-and-t1022-multicor=
e-communications-processors:T1042</a>). <br></div><div>Software documentati=
on is here (<a href=3D"https://www.nxp.com/docs/en/supporting-information/Q=
ORIQ-SDK-2.0-IC-REV0.pdf">https://www.nxp.com/docs/en/supporting-informatio=
n/QORIQ-SDK-2.0-IC-REV0.pdf</a>).</div><div><br></div><div><br></div><div><=
b><font size=3D"2">I tried to compile <u>&#39;amdgpu&#39; </u>in linux kern=
el.</font></b></div><div><br></div><div><b>I successfully compiled linux ke=
rnel for powerpc e5500 architecture. I enabled amdgpu and its prerequisites=
 in menuconfig. All drivers compiled successfully.</b></div><div><div><b></=
b></div></div><div><br></div><div><b>But when I try to install <u>&#39;amdg=
pu.ko&#39;</u> module, it&#39;s not initializing gpu hardware. Console mess=
ages from &#39;dmesg&#39; and U-boot is below. Hardware is connected to boa=
rd via PCI and connected to monitor via HDMI-DVI converter. I am using HDMI=
 port on monitor.<br></b></div><div><b><br></b></div><div><b> Any suggestio=
n/solutions for this situation?</b></div><div><br></div><div>Regards.<br></=
div><div><br></div><div><br><div><span style=3D"font-family:georgia,serif">=
<br></span></div><div><font size=3D"4"><span style=3D"font-family:georgia,s=
erif">Dmesg messages from linux about amdgpu:</span></font></div><div><br><=
/div><div>[5.866162] [drm] amdgpu kernel modesetting enabled.=C2=A0=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </div=
>[5.870293] [drm] initializing kernel modesetting (POLARIS12 0x1002:0x6987 =
0x1787:0x2389 0x80). =C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=C2=A0 <br>[5.877719] amdgpu 0001:01:00.0: Fatal error during GPU init =
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>[5.882363] amdgpu: probe of =
0001:01:00.0 failed with error -12</div><div><br></div><div><div><br></div>=
<div><font size=3D"4"><span style=3D"font-family:comic sans ms,sans-serif">=
&#39;dmesg&#39; messages from Linux</span></font></div><div><br></div><div>=
<br></div><div>[ =C2=A0 =C2=A00.464934] pci 0000:00:00.0: bridge configurat=
ion invalid ([bus 00-00]), reconfiguring<br>[ =C2=A0 =C2=A00.473580] pci 00=
00:00:00.0: PCI bridge to [bus 01-ff]<br>[ =C2=A0 =C2=A00.477426] pci 0000:=
00:00.0: =C2=A0 bridge window [io =C2=A00x8000080000010000-0x8000080000010f=
ff]<br>[ =C2=A0 =C2=A00.477431] pci 0000:00:00.0: =C2=A0 bridge window [mem=
 0x00000000-0x000fffff]<br>[ =C2=A0 =C2=A00.477438] pci 0000:00:00.0: =C2=
=A0 bridge window [mem 0x00000000-0x000fffff 64bit pref]<br>[ =C2=A0 =C2=A0=
0.477451] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01<br>[ =
=C2=A0 =C2=A00.477456] pci_bus 0000:00: busn_res: [bus 00-ff] end is update=
d to 01<br>[ =C2=A0 =C2=A00.477584] fsl-pci ffe250000.pcie: PCI host bridge=
 to bus 0001:00<br>[ =C2=A0 =C2=A00.482383] pci_bus 0001:00: root bus resou=
rce [io =C2=A00x8000080000021000-0x8000080000030fff] (bus address [0x0000-0=
xffff])<br>[ =C2=A0 =C2=A00.491940] pci_bus 0001:00: root bus resource [mem=
 0xc10000000-0xc1fffffff] (bus address [0xe0000000-0xefffffff])<br>[ =C2=A0=
 =C2=A00.500980] pci_bus 0001:00: root bus resource [bus 00-01]<br>[ =C2=A0=
 =C2=A00.505153] pci_bus 0001:00: busn_res: [bus 00-01] end is updated to f=
f<br>[ =C2=A0 =C2=A00.505172] pci 0001:00:00.0: [1957:0824] type 01 class 0=
x0b2000<br>[ =C2=A0 =C2=A00.505191] pci 0001:00:00.0: reg 0x10: [mem 0xff00=
0000-0xffffffff]<br>[ =C2=A0 =C2=A00.505236] pci 0001:00:00.0: supports D1 =
D2<br>[ =C2=A0 =C2=A00.505239] pci 0001:00:00.0: PME# supported from D0 D1 =
D2 D3hot D3cold<br>[ =C2=A0 =C2=A00.505346] iommu: Removing device ffe25000=
0.pcie from group 20<br>[ =C2=A0 =C2=A00.509901] iommu: Adding device 0001:=
00:00.0 to group 19<br>[ =C2=A0 =C2=A00.516106] pci 0001:01:00.0: [1002:698=
7] type 00 class 0x030000<br>[ =C2=A0 =C2=A00.516160] pci 0001:01:00.0: reg=
 0x10: [mem 0xc10000000-0xc1fffffff 64bit pref]<br>[ =C2=A0 =C2=A00.516175]=
 pci 0001:01:00.0: reg 0x18: [mem 0x1000ffe00000-0x1000ffffffff 64bit pref]=
<br>[ =C2=A0 =C2=A00.516186] pci 0001:01:00.0: reg 0x20: [io =C2=A00x800008=
0000022100-0x80000800000221ff]<br>[ =C2=A0 =C2=A00.516196] pci 0001:01:00.0=
: reg 0x24: [mem 0xfffc0000-0xffffffff]<br>[ =C2=A0 =C2=A00.516207] pci 000=
1:01:00.0: reg 0x30: [mem 0xfffe0000-0xffffffff pref]<br>[ =C2=A0 =C2=A00.5=
16219] pci 0001:01:00.0: enabling Extended Tags<br>[ =C2=A0 =C2=A00.519920]=
 pci 0001:01:00.0: supports D1 D2<br>[ =C2=A0 =C2=A00.519923] pci 0001:01:0=
0.0: PME# supported from D1 D2 D3hot D3cold<br>[ =C2=A0 =C2=A00.519958] pci=
 0001:01:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 5 GT/s x1 li=
nk at 0001:00:00.0 (capable of 63.008 Gb/s with 8 GT/s x8 link)<br>[ =C2=A0=
 =C2=A00.532404] iommu: Adding device 0001:01:00.0 to group 19<br>[ =C2=A0 =
=C2=A00.536460] pci 0001:01:00.1: [1002:aae0] type 00 class 0x040300<br>[ =
=C2=A0 =C2=A00.536500] pci 0001:01:00.1: reg 0x10: [mem 0x1200ffffc000-0x12=
00ffffffff 64bit]<br>[ =C2=A0 =C2=A00.536553] pci 0001:01:00.1: enabling Ex=
tended Tags<br>[ =C2=A0 =C2=A00.540200] pci 0001:01:00.1: supports D1 D2<br=
>[ =C2=A0 =C2=A00.540291] iommu: Adding device 0001:01:00.1 to group 19<br>=
[ =C2=A0 =C2=A00.546301] pci 0001:00:00.0: PCI bridge to [bus 01-ff]<br>[ =
=C2=A0 =C2=A00.550147] pci 0001:00:00.0: =C2=A0 bridge window [io =C2=A00x8=
000080000022000-0x8000080000022fff]<br>[ =C2=A0 =C2=A00.550152] pci 0001:00=
:00.0: =C2=A0 bridge window [mem 0xc10000000-0xc1fffffff]<br>[ =C2=A0 =C2=
=A00.550235] pci_bus 0001:01: busn_res: [bus 01-ff] end is updated to 01<br=
>[ =C2=A0 =C2=A00.550242] pci_bus 0001:00: busn_res: [bus 00-ff] end is upd=
ated to 01<br>[ =C2=A0 =C2=A00.550376] fsl-pci ffe260000.pcie: PCI host bri=
dge to bus 0002:00<br>[ =C2=A0 =C2=A00.555177] pci_bus 0002:00: root bus re=
source [io =C2=A00x8000080000032000-0x8000080000041fff] (bus address [0x000=
0-0xffff])<br>[ =C2=A0 =C2=A00.564732] pci_bus 0002:00: root bus resource [=
mem 0xc20000000-0xc2fffffff] (bus address [0xe0000000-0xefffffff])<br>[ =C2=
=A0 =C2=A00.573773] pci_bus 0002:00: root bus resource [bus 00]<br>[ =C2=A0=
 =C2=A00.577680] pci_bus 0002:00: busn_res: [bus 00] end is updated to ff<b=
r>[ =C2=A0 =C2=A00.577698] pci 0002:00:00.0: [1957:0824] type 01 class 0x0b=
2000<br>[ =C2=A0 =C2=A00.577718] pci 0002:00:00.0: reg 0x10: [mem 0xff00000=
0-0xffffffff]<br>[ =C2=A0 =C2=A00.577764] pci 0002:00:00.0: supports D1 D2<=
br>[ =C2=A0 =C2=A00.577767] pci 0002:00:00.0: PME# supported from D0 D1 D2 =
D3hot D3cold<br>[ =C2=A0 =C2=A00.577880] iommu: Removing device ffe260000.p=
cie from group 21<br>[ =C2=A0 =C2=A00.582434] iommu: Adding device 0002:00:=
00.0 to group 20<br>[ =C2=A0 =C2=A00.588545] pci 0002:00:00.0: bridge confi=
guration invalid ([bus 00-00]), reconfiguring<br>[ =C2=A0 =C2=A00.597194] p=
ci 0002:00:00.0: PCI bridge to [bus 01-ff]<br>[ =C2=A0 =C2=A00.601040] pci =
0002:00:00.0: =C2=A0 bridge window [io =C2=A00x8000080000032000-0x800008000=
0032fff]<br>[ =C2=A0 =C2=A00.601045] pci 0002:00:00.0: =C2=A0 bridge window=
 [mem 0x00000000-0x000fffff]<br>[ =C2=A0 =C2=A00.601052] pci 0002:00:00.0: =
=C2=A0 bridge window<div>Dmesg messages from linux about amdgpu:<br></div><=
div>[5.866162] [drm] amdgpu kernel modesetting enabled.=C2=A0=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </div>[5.870=
293]
 [drm] initializing kernel modesetting (POLARIS12 0x1002:0x6987=20
0x1787:0x2389 0x80). =C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=C2=A0 <br>[5.877719] amdgpu 0001:01:00.0: Fatal error dur=
ing GPU init =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>[5.882363] amdg=
pu: probe of 0001:01:00.0 failed with error -12 [mem 0x00000000-0x000fffff =
64bit pref]<br>[ =C2=A0 =C2=A00.601064] pci_bus 0002:01: busn_res: [bus 01-=
ff] end is updated to 01<br>[ =C2=A0 =C2=A00.601070] pci_bus 0002:00: busn_=
res: [bus 00-ff] end is updated to 01<br>[ =C2=A0 =C2=A00.601197] fsl-pci f=
fe270000.pcie: PCI host bridge to bus 0003:00<br>[ =C2=A0 =C2=A00.605995] p=
ci_bus 0003:00: root bus resource [io =C2=A00x8000080000043000-0x8000080000=
052fff] (bus address [0x0000-0xffff])<br>[ =C2=A0 =C2=A00.615553] pci_bus 0=
003:00: root bus resource [mem 0xc30000000-0xc3fffffff] (bus address [0xe00=
00000-0xefffffff])<br>[ =C2=A0 =C2=A00.624593] pci_bus 0003:00: root bus re=
source [bus 00]<br>[ =C2=A0 =C2=A00.628501] pci_bus 0003:00: busn_res: [bus=
 00] end is updated to ff<br>[ =C2=A0 =C2=A00.628519] pci 0003:00:00.0: [19=
57:0824] type 01 class 0x0b2000<br>[ =C2=A0 =C2=A00.628538] pci 0003:00:00.=
0: reg 0x10: [mem 0xff000000-0xffffffff]<br>[ =C2=A0 =C2=A00.628584] pci 00=
03:00:00.0: supports D1 D2<br>[ =C2=A0 =C2=A00.628588] pci 0003:00:00.0: PM=
E# supported from D0 D1 D2 D3hot D3cold<br>[ =C2=A0 =C2=A00.628703] iommu: =
Removing device ffe270000.pcie from group 22<br>[ =C2=A0 =C2=A00.633257] io=
mmu: Adding device 0003:00:00.0 to group 21<br>[ =C2=A0 =C2=A00.639362] pci=
 0003:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring<br=
><div>Dmesg messages from linux about amdgpu:<br></div><div>[5.866162] [drm=
] amdgpu kernel modesetting enabled.=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </div>[5.870293]
 [drm] initializing kernel modesetting (POLARIS12 0x1002:0x6987=20
0x1787:0x2389 0x80). =C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=C2=A0 <br>[5.877719] amdgpu 0001:01:00.0: Fatal error dur=
ing GPU init =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>[5.882363] amdg=
pu: probe of 0001:01:00.0 failed with error -12[ =C2=A0 =C2=A00.648066] pci=
 0003:00:00.0: PCI bridge to [bus 01-ff]<br>[ =C2=A0 =C2=A00.651912] pci 00=
03:00:00.0: =C2=A0 bridge window [io =C2=A00x8000080000043000-0x80000800000=
43fff]<br>[ =C2=A0 =C2=A00.651917] pci 0003:00:00.0: =C2=A0 bridge window [=
mem 0x00000000-0x000fffff]<br>[ =C2=A0 =C2=A00.651923] pci 0003:00:00.0: =
=C2=A0 bridge window [mem 0x00000000-0x000fffff 64bit pref]<br>[ =C2=A0 =C2=
=A00.651936] pci_bus 0003:01: busn_res: [bus 01-ff] end is updated to 01<br=
>[ =C2=A0 =C2=A00.651942] pci_bus 0003:00: busn_res: [bus 00-ff] end is upd=
ated to 01<br>[ =C2=A0 =C2=A00.651988] PCI: Cannot allocate resource region=
 0 of device 0000:00:00.0, will remap<br>[ =C2=A0 =C2=A00.658435] PCI: Cann=
ot allocate resource region 0 of device 0001:00:00.0, will remap<br>[ =C2=
=A0 =C2=A00.664953] PCI: Cannot allocate resource region 2 of device 0001:0=
1:00.0, will remap<br>[ =C2=A0 =C2=A00.671469] PCI: Cannot allocate resourc=
e region 5 of device 0001:01:00.0, will remap<br>[ =C2=A0 =C2=A00.677989] P=
CI: Cannot allocate resource region 6 of device 0001:01:00.0, will remap<br=
>[ =C2=A0 =C2=A00.684514] PCI: Cannot allocate resource region 0 of device =
0001:01:00.1, will remap<br>[ =C2=A0 =C2=A00.691033] PCI: Cannot allocate r=
esource region 0 of device 0002:00:00.0, will remap<br>[ =C2=A0 =C2=A00.697=
552] PCI: Cannot allocate resource region 0 of device 0003:00:00.0, will re=
map<br>[ =C2=A0 =C2=A00.704083] PCI 0000:00 Cannot reserve Legacy IO [io =
=C2=A00x8000080000010000-0x10fff]<br>[ =C2=A0 =C2=A00.704086] PCI 0001:00 C=
annot reserve Legacy IO [io =C2=A00x8000080000021000-0x21fff]<br>[ =C2=A0 =
=C2=A00.704089] PCI 0002:00 Cannot reserve Legacy IO [io =C2=A00x8000080000=
032000-0x32fff]<br>[ =C2=A0 =C2=A00.704092] PCI 0003:00 Cannot reserve Lega=
cy IO [io =C2=A00x8000080000043000-0x43fff]<br>[ =C2=A0 =C2=A00.704107] pci=
 0000:00:00.0: BAR 0: no space for [mem size 0x01000000]<br>[ =C2=A0 =C2=A0=
0.709375] pci 0000:00:00.0: BAR 0: failed to assign [mem size 0x01000000]<b=
r>[ =C2=A0 =C2=A00.715026] pci 0000:00:00.0: PCI bridge to [bus 01]<br>[ =
=C2=A0 =C2=A00.718673] pci 0000:00:00.0: =C2=A0 bridge window [io =C2=A00x8=
000080000010000-0x800008000001ffff]<br>[ =C2=A0 =C2=A00.725545] pci 0000:00=
:00.0: =C2=A0 bridge window [mem 0xc00000000-0xc0fffffff]<br>[ =C2=A0 =C2=
=A00.731196] pci_bus 0000:00: Some PCI device resources are unassigned, try=
 booting with pci=3Drealloc<br>[ =C2=A0 =C2=A00.738932] pci_bus 0000:00: re=
source 4 [io =C2=A00x8000080000010000-0x800008000001ffff]<br>[ =C2=A0 =C2=
=A00.738935] pci_bus 0000:00: resource 5 [mem 0xc00000000-0xc0fffffff]<br>[=
 =C2=A0 =C2=A00.738939] pci_bus 0000:01: resource 0 [io =C2=A00x80000800000=
10000-0x800008000001ffff]<br>[ =C2=A0 =C2=A00.738942] pci_bus 0000:01: reso=
urce 1 [mem 0xc00000000-0xc0fffffff]<br>[ =C2=A0 =C2=A00.738953] pci 0001:0=
0:00.0: BAR 0: no space for [mem size 0x01000000]<br>[ =C2=A0 =C2=A00.74423=
5] pci 0001:00:00.0: BAR 0: failed to assign [mem size 0x01000000]<br>[ =C2=
=A0 =C2=A00.749887] pci 0001:00:00.0: BAR 9: no space for [mem size 0x00200=
000 64bit pref]<br>[ =C2=A0 =C2=A00.756144] pci 0001:00:00.0: BAR 9: failed=
 to assign [mem size 0x00200000 64bit pref]<br>[ =C2=A0 =C2=A00.762754] pci=
 0001:01:00.0: BAR 2: no space for [mem size 0x00200000 64bit pref]<br>[ =
=C2=A0 =C2=A00.769010] pci 0001:01:00.0: BAR 2: failed to assign [mem size =
0x00200000 64bit pref]<br>[ =C2=A0 =C2=A00.775617] pci 0001:01:00.0: BAR 5:=
 no space for [mem size 0x00040000]<br>[ =C2=A0 =C2=A00.780920] pci 0001:01=
:00.0: BAR 5: failed to assign [mem size 0x00040000]<br>[ =C2=A0 =C2=A00.78=
6571] pci 0001:01:00.0: BAR 6: no space for [mem size 0x00020000 pref]<br>[=
 =C2=A0 =C2=A00.792308] pci 0001:01:00.0: BAR 6: failed to assign [mem size=
 0x00020000 pref]<br>[ =C2=A0 =C2=A00.798394] pci 0001:01:00.1: BAR 0: no s=
pace for [mem size 0x00004000 64bit]<br>[ =C2=A0 =C2=A00.804218] pci 0001:0=
1:00.1: BAR 0: failed to assign [mem size 0x00004000 64bit]<br>[ =C2=A0 =C2=
=A00.810391] pci 0001:00:00.0: PCI bridge to [bus 01]<br>[ =C2=A0 =C2=A00.8=
14038] pci 0001:00:00.0: =C2=A0 bridge window [io =C2=A00x8000080000021000-=
0x8000080000030fff]<br>[ =C2=A0 =C2=A00.820910] pci 0001:00:00.0: =C2=A0 br=
idge window [mem 0xc10000000-0xc1fffffff]<br>[ =C2=A0 =C2=A00.826561] pci_b=
us 0001:00: Some PCI device resources are unassigned, try booting with pci=
=3Drealloc<br>[ =C2=A0 =C2=A00.834298] pci_bus 0001:00: resource 4 [io =C2=
=A00x8000080000021000-0x8000080000030fff]<br>[ =C2=A0 =C2=A00.834301] pci_b=
us 0001:00: resource 5 [mem 0xc10000000-0xc1fffffff]<br>[ =C2=A0 =C2=A00.83=
4305] pci_bus 0001:01: resource 0 [io =C2=A00x8000080000021000-0x8000080000=
030fff]<br>[ =C2=A0 =C2=A00.834308] pci_bus 0001:01: resource 1 [mem 0xc100=
00000-0xc1fffffff]<br>[ =C2=A0 =C2=A00.834318] pci 0002:00:00.0: BAR 0: no =
space for [mem size 0x01000000]<br>[ =C2=A0 =C2=A00.839600] pci 0002:00:00.=
0: BAR 0: failed to assign [mem size 0x01000000]<br>[ =C2=A0 =C2=A00.845251=
] pci 0002:00:00.0: PCI bridge to [bus 01]<br>[ =C2=A0 =C2=A00.848898] pci =
0002:00:00.0: =C2=A0 bridge window [io =C2=A00x8000080000032000-0x800008000=
0041fff]<br>[ =C2=A0 =C2=A00.855780] pci 0002:00:00.0: =C2=A0 bridge window=
 [mem 0xc20000000-0xc2fffffff]<br>[ =C2=A0 =C2=A00.861422] pci_bus 0002:00:=
 Some PCI device resources are unassigned, try booting with pci=3Drealloc<b=
r>[ =C2=A0 =C2=A00.869158] pci_bus 0002:00: resource 4 [io =C2=A00x80000800=
00032000-0x8000080000041fff]<br>[ =C2=A0 =C2=A00.869161] pci_bus 0002:00: r=
esource 5 [mem 0xc20000000-0xc2fffffff]<br>[ =C2=A0 =C2=A00.869165] pci_bus=
 0002:01: resource 0 [io =C2=A00x8000080000032000-0x8000080000041fff]<br>[ =
=C2=A0 =C2=A00.869168] pci_bus 0002:01: resource 1 [mem 0xc20000000-0xc2fff=
ffff]<br>[ =C2=A0 =C2=A00.869178] pci 0003:00:00.0: BAR 0: no space for [me=
m size 0x01000000]<br>[ =C2=A0 =C2=A00.874468] pci 0003:00:00.0: BAR 0: fai=
led to assign [mem size 0x01000000]<br>[ =C2=A0 =C2=A00.880112] pci 0003:00=
:00.0: PCI bridge to [bus 01]<br>[ =C2=A0 =C2=A00.883759] pci 0003:00:00.0:=
 =C2=A0 bridge window [io =C2=A00x8000080000043000-0x8000080000052fff]<br>[=
 =C2=A0 =C2=A00.890632] pci 0003:00:00.0: =C2=A0 bridge window [mem 0xc3000=
0000-0xc3fffffff]<br>[ =C2=A0 =C2=A00.896284] pci_bus 0003:00: Some PCI dev=
ice resources are unassigned, try booting with pci=3Drealloc<br>[ =C2=A0 =
=C2=A00.904018] pci_bus 0003:00: resource 4 [io =C2=A00x8000080000043000-0x=
8000080000052fff]<br>[ =C2=A0 =C2=A00.904022] pci_bus 0003:00: resource 5 [=
mem 0xc30000000-0xc3fffffff]<br>[ =C2=A0 =C2=A00.904025] pci_bus 0003:01: r=
esource 0 [io =C2=A00x8000080000043000-0x8000080000052fff]<br>[ =C2=A0 =C2=
=A00.904028] pci_bus 0003:01: resource 1 [mem 0xc30000000-0xc3fffffff]<br>[=
 =C2=A0 =C2=A00.904030] PCI: Probing PCI hardware done</div></div><div><br>=
</div><div><br></div><div><br></div><div><font size=3D"4"><span style=3D"fo=
nt-family:tahoma,sans-serif"><span style=3D"color:rgb(0,0,0)">PCI console m=
essages from U-BOOT</span></span></font></div><div><br></div><div><br></div=
><div>PCI: Probing PCI hardware<br>fsl-pci ffe240000.pcie: PCI host bridge =
to bus 0000:00<br>pci_bus 0000:00: root bus resource [io =C2=A00x8000080000=
010000-0x800008000001ffff] (bus address [0x0000-0xffff])<br>pci_bus 0000:00=
: root bus resource [mem 0xc00000000-0xc0fffffff] (bus address [0xe0000000-=
0xefffffff])<br>pci_bus 0000:00: root bus resource [bus 00]<br>iommu: Remov=
ing device ffe240000.pcie from group 19<br>iommu: Adding device 0000:00:00.=
0 to group 24<br>pci 0000:00:00.0: bridge configuration invalid ([bus 00-00=
]), reconfiguring<br>pci 0000:00:00.0: PCI bridge to [bus 01-ff]<br>fsl-pci=
 ffe250000.pcie: PCI host bridge to bus 0001:00<br>pci_bus 0001:00: root bu=
s resource [io =C2=A00x8000080000021000-0x8000080000030fff] (bus address [0=
x0000-0xffff])<br>pci_bus 0001:00: root bus resource [mem 0xc10000000-0xc1f=
ffffff] (bus address [0xe0000000-0xefffffff])<br>pci_bus 0001:00: root bus =
resource [bus 00-01]<br>iommu: Removing device ffe250000.pcie from group 20=
<br>iommu: Adding device 0001:00:00.0 to group 19<br>pci 0001:01:00.0: enab=
ling Extended Tags<br>pci 0001:01:00.0: 4.000 Gb/s available PCIe bandwidth=
, limited by 5 GT/s x1 link at 0001:00:00.0 (capable of 63.008 Gb/s with 8 =
GT/s x8 link)<br>iommu: Adding device 0001:01:00.0 to group 19<br>pci 0001:=
01:00.1: enabling Extended Tags<br>iommu: Adding device 0001:01:00.1 to gro=
up 19<br>pci 0001:00:00.0: PCI bridge to [bus 01-ff]<br>fsl-pci ffe260000.p=
cie: PCI host bridge to bus 0002:00<br>pci_bus 0002:00: root bus resource [=
io =C2=A00x8000080000032000-0x8000080000041fff] (bus address [0x0000-0xffff=
])<br>pci_bus 0002:00: root bus resource [mem 0xc20000000-0xc2fffffff] (bus=
 address [0xe0000000-0xefffffff])<br>pci_bus 0002:00: root bus resource [bu=
s 00]<br>iommu: Removing device ffe260000.pcie from group 21<br>iommu: Addi=
ng device 0002:00:00.0 to group 20<br>pci 0002:00:00.0: bridge configuratio=
n invalid ([bus 00-00]), reconfiguring<br>pci 0002:00:00.0: PCI bridge to [=
bus 01-ff]<br>fsl-pci ffe270000.pcie: PCI host bridge to bus 0003:00<br>pci=
_bus 0003:00: root bus resource [io =C2=A00x8000080000043000-0x800008000005=
2fff] (bus address [0x0000-0xffff])<br>pci_bus 0003:00: root bus resource [=
mem 0xc30000000-0xc3fffffff] (bus address [0xe0000000-0xefffffff])<br>pci_b=
us 0003:00: root bus resource [bus 00]<br>iommu: Removing device ffe270000.=
pcie from group 22<br>iommu: Adding device 0003:00:00.0 to group 21<br>pci =
0003:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring<br>=
pci 0003:00:00.0: PCI bridge to [bus 01-ff]<br>PCI: Cannot allocate resourc=
e region 0 of device 0000:00:00.0, will remap<br>PCI: Cannot allocate resou=
rce region 0 of device 0001:00:00.0, will remap<br>PCI: Cannot allocate res=
ource region 2 of device 0001:01:00.0, will remap<br>PCI: Cannot allocate r=
esource region 5 of device 0001:01:00.0, will remap<br>PCI: Cannot allocate=
 resource region 6 of device 0001:01:00.0, will remap<br>PCI: Cannot alloca=
te resource region 0 of device 0001:01:00.1, will remap<br>PCI: Cannot allo=
cate resource region 0 of device 0002:00:00.0, will remap<br>PCI: Cannot al=
locate resource region 0 of device 0003:00:00.0, will remap<br>pci 0000:00:=
00.0: BAR 0: no space for [mem size 0x01000000]<br>pci 0000:00:00.0: BAR 0:=
 failed to assign [mem size 0x01000000]<br>pci 0000:00:00.0: PCI bridge to =
[bus 01]<br>pci 0000:00:00.0: =C2=A0 bridge window [io =C2=A00x800008000001=
0000-0x800008000001ffff]<br>pci 0000:00:00.0: =C2=A0 bridge window [mem 0xc=
00000000-0xc0fffffff]<br>pci_bus 0000:00: Some PCI device resources are una=
ssigned, try booting with pci=3Drealloc<br>pci 0001:00:00.0: BAR 0: no spac=
e for [mem size 0x01000000]<br>pci 0001:00:00.0: BAR 0: failed to assign [m=
em size 0x01000000]<br>pci 0001:00:00.0: BAR 9: no space for [mem size 0x00=
200000 64bit pref]<br>pci 0001:00:00.0: BAR 9: failed to assign [mem size 0=
x00200000 64bit pref]<br>pci 0001:01:00.0: BAR 2: no space for [mem size 0x=
00200000 64bit pref]<br>pci 0001:01:00.0: BAR 2: failed to assign [mem size=
 0x00200000 64bit pref]<br>pci 0001:01:00.0: BAR 5: no space for [mem size =
0x00040000]<br>pci 0001:01:00.0: BAR 5: failed to assign [mem size 0x000400=
00]<br>pci 0001:01:00.0: BAR 6: no space for [mem size 0x00020000 pref]<br>=
pci 0001:01:00.0: BAR 6: failed to assign [mem size 0x00020000 pref]<br>pci=
 0001:01:00.1: BAR 0: no space for [mem size 0x00004000 64bit]<br>pci 0001:=
01:00.1: BAR 0: failed to assign [mem size 0x00004000 64bit]<br>pci 0001:00=
:00.0: PCI bridge to [bus 01]<br>pci 0001:00:00.0: =C2=A0 bridge window [io=
 =C2=A00x8000080000021000-0x8000080000030fff]<br>pci 0001:00:00.0: =C2=A0 b=
ridge window [mem 0xc10000000-0xc1fffffff]<br>pci_bus 0001:00: Some PCI dev=
ice resources are unassigned, try booting with pci=3Drealloc<br>pci 0002:00=
:00.0: BAR 0: no space for [mem size 0x01000000]<br>pci 0002:00:00.0: BAR 0=
: failed to assign [mem size 0x01000000]<br>pci 0002:00:00.0: PCI bridge to=
 [bus 01]<br>pci 0002:00:00.0: =C2=A0 bridge window [io =C2=A00x80000800000=
32000-0x8000080000041fff]<br>pci 0002:00:00.0: =C2=A0 bridge window [mem 0x=
c20000000-0xc2fffffff]<br>pci_bus 0002:00: Some PCI device resources are un=
assigned, try booting with pci=3Drealloc<br>pci 0003:00:00.0: BAR 0: no spa=
ce for [mem size 0x01000000]<br>pci 0003:00:00.0: BAR 0: failed to assign [=
mem size 0x01000000]<br>pci 0003:00:00.0: PCI bridge to [bus 01]<br>pci 000=
3:00:00.0: =C2=A0 bridge window [io =C2=A00x8000080000043000-0x800008000005=
2fff]<br>pci 0003:00:00.0: =C2=A0 bridge window [mem 0xc30000000-0xc3ffffff=
f]<br>pci_bus 0003:00: Some PCI device resources are unassigned, try bootin=
g with pci=3Drealloc</div><div><br></div><div><br></div><div><br></div><div=
><br></div></div>

--000000000000565e8b05982c1ce5--

--===============0635624013==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0635624013==--
