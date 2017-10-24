From: Dennis Schridde <devurandom-hi6Y0CQ0nG0@public.gmane.org>
Subject: [drm:amdgpu_get_bios [amdgpu]] *ERROR* ACPI VFCT table present but
 broken (too short #2)
Date: Tue, 24 Oct 2017 12:24:21 +0200
Message-ID: <1807916.LxvqnZUED1@monk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1579517317=="
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

--===============1579517317==
Content-Type: multipart/signed; boundary="nextPart2250314.hWhE7FQ4uC"; micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart2250314.hWhE7FQ4uC
Content-Type: multipart/mixed; boundary="nextPart1554459.CH0NS1MyuD"
Content-Transfer-Encoding: 7Bit

This is a multi-part message in MIME format.

--nextPart1554459.CH0NS1MyuD
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi!

I am seeing messages like the following during startup:

[drm:amdgpu_get_bios [amdgpu]] *ERROR* ACPI VFCT table present but broken (too 
short #2)
AMD-Vi: Event logged [IO_PAGE_FAULT device=00:00.0 domain=0x0000 
address=0x00000000fffc0000 flags=0x0070]
[drm:dce_v11_0_set_pageflip_irq_state [amdgpu]] *ERROR* invalid pageflip crtc 
5
[drm:amdgpu_irq_disable_all [amdgpu]] *ERROR* error disabling interrupt (-22)
amdgpu 0000:01:00.0: Fatal error during GPU init
[TTM] Memory type 2 has not been initialized

The first message always appears, while the others are not as easily 
reproducable.

Other weird behaviour I notice is:
* Hangs of the entire system when I start Steam using `env DRI_PRIME=1 steam` 
(nothing reacts to commands anymore, including mouse clicks, the power button 
and the num-lock key, and the mouse cursor moves very sluggishly)
* Crashes of KWin when using Alt+Tab [1]
* The firmware and GRUB (and Linux, initially) display at 1024x768, while the 
monitor's native resolution is 2560x1080.  After the Linux kernel takes over, 
the monitor switches back to the native resolution.

I would hope that someone could guide me in gathering more information about 
this and in the best case getting additional output or a backtrace from the 
kernel, please.

Please find the full output of dmesg, lshw, lspci, glxinfo attached.  Since 
the second card (RX 560) did not come up during this boot, I could not include 
the output of glxinfo for that card (`env DRI_PRIME=1 glxinfo`) at this time.

I run Gentoo Linux with following software:
* Linux 4.13.8
* Mesa 17.2.3
* LLVM 5.0.0

I have two graphics cards plugged in:
* AMD Radeon R7 / AMD A10-7800
* AMD Radeon RX 560

The monitor is connected via Display Port to the first card (R7).

If more information would be helpful, please tell me how and I will try to 
acquire it.

--Dennis

P.S. I accidentally sent this email to the dri-devel mailinglist before.  
Please excuse the noise and ignore it there.

[1]: https://bugs.freedesktop.org/show_bug.cgi?id=103234
--nextPart1554459.CH0NS1MyuD
Content-Disposition: attachment; filename="dmesg.log"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-log; charset="utf-8"; name="dmesg.log"

[    0.000000] random: get_random_bytes called from start_kernel+0x2b/0x453 with crng_init=0
[    0.000000] Linux version 4.13.8-gentoo (dschridde@ernie) (gcc version 6.4.0 (Gentoo 6.4.0 p1.0)) #2 SMP Wed Oct 18 23:33:29 CEST 2017
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-4.13.8-gentoo root=UUID=f7e025ba-4549-4154-a81a-dadd364d3177 ro quiet fbcon=scrollback:128k amdgpu.exp_hw_support=1
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000000fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000001000-0x000000000008ffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000090000-0x0000000000090fff] type 20
[    0.000000] BIOS-e820: [mem 0x0000000000091000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000008ce94fff] usable
[    0.000000] BIOS-e820: [mem 0x000000008ce95000-0x000000008cec4fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000008cec5000-0x000000008cef4fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000008cef5000-0x000000008d572fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000008d573000-0x000000008e350fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000008e351000-0x000000008e3adfff] type 20
[    0.000000] BIOS-e820: [mem 0x000000008e3ae000-0x000000008e3aefff] usable
[    0.000000] BIOS-e820: [mem 0x000000008e3af000-0x000000008e5b4fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000008e5b5000-0x000000008e9f2fff] usable
[    0.000000] BIOS-e820: [mem 0x000000008e9f3000-0x000000008eff3fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000008eff4000-0x000000008effffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000feb80000-0x00000000fec01fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec10000-0x00000000fec10fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed8ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000042effffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v32.31 by American Megatrends
[    0.000000] efi:  ACPI=0x8cedd000  ACPI 2.0=0x8cedd000  SMBIOS=0x8e34f618 
[    0.000000] random: fast init done
[    0.000000] SMBIOS 2.7 present.
[    0.000000] DMI: System manufacturer System Product Name/A88X-PRO, BIOS 2603 03/10/2016
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x42f000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF write-through
[    0.000000]   C0000-DFFFF uncachable
[    0.000000]   E0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000000 mask FFFF80000000 write-back
[    0.000000]   1 base 000080000000 mask FFFFC0000000 write-back
[    0.000000]   2 base 0000C0000000 mask FFFFF0000000 write-back
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] TOM2: 000000042f000000 aka 17136M
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- WT  
[    0.000000] e820: update [mem 0xd0000000-0xffffffff] usable ==> reserved
[    0.000000] e820: last_pfn = 0x8f000 max_arch_pfn = 0x400000000
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] Base memory trampoline at [ffff880000057000] 57000 size 24576
[    0.000000] Using GB pages for direct mapping
[    0.000000] BRK [0x01c19000, 0x01c19fff] PGTABLE
[    0.000000] BRK [0x01c1a000, 0x01c1afff] PGTABLE
[    0.000000] BRK [0x01c1b000, 0x01c1bfff] PGTABLE
[    0.000000] BRK [0x01c1c000, 0x01c1cfff] PGTABLE
[    0.000000] BRK [0x01c1d000, 0x01c1dfff] PGTABLE
[    0.000000] BRK [0x01c1e000, 0x01c1efff] PGTABLE
[    0.000000] Secure boot could not be determined
[    0.000000] RAMDISK: [mem 0x360c7000-0x3705afff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x000000008CEDD000 000024 (v02 ALASKA)
[    0.000000] ACPI: XSDT 0x000000008CEDD088 000084 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FACP 0x000000008CEE3D70 00010C (v05 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI BIOS Warning (bug): Optional FADT field Pm2ControlBlock has valid Length but zero Address: 0x0000000000000000/0x1 (20170531/tbfadt-658)
[    0.000000] ACPI: DSDT 0x000000008CEDD1A0 006BCE (v02 ALASKA A M I    00000000 INTL 20051117)
[    0.000000] ACPI: FACS 0x000000008D568080 000040
[    0.000000] ACPI: APIC 0x000000008CEE3E80 00007E (v03 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FPDT 0x000000008CEE3F00 000044 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: MCFG 0x000000008CEE3F48 00003C (v01 ALASKA A M I    01072009 MSFT 00010013)
[    0.000000] ACPI: CRAT 0x000000008CEF46D8 0005A0 (v01 AMD    BANTRY   00000001 AMD  00000001)
[    0.000000] ACPI: HPET 0x000000008CEE3FE0 000038 (v01 ALASKA A M I    01072009 AMI  00000005)
[    0.000000] ACPI: UEFI 0x000000008CEE4018 000042 (v01 ALASKA A M I    01072009      00000000)
[    0.000000] ACPI: IVRS 0x000000008CEE4060 0000D0 (v02 AMD    BANTRY   00000001 AMD  00000000)
[    0.000000] ACPI: VFCT 0x000000008CEE4130 00F684 (v01 ALASKA A M I    00000001 AMD  31504F47)
[    0.000000] ACPI: BGRT 0x000000008CEF37B8 000038 (v00 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: SSDT 0x000000008CEF37F0 000B9C (v01 AMD    BANTRY   00000001 AMD  00000001)
[    0.000000] ACPI: SSDT 0x000000008CEF4390 000346 (v02 AMD    BANTRY   00000002 MSFT 04000000)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000042effffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000008ffff]
[    0.000000]   node   0: [mem 0x0000000000091000-0x000000000009ffff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x000000008ce94fff]
[    0.000000]   node   0: [mem 0x000000008e3ae000-0x000000008e3aefff]
[    0.000000]   node   0: [mem 0x000000008e5b5000-0x000000008e9f2fff]
[    0.000000]   node   0: [mem 0x000000008eff4000-0x000000008effffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000042effffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000042effffff]
[    0.000000] On node 0 totalpages: 3916414
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 87 pages reserved
[    0.000000]   DMA zone: 3998 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 8972 pages used for memmap
[    0.000000]   DMA32 zone: 574176 pages, LIFO batch:31
[    0.000000]   Normal zone: 52160 pages used for memmap
[    0.000000]   Normal zone: 3338240 pages, LIFO batch:31
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
[    0.000000] ACPI: HPET id: 0x10228210 base: 0xfed00000
[    0.000000] efi_bgrt: Ignoring BGRT: invalid image address
[    0.000000] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x00090000-0x00090fff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0x8ce95000-0x8cec4fff]
[    0.000000] PM: Registered nosave memory: [mem 0x8cec5000-0x8cef4fff]
[    0.000000] PM: Registered nosave memory: [mem 0x8cef5000-0x8d572fff]
[    0.000000] PM: Registered nosave memory: [mem 0x8d573000-0x8e350fff]
[    0.000000] PM: Registered nosave memory: [mem 0x8e351000-0x8e3adfff]
[    0.000000] PM: Registered nosave memory: [mem 0x8e3af000-0x8e5b4fff]
[    0.000000] PM: Registered nosave memory: [mem 0x8e9f3000-0x8eff3fff]
[    0.000000] PM: Registered nosave memory: [mem 0x8f000000-0xf7ffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xf8000000-0xfbffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfc000000-0xfeb7ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfeb80000-0xfec01fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec02000-0xfec0ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec10000-0xfec10fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec11000-0xfecfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed00000-0xfed00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed01000-0xfed7ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed80000-0xfed8ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed90000-0xfeffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xff000000-0xffffffff]
[    0.000000] e820: [mem 0x8f000000-0xf7ffffff] available for PCI devices
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.000000] setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:4 nr_node_ids:1
[    0.000000] percpu: Embedded 34 pages/cpu @ffff88042ec00000 s102232 r8192 d28840 u524288
[    0.000000] pcpu-alloc: s102232 r8192 d28840 u524288 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 3855131
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-4.13.8-gentoo root=UUID=f7e025ba-4549-4154-a81a-dadd364d3177 ro quiet fbcon=scrollback:128k amdgpu.exp_hw_support=1
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes)
[    0.000000] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.000000] Memory: 15234616K/15665656K available (6280K kernel code, 516K rwdata, 1956K rodata, 912K init, 608K bss, 431040K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=4.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.000000] NR_IRQS: 4352, nr_irqs: 1000, preallocated irqs: 16
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.001000] tsc: Detected 3499.959 MHz processor
[    0.001000] Calibrating delay loop (skipped), value calculated using timer frequency.. 6999.91 BogoMIPS (lpj=3499959)
[    0.001000] pid_max: default: 32768 minimum: 301
[    0.001000] ACPI: Core revision 20170531
[    0.003956] ACPI: 3 ACPI AML tables successfully acquired and loaded
[    0.005024] Security Framework initialized
[    0.005085] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes)
[    0.005137] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes)
[    0.005284] CPU: Physical Processor ID: 0
[    0.005284] CPU: Processor Core ID: 0
[    0.005285] mce: CPU supports 7 MCE banks
[    0.005290] LVT offset 1 assigned for vector 0xf9
[    0.005295] Last level iTLB entries: 4KB 512, 2MB 1024, 4MB 512
[    0.005295] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 512, 1GB 0
[    0.005377] Freeing SMP alternatives memory: 32K
[    0.007751] smpboot: Max logical packages: 1
[    0.010415] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.021000] smpboot: CPU0: AMD A10-7800 Radeon R7, 12 Compute Cores 4C+8G (family: 0x15, model: 0x30, stepping: 0x1)
[    0.021000] Performance Events: Fam15h core perfctr, AMD PMU driver.
[    0.021000] ... version:                0
[    0.021000] ... bit width:              48
[    0.021000] ... generic registers:      6
[    0.021000] ... value mask:             0000ffffffffffff
[    0.021000] ... max period:             00007fffffffffff
[    0.021000] ... fixed-purpose events:   0
[    0.021000] ... event mask:             000000000000003f
[    0.021000] Hierarchical SRCU implementation.
[    0.021000] smp: Bringing up secondary CPUs ...
[    0.021000] x86: Booting SMP configuration:
[    0.021000] .... node  #0, CPUs:      #1 #2 #3
[    0.203024] smp: Brought up 1 node, 4 CPUs
[    0.203024] smpboot: Total of 4 processors activated (27996.59 BogoMIPS)
[    0.203841] devtmpfs: initialized
[    0.204112] PM: Registering ACPI NVS region [mem 0x8cef5000-0x8d572fff] (6807552 bytes)
[    0.204112] PM: Registering ACPI NVS region [mem 0x8e3af000-0x8e5b4fff] (2121728 bytes)
[    0.204187] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.204190] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    0.204261] xor: automatically using best checksumming function   avx       
[    0.204263] pinctrl core: initialized pinctrl subsystem
[    0.204288] RTC time: 18:00:05, date: 10/23/17
[    0.204362] NET: Registered protocol family 16
[    0.204460] cpuidle: using governor ladder
[    0.204460] cpuidle: using governor menu
[    0.204460] PCCT header not found.
[    0.204460] ACPI: bus type PCI registered
[    0.204460] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.204460] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.204460] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
[    0.204460] PCI: Using configuration type 1 for base access
[    0.205346] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.222004] raid6: sse2x1   gen()  7300 MB/s
[    0.239005] raid6: sse2x1   xor()  5058 MB/s
[    0.256006] raid6: sse2x2   gen() 11304 MB/s
[    0.273001] raid6: sse2x2   xor()  7714 MB/s
[    0.290001] raid6: sse2x4   gen() 13042 MB/s
[    0.307002] raid6: sse2x4   xor()  5968 MB/s
[    0.307003] raid6: using algorithm sse2x4 gen() 13042 MB/s
[    0.307004] raid6: .... xor() 5968 MB/s, rmw enabled
[    0.307005] raid6: using ssse3x2 recovery algorithm
[    0.307045] ACPI: Added _OSI(Module Device)
[    0.307046] ACPI: Added _OSI(Processor Device)
[    0.307046] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.307047] ACPI: Added _OSI(Processor Aggregator Device)
[    0.307195] ACPI: Executed 1 blocks of module-level executable AML code
[    0.309606] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.309866] ACPI: EC: EC started
[    0.309867] ACPI: EC: interrupt blocked
[    0.309871] ACPI: \_SB_.PCI0.SBRG.EC0_: Used as first EC
[    0.309873] ACPI: \_SB_.PCI0.SBRG.EC0_: GPE=0xa, EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.309874] ACPI: \_SB_.PCI0.SBRG.EC0_: Used as boot DSDT EC to handle transactions
[    0.309874] ACPI: Interpreter enabled
[    0.309889] ACPI: (supports S0 S3 S4 S5)
[    0.309890] ACPI: Using IOAPIC for interrupt routing
[    0.309999] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.314508] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.314511] acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.314638] acpi PNP0A03:00: _OSC: platform does not support [PCIeHotplug PME]
[    0.314756] acpi PNP0A03:00: _OSC: OS now controls [AER PCIeCapability]
[    0.314759] acpi PNP0A03:00: [Firmware Info]: MMCONFIG for domain 0000 [bus 00-3f] only partially covers this bridge
[    0.314975] PCI host bridge to bus 0000:00
[    0.314976] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    0.314978] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    0.314978] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
[    0.314979] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.314981] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.314982] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff window]
[    0.314983] pci_bus 0000:00: root bus resource [mem 0xd0000000-0xffffffff window]
[    0.314984] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.314991] pci 0000:00:00.0: [1022:1422] type 00 class 0x060000
[    0.315089] pci 0000:00:00.2: [1022:1423] type 00 class 0x080600
[    0.315211] pci 0000:00:01.0: [1002:130f] type 00 class 0x030000
[    0.315227] pci 0000:00:01.0: reg 0x10: [mem 0xd0000000-0xdfffffff 64bit pref]
[    0.315234] pci 0000:00:01.0: reg 0x18: [mem 0xf0800000-0xf0ffffff 64bit pref]
[    0.315240] pci 0000:00:01.0: reg 0x20: [io  0xf000-0xf0ff]
[    0.315245] pci 0000:00:01.0: reg 0x24: [mem 0xfeb00000-0xfeb3ffff]
[    0.315250] pci 0000:00:01.0: reg 0x30: [mem 0xfeb40000-0xfeb5ffff pref]
[    0.315283] pci 0000:00:01.0: supports D1 D2
[    0.315284] pci 0000:00:01.0: PME# supported from D1 D2 D3hot
[    0.315350] pci 0000:00:01.1: [1002:1308] type 00 class 0x040300
[    0.315363] pci 0000:00:01.1: reg 0x10: [mem 0xfeb64000-0xfeb67fff 64bit]
[    0.315406] pci 0000:00:01.1: supports D1 D2
[    0.315461] pci 0000:00:02.0: [1022:1424] type 00 class 0x060000
[    0.315534] pci 0000:00:02.1: [1022:1425] type 01 class 0x060400
[    0.315592] pci 0000:00:02.1: PME# supported from D0 D3hot D3cold
[    0.315657] pci 0000:00:03.0: [1022:1424] type 00 class 0x060000
[    0.315734] pci 0000:00:04.0: [1022:1424] type 00 class 0x060000
[    0.315835] pci 0000:00:10.0: [1022:7814] type 00 class 0x0c0330
[    0.315863] pci 0000:00:10.0: reg 0x10: [mem 0xfeb6a000-0xfeb6bfff 64bit]
[    0.315965] pci 0000:00:10.0: PME# supported from D0 D3hot D3cold
[    0.316088] pci 0000:00:10.1: [1022:7814] type 00 class 0x0c0330
[    0.316115] pci 0000:00:10.1: reg 0x10: [mem 0xfeb68000-0xfeb69fff 64bit]
[    0.316218] pci 0000:00:10.1: PME# supported from D0 D3hot D3cold
[    0.316294] pci 0000:00:11.0: [1022:7801] type 00 class 0x010601
[    0.316314] pci 0000:00:11.0: reg 0x10: [io  0xf140-0xf147]
[    0.316322] pci 0000:00:11.0: reg 0x14: [io  0xf130-0xf133]
[    0.316331] pci 0000:00:11.0: reg 0x18: [io  0xf120-0xf127]
[    0.316339] pci 0000:00:11.0: reg 0x1c: [io  0xf110-0xf113]
[    0.316347] pci 0000:00:11.0: reg 0x20: [io  0xf100-0xf10f]
[    0.316356] pci 0000:00:11.0: reg 0x24: [mem 0xfeb70000-0xfeb707ff]
[    0.316444] pci 0000:00:12.0: [1022:7807] type 00 class 0x0c0310
[    0.316461] pci 0000:00:12.0: reg 0x10: [mem 0xfeb6f000-0xfeb6ffff]
[    0.316571] pci 0000:00:12.2: [1022:7808] type 00 class 0x0c0320
[    0.316591] pci 0000:00:12.2: reg 0x10: [mem 0xfeb6e000-0xfeb6e0ff]
[    0.316666] pci 0000:00:12.2: supports D1 D2
[    0.316667] pci 0000:00:12.2: PME# supported from D0 D1 D2 D3hot D3cold
[    0.316728] pci 0000:00:13.0: [1022:7807] type 00 class 0x0c0310
[    0.316744] pci 0000:00:13.0: reg 0x10: [mem 0xfeb6d000-0xfeb6dfff]
[    0.316854] pci 0000:00:13.2: [1022:7808] type 00 class 0x0c0320
[    0.316873] pci 0000:00:13.2: reg 0x10: [mem 0xfeb6c000-0xfeb6c0ff]
[    0.316949] pci 0000:00:13.2: supports D1 D2
[    0.316950] pci 0000:00:13.2: PME# supported from D0 D1 D2 D3hot D3cold
[    0.317014] pci 0000:00:14.0: [1022:780b] type 00 class 0x0c0500
[    0.317136] pci 0000:00:14.2: [1022:780d] type 00 class 0x040300
[    0.317159] pci 0000:00:14.2: reg 0x10: [mem 0xfeb60000-0xfeb63fff 64bit]
[    0.317222] pci 0000:00:14.2: PME# supported from D0 D3hot D3cold
[    0.317276] pci 0000:00:14.3: [1022:780e] type 00 class 0x060100
[    0.317394] pci 0000:00:14.4: [1022:780f] type 01 class 0x060401
[    0.317491] pci 0000:00:15.0: [1022:43a0] type 01 class 0x060400
[    0.317568] pci 0000:00:15.0: supports D1 D2
[    0.317569] pci 0000:00:15.0: PME# supported from D0 D3hot D3cold
[    0.317636] pci 0000:00:15.1: [1022:43a1] type 01 class 0x060400
[    0.317713] pci 0000:00:15.1: supports D1 D2
[    0.317714] pci 0000:00:15.1: PME# supported from D0 D3hot D3cold
[    0.317780] pci 0000:00:15.2: [1022:43a2] type 01 class 0x060400
[    0.317856] pci 0000:00:15.2: supports D1 D2
[    0.317857] pci 0000:00:15.2: PME# supported from D0 D3hot D3cold
[    0.317926] pci 0000:00:18.0: [1022:141a] type 00 class 0x060000
[    0.317993] pci 0000:00:18.1: [1022:141b] type 00 class 0x060000
[    0.318057] pci 0000:00:18.2: [1022:141c] type 00 class 0x060000
[    0.318121] pci 0000:00:18.3: [1022:141d] type 00 class 0x060000
[    0.318208] pci 0000:00:18.4: [1022:141e] type 00 class 0x060000
[    0.318269] pci 0000:00:18.5: [1022:141f] type 00 class 0x060000
[    0.318397] pci 0000:01:00.0: [1002:67ff] type 00 class 0x030000
[    0.318430] pci 0000:01:00.0: reg 0x10: [mem 0xe0000000-0xefffffff 64bit pref]
[    0.318442] pci 0000:01:00.0: reg 0x18: [mem 0xf0000000-0xf01fffff 64bit pref]
[    0.318449] pci 0000:01:00.0: reg 0x20: [io  0xe000-0xe0ff]
[    0.318456] pci 0000:01:00.0: reg 0x24: [mem 0xfea00000-0xfea3ffff]
[    0.318463] pci 0000:01:00.0: reg 0x30: [mem 0xfea40000-0xfea5ffff pref]
[    0.318545] pci 0000:01:00.0: supports D1 D2
[    0.318546] pci 0000:01:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.318632] pci 0000:01:00.1: [1002:aae0] type 00 class 0x040300
[    0.318659] pci 0000:01:00.1: reg 0x10: [mem 0xfea60000-0xfea63fff 64bit]
[    0.318753] pci 0000:01:00.1: supports D1 D2
[    0.321078] pci 0000:00:02.1: PCI bridge to [bus 01]
[    0.321085] pci 0000:00:02.1:   bridge window [io  0xe000-0xefff]
[    0.321087] pci 0000:00:02.1:   bridge window [mem 0xfea00000-0xfeafffff]
[    0.321091] pci 0000:00:02.1:   bridge window [mem 0xe0000000-0xf01fffff 64bit pref]
[    0.321205] pci 0000:00:14.4: PCI bridge to [bus 02] (subtractive decode)
[    0.321213] pci 0000:00:14.4:   bridge window [io  0x0000-0x03af window] (subtractive decode)
[    0.321214] pci 0000:00:14.4:   bridge window [io  0x03e0-0x0cf7 window] (subtractive decode)
[    0.321215] pci 0000:00:14.4:   bridge window [io  0x03b0-0x03df window] (subtractive decode)
[    0.321216] pci 0000:00:14.4:   bridge window [io  0x0d00-0xffff window] (subtractive decode)
[    0.321217] pci 0000:00:14.4:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
[    0.321218] pci 0000:00:14.4:   bridge window [mem 0x000c0000-0x000dffff window] (subtractive decode)
[    0.321219] pci 0000:00:14.4:   bridge window [mem 0xd0000000-0xffffffff window] (subtractive decode)
[    0.321260] pci 0000:00:15.0: PCI bridge to [bus 03]
[    0.321327] pci 0000:04:00.0: [1b21:1142] type 00 class 0x0c0330
[    0.321364] pci 0000:04:00.0: reg 0x10: [mem 0xfe900000-0xfe907fff 64bit]
[    0.321509] pci 0000:04:00.0: PME# supported from D3cold
[    0.324070] pci 0000:00:15.1: PCI bridge to [bus 04]
[    0.324079] pci 0000:00:15.1:   bridge window [mem 0xfe900000-0xfe9fffff]
[    0.324205] pci 0000:05:00.0: [10ec:8168] type 00 class 0x020000
[    0.324237] pci 0000:05:00.0: reg 0x10: [io  0xd000-0xd0ff]
[    0.324266] pci 0000:05:00.0: reg 0x18: [mem 0xfe800000-0xfe800fff 64bit]
[    0.324284] pci 0000:05:00.0: reg 0x20: [mem 0xf1000000-0xf1003fff 64bit pref]
[    0.324387] pci 0000:05:00.0: supports D1 D2
[    0.324388] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.327077] pci 0000:00:15.2: PCI bridge to [bus 05]
[    0.327104] pci 0000:00:15.2:   bridge window [io  0xd000-0xdfff]
[    0.327107] pci 0000:00:15.2:   bridge window [mem 0xfe800000-0xfe8fffff]
[    0.327112] pci 0000:00:15.2:   bridge window [mem 0xf1000000-0xf10fffff 64bit pref]
[    0.327148] pci_bus 0000:00: on NUMA node 0
[    0.327582] ACPI: PCI Interrupt Link [LNKA] (IRQs 4 5 6 7 10 11 14 15) *0
[    0.327632] ACPI: PCI Interrupt Link [LNKB] (IRQs 4 5 6 7 10 11 14 15) *0
[    0.327683] ACPI: PCI Interrupt Link [LNKC] (IRQs 4 5 6 7 10 11 14 15) *0
[    0.327733] ACPI: PCI Interrupt Link [LNKD] (IRQs 4 10 11 14 15) *0
[    0.327771] ACPI: PCI Interrupt Link [LNKE] (IRQs 4 5 6 7 10 11 14 15) *0
[    0.327802] ACPI: PCI Interrupt Link [LNKF] (IRQs 4 5 6 7 10 11 14 15) *0
[    0.327833] ACPI: PCI Interrupt Link [LNKG] (IRQs 4 5 6 7 10 11 14 15) *0
[    0.327863] ACPI: PCI Interrupt Link [LNKH] (IRQs 4 5 6 7 10 11 14 15) *0
[    0.328126] ACPI: EC: interrupt unblocked
[    0.328133] ACPI: EC: event unblocked
[    0.328138] ACPI: \_SB_.PCI0.SBRG.EC0_: GPE=0xa, EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.328140] ACPI: \_SB_.PCI0.SBRG.EC0_: Used as boot DSDT EC to handle transactions and events
[    0.328192] pci 0000:00:01.0: vgaarb: setting as boot VGA device
[    0.328192] pci 0000:00:01.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.328192] pci 0000:01:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
[    0.328192] pci 0000:01:00.0: vgaarb: bridge control possible
[    0.328192] pci 0000:00:01.0: vgaarb: no bridge control possible
[    0.328192] vgaarb: loaded
[    0.328192] pps_core: LinuxPPS API ver. 1 registered
[    0.328192] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
[    0.328192] EDAC MC: Ver: 3.0.0
[    0.328192] Registered efivars operations
[    0.338422] PCI: Using ACPI for IRQ routing
[    0.340440] PCI: pci_cache_line_size set to 64 bytes
[    0.340510] e820: reserve RAM buffer [mem 0x8ce95000-0x8fffffff]
[    0.340511] e820: reserve RAM buffer [mem 0x8e3af000-0x8fffffff]
[    0.340512] e820: reserve RAM buffer [mem 0x8e9f3000-0x8fffffff]
[    0.340513] e820: reserve RAM buffer [mem 0x8f000000-0x8fffffff]
[    0.340513] e820: reserve RAM buffer [mem 0x42f000000-0x42fffffff]
[    0.340650] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.340650] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.342103] clocksource: Switched to clocksource hpet
[    0.343559] pnp: PnP ACPI init
[    0.343662] system 00:00: [mem 0xf8000000-0xfbffffff] has been reserved
[    0.343665] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.343713] system 00:01: [mem 0x90000000-0xcfffffff] has been reserved
[    0.343715] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.343764] system 00:02: [mem 0xfeb80000-0xfebfffff] could not be reserved
[    0.343766] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.343865] system 00:03: [io  0x0290-0x029f] has been reserved
[    0.343867] system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.343907] pnp 00:04: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.344000] system 00:05: [io  0x04d0-0x04d1] has been reserved
[    0.344010] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.344040] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.344214] pnp 00:07: [dma 0 disabled]
[    0.344246] pnp 00:07: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.344424] system 00:08: [io  0x04d0-0x04d1] has been reserved
[    0.344425] system 00:08: [io  0x040b] has been reserved
[    0.344426] system 00:08: [io  0x04d6] has been reserved
[    0.344427] system 00:08: [io  0x0c00-0x0c01] has been reserved
[    0.344428] system 00:08: [io  0x0c14] has been reserved
[    0.344429] system 00:08: [io  0x0c50-0x0c51] has been reserved
[    0.344430] system 00:08: [io  0x0c52] has been reserved
[    0.344431] system 00:08: [io  0x0c6c] has been reserved
[    0.344432] system 00:08: [io  0x0c6f] has been reserved
[    0.344433] system 00:08: [io  0x0cd0-0x0cd1] has been reserved
[    0.344433] system 00:08: [io  0x0cd2-0x0cd3] has been reserved
[    0.344434] system 00:08: [io  0x0cd4-0x0cd5] has been reserved
[    0.344436] system 00:08: [io  0x0cd6-0x0cd7] has been reserved
[    0.344437] system 00:08: [io  0x0cd8-0x0cdf] has been reserved
[    0.344438] system 00:08: [io  0x0800-0x089f] has been reserved
[    0.344439] system 00:08: [io  0x0b00-0x0b0f] has been reserved
[    0.344440] system 00:08: [io  0x0b20-0x0b3f] has been reserved
[    0.344441] system 00:08: [io  0x0900-0x090f] has been reserved
[    0.344442] system 00:08: [io  0x0910-0x091f] has been reserved
[    0.344443] system 00:08: [io  0xfe00-0xfefe] has been reserved
[    0.344445] system 00:08: [mem 0xfec00000-0xfec00fff] could not be reserved
[    0.344446] system 00:08: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.344447] system 00:08: [mem 0xfed80000-0xfed8ffff] has been reserved
[    0.344448] system 00:08: [mem 0xfed61000-0xfed70fff] has been reserved
[    0.344449] system 00:08: [mem 0xfec10000-0xfec10fff] has been reserved
[    0.344451] system 00:08: [mem 0xff000000-0xffffffff] has been reserved
[    0.344452] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.344581] pnp: PnP ACPI: found 9 devices
[    0.349114] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.349148] pci 0000:00:02.1: PCI bridge to [bus 01]
[    0.349150] pci 0000:00:02.1:   bridge window [io  0xe000-0xefff]
[    0.349153] pci 0000:00:02.1:   bridge window [mem 0xfea00000-0xfeafffff]
[    0.349155] pci 0000:00:02.1:   bridge window [mem 0xe0000000-0xf01fffff 64bit pref]
[    0.349160] pci 0000:00:14.4: PCI bridge to [bus 02]
[    0.349170] pci 0000:00:15.0: PCI bridge to [bus 03]
[    0.349179] pci 0000:00:15.1: PCI bridge to [bus 04]
[    0.349182] pci 0000:00:15.1:   bridge window [mem 0xfe900000-0xfe9fffff]
[    0.349189] pci 0000:00:15.2: PCI bridge to [bus 05]
[    0.349190] pci 0000:00:15.2:   bridge window [io  0xd000-0xdfff]
[    0.349194] pci 0000:00:15.2:   bridge window [mem 0xfe800000-0xfe8fffff]
[    0.349197] pci 0000:00:15.2:   bridge window [mem 0xf1000000-0xf10fffff 64bit pref]
[    0.349202] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    0.349203] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
[    0.349204] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
[    0.349205] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    0.349206] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff window]
[    0.349206] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff window]
[    0.349207] pci_bus 0000:00: resource 10 [mem 0xd0000000-0xffffffff window]
[    0.349208] pci_bus 0000:01: resource 0 [io  0xe000-0xefff]
[    0.349209] pci_bus 0000:01: resource 1 [mem 0xfea00000-0xfeafffff]
[    0.349210] pci_bus 0000:01: resource 2 [mem 0xe0000000-0xf01fffff 64bit pref]
[    0.349211] pci_bus 0000:02: resource 4 [io  0x0000-0x03af window]
[    0.349212] pci_bus 0000:02: resource 5 [io  0x03e0-0x0cf7 window]
[    0.349213] pci_bus 0000:02: resource 6 [io  0x03b0-0x03df window]
[    0.349214] pci_bus 0000:02: resource 7 [io  0x0d00-0xffff window]
[    0.349215] pci_bus 0000:02: resource 8 [mem 0x000a0000-0x000bffff window]
[    0.349216] pci_bus 0000:02: resource 9 [mem 0x000c0000-0x000dffff window]
[    0.349217] pci_bus 0000:02: resource 10 [mem 0xd0000000-0xffffffff window]
[    0.349218] pci_bus 0000:04: resource 1 [mem 0xfe900000-0xfe9fffff]
[    0.349219] pci_bus 0000:05: resource 0 [io  0xd000-0xdfff]
[    0.349220] pci_bus 0000:05: resource 1 [mem 0xfe800000-0xfe8fffff]
[    0.349221] pci_bus 0000:05: resource 2 [mem 0xf1000000-0xf10fffff 64bit pref]
[    0.349270] NET: Registered protocol family 2
[    0.349383] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.349586] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.349772] TCP: Hash tables configured (established 131072 bind 65536)
[    0.349811] UDP hash table entries: 8192 (order: 6, 262144 bytes)
[    0.349865] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes)
[    0.349954] NET: Registered protocol family 1
[    0.349973] pci 0000:00:01.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.438236] pci 0000:00:12.2: PME# does not work under D3, disabling it
[    0.524234] pci 0000:00:13.2: PME# does not work under D3, disabling it
[    0.524402] PCI: CLS 64 bytes, default 64
[    0.524443] Unpacking initramfs...
[    1.880700] Freeing initrd memory: 15952K
[    1.880729] AMD-Vi: IOMMU performance counters supported
[    1.880733] AMD-Vi: Applying ATS write check workaround for IOMMU at 0000:00:00.2
[    1.880839] pci 0000:00:00.2: can't derive routing for PCI INT A
[    1.880840] pci 0000:00:00.2: PCI INT A: not connected
[    1.880970] iommu: Adding device 0000:00:01.0 to group 0
[    1.880984] iommu: Using direct mapping for device 0000:00:01.0
[    1.880998] iommu: Adding device 0000:00:01.1 to group 0
[    1.881079] iommu: Adding device 0000:00:02.0 to group 1
[    1.881092] iommu: Adding device 0000:00:02.1 to group 1
[    1.881141] iommu: Adding device 0000:00:03.0 to group 2
[    1.881192] iommu: Adding device 0000:00:04.0 to group 3
[    1.881253] iommu: Adding device 0000:00:10.0 to group 4
[    1.881268] iommu: Adding device 0000:00:10.1 to group 4
[    1.881316] iommu: Adding device 0000:00:11.0 to group 5
[    1.881386] iommu: Adding device 0000:00:12.0 to group 6
[    1.881398] iommu: Adding device 0000:00:12.2 to group 6
[    1.881454] iommu: Adding device 0000:00:13.0 to group 7
[    1.881466] iommu: Adding device 0000:00:13.2 to group 7
[    1.881528] iommu: Adding device 0000:00:14.0 to group 8
[    1.881541] iommu: Adding device 0000:00:14.2 to group 8
[    1.881553] iommu: Adding device 0000:00:14.3 to group 8
[    1.881600] iommu: Adding device 0000:00:14.4 to group 9
[    1.881665] iommu: Adding device 0000:00:15.0 to group 10
[    1.881680] iommu: Adding device 0000:00:15.1 to group 10
[    1.881695] iommu: Adding device 0000:00:15.2 to group 10
[    1.881771] iommu: Adding device 0000:00:18.0 to group 11
[    1.881784] iommu: Adding device 0000:00:18.1 to group 11
[    1.881797] iommu: Adding device 0000:00:18.2 to group 11
[    1.881811] iommu: Adding device 0000:00:18.3 to group 11
[    1.881824] iommu: Adding device 0000:00:18.4 to group 11
[    1.881838] iommu: Adding device 0000:00:18.5 to group 11
[    1.881865] iommu: Adding device 0000:01:00.0 to group 1
[    1.881876] iommu: Adding device 0000:01:00.1 to group 1
[    1.881886] iommu: Adding device 0000:04:00.0 to group 10
[    1.881897] iommu: Adding device 0000:05:00.0 to group 10
[    1.882313] AMD-Vi: Found IOMMU at 0000:00:00.2 cap 0x40
[    1.882314] AMD-Vi: Extended features (0x800090a52):
[    1.882315]  PPR GT IA PC
[    1.882317] AMD-Vi: Interrupt remapping enabled
[    1.882582] AMD-Vi: Lazy IO/TLB flushing enabled
[    1.883894] amd_uncore: AMD NB counters detected
[    1.884105] LVT offset 0 assigned for vector 0x400
[    1.884147] perf: AMD IBS detected (0x000001ff)
[    1.884151] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 counters/bank).
[    1.884559] Scanning for low memory corruption every 60 seconds
[    1.884746] audit: initializing netlink subsys (disabled)
[    1.884803] audit: type=2000 audit(1508781606.884:1): state=initialized audit_enabled=0 res=1
[    1.884880] Initialise system trusted keyrings
[    1.884888] Key type blacklist registered
[    1.884921] workingset: timestamp_bits=46 max_order=22 bucket_order=0
[    1.886686] NET: Registered protocol family 38
[    1.886688] Key type asymmetric registered
[    1.886704] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
[    1.886742] io scheduler noop registered
[    1.886743] io scheduler deadline registered
[    1.886759] io scheduler cfq registered (default)
[    1.886760] io scheduler mq-deadline registered
[    1.886760] io scheduler kyber registered
[    1.886776] io scheduler bfq registered
[    1.887209] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    1.907750] 00:07: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    1.908210] Non-volatile memory driver v1.3
[    1.908287] Hangcheck: starting hangcheck timer 0.9.1 (tick is 180 seconds, margin is 60 seconds).
[    1.908392] efifb: probing for efifb
[    1.908398] efifb: framebuffer at 0xd0000000, using 3072k, total 3072k
[    1.908398] efifb: mode is 1024x768x32, linelength=4096, pages=1
[    1.908399] efifb: scrolling: redraw
[    1.908400] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    1.909974] Console: switching to colour frame buffer device 128x48
[    1.911517] fb0: EFI VGA frame buffer device
[    1.911814] GHES: HEST is not enabled!
[    1.911823] AMD IOMMUv2 driver by Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
[    1.912066] i8042: PNP: No PS/2 controller found.
[    1.912171] ledtrig-cpu: registered to indicate activity on CPUs
[    1.912202] hidraw: raw HID events driver (C) Jiri Kosina
[    1.912317] NET: Registered protocol family 10
[    1.912472] Segment Routing with IPv6
[    1.912483] NET: Registered protocol family 17
[    1.912715] microcode: CPU0: patch_level=0x06003106
[    1.912721] microcode: CPU1: patch_level=0x06003106
[    1.912728] microcode: CPU2: patch_level=0x06003106
[    1.912735] microcode: CPU3: patch_level=0x06003106
[    1.912766] microcode: Microcode Update Driver: v2.2.
[    1.912774] sched_clock: Marking stable (1912762065, 0)->(2114981203, -202219138)
[    1.912937] registered taskstats version 1
[    1.912938] Loading compiled-in X.509 certificates
[    1.913093] Btrfs loaded, crc32c=crc32c-generic
[    1.913364]   Magic number: 5:624:39
[    1.913410] hctosys: unable to open rtc device (rtc0)
[    1.913514] acpi_cpufreq: overriding BIOS provided _PSD data
[    1.913659] PM: Hibernation image not present or could not be loaded.
[    1.914406] Freeing unused kernel memory: 912K
[    1.914407] Write protecting the kernel read-only data: 10240k
[    1.914941] Freeing unused kernel memory: 1896K
[    1.915140] Freeing unused kernel memory: 92K
[    1.915145] rodata_test: all tests were successful
[    1.946407] systemd[1]: systemd 235 running in system mode. (+PAM +AUDIT -SELINUX +IMA -APPARMOR +SMACK -SYSVINIT +UTMP -LIBCRYPTSETUP +GCRYPT -GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN default-hierarchy=hybrid)
[    1.946542] systemd[1]: Detected architecture x86-64.
[    1.946543] systemd[1]: Running in initial RAM disk.
[    1.946549] systemd[1]: No hostname configured.
[    1.946552] systemd[1]: Set hostname to <localhost>.
[    1.946581] systemd[1]: Initializing machine ID from random generator.
[    2.002369] systemd[1]: Reached target Swap.
[    2.002438] systemd[1]: Reached target Timers.
[    2.002499] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[    2.002517] systemd[1]: Reached target Paths.
[    2.140837] device-mapper: uevent: version 1.0.3
[    2.140972] device-mapper: ioctl: 4.37.0-ioctl (2017-09-20) initialised: dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
[    2.341622] ACPI: bus type USB registered
[    2.341642] usbcore: registered new interface driver usbfs
[    2.341649] usbcore: registered new interface driver hub
[    2.341681] usbcore: registered new device driver usb
[    2.347485] QUIRK: Enable AMD PLL fix
[    2.347502] xhci_hcd 0000:00:10.0: xHCI Host Controller
[    2.347508] xhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
[    2.347701] xhci_hcd 0000:00:10.0: hcc params 0x014040c3 hci version 0x100 quirks 0x00000418
[    2.347870] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    2.347871] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.347872] usb usb1: Product: xHCI Host Controller
[    2.347873] usb usb1: Manufacturer: Linux 4.13.8-gentoo xhci-hcd
[    2.347874] usb usb1: SerialNumber: 0000:00:10.0
[    2.347963] hub 1-0:1.0: USB hub found
[    2.347970] hub 1-0:1.0: 2 ports detected
[    2.349738] xhci_hcd 0000:00:10.0: xHCI Host Controller
[    2.349743] xhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
[    2.351459] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[    2.351480] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003
[    2.351482] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.351483] usb usb2: Product: xHCI Host Controller
[    2.351483] usb usb2: Manufacturer: Linux 4.13.8-gentoo xhci-hcd
[    2.351484] usb usb2: SerialNumber: 0000:00:10.0
[    2.351570] hub 2-0:1.0: USB hub found
[    2.351577] hub 2-0:1.0: 2 ports detected
[    2.351776] xhci_hcd 0000:00:10.1: xHCI Host Controller
[    2.351780] xhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
[    2.351949] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.353604] xhci_hcd 0000:00:10.1: hcc params 0x014040c3 hci version 0x100 quirks 0x00000418
[    2.353688] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    2.353976] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
[    2.353977] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.353978] usb usb3: Product: xHCI Host Controller
[    2.353979] usb usb3: Manufacturer: Linux 4.13.8-gentoo xhci-hcd
[    2.353980] usb usb3: SerialNumber: 0000:00:10.1
[    2.354152] ehci-pci: EHCI PCI platform driver
[    2.354850] hub 3-0:1.0: USB hub found
[    2.354858] hub 3-0:1.0: 2 ports detected
[    2.354947] xhci_hcd 0000:00:10.1: xHCI Host Controller
[    2.354951] xhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 4
[    2.356064] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
[    2.356083] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003
[    2.356085] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.356086] usb usb4: Product: xHCI Host Controller
[    2.356087] usb usb4: Manufacturer: Linux 4.13.8-gentoo xhci-hcd
[    2.356087] usb usb4: SerialNumber: 0000:00:10.1
[    2.356170] hub 4-0:1.0: USB hub found
[    2.356177] hub 4-0:1.0: 2 ports detected
[    2.356381] ehci-pci 0000:00:12.2: EHCI Host Controller
[    2.356386] ehci-pci 0000:00:12.2: new USB bus registered, assigned bus number 5
[    2.356389] ehci-pci 0000:00:12.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    2.356398] ehci-pci 0000:00:12.2: debug port 1
[    2.356437] ehci-pci 0000:00:12.2: irq 17, io mem 0xfeb6e000
[    2.359763] SCSI subsystem initialized
[    2.363051] ehci-pci 0000:00:12.2: USB 2.0 started, EHCI 1.00
[    2.363137] usb usb5: New USB device found, idVendor=1d6b, idProduct=0002
[    2.363139] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.363141] usb usb5: Product: EHCI Host Controller
[    2.363142] usb usb5: Manufacturer: Linux 4.13.8-gentoo ehci_hcd
[    2.363143] usb usb5: SerialNumber: 0000:00:12.2
[    2.363235] hub 5-0:1.0: USB hub found
[    2.363240] hub 5-0:1.0: 5 ports detected
[    2.363464] xhci_hcd 0000:04:00.0: xHCI Host Controller
[    2.363470] xhci_hcd 0000:04:00.0: new USB bus registered, assigned bus number 6
[    2.367207] libata version 3.00 loaded.
[    2.378986] AVX version of gcm_enc/dec engaged.
[    2.378987] AES CTR mode by8 optimization enabled
[    2.418563] [drm] amdgpu kernel modesetting enabled.
[    2.423905] xhci_hcd 0000:04:00.0: hcc params 0x0200e081 hci version 0x100 quirks 0x10000410
[    2.424128] usb usb6: New USB device found, idVendor=1d6b, idProduct=0002
[    2.424130] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.424132] usb usb6: Product: xHCI Host Controller
[    2.424133] usb usb6: Manufacturer: Linux 4.13.8-gentoo xhci-hcd
[    2.424134] usb usb6: SerialNumber: 0000:04:00.0
[    2.424354] hub 6-0:1.0: USB hub found
[    2.424362] hub 6-0:1.0: 2 ports detected
[    2.424457] ehci-pci 0000:00:13.2: EHCI Host Controller
[    2.424462] ehci-pci 0000:00:13.2: new USB bus registered, assigned bus number 7
[    2.424466] ehci-pci 0000:00:13.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    2.424476] ehci-pci 0000:00:13.2: debug port 1
[    2.424503] ehci-pci 0000:00:13.2: irq 17, io mem 0xfeb6c000
[    2.424579] xhci_hcd 0000:04:00.0: xHCI Host Controller
[    2.424582] xhci_hcd 0000:04:00.0: new USB bus registered, assigned bus number 8
[    2.424623] usb usb8: We don't know the algorithms for LPM for this host, disabling LPM.
[    2.424640] usb usb8: New USB device found, idVendor=1d6b, idProduct=0003
[    2.424641] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.424642] usb usb8: Product: xHCI Host Controller
[    2.424643] usb usb8: Manufacturer: Linux 4.13.8-gentoo xhci-hcd
[    2.424644] usb usb8: SerialNumber: 0000:04:00.0
[    2.424787] hub 8-0:1.0: USB hub found
[    2.424862] hub 8-0:1.0: 2 ports detected
[    2.431077] ehci-pci 0000:00:13.2: USB 2.0 started, EHCI 1.00
[    2.431476] usb usb7: New USB device found, idVendor=1d6b, idProduct=0002
[    2.431477] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.431478] usb usb7: Product: EHCI Host Controller
[    2.431479] usb usb7: Manufacturer: Linux 4.13.8-gentoo ehci_hcd
[    2.431480] usb usb7: SerialNumber: 0000:00:13.2
[    2.431711] hub 7-0:1.0: USB hub found
[    2.431718] hub 7-0:1.0: 5 ports detected
[    2.432267] ohci-pci: OHCI PCI platform driver
[    2.432387] ohci-pci 0000:00:12.0: OHCI PCI host controller
[    2.432394] ohci-pci 0000:00:12.0: new USB bus registered, assigned bus number 9
[    2.432431] ohci-pci 0000:00:12.0: irq 18, io mem 0xfeb6f000
[    2.488263] usb usb9: New USB device found, idVendor=1d6b, idProduct=0001
[    2.488268] usb usb9: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.488270] usb usb9: Product: OHCI PCI host controller
[    2.488272] usb usb9: Manufacturer: Linux 4.13.8-gentoo ohci_hcd
[    2.488275] usb usb9: SerialNumber: 0000:00:12.0
[    2.488702] hub 9-0:1.0: USB hub found
[    2.488722] hub 9-0:1.0: 5 ports detected
[    2.488987] ahci 0000:00:11.0: version 3.0
[    2.489325] ahci 0000:00:11.0: AHCI 0001.0300 32 slots 8 ports 6 Gbps 0xff impl SATA mode
[    2.489327] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp pio sxs 
[    2.489331] ahci 0000:00:11.0: both AHCI_HFLAG_MULTI_MSI flag set and custom irq handler implemented
[    2.490270] scsi host0: ahci
[    2.490409] scsi host1: ahci
[    2.490864] scsi host2: ahci
[    2.491070] scsi host3: ahci
[    2.492786] scsi host4: ahci
[    2.492990] scsi host5: ahci
[    2.493179] scsi host6: ahci
[    2.493325] scsi host7: ahci
[    2.493387] ata1: SATA max UDMA/133 abar m2048@0xfeb70000 port 0xfeb70100 irq 40
[    2.493390] ata2: SATA max UDMA/133 abar m2048@0xfeb70000 port 0xfeb70180 irq 41
[    2.493392] ata3: SATA max UDMA/133 abar m2048@0xfeb70000 port 0xfeb70200 irq 42
[    2.493394] ata4: SATA max UDMA/133 abar m2048@0xfeb70000 port 0xfeb70280 irq 43
[    2.493396] ata5: SATA max UDMA/133 abar m2048@0xfeb70000 port 0xfeb70300 irq 44
[    2.493398] ata6: SATA max UDMA/133 abar m2048@0xfeb70000 port 0xfeb70380 irq 45
[    2.493400] ata7: SATA max UDMA/133 abar m2048@0xfeb70000 port 0xfeb70400 irq 46
[    2.493402] ata8: SATA max UDMA/133 abar m2048@0xfeb70000 port 0xfeb70480 irq 47
[    2.495159] checking generic (d0000000 300000) vs hw (d0000000 10000000)
[    2.495161] fb: switching to amdgpudrmfb from EFI VGA
[    2.495191] Console: switching to colour dummy device 80x25
[    2.495580] [drm] initializing kernel modesetting (KAVERI 0x1002:0x130F 0x1043:0x85CB 0x00).
[    2.495593] [drm] register mmio base: 0xFEB00000
[    2.495594] [drm] register mmio size: 262144
[    2.495632] ATOM BIOS: 113-SPEC-102
[    2.495643] [drm] GPU post is not needed
[    2.495783] [drm] vm size is 64 GB, block size is 13-bit
[    2.495790] amdgpu 0000:00:01.0: VRAM: 1024M 0x0000000000000000 - 0x000000003FFFFFFF (1024M used)
[    2.495792] amdgpu 0000:00:01.0: GTT: 3072M 0x0000000040000000 - 0x00000000FFFFFFFF
[    2.495796] [drm] Detected VRAM RAM=1024M, BAR=1024M
[    2.495797] [drm] RAM width 128bits UNKNOWN
[    2.495852] [TTM] Zone  kernel: Available graphics memory: 7692436 kiB
[    2.495853] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[    2.495854] [TTM] Initializing pool allocator
[    2.495858] [TTM] Initializing DMA pool allocator
[    2.495881] [drm] amdgpu: 1024M of VRAM memory ready
[    2.495882] [drm] amdgpu: 3072M of GTT memory ready.
[    2.495891] [drm] GART: num cpu pages 786432, num gpu pages 786432
[    2.597046] [drm] PCIE GART of 3072M enabled (table at 0x0000000000040000).
[    2.597078] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    2.597079] [drm] Driver supports precise vblank timestamp query.
[    2.597112] amdgpu 0000:00:01.0: amdgpu: using MSI.
[    2.597130] [drm] amdgpu: irq initialized.
[    2.597134] [drm] Internal thermal controller without fan control
[    2.597135] [drm] amdgpu: dpm initialized
[    2.597270] [drm] AMDGPU Display Connectors
[    2.597270] [drm] Connector 0:
[    2.597271] [drm]   HDMI-A-1
[    2.597271] [drm]   HPD3
[    2.597273] [drm]   DDC: 0x1954 0x1954 0x1955 0x1955 0x1956 0x1956 0x1957 0x1957
[    2.597273] [drm]   Encoders:
[    2.597274] [drm]     DFP2: INTERNAL_UNIPHY2
[    2.597274] [drm] Connector 1:
[    2.597275] [drm]   DP-1
[    2.597275] [drm]   HPD1
[    2.597276] [drm]   DDC: 0x194c 0x194c 0x194d 0x194d 0x194e 0x194e 0x194f 0x194f
[    2.597277] [drm]   Encoders:
[    2.597277] [drm]     DFP1: INTERNAL_UNIPHY
[    2.597278] [drm] Connector 2:
[    2.597278] [drm]   VGA-1
[    2.597279] [drm]   HPD2
[    2.597280] [drm]   DDC: 0x1950 0x1950 0x1951 0x1951 0x1952 0x1952 0x1953 0x1953
[    2.597280] [drm]   Encoders:
[    2.597280] [drm]     CRT1: INTERNAL_UNIPHY3
[    2.597281] [drm]     CRT1: NUTMEG
[    2.597505] amdgpu 0000:00:01.0: fence driver on ring 0 use gpu addr 0x0000000040000010, cpu addr 0xffff880416dc3010
[    2.597555] amdgpu 0000:00:01.0: fence driver on ring 1 use gpu addr 0x0000000040000020, cpu addr 0xffff880416dc3020
[    2.597600] amdgpu 0000:00:01.0: fence driver on ring 2 use gpu addr 0x0000000040000030, cpu addr 0xffff880416dc3030
[    2.597644] amdgpu 0000:00:01.0: fence driver on ring 3 use gpu addr 0x0000000040000040, cpu addr 0xffff880416dc3040
[    2.597678] amdgpu 0000:00:01.0: fence driver on ring 4 use gpu addr 0x0000000040000050, cpu addr 0xffff880416dc3050
[    2.597710] amdgpu 0000:00:01.0: fence driver on ring 5 use gpu addr 0x0000000040000060, cpu addr 0xffff880416dc3060
[    2.597743] amdgpu 0000:00:01.0: fence driver on ring 6 use gpu addr 0x0000000040000070, cpu addr 0xffff880416dc3070
[    2.597779] amdgpu 0000:00:01.0: fence driver on ring 7 use gpu addr 0x0000000040000080, cpu addr 0xffff880416dc3080
[    2.597817] amdgpu 0000:00:01.0: fence driver on ring 8 use gpu addr 0x0000000040000090, cpu addr 0xffff880416dc3090
[    2.597887] amdgpu 0000:00:01.0: fence driver on ring 9 use gpu addr 0x00000000400000a0, cpu addr 0xffff880416dc30a0
[    2.597922] amdgpu 0000:00:01.0: fence driver on ring 10 use gpu addr 0x00000000400000b0, cpu addr 0xffff880416dc30b0
[    2.598022] [drm] Found UVD firmware Version: 1.64 Family ID: 9
[    2.598255] amdgpu 0000:00:01.0: fence driver on ring 11 use gpu addr 0x000000000068cd30, cpu addr 0xffffc90000e38d30
[    2.598311] [drm] Found VCE firmware Version: 50.10 Binary ID: 2
[    2.598364] amdgpu 0000:00:01.0: fence driver on ring 12 use gpu addr 0x00000000400000d0, cpu addr 0xffff880416dc30d0
[    2.598392] amdgpu 0000:00:01.0: fence driver on ring 13 use gpu addr 0x00000000400000e0, cpu addr 0xffff880416dc30e0
[    2.629532] [drm] ring test on 0 succeeded in 13 usecs
[    2.629739] [drm] ring test on 1 succeeded in 3 usecs
[    2.629745] [drm] ring test on 2 succeeded in 2 usecs
[    2.629751] [drm] ring test on 3 succeeded in 2 usecs
[    2.629757] [drm] ring test on 4 succeeded in 2 usecs
[    2.629767] [drm] ring test on 5 succeeded in 5 usecs
[    2.629775] [drm] ring test on 6 succeeded in 4 usecs
[    2.629781] [drm] ring test on 7 succeeded in 2 usecs
[    2.629787] [drm] ring test on 8 succeeded in 2 usecs
[    2.629891] [drm] ring test on 9 succeeded in 3 usecs
[    2.629896] [drm] ring test on 10 succeeded in 3 usecs
[    2.655198] [drm] ring test on 11 succeeded in 0 usecs
[    2.655200] [drm] UVD initialized successfully.
[    2.788104] usb 6-2: new full-speed USB device number 2 using xhci_hcd
[    2.790284] [drm] ring test on 12 succeeded in 6 usecs
[    2.790289] [drm] ring test on 13 succeeded in 1 usecs
[    2.790289] [drm] VCE initialized successfully.
[    2.790553] [drm] ib test on ring 0 succeeded
[    2.790602] [drm] ib test on ring 1 succeeded
[    2.790629] [drm] ib test on ring 2 succeeded
[    2.790646] [drm] ib test on ring 3 succeeded
[    2.790665] [drm] ib test on ring 4 succeeded
[    2.790687] [drm] ib test on ring 5 succeeded
[    2.790709] [drm] ib test on ring 6 succeeded
[    2.790725] [drm] ib test on ring 7 succeeded
[    2.790744] [drm] ib test on ring 8 succeeded
[    2.790763] [drm] ib test on ring 9 succeeded
[    2.790781] [drm] ib test on ring 10 succeeded
[    2.791575] [drm] ib test on ring 11 succeeded
[    2.791856] [drm] ib test on ring 12 succeeded
[    2.805517] ata5: SATA link down (SStatus 0 SControl 300)
[    2.806302] ata8: SATA link down (SStatus 0 SControl 300)
[    2.806405] ata7: SATA link down (SStatus 0 SControl 300)
[    2.822168] usb 9-1: new low-speed USB device number 2 using ohci-pci
[    2.852551] [drm] fb mappable at 0x90828000
[    2.852554] [drm] vram apper at 0x90000000
[    2.852556] [drm] size 11059200
[    2.852557] [drm] fb depth is 24
[    2.852558] [drm]    pitch is 10240
[    2.852804] fbcon: amdgpudrmfb (fb0) is primary device
[    2.913202] tsc: Refined TSC clocksource calibration: 3500.215 MHz
[    2.913211] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x32741c10c0e, max_idle_ns: 440795306386 ns
[    2.952118] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    2.952178] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    2.952206] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    2.952225] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    2.952753] ata3.00: ATAPI: TSSTcorp CDDVDW SH-S203D, SB00, max UDMA/100
[    2.952888] ata4.00: ATAPI: TSSTcorpDVD-ROM SH-D163B, SB01, max UDMA/33
[    2.952962] ata1.00: ATA-8: ST2000DL003-9VT166, CC32, max UDMA/133
[    2.952965] ata1.00: 3907029168 sectors, multi 16: LBA48 NCQ (depth 31/32)
[    2.953638] ata3.00: configured for UDMA/100
[    2.953740] ata1.00: configured for UDMA/133
[    2.954043] scsi 0:0:0:0: Direct-Access     ATA      ST2000DL003-9VT1 CC32 PQ: 0 ANSI: 5
[    2.954119] ata2.00: supports DRM functions and may not be fully accessible
[    2.954505] ata4.00: configured for UDMA/33
[    2.959000] ata2.00: disabling queued TRIM support
[    2.959004] ata2.00: ATA-9: Samsung SSD 850 PRO 128GB, EXM04B6Q, max UDMA/133
[    2.959007] ata2.00: 250069680 sectors, multi 1: LBA48 NCQ (depth 31/32), AA
[    2.960180] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.963553] ata6.00: ATA-7: SAMSUNG SP2504C, VT100-52, max UDMA7
[    2.963557] ata6.00: 488281250 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    2.964090] ata2.00: supports DRM functions and may not be fully accessible
[    2.968908] ata2.00: disabling queued TRIM support
[    2.973809] ata2.00: configured for UDMA/133
[    2.977165] ata6.00: configured for UDMA/133
[    2.978228] usb 9-1: New USB device found, idVendor=045e, idProduct=077d
[    2.978232] usb 9-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.978234] usb 9-1: Product: Comfort Mouse 6000
[    2.978236] usb 9-1: Manufacturer: Microsoft
[    3.000980] Console: switching to colour frame buffer device 320x67
[    3.006782] scsi 1:0:0:0: Direct-Access     ATA      Samsung SSD 850  4B6Q PQ: 0 ANSI: 5
[    3.027255] scsi 2:0:0:0: CD-ROM            TSSTcorp CDDVDW SH-S203D  SB00 PQ: 0 ANSI: 5
[    3.040214] scsi 3:0:0:0: CD-ROM            TSSTcorp DVD-ROM SH-D163B SB01 PQ: 0 ANSI: 5
[    3.054089] scsi 5:0:0:0: Direct-Access     ATA      SAMSUNG SP2504C  0-52 PQ: 0 ANSI: 5
[    3.091125] usb 6-2: New USB device found, idVendor=28de, idProduct=1142
[    3.091129] usb 6-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.091131] usb 6-2: Product: Steam Controller
[    3.091133] usb 6-2: Manufacturer: Valve Software
[    3.098243] amdgpu 0000:00:01.0: fb0: amdgpudrmfb frame buffer device
[    3.108284] [drm] Initialized amdgpu 3.18.0 20150101 for 0000:00:01.0 on minor 0
[    3.108563] ohci-pci 0000:00:13.0: OHCI PCI host controller
[    3.108580] ohci-pci 0000:00:13.0: new USB bus registered, assigned bus number 10
[    3.108626] ohci-pci 0000:00:13.0: irq 18, io mem 0xfeb6d000
[    3.110348] amdgpu 0000:01:00.0: enabling device (0000 -> 0003)
[    3.110665] [drm] initializing kernel modesetting (POLARIS11 0x1002:0x67FF 0x1043:0x052D 0xCF).
[    3.110685] [drm] register mmio base: 0xFEA00000
[    3.110686] [drm] register mmio size: 262144
[    3.110707] [drm] probing gen 2 caps for device 1022:1425 = 733d03/e
[    3.110710] [drm] probing mlw for device 1022:1425 = 733d03
[    3.110727] [drm] UVD is enabled in VM mode
[    3.110730] [drm] VCE enabled in VM mode
[    3.110851] [drm:amdgpu_get_bios [amdgpu]] *ERROR* ACPI VFCT table present but broken (too short #2)
[    3.123545] sd 0:0:0:0: [sda] 3907029168 512-byte logical blocks: (2.00 TB/1.82 TiB)
[    3.123617] sd 0:0:0:0: [sda] Write Protect is off
[    3.123620] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    3.123695] sd 1:0:0:0: [sdb] 250069680 512-byte logical blocks: (128 GB/119 GiB)
[    3.123741] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    3.123754] sd 1:0:0:0: [sdb] Write Protect is off
[    3.123756] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    3.123879] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    3.124640] sd 5:0:0:0: [sdc] 488281250 512-byte logical blocks: (250 GB/233 GiB)
[    3.124738] sd 5:0:0:0: [sdc] Write Protect is off
[    3.124741] sd 5:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    3.124925] sd 5:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    3.129250] sd 1:0:0:0: [sdb] supports TCG Opal
[    3.129253] sd 1:0:0:0: [sdb] Attached SCSI disk
[    3.130201] usbcore: registered new interface driver usbhid
[    3.130202] usbhid: USB HID core driver
[    3.131773] input: Microsoft Comfort Mouse 6000 as /devices/pci0000:00/0000:00:12.0/usb9/9-1/9-1:1.0/0003:045E:077D.0001/input/input0
[    3.138204] sr 2:0:0:0: [sr0] scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
[    3.138207] cdrom: Uniform CD-ROM driver Revision: 3.20
[    3.138425] sr 2:0:0:0: Attached scsi CD-ROM sr0
[    3.152300] sr 3:0:0:0: [sr1] scsi3-mmc drive: 4x/48x cd/rw xa/form2 cdda tray
[    3.152509] sr 3:0:0:0: Attached scsi CD-ROM sr1
[    3.162987]  sdc: sdc1 sdc2 sdc3
[    3.164857] usb usb10: New USB device found, idVendor=1d6b, idProduct=0001
[    3.164858] usb usb10: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.164859] usb usb10: Product: OHCI PCI host controller
[    3.164860] usb usb10: Manufacturer: Linux 4.13.8-gentoo ohci_hcd
[    3.164861] usb usb10: SerialNumber: 0000:00:13.0
[    3.165067] sd 5:0:0:0: [sdc] Attached SCSI disk
[    3.165246] hub 10-0:1.0: USB hub found
[    3.165286] hub 10-0:1.0: 5 ports detected
[    3.183303] hid-generic 0003:045E:077D.0001: input,hidraw0: USB HID v1.11 Mouse [Microsoft Comfort Mouse 6000] on usb-0000:00:12.0-1/input0
[    3.183492] input: Valve Software Steam Controller as /devices/pci0000:00/0000:00:15.1/0000:04:00.0/usb6/6-2/6-2:1.0/0003:28DE:1142.0002/input/input1
[    3.236348] hid-generic 0003:28DE:1142.0002: input,hidraw1: USB HID v1.11 Keyboard [Valve Software Steam Controller] on usb-0000:04:00.0-2/input0
[    3.237519] hid-generic 0003:28DE:1142.0003: hiddev96,hidraw2: USB HID v1.11 Device [Valve Software Steam Controller] on usb-0000:04:00.0-2/input1
[    3.237654] hid-generic 0003:28DE:1142.0004: hiddev97,hidraw3: USB HID v1.11 Device [Valve Software Steam Controller] on usb-0000:04:00.0-2/input2
[    3.237805] hid-generic 0003:28DE:1142.0005: hiddev98,hidraw4: USB HID v1.11 Device [Valve Software Steam Controller] on usb-0000:04:00.0-2/input3
[    3.239227] hid-generic 0003:28DE:1142.0006: hiddev99,hidraw5: USB HID v1.11 Device [Valve Software Steam Controller] on usb-0000:04:00.0-2/input4
[    3.336429] ATOM BIOS: 115-C994PI0-102
[    3.336443] [drm] GPU posting now...
[    3.337022]  sda: sda1 sda2 sda3
[    3.337724] sd 0:0:0:0: [sda] Attached SCSI disk
[    3.445497] [drm] vm size is 64 GB, block size is 13-bit
[    3.445578] amdgpu 0000:01:00.0: VRAM: 2048M 0x0000000000000000 - 0x000000007FFFFFFF (2048M used)
[    3.445579] amdgpu 0000:01:00.0: GTT: 3072M 0x0000000080000000 - 0x000000013FFFFFFF
[    3.445590] [drm] Detected VRAM RAM=2048M, BAR=256M
[    3.445591] [drm] RAM width 128bits GDDR5
[    3.445605] [drm] amdgpu: 2048M of VRAM memory ready
[    3.445606] [drm] amdgpu: 3072M of GTT memory ready.
[    3.445623] [drm] GART: num cpu pages 786432, num gpu pages 786432
[    3.446798] [drm] PCIE GART of 3072M enabled (table at 0x0000000000040000).
[    3.446829] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    3.446829] [drm] Driver supports precise vblank timestamp query.
[    3.446869] amdgpu 0000:01:00.0: amdgpu: using MSI.
[    3.446884] [drm] amdgpu: irq initialized.
[    3.532102] usb 9-2: new low-speed USB device number 3 using ohci-pci
[    3.600961] random: crng init done
[    3.607783] amdgpu: [powerplay] amdgpu: powerplay sw initialized
[    3.607934] [drm] AMDGPU Display Connectors
[    3.607935] [drm] Connector 0:
[    3.607935] [drm]   DP-2
[    3.607936] [drm]   HPD5
[    3.607937] [drm]   DDC: 0x4868 0x4868 0x4869 0x4869 0x486a 0x486a 0x486b 0x486b
[    3.607937] [drm]   Encoders:
[    3.607938] [drm]     DFP1: INTERNAL_UNIPHY1
[    3.607938] [drm] Connector 1:
[    3.607939] [drm]   HDMI-A-2
[    3.607939] [drm]   HPD3
[    3.607940] [drm]   DDC: 0x4874 0x4874 0x4875 0x4875 0x4876 0x4876 0x4877 0x4877
[    3.607940] [drm]   Encoders:
[    3.607941] [drm]     DFP2: INTERNAL_UNIPHY1
[    3.607941] [drm] Connector 2:
[    3.607941] [drm]   DVI-D-1
[    3.607942] [drm]   HPD4
[    3.607943] [drm]   DDC: 0x4878 0x4878 0x4879 0x4879 0x487a 0x487a 0x487b 0x487b
[    3.607943] [drm]   Encoders:
[    3.607944] [drm]     DFP3: INTERNAL_UNIPHY
[    3.608390] amdgpu 0000:01:00.0: fence driver on ring 0 use gpu addr 0x0000000080000008, cpu addr 0xffff880414477008
[    3.608623] amdgpu 0000:01:00.0: fence driver on ring 1 use gpu addr 0x0000000080000018, cpu addr 0xffff880414477018
[    3.608677] amdgpu 0000:01:00.0: fence driver on ring 2 use gpu addr 0x0000000080000028, cpu addr 0xffff880414477028
[    3.608730] amdgpu 0000:01:00.0: fence driver on ring 3 use gpu addr 0x0000000080000038, cpu addr 0xffff880414477038
[    3.608778] amdgpu 0000:01:00.0: fence driver on ring 4 use gpu addr 0x0000000080000048, cpu addr 0xffff880414477048
[    3.608826] amdgpu 0000:01:00.0: fence driver on ring 5 use gpu addr 0x0000000080000058, cpu addr 0xffff880414477058
[    3.608873] amdgpu 0000:01:00.0: fence driver on ring 6 use gpu addr 0x0000000080000068, cpu addr 0xffff880414477068
[    3.608920] amdgpu 0000:01:00.0: fence driver on ring 7 use gpu addr 0x0000000080000078, cpu addr 0xffff880414477078
[    3.608958] amdgpu 0000:01:00.0: fence driver on ring 8 use gpu addr 0x0000000080000088, cpu addr 0xffff880414477088
[    3.608987] amdgpu 0000:01:00.0: fence driver on ring 9 use gpu addr 0x000000008000009c, cpu addr 0xffff88041447709c
[    3.611137] amdgpu 0000:01:00.0: fence driver on ring 10 use gpu addr 0x00000000800000ac, cpu addr 0xffff8804144770ac
[    3.611204] amdgpu 0000:01:00.0: fence driver on ring 11 use gpu addr 0x00000000800000bc, cpu addr 0xffff8804144770bc
[    3.611354] [drm] Found UVD firmware Version: 1.79 Family ID: 16
[    3.612167] amdgpu 0000:01:00.0: fence driver on ring 12 use gpu addr 0x000000000082d420, cpu addr 0xffffc9000125a420
[    3.612280] [drm] Found VCE firmware Version: 52.4 Binary ID: 3
[    3.612386] amdgpu 0000:01:00.0: fence driver on ring 13 use gpu addr 0x00000000800000dc, cpu addr 0xffff8804144770dc
[    3.612422] amdgpu 0000:01:00.0: fence driver on ring 14 use gpu addr 0x00000000800000ec, cpu addr 0xffff8804144770ec
[    3.667771] amdgpu: [powerplay] [AVFS] Something is broken. See log!
[    3.670624] amdgpu: [powerplay] Can't find requested voltage id in vdd_dep_on_sclk table!
[    3.674750] amdgpu: [powerplay] 
                failed to send message 309 ret is 254 
