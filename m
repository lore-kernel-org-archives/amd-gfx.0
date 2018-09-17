From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: ttm crash on init
Date: Mon, 17 Sep 2018 12:21:41 -0400
Message-ID: <e0b33ce8-2d9a-919c-8060-ce97a37c29d9@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------FEEA2C1716226EFA7C672103"
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
To: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--------------FEEA2C1716226EFA7C672103
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

(attached).  I'll try to bisect in a second.  Is anyone aware of this?

Tom

--------------FEEA2C1716226EFA7C672103
Content-Type: text/x-log;
 name="ttm_dmesg.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ttm_dmesg.log"

[    0.000000] Linux version 4.19.0-rc1+ (root@raven) (gcc version 8.1.1 20180712 (Red Hat 8.1.1-5) (GCC)) #29 SMP Fri Sep 14 07:30:30 EDT 2018
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-4.19.0-rc1+ root=UUID=66163c80-0ca1-4beb-aeba-5cc130b813e6 ro rhgb quiet modprobe.blacklist=amdgpu,radeon LANG=en_CA.UTF-8
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
[    0.000000] BIOS-e820: [mem 0x000000000b020000-0x0000000073963fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000073964000-0x000000007397cfff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000007397d000-0x000000007a5aafff] usable
[    0.000000] BIOS-e820: [mem 0x000000007a5ab000-0x000000007a6c2fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007a6c3000-0x000000007a6cefff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000007a6cf000-0x000000007a7d1fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007a7d2000-0x000000007ab89fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000007ab8a000-0x000000007b942fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007b943000-0x000000007dffffff] usable
[    0.000000] BIOS-e820: [mem 0x000000007e000000-0x00000000bfffffff] reserved
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
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000023f33ffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 3.1.1 present.
[    0.000000] DMI: System manufacturer System Product Name/TUF B350M-PLUS GAMING, BIOS 4011 04/19/2018
[    0.000000] tsc: Fast TSC calibration failed
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] last_pfn = 0x23f340 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF write-through
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000000 mask FFFF80000000 write-back
[    0.000000]   1 base 000080000000 mask FFFFC0000000 write-back
[    0.000000]   2 disabled
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] TOM2: 0000000240000000 aka 9216M
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000000] e820: update [mem 0xc0000000-0xffffffff] usable ==> reserved
[    0.000000] last_pfn = 0x7e000 max_arch_pfn = 0x400000000
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] Base memory trampoline at [(____ptrval____)] 97000 size 24576
[    0.000000] BRK [0x1f83bb000, 0x1f83bbfff] PGTABLE
[    0.000000] BRK [0x1f83bc000, 0x1f83bcfff] PGTABLE
[    0.000000] BRK [0x1f83bd000, 0x1f83bdfff] PGTABLE
[    0.000000] BRK [0x1f83be000, 0x1f83befff] PGTABLE
[    0.000000] BRK [0x1f83bf000, 0x1f83bffff] PGTABLE
[    0.000000] BRK [0x1f83c0000, 0x1f83c0fff] PGTABLE
[    0.000000] BRK [0x1f83c1000, 0x1f83c1fff] PGTABLE
[    0.000000] BRK [0x1f83c2000, 0x1f83c2fff] PGTABLE
[    0.000000] BRK [0x1f83c3000, 0x1f83c3fff] PGTABLE
[    0.000000] BRK [0x1f83c4000, 0x1f83c4fff] PGTABLE
[    0.000000] BRK [0x1f83c5000, 0x1f83c5fff] PGTABLE
[    0.000000] BRK [0x1f83c6000, 0x1f83c6fff] PGTABLE
[    0.000000] RAMDISK: [mem 0x345c7000-0x362dbfff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F05B0 000024 (v02 ALASKA)
[    0.000000] ACPI: XSDT 0x00000000739640A0 0000BC (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FACP 0x000000007396E9C8 000114 (v06 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI BIOS Warning (bug): Optional FADT field Pm2ControlBlock has valid Length but zero Address: 0x0000000000000000/0x1 (20180810/tbfadt-624)
[    0.000000] ACPI: DSDT 0x00000000739641F8 00A7C9 (v02 ALASKA A M I    01072009 INTL 20120913)
[    0.000000] ACPI: FACS 0x000000007AB73E00 000040
[    0.000000] ACPI: APIC 0x000000007396EAE0 0000DE (v03 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FPDT 0x000000007396EBC0 000044 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FIDT 0x000000007396EC08 00009C (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: SSDT 0x000000007397B510 001A41 (v01 AMD    AmdTable 00000001 INTL 20120913)
[    0.000000] ACPI: SSDT 0x000000007396ED00 005367 (v02 AMD    AmdTable 00000002 MSFT 02000002)
[    0.000000] ACPI: SSDT 0x0000000073974068 00119C (v01 AMD    AMD CPU  00000001 AMD  00000001)
[    0.000000] ACPI: CRAT 0x0000000073975208 000810 (v01 AMD    AMD CRAT 00000001 AMD  00000001)
[    0.000000] ACPI: CDIT 0x0000000073975A18 000029 (v01 AMD    AMD CDIT 00000001 AMD  00000001)
[    0.000000] ACPI: SSDT 0x0000000073975A48 002DA8 (v01 AMD    AMD AOD  00000001 INTL 20120913)
[    0.000000] ACPI: MCFG 0x00000000739787F0 00003C (v01 ALASKA A M I    01072009 MSFT 00010013)
[    0.000000] ACPI: HPET 0x0000000073978830 000038 (v01 ALASKA A M I    01072009 AMI  00000005)
[    0.000000] ACPI: UEFI 0x0000000073978868 000042 (v01                 00000000      00000000)
[    0.000000] ACPI: IVRS 0x00000000739788B0 0000D0 (v02 AMD    AMD IVRS 00000001 AMD  00000000)
[    0.000000] ACPI: SSDT 0x0000000073978980 0000F8 (v01 AMD    AMD PT   00001000 INTL 20120913)
[    0.000000] ACPI: SSDT 0x0000000073978A78 000E96 (v01 AMD    AmdTable 00000001 INTL 20120913)
[    0.000000] ACPI: SSDT 0x0000000073979910 000850 (v01 AMD    AmdTable 00000001 INTL 20120913)
[    0.000000] ACPI: SSDT 0x000000007397A160 000B5E (v01 AMD    AmdTable 00000001 INTL 20120913)
[    0.000000] ACPI: SSDT 0x000000007397ACC0 000850 (v01 AMD    AmdTable 00000001 INTL 20120913)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000023f33ffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x23f33c000-0x23f33ffff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000023f33ffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009cfff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x0000000003ffffff]
[    0.000000]   node   0: [mem 0x000000000400a000-0x0000000009bfffff]
[    0.000000]   node   0: [mem 0x000000000a000000-0x000000000affffff]
[    0.000000]   node   0: [mem 0x000000000b020000-0x0000000073963fff]
[    0.000000]   node   0: [mem 0x000000007397d000-0x000000007a5aafff]
[    0.000000]   node   0: [mem 0x000000007a6cf000-0x000000007a7d1fff]
[    0.000000]   node   0: [mem 0x000000007b943000-0x000000007dffffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000023f33ffff]
[    0.000000] Reserved but unavailable: 14140 pages
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000023f33ffff]
[    0.000000] On node 0 totalpages: 1817604
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 21 pages reserved
[    0.000000]   DMA zone: 3996 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 7909 pages used for memmap
[    0.000000]   DMA32 zone: 506152 pages, LIFO batch:63
[    0.000000]   Normal zone: 20429 pages used for memmap
[    0.000000]   Normal zone: 1307456 pages, LIFO batch:63
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
[    0.000000] PM: Registered nosave memory: [mem 0x73964000-0x7397cfff]
[    0.000000] PM: Registered nosave memory: [mem 0x7a5ab000-0x7a6c2fff]
[    0.000000] PM: Registered nosave memory: [mem 0x7a6c3000-0x7a6cefff]
[    0.000000] PM: Registered nosave memory: [mem 0x7a7d2000-0x7ab89fff]
[    0.000000] PM: Registered nosave memory: [mem 0x7ab8a000-0x7b942fff]
[    0.000000] PM: Registered nosave memory: [mem 0x7e000000-0xbfffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xc0000000-0xf7ffffff]
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
[    0.000000] [mem 0xc0000000-0xf7ffffff] available for PCI devices
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.000000] random: get_random_bytes called from start_kernel+0xf1/0x762 with crng_init=0
[    0.000000] setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:16 nr_node_ids:1
[    0.000000] percpu: Embedded 54 pages/cpu @(____ptrval____) s181064 r8192 d31928 u262144
[    0.000000] pcpu-alloc: s181064 r8192 d31928 u262144 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 12 13 14 15 
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 1789181
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-4.19.0-rc1+ root=UUID=66163c80-0ca1-4beb-aeba-5cc130b813e6 ro rhgb quiet modprobe.blacklist=amdgpu,radeon LANG=en_CA.UTF-8
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Memory: 6033232K/7270416K available (40972K kernel code, 5626K rwdata, 6712K rodata, 1828K init, 21012K bss, 1237184K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=16, Nodes=1
[    0.000000] Running RCU self tests
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu: 	RCU event tracing is enabled.
[    0.000000] rcu: 	RCU lockdep checking is enabled.
[    0.000000] rcu: 	RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=16.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=16
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
[    0.000000] ACPI: Core revision 20180810
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
[    0.000000] hpet clockevent registered
[    0.000000] APIC: Switch to symmetric I/O mode setup
[    0.000000] Switched APIC routing to physical flat.
[    0.000000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.006000] tsc: PIT calibration matches HPET. 1 loops
[    0.006000] tsc: Detected 3593.301 MHz processor
[    0.000022] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x33cb9b557df, max_idle_ns: 440795366497 ns
[    0.000037] Calibrating delay loop (skipped), value calculated using timer frequency.. 7186.60 BogoMIPS (lpj=3593301)
[    0.000041] pid_max: default: 32768 minimum: 301
[    0.000140] Security Framework initialized
[    0.000144] SELinux:  Initializing.
[    0.002987] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.004865] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.004951] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.005006] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.006046] mce: CPU supports 23 MCE banks
[    0.006088] LVT offset 1 assigned for vector 0xf9
[    0.006150] LVT offset 2 assigned for vector 0xf4
[    0.006160] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 512
[    0.006162] Last level dTLB entries: 4KB 1536, 2MB 1536, 4MB 768, 1GB 0
[    0.006165] Spectre V2 : Mitigation: Full AMD retpoline
[    0.006167] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.006168] Spectre V2 : Spectre v2 mitigation: Enabling Indirect Branch Prediction Barrier
[    0.006171] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
[    0.006461] debug: unmapping init [mem 0xffffffff94d2b000-0xffffffff94d33fff]
[    0.009028] smpboot: CPU0: AMD Ryzen 5 2400G with Radeon Vega Graphics (family: 0x17, model: 0x11, stepping: 0x0)
[    0.009028] Performance Events: Fam17h core perfctr, AMD PMU driver.
[    0.009028] ... version:                0
[    0.009028] ... bit width:              48
[    0.009028] ... generic registers:      6
[    0.009028] ... value mask:             0000ffffffffffff
[    0.009028] ... max period:             00007fffffffffff
[    0.009028] ... fixed-purpose events:   0
[    0.009028] ... event mask:             000000000000003f
[    0.009028] rcu: Hierarchical SRCU implementation.
[    0.011042] MCE: In-kernel MCE decoding enabled.
[    0.011340] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.012255] smp: Bringing up secondary CPUs ...
[    0.012841] x86: Booting SMP configuration:
[    0.012848] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7
[    0.026209] smp: Brought up 1 node, 8 CPUs
[    0.026209] smpboot: Max logical packages: 2
[    0.026209] smpboot: Total of 8 processors activated (57492.81 BogoMIPS)
[    0.029201] devtmpfs: initialized
[    0.032429] PM: Registering ACPI NVS region [mem 0x04000000-0x04009fff] (40960 bytes)
[    0.032429] PM: Registering ACPI NVS region [mem 0x7a7d2000-0x7ab89fff] (3899392 bytes)
[    0.035616] kworker/u32:0 (53) used greatest stack depth: 21040 bytes left
[    0.036122] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.036159] futex hash table entries: 4096 (order: 7, 524288 bytes)
[    0.037780] RTC time: 16:13:31, date: 09/17/18
[    0.038639] NET: Registered protocol family 16
[    0.039433] audit: initializing netlink subsys (disabled)
[    0.039485] audit: type=2000 audit(1537200811.045:1): state=initialized audit_enabled=0 res=1
[    0.040699] cpuidle: using governor menu
[    0.041184] ACPI: bus type PCI registered
[    0.041547] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.041553] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
[    0.041586] PCI: Using configuration type 1 for base access
[    0.043062] mtrr: your CPUs had inconsistent variable MTRR settings
[    0.043064] mtrr: probably your BIOS does not setup all CPUs.
[    0.043066] mtrr: corrected configuration.
[    0.070421] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.072117] ACPI: Added _OSI(Module Device)
[    0.072117] ACPI: Added _OSI(Processor Device)
[    0.072117] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.072117] ACPI: Added _OSI(Processor Aggregator Device)
[    0.072117] ACPI: Added _OSI(Linux-Dell-Video)
[    0.072117] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.247723] ACPI BIOS Error (bug): Failure creating [\_SB.SMIC], AE_ALREADY_EXISTS (20180810/dswload2-316)
[    0.248037] ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20180810/psobject-221)
[    0.248367] ACPI BIOS Error (bug): Failure creating [\_SB.SMIB], AE_ALREADY_EXISTS (20180810/dsfield-626)
[    0.255495] ACPI BIOS Error (bug): Failure creating [\_SB.MACO], AE_ALREADY_EXISTS (20180810/dswload2-316)
[    0.255860] ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20180810/psobject-221)
[    0.256800] ACPI: 10 ACPI AML tables successfully acquired and loaded
[    0.283302] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.318040] ACPI: Interpreter enabled
[    0.318172] ACPI: (supports S0 S3 S4 S5)
[    0.318176] ACPI: Using IOAPIC for interrupt routing
[    0.321519] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.325875] ACPI: Enabled 3 GPEs in block 00 to 1F
[    0.379150] ACPI: Power Resource [P0ST] (on)
[    0.379667] ACPI: Power Resource [P3ST] (on)
[    0.480363] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.480387] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.484186] acpi PNP0A08:00: _OSC: platform does not support [PME LTR]
[    0.487828] acpi PNP0A08:00: _OSC: OS now controls [AER PCIeCapability]
[    0.487960] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000 [bus 00-3f] only partially covers this bridge
[    0.492257] PCI host bridge to bus 0000:00
[    0.492266] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    0.492273] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    0.492280] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
[    0.492287] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.492294] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.492301] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff window]
[    0.492307] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfec2ffff window]
[    0.492314] pci_bus 0000:00: root bus resource [mem 0xfee00000-0xffffffff window]
[    0.492324] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.492367] pci 0000:00:00.0: [1022:15d0] type 00 class 0x060000
[    0.493498] pci 0000:00:00.2: [1022:15d1] type 00 class 0x080600
[    0.494533] pci 0000:00:01.0: [1022:1452] type 00 class 0x060000
[    0.495396] pci 0000:00:01.1: [1022:15d3] type 01 class 0x060400
[    0.495581] pci 0000:00:01.1: PME# supported from D0 D3hot D3cold
[    0.496611] pci 0000:00:01.2: [1022:15d3] type 01 class 0x060400
[    0.496794] pci 0000:00:01.2: PME# supported from D0 D3hot D3cold
[    0.497804] pci 0000:00:08.0: [1022:1452] type 00 class 0x060000
[    0.498661] pci 0000:00:08.1: [1022:15db] type 01 class 0x060400
[    0.498738] pci 0000:00:08.1: enabling Extended Tags
[    0.498845] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
[    0.499802] pci 0000:00:08.2: [1022:15dc] type 01 class 0x060400
[    0.499878] pci 0000:00:08.2: enabling Extended Tags
[    0.499987] pci 0000:00:08.2: PME# supported from D0 D3hot D3cold
[    0.501038] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500
[    0.502096] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100
[    0.503202] pci 0000:00:18.0: [1022:15e8] type 00 class 0x060000
[    0.504033] pci 0000:00:18.1: [1022:15e9] type 00 class 0x060000
[    0.504768] pci 0000:00:18.2: [1022:15ea] type 00 class 0x060000
[    0.505554] pci 0000:00:18.3: [1022:15eb] type 00 class 0x060000
[    0.506360] pci 0000:00:18.4: [1022:15ec] type 00 class 0x060000
[    0.507149] pci 0000:00:18.5: [1022:15ed] type 00 class 0x060000
[    0.508033] pci 0000:00:18.6: [1022:15ee] type 00 class 0x060000
[    0.508726] pci 0000:00:18.7: [1022:15ef] type 00 class 0x060000
[    0.509729] pci 0000:01:00.0: [1002:67c4] type 00 class 0x030000
[    0.509783] pci 0000:01:00.0: reg 0x10: [mem 0xe0000000-0xefffffff 64bit pref]
[    0.509801] pci 0000:01:00.0: reg 0x18: [mem 0xf0000000-0xf01fffff 64bit pref]
[    0.509812] pci 0000:01:00.0: reg 0x20: [io  0xf000-0xf0ff]
[    0.509823] pci 0000:01:00.0: reg 0x24: [mem 0xfe900000-0xfe93ffff]
[    0.509835] pci 0000:01:00.0: reg 0x30: [mem 0xfe940000-0xfe95ffff pref]
[    0.510054] pci 0000:01:00.0: supports D1 D2
[    0.510056] pci 0000:01:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.510137] pci 0000:01:00.0: 63.008 Gb/s available PCIe bandwidth, limited by 8 GT/s x8 link at 0000:00:01.1 (capable of 126.016 Gb/s with 8 GT/s x16 link)
[    0.510700] pci 0000:01:00.1: [1002:aaf0] type 00 class 0x040300
[    0.510745] pci 0000:01:00.1: reg 0x10: [mem 0xfe960000-0xfe963fff 64bit]
[    0.510982] pci 0000:01:00.1: supports D1 D2
[    0.511617] pci 0000:00:01.1: PCI bridge to [bus 01]
[    0.511625] pci 0000:00:01.1:   bridge window [io  0xf000-0xffff]
[    0.511630] pci 0000:00:01.1:   bridge window [mem 0xfe900000-0xfe9fffff]
[    0.511638] pci 0000:00:01.1:   bridge window [mem 0xe0000000-0xf01fffff 64bit pref]
[    0.511830] pci 0000:02:00.0: [1022:43bb] type 00 class 0x0c0330
[    0.511867] pci 0000:02:00.0: reg 0x10: [mem 0xfe7a0000-0xfe7a7fff 64bit]
[    0.512088] pci 0000:02:00.0: PME# supported from D3hot D3cold
[    0.512638] pci 0000:02:00.1: [1022:43b7] type 00 class 0x010601
[    0.512718] pci 0000:02:00.1: reg 0x24: [mem 0xfe780000-0xfe79ffff]
[    0.512731] pci 0000:02:00.1: reg 0x30: [mem 0xfe700000-0xfe77ffff pref]
[    0.512873] pci 0000:02:00.1: PME# supported from D3hot D3cold
[    0.513413] pci 0000:02:00.2: [1022:43b2] type 01 class 0x060400
[    0.513614] pci 0000:02:00.2: PME# supported from D3hot D3cold
[    0.514239] pci 0000:00:01.2: PCI bridge to [bus 02-06]
[    0.514248] pci 0000:00:01.2:   bridge window [io  0xe000-0xefff]
[    0.514253] pci 0000:00:01.2:   bridge window [mem 0xfe600000-0xfe7fffff]
[    0.514460] pci 0000:03:00.0: [1022:43b4] type 01 class 0x060400
[    0.514724] pci 0000:03:00.0: PME# supported from D3hot D3cold
[    0.515494] pci 0000:03:01.0: [1022:43b4] type 01 class 0x060400
[    0.515753] pci 0000:03:01.0: PME# supported from D3hot D3cold
[    0.516487] pci 0000:03:04.0: [1022:43b4] type 01 class 0x060400
[    0.516747] pci 0000:03:04.0: PME# supported from D3hot D3cold
[    0.517500] pci 0000:02:00.2: PCI bridge to [bus 03-06]
[    0.517509] pci 0000:02:00.2:   bridge window [io  0xe000-0xefff]
[    0.517515] pci 0000:02:00.2:   bridge window [mem 0xfe600000-0xfe6fffff]
[    0.517742] pci 0000:04:00.0: [10ec:8168] type 00 class 0x020000
[    0.517797] pci 0000:04:00.0: reg 0x10: [io  0xe000-0xe0ff]
[    0.517845] pci 0000:04:00.0: reg 0x18: [mem 0xfe604000-0xfe604fff 64bit]
[    0.517875] pci 0000:04:00.0: reg 0x20: [mem 0xfe600000-0xfe603fff 64bit]
[    0.518228] pci 0000:04:00.0: supports D1 D2
[    0.518231] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.518878] pci 0000:03:00.0: PCI bridge to [bus 04]
[    0.518888] pci 0000:03:00.0:   bridge window [io  0xe000-0xefff]
[    0.518893] pci 0000:03:00.0:   bridge window [mem 0xfe600000-0xfe6fffff]
[    0.519096] pci 0000:03:01.0: PCI bridge to [bus 05]
[    0.519268] pci 0000:03:04.0: PCI bridge to [bus 06]
[    0.519504] pci 0000:07:00.0: [1002:15dd] type 00 class 0x030000
[    0.519559] pci 0000:07:00.0: reg 0x10: [mem 0xc0000000-0xcfffffff 64bit pref]
[    0.519581] pci 0000:07:00.0: reg 0x18: [mem 0xd0000000-0xd01fffff 64bit pref]
[    0.519597] pci 0000:07:00.0: reg 0x20: [io  0xd000-0xd0ff]
[    0.519612] pci 0000:07:00.0: reg 0x24: [mem 0xfe500000-0xfe57ffff]
[    0.519637] pci 0000:07:00.0: enabling Extended Tags
[    0.519842] pci 0000:07:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.520571] pci 0000:07:00.1: [1002:15de] type 00 class 0x040300
[    0.520607] pci 0000:07:00.1: reg 0x10: [mem 0xfe588000-0xfe58bfff]
[    0.520694] pci 0000:07:00.1: enabling Extended Tags
[    0.520861] pci 0000:07:00.1: PME# supported from D1 D2 D3hot D3cold
[    0.521540] pci 0000:07:00.2: [1022:15df] type 00 class 0x108000
[    0.521601] pci 0000:07:00.2: reg 0x18: [mem 0xfe400000-0xfe4fffff]
[    0.521641] pci 0000:07:00.2: reg 0x24: [mem 0xfe58c000-0xfe58dfff]
[    0.521665] pci 0000:07:00.2: enabling Extended Tags
[    0.522473] pci 0000:07:00.3: [1022:15e0] type 00 class 0x0c0330
[    0.522516] pci 0000:07:00.3: reg 0x10: [mem 0xfe300000-0xfe3fffff 64bit]
[    0.522589] pci 0000:07:00.3: enabling Extended Tags
[    0.522763] pci 0000:07:00.3: PME# supported from D0 D3hot D3cold
[    0.523454] pci 0000:07:00.4: [1022:15e1] type 00 class 0x0c0330
[    0.523497] pci 0000:07:00.4: reg 0x10: [mem 0xfe200000-0xfe2fffff 64bit]
[    0.523571] pci 0000:07:00.4: enabling Extended Tags
[    0.523742] pci 0000:07:00.4: PME# supported from D0 D3hot D3cold
[    0.524433] pci 0000:07:00.6: [1022:15e3] type 00 class 0x040300
[    0.524469] pci 0000:07:00.6: reg 0x10: [mem 0xfe580000-0xfe587fff]
[    0.524555] pci 0000:07:00.6: enabling Extended Tags
[    0.524719] pci 0000:07:00.6: PME# supported from D0 D3hot D3cold
[    0.525492] pci 0000:00:08.1: PCI bridge to [bus 07]
[    0.525502] pci 0000:00:08.1:   bridge window [io  0xd000-0xdfff]
[    0.525508] pci 0000:00:08.1:   bridge window [mem 0xfe200000-0xfe5fffff]
[    0.525516] pci 0000:00:08.1:   bridge window [mem 0xc0000000-0xd01fffff 64bit pref]
[    0.525708] pci 0000:08:00.0: [1022:7901] type 00 class 0x010601
[    0.525807] pci 0000:08:00.0: reg 0x24: [mem 0xfe800000-0xfe8007ff]
[    0.525831] pci 0000:08:00.0: enabling Extended Tags
[    0.526005] pci 0000:08:00.0: PME# supported from D3hot D3cold
[    0.526649] pci 0000:00:08.2: PCI bridge to [bus 08]
[    0.526661] pci 0000:00:08.2:   bridge window [mem 0xfe800000-0xfe8fffff]
[    0.534129] ACPI: PCI Interrupt Link [LNKA] (IRQs 4 5 7 10 11 14 15) *0
[    0.534987] ACPI: PCI Interrupt Link [LNKB] (IRQs 4 5 7 10 11 14 15) *0
[    0.535774] ACPI: PCI Interrupt Link [LNKC] (IRQs 4 5 7 10 11 14 15) *0
[    0.536678] ACPI: PCI Interrupt Link [LNKD] (IRQs 4 5 7 10 11 14 15) *0
[    0.537526] ACPI: PCI Interrupt Link [LNKE] (IRQs 4 5 7 10 11 14 15) *0
[    0.538258] ACPI: PCI Interrupt Link [LNKF] (IRQs 4 5 7 10 11 14 15) *0
[    0.538971] ACPI: PCI Interrupt Link [LNKG] (IRQs 4 5 7 10 11 14 15) *0
[    0.539698] ACPI: PCI Interrupt Link [LNKH] (IRQs 4 5 7 10 11 14 15) *0
[    0.547285] pci 0000:01:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
[    0.547285] pci 0000:07:00.0: vgaarb: setting as boot VGA device
[    0.547285] pci 0000:07:00.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.547285] pci 0000:07:00.0: vgaarb: bridge control possible
[    0.547285] pci 0000:01:00.0: vgaarb: bridge control possible
[    0.547285] vgaarb: loaded
[    0.548146] SCSI subsystem initialized
[    0.548433] libata version 3.00 loaded.
[    0.548483] ACPI: bus type USB registered
[    0.549142] usbcore: registered new interface driver usbfs
[    0.549142] usbcore: registered new interface driver hub
[    0.549247] usbcore: registered new device driver usb
[    0.549364] pps_core: LinuxPPS API ver. 1 registered
[    0.549366] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
[    0.549405] PTP clock support registered
[    0.549606] EDAC MC: Ver: 3.0.0
[    0.550419] Advanced Linux Sound Architecture Driver Initialized.
[    0.551112] PCI: Using ACPI for IRQ routing
[    0.555218] PCI: pci_cache_line_size set to 64 bytes
[    0.555347] e820: reserve RAM buffer [mem 0x0009d400-0x0009ffff]
[    0.555366] e820: reserve RAM buffer [mem 0x09c00000-0x0bffffff]
[    0.555373] e820: reserve RAM buffer [mem 0x0b000000-0x0bffffff]
[    0.555381] e820: reserve RAM buffer [mem 0x73964000-0x73ffffff]
[    0.555388] e820: reserve RAM buffer [mem 0x7a5ab000-0x7bffffff]
[    0.555395] e820: reserve RAM buffer [mem 0x7a7d2000-0x7bffffff]
[    0.555402] e820: reserve RAM buffer [mem 0x7e000000-0x7fffffff]
[    0.555409] e820: reserve RAM buffer [mem 0x23f340000-0x23fffffff]
[    0.556652] NetLabel: Initializing
[    0.556654] NetLabel:  domain hash size = 128
[    0.556656] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.556783] NetLabel:  unlabeled traffic allowed by default
[    0.557279] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.557288] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.559283] clocksource: Switched to clocksource tsc-early
[    0.654183] VFS: Disk quotas dquot_6.6.0
[    0.654234] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.654685] pnp: PnP ACPI init
[    0.655706] system 00:00: [mem 0xf8000000-0xfbffffff] has been reserved
[    0.655817] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.656647] system 00:01: [mem 0xfeb80000-0xfebfffff] has been reserved
[    0.656697] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.658252] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.660272] system 00:03: [io  0x0300-0x030f] has been reserved
[    0.660295] system 00:03: [io  0x0230-0x023f] has been reserved
[    0.660316] system 00:03: [io  0x0290-0x029f] has been reserved
[    0.660353] system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.663919] pnp 00:04: [dma 0 disabled]
[    0.664207] pnp 00:04: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.666975] system 00:05: [io  0x04d0-0x04d1] has been reserved
[    0.666997] system 00:05: [io  0x040b] has been reserved
[    0.667017] system 00:05: [io  0x04d6] has been reserved
[    0.667032] system 00:05: [io  0x0c00-0x0c01] has been reserved
[    0.667045] system 00:05: [io  0x0c14] has been reserved
[    0.667058] system 00:05: [io  0x0c50-0x0c51] has been reserved
[    0.667071] system 00:05: [io  0x0c52] has been reserved
[    0.667084] system 00:05: [io  0x0c6c] has been reserved
[    0.667097] system 00:05: [io  0x0c6f] has been reserved
[    0.667110] system 00:05: [io  0x0cd0-0x0cd1] has been reserved
[    0.667123] system 00:05: [io  0x0cd2-0x0cd3] has been reserved
[    0.667136] system 00:05: [io  0x0cd4-0x0cd5] has been reserved
[    0.667149] system 00:05: [io  0x0cd6-0x0cd7] has been reserved
[    0.667161] system 00:05: [io  0x0cd8-0x0cdf] has been reserved
[    0.667174] system 00:05: [io  0x0800-0x089f] has been reserved
[    0.667187] system 00:05: [io  0x0b00-0x0b0f] has been reserved
[    0.667200] system 00:05: [io  0x0b20-0x0b3f] has been reserved
[    0.667213] system 00:05: [io  0x0900-0x090f] has been reserved
[    0.667226] system 00:05: [io  0x0910-0x091f] has been reserved
[    0.667249] system 00:05: [mem 0xfec00000-0xfec00fff] could not be reserved
[    0.667268] system 00:05: [mem 0xfec01000-0xfec01fff] could not be reserved
[    0.667281] system 00:05: [mem 0xfedc0000-0xfedc0fff] has been reserved
[    0.667294] system 00:05: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.667313] system 00:05: [mem 0xfed80000-0xfed8ffff] could not be reserved
[    0.667326] system 00:05: [mem 0xfec10000-0xfec10fff] has been reserved
[    0.667339] system 00:05: [mem 0xff000000-0xffffffff] has been reserved
[    0.667375] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.673460] pnp: PnP ACPI: found 6 devices
[    0.696382] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.696479] pci 0000:00:01.1: PCI bridge to [bus 01]
[    0.696484] pci 0000:00:01.1:   bridge window [io  0xf000-0xffff]
[    0.696492] pci 0000:00:01.1:   bridge window [mem 0xfe900000-0xfe9fffff]
[    0.696498] pci 0000:00:01.1:   bridge window [mem 0xe0000000-0xf01fffff 64bit pref]
[    0.696514] pci 0000:03:00.0: PCI bridge to [bus 04]
[    0.696519] pci 0000:03:00.0:   bridge window [io  0xe000-0xefff]
[    0.696526] pci 0000:03:00.0:   bridge window [mem 0xfe600000-0xfe6fffff]
[    0.696538] pci 0000:03:01.0: PCI bridge to [bus 05]
[    0.696554] pci 0000:03:04.0: PCI bridge to [bus 06]
[    0.696570] pci 0000:02:00.2: PCI bridge to [bus 03-06]
[    0.696574] pci 0000:02:00.2:   bridge window [io  0xe000-0xefff]
[    0.696580] pci 0000:02:00.2:   bridge window [mem 0xfe600000-0xfe6fffff]
[    0.696592] pci 0000:00:01.2: PCI bridge to [bus 02-06]
[    0.696595] pci 0000:00:01.2:   bridge window [io  0xe000-0xefff]
[    0.696602] pci 0000:00:01.2:   bridge window [mem 0xfe600000-0xfe7fffff]
[    0.696614] pci 0000:00:08.1: PCI bridge to [bus 07]
[    0.696617] pci 0000:00:08.1:   bridge window [io  0xd000-0xdfff]
[    0.696624] pci 0000:00:08.1:   bridge window [mem 0xfe200000-0xfe5fffff]
[    0.696629] pci 0000:00:08.1:   bridge window [mem 0xc0000000-0xd01fffff 64bit pref]
[    0.696638] pci 0000:00:08.2: PCI bridge to [bus 08]
[    0.696644] pci 0000:00:08.2:   bridge window [mem 0xfe800000-0xfe8fffff]
[    0.696657] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    0.696660] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
[    0.696662] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
[    0.696665] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    0.696668] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff window]
[    0.696671] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff window]
[    0.696673] pci_bus 0000:00: resource 10 [mem 0xc0000000-0xfec2ffff window]
[    0.696676] pci_bus 0000:00: resource 11 [mem 0xfee00000-0xffffffff window]
[    0.696679] pci_bus 0000:01: resource 0 [io  0xf000-0xffff]
[    0.696681] pci_bus 0000:01: resource 1 [mem 0xfe900000-0xfe9fffff]
[    0.696684] pci_bus 0000:01: resource 2 [mem 0xe0000000-0xf01fffff 64bit pref]
[    0.696686] pci_bus 0000:02: resource 0 [io  0xe000-0xefff]
[    0.696689] pci_bus 0000:02: resource 1 [mem 0xfe600000-0xfe7fffff]
[    0.696691] pci_bus 0000:03: resource 0 [io  0xe000-0xefff]
[    0.696694] pci_bus 0000:03: resource 1 [mem 0xfe600000-0xfe6fffff]
[    0.696696] pci_bus 0000:04: resource 0 [io  0xe000-0xefff]
[    0.696699] pci_bus 0000:04: resource 1 [mem 0xfe600000-0xfe6fffff]
[    0.696701] pci_bus 0000:07: resource 0 [io  0xd000-0xdfff]
[    0.696704] pci_bus 0000:07: resource 1 [mem 0xfe200000-0xfe5fffff]
[    0.696706] pci_bus 0000:07: resource 2 [mem 0xc0000000-0xd01fffff 64bit pref]
[    0.696709] pci_bus 0000:08: resource 1 [mem 0xfe800000-0xfe8fffff]
[    0.697654] NET: Registered protocol family 2
[    0.698597] tcp_listen_portaddr_hash hash table entries: 4096 (order: 6, 294912 bytes)
[    0.698805] TCP established hash table entries: 65536 (order: 7, 524288 bytes)
[    0.699729] TCP bind hash table entries: 65536 (order: 10, 4194304 bytes)
[    0.701182] TCP: Hash tables configured (established 65536 bind 65536)
[    0.701899] UDP hash table entries: 4096 (order: 7, 655360 bytes)
[    0.702233] UDP-Lite hash table entries: 4096 (order: 7, 655360 bytes)
[    0.703011] NET: Registered protocol family 1
[    0.703916] RPC: Registered named UNIX socket transport module.
[    0.703922] RPC: Registered udp transport module.
[    0.703924] RPC: Registered tcp transport module.
[    0.703926] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.704732] pci 0000:01:00.1: Linked as a consumer to 0000:01:00.0
[    0.706447] pci 0000:07:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.706486] pci 0000:07:00.1: Linked as a consumer to 0000:07:00.0
[    0.710421] PCI: CLS 64 bytes, default 64
[    0.710864] Unpacking initramfs...
[    1.391446] debug: unmapping init [mem 0xffff8800345c7000-0xffff8800362dbfff]
[    1.739907] AMD-Vi: Unable to write to IOMMU perf counter.
[    1.740856] pci 0000:00:00.2: can't derive routing for PCI INT A
[    1.740859] pci 0000:00:00.2: PCI INT A: not connected
[    1.743280] iommu: Adding device 0000:00:01.0 to group 0
[    1.744431] iommu: Adding device 0000:00:01.1 to group 1
[    1.745498] iommu: Adding device 0000:00:01.2 to group 2
[    1.746677] iommu: Adding device 0000:00:08.0 to group 3
[    1.747835] iommu: Adding device 0000:00:08.1 to group 4
[    1.747938] iommu: Adding device 0000:00:08.2 to group 3
[    1.749025] iommu: Adding device 0000:00:14.0 to group 5
[    1.749129] iommu: Adding device 0000:00:14.3 to group 5
[    1.750410] iommu: Adding device 0000:00:18.0 to group 6
[    1.750506] iommu: Adding device 0000:00:18.1 to group 6
[    1.750600] iommu: Adding device 0000:00:18.2 to group 6
[    1.750696] iommu: Adding device 0000:00:18.3 to group 6
[    1.750791] iommu: Adding device 0000:00:18.4 to group 6
[    1.750884] iommu: Adding device 0000:00:18.5 to group 6
[    1.750981] iommu: Adding device 0000:00:18.6 to group 6
[    1.751093] iommu: Adding device 0000:00:18.7 to group 6
[    1.752235] iommu: Adding device 0000:01:00.0 to group 7
[    1.752745] iommu: Using direct mapping for device 0000:01:00.0
[    1.752857] iommu: Adding device 0000:01:00.1 to group 7
[    1.753974] iommu: Adding device 0000:02:00.0 to group 8
[    1.754100] iommu: Adding device 0000:02:00.1 to group 8
[    1.754213] iommu: Adding device 0000:02:00.2 to group 8
[    1.754294] iommu: Adding device 0000:03:00.0 to group 8
[    1.754409] iommu: Adding device 0000:03:01.0 to group 8
[    1.754494] iommu: Adding device 0000:03:04.0 to group 8
[    1.754583] iommu: Adding device 0000:04:00.0 to group 8
[    1.755838] iommu: Adding device 0000:07:00.0 to group 9
[    1.756375] iommu: Using direct mapping for device 0000:07:00.0
[    1.757541] iommu: Adding device 0000:07:00.1 to group 10
[    1.757681] iommu: Adding device 0000:07:00.2 to group 10
[    1.757811] iommu: Adding device 0000:07:00.3 to group 10
[    1.757938] iommu: Adding device 0000:07:00.4 to group 10
[    1.758075] iommu: Adding device 0000:07:00.6 to group 10
[    1.758159] iommu: Adding device 0000:08:00.0 to group 3
[    1.758431] AMD-Vi: Found IOMMU at 0000:00:00.2 cap 0x40
[    1.758433] AMD-Vi: Extended features (0x4f77ef22294ada):
[    1.758435]  PPR NX GT IA GA PC GA_vAPIC
[    1.759084] AMD-Vi: Lazy IO/TLB flushing enabled
[    1.771536] amd_uncore: AMD NB counters detected
[    1.771548] amd_uncore: AMD LLC counters detected
[    1.778724] Scanning for low memory corruption every 60 seconds
[    1.784884] Initialise system trusted keyrings
[    1.785229] workingset: timestamp_bits=56 max_order=21 bucket_order=0
[    1.813206] NFS: Registering the id_resolver key type
[    1.813257] Key type id_resolver registered
[    1.813263] Key type id_legacy registered
[    1.818240] Key type asymmetric registered
[    1.818257] Asymmetric key parser 'x509' registered
[    1.818324] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
[    1.818355] io scheduler noop registered
[    1.818358] io scheduler deadline registered
[    1.818731] io scheduler cfq registered (default)
[    1.818735] io scheduler mq-deadline registered
[    1.818738] io scheduler kyber registered
[    1.825724] pcieport 0000:00:01.1: AER enabled with IRQ 26
[    1.825883] pcieport 0000:00:01.2: AER enabled with IRQ 27
[    1.826813] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    1.826899] ACPI: Power Button [PWRB]
[    1.827224] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    1.827363] ACPI: Power Button [PWRF]
[    1.828263] ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
[    1.830694] acpi device:03: registered as cooling_device0
[    1.831181] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:02/LNXVIDEO:00/input/input2
[    1.831662] Monitor-Mwait will be used to enter C-1 state
[    1.837529] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.858661] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    1.861708] Non-volatile memory driver v1.3
[    1.861883] Linux agpgart interface v0.103
[    1.887582] loop: module loaded
[    1.888540] ahci 0000:02:00.1: version 3.0
[    1.889330] ahci 0000:02:00.1: SSS flag set, parallel bus scan disabled
[    1.889387] ahci 0000:02:00.1: AHCI 0001.0301 32 slots 8 ports 6 Gbps 0x33 impl SATA mode
[    1.889392] ahci 0000:02:00.1: flags: 64bit ncq sntf stag pm led clo only pmp pio slum part sxs deso sadm sds apst 
[    1.896108] scsi host0: ahci
[    1.897323] scsi host1: ahci
[    1.898124] scsi host2: ahci
[    1.898949] scsi host3: ahci
[    1.899793] scsi host4: ahci
[    1.900608] scsi host5: ahci
[    1.901414] scsi host6: ahci
[    1.902093] scsi host7: ahci
[    1.902443] ata1: SATA max UDMA/133 abar m131072@0xfe780000 port 0xfe780100 irq 35
[    1.902447] ata2: SATA max UDMA/133 abar m131072@0xfe780000 port 0xfe780180 irq 35
[    1.902450] ata3: DUMMY
[    1.902452] ata4: DUMMY
[    1.902455] ata5: SATA max UDMA/133 abar m131072@0xfe780000 port 0xfe780300 irq 35
[    1.902459] ata6: SATA max UDMA/133 abar m131072@0xfe780000 port 0xfe780380 irq 35
[    1.902461] ata7: DUMMY
[    1.902462] ata8: DUMMY
[    1.903524] ahci 0000:08:00.0: AHCI 0001.0301 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
[    1.903529] ahci 0000:08:00.0: flags: 64bit ncq sntf ilck pm led clo only pmp fbs pio slum part 
[    1.904617] scsi host8: ahci
[    1.904978] ata9: SATA max UDMA/133 abar m2048@0xfe800000 port 0xfe800100 irq 37
[    1.906680] e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2-NAPI
[    1.906683] e100: Copyright(c) 1999-2006 Intel Corporation
[    1.906770] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
[    1.906772] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    1.906875] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    1.906877] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    1.906969] sky2: driver version 1.30
[    1.917813] libphy: r8169: probed
[    1.918952] r8169 0000:04:00.0 eth0: RTL8168h/8111h, b0:6e:bf:2f:47:8d, XID 54100800, IRQ 38
[    1.918957] r8169 0000:04:00.0 eth0: jumbo features [frames: 9200 bytes, tx checksumming: ko]
[    1.919605] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.919607] ehci-pci: EHCI PCI platform driver
[    1.919673] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.919691] ohci-pci: OHCI PCI platform driver
[    1.919756] uhci_hcd: USB Universal Host Controller Interface driver
[    1.920661] xhci_hcd 0000:02:00.0: xHCI Host Controller
[    1.921247] xhci_hcd 0000:02:00.0: new USB bus registered, assigned bus number 1
[    1.976992] xhci_hcd 0000:02:00.0: hcc params 0x0200ef81 hci version 0x110 quirks 0x0000000048000410
[    1.979073] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.19
[    1.979080] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.979083] usb usb1: Product: xHCI Host Controller
[    1.979086] usb usb1: Manufacturer: Linux 4.19.0-rc1+ xhci-hcd
[    1.979088] usb usb1: SerialNumber: 0000:02:00.0
[    1.980300] hub 1-0:1.0: USB hub found
[    1.980440] hub 1-0:1.0: 10 ports detected
[    2.150571] xhci_hcd 0000:02:00.0: xHCI Host Controller
[    2.150990] xhci_hcd 0000:02:00.0: new USB bus registered, assigned bus number 2
[    2.151006] xhci_hcd 0000:02:00.0: Host supports USB 3.10 Enhanced SuperSpeed
[    2.151207] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[    2.151536] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 4.19
[    2.151539] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.151542] usb usb2: Product: xHCI Host Controller
[    2.151544] usb usb2: Manufacturer: Linux 4.19.0-rc1+ xhci-hcd
[    2.151547] usb usb2: SerialNumber: 0000:02:00.0
[    2.152472] hub 2-0:1.0: USB hub found
[    2.152585] hub 2-0:1.0: 4 ports detected
[    2.214543] ata9: SATA link down (SStatus 0 SControl 300)
[    2.219198] xhci_hcd 0000:07:00.3: xHCI Host Controller
[    2.219550] xhci_hcd 0000:07:00.3: new USB bus registered, assigned bus number 3
[    2.219954] xhci_hcd 0000:07:00.3: hcc params 0x0270ffe5 hci version 0x110 quirks 0x0000000040000410
[    2.222391] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.19
[    2.222394] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.222397] usb usb3: Product: xHCI Host Controller
[    2.222399] usb usb3: Manufacturer: Linux 4.19.0-rc1+ xhci-hcd
[    2.222402] usb usb3: SerialNumber: 0000:07:00.3
[    2.223211] hub 3-0:1.0: USB hub found
[    2.223309] hub 3-0:1.0: 4 ports detected
[    2.225497] xhci_hcd 0000:07:00.3: xHCI Host Controller
[    2.225806] xhci_hcd 0000:07:00.3: new USB bus registered, assigned bus number 4
[    2.225820] xhci_hcd 0000:07:00.3: Host supports USB 3.10 Enhanced SuperSpeed
[    2.225975] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
[    2.226272] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 4.19
[    2.226275] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.226277] usb usb4: Product: xHCI Host Controller
[    2.226280] usb usb4: Manufacturer: Linux 4.19.0-rc1+ xhci-hcd
[    2.226282] usb usb4: SerialNumber: 0000:07:00.3
[    2.227121] hub 4-0:1.0: USB hub found
[    2.227215] hub 4-0:1.0: 4 ports detected
[    2.230003] xhci_hcd 0000:07:00.4: xHCI Host Controller
[    2.230330] xhci_hcd 0000:07:00.4: new USB bus registered, assigned bus number 5
[    2.230694] xhci_hcd 0000:07:00.4: hcc params 0x0260ffe5 hci version 0x110 quirks 0x0000000040000410
[    2.232812] usb usb5: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.19
[    2.232816] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.232818] usb usb5: Product: xHCI Host Controller
[    2.232821] usb usb5: Manufacturer: Linux 4.19.0-rc1+ xhci-hcd
[    2.232823] usb usb5: SerialNumber: 0000:07:00.4
[    2.233616] hub 5-0:1.0: USB hub found
[    2.233709] hub 5-0:1.0: 1 port detected
[    2.234654] xhci_hcd 0000:07:00.4: xHCI Host Controller
[    2.234924] xhci_hcd 0000:07:00.4: new USB bus registered, assigned bus number 6
[    2.234937] xhci_hcd 0000:07:00.4: Host supports USB 3.10 Enhanced SuperSpeed
[    2.235093] usb usb6: We don't know the algorithms for LPM for this host, disabling LPM.
[    2.235385] usb usb6: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 4.19
[    2.235387] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.235390] usb usb6: Product: xHCI Host Controller
[    2.235392] usb usb6: Manufacturer: Linux 4.19.0-rc1+ xhci-hcd
[    2.235395] usb usb6: SerialNumber: 0000:07:00.4
[    2.236186] hub 6-0:1.0: USB hub found
[    2.236276] hub 6-0:1.0: 1 port detected
[    2.237287] usbcore: registered new interface driver usblp
[    2.237368] usbcore: registered new interface driver usb-storage
[    2.237524] i8042: PNP: No PS/2 controller found.
[    2.238736] rtc_cmos 00:02: RTC can wake from S4
[    2.239390] rtc_cmos 00:02: registered as rtc0
[    2.239537] rtc_cmos 00:02: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    2.240829] device-mapper: ioctl: 4.39.0-ioctl (2018-04-03) initialised: dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
[    2.240966] hidraw: raw HID events driver (C) Jiri Kosina
[    2.242659] usbcore: registered new interface driver usbhid
[    2.242663] usbhid: USB HID core driver
[    2.244737] snd_hda_intel 0000:01:00.1: Force to non-snoop mode
[    2.249251] hdaudio hdaudioC0D0: Unable to bind the codec
[    2.249776] Initializing XFRM netlink socket
[    2.251431] NET: Registered protocol family 10
[    2.253089] hdaudio hdaudioC1D0: Unable to bind the codec
[    2.253952] Segment Routing with IPv6
[    2.254741] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    2.255726] NET: Registered protocol family 17
[    2.255857] Key type dns_resolver registered
[    2.255860] start plist test
[    2.258145] end plist test
[    2.263855] microcode: CPU0: patch_level=0x0810100b
[    2.263888] microcode: CPU1: patch_level=0x0810100b
[    2.263910] microcode: CPU2: patch_level=0x0810100b
[    2.263930] microcode: CPU3: patch_level=0x0810100b
[    2.263955] microcode: CPU4: patch_level=0x0810100b
[    2.263973] microcode: CPU5: patch_level=0x0810100b
[    2.263993] microcode: CPU6: patch_level=0x0810100b
[    2.264010] microcode: CPU7: patch_level=0x0810100b
[    2.264219] microcode: Microcode Update Driver: v2.2.
[    2.264290] sched_clock: Marking stable (2270148456, -5971137)->(2390051366, -125874047)
[    2.265134] registered taskstats version 1
[    2.265137] Loading compiled-in X.509 certificates
[    2.265724] hdaudio hdaudioC2D0: Unable to bind the codec
[    2.269761]   Magic number: 2:162:237
[    2.269964] console [netcon0] enabled
[    2.269966] netconsole: network logging started
[    2.271010] acpi_cpufreq: overriding BIOS provided _PSD data
[    2.275177] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    2.286210] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    2.286608] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[    2.286640] cfg80211: failed to load regulatory.db
[    2.286795] ALSA device list:
[    2.286797]   No soundcards found.
[    2.361594] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    2.368260] ata1.00: ATA-8: KINGSTON SV300S37A120G, 608ABBF0, max UDMA/133
[    2.368269] ata1.00: 234441648 sectors, multi 1: LBA48 NCQ (depth 32), AA
[    2.373709] ata1.00: configured for UDMA/133
[    2.375409] scsi 0:0:0:0: Direct-Access     ATA      KINGSTON SV300S3 BBF0 PQ: 0 ANSI: 5
[    2.379647] sd 0:0:0:0: [sda] 234441648 512-byte logical blocks: (120 GB/112 GiB)
[    2.379771] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    2.379832] sd 0:0:0:0: [sda] Write Protect is off
[    2.379837] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.380182] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.384791]  sda: sda1 sda2 sda3
[    2.387742] sd 0:0:0:0: [sda] Attached SCSI disk
[    2.484083] usb 1-1: new high-speed USB device number 2 using xhci_hcd
[    2.622614] usb 1-1: New USB device found, idVendor=0409, idProduct=005a, bcdDevice= 1.00
[    2.622640] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.630106] hub 1-1:1.0: USB hub found
[    2.632455] hub 1-1:1.0: 4 ports detected
[    2.689096] ata2: SATA link down (SStatus 0 SControl 300)
[    2.732788] usb 2-2: new SuperSpeed Gen 1 USB device number 2 using xhci_hcd
[    2.756830] usb 2-2: New USB device found, idVendor=2001, idProduct=4a00, bcdDevice= 1.00
[    2.756841] usb 2-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    2.756848] usb 2-2: Product: D-Link DUB-1312
[    2.756855] usb 2-2: Manufacturer: D-Link Elec. Corp.
[    2.756862] usb 2-2: SerialNumber: 000000000018A9
[    2.777251] tsc: Refined TSC clocksource calibration: 3596.423 MHz
[    2.777290] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x33d71ff2b93, max_idle_ns: 440795207865 ns
[    2.777517] clocksource: Switched to clocksource tsc
[    2.963455] usb 1-1.4: new low-speed USB device number 3 using xhci_hcd
[    2.998931] ata5: SATA link down (SStatus 0 SControl 300)
[    3.285215] usb 1-1.4: New USB device found, idVendor=046d, idProduct=c31c, bcdDevice=64.00
[    3.285226] usb 1-1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.285233] usb 1-1.4: Product: USB Keyboard
[    3.285240] usb 1-1.4: Manufacturer: Logitech
[    3.314819] ata6: SATA link down (SStatus 0 SControl 300)
[    3.315435] debug: unmapping init [mem 0xffffffff94b62000-0xffffffff94d2afff]
[    3.321180] Write protecting the kernel read-only data: 51200k
[    3.323160] debug: unmapping init [mem 0xffffffff9360b000-0xffffffff937fffff]
[    3.323373] debug: unmapping init [mem 0xffffffff93e8e000-0xffffffff93ffffff]
[    3.323607] Run /init as init process
[    3.390936] systemd[1]: systemd 238 running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=hybrid)
[    3.403721] systemd[1]: Detected architecture x86-64.
[    3.403734] systemd[1]: Running in initial RAM disk.
[    3.408891] systemd[1]: Set hostname to <raven>.
[    3.410107] input: Logitech USB Keyboard as /devices/pci0000:00/0000:00:01.2/0000:02:00.0/usb1/1-1/1-1.4/1-1.4:1.0/0003:046D:C31C.0001/input/input3
[    3.465685] hid-generic 0003:046D:C31C.0001: input,hidraw0: USB HID v1.10 Keyboard [Logitech USB Keyboard] on usb-0000:02:00.0-1.4/input0
[    3.574419] systemd[1]: File /usr/lib/systemd/system/systemd-journald.service:35 configures an IP firewall (IPAddressDeny=any), but the local system does not support BPF/cgroup based firewalling.
[    3.574430] systemd[1]: Proceeding WITHOUT firewalling in effect! (This warning is only shown for the first loaded unit using IP firewalling.)
[    3.582744] random: systemd: uninitialized urandom read (16 bytes read)
[    3.582780] systemd[1]: Reached target Timers.
[    3.582939] random: systemd: uninitialized urandom read (16 bytes read)
[    3.582968] systemd[1]: Reached target Slices.
[    3.582989] random: systemd: uninitialized urandom read (16 bytes read)
[    3.583016] systemd[1]: Reached target Local File Systems.
[    3.583292] systemd[1]: Reached target Swap.
[    3.589356] input: Logitech USB Keyboard Consumer Control as /devices/pci0000:00/0000:00:01.2/0000:02:00.0/usb1/1-1/1-1.4/1-1.4:1.1/0003:046D:C31C.0002/input/input4
[    3.612627] systemd-tmpfile (1480) used greatest stack depth: 20456 bytes left
[    3.640817] audit: type=1130 audit(1537200814.645:2): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-tmpfiles-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    3.643018] input: Logitech USB Keyboard System Control as /devices/pci0000:00/0000:00:01.2/0000:02:00.0/usb1/1-1/1-1.4/1-1.4:1.1/0003:046D:C31C.0002/input/input5
[    3.643932] input: Logitech USB Keyboard Consumer Control as /devices/pci0000:00/0000:00:01.2/0000:02:00.0/usb1/1-1/1-1.4/1-1.4:1.1/0003:046D:C31C.0002/input/input6
[    3.644807] hid-generic 0003:046D:C31C.0002: input,hidraw1: USB HID v1.10 Device [Logitech USB Keyboard] on usb-0000:02:00.0-1.4/input1
[    3.687096] input: Logitech USB Keyboard as /devices/pci0000:00/0000:00:01.2/0000:02:00.0/usb1/1-1/1-1.4/1-1.4:1.2/0003:046D:C31C.0003/input/input7
[    3.687846] hid-generic 0003:046D:C31C.0003: input,hidraw2: USB HID v1.10 Mouse [Logitech USB Keyboard] on usb-0000:02:00.0-1.4/input2
[    3.788712] audit: type=1130 audit(1537200814.793:3): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-cmdline comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    3.827716] audit: type=1130 audit(1537200814.832:4): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-vconsole-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    3.827746] audit: type=1131 audit(1537200814.832:5): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-vconsole-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    3.867841] audit: type=1130 audit(1537200814.872:6): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-pre-udev comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    3.881361] audit: type=1130 audit(1537200814.886:7): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-journald comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    3.901215] audit: type=1130 audit(1537200814.906:8): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-udevd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    4.423482] audit: type=1130 audit(1537200815.428:9): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-udev-trigger comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    4.484711] r8169 0000:04:00.0 enp4s0: renamed from eth0
[    4.505327] audit: type=1130 audit(1537200815.510:10): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=plymouth-start comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    4.541983] systemd-sysctl (2424) used greatest stack depth: 18968 bytes left
[    4.846416] ax88179_178a 2-2:1.0 eth0: register 'ax88179_178a' at usb-0000:02:00.0-2, D-Link DUB-1312 USB 3.0 to Gigabit Ethernet Adapter, 54:b8:0a:ef:ed:d7
[    4.847318] usbcore: registered new interface driver ax88179_178a
[    4.861927] ax88179_178a 2-2:1.0 enp2s0f0u2: renamed from eth0
[    4.911716] systemd-udevd (2026) used greatest stack depth: 18888 bytes left
[    4.991413] random: fast init done
[    5.027847] EXT4-fs (sda3): mounted filesystem with ordered data mode. Opts: (null)
[    5.104262] systemd-fstab-g (2453) used greatest stack depth: 17808 bytes left
[    5.306612] kauditd_printk_skb: 2 callbacks suppressed
[    5.306617] audit: type=1130 audit(1537200816.311:13): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=initrd-parse-etc comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.306699] audit: type=1131 audit(1537200816.311:14): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=initrd-parse-etc comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.541096] audit: type=1130 audit(1537200816.545:15): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-pre-pivot comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.571861] audit: type=1131 audit(1537200816.576:16): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-pre-pivot comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.574076] audit: type=1130 audit(1537200816.578:17): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-tmpfiles-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.574106] audit: type=1131 audit(1537200816.579:18): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-tmpfiles-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.575375] audit: type=1130 audit(1537200816.580:19): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-initqueue comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.575416] audit: type=1131 audit(1537200816.580:20): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-initqueue comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.577066] audit: type=1130 audit(1537200816.581:21): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-udev-trigger comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.577106] audit: type=1131 audit(1537200816.581:22): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-udev-trigger comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.875119] systemd-journald[1491]: Received SIGTERM from PID 1 (systemd).
[    5.995721] systemd: 21 output lines suppressed due to ratelimiting
[    6.120011] SELinux:  Disabled at runtime.
[    6.189739] systemd[1]: systemd 238 running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=hybrid)
[    6.202905] systemd[1]: Detected architecture x86-64.
[    6.205077] systemd[1]: Set hostname to <raven>.
[    6.281490] systemd-cryptse (2521) used greatest stack depth: 17768 bytes left
[    6.296484] selinux-autorel (2520) used greatest stack depth: 17712 bytes left
[    6.297753] anaconda-genera (2514) used greatest stack depth: 16136 bytes left
[    6.403768] systemd[1]: File /usr/lib/systemd/system/systemd-journald.service:35 configures an IP firewall (IPAddressDeny=any), but the local system does not support BPF/cgroup based firewalling.
[    6.403779] systemd[1]: Proceeding WITHOUT firewalling in effect! (This warning is only shown for the first loaded unit using IP firewalling.)
[    6.553027] systemd[1]: Stopped Switch Root.
[    6.553597] systemd[1]: systemd-journald.service: Service has no hold-off time, scheduling restart.
[    6.553683] systemd[1]: systemd-journald.service: Scheduled restart job, restart counter is at 1.
[    6.553710] systemd[1]: Stopped Journal Service.
[    6.556642] systemd[1]: Starting Journal Service...
[    6.651680] EXT4-fs (sda3): re-mounted. Opts: (null)
[    6.697729] systemd-journald[2535]: Received request to flush runtime journal from PID 1
[    7.493015] Adding 7826428k swap on /dev/sda2.  Priority:-2 extents:1 across:7826428k SS
[    7.831438] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[    8.647356] IPv6: ADDRCONF(NETDEV_UP): enp2s0f0u2: link is not ready
[    8.921527] random: crng init done
[    8.921540] random: 7 urandom warning(s) missed due to ratelimiting
[    9.012656] IPv6: ADDRCONF(NETDEV_UP): enp2s0f0u2: link is not ready
[    9.020450] IPv6: ADDRCONF(NETDEV_UP): enp4s0: link is not ready
[    9.030696] Generic PHY r8169-400:00: attached PHY driver [Generic PHY] (mii_bus:phy_addr=r8169-400:00, irq=IGNORE)
[    9.117340] IPv6: ADDRCONF(NETDEV_UP): enp4s0: link is not ready
[   12.048219] ax88179_178a 2-2:1.0 enp2s0f0u2: ax88179 - Link status is: 1
[   12.069633] IPv6: ADDRCONF(NETDEV_CHANGE): enp2s0f0u2: link becomes ready
[  332.317705] kworker/dying (1249) used greatest stack depth: 13040 bytes left
[  376.558471] [drm] amdgpu kernel modesetting enabled.
[  376.559271] Parsing CRAT table with 1 nodes
[  376.559428] Creating topology SYSFS entries
[  376.560131] Topology: Add APU node [0x0:0x0]
[  376.560133] Finished initializing topology
[  376.561073] amdgpu 0000:01:00.0: enabling device (0000 -> 0003)
[  376.563450] [drm] initializing kernel modesetting (POLARIS10 0x1002:0x67C4 0x1002:0x0B0D 0x00).
[  376.563533] [drm] register mmio base: 0xFE900000
[  376.563536] [drm] register mmio size: 262144
[  376.563598] [drm] add ip block number 0 <vi_common>
[  376.563601] [drm] add ip block number 1 <gmc_v8_0>
[  376.563603] [drm] add ip block number 2 <tonga_ih>
[  376.563605] [drm] add ip block number 3 <powerplay>
[  376.563607] [drm] add ip block number 4 <dm>
[  376.563610] [drm] add ip block number 5 <gfx_v8_0>
[  376.563612] [drm] add ip block number 6 <sdma_v3_0>
[  376.563614] [drm] add ip block number 7 <uvd_v6_0>
[  376.563616] [drm] add ip block number 8 <vce_v3_0>
[  376.563785] [drm] UVD is enabled in VM mode
[  376.563787] [drm] UVD ENC is enabled in VM mode
[  376.563793] [drm] VCE enabled in VM mode
[  376.678253] ATOM BIOS: 113-C9540101-006
[  376.678347] [drm] GPU posting now...
[  376.836771] [drm] vm size is 64 GB, 2 levels, block size is 10-bit, fragment size is 9-bit
[  376.840501] amdgpu 0000:01:00.0: VRAM: 8192M 0x000000F400000000 - 0x000000F5FFFFFFFF (8192M used)
[  376.840506] amdgpu 0000:01:00.0: GART: 256M 0x000000FF00000000 - 0x000000FF0FFFFFFF
[  376.840535] [drm] Detected VRAM RAM=8192M, BAR=256M
[  376.840537] [drm] RAM width 256bits GDDR5
[  376.841487] [TTM] Zone  kernel: Available graphics memory: 3049592 kiB
[  376.841497] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[  376.841499] [TTM] Initializing pool allocator
[  376.841834] [TTM] Initializing DMA pool allocator
[  376.842990] kasan: CONFIG_KASAN_INLINE enabled
[  376.843307] kasan: GPF could be caused by NULL-ptr deref or user memory access
[  376.843528] general protection fault: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN NOPTI
[  376.843723] CPU: 2 PID: 3862 Comm: modprobe Not tainted 4.19.0-rc1+ #29
[  376.843903] Hardware name: System manufacturer System Product Name/TUF B350M-PLUS GAMING, BIOS 4011 04/19/2018
[  376.844268] RIP: 0010:amdgpu_bo_create_kernel+0x59/0x1a0 [amdgpu]
[  376.844446] Code: 48 c1 ea 03 80 3c 02 00 0f 85 27 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b 6d 00 48 8d bd a8 00 00 00 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e e7 00 00 00 f6 85 aa 00 00 00
[  376.844795] RSP: 0018:ffff8801e20eea20 EFLAGS: 00010212
[  376.844958] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: dffffc0000000000
[  376.845151] RDX: 0000000000000015 RSI: 0000000000000000 RDI: 00000000000000a8
[  376.845336] RBP: 0000000000000000 R08: ffff8801f08a0658 R09: 0000000000000000
[  376.845521] R10: ffff8801f08b1c88 R11: ffff8801e20ee9a7 R12: ffff8801f08a0008
[  376.845706] R13: ffff8801f08a0b50 R14: ffff8801f08a0af0 R15: ffff8801f08a0000
[  376.845947] FS:  00007f222ef370c0(0000) GS:ffff8801fea80000(0000) knlGS:0000000000000000
[  376.846253] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  376.846474] CR2: 00007fc1e678bf18 CR3: 00000001e4896000 CR4: 00000000003406e0
[  376.846709] Call Trace:
[  376.847015]  amdgpu_ttm_init+0x594/0x7b0 [amdgpu]
[  376.847354]  ? amdgpu_ttm_set_buffer_funcs_status+0x370/0x370 [amdgpu]
[  376.847590]  ? printk+0x9a/0xc0
[  376.847771]  ? kmsg_dump_rewind_nolock+0xd4/0xd4
[  376.847974]  ? io_reserve_memtype+0x2c0/0x2c0
[  376.848297]  gmc_v8_0_sw_init+0x7a1/0x1590 [amdgpu]
[  376.848629]  ? gmc_v8_0_process_interrupt+0xdf0/0xdf0 [amdgpu]
[  376.848853]  ? drm_debugfs_remove_files+0x380/0x380
[  376.849180]  ? amdgpu_atom_parse+0x910/0x910 [amdgpu]
[  376.849513]  ? amdgpu_debugfs_add_files+0x1ac/0x280 [amdgpu]
[  376.849863]  amdgpu_device_init.cold.33+0x217f/0x313d [amdgpu]
[  376.850202]  ? amdgpu_device_has_dc_support+0x50/0x50 [amdgpu]
[  376.850428]  ? rcu_read_lock_sched_held+0x10f/0x130
[  376.850633]  ? __alloc_pages_nodemask+0x99a/0xb90
[  376.850836]  ? __alloc_pages_slowpath+0x2940/0x2940
[  376.851048]  ? depot_save_stack+0x288/0x460
[  376.851245]  ? save_trace+0x300/0x300
[  376.851437]  ? __kasan_slab_free+0x111/0x150
[  376.851632]  ? kfree+0xd2/0x290
[  376.851813]  ? drm_dev_register+0x225/0x3e0
[  376.852140]  ? amdgpu_pci_probe+0x290/0x3a0 [amdgpu]
[  376.852352]  ? local_pci_probe+0xcf/0x180
[  376.852546]  ? really_probe+0x4c7/0x720
[  376.852735]  ? driver_probe_device+0xc2/0x1a0
[  376.852934]  ? __driver_attach+0x200/0x270
[  376.853129]  ? __lock_is_held+0xad/0x140
[  376.853436]  ? amdgpu_driver_load_kms+0x124/0x770 [amdgpu]
[  376.853656]  ? rcu_read_lock_sched_held+0x10f/0x130
[  376.853975]  amdgpu_driver_load_kms+0x18a/0x770 [amdgpu]
[  376.854201]  ? trace_hardirqs_off_caller+0x210/0x210
[  376.854518]  ? amdgpu_driver_unload_kms+0x1a0/0x1a0 [amdgpu]
[  376.854738]  ? drm_dev_register+0x225/0x3e0
[  376.854934]  ? lockdep_hardirqs_on+0x37c/0x560
[  376.855136]  ? __kasan_slab_free+0x126/0x150
[  376.855334]  drm_dev_register+0x2a8/0x3e0
[  376.855640]  amdgpu_pci_probe+0x290/0x3a0 [amdgpu]
[  376.855961]  ? amdgpu_pmops_runtime_idle+0x2b0/0x2b0 [amdgpu]
[  376.856184]  local_pci_probe+0xcf/0x180
[  376.856375]  pci_device_probe+0x29f/0x470
[  376.856568]  ? pci_device_remove+0x3a0/0x3a0
[  376.856768]  really_probe+0x4c7/0x720
[  376.856957]  ? device_attach+0x10/0x10
[  376.857149]  ? driver_probe_device+0x1a0/0x1a0
[  376.857348]  ? driver_probe_device+0x1a0/0x1a0
[  376.857546]  driver_probe_device+0xc2/0x1a0
[  376.857740]  ? driver_probe_device+0x1a0/0x1a0
[  376.857938]  __driver_attach+0x200/0x270
[  376.858130]  bus_for_each_dev+0x116/0x1a0
[  376.858323]  ? subsys_dev_iter_exit+0x10/0x10
[  376.858520]  ? bus_add_driver+0xb2/0x500
[  376.858711]  ? kmem_cache_alloc_trace+0x135/0x2a0
[  376.858912]  ? bus_add_driver+0xb2/0x500
[  376.859106]  bus_add_driver+0x3e5/0x500
[  376.859299]  driver_register+0x189/0x310
[  376.859491]  __pci_register_driver+0x1fe/0x300
[  376.859678]  ? pci_bus_num_vf+0x10/0x10
[  376.859799]  ? 0xffffffffc0e90000
[  376.859916]  ? 0xffffffffc0e90000
[  376.860036]  do_one_initcall+0xdc/0x551
[  376.860157]  ? trace_event_raw_event_initcall_finish+0x1b0/0x1b0
[  376.860297]  ? fs_reclaim_acquire+0x10/0x10
[  376.860422]  ? lock_downgrade+0x690/0x690
[  376.860547]  ? rcu_pm_notify+0xc0/0xc0
[  376.860668]  ? kasan_unpoison_shadow+0x30/0x40
[  376.860795]  ? kasan_kmalloc+0xbf/0xe0
[  376.860917]  ? do_init_module+0x9a/0x730
[  376.861038]  ? kasan_unpoison_shadow+0x30/0x40
[  376.861167]  do_init_module+0x23e/0x730
[  376.861292]  ? __x64_sys_delete_module+0x5a0/0x5a0
[  376.861426]  load_module+0x726c/0x9210
[  376.861558]  ? module_frob_arch_sections+0x20/0x20
[  376.861687]  ? _raw_spin_unlock+0x1f/0x30
[  376.861809]  ? __pte_alloc_kernel+0x89/0xf0
[  376.861934]  ? __vfs_read+0x4f3/0x880
[  376.862056]  ? __x64_sys_copy_file_range+0x610/0x610
[  376.862187]  ? s_show+0x750/0x750
[  376.862304]  ? fsnotify+0x1480/0x1480
[  376.862423]  ? fsnotify+0x1480/0x1480
[  376.862548]  ? vfs_read+0x24a/0x2d0
[  376.862667]  ? vfs_read+0x24a/0x2d0
[  376.862787]  ? kernel_read+0x8b/0x130
[  376.862910]  ? get_unmapped_area+0x1c0/0x350
[  376.863043]  ? remove_arg_zero+0x5a0/0x5a0
[  376.863173]  ? do_mmap+0x80b/0x11b0
[  376.863295]  ? up_write+0x6f/0x210
[  376.863419]  ? __do_sys_finit_module+0x22a/0x290
[  376.863547]  __do_sys_finit_module+0x22a/0x290
[  376.863675]  ? __ia32_sys_init_module+0xa0/0xa0
[  376.863804]  ? vfs_statx_fd+0x3f/0x80
[  376.863925]  ? __do_sys_newfstat+0xb5/0xc0
[  376.864050]  ? do_syscall_64+0x8b/0x590
[  376.864179]  do_syscall_64+0x13a/0x590
[  376.864294]  ? syscall_return_slowpath+0x440/0x440
[  376.864416]  ? trace_hardirqs_on_caller+0x220/0x220
[  376.864537]  ? syscall_return_slowpath+0x1a7/0x440
[  376.864658]  ? prepare_exit_to_usermode+0x320/0x320
[  376.864779]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[  376.864900]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  376.865024] RIP: 0033:0x7f222e415879
[  376.865135] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d f7 45 2c 00 f7 d8 64 89 01 48
[  376.865422] RSP: 002b:00007ffc2bb0e9e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[  376.865598] RAX: ffffffffffffffda RBX: 00005590fdf2bb80 RCX: 00007f222e415879
[  376.865732] RDX: 0000000000000000 RSI: 00005590fd0a53e6 RDI: 0000000000000007
[  376.865866] RBP: 00005590fd0a53e6 R08: 0000000000000000 R09: 0000000000000000
[  376.865999] R10: 0000000000000007 R11: 0000000000000246 R12: 0000000000000000
[  376.866132] R13: 00005590fdf2bcb0 R14: 0000000000040000 R15: 0000000000000000
[  376.866270] Modules linked in: amdgpu(+) mfd_core chash gpu_sched ttm ax88179_178a usbnet
[  376.866525] ---[ end trace 3f013aac1eacc5ca ]---
[  376.866757] RIP: 0010:amdgpu_bo_create_kernel+0x59/0x1a0 [amdgpu]
[  376.866891] Code: 48 c1 ea 03 80 3c 02 00 0f 85 27 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b 6d 00 48 8d bd a8 00 00 00 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e e7 00 00 00 f6 85 aa 00 00 00
[  376.867186] RSP: 0018:ffff8801e20eea20 EFLAGS: 00010212
[  376.867313] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: dffffc0000000000
[  376.867450] RDX: 0000000000000015 RSI: 0000000000000000 RDI: 00000000000000a8
[  376.867588] RBP: 0000000000000000 R08: ffff8801f08a0658 R09: 0000000000000000
[  376.867721] R10: ffff8801f08b1c88 R11: ffff8801e20ee9a7 R12: ffff8801f08a0008
[  376.867861] R13: ffff8801f08a0b50 R14: ffff8801f08a0af0 R15: ffff8801f08a0000
[  376.868017] FS:  00007f222ef370c0(0000) GS:ffff8801fea80000(0000) knlGS:0000000000000000
[  376.868199] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  376.868327] CR2: 00007fc1e678bf18 CR3: 00000001e4896000 CR4: 00000000003406e0

--------------FEEA2C1716226EFA7C672103
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------FEEA2C1716226EFA7C672103--
