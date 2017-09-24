From: Thomas Meyer <thomas@m3y3r.de>
Subject: radeon_get_bios: BUG: unable to handle kernel paging request
Date: Sun, 24 Sep 2017 12:26:32 +0200
Message-ID: <20170924102626.GA20358@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, alexander.deucher@amd.com, christian.koenig@amd.com, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Hi,

while trying to resurrect my old Macbook as an 32 bit kernel testing device,
I think someone broke the radeon driver on this first generation pure EFI boot
Macbook.

My guess would be that the introduction of the vga_switcheroo code did break the
radeon_get_bios functionality.

I will try again without radeon_atrm_get_bios and radeon_acpi_vfct_bios.

kind regards
thomas

[    0.000000] Linux version 4.14.0-rc1+ (thomas@maria) (gcc version 7.1.1 20170622 (Red Hat 7.1.1-3) (GCC)) #7 SMP Sun Sep 24 07:16:00 CEST 2017
[    0.000000] Disabled fast string operations
[    0.000000] x86/fpu: x87 FPU will use FXSAVE
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000008efff] usable
[    0.000000] BIOS-e820: [mem 0x000000000008f000-0x000000000008ffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000000090000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007f0c7fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007f0c8000-0x000000007f2c8fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000007f2c9000-0x000000007fe4afff] usable
[    0.000000] BIOS-e820: [mem 0x000000007fe4b000-0x000000007fe6efff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007fe6f000-0x000000007fe7efff] usable
[    0.000000] BIOS-e820: [mem 0x000000007fe7f000-0x000000007feaafff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007feab000-0x000000007feb1fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007feb2000-0x000000007feb6fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000007feb7000-0x000000007feb8fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007feb9000-0x000000007feeefff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000007feef000-0x000000007fefefff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000007feff000-0x000000007fefffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000e00f8000-0x00000000e00f8fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fffb0000-0x00000000fffdffff] reserved
[    0.000000] Notice: NX (Execute Disable) protection cannot be enabled: non-PAE kernel!
[    0.000000] e820: update [mem 0x7bf6f010-0x7bf7ea3b] usable ==> usable
[    0.000000] e820: update [mem 0x7bf6f010-0x7bf7ea3b] usable ==> usable
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 0x0000000000000000-0x000000000008efff] usable
[    0.000000] reserve setup_data: [mem 0x000000000008f000-0x000000000008ffff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x0000000000090000-0x000000000009ffff] usable
[    0.000000] reserve setup_data: [mem 0x0000000000100000-0x000000007bf6f00f] usable
[    0.000000] reserve setup_data: [mem 0x000000007bf6f010-0x000000007bf7ea3b] usable
[    0.000000] reserve setup_data: [mem 0x000000007bf7ea3c-0x000000007f0c7fff] usable
[    0.000000] reserve setup_data: [mem 0x000000007f0c8000-0x000000007f2c8fff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x000000007f2c9000-0x000000007fe4afff] usable
[    0.000000] reserve setup_data: [mem 0x000000007fe4b000-0x000000007fe6efff] reserved
[    0.000000] reserve setup_data: [mem 0x000000007fe6f000-0x000000007fe7efff] usable
[    0.000000] reserve setup_data: [mem 0x000000007fe7f000-0x000000007feaafff] reserved
[    0.000000] reserve setup_data: [mem 0x000000007feab000-0x000000007feb1fff] usable
[    0.000000] reserve setup_data: [mem 0x000000007feb2000-0x000000007feb6fff] ACPI data
[    0.000000] reserve setup_data: [mem 0x000000007feb7000-0x000000007feb8fff] usable
[    0.000000] reserve setup_data: [mem 0x000000007feb9000-0x000000007feeefff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x000000007feef000-0x000000007fefefff] ACPI data
[    0.000000] reserve setup_data: [mem 0x000000007feff000-0x000000007fefffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000e00f8000-0x00000000e00f8fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fffb0000-0x00000000fffdffff] reserved
[    0.000000] efi: EFI v1.10 by Apple
[    0.000000] efi:  ACPI=0x7fefd000  ACPI 2.0=0x7fefd014  SMBIOS=0x7feba000 
[    0.000000] random: fast init done
[    0.000000] SMBIOS 2.4 present.
[    0.000000] DMI: Apple Computer, Inc. MacBookPro1,1/Mac-F425BEC8, BIOS    MBP11.88Z.0055.B08.0610121325 10/12/06
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x7feb9 max_arch_pfn = 0x100000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-CFFFF write-protect
[    0.000000]   D0000-DFFFF uncachable
[    0.000000]   E0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 0FFE00000 mask FFFE00000 write-protect
[    0.000000]   1 base 000000000 mask F80000000 write-back
[    0.000000]   2 base 07FF00000 mask FFFF00000 uncachable
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] x86/PAT: PAT not supported by CPU.
[    0.000000] x86/PAT: Configuration [0-7]: WB  WT  UC- UC  WB  WT  UC- UC  
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] initial memory mapped: [mem 0x00000000-0x0effffff]
[    0.000000] Base memory trampoline at [c009b000] 9b000 size 16384
[    0.000000] BRK [0x0ed2e000, 0x0ed2efff] PGTABLE
[    0.000000] Secure boot disabled
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x000000007FEFD014 000024 (v02 APPLE )
[    0.000000] ACPI: XSDT 0x000000007FEFD120 000074 (v01 APPLE  Apple00  00000055      01000013)
[    0.000000] ACPI: FACP 0x000000007FEFB000 0000F4 (v03 APPLE  Apple00  00000055 Loki 0000005F)
[    0.000000] ACPI: DSDT 0x000000007FEF0000 0048C0 (v01 APPLE  MacBookP 00010001 INTL 20050309)
[    0.000000] ACPI: FACS 0x000000007FEBB000 000040
[    0.000000] ACPI: FACS 0x000000007FEBB000 000040
[    0.000000] ACPI: HPET 0x000000007FEFA000 000038 (v01 APPLE  Apple00  00000001 Loki 0000005F)
[    0.000000] ACPI: APIC 0x000000007FEF9000 000068 (v01 APPLE  Apple00  00000001 Loki 0000005F)
[    0.000000] ACPI: MCFG 0x000000007FEF8000 00003C (v01 APPLE  Apple00  00000001 Loki 0000005F)
[    0.000000] ACPI: ASF! 0x000000007FEF7000 00009C (v32 APPLE  Apple00  00000001 Loki 0000005F)
[    0.000000] ACPI: SBST 0x000000007FEF6000 000030 (v01 APPLE  Apple00  00000001 Loki 0000005F)
[    0.000000] ACPI: ECDT 0x000000007FEF5000 000053 (v01 APPLE  Apple00  00000001 Loki 0000005F)
[    0.000000] ACPI: SSDT 0x000000007FEB6000 00064F (v01 APPLE  SataPri  00001000 INTL 20050309)
[    0.000000] ACPI: SSDT 0x000000007FEB5000 00069C (v01 APPLE  SataSec  00001000 INTL 20050309)
[    0.000000] ACPI: SSDT 0x000000007FEEF000 0004DC (v01 APPLE  CpuPm    00003000 INTL 20050309)
[    0.000000] ACPI: DMI detected to setup _OSI("Darwin"): Apple hardware
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] 1158MB HIGHMEM available.
[    0.000000] 887MB LOWMEM available.
[    0.000000]   mapped low ram: 0 - 377fe000
[    0.000000]   low ram: 0 - 377fe000
[    0.000000] BRK [0x0ed2f000, 0x0ed2ffff] PGTABLE
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   Normal   [mem 0x0000000001000000-0x00000000377fdfff]
[    0.000000]   HighMem  [mem 0x00000000377fe000-0x000000007feb8fff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000008efff]
[    0.000000]   node   0: [mem 0x0000000000090000-0x000000000009ffff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x000000007f0c7fff]
[    0.000000]   node   0: [mem 0x000000007f2c9000-0x000000007fe4afff]
[    0.000000]   node   0: [mem 0x000000007fe6f000-0x000000007fe7efff]
[    0.000000]   node   0: [mem 0x000000007feab000-0x000000007feb1fff]
[    0.000000]   node   0: [mem 0x000000007feb7000-0x000000007feb8fff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000007feb8fff]
[    0.000000] On node 0 totalpages: 523265
[    0.000000] free_area_init_node: node 0, pgdat ceb45f00, node_mem_map f63fe028
[    0.000000]   DMA zone: 40 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 3998 pages, LIFO batch:0
[    0.000000]   Normal zone: 2180 pages used for memmap
[    0.000000]   Normal zone: 223230 pages, LIFO batch:31
[    0.000000]   HighMem zone: 296037 pages, LIFO batch:31
[    0.000000] Using APIC driver default
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] smpboot: Allowing 2 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0008f000-0x0008ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000fffff]
[    0.000000] e820: [mem 0x7ff00000-0xe00f7fff] available for PCI devices
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.000000] setup_percpu: NR_CPUS:2 nr_cpumask_bits:2 nr_cpu_ids:2 nr_node_ids:1
[    0.000000] percpu: Embedded 21 pages/cpu @f63d1000 s55884 r0 d30132 u86016
[    0.000000] pcpu-alloc: s55884 r0 d30132 u86016 alloc=21*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 521045
[    0.000000] Kernel command line: selinux=0 
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Initializing CPU#0
[    0.000000] Initializing HighMem for node 0 (000377fe:0007feb9)
[    0.000000] Initializing Movable for node 0 (00000000:00000000)
[    0.000000] Memory: 2033008K/2093060K available (7193K kernel code, 401K rwdata, 1932K rodata, 1028K init, 532K bss, 60052K reserved, 0K cma-reserved, 1157092K highmem)
[    0.000000] virtual kernel memory layout:
                   fixmap  : 0xfff8d000 - 0xfffff000   ( 456 kB)
                   pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
                   vmalloc : 0xf7ffe000 - 0xff7fe000   ( 120 MB)
                   lowmem  : 0xc0000000 - 0xf77fe000   ( 887 MB)
                     .init : 0xceb64000 - 0xcec65000   (1028 kB)
                     .data : 0xce906618 - 0xceb51640   (2348 kB)
                     .text : 0xce200000 - 0xce906618   (7193 kB)