[    3.674767] amdgpu: [powerplay] 
                failed to send pre message 14e ret is 254 
[    3.718037] amdgpu: [powerplay] 
                failed to send message 136 ret is 0 
[    3.726108] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:00.0 domain=0x0000 address=0x00000000fffc0000 flags=0x0070]
[    3.726150] AMD-Vi: Event logged [
[    3.726151] INVALID_DEVICE_REQUEST device=00:00.0 address=0x000000fdf8000000 flags=0x0a00]
[    3.726164] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:00.0 domain=0x0000 address=0x00000000fffd0000 flags=0x0070]
[    3.726796] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:00.0 domain=0x0000 address=0x00000000fffc0010 flags=0x0070]
[    3.726830] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:00.0 domain=0x0000 address=0x00000000fffd0000 flags=0x0070]
[    3.726864] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:00.0 domain=0x0000 address=0x00000000fffc0020 flags=0x0070]
[    3.726898] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:00.0 domain=0x0000 address=0x00000000fffd0000 flags=0x0070]
[    3.726932] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:00.0 domain=0x0000 address=0x00000000fffc0030 flags=0x0070]
[    3.726966] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:00.0 domain=0x0000 address=0x00000000fffd0000 flags=0x0070]
[    3.726999] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:00.0 domain=0x0000 address=0x00000000fffc0040 flags=0x0070]
[    3.740218] usb 9-2: New USB device found, idVendor=413c, idProduct=2003
[    3.740219] usb 9-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.740220] usb 9-2: Product: Dell USB Keyboard
[    3.740221] usb 9-2: Manufacturer: Dell
[    3.748449] input: Dell Dell USB Keyboard as /devices/pci0000:00/0000:00:12.0/usb9/9-2/9-2:1.0/0003:413C:2003.0007/input/input2
[    3.801149] hid-generic 0003:413C:2003.0007: input,hidraw6: USB HID v1.10 Keyboard [Dell Dell USB Keyboard] on usb-0000:00:12.0-2/input0
[    3.942876] [drm:gfx_v8_0_ring_test_ring [amdgpu]] *ERROR* amdgpu: ring 0 test failed (scratch(0xC040)=0xCAFEDEAD)
[    3.942961] [drm:amdgpu_device_init [amdgpu]] *ERROR* hw_init of IP block <gfx_v8_0> failed -22
[    3.943001] amdgpu 0000:01:00.0: amdgpu_init failed
[    3.943041] clocksource: Switched to clocksource tsc
[    3.943817] amdgpu: [powerplay] 
                failed to send message 30a ret is 254 
