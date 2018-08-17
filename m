From: =?UTF-8?Q?Br=C3=A1ulio_Bhavamitra?= <brauliobo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Chrome crash on 4.18.1
Date: Fri, 17 Aug 2018 19:39:43 -0300
Message-ID: <CAJri6_t0K4uxjbmU=xeTFntbxr67f+FeTmBLbnL2yXmdXnBqpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1551458660=="
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
To: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1551458660==
Content-Type: multipart/alternative; boundary="0000000000001d5ee40573a93d81"

--0000000000001d5ee40573a93d81
Content-Type: text/plain; charset="UTF-8"

Chrome freezed and had to be killed, error on dmesg below.

Using AMD Ryzen 2500u

[    0.000000] Linux version 4.18.1-arch1-1-ARCH (builduser@heftig-21694)
(gcc version 8.2.0 (GCC)) #1 SMP PREEMPT Wed Aug 15 21:11:55 UTC 2018
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-linux
root=UUID=7bec7995-3557-480d-aee8-d9871405748d rw pci=noaer idle=nomwait
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Centaur CentaurHauls
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point
registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832
bytes, using 'compacted' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009d3ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009d400-0x000000000009ffff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff]
reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000003ffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000004000000-0x000000000400ffff] ACPI
NVS
[    0.000000] BIOS-e820: [mem 0x0000000004010000-0x0000000009e9ffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000009ea0000-0x0000000009ffffff]
reserved
[    0.000000] BIOS-e820: [mem 0x000000000a000000-0x00000000ccfaafff] usable
[    0.000000] BIOS-e820: [mem 0x00000000ccfab000-0x00000000cd096fff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000cd097000-0x00000000cd0c6fff] ACPI
data
[    0.000000] BIOS-e820: [mem 0x00000000cd0c7000-0x00000000cd59efff] ACPI
NVS
[    0.000000] BIOS-e820: [mem 0x00000000cd59f000-0x00000000cdd4bfff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000cdd4c000-0x00000000ceffffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000cf000000-0x00000000dfffffff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fd800000-0x00000000fd8fffff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fe800000-0x00000000fe800fff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000feb80000-0x00000000fec01fff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec10000-0x00000000fec10fff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed40000-0x00000000fed44fff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed8ffff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fedc2000-0x00000000fedcffff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fedd4000-0x00000000fedd5fff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000feefffff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff]
reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000051f33ffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 3.0.0 present.
[    0.000000] DMI: HP HP ENVY x360 Convertible 15m-bq1xx/83C6, BIOS F.17
03/29/2018
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] last_pfn = 0x51f340 max_arch_pfn = 0x400000000
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
[    0.000000] TOM2: 0000000520000000 aka 20992M
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC-
WT
[    0.000000] e820: update [mem 0xe0000000-0xffffffff] usable ==> reserved
[    0.000000] last_pfn = 0xcf000 max_arch_pfn = 0x400000000
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] Base memory trampoline at [(____ptrval____)] 97000 size 24576
[    0.000000] Using GB pages for direct mapping
[    0.000000] BRK [0x236676000, 0x236676fff] PGTABLE
[    0.000000] BRK [0x236677000, 0x236677fff] PGTABLE
[    0.000000] BRK [0x236678000, 0x236678fff] PGTABLE
[    0.000000] BRK [0x236679000, 0x236679fff] PGTABLE
[    0.000000] BRK [0x23667a000, 0x23667afff] PGTABLE
[    0.000000] BRK [0x23667b000, 0x23667bfff] PGTABLE
[    0.000000] BRK [0x23667c000, 0x23667cfff] PGTABLE
[    0.000000] BRK [0x23667d000, 0x23667dfff] PGTABLE
[    0.000000] BRK [0x23667e000, 0x23667efff] PGTABLE
[    0.000000] BRK [0x23667f000, 0x23667ffff] PGTABLE
[    0.000000] BRK [0x236680000, 0x236680fff] PGTABLE
[    0.000000] RAMDISK: [mem 0x35e07000-0x36efafff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F05B0 000024 (v02 HPQOEM)
[    0.000000] ACPI: XSDT 0x00000000CD0A7090 00009C (v01 HPQOEM SLIC-MPC
01072009 HP   00010013)
[    0.000000] ACPI: FACP 0x00000000CD0BC1A0 000114 (v06 HPQOEM SLIC-MPC
01072009 HP   00010013)
[    0.000000] ACPI BIOS Warning (bug): Optional FADT field Pm2ControlBlock
has valid Length but zero Address: 0x0000000000000000/0x1
(20180531/tbfadt-624)
[    0.000000] ACPI: DSDT 0x00000000CD0A71B8 014FE2 (v02 HPQOEM 83C6
 01072009 ACPI 20120913)
[    0.000000] ACPI: FACS 0x00000000CD582F80 000040
[    0.000000] ACPI: APIC 0x00000000CD0BC2B8 0000DE (v03 HPQOEM 83C6
 01072009 HP   00010013)
[    0.000000] ACPI: FPDT 0x00000000CD0BC398 000044 (v01 HPQOEM 83C6
 01072009 HP   00010013)
[    0.000000] ACPI: FIDT 0x00000000CD0BC3E0 00009C (v01 HPQOEM 83C6
 01072009 HP   00010013)
[    0.000000] ACPI: SSDT 0x00000000CD0BC480 0051C4 (v02 HPQOEM 83C6
 00000002 ACPI 04000000)
[    0.000000] ACPI: MCFG 0x00000000CD0C1648 00003C (v01 HPQOEM 83C6
 01072009 HP   00010013)
[    0.000000] ACPI: MSDM 0x00000000CD0C1688 000055 (v03 HPQOEM SLIC-MPC
00000001 HP   00010013)
[    0.000000] ACPI: SSDT 0x00000000CD0C16E0 00119C (v01 HPQOEM 83C6
 00000001 ACPI 00000001)
[    0.000000] ACPI: CRAT 0x00000000CD0C2880 000838 (v01 HPQOEM 83C6
 00000001 HP   00000001)
[    0.000000] ACPI: CDIT 0x00000000CD0C30B8 000029 (v01 HPQOEM 83C6
 00000001 HP   00000001)
[    0.000000] ACPI: HPET 0x00000000CD0C30E8 000038 (v01 HPQOEM 83C6
 01072009 HP   00000005)
[    0.000000] ACPI: UEFI 0x00000000CD0C3120 000042 (v01 HPQOEM 83C6
 00000000 HP   00000000)
[    0.000000] ACPI: IVRS 0x00000000CD0C3168 0000D0 (v02 HPQOEM 83C6
 00000001 HP   00000000)
[    0.000000] ACPI: SSDT 0x00000000CD0C3238 001676 (v01 HPQOEM 83C6
 00000001 ACPI 20120913)
[    0.000000] ACPI: SSDT 0x00000000CD0C48B0 0018E2 (v01 HPQOEM 83C6
 00000001 ACPI 20120913)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000051f33ffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x51f33c000-0x51f33ffff]
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000051f33ffff]
[    0.000000]   Device   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009cfff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x0000000003ffffff]
[    0.000000]   node   0: [mem 0x0000000004010000-0x0000000009e9ffff]
[    0.000000]   node   0: [mem 0x000000000a000000-0x00000000ccfaafff]
[    0.000000]   node   0: [mem 0x00000000cdd4c000-0x00000000ceffffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000051f33ffff]
[    0.000000] Reserved but unavailable: 8053 pages
[    0.000000] Initmem setup node 0 [mem
0x0000000000001000-0x000000051f33ffff]
[    0.000000] On node 0 totalpages: 5166027
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 21 pages reserved
[    0.000000]   DMA zone: 3996 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 13124 pages used for memmap
[    0.000000]   DMA32 zone: 839919 pages, LIFO batch:31
[    0.000000]   Normal zone: 67533 pages used for memmap
[    0.000000]   Normal zone: 4322112 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 9, version 33, address 0xfec00000, GSI
0-23
[    0.000000] IOAPIC[1]: apic_id 10, version 33, address 0xfec01000, GSI
24-55
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
[    0.000000] PM: Registered nosave memory: [mem 0x04000000-0x0400ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x09ea0000-0x09ffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xccfab000-0xcd096fff]
[    0.000000] PM: Registered nosave memory: [mem 0xcd097000-0xcd0c6fff]
[    0.000000] PM: Registered nosave memory: [mem 0xcd0c7000-0xcd59efff]
[    0.000000] PM: Registered nosave memory: [mem 0xcd59f000-0xcdd4bfff]
[    0.000000] PM: Registered nosave memory: [mem 0xcf000000-0xdfffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xe0000000-0xf7ffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xf8000000-0xfbffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfc000000-0xfd7fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfd800000-0xfd8fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfd900000-0xfe7fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfe800000-0xfe800fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfe801000-0xfeb7ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfeb80000-0xfec01fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec02000-0xfec0ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec10000-0xfec10fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec11000-0xfecfffff]
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
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 6370452778343963 ns
[    0.000000] random: get_random_bytes called from start_kernel+0x95/0x535
with crng_init=0
[    0.000000] setup_percpu: NR_CPUS:320 nr_cpumask_bits:320 nr_cpu_ids:16
nr_node_ids:1
[    0.000000] percpu: Embedded 46 pages/cpu @(____ptrval____) s151552
r8192 d28672 u262144
[    0.000000] pcpu-alloc: s151552 r8192 d28672 u262144 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 12
13 14 15
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages:
5085285
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-linux
root=UUID=7bec7995-3557-480d-aee8-d9871405748d rw pci=noaer idle=nomwait
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Memory: 20231056K/20664108K available (10252K kernel code,
1297K rwdata, 3528K rodata, 1488K init, 612K bss, 433052K reserved, 0K
cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=16, Nodes=1
[    0.000000] ftrace: allocating 33391 entries in 131 pages
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] CONFIG_RCU_FANOUT set to non-default value of 32
[    0.000000] RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000] RCU restricting CPUs from NR_CPUS=320 to nr_cpu_ids=16.
[    0.000000] RCU priority boosting: priority 1 delay 500 ms.
[    0.000000] Tasks RCU enabled.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=16
[    0.000000] NR_IRQS: 20736, nr_irqs: 1096, preallocated irqs: 16
[    0.000000] Offload RCU callbacks from CPUs: (none).
[    0.000000] spurious 8259A interrupt: IRQ7.
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] ACPI: Core revision 20180531
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff,
max_idle_ns: 133484873504 ns
[    0.000000] hpet clockevent registered
[    0.000000] APIC: Switch to symmetric I/O mode setup
[    0.003333] Switched APIC routing to physical flat.
[    0.003333] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.019999] tsc: Fast TSC calibration using PIT
[    0.023333] tsc: Detected 1996.125 MHz processor
[    0.023333] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:
0x398bc360853, max_idle_ns: 881590429734 ns
[    0.023333] Calibrating delay loop (skipped), value calculated using
timer frequency.. 3993.59 BogoMIPS (lpj=6653750)
[    0.023333] pid_max: default: 32768 minimum: 301
[    0.023333] Security Framework initialized
[    0.023333] Yama: becoming mindful.
[    0.030426] Dentry cache hash table entries: 4194304 (order: 13,
33554432 bytes)
[    0.033707] Inode-cache hash table entries: 2097152 (order: 12, 16777216
bytes)
[    0.033887] Mount-cache hash table entries: 65536 (order: 7, 524288
bytes)
[    0.033994] Mountpoint-cache hash table entries: 65536 (order: 7, 524288
bytes)
[    0.034705] mce: CPU supports 23 MCE banks
[    0.034729] LVT offset 1 assigned for vector 0xf9
[    0.034796] LVT offset 2 assigned for vector 0xf4
[    0.034810] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 512
[    0.034811] Last level dTLB entries: 4KB 1536, 2MB 1536, 4MB 768, 1GB 0
[    0.034813] Spectre V2 : Mitigation: Full AMD retpoline
[    0.034814] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB
on context switch
[    0.034814] Spectre V2 : Spectre v2 mitigation: Enabling Indirect Branch
Prediction Barrier
[    0.034816] Speculative Store Bypass: Mitigation: Speculative Store
Bypass disabled via prctl and seccomp
[    0.042325] Freeing SMP alternatives memory: 28K
[    0.046666] smpboot: CPU0: AMD Ryzen 5 2500U with Radeon Vega Mobile Gfx
(family: 0x17, model: 0x11, stepping: 0x0)
[    0.063354] Performance Events: Fam17h core perfctr, AMD PMU driver.
[    0.063362] ... version:                0
[    0.063363] ... bit width:              48
[    0.063364] ... generic registers:      6
[    0.063365] ... value mask:             0000ffffffffffff
[    0.063366] ... max period:             00007fffffffffff
[    0.063367] ... fixed-purpose events:   0
[    0.063368] ... event mask:             000000000000003f
[    0.070012] Hierarchical SRCU implementation.
[    0.090482] NMI watchdog: Enabled. Permanently consumes one hw-PMU
counter.
[    0.096676] smp: Bringing up secondary CPUs ...
[    0.136716] x86: Booting SMP configuration:
[    0.136719] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7
[    0.382675] smp: Brought up 1 node, 8 CPUs
[    0.382675] smpboot: Max logical packages: 2
[    0.382675] smpboot: Total of 8 processors activated (31950.75 BogoMIPS)
[    0.384034] devtmpfs: initialized
[    0.384034] x86/mm: Memory block size: 128MB
[    0.387974] PM: Registering ACPI NVS region [mem 0x04000000-0x0400ffff]
(65536 bytes)
[    0.387974] PM: Registering ACPI NVS region [mem 0xcd0c7000-0xcd59efff]
(5079040 bytes)
[    0.387974] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 6370867519511994 ns
[    0.387974] futex hash table entries: 4096 (order: 6, 262144 bytes)
[    0.387974] pinctrl core: initialized pinctrl subsystem
[    0.387974] RTC time: 20:56:45, date: 08/17/18
[    0.390689] NET: Registered protocol family 16
[    0.390824] audit: initializing netlink subsys (disabled)
[    0.390832] audit: type=2000 audit(1534539404.389:1): state=initialized
audit_enabled=0 res=1
[    0.390832] cpuidle: using governor ladder
[    0.390832] cpuidle: using governor menu
[    0.390832] ACPI FADT declares the system doesn't support PCIe ASPM, so
disable it
[    0.390832] ACPI: bus type PCI registered
[    0.390832] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.390832] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem
0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.390832] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
[    0.390832] PCI: Using configuration type 1 for base access
[    0.390832] mtrr: your CPUs had inconsistent variable MTRR settings
[    0.390832] mtrr: probably your BIOS does not setup all CPUs.
[    0.390832] mtrr: corrected configuration.
[    0.393439] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.393439] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.393569] ACPI: Added _OSI(Module Device)
[    0.393571] ACPI: Added _OSI(Processor Device)
[    0.393571] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.393572] ACPI: Added _OSI(Processor Aggregator Device)
[    0.393573] ACPI: Added _OSI(Linux-Dell-Video)
[    0.395212] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.417390] ACPI: 5 ACPI AML tables successfully acquired and loaded
[    0.442272] ACPI: EC: EC started
[    0.442274] ACPI: EC: interrupt blocked
[    0.474786] ACPI: \_SB_.PCI0.SBRG.EC0_: Used as first EC
[    0.474788] ACPI: \_SB_.PCI0.SBRG.EC0_: GPE=0x3, EC_CMD/EC_SC=0x66,
EC_DATA=0x62
[    0.474791] ACPI: \_SB_.PCI0.SBRG.EC0_: Used as boot DSDT EC to handle
transactions
[    0.474791] ACPI: Interpreter enabled
[    0.474815] ACPI: (supports S0 S3 S4 S5)
[    0.474816] ACPI: Using IOAPIC for interrupt routing
[    0.476784] PCI: Using host bridge windows from ACPI; if necessary, use
"pci=nocrs" and report a bug
[    0.477446] ACPI: Enabled 2 GPEs in block 00 to 1F
[    0.482166] ACPI: Power Resource [P0ST] (on)
[    0.482221] ACPI: Power Resource [P3ST] (on)
[    0.489829] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.489836] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM
ClockPM Segments MSI]
[    0.490252] acpi PNP0A08:00: _OSC: platform does not support
[SHPCHotplug LTR]
[    0.490543] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME
PCIeCapability]
[    0.490544] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using
BIOS configuration
[    0.490564] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000
[bus 00-3f] only partially covers this bridge
[    0.491144] PCI host bridge to bus 0000:00
[    0.491147] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    0.491149] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    0.491151] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
[    0.491152] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.491154] pci_bus 0000:00: root bus resource [mem
0x000a0000-0x000bffff window]
[    0.491156] pci_bus 0000:00: root bus resource [mem
0x000c0000-0x000dffff window]
[    0.491157] pci_bus 0000:00: root bus resource [mem
0xe0000000-0xfebfffff window]
[    0.491159] pci_bus 0000:00: root bus resource [mem
0xfee00000-0xffffffff window]
[    0.491161] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.491173] pci 0000:00:00.0: [1022:15d0] type 00 class 0x060000
[    0.491339] pci 0000:00:00.2: [1022:15d1] type 00 class 0x080600
[    0.491539] pci 0000:00:01.0: [1022:1452] type 00 class 0x060000
[    0.491704] pci 0000:00:01.6: [1022:15d3] type 01 class 0x060400
[    0.491840] pci 0000:00:01.6: PME# supported from D0 D3hot D3cold
[    0.491994] pci 0000:00:01.7: [1022:15d3] type 01 class 0x060400
[    0.492129] pci 0000:00:01.7: PME# supported from D0 D3hot D3cold
[    0.492286] pci 0000:00:08.0: [1022:1452] type 00 class 0x060000
[    0.492436] pci 0000:00:08.1: [1022:15db] type 01 class 0x060400
[    0.492493] pci 0000:00:08.1: enabling Extended Tags
[    0.492551] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
[    0.492667] pci 0000:00:08.2: [1022:15dc] type 01 class 0x060400
[    0.492724] pci 0000:00:08.2: enabling Extended Tags
[    0.492781] pci 0000:00:08.2: PME# supported from D0 D3hot D3cold
[    0.492939] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500
[    0.493189] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100
[    0.493413] pci 0000:00:18.0: [1022:15e8] type 00 class 0x060000
[    0.493509] pci 0000:00:18.1: [1022:15e9] type 00 class 0x060000
[    0.493593] pci 0000:00:18.2: [1022:15ea] type 00 class 0x060000
[    0.493692] pci 0000:00:18.3: [1022:15eb] type 00 class 0x060000
[    0.493775] pci 0000:00:18.4: [1022:15ec] type 00 class 0x060000
[    0.493859] pci 0000:00:18.5: [1022:15ed] type 00 class 0x060000
[    0.493944] pci 0000:00:18.6: [1022:15ee] type 00 class 0x060000
[    0.494027] pci 0000:00:18.7: [1022:15ef] type 00 class 0x060000
[    0.494256] pci 0000:01:00.0: [10ec:522a] type 00 class 0xff0000
[    0.494298] pci 0000:01:00.0: reg 0x10: [mem 0xfe300000-0xfe300fff]
[    0.494483] pci 0000:01:00.0: supports D1 D2
[    0.494485] pci 0000:01:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.494750] pci 0000:00:01.6: PCI bridge to [bus 01]
[    0.494760] pci 0000:00:01.6:   bridge window [mem 0xfe300000-0xfe3fffff]
[    0.494903] pci 0000:02:00.0: [10ec:b822] type 00 class 0x028000
[    0.494953] pci 0000:02:00.0: reg 0x10: [io  0xf000-0xf0ff]
[    0.494998] pci 0000:02:00.0: reg 0x18: [mem 0xfe200000-0xfe20ffff 64bit]
[    0.495207] pci 0000:02:00.0: supports D1 D2
[    0.495209] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.495543] pci 0000:00:01.7: PCI bridge to [bus 02]
[    0.495550] pci 0000:00:01.7:   bridge window [io  0xf000-0xffff]
[    0.495554] pci 0000:00:01.7:   bridge window [mem 0xfe200000-0xfe2fffff]
[    0.495714] pci 0000:03:00.0: [1002:15dd] type 00 class 0x030000
[    0.495762] pci 0000:03:00.0: reg 0x10: [mem 0xe0000000-0xefffffff 64bit
pref]
[    0.495783] pci 0000:03:00.0: reg 0x18: [mem 0xf0000000-0xf01fffff 64bit
pref]
[    0.495796] pci 0000:03:00.0: reg 0x20: [io  0xe000-0xe0ff]
[    0.495810] pci 0000:03:00.0: reg 0x24: [mem 0xfe000000-0xfe07ffff]
[    0.495832] pci 0000:03:00.0: enabling Extended Tags
[    0.495940] pci 0000:03:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.496099] pci 0000:03:00.1: [1002:15de] type 00 class 0x040300
[    0.496131] pci 0000:03:00.1: reg 0x10: [mem 0xfe088000-0xfe08bfff]
[    0.496210] pci 0000:03:00.1: enabling Extended Tags
[    0.496284] pci 0000:03:00.1: PME# supported from D1 D2 D3hot D3cold
[    0.496394] pci 0000:03:00.2: [1022:15df] type 00 class 0x108000
[    0.496449] pci 0000:03:00.2: reg 0x18: [mem 0xfdf00000-0xfdffffff]
[    0.496485] pci 0000:03:00.2: reg 0x24: [mem 0xfe08c000-0xfe08dfff]
[    0.496507] pci 0000:03:00.2: enabling Extended Tags
[    0.496684] pci 0000:03:00.3: [1022:15e0] type 00 class 0x0c0330
[    0.496723] pci 0000:03:00.3: reg 0x10: [mem 0xfde00000-0xfdefffff 64bit]
[    0.496790] pci 0000:03:00.3: enabling Extended Tags
[    0.496872] pci 0000:03:00.3: PME# supported from D0 D3hot D3cold
[    0.496982] pci 0000:03:00.4: [1022:15e1] type 00 class 0x0c0330
[    0.497021] pci 0000:03:00.4: reg 0x10: [mem 0xfdd00000-0xfddfffff 64bit]
[    0.497088] pci 0000:03:00.4: enabling Extended Tags
[    0.497169] pci 0000:03:00.4: PME# supported from D0 D3hot D3cold
[    0.497280] pci 0000:03:00.6: [1022:15e3] type 00 class 0x040300
[    0.497312] pci 0000:03:00.6: reg 0x10: [mem 0xfe080000-0xfe087fff]
[    0.497391] pci 0000:03:00.6: enabling Extended Tags
[    0.497464] pci 0000:03:00.6: PME# supported from D0 D3hot D3cold
[    0.497610] pci 0000:00:08.1: PCI bridge to [bus 03]
[    0.497616] pci 0000:00:08.1:   bridge window [io  0xe000-0xefff]
[    0.497620] pci 0000:00:08.1:   bridge window [mem 0xfdd00000-0xfe0fffff]
[    0.497627] pci 0000:00:08.1:   bridge window [mem 0xe0000000-0xf01fffff
64bit pref]
[    0.497737] pci 0000:04:00.0: [1022:7901] type 00 class 0x010601
[    0.497828] pci 0000:04:00.0: reg 0x24: [mem 0xfe100000-0xfe1007ff]
[    0.497850] pci 0000:04:00.0: enabling Extended Tags
[    0.497932] pci 0000:04:00.0: PME# supported from D3hot D3cold
[    0.498052] pci 0000:00:08.2: PCI bridge to [bus 04]
[    0.498061] pci 0000:00:08.2:   bridge window [mem 0xfe100000-0xfe1fffff]
[    0.498527] ACPI: IRQ 7 override to edge, high
[    0.498689] ACPI: PCI Interrupt Link [LNKA] (IRQs 4 5 7 10 11 14 15) *0
[    0.498802] ACPI: PCI Interrupt Link [LNKB] (IRQs 4 5 7 10 11 14 15) *0
[    0.498900] ACPI: PCI Interrupt Link [LNKC] (IRQs 4 5 7 10 11 14 15) *0
[    0.499016] ACPI: PCI Interrupt Link [LNKD] (IRQs 4 5 7 10 11 14 15) *0
[    0.499123] ACPI: PCI Interrupt Link [LNKE] (IRQs 4 5 7 10 11 14 15) *0
[    0.499206] ACPI: PCI Interrupt Link [LNKF] (IRQs 4 5 7 10 11 14 15) *0
[    0.499289] ACPI: PCI Interrupt Link [LNKG] (IRQs 4 5 7 10 11 14 15) *0
[    0.499372] ACPI: PCI Interrupt Link [LNKH] (IRQs 4 5 7 10 11 14 15) *0
[    0.500594] ACPI: EC: interrupt unblocked
[    0.500625] ACPI: EC: event unblocked
[    0.500646] ACPI: \_SB_.PCI0.SBRG.EC0_: GPE=0x3, EC_CMD/EC_SC=0x66,
EC_DATA=0x62
[    0.500648] ACPI: \_SB_.PCI0.SBRG.EC0_: Used as boot DSDT EC to handle
transactions and events
[    0.503358] pci 0000:03:00.0: vgaarb: setting as boot VGA device
[    0.503362] pci 0000:03:00.0: vgaarb: VGA device added:
decodes=io+mem,owns=io+mem,locks=none
[    0.503365] pci 0000:03:00.0: vgaarb: bridge control possible
[    0.503366] vgaarb: loaded
[    0.505741] pps_core: LinuxPPS API ver. 1 registered
[    0.505741] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo
Giometti <giometti-k2GhghHVRtY@public.gmane.org>
[    0.505741] PTP clock support registered
[    0.505741] EDAC MC: Ver: 3.0.0
[    0.506733] PCI: Using ACPI for IRQ routing
[    0.510850] PCI: pci_cache_line_size set to 64 bytes
[    0.511073] Expanded resource Reserved due to conflict with PCI Bus
0000:00
[    0.511076] e820: reserve RAM buffer [mem 0x0009d400-0x0009ffff]
[    0.511078] e820: reserve RAM buffer [mem 0x09ea0000-0x0bffffff]
[    0.511079] e820: reserve RAM buffer [mem 0xccfab000-0xcfffffff]
[    0.511080] e820: reserve RAM buffer [mem 0xcf000000-0xcfffffff]
[    0.511081] e820: reserve RAM buffer [mem 0x51f340000-0x51fffffff]
[    0.511240] NetLabel: Initializing
[    0.511241] NetLabel:  domain hash size = 128
[    0.511241] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.511258] NetLabel:  unlabeled traffic allowed by default
[    0.511263] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.511263] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.515621] clocksource: Switched to clocksource tsc-early
[    0.530866] VFS: Disk quotas dquot_6.6.0
[    0.530923] VFS: Dquot-cache hash table entries: 512 (order 0, 4096
bytes)
[    0.531072] pnp: PnP ACPI init
[    0.531316] system 00:00: [mem 0xf8000000-0xfbffffff] has been reserved
[    0.531323] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.531440] system 00:01: [mem 0xfeb80000-0xfebfffff] could not be
reserved
[    0.531444] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.531608] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.531723] pnp 00:03: Plug and Play ACPI device, IDs HPQ8001 PNP0303
(active)
[    0.531752] pnp 00:04: Plug and Play ACPI device, IDs SYN324e ETD0000
PNP0f13 (active)
[    0.532131] system 00:05: [io  0x04d0-0x04d1] has been reserved
[    0.532134] system 00:05: [io  0x040b] has been reserved
[    0.532135] system 00:05: [io  0x04d6] has been reserved
[    0.532137] system 00:05: [io  0x0c00-0x0c01] has been reserved
[    0.532139] system 00:05: [io  0x0c14] has been reserved
[    0.532149] system 00:05: [io  0x0c50-0x0c51] has been reserved
[    0.532151] system 00:05: [io  0x0c52] has been reserved
[    0.532153] system 00:05: [io  0x0c6c] has been reserved
[    0.532155] system 00:05: [io  0x0c6f] has been reserved
[    0.532156] system 00:05: [io  0x0cd0-0x0cd1] has been reserved
[    0.532158] system 00:05: [io  0x0cd2-0x0cd3] has been reserved
[    0.532160] system 00:05: [io  0x0cd4-0x0cd5] has been reserved
[    0.532162] system 00:05: [io  0x0cd6-0x0cd7] has been reserved
[    0.532163] system 00:05: [io  0x0cd8-0x0cdf] has been reserved
[    0.532165] system 00:05: [io  0x0800-0x089f] has been reserved
[    0.532167] system 00:05: [io  0x0b00-0x0b0f] has been reserved
[    0.532168] system 00:05: [io  0x0b20-0x0b3f] has been reserved
[    0.532170] system 00:05: [io  0x0900-0x090f] has been reserved
[    0.532172] system 00:05: [io  0x0910-0x091f] has been reserved
[    0.532175] system 00:05: [mem 0xfec00000-0xfec00fff] could not be
reserved
[    0.532177] system 00:05: [mem 0xfec01000-0xfec01fff] could not be
reserved
[    0.532179] system 00:05: [mem 0xfedc0000-0xfedc0fff] has been reserved
[    0.532181] system 00:05: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.532183] system 00:05: [mem 0xfed80000-0xfed8ffff] could not be
reserved
[    0.532185] system 00:05: [mem 0xfec10000-0xfec10fff] has been reserved
[    0.532187] system 00:05: [mem 0xff000000-0xffffffff] has been reserved
[    0.532191] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.532918] pnp: PnP ACPI: found 6 devices
[    0.544268] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff,
max_idle_ns: 2085701024 ns
[    0.544287] pci 0000:00:01.6: bridge window [io  0x1000-0x0fff] to [bus
01] add_size 1000
[    0.544290] pci 0000:00:01.6: bridge window [mem 0x00100000-0x000fffff
64bit pref] to [bus 01] add_size 200000 add_align 100000
[    0.544326] pci 0000:00:01.6: BAR 15: assigned [mem
0xf0200000-0xf03fffff 64bit pref]
[    0.544331] pci 0000:00:01.6: BAR 13: assigned [io  0x1000-0x1fff]
[    0.544333] pci 0000:00:01.6: PCI bridge to [bus 01]
[    0.544336] pci 0000:00:01.6:   bridge window [io  0x1000-0x1fff]
[    0.544342] pci 0000:00:01.6:   bridge window [mem 0xfe300000-0xfe3fffff]
[    0.544347] pci 0000:00:01.6:   bridge window [mem 0xf0200000-0xf03fffff
64bit pref]
[    0.544354] pci 0000:00:01.7: PCI bridge to [bus 02]
[    0.544357] pci 0000:00:01.7:   bridge window [io  0xf000-0xffff]
[    0.544363] pci 0000:00:01.7:   bridge window [mem 0xfe200000-0xfe2fffff]
[    0.544374] pci 0000:00:08.1: PCI bridge to [bus 03]
[    0.544377] pci 0000:00:08.1:   bridge window [io  0xe000-0xefff]
[    0.544382] pci 0000:00:08.1:   bridge window [mem 0xfdd00000-0xfe0fffff]
[    0.544386] pci 0000:00:08.1:   bridge window [mem 0xe0000000-0xf01fffff
64bit pref]
[    0.544394] pci 0000:00:08.2: PCI bridge to [bus 04]
[    0.544400] pci 0000:00:08.2:   bridge window [mem 0xfe100000-0xfe1fffff]
[    0.544411] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    0.544413] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
[    0.544414] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
[    0.544416] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    0.544418] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff
window]
[    0.544419] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff
window]
[    0.544421] pci_bus 0000:00: resource 10 [mem 0xe0000000-0xfebfffff
window]
[    0.544422] pci_bus 0000:00: resource 11 [mem 0xfee00000-0xffffffff
window]
[    0.544424] pci_bus 0000:01: resource 0 [io  0x1000-0x1fff]
[    0.544426] pci_bus 0000:01: resource 1 [mem 0xfe300000-0xfe3fffff]
[    0.544427] pci_bus 0000:01: resource 2 [mem 0xf0200000-0xf03fffff 64bit
pref]
[    0.544429] pci_bus 0000:02: resource 0 [io  0xf000-0xffff]
[    0.544431] pci_bus 0000:02: resource 1 [mem 0xfe200000-0xfe2fffff]
[    0.544432] pci_bus 0000:03: resource 0 [io  0xe000-0xefff]
[    0.544434] pci_bus 0000:03: resource 1 [mem 0xfdd00000-0xfe0fffff]
[    0.544435] pci_bus 0000:03: resource 2 [mem 0xe0000000-0xf01fffff 64bit
pref]
[    0.544437] pci_bus 0000:04: resource 1 [mem 0xfe100000-0xfe1fffff]
[    0.544681] NET: Registered protocol family 2
[    0.545002] tcp_listen_portaddr_hash hash table entries: 16384 (order:
6, 262144 bytes)
[    0.545117] TCP established hash table entries: 262144 (order: 9,
2097152 bytes)
[    0.545602] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.545767] TCP: Hash tables configured (established 262144 bind 65536)
[    0.545847] UDP hash table entries: 16384 (order: 7, 524288 bytes)
[    0.545950] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes)
[    0.546165] NET: Registered protocol family 1
[    0.546171] NET: Registered protocol family 44
[    0.546316] pci 0000:03:00.0: Video device with shadowed ROM at [mem
0x000c0000-0x000dffff]
[    0.546341] pci 0000:03:00.1: Linked as a consumer to 0000:03:00.0
[    0.546871] PCI: CLS 64 bytes, default 64
[    0.546934] Unpacking initramfs...
[    0.911016] Freeing initrd memory: 17360K
[    0.911052] AMD-Vi: Unable to write to IOMMU perf counter.
[    0.911200] pci 0000:00:00.2: can't derive routing for PCI INT A
[    0.911202] pci 0000:00:00.2: PCI INT A: not connected
[    0.911705] iommu: Adding device 0000:00:01.0 to group 0
[    0.911956] iommu: Adding device 0000:00:01.6 to group 1
[    0.912188] iommu: Adding device 0000:00:01.7 to group 2
[    0.912429] iommu: Adding device 0000:00:08.0 to group 3
[    0.912462] iommu: Adding device 0000:00:08.1 to group 3
[    0.912493] iommu: Adding device 0000:00:08.2 to group 3
[    0.912709] iommu: Adding device 0000:00:14.0 to group 4
[    0.912753] iommu: Adding device 0000:00:14.3 to group 4
[    0.913001] iommu: Adding device 0000:00:18.0 to group 5
[    0.913072] iommu: Adding device 0000:00:18.1 to group 5
[    0.913104] iommu: Adding device 0000:00:18.2 to group 5
[    0.913136] iommu: Adding device 0000:00:18.3 to group 5
[    0.913169] iommu: Adding device 0000:00:18.4 to group 5
[    0.913205] iommu: Adding device 0000:00:18.5 to group 5
[    0.913237] iommu: Adding device 0000:00:18.6 to group 5
[    0.913268] iommu: Adding device 0000:00:18.7 to group 5
[    0.913542] iommu: Adding device 0000:01:00.0 to group 6
[    0.913834] iommu: Adding device 0000:02:00.0 to group 7
[    0.913922] iommu: Adding device 0000:03:00.0 to group 3
[    0.914008] iommu: Adding device 0000:03:00.1 to group 3
[    0.914077] iommu: Adding device 0000:03:00.2 to group 3
[    0.914145] iommu: Adding device 0000:03:00.3 to group 3
[    0.914214] iommu: Adding device 0000:03:00.4 to group 3
[    0.914284] iommu: Adding device 0000:03:00.6 to group 3
[    0.914355] iommu: Adding device 0000:04:00.0 to group 3
[    0.914669] AMD-Vi: Found IOMMU at 0000:00:00.2 cap 0x40
[    0.914671] AMD-Vi: Extended features (0xf77ef22294ada):
[    0.914671]  PPR NX GT IA GA PC GA_vAPIC
[    0.914675] AMD-Vi: Interrupt remapping enabled
[    0.914676] AMD-Vi: virtual APIC enabled
[    1.010883] AMD-Vi: Lazy IO/TLB flushing enabled
[    1.012398] amd_uncore: AMD NB counters detected
[    1.012403] amd_uncore: AMD LLC counters detected
[    1.013727] Scanning for low memory corruption every 60 seconds
[    1.015077] Initialise system trusted keyrings
[    1.015136] Key type blacklist registered
[    1.015279] workingset: timestamp_bits=41 max_order=23 bucket_order=0
[    1.017304] zbud: loaded
[    1.017688] pstore: using lz4hc compression
[    1.022492] Key type asymmetric registered
[    1.022494] Asymmetric key parser 'x509' registered
[    1.022571] Block layer SCSI generic (bsg) driver version 0.4 loaded
(major 245)
[    1.022738] io scheduler noop registered
[    1.022740] io scheduler deadline registered
[    1.022870] io scheduler cfq registered (default)
[    1.022871] io scheduler mq-deadline registered
[    1.022872] io scheduler kyber registered
[    1.022933] io scheduler bfq registered
[    1.024743] pcieport 0000:00:01.6: Signaling PME with IRQ 26
[    1.024776] pcieport 0000:00:01.7: Signaling PME with IRQ 27
[    1.024820] pcieport 0000:00:08.1: Signaling PME with IRQ 28
[    1.024857] pcieport 0000:00:08.2: Signaling PME with IRQ 29
[    1.024888] pciehp 0000:00:01.6:pcie004: Slot #0 AttnBtn- PwrCtrl- MRL-
AttnInd- PwrInd- HotPlug+ Surprise- Interlock- NoCompl+ LLActRep+
[    1.024934] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    1.025017] vesafb: mode is 1920x1080x32, linelength=7680, pages=0
[    1.025018] vesafb: scrolling: redraw
[    1.025020] vesafb: Truecolor: size=0:8:8:8, shift=0:16:8:0
[    1.025036] vesafb: framebuffer at 0xe0000000, mapped to
0x(____ptrval____), using 8128k, total 8128k
[    1.117288] Console: switching to colour frame buffer device 240x67
[    1.167604] fb0: VESA VGA frame buffer device
[    1.167704] input: Power Button as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    1.167714] ACPI: Power Button [PWRB]
[    1.167765] input: Lid Switch as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input1
[    1.167771] ACPI: Lid Switch [LID0]
[    1.167823] input: Power Button as
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[    1.167839] ACPI: Power Button [PWRF]
[    1.167969] ACPI: Video Device [VGA2] (multi-head: yes  rom: no  post:
no)
[    1.168298] acpi device:16: registered as cooling_device0
[    1.168357] input: Video Bus as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:15/LNXVIDEO:02/input/input3
[    1.168406] Monitor-Mwait will be used to enter C-1 state
[    1.174071] thermal LNXTHERM:00: registered as thermal_zone0
[    1.174073] ACPI: Thermal Zone [TZS0] (54 C)
[    1.174580] thermal LNXTHERM:01: registered as thermal_zone1
[    1.174581] ACPI: Thermal Zone [TZS1] (49 C)
[    1.175186] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.177754] ledtrig-cpu: registered to indicate activity on CPUs
[    1.178519] NET: Registered protocol family 10
[    1.184065] Segment Routing with IPv6
[    1.184093] NET: Registered protocol family 17
[    1.185071] RAS: Correctable Errors collector initialized.
[    1.186575] microcode: CPU0: patch_level=0x08101007
[    1.186587] microcode: CPU1: patch_level=0x08101007
[    1.186591] microcode: CPU2: patch_level=0x08101007
[    1.186600] microcode: CPU3: patch_level=0x08101007
[    1.186914] microcode: CPU4: patch_level=0x08101007
[    1.186923] microcode: CPU5: patch_level=0x08101007
[    1.186948] microcode: CPU6: patch_level=0x08101007
[    1.186956] microcode: CPU7: patch_level=0x08101007
[    1.187070] microcode: Microcode Update Driver: v2.2.
[    1.187100] sched_clock: Marking stable (1187064456, 0)->(1382906531,
-195842075)
[    1.187642] registered taskstats version 1
[    1.187653] Loading compiled-in X.509 certificates
[    1.187682] zswap: loaded using pool lzo/zbud
[    1.192243] Key type big_key registered
[    1.192907]   Magic number: 14:303:953
[    1.192989] memory memory6: hash matches
[    1.192995] hctosys: unable to open rtc device (rtc0)
[    1.587197] Freeing unused kernel memory: 1488K
[    1.587199] Write protecting the kernel read-only data: 16384k
[    1.589231] Freeing unused kernel memory: 2016K
[    1.591200] Freeing unused kernel memory: 568K
[    1.693784] i8042: PNP: PS/2 Controller [PNP0303:KBD0,PNP0f13:PS2M] at
0x60,0x64 irq 1,12
[    1.700440] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.700528] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.702175] cryptd: max_cpu_qlen set to 1000
[    1.705654] ACPI: bus type USB registered
[    1.705698] usbcore: registered new interface driver usbfs
[    1.705711] usbcore: registered new interface driver hub
[    1.705782] usbcore: registered new device driver usb
[    1.706708] AVX2 version of gcm_enc/dec engaged.
[    1.706711] AES CTR mode by8 optimization enabled
[    1.707948] SCSI subsystem initialized
[    1.713077] xhci_hcd 0000:03:00.3: xHCI Host Controller
[    1.713087] xhci_hcd 0000:03:00.3: new USB bus registered, assigned bus
number 1
[    1.713279] xhci_hcd 0000:03:00.3: hcc params 0x0270ffe5 hci version
0x110 quirks 0x0000000040000410
[    1.714026] usb usb1: New USB device found, idVendor=1d6b,
idProduct=0002, bcdDevice= 4.18
[    1.714028] usb usb1: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    1.714030] usb usb1: Product: xHCI Host Controller
[    1.714031] usb usb1: Manufacturer: Linux 4.18.1-arch1-1-ARCH xhci-hcd
[    1.714033] usb usb1: SerialNumber: 0000:03:00.3
[    1.714230] hub 1-0:1.0: USB hub found
[    1.714250] hub 1-0:1.0: 4 ports detected
[    1.714320] libata version 3.00 loaded.
[    1.715393] xhci_hcd 0000:03:00.3: xHCI Host Controller
[    1.715403] xhci_hcd 0000:03:00.3: new USB bus registered, assigned bus
number 2
[    1.715410] xhci_hcd 0000:03:00.3: Host supports USB 3.10 Enhanced
SuperSpeed
[    1.715440] usb usb2: We don't know the algorithms for LPM for this
host, disabling LPM.
[    1.715470] usb usb2: New USB device found, idVendor=1d6b,
idProduct=0003, bcdDevice= 4.18
[    1.715472] usb usb2: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    1.715474] usb usb2: Product: xHCI Host Controller
[    1.715476] usb usb2: Manufacturer: Linux 4.18.1-arch1-1-ARCH xhci-hcd
[    1.715478] usb usb2: SerialNumber: 0000:03:00.3
[    1.715676] hub 2-0:1.0: USB hub found
[    1.715693] hub 2-0:1.0: 4 ports detected
[    1.716382] ahci 0000:04:00.0: version 3.0
[    1.716998] xhci_hcd 0000:03:00.4: xHCI Host Controller
[    1.717004] xhci_hcd 0000:03:00.4: new USB bus registered, assigned bus
number 3
[    1.717143] xhci_hcd 0000:03:00.4: hcc params 0x0260ffe5 hci version
0x110 quirks 0x0000000040000410
[    1.717762] usb usb3: New USB device found, idVendor=1d6b,
idProduct=0002, bcdDevice= 4.18
[    1.717764] usb usb3: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    1.717765] usb usb3: Product: xHCI Host Controller
[    1.717767] usb usb3: Manufacturer: Linux 4.18.1-arch1-1-ARCH xhci-hcd
[    1.717768] usb usb3: SerialNumber: 0000:03:00.4
[    1.718003] hub 3-0:1.0: USB hub found
[    1.718023] hub 3-0:1.0: 2 ports detected
[    1.718718] xhci_hcd 0000:03:00.4: xHCI Host Controller
[    1.718724] xhci_hcd 0000:03:00.4: new USB bus registered, assigned bus
number 4
[    1.718729] xhci_hcd 0000:03:00.4: Host supports USB 3.10 Enhanced
SuperSpeed
[    1.718758] usb usb4: We don't know the algorithms for LPM for this
host, disabling LPM.
[    1.718793] usb usb4: New USB device found, idVendor=1d6b,
idProduct=0003, bcdDevice= 4.18
[    1.718796] usb usb4: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    1.718798] usb usb4: Product: xHCI Host Controller
[    1.718800] usb usb4: Manufacturer: Linux 4.18.1-arch1-1-ARCH xhci-hcd
[    1.718802] usb usb4: SerialNumber: 0000:03:00.4
[    1.719007] hub 4-0:1.0: USB hub found
[    1.719029] hub 4-0:1.0: 1 port detected
[    1.727051] ahci 0000:04:00.0: AHCI 0001.0301 32 slots 2 ports 6 Gbps
0x3 impl SATA mode
[    1.727056] ahci 0000:04:00.0: flags: 64bit ncq sntf ilck pm led clo
only pmp fbs pio slum part deso sadm sds
[    1.727060] ahci 0000:04:00.0: both AHCI_HFLAG_MULTI_MSI flag set and
custom irq handler implemented
[    1.727653] scsi host0: ahci
[    1.728020] scsi host1: ahci
[    1.728091] ata1: SATA max UDMA/133 abar m2048@0xfe100000 port
0xfe100100 irq 42
[    1.728095] ata2: SATA max UDMA/133 abar m2048@0xfe100000 port
0xfe100180 irq 43
[    1.732184] input: AT Translated Set 2 keyboard as
/devices/platform/i8042/serio0/input/input4
[    2.023780] tsc: Refined TSC clocksource calibration: 1996.241 MHz
[    2.023798] clocksource: tsc: mask: 0xffffffffffffffff max_cycles:
0x398c9e7ced1, max_idle_ns: 881590497691 ns
[    2.024830] clocksource: Switched to clocksource tsc
[    2.043386] usb 1-4: new high-speed USB device number 2 using xhci_hcd
[    2.046708] usb 3-2: new high-speed USB device number 2 using xhci_hcd
[    2.189006] usb 3-2: New USB device found, idVendor=05e3,
idProduct=0608, bcdDevice=88.32
[    2.189009] usb 3-2: New USB device strings: Mfr=0, Product=1,
SerialNumber=0
[    2.189011] usb 3-2: Product: USB2.0 Hub
[    2.196740] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    2.196782] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    2.197553] ata1.00: ATA-9: WDC WDS240G2G0B-00EPW0, UJ190000, max
UDMA/133
[    2.197557] ata1.00: 468877312 sectors, multi 1: LBA48 NCQ (depth 32)
[    2.199116] ata2.00: ATA-9: HGST HTS721010A9E630, JB0OA3T0, max UDMA/133
[    2.199119] ata2.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 32),
AA
[    2.201241] ata2.00: configured for UDMA/133
[    2.202935] ata1.00: configured for UDMA/133
[    2.203630] scsi 0:0:0:0: Direct-Access     ATA      WDC WDS240G2G0B-
0000 PQ: 0 ANSI: 5
[    2.204339] scsi 1:0:0:0: Direct-Access     ATA      HGST HTS721010A9
A3T0 PQ: 0 ANSI: 5
[    2.207091] sd 1:0:0:0: [sdb] 1953525168 512-byte logical blocks: (1.00
TB/932 GiB)
[    2.207093] sd 1:0:0:0: [sdb] 4096-byte physical blocks
[    2.207097] sd 0:0:0:0: [sda] 468877312 512-byte logical blocks: (240
GB/224 GiB)
[    2.207112] sd 0:0:0:0: [sda] Write Protect is off
[    2.207114] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.207117] sd 1:0:0:0: [sdb] Write Protect is off
[    2.207121] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    2.207141] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,
doesn't support DPO or FUA
[    2.207168] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled,
doesn't support DPO or FUA
[    2.207822]  sda: sda1 sda2
[    2.208207] sd 0:0:0:0: [sda] Attached SCSI disk
[    2.224862] usb 1-4: New USB device found, idVendor=04f2,
idProduct=b593, bcdDevice= 0.10
[    2.224865] usb 1-4: New USB device strings: Mfr=3, Product=1,
SerialNumber=2
[    2.224868] usb 1-4: Product: HP Wide Vision FHD Camera
[    2.224869] usb 1-4: Manufacturer: Chicony Electronics Co.,Ltd.
[    2.224871] usb 1-4: SerialNumber: 1
[    2.232069] hub 3-2:1.0: USB hub found
[    2.232528] hub 3-2:1.0: 4 ports detected
[    2.504296]  sdb: sdb1 sdb2 sdb3 sdb4 sdb5 sdb6
[    2.506059] sd 1:0:0:0: [sdb] Attached SCSI disk
[    2.523952] usb 3-2.3: new full-speed USB device number 3 using xhci_hcd
[    2.603357] raid6: sse2x1   gen()  4685 MB/s
[    2.638832] usb 3-2.3: New USB device found, idVendor=0483,
idProduct=91d1, bcdDevice= 1.11
[    2.638835] usb 3-2.3: New USB device strings: Mfr=1, Product=2,
SerialNumber=3
[    2.638838] usb 3-2.3: Product: ST_SENSOR_HUB
[    2.638840] usb 3-2.3: Manufacturer: STMicroelectronics
[    2.638842] usb 3-2.3: SerialNumber: ST_SENSOR_HUB
[    2.660009] raid6: sse2x1   xor()  4196 MB/s
[    2.683660] hidraw: raw HID events driver (C) Jiri Kosina
[    2.698867] usbcore: registered new interface driver usbhid
[    2.698868] usbhid: USB HID core driver
[    2.702700] hid-generic 0003:0483:91D1.0001: hiddev0,hidraw0: USB HID
v1.10 Device [STMicroelectronics ST_SENSOR_HUB] on
usb-0000:03:00.4-2.3/input0
[    2.716685] raid6: sse2x2   gen()  8136 MB/s
[    2.753354] usb 3-2.4: new full-speed USB device number 4 using xhci_hcd
[    2.773347] raid6: sse2x2   xor()  5703 MB/s
[    2.830018] raid6: sse2x4   gen()  9263 MB/s
[    2.850856] random: fast init done
[    2.865856] usb 3-2.4: New USB device found, idVendor=0bda,
idProduct=b00b, bcdDevice= 1.10
[    2.865859] usb 3-2.4: New USB device strings: Mfr=1, Product=2,
SerialNumber=3
[    2.865861] usb 3-2.4: Product: Bluetooth Radio
[    2.865863] usb 3-2.4: Manufacturer: Realtek
[    2.865865] usb 3-2.4: SerialNumber: 00e04c000001
[    2.886671] raid6: sse2x4   xor()  5370 MB/s
[    2.943341] raid6: avx2x1   gen() 10008 MB/s
[    3.000004] raid6: avx2x1   xor()  7566 MB/s
[    3.056676] raid6: avx2x2   gen() 12642 MB/s
[    3.113375] raid6: avx2x2   xor()  8141 MB/s
[    3.170007] raid6: avx2x4   gen() 13201 MB/s
[    3.226684] raid6: avx2x4   xor()  7591 MB/s
[    3.226686] raid6: using algorithm avx2x4 gen() 13201 MB/s
[    3.226686] raid6: .... xor() 7591 MB/s, rmw enabled
[    3.226688] raid6: using avx2x2 recovery algorithm
[    3.231400] xor: automatically using best checksumming function   avx

