From: Tom St Denis <tstdenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: dmesg warning during init
Date: Mon, 16 Jul 2018 11:55:04 -0400
Message-ID: <aff64c92-6611-041f-319b-fd444f67a239@amd.com>
References: <4202bddf-090d-dd45-6b0a-aeb3a2534f3c@amd.com>
 <2b60a98b-f4a5-9dab-24be-ead1da757dcd@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------581D4F362C624E788C55386B"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <2b60a98b-f4a5-9dab-24be-ead1da757dcd-otUistvHUpPR7s880joybQ@public.gmane.org>
Content-Language: en-US
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--------------581D4F362C624E788C55386B
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

I have the same now and get the attached dmesg.

Tom

On 07/16/2018 10:25 AM, Michel Dänzer wrote:
> On 2018-07-16 02:10 PM, Tom St Denis wrote:
>> Hi all,
>>
>> Back from vacation, booting up the latest drm-next kernel and noticed
>> this warning on boot. Attached.
>>
>> I like the comment in the commit 5c200f56506a142451f17dbea7befa76dd74a942:
>>
>> "This shouldn't happen, but if it does, we'll get a backtrace of the
>> caller, and update the pin_size values as needed."
> 
> Once again, turns out it is better to be safe than sorry. :)
> Unfortunately, the backtrace isn't really usable, all entries have a
> question mark. What does
> 
>   grep -e UNWINDER -e DEBUG_INFO -e FRAME_POINTER .config
> 
> say in your build tree? FWIW, it's the below for me, and in my
> backtraces some entries have no question mark, and those seem reliable.
> 
> 
> CONFIG_SCHED_OMIT_FRAME_POINTER=y
> CONFIG_DEBUG_INFO=y
> CONFIG_DEBUG_INFO_REDUCED=y
> # CONFIG_DEBUG_INFO_SPLIT is not set
> # CONFIG_DEBUG_INFO_DWARF4 is not set
> CONFIG_UNWINDER_ORC=y
> # CONFIG_UNWINDER_FRAME_POINTER is not set
> # CONFIG_UNWINDER_GUESS is not set
> 
> 

--------------581D4F362C624E788C55386B
Content-Type: text/x-log;
 name="raven.dmesg.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="raven.dmesg.log"

[    0.000000] Linux version 4.18.0-rc1+ (root@raven) (gcc version 8.1.1 20180502 (Red Hat 8.1.1-1) (GCC)) #7 SMP Mon Jul 16 11:45:24 EDT 2018
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-4.18.0-rc1+ root=UUID=66163c80-0ca1-4beb-aeba-5cc130b813e6 ro rhgb quiet modprobe.blacklist=amdgpu,radeon LANG=en_CA.UTF-8
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'compacted' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009d3ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009d400-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000003ffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000004000000-0x0000000004009fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000000400a000-0x0000000009bfffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000009c00000-0x0000000009ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x000000000a000000-0x000000000affffff] usable
[    0.000000] BIOS-e820: [mem 0x000000000b000000-0x000000000b01ffff] reserved
[    0.000000] BIOS-e820: [mem 0x000000000b020000-0x0000000096463fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000096464000-0x000000009647bfff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000009647c000-0x000000009a5bdfff] usable
[    0.000000] BIOS-e820: [mem 0x000000009a5be000-0x000000009a6d5fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000009a6d6000-0x000000009a6e1fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000009a6e2000-0x000000009a7e4fff] usable
[    0.000000] BIOS-e820: [mem 0x000000009a7e5000-0x000000009ab9cfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000009ab9d000-0x000000009b942fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000009b943000-0x000000009dffffff] usable
[    0.000000] BIOS-e820: [mem 0x000000009e000000-0x00000000dfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fd800000-0x00000000fdffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fea00000-0x00000000fea0ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000feb80000-0x00000000fec01fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec10000-0x00000000fec10fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec30000-0x00000000fec30fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed40000-0x00000000fed44fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed8ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fedc2000-0x00000000fedcffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fedd4000-0x00000000fedd5fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000feefffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000021f33ffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 3.1.1 present.
[    0.000000] DMI: System manufacturer System Product Name/TUF B350M-PLUS GAMING, BIOS 4011 04/19/2018
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] last_pfn = 0x21f340 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF write-through
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000000 mask FFFF80000000 write-back
[    0.000000]   1 base 000080000000 mask FFFFC0000000 write-back
[    0.000000]   2 base 0000C0000000 mask FFFFE0000000 write-back
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] TOM2: 0000000220000000 aka 8704M
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000000] e820: update [mem 0xe0000000-0xffffffff] usable ==> reserved
[    0.000000] last_pfn = 0x9e000 max_arch_pfn = 0x400000000
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] Base memory trampoline at [(____ptrval____)] 97000 size 24576
[    0.000000] Using GB pages for direct mapping
[    0.000000] BRK [0x2e5f8000, 0x2e5f8fff] PGTABLE
[    0.000000] BRK [0x2e5f9000, 0x2e5f9fff] PGTABLE
[    0.000000] BRK [0x2e5fa000, 0x2e5fafff] PGTABLE
[    0.000000] BRK [0x2e5fb000, 0x2e5fbfff] PGTABLE
[    0.000000] BRK [0x2e5fc000, 0x2e5fcfff] PGTABLE
[    0.000000] BRK [0x2e5fd000, 0x2e5fdfff] PGTABLE
[    0.000000] BRK [0x2e5fe000, 0x2e5fefff] PGTABLE
[    0.000000] BRK [0x2e5ff000, 0x2e5fffff] PGTABLE
[    0.000000] BRK [0x2e600000, 0x2e600fff] PGTABLE
[    0.000000] RAMDISK: [mem 0x34c80000-0x36637fff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F05B0 000024 (v02 ALASKA)
[    0.000000] ACPI: XSDT 0x0000000096464098 0000AC (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FACP 0x000000009646E9B0 000114 (v06 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI BIOS Warning (bug): Optional FADT field Pm2ControlBlock has valid Length but zero Address: 0x0000000000000000/0x1 (20180531/tbfadt-624)
[    0.000000] ACPI: DSDT 0x00000000964641E0 00A7C9 (v02 ALASKA A M I    01072009 INTL 20120913)
[    0.000000] ACPI: FACS 0x000000009AB86E00 000040
[    0.000000] ACPI: APIC 0x000000009646EAC8 0000DE (v03 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FPDT 0x000000009646EBA8 000044 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FIDT 0x000000009646EBF0 00009C (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: SSDT 0x000000009647A148 001A41 (v01 AMD    AmdTable 00000001 INTL 20120913)
[    0.000000] ACPI: SSDT 0x000000009646ECE8 005367 (v02 AMD    AmdTable 00000002 MSFT 02000002)
[    0.000000] ACPI: SSDT 0x0000000096474050 00119C (v01 AMD    AMD CPU  00000001 AMD  00000001)
[    0.000000] ACPI: CRAT 0x00000000964751F0 000810 (v01 AMD    AMD CRAT 00000001 AMD  00000001)
[    0.000000] ACPI: CDIT 0x0000000096475A00 000029 (v01 AMD    AMD CDIT 00000001 AMD  00000001)
[    0.000000] ACPI: SSDT 0x0000000096475A30 002DA8 (v01 AMD    AMD AOD  00000001 INTL 20120913)
[    0.000000] ACPI: MCFG 0x00000000964787D8 00003C (v01 ALASKA A M I    01072009 MSFT 00010013)
[    0.000000] ACPI: HPET 0x0000000096478818 000038 (v01 ALASKA A M I    01072009 AMI  00000005)
[    0.000000] ACPI: UEFI 0x0000000096478850 000042 (v01                 00000000      00000000)
[    0.000000] ACPI: IVRS 0x0000000096478898 0000D0 (v02 AMD    AMD IVRS 00000001 AMD  00000000)
[    0.000000] ACPI: SSDT 0x0000000096478968 0000F8 (v01 AMD    AMD PT   00001000 INTL 20120913)
[    0.000000] ACPI: SSDT 0x0000000096478A60 000E96 (v01 AMD    AmdTable 00000001 INTL 20120913)
[    0.000000] ACPI: SSDT 0x00000000964798F8 000850 (v01 AMD    AmdTable 00000001 INTL 20120913)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000021f33ffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x21f33c000-0x21f33ffff]
[    0.000000] tsc: Fast TSC calibration failed
[    0.000000] tsc: Using PIT calibration value
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000021f33ffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009cfff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x0000000003ffffff]
[    0.000000]   node   0: [mem 0x000000000400a000-0x0000000009bfffff]
[    0.000000]   node   0: [mem 0x000000000a000000-0x000000000affffff]
[    0.000000]   node   0: [mem 0x000000000b020000-0x0000000096463fff]
[    0.000000]   node   0: [mem 0x000000009647c000-0x000000009a5bdfff]
[    0.000000]   node   0: [mem 0x000000009a6e2000-0x000000009a7e4fff]
[    0.000000]   node   0: [mem 0x000000009b943000-0x000000009dffffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000021f33ffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000021f33ffff]
[    0.000000] On node 0 totalpages: 1817624
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 21 pages reserved
[    0.000000]   DMA zone: 3996 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 9957 pages used for memmap
[    0.000000]   DMA32 zone: 637244 pages, LIFO batch:31
[    0.000000]   Normal zone: 18381 pages used for memmap
[    0.000000]   Normal zone: 1176384 pages, LIFO batch:31
[    0.000000] Reserved but unavailable: 100 pages
[    0.000000] kasan: KernelAddressSanitizer initialized
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 9, version 33, address 0xfec00000, GSI 0-23
[    0.000000] IOAPIC[1]: apic_id 10, version 33, address 0xfec01000, GSI 24-55
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x10228201 base: 0xfed00000
[    0.000000] smpboot: Allowing 16 CPUs, 8 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009d000-0x0009dfff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009e000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000dffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000e0000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0x04000000-0x04009fff]
[    0.000000] PM: Registered nosave memory: [mem 0x09c00000-0x09ffffff]
[    0.000000] PM: Registered nosave memory: [mem 0x0b000000-0x0b01ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x96464000-0x9647bfff]
[    0.000000] PM: Registered nosave memory: [mem 0x9a5be000-0x9a6d5fff]
[    0.000000] PM: Registered nosave memory: [mem 0x9a6d6000-0x9a6e1fff]
[    0.000000] PM: Registered nosave memory: [mem 0x9a7e5000-0x9ab9cfff]
[    0.000000] PM: Registered nosave memory: [mem 0x9ab9d000-0x9b942fff]
[    0.000000] PM: Registered nosave memory: [mem 0x9e000000-0xdfffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xe0000000-0xf7ffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xf8000000-0xfbffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfc000000-0xfd7fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfd800000-0xfdffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfe000000-0xfe9fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfea00000-0xfea0ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfea10000-0xfeb7ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfeb80000-0xfec01fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec02000-0xfec0ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec10000-0xfec10fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec11000-0xfec2ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec30000-0xfec30fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec31000-0xfecfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed00000-0xfed00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed01000-0xfed3ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed40000-0xfed44fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed45000-0xfed7ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed80000-0xfed8ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed90000-0xfedc1fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfedc2000-0xfedcffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfedd0000-0xfedd3fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfedd4000-0xfedd5fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfedd6000-0xfedfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee00000-0xfeefffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfef00000-0xfeffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xff000000-0xffffffff]
[    0.000000] [mem 0xe0000000-0xf7ffffff] available for PCI devices
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.000000] WARNING: WARNING: Bad or missing .orc_unwind table.  Disabling unwinder.
[    0.000000] random: get_random_bytes called from start_kernel+0xe5/0x5ef with crng_init=0
[    0.000000] setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:16 nr_node_ids:1
[    0.000000] percpu: Embedded 53 pages/cpu @(____ptrval____) s179976 r8192 d28920 u262144
[    0.000000] pcpu-alloc: s179976 r8192 d28920 u262144 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 12 13 14 15 
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 1789201
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-4.18.0-rc1+ root=UUID=66163c80-0ca1-4beb-aeba-5cc130b813e6 ro rhgb quiet modprobe.blacklist=amdgpu,radeon LANG=en_CA.UTF-8
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Memory: 6080288K/7270496K available (22540K kernel code, 5533K rwdata, 6732K rodata, 1600K init, 21008K bss, 1190208K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=16, Nodes=1
[    0.000000] Running RCU self tests
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU event tracing is enabled.
[    0.000000] 	RCU lockdep checking is enabled.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=16.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=16
[    0.000000] NR_IRQS: 4352, nr_irqs: 1096, preallocated irqs: 16
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.000000] ... MAX_LOCK_DEPTH:          48
[    0.000000] ... MAX_LOCKDEP_KEYS:        8191
[    0.000000] ... CLASSHASH_SIZE:          4096
[    0.000000] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.000000] ... MAX_LOCKDEP_CHAINS:      65536
[    0.000000] ... CHAINHASH_SIZE:          32768
[    0.000000]  memory used by lock dependency info: 7391 kB
[    0.000000]  per task-struct memory footprint: 1920 bytes
[    0.000000] ACPI: Core revision 20180531
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
[    0.000000] hpet clockevent registered
[    0.000000] APIC: Switch to symmetric I/O mode setup
[    0.000000] Switched APIC routing to physical flat.
[    0.001000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.006000] tsc: Fast TSC calibration failed
[    0.008000] tsc: PIT calibration matches HPET. 1 loops
[    0.008000] tsc: Detected 3593.321 MHz processor
[    0.008000] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x33cbadac57a, max_idle_ns: 440795202126 ns
[    0.008000] Calibrating delay loop (skipped), value calculated using timer frequency.. 7186.64 BogoMIPS (lpj=3593321)
[    0.008000] pid_max: default: 32768 minimum: 301
[    0.008000] Security Framework initialized
[    0.008000] SELinux:  Initializing.
[    0.008000] SELinux:  Starting in permissive mode
[    0.009825] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.010616] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.010667] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.010694] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.011352] CPU: Physical Processor ID: 0
[    0.011355] CPU: Processor Core ID: 0
[    0.011464] mce: CPU supports 23 MCE banks
[    0.011493] LVT offset 1 assigned for vector 0xf9
[    0.011561] LVT offset 2 assigned for vector 0xf4
[    0.011573] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 512
[    0.011576] Last level dTLB entries: 4KB 1536, 2MB 1536, 4MB 768, 1GB 0
[    0.011581] Spectre V2 : Mitigation: Full AMD retpoline
[    0.011584] Spectre V2 : Spectre v2 mitigation: Enabling Indirect Branch Prediction Barrier
[    0.011588] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
[    0.011888] Freeing SMP alternatives memory: 36K
[    0.013000] smpboot: CPU0: AMD Ryzen 5 2400G with Radeon Vega Graphics (family: 0x17, model: 0x11, stepping: 0x0)
[    0.013000] Performance Events: Fam17h core perfctr, AMD PMU driver.
[    0.013000] ... version:                0
[    0.013000] ... bit width:              48
[    0.013000] ... generic registers:      6
[    0.013000] ... value mask:             0000ffffffffffff
[    0.013000] ... max period:             00007fffffffffff
[    0.013000] ... fixed-purpose events:   0
[    0.013000] ... event mask:             000000000000003f
[    0.013000] Hierarchical SRCU implementation.
[    0.015007] MCE: In-kernel MCE decoding enabled.
[    0.015761] smp: Bringing up secondary CPUs ...
[    0.016336] x86: Booting SMP configuration:
[    0.016342] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7
[    0.029146] smp: Brought up 1 node, 8 CPUs
[    0.029146] smpboot: Max logical packages: 2
[    0.029146] smpboot: Total of 8 processors activated (57493.13 BogoMIPS)
[    0.032666] devtmpfs: initialized
[    0.035235] PM: Registering ACPI NVS region [mem 0x04000000-0x04009fff] (40960 bytes)
[    0.035235] PM: Registering ACPI NVS region [mem 0x9a7e5000-0x9ab9cfff] (3899392 bytes)
[    0.036541] kworker/u32:1 (52) used greatest stack depth: 21768 bytes left
[    0.038115] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.038115] futex hash table entries: 4096 (order: 7, 524288 bytes)
[    0.039790] RTC time: 15:47:12, date: 07/16/18
[    0.041970] NET: Registered protocol family 16
[    0.042480] audit: initializing netlink subsys (disabled)
[    0.042516] audit: type=2000 audit(1531756032.042:1): state=initialized audit_enabled=0 res=1
[    0.043302] cpuidle: using governor menu
[    0.043396] ACPI: bus type PCI registered
[    0.044089] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.044089] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
[    0.044089] PCI: Using configuration type 1 for base access
[    0.045115] mtrr: your CPUs had inconsistent variable MTRR settings
[    0.045115] mtrr: probably your BIOS does not setup all CPUs.
[    0.045115] mtrr: corrected configuration.
[    0.064069] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.064347] ACPI: Added _OSI(Module Device)
[    0.064350] ACPI: Added _OSI(Processor Device)
[    0.064354] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.064357] ACPI: Added _OSI(Processor Aggregator Device)
[    0.064362] ACPI: Added _OSI(Linux-Dell-Video)
[    0.111180] 
               3ACPI BIOS Error (bug): Failure creating [\_SB.SMIC], AE_ALREADY_EXISTS (20180531/dswload2-316)