[    3.943836] amdgpu: [powerplay] 
                failed to send pre message 26b ret is 254 
[    3.978157] bcache: bch_journal_replay() journal replay done, 1870 keys in 29 entries, seq 21228149
[    3.978472] bcache: register_cache() registered cache device sdb
[    3.978665] bcache: register_bdev() registered backing device sda3
[    4.126806] bcache: bch_cached_dev_attach() Caching sda3 as bcache0 on set 2544ce80-fc04-4c3a-91a1-3d809e8206f4
[    4.135422] BTRFS: device label ernie devid 1 transid 726874 /dev/bcache0
[    4.164547] [drm:dce_v11_0_set_pageflip_irq_state [amdgpu]] *ERROR* invalid pageflip crtc 5
[    4.164710] [drm:amdgpu_irq_disable_all [amdgpu]] *ERROR* error disabling interrupt (-22)
[    4.164864] [drm:dce_v11_0_set_pageflip_irq_state [amdgpu]] *ERROR* invalid pageflip crtc 5
[    4.165010] [drm:amdgpu_irq_disable_all [amdgpu]] *ERROR* error disabling interrupt (-22)
[    4.165170] [drm:dce_v11_0_set_pageflip_irq_state [amdgpu]] *ERROR* invalid pageflip crtc 5
[    4.165316] [drm:amdgpu_irq_disable_all [amdgpu]] *ERROR* error disabling interrupt (-22)
[    4.165468] [drm:dce_v11_0_set_pageflip_irq_state [amdgpu]] *ERROR* invalid pageflip crtc 5
[    4.165613] [drm:amdgpu_irq_disable_all [amdgpu]] *ERROR* error disabling interrupt (-22)
[    4.165765] [drm:dce_v11_0_set_pageflip_irq_state [amdgpu]] *ERROR* invalid pageflip crtc 5
[    4.165909] [drm:amdgpu_irq_disable_all [amdgpu]] *ERROR* error disabling interrupt (-22)
[    4.166062] [drm:dce_v11_0_set_pageflip_irq_state [amdgpu]] *ERROR* invalid pageflip crtc 5
[    4.166208] [drm:amdgpu_irq_disable_all [amdgpu]] *ERROR* error disabling interrupt (-22)
[    4.168619] [drm] amdgpu: ttm finalized
[    4.168632] amdgpu 0000:01:00.0: Fatal error during GPU init
[    4.168688] [drm] amdgpu: finishing device.
[    4.168690] [TTM] Memory type 2 has not been initialized
[    4.195348] amdgpu: probe of 0000:01:00.0 failed with error -22
[    4.239657] BTRFS info (device bcache0): disk space caching is enabled
[    4.239660] BTRFS info (device bcache0): has skinny extents
[    4.720429] BTRFS info (device bcache0): detected SSD devices, enabling SSD mode
[    5.285718] systemd-journald[107]: Received SIGTERM from PID 1 (systemd).
[    5.344013] systemd: 18 output lines suppressed due to ratelimiting
[    5.714327] BTRFS info (device bcache0): enabling auto defrag
[    5.714330] BTRFS info (device bcache0): turning on discard
[    5.714333] BTRFS info (device bcache0): use lzo compression
[    5.714333] BTRFS info (device bcache0): disk space caching is enabled
[    5.744942] systemd-journald[440]: Received request to flush runtime journal from PID 1
[    5.747748] kvm: Nested Virtualization enabled
[    5.747750] kvm: Nested Paging enabled
[    5.760662] tun: Universal TUN/TAP device driver, 1.6
[    5.771980] loop: module loaded
[    5.876006] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input3
[    5.876017] ACPI: Power Button [PWRB]
[    5.876062] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input4
[    5.876073] ACPI: Power Button [PWRF]
[    5.880930] ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
[    5.881067] ACPI Error: [AFN7] Namespace lookup failure, AE_NOT_FOUND (20170531/psargs-364)
[    5.881118] ACPI Error: Method parse/execution failed \_SB.PCI0.VGA.LCD._BCM, AE_NOT_FOUND (20170531/psparse-550)
[    5.881163] ACPI Error: Evaluating _BCM failed (20170531/video-364)
[    5.881239] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A03:00/LNXVIDEO:00/input/input5
[    5.881278] ACPI: Video Device [VGA1] (multi-head: yes  rom: no  post: no)
[    5.881328] ACPI Error: [AFN7] Namespace lookup failure, AE_NOT_FOUND (20170531/psargs-364)
[    5.881363] ACPI Error: Method parse/execution failed \_SB.PCI0.PB21.VGA.LCD._BCM, AE_NOT_FOUND (20170531/psparse-550)
[    5.881407] ACPI Error: Evaluating _BCM failed (20170531/video-364)
[    5.881475] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A03:00/device:03/LNXVIDEO:01/input/input6
[    5.890221] systemd-journald[440]: File /var/log/journal/da20799125212121ea1810b900000015/system.journal corrupted or uncleanly shut down, renaming and replacing.
[    5.892138] rtc_cmos 00:04: RTC can wake from S4
[    5.892294] rtc_cmos 00:04: rtc core: registered rtc_cmos as rtc0
[    5.892323] rtc_cmos 00:04: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    5.904486] snd_hda_intel 0000:00:01.1: enabling device (0000 -> 0002)
[    5.904599] snd_hda_intel 0000:00:01.1: Force to non-snoop mode
[    5.904883] snd_hda_intel 0000:01:00.1: enabling device (0000 -> 0002)
[    5.904934] snd_hda_intel 0000:01:00.1: Handle vga_switcheroo audio client
[    5.904935] snd_hda_intel 0000:01:00.1: Force to non-snoop mode
[    5.917417] snd_hda_intel 0000:01:00.1: Too many HDMI devices
[    5.917419] snd_hda_intel 0000:01:00.1: Consider building the kernel with CONFIG_SND_DYNAMIC_MINORS=y
[    5.917420] snd_hda_intel 0000:01:00.1: Too many HDMI devices
[    5.917421] snd_hda_intel 0000:01:00.1: Consider building the kernel with CONFIG_SND_DYNAMIC_MINORS=y
[    5.917422] snd_hda_intel 0000:01:00.1: Too many HDMI devices
[    5.917423] snd_hda_intel 0000:01:00.1: Consider building the kernel with CONFIG_SND_DYNAMIC_MINORS=y
[    5.917823] snd_hda_intel 0000:01:00.1: control 3:0:0:ELD:0 is already present
[    5.917985] snd_hda_codec_hdmi: probe of hdaudioC2D0 failed with error -16
[    5.919695] snd_hda_intel 0000:01:00.1: Too many HDMI devices
[    5.919698] snd_hda_intel 0000:01:00.1: Consider building the kernel with CONFIG_SND_DYNAMIC_MINORS=y
[    5.919699] snd_hda_intel 0000:01:00.1: Too many HDMI devices
[    5.919700] snd_hda_intel 0000:01:00.1: Consider building the kernel with CONFIG_SND_DYNAMIC_MINORS=y
[    5.919701] snd_hda_intel 0000:01:00.1: Too many HDMI devices
[    5.919702] snd_hda_intel 0000:01:00.1: Consider building the kernel with CONFIG_SND_DYNAMIC_MINORS=y
[    5.920130] snd_hda_intel 0000:01:00.1: control 3:0:0:ELD:0 is already present
[    5.920616] input: HDA ATI HDMI HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:01.1/sound/card0/input7
[    5.920646] input: HDA ATI HDMI HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:01.1/sound/card0/input8
[    5.920670] snd_hda_codec_hdmi: probe of hdaudioC2D0 failed with error -16
[    5.923350] snd_hda_intel 0000:01:00.1: Too many HDMI devices
[    5.923352] snd_hda_intel 0000:01:00.1: Consider building the kernel with CONFIG_SND_DYNAMIC_MINORS=y
[    5.923353] snd_hda_intel 0000:01:00.1: Too many HDMI devices
[    5.923354] snd_hda_intel 0000:01:00.1: Consider building the kernel with CONFIG_SND_DYNAMIC_MINORS=y
[    5.923355] snd_hda_intel 0000:01:00.1: Too many HDMI devices
[    5.923356] snd_hda_intel 0000:01:00.1: Consider building the kernel with CONFIG_SND_DYNAMIC_MINORS=y
[    5.923636] snd_hda_intel 0000:01:00.1: control 3:0:0:ELD:0 is already present
[    5.923838] snd_hda_codec_hdmi: probe of hdaudioC2D0 failed with error -16
[    5.924127] snd_hda_codec_realtek hdaudioC1D0: ALC1150: SKU not ready 0x00000000
[    5.924666] snd_hda_codec_realtek hdaudioC1D0: autoconfig for ALC1150: line_outs=3 (0x14/0x15/0x16/0x0/0x0) type:line
[    5.924668] snd_hda_codec_realtek hdaudioC1D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    5.924670] snd_hda_codec_realtek hdaudioC1D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
[    5.924671] snd_hda_codec_realtek hdaudioC1D0:    mono: mono_out=0x0
[    5.924672] snd_hda_codec_realtek hdaudioC1D0:    dig-out=0x11/0x1e
[    5.924673] snd_hda_codec_realtek hdaudioC1D0:    inputs:
[    5.924675] snd_hda_codec_realtek hdaudioC1D0:      Front Mic=0x19
[    5.924677] snd_hda_codec_realtek hdaudioC1D0:      Rear Mic=0x18
[    5.924678] snd_hda_codec_realtek hdaudioC1D0:      Line=0x1a
[    5.926524] snd_hda_codec_generic hdaudioC2D0: ignore pin 0x7, too many assigned pins
[    5.926539] snd_hda_codec_generic hdaudioC2D0: ignore pin 0x9, too many assigned pins
[    5.926554] snd_hda_codec_generic hdaudioC2D0: ignore pin 0xb, too many assigned pins
[    5.926556] snd_hda_codec_generic hdaudioC2D0: autoconfig for Generic: line_outs=0 (0x0/0x0/0x0/0x0/0x0) type:line
[    5.926557] snd_hda_codec_generic hdaudioC2D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    5.926559] snd_hda_codec_generic hdaudioC2D0:    hp_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    5.926560] snd_hda_codec_generic hdaudioC2D0:    mono: mono_out=0x0
[    5.926560] snd_hda_codec_generic hdaudioC2D0:    dig-out=0x3/0x5
[    5.926561] snd_hda_codec_generic hdaudioC2D0:    inputs:
[    5.927544] input: HDA ATI HDMI HDMI as /devices/pci0000:00/0000:00:02.1/0000:01:00.1/sound/card2/input21
[    5.927571] input: HDA ATI HDMI HDMI as /devices/pci0000:00/0000:00:02.1/0000:01:00.1/sound/card2/input22
[    5.927578] proc_dir_entry 'card2/eld#0.0' already registered
[    5.927591] ------------[ cut here ]------------
[    5.927597] WARNING: CPU: 1 PID: 15 at /usr/src/linux-4.13.8-gentoo/fs/proc/generic.c:328 proc_register+0xae/0x120
[    5.927602] Modules linked in: snd_hda_codec_realtek(+) snd_hda_codec_generic snd_hda_codec_hdmi snd_hda_intel snd_hda_codec rtc_cmos snd_hwdep snd_hda_core snd_pcm snd_timer video snd button soundcore loop vhost_net vhost tap tun kvm_amd kvm irqbypass hid_generic sr_mod cdrom sd_mod usbhid ohci_pci crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel pcbc amdgpu aesni_intel aes_x86_64 crypto_simd glue_helper ahci cryptd libahci libata hwmon scsi_mod mfd_core i2c_algo_bit backlight drm_kms_helper ehci_pci ohci_hcd ehci_hcd syscopyarea sysfillrect sysimgblt fb_sys_fops ttm xhci_pci xhci_hcd drm usbcore usb_common i2c_core dm_mirror dm_region_hash dm_log dm_mod dax efivarfs
[    5.927637] CPU: 1 PID: 15 Comm: kworker/1:0 Not tainted 4.13.8-gentoo #2
[    5.927638] Hardware name: System manufacturer System Product Name/A88X-PRO, BIOS 2603 03/10/2016
[    5.927642] Workqueue: events azx_probe_work [snd_hda_intel]
[    5.927643] task: ffff88041d0d0000 task.stack: ffffc9000011c000
[    5.927645] RIP: 0010:proc_register+0xae/0x120
[    5.927646] RSP: 0018:ffffc9000011fcb8 EFLAGS: 00010296
[    5.927647] RAX: 0000000000000031 RBX: ffff880416264b80 RCX: 0000000000000006
[    5.927648] RDX: 0000000000000007 RSI: 0000000000000086 RDI: ffff88042ec8caf0
[    5.927648] RBP: ffffc9000011fce0 R08: 0000000000000001 R09: 0000000000000451
[    5.927649] R10: 000000000000026a R11: 0000000000000451 R12: ffff8804156f4a80
[    5.927649] R13: ffff880416264505 R14: ffff880416264480 R15: ffff8804156f4ab8
[    5.927650] FS:  0000000000000000(0000) GS:ffff88042ec80000(0000) knlGS:0000000000000000
[    5.927651] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.927652] CR2: 00007ffeff977fac CR3: 000000041ca40000 CR4: 00000000000406e0
[    5.927653] Call Trace:
[    5.927656]  proc_create_data+0x71/0xb0
[    5.927662]  snd_info_register+0x66/0xd0 [snd]
[    5.927665]  snd_info_register_recursive+0x5b/0x70 [snd]
[    5.927668]  snd_info_register_recursive+0x46/0x70 [snd]
[    5.927671]  snd_info_card_register+0x25/0xa0 [snd]
[    5.927674]  snd_card_register+0x131/0x1b0 [snd]
[    5.927677]  ? device_attach+0xb/0x10
[    5.927683]  azx_probe_continue+0x49a/0x820 [snd_hda_intel]
[    5.927685]  ? azx_probe_continue+0x49a/0x820 [snd_hda_intel]
[    5.927686]  azx_probe_work+0x10/0x20 [snd_hda_intel]
[    5.927689]  process_one_work+0x1af/0x340
[    5.927690]  worker_thread+0x43/0x3e0
[    5.927692]  kthread+0xff/0x140
[    5.927693]  ? create_worker+0x1a0/0x1a0
[    5.927695]  ? kthread_create_on_node+0x40/0x40
[    5.927696]  ? kthread_create_on_node+0x40/0x40
[    5.927698]  ret_from_fork+0x22/0x30
[    5.927698] Code: eb dd 48 8d 53 c0 4c 89 ee e8 3f fe ff ff 85 c0 78 c9 75 e8 49 8d b4 24 85 00 00 00 4c 89 ea 48 c7 c7 a8 3d 97 81 e8 9e db eb ff <0f> ff c6 05 b9 98 a0 00 00 41 8b 36 48 c7 c7 20 e6 a3 81 81 c6 
[    5.927719] ---[ end trace e81c9d69834344c2 ]---
[    5.940182] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:14.2/sound/card1/input23
[    5.940768] input: HD-Audio Generic Front Mic as /devices/pci0000:00/0000:00:14.2/sound/card1/input24
[    5.940792] input: HD-Audio Generic Rear Mic as /devices/pci0000:00/0000:00:14.2/sound/card1/input25
[    5.940845] input: HD-Audio Generic Line as /devices/pci0000:00/0000:00:14.2/sound/card1/input26
[    5.940873] input: HD-Audio Generic Line Out Front as /devices/pci0000:00/0000:00:14.2/sound/card1/input27
[    5.940899] input: HD-Audio Generic Line Out Surround as /devices/pci0000:00/0000:00:14.2/sound/card1/input28
[    5.940921] input: HD-Audio Generic Line Out CLFE as /devices/pci0000:00/0000:00:14.2/sound/card1/input29
[    5.940943] input: HD-Audio Generic Front Headphone as /devices/pci0000:00/0000:00:14.2/sound/card1/input30
[    5.946348] bcache: register_bcache() error opening /dev/sdb: device already registered
[    5.957793] EFI Variables Facility v0.08 2004-May-17
[    5.958601] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[    5.962100] r8169 0000:05:00.0 eth0: RTL8168g/8111g at 0xffffc90000241000, 38:2c:4a:ba:24:92, XID 0c000800 IRQ 54
[    5.962101] r8169 0000:05:00.0 eth0: jumbo features [frames: 9200 bytes, tx checksumming: ko]
[    5.963630] MCE: In-kernel MCE decoding enabled.
[    5.965948] EDAC amd64: Node 0: DRAM ECC disabled.
[    5.965949] EDAC amd64: ECC disabled in the BIOS or no ECC capability, module will not load.
                Either enable ECC checking or force module loading by setting 'ecc_enable_override'.
                (Note that use of the override may cause unknown side effects.)
[    5.981194] pstore: using lz4 compression
[    5.986278] pstore: Registered efi as persistent store backend
[    6.078124] r8169 0000:05:00.0 enp5s0: renamed from eth0
[    6.488886] bcache: register_bcache() error opening /dev/sda3: device already registered
[    7.332372] Netfilter messages via NETLINK v0.30.
[    7.339425] nf_tables: (c) 2007-2009 Patrick McHardy <kaber-dcUjhNyLwpNeoWH0uzbU5w@public.gmane.org>
[    8.104683] ip_tables: (C) 2000-2006 Netfilter Core Team
[    8.118002] ip6_tables: (C) 2000-2006 Netfilter Core Team
[    8.148648] Ebtables v2.0 registered
[    8.173290] nf_conntrack version 0.5.0 (65536 buckets, 262144 max)
[    8.257721] bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
[    8.297236] ip_set: protocol 6
[    8.525297] IPv6: ADDRCONF(NETDEV_UP): enp5s0: link is not ready
[    8.564660] r8169 0000:05:00.0 enp5s0: link down
[    8.564662] r8169 0000:05:00.0 enp5s0: link down
[    8.565058] IPv6: ADDRCONF(NETDEV_UP): enp5s0: link is not ready
[    8.638166] amdgpu 0000:00:01.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=none:owns=io+mem
[    9.175261] virbr0: port 1(virbr0-nic) entered blocking state
[    9.175263] virbr0: port 1(virbr0-nic) entered disabled state
[    9.175309] device virbr0-nic entered promiscuous mode
[    9.307856] virbr0: port 1(virbr0-nic) entered blocking state
[    9.307859] virbr0: port 1(virbr0-nic) entered listening state
[    9.345056] virbr0: port 1(virbr0-nic) entered disabled state
[    9.483328] systemd-journald[440]: File /var/log/journal/da20799125212121ea1810b900000015/user-65534.journal corrupted or uncleanly shut down, renaming and replacing.
[   10.130758] r8169 0000:05:00.0 enp5s0: link up
[   10.130765] IPv6: ADDRCONF(NETDEV_CHANGE): enp5s0: link becomes ready
[   10.174656] 8021q: 802.1Q VLAN Support v1.8
[   14.591216] systemd-journald[440]: File /var/log/journal/da20799125212121ea1810b900000015/user-1000.journal corrupted or uncleanly shut down, renaming and replacing.
[   27.206798] fuse init (API version 7.26)

--nextPart1554459.CH0NS1MyuD
Content-Disposition: attachment; filename="lshw.log"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-log; charset="utf-8"; name="lshw.log"