[    3.261457] Btrfs loaded, crc32c=crc32c-intel
[    3.262181] BTRFS: device label root devid 1 transid 138955 /dev/sda2
[    3.262245] BTRFS: device label ARQUIVOS devid 1 transid 1514 /dev/sdb6
[    3.286065] device-mapper: uevent: version 1.0.3
[    3.286930] device-mapper: ioctl: 4.39.0-ioctl (2018-04-03) initialised:
dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
[    3.326186] BTRFS info (device sda2): disk space caching is enabled
[    3.326188] BTRFS info (device sda2): has skinny extents
[    3.433912] BTRFS info (device sda2): enabling ssd optimizations
[    3.710486] systemd[1]: systemd 239 running in system mode. (+PAM -AUDIT
-SELINUX -IMA -APPARMOR +SMACK -SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT
+GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN +PCRE2
default-hierarchy=hybrid)
[    3.729359] systemd[1]: Detected architecture x86-64.
[    3.745495] systemd[1]: Set hostname to <braulio-laptop>.
[    3.904599] systemd[1]: /etc/systemd/system/rc-local.service:11: Support
for option SysVStartPriority= has been removed and it is ignored
[    3.908859] random: systemd: uninitialized urandom read (16 bytes read)
[    3.909004] systemd[1]: Listening on Journal Socket.
[    3.909802] random: systemd: uninitialized urandom read (16 bytes read)
[    3.909858] systemd[1]: Started Forward Password Requests to Wall
Directory Watch.
[    3.910816] random: systemd: uninitialized urandom read (16 bytes read)
[    3.910899] systemd[1]: Listening on udev Kernel Socket.
[    3.911721] systemd[1]: Listening on Journal Audit Socket.
[    3.912428] systemd[1]: Started Dispatch Password Requests to Console
Directory Watch.
[    3.913345] systemd[1]: Reached target Local Encrypted Volumes.
[    4.043824] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    4.043873] sd 1:0:0:0: Attached scsi generic sg1 type 0
[    4.058177] vboxdrv: loading out-of-tree module taints kernel.
[    4.066401] vboxdrv: Found 8 processor cores
[    4.087570] vboxdrv: TSC mode is Invariant, tentative frequency
1996214607 Hz
[    4.087572] vboxdrv: Successfully loaded version 5.2.18 (interface
0x00290001)
[    4.134788] VBoxPciLinuxInit
[    4.134793] vboxpci: IOMMU found
[    4.153543] VBoxNetAdp: Successfully started.
[    4.156063] VBoxNetFlt: Successfully started.
[    4.228852] BTRFS info (device sda2): use zstd compression, level 0
[    4.228857] BTRFS info (device sda2): turning on discard
[    4.228859] BTRFS info (device sda2): enabling auto defrag
[    4.228863] BTRFS info (device sda2): using default commit interval 30s
[    4.228866] BTRFS info (device sda2): disk space caching is enabled
[    4.462103] systemd-journald[326]: Received request to flush runtime
journal from PID 1
[    5.121602] acpi_cpufreq: overriding BIOS provided _PSD data
[    5.122273] input: HP Wireless hotkeys as /devices/virtual/input/input6
[    5.123288] amd_gpio AMDI0030:00: Failed to get gpio IRQ: -22
[    5.149916] amd_gpio: probe of AMDI0030:00 failed with error -22
[    5.150563] cmi: probe of SMB0001:00 failed with error -5
[    5.160559] rtc_cmos 00:02: RTC can wake from S4
[    5.160942] rtc_cmos 00:02: registered as rtc0
[    5.160985] rtc_cmos 00:02: alarms up to one month, y3k, 114 bytes
nvram, hpet irqs
[    5.168738] hp_accel: laptop model unknown, using default axes
configuration
[    5.176315] ACPI: AC Adapter [ADP1] (on-line)
[    5.177353] acpi PNP0C14:01: duplicate WMI GUID
05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:00)
[    5.198504] lis3lv02d: unknown sensor type 0x0
[    5.201864] ACPI: Battery Slot [BAT0] (battery present)
[    5.224865] hp_accel: probe of HPQ6007:00 failed with error -22
[    5.225183] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00,
revision 0
[    5.225185] piix4_smbus 0000:00:14.0: Using register 0x02 for SMBus port
selection
[    5.236121] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver
[    5.236277] sp5100-tco sp5100-tco: Using 0xfed80b00 for watchdog MMIO
address
[    5.236286] sp5100-tco sp5100-tco: Watchdog hardware is disabled
[    5.307238] Linux agpgart interface v0.103
[    5.352229] cfg80211: Loading compiled-in X.509 certificates for
regulatory database
[    5.373943] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    5.376409] platform regulatory.0: Direct firmware load for
regulatory.db failed with error -2
[    5.376415] cfg80211: failed to load regulatory.db
[    5.423514] kvm: Nested Virtualization enabled
[    5.423532] kvm: Nested Paging enabled
[    5.423533] SVM: Virtual VMLOAD VMSAVE supported
[    5.423534] SVM: Virtual GIF supported
[    5.430041] MCE: In-kernel MCE decoding enabled.
[    5.437041] EDAC amd64: Node 0: DRAM ECC disabled.
[    5.437044] EDAC amd64: ECC disabled in the BIOS or no ECC capability,
module will not load.
                Either enable ECC checking or force module loading by
