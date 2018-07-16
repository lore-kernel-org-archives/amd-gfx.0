From: Tom St Denis <tstdenis-5C7GfCeVMHo@public.gmane.org>
Subject: dmesg warning during init
Date: Mon, 16 Jul 2018 08:10:04 -0400
Message-ID: <4202bddf-090d-dd45-6b0a-aeb3a2534f3c@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------DAAE2C6C495871B1978171DC"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Daenzer, Michel" <Michel.Daenzer-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

--------------DAAE2C6C495871B1978171DC
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

Back from vacation, booting up the latest drm-next kernel and noticed 
this warning on boot. Attached.

I like the comment in the commit 5c200f56506a142451f17dbea7befa76dd74a942:

"This shouldn't happen, but if it does, we'll get a backtrace of the
caller, and update the pin_size values as needed."

:-)

Tom

--------------DAAE2C6C495871B1978171DC
Content-Type: text/x-log;
 name="raven.dmesg.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="raven.dmesg.log"

[    0.000000] Linux version 4.18.0-rc1+ (root@raven) (gcc version 8.1.1 20180502 (Red Hat 8.1.1-1) (GCC)) #5 SMP Mon Jul 16 06:51:46 EDT 2018
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
[    0.000000] BRK [0x169fa2000, 0x169fa2fff] PGTABLE
[    0.000000] BRK [0x169fa3000, 0x169fa3fff] PGTABLE
[    0.000000] BRK [0x169fa4000, 0x169fa4fff] PGTABLE
[    0.000000] BRK [0x169fa5000, 0x169fa5fff] PGTABLE
[    0.000000] BRK [0x169fa6000, 0x169fa6fff] PGTABLE
[    0.000000] BRK [0x169fa7000, 0x169fa7fff] PGTABLE
[    0.000000] BRK [0x169fa8000, 0x169fa8fff] PGTABLE
[    0.000000] BRK [0x169fa9000, 0x169fa9fff] PGTABLE
[    0.000000] BRK [0x169faa000, 0x169faafff] PGTABLE
[    0.000000] BRK [0x169fab000, 0x169fabfff] PGTABLE
[    0.000000] BRK [0x169fac000, 0x169facfff] PGTABLE
[    0.000000] BRK [0x169fad000, 0x169fadfff] PGTABLE
[    0.000000] RAMDISK: [mem 0x34cbd000-0x36656fff]
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
[    0.000000] random: get_random_bytes called from start_kernel+0xe0/0x5d6 with crng_init=0
[    0.000000] setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:16 nr_node_ids:1
[    0.000000] percpu: Embedded 52 pages/cpu @(____ptrval____) s175448 r8192 d29352 u262144
[    0.000000] pcpu-alloc: s175448 r8192 d29352 u262144 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 12 13 14 15 
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 1789201
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-4.18.0-rc1+ root=UUID=66163c80-0ca1-4beb-aeba-5cc130b813e6 ro rhgb quiet modprobe.blacklist=amdgpu,radeon LANG=en_CA.UTF-8
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Memory: 6097000K/7270496K available (22540K kernel code, 4878K rwdata, 5428K rodata, 1592K init, 9056K bss, 1173496K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=16, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU event tracing is enabled.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=16.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=16
[    0.000000] NR_IRQS: 4352, nr_irqs: 1096, preallocated irqs: 16
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] ACPI: Core revision 20180531
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
[    0.000000] hpet clockevent registered
[    0.000000] APIC: Switch to symmetric I/O mode setup
[    0.000000] Switched APIC routing to physical flat.
[    0.000000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.005000] tsc: Fast TSC calibration failed
[    0.007000] tsc: PIT calibration matches HPET. 1 loops
[    0.007000] tsc: Detected 3593.746 MHz processor
[    0.007000] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x33cd3f38bea, max_idle_ns: 440795255649 ns
[    0.007000] Calibrating delay loop (skipped), value calculated using timer frequency.. 7187.49 BogoMIPS (lpj=3593746)
[    0.007000] pid_max: default: 32768 minimum: 301
[    0.007000] Security Framework initialized
[    0.007000] SELinux:  Initializing.
[    0.007000] SELinux:  Starting in permissive mode
[    0.008895] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.009662] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.009701] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.009724] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.010009] CPU: Physical Processor ID: 0
[    0.010010] CPU: Processor Core ID: 0
[    0.010117] mce: CPU supports 23 MCE banks
[    0.010135] LVT offset 1 assigned for vector 0xf9
[    0.010184] LVT offset 2 assigned for vector 0xf4
[    0.010195] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 512
[    0.010196] Last level dTLB entries: 4KB 1536, 2MB 1536, 4MB 768, 1GB 0
[    0.010198] Spectre V2 : Mitigation: Full AMD retpoline
[    0.010199] Spectre V2 : Spectre v2 mitigation: Enabling Indirect Branch Prediction Barrier
[    0.010201] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
[    0.020555] Freeing SMP alternatives memory: 36K
[    0.023000] smpboot: CPU0: AMD Ryzen 5 2400G with Radeon Vega Graphics (family: 0x17, model: 0x11, stepping: 0x0)
[    0.023000] Performance Events: Fam17h core perfctr, AMD PMU driver.
[    0.023000] ... version:                0
[    0.023000] ... bit width:              48
[    0.023000] ... generic registers:      6
[    0.023000] ... value mask:             0000ffffffffffff
[    0.023000] ... max period:             00007fffffffffff
[    0.023000] ... fixed-purpose events:   0
[    0.023000] ... event mask:             000000000000003f
[    0.023000] Hierarchical SRCU implementation.
[    0.024427] MCE: In-kernel MCE decoding enabled.
[    0.024864] smp: Bringing up secondary CPUs ...
[    0.025114] x86: Booting SMP configuration:
[    0.025116] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7
[    0.036005] smp: Brought up 1 node, 8 CPUs
[    0.036006] smpboot: Max logical packages: 2
[    0.036008] smpboot: Total of 8 processors activated (57499.93 BogoMIPS)
[    0.038004] devtmpfs: initialized
[    0.040031] PM: Registering ACPI NVS region [mem 0x04000000-0x04009fff] (40960 bytes)
[    0.040035] PM: Registering ACPI NVS region [mem 0x9a7e5000-0x9ab9cfff] (3899392 bytes)
[    0.040413] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.040452] futex hash table entries: 4096 (order: 6, 262144 bytes)
[    0.040381] kworker/u32:0 (52) used greatest stack depth: 23576 bytes left
[    0.041270] RTC time: 12:04:52, date: 07/16/18
[    0.043131] NET: Registered protocol family 16
[    0.043349] audit: initializing netlink subsys (disabled)
[    0.043361] audit: type=2000 audit(1531742691.043:1): state=initialized audit_enabled=0 res=1
[    0.043361] kworker/u32:0 (56) used greatest stack depth: 22856 bytes left
[    0.043377] cpuidle: using governor menu
[    0.044191] ACPI: bus type PCI registered
[    0.044354] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.044358] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
[    0.044377] PCI: Using configuration type 1 for base access
[    0.045412] mtrr: your CPUs had inconsistent variable MTRR settings
[    0.045414] mtrr: probably your BIOS does not setup all CPUs.
[    0.045415] mtrr: corrected configuration.
[    0.049587] kworker/u32:0 (268) used greatest stack depth: 22088 bytes left
[    0.052419] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.053134] ACPI: Added _OSI(Module Device)
[    0.053135] ACPI: Added _OSI(Processor Device)
[    0.053136] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.053137] ACPI: Added _OSI(Processor Aggregator Device)
[    0.053139] ACPI: Added _OSI(Linux-Dell-Video)
[    0.074599] 
               3ACPI BIOS Error (bug): Failure creating [\_SB.SMIC], AE_ALREADY_EXISTS (20180531/dswload2-316)
[    0.074608] ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20180531/psobject-221)
[    0.074819] ACPI Error: Ignore error and continue table load (20180531/psobject-604)
[    0.075002] 
               3ACPI BIOS Error (bug): Failure creating [\_SB.SMIB], AE_ALREADY_EXISTS (20180531/dsfield-594)