ernie
    description: Desktop Computer
    product: System Product Name (SKU)
    vendor: System manufacturer
    version: System Version
    serial: System Serial Number
    width: 4294967295 bits
    capabilities: smbios-2.7 dmi-2.7 smp vsyscall32
    configuration: boot=normal chassis=desktop family=To be filled by O.E.M. sku=SKU uuid=A0D79214-EE15-E011-A423-382C4ABA2492
  *-core
       description: Motherboard
       product: A88X-PRO
       vendor: ASUSTeK COMPUTER INC.
       physical id: 0
       version: Rev X.0x
       serial: 141033557900304
       slot: To be filled by O.E.M.
     *-firmware
          description: BIOS
          vendor: American Megatrends Inc.
          physical id: 0
          version: 2603
          date: 03/10/2016
          size: 64KiB
          capacity: 8128KiB
          capabilities: pci upgrade shadowing cdboot bootselect socketedrom edd int13floppy1200 int13floppy720 int13floppy2880 int5printscreen int9keyboard int14serial int17printer acpi usb biosbootspecification uefi
     *-memory
          description: System Memory
          physical id: 33
          slot: System board or motherboard
          size: 16GiB
        *-bank:0
             description: [empty]
             product: Array1_PartNumber1
             vendor: A1_Manufacturer1
             physical id: 0
             serial: A1_SerNum1
             slot: DIMM_A1
        *-bank:1
             description: DIMM DDR3 Synchronous Unbuffered (Unregistered) 1600 MHz (0.6 ns)
             product: CL10-11-11 D3-2133
             vendor: Undefined
             physical id: 1
             serial: 00000000
             slot: DIMM_A2
             size: 8GiB
             width: 64 bits
             clock: 1600MHz (0.6ns)
        *-bank:2
             description: [empty]
             product: Array1_PartNumber2
             vendor: A1_Manufacturer2
             physical id: 2
             serial: A1_SerNum2
             slot: DIMM_B1
        *-bank:3
             description: DIMM DDR3 Synchronous Unbuffered (Unregistered) 1600 MHz (0.6 ns)
             product: Array1_PartNumber3
             vendor: A1_Manufacturer3
             physical id: 3
             serial: A1_SerNum3
             slot: DIMM_B2
             size: 8GiB
             width: 64 bits
             clock: 1600MHz (0.6ns)
     *-cache:0
          description: L1 cache
          physical id: 41
          slot: L1 CACHE
          size: 256KiB
          capacity: 256KiB
          clock: 1GHz (1.0ns)
          capabilities: pipeline-burst internal write-back unified
          configuration: level=1
     *-cache:1
          description: L2 cache
          physical id: 42
          slot: L2 CACHE
          size: 4MiB
          capacity: 4MiB
          clock: 1GHz (1.0ns)
          capabilities: pipeline-burst internal write-back unified
          configuration: level=2
     *-cpu
          description: CPU
          product: AMD A10-7800 Radeon R7, 12 Compute Cores 4C+8G
          vendor: Advanced Micro Devices [AMD]
          physical id: 43
          bus info: cpu@0
          version: AMD A10-7800 Radeon R7, 12 Compute Cores 4C+8G
          slot: FM2+
          size: 1576MHz
          capacity: 3500MHz
          width: 64 bits
          clock: 100MHz
          capabilities: x86-64 fpu fpu_exception wp vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 popcnt aes xsave avx f16c lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs xop skinit wdt lwp fma4 tce nodeid_msr tbm topoext perfctr_core perfctr_nb bpext ptsc cpb hw_pstate vmmcall fsgsbase bmi1 xsaveopt arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold overflow_recov cpufreq
          configuration: cores=4 enabledcores=4 threads=4
     *-pci:0
          description: Host bridge
          product: Family 15h (Models 30h-3fh) Processor Root Complex
          vendor: Advanced Micro Devices, Inc. [AMD]
          physical id: 100
          bus info: pci@0000:00:00.0
          version: 00
          width: 32 bits
          clock: 33MHz
        *-generic UNCLAIMED
             description: IOMMU
             product: Family 15h (Models 30h-3fh) I/O Memory Management Unit
             vendor: Advanced Micro Devices, Inc. [AMD]
             physical id: 0.2
             bus info: pci@0000:00:00.2
             version: 00
             width: 32 bits
             clock: 33MHz
             capabilities: msi ht cap_list
             configuration: latency=0
        *-display
             description: VGA compatible controller
             product: Kaveri [Radeon R7 Graphics]
             vendor: Advanced Micro Devices, Inc. [AMD/ATI]
             physical id: 1
             bus info: pci@0000:00:01.0
             version: 00
             width: 64 bits
             clock: 33MHz
             capabilities: pm pciexpress msi vga_controller bus_master cap_list rom
             configuration: driver=amdgpu latency=0
             resources: irq:49 memory:d0000000-dfffffff memory:f0800000-f0ffffff ioport:f000(size=256) memory:feb00000-feb3ffff memory:c0000-dffff
        *-multimedia:0
             description: Audio device
             product: Kaveri HDMI/DP Audio Controller
             vendor: Advanced Micro Devices, Inc. [AMD/ATI]
             physical id: 1.1
             bus info: pci@0000:00:01.1
             version: 00
             width: 64 bits
             clock: 33MHz
             capabilities: pm pciexpress msi bus_master cap_list
             configuration: driver=snd_hda_intel latency=0
             resources: irq:51 memory:feb64000-feb67fff
        *-pci:0
             description: PCI bridge
             product: Advanced Micro Devices, Inc. [AMD]
             vendor: Advanced Micro Devices, Inc. [AMD]
             physical id: 2.1
             bus info: pci@0000:00:02.1
             version: 00
             width: 32 bits
             clock: 33MHz
             capabilities: pci pm pciexpress msi ht normal_decode bus_master cap_list
             configuration: driver=pcieport
             resources: irq:16 ioport:e000(size=4096) memory:fea00000-feafffff ioport:e0000000(size=270532608)
           *-display UNCLAIMED
                description: VGA compatible controller
                product: Baffin [Radeon RX 560]
                vendor: Advanced Micro Devices, Inc. [AMD/ATI]
                physical id: 0
                bus info: pci@0000:01:00.0
                version: cf
                width: 64 bits
                clock: 33MHz
                capabilities: pm pciexpress msi vga_controller cap_list
                configuration: latency=0
                resources: memory:e0000000-efffffff memory:f0000000-f01fffff ioport:e000(size=256) memory:fea00000-fea3ffff memory:fea40000-fea5ffff
           *-multimedia
                description: Audio device
                product: Advanced Micro Devices, Inc. [AMD/ATI]
                vendor: Advanced Micro Devices, Inc. [AMD/ATI]
                physical id: 0.1
                bus info: pci@0000:01:00.1
                version: 00
                width: 64 bits
                clock: 33MHz
                capabilities: pm pciexpress msi bus_master cap_list
                configuration: driver=snd_hda_intel latency=0
                resources: irq:53 memory:fea60000-fea63fff
        *-usb:0
             description: USB controller
             product: FCH USB XHCI Controller
             vendor: Advanced Micro Devices, Inc. [AMD]
             physical id: 10
             bus info: pci@0000:00:10.0
             version: 09
             width: 64 bits
             clock: 33MHz
             capabilities: pm msi msix pciexpress xhci bus_master cap_list
             configuration: driver=xhci_hcd latency=0
             resources: irq:18 memory:feb6a000-feb6bfff
           *-usbhost:0
                product: xHCI Host Controller
                vendor: Linux 4.13.8-gentoo xhci-hcd
                physical id: 0
                bus info: usb@1
                logical name: usb1
                version: 4.13
                capabilities: usb-2.00
                configuration: driver=hub slots=2 speed=480Mbit/s
           *-usbhost:1
                product: xHCI Host Controller
                vendor: Linux 4.13.8-gentoo xhci-hcd
                physical id: 1
                bus info: usb@2
                logical name: usb2
                version: 4.13
                capabilities: usb-3.00
                configuration: driver=hub slots=2 speed=5000Mbit/s
        *-usb:1
             description: USB controller
             product: FCH USB XHCI Controller
             vendor: Advanced Micro Devices, Inc. [AMD]
             physical id: 10.1
             bus info: pci@0000:00:10.1
             version: 09
             width: 64 bits
             clock: 33MHz
             capabilities: pm msi msix pciexpress xhci bus_master cap_list
             configuration: driver=xhci_hcd latency=0
             resources: irq:17 memory:feb68000-feb69fff
           *-usbhost:0
                product: xHCI Host Controller
                vendor: Linux 4.13.8-gentoo xhci-hcd
                physical id: 0
                bus info: usb@3
                logical name: usb3
                version: 4.13
                capabilities: usb-2.00
                configuration: driver=hub slots=2 speed=480Mbit/s
           *-usbhost:1
                product: xHCI Host Controller
                vendor: Linux 4.13.8-gentoo xhci-hcd
                physical id: 1
                bus info: usb@4
                logical name: usb4
                version: 4.13
                capabilities: usb-3.00
                configuration: driver=hub slots=2 speed=5000Mbit/s
        *-storage
             description: SATA controller
             product: FCH SATA Controller [AHCI mode]
             vendor: Advanced Micro Devices, Inc. [AMD]
             physical id: 11
             bus info: pci@0000:00:11.0
             version: 40
             width: 32 bits
             clock: 66MHz
             capabilities: storage msi ahci_1.0 bus_master cap_list
             configuration: driver=ahci latency=32
             resources: irq:40 ioport:f140(size=8) ioport:f130(size=4) ioport:f120(size=8) ioport:f110(size=4) ioport:f100(size=16) memory:feb70000-feb707ff
        *-usb:2
             description: USB controller
             product: FCH USB OHCI Controller
             vendor: Advanced Micro Devices, Inc. [AMD]
             physical id: 12
             bus info: pci@0000:00:12.0
             version: 11
             width: 32 bits
             clock: 66MHz
             capabilities: ohci bus_master
             configuration: driver=ohci-pci latency=32
             resources: irq:18 memory:feb6f000-feb6ffff
           *-usbhost
                product: OHCI PCI host controller
                vendor: Linux 4.13.8-gentoo ohci_hcd
                physical id: 1
                bus info: usb@9
                logical name: usb9
                version: 4.13
                capabilities: usb-1.10
                configuration: driver=hub slots=5 speed=12Mbit/s
              *-usb:0
                   description: Mouse
                   product: Comfort Mouse 6000
                   vendor: Microsoft
                   physical id: 1
                   bus info: usb@9:1
                   version: 1.44
                   capabilities: usb-2.00
                   configuration: driver=usbhid maxpower=100mA speed=2Mbit/s
              *-usb:1
                   description: Keyboard
                   product: Dell USB Keyboard
                   vendor: Dell
                   physical id: 2
                   bus info: usb@9:2
                   version: 3.06
                   capabilities: usb-1.10
                   configuration: driver=usbhid maxpower=70mA speed=2Mbit/s
        *-usb:3
             description: USB controller
             product: FCH USB EHCI Controller
             vendor: Advanced Micro Devices, Inc. [AMD]
             physical id: 12.2
             bus info: pci@0000:00:12.2
             version: 11
             width: 32 bits
             clock: 66MHz
             capabilities: pm debug ehci bus_master cap_list
             configuration: driver=ehci-pci latency=32
             resources: irq:17 memory:feb6e000-feb6e0ff
           *-usbhost
                product: EHCI Host Controller
                vendor: Linux 4.13.8-gentoo ehci_hcd
                physical id: 1
                bus info: usb@5
                logical name: usb5
                version: 4.13
                capabilities: usb-2.00
                configuration: driver=hub slots=5 speed=480Mbit/s
        *-usb:4
             description: USB controller
             product: FCH USB OHCI Controller
             vendor: Advanced Micro Devices, Inc. [AMD]
             physical id: 13
             bus info: pci@0000:00:13.0
             version: 11
             width: 32 bits
             clock: 66MHz
             capabilities: ohci bus_master
             configuration: driver=ohci-pci latency=32
             resources: irq:18 memory:feb6d000-feb6dfff
           *-usbhost
                product: OHCI PCI host controller
                vendor: Linux 4.13.8-gentoo ohci_hcd
                physical id: 1
                bus info: usb@10
                logical name: usb10
                version: 4.13
                capabilities: usb-1.10
                configuration: driver=hub slots=5 speed=12Mbit/s
        *-usb:5
             description: USB controller
             product: FCH USB EHCI Controller
             vendor: Advanced Micro Devices, Inc. [AMD]
             physical id: 13.2
             bus info: pci@0000:00:13.2
             version: 11
             width: 32 bits
             clock: 66MHz
             capabilities: pm debug ehci bus_master cap_list
             configuration: driver=ehci-pci latency=32
             resources: irq:17 memory:feb6c000-feb6c0ff
           *-usbhost
                product: EHCI Host Controller
                vendor: Linux 4.13.8-gentoo ehci_hcd
                physical id: 1
                bus info: usb@7
                logical name: usb7
                version: 4.13
                capabilities: usb-2.00
                configuration: driver=hub slots=5 speed=480Mbit/s
        *-serial UNCLAIMED
             description: SMBus
             product: FCH SMBus Controller
             vendor: Advanced Micro Devices, Inc. [AMD]
             physical id: 14
             bus info: pci@0000:00:14.0
             version: 16
             width: 32 bits
             clock: 66MHz
             configuration: latency=0
        *-multimedia:1
             description: Audio device
             product: FCH Azalia Controller
             vendor: Advanced Micro Devices, Inc. [AMD]
             physical id: 14.2
             bus info: pci@0000:00:14.2
             version: 01
             width: 64 bits
             clock: 33MHz
             capabilities: pm bus_master cap_list
             configuration: driver=snd_hda_intel latency=32
             resources: irq:16 memory:feb60000-feb63fff
        *-isa
             description: ISA bridge
             product: FCH LPC Bridge
             vendor: Advanced Micro Devices, Inc. [AMD]
             physical id: 14.3
             bus info: pci@0000:00:14.3
             version: 11
             width: 32 bits
             clock: 66MHz
             capabilities: isa bus_master
             configuration: latency=0
        *-pci:1
             description: PCI bridge
             product: FCH PCI Bridge
             vendor: Advanced Micro Devices, Inc. [AMD]
             physical id: 14.4
             bus info: pci@0000:00:14.4
             version: 40
             width: 32 bits
             clock: 66MHz
             capabilities: pci subtractive_decode bus_master vga_palette
        *-pci:2
             description: PCI bridge
             product: Hudson PCI to PCI bridge (PCIE port 0)
             vendor: Advanced Micro Devices, Inc. [AMD]
             physical id: 15
             bus info: pci@0000:00:15.0
             version: 00
             width: 32 bits
             clock: 33MHz
             capabilities: pci pm pciexpress msi ht normal_decode bus_master cap_list
             configuration: driver=pcieport
             resources: irq:16
        *-pci:3
             description: PCI bridge
             product: Hudson PCI to PCI bridge (PCIE port 1)
             vendor: Advanced Micro Devices, Inc. [AMD]
             physical id: 15.1
             bus info: pci@0000:00:15.1
             version: 00
             width: 32 bits
             clock: 33MHz
             capabilities: pci pm pciexpress msi ht normal_decode bus_master cap_list
             configuration: driver=pcieport
             resources: irq:16 memory:fe900000-fe9fffff
           *-usb
                description: USB controller
                product: ASM1042A USB 3.0 Host Controller
                vendor: ASMedia Technology Inc.
                physical id: 0
                bus info: pci@0000:04:00.0
                version: 00
                width: 64 bits
                clock: 33MHz
                capabilities: msi msix pm pciexpress xhci bus_master cap_list
                configuration: driver=xhci_hcd latency=0
                resources: irq:17 memory:fe900000-fe907fff
              *-usbhost:0
                   product: xHCI Host Controller
                   vendor: Linux 4.13.8-gentoo xhci-hcd
                   physical id: 0
                   bus info: usb@6
                   logical name: usb6
                   version: 4.13
                   capabilities: usb-2.00
                   configuration: driver=hub slots=2 speed=480Mbit/s
                 *-usb
                      description: Keyboard
                      product: Steam Controller
                      vendor: Valve Software
                      physical id: 2
                      bus info: usb@6:2
                      version: 0.01
                      capabilities: usb-2.00
                      configuration: driver=usbhid maxpower=100mA speed=12Mbit/s
              *-usbhost:1
                   product: xHCI Host Controller
                   vendor: Linux 4.13.8-gentoo xhci-hcd
                   physical id: 1
                   bus info: usb@8
                   logical name: usb8
                   version: 4.13
                   capabilities: usb-3.00
                   configuration: driver=hub slots=2 speed=5000Mbit/s
        *-pci:4
             description: PCI bridge
             product: Hudson PCI to PCI bridge (PCIE port 2)
             vendor: Advanced Micro Devices, Inc. [AMD]
             physical id: 15.2
             bus info: pci@0000:00:15.2
             version: 00
             width: 32 bits
             clock: 33MHz
             capabilities: pci pm pciexpress msi ht normal_decode bus_master cap_list
             configuration: driver=pcieport
             resources: irq:16 ioport:d000(size=4096) memory:fe800000-fe8fffff ioport:f1000000(size=1048576)
           *-network
                description: Ethernet interface
                product: RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller
                vendor: Realtek Semiconductor Co., Ltd.
                physical id: 0
                bus info: pci@0000:05:00.0
                logical name: enp5s0
                version: 11
                serial: 38:2c:4a:ba:24:92
                size: 100Mbit/s
                capacity: 1Gbit/s
                width: 64 bits
                clock: 33MHz
                capabilities: pm msi pciexpress msix vpd bus_master cap_list ethernet physical tp mii 10bt 10bt-fd 100bt 100bt-fd 1000bt 1000bt-fd autonegotiation
                configuration: autonegotiation=on broadcast=yes driver=r8169 driverversion=2.3LK-NAPI duplex=full firmware=rtl8168g-2_0.0.1 02/06/13 ip=192.168.178.21 latency=0 link=yes multicast=yes port=MII speed=100Mbit/s
                resources: irq:54 ioport:d000(size=256) memory:fe800000-fe800fff memory:f1000000-f1003fff
     *-pci:1
          description: Host bridge
          product: Advanced Micro Devices, Inc. [AMD]
          vendor: Advanced Micro Devices, Inc. [AMD]
          physical id: 101
          bus info: pci@0000:00:02.0
          version: 00
          width: 32 bits
          clock: 33MHz
     *-pci:2
          description: Host bridge
          product: Advanced Micro Devices, Inc. [AMD]
          vendor: Advanced Micro Devices, Inc. [AMD]
          physical id: 102
          bus info: pci@0000:00:03.0
          version: 00
          width: 32 bits
          clock: 33MHz
     *-pci:3
          description: Host bridge
          product: Advanced Micro Devices, Inc. [AMD]
          vendor: Advanced Micro Devices, Inc. [AMD]
          physical id: 103
          bus info: pci@0000:00:04.0
          version: 00
          width: 32 bits
          clock: 33MHz
     *-pci:4
          description: Host bridge
          product: Family 15h (Models 30h-3fh) Processor Function 0
          vendor: Advanced Micro Devices, Inc. [AMD]
          physical id: 104
          bus info: pci@0000:00:18.0
          version: 00
          width: 32 bits
          clock: 33MHz
     *-pci:5
          description: Host bridge
          product: Family 15h (Models 30h-3fh) Processor Function 1
          vendor: Advanced Micro Devices, Inc. [AMD]
          physical id: 105
          bus info: pci@0000:00:18.1
          version: 00
          width: 32 bits
          clock: 33MHz
     *-pci:6
          description: Host bridge
          product: Family 15h (Models 30h-3fh) Processor Function 2
          vendor: Advanced Micro Devices, Inc. [AMD]
          physical id: 106
          bus info: pci@0000:00:18.2
          version: 00
          width: 32 bits
          clock: 33MHz
     *-pci:7
          description: Host bridge
          product: Family 15h (Models 30h-3fh) Processor Function 3
          vendor: Advanced Micro Devices, Inc. [AMD]
          physical id: 107
          bus info: pci@0000:00:18.3
          version: 00
          width: 32 bits
          clock: 33MHz
          configuration: driver=k10temp
          resources: irq:0
     *-pci:8
          description: Host bridge
          product: Family 15h (Models 30h-3fh) Processor Function 4
          vendor: Advanced Micro Devices, Inc. [AMD]
          physical id: 108
          bus info: pci@0000:00:18.4
          version: 00
          width: 32 bits
          clock: 33MHz
          configuration: driver=fam15h_power
          resources: irq:0
     *-pci:9
          description: Host bridge
          product: Family 15h (Models 30h-3fh) Processor Function 5
          vendor: Advanced Micro Devices, Inc. [AMD]
          physical id: 109
          bus info: pci@0000:00:18.5
          version: 00
          width: 32 bits
          clock: 33MHz
  *-network:0
       description: Ethernet interface
       physical id: 1
       logical name: virbr0
       serial: 52:54:00:31:07:13
       capabilities: ethernet physical
       configuration: broadcast=yes driver=bridge driverversion=2.3 firmware=N/A ip=192.168.100.1 link=no multicast=yes
  *-network:1 DISABLED
       description: Ethernet interface
       physical id: 2
       logical name: virbr0-nic
       serial: 52:54:00:31:07:13
       size: 10Mbit/s
       capabilities: ethernet physical
       configuration: autonegotiation=off broadcast=yes driver=tun driverversion=1.6 duplex=full link=no multicast=yes port=twisted pair speed=10Mbit/s

--nextPart1554459.CH0NS1MyuD
Content-Disposition: attachment; filename="glxinfo-Radeon-R7-mesa-17.2.3.log"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-log; charset="utf-8"; name="glxinfo-Radeon-R7-mesa-17.2.3.log"

name of display: :0
display: :0  screen: 0
direct rendering: Yes
server glx vendor string: SGI
server glx version string: 1.4
server glx extensions:
    GLX_ARB_create_context, GLX_ARB_create_context_profile, 
    GLX_ARB_create_context_robustness, GLX_ARB_fbconfig_float, 
    GLX_ARB_framebuffer_sRGB, GLX_ARB_multisample, 
    GLX_EXT_create_context_es2_profile, GLX_EXT_create_context_es_profile, 
    GLX_EXT_fbconfig_packed_float, GLX_EXT_framebuffer_sRGB, 
    GLX_EXT_import_context, GLX_EXT_libglvnd, GLX_EXT_texture_from_pixmap, 
    GLX_EXT_visual_info, GLX_EXT_visual_rating, GLX_INTEL_swap_event, 
    GLX_MESA_copy_sub_buffer, GLX_OML_swap_method, GLX_SGIS_multisample, 
    GLX_SGIX_fbconfig, GLX_SGIX_pbuffer, GLX_SGIX_visual_select_group, 
    GLX_SGI_make_current_read, GLX_SGI_swap_control
client glx vendor string: Mesa Project and SGI
client glx version string: 1.4
client glx extensions:
    GLX_ARB_create_context, GLX_ARB_create_context_profile, 
    GLX_ARB_create_context_robustness, GLX_ARB_fbconfig_float, 
    GLX_ARB_framebuffer_sRGB, GLX_ARB_get_proc_address, GLX_ARB_multisample, 
    GLX_EXT_buffer_age, GLX_EXT_create_context_es2_profile, 
    GLX_EXT_create_context_es_profile, GLX_EXT_fbconfig_packed_float, 
    GLX_EXT_framebuffer_sRGB, GLX_EXT_import_context, 
    GLX_EXT_texture_from_pixmap, GLX_EXT_visual_info, GLX_EXT_visual_rating, 
    GLX_INTEL_swap_event, GLX_MESA_copy_sub_buffer, 
    GLX_MESA_multithread_makecurrent, GLX_MESA_query_renderer, 
    GLX_MESA_swap_control, GLX_OML_swap_method, GLX_OML_sync_control, 
    GLX_SGIS_multisample, GLX_SGIX_fbconfig, GLX_SGIX_pbuffer, 
    GLX_SGIX_visual_select_group, GLX_SGI_make_current_read, 
    GLX_SGI_swap_control, GLX_SGI_video_sync
GLX version: 1.4
GLX extensions:
    GLX_ARB_create_context, GLX_ARB_create_context_profile, 
    GLX_ARB_create_context_robustness, GLX_ARB_fbconfig_float, 
    GLX_ARB_framebuffer_sRGB, GLX_ARB_get_proc_address, GLX_ARB_multisample, 
    GLX_EXT_buffer_age, GLX_EXT_create_context_es2_profile, 
    GLX_EXT_create_context_es_profile, GLX_EXT_fbconfig_packed_float, 
    GLX_EXT_framebuffer_sRGB, GLX_EXT_import_context, 
    GLX_EXT_texture_from_pixmap, GLX_EXT_visual_info, GLX_EXT_visual_rating, 
    GLX_INTEL_swap_event, GLX_MESA_copy_sub_buffer, 
    GLX_MESA_multithread_makecurrent, GLX_MESA_query_renderer, 
    GLX_MESA_swap_control, GLX_OML_swap_method, GLX_OML_sync_control, 
    GLX_SGIS_multisample, GLX_SGIX_fbconfig, GLX_SGIX_pbuffer, 
    GLX_SGIX_visual_select_group, GLX_SGI_make_current_read, 
    GLX_SGI_swap_control, GLX_SGI_video_sync
Extended renderer info (GLX_MESA_query_renderer):
    Vendor: X.Org (0x1002)
    Device: AMD KAVERI (DRM 3.18.0 / 4.13.8-gentoo, LLVM 5.0.0) (0x130f)
    Version: 17.2.3
    Accelerated: yes
    Video memory: 994MB
    Unified memory: no
    Preferred profile: core (0x1)
    Max core profile version: 4.5
    Max compat profile version: 3.0
    Max GLES1 profile version: 1.1
    Max GLES[23] profile version: 3.1
OpenGL vendor string: X.Org
OpenGL renderer string: AMD KAVERI (DRM 3.18.0 / 4.13.8-gentoo, LLVM 5.0.0)
OpenGL core profile version string: 4.5 (Core Profile) Mesa 17.2.3
OpenGL core profile shading language version string: 4.50
OpenGL core profile context flags: (none)
OpenGL core profile profile mask: core profile
OpenGL core profile extensions:
    GL_AMD_conservative_depth, GL_AMD_draw_buffers_blend, 
    GL_AMD_performance_monitor, GL_AMD_pinned_memory, 
    GL_AMD_seamless_cubemap_per_texture, GL_AMD_shader_stencil_export, 
    GL_AMD_shader_trinary_minmax, GL_AMD_vertex_shader_layer, 
    GL_AMD_vertex_shader_viewport_index, GL_ANGLE_texture_compression_dxt3, 
    GL_ANGLE_texture_compression_dxt5, GL_ARB_ES2_compatibility, 
    GL_ARB_ES3_1_compatibility, GL_ARB_ES3_2_compatibility, 
    GL_ARB_ES3_compatibility, GL_ARB_arrays_of_arrays, GL_ARB_base_instance, 
    GL_ARB_bindless_texture, GL_ARB_blend_func_extended, 
    GL_ARB_buffer_storage, GL_ARB_clear_buffer_object, GL_ARB_clear_texture, 
    GL_ARB_clip_control, GL_ARB_color_buffer_float, 
    GL_ARB_compressed_texture_pixel_storage, GL_ARB_compute_shader, 
    GL_ARB_compute_variable_group_size, GL_ARB_conditional_render_inverted, 
    GL_ARB_conservative_depth, GL_ARB_copy_buffer, GL_ARB_copy_image, 
    GL_ARB_cull_distance, GL_ARB_debug_output, GL_ARB_depth_buffer_float, 
    GL_ARB_depth_clamp, GL_ARB_derivative_control, GL_ARB_direct_state_access, 
    GL_ARB_draw_buffers, GL_ARB_draw_buffers_blend, 
    GL_ARB_draw_elements_base_vertex, GL_ARB_draw_indirect, 
    GL_ARB_draw_instanced, GL_ARB_enhanced_layouts, 
    GL_ARB_explicit_attrib_location, GL_ARB_explicit_uniform_location, 
    GL_ARB_fragment_coord_conventions, GL_ARB_fragment_layer_viewport, 
    GL_ARB_fragment_shader, GL_ARB_framebuffer_no_attachments, 
    GL_ARB_framebuffer_object, GL_ARB_framebuffer_sRGB, 
    GL_ARB_get_program_binary, GL_ARB_get_texture_sub_image, 
    GL_ARB_gpu_shader5, GL_ARB_gpu_shader_fp64, GL_ARB_gpu_shader_int64, 
    GL_ARB_half_float_pixel, GL_ARB_half_float_vertex, 
    GL_ARB_indirect_parameters, GL_ARB_instanced_arrays, 
    GL_ARB_internalformat_query, GL_ARB_internalformat_query2, 
    GL_ARB_invalidate_subdata, GL_ARB_map_buffer_alignment, 
    GL_ARB_map_buffer_range, GL_ARB_multi_bind, GL_ARB_multi_draw_indirect, 
    GL_ARB_occlusion_query2, GL_ARB_pipeline_statistics_query, 
    GL_ARB_pixel_buffer_object, GL_ARB_point_sprite, 
    GL_ARB_program_interface_query, GL_ARB_provoking_vertex, 
    GL_ARB_query_buffer_object, GL_ARB_robust_buffer_access_behavior, 
    GL_ARB_robustness, GL_ARB_sample_shading, GL_ARB_sampler_objects, 
    GL_ARB_seamless_cube_map, GL_ARB_seamless_cubemap_per_texture, 
    GL_ARB_separate_shader_objects, GL_ARB_shader_atomic_counter_ops, 
    GL_ARB_shader_atomic_counters, GL_ARB_shader_ballot, 
    GL_ARB_shader_bit_encoding, GL_ARB_shader_clock, 
    GL_ARB_shader_draw_parameters, GL_ARB_shader_group_vote, 
    GL_ARB_shader_image_load_store, GL_ARB_shader_image_size, 
    GL_ARB_shader_objects, GL_ARB_shader_precision, 
    GL_ARB_shader_stencil_export, GL_ARB_shader_storage_buffer_object, 
    GL_ARB_shader_subroutine, GL_ARB_shader_texture_image_samples, 
    GL_ARB_shader_texture_lod, GL_ARB_shader_viewport_layer_array, 
    GL_ARB_shading_language_420pack, GL_ARB_shading_language_packing, 
    GL_ARB_sparse_buffer, GL_ARB_stencil_texturing, GL_ARB_sync, 
    GL_ARB_tessellation_shader, GL_ARB_texture_barrier, 
    GL_ARB_texture_buffer_object, GL_ARB_texture_buffer_object_rgb32, 
    GL_ARB_texture_buffer_range, GL_ARB_texture_compression_bptc, 
    GL_ARB_texture_compression_rgtc, GL_ARB_texture_cube_map_array, 
    GL_ARB_texture_float, GL_ARB_texture_gather, 
    GL_ARB_texture_mirror_clamp_to_edge, GL_ARB_texture_multisample, 
    GL_ARB_texture_non_power_of_two, GL_ARB_texture_query_levels, 
    GL_ARB_texture_query_lod, GL_ARB_texture_rectangle, GL_ARB_texture_rg, 
    GL_ARB_texture_rgb10_a2ui, GL_ARB_texture_stencil8, 
    GL_ARB_texture_storage, GL_ARB_texture_storage_multisample, 
    GL_ARB_texture_swizzle, GL_ARB_texture_view, GL_ARB_timer_query, 
    GL_ARB_transform_feedback2, GL_ARB_transform_feedback3, 
    GL_ARB_transform_feedback_instanced, GL_ARB_uniform_buffer_object, 
    GL_ARB_vertex_array_bgra, GL_ARB_vertex_array_object, 
    GL_ARB_vertex_attrib_64bit, GL_ARB_vertex_attrib_binding, 
    GL_ARB_vertex_shader, GL_ARB_vertex_type_10f_11f_11f_rev, 
    GL_ARB_vertex_type_2_10_10_10_rev, GL_ARB_viewport_array, 
    GL_ATI_blend_equation_separate, GL_ATI_meminfo, GL_ATI_texture_float, 
    GL_ATI_texture_mirror_once, GL_EXT_abgr, GL_EXT_blend_equation_separate, 
    GL_EXT_depth_bounds_test, GL_EXT_draw_buffers2, GL_EXT_draw_instanced, 
    GL_EXT_framebuffer_blit, GL_EXT_framebuffer_multisample, 
    GL_EXT_framebuffer_multisample_blit_scaled, GL_EXT_framebuffer_sRGB, 
    GL_EXT_packed_depth_stencil, GL_EXT_packed_float, 
    GL_EXT_pixel_buffer_object, GL_EXT_polygon_offset_clamp, 
    GL_EXT_provoking_vertex, GL_EXT_shader_integer_mix, GL_EXT_texture_array, 
    GL_EXT_texture_compression_dxt1, GL_EXT_texture_compression_rgtc, 
    GL_EXT_texture_compression_s3tc, GL_EXT_texture_filter_anisotropic, 
    GL_EXT_texture_integer, GL_EXT_texture_mirror_clamp, GL_EXT_texture_sRGB, 
    GL_EXT_texture_sRGB_decode, GL_EXT_texture_shared_exponent, 
    GL_EXT_texture_snorm, GL_EXT_texture_swizzle, GL_EXT_timer_query, 
    GL_EXT_transform_feedback, GL_EXT_vertex_array_bgra, 
    GL_IBM_multimode_draw_arrays, GL_KHR_context_flush_control, GL_KHR_debug, 
    GL_KHR_no_error, GL_KHR_robust_buffer_access_behavior, GL_KHR_robustness, 
    GL_MESA_pack_invert, GL_MESA_shader_integer_functions, 
    GL_MESA_texture_signed_rgba, GL_NVX_gpu_memory_info, 
    GL_NV_conditional_render, GL_NV_depth_clamp, GL_NV_packed_depth_stencil, 
    GL_NV_texture_barrier, GL_NV_vdpau_interop, GL_OES_EGL_image, GL_S3_s3tc

