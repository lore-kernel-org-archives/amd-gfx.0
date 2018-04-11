From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: Lenovo ThinkVision X1 27" USB-C occasionally hangs the kernel
 (usbhid) and isn't setting a proper resolution when USB 3.0 (FHD) switched
 to USB 2.0 (UHD)
Date: Wed, 11 Apr 2018 14:09:29 +0300
Message-ID: <20180411110929.GC7517@kuha.fi.intel.com>
References: <20180410143550.GA12209@kuha.fi.intel.com>
 <21a20e4a29601710a2b07473111b7a47@nixaid.com>
 <361c906361dc1746526a66f5921fdaae@nixaid.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Nq2Wo0NMKNjxTN9z"
Content-Transfer-Encoding: 8bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <361c906361dc1746526a66f5921fdaae@nixaid.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: andrey.arapov@nixaid.comm, Alex Deucher <alexander.deucher@amd.com>, Christian =?unknown-8bit?B?S8O2bmln?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>
Cc: linux-usb@vger.kernel.org, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 11, 2018 at 08:28:44AM +0000, andrey.arapov@nixaid.com wrote:
> Thank you for the insights, Heikki!
> 
> Please find the acpi.dump.tgz file is a attached.
> 
> I do not have the USBC* and INT3515* devices,

OK. That means we don't have any way to interface with the USB Type-C
ports directly unfortunately. The ports are quite simply not visible
to us. We can't do anything from USB side.

The problem is in any case a graphics problem, so maybe it's better to
let those guys take a look at this. I think this MacBook Pro has AMD
GPU, so adding AMD driver maintainers and lists.


> so I have attached the following file as well:
> 
> # ls -1 /sys/bus/acpi/devices/*/status | while read dev; do echo $dev: $(cat $dev); done | gzip -c > /tmp/all-device-status.log.gz
> 
> 
> KR,
> Andrey Arapov
> 
> April 10, 2018 4:35 PM, "Heikki Krogerus" <heikki.krogerus@linux.intel.com> wrote:
> 
> > On Tue, Apr 10, 2018 at 09:05:07AM +0000, andrey.arapov@nixaid.com wrote:
> > 
> >> Dear Linux Kernel Devs,
> >> 
> >> I have recently got a Lenovo ThinkVision X1 27" monitor, it is connected to my
> >> laptop over a USB-C cable (DisplayPort).
> >> 
> >> This monitor has a built-in USB hub with a toggle button, when pressed it
> >> shows two options on the screen:
> >> 
> >> Press USB Switch to toggle between:
> >> A) 3840x2160 UHD USB 2.0
> >> B) 1920x1080 FHD USB 3.0
> >> 
> >> By default it is always set to FHD, which is why Linux sees the 1920x1080 as a
> >> maximum possible resolution.
> >> 
> >> Whenever I am changing it to the UHD, Linux is not changing the resolution to
> >> 3840x2160, instead it sets to somewhere around 2560x####.
> >> 
> >> To work this around, I am running the following commands manually:
> >> 
> >> xrandr --newmode "3840x2160_60.00" 533.25 3840 3888 3920 4000 2160 2163 2168 2222 +hsync -vsync
> >> xrandr --addmode DisplayPort-2 3840x2160_60.00
> >> xrandr --output DisplayPort-2 --mode 3840x2160_60.00
> >> 
> >> Then, when I was trying to switch it back to FHD and again back to UHD,
> >> sometimes it causes a kernel panic. The panic also happened when I was
> >> plugging the cable in/out and back again. What I was able to spot is that the
> >> last unloaded kernel module was usbhid.
> >> 
> >> Please advise, what can I try to help investigating this issue further?
> >> 
> >> I have attached the output from "dmesg -T" command as "4.16.1-dmesg.txt" file.
> >> The logs are related to when the monitor was connected via a USB-C cable to a
> >> DisplayPort-2, the default resolution picked was FHD (USB 3.0) and then I have
> >> pressed the toggle button to use UHD (USB 2.0), then have applied the "xrandr"
> >> commands and have closed the lid of my laptop so I would be using my monitor
> >> as a primary display.
> > 
> > The board seems to support Thunderbold, however, in this case my guess is that
> > the monitor is actually using just the DP alternate mode (Thundebolt can pipe
> > DisplayPort protocol).
> > 
> > I'm guessing the problem is related to the DisplayPort lane counts. With the
> > highest resolutions you need all four lanes, but if you want to use USB3 with
> > USB Type-C connectors at the same time, two have to be allocated for USB3
> > leaving only two for DisplayPort allowing lower resolution. The problem is that
> > the GPU drivers need to know how many lanes the DisplayPort has in use. That
> > information will in normal case come from USB Type-C drivers. Unfortunately we
> > do not have support for that in Linux kernel yet, but I have made a proposal for
> > a solution.
> > 
> > Let's start by checking details of your board. Can you send us acpidump output?
> > 
> > % acpidump -o <filename>
> > 
> > Also, please check the status of these acpi devices:
> > 
> > % cat /sys/bus/acpi/devices/USBC*/status
> > % cat /sys/bus/acpi/devices/INT3515*/status


Br,

-- 
heikki

--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: attachment; filename="4.16.1-dmesg.txt"
Content-Transfer-Encoding: 8bit

