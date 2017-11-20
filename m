From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: regression in suspend/resume on Polaris
Date: Mon, 20 Nov 2017 08:18:03 -0500
Message-ID: <abd84787-4ba4-0a98-d17e-86a1e1467d8c@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------16F13365AFCD139AAE50E061"
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
Cc: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Liu,
 Monk" <monk.liu-5C7GfCeVMHo@public.gmane.org>

--------------16F13365AFCD139AAE50E061
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

This commit causes a failure (attached) on resume with a Polaris10 
device installed (during uvd video playback).

commit 1cfd8e237f0318e330190ac21d63c58ae6a1f66c (HEAD, refs/bisect/bad)
Author: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Date:   Tue Nov 14 11:52:35 2017 +0800

     drm/amdgpu:cleanup GMC & gart garbage function

     for gart_ram_alloc/free, they are never used in driver thus
     ripe them out totally.

     for gart_vram_pin/unpin, they are not needed becuase we can
     use bo_creat_kernel/free to replace the original manual way
     in the gart_vram_alloc/free, thus gart_vram_pin/unpin can
     also be riped out.

     Change-Id: Ic60949b59d8b363e5199f6c11d9ea4a15ec57519
     Signed-off-by: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
     Reviewed-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>

Cheers,
Tom

--------------16F13365AFCD139AAE50E061
Content-Type: text/x-log;
 name="polaris_failed_resume.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="polaris_failed_resume.log"