OpenGL version string: 3.0 Mesa 17.2.3
OpenGL shading language version string: 1.30
OpenGL context flags: (none)
OpenGL extensions:
    GL_AMD_conservative_depth, GL_AMD_draw_buffers_blend, 
    GL_AMD_performance_monitor, GL_AMD_pinned_memory, 
    GL_AMD_seamless_cubemap_per_texture, GL_AMD_shader_stencil_export, 
    GL_AMD_shader_trinary_minmax, GL_ANGLE_texture_compression_dxt3, 
    GL_ANGLE_texture_compression_dxt5, GL_APPLE_packed_pixels, 
    GL_ARB_ES2_compatibility, GL_ARB_ES3_compatibility, 
    GL_ARB_arrays_of_arrays, GL_ARB_base_instance, GL_ARB_bindless_texture, 
    GL_ARB_blend_func_extended, GL_ARB_buffer_storage, 
    GL_ARB_clear_buffer_object, GL_ARB_clear_texture, GL_ARB_clip_control, 
    GL_ARB_color_buffer_float, GL_ARB_compressed_texture_pixel_storage, 
    GL_ARB_compute_shader, GL_ARB_compute_variable_group_size, 
    GL_ARB_conditional_render_inverted, GL_ARB_conservative_depth, 
    GL_ARB_copy_buffer, GL_ARB_copy_image, GL_ARB_cull_distance, 
    GL_ARB_debug_output, GL_ARB_depth_buffer_float, GL_ARB_depth_clamp, 
    GL_ARB_depth_texture, GL_ARB_derivative_control, GL_ARB_draw_buffers, 
    GL_ARB_draw_buffers_blend, GL_ARB_draw_elements_base_vertex, 
    GL_ARB_draw_instanced, GL_ARB_explicit_attrib_location, 
    GL_ARB_explicit_uniform_location, GL_ARB_fragment_coord_conventions, 
    GL_ARB_fragment_program, GL_ARB_fragment_program_shadow, 
    GL_ARB_fragment_shader, GL_ARB_framebuffer_no_attachments, 
    GL_ARB_framebuffer_object, GL_ARB_framebuffer_sRGB, 
    GL_ARB_get_program_binary, GL_ARB_get_texture_sub_image, 
    GL_ARB_half_float_pixel, GL_ARB_half_float_vertex, 
    GL_ARB_instanced_arrays, GL_ARB_internalformat_query, 
    GL_ARB_internalformat_query2, GL_ARB_invalidate_subdata, 
    GL_ARB_map_buffer_alignment, GL_ARB_map_buffer_range, GL_ARB_multi_bind, 
    GL_ARB_multisample, GL_ARB_multitexture, GL_ARB_occlusion_query, 
    GL_ARB_occlusion_query2, GL_ARB_pipeline_statistics_query, 
    GL_ARB_pixel_buffer_object, GL_ARB_point_parameters, GL_ARB_point_sprite, 
    GL_ARB_program_interface_query, GL_ARB_provoking_vertex, 
    GL_ARB_query_buffer_object, GL_ARB_robust_buffer_access_behavior, 
    GL_ARB_robustness, GL_ARB_sample_shading, GL_ARB_sampler_objects, 
    GL_ARB_seamless_cube_map, GL_ARB_seamless_cubemap_per_texture, 
    GL_ARB_separate_shader_objects, GL_ARB_shader_atomic_counter_ops, 
    GL_ARB_shader_atomic_counters, GL_ARB_shader_ballot, 
    GL_ARB_shader_bit_encoding, GL_ARB_shader_clock, 
    GL_ARB_shader_draw_parameters, GL_ARB_shader_group_vote, 
    GL_ARB_shader_image_load_store, GL_ARB_shader_image_size, 
    GL_ARB_shader_objects, GL_ARB_shader_precision, 
    GL_ARB_shader_stencil_export, GL_ARB_shader_storage_buffer_object, 
    GL_ARB_shader_texture_image_samples, GL_ARB_shader_texture_lod, 
    GL_ARB_shading_language_100, GL_ARB_shading_language_420pack, 
    GL_ARB_shading_language_packing, GL_ARB_shadow, GL_ARB_sparse_buffer, 
    GL_ARB_stencil_texturing, GL_ARB_sync, GL_ARB_texture_barrier, 
    GL_ARB_texture_border_clamp, GL_ARB_texture_compression, 
    GL_ARB_texture_compression_bptc, GL_ARB_texture_compression_rgtc, 
    GL_ARB_texture_cube_map, GL_ARB_texture_cube_map_array, 
    GL_ARB_texture_env_add, GL_ARB_texture_env_combine, 
    GL_ARB_texture_env_crossbar, GL_ARB_texture_env_dot3, 
    GL_ARB_texture_float, GL_ARB_texture_gather, 
    GL_ARB_texture_mirror_clamp_to_edge, GL_ARB_texture_mirrored_repeat, 
    GL_ARB_texture_multisample, GL_ARB_texture_non_power_of_two, 
    GL_ARB_texture_query_levels, GL_ARB_texture_query_lod, 
    GL_ARB_texture_rectangle, GL_ARB_texture_rg, GL_ARB_texture_rgb10_a2ui, 
    GL_ARB_texture_stencil8, GL_ARB_texture_storage, 
    GL_ARB_texture_storage_multisample, GL_ARB_texture_swizzle, 
    GL_ARB_texture_view, GL_ARB_timer_query, GL_ARB_transform_feedback2, 
    GL_ARB_transform_feedback3, GL_ARB_transform_feedback_instanced, 
    GL_ARB_transpose_matrix, GL_ARB_uniform_buffer_object, 
    GL_ARB_vertex_array_bgra, GL_ARB_vertex_array_object, 
    GL_ARB_vertex_attrib_binding, GL_ARB_vertex_buffer_object, 
    GL_ARB_vertex_program, GL_ARB_vertex_shader, 
    GL_ARB_vertex_type_10f_11f_11f_rev, GL_ARB_vertex_type_2_10_10_10_rev, 
    GL_ARB_window_pos, GL_ATI_blend_equation_separate, GL_ATI_draw_buffers, 
    GL_ATI_fragment_shader, GL_ATI_meminfo, GL_ATI_separate_stencil, 
    GL_ATI_texture_compression_3dc, GL_ATI_texture_env_combine3, 
    GL_ATI_texture_float, GL_ATI_texture_mirror_once, GL_EXT_abgr, 
    GL_EXT_bgra, GL_EXT_blend_color, GL_EXT_blend_equation_separate, 
    GL_EXT_blend_func_separate, GL_EXT_blend_minmax, GL_EXT_blend_subtract, 
    GL_EXT_compiled_vertex_array, GL_EXT_copy_texture, 
    GL_EXT_depth_bounds_test, GL_EXT_draw_buffers2, GL_EXT_draw_instanced, 
    GL_EXT_draw_range_elements, GL_EXT_fog_coord, GL_EXT_framebuffer_blit, 
    GL_EXT_framebuffer_multisample, GL_EXT_framebuffer_multisample_blit_scaled, 
    GL_EXT_framebuffer_object, GL_EXT_framebuffer_sRGB, 
    GL_EXT_gpu_program_parameters, GL_EXT_multi_draw_arrays, 
    GL_EXT_packed_depth_stencil, GL_EXT_packed_float, GL_EXT_packed_pixels, 
    GL_EXT_pixel_buffer_object, GL_EXT_point_parameters, 
    GL_EXT_polygon_offset, GL_EXT_polygon_offset_clamp, 
    GL_EXT_provoking_vertex, GL_EXT_rescale_normal, GL_EXT_secondary_color, 
    GL_EXT_separate_specular_color, GL_EXT_shader_integer_mix, 
    GL_EXT_shadow_funcs, GL_EXT_stencil_two_side, GL_EXT_stencil_wrap, 
    GL_EXT_subtexture, GL_EXT_texture, GL_EXT_texture3D, 
    GL_EXT_texture_array, GL_EXT_texture_compression_dxt1, 
    GL_EXT_texture_compression_latc, GL_EXT_texture_compression_rgtc, 
    GL_EXT_texture_compression_s3tc, GL_EXT_texture_cube_map, 
    GL_EXT_texture_edge_clamp, GL_EXT_texture_env_add, 
    GL_EXT_texture_env_combine, GL_EXT_texture_env_dot3, 
    GL_EXT_texture_filter_anisotropic, GL_EXT_texture_integer, 
    GL_EXT_texture_lod_bias, GL_EXT_texture_mirror_clamp, 
    GL_EXT_texture_object, GL_EXT_texture_rectangle, GL_EXT_texture_sRGB, 
    GL_EXT_texture_sRGB_decode, GL_EXT_texture_shared_exponent, 
    GL_EXT_texture_snorm, GL_EXT_texture_swizzle, GL_EXT_timer_query, 
    GL_EXT_transform_feedback, GL_EXT_vertex_array, GL_EXT_vertex_array_bgra, 
    GL_IBM_multimode_draw_arrays, GL_IBM_rasterpos_clip, 
    GL_IBM_texture_mirrored_repeat, GL_INGR_blend_func_separate, 
    GL_KHR_context_flush_control, GL_KHR_debug, GL_KHR_no_error, 
    GL_KHR_robust_buffer_access_behavior, GL_KHR_robustness, 
    GL_MESA_pack_invert, GL_MESA_shader_integer_functions, 
    GL_MESA_texture_signed_rgba, GL_MESA_window_pos, GL_NVX_gpu_memory_info, 
    GL_NV_blend_square, GL_NV_conditional_render, GL_NV_depth_clamp, 
    GL_NV_fog_distance, GL_NV_light_max_exponent, GL_NV_packed_depth_stencil, 
    GL_NV_primitive_restart, GL_NV_texgen_reflection, GL_NV_texture_barrier, 
    GL_NV_texture_env_combine4, GL_NV_texture_rectangle, GL_NV_vdpau_interop, 
    GL_OES_EGL_image, GL_OES_read_format, GL_S3_s3tc, 
    GL_SGIS_generate_mipmap, GL_SGIS_texture_border_clamp, 
    GL_SGIS_texture_edge_clamp, GL_SGIS_texture_lod, GL_SUN_multi_draw_arrays

OpenGL ES profile version string: OpenGL ES 3.1 Mesa 17.2.3
OpenGL ES profile shading language version string: OpenGL ES GLSL ES 3.10
OpenGL ES profile extensions:
    GL_ANGLE_texture_compression_dxt3, GL_ANGLE_texture_compression_dxt5, 
    GL_APPLE_texture_max_level, GL_EXT_base_instance, 
    GL_EXT_blend_func_extended, GL_EXT_blend_minmax, GL_EXT_buffer_storage, 
    GL_EXT_clip_cull_distance, GL_EXT_color_buffer_float, 
    GL_EXT_compressed_ETC1_RGB8_sub_texture, GL_EXT_copy_image, 
    GL_EXT_discard_framebuffer, GL_EXT_draw_buffers, 
    GL_EXT_draw_buffers_indexed, GL_EXT_draw_elements_base_vertex, 
    GL_EXT_frag_depth, GL_EXT_geometry_point_size, GL_EXT_geometry_shader, 
    GL_EXT_gpu_shader5, GL_EXT_map_buffer_range, GL_EXT_multi_draw_arrays, 
    GL_EXT_polygon_offset_clamp, GL_EXT_primitive_bounding_box, 
    GL_EXT_read_format_bgra, GL_EXT_robustness, 
    GL_EXT_separate_shader_objects, GL_EXT_shader_integer_mix, 
    GL_EXT_shader_io_blocks, GL_EXT_tessellation_point_size, 
    GL_EXT_tessellation_shader, GL_EXT_texture_border_clamp, 
    GL_EXT_texture_buffer, GL_EXT_texture_compression_dxt1, 
    GL_EXT_texture_cube_map_array, GL_EXT_texture_filter_anisotropic, 
    GL_EXT_texture_format_BGRA8888, GL_EXT_texture_rg, 
    GL_EXT_texture_sRGB_decode, GL_EXT_texture_type_2_10_10_10_REV, 
    GL_EXT_unpack_subimage, GL_KHR_context_flush_control, GL_KHR_debug, 
    GL_KHR_no_error, GL_KHR_robust_buffer_access_behavior, GL_KHR_robustness, 
    GL_MESA_shader_integer_functions, GL_NV_draw_buffers, 
    GL_NV_fbo_color_attachments, GL_NV_image_formats, GL_NV_read_buffer, 
    GL_NV_read_depth, GL_NV_read_depth_stencil, GL_NV_read_stencil, 
    GL_OES_EGL_image, GL_OES_EGL_image_external, GL_OES_EGL_sync, 
    GL_OES_compressed_ETC1_RGB8_texture, GL_OES_copy_image, GL_OES_depth24, 
    GL_OES_depth_texture, GL_OES_depth_texture_cube_map, 
    GL_OES_draw_buffers_indexed, GL_OES_draw_elements_base_vertex, 
    GL_OES_element_index_uint, GL_OES_fbo_render_mipmap, 
    GL_OES_geometry_point_size, GL_OES_geometry_shader, 
    GL_OES_get_program_binary, GL_OES_gpu_shader5, GL_OES_mapbuffer, 
    GL_OES_packed_depth_stencil, GL_OES_primitive_bounding_box, 
    GL_OES_rgb8_rgba8, GL_OES_sample_shading, GL_OES_sample_variables, 
    GL_OES_shader_image_atomic, GL_OES_shader_io_blocks, 
    GL_OES_shader_multisample_interpolation, GL_OES_standard_derivatives, 
    GL_OES_stencil8, GL_OES_surfaceless_context, 
    GL_OES_tessellation_point_size, GL_OES_tessellation_shader, 
    GL_OES_texture_3D, GL_OES_texture_border_clamp, GL_OES_texture_buffer, 
    GL_OES_texture_cube_map_array, GL_OES_texture_float, 
    GL_OES_texture_float_linear, GL_OES_texture_half_float, 
    GL_OES_texture_half_float_linear, GL_OES_texture_npot, 
    GL_OES_texture_stencil8, GL_OES_texture_storage_multisample_2d_array, 
    GL_OES_vertex_array_object, GL_OES_vertex_half_float, 
    GL_OES_viewport_array

480 GLX Visuals
    visual  x   bf lv rg d st  colorbuffer  sr ax dp st accumbuffer  ms  cav
  id dep cl sp  sz l  ci b ro  r  g  b  a F gb bf th cl  r  g  b  a ns b eat