[Tue Apr 10 10:19:42 2018] Linux version 4.16.1-041601-generic (kernel@kathleen) (gcc version 7.2.0 (Ubuntu 7.2.0-8ubuntu3.2)) #201804081334 SMP Sun Apr 8 13:35:48 UTC 2018
[Tue Apr 10 10:19:42 2018] Command line: BOOT_IMAGE=/vmlinuz-4.16.1-041601-generic root=UUID=67afe78a-5a17-4fc7-b61f-9db64480d602 ro quiet splash vt.handoff=7
[Tue Apr 10 10:19:42 2018] KERNEL supported cpus:
[Tue Apr 10 10:19:42 2018]   Intel GenuineIntel
[Tue Apr 10 10:19:42 2018]   AMD AuthenticAMD
[Tue Apr 10 10:19:42 2018]   Centaur CentaurHauls
[Tue Apr 10 10:19:42 2018] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[Tue Apr 10 10:19:42 2018] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[Tue Apr 10 10:19:42 2018] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[Tue Apr 10 10:19:42 2018] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
[Tue Apr 10 10:19:42 2018] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[Tue Apr 10 10:19:42 2018] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[Tue Apr 10 10:19:42 2018] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[Tue Apr 10 10:19:42 2018] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[Tue Apr 10 10:19:42 2018] x86/fpu: Enabled xstate features 0x1f, context size is 960 bytes, using 'compacted' format.
[Tue Apr 10 10:19:42 2018] e820: BIOS-provided physical RAM map:
[Tue Apr 10 10:19:42 2018] BIOS-e820: [mem 0x0000000000000000-0x0000000000057fff] usable
[Tue Apr 10 10:19:42 2018] BIOS-e820: [mem 0x0000000000058000-0x0000000000058fff] reserved
[Tue Apr 10 10:19:42 2018] BIOS-e820: [mem 0x0000000000059000-0x000000000009dfff] usable
[Tue Apr 10 10:19:42 2018] BIOS-e820: [mem 0x000000000009e000-0x00000000000fffff] reserved
[Tue Apr 10 10:19:42 2018] BIOS-e820: [mem 0x0000000000100000-0x000000007401cfff] usable
[Tue Apr 10 10:19:42 2018] BIOS-e820: [mem 0x000000007401d000-0x000000007421efff] reserved
[Tue Apr 10 10:19:42 2018] BIOS-e820: [mem 0x000000007421f000-0x0000000074ca7fff] usable
[Tue Apr 10 10:19:42 2018] BIOS-e820: [mem 0x0000000074ca8000-0x0000000074ca8fff] ACPI NVS
[Tue Apr 10 10:19:42 2018] BIOS-e820: [mem 0x0000000074ca9000-0x0000000074ca9fff] reserved
[Tue Apr 10 10:19:42 2018] BIOS-e820: [mem 0x0000000074caa000-0x0000000074f4dfff] usable
[Tue Apr 10 10:19:42 2018] BIOS-e820: [mem 0x0000000074f4e000-0x0000000074f4efff] reserved
[Tue Apr 10 10:19:42 2018] BIOS-e820: [mem 0x0000000074f4f000-0x000000007ab9efff] usable
[Tue Apr 10 10:19:42 2018] BIOS-e820: [mem 0x000000007ab9f000-0x000000007ac0efff] type 20
[Tue Apr 10 10:19:42 2018] BIOS-e820: [mem 0x000000007ac0f000-0x000000007af2efff] reserved
[Tue Apr 10 10:19:42 2018] BIOS-e820: [mem 0x000000007af2f000-0x000000007af7efff] ACPI NVS
[Tue Apr 10 10:19:42 2018] BIOS-e820: [mem 0x000000007af7f000-0x000000007affefff] ACPI data
[Tue Apr 10 10:19:42 2018] BIOS-e820: [mem 0x000000007afff000-0x000000007affffff] usable
[Tue Apr 10 10:19:42 2018] BIOS-e820: [mem 0x000000007b000000-0x000000007fffffff] reserved
[Tue Apr 10 10:19:42 2018] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
[Tue Apr 10 10:19:42 2018] BIOS-e820: [mem 0x00000000fe010000-0x00000000fe010fff] reserved
[Tue Apr 10 10:19:42 2018] BIOS-e820: [mem 0x00000000ff939000-0x00000000ff968fff] reserved
[Tue Apr 10 10:19:42 2018] BIOS-e820: [mem 0x0000000100000000-0x000000047effffff] usable
[Tue Apr 10 10:19:42 2018] NX (Execute Disable) protection: active
[Tue Apr 10 10:19:42 2018] efi: EFI v2.40 by Apple
[Tue Apr 10 10:19:42 2018] efi:  ACPI=0x7affe000  ACPI 2.0=0x7affe014  SMBIOS=0x7aee0000  SMBIOS 3.0=0x7aede000 
[Tue Apr 10 10:19:42 2018] random: fast init done
[Tue Apr 10 10:19:42 2018] SMBIOS 3.0.0 present.
[Tue Apr 10 10:19:42 2018] DMI: Apple Inc. MacBookPro14,3/Mac-551B86E5744E2388, BIOS MBP143.88Z.0173.B00.1802080917 02/08/2018
[Tue Apr 10 10:19:42 2018] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[Tue Apr 10 10:19:42 2018] e820: remove [mem 0x000a0000-0x000fffff] usable
[Tue Apr 10 10:19:42 2018] e820: last_pfn = 0x47f000 max_arch_pfn = 0x400000000
[Tue Apr 10 10:19:42 2018] MTRR default type: write-back
[Tue Apr 10 10:19:42 2018] MTRR fixed ranges enabled:
[Tue Apr 10 10:19:42 2018]   00000-9FFFF write-back
[Tue Apr 10 10:19:42 2018]   A0000-FFFFF uncachable
[Tue Apr 10 10:19:42 2018] MTRR variable ranges enabled:
[Tue Apr 10 10:19:42 2018]   0 base 0080000000 mask 7F80000000 uncachable
[Tue Apr 10 10:19:42 2018]   1 base 007C000000 mask 7FFC000000 uncachable
[Tue Apr 10 10:19:42 2018]   2 base 007B000000 mask 7FFF000000 uncachable
[Tue Apr 10 10:19:42 2018]   3 base 4000000000 mask 4000000000 uncachable
[Tue Apr 10 10:19:42 2018]   4 disabled
[Tue Apr 10 10:19:42 2018]   5 disabled
[Tue Apr 10 10:19:42 2018]   6 disabled
[Tue Apr 10 10:19:42 2018]   7 disabled
[Tue Apr 10 10:19:42 2018]   8 disabled
[Tue Apr 10 10:19:42 2018]   9 disabled
[Tue Apr 10 10:19:42 2018] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[Tue Apr 10 10:19:42 2018] e820: last_pfn = 0x7b000 max_arch_pfn = 0x400000000
[Tue Apr 10 10:19:42 2018] Scanning 1 areas for low memory corruption
[Tue Apr 10 10:19:42 2018] Base memory trampoline at [        (ptrval)] 98000 size 24576
[Tue Apr 10 10:19:42 2018] Using GB pages for direct mapping
[Tue Apr 10 10:19:42 2018] BRK [0x24a940000, 0x24a940fff] PGTABLE
[Tue Apr 10 10:19:42 2018] BRK [0x24a941000, 0x24a941fff] PGTABLE
[Tue Apr 10 10:19:42 2018] BRK [0x24a942000, 0x24a942fff] PGTABLE
[Tue Apr 10 10:19:42 2018] BRK [0x24a943000, 0x24a943fff] PGTABLE
[Tue Apr 10 10:19:42 2018] BRK [0x24a944000, 0x24a944fff] PGTABLE
[Tue Apr 10 10:19:42 2018] BRK [0x24a945000, 0x24a945fff] PGTABLE
[Tue Apr 10 10:19:42 2018] BRK [0x24a946000, 0x24a946fff] PGTABLE
[Tue Apr 10 10:19:42 2018] BRK [0x24a947000, 0x24a947fff] PGTABLE
[Tue Apr 10 10:19:42 2018] BRK [0x24a948000, 0x24a948fff] PGTABLE
[Tue Apr 10 10:19:42 2018] BRK [0x24a949000, 0x24a949fff] PGTABLE
[Tue Apr 10 10:19:42 2018] BRK [0x24a94a000, 0x24a94afff] PGTABLE
[Tue Apr 10 10:19:42 2018] BRK [0x24a94b000, 0x24a94bfff] PGTABLE
[Tue Apr 10 10:19:42 2018] Secure boot could not be determined
[Tue Apr 10 10:19:42 2018] RAMDISK: [mem 0x31d2c000-0x34e8dfff]
[Tue Apr 10 10:19:42 2018] ACPI: Early table checksum verification disabled
[Tue Apr 10 10:19:42 2018] ACPI: RSDP 0x000000007AFFE014 000024 (v02 APPLE )
[Tue Apr 10 10:19:42 2018] ACPI: XSDT 0x000000007AFC6188 0000D4 (v01 APPLE  Apple00  00000000      01000013)
[Tue Apr 10 10:19:42 2018] ACPI: FACP 0x000000007AFF8000 0000F4 (v05 APPLE  Apple00  00000000 Loki 0000005F)
[Tue Apr 10 10:19:42 2018] ACPI: DSDT 0x000000007AFEB000 008764 (v02 APPLE  MacBookP 00140003 INTL 20140424)
[Tue Apr 10 10:19:42 2018] ACPI: FACS 0x000000007AF7C000 000040
[Tue Apr 10 10:19:42 2018] ACPI: UEFI 0x000000007AF7D000 000042 (v01 INTEL  EDK2     00000002      01000013)
[Tue Apr 10 10:19:42 2018] ACPI: ECDT 0x000000007AFFA000 000053 (v01 APPLE  Apple00  00000001 Loki 0000005F)
[Tue Apr 10 10:19:42 2018] ACPI: HPET 0x000000007AFF7000 000038 (v01 APPLE  Apple00  00000001 Loki 0000005F)
[Tue Apr 10 10:19:42 2018] ACPI: APIC 0x000000007AFF6000 0000BC (v02 APPLE  Apple00  00000001 Loki 0000005F)
[Tue Apr 10 10:19:42 2018] ACPI: MCFG 0x000000007AFF5000 00003C (v01 APPLE  Apple00  00000001 Loki 0000005F)
[Tue Apr 10 10:19:42 2018] ACPI: SBST 0x000000007AFF4000 000030 (v01 APPLE  Apple00  00000001 Loki 0000005F)
[Tue Apr 10 10:19:42 2018] ACPI: SSDT 0x000000007AFEA000 000024 (v01 APPLE  SmcDppt  00001000 INTL 20140424)
[Tue Apr 10 10:19:42 2018] ACPI: SSDT 0x000000007AFE9000 0007FD (v02 APPLE  PEG0GFX0 00001000 INTL 20140424)
[Tue Apr 10 10:19:42 2018] ACPI: SSDT 0x000000007AFE8000 000024 (v01 APPLE  PEG0SSD0 00001000 INTL 20140424)
[Tue Apr 10 10:19:42 2018] ACPI: SSDT 0x000000007AFE5000 000031 (v01 APPLE  SsdtS3   00001000 INTL 20140424)
[Tue Apr 10 10:19:42 2018] ACPI: SSDT 0x000000007AFE4000 0000DD (v01 APPLE  SataAhci 00001000 INTL 20140424)
[Tue Apr 10 10:19:42 2018] ACPI: SSDT 0x000000007AFE3000 0000B8 (v01 APPLE  Sdxc     00001000 INTL 20140424)
[Tue Apr 10 10:19:42 2018] ACPI: SSDT 0x000000007AFCE000 009C80 (v02 APPLE  TbtPEG12 00001000 INTL 20140424)
[Tue Apr 10 10:19:42 2018] ACPI: SSDT 0x000000007AFCD000 000FFC (v02 APPLE  Xhci     00001000 INTL 20140424)
[Tue Apr 10 10:19:42 2018] ACPI: SSDT 0x000000007AFCC000 000612 (v02 PmRef  Cpu0Ist  00003000 INTL 20140424)
[Tue Apr 10 10:19:42 2018] ACPI: SSDT 0x000000007AFCB000 0005AA (v02 PmRef  ApIst    00003000 INTL 20140424)
[Tue Apr 10 10:19:42 2018] ACPI: SSDT 0x000000007AFCA000 000295 (v02 PmRef  Cpu0Cst  00003001 INTL 20140424)
[Tue Apr 10 10:19:42 2018] ACPI: SSDT 0x000000007AFC9000 000119 (v02 PmRef  ApCst    00003000 INTL 20140424)
[Tue Apr 10 10:19:42 2018] ACPI: SSDT 0x000000007AFC8000 000F16 (v02 CpuRef CpuSsdt  00003000 INTL 20140424)
[Tue Apr 10 10:19:42 2018] ACPI: DMAR 0x000000007AFC7000 000160 (v01 APPLE  KBL      00000001 INTL 00000001)
[Tue Apr 10 10:19:42 2018] ACPI: VFCT 0x000000007AFB6000 00F284 (v01 APPLE  Apple00  00000001 AMD  31504F47)
[Tue Apr 10 10:19:42 2018] ACPI: DMI detected to setup _OSI("Darwin"): Apple hardware
[Tue Apr 10 10:19:42 2018] ACPI: Local APIC address 0xfee00000
[Tue Apr 10 10:19:42 2018] No NUMA configuration found
[Tue Apr 10 10:19:42 2018] Faking a node at [mem 0x0000000000000000-0x000000047effffff]
[Tue Apr 10 10:19:42 2018] NODE_DATA(0) allocated [mem 0x47efd5000-0x47effffff]
[Tue Apr 10 10:19:42 2018] Zone ranges:
[Tue Apr 10 10:19:42 2018]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[Tue Apr 10 10:19:42 2018]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[Tue Apr 10 10:19:42 2018]   Normal   [mem 0x0000000100000000-0x000000047effffff]
[Tue Apr 10 10:19:42 2018]   Device   empty
[Tue Apr 10 10:19:42 2018] Movable zone start for each node
[Tue Apr 10 10:19:42 2018] Early memory node ranges
[Tue Apr 10 10:19:42 2018]   node   0: [mem 0x0000000000001000-0x0000000000057fff]
[Tue Apr 10 10:19:42 2018]   node   0: [mem 0x0000000000059000-0x000000000009dfff]
[Tue Apr 10 10:19:42 2018]   node   0: [mem 0x0000000000100000-0x000000007401cfff]
[Tue Apr 10 10:19:42 2018]   node   0: [mem 0x000000007421f000-0x0000000074ca7fff]
[Tue Apr 10 10:19:42 2018]   node   0: [mem 0x0000000074caa000-0x0000000074f4dfff]
[Tue Apr 10 10:19:42 2018]   node   0: [mem 0x0000000074f4f000-0x000000007ab9efff]
[Tue Apr 10 10:19:42 2018]   node   0: [mem 0x000000007afff000-0x000000007affffff]
[Tue Apr 10 10:19:42 2018]   node   0: [mem 0x0000000100000000-0x000000047effffff]
[Tue Apr 10 10:19:42 2018] Initmem setup node 0 [mem 0x0000000000001000-0x000000047effffff]
[Tue Apr 10 10:19:42 2018] On node 0 totalpages: 4167991
[Tue Apr 10 10:19:42 2018]   DMA zone: 64 pages used for memmap
[Tue Apr 10 10:19:42 2018]   DMA zone: 22 pages reserved
[Tue Apr 10 10:19:42 2018]   DMA zone: 3996 pages, LIFO batch:0
[Tue Apr 10 10:19:42 2018]   DMA32 zone: 7783 pages used for memmap
[Tue Apr 10 10:19:42 2018]   DMA32 zone: 498075 pages, LIFO batch:31
[Tue Apr 10 10:19:42 2018]   Normal zone: 57280 pages used for memmap
[Tue Apr 10 10:19:42 2018]   Normal zone: 3665920 pages, LIFO batch:31
[Tue Apr 10 10:19:42 2018] Reserved but unavailable: 98 pages
[Tue Apr 10 10:19:42 2018] ACPI: PM-Timer IO Port: 0x1808
[Tue Apr 10 10:19:42 2018] ACPI: Local APIC address 0xfee00000
[Tue Apr 10 10:19:42 2018] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[Tue Apr 10 10:19:42 2018] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[Tue Apr 10 10:19:42 2018] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[Tue Apr 10 10:19:42 2018] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[Tue Apr 10 10:19:42 2018] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[Tue Apr 10 10:19:42 2018] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[Tue Apr 10 10:19:42 2018] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[Tue Apr 10 10:19:42 2018] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[Tue Apr 10 10:19:42 2018] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
[Tue Apr 10 10:19:42 2018] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[Tue Apr 10 10:19:42 2018] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[Tue Apr 10 10:19:42 2018] ACPI: IRQ0 used by override.
[Tue Apr 10 10:19:42 2018] ACPI: IRQ9 used by override.
[Tue Apr 10 10:19:42 2018] Using ACPI (MADT) for SMP configuration information
[Tue Apr 10 10:19:42 2018] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[Tue Apr 10 10:19:42 2018] smpboot: Allowing 8 CPUs, 0 hotplug CPUs
[Tue Apr 10 10:19:42 2018] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[Tue Apr 10 10:19:42 2018] PM: Registered nosave memory: [mem 0x00058000-0x00058fff]
[Tue Apr 10 10:19:42 2018] PM: Registered nosave memory: [mem 0x0009e000-0x000fffff]
[Tue Apr 10 10:19:42 2018] PM: Registered nosave memory: [mem 0x7401d000-0x7421efff]
[Tue Apr 10 10:19:42 2018] PM: Registered nosave memory: [mem 0x74ca8000-0x74ca8fff]
[Tue Apr 10 10:19:42 2018] PM: Registered nosave memory: [mem 0x74ca9000-0x74ca9fff]
[Tue Apr 10 10:19:42 2018] PM: Registered nosave memory: [mem 0x74f4e000-0x74f4efff]
[Tue Apr 10 10:19:42 2018] PM: Registered nosave memory: [mem 0x7ab9f000-0x7ac0efff]
[Tue Apr 10 10:19:42 2018] PM: Registered nosave memory: [mem 0x7ac0f000-0x7af2efff]
[Tue Apr 10 10:19:42 2018] PM: Registered nosave memory: [mem 0x7af2f000-0x7af7efff]
[Tue Apr 10 10:19:42 2018] PM: Registered nosave memory: [mem 0x7af7f000-0x7affefff]
[Tue Apr 10 10:19:42 2018] PM: Registered nosave memory: [mem 0x7b000000-0x7fffffff]
[Tue Apr 10 10:19:42 2018] PM: Registered nosave memory: [mem 0x80000000-0xdfffffff]
[Tue Apr 10 10:19:42 2018] PM: Registered nosave memory: [mem 0xe0000000-0xefffffff]
[Tue Apr 10 10:19:42 2018] PM: Registered nosave memory: [mem 0xf0000000-0xfe00ffff]
[Tue Apr 10 10:19:42 2018] PM: Registered nosave memory: [mem 0xfe010000-0xfe010fff]
[Tue Apr 10 10:19:42 2018] PM: Registered nosave memory: [mem 0xfe011000-0xff938fff]
[Tue Apr 10 10:19:42 2018] PM: Registered nosave memory: [mem 0xff939000-0xff968fff]
[Tue Apr 10 10:19:42 2018] PM: Registered nosave memory: [mem 0xff969000-0xffffffff]
[Tue Apr 10 10:19:42 2018] e820: [mem 0x80000000-0xdfffffff] available for PCI devices
[Tue Apr 10 10:19:42 2018] Booting paravirtualized kernel on bare hardware
[Tue Apr 10 10:19:42 2018] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[Tue Apr 10 10:19:42 2018] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:1
[Tue Apr 10 10:19:42 2018] percpu: Embedded 46 pages/cpu @        (ptrval) s151552 r8192 d28672 u262144
[Tue Apr 10 10:19:42 2018] pcpu-alloc: s151552 r8192 d28672 u262144 alloc=1*2097152
[Tue Apr 10 10:19:42 2018] pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
[Tue Apr 10 10:19:42 2018] Built 1 zonelists, mobility grouping on.  Total pages: 4102842
[Tue Apr 10 10:19:42 2018] Policy zone: Normal
[Tue Apr 10 10:19:42 2018] Kernel command line: BOOT_IMAGE=/vmlinuz-4.16.1-041601-generic root=UUID=67afe78a-5a17-4fc7-b61f-9db64480d602 ro quiet splash vt.handoff=7
[Tue Apr 10 10:19:42 2018] Calgary: detecting Calgary via BIOS EBDA area
[Tue Apr 10 10:19:42 2018] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[Tue Apr 10 10:19:42 2018] Memory: 16109616K/16671964K available (12300K kernel code, 2478K rwdata, 4244K rodata, 2404K init, 2416K bss, 562348K reserved, 0K cma-reserved)
[Tue Apr 10 10:19:42 2018] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[Tue Apr 10 10:19:42 2018] Kernel/User page tables isolation: enabled
[Tue Apr 10 10:19:42 2018] ftrace: allocating 39348 entries in 154 pages
[Tue Apr 10 10:19:42 2018] Hierarchical RCU implementation.
[Tue Apr 10 10:19:42 2018] 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=8.
[Tue Apr 10 10:19:42 2018] 	Tasks RCU enabled.
[Tue Apr 10 10:19:42 2018] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
[Tue Apr 10 10:19:42 2018] NR_IRQS: 524544, nr_irqs: 488, preallocated irqs: 16
[Tue Apr 10 10:19:42 2018] Console: colour dummy device 80x25
[Tue Apr 10 10:19:42 2018] console [tty0] enabled
[Tue Apr 10 10:19:42 2018] ACPI: Core revision 20180105
[Tue Apr 10 10:19:42 2018] ACPI: 14 ACPI AML tables successfully acquired and loaded
[Tue Apr 10 10:19:42 2018] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635855245 ns
[Tue Apr 10 10:19:42 2018] hpet clockevent registered
[Tue Apr 10 10:19:42 2018] APIC: Switch to symmetric I/O mode setup
[Tue Apr 10 10:19:42 2018] DMAR: Host address width 39
[Tue Apr 10 10:19:42 2018] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[Tue Apr 10 10:19:42 2018] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1c0000c40660462 ecap 19e2ff0505e
[Tue Apr 10 10:19:42 2018] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[Tue Apr 10 10:19:42 2018] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c40660462 ecap f050da
[Tue Apr 10 10:19:42 2018] DMAR: RMRR base: 0x0000007b800000 end: 0x0000007fffffff
[Tue Apr 10 10:19:42 2018] DMAR: ANDD device: 1 name: \_SB.PCI0.I2C0
[Tue Apr 10 10:19:42 2018] DMAR: ANDD device: 7 name: \_SB.PCI0.SPI0
[Tue Apr 10 10:19:42 2018] DMAR: ANDD device: 8 name: \_SB.PCI0.SPI1
[Tue Apr 10 10:19:42 2018] DMAR: ANDD device: 9 name: \_SB.PCI0.UA00
[Tue Apr 10 10:19:42 2018] DMAR: ANDD device: a name: \_SB.PCI0.UA01
[Tue Apr 10 10:19:42 2018] DMAR: ANDD device: b name: \_SB.PCI0.UA02
[Tue Apr 10 10:19:42 2018] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[Tue Apr 10 10:19:42 2018] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[Tue Apr 10 10:19:42 2018] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
[Tue Apr 10 10:19:42 2018] DMAR-IR: Enabled IRQ remapping in x2apic mode
[Tue Apr 10 10:19:42 2018] x2apic enabled
[Tue Apr 10 10:19:42 2018] Switched APIC routing to cluster x2apic.
[Tue Apr 10 10:19:42 2018] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[Tue Apr 10 10:19:42 2018] tsc: Detected 2900.000 MHz processor
[Tue Apr 10 10:19:42 2018] tsc: Detected 2904.000 MHz TSC
[Tue Apr 10 10:19:42 2018] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x29dc05e54fc, max_idle_ns: 440795291716 ns
[Tue Apr 10 10:19:42 2018] Calibrating delay loop (skipped), value calculated using timer frequency.. 5808.00 BogoMIPS (lpj=11616000)
[Tue Apr 10 10:19:42 2018] pid_max: default: 32768 minimum: 301
[Tue Apr 10 10:19:42 2018] Security Framework initialized
[Tue Apr 10 10:19:42 2018] Yama: becoming mindful.
[Tue Apr 10 10:19:42 2018] AppArmor: AppArmor initialized
[Tue Apr 10 10:19:42 2018] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes)
[Tue Apr 10 10:19:42 2018] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[Tue Apr 10 10:19:42 2018] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes)
[Tue Apr 10 10:19:42 2018] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes)
[Tue Apr 10 10:19:42 2018] CPU: Physical Processor ID: 0
[Tue Apr 10 10:19:42 2018] CPU: Processor Core ID: 0
[Tue Apr 10 10:19:42 2018] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[Tue Apr 10 10:19:42 2018] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
[Tue Apr 10 10:19:42 2018] mce: CPU supports 10 MCE banks
[Tue Apr 10 10:19:42 2018] CPU0: Thermal monitoring enabled (TM1)
[Tue Apr 10 10:19:42 2018] process: using mwait in idle threads
[Tue Apr 10 10:19:42 2018] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
[Tue Apr 10 10:19:42 2018] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[Tue Apr 10 10:19:42 2018] Spectre V2 : Mitigation: Full generic retpoline
[Tue Apr 10 10:19:42 2018] Spectre V2 : Spectre v2 mitigation: Filling RSB on context switch
[Tue Apr 10 10:19:42 2018] Spectre V2 : Spectre v2 mitigation: Enabling Indirect Branch Prediction Barrier
[Tue Apr 10 10:19:42 2018] Spectre V2 : Enabling Restricted Speculation for firmware calls
[Tue Apr 10 10:19:42 2018] Freeing SMP alternatives memory: 36K
[Tue Apr 10 10:19:42 2018] TSC deadline timer enabled
[Tue Apr 10 10:19:42 2018] smpboot: CPU0: Intel(R) Core(TM) i7-7820HQ CPU @ 2.90GHz (family: 0x6, model: 0x9e, stepping: 0x9)
[Tue Apr 10 10:19:42 2018] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.
[Tue Apr 10 10:19:42 2018] ... version:                4
[Tue Apr 10 10:19:42 2018] ... bit width:              48
[Tue Apr 10 10:19:42 2018] ... generic registers:      4
[Tue Apr 10 10:19:42 2018] ... value mask:             0000ffffffffffff
[Tue Apr 10 10:19:42 2018] ... max period:             00007fffffffffff
[Tue Apr 10 10:19:42 2018] ... fixed-purpose events:   3
[Tue Apr 10 10:19:42 2018] ... event mask:             000000070000000f
[Tue Apr 10 10:19:42 2018] Hierarchical SRCU implementation.
[Tue Apr 10 10:19:42 2018] smp: Bringing up secondary CPUs ...
[Tue Apr 10 10:19:42 2018] x86: Booting SMP configuration:
[Tue Apr 10 10:19:42 2018] .... node  #0, CPUs:      #1
[Tue Apr 10 10:19:42 2018] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[Tue Apr 10 10:19:42 2018]  #2 #3 #4 #5 #6 #7
[Tue Apr 10 10:19:42 2018] smp: Brought up 1 node, 8 CPUs
[Tue Apr 10 10:19:42 2018] smpboot: Max logical packages: 1
[Tue Apr 10 10:19:42 2018] smpboot: Total of 8 processors activated (46464.00 BogoMIPS)
[Tue Apr 10 10:19:42 2018] devtmpfs: initialized
[Tue Apr 10 10:19:42 2018] x86/mm: Memory block size: 128MB
[Tue Apr 10 10:19:42 2018] evm: security.selinux
[Tue Apr 10 10:19:42 2018] evm: security.SMACK64
[Tue Apr 10 10:19:42 2018] evm: security.SMACK64EXEC
[Tue Apr 10 10:19:42 2018] evm: security.SMACK64TRANSMUTE
[Tue Apr 10 10:19:42 2018] evm: security.SMACK64MMAP
[Tue Apr 10 10:19:42 2018] evm: security.apparmor
[Tue Apr 10 10:19:42 2018] evm: security.ima
[Tue Apr 10 10:19:42 2018] evm: security.capability
[Tue Apr 10 10:19:42 2018] PM: Registering ACPI NVS region [mem 0x74ca8000-0x74ca8fff] (4096 bytes)
[Tue Apr 10 10:19:42 2018] PM: Registering ACPI NVS region [mem 0x7af2f000-0x7af7efff] (327680 bytes)
[Tue Apr 10 10:19:42 2018] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[Tue Apr 10 10:19:42 2018] futex hash table entries: 2048 (order: 5, 131072 bytes)
[Tue Apr 10 10:19:42 2018] pinctrl core: initialized pinctrl subsystem
[Tue Apr 10 10:19:42 2018] RTC time:  8:19:42, date: 04/10/18
[Tue Apr 10 10:19:42 2018] NET: Registered protocol family 16
[Tue Apr 10 10:19:42 2018] cpuidle: using governor ladder
[Tue Apr 10 10:19:42 2018] cpuidle: using governor menu
[Tue Apr 10 10:19:42 2018] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[Tue Apr 10 10:19:42 2018] ACPI: bus type PCI registered
[Tue Apr 10 10:19:42 2018] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[Tue Apr 10 10:19:42 2018] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[Tue Apr 10 10:19:42 2018] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
[Tue Apr 10 10:19:42 2018] PCI: Using configuration type 1 for base access
[Tue Apr 10 10:19:42 2018] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[Tue Apr 10 10:19:42 2018] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[Tue Apr 10 10:19:42 2018] ACPI: Disabled all _OSI OS vendors
[Tue Apr 10 10:19:42 2018] ACPI: Added _OSI(Module Device)
[Tue Apr 10 10:19:42 2018] ACPI: Added _OSI(Processor Device)
[Tue Apr 10 10:19:42 2018] ACPI: Added _OSI(3.0 _SCP Extensions)
[Tue Apr 10 10:19:42 2018] ACPI: Added _OSI(Processor Aggregator Device)
[Tue Apr 10 10:19:42 2018] ACPI: Added _OSI(Darwin)
[Tue Apr 10 10:19:42 2018] ACPI: EC: EC started
[Tue Apr 10 10:19:42 2018] ACPI: EC: interrupt blocked
[Tue Apr 10 10:19:42 2018] ACPI: \: Used as first EC
[Tue Apr 10 10:19:42 2018] ACPI: \: GPE=0x7, EC_CMD/EC_SC=0x66, EC_DATA=0x62
[Tue Apr 10 10:19:42 2018] ACPI: \: Used as boot ECDT EC to handle transactions
[Tue Apr 10 10:19:42 2018] ACPI: BIOS _OSI(Darwin) query honored via DMI
[Tue Apr 10 10:19:42 2018] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[Tue Apr 10 10:19:42 2018] ACPI: Dynamic OEM Table Load:
[Tue Apr 10 10:19:42 2018] ACPI Error: AE_NO_MEMORY, SSDT 0xFFFF9DDAABCCA800 Table is duplicated (20180105/tbdata-562)
[Tue Apr 10 10:19:42 2018] No Local Variables are initialized for Method [GCAP]
[Tue Apr 10 10:19:42 2018] Initialized Arguments for Method [GCAP]:  (1 arguments defined for method invocation)
[Tue Apr 10 10:19:42 2018]   Arg0:   000000008d353627 <Obj>           Buffer(8) 00 00 00 00 00 10 00 00
[Tue Apr 10 10:19:42 2018] ACPI Error: Method parse/execution failed \_PR.CPU0.GCAP, AE_ALREADY_EXISTS (20180105/psparse-550)
[Tue Apr 10 10:19:42 2018] ACPI Error: Method parse/execution failed \_PR.CPU0._OSC, AE_ALREADY_EXISTS (20180105/psparse-550)
[Tue Apr 10 10:19:42 2018] ACPI BIOS Error (bug): Failure looking up [\_SB.OSCP], AE_NOT_FOUND (20180105/psargs-364)
[Tue Apr 10 10:19:42 2018] No Local Variables are initialized for Method [GCAP]
[Tue Apr 10 10:19:42 2018] Initialized Arguments for Method [GCAP]:  (1 arguments defined for method invocation)
[Tue Apr 10 10:19:42 2018]   Arg0:   0000000090392e20 <Obj>           Buffer(8) 00 00 00 00 00 10 00 00
[Tue Apr 10 10:19:42 2018] ACPI Error: Method parse/execution failed \_PR.CPU1.GCAP, AE_NOT_FOUND (20180105/psparse-550)
[Tue Apr 10 10:19:42 2018] ACPI Error: Method parse/execution failed \_PR.CPU1._OSC, AE_NOT_FOUND (20180105/psparse-550)
[Tue Apr 10 10:19:42 2018] ACPI BIOS Error (bug): Failure looking up [\_SB.OSCP], AE_NOT_FOUND (20180105/psargs-364)
[Tue Apr 10 10:19:42 2018] No Local Variables are initialized for Method [GCAP]
[Tue Apr 10 10:19:42 2018] Initialized Arguments for Method [GCAP]:  (1 arguments defined for method invocation)
[Tue Apr 10 10:19:42 2018]   Arg0:   000000000ec77b59 <Obj>           Buffer(8) 00 00 00 00 00 10 00 00
[Tue Apr 10 10:19:42 2018] ACPI Error: Method parse/execution failed \_PR.CPU2.GCAP, AE_NOT_FOUND (20180105/psparse-550)
[Tue Apr 10 10:19:42 2018] ACPI Error: Method parse/execution failed \_PR.CPU2._OSC, AE_NOT_FOUND (20180105/psparse-550)
[Tue Apr 10 10:19:42 2018] ACPI BIOS Error (bug): Failure looking up [\_SB.OSCP], AE_NOT_FOUND (20180105/psargs-364)
[Tue Apr 10 10:19:42 2018] No Local Variables are initialized for Method [GCAP]
[Tue Apr 10 10:19:42 2018] Initialized Arguments for Method [GCAP]:  (1 arguments defined for method invocation)
[Tue Apr 10 10:19:42 2018]   Arg0:   000000009f2d9a0d <Obj>           Buffer(8) 00 00 00 00 00 10 00 00
[Tue Apr 10 10:19:42 2018] ACPI Error: Method parse/execution failed \_PR.CPU3.GCAP, AE_NOT_FOUND (20180105/psparse-550)
[Tue Apr 10 10:19:42 2018] ACPI Error: Method parse/execution failed \_PR.CPU3._OSC, AE_NOT_FOUND (20180105/psparse-550)
[Tue Apr 10 10:19:42 2018] ACPI BIOS Error (bug): Failure looking up [\_SB.OSCP], AE_NOT_FOUND (20180105/psargs-364)
[Tue Apr 10 10:19:42 2018] No Local Variables are initialized for Method [GCAP]
[Tue Apr 10 10:19:42 2018] Initialized Arguments for Method [GCAP]:  (1 arguments defined for method invocation)
[Tue Apr 10 10:19:42 2018]   Arg0:   00000000b3dff57a <Obj>           Buffer(8) 00 00 00 00 00 10 00 00
[Tue Apr 10 10:19:42 2018] ACPI Error: Method parse/execution failed \_PR.CPU4.GCAP, AE_NOT_FOUND (20180105/psparse-550)
[Tue Apr 10 10:19:42 2018] ACPI Error: Method parse/execution failed \_PR.CPU4._OSC, AE_NOT_FOUND (20180105/psparse-550)
[Tue Apr 10 10:19:42 2018] ACPI BIOS Error (bug): Failure looking up [\_SB.OSCP], AE_NOT_FOUND (20180105/psargs-364)
[Tue Apr 10 10:19:42 2018] No Local Variables are initialized for Method [GCAP]
[Tue Apr 10 10:19:42 2018] Initialized Arguments for Method [GCAP]:  (1 arguments defined for method invocation)
[Tue Apr 10 10:19:42 2018]   Arg0:   000000004a2898a9 <Obj>           Buffer(8) 00 00 00 00 00 10 00 00
[Tue Apr 10 10:19:42 2018] ACPI Error: Method parse/execution failed \_PR.CPU5.GCAP, AE_NOT_FOUND (20180105/psparse-550)
[Tue Apr 10 10:19:42 2018] ACPI Error: Method parse/execution failed \_PR.CPU5._OSC, AE_NOT_FOUND (20180105/psparse-550)
[Tue Apr 10 10:19:42 2018] ACPI BIOS Error (bug): Failure looking up [\_SB.OSCP], AE_NOT_FOUND (20180105/psargs-364)
[Tue Apr 10 10:19:42 2018] No Local Variables are initialized for Method [GCAP]
[Tue Apr 10 10:19:42 2018] Initialized Arguments for Method [GCAP]:  (1 arguments defined for method invocation)
[Tue Apr 10 10:19:42 2018]   Arg0:   00000000aa1ffd70 <Obj>           Buffer(8) 00 00 00 00 00 10 00 00
[Tue Apr 10 10:19:42 2018] ACPI Error: Method parse/execution failed \_PR.CPU6.GCAP, AE_NOT_FOUND (20180105/psparse-550)
[Tue Apr 10 10:19:42 2018] ACPI Error: Method parse/execution failed \_PR.CPU6._OSC, AE_NOT_FOUND (20180105/psparse-550)
[Tue Apr 10 10:19:42 2018] ACPI BIOS Error (bug): Failure looking up [\_SB.OSCP], AE_NOT_FOUND (20180105/psargs-364)
[Tue Apr 10 10:19:42 2018] No Local Variables are initialized for Method [GCAP]
[Tue Apr 10 10:19:42 2018] Initialized Arguments for Method [GCAP]:  (1 arguments defined for method invocation)
[Tue Apr 10 10:19:42 2018]   Arg0:   00000000cb1bb24c <Obj>           Buffer(8) 00 00 00 00 00 10 00 00
[Tue Apr 10 10:19:42 2018] ACPI Error: Method parse/execution failed \_PR.CPU7.GCAP, AE_NOT_FOUND (20180105/psparse-550)
[Tue Apr 10 10:19:42 2018] ACPI Error: Method parse/execution failed \_PR.CPU7._OSC, AE_NOT_FOUND (20180105/psparse-550)
[Tue Apr 10 10:19:42 2018] ACPI: Dynamic OEM Table Load:
[Tue Apr 10 10:19:42 2018] ACPI Error: AE_NO_MEMORY, SSDT 0xFFFF9DDAAB845C00 Table is duplicated (20180105/tbdata-562)
[Tue Apr 10 10:19:42 2018] No Local Variables are initialized for Method [GCAP]
[Tue Apr 10 10:19:42 2018] Initialized Arguments for Method [GCAP]:  (1 arguments defined for method invocation)
[Tue Apr 10 10:19:42 2018]   Arg0:   000000002a41cd8f <Obj>           Buffer(12) 02 00 00 00 BF 0B 00 00
[Tue Apr 10 10:19:42 2018] ACPI Error: Method parse/execution failed \_PR.CPU0.GCAP, AE_ALREADY_EXISTS (20180105/psparse-550)
[Tue Apr 10 10:19:42 2018] ACPI Error: Method parse/execution failed \_PR.CPU0._PDC, AE_ALREADY_EXISTS (20180105/psparse-550)
[Tue Apr 10 10:19:42 2018] ACPI: Dynamic OEM Table Load:
[Tue Apr 10 10:19:42 2018] ACPI Error: AE_NO_MEMORY, SSDT 0xFFFF9DDAABC7E000 Table is duplicated (20180105/tbdata-562)
[Tue Apr 10 10:19:42 2018] No Local Variables are initialized for Method [APPT]
[Tue Apr 10 10:19:42 2018] No Arguments are initialized for method [APPT]
[Tue Apr 10 10:19:42 2018] ACPI Error: Method parse/execution failed \_PR.CPU1.APPT, AE_ALREADY_EXISTS (20180105/psparse-550)
[Tue Apr 10 10:19:42 2018] ACPI Error: Method parse/execution failed \_PR.CPU1.GCAP, AE_ALREADY_EXISTS (20180105/psparse-550)
[Tue Apr 10 10:19:42 2018] ACPI Error: Method parse/execution failed \_PR.CPU1._PDC, AE_ALREADY_EXISTS (20180105/psparse-550)
[Tue Apr 10 10:19:42 2018] ACPI BIOS Error (bug): Failure looking up [\_SB.OSCP], AE_NOT_FOUND (20180105/psargs-364)
[Tue Apr 10 10:19:42 2018] No Local Variables are initialized for Method [GCAP]
[Tue Apr 10 10:19:42 2018] Initialized Arguments for Method [GCAP]:  (1 arguments defined for method invocation)
[Tue Apr 10 10:19:42 2018]   Arg0:   00000000b07768b1 <Obj>           Buffer(12) 02 00 00 00 BF 0B 00 00
[Tue Apr 10 10:19:42 2018] ACPI Error: Method parse/execution failed \_PR.CPU2.GCAP, AE_NOT_FOUND (20180105/psparse-550)
[Tue Apr 10 10:19:42 2018] ACPI Error: Method parse/execution failed \_PR.CPU2._PDC, AE_NOT_FOUND (20180105/psparse-550)
[Tue Apr 10 10:19:42 2018] ACPI BIOS Error (bug): Failure looking up [\_SB.OSCP], AE_NOT_FOUND (20180105/psargs-364)
[Tue Apr 10 10:19:42 2018] No Local Variables are initialized for Method [GCAP]
[Tue Apr 10 10:19:42 2018] Initialized Arguments for Method [GCAP]:  (1 arguments defined for method invocation)
[Tue Apr 10 10:19:42 2018]   Arg0:   0000000053c47763 <Obj>           Buffer(12) 02 00 00 00 BF 0B 00 00
[Tue Apr 10 10:19:42 2018] ACPI Error: Method parse/execution failed \_PR.CPU3.GCAP, AE_NOT_FOUND (20180105/psparse-550)
[Tue Apr 10 10:19:42 2018] ACPI Error: Method parse/execution failed \_PR.CPU3._PDC, AE_NOT_FOUND (20180105/psparse-550)
[Tue Apr 10 10:19:42 2018] ACPI BIOS Error (bug): Failure looking up [\_SB.OSCP], AE_NOT_FOUND (20180105/psargs-364)
[Tue Apr 10 10:19:42 2018] No Local Variables are initialized for Method [GCAP]
[Tue Apr 10 10:19:42 2018] Initialized Arguments for Method [GCAP]:  (1 arguments defined for method invocation)
[Tue Apr 10 10:19:42 2018]   Arg0:   0000000078bd38d9 <Obj>           Buffer(12) 02 00 00 00 BF 0B 00 00
[Tue Apr 10 10:19:42 2018] ACPI Error: Method parse/execution failed \_PR.CPU4.GCAP, AE_NOT_FOUND (20180105/psparse-550)
[Tue Apr 10 10:19:42 2018] ACPI Error: Method parse/execution failed \_PR.CPU4._PDC, AE_NOT_FOUND (20180105/psparse-550)
[Tue Apr 10 10:19:42 2018] ACPI BIOS Error (bug): Failure looking up [\_SB.OSCP], AE_NOT_FOUND (20180105/psargs-364)
[Tue Apr 10 10:19:42 2018] No Local Variables are initialized for Method [GCAP]
[Tue Apr 10 10:19:42 2018] Initialized Arguments for Method [GCAP]:  (1 arguments defined for method invocation)
[Tue Apr 10 10:19:42 2018]   Arg0:   0000000048e9142e <Obj>           Buffer(12) 02 00 00 00 BF 0B 00 00
[Tue Apr 10 10:19:42 2018] ACPI Error: Method parse/execution failed \_PR.CPU5.GCAP, AE_NOT_FOUND (20180105/psparse-550)
[Tue Apr 10 10:19:42 2018] ACPI Error: Method parse/execution failed \_PR.CPU5._PDC, AE_NOT_FOUND (20180105/psparse-550)
[Tue Apr 10 10:19:42 2018] ACPI BIOS Error (bug): Failure looking up [\_SB.OSCP], AE_NOT_FOUND (20180105/psargs-364)
[Tue Apr 10 10:19:42 2018] No Local Variables are initialized for Method [GCAP]
[Tue Apr 10 10:19:42 2018] Initialized Arguments for Method [GCAP]:  (1 arguments defined for method invocation)
[Tue Apr 10 10:19:42 2018]   Arg0:   0000000031d35a0b <Obj>           Buffer(12) 02 00 00 00 BF 0B 00 00
[Tue Apr 10 10:19:42 2018] ACPI Error: Method parse/execution failed \_PR.CPU6.GCAP, AE_NOT_FOUND (20180105/psparse-550)
[Tue Apr 10 10:19:42 2018] ACPI Error: Method parse/execution failed \_PR.CPU6._PDC, AE_NOT_FOUND (20180105/psparse-550)
[Tue Apr 10 10:19:42 2018] ACPI BIOS Error (bug): Failure looking up [\_SB.OSCP], AE_NOT_FOUND (20180105/psargs-364)
[Tue Apr 10 10:19:42 2018] No Local Variables are initialized for Method [GCAP]
[Tue Apr 10 10:19:42 2018] Initialized Arguments for Method [GCAP]:  (1 arguments defined for method invocation)
[Tue Apr 10 10:19:42 2018]   Arg0:   0000000049f439b5 <Obj>           Buffer(12) 02 00 00 00 BF 0B 00 00
[Tue Apr 10 10:19:42 2018] ACPI Error: Method parse/execution failed \_PR.CPU7.GCAP, AE_NOT_FOUND (20180105/psparse-550)
[Tue Apr 10 10:19:42 2018] ACPI Error: Method parse/execution failed \_PR.CPU7._PDC, AE_NOT_FOUND (20180105/psparse-550)
[Tue Apr 10 10:19:42 2018] ACPI: Interpreter enabled
[Tue Apr 10 10:19:42 2018] ACPI: (supports S0 S3 S4 S5)
[Tue Apr 10 10:19:42 2018] ACPI: Using IOAPIC for interrupt routing
[Tue Apr 10 10:19:42 2018] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[Tue Apr 10 10:19:42 2018] ACPI: Enabled 11 GPEs in block 00 to 7F
[Tue Apr 10 10:19:42 2018] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[Tue Apr 10 10:19:42 2018] acpi PNP0A08:00: _OSC: OS assumes control of [PCIeHotplug SHPCHotplug AER PCIeCapability]
[Tue Apr 10 10:19:42 2018] PCI host bridge to bus 0000:00
[Tue Apr 10 10:19:42 2018] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000c3fff window]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:00: root bus resource [mem 0x000c4000-0x000c7fff window]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:00: root bus resource [mem 0x000c8000-0x000cbfff window]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:00: root bus resource [mem 0x000cc000-0x000cffff window]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000d3fff window]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d7fff window]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000dbfff window]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000dffff window]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000e3fff window]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:00: root bus resource [mem 0x000e4000-0x000e7fff window]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:00: root bus resource [mem 0x000e8000-0x000ebfff window]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:00: root bus resource [mem 0x000ec000-0x000effff window]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:00: root bus resource [mem 0x000f0000-0x000fffff window]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:00: root bus resource [mem 0x80000000-0xfeafffff window]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:00: root bus resource [mem 0x4000000000-0x7fffffffff window]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:00: root bus resource [bus 00-ff]
[Tue Apr 10 10:19:42 2018] pci 0000:00:00.0: [8086:5910] type 00 class 0x060000
[Tue Apr 10 10:19:42 2018] pci 0000:00:01.0: [8086:1901] type 01 class 0x060400
[Tue Apr 10 10:19:42 2018] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[Tue Apr 10 10:19:42 2018] pci 0000:00:01.1: [8086:1905] type 01 class 0x060400
[Tue Apr 10 10:19:42 2018] pci 0000:00:01.1: PME# supported from D0 D3hot D3cold
[Tue Apr 10 10:19:42 2018] pci 0000:00:01.2: [8086:1909] type 01 class 0x060400
[Tue Apr 10 10:19:42 2018] pci 0000:00:01.2: PME# supported from D0 D3hot D3cold
[Tue Apr 10 10:19:42 2018] pci 0000:00:14.0: [8086:a12f] type 00 class 0x0c0330
[Tue Apr 10 10:19:42 2018] pci 0000:00:14.0: reg 0x10: [mem 0x82700000-0x8270ffff 64bit]
[Tue Apr 10 10:19:42 2018] pci 0000:00:14.0: PME# supported from D3hot D3cold
[Tue Apr 10 10:19:42 2018] pci 0000:00:15.0: [8086:a160] type 00 class 0x118000
[Tue Apr 10 10:19:42 2018] pci 0000:00:15.0: reg 0x10: [mem 0x82728000-0x82728fff 64bit]
[Tue Apr 10 10:19:42 2018] pci 0000:00:16.0: [8086:a13a] type 00 class 0x078000
[Tue Apr 10 10:19:42 2018] pci 0000:00:16.0: reg 0x10: [mem 0x82729000-0x82729fff 64bit]
[Tue Apr 10 10:19:42 2018] pci 0000:00:16.0: PME# supported from D3hot
[Tue Apr 10 10:19:42 2018] pci 0000:00:19.0: [8086:a166] type 00 class 0x118000
[Tue Apr 10 10:19:42 2018] pci 0000:00:19.0: reg 0x10: [mem 0x8272a000-0x8272afff 64bit]
[Tue Apr 10 10:19:42 2018] pci 0000:00:1b.0: [8086:a167] type 01 class 0x060400
[Tue Apr 10 10:19:42 2018] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[Tue Apr 10 10:19:42 2018] pci 0000:00:1c.0: [8086:a110] type 01 class 0x060400
[Tue Apr 10 10:19:42 2018] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[Tue Apr 10 10:19:42 2018] pci 0000:00:1e.0: [8086:a127] type 00 class 0x118000
[Tue Apr 10 10:19:42 2018] pci 0000:00:1e.0: reg 0x10: [mem 0x8272b000-0x8272bfff 64bit]
[Tue Apr 10 10:19:42 2018] pci 0000:00:1e.1: [8086:a128] type 00 class 0x118000
[Tue Apr 10 10:19:42 2018] pci 0000:00:1e.1: reg 0x10: [mem 0x8272c000-0x8272cfff 64bit]
[Tue Apr 10 10:19:42 2018] pci 0000:00:1e.2: [8086:a129] type 00 class 0x118000
[Tue Apr 10 10:19:42 2018] pci 0000:00:1e.2: reg 0x10: [mem 0x8272d000-0x8272dfff 64bit]
[Tue Apr 10 10:19:42 2018] pci 0000:00:1e.3: [8086:a12a] type 00 class 0x118000
[Tue Apr 10 10:19:42 2018] pci 0000:00:1e.3: reg 0x10: [mem 0x8272e000-0x8272efff 64bit]
[Tue Apr 10 10:19:42 2018] pci 0000:00:1f.0: [8086:a151] type 00 class 0x060100
[Tue Apr 10 10:19:42 2018] pci 0000:00:1f.2: [8086:a121] type 00 class 0x058000
[Tue Apr 10 10:19:42 2018] pci 0000:00:1f.2: reg 0x10: [mem 0x82724000-0x82727fff]
[Tue Apr 10 10:19:42 2018] pci 0000:00:1f.3: [8086:a170] type 00 class 0x040300
[Tue Apr 10 10:19:42 2018] pci 0000:00:1f.3: reg 0x10: [mem 0x82720000-0x82723fff 64bit]
[Tue Apr 10 10:19:42 2018] pci 0000:00:1f.3: reg 0x20: [mem 0x00000000-0x0000ffff 64bit]
[Tue Apr 10 10:19:42 2018] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[Tue Apr 10 10:19:42 2018] pci 0000:00:1f.4: [8086:a123] type 00 class 0x0c0500
[Tue Apr 10 10:19:42 2018] pci 0000:00:1f.4: reg 0x10: [mem 0x8272f000-0x8272f0ff 64bit]
[Tue Apr 10 10:19:42 2018] pci 0000:00:1f.4: reg 0x20: [io  0x5040-0x505f]
[Tue Apr 10 10:19:42 2018] pci 0000:01:00.0: [1002:67ef] type 00 class 0x030000
[Tue Apr 10 10:19:42 2018] pci 0000:01:00.0: reg 0x10: [mem 0xb0000000-0xbfffffff 64bit pref]
[Tue Apr 10 10:19:42 2018] pci 0000:01:00.0: reg 0x18: [mem 0xc0000000-0xc01fffff 64bit pref]
[Tue Apr 10 10:19:42 2018] pci 0000:01:00.0: reg 0x20: [io  0x4000-0x40ff]
[Tue Apr 10 10:19:42 2018] pci 0000:01:00.0: reg 0x24: [mem 0x82600000-0x8263ffff]
[Tue Apr 10 10:19:42 2018] pci 0000:01:00.0: reg 0x30: [mem 0x82640000-0x8265ffff pref]
[Tue Apr 10 10:19:42 2018] pci 0000:01:00.0: BAR 0: assigned to efifb
[Tue Apr 10 10:19:42 2018] pci 0000:01:00.0: supports D1 D2
[Tue Apr 10 10:19:42 2018] pci 0000:01:00.1: [1002:aae0] type 00 class 0x040300
[Tue Apr 10 10:19:42 2018] pci 0000:01:00.1: reg 0x10: [mem 0x82660000-0x82663fff 64bit]
[Tue Apr 10 10:19:42 2018] pci 0000:01:00.1: supports D1 D2
[Tue Apr 10 10:19:42 2018] pci 0000:00:01.0: PCI bridge to [bus 01]
[Tue Apr 10 10:19:42 2018] pci 0000:00:01.0:   bridge window [io  0x4000-0x4fff]
[Tue Apr 10 10:19:42 2018] pci 0000:00:01.0:   bridge window [mem 0x82600000-0x826fffff]
[Tue Apr 10 10:19:42 2018] pci 0000:00:01.0:   bridge window [mem 0xb0000000-0xc01fffff 64bit pref]
[Tue Apr 10 10:19:42 2018] pci 0000:04:00.0: [8086:1578] type 01 class 0x060400
[Tue Apr 10 10:19:42 2018] pci 0000:04:00.0: enabling Extended Tags
[Tue Apr 10 10:19:42 2018] pci 0000:04:00.0: supports D1 D2
[Tue Apr 10 10:19:42 2018] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[Tue Apr 10 10:19:42 2018] pci 0000:00:01.1: PCI bridge to [bus 04-79]
[Tue Apr 10 10:19:42 2018] pci 0000:00:01.1:   bridge window [io  0x6000-0x9fff]
[Tue Apr 10 10:19:42 2018] pci 0000:00:01.1:   bridge window [mem 0x82800000-0x909fffff]
[Tue Apr 10 10:19:42 2018] pci 0000:00:01.1:   bridge window [mem 0xc0200000-0xce1fffff 64bit pref]
[Tue Apr 10 10:19:42 2018] pci 0000:05:00.0: [8086:15d3] type 01 class 0x060400
[Tue Apr 10 10:19:42 2018] pci 0000:05:00.0: enabling Extended Tags
[Tue Apr 10 10:19:42 2018] pci 0000:05:00.0: supports D1 D2
[Tue Apr 10 10:19:42 2018] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[Tue Apr 10 10:19:42 2018] pci 0000:05:01.0: [8086:15d3] type 01 class 0x060400
[Tue Apr 10 10:19:42 2018] pci 0000:05:01.0: enabling Extended Tags
[Tue Apr 10 10:19:42 2018] pci 0000:05:01.0: supports D1 D2
[Tue Apr 10 10:19:42 2018] pci 0000:05:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[Tue Apr 10 10:19:42 2018] pci 0000:05:02.0: [8086:15d3] type 01 class 0x060400
[Tue Apr 10 10:19:42 2018] pci 0000:05:02.0: enabling Extended Tags
[Tue Apr 10 10:19:42 2018] pci 0000:05:02.0: supports D1 D2
[Tue Apr 10 10:19:42 2018] pci 0000:05:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[Tue Apr 10 10:19:42 2018] pci 0000:05:04.0: [8086:15d3] type 01 class 0x060400
[Tue Apr 10 10:19:42 2018] pci 0000:05:04.0: enabling Extended Tags
[Tue Apr 10 10:19:42 2018] pci 0000:05:04.0: supports D1 D2
[Tue Apr 10 10:19:42 2018] pci 0000:05:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[Tue Apr 10 10:19:42 2018] pci 0000:04:00.0: PCI bridge to [bus 05-79]
[Tue Apr 10 10:19:42 2018] pci 0000:04:00.0:   bridge window [io  0x0000-0x0fff]
[Tue Apr 10 10:19:42 2018] pci 0000:04:00.0:   bridge window [mem 0x82800000-0x909fffff]
[Tue Apr 10 10:19:42 2018] pci 0000:04:00.0:   bridge window [mem 0xc0200000-0xce1fffff 64bit pref]
[Tue Apr 10 10:19:42 2018] pci 0000:06:00.0: [8086:15d2] type 00 class 0x088000
[Tue Apr 10 10:19:42 2018] pci 0000:06:00.0: reg 0x10: [mem 0x82900000-0x8293ffff]
[Tue Apr 10 10:19:42 2018] pci 0000:06:00.0: reg 0x14: [mem 0x82940000-0x82940fff]
[Tue Apr 10 10:19:42 2018] pci 0000:06:00.0: enabling Extended Tags
[Tue Apr 10 10:19:42 2018] pci 0000:06:00.0: supports D1 D2
[Tue Apr 10 10:19:42 2018] pci 0000:06:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[Tue Apr 10 10:19:42 2018] pci 0000:05:00.0: PCI bridge to [bus 06]
[Tue Apr 10 10:19:42 2018] pci 0000:05:00.0:   bridge window [io  0x0000-0x0fff]
[Tue Apr 10 10:19:42 2018] pci 0000:05:00.0:   bridge window [mem 0x82900000-0x829fffff]
[Tue Apr 10 10:19:42 2018] pci 0000:05:01.0: PCI bridge to [bus 08-40]
[Tue Apr 10 10:19:42 2018] pci 0000:05:01.0:   bridge window [io  0x0000-0x0fff]
[Tue Apr 10 10:19:42 2018] pci 0000:05:01.0:   bridge window [mem 0x82a00000-0x899fffff]
[Tue Apr 10 10:19:42 2018] pci 0000:05:01.0:   bridge window [mem 0xc0200000-0xc71fffff 64bit pref]
[Tue Apr 10 10:19:42 2018] pci 0000:07:00.0: [8086:15d4] type 00 class 0x0c0330
[Tue Apr 10 10:19:42 2018] pci 0000:07:00.0: reg 0x10: [mem 0x00000000-0x0000ffff]
[Tue Apr 10 10:19:42 2018] pci 0000:07:00.0: enabling Extended Tags
[Tue Apr 10 10:19:42 2018] pci 0000:07:00.0: supports D1 D2
[Tue Apr 10 10:19:42 2018] pci 0000:07:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[Tue Apr 10 10:19:42 2018] pci 0000:05:02.0: PCI bridge to [bus 07]
[Tue Apr 10 10:19:42 2018] pci 0000:05:02.0:   bridge window [io  0x0000-0x0fff]
[Tue Apr 10 10:19:42 2018] pci 0000:05:02.0:   bridge window [mem 0x82800000-0x828fffff]
[Tue Apr 10 10:19:42 2018] pci 0000:05:04.0: PCI bridge to [bus 41-79]
[Tue Apr 10 10:19:42 2018] pci 0000:05:04.0:   bridge window [io  0x0000-0x0fff]
[Tue Apr 10 10:19:42 2018] pci 0000:05:04.0:   bridge window [mem 0x89a00000-0x909fffff]
[Tue Apr 10 10:19:42 2018] pci 0000:05:04.0:   bridge window [mem 0xc7200000-0xce1fffff 64bit pref]
[Tue Apr 10 10:19:42 2018] pci 0000:7a:00.0: [8086:1578] type 01 class 0x060400
[Tue Apr 10 10:19:42 2018] pci 0000:7a:00.0: enabling Extended Tags
[Tue Apr 10 10:19:42 2018] pci 0000:7a:00.0: supports D1 D2
[Tue Apr 10 10:19:42 2018] pci 0000:7a:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[Tue Apr 10 10:19:42 2018] pci 0000:00:01.2: PCI bridge to [bus 7a-ef]
[Tue Apr 10 10:19:42 2018] pci 0000:00:01.2:   bridge window [io  0xa000-0xdfff]
[Tue Apr 10 10:19:42 2018] pci 0000:00:01.2:   bridge window [mem 0x90a00000-0x9ebfffff]
[Tue Apr 10 10:19:42 2018] pci 0000:00:01.2:   bridge window [mem 0xce200000-0xdc1fffff 64bit pref]
[Tue Apr 10 10:19:42 2018] pci 0000:7b:00.0: [8086:15d3] type 01 class 0x060400
[Tue Apr 10 10:19:42 2018] pci 0000:7b:00.0: enabling Extended Tags
[Tue Apr 10 10:19:42 2018] pci 0000:7b:00.0: supports D1 D2
[Tue Apr 10 10:19:42 2018] pci 0000:7b:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[Tue Apr 10 10:19:42 2018] pci 0000:7b:01.0: [8086:15d3] type 01 class 0x060400
[Tue Apr 10 10:19:42 2018] pci 0000:7b:01.0: enabling Extended Tags
[Tue Apr 10 10:19:42 2018] pci 0000:7b:01.0: supports D1 D2
[Tue Apr 10 10:19:42 2018] pci 0000:7b:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[Tue Apr 10 10:19:42 2018] pci 0000:7b:02.0: [8086:15d3] type 01 class 0x060400
[Tue Apr 10 10:19:42 2018] pci 0000:7b:02.0: enabling Extended Tags
[Tue Apr 10 10:19:42 2018] pci 0000:7b:02.0: supports D1 D2
[Tue Apr 10 10:19:42 2018] pci 0000:7b:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[Tue Apr 10 10:19:42 2018] pci 0000:7b:04.0: [8086:15d3] type 01 class 0x060400
[Tue Apr 10 10:19:42 2018] pci 0000:7b:04.0: enabling Extended Tags
[Tue Apr 10 10:19:42 2018] pci 0000:7b:04.0: supports D1 D2
[Tue Apr 10 10:19:42 2018] pci 0000:7b:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[Tue Apr 10 10:19:42 2018] pci 0000:7a:00.0: PCI bridge to [bus 7b-ef]
[Tue Apr 10 10:19:42 2018] pci 0000:7a:00.0:   bridge window [io  0x0000-0x0fff]
[Tue Apr 10 10:19:42 2018] pci 0000:7a:00.0:   bridge window [mem 0x90a00000-0x9ebfffff]
[Tue Apr 10 10:19:42 2018] pci 0000:7a:00.0:   bridge window [mem 0xce200000-0xdc1fffff 64bit pref]
[Tue Apr 10 10:19:42 2018] pci 0000:7c:00.0: [8086:15d2] type 00 class 0x088000
[Tue Apr 10 10:19:42 2018] pci 0000:7c:00.0: reg 0x10: [mem 0x90b00000-0x90b3ffff]
[Tue Apr 10 10:19:42 2018] pci 0000:7c:00.0: reg 0x14: [mem 0x90b40000-0x90b40fff]
[Tue Apr 10 10:19:42 2018] pci 0000:7c:00.0: enabling Extended Tags
[Tue Apr 10 10:19:42 2018] pci 0000:7c:00.0: supports D1 D2
[Tue Apr 10 10:19:42 2018] pci 0000:7c:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[Tue Apr 10 10:19:42 2018] pci 0000:7b:00.0: PCI bridge to [bus 7c]
[Tue Apr 10 10:19:42 2018] pci 0000:7b:00.0:   bridge window [io  0x0000-0x0fff]
[Tue Apr 10 10:19:42 2018] pci 0000:7b:00.0:   bridge window [mem 0x90b00000-0x90bfffff]
[Tue Apr 10 10:19:42 2018] pci 0000:7b:01.0: PCI bridge to [bus 7e-b6]
[Tue Apr 10 10:19:42 2018] pci 0000:7b:01.0:   bridge window [io  0x0000-0x0fff]
[Tue Apr 10 10:19:42 2018] pci 0000:7b:01.0:   bridge window [mem 0x90c00000-0x97bfffff]
[Tue Apr 10 10:19:42 2018] pci 0000:7b:01.0:   bridge window [mem 0xce200000-0xd51fffff 64bit pref]
[Tue Apr 10 10:19:42 2018] pci 0000:7d:00.0: [8086:15d4] type 00 class 0x0c0330
[Tue Apr 10 10:19:42 2018] pci 0000:7d:00.0: reg 0x10: [mem 0x00000000-0x0000ffff]
[Tue Apr 10 10:19:42 2018] pci 0000:7d:00.0: enabling Extended Tags
[Tue Apr 10 10:19:42 2018] pci 0000:7d:00.0: supports D1 D2
[Tue Apr 10 10:19:42 2018] pci 0000:7d:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[Tue Apr 10 10:19:42 2018] pci 0000:7b:02.0: PCI bridge to [bus 7d]
[Tue Apr 10 10:19:42 2018] pci 0000:7b:02.0:   bridge window [io  0x0000-0x0fff]
[Tue Apr 10 10:19:42 2018] pci 0000:7b:02.0:   bridge window [mem 0x90a00000-0x90afffff]
[Tue Apr 10 10:19:42 2018] pci 0000:7b:04.0: PCI bridge to [bus b7-ef]
[Tue Apr 10 10:19:42 2018] pci 0000:7b:04.0:   bridge window [io  0x0000-0x0fff]
[Tue Apr 10 10:19:42 2018] pci 0000:7b:04.0:   bridge window [mem 0x97c00000-0x9ebfffff]
[Tue Apr 10 10:19:42 2018] pci 0000:7b:04.0:   bridge window [mem 0xd5200000-0xdc1fffff 64bit pref]
[Tue Apr 10 10:19:42 2018] pci 0000:02:00.0: [144d:a804] type 00 class 0x010802
[Tue Apr 10 10:19:42 2018] pci 0000:02:00.0: reg 0x10: [mem 0x82500000-0x82503fff 64bit]
[Tue Apr 10 10:19:42 2018] pci 0000:02:00.0: reg 0x18: [io  0x3000-0x30ff]
[Tue Apr 10 10:19:42 2018] pci 0000:00:1b.0: PCI bridge to [bus 02]
[Tue Apr 10 10:19:42 2018] pci 0000:00:1b.0:   bridge window [io  0x3000-0x3fff]
[Tue Apr 10 10:19:42 2018] pci 0000:00:1b.0:   bridge window [mem 0x82500000-0x825fffff]
[Tue Apr 10 10:19:42 2018] pci 0000:03:00.0: [14e4:43ba] type 00 class 0x028000
[Tue Apr 10 10:19:42 2018] pci 0000:03:00.0: reg 0x10: [mem 0x82400000-0x82407fff 64bit]
[Tue Apr 10 10:19:42 2018] pci 0000:03:00.0: reg 0x18: [mem 0x82000000-0x823fffff 64bit]
[Tue Apr 10 10:19:42 2018] pci 0000:03:00.0: supports D1 D2
[Tue Apr 10 10:19:42 2018] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[Tue Apr 10 10:19:42 2018] pci 0000:00:1c.0: PCI bridge to [bus 03]
[Tue Apr 10 10:19:42 2018] pci 0000:00:1c.0:   bridge window [mem 0x82000000-0x824fffff]
[Tue Apr 10 10:19:42 2018] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 12 14 15) *0
[Tue Apr 10 10:19:42 2018] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 11 12 14 15) *0
[Tue Apr 10 10:19:42 2018] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 12 14 15) *0
[Tue Apr 10 10:19:42 2018] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 11 12 14 15) *0
[Tue Apr 10 10:19:42 2018] ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 10 12 14 15) *0
[Tue Apr 10 10:19:42 2018] ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 14 15) *0
[Tue Apr 10 10:19:42 2018] ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 10 12 14 15) *0
[Tue Apr 10 10:19:42 2018] ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 7 11 12 14 15) *0
[Tue Apr 10 10:19:42 2018] ACPI: EC: interrupt unblocked
[Tue Apr 10 10:19:42 2018] ACPI: EC: event unblocked
[Tue Apr 10 10:19:42 2018] ACPI: \_SB_.PCI0.LPCB.EC__: GPE=0x7, EC_CMD/EC_SC=0x66, EC_DATA=0x62
[Tue Apr 10 10:19:42 2018] ACPI: \_SB_.PCI0.LPCB.EC__: Used as boot DSDT EC to handle transactions and events
[Tue Apr 10 10:19:42 2018] pci 0000:01:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
[Tue Apr 10 10:19:42 2018] pci 0000:01:00.0: vgaarb: bridge control possible
[Tue Apr 10 10:19:42 2018] pci 0000:01:00.0: vgaarb: setting as boot device
[Tue Apr 10 10:19:42 2018] vgaarb: loaded
[Tue Apr 10 10:19:42 2018] SCSI subsystem initialized
[Tue Apr 10 10:19:42 2018] libata version 3.00 loaded.
[Tue Apr 10 10:19:42 2018] ACPI: bus type USB registered
[Tue Apr 10 10:19:42 2018] usbcore: registered new interface driver usbfs
[Tue Apr 10 10:19:42 2018] usbcore: registered new interface driver hub
[Tue Apr 10 10:19:42 2018] usbcore: registered new device driver usb
[Tue Apr 10 10:19:42 2018] EDAC MC: Ver: 3.0.0
[Tue Apr 10 10:19:42 2018] Registered efivars operations
[Tue Apr 10 10:19:42 2018] PCI: Using ACPI for IRQ routing
[Tue Apr 10 10:19:42 2018] PCI: pci_cache_line_size set to 64 bytes
[Tue Apr 10 10:19:42 2018] e820: reserve RAM buffer [mem 0x00058000-0x0005ffff]
[Tue Apr 10 10:19:42 2018] e820: reserve RAM buffer [mem 0x0009e000-0x0009ffff]
[Tue Apr 10 10:19:42 2018] e820: reserve RAM buffer [mem 0x7401d000-0x77ffffff]
[Tue Apr 10 10:19:42 2018] e820: reserve RAM buffer [mem 0x74ca8000-0x77ffffff]
[Tue Apr 10 10:19:42 2018] e820: reserve RAM buffer [mem 0x74f4e000-0x77ffffff]
[Tue Apr 10 10:19:42 2018] e820: reserve RAM buffer [mem 0x7ab9f000-0x7bffffff]
[Tue Apr 10 10:19:42 2018] e820: reserve RAM buffer [mem 0x7b000000-0x7bffffff]
[Tue Apr 10 10:19:42 2018] e820: reserve RAM buffer [mem 0x47f000000-0x47fffffff]
[Tue Apr 10 10:19:42 2018] NetLabel: Initializing
[Tue Apr 10 10:19:42 2018] NetLabel:  domain hash size = 128
[Tue Apr 10 10:19:42 2018] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[Tue Apr 10 10:19:42 2018] NetLabel:  unlabeled traffic allowed by default
[Tue Apr 10 10:19:42 2018] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[Tue Apr 10 10:19:42 2018] hpet0: 8 comparators, 64-bit 24.000000 MHz counter
[Tue Apr 10 10:19:42 2018] clocksource: Switched to clocksource tsc-early
[Tue Apr 10 10:19:42 2018] VFS: Disk quotas dquot_6.6.0
[Tue Apr 10 10:19:42 2018] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[Tue Apr 10 10:19:42 2018] AppArmor: AppArmor Filesystem Enabled
[Tue Apr 10 10:19:42 2018] pnp: PnP ACPI init
[Tue Apr 10 10:19:42 2018] system 00:00: [io  0xffff] has been reserved
[Tue Apr 10 10:19:42 2018] system 00:00: [io  0x1800-0x18fe] has been reserved
[Tue Apr 10 10:19:42 2018] system 00:00: [io  0x0800-0x087f] has been reserved
[Tue Apr 10 10:19:42 2018] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[Tue Apr 10 10:19:42 2018] pnp 00:01: Plug and Play ACPI device, IDs PNP0b00 (active)
[Tue Apr 10 10:19:42 2018] pnp 00:02: Plug and Play ACPI device, IDs APP000b (active)
[Tue Apr 10 10:19:42 2018] system 00:03: [mem 0xfed10000-0xfed17fff] has been reserved
[Tue Apr 10 10:19:42 2018] system 00:03: [mem 0xfed18000-0xfed18fff] has been reserved
[Tue Apr 10 10:19:42 2018] system 00:03: [mem 0xfed19000-0xfed19fff] has been reserved
[Tue Apr 10 10:19:42 2018] system 00:03: [mem 0xe0000000-0xefffffff] has been reserved
[Tue Apr 10 10:19:42 2018] system 00:03: [mem 0xfd000000-0xfe7fffff] could not be reserved
[Tue Apr 10 10:19:42 2018] system 00:03: [mem 0xfed20000-0xfed3ffff] has been reserved
[Tue Apr 10 10:19:42 2018] system 00:03: [mem 0xfed90000-0xfed93fff] could not be reserved
[Tue Apr 10 10:19:42 2018] system 00:03: [mem 0xfed45000-0xfed8ffff] has been reserved
[Tue Apr 10 10:19:42 2018] system 00:03: [mem 0xff000000-0xffffffff] could not be reserved
[Tue Apr 10 10:19:42 2018] system 00:03: [mem 0xfee00000-0xfeefffff] has been reserved
[Tue Apr 10 10:19:42 2018] system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
[Tue Apr 10 10:19:42 2018] system 00:04: [mem 0x20000000-0x201fffff] could not be reserved
[Tue Apr 10 10:19:42 2018] system 00:04: [mem 0x40000000-0x401fffff] could not be reserved
[Tue Apr 10 10:19:42 2018] system 00:04: Plug and Play ACPI device, IDs PNP0c01 (active)
[Tue Apr 10 10:19:42 2018] pnp: PnP ACPI: found 5 devices
[Tue Apr 10 10:19:42 2018] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[Tue Apr 10 10:19:42 2018] pci 0000:05:01.0: bridge window [io  0x1000-0x0fff] to [bus 08-40] add_size 1000
[Tue Apr 10 10:19:42 2018] pci 0000:05:02.0: bridge window [io  0x1000-0x0fff] to [bus 07] add_size 1000
[Tue Apr 10 10:19:42 2018] pci 0000:05:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 07] add_size 200000 add_align 100000
[Tue Apr 10 10:19:42 2018] pci 0000:05:04.0: bridge window [io  0x1000-0x0fff] to [bus 41-79] add_size 1000
[Tue Apr 10 10:19:42 2018] pci 0000:04:00.0: bridge window [io  0x1000-0x0fff] to [bus 05-79] add_size 3000
[Tue Apr 10 10:19:42 2018] pci 0000:7b:01.0: bridge window [io  0x1000-0x0fff] to [bus 7e-b6] add_size 1000
[Tue Apr 10 10:19:42 2018] pci 0000:7b:02.0: bridge window [io  0x1000-0x0fff] to [bus 7d] add_size 1000
[Tue Apr 10 10:19:42 2018] pci 0000:7b:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 7d] add_size 200000 add_align 100000
[Tue Apr 10 10:19:42 2018] pci 0000:7b:04.0: bridge window [io  0x1000-0x0fff] to [bus b7-ef] add_size 1000
[Tue Apr 10 10:19:42 2018] pci 0000:7a:00.0: bridge window [io  0x1000-0x0fff] to [bus 7b-ef] add_size 3000
[Tue Apr 10 10:19:42 2018] pci 0000:00:1f.3: BAR 4: assigned [mem 0x4000000000-0x400000ffff 64bit]
[Tue Apr 10 10:19:42 2018] pci 0000:00:01.0: PCI bridge to [bus 01]
[Tue Apr 10 10:19:42 2018] pci 0000:00:01.0:   bridge window [io  0x4000-0x4fff]
[Tue Apr 10 10:19:42 2018] pci 0000:00:01.0:   bridge window [mem 0x82600000-0x826fffff]
[Tue Apr 10 10:19:42 2018] pci 0000:00:01.0:   bridge window [mem 0xb0000000-0xc01fffff 64bit pref]
[Tue Apr 10 10:19:42 2018] pci 0000:04:00.0: BAR 13: assigned [io  0x6000-0x8fff]
[Tue Apr 10 10:19:42 2018] pci 0000:05:02.0: BAR 15: no space for [mem size 0x00200000 64bit pref]
[Tue Apr 10 10:19:42 2018] pci 0000:05:02.0: BAR 15: failed to assign [mem size 0x00200000 64bit pref]
[Tue Apr 10 10:19:42 2018] pci 0000:05:01.0: BAR 13: assigned [io  0x6000-0x6fff]
[Tue Apr 10 10:19:42 2018] pci 0000:05:02.0: BAR 13: assigned [io  0x7000-0x7fff]
[Tue Apr 10 10:19:42 2018] pci 0000:05:04.0: BAR 13: assigned [io  0x8000-0x8fff]
[Tue Apr 10 10:19:42 2018] pci 0000:05:02.0: BAR 15: no space for [mem size 0x00200000 64bit pref]
[Tue Apr 10 10:19:42 2018] pci 0000:05:02.0: BAR 15: failed to assign [mem size 0x00200000 64bit pref]
[Tue Apr 10 10:19:42 2018] pci 0000:05:00.0: PCI bridge to [bus 06]
[Tue Apr 10 10:19:42 2018] pci 0000:05:00.0:   bridge window [mem 0x82900000-0x829fffff]
[Tue Apr 10 10:19:42 2018] pci 0000:05:01.0: PCI bridge to [bus 08-40]
[Tue Apr 10 10:19:42 2018] pci 0000:05:01.0:   bridge window [io  0x6000-0x6fff]
[Tue Apr 10 10:19:42 2018] pci 0000:05:01.0:   bridge window [mem 0x82a00000-0x899fffff]
[Tue Apr 10 10:19:42 2018] pci 0000:05:01.0:   bridge window [mem 0xc0200000-0xc71fffff 64bit pref]
[Tue Apr 10 10:19:42 2018] pci 0000:07:00.0: BAR 0: assigned [mem 0x82800000-0x8280ffff]
[Tue Apr 10 10:19:42 2018] pci 0000:05:02.0: PCI bridge to [bus 07]
[Tue Apr 10 10:19:42 2018] pci 0000:05:02.0:   bridge window [io  0x7000-0x7fff]
[Tue Apr 10 10:19:42 2018] pci 0000:05:02.0:   bridge window [mem 0x82800000-0x828fffff]
[Tue Apr 10 10:19:42 2018] pci 0000:05:04.0: PCI bridge to [bus 41-79]
[Tue Apr 10 10:19:42 2018] pci 0000:05:04.0:   bridge window [io  0x8000-0x8fff]
[Tue Apr 10 10:19:42 2018] pci 0000:05:04.0:   bridge window [mem 0x89a00000-0x909fffff]
[Tue Apr 10 10:19:42 2018] pci 0000:05:04.0:   bridge window [mem 0xc7200000-0xce1fffff 64bit pref]
[Tue Apr 10 10:19:42 2018] pci 0000:04:00.0: PCI bridge to [bus 05-79]
[Tue Apr 10 10:19:42 2018] pci 0000:04:00.0:   bridge window [io  0x6000-0x8fff]
[Tue Apr 10 10:19:42 2018] pci 0000:04:00.0:   bridge window [mem 0x82800000-0x909fffff]
[Tue Apr 10 10:19:42 2018] pci 0000:04:00.0:   bridge window [mem 0xc0200000-0xce1fffff 64bit pref]
[Tue Apr 10 10:19:42 2018] pci 0000:00:01.1: PCI bridge to [bus 04-79]
[Tue Apr 10 10:19:42 2018] pci 0000:00:01.1:   bridge window [io  0x6000-0x9fff]
[Tue Apr 10 10:19:42 2018] pci 0000:00:01.1:   bridge window [mem 0x82800000-0x909fffff]
[Tue Apr 10 10:19:42 2018] pci 0000:00:01.1:   bridge window [mem 0xc0200000-0xce1fffff 64bit pref]
[Tue Apr 10 10:19:42 2018] pci 0000:7a:00.0: BAR 13: assigned [io  0xa000-0xcfff]
[Tue Apr 10 10:19:42 2018] pci 0000:7b:02.0: BAR 15: no space for [mem size 0x00200000 64bit pref]
[Tue Apr 10 10:19:42 2018] pci 0000:7b:02.0: BAR 15: failed to assign [mem size 0x00200000 64bit pref]
[Tue Apr 10 10:19:42 2018] pci 0000:7b:01.0: BAR 13: assigned [io  0xa000-0xafff]
[Tue Apr 10 10:19:42 2018] pci 0000:7b:02.0: BAR 13: assigned [io  0xb000-0xbfff]
[Tue Apr 10 10:19:42 2018] pci 0000:7b:04.0: BAR 13: assigned [io  0xc000-0xcfff]
[Tue Apr 10 10:19:42 2018] pci 0000:7b:02.0: BAR 15: no space for [mem size 0x00200000 64bit pref]
[Tue Apr 10 10:19:42 2018] pci 0000:7b:02.0: BAR 15: failed to assign [mem size 0x00200000 64bit pref]
[Tue Apr 10 10:19:42 2018] pci 0000:7b:00.0: PCI bridge to [bus 7c]
[Tue Apr 10 10:19:42 2018] pci 0000:7b:00.0:   bridge window [mem 0x90b00000-0x90bfffff]
[Tue Apr 10 10:19:42 2018] pci 0000:7b:01.0: PCI bridge to [bus 7e-b6]
[Tue Apr 10 10:19:42 2018] pci 0000:7b:01.0:   bridge window [io  0xa000-0xafff]
[Tue Apr 10 10:19:42 2018] pci 0000:7b:01.0:   bridge window [mem 0x90c00000-0x97bfffff]
[Tue Apr 10 10:19:42 2018] pci 0000:7b:01.0:   bridge window [mem 0xce200000-0xd51fffff 64bit pref]
[Tue Apr 10 10:19:42 2018] pci 0000:7d:00.0: BAR 0: assigned [mem 0x90a00000-0x90a0ffff]
[Tue Apr 10 10:19:42 2018] pci 0000:7b:02.0: PCI bridge to [bus 7d]
[Tue Apr 10 10:19:42 2018] pci 0000:7b:02.0:   bridge window [io  0xb000-0xbfff]
[Tue Apr 10 10:19:42 2018] pci 0000:7b:02.0:   bridge window [mem 0x90a00000-0x90afffff]
[Tue Apr 10 10:19:42 2018] pci 0000:7b:04.0: PCI bridge to [bus b7-ef]
[Tue Apr 10 10:19:42 2018] pci 0000:7b:04.0:   bridge window [io  0xc000-0xcfff]
[Tue Apr 10 10:19:42 2018] pci 0000:7b:04.0:   bridge window [mem 0x97c00000-0x9ebfffff]
[Tue Apr 10 10:19:42 2018] pci 0000:7b:04.0:   bridge window [mem 0xd5200000-0xdc1fffff 64bit pref]
[Tue Apr 10 10:19:42 2018] pci 0000:7a:00.0: PCI bridge to [bus 7b-ef]
[Tue Apr 10 10:19:42 2018] pci 0000:7a:00.0:   bridge window [io  0xa000-0xcfff]
[Tue Apr 10 10:19:42 2018] pci 0000:7a:00.0:   bridge window [mem 0x90a00000-0x9ebfffff]
[Tue Apr 10 10:19:42 2018] pci 0000:7a:00.0:   bridge window [mem 0xce200000-0xdc1fffff 64bit pref]
[Tue Apr 10 10:19:42 2018] pci 0000:00:01.2: PCI bridge to [bus 7a-ef]
[Tue Apr 10 10:19:42 2018] pci 0000:00:01.2:   bridge window [io  0xa000-0xdfff]
[Tue Apr 10 10:19:42 2018] pci 0000:00:01.2:   bridge window [mem 0x90a00000-0x9ebfffff]
[Tue Apr 10 10:19:42 2018] pci 0000:00:01.2:   bridge window [mem 0xce200000-0xdc1fffff 64bit pref]
[Tue Apr 10 10:19:42 2018] pci 0000:00:1b.0: PCI bridge to [bus 02]
[Tue Apr 10 10:19:42 2018] pci 0000:00:1b.0:   bridge window [io  0x3000-0x3fff]
[Tue Apr 10 10:19:42 2018] pci 0000:00:1b.0:   bridge window [mem 0x82500000-0x825fffff]
[Tue Apr 10 10:19:42 2018] pci 0000:00:1c.0: PCI bridge to [bus 03]
[Tue Apr 10 10:19:42 2018] pci 0000:00:1c.0:   bridge window [mem 0x82000000-0x824fffff]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000c3fff window]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:00: resource 8 [mem 0x000c4000-0x000c7fff window]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:00: resource 9 [mem 0x000c8000-0x000cbfff window]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:00: resource 10 [mem 0x000cc000-0x000cffff window]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:00: resource 11 [mem 0x000d0000-0x000d3fff window]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:00: resource 12 [mem 0x000d4000-0x000d7fff window]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:00: resource 13 [mem 0x000d8000-0x000dbfff window]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:00: resource 14 [mem 0x000dc000-0x000dffff window]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:00: resource 15 [mem 0x000e0000-0x000e3fff window]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:00: resource 16 [mem 0x000e4000-0x000e7fff window]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:00: resource 17 [mem 0x000e8000-0x000ebfff window]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:00: resource 18 [mem 0x000ec000-0x000effff window]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:00: resource 19 [mem 0x000f0000-0x000fffff window]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:00: resource 20 [mem 0x80000000-0xfeafffff window]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:00: resource 21 [mem 0x4000000000-0x7fffffffff window]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:01: resource 0 [io  0x4000-0x4fff]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:01: resource 1 [mem 0x82600000-0x826fffff]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:01: resource 2 [mem 0xb0000000-0xc01fffff 64bit pref]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:04: resource 0 [io  0x6000-0x9fff]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:04: resource 1 [mem 0x82800000-0x909fffff]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:04: resource 2 [mem 0xc0200000-0xce1fffff 64bit pref]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:05: resource 0 [io  0x6000-0x8fff]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:05: resource 1 [mem 0x82800000-0x909fffff]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:05: resource 2 [mem 0xc0200000-0xce1fffff 64bit pref]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:06: resource 1 [mem 0x82900000-0x829fffff]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:08: resource 0 [io  0x6000-0x6fff]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:08: resource 1 [mem 0x82a00000-0x899fffff]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:08: resource 2 [mem 0xc0200000-0xc71fffff 64bit pref]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:07: resource 0 [io  0x7000-0x7fff]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:07: resource 1 [mem 0x82800000-0x828fffff]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:41: resource 0 [io  0x8000-0x8fff]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:41: resource 1 [mem 0x89a00000-0x909fffff]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:41: resource 2 [mem 0xc7200000-0xce1fffff 64bit pref]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:7a: resource 0 [io  0xa000-0xdfff]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:7a: resource 1 [mem 0x90a00000-0x9ebfffff]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:7a: resource 2 [mem 0xce200000-0xdc1fffff 64bit pref]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:7b: resource 0 [io  0xa000-0xcfff]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:7b: resource 1 [mem 0x90a00000-0x9ebfffff]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:7b: resource 2 [mem 0xce200000-0xdc1fffff 64bit pref]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:7c: resource 1 [mem 0x90b00000-0x90bfffff]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:7e: resource 0 [io  0xa000-0xafff]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:7e: resource 1 [mem 0x90c00000-0x97bfffff]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:7e: resource 2 [mem 0xce200000-0xd51fffff 64bit pref]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:7d: resource 0 [io  0xb000-0xbfff]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:7d: resource 1 [mem 0x90a00000-0x90afffff]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:b7: resource 0 [io  0xc000-0xcfff]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:b7: resource 1 [mem 0x97c00000-0x9ebfffff]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:b7: resource 2 [mem 0xd5200000-0xdc1fffff 64bit pref]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:02: resource 0 [io  0x3000-0x3fff]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:02: resource 1 [mem 0x82500000-0x825fffff]
[Tue Apr 10 10:19:42 2018] pci_bus 0000:03: resource 1 [mem 0x82000000-0x824fffff]
[Tue Apr 10 10:19:42 2018] NET: Registered protocol family 2
[Tue Apr 10 10:19:42 2018] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5, 131072 bytes)
[Tue Apr 10 10:19:42 2018] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
[Tue Apr 10 10:19:42 2018] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[Tue Apr 10 10:19:42 2018] TCP: Hash tables configured (established 131072 bind 65536)
[Tue Apr 10 10:19:42 2018] UDP hash table entries: 8192 (order: 6, 262144 bytes)
[Tue Apr 10 10:19:42 2018] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes)
[Tue Apr 10 10:19:42 2018] NET: Registered protocol family 1
[Tue Apr 10 10:19:42 2018] pci 0000:07:00.0: enabling device (0000 -> 0002)
[Tue Apr 10 10:19:42 2018] pci 0000:7d:00.0: enabling device (0000 -> 0002)
[Tue Apr 10 10:19:42 2018] PCI: CLS 256 bytes, default 64
[Tue Apr 10 10:19:42 2018] Unpacking initramfs...
[Tue Apr 10 10:19:43 2018] Freeing initrd memory: 50568K
[Tue Apr 10 10:19:43 2018] DMAR: ACPI device "device:91" under DMAR at fed91000 as 00:15.0
[Tue Apr 10 10:19:43 2018] DMAR: ACPI device "device:92" under DMAR at fed91000 as 00:1e.2
[Tue Apr 10 10:19:43 2018] DMAR: ACPI device "device:93" under DMAR at fed91000 as 00:1e.3
[Tue Apr 10 10:19:43 2018] DMAR: Failed to find handle for ACPI object \_SB.PCI0.UA00
[Tue Apr 10 10:19:43 2018] DMAR: Failed to find handle for ACPI object \_SB.PCI0.UA01
[Tue Apr 10 10:19:43 2018] DMAR: Failed to find handle for ACPI object \_SB.PCI0.UA02
[Tue Apr 10 10:19:43 2018] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[Tue Apr 10 10:19:43 2018] software IO TLB [mem 0x6be31000-0x6fe31000] (64MB) mapped at [000000004300d944-0000000011bb9122]
[Tue Apr 10 10:19:43 2018] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x29dc05e54fc, max_idle_ns: 440795291716 ns
[Tue Apr 10 10:19:43 2018] clocksource: Switched to clocksource tsc
[Tue Apr 10 10:19:43 2018] Scanning for low memory corruption every 60 seconds
[Tue Apr 10 10:19:43 2018] Initialise system trusted keyrings
[Tue Apr 10 10:19:43 2018] Key type blacklist registered
[Tue Apr 10 10:19:43 2018] workingset: timestamp_bits=36 max_order=22 bucket_order=0
[Tue Apr 10 10:19:43 2018] zbud: loaded
[Tue Apr 10 10:19:43 2018] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[Tue Apr 10 10:19:43 2018] fuse init (API version 7.26)
[Tue Apr 10 10:19:43 2018] Key type asymmetric registered
[Tue Apr 10 10:19:43 2018] Asymmetric key parser 'x509' registered
[Tue Apr 10 10:19:43 2018] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 246)
[Tue Apr 10 10:19:43 2018] io scheduler noop registered
[Tue Apr 10 10:19:43 2018] io scheduler deadline registered
[Tue Apr 10 10:19:43 2018] io scheduler cfq registered (default)
[Tue Apr 10 10:19:43 2018] pciehp 0000:05:01.0:pcie204: Slot #1 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ LLActRep+
[Tue Apr 10 10:19:43 2018] pciehp 0000:05:02.0:pcie204: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ LLActRep+
[Tue Apr 10 10:19:43 2018] pciehp 0000:05:02.0:pcie204: Slot(0): Card present
[Tue Apr 10 10:19:43 2018] pciehp 0000:05:04.0:pcie204: Slot #4 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ LLActRep+
[Tue Apr 10 10:19:43 2018] pciehp 0000:7b:01.0:pcie204: Slot #1 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ LLActRep+
[Tue Apr 10 10:19:43 2018] pciehp 0000:7b:02.0:pcie204: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ LLActRep+
[Tue Apr 10 10:19:43 2018] pciehp 0000:7b:02.0:pcie204: Slot(0-1): Card present
[Tue Apr 10 10:19:43 2018] pciehp 0000:7b:04.0:pcie204: Slot #4 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ LLActRep+
[Tue Apr 10 10:19:43 2018] efifb: probing for efifb
[Tue Apr 10 10:19:43 2018] efifb: framebuffer at 0xb0300000, using 29440k, total 29440k
[Tue Apr 10 10:19:43 2018] efifb: mode is 3360x2100x32, linelength=14336, pages=1
[Tue Apr 10 10:19:43 2018] efifb: scrolling: redraw
[Tue Apr 10 10:19:43 2018] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[Tue Apr 10 10:19:43 2018] Console: switching to colour frame buffer device 420x131
[Tue Apr 10 10:19:43 2018] fb0: EFI VGA frame buffer device
[Tue Apr 10 10:19:43 2018] intel_idle: MWAIT substates: 0x11142120
[Tue Apr 10 10:19:43 2018] intel_idle: v0.4.1 model 0x9E
[Tue Apr 10 10:19:43 2018] intel_idle: lapic_timer_reliable_states 0xffffffff
[Tue Apr 10 10:19:43 2018] ACPI: AC Adapter [ADP1] (on-line)
[Tue Apr 10 10:19:43 2018] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input0
[Tue Apr 10 10:19:43 2018] ACPI: Lid Switch [LID0]
[Tue Apr 10 10:19:43 2018] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
[Tue Apr 10 10:19:43 2018] ACPI: Power Button [PWRB]
[Tue Apr 10 10:19:43 2018] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input2
[Tue Apr 10 10:19:43 2018] ACPI: Sleep Button [SLPB]
[Tue Apr 10 10:19:43 2018] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[Tue Apr 10 10:19:43 2018] ACPI: Power Button [PWRF]
[Tue Apr 10 10:19:43 2018] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[Tue Apr 10 10:19:43 2018] Linux agpgart interface v0.103
[Tue Apr 10 10:19:43 2018] loop: module loaded
[Tue Apr 10 10:19:43 2018] nvme nvme0: pci function 0000:02:00.0
[Tue Apr 10 10:19:43 2018] libphy: Fixed MDIO Bus: probed
[Tue Apr 10 10:19:43 2018] tun: Universal TUN/TAP device driver, 1.6
[Tue Apr 10 10:19:43 2018] PPP generic driver version 2.4.2
[Tue Apr 10 10:19:43 2018] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[Tue Apr 10 10:19:43 2018] ehci-pci: EHCI PCI platform driver
[Tue Apr 10 10:19:43 2018] ehci-platform: EHCI generic platform driver
[Tue Apr 10 10:19:43 2018] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[Tue Apr 10 10:19:43 2018] ohci-pci: OHCI PCI platform driver
[Tue Apr 10 10:19:43 2018] ohci-platform: OHCI generic platform driver
[Tue Apr 10 10:19:43 2018] uhci_hcd: USB Universal Host Controller Interface driver
[Tue Apr 10 10:19:43 2018] xhci_hcd 0000:00:14.0: xHCI Host Controller
[Tue Apr 10 10:19:43 2018] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[Tue Apr 10 10:19:43 2018] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x00109810
[Tue Apr 10 10:19:43 2018] xhci_hcd 0000:00:14.0: cache line size of 256 is not supported
[Tue Apr 10 10:19:43 2018] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[Tue Apr 10 10:19:43 2018] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[Tue Apr 10 10:19:43 2018] usb usb1: Product: xHCI Host Controller
[Tue Apr 10 10:19:43 2018] usb usb1: Manufacturer: Linux 4.16.1-041601-generic xhci-hcd
[Tue Apr 10 10:19:43 2018] usb usb1: SerialNumber: 0000:00:14.0
[Tue Apr 10 10:19:43 2018] hub 1-0:1.0: USB hub found
[Tue Apr 10 10:19:43 2018] hub 1-0:1.0: 16 ports detected
[Tue Apr 10 10:19:43 2018] xhci_hcd 0000:00:14.0: xHCI Host Controller
[Tue Apr 10 10:19:43 2018] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[Tue Apr 10 10:19:43 2018] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003
[Tue Apr 10 10:19:43 2018] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[Tue Apr 10 10:19:43 2018] usb usb2: Product: xHCI Host Controller
[Tue Apr 10 10:19:43 2018] usb usb2: Manufacturer: Linux 4.16.1-041601-generic xhci-hcd
[Tue Apr 10 10:19:43 2018] usb usb2: SerialNumber: 0000:00:14.0
[Tue Apr 10 10:19:43 2018] hub 2-0:1.0: USB hub found
[Tue Apr 10 10:19:43 2018] hub 2-0:1.0: 8 ports detected
[Tue Apr 10 10:19:43 2018] xhci_hcd 0000:07:00.0: xHCI Host Controller
[Tue Apr 10 10:19:43 2018] xhci_hcd 0000:07:00.0: new USB bus registered, assigned bus number 3
[Tue Apr 10 10:19:43 2018] xhci_hcd 0000:07:00.0: hcc params 0x200077c1 hci version 0x110 quirks 0x00009810
[Tue Apr 10 10:19:43 2018] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
[Tue Apr 10 10:19:43 2018] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[Tue Apr 10 10:19:43 2018] usb usb3: Product: xHCI Host Controller
[Tue Apr 10 10:19:43 2018] usb usb3: Manufacturer: Linux 4.16.1-041601-generic xhci-hcd
[Tue Apr 10 10:19:43 2018] usb usb3: SerialNumber: 0000:07:00.0
[Tue Apr 10 10:19:43 2018] hub 3-0:1.0: USB hub found
[Tue Apr 10 10:19:43 2018] hub 3-0:1.0: 2 ports detected
[Tue Apr 10 10:19:43 2018] xhci_hcd 0000:07:00.0: xHCI Host Controller
[Tue Apr 10 10:19:43 2018] xhci_hcd 0000:07:00.0: new USB bus registered, assigned bus number 4
[Tue Apr 10 10:19:43 2018] xhci_hcd 0000:07:00.0: Host supports USB 3.1 Enhanced SuperSpeed
[Tue Apr 10 10:19:43 2018] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003
[Tue Apr 10 10:19:43 2018] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[Tue Apr 10 10:19:43 2018] usb usb4: Product: xHCI Host Controller
[Tue Apr 10 10:19:43 2018] usb usb4: Manufacturer: Linux 4.16.1-041601-generic xhci-hcd
[Tue Apr 10 10:19:43 2018] usb usb4: SerialNumber: 0000:07:00.0
[Tue Apr 10 10:19:43 2018] hub 4-0:1.0: USB hub found
[Tue Apr 10 10:19:43 2018] hub 4-0:1.0: 2 ports detected
[Tue Apr 10 10:19:43 2018] xhci_hcd 0000:7d:00.0: xHCI Host Controller
[Tue Apr 10 10:19:43 2018] xhci_hcd 0000:7d:00.0: new USB bus registered, assigned bus number 5
[Tue Apr 10 10:19:43 2018] xhci_hcd 0000:7d:00.0: hcc params 0x200077c1 hci version 0x110 quirks 0x00009810
[Tue Apr 10 10:19:43 2018] usb usb5: New USB device found, idVendor=1d6b, idProduct=0002
[Tue Apr 10 10:19:43 2018] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[Tue Apr 10 10:19:43 2018] usb usb5: Product: xHCI Host Controller
[Tue Apr 10 10:19:43 2018] usb usb5: Manufacturer: Linux 4.16.1-041601-generic xhci-hcd
[Tue Apr 10 10:19:43 2018] usb usb5: SerialNumber: 0000:7d:00.0
[Tue Apr 10 10:19:43 2018] hub 5-0:1.0: USB hub found
[Tue Apr 10 10:19:43 2018] hub 5-0:1.0: 2 ports detected
[Tue Apr 10 10:19:43 2018] xhci_hcd 0000:7d:00.0: xHCI Host Controller
[Tue Apr 10 10:19:43 2018] xhci_hcd 0000:7d:00.0: new USB bus registered, assigned bus number 6
[Tue Apr 10 10:19:43 2018] xhci_hcd 0000:7d:00.0: Host supports USB 3.1 Enhanced SuperSpeed
[Tue Apr 10 10:19:43 2018] usb usb6: New USB device found, idVendor=1d6b, idProduct=0003
[Tue Apr 10 10:19:43 2018] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[Tue Apr 10 10:19:43 2018] usb usb6: Product: xHCI Host Controller
[Tue Apr 10 10:19:43 2018] usb usb6: Manufacturer: Linux 4.16.1-041601-generic xhci-hcd
[Tue Apr 10 10:19:43 2018] usb usb6: SerialNumber: 0000:7d:00.0
[Tue Apr 10 10:19:43 2018] hub 6-0:1.0: USB hub found
[Tue Apr 10 10:19:43 2018] hub 6-0:1.0: 2 ports detected
[Tue Apr 10 10:19:43 2018] i8042: PNP: No PS/2 controller found.
[Tue Apr 10 10:19:43 2018] mousedev: PS/2 mouse device common for all mice
[Tue Apr 10 10:19:43 2018] rtc_cmos 00:01: RTC can wake from S4
[Tue Apr 10 10:19:43 2018] rtc_cmos 00:01: rtc core: registered rtc_cmos as rtc0
[Tue Apr 10 10:19:43 2018] rtc_cmos 00:01: alarms up to one month, y3k, 242 bytes nvram, hpet irqs
[Tue Apr 10 10:19:43 2018] i2c /dev entries driver
[Tue Apr 10 10:19:43 2018] device-mapper: uevent: version 1.0.3
[Tue Apr 10 10:19:43 2018] device-mapper: ioctl: 4.37.0-ioctl (2017-09-20) initialised: dm-devel@redhat.com
[Tue Apr 10 10:19:43 2018] intel_pstate: Intel P-state driver initializing
[Tue Apr 10 10:19:43 2018] intel_pstate: Disabling energy efficiency optimization
[Tue Apr 10 10:19:43 2018] intel_pstate: HWP enabled
[Tue Apr 10 10:19:43 2018] ledtrig-cpu: registered to indicate activity on CPUs
[Tue Apr 10 10:19:43 2018] EFI Variables Facility v0.08 2004-May-17
[Tue Apr 10 10:19:43 2018]  nvme0n1: p1 p2 p3 p4 p5 p6
[Tue Apr 10 10:19:43 2018] intel_pmc_core:  initialized
[Tue Apr 10 10:19:43 2018] NET: Registered protocol family 10
[Tue Apr 10 10:19:43 2018] NET: Registered protocol family 17
[Tue Apr 10 10:19:43 2018] Key type dns_resolver registered
[Tue Apr 10 10:19:43 2018] RAS: Correctable Errors collector initialized.
[Tue Apr 10 10:19:43 2018] microcode: sig=0x906e9, pf=0x20, revision=0x84
[Tue Apr 10 10:19:43 2018] microcode: Microcode Update Driver: v2.2.
[Tue Apr 10 10:19:43 2018] sched_clock: Marking stable (1390251953, 0)->(1376339540, 13912413)
[Tue Apr 10 10:19:43 2018] registered taskstats version 1
[Tue Apr 10 10:19:43 2018] Loading compiled-in X.509 certificates
[Tue Apr 10 10:19:43 2018] Loaded X.509 cert 'Build time autogenerated kernel key: 8bcc62b77e71ce7d8541bc53eca9c2389b42524d'
[Tue Apr 10 10:19:43 2018] zswap: loaded using pool lzo/zbud
[Tue Apr 10 10:19:43 2018] Key type big_key registered
[Tue Apr 10 10:19:43 2018] Key type trusted registered
[Tue Apr 10 10:19:43 2018] Key type encrypted registered
[Tue Apr 10 10:19:43 2018] AppArmor: AppArmor sha1 policy hashing enabled
[Tue Apr 10 10:19:43 2018] ima: No TPM chip found, activating TPM-bypass! (rc=-19)
[Tue Apr 10 10:19:43 2018] evm: HMAC attrs: 0x1
[Tue Apr 10 10:19:43 2018]   Magic number: 14:854:320
[Tue Apr 10 10:19:43 2018] misc microcode: hash matches
[Tue Apr 10 10:19:43 2018] platform microcode: hash matches
[Tue Apr 10 10:19:43 2018] tty tty45: hash matches
[Tue Apr 10 10:19:43 2018] rtc_cmos 00:01: setting system clock to 2018-04-10 08:19:43 UTC (1523348383)
[Tue Apr 10 10:19:43 2018] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[Tue Apr 10 10:19:43 2018] EDD information not available.
[Tue Apr 10 10:19:43 2018] Freeing unused kernel memory: 2404K
[Tue Apr 10 10:19:43 2018] Write protecting the kernel read-only data: 20480k
[Tue Apr 10 10:19:43 2018] Freeing unused kernel memory: 2008K
[Tue Apr 10 10:19:43 2018] Freeing unused kernel memory: 1900K
[Tue Apr 10 10:19:43 2018] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[Tue Apr 10 10:19:43 2018] x86/mm: Checking user space page tables
[Tue Apr 10 10:19:43 2018] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[Tue Apr 10 10:19:43 2018] [Firmware Bug]: ACPI(GFX0) defines _DOD but not _DOS
[Tue Apr 10 10:19:43 2018] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[Tue Apr 10 10:19:43 2018] acpi device:02: registered as cooling_device8
[Tue Apr 10 10:19:43 2018] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:01/LNXVIDEO:00/input/input4
[Tue Apr 10 10:19:43 2018] applespi: loading out-of-tree module taints kernel.
[Tue Apr 10 10:19:43 2018] applespi: module verification failed: signature and/or required key missing - tainting kernel
[Tue Apr 10 10:19:43 2018] thunderbolt 0000:06:00.0: NHI initialized, starting thunderbolt
[Tue Apr 10 10:19:43 2018] thunderbolt 0000:06:00.0: allocating TX ring 0 of size 10
[Tue Apr 10 10:19:43 2018] thunderbolt 0000:06:00.0: allocating RX ring 0 of size 10
[Tue Apr 10 10:19:43 2018] thunderbolt 0000:06:00.0: control channel created
[Tue Apr 10 10:19:43 2018] thunderbolt 0000:06:00.0: control channel starting...
[Tue Apr 10 10:19:43 2018] thunderbolt 0000:06:00.0: starting TX ring 0
[Tue Apr 10 10:19:43 2018] thunderbolt 0000:06:00.0: enabling interrupt at register 0x38200 bit 0 (0x0 -> 0x1)
[Tue Apr 10 10:19:43 2018] thunderbolt 0000:06:00.0: starting RX ring 0
[Tue Apr 10 10:19:43 2018] thunderbolt 0000:06:00.0: enabling interrupt at register 0x38200 bit 12 (0x1 -> 0x1001)
[Tue Apr 10 10:19:43 2018] thunderbolt 0000:06:00.0: starting ICM firmware
[Tue Apr 10 10:19:43 2018] cryptd: max_cpu_qlen set to 1000
[Tue Apr 10 10:19:43 2018] AVX2 version of gcm_enc/dec engaged.
[Tue Apr 10 10:19:43 2018] AES CTR mode by8 optimization enabled
[Tue Apr 10 10:19:43 2018] usb 1-2: new high-speed USB device number 2 using xhci_hcd
[Tue Apr 10 10:19:43 2018] intel-lpss 0000:00:15.0: enabling device (0000 -> 0002)
[Tue Apr 10 10:19:43 2018] intel-lpss 0000:00:19.0: enabling device (0000 -> 0002)
[Tue Apr 10 10:19:43 2018] intel-lpss 0000:00:1e.0: enabling device (0000 -> 0002)
[Tue Apr 10 10:19:43 2018] [drm] amdgpu kernel modesetting enabled.
[Tue Apr 10 10:19:43 2018] AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
[Tue Apr 10 10:19:43 2018] AMD IOMMUv2 functionality not available on this system
[Tue Apr 10 10:19:43 2018] CRAT table not found
[Tue Apr 10 10:19:43 2018] Virtual CRAT table created for CPU
[Tue Apr 10 10:19:43 2018] Parsing CRAT table with 1 nodes
[Tue Apr 10 10:19:43 2018] Creating topology SYSFS entries
[Tue Apr 10 10:19:43 2018] Topology: Add CPU node
[Tue Apr 10 10:19:43 2018] Finished initializing topology
[Tue Apr 10 10:19:43 2018] kfd kfd: Initialized module
[Tue Apr 10 10:19:43 2018] checking generic (b0300000 1cc0000) vs hw (b0000000 10000000)
[Tue Apr 10 10:19:43 2018] fb: switching to amdgpudrmfb from EFI VGA
[Tue Apr 10 10:19:43 2018] Console: switching to colour dummy device 80x25
[Tue Apr 10 10:19:43 2018] [drm] initializing kernel modesetting (POLARIS11 0x1002:0x67EF 0x106B:0x0179 0xC0).
[Tue Apr 10 10:19:43 2018] [drm] register mmio base: 0x82600000
[Tue Apr 10 10:19:43 2018] [drm] register mmio size: 262144
[Tue Apr 10 10:19:43 2018] [drm] probing gen 2 caps for device 8086:1901 = 261ac83/e
[Tue Apr 10 10:19:43 2018] [drm] probing mlw for device 8086:1901 = 261ac83
[Tue Apr 10 10:19:43 2018] [drm] UVD is enabled in VM mode
[Tue Apr 10 10:19:43 2018] [drm] UVD ENC is enabled in VM mode
[Tue Apr 10 10:19:43 2018] [drm] VCE enabled in VM mode
[Tue Apr 10 10:19:43 2018] ATOM BIOS: 113-C9801AU-A02
[Tue Apr 10 10:19:43 2018] [drm] vm size is 64 GB, 2 levels, block size is 10-bit, fragment size is 9-bit
[Tue Apr 10 10:19:43 2018] amdgpu 0000:01:00.0: BAR 2: releasing [mem 0xc0000000-0xc01fffff 64bit pref]
[Tue Apr 10 10:19:43 2018] amdgpu 0000:01:00.0: BAR 0: releasing [mem 0xb0000000-0xbfffffff 64bit pref]
[Tue Apr 10 10:19:43 2018] amdgpu 0000:01:00.0: BAR 0: assigned [mem 0xb0000000-0xbfffffff 64bit pref]
[Tue Apr 10 10:19:43 2018] amdgpu 0000:01:00.0: BAR 2: assigned [mem 0xc0000000-0xc01fffff 64bit pref]
[Tue Apr 10 10:19:43 2018] amdgpu 0000:01:00.0: VRAM: 4096M 0x000000F400000000 - 0x000000F4FFFFFFFF (4096M used)
[Tue Apr 10 10:19:43 2018] amdgpu 0000:01:00.0: GTT: 256M 0x0000000000000000 - 0x000000000FFFFFFF
[Tue Apr 10 10:19:43 2018] [drm] Detected VRAM RAM=4096M, BAR=256M
[Tue Apr 10 10:19:43 2018] [drm] RAM width 128bits GDDR5
[Tue Apr 10 10:19:43 2018] [TTM] Zone  kernel: Available graphics memory: 8160234 kiB
[Tue Apr 10 10:19:43 2018] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[Tue Apr 10 10:19:43 2018] [TTM] Initializing pool allocator
[Tue Apr 10 10:19:43 2018] [TTM] Initializing DMA pool allocator
[Tue Apr 10 10:19:43 2018] [drm] amdgpu: 4096M of VRAM memory ready
[Tue Apr 10 10:19:43 2018] [drm] amdgpu: 4096M of GTT memory ready.
[Tue Apr 10 10:19:43 2018] [drm] GART: num cpu pages 65536, num gpu pages 65536
[Tue Apr 10 10:19:43 2018] [drm] PCIE GART of 256M enabled (table at 0x000000F400040000).
[Tue Apr 10 10:19:43 2018] amdgpu 0000:01:00.0: Direct firmware load for amdgpu/polaris11_pfp_2.bin failed with error -2
[Tue Apr 10 10:19:43 2018] amdgpu 0000:01:00.0: Direct firmware load for amdgpu/polaris11_me_2.bin failed with error -2
[Tue Apr 10 10:19:43 2018] amdgpu 0000:01:00.0: Direct firmware load for amdgpu/polaris11_ce_2.bin failed with error -2
[Tue Apr 10 10:19:43 2018] amdgpu 0000:01:00.0: Direct firmware load for amdgpu/polaris11_mec_2.bin failed with error -2
[Tue Apr 10 10:19:43 2018] amdgpu 0000:01:00.0: Direct firmware load for amdgpu/polaris11_mec2_2.bin failed with error -2
[Tue Apr 10 10:19:43 2018] [drm] Found UVD firmware Version: 1.79 Family ID: 16
[Tue Apr 10 10:19:43 2018] [drm] UVD ENC is disabled
[Tue Apr 10 10:19:43 2018] [drm] Found VCE firmware Version: 52.4 Binary ID: 3
[Tue Apr 10 10:19:43 2018] intel-lpss 0000:00:1e.1: enabling device (0000 -> 0002)
[Tue Apr 10 10:19:43 2018] intel-lpss 0000:00:1e.2: enabling device (0000 -> 0002)
[Tue Apr 10 10:19:43 2018] intel-lpss 0000:00:1e.3: enabling device (0000 -> 0002)
[Tue Apr 10 10:19:43 2018] amdgpu: [powerplay] 
                            failed to send message 309 ret is 254 