[    0.075659] ACPI: 8 ACPI AML tables successfully acquired and loaded
[    0.079557] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.087879] ACPI: Interpreter enabled
[    0.087912] ACPI: (supports S0 S3 S4 S5)
[    0.087914] ACPI: Using IOAPIC for interrupt routing
[    0.088490] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.089077] ACPI: Enabled 3 GPEs in block 00 to 1F
[    0.096373] ACPI: Power Resource [P0ST] (on)
[    0.096463] ACPI: Power Resource [P3ST] (on)
[    0.112082] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.112090] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.112482] acpi PNP0A08:00: _OSC: platform does not support [PME LTR]
[    0.112867] acpi PNP0A08:00: _OSC: OS now controls [AER PCIeCapability]
[    0.112885] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000 [bus 00-3f] only partially covers this bridge
[    0.113340] PCI host bridge to bus 0000:00
[    0.113343] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    0.113345] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    0.113347] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
[    0.113350] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.113352] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.113354] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff window]
[    0.113356] pci_bus 0000:00: root bus resource [mem 0xe0000000-0xfec2ffff window]
[    0.113359] pci_bus 0000:00: root bus resource [mem 0xfee00000-0xffffffff window]
[    0.113361] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.113374] pci 0000:00:00.0: [1022:15d0] type 00 class 0x060000
[    0.113584] pci 0000:00:00.2: [1022:15d1] type 00 class 0x080600
[    0.113811] pci 0000:00:01.0: [1022:1452] type 00 class 0x060000
[    0.114036] pci 0000:00:01.2: [1022:15d3] type 01 class 0x060400
[    0.114109] pci 0000:00:01.2: PME# supported from D0 D3hot D3cold
[    0.114289] pci 0000:00:08.0: [1022:1452] type 00 class 0x060000
[    0.114475] pci 0000:00:08.1: [1022:15db] type 01 class 0x060400
[    0.114530] pci 0000:00:08.1: enabling Extended Tags
[    0.114592] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
[    0.114762] pci 0000:00:08.2: [1022:15dc] type 01 class 0x060400
[    0.114816] pci 0000:00:08.2: enabling Extended Tags
[    0.114873] pci 0000:00:08.2: PME# supported from D0 D3hot D3cold
[    0.115054] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500
[    0.115353] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100
[    0.115665] pci 0000:00:18.0: [1022:15e8] type 00 class 0x060000
[    0.116035] pci 0000:00:18.1: [1022:15e9] type 00 class 0x060000
[    0.116035] pci 0000:00:18.2: [1022:15ea] type 00 class 0x060000
[    0.116035] pci 0000:00:18.3: [1022:15eb] type 00 class 0x060000
[    0.116115] pci 0000:00:18.4: [1022:15ec] type 00 class 0x060000
[    0.116226] pci 0000:00:18.5: [1022:15ed] type 00 class 0x060000
[    0.116336] pci 0000:00:18.6: [1022:15ee] type 00 class 0x060000
[    0.116444] pci 0000:00:18.7: [1022:15ef] type 00 class 0x060000
[    0.116645] pci 0000:01:00.0: [1022:43bb] type 00 class 0x0c0330
[    0.116678] pci 0000:01:00.0: reg 0x10: [mem 0xfe8a0000-0xfe8a7fff 64bit]
[    0.116791] pci 0000:01:00.0: PME# supported from D3hot D3cold
[    0.117033] pci 0000:01:00.1: [1022:43b7] type 00 class 0x010601
[    0.117033] pci 0000:01:00.1: reg 0x24: [mem 0xfe880000-0xfe89ffff]
[    0.117033] pci 0000:01:00.1: reg 0x30: [mem 0xfe800000-0xfe87ffff pref]
[    0.117061] pci 0000:01:00.1: PME# supported from D3hot D3cold
[    0.117172] pci 0000:01:00.2: [1022:43b2] type 01 class 0x060400
[    0.117281] pci 0000:01:00.2: PME# supported from D3hot D3cold
[    0.117453] pci 0000:00:01.2: PCI bridge to [bus 01-05]
[    0.117459] pci 0000:00:01.2:   bridge window [io  0xf000-0xffff]
[    0.117463] pci 0000:00:01.2:   bridge window [mem 0xfe700000-0xfe8fffff]
[    0.117540] pci 0000:02:00.0: [1022:43b4] type 01 class 0x060400
[    0.117667] pci 0000:02:00.0: PME# supported from D3hot D3cold
[    0.117809] pci 0000:02:01.0: [1022:43b4] type 01 class 0x060400
[    0.117935] pci 0000:02:01.0: PME# supported from D3hot D3cold
[    0.118083] pci 0000:02:04.0: [1022:43b4] type 01 class 0x060400
[    0.118210] pci 0000:02:04.0: PME# supported from D3hot D3cold
[    0.118366] pci 0000:01:00.2: PCI bridge to [bus 02-05]
[    0.118374] pci 0000:01:00.2:   bridge window [io  0xf000-0xffff]
[    0.118378] pci 0000:01:00.2:   bridge window [mem 0xfe700000-0xfe7fffff]
[    0.118463] pci 0000:03:00.0: [10ec:8168] type 00 class 0x020000
[    0.118514] pci 0000:03:00.0: reg 0x10: [io  0xf000-0xf0ff]
[    0.118558] pci 0000:03:00.0: reg 0x18: [mem 0xfe704000-0xfe704fff 64bit]
[    0.118585] pci 0000:03:00.0: reg 0x20: [mem 0xfe700000-0xfe703fff 64bit]
[    0.118745] pci 0000:03:00.0: supports D1 D2
[    0.118746] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.118965] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.118973] pci 0000:02:00.0:   bridge window [io  0xf000-0xffff]
[    0.118977] pci 0000:02:00.0:   bridge window [mem 0xfe700000-0xfe7fffff]
[    0.119047] pci 0000:02:01.0: PCI bridge to [bus 04]
[    0.119119] pci 0000:02:04.0: PCI bridge to [bus 05]
[    0.119237] pci 0000:06:00.0: [1002:15dd] type 00 class 0x030000
[    0.119286] pci 0000:06:00.0: reg 0x10: [mem 0xe0000000-0xefffffff 64bit pref]
[    0.119305] pci 0000:06:00.0: reg 0x18: [mem 0xf0000000-0xf01fffff 64bit pref]
[    0.119319] pci 0000:06:00.0: reg 0x20: [io  0xe000-0xe0ff]
[    0.119332] pci 0000:06:00.0: reg 0x24: [mem 0xfe600000-0xfe67ffff]
[    0.119353] pci 0000:06:00.0: enabling Extended Tags
[    0.119465] pci 0000:06:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.119628] pci 0000:06:00.1: [1002:15de] type 00 class 0x040300
[    0.119660] pci 0000:06:00.1: reg 0x10: [mem 0xfe688000-0xfe68bfff]
[    0.119733] pci 0000:06:00.1: enabling Extended Tags
[    0.119807] pci 0000:06:00.1: PME# supported from D1 D2 D3hot D3cold
[    0.119933] pci 0000:06:00.2: [1022:15df] type 00 class 0x108000
[    0.119986] pci 0000:06:00.2: reg 0x18: [mem 0xfe500000-0xfe5fffff]
[    0.120023] pci 0000:06:00.2: reg 0x24: [mem 0xfe68c000-0xfe68dfff]
[    0.120044] pci 0000:06:00.2: enabling Extended Tags
[    0.120252] pci 0000:06:00.3: [1022:15e0] type 00 class 0x0c0330
[    0.120290] pci 0000:06:00.3: reg 0x10: [mem 0xfe400000-0xfe4fffff 64bit]
[    0.120353] pci 0000:06:00.3: enabling Extended Tags
[    0.120434] pci 0000:06:00.3: PME# supported from D0 D3hot D3cold
[    0.120578] pci 0000:06:00.4: [1022:15e1] type 00 class 0x0c0330
[    0.120616] pci 0000:06:00.4: reg 0x10: [mem 0xfe300000-0xfe3fffff 64bit]
[    0.120679] pci 0000:06:00.4: enabling Extended Tags
[    0.120760] pci 0000:06:00.4: PME# supported from D0 D3hot D3cold
[    0.120901] pci 0000:06:00.6: [1022:15e3] type 00 class 0x040300
[    0.120932] pci 0000:06:00.6: reg 0x10: [mem 0xfe680000-0xfe687fff]
[    0.121010] pci 0000:06:00.6: enabling Extended Tags
[    0.121084] pci 0000:06:00.6: PME# supported from D0 D3hot D3cold
[    0.121282] pci 0000:00:08.1: PCI bridge to [bus 06]
[    0.121289] pci 0000:00:08.1:   bridge window [io  0xe000-0xefff]
[    0.121293] pci 0000:00:08.1:   bridge window [mem 0xfe300000-0xfe6fffff]
[    0.121300] pci 0000:00:08.1:   bridge window [mem 0xe0000000-0xf01fffff 64bit pref]
[    0.121379] pci 0000:07:00.0: [1022:7901] type 00 class 0x010601
[    0.121465] pci 0000:07:00.0: reg 0x24: [mem 0xfe900000-0xfe9007ff]
[    0.121486] pci 0000:07:00.0: enabling Extended Tags
[    0.121569] pci 0000:07:00.0: PME# supported from D3hot D3cold
[    0.121735] pci 0000:00:08.2: PCI bridge to [bus 07]
[    0.121744] pci 0000:00:08.2:   bridge window [mem 0xfe900000-0xfe9fffff]
[    0.122724] ACPI: PCI Interrupt Link [LNKA] (IRQs 4 5 7 10 11 14 15) *0
[    0.122846] ACPI: PCI Interrupt Link [LNKB] (IRQs 4 5 7 10 11 14 15) *0
[    0.122961] ACPI: PCI Interrupt Link [LNKC] (IRQs 4 5 7 10 11 14 15) *0
[    0.123096] ACPI: PCI Interrupt Link [LNKD] (IRQs 4 5 7 10 11 14 15) *0
[    0.123218] ACPI: PCI Interrupt Link [LNKE] (IRQs 4 5 7 10 11 14 15) *0
[    0.123319] ACPI: PCI Interrupt Link [LNKF] (IRQs 4 5 7 10 11 14 15) *0
[    0.123425] ACPI: PCI Interrupt Link [LNKG] (IRQs 4 5 7 10 11 14 15) *0
[    0.123528] ACPI: PCI Interrupt Link [LNKH] (IRQs 4 5 7 10 11 14 15) *0
[    0.125061] pci 0000:06:00.0: vgaarb: setting as boot VGA device
[    0.125061] pci 0000:06:00.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.125061] pci 0000:06:00.0: vgaarb: bridge control possible
[    0.125061] vgaarb: loaded
[    0.125226] SCSI subsystem initialized
[    0.125261] libata version 3.00 loaded.
[    0.125261] ACPI: bus type USB registered
[    0.125261] usbcore: registered new interface driver usbfs
[    0.125261] usbcore: registered new interface driver hub
[    0.125274] usbcore: registered new device driver usb
[    0.125314] pps_core: LinuxPPS API ver. 1 registered
[    0.125316] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
[    0.125326] PTP clock support registered
[    0.125440] EDAC MC: Ver: 3.0.0
[    0.126063] Advanced Linux Sound Architecture Driver Initialized.
[    0.126088] PCI: Using ACPI for IRQ routing
[    0.128336] PCI: pci_cache_line_size set to 64 bytes
[    0.128433] e820: reserve RAM buffer [mem 0x0009d400-0x0009ffff]
[    0.128436] e820: reserve RAM buffer [mem 0x09c00000-0x0bffffff]
[    0.128438] e820: reserve RAM buffer [mem 0x0b000000-0x0bffffff]
[    0.128439] e820: reserve RAM buffer [mem 0x96464000-0x97ffffff]
[    0.128441] e820: reserve RAM buffer [mem 0x9a5be000-0x9bffffff]
[    0.128443] e820: reserve RAM buffer [mem 0x9a7e5000-0x9bffffff]
[    0.128445] e820: reserve RAM buffer [mem 0x9e000000-0x9fffffff]
[    0.128446] e820: reserve RAM buffer [mem 0x21f340000-0x21fffffff]
[    0.129040] NetLabel: Initializing
[    0.129040] NetLabel:  domain hash size = 128
[    0.129040] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.129040] NetLabel:  unlabeled traffic allowed by default
[    0.129120] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.129124] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.131155] clocksource: Switched to clocksource tsc-early
[    0.152325] VFS: Disk quotas dquot_6.6.0
[    0.152349] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.152459] pnp: PnP ACPI init
[    0.152674] system 00:00: [mem 0xf8000000-0xfbffffff] has been reserved
[    0.152686] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.152821] system 00:01: [mem 0xfeb80000-0xfebfffff] has been reserved
[    0.152831] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.153055] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.153352] system 00:03: [io  0x0300-0x030f] has been reserved
[    0.153355] system 00:03: [io  0x0230-0x023f] has been reserved
[    0.153358] system 00:03: [io  0x0290-0x029f] has been reserved
[    0.153366] system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.153894] pnp 00:04: [dma 0 disabled]
[    0.153972] pnp 00:04: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.154399] system 00:05: [io  0x04d0-0x04d1] has been reserved
[    0.154401] system 00:05: [io  0x040b] has been reserved
[    0.154404] system 00:05: [io  0x04d6] has been reserved
[    0.154407] system 00:05: [io  0x0c00-0x0c01] has been reserved
[    0.154409] system 00:05: [io  0x0c14] has been reserved
[    0.154412] system 00:05: [io  0x0c50-0x0c51] has been reserved
[    0.154414] system 00:05: [io  0x0c52] has been reserved
[    0.154417] system 00:05: [io  0x0c6c] has been reserved
[    0.154419] system 00:05: [io  0x0c6f] has been reserved
[    0.154422] system 00:05: [io  0x0cd0-0x0cd1] has been reserved
[    0.154425] system 00:05: [io  0x0cd2-0x0cd3] has been reserved
[    0.154427] system 00:05: [io  0x0cd4-0x0cd5] has been reserved
[    0.154430] system 00:05: [io  0x0cd6-0x0cd7] has been reserved
[    0.154434] system 00:05: [io  0x0cd8-0x0cdf] has been reserved
[    0.154436] system 00:05: [io  0x0800-0x089f] has been reserved
[    0.154439] system 00:05: [io  0x0b00-0x0b0f] has been reserved
[    0.154442] system 00:05: [io  0x0b20-0x0b3f] has been reserved
[    0.154444] system 00:05: [io  0x0900-0x090f] has been reserved
[    0.154447] system 00:05: [io  0x0910-0x091f] has been reserved
[    0.154450] system 00:05: [mem 0xfec00000-0xfec00fff] could not be reserved
[    0.154454] system 00:05: [mem 0xfec01000-0xfec01fff] could not be reserved
[    0.154457] system 00:05: [mem 0xfedc0000-0xfedc0fff] has been reserved
[    0.154459] system 00:05: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.154463] system 00:05: [mem 0xfed80000-0xfed8ffff] could not be reserved
[    0.154466] system 00:05: [mem 0xfec10000-0xfec10fff] has been reserved
[    0.154468] system 00:05: [mem 0xff000000-0xffffffff] has been reserved
[    0.154477] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.155414] pnp: PnP ACPI: found 6 devices
[    0.163792] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.163866] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.163870] pci 0000:02:00.0:   bridge window [io  0xf000-0xffff]
[    0.163876] pci 0000:02:00.0:   bridge window [mem 0xfe700000-0xfe7fffff]
[    0.163886] pci 0000:02:01.0: PCI bridge to [bus 04]
[    0.163900] pci 0000:02:04.0: PCI bridge to [bus 05]
[    0.163913] pci 0000:01:00.2: PCI bridge to [bus 02-05]
[    0.163916] pci 0000:01:00.2:   bridge window [io  0xf000-0xffff]
[    0.163922] pci 0000:01:00.2:   bridge window [mem 0xfe700000-0xfe7fffff]
[    0.163931] pci 0000:00:01.2: PCI bridge to [bus 01-05]
[    0.163934] pci 0000:00:01.2:   bridge window [io  0xf000-0xffff]
[    0.163939] pci 0000:00:01.2:   bridge window [mem 0xfe700000-0xfe8fffff]
[    0.163950] pci 0000:00:08.1: PCI bridge to [bus 06]
[    0.163953] pci 0000:00:08.1:   bridge window [io  0xe000-0xefff]
[    0.163959] pci 0000:00:08.1:   bridge window [mem 0xfe300000-0xfe6fffff]
[    0.163963] pci 0000:00:08.1:   bridge window [mem 0xe0000000-0xf01fffff 64bit pref]
[    0.163970] pci 0000:00:08.2: PCI bridge to [bus 07]
[    0.163976] pci 0000:00:08.2:   bridge window [mem 0xfe900000-0xfe9fffff]
[    0.163987] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    0.163989] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
[    0.163991] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
[    0.163993] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    0.163995] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff window]
[    0.163997] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff window]
[    0.163999] pci_bus 0000:00: resource 10 [mem 0xe0000000-0xfec2ffff window]
[    0.164001] pci_bus 0000:00: resource 11 [mem 0xfee00000-0xffffffff window]
[    0.164003] pci_bus 0000:01: resource 0 [io  0xf000-0xffff]
[    0.164004] pci_bus 0000:01: resource 1 [mem 0xfe700000-0xfe8fffff]
[    0.164007] pci_bus 0000:02: resource 0 [io  0xf000-0xffff]
[    0.164008] pci_bus 0000:02: resource 1 [mem 0xfe700000-0xfe7fffff]
[    0.164010] pci_bus 0000:03: resource 0 [io  0xf000-0xffff]
[    0.164012] pci_bus 0000:03: resource 1 [mem 0xfe700000-0xfe7fffff]
[    0.164014] pci_bus 0000:06: resource 0 [io  0xe000-0xefff]
[    0.164016] pci_bus 0000:06: resource 1 [mem 0xfe300000-0xfe6fffff]
[    0.164018] pci_bus 0000:06: resource 2 [mem 0xe0000000-0xf01fffff 64bit pref]
[    0.164020] pci_bus 0000:07: resource 1 [mem 0xfe900000-0xfe9fffff]
[    0.164172] NET: Registered protocol family 2
[    0.164429] tcp_listen_portaddr_hash hash table entries: 4096 (order: 4, 65536 bytes)
[    0.164520] TCP established hash table entries: 65536 (order: 7, 524288 bytes)
[    0.164944] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.165284] TCP: Hash tables configured (established 65536 bind 65536)
[    0.165367] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[    0.165442] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[    0.165615] NET: Registered protocol family 1
[    0.165854] RPC: Registered named UNIX socket transport module.
[    0.165855] RPC: Registered udp transport module.
[    0.165856] RPC: Registered tcp transport module.
[    0.165856] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.166338] pci 0000:06:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.166348] pci 0000:06:00.1: Linked as a consumer to 0000:06:00.0
[    0.166819] PCI: CLS 64 bytes, default 64
[    0.166888] Unpacking initramfs...
[    0.837795] Freeing initrd memory: 26216K
[    1.158964] AMD-Vi: IOMMU performance counters supported
[    1.159101] pci 0000:00:00.2: can't derive routing for PCI INT A
[    1.159103] pci 0000:00:00.2: PCI INT A: not connected
[    1.159494] iommu: Adding device 0000:00:01.0 to group 0
[    1.159703] iommu: Adding device 0000:00:01.2 to group 1
[    1.159884] iommu: Adding device 0000:00:08.0 to group 2
[    1.160088] iommu: Adding device 0000:00:08.1 to group 3
[    1.160136] iommu: Adding device 0000:00:08.2 to group 2
[    1.160333] iommu: Adding device 0000:00:14.0 to group 4
[    1.160364] iommu: Adding device 0000:00:14.3 to group 4
[    1.160560] iommu: Adding device 0000:00:18.0 to group 5
[    1.160593] iommu: Adding device 0000:00:18.1 to group 5
[    1.160623] iommu: Adding device 0000:00:18.2 to group 5
[    1.160655] iommu: Adding device 0000:00:18.3 to group 5
[    1.160685] iommu: Adding device 0000:00:18.4 to group 5
[    1.160718] iommu: Adding device 0000:00:18.5 to group 5
[    1.160748] iommu: Adding device 0000:00:18.6 to group 5
[    1.160778] iommu: Adding device 0000:00:18.7 to group 5
[    1.160997] iommu: Adding device 0000:01:00.0 to group 6
[    1.161057] iommu: Adding device 0000:01:00.1 to group 6
[    1.161104] iommu: Adding device 0000:01:00.2 to group 6
[    1.161135] iommu: Adding device 0000:02:00.0 to group 6
[    1.161164] iommu: Adding device 0000:02:01.0 to group 6
[    1.161192] iommu: Adding device 0000:02:04.0 to group 6
[    1.161236] iommu: Adding device 0000:03:00.0 to group 6
[    1.161478] iommu: Adding device 0000:06:00.0 to group 7
[    1.161577] iommu: Using direct mapping for device 0000:06:00.0
[    1.161782] iommu: Adding device 0000:06:00.1 to group 8
[    1.161835] iommu: Adding device 0000:06:00.2 to group 8
[    1.161886] iommu: Adding device 0000:06:00.3 to group 8
[    1.161938] iommu: Adding device 0000:06:00.4 to group 8
[    1.161991] iommu: Adding device 0000:06:00.6 to group 8
[    1.162025] iommu: Adding device 0000:07:00.0 to group 2
[    1.162392] AMD-Vi: Found IOMMU at 0000:00:00.2 cap 0x40
[    1.162393] AMD-Vi: Extended features (0x4f77ef22294ada):
[    1.162394]  PPR NX GT IA GA PC GA_vAPIC
[    1.162654] AMD-Vi: Lazy IO/TLB flushing enabled
[    1.166990] amd_uncore: AMD NB counters detected
[    1.166999] amd_uncore: AMD LLC counters detected
[    1.167385] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 counters/bank).
[    1.169784] Scanning for low memory corruption every 60 seconds
[    1.171618] Initialise system trusted keyrings
[    1.171747] workingset: timestamp_bits=56 max_order=21 bucket_order=0
[    1.180351] NFS: Registering the id_resolver key type
[    1.180401] Key type id_resolver registered
[    1.180402] Key type id_legacy registered
[    1.180614] SELinux:  Registering netfilter hooks
[    1.182469] Key type asymmetric registered
[    1.182470] Asymmetric key parser 'x509' registered
[    1.182525] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
[    1.182528] io scheduler noop registered
[    1.182529] io scheduler deadline registered
[    1.182605] io scheduler cfq registered (default)
[    1.182606] io scheduler mq-deadline registered
[    1.182607] io scheduler kyber registered
[    1.184176] pcieport 0000:00:01.2: AER enabled with IRQ 26
[    1.184467] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    1.184482] ACPI: Power Button [PWRB]
[    1.184556] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    1.184577] ACPI: Power Button [PWRF]
[    1.184734] Monitor-Mwait will be used to enter C-1 state
[    1.186290] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.207250] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    1.208086] Non-volatile memory driver v1.3
[    1.208130] Linux agpgart interface v0.103
[    1.214425] loop: module loaded
[    1.214693] ahci 0000:01:00.1: version 3.0
[    1.214930] ahci 0000:01:00.1: SSS flag set, parallel bus scan disabled
[    1.214994] ahci 0000:01:00.1: AHCI 0001.0301 32 slots 8 ports 6 Gbps 0x33 impl SATA mode
[    1.215000] ahci 0000:01:00.1: flags: 64bit ncq sntf stag pm led clo only pmp pio slum part sxs deso sadm sds apst 
[    1.216601] scsi host0: ahci
[    1.216895] scsi host1: ahci
[    1.217127] scsi host2: ahci
[    1.217338] scsi host3: ahci
[    1.217549] scsi host4: ahci
[    1.217755] scsi host5: ahci
[    1.217968] scsi host6: ahci
[    1.218179] scsi host7: ahci
[    1.218269] ata1: SATA max UDMA/133 abar m131072@0xfe880000 port 0xfe880100 irq 34
[    1.218272] ata2: SATA max UDMA/133 abar m131072@0xfe880000 port 0xfe880180 irq 34
[    1.218273] ata3: DUMMY
[    1.218274] ata4: DUMMY
[    1.218277] ata5: SATA max UDMA/133 abar m131072@0xfe880000 port 0xfe880300 irq 34
[    1.218280] ata6: SATA max UDMA/133 abar m131072@0xfe880000 port 0xfe880380 irq 34
[    1.218281] ata7: DUMMY
[    1.218282] ata8: DUMMY
[    1.218607] ahci 0000:07:00.0: AHCI 0001.0301 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
[    1.218612] ahci 0000:07:00.0: flags: 64bit ncq sntf ilck pm led clo only pmp fbs pio slum part 
[    1.218954] scsi host8: ahci
[    1.219089] ata9: SATA max UDMA/133 abar m2048@0xfe900000 port 0xfe900100 irq 36
[    1.219386] e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2-NAPI
[    1.219387] e100: Copyright(c) 1999-2006 Intel Corporation
[    1.219427] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
[    1.219428] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    1.219465] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    1.219466] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    1.219510] sky2: driver version 1.30
[    1.219635] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[    1.224352] r8169 0000:03:00.0 eth0: RTL8168h/8111h, b0:6e:bf:2f:47:8d, XID 54100800, IRQ 37
[    1.224356] r8169 0000:03:00.0 eth0: jumbo features [frames: 9200 bytes, tx checksumming: ko]
[    1.224586] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.224587] ehci-pci: EHCI PCI platform driver
[    1.224617] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.224624] ohci-pci: OHCI PCI platform driver
[    1.224651] uhci_hcd: USB Universal Host Controller Interface driver
[    1.224881] xhci_hcd 0000:01:00.0: xHCI Host Controller
[    1.224961] xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 1
[    1.280349] xhci_hcd 0000:01:00.0: hcc params 0x0200ef81 hci version 0x110 quirks 0x0000000048000410
[    1.280674] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.18
[    1.280676] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.280678] usb usb1: Product: xHCI Host Controller
[    1.280680] usb usb1: Manufacturer: Linux 4.18.0-rc1+ xhci-hcd
[    1.280681] usb usb1: SerialNumber: 0000:01:00.0
[    1.280867] hub 1-0:1.0: USB hub found
[    1.280890] hub 1-0:1.0: 10 ports detected
[    1.293176] xhci_hcd 0000:01:00.0: xHCI Host Controller
[    1.293252] xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 2
[    1.293257] xhci_hcd 0000:01:00.0: Host supports USB 3.10 Enhanced SuperSpeed
[    1.293301] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[    1.293348] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 4.18
[    1.293350] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.293352] usb usb2: Product: xHCI Host Controller
[    1.293354] usb usb2: Manufacturer: Linux 4.18.0-rc1+ xhci-hcd
[    1.293355] usb usb2: SerialNumber: 0000:01:00.0
[    1.293534] hub 2-0:1.0: USB hub found
[    1.293549] hub 2-0:1.0: 4 ports detected
[    1.298474] xhci_hcd 0000:06:00.3: xHCI Host Controller
[    1.298546] xhci_hcd 0000:06:00.3: new USB bus registered, assigned bus number 3
[    1.298756] xhci_hcd 0000:06:00.3: hcc params 0x0270ffe5 hci version 0x110 quirks 0x0000000040000410
[    1.299311] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.18
[    1.299314] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.299315] usb usb3: Product: xHCI Host Controller
[    1.299317] usb usb3: Manufacturer: Linux 4.18.0-rc1+ xhci-hcd
[    1.299318] usb usb3: SerialNumber: 0000:06:00.3
[    1.299483] hub 3-0:1.0: USB hub found
[    1.299504] hub 3-0:1.0: 4 ports detected
[    1.300041] xhci_hcd 0000:06:00.3: xHCI Host Controller
[    1.300097] xhci_hcd 0000:06:00.3: new USB bus registered, assigned bus number 4
[    1.300101] xhci_hcd 0000:06:00.3: Host supports USB 3.10 Enhanced SuperSpeed
[    1.300142] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
[    1.300183] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 4.18
[    1.300185] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.300187] usb usb4: Product: xHCI Host Controller
[    1.300189] usb usb4: Manufacturer: Linux 4.18.0-rc1+ xhci-hcd
[    1.300190] usb usb4: SerialNumber: 0000:06:00.3
[    1.300351] hub 4-0:1.0: USB hub found
[    1.300371] hub 4-0:1.0: 4 ports detected
[    1.300987] xhci_hcd 0000:06:00.4: xHCI Host Controller
[    1.301057] xhci_hcd 0000:06:00.4: new USB bus registered, assigned bus number 5
[    1.301238] xhci_hcd 0000:06:00.4: hcc params 0x0260ffe5 hci version 0x110 quirks 0x0000000040000410
[    1.301710] usb usb5: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.18
[    1.301712] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.301714] usb usb5: Product: xHCI Host Controller
[    1.301715] usb usb5: Manufacturer: Linux 4.18.0-rc1+ xhci-hcd
[    1.301717] usb usb5: SerialNumber: 0000:06:00.4
[    1.301870] hub 5-0:1.0: USB hub found
[    1.301887] hub 5-0:1.0: 1 port detected
[    1.302052] xhci_hcd 0000:06:00.4: xHCI Host Controller
[    1.302119] xhci_hcd 0000:06:00.4: new USB bus registered, assigned bus number 6
[    1.302123] xhci_hcd 0000:06:00.4: Host supports USB 3.10 Enhanced SuperSpeed
[    1.302162] usb usb6: We don't know the algorithms for LPM for this host, disabling LPM.
[    1.302201] usb usb6: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 4.18
[    1.302203] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.302205] usb usb6: Product: xHCI Host Controller
[    1.302206] usb usb6: Manufacturer: Linux 4.18.0-rc1+ xhci-hcd
[    1.302208] usb usb6: SerialNumber: 0000:06:00.4
[    1.302364] hub 6-0:1.0: USB hub found
[    1.302383] hub 6-0:1.0: 1 port detected
[    1.302568] usbcore: registered new interface driver usblp
[    1.302622] usbcore: registered new interface driver usb-storage
[    1.302661] i8042: PNP: No PS/2 controller found.
[    1.302957] rtc_cmos 00:02: RTC can wake from S4
[    1.303259] rtc_cmos 00:02: registered as rtc0
[    1.303291] rtc_cmos 00:02: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    1.303652] device-mapper: ioctl: 4.39.0-ioctl (2018-04-03) initialised: dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
[    1.303688] hidraw: raw HID events driver (C) Jiri Kosina
[    1.304101] usbcore: registered new interface driver usbhid
[    1.304102] usbhid: USB HID core driver
[    1.305600] Initializing XFRM netlink socket
[    1.305952] NET: Registered protocol family 10
[    1.306538] Segment Routing with IPv6
[    1.307580] hdaudio hdaudioC0D0: Unable to bind the codec
[    1.307925] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    1.308168] NET: Registered protocol family 17
[    1.308223] Key type dns_resolver registered
[    1.311800] microcode: CPU0: patch_level=0x0810100b
[    1.311809] microcode: CPU1: patch_level=0x0810100b
[    1.311818] microcode: CPU2: patch_level=0x0810100b
[    1.311825] microcode: CPU3: patch_level=0x0810100b
[    1.311832] microcode: CPU4: patch_level=0x0810100b
[    1.311842] microcode: CPU5: patch_level=0x0810100b
[    1.311847] microcode: CPU6: patch_level=0x0810100b
[    1.311853] microcode: CPU7: patch_level=0x0810100b
[    1.311916] microcode: Microcode Update Driver: v2.2.
[    1.311952] sched_clock: Marking stable (1311905448, 0)->(1430347832, -118442384)
[    1.312323] registered taskstats version 1
[    1.312324] Loading compiled-in X.509 certificates
[    1.312389] Unable to create integrity sysfs dir: -19
[    1.313682]   Magic number: 10:991:76
[    1.313798] console [netcon0] enabled
[    1.313799] netconsole: network logging started
[    1.314060] acpi_cpufreq: overriding BIOS provided _PSD data
[    1.315017] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    1.315937] hdaudio hdaudioC1D0: Unable to bind the codec
[    1.318373] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    1.318445] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[    1.318448] cfg80211: failed to load regulatory.db
[    1.318476] ALSA device list:
[    1.318477]   No soundcards found.
[    1.525639] ata9: SATA link down (SStatus 0 SControl 300)
[    1.618237] usb 1-1: new high-speed USB device number 2 using xhci_hcd
[    1.680230] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.687478] ata1.00: ATA-8: KINGSTON SV300S37A120G, 608ABBF0, max UDMA/133
[    1.687481] ata1.00: 234441648 sectors, multi 1: LBA48 NCQ (depth 32), AA
[    1.695984] ata1.00: configured for UDMA/133
[    1.696489] scsi 0:0:0:0: Direct-Access     ATA      KINGSTON SV300S3 BBF0 PQ: 0 ANSI: 5
[    1.696942] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    1.697161] sd 0:0:0:0: [sda] 234441648 512-byte logical blocks: (120 GB/112 GiB)
[    1.697191] sd 0:0:0:0: [sda] Write Protect is off
[    1.697195] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.697240] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.698121]  sda: sda1 sda2 sda3
[    1.698865] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.756746] usb 1-1: New USB device found, idVendor=0409, idProduct=005a, bcdDevice= 1.00
[    1.756750] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    1.761768] hub 1-1:1.0: USB hub found
[    1.764715] hub 1-1:1.0: 4 ports detected
[    1.865625] usb 2-2: new SuperSpeed Gen 1 USB device number 2 using xhci_hcd
[    1.888958] usb 2-2: New USB device found, idVendor=2001, idProduct=4a00, bcdDevice= 1.00
[    1.888962] usb 2-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    1.888965] usb 2-2: Product: D-Link DUB-1312
[    1.888967] usb 2-2: Manufacturer: D-Link Elec. Corp.
[    1.888970] usb 2-2: SerialNumber: 000000000018A9
[    2.003812] random: fast init done
[    2.004284] ata2: SATA link down (SStatus 0 SControl 300)
[    2.087354] usb 1-1.4: new low-speed USB device number 3 using xhci_hcd
[    2.207336] tsc: Refined TSC clocksource calibration: 3596.280 MHz
[    2.207359] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x33d6997384c, max_idle_ns: 440795274815 ns
[    2.207414] clocksource: Switched to clocksource tsc
[    2.309208] ata5: SATA link down (SStatus 0 SControl 300)
[    2.410594] usb 1-1.4: New USB device found, idVendor=046d, idProduct=c31c, bcdDevice=64.00
[    2.410599] usb 1-1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.410602] usb 1-1.4: Product: USB Keyboard
[    2.410604] usb 1-1.4: Manufacturer: Logitech
[    2.526813] input: Logitech USB Keyboard as /devices/pci0000:00/0000:00:01.2/0000:01:00.0/usb1/1-1/1-1.4/1-1.4:1.0/0003:046D:C31C.0001/input/input2
[    2.578910] hid-generic 0003:046D:C31C.0001: input,hidraw0: USB HID v1.10 Keyboard [Logitech USB Keyboard] on usb-0000:01:00.0-1.4/input0
[    2.623768] ata6: SATA link down (SStatus 0 SControl 300)
[    3.111799] Freeing unused kernel memory: 1592K
[    3.112168] input: Logitech USB Keyboard Consumer Control as /devices/pci0000:00/0000:00:01.2/0000:01:00.0/usb1/1-1/1-1.4/1-1.4:1.1/0003:046D:C31C.0002/input/input3
[    3.113021] Write protecting the kernel read-only data: 30720k
[    3.115059] Freeing unused kernel memory: 2004K
[    3.117621] Freeing unused kernel memory: 716K
[    3.132043] systemd[1]: systemd 238 running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=hybrid)
[    3.144606] systemd[1]: Detected architecture x86-64.
[    3.144610] systemd[1]: Running in initial RAM disk.
[    3.146848] systemd[1]: Set hostname to <raven>.
[    3.164160] input: Logitech USB Keyboard System Control as /devices/pci0000:00/0000:00:01.2/0000:01:00.0/usb1/1-1/1-1.4/1-1.4:1.1/0003:046D:C31C.0002/input/input4
[    3.164263] input: Logitech USB Keyboard Consumer Control as /devices/pci0000:00/0000:00:01.2/0000:01:00.0/usb1/1-1/1-1.4/1-1.4:1.1/0003:046D:C31C.0002/input/input5
[    3.164366] hid-generic 0003:046D:C31C.0002: input,hidraw1: USB HID v1.10 Device [Logitech USB Keyboard] on usb-0000:01:00.0-1.4/input1
[    3.196095] systemd[1]: File /usr/lib/systemd/system/systemd-journald.service:35 configures an IP firewall (IPAddressDeny=any), but the local system does not support BPF/cgroup based firewalling.
[    3.196099] systemd[1]: Proceeding WITHOUT firewalling in effect! (This warning is only shown for the first loaded unit using IP firewalling.)
[    3.200607] random: systemd: uninitialized urandom read (16 bytes read)
[    3.200677] systemd[1]: Listening on Journal Audit Socket.
[    3.200747] random: systemd: uninitialized urandom read (16 bytes read)
[    3.200804] systemd[1]: Listening on udev Kernel Socket.
[    3.200816] random: systemd: uninitialized urandom read (16 bytes read)
[    3.200928] systemd[1]: Listening on Journal Socket (/dev/log).
[    3.201078] systemd[1]: Listening on Journal Socket.
[    3.206450] input: Logitech USB Keyboard as /devices/pci0000:00/0000:00:01.2/0000:01:00.0/usb1/1-1/1-1.4/1-1.4:1.2/0003:046D:C31C.0003/input/input6
[    3.206671] hid-generic 0003:046D:C31C.0003: input,hidraw2: USB HID v1.10 Mouse [Logitech USB Keyboard] on usb-0000:01:00.0-1.4/input2
[    3.214399] systemd-tmpfile (1464) used greatest stack depth: 21472 bytes left
[    3.215509] audit: type=1130 audit(1531742694.214:2): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-tmpfiles-setup-dev comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    3.217110] audit: type=1130 audit(1531742694.216:3): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-sysctl comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    3.270812] audit: type=1130 audit(1531742694.269:4): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-cmdline comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    3.297305] audit: type=1130 audit(1531742694.296:5): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-pre-udev comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    3.309571] audit: type=1130 audit(1531742694.308:6): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-udevd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    3.328878] audit: type=1130 audit(1531742694.327:7): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-vconsole-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    3.328901] audit: type=1131 audit(1531742694.327:8): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-vconsole-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    3.355520] audit: type=1130 audit(1531742694.354:9): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-journald comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    3.447307] kworker/u32:1 (2214) used greatest stack depth: 19936 bytes left
[    3.452841] audit: type=1130 audit(1531742694.451:10): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-udev-trigger comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    3.483912] r8169 0000:03:00.0 enp3s0: renamed from eth0
[    3.842387] ax88179_178a 2-2:1.0 eth0: register 'ax88179_178a' at usb-0000:01:00.0-2, D-Link DUB-1312 USB 3.0 to Gigabit Ethernet Adapter, 54:b8:0a:ef:ed:d7
[    3.842445] usbcore: registered new interface driver ax88179_178a
[    3.845984] ax88179_178a 2-2:1.0 enp1s0f0u2: renamed from eth0
[    3.911286] EXT4-fs (sda3): mounted filesystem with ordered data mode. Opts: (null)
[    4.304830] systemd-journald[1461]: Received SIGTERM from PID 1 (systemd).
[    4.343317] systemd: 23 output lines suppressed due to ratelimiting
[    4.416575] SELinux:  Disabled at runtime.
[    4.416590] SELinux:  Unregistering netfilter hooks
[    4.462844] systemd[1]: systemd 238 running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=hybrid)
[    4.475545] systemd[1]: Detected architecture x86-64.
[    4.476237] systemd[1]: Set hostname to <raven>.
[    4.509446] systemd-getty-g (2456) used greatest stack depth: 19768 bytes left
[    4.533202] anaconda-genera (2446) used greatest stack depth: 18864 bytes left
[    4.581723] systemd[1]: File /usr/lib/systemd/system/systemd-journald.service:35 configures an IP firewall (IPAddressDeny=any), but the local system does not support BPF/cgroup based firewalling.
[    4.581728] systemd[1]: Proceeding WITHOUT firewalling in effect! (This warning is only shown for the first loaded unit using IP firewalling.)
[    4.631199] systemd[1]: /usr/lib/systemd/system/virtlockd-admin.socket:7: Unknown lvalue 'Server' in section 'Socket'
[    4.662626] systemd[1]: Stopped Switch Root.
[    4.662822] systemd[1]: systemd-journald.service: Service has no hold-off time, scheduling restart.
[    4.662886] systemd[1]: systemd-journald.service: Scheduled restart job, restart counter is at 1.
[    4.662900] systemd[1]: Stopped Journal Service.
[    4.693285] EXT4-fs (sda3): re-mounted. Opts: (null)
[    4.709356] systemd-journald[2468]: Received request to flush runtime journal from PID 1
[    4.909696] journalctl (2484) used greatest stack depth: 18608 bytes left
[    5.036020] Adding 7826428k swap on /dev/sda2.  Priority:-2 extents:1 across:7826428k SS
[    5.173523] kauditd_printk_skb: 51 callbacks suppressed
[    5.173526] audit: type=1130 audit(1531742696.172:62): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-udev-settle comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.176232] audit: type=1130 audit(1531742696.175:63): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=lvm2-lvmetad comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.192131] audit: type=1130 audit(1531742696.191:64): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=lvm2-monitor comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.197205] audit: type=1130 audit(1531742696.196:65): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=dmraid-activation comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.197223] audit: type=1131 audit(1531742696.196:66): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=dmraid-activation comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.222551] audit: type=1130 audit(1531742696.221:67): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-fsck@dev-disk-by\x2duuid-05bc52dc\x2d0680\x2d4590\x2d9517\x2d8bc91c1cae3d comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.232504] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[    5.241491] audit: type=1130 audit(1531742696.240:68): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=dracut-shutdown comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.245256] audit: type=1130 audit(1531742696.244:69): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=nfs-config comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.245263] audit: type=1131 audit(1531742696.244:70): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=nfs-config comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.252558] audit: type=1130 audit(1531742696.251:71): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=plymouth-read-write comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.382180] random: crng init done
[    5.382183] random: 7 urandom warning(s) missed due to ratelimiting
[    5.634882] IPv6: ADDRCONF(NETDEV_UP): enp1s0f0u2: link is not ready
[    5.656989] plymouthd (2338) used greatest stack depth: 17336 bytes left
[    5.994336] IPv6: ADDRCONF(NETDEV_UP): enp1s0f0u2: link is not ready
[    5.998027] IPv6: ADDRCONF(NETDEV_UP): enp3s0: link is not ready
[    6.035372] r8169 0000:03:00.0 enp3s0: link down
[    6.035504] IPv6: ADDRCONF(NETDEV_UP): enp3s0: link is not ready
[    8.585692] ax88179_178a 2-2:1.0 enp1s0f0u2: ax88179 - Link status is: 1
[    8.604672] IPv6: ADDRCONF(NETDEV_CHANGE): enp1s0f0u2: link becomes ready
[   51.189904] [drm] amdgpu kernel modesetting enabled.
[   51.194028] Parsing CRAT table with 1 nodes
[   51.194040] Creating topology SYSFS entries
[   51.194112] Topology: Add APU node [0x0:0x0]
[   51.194113] Finished initializing topology
[   51.194176] kfd kfd: Initialized module
[   51.194827] [drm] initializing kernel modesetting (RAVEN 0x1002:0x15DD 0x1043:0x876B 0xC6).
[   51.194846] [drm] register mmio base: 0xFE600000
[   51.194847] [drm] register mmio size: 524288
[   51.194866] [drm] add ip block number 0 <soc15_common>
[   51.194867] [drm] add ip block number 1 <gmc_v9_0>
[   51.194869] [drm] add ip block number 2 <vega10_ih>
[   51.194869] [drm] add ip block number 3 <psp>
[   51.194871] [drm] add ip block number 4 <powerplay>
[   51.194872] [drm] add ip block number 5 <dm>
[   51.194873] [drm] add ip block number 6 <gfx_v9_0>
[   51.194874] [drm] add ip block number 7 <sdma_v4_0>
[   51.194875] [drm] add ip block number 8 <vcn_v1_0>
[   51.195819] kfd kfd: DID 15dd is missing in supported_devices
[   51.195821] kfd kfd: kgd2kfd_probe failed
[   51.196009] [drm] VCN decode is enabled in VM mode
[   51.196010] [drm] VCN encode is enabled in VM mode
[   51.196011] [drm] VCN jpeg decode is enabled in VM mode
[   51.219956] [drm] BIOS signature incorrect 65 7
[   51.219997] ATOM BIOS: 113-RAVEN-106
[   51.220059] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, fragment size is 9-bit
[   51.220073] amdgpu 0000:06:00.0: VRAM: 1024M 0x000000F400000000 - 0x000000F43FFFFFFF (1024M used)
[   51.220076] amdgpu 0000:06:00.0: GART: 1024M 0x000000F500000000 - 0x000000F53FFFFFFF
[   51.220081] [drm] Detected VRAM RAM=1024M, BAR=1024M
[   51.220082] [drm] RAM width 128bits DDR4
[   51.220191] [TTM] Zone  kernel: Available graphics memory: 3096758 kiB
[   51.220192] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[   51.220193] [TTM] Initializing pool allocator
[   51.220200] [TTM] Initializing DMA pool allocator
[   51.220301] [drm] amdgpu: 1024M of VRAM memory ready
[   51.220303] [drm] amdgpu: 3072M of GTT memory ready.
[   51.220320] [drm] GART: num cpu pages 262144, num gpu pages 262144
[   51.220500] [drm] PCIE GART of 1024M enabled (table at 0x000000F400900000).
[   51.229340] [drm] use_doorbell being set to: [true]
[   51.230400] [drm] Found VCN firmware Version: 1.24 Family ID: 18
[   51.297170] amdgpu: [powerplay] dpm has been enabled
[   51.297278] [drm] DM_PPLIB: values for Invalid clock
[   51.297280] [drm] DM_PPLIB:	 0 in kHz
[   51.297280] [drm] DM_PPLIB:	 400000 in kHz
[   51.297281] [drm] DM_PPLIB:	 933000 in kHz
[   51.297282] [drm] DM_PPLIB:	 1067000 in kHz
[   51.297472] WARNING: CPU: 5 PID: 3753 at drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:1372 dcn_bw_update_from_pplib+0x309/0x530 [amdgpu]
[   51.297473] Modules linked in: amdkfd amdgpu(+) mfd_core chash gpu_sched ttm ax88179_178a usbnet
[   51.297484] CPU: 5 PID: 3753 Comm: modprobe Not tainted 4.18.0-rc1+ #5
[   51.297486] Hardware name: System manufacturer System Product Name/TUF B350M-PLUS GAMING, BIOS 4011 04/19/2018
[   51.297648] RIP: 0010:dcn_bw_update_from_pplib+0x309/0x530 [amdgpu]
[   51.297648] Code: 64 1d 00 dc f9 d9 c9 dc 4c 24 08 dc 0d b0 64 1d 00 de f1 d9 5c 24 08 e8 a5 36 93 d2 f3 0f 10 5c 24 08 f3 41 0f 11 5f 4c eb 02 <0f> 0b 4c 8d a4 24 c0 00 00 00 48 8b 3c 24 be 04 00 00 00 4c 89 e2 
[   51.297680] RSP: 0018:ffff8801cd3c6908 EFLAGS: 00010246
[   51.297682] RAX: 0000000000000000 RBX: ffff8801cd3c6948 RCX: ffffffffc042f648
[   51.297684] RDX: 0000000000000007 RSI: dffffc0000000000 RDI: ffff8801cd3c694c
[   51.297685] RBP: ffff8801cc97c400 R08: ffffed003c02bc9f R09: ffffed003c02bc9e
[   51.297687] R10: ffffed003c02bc9e R11: ffff8801e015e4f7 R12: 0000000000000004
[   51.297688] R13: 1ffff10039a78d25 R14: ffff8801d7368240 R15: 0000000000000000
[   51.297690] FS:  00007fb33ca420c0(0000) GS:ffff8801e0140000(0000) knlGS:0000000000000000
[   51.297692] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   51.297693] CR2: 00007fb33bf7a0a0 CR3: 00000001ca564000 CR4: 00000000003406e0
[   51.297694] Call Trace:
[   51.297858]  ? dcn_find_dcfclk_suits_all+0x610/0x610 [amdgpu]
[   51.297862]  ? rcu_note_context_switch+0x2a0/0x2a0
[   51.298025]  ? dcn10_create_resource_pool+0x5e6/0xef0 [amdgpu]
[   51.298186]  ? dcn10_create_resource_pool+0x5e6/0xef0 [amdgpu]
[   51.298348]  ? dcn10_create_resource_pool+0xbe2/0xef0 [amdgpu]
[   51.298510]  ? dal_i2caux_construct_engine+0x22/0x30 [amdgpu]
[   51.298672]  ? dal_aux_engine_dce110_create+0x9f/0xd0 [amdgpu]
[   51.298833]  ? dcn10_clock_source_destroy+0x30/0x30 [amdgpu]
[   51.298995]  ? dal_i2caux_dce110_construct+0x386/0x400 [amdgpu]
[   51.299155]  ? dc_create_resource_pool+0x8b/0x240 [amdgpu]
[   51.299314]  ? resource_parse_asic_id+0x170/0x170 [amdgpu]
[   51.299318]  ? kasan_kmalloc+0xbf/0xe0
[   51.299479]  ? dal_gpio_service_create+0xe7/0x180 [amdgpu]
[   51.299482]  ? __kmalloc+0x104/0x1f0
[   51.299643]  ? dal_gpio_service_create+0xe7/0x180 [amdgpu]
[   51.299803]  ? dc_create+0x407/0xc90 [amdgpu]
[   51.299964]  ? dc_create_state+0xe0/0xe0 [amdgpu]
[   51.300124]  ? amdgpu_dm_irq_unregister_interrupt+0x320/0x320 [amdgpu]
[   51.300263]  ? amdgpu_mm_rreg+0x1e4/0x210 [amdgpu]
[   51.300266]  ? rcu_note_context_switch+0x2a0/0x2a0
[   51.300268]  ? kasan_unpoison_shadow+0x30/0x40
[   51.300270]  ? kasan_kmalloc+0xbf/0xe0
[   51.300424]  ? amdgpu_cgs_create_device+0x27/0x60 [amdgpu]
[   51.300427]  ? kmem_cache_alloc_trace+0xea/0x1a0
[   51.300580]  ? amdgpu_cgs_create_device+0x27/0x60 [amdgpu]
[   51.300740]  ? dm_hw_init+0x20c/0x320 [amdgpu]
[   51.300900]  ? dm_resume+0x580/0x580 [amdgpu]
[   51.301058]  ? psm_set_states+0xc3/0xe0 [amdgpu]
[   51.301214]  ? hwmgr_hw_init+0x27e/0x2a0 [amdgpu]
[   51.301373]  ? amdgpu_device_init.cold.29+0x11ca/0x1784 [amdgpu]
[   51.301514]  ? amdgpu_device_has_dc_support+0x30/0x30 [amdgpu]
[   51.301518]  ? __alloc_pages_nodemask+0x26c/0x4e0
[   51.301521]  ? __alloc_pages_slowpath+0x1780/0x1780
[   51.301523]  ? save_stack+0x8c/0xb0
[   51.301527]  ? mutex_unlock+0x18/0x40
[   51.301530]  ? kernfs_activate+0x13f/0x180
[   51.301533]  ? kernfs_get+0x10/0x10
[   51.301535]  ? kasan_unpoison_shadow+0x30/0x40
[   51.301538]  ? kmalloc_order+0x46/0x60
[   51.301679]  ? amdgpu_driver_load_kms+0x110/0x3c0 [amdgpu]
[   51.301819]  ? amdgpu_driver_unload_kms+0xd0/0xd0 [amdgpu]
[   51.301822]  ? sysfs_do_create_link_sd.isra.2+0xef/0x190
[   51.301825]  ? __kasan_slab_free+0x13a/0x170
[   51.301828]  ? drm_dev_register+0x1a4/0x1f0
[   51.301969]  ? amdgpu_pci_probe+0x1af/0x230 [amdgpu]
[   51.302108]  ? amdgpu_pmops_runtime_idle+0x190/0x190 [amdgpu]
[   51.302112]  ? local_pci_probe+0x6b/0xc0
[   51.302115]  ? pci_device_probe+0x195/0x260
[   51.302117]  ? pci_device_remove+0x1d0/0x1d0
[   51.302122]  ? driver_probe_device+0x426/0x510
[   51.302124]  ? driver_probe_done+0xb0/0xb0
[   51.302127]  ? mutex_lock+0xa1/0x100
[   51.302129]  ? __mutex_lock_slowpath+0x10/0x10
[   51.302132]  ? driver_probe_device+0x510/0x510
[   51.302135]  ? __driver_attach+0x12c/0x130
[   51.302137]  ? bus_for_each_dev+0xe1/0x140
[   51.302140]  ? subsys_dev_iter_exit+0x10/0x10
[   51.302142]  ? bus_add_driver+0x78/0x2c0
[   51.302144]  ? kmem_cache_alloc_trace+0xea/0x1a0
[   51.302147]  ? bus_add_driver+0x276/0x2c0
[   51.302150]  ? driver_register+0xca/0x140
[   51.302153]  ? __pci_register_driver+0x144/0x170
[   51.302155]  ? pci_bus_num_vf+0x10/0x10
[   51.302158]  ? kmem_cache_create_usercopy+0x1a8/0x290
[   51.302160]  ? 0xffffffffc06d0000
[   51.302163]  ? do_one_initcall+0xa2/0x2cc
[   51.302166]  ? trace_event_raw_event_initcall_finish+0x130/0x130
[   51.302169]  ? llist_add_batch+0xbc/0x110
[   51.302171]  ? llist_reverse_order+0x30/0x30
[   51.302175]  ? pmd_clear_huge+0x9/0x40
[   51.302177]  ? vunmap_page_range+0x269/0x3c0
[   51.302179]  ? rcu_note_context_switch+0x2a0/0x2a0
[   51.302182]  ? kasan_unpoison_shadow+0x30/0x40
[   51.302184]  ? kasan_kmalloc+0xbf/0xe0
[   51.302186]  ? kasan_unpoison_shadow+0x30/0x40
[   51.302190]  ? do_init_module+0x14e/0x3c0
[   51.302192]  ? __x64_sys_delete_module+0x3c0/0x3c0
[   51.302195]  ? __kasan_slab_free+0x13a/0x170
[   51.302197]  ? load_module+0x3791/0x3f10
[   51.302203]  ? module_frob_arch_sections+0x20/0x20
[   51.302205]  ? __vfs_read+0x32f/0x370
[   51.302208]  ? __x64_sys_copy_file_range+0x360/0x360
[   51.302212]  ? __fsnotify_update_child_dentry_flags.part.3+0x2d0/0x2d0
[   51.302214]  ? __fsnotify_parent+0x7f/0x210
[   51.302217]  ? __fsnotify_update_child_dentry_flags.part.3+0x2d0/0x2d0
[   51.302220]  ? vfs_read+0x16c/0x1a0
[   51.302222]  ? vfs_read+0xbe/0x1a0
[   51.302224]  ? kernel_read+0x6f/0x90
[   51.302227]  ? kernel_read_file+0x210/0x2f0
[   51.302230]  ? free_bprm+0xf0/0xf0
[   51.302232]  ? up_read+0x20/0x20
[   51.302236]  ? __do_sys_finit_module+0x18f/0x1c0
[   51.302238]  ? __do_sys_finit_module+0x18f/0x1c0
[   51.302240]  ? __ia32_sys_init_module+0x40/0x40
[   51.302243]  ? vfs_statx_fd+0x3f/0x80
[   51.302245]  ? __do_sys_newfstat+0xb5/0xc0
[   51.302249]  ? do_syscall_64+0xf7/0x2a0
[   51.302251]  ? syscall_return_slowpath+0x1d0/0x1d0
[   51.302254]  ? do_page_fault+0x8a/0x210
[   51.302256]  ? __do_page_fault+0x680/0x680
[   51.302258]  ? prepare_exit_to_usermode+0xe8/0x150
[   51.302260]  ? perf_trace_sys_enter+0x4b0/0x4b0
[   51.302263]  ? __put_user_4+0x1c/0x30
[   51.302266]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   51.302268] ---[ end trace c4dac6679ea26e8c ]---
[   51.302278] [drm] DM_PPLIB: values for Invalid clock
[   51.302279] [drm] DM_PPLIB:	 300000 in kHz
[   51.302280] [drm] DM_PPLIB:	 600000 in kHz
[   51.302281] [drm] DM_PPLIB:	 626000 in kHz
[   51.302281] [drm] DM_PPLIB:	 654000 in kHz
[   51.306127] [drm] Display Core initialized with v3.1.55!
[   51.331163] [drm] SADs count is: -524, don't need to read it
[   51.332057] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   51.332058] [drm] Driver supports precise vblank timestamp query.
[   51.355673] [drm] VCN decode and encode initialized successfully.
[   51.357729] [drm] fb mappable at 0xA1100000
[   51.357731] [drm] vram apper at 0xA0000000
[   51.357732] [drm] size 8294400
[   51.357733] [drm] fb depth is 24
[   51.357734] [drm]    pitch is 7680
[   51.357870] fbcon: amdgpudrmfb (fb0) is primary device
[   51.422092] Console: switching to colour frame buffer device 240x67
[   51.436962] amdgpu 0000:06:00.0: fb0: amdgpudrmfb frame buffer device
[   51.446048] amdgpu 0000:06:00.0: ring 0(gfx) uses VM inv eng 4 on hub 0
[   51.446051] amdgpu 0000:06:00.0: ring 1(comp_1.0.0) uses VM inv eng 5 on hub 0
[   51.446053] amdgpu 0000:06:00.0: ring 2(comp_1.1.0) uses VM inv eng 6 on hub 0
[   51.446055] amdgpu 0000:06:00.0: ring 3(comp_1.2.0) uses VM inv eng 7 on hub 0
[   51.446057] amdgpu 0000:06:00.0: ring 4(comp_1.3.0) uses VM inv eng 8 on hub 0
[   51.446059] amdgpu 0000:06:00.0: ring 5(comp_1.0.1) uses VM inv eng 9 on hub 0
[   51.446061] amdgpu 0000:06:00.0: ring 6(comp_1.1.1) uses VM inv eng 10 on hub 0
[   51.446063] amdgpu 0000:06:00.0: ring 7(comp_1.2.1) uses VM inv eng 11 on hub 0
[   51.446065] amdgpu 0000:06:00.0: ring 8(comp_1.3.1) uses VM inv eng 12 on hub 0
[   51.446068] amdgpu 0000:06:00.0: ring 9(kiq_2.1.0) uses VM inv eng 13 on hub 0
[   51.446070] amdgpu 0000:06:00.0: ring 10(sdma0) uses VM inv eng 4 on hub 1
[   51.446072] amdgpu 0000:06:00.0: ring 11(vcn_dec) uses VM inv eng 5 on hub 1
[   51.446074] amdgpu 0000:06:00.0: ring 12(vcn_enc0) uses VM inv eng 6 on hub 1
[   51.446076] amdgpu 0000:06:00.0: ring 13(vcn_enc1) uses VM inv eng 7 on hub 1
[   51.446078] amdgpu 0000:06:00.0: ring 14(vcn_jpeg) uses VM inv eng 8 on hub 1
[   51.899237] [drm] Initialized amdgpu 3.27.0 20150101 for 0000:06:00.0 on minor 0
[   51.899923] modprobe (3753) used greatest stack depth: 16472 bytes left
[   54.426516] WARNING: CPU: 5 PID: 2443 at drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:92 amdgpu_ttm_bo_destroy+0x386/0x3a0 [amdgpu]
[   54.426519] Modules linked in: amdkfd amdgpu mfd_core chash gpu_sched ttm ax88179_178a usbnet
[   54.426539] CPU: 5 PID: 2443 Comm: kworker/5:2 Tainted: G        W         4.18.0-rc1+ #5
[   54.426542] Hardware name: System manufacturer System Product Name/TUF B350M-PLUS GAMING, BIOS 4011 04/19/2018
[   54.426559] Workqueue: events ttm_bo_delayed_workqueue [ttm]
[   54.426742] RIP: 0010:amdgpu_ttm_bo_destroy+0x386/0x3a0 [amdgpu]
[   54.426743] Code: 5c 41 5d 41 5e 41 5f c3 4c 89 ef e8 84 81 b3 d2 48 c7 83 70 03 00 00 00 00 00 00 e9 17 fe ff ff 4c 8d 64 24 40 e9 0d fe ff ff <0f> 0b 4c 89 ff e8 a0 fb ff ff e9 25 fd ff ff e8 e6 7c 87 d2 66 0f 
[   54.426806] RSP: 0018:ffff8801cc207100 EFLAGS: 00010202
[   54.426811] RAX: 0000000000000001 RBX: ffff8801db015558 RCX: ffffffffc022ab8c
[   54.426814] RDX: 0000000000000003 RSI: dffffc0000000000 RDI: ffff8801db0157a8
[   54.426817] RBP: 1ffff10039840e24 R08: 0000000000000000 R09: ffff8801cc206f70
[   54.426820] R10: ffffed0039840df8 R11: ffff8801cc206fc7 R12: 0000000000000000
[   54.426823] R13: ffff8801db015558 R14: ffff8801db015610 R15: ffff8801db015500
[   54.426826] FS:  0000000000000000(0000) GS:ffff8801e0140000(0000) knlGS:0000000000000000
[   54.426829] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   54.426832] CR2: 00007fb33bf7a0a0 CR3: 00000001d645c000 CR4: 00000000003406e0
[   54.426834] Call Trace:
[   54.427017]  ? amdgpu_bo_subtract_pin_size+0xd0/0xd0 [amdgpu]
[   54.427024]  ? update_nohz_stats+0x70/0x140
[   54.427032]  ? mutex_unlock+0x18/0x40
[   54.427047]  ? ttm_bo_cleanup_refs+0x5be/0x630 [ttm]
[   54.427062]  ? ttm_bo_put+0x20/0x20 [ttm]
[   54.427069]  ? __kasan_slab_free+0x13a/0x170
[   54.427084]  ? ttm_bo_release_list+0x3d2/0x480 [ttm]
[   54.427099]  ? ttm_bo_add_move_fence.isra.20+0x170/0x170 [ttm]
[   54.427103]  ? plist_requeue+0x260/0x260
[   54.427108]  ? __kmalloc+0x104/0x1f0
[   54.427113]  ? get_nohz_timer_target+0xd2/0x390
[   54.427117]  ? resched_cpu+0x70/0x70
[   54.427123]  ? detach_if_pending+0x85/0x240
[   54.427127]  ? init_timer_key+0x160/0x160
[   54.427132]  ? __internal_add_timer+0x10e/0x160
[   54.427136]  ? mutex_trylock+0xed/0x120
[   54.427140]  ? ww_mutex_unlock+0x40/0x40
[   54.427154]  ? ttm_bo_delayed_delete+0x25c/0x5e0 [ttm]
[   54.427168]  ? ttm_bo_cleanup_refs+0x630/0x630 [ttm]
[   54.427172]  ? _raw_spin_lock+0xe/0x30
[   54.427177]  ? devkmsg_read+0x570/0x570
[   54.427183]  ? soft_cursor+0x319/0x420
[   54.427189]  ? rcu_rnp_online_cpus+0xa0/0xa0
[   54.427193]  ? __update_idle_core+0x127/0x280
[   54.427197]  ? finish_task_switch+0x217/0x4e0
[   54.427201]  ? set_load_weight+0x100/0x100
[   54.427206]  ? read_word_at_a_time+0xe/0x20
[   54.427210]  ? strscpy+0x14b/0x280
[   54.427215]  ? read_word_at_a_time+0x20/0x20
[   54.427229]  ? ttm_bo_delayed_workqueue+0x12/0x40 [ttm]
[   54.427233]  ? process_one_work+0x5a8/0x980
[   54.427238]  ? max_active_store+0xe0/0xe0
[   54.427242]  ? __sched_text_start+0x8/0x8
[   54.427247]  ? sched_clock_cpu+0x18/0x110
[   54.427250]  ? _raw_spin_lock+0xe/0x30
[   54.427254]  ? pick_next_task_fair+0x6a9/0xb20
[   54.427259]  ? run_rebalance_domains+0x250/0x250
[   54.427265]  ? schedule+0xca/0x240
[   54.427270]  ? worker_enter_idle+0x217/0x330
[   54.427274]  ? __schedule+0xd50/0xd50
[   54.427279]  ? mutex_lock+0xa1/0x100
[   54.427283]  ? __mutex_lock_slowpath+0x10/0x10
[   54.427287]  ? __update_idle_core+0x127/0x280
[   54.427291]  ? cpu_load_update_active+0x190/0x190
[   54.427295]  ? worker_thread+0x17c/0xa70
[   54.427300]  ? process_one_work+0x980/0x980
[   54.427305]  ? __schedule+0x528/0xd50
[   54.427309]  ? migrate_swap_stop+0x430/0x430
[   54.427314]  ? __sched_text_start+0x8/0x8
[   54.427318]  ? save_stack+0x8c/0xb0
[   54.427326]  ? schedule+0xca/0x240
[   54.427330]  ? __schedule+0xd50/0xd50
[   54.427335]  ? remove_wait_queue+0x150/0x150
[   54.427339]  ? rcu_note_context_switch+0x2a0/0x2a0
[   54.427343]  ? kasan_unpoison_shadow+0x30/0x40
[   54.427348]  ? __kthread_parkme+0xc7/0x100
[   54.427352]  ? parse_args.cold.17+0x146/0x146
[   54.427357]  ? process_one_work+0x980/0x980
[   54.427360]  ? kthread+0x19b/0x1c0
[   54.427365]  ? kthread_create_worker_on_cpu+0xc0/0xc0
[   54.427369]  ? ret_from_fork+0x22/0x40
[   54.427373] ---[ end trace c4dac6679ea26e8d ]---

--------------DAAE2C6C495871B1978171DC
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------DAAE2C6C495871B1978171DC--