setting 'ecc_enable_override'.
                (Note that use of the override may cause unknown side
effects.)
[    5.442151] snd_hda_intel 0000:03:00.1: Handle vga_switcheroo audio
client
[    5.459035] media: Linux media interface: v0.10
[    5.491789] input: HD-Audio Generic HDMI/DP,pcm=3 as
/devices/pci0000:00/0000:00:08.1/0000:03:00.1/sound/card0/input8
[    5.491931] input: HD-Audio Generic HDMI/DP,pcm=7 as
/devices/pci0000:00/0000:00:08.1/0000:03:00.1/sound/card0/input9
[    5.492125] snd_hda_codec_realtek hdaudioC1D0: autoconfig for ALC295:
line_outs=1 (0x17/0x0/0x0/0x0/0x0) type:speaker
[    5.492128] snd_hda_codec_realtek hdaudioC1D0:    speaker_outs=0
(0x0/0x0/0x0/0x0/0x0)
[    5.492130] snd_hda_codec_realtek hdaudioC1D0:    hp_outs=1
(0x21/0x0/0x0/0x0/0x0)
[    5.492132] snd_hda_codec_realtek hdaudioC1D0:    mono: mono_out=0x0
[    5.492133] snd_hda_codec_realtek hdaudioC1D0:    inputs:
[    5.492136] snd_hda_codec_realtek hdaudioC1D0:      Mic=0x19
[    5.492138] snd_hda_codec_realtek hdaudioC1D0:      Internal Mic=0x12
[    5.494688] random: crng init done
[    5.494690] random: 7 urandom warning(s) missed due to ratelimiting
[    5.535897] videodev: Linux video capture interface: v2.00
[    5.547522] input: HD-Audio Generic Mic as
/devices/pci0000:00/0000:00:08.1/0000:03:00.6/sound/card1/input10
[    5.547602] input: HD-Audio Generic Headphone as
/devices/pci0000:00/0000:00:08.1/0000:03:00.6/sound/card1/input11
[    5.550829] Bluetooth: Core ver 2.22
[    5.550858] NET: Registered protocol family 31
[    5.550860] Bluetooth: HCI device and connection manager initialized
[    5.550867] Bluetooth: HCI socket layer initialized
[    5.550871] Bluetooth: L2CAP socket layer initialized
[    5.550902] Bluetooth: SCO socket layer initialized
[    5.555966] ACPI Error: Field [D128] at bit offset/length 128/1024
exceeds size of target Buffer (160 bits) (20180531/dsopcode-201)
[    5.556313] r8822be: module is from the staging directory, the quality
is unknown, you have been warned.
[    5.568568] ACPI Error: Method parse/execution failed \HWMC,
AE_AML_BUFFER_LIMIT (20180531/psparse-516)
[    5.579798] ACPI Error: Method parse/execution failed \_SB.WMID.WMAA,
AE_AML_BUFFER_LIMIT (20180531/psparse-516)
[    5.580019] ACPI Error: Field [D128] at bit offset/length 128/1024
exceeds size of target Buffer (160 bits) (20180531/dsopcode-201)
[    5.604033] ACPI Error: Method parse/execution failed \HWMC,
AE_AML_BUFFER_LIMIT (20180531/psparse-516)
[    5.604059] ACPI Error: Method parse/execution failed \_SB.WMID.WMAA,
AE_AML_BUFFER_LIMIT (20180531/psparse-516)
[    5.604273] ACPI Error: Field [D128] at bit offset/length 128/1024
exceeds size of target Buffer (160 bits) (20180531/dsopcode-201)
[    5.604284] ACPI Error: Method parse/execution failed \HWMC,
AE_AML_BUFFER_LIMIT (20180531/psparse-516)
[    5.604298] ACPI Error: Method parse/execution failed \_SB.WMID.WMAA,
AE_AML_BUFFER_LIMIT (20180531/psparse-516)
[    5.604426] input: HP WMI hotkeys as /devices/virtual/input/input12
[    5.604991] ACPI Error: Field [D128] at bit offset/length 128/1024
exceeds size of target Buffer (160 bits) (20180531/dsopcode-201)
[    5.605029] ACPI Error: Method parse/execution failed \HWMC,
AE_AML_BUFFER_LIMIT (20180531/psparse-516)
[    5.605268] acer_wmi: Acer Laptop ACPI-WMI Extras
[    5.605275] acer_wmi: Unsupported machine has AMW0_GUID1, unable to load
[    5.605919] ACPI Error: Method parse/execution failed \_SB.WMID.WMAA,
AE_AML_BUFFER_LIMIT (20180531/psparse-516)
[    5.606195] ACPI Error: Field [D128] at bit offset/length 128/1024
exceeds size of target Buffer (160 bits) (20180531/dsopcode-201)
[    5.606211] ACPI Error: Method parse/execution failed \HWMC,
AE_AML_BUFFER_LIMIT (20180531/psparse-516)
[    5.606228] ACPI Error: Method parse/execution failed \_SB.WMID.WMAA,
AE_AML_BUFFER_LIMIT (20180531/psparse-516)
[    5.625595] r8822be: Using firmware rtlwifi/rtl8822befw.bin
[    5.795068] usbcore: registered new interface driver btusb
[    5.796265] ieee80211 phy0: Selected rate control algorithm 'rtl_rc'
[    5.797209] r8822be: rtlwifi: wireless switch is on
[    5.798127] Bluetooth: hci0: rtl: examining hci_ver=07 hci_rev=000b
lmp_ver=07 lmp_subver=8822
[    5.798131] Bluetooth: hci0: rtl: loading rtl_bt/rtl8822b_config.bin
[    5.798797] Bluetooth: hci0: rtl: loading rtl_bt/rtl8822b_fw.bin
[    5.798821] uvcvideo: Found UVC 1.00 device HP Wide Vision FHD Camera
(04f2:b593)
[    5.799878] r8822be 0000:02:00.0 wlp2s0: renamed from wlan0
[    5.802110] Bluetooth: hci0: rom_version status=0 version=2
[    5.802128] Bluetooth: hci0: cfg_sz 14, total size 20270
[    5.806923] uvcvideo 1-4:1.0: Entity type for entity Extension 4 was not
initialized!
[    5.806926] uvcvideo 1-4:1.0: Entity type for entity Processing 2 was
not initialized!
[    5.806928] uvcvideo 1-4:1.0: Entity type for entity Camera 1 was not
initialized!
[    5.807084] input: HP Wide Vision FHD Camera: HP W as
/devices/pci0000:00/0000:00:08.1/0000:03:00.3/usb1/1-4/1-4:1.0/input/input13
[    5.807774] uvcvideo: Found UVC 1.00 device HP Wide Vision FHD Camera
(04f2:b593)
[    5.809803] uvcvideo: Unable to create debugfs 1-2 directory.
[    5.810025] uvcvideo 1-4:1.2: Entity type for entity Extension 10 was
not initialized!
[    5.810029] uvcvideo 1-4:1.2: Entity type for entity Extension 12 was
not initialized!
[    5.810031] uvcvideo 1-4:1.2: Entity type for entity Processing 9 was
not initialized!
[    5.810033] uvcvideo 1-4:1.2: Entity type for entity Camera 11 was not
initialized!
[    5.810151] input: HP Wide Vision FHD Camera: HP I as
/devices/pci0000:00/0000:00:08.1/0000:03:00.3/usb1/1-4/1-4:1.2/input/input14
[    5.810338] usbcore: registered new interface driver uvcvideo
[    5.810339] USB Video Class driver (1.1.1)
[    5.854696] [drm] amdgpu kernel modesetting enabled.
[    5.864294] AMD IOMMUv2 driver by Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
[    5.882960] Parsing CRAT table with 1 nodes
[    5.882965] Ignoring ACPI CRAT on non-APU system
[    5.882976] Virtual CRAT table created for CPU
[    5.882977] Parsing CRAT table with 1 nodes
[    5.882978] Creating topology SYSFS entries
[    5.882992] Topology: Add CPU node
[    5.882993] Finished initializing topology
[    5.883079] kfd kfd: Initialized module
[    5.883552] checking generic (e0000000 7f0000) vs hw (e0000000 10000000)
[    5.883554] fb: switching to amdgpudrmfb from VESA VGA
[    5.883590] Console: switching to colour dummy device 80x25
[    5.884118] [drm] initializing kernel modesetting (RAVEN 0x1002:0x15DD
0x103C:0x83C6 0xC4).
[    5.884137] [drm] register mmio base: 0xFE000000
[    5.884138] [drm] register mmio size: 524288
[    5.884160] [drm] probing gen 2 caps for device 1022:15db = 700d03/e
[    5.884166] [drm] probing mlw for device 1022:15db = 700d03
[    5.884169] [drm] add ip block number 0 <soc15_common>
[    5.884170] [drm] add ip block number 1 <gmc_v9_0>
[    5.884172] [drm] add ip block number 2 <vega10_ih>
[    5.884173] [drm] add ip block number 3 <psp>
[    5.884174] [drm] add ip block number 4 <powerplay>
[    5.884175] [drm] add ip block number 5 <dm>
[    5.884176] [drm] add ip block number 6 <gfx_v9_0>
[    5.884177] [drm] add ip block number 7 <sdma_v4_0>
[    5.884178] [drm] add ip block number 8 <vcn_v1_0>
[    5.886483] kfd kfd: DID 15dd is missing in supported_devices
[    5.886487] kfd kfd: kgd2kfd_probe failed
[    5.886511] [drm] VCN decode is enabled in VM mode
[    5.886512] [drm] VCN encode is enabled in VM mode
[    5.915648] [drm] BIOS signature incorrect 0 0
[    5.915690] ATOM BIOS: SWBRT25890.001
[    5.915733] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit,
fragment size is 9-bit
[    5.915747] amdgpu 0000:03:00.0: VRAM: 256M 0x000000F400000000 -
0x000000F40FFFFFFF (256M used)
[    5.915749] amdgpu 0000:03:00.0: GTT: 1024M 0x000000F500000000 -
0x000000F53FFFFFFF
[    5.915754] [drm] Detected VRAM RAM=256M, BAR=256M
[    5.915755] [drm] RAM width 128bits UNKNOWN
[    5.916307] [TTM] Zone  kernel: Available graphics memory: 10159234 kiB
[    5.916309] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[    5.916310] [TTM] Initializing pool allocator
[    5.916316] [TTM] Initializing DMA pool allocator
[    5.916359] [drm] amdgpu: 256M of VRAM memory ready
[    5.916361] [drm] amdgpu: 3072M of GTT memory ready.
[    5.916377] [drm] GART: num cpu pages 262144, num gpu pages 262144
[    5.916630] [drm] PCIE GART of 1024M enabled (table at
0x000000F400900000).
[    5.932793] [drm] use_doorbell being set to: [true]
[    5.935374] [drm] Found VCN firmware Version: 1.73 Family ID: 18
[    6.015126] psmouse serio1: synaptics: queried max coordinates: x
[..5640], y [..4740]
[    6.042491] psmouse serio1: synaptics: queried min coordinates: x
[1302..], y [1116..]
[    6.042501] psmouse serio1: synaptics: Your touchpad (PNP: SYN324e
ETD0000 PNP0f13) says it can support a different bus. If i2c-hid and
hid-rmi are not used, you might want to try setting
psmouse.synaptics_intertouch to 1 and report this to
linux-input-u79uwXL29TaiAVqoAR/hOA@public.gmane.org
[    6.070325] BTRFS info (device sdb6): use zstd compression, level 0
[    6.070329] BTRFS info (device sdb6): enabling auto defrag
[    6.070333] BTRFS info (device sdb6): using default commit interval 30s
[    6.070337] BTRFS info (device sdb6): disk space caching is enabled
[    6.070339] BTRFS info (device sdb6): has skinny extents
[    6.094400] psmouse serio1: synaptics: Touchpad model: 1, fw: 8.2, id:
0x1e2b1, caps: 0xf00123/0x840300/0x12e800/0x400000, board id: 3314, fw id:
2544170
[    6.128063] input: SynPS/2 Synaptics TouchPad as
/devices/platform/i8042/serio1/input/input7
[    6.140472] mousedev: PS/2 mouse device common for all mice
[    6.196628] EXT4-fs (sda1): mounted filesystem with ordered data mode.
Opts: stripe=4
[    6.603711] amdgpu: [powerplay] dpm has been enabled
[    6.604078] [drm:construct [amdgpu]] *ERROR* construct: Invalid
Connector ObjectID from Adapter Service for connector index:2! type 0
expected 3
[    6.621349] [drm] Display Core initialized with v3.1.44!
[    6.627947] [drm] SADs count is: -2, don't need to read it
[    6.629081] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    6.629082] [drm] Driver supports precise vblank timestamp query.
[    6.653040] [drm] VCN decode and encode initialized successfully.
[    6.656014] [drm] fb mappable at 0xD1100000
[    6.656017] [drm] vram apper at 0xD0000000
[    6.656018] [drm] size 8294400
[    6.656019] [drm] fb depth is 24
[    6.656020] [drm]    pitch is 7680
[    6.656149] fbcon: amdgpudrmfb (fb0) is primary device
[    6.671592] Console: switching to colour frame buffer device 240x67
[    6.693572] amdgpu 0000:03:00.0: fb0: amdgpudrmfb frame buffer device
[    6.721247] amdgpu 0000:03:00.0: ring 0(gfx) uses VM inv eng 4 on hub 0
[    6.721251] amdgpu 0000:03:00.0: ring 1(comp_1.0.0) uses VM inv eng 5 on
hub 0
[    6.721254] amdgpu 0000:03:00.0: ring 2(comp_1.1.0) uses VM inv eng 6 on
hub 0
[    6.721256] amdgpu 0000:03:00.0: ring 3(comp_1.2.0) uses VM inv eng 7 on
hub 0
[    6.721258] amdgpu 0000:03:00.0: ring 4(comp_1.3.0) uses VM inv eng 8 on
hub 0
[    6.721260] amdgpu 0000:03:00.0: ring 5(comp_1.0.1) uses VM inv eng 9 on
hub 0
[    6.721263] amdgpu 0000:03:00.0: ring 6(comp_1.1.1) uses VM inv eng 10
on hub 0
[    6.721265] amdgpu 0000:03:00.0: ring 7(comp_1.2.1) uses VM inv eng 11
on hub 0
[    6.721267] amdgpu 0000:03:00.0: ring 8(comp_1.3.1) uses VM inv eng 12
on hub 0
[    6.721270] amdgpu 0000:03:00.0: ring 9(kiq_2.1.0) uses VM inv eng 13 on
hub 0
[    6.721272] amdgpu 0000:03:00.0: ring 10(sdma0) uses VM inv eng 4 on hub
1
[    6.721274] amdgpu 0000:03:00.0: ring 11(vcn_dec) uses VM inv eng 5 on
hub 1
[    6.721276] amdgpu 0000:03:00.0: ring 12(vcn_enc0) uses VM inv eng 6 on
hub 1
[    6.721279] amdgpu 0000:03:00.0: ring 13(vcn_enc1) uses VM inv eng 7 on
hub 1
[    6.725754] [drm] Initialized amdgpu 3.26.0 20150101 for 0000:03:00.0 on
minor 0
[    8.246458] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    8.246460] Bluetooth: BNEP filters: protocol multicast
[    8.246465] Bluetooth: BNEP socket layer initialized
[    9.870932] IPv6: ADDRCONF(NETDEV_UP): wlp2s0: link is not ready
[   10.472458] IPv6: ADDRCONF(NETDEV_UP): wlp2s0: link is not ready
[   10.472503] bridge: filtering via arp/ip/ip6tables is no longer
available by default. Update your scripts to load br_netfilter if you need
this.
[   10.946394] IPv6: ADDRCONF(NETDEV_UP): wlp2s0: link is not ready
[   10.947022] Bridge firewalling registered
[   11.044179] bpfilter: Loaded bpfilter_umh pid 859
[   11.049265] audit: type=1325 audit(1534539415.044:2): table=filter
family=2 entries=0
[   11.049591] audit: type=1300 audit(1534539415.044:2): arch=c000003e
syscall=175 success=yes exit=0 a0=55555577d8e0 a1=2308 a2=55555556fde6
a3=555555779010 items=0 ppid=348 pid=861 auid=4294967295 uid=0 gid=0 euid=0
suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295
comm="modprobe" exe="/usr/bin/kmod" key=(null)
[   11.049595] audit: type=1327 audit(1534539415.044:2):
proctitle=2F7362696E2F6D6F6470726F6265002D71002D2D0069707461626C655F66696C746572
[   11.074989] audit: type=1325 audit(1534539415.071:3): table=nat family=2
entries=0
[   11.075271] audit: type=1300 audit(1534539415.071:3): arch=c000003e
syscall=175 success=yes exit=0 a0=55555577e400 a1=21e8 a2=55555556fde6
a3=555555779010 items=0 ppid=89 pid=867 auid=4294967295 uid=0 gid=0 euid=0
suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295
comm="modprobe" exe="/usr/bin/kmod" key=(null)
[   11.075274] audit: type=1327 audit(1534539415.071:3):
proctitle=2F7362696E2F6D6F6470726F6265002D71002D2D0069707461626C655F6E6174
[   11.075295] IPv6: ADDRCONF(NETDEV_UP): wlp2s0: link is not ready
[   11.118283] audit: type=1325 audit(1534539415.114:4): table=nat family=2
entries=5
[   11.118290] audit: type=1300 audit(1534539415.114:4): arch=c000003e
syscall=54 success=yes exit=0 a0=4 a1=0 a2=40 a3=5555557d2a50 items=0
ppid=584 pid=896 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0
sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="iptables"
exe="/usr/bin/xtables-multi" key=(null)
[   11.118293] audit: type=1327 audit(1534539415.114:4):
proctitle=2F7573722F62696E2F69707461626C6573002D2D77616974002D74006E6174002D4E00444F434B4552
[   11.124243] audit: type=1325 audit(1534539415.121:5): table=filter
family=2 entries=4
[   11.559137] Initializing XFRM netlink socket
[   11.651373] IPv6: ADDRCONF(NETDEV_UP): docker0: link is not ready
[   11.753737] fuse init (API version 7.27)
[   16.329392] IPv6: ADDRCONF(NETDEV_UP): wlp2s0: link is not ready
[   16.345775] IPv6: ADDRCONF(NETDEV_UP): wlp2s0: link is not ready
[   16.819658] IPv6: ADDRCONF(NETDEV_UP): wlp2s0: link is not ready
[   18.032546] Bluetooth: RFCOMM TTY layer initialized
[   18.032554] Bluetooth: RFCOMM socket layer initialized
[   18.032561] Bluetooth: RFCOMM ver 1.11
[   19.991177] show_signal_msg: 116 callbacks suppressed
[   19.991183] core[1450]: segfault at 0 ip 0000000000441058 sp
00007fffffffd2f0 error 4
[   19.991187] Code: 40 00 31 c0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00
55 48 89 f5 53 48 89 fb 48 83 ec 08 e8 8f ec fd ff 89 c7 e8 f8 f0 fd ff
<48> 8b 30 48 89 ea 48 89 df e8 fa eb fd ff 48 83 c4 08 b8 01 00 00
[   19.991287] audit: type=1701 audit(1534539423.988:46): auid=1000
uid=1000 gid=1000 ses=2 pid=1450 comm="core" exe="/usr/bin/warsaw/core"
sig=11 res=1
[   44.165945] IPv6: ADDRCONF(NETDEV_UP): wlp2s0: link is not ready
[   47.429184] wlp2s0: authenticate with 64:66:b3:be:b5:b7
[   47.429620] wlp2s0: send auth to 64:66:b3:be:b5:b7 (try 1/3)
[   47.432430] wlp2s0: authenticated
[   47.432627] r8822be 0000:02:00.0 wlp2s0: disabling HT as WMM/QoS is not
supported by the AP
[   47.432631] r8822be 0000:02:00.0 wlp2s0: disabling VHT as WMM/QoS is not
supported by the AP
[   47.433353] wlp2s0: associate with 64:66:b3:be:b5:b7 (try 1/3)
[   47.462546] wlp2s0: RX AssocResp from 64:66:b3:be:b5:b7 (capab=0x431
status=0 aid=3)
[   47.462835] wlp2s0: associated
[   47.496430] IPv6: ADDRCONF(NETDEV_CHANGE): wlp2s0: link becomes ready
[   72.839833] SGI XFS with ACLs, security attributes, realtime, scrub, no
debug enabled
[   72.861991] JFS: nTxBlock = 8192, nTxLock = 65536
[   72.904797] ntfs: driver 2.1.32 [Flags: R/W MODULE].
[ 5898.208262] ------------[ cut here ]------------
[ 5898.208272] kernel BUG at drivers/dma-buf/reservation.c:234!
[ 5898.208305] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[ 5898.208314] CPU: 6 PID: 2988 Comm: chromium Tainted: G         C O
4.18.1-arch1-1-ARCH #1
[ 5898.208317] Hardware name: HP HP ENVY x360 Convertible 15m-bq1xx/83C6,
BIOS F.17 03/29/2018
[ 5898.208334] RIP: 0010:reservation_object_add_shared_fence+0x31b/0x370
[ 5898.208336] Code: ff 4c 89 7d 18 c7 45 10 01 00 00 00 e9 e2 fd ff ff e8
46 8c a8 ff e9 0c fe ff ff b8 18 00 00 00 ba 01 00 00 00 e9 c0 fd ff ff
<0f> 0b 8d 50 01 48 8d 04 c5 18 00 00 00 48 01 d8 45 31 f6 4c 89 38
[ 5898.208373] RSP: 0018:ffffa1b1ca9abb38 EFLAGS: 00010246
[ 5898.208377] RAX: 0000000000000004 RBX: ffff9236f1c71580 RCX:
0000000000000001
[ 5898.208380] RDX: 0000000000000001 RSI: ffff92371223da60 RDI:
ffff9236b196ba18
[ 5898.208382] RBP: 0000000000000000 R08: ffff9236bc7c3c80 R09:
ffff92374aba2378
[ 5898.208385] R10: ffff9237374cded8 R11: ffff9237374cdec8 R12:
ffff9236b196ba18
[ 5898.208387] R13: ffff9236b1ac0130 R14: ffff9236bfe3c000 R15:
ffff92371223da60
[ 5898.208390] FS:  00007fffe08c2180(0000) GS:ffff92374ab80000(0000)
knlGS:0000000000000000
[ 5898.208393] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 5898.208395] CR2: 0000265eadacf000 CR3: 00000004794e4000 CR4:
00000000003406e0
[ 5898.208398] Call Trace:
[ 5898.208519]  amdgpu_vm_update_directories+0x2a8/0x3e0 [amdgpu]
[ 5898.208582]  ? amdgpu_vm_prt_put+0x20/0x20 [amdgpu]
[ 5898.208639]  amdgpu_gem_va_ioctl+0x253/0x500 [amdgpu]
[ 5898.208693]  ? amdgpu_gem_metadata_ioctl+0x1b0/0x1b0 [amdgpu]
[ 5898.208715]  drm_ioctl_kernel+0xa7/0xf0 [drm]
[ 5898.208731]  drm_ioctl+0x30e/0x3c0 [drm]
[ 5898.208777]  ? amdgpu_gem_metadata_ioctl+0x1b0/0x1b0 [amdgpu]
[ 5898.208836]  amdgpu_drm_ioctl+0x49/0x80 [amdgpu]
[ 5898.208844]  do_vfs_ioctl+0xa4/0x620
[ 5898.208850]  ? syscall_slow_exit_work+0x19b/0x1b0
[ 5898.208855]  ksys_ioctl+0x60/0x90
[ 5898.208860]  __x64_sys_ioctl+0x16/0x20
[ 5898.208864]  do_syscall_64+0x5b/0x170
[ 5898.208871]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 5898.208875] RIP: 0033:0x7fffeeaa979b
[ 5898.208877] Code: 0f 1e fa 48 8b 05 c5 b6 0c 00 64 c7 00 26 00 00 00 48
c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05
<48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 95 b6 0c 00 f7 d8 64 89 01 48
[ 5898.208923] RSP: 002b:00007fffffffc578 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[ 5898.208927] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007fffeeaa979b
[ 5898.208929] RDX: 00007fffffffc5c0 RSI: 00000000c0286448 RDI:
000000000000000f
[ 5898.208931] RBP: 00007fffffffc5c0 R08: 0000000108ff0000 R09:
000000000000000e
[ 5898.208934] R10: 00000000000001c6 R11: 0000000000000246 R12:
00000000c0286448
[ 5898.208936] R13: 000000000000000f R14: 0000000000010000 R15:
000025e648c02a90
[ 5898.208940] Modules linked in: ufs hfsplus hfs minix ntfs vfat msdos fat
jfs xfs ccm rfcomm fuse ipt_MASQUERADE nf_conntrack_netlink nfnetlink
xfrm_user xfrm_algo iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4
nf_nat_ipv4 xt_addrtype iptable_filter bpfilter xt_conntrack nf_nat
nf_conntrack br_netfilter bridge stp llc bnep ext4 joydev mbcache mousedev
jbd2 fscrypto amdkfd amd_iommu_v2 arc4 amdgpu uvcvideo hid_sensor_rotation
hid_sensor_accel_3d btusb hid_sensor_magn_3d hid_sensor_incl_3d
hid_sensor_gyro_3d btrtl hid_sensor_trigger videobuf2_vmalloc
industrialio_triggered_buffer btbcm videobuf2_memops kfifo_buf r8822be(C)
btintel videobuf2_v4l2 hid_sensor_iio_common hp_wmi chash wmi_bmof
sparse_keymap videobuf2_common bluetooth gpu_sched industrialio
i2c_algo_bit videodev snd_hda_codec_realtek ttm ecdh_generic
[ 5898.209004]  snd_hda_codec_generic snd_hda_codec_hdmi crc16 mac80211
media drm_kms_helper snd_hda_intel edac_mce_amd snd_hda_codec kvm_amd drm
ccp snd_hda_core rng_core kvm snd_hwdep cfg80211 snd_pcm agpgart
syscopyarea psmouse sysfillrect snd_timer irqbypass k10temp input_leds snd
sysimgblt sp5100_tco rtsx_pci_ms rfkill memstick soundcore fb_sys_fops
i2c_piix4 wmi hp_accel battery ac rtc_cmos evdev lis3lv02d i2c_hid mac_hid
input_polldev led_class i2c_scmi pcc_cpufreq pinctrl_amd hp_wireless
acpi_cpufreq vboxnetflt(O) vboxnetadp(O) vboxpci(O) vboxdrv(O) msr sg
crypto_user ip_tables x_tables dm_crypt dm_mod btrfs libcrc32c
crc32c_generic xor zstd_decompress zstd_compress xxhash hid_sensor_hub
hid_generic usbhid hid raid6_pq sd_mod crct10dif_pclmul crc32_pclmul
crc32c_intel rtsx_pci_sdmmc ghash_clmulni_intel
[ 5898.209074]  serio_raw atkbd libps2 mmc_core pcbc ahci libahci xhci_pci
libata xhci_hcd aesni_intel aes_x86_64 crypto_simd cryptd glue_helper
usbcore scsi_mod usb_common rtsx_pci i8042 serio lz4 lz4_compress
[ 5898.209101] ---[ end trace 6c5f000032a0a21d ]---
[ 5898.209108] RIP: 0010:reservation_object_add_shared_fence+0x31b/0x370
[ 5898.209110] Code: ff 4c 89 7d 18 c7 45 10 01 00 00 00 e9 e2 fd ff ff e8
46 8c a8 ff e9 0c fe ff ff b8 18 00 00 00 ba 01 00 00 00 e9 c0 fd ff ff
<0f> 0b 8d 50 01 48 8d 04 c5 18 00 00 00 48 01 d8 45 31 f6 4c 89 38
[ 5898.209153] RSP: 0018:ffffa1b1ca9abb38 EFLAGS: 00010246
[ 5898.209156] RAX: 0000000000000004 RBX: ffff9236f1c71580 RCX:
0000000000000001
[ 5898.209159] RDX: 0000000000000001 RSI: ffff92371223da60 RDI:
ffff9236b196ba18
[ 5898.209161] RBP: 0000000000000000 R08: ffff9236bc7c3c80 R09:
ffff92374aba2378
[ 5898.209163] R10: ffff9237374cded8 R11: ffff9237374cdec8 R12:
ffff9236b196ba18
[ 5898.209165] R13: ffff9236b1ac0130 R14: ffff9236bfe3c000 R15:
ffff92371223da60
[ 5898.209168] FS:  00007fffe08c2180(0000) GS:ffff92374ab80000(0000)
knlGS:0000000000000000
[ 5898.209171] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 5898.209173] CR2: 0000265eadacf000 CR3: 00000004794e4000 CR4:
00000000003406e0
[ 5921.939945] audit: type=1006 audit(1534545327.725:47): pid=9656 uid=0
old-auid=4294967295 auid=1000 tty=tty2 old-ses=4294967295 ses=4 res=1

--0000000000001d5ee40573a93d81
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Chrome freezed and had to be killed, error on dmesg below.=
<div><br></div><div>Using AMD Ryzen 2500u<br><div><br></div><div><div>[=C2=
=A0 =C2=A0 0.000000] Linux version 4.18.1-arch1-1-ARCH (builduser@heftig-21=
694) (gcc version 8.2.0 (GCC)) #1 SMP PREEMPT Wed Aug 15 21:11:55 UTC 2018<=
/div><div>[=C2=A0 =C2=A0 0.000000] Command line: BOOT_IMAGE=3D/vmlinuz-linu=
x root=3DUUID=3D7bec7995-3557-480d-aee8-d9871405748d rw pci=3Dnoaer idle=3D=
nomwait</div><div>[=C2=A0 =C2=A0 0.000000] KERNEL supported cpus:</div><div=
>[=C2=A0 =C2=A0 0.000000]=C2=A0 =C2=A0Intel GenuineIntel</div><div>[=C2=A0 =
=C2=A0 0.000000]=C2=A0 =C2=A0AMD AuthenticAMD</div><div>[=C2=A0 =C2=A0 0.00=
0000]=C2=A0 =C2=A0Centaur CentaurHauls</div><div>[=C2=A0 =C2=A0 0.000000] x=
86/fpu: Supporting XSAVE feature 0x001: &#39;x87 floating point registers&#=
39;</div><div>[=C2=A0 =C2=A0 0.000000] x86/fpu: Supporting XSAVE feature 0x=
002: &#39;SSE registers&#39;</div><div>[=C2=A0 =C2=A0 0.000000] x86/fpu: Su=
pporting XSAVE feature 0x004: &#39;AVX registers&#39;</div><div>[=C2=A0 =C2=
=A0 0.000000] x86/fpu: xstate_offset[2]:=C2=A0 576, xstate_sizes[2]:=C2=A0 =
256</div><div>[=C2=A0 =C2=A0 0.000000] x86/fpu: Enabled xstate features 0x7=
, context size is 832 bytes, using &#39;compacted&#39; format.</div><div>[=
=C2=A0 =C2=A0 0.000000] BIOS-provided physical RAM map:</div><div>[=C2=A0 =
=C2=A0 0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009d3ff] usa=
ble</div><div>[=C2=A0 =C2=A0 0.000000] BIOS-e820: [mem 0x000000000009d400-0=
x000000000009ffff] reserved</div><div>[=C2=A0 =C2=A0 0.000000] BIOS-e820: [=
mem 0x00000000000e0000-0x00000000000fffff] reserved</div><div>[=C2=A0 =C2=
=A0 0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000003ffffff] usable=
</div><div>[=C2=A0 =C2=A0 0.000000] BIOS-e820: [mem 0x0000000004000000-0x00=
0000000400ffff] ACPI NVS</div><div>[=C2=A0 =C2=A0 0.000000] BIOS-e820: [mem=
 0x0000000004010000-0x0000000009e9ffff] usable</div><div>[=C2=A0 =C2=A0 0.0=
00000] BIOS-e820: [mem 0x0000000009ea0000-0x0000000009ffffff] reserved</div=
><div>[=C2=A0 =C2=A0 0.000000] BIOS-e820: [mem 0x000000000a000000-0x0000000=
0ccfaafff] usable</div><div>[=C2=A0 =C2=A0 0.000000] BIOS-e820: [mem 0x0000=
0000ccfab000-0x00000000cd096fff] reserved</div><div>[=C2=A0 =C2=A0 0.000000=
] BIOS-e820: [mem 0x00000000cd097000-0x00000000cd0c6fff] ACPI data</div><di=
v>[=C2=A0 =C2=A0 0.000000] BIOS-e820: [mem 0x00000000cd0c7000-0x00000000cd5=
9efff] ACPI NVS</div><div>[=C2=A0 =C2=A0 0.000000] BIOS-e820: [mem 0x000000=
00cd59f000-0x00000000cdd4bfff] reserved</div><div>[=C2=A0 =C2=A0 0.000000] =
BIOS-e820: [mem 0x00000000cdd4c000-0x00000000ceffffff] usable</div><div>[=
=C2=A0 =C2=A0 0.000000] BIOS-e820: [mem 0x00000000cf000000-0x00000000dfffff=
ff] reserved</div><div>[=C2=A0 =C2=A0 0.000000] BIOS-e820: [mem 0x00000000f=
8000000-0x00000000fbffffff] reserved</div><div>[=C2=A0 =C2=A0 0.000000] BIO=
S-e820: [mem 0x00000000fd800000-0x00000000fd8fffff] reserved</div><div>[=C2=
=A0 =C2=A0 0.000000] BIOS-e820: [mem 0x00000000fe800000-0x00000000fe800fff]=
 reserved</div><div>[=C2=A0 =C2=A0 0.000000] BIOS-e820: [mem 0x00000000feb8=
0000-0x00000000fec01fff] reserved</div><div>[=C2=A0 =C2=A0 0.000000] BIOS-e=
820: [mem 0x00000000fec10000-0x00000000fec10fff] reserved</div><div>[=C2=A0=
 =C2=A0 0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] re=
