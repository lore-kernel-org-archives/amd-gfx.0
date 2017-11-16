From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: dirty suspend after piglit run
Date: Thu, 16 Nov 2017 13:22:34 -0500
Message-ID: <c001eafa-95b9-809c-5239-829ed40eb65d@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------ED486B5870649532215BCF76"
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

--------------ED486B5870649532215BCF76
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On my Carrizo with the tip of drm-next as of today I get VM faults near 
the end of the piglit tests (with "-x max.*size") which then manifest 
UVD problems when decoding with a system suspend in the middle.

Attached is the dmesg log.

Suspend works fine if I don't trigger the VM faults first.

I'll see if I can bisect down the VM faults since I think this is a 
relatively new regression (with max.*size excluded).

Tom

--------------ED486B5870649532215BCF76
Content-Type: text/x-log;
 name="carrizo_after_piglit_then_after_suspend_with_uvd.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="carrizo_after_piglit_then_after_suspend_with_uvd.log"

[    0.000000] Linux version 4.14.0-rc3+ (root@carrizo) (gcc version 7.2.1 20170915 (Red Hat 7.2.1-2) (GCC)) #21 SMP Thu Nov 16 10:52:30 EST 2017
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-4.14.0-rc3+ root=UUID=66163c80-0ca1-4beb-aeba-5cc130b813e6 ro rhgb quiet LANG=en_CA.UTF-8 rdblacklist=amdgpu
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009d3ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009d400-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000d6cf1fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000d6cf2000-0x00000000d6d0bfff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000d6d0c000-0x00000000dac18fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000dac19000-0x00000000dada0fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000dada1000-0x00000000dadb3fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000dadb4000-0x00000000daeadfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000daeae000-0x00000000db25ffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000db260000-0x00000000dbb6cfff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000dbb6d000-0x00000000ddffffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000de000000-0x00000000dfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fe500000-0x00000000fe5fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fea00000-0x00000000fea0ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000feb80000-0x00000000fec01fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec10000-0x00000000fec10fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec30000-0x00000000fec30fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed40000-0x00000000fed44fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed8ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fedc0000-0x00000000fedc0fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fedc2000-0x00000000fedc8fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000feefffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x00000001feffffff] usable
[    0.000000] BIOS-e820: [mem 0x00000001ff000000-0x000000021effffff] reserved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] random: fast init done
[    0.000000] SMBIOS 3.0.0 present.
[    0.000000] DMI: System manufacturer System Product Name/TUF B350M-PLUS GAMING, BIOS 0902 09/08/2017
[    0.000000] tsc: Fast TSC calibration failed
[    0.000000] tsc: Using PIT calibration value
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x1ff000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF write-through
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000000 mask FFFF80000000 write-back
[    0.000000]   1 base 000080000000 mask FFFFC0000000 write-back
[    0.000000]   2 base 0000C0000000 mask FFFFE0000000 write-back
[    0.000000]   3 base 0000DE000000 mask FFFFFE000000 uncachable
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] TOM2: 000000021f000000 aka 8688M
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000000] e820: update [mem 0xde000000-0xffffffff] usable ==> reserved
[    0.000000] e820: last_pfn = 0xde000 max_arch_pfn = 0x400000000
[    0.000000] Base memory trampoline at [ffff880000097000] 97000 size 24576
[    0.000000] Using GB pages for direct mapping
[    0.000000] BRK [0x1fea2000, 0x1fea2fff] PGTABLE
[    0.000000] BRK [0x1fea3000, 0x1fea3fff] PGTABLE
[    0.000000] BRK [0x1fea4000, 0x1fea4fff] PGTABLE
[    0.000000] BRK [0x1fea5000, 0x1fea5fff] PGTABLE
[    0.000000] BRK [0x1fea6000, 0x1fea6fff] PGTABLE
[    0.000000] BRK [0x1fea7000, 0x1fea7fff] PGTABLE
[    0.000000] BRK [0x1fea8000, 0x1fea8fff] PGTABLE
[    0.000000] RAMDISK: [mem 0x2e84e000-0x3341efff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F05B0 000024 (v02 ALASKA)
[    0.000000] ACPI: XSDT 0x00000000D6CF2098 0000A4 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FACP 0x00000000D6CFCB30 000114 (v06 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI BIOS Warning (bug): Optional FADT field Pm2ControlBlock has valid Length but zero Address: 0x0000000000000000/0x1 (20170728/tbfadt-658)
[    0.000000] ACPI: DSDT 0x00000000D6CF21D0 00A95C (v02 ALASKA A M I    01072009 INTL 20120913)
[    0.000000] ACPI: FACS 0x00000000DB25DC80 000040
[    0.000000] ACPI: APIC 0x00000000D6CFCC48 0000DE (v03 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FPDT 0x00000000D6CFCD28 000044 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: SSDT 0x00000000D6D099B8 001664 (v01 AMD    CPMCMN   00000001 INTL 20120913)
[    0.000000] ACPI: FIDT 0x00000000D6CFCDC8 00009C (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: SSDT 0x00000000D6CFCE68 000D40 (v01 AMD    AMD CPU  00000001 AMD  00000001)
[    0.000000] ACPI: CRAT 0x00000000D6CFDBA8 000500 (v01 AMD    AMD CRAT 00000001 AMD  00000001)
[    0.000000] ACPI: CDIT 0x00000000D6CFE0A8 000029 (v01 AMD    AMD CDIT 00000001 AMD  00000001)
[    0.000000] ACPI: SSDT 0x00000000D6CFE0D8 0017FF (v01 AMD    AMD AOD  00000001 INTL 20120913)
[    0.000000] ACPI: MCFG 0x00000000D6CFF8D8 00003C (v01 ALASKA A M I    01072009 MSFT 00010013)
[    0.000000] ACPI: HPET 0x00000000D6CFF918 000038 (v01 ALASKA A M I    01072009 AMI  00000005)
[    0.000000] ACPI: UEFI 0x00000000D6CFF950 000042 (v01                 00000000      00000000)
[    0.000000] ACPI: SSDT 0x00000000D6CFF998 00888F (v02 AMD    AGESA    00000002 MSFT 04000000)
[    0.000000] ACPI: IVRS 0x00000000D6D08228 0000D0 (v02 AMD    AGESA    00000001 AMD  00000000)
[    0.000000] ACPI: SSDT 0x00000000D6D082F8 0000F8 (v01 AMD    AMD PT   00001000 INTL 20120913)
[    0.000000] ACPI: SSDT 0x00000000D6D083F0 0015C5 (v01 AMD    CPMDFIGP 00000001 INTL 20120913)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x00000001feffffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x1fefd3000-0x1feffdfff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x00000001feffffff]
[    0.000000]   Device   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009cfff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x00000000d6cf1fff]
[    0.000000]   node   0: [mem 0x00000000d6d0c000-0x00000000dac18fff]
[    0.000000]   node   0: [mem 0x00000000dadb4000-0x00000000daeadfff]
[    0.000000]   node   0: [mem 0x00000000dbb6d000-0x00000000ddffffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x00000001feffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x00000001feffffff]
[    0.000000] On node 0 totalpages: 1949992
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 21 pages reserved
[    0.000000]   DMA zone: 3996 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 14087 pages used for memmap
[    0.000000]   DMA32 zone: 901516 pages, LIFO batch:31
[    0.000000]   Normal zone: 16320 pages used for memmap
[    0.000000]   Normal zone: 1044480 pages, LIFO batch:31
[    0.000000] [ffffed001ada1800-ffffed001adfffff] potential offnode page_structs
[    0.000000] [ffffed001b5b6800-ffffed001b5d5bff] potential offnode page_structs
[    0.000000] kasan: KernelAddressSanitizer initialized
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 0, version 33, address 0xfec00000, GSI 0-23
[    0.000000] IOAPIC[1]: apic_id 1, version 33, address 0xfec01000, GSI 24-55
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x10228201 base: 0xfed00000
[    0.000000] smpboot: Allowing 16 CPUs, 12 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009d000-0x0009dfff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009e000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000dffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000e0000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xd6cf2000-0xd6d0bfff]
[    0.000000] PM: Registered nosave memory: [mem 0xdac19000-0xdada0fff]
[    0.000000] PM: Registered nosave memory: [mem 0xdada1000-0xdadb3fff]
[    0.000000] PM: Registered nosave memory: [mem 0xdaeae000-0xdb25ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xdb260000-0xdbb6cfff]
[    0.000000] PM: Registered nosave memory: [mem 0xde000000-0xdfffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xe0000000-0xf7ffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xf8000000-0xfbffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfc000000-0xfe4fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfe500000-0xfe5fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfe600000-0xfe9fffff]
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
[    0.000000] PM: Registered nosave memory: [mem 0xfed90000-0xfedbffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfedc0000-0xfedc0fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfedc1000-0xfedc1fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfedc2000-0xfedc8fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfedc9000-0xfedfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee00000-0xfeefffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfef00000-0xfeffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xff000000-0xffffffff]
[    0.000000] e820: [mem 0xe0000000-0xf7ffffff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.000000] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:16 nr_cpu_ids:16 nr_node_ids:1
[    0.000000] percpu: Embedded 46 pages/cpu @ffff8801bae00000 s149016 r8192 d31208 u262144
[    0.000000] pcpu-alloc: s149016 r8192 d31208 u262144 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 12 13 14 15 
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 1919500
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-4.14.0-rc3+ root=UUID=66163c80-0ca1-4beb-aeba-5cc130b813e6 ro rhgb quiet LANG=en_CA.UTF-8 rdblacklist=amdgpu
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Memory: 6499364K/7799968K available (17649K kernel code, 6520K rwdata, 6696K rodata, 3292K init, 11172K bss, 1300604K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=16, Nodes=1
[    0.000000] ftrace: allocating 35177 entries in 138 pages
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=16.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=16
[    0.000000] NR_IRQS: 524544, nr_irqs: 1096, preallocated irqs: 16
[    0.000000] 	Offload RCU callbacks from CPUs: .
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Fast TSC calibration failed
[    0.002000] tsc: PIT calibration matches HPET. 1 loops
[    0.002000] tsc: Detected 3792.794 MHz processor
[    0.002000] Calibrating delay loop (skipped), value calculated using timer frequency.. 7585.58 BogoMIPS (lpj=3792794)
[    0.002000] pid_max: default: 32768 minimum: 301
[    0.003010] ACPI: Core revision 20170728
[    0.586240] ACPI: 7 ACPI AML tables successfully acquired and loaded
[    0.587367] Security Framework initialized
[    0.587376] Yama: becoming mindful.
[    0.587423] SELinux:  Initializing.
[    0.588038] SELinux:  Starting in permissive mode
[    0.592203] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.594205] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.594618] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.594699] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.597948] [Firmware Info]: CPU: Re-enabling disabled Topology Extensions Support.
[    0.597959] CPU: Physical Processor ID: 0
[    0.597961] CPU: Processor Core ID: 0
[    0.597973] mce: CPU supports 7 MCE banks
[    0.598016] LVT offset 1 assigned for vector 0xf9
[    0.598025] Last level iTLB entries: 4KB 512, 2MB 1024, 4MB 512
[    0.598026] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 512, 1GB 0
[    0.598241] Freeing SMP alternatives memory: 36K
[    0.601415] smpboot: Max logical packages: 4
[    0.605019] Switched APIC routing to physical flat.
[    0.606000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.616000] smpboot: CPU0: AMD A12-9800 RADEON R7, 12 COMPUTE CORES 4C+8G (family: 0x15, model: 0x65, stepping: 0x1)
[    0.616000] Performance Events: Fam15h core perfctr, AMD PMU driver.
[    0.616000] ... version:                0
[    0.616000] ... bit width:              48
[    0.616000] ... generic registers:      6
[    0.616000] ... value mask:             0000ffffffffffff
[    0.616000] ... max period:             00007fffffffffff
[    0.616000] ... fixed-purpose events:   0
[    0.616000] ... event mask:             000000000000003f
[    0.616000] Hierarchical SRCU implementation.
[    0.730070] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
[    0.730298] smp: Bringing up secondary CPUs ...
[    0.731118] x86: Booting SMP configuration:
[    0.731121] .... node  #0, CPUs:        #1  #2  #3
[    0.763105] smp: Brought up 1 node, 4 CPUs
[    0.763105] smpboot: Total of 4 processors activated (30215.98 BogoMIPS)
[    0.771052] devtmpfs: initialized
[    0.772544] x86/mm: Memory block size: 128MB
[    0.790439] PM: Registering ACPI NVS region [mem 0xdaeae000-0xdb25ffff] (3874816 bytes)
[    0.797034] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.797034] futex hash table entries: 4096 (order: 6, 262144 bytes)
[    0.799018] pinctrl core: initialized pinctrl subsystem
[    0.799127] RTC time: 17:19:33, date: 11/16/17
[    0.803490] NET: Registered protocol family 16
[    0.808078] cpuidle: using governor menu
[    0.809599] ACPI: bus type PCI registered
[    0.809604] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.811112] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.811117] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
[    0.811192] PCI: Using configuration type 1 for base access
[    0.843098] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.843102] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.848122] ACPI: Added _OSI(Module Device)
[    0.848122] ACPI: Added _OSI(Processor Device)
[    0.848122] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.848122] ACPI: Added _OSI(Processor Aggregator Device)
[    0.849123] ACPI: Executed 1 blocks of module-level executable AML code
[    0.981999] ACPI Error: Needed [Integer/String/Buffer], found [Region] ffff8801b8f0f548 (20170728/exresop-424)
[    0.982119] ACPI Exception: AE_AML_OPERAND_TYPE, Could not execute arguments for [IOB2] (Region) (20170728/nsinit-426)
[    1.403631] ACPI: Interpreter enabled
[    1.403794] ACPI: (supports S0 S3 S4 S5)
[    1.403796] ACPI: Using IOAPIC for interrupt routing
[    1.407050] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    1.414721] ACPI: Enabled 3 GPEs in block 00 to 1F
[    1.585255] ACPI: Power Resource [P0SD] (off)
[    1.586245] ACPI: Power Resource [P3SD] (off)
[    1.589823] ACPI: Power Resource [P0U2] (off)
[    1.590854] ACPI: Power Resource [P3U2] (off)
[    1.597381] ACPI: Power Resource [P0U3] (off)
[    1.598392] ACPI: Power Resource [P3U3] (off)
[    1.614865] ACPI: Power Resource [P0ST] (on)
[    1.615924] ACPI: Power Resource [P3ST] (on)
[    1.734498] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    1.734534] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    1.742283] acpi PNP0A08:00: _OSC: platform does not support [PCIeHotplug PME]
[    1.749889] acpi PNP0A08:00: _OSC: OS now controls [AER PCIeCapability]
[    1.750226] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000 [bus 00-3f] only partially covers this bridge
[    1.766207] PCI host bridge to bus 0000:00
[    1.766224] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    1.766236] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    1.766248] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
[    1.766259] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    1.766271] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    1.766283] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff window]
[    1.766295] pci_bus 0000:00: root bus resource [mem 0xe0000000-0xfec2ffff window]
[    1.766307] pci_bus 0000:00: root bus resource [mem 0xfee00000-0xffffffff window]
[    1.766318] pci_bus 0000:00: root bus resource [bus 00-ff]
[    1.766347] pci 0000:00:00.0: [1022:1576] type 00 class 0x060000
[    1.768481] pci 0000:00:00.2: [1022:1577] type 00 class 0x080600
[    1.770602] pci 0000:00:01.0: [1002:9874] type 00 class 0x030000
[    1.770625] pci 0000:00:01.0: reg 0x10: [mem 0xe0000000-0xefffffff 64bit pref]
[    1.770635] pci 0000:00:01.0: reg 0x18: [mem 0xf0000000-0xf07fffff 64bit pref]
[    1.770642] pci 0000:00:01.0: reg 0x20: [io  0xf000-0xf0ff]
[    1.770649] pci 0000:00:01.0: reg 0x24: [mem 0xfe900000-0xfe93ffff]
[    1.770656] pci 0000:00:01.0: reg 0x30: [mem 0xfe940000-0xfe95ffff pref]
[    1.770661] pci 0000:00:01.0: enabling Extended Tags
[    1.770774] pci 0000:00:01.0: supports D1 D2
[    1.770776] pci 0000:00:01.0: PME# supported from D1 D2 D3hot
[    1.773032] pci 0000:00:01.1: [1002:9840] type 00 class 0x040300
[    1.773051] pci 0000:00:01.1: reg 0x10: [mem 0xfe960000-0xfe963fff 64bit]
[    1.773079] pci 0000:00:01.1: enabling Extended Tags
[    1.773233] pci 0000:00:01.1: supports D1 D2
[    1.775040] pci 0000:00:02.0: [1022:157b] type 00 class 0x060000
[    1.776933] pci 0000:00:02.4: [1022:157c] type 01 class 0x060400
[    1.777028] pci 0000:00:02.4: enabling Extended Tags
[    1.777164] pci 0000:00:02.4: PME# supported from D0 D3hot D3cold
[    1.779425] pci 0000:00:03.0: [1022:157b] type 00 class 0x060000
[    1.781361] pci 0000:00:08.0: [1022:1578] type 00 class 0x108000
[    1.781380] pci 0000:00:08.0: reg 0x10: [mem 0xf0800000-0xf081ffff 64bit pref]
[    1.781387] pci 0000:00:08.0: reg 0x18: [mem 0xfe600000-0xfe6fffff]
[    1.781394] pci 0000:00:08.0: reg 0x1c: [mem 0xfe969000-0xfe969fff]
[    1.781406] pci 0000:00:08.0: reg 0x24: [mem 0xfe966000-0xfe967fff]
[    1.783565] pci 0000:00:09.0: [1022:157d] type 00 class 0x060000
[    1.785531] pci 0000:00:10.0: [1022:7914] type 00 class 0x0c0330
[    1.785566] pci 0000:00:10.0: reg 0x10: [mem 0xfe964000-0xfe965fff 64bit]
[    1.785761] pci 0000:00:10.0: PME# supported from D0 D3hot D3cold
[    1.788014] pci 0000:00:11.0: [1022:7901] type 00 class 0x010601
[    1.788051] pci 0000:00:11.0: reg 0x10: [io  0xf140-0xf147]
[    1.788062] pci 0000:00:11.0: reg 0x14: [io  0xf130-0xf133]
[    1.788074] pci 0000:00:11.0: reg 0x18: [io  0xf120-0xf127]
[    1.788085] pci 0000:00:11.0: reg 0x1c: [io  0xf110-0xf113]
[    1.788096] pci 0000:00:11.0: reg 0x20: [io  0xf100-0xf10f]
[    1.788108] pci 0000:00:11.0: reg 0x24: [mem 0xfe968000-0xfe9683ff]
[    1.788266] pci 0000:00:11.0: PME# supported from D3hot
[    1.790451] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500
[    1.792665] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100
[    1.794875] pci 0000:00:18.0: [1022:1570] type 00 class 0x060000
[    1.796820] pci 0000:00:18.1: [1022:1571] type 00 class 0x060000
[    1.798716] pci 0000:00:18.2: [1022:1572] type 00 class 0x060000
[    1.800641] pci 0000:00:18.3: [1022:1573] type 00 class 0x060000
[    1.802549] pci 0000:00:18.4: [1022:1574] type 00 class 0x060000
[    1.804464] pci 0000:00:18.5: [1022:1575] type 00 class 0x060000
[    1.807242] pci 0000:05:00.0: [1022:43bb] type 00 class 0x0c0330
[    1.807278] pci 0000:05:00.0: reg 0x10: [mem 0xfe8a0000-0xfe8a7fff 64bit]
[    1.807333] pci 0000:05:00.0: enabling Extended Tags
[    1.807529] pci 0000:05:00.0: PME# supported from D3hot D3cold
[    1.808523] pci 0000:05:00.1: [1022:43b7] type 00 class 0x010601
[    1.808593] pci 0000:05:00.1: reg 0x24: [mem 0xfe880000-0xfe89ffff]
[    1.808605] pci 0000:05:00.1: reg 0x30: [mem 0xfe800000-0xfe87ffff pref]
[    1.808614] pci 0000:05:00.1: enabling Extended Tags
[    1.808793] pci 0000:05:00.1: PME# supported from D3hot D3cold
[    1.809579] pci 0000:05:00.2: [1022:43b2] type 01 class 0x060400
[    1.809635] pci 0000:05:00.2: enabling Extended Tags
[    1.809832] pci 0000:05:00.2: PME# supported from D3hot D3cold
[    1.860101] pci 0000:00:02.4: PCI bridge to [bus 05-20]
[    1.860113] pci 0000:00:02.4:   bridge window [io  0xe000-0xefff]
[    1.860118] pci 0000:00:02.4:   bridge window [mem 0xfe700000-0xfe8fffff]
[    1.861605] pci 0000:1d:00.0: [1022:43b4] type 01 class 0x060400
[    1.861669] pci 0000:1d:00.0: enabling Extended Tags
[    1.861955] pci 0000:1d:00.0: PME# supported from D3hot D3cold
[    1.863031] pci 0000:1d:01.0: [1022:43b4] type 01 class 0x060400
[    1.863091] pci 0000:1d:01.0: enabling Extended Tags
[    1.863380] pci 0000:1d:01.0: PME# supported from D3hot D3cold
[    1.864484] pci 0000:1d:04.0: [1022:43b4] type 01 class 0x060400
[    1.864545] pci 0000:1d:04.0: enabling Extended Tags
[    1.864830] pci 0000:1d:04.0: PME# supported from D3hot D3cold
[    1.865960] pci 0000:05:00.2: PCI bridge to [bus 1d-20]
[    1.865968] pci 0000:05:00.2:   bridge window [io  0xe000-0xefff]
[    1.865974] pci 0000:05:00.2:   bridge window [mem 0xfe700000-0xfe7fffff]
[    1.866674] pci 0000:1e:00.0: [10ec:8168] type 00 class 0x020000
[    1.866724] pci 0000:1e:00.0: reg 0x10: [io  0xe000-0xe0ff]
[    1.866767] pci 0000:1e:00.0: reg 0x18: [mem 0xfe704000-0xfe704fff 64bit]
[    1.866794] pci 0000:1e:00.0: reg 0x20: [mem 0xfe700000-0xfe703fff 64bit]
[    1.867291] pci 0000:1e:00.0: supports D1 D2
[    1.867293] pci 0000:1e:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.871207] pci 0000:1d:00.0: PCI bridge to [bus 1e]
[    1.871220] pci 0000:1d:00.0:   bridge window [io  0xe000-0xefff]
[    1.871226] pci 0000:1d:00.0:   bridge window [mem 0xfe700000-0xfe7fffff]
[    1.872181] pci 0000:1d:01.0: PCI bridge to [bus 1f]
[    1.872901] pci 0000:1d:04.0: PCI bridge to [bus 20]
[    1.892551] ACPI: PCI Interrupt Link [LNKA] (IRQs 4 5 7 10 11 14 15) *0
[    1.894304] ACPI: PCI Interrupt Link [LNKB] (IRQs 4 5 7 10 11 14 15) *0
[    1.895889] ACPI: PCI Interrupt Link [LNKC] (IRQs 4 5 7 10 11 14 15) *0
[    1.897759] ACPI: PCI Interrupt Link [LNKD] (IRQs 4 5 7 10 11 14 15) *0
[    1.899533] ACPI: PCI Interrupt Link [LNKE] (IRQs 4 5 7 10 11 14 15) *0
[    1.901043] ACPI: PCI Interrupt Link [LNKF] (IRQs 4 5 7 10 11 14 15) *0
[    1.902537] ACPI: PCI Interrupt Link [LNKG] (IRQs 4 5 7 10 11 14 15) *0
[    1.904049] ACPI: PCI Interrupt Link [LNKH] (IRQs 4 5 7 10 11 14 15) *0
[    1.917580] pci 0000:00:01.0: vgaarb: setting as boot VGA device
[    1.917580] pci 0000:00:01.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    1.917580] pci 0000:00:01.0: vgaarb: bridge control possible
[    1.917580] vgaarb: loaded
[    1.919729] SCSI subsystem initialized
[    1.921188] libata version 3.00 loaded.
[    1.921529] ACPI: bus type USB registered
[    1.921755] usbcore: registered new interface driver usbfs
[    1.923119] usbcore: registered new interface driver hub
[    1.923364] usbcore: registered new device driver usb
[    1.924309] EDAC MC: Ver: 3.0.0
[    1.926223] PCI: Using ACPI for IRQ routing
[    1.928596] PCI: pci_cache_line_size set to 64 bytes
[    1.928678] e820: reserve RAM buffer [mem 0x0009d400-0x0009ffff]
[    1.928691] e820: reserve RAM buffer [mem 0xd6cf2000-0xd7ffffff]
[    1.928702] e820: reserve RAM buffer [mem 0xdac19000-0xdbffffff]
[    1.928713] e820: reserve RAM buffer [mem 0xdaeae000-0xdbffffff]
[    1.928725] e820: reserve RAM buffer [mem 0xde000000-0xdfffffff]
[    1.928747] e820: reserve RAM buffer [mem 0x1ff000000-0x1ffffffff]
[    1.930332] NetLabel: Initializing
[    1.930334] NetLabel:  domain hash size = 128
[    1.930335] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    1.930578] NetLabel:  unlabeled traffic allowed by default
[    1.931306] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    1.931312] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    1.933220] clocksource: Switched to clocksource hpet
[    2.201070] VFS: Disk quotas dquot_6.6.0
[    2.201756] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    2.203214] pnp: PnP ACPI init
[    2.204846] system 00:00: [mem 0xf8000000-0xfbffffff] has been reserved
[    2.204888] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    2.206521] system 00:01: [mem 0xfeb80000-0xfebfffff] could not be reserved
[    2.206561] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    2.207926] system 00:02: [mem 0xc0000000-0xdfffffff] could not be reserved
[    2.207963] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    2.210140] pnp 00:03: Plug and Play ACPI device, IDs PNP0b00 (active)
[    2.214244] system 00:04: [io  0x0300-0x030f] has been reserved
[    2.214277] system 00:04: [io  0x0230-0x023f] has been reserved
[    2.214304] system 00:04: [io  0x0290-0x029f] has been reserved
[    2.214351] system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
[    2.224408] system 00:05: [io  0x04d0-0x04d1] has been reserved
[    2.224437] system 00:05: [io  0x040b] has been reserved
[    2.224469] system 00:05: [io  0x04d6] has been reserved
[    2.224495] system 00:05: [io  0x0c00-0x0c01] has been reserved
[    2.224521] system 00:05: [io  0x0c14] has been reserved
[    2.224551] system 00:05: [io  0x0c50-0x0c51] has been reserved
[    2.224577] system 00:05: [io  0x0c52] has been reserved
[    2.224603] system 00:05: [io  0x0c6c] has been reserved
[    2.224628] system 00:05: [io  0x0c6f] has been reserved
[    2.224654] system 00:05: [io  0x0cd0-0x0cd1] has been reserved
[    2.224680] system 00:05: [io  0x0cd2-0x0cd3] has been reserved
[    2.224706] system 00:05: [io  0x0cd4-0x0cd5] has been reserved
[    2.224731] system 00:05: [io  0x0cd6-0x0cd7] has been reserved
[    2.224757] system 00:05: [io  0x0cd8-0x0cdf] has been reserved
[    2.224783] system 00:05: [io  0x0800-0x089f] has been reserved
[    2.224808] system 00:05: [io  0x0b00-0x0b0f] has been reserved
[    2.224833] system 00:05: [io  0x0b20-0x0b3f] has been reserved
[    2.224859] system 00:05: [io  0x0900-0x090f] has been reserved
[    2.224884] system 00:05: [io  0x0910-0x091f] has been reserved
[    2.224921] system 00:05: [mem 0xfec00000-0xfec00fff] could not be reserved
[    2.224954] system 00:05: [mem 0xfec01000-0xfec01fff] could not be reserved
[    2.224980] system 00:05: [mem 0xfedc0000-0xfedc0fff] has been reserved
[    2.225020] system 00:05: [mem 0xfee00000-0xfee00fff] has been reserved
[    2.225051] system 00:05: [mem 0xfed80000-0xfed8ffff] has been reserved
[    2.225079] system 00:05: [mem 0xfec10000-0xfec10fff] has been reserved
[    2.225105] system 00:05: [mem 0xff000000-0xffffffff] has been reserved
[    2.225151] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    2.239134] pnp: PnP ACPI: found 6 devices
[    2.283849] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    2.284161] pci 0000:1d:00.0: PCI bridge to [bus 1e]
[    2.284169] pci 0000:1d:00.0:   bridge window [io  0xe000-0xefff]
[    2.284175] pci 0000:1d:00.0:   bridge window [mem 0xfe700000-0xfe7fffff]
[    2.284186] pci 0000:1d:01.0: PCI bridge to [bus 1f]
[    2.284200] pci 0000:1d:04.0: PCI bridge to [bus 20]
[    2.284214] pci 0000:05:00.2: PCI bridge to [bus 1d-20]
[    2.284218] pci 0000:05:00.2:   bridge window [io  0xe000-0xefff]
[    2.284224] pci 0000:05:00.2:   bridge window [mem 0xfe700000-0xfe7fffff]
[    2.284234] pci 0000:00:02.4: PCI bridge to [bus 05-20]
[    2.284237] pci 0000:00:02.4:   bridge window [io  0xe000-0xefff]
[    2.284241] pci 0000:00:02.4:   bridge window [mem 0xfe700000-0xfe8fffff]
[    2.284255] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    2.284257] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
[    2.284260] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
[    2.284262] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    2.284264] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff window]
[    2.284266] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff window]
[    2.284269] pci_bus 0000:00: resource 10 [mem 0xe0000000-0xfec2ffff window]
[    2.284272] pci_bus 0000:00: resource 11 [mem 0xfee00000-0xffffffff window]
[    2.284274] pci_bus 0000:05: resource 0 [io  0xe000-0xefff]
[    2.284276] pci_bus 0000:05: resource 1 [mem 0xfe700000-0xfe8fffff]
[    2.284279] pci_bus 0000:1d: resource 0 [io  0xe000-0xefff]
[    2.284281] pci_bus 0000:1d: resource 1 [mem 0xfe700000-0xfe7fffff]
[    2.284283] pci_bus 0000:1e: resource 0 [io  0xe000-0xefff]
[    2.284285] pci_bus 0000:1e: resource 1 [mem 0xfe700000-0xfe7fffff]
[    2.286734] NET: Registered protocol family 2
[    2.289547] TCP established hash table entries: 65536 (order: 7, 524288 bytes)
[    2.290084] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    2.290446] TCP: Hash tables configured (established 65536 bind 65536)
[    2.291726] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[    2.291846] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[    2.294129] NET: Registered protocol family 1
[    2.294212] pci 0000:00:01.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    2.302887] PCI: CLS 64 bytes, default 64
[    2.303321] Unpacking initramfs...
[    5.114768] Freeing initrd memory: 77636K
[    5.114806] AMD-Vi: IOMMU performance counters supported
[    5.117183] pci 0000:00:00.2: can't derive routing for PCI INT A
[    5.117185] pci 0000:00:00.2: PCI INT A: not connected
[    5.122726] iommu: Adding device 0000:00:01.0 to group 0
[    5.123691] iommu: Using direct mapping for device 0000:00:01.0
[    5.123836] iommu: Adding device 0000:00:01.1 to group 0
[    5.127809] iommu: Adding device 0000:00:02.0 to group 1
[    5.127961] iommu: Adding device 0000:00:02.4 to group 1
[    5.131956] iommu: Adding device 0000:00:03.0 to group 2
[    5.135646] iommu: Adding device 0000:00:08.0 to group 3
[    5.138731] iommu: Adding device 0000:00:09.0 to group 4
[    5.141976] iommu: Adding device 0000:00:10.0 to group 5
[    5.145109] iommu: Adding device 0000:00:11.0 to group 6
[    5.148434] iommu: Adding device 0000:00:14.0 to group 7
[    5.148578] iommu: Adding device 0000:00:14.3 to group 7
[    5.151577] iommu: Adding device 0000:00:18.0 to group 8
[    5.151722] iommu: Adding device 0000:00:18.1 to group 8
[    5.151842] iommu: Adding device 0000:00:18.2 to group 8
[    5.151968] iommu: Adding device 0000:00:18.3 to group 8
[    5.152163] iommu: Adding device 0000:00:18.4 to group 8
[    5.152295] iommu: Adding device 0000:00:18.5 to group 8
[    5.152470] iommu: Adding device 0000:05:00.0 to group 1
[    5.152588] iommu: Adding device 0000:05:00.1 to group 1
[    5.152699] iommu: Adding device 0000:05:00.2 to group 1
[    5.152818] iommu: Adding device 0000:1d:00.0 to group 1
[    5.152931] iommu: Adding device 0000:1d:01.0 to group 1
[    5.153067] iommu: Adding device 0000:1d:04.0 to group 1
[    5.153195] iommu: Adding device 0000:1e:00.0 to group 1
[    5.153783] AMD-Vi: Found IOMMU at 0000:00:00.2 cap 0x40
[    5.153785] AMD-Vi: Extended features (0x37ef22294ada):
[    5.153787]  PPR NX GT IA GA PC GA_vAPIC
[    5.153791] AMD-Vi: Interrupt remapping enabled
[    5.153791] AMD-Vi: virtual APIC enabled
[    5.155218] AMD-Vi: Lazy IO/TLB flushing enabled
[    5.163146] amd_uncore: AMD NB counters detected
[    5.164337] LVT offset 0 assigned for vector 0x400
[    5.165731] perf: AMD IBS detected (0x000007ff)
[    5.165872] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 counters/bank).
[    5.183094] audit: initializing netlink subsys (disabled)
[    5.183870] audit: type=2000 audit(1510852777.182:1): state=initialized audit_enabled=0 res=1
[    5.187595] Initialise system trusted keyrings
[    5.187675] Key type blacklist registered
[    5.188423] workingset: timestamp_bits=36 max_order=21 bucket_order=0
[    5.224763] zbud: loaded
[    5.239635] SELinux:  Registering netfilter hooks
[    5.538979] NET: Registered protocol family 38
[    5.539028] Key type asymmetric registered
[    5.539029] Asymmetric key parser 'x509' registered
[    5.539620] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 248)
[    5.539973] io scheduler noop registered
[    5.539976] io scheduler deadline registered
[    5.540995] io scheduler cfq registered (default)
[    5.540997] io scheduler mq-deadline registered
[    5.540998] io scheduler kyber registered
[    5.541443] atomic64_test: passed for x86-64 platform with CX8 and with SSE
[    5.556121] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    5.556258] ACPI: Power Button [PWRB]
[    5.556870] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    5.556959] ACPI: Power Button [PWRF]
[    5.564559] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    5.599393] Non-volatile memory driver v1.3
[    5.599655] Linux agpgart interface v0.103
[    5.607145] ahci 0000:00:11.0: version 3.0
[    5.610868] ahci 0000:00:11.0: AHCI 0001.0300 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
[    5.610874] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp fbs pio slum part 
[    5.613212] scsi host0: ahci
[    5.615221] ata1: SATA max UDMA/133 abar m1024@0xfe968000 port 0xfe968100 irq 19
[    5.617236] ahci 0000:05:00.1: SSS flag set, parallel bus scan disabled
[    5.827560] ahci 0000:05:00.1: AHCI 0001.0301 32 slots 8 ports 6 Gbps 0x33 impl SATA mode
[    5.827565] ahci 0000:05:00.1: flags: 64bit ncq sntf stag pm led clo only pmp pio slum part sxs deso sadm sds apst 
[    5.840581] scsi host1: ahci
[    5.842333] scsi host2: ahci
[    5.843894] scsi host3: ahci
[    5.845261] scsi host4: ahci
[    5.846779] scsi host5: ahci
[    5.848289] scsi host6: ahci
[    5.849766] scsi host7: ahci
[    5.851694] scsi host8: ahci
[    5.852680] ata2: SATA max UDMA/133 abar m131072@0xfe880000 port 0xfe880100 irq 33
[    5.852684] ata3: SATA max UDMA/133 abar m131072@0xfe880000 port 0xfe880180 irq 33
[    5.852685] ata4: DUMMY
[    5.852686] ata5: DUMMY
[    5.852689] ata6: SATA max UDMA/133 abar m131072@0xfe880000 port 0xfe880300 irq 33
[    5.852691] ata7: SATA max UDMA/133 abar m131072@0xfe880000 port 0xfe880380 irq 33
[    5.852692] ata8: DUMMY
[    5.852693] ata9: DUMMY
[    5.853777] libphy: Fixed MDIO Bus: probed
[    5.854359] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    5.854388] ehci-pci: EHCI PCI platform driver
[    5.854516] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    5.854538] ohci-pci: OHCI PCI platform driver
[    5.854665] uhci_hcd: USB Universal Host Controller Interface driver
[    5.858672] xhci_hcd 0000:00:10.0: xHCI Host Controller
[    5.859406] xhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
[    5.860135] xhci_hcd 0000:00:10.0: hcc params 0x014040c3 hci version 0x100 quirks 0x00000410
[    5.864261] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    5.864265] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.864266] usb usb1: Product: xHCI Host Controller
[    5.864268] usb usb1: Manufacturer: Linux 4.14.0-rc3+ xhci-hcd
[    5.864270] usb usb1: SerialNumber: 0000:00:10.0
[    5.866196] hub 1-0:1.0: USB hub found
[    5.866324] hub 1-0:1.0: 4 ports detected
[    5.870436] xhci_hcd 0000:00:10.0: xHCI Host Controller
[    5.871214] xhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
[    5.871434] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[    5.871922] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003
[    5.871925] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.871926] usb usb2: Product: xHCI Host Controller
[    5.871928] usb usb2: Manufacturer: Linux 4.14.0-rc3+ xhci-hcd
[    5.871930] usb usb2: SerialNumber: 0000:00:10.0
[    5.873880] hub 2-0:1.0: USB hub found
[    5.874031] hub 2-0:1.0: 4 ports detected
[    5.879898] xhci_hcd 0000:05:00.0: xHCI Host Controller
[    5.880657] xhci_hcd 0000:05:00.0: new USB bus registered, assigned bus number 3
[    5.930207] ata1: SATA link down (SStatus 0 SControl 300)
[    5.936845] xhci_hcd 0000:05:00.0: hcc params 0x0200ef81 hci version 0x110 quirks 0x08000410
[    5.941607] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
[    5.941612] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.941614] usb usb3: Product: xHCI Host Controller
[    5.941616] usb usb3: Manufacturer: Linux 4.14.0-rc3+ xhci-hcd
[    5.941618] usb usb3: SerialNumber: 0000:05:00.0
[    5.943645] hub 3-0:1.0: USB hub found
[    5.943847] hub 3-0:1.0: 10 ports detected
[    6.175116] tsc: Refined TSC clocksource calibration: 3792.880 MHz
[    6.175165] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x6d58273f81c, max_idle_ns: 881591146675 ns
[    6.286736] xhci_hcd 0000:05:00.0: xHCI Host Controller
[    6.287582] xhci_hcd 0000:05:00.0: new USB bus registered, assigned bus number 4
[    6.287612] xhci_hcd 0000:05:00.0: Host supports USB 3.1 Enhanced SuperSpeed
[    6.287880] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
[    6.288458] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003
[    6.288460] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    6.288462] usb usb4: Product: xHCI Host Controller
[    6.288465] usb usb4: Manufacturer: Linux 4.14.0-rc3+ xhci-hcd
[    6.288466] usb usb4: SerialNumber: 0000:05:00.0
[    6.293433] hub 4-0:1.0: USB hub found
[    6.293621] hub 4-0:1.0: 4 ports detected
[    6.319214] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    6.326369] ata2.00: ATA-8: KINGSTON SV300S37A120G, 608ABBF0, max UDMA/133
[    6.326373] ata2.00: 234441648 sectors, multi 1: LBA48 NCQ (depth 31/32), AA
[    6.331488] ata2.00: configured for UDMA/133
[    6.338291] scsi 1:0:0:0: Direct-Access     ATA      KINGSTON SV300S3 BBF0 PQ: 0 ANSI: 5
[    6.341096] sd 1:0:0:0: [sda] 234441648 512-byte logical blocks: (120 GB/112 GiB)
[    6.341210] sd 1:0:0:0: [sda] Write Protect is off
[    6.341216] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    6.341305] sd 1:0:0:0: Attached scsi generic sg0 type 0
[    6.341471] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    6.344669]  sda: sda1 sda2 sda3
[    6.349803] sd 1:0:0:0: [sda] Attached SCSI disk
[    6.432713] usbcore: registered new interface driver usbserial
[    6.432789] usbcore: registered new interface driver usbserial_generic
[    6.432862] usbserial: USB Serial support registered for generic
[    6.433379] i8042: PNP: No PS/2 controller found.
[    6.433978] mousedev: PS/2 mouse device common for all mice
[    6.435038] rtc_cmos 00:03: RTC can wake from S4
[    6.435630] rtc_cmos 00:03: rtc core: registered rtc_cmos as rtc0
[    6.435704] rtc_cmos 00:03: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    6.435804] IR NEC protocol handler initialized
[    6.435806] IR RC5(x/sz) protocol handler initialized
[    6.435806] IR RC6 protocol handler initialized
[    6.435808] IR JVC protocol handler initialized
[    6.435808] IR Sony protocol handler initialized
[    6.435809] IR SANYO protocol handler initialized
[    6.435810] IR Sharp protocol handler initialized
[    6.435811] IR MCE Keyboard/mouse protocol handler initialized
[    6.435812] IR XMP protocol handler initialized
[    6.440163] device-mapper: uevent: version 1.0.3
[    6.441686] device-mapper: ioctl: 4.36.0-ioctl (2017-06-09) initialised: dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
[    6.448624] hidraw: raw HID events driver (C) Jiri Kosina
[    6.449297] usbcore: registered new interface driver usbhid
[    6.449297] usbhid: USB HID core driver
[    6.450364] drop_monitor: Initializing network drop monitor service
[    6.450803] ip_tables: (C) 2000-2006 Netfilter Core Team
[    6.451499] Initializing XFRM netlink socket
[    6.454965] NET: Registered protocol family 10
[    6.470684] Segment Routing with IPv6
[    6.470799] mip6: Mobile IPv6
[    6.470804] NET: Registered protocol family 17
[    6.474277] microcode: CPU0: patch_level=0x06006118
[    6.474309] microcode: CPU1: patch_level=0x06006118
[    6.474343] microcode: CPU2: patch_level=0x06006118
[    6.474376] microcode: CPU3: patch_level=0x06006118
[    6.474676] microcode: Microcode Update Driver: v2.2.
[    6.474759] AVX2 version of gcm_enc/dec engaged.
[    6.474760] AES CTR mode by8 optimization enabled
[    6.528305] sched_clock: Marking stable (6528275097, 0)->(6673485573, -145210476)
[    6.530122] registered taskstats version 1
[    6.530217] Loading compiled-in X.509 certificates
[    6.600824] Loaded X.509 cert 'Build time autogenerated kernel key: 4a8b10ec1abbeb49297210aa9a53ca0955df230f'
[    6.601717] zswap: loaded using pool lzo/zbud
[    6.602426] kmemleak: Kernel memory leak detector initialized
[    6.602435] kmemleak: Automatic memory scanning thread started
[    6.609155] usb 3-10: new high-speed USB device number 2 using xhci_hcd
[    6.622527] Key type big_key registered
[    6.631579] Key type encrypted registered
[    6.634632]   Magic number: 9:308:340
[    6.635289] rtc_cmos 00:03: setting system clock to 2017-11-16 17:19:39 UTC (1510852779)
[    6.654176] ata3: SATA link down (SStatus 0 SControl 300)
[    6.753385] usb 3-10: New USB device found, idVendor=0409, idProduct=005a
[    6.753390] usb 3-10: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    6.757724] hub 3-10:1.0: USB hub found
[    6.760330] hub 3-10:1.0: 4 ports detected
[    6.968379] ata6: SATA link down (SStatus 0 SControl 300)
[    7.091292] usb 3-10.4: new low-speed USB device number 3 using xhci_hcd
[    7.183962] clocksource: Switched to clocksource tsc
[    7.280647] ata7: SATA link down (SStatus 0 SControl 300)
[    7.292001] Freeing unused kernel memory: 3292K
[    7.292073] Write protecting the kernel read-only data: 26624k
[    7.293599] Freeing unused kernel memory: 772K
[    7.302382] Freeing unused kernel memory: 1496K
[    7.337912] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    7.337921] rodata_test: all tests were successful
[    7.409866] systemd[1]: systemd 233 running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN default-hierarchy=hybrid)
[    7.411146] systemd[1]: Detected architecture x86-64.
[    7.411163] systemd[1]: Running in initial RAM disk.
[    7.411262] systemd[1]: Set hostname to <carrizo>.
[    7.453326] usb 3-10.4: New USB device found, idVendor=046d, idProduct=c31c
[    7.453331] usb 3-10.4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    7.453333] usb 3-10.4: Product: USB Keyboard
[    7.453335] usb 3-10.4: Manufacturer: Logitech
[    7.561215] input: Logitech USB Keyboard as /devices/pci0000:00/0000:00:02.4/0000:05:00.0/usb3/3-10/3-10.4/3-10.4:1.0/0003:046D:C31C.0001/input/input2
[    7.585338] systemd[1]: /run/systemd/generator/dev-disk-by\x2duuid-66163c80\x2d0ca1\x2d4beb\x2daeba\x2d5cc130b813e6.device.d/timeout.conf:3: Unknown lvalue 'JobRunningTimeoutSec' in section 'Unit'
[    7.590337] systemd[1]: Listening on Journal Socket.
[    7.590727] systemd[1]: Listening on udev Kernel Socket.
[    7.590751] systemd[1]: Reached target Timers.
[    7.591282] systemd[1]: Listening on Journal Audit Socket.
[    7.591550] systemd[1]: Listening on udev Control Socket.
[    7.618199] hid-generic 0003:046D:C31C.0001: input,hidraw0: USB HID v1.10 Keyboard [Logitech USB Keyboard] on usb-0000:05:00.0-10.4/input0
[    7.670556] audit: type=1130 audit(1510852780.535:2): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=kmod-static-nodes comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    7.678983] audit: type=1130 audit(1510852780.543:3): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-sysctl comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    7.703948] audit: type=1130 audit(1510852780.568:4): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-tmpfiles-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    7.724529] audit: type=1130 audit(1510852780.589:5): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-tmpfiles-setup-dev comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    7.746852] input: Logitech USB Keyboard as /devices/pci0000:00/0000:00:02.4/0000:05:00.0/usb3/3-10/3-10.4/3-10.4:1.1/0003:046D:C31C.0002/input/input3
[    7.799572] hid-generic 0003:046D:C31C.0002: input,hidraw1: USB HID v1.10 Device [Logitech USB Keyboard] on usb-0000:05:00.0-10.4/input1
[    7.838683] input: Logitech USB Keyboard as /devices/pci0000:00/0000:00:02.4/0000:05:00.0/usb3/3-10/3-10.4/3-10.4:1.2/0003:046D:C31C.0003/input/input4
[    7.841481] hid-generic 0003:046D:C31C.0003: input,hidraw2: USB HID v1.10 Mouse [Logitech USB Keyboard] on usb-0000:05:00.0-10.4/input2
[    7.911619] audit: type=1130 audit(1510852780.776:6): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-cmdline comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    7.949428] audit: type=1130 audit(1510852780.813:7): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-journald comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    7.970297] audit: type=1130 audit(1510852780.834:8): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-vconsole-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    7.970335] audit: type=1131 audit(1510852780.834:9): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-vconsole-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    8.049193] audit: type=1130 audit(1510852780.914:10): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-pre-udev comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    8.964892] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[    8.984941] r8169 0000:1e:00.0 eth0: RTL8168h/8111h at 0xffffc90000d52000, b0:6e:bf:2f:47:8d, XID 14100800 IRQ 44
[    8.984947] r8169 0000:1e:00.0 eth0: jumbo features [frames: 9200 bytes, tx checksumming: ko]
[    9.161816] r8169 0000:1e:00.0 enp30s0: renamed from eth0
[    9.592227] EXT4-fs (sda3): mounted filesystem with ordered data mode. Opts: (null)
[   10.202365] kauditd_printk_skb: 8 callbacks suppressed
[   10.202370] audit: type=1131 audit(1510852783.067:19): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-pre-pivot comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   10.212395] audit: type=1130 audit(1510852783.077:20): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-initqueue comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   10.212498] audit: type=1131 audit(1510852783.077:21): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-initqueue comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   10.215610] audit: type=1130 audit(1510852783.080:22): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-udev-trigger comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   10.215690] audit: type=1131 audit(1510852783.080:23): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-udev-trigger comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   10.218593] audit: type=1130 audit(1510852783.083:24): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-sysctl comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   10.218720] audit: type=1131 audit(1510852783.083:25): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-sysctl comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   10.221940] audit: type=1130 audit(1510852783.086:26): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-tmpfiles-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   10.222072] audit: type=1131 audit(1510852783.086:27): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-tmpfiles-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   10.243405] audit: type=1130 audit(1510852783.108:28): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-udevd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   10.591307] systemd-journald[218]: Received SIGTERM from PID 1 (systemd).
[   10.846497] systemd: 20 output lines suppressed due to ratelimiting
[   10.989745] SELinux:  Disabled at runtime.
[   10.989773] SELinux:  Unregistering netfilter hooks
[   11.486510] EXT4-fs (sda3): re-mounted. Opts: (null)
[   11.694916] systemd-journald[463]: Received request to flush runtime journal from PID 1
[   12.230396] acpi_cpufreq: overriding BIOS provided _PSD data
[   12.337549] ACPI: Video Device [VGA2] (multi-head: yes  rom: no  post: no)
[   12.344170] acpi device:4c: registered as cooling_device4
[   12.345483] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:02/input/input5
[   12.572635] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, revision 0
[   12.572641] piix4_smbus 0000:00:14.0: Using register 0x2e for SMBus port selection
[   12.691832] input: PC Speaker as /devices/platform/pcspkr/input/input6
[   12.721813] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver v0.05
[   12.724651] sp5100_tco: PCI Vendor ID: 0x1022, Device ID: 0x790b, Revision ID: 0x4a
[   12.724679] sp5100_tco: I/O address 0x0cd6 already in use
[   13.072817] Adding 7826428k swap on /dev/sda2.  Priority:-2 extents:1 across:7826428k SSFS
[   13.612134] snd_hda_intel 0000:00:01.1: Force to non-snoop mode
[   13.656400] input: HDA ATI HDMI HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:01.1/sound/card0/input7
[   13.722218] kvm: Nested Virtualization enabled
[   13.722517] kvm: Nested Paging enabled
[   13.722519] SVM: Virtual VMLOAD VMSAVE supported
[   13.722520] SVM: Virtual GIF supported
[   13.987903] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[   14.593206] RPC: Registered named UNIX socket transport module.
[   14.593209] RPC: Registered udp transport module.
[   14.593210] RPC: Registered tcp transport module.
[   14.593211] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   14.693756] random: crng init done
[   15.332234] IPv6: ADDRCONF(NETDEV_UP): enp30s0: link is not ready
[   15.362232] r8169 0000:1e:00.0 enp30s0: link down
[   15.362291] r8169 0000:1e:00.0 enp30s0: link down
[   15.362830] IPv6: ADDRCONF(NETDEV_UP): enp30s0: link is not ready
[   16.121386] ip6_tables: (C) 2000-2006 Netfilter Core Team
[   16.269497] Ebtables v2.0 registered
[   16.932946] tun: Universal TUN/TAP device driver, 1.6
[   16.938252] virbr0: port 1(virbr0-nic) entered blocking state
[   16.938282] virbr0: port 1(virbr0-nic) entered disabled state
[   16.939522] device virbr0-nic entered promiscuous mode
[   17.479672] nf_conntrack version 0.5.0 (65536 buckets, 262144 max)
[   18.118045] virbr0: port 1(virbr0-nic) entered blocking state
[   18.118083] virbr0: port 1(virbr0-nic) entered listening state
[   18.291438] virbr0: port 1(virbr0-nic) entered disabled state
[   19.132634] r8169 0000:1e:00.0 enp30s0: link up
[   19.132653] IPv6: ADDRCONF(NETDEV_CHANGE): enp30s0: link becomes ready
[   29.222619] [drm] amdgpu kernel modesetting enabled.
[   29.230887] [drm] initializing kernel modesetting (CARRIZO 0x1002:0x9874 0x1043:0x8719 0xE1).
[   29.230980] [drm] register mmio base: 0xFE900000
[   29.230981] [drm] register mmio size: 262144
[   29.243279] [drm] UVD is enabled in physical mode
[   29.243285] [drm] VCE enabled in physical mode
[   29.259592] [drm] BIOS signature incorrect 20 7
[   29.259823] ATOM BIOS: 109-C95010-003
[   29.262022] [drm] vm size is 64 GB, block size is 13-bit, fragment size is 9-bit
[   29.262053] amdgpu 0000:00:01.0: VRAM: 512M 0x000000F400000000 - 0x000000F41FFFFFFF (512M used)
[   29.262058] amdgpu 0000:00:01.0: GTT: 1024M 0x0000000000000000 - 0x000000003FFFFFFF
[   29.262108] [drm] Detected VRAM RAM=512M, BAR=512M
[   29.262110] [drm] RAM width 128bits UNKNOWN
[   29.264285] [TTM] Zone  kernel: Available graphics memory: 3324274 kiB
[   29.264290] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[   29.264292] [TTM] Initializing pool allocator
[   29.264836] [TTM] Initializing DMA pool allocator
[   29.265821] [drm] amdgpu: 512M of VRAM memory ready
[   29.265844] [drm] amdgpu: 3072M of GTT memory ready.
[   29.266170] [drm] GART: num cpu pages 262144, num gpu pages 262144
[   29.266687] [drm] PCIE GART of 1024M enabled (table at 0x000000F400040000).
[   29.279892] [drm] Chained IB support enabled!
[   29.305962] [drm] Found UVD firmware Version: 1.91 Family ID: 11
[   29.310085] [drm] Found VCE firmware Version: 52.4 Binary ID: 3
[   29.319893] [drm] DM_PPLIB: values for Engine clock
[   29.319899] [drm] DM_PPLIB:	 45000
[   29.319900] [drm] DM_PPLIB:	 57600
[   29.319901] [drm] DM_PPLIB:	 68572
[   29.319901] [drm] DM_PPLIB:	 80000
[   29.319902] [drm] DM_PPLIB:	 90000
[   29.319903] [drm] DM_PPLIB:	 96000
[   29.319903] [drm] DM_PPLIB:	 102858
[   29.319904] [drm] DM_PPLIB:	 110770
[   29.319906] [drm] DM_PPLIB: Validation clocks:
[   29.319907] [drm] DM_PPLIB:    engine_max_clock: 110770
[   29.319907] [drm] DM_PPLIB:    memory_max_clock: 106600
[   29.319908] [drm] DM_PPLIB:    level           : 0
[   29.319910] [drm] DM_PPLIB: values for Display clock
[   29.319911] [drm] DM_PPLIB:	 30000
[   29.319912] [drm] DM_PPLIB:	 40000
[   29.319912] [drm] DM_PPLIB:	 49656
[   29.319913] [drm] DM_PPLIB:	 62609
[   29.319914] [drm] DM_PPLIB:	 68572
[   29.319914] [drm] DM_PPLIB:	 75790
[   29.319915] [drm] DM_PPLIB:	 80000
[   29.319915] [drm] DM_PPLIB:	 84706
[   29.319916] [drm] DM_PPLIB: Validation clocks:
[   29.319917] [drm] DM_PPLIB:    engine_max_clock: 110770
[   29.319917] [drm] DM_PPLIB:    memory_max_clock: 106600
[   29.319918] [drm] DM_PPLIB:    level           : 0
[   29.319919] [drm] DM_PPLIB: values for Memory clock
[   29.319920] [drm] DM_PPLIB:	 66700
[   29.319921] [drm] DM_PPLIB:	 106600
[   29.319921] [drm] DM_PPLIB: Validation clocks:
[   29.319922] [drm] DM_PPLIB:    engine_max_clock: 110770
[   29.319923] [drm] DM_PPLIB:    memory_max_clock: 106600
[   29.319923] [drm] DM_PPLIB:    level           : 0
[   29.319927] [drm] DC: create_links: connectors_num: physical:3, virtual:0
[   29.624090] [drm:hwss_wait_for_blank_complete [amdgpu]] *ERROR* DC: failed to blank crtc!
[   29.624200] [drm] Display Core initialized!
[   29.644132] [drm] SADs count is: -2, don't need to read it
[   29.644214] [drm] 2228W: [Block 0] 
[   29.644233] [drm] dc_link_detect: manufacturer_id = E305, product_id = 2228, serial_number = 1010101, manufacture_week = 24, manufacture_year = 25, display_name = 2228W, speaker_flag = 0, audio_mode_count = 0
[   29.649552] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   29.649555] [drm] Driver supports precise vblank timestamp query.
[   30.678922] [drm] UVD initialized successfully.
[   30.880110] [drm] VCE initialized successfully.
[   30.891301] [drm] fb mappable at 0x2015BD000
[   30.891304] [drm] vram apper at 0x1FF000000
[   30.891305] [drm] size 8294400
[   30.891306] [drm] fb depth is 24
[   30.891307] [drm]    pitch is 7680
[   30.892482] fbcon: amdgpudrmfb (fb0) is primary device
[   30.911308] [drm] {1920x1080, 2200x1125@148500Khz}
[   30.970826] Console: switching to colour frame buffer device 240x67
[   31.003134] amdgpu 0000:00:01.0: fb0: amdgpudrmfb frame buffer device
[   31.039027] [drm] Initialized amdgpu 3.23.0 20150101 for 0000:00:01.0 on minor 0
[   81.519341] PM: suspend entry (deep)
[   81.519345] PM: Syncing filesystems ... done.
[   81.549521] Freezing user space processes ... (elapsed 0.004 seconds) done.
[   81.553665] OOM killer disabled.
[   81.553666] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
[   81.555808] Suspending console(s) (use no_console_suspend to debug)
[   81.557207] sd 1:0:0:0: [sda] Synchronizing SCSI cache
[   81.557344] sd 1:0:0:0: [sda] Stopping disk
[   82.798474] amdgpu 0000:00:01.0: ffff8801a2cb7700 unpin not necessary
[   82.798481] amdgpu 0000:00:01.0: ffff88019fa2dd80 unpin not necessary
[   82.813360] PM: suspend devices took 1.258 seconds
[   82.867431] ACPI: Preparing to enter system sleep state S3
[   83.232466] PM: Saving platform NVS memory
[   83.232524] Disabling non-boot CPUs ...
[   83.247785] smpboot: CPU 1 is now offline
[   83.262465] smpboot: CPU 2 is now offline
[   83.278657] smpboot: CPU 3 is now offline
[   83.279763] ACPI: Low-level resume complete
[   83.279868] PM: Restoring platform NVS memory
[   83.279963] LVT offset 0 assigned for vector 0x400
[   83.280660] Enabling non-boot CPUs ...
[   83.280961] x86: Booting SMP configuration:
[   83.280962] smpboot: Booting Node 0 Processor 1 APIC 0x11
[   83.281051] ==================================================================
[   83.281061] BUG: KASAN: use-after-free in find_cpio_data+0x134/0x490
[   83.281063] Read of size 1 at addr ffff88002e84e000 by task swapper/1/0