[    0.000000] Linux version 4.14.0-rc3+ (root@fx6) (gcc version 7.2.1 20170915 (Red Hat 7.2.1-2) (GCC)) #9 SMP Mon Nov 20 07:40:49 EST 2017
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-4.14.0-rc3+ root=UUID=f9bdf62c-2ae6-4e5b-82ec-3d5521299090 ro rhgb quiet LANG=en_CA.UTF-8 rdblacklist=amdgpu
[    0.000000] random: get_random_u32 called from bsp_init_amd+0x1d3/0x220 with crng_init=0
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009e7ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009e800-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000ba8ebfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000ba8ec000-0x00000000baa6ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000baa70000-0x00000000baa7ffff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000baa80000-0x00000000bb880fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000bb881000-0x00000000bca36fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000bca37000-0x00000000bca37fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bca38000-0x00000000bcc3dfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000bcc3e000-0x00000000bd082fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bd083000-0x00000000bd7f3fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000bd7f4000-0x00000000bd7fffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec10000-0x00000000fec10fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec20000-0x00000000fec20fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed61000-0x00000000fed70fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed8ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fef00000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100001000-0x000000023effffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] random: fast init done
[    0.000000] SMBIOS 2.7 present.
[    0.000000] DMI: To be filled by O.E.M. To be filled by O.E.M./M5A97 LE R2.0, BIOS 2501 04/09/2014
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x23f000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF write-through
[    0.000000]   C0000-CEFFF write-protect
[    0.000000]   CF000-EBFFF uncachable
[    0.000000]   EC000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000000 mask FFFF80000000 write-back
[    0.000000]   1 base 000080000000 mask FFFFC0000000 write-back
[    0.000000]   2 base 0000BD800000 mask FFFFFF800000 uncachable
[    0.000000]   3 base 0000BE000000 mask FFFFFE000000 uncachable
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] TOM2: 000000023f000000 aka 9200M
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000000] e820: update [mem 0xbd800000-0xffffffff] usable ==> reserved
[    0.000000] e820: last_pfn = 0xbd800 max_arch_pfn = 0x400000000
[    0.000000] Base memory trampoline at [ffff9f1a40098000] 98000 size 24576
[    0.000000] Using GB pages for direct mapping
[    0.000000] BRK [0x4d521000, 0x4d521fff] PGTABLE
[    0.000000] BRK [0x4d522000, 0x4d522fff] PGTABLE
[    0.000000] BRK [0x4d523000, 0x4d523fff] PGTABLE
[    0.000000] BRK [0x4d524000, 0x4d524fff] PGTABLE
[    0.000000] BRK [0x4d525000, 0x4d525fff] PGTABLE
[    0.000000] BRK [0x4d526000, 0x4d526fff] PGTABLE
[    0.000000] BRK [0x4d527000, 0x4d527fff] PGTABLE
[    0.000000] BRK [0x4d528000, 0x4d528fff] PGTABLE
[    0.000000] BRK [0x4d529000, 0x4d529fff] PGTABLE
[    0.000000] BRK [0x4d52a000, 0x4d52afff] PGTABLE
[    0.000000] BRK [0x4d52b000, 0x4d52bfff] PGTABLE
[    0.000000] RAMDISK: [mem 0x2e8e1000-0x33468fff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F0490 000024 (v02 ALASKA)
[    0.000000] ACPI: XSDT 0x00000000BAA77070 00005C (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FACP 0x00000000BAA7DEB8 00010C (v05 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI BIOS Warning (bug): Optional FADT field Pm2ControlBlock has valid Length but zero Address: 0x0000000000000000/0x1 (20170728/tbfadt-658)
[    0.000000] ACPI: DSDT 0x00000000BAA77168 006D50 (v02 ALASKA A M I    00000000 INTL 20051117)
[    0.000000] ACPI: FACS 0x00000000BB87BF80 000040
[    0.000000] ACPI: APIC 0x00000000BAA7DFC8 00008E (v03 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FPDT 0x00000000BAA7E058 000044 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: MCFG 0x00000000BAA7E0A0 00003C (v01 ALASKA A M I    01072009 MSFT 00010013)
[    0.000000] ACPI: HPET 0x00000000BAA7E0E0 000038 (v01 ALASKA A M I    01072009 AMI  00000005)
[    0.000000] ACPI: IVRS 0x00000000BAA7F2C8 0000C0 (v01 AMD    RD890S   00202031 AMD  00000000)
[    0.000000] ACPI: SSDT 0x00000000BAA7E170 001158 (v01 AMD    POWERNOW 00000001 AMD  00000001)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000023effffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x23efd3000-0x23effdfff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000023effffff]
[    0.000000]   Device   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009dfff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x00000000ba8ebfff]
[    0.000000]   node   0: [mem 0x00000000bca37000-0x00000000bca37fff]
[    0.000000]   node   0: [mem 0x00000000bcc3e000-0x00000000bd082fff]
[    0.000000]   node   0: [mem 0x00000000bd7f4000-0x00000000bd7fffff]
[    0.000000]   node   0: [mem 0x0000000100001000-0x000000023effffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000023effffff]
[    0.000000] On node 0 totalpages: 2071770
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 21 pages reserved
[    0.000000]   DMA zone: 3997 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 11893 pages used for memmap
[    0.000000]   DMA32 zone: 761150 pages, LIFO batch:31
[    0.000000]   Normal zone: 20416 pages used for memmap
[    0.000000]   Normal zone: 1306623 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 7, version 33, address 0xfec00000, GSI 0-23
[    0.000000] IOAPIC[1]: apic_id 8, version 33, address 0xfec20000, GSI 24-55
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x43538210 base: 0xfed00000
[    0.000000] smpboot: Allowing 6 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009e000-0x0009efff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000dffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000e0000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xba8ec000-0xbaa6ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xbaa70000-0xbaa7ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xbaa80000-0xbb880fff]
[    0.000000] PM: Registered nosave memory: [mem 0xbb881000-0xbca36fff]
[    0.000000] PM: Registered nosave memory: [mem 0xbca38000-0xbcc3dfff]
[    0.000000] PM: Registered nosave memory: [mem 0xbd083000-0xbd7f3fff]
[    0.000000] PM: Registered nosave memory: [mem 0xbd800000-0xfebfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec01000-0xfec0ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec10000-0xfec10fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec11000-0xfec1ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec20000-0xfec20fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec21000-0xfecfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed00000-0xfed00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed01000-0xfed60fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed61000-0xfed70fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed71000-0xfed7ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed80000-0xfed8ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed90000-0xfeefffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfef00000-0xffffffff]
[    0.000000] PM: Registered nosave memory: [mem 0x100000000-0x100000fff]
[    0.000000] e820: [mem 0xbd800000-0xfebfffff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.000000] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:6 nr_cpu_ids:6 nr_node_ids:1
[    0.000000] percpu: Embedded 37 pages/cpu @ffff9f1c7ec00000 s111832 r8192 d31528 u262144
[    0.000000] pcpu-alloc: s111832 r8192 d31528 u262144 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 4 5 - - 
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 2039376
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-4.14.0-rc3+ root=UUID=f9bdf62c-2ae6-4e5b-82ec-3d5521299090 ro rhgb quiet LANG=en_CA.UTF-8 rdblacklist=amdgpu
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Memory: 7989808K/8287080K available (8855K kernel code, 2332K rwdata, 3804K rodata, 2856K init, 1968K bss, 297272K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=6, Nodes=1
[    0.000000] ftrace: allocating 35162 entries in 138 pages
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=6.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=6
[    0.000000] NR_IRQS: 524544, nr_irqs: 1016, preallocated irqs: 16
[    0.000000] 	Offload RCU callbacks from CPUs: .
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.001000] tsc: Detected 3511.515 MHz processor
[    0.001000] Calibrating delay loop (skipped), value calculated using timer frequency.. 7023.03 BogoMIPS (lpj=3511515)
[    0.001000] pid_max: default: 32768 minimum: 301
[    0.001000] ACPI: Core revision 20170728
[    0.017769] ACPI: 2 ACPI AML tables successfully acquired and loaded
[    0.017889] Security Framework initialized
[    0.017890] Yama: becoming mindful.
[    0.017898] SELinux:  Initializing.
[    0.017928] SELinux:  Starting in permissive mode
[    0.019991] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.021033] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.021102] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.021138] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.021584] CPU: Physical Processor ID: 0
[    0.021585] CPU: Processor Core ID: 0
[    0.021586] mce: CPU supports 7 MCE banks
[    0.021595] LVT offset 1 assigned for vector 0xf9
[    0.021599] Last level iTLB entries: 4KB 512, 2MB 1024, 4MB 512
[    0.021600] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 512, 1GB 0
[    0.021882] Freeing SMP alternatives memory: 36K
[    0.024130] smpboot: Max logical packages: 1
[    0.025448] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.036000] smpboot: CPU0: AMD FX(tm)-6300 Six-Core Processor (family: 0x15, model: 0x2, stepping: 0x0)
[    0.036000] Performance Events: Fam15h core perfctr, AMD PMU driver.
[    0.036000] ... version:                0
[    0.036000] ... bit width:              48
[    0.036000] ... generic registers:      6
[    0.036000] ... value mask:             0000ffffffffffff
[    0.036000] ... max period:             00007fffffffffff
[    0.036000] ... fixed-purpose events:   0
[    0.036000] ... event mask:             000000000000003f
[    0.036000] Hierarchical SRCU implementation.
[    0.036000] smp: Bringing up secondary CPUs ...
[    0.036037] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
[    0.036121] x86: Booting SMP configuration:
[    0.036122] .... node  #0, CPUs:      #1 #2 #3 #4 #5
[    0.353028] smp: Brought up 1 node, 6 CPUs
[    0.353028] smpboot: Total of 6 processors activated (42135.02 BogoMIPS)
[    0.355131] devtmpfs: initialized
[    0.355131] x86/mm: Memory block size: 128MB
[    0.357265] PM: Registering ACPI NVS region [mem 0xbaa80000-0xbb880fff] (14684160 bytes)
[    0.359564] PM: Registering ACPI NVS region [mem 0xbca38000-0xbcc3dfff] (2121728 bytes)
[    0.359993] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.360012] futex hash table entries: 2048 (order: 5, 131072 bytes)
[    0.360174] pinctrl core: initialized pinctrl subsystem
[    0.360257] RTC time: 13:15:17, date: 11/20/17
[    0.360453] NET: Registered protocol family 16
[    0.360865] cpuidle: using governor menu
[    0.361095] ACPI: bus type PCI registered
[    0.361096] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.361244] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.361247] PCI: not using MMCONFIG
[    0.361248] PCI: Using configuration type 1 for base access
[    0.361248] PCI: Using configuration type 1 for extended access
[    0.365522] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.365522] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.366161] ACPI: Added _OSI(Module Device)
[    0.366162] ACPI: Added _OSI(Processor Device)
[    0.366162] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.366163] ACPI: Added _OSI(Processor Aggregator Device)
[    0.366555] ACPI: Executed 2 blocks of module-level executable AML code
[    0.383530] ACPI: EC: EC started
[    0.383531] ACPI: EC: interrupt blocked
[    0.383540] ACPI: \_SB_.PCI0.SBRG.EC0_: Used as first EC
[    0.383542] ACPI: \_SB_.PCI0.SBRG.EC0_: GPE=0xa, EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.383545] ACPI: \_SB_.PCI0.SBRG.EC0_: Used as boot DSDT EC to handle transactions
[    0.383545] ACPI: Interpreter enabled
[    0.383573] ACPI: (supports S0 S3 S4 S5)
[    0.383574] ACPI: Using IOAPIC for interrupt routing
[    0.383962] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.384085] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in ACPI motherboard resources
[    0.384099] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.384799] ACPI: Enabled 10 GPEs in block 00 to 1F
[    0.407866] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.407873] acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.407886] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.409106] PCI host bridge to bus 0000:00
[    0.409109] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    0.409111] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    0.409114] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
[    0.409116] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.409118] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.409120] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff window]
[    0.409122] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xffffffff window]
[    0.409124] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.409138] pci 0000:00:00.0: [1002:5a14] type 00 class 0x060000
[    0.409422] pci 0000:00:00.2: [1002:5a23] type 00 class 0x080600
[    0.409698] pci 0000:00:02.0: [1002:5a16] type 01 class 0x060400
[    0.409723] pci 0000:00:02.0: enabling Extended Tags
[    0.409757] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
[    0.409997] pci 0000:00:04.0: [1002:5a18] type 01 class 0x060400
[    0.410024] pci 0000:00:04.0: enabling Extended Tags
[    0.410064] pci 0000:00:04.0: PME# supported from D0 D3hot D3cold
[    0.410310] pci 0000:00:07.0: [1002:5a1b] type 01 class 0x060400
[    0.410335] pci 0000:00:07.0: enabling Extended Tags
[    0.410368] pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
[    0.410619] pci 0000:00:11.0: [1002:4391] type 00 class 0x010601
[    0.410638] pci 0000:00:11.0: reg 0x10: [io  0xf040-0xf047]
[    0.410646] pci 0000:00:11.0: reg 0x14: [io  0xf030-0xf033]
[    0.410655] pci 0000:00:11.0: reg 0x18: [io  0xf020-0xf027]
[    0.410663] pci 0000:00:11.0: reg 0x1c: [io  0xf010-0xf013]
[    0.410671] pci 0000:00:11.0: reg 0x20: [io  0xf000-0xf00f]
[    0.410679] pci 0000:00:11.0: reg 0x24: [mem 0xfeb0b000-0xfeb0b3ff]
[    0.410935] pci 0000:00:12.0: [1002:4397] type 00 class 0x0c0310
[    0.410952] pci 0000:00:12.0: reg 0x10: [mem 0xfeb0a000-0xfeb0afff]
[    0.411249] pci 0000:00:12.2: [1002:4396] type 00 class 0x0c0320
[    0.411268] pci 0000:00:12.2: reg 0x10: [mem 0xfeb09000-0xfeb090ff]
[    0.411347] pci 0000:00:12.2: supports D1 D2
[    0.411348] pci 0000:00:12.2: PME# supported from D0 D1 D2 D3hot
[    0.411581] pci 0000:00:13.0: [1002:4397] type 00 class 0x0c0310
[    0.411597] pci 0000:00:13.0: reg 0x10: [mem 0xfeb08000-0xfeb08fff]
[    0.411883] pci 0000:00:13.2: [1002:4396] type 00 class 0x0c0320
[    0.411902] pci 0000:00:13.2: reg 0x10: [mem 0xfeb07000-0xfeb070ff]
[    0.411981] pci 0000:00:13.2: supports D1 D2
[    0.411982] pci 0000:00:13.2: PME# supported from D0 D1 D2 D3hot
[    0.412225] pci 0000:00:14.0: [1002:4385] type 00 class 0x0c0500
[    0.412510] pci 0000:00:14.2: [1002:4383] type 00 class 0x040300
[    0.412532] pci 0000:00:14.2: reg 0x10: [mem 0xfeb00000-0xfeb03fff 64bit]
[    0.412598] pci 0000:00:14.2: PME# supported from D0 D3hot D3cold
[    0.412820] pci 0000:00:14.3: [1002:439d] type 00 class 0x060100
[    0.413120] pci 0000:00:14.4: [1002:4384] type 01 class 0x060401
[    0.413383] pci 0000:00:14.5: [1002:4399] type 00 class 0x0c0310
[    0.413399] pci 0000:00:14.5: reg 0x10: [mem 0xfeb06000-0xfeb06fff]
[    0.413682] pci 0000:00:16.0: [1002:4397] type 00 class 0x0c0310
[    0.413698] pci 0000:00:16.0: reg 0x10: [mem 0xfeb05000-0xfeb05fff]
[    0.413980] pci 0000:00:16.2: [1002:4396] type 00 class 0x0c0320
[    0.414002] pci 0000:00:16.2: reg 0x10: [mem 0xfeb04000-0xfeb040ff]
[    0.414082] pci 0000:00:16.2: supports D1 D2
[    0.414083] pci 0000:00:16.2: PME# supported from D0 D1 D2 D3hot
[    0.414312] pci 0000:00:18.0: [1022:1600] type 00 class 0x060000
[    0.414531] pci 0000:00:18.1: [1022:1601] type 00 class 0x060000
[    0.414766] pci 0000:00:18.2: [1022:1602] type 00 class 0x060000
[    0.414962] pci 0000:00:18.3: [1022:1603] type 00 class 0x060000
[    0.415174] pci 0000:00:18.4: [1022:1604] type 00 class 0x060000
[    0.415370] pci 0000:00:18.5: [1022:1605] type 00 class 0x060000
[    0.415627] pci 0000:01:00.0: [1002:67c4] type 00 class 0x030000
[    0.415653] pci 0000:01:00.0: reg 0x10: [mem 0xc0000000-0xcfffffff 64bit pref]
[    0.415693] pci 0000:01:00.0: reg 0x18: [mem 0xd0000000-0xd01fffff 64bit pref]
[    0.415701] pci 0000:01:00.0: reg 0x20: [io  0xe000-0xe0ff]
[    0.415708] pci 0000:01:00.0: reg 0x24: [mem 0xfea00000-0xfea3ffff]
[    0.415716] pci 0000:01:00.0: reg 0x30: [mem 0xfea40000-0xfea5ffff pref]
[    0.415722] pci 0000:01:00.0: enabling Extended Tags
[    0.415789] pci 0000:01:00.0: supports D1 D2
[    0.415790] pci 0000:01:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.415908] pci 0000:01:00.1: [1002:aaf0] type 00 class 0x040300
[    0.415931] pci 0000:01:00.1: reg 0x10: [mem 0xfea60000-0xfea63fff 64bit]
[    0.415968] pci 0000:01:00.1: enabling Extended Tags
[    0.416024] pci 0000:01:00.1: supports D1 D2
[    0.419035] pci 0000:00:02.0: PCI bridge to [bus 01]
[    0.419038] pci 0000:00:02.0:   bridge window [io  0xe000-0xefff]
[    0.419041] pci 0000:00:02.0:   bridge window [mem 0xfea00000-0xfeafffff]
[    0.419044] pci 0000:00:02.0:   bridge window [mem 0xc0000000-0xd01fffff 64bit pref]
[    0.419098] pci 0000:00:04.0: PCI bridge to [bus 02]
[    0.419169] pci 0000:03:00.0: [1b21:1142] type 00 class 0x0c0330
[    0.419197] pci 0000:03:00.0: reg 0x10: [mem 0xfe900000-0xfe907fff 64bit]
[    0.419341] pci 0000:03:00.0: PME# supported from D3cold
[    0.422014] pci 0000:00:07.0: PCI bridge to [bus 03]
[    0.422019] pci 0000:00:07.0:   bridge window [mem 0xfe900000-0xfe9fffff]
[    0.422117] pci 0000:00:14.4: PCI bridge to [bus 04] (subtractive decode)
[    0.422126] pci 0000:00:14.4:   bridge window [io  0x0000-0x03af window] (subtractive decode)
[    0.422128] pci 0000:00:14.4:   bridge window [io  0x03e0-0x0cf7 window] (subtractive decode)
[    0.422130] pci 0000:00:14.4:   bridge window [io  0x03b0-0x03df window] (subtractive decode)
[    0.422132] pci 0000:00:14.4:   bridge window [io  0x0d00-0xffff window] (subtractive decode)
[    0.422134] pci 0000:00:14.4:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
[    0.422136] pci 0000:00:14.4:   bridge window [mem 0x000c0000-0x000dffff window] (subtractive decode)
[    0.422138] pci 0000:00:14.4:   bridge window [mem 0xc0000000-0xffffffff window] (subtractive decode)
[    0.423117] ACPI: PCI Interrupt Link [LNKA] (IRQs 4 7 10 11 14 15) *0
[    0.423312] ACPI: PCI Interrupt Link [LNKB] (IRQs 4 7 10 11 14 15) *0
[    0.423514] ACPI: PCI Interrupt Link [LNKC] (IRQs 4 7 10 11 14 15) *0
[    0.423714] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 10 11 14 15) *0
[    0.423884] ACPI: PCI Interrupt Link [LNKE] (IRQs 4 7 10 11 14 15) *0
[    0.424025] ACPI: PCI Interrupt Link [LNKF] (IRQs 4 7 10 11 14 15) *0
[    0.424164] ACPI: PCI Interrupt Link [LNKG] (IRQs 4 7 10 11 14 15) *0
[    0.424318] ACPI: PCI Interrupt Link [LNKH] (IRQs 4 7 10 11 14 15) *0
[    0.424628] ACPI: EC: interrupt unblocked
[    0.424633] ACPI: EC: event unblocked
[    0.424639] ACPI: \_SB_.PCI0.SBRG.EC0_: GPE=0xa, EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.424642] ACPI: \_SB_.PCI0.SBRG.EC0_: Used as boot DSDT EC to handle transactions and events
[    0.424757] pci 0000:01:00.0: vgaarb: setting as boot VGA device
[    0.424757] pci 0000:01:00.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.424757] pci 0000:01:00.0: vgaarb: bridge control possible
[    0.424757] vgaarb: loaded
[    0.425102] SCSI subsystem initialized
[    0.425124] libata version 3.00 loaded.
[    0.425124] ACPI: bus type USB registered
[    0.425124] usbcore: registered new interface driver usbfs
[    0.425124] usbcore: registered new interface driver hub
[    0.425155] usbcore: registered new device driver usb
[    0.425230] EDAC MC: Ver: 3.0.0
[    0.425230] PCI: Using ACPI for IRQ routing
[    0.433858] PCI: pci_cache_line_size set to 64 bytes
[    0.433909] e820: reserve RAM buffer [mem 0x0009e800-0x0009ffff]
[    0.433911] e820: reserve RAM buffer [mem 0xba8ec000-0xbbffffff]
[    0.433913] e820: reserve RAM buffer [mem 0xbca38000-0xbfffffff]
[    0.433914] e820: reserve RAM buffer [mem 0xbd083000-0xbfffffff]
[    0.433916] e820: reserve RAM buffer [mem 0xbd800000-0xbfffffff]
[    0.433918] e820: reserve RAM buffer [mem 0x23f000000-0x23fffffff]
[    0.434106] NetLabel: Initializing
[    0.434106] NetLabel:  domain hash size = 128
[    0.434107] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.434137] NetLabel:  unlabeled traffic allowed by default
[    0.434160] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.434160] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.437040] clocksource: Switched to clocksource hpet
[    0.475434] VFS: Disk quotas dquot_6.6.0
[    0.475496] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.475676] pnp: PnP ACPI init
[    0.475944] system 00:00: [mem 0xe0000000-0xefffffff] has been reserved
[    0.475953] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.476752] system 00:01: [io  0x040b] has been reserved
[    0.476756] system 00:01: [io  0x04d6] has been reserved
[    0.476758] system 00:01: [io  0x0c00-0x0c01] has been reserved
[    0.476761] system 00:01: [io  0x0c14] has been reserved
[    0.476764] system 00:01: [io  0x0c50-0x0c51] has been reserved
[    0.476767] system 00:01: [io  0x0c52] has been reserved
[    0.476769] system 00:01: [io  0x0c6c] has been reserved
[    0.476774] system 00:01: [io  0x0c6f] has been reserved
[    0.476776] system 00:01: [io  0x0cd0-0x0cd1] has been reserved
[    0.476779] system 00:01: [io  0x0cd2-0x0cd3] has been reserved
[    0.476782] system 00:01: [io  0x0cd4-0x0cd5] has been reserved
[    0.476785] system 00:01: [io  0x0cd6-0x0cd7] has been reserved
[    0.476788] system 00:01: [io  0x0cd8-0x0cdf] has been reserved
[    0.476791] system 00:01: [io  0x0800-0x089f] has been reserved
[    0.476794] system 00:01: [io  0x0b20-0x0b3f] has been reserved
[    0.476797] system 00:01: [io  0x0900-0x090f] has been reserved
[    0.476799] system 00:01: [io  0x0910-0x091f] has been reserved
[    0.476802] system 00:01: [io  0xfe00-0xfefe] has been reserved
[    0.476806] system 00:01: [mem 0xfec00000-0xfec00fff] could not be reserved
[    0.476809] system 00:01: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.476813] system 00:01: [mem 0xfed80000-0xfed8ffff] has been reserved
[    0.476816] system 00:01: [mem 0xfed61000-0xfed70fff] has been reserved
[    0.476819] system 00:01: [mem 0xfec10000-0xfec10fff] has been reserved
[    0.476823] system 00:01: [mem 0xfed00000-0xfed00fff] could not be reserved
[    0.476826] system 00:01: [mem 0xff800000-0xffffffff] has been reserved
[    0.476831] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.477224] system 00:02: [io  0x0290-0x02af] has been reserved
[    0.477229] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.477295] pnp 00:03: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.477425] system 00:04: [io  0x04d0-0x04d1] has been reserved
[    0.477430] system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.477523] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.478074] pnp 00:06: [dma 0 disabled]
[    0.478152] pnp 00:06: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.478516] system 00:07: [mem 0xfeb20000-0xfeb23fff] could not be reserved
[    0.478522] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.478834] system 00:08: [mem 0xfec20000-0xfec200ff] could not be reserved
[    0.478839] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.479232] pnp: PnP ACPI: found 9 devices
[    0.487293] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.487477] pci 0000:00:02.0: PCI bridge to [bus 01]
[    0.487479] pci 0000:00:02.0:   bridge window [io  0xe000-0xefff]
[    0.487482] pci 0000:00:02.0:   bridge window [mem 0xfea00000-0xfeafffff]
[    0.487484] pci 0000:00:02.0:   bridge window [mem 0xc0000000-0xd01fffff 64bit pref]
[    0.487487] pci 0000:00:04.0: PCI bridge to [bus 02]
[    0.487493] pci 0000:00:07.0: PCI bridge to [bus 03]
[    0.487496] pci 0000:00:07.0:   bridge window [mem 0xfe900000-0xfe9fffff]
[    0.487501] pci 0000:00:14.4: PCI bridge to [bus 04]
[    0.487511] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    0.487513] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
[    0.487514] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
[    0.487515] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    0.487516] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff window]
[    0.487517] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff window]
[    0.487518] pci_bus 0000:00: resource 10 [mem 0xc0000000-0xffffffff window]
[    0.487519] pci_bus 0000:01: resource 0 [io  0xe000-0xefff]
[    0.487520] pci_bus 0000:01: resource 1 [mem 0xfea00000-0xfeafffff]
[    0.487521] pci_bus 0000:01: resource 2 [mem 0xc0000000-0xd01fffff 64bit pref]
[    0.487523] pci_bus 0000:03: resource 1 [mem 0xfe900000-0xfe9fffff]
[    0.487524] pci_bus 0000:04: resource 4 [io  0x0000-0x03af window]
[    0.487525] pci_bus 0000:04: resource 5 [io  0x03e0-0x0cf7 window]
[    0.487526] pci_bus 0000:04: resource 6 [io  0x03b0-0x03df window]
[    0.487527] pci_bus 0000:04: resource 7 [io  0x0d00-0xffff window]
[    0.487528] pci_bus 0000:04: resource 8 [mem 0x000a0000-0x000bffff window]
[    0.487529] pci_bus 0000:04: resource 9 [mem 0x000c0000-0x000dffff window]
[    0.487530] pci_bus 0000:04: resource 10 [mem 0xc0000000-0xffffffff window]
[    0.487698] NET: Registered protocol family 2
[    0.488030] TCP established hash table entries: 65536 (order: 7, 524288 bytes)
[    0.488157] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.488377] TCP: Hash tables configured (established 65536 bind 65536)
[    0.488467] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[    0.488506] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[    0.488664] NET: Registered protocol family 1
[    0.757641] pci 0000:01:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.758036] PCI: CLS 64 bytes, default 64
[    0.758106] Unpacking initramfs...
[    1.948259] Freeing initrd memory: 77344K
[    1.949355] iommu: Adding device 0000:00:00.0 to group 0
[    1.949559] iommu: Adding device 0000:00:02.0 to group 1
[    1.949748] iommu: Adding device 0000:00:04.0 to group 2
[    1.949945] iommu: Adding device 0000:00:07.0 to group 3
[    1.950148] iommu: Adding device 0000:00:11.0 to group 4
[    1.950358] iommu: Adding device 0000:00:12.0 to group 5
[    1.950378] iommu: Adding device 0000:00:12.2 to group 5
[    1.950580] iommu: Adding device 0000:00:13.0 to group 6
[    1.950601] iommu: Adding device 0000:00:13.2 to group 6
[    1.950801] iommu: Adding device 0000:00:14.0 to group 7
[    1.951008] iommu: Adding device 0000:00:14.2 to group 8
[    1.951196] iommu: Adding device 0000:00:14.3 to group 9
[    1.951394] iommu: Adding device 0000:00:14.4 to group 10
[    1.951587] iommu: Adding device 0000:00:14.5 to group 11
[    1.951797] iommu: Adding device 0000:00:16.0 to group 12
[    1.951819] iommu: Adding device 0000:00:16.2 to group 12
[    1.952053] iommu: Adding device 0000:01:00.0 to group 13
[    1.952090] iommu: Adding device 0000:01:00.1 to group 13
[    1.952293] iommu: Adding device 0000:03:00.0 to group 14
[    1.992624] AMD-Vi: Found IOMMU at 0000:00:00.2 cap 0x40
[    1.992624] AMD-Vi: Interrupt remapping enabled
[    1.992773] AMD-Vi: Lazy IO/TLB flushing enabled
[    1.994557] amd_uncore: AMD NB counters detected
[    1.994701] LVT offset 0 assigned for vector 0x400
[    1.994785] perf: AMD IBS detected (0x000000ff)
[    1.996377] audit: initializing netlink subsys (disabled)
[    1.996461] audit: type=2000 audit(1511183717.995:1): state=initialized audit_enabled=0 res=1
[    1.996959] Initialise system trusted keyrings
[    1.996975] Key type blacklist registered
[    1.997049] workingset: timestamp_bits=36 max_order=21 bucket_order=0
[    2.000586] zbud: loaded
[    2.001721] SELinux:  Registering netfilter hooks
[    2.183478] NET: Registered protocol family 38
[    2.183484] Key type asymmetric registered
[    2.183485] Asymmetric key parser 'x509' registered
[    2.183576] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 248)
[    2.183641] io scheduler noop registered
[    2.183642] io scheduler deadline registered
[    2.183769] io scheduler cfq registered (default)
[    2.183770] io scheduler mq-deadline registered
[    2.183863] atomic64_test: passed for x86-64 platform with CX8 and with SSE
[    2.184847] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    2.184879] ACPI: Power Button [PWRB]
[    2.184979] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    2.185018] ACPI: Power Button [PWRF]
[    2.186332] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    2.206924] 00:06: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    2.211219] Non-volatile memory driver v1.3
[    2.211266] Linux agpgart interface v0.103
[    2.212799] ahci 0000:00:11.0: version 3.0
[    2.213101] ahci 0000:00:11.0: AHCI 0001.0200 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
[    2.213103] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part 
[    2.213439] scsi host0: ahci
[    2.213531] ata1: SATA max UDMA/133 abar m1024@0xfeb0b000 port 0xfeb0b100 irq 19
[    2.213686] libphy: Fixed MDIO Bus: probed
[    2.213775] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.213781] ehci-pci: EHCI PCI platform driver
[    2.214043] QUIRK: Enable AMD PLL fix
[    2.214059] ehci-pci 0000:00:12.2: EHCI Host Controller
[    2.214135] ehci-pci 0000:00:12.2: new USB bus registered, assigned bus number 1
[    2.214140] ehci-pci 0000:00:12.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    2.214148] ehci-pci 0000:00:12.2: debug port 1
[    2.214198] ehci-pci 0000:00:12.2: irq 17, io mem 0xfeb09000
[    2.221103] ehci-pci 0000:00:12.2: USB 2.0 started, EHCI 1.00
[    2.221323] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    2.221324] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.221325] usb usb1: Product: EHCI Host Controller
[    2.221326] usb usb1: Manufacturer: Linux 4.14.0-rc3+ ehci_hcd
[    2.221327] usb usb1: SerialNumber: 0000:00:12.2
[    2.221566] hub 1-0:1.0: USB hub found
[    2.221577] hub 1-0:1.0: 5 ports detected
[    2.222183] ehci-pci 0000:00:13.2: EHCI Host Controller
[    2.222259] ehci-pci 0000:00:13.2: new USB bus registered, assigned bus number 2
[    2.222264] ehci-pci 0000:00:13.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    2.222272] ehci-pci 0000:00:13.2: debug port 1
[    2.222324] ehci-pci 0000:00:13.2: irq 21, io mem 0xfeb07000
[    2.229101] ehci-pci 0000:00:13.2: USB 2.0 started, EHCI 1.00
[    2.229304] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[    2.229305] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.229306] usb usb2: Product: EHCI Host Controller
[    2.229307] usb usb2: Manufacturer: Linux 4.14.0-rc3+ ehci_hcd
[    2.229308] usb usb2: SerialNumber: 0000:00:13.2
[    2.229493] hub 2-0:1.0: USB hub found
[    2.229504] hub 2-0:1.0: 5 ports detected
[    2.230045] ehci-pci 0000:00:16.2: EHCI Host Controller
[    2.230119] ehci-pci 0000:00:16.2: new USB bus registered, assigned bus number 3
[    2.230123] ehci-pci 0000:00:16.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    2.230130] ehci-pci 0000:00:16.2: debug port 1
[    2.230181] ehci-pci 0000:00:16.2: irq 23, io mem 0xfeb04000
[    2.237104] ehci-pci 0000:00:16.2: USB 2.0 started, EHCI 1.00
[    2.237325] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
[    2.237326] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.237327] usb usb3: Product: EHCI Host Controller
[    2.237328] usb usb3: Manufacturer: Linux 4.14.0-rc3+ ehci_hcd
[    2.237328] usb usb3: SerialNumber: 0000:00:16.2
[    2.237506] hub 3-0:1.0: USB hub found
[    2.237517] hub 3-0:1.0: 4 ports detected
[    2.237821] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    2.237828] ohci-pci: OHCI PCI platform driver
[    2.238098] ohci-pci 0000:00:12.0: OHCI PCI host controller
[    2.238172] ohci-pci 0000:00:12.0: new USB bus registered, assigned bus number 4
[    2.238217] ohci-pci 0000:00:12.0: irq 18, io mem 0xfeb0a000
[    2.294197] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
[    2.294198] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.294199] usb usb4: Product: OHCI PCI host controller
[    2.294200] usb usb4: Manufacturer: Linux 4.14.0-rc3+ ohci_hcd
[    2.294201] usb usb4: SerialNumber: 0000:00:12.0
[    2.294425] hub 4-0:1.0: USB hub found
[    2.294438] hub 4-0:1.0: 5 ports detected
[    2.295012] ohci-pci 0000:00:13.0: OHCI PCI host controller
[    2.295091] ohci-pci 0000:00:13.0: new USB bus registered, assigned bus number 5
[    2.295140] ohci-pci 0000:00:13.0: irq 20, io mem 0xfeb08000
[    2.351203] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
[    2.351204] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.351205] usb usb5: Product: OHCI PCI host controller
[    2.351206] usb usb5: Manufacturer: Linux 4.14.0-rc3+ ohci_hcd
[    2.351207] usb usb5: SerialNumber: 0000:00:13.0
[    2.351473] hub 5-0:1.0: USB hub found
[    2.351486] hub 5-0:1.0: 5 ports detected
[    2.351946] ohci-pci 0000:00:14.5: OHCI PCI host controller
[    2.352096] ohci-pci 0000:00:14.5: new USB bus registered, assigned bus number 6
[    2.352127] ohci-pci 0000:00:14.5: irq 18, io mem 0xfeb06000
[    2.408184] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
[    2.408186] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.408187] usb usb6: Product: OHCI PCI host controller
[    2.408188] usb usb6: Manufacturer: Linux 4.14.0-rc3+ ohci_hcd
[    2.408189] usb usb6: SerialNumber: 0000:00:14.5
[    2.408415] hub 6-0:1.0: USB hub found
[    2.408427] hub 6-0:1.0: 2 ports detected
[    2.408917] ohci-pci 0000:00:16.0: OHCI PCI host controller
[    2.408989] ohci-pci 0000:00:16.0: new USB bus registered, assigned bus number 7
[    2.409043] ohci-pci 0000:00:16.0: irq 22, io mem 0xfeb05000
[    2.465184] usb usb7: New USB device found, idVendor=1d6b, idProduct=0001
[    2.465186] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.465187] usb usb7: Product: OHCI PCI host controller
[    2.465188] usb usb7: Manufacturer: Linux 4.14.0-rc3+ ohci_hcd
[    2.465188] usb usb7: SerialNumber: 0000:00:16.0
[    2.465454] hub 7-0:1.0: USB hub found
[    2.465467] hub 7-0:1.0: 4 ports detected
[    2.465693] uhci_hcd: USB Universal Host Controller Interface driver
[    2.465899] xhci_hcd 0000:03:00.0: xHCI Host Controller
[    2.466048] xhci_hcd 0000:03:00.0: new USB bus registered, assigned bus number 8
[    2.526527] xhci_hcd 0000:03:00.0: hcc params 0x0200e081 hci version 0x100 quirks 0x10000410
[    2.526967] usb usb8: New USB device found, idVendor=1d6b, idProduct=0002
[    2.526968] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.526969] usb usb8: Product: xHCI Host Controller
[    2.526970] usb usb8: Manufacturer: Linux 4.14.0-rc3+ xhci-hcd
[    2.526971] usb usb8: SerialNumber: 0000:03:00.0
[    2.527208] hub 8-0:1.0: USB hub found
[    2.527221] hub 8-0:1.0: 2 ports detected
[    2.527366] xhci_hcd 0000:03:00.0: xHCI Host Controller
[    2.527433] xhci_hcd 0000:03:00.0: new USB bus registered, assigned bus number 9
[    2.527484] usb usb9: We don't know the algorithms for LPM for this host, disabling LPM.
[    2.527537] usb usb9: New USB device found, idVendor=1d6b, idProduct=0003
[    2.527538] usb usb9: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.527539] usb usb9: Product: xHCI Host Controller
[    2.527539] usb usb9: Manufacturer: Linux 4.14.0-rc3+ xhci-hcd
[    2.527540] usb usb9: SerialNumber: 0000:03:00.0
[    2.527700] hub 9-0:1.0: USB hub found
[    2.527711] hub 9-0:1.0: 2 ports detected
[    2.527983] usbcore: registered new interface driver usbserial
[    2.527999] usbcore: registered new interface driver usbserial_generic
[    2.528022] usbserial: USB Serial support registered for generic
[    2.528060] i8042: PNP: No PS/2 controller found.
[    2.528130] mousedev: PS/2 mouse device common for all mice
[    2.528320] rtc_cmos 00:03: RTC can wake from S4
[    2.528456] rtc_cmos 00:03: rtc core: registered rtc_cmos as rtc0
[    2.528483] rtc_cmos 00:03: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    2.528525] IR NEC protocol handler initialized
[    2.528526] IR RC5(x/sz) protocol handler initialized
[    2.528527] IR RC6 protocol handler initialized
[    2.528527] IR JVC protocol handler initialized
[    2.528527] IR Sony protocol handler initialized
[    2.528528] IR SANYO protocol handler initialized
[    2.528528] IR Sharp protocol handler initialized
[    2.528529] IR MCE Keyboard/mouse protocol handler initialized
[    2.528529] IR XMP protocol handler initialized
[    2.528621] device-mapper: uevent: version 1.0.3
[    2.528759] device-mapper: ioctl: 4.36.0-ioctl (2017-06-09) initialised: dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
[    2.529572] hidraw: raw HID events driver (C) Jiri Kosina
[    2.529643] usbcore: registered new interface driver usbhid
[    2.529643] usbhid: USB HID core driver
[    2.529808] drop_monitor: Initializing network drop monitor service
[    2.529899] ip_tables: (C) 2000-2006 Netfilter Core Team
[    2.530031] Initializing XFRM netlink socket
[    2.530362] NET: Registered protocol family 10
[    2.533208] Segment Routing with IPv6
[    2.533233] mip6: Mobile IPv6
[    2.533234] NET: Registered protocol family 17
[    2.533796] RAS: Correctable Errors collector initialized.
[    2.534154] microcode: microcode updated early to new patch_level=0x0600084f
[    2.534191] microcode: CPU0: patch_level=0x0600084f
[    2.534202] microcode: CPU1: patch_level=0x0600084f
[    2.534210] microcode: CPU2: patch_level=0x0600084f
[    2.534220] microcode: CPU3: patch_level=0x0600084f
[    2.534229] microcode: CPU4: patch_level=0x0600084f
[    2.534238] microcode: CPU5: patch_level=0x0600084f
[    2.534291] microcode: Microcode Update Driver: v2.2.
[    2.534307] AVX version of gcm_enc/dec engaged.
[    2.534307] AES CTR mode by8 optimization enabled
[    2.545801] sched_clock: Marking stable (2545790711, 0)->(2843169962, -297379251)
[    2.546253] registered taskstats version 1
[    2.546272] Loading compiled-in X.509 certificates
[    2.586669] usb 1-3: new high-speed USB device number 2 using ehci-pci
[    2.587846] Loaded X.509 cert 'Build time autogenerated kernel key: 187414dc182ed9acbf477f543c12accda7b0e056'
[    2.587895] zswap: loaded using pool lzo/zbud
[    2.588168] kmemleak: Kernel memory leak detector initialized
[    2.588172] kmemleak: Automatic memory scanning thread started
[    2.592314] Key type big_key registered
[    2.594233] Key type encrypted registered
[    2.594762]   Magic number: 9:631:281
[    2.594806] tty tty18: hash matches
[    2.594875] rtc_cmos 00:03: setting system clock to 2017-11-20 13:15:19 UTC (1511183719)
[    2.672120] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    2.679197] ata1.00: ATA-8: KINGSTON SV300S37A120G, 608ABBF0, max UDMA/133
[    2.679201] ata1.00: 234441648 sectors, multi 1: LBA48 NCQ (depth 31/32), AA
[    2.685972] ata1.00: configured for UDMA/133
[    2.686631] scsi 0:0:0:0: Direct-Access     ATA      KINGSTON SV300S3 BBF0 PQ: 0 ANSI: 5
[    2.687030] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    2.687089] sd 0:0:0:0: [sda] 234441648 512-byte logical blocks: (120 GB/112 GiB)
[    2.687116] sd 0:0:0:0: [sda] Write Protect is off
[    2.687118] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.687161] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.688000]  sda: sda1 sda2 sda3
[    2.688645] sd 0:0:0:0: [sda] Attached SCSI disk
[    2.691936] Freeing unused kernel memory: 2856K
[    2.691937] Write protecting the kernel read-only data: 14336k
[    2.692498] Freeing unused kernel memory: 1372K
[    2.693115] Freeing unused kernel memory: 292K
[    2.700162] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    2.700166] rodata_test: all tests were successful
[    2.716100] systemd[1]: systemd 233 running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN default-hierarchy=hybrid)
[    2.716353] systemd[1]: Detected architecture x86-64.
[    2.716357] systemd[1]: Running in initial RAM disk.
[    2.716375] systemd[1]: Set hostname to <fx6>.
[    2.717161] usb 1-3: New USB device found, idVendor=0bda, idProduct=8152
[    2.717163] usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    2.717164] usb 1-3: Product: USB 10/100 LAN
[    2.717165] usb 1-3: Manufacturer: CMI
[    2.717166] usb 1-3: SerialNumber: 70886B8245CF
[    2.768183] systemd[1]: /run/systemd/generator/dev-disk-by\x2duuid-f9bdf62c\x2d2ae6\x2d4e5b\x2d82ec\x2d3d5521299090.device.d/timeout.conf:3: Unknown lvalue 'JobRunningTimeoutSec' in section 'Unit'
[    2.769225] systemd[1]: Reached target Swap.
[    2.769331] systemd[1]: Listening on udev Control Socket.
[    2.770268] systemd[1]: Created slice System Slice.
[    2.770352] systemd[1]: Listening on Journal Socket.
[    2.771499] systemd[1]: Starting Create list of required static device nodes for the current kernel...
[    2.792742] audit: type=1130 audit(1511183719.696:2): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-tmpfiles-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    2.796492] audit: type=1130 audit(1511183719.700:3): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-tmpfiles-setup-dev comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    2.834036] usb 1-4: new high-speed USB device number 3 using ehci-pci
[    2.862925] audit: type=1130 audit(1511183719.766:4): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-journald comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    2.863525] audit: type=1130 audit(1511183719.767:5): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-cmdline comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    2.899495] audit: type=1130 audit(1511183719.803:6): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-pre-udev comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    2.906744] audit: type=1130 audit(1511183719.810:7): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-vconsole-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    2.906771] audit: type=1131 audit(1511183719.810:8): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-vconsole-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    2.907547] audit: type=1130 audit(1511183719.811:9): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-udevd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    2.964157] usb 1-4: New USB device found, idVendor=0409, idProduct=005a
[    2.964159] usb 1-4: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.964487] hub 1-4:1.0: USB hub found
[    2.964645] hub 1-4:1.0: 4 ports detected
[    3.025714] audit: type=1130 audit(1511183719.929:10): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-udev-trigger comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    3.040043] tsc: Refined TSC clocksource calibration: 3511.722 MHz
[    3.040055] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x329e927a702, max_idle_ns: 440795370237 ns
[    3.052890] usbcore: registered new interface driver r8152
[    3.170117] usb 1-3: reset high-speed USB device number 2 using ehci-pci
[    3.258463] EXT4-fs (sda3): mounted filesystem with ordered data mode. Opts: (null)
[    3.352100] r8152 1-3:1.0 eth0: v1.09.9
[    3.353495] r8152 1-3:1.0 enp0s18f2u3: renamed from eth0
[    3.376110] usb 1-4.4: new low-speed USB device number 4 using ehci-pci
[    3.543327] usb 1-4.4: New USB device found, idVendor=046d, idProduct=c31c
[    3.543329] usb 1-4.4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.543331] usb 1-4.4: Product: USB Keyboard
[    3.543331] usb 1-4.4: Manufacturer: Logitech
[    3.594386] input: Logitech USB Keyboard as /devices/pci0000:00/0000:00:12.2/usb1/1-4/1-4.4/1-4.4:1.0/0003:046D:C31C.0001/input/input2
[    3.646497] hid-generic 0003:046D:C31C.0001: input,hidraw0: USB HID v1.10 Keyboard [Logitech USB Keyboard] on usb-0000:00:12.2-4.4/input0
[    3.647864] systemd-journald[213]: Received SIGTERM from PID 1 (systemd).
[    3.688976] systemd: 18 output lines suppressed due to ratelimiting
[    3.721469] input: Logitech USB Keyboard as /devices/pci0000:00/0000:00:12.2/usb1/1-4/1-4.4/1-4.4:1.1/0003:046D:C31C.0002/input/input3
[    3.749522] SELinux:  Disabled at runtime.
[    3.749541] SELinux:  Unregistering netfilter hooks
[    3.773426] hid-generic 0003:046D:C31C.0002: input,hidraw1: USB HID v1.10 Device [Logitech USB Keyboard] on usb-0000:00:12.2-4.4/input1
[    3.795973] input: Logitech USB Keyboard as /devices/pci0000:00/0000:00:12.2/usb1/1-4/1-4.4/1-4.4:1.2/0003:046D:C31C.0003/input/input4
[    3.796306] hid-generic 0003:046D:C31C.0003: input,hidraw2: USB HID v1.10 Mouse [Logitech USB Keyboard] on usb-0000:00:12.2-4.4/input2
[    3.985429] EXT4-fs (sda3): re-mounted. Opts: (null)
[    4.021441] systemd-journald[465]: Received request to flush runtime journal from PID 1
[    4.048141] clocksource: Switched to clocksource tsc
[    4.236873] acpi_cpufreq: overriding BIOS provided _PSD data
[    4.290479] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, revision 0
[    4.290486] piix4_smbus 0000:00:14.0: Using register 0x2c for SMBus port selection
[    4.290792] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Controller at 0xb20
[    4.309044] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    4.356073] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver v0.05
[    4.356249] sp5100_tco: PCI Vendor ID: 0x1002, Device ID: 0x4385, Revision ID: 0x42
[    4.356259] sp5100_tco: I/O address 0x0cd6 already in use
[    4.429346] Adding 8270844k swap on /dev/sda2.  Priority:-2 extents:1 across:8270844k SSFS
[    4.629307] asus_wmi: ASUS WMI generic driver loaded
[    4.645884] asus_wmi: Initialization: 0x0
[    4.646040] asus_wmi: BIOS WMI version: 0.9
[    4.646386] asus_wmi: SFUN value: 0x0
[    4.651327] input: Eee PC WMI hotkeys as /devices/platform/eeepc-wmi/input/input5
[    4.653741] asus_wmi: Number of fans: 1
[    4.685371] snd_hda_intel 0000:01:00.1: Handle vga_switcheroo audio client
[    4.685373] snd_hda_intel 0000:01:00.1: Force to non-snoop mode
[    4.685572] kvm: Nested Virtualization enabled
[    4.685608] kvm: Nested Paging enabled
[    4.722422] input: HDA ATI HDMI HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:02.0/0000:01:00.1/sound/card1/input6
[    4.722626] input: HDA ATI HDMI HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:02.0/0000:01:00.1/sound/card1/input7
[    4.722964] input: HDA ATI HDMI HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:02.0/0000:01:00.1/sound/card1/input8
[    4.724297] input: HDA ATI HDMI HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:02.0/0000:01:00.1/sound/card1/input9
[    4.725270] input: HDA ATI HDMI HDMI/DP,pcm=10 as /devices/pci0000:00/0000:00:02.0/0000:01:00.1/sound/card1/input10
[    4.725553] input: HDA ATI HDMI HDMI/DP,pcm=11 as /devices/pci0000:00/0000:00:02.0/0000:01:00.1/sound/card1/input11
[    4.726883] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC887-VD: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:line
[    4.726890] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    4.726891] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
[    4.726893] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
[    4.726894] snd_hda_codec_realtek hdaudioC0D0:    dig-out=0x11/0x0
[    4.726895] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[    4.726897] snd_hda_codec_realtek hdaudioC0D0:      Front Mic=0x19
[    4.726899] snd_hda_codec_realtek hdaudioC0D0:      Rear Mic=0x18
[    4.726900] snd_hda_codec_realtek hdaudioC0D0:      Line=0x1a
[    4.747804] input: HDA ATI SB Front Mic as /devices/pci0000:00/0000:00:14.2/sound/card0/input12
[    4.748218] input: HDA ATI SB Rear Mic as /devices/pci0000:00/0000:00:14.2/sound/card0/input13
[    4.748605] input: HDA ATI SB Line as /devices/pci0000:00/0000:00:14.2/sound/card0/input14
[    4.748900] input: HDA ATI SB Line Out as /devices/pci0000:00/0000:00:14.2/sound/card0/input15
[    4.749208] input: HDA ATI SB Front Headphone as /devices/pci0000:00/0000:00:14.2/sound/card0/input16
[    4.876385] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[    5.127094] RPC: Registered named UNIX socket transport module.
[    5.127096] RPC: Registered udp transport module.
[    5.127096] RPC: Registered tcp transport module.
[    5.127097] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    5.404828] IPv6: ADDRCONF(NETDEV_UP): enp0s18f2u3: link is not ready
[    5.433275] IPv6: ADDRCONF(NETDEV_UP): enp0s18f2u3: link is not ready
[    5.644576] r8152 1-3:1.0 enp0s18f2u3: carrier on
[    5.644593] IPv6: ADDRCONF(NETDEV_CHANGE): enp0s18f2u3: link becomes ready
[    5.759857] ip6_tables: (C) 2000-2006 Netfilter Core Team
[    5.853172] Ebtables v2.0 registered
[    6.230059] tun: Universal TUN/TAP device driver, 1.6
[    6.231099] virbr0: port 1(virbr0-nic) entered blocking state
[    6.231106] virbr0: port 1(virbr0-nic) entered disabled state
[    6.231384] device virbr0-nic entered promiscuous mode
[    6.455071] nf_conntrack version 0.5.0 (65536 buckets, 262144 max)
[    6.827701] virbr0: port 1(virbr0-nic) entered blocking state
[    6.827708] virbr0: port 1(virbr0-nic) entered listening state
[    6.882380] virbr0: port 1(virbr0-nic) entered disabled state
[   11.383487] random: crng init done
[   14.077983] [drm] amdgpu kernel modesetting enabled.
[   14.092756] AMD IOMMUv2 driver by Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
[   14.092757] AMD IOMMUv2 functionality not available on this system
[   14.153219] CRAT table not found
[   14.153221] Finished initializing topology ret=0
[   14.153276] kfd kfd: Initialized module
[   14.156080] [drm] initializing kernel modesetting (POLARIS10 0x1002:0x67C4 0x1002:0x0B0D 0x00).
[   14.156104] [drm] register mmio base: 0xFEA00000
[   14.156105] [drm] register mmio size: 262144
[   14.156132] [drm] probing gen 2 caps for device 1002:5a16 = 33ed02/0
[   14.156133] [drm] probing mlw for device 1002:5a16 = 33ed02
[   14.156156] [drm] UVD is enabled in VM mode
[   14.156156] [drm] UVD ENC is enabled in VM mode
[   14.156158] [drm] VCE enabled in VM mode
[   14.156428] ATOM BIOS: 113-C9540101-006
[   14.158101] [drm] vm size is 64 GB, block size is 13-bit, fragment size is 9-bit
[   14.160135] amdgpu 0000:01:00.0: BAR 2: releasing [mem 0xd0000000-0xd01fffff 64bit pref]
[   14.160138] amdgpu 0000:01:00.0: BAR 0: releasing [mem 0xc0000000-0xcfffffff 64bit pref]
[   14.160158] pcieport 0000:00:02.0: BAR 15: releasing [mem 0xc0000000-0xd01fffff 64bit pref]
[   14.160182] pcieport 0000:00:02.0: BAR 15: no space for [mem size 0x300000000 64bit pref]
[   14.160184] pcieport 0000:00:02.0: BAR 15: failed to assign [mem size 0x300000000 64bit pref]
[   14.160199] amdgpu 0000:01:00.0: BAR 0: no space for [mem size 0x200000000 64bit pref]
[   14.160201] amdgpu 0000:01:00.0: BAR 0: failed to assign [mem size 0x200000000 64bit pref]
[   14.160208] amdgpu 0000:01:00.0: BAR 2: no space for [mem size 0x00200000 64bit pref]
[   14.160210] amdgpu 0000:01:00.0: BAR 2: failed to assign [mem size 0x00200000 64bit pref]
[   14.160226] pcieport 0000:00:02.0: PCI bridge to [bus 01]
[   14.160229] pcieport 0000:00:02.0:   bridge window [io  0xe000-0xefff]
[   14.160234] pcieport 0000:00:02.0:   bridge window [mem 0xfea00000-0xfeafffff]
[   14.160249] pcieport 0000:00:02.0: PCI bridge to [bus 01]
[   14.160252] pcieport 0000:00:02.0:   bridge window [io  0xe000-0xefff]
[   14.160256] pcieport 0000:00:02.0:   bridge window [mem 0xfea00000-0xfeafffff]
[   14.160259] pcieport 0000:00:02.0:   bridge window [mem 0xc0000000-0xd01fffff 64bit pref]
[   14.160269] [drm] Not enough PCI address space for a large BAR.
[   14.160430] amdgpu 0000:01:00.0: BAR 0: assigned [mem 0xc0000000-0xcfffffff 64bit pref]
[   14.160443] amdgpu 0000:01:00.0: BAR 2: assigned [mem 0xd0000000-0xd01fffff 64bit pref]
[   14.160522] amdgpu 0000:01:00.0: VRAM: 8192M 0x000000F400000000 - 0x000000F5FFFFFFFF (8192M used)
[   14.160525] amdgpu 0000:01:00.0: GTT: 256M 0x0000000000000000 - 0x000000000FFFFFFF
[   14.160532] [drm] Detected VRAM RAM=8192M, BAR=256M
[   14.160533] [drm] RAM width 256bits GDDR5
[   14.160832] [TTM] Zone  kernel: Available graphics memory: 4068830 kiB
[   14.160833] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[   14.160834] [TTM] Initializing pool allocator
[   14.160881] [TTM] Initializing DMA pool allocator
[   14.161014] [drm] amdgpu: 8192M of VRAM memory ready
[   14.161019] [drm] amdgpu: 5960M of GTT memory ready.
[   14.161090] [drm] GART: num cpu pages 65536, num gpu pages 65536
[   14.161208] [drm] PCIE GART of 256M enabled (table at 0x000000F400040000).
[   14.161488] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   14.161489] [drm] Driver supports precise vblank timestamp query.
[   14.164894] [drm] AMDGPU Display Connectors
[   14.164895] [drm] Connector 0:
[   14.164896] [drm]   DP-1
[   14.164897] [drm]   HPD6
[   14.164898] [drm]   DDC: 0x4868 0x4868 0x4869 0x4869 0x486a 0x486a 0x486b 0x486b
[   14.164898] [drm]   Encoders:
[   14.164900] [drm]     DFP1: INTERNAL_UNIPHY2
[   14.164900] [drm] Connector 1:
[   14.164901] [drm]   DP-2
[   14.164901] [drm]   HPD4
[   14.164902] [drm]   DDC: 0x4870 0x4870 0x4871 0x4871 0x4872 0x4872 0x4873 0x4873
[   14.164903] [drm]   Encoders:
[   14.164903] [drm]     DFP2: INTERNAL_UNIPHY2
[   14.164904] [drm] Connector 2:
[   14.164904] [drm]   DP-3
[   14.164904] [drm]   HPD1
[   14.164905] [drm]   DDC: 0x486c 0x486c 0x486d 0x486d 0x486e 0x486e 0x486f 0x486f
[   14.164906] [drm]   Encoders:
[   14.164906] [drm]     DFP3: INTERNAL_UNIPHY1
[   14.164907] [drm] Connector 3:
[   14.164907] [drm]   DP-4
[   14.164908] [drm]   HPD3
[   14.164909] [drm]   DDC: 0x4874 0x4874 0x4875 0x4875 0x4876 0x4876 0x4877 0x4877
[   14.164909] [drm]   Encoders:
[   14.164910] [drm]     DFP4: INTERNAL_UNIPHY
[   14.166900] [drm] Chained IB support enabled!
[   14.173632] [drm] Found UVD firmware Version: 1.79 Family ID: 16
[   14.176543] [drm] Found VCE firmware Version: 52.4 Binary ID: 3
[   14.261656] [drm] UVD and UVD ENC initialized successfully.
[   14.362592] [drm] VCE initialized successfully.
[   14.986842] [drm] fb mappable at 0xC03F0000
[   14.986844] [drm] vram apper at 0xC0000000
[   14.986846] [drm] size 8294400
[   14.986847] [drm] fb depth is 24
[   14.986848] [drm]    pitch is 7680
[   14.987186] fbcon: amdgpudrmfb (fb0) is primary device
[   15.125372] Console: switching to colour frame buffer device 240x67
[   15.255681] amdgpu 0000:01:00.0: fb0: amdgpudrmfb frame buffer device
[   15.264926] [drm] Initialized amdgpu 3.23.0 20150101 for 0000:01:00.0 on minor 0
[   19.467414] rfkill: input handler disabled
[   49.561885] PM: suspend entry (deep)
[   49.561887] PM: Syncing filesystems ... done.
[   49.591356] Freezing user space processes ... (elapsed 0.002 seconds) done.
[   49.593913] OOM killer disabled.
[   49.593914] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
[   49.595100] Suspending console(s) (use no_console_suspend to debug)
[   49.595737] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[   49.595814] sd 0:0:0:0: [sda] Stopping disk
[   49.596716] serial 00:06: disabled
[   50.190177] PM: suspend devices took 0.595 seconds
[   50.205100] ACPI: Preparing to enter system sleep state S3
[   50.205385] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[   50.207700] ACPI: EC: event blocked
[   50.207700] ACPI: EC: EC stopped
[   50.207701] PM: Saving platform NVS memory
[   50.207909] Disabling non-boot CPUs ...
[   50.217549] smpboot: CPU 1 is now offline
[   50.230891] smpboot: CPU 2 is now offline
[   50.239410] smpboot: CPU 3 is now offline
[   50.246688] smpboot: CPU 4 is now offline
[   50.251141] smpboot: CPU 5 is now offline
[   50.253302] ACPI: Low-level resume complete
[   50.253347] ACPI: EC: EC started
[   50.253347] PM: Restoring platform NVS memory
[   50.334706] LVT offset 0 assigned for vector 0x400
[   50.340306] microcode: CPU0: new patch_level=0x0600084f
[   50.340345] Enabling non-boot CPUs ...
[   50.340414] x86: Booting SMP configuration:
[   50.340415] smpboot: Booting Node 0 Processor 1 APIC 0x11
[   50.343696]  cache: parent cpu1 should not be sleeping
[   50.343953] microcode: CPU1: patch_level=0x0600084f
[   50.344351] CPU1 is up
[   50.344442] smpboot: Booting Node 0 Processor 2 APIC 0x12
[   50.353162]  cache: parent cpu2 should not be sleeping
[   50.353551] microcode: CPU2: patch_level=0x0600084f
[   50.354141] CPU2 is up
[   50.354196] smpboot: Booting Node 0 Processor 3 APIC 0x13
[   50.357729]  cache: parent cpu3 should not be sleeping
[   50.357985] microcode: CPU3: patch_level=0x0600084f
[   50.358544] CPU3 is up
[   50.358587] smpboot: Booting Node 0 Processor 4 APIC 0x14
[   50.367110]  cache: parent cpu4 should not be sleeping
[   50.367361] microcode: CPU4: patch_level=0x0600084f
[   50.367951] CPU4 is up
[   50.367993] smpboot: Booting Node 0 Processor 5 APIC 0x15
[   50.371351]  cache: parent cpu5 should not be sleeping
[   50.371602] microcode: CPU5: patch_level=0x0600084f
[   50.372225] CPU5 is up
[   50.380799] ACPI: Waking up from system sleep state S3
[   50.396581] ACPI: EC: event unblocked
[   50.397036] usb usb8: root hub lost power or was reset
[   50.397038] usb usb9: root hub lost power or was reset
[   50.398756] sd 0:0:0:0: [sda] Starting disk
[   50.400324] serial 00:06: activated
[   50.504241] r8152 1-3:1.0 enp0s18f2u3: carrier on
[   50.551061] [drm] PCIE GART of 256M enabled (table at 0x000000F400040000).
[   50.856434] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   50.867973] ata1.00: configured for UDMA/133
[   51.151741] [drm:gfx_v8_0_ring_test_ring [amdgpu]] *ERROR* amdgpu: ring 0 test failed (scratch(0xC040)=0xCAFEDEAD)
[   51.151770] [drm:amdgpu_resume_phase2 [amdgpu]] *ERROR* resume of IP block <gfx_v8_0> failed -22
[   51.151799] [drm:amdgpu_device_resume [amdgpu]] *ERROR* amdgpu_resume failed (-22).
[   51.151802] dpm_run_callback(): pci_pm_resume+0x0/0xb0 returns -22
[   51.151804] PM: Device 0000:01:00.0 failed to resume async: error -22
[   51.151996] PM: resume devices took 0.756 seconds
[   51.152018] OOM killer enabled.
[   51.152018] Restarting tasks ... done.
[   51.153697] PM: suspend exit
[   51.295730] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.295805] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.295810] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.295851] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.295855] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.295894] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.295897] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.295934] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.295936] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.295974] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.295978] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.296015] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.296018] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.296054] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.296057] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.296095] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.296099] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.296141] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.296146] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.296186] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.296191] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.296231] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.296235] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.296276] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.296279] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.296319] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.296323] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.296365] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.296372] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.296413] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.296429] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.296472] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.296477] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.296518] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.296524] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.296565] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.296569] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.296613] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.296618] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.296659] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.296664] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.296705] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.296711] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.296752] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.296757] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.296799] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.296805] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.296841] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.296845] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.296881] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.312866] amdgpu 0000:01:00.0: couldn't schedule ib on ring <gfx>
[   51.312919] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.360136] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.360261] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.360281] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.360390] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.360399] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.360511] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.360527] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.360634] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.360643] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.360755] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.360764] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.360874] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.360882] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.360994] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.361003] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.361113] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.361122] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.361227] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.361255] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   51.361300] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.367034] IPv6: ADDRCONF(NETDEV_UP): enp0s18f2u3: link is not ready
[   51.372954] IPv6: ADDRCONF(NETDEV_UP): enp0s18f2u3: link is not ready
[   51.382938] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.383030] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.383037] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.383093] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.383098] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.383153] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.383157] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.383213] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.383217] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.383272] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.383276] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.383331] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.383335] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.383390] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.383401] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.383459] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.383471] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.383534] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.383544] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.383605] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.383611] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.383673] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.383681] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.383742] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.383746] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.383801] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.383807] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.383862] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.383866] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.383921] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.383927] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.383984] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.383989] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.384046] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.384054] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.384112] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.384117] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.384175] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.384182] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.384244] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.384250] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.384307] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.384313] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.384375] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.384380] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.384443] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.384454] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.384511] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.384515] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.384570] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.384576] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.384630] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.384634] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.384689] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.384692] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.384747] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.384751] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.384805] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.384809] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.384864] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.384868] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.384922] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.384929] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.384983] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.384989] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.385043] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.385048] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.385103] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.385109] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.385164] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.385170] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.385224] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.385237] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.385292] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.385298] amdgpu 0000:01:00.0: couldn't schedule ib on ring <gfx>
[   51.385382] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.400418] IPv6: ADDRCONF(NETDEV_UP): enp0s18f2u3: link is not ready
[   51.403785] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   51.403854] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.404130] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.404311] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.404602] amdgpu 0000:01:00.0: couldn't schedule ib on ring <gfx>
[   51.404667] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.439890] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.439944] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.439948] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.439989] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.439993] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.440032] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.440038] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.440078] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.440081] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.440121] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.440124] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.440163] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.440167] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.440207] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.440211] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.440252] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.440256] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.440293] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.441189] amdgpu 0000:01:00.0: couldn't schedule ib on ring <gfx>
[   51.441329] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.441534] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.441585] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.441631] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.441676] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.441714] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.441760] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.441790] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.441836] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.443244] amdgpu 0000:01:00.0: couldn't schedule ib on ring <gfx>
[   51.443487] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.444417] amdgpu 0000:01:00.0: couldn't schedule ib on ring <gfx>
[   51.444513] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.457679] r8152 1-3:1.0 enp0s18f2u3: carrier on
[   51.458934] IPv6: ADDRCONF(NETDEV_CHANGE): enp0s18f2u3: link becomes ready
[   51.477466] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.477534] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.512991] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.513046] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.546499] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.546547] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.561251] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   51.561329] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.561346] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   51.561391] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.561412] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   51.561452] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.561478] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   51.561518] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.599176] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   51.599241] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.912265] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   51.912348] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   51.912361] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   51.912399] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.344479] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.344562] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.344567] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.344604] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.344608] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.344645] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.344648] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.344684] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.344687] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.344724] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.344727] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.344763] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.344766] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.344802] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.344805] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.344842] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.344845] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.344881] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.344884] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.344920] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.344923] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.344960] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.344963] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.344999] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.345002] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.345038] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.345042] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.345078] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.345081] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.345117] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.345120] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.345156] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.345159] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.345195] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.345198] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.345234] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.345238] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.345274] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.345276] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.345313] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.345315] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.345352] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.345355] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.345391] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.345394] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.345430] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.345433] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.345469] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.345481] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.345518] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.345524] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.345561] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.345563] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.345599] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.345602] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.345638] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.345642] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.345678] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.345681] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.345717] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.345721] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.345757] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.345761] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.345797] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.345799] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.345836] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.345839] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.345875] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.345878] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.345915] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.345917] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.345953] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.345956] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.345993] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.346004] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.346037] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.346040] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.346073] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.346076] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.346109] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.346114] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.346147] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.346150] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.346183] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.346186] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.346219] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.346223] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.346256] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.346260] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.346294] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.346296] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.346330] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.346332] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.346366] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.346369] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.346402] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.346406] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.346446] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.346454] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.346494] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.346497] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.346533] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.346537] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.346573] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.346577] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.346613] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.346617] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.346653] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.346656] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.346692] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.346696] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.346732] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.346736] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.346772] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.346775] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.346811] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.346813] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.346850] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.346852] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.346888] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.346891] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.346927] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.346930] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.346966] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.346969] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.347005] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.347008] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.347044] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.347047] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.347084] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.347087] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.347123] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.347127] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.347163] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.347166] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.347202] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.347205] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.347241] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.347245] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.347281] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.347285] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.347321] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.347324] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.347360] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.347364] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.347400] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.347403] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.347440] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.347449] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.347486] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.347488] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.347525] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.347527] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.347563] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.347566] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.347602] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.347605] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.347642] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.347646] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.347682] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.347685] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.347722] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.347725] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.347761] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.347766] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.347802] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.347806] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.347842] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.347846] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.347882] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.347884] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.347921] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.347924] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.347960] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.347963] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.347999] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.348002] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.348038] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.348043] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.348080] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.348084] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.348120] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.348126] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.348164] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.348170] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   52.348210] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   52.348242] amdgpu 0000:01:00.0: couldn't schedule ib on ring <gfx>
[   52.348333] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.412636] [drm:atom_op_jump [amdgpu]] *ERROR* atombios stuck in loop for more than 5secs aborting
[   56.412669] [drm:amdgpu_atom_execute_table_locked [amdgpu]] *ERROR* atombios stuck executing D74A (len 824, WS 0, PS 0) @ 0xD899
[   56.412699] [drm:amdgpu_atom_execute_table_locked [amdgpu]] *ERROR* atombios stuck executing D604 (len 326, WS 0, PS 0) @ 0xD68F
[   56.414534] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   56.414626] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.414639] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   56.414709] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.414912] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   56.414982] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.415153] amdgpu 0000:01:00.0: couldn't schedule ib on ring <gfx>
[   56.415285] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.497960] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   56.498081] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.498100] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   56.498200] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.498207] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   56.498306] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.498316] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   56.498416] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.498425] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   56.498538] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.498642] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   56.498755] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.498766] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   56.498883] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.498893] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   56.498962] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.498967] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   56.499038] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.499043] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   56.499121] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.499127] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   56.499203] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.499208] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   56.499285] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.499290] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   56.499369] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.501761] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma1>
[   56.501822] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.501825] amdgpu 0000:01:00.0: couldn't schedule ib on ring <gfx>
[   56.501949] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.502005] amdgpu 0000:01:00.0: couldn't schedule ib on ring <gfx>
[   56.502120] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.502149] amdgpu 0000:01:00.0: couldn't schedule ib on ring <gfx>
[   56.502265] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.502288] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   56.502375] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.502377] amdgpu 0000:01:00.0: couldn't schedule ib on ring <gfx>
[   56.502491] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.502510] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   56.502589] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.502592] amdgpu 0000:01:00.0: couldn't schedule ib on ring <gfx>
[   56.502711] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.502713] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   56.502796] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.502805] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   56.502885] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.505067] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.505128] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.505293] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.505345] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.505570] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.505623] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.505812] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.505851] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.506044] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.506081] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.506273] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.506311] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.506528] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.506568] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.507292] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.507330] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.507527] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.507563] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.508364] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.508413] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.508580] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.508618] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.508760] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.508798] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.508964] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.509001] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.509139] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.509177] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.509354] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.509392] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.509608] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.509659] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.509899] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.509941] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.510088] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.510130] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.510317] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.510359] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.510539] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.510581] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.510764] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.510806] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.510959] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.511000] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.511201] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.511244] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.511396] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.511437] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.511638] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.511680] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.511856] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.511917] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.512083] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.512141] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.512295] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.512356] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.512581] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.512639] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.512806] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.512866] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.513024] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.513084] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.513175] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.513236] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.513341] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.513401] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.513909] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.513969] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.516286] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.516368] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.516470] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.516544] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.516709] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.516782] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.516899] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.516972] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.517138] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.517210] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.517336] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.517408] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.517610] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.517682] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.517821] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.517895] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.518076] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.518150] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.518288] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.518362] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.518555] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.518629] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.518785] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.518858] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.519042] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.519116] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.519258] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.519331] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.519529] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.519602] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.519749] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.519826] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.520005] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.520081] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.520210] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.520284] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.520482] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.520557] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.520684] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.520762] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.520942] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.521018] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.521125] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.521200] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.521321] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.521398] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.522125] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.522207] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.522364] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.522442] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.522554] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.522630] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.522815] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.522891] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.523015] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.523091] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.523279] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.523356] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.523485] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.523561] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.523802] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.523877] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.524044] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.524123] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.524300] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.524375] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.524538] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.524617] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.525195] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.525276] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.525603] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.525683] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.525997] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.526061] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.526309] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.526373] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.526705] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.526769] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.526990] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.527054] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.527375] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.527440] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.527699] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.527763] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.528090] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.528155] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.528396] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.528459] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.528823] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.528890] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.529144] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.529207] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.529495] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.529559] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.530818] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.530873] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.531095] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.531140] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.531284] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.531328] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.531536] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.531581] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.531732] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.531777] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.531962] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.532008] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.532145] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.532190] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.532377] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.532419] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.532561] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.532602] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.532799] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.532841] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.532989] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.533032] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.533188] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   56.533251] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.533289] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.533335] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.533452] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.533495] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.533707] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   56.533745] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.533766] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.533807] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.533866] amdgpu 0000:01:00.0: couldn't schedule ib on ring <gfx>
[   56.533905] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.534188] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.534229] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.534583] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.534622] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.534805] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.534844] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.535044] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.535091] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.535267] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.535316] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.535527] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.535576] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.535730] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.535782] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.535954] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.536004] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.536174] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.536222] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.536398] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.536447] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.537000] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.537051] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.537790] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.537845] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.538154] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.538205] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.538424] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.538472] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.538715] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.538767] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.539007] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.539057] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.539249] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.539299] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.539558] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.539611] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.539805] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.539853] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.540057] amdgpu 0000:01:00.0: couldn't schedule ib on ring <uvd>
[   56.540103] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.564410] amdgpu 0000:01:00.0: couldn't schedule ib on ring <sdma0>
[   56.564528] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
[   56.564710] amdgpu 0000:01:00.0: couldn't schedule ib on ring <gfx>
[   56.564762] [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)

--------------16F13365AFCD139AAE50E061
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------16F13365AFCD139AAE50E061--