served</div><div>[=C2=A0 =C2=A0 0.000000] BIOS-e820: [mem 0x00000000fed4000=
0-0x00000000fed44fff] reserved</div><div>[=C2=A0 =C2=A0 0.000000] BIOS-e820=
: [mem 0x00000000fed80000-0x00000000fed8ffff] reserved</div><div>[=C2=A0 =
=C2=A0 0.000000] BIOS-e820: [mem 0x00000000fedc2000-0x00000000fedcffff] res=
erved</div><div>[=C2=A0 =C2=A0 0.000000] BIOS-e820: [mem 0x00000000fedd4000=
-0x00000000fedd5fff] reserved</div><div>[=C2=A0 =C2=A0 0.000000] BIOS-e820:=
 [mem 0x00000000fee00000-0x00000000feefffff] reserved</div><div>[=C2=A0 =C2=
=A0 0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserv=
ed</div><div>[=C2=A0 =C2=A0 0.000000] BIOS-e820: [mem 0x0000000100000000-0x=
000000051f33ffff] usable</div><div>[=C2=A0 =C2=A0 0.000000] NX (Execute Dis=
able) protection: active</div><div>[=C2=A0 =C2=A0 0.000000] SMBIOS 3.0.0 pr=
esent.</div><div>[=C2=A0 =C2=A0 0.000000] DMI: HP HP ENVY x360 Convertible =
15m-bq1xx/83C6, BIOS F.17 03/29/2018</div><div>[=C2=A0 =C2=A0 0.000000] e82=
0: update [mem 0x00000000-0x00000fff] usable =3D=3D&gt; reserved</div><div>=
[=C2=A0 =C2=A0 0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable</d=
iv><div>[=C2=A0 =C2=A0 0.000000] last_pfn =3D 0x51f340 max_arch_pfn =3D 0x4=
00000000</div><div>[=C2=A0 =C2=A0 0.000000] MTRR default type: uncachable</=
div><div>[=C2=A0 =C2=A0 0.000000] MTRR fixed ranges enabled:</div><div>[=C2=
=A0 =C2=A0 0.000000]=C2=A0 =C2=A000000-9FFFF write-back</div><div>[=C2=A0 =
=C2=A0 0.000000]=C2=A0 =C2=A0A0000-BFFFF write-through</div><div>[=C2=A0 =
=C2=A0 0.000000]=C2=A0 =C2=A0C0000-FFFFF write-protect</div><div>[=C2=A0 =
=C2=A0 0.000000] MTRR variable ranges enabled:</div><div>[=C2=A0 =C2=A0 0.0=
00000]=C2=A0 =C2=A00 base 000000000000 mask FFFF80000000 write-back</div><d=
iv>[=C2=A0 =C2=A0 0.000000]=C2=A0 =C2=A01 base 000080000000 mask FFFFC00000=
00 write-back</div><div>[=C2=A0 =C2=A0 0.000000]=C2=A0 =C2=A02 base 0000C00=
00000 mask FFFFE0000000 write-back</div><div>[=C2=A0 =C2=A0 0.000000]=C2=A0=
 =C2=A03 disabled</div><div>[=C2=A0 =C2=A0 0.000000]=C2=A0 =C2=A04 disabled=
</div><div>[=C2=A0 =C2=A0 0.000000]=C2=A0 =C2=A05 disabled</div><div>[=C2=
=A0 =C2=A0 0.000000]=C2=A0 =C2=A06 disabled</div><div>[=C2=A0 =C2=A0 0.0000=
00]=C2=A0 =C2=A07 disabled</div><div>[=C2=A0 =C2=A0 0.000000] TOM2: 0000000=
520000000 aka 20992M</div><div>[=C2=A0 =C2=A0 0.000000] x86/PAT: Configurat=
ion [0-7]: WB=C2=A0 WC=C2=A0 UC- UC=C2=A0 WB=C2=A0 WP=C2=A0 UC- WT=C2=A0=C2=
=A0</div><div>[=C2=A0 =C2=A0 0.000000] e820: update [mem 0xe0000000-0xfffff=
fff] usable =3D=3D&gt; reserved</div><div>[=C2=A0 =C2=A0 0.000000] last_pfn=
 =3D 0xcf000 max_arch_pfn =3D 0x400000000</div><div>[=C2=A0 =C2=A0 0.000000=
] Scanning 1 areas for low memory corruption</div><div>[=C2=A0 =C2=A0 0.000=
000] Base memory trampoline at [(____ptrval____)] 97000 size 24576</div><di=
v>[=C2=A0 =C2=A0 0.000000] Using GB pages for direct mapping</div><div>[=C2=
=A0 =C2=A0 0.000000] BRK [0x236676000, 0x236676fff] PGTABLE</div><div>[=C2=
=A0 =C2=A0 0.000000] BRK [0x236677000, 0x236677fff] PGTABLE</div><div>[=C2=
=A0 =C2=A0 0.000000] BRK [0x236678000, 0x236678fff] PGTABLE</div><div>[=C2=
=A0 =C2=A0 0.000000] BRK [0x236679000, 0x236679fff] PGTABLE</div><div>[=C2=
=A0 =C2=A0 0.000000] BRK [0x23667a000, 0x23667afff] PGTABLE</div><div>[=C2=
=A0 =C2=A0 0.000000] BRK [0x23667b000, 0x23667bfff] PGTABLE</div><div>[=C2=
=A0 =C2=A0 0.000000] BRK [0x23667c000, 0x23667cfff] PGTABLE</div><div>[=C2=
=A0 =C2=A0 0.000000] BRK [0x23667d000, 0x23667dfff] PGTABLE</div><div>[=C2=
=A0 =C2=A0 0.000000] BRK [0x23667e000, 0x23667efff] PGTABLE</div><div>[=C2=
=A0 =C2=A0 0.000000] BRK [0x23667f000, 0x23667ffff] PGTABLE</div><div>[=C2=
=A0 =C2=A0 0.000000] BRK [0x236680000, 0x236680fff] PGTABLE</div><div>[=C2=
=A0 =C2=A0 0.000000] RAMDISK: [mem 0x35e07000-0x36efafff]</div><div>[=C2=A0=
 =C2=A0 0.000000] ACPI: Early table checksum verification disabled</div><di=
v>[=C2=A0 =C2=A0 0.000000] ACPI: RSDP 0x00000000000F05B0 000024 (v02 HPQOEM=
)</div><div>[=C2=A0 =C2=A0 0.000000] ACPI: XSDT 0x00000000CD0A7090 00009C (=
v01 HPQOEM SLIC-MPC 01072009 HP=C2=A0 =C2=A000010013)</div><div>[=C2=A0 =C2=
=A0 0.000000] ACPI: FACP 0x00000000CD0BC1A0 000114 (v06 HPQOEM SLIC-MPC 010=
72009 HP=C2=A0 =C2=A000010013)</div><div>[=C2=A0 =C2=A0 0.000000] ACPI BIOS=
 Warning (bug): Optional FADT field Pm2ControlBlock has valid Length but ze=
ro Address: 0x0000000000000000/0x1 (20180531/tbfadt-624)</div><div>[=C2=A0 =
=C2=A0 0.000000] ACPI: DSDT 0x00000000CD0A71B8 014FE2 (v02 HPQOEM 83C6=C2=
=A0 =C2=A0 =C2=A001072009 ACPI 20120913)</div><div>[=C2=A0 =C2=A0 0.000000]=
 ACPI: FACS 0x00000000CD582F80 000040</div><div>[=C2=A0 =C2=A0 0.000000] AC=
PI: APIC 0x00000000CD0BC2B8 0000DE (v03 HPQOEM 83C6=C2=A0 =C2=A0 =C2=A00107=
2009 HP=C2=A0 =C2=A000010013)</div><div>[=C2=A0 =C2=A0 0.000000] ACPI: FPDT=
 0x00000000CD0BC398 000044 (v01 HPQOEM 83C6=C2=A0 =C2=A0 =C2=A001072009 HP=
=C2=A0 =C2=A000010013)</div><div>[=C2=A0 =C2=A0 0.000000] ACPI: FIDT 0x0000=
0000CD0BC3E0 00009C (v01 HPQOEM 83C6=C2=A0 =C2=A0 =C2=A001072009 HP=C2=A0 =
=C2=A000010013)</div><div>[=C2=A0 =C2=A0 0.000000] ACPI: SSDT 0x00000000CD0=
BC480 0051C4 (v02 HPQOEM 83C6=C2=A0 =C2=A0 =C2=A000000002 ACPI 04000000)</d=
iv><div>[=C2=A0 =C2=A0 0.000000] ACPI: MCFG 0x00000000CD0C1648 00003C (v01 =
HPQOEM 83C6=C2=A0 =C2=A0 =C2=A001072009 HP=C2=A0 =C2=A000010013)</div><div>=
[=C2=A0 =C2=A0 0.000000] ACPI: MSDM 0x00000000CD0C1688 000055 (v03 HPQOEM S=
LIC-MPC 00000001 HP=C2=A0 =C2=A000010013)</div><div>[=C2=A0 =C2=A0 0.000000=
] ACPI: SSDT 0x00000000CD0C16E0 00119C (v01 HPQOEM 83C6=C2=A0 =C2=A0 =C2=A0=
00000001 ACPI 00000001)</div><div>[=C2=A0 =C2=A0 0.000000] ACPI: CRAT 0x000=
00000CD0C2880 000838 (v01 HPQOEM 83C6=C2=A0 =C2=A0 =C2=A000000001 HP=C2=A0 =
=C2=A000000001)</div><div>[=C2=A0 =C2=A0 0.000000] ACPI: CDIT 0x00000000CD0=
C30B8 000029 (v01 HPQOEM 83C6=C2=A0 =C2=A0 =C2=A000000001 HP=C2=A0 =C2=A000=
000001)</div><div>[=C2=A0 =C2=A0 0.000000] ACPI: HPET 0x00000000CD0C30E8 00=
0038 (v01 HPQOEM 83C6=C2=A0 =C2=A0 =C2=A001072009 HP=C2=A0 =C2=A000000005)<=
/div><div>[=C2=A0 =C2=A0 0.000000] ACPI: UEFI 0x00000000CD0C3120 000042 (v0=
1 HPQOEM 83C6=C2=A0 =C2=A0 =C2=A000000000 HP=C2=A0 =C2=A000000000)</div><di=
v>[=C2=A0 =C2=A0 0.000000] ACPI: IVRS 0x00000000CD0C3168 0000D0 (v02 HPQOEM=
 83C6=C2=A0 =C2=A0 =C2=A000000001 HP=C2=A0 =C2=A000000000)</div><div>[=C2=
=A0 =C2=A0 0.000000] ACPI: SSDT 0x00000000CD0C3238 001676 (v01 HPQOEM 83C6=
=C2=A0 =C2=A0 =C2=A000000001 ACPI 20120913)</div><div>[=C2=A0 =C2=A0 0.0000=
00] ACPI: SSDT 0x00000000CD0C48B0 0018E2 (v01 HPQOEM 83C6=C2=A0 =C2=A0 =C2=
=A000000001 ACPI 20120913)</div><div>[=C2=A0 =C2=A0 0.000000] ACPI: Local A=
PIC address 0xfee00000</div><div>[=C2=A0 =C2=A0 0.000000] No NUMA configura=
tion found</div><div>[=C2=A0 =C2=A0 0.000000] Faking a node at [mem 0x00000=
00000000000-0x000000051f33ffff]</div><div>[=C2=A0 =C2=A0 0.000000] NODE_DAT=
A(0) allocated [mem 0x51f33c000-0x51f33ffff]</div><div>[=C2=A0 =C2=A0 0.000=
000] tsc: Fast TSC calibration using PIT</div><div>[=C2=A0 =C2=A0 0.000000]=
 Zone ranges:</div><div>[=C2=A0 =C2=A0 0.000000]=C2=A0 =C2=A0DMA=C2=A0 =C2=
=A0 =C2=A0 [mem 0x0000000000001000-0x0000000000ffffff]</div><div>[=C2=A0 =
=C2=A0 0.000000]=C2=A0 =C2=A0DMA32=C2=A0 =C2=A0 [mem 0x0000000001000000-0x0=
0000000ffffffff]</div><div>[=C2=A0 =C2=A0 0.000000]=C2=A0 =C2=A0Normal=C2=
=A0 =C2=A0[mem 0x0000000100000000-0x000000051f33ffff]</div><div>[=C2=A0 =C2=
=A0 0.000000]=C2=A0 =C2=A0Device=C2=A0 =C2=A0empty</div><div>[=C2=A0 =C2=A0=
 0.000000] Movable zone start for each node</div><div>[=C2=A0 =C2=A0 0.0000=
00] Early memory node ranges</div><div>[=C2=A0 =C2=A0 0.000000]=C2=A0 =C2=
=A0node=C2=A0 =C2=A00: [mem 0x0000000000001000-0x000000000009cfff]</div><di=
v>[=C2=A0 =C2=A0 0.000000]=C2=A0 =C2=A0node=C2=A0 =C2=A00: [mem 0x000000000=
0100000-0x0000000003ffffff]</div><div>[=C2=A0 =C2=A0 0.000000]=C2=A0 =C2=A0=
node=C2=A0 =C2=A00: [mem 0x0000000004010000-0x0000000009e9ffff]</div><div>[=
=C2=A0 =C2=A0 0.000000]=C2=A0 =C2=A0node=C2=A0 =C2=A00: [mem 0x000000000a00=
0000-0x00000000ccfaafff]</div><div>[=C2=A0 =C2=A0 0.000000]=C2=A0 =C2=A0nod=
e=C2=A0 =C2=A00: [mem 0x00000000cdd4c000-0x00000000ceffffff]</div><div>[=C2=
=A0 =C2=A0 0.000000]=C2=A0 =C2=A0node=C2=A0 =C2=A00: [mem 0x000000010000000=
0-0x000000051f33ffff]</div><div>[=C2=A0 =C2=A0 0.000000] Reserved but unava=
ilable: 8053 pages</div><div>[=C2=A0 =C2=A0 0.000000] Initmem setup node 0 =
[mem 0x0000000000001000-0x000000051f33ffff]</div><div>[=C2=A0 =C2=A0 0.0000=
00] On node 0 totalpages: 5166027</div><div>[=C2=A0 =C2=A0 0.000000]=C2=A0 =
=C2=A0DMA zone: 64 pages used for memmap</div><div>[=C2=A0 =C2=A0 0.000000]=
=C2=A0 =C2=A0DMA zone: 21 pages reserved</div><div>[=C2=A0 =C2=A0 0.000000]=
=C2=A0 =C2=A0DMA zone: 3996 pages, LIFO batch:0</div><div>[=C2=A0 =C2=A0 0.=
000000]=C2=A0 =C2=A0DMA32 zone: 13124 pages used for memmap</div><div>[=C2=
=A0 =C2=A0 0.000000]=C2=A0 =C2=A0DMA32 zone: 839919 pages, LIFO batch:31</d=
iv><div>[=C2=A0 =C2=A0 0.000000]=C2=A0 =C2=A0Normal zone: 67533 pages used =
for memmap</div><div>[=C2=A0 =C2=A0 0.000000]=C2=A0 =C2=A0Normal zone: 4322=
112 pages, LIFO batch:31</div><div>[=C2=A0 =C2=A0 0.000000] ACPI: PM-Timer =
IO Port: 0x808</div><div>[=C2=A0 =C2=A0 0.000000] ACPI: Local APIC address =
0xfee00000</div><div>[=C2=A0 =C2=A0 0.000000] ACPI: LAPIC_NMI (acpi_id[0xff=
] high edge lint[0x1])</div><div>[=C2=A0 =C2=A0 0.000000] IOAPIC[0]: apic_i=
d 9, version 33, address 0xfec00000, GSI 0-23</div><div>[=C2=A0 =C2=A0 0.00=
0000] IOAPIC[1]: apic_id 10, version 33, address 0xfec01000, GSI 24-55</div=
><div>[=C2=A0 =C2=A0 0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_ir=
q 2 dfl dfl)</div><div>[=C2=A0 =C2=A0 0.000000] ACPI: INT_SRC_OVR (bus 0 bu=
s_irq 9 global_irq 9 low level)</div><div>[=C2=A0 =C2=A0 0.000000] ACPI: IR=
Q0 used by override.</div><div>[=C2=A0 =C2=A0 0.000000] ACPI: IRQ9 used by =
override.</div><div>[=C2=A0 =C2=A0 0.000000] Using ACPI (MADT) for SMP conf=
iguration information</div><div>[=C2=A0 =C2=A0 0.000000] ACPI: HPET id: 0x1=
0228201 base: 0xfed00000</div><div>[=C2=A0 =C2=A0 0.000000] smpboot: Allowi=
ng 16 CPUs, 8 hotplug CPUs</div><div>[=C2=A0 =C2=A0 0.000000] PM: Registere=
d nosave memory: [mem 0x00000000-0x00000fff]</div><div>[=C2=A0 =C2=A0 0.000=
000] PM: Registered nosave memory: [mem 0x0009d000-0x0009dfff]</div><div>[=
=C2=A0 =C2=A0 0.000000] PM: Registered nosave memory: [mem 0x0009e000-0x000=
9ffff]</div><div>[=C2=A0 =C2=A0 0.000000] PM: Registered nosave memory: [me=
m 0x000a0000-0x000dffff]</div><div>[=C2=A0 =C2=A0 0.000000] PM: Registered =
nosave memory: [mem 0x000e0000-0x000fffff]</div><div>[=C2=A0 =C2=A0 0.00000=
0] PM: Registered nosave memory: [mem 0x04000000-0x0400ffff]</div><div>[=C2=
=A0 =C2=A0 0.000000] PM: Registered nosave memory: [mem 0x09ea0000-0x09ffff=
ff]</div><div>[=C2=A0 =C2=A0 0.000000] PM: Registered nosave memory: [mem 0=
xccfab000-0xcd096fff]</div><div>[=C2=A0 =C2=A0 0.000000] PM: Registered nos=
ave memory: [mem 0xcd097000-0xcd0c6fff]</div><div>[=C2=A0 =C2=A0 0.000000] =
PM: Registered nosave memory: [mem 0xcd0c7000-0xcd59efff]</div><div>[=C2=A0=
 =C2=A0 0.000000] PM: Registered nosave memory: [mem 0xcd59f000-0xcdd4bfff]=
</div><div>[=C2=A0 =C2=A0 0.000000] PM: Registered nosave memory: [mem 0xcf=
000000-0xdfffffff]</div><div>[=C2=A0 =C2=A0 0.000000] PM: Registered nosave=
 memory: [mem 0xe0000000-0xf7ffffff]</div><div>[=C2=A0 =C2=A0 0.000000] PM:=
 Registered nosave memory: [mem 0xf8000000-0xfbffffff]</div><div>[=C2=A0 =
=C2=A0 0.000000] PM: Registered nosave memory: [mem 0xfc000000-0xfd7fffff]<=
/div><div>[=C2=A0 =C2=A0 0.000000] PM: Registered nosave memory: [mem 0xfd8=
00000-0xfd8fffff]</div><div>[=C2=A0 =C2=A0 0.000000] PM: Registered nosave =
memory: [mem 0xfd900000-0xfe7fffff]</div><div>[=C2=A0 =C2=A0 0.000000] PM: =
Registered nosave memory: [mem 0xfe800000-0xfe800fff]</div><div>[=C2=A0 =C2=
=A0 0.000000] PM: Registered nosave memory: [mem 0xfe801000-0xfeb7ffff]</di=
v><div>[=C2=A0 =C2=A0 0.000000] PM: Registered nosave memory: [mem 0xfeb800=
00-0xfec01fff]</div><div>[=C2=A0 =C2=A0 0.000000] PM: Registered nosave mem=
ory: [mem 0xfec02000-0xfec0ffff]</div><div>[=C2=A0 =C2=A0 0.000000] PM: Reg=
istered nosave memory: [mem 0xfec10000-0xfec10fff]</div><div>[=C2=A0 =C2=A0=
 0.000000] PM: Registered nosave memory: [mem 0xfec11000-0xfecfffff]</div><=
div>[=C2=A0 =C2=A0 0.000000] PM: Registered nosave memory: [mem 0xfed00000-=
0xfed00fff]</div><div>[=C2=A0 =C2=A0 0.000000] PM: Registered nosave memory=
: [mem 0xfed01000-0xfed3ffff]</div><div>[=C2=A0 =C2=A0 0.000000] PM: Regist=
ered nosave memory: [mem 0xfed40000-0xfed44fff]</div><div>[=C2=A0 =C2=A0 0.=
000000] PM: Registered nosave memory: [mem 0xfed45000-0xfed7ffff]</div><div=
>[=C2=A0 =C2=A0 0.000000] PM: Registered nosave memory: [mem 0xfed80000-0xf=
ed8ffff]</div><div>[=C2=A0 =C2=A0 0.000000] PM: Registered nosave memory: [=
mem 0xfed90000-0xfedc1fff]</div><div>[=C2=A0 =C2=A0 0.000000] PM: Registere=
d nosave memory: [mem 0xfedc2000-0xfedcffff]</div><div>[=C2=A0 =C2=A0 0.000=
000] PM: Registered nosave memory: [mem 0xfedd0000-0xfedd3fff]</div><div>[=
=C2=A0 =C2=A0 0.000000] PM: Registered nosave memory: [mem 0xfedd4000-0xfed=
d5fff]</div><div>[=C2=A0 =C2=A0 0.000000] PM: Registered nosave memory: [me=
m 0xfedd6000-0xfedfffff]</div><div>[=C2=A0 =C2=A0 0.000000] PM: Registered =
nosave memory: [mem 0xfee00000-0xfeefffff]</div><div>[=C2=A0 =C2=A0 0.00000=
0] PM: Registered nosave memory: [mem 0xfef00000-0xfeffffff]</div><div>[=C2=
=A0 =C2=A0 0.000000] PM: Registered nosave memory: [mem 0xff000000-0xffffff=
ff]</div><div>[=C2=A0 =C2=A0 0.000000] [mem 0xe0000000-0xf7ffffff] availabl=
e for PCI devices</div><div>[=C2=A0 =C2=A0 0.000000] Booting paravirtualize=
d kernel on bare hardware</div><div>[=C2=A0 =C2=A0 0.000000] clocksource: r=
efined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 63704=
52778343963 ns</div><div>[=C2=A0 =C2=A0 0.000000] random: get_random_bytes =
called from start_kernel+0x95/0x535 with crng_init=3D0</div><div>[=C2=A0 =
=C2=A0 0.000000] setup_percpu: NR_CPUS:320 nr_cpumask_bits:320 nr_cpu_ids:1=
6 nr_node_ids:1</div><div>[=C2=A0 =C2=A0 0.000000] percpu: Embedded 46 page=
s/cpu @(____ptrval____) s151552 r8192 d28672 u262144</div><div>[=C2=A0 =C2=
=A0 0.000000] pcpu-alloc: s151552 r8192 d28672 u262144 alloc=3D1*2097152</d=
iv><div>[=C2=A0 =C2=A0 0.000000] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0=
] 08 09 10 11 12 13 14 15=C2=A0</div><div>[=C2=A0 =C2=A0 0.000000] Built 1 =
zonelists, mobility grouping on.=C2=A0 Total pages: 5085285</div><div>[=C2=
=A0 =C2=A0 0.000000] Policy zone: Normal</div><div>[=C2=A0 =C2=A0 0.000000]=
 Kernel command line: BOOT_IMAGE=3D/vmlinuz-linux root=3DUUID=3D7bec7995-35=
57-480d-aee8-d9871405748d rw pci=3Dnoaer idle=3Dnomwait</div><div>[=C2=A0 =
=C2=A0 0.000000] Calgary: detecting Calgary via BIOS EBDA area</div><div>[=
=C2=A0 =C2=A0 0.000000] Calgary: Unable to locate Rio Grande table in EBDA =
- bailing!</div><div>[=C2=A0 =C2=A0 0.000000] Memory: 20231056K/20664108K a=
vailable (10252K kernel code, 1297K rwdata, 3528K rodata, 1488K init, 612K =
bss, 433052K reserved, 0K cma-reserved)</div><div>[=C2=A0 =C2=A0 0.000000] =
SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D16, Nodes=3D1</div>=
<div>[=C2=A0 =C2=A0 0.000000] ftrace: allocating 33391 entries in 131 pages=
</div><div>[=C2=A0 =C2=A0 0.000000] Preemptible hierarchical RCU implementa=
tion.</div><div>[=C2=A0 =C2=A0 0.000000] <span style=3D"white-space:pre">	<=
/span>CONFIG_RCU_FANOUT set to non-default value of 32</div><div>[=C2=A0 =
=C2=A0 0.000000] <span style=3D"white-space:pre">	</span>RCU dyntick-idle g=
race-period acceleration is enabled.</div><div>[=C2=A0 =C2=A0 0.000000] <sp=
an style=3D"white-space:pre">	</span>RCU restricting CPUs from NR_CPUS=3D32=
0 to nr_cpu_ids=3D16.</div><div>[=C2=A0 =C2=A0 0.000000] <span style=3D"whi=
te-space:pre">	</span>RCU priority boosting: priority 1 delay 500 ms.</div>=
<div>[=C2=A0 =C2=A0 0.000000] <span style=3D"white-space:pre">	</span>Tasks=
 RCU enabled.</div><div>[=C2=A0 =C2=A0 0.000000] RCU: Adjusting geometry fo=
r rcu_fanout_leaf=3D16, nr_cpu_ids=3D16</div><div>[=C2=A0 =C2=A0 0.000000] =
NR_IRQS: 20736, nr_irqs: 1096, preallocated irqs: 16</div><div>[=C2=A0 =C2=
=A0 0.000000] <span style=3D"white-space:pre">	</span>Offload RCU callbacks=
 from CPUs: (none).</div><div>[=C2=A0 =C2=A0 0.000000] spurious 8259A inter=
rupt: IRQ7.</div><div>[=C2=A0 =C2=A0 0.000000] Console: colour dummy device=
 80x25</div><div>[=C2=A0 =C2=A0 0.000000] console [tty0] enabled</div><div>=
[=C2=A0 =C2=A0 0.000000] ACPI: Core revision 20180531</div><div>[=C2=A0 =C2=
=A0 0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, m=
ax_idle_ns: 133484873504 ns</div><div>[=C2=A0 =C2=A0 0.000000] hpet clockev=
ent registered</div><div>[=C2=A0 =C2=A0 0.000000] APIC: Switch to symmetric=
 I/O mode setup</div><div>[=C2=A0 =C2=A0 0.003333] Switched APIC routing to=
 physical flat.</div><div>[=C2=A0 =C2=A0 0.003333] ..TIMER: vector=3D0x30 a=
pic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D-1</div><div>[=C2=A0 =C2=A0 0.019999] t=
sc: Fast TSC calibration using PIT</div><div>[=C2=A0 =C2=A0 0.023333] tsc: =
Detected 1996.125 MHz processor</div><div>[=C2=A0 =C2=A0 0.023333] clocksou=
rce: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x398bc360853, max_idl=
e_ns: 881590429734 ns</div><div>[=C2=A0 =C2=A0 0.023333] Calibrating delay =
loop (skipped), value calculated using timer frequency.. 3993.59 BogoMIPS (=
lpj=3D6653750)</div><div>[=C2=A0 =C2=A0 0.023333] pid_max: default: 32768 m=
inimum: 301</div><div>[=C2=A0 =C2=A0 0.023333] Security Framework initializ=
ed</div><div>[=C2=A0 =C2=A0 0.023333] Yama: becoming mindful.</div><div>[=
=C2=A0 =C2=A0 0.030426] Dentry cache hash table entries: 4194304 (order: 13=
, 33554432 bytes)</div><div>[=C2=A0 =C2=A0 0.033707] Inode-cache hash table=
 entries: 2097152 (order: 12, 16777216 bytes)</div><div>[=C2=A0 =C2=A0 0.03=
3887] Mount-cache hash table entries: 65536 (order: 7, 524288 bytes)</div><=
div>[=C2=A0 =C2=A0 0.033994] Mountpoint-cache hash table entries: 65536 (or=
der: 7, 524288 bytes)</div><div>[=C2=A0 =C2=A0 0.034705] mce: CPU supports =
23 MCE banks</div><div>[=C2=A0 =C2=A0 0.034729] LVT offset 1 assigned for v=
ector 0xf9</div><div>[=C2=A0 =C2=A0 0.034796] LVT offset 2 assigned for vec=
tor 0xf4</div><div>[=C2=A0 =C2=A0 0.034810] Last level iTLB entries: 4KB 10=
24, 2MB 1024, 4MB 512</div><div>[=C2=A0 =C2=A0 0.034811] Last level dTLB en=
tries: 4KB 1536, 2MB 1536, 4MB 768, 1GB 0</div><div>[=C2=A0 =C2=A0 0.034813=
] Spectre V2 : Mitigation: Full AMD retpoline</div><div>[=C2=A0 =C2=A0 0.03=
4814] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on conte=
xt switch</div><div>[=C2=A0 =C2=A0 0.034814] Spectre V2 : Spectre v2 mitiga=
tion: Enabling Indirect Branch Prediction Barrier</div><div>[=C2=A0 =C2=A0 =
0.034816] Speculative Store Bypass: Mitigation: Speculative Store Bypass di=
sabled via prctl and seccomp</div><div>[=C2=A0 =C2=A0 0.042325] Freeing SMP=
 alternatives memory: 28K</div><div>[=C2=A0 =C2=A0 0.046666] smpboot: CPU0:=
 AMD Ryzen 5 2500U with Radeon Vega Mobile Gfx (family: 0x17, model: 0x11, =
stepping: 0x0)</div><div>[=C2=A0 =C2=A0 0.063354] Performance Events: Fam17=
h core perfctr, AMD PMU driver.</div><div>[=C2=A0 =C2=A0 0.063362] ... vers=
ion:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0</div><div>[=
=C2=A0 =C2=A0 0.063363] ... bit width:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 48</div><div>[=C2=A0 =C2=A0 0.063364] ... generic registers:=
=C2=A0 =C2=A0 =C2=A0 6</div><div>[=C2=A0 =C2=A0 0.063365] ... value mask:=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00000ffffffffffff</div><div>=
[=C2=A0 =C2=A0 0.063366] ... max period:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A000007fffffffffff</div><div>[=C2=A0 =C2=A0 0.063367] ... fixed-=
purpose events:=C2=A0 =C2=A00</div><div>[=C2=A0 =C2=A0 0.063368] ... event =
mask:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0000000000000003f</div>=
<div>[=C2=A0 =C2=A0 0.070012] Hierarchical SRCU implementation.</div><div>[=
=C2=A0 =C2=A0 0.090482] NMI watchdog: Enabled. Permanently consumes one hw-=
PMU counter.</div><div>[=C2=A0 =C2=A0 0.096676] smp: Bringing up secondary =
CPUs ...</div><div>[=C2=A0 =C2=A0 0.136716] x86: Booting SMP configuration:=
</div><div>[=C2=A0 =C2=A0 0.136719] .... node=C2=A0 #0, CPUs:=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 #1=C2=A0 #2=C2=A0 #3=C2=A0 #4=C2=A0 #5=C2=A0 #6=C2=A0 #7</div=
><div>[=C2=A0 =C2=A0 0.382675] smp: Brought up 1 node, 8 CPUs</div><div>[=
=C2=A0 =C2=A0 0.382675] smpboot: Max logical packages: 2</div><div>[=C2=A0 =
=C2=A0 0.382675] smpboot: Total of 8 processors activated (31950.75 BogoMIP=
S)</div><div>[=C2=A0 =C2=A0 0.384034] devtmpfs: initialized</div><div>[=C2=
=A0 =C2=A0 0.384034] x86/mm: Memory block size: 128MB</div><div>[=C2=A0 =C2=
=A0 0.387974] PM: Registering ACPI NVS region [mem 0x04000000-0x0400ffff] (=
65536 bytes)</div><div>[=C2=A0 =C2=A0 0.387974] PM: Registering ACPI NVS re=
gion [mem 0xcd0c7000-0xcd59efff] (5079040 bytes)</div><div>[=C2=A0 =C2=A0 0=
.387974] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max=
_idle_ns: 6370867519511994 ns</div><div>[=C2=A0 =C2=A0 0.387974] futex hash=
 table entries: 4096 (order: 6, 262144 bytes)</div><div>[=C2=A0 =C2=A0 0.38=
7974] pinctrl core: initialized pinctrl subsystem</div><div>[=C2=A0 =C2=A0 =
0.387974] RTC time: 20:56:45, date: 08/17/18</div><div>[=C2=A0 =C2=A0 0.390=
689] NET: Registered protocol family 16</div><div>[=C2=A0 =C2=A0 0.390824] =
audit: initializing netlink subsys (disabled)</div><div>[=C2=A0 =C2=A0 0.39=
0832] audit: type=3D2000 audit(1534539404.389:1): state=3Dinitialized audit=
_enabled=3D0 res=3D1</div><div>[=C2=A0 =C2=A0 0.390832] cpuidle: using gove=
rnor ladder</div><div>[=C2=A0 =C2=A0 0.390832] cpuidle: using governor menu=
</div><div>[=C2=A0 =C2=A0 0.390832] ACPI FADT declares the system doesn&#39=
;t support PCIe ASPM, so disable it</div><div>[=C2=A0 =C2=A0 0.390832] ACPI=
: bus type PCI registered</div><div>[=C2=A0 =C2=A0 0.390832] acpiphp: ACPI =
Hot Plug PCI Controller Driver version: 0.5</div><div>[=C2=A0 =C2=A0 0.3908=
32] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff=
] (base 0xf8000000)</div><div>[=C2=A0 =C2=A0 0.390832] PCI: MMCONFIG at [me=
m 0xf8000000-0xfbffffff] reserved in E820</div><div>[=C2=A0 =C2=A0 0.390832=
] PCI: Using configuration type 1 for base access</div><div>[=C2=A0 =C2=A0 =
0.390832] mtrr: your CPUs had inconsistent variable MTRR settings</div><div=
>[=C2=A0 =C2=A0 0.390832] mtrr: probably your BIOS does not setup all CPUs.=
</div><div>[=C2=A0 =C2=A0 0.390832] mtrr: corrected configuration.</div><di=
v>[=C2=A0 =C2=A0 0.393439] HugeTLB registered 1.00 GiB page size, pre-alloc=
ated 0 pages</div><div>[=C2=A0 =C2=A0 0.393439] HugeTLB registered 2.00 MiB=
 page size, pre-allocated 0 pages</div><div>[=C2=A0 =C2=A0 0.393569] ACPI: =
Added _OSI(Module Device)</div><div>[=C2=A0 =C2=A0 0.393571] ACPI: Added _O=
SI(Processor Device)</div><div>[=C2=A0 =C2=A0 0.393571] ACPI: Added _OSI(3.=
0 _SCP Extensions)</div><div>[=C2=A0 =C2=A0 0.393572] ACPI: Added _OSI(Proc=
essor Aggregator Device)</div><div>[=C2=A0 =C2=A0 0.393573] ACPI: Added _OS=
I(Linux-Dell-Video)</div><div>[=C2=A0 =C2=A0 0.395212] ACPI: [Firmware Bug]=
: BIOS _OSI(Linux) query ignored</div><div>[=C2=A0 =C2=A0 0.417390] ACPI: 5=
 ACPI AML tables successfully acquired and loaded</div><div>[=C2=A0 =C2=A0 =
0.442272] ACPI: EC: EC started</div><div>[=C2=A0 =C2=A0 0.442274] ACPI: EC:=
 interrupt blocked</div><div>[=C2=A0 =C2=A0 0.474786] ACPI: \_SB_.PCI0.SBRG=
.EC0_: Used as first EC</div><div>[=C2=A0 =C2=A0 0.474788] ACPI: \_SB_.PCI0=
.SBRG.EC0_: GPE=3D0x3, EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62</div><div>[=C2=
=A0 =C2=A0 0.474791] ACPI: \_SB_.PCI0.SBRG.EC0_: Used as boot DSDT EC to ha=
ndle transactions</div><div>[=C2=A0 =C2=A0 0.474791] ACPI: Interpreter enab=
led</div><div>[=C2=A0 =C2=A0 0.474815] ACPI: (supports S0 S3 S4 S5)</div><d=
iv>[=C2=A0 =C2=A0 0.474816] ACPI: Using IOAPIC for interrupt routing</div><=
div>[=C2=A0 =C2=A0 0.476784] PCI: Using host bridge windows from ACPI; if n=
ecessary, use &quot;pci=3Dnocrs&quot; and report a bug</div><div>[=C2=A0 =
=C2=A0 0.477446] ACPI: Enabled 2 GPEs in block 00 to 1F</div><div>[=C2=A0 =
=C2=A0 0.482166] ACPI: Power Resource [P0ST] (on)</div><div>[=C2=A0 =C2=A0 =
0.482221] ACPI: Power Resource [P3ST] (on)</div><div>[=C2=A0 =C2=A0 0.48982=
9] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])</div><div>[=C2=A0=
 =C2=A0 0.489836] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM C=