[   83.281067] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.14.0-rc3+ #21
[   83.281069] Hardware name: System manufacturer System Product Name/TUF B350M-PLUS GAMING, BIOS 0902 09/08/2017
[   83.281070] Call Trace:
[   83.281077]  dump_stack+0xb8/0x133
[   83.281080]  ? _atomic_dec_and_lock+0x16d/0x16d
[   83.281085]  ? show_regs_print_info+0x41/0x41
[   83.281089]  print_address_description+0x6f/0x280
[   83.281091]  kasan_report+0x27a/0x370
[   83.281093]  ? find_cpio_data+0x134/0x490
[   83.281096]  __asan_load1+0x47/0x50
[   83.281099]  find_cpio_data+0x134/0x490
[   83.281102]  ? dump_stack+0x133/0x133
[   83.281106]  ? kvm_register_clock+0x30/0xb0
[   83.281109]  ? __switch_to+0x399/0x710
[   83.281111]  ? snprintf+0x8f/0xc0
[   83.281113]  ? vsprintf+0x20/0x20
[   83.281116]  find_microcode_in_initrd+0x139/0x1c0
[   83.281119]  __load_ucode_amd+0x165/0x260
[   83.281121]  ? flush_tlb_func_remote+0x50/0x50
[   83.281124]  ? free_cache+0x160/0x160
[   83.281127]  ? flush_smp_call_function_queue+0x2e0/0x2e0
[   83.281130]  ? __lock_text_start+0x8/0x8
[   83.281132]  ? firmware_map_remove+0xec/0x154
[   83.281135]  load_ucode_amd_ap+0xa5/0x140
[   83.281137]  ? generic_exec_single+0x280/0x280
[   83.281139]  ? load_ucode_amd_ap+0xa5/0x140
[   83.281141]  ? request_microcode_amd+0x2b0/0x2b0
[   83.281143]  ? cpu_report_death+0xfe/0x160
[   83.281145]  ? cpu_wait_death+0x390/0x390
[   83.281148]  ? rcu_eqs_enter_common.constprop.68+0x139/0x1a0
[   83.281151]  load_ucode_ap+0x89/0xa0
[   83.281153]  cpu_init+0x5f6/0x6b0
[   83.281156]  ? native_play_dead+0x1f/0x101
[   83.281159]  ? arch_cpu_idle_dead+0x1b/0x20
[   83.281161]  ? syscall_init+0xb0/0xb0
[   83.281163]  ? cpu_startup_entry+0xe0/0xf0
[   83.281165]  ? cpu_in_idle+0x20/0x20
[   83.281169]  start_secondary+0xb0/0x350
[   83.281171]  ? set_cpu_sibling_map+0x960/0x960
[   83.281176]  secondary_startup_64+0xa5/0xa5