[    0.000000] Checking if this processor honours the WP bit even in supervisor mode...Ok.
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU event tracing is enabled.
[    0.000000] NR_IRQS: 2304, nr_irqs: 440, preallocated irqs: 16
[    0.000000] CPU 0 irqstacks, hard=f5c1a000 soft=f5c1c000
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.001000] tsc: Detected 1830.798 MHz processor
[    0.001000] Calibrating delay loop (skipped), value calculated using timer frequency.. 3661.59 BogoMIPS (lpj=1830798)
[    0.001000] pid_max: default: 32768 minimum: 301
[    0.001000] ACPI: Core revision 20170728
[    0.008108] ACPI: 4 ACPI AML tables successfully acquired and loaded
[    0.024075] Security Framework initialized
[    0.024087] SELinux:  Disabled at boot.
[    0.024134] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.024152] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.024694] Disabled fast string operations
[    0.024706] CPU: Physical Processor ID: 0
[    0.024713] CPU: Processor Core ID: 0
[    0.024729] mce: CPU supports 6 MCE banks
[    0.024746] CPU0: Thermal monitoring enabled (TM2)
[    0.024761] process: using mwait in idle threads
[    0.024777] Last level iTLB entries: 4KB 128, 2MB 0, 4MB 2
[    0.024787] Last level dTLB entries: 4KB 128, 2MB 0, 4MB 8, 1GB 0
[    0.025099] Freeing SMP alternatives memory: 28K
[    0.026144] smpboot: Max logical packages: 1
[    0.026157] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.027397] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.038000] smpboot: CPU0: Genuine Intel(R) CPU           T2400  @ 1.83GHz (family: 0x6, model: 0xe, stepping: 0x8)
[    0.038000] Performance Events: Core events, core PMU driver.
[    0.038000] ... version:                1
[    0.038000] ... bit width:              40
[    0.038000] ... generic registers:      2
[    0.038000] ... value mask:             000000ffffffffff
[    0.038000] ... max period:             000000007fffffff
[    0.038000] ... fixed-purpose events:   0
[    0.038000] ... event mask:             0000000000000003
[    0.038000] Hierarchical SRCU implementation.
[    0.038000] smp: Bringing up secondary CPUs ...
[    0.038000] CPU 1 irqstacks, hard=f5c86000 soft=f5c90000
[    0.038000] x86: Booting SMP configuration:
[    0.038000] .... node  #0, CPUs:      #1
[    0.001000] Initializing CPU#1
[    0.001000] ------------[ cut here ]------------
[    0.001000] WARNING: CPU: 1 PID: 0 at /home/thomas/git/linux/arch/x86/mm/tlb.c:257 initialize_tlbstate_and_flush+0xf0/0x100
[    0.001000] Modules linked in:
[    0.001000] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.14.0-rc1+ #7
[    0.001000] Hardware name: Apple Computer, Inc. MacBookPro1,1/Mac-F425BEC8, BIOS    MBP11.88Z.0055.B08.0610121325 10/12/06
[    0.001000] task: f5c539c0 task.stack: f5c74000
[    0.001000] EIP: initialize_tlbstate_and_flush+0xf0/0x100
[    0.001000] EFLAGS: 00210006 CPU: 1
[    0.001000] EAX: cec6f000 EBX: ceb0f760 ECX: 0ec6f000 EDX: 00000000
[    0.001000] ESI: 0ec6c000 EDI: f5c539c0 EBP: f5c75f48 ESP: f5c75f38
[    0.001000]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
[    0.001000] CR0: 80050033 CR2: 00000000 CR3: 0ec6c000 CR4: 00000690
[    0.001000] Call Trace:
[    0.001000]  cpu_init+0xcb/0x370
[    0.001000]  start_secondary+0x27/0x1c0
[    0.001000]  startup_32_smp+0x164/0x166
[    0.001000] Code: 00 00 51 9d 83 c0 10 3d ec 3b c6 ce 75 db 83 c4 08 5b 5e 5d c3 8d b6 00 00 00 00 0f ff e9 6d ff ff ff 89 f6 8d bc 27 00 00 00 00 <0f> ff e9 3c ff ff ff 89 f6 8d bc 27 00 00 00 00 55 89 d1 ba e0
[    0.001000] ---[ end trace 4f0e29a0d1dc00e3 ]---
[    0.001000] Disabled fast string operations
[    0.099052] smp: Brought up 1 node, 2 CPUs
[    0.099169] smpboot: Total of 2 processors activated (7323.14 BogoMIPS)
[    0.100225] devtmpfs: initialized
[    0.101263] PM: Registering ACPI NVS region [mem 0x0008f000-0x0008ffff] (4096 bytes)
[    0.101263] PM: Registering ACPI NVS region [mem 0x7f0c8000-0x7f2c8fff] (2101248 bytes)
[    0.101263] PM: Registering ACPI NVS region [mem 0x7feb9000-0x7feeefff] (221184 bytes)
[    0.101428] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.101449] futex hash table entries: 512 (order: 3, 32768 bytes)
[    0.102043] NET: Registered protocol family 16
[    0.102718] cpuidle: using governor menu
[    0.102718] ACPI: bus type PCI registered
[    0.103032] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.103066] PCI: not using MMCONFIG
[    0.118005] PCI: Using configuration type 1 for base access
[    0.129336] HugeTLB registered 4.00 MiB page size, pre-allocated 0 pages
[    0.129336] ACPI: Disabled all _OSI OS vendors
[    0.129336] ACPI: Added _OSI(Module Device)
[    0.129336] ACPI: Added _OSI(Processor Device)
[    0.129336] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.129336] ACPI: Added _OSI(Processor Aggregator Device)
[    0.129336] ACPI: Added _OSI(Darwin)
[    0.129336] ACPI: EC: EC started
[    0.129336] ACPI: EC: interrupt blocked
[    0.132026] ACPI: \: Used as first EC
[    0.132038] ACPI: \: GPE=0x17, EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.132048] ACPI: \: Used as boot ECDT EC to handle transactions
[    0.134029] ACPI: BIOS _OSI(Darwin) query honored via DMI
[    0.139385] ACPI: Dynamic OEM Table Load:
[    0.139410] ACPI: SSDT 0x00000000F5E7AC00 00022A (v01 APPLE  Cpu0Ist  00003000 INTL 20050309)
[    0.139815] ACPI: Dynamic OEM Table Load:
[    0.139836] ACPI: SSDT 0x00000000F5E7B800 0002C3 (v01 APPLE  Cpu0Cst  00003001 INTL 20050309)
[    0.140679] ACPI: Dynamic OEM Table Load:
[    0.140700] ACPI: SSDT 0x00000000F5D9E6C0 000087 (v01 APPLE  Cpu1Ist  00003000 INTL 20050309)
[    0.141015] ACPI: Dynamic OEM Table Load:
[    0.141036] ACPI: SSDT 0x00000000F5D9EF00 000085 (v01 APPLE  Cpu1Cst  00003000 INTL 20050309)
[    0.141688] ACPI: Interpreter enabled
[    0.141766] ACPI: (supports S0 S3 S4 S5)
[    0.141775] ACPI: Using IOAPIC for interrupt routing
[    0.141857] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.142576] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in ACPI motherboard resources
[    0.142590] PCI: Using MMCONFIG for extended config space
[    0.142613] PCI: Ignoring host bridge windows from ACPI; if necessary, use "pci=use_crs" and report a bug
[    0.143217] ACPI: Enabled 12 GPEs in block 00 to 1F
[    0.159652] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.159672] acpi PNP0A08:00: _OSC: OS assumes control of [PCIeHotplug SHPCHotplug AER PCIeCapability]
[    0.160040] acpi PNP0A08:00: host bridge window [io  0x0000-0x0cf7 window] (ignored)
[    0.160044] acpi PNP0A08:00: host bridge window [io  0x0cf8-0x0cff] (ignored)
[    0.160048] acpi PNP0A08:00: host bridge window [io  0x0d00-0xffff window] (ignored)
[    0.160053] acpi PNP0A08:00: host bridge window [mem 0x000a0000-0x000bffff window] (ignored)
[    0.160057] acpi PNP0A08:00: host bridge window [mem 0x000c0000-0x000c3fff window] (ignored)
[    0.160061] acpi PNP0A08:00: host bridge window [mem 0x000c4000-0x000c7fff window] (ignored)
[    0.160065] acpi PNP0A08:00: host bridge window [mem 0x000c8000-0x000cbfff window] (ignored)
[    0.160069] acpi PNP0A08:00: host bridge window [mem 0x000cc000-0x000cffff window] (ignored)
[    0.160073] acpi PNP0A08:00: host bridge window [mem 0x000d0000-0x000d3fff window] (ignored)
[    0.160077] acpi PNP0A08:00: host bridge window [mem 0x000d4000-0x000d7fff window] (ignored)
[    0.160081] acpi PNP0A08:00: host bridge window [mem 0x000d8000-0x000dbfff window] (ignored)
[    0.160086] acpi PNP0A08:00: host bridge window [mem 0x000dc000-0x000dffff window] (ignored)
[    0.160090] acpi PNP0A08:00: host bridge window [mem 0x000e0000-0x000e3fff window] (ignored)
[    0.160094] acpi PNP0A08:00: host bridge window [mem 0x000e4000-0x000e7fff window] (ignored)
[    0.160098] acpi PNP0A08:00: host bridge window [mem 0x000e8000-0x000ebfff window] (ignored)
[    0.160102] acpi PNP0A08:00: host bridge window [mem 0x000ec000-0x000effff window] (ignored)
[    0.160106] acpi PNP0A08:00: host bridge window [mem 0x000f0000-0x000fffff window] (ignored)
[    0.160110] acpi PNP0A08:00: host bridge window [mem 0x80000000-0xfebfffff window] (ignored)
[    0.160113] PCI: root bus 00: using default resources
[    0.160197] PCI host bridge to bus 0000:00
[    0.160210] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.160221] pci_bus 0000:00: root bus resource [mem 0x00000000-0xffffffff]
[    0.160234] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.160260] pci 0000:00:00.0: [8086:27a0] type 00 class 0x060000
[    0.160505] pci 0000:00:01.0: [8086:27a1] type 01 class 0x060400
[    0.160586] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.160819] pci 0000:00:07.0: [8086:27a3] type 00 class 0x110100
[    0.160839] pci 0000:00:07.0: reg 0x10: [mem 0x90304000-0x90304fff]
[    0.161123] pci 0000:00:1b.0: [8086:27d8] type 00 class 0x040300
[    0.161161] pci 0000:00:1b.0: reg 0x10: [mem 0x90300000-0x90303fff 64bit]
[    0.161281] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.161503] pci 0000:00:1c.0: [8086:27d0] type 01 class 0x060400
[    0.161651] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.161878] pci 0000:00:1c.2: [8086:27d4] type 01 class 0x060400
[    0.162025] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    0.162247] pci 0000:00:1d.0: [8086:27c8] type 00 class 0x0c0300
[    0.162320] pci 0000:00:1d.0: reg 0x20: [io  0x40a0-0x40bf]
[    0.162561] pci 0000:00:1d.1: [8086:27c9] type 00 class 0x0c0300
[    0.162634] pci 0000:00:1d.1: reg 0x20: [io  0x4080-0x409f]
[    0.162874] pci 0000:00:1d.2: [8086:27ca] type 00 class 0x0c0300
[    0.162946] pci 0000:00:1d.2: reg 0x20: [io  0x4060-0x407f]
[    0.163195] pci 0000:00:1d.3: [8086:27cb] type 00 class 0x0c0300
[    0.163268] pci 0000:00:1d.3: reg 0x20: [io  0x4040-0x405f]
[    0.163518] pci 0000:00:1d.7: [8086:27cc] type 00 class 0x0c0320
[    0.163549] pci 0000:00:1d.7: reg 0x10: [mem 0x90305400-0x903057ff]
[    0.163655] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.163858] pci 0000:00:1e.0: [8086:2448] type 01 class 0x060401
[    0.164155] pci 0000:00:1f.0: [8086:27b9] type 00 class 0x060100
[    0.164298] pci 0000:00:1f.0: quirk: [io  0x0400-0x047f] claimed by ICH6 ACPI/GPIO/TCO
[    0.164319] pci 0000:00:1f.0: quirk: [io  0x0500-0x053f] claimed by ICH6 GPIO
[    0.164333] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 1 PIO at 0680 (mask 000f)
[    0.164349] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 2 PIO at 1640 (mask 000f)
[    0.164365] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 3 PIO at 4700 (mask 0003)
[    0.164381] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 4 PIO at 0300 (mask 001f)
[    0.164624] pci 0000:00:1f.1: [8086:27df] type 00 class 0x01018f
[    0.164653] pci 0000:00:1f.1: reg 0x10: [io  0x40e8-0x40ef]
[    0.164669] pci 0000:00:1f.1: reg 0x14: [io  0x40fc-0x40ff]
[    0.164684] pci 0000:00:1f.1: reg 0x18: [io  0x40e0-0x40e7]
[    0.164699] pci 0000:00:1f.1: reg 0x1c: [io  0x40f8-0x40fb]
[    0.164714] pci 0000:00:1f.1: reg 0x20: [io  0x40c0-0x40cf]
[    0.164943] pci 0000:00:1f.2: [8086:27c5] type 00 class 0x010601
[    0.164976] pci 0000:00:1f.2: reg 0x10: [io  0x40d8-0x40df]
[    0.164992] pci 0000:00:1f.2: reg 0x14: [io  0x40f4-0x40f7]
[    0.165015] pci 0000:00:1f.2: reg 0x18: [io  0x40d0-0x40d7]
[    0.165030] pci 0000:00:1f.2: reg 0x1c: [io  0x40f0-0x40f3]
[    0.165045] pci 0000:00:1f.2: reg 0x20: [io  0x4020-0x402f]
[    0.165061] pci 0000:00:1f.2: reg 0x24: [mem 0x90305000-0x903053ff]
[    0.165132] pci 0000:00:1f.2: PME# supported from D3hot
[    0.165337] pci 0000:00:1f.3: [8086:27da] type 00 class 0x0c0500
[    0.165429] pci 0000:00:1f.3: reg 0x20: [io  0xefa0-0xefbf]
[    0.165774] pci 0000:01:00.0: [1002:71c5] type 00 class 0x030000
[    0.165853] pci 0000:01:00.0: reg 0x10: [mem 0x80000000-0x87ffffff pref]
[    0.165890] pci 0000:01:00.0: reg 0x14: [io  0x3000-0x30ff]
[    0.165926] pci 0000:01:00.0: reg 0x18: [mem 0x90200000-0x9020ffff]
[    0.166058] pci 0000:01:00.0: reg 0x30: [mem 0xfffe0000-0xffffffff pref]
[    0.166087] pci 0000:01:00.0: enabling Extended Tags
[    0.166289] pci 0000:01:00.0: supports D1 D2
[    0.166408] pci 0000:01:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    0.166443] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.166456] pci 0000:00:01.0:   bridge window [io  0x3000-0x3fff]
[    0.166462] pci 0000:00:01.0:   bridge window [mem 0x90200000-0x902fffff]
[    0.166469] pci 0000:00:01.0:   bridge window [mem 0x80000000-0x87ffffff 64bit pref]
[    0.166588] pci 0000:02:00.0: [11ab:4362] type 00 class 0x020000
[    0.166641] pci 0000:02:00.0: reg 0x10: [mem 0x90100000-0x90103fff 64bit]
[    0.166661] pci 0000:02:00.0: reg 0x18: [io  0x2000-0x20ff]
[    0.166728] pci 0000:02:00.0: reg 0x30: [mem 0xfffe0000-0xffffffff pref]
[    0.166844] pci 0000:02:00.0: supports D1 D2
[    0.166848] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.166994] pci 0000:02:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    0.167033] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.167047] pci 0000:00:1c.0:   bridge window [io  0x2000-0x2fff]
[    0.167054] pci 0000:00:1c.0:   bridge window [mem 0x90100000-0x901fffff]
[    0.167153] pci 0000:00:1c.2: PCI bridge to [bus 03-0a]
[    0.167168] pci 0000:00:1c.2:   bridge window [io  0x1000-0x1fff]
[    0.167175] pci 0000:00:1c.2:   bridge window [mem 0x8c100000-0x900fffff]
[    0.167186] pci 0000:00:1c.2:   bridge window [mem 0x88000000-0x8bffffff 64bit pref]
[    0.167282] pci 0000:0b:03.0: [11c1:5811] type 00 class 0x0c0010
[    0.167317] pci 0000:0b:03.0: reg 0x10: [mem 0x8c000000-0x8c000fff]
[    0.167441] pci 0000:0b:03.0: supports D1 D2
[    0.167445] pci 0000:0b:03.0: PME# supported from D0 D1 D2 D3hot
[    0.167621] pci 0000:00:1e.0: PCI bridge to [bus 0b] (subtractive decode)
[    0.167641] pci 0000:00:1e.0:   bridge window [mem 0x8c000000-0x8c0fffff]
[    0.167652] pci 0000:00:1e.0:   bridge window [io  0x0000-0xffff] (subtractive decode)
[    0.167656] pci 0000:00:1e.0:   bridge window [mem 0x00000000-0xffffffff] (subtractive decode)
[    0.167690] pci_bus 0000:00: on NUMA node 0
[    0.168046] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 12 14 15) *0, disabled.
[    0.168226] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
[    0.168406] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 12 14 15) *0, disabled.
[    0.168583] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
[    0.168769] ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 10 12 14 15) *0, disabled.
[    0.168946] ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
[    0.169135] ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 10 12 14 15) *0, disabled.
[    0.169316] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 11 12 14 15) *0, disabled.
[    0.170377] ACPI: EC: interrupt unblocked
[    0.170400] ACPI: EC: event unblocked
[    0.170418] ACPI: \_SB_.PCI0.LPCB.EC__: GPE=0x17, EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.170432] ACPI: \_SB_.PCI0.LPCB.EC__: Used as boot DSDT EC to handle transactions and events
[    0.170665] pci 0000:01:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
[    0.170683] pci 0000:01:00.0: vgaarb: bridge control possible
[    0.170691] vgaarb: loaded
[    0.170937] SCSI subsystem initialized
[    0.171085] libata version 3.00 loaded.
[    0.171169] ACPI: bus type USB registered
[    0.171242] usbcore: registered new interface driver usbfs
[    0.171288] usbcore: registered new interface driver hub
[    0.171340] usbcore: registered new device driver usb
[    0.171425] pps_core: LinuxPPS API ver. 1 registered
[    0.171435] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.171464] PTP clock support registered
[    0.171725] EDAC MC: Ver: 3.0.0
[    0.172018] Registered efivars operations
[    0.188181] Advanced Linux Sound Architecture Driver Initialized.
[    0.188246] PCI: Using ACPI for IRQ routing
[    0.200716] PCI: pci_cache_line_size set to 64 bytes
[    0.200799] e820: reserve RAM buffer [mem 0x0008f000-0x0008ffff]
[    0.200802] e820: reserve RAM buffer [mem 0x7bf6f010-0x7bffffff]
[    0.200805] e820: reserve RAM buffer [mem 0x7f0c8000-0x7fffffff]
[    0.200809] e820: reserve RAM buffer [mem 0x7fe4b000-0x7fffffff]
[    0.200813] e820: reserve RAM buffer [mem 0x7fe7f000-0x7fffffff]
[    0.200816] e820: reserve RAM buffer [mem 0x7feb2000-0x7fffffff]
[    0.200820] e820: reserve RAM buffer [mem 0x7feb9000-0x7fffffff]
[    0.201350] NetLabel: Initializing
[    0.201360] NetLabel:  domain hash size = 128
[    0.201368] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.201413] NetLabel:  unlabeled traffic allowed by default
[    0.201578] HPET: 3 timers in total, 0 timers will be used for per-cpu timer
[    0.201595] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.201610] hpet0: 3 comparators, 64-bit 14.318180 MHz counter
[    0.203047] clocksource: Switched to clocksource hpet
[    0.203143] VFS: Disk quotas dquot_6.6.0
[    0.203189] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.203315] pnp: PnP ACPI init
[    0.203524] system 00:00: [mem 0xe0000000-0xefffffff] could not be reserved
[    0.203539] system 00:00: [mem 0xfed14000-0xfed17fff] has been reserved
[    0.203551] system 00:00: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.203564] system 00:00: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.203576] system 00:00: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.203589] system 00:00: [mem 0xfed20000-0xfed8ffff] has been reserved
[    0.203615] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.204286] pnp 00:01: Plug and Play ACPI device, IDs IFX0101 (active)
[    0.204536] system 00:02: [mem 0xfed00000-0xfed003ff] has been reserved
[    0.204568] system 00:02: Plug and Play ACPI device, IDs PNP0103 PNP0c01 (active)
[    0.204663] pnp 00:03: disabling [io  0x1640-0x164f] because it overlaps 0000:00:1c.2 BAR 7 [io  0x1000-0x1fff]
[    0.204785] system 00:03: [io  0x0680-0x06ef] has been reserved
[    0.204798] system 00:03: [io  0x0800-0x080f] has been reserved
[    0.204810] system 00:03: [io  0x0810-0x0817] has been reserved
[    0.204822] system 00:03: [io  0x0400-0x047f] has been reserved
[    0.204834] system 00:03: [io  0x0500-0x053f] has been reserved
[    0.204859] system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.204934] pnp 00:04: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.205068] pnp: PnP ACPI: found 5 devices
[    0.244271] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.244304] pci 0000:01:00.0: can't claim BAR 6 [mem 0xfffe0000-0xffffffff pref]: no compatible bridge window
[    0.244321] pci 0000:02:00.0: can't claim BAR 6 [mem 0xfffe0000-0xffffffff pref]: no compatible bridge window
[    0.244359] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 02] add_size 200000 add_align 100000
[    0.244395] pci 0000:00:1c.0: BAR 9: assigned [mem 0x90400000-0x905fffff 64bit pref]
[    0.244413] pci 0000:01:00.0: BAR 6: assigned [mem 0x90220000-0x9023ffff pref]
[    0.244427] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.244439] pci 0000:00:01.0:   bridge window [io  0x3000-0x3fff]
[    0.244453] pci 0000:00:01.0:   bridge window [mem 0x90200000-0x902fffff]
[    0.244466] pci 0000:00:01.0:   bridge window [mem 0x80000000-0x87ffffff 64bit pref]
[    0.244485] pci 0000:02:00.0: BAR 6: assigned [mem 0x90120000-0x9013ffff pref]
[    0.244498] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.244510] pci 0000:00:1c.0:   bridge window [io  0x2000-0x2fff]
[    0.244526] pci 0000:00:1c.0:   bridge window [mem 0x90100000-0x901fffff]
[    0.244541] pci 0000:00:1c.0:   bridge window [mem 0x90400000-0x905fffff 64bit pref]
[    0.244561] pci 0000:00:1c.2: PCI bridge to [bus 03-0a]
[    0.244573] pci 0000:00:1c.2:   bridge window [io  0x1000-0x1fff]
[    0.244588] pci 0000:00:1c.2:   bridge window [mem 0x8c100000-0x900fffff]
[    0.244603] pci 0000:00:1c.2:   bridge window [mem 0x88000000-0x8bffffff 64bit pref]
[    0.244624] pci 0000:00:1e.0: PCI bridge to [bus 0b]
[    0.244639] pci 0000:00:1e.0:   bridge window [mem 0x8c000000-0x8c0fffff]
[    0.244662] pci_bus 0000:00: resource 4 [io  0x0000-0xffff]
[    0.244666] pci_bus 0000:00: resource 5 [mem 0x00000000-0xffffffff]
[    0.244670] pci_bus 0000:01: resource 0 [io  0x3000-0x3fff]
[    0.244675] pci_bus 0000:01: resource 1 [mem 0x90200000-0x902fffff]
[    0.244679] pci_bus 0000:01: resource 2 [mem 0x80000000-0x87ffffff 64bit pref]
[    0.244684] pci_bus 0000:02: resource 0 [io  0x2000-0x2fff]
[    0.244688] pci_bus 0000:02: resource 1 [mem 0x90100000-0x901fffff]
[    0.244692] pci_bus 0000:02: resource 2 [mem 0x90400000-0x905fffff 64bit pref]
[    0.244696] pci_bus 0000:03: resource 0 [io  0x1000-0x1fff]
[    0.244701] pci_bus 0000:03: resource 1 [mem 0x8c100000-0x900fffff]
[    0.244705] pci_bus 0000:03: resource 2 [mem 0x88000000-0x8bffffff 64bit pref]
[    0.244709] pci_bus 0000:0b: resource 1 [mem 0x8c000000-0x8c0fffff]
[    0.244714] pci_bus 0000:0b: resource 4 [io  0x0000-0xffff]
[    0.244718] pci_bus 0000:0b: resource 5 [mem 0x00000000-0xffffffff]
[    0.244956] NET: Registered protocol family 2
[    0.245340] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    0.245397] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
[    0.245483] TCP: Hash tables configured (established 8192 bind 8192)
[    0.245562] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    0.245588] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    0.245692] NET: Registered protocol family 1
[    0.248137] pci 0000:00:1d.7: enabling device (0000 -> 0002)
[    0.248759] PCI: CLS mismatch (256 != 64), using 64 bytes
[    0.266243] Scanning for low memory corruption every 60 seconds
[    0.266314] efifb: dmi detected MacBookPro1,1 - framebuffer at 0x80010000 (1440x900, stride 5888)
[    0.266991] audit: initializing netlink subsys (disabled)
[    0.267167] audit: type=2000 audit(1506241992.266:1): state=initialized audit_enabled=0 res=1
[    0.267790] workingset: timestamp_bits=14 max_order=19 bucket_order=5
[    0.276118] bounce: pool size: 64 pages
[    0.276161] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
[    0.276176] io scheduler noop registered
[    0.276185] io scheduler deadline registered
[    0.276343] io scheduler cfq registered (default)
[    0.276355] io scheduler mq-deadline registered
[    0.276364] io scheduler kyber registered
[    0.277911] pcieport 0000:00:1c.2: enabling device (0000 -> 0003)
[    0.278579] efifb: probing for efifb
[    0.278620] efifb: framebuffer at 0x80010000, using 5176k, total 5175k
[    0.278631] efifb: mode is 1440x900x32, linelength=5888, pages=1
[    0.278639] efifb: scrolling: redraw
[    0.278648] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    0.382813] Console: switching to colour frame buffer device 180x56
[    0.486917] fb0: EFI VGA frame buffer device
[    0.487471] intel_idle: does not run on family 6 model 14
[    0.487671] ACPI: AC Adapter [ADP1] (on-line)
[    0.488418] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input0
[    0.489480] ACPI: Lid Switch [LID0]
[    0.490027] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
[    0.491047] ACPI: Power Button [PWRB]
[    0.491583] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input2
[    0.492609] ACPI: Sleep Button [SLPB]
[    0.493197] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[    0.494123] ACPI: Power Button [PWRF]
[    0.494978] Monitor-Mwait will be used to enter C-1 state
[    0.494988] Monitor-Mwait will be used to enter C-2 state
[    0.494995] Monitor-Mwait will be used to enter C-3 state
[    0.495022] Monitor-Mwait will be used to enter C-4 state
[    0.495029] tsc: Marking TSC unstable due to TSC halts in idle
[    0.497017] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.499308] Non-volatile memory driver v1.3
[    0.499960] intel_rng: FWH not detected
[    0.505109] loop: module loaded
[    0.505750] ahci 0000:00:1f.2: version 3.0
[    0.505764] ahci 0000:00:1f.2: enabling device (0005 -> 0007)
[    0.506983] ahci 0000:00:1f.2: SSS flag set, parallel bus scan disabled
[    0.507824] ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 1.5 Gbps 0x4 impl SATA mode
[    0.508812] ahci 0000:00:1f.2: flags: 64bit ncq ilck stag pm led clo pio slum part 
[    0.510832] scsi host0: ahci
[    0.511534] scsi host1: ahci
[    0.512130] scsi host2: ahci
[    0.512731] scsi host3: ahci
[    0.513241] ata1: DUMMY
[    0.513532] ata2: DUMMY
[    0.513824] ata3: SATA max UDMA/133 abar m1024@0x90305000 port 0x90305200 irq 26
[    0.514717] ata4: DUMMY
[    0.515278] ata_piix 0000:00:1f.1: version 2.13
[    0.517196] scsi host4: ata_piix
[    0.517810] scsi host5: ata_piix
[    0.518330] ata5: PATA max UDMA/100 cmd 0x40e8 ctl 0x40fc bmdma 0x40c0 irq 18
[    0.519202] ata6: PATA max UDMA/100 cmd 0x40e0 ctl 0x40f8 bmdma 0x40c8 irq 18
[    0.549794] e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2-NAPI
[    0.580067] e100: Copyright(c) 1999-2006 Intel Corporation
[    0.610314] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
[    0.640300] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    0.670079] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    0.699595] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    0.729336] sky2: driver version 1.30
[    0.759913] ata5.00: ATAPI: MATSHITADVD-R   UJ-857, HAEA, max UDMA/66
[    0.760087] sky2 0000:02:00.0: Yukon-2 EC chip revision 2
[    0.760591] sky2 0000:02:00.0 eth0: addr 00:16:cb:8c:b2:65
[    0.761167] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.761170] ehci-pci: EHCI PCI platform driver
[    0.761537] ehci-pci 0000:00:1d.7: EHCI Host Controller
[    0.761668] ehci-pci 0000:00:1d.7: new USB bus registered, assigned bus number 1
[    0.761689] ehci-pci 0000:00:1d.7: debug port 1
[    0.765596] ehci-pci 0000:00:1d.7: cache line size of 64 is not supported
[    0.765766] ehci-pci 0000:00:1d.7: irq 23, io mem 0x90305400
[    0.772041] ehci-pci 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    0.772181] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    0.772185] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.772189] usb usb1: Product: EHCI Host Controller
[    0.772193] usb usb1: Manufacturer: Linux 4.14.0-rc1+ ehci_hcd
[    0.772196] usb usb1: SerialNumber: 0000:00:1d.7
[    0.772500] hub 1-0:1.0: USB hub found
[    0.772545] hub 1-0:1.0: 8 ports detected
[    0.773105] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.773112] ohci-pci: OHCI PCI platform driver
[    0.773143] uhci_hcd: USB Universal Host Controller Interface driver
[    0.773447] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    0.773631] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
[    0.773669] uhci_hcd 0000:00:1d.0: irq 23, io base 0x000040a0
[    0.773828] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
[    0.773832] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.773835] usb usb2: Product: UHCI Host Controller
[    0.773839] usb usb2: Manufacturer: Linux 4.14.0-rc1+ uhci_hcd
[    0.773842] usb usb2: SerialNumber: 0000:00:1d.0
[    0.774155] hub 2-0:1.0: USB hub found
[    0.774198] hub 2-0:1.0: 2 ports detected
[    0.774764] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    0.774948] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
[    0.775020] uhci_hcd 0000:00:1d.1: irq 19, io base 0x00004080
[    0.775128] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
[    0.775132] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.775135] usb usb3: Product: UHCI Host Controller
[    0.775139] usb usb3: Manufacturer: Linux 4.14.0-rc1+ uhci_hcd
[    0.775142] usb usb3: SerialNumber: 0000:00:1d.1
[    0.775449] hub 3-0:1.0: USB hub found
[    0.775465] hub 3-0:1.0: 2 ports detected
[    0.776110] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    0.776226] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
[    0.776264] uhci_hcd 0000:00:1d.2: irq 18, io base 0x00004060
[    0.776370] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
[    0.776374] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.776377] usb usb4: Product: UHCI Host Controller
[    0.776381] usb usb4: Manufacturer: Linux 4.14.0-rc1+ uhci_hcd
[    0.776384] usb usb4: SerialNumber: 0000:00:1d.2
[    0.776690] hub 4-0:1.0: USB hub found
[    0.776706] hub 4-0:1.0: 2 ports detected
[    0.777354] uhci_hcd 0000:00:1d.3: UHCI Host Controller
[    0.777470] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
[    0.777522] uhci_hcd 0000:00:1d.3: irq 16, io base 0x00004040
[    0.777630] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
[    0.777634] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.777637] usb usb5: Product: UHCI Host Controller
[    0.777641] usb usb5: Manufacturer: Linux 4.14.0-rc1+ uhci_hcd
[    0.777644] usb usb5: SerialNumber: 0000:00:1d.3
[    0.777970] hub 5-0:1.0: USB hub found
[    0.777986] hub 5-0:1.0: 2 ports detected
[    0.778473] usbcore: registered new interface driver usblp
[    0.778578] usbcore: registered new interface driver usb-storage
[    0.778776] i8042: PNP: No PS/2 controller found.
[    0.779415] rtc_cmos 00:04: RTC can wake from S4
[    0.779661] rtc_cmos 00:04: rtc core: registered rtc_cmos as rtc0
[    0.779702] rtc_cmos 00:04: alarms up to one month, y3k, 242 bytes nvram, hpet irqs
[    0.780241] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
[    0.781627] device-mapper: ioctl: 4.36.0-ioctl (2017-06-09) initialised: dm-devel@redhat.com
[    0.781637] EFI Variables Facility v0.08 2004-May-17
[    0.800359] hidraw: raw HID events driver (C) Jiri Kosina
[    0.801520] usbcore: registered new interface driver usbhid
[    0.801521] usbhid: USB HID core driver
[    0.802119] snd_hda_intel 0000:00:1b.0: enabling device (0000 -> 0002)
[    0.802778] Netfilter messages via NETLINK v0.30.
[    0.802976] nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
[    0.803189] ctnetlink v0.93: registering with nfnetlink.
[    0.803482] ip_tables: (C) 2000-2006 Netfilter Core Team
[    0.814423] hdaudio hdaudioC0D0: Unable to bind the codec
[    0.834476] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    0.846125] ata3.00: ATA-9: INTEL SSDSC2CT240A4, 335s, max UDMA/133
[    0.846129] ata3.00: 468862128 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    0.856128] ata3.00: configured for UDMA/133
[    0.856350] scsi 2:0:0:0: Direct-Access     ATA      INTEL SSDSC2CT24 335s PQ: 0 ANSI: 5
[    0.857044] sd 2:0:0:0: [sda] 468862128 512-byte logical blocks: (240 GB/224 GiB)
[    0.857078] sd 2:0:0:0: [sda] Write Protect is off
[    0.857082] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    0.857135] sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    0.857526] sd 2:0:0:0: Attached scsi generic sg0 type 0
[    0.859225]  sda: sda1 sda2 sda3 sda4
[    0.860188] sd 2:0:0:0: [sda] Attached SCSI disk
[    1.098040] usb 1-1: new high-speed USB device number 2 using ehci-pci
[    1.228595] usb 1-1: New USB device found, idVendor=0b05, idProduct=1786
[    1.228600] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    1.228603] usb 1-1: Product: ASUS EZ N Network Adapter
[    1.228607] usb 1-1: Manufacturer: Manufacturer Realtek 
[    1.228610] usb 1-1: SerialNumber: 00e04c000001
[    1.312040] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x1a63cf29df2, max_idle_ns: 440795204073 ns
[    1.732038] usb 2-2: new full-speed USB device number 2 using uhci_hcd
[    1.919106] usb 2-2: New USB device found, idVendor=05ac, idProduct=0218
[    1.919110] usb 2-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    1.919114] usb 2-2: Product: Apple Internal Keyboard / Trackpad
[    1.919117] usb 2-2: Manufacturer: Apple Computer
[    1.928960] input: Apple Computer Apple Internal Keyboard / Trackpad as /devices/pci0000:00/0000:00:1d.0/usb2/2-2/2-2:1.0/0003:05AC:0218.0001/input/input4
[    1.980633] apple 0003:05AC:0218.0001: input,hidraw0: USB HID v1.11 Keyboard [Apple Computer Apple Internal Keyboard / Trackpad] on usb-0000:00:1d.0-2/input0
[    1.987893] input: Apple Computer Apple Internal Keyboard / Trackpad as /devices/pci0000:00/0000:00:1d.0/usb2/2-2/2-2:1.2/0003:05AC:0218.0002/input/input5
[    2.039211] apple 0003:05AC:0218.0002: input,hidraw1: USB HID v1.11 Device [Apple Computer Apple Internal Keyboard / Trackpad] on usb-0000:00:1d.0-2/input2
[    2.234043] usb 1-4: new high-speed USB device number 4 using ehci-pci
[    2.363023] usb 1-4: New USB device found, idVendor=05ac, idProduct=8501
[    2.363028] usb 1-4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.363031] usb 1-4: Product: Built-in iSight
[    2.363034] usb 1-4: Manufacturer: Micron
[    2.666043] usb 4-2: new full-speed USB device number 2 using uhci_hcd
[    2.844093] usb 4-2: New USB device found, idVendor=05ac, idProduct=8240
[    2.844098] usb 4-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.844101] usb 4-2: Product: IR Receiver
[    2.844104] usb 4-2: Manufacturer: Apple Computer, Inc.
[    3.562043] usb 5-1: new full-speed USB device number 2 using uhci_hcd
[    3.944103] usb 5-1: New USB device found, idVendor=05ac, idProduct=1000
[    3.944107] usb 5-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    3.967129] input: HID 05ac:1000 as /devices/pci0000:00/0000:00:1d.3/usb5/5-1/5-1:1.0/0003:05AC:1000.0004/input/input6
[    4.019642] hid-generic 0003:05AC:1000.0004: input,hidraw2: USB HID v1.11 Keyboard [HID 05ac:1000] on usb-0000:00:1d.3-1/input0
[    4.037446] input: HID 05ac:1000 as /devices/pci0000:00/0000:00:1d.3/usb5/5-1/5-1:1.1/0003:05AC:1000.0005/input/input7
[    4.037701] hid-generic 0003:05AC:1000.0005: input,hidraw3: USB HID v1.11 Mouse [HID 05ac:1000] on usb-0000:00:1d.3-1/input1
[    4.359977] Initializing XFRM netlink socket
[    4.399892] NET: Registered protocol family 10
[    4.402173] ata5.00: configured for UDMA/66
[    4.404296] scsi 4:0:0:0: CD-ROM            MATSHITA DVD-R   UJ-857   HAEA PQ: 0 ANSI: 5
[    4.480339] sr 4:0:0:0: [sr0] scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
[    4.480342] cdrom: Uniform CD-ROM driver Revision: 3.20
[    4.480625] sr 4:0:0:0: Attached scsi CD-ROM sr0
[    4.480930] sr 4:0:0:0: Attached scsi generic sg1 type 5
[    4.638202] Segment Routing with IPv6
[    4.677591] ip6_tables: (C) 2000-2006 Netfilter Core Team
[    4.718132] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    4.757560] NET: Registered protocol family 17
[    4.796401] Key type dns_resolver registered
[    4.835429] microcode: sig=0x6e8, pf=0x20, revision=0x39
[    4.874255] microcode: Microcode Update Driver: v2.2.
[    4.874267] Using IPI No-Shortcut mode
[    4.951332] registered taskstats version 1
[    4.989765] console [netcon0] enabled
[    5.027249] netconsole: network logging started
[    5.068755] ALSA device list:
[    5.105871]   No soundcards found.
[    5.143271] Freeing unused kernel memory: 1028K
[    5.180282] Write protecting the kernel text: 7196k
[    5.217314] Write protecting the kernel read-only data: 1944k
[    5.334495] EXT4-fs (loop0): 3 orphan inodes deleted
[    5.371061] EXT4-fs (loop0): recovery complete
[    5.412253] EXT4-fs (loop0): mounted filesystem with ordered data mode. Opts: 
[    5.668058] systemd[1]: RTC configured in localtime, applying delta of 120 minutes to system time.
[    5.732261] systemd[1]: systemd 233 running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN default-hierarchy=hybrid)
[    5.810540] systemd[1]: Detected architecture x86.
[    6.507244] systemd[1]: Listening on Process Core Dump Socket.
[    6.585366] systemd[1]: Created slice User and Session Slice.
[    6.659470] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[    6.731182] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[    6.803632] systemd[1]: Listening on LVM2 poll daemon socket.
[    6.876651] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    6.950833] systemd[1]: Listening on Journal Socket (/dev/log).
[    7.025929] systemd[1]: Reached target Login Prompts.
[    8.116598] audit: type=1130 audit(1506234800.115:2): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-journald comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    8.220676] audit: type=1130 audit(1506234800.219:3): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-vconsole-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    8.294720] audit: type=1131 audit(1506234800.219:4): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-vconsole-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    8.416060] audit: type=1130 audit(1506234800.415:5): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-sysctl comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    8.539566] audit: type=1130 audit(1506234800.538:6): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-remount-fs comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    8.668250] audit: type=1130 audit(1506234800.667:7): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=lvm2-lvmetad comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    9.015862] audit: type=1130 audit(1506234801.014:8): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=fedora-readonly comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    9.165922] audit: type=1130 audit(1506234801.164:9): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-tmpfiles-setup-dev comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    9.307977] audit: type=1130 audit(1506234801.306:10): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-udev-trigger comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    9.320977] systemd-journald[1183]: Received request to flush runtime journal from PID 1
[    9.461090] systemd-journald[1183]: File /var/log/journal/fd305a034daf414c8fa0c30897019c39/system.journal corrupted or uncleanly shut down, renaming and replacing.
[    9.751236] audit: type=1130 audit(1506234801.750:11): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-journal-flush comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   10.420570] sky2 0000:02:00.0 enp2s0: renamed from eth0
[   10.610162] appletouch 2-2:1.1: Geyser mode initialized.
[   10.678059] input: Apple Computer, Inc. IR Receiver as /devices/pci0000:00/0000:00:1d.2/usb4/4-2/4-2:1.0/0003:05AC:8240.0003/input/input9
[   10.744258] r8712u: module is from the staging directory, the quality is unknown, you have been warned.
[   10.778164] input: appletouch as /devices/pci0000:00/0000:00:1d.0/usb2/2-2/2-2:1.1/input/input8
[   10.847095] usbcore: registered new interface driver appletouch
[   10.871089] appleir 0003:05AC:8240.0003: input,hiddev96,hidraw4: USB HID v1.11 Device [Apple Computer, Inc. IR Receiver] on usb-0000:00:1d.2-2/input0
[   10.985243] r8712u: register rtl8712_netdev_ops to netdev_ops
[   11.045177] usb 1-1: r8712u: USB_SPEED_HIGH with 4 endpoints
[   11.336050] usb 1-1: r8712u: Boot from EFUSE: Autoload OK
[   11.427840] applesmc: key=247 fan=2 temp=12 index=12 acc=1 lux=2 kbd=1
[   11.440471] input: applesmc as /devices/platform/applesmc.768/input/input10
[   11.445293] applesmc applesmc.768: hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
[   12.419380] random: crng init done
[   12.565863] usb 1-1: r8712u: CustomerID = 0x0010
[   12.622212] usb 1-1: r8712u: MAC Address from efuse = 00:26:18:c4:c3:48
[   12.678395] usb 1-1: r8712u: Loading firmware from "rtlwifi/rtl8712u.bin"
[   12.735085] usbcore: registered new interface driver r8712u
[   12.814848] r8712u 1-1:1.0 wlp0s29f7u1: renamed from wlan0
[   13.435381] kauditd_printk_skb: 8 callbacks suppressed
[   13.435384] audit: type=1130 audit(1506234805.434:20): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=plymouth-read-write comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   13.435734] audit: type=1131 audit(1506234805.434:21): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=plymouth-read-write comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   13.678381] audit: type=1130 audit(1506234805.677:22): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-tmpfiles-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   13.824040] audit: type=1130 audit(1506234805.822:23): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=nfs-config comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   13.824511] audit: type=1131 audit(1506234805.823:24): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=nfs-config comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   14.027803] audit: type=1130 audit(1506234806.026:25): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=dracut-shutdown comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   19.368818] IPv6: ADDRCONF(NETDEV_UP): enp2s0: link is not ready
[   19.371116] sky2 0000:02:00.0 enp2s0: enabling interface
[   19.379545] IPv6: ADDRCONF(NETDEV_UP): enp2s0: link is not ready
[   19.441394] IPv6: ADDRCONF(NETDEV_UP): wlp0s29f7u1: link is not ready
[   20.216547] r8712u 1-1:1.0 wlp0s29f7u1: 1 RCR=0x153f00e
[   20.241195] r8712u 1-1:1.0 wlp0s29f7u1: 2 RCR=0x553f00e
[   21.488420] IPv6: ADDRCONF(NETDEV_UP): wlp0s29f7u1: link is not ready
[   23.106381] IPv6: ADDRCONF(NETDEV_UP): wlp0s29f7u1: link is not ready
[   23.392797] IPv6: ADDRCONF(NETDEV_UP): wlp0s29f7u1: link is not ready
[   43.931727] IPv6: ADDRCONF(NETDEV_CHANGE): wlp0s29f7u1: link becomes ready
[   45.500593] IPv6: ADDRCONF(NETDEV_UP): wlp0s29f7u1: link is not ready
[  169.948911] sky2 0000:02:00.0 enp2s0: Link is up at 1000 Mbps, full duplex, flow control both
[  169.948911] IPv6: ADDRCONF(NETDEV_CHANGE): enp2s0: link becomes ready
[  178.371650] systemd-journald[1183]: File /var/log/journal/fd305a034daf414c8fa0c30897019c39/user-1000.journal corrupted or uncleanly shut down, renaming and replacing.
[  208.902278] IPv6: ADDRCONF(NETDEV_CHANGE): wlp0s29f7u1: link becomes ready
[  316.163383] [drm] radeon kernel modesetting enabled.
[  316.163521] checking generic (80010000 50e000) vs hw (80000000 8000000)
[  316.163524] fb: switching to radeondrmfb from EFI VGA
[  316.164263] Console: switching to colour dummy device 80x25
[  316.173340] [drm] initializing kernel modesetting (RV530 0x1002:0x71C5 0x106B:0x0080 0x00).
[  316.173409] radeon 0000:01:00.0: Invalid PCI ROM header signature: expecting 0xaa55, got 0xa1a1
[  316.173574] radeon 0000:01:00.0: Invalid PCI ROM header signature: expecting 0xaa55, got 0x2121
[  316.173596] BUG: unable to handle kernel paging request at 3bf6f03c
[  316.173716] IP: radeon_get_bios+0x701/0xe80 [radeon]
[  316.173720] *pde = 00000000 
[  316.173726] Oops: 0000 [#1] SMP
[  316.173731] Modules linked in: radeon(+) iptable_nat nf_nat_ipv4 nf_nat applesmc r8712u(C) hid_appleir appletouch i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm drm apple_bl
[  316.173764] CPU: 0 PID: 3401 Comm: modprobe Tainted: G        WC      4.14.0-rc1+ #7
[  316.173769] Hardware name: Apple Computer, Inc. MacBookPro1,1/Mac-F425BEC8, BIOS    MBP11.88Z.0055.B08.0610121325 10/12/06
[  316.173774] task: edc6f380 task.stack: f23ca000
[  316.173873] EIP: radeon_get_bios+0x701/0xe80 [radeon]
[  316.173877] EFLAGS: 00210206 CPU: 0
[  316.173882] EAX: 3bf6f03c EBX: c7d30164 ECX: 0000fa00 EDX: 0000fa00
[  316.173887] ESI: 00000000 EDI: c7d30000 EBP: f23cbc84 ESP: f23cbc04
[  316.173891]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
[  316.173896] CR0: 80050033 CR2: 3bf6f03c CR3: 1c6ca000 CR4: 000006d0
[  316.173901] Call Trace:
[  316.173914]  ? iomem_map_sanity_check+0x69/0xb0
[  316.173921]  ? __ioremap_caller+0x161/0x2d0
[  316.174010]  ? cail_mc_write+0x20/0x20 [radeon]
[  316.174028]  r520_init+0x21/0x2b0 [radeon]
[  316.174028]  radeon_device_init+0x5eb/0xc80 [radeon]
[  316.174028]  radeon_driver_load_kms+0x87/0x1c0 [radeon]
[  316.174028]  drm_dev_register+0x120/0x1a0 [drm]
[  316.174028]  drm_get_pci_dev+0x7e/0x130 [drm]
[  316.174028]  radeon_pci_probe+0x78/0x90 [radeon]
[  316.174028]  pci_device_probe+0x8f/0x130
[  316.174028]  driver_probe_device+0x1af/0x290
[  316.174028]  __driver_attach+0x81/0x90
[  316.174028]  ? driver_probe_device+0x290/0x290
[  316.174028]  bus_for_each_dev+0x57/0x80
[  316.174028]  driver_attach+0x14/0x20
[  316.174028]  ? driver_probe_device+0x290/0x290
[  316.174028]  bus_add_driver+0x157/0x1e0
[  316.174028]  ? 0xf83ae000
[  316.174028]  driver_register+0x51/0xd0
[  316.174028]  ? 0xf83ae000
[  316.174028]  __pci_register_driver+0x35/0x40
[  316.174028]  radeon_init+0x81/0x1000 [radeon]
[  316.174028]  do_one_initcall+0x41/0x160
[  316.174028]  ? kvfree+0x45/0x50
[  316.174028]  ? kmem_cache_alloc+0xed/0x150
[  316.174028]  ? do_init_module+0x17/0x1c7
[  316.174028]  do_init_module+0x49/0x1c7
[  316.174028]  load_module+0x1d9b/0x2460
[  316.174028]  SyS_finit_module+0x6d/0x90
[  316.174028]  do_fast_syscall_32+0x67/0x180
[  316.174028]  entry_SYSENTER_32+0x4e/0x7c
[  316.174028] EIP: 0xb7f6ab55
[  316.174028] EFLAGS: 00000246 CPU: 0
[  316.174028] EAX: ffffffda EBX: 00000003 ECX: 00487e0c EDX: 00000000
[  316.174028] ESI: 014b5f98 EDI: 014b51d8 EBP: 014b64c8 ESP: bffc3a7c
[  316.174028]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b
[  316.174028] Code: 16 00 00 84 c0 0f 85 0e fc ff ff 8b 47 08 8b 55 ac c7 87 64 01 00 00 00 00 00 00 e8 3a 8a a1 d5 85 c0 74 10 8b 55 cc 85 d2 74 09 <80> 38 55 0f 84 ae 00 00 00 68 f0 aa bb f8 6a 00 68 cd aa bb f8
[  316.174028] EIP: radeon_get_bios+0x701/0xe80 [radeon] SS:ESP: 0068:f23cbc04
[  316.174028] CR2: 000000003bf6f03c
[  316.174896] ---[ end trace 4f0e29a0d1dc00e5 ]---
[  329.023549] IPv6: ADDRCONF(NETDEV_UP): wlp0s29f7u1: link is not ready
[  330.540455] IPv6: ADDRCONF(NETDEV_UP): wlp0s29f7u1: link is not ready