lockPM Segments MSI]</div><div>[=C2=A0 =C2=A0 0.490252] acpi PNP0A08:00: _O=
SC: platform does not support [SHPCHotplug LTR]</div><div>[=C2=A0 =C2=A0 0.=
490543] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapabil=
ity]</div><div>[=C2=A0 =C2=A0 0.490544] acpi PNP0A08:00: FADT indicates ASP=
M is unsupported, using BIOS configuration</div><div>[=C2=A0 =C2=A0 0.49056=
4] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000 [bus 00-3f] o=
nly partially covers this bridge</div><div>[=C2=A0 =C2=A0 0.491144] PCI hos=
t bridge to bus 0000:00</div><div>[=C2=A0 =C2=A0 0.491147] pci_bus 0000:00:=
 root bus resource [io=C2=A0 0x0000-0x03af window]</div><div>[=C2=A0 =C2=A0=
 0.491149] pci_bus 0000:00: root bus resource [io=C2=A0 0x03e0-0x0cf7 windo=
w]</div><div>[=C2=A0 =C2=A0 0.491151] pci_bus 0000:00: root bus resource [i=
o=C2=A0 0x03b0-0x03df window]</div><div>[=C2=A0 =C2=A0 0.491152] pci_bus 00=
00:00: root bus resource [io=C2=A0 0x0d00-0xffff window]</div><div>[=C2=A0 =
=C2=A0 0.491154] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bf=
fff window]</div><div>[=C2=A0 =C2=A0 0.491156] pci_bus 0000:00: root bus re=
source [mem 0x000c0000-0x000dffff window]</div><div>[=C2=A0 =C2=A0 0.491157=
] pci_bus 0000:00: root bus resource [mem 0xe0000000-0xfebfffff window]</di=
v><div>[=C2=A0 =C2=A0 0.491159] pci_bus 0000:00: root bus resource [mem 0xf=
ee00000-0xffffffff window]</div><div>[=C2=A0 =C2=A0 0.491161] pci_bus 0000:=
00: root bus resource [bus 00-ff]</div><div>[=C2=A0 =C2=A0 0.491173] pci 00=
00:00:00.0: [1022:15d0] type 00 class 0x060000</div><div>[=C2=A0 =C2=A0 0.4=
91339] pci 0000:00:00.2: [1022:15d1] type 00 class 0x080600</div><div>[=C2=
=A0 =C2=A0 0.491539] pci 0000:00:01.0: [1022:1452] type 00 class 0x060000</=
div><div>[=C2=A0 =C2=A0 0.491704] pci 0000:00:01.6: [1022:15d3] type 01 cla=
ss 0x060400</div><div>[=C2=A0 =C2=A0 0.491840] pci 0000:00:01.6: PME# suppo=
rted from D0 D3hot D3cold</div><div>[=C2=A0 =C2=A0 0.491994] pci 0000:00:01=
.7: [1022:15d3] type 01 class 0x060400</div><div>[=C2=A0 =C2=A0 0.492129] p=
ci 0000:00:01.7: PME# supported from D0 D3hot D3cold</div><div>[=C2=A0 =C2=
=A0 0.492286] pci 0000:00:08.0: [1022:1452] type 00 class 0x060000</div><di=
v>[=C2=A0 =C2=A0 0.492436] pci 0000:00:08.1: [1022:15db] type 01 class 0x06=
0400</div><div>[=C2=A0 =C2=A0 0.492493] pci 0000:00:08.1: enabling Extended=
 Tags</div><div>[=C2=A0 =C2=A0 0.492551] pci 0000:00:08.1: PME# supported f=
rom D0 D3hot D3cold</div><div>[=C2=A0 =C2=A0 0.492667] pci 0000:00:08.2: [1=
022:15dc] type 01 class 0x060400</div><div>[=C2=A0 =C2=A0 0.492724] pci 000=
0:00:08.2: enabling Extended Tags</div><div>[=C2=A0 =C2=A0 0.492781] pci 00=
00:00:08.2: PME# supported from D0 D3hot D3cold</div><div>[=C2=A0 =C2=A0 0.=
492939] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500</div><div>[=C2=
=A0 =C2=A0 0.493189] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100</=
div><div>[=C2=A0 =C2=A0 0.493413] pci 0000:00:18.0: [1022:15e8] type 00 cla=
ss 0x060000</div><div>[=C2=A0 =C2=A0 0.493509] pci 0000:00:18.1: [1022:15e9=
] type 00 class 0x060000</div><div>[=C2=A0 =C2=A0 0.493593] pci 0000:00:18.=
2: [1022:15ea] type 00 class 0x060000</div><div>[=C2=A0 =C2=A0 0.493692] pc=
i 0000:00:18.3: [1022:15eb] type 00 class 0x060000</div><div>[=C2=A0 =C2=A0=
 0.493775] pci 0000:00:18.4: [1022:15ec] type 00 class 0x060000</div><div>[=
=C2=A0 =C2=A0 0.493859] pci 0000:00:18.5: [1022:15ed] type 00 class 0x06000=
0</div><div>[=C2=A0 =C2=A0 0.493944] pci 0000:00:18.6: [1022:15ee] type 00 =
class 0x060000</div><div>[=C2=A0 =C2=A0 0.494027] pci 0000:00:18.7: [1022:1=
5ef] type 00 class 0x060000</div><div>[=C2=A0 =C2=A0 0.494256] pci 0000:01:=
00.0: [10ec:522a] type 00 class 0xff0000</div><div>[=C2=A0 =C2=A0 0.494298]=
 pci 0000:01:00.0: reg 0x10: [mem 0xfe300000-0xfe300fff]</div><div>[=C2=A0 =
=C2=A0 0.494483] pci 0000:01:00.0: supports D1 D2</div><div>[=C2=A0 =C2=A0 =
0.494485] pci 0000:01:00.0: PME# supported from D1 D2 D3hot D3cold</div><di=
v>[=C2=A0 =C2=A0 0.494750] pci 0000:00:01.6: PCI bridge to [bus 01]</div><d=
iv>[=C2=A0 =C2=A0 0.494760] pci 0000:00:01.6:=C2=A0 =C2=A0bridge window [me=
m 0xfe300000-0xfe3fffff]</div><div>[=C2=A0 =C2=A0 0.494903] pci 0000:02:00.=
0: [10ec:b822] type 00 class 0x028000</div><div>[=C2=A0 =C2=A0 0.494953] pc=
i 0000:02:00.0: reg 0x10: [io=C2=A0 0xf000-0xf0ff]</div><div>[=C2=A0 =C2=A0=
 0.494998] pci 0000:02:00.0: reg 0x18: [mem 0xfe200000-0xfe20ffff 64bit]</d=
iv><div>[=C2=A0 =C2=A0 0.495207] pci 0000:02:00.0: supports D1 D2</div><div=
>[=C2=A0 =C2=A0 0.495209] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3=
hot D3cold</div><div>[=C2=A0 =C2=A0 0.495543] pci 0000:00:01.7: PCI bridge =
to [bus 02]</div><div>[=C2=A0 =C2=A0 0.495550] pci 0000:00:01.7:=C2=A0 =C2=
=A0bridge window [io=C2=A0 0xf000-0xffff]</div><div>[=C2=A0 =C2=A0 0.495554=
] pci 0000:00:01.7:=C2=A0 =C2=A0bridge window [mem 0xfe200000-0xfe2fffff]</=
div><div>[=C2=A0 =C2=A0 0.495714] pci 0000:03:00.0: [1002:15dd] type 00 cla=
ss 0x030000</div><div>[=C2=A0 =C2=A0 0.495762] pci 0000:03:00.0: reg 0x10: =
[mem 0xe0000000-0xefffffff 64bit pref]</div><div>[=C2=A0 =C2=A0 0.495783] p=
ci 0000:03:00.0: reg 0x18: [mem 0xf0000000-0xf01fffff 64bit pref]</div><div=
>[=C2=A0 =C2=A0 0.495796] pci 0000:03:00.0: reg 0x20: [io=C2=A0 0xe000-0xe0=
ff]</div><div>[=C2=A0 =C2=A0 0.495810] pci 0000:03:00.0: reg 0x24: [mem 0xf=
e000000-0xfe07ffff]</div><div>[=C2=A0 =C2=A0 0.495832] pci 0000:03:00.0: en=
abling Extended Tags</div><div>[=C2=A0 =C2=A0 0.495940] pci 0000:03:00.0: P=
ME# supported from D1 D2 D3hot D3cold</div><div>[=C2=A0 =C2=A0 0.496099] pc=
i 0000:03:00.1: [1002:15de] type 00 class 0x040300</div><div>[=C2=A0 =C2=A0=
 0.496131] pci 0000:03:00.1: reg 0x10: [mem 0xfe088000-0xfe08bfff]</div><di=
v>[=C2=A0 =C2=A0 0.496210] pci 0000:03:00.1: enabling Extended Tags</div><d=
iv>[=C2=A0 =C2=A0 0.496284] pci 0000:03:00.1: PME# supported from D1 D2 D3h=
ot D3cold</div><div>[=C2=A0 =C2=A0 0.496394] pci 0000:03:00.2: [1022:15df] =
type 00 class 0x108000</div><div>[=C2=A0 =C2=A0 0.496449] pci 0000:03:00.2:=
 reg 0x18: [mem 0xfdf00000-0xfdffffff]</div><div>[=C2=A0 =C2=A0 0.496485] p=
ci 0000:03:00.2: reg 0x24: [mem 0xfe08c000-0xfe08dfff]</div><div>[=C2=A0 =
=C2=A0 0.496507] pci 0000:03:00.2: enabling Extended Tags</div><div>[=C2=A0=
 =C2=A0 0.496684] pci 0000:03:00.3: [1022:15e0] type 00 class 0x0c0330</div=
><div>[=C2=A0 =C2=A0 0.496723] pci 0000:03:00.3: reg 0x10: [mem 0xfde00000-=
0xfdefffff 64bit]</div><div>[=C2=A0 =C2=A0 0.496790] pci 0000:03:00.3: enab=
ling Extended Tags</div><div>[=C2=A0 =C2=A0 0.496872] pci 0000:03:00.3: PME=
# supported from D0 D3hot D3cold</div><div>[=C2=A0 =C2=A0 0.496982] pci 000=
0:03:00.4: [1022:15e1] type 00 class 0x0c0330</div><div>[=C2=A0 =C2=A0 0.49=
7021] pci 0000:03:00.4: reg 0x10: [mem 0xfdd00000-0xfddfffff 64bit]</div><d=
iv>[=C2=A0 =C2=A0 0.497088] pci 0000:03:00.4: enabling Extended Tags</div><=
div>[=C2=A0 =C2=A0 0.497169] pci 0000:03:00.4: PME# supported from D0 D3hot=
 D3cold</div><div>[=C2=A0 =C2=A0 0.497280] pci 0000:03:00.6: [1022:15e3] ty=
pe 00 class 0x040300</div><div>[=C2=A0 =C2=A0 0.497312] pci 0000:03:00.6: r=
eg 0x10: [mem 0xfe080000-0xfe087fff]</div><div>[=C2=A0 =C2=A0 0.497391] pci=
 0000:03:00.6: enabling Extended Tags</div><div>[=C2=A0 =C2=A0 0.497464] pc=
i 0000:03:00.6: PME# supported from D0 D3hot D3cold</div><div>[=C2=A0 =C2=
=A0 0.497610] pci 0000:00:08.1: PCI bridge to [bus 03]</div><div>[=C2=A0 =
=C2=A0 0.497616] pci 0000:00:08.1:=C2=A0 =C2=A0bridge window [io=C2=A0 0xe0=
00-0xefff]</div><div>[=C2=A0 =C2=A0 0.497620] pci 0000:00:08.1:=C2=A0 =C2=
=A0bridge window [mem 0xfdd00000-0xfe0fffff]</div><div>[=C2=A0 =C2=A0 0.497=
627] pci 0000:00:08.1:=C2=A0 =C2=A0bridge window [mem 0xe0000000-0xf01fffff=
 64bit pref]</div><div>[=C2=A0 =C2=A0 0.497737] pci 0000:04:00.0: [1022:790=
1] type 00 class 0x010601</div><div>[=C2=A0 =C2=A0 0.497828] pci 0000:04:00=
.0: reg 0x24: [mem 0xfe100000-0xfe1007ff]</div><div>[=C2=A0 =C2=A0 0.497850=
] pci 0000:04:00.0: enabling Extended Tags</div><div>[=C2=A0 =C2=A0 0.49793=
2] pci 0000:04:00.0: PME# supported from D3hot D3cold</div><div>[=C2=A0 =C2=
=A0 0.498052] pci 0000:00:08.2: PCI bridge to [bus 04]</div><div>[=C2=A0 =
=C2=A0 0.498061] pci 0000:00:08.2:=C2=A0 =C2=A0bridge window [mem 0xfe10000=
0-0xfe1fffff]</div><div>[=C2=A0 =C2=A0 0.498527] ACPI: IRQ 7 override to ed=
ge, high</div><div>[=C2=A0 =C2=A0 0.498689] ACPI: PCI Interrupt Link [LNKA]=
 (IRQs 4 5 7 10 11 14 15) *0</div><div>[=C2=A0 =C2=A0 0.498802] ACPI: PCI I=
nterrupt Link [LNKB] (IRQs 4 5 7 10 11 14 15) *0</div><div>[=C2=A0 =C2=A0 0=
.498900] ACPI: PCI Interrupt Link [LNKC] (IRQs 4 5 7 10 11 14 15) *0</div><=
div>[=C2=A0 =C2=A0 0.499016] ACPI: PCI Interrupt Link [LNKD] (IRQs 4 5 7 10=
 11 14 15) *0</div><div>[=C2=A0 =C2=A0 0.499123] ACPI: PCI Interrupt Link [=
LNKE] (IRQs 4 5 7 10 11 14 15) *0</div><div>[=C2=A0 =C2=A0 0.499206] ACPI: =
PCI Interrupt Link [LNKF] (IRQs 4 5 7 10 11 14 15) *0</div><div>[=C2=A0 =C2=
=A0 0.499289] ACPI: PCI Interrupt Link [LNKG] (IRQs 4 5 7 10 11 14 15) *0</=
div><div>[=C2=A0 =C2=A0 0.499372] ACPI: PCI Interrupt Link [LNKH] (IRQs 4 5=
 7 10 11 14 15) *0</div><div>[=C2=A0 =C2=A0 0.500594] ACPI: EC: interrupt u=
nblocked</div><div>[=C2=A0 =C2=A0 0.500625] ACPI: EC: event unblocked</div>=
<div>[=C2=A0 =C2=A0 0.500646] ACPI: \_SB_.PCI0.SBRG.EC0_: GPE=3D0x3, EC_CMD=
/EC_SC=3D0x66, EC_DATA=3D0x62</div><div>[=C2=A0 =C2=A0 0.500648] ACPI: \_SB=
_.PCI0.SBRG.EC0_: Used as boot DSDT EC to handle transactions and events</d=
iv><div>[=C2=A0 =C2=A0 0.503358] pci 0000:03:00.0: vgaarb: setting as boot =
VGA device</div><div>[=C2=A0 =C2=A0 0.503362] pci 0000:03:00.0: vgaarb: VGA=
 device added: decodes=3Dio+mem,owns=3Dio+mem,locks=3Dnone</div><div>[=C2=
=A0 =C2=A0 0.503365] pci 0000:03:00.0: vgaarb: bridge control possible</div=
><div>[=C2=A0 =C2=A0 0.503366] vgaarb: loaded</div><div>[=C2=A0 =C2=A0 0.50=
5741] pps_core: LinuxPPS API ver. 1 registered</div><div>[=C2=A0 =C2=A0 0.5=
05741] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti=
 &lt;<a href=3D"mailto:giometti-k2GhghHVRtY@public.gmane.org">giometti-k2GhghHVRtY@public.gmane.org</a>&gt;</div><d=
iv>[=C2=A0 =C2=A0 0.505741] PTP clock support registered</div><div>[=C2=A0 =
=C2=A0 0.505741] EDAC MC: Ver: 3.0.0</div><div>[=C2=A0 =C2=A0 0.506733] PCI=
: Using ACPI for IRQ routing</div><div>[=C2=A0 =C2=A0 0.510850] PCI: pci_ca=
che_line_size set to 64 bytes</div><div>[=C2=A0 =C2=A0 0.511073] Expanded r=
esource Reserved due to conflict with PCI Bus 0000:00</div><div>[=C2=A0 =C2=
=A0 0.511076] e820: reserve RAM buffer [mem 0x0009d400-0x0009ffff]</div><di=
v>[=C2=A0 =C2=A0 0.511078] e820: reserve RAM buffer [mem 0x09ea0000-0x0bfff=
fff]</div><div>[=C2=A0 =C2=A0 0.511079] e820: reserve RAM buffer [mem 0xccf=
ab000-0xcfffffff]</div><div>[=C2=A0 =C2=A0 0.511080] e820: reserve RAM buff=
er [mem 0xcf000000-0xcfffffff]</div><div>[=C2=A0 =C2=A0 0.511081] e820: res=
erve RAM buffer [mem 0x51f340000-0x51fffffff]</div><div>[=C2=A0 =C2=A0 0.51=
1240] NetLabel: Initializing</div><div>[=C2=A0 =C2=A0 0.511241] NetLabel:=
=C2=A0 domain hash size =3D 128</div><div>[=C2=A0 =C2=A0 0.511241] NetLabel=
:=C2=A0 protocols =3D UNLABELED CIPSOv4 CALIPSO</div><div>[=C2=A0 =C2=A0 0.=
511258] NetLabel:=C2=A0 unlabeled traffic allowed by default</div><div>[=C2=
=A0 =C2=A0 0.511263] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0</div><div>[=C2=
=A0 =C2=A0 0.511263] hpet0: 3 comparators, 32-bit 14.318180 MHz counter</di=
v><div>[=C2=A0 =C2=A0 0.515621] clocksource: Switched to clocksource tsc-ea=
rly</div><div>[=C2=A0 =C2=A0 0.530866] VFS: Disk quotas dquot_6.6.0</div><d=
iv>[=C2=A0 =C2=A0 0.530923] VFS: Dquot-cache hash table entries: 512 (order=
 0, 4096 bytes)</div><div>[=C2=A0 =C2=A0 0.531072] pnp: PnP ACPI init</div>=
<div>[=C2=A0 =C2=A0 0.531316] system 00:00: [mem 0xf8000000-0xfbffffff] has=
 been reserved</div><div>[=C2=A0 =C2=A0 0.531323] system 00:00: Plug and Pl=
ay ACPI device, IDs PNP0c01 (active)</div><div>[=C2=A0 =C2=A0 0.531440] sys=
tem 00:01: [mem 0xfeb80000-0xfebfffff] could not be reserved</div><div>[=C2=
=A0 =C2=A0 0.531444] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (=
active)</div><div>[=C2=A0 =C2=A0 0.531608] pnp 00:02: Plug and Play ACPI de=
vice, IDs PNP0b00 (active)</div><div>[=C2=A0 =C2=A0 0.531723] pnp 00:03: Pl=
ug and Play ACPI device, IDs HPQ8001 PNP0303 (active)</div><div>[=C2=A0 =C2=
=A0 0.531752] pnp 00:04: Plug and Play ACPI device, IDs SYN324e ETD0000 PNP=
0f13 (active)</div><div>[=C2=A0 =C2=A0 0.532131] system 00:05: [io=C2=A0 0x=
04d0-0x04d1] has been reserved</div><div>[=C2=A0 =C2=A0 0.532134] system 00=
:05: [io=C2=A0 0x040b] has been reserved</div><div>[=C2=A0 =C2=A0 0.532135]=
 system 00:05: [io=C2=A0 0x04d6] has been reserved</div><div>[=C2=A0 =C2=A0=
 0.532137] system 00:05: [io=C2=A0 0x0c00-0x0c01] has been reserved</div><d=
iv>[=C2=A0 =C2=A0 0.532139] system 00:05: [io=C2=A0 0x0c14] has been reserv=
ed</div><div>[=C2=A0 =C2=A0 0.532149] system 00:05: [io=C2=A0 0x0c50-0x0c51=
] has been reserved</div><div>[=C2=A0 =C2=A0 0.532151] system 00:05: [io=C2=
=A0 0x0c52] has been reserved</div><div>[=C2=A0 =C2=A0 0.532153] system 00:=
05: [io=C2=A0 0x0c6c] has been reserved</div><div>[=C2=A0 =C2=A0 0.532155] =
system 00:05: [io=C2=A0 0x0c6f] has been reserved</div><div>[=C2=A0 =C2=A0 =
0.532156] system 00:05: [io=C2=A0 0x0cd0-0x0cd1] has been reserved</div><di=
v>[=C2=A0 =C2=A0 0.532158] system 00:05: [io=C2=A0 0x0cd2-0x0cd3] has been =
reserved</div><div>[=C2=A0 =C2=A0 0.532160] system 00:05: [io=C2=A0 0x0cd4-=
0x0cd5] has been reserved</div><div>[=C2=A0 =C2=A0 0.532162] system 00:05: =
[io=C2=A0 0x0cd6-0x0cd7] has been reserved</div><div>[=C2=A0 =C2=A0 0.53216=
3] system 00:05: [io=C2=A0 0x0cd8-0x0cdf] has been reserved</div><div>[=C2=
=A0 =C2=A0 0.532165] system 00:05: [io=C2=A0 0x0800-0x089f] has been reserv=
ed</div><div>[=C2=A0 =C2=A0 0.532167] system 00:05: [io=C2=A0 0x0b00-0x0b0f=
] has been reserved</div><div>[=C2=A0 =C2=A0 0.532168] system 00:05: [io=C2=
=A0 0x0b20-0x0b3f] has been reserved</div><div>[=C2=A0 =C2=A0 0.532170] sys=
tem 00:05: [io=C2=A0 0x0900-0x090f] has been reserved</div><div>[=C2=A0 =C2=
=A0 0.532172] system 00:05: [io=C2=A0 0x0910-0x091f] has been reserved</div=
><div>[=C2=A0 =C2=A0 0.532175] system 00:05: [mem 0xfec00000-0xfec00fff] co=
uld not be reserved</div><div>[=C2=A0 =C2=A0 0.532177] system 00:05: [mem 0=
xfec01000-0xfec01fff] could not be reserved</div><div>[=C2=A0 =C2=A0 0.5321=
79] system 00:05: [mem 0xfedc0000-0xfedc0fff] has been reserved</div><div>[=
=C2=A0 =C2=A0 0.532181] system 00:05: [mem 0xfee00000-0xfee00fff] has been =
reserved</div><div>[=C2=A0 =C2=A0 0.532183] system 00:05: [mem 0xfed80000-0=
xfed8ffff] could not be reserved</div><div>[=C2=A0 =C2=A0 0.532185] system =
00:05: [mem 0xfec10000-0xfec10fff] has been reserved</div><div>[=C2=A0 =C2=
=A0 0.532187] system 00:05: [mem 0xff000000-0xffffffff] has been reserved</=
div><div>[=C2=A0 =C2=A0 0.532191] system 00:05: Plug and Play ACPI device, =
IDs PNP0c02 (active)</div><div>[=C2=A0 =C2=A0 0.532918] pnp: PnP ACPI: foun=
d 6 devices</div><div>[=C2=A0 =C2=A0 0.544268] clocksource: acpi_pm: mask: =
0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns</div><div>[=C2=A0=
 =C2=A0 0.544287] pci 0000:00:01.6: bridge window [io=C2=A0 0x1000-0x0fff] =