[    0.111199] ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20180531/psobject-221)
[    0.111457] ACPI Error: Ignore error and continue table load (20180531/psobject-604)
[    0.111673] 
               3ACPI BIOS Error (bug): Failure creating [\_SB.SMIB], AE_ALREADY_EXISTS (20180531/dsfield-594)
[    0.112936] ACPI: 8 ACPI AML tables successfully acquired and loaded
[    0.133873] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.147359] ACPI: Interpreter enabled
[    0.147444] ACPI: (supports S0 S3 S4 S5)
[    0.147448] ACPI: Using IOAPIC for interrupt routing
[    0.149730] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.151222] ACPI: Enabled 3 GPEs in block 00 to 1F
[    0.169573] ACPI: Power Resource [P0ST] (on)
[    0.169798] ACPI: Power Resource [P3ST] (on)
[    0.206905] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.206918] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.208055] acpi PNP0A08:00: _OSC: platform does not support [PME LTR]
[    0.209113] acpi PNP0A08:00: _OSC: OS now controls [AER PCIeCapability]
[    0.209166] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000 [bus 00-3f] only partially covers this bridge
[    0.210278] PCI host bridge to bus 0000:00
[    0.210284] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    0.210289] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    0.210294] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
[    0.210298] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.210303] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.210308] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff window]
[    0.210313] pci_bus 0000:00: root bus resource [mem 0xe0000000-0xfec2ffff window]
[    0.210318] pci_bus 0000:00: root bus resource [mem 0xfee00000-0xffffffff window]
[    0.210323] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.210353] pci 0000:00:00.0: [1022:15d0] type 00 class 0x060000
[    0.210861] pci 0000:00:00.2: [1022:15d1] type 00 class 0x080600
[    0.211345] pci 0000:00:01.0: [1022:1452] type 00 class 0x060000
[    0.211738] pci 0000:00:01.2: [1022:15d3] type 01 class 0x060400
[    0.211896] pci 0000:00:01.2: PME# supported from D0 D3hot D3cold
[    0.212379] pci 0000:00:08.0: [1022:1452] type 00 class 0x060000
[    0.212775] pci 0000:00:08.1: [1022:15db] type 01 class 0x060400
[    0.212849] pci 0000:00:08.1: enabling Extended Tags
[    0.212940] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
[    0.213348] pci 0000:00:08.2: [1022:15dc] type 01 class 0x060400
[    0.213420] pci 0000:00:08.2: enabling Extended Tags
[    0.213505] pci 0000:00:08.2: PME# supported from D0 D3hot D3cold
[    0.213969] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500
[    0.214461] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100
[    0.214961] pci 0000:00:18.0: [1022:15e8] type 00 class 0x060000
[    0.215289] pci 0000:00:18.1: [1022:15e9] type 00 class 0x060000
[    0.215601] pci 0000:00:18.2: [1022:15ea] type 00 class 0x060000
[    0.215927] pci 0000:00:18.3: [1022:15eb] type 00 class 0x060000
[    0.216249] pci 0000:00:18.4: [1022:15ec] type 00 class 0x060000
[    0.216557] pci 0000:00:18.5: [1022:15ed] type 00 class 0x060000
[    0.216870] pci 0000:00:18.6: [1022:15ee] type 00 class 0x060000
[    0.217188] pci 0000:00:18.7: [1022:15ef] type 00 class 0x060000
[    0.217652] pci 0000:01:00.0: [1022:43bb] type 00 class 0x0c0330
[    0.217695] pci 0000:01:00.0: reg 0x10: [mem 0xfe8a0000-0xfe8a7fff 64bit]
[    0.217854] pci 0000:01:00.0: PME# supported from D3hot D3cold
[    0.218136] pci 0000:01:00.1: [1022:43b7] type 00 class 0x010601
[    0.218223] pci 0000:01:00.1: reg 0x24: [mem 0xfe880000-0xfe89ffff]
[    0.218239] pci 0000:01:00.1: reg 0x30: [mem 0xfe800000-0xfe87ffff pref]
[    0.218333] pci 0000:01:00.1: PME# supported from D3hot D3cold
[    0.218578] pci 0000:01:00.2: [1022:43b2] type 01 class 0x060400
[    0.218735] pci 0000:01:00.2: PME# supported from D3hot D3cold
[    0.219079] pci 0000:00:01.2: PCI bridge to [bus 01-05]
[    0.219090] pci 0000:00:01.2:   bridge window [io  0xf000-0xffff]
[    0.219097] pci 0000:00:01.2:   bridge window [mem 0xfe700000-0xfe8fffff]
[    0.219230] pci 0000:02:00.0: [1022:43b4] type 01 class 0x060400
[    0.219409] pci 0000:02:00.0: PME# supported from D3hot D3cold
[    0.219727] pci 0000:02:01.0: [1022:43b4] type 01 class 0x060400
[    0.219909] pci 0000:02:01.0: PME# supported from D3hot D3cold
[    0.220240] pci 0000:02:04.0: [1022:43b4] type 01 class 0x060400
[    0.220418] pci 0000:02:04.0: PME# supported from D3hot D3cold
[    0.220771] pci 0000:01:00.2: PCI bridge to [bus 02-05]
[    0.220782] pci 0000:01:00.2:   bridge window [io  0xf000-0xffff]
[    0.220790] pci 0000:01:00.2:   bridge window [mem 0xfe700000-0xfe7fffff]
[    0.220938] pci 0000:03:00.0: [10ec:8168] type 00 class 0x020000
[    0.221008] pci 0000:03:00.0: reg 0x10: [io  0xf000-0xf0ff]
[    0.221060] pci 0000:03:00.0: reg 0x18: [mem 0xfe704000-0xfe704fff 64bit]
[    0.221093] pci 0000:03:00.0: reg 0x20: [mem 0xfe700000-0xfe703fff 64bit]
[    0.221303] pci 0000:03:00.0: supports D1 D2
[    0.221307] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.221663] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.221674] pci 0000:02:00.0:   bridge window [io  0xf000-0xffff]
[    0.221681] pci 0000:02:00.0:   bridge window [mem 0xfe700000-0xfe7fffff]
[    0.221805] pci 0000:02:01.0: PCI bridge to [bus 04]
[    0.221931] pci 0000:02:04.0: PCI bridge to [bus 05]
[    0.222131] pci 0000:06:00.0: [1002:15dd] type 00 class 0x030000
[    0.222191] pci 0000:06:00.0: reg 0x10: [mem 0xe0000000-0xefffffff 64bit pref]
[    0.222217] pci 0000:06:00.0: reg 0x18: [mem 0xf0000000-0xf01fffff 64bit pref]
[    0.222235] pci 0000:06:00.0: reg 0x20: [io  0xe000-0xe0ff]
[    0.222252] pci 0000:06:00.0: reg 0x24: [mem 0xfe600000-0xfe67ffff]
[    0.222280] pci 0000:06:00.0: enabling Extended Tags
[    0.222440] pci 0000:06:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.222772] pci 0000:06:00.1: [1002:15de] type 00 class 0x040300
[    0.222813] pci 0000:06:00.1: reg 0x10: [mem 0xfe688000-0xfe68bfff]
[    0.222906] pci 0000:06:00.1: enabling Extended Tags
[    0.223036] pci 0000:06:00.1: PME# supported from D1 D2 D3hot D3cold
[    0.223327] pci 0000:06:00.2: [1022:15df] type 00 class 0x108000
[    0.223394] pci 0000:06:00.2: reg 0x18: [mem 0xfe500000-0xfe5fffff]
[    0.223438] pci 0000:06:00.2: reg 0x24: [mem 0xfe68c000-0xfe68dfff]
[    0.223466] pci 0000:06:00.2: enabling Extended Tags
[    0.223862] pci 0000:06:00.3: [1022:15e0] type 00 class 0x0c0330
[    0.223912] pci 0000:06:00.3: reg 0x10: [mem 0xfe400000-0xfe4fffff 64bit]
[    0.223992] pci 0000:06:00.3: enabling Extended Tags
[    0.224119] pci 0000:06:00.3: PME# supported from D0 D3hot D3cold
[    0.224426] pci 0000:06:00.4: [1022:15e1] type 00 class 0x0c0330
[    0.224475] pci 0000:06:00.4: reg 0x10: [mem 0xfe300000-0xfe3fffff 64bit]
[    0.224555] pci 0000:06:00.4: enabling Extended Tags
[    0.224670] pci 0000:06:00.4: PME# supported from D0 D3hot D3cold
[    0.224979] pci 0000:06:00.6: [1022:15e3] type 00 class 0x040300
[    0.225031] pci 0000:06:00.6: reg 0x10: [mem 0xfe680000-0xfe687fff]
[    0.225124] pci 0000:06:00.6: enabling Extended Tags
[    0.225230] pci 0000:06:00.6: PME# supported from D0 D3hot D3cold
[    0.225607] pci 0000:00:08.1: PCI bridge to [bus 06]
[    0.225618] pci 0000:00:08.1:   bridge window [io  0xe000-0xefff]
[    0.225625] pci 0000:00:08.1:   bridge window [mem 0xfe300000-0xfe6fffff]
[    0.225636] pci 0000:00:08.1:   bridge window [mem 0xe0000000-0xf01fffff 64bit pref]
[    0.225780] pci 0000:07:00.0: [1022:7901] type 00 class 0x010601
[    0.225889] pci 0000:07:00.0: reg 0x24: [mem 0xfe900000-0xfe9007ff]
[    0.225916] pci 0000:07:00.0: enabling Extended Tags
[    0.226055] pci 0000:07:00.0: PME# supported from D3hot D3cold
[    0.226364] pci 0000:00:08.2: PCI bridge to [bus 07]
[    0.226378] pci 0000:00:08.2:   bridge window [mem 0xfe900000-0xfe9fffff]
[    0.228872] ACPI: PCI Interrupt Link [LNKA] (IRQs 4 5 7 10 11 14 15) *0
[    0.229187] ACPI: PCI Interrupt Link [LNKB] (IRQs 4 5 7 10 11 14 15) *0
[    0.229468] ACPI: PCI Interrupt Link [LNKC] (IRQs 4 5 7 10 11 14 15) *0
[    0.229783] ACPI: PCI Interrupt Link [LNKD] (IRQs 4 5 7 10 11 14 15) *0
[    0.230093] ACPI: PCI Interrupt Link [LNKE] (IRQs 4 5 7 10 11 14 15) *0
[    0.230347] ACPI: PCI Interrupt Link [LNKF] (IRQs 4 5 7 10 11 14 15) *0
[    0.230618] ACPI: PCI Interrupt Link [LNKG] (IRQs 4 5 7 10 11 14 15) *0
[    0.230882] ACPI: PCI Interrupt Link [LNKH] (IRQs 4 5 7 10 11 14 15) *0
[    0.233564] pci 0000:06:00.0: vgaarb: setting as boot VGA device
[    0.233564] pci 0000:06:00.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.233564] pci 0000:06:00.0: vgaarb: bridge control possible
[    0.233564] vgaarb: loaded
[    0.234238] SCSI subsystem initialized
[    0.234329] libata version 3.00 loaded.
[    0.234370] ACPI: bus type USB registered
[    0.234476] usbcore: registered new interface driver usbfs
[    0.234549] usbcore: registered new interface driver hub
[    0.235110] usbcore: registered new device driver usb
[    0.235249] pps_core: LinuxPPS API ver. 1 registered
[    0.235253] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
[    0.235282] PTP clock support registered
[    0.235459] EDAC MC: Ver: 3.0.0
[    0.236212] Advanced Linux Sound Architecture Driver Initialized.
[    0.236334] PCI: Using ACPI for IRQ routing
[    0.241634] PCI: pci_cache_line_size set to 64 bytes
[    0.241769] e820: reserve RAM buffer [mem 0x0009d400-0x0009ffff]
[    0.241776] e820: reserve RAM buffer [mem 0x09c00000-0x0bffffff]
[    0.241781] e820: reserve RAM buffer [mem 0x0b000000-0x0bffffff]
[    0.241785] e820: reserve RAM buffer [mem 0x96464000-0x97ffffff]
[    0.241789] e820: reserve RAM buffer [mem 0x9a5be000-0x9bffffff]
[    0.241794] e820: reserve RAM buffer [mem 0x9a7e5000-0x9bffffff]
[    0.241798] e820: reserve RAM buffer [mem 0x9e000000-0x9fffffff]
[    0.241802] e820: reserve RAM buffer [mem 0x21f340000-0x21fffffff]
[    0.242533] NetLabel: Initializing
[    0.242536] NetLabel:  domain hash size = 128
[    0.242538] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.242603] NetLabel:  unlabeled traffic allowed by default
[    0.243058] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.243070] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.245153] clocksource: Switched to clocksource tsc-early
[    0.326524] VFS: Disk quotas dquot_6.6.0
[    0.326567] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.326837] pnp: PnP ACPI init
[    0.327281] system 00:00: [mem 0xf8000000-0xfbffffff] has been reserved
[    0.327373] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.327718] system 00:01: [mem 0xfeb80000-0xfebfffff] has been reserved
[    0.327749] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.328338] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.328993] system 00:03: [io  0x0300-0x030f] has been reserved
[    0.328999] system 00:03: [io  0x0230-0x023f] has been reserved
[    0.329005] system 00:03: [io  0x0290-0x029f] has been reserved
[    0.329031] system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.330209] pnp 00:04: [dma 0 disabled]
[    0.330358] pnp 00:04: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.331244] system 00:05: [io  0x04d0-0x04d1] has been reserved
[    0.331253] system 00:05: [io  0x040b] has been reserved
[    0.331262] system 00:05: [io  0x04d6] has been reserved
[    0.331271] system 00:05: [io  0x0c00-0x0c01] has been reserved
[    0.331280] system 00:05: [io  0x0c14] has been reserved
[    0.331289] system 00:05: [io  0x0c50-0x0c51] has been reserved
[    0.331297] system 00:05: [io  0x0c52] has been reserved
[    0.331306] system 00:05: [io  0x0c6c] has been reserved
[    0.331313] system 00:05: [io  0x0c6f] has been reserved
[    0.331319] system 00:05: [io  0x0cd0-0x0cd1] has been reserved
[    0.331325] system 00:05: [io  0x0cd2-0x0cd3] has been reserved
[    0.331330] system 00:05: [io  0x0cd4-0x0cd5] has been reserved
[    0.331336] system 00:05: [io  0x0cd6-0x0cd7] has been reserved
[    0.331342] system 00:05: [io  0x0cd8-0x0cdf] has been reserved
[    0.331348] system 00:05: [io  0x0800-0x089f] has been reserved
[    0.331353] system 00:05: [io  0x0b00-0x0b0f] has been reserved
[    0.331359] system 00:05: [io  0x0b20-0x0b3f] has been reserved
[    0.331365] system 00:05: [io  0x0900-0x090f] has been reserved
[    0.331371] system 00:05: [io  0x0910-0x091f] has been reserved
[    0.331379] system 00:05: [mem 0xfec00000-0xfec00fff] could not be reserved
[    0.331388] system 00:05: [mem 0xfec01000-0xfec01fff] could not be reserved
[    0.331394] system 00:05: [mem 0xfedc0000-0xfedc0fff] has been reserved
[    0.331400] system 00:05: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.331407] system 00:05: [mem 0xfed80000-0xfed8ffff] could not be reserved
[    0.331413] system 00:05: [mem 0xfec10000-0xfec10fff] has been reserved
[    0.331419] system 00:05: [mem 0xff000000-0xffffffff] has been reserved
[    0.331447] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.333626] pnp: PnP ACPI: found 6 devices
[    0.347606] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.347699] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.347706] pci 0000:02:00.0:   bridge window [io  0xf000-0xffff]
[    0.347715] pci 0000:02:00.0:   bridge window [mem 0xfe700000-0xfe7fffff]
[    0.347728] pci 0000:02:01.0: PCI bridge to [bus 04]
[    0.347746] pci 0000:02:04.0: PCI bridge to [bus 05]
[    0.347773] pci 0000:01:00.2: PCI bridge to [bus 02-05]
[    0.347779] pci 0000:01:00.2:   bridge window [io  0xf000-0xffff]
[    0.347787] pci 0000:01:00.2:   bridge window [mem 0xfe700000-0xfe7fffff]
[    0.347800] pci 0000:00:01.2: PCI bridge to [bus 01-05]
[    0.347805] pci 0000:00:01.2:   bridge window [io  0xf000-0xffff]
[    0.347814] pci 0000:00:01.2:   bridge window [mem 0xfe700000-0xfe8fffff]
[    0.347828] pci 0000:00:08.1: PCI bridge to [bus 06]
[    0.347833] pci 0000:00:08.1:   bridge window [io  0xe000-0xefff]
[    0.347842] pci 0000:00:08.1:   bridge window [mem 0xfe300000-0xfe6fffff]
[    0.347849] pci 0000:00:08.1:   bridge window [mem 0xe0000000-0xf01fffff 64bit pref]
[    0.347859] pci 0000:00:08.2: PCI bridge to [bus 07]
[    0.347868] pci 0000:00:08.2:   bridge window [mem 0xfe900000-0xfe9fffff]
[    0.347883] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    0.347887] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
[    0.347891] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
[    0.347894] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    0.347898] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff window]
[    0.347902] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff window]
[    0.347906] pci_bus 0000:00: resource 10 [mem 0xe0000000-0xfec2ffff window]
[    0.347910] pci_bus 0000:00: resource 11 [mem 0xfee00000-0xffffffff window]
[    0.347914] pci_bus 0000:01: resource 0 [io  0xf000-0xffff]
[    0.347917] pci_bus 0000:01: resource 1 [mem 0xfe700000-0xfe8fffff]
[    0.347921] pci_bus 0000:02: resource 0 [io  0xf000-0xffff]
[    0.347925] pci_bus 0000:02: resource 1 [mem 0xfe700000-0xfe7fffff]
[    0.347929] pci_bus 0000:03: resource 0 [io  0xf000-0xffff]
[    0.347933] pci_bus 0000:03: resource 1 [mem 0xfe700000-0xfe7fffff]
[    0.347937] pci_bus 0000:06: resource 0 [io  0xe000-0xefff]
[    0.347940] pci_bus 0000:06: resource 1 [mem 0xfe300000-0xfe6fffff]
[    0.347944] pci_bus 0000:06: resource 2 [mem 0xe0000000-0xf01fffff 64bit pref]
[    0.347948] pci_bus 0000:07: resource 1 [mem 0xfe900000-0xfe9fffff]
[    0.348378] NET: Registered protocol family 2
[    0.349023] tcp_listen_portaddr_hash hash table entries: 4096 (order: 6, 294912 bytes)
[    0.349467] TCP established hash table entries: 65536 (order: 7, 524288 bytes)
[    0.350271] TCP bind hash table entries: 65536 (order: 10, 4194304 bytes)
[    0.356117] TCP: Hash tables configured (established 65536 bind 65536)
[    0.356466] UDP hash table entries: 4096 (order: 7, 655360 bytes)
[    0.357318] UDP-Lite hash table entries: 4096 (order: 7, 655360 bytes)
[    0.358376] NET: Registered protocol family 1
[    0.359028] RPC: Registered named UNIX socket transport module.
[    0.359033] RPC: Registered udp transport module.
[    0.359036] RPC: Registered tcp transport module.
[    0.359039] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.360291] pci 0000:06:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.360349] pci 0000:06:00.1: Linked as a consumer to 0000:06:00.0
[    0.361927] PCI: CLS 64 bytes, default 64
[    0.362321] Unpacking initramfs...
[    1.152154] Freeing initrd memory: 26336K
[    1.510964] AMD-Vi: Unable to write to IOMMU perf counter.
[    1.511491] pci 0000:00:00.2: can't derive routing for PCI INT A
[    1.511495] pci 0000:00:00.2: PCI INT A: not connected
[    1.512479] iommu: Adding device 0000:00:01.0 to group 0
[    1.512859] iommu: Adding device 0000:00:01.2 to group 1
[    1.513219] iommu: Adding device 0000:00:08.0 to group 2
[    1.513600] iommu: Adding device 0000:00:08.1 to group 3
[    1.513677] iommu: Adding device 0000:00:08.2 to group 2
[    1.514020] iommu: Adding device 0000:00:14.0 to group 4
[    1.514094] iommu: Adding device 0000:00:14.3 to group 4
[    1.514640] iommu: Adding device 0000:00:18.0 to group 5
[    1.514716] iommu: Adding device 0000:00:18.1 to group 5
[    1.514790] iommu: Adding device 0000:00:18.2 to group 5
[    1.514863] iommu: Adding device 0000:00:18.3 to group 5
[    1.514939] iommu: Adding device 0000:00:18.4 to group 5
[    1.515025] iommu: Adding device 0000:00:18.5 to group 5
[    1.515102] iommu: Adding device 0000:00:18.6 to group 5
[    1.515175] iommu: Adding device 0000:00:18.7 to group 5
[    1.515552] iommu: Adding device 0000:01:00.0 to group 6
[    1.515643] iommu: Adding device 0000:01:00.1 to group 6
[    1.515737] iommu: Adding device 0000:01:00.2 to group 6
[    1.515785] iommu: Adding device 0000:02:00.0 to group 6
[    1.515831] iommu: Adding device 0000:02:01.0 to group 6
[    1.515878] iommu: Adding device 0000:02:04.0 to group 6
[    1.515935] iommu: Adding device 0000:03:00.0 to group 6
[    1.516427] iommu: Adding device 0000:06:00.0 to group 7
[    1.516598] iommu: Using direct mapping for device 0000:06:00.0
[    1.517040] iommu: Adding device 0000:06:00.1 to group 8
[    1.517145] iommu: Adding device 0000:06:00.2 to group 8
[    1.517247] iommu: Adding device 0000:06:00.3 to group 8
[    1.517351] iommu: Adding device 0000:06:00.4 to group 8
[    1.517454] iommu: Adding device 0000:06:00.6 to group 8
[    1.517497] iommu: Adding device 0000:07:00.0 to group 2
[    1.517810] AMD-Vi: Found IOMMU at 0000:00:00.2 cap 0x40
[    1.517813] AMD-Vi: Extended features (0x4f77ef22294ada):
[    1.517815]  PPR NX GT IA GA PC GA_vAPIC
[    1.518399] AMD-Vi: Lazy IO/TLB flushing enabled
[    1.526894] amd_uncore: AMD NB counters detected
[    1.526917] amd_uncore: AMD LLC counters detected
[    1.533502] Scanning for low memory corruption every 60 seconds
[    1.537654] Initialise system trusted keyrings
[    1.537989] workingset: timestamp_bits=56 max_order=21 bucket_order=0
[    1.557983] NFS: Registering the id_resolver key type
[    1.558048] Key type id_resolver registered
[    1.558054] Key type id_legacy registered
[    1.558590] SELinux:  Registering netfilter hooks
[    1.562407] Key type asymmetric registered
[    1.562422] Asymmetric key parser 'x509' registered
[    1.562571] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
[    1.562594] io scheduler noop registered
[    1.562599] io scheduler deadline registered
[    1.562839] io scheduler cfq registered (default)
[    1.562845] io scheduler mq-deadline registered
[    1.562850] io scheduler kyber registered
[    1.566767] pcieport 0000:00:01.2: AER enabled with IRQ 26
[    1.567465] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    1.567514] ACPI: Power Button [PWRB]
[    1.567676] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    1.567791] ACPI: Power Button [PWRF]
[    1.568372] Monitor-Mwait will be used to enter C-1 state
[    1.573061] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.594176] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    1.596741] Non-volatile memory driver v1.3
[    1.596914] Linux agpgart interface v0.103
[    1.618388] loop: module loaded
[    1.618857] ahci 0000:01:00.1: version 3.0
[    1.619208] ahci 0000:01:00.1: SSS flag set, parallel bus scan disabled
[    1.619268] ahci 0000:01:00.1: AHCI 0001.0301 32 slots 8 ports 6 Gbps 0x33 impl SATA mode
[    1.619274] ahci 0000:01:00.1: flags: 64bit ncq sntf stag pm led clo only pmp pio slum part sxs deso sadm sds apst 
[    1.622398] scsi host0: ahci
[    1.623119] scsi host1: ahci
[    1.623656] scsi host2: ahci
[    1.624239] scsi host3: ahci
[    1.624758] scsi host4: ahci
[    1.625299] scsi host5: ahci
[    1.625782] scsi host6: ahci
[    1.626225] scsi host7: ahci
[    1.626408] ata1: SATA max UDMA/133 abar m131072@0xfe880000 port 0xfe880100 irq 34
[    1.626413] ata2: SATA max UDMA/133 abar m131072@0xfe880000 port 0xfe880180 irq 34
[    1.626416] ata3: DUMMY
[    1.626419] ata4: DUMMY
[    1.626423] ata5: SATA max UDMA/133 abar m131072@0xfe880000 port 0xfe880300 irq 34
[    1.626428] ata6: SATA max UDMA/133 abar m131072@0xfe880000 port 0xfe880380 irq 34
[    1.626431] ata7: DUMMY
[    1.626433] ata8: DUMMY
[    1.626976] ahci 0000:07:00.0: AHCI 0001.0301 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
[    1.626982] ahci 0000:07:00.0: flags: 64bit ncq sntf ilck pm led clo only pmp fbs pio slum part 
[    1.627712] scsi host8: ahci
[    1.628109] ata9: SATA max UDMA/133 abar m2048@0xfe900000 port 0xfe900100 irq 36
[    1.628736] e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2-NAPI
[    1.628740] e100: Copyright(c) 1999-2006 Intel Corporation
[    1.628831] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
[    1.628836] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    1.628925] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    1.628928] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    1.629047] sky2: driver version 1.30
[    1.629341] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[    1.633808] r8169 0000:03:00.0 eth0: RTL8168h/8111h, b0:6e:bf:2f:47:8d, XID 54100800, IRQ 37
[    1.633813] r8169 0000:03:00.0 eth0: jumbo features [frames: 9200 bytes, tx checksumming: ko]
[    1.634316] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.634320] ehci-pci: EHCI PCI platform driver
[    1.634378] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.634395] ohci-pci: OHCI PCI platform driver
[    1.634455] uhci_hcd: USB Universal Host Controller Interface driver
[    1.634908] xhci_hcd 0000:01:00.0: xHCI Host Controller
[    1.635318] xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 1
[    1.690876] xhci_hcd 0000:01:00.0: hcc params 0x0200ef81 hci version 0x110 quirks 0x0000000048000410
[    1.692251] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.18
[    1.692260] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.692264] usb usb1: Product: xHCI Host Controller
[    1.692268] usb usb1: Manufacturer: Linux 4.18.0-rc1+ xhci-hcd
[    1.692272] usb usb1: SerialNumber: 0000:01:00.0
[    1.693101] hub 1-0:1.0: USB hub found
[    1.693200] hub 1-0:1.0: 10 ports detected
[    1.761637] xhci_hcd 0000:01:00.0: xHCI Host Controller
[    1.761954] xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 2
[    1.761968] xhci_hcd 0000:01:00.0: Host supports USB 3.10 Enhanced SuperSpeed
[    1.762152] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[    1.762343] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 4.18
[    1.762348] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.762351] usb usb2: Product: xHCI Host Controller
[    1.762355] usb usb2: Manufacturer: Linux 4.18.0-rc1+ xhci-hcd
[    1.762359] usb usb2: SerialNumber: 0000:01:00.0
[    1.763155] hub 2-0:1.0: USB hub found
[    1.763225] hub 2-0:1.0: 4 ports detected
[    1.789422] xhci_hcd 0000:06:00.3: xHCI Host Controller
[    1.789720] xhci_hcd 0000:06:00.3: new USB bus registered, assigned bus number 3
[    1.789975] xhci_hcd 0000:06:00.3: hcc params 0x0270ffe5 hci version 0x110 quirks 0x0000000040000410
[    1.791396] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.18
[    1.791401] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.791405] usb usb3: Product: xHCI Host Controller
[    1.791408] usb usb3: Manufacturer: Linux 4.18.0-rc1+ xhci-hcd
[    1.791412] usb usb3: SerialNumber: 0000:06:00.3
[    1.791901] hub 3-0:1.0: USB hub found
[    1.791948] hub 3-0:1.0: 4 ports detected
[    1.793062] xhci_hcd 0000:06:00.3: xHCI Host Controller
[    1.793248] xhci_hcd 0000:06:00.3: new USB bus registered, assigned bus number 4
[    1.793258] xhci_hcd 0000:06:00.3: Host supports USB 3.10 Enhanced SuperSpeed
[    1.793353] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
[    1.793482] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 4.18
[    1.793487] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.793490] usb usb4: Product: xHCI Host Controller
[    1.793494] usb usb4: Manufacturer: Linux 4.18.0-rc1+ xhci-hcd
[    1.793498] usb usb4: SerialNumber: 0000:06:00.3
[    1.794030] hub 4-0:1.0: USB hub found
[    1.794071] hub 4-0:1.0: 4 ports detected
[    1.795340] xhci_hcd 0000:06:00.4: xHCI Host Controller
[    1.795532] xhci_hcd 0000:06:00.4: new USB bus registered, assigned bus number 5
[    1.795765] xhci_hcd 0000:06:00.4: hcc params 0x0260ffe5 hci version 0x110 quirks 0x0000000040000410
[    1.796989] usb usb5: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.18
[    1.796994] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.796998] usb usb5: Product: xHCI Host Controller
[    1.797018] usb usb5: Manufacturer: Linux 4.18.0-rc1+ xhci-hcd
[    1.797021] usb usb5: SerialNumber: 0000:06:00.4
[    1.797480] hub 5-0:1.0: USB hub found
[    1.797522] hub 5-0:1.0: 1 port detected
[    1.797957] xhci_hcd 0000:06:00.4: xHCI Host Controller
[    1.798142] xhci_hcd 0000:06:00.4: new USB bus registered, assigned bus number 6
[    1.798152] xhci_hcd 0000:06:00.4: Host supports USB 3.10 Enhanced SuperSpeed
[    1.798252] usb usb6: We don't know the algorithms for LPM for this host, disabling LPM.
[    1.798380] usb usb6: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 4.18
[    1.798385] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.798388] usb usb6: Product: xHCI Host Controller
[    1.798392] usb usb6: Manufacturer: Linux 4.18.0-rc1+ xhci-hcd
[    1.798396] usb usb6: SerialNumber: 0000:06:00.4
[    1.798858] hub 6-0:1.0: USB hub found
[    1.798898] hub 6-0:1.0: 1 port detected
[    1.799414] usbcore: registered new interface driver usblp
[    1.799495] usbcore: registered new interface driver usb-storage
[    1.799599] i8042: PNP: No PS/2 controller found.
[    1.800449] rtc_cmos 00:02: RTC can wake from S4
[    1.800879] rtc_cmos 00:02: registered as rtc0
[    1.800969] rtc_cmos 00:02: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    1.801846] device-mapper: ioctl: 4.39.0-ioctl (2018-04-03) initialised: dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
[    1.801924] hidraw: raw HID events driver (C) Jiri Kosina
[    1.803074] usbcore: registered new interface driver usbhid
[    1.803076] usbhid: USB HID core driver
[    1.806683] Initializing XFRM netlink socket
[    1.808560] hdaudio hdaudioC0D0: Unable to bind the codec
[    1.808911] NET: Registered protocol family 10
[    1.810759] Segment Routing with IPv6
[    1.811441] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    1.812032] NET: Registered protocol family 17
[    1.812130] Key type dns_resolver registered
[    1.818474] hdaudio hdaudioC1D0: Unable to bind the codec
[    1.822627] microcode: CPU0: patch_level=0x0810100b
[    1.822644] microcode: CPU1: patch_level=0x0810100b
[    1.822660] microcode: CPU2: patch_level=0x0810100b
[    1.822684] microcode: CPU3: patch_level=0x0810100b
[    1.822708] microcode: CPU4: patch_level=0x0810100b
[    1.822724] microcode: CPU5: patch_level=0x0810100b
[    1.822740] microcode: CPU6: patch_level=0x0810100b
[    1.822754] microcode: CPU7: patch_level=0x0810100b
[    1.822900] microcode: Microcode Update Driver: v2.2.
[    1.822973] sched_clock: Marking stable (1822873480, 0)->(1940992670, -118119190)
[    1.823818] registered taskstats version 1
[    1.823821] Loading compiled-in X.509 certificates
[    1.823959] Unable to create integrity sysfs dir: -19
[    1.825820]   Magic number: 10:36:791
[    1.826085] console [netcon0] enabled
[    1.826087] netconsole: network logging started
[    1.826645] acpi_cpufreq: overriding BIOS provided _PSD data
[    1.828624] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    1.836186] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    1.836620] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[    1.836658] cfg80211: failed to load regulatory.db
[    1.836855] ALSA device list:
[    1.836860]   No soundcards found.
[    1.934930] ata9: SATA link down (SStatus 0 SControl 300)
[    2.081046] usb 1-1: new high-speed USB device number 2 using xhci_hcd
[    2.095125] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    2.102106] ata1.00: ATA-8: KINGSTON SV300S37A120G, 608ABBF0, max UDMA/133
[    2.102113] ata1.00: 234441648 sectors, multi 1: LBA48 NCQ (depth 32), AA
[    2.111301] ata1.00: configured for UDMA/133
[    2.112400] scsi 0:0:0:0: Direct-Access     ATA      KINGSTON SV300S3 BBF0 PQ: 0 ANSI: 5
[    2.115231] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    2.115271] sd 0:0:0:0: [sda] 234441648 512-byte logical blocks: (120 GB/112 GiB)
[    2.115411] sd 0:0:0:0: [sda] Write Protect is off
[    2.115418] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.115585] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.118478]  sda: sda1 sda2 sda3
[    2.120864] sd 0:0:0:0: [sda] Attached SCSI disk
[    2.219874] usb 1-1: New USB device found, idVendor=0409, idProduct=005a, bcdDevice= 1.00
[    2.219903] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.227116] hub 1-1:1.0: USB hub found
[    2.229802] hub 1-1:1.0: 4 ports detected
[    2.329376] usb 2-2: new SuperSpeed Gen 1 USB device number 2 using xhci_hcd
[    2.352320] usb 2-2: New USB device found, idVendor=2001, idProduct=4a00, bcdDevice= 1.00
[    2.352328] usb 2-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    2.352334] usb 2-2: Product: D-Link DUB-1312
[    2.352340] usb 2-2: Manufacturer: D-Link Elec. Corp.
[    2.352345] usb 2-2: SerialNumber: 000000000018A9
[    2.425067] ata2: SATA link down (SStatus 0 SControl 300)
[    2.559429] usb 1-1.4: new low-speed USB device number 3 using xhci_hcd
[    2.591621] tsc: Refined TSC clocksource calibration: 3596.228 MHz
[    2.591665] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x33d6683f6ad, max_idle_ns: 440795366631 ns
[    2.591983] clocksource: Switched to clocksource tsc
[    2.732898] ata5: SATA link down (SStatus 0 SControl 300)
[    2.883666] usb 1-1.4: New USB device found, idVendor=046d, idProduct=c31c, bcdDevice=64.00
[    2.883681] usb 1-1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.883691] usb 1-1.4: Product: USB Keyboard
[    2.883702] usb 1-1.4: Manufacturer: Logitech
[    3.001740] input: Logitech USB Keyboard as /devices/pci0000:00/0000:00:01.2/0000:01:00.0/usb1/1-1/1-1.4/1-1.4:1.0/0003:046D:C31C.0001/input/input2
[    3.048984] ata6: SATA link down (SStatus 0 SControl 300)
[    3.052763] Freeing unused kernel memory: 1600K
[    3.056291] hid-generic 0003:046D:C31C.0001: input,hidraw0: USB HID v1.10 Keyboard [Logitech USB Keyboard] on usb-0000:01:00.0-1.4/input0
[    3.057067] Write protecting the kernel read-only data: 32768k
[    3.058971] Freeing unused kernel memory: 2004K
[    3.064785] Freeing unused kernel memory: 1460K
[    3.105216] systemd[1]: systemd 238 running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=hybrid)
[    3.118991] systemd[1]: Detected architecture x86-64.
[    3.118999] systemd[1]: Running in initial RAM disk.
[    3.122303] systemd[1]: Set hostname to <raven>.
[    3.180296] input: Logitech USB Keyboard Consumer Control as /devices/pci0000:00/0000:00:01.2/0000:01:00.0/usb1/1-1/1-1.4/1-1.4:1.1/0003:046D:C31C.0002/input/input3
[    3.216691] systemd[1]: File /usr/lib/systemd/system/systemd-journald.service:35 configures an IP firewall (IPAddressDeny=any), but the local system does not support BPF/cgroup based firewalling.
[    3.216699] systemd[1]: Proceeding WITHOUT firewalling in effect! (This warning is only shown for the first loaded unit using IP firewalling.)
[    3.224510] random: systemd: uninitialized urandom read (16 bytes read)
[    3.224710] systemd[1]: Listening on Journal Audit Socket.
[    3.224833] random: systemd: uninitialized urandom read (16 bytes read)
[    3.224860] systemd[1]: Reached target Local File Systems.
[    3.224877] random: systemd: uninitialized urandom read (16 bytes read)
[    3.225253] systemd[1]: Listening on Journal Socket (/dev/log).
[    3.225601] systemd[1]: Listening on udev Control Socket.
[    3.232804] input: Logitech USB Keyboard System Control as /devices/pci0000:00/0000:00:01.2/0000:01:00.0/usb1/1-1/1-1.4/1-1.4:1.1/0003:046D:C31C.0002/input/input4
[    3.233348] input: Logitech USB Keyboard Consumer Control as /devices/pci0000:00/0000:00:01.2/0000:01:00.0/usb1/1-1/1-1.4/1-1.4:1.1/0003:046D:C31C.0002/input/input5
[    3.233888] hid-generic 0003:046D:C31C.0002: input,hidraw1: USB HID v1.10 Device [Logitech USB Keyboard] on usb-0000:01:00.0-1.4/input1
[    3.249933] systemd-sysctl (1455) used greatest stack depth: 21520 bytes left
[    3.253160] audit: type=1130 audit(1531756035.251:2): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-sysctl comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    3.257891] audit: type=1130 audit(1531756035.256:3): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-tmpfiles-setup-dev comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    3.265337] audit: type=1130 audit(1531756035.264:4): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-tmpfiles-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    3.277219] input: Logitech USB Keyboard as /devices/pci0000:00/0000:00:01.2/0000:01:00.0/usb1/1-1/1-1.4/1-1.4:1.2/0003:046D:C31C.0003/input/input6
[    3.277984] hid-generic 0003:046D:C31C.0003: input,hidraw2: USB HID v1.10 Mouse [Logitech USB Keyboard] on usb-0000:01:00.0-1.4/input2
[    3.354115] audit: type=1130 audit(1531756035.353:5): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-cmdline comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    3.403719] audit: type=1130 audit(1531756035.402:6): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-pre-udev comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    3.410095] audit: type=1130 audit(1531756035.409:7): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-vconsole-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    3.410144] audit: type=1131 audit(1531756035.409:8): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-vconsole-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    3.427171] audit: type=1130 audit(1531756035.426:9): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-udevd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    3.483328] audit: type=1130 audit(1531756035.482:10): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-journald comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    3.515321] udevadm (1568) used greatest stack depth: 21488 bytes left
[    3.882242] ata_id (2350) used greatest stack depth: 20896 bytes left
[    3.900454] r8169 0000:03:00.0 enp3s0: renamed from eth0
[    4.235346] ax88179_178a 2-2:1.0 eth0: register 'ax88179_178a' at usb-0000:01:00.0-2, D-Link DUB-1312 USB 3.0 to Gigabit Ethernet Adapter, 54:b8:0a:ef:ed:d7
[    4.235976] usbcore: registered new interface driver ax88179_178a
[    4.243364] ax88179_178a 2-2:1.0 enp1s0f0u2: renamed from eth0
[    4.276592] systemd-udevd (2243) used greatest stack depth: 20392 bytes left
[    4.277597] systemd-udevd (1858) used greatest stack depth: 20256 bytes left
[    4.278914] systemd-udevd (2131) used greatest stack depth: 19808 bytes left
[    4.305211] random: fast init done
[    4.322878] fsck.ext4 (2383) used greatest stack depth: 19640 bytes left
[    4.347880] EXT4-fs (sda3): mounted filesystem with ordered data mode. Opts: (null)
[    4.384902] systemd-fstab-g (2394) used greatest stack depth: 18376 bytes left
[    4.920037] systemd-journald[1454]: Received SIGTERM from PID 1 (systemd).
[    5.022645] systemd: 23 output lines suppressed due to ratelimiting
[    5.117951] SELinux:  Disabled at runtime.
[    5.118288] SELinux:  Unregistering netfilter hooks
[    5.145240] kauditd_printk_skb: 32 callbacks suppressed
[    5.145244] audit: type=1404 audit(1531756037.144:43): enforcing=0 old_enforcing=0 auid=4294967295 ses=4294967295 enabled=0 old-enabled=1 lsm=selinux res=1
[    5.178506] systemd[1]: systemd 238 running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=hybrid)
[    5.191870] systemd[1]: Detected architecture x86-64.
[    5.192975] systemd[1]: Set hostname to <raven>.
[    5.263233] anaconda-genera (2454) used greatest stack depth: 17400 bytes left
[    5.325960] systemd[1]: File /usr/lib/systemd/system/systemd-journald.service:35 configures an IP firewall (IPAddressDeny=any), but the local system does not support BPF/cgroup based firewalling.
[    5.325968] systemd[1]: Proceeding WITHOUT firewalling in effect! (This warning is only shown for the first loaded unit using IP firewalling.)
[    5.394707] systemd[1]: /usr/lib/systemd/system/virtlockd-admin.socket:7: Unknown lvalue 'Server' in section 'Socket'
[    5.441728] audit: type=1130 audit(1531756037.440:44): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-journald comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.441759] audit: type=1131 audit(1531756037.440:45): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-journald comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.443190] systemd[1]: Stopped Switch Root.
[    5.443383] audit: type=1130 audit(1531756037.442:46): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=initrd-switch-root comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.443405] audit: type=1131 audit(1531756037.442:47): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=initrd-switch-root comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.443681] systemd[1]: systemd-journald.service: Service has no hold-off time, scheduling restart.
[    5.443758] systemd[1]: systemd-journald.service: Scheduled restart job, restart counter is at 1.
[    5.443782] systemd[1]: Stopped Journal Service.
[    5.444234] audit: type=1130 audit(1531756037.442:48): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-journald comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.444255] audit: type=1131 audit(1531756037.442:49): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-journald comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.462293] audit: type=1305 audit(1531756037.461:50): audit_enabled=1 old=1 auid=4294967295 ses=4294967295 res=1
[    5.495667] audit: type=1130 audit(1531756037.494:51): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-journald comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.498462] audit: type=1130 audit(1531756037.497:52): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=kmod-static-nodes comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.510240] EXT4-fs (sda3): re-mounted. Opts: (null)
[    5.538524] systemd-journald[2475]: Received request to flush runtime journal from PID 1
[    6.309423] Adding 7826428k swap on /dev/sda2.  Priority:-2 extents:1 across:7826428k SS
[    6.594646] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[    6.875032] random: crng init done
[    6.875038] random: 7 urandom warning(s) missed due to ratelimiting
[    7.282963] IPv6: ADDRCONF(NETDEV_UP): enp1s0f0u2: link is not ready
[    7.641785] IPv6: ADDRCONF(NETDEV_UP): enp1s0f0u2: link is not ready
[    7.647761] IPv6: ADDRCONF(NETDEV_UP): enp3s0: link is not ready
[    7.687051] r8169 0000:03:00.0 enp3s0: link down
[    7.687229] IPv6: ADDRCONF(NETDEV_UP): enp3s0: link is not ready
[   10.598923] ax88179_178a 2-2:1.0 enp1s0f0u2: ax88179 - Link status is: 1
[   10.618514] IPv6: ADDRCONF(NETDEV_CHANGE): enp1s0f0u2: link becomes ready
[  285.689898] [drm] amdgpu kernel modesetting enabled.
[  285.716093] Parsing CRAT table with 1 nodes
[  285.716143] Creating topology SYSFS entries
[  285.716356] Topology: Add APU node [0x0:0x0]
[  285.716358] Finished initializing topology
[  285.716523] kfd kfd: Initialized module
[  285.720375] [drm] initializing kernel modesetting (RAVEN 0x1002:0x15DD 0x1043:0x876B 0xC6).
[  285.720449] [drm] register mmio base: 0xFE600000
[  285.720452] [drm] register mmio size: 524288
[  285.720500] [drm] add ip block number 0 <soc15_common>
[  285.720503] [drm] add ip block number 1 <gmc_v9_0>
[  285.720507] [drm] add ip block number 2 <vega10_ih>
[  285.720511] [drm] add ip block number 3 <psp>
[  285.720515] [drm] add ip block number 4 <powerplay>
[  285.720518] [drm] add ip block number 5 <dm>
[  285.720522] [drm] add ip block number 6 <gfx_v9_0>
[  285.720526] [drm] add ip block number 7 <sdma_v4_0>
[  285.720529] [drm] add ip block number 8 <vcn_v1_0>
[  285.724322] kfd kfd: DID 15dd is missing in supported_devices
[  285.724327] kfd kfd: kgd2kfd_probe failed
[  285.724564] [drm] VCN decode is enabled in VM mode
[  285.724568] [drm] VCN encode is enabled in VM mode
[  285.724571] [drm] VCN jpeg decode is enabled in VM mode
[  285.749045] [drm] BIOS signature incorrect 65 7
[  285.749092] ATOM BIOS: 113-RAVEN-106
[  285.749362] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, fragment size is 9-bit
[  285.749383] amdgpu 0000:06:00.0: VRAM: 1024M 0x000000F400000000 - 0x000000F43FFFFFFF (1024M used)
[  285.749388] amdgpu 0000:06:00.0: GART: 1024M 0x000000F500000000 - 0x000000F53FFFFFFF
[  285.749397] [drm] Detected VRAM RAM=1024M, BAR=1024M
[  285.749400] [drm] RAM width 128bits DDR4
[  285.749970] [TTM] Zone  kernel: Available graphics memory: 3088838 kiB
[  285.749985] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[  285.749988] [TTM] Initializing pool allocator
[  285.750022] [TTM] Initializing DMA pool allocator
[  285.750588] [drm] amdgpu: 1024M of VRAM memory ready
[  285.750599] [drm] amdgpu: 3072M of GTT memory ready.
[  285.750665] [drm] GART: num cpu pages 262144, num gpu pages 262144
[  285.751062] [drm] PCIE GART of 1024M enabled (table at 0x000000F400900000).
[  285.762713] [drm] use_doorbell being set to: [true]
[  285.764320] [drm] Found VCN firmware Version: 1.24 Family ID: 18
[  285.840493] amdgpu: [powerplay] dpm has been enabled
[  285.840876] [drm] DM_PPLIB: values for Invalid clock
[  285.840880] [drm] DM_PPLIB:	 0 in kHz
[  285.840883] [drm] DM_PPLIB:	 400000 in kHz
[  285.840887] [drm] DM_PPLIB:	 933000 in kHz
[  285.840890] [drm] DM_PPLIB:	 1067000 in kHz
[  285.841093] WARNING: CPU: 0 PID: 3780 at drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:1372 dcn_bw_update_from_pplib+0x309/0x530 [amdgpu]
[  285.841096] Modules linked in: amdkfd amdgpu(+) mfd_core chash gpu_sched ttm ax88179_178a usbnet
[  285.841126] CPU: 0 PID: 3780 Comm: modprobe Not tainted 4.18.0-rc1+ #7
[  285.841130] Hardware name: System manufacturer System Product Name/TUF B350M-PLUS GAMING, BIOS 4011 04/19/2018
[  285.841299] RIP: 0010:dcn_bw_update_from_pplib+0x309/0x530 [amdgpu]
[  285.841301] Code: 81 1d 00 dc f9 d9 c9 dc 4c 24 08 dc 0d e0 81 1d 00 de f1 d9 5c 24 08 e8 d5 c0 fd d9 f3 0f 10 5c 24 08 f3 41 0f 11 5f 4c eb 02 <0f> 0b 4c 8d a4 24 c0 00 00 00 48 8b 3c 24 be 04 00 00 00 4c 89 e2 
[  285.841460] RSP: 0018:ffff8801d049e848 EFLAGS: 00010246
[  285.841467] RAX: 0000000000000000 RBX: ffff8801d049e888 RCX: ffffffffc05b8308
[  285.841471] RDX: 0000000000000007 RSI: dffffc0000000000 RDI: ffff8801d049e88c
[  285.841475] RBP: ffff8801d7c65500 R08: ffffed003bfc3cdb R09: ffffed003bfc3cda
[  285.841479] R10: ffffed003bfc3cda R11: ffff8801dfe1e6d7 R12: 0000000000000004
[  285.841482] R13: 1ffff1003a093d0d R14: ffff8801ce4a6840 R15: 0000000000000000
[  285.841486] FS:  00007fd60370c0c0(0000) GS:ffff8801dfe00000(0000) knlGS:0000000000000000
[  285.841490] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  285.841494] CR2: 000055997f5e9d98 CR3: 00000001c9e50000 CR4: 00000000003406f0
[  285.841496] Call Trace:
[  285.841506]  ? fs_reclaim_acquire+0x10/0x10
[  285.841677]  ? dcn_find_dcfclk_suits_all+0x610/0x610 [amdgpu]
[  285.841683]  ? lock_downgrade+0x300/0x300
[  285.841868]  ? dcn10_create_resource_pool+0x5e6/0xef0 [amdgpu]
[  285.842040]  ? dcn10_create_resource_pool+0x5e6/0xef0 [amdgpu]
[  285.842214]  ? dcn10_create_resource_pool+0xbe2/0xef0 [amdgpu]
[  285.842390]  ? dcn10_clock_source_destroy+0x30/0x30 [amdgpu]
[  285.842395]  ? lock_release+0x490/0x490
[  285.842571]  ? dc_create_resource_pool+0x8b/0x240 [amdgpu]
[  285.842739]  ? resource_parse_asic_id+0x170/0x170 [amdgpu]
[  285.842746]  ? kasan_kmalloc+0xbf/0xe0
[  285.842915]  ? dal_gpio_service_create+0xe7/0x180 [amdgpu]
[  285.843087]  ? dal_gpio_service_create+0xe7/0x180 [amdgpu]
[  285.843092]  ? __kmalloc+0x128/0x2b0
[  285.843266]  ? dc_create+0x407/0xc90 [amdgpu]
[  285.843273]  ? save_trace+0x1b0/0x1b0
[  285.843278]  ? fs_reclaim_acquire+0x10/0x10
[  285.843452]  ? dc_create_state+0xe0/0xe0 [amdgpu]
[  285.843466]  ? kasan_unpoison_shadow+0x30/0x40
[  285.843471]  ? kasan_kmalloc+0xbf/0xe0
[  285.843631]  ? amdgpu_cgs_create_device+0x27/0x60 [amdgpu]
[  285.843794]  ? amdgpu_cgs_create_device+0x27/0x60 [amdgpu]
[  285.843799]  ? kmem_cache_alloc_trace+0x10b/0x260
[  285.843972]  ? dm_hw_init+0x212/0x320 [amdgpu]
[  285.844140]  ? dm_resume+0x580/0x580 [amdgpu]
[  285.844314]  ? psm_set_states+0xc3/0xe0 [amdgpu]
[  285.844481]  ? hwmgr_hw_init+0x27e/0x2a0 [amdgpu]
[  285.844652]  ? amdgpu_device_init.cold.29+0x11c9/0x1783 [amdgpu]
[  285.844804]  ? amdgpu_device_has_dc_support+0x30/0x30 [amdgpu]
[  285.844813]  ? rcu_read_lock_sched_held+0x74/0x80
[  285.844818]  ? __alloc_pages_nodemask+0x5a3/0x620
[  285.844825]  ? __alloc_pages_slowpath+0x1aa0/0x1aa0
[  285.844832]  ? __unwind_start+0x3b1/0x420
[  285.844840]  ? save_stack+0x8c/0xb0
[  285.844848]  ? save_trace+0x1b0/0x1b0
[  285.844859]  ? __mutex_unlock_slowpath+0x114/0x530
[  285.844871]  ? __lock_is_held+0x51/0xc0
[  285.845020]  ? amdgpu_drm_ioctl+0x6e/0x180 [amdgpu]
[  285.845028]  ? rcu_read_lock_sched_held+0x74/0x80
[  285.845178]  ? amdgpu_driver_load_kms+0x110/0x3c0 [amdgpu]
[  285.845182]  ? quarantine_put+0xb2/0x150
[  285.845329]  ? amdgpu_driver_unload_kms+0xd0/0xd0 [amdgpu]
[  285.845334]  ? trace_hardirqs_on_caller+0x17a/0x250
[  285.845345]  ? __kasan_slab_free+0x13a/0x170
[  285.845357]  ? drm_dev_register+0x1a6/0x1f0
[  285.845507]  ? amdgpu_pci_probe+0x1af/0x230 [amdgpu]
[  285.845654]  ? amdgpu_pmops_runtime_idle+0x190/0x190 [amdgpu]
[  285.845661]  ? local_pci_probe+0x6b/0xc0
[  285.845669]  ? pci_device_probe+0x195/0x260
[  285.845675]  ? pci_device_remove+0x1d0/0x1d0
[  285.845691]  ? driver_probe_device+0x426/0x510
[  285.845699]  ? driver_probe_done+0xb0/0xb0
[  285.845705]  ? pci_match_id.part.11+0xf3/0x140
[  285.845713]  ? pci_match_device+0x1c8/0x1f0
[  285.845725]  ? driver_probe_device+0x510/0x510
[  285.845730]  ? __driver_attach+0x130/0x140
[  285.845737]  ? bus_for_each_dev+0xe4/0x140
[  285.845743]  ? subsys_dev_iter_exit+0x10/0x10
[  285.845750]  ? bus_add_driver+0x78/0x2c0
[  285.845755]  ? kmem_cache_alloc_trace+0x10b/0x260
[  285.845764]  ? bus_add_driver+0x279/0x2c0
[  285.845773]  ? driver_register+0xca/0x140
[  285.845782]  ? __pci_register_driver+0x148/0x180
[  285.845788]  ? pci_bus_num_vf+0x10/0x10
[  285.845793]  ? kmem_cache_create_usercopy+0x1aa/0x290
[  285.845804]  ? 0xffffffffc0870000
[  285.845811]  ? do_one_initcall+0xd5/0x4c7
[  285.845816]  ? trace_event_raw_event_initcall_finish+0x130/0x130
[  285.845822]  ? find_held_lock+0xac/0xd0
[  285.845826]  ? mark_held_locks+0x23/0xb0
[  285.845831]  ? retint_kernel+0x10/0x10
[  285.845838]  ? trace_hardirqs_on_caller+0x17a/0x250
[  285.845844]  ? trace_hardirqs_on_thunk+0x1a/0x1c
[  285.845851]  ? irq_exit+0x7f/0x110
[  285.845869]  ? __memset+0x29/0x30
[  285.845875]  ? kasan_unpoison_shadow+0x30/0x40
[  285.845886]  ? do_init_module+0x14e/0x3c0
[  285.845893]  ? __x64_sys_delete_module+0x3c0/0x3c0
[  285.845898]  ? __lock_is_held+0x38/0xc0
[  285.845910]  ? load_module+0x382b/0x4080
[  285.845939]  ? module_frob_arch_sections+0x20/0x20
[  285.845950]  ? __vfs_read+0x32f/0x370
[  285.845958]  ? fsnotify+0x956/0x970
[  285.845970]  ? fsnotify_first_mark+0x1f0/0x1f0
[  285.845975]  ? fsnotify+0x970/0x970
[  285.845979]  ? __fsnotify_parent+0x7f/0x210
[  285.845985]  ? fsnotify+0x970/0x970
[  285.846000]  ? vfs_read+0x16c/0x1a0
[  285.846005]  ? vfs_read+0xbe/0x1a0
[  285.846013]  ? kernel_read+0x6f/0x90
[  285.846022]  ? kernel_read_file+0x210/0x2f0
[  285.846030]  ? free_bprm+0xf0/0xf0
[  285.846034]  ? up_read+0x90/0x90
[  285.846051]  ? __do_sys_finit_module+0x18f/0x1c0
[  285.846056]  ? __do_sys_finit_module+0x18f/0x1c0
[  285.846061]  ? __ia32_sys_init_module+0x40/0x40
[  285.846068]  ? vfs_statx_fd+0x3f/0x80
[  285.846076]  ? __do_sys_newfstat+0xb5/0xc0
[  285.846091]  ? mark_held_locks+0x23/0xb0
[  285.846097]  ? do_syscall_64+0x8a/0x370
[  285.846105]  ? do_syscall_64+0xfc/0x370
[  285.846111]  ? syscall_return_slowpath+0x2a0/0x2a0
[  285.846115]  ? __do_page_fault+0x405/0x6a0
[  285.846120]  ? lockdep_sys_exit+0x16/0x31
[  285.846125]  ? syscall_return_slowpath+0x17b/0x2a0
[  285.846130]  ? prepare_exit_to_usermode+0x1e0/0x1e0
[  285.846135]  ? mark_held_locks+0x23/0xb0
[  285.846141]  ? entry_SYSCALL_64_after_hwframe+0x59/0xbe
[  285.846147]  ? trace_hardirqs_off_caller+0xb5/0x100
[  285.846153]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[  285.846163]  ? entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  285.846179] irq event stamp: 415490
[  285.846185] hardirqs last  enabled at (415489): [<ffffffff9a3719a6>] console_unlock+0x666/0x880
[  285.846191] hardirqs last disabled at (415490): [<ffffffff9b60110c>] error_entry+0x7c/0x100
[  285.846196] softirqs last  enabled at (415294): [<ffffffff9b800565>] __do_softirq+0x565/0x74b
[  285.846201] softirqs last disabled at (415287): [<ffffffff9a2b478f>] irq_exit+0xff/0x110
[  285.846204] ---[ end trace e3e5d14c40290d37 ]---
[  285.846241] [drm] DM_PPLIB: values for Invalid clock
[  285.846245] [drm] DM_PPLIB:	 300000 in kHz
[  285.846248] [drm] DM_PPLIB:	 600000 in kHz
[  285.846252] [drm] DM_PPLIB:	 626000 in kHz
[  285.846255] [drm] DM_PPLIB:	 654000 in kHz
[  285.856318] [drm] Display Core initialized with v3.1.55!
[  285.883260] [drm] SADs count is: -524, don't need to read it
[  285.886210] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[  285.886215] [drm] Driver supports precise vblank timestamp query.
[  285.909807] [drm] VCN decode and encode initialized successfully.
[  285.913915] [drm] fb mappable at 0xA1100000
[  285.913931] [drm] vram apper at 0xA0000000
[  285.913934] [drm] size 8294400
[  285.913937] [drm] fb depth is 24
[  285.913940] [drm]    pitch is 7680
[  285.915112] fbcon: amdgpudrmfb (fb0) is primary device
[  285.974255] Console: switching to colour frame buffer device 240x67
[  285.989264] amdgpu 0000:06:00.0: fb0: amdgpudrmfb frame buffer device
[  285.998808] amdgpu 0000:06:00.0: ring 0(gfx) uses VM inv eng 4 on hub 0
[  285.998815] amdgpu 0000:06:00.0: ring 1(comp_1.0.0) uses VM inv eng 5 on hub 0
[  285.998819] amdgpu 0000:06:00.0: ring 2(comp_1.1.0) uses VM inv eng 6 on hub 0
[  285.998824] amdgpu 0000:06:00.0: ring 3(comp_1.2.0) uses VM inv eng 7 on hub 0
[  285.998828] amdgpu 0000:06:00.0: ring 4(comp_1.3.0) uses VM inv eng 8 on hub 0
[  285.998833] amdgpu 0000:06:00.0: ring 5(comp_1.0.1) uses VM inv eng 9 on hub 0
[  285.998837] amdgpu 0000:06:00.0: ring 6(comp_1.1.1) uses VM inv eng 10 on hub 0
[  285.998841] amdgpu 0000:06:00.0: ring 7(comp_1.2.1) uses VM inv eng 11 on hub 0
[  285.998846] amdgpu 0000:06:00.0: ring 8(comp_1.3.1) uses VM inv eng 12 on hub 0
[  285.998850] amdgpu 0000:06:00.0: ring 9(kiq_2.1.0) uses VM inv eng 13 on hub 0
[  285.998855] amdgpu 0000:06:00.0: ring 10(sdma0) uses VM inv eng 4 on hub 1
[  285.998859] amdgpu 0000:06:00.0: ring 11(vcn_dec) uses VM inv eng 5 on hub 1
[  285.998863] amdgpu 0000:06:00.0: ring 12(vcn_enc0) uses VM inv eng 6 on hub 1
[  285.998868] amdgpu 0000:06:00.0: ring 13(vcn_enc1) uses VM inv eng 7 on hub 1
[  285.998872] amdgpu 0000:06:00.0: ring 14(vcn_jpeg) uses VM inv eng 8 on hub 1
[  286.447486] [drm] Initialized amdgpu 3.27.0 20150101 for 0000:06:00.0 on minor 0
[  286.449642] modprobe (3780) used greatest stack depth: 16336 bytes left
[  287.399030] WARNING: CPU: 0 PID: 53 at drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:92 amdgpu_ttm_bo_destroy+0x388/0x3a0 [amdgpu]
[  287.399047] Modules linked in: amdkfd amdgpu mfd_core chash gpu_sched ttm ax88179_178a usbnet
[  287.399077] CPU: 0 PID: 53 Comm: kworker/0:1 Tainted: G        W         4.18.0-rc1+ #7
[  287.399080] Hardware name: System manufacturer System Product Name/TUF B350M-PLUS GAMING, BIOS 4011 04/19/2018
[  287.399095] Workqueue: events ttm_bo_delayed_workqueue [ttm]
[  287.399216] RIP: 0010:amdgpu_ttm_bo_destroy+0x388/0x3a0 [amdgpu]
[  287.399219] Code: 5c 41 5d 41 5e 41 5f c3 4c 89 ef e8 22 11 1e da 48 c7 83 b8 04 00 00 00 00 00 00 e9 15 fe ff ff 4c 8d 64 24 40 e9 0b fe ff ff <0f> 0b 4c 89 ff e8 9e fb ff ff e9 23 fd ff ff e8 d4 2c ef d9 0f 1f 
[  287.399375] RSP: 0018:ffff8801de55f1e0 EFLAGS: 00010202
[  287.399381] RAX: 0000000000000001 RBX: ffff8801d7db3bd8 RCX: ffffffffc03b32dc
[  287.399385] RDX: 0000000000000003 RSI: dffffc0000000000 RDI: ffff8801d7db3f40
[  287.399389] RBP: 1ffff1003bcabe40 R08: ffffed003afb67d4 R09: ffffed003afb67d3
[  287.399393] R10: ffffed003afb67d3 R11: ffff8801d7db3e9f R12: ffff8801d7db3dc8
[  287.399396] R13: ffff8801d7db3bd8 R14: ffff8801d7db3c90 R15: ffff8801d7db3b80
[  287.399401] FS:  0000000000000000(0000) GS:ffff8801dfe00000(0000) knlGS:0000000000000000
[  287.399404] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  287.399408] CR2: 0000000001785000 CR3: 00000001de69a000 CR4: 00000000003406f0
[  287.399410] Call Trace:
[  287.399418]  ? save_trace+0x1b0/0x1b0
[  287.399539]  ? amdgpu_bo_subtract_pin_size+0xd0/0xd0 [amdgpu]
[  287.399546]  ? __mutex_unlock_slowpath+0x114/0x530
[  287.399556]  ? mark_held_locks+0x8b/0xb0
[  287.399562]  ? quarantine_put+0xb2/0x150
[  287.399569]  ? trace_hardirqs_on_caller+0x17a/0x250
[  287.399575]  ? mutex_destroy+0x7b/0x140
[  287.399581]  ? percpu_down_write+0x2d0/0x2d0
[  287.399588]  ? __kasan_slab_free+0x13a/0x170
[  287.399607]  ? ttm_bo_release_list+0x3fc/0x4a0 [ttm]
[  287.399624]  ? ttm_bo_add_move_fence.isra.14+0xc0/0xc0 [ttm]
[  287.399637]  ? ttm_bo_cleanup_refs+0x4cd/0x510 [ttm]
[  287.399654]  ? ttm_bo_put+0x20/0x20 [ttm]
[  287.399669]  ? ttm_bo_delayed_delete+0x12b/0x4f0 [ttm]
[  287.399682]  ? mutex_trylock+0x19b/0x1b0
[  287.399695]  ? ttm_bo_delayed_delete+0x371/0x4f0 [ttm]
[  287.399701]  ? ww_mutex_lock.part.4+0x70/0x70
[  287.399724]  ? ttm_bo_delayed_delete+0x203/0x4f0 [ttm]
[  287.399744]  ? ttm_bo_cleanup_refs+0x510/0x510 [ttm]
[  287.399750]  ? __lock_acquire+0x66f/0x25c0
[  287.399755]  ? find_held_lock+0xac/0xd0
[  287.399767]  ? find_held_lock+0xac/0xd0
[  287.399773]  ? match_held_lock+0x92/0x330
[  287.399778]  ? save_trace+0x1b0/0x1b0
[  287.399784]  ? lock_acquire+0x12a/0x2e0
[  287.399789]  ? process_one_work+0x5f6/0xdd0
[  287.399798]  ? lock_release+0x490/0x490
[  287.399803]  ? do_raw_spin_trylock+0x120/0x120
[  287.399812]  ? __lock_is_held+0x51/0xc0
[  287.399832]  ? ttm_bo_delayed_workqueue+0x12/0x40 [ttm]
[  287.399837]  ? process_one_work+0x70c/0xdd0
[  287.399851]  ? wq_pool_ids_show+0x1e0/0x1e0
[  287.399856]  ? lock_repin_lock+0x1b0/0x1b0
[  287.399870]  ? match_held_lock+0x7f/0x330
[  287.399874]  ? save_trace+0x1b0/0x1b0
[  287.399886]  ? find_held_lock+0xac/0xd0
[  287.399894]  ? match_held_lock+0x7f/0x330
[  287.399899]  ? save_trace+0x1b0/0x1b0
[  287.399905]  ? lock_downgrade+0x300/0x300
[  287.399913]  ? do_raw_spin_unlock+0x152/0x1e0
[  287.399920]  ? remove_wait_queue+0x150/0x150
[  287.399924]  ? lock_downgrade+0x230/0x300
[  287.399933]  ? find_held_lock+0xac/0xd0
[  287.399942]  ? lock_acquire+0x12a/0x2e0
[  287.399947]  ? worker_thread+0x2b0/0x9a0
[  287.399956]  ? lock_release+0x490/0x490
[  287.399962]  ? do_raw_spin_trylock+0x120/0x120
[  287.399966]  ? retint_kernel+0x10/0x10
[  287.399976]  ? mark_held_locks+0x23/0xb0
[  287.399987]  ? worker_thread+0x14f/0x9a0
[  287.400000]  ? process_one_work+0xdd0/0xdd0
[  287.400011]  ? __sched_text_start+0x8/0x8
[  287.400019]  ? save_trace+0x1b0/0x1b0
[  287.400023]  ? match_held_lock+0x7f/0x330
[  287.400029]  ? save_trace+0x1b0/0x1b0
[  287.400035]  ? finish_task_switch+0x168/0x500
[  287.400042]  ? lock_downgrade+0x300/0x300
[  287.400055]  ? find_held_lock+0xac/0xd0
[  287.400065]  ? schedule+0xca/0x240
[  287.400070]  ? lock_downgrade+0x300/0x300
[  287.400076]  ? __schedule+0x1100/0x1100
[  287.400082]  ? do_raw_spin_unlock+0x152/0x1e0
[  287.400088]  ? do_raw_spin_trylock+0x120/0x120
[  287.400092]  ? __lockdep_init_map+0x86/0x210
[  287.400099]  ? __init_waitqueue_head+0xb9/0xf0
[  287.400105]  ? __kthread_parkme+0xc7/0x100
[  287.400111]  ? parse_args.cold.17+0x146/0x146
[  287.400115]  ? _raw_spin_unlock_irqrestore+0x37/0x40
[  287.400125]  ? process_one_work+0xdd0/0xdd0
[  287.400129]  ? kthread+0x19b/0x1c0
[  287.400134]  ? kthread_create_worker_on_cpu+0xc0/0xc0
[  287.400141]  ? ret_from_fork+0x27/0x50
[  287.400157] irq event stamp: 2196
[  287.400162] hardirqs last  enabled at (2195): [<ffffffff9a5963a2>] quarantine_put+0xb2/0x150
[  287.400167] hardirqs last disabled at (2196): [<ffffffff9b60110c>] error_entry+0x7c/0x100
[  287.400174] softirqs last  enabled at (1234): [<ffffffff9a3f9549>] css_release_work_fn+0x499/0x690
[  287.400179] softirqs last disabled at (1232): [<ffffffff9a3f9532>] css_release_work_fn+0x482/0x690
[  287.400182] ---[ end trace e3e5d14c40290d38 ]---
[  288.607644] dbus-launch (3902) used greatest stack depth: 15952 bytes left
[  289.259537] fuse init (API version 7.27)
[  292.393712] rfkill: input handler disabled

--------------581D4F362C624E788C55386B
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------581D4F362C624E788C55386B--