[Tue Apr 10 10:19:43 2018] amdgpu: [powerplay] 
                            failed to send pre message 14e ret is 254 
[Tue Apr 10 10:19:43 2018] [drm] DM_PPLIB: values for Engine clock
[Tue Apr 10 10:19:43 2018] [drm] DM_PPLIB:	 21400
[Tue Apr 10 10:19:43 2018] [drm] DM_PPLIB:	 32000
[Tue Apr 10 10:19:43 2018] [drm] DM_PPLIB:	 43600
[Tue Apr 10 10:19:43 2018] [drm] DM_PPLIB:	 55600
[Tue Apr 10 10:19:43 2018] [drm] DM_PPLIB:	 67100
[Tue Apr 10 10:19:43 2018] [drm] DM_PPLIB:	 75600
[Tue Apr 10 10:19:43 2018] [drm] DM_PPLIB:	 83800
[Tue Apr 10 10:19:43 2018] [drm] DM_PPLIB:	 90700
[Tue Apr 10 10:19:43 2018] [drm] DM_PPLIB: Validation clocks:
[Tue Apr 10 10:19:43 2018] [drm] DM_PPLIB:    engine_max_clock: 90700
[Tue Apr 10 10:19:43 2018] [drm] DM_PPLIB:    memory_max_clock: 127000
[Tue Apr 10 10:19:43 2018] [drm] DM_PPLIB:    level           : 0
[Tue Apr 10 10:19:43 2018] [drm] DM_PPLIB: values for Memory clock
[Tue Apr 10 10:19:43 2018] [drm] DM_PPLIB:	 30000
[Tue Apr 10 10:19:43 2018] [drm] DM_PPLIB:	 127000
[Tue Apr 10 10:19:43 2018] [drm] DM_PPLIB: Validation clocks:
[Tue Apr 10 10:19:43 2018] [drm] DM_PPLIB:    engine_max_clock: 90700
[Tue Apr 10 10:19:43 2018] [drm] DM_PPLIB:    memory_max_clock: 127000
[Tue Apr 10 10:19:43 2018] [drm] DM_PPLIB:    level           : 0
[Tue Apr 10 10:19:43 2018] usb 1-2: New USB device found, idVendor=0451, idProduct=8142
[Tue Apr 10 10:19:43 2018] usb 1-2: New USB device strings: Mfr=0, Product=0, SerialNumber=1
[Tue Apr 10 10:19:43 2018] usb 1-2: SerialNumber: FE05108975C5
[Tue Apr 10 10:19:43 2018] hub 1-2:1.0: USB hub found
[Tue Apr 10 10:19:43 2018] hub 1-2:1.0: 4 ports detected
[Tue Apr 10 10:19:43 2018] input: Apple SPI Keyboard as /devices/pci0000:00/0000:00:1e.3/pxa2xx-spi.5/spi_master/spi2/spi-APP000D:00/input/input5
[Tue Apr 10 10:19:43 2018] input: Apple SPI Touchpad as /devices/pci0000:00/0000:00:1e.3/pxa2xx-spi.5/spi_master/spi2/spi-APP000D:00/input/input6
[Tue Apr 10 10:19:43 2018] applespi: spi-device probe done: spi-APP000D:00
[Tue Apr 10 10:19:43 2018] applespi: modeswitch done.
[Tue Apr 10 10:19:43 2018] [drm] Display Core initialized with v3.1.27!
[Tue Apr 10 10:19:43 2018] [drm] SADs count is: -2, don't need to read it
[Tue Apr 10 10:19:43 2018] usb 1-7: new high-speed USB device number 3 using xhci_hcd
[Tue Apr 10 10:19:43 2018] usb 1-7: New USB device found, idVendor=2357, idProduct=010c
[Tue Apr 10 10:19:43 2018] usb 1-7: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[Tue Apr 10 10:19:43 2018] usb 1-7: Product: 802.11n NIC
[Tue Apr 10 10:19:43 2018] usb 1-7: Manufacturer: Realtek
[Tue Apr 10 10:19:43 2018] usb 1-7: SerialNumber: 00E04C0001
[Tue Apr 10 10:19:43 2018] 8188eu: version magic '4.16.0-041600-generic SMP mod_unload ' should be '4.16.1-041601-generic SMP mod_unload '
[Tue Apr 10 10:19:43 2018] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[Tue Apr 10 10:19:43 2018] [drm] Driver supports precise vblank timestamp query.
[Tue Apr 10 10:19:43 2018] usb 1-2.1: new high-speed USB device number 4 using xhci_hcd
[Tue Apr 10 10:19:44 2018] [drm] UVD initialized successfully.
[Tue Apr 10 10:19:44 2018] usb 1-2.1: New USB device found, idVendor=2109, idProduct=2811
[Tue Apr 10 10:19:44 2018] usb 1-2.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[Tue Apr 10 10:19:44 2018] usb 1-2.1: Product: USB2.0 Hub             
[Tue Apr 10 10:19:44 2018] usb 1-2.1: Manufacturer: VIA Labs, Inc.         
[Tue Apr 10 10:19:44 2018] hub 1-2.1:1.0: USB hub found
[Tue Apr 10 10:19:44 2018] hub 1-2.1:1.0: 4 ports detected
[Tue Apr 10 10:19:44 2018] [drm] VCE initialized successfully.
[Tue Apr 10 10:19:44 2018] usb 1-2.3: new high-speed USB device number 5 using xhci_hcd
[Tue Apr 10 10:19:44 2018] usb 1-2.3: New USB device found, idVendor=17ef, idProduct=4824
[Tue Apr 10 10:19:44 2018] usb 1-2.3: New USB device strings: Mfr=3, Product=1, SerialNumber=2
[Tue Apr 10 10:19:44 2018] usb 1-2.3: Product: FULL HD 1080P Webcam
[Tue Apr 10 10:19:44 2018] usb 1-2.3: Manufacturer: Generic
[Tue Apr 10 10:19:44 2018] usb 1-2.3: SerialNumber: 200901010001
[Tue Apr 10 10:19:44 2018] usb 1-2.4: new full-speed USB device number 6 using xhci_hcd
[Tue Apr 10 10:19:44 2018] [drm] fb mappable at 0xB03F2000
[Tue Apr 10 10:19:44 2018] [drm] vram apper at 0xB0000000
[Tue Apr 10 10:19:44 2018] [drm] size 33177600
[Tue Apr 10 10:19:44 2018] [drm] fb depth is 24
[Tue Apr 10 10:19:44 2018] [drm]    pitch is 15360
[Tue Apr 10 10:19:44 2018] fbcon: amdgpudrmfb (fb0) is primary device
[Tue Apr 10 10:19:44 2018] usb 1-2.4: New USB device found, idVendor=0451, idProduct=3421
[Tue Apr 10 10:19:44 2018] usb 1-2.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[Tue Apr 10 10:19:44 2018] usb 1-2.4: Product: Texas Instruments USB Billboard Device
[Tue Apr 10 10:19:44 2018] usb 1-2.4: Manufacturer: Texas Instruments Inc.
[Tue Apr 10 10:19:44 2018] usb 1-2.4: SerialNumber: 8CFF59CD08152152
[Tue Apr 10 10:19:44 2018] Console: switching to colour frame buffer device 360x112
[Tue Apr 10 10:19:44 2018] amdgpu 0000:01:00.0: fb0: amdgpudrmfb frame buffer device
[Tue Apr 10 10:19:44 2018] usb 1-3: new high-speed USB device number 7 using xhci_hcd
[Tue Apr 10 10:19:44 2018] [drm] Initialized amdgpu 3.23.0 20150101 for 0000:01:00.0 on minor 0
[Tue Apr 10 10:19:44 2018] usb 1-3: New USB device found, idVendor=05ac, idProduct=8600
[Tue Apr 10 10:19:44 2018] usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[Tue Apr 10 10:19:44 2018] usb 1-3: Product: iBridge
[Tue Apr 10 10:19:44 2018] usb 1-3: Manufacturer: Apple Inc.
[Tue Apr 10 10:19:44 2018] hidraw: raw HID events driver (C) Jiri Kosina
[Tue Apr 10 10:19:44 2018] usbcore: registered new interface driver usbhid
[Tue Apr 10 10:19:44 2018] usbhid: USB HID core driver
[Tue Apr 10 10:19:44 2018] hid-generic 0003:0451:3421.0001: hiddev0,hidraw0: USB HID v1.11 Device [Texas Instruments Inc. Texas Instruments USB Billboard Device] on usb-0000:00:14.0-2.4/input1
[Tue Apr 10 10:19:44 2018] input: Apple Inc. iBridge as /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3:1.2/0003:05AC:8600.0002/input/input7
[Tue Apr 10 10:19:44 2018] hid-generic 0003:05AC:8600.0002: input,hidraw1: USB HID v1.01 Keyboard [Apple Inc. iBridge] on usb-0000:00:14.0-3/input2
[Tue Apr 10 10:19:44 2018] hid-generic 0003:05AC:8600.0003: hiddev1,hidraw2: USB HID v1.01 Device [Apple Inc. iBridge] on usb-0000:00:14.0-3/input3
[Tue Apr 10 10:19:45 2018] input: Apple Inc. iBridge as /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3:1.2/0003:05AC:8600.0002/input/input8
[Tue Apr 10 10:19:45 2018] apple-touchbar 0003:05AC:8600.0002: input,hidraw1: USB HID v1.01 Keyboard [Apple Inc. iBridge] on usb-0000:00:14.0-3/input2
[Tue Apr 10 10:19:45 2018] apple-touchbar 0003:05AC:8600.0002: module probe done.
[Tue Apr 10 10:19:45 2018] apple-touchbar 0003:05AC:8600.0003: hiddev1,hidraw2: USB HID v1.01 Device [Apple Inc. iBridge] on usb-0000:00:14.0-3/input3
[Tue Apr 10 10:19:45 2018] apple-touchbar 0003:05AC:8600.0003: module probe done.
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:06:00.0: current switch config:
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:06:00.0:  Switch: 8086:15d3 (Revision: 6, TB Version: 2)
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:06:00.0:   Max Port Number: 11
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:06:00.0:   Config:
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:06:00.0:    Upstream Port Number: 5 Depth: 0 Route String: 0x0 Enabled: 1, PlugEventsDelay: 254ms
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:06:00.0:    unknown1: 0x0 unknown4: 0x0
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:06:00.0: 0: uid: 0x1b74ed5505400
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:06:00.0:  Port 0: 8086:15d3 (Revision: 6, TB Version: 1, Type: Port (0x1))
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:06:00.0:   Max hop id (in/out): 7/7
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:06:00.0:   Max counters: 8
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:06:00.0:   NFC Credits: 0x800000
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:06:00.0:  Port 1: 8086:15d3 (Revision: 6, TB Version: 1, Type: Port (0x1))
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:06:00.0:   Max hop id (in/out): 15/15
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:06:00.0:   Max counters: 16
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:06:00.0:   NFC Credits: 0x3c00000
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:06:00.0:  Port 2: 8086:15d3 (Revision: 6, TB Version: 1, Type: Port (0x1))
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:06:00.0:   Max hop id (in/out): 15/15
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:06:00.0:   Max counters: 16
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:06:00.0:   NFC Credits: 0x3c00000
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:06:00.0:  Port 3: 8086:15d3 (Revision: 6, TB Version: 1, Type: Port (0x1))
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:06:00.0:   Max hop id (in/out): 15/15
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:06:00.0:   Max counters: 16
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:06:00.0:   NFC Credits: 0x3c00000
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:06:00.0:  Port 4: 8086:15d3 (Revision: 6, TB Version: 1, Type: Port (0x1))
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:06:00.0:   Max hop id (in/out): 15/15
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:06:00.0:   Max counters: 16
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:06:00.0:   NFC Credits: 0x3c00000
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:06:00.0:  Port 5: 8086:15d3 (Revision: 6, TB Version: 1, Type: NHI (0x2))
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:06:00.0:   Max hop id (in/out): 11/11
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:06:00.0:   Max counters: 16
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:06:00.0:   NFC Credits: 0x1000000
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:06:00.0:  Port 6: 8086:15d3 (Revision: 6, TB Version: 1, Type: PCIe (0x100101))
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:06:00.0:   Max hop id (in/out): 8/8
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:06:00.0:   Max counters: 2
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:06:00.0:   NFC Credits: 0x800000
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:06:00.0:  Port 7: 8086:15d3 (Revision: 6, TB Version: 1, Type: PCIe (0x100101))
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:06:00.0:   Max hop id (in/out): 8/8
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:06:00.0:   Max counters: 2
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:06:00.0:   NFC Credits: 0x800000
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:06:00.0:  Port 8: 8086:15d3 (Revision: 6, TB Version: 1, Type: DP/HDMI (0xe0102))
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:06:00.0:   Max hop id (in/out): 9/9
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:06:00.0:   Max counters: 2
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:06:00.0:   NFC Credits: 0x800000
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:06:00.0:  Port 9: 8086:15d3 (Revision: 6, TB Version: 1, Type: DP/HDMI (0xe0101))
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:06:00.0:   Max hop id (in/out): 9/9
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:06:00.0:   Max counters: 2
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:06:00.0:   NFC Credits: 0x1000000
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:06:00.0:  Port 10: 8086:15d3 (Revision: 6, TB Version: 1, Type: DP/HDMI (0xe0101))
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:06:00.0:   Max hop id (in/out): 9/9
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:06:00.0:   Max counters: 2
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:06:00.0:   NFC Credits: 0x1000000
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:06:00.0:  Port 11: 8086:15d3 (Revision: 6, TB Version: 1, Type: DP/HDMI (0xe0102))
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:06:00.0:   Max hop id (in/out): 9/9
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:06:00.0:   Max counters: 2
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:06:00.0:   NFC Credits: 0x800000
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:7c:00.0: NHI initialized, starting thunderbolt
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:7c:00.0: allocating TX ring 0 of size 10
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:7c:00.0: allocating RX ring 0 of size 10
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:7c:00.0: control channel created
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:7c:00.0: control channel starting...
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:7c:00.0: starting TX ring 0
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:7c:00.0: enabling interrupt at register 0x38200 bit 0 (0x0 -> 0x1)
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:7c:00.0: starting RX ring 0
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:7c:00.0: enabling interrupt at register 0x38200 bit 12 (0x1 -> 0x1001)
[Tue Apr 10 10:19:45 2018] thunderbolt 0000:7c:00.0: starting ICM firmware
[Tue Apr 10 10:19:46 2018] usb 1-2.4: USB disconnect, device number 6
[Tue Apr 10 10:19:46 2018] thunderbolt 0000:7c:00.0: current switch config:
[Tue Apr 10 10:19:46 2018] thunderbolt 0000:7c:00.0:  Switch: 8086:15d3 (Revision: 6, TB Version: 2)
[Tue Apr 10 10:19:46 2018] thunderbolt 0000:7c:00.0:   Max Port Number: 11
[Tue Apr 10 10:19:46 2018] thunderbolt 0000:7c:00.0:   Config:
[Tue Apr 10 10:19:46 2018] thunderbolt 0000:7c:00.0:    Upstream Port Number: 5 Depth: 0 Route String: 0x0 Enabled: 1, PlugEventsDelay: 254ms
[Tue Apr 10 10:19:46 2018] thunderbolt 0000:7c:00.0:    unknown1: 0x0 unknown4: 0x0
[Tue Apr 10 10:19:46 2018] thunderbolt 0000:7c:00.0: 0: uid: 0x1b74ed580b401
[Tue Apr 10 10:19:46 2018] thunderbolt 0000:7c:00.0:  Port 0: 8086:15d3 (Revision: 6, TB Version: 1, Type: Port (0x1))
[Tue Apr 10 10:19:46 2018] thunderbolt 0000:7c:00.0:   Max hop id (in/out): 7/7
[Tue Apr 10 10:19:46 2018] thunderbolt 0000:7c:00.0:   Max counters: 8
[Tue Apr 10 10:19:46 2018] thunderbolt 0000:7c:00.0:   NFC Credits: 0x800000
[Tue Apr 10 10:19:46 2018] thunderbolt 0000:7c:00.0:  Port 1: 8086:15d3 (Revision: 6, TB Version: 1, Type: Port (0x1))
[Tue Apr 10 10:19:46 2018] thunderbolt 0000:7c:00.0:   Max hop id (in/out): 15/15
[Tue Apr 10 10:19:46 2018] thunderbolt 0000:7c:00.0:   Max counters: 16
[Tue Apr 10 10:19:46 2018] thunderbolt 0000:7c:00.0:   NFC Credits: 0x3c00000
[Tue Apr 10 10:19:46 2018] thunderbolt 0000:7c:00.0:  Port 2: 8086:15d3 (Revision: 6, TB Version: 1, Type: Port (0x1))
[Tue Apr 10 10:19:46 2018] thunderbolt 0000:7c:00.0:   Max hop id (in/out): 15/15
[Tue Apr 10 10:19:46 2018] thunderbolt 0000:7c:00.0:   Max counters: 16
[Tue Apr 10 10:19:46 2018] thunderbolt 0000:7c:00.0:   NFC Credits: 0x3c00000
[Tue Apr 10 10:19:46 2018] thunderbolt 0000:7c:00.0:  Port 3: 8086:15d3 (Revision: 6, TB Version: 1, Type: Port (0x1))
[Tue Apr 10 10:19:46 2018] thunderbolt 0000:7c:00.0:   Max hop id (in/out): 15/15
[Tue Apr 10 10:19:46 2018] thunderbolt 0000:7c:00.0:   Max counters: 16
[Tue Apr 10 10:19:46 2018] thunderbolt 0000:7c:00.0:   NFC Credits: 0x3c00000
[Tue Apr 10 10:19:46 2018] thunderbolt 0000:7c:00.0:  Port 4: 8086:15d3 (Revision: 6, TB Version: 1, Type: Port (0x1))
[Tue Apr 10 10:19:46 2018] thunderbolt 0000:7c:00.0:   Max hop id (in/out): 15/15
[Tue Apr 10 10:19:46 2018] thunderbolt 0000:7c:00.0:   Max counters: 16
[Tue Apr 10 10:19:46 2018] thunderbolt 0000:7c:00.0:   NFC Credits: 0x3c00000
[Tue Apr 10 10:19:46 2018] thunderbolt 0000:7c:00.0:  Port 5: 8086:15d3 (Revision: 6, TB Version: 1, Type: NHI (0x2))
[Tue Apr 10 10:19:46 2018] thunderbolt 0000:7c:00.0:   Max hop id (in/out): 11/11
[Tue Apr 10 10:19:46 2018] thunderbolt 0000:7c:00.0:   Max counters: 16
[Tue Apr 10 10:19:46 2018] thunderbolt 0000:7c:00.0:   NFC Credits: 0x1000000
[Tue Apr 10 10:19:46 2018] thunderbolt 0000:7c:00.0:  Port 6: 8086:15d3 (Revision: 6, TB Version: 1, Type: PCIe (0x100101))
[Tue Apr 10 10:19:46 2018] thunderbolt 0000:7c:00.0:   Max hop id (in/out): 8/8
[Tue Apr 10 10:19:46 2018] thunderbolt 0000:7c:00.0:   Max counters: 2
[Tue Apr 10 10:19:46 2018] thunderbolt 0000:7c:00.0:   NFC Credits: 0x800000
[Tue Apr 10 10:19:46 2018] thunderbolt 0000:7c:00.0:  Port 7: 8086:15d3 (Revision: 6, TB Version: 1, Type: PCIe (0x100101))
[Tue Apr 10 10:19:46 2018] thunderbolt 0000:7c:00.0:   Max hop id (in/out): 8/8
[Tue Apr 10 10:19:46 2018] thunderbolt 0000:7c:00.0:   Max counters: 2
[Tue Apr 10 10:19:46 2018] thunderbolt 0000:7c:00.0:   NFC Credits: 0x800000
[Tue Apr 10 10:19:46 2018] thunderbolt 0000:7c:00.0:  Port 8: 8086:15d3 (Revision: 6, TB Version: 1, Type: DP/HDMI (0xe0102))
[Tue Apr 10 10:19:46 2018] thunderbolt 0000:7c:00.0:   Max hop id (in/out): 9/9
[Tue Apr 10 10:19:46 2018] thunderbolt 0000:7c:00.0:   Max counters: 2
[Tue Apr 10 10:19:46 2018] thunderbolt 0000:7c:00.0:   NFC Credits: 0x800000
[Tue Apr 10 10:19:46 2018] thunderbolt 0000:7c:00.0:  Port 9: 8086:15d3 (Revision: 6, TB Version: 1, Type: DP/HDMI (0xe0101))
[Tue Apr 10 10:19:46 2018] thunderbolt 0000:7c:00.0:   Max hop id (in/out): 9/9
[Tue Apr 10 10:19:46 2018] thunderbolt 0000:7c:00.0:   Max counters: 2
[Tue Apr 10 10:19:46 2018] thunderbolt 0000:7c:00.0:   NFC Credits: 0x1000000
[Tue Apr 10 10:19:46 2018] thunderbolt 0000:7c:00.0:  Port 10: 8086:15d3 (Revision: 6, TB Version: 1, Type: DP/HDMI (0xe0101))
[Tue Apr 10 10:19:46 2018] thunderbolt 0000:7c:00.0:   Max hop id (in/out): 9/9
[Tue Apr 10 10:19:46 2018] thunderbolt 0000:7c:00.0:   Max counters: 2
[Tue Apr 10 10:19:46 2018] thunderbolt 0000:7c:00.0:   NFC Credits: 0x1000000
[Tue Apr 10 10:19:46 2018] thunderbolt 0000:7c:00.0:  Port 11: 8086:15d3 (Revision: 6, TB Version: 1, Type: DP/HDMI (0xe0102))
[Tue Apr 10 10:19:46 2018] thunderbolt 0000:7c:00.0:   Max hop id (in/out): 9/9
[Tue Apr 10 10:19:46 2018] thunderbolt 0000:7c:00.0:   Max counters: 2
[Tue Apr 10 10:19:46 2018] thunderbolt 0000:7c:00.0:   NFC Credits: 0x800000
[Tue Apr 10 10:19:46 2018] 8188eu: version magic '4.16.0-041600-generic SMP mod_unload ' should be '4.16.1-041601-generic SMP mod_unload '
[Tue Apr 10 10:19:47 2018] usb 1-2: USB disconnect, device number 2
[Tue Apr 10 10:19:47 2018] usb 1-2.1: USB disconnect, device number 4
[Tue Apr 10 10:19:47 2018] usb 1-2.3: USB disconnect, device number 5
[Tue Apr 10 10:19:48 2018] CPU4: Core temperature above threshold, cpu clock throttled (total events = 1)
[Tue Apr 10 10:19:48 2018] CPU0: Core temperature above threshold, cpu clock throttled (total events = 1)
[Tue Apr 10 10:19:48 2018] CPU0: Package temperature above threshold, cpu clock throttled (total events = 1)
[Tue Apr 10 10:19:48 2018] CPU4: Package temperature above threshold, cpu clock throttled (total events = 1)
[Tue Apr 10 10:19:48 2018] CPU5: Package temperature above threshold, cpu clock throttled (total events = 1)
[Tue Apr 10 10:19:48 2018] CPU1: Package temperature above threshold, cpu clock throttled (total events = 1)
[Tue Apr 10 10:19:48 2018] CPU2: Package temperature above threshold, cpu clock throttled (total events = 1)
[Tue Apr 10 10:19:48 2018] CPU6: Package temperature above threshold, cpu clock throttled (total events = 1)
[Tue Apr 10 10:19:48 2018] CPU7: Package temperature above threshold, cpu clock throttled (total events = 1)
[Tue Apr 10 10:19:48 2018] CPU3: Package temperature above threshold, cpu clock throttled (total events = 1)
[Tue Apr 10 10:19:48 2018] CPU4: Core temperature/speed normal
[Tue Apr 10 10:19:48 2018] CPU0: Core temperature/speed normal
[Tue Apr 10 10:19:48 2018] CPU4: Package temperature/speed normal
[Tue Apr 10 10:19:48 2018] CPU0: Package temperature/speed normal
[Tue Apr 10 10:19:48 2018] CPU1: Package temperature/speed normal
[Tue Apr 10 10:19:48 2018] CPU5: Package temperature/speed normal
[Tue Apr 10 10:19:48 2018] CPU6: Package temperature/speed normal
[Tue Apr 10 10:19:48 2018] CPU2: Package temperature/speed normal
[Tue Apr 10 10:19:48 2018] CPU3: Package temperature/speed normal
[Tue Apr 10 10:19:48 2018] CPU7: Package temperature/speed normal
[Tue Apr 10 10:19:48 2018] usb 1-2: new high-speed USB device number 8 using xhci_hcd
[Tue Apr 10 10:19:48 2018] usb 1-2: New USB device found, idVendor=0451, idProduct=8142
[Tue Apr 10 10:19:48 2018] usb 1-2: New USB device strings: Mfr=0, Product=0, SerialNumber=1
[Tue Apr 10 10:19:48 2018] usb 1-2: SerialNumber: FE05108975C5
[Tue Apr 10 10:19:48 2018] hub 1-2:1.0: USB hub found
[Tue Apr 10 10:19:48 2018] hub 1-2:1.0: 4 ports detected
[Tue Apr 10 10:19:49 2018] NET: Registered protocol family 38
[Tue Apr 10 10:19:49 2018] usb 1-2.1: new high-speed USB device number 9 using xhci_hcd
[Tue Apr 10 10:19:49 2018] EXT4-fs (dm-0): mounted filesystem with ordered data mode. Opts: (null)
[Tue Apr 10 10:19:49 2018] usb 1-2.1: New USB device found, idVendor=2109, idProduct=2811
[Tue Apr 10 10:19:49 2018] usb 1-2.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[Tue Apr 10 10:19:49 2018] usb 1-2.1: Product: USB2.0 Hub             
[Tue Apr 10 10:19:49 2018] usb 1-2.1: Manufacturer: VIA Labs, Inc.         
[Tue Apr 10 10:19:49 2018] hub 1-2.1:1.0: USB hub found
[Tue Apr 10 10:19:49 2018] hub 1-2.1:1.0: 4 ports detected
[Tue Apr 10 10:19:49 2018] usb 1-2.2: new full-speed USB device number 10 using xhci_hcd
[Tue Apr 10 10:19:49 2018] usb 1-2.2: New USB device found, idVendor=17ef, idProduct=a00a
[Tue Apr 10 10:19:49 2018] usb 1-2.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[Tue Apr 10 10:19:49 2018] usb 1-2.2: Product: X1
[Tue Apr 10 10:19:49 2018] usb 1-2.2: Manufacturer: Lenovo
[Tue Apr 10 10:19:49 2018] usb 1-2.2: SerialNumber: 000000000000
[Tue Apr 10 10:19:49 2018] systemd[1]: systemd 229 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ -LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN)
[Tue Apr 10 10:19:49 2018] systemd[1]: Detected architecture x86-64.
[Tue Apr 10 10:19:49 2018] systemd[1]: Set hostname to <mac0825>.
[Tue Apr 10 10:19:49 2018] input: Lenovo X1 as /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2.2/1-2.2:1.3/0003:17EF:A00A.0004/input/input9
[Tue Apr 10 10:19:49 2018] hid-generic 0003:17EF:A00A.0004: input,hiddev0,hidraw0: USB HID v1.00 Device [Lenovo X1] on usb-0000:00:14.0-2.2/input3
[Tue Apr 10 10:19:49 2018] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[Tue Apr 10 10:19:49 2018] systemd[1]: Listening on fsck to fsckd communication Socket.
[Tue Apr 10 10:19:49 2018] systemd[1]: Listening on Journal Socket (/dev/log).
[Tue Apr 10 10:19:49 2018] systemd[1]: Listening on udev Kernel Socket.
[Tue Apr 10 10:19:49 2018] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[Tue Apr 10 10:19:49 2018] systemd[1]: Created slice User and Session Slice.
[Tue Apr 10 10:19:49 2018] systemd[1]: Listening on Syslog Socket.
[Tue Apr 10 10:19:49 2018] lp: driver loaded but no devices found
[Tue Apr 10 10:19:49 2018] ppdev: user-space parallel port driver
[Tue Apr 10 10:19:49 2018] random: crng init done
[Tue Apr 10 10:19:49 2018] EXT4-fs (dm-0): re-mounted. Opts: errors=remount-ro
[Tue Apr 10 10:19:49 2018] usb 1-2.3: new high-speed USB device number 11 using xhci_hcd
[Tue Apr 10 10:19:49 2018] systemd-journald[460]: Received request to flush runtime journal from PID 1
[Tue Apr 10 10:19:50 2018] apple_gmux: Found gmux version 4.0.29 [indexed]
[Tue Apr 10 10:19:50 2018] usb 1-2.3: New USB device found, idVendor=17ef, idProduct=4824
[Tue Apr 10 10:19:50 2018] usb 1-2.3: New USB device strings: Mfr=3, Product=1, SerialNumber=2
[Tue Apr 10 10:19:50 2018] usb 1-2.3: Product: FULL HD 1080P Webcam
[Tue Apr 10 10:19:50 2018] usb 1-2.3: Manufacturer: Generic
[Tue Apr 10 10:19:50 2018] usb 1-2.3: SerialNumber: 200901010001
[Tue Apr 10 10:19:50 2018] smbus_hc ACPI0001:00: SBS HC: offset = 0x20, query_bit = 0x10
[Tue Apr 10 10:19:50 2018] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[Tue Apr 10 10:19:50 2018] media: Linux media interface: v0.10
[Tue Apr 10 10:19:50 2018] Bluetooth: Core ver 2.22
[Tue Apr 10 10:19:50 2018] NET: Registered protocol family 31
[Tue Apr 10 10:19:50 2018] Bluetooth: HCI device and connection manager initialized
[Tue Apr 10 10:19:50 2018] Bluetooth: HCI socket layer initialized
[Tue Apr 10 10:19:50 2018] Bluetooth: L2CAP socket layer initialized
[Tue Apr 10 10:19:50 2018] Bluetooth: SCO socket layer initialized
[Tue Apr 10 10:19:50 2018] Linux video capture interface: v2.00
[Tue Apr 10 10:19:50 2018] ACPI: Smart Battery System [SBS0]: AC Adapter [AC0] (on-line)
[Tue Apr 10 10:19:50 2018] Bluetooth: HCI UART driver ver 2.3
[Tue Apr 10 10:19:50 2018] Bluetooth: HCI UART protocol H4 registered
[Tue Apr 10 10:19:50 2018] Bluetooth: HCI UART protocol BCSP registered
[Tue Apr 10 10:19:50 2018] Bluetooth: HCI UART protocol LL registered
[Tue Apr 10 10:19:50 2018] Bluetooth: HCI UART protocol ATH3K registered
[Tue Apr 10 10:19:50 2018] Bluetooth: HCI UART protocol Three-wire (H5) registered
[Tue Apr 10 10:19:50 2018] Bluetooth: HCI UART protocol Intel registered
[Tue Apr 10 10:19:50 2018] Bluetooth: HCI UART protocol Broadcom registered
[Tue Apr 10 10:19:50 2018] Bluetooth: HCI UART protocol QCA registered
[Tue Apr 10 10:19:50 2018] Bluetooth: HCI UART protocol AG6XX registered
[Tue Apr 10 10:19:50 2018] Bluetooth: HCI UART protocol Marvell registered
[Tue Apr 10 10:19:50 2018] dw-apb-uart.1: ttyS4 at MMIO 0x8272a000 (irq = 21, base_baud = 115200) is a 16550A
[Tue Apr 10 10:19:50 2018] serial serial0: tty port ttyS4 registered
[Tue Apr 10 10:19:50 2018] uvcvideo: Found UVC 1.50 device iBridge (05ac:8600)
[Tue Apr 10 10:19:50 2018] idma64 idma64.0: Found Intel integrated DMA 64-bit
[Tue Apr 10 10:19:50 2018] uvcvideo 1-3:1.0: Entity type for entity Camera 1 was not initialized!
[Tue Apr 10 10:19:50 2018] uvcvideo: Found UVC 1.00 device FULL HD 1080P Webcam (17ef:4824)
[Tue Apr 10 10:19:50 2018] uvcvideo 1-2.3:1.0: Entity type for entity Extension 4 was not initialized!
[Tue Apr 10 10:19:50 2018] uvcvideo 1-2.3:1.0: Entity type for entity Processing 2 was not initialized!
[Tue Apr 10 10:19:50 2018] uvcvideo 1-2.3:1.0: Entity type for entity Camera 1 was not initialized!
[Tue Apr 10 10:19:50 2018] input: FULL HD 1080P Webcam: FULL HD 1 as /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2.3/1-2.3:1.0/input/input10
[Tue Apr 10 10:19:50 2018] usbcore: registered new interface driver uvcvideo
[Tue Apr 10 10:19:50 2018] USB Video Class driver (1.1.1)
[Tue Apr 10 10:19:50 2018] dw-apb-uart.2: ttyS5 at MMIO 0x8272b000 (irq = 20, base_baud = 3000000) is a 16550A
[Tue Apr 10 10:19:50 2018] serial serial1: tty port ttyS5 registered
[Tue Apr 10 10:19:50 2018] idma64 idma64.2: Found Intel integrated DMA 64-bit
[Tue Apr 10 10:19:50 2018] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[Tue Apr 10 10:19:50 2018] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[Tue Apr 10 10:19:50 2018] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[Tue Apr 10 10:19:50 2018] cfg80211: failed to load regulatory.db
[Tue Apr 10 10:19:50 2018] RAPL PMU: API unit is 2^-32 Joules, 5 fixed counters, 655360 ms ovfl timer
[Tue Apr 10 10:19:50 2018] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[Tue Apr 10 10:19:50 2018] RAPL PMU: hw unit of domain package 2^-14 Joules
[Tue Apr 10 10:19:50 2018] RAPL PMU: hw unit of domain dram 2^-14 Joules
[Tue Apr 10 10:19:50 2018] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[Tue Apr 10 10:19:50 2018] RAPL PMU: hw unit of domain psys 2^-14 Joules
[Tue Apr 10 10:19:50 2018] dw-apb-uart.3: ttyS6 at MMIO 0x8272c000 (irq = 21, base_baud = 115200) is a 16550A
[Tue Apr 10 10:19:50 2018] snd_hda_intel 0000:01:00.1: enabling device (0000 -> 0002)
[Tue Apr 10 10:19:50 2018] snd_hda_intel 0000:01:00.1: Handle vga_switcheroo audio client
[Tue Apr 10 10:19:50 2018] snd_hda_intel 0000:01:00.1: Force to non-snoop mode
[Tue Apr 10 10:19:50 2018] serial serial2: tty port ttyS6 registered
[Tue Apr 10 10:19:50 2018] idma64 idma64.3: Found Intel integrated DMA 64-bit
[Tue Apr 10 10:19:50 2018] usbcore: registered new interface driver brcmfmac
[Tue Apr 10 10:19:50 2018] input: HDA ATI HDMI HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input11
[Tue Apr 10 10:19:50 2018] input: HDA ATI HDMI HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input12
[Tue Apr 10 10:19:50 2018] input: HDA ATI HDMI HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input13
[Tue Apr 10 10:19:50 2018] input: HDA ATI HDMI HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input14
[Tue Apr 10 10:19:50 2018] input: HDA ATI HDMI HDMI/DP,pcm=10 as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input15
[Tue Apr 10 10:19:50 2018] input: HDA ATI HDMI HDMI/DP,pcm=11 as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input16
[Tue Apr 10 10:19:50 2018] intel_rapl: Found RAPL domain package
[Tue Apr 10 10:19:50 2018] intel_rapl: Found RAPL domain core
[Tue Apr 10 10:19:50 2018] intel_rapl: Found RAPL domain uncore
[Tue Apr 10 10:19:50 2018] intel_rapl: Found RAPL domain dram
[Tue Apr 10 10:19:50 2018] snd_hda_codec_generic hdaudioC0D0: autoconfig for Generic: line_outs=2 (0x24/0x25/0x0/0x0/0x0) type:speaker
[Tue Apr 10 10:19:50 2018] snd_hda_codec_generic hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[Tue Apr 10 10:19:50 2018] snd_hda_codec_generic hdaudioC0D0:    hp_outs=1 (0x2c/0x0/0x0/0x0/0x0)
[Tue Apr 10 10:19:50 2018] snd_hda_codec_generic hdaudioC0D0:    mono: mono_out=0x0
[Tue Apr 10 10:19:50 2018] snd_hda_codec_generic hdaudioC0D0:    inputs:
[Tue Apr 10 10:19:50 2018] snd_hda_codec_generic hdaudioC0D0:      Internal Mic=0x44
[Tue Apr 10 10:19:50 2018] snd_hda_codec_generic hdaudioC0D0:      Mic=0x3c
[Tue Apr 10 10:19:50 2018] usb 1-2.2: 1:1: cannot get freq at ep 0x81
[Tue Apr 10 10:19:50 2018] idma64 idma64.4: Found Intel integrated DMA 64-bit
[Tue Apr 10 10:19:50 2018] idma64 idma64.5: Found Intel integrated DMA 64-bit
[Tue Apr 10 10:19:50 2018] usb 1-2.2: 2:1: cannot get freq at ep 0x1
[Tue Apr 10 10:19:50 2018] usbcore: registered new interface driver snd-usb-audio
[Tue Apr 10 10:19:50 2018] applesmc: key=862 fan=2 temp=46 index=45 acc=0 lux=0 kbd=0
[Tue Apr 10 10:19:50 2018] applesmc applesmc.768: hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
[Tue Apr 10 10:19:50 2018] brcmfmac: brcmf_fw_map_chip_to_name: using brcm/brcmfmac43602-pcie.bin for chip 0x00aa52(43602) rev 0x000002
[Tue Apr 10 10:19:50 2018] ACPI: Smart Battery System [SBS0]: Battery Slot [BAT0] (battery present)
[Tue Apr 10 10:19:50 2018] brcmfmac 0000:03:00.0: Direct firmware load for brcm/brcmfmac43602-pcie.txt failed with error -2
[Tue Apr 10 10:19:50 2018] Bluetooth: hci0: BCM: chip id 126
[Tue Apr 10 10:19:50 2018] Bluetooth: hci0: BCM: features 0x2f
[Tue Apr 10 10:19:50 2018] Bluetooth: hci0: BCM20703A2 Generic UART UHE Apple 40MHz wlcsp_x100
[Tue Apr 10 10:19:50 2018] Bluetooth: hci0: BCM (001.002.063) build 0168
[Tue Apr 10 10:19:50 2018] bluetooth hci0: Direct firmware load for brcm/BCM.hcd failed with error -2
[Tue Apr 10 10:19:50 2018] Bluetooth: hci0: BCM: Patch brcm/BCM.hcd not found
[Tue Apr 10 10:19:50 2018] brcmfmac 0000:03:00.0: Direct firmware load for brcm/brcmfmac43602-pcie.clm_blob failed with error -2
[Tue Apr 10 10:19:50 2018] brcmfmac: brcmf_c_process_clm_blob: no clm_blob available(err=-2), device may have limited channels available
[Tue Apr 10 10:19:50 2018] brcmfmac: brcmf_c_preinit_dcmds: Firmware version = wl0: Nov 10 2015 06:38:10 version 7.35.177.61 (r598657) FWID 01-ea662a8c
[Tue Apr 10 10:19:50 2018] EXT4-fs (nvme0n1p5): mounted filesystem with ordered data mode. Opts: (null)
[Tue Apr 10 10:19:50 2018] brcmfmac 0000:03:00.0 wlp3s0: renamed from wlan0
[Tue Apr 10 10:19:51 2018] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[Tue Apr 10 10:19:51 2018] Bluetooth: BNEP filters: protocol multicast
[Tue Apr 10 10:19:51 2018] Bluetooth: BNEP socket layer initialized
[Tue Apr 10 10:19:51 2018] r8188eu: module is from the staging directory, the quality is unknown, you have been warned.
[Tue Apr 10 10:19:51 2018] Chip Version Info: CHIP_8188E_Normal_Chip_TSMC_D_CUT_1T1R_RomVer(0)
[Tue Apr 10 10:19:51 2018] usbcore: registered new interface driver r8188eu
[Tue Apr 10 10:19:51 2018] 8188eu: version magic '4.16.0-041600-generic SMP mod_unload ' should be '4.16.1-041601-generic SMP mod_unload '
[Tue Apr 10 10:19:51 2018] MAC Address = 7c:8b:ca:07:cb:51
[Tue Apr 10 10:19:52 2018] usb 1-2.4: new full-speed USB device number 12 using xhci_hcd
[Tue Apr 10 10:19:52 2018] usb 1-2.4: New USB device found, idVendor=0451, idProduct=3421
[Tue Apr 10 10:19:52 2018] usb 1-2.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[Tue Apr 10 10:19:52 2018] usb 1-2.4: Product: Texas Instruments USB Billboard Device
[Tue Apr 10 10:19:52 2018] usb 1-2.4: Manufacturer: Texas Instruments Inc.
[Tue Apr 10 10:19:52 2018] usb 1-2.4: SerialNumber: 8CFF59CD08152152
[Tue Apr 10 10:19:52 2018] hid-generic 0003:0451:3421.0005: hiddev2,hidraw3: USB HID v1.11 Device [Texas Instruments Inc. Texas Instruments USB Billboard Device] on usb-0000:00:14.0-2.4/input1
[Tue Apr 10 10:19:53 2018] bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
[Tue Apr 10 10:19:53 2018] Bridge firewalling registered
[Tue Apr 10 10:19:53 2018] Initializing XFRM netlink socket
[Tue Apr 10 10:19:53 2018] usb 1-2.2: 1:1: cannot get freq at ep 0x81
[Tue Apr 10 10:19:53 2018] Bluetooth: RFCOMM TTY layer initialized
[Tue Apr 10 10:19:53 2018] Bluetooth: RFCOMM socket layer initialized
[Tue Apr 10 10:19:53 2018] Bluetooth: RFCOMM ver 1.11
[Tue Apr 10 10:19:56 2018] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[Tue Apr 10 10:19:56 2018] Bluetooth: HIDP socket layer initialized
[Tue Apr 10 10:19:56 2018] hid-generic 0005:004C:026C.0006: unknown main item tag 0x0
[Tue Apr 10 10:19:56 2018] input: aarapov’s Keyboard as /devices/pci0000:00/0000:00:1e.0/dw-apb-uart.2/serial1/serial1-0/bluetooth/hci0/hci0:11/0005:004C:026C.0006/input/input17
[Tue Apr 10 10:19:56 2018] hid-generic 0005:004C:026C.0006: input,hidraw4: BLUETOOTH HID v0.82 Keyboard [aarapov’s Keyboard] on 8c:85:90:54:4b:84
[Tue Apr 10 10:20:02 2018] hid-generic 0005:17EF:6038.0007: unknown main item tag 0x0
[Tue Apr 10 10:20:02 2018] input: ThinkPad Bluetooth Laser Mouse as /devices/pci0000:00/0000:00:1e.0/dw-apb-uart.2/serial1/serial1-0/bluetooth/hci0/hci0:12/0005:17EF:6038.0007/input/input18
[Tue Apr 10 10:20:02 2018] hid-generic 0005:17EF:6038.0007: input,hidraw5: BLUETOOTH HID v2.00 Mouse [ThinkPad Bluetooth Laser Mouse] on 8c:85:90:54:4b:84
[Tue Apr 10 10:20:02 2018] usb 6-1: new SuperSpeed USB device number 2 using xhci_hcd
[Tue Apr 10 10:20:02 2018] usb 6-1: New USB device found, idVendor=0451, idProduct=8140
[Tue Apr 10 10:20:02 2018] usb 6-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[Tue Apr 10 10:20:02 2018] hub 6-1:1.0: USB hub found
[Tue Apr 10 10:20:02 2018] hub 6-1:1.0: 4 ports detected
[Tue Apr 10 10:20:03 2018] usb 6-1.1: new SuperSpeed USB device number 3 using xhci_hcd
[Tue Apr 10 10:20:03 2018] usb 6-1.1: New USB device found, idVendor=2109, idProduct=8110
[Tue Apr 10 10:20:03 2018] usb 6-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[Tue Apr 10 10:20:03 2018] usb 6-1.1: Product: USB3.0 Hub             
[Tue Apr 10 10:20:03 2018] usb 6-1.1: Manufacturer: VIA Labs, Inc.         
[Tue Apr 10 10:20:03 2018] hub 6-1.1:1.0: USB hub found
[Tue Apr 10 10:20:03 2018] hub 6-1.1:1.0: 4 ports detected
[Tue Apr 10 10:20:20 2018] usb 6-1: USB disconnect, device number 2
[Tue Apr 10 10:20:20 2018] usb 6-1.1: USB disconnect, device number 3
[Tue Apr 10 10:20:24 2018] usb 1-2: USB disconnect, device number 8
[Tue Apr 10 10:20:24 2018] usb 1-2.1: USB disconnect, device number 9
[Tue Apr 10 10:20:24 2018] usb 1-2.2: USB disconnect, device number 10
[Tue Apr 10 10:20:24 2018] usb 1-2.3: USB disconnect, device number 11
[Tue Apr 10 10:20:24 2018] usb 1-2.4: USB disconnect, device number 12
[Tue Apr 10 10:20:24 2018] usb 1-2: new high-speed USB device number 13 using xhci_hcd
[Tue Apr 10 10:20:24 2018] usb 1-2: New USB device found, idVendor=0451, idProduct=8142
[Tue Apr 10 10:20:24 2018] usb 1-2: New USB device strings: Mfr=0, Product=0, SerialNumber=1
[Tue Apr 10 10:20:24 2018] usb 1-2: SerialNumber: FE05108975C5
[Tue Apr 10 10:20:24 2018] hub 1-2:1.0: USB hub found
[Tue Apr 10 10:20:24 2018] hub 1-2:1.0: 4 ports detected
[Tue Apr 10 10:20:24 2018] usb 1-2.1: new high-speed USB device number 14 using xhci_hcd
[Tue Apr 10 10:20:25 2018] usb 1-2.1: New USB device found, idVendor=2109, idProduct=2811
[Tue Apr 10 10:20:25 2018] usb 1-2.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[Tue Apr 10 10:20:25 2018] usb 1-2.1: Product: USB2.0 Hub             
[Tue Apr 10 10:20:25 2018] usb 1-2.1: Manufacturer: VIA Labs, Inc.         
[Tue Apr 10 10:20:25 2018] hub 1-2.1:1.0: USB hub found
[Tue Apr 10 10:20:25 2018] hub 1-2.1:1.0: 4 ports detected
[Tue Apr 10 10:20:25 2018] usb 1-2.2: new full-speed USB device number 15 using xhci_hcd
[Tue Apr 10 10:20:25 2018] usb 1-2.2: New USB device found, idVendor=17ef, idProduct=a00a
[Tue Apr 10 10:20:25 2018] usb 1-2.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[Tue Apr 10 10:20:25 2018] usb 1-2.2: Product: X1
[Tue Apr 10 10:20:25 2018] usb 1-2.2: Manufacturer: Lenovo
[Tue Apr 10 10:20:25 2018] usb 1-2.2: SerialNumber: 000000000000
[Tue Apr 10 10:20:25 2018] input: Lenovo X1 as /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2.2/1-2.2:1.3/0003:17EF:A00A.0008/input/input19
[Tue Apr 10 10:20:25 2018] hid-generic 0003:17EF:A00A.0008: input,hiddev0,hidraw0: USB HID v1.00 Device [Lenovo X1] on usb-0000:00:14.0-2.2/input3
[Tue Apr 10 10:20:25 2018] usb 1-2.3: new high-speed USB device number 16 using xhci_hcd
[Tue Apr 10 10:20:26 2018] usb 1-2.3: New USB device found, idVendor=17ef, idProduct=4824
[Tue Apr 10 10:20:26 2018] usb 1-2.3: New USB device strings: Mfr=3, Product=1, SerialNumber=2
[Tue Apr 10 10:20:26 2018] usb 1-2.3: Product: FULL HD 1080P Webcam
[Tue Apr 10 10:20:26 2018] usb 1-2.3: Manufacturer: Generic
[Tue Apr 10 10:20:26 2018] usb 1-2.3: SerialNumber: 200901010001
[Tue Apr 10 10:20:26 2018] uvcvideo: Found UVC 1.00 device FULL HD 1080P Webcam (17ef:4824)
[Tue Apr 10 10:20:26 2018] uvcvideo 1-2.3:1.0: Entity type for entity Extension 4 was not initialized!
[Tue Apr 10 10:20:26 2018] uvcvideo 1-2.3:1.0: Entity type for entity Processing 2 was not initialized!
[Tue Apr 10 10:20:26 2018] uvcvideo 1-2.3:1.0: Entity type for entity Camera 1 was not initialized!
[Tue Apr 10 10:20:26 2018] input: FULL HD 1080P Webcam: FULL HD 1 as /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2.3/1-2.3:1.0/input/input20
[Tue Apr 10 10:20:26 2018] usb 1-2.4: new full-speed USB device number 17 using xhci_hcd
[Tue Apr 10 10:20:26 2018] usb 1-2.4: New USB device found, idVendor=0451, idProduct=3421
[Tue Apr 10 10:20:26 2018] usb 1-2.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[Tue Apr 10 10:20:26 2018] usb 1-2.4: Product: Texas Instruments USB Billboard Device
[Tue Apr 10 10:20:26 2018] usb 1-2.4: Manufacturer: Texas Instruments Inc.
[Tue Apr 10 10:20:26 2018] usb 1-2.4: SerialNumber: 8CFF59CD08152152
[Tue Apr 10 10:20:26 2018] hid-generic 0003:0451:3421.0009: hiddev2,hidraw3: USB HID v1.11 Device [Texas Instruments Inc. Texas Instruments USB Billboard Device] on usb-0000:00:14.0-2.4/input1
[Tue Apr 10 10:20:26 2018] usb 1-2.2: 1:1: cannot get freq at ep 0x81
[Tue Apr 10 10:20:26 2018] usb 1-2.2: 2:1: cannot get freq at ep 0x1
[Tue Apr 10 10:20:26 2018] usb 1-2.2: 1:1: cannot get freq at ep 0x81
[Tue Apr 10 10:21:07 2018] docker0: port 1(veth5d3306d) entered blocking state
[Tue Apr 10 10:21:07 2018] docker0: port 1(veth5d3306d) entered disabled state
[Tue Apr 10 10:21:07 2018] device veth5d3306d entered promiscuous mode
[Tue Apr 10 10:21:07 2018] eth0: renamed from veth1beb80e
[Tue Apr 10 10:21:07 2018] docker0: port 1(veth5d3306d) entered blocking state
[Tue Apr 10 10:21:07 2018] docker0: port 1(veth5d3306d) entered forwarding state
[Tue Apr 10 10:22:41 2018] usb 1-2.2: USB disconnect, device number 15
[Tue Apr 10 10:24:55 2018] usb 1-2.4: USB disconnect, device number 17
[Tue Apr 10 10:24:55 2018] usb 1-2: USB disconnect, device number 13
[Tue Apr 10 10:24:55 2018] usb 1-2.1: USB disconnect, device number 14
[Tue Apr 10 10:24:55 2018] usb 1-2.3: USB disconnect, device number 16
[Tue Apr 10 10:24:57 2018] usb 1-2: new high-speed USB device number 18 using xhci_hcd
[Tue Apr 10 10:24:57 2018] usb 1-2: New USB device found, idVendor=0451, idProduct=8142
[Tue Apr 10 10:24:57 2018] usb 1-2: New USB device strings: Mfr=0, Product=0, SerialNumber=1
[Tue Apr 10 10:24:57 2018] usb 1-2: SerialNumber: FE05108975C5
[Tue Apr 10 10:24:57 2018] hub 1-2:1.0: USB hub found
[Tue Apr 10 10:24:57 2018] hub 1-2:1.0: 4 ports detected
[Tue Apr 10 10:24:57 2018] usb 1-2.1: new high-speed USB device number 19 using xhci_hcd
[Tue Apr 10 10:24:57 2018] usb 1-2.1: New USB device found, idVendor=2109, idProduct=2811
[Tue Apr 10 10:24:57 2018] usb 1-2.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[Tue Apr 10 10:24:57 2018] usb 1-2.1: Product: USB2.0 Hub             
[Tue Apr 10 10:24:57 2018] usb 1-2.1: Manufacturer: VIA Labs, Inc.         
[Tue Apr 10 10:24:57 2018] hub 1-2.1:1.0: USB hub found
[Tue Apr 10 10:24:57 2018] hub 1-2.1:1.0: 4 ports detected
[Tue Apr 10 10:24:57 2018] usb 1-2.2: new full-speed USB device number 20 using xhci_hcd
[Tue Apr 10 10:24:58 2018] usb 1-2.2: New USB device found, idVendor=17ef, idProduct=a00a
[Tue Apr 10 10:24:58 2018] usb 1-2.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[Tue Apr 10 10:24:58 2018] usb 1-2.2: Product: X1
[Tue Apr 10 10:24:58 2018] usb 1-2.2: Manufacturer: Lenovo
[Tue Apr 10 10:24:58 2018] usb 1-2.2: SerialNumber: 000000000000
[Tue Apr 10 10:24:58 2018] usb 1-2.2: 2:1: cannot get freq at ep 0x1
[Tue Apr 10 10:24:58 2018] input: Lenovo X1 as /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2.2/1-2.2:1.3/0003:17EF:A00A.000A/input/input21
[Tue Apr 10 10:24:58 2018] hid-generic 0003:17EF:A00A.000A: input,hiddev0,hidraw0: USB HID v1.00 Device [Lenovo X1] on usb-0000:00:14.0-2.2/input3
[Tue Apr 10 10:24:58 2018] usb 1-2.3: new high-speed USB device number 21 using xhci_hcd
[Tue Apr 10 10:24:58 2018] usb 1-2.3: New USB device found, idVendor=17ef, idProduct=4824
[Tue Apr 10 10:24:58 2018] usb 1-2.3: New USB device strings: Mfr=3, Product=1, SerialNumber=2
[Tue Apr 10 10:24:58 2018] usb 1-2.3: Product: FULL HD 1080P Webcam
[Tue Apr 10 10:24:58 2018] usb 1-2.3: Manufacturer: Generic
[Tue Apr 10 10:24:58 2018] usb 1-2.3: SerialNumber: 200901010001
[Tue Apr 10 10:24:58 2018] uvcvideo: Found UVC 1.00 device FULL HD 1080P Webcam (17ef:4824)
[Tue Apr 10 10:24:58 2018] uvcvideo 1-2.3:1.0: Entity type for entity Extension 4 was not initialized!
[Tue Apr 10 10:24:58 2018] uvcvideo 1-2.3:1.0: Entity type for entity Processing 2 was not initialized!
[Tue Apr 10 10:24:58 2018] uvcvideo 1-2.3:1.0: Entity type for entity Camera 1 was not initialized!
[Tue Apr 10 10:24:58 2018] input: FULL HD 1080P Webcam: FULL HD 1 as /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2.3/1-2.3:1.0/input/input22
[Tue Apr 10 10:24:58 2018] usb 1-2.2: 1:1: cannot get freq at ep 0x81
[Tue Apr 10 10:24:58 2018] usb 1-2.2: 1:1: cannot get freq at ep 0x81
[Tue Apr 10 10:25:00 2018] usb 1-2.4: new full-speed USB device number 22 using xhci_hcd
[Tue Apr 10 10:25:00 2018] usb 1-2.4: New USB device found, idVendor=0451, idProduct=3421
[Tue Apr 10 10:25:00 2018] usb 1-2.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[Tue Apr 10 10:25:00 2018] usb 1-2.4: Product: Texas Instruments USB Billboard Device
[Tue Apr 10 10:25:00 2018] usb 1-2.4: Manufacturer: Texas Instruments Inc.
[Tue Apr 10 10:25:00 2018] usb 1-2.4: SerialNumber: 8CFF59CD08152152
[Tue Apr 10 10:25:00 2018] hid-generic 0003:0451:3421.000B: hiddev2,hidraw3: USB HID v1.11 Device [Texas Instruments Inc. Texas Instruments USB Billboard Device] on usb-0000:00:14.0-2.4/input1