to [bus 01] add_size 1000</div><div>[=C2=A0 =C2=A0 0.544290] pci 0000:00:01=
.6: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 01] add_si=
ze 200000 add_align 100000</div><div>[=C2=A0 =C2=A0 0.544326] pci 0000:00:0=
1.6: BAR 15: assigned [mem 0xf0200000-0xf03fffff 64bit pref]</div><div>[=C2=
=A0 =C2=A0 0.544331] pci 0000:00:01.6: BAR 13: assigned [io=C2=A0 0x1000-0x=
1fff]</div><div>[=C2=A0 =C2=A0 0.544333] pci 0000:00:01.6: PCI bridge to [b=
us 01]</div><div>[=C2=A0 =C2=A0 0.544336] pci 0000:00:01.6:=C2=A0 =C2=A0bri=
dge window [io=C2=A0 0x1000-0x1fff]</div><div>[=C2=A0 =C2=A0 0.544342] pci =
0000:00:01.6:=C2=A0 =C2=A0bridge window [mem 0xfe300000-0xfe3fffff]</div><d=
iv>[=C2=A0 =C2=A0 0.544347] pci 0000:00:01.6:=C2=A0 =C2=A0bridge window [me=
m 0xf0200000-0xf03fffff 64bit pref]</div><div>[=C2=A0 =C2=A0 0.544354] pci =
0000:00:01.7: PCI bridge to [bus 02]</div><div>[=C2=A0 =C2=A0 0.544357] pci=
 0000:00:01.7:=C2=A0 =C2=A0bridge window [io=C2=A0 0xf000-0xffff]</div><div=
>[=C2=A0 =C2=A0 0.544363] pci 0000:00:01.7:=C2=A0 =C2=A0bridge window [mem =
0xfe200000-0xfe2fffff]</div><div>[=C2=A0 =C2=A0 0.544374] pci 0000:00:08.1:=
 PCI bridge to [bus 03]</div><div>[=C2=A0 =C2=A0 0.544377] pci 0000:00:08.1=
:=C2=A0 =C2=A0bridge window [io=C2=A0 0xe000-0xefff]</div><div>[=C2=A0 =C2=
=A0 0.544382] pci 0000:00:08.1:=C2=A0 =C2=A0bridge window [mem 0xfdd00000-0=
xfe0fffff]</div><div>[=C2=A0 =C2=A0 0.544386] pci 0000:00:08.1:=C2=A0 =C2=
=A0bridge window [mem 0xe0000000-0xf01fffff 64bit pref]</div><div>[=C2=A0 =
=C2=A0 0.544394] pci 0000:00:08.2: PCI bridge to [bus 04]</div><div>[=C2=A0=
 =C2=A0 0.544400] pci 0000:00:08.2:=C2=A0 =C2=A0bridge window [mem 0xfe1000=
00-0xfe1fffff]</div><div>[=C2=A0 =C2=A0 0.544411] pci_bus 0000:00: resource=
 4 [io=C2=A0 0x0000-0x03af window]</div><div>[=C2=A0 =C2=A0 0.544413] pci_b=
us 0000:00: resource 5 [io=C2=A0 0x03e0-0x0cf7 window]</div><div>[=C2=A0 =
=C2=A0 0.544414] pci_bus 0000:00: resource 6 [io=C2=A0 0x03b0-0x03df window=
]</div><div>[=C2=A0 =C2=A0 0.544416] pci_bus 0000:00: resource 7 [io=C2=A0 =
0x0d00-0xffff window]</div><div>[=C2=A0 =C2=A0 0.544418] pci_bus 0000:00: r=
esource 8 [mem 0x000a0000-0x000bffff window]</div><div>[=C2=A0 =C2=A0 0.544=
419] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff window]</div><d=
iv>[=C2=A0 =C2=A0 0.544421] pci_bus 0000:00: resource 10 [mem 0xe0000000-0x=
febfffff window]</div><div>[=C2=A0 =C2=A0 0.544422] pci_bus 0000:00: resour=
ce 11 [mem 0xfee00000-0xffffffff window]</div><div>[=C2=A0 =C2=A0 0.544424]=
 pci_bus 0000:01: resource 0 [io=C2=A0 0x1000-0x1fff]</div><div>[=C2=A0 =C2=
=A0 0.544426] pci_bus 0000:01: resource 1 [mem 0xfe300000-0xfe3fffff]</div>=
<div>[=C2=A0 =C2=A0 0.544427] pci_bus 0000:01: resource 2 [mem 0xf0200000-0=
xf03fffff 64bit pref]</div><div>[=C2=A0 =C2=A0 0.544429] pci_bus 0000:02: r=
esource 0 [io=C2=A0 0xf000-0xffff]</div><div>[=C2=A0 =C2=A0 0.544431] pci_b=
us 0000:02: resource 1 [mem 0xfe200000-0xfe2fffff]</div><div>[=C2=A0 =C2=A0=
 0.544432] pci_bus 0000:03: resource 0 [io=C2=A0 0xe000-0xefff]</div><div>[=
=C2=A0 =C2=A0 0.544434] pci_bus 0000:03: resource 1 [mem 0xfdd00000-0xfe0ff=
fff]</div><div>[=C2=A0 =C2=A0 0.544435] pci_bus 0000:03: resource 2 [mem 0x=
e0000000-0xf01fffff 64bit pref]</div><div>[=C2=A0 =C2=A0 0.544437] pci_bus =
0000:04: resource 1 [mem 0xfe100000-0xfe1fffff]</div><div>[=C2=A0 =C2=A0 0.=
544681] NET: Registered protocol family 2</div><div>[=C2=A0 =C2=A0 0.545002=
] tcp_listen_portaddr_hash hash table entries: 16384 (order: 6, 262144 byte=
s)</div><div>[=C2=A0 =C2=A0 0.545117] TCP established hash table entries: 2=
62144 (order: 9, 2097152 bytes)</div><div>[=C2=A0 =C2=A0 0.545602] TCP bind=
 hash table entries: 65536 (order: 8, 1048576 bytes)</div><div>[=C2=A0 =C2=
=A0 0.545767] TCP: Hash tables configured (established 262144 bind 65536)</=
div><div>[=C2=A0 =C2=A0 0.545847] UDP hash table entries: 16384 (order: 7, =
524288 bytes)</div><div>[=C2=A0 =C2=A0 0.545950] UDP-Lite hash table entrie=
s: 16384 (order: 7, 524288 bytes)</div><div>[=C2=A0 =C2=A0 0.546165] NET: R=
egistered protocol family 1</div><div>[=C2=A0 =C2=A0 0.546171] NET: Registe=
red protocol family 44</div><div>[=C2=A0 =C2=A0 0.546316] pci 0000:03:00.0:=
 Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]</div><div>[=
=C2=A0 =C2=A0 0.546341] pci 0000:03:00.1: Linked as a consumer to 0000:03:0=
0.0</div><div>[=C2=A0 =C2=A0 0.546871] PCI: CLS 64 bytes, default 64</div><=
div>[=C2=A0 =C2=A0 0.546934] Unpacking initramfs...</div><div>[=C2=A0 =C2=
=A0 0.911016] Freeing initrd memory: 17360K</div><div>[=C2=A0 =C2=A0 0.9110=
52] AMD-Vi: Unable to write to IOMMU perf counter.</div><div>[=C2=A0 =C2=A0=
 0.911200] pci 0000:00:00.2: can&#39;t derive routing for PCI INT A</div><d=
iv>[=C2=A0 =C2=A0 0.911202] pci 0000:00:00.2: PCI INT A: not connected</div=
><div>[=C2=A0 =C2=A0 0.911705] iommu: Adding device 0000:00:01.0 to group 0=
</div><div>[=C2=A0 =C2=A0 0.911956] iommu: Adding device 0000:00:01.6 to gr=
oup 1</div><div>[=C2=A0 =C2=A0 0.912188] iommu: Adding device 0000:00:01.7 =
to group 2</div><div>[=C2=A0 =C2=A0 0.912429] iommu: Adding device 0000:00:=
08.0 to group 3</div><div>[=C2=A0 =C2=A0 0.912462] iommu: Adding device 000=
0:00:08.1 to group 3</div><div>[=C2=A0 =C2=A0 0.912493] iommu: Adding devic=
e 0000:00:08.2 to group 3</div><div>[=C2=A0 =C2=A0 0.912709] iommu: Adding =
device 0000:00:14.0 to group 4</div><div>[=C2=A0 =C2=A0 0.912753] iommu: Ad=
ding device 0000:00:14.3 to group 4</div><div>[=C2=A0 =C2=A0 0.913001] iomm=
u: Adding device 0000:00:18.0 to group 5</div><div>[=C2=A0 =C2=A0 0.913072]=
 iommu: Adding device 0000:00:18.1 to group 5</div><div>[=C2=A0 =C2=A0 0.91=
3104] iommu: Adding device 0000:00:18.2 to group 5</div><div>[=C2=A0 =C2=A0=
 0.913136] iommu: Adding device 0000:00:18.3 to group 5</div><div>[=C2=A0 =
=C2=A0 0.913169] iommu: Adding device 0000:00:18.4 to group 5</div><div>[=
=C2=A0 =C2=A0 0.913205] iommu: Adding device 0000:00:18.5 to group 5</div><=
div>[=C2=A0 =C2=A0 0.913237] iommu: Adding device 0000:00:18.6 to group 5</=
div><div>[=C2=A0 =C2=A0 0.913268] iommu: Adding device 0000:00:18.7 to grou=
p 5</div><div>[=C2=A0 =C2=A0 0.913542] iommu: Adding device 0000:01:00.0 to=
 group 6</div><div>[=C2=A0 =C2=A0 0.913834] iommu: Adding device 0000:02:00=
.0 to group 7</div><div>[=C2=A0 =C2=A0 0.913922] iommu: Adding device 0000:=
03:00.0 to group 3</div><div>[=C2=A0 =C2=A0 0.914008] iommu: Adding device =
0000:03:00.1 to group 3</div><div>[=C2=A0 =C2=A0 0.914077] iommu: Adding de=
vice 0000:03:00.2 to group 3</div><div>[=C2=A0 =C2=A0 0.914145] iommu: Addi=
ng device 0000:03:00.3 to group 3</div><div>[=C2=A0 =C2=A0 0.914214] iommu:=
 Adding device 0000:03:00.4 to group 3</div><div>[=C2=A0 =C2=A0 0.914284] i=
ommu: Adding device 0000:03:00.6 to group 3</div><div>[=C2=A0 =C2=A0 0.9143=
55] iommu: Adding device 0000:04:00.0 to group 3</div><div>[=C2=A0 =C2=A0 0=
.914669] AMD-Vi: Found IOMMU at 0000:00:00.2 cap 0x40</div><div>[=C2=A0 =C2=
=A0 0.914671] AMD-Vi: Extended features (0xf77ef22294ada):</div><div>[=C2=
=A0 =C2=A0 0.914671]=C2=A0 PPR NX GT IA GA PC GA_vAPIC</div><div>[=C2=A0 =
=C2=A0 0.914675] AMD-Vi: Interrupt remapping enabled</div><div>[=C2=A0 =C2=
=A0 0.914676] AMD-Vi: virtual APIC enabled</div><div>[=C2=A0 =C2=A0 1.01088=
3] AMD-Vi: Lazy IO/TLB flushing enabled</div><div>[=C2=A0 =C2=A0 1.012398] =
amd_uncore: AMD NB counters detected</div><div>[=C2=A0 =C2=A0 1.012403] amd=
_uncore: AMD LLC counters detected</div><div>[=C2=A0 =C2=A0 1.013727] Scann=
ing for low memory corruption every 60 seconds</div><div>[=C2=A0 =C2=A0 1.0=
15077] Initialise system trusted keyrings</div><div>[=C2=A0 =C2=A0 1.015136=
] Key type blacklist registered</div><div>[=C2=A0 =C2=A0 1.015279] workings=
et: timestamp_bits=3D41 max_order=3D23 bucket_order=3D0</div><div>[=C2=A0 =
=C2=A0 1.017304] zbud: loaded</div><div>[=C2=A0 =C2=A0 1.017688] pstore: us=
ing lz4hc compression</div><div>[=C2=A0 =C2=A0 1.022492] Key type asymmetri=
c registered</div><div>[=C2=A0 =C2=A0 1.022494] Asymmetric key parser &#39;=
x509&#39; registered</div><div>[=C2=A0 =C2=A0 1.022571] Block layer SCSI ge=
neric (bsg) driver version 0.4 loaded (major 245)</div><div>[=C2=A0 =C2=A0 =
1.022738] io scheduler noop registered</div><div>[=C2=A0 =C2=A0 1.022740] i=
o scheduler deadline registered</div><div>[=C2=A0 =C2=A0 1.022870] io sched=
uler cfq registered (default)</div><div>[=C2=A0 =C2=A0 1.022871] io schedul=
er mq-deadline registered</div><div>[=C2=A0 =C2=A0 1.022872] io scheduler k=
yber registered</div><div>[=C2=A0 =C2=A0 1.022933] io scheduler bfq registe=
red</div><div>[=C2=A0 =C2=A0 1.024743] pcieport 0000:00:01.6: Signaling PME=
 with IRQ 26</div><div>[=C2=A0 =C2=A0 1.024776] pcieport 0000:00:01.7: Sign=
aling PME with IRQ 27</div><div>[=C2=A0 =C2=A0 1.024820] pcieport 0000:00:0=
8.1: Signaling PME with IRQ 28</div><div>[=C2=A0 =C2=A0 1.024857] pcieport =
0000:00:08.2: Signaling PME with IRQ 29</div><div>[=C2=A0 =C2=A0 1.024888] =
pciehp 0000:00:01.6:pcie004: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd=
- HotPlug+ Surprise- Interlock- NoCompl+ LLActRep+</div><div>[=C2=A0 =C2=A0=
 1.024934] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4</di=
v><div>[=C2=A0 =C2=A0 1.025017] vesafb: mode is 1920x1080x32, linelength=3D=
7680, pages=3D0</div><div>[=C2=A0 =C2=A0 1.025018] vesafb: scrolling: redra=
w</div><div>[=C2=A0 =C2=A0 1.025020] vesafb: Truecolor: size=3D0:8:8:8, shi=
ft=3D0:16:8:0</div><div>[=C2=A0 =C2=A0 1.025036] vesafb: framebuffer at 0xe=
0000000, mapped to 0x(____ptrval____), using 8128k, total 8128k</div><div>[=
=C2=A0 =C2=A0 1.117288] Console: switching to colour frame buffer device 24=
0x67</div><div>[=C2=A0 =C2=A0 1.167604] fb0: VESA VGA frame buffer device</=
div><div>[=C2=A0 =C2=A0 1.167704] input: Power Button as /devices/LNXSYSTM:=
00/LNXSYBUS:00/PNP0C0C:00/input/input0</div><div>[=C2=A0 =C2=A0 1.167714] A=
CPI: Power Button [PWRB]</div><div>[=C2=A0 =C2=A0 1.167765] input: Lid Swit=
ch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input1</div><div>[=
=C2=A0 =C2=A0 1.167771] ACPI: Lid Switch [LID0]</div><div>[=C2=A0 =C2=A0 1.=
167823] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input=
2</div><div>[=C2=A0 =C2=A0 1.167839] ACPI: Power Button [PWRF]</div><div>[=
=C2=A0 =C2=A0 1.167969] ACPI: Video Device [VGA2] (multi-head: yes=C2=A0 ro=
m: no=C2=A0 post: no)</div><div>[=C2=A0 =C2=A0 1.168298] acpi device:16: re=
gistered as cooling_device0</div><div>[=C2=A0 =C2=A0 1.168357] input: Video=
 Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:15/LNXVIDEO:02/i=
nput/input3</div><div>[=C2=A0 =C2=A0 1.168406] Monitor-Mwait will be used t=
o enter C-1 state</div><div>[=C2=A0 =C2=A0 1.174071] thermal LNXTHERM:00: r=
egistered as thermal_zone0</div><div>[=C2=A0 =C2=A0 1.174073] ACPI: Thermal=
 Zone [TZS0] (54 C)</div><div>[=C2=A0 =C2=A0 1.174580] thermal LNXTHERM:01:=
 registered as thermal_zone1</div><div>[=C2=A0 =C2=A0 1.174581] ACPI: Therm=
al Zone [TZS1] (49 C)</div><div>[=C2=A0 =C2=A0 1.175186] Serial: 8250/16550=
 driver, 4 ports, IRQ sharing enabled</div><div>[=C2=A0 =C2=A0 1.177754] le=
dtrig-cpu: registered to indicate activity on CPUs</div><div>[=C2=A0 =C2=A0=
 1.178519] NET: Registered protocol family 10</div><div>[=C2=A0 =C2=A0 1.18=
4065] Segment Routing with IPv6</div><div>[=C2=A0 =C2=A0 1.184093] NET: Reg=
istered protocol family 17</div><div>[=C2=A0 =C2=A0 1.185071] RAS: Correcta=
ble Errors collector initialized.</div><div>[=C2=A0 =C2=A0 1.186575] microc=
ode: CPU0: patch_level=3D0x08101007</div><div>[=C2=A0 =C2=A0 1.186587] micr=
ocode: CPU1: patch_level=3D0x08101007</div><div>[=C2=A0 =C2=A0 1.186591] mi=
crocode: CPU2: patch_level=3D0x08101007</div><div>[=C2=A0 =C2=A0 1.186600] =
microcode: CPU3: patch_level=3D0x08101007</div><div>[=C2=A0 =C2=A0 1.186914=
] microcode: CPU4: patch_level=3D0x08101007</div><div>[=C2=A0 =C2=A0 1.1869=
23] microcode: CPU5: patch_level=3D0x08101007</div><div>[=C2=A0 =C2=A0 1.18=
6948] microcode: CPU6: patch_level=3D0x08101007</div><div>[=C2=A0 =C2=A0 1.=
186956] microcode: CPU7: patch_level=3D0x08101007</div><div>[=C2=A0 =C2=A0 =
1.187070] microcode: Microcode Update Driver: v2.2.</div><div>[=C2=A0 =C2=
=A0 1.187100] sched_clock: Marking stable (1187064456, 0)-&gt;(1382906531, =
-195842075)</div><div>[=C2=A0 =C2=A0 1.187642] registered taskstats version=
 1</div><div>[=C2=A0 =C2=A0 1.187653] Loading compiled-in X.509 certificate=
s</div><div>[=C2=A0 =C2=A0 1.187682] zswap: loaded using pool lzo/zbud</div=
><div>[=C2=A0 =C2=A0 1.192243] Key type big_key registered</div><div>[=C2=
=A0 =C2=A0 1.192907]=C2=A0 =C2=A0Magic number: 14:303:953</div><div>[=C2=A0=
 =C2=A0 1.192989] memory memory6: hash matches</div><div>[=C2=A0 =C2=A0 1.1=
92995] hctosys: unable to open rtc device (rtc0)</div><div>[=C2=A0 =C2=A0 1=
.587197] Freeing unused kernel memory: 1488K</div><div>[=C2=A0 =C2=A0 1.587=
199] Write protecting the kernel read-only data: 16384k</div><div>[=C2=A0 =
=C2=A0 1.589231] Freeing unused kernel memory: 2016K</div><div>[=C2=A0 =C2=
=A0 1.591200] Freeing unused kernel memory: 568K</div><div>[=C2=A0 =C2=A0 1=
.693784] i8042: PNP: PS/2 Controller [PNP0303:KBD0,PNP0f13:PS2M] at 0x60,0x=
64 irq 1,12</div><div>[=C2=A0 =C2=A0 1.700440] serio: i8042 KBD port at 0x6=
0,0x64 irq 1</div><div>[=C2=A0 =C2=A0 1.700528] serio: i8042 AUX port at 0x=
60,0x64 irq 12</div><div>[=C2=A0 =C2=A0 1.702175] cryptd: max_cpu_qlen set =
to 1000</div><div>[=C2=A0 =C2=A0 1.705654] ACPI: bus type USB registered</d=
iv><div>[=C2=A0 =C2=A0 1.705698] usbcore: registered new interface driver u=
sbfs</div><div>[=C2=A0 =C2=A0 1.705711] usbcore: registered new interface d=
river hub</div><div>[=C2=A0 =C2=A0 1.705782] usbcore: registered new device=
 driver usb</div><div>[=C2=A0 =C2=A0 1.706708] AVX2 version of gcm_enc/dec =
engaged.</div><div>[=C2=A0 =C2=A0 1.706711] AES CTR mode by8 optimization e=
nabled</div><div>[=C2=A0 =C2=A0 1.707948] SCSI subsystem initialized</div><=
div>[=C2=A0 =C2=A0 1.713077] xhci_hcd 0000:03:00.3: xHCI Host Controller</d=
iv><div>[=C2=A0 =C2=A0 1.713087] xhci_hcd 0000:03:00.3: new USB bus registe=
red, assigned bus number 1</div><div>[=C2=A0 =C2=A0 1.713279] xhci_hcd 0000=
:03:00.3: hcc params 0x0270ffe5 hci version 0x110 quirks 0x0000000040000410=
</div><div>[=C2=A0 =C2=A0 1.714026] usb usb1: New USB device found, idVendo=
r=3D1d6b, idProduct=3D0002, bcdDevice=3D 4.18</div><div>[=C2=A0 =C2=A0 1.71=
4028] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=
=3D1</div><div>[=C2=A0 =C2=A0 1.714030] usb usb1: Product: xHCI Host Contro=
ller</div><div>[=C2=A0 =C2=A0 1.714031] usb usb1: Manufacturer: Linux 4.18.=
1-arch1-1-ARCH xhci-hcd</div><div>[=C2=A0 =C2=A0 1.714033] usb usb1: Serial=
Number: 0000:03:00.3</div><div>[=C2=A0 =C2=A0 1.714230] hub 1-0:1.0: USB hu=
b found</div><div>[=C2=A0 =C2=A0 1.714250] hub 1-0:1.0: 4 ports detected</d=
iv><div>[=C2=A0 =C2=A0 1.714320] libata version 3.00 loaded.</div><div>[=C2=
=A0 =C2=A0 1.715393] xhci_hcd 0000:03:00.3: xHCI Host Controller</div><div>=
[=C2=A0 =C2=A0 1.715403] xhci_hcd 0000:03:00.3: new USB bus registered, ass=
igned bus number 2</div><div>[=C2=A0 =C2=A0 1.715410] xhci_hcd 0000:03:00.3=
: Host supports USB 3.10 Enhanced SuperSpeed</div><div>[=C2=A0 =C2=A0 1.715=
440] usb usb2: We don&#39;t know the algorithms for LPM for this host, disa=
bling LPM.</div><div>[=C2=A0 =C2=A0 1.715470] usb usb2: New USB device foun=
d, idVendor=3D1d6b, idProduct=3D0003, bcdDevice=3D 4.18</div><div>[=C2=A0 =
=C2=A0 1.715472] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D1</div><div>[=C2=A0 =C2=A0 1.715474] usb usb2: Product: xHCI H=
ost Controller</div><div>[=C2=A0 =C2=A0 1.715476] usb usb2: Manufacturer: L=
inux 4.18.1-arch1-1-ARCH xhci-hcd</div><div>[=C2=A0 =C2=A0 1.715478] usb us=
b2: SerialNumber: 0000:03:00.3</div><div>[=C2=A0 =C2=A0 1.715676] hub 2-0:1=
.0: USB hub found</div><div>[=C2=A0 =C2=A0 1.715693] hub 2-0:1.0: 4 ports d=
etected</div><div>[=C2=A0 =C2=A0 1.716382] ahci 0000:04:00.0: version 3.0</=
div><div>[=C2=A0 =C2=A0 1.716998] xhci_hcd 0000:03:00.4: xHCI Host Controll=
er</div><div>[=C2=A0 =C2=A0 1.717004] xhci_hcd 0000:03:00.4: new USB bus re=
gistered, assigned bus number 3</div><div>[=C2=A0 =C2=A0 1.717143] xhci_hcd=
 0000:03:00.4: hcc params 0x0260ffe5 hci version 0x110 quirks 0x00000000400=
00410</div><div>[=C2=A0 =C2=A0 1.717762] usb usb3: New USB device found, id=
Vendor=3D1d6b, idProduct=3D0002, bcdDevice=3D 4.18</div><div>[=C2=A0 =C2=A0=
 1.717764] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, SerialNu=
mber=3D1</div><div>[=C2=A0 =C2=A0 1.717765] usb usb3: Product: xHCI Host Co=
ntroller</div><div>[=C2=A0 =C2=A0 1.717767] usb usb3: Manufacturer: Linux 4=
.18.1-arch1-1-ARCH xhci-hcd</div><div>[=C2=A0 =C2=A0 1.717768] usb usb3: Se=
rialNumber: 0000:03:00.4</div><div>[=C2=A0 =C2=A0 1.718003] hub 3-0:1.0: US=
B hub found</div><div>[=C2=A0 =C2=A0 1.718023] hub 3-0:1.0: 2 ports detecte=
d</div><div>[=C2=A0 =C2=A0 1.718718] xhci_hcd 0000:03:00.4: xHCI Host Contr=
oller</div><div>[=C2=A0 =C2=A0 1.718724] xhci_hcd 0000:03:00.4: new USB bus=
 registered, assigned bus number 4</div><div>[=C2=A0 =C2=A0 1.718729] xhci_=
hcd 0000:03:00.4: Host supports USB 3.10 Enhanced SuperSpeed</div><div>[=C2=
=A0 =C2=A0 1.718758] usb usb4: We don&#39;t know the algorithms for LPM for=
 this host, disabling LPM.</div><div>[=C2=A0 =C2=A0 1.718793] usb usb4: New=
 USB device found, idVendor=3D1d6b, idProduct=3D0003, bcdDevice=3D 4.18</di=
v><div>[=C2=A0 =C2=A0 1.718796] usb usb4: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1</div><div>[=C2=A0 =C2=A0 1.718798] usb usb4: =
Product: xHCI Host Controller</div><div>[=C2=A0 =C2=A0 1.718800] usb usb4: =
Manufacturer: Linux 4.18.1-arch1-1-ARCH xhci-hcd</div><div>[=C2=A0 =C2=A0 1=
.718802] usb usb4: SerialNumber: 0000:03:00.4</div><div>[=C2=A0 =C2=A0 1.71=
9007] hub 4-0:1.0: USB hub found</div><div>[=C2=A0 =C2=A0 1.719029] hub 4-0=
:1.0: 1 port detected</div><div>[=C2=A0 =C2=A0 1.727051] ahci 0000:04:00.0:=
 AHCI 0001.0301 32 slots 2 ports 6 Gbps 0x3 impl SATA mode</div><div>[=C2=
=A0 =C2=A0 1.727056] ahci 0000:04:00.0: flags: 64bit ncq sntf ilck pm led c=
lo only pmp fbs pio slum part deso sadm sds=C2=A0</div><div>[=C2=A0 =C2=A0 =
1.727060] ahci 0000:04:00.0: both AHCI_HFLAG_MULTI_MSI flag set and custom =
irq handler implemented</div><div>[=C2=A0 =C2=A0 1.727653] scsi host0: ahci=
</div><div>[=C2=A0 =C2=A0 1.728020] scsi host1: ahci</div><div>[=C2=A0 =C2=
=A0 1.728091] ata1: SATA max UDMA/133 abar m2048@0xfe100000 port 0xfe100100=
 irq 42</div><div>[=C2=A0 =C2=A0 1.728095] ata2: SATA max UDMA/133 abar m20=
48@0xfe100000 port 0xfe100180 irq 43</div><div>[=C2=A0 =C2=A0 1.732184] inp=
ut: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/in=
put4</div><div>[=C2=A0 =C2=A0 2.023780] tsc: Refined TSC clocksource calibr=
ation: 1996.241 MHz</div><div>[=C2=A0 =C2=A0 2.023798] clocksource: tsc: ma=
sk: 0xffffffffffffffff max_cycles: 0x398c9e7ced1, max_idle_ns: 881590497691=
 ns</div><div>[=C2=A0 =C2=A0 2.024830] clocksource: Switched to clocksource=
 tsc</div><div>[=C2=A0 =C2=A0 2.043386] usb 1-4: new high-speed USB device =
number 2 using xhci_hcd</div><div>[=C2=A0 =C2=A0 2.046708] usb 3-2: new hig=
h-speed USB device number 2 using xhci_hcd</div><div>[=C2=A0 =C2=A0 2.18900=
6] usb 3-2: New USB device found, idVendor=3D05e3, idProduct=3D0608, bcdDev=
ice=3D88.32</div><div>[=C2=A0 =C2=A0 2.189009] usb 3-2: New USB device stri=
ngs: Mfr=3D0, Product=3D1, SerialNumber=3D0</div><div>[=C2=A0 =C2=A0 2.1890=
11] usb 3-2: Product: USB2.0 Hub</div><div>[=C2=A0 =C2=A0 2.196740] ata1: S=
ATA link up 6.0 Gbps (SStatus 133 SControl 300)</div><div>[=C2=A0 =C2=A0 2.=
196782] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)</div><div>[=
=C2=A0 =C2=A0 2.197553] ata1.00: ATA-9: WDC WDS240G2G0B-00EPW0, UJ190000, m=
ax UDMA/133</div><div>[=C2=A0 =C2=A0 2.197557] ata1.00: 468877312 sectors, =
multi 1: LBA48 NCQ (depth 32)</div><div>[=C2=A0 =C2=A0 2.199116] ata2.00: A=
TA-9: HGST HTS721010A9E630, JB0OA3T0, max UDMA/133</div><div>[=C2=A0 =C2=A0=
 2.199119] ata2.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 32), AA<=