----------------------------------------------------------------------------
0x021 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 24  8  0  0  0  0  0 0 None
0x022 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 24  8  0  0  0  0  0 0 None
0x2d1 24 tc  0  32  0 r  . .   8  8  8  8 .  .  0  0  0  0  0  0  0  0 0 None
0x2d2 24 tc  0  32  0 r  . .   8  8  8  8 .  .  0  0  0 16 16 16 16  0 0 Slow
0x2d3 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0  0  0  0  0  0  0  0 0 None
0x2d4 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0  0  0 16 16 16 16  0 0 Slow
0x2d5 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0  0  0  0  0  0  0  0 0 None
0x2d6 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0  0  0 16 16 16 16  0 0 Slow
0x2d7 24 tc  0  32  0 r  . .   8  8  8  8 .  .  0 16  0  0  0  0  0  0 0 None
0x2d8 24 tc  0  32  0 r  . .   8  8  8  8 .  .  0 16  0 16 16 16 16  0 0 Slow
0x2d9 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 16  0  0  0  0  0  0 0 None
0x2da 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 16  0 16 16 16 16  0 0 Slow
0x2db 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 16  0  0  0  0  0  0 0 None
0x2dc 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 16  0 16 16 16 16  0 0 Slow
0x2dd 24 tc  0  32  0 r  . .   8  8  8  8 .  .  0 24  0  0  0  0  0  0 0 None
0x2de 24 tc  0  32  0 r  . .   8  8  8  8 .  .  0 24  0 16 16 16 16  0 0 Slow
0x2df 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 24  0  0  0  0  0  0 0 None
0x2e0 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 24  0 16 16 16 16  0 0 Slow
0x2e1 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 24  0  0  0  0  0  0 0 None
0x2e2 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 24  0 16 16 16 16  0 0 Slow
0x2e3 24 tc  0  32  0 r  . .   8  8  8  8 .  .  0 24  8  0  0  0  0  0 0 None
0x2e4 24 tc  0  32  0 r  . .   8  8  8  8 .  .  0 24  8 16 16 16 16  0 0 Slow
0x2e5 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 24  8 16 16 16 16  0 0 Slow
0x2e6 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 24  8 16 16 16 16  0 0 Slow
0x2e7 24 tc  0  32  0 r  . .   8  8  8  8 .  .  0  0  0  0  0  0  0  2 1 None
0x2e8 24 tc  0  32  0 r  . .   8  8  8  8 .  .  0  0  0  0  0  0  0  4 1 None
0x2e9 24 tc  0  32  0 r  . .   8  8  8  8 .  .  0  0  0  0  0  0  0  8 1 None
0x2ea 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0  0  0  0  0  0  0  2 1 None
0x2eb 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0  0  0  0  0  0  0  4 1 None
0x2ec 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0  0  0  0  0  0  0  8 1 None
0x2ed 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0  0  0  0  0  0  0  2 1 None
0x2ee 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0  0  0  0  0  0  0  4 1 None
0x2ef 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0  0  0  0  0  0  0  8 1 None
0x2f0 24 tc  0  32  0 r  . .   8  8  8  8 .  .  0 16  0  0  0  0  0  2 1 None
0x2f1 24 tc  0  32  0 r  . .   8  8  8  8 .  .  0 16  0  0  0  0  0  4 1 None
0x2f2 24 tc  0  32  0 r  . .   8  8  8  8 .  .  0 16  0  0  0  0  0  8 1 None
0x2f3 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 16  0  0  0  0  0  2 1 None
0x2f4 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 16  0  0  0  0  0  4 1 None
0x2f5 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 16  0  0  0  0  0  8 1 None
0x2f6 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 16  0  0  0  0  0  2 1 None
0x2f7 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 16  0  0  0  0  0  4 1 None
0x2f8 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 16  0  0  0  0  0  8 1 None
0x2f9 24 tc  0  32  0 r  . .   8  8  8  8 .  .  0 24  0  0  0  0  0  2 1 None
0x2fa 24 tc  0  32  0 r  . .   8  8  8  8 .  .  0 24  0  0  0  0  0  4 1 None
0x2fb 24 tc  0  32  0 r  . .   8  8  8  8 .  .  0 24  0  0  0  0  0  8 1 None
0x2fc 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 24  0  0  0  0  0  2 1 None
0x2fd 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 24  0  0  0  0  0  4 1 None
0x2fe 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 24  0  0  0  0  0  8 1 None
0x2ff 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 24  0  0  0  0  0  2 1 None
0x300 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 24  0  0  0  0  0  4 1 None
0x301 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 24  0  0  0  0  0  8 1 None
0x302 24 tc  0  32  0 r  . .   8  8  8  8 .  .  0 24  8  0  0  0  0  2 1 None
0x303 24 tc  0  32  0 r  . .   8  8  8  8 .  .  0 24  8  0  0  0  0  4 1 None
0x304 24 tc  0  32  0 r  . .   8  8  8  8 .  .  0 24  8  0  0  0  0  8 1 None
0x305 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 24  8  0  0  0  0  2 1 None
0x306 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 24  8  0  0  0  0  4 1 None
0x307 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 24  8  0  0  0  0  8 1 None
0x308 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 24  8  0  0  0  0  2 1 None
0x309 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 24  8  0  0  0  0  4 1 None
0x30a 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 24  8  0  0  0  0  8 1 None
0x30b 24 tc  0  24  0 r  . .   8  8  8  0 .  .  0  0  0  0  0  0  0  0 0 None
0x30c 24 tc  0  24  0 r  . .   8  8  8  0 .  .  0  0  0 16 16 16  0  0 0 Slow
0x30d 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0  0  0  0  0  0  0  0 0 None
0x30e 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0  0  0 16 16 16  0  0 0 Slow
0x30f 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0  0  0  0  0  0  0  0 0 None
0x310 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0  0  0 16 16 16  0  0 0 Slow
0x311 24 tc  0  24  0 r  . .   8  8  8  0 .  .  0 16  0  0  0  0  0  0 0 None
0x312 24 tc  0  24  0 r  . .   8  8  8  0 .  .  0 16  0 16 16 16  0  0 0 Slow
0x313 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 16  0  0  0  0  0  0 0 None
0x314 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 16  0 16 16 16  0  0 0 Slow
0x315 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 16  0  0  0  0  0  0 0 None
0x316 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 16  0 16 16 16  0  0 0 Slow
0x317 24 tc  0  24  0 r  . .   8  8  8  0 .  .  0 24  0  0  0  0  0  0 0 None
0x318 24 tc  0  24  0 r  . .   8  8  8  0 .  .  0 24  0 16 16 16  0  0 0 Slow
0x319 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 24  0  0  0  0  0  0 0 None
0x31a 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 24  0 16 16 16  0  0 0 Slow
0x31b 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 24  0  0  0  0  0  0 0 None
0x31c 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 24  0 16 16 16  0  0 0 Slow
0x31d 24 tc  0  24  0 r  . .   8  8  8  0 .  .  0 24  8  0  0  0  0  0 0 None
0x31e 24 tc  0  24  0 r  . .   8  8  8  0 .  .  0 24  8 16 16 16  0  0 0 Slow
0x31f 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 24  8  0  0  0  0  0 0 None
0x320 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 24  8 16 16 16  0  0 0 Slow
0x321 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 24  8  0  0  0  0  0 0 None
0x322 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 24  8 16 16 16  0  0 0 Slow
0x323 24 tc  0  24  0 r  . .   8  8  8  0 .  .  0  0  0  0  0  0  0  2 1 None
0x324 24 tc  0  24  0 r  . .   8  8  8  0 .  .  0  0  0  0  0  0  0  4 1 None
0x325 24 tc  0  24  0 r  . .   8  8  8  0 .  .  0  0  0  0  0  0  0  8 1 None
0x326 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0  0  0  0  0  0  0  2 1 None
0x327 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0  0  0  0  0  0  0  4 1 None
0x328 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0  0  0  0  0  0  0  8 1 None
0x329 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0  0  0  0  0  0  0  2 1 None
0x32a 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0  0  0  0  0  0  0  4 1 None
0x32b 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0  0  0  0  0  0  0  8 1 None
0x32c 24 tc  0  24  0 r  . .   8  8  8  0 .  .  0 16  0  0  0  0  0  2 1 None
0x32d 24 tc  0  24  0 r  . .   8  8  8  0 .  .  0 16  0  0  0  0  0  4 1 None
0x32e 24 tc  0  24  0 r  . .   8  8  8  0 .  .  0 16  0  0  0  0  0  8 1 None
0x32f 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 16  0  0  0  0  0  2 1 None
0x330 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 16  0  0  0  0  0  4 1 None
0x331 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 16  0  0  0  0  0  8 1 None
0x332 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 16  0  0  0  0  0  2 1 None
0x333 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 16  0  0  0  0  0  4 1 None
0x334 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 16  0  0  0  0  0  8 1 None
0x335 24 tc  0  24  0 r  . .   8  8  8  0 .  .  0 24  0  0  0  0  0  2 1 None
0x336 24 tc  0  24  0 r  . .   8  8  8  0 .  .  0 24  0  0  0  0  0  4 1 None
0x337 24 tc  0  24  0 r  . .   8  8  8  0 .  .  0 24  0  0  0  0  0  8 1 None
0x338 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 24  0  0  0  0  0  2 1 None
0x339 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 24  0  0  0  0  0  4 1 None
0x33a 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 24  0  0  0  0  0  8 1 None
0x33b 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 24  0  0  0  0  0  2 1 None
0x33c 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 24  0  0  0  0  0  4 1 None
0x33d 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 24  0  0  0  0  0  8 1 None
0x33e 24 tc  0  24  0 r  . .   8  8  8  0 .  .  0 24  8  0  0  0  0  2 1 None
0x33f 24 tc  0  24  0 r  . .   8  8  8  0 .  .  0 24  8  0  0  0  0  4 1 None
0x340 24 tc  0  24  0 r  . .   8  8  8  0 .  .  0 24  8  0  0  0  0  8 1 None
0x341 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 24  8  0  0  0  0  2 1 None
0x342 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 24  8  0  0  0  0  4 1 None
0x343 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 24  8  0  0  0  0  8 1 None
0x344 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 24  8  0  0  0  0  2 1 None
0x345 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 24  8  0  0  0  0  4 1 None
0x346 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 24  8  0  0  0  0  8 1 None
0x347 24 tc  0  32  0 r  . .   8  8  8  8 .  s  0  0  0  0  0  0  0  0 0 None
0x348 24 tc  0  32  0 r  . .   8  8  8  8 .  s  0  0  0 16 16 16 16  0 0 Slow
0x349 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0  0  0  0  0  0  0  0 0 None
0x34a 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0  0  0 16 16 16 16  0 0 Slow
0x34b 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0  0  0  0  0  0  0  0 0 None
0x34c 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0  0  0 16 16 16 16  0 0 Slow
0x34d 24 tc  0  32  0 r  . .   8  8  8  8 .  s  0 16  0  0  0  0  0  0 0 None
0x34e 24 tc  0  32  0 r  . .   8  8  8  8 .  s  0 16  0 16 16 16 16  0 0 Slow
0x34f 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 16  0  0  0  0  0  0 0 None
0x350 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 16  0 16 16 16 16  0 0 Slow
0x351 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 16  0  0  0  0  0  0 0 None
0x352 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 16  0 16 16 16 16  0 0 Slow
0x353 24 tc  0  32  0 r  . .   8  8  8  8 .  s  0 24  0  0  0  0  0  0 0 None
0x354 24 tc  0  32  0 r  . .   8  8  8  8 .  s  0 24  0 16 16 16 16  0 0 Slow
0x355 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 24  0  0  0  0  0  0 0 None
0x356 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 24  0 16 16 16 16  0 0 Slow
0x357 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 24  0  0  0  0  0  0 0 None
0x358 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 24  0 16 16 16 16  0 0 Slow
0x359 24 tc  0  32  0 r  . .   8  8  8  8 .  s  0 24  8  0  0  0  0  0 0 None
0x35a 24 tc  0  32  0 r  . .   8  8  8  8 .  s  0 24  8 16 16 16 16  0 0 Slow
0x35b 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 24  8  0  0  0  0  0 0 None
0x35c 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 24  8 16 16 16 16  0 0 Slow
0x35d 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 24  8  0  0  0  0  0 0 None
0x35e 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 24  8 16 16 16 16  0 0 Slow
0x35f 24 tc  0  32  0 r  . .   8  8  8  8 .  s  0  0  0  0  0  0  0  2 1 None
0x360 24 tc  0  32  0 r  . .   8  8  8  8 .  s  0  0  0  0  0  0  0  4 1 None
0x361 24 tc  0  32  0 r  . .   8  8  8  8 .  s  0  0  0  0  0  0  0  8 1 None
0x362 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0  0  0  0  0  0  0  2 1 None
0x363 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0  0  0  0  0  0  0  4 1 None
0x364 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0  0  0  0  0  0  0  8 1 None
0x365 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0  0  0  0  0  0  0  2 1 None
0x366 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0  0  0  0  0  0  0  4 1 None
0x367 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0  0  0  0  0  0  0  8 1 None
0x368 24 tc  0  32  0 r  . .   8  8  8  8 .  s  0 16  0  0  0  0  0  2 1 None
0x369 24 tc  0  32  0 r  . .   8  8  8  8 .  s  0 16  0  0  0  0  0  4 1 None
0x36a 24 tc  0  32  0 r  . .   8  8  8  8 .  s  0 16  0  0  0  0  0  8 1 None
0x36b 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 16  0  0  0  0  0  2 1 None
0x36c 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 16  0  0  0  0  0  4 1 None
0x36d 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 16  0  0  0  0  0  8 1 None
0x36e 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 16  0  0  0  0  0  2 1 None
0x36f 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 16  0  0  0  0  0  4 1 None
0x370 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 16  0  0  0  0  0  8 1 None
0x371 24 tc  0  32  0 r  . .   8  8  8  8 .  s  0 24  0  0  0  0  0  2 1 None
0x372 24 tc  0  32  0 r  . .   8  8  8  8 .  s  0 24  0  0  0  0  0  4 1 None
0x373 24 tc  0  32  0 r  . .   8  8  8  8 .  s  0 24  0  0  0  0  0  8 1 None
0x374 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 24  0  0  0  0  0  2 1 None
0x375 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 24  0  0  0  0  0  4 1 None
0x376 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 24  0  0  0  0  0  8 1 None
0x377 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 24  0  0  0  0  0  2 1 None
0x378 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 24  0  0  0  0  0  4 1 None
0x379 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 24  0  0  0  0  0  8 1 None
0x37a 24 tc  0  32  0 r  . .   8  8  8  8 .  s  0 24  8  0  0  0  0  2 1 None
0x37b 24 tc  0  32  0 r  . .   8  8  8  8 .  s  0 24  8  0  0  0  0  4 1 None
0x37c 24 tc  0  32  0 r  . .   8  8  8  8 .  s  0 24  8  0  0  0  0  8 1 None
0x37d 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 24  8  0  0  0  0  2 1 None
0x37e 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 24  8  0  0  0  0  4 1 None
0x37f 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 24  8  0  0  0  0  8 1 None
0x380 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 24  8  0  0  0  0  2 1 None
0x381 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 24  8  0  0  0  0  4 1 None
0x382 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 24  8  0  0  0  0  8 1 None
0x383 24 tc  0  24  0 r  . .   8  8  8  0 .  s  0  0  0  0  0  0  0  0 0 None
0x384 24 tc  0  24  0 r  . .   8  8  8  0 .  s  0  0  0 16 16 16  0  0 0 Slow
0x385 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0  0  0  0  0  0  0  0 0 None
0x386 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0  0  0 16 16 16  0  0 0 Slow
0x387 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0  0  0  0  0  0  0  0 0 None
0x388 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0  0  0 16 16 16  0  0 0 Slow
0x389 24 tc  0  24  0 r  . .   8  8  8  0 .  s  0 16  0  0  0  0  0  0 0 None
0x38a 24 tc  0  24  0 r  . .   8  8  8  0 .  s  0 16  0 16 16 16  0  0 0 Slow
0x38b 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 16  0  0  0  0  0  0 0 None
0x38c 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 16  0 16 16 16  0  0 0 Slow
0x38d 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 16  0  0  0  0  0  0 0 None
0x38e 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 16  0 16 16 16  0  0 0 Slow
0x38f 24 tc  0  24  0 r  . .   8  8  8  0 .  s  0 24  0  0  0  0  0  0 0 None
0x390 24 tc  0  24  0 r  . .   8  8  8  0 .  s  0 24  0 16 16 16  0  0 0 Slow
0x391 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 24  0  0  0  0  0  0 0 None
0x392 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 24  0 16 16 16  0  0 0 Slow
0x393 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 24  0  0  0  0  0  0 0 None
0x394 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 24  0 16 16 16  0  0 0 Slow
0x395 24 tc  0  24  0 r  . .   8  8  8  0 .  s  0 24  8  0  0  0  0  0 0 None
0x396 24 tc  0  24  0 r  . .   8  8  8  0 .  s  0 24  8 16 16 16  0  0 0 Slow
0x397 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 24  8  0  0  0  0  0 0 None
0x398 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 24  8 16 16 16  0  0 0 Slow
0x399 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 24  8  0  0  0  0  0 0 None
0x39a 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 24  8 16 16 16  0  0 0 Slow
0x39b 24 tc  0  24  0 r  . .   8  8  8  0 .  s  0  0  0  0  0  0  0  2 1 None
0x39c 24 tc  0  24  0 r  . .   8  8  8  0 .  s  0  0  0  0  0  0  0  4 1 None
0x39d 24 tc  0  24  0 r  . .   8  8  8  0 .  s  0  0  0  0  0  0  0  8 1 None
0x39e 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0  0  0  0  0  0  0  2 1 None
0x39f 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0  0  0  0  0  0  0  4 1 None
0x3a0 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0  0  0  0  0  0  0  8 1 None
0x3a1 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0  0  0  0  0  0  0  2 1 None
0x3a2 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0  0  0  0  0  0  0  4 1 None
0x3a3 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0  0  0  0  0  0  0  8 1 None
0x3a4 24 tc  0  24  0 r  . .   8  8  8  0 .  s  0 16  0  0  0  0  0  2 1 None
0x3a5 24 tc  0  24  0 r  . .   8  8  8  0 .  s  0 16  0  0  0  0  0  4 1 None
0x3a6 24 tc  0  24  0 r  . .   8  8  8  0 .  s  0 16  0  0  0  0  0  8 1 None
0x3a7 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 16  0  0  0  0  0  2 1 None
0x3a8 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 16  0  0  0  0  0  4 1 None
0x3a9 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 16  0  0  0  0  0  8 1 None
0x3aa 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 16  0  0  0  0  0  2 1 None
0x3ab 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 16  0  0  0  0  0  4 1 None
0x3ac 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 16  0  0  0  0  0  8 1 None
0x3ad 24 tc  0  24  0 r  . .   8  8  8  0 .  s  0 24  0  0  0  0  0  2 1 None
0x3ae 24 tc  0  24  0 r  . .   8  8  8  0 .  s  0 24  0  0  0  0  0  4 1 None
0x3af 24 tc  0  24  0 r  . .   8  8  8  0 .  s  0 24  0  0  0  0  0  8 1 None
0x3b0 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 24  0  0  0  0  0  2 1 None
0x3b1 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 24  0  0  0  0  0  4 1 None
0x3b2 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 24  0  0  0  0  0  8 1 None
0x3b3 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 24  0  0  0  0  0  2 1 None
0x3b4 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 24  0  0  0  0  0  4 1 None
0x3b5 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 24  0  0  0  0  0  8 1 None
0x3b6 24 tc  0  24  0 r  . .   8  8  8  0 .  s  0 24  8  0  0  0  0  2 1 None
0x3b7 24 tc  0  24  0 r  . .   8  8  8  0 .  s  0 24  8  0  0  0  0  4 1 None
0x3b8 24 tc  0  24  0 r  . .   8  8  8  0 .  s  0 24  8  0  0  0  0  8 1 None
0x3b9 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 24  8  0  0  0  0  2 1 None
0x3ba 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 24  8  0  0  0  0  4 1 None
0x3bb 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 24  8  0  0  0  0  8 1 None
0x3bc 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 24  8  0  0  0  0  2 1 None
0x3bd 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 24  8  0  0  0  0  4 1 None
0x3be 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 24  8  0  0  0  0  8 1 None
0x3bf 24 dc  0  32  0 r  . .   8  8  8  8 .  .  0  0  0  0  0  0  0  0 0 None
0x3c0 24 dc  0  32  0 r  . .   8  8  8  8 .  .  0  0  0 16 16 16 16  0 0 Slow
0x3c1 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0  0  0  0  0  0  0  0 0 None
0x3c2 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0  0  0 16 16 16 16  0 0 Slow
0x3c3 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0  0  0  0  0  0  0  0 0 None
0x3c4 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0  0  0 16 16 16 16  0 0 Slow
0x3c5 24 dc  0  32  0 r  . .   8  8  8  8 .  .  0 16  0  0  0  0  0  0 0 None
0x3c6 24 dc  0  32  0 r  . .   8  8  8  8 .  .  0 16  0 16 16 16 16  0 0 Slow
0x3c7 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 16  0  0  0  0  0  0 0 None
0x3c8 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 16  0 16 16 16 16  0 0 Slow
0x3c9 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 16  0  0  0  0  0  0 0 None
0x3ca 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 16  0 16 16 16 16  0 0 Slow
0x3cb 24 dc  0  32  0 r  . .   8  8  8  8 .  .  0 24  0  0  0  0  0  0 0 None
0x3cc 24 dc  0  32  0 r  . .   8  8  8  8 .  .  0 24  0 16 16 16 16  0 0 Slow
0x3cd 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 24  0  0  0  0  0  0 0 None
0x3ce 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 24  0 16 16 16 16  0 0 Slow
0x3cf 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 24  0  0  0  0  0  0 0 None
0x3d0 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 24  0 16 16 16 16  0 0 Slow
0x3d1 24 dc  0  32  0 r  . .   8  8  8  8 .  .  0 24  8  0  0  0  0  0 0 None
0x3d2 24 dc  0  32  0 r  . .   8  8  8  8 .  .  0 24  8 16 16 16 16  0 0 Slow
0x3d3 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 24  8 16 16 16 16  0 0 Slow
0x3d4 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 24  8  0  0  0  0  0 0 None
0x3d5 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 24  8 16 16 16 16  0 0 Slow
0x3d6 24 dc  0  32  0 r  . .   8  8  8  8 .  .  0  0  0  0  0  0  0  2 1 None
0x3d7 24 dc  0  32  0 r  . .   8  8  8  8 .  .  0  0  0  0  0  0  0  4 1 None
0x3d8 24 dc  0  32  0 r  . .   8  8  8  8 .  .  0  0  0  0  0  0  0  8 1 None
0x3d9 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0  0  0  0  0  0  0  2 1 None
0x3da 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0  0  0  0  0  0  0  4 1 None
0x3db 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0  0  0  0  0  0  0  8 1 None
0x3dc 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0  0  0  0  0  0  0  2 1 None
0x3dd 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0  0  0  0  0  0  0  4 1 None
0x3de 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0  0  0  0  0  0  0  8 1 None
0x3df 24 dc  0  32  0 r  . .   8  8  8  8 .  .  0 16  0  0  0  0  0  2 1 None
0x3e0 24 dc  0  32  0 r  . .   8  8  8  8 .  .  0 16  0  0  0  0  0  4 1 None
0x3e1 24 dc  0  32  0 r  . .   8  8  8  8 .  .  0 16  0  0  0  0  0  8 1 None
0x3e2 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 16  0  0  0  0  0  2 1 None
0x3e3 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 16  0  0  0  0  0  4 1 None
0x3e4 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 16  0  0  0  0  0  8 1 None
0x3e5 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 16  0  0  0  0  0  2 1 None
0x3e6 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 16  0  0  0  0  0  4 1 None
0x3e7 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 16  0  0  0  0  0  8 1 None
0x3e8 24 dc  0  32  0 r  . .   8  8  8  8 .  .  0 24  0  0  0  0  0  2 1 None
0x3e9 24 dc  0  32  0 r  . .   8  8  8  8 .  .  0 24  0  0  0  0  0  4 1 None
0x3ea 24 dc  0  32  0 r  . .   8  8  8  8 .  .  0 24  0  0  0  0  0  8 1 None
0x3eb 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 24  0  0  0  0  0  2 1 None
0x3ec 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 24  0  0  0  0  0  4 1 None
0x3ed 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 24  0  0  0  0  0  8 1 None
0x3ee 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 24  0  0  0  0  0  2 1 None
0x3ef 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 24  0  0  0  0  0  4 1 None
0x3f0 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 24  0  0  0  0  0  8 1 None
0x3f1 24 dc  0  32  0 r  . .   8  8  8  8 .  .  0 24  8  0  0  0  0  2 1 None
0x3f2 24 dc  0  32  0 r  . .   8  8  8  8 .  .  0 24  8  0  0  0  0  4 1 None
0x3f3 24 dc  0  32  0 r  . .   8  8  8  8 .  .  0 24  8  0  0  0  0  8 1 None
0x3f4 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 24  8  0  0  0  0  2 1 None
0x3f5 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 24  8  0  0  0  0  4 1 None
0x3f6 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 24  8  0  0  0  0  8 1 None
0x3f7 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 24  8  0  0  0  0  2 1 None
0x3f8 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 24  8  0  0  0  0  4 1 None
0x3f9 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 24  8  0  0  0  0  8 1 None
0x3fa 24 dc  0  24  0 r  . .   8  8  8  0 .  .  0  0  0  0  0  0  0  0 0 None
0x3fb 24 dc  0  24  0 r  . .   8  8  8  0 .  .  0  0  0 16 16 16  0  0 0 Slow
0x3fc 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0  0  0  0  0  0  0  0 0 None
0x3fd 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0  0  0 16 16 16  0  0 0 Slow
0x3fe 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0  0  0  0  0  0  0  0 0 None
0x3ff 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0  0  0 16 16 16  0  0 0 Slow
0x400 24 dc  0  24  0 r  . .   8  8  8  0 .  .  0 16  0  0  0  0  0  0 0 None
0x401 24 dc  0  24  0 r  . .   8  8  8  0 .  .  0 16  0 16 16 16  0  0 0 Slow
0x402 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 16  0  0  0  0  0  0 0 None
0x403 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 16  0 16 16 16  0  0 0 Slow
0x404 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 16  0  0  0  0  0  0 0 None
0x405 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 16  0 16 16 16  0  0 0 Slow
0x406 24 dc  0  24  0 r  . .   8  8  8  0 .  .  0 24  0  0  0  0  0  0 0 None
0x407 24 dc  0  24  0 r  . .   8  8  8  0 .  .  0 24  0 16 16 16  0  0 0 Slow
0x408 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 24  0  0  0  0  0  0 0 None
0x409 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 24  0 16 16 16  0  0 0 Slow
0x40a 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 24  0  0  0  0  0  0 0 None
0x40b 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 24  0 16 16 16  0  0 0 Slow
0x40c 24 dc  0  24  0 r  . .   8  8  8  0 .  .  0 24  8  0  0  0  0  0 0 None
0x40d 24 dc  0  24  0 r  . .   8  8  8  0 .  .  0 24  8 16 16 16  0  0 0 Slow
0x40e 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 24  8  0  0  0  0  0 0 None
0x40f 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 24  8 16 16 16  0  0 0 Slow
0x410 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 24  8  0  0  0  0  0 0 None
0x411 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 24  8 16 16 16  0  0 0 Slow
0x412 24 dc  0  24  0 r  . .   8  8  8  0 .  .  0  0  0  0  0  0  0  2 1 None
0x413 24 dc  0  24  0 r  . .   8  8  8  0 .  .  0  0  0  0  0  0  0  4 1 None
0x414 24 dc  0  24  0 r  . .   8  8  8  0 .  .  0  0  0  0  0  0  0  8 1 None
0x415 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0  0  0  0  0  0  0  2 1 None
0x416 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0  0  0  0  0  0  0  4 1 None
0x417 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0  0  0  0  0  0  0  8 1 None
0x418 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0  0  0  0  0  0  0  2 1 None
0x419 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0  0  0  0  0  0  0  4 1 None
0x41a 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0  0  0  0  0  0  0  8 1 None
0x41b 24 dc  0  24  0 r  . .   8  8  8  0 .  .  0 16  0  0  0  0  0  2 1 None
0x41c 24 dc  0  24  0 r  . .   8  8  8  0 .  .  0 16  0  0  0  0  0  4 1 None
0x41d 24 dc  0  24  0 r  . .   8  8  8  0 .  .  0 16  0  0  0  0  0  8 1 None
0x41e 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 16  0  0  0  0  0  2 1 None
0x41f 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 16  0  0  0  0  0  4 1 None
0x420 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 16  0  0  0  0  0  8 1 None
0x421 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 16  0  0  0  0  0  2 1 None
0x422 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 16  0  0  0  0  0  4 1 None
0x423 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 16  0  0  0  0  0  8 1 None
0x424 24 dc  0  24  0 r  . .   8  8  8  0 .  .  0 24  0  0  0  0  0  2 1 None
0x425 24 dc  0  24  0 r  . .   8  8  8  0 .  .  0 24  0  0  0  0  0  4 1 None
0x426 24 dc  0  24  0 r  . .   8  8  8  0 .  .  0 24  0  0  0  0  0  8 1 None
0x427 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 24  0  0  0  0  0  2 1 None
0x428 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 24  0  0  0  0  0  4 1 None
0x429 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 24  0  0  0  0  0  8 1 None
0x42a 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 24  0  0  0  0  0  2 1 None
0x42b 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 24  0  0  0  0  0  4 1 None
0x42c 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 24  0  0  0  0  0  8 1 None
0x42d 24 dc  0  24  0 r  . .   8  8  8  0 .  .  0 24  8  0  0  0  0  2 1 None
0x42e 24 dc  0  24  0 r  . .   8  8  8  0 .  .  0 24  8  0  0  0  0  4 1 None
0x42f 24 dc  0  24  0 r  . .   8  8  8  0 .  .  0 24  8  0  0  0  0  8 1 None
0x430 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 24  8  0  0  0  0  2 1 None
0x431 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 24  8  0  0  0  0  4 1 None
0x432 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 24  8  0  0  0  0  8 1 None
0x433 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 24  8  0  0  0  0  2 1 None
0x434 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 24  8  0  0  0  0  4 1 None
0x435 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 24  8  0  0  0  0  8 1 None
0x436 24 dc  0  32  0 r  . .   8  8  8  8 .  s  0  0  0  0  0  0  0  0 0 None
0x437 24 dc  0  32  0 r  . .   8  8  8  8 .  s  0  0  0 16 16 16 16  0 0 Slow
0x438 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0  0  0  0  0  0  0  0 0 None
0x439 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0  0  0 16 16 16 16  0 0 Slow
0x43a 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0  0  0  0  0  0  0  0 0 None
0x43b 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0  0  0 16 16 16 16  0 0 Slow
0x43c 24 dc  0  32  0 r  . .   8  8  8  8 .  s  0 16  0  0  0  0  0  0 0 None
0x43d 24 dc  0  32  0 r  . .   8  8  8  8 .  s  0 16  0 16 16 16 16  0 0 Slow
0x43e 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 16  0  0  0  0  0  0 0 None
0x43f 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 16  0 16 16 16 16  0 0 Slow
0x440 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 16  0  0  0  0  0  0 0 None
0x441 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 16  0 16 16 16 16  0 0 Slow
0x442 24 dc  0  32  0 r  . .   8  8  8  8 .  s  0 24  0  0  0  0  0  0 0 None
0x443 24 dc  0  32  0 r  . .   8  8  8  8 .  s  0 24  0 16 16 16 16  0 0 Slow
0x444 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 24  0  0  0  0  0  0 0 None
0x445 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 24  0 16 16 16 16  0 0 Slow
0x446 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 24  0  0  0  0  0  0 0 None
0x447 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 24  0 16 16 16 16  0 0 Slow
0x448 24 dc  0  32  0 r  . .   8  8  8  8 .  s  0 24  8  0  0  0  0  0 0 None
0x449 24 dc  0  32  0 r  . .   8  8  8  8 .  s  0 24  8 16 16 16 16  0 0 Slow
0x44a 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 24  8  0  0  0  0  0 0 None
0x44b 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 24  8 16 16 16 16  0 0 Slow
0x44c 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 24  8  0  0  0  0  0 0 None
0x44d 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 24  8 16 16 16 16  0 0 Slow
0x44e 24 dc  0  32  0 r  . .   8  8  8  8 .  s  0  0  0  0  0  0  0  2 1 None
0x44f 24 dc  0  32  0 r  . .   8  8  8  8 .  s  0  0  0  0  0  0  0  4 1 None
0x450 24 dc  0  32  0 r  . .   8  8  8  8 .  s  0  0  0  0  0  0  0  8 1 None
0x451 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0  0  0  0  0  0  0  2 1 None
0x452 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0  0  0  0  0  0  0  4 1 None
0x453 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0  0  0  0  0  0  0  8 1 None
0x454 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0  0  0  0  0  0  0  2 1 None
0x455 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0  0  0  0  0  0  0  4 1 None
0x456 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0  0  0  0  0  0  0  8 1 None
0x457 24 dc  0  32  0 r  . .   8  8  8  8 .  s  0 16  0  0  0  0  0  2 1 None
0x458 24 dc  0  32  0 r  . .   8  8  8  8 .  s  0 16  0  0  0  0  0  4 1 None
0x459 24 dc  0  32  0 r  . .   8  8  8  8 .  s  0 16  0  0  0  0  0  8 1 None
0x45a 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 16  0  0  0  0  0  2 1 None
0x45b 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 16  0  0  0  0  0  4 1 None
0x45c 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 16  0  0  0  0  0  8 1 None
0x45d 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 16  0  0  0  0  0  2 1 None
0x45e 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 16  0  0  0  0  0  4 1 None
0x45f 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 16  0  0  0  0  0  8 1 None
0x460 24 dc  0  32  0 r  . .   8  8  8  8 .  s  0 24  0  0  0  0  0  2 1 None
0x461 24 dc  0  32  0 r  . .   8  8  8  8 .  s  0 24  0  0  0  0  0  4 1 None
0x462 24 dc  0  32  0 r  . .   8  8  8  8 .  s  0 24  0  0  0  0  0  8 1 None
0x463 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 24  0  0  0  0  0  2 1 None
0x464 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 24  0  0  0  0  0  4 1 None
0x465 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 24  0  0  0  0  0  8 1 None
0x466 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 24  0  0  0  0  0  2 1 None
0x467 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 24  0  0  0  0  0  4 1 None
0x468 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 24  0  0  0  0  0  8 1 None
0x469 24 dc  0  32  0 r  . .   8  8  8  8 .  s  0 24  8  0  0  0  0  2 1 None
0x46a 24 dc  0  32  0 r  . .   8  8  8  8 .  s  0 24  8  0  0  0  0  4 1 None
0x46b 24 dc  0  32  0 r  . .   8  8  8  8 .  s  0 24  8  0  0  0  0  8 1 None
0x46c 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 24  8  0  0  0  0  2 1 None
0x46d 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 24  8  0  0  0  0  4 1 None
0x46e 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 24  8  0  0  0  0  8 1 None
0x46f 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 24  8  0  0  0  0  2 1 None
0x470 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 24  8  0  0  0  0  4 1 None
0x471 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 24  8  0  0  0  0  8 1 None
0x472 24 dc  0  24  0 r  . .   8  8  8  0 .  s  0  0  0  0  0  0  0  0 0 None
0x473 24 dc  0  24  0 r  . .   8  8  8  0 .  s  0  0  0 16 16 16  0  0 0 Slow
0x474 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0  0  0  0  0  0  0  0 0 None
0x475 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0  0  0 16 16 16  0  0 0 Slow
0x476 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0  0  0  0  0  0  0  0 0 None
0x477 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0  0  0 16 16 16  0  0 0 Slow
0x478 24 dc  0  24  0 r  . .   8  8  8  0 .  s  0 16  0  0  0  0  0  0 0 None
0x479 24 dc  0  24  0 r  . .   8  8  8  0 .  s  0 16  0 16 16 16  0  0 0 Slow
0x47a 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 16  0  0  0  0  0  0 0 None
0x47b 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 16  0 16 16 16  0  0 0 Slow
0x47c 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 16  0  0  0  0  0  0 0 None
0x47d 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 16  0 16 16 16  0  0 0 Slow
0x47e 24 dc  0  24  0 r  . .   8  8  8  0 .  s  0 24  0  0  0  0  0  0 0 None
0x47f 24 dc  0  24  0 r  . .   8  8  8  0 .  s  0 24  0 16 16 16  0  0 0 Slow
0x480 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 24  0  0  0  0  0  0 0 None
0x481 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 24  0 16 16 16  0  0 0 Slow
0x482 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 24  0  0  0  0  0  0 0 None
0x483 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 24  0 16 16 16  0  0 0 Slow
0x484 24 dc  0  24  0 r  . .   8  8  8  0 .  s  0 24  8  0  0  0  0  0 0 None
0x485 24 dc  0  24  0 r  . .   8  8  8  0 .  s  0 24  8 16 16 16  0  0 0 Slow
0x486 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 24  8  0  0  0  0  0 0 None
0x487 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 24  8 16 16 16  0  0 0 Slow
0x488 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 24  8  0  0  0  0  0 0 None
0x489 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 24  8 16 16 16  0  0 0 Slow
0x48a 24 dc  0  24  0 r  . .   8  8  8  0 .  s  0  0  0  0  0  0  0  2 1 None
0x48b 24 dc  0  24  0 r  . .   8  8  8  0 .  s  0  0  0  0  0  0  0  4 1 None
0x48c 24 dc  0  24  0 r  . .   8  8  8  0 .  s  0  0  0  0  0  0  0  8 1 None
0x48d 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0  0  0  0  0  0  0  2 1 None
0x48e 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0  0  0  0  0  0  0  4 1 None
0x48f 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0  0  0  0  0  0  0  8 1 None
0x490 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0  0  0  0  0  0  0  2 1 None
0x491 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0  0  0  0  0  0  0  4 1 None
0x492 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0  0  0  0  0  0  0  8 1 None
0x493 24 dc  0  24  0 r  . .   8  8  8  0 .  s  0 16  0  0  0  0  0  2 1 None
0x494 24 dc  0  24  0 r  . .   8  8  8  0 .  s  0 16  0  0  0  0  0  4 1 None
0x495 24 dc  0  24  0 r  . .   8  8  8  0 .  s  0 16  0  0  0  0  0  8 1 None
0x496 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 16  0  0  0  0  0  2 1 None
0x497 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 16  0  0  0  0  0  4 1 None
0x498 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 16  0  0  0  0  0  8 1 None
0x499 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 16  0  0  0  0  0  2 1 None
0x49a 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 16  0  0  0  0  0  4 1 None
0x49b 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 16  0  0  0  0  0  8 1 None
0x49c 24 dc  0  24  0 r  . .   8  8  8  0 .  s  0 24  0  0  0  0  0  2 1 None
0x49d 24 dc  0  24  0 r  . .   8  8  8  0 .  s  0 24  0  0  0  0  0  4 1 None
0x49e 24 dc  0  24  0 r  . .   8  8  8  0 .  s  0 24  0  0  0  0  0  8 1 None
0x49f 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 24  0  0  0  0  0  2 1 None
0x4a0 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 24  0  0  0  0  0  4 1 None
0x4a1 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 24  0  0  0  0  0  8 1 None
0x4a2 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 24  0  0  0  0  0  2 1 None
0x4a3 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 24  0  0  0  0  0  4 1 None
0x4a4 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 24  0  0  0  0  0  8 1 None
0x4a5 24 dc  0  24  0 r  . .   8  8  8  0 .  s  0 24  8  0  0  0  0  2 1 None
0x4a6 24 dc  0  24  0 r  . .   8  8  8  0 .  s  0 24  8  0  0  0  0  4 1 None
0x4a7 24 dc  0  24  0 r  . .   8  8  8  0 .  s  0 24  8  0  0  0  0  8 1 None
0x4a8 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 24  8  0  0  0  0  2 1 None
0x4a9 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 24  8  0  0  0  0  4 1 None
0x4aa 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 24  8  0  0  0  0  8 1 None
0x4ab 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 24  8  0  0  0  0  2 1 None
0x4ac 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 24  8  0  0  0  0  4 1 None
0x4ad 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 24  8  0  0  0  0  8 1 None
0x078 32 tc  0  32  0 r  y .   8  8  8  8 .  .  0 24  8  0  0  0  0  0 0 None

600 GLXFBConfigs:
    visual  x   bf lv rg d st  colorbuffer  sr ax dp st accumbuffer  ms  cav
  id dep cl sp  sz l  ci b ro  r  g  b  a F gb bf th cl  r  g  b  a ns b eat