--Nq2Wo0NMKNjxTN9z
Content-Type: application/gzip
Content-Disposition: attachment; filename="acpi.dump.tgz"
Content-Transfer-Encoding: base64

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
MFGUtzm5vniS1IYbmOIt6gHSRD8DqU0/XVC0iwBWS7EU1AJjJLNjN1zwkRe/uCF/M133t9tn
BpYmZpCrU88qyAzDcuRXIMi3kIzIr0CsZzm9MY+MGM/QCM4Mnw/P7B4YnBn8J/I6tlTm/wHl
Z7Ht4mR+0YzW/01IAbxswZbSpggmdz9Xs556SDcOSciHsqXP5lOExT7rt53X21SzLRy1iZ9I
K+91tmmqdSScGfwnoB4yztrzX2/N68UKUhsjdeaJqE29eT3bOjP4T3D2bed6FAtZ0DuPptYl
zzN1if9E5JYNkL6ftWnYkgK+khjDP631Ti63rYOMzsKs2uEG07/SD7nRqtymX725G5Kb8SpN
rnITVDI/Myy2owk+LWgTodozw7wdFV9odK4d4TihPXc3V6nXu7NI5rwd7Wqvld8eQrVnhrgd
i7rA+zSF9mThiGdZME7dhdGvKucOt6P+ordnhiJdHo/lXlMV6DQJvuyZYU87itT1WvntSSUt
MSt3ScFwWQpwZthqR77Qa2XbY8iK/+bcjzcXtp1a9mf9UWefSq4CSf182yFIho+3HTjoONm5
rpbnRsMQn/uAqO3+4eHrDzIjz775/Vd226lCLTDqljWSwTekpK355zQ3N8NvuEH/R/53287g
jZPW42dPaBf3oo1tZ8UJVPlI7YK748ZHomlt1/bB0ngDDPuw3p3aKmyTSrxthxPET53nkrBb
TSGcHZS3ZIX2g4dkckGw7fSVGkvv6VZ+OHcBD/SFcZKYhYWuzf6z8xgj/R/fVeX3SPaZ4sLc
qahNfWTGrP6XmUuXfKV3w4YUrH3C+rYTP21Qq0uSGcjTxL1zY9Neal+Gm7x5m05bkpnNftjo
Xeyq2vWFpx/pWc/LoIllvnb79j8IfYhv31LQwzERjXfHla7dvt2cnqR0z0Vgq571XV/kWf+B
ne2nzc4uXTVOdL1YlqKkbb2JlavGP/x6enj4Lvn/TWfPY1Bco60fd6/aBnep/n/Lnf1S7lQ3
O8t3Zudp4cbdWU+4M3mS/EquVa/8OxO+PKVAZY/nIr4ftSm86euk/PLpmJk7UbsRMe+QY+nC
Z6d8S+Ff5VgPWUKJtzdjQnEzt6/8888UF9KTkh1IiKuN145Y/TomnTHl9JI/uOVeixd49hxT
BJ+jkAdn8xDGJFfQdiPyR5PGLBqqwqxyW/2XRjnFQN0NPVf/5Y2oxdMyGKW77OD1I+UCmH+1
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
P379+PXj149fP379+PXj149fP379+PXj149fP379+PXj149fP379+PXj149fP379+PXj149f
P379+PX/F1//X9CVxrkA8AoA