/div><div>[=C2=A0 =C2=A0 2.201241] ata2.00: configured for UDMA/133</div><d=
iv>[=C2=A0 =C2=A0 2.202935] ata1.00: configured for UDMA/133</div><div>[=C2=
=A0 =C2=A0 2.203630] scsi 0:0:0:0: Direct-Access=C2=A0 =C2=A0 =C2=A0ATA=C2=
=A0 =C2=A0 =C2=A0 WDC WDS240G2G0B- 0000 PQ: 0 ANSI: 5</div><div>[=C2=A0 =C2=
=A0 2.204339] scsi 1:0:0:0: Direct-Access=C2=A0 =C2=A0 =C2=A0ATA=C2=A0 =C2=
=A0 =C2=A0 HGST HTS721010A9 A3T0 PQ: 0 ANSI: 5</div><div>[=C2=A0 =C2=A0 2.2=
07091] sd 1:0:0:0: [sdb] 1953525168 512-byte logical blocks: (1.00 TB/932 G=
iB)</div><div>[=C2=A0 =C2=A0 2.207093] sd 1:0:0:0: [sdb] 4096-byte physical=
 blocks</div><div>[=C2=A0 =C2=A0 2.207097] sd 0:0:0:0: [sda] 468877312 512-=
byte logical blocks: (240 GB/224 GiB)</div><div>[=C2=A0 =C2=A0 2.207112] sd=
 0:0:0:0: [sda] Write Protect is off</div><div>[=C2=A0 =C2=A0 2.207114] sd =
0:0:0:0: [sda] Mode Sense: 00 3a 00 00</div><div>[=C2=A0 =C2=A0 2.207117] s=
d 1:0:0:0: [sdb] Write Protect is off</div><div>[=C2=A0 =C2=A0 2.207121] sd=
 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00</div><div>[=C2=A0 =C2=A0 2.207141] =
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn&#39;t su=
pport DPO or FUA</div><div>[=C2=A0 =C2=A0 2.207168] sd 1:0:0:0: [sdb] Write=
 cache: enabled, read cache: enabled, doesn&#39;t support DPO or FUA</div><=
div>[=C2=A0 =C2=A0 2.207822]=C2=A0 sda: sda1 sda2</div><div>[=C2=A0 =C2=A0 =
2.208207] sd 0:0:0:0: [sda] Attached SCSI disk</div><div>[=C2=A0 =C2=A0 2.2=
24862] usb 1-4: New USB device found, idVendor=3D04f2, idProduct=3Db593, bc=
dDevice=3D 0.10</div><div>[=C2=A0 =C2=A0 2.224865] usb 1-4: New USB device =
strings: Mfr=3D3, Product=3D1, SerialNumber=3D2</div><div>[=C2=A0 =C2=A0 2.=
224868] usb 1-4: Product: HP Wide Vision FHD Camera</div><div>[=C2=A0 =C2=
=A0 2.224869] usb 1-4: Manufacturer: Chicony Electronics Co.,Ltd.</div><div=
>[=C2=A0 =C2=A0 2.224871] usb 1-4: SerialNumber: 1</div><div>[=C2=A0 =C2=A0=
 2.232069] hub 3-2:1.0: USB hub found</div><div>[=C2=A0 =C2=A0 2.232528] hu=
b 3-2:1.0: 4 ports detected</div><div>[=C2=A0 =C2=A0 2.504296]=C2=A0 sdb: s=
db1 sdb2 sdb3 sdb4 sdb5 sdb6</div><div>[=C2=A0 =C2=A0 2.506059] sd 1:0:0:0:=
 [sdb] Attached SCSI disk</div><div>[=C2=A0 =C2=A0 2.523952] usb 3-2.3: new=
 full-speed USB device number 3 using xhci_hcd</div><div>[=C2=A0 =C2=A0 2.6=
03357] raid6: sse2x1=C2=A0 =C2=A0gen()=C2=A0 4685 MB/s</div><div>[=C2=A0 =
=C2=A0 2.638832] usb 3-2.3: New USB device found, idVendor=3D0483, idProduc=
t=3D91d1, bcdDevice=3D 1.11</div><div>[=C2=A0 =C2=A0 2.638835] usb 3-2.3: N=
ew USB device strings: Mfr=3D1, Product=3D2, SerialNumber=3D3</div><div>[=
=C2=A0 =C2=A0 2.638838] usb 3-2.3: Product: ST_SENSOR_HUB</div><div>[=C2=A0=
 =C2=A0 2.638840] usb 3-2.3: Manufacturer: STMicroelectronics</div><div>[=
=C2=A0 =C2=A0 2.638842] usb 3-2.3: SerialNumber: ST_SENSOR_HUB</div><div>[=
=C2=A0 =C2=A0 2.660009] raid6: sse2x1=C2=A0 =C2=A0xor()=C2=A0 4196 MB/s</di=
v><div>[=C2=A0 =C2=A0 2.683660] hidraw: raw HID events driver (C) Jiri Kosi=
na</div><div>[=C2=A0 =C2=A0 2.698867] usbcore: registered new interface dri=
ver usbhid</div><div>[=C2=A0 =C2=A0 2.698868] usbhid: USB HID core driver</=
div><div>[=C2=A0 =C2=A0 2.702700] hid-generic 0003:0483:91D1.0001: hiddev0,=
hidraw0: USB HID v1.10 Device [STMicroelectronics ST_SENSOR_HUB] on usb-000=
0:03:00.4-2.3/input0</div><div>[=C2=A0 =C2=A0 2.716685] raid6: sse2x2=C2=A0=
 =C2=A0gen()=C2=A0 8136 MB/s</div><div>[=C2=A0 =C2=A0 2.753354] usb 3-2.4: =
new full-speed USB device number 4 using xhci_hcd</div><div>[=C2=A0 =C2=A0 =
2.773347] raid6: sse2x2=C2=A0 =C2=A0xor()=C2=A0 5703 MB/s</div><div>[=C2=A0=
 =C2=A0 2.830018] raid6: sse2x4=C2=A0 =C2=A0gen()=C2=A0 9263 MB/s</div><div=
>[=C2=A0 =C2=A0 2.850856] random: fast init done</div><div>[=C2=A0 =C2=A0 2=
.865856] usb 3-2.4: New USB device found, idVendor=3D0bda, idProduct=3Db00b=
, bcdDevice=3D 1.10</div><div>[=C2=A0 =C2=A0 2.865859] usb 3-2.4: New USB d=
evice strings: Mfr=3D1, Product=3D2, SerialNumber=3D3</div><div>[=C2=A0 =C2=
=A0 2.865861] usb 3-2.4: Product: Bluetooth Radio=C2=A0</div><div>[=C2=A0 =
=C2=A0 2.865863] usb 3-2.4: Manufacturer: Realtek=C2=A0</div><div>[=C2=A0 =
=C2=A0 2.865865] usb 3-2.4: SerialNumber: 00e04c000001</div><div>[=C2=A0 =
=C2=A0 2.886671] raid6: sse2x4=C2=A0 =C2=A0xor()=C2=A0 5370 MB/s</div><div>=
[=C2=A0 =C2=A0 2.943341] raid6: avx2x1=C2=A0 =C2=A0gen() 10008 MB/s</div><d=
iv>[=C2=A0 =C2=A0 3.000004] raid6: avx2x1=C2=A0 =C2=A0xor()=C2=A0 7566 MB/s=
</div><div>[=C2=A0 =C2=A0 3.056676] raid6: avx2x2=C2=A0 =C2=A0gen() 12642 M=
B/s</div><div>[=C2=A0 =C2=A0 3.113375] raid6: avx2x2=C2=A0 =C2=A0xor()=C2=
=A0 8141 MB/s</div><div>[=C2=A0 =C2=A0 3.170007] raid6: avx2x4=C2=A0 =C2=A0=
gen() 13201 MB/s</div><div>[=C2=A0 =C2=A0 3.226684] raid6: avx2x4=C2=A0 =C2=
=A0xor()=C2=A0 7591 MB/s</div><div>[=C2=A0 =C2=A0 3.226686] raid6: using al=
gorithm avx2x4 gen() 13201 MB/s</div><div>[=C2=A0 =C2=A0 3.226686] raid6: .=
... xor() 7591 MB/s, rmw enabled</div><div>[=C2=A0 =C2=A0 3.226688] raid6: =
using avx2x2 recovery algorithm</div><div>[=C2=A0 =C2=A0 3.231400] xor: aut=
omatically using best checksumming function=C2=A0 =C2=A0avx=C2=A0 =C2=A0 =
=C2=A0 =C2=A0</div><div>[=C2=A0 =C2=A0 3.261457] Btrfs loaded, crc32c=3Dcrc=
32c-intel</div><div>[=C2=A0 =C2=A0 3.262181] BTRFS: device label root devid=
 1 transid 138955 /dev/sda2</div><div>[=C2=A0 =C2=A0 3.262245] BTRFS: devic=
e label ARQUIVOS devid 1 transid 1514 /dev/sdb6</div><div>[=C2=A0 =C2=A0 3.=
286065] device-mapper: uevent: version 1.0.3</div><div>[=C2=A0 =C2=A0 3.286=
930] device-mapper: ioctl: 4.39.0-ioctl (2018-04-03) initialised: <a href=
=3D"mailto:dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a></div><div>[=C2=A0 =
=C2=A0 3.326186] BTRFS info (device sda2): disk space caching is enabled</d=
iv><div>[=C2=A0 =C2=A0 3.326188] BTRFS info (device sda2): has skinny exten=
ts</div><div>[=C2=A0 =C2=A0 3.433912] BTRFS info (device sda2): enabling ss=
d optimizations</div><div>[=C2=A0 =C2=A0 3.710486] systemd[1]: systemd 239 =
running in system mode. (+PAM -AUDIT -SELINUX -IMA -APPARMOR +SMACK -SYSVIN=
IT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFU=
TILS +KMOD -IDN2 +IDN +PCRE2 default-hierarchy=3Dhybrid)</div><div>[=C2=A0 =
=C2=A0 3.729359] systemd[1]: Detected architecture x86-64.</div><div>[=C2=
=A0 =C2=A0 3.745495] systemd[1]: Set hostname to &lt;braulio-laptop&gt;.</d=
iv><div>[=C2=A0 =C2=A0 3.904599] systemd[1]: /etc/systemd/system/rc-local.s=
ervice:11: Support for option SysVStartPriority=3D has been removed and it =
is ignored</div><div>[=C2=A0 =C2=A0 3.908859] random: systemd: uninitialize=
d urandom read (16 bytes read)</div><div>[=C2=A0 =C2=A0 3.909004] systemd[1=
]: Listening on Journal Socket.</div><div>[=C2=A0 =C2=A0 3.909802] random: =
systemd: uninitialized urandom read (16 bytes read)</div><div>[=C2=A0 =C2=
=A0 3.909858] systemd[1]: Started Forward Password Requests to Wall Directo=
ry Watch.</div><div>[=C2=A0 =C2=A0 3.910816] random: systemd: uninitialized=
 urandom read (16 bytes read)</div><div>[=C2=A0 =C2=A0 3.910899] systemd[1]=
: Listening on udev Kernel Socket.</div><div>[=C2=A0 =C2=A0 3.911721] syste=
md[1]: Listening on Journal Audit Socket.</div><div>[=C2=A0 =C2=A0 3.912428=
] systemd[1]: Started Dispatch Password Requests to Console Directory Watch=
.</div><div>[=C2=A0 =C2=A0 3.913345] systemd[1]: Reached target Local Encry=
pted Volumes.</div><div>[=C2=A0 =C2=A0 4.043824] sd 0:0:0:0: Attached scsi =
generic sg0 type 0</div><div>[=C2=A0 =C2=A0 4.043873] sd 1:0:0:0: Attached =
scsi generic sg1 type 0</div><div>[=C2=A0 =C2=A0 4.058177] vboxdrv: loading=
 out-of-tree module taints kernel.</div><div>[=C2=A0 =C2=A0 4.066401] vboxd=
rv: Found 8 processor cores</div><div>[=C2=A0 =C2=A0 4.087570] vboxdrv: TSC=
 mode is Invariant, tentative frequency 1996214607 Hz</div><div>[=C2=A0 =C2=
=A0 4.087572] vboxdrv: Successfully loaded version 5.2.18 (interface 0x0029=
0001)</div><div>[=C2=A0 =C2=A0 4.134788] VBoxPciLinuxInit</div><div>[=C2=A0=
 =C2=A0 4.134793] vboxpci: IOMMU found</div><div>[=C2=A0 =C2=A0 4.153543] V=
BoxNetAdp: Successfully started.</div><div>[=C2=A0 =C2=A0 4.156063] VBoxNet=
Flt: Successfully started.</div><div>[=C2=A0 =C2=A0 4.228852] BTRFS info (d=
evice sda2): use zstd compression, level 0</div><div>[=C2=A0 =C2=A0 4.22885=
7] BTRFS info (device sda2): turning on discard</div><div>[=C2=A0 =C2=A0 4.=
228859] BTRFS info (device sda2): enabling auto defrag</div><div>[=C2=A0 =
=C2=A0 4.228863] BTRFS info (device sda2): using default commit interval 30=
s</div><div>[=C2=A0 =C2=A0 4.228866] BTRFS info (device sda2): disk space c=
aching is enabled</div><div>[=C2=A0 =C2=A0 4.462103] systemd-journald[326]:=
 Received request to flush runtime journal from PID 1</div><div>[=C2=A0 =C2=
=A0 5.121602] acpi_cpufreq: overriding BIOS provided _PSD data</div><div>[=
=C2=A0 =C2=A0 5.122273] input: HP Wireless hotkeys as /devices/virtual/inpu=
t/input6</div><div>[=C2=A0 =C2=A0 5.123288] amd_gpio AMDI0030:00: Failed to=
 get gpio IRQ: -22</div><div>[=C2=A0 =C2=A0 5.149916] amd_gpio: probe of AM=
DI0030:00 failed with error -22</div><div>[=C2=A0 =C2=A0 5.150563] cmi: pro=
be of SMB0001:00 failed with error -5</div><div>[=C2=A0 =C2=A0 5.160559] rt=
c_cmos 00:02: RTC can wake from S4</div><div>[=C2=A0 =C2=A0 5.160942] rtc_c=
mos 00:02: registered as rtc0</div><div>[=C2=A0 =C2=A0 5.160985] rtc_cmos 0=
0:02: alarms up to one month, y3k, 114 bytes nvram, hpet irqs</div><div>[=
=C2=A0 =C2=A0 5.168738] hp_accel: laptop model unknown, using default axes =
configuration</div><div>[=C2=A0 =C2=A0 5.176315] ACPI: AC Adapter [ADP1] (o=
n-line)</div><div>[=C2=A0 =C2=A0 5.177353] acpi PNP0C14:01: duplicate WMI G=
UID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:00)=
</div><div>[=C2=A0 =C2=A0 5.198504] lis3lv02d: unknown sensor type 0x0</div=
><div>[=C2=A0 =C2=A0 5.201864] ACPI: Battery Slot [BAT0] (battery present)<=
/div><div>[=C2=A0 =C2=A0 5.224865] hp_accel: probe of HPQ6007:00 failed wit=
h error -22</div><div>[=C2=A0 =C2=A0 5.225183] piix4_smbus 0000:00:14.0: SM=
Bus Host Controller at 0xb00, revision 0</div><div>[=C2=A0 =C2=A0 5.225185]=
 piix4_smbus 0000:00:14.0: Using register 0x02 for SMBus port selection</di=
v><div>[=C2=A0 =C2=A0 5.236121] sp5100_tco: SP5100/SB800 TCO WatchDog Timer=
 Driver</div><div>[=C2=A0 =C2=A0 5.236277] sp5100-tco sp5100-tco: Using 0xf=
ed80b00 for watchdog MMIO address</div><div>[=C2=A0 =C2=A0 5.236286] sp5100=
-tco sp5100-tco: Watchdog hardware is disabled</div><div>[=C2=A0 =C2=A0 5.3=
07238] Linux agpgart interface v0.103</div><div>[=C2=A0 =C2=A0 5.352229] cf=
g80211: Loading compiled-in X.509 certificates for regulatory database</div=
><div>[=C2=A0 =C2=A0 5.373943] cfg80211: Loaded X.509 cert &#39;sforshee: 0=
0b28ddf47aef9cea7&#39;</div><div>[=C2=A0 =C2=A0 5.376409] platform regulato=
ry.0: Direct firmware load for regulatory.db failed with error -2</div><div=
>[=C2=A0 =C2=A0 5.376415] cfg80211: failed to load regulatory.db</div><div>=
[=C2=A0 =C2=A0 5.423514] kvm: Nested Virtualization enabled</div><div>[=C2=
=A0 =C2=A0 5.423532] kvm: Nested Paging enabled</div><div>[=C2=A0 =C2=A0 5.=
423533] SVM: Virtual VMLOAD VMSAVE supported</div><div>[=C2=A0 =C2=A0 5.423=
534] SVM: Virtual GIF supported</div><div>[=C2=A0 =C2=A0 5.430041] MCE: In-=
kernel MCE decoding enabled.</div><div>[=C2=A0 =C2=A0 5.437041] EDAC amd64:=
 Node 0: DRAM ECC disabled.</div><div>[=C2=A0 =C2=A0 5.437044] EDAC amd64: =
ECC disabled in the BIOS or no ECC capability, module will not load.</div><=
div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Either enable E=
CC checking or force module loading by setting &#39;ecc_enable_override&#39=
;.</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (Note =
that use of the override may cause unknown side effects.)</div><div>[=C2=A0=
 =C2=A0 5.442151] snd_hda_intel 0000:03:00.1: Handle vga_switcheroo audio c=
lient</div><div>[=C2=A0 =C2=A0 5.459035] media: Linux media interface: v0.1=
0</div><div>[=C2=A0 =C2=A0 5.491789] input: HD-Audio Generic HDMI/DP,pcm=3D=
3 as /devices/pci0000:00/0000:00:08.1/0000:03:00.1/sound/card0/input8</div>=
<div>[=C2=A0 =C2=A0 5.491931] input: HD-Audio Generic HDMI/DP,pcm=3D7 as /d=
evices/pci0000:00/0000:00:08.1/0000:03:00.1/sound/card0/input9</div><div>[=
=C2=A0 =C2=A0 5.492125] snd_hda_codec_realtek hdaudioC1D0: autoconfig for A=
LC295: line_outs=3D1 (0x17/0x0/0x0/0x0/0x0) type:speaker</div><div>[=C2=A0 =
=C2=A0 5.492128] snd_hda_codec_realtek hdaudioC1D0:=C2=A0 =C2=A0 speaker_ou=
ts=3D0 (0x0/0x0/0x0/0x0/0x0)</div><div>[=C2=A0 =C2=A0 5.492130] snd_hda_cod=
ec_realtek hdaudioC1D0:=C2=A0 =C2=A0 hp_outs=3D1 (0x21/0x0/0x0/0x0/0x0)</di=
v><div>[=C2=A0 =C2=A0 5.492132] snd_hda_codec_realtek hdaudioC1D0:=C2=A0 =
=C2=A0 mono: mono_out=3D0x0</div><div>[=C2=A0 =C2=A0 5.492133] snd_hda_code=
c_realtek hdaudioC1D0:=C2=A0 =C2=A0 inputs:</div><div>[=C2=A0 =C2=A0 5.4921=
36] snd_hda_codec_realtek hdaudioC1D0:=C2=A0 =C2=A0 =C2=A0 Mic=3D0x19</div>=
<div>[=C2=A0 =C2=A0 5.492138] snd_hda_codec_realtek hdaudioC1D0:=C2=A0 =C2=
=A0 =C2=A0 Internal Mic=3D0x12</div><div>[=C2=A0 =C2=A0 5.494688] random: c=
rng init done</div><div>[=C2=A0 =C2=A0 5.494690] random: 7 urandom warning(=
s) missed due to ratelimiting</div><div>[=C2=A0 =C2=A0 5.535897] videodev: =
Linux video capture interface: v2.00</div><div>[=C2=A0 =C2=A0 5.547522] inp=
ut: HD-Audio Generic Mic as /devices/pci0000:00/0000:00:08.1/0000:03:00.6/s=
ound/card1/input10</div><div>[=C2=A0 =C2=A0 5.547602] input: HD-Audio Gener=
ic Headphone as /devices/pci0000:00/0000:00:08.1/0000:03:00.6/sound/card1/i=
nput11</div><div>[=C2=A0 =C2=A0 5.550829] Bluetooth: Core ver 2.22</div><di=
v>[=C2=A0 =C2=A0 5.550858] NET: Registered protocol family 31</div><div>[=
=C2=A0 =C2=A0 5.550860] Bluetooth: HCI device and connection manager initia=
lized</div><div>[=C2=A0 =C2=A0 5.550867] Bluetooth: HCI socket layer initia=
lized</div><div>[=C2=A0 =C2=A0 5.550871] Bluetooth: L2CAP socket layer init=
ialized</div><div>[=C2=A0 =C2=A0 5.550902] Bluetooth: SCO socket layer init=
ialized</div><div>[=C2=A0 =C2=A0 5.555966] ACPI Error: Field [D128] at bit =
offset/length 128/1024 exceeds size of target Buffer (160 bits) (20180531/d=
sopcode-201)</div><div>[=C2=A0 =C2=A0 5.556313] r8822be: module is from the=
 staging directory, the quality is unknown, you have been warned.</div><div=
>[=C2=A0 =C2=A0 5.568568] ACPI Error: Method parse/execution failed \HWMC, =
AE_AML_BUFFER_LIMIT (20180531/psparse-516)</div><div>[=C2=A0 =C2=A0 5.57979=
8] ACPI Error: Method parse/execution failed \_SB.WMID.WMAA, AE_AML_BUFFER_=
LIMIT (20180531/psparse-516)</div><div>[=C2=A0 =C2=A0 5.580019] ACPI Error:=
 Field [D128] at bit offset/length 128/1024 exceeds size of target Buffer (=
160 bits) (20180531/dsopcode-201)</div><div>[=C2=A0 =C2=A0 5.604033] ACPI E=
rror: Method parse/execution failed \HWMC, AE_AML_BUFFER_LIMIT (20180531/ps=
parse-516)</div><div>[=C2=A0 =C2=A0 5.604059] ACPI Error: Method parse/exec=
ution failed \_SB.WMID.WMAA, AE_AML_BUFFER_LIMIT (20180531/psparse-516)</di=
v><div>[=C2=A0 =C2=A0 5.604273] ACPI Error: Field [D128] at bit offset/leng=
th 128/1024 exceeds size of target Buffer (160 bits) (20180531/dsopcode-201=
)</div><div>[=C2=A0 =C2=A0 5.604284] ACPI Error: Method parse/execution fai=
led \HWMC, AE_AML_BUFFER_LIMIT (20180531/psparse-516)</div><div>[=C2=A0 =C2=
=A0 5.604298] ACPI Error: Method parse/execution failed \_SB.WMID.WMAA, AE_=
AML_BUFFER_LIMIT (20180531/psparse-516)</div><div>[=C2=A0 =C2=A0 5.604426] =
input: HP WMI hotkeys as /devices/virtual/input/input12</div><div>[=C2=A0 =
=C2=A0 5.604991] ACPI Error: Field [D128] at bit offset/length 128/1024 exc=
eeds size of target Buffer (160 bits) (20180531/dsopcode-201)</div><div>[=
=C2=A0 =C2=A0 5.605029] ACPI Error: Method parse/execution failed \HWMC, AE=
_AML_BUFFER_LIMIT (20180531/psparse-516)</div><div>[=C2=A0 =C2=A0 5.605268]=
 acer_wmi: Acer Laptop ACPI-WMI Extras</div><div>[=C2=A0 =C2=A0 5.605275] a=
cer_wmi: Unsupported machine has AMW0_GUID1, unable to load</div><div>[=C2=
=A0 =C2=A0 5.605919] ACPI Error: Method parse/execution failed \_SB.WMID.WM=
AA, AE_AML_BUFFER_LIMIT (20180531/psparse-516)</div><div>[=C2=A0 =C2=A0 5.6=
06195] ACPI Error: Field [D128] at bit offset/length 128/1024 exceeds size =
of target Buffer (160 bits) (20180531/dsopcode-201)</div><div>[=C2=A0 =C2=
=A0 5.606211] ACPI Error: Method parse/execution failed \HWMC, AE_AML_BUFFE=
R_LIMIT (20180531/psparse-516)</div><div>[=C2=A0 =C2=A0 5.606228] ACPI Erro=
r: Method parse/execution failed \_SB.WMID.WMAA, AE_AML_BUFFER_LIMIT (20180=
531/psparse-516)</div><div>[=C2=A0 =C2=A0 5.625595] r8822be: Using firmware=
 rtlwifi/rtl8822befw.bin</div><div>[=C2=A0 =C2=A0 5.795068] usbcore: regist=
ered new interface driver btusb</div><div>[=C2=A0 =C2=A0 5.796265] ieee8021=
1 phy0: Selected rate control algorithm &#39;rtl_rc&#39;</div><div>[=C2=A0 =
=C2=A0 5.797209] r8822be: rtlwifi: wireless switch is on</div><div>[=C2=A0 =
=C2=A0 5.798127] Bluetooth: hci0: rtl: examining hci_ver=3D07 hci_rev=3D000=
b lmp_ver=3D07 lmp_subver=3D8822</div><div>[=C2=A0 =C2=A0 5.798131] Bluetoo=
th: hci0: rtl: loading rtl_bt/rtl8822b_config.bin</div><div>[=C2=A0 =C2=A0 =
5.798797] Bluetooth: hci0: rtl: loading rtl_bt/rtl8822b_fw.bin</div><div>[=
=C2=A0 =C2=A0 5.798821] uvcvideo: Found UVC 1.00 device HP Wide Vision FHD =
Camera (04f2:b593)</div><div>[=C2=A0 =C2=A0 5.799878] r8822be 0000:02:00.0 =
wlp2s0: renamed from wlan0</div><div>[=C2=A0 =C2=A0 5.802110] Bluetooth: hc=
i0: rom_version status=3D0 version=3D2</div><div>[=C2=A0 =C2=A0 5.802128] B=
luetooth: hci0: cfg_sz 14, total size 20270</div><div>[=C2=A0 =C2=A0 5.8069=
23] uvcvideo 1-4:1.0: Entity type for entity Extension 4 was not initialize=
d!</div><div>[=C2=A0 =C2=A0 5.806926] uvcvideo 1-4:1.0: Entity type for ent=
ity Processing 2 was not initialized!</div><div>[=C2=A0 =C2=A0 5.806928] uv=
cvideo 1-4:1.0: Entity type for entity Camera 1 was not initialized!</div><=
div>[=C2=A0 =C2=A0 5.807084] input: HP Wide Vision FHD Camera: HP W as /dev=
ices/pci0000:00/0000:00:08.1/0000:03:00.3/usb1/1-4/1-4:1.0/input/input13</d=
iv><div>[=C2=A0 =C2=A0 5.807774] uvcvideo: Found UVC 1.00 device HP Wide Vi=
sion FHD Camera (04f2:b593)</div><div>[=C2=A0 =C2=A0 5.809803] uvcvideo: Un=
able to create debugfs 1-2 directory.</div><div>[=C2=A0 =C2=A0 5.810025] uv=
cvideo 1-4:1.2: Entity type for entity Extension 10 was not initialized!</d=
iv><div>[=C2=A0 =C2=A0 5.810029] uvcvideo 1-4:1.2: Entity type for entity E=
xtension 12 was not initialized!</div><div>[=C2=A0 =C2=A0 5.810031] uvcvide=
o 1-4:1.2: Entity type for entity Processing 9 was not initialized!</div><d=
iv>[=C2=A0 =C2=A0 5.810033] uvcvideo 1-4:1.2: Entity type for entity Camera=
 11 was not initialized!</div><div>[=C2=A0 =C2=A0 5.810151] input: HP Wide =