----------------------------------------------------------------------------
0x079 24 tc  0  32  0 r  . .   8  8  8  8 .  .  0  0  0  0  0  0  0  0 0 None
0x07a 24 tc  0  32  0 r  . .   8  8  8  8 .  .  0  0  0 16 16 16 16  0 0 Slow
0x07b 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0  0  0  0  0  0  0  0 0 None
0x07c 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0  0  0 16 16 16 16  0 0 Slow
0x07d 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0  0  0  0  0  0  0  0 0 None
0x07e 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0  0  0 16 16 16 16  0 0 Slow
0x07f 24 tc  0  32  0 r  . .   8  8  8  8 .  .  0 16  0  0  0  0  0  0 0 None
0x080 24 tc  0  32  0 r  . .   8  8  8  8 .  .  0 16  0 16 16 16 16  0 0 Slow
0x081 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 16  0  0  0  0  0  0 0 None
0x082 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 16  0 16 16 16 16  0 0 Slow
0x083 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 16  0  0  0  0  0  0 0 None
0x084 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 16  0 16 16 16 16  0 0 Slow
0x085 24 tc  0  32  0 r  . .   8  8  8  8 .  .  0 24  0  0  0  0  0  0 0 None
0x086 24 tc  0  32  0 r  . .   8  8  8  8 .  .  0 24  0 16 16 16 16  0 0 Slow
0x087 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 24  0  0  0  0  0  0 0 None
0x088 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 24  0 16 16 16 16  0 0 Slow
0x089 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 24  0  0  0  0  0  0 0 None
0x08a 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 24  0 16 16 16 16  0 0 Slow
0x08b 24 tc  0  32  0 r  . .   8  8  8  8 .  .  0 24  8  0  0  0  0  0 0 None
0x08c 24 tc  0  32  0 r  . .   8  8  8  8 .  .  0 24  8 16 16 16 16  0 0 Slow
0x08d 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 24  8  0  0  0  0  0 0 None
0x08e 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 24  8 16 16 16 16  0 0 Slow
0x08f 32 tc  0  32  0 r  y .   8  8  8  8 .  .  0 24  8  0  0  0  0  0 0 None
0x090 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 24  8 16 16 16 16  0 0 Slow
0x091 24 tc  0  32  0 r  . .   8  8  8  8 .  .  0  0  0  0  0  0  0  2 1 None
0x092 24 tc  0  32  0 r  . .   8  8  8  8 .  .  0  0  0  0  0  0  0  4 1 None
0x093 24 tc  0  32  0 r  . .   8  8  8  8 .  .  0  0  0  0  0  0  0  8 1 None
0x094 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0  0  0  0  0  0  0  2 1 None
0x095 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0  0  0  0  0  0  0  4 1 None
0x096 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0  0  0  0  0  0  0  8 1 None
0x097 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0  0  0  0  0  0  0  2 1 None
0x098 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0  0  0  0  0  0  0  4 1 None
0x099 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0  0  0  0  0  0  0  8 1 None
0x09a 24 tc  0  32  0 r  . .   8  8  8  8 .  .  0 16  0  0  0  0  0  2 1 None
0x09b 24 tc  0  32  0 r  . .   8  8  8  8 .  .  0 16  0  0  0  0  0  4 1 None
0x09c 24 tc  0  32  0 r  . .   8  8  8  8 .  .  0 16  0  0  0  0  0  8 1 None
0x09d 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 16  0  0  0  0  0  2 1 None
0x09e 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 16  0  0  0  0  0  4 1 None
0x09f 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 16  0  0  0  0  0  8 1 None
0x0a0 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 16  0  0  0  0  0  2 1 None
0x0a1 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 16  0  0  0  0  0  4 1 None
0x0a2 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 16  0  0  0  0  0  8 1 None
0x0a3 24 tc  0  32  0 r  . .   8  8  8  8 .  .  0 24  0  0  0  0  0  2 1 None
0x0a4 24 tc  0  32  0 r  . .   8  8  8  8 .  .  0 24  0  0  0  0  0  4 1 None
0x0a5 24 tc  0  32  0 r  . .   8  8  8  8 .  .  0 24  0  0  0  0  0  8 1 None
0x0a6 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 24  0  0  0  0  0  2 1 None
0x0a7 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 24  0  0  0  0  0  4 1 None
0x0a8 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 24  0  0  0  0  0  8 1 None
0x0a9 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 24  0  0  0  0  0  2 1 None
0x0aa 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 24  0  0  0  0  0  4 1 None
0x0ab 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 24  0  0  0  0  0  8 1 None
0x0ac 24 tc  0  32  0 r  . .   8  8  8  8 .  .  0 24  8  0  0  0  0  2 1 None
0x0ad 24 tc  0  32  0 r  . .   8  8  8  8 .  .  0 24  8  0  0  0  0  4 1 None
0x0ae 24 tc  0  32  0 r  . .   8  8  8  8 .  .  0 24  8  0  0  0  0  8 1 None
0x0af 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 24  8  0  0  0  0  2 1 None
0x0b0 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 24  8  0  0  0  0  4 1 None
0x0b1 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 24  8  0  0  0  0  8 1 None
0x0b2 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 24  8  0  0  0  0  2 1 None
0x0b3 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 24  8  0  0  0  0  4 1 None
0x0b4 24 tc  0  32  0 r  y .   8  8  8  8 .  .  0 24  8  0  0  0  0  8 1 None
0x0b5 24 tc  0  24  0 r  . .   8  8  8  0 .  .  0  0  0  0  0  0  0  0 0 None
0x0b6 24 tc  0  24  0 r  . .   8  8  8  0 .  .  0  0  0 16 16 16  0  0 0 Slow
0x0b7 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0  0  0  0  0  0  0  0 0 None
0x0b8 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0  0  0 16 16 16  0  0 0 Slow
0x0b9 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0  0  0  0  0  0  0  0 0 None
0x0ba 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0  0  0 16 16 16  0  0 0 Slow
0x0bb 24 tc  0  24  0 r  . .   8  8  8  0 .  .  0 16  0  0  0  0  0  0 0 None
0x0bc 24 tc  0  24  0 r  . .   8  8  8  0 .  .  0 16  0 16 16 16  0  0 0 Slow
0x0bd 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 16  0  0  0  0  0  0 0 None
0x0be 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 16  0 16 16 16  0  0 0 Slow
0x0bf 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 16  0  0  0  0  0  0 0 None
0x0c0 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 16  0 16 16 16  0  0 0 Slow
0x0c1 24 tc  0  24  0 r  . .   8  8  8  0 .  .  0 24  0  0  0  0  0  0 0 None
0x0c2 24 tc  0  24  0 r  . .   8  8  8  0 .  .  0 24  0 16 16 16  0  0 0 Slow
0x0c3 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 24  0  0  0  0  0  0 0 None
0x0c4 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 24  0 16 16 16  0  0 0 Slow
0x0c5 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 24  0  0  0  0  0  0 0 None
0x0c6 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 24  0 16 16 16  0  0 0 Slow
0x0c7 24 tc  0  24  0 r  . .   8  8  8  0 .  .  0 24  8  0  0  0  0  0 0 None
0x0c8 24 tc  0  24  0 r  . .   8  8  8  0 .  .  0 24  8 16 16 16  0  0 0 Slow
0x0c9 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 24  8  0  0  0  0  0 0 None
0x0ca 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 24  8 16 16 16  0  0 0 Slow
0x0cb 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 24  8  0  0  0  0  0 0 None
0x0cc 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 24  8 16 16 16  0  0 0 Slow
0x0cd 24 tc  0  24  0 r  . .   8  8  8  0 .  .  0  0  0  0  0  0  0  2 1 None
0x0ce 24 tc  0  24  0 r  . .   8  8  8  0 .  .  0  0  0  0  0  0  0  4 1 None
0x0cf 24 tc  0  24  0 r  . .   8  8  8  0 .  .  0  0  0  0  0  0  0  8 1 None
0x0d0 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0  0  0  0  0  0  0  2 1 None
0x0d1 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0  0  0  0  0  0  0  4 1 None
0x0d2 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0  0  0  0  0  0  0  8 1 None
0x0d3 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0  0  0  0  0  0  0  2 1 None
0x0d4 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0  0  0  0  0  0  0  4 1 None
0x0d5 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0  0  0  0  0  0  0  8 1 None
0x0d6 24 tc  0  24  0 r  . .   8  8  8  0 .  .  0 16  0  0  0  0  0  2 1 None
0x0d7 24 tc  0  24  0 r  . .   8  8  8  0 .  .  0 16  0  0  0  0  0  4 1 None
0x0d8 24 tc  0  24  0 r  . .   8  8  8  0 .  .  0 16  0  0  0  0  0  8 1 None
0x0d9 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 16  0  0  0  0  0  2 1 None
0x0da 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 16  0  0  0  0  0  4 1 None
0x0db 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 16  0  0  0  0  0  8 1 None
0x0dc 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 16  0  0  0  0  0  2 1 None
0x0dd 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 16  0  0  0  0  0  4 1 None
0x0de 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 16  0  0  0  0  0  8 1 None
0x0df 24 tc  0  24  0 r  . .   8  8  8  0 .  .  0 24  0  0  0  0  0  2 1 None
0x0e0 24 tc  0  24  0 r  . .   8  8  8  0 .  .  0 24  0  0  0  0  0  4 1 None
0x0e1 24 tc  0  24  0 r  . .   8  8  8  0 .  .  0 24  0  0  0  0  0  8 1 None
0x0e2 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 24  0  0  0  0  0  2 1 None
0x0e3 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 24  0  0  0  0  0  4 1 None
0x0e4 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 24  0  0  0  0  0  8 1 None
0x0e5 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 24  0  0  0  0  0  2 1 None
0x0e6 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 24  0  0  0  0  0  4 1 None
0x0e7 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 24  0  0  0  0  0  8 1 None
0x0e8 24 tc  0  24  0 r  . .   8  8  8  0 .  .  0 24  8  0  0  0  0  2 1 None
0x0e9 24 tc  0  24  0 r  . .   8  8  8  0 .  .  0 24  8  0  0  0  0  4 1 None
0x0ea 24 tc  0  24  0 r  . .   8  8  8  0 .  .  0 24  8  0  0  0  0  8 1 None
0x0eb 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 24  8  0  0  0  0  2 1 None
0x0ec 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 24  8  0  0  0  0  4 1 None
0x0ed 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 24  8  0  0  0  0  8 1 None
0x0ee 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 24  8  0  0  0  0  2 1 None
0x0ef 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 24  8  0  0  0  0  4 1 None
0x0f0 24 tc  0  24  0 r  y .   8  8  8  0 .  .  0 24  8  0  0  0  0  8 1 None
0x0f1 24 tc  0  32  0 r  . .   8  8  8  8 .  s  0  0  0  0  0  0  0  0 0 None
0x0f2 24 tc  0  32  0 r  . .   8  8  8  8 .  s  0  0  0 16 16 16 16  0 0 Slow
0x0f3 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0  0  0  0  0  0  0  0 0 None
0x0f4 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0  0  0 16 16 16 16  0 0 Slow
0x0f5 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0  0  0  0  0  0  0  0 0 None
0x0f6 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0  0  0 16 16 16 16  0 0 Slow
0x0f7 24 tc  0  32  0 r  . .   8  8  8  8 .  s  0 16  0  0  0  0  0  0 0 None
0x0f8 24 tc  0  32  0 r  . .   8  8  8  8 .  s  0 16  0 16 16 16 16  0 0 Slow
0x0f9 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 16  0  0  0  0  0  0 0 None
0x0fa 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 16  0 16 16 16 16  0 0 Slow
0x0fb 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 16  0  0  0  0  0  0 0 None
0x0fc 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 16  0 16 16 16 16  0 0 Slow
0x0fd 24 tc  0  32  0 r  . .   8  8  8  8 .  s  0 24  0  0  0  0  0  0 0 None
0x0fe 24 tc  0  32  0 r  . .   8  8  8  8 .  s  0 24  0 16 16 16 16  0 0 Slow
0x0ff 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 24  0  0  0  0  0  0 0 None
0x100 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 24  0 16 16 16 16  0 0 Slow
0x101 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 24  0  0  0  0  0  0 0 None
0x102 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 24  0 16 16 16 16  0 0 Slow
0x103 24 tc  0  32  0 r  . .   8  8  8  8 .  s  0 24  8  0  0  0  0  0 0 None
0x104 24 tc  0  32  0 r  . .   8  8  8  8 .  s  0 24  8 16 16 16 16  0 0 Slow
0x105 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 24  8  0  0  0  0  0 0 None
0x106 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 24  8 16 16 16 16  0 0 Slow
0x107 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 24  8  0  0  0  0  0 0 None
0x108 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 24  8 16 16 16 16  0 0 Slow
0x109 24 tc  0  32  0 r  . .   8  8  8  8 .  s  0  0  0  0  0  0  0  2 1 None
0x10a 24 tc  0  32  0 r  . .   8  8  8  8 .  s  0  0  0  0  0  0  0  4 1 None
0x10b 24 tc  0  32  0 r  . .   8  8  8  8 .  s  0  0  0  0  0  0  0  8 1 None
0x10c 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0  0  0  0  0  0  0  2 1 None
0x10d 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0  0  0  0  0  0  0  4 1 None
0x10e 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0  0  0  0  0  0  0  8 1 None
0x10f 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0  0  0  0  0  0  0  2 1 None
0x110 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0  0  0  0  0  0  0  4 1 None
0x111 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0  0  0  0  0  0  0  8 1 None
0x112 24 tc  0  32  0 r  . .   8  8  8  8 .  s  0 16  0  0  0  0  0  2 1 None
0x113 24 tc  0  32  0 r  . .   8  8  8  8 .  s  0 16  0  0  0  0  0  4 1 None
0x114 24 tc  0  32  0 r  . .   8  8  8  8 .  s  0 16  0  0  0  0  0  8 1 None
0x115 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 16  0  0  0  0  0  2 1 None
0x116 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 16  0  0  0  0  0  4 1 None
0x117 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 16  0  0  0  0  0  8 1 None
0x118 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 16  0  0  0  0  0  2 1 None
0x119 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 16  0  0  0  0  0  4 1 None
0x11a 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 16  0  0  0  0  0  8 1 None
0x11b 24 tc  0  32  0 r  . .   8  8  8  8 .  s  0 24  0  0  0  0  0  2 1 None
0x11c 24 tc  0  32  0 r  . .   8  8  8  8 .  s  0 24  0  0  0  0  0  4 1 None
0x11d 24 tc  0  32  0 r  . .   8  8  8  8 .  s  0 24  0  0  0  0  0  8 1 None
0x11e 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 24  0  0  0  0  0  2 1 None
0x11f 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 24  0  0  0  0  0  4 1 None
0x120 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 24  0  0  0  0  0  8 1 None
0x121 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 24  0  0  0  0  0  2 1 None
0x122 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 24  0  0  0  0  0  4 1 None
0x123 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 24  0  0  0  0  0  8 1 None
0x124 24 tc  0  32  0 r  . .   8  8  8  8 .  s  0 24  8  0  0  0  0  2 1 None
0x125 24 tc  0  32  0 r  . .   8  8  8  8 .  s  0 24  8  0  0  0  0  4 1 None
0x126 24 tc  0  32  0 r  . .   8  8  8  8 .  s  0 24  8  0  0  0  0  8 1 None
0x127 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 24  8  0  0  0  0  2 1 None
0x128 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 24  8  0  0  0  0  4 1 None
0x129 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 24  8  0  0  0  0  8 1 None
0x12a 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 24  8  0  0  0  0  2 1 None
0x12b 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 24  8  0  0  0  0  4 1 None
0x12c 24 tc  0  32  0 r  y .   8  8  8  8 .  s  0 24  8  0  0  0  0  8 1 None
0x12d 24 tc  0  24  0 r  . .   8  8  8  0 .  s  0  0  0  0  0  0  0  0 0 None
0x12e 24 tc  0  24  0 r  . .   8  8  8  0 .  s  0  0  0 16 16 16  0  0 0 Slow
0x12f 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0  0  0  0  0  0  0  0 0 None
0x130 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0  0  0 16 16 16  0  0 0 Slow
0x131 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0  0  0  0  0  0  0  0 0 None
0x132 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0  0  0 16 16 16  0  0 0 Slow
0x133 24 tc  0  24  0 r  . .   8  8  8  0 .  s  0 16  0  0  0  0  0  0 0 None
0x134 24 tc  0  24  0 r  . .   8  8  8  0 .  s  0 16  0 16 16 16  0  0 0 Slow
0x135 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 16  0  0  0  0  0  0 0 None
0x136 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 16  0 16 16 16  0  0 0 Slow
0x137 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 16  0  0  0  0  0  0 0 None
0x138 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 16  0 16 16 16  0  0 0 Slow
0x139 24 tc  0  24  0 r  . .   8  8  8  0 .  s  0 24  0  0  0  0  0  0 0 None
0x13a 24 tc  0  24  0 r  . .   8  8  8  0 .  s  0 24  0 16 16 16  0  0 0 Slow
0x13b 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 24  0  0  0  0  0  0 0 None
0x13c 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 24  0 16 16 16  0  0 0 Slow
0x13d 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 24  0  0  0  0  0  0 0 None
0x13e 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 24  0 16 16 16  0  0 0 Slow
0x13f 24 tc  0  24  0 r  . .   8  8  8  0 .  s  0 24  8  0  0  0  0  0 0 None
0x140 24 tc  0  24  0 r  . .   8  8  8  0 .  s  0 24  8 16 16 16  0  0 0 Slow
0x141 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 24  8  0  0  0  0  0 0 None
0x142 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 24  8 16 16 16  0  0 0 Slow
0x143 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 24  8  0  0  0  0  0 0 None
0x144 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 24  8 16 16 16  0  0 0 Slow
0x145 24 tc  0  24  0 r  . .   8  8  8  0 .  s  0  0  0  0  0  0  0  2 1 None
0x146 24 tc  0  24  0 r  . .   8  8  8  0 .  s  0  0  0  0  0  0  0  4 1 None
0x147 24 tc  0  24  0 r  . .   8  8  8  0 .  s  0  0  0  0  0  0  0  8 1 None
0x148 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0  0  0  0  0  0  0  2 1 None
0x149 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0  0  0  0  0  0  0  4 1 None
0x14a 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0  0  0  0  0  0  0  8 1 None
0x14b 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0  0  0  0  0  0  0  2 1 None
0x14c 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0  0  0  0  0  0  0  4 1 None
0x14d 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0  0  0  0  0  0  0  8 1 None
0x14e 24 tc  0  24  0 r  . .   8  8  8  0 .  s  0 16  0  0  0  0  0  2 1 None
0x14f 24 tc  0  24  0 r  . .   8  8  8  0 .  s  0 16  0  0  0  0  0  4 1 None
0x150 24 tc  0  24  0 r  . .   8  8  8  0 .  s  0 16  0  0  0  0  0  8 1 None
0x151 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 16  0  0  0  0  0  2 1 None
0x152 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 16  0  0  0  0  0  4 1 None
0x153 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 16  0  0  0  0  0  8 1 None
0x154 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 16  0  0  0  0  0  2 1 None
0x155 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 16  0  0  0  0  0  4 1 None
0x156 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 16  0  0  0  0  0  8 1 None
0x157 24 tc  0  24  0 r  . .   8  8  8  0 .  s  0 24  0  0  0  0  0  2 1 None
0x158 24 tc  0  24  0 r  . .   8  8  8  0 .  s  0 24  0  0  0  0  0  4 1 None
0x159 24 tc  0  24  0 r  . .   8  8  8  0 .  s  0 24  0  0  0  0  0  8 1 None
0x15a 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 24  0  0  0  0  0  2 1 None
0x15b 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 24  0  0  0  0  0  4 1 None
0x15c 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 24  0  0  0  0  0  8 1 None
0x15d 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 24  0  0  0  0  0  2 1 None
0x15e 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 24  0  0  0  0  0  4 1 None
0x15f 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 24  0  0  0  0  0  8 1 None
0x160 24 tc  0  24  0 r  . .   8  8  8  0 .  s  0 24  8  0  0  0  0  2 1 None
0x161 24 tc  0  24  0 r  . .   8  8  8  0 .  s  0 24  8  0  0  0  0  4 1 None
0x162 24 tc  0  24  0 r  . .   8  8  8  0 .  s  0 24  8  0  0  0  0  8 1 None
0x163 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 24  8  0  0  0  0  2 1 None
0x164 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 24  8  0  0  0  0  4 1 None
0x165 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 24  8  0  0  0  0  8 1 None
0x166 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 24  8  0  0  0  0  2 1 None
0x167 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 24  8  0  0  0  0  4 1 None
0x168 24 tc  0  24  0 r  y .   8  8  8  0 .  s  0 24  8  0  0  0  0  8 1 None
0x169  0 tc  0  16  0 r  . .   5  6  5  0 .  .  0  0  0  0  0  0  0  0 0 None
0x16a  0 tc  0  16  0 r  . .   5  6  5  0 .  .  0  0  0 16 16 16  0  0 0 Slow
0x16b  0 tc  0  16  0 r  y .   5  6  5  0 .  .  0  0  0  0  0  0  0  0 0 None
0x16c  0 tc  0  16  0 r  y .   5  6  5  0 .  .  0  0  0 16 16 16  0  0 0 Slow
0x16d  0 tc  0  16  0 r  y .   5  6  5  0 .  .  0  0  0  0  0  0  0  0 0 None
0x16e  0 tc  0  16  0 r  y .   5  6  5  0 .  .  0  0  0 16 16 16  0  0 0 Slow
0x16f  0 tc  0  16  0 r  . .   5  6  5  0 .  .  0 16  0  0  0  0  0  0 0 None
0x170  0 tc  0  16  0 r  . .   5  6  5  0 .  .  0 16  0 16 16 16  0  0 0 Slow
0x171  0 tc  0  16  0 r  y .   5  6  5  0 .  .  0 16  0  0  0  0  0  0 0 None
0x172  0 tc  0  16  0 r  y .   5  6  5  0 .  .  0 16  0 16 16 16  0  0 0 Slow
0x173  0 tc  0  16  0 r  y .   5  6  5  0 .  .  0 16  0  0  0  0  0  0 0 None
0x174  0 tc  0  16  0 r  y .   5  6  5  0 .  .  0 16  0 16 16 16  0  0 0 Slow
0x175  0 tc  0  16  0 r  . .   5  6  5  0 .  .  0 24  0  0  0  0  0  0 0 None
0x176  0 tc  0  16  0 r  . .   5  6  5  0 .  .  0 24  0 16 16 16  0  0 0 Slow
0x177  0 tc  0  16  0 r  y .   5  6  5  0 .  .  0 24  0  0  0  0  0  0 0 None
0x178  0 tc  0  16  0 r  y .   5  6  5  0 .  .  0 24  0 16 16 16  0  0 0 Slow
0x179  0 tc  0  16  0 r  y .   5  6  5  0 .  .  0 24  0  0  0  0  0  0 0 None
0x17a  0 tc  0  16  0 r  y .   5  6  5  0 .  .  0 24  0 16 16 16  0  0 0 Slow
0x17b  0 tc  0  16  0 r  . .   5  6  5  0 .  .  0 24  8  0  0  0  0  0 0 None
0x17c  0 tc  0  16  0 r  . .   5  6  5  0 .  .  0 24  8 16 16 16  0  0 0 Slow
0x17d  0 tc  0  16  0 r  y .   5  6  5  0 .  .  0 24  8  0  0  0  0  0 0 None
0x17e  0 tc  0  16  0 r  y .   5  6  5  0 .  .  0 24  8 16 16 16  0  0 0 Slow
0x17f  0 tc  0  16  0 r  y .   5  6  5  0 .  .  0 24  8  0  0  0  0  0 0 None
0x180  0 tc  0  16  0 r  y .   5  6  5  0 .  .  0 24  8 16 16 16  0  0 0 Slow
0x181  0 tc  0  16  0 r  . .   5  6  5  0 .  .  0  0  0  0  0  0  0  2 1 None
0x182  0 tc  0  16  0 r  . .   5  6  5  0 .  .  0  0  0  0  0  0  0  4 1 None
0x183  0 tc  0  16  0 r  . .   5  6  5  0 .  .  0  0  0  0  0  0  0  8 1 None
0x184  0 tc  0  16  0 r  y .   5  6  5  0 .  .  0  0  0  0  0  0  0  2 1 None
0x185  0 tc  0  16  0 r  y .   5  6  5  0 .  .  0  0  0  0  0  0  0  4 1 None
0x186  0 tc  0  16  0 r  y .   5  6  5  0 .  .  0  0  0  0  0  0  0  8 1 None
0x187  0 tc  0  16  0 r  y .   5  6  5  0 .  .  0  0  0  0  0  0  0  2 1 None
0x188  0 tc  0  16  0 r  y .   5  6  5  0 .  .  0  0  0  0  0  0  0  4 1 None
0x189  0 tc  0  16  0 r  y .   5  6  5  0 .  .  0  0  0  0  0  0  0  8 1 None
0x18a  0 tc  0  16  0 r  . .   5  6  5  0 .  .  0 16  0  0  0  0  0  2 1 None
0x18b  0 tc  0  16  0 r  . .   5  6  5  0 .  .  0 16  0  0  0  0  0  4 1 None
0x18c  0 tc  0  16  0 r  . .   5  6  5  0 .  .  0 16  0  0  0  0  0  8 1 None
0x18d  0 tc  0  16  0 r  y .   5  6  5  0 .  .  0 16  0  0  0  0  0  2 1 None
0x18e  0 tc  0  16  0 r  y .   5  6  5  0 .  .  0 16  0  0  0  0  0  4 1 None
0x18f  0 tc  0  16  0 r  y .   5  6  5  0 .  .  0 16  0  0  0  0  0  8 1 None
0x190  0 tc  0  16  0 r  y .   5  6  5  0 .  .  0 16  0  0  0  0  0  2 1 None
0x191  0 tc  0  16  0 r  y .   5  6  5  0 .  .  0 16  0  0  0  0  0  4 1 None
0x192  0 tc  0  16  0 r  y .   5  6  5  0 .  .  0 16  0  0  0  0  0  8 1 None
0x193  0 tc  0  16  0 r  . .   5  6  5  0 .  .  0 24  0  0  0  0  0  2 1 None
0x194  0 tc  0  16  0 r  . .   5  6  5  0 .  .  0 24  0  0  0  0  0  4 1 None
0x195  0 tc  0  16  0 r  . .   5  6  5  0 .  .  0 24  0  0  0  0  0  8 1 None
0x196  0 tc  0  16  0 r  y .   5  6  5  0 .  .  0 24  0  0  0  0  0  2 1 None
0x197  0 tc  0  16  0 r  y .   5  6  5  0 .  .  0 24  0  0  0  0  0  4 1 None
0x198  0 tc  0  16  0 r  y .   5  6  5  0 .  .  0 24  0  0  0  0  0  8 1 None
0x199  0 tc  0  16  0 r  y .   5  6  5  0 .  .  0 24  0  0  0  0  0  2 1 None
0x19a  0 tc  0  16  0 r  y .   5  6  5  0 .  .  0 24  0  0  0  0  0  4 1 None
0x19b  0 tc  0  16  0 r  y .   5  6  5  0 .  .  0 24  0  0  0  0  0  8 1 None
0x19c  0 tc  0  16  0 r  . .   5  6  5  0 .  .  0 24  8  0  0  0  0  2 1 None
0x19d  0 tc  0  16  0 r  . .   5  6  5  0 .  .  0 24  8  0  0  0  0  4 1 None
0x19e  0 tc  0  16  0 r  . .   5  6  5  0 .  .  0 24  8  0  0  0  0  8 1 None
0x19f  0 tc  0  16  0 r  y .   5  6  5  0 .  .  0 24  8  0  0  0  0  2 1 None
0x1a0  0 tc  0  16  0 r  y .   5  6  5  0 .  .  0 24  8  0  0  0  0  4 1 None
0x1a1  0 tc  0  16  0 r  y .   5  6  5  0 .  .  0 24  8  0  0  0  0  8 1 None
0x1a2  0 tc  0  16  0 r  y .   5  6  5  0 .  .  0 24  8  0  0  0  0  2 1 None
0x1a3  0 tc  0  16  0 r  y .   5  6  5  0 .  .  0 24  8  0  0  0  0  4 1 None
0x1a4  0 tc  0  16  0 r  y .   5  6  5  0 .  .  0 24  8  0  0  0  0  8 1 None
0x1a5 24 dc  0  32  0 r  . .   8  8  8  8 .  .  0  0  0  0  0  0  0  0 0 None
0x1a6 24 dc  0  32  0 r  . .   8  8  8  8 .  .  0  0  0 16 16 16 16  0 0 Slow
0x1a7 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0  0  0  0  0  0  0  0 0 None
0x1a8 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0  0  0 16 16 16 16  0 0 Slow
0x1a9 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0  0  0  0  0  0  0  0 0 None
0x1aa 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0  0  0 16 16 16 16  0 0 Slow
0x1ab 24 dc  0  32  0 r  . .   8  8  8  8 .  .  0 16  0  0  0  0  0  0 0 None
0x1ac 24 dc  0  32  0 r  . .   8  8  8  8 .  .  0 16  0 16 16 16 16  0 0 Slow
0x1ad 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 16  0  0  0  0  0  0 0 None
0x1ae 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 16  0 16 16 16 16  0 0 Slow
0x1af 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 16  0  0  0  0  0  0 0 None
0x1b0 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 16  0 16 16 16 16  0 0 Slow
0x1b1 24 dc  0  32  0 r  . .   8  8  8  8 .  .  0 24  0  0  0  0  0  0 0 None
0x1b2 24 dc  0  32  0 r  . .   8  8  8  8 .  .  0 24  0 16 16 16 16  0 0 Slow
0x1b3 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 24  0  0  0  0  0  0 0 None
0x1b4 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 24  0 16 16 16 16  0 0 Slow
0x1b5 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 24  0  0  0  0  0  0 0 None
0x1b6 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 24  0 16 16 16 16  0 0 Slow
0x1b7 24 dc  0  32  0 r  . .   8  8  8  8 .  .  0 24  8  0  0  0  0  0 0 None
0x1b8 24 dc  0  32  0 r  . .   8  8  8  8 .  .  0 24  8 16 16 16 16  0 0 Slow
0x1b9 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 24  8  0  0  0  0  0 0 None
0x1ba 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 24  8 16 16 16 16  0 0 Slow
0x1bb 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 24  8  0  0  0  0  0 0 None
0x1bc 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 24  8 16 16 16 16  0 0 Slow
0x1bd 24 dc  0  32  0 r  . .   8  8  8  8 .  .  0  0  0  0  0  0  0  2 1 None
0x1be 24 dc  0  32  0 r  . .   8  8  8  8 .  .  0  0  0  0  0  0  0  4 1 None
0x1bf 24 dc  0  32  0 r  . .   8  8  8  8 .  .  0  0  0  0  0  0  0  8 1 None
0x1c0 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0  0  0  0  0  0  0  2 1 None
0x1c1 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0  0  0  0  0  0  0  4 1 None
0x1c2 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0  0  0  0  0  0  0  8 1 None
0x1c3 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0  0  0  0  0  0  0  2 1 None
0x1c4 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0  0  0  0  0  0  0  4 1 None
0x1c5 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0  0  0  0  0  0  0  8 1 None
0x1c6 24 dc  0  32  0 r  . .   8  8  8  8 .  .  0 16  0  0  0  0  0  2 1 None
0x1c7 24 dc  0  32  0 r  . .   8  8  8  8 .  .  0 16  0  0  0  0  0  4 1 None
0x1c8 24 dc  0  32  0 r  . .   8  8  8  8 .  .  0 16  0  0  0  0  0  8 1 None
0x1c9 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 16  0  0  0  0  0  2 1 None
0x1ca 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 16  0  0  0  0  0  4 1 None
0x1cb 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 16  0  0  0  0  0  8 1 None
0x1cc 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 16  0  0  0  0  0  2 1 None
0x1cd 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 16  0  0  0  0  0  4 1 None
0x1ce 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 16  0  0  0  0  0  8 1 None
0x1cf 24 dc  0  32  0 r  . .   8  8  8  8 .  .  0 24  0  0  0  0  0  2 1 None
0x1d0 24 dc  0  32  0 r  . .   8  8  8  8 .  .  0 24  0  0  0  0  0  4 1 None
0x1d1 24 dc  0  32  0 r  . .   8  8  8  8 .  .  0 24  0  0  0  0  0  8 1 None
0x1d2 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 24  0  0  0  0  0  2 1 None
0x1d3 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 24  0  0  0  0  0  4 1 None
0x1d4 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 24  0  0  0  0  0  8 1 None
0x1d5 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 24  0  0  0  0  0  2 1 None
0x1d6 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 24  0  0  0  0  0  4 1 None
0x1d7 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 24  0  0  0  0  0  8 1 None
0x1d8 24 dc  0  32  0 r  . .   8  8  8  8 .  .  0 24  8  0  0  0  0  2 1 None
0x1d9 24 dc  0  32  0 r  . .   8  8  8  8 .  .  0 24  8  0  0  0  0  4 1 None
0x1da 24 dc  0  32  0 r  . .   8  8  8  8 .  .  0 24  8  0  0  0  0  8 1 None
0x1db 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 24  8  0  0  0  0  2 1 None
0x1dc 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 24  8  0  0  0  0  4 1 None
0x1dd 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 24  8  0  0  0  0  8 1 None
0x1de 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 24  8  0  0  0  0  2 1 None
0x1df 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 24  8  0  0  0  0  4 1 None
0x1e0 24 dc  0  32  0 r  y .   8  8  8  8 .  .  0 24  8  0  0  0  0  8 1 None
0x1e1 24 dc  0  24  0 r  . .   8  8  8  0 .  .  0  0  0  0  0  0  0  0 0 None
0x1e2 24 dc  0  24  0 r  . .   8  8  8  0 .  .  0  0  0 16 16 16  0  0 0 Slow
0x1e3 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0  0  0  0  0  0  0  0 0 None
0x1e4 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0  0  0 16 16 16  0  0 0 Slow
0x1e5 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0  0  0  0  0  0  0  0 0 None
0x1e6 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0  0  0 16 16 16  0  0 0 Slow
0x1e7 24 dc  0  24  0 r  . .   8  8  8  0 .  .  0 16  0  0  0  0  0  0 0 None
0x1e8 24 dc  0  24  0 r  . .   8  8  8  0 .  .  0 16  0 16 16 16  0  0 0 Slow
0x1e9 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 16  0  0  0  0  0  0 0 None
0x1ea 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 16  0 16 16 16  0  0 0 Slow
0x1eb 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 16  0  0  0  0  0  0 0 None
0x1ec 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 16  0 16 16 16  0  0 0 Slow
0x1ed 24 dc  0  24  0 r  . .   8  8  8  0 .  .  0 24  0  0  0  0  0  0 0 None
0x1ee 24 dc  0  24  0 r  . .   8  8  8  0 .  .  0 24  0 16 16 16  0  0 0 Slow
0x1ef 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 24  0  0  0  0  0  0 0 None
0x1f0 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 24  0 16 16 16  0  0 0 Slow
0x1f1 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 24  0  0  0  0  0  0 0 None
0x1f2 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 24  0 16 16 16  0  0 0 Slow
0x1f3 24 dc  0  24  0 r  . .   8  8  8  0 .  .  0 24  8  0  0  0  0  0 0 None
0x1f4 24 dc  0  24  0 r  . .   8  8  8  0 .  .  0 24  8 16 16 16  0  0 0 Slow
0x1f5 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 24  8  0  0  0  0  0 0 None
0x1f6 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 24  8 16 16 16  0  0 0 Slow
0x1f7 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 24  8  0  0  0  0  0 0 None
0x1f8 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 24  8 16 16 16  0  0 0 Slow
0x1f9 24 dc  0  24  0 r  . .   8  8  8  0 .  .  0  0  0  0  0  0  0  2 1 None
0x1fa 24 dc  0  24  0 r  . .   8  8  8  0 .  .  0  0  0  0  0  0  0  4 1 None
0x1fb 24 dc  0  24  0 r  . .   8  8  8  0 .  .  0  0  0  0  0  0  0  8 1 None
0x1fc 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0  0  0  0  0  0  0  2 1 None
0x1fd 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0  0  0  0  0  0  0  4 1 None
0x1fe 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0  0  0  0  0  0  0  8 1 None
0x1ff 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0  0  0  0  0  0  0  2 1 None
0x200 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0  0  0  0  0  0  0  4 1 None
0x201 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0  0  0  0  0  0  0  8 1 None
0x202 24 dc  0  24  0 r  . .   8  8  8  0 .  .  0 16  0  0  0  0  0  2 1 None
0x203 24 dc  0  24  0 r  . .   8  8  8  0 .  .  0 16  0  0  0  0  0  4 1 None
0x204 24 dc  0  24  0 r  . .   8  8  8  0 .  .  0 16  0  0  0  0  0  8 1 None
0x205 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 16  0  0  0  0  0  2 1 None
0x206 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 16  0  0  0  0  0  4 1 None
0x207 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 16  0  0  0  0  0  8 1 None
0x208 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 16  0  0  0  0  0  2 1 None
0x209 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 16  0  0  0  0  0  4 1 None
0x20a 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 16  0  0  0  0  0  8 1 None
0x20b 24 dc  0  24  0 r  . .   8  8  8  0 .  .  0 24  0  0  0  0  0  2 1 None
0x20c 24 dc  0  24  0 r  . .   8  8  8  0 .  .  0 24  0  0  0  0  0  4 1 None
0x20d 24 dc  0  24  0 r  . .   8  8  8  0 .  .  0 24  0  0  0  0  0  8 1 None
0x20e 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 24  0  0  0  0  0  2 1 None
0x20f 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 24  0  0  0  0  0  4 1 None
0x210 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 24  0  0  0  0  0  8 1 None
0x211 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 24  0  0  0  0  0  2 1 None
0x212 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 24  0  0  0  0  0  4 1 None
0x213 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 24  0  0  0  0  0  8 1 None
0x214 24 dc  0  24  0 r  . .   8  8  8  0 .  .  0 24  8  0  0  0  0  2 1 None
0x215 24 dc  0  24  0 r  . .   8  8  8  0 .  .  0 24  8  0  0  0  0  4 1 None
0x216 24 dc  0  24  0 r  . .   8  8  8  0 .  .  0 24  8  0  0  0  0  8 1 None
0x217 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 24  8  0  0  0  0  2 1 None
0x218 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 24  8  0  0  0  0  4 1 None
0x219 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 24  8  0  0  0  0  8 1 None
0x21a 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 24  8  0  0  0  0  2 1 None
0x21b 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 24  8  0  0  0  0  4 1 None
0x21c 24 dc  0  24  0 r  y .   8  8  8  0 .  .  0 24  8  0  0  0  0  8 1 None
0x21d 24 dc  0  32  0 r  . .   8  8  8  8 .  s  0  0  0  0  0  0  0  0 0 None
0x21e 24 dc  0  32  0 r  . .   8  8  8  8 .  s  0  0  0 16 16 16 16  0 0 Slow
0x21f 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0  0  0  0  0  0  0  0 0 None
0x220 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0  0  0 16 16 16 16  0 0 Slow
0x221 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0  0  0  0  0  0  0  0 0 None
0x222 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0  0  0 16 16 16 16  0 0 Slow
0x223 24 dc  0  32  0 r  . .   8  8  8  8 .  s  0 16  0  0  0  0  0  0 0 None
0x224 24 dc  0  32  0 r  . .   8  8  8  8 .  s  0 16  0 16 16 16 16  0 0 Slow
0x225 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 16  0  0  0  0  0  0 0 None
0x226 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 16  0 16 16 16 16  0 0 Slow
0x227 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 16  0  0  0  0  0  0 0 None
0x228 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 16  0 16 16 16 16  0 0 Slow
0x229 24 dc  0  32  0 r  . .   8  8  8  8 .  s  0 24  0  0  0  0  0  0 0 None
0x22a 24 dc  0  32  0 r  . .   8  8  8  8 .  s  0 24  0 16 16 16 16  0 0 Slow
0x22b 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 24  0  0  0  0  0  0 0 None
0x22c 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 24  0 16 16 16 16  0 0 Slow
0x22d 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 24  0  0  0  0  0  0 0 None
0x22e 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 24  0 16 16 16 16  0 0 Slow
0x22f 24 dc  0  32  0 r  . .   8  8  8  8 .  s  0 24  8  0  0  0  0  0 0 None
0x230 24 dc  0  32  0 r  . .   8  8  8  8 .  s  0 24  8 16 16 16 16  0 0 Slow
0x231 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 24  8  0  0  0  0  0 0 None
0x232 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 24  8 16 16 16 16  0 0 Slow
0x233 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 24  8  0  0  0  0  0 0 None
0x234 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 24  8 16 16 16 16  0 0 Slow
0x235 24 dc  0  32  0 r  . .   8  8  8  8 .  s  0  0  0  0  0  0  0  2 1 None
0x236 24 dc  0  32  0 r  . .   8  8  8  8 .  s  0  0  0  0  0  0  0  4 1 None
0x237 24 dc  0  32  0 r  . .   8  8  8  8 .  s  0  0  0  0  0  0  0  8 1 None
0x238 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0  0  0  0  0  0  0  2 1 None
0x239 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0  0  0  0  0  0  0  4 1 None
0x23a 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0  0  0  0  0  0  0  8 1 None
0x23b 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0  0  0  0  0  0  0  2 1 None
0x23c 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0  0  0  0  0  0  0  4 1 None
0x23d 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0  0  0  0  0  0  0  8 1 None
0x23e 24 dc  0  32  0 r  . .   8  8  8  8 .  s  0 16  0  0  0  0  0  2 1 None
0x23f 24 dc  0  32  0 r  . .   8  8  8  8 .  s  0 16  0  0  0  0  0  4 1 None
0x240 24 dc  0  32  0 r  . .   8  8  8  8 .  s  0 16  0  0  0  0  0  8 1 None
0x241 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 16  0  0  0  0  0  2 1 None
0x242 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 16  0  0  0  0  0  4 1 None
0x243 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 16  0  0  0  0  0  8 1 None
0x244 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 16  0  0  0  0  0  2 1 None
0x245 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 16  0  0  0  0  0  4 1 None
0x246 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 16  0  0  0  0  0  8 1 None
0x247 24 dc  0  32  0 r  . .   8  8  8  8 .  s  0 24  0  0  0  0  0  2 1 None
0x248 24 dc  0  32  0 r  . .   8  8  8  8 .  s  0 24  0  0  0  0  0  4 1 None
0x249 24 dc  0  32  0 r  . .   8  8  8  8 .  s  0 24  0  0  0  0  0  8 1 None
0x24a 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 24  0  0  0  0  0  2 1 None
0x24b 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 24  0  0  0  0  0  4 1 None
0x24c 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 24  0  0  0  0  0  8 1 None
0x24d 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 24  0  0  0  0  0  2 1 None
0x24e 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 24  0  0  0  0  0  4 1 None
0x24f 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 24  0  0  0  0  0  8 1 None
0x250 24 dc  0  32  0 r  . .   8  8  8  8 .  s  0 24  8  0  0  0  0  2 1 None
0x251 24 dc  0  32  0 r  . .   8  8  8  8 .  s  0 24  8  0  0  0  0  4 1 None
0x252 24 dc  0  32  0 r  . .   8  8  8  8 .  s  0 24  8  0  0  0  0  8 1 None
0x253 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 24  8  0  0  0  0  2 1 None
0x254 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 24  8  0  0  0  0  4 1 None
0x255 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 24  8  0  0  0  0  8 1 None
0x256 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 24  8  0  0  0  0  2 1 None
0x257 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 24  8  0  0  0  0  4 1 None
0x258 24 dc  0  32  0 r  y .   8  8  8  8 .  s  0 24  8  0  0  0  0  8 1 None
0x259 24 dc  0  24  0 r  . .   8  8  8  0 .  s  0  0  0  0  0  0  0  0 0 None
0x25a 24 dc  0  24  0 r  . .   8  8  8  0 .  s  0  0  0 16 16 16  0  0 0 Slow
0x25b 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0  0  0  0  0  0  0  0 0 None
0x25c 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0  0  0 16 16 16  0  0 0 Slow
0x25d 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0  0  0  0  0  0  0  0 0 None
0x25e 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0  0  0 16 16 16  0  0 0 Slow
0x25f 24 dc  0  24  0 r  . .   8  8  8  0 .  s  0 16  0  0  0  0  0  0 0 None
0x260 24 dc  0  24  0 r  . .   8  8  8  0 .  s  0 16  0 16 16 16  0  0 0 Slow
0x261 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 16  0  0  0  0  0  0 0 None
0x262 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 16  0 16 16 16  0  0 0 Slow
0x263 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 16  0  0  0  0  0  0 0 None
0x264 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 16  0 16 16 16  0  0 0 Slow
0x265 24 dc  0  24  0 r  . .   8  8  8  0 .  s  0 24  0  0  0  0  0  0 0 None
0x266 24 dc  0  24  0 r  . .   8  8  8  0 .  s  0 24  0 16 16 16  0  0 0 Slow
0x267 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 24  0  0  0  0  0  0 0 None
0x268 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 24  0 16 16 16  0  0 0 Slow
0x269 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 24  0  0  0  0  0  0 0 None
0x26a 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 24  0 16 16 16  0  0 0 Slow
0x26b 24 dc  0  24  0 r  . .   8  8  8  0 .  s  0 24  8  0  0  0  0  0 0 None
0x26c 24 dc  0  24  0 r  . .   8  8  8  0 .  s  0 24  8 16 16 16  0  0 0 Slow
0x26d 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 24  8  0  0  0  0  0 0 None
0x26e 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 24  8 16 16 16  0  0 0 Slow
0x26f 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 24  8  0  0  0  0  0 0 None
0x270 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 24  8 16 16 16  0  0 0 Slow
0x271 24 dc  0  24  0 r  . .   8  8  8  0 .  s  0  0  0  0  0  0  0  2 1 None
0x272 24 dc  0  24  0 r  . .   8  8  8  0 .  s  0  0  0  0  0  0  0  4 1 None
0x273 24 dc  0  24  0 r  . .   8  8  8  0 .  s  0  0  0  0  0  0  0  8 1 None
0x274 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0  0  0  0  0  0  0  2 1 None
0x275 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0  0  0  0  0  0  0  4 1 None
0x276 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0  0  0  0  0  0  0  8 1 None
0x277 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0  0  0  0  0  0  0  2 1 None
0x278 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0  0  0  0  0  0  0  4 1 None
0x279 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0  0  0  0  0  0  0  8 1 None
0x27a 24 dc  0  24  0 r  . .   8  8  8  0 .  s  0 16  0  0  0  0  0  2 1 None
0x27b 24 dc  0  24  0 r  . .   8  8  8  0 .  s  0 16  0  0  0  0  0  4 1 None
0x27c 24 dc  0  24  0 r  . .   8  8  8  0 .  s  0 16  0  0  0  0  0  8 1 None
0x27d 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 16  0  0  0  0  0  2 1 None
0x27e 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 16  0  0  0  0  0  4 1 None
0x27f 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 16  0  0  0  0  0  8 1 None
0x280 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 16  0  0  0  0  0  2 1 None
0x281 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 16  0  0  0  0  0  4 1 None
0x282 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 16  0  0  0  0  0  8 1 None
0x283 24 dc  0  24  0 r  . .   8  8  8  0 .  s  0 24  0  0  0  0  0  2 1 None
0x284 24 dc  0  24  0 r  . .   8  8  8  0 .  s  0 24  0  0  0  0  0  4 1 None
0x285 24 dc  0  24  0 r  . .   8  8  8  0 .  s  0 24  0  0  0  0  0  8 1 None
0x286 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 24  0  0  0  0  0  2 1 None
0x287 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 24  0  0  0  0  0  4 1 None
0x288 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 24  0  0  0  0  0  8 1 None
0x289 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 24  0  0  0  0  0  2 1 None
0x28a 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 24  0  0  0  0  0  4 1 None
0x28b 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 24  0  0  0  0  0  8 1 None
0x28c 24 dc  0  24  0 r  . .   8  8  8  0 .  s  0 24  8  0  0  0  0  2 1 None
0x28d 24 dc  0  24  0 r  . .   8  8  8  0 .  s  0 24  8  0  0  0  0  4 1 None
0x28e 24 dc  0  24  0 r  . .   8  8  8  0 .  s  0 24  8  0  0  0  0  8 1 None
0x28f 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 24  8  0  0  0  0  2 1 None
0x290 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 24  8  0  0  0  0  4 1 None
0x291 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 24  8  0  0  0  0  8 1 None
0x292 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 24  8  0  0  0  0  2 1 None
0x293 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 24  8  0  0  0  0  4 1 None
0x294 24 dc  0  24  0 r  y .   8  8  8  0 .  s  0 24  8  0  0  0  0  8 1 None
0x295  0 dc  0  16  0 r  . .   5  6  5  0 .  .  0  0  0  0  0  0  0  0 0 None
0x296  0 dc  0  16  0 r  . .   5  6  5  0 .  .  0  0  0 16 16 16  0  0 0 Slow
0x297  0 dc  0  16  0 r  y .   5  6  5  0 .  .  0  0  0  0  0  0  0  0 0 None
0x298  0 dc  0  16  0 r  y .   5  6  5  0 .  .  0  0  0 16 16 16  0  0 0 Slow
0x299  0 dc  0  16  0 r  y .   5  6  5  0 .  .  0  0  0  0  0  0  0  0 0 None
0x29a  0 dc  0  16  0 r  y .   5  6  5  0 .  .  0  0  0 16 16 16  0  0 0 Slow
0x29b  0 dc  0  16  0 r  . .   5  6  5  0 .  .  0 16  0  0  0  0  0  0 0 None
0x29c  0 dc  0  16  0 r  . .   5  6  5  0 .  .  0 16  0 16 16 16  0  0 0 Slow
0x29d  0 dc  0  16  0 r  y .   5  6  5  0 .  .  0 16  0  0  0  0  0  0 0 None
0x29e  0 dc  0  16  0 r  y .   5  6  5  0 .  .  0 16  0 16 16 16  0  0 0 Slow
0x29f  0 dc  0  16  0 r  y .   5  6  5  0 .  .  0 16  0  0  0  0  0  0 0 None
0x2a0  0 dc  0  16  0 r  y .   5  6  5  0 .  .  0 16  0 16 16 16  0  0 0 Slow
0x2a1  0 dc  0  16  0 r  . .   5  6  5  0 .  .  0 24  0  0  0  0  0  0 0 None
0x2a2  0 dc  0  16  0 r  . .   5  6  5  0 .  .  0 24  0 16 16 16  0  0 0 Slow
0x2a3  0 dc  0  16  0 r  y .   5  6  5  0 .  .  0 24  0  0  0  0  0  0 0 None
0x2a4  0 dc  0  16  0 r  y .   5  6  5  0 .  .  0 24  0 16 16 16  0  0 0 Slow
0x2a5  0 dc  0  16  0 r  y .   5  6  5  0 .  .  0 24  0  0  0  0  0  0 0 None
0x2a6  0 dc  0  16  0 r  y .   5  6  5  0 .  .  0 24  0 16 16 16  0  0 0 Slow
0x2a7  0 dc  0  16  0 r  . .   5  6  5  0 .  .  0 24  8  0  0  0  0  0 0 None
0x2a8  0 dc  0  16  0 r  . .   5  6  5  0 .  .  0 24  8 16 16 16  0  0 0 Slow
0x2a9  0 dc  0  16  0 r  y .   5  6  5  0 .  .  0 24  8  0  0  0  0  0 0 None
0x2aa  0 dc  0  16  0 r  y .   5  6  5  0 .  .  0 24  8 16 16 16  0  0 0 Slow
0x2ab  0 dc  0  16  0 r  y .   5  6  5  0 .  .  0 24  8  0  0  0  0  0 0 None
0x2ac  0 dc  0  16  0 r  y .   5  6  5  0 .  .  0 24  8 16 16 16  0  0 0 Slow
0x2ad  0 dc  0  16  0 r  . .   5  6  5  0 .  .  0  0  0  0  0  0  0  2 1 None
0x2ae  0 dc  0  16  0 r  . .   5  6  5  0 .  .  0  0  0  0  0  0  0  4 1 None
0x2af  0 dc  0  16  0 r  . .   5  6  5  0 .  .  0  0  0  0  0  0  0  8 1 None
0x2b0  0 dc  0  16  0 r  y .   5  6  5  0 .  .  0  0  0  0  0  0  0  2 1 None
0x2b1  0 dc  0  16  0 r  y .   5  6  5  0 .  .  0  0  0  0  0  0  0  4 1 None
0x2b2  0 dc  0  16  0 r  y .   5  6  5  0 .  .  0  0  0  0  0  0  0  8 1 None
0x2b3  0 dc  0  16  0 r  y .   5  6  5  0 .  .  0  0  0  0  0  0  0  2 1 None
0x2b4  0 dc  0  16  0 r  y .   5  6  5  0 .  .  0  0  0  0  0  0  0  4 1 None
0x2b5  0 dc  0  16  0 r  y .   5  6  5  0 .  .  0  0  0  0  0  0  0  8 1 None
0x2b6  0 dc  0  16  0 r  . .   5  6  5  0 .  .  0 16  0  0  0  0  0  2 1 None
0x2b7  0 dc  0  16  0 r  . .   5  6  5  0 .  .  0 16  0  0  0  0  0  4 1 None
0x2b8  0 dc  0  16  0 r  . .   5  6  5  0 .  .  0 16  0  0  0  0  0  8 1 None
0x2b9  0 dc  0  16  0 r  y .   5  6  5  0 .  .  0 16  0  0  0  0  0  2 1 None
0x2ba  0 dc  0  16  0 r  y .   5  6  5  0 .  .  0 16  0  0  0  0  0  4 1 None
0x2bb  0 dc  0  16  0 r  y .   5  6  5  0 .  .  0 16  0  0  0  0  0  8 1 None
0x2bc  0 dc  0  16  0 r  y .   5  6  5  0 .  .  0 16  0  0  0  0  0  2 1 None
0x2bd  0 dc  0  16  0 r  y .   5  6  5  0 .  .  0 16  0  0  0  0  0  4 1 None
0x2be  0 dc  0  16  0 r  y .   5  6  5  0 .  .  0 16  0  0  0  0  0  8 1 None
0x2bf  0 dc  0  16  0 r  . .   5  6  5  0 .  .  0 24  0  0  0  0  0  2 1 None
0x2c0  0 dc  0  16  0 r  . .   5  6  5  0 .  .  0 24  0  0  0  0  0  4 1 None
0x2c1  0 dc  0  16  0 r  . .   5  6  5  0 .  .  0 24  0  0  0  0  0  8 1 None
0x2c2  0 dc  0  16  0 r  y .   5  6  5  0 .  .  0 24  0  0  0  0  0  2 1 None
0x2c3  0 dc  0  16  0 r  y .   5  6  5  0 .  .  0 24  0  0  0  0  0  4 1 None
0x2c4  0 dc  0  16  0 r  y .   5  6  5  0 .  .  0 24  0  0  0  0  0  8 1 None
0x2c5  0 dc  0  16  0 r  y .   5  6  5  0 .  .  0 24  0  0  0  0  0  2 1 None
0x2c6  0 dc  0  16  0 r  y .   5  6  5  0 .  .  0 24  0  0  0  0  0  4 1 None
0x2c7  0 dc  0  16  0 r  y .   5  6  5  0 .  .  0 24  0  0  0  0  0  8 1 None
0x2c8  0 dc  0  16  0 r  . .   5  6  5  0 .  .  0 24  8  0  0  0  0  2 1 None
0x2c9  0 dc  0  16  0 r  . .   5  6  5  0 .  .  0 24  8  0  0  0  0  4 1 None
0x2ca  0 dc  0  16  0 r  . .   5  6  5  0 .  .  0 24  8  0  0  0  0  8 1 None
0x2cb  0 dc  0  16  0 r  y .   5  6  5  0 .  .  0 24  8  0  0  0  0  2 1 None
0x2cc  0 dc  0  16  0 r  y .   5  6  5  0 .  .  0 24  8  0  0  0  0  4 1 None
0x2cd  0 dc  0  16  0 r  y .   5  6  5  0 .  .  0 24  8  0  0  0  0  8 1 None
0x2ce  0 dc  0  16  0 r  y .   5  6  5  0 .  .  0 24  8  0  0  0  0  2 1 None
0x2cf  0 dc  0  16  0 r  y .   5  6  5  0 .  .  0 24  8  0  0  0  0  4 1 None
0x2d0  0 dc  0  16  0 r  y .   5  6  5  0 .  .  0 24  8  0  0  0  0  8 1 None