[   83.281178] The buggy address belongs to the page:
[   83.281182] page:ffffea0000ba1380 count:0 mapcount:0 mapping:          (null) index:0x1
[   83.281184] flags: 0xfffffc0000000()
[   83.281188] raw: 000fffffc0000000 0000000000000000 0000000000000001 00000000ffffffff
[   83.281190] raw: dead000000000100 dead000000000200 0000000000000000 0000000000000000
[   83.281191] page dumped because: kasan: bad access detected

[   83.281192] Memory state around the buggy address:
[   83.281194]  ffff88002e84df00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[   83.281196]  ffff88002e84df80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[   83.281197] >ffff88002e84e000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[   83.281198]                    ^
[   83.281200]  ffff88002e84e080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[   83.281202]  ffff88002e84e100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[   83.281202] ==================================================================
[   83.281203] Disabling lock debugging due to kernel taint
[   83.285208]  cache: parent cpu1 should not be sleeping
[   83.286385] microcode: CPU1: patch_level=0x06006118
[   83.289686] CPU1 is up
[   83.289993] smpboot: Booting Node 0 Processor 2 APIC 0x12
[   83.295573]  cache: parent cpu2 should not be sleeping
[   83.296858] microcode: CPU2: patch_level=0x06006118
[   83.301145] CPU2 is up
[   83.301486] smpboot: Booting Node 0 Processor 3 APIC 0x13
[   83.305863]  cache: parent cpu3 should not be sleeping
[   83.307470] microcode: CPU3: patch_level=0x06006118
[   83.312083] CPU3 is up
[   83.313464] ACPI: Waking up from system sleep state S3
[   83.439786] [drm] PCIE GART of 1024M enabled (table at 0x000000F400040000).
[   83.651823] usb usb3: root hub lost power or was reset
[   83.651825] usb usb4: root hub lost power or was reset
[   83.655067] sd 1:0:0:0: [sda] Starting disk
[   83.710002] r8169 0000:1e:00.0 enp30s0: link down
[   83.952392] [drm:hwss_wait_for_blank_complete [amdgpu]] *ERROR* DC: failed to blank crtc!
[   83.959970] ata7: SATA link down (SStatus 0 SControl 300)
[   83.961912] ata3: SATA link down (SStatus 0 SControl 300)
[   83.961913] ata1: SATA link down (SStatus 0 SControl 300)
[   84.017614] ata6: SATA link down (SStatus 0 SControl 300)
[   84.035674] usb 3-10: reset high-speed USB device number 2 using xhci_hcd
[   84.177187] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   84.188215] ata2.00: configured for UDMA/133
[   84.673443] usb 3-10.4: reset low-speed USB device number 3 using xhci_hcd
[   84.982716] [drm] UVD initialized successfully.
[   85.183925] [drm] VCE initialized successfully.
[   85.199234] [drm] SADs count is: -2, don't need to read it
[   85.199327] [drm] 2228W: [Block 0] 
[   85.199336] [drm] dc_link_detect: manufacturer_id = E305, product_id = 2228, serial_number = 1010101, manufacture_week = 24, manufacture_year = 25, display_name = 2228W, speaker_flag = 0, audio_mode_count = 0
[   85.316972] PM: resume devices took 1.877 seconds
[   85.317358] acpi LNXPOWER:07: Turning OFF
[   85.319615] OOM killer enabled.
[   85.319616] Restarting tasks ... done.
[   85.321928] video LNXVIDEO:02: Restoring backlight state
[   85.327020] PM: suspend exit
[   85.405324] [drm] {1920x1080, 2200x1125@148500Khz}
[   85.411932] IPv6: ADDRCONF(NETDEV_UP): enp30s0: link is not ready
[   85.419682] IPv6: ADDRCONF(NETDEV_UP): enp30s0: link is not ready
[   85.440820] r8169 0000:1e:00.0 enp30s0: link down
[   85.441917] IPv6: ADDRCONF(NETDEV_UP): enp30s0: link is not ready
[   88.584371] r8169 0000:1e:00.0 enp30s0: link up
[   88.584387] IPv6: ADDRCONF(NETDEV_CHANGE): enp30s0: link becomes ready
[   94.857756] PM: suspend entry (deep)
[   94.857762] PM: Syncing filesystems ... done.
[   94.920247] Freezing user space processes ... (elapsed 0.004 seconds) done.
[   94.924415] OOM killer disabled.
[   94.924416] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
[   94.926095] Suspending console(s) (use no_console_suspend to debug)
[   94.927371] sd 1:0:0:0: [sda] Synchronizing SCSI cache
[   94.927583] sd 1:0:0:0: [sda] Stopping disk
[   95.021421] amdgpu 0000:00:01.0: ffff8801a5890000 unpin not necessary
[   95.037765] PM: suspend devices took 0.112 seconds
[   95.091731] ACPI: Preparing to enter system sleep state S3
[   95.471439] PM: Saving platform NVS memory
[   95.471501] Disabling non-boot CPUs ...
[   95.488533] smpboot: CPU 1 is now offline
[   95.500785] smpboot: CPU 2 is now offline
[   95.510003] smpboot: CPU 3 is now offline
[   95.511143] ACPI: Low-level resume complete
[   95.511259] PM: Restoring platform NVS memory
[   95.511353] LVT offset 0 assigned for vector 0x400
[   95.512541] Enabling non-boot CPUs ...
[   95.512844] x86: Booting SMP configuration:
[   95.512846] smpboot: Booting Node 0 Processor 1 APIC 0x11
[   95.517026]  cache: parent cpu1 should not be sleeping
[   95.518197] microcode: CPU1: patch_level=0x06006118
[   95.521652] CPU1 is up
[   95.521944] smpboot: Booting Node 0 Processor 2 APIC 0x12
[   95.527135]  cache: parent cpu2 should not be sleeping
[   95.528467] microcode: CPU2: patch_level=0x06006118
[   95.532754] CPU2 is up
[   95.533111] smpboot: Booting Node 0 Processor 3 APIC 0x13
[   95.537507]  cache: parent cpu3 should not be sleeping
[   95.539319] microcode: CPU3: patch_level=0x06006118
[   95.543852] CPU3 is up
[   95.545204] ACPI: Waking up from system sleep state S3
[   95.673296] [drm] PCIE GART of 1024M enabled (table at 0x000000F400040000).
[   95.885782] usb usb3: root hub lost power or was reset
[   95.885785] usb usb4: root hub lost power or was reset
[   95.886106] sd 1:0:0:0: [sda] Starting disk
[   95.944041] r8169 0000:1e:00.0 enp30s0: link down
[   96.190446] [drm:hwss_wait_for_blank_complete [amdgpu]] *ERROR* DC: failed to blank crtc!
[   96.248618] ata3: SATA link down (SStatus 0 SControl 300)
[   96.248874] ata7: SATA link down (SStatus 0 SControl 300)
[   96.250322] ata6: SATA link down (SStatus 0 SControl 300)
[   96.250324] ata1: SATA link down (SStatus 0 SControl 300)
[   96.268664] usb 3-10: reset high-speed USB device number 2 using xhci_hcd
[   96.354278] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   96.365192] ata2.00: configured for UDMA/133
[   96.907812] usb 3-10.4: reset low-speed USB device number 3 using xhci_hcd
[   97.216884] [drm] UVD initialized successfully.
[   97.416264] [drm] VCE initialized successfully.
[   97.431632] [drm] SADs count is: -2, don't need to read it
[   97.431700] [drm] 2228W: [Block 0] 
[   97.431709] [drm] dc_link_detect: manufacturer_id = E305, product_id = 2228, serial_number = 1010101, manufacture_week = 24, manufacture_year = 25, display_name = 2228W, speaker_flag = 0, audio_mode_count = 0
[   97.564262] PM: resume devices took 1.891 seconds
[   97.566667] OOM killer enabled.
[   97.566668] Restarting tasks ... done.
[   97.569335] video LNXVIDEO:02: Restoring backlight state
[   97.579497] PM: suspend exit
[   97.603809] [drm] {1920x1080, 2200x1125@148500Khz}
[   97.662727] IPv6: ADDRCONF(NETDEV_UP): enp30s0: link is not ready
[   97.670516] IPv6: ADDRCONF(NETDEV_UP): enp30s0: link is not ready
[   97.688693] r8169 0000:1e:00.0 enp30s0: link down
[   97.689280] IPv6: ADDRCONF(NETDEV_UP): enp30s0: link is not ready
[  100.767705] r8169 0000:1e:00.0 enp30s0: link up
[  100.767720] IPv6: ADDRCONF(NETDEV_CHANGE): enp30s0: link becomes ready
[  120.293988] PM: suspend entry (deep)
[  120.293992] PM: Syncing filesystems ... done.
[  120.339071] Freezing user space processes ... (elapsed 0.004 seconds) done.
[  120.343645] OOM killer disabled.
[  120.343646] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
[  120.345902] Suspending console(s) (use no_console_suspend to debug)
[  120.347212] sd 1:0:0:0: [sda] Synchronizing SCSI cache
[  120.347417] sd 1:0:0:0: [sda] Stopping disk
[  121.782159] amdgpu 0000:00:01.0: ffff880196bd3b80 unpin not necessary
[  121.797208] PM: suspend devices took 1.452 seconds
[  121.851375] ACPI: Preparing to enter system sleep state S3
[  122.223735] PM: Saving platform NVS memory
[  122.223793] Disabling non-boot CPUs ...
[  122.237542] smpboot: CPU 1 is now offline
[  122.254720] smpboot: CPU 2 is now offline
[  122.267587] smpboot: CPU 3 is now offline
[  122.268865] ACPI: Low-level resume complete
[  122.268979] PM: Restoring platform NVS memory
[  122.269073] LVT offset 0 assigned for vector 0x400
[  122.269750] Enabling non-boot CPUs ...
[  122.270065] x86: Booting SMP configuration:
[  122.270067] smpboot: Booting Node 0 Processor 1 APIC 0x11
[  122.274336]  cache: parent cpu1 should not be sleeping
[  122.275520] microcode: CPU1: patch_level=0x06006118
[  122.279045] CPU1 is up
[  122.279339] smpboot: Booting Node 0 Processor 2 APIC 0x12
[  122.285334]  cache: parent cpu2 should not be sleeping
[  122.286741] microcode: CPU2: patch_level=0x06006118
[  122.291071] CPU2 is up
[  122.291410] smpboot: Booting Node 0 Processor 3 APIC 0x13
[  122.295805]  cache: parent cpu3 should not be sleeping
[  122.297408] microcode: CPU3: patch_level=0x06006118
[  122.302073] CPU3 is up
[  122.303421] ACPI: Waking up from system sleep state S3
[  122.429430] [drm] PCIE GART of 1024M enabled (table at 0x000000F400040000).
[  122.431282] usb usb3: root hub lost power or was reset
[  122.431286] usb usb4: root hub lost power or was reset
[  122.436228] sd 1:0:0:0: [sda] Starting disk
[  122.489507] r8169 0000:1e:00.0 enp30s0: link down
[  122.734275] [drm:hwss_wait_for_blank_complete [amdgpu]] *ERROR* DC: failed to blank crtc!
[  122.739462] ata3: SATA link down (SStatus 0 SControl 300)
[  122.739559] ata1: SATA link down (SStatus 0 SControl 300)
[  122.739582] ata6: SATA link down (SStatus 0 SControl 300)
[  122.739611] ata7: SATA link down (SStatus 0 SControl 300)
[  122.814310] usb 3-10: reset high-speed USB device number 2 using xhci_hcd
[  122.899983] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[  122.911080] ata2.00: configured for UDMA/133
[  123.452408] usb 3-10.4: reset low-speed USB device number 3 using xhci_hcd
[  123.764425] [drm] UVD initialized successfully.
[  123.964728] [drm] VCE initialized successfully.
[  123.980093] [drm] SADs count is: -2, don't need to read it
[  123.980196] [drm] 2228W: [Block 0] 
[  123.980206] [drm] dc_link_detect: manufacturer_id = E305, product_id = 2228, serial_number = 1010101, manufacture_week = 24, manufacture_year = 25, display_name = 2228W, speaker_flag = 0, audio_mode_count = 0
[  124.118262] PM: resume devices took 1.689 seconds
[  124.120710] OOM killer enabled.
[  124.120711] Restarting tasks ... done.
[  124.122337] video LNXVIDEO:02: Restoring backlight state
[  124.125115] PM: suspend exit
[  124.173272] [drm] {1920x1080, 2200x1125@148500Khz}
[  124.222308] IPv6: ADDRCONF(NETDEV_UP): enp30s0: link is not ready
[  124.228392] IPv6: ADDRCONF(NETDEV_UP): enp30s0: link is not ready
[  124.253803] r8169 0000:1e:00.0 enp30s0: link down
[  124.254054] IPv6: ADDRCONF(NETDEV_UP): enp30s0: link is not ready
[  127.343318] r8169 0000:1e:00.0 enp30s0: link up
[  127.343340] IPv6: ADDRCONF(NETDEV_CHANGE): enp30s0: link becomes ready
[  700.375464] kmemleak: 195 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
[ 1350.713261] kmemleak: 76 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
[ 2003.888722] kmemleak: 12 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
[ 2131.430459] perf: interrupt took too long (2553 > 2500), lowering kernel.perf_event_max_sample_rate to 78000
[ 2335.652039] show_signal_msg: 52 callbacks suppressed
[ 2335.652046] glx-visuals-ste[25833]: segfault at 1a ip 00007f1ae647772e sp 00007ffd62e7dc00 error 4 in radeonsi_dri.so[7f1ae6087000+2194000]
[ 2335.736227] glx-visuals-dep[25832]: segfault at 1a ip 00007fdfbbdb772e sp 00007fff8111f2a0 error 4 in radeonsi_dri.so[7fdfbb9c7000+2194000]
[ 2657.453543] kmemleak: 4 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
[ 3313.353058] kmemleak: 5 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
[ 3332.131050] amdgpu 0000:00:01.0: GPU fault detected: 146 0x0a48600c
[ 3332.131059] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x00101949
[ 3332.131064] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x0E06000C
[ 3332.131069] amdgpu 0000:00:01.0: VM fault (0x0c, vmid 7) at page 1055049, read from 'TC0' (0x54433000) (96)
[ 3332.131735] amdgpu 0000:00:01.0: GPU fault detected: 146 0x0a48600c
[ 3332.131742] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x00101949
[ 3332.131746] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x0E06000C
[ 3332.131752] amdgpu 0000:00:01.0: VM fault (0x0c, vmid 7) at page 1055049, read from 'TC0' (0x54433000) (96)
[ 3332.132250] amdgpu 0000:00:01.0: GPU fault detected: 146 0x0a48500c
[ 3332.132257] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x00101949
[ 3332.132261] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x0E05000C
[ 3332.132266] amdgpu 0000:00:01.0: VM fault (0x0c, vmid 7) at page 1055049, read from 'TC1' (0x54433100) (80)
[ 3332.144190] amdgpu 0000:00:01.0: GPU fault detected: 146 0x0a48100c
[ 3332.144200] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x00101949
[ 3332.144205] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x0E01000C
[ 3332.144211] amdgpu 0000:00:01.0: VM fault (0x0c, vmid 7) at page 1055049, read from 'TC3' (0x54433300) (16)
[ 3332.152458] amdgpu 0000:00:01.0: GPU fault detected: 146 0x0c90200c
[ 3332.152467] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x00101992
[ 3332.152471] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x0402000C
[ 3332.152477] amdgpu 0000:00:01.0: VM fault (0x0c, vmid 2) at page 1055122, read from 'TC2' (0x54433200) (32)
[ 3332.153047] amdgpu 0000:00:01.0: GPU fault detected: 146 0x0c90100c
[ 3332.153055] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x00101992
[ 3332.153059] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x0401000C
[ 3332.153064] amdgpu 0000:00:01.0: VM fault (0x0c, vmid 2) at page 1055122, read from 'TC3' (0x54433300) (16)
[ 3332.153999] amdgpu 0000:00:01.0: GPU fault detected: 146 0x0c90600c
[ 3332.154007] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x00101992
[ 3332.154011] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x0406000C
[ 3332.154017] amdgpu 0000:00:01.0: VM fault (0x0c, vmid 2) at page 1055122, read from 'TC0' (0x54433000) (96)
[ 3332.154863] amdgpu 0000:00:01.0: GPU fault detected: 146 0x0c90200c
[ 3332.154871] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x00101992
[ 3332.154876] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x0402000C
[ 3332.154881] amdgpu 0000:00:01.0: VM fault (0x0c, vmid 2) at page 1055122, read from 'TC2' (0x54433200) (32)
[ 3333.038719] amdgpu 0000:00:01.0: GPU fault detected: 146 0x0c18500c
[ 3333.038727] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x00104983
[ 3333.038730] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x0C05000C
[ 3333.038735] amdgpu 0000:00:01.0: VM fault (0x0c, vmid 6) at page 1067395, read from 'TC1' (0x54433100) (80)
[ 3333.045769] amdgpu 0000:00:01.0: GPU fault detected: 146 0x0c18500c
[ 3333.045777] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x00104983
[ 3333.045781] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x0C05000C
[ 3333.045787] amdgpu 0000:00:01.0: VM fault (0x0c, vmid 6) at page 1067395, read from 'TC1' (0x54433100) (80)
[ 3337.179566] gmc_v8_0_process_interrupt: 1359 callbacks suppressed
[ 3337.179574] amdgpu 0000:00:01.0: GPU fault detected: 146 0x08c0600c
[ 3337.179580] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x00101318
[ 3337.179585] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x0206000C
[ 3337.179590] amdgpu 0000:00:01.0: VM fault (0x0c, vmid 1) at page 1053464, read from 'TC0' (0x54433000) (96)
[ 3337.180557] amdgpu 0000:00:01.0: GPU fault detected: 146 0x08c0500c
[ 3337.180567] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x00101318
[ 3337.180571] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x0205000C
[ 3337.180578] amdgpu 0000:00:01.0: VM fault (0x0c, vmid 1) at page 1053464, read from 'TC1' (0x54433100) (80)
[ 3337.187569] amdgpu 0000:00:01.0: GPU fault detected: 146 0x08c0600c
[ 3337.187578] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x00101318
[ 3337.187582] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x0206000C
[ 3337.187588] amdgpu 0000:00:01.0: VM fault (0x0c, vmid 1) at page 1053464, read from 'TC0' (0x54433000) (96)
[ 3337.188370] amdgpu 0000:00:01.0: GPU fault detected: 146 0x08c0600c
[ 3337.188377] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x00101318
[ 3337.188381] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x0206000C
[ 3337.188386] amdgpu 0000:00:01.0: VM fault (0x0c, vmid 1) at page 1053464, read from 'TC0' (0x54433000) (96)
[ 3337.189266] amdgpu 0000:00:01.0: GPU fault detected: 146 0x08c0100c
[ 3337.189274] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x00101318
[ 3337.189277] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x0201000C
[ 3337.189283] amdgpu 0000:00:01.0: VM fault (0x0c, vmid 1) at page 1053464, read from 'TC3' (0x54433300) (16)
[ 3337.190261] amdgpu 0000:00:01.0: GPU fault detected: 146 0x08c0600c
[ 3337.190269] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x00101318
[ 3337.190272] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x0206000C
[ 3337.190277] amdgpu 0000:00:01.0: VM fault (0x0c, vmid 1) at page 1053464, read from 'TC0' (0x54433000) (96)
[ 3337.191065] amdgpu 0000:00:01.0: GPU fault detected: 146 0x08c8100c
[ 3337.191072] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x00101319
[ 3337.191076] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x0201000C
[ 3337.191081] amdgpu 0000:00:01.0: VM fault (0x0c, vmid 1) at page 1053465, read from 'TC3' (0x54433300) (16)
[ 3337.193049] amdgpu 0000:00:01.0: GPU fault detected: 146 0x08c8600c
[ 3337.193057] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x00101319
[ 3337.193060] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x0206000C
[ 3337.193065] amdgpu 0000:00:01.0: VM fault (0x0c, vmid 1) at page 1053465, read from 'TC0' (0x54433000) (96)
[ 3337.193725] amdgpu 0000:00:01.0: GPU fault detected: 146 0x08c8600c
[ 3337.193733] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x00101319
[ 3337.193737] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x0206000C
[ 3337.193742] amdgpu 0000:00:01.0: VM fault (0x0c, vmid 1) at page 1053465, read from 'TC0' (0x54433000) (96)
[ 3337.195466] amdgpu 0000:00:01.0: GPU fault detected: 146 0x08c8600c
[ 3337.195474] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x00101319
[ 3337.195478] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x0206000C
[ 3337.195483] amdgpu 0000:00:01.0: VM fault (0x0c, vmid 1) at page 1053465, read from 'TC0' (0x54433000) (96)
[ 3342.298347] gmc_v8_0_process_interrupt: 1026 callbacks suppressed
[ 3342.298356] amdgpu 0000:00:01.0: GPU fault detected: 146 0x08c0500c
[ 3342.298364] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x00101318
[ 3342.298369] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x0405000C
[ 3342.298376] amdgpu 0000:00:01.0: VM fault (0x0c, vmid 2) at page 1053464, read from 'TC1' (0x54433100) (80)
[ 3342.298784] amdgpu 0000:00:01.0: GPU fault detected: 146 0x08c0600c
[ 3342.298790] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x00101318
[ 3342.298794] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x0406000C
[ 3342.298800] amdgpu 0000:00:01.0: VM fault (0x0c, vmid 2) at page 1053464, read from 'TC0' (0x54433000) (96)
[ 3342.299189] amdgpu 0000:00:01.0: GPU fault detected: 146 0x08c0500c
[ 3342.299196] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x00101318
[ 3342.299200] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x0405000C
[ 3342.299207] amdgpu 0000:00:01.0: VM fault (0x0c, vmid 2) at page 1053464, read from 'TC1' (0x54433100) (80)
[ 3342.304936] amdgpu 0000:00:01.0: GPU fault detected: 146 0x08c0200c
[ 3342.304948] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x00101318
[ 3342.304953] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x0402000C
[ 3342.304960] amdgpu 0000:00:01.0: VM fault (0x0c, vmid 2) at page 1053464, read from 'TC2' (0x54433200) (32)
[ 3342.306904] amdgpu 0000:00:01.0: GPU fault detected: 146 0x08c0600c
[ 3342.306912] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x00101318
[ 3342.306916] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x0406000C
[ 3342.306921] amdgpu 0000:00:01.0: VM fault (0x0c, vmid 2) at page 1053464, read from 'TC0' (0x54433000) (96)
[ 3342.308586] amdgpu 0000:00:01.0: GPU fault detected: 146 0x08c0100c
[ 3342.308595] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x00101318
[ 3342.308598] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x0401000C
[ 3342.308604] amdgpu 0000:00:01.0: VM fault (0x0c, vmid 2) at page 1053464, read from 'TC3' (0x54433300) (16)
[ 3342.309072] amdgpu 0000:00:01.0: GPU fault detected: 146 0x08c8200c
[ 3342.309078] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x00101319
[ 3342.309082] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x0402000C
[ 3342.309087] amdgpu 0000:00:01.0: VM fault (0x0c, vmid 2) at page 1053465, read from 'TC2' (0x54433200) (32)
[ 3342.310100] amdgpu 0000:00:01.0: GPU fault detected: 146 0x08c8500c
[ 3342.310108] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x00101319
[ 3342.310112] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x0405000C
[ 3342.310117] amdgpu 0000:00:01.0: VM fault (0x0c, vmid 2) at page 1053465, read from 'TC1' (0x54433100) (80)
[ 3342.312266] amdgpu 0000:00:01.0: GPU fault detected: 146 0x08c8200c
[ 3342.312274] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x00101319
[ 3342.312278] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x0402000C
[ 3342.312283] amdgpu 0000:00:01.0: VM fault (0x0c, vmid 2) at page 1053465, read from 'TC2' (0x54433200) (32)
[ 3342.312768] amdgpu 0000:00:01.0: GPU fault detected: 146 0x08c8600c
[ 3342.312775] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x00101319
[ 3342.312779] amdgpu 0000:00:01.0:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x0406000C
[ 3342.312784] amdgpu 0000:00:01.0: VM fault (0x0c, vmid 2) at page 1053465, read from 'TC0' (0x54433000) (96)
[ 3406.851256] amdgpu 0000:00:01.0: Disabling VM faults because of PRT request!
[ 3568.637479] PM: suspend entry (deep)
[ 3568.637482] PM: Syncing filesystems ... done.
[ 3568.672096] Freezing user space processes ... (elapsed 0.004 seconds) done.
[ 3568.676390] OOM killer disabled.
[ 3568.676392] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
[ 3568.678573] Suspending console(s) (use no_console_suspend to debug)
[ 3568.679574] sd 1:0:0:0: [sda] Synchronizing SCSI cache
[ 3568.679726] sd 1:0:0:0: [sda] Stopping disk
[ 3569.075096] kworker/u32:14: page allocation failure: order:10, mode:0x1404000(GFP_NOIO|__GFP_COMP), nodemask=(null)
[ 3569.075106] kworker/u32:14 cpuset=/ mems_allowed=0
[ 3569.075115] CPU: 2 PID: 17097 Comm: kworker/u32:14 Tainted: G    B           4.14.0-rc3+ #21
[ 3569.075116] Hardware name: System manufacturer System Product Name/TUF B350M-PLUS GAMING, BIOS 0902 09/08/2017
[ 3569.075125] Workqueue: events_unbound async_run_entry_fn
[ 3569.075127] Call Trace:
[ 3569.075136]  dump_stack+0xb8/0x133
[ 3569.075139]  ? _atomic_dec_and_lock+0x16d/0x16d
[ 3569.075145]  warn_alloc+0x1d1/0x2a0
[ 3569.075149]  ? zone_watermark_ok_safe+0x260/0x260
[ 3569.075152]  ? unreserve_highatomic_pageblock+0x2c2/0x370
[ 3569.075155]  ? drain_all_pages+0x9b/0x390
[ 3569.075160]  __alloc_pages_slowpath+0x1a7f/0x1ad0
[ 3569.075166]  ? detach_if_pending+0x15d/0x280
[ 3569.075169]  ? warn_alloc+0x2a0/0x2a0
[ 3569.075172]  ? __lock_text_start+0x8/0x8
[ 3569.075188]  ? ttm_bo_handle_move_mem+0x31e/0xac0 [ttm]
[ 3569.075191]  ? del_timer+0xa8/0xe0
[ 3569.075193]  ? lock_timer_base+0x1a0/0x1a0
[ 3569.075198]  ? get_work_pool+0x79/0xf0
[ 3569.075201]  ? try_to_grab_pending+0x4cf/0x500
[ 3569.075204]  ? flush_work+0xd2/0x490
[ 3569.075208]  ? __queue_delayed_work+0x230/0x230
[ 3569.075212]  ? __list_add_valid+0x2f/0xa0
[ 3569.075223]  ? ttm_bo_add_to_lru+0x369/0x390 [ttm]
[ 3569.075226]  ? __lock_text_start+0x8/0x8
[ 3569.075231]  ? dma_fence_default_wait+0x222/0x700
[ 3569.075234]  ? dma_fence_get_status+0xb0/0xb0
[ 3569.075236]  ? dma_fence_release+0x200/0x200
[ 3569.075247]  ? ttm_mem_evict_first+0x535/0x540 [ttm]
[ 3569.075251]  __alloc_pages_nodemask+0x5ee/0x610
[ 3569.075254]  ? __alloc_pages_slowpath+0x1ad0/0x1ad0
[ 3569.075258]  ? enqueue_entity+0x11f0/0x11f0
[ 3569.075262]  ? update_stack_state+0x2fa/0x3e0
[ 3569.075265]  ? dma_fence_context_alloc+0x20/0x20
[ 3569.075276]  ? ttm_bo_del_from_lru+0x28e/0x430 [ttm]
[ 3569.075287]  ? ttm_bo_release_list+0x480/0x480 [ttm]
[ 3569.075291]  alloc_pages_current+0x75/0x110
[ 3569.075295]  kmalloc_order+0x24/0x80
[ 3569.075298]  kmalloc_order_trace+0x24/0xb0
[ 3569.075302]  __kmalloc+0x240/0x260
[ 3569.075450]  amdgpu_uvd_suspend+0x204/0x250 [amdgpu]
[ 3569.075581]  ? amdgpu_uvd_sw_fini+0xa0/0xa0 [amdgpu]
[ 3569.075714]  uvd_v6_0_suspend+0x1e/0x30 [amdgpu]
[ 3569.075828]  amdgpu_suspend+0x9f/0x240 [amdgpu]
[ 3569.075840]  ? ttm_bo_evict_mm+0x42/0x70 [ttm]
[ 3569.075954]  amdgpu_device_suspend+0x434/0x740 [amdgpu]
[ 3569.076069]  ? amdgpu_device_fini+0x320/0x320 [amdgpu]
[ 3569.076071]  ? klist_prev+0x250/0x250
[ 3569.076075]  ? __pm_runtime_barrier+0x10b/0x380
[ 3569.076078]  ? __lock_text_start+0x8/0x8
[ 3569.076193]  ? amdgpu_pmops_freeze+0x30/0x30 [amdgpu]
[ 3569.076306]  amdgpu_pmops_suspend+0x2f/0x40 [amdgpu]
[ 3569.076309]  pci_pm_suspend+0xf4/0x1f0
[ 3569.076312]  ? pci_pm_freeze+0x160/0x160
[ 3569.076315]  dpm_run_callback+0xdb/0x2f0
[ 3569.076318]  ? initcall_debug_report.isra.8+0x80/0x80
[ 3569.076322]  ? resched_curr+0xe6/0x1b0
[ 3569.076324]  ? wake_q_add+0x60/0x60
[ 3569.076327]  ? select_idle_sibling+0x870/0x870
[ 3569.076329]  ? __lock_text_start+0x8/0x8
[ 3569.076333]  __device_suspend+0x27d/0x7d0
[ 3569.076336]  ? __lock_text_start+0x8/0x8
[ 3569.076339]  ? legacy_suspend+0x2e0/0x2e0
[ 3569.076341]  ? check_preempt_curr+0x120/0x120
[ 3569.076348]  ? try_to_wake_up+0x120/0x9e0
[ 3569.076352]  ? migrate_swap_stop+0x550/0x550
[ 3569.076355]  async_suspend+0x1f/0xb0
[ 3569.076358]  async_run_entry_fn+0x112/0x520
[ 3569.076361]  ? __device_suspend+0x7d0/0x7d0
[ 3569.076363]  ? async_schedule_domain+0x10/0x10
[ 3569.076366]  ? __list_add_valid+0x2f/0xa0
[ 3569.076369]  ? worker_enter_idle+0x328/0x3f0
[ 3569.076372]  ? workqueue_congested+0x110/0x200
[ 3569.076375]  ? alloc_worker+0x17d/0x1e0
[ 3569.076377]  ? set_user_nice+0x91/0x500
[ 3569.076380]  ? __list_add_valid+0x2f/0xa0
[ 3569.076384]  process_one_work+0x669/0xaa0
[ 3569.076388]  ? pwq_dec_nr_in_flight+0x200/0x200
[ 3569.076391]  ? del_timer+0xe0/0xe0
[ 3569.076395]  ? del_timer_sync+0x42/0x50
[ 3569.076397]  ? maybe_create_worker+0x3ea/0x400
[ 3569.076401]  ? create_worker+0x350/0x350
[ 3569.076404]  ? resched_curr+0xe6/0x1b0
[ 3569.076407]  ? wake_q_add+0x60/0x60
[ 3569.076409]  ? pick_next_task_fair+0x4db/0xb50
[ 3569.076412]  ? select_idle_sibling+0x870/0x870
[ 3569.076415]  ? _find_next_bit+0x35/0xb0
[ 3569.076418]  ? find_next_bit+0xb/0x10
[ 3569.076420]  ? idle_cpu+0x63/0x90
[ 3569.076423]  ? __update_idle_core+0x1cf/0x2e0
[ 3569.076426]  ? __asan_storeN+0x12/0x20
[ 3569.076429]  ? mutex_trylock+0x93/0x130
[ 3569.076431]  ? ww_mutex_unlock+0x60/0x60
[ 3569.076434]  ? finish_task_switch+0x17f/0x4e0
[ 3569.076437]  worker_thread+0x19d/0xb10
[ 3569.076442]  ? process_one_work+0xaa0/0xaa0
[ 3569.076444]  ? __schedule+0x489/0xf40
[ 3569.076447]  ? memcmp+0x4d/0x80
[ 3569.076450]  ? __sched_text_start+0x8/0x8
[ 3569.076453]  ? save_stack+0xa3/0xd0
[ 3569.076456]  ? save_stack_trace+0x1b/0x20
[ 3569.076459]  ? save_stack+0x43/0xd0
[ 3569.076461]  ? kasan_kmalloc+0xad/0xe0
[ 3569.076463]  ? kmem_cache_alloc_trace+0xf7/0x210
[ 3569.076466]  ? kthread+0x63/0x1e0
[ 3569.076468]  ? ret_from_fork+0x25/0x30
[ 3569.076473]  ? create_object+0x54c/0x640
[ 3569.076476]  ? start_scan_thread+0x70/0x70
[ 3569.076480]  ? schedule+0xd8/0x2a0
[ 3569.076482]  ? __schedule+0xf40/0xf40
[ 3569.076485]  ? do_wait_intr_irq+0x2a0/0x2a0
[ 3569.076488]  ? memcg_kmem_put_cache+0x75/0x140
[ 3569.076490]  ? __lock_text_start+0x8/0x8
[ 3569.076493]  ? __init_waitqueue_head+0x70/0xe0
[ 3569.076495]  ? print_dl_stats+0x50/0x50
[ 3569.076497]  ? kthread+0x63/0x1e0
[ 3569.076500]  kthread+0x1b7/0x1e0
[ 3569.076503]  ? process_one_work+0xaa0/0xaa0
[ 3569.076506]  ? kthread_park+0xa0/0xa0
[ 3569.076508]  ret_from_fork+0x25/0x30
[ 3569.076529] Mem-Info:
[ 3569.076539] active_anon:110062 inactive_anon:36388 isolated_anon:0
                active_file:250936 inactive_file:356949 isolated_file:0
                unevictable:0 dirty:5 writeback:0 unstable:0
                slab_reclaimable:142285 slab_unreclaimable:233290
                mapped:73723 shmem:776 pagetables:10820 bounce:0
                free:362214 free_pcp:1342 free_cma:0