Vision FHD Camera: HP I as /devices/pci0000:00/0000:00:08.1/0000:03:00.3/us=
b1/1-4/1-4:1.2/input/input14</div><div>[=C2=A0 =C2=A0 5.810338] usbcore: re=
gistered new interface driver uvcvideo</div><div>[=C2=A0 =C2=A0 5.810339] U=
SB Video Class driver (1.1.1)</div><div>[=C2=A0 =C2=A0 5.854696] [drm] amdg=
pu kernel modesetting enabled.</div><div>[=C2=A0 =C2=A0 5.864294] AMD IOMMU=
v2 driver by Joerg Roedel &lt;<a href=3D"mailto:jroedel-l3A5Bk7waGM@public.gmane.org">jroedel@su=
se.de</a>&gt;</div><div>[=C2=A0 =C2=A0 5.882960] Parsing CRAT table with 1 =
nodes</div><div>[=C2=A0 =C2=A0 5.882965] Ignoring ACPI CRAT on non-APU syst=
em</div><div>[=C2=A0 =C2=A0 5.882976] Virtual CRAT table created for CPU</d=
iv><div>[=C2=A0 =C2=A0 5.882977] Parsing CRAT table with 1 nodes</div><div>=
[=C2=A0 =C2=A0 5.882978] Creating topology SYSFS entries</div><div>[=C2=A0 =
=C2=A0 5.882992] Topology: Add CPU node</div><div>[=C2=A0 =C2=A0 5.882993] =
Finished initializing topology</div><div>[=C2=A0 =C2=A0 5.883079] kfd kfd: =
Initialized module</div><div>[=C2=A0 =C2=A0 5.883552] checking generic (e00=
00000 7f0000) vs hw (e0000000 10000000)</div><div>[=C2=A0 =C2=A0 5.883554] =
fb: switching to amdgpudrmfb from VESA VGA</div><div>[=C2=A0 =C2=A0 5.88359=
0] Console: switching to colour dummy device 80x25</div><div>[=C2=A0 =C2=A0=
 5.884118] [drm] initializing kernel modesetting (RAVEN 0x1002:0x15DD 0x103=
C:0x83C6 0xC4).</div><div>[=C2=A0 =C2=A0 5.884137] [drm] register mmio base=
: 0xFE000000</div><div>[=C2=A0 =C2=A0 5.884138] [drm] register mmio size: 5=
24288</div><div>[=C2=A0 =C2=A0 5.884160] [drm] probing gen 2 caps for devic=
e 1022:15db =3D 700d03/e</div><div>[=C2=A0 =C2=A0 5.884166] [drm] probing m=
lw for device 1022:15db =3D 700d03</div><div>[=C2=A0 =C2=A0 5.884169] [drm]=
 add ip block number 0 &lt;soc15_common&gt;</div><div>[=C2=A0 =C2=A0 5.8841=
70] [drm] add ip block number 1 &lt;gmc_v9_0&gt;</div><div>[=C2=A0 =C2=A0 5=
.884172] [drm] add ip block number 2 &lt;vega10_ih&gt;</div><div>[=C2=A0 =
=C2=A0 5.884173] [drm] add ip block number 3 &lt;psp&gt;</div><div>[=C2=A0 =
=C2=A0 5.884174] [drm] add ip block number 4 &lt;powerplay&gt;</div><div>[=
=C2=A0 =C2=A0 5.884175] [drm] add ip block number 5 &lt;dm&gt;</div><div>[=
=C2=A0 =C2=A0 5.884176] [drm] add ip block number 6 &lt;gfx_v9_0&gt;</div><=
div>[=C2=A0 =C2=A0 5.884177] [drm] add ip block number 7 &lt;sdma_v4_0&gt;<=
/div><div>[=C2=A0 =C2=A0 5.884178] [drm] add ip block number 8 &lt;vcn_v1_0=
&gt;</div><div>[=C2=A0 =C2=A0 5.886483] kfd kfd: DID 15dd is missing in sup=
ported_devices</div><div>[=C2=A0 =C2=A0 5.886487] kfd kfd: kgd2kfd_probe fa=
iled</div><div>[=C2=A0 =C2=A0 5.886511] [drm] VCN decode is enabled in VM m=
ode</div><div>[=C2=A0 =C2=A0 5.886512] [drm] VCN encode is enabled in VM mo=
de</div><div>[=C2=A0 =C2=A0 5.915648] [drm] BIOS signature incorrect 0 0</d=
iv><div>[=C2=A0 =C2=A0 5.915690] ATOM BIOS: SWBRT25890.001</div><div>[=C2=
=A0 =C2=A0 5.915733] [drm] vm size is 262144 GB, 4 levels, block size is 9-=
bit, fragment size is 9-bit</div><div>[=C2=A0 =C2=A0 5.915747] amdgpu 0000:=
03:00.0: VRAM: 256M 0x000000F400000000 - 0x000000F40FFFFFFF (256M used)</di=
v><div>[=C2=A0 =C2=A0 5.915749] amdgpu 0000:03:00.0: GTT: 1024M 0x000000F50=
0000000 - 0x000000F53FFFFFFF</div><div>[=C2=A0 =C2=A0 5.915754] [drm] Detec=
ted VRAM RAM=3D256M, BAR=3D256M</div><div>[=C2=A0 =C2=A0 5.915755] [drm] RA=
M width 128bits UNKNOWN</div><div>[=C2=A0 =C2=A0 5.916307] [TTM] Zone=C2=A0=
 kernel: Available graphics memory: 10159234 kiB</div><div>[=C2=A0 =C2=A0 5=
.916309] [TTM] Zone=C2=A0 =C2=A0dma32: Available graphics memory: 2097152 k=
iB</div><div>[=C2=A0 =C2=A0 5.916310] [TTM] Initializing pool allocator</di=
v><div>[=C2=A0 =C2=A0 5.916316] [TTM] Initializing DMA pool allocator</div>=
<div>[=C2=A0 =C2=A0 5.916359] [drm] amdgpu: 256M of VRAM memory ready</div>=
<div>[=C2=A0 =C2=A0 5.916361] [drm] amdgpu: 3072M of GTT memory ready.</div=
><div>[=C2=A0 =C2=A0 5.916377] [drm] GART: num cpu pages 262144, num gpu pa=
ges 262144</div><div>[=C2=A0 =C2=A0 5.916630] [drm] PCIE GART of 1024M enab=
led (table at 0x000000F400900000).</div><div>[=C2=A0 =C2=A0 5.932793] [drm]=
 use_doorbell being set to: [true]</div><div>[=C2=A0 =C2=A0 5.935374] [drm]=
 Found VCN firmware Version: 1.73 Family ID: 18</div><div>[=C2=A0 =C2=A0 6.=
015126] psmouse serio1: synaptics: queried max coordinates: x [..5640], y [=
..4740]</div><div>[=C2=A0 =C2=A0 6.042491] psmouse serio1: synaptics: queri=
ed min coordinates: x [1302..], y [1116..]</div><div>[=C2=A0 =C2=A0 6.04250=
1] psmouse serio1: synaptics: Your touchpad (PNP: SYN324e ETD0000 PNP0f13) =
says it can support a different bus. If i2c-hid and hid-rmi are not used, y=
ou might want to try setting psmouse.synaptics_intertouch to 1 and report t=
his to <a href=3D"mailto:linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">linux-input-u79uwXL29Tb/PtFMR13I2A@public.gmane.org=
el.org</a>.</div><div>[=C2=A0 =C2=A0 6.070325] BTRFS info (device sdb6): us=
e zstd compression, level 0</div><div>[=C2=A0 =C2=A0 6.070329] BTRFS info (=
device sdb6): enabling auto defrag</div><div>[=C2=A0 =C2=A0 6.070333] BTRFS=
 info (device sdb6): using default commit interval 30s</div><div>[=C2=A0 =
=C2=A0 6.070337] BTRFS info (device sdb6): disk space caching is enabled</d=
iv><div>[=C2=A0 =C2=A0 6.070339] BTRFS info (device sdb6): has skinny exten=
ts</div><div>[=C2=A0 =C2=A0 6.094400] psmouse serio1: synaptics: Touchpad m=
odel: 1, fw: 8.2, id: 0x1e2b1, caps: 0xf00123/0x840300/0x12e800/0x400000, b=
oard id: 3314, fw id: 2544170</div><div>[=C2=A0 =C2=A0 6.128063] input: Syn=
PS/2 Synaptics TouchPad as /devices/platform/i8042/serio1/input/input7</div=
><div>[=C2=A0 =C2=A0 6.140472] mousedev: PS/2 mouse device common for all m=
ice</div><div>[=C2=A0 =C2=A0 6.196628] EXT4-fs (sda1): mounted filesystem w=
ith ordered data mode. Opts: stripe=3D4</div><div>[=C2=A0 =C2=A0 6.603711] =
amdgpu: [powerplay] dpm has been enabled</div><div>[=C2=A0 =C2=A0 6.604078]=
 [drm:construct [amdgpu]] *ERROR* construct: Invalid Connector ObjectID fro=
m Adapter Service for connector index:2! type 0 expected 3</div><div>[=C2=
=A0 =C2=A0 6.621349] [drm] Display Core initialized with v3.1.44!</div><div=
>[=C2=A0 =C2=A0 6.627947] [drm] SADs count is: -2, don&#39;t need to read i=
t</div><div>[=C2=A0 =C2=A0 6.629081] [drm] Supports vblank timestamp cachin=
g Rev 2 (21.10.2013).</div><div>[=C2=A0 =C2=A0 6.629082] [drm] Driver suppo=
rts precise vblank timestamp query.</div><div>[=C2=A0 =C2=A0 6.653040] [drm=
] VCN decode and encode initialized successfully.</div><div>[=C2=A0 =C2=A0 =
6.656014] [drm] fb mappable at 0xD1100000</div><div>[=C2=A0 =C2=A0 6.656017=
] [drm] vram apper at 0xD0000000</div><div>[=C2=A0 =C2=A0 6.656018] [drm] s=
ize 8294400</div><div>[=C2=A0 =C2=A0 6.656019] [drm] fb depth is 24</div><d=
iv>[=C2=A0 =C2=A0 6.656020] [drm]=C2=A0 =C2=A0 pitch is 7680</div><div>[=C2=
=A0 =C2=A0 6.656149] fbcon: amdgpudrmfb (fb0) is primary device</div><div>[=
=C2=A0 =C2=A0 6.671592] Console: switching to colour frame buffer device 24=
0x67</div><div>[=C2=A0 =C2=A0 6.693572] amdgpu 0000:03:00.0: fb0: amdgpudrm=
fb frame buffer device</div><div>[=C2=A0 =C2=A0 6.721247] amdgpu 0000:03:00=
.0: ring 0(gfx) uses VM inv eng 4 on hub 0</div><div>[=C2=A0 =C2=A0 6.72125=
1] amdgpu 0000:03:00.0: ring 1(comp_1.0.0) uses VM inv eng 5 on hub 0</div>=
<div>[=C2=A0 =C2=A0 6.721254] amdgpu 0000:03:00.0: ring 2(comp_1.1.0) uses =
VM inv eng 6 on hub 0</div><div>[=C2=A0 =C2=A0 6.721256] amdgpu 0000:03:00.=
0: ring 3(comp_1.2.0) uses VM inv eng 7 on hub 0</div><div>[=C2=A0 =C2=A0 6=
.721258] amdgpu 0000:03:00.0: ring 4(comp_1.3.0) uses VM inv eng 8 on hub 0=
</div><div>[=C2=A0 =C2=A0 6.721260] amdgpu 0000:03:00.0: ring 5(comp_1.0.1)=
 uses VM inv eng 9 on hub 0</div><div>[=C2=A0 =C2=A0 6.721263] amdgpu 0000:=
03:00.0: ring 6(comp_1.1.1) uses VM inv eng 10 on hub 0</div><div>[=C2=A0 =
=C2=A0 6.721265] amdgpu 0000:03:00.0: ring 7(comp_1.2.1) uses VM inv eng 11=
 on hub 0</div><div>[=C2=A0 =C2=A0 6.721267] amdgpu 0000:03:00.0: ring 8(co=
mp_1.3.1) uses VM inv eng 12 on hub 0</div><div>[=C2=A0 =C2=A0 6.721270] am=
dgpu 0000:03:00.0: ring 9(kiq_2.1.0) uses VM inv eng 13 on hub 0</div><div>=
[=C2=A0 =C2=A0 6.721272] amdgpu 0000:03:00.0: ring 10(sdma0) uses VM inv en=
g 4 on hub 1</div><div>[=C2=A0 =C2=A0 6.721274] amdgpu 0000:03:00.0: ring 1=
1(vcn_dec) uses VM inv eng 5 on hub 1</div><div>[=C2=A0 =C2=A0 6.721276] am=
dgpu 0000:03:00.0: ring 12(vcn_enc0) uses VM inv eng 6 on hub 1</div><div>[=
=C2=A0 =C2=A0 6.721279] amdgpu 0000:03:00.0: ring 13(vcn_enc1) uses VM inv =
eng 7 on hub 1</div><div>[=C2=A0 =C2=A0 6.725754] [drm] Initialized amdgpu =
3.26.0 20150101 for 0000:03:00.0 on minor 0</div><div>[=C2=A0 =C2=A0 8.2464=
58] Bluetooth: BNEP (Ethernet Emulation) ver 1.3</div><div>[=C2=A0 =C2=A0 8=
.246460] Bluetooth: BNEP filters: protocol multicast</div><div>[=C2=A0 =C2=
=A0 8.246465] Bluetooth: BNEP socket layer initialized</div><div>[=C2=A0 =
=C2=A0 9.870932] IPv6: ADDRCONF(NETDEV_UP): wlp2s0: link is not ready</div>=
<div>[=C2=A0 =C2=A010.472458] IPv6: ADDRCONF(NETDEV_UP): wlp2s0: link is no=
t ready</div><div>[=C2=A0 =C2=A010.472503] bridge: filtering via arp/ip/ip6=
tables is no longer available by default. Update your scripts to load br_ne=
tfilter if you need this.</div><div>[=C2=A0 =C2=A010.946394] IPv6: ADDRCONF=
(NETDEV_UP): wlp2s0: link is not ready</div><div>[=C2=A0 =C2=A010.947022] B=
ridge firewalling registered</div><div>[=C2=A0 =C2=A011.044179] bpfilter: L=
oaded bpfilter_umh pid 859</div><div>[=C2=A0 =C2=A011.049265] audit: type=
=3D1325 audit(1534539415.044:2): table=3Dfilter family=3D2 entries=3D0</div=
><div>[=C2=A0 =C2=A011.049591] audit: type=3D1300 audit(1534539415.044:2): =
arch=3Dc000003e syscall=3D175 success=3Dyes exit=3D0 a0=3D55555577d8e0 a1=
=3D2308 a2=3D55555556fde6 a3=3D555555779010 items=3D0 ppid=3D348 pid=3D861 =
auid=3D4294967295 uid=3D0 gid=3D0 euid=3D0 suid=3D0 fsuid=3D0 egid=3D0 sgid=
=3D0 fsgid=3D0 tty=3D(none) ses=3D4294967295 comm=3D&quot;modprobe&quot; ex=
e=3D&quot;/usr/bin/kmod&quot; key=3D(null)</div><div>[=C2=A0 =C2=A011.04959=
5] audit: type=3D1327 audit(1534539415.044:2): proctitle=3D2F7362696E2F6D6F=
6470726F6265002D71002D2D0069707461626C655F66696C746572</div><div>[=C2=A0 =
=C2=A011.074989] audit: type=3D1325 audit(1534539415.071:3): table=3Dnat fa=
mily=3D2 entries=3D0</div><div>[=C2=A0 =C2=A011.075271] audit: type=3D1300 =
audit(1534539415.071:3): arch=3Dc000003e syscall=3D175 success=3Dyes exit=
=3D0 a0=3D55555577e400 a1=3D21e8 a2=3D55555556fde6 a3=3D555555779010 items=
=3D0 ppid=3D89 pid=3D867 auid=3D4294967295 uid=3D0 gid=3D0 euid=3D0 suid=3D=
0 fsuid=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3D(none) ses=3D4294967295 comm=
=3D&quot;modprobe&quot; exe=3D&quot;/usr/bin/kmod&quot; key=3D(null)</div><=
div>[=C2=A0 =C2=A011.075274] audit: type=3D1327 audit(1534539415.071:3): pr=
octitle=3D2F7362696E2F6D6F6470726F6265002D71002D2D0069707461626C655F6E6174<=
/div><div>[=C2=A0 =C2=A011.075295] IPv6: ADDRCONF(NETDEV_UP): wlp2s0: link =
is not ready</div><div>[=C2=A0 =C2=A011.118283] audit: type=3D1325 audit(15=
34539415.114:4): table=3Dnat family=3D2 entries=3D5</div><div>[=C2=A0 =C2=
=A011.118290] audit: type=3D1300 audit(1534539415.114:4): arch=3Dc000003e s=
yscall=3D54 success=3Dyes exit=3D0 a0=3D4 a1=3D0 a2=3D40 a3=3D5555557d2a50 =
items=3D0 ppid=3D584 pid=3D896 auid=3D4294967295 uid=3D0 gid=3D0 euid=3D0 s=
uid=3D0 fsuid=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3D(none) ses=3D4294967295=
 comm=3D&quot;iptables&quot; exe=3D&quot;/usr/bin/xtables-multi&quot; key=
=3D(null)</div><div>[=C2=A0 =C2=A011.118293] audit: type=3D1327 audit(15345=
39415.114:4): proctitle=3D2F7573722F62696E2F69707461626C6573002D2D776169740=
02D74006E6174002D4E00444F434B4552</div><div>[=C2=A0 =C2=A011.124243] audit:=
 type=3D1325 audit(1534539415.121:5): table=3Dfilter family=3D2 entries=3D4=
</div><div>[=C2=A0 =C2=A011.559137] Initializing XFRM netlink socket</div><=
div>[=C2=A0 =C2=A011.651373] IPv6: ADDRCONF(NETDEV_UP): docker0: link is no=
t ready</div><div>[=C2=A0 =C2=A011.753737] fuse init (API version 7.27)</di=
v><div>[=C2=A0 =C2=A016.329392] IPv6: ADDRCONF(NETDEV_UP): wlp2s0: link is =
not ready</div><div>[=C2=A0 =C2=A016.345775] IPv6: ADDRCONF(NETDEV_UP): wlp=
2s0: link is not ready</div><div>[=C2=A0 =C2=A016.819658] IPv6: ADDRCONF(NE=
TDEV_UP): wlp2s0: link is not ready</div><div>[=C2=A0 =C2=A018.032546] Blue=
tooth: RFCOMM TTY layer initialized</div><div>[=C2=A0 =C2=A018.032554] Blue=
tooth: RFCOMM socket layer initialized</div><div>[=C2=A0 =C2=A018.032561] B=
luetooth: RFCOMM ver 1.11</div><div>[=C2=A0 =C2=A019.991177] show_signal_ms=
g: 116 callbacks suppressed</div><div>[=C2=A0 =C2=A019.991183] core[1450]: =
segfault at 0 ip 0000000000441058 sp 00007fffffffd2f0 error 4</div><div>[=
=C2=A0 =C2=A019.991187] Code: 40 00 31 c0 c3 66 2e 0f 1f 84 00 00 00 00 00 =
0f 1f 00 55 48 89 f5 53 48 89 fb 48 83 ec 08 e8 8f ec fd ff 89 c7 e8 f8 f0 =
fd ff &lt;48&gt; 8b 30 48 89 ea 48 89 df e8 fa eb fd ff 48 83 c4 08 b8 01 0=
0 00=C2=A0</div><div>[=C2=A0 =C2=A019.991287] audit: type=3D1701 audit(1534=
539423.988:46): auid=3D1000 uid=3D1000 gid=3D1000 ses=3D2 pid=3D1450 comm=
=3D&quot;core&quot; exe=3D&quot;/usr/bin/warsaw/core&quot; sig=3D11 res=3D1=
</div><div>[=C2=A0 =C2=A044.165945] IPv6: ADDRCONF(NETDEV_UP): wlp2s0: link=
 is not ready</div><div>[=C2=A0 =C2=A047.429184] wlp2s0: authenticate with =
64:66:b3:be:b5:b7</div><div>[=C2=A0 =C2=A047.429620] wlp2s0: send auth to 6=
4:66:b3:be:b5:b7 (try 1/3)</div><div>[=C2=A0 =C2=A047.432430] wlp2s0: authe=
nticated</div><div>[=C2=A0 =C2=A047.432627] r8822be 0000:02:00.0 wlp2s0: di=
sabling HT as WMM/QoS is not supported by the AP</div><div>[=C2=A0 =C2=A047=
.432631] r8822be 0000:02:00.0 wlp2s0: disabling VHT as WMM/QoS is not suppo=
rted by the AP</div><div>[=C2=A0 =C2=A047.433353] wlp2s0: associate with 64=
:66:b3:be:b5:b7 (try 1/3)</div><div>[=C2=A0 =C2=A047.462546] wlp2s0: RX Ass=
ocResp from 64:66:b3:be:b5:b7 (capab=3D0x431 status=3D0 aid=3D3)</div><div>=
[=C2=A0 =C2=A047.462835] wlp2s0: associated</div><div>[=C2=A0 =C2=A047.4964=
30] IPv6: ADDRCONF(NETDEV_CHANGE): wlp2s0: link becomes ready</div><div>[=
=C2=A0 =C2=A072.839833] SGI XFS with ACLs, security attributes, realtime, s=
crub, no debug enabled</div><div>[=C2=A0 =C2=A072.861991] JFS: nTxBlock =3D=
 8192, nTxLock =3D 65536</div><div>[=C2=A0 =C2=A072.904797] ntfs: driver 2.=
1.32 [Flags: R/W MODULE].</div><div>[ 5898.208262] ------------[ cut here ]=
------------</div><div>[ 5898.208272] kernel BUG at drivers/dma-buf/reserva=
tion.c:234!</div><div>[ 5898.208305] invalid opcode: 0000 [#1] PREEMPT SMP =
NOPTI</div><div>[ 5898.208314] CPU: 6 PID: 2988 Comm: chromium Tainted: G=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0C O=C2=A0 =C2=A0 =C2=A0 4.18.1-arch1-1-AR=
CH #1</div><div>[ 5898.208317] Hardware name: HP HP ENVY x360 Convertible 1=
5m-bq1xx/83C6, BIOS F.17 03/29/2018</div><div>[ 5898.208334] RIP: 0010:rese=
rvation_object_add_shared_fence+0x31b/0x370</div><div>[ 5898.208336] Code: =
ff 4c 89 7d 18 c7 45 10 01 00 00 00 e9 e2 fd ff ff e8 46 8c a8 ff e9 0c fe =
ff ff b8 18 00 00 00 ba 01 00 00 00 e9 c0 fd ff ff &lt;0f&gt; 0b 8d 50 01 4=
8 8d 04 c5 18 00 00 00 48 01 d8 45 31 f6 4c 89 38=C2=A0</div><div>[ 5898.20=
8373] RSP: 0018:ffffa1b1ca9abb38 EFLAGS: 00010246</div><div>[ 5898.208377] =
RAX: 0000000000000004 RBX: ffff9236f1c71580 RCX: 0000000000000001</div><div=
>[ 5898.208380] RDX: 0000000000000001 RSI: ffff92371223da60 RDI: ffff9236b1=
96ba18</div><div>[ 5898.208382] RBP: 0000000000000000 R08: ffff9236bc7c3c80=
 R09: ffff92374aba2378</div><div>[ 5898.208385] R10: ffff9237374cded8 R11: =
ffff9237374cdec8 R12: ffff9236b196ba18</div><div>[ 5898.208387] R13: ffff92=
36b1ac0130 R14: ffff9236bfe3c000 R15: ffff92371223da60</div><div>[ 5898.208=
390] FS:=C2=A0 00007fffe08c2180(0000) GS:ffff92374ab80000(0000) knlGS:00000=
00000000000</div><div>[ 5898.208393] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: =
0000000080050033</div><div>[ 5898.208395] CR2: 0000265eadacf000 CR3: 000000=
04794e4000 CR4: 00000000003406e0</div><div>[ 5898.208398] Call Trace:</div>=
<div>[ 5898.208519]=C2=A0 amdgpu_vm_update_directories+0x2a8/0x3e0 [amdgpu]=
</div><div>[ 5898.208582]=C2=A0 ? amdgpu_vm_prt_put+0x20/0x20 [amdgpu]</div=
><div>[ 5898.208639]=C2=A0 amdgpu_gem_va_ioctl+0x253/0x500 [amdgpu]</div><d=
iv>[ 5898.208693]=C2=A0 ? amdgpu_gem_metadata_ioctl+0x1b0/0x1b0 [amdgpu]</d=
iv><div>[ 5898.208715]=C2=A0 drm_ioctl_kernel+0xa7/0xf0 [drm]</div><div>[ 5=
898.208731]=C2=A0 drm_ioctl+0x30e/0x3c0 [drm]</div><div>[ 5898.208777]=C2=
=A0 ? amdgpu_gem_metadata_ioctl+0x1b0/0x1b0 [amdgpu]</div><div>[ 5898.20883=
6]=C2=A0 amdgpu_drm_ioctl+0x49/0x80 [amdgpu]</div><div>[ 5898.208844]=C2=A0=
 do_vfs_ioctl+0xa4/0x620</div><div>[ 5898.208850]=C2=A0 ? syscall_slow_exit=
_work+0x19b/0x1b0</div><div>[ 5898.208855]=C2=A0 ksys_ioctl+0x60/0x90</div>=
<div>[ 5898.208860]=C2=A0 __x64_sys_ioctl+0x16/0x20</div><div>[ 5898.208864=
]=C2=A0 do_syscall_64+0x5b/0x170</div><div>[ 5898.208871]=C2=A0 entry_SYSCA=
LL_64_after_hwframe+0x44/0xa9</div><div>[ 5898.208875] RIP: 0033:0x7fffeeaa=
979b</div><div>[ 5898.208877] Code: 0f 1e fa 48 8b 05 c5 b6 0c 00 64 c7 00 =
26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 =
00 00 0f 05 &lt;48&gt; 3d 01 f0 ff ff 73 01 c3 48 8b 0d 95 b6 0c 00 f7 d8 6=
4 89 01 48=C2=A0</div><div>[ 5898.208923] RSP: 002b:00007fffffffc578 EFLAGS=
: 00000246 ORIG_RAX: 0000000000000010</div><div>[ 5898.208927] RAX: fffffff=
fffffffda RBX: 0000000000000000 RCX: 00007fffeeaa979b</div><div>[ 5898.2089=
29] RDX: 00007fffffffc5c0 RSI: 00000000c0286448 RDI: 000000000000000f</div>=
<div>[ 5898.208931] RBP: 00007fffffffc5c0 R08: 0000000108ff0000 R09: 000000=
000000000e</div><div>[ 5898.208934] R10: 00000000000001c6 R11: 000000000000=
0246 R12: 00000000c0286448</div><div>[ 5898.208936] R13: 000000000000000f R=
14: 0000000000010000 R15: 000025e648c02a90</div><div>[ 5898.208940] Modules=
 linked in: ufs hfsplus hfs minix ntfs vfat msdos fat jfs xfs ccm rfcomm fu=
se ipt_MASQUERADE nf_conntrack_netlink nfnetlink xfrm_user xfrm_algo iptabl=
e_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 xt_addrtype iptable_filt=
er bpfilter xt_conntrack nf_nat nf_conntrack br_netfilter bridge stp llc bn=
ep ext4 joydev mbcache mousedev jbd2 fscrypto amdkfd amd_iommu_v2 arc4 amdg=
pu uvcvideo hid_sensor_rotation hid_sensor_accel_3d btusb hid_sensor_magn_3=
d hid_sensor_incl_3d hid_sensor_gyro_3d btrtl hid_sensor_trigger videobuf2_=
vmalloc industrialio_triggered_buffer btbcm videobuf2_memops kfifo_buf r882=
2be(C) btintel videobuf2_v4l2 hid_sensor_iio_common hp_wmi chash wmi_bmof s=
parse_keymap videobuf2_common bluetooth gpu_sched industrialio i2c_algo_bit=
 videodev snd_hda_codec_realtek ttm ecdh_generic</div><div>[ 5898.209004]=
=C2=A0 snd_hda_codec_generic snd_hda_codec_hdmi crc16 mac80211 media drm_km=
s_helper snd_hda_intel edac_mce_amd snd_hda_codec kvm_amd drm ccp snd_hda_c=
ore rng_core kvm snd_hwdep cfg80211 snd_pcm agpgart syscopyarea psmouse sys=
fillrect snd_timer irqbypass k10temp input_leds snd sysimgblt sp5100_tco rt=
sx_pci_ms rfkill memstick soundcore fb_sys_fops i2c_piix4 wmi hp_accel batt=
ery ac rtc_cmos evdev lis3lv02d i2c_hid mac_hid input_polldev led_class i2c=
_scmi pcc_cpufreq pinctrl_amd hp_wireless acpi_cpufreq vboxnetflt(O) vboxne=
tadp(O) vboxpci(O) vboxdrv(O) msr sg crypto_user ip_tables x_tables dm_cryp=
t dm_mod btrfs libcrc32c crc32c_generic xor zstd_decompress zstd_compress x=
xhash hid_sensor_hub hid_generic usbhid hid raid6_pq sd_mod crct10dif_pclmu=
l crc32_pclmul crc32c_intel rtsx_pci_sdmmc ghash_clmulni_intel</div><div>[ =
5898.209074]=C2=A0 serio_raw atkbd libps2 mmc_core pcbc ahci libahci xhci_p=
ci libata xhci_hcd aesni_intel aes_x86_64 crypto_simd cryptd glue_helper us=
bcore scsi_mod usb_common rtsx_pci i8042 serio lz4 lz4_compress</div><div>[=
 5898.209101] ---[ end trace 6c5f000032a0a21d ]---</div><div>[ 5898.209108]=
 RIP: 0010:reservation_object_add_shared_fence+0x31b/0x370</div><div>[ 5898=
.209110] Code: ff 4c 89 7d 18 c7 45 10 01 00 00 00 e9 e2 fd ff ff e8 46 8c =
a8 ff e9 0c fe ff ff b8 18 00 00 00 ba 01 00 00 00 e9 c0 fd ff ff &lt;0f&gt=
; 0b 8d 50 01 48 8d 04 c5 18 00 00 00 48 01 d8 45 31 f6 4c 89 38=C2=A0</div=
><div>[ 5898.209153] RSP: 0018:ffffa1b1ca9abb38 EFLAGS: 00010246</div><div>=
[ 5898.209156] RAX: 0000000000000004 RBX: ffff9236f1c71580 RCX: 00000000000=
00001</div><div>[ 5898.209159] RDX: 0000000000000001 RSI: ffff92371223da60 =
RDI: ffff9236b196ba18</div><div>[ 5898.209161] RBP: 0000000000000000 R08: f=
fff9236bc7c3c80 R09: ffff92374aba2378</div><div>[ 5898.209163] R10: ffff923=
7374cded8 R11: ffff9237374cdec8 R12: ffff9236b196ba18</div><div>[ 5898.2091=
65] R13: ffff9236b1ac0130 R14: ffff9236bfe3c000 R15: ffff92371223da60</div>=
<div>[ 5898.209168] FS:=C2=A0 00007fffe08c2180(0000) GS:ffff92374ab80000(00=
00) knlGS:0000000000000000</div><div>[ 5898.209171] CS:=C2=A0 0010 DS: 0000=
 ES: 0000 CR0: 0000000080050033</div><div>[ 5898.209173] CR2: 0000265eadacf=
000 CR3: 00000004794e4000 CR4: 00000000003406e0</div><div>[ 5921.939945] au=
dit: type=3D1006 audit(1534545327.725:47): pid=3D9656 uid=3D0 old-auid=3D42=
94967295 auid=3D1000 tty=3Dtty2 old-ses=3D4294967295 ses=3D4 res=3D1</div><=
/div><div><br></div></div></div>

--0000000000001d5ee40573a93d81--

--===============1551458660==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1551458660==--