--Nq2Wo0NMKNjxTN9z
Content-Type: application/gzip
Content-Disposition: attachment; filename="all-device-status.log.gz"
Content-Transfer-Encoding: base64

H4sIADnGzVoAA53Yy2oCQRBG4X2eIi8wdFdXV5fjbhwNCLkMMXmA8RJwFxgN5O2zcCMkyOms
3Jwh4v9RBsP0PYXteQrj7vMY9oev4+4wha4f1jFGmccYptN4Ok/ze7G78Hc8DL9audmminZR
0S7p+31cNevUN5vNso8Vz7x3r2/N5qX/xyNNhx5a9E9p5ewPXF7n0XhaeDrj6cjTLU93PD3w
9AOnwicQ4WniqfI085RzEc5FOBdpecplCZclXJbsecoRCkeYOMLEESaOMDlP+bCJD5v4sImv
lfhaia+lfC3laylfS/nJUH4ylJ8M5VyUnwzlspTLUi5L+clQjlA5QuUIM0eYuazMZWXOJXMu
mXPJnEvmBjI3kLmBzA1kbsC4AeOHyDgX41yMczH+D4lxWcZlGZdl/BAZR2gcoXGExhEaR1j4
N0zhwxY+bOHDFr5W4WsVvlbhaxW+VuFrOT8Zzk+G85PhnIvzk+FclnNZzmU5PxnOETpH6Byh
c4Qz/gnM+CfQclktl9XyL6OWI2w5whYgHJ6HKFGvf/mJN9I+djxdod/QLu1DXSsVbapotaLN
Fa1VtKWi9ev2B3mFNa9VFQAA

--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--Nq2Wo0NMKNjxTN9z--