--nextPart1554459.CH0NS1MyuD
Content-Disposition: attachment; filename="lspci.log"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-log; charset="utf-8"; name="lspci.log"

00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h (Models 30h-3fh) Processor Root Complex
	Subsystem: ASUSTeK Computer Inc. Family 15h (Models 30h-3fh) Processor Root Complex
	Flags: bus master, fast devsel, latency 0

00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Family 15h (Models 30h-3fh) I/O Memory Management Unit
	Subsystem: ASUSTeK Computer Inc. Family 15h (Models 30h-3fh) I/O Memory Management Unit
	Flags: fast devsel, IRQ 24
	Capabilities: [40] Secure device <?>
	Capabilities: [54] MSI: Enable+ Count=1/4 Maskable- 64bit+
	Capabilities: [64] HyperTransport: MSI Mapping Enable+ Fixed+

00:01.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Kaveri [Radeon R7 Graphics] (prog-if 00 [VGA controller])
	Subsystem: ASUSTeK Computer Inc. Kaveri [Radeon R7 Graphics]
	Flags: bus master, fast devsel, latency 0, IRQ 49
	Memory at d0000000 (64-bit, prefetchable) [size=256M]
	Memory at f0800000 (64-bit, prefetchable) [size=8M]
	I/O ports at f000 [size=256]
	Memory at feb00000 (32-bit, non-prefetchable) [size=256K]
	Expansion ROM at 000c0000 [disabled] [size=128K]
	Capabilities: [48] Vendor Specific Information: Len=08 <?>
	Capabilities: [50] Power Management version 3
	Capabilities: [58] Express Root Complex Integrated Endpoint, MSI 00
	Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
	Capabilities: [100] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
	Capabilities: [270] #19
	Capabilities: [2b0] Address Translation Service (ATS)
	Capabilities: [2c0] Page Request Interface (PRI)
	Capabilities: [2d0] Process Address Space ID (PASID)
	Kernel driver in use: amdgpu
	Kernel modules: amdgpu

00:01.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Kaveri HDMI/DP Audio Controller
	Subsystem: ASUSTeK Computer Inc. Kaveri HDMI/DP Audio Controller
	Flags: bus master, fast devsel, latency 0, IRQ 51
	Memory at feb64000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [48] Vendor Specific Information: Len=08 <?>
	Capabilities: [50] Power Management version 3
	Capabilities: [58] Express Root Complex Integrated Endpoint, MSI 00
	Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
	Capabilities: [100] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
	Kernel driver in use: snd_hda_intel
	Kernel modules: snd_hda_intel

00:02.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1424
	Flags: fast devsel

00:02.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 1425 (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0, IRQ 16
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000e000-0000efff [size=4K]
	Memory behind bridge: fea00000-feafffff [size=1M]
	Prefetchable memory behind bridge: 00000000e0000000-00000000f01fffff [size=258M]
	Capabilities: [50] Power Management version 3
	Capabilities: [58] Express Root Port (Slot+), MSI 00
	Capabilities: [a0] MSI: Enable- Count=1/1 Maskable- 64bit+
	Capabilities: [b0] Subsystem: ASUSTeK Computer Inc. Device 85cb
	Capabilities: [b8] HyperTransport: MSI Mapping Enable+ Fixed+
	Capabilities: [100] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
	Capabilities: [270] #19
	Kernel driver in use: pcieport

00:03.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1424
	Flags: fast devsel

00:04.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1424
	Flags: fast devsel

00:10.0 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB XHCI Controller (rev 09) (prog-if 30 [XHCI])
	Subsystem: ASUSTeK Computer Inc. FCH USB XHCI Controller
	Flags: bus master, fast devsel, latency 0, IRQ 18
	Memory at feb6a000 (64-bit, non-prefetchable) [size=8K]
	Capabilities: [50] Power Management version 3
	Capabilities: [70] MSI: Enable- Count=1/8 Maskable- 64bit+
	Capabilities: [90] MSI-X: Enable+ Count=8 Masked-
	Capabilities: [a0] Express Root Complex Integrated Endpoint, MSI 00
	Capabilities: [100] Latency Tolerance Reporting
	Kernel driver in use: xhci_hcd
	Kernel modules: xhci_pci

00:10.1 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB XHCI Controller (rev 09) (prog-if 30 [XHCI])
	Subsystem: ASUSTeK Computer Inc. FCH USB XHCI Controller
	Flags: bus master, fast devsel, latency 0, IRQ 17
	Memory at feb68000 (64-bit, non-prefetchable) [size=8K]
	Capabilities: [50] Power Management version 3
	Capabilities: [70] MSI: Enable- Count=1/8 Maskable- 64bit+
	Capabilities: [90] MSI-X: Enable+ Count=8 Masked-
	Capabilities: [a0] Express Root Complex Integrated Endpoint, MSI 00
	Kernel driver in use: xhci_hcd
	Kernel modules: xhci_pci

00:11.0 SATA controller: Advanced Micro Devices, Inc. [AMD] FCH SATA Controller [AHCI mode] (rev 40) (prog-if 01 [AHCI 1.0])
	Subsystem: ASUSTeK Computer Inc. FCH SATA Controller [AHCI mode]
	Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 40
	I/O ports at f140 [size=8]
	I/O ports at f130 [size=4]
	I/O ports at f120 [size=8]
	I/O ports at f110 [size=4]
	I/O ports at f100 [size=16]
	Memory at feb70000 (32-bit, non-prefetchable) [size=2K]
	Capabilities: [50] MSI: Enable+ Count=8/8 Maskable- 64bit+
	Capabilities: [70] SATA HBA v1.0
	Kernel driver in use: ahci
	Kernel modules: ahci

00:12.0 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB OHCI Controller (rev 11) (prog-if 10 [OHCI])
	Subsystem: ASUSTeK Computer Inc. FCH USB OHCI Controller
	Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 18
	Memory at feb6f000 (32-bit, non-prefetchable) [size=4K]
	Kernel driver in use: ohci-pci
	Kernel modules: ohci_pci

00:12.2 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB EHCI Controller (rev 11) (prog-if 20 [EHCI])
	Subsystem: ASUSTeK Computer Inc. FCH USB EHCI Controller
	Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 17
	Memory at feb6e000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [c0] Power Management version 2
	Capabilities: [e4] Debug port: BAR=1 offset=00e0
	Kernel driver in use: ehci-pci
	Kernel modules: ehci_pci

00:13.0 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB OHCI Controller (rev 11) (prog-if 10 [OHCI])
	Subsystem: ASUSTeK Computer Inc. FCH USB OHCI Controller
	Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 18
	Memory at feb6d000 (32-bit, non-prefetchable) [size=4K]
	Kernel driver in use: ohci-pci
	Kernel modules: ohci_pci

00:13.2 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB EHCI Controller (rev 11) (prog-if 20 [EHCI])
	Subsystem: ASUSTeK Computer Inc. FCH USB EHCI Controller
	Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 17
	Memory at feb6c000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [c0] Power Management version 2
	Capabilities: [e4] Debug port: BAR=1 offset=00e0
	Kernel driver in use: ehci-pci
	Kernel modules: ehci_pci

00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller (rev 16)
	Subsystem: ASUSTeK Computer Inc. FCH SMBus Controller
	Flags: 66MHz, medium devsel

00:14.2 Audio device: Advanced Micro Devices, Inc. [AMD] FCH Azalia Controller (rev 01)
	Subsystem: ASUSTeK Computer Inc. FCH Azalia Controller
	Flags: bus master, slow devsel, latency 32, IRQ 16
	Memory at feb60000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
	Kernel driver in use: snd_hda_intel
	Kernel modules: snd_hda_intel

00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge (rev 11)
	Subsystem: ASUSTeK Computer Inc. FCH LPC Bridge
	Flags: bus master, 66MHz, medium devsel, latency 0

00:14.4 PCI bridge: Advanced Micro Devices, Inc. [AMD] FCH PCI Bridge (rev 40) (prog-if 01 [Subtractive decode])
	Flags: bus master, VGA palette snoop, 66MHz, medium devsel, latency 64
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
	I/O behind bridge: None
	Memory behind bridge: None
	Prefetchable memory behind bridge: None

00:15.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] Hudson PCI to PCI bridge (PCIE port 0) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0, IRQ 16
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: None
	Memory behind bridge: None
	Prefetchable memory behind bridge: None
	Capabilities: [50] Power Management version 3
	Capabilities: [58] Express Root Port (Slot-), MSI 00
	Capabilities: [a0] MSI: Enable- Count=1/1 Maskable- 64bit+
	Capabilities: [b0] Subsystem: Advanced Micro Devices, Inc. [AMD] Hudson PCI to PCI bridge (PCIE port 0)
	Capabilities: [b8] HyperTransport: MSI Mapping Enable+ Fixed+
	Capabilities: [100] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
	Kernel driver in use: pcieport

00:15.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Hudson PCI to PCI bridge (PCIE port 1) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0, IRQ 16
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
	I/O behind bridge: None
	Memory behind bridge: fe900000-fe9fffff [size=1M]
	Prefetchable memory behind bridge: None
	Capabilities: [50] Power Management version 3
	Capabilities: [58] Express Root Port (Slot-), MSI 00
	Capabilities: [a0] MSI: Enable- Count=1/1 Maskable- 64bit+
	Capabilities: [b0] Subsystem: Advanced Micro Devices, Inc. [AMD] Hudson PCI to PCI bridge (PCIE port 1)
	Capabilities: [b8] HyperTransport: MSI Mapping Enable+ Fixed+
	Capabilities: [100] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
	Kernel driver in use: pcieport

00:15.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Hudson PCI to PCI bridge (PCIE port 2) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0, IRQ 16
	Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff [size=4K]
	Memory behind bridge: fe800000-fe8fffff [size=1M]
	Prefetchable memory behind bridge: 00000000f1000000-00000000f10fffff [size=1M]
	Capabilities: [50] Power Management version 3
	Capabilities: [58] Express Root Port (Slot-), MSI 00
	Capabilities: [a0] MSI: Enable- Count=1/1 Maskable- 64bit+
	Capabilities: [b0] Subsystem: Advanced Micro Devices, Inc. [AMD] Hudson PCI to PCI bridge (PCIE port 2)
	Capabilities: [b8] HyperTransport: MSI Mapping Enable+ Fixed+
	Capabilities: [100] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
	Kernel driver in use: pcieport

00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h (Models 30h-3fh) Processor Function 0
	Flags: fast devsel

00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h (Models 30h-3fh) Processor Function 1
	Flags: fast devsel

00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h (Models 30h-3fh) Processor Function 2
	Flags: fast devsel

00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h (Models 30h-3fh) Processor Function 3
	Flags: fast devsel
	Capabilities: [f0] Secure device <?>
	Kernel driver in use: k10temp
	Kernel modules: k10temp

00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h (Models 30h-3fh) Processor Function 4
	Flags: fast devsel
	Kernel driver in use: fam15h_power
	Kernel modules: fam15h_power

00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h (Models 30h-3fh) Processor Function 5
	Flags: fast devsel

01:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Baffin [Radeon RX 560] (rev cf) (prog-if 00 [VGA controller])
	Subsystem: ASUSTeK Computer Inc. Baffin [Radeon RX 560]
	Flags: fast devsel, IRQ 50
	Memory at e0000000 (64-bit, prefetchable) [size=256M]
	Memory at f0000000 (64-bit, prefetchable) [size=2M]
	I/O ports at e000 [size=256]
	Memory at fea00000 (32-bit, non-prefetchable) [size=256K]
	Expansion ROM at fea40000 [disabled] [size=128K]
	Capabilities: [48] Vendor Specific Information: Len=08 <?>
	Capabilities: [50] Power Management version 3
	Capabilities: [58] Express Legacy Endpoint, MSI 00
	Capabilities: [a0] MSI: Enable- Count=1/1 Maskable- 64bit+
	Capabilities: [100] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
	Capabilities: [150] Advanced Error Reporting
	Capabilities: [200] #15
	Capabilities: [270] #19
	Capabilities: [2b0] Address Translation Service (ATS)
	Capabilities: [2c0] Page Request Interface (PRI)
	Capabilities: [2d0] Process Address Space ID (PASID)
	Capabilities: [320] Latency Tolerance Reporting
	Capabilities: [328] Alternative Routing-ID Interpretation (ARI)
	Capabilities: [370] L1 PM Substates
	Kernel modules: amdgpu

01:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Device aae0
	Subsystem: ASUSTeK Computer Inc. Device aae0
	Flags: bus master, fast devsel, latency 0, IRQ 53
	Memory at fea60000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [48] Vendor Specific Information: Len=08 <?>
	Capabilities: [50] Power Management version 3
	Capabilities: [58] Express Legacy Endpoint, MSI 00
	Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
	Capabilities: [100] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
	Capabilities: [150] Advanced Error Reporting
	Capabilities: [328] Alternative Routing-ID Interpretation (ARI)
	Kernel driver in use: snd_hda_intel
	Kernel modules: snd_hda_intel

04:00.0 USB controller: ASMedia Technology Inc. ASM1042A USB 3.0 Host Controller (prog-if 30 [XHCI])
	Subsystem: ASUSTeK Computer Inc. ASM1042A USB 3.0 Host Controller
	Flags: bus master, fast devsel, latency 0, IRQ 17
	Memory at fe900000 (64-bit, non-prefetchable) [size=32K]
	Capabilities: [50] MSI: Enable- Count=1/8 Maskable- 64bit+
	Capabilities: [68] MSI-X: Enable+ Count=8 Masked-
	Capabilities: [78] Power Management version 3
	Capabilities: [80] Express Legacy Endpoint, MSI 00
	Capabilities: [100] Virtual Channel
	Kernel driver in use: xhci_hcd
	Kernel modules: xhci_pci

05:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 11)
	Subsystem: ASUSTeK Computer Inc. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller
	Flags: bus master, fast devsel, latency 0, IRQ 54
	I/O ports at d000 [size=256]
	Memory at fe800000 (64-bit, non-prefetchable) [size=4K]
	Memory at f1000000 (64-bit, prefetchable) [size=16K]
	Capabilities: [40] Power Management version 3
	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
	Capabilities: [70] Express Endpoint, MSI 01
	Capabilities: [b0] MSI-X: Enable- Count=4 Masked-
	Capabilities: [d0] Vital Product Data
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [140] Virtual Channel
	Capabilities: [160] Device Serial Number 01-00-00-00-68-4c-e0-00
	Capabilities: [170] Latency Tolerance Reporting
	Kernel driver in use: r8169
	Kernel modules: r8169


--nextPart1554459.CH0NS1MyuD--

--nextPart2250314.hWhE7FQ4uC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQGzBAABCAAdFiEE0Ngi/nirHnbsz3NFz+h/M161qdwFAlnvFNUACgkQz+h/M161
qdzHbQv+ICCNZKk38U4ndViOCamuTCKitm6pmkRqJTOwJoR8eFnjO1Zl8zY3lkd/
7MBMt0CWyxsE/M+pYsF4ceWiXTgZrdWzEk3gtmartlmnIY0auE8prhZVOpAbYihi
MDf45JVXBNQJK69x2tIMvURZRVZygCOBks0Hnbkz7cOCqqv4pVOvDYMBe8tQfEiO
GgbTN+FBP6AlybGBWkpXG7iw5TbW/HHVvnJOhSmCkBH9k5br7CJcFRmsg3UeaF+6
DSyWavPhIrQnwfGnu5Zt6s+bwSUl/Jkqwk6nQfiGeWZwoDOjdexa/HcWKQNPIzGa
ZevJkVBJ8Mm+ZfjXXXMrb46qfusOveZJXCc5SrRJGStQKEA+OIdf/OtySVwlUVIM
1P+hnSX3B0Hap2KHsLtaIkL0URbCxXkSwMoz3Fl0LpX9rXtXdvRHcZirVrBn+AdC
RKquS1JhoMqIqSnPgCat1MotzMcUPjRqMuMR6JfjC1XsoMV05woJidAdP0IyruBE
iDHjm/Mq
=bOak
-----END PGP SIGNATURE-----

--nextPart2250314.hWhE7FQ4uC--


--===============1579517317==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1579517317==--