[ 3569.076545] Node 0 active_anon:440248kB inactive_anon:145552kB active_file:1003744kB inactive_file:1427796kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:294892kB dirty:20kB writeback:0kB shmem:3104kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB unstable:0kB all_unreclaimable? no
[ 3569.076546] Node 0 DMA free:15900kB min:164kB low:204kB high:244kB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15984kB managed:15900kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[ 3569.076552] lowmem_reserve[]: 0 3335 6331 6331 6331
[ 3569.076556] Node 0 DMA32 free:700816kB min:35508kB low:44384kB high:53260kB active_anon:87800kB inactive_anon:904kB active_file:577336kB inactive_file:1123424kB unevictable:0kB writepending:0kB present:3606064kB managed:3563860kB mlocked:0kB kernel_stack:96kB pagetables:276kB bounce:0kB free_pcp:2788kB local_pcp:708kB free_cma:0kB
[ 3569.076561] lowmem_reserve[]: 0 0 2996 2996 2996
[ 3569.076565] Node 0 Normal free:732140kB min:31904kB low:39880kB high:47856kB active_anon:352588kB inactive_anon:144360kB active_file:426632kB inactive_file:600436kB unevictable:0kB writepending:0kB present:4177920kB managed:3068788kB mlocked:0kB kernel_stack:17440kB pagetables:43004kB bounce:0kB free_pcp:2580kB local_pcp:736kB free_cma:0kB
[ 3569.076571] lowmem_reserve[]: 0 0 0 0 0
[ 3569.076574] Node 0 DMA: 1*4kB (U) 1*8kB (U) 1*16kB (U) 0*32kB 2*64kB (U) 1*128kB (U) 1*256kB (U) 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15900kB
[ 3569.076589] Node 0 DMA32: 24158*4kB (UME) 8850*8kB (UME) 3710*16kB (UME) 3305*32kB (UME) 1247*64kB (UME) 702*128kB (UME) 368*256kB (UME) 147*512kB (UME) 29*1024kB (M) 0*2048kB 0*4096kB = 701384kB
[ 3569.076603] Node 0 Normal: 274*4kB (MEH) 8332*8kB (MEH) 6916*16kB (UMEH) 4684*32kB (UMEH) 2580*64kB (UMEH) 1112*128kB (UMEH) 295*256kB (UMEH) 39*512kB (UM) 1*1024kB (M) 0*2048kB 0*4096kB = 732264kB
[ 3569.076619] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
[ 3569.076620] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
[ 3569.076621] 608678 total pagecache pages
[ 3569.076625] 0 pages in swap cache
[ 3569.076626] Swap cache stats: add 1, delete 1, find 0/0
[ 3569.076627] Free swap  = 7826172kB
[ 3569.076628] Total swap = 7826428kB
[ 3569.076629] 1949992 pages RAM
[ 3569.076630] 0 pages HighMem/MovableOnly
[ 3569.076630] 287855 pages reserved
[ 3569.076631] 0 pages cma reserved
[ 3569.076632] 0 pages hwpoisoned
[ 3569.076759] [drm:amdgpu_suspend [amdgpu]] *ERROR* suspend of IP block <uvd_v6_0> failed -12
[ 3569.078009] amdgpu 0000:00:01.0: ffff8801a455ee80 unpin not necessary
[ 3569.094123] PM: suspend devices took 0.416 seconds
[ 3569.147140] ACPI: Preparing to enter system sleep state S3
[ 3569.508979] PM: Saving platform NVS memory
[ 3569.509046] Disabling non-boot CPUs ...
[ 3569.524430] smpboot: CPU 1 is now offline
[ 3569.539381] smpboot: CPU 2 is now offline
[ 3569.549497] smpboot: CPU 3 is now offline
[ 3569.551025] ACPI: Low-level resume complete
[ 3569.551144] PM: Restoring platform NVS memory
[ 3569.551246] LVT offset 0 assigned for vector 0x400
[ 3569.551562] Enabling non-boot CPUs ...
[ 3569.551900] x86: Booting SMP configuration:
[ 3569.551901] smpboot: Booting Node 0 Processor 1 APIC 0x11
[ 3569.556199]  cache: parent cpu1 should not be sleeping
[ 3569.557519] microcode: CPU1: patch_level=0x06006118
[ 3569.561106] CPU1 is up
[ 3569.561411] smpboot: Booting Node 0 Processor 2 APIC 0x12
[ 3569.566088]  cache: parent cpu2 should not be sleeping
[ 3569.567484] microcode: CPU2: patch_level=0x06006118
[ 3569.571845] CPU2 is up
[ 3569.572206] smpboot: Booting Node 0 Processor 3 APIC 0x13
[ 3569.577083]  cache: parent cpu3 should not be sleeping
[ 3569.578381] microcode: CPU3: patch_level=0x06006118
[ 3569.582978] CPU3 is up
[ 3569.584333] ACPI: Waking up from system sleep state S3
[ 3569.710535] [drm] PCIE GART of 1024M enabled (table at 0x000000F400040000).
[ 3569.922775] usb usb3: root hub lost power or was reset
[ 3569.922778] usb usb4: root hub lost power or was reset
[ 3569.923835] sd 1:0:0:0: [sda] Starting disk
[ 3569.980873] r8169 0000:1e:00.0 enp30s0: link down
[ 3570.226174] [drm:hwss_wait_for_blank_complete [amdgpu]] *ERROR* DC: failed to blank crtc!
[ 3570.229021] ata6: SATA link down (SStatus 0 SControl 300)
[ 3570.229350] ata7: SATA link down (SStatus 0 SControl 300)
[ 3570.237580] ata1: SATA link down (SStatus 0 SControl 300)
[ 3570.283625] ata3: SATA link down (SStatus 0 SControl 300)
[ 3570.311155] usb 3-10: reset high-speed USB device number 2 using xhci_hcd
[ 3570.436741] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[ 3570.447868] ata2.00: configured for UDMA/133
[ 3570.949056] usb 3-10.4: reset low-speed USB device number 3 using xhci_hcd
[ 3571.256035] [drm] UVD initialized successfully.
[ 3571.457315] [drm] VCE initialized successfully.
[ 3571.472745] [drm] SADs count is: -2, don't need to read it
[ 3571.472886] [drm] 2228W: [Block 0] 
[ 3571.472896] [drm] dc_link_detect: manufacturer_id = E305, product_id = 2228, serial_number = 1010101, manufacture_week = 24, manufacture_year = 25, display_name = 2228W, speaker_flag = 0, audio_mode_count = 0
[ 3571.607665] PM: resume devices took 1.897 seconds
[ 3571.610023] OOM killer enabled.
[ 3571.610025] Restarting tasks ... done.
[ 3571.613436] video LNXVIDEO:02: Restoring backlight state
[ 3571.624543] PM: suspend exit
[ 3571.686091] IPv6: ADDRCONF(NETDEV_UP): enp30s0: link is not ready
[ 3571.701583] IPv6: ADDRCONF(NETDEV_UP): enp30s0: link is not ready
[ 3571.708710] [drm] {1920x1080, 2200x1125@148500Khz}
[ 3571.726000] r8169 0000:1e:00.0 enp30s0: link down
[ 3571.726378] IPv6: ADDRCONF(NETDEV_UP): enp30s0: link is not ready
[ 3574.848626] r8169 0000:1e:00.0 enp30s0: link up
[ 3574.848652] IPv6: ADDRCONF(NETDEV_CHANGE): enp30s0: link becomes ready

--------------ED486B5870649532215BCF76
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------ED486B5870649532215BCF76--
