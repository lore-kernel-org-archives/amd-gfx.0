From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu/gmc: steal the appropriate amount of vram
 for fw hand-over (v2)
Date: Tue, 10 Apr 2018 18:53:12 +0800
Message-ID: <20180410105307.GA24140@hr-amur2>
References: <20180406195410.5622-1-alexander.deucher@amd.com>
 <20180409082304.GA15597@hr-amur2>
 <BN6PR1201MB01156ABA821FA7D9533C6227EABF0@BN6PR1201MB0115.namprd12.prod.outlook.com>
 <46fd832a-8169-39a5-a235-750a648736a1@gmail.com>
 <c92643de-25f7-2aed-d445-be23a979a3d9@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fdj2RfSjLxBAspz7"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <c92643de-25f7-2aed-d445-be23a979a3d9-5C7GfCeVMHo@public.gmane.org>
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
To: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Cc: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, christian.koenig-5C7GfCeVMHo@public.gmane.org, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Mon, Apr 09, 2018 at 11:17:58AM -0400, Andrey Grodzovsky wrote:
> OK, tested with DC disabled , no issues on resume (no visible
> corruption on display or errors in log). Now the display itself
> freezes after amdgpu is loaded with DC disabled, this happens only
> when BIOS in VGA mode , in console mode no such problem. Happens
> before my and Alex patches, looks like a separate issue.
> 
> So anyway, if corruption would be there (beginning of VRAM and hence
> scanout FB corrupted) , i should have seen it with grub in console
> mode where display is fine and not freezing.
> 

Reproduce steps:
1. sudo modprobe amdgpu dc=0 ip_block_mask=0x7f
2. pm-suspend/resume two times.

You will see the start of vram is corrupted after S3 resume.

[  570.343635] [drm] PCIE GART of 512M enabled (table at 0x000000F400000000).
[  570.343642] [drm] PSP is resuming...
[  570.343713] gmc_v9_0_process_interrupt: 12 callbacks suppressed
[  570.343715] amdgpu 0000:03:00.0: [mmhub] VMC page fault (src_id:0 ring:0 vmid:0 pasid:0)
[  570.343716] amdgpu 0000:03:00.0:   at page 0x000000f600700000 from 18
[  570.343716] amdgpu 0000:03:00.0: VM_L2_PROTECTION_FAULT_STATUS:0x00000010
[  570.525510] [drm:psp_resume [amdgpu]] *ERROR* PSP resume failed
[  570.525523] [drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *ERROR* resume of IP block <psp> failed -62
[  570.525536] [drm:amdgpu_device_resume [amdgpu]] *ERROR* amdgpu_device_ip_resume failed (-62).
[  570.536704] e1000e: enp0s31f6 NIC Link is Up 100 Mbps Full Duplex, Flow Control: Rx/Tx
[  570.540496] dpm_run_callback(): pci_pm_resume+0x0/0xa0 returns -62
[  570.547879] e1000e 0000:00:1f.6 enp0s31f6: 10/100 speed: disabling TSO
[  570.555434] call 0000:03:00.0+ returned -62 after 1973202 usecs
[  570.689812] PM: Device 0000:03:00.0 failed to resume async: error -62

I attached the whole dmesg.

Thanks,
Ray

--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="2_times_s3.txt"

[    0.000000] Linux version 4.16.0-rc7-custom (root@hr-intel) (gcc version 4.8.2 (GCC)) #1 SMP Tue Apr 10 15:23:37 CST 2018
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-4.16.0-rc7-custom root=UUID=3fff528d-c596-4838-98fc-04c92d819ed2 ro text no_console_suspend initcall_debug=y main.dyndbg=+p core.dyndbg=+p iommu=off pcie_aspm=off mem=1024M loglevel=8 console=ttyS0,115200
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Centaur CentaurHauls
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    0.000000] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    0.000000] x86/fpu: Enabled xstate features 0x1f, context size is 960 bytes, using 'compacted' format.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009c7ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009c800-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000b5580fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000b5581000-0x00000000b5581fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000b5582000-0x00000000b5582fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000b5583000-0x00000000bde42fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bde43000-0x00000000be242fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000be243000-0x00000000be4d3fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000be4d4000-0x00000000beb7efff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000beb7f000-0x00000000bf6fefff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000bf6ff000-0x00000000bf6fffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bf700000-0x00000000bfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f0000000-0x00000000f7ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000043effffff] usable
[    0.000000] e820: remove [mem 0x40000000-0xfffffffffffffffe] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] e820: user-defined physical RAM map:
[    0.000000] user: [mem 0x0000000000000000-0x000000000009c7ff] usable
[    0.000000] user: [mem 0x000000000009c800-0x000000000009ffff] reserved
[    0.000000] user: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] user: [mem 0x0000000000100000-0x000000003fffffff] usable
[    0.000000] user: [mem 0x00000000b5581000-0x00000000b5581fff] ACPI NVS
[    0.000000] user: [mem 0x00000000b5582000-0x00000000b5582fff] reserved
[    0.000000] user: [mem 0x00000000bde43000-0x00000000be242fff] reserved
[    0.000000] user: [mem 0x00000000be4d4000-0x00000000beb7efff] ACPI NVS
[    0.000000] user: [mem 0x00000000beb7f000-0x00000000bf6fefff] reserved
[    0.000000] user: [mem 0x00000000bf700000-0x00000000bfffffff] reserved
[    0.000000] user: [mem 0x00000000f0000000-0x00000000f7ffffff] reserved
[    0.000000] user: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
[    0.000000] user: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] user: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] user: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] random: fast init done
[    0.000000] SMBIOS 3.0.0 present.
[    0.000000] DMI: Gigabyte Technology Co., Ltd. Z170XP-SLI/Z170XP-SLI-CF, BIOS F20 11/04/2016
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x40000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: write-back
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 00C0000000 mask 7FC0000000 uncachable
[    0.000000]   1 disabled
[    0.000000]   2 disabled
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000]   8 disabled
[    0.000000]   9 disabled
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000000] found SMP MP-table at [mem 0x000fcce0-0x000fccef] mapped at [        (ptrval)]
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] Base memory trampoline at [        (ptrval)] 96000 size 24576
[    0.000000] Using GB pages for direct mapping
[    0.000000] BRK [0x0ac19000, 0x0ac19fff] PGTABLE
[    0.000000] BRK [0x0ac1a000, 0x0ac1afff] PGTABLE
[    0.000000] BRK [0x0ac1b000, 0x0ac1bfff] PGTABLE
[    0.000000] BRK [0x0ac1c000, 0x0ac1cfff] PGTABLE
[    0.000000] RAMDISK: [mem 0x32e7c000-0x35735fff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F05B0 000024 (v02 ALASKA)
[    0.000000] ACPI: XSDT 0x00000000BE7D40A0 0000BC (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FACP 0x00000000BE7FBFE8 000114 (v06 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: DSDT 0x00000000BE7D41F0 027DF8 (v02 ALASKA A M I    01072009 INTL 20160422)
[    0.000000] ACPI: FACS 0x00000000BEB7EC40 000040
[    0.000000] ACPI: APIC 0x00000000BE7FC100 0000BC (v03 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FPDT 0x00000000BE7FC1C0 000044 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: MCFG 0x00000000BE7FC208 00003C (v01 ALASKA A M I    01072009 MSFT 00000097)
[    0.000000] ACPI: FIDT 0x00000000BE7FC248 00009C (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: SSDT 0x00000000BE7FC2E8 003154 (v02 SaSsdt SaSsdt   00003000 INTL 20160422)
[    0.000000] ACPI: SSDT 0x00000000BE7FF440 002544 (v02 PegSsd PegSsdt  00001000 INTL 20160422)
[    0.000000] ACPI: HPET 0x00000000BE801988 000038 (v01 INTEL  SKL      00000001 MSFT 0000005F)
[    0.000000] ACPI: SSDT 0x00000000BE8019C0 000E3B (v02 INTEL  Ther_Rvp 00001000 INTL 20160422)
[    0.000000] ACPI: SSDT 0x00000000BE802800 0008FF (v02 INTEL  xh_rvp10 00000000 INTL 20160422)
[    0.000000] ACPI: UEFI 0x00000000BE803100 000042 (v01 INTEL  EDK2     00000002      01000013)
[    0.000000] ACPI: SSDT 0x00000000BE803148 000EDE (v02 CpuRef CpuSsdt  00003000 INTL 20160422)
[    0.000000] ACPI: LPIT 0x00000000BE804028 000094 (v01 INTEL  SKL      00000000 MSFT 0000005F)
[    0.000000] ACPI: WSMT 0x00000000BE8040C0 000028 (v01 INTEL  SKL      00000000 MSFT 0000005F)
[    0.000000] ACPI: SSDT 0x00000000BE8040E8 00029F (v02 INTEL  sensrhub 00000000 INTL 20160422)
[    0.000000] ACPI: SSDT 0x00000000BE804388 003002 (v02 INTEL  PtidDevc 00001000 INTL 20160422)
[    0.000000] ACPI: DBGP 0x00000000BE807390 000034 (v01 INTEL           00000002 MSFT 0000005F)
[    0.000000] ACPI: DBG2 0x00000000BE8073C8 000054 (v00 INTEL           00000002 MSFT 0000005F)
[    0.000000] ACPI: DMAR 0x00000000BE807420 000070 (v01 INTEL  SKL      00000001 INTL 00000001)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000003fffffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x3fffc000-0x3fffffff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x000000003fffffff]
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009bfff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x000000003fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000003fffffff]
[    0.000000] On node 0 totalpages: 262043
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 21 pages reserved
[    0.000000]   DMA zone: 3995 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 4032 pages used for memmap
[    0.000000]   DMA32 zone: 258048 pages, LIFO batch:31
[    0.000000] Reserved but unavailable: 101 pages
[    0.000000] ACPI: PM-Timer IO Port: 0x1808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] [Firmware Bug]: TSC_DEADLINE disabled due to Errata; please update microcode to version: 0xb2 (or later)
[    0.000000] smpboot: Allowing 8 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009c000-0x0009cfff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009d000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000dffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000e0000-0x000fffff]
[    0.000000] e820: [mem 0x40000000-0xb5580fff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.000000] setup_percpu: NR_CPUS:256 nr_cpumask_bits:256 nr_cpu_ids:8 nr_node_ids:1
[    0.000000] percpu: Embedded 45 pages/cpu @        (ptrval) s145816 r8192 d30312 u262144
[    0.000000] pcpu-alloc: s145816 r8192 d30312 u262144 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 257926
[    0.000000] Policy zone: DMA32
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-4.16.0-rc7-custom root=UUID=3fff528d-c596-4838-98fc-04c92d819ed2 ro text no_console_suspend initcall_debug=y main.dyndbg=+p core.dyndbg=+p iommu=off pcie_aspm=off mem=1024M loglevel=8 console=ttyS0,115200
[    0.000000] PCIe ASPM is disabled
[    0.000000] Memory: 959664K/1048172K available (12300K kernel code, 1522K rwdata, 3720K rodata, 2316K init, 2844K bss, 88508K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] Kernel/User page tables isolation: enabled
[    0.000000] ftrace: allocating 37033 entries in 145 pages
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=8.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
[    0.000000] NR_IRQS: 16640, nr_irqs: 2048, preallocated irqs: 16
[    0.000000] 	Offload RCU callbacks from CPUs: .
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [ttyS0] enabled
[    0.000000] ACPI: Core revision 20180105
[    0.000000] ACPI: 8 ACPI AML tables successfully acquired and loaded
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635855245 ns
[    0.000000] hpet clockevent registered
[    0.004000] APIC: Switch to symmetric I/O mode setup
[    0.008000] DMAR: Host address width 39
[    0.012000] DMAR: DRHD base: 0x000000fed90000 flags: 0x1
[    0.016000] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap d2008c40660462 ecap f050da
[    0.020000] DMAR: RMRR base: 0x000000be19a000 end: 0x000000be1b9fff
[    0.024000] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed90000 IOMMU 0
[    0.028000] DMAR-IR: HPET id 0 under DRHD base 0xfed90000
[    0.032000] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
[    0.036000] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.036000] x2apic enabled
[    0.040000] Switched APIC routing to cluster x2apic.
[    0.048000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.068000] tsc: Detected 3400.000 MHz processor
[    0.072000] tsc: Detected 3408.000 MHz TSC
[    0.072000] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x311fd3cd494, max_idle_ns: 440795223879 ns
[    0.080001] Calibrating delay loop (skipped), value calculated using timer frequency.. 6816.00 BogoMIPS (lpj=13632000)
[    0.084001] pid_max: default: 32768 minimum: 301
[    0.088072] Security Framework initialized
[    0.092002] Yama: becoming mindful.
[    0.096032] AppArmor: AppArmor initialized
[    0.100195] Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.104090] Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
[    0.108028] Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
[    0.112006] Mountpoint-cache hash table entries: 2048 (order: 2, 16384 bytes)
[    0.116329] CPU: Physical Processor ID: 0
[    0.120001] CPU: Processor Core ID: 0
[    0.124005] mce: CPU supports 10 MCE banks
[    0.128009] CPU0: Thermal monitoring enabled (TM1)
[    0.132013] process: using mwait in idle threads
[    0.136002] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
[    0.140000] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    0.144001] Spectre V2 : Vulnerable: Minimal generic ASM retpoline
[    0.148000] Spectre V2 : Spectre v2 mitigation: Filling RSB on context switch
[    0.152058] Freeing SMP alternatives memory: 36K
[    0.160000] smpboot: CPU0: Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz (family: 0x6, model: 0x5e, stepping: 0x3)
[    0.160084] calling  trace_init_flags_sys_exit+0x0/0xf @ 1
[    0.164002] initcall trace_init_flags_sys_exit+0x0/0xf returned 0 after 0 usecs
[    0.168001] calling  trace_init_flags_sys_enter+0x0/0xf @ 1
[    0.172001] initcall trace_init_flags_sys_enter+0x0/0xf returned 0 after 0 usecs
[    0.176001] calling  init_hw_perf_events+0x0/0x5ab @ 1
[    0.180000] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.
[    0.184003] ... version:                4
[    0.188000] ... bit width:              48
[    0.192000] ... generic registers:      4
[    0.196000] ... value mask:             0000ffffffffffff
[    0.200000] ... max period:             00007fffffffffff
[    0.204000] ... fixed-purpose events:   3
[    0.208000] ... event mask:             000000070000000f
[    0.212021] initcall init_hw_perf_events+0x0/0x5ab returned 0 after 31250 usecs
[    0.216001] calling  init_real_mode+0x0/0x1b8 @ 1
[    0.220008] initcall init_real_mode+0x0/0x1b8 returned 0 after 0 usecs
[    0.224001] calling  trace_init_perf_perm_irq_work_exit+0x0/0x13 @ 1
[    0.228001] initcall trace_init_perf_perm_irq_work_exit+0x0/0x13 returned 0 after 0 usecs
[    0.232002] calling  register_nmi_cpu_backtrace_handler+0x0/0x16 @ 1
[    0.236001] initcall register_nmi_cpu_backtrace_handler+0x0/0x16 returned 0 after 0 usecs
[    0.240001] calling  numachip_system_init+0x0/0x67 @ 1
[    0.244001] initcall numachip_system_init+0x0/0x67 returned 0 after 0 usecs
[    0.248001] calling  early_efi_map_fb+0x0/0x32 @ 1
[    0.252001] initcall early_efi_map_fb+0x0/0x32 returned 0 after 0 usecs
[    0.256001] calling  spawn_ksoftirqd+0x0/0x40 @ 1
[    0.260019] initcall spawn_ksoftirqd+0x0/0x40 returned 0 after 0 usecs
[    0.264001] calling  migration_init+0x0/0x34 @ 1
[    0.268001] initcall migration_init+0x0/0x34 returned 0 after 0 usecs
[    0.272001] calling  check_cpu_stall_init+0x0/0x1b @ 1
[    0.276001] initcall check_cpu_stall_init+0x0/0x1b returned 0 after 0 usecs
[    0.280001] calling  srcu_bootup_announce+0x0/0x34 @ 1
[    0.284000] Hierarchical SRCU implementation.
[    0.288001] initcall srcu_bootup_announce+0x0/0x34 returned 0 after 3906 usecs
[    0.292001] calling  rcu_spawn_gp_kthread+0x0/0x13a @ 1
[    0.296028] initcall rcu_spawn_gp_kthread+0x0/0x13a returned 0 after 0 usecs
[    0.300001] calling  cpu_stop_init+0x0/0x91 @ 1
[    0.304020] initcall cpu_stop_init+0x0/0x91 returned 0 after 0 usecs
[    0.308001] calling  init_events+0x0/0x3a @ 1
[    0.312006] initcall init_events+0x0/0x3a returned 0 after 0 usecs
[    0.321613] calling  init_trace_printk+0x0/0xc @ 1
[    0.324003] initcall init_trace_printk+0x0/0xc returned 0 after 0 usecs
[    0.328001] calling  event_trace_enable_again+0x0/0x1f @ 1
[    0.332001] initcall event_trace_enable_again+0x0/0x1f returned 0 after 0 usecs
[    0.336001] calling  jump_label_init_module+0x0/0x11 @ 1
[    0.340002] initcall jump_label_init_module+0x0/0x11 returned 0 after 0 usecs
[    0.344001] calling  dynamic_debug_init+0x0/0x249 @ 1
[    0.348531] initcall dynamic_debug_init+0x0/0x249 returned 0 after 0 usecs
[    0.352003] calling  rand_initialize+0x0/0x100 @ 1
[    0.356035] initcall rand_initialize+0x0/0x100 returned 0 after 0 usecs
[    0.360002] calling  initialize_ptr_random+0x0/0x3c @ 1
[    0.364001] initcall initialize_ptr_random+0x0/0x3c returned 0 after 0 usecs
[    0.368428] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.372005] smp: Bringing up secondary CPUs ...
[    0.376114] x86: Booting SMP configuration:
[    0.380003] .... node  #0, CPUs:      #1 #2 #3 #4 #5 #6 #7
[    0.384522] smp: Brought up 1 node, 8 CPUs
[    0.392001] smpboot: Max logical packages: 1
[    0.396000] smpboot: Total of 8 processors activated (54528.00 BogoMIPS)
[    0.404416] devtmpfs: initialized
[    0.408025] device: 'platform': device_add
[    0.412013] PM: Adding info for No Bus:platform
[    0.416026] device: 'cpu': device_add
[    0.420018] PM: Adding info for No Bus:cpu
[    0.424019] device: 'memory': device_add
[    0.428015] PM: Adding info for No Bus:memory
[    0.432001] x86/mm: Memory block size: 128MB
[    0.436004] device: 'memory0': device_add
[    0.440020] PM: Adding info for memory:memory0
[    0.444006] device: 'memory1': device_add
[    0.448018] PM: Adding info for memory:memory1
[    0.452005] device: 'memory2': device_add
[    0.456019] PM: Adding info for memory:memory2
[    0.460005] device: 'memory3': device_add
[    0.464018] PM: Adding info for memory:memory3
[    0.468005] device: 'memory4': device_add
[    0.472018] PM: Adding info for memory:memory4
[    0.476004] device: 'memory5': device_add
[    0.480020] PM: Adding info for memory:memory5
[    0.488005] device: 'memory6': device_add
[    0.492018] PM: Adding info for memory:memory6
[    0.496005] device: 'memory7': device_add
[    0.500018] PM: Adding info for memory:memory7
[    0.504014] device: 'container': device_add
[    0.508011] PM: Adding info for No Bus:container
[    0.512129] calling  ipc_ns_init+0x0/0x63 @ 1
[    0.516005] initcall ipc_ns_init+0x0/0x63 returned 0 after 0 usecs
[    0.524001] calling  init_mmap_min_addr+0x0/0x16 @ 1
[    0.528001] initcall init_mmap_min_addr+0x0/0x16 returned 0 after 0 usecs
[    0.536001] calling  evm_display_config+0x0/0x2d @ 1
[    0.540000] evm: security.selinux
[    0.544000] evm: security.SMACK64
[    0.548000] evm: security.apparmor
[    0.548000] evm: security.ima
[    0.550972] evm: security.capability
[    0.556001] initcall evm_display_config+0x0/0x2d returned 0 after 15625 usecs
[    0.564001] calling  init_cpufreq_transition_notifier_list+0x0/0x1b @ 1
[    0.568009] initcall init_cpufreq_transition_notifier_list+0x0/0x1b returned 0 after 0 usecs
[    0.580001] calling  net_ns_init+0x0/0x162 @ 1
[    0.584021] initcall net_ns_init+0x0/0x162 returned 0 after 0 usecs
[    0.588024] calling  e820__register_nvs_regions+0x0/0x38 @ 1
[    0.596003] PM: Registering ACPI NVS region [mem 0xb5581000-0xb5581fff] (4096 bytes)
[    0.604001] PM: Registering ACPI NVS region [mem 0xbe4d4000-0xbeb7efff] (6991872 bytes)
[    0.612776] initcall e820__register_nvs_regions+0x0/0x38 returned 0 after 15625 usecs
[    0.620001] calling  cpufreq_register_tsc_scaling+0x0/0x2b @ 1
[    0.624001] initcall cpufreq_register_tsc_scaling+0x0/0x2b returned 0 after 0 usecs
[    0.632001] calling  init_cpu_syscore+0x0/0xf @ 1
[    0.636001] initcall init_cpu_syscore+0x0/0xf returned 0 after 0 usecs
[    0.644001] calling  reboot_init+0x0/0x3d @ 1
[    0.648003] initcall reboot_init+0x0/0x3d returned 0 after 0 usecs
[    0.656001] calling  init_lapic_sysfs+0x0/0x20 @ 1
[    0.660001] initcall init_lapic_sysfs+0x0/0x20 returned 0 after 0 usecs
[    0.664001] calling  cpu_hotplug_pm_sync_init+0x0/0x14 @ 1
[    0.672001] initcall cpu_hotplug_pm_sync_init+0x0/0x14 returned 0 after 0 usecs
[    0.680001] calling  alloc_frozen_cpus+0x0/0x8 @ 1
[    0.684001] initcall alloc_frozen_cpus+0x0/0x8 returned 0 after 0 usecs
[    0.688001] calling  wq_sysfs_init+0x0/0x2b @ 1
[    0.696016] device: 'workqueue': device_add
[    0.700013] PM: Adding info for No Bus:workqueue
[    0.704002] initcall wq_sysfs_init+0x0/0x2b returned 0 after 7812 usecs
[    0.708001] calling  ksysfs_init+0x0/0x93 @ 1
[    0.716011] initcall ksysfs_init+0x0/0x93 returned 0 after 0 usecs
[    0.720001] calling  pm_init+0x0/0x7b @ 1
[    0.724031] initcall pm_init+0x0/0x7b returned 0 after 0 usecs
[    0.732002] calling  pm_disk_init+0x0/0x18 @ 1
[    0.736005] initcall pm_disk_init+0x0/0x18 returned 0 after 0 usecs
[    0.740002] calling  swsusp_header_init+0x0/0x30 @ 1
[    0.744001] initcall swsusp_header_init+0x0/0x30 returned 0 after 0 usecs
[    0.752001] calling  rcu_set_runtime_mode+0x0/0x12 @ 1
[    0.756001] initcall rcu_set_runtime_mode+0x0/0x12 returned 0 after 0 usecs
[    0.764001] calling  init_jiffies_clocksource+0x0/0x18 @ 1
[    0.772001] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.780001] initcall init_jiffies_clocksource+0x0/0x18 returned 0 after 7812 usecs
[    0.788000] calling  futex_init+0x0/0xe8 @ 1
[    0.792010] futex hash table entries: 2048 (order: 5, 131072 bytes)
[    0.800010] initcall futex_init+0x0/0xe8 returned 0 after 7812 usecs
[    0.804001] calling  cgroup_wq_init+0x0/0x30 @ 1
[    0.808013] initcall cgroup_wq_init+0x0/0x30 returned 0 after 0 usecs
[    0.816001] calling  cgroup1_wq_init+0x0/0x30 @ 1
[    0.820012] initcall cgroup1_wq_init+0x0/0x30 returned 0 after 0 usecs
[    0.828001] calling  ftrace_mod_cmd_init+0x0/0xc @ 1
[    0.832002] initcall ftrace_mod_cmd_init+0x0/0xc returned 0 after 0 usecs
[    0.840001] calling  init_wakeup_tracer+0x0/0x2d @ 1
[    0.844004] initcall init_wakeup_tracer+0x0/0x2d returned 0 after 0 usecs
[    0.852001] calling  init_graph_trace+0x0/0x61 @ 1
[    0.856003] initcall init_graph_trace+0x0/0x61 returned 0 after 0 usecs
[    0.860002] calling  init_per_zone_wmark_min+0x0/0x6f @ 1
[    0.868003] initcall init_per_zone_wmark_min+0x0/0x6f returned 0 after 0 usecs
[    0.876001] calling  init_zero_pfn+0x0/0x3f @ 1
[    0.880001] initcall init_zero_pfn+0x0/0x3f returned 0 after 0 usecs
[    0.884001] calling  memory_failure_init+0x0/0x9b @ 1
[    0.892001] initcall memory_failure_init+0x0/0x9b returned 0 after 0 usecs
[    0.896001] calling  cma_init_reserved_areas+0x0/0x18d @ 1
[    0.904001] initcall cma_init_reserved_areas+0x0/0x18d returned 0 after 0 usecs
[    0.912001] calling  fsnotify_init+0x0/0x4b @ 1
[    0.916010] initcall fsnotify_init+0x0/0x4b returned 0 after 0 usecs
[    0.920001] calling  filelock_init+0x0/0x8c @ 1
[    0.924010] initcall filelock_init+0x0/0x8c returned 0 after 0 usecs
[    0.932001] calling  init_script_binfmt+0x0/0x16 @ 1
[    0.936001] initcall init_script_binfmt+0x0/0x16 returned 0 after 0 usecs
[    0.944001] calling  init_elf_binfmt+0x0/0x16 @ 1
[    0.948001] initcall init_elf_binfmt+0x0/0x16 returned 0 after 0 usecs
[    0.956001] calling  init_compat_elf_binfmt+0x0/0x16 @ 1
[    0.960001] initcall init_compat_elf_binfmt+0x0/0x16 returned 0 after 0 usecs
[    0.968001] calling  debugfs_init+0x0/0x55 @ 1
[    0.972003] initcall debugfs_init+0x0/0x55 returned 0 after 0 usecs
[    0.976001] calling  tracefs_init+0x0/0x3a @ 1
[    0.984002] initcall tracefs_init+0x0/0x3a returned 0 after 0 usecs
[    0.988001] calling  securityfs_init+0x0/0x74 @ 1
[    0.992039] initcall securityfs_init+0x0/0x74 returned 0 after 0 usecs
[    1.000001] calling  prandom_init+0x0/0xd8 @ 1
[    1.004006] initcall prandom_init+0x0/0xd8 returned 0 after 0 usecs
[    1.012000] calling  pinctrl_init+0x0/0xb2 @ 1
[    1.016000] pinctrl core: initialized pinctrl subsystem
[    1.020039] initcall pinctrl_init+0x0/0xb2 returned 0 after 3906 usecs
[    1.028001] calling  gpiolib_dev_init+0x0/0xcf @ 1
[    1.032012] initcall gpiolib_dev_init+0x0/0xcf returned 0 after 0 usecs
[    1.040002] calling  sfi_sysfs_init+0x0/0xd6 @ 1
[    1.044001] initcall sfi_sysfs_init+0x0/0xd6 returned 0 after 0 usecs
[    1.048001] calling  virtio_init+0x0/0x30 @ 1
[    1.052012] initcall virtio_init+0x0/0x30 returned 0 after 0 usecs
[    1.060001] calling  regulator_init+0x0/0x8c @ 1
[    1.064013] device: 'reg-dummy': device_add
[    1.068018] PM: Adding info for platform:reg-dummy
[    1.072016] devices_kset: Moving reg-dummy to end of list
[    1.080007] regulator-dummy: no parameters
[    1.084001] device: 'regulator.0': device_add
[    1.088031] PM: Adding info for No Bus:regulator.0
[    1.092022] initcall regulator_init+0x0/0x8c returned 0 after 27343 usecs
[    1.100001] calling  iommu_init+0x0/0x2b @ 1
[    1.104003] initcall iommu_init+0x0/0x2b returned 0 after 0 usecs
[    1.108001] calling  component_debug_init+0x0/0x1d @ 1
[    1.116003] initcall component_debug_init+0x0/0x1d returned 0 after 0 usecs
[    1.120001] calling  early_resume_init+0x0/0xd0 @ 1
[    1.128091] RTC time: 10:29:18, date: 04/10/18
[    1.132001] initcall early_resume_init+0x0/0xd0 returned 0 after 3906 usecs
[    1.136001] calling  opp_debug_init+0x0/0x3d @ 1
[    1.144003] initcall opp_debug_init+0x0/0x3d returned 0 after 0 usecs
[    1.148001] calling  cpufreq_core_init+0x0/0x4c @ 1
[    1.152003] initcall cpufreq_core_init+0x0/0x4c returned 0 after 0 usecs
[    1.160001] calling  cpuidle_init+0x0/0x3d @ 1
[    1.164004] initcall cpuidle_init+0x0/0x3d returned 0 after 0 usecs
[    1.172001] calling  capsule_reboot_register+0x0/0x11 @ 1
[    1.176001] initcall capsule_reboot_register+0x0/0x11 returned 0 after 0 usecs
[    1.184001] calling  bsp_pm_check_init+0x0/0x14 @ 1
[    1.188001] initcall bsp_pm_check_init+0x0/0x14 returned 0 after 0 usecs
[    1.196000] calling  sock_init+0x0/0x9a @ 1
[    1.200092] initcall sock_init+0x0/0x9a returned 0 after 0 usecs
[    1.204001] calling  net_inuse_init+0x0/0x26 @ 1
[    1.212012] initcall net_inuse_init+0x0/0x26 returned 0 after 0 usecs
[    1.216001] calling  net_defaults_init+0x0/0x26 @ 1
[    1.220001] initcall net_defaults_init+0x0/0x26 returned 0 after 0 usecs
[    1.228001] calling  init_default_flow_dissectors+0x0/0x50 @ 1
[    1.236001] initcall init_default_flow_dissectors+0x0/0x50 returned 0 after 0 usecs
[    1.240000] calling  netpoll_init+0x0/0x31 @ 1
[    1.248001] initcall netpoll_init+0x0/0x31 returned 0 after 0 usecs
[    1.252001] calling  netlink_proto_init+0x0/0x153 @ 1
[    1.256044] NET: Registered protocol family 16
[    1.264019] initcall netlink_proto_init+0x0/0x153 returned 0 after 7812 usecs
[    1.268001] calling  __gnttab_init+0x0/0x30 @ 1
[    1.272001] initcall __gnttab_init+0x0/0x30 returned -19 after 0 usecs
[    1.280022] calling  irq_sysfs_init+0x0/0x8d @ 1
[    1.284134] initcall irq_sysfs_init+0x0/0x8d returned 0 after 0 usecs
[    1.292001] calling  audit_init+0x0/0x182 @ 1
[    1.296002] audit: initializing netlink subsys (disabled)
[    1.300013] initcall audit_init+0x0/0x182 returned 0 after 3906 usecs
[    1.300013] audit: type=2000 audit(1523356157.300:1): state=initialized audit_enabled=0 res=1
[    1.316001] calling  bdi_class_init+0x0/0x49 @ 1
[    1.320009] initcall bdi_class_init+0x0/0x49 returned 0 after 0 usecs
[    1.328000] calling  mm_sysfs_init+0x0/0x29 @ 1
[    1.332003] initcall mm_sysfs_init+0x0/0x29 returned 0 after 0 usecs
[    1.340001] calling  pcibus_class_init+0x0/0x18 @ 1
[    1.344004] initcall pcibus_class_init+0x0/0x18 returned 0 after 0 usecs
[    1.348001] calling  pci_driver_init+0x0/0x11 @ 1
[    1.356011] initcall pci_driver_init+0x0/0x11 returned 0 after 0 usecs
[    1.360001] calling  rio_bus_init+0x0/0x43 @ 1
[    1.364015] initcall rio_bus_init+0x0/0x43 returned 0 after 0 usecs
[    1.372001] calling  backlight_class_init+0x0/0xa9 @ 1
[    1.376005] initcall backlight_class_init+0x0/0xa9 returned 0 after 0 usecs
[    1.384001] calling  xenbus_init+0x0/0x2a3 @ 1
[    1.388001] initcall xenbus_init+0x0/0x2a3 returned -19 after 0 usecs
[    1.396000] calling  tty_class_init+0x0/0x34 @ 1
[    1.400005] initcall tty_class_init+0x0/0x34 returned 0 after 0 usecs
[    1.404001] calling  vtconsole_class_init+0x0/0xc3 @ 1
[    1.412008] device: 'vtcon0': device_add
[    1.416019] PM: Adding info for No Bus:vtcon0
[    1.420003] initcall vtconsole_class_init+0x0/0xc3 returned 0 after 7812 usecs
[    1.428001] calling  iommu_dev_init+0x0/0x18 @ 1
[    1.432004] initcall iommu_dev_init+0x0/0x18 returned 0 after 0 usecs
[    1.436001] calling  mipi_dsi_bus_init+0x0/0x11 @ 1
[    1.444009] initcall mipi_dsi_bus_init+0x0/0x11 returned 0 after 0 usecs
[    1.448001] calling  wakeup_sources_debugfs_init+0x0/0x2b @ 1
[    1.456003] initcall wakeup_sources_debugfs_init+0x0/0x2b returned 0 after 0 usecs
[    1.464001] calling  register_node_type+0x0/0x2f @ 1
[    1.468012] device: 'node': device_add
[    1.472015] PM: Adding info for No Bus:node
[    1.476001] initcall register_node_type+0x0/0x2f returned 0 after 7812 usecs
[    1.484001] calling  regmap_initcall+0x0/0xd @ 1
[    1.488004] initcall regmap_initcall+0x0/0xd returned 0 after 0 usecs
[    1.492001] calling  sram_init+0x0/0x13 @ 1
[    1.496008] initcall sram_init+0x0/0x13 returned 0 after 0 usecs
[    1.504001] calling  syscon_init+0x0/0x13 @ 1
[    1.508007] initcall syscon_init+0x0/0x13 returned 0 after 0 usecs
[    1.516000] calling  spi_init+0x0/0x99 @ 1
[    1.520016] initcall spi_init+0x0/0x99 returned 0 after 0 usecs
[    1.524001] calling  i2c_init+0x0/0xb4 @ 1
[    1.528019] initcall i2c_init+0x0/0xb4 returned 0 after 0 usecs
[    1.536001] calling  init_ladder+0x0/0x24 @ 1
[    1.540012] cpuidle: using governor ladder
[    1.544003] initcall init_ladder+0x0/0x24 returned 0 after 3906 usecs
[    1.548001] calling  init_menu+0x0/0x11 @ 1
[    1.552014] cpuidle: using governor menu
[    1.556002] initcall init_menu+0x0/0x11 returned 0 after 3906 usecs
[    1.564001] calling  pcc_init+0x0/0x356 @ 1
[    1.568002] initcall pcc_init+0x0/0x356 returned -19 after 0 usecs
[    1.572000] calling  amd_postcore_init+0x0/0x11a @ 1
[    1.580001] initcall amd_postcore_init+0x0/0x11a returned 0 after 0 usecs
[    1.584001] calling  kobject_uevent_init+0x0/0xc @ 1
[    1.592007] initcall kobject_uevent_init+0x0/0xc returned 0 after 0 usecs
[    1.596022] calling  bts_init+0x0/0xbc @ 1
[    1.600001] initcall bts_init+0x0/0xbc returned -19 after 0 usecs
[    1.608000] calling  pt_init+0x0/0x384 @ 1
[    1.612017] initcall pt_init+0x0/0x384 returned 0 after 0 usecs
[    1.616001] calling  boot_params_ksysfs_init+0x0/0x24e @ 1
[    1.624006] initcall boot_params_ksysfs_init+0x0/0x24e returned 0 after 0 usecs
[    1.632001] calling  sbf_init+0x0/0xf3 @ 1
[    1.636001] initcall sbf_init+0x0/0xf3 returned 0 after 0 usecs
[    1.640001] calling  arch_kdebugfs_init+0x0/0x24 @ 1
[    1.644004] initcall arch_kdebugfs_init+0x0/0x24 returned 0 after 0 usecs
[    1.652000] calling  mtrr_if_init+0x0/0x61 @ 1
[    1.656002] initcall mtrr_if_init+0x0/0x61 returned 0 after 0 usecs
[    1.664001] calling  ffh_cstate_init+0x0/0x2b @ 1
[    1.668006] initcall ffh_cstate_init+0x0/0x2b returned 0 after 0 usecs
[    1.676001] calling  kvm_setup_pv_tlb_flush+0x0/0x9f @ 1
[    1.680002] initcall kvm_setup_pv_tlb_flush+0x0/0x9f returned 0 after 0 usecs
[    1.688001] calling  activate_jump_labels+0x0/0x32 @ 1
[    1.692001] initcall activate_jump_labels+0x0/0x32 returned 0 after 0 usecs
[    1.700001] calling  gigantic_pages_init+0x0/0x30 @ 1
[    1.704001] initcall gigantic_pages_init+0x0/0x30 returned 0 after 0 usecs
[    1.712001] calling  kcmp_cookies_init+0x0/0x38 @ 1
[    1.716002] initcall kcmp_cookies_init+0x0/0x38 returned 0 after 0 usecs
[    1.724001] calling  acpi_pci_init+0x0/0x66 @ 1
[    1.728000] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    1.736000] ACPI: bus type PCI registered
[    1.740001] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    1.744001] initcall acpi_pci_init+0x0/0x66 returned 0 after 15625 usecs
[    1.752000] calling  dma_bus_init+0x0/0xc3 @ 1
[    1.756045] initcall dma_bus_init+0x0/0xc3 returned 0 after 0 usecs
[    1.764001] calling  dma_channel_table_init+0x0/0xcf @ 1
[    1.768040] initcall dma_channel_table_init+0x0/0xcf returned 0 after 0 usecs
[    1.776002] calling  setup_vcpu_hotplug_event+0x0/0x28 @ 1
[    1.780001] initcall setup_vcpu_hotplug_event+0x0/0x28 returned -19 after 0 usecs
[    1.788001] calling  register_xen_pci_notifier+0x0/0x36 @ 1
[    1.792001] initcall register_xen_pci_notifier+0x0/0x36 returned 0 after 0 usecs
[    1.800000] calling  xen_pcpu_init+0x0/0xc4 @ 1
[    1.804000] initcall xen_pcpu_init+0x0/0xc4 returned -19 after 0 usecs
[    1.812001] calling  dmi_id_init+0x0/0x325 @ 1
[    1.816007] device: 'id': device_add
[    1.820031] PM: Adding info for No Bus:id
[    1.824056] initcall dmi_id_init+0x0/0x325 returned 0 after 7812 usecs
[    1.832002] calling  numachip_timer_init+0x0/0x54 @ 1
[    1.836001] initcall numachip_timer_init+0x0/0x54 returned -19 after 0 usecs
[    1.844001] calling  pci_arch_init+0x0/0x68 @ 1
[    1.848015] PCI: MMCONFIG for domain 0000 [bus 00-7f] at [mem 0xf0000000-0xf7ffffff] (base 0xf0000000)
[    1.856001] PCI: MMCONFIG at [mem 0xf0000000-0xf7ffffff] reserved in E820
[    1.864008] PCI: Using configuration type 1 for base access
[    1.868003] initcall pci_arch_init+0x0/0x68 returned 0 after 19531 usecs
[    1.876022] calling  init_vdso+0x0/0x40 @ 1
[    1.880004] initcall init_vdso+0x0/0x40 returned 0 after 0 usecs
[    1.884002] calling  sysenter_setup+0x0/0x14 @ 1
[    1.892003] initcall sysenter_setup+0x0/0x14 returned 0 after 0 usecs
[    1.896001] calling  fixup_ht_bug+0x0/0xa1 @ 1
[    1.900001] initcall fixup_ht_bug+0x0/0xa1 returned 0 after 0 usecs
[    1.908001] calling  topology_init+0x0/0xb9 @ 1
[    1.912004] device: 'node0': device_add
[    1.916022] PM: Adding info for node:node0
[    1.920033] device: 'cpu0': device_add
[    1.924015] PM: Adding info for cpu:cpu0
[    1.928020] device: 'cpu1': device_add
[    1.932016] PM: Adding info for cpu:cpu1
[    1.936020] device: 'cpu2': device_add
[    1.940016] PM: Adding info for cpu:cpu2
[    1.944018] device: 'cpu3': device_add
[    1.948015] PM: Adding info for cpu:cpu3
[    1.952018] device: 'cpu4': device_add
[    1.956016] PM: Adding info for cpu:cpu4
[    1.960018] device: 'cpu5': device_add
[    1.964016] PM: Adding info for cpu:cpu5
[    1.964018] device: 'cpu6': device_add
[    1.968015] PM: Adding info for cpu:cpu6
[    1.972018] device: 'cpu7': device_add
[    1.976016] PM: Adding info for cpu:cpu7
[    1.980017] initcall topology_init+0x0/0xb9 returned 0 after 66406 usecs
[    1.988001] calling  mtrr_init_finialize+0x0/0x3f @ 1
[    1.992001] initcall mtrr_init_finialize+0x0/0x3f returned 0 after 0 usecs
[    2.000001] calling  uid_cache_init+0x0/0x95 @ 1
[    2.004003] initcall uid_cache_init+0x0/0x95 returned 0 after 0 usecs
[    2.012001] calling  param_sysfs_init+0x0/0x1bf @ 1
[    2.016804] initcall param_sysfs_init+0x0/0x1bf returned 0 after 0 usecs
[    2.024001] calling  user_namespace_sysctl_init+0x0/0x48 @ 1
[    2.032009] initcall user_namespace_sysctl_init+0x0/0x48 returned 0 after 0 usecs
[    2.036001] calling  proc_schedstat_init+0x0/0x1f @ 1
[    2.044002] initcall proc_schedstat_init+0x0/0x1f returned 0 after 0 usecs
[    2.048001] calling  pm_sysrq_init+0x0/0x19 @ 1
[    2.056004] initcall pm_sysrq_init+0x0/0x19 returned 0 after 0 usecs
[    2.060002] calling  create_proc_profile+0x0/0xd0 @ 1
[    2.064001] initcall create_proc_profile+0x0/0xd0 returned 0 after 0 usecs
[    2.072001] calling  crash_save_vmcoreinfo_init+0x0/0x629 @ 1
[    2.080012] initcall crash_save_vmcoreinfo_init+0x0/0x629 returned 0 after 0 usecs
[    2.084001] calling  crash_notes_memory_init+0x0/0x37 @ 1
[    2.092007] initcall crash_notes_memory_init+0x0/0x37 returned 0 after 0 usecs
[    2.100001] calling  cgroup_sysfs_init+0x0/0x18 @ 1
[    2.104004] initcall cgroup_sysfs_init+0x0/0x18 returned 0 after 0 usecs
[    2.112001] calling  cgroup_namespaces_init+0x0/0x8 @ 1
[    2.116001] initcall cgroup_namespaces_init+0x0/0x8 returned 0 after 0 usecs
[    2.124001] calling  user_namespaces_init+0x0/0x2d @ 1
[    2.128003] initcall user_namespaces_init+0x0/0x2d returned 0 after 0 usecs
[    2.136001] calling  hung_task_init+0x0/0x51 @ 1
[    2.140014] initcall hung_task_init+0x0/0x51 returned 0 after 0 usecs
[    2.144002] calling  oom_init+0x0/0x3e @ 1
[    2.148076] initcall oom_init+0x0/0x3e returned 0 after 0 usecs
[    2.156001] calling  default_bdi_init+0x0/0xba @ 1
[    2.160009] device: 'writeback': device_add
[    2.164018] PM: Adding info for workqueue:writeback
[    2.168032] initcall default_bdi_init+0x0/0xba returned 0 after 7812 usecs
[    2.176001] calling  percpu_enable_async+0x0/0xf @ 1
[    2.180000] initcall percpu_enable_async+0x0/0xf returned 0 after 0 usecs
[    2.188001] calling  kcompactd_init+0x0/0x91 @ 1
[    2.192009] initcall kcompactd_init+0x0/0x91 returned 0 after 0 usecs
[    2.200004] calling  init_reserve_notifier+0x0/0x21 @ 1
[    2.204001] initcall init_reserve_notifier+0x0/0x21 returned 0 after 0 usecs
[    2.212001] calling  init_admin_reserve+0x0/0x40 @ 1
[    2.216001] initcall init_admin_reserve+0x0/0x40 returned 0 after 0 usecs
[    2.224001] calling  init_user_reserve+0x0/0x40 @ 1
[    2.228001] initcall init_user_reserve+0x0/0x40 returned 0 after 0 usecs
[    2.236001] calling  swap_init_sysfs+0x0/0x67 @ 1
[    2.240005] initcall swap_init_sysfs+0x0/0x67 returned 0 after 0 usecs
[    2.248001] calling  swapfile_init+0x0/0xac @ 1
[    2.252001] initcall swapfile_init+0x0/0xac returned 0 after 0 usecs
[    2.256001] calling  hugetlb_init+0x0/0x492 @ 1
[    2.260001] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    2.268000] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    2.276036] initcall hugetlb_init+0x0/0x492 returned 0 after 15625 usecs
[    2.280001] calling  ksm_init+0x0/0x19d @ 1
[    2.284014] initcall ksm_init+0x0/0x19d returned 0 after 0 usecs
[    2.292001] calling  hugepage_init+0x0/0x15a @ 1
[    2.296018] initcall hugepage_init+0x0/0x15a returned 0 after 0 usecs
[    2.304002] calling  mem_cgroup_swap_init+0x0/0x52 @ 1
[    2.308001] initcall mem_cgroup_swap_init+0x0/0x52 returned 0 after 0 usecs
[    2.316001] calling  mem_cgroup_init+0x0/0x150 @ 1
[    2.320014] initcall mem_cgroup_init+0x0/0x150 returned 0 after 0 usecs
[    2.328002] calling  sel_ib_pkey_init+0x0/0x32 @ 1
[    2.332001] initcall sel_ib_pkey_init+0x0/0x32 returned 0 after 0 usecs
[    2.336001] calling  crypto_wq_init+0x0/0x33 @ 1
[    2.344013] initcall crypto_wq_init+0x0/0x33 returned 0 after 0 usecs
[    2.348002] calling  cryptomgr_init+0x0/0x11 @ 1
[    2.352002] initcall cryptomgr_init+0x0/0x11 returned 0 after 0 usecs
[    2.360001] calling  init_bio+0x0/0xd1 @ 1
[    2.364039] initcall init_bio+0x0/0xd1 returned 0 after 0 usecs
[    2.372001] calling  blk_settings_init+0x0/0x2a @ 1
[    2.376000] initcall blk_settings_init+0x0/0x2a returned 0 after 0 usecs
[    2.380000] calling  blk_ioc_init+0x0/0x2a @ 1
[    2.388008] initcall blk_ioc_init+0x0/0x2a returned 0 after 0 usecs
[    2.392000] calling  blk_softirq_init+0x0/0x74 @ 1
[    2.396001] initcall blk_softirq_init+0x0/0x74 returned 0 after 0 usecs
[    2.404000] calling  blk_mq_init+0x0/0x2a @ 1
[    2.408000] initcall blk_mq_init+0x0/0x2a returned 0 after 0 usecs
[    2.416000] calling  genhd_device_init+0x0/0x76 @ 1
[    2.420023] initcall genhd_device_init+0x0/0x76 returned 0 after 0 usecs
[    2.424001] calling  irq_poll_setup+0x0/0x6f @ 1
[    2.432001] initcall irq_poll_setup+0x0/0x6f returned 0 after 0 usecs
[    2.436000] calling  byt_gpio_init+0x0/0x13 @ 1
[    2.440007] initcall byt_gpio_init+0x0/0x13 returned 0 after 0 usecs
[    2.448001] calling  gpiolib_debugfs_init+0x0/0x24 @ 1
[    2.452003] initcall gpiolib_debugfs_init+0x0/0x24 returned 0 after 0 usecs
[    2.460001] calling  lp_gpio_init+0x0/0x13 @ 1
[    2.464007] initcall lp_gpio_init+0x0/0x13 returned 0 after 0 usecs
[    2.472001] calling  rc5t583_gpio_init+0x0/0x13 @ 1
[    2.476006] initcall rc5t583_gpio_init+0x0/0x13 returned 0 after 0 usecs
[    2.484001] calling  palmas_gpio_init+0x0/0x13 @ 1
[    2.488006] initcall palmas_gpio_init+0x0/0x13 returned 0 after 0 usecs
[    2.492001] calling  tps6586x_gpio_init+0x0/0x13 @ 1
[    2.500007] initcall tps6586x_gpio_init+0x0/0x13 returned 0 after 0 usecs
[    2.504001] calling  tps65910_gpio_init+0x0/0x13 @ 1
[    2.512006] initcall tps65910_gpio_init+0x0/0x13 returned 0 after 0 usecs
[    2.516000] calling  pwm_debugfs_init+0x0/0x24 @ 1
[    2.520003] initcall pwm_debugfs_init+0x0/0x24 returned 0 after 0 usecs
[    2.528001] calling  pwm_sysfs_init+0x0/0x18 @ 1
[    2.532005] initcall pwm_sysfs_init+0x0/0x18 returned 0 after 0 usecs
[    2.540002] calling  pci_slot_init+0x0/0x50 @ 1
[    2.544003] initcall pci_slot_init+0x0/0x50 returned 0 after 0 usecs
[    2.552001] calling  fbmem_init+0x0/0xdd @ 1
[    2.556011] device: 'fbcon': device_add
[    2.556027] PM: Adding info for No Bus:fbcon
[    2.564001] initcall fbmem_init+0x0/0xdd returned 0 after 7812 usecs
[    2.568001] calling  scan_for_dmi_ipmi+0x0/0x10b @ 1
[    2.576001] initcall scan_for_dmi_ipmi+0x0/0x10b returned 0 after 0 usecs
[    2.580001] calling  acpi_init+0x0/0x34c @ 1
[    2.584033] ACPI: Added _OSI(Module Device)
[    2.588001] ACPI: Added _OSI(Processor Device)
[    2.592000] ACPI: Added _OSI(3.0 _SCP Extensions)
[    2.600000] ACPI: Added _OSI(Processor Aggregator Device)
[    2.606681] ACPI: Executed 35 blocks of module-level executable AML code
[    2.643539] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    2.654935] ACPI: Dynamic OEM Table Load:
[    2.660005] ACPI: SSDT 0xFFFF9989BD7CF000 000717 (v02 PmRef  Cpu0Ist  00003000 INTL 20160422)
[    2.668960] ACPI: Executed 1 blocks of module-level executable AML code
[    2.676132] ACPI: \_PR_.CPU0: _OSC native thermal LVT Acked
[    2.685049] ACPI: Dynamic OEM Table Load:
[    2.692003] ACPI: SSDT 0xFFFF9989BCE70C00 0003FF (v02 PmRef  Cpu0Cst  00003001 INTL 20160422)
[    2.700236] ACPI: Executed 1 blocks of module-level executable AML code
[    2.704899] ACPI: Dynamic OEM Table Load:
[    2.712004] ACPI: SSDT 0xFFFF9989BD7CF800 00065C (v02 PmRef  ApIst    00003000 INTL 20160422)
[    2.721245] ACPI: Executed 1 blocks of module-level executable AML code
[    2.728293] ACPI: Dynamic OEM Table Load:
[    2.732003] ACPI: SSDT 0xFFFF9989BCE13800 00018A (v02 PmRef  ApCst    00003000 INTL 20160422)
[    2.740427] ACPI: Executed 1 blocks of module-level executable AML code
[    2.755911] ACPI: Interpreter enabled
[    2.760031] ACPI: (supports S0 S3 S4 S5)
[    2.764001] ACPI: Using IOAPIC for interrupt routing
[    2.768052] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    2.780532] ACPI: Enabled 6 GPEs in block 00 to 7F
[    2.788058] device: 'LNXSYSTM:00': device_add
[    2.792019] PM: Adding info for acpi:LNXSYSTM:00
[    2.796076] device: 'LNXCPU:00': device_add
[    2.800017] PM: Adding info for acpi:LNXCPU:00
[    2.804044] device: 'LNXCPU:01': device_add
[    2.808018] PM: Adding info for acpi:LNXCPU:01
[    2.812038] device: 'LNXCPU:02': device_add
[    2.816016] PM: Adding info for acpi:LNXCPU:02
[    2.820145] device: 'LNXCPU:03': device_add
[    2.824017] PM: Adding info for acpi:LNXCPU:03
[    2.832037] device: 'LNXCPU:04': device_add
[    2.836016] PM: Adding info for acpi:LNXCPU:04
[    2.840038] device: 'LNXCPU:05': device_add
[    2.844017] PM: Adding info for acpi:LNXCPU:05
[    2.848037] device: 'LNXCPU:06': device_add
[    2.852016] PM: Adding info for acpi:LNXCPU:06
[    2.856037] device: 'LNXCPU:07': device_add
[    2.860016] PM: Adding info for acpi:LNXCPU:07
[    2.864053] device: 'LNXSYBUS:00': device_add
[    2.868017] PM: Adding info for acpi:LNXSYBUS:00
[    2.877208] device: 'PNP0A08:00': device_add
[    2.880019] PM: Adding info for acpi:PNP0A08:00
[    2.884116] device: 'LNXVIDEO:00': device_add
[    2.888017] PM: Adding info for acpi:LNXVIDEO:00
[    2.892365] device: 'device:00': device_add
[    2.896019] PM: Adding info for acpi:device:00
[    2.904192] device: 'device:01': device_add
[    2.908018] PM: Adding info for acpi:device:01
[    2.912163] device: 'device:02': device_add
[    2.916018] PM: Adding info for acpi:device:02
[    2.920163] device: 'device:03': device_add
[    2.924016] PM: Adding info for acpi:device:03
[    2.928284] device: 'device:04': device_add
[    2.932018] PM: Adding info for acpi:device:04
[    2.940164] device: 'device:05': device_add
[    2.944018] PM: Adding info for acpi:device:05
[    2.948163] device: 'device:06': device_add
[    2.952018] PM: Adding info for acpi:device:06
[    2.956164] device: 'device:07': device_add
[    2.960017] PM: Adding info for acpi:device:07
[    2.964143] device: 'device:08': device_add
[    2.968017] PM: Adding info for acpi:device:08
[    2.972143] device: 'device:09': device_add
[    2.976019] PM: Adding info for acpi:device:09
[    2.984141] device: 'device:0a': device_add
[    2.988017] PM: Adding info for acpi:device:0a
[    2.992142] device: 'device:0b': device_add
[    2.996017] PM: Adding info for acpi:device:0b
[    3.000142] device: 'device:0c': device_add
[    3.004017] PM: Adding info for acpi:device:0c
[    3.008142] device: 'device:0d': device_add
[    3.012018] PM: Adding info for acpi:device:0d
[    3.016142] device: 'device:0e': device_add
[    3.020017] PM: Adding info for acpi:device:0e
[    3.028130] device: 'device:0f': device_add
[    3.032017] PM: Adding info for acpi:device:0f
[    3.036177] device: 'device:10': device_add
[    3.040017] PM: Adding info for acpi:device:10
[    3.044071] device: 'device:11': device_add
[    3.048018] PM: Adding info for acpi:device:11
[    3.052112] ACPI: Power Resource [PG00] (on)
[    3.056005] device: 'LNXPOWER:00': device_add
[    3.060017] PM: Adding info for acpi:LNXPOWER:00
[    3.064531] device: 'device:12': device_add
[    3.072018] PM: Adding info for acpi:device:12
[    3.076319] device: 'device:13': device_add
[    3.080019] PM: Adding info for acpi:device:13
[    3.084120] ACPI: Power Resource [PG01] (on)
[    3.088006] device: 'LNXPOWER:01': device_add
[    3.092017] PM: Adding info for acpi:LNXPOWER:01
[    3.096530] device: 'device:14': device_add
[    3.100018] PM: Adding info for acpi:device:14
[    3.108318] device: 'device:15': device_add
[    3.112018] PM: Adding info for acpi:device:15
[    3.116116] ACPI: Power Resource [PG02] (on)
[    3.120005] device: 'LNXPOWER:02': device_add
[    3.124018] PM: Adding info for acpi:LNXPOWER:02
[    3.128160] device: 'device:16': device_add
[    3.132018] PM: Adding info for acpi:device:16
[    3.136314] device: 'device:17': device_add
[    3.144018] PM: Adding info for acpi:device:17
[    3.148080] device: 'device:18': device_add
[    3.152103] PM: Adding info for acpi:device:18
[    3.156398] device: 'PNP0C02:00': device_add
[    3.160018] PM: Adding info for acpi:PNP0C02:00
[    3.165333] device: 'PNP0400:00': device_add
[    3.172018] PM: Adding info for acpi:PNP0400:00
[    3.176499] device: 'PNP0303:00': device_add
[    3.180019] PM: Adding info for acpi:PNP0303:00
[    3.184003] device: 'PNP0F03:00': device_add
[    3.188019] PM: Adding info for acpi:PNP0F03:00
[    3.193066] device: 'PNP0501:00': device_add
[    3.200018] PM: Adding info for acpi:PNP0501:00
[    3.204112] device: 'PNP0C08:00': device_add
[    3.208018] PM: Adding info for acpi:PNP0C08:00
[    3.212110] device: 'PNP0C08:01': device_add
[    3.216018] PM: Adding info for acpi:PNP0C08:01
[    3.220084] device: 'INT0800:00': device_add
[    3.228016] PM: Adding info for acpi:INT0800:00
[    3.232209] device: 'PNP0103:00': device_add
[    3.236019] PM: Adding info for acpi:PNP0103:00
[    3.240085] device: 'PNP0000:00': device_add
[    3.244016] PM: Adding info for acpi:PNP0000:00
[    3.248241] device: 'PNP0C04:00': device_add
[    3.252019] PM: Adding info for acpi:PNP0C04:00
[    3.256086] device: 'PNP0C02:01': device_add
[    3.260016] PM: Adding info for acpi:PNP0C02:01
[    3.268301] device: 'PNP0C02:02': device_add
[    3.272018] PM: Adding info for acpi:PNP0C02:02
[    3.276082] device: 'PNP0B00:00': device_add
[    3.280018] PM: Adding info for acpi:PNP0B00:00
[    3.284077] device: 'PNP0100:00': device_add
[    3.288016] PM: Adding info for acpi:PNP0100:00
[    3.292129] device: 'INT3F0D:00': device_add
[    3.296017] PM: Adding info for acpi:INT3F0D:00
[    3.304129] device: 'PNP0C09:00': device_add
[    3.308016] PM: Adding info for acpi:PNP0C09:00
[    3.312100] device: 'PNP0C0A:00': device_add
[    3.316019] PM: Adding info for acpi:PNP0C0A:00
[    3.320092] device: 'PNP0C0A:01': device_add
[    3.324018] PM: Adding info for acpi:PNP0C0A:01
[    3.328087] device: 'PNP0C0A:02': device_add
[    3.332017] PM: Adding info for acpi:PNP0C0A:02
[    3.340310] device: 'device:19': device_add
[    3.344019] PM: Adding info for acpi:device:19
[    3.348312] device: 'device:1a': device_add
[    3.352017] PM: Adding info for acpi:device:1a
[    3.356230] ACPI: Power Resource [WRST] (on)
[    3.360005] device: 'LNXPOWER:03': device_add
[    3.364019] PM: Adding info for acpi:LNXPOWER:03
[    3.368309] device: 'device:1b': device_add
[    3.372018] PM: Adding info for acpi:device:1b
[    3.380412] device: 'device:1c': device_add
[    3.384019] PM: Adding info for acpi:device:1c
[    3.388229] ACPI: Power Resource [WRST] (on)
[    3.392005] device: 'LNXPOWER:04': device_add
[    3.396018] PM: Adding info for acpi:LNXPOWER:04
[    3.400122] device: 'device:1d': device_add
[    3.404018] PM: Adding info for acpi:device:1d
[    3.408310] device: 'device:1e': device_add
[    3.416018] PM: Adding info for acpi:device:1e
[    3.420228] ACPI: Power Resource [WRST] (on)
[    3.424006] device: 'LNXPOWER:05': device_add
[    3.428019] PM: Adding info for acpi:LNXPOWER:05
[    3.432309] device: 'device:1f': device_add
[    3.436018] PM: Adding info for acpi:device:1f
[    3.440310] device: 'device:20': device_add
[    3.444018] PM: Adding info for acpi:device:20
[    3.452228] ACPI: Power Resource [WRST] (on)
[    3.456005] device: 'LNXPOWER:06': device_add
[    3.460017] PM: Adding info for acpi:LNXPOWER:06
[    3.464312] device: 'device:21': device_add
[    3.468018] PM: Adding info for acpi:device:21
[    3.472311] device: 'device:22': device_add
[    3.476017] PM: Adding info for acpi:device:22
[    3.480227] ACPI: Power Resource [WRST] (on)
[    3.488157] device: 'LNXPOWER:07': device_add
[    3.492019] PM: Adding info for acpi:LNXPOWER:07
[    3.496310] device: 'device:23': device_add
[    3.500019] PM: Adding info for acpi:device:23
[    3.504314] device: 'device:24': device_add
[    3.508019] PM: Adding info for acpi:device:24
[    3.512233] ACPI: Power Resource [WRST] (on)
[    3.516005] device: 'LNXPOWER:08': device_add
[    3.524018] PM: Adding info for acpi:LNXPOWER:08
[    3.528312] device: 'device:25': device_add
[    3.532018] PM: Adding info for acpi:device:25
[    3.536310] device: 'device:26': device_add
[    3.540019] PM: Adding info for acpi:device:26
[    3.544228] ACPI: Power Resource [WRST] (on)
[    3.548005] device: 'LNXPOWER:09': device_add
[    3.552017] PM: Adding info for acpi:LNXPOWER:09
[    3.560311] device: 'device:27': device_add
[    3.564018] PM: Adding info for acpi:device:27
[    3.568311] device: 'device:28': device_add
[    3.572017] PM: Adding info for acpi:device:28
[    3.576228] ACPI: Power Resource [WRST] (on)
[    3.580005] device: 'LNXPOWER:0a': device_add
[    3.584019] PM: Adding info for acpi:LNXPOWER:0a
[    3.588313] device: 'device:29': device_add
[    3.596018] PM: Adding info for acpi:device:29
[    3.600384] device: 'device:2a': device_add
[    3.604018] PM: Adding info for acpi:device:2a
[    3.608230] ACPI: Power Resource [WRST] (on)
[    3.612005] device: 'LNXPOWER:0b': device_add
[    3.616018] PM: Adding info for acpi:LNXPOWER:0b
[    3.620190] device: 'device:2b': device_add
[    3.624018] PM: Adding info for acpi:device:2b
[    3.628309] device: 'device:2c': device_add
[    3.636018] PM: Adding info for acpi:device:2c
[    3.640229] ACPI: Power Resource [WRST] (on)
[    3.644006] device: 'LNXPOWER:0c': device_add
[    3.648017] PM: Adding info for acpi:LNXPOWER:0c
[    3.652309] device: 'device:2d': device_add
[    3.656019] PM: Adding info for acpi:device:2d
[    3.660308] device: 'device:2e': device_add
[    3.664017] PM: Adding info for acpi:device:2e
[    3.672228] ACPI: Power Resource [WRST] (on)
[    3.676005] device: 'LNXPOWER:0d': device_add
[    3.680018] PM: Adding info for acpi:LNXPOWER:0d
[    3.684309] device: 'device:2f': device_add
[    3.688018] PM: Adding info for acpi:device:2f
[    3.692309] device: 'device:30': device_add
[    3.696019] PM: Adding info for acpi:device:30
[    3.700229] ACPI: Power Resource [WRST] (on)
[    3.708005] device: 'LNXPOWER:0e': device_add
[    3.712123] PM: Adding info for acpi:LNXPOWER:0e
[    3.716311] device: 'device:31': device_add
[    3.720017] PM: Adding info for acpi:device:31
[    3.724310] device: 'device:32': device_add
[    3.728018] PM: Adding info for acpi:device:32
[    3.732228] ACPI: Power Resource [WRST] (on)
[    3.736005] device: 'LNXPOWER:0f': device_add
[    3.744019] PM: Adding info for acpi:LNXPOWER:0f
[    3.748309] device: 'device:33': device_add
[    3.752018] PM: Adding info for acpi:device:33
[    3.756307] device: 'device:34': device_add
[    3.760017] PM: Adding info for acpi:device:34
[    3.764228] ACPI: Power Resource [WRST] (on)
[    3.768003] device: 'LNXPOWER:10': device_add
[    3.772018] PM: Adding info for acpi:LNXPOWER:10
[    3.780313] device: 'device:35': device_add
[    3.784019] PM: Adding info for acpi:device:35
[    3.788311] device: 'device:36': device_add
[    3.792017] PM: Adding info for acpi:device:36
[    3.796227] ACPI: Power Resource [WRST] (on)
[    3.800005] device: 'LNXPOWER:11': device_add
[    3.804018] PM: Adding info for acpi:LNXPOWER:11
[    3.808314] device: 'device:37': device_add
[    3.816021] PM: Adding info for acpi:device:37
[    3.820407] device: 'device:38': device_add
[    3.824018] PM: Adding info for acpi:device:38
[    3.828234] ACPI: Power Resource [WRST] (on)
[    3.832005] device: 'LNXPOWER:12': device_add
[    3.836017] PM: Adding info for acpi:LNXPOWER:12
[    3.840224] device: 'device:39': device_add
[    3.844017] PM: Adding info for acpi:device:39
[    3.852309] device: 'device:3a': device_add
[    3.856019] PM: Adding info for acpi:device:3a
[    3.860229] ACPI: Power Resource [WRST] (on)
[    3.864006] device: 'LNXPOWER:13': device_add
[    3.868017] PM: Adding info for acpi:LNXPOWER:13
[    3.872309] device: 'device:3b': device_add
[    3.876018] PM: Adding info for acpi:device:3b
[    3.880309] device: 'device:3c': device_add
[    3.884017] PM: Adding info for acpi:device:3c
[    3.892306] device: 'device:3d': device_add
[    3.896019] PM: Adding info for acpi:device:3d
[    3.900306] device: 'device:3e': device_add
[    3.904017] PM: Adding info for acpi:device:3e
[    3.908303] device: 'device:3f': device_add
[    3.912019] PM: Adding info for acpi:device:3f
[    3.916306] device: 'device:40': device_add
[    3.920018] PM: Adding info for acpi:device:40
[    3.928509] device: 'device:41': device_add
[    3.932020] PM: Adding info for acpi:device:41
[    3.936309] device: 'device:42': device_add
[    3.940017] PM: Adding info for acpi:device:42
[    3.944308] device: 'device:43': device_add
[    3.948018] PM: Adding info for acpi:device:43
[    3.952312] device: 'device:44': device_add
[    3.956018] PM: Adding info for acpi:device:44
[    3.964230] ACPI: Power Resource [WRST] (on)
[    3.968005] device: 'LNXPOWER:14': device_add
[    3.972019] PM: Adding info for acpi:LNXPOWER:14
[    3.976313] device: 'device:45': device_add
[    3.980018] PM: Adding info for acpi:device:45
[    3.984308] device: 'device:46': device_add
[    3.988018] PM: Adding info for acpi:device:46
[    3.992227] ACPI: Power Resource [WRST] (on)
[    4.000005] device: 'LNXPOWER:15': device_add
[    4.004019] PM: Adding info for acpi:LNXPOWER:15
[    4.008309] device: 'device:47': device_add
[    4.012019] PM: Adding info for acpi:device:47
[    4.016307] device: 'device:48': device_add
[    4.020018] PM: Adding info for acpi:device:48
[    4.024073] ACPI: Power Resource [WRST] (on)
[    4.028005] device: 'LNXPOWER:16': device_add
[    4.032017] PM: Adding info for acpi:LNXPOWER:16
[    4.040444] device: 'PNP0C02:03': device_add
[    4.044019] PM: Adding info for acpi:PNP0C02:03
[    4.048122] device: 'PNP0C02:04': device_add
[    4.052018] PM: Adding info for acpi:PNP0C02:04
[    4.056037] device: 'PNP0C02:05': device_add
[    4.060018] PM: Adding info for acpi:PNP0C02:05
[    4.064077] device: 'device:49': device_add
[    4.072017] PM: Adding info for acpi:device:49
[    4.076070] device: 'device:4a': device_add
[    4.080018] PM: Adding info for acpi:device:4a
[    4.084368] device: 'device:4b': device_add
[    4.088018] PM: Adding info for acpi:device:4b
[    4.092458] device: 'device:4c': device_add
[    4.096019] PM: Adding info for acpi:device:4c
[    4.100284] device: 'device:4d': device_add
[    4.104018] PM: Adding info for acpi:device:4d
[    4.112073] device: 'device:4e': device_add
[    4.116018] PM: Adding info for acpi:device:4e
[    4.120070] device: 'device:4f': device_add
[    4.124016] PM: Adding info for acpi:device:4f
[    4.128069] device: 'device:50': device_add
[    4.132017] PM: Adding info for acpi:device:50
[    4.136070] device: 'device:51': device_add
[    4.140016] PM: Adding info for acpi:device:51
[    4.144070] device: 'device:52': device_add
[    4.148018] PM: Adding info for acpi:device:52
[    4.156181] device: 'device:53': device_add
[    4.160016] PM: Adding info for acpi:device:53
[    4.164070] device: 'device:54': device_add
[    4.168017] PM: Adding info for acpi:device:54
[    4.172070] device: 'device:55': device_add
[    4.176016] PM: Adding info for acpi:device:55
[    4.180069] device: 'device:56': device_add
[    4.184018] PM: Adding info for acpi:device:56
[    4.188070] device: 'device:57': device_add
[    4.192016] PM: Adding info for acpi:device:57
[    4.196175] device: 'device:58': device_add
[    4.204017] PM: Adding info for acpi:device:58
[    4.208172] device: 'device:59': device_add
[    4.212018] PM: Adding info for acpi:device:59
[    4.216171] device: 'device:5a': device_add
[    4.220018] PM: Adding info for acpi:device:5a
[    4.224170] device: 'device:5b': device_add
[    4.228018] PM: Adding info for acpi:device:5b
[    4.232170] device: 'device:5c': device_add
[    4.236017] PM: Adding info for acpi:device:5c
[    4.240169] device: 'device:5d': device_add
[    4.248018] PM: Adding info for acpi:device:5d
[    4.252170] device: 'device:5e': device_add
[    4.256019] PM: Adding info for acpi:device:5e
[    4.260170] device: 'device:5f': device_add
[    4.264119] PM: Adding info for acpi:device:5f
[    4.268072] device: 'device:60': device_add
[    4.272016] PM: Adding info for acpi:device:60
[    4.276070] device: 'device:61': device_add
[    4.280017] PM: Adding info for acpi:device:61
[    4.284069] device: 'device:62': device_add
[    4.288018] PM: Adding info for acpi:device:62
[    4.296070] device: 'device:63': device_add
[    4.300016] PM: Adding info for acpi:device:63
[    4.304170] device: 'device:64': device_add
[    4.308017] PM: Adding info for acpi:device:64
[    4.312170] device: 'device:65': device_add
[    4.316018] PM: Adding info for acpi:device:65
[    4.320169] device: 'device:66': device_add
[    4.324015] PM: Adding info for acpi:device:66
[    4.328174] device: 'device:67': device_add
[    4.332017] PM: Adding info for acpi:device:67
[    4.340461] device: 'device:68': device_add
[    4.344019] PM: Adding info for acpi:device:68
[    4.348347] device: 'device:69': device_add
[    4.352018] PM: Adding info for acpi:device:69
[    4.356077] device: 'device:6a': device_add
[    4.360019] PM: Adding info for acpi:device:6a
[    4.364299] device: 'device:6b': device_add
[    4.368018] PM: Adding info for acpi:device:6b
[    4.376071] device: 'device:6c': device_add
[    4.380109] PM: Adding info for acpi:device:6c
[    4.384072] device: 'device:6d': device_add
[    4.388069] PM: Adding info for acpi:device:6d
[    4.392070] device: 'device:6e': device_add
[    4.396018] PM: Adding info for acpi:device:6e
[    4.400070] device: 'device:6f': device_add
[    4.404016] PM: Adding info for acpi:device:6f
[    4.408069] device: 'device:70': device_add
[    4.412017] PM: Adding info for acpi:device:70
[    4.416108] device: 'device:71': device_add
[    4.424017] PM: Adding info for acpi:device:71
[    4.428115] device: 'device:72': device_add
[    4.432018] PM: Adding info for acpi:device:72
[    4.436113] device: 'device:73': device_add
[    4.440017] PM: Adding info for acpi:device:73
[    4.444227] device: 'INT343E:00': device_add
[    4.448017] PM: Adding info for acpi:INT343E:00
[    4.452219] device: 'INT343D:00': device_add
[    4.456019] PM: Adding info for acpi:INT343D:00
[    4.466321] device: 'PNP0C02:06': device_add
[    4.468018] PM: Adding info for acpi:PNP0C02:06
[    4.472450] device: 'INT345D:00': device_add
[    4.480018] PM: Adding info for acpi:INT345D:00
[    4.484366] device: 'INT3442:00': device_add
[    4.488018] PM: Adding info for acpi:INT3442:00
[    4.492302] device: 'XXXX0000:00': device_add
[    4.496019] PM: Adding info for acpi:XXXX0000:00
[    4.501208] device: 'INT0000:00': device_add
[    4.508019] PM: Adding info for acpi:INT0000:00
[    4.512372] device: 'INT3515:00': device_add
[    4.516018] PM: Adding info for acpi:INT3515:00
[    4.520367] device: 'INT3515:01': device_add
[    4.524020] PM: Adding info for acpi:INT3515:01
[    4.528367] device: 'INT3443:00': device_add
[    4.536019] PM: Adding info for acpi:INT3443:00
[    4.540232] device: 'XXXX0000:01': device_add
[    4.544017] PM: Adding info for acpi:XXXX0000:01
[    4.548199] device: 'IMPJ0003:00': device_add
[    4.552017] PM: Adding info for acpi:IMPJ0003:00
[    4.556369] device: 'INT3444:00': device_add
[    4.560018] PM: Adding info for acpi:INT3444:00
[    4.568202] device: 'INT3471:00': device_add
[    4.572017] PM: Adding info for acpi:INT3471:00
[    4.576286] device: 'INT3472:00': device_add
[    4.580018] PM: Adding info for acpi:INT3472:00
[    4.584367] device: 'INT3445:00': device_add
[    4.588020] PM: Adding info for acpi:INT3445:00
[    4.592364] device: 'INT3446:00': device_add
[    4.600018] PM: Adding info for acpi:INT3446:00
[    4.604198] device: 'INT3474:00': device_add
[    4.608019] PM: Adding info for acpi:INT3474:00
[    4.612456] device: 'INT3447:00': device_add
[    4.616020] PM: Adding info for acpi:INT3447:00
[    4.620351] device: 'INT3440:00': device_add
[    4.624018] PM: Adding info for acpi:INT3440:00
[    4.632361] device: 'INT3441:00': device_add
[    4.636018] PM: Adding info for acpi:INT3441:00
[    4.641267] device: 'FPNT_DIS:00': device_add
[    4.644018] PM: Adding info for acpi:FPNT_DIS:00
[    4.648406] device: 'INT3448:00': device_add
[    4.656018] PM: Adding info for acpi:INT3448:00
[    4.661254] device: 'INT33E1:00': device_add
[    4.664019] PM: Adding info for acpi:INT33E1:00
[    4.668317] device: 'INT3449:00': device_add
[    4.672018] PM: Adding info for acpi:INT3449:00
[    4.680404] device: 'INT344A:00': device_add
[    4.684020] PM: Adding info for acpi:INT344A:00
[    4.688350] device: 'INT33A2:00': device_add
[    4.692019] PM: Adding info for acpi:INT33A2:00
[    4.696082] device: 'device:74': device_add
[    4.700017] PM: Adding info for acpi:device:74
[    4.704079] device: 'device:75': device_add
[    4.708018] PM: Adding info for acpi:device:75
[    4.716070] device: 'device:76': device_add
[    4.720016] PM: Adding info for acpi:device:76
[    4.724644] device: 'INT3472:01': device_add
[    4.728019] PM: Adding info for acpi:INT3472:01
[    4.732473] device: 'INT3472:02': device_add
[    4.736019] PM: Adding info for acpi:INT3472:02
[    4.740483] device: 'INT3472:03': device_add
[    4.748019] PM: Adding info for acpi:INT3472:03
[    4.752482] device: 'INT3472:04': device_add
[    4.756019] PM: Adding info for acpi:INT3472:04
[    4.760341] device: 'INT3472:05': device_add
[    4.764019] PM: Adding info for acpi:INT3472:05
[    4.768444] device: 'INT3472:06': device_add
[    4.776020] PM: Adding info for acpi:INT3472:06
[    4.780442] device: 'INT3472:07': device_add
[    4.784019] PM: Adding info for acpi:INT3472:07
[    4.788444] device: 'INT3472:08': device_add
[    4.792019] PM: Adding info for acpi:INT3472:08
[    4.797694] device: 'INT3471:01': device_add
[    4.804020] PM: Adding info for acpi:INT3471:01
[    4.808367] device: 'INT33BE:00': device_add
[    4.812019] PM: Adding info for acpi:INT33BE:00
[    4.821772] device: 'INT3471:02': device_add
[    4.824019] PM: Adding info for acpi:INT3471:02
[    4.829684] device: 'INT33BE:01': device_add
[    4.836193] PM: Adding info for acpi:INT33BE:01
[    4.840220] device: 'ABCD0000:00': device_add
[    4.844218] PM: Adding info for acpi:ABCD0000:00
[    4.848086] device: 'PNP0C14:00': device_add
[    4.852018] PM: Adding info for acpi:PNP0C14:00
[    4.860175] device: 'ACPI000C:00': device_add
[    4.864017] PM: Adding info for acpi:ACPI000C:00
[    4.868251] device: 'PNP0C0F:00': device_add
[    4.872020] PM: Adding info for acpi:PNP0C0F:00
[    4.876230] device: 'PNP0C0F:01': device_add
[    4.880017] PM: Adding info for acpi:PNP0C0F:01
[    4.884229] device: 'PNP0C0F:02': device_add
[    4.888017] PM: Adding info for acpi:PNP0C0F:02
[    4.896230] device: 'PNP0C0F:03': device_add
[    4.900020] PM: Adding info for acpi:PNP0C0F:03
[    4.904230] device: 'PNP0C0F:04': device_add
[    4.908017] PM: Adding info for acpi:PNP0C0F:04
[    4.912229] device: 'PNP0C0F:05': device_add
[    4.916018] PM: Adding info for acpi:PNP0C0F:05
[    4.920230] device: 'PNP0C0F:06': device_add
[    4.928018] PM: Adding info for acpi:PNP0C0F:06
[    4.932229] device: 'PNP0C0F:07': device_add
[    4.936019] PM: Adding info for acpi:PNP0C0F:07
[    4.940251] device: 'INT0E0C:00': device_add
[    4.944018] PM: Adding info for acpi:INT0E0C:00
[    4.948128] device: 'INT3420:00': device_add
[    4.952017] PM: Adding info for acpi:INT3420:00
[    4.956469] device: 'PNP0C0E:00': device_add
[    4.964021] PM: Adding info for acpi:PNP0C0E:00
[    4.968083] device: 'PNP0C14:01': device_add
[    4.972017] PM: Adding info for acpi:PNP0C14:01
[    4.976236] device: 'INT33A1:00': device_add
[    4.980018] PM: Adding info for acpi:INT33A1:00
[    4.984155] device: 'IWC0001:00': device_add
[    4.988018] PM: Adding info for acpi:IWC0001:00
[    4.992108] device: 'PNP0C0C:00': device_add
[    5.000017] PM: Adding info for acpi:PNP0C0C:00
[    5.004105] device: 'PNP0C0D:00': device_add
[    5.008017] PM: Adding info for acpi:PNP0C0D:00
[    5.012304] device: 'IFX0102:00': device_add
[    5.016019] PM: Adding info for acpi:IFX0102:00
[    5.020206] device: 'INT3470:00': device_add
[    5.024019] PM: Adding info for acpi:INT3470:00
[    5.028086] device: 'INT340E:00': device_add
[    5.036018] PM: Adding info for acpi:INT340E:00
[    5.040151] device: 'INT33A3:00': device_add
[    5.044018] PM: Adding info for acpi:INT33A3:00
[    5.048077] device: 'LNXSYBUS:01': device_add
[    5.052017] PM: Adding info for acpi:LNXSYBUS:01
[    5.056109] ACPI: Power Resource [FN00] (off)
[    5.060005] device: 'LNXPOWER:17': device_add
[    5.064024] PM: Adding info for acpi:LNXPOWER:17
[    5.072167] device: 'PNP0C0B:00': device_add
[    5.076018] PM: Adding info for acpi:PNP0C0B:00
[    5.080110] ACPI: Power Resource [FN01] (off)
[    5.084005] device: 'LNXPOWER:18': device_add
[    5.088021] PM: Adding info for acpi:LNXPOWER:18
[    5.092163] device: 'PNP0C0B:01': device_add
[    5.096019] PM: Adding info for acpi:PNP0C0B:01
[    5.100108] ACPI: Power Resource [FN02] (off)
[    5.108005] device: 'LNXPOWER:19': device_add
[    5.112017] PM: Adding info for acpi:LNXPOWER:19
[    5.116162] device: 'PNP0C0B:02': device_add
[    5.120018] PM: Adding info for acpi:PNP0C0B:02
[    5.124107] ACPI: Power Resource [FN03] (off)
[    5.128005] device: 'LNXPOWER:1a': device_add
[    5.132019] PM: Adding info for acpi:LNXPOWER:1a
[    5.136161] device: 'PNP0C0B:03': device_add
[    5.144018] PM: Adding info for acpi:PNP0C0B:03
[    5.148108] ACPI: Power Resource [FN04] (off)
[    5.152005] device: 'LNXPOWER:1b': device_add
[    5.156017] PM: Adding info for acpi:LNXPOWER:1b
[    5.160161] device: 'PNP0C0B:04': device_add
[    5.164020] PM: Adding info for acpi:PNP0C0B:04
[    5.168043] device: 'LNXTHERM:00': device_add
[    5.172017] PM: Adding info for acpi:LNXTHERM:00
[    5.180111] device: 'LNXTHERM:01': device_add
[    5.184017] PM: Adding info for acpi:LNXTHERM:01
[    5.188366] device: 'INT3420:01': device_add
[    5.192018] PM: Adding info for acpi:INT3420:01
[    5.196196] device: 'INT339B:00': device_add
[    5.200017] PM: Adding info for acpi:INT339B:00
[    5.204159] device: 'ACPI0008:00': device_add
[    5.208018] PM: Adding info for acpi:ACPI0008:00
[    5.216214] device: 'INT33D0:00': device_add
[    5.220018] PM: Adding info for acpi:INT33D0:00
[    5.225254] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-7e])
[    5.232006] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig Segments MSI]
[    5.240116] acpi PNP0A08:00: _OSC failed (AE_ERROR); disabling ASPM
[    5.244387] device: 'pci0000:00': device_add
[    5.248020] PM: Adding info for No Bus:pci0000:00
[    5.256004] device: '0000:00': device_add
[    5.260022] PM: Adding info for No Bus:0000:00
[    5.264857] PCI host bridge to bus 0000:00
[    5.268002] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    5.276001] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    5.280001] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    5.288001] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xefffffff window]
[    5.296054] pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7fffff window]
[    5.304002] pci_bus 0000:00: root bus resource [bus 00-7e]
[    5.308007] pci 0000:00:00.0: [8086:191f] type 00 class 0x060000
[    5.316031] device: '0000:00:00.0': device_add
[    5.320628] PM: Adding info for pci:0000:00:00.0
[    5.324012] pci 0000:00:01.0: [8086:1901] type 01 class 0x060400
[    5.332034] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    5.336005] device: '0000:00:01.0': device_add
[    5.340431] PM: Adding info for pci:0000:00:01.0
[    5.348098] pci 0000:00:14.0: [8086:a12f] type 00 class 0x0c0330
[    5.352020] pci 0000:00:14.0: reg 0x10: [mem 0xeff30000-0xeff3ffff 64bit]
[    5.360062] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    5.364009] device: '0000:00:14.0': device_add
[    5.372466] PM: Adding info for pci:0000:00:14.0
[    5.376039] pci 0000:00:16.0: [8086:a13a] type 00 class 0x078000
[    5.380021] pci 0000:00:16.0: reg 0x10: [mem 0xeff4d000-0xeff4dfff 64bit]
[    5.388051] pci 0000:00:16.0: PME# supported from D3hot
[    5.392013] device: '0000:00:16.0': device_add
[    5.396330] PM: Adding info for pci:0000:00:16.0
[    5.404078] pci 0000:00:17.0: [8086:a102] type 00 class 0x010601
[    5.408013] pci 0000:00:17.0: reg 0x10: [mem 0xeff48000-0xeff49fff]
[    5.416005] pci 0000:00:17.0: reg 0x14: [mem 0xeff4c000-0xeff4c0ff]
[    5.420005] pci 0000:00:17.0: reg 0x18: [io  0xf050-0xf057]
[    5.428006] pci 0000:00:17.0: reg 0x1c: [io  0xf040-0xf043]
[    5.432005] pci 0000:00:17.0: reg 0x20: [io  0xf020-0xf03f]
[    5.440005] pci 0000:00:17.0: reg 0x24: [mem 0xeff4b000-0xeff4b7ff]
[    5.444035] pci 0000:00:17.0: PME# supported from D3hot
[    5.448007] device: '0000:00:17.0': device_add
[    5.456337] PM: Adding info for pci:0000:00:17.0
[    5.460018] pci 0000:00:1b.0: [8086:a167] type 01 class 0x060400
[    5.464053] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    5.472008] device: '0000:00:1b.0': device_add
[    5.476431] PM: Adding info for pci:0000:00:1b.0
[    5.480016] pci 0000:00:1b.2: [8086:a169] type 01 class 0x060400
[    5.488056] pci 0000:00:1b.2: PME# supported from D0 D3hot D3cold
[    5.492011] device: '0000:00:1b.2': device_add
[    5.496429] PM: Adding info for pci:0000:00:1b.2
[    5.504014] pci 0000:00:1b.3: [8086:a16a] type 01 class 0x060400
[    5.508056] pci 0000:00:1b.3: PME# supported from D0 D3hot D3cold
[    5.516146] device: '0000:00:1b.3': device_add
[    5.520432] PM: Adding info for pci:0000:00:1b.3
[    5.524026] pci 0000:00:1c.0: [8086:a110] type 01 class 0x060400
[    5.532056] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    5.536011] device: '0000:00:1c.0': device_add
[    5.540013] PM: Adding info for pci:0000:00:1c.0
[    5.544023] pci 0000:00:1c.4: [8086:a114] type 01 class 0x060400
[    5.552062] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    5.556013] device: '0000:00:1c.4': device_add
[    5.564427] PM: Adding info for pci:0000:00:1c.4
[    5.568023] pci 0000:00:1d.0: [8086:a118] type 01 class 0x060400
[    5.572062] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    5.580013] device: '0000:00:1d.0': device_add
[    5.584427] PM: Adding info for pci:0000:00:1d.0
[    5.588023] pci 0000:00:1f.0: [8086:a145] type 00 class 0x060100
[    5.596105] device: '0000:00:1f.0': device_add
[    5.600315] PM: Adding info for pci:0000:00:1f.0
[    5.604014] pci 0000:00:1f.2: [8086:a121] type 00 class 0x058000
[    5.612013] pci 0000:00:1f.2: reg 0x10: [mem 0xeff44000-0xeff47fff]
[    5.616055] device: '0000:00:1f.2': device_add
[    5.620314] PM: Adding info for pci:0000:00:1f.2
[    5.628072] pci 0000:00:1f.3: [8086:a170] type 00 class 0x040300
[    5.632024] pci 0000:00:1f.3: reg 0x10: [mem 0xeff40000-0xeff43fff 64bit]
[    5.640027] pci 0000:00:1f.3: reg 0x20: [mem 0xeff20000-0xeff2ffff 64bit]
[    5.648046] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    5.652008] device: '0000:00:1f.3': device_add
[    5.656419] PM: Adding info for pci:0000:00:1f.3
[    5.660018] pci 0000:00:1f.4: [8086:a123] type 00 class 0x0c0500
[    5.668059] pci 0000:00:1f.4: reg 0x10: [mem 0xeff4a000-0xeff4a0ff 64bit]
[    5.676068] pci 0000:00:1f.4: reg 0x20: [io  0xf000-0xf01f]
[    5.680082] device: '0000:00:1f.4': device_add
[    5.684315] PM: Adding info for pci:0000:00:1f.4
[    5.688020] pci 0000:00:1f.6: [8086:15b8] type 00 class 0x020000
[    5.696024] pci 0000:00:1f.6: reg 0x10: [mem 0xeff00000-0xeff1ffff]
[    5.700099] pci 0000:00:1f.6: PME# supported from D0 D3hot D3cold
[    5.708011] device: '0000:00:1f.6': device_add
[    5.712323] PM: Adding info for pci:0000:00:1f.6
[    5.716020] device: '0000:01': device_add
[    5.720022] PM: Adding info for No Bus:0000:01
[    5.724036] pci 0000:01:00.0: [1022:1470] type 01 class 0x060400
[    5.732014] pci 0000:01:00.0: reg 0x10: [mem 0xefd00000-0xefd03fff]
[    5.740058] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    5.744014] device: '0000:01:00.0': device_add
[    5.748112] PM: Adding info for pci:0000:01:00.0
[    5.752006] pci 0000:00:01.0: PCI bridge to [bus 01-03]
[    5.760001] pci 0000:00:01.0:   bridge window [io  0xe000-0xefff]
[    5.764001] pci 0000:00:01.0:   bridge window [mem 0xefc00000-0xefdfffff]
[    5.772002] pci 0000:00:01.0:   bridge window [mem 0xd0000000-0xe01fffff 64bit pref]
[    5.780018] device: '0000:02': device_add
[    5.784022] PM: Adding info for No Bus:0000:02
[    5.788013] pci 0000:02:00.0: [1022:1471] type 01 class 0x060400
[    5.792070] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    5.800013] device: '0000:02:00.0': device_add
[    5.804051] PM: Adding info for pci:0000:02:00.0
[    5.808020] pci 0000:01:00.0: PCI bridge to [bus 02-03]
[    5.816003] pci 0000:01:00.0:   bridge window [io  0xe000-0xefff]
[    5.820002] pci 0000:01:00.0:   bridge window [mem 0xefc00000-0xefcfffff]
[    5.828004] pci 0000:01:00.0:   bridge window [mem 0xd0000000-0xe01fffff 64bit pref]
[    5.836021] device: '0000:03': device_add
[    5.840025] PM: Adding info for No Bus:0000:03
[    5.844082] pci 0000:03:00.0: [1002:6868] type 00 class 0x030000
[    5.848018] pci 0000:03:00.0: reg 0x10: [mem 0xd0000000-0xdfffffff 64bit pref]
[    5.856007] pci 0000:03:00.0: reg 0x18: [mem 0xe0000000-0xe01fffff 64bit pref]
[    5.864005] pci 0000:03:00.0: reg 0x20: [io  0xe000-0xe0ff]
[    5.868005] pci 0000:03:00.0: reg 0x24: [mem 0xefc00000-0xefc7ffff]
[    5.876005] pci 0000:03:00.0: reg 0x30: [mem 0xefc80000-0xefc9ffff pref]
[    5.884055] pci 0000:03:00.0: PME# supported from D1 D2 D3hot D3cold
[    5.888016] device: '0000:03:00.0': device_add
[    5.892049] PM: Adding info for pci:0000:03:00.0
[    5.900013] pci 0000:03:00.1: [1002:aaf8] type 00 class 0x040300
[    5.904012] pci 0000:03:00.1: reg 0x10: [mem 0xefca0000-0xefca3fff]
[    5.912070] pci 0000:03:00.1: PME# supported from D1 D2 D3hot D3cold
[    5.916011] device: '0000:03:00.1': device_add
[    5.920048] PM: Adding info for pci:0000:03:00.1
[    5.924008] pci 0000:02:00.0: PCI bridge to [bus 03]
[    5.932003] pci 0000:02:00.0:   bridge window [io  0xe000-0xefff]
[    5.936002] pci 0000:02:00.0:   bridge window [mem 0xefc00000-0xefcfffff]
[    5.944003] pci 0000:02:00.0:   bridge window [mem 0xd0000000-0xe01fffff 64bit pref]
[    5.952025] device: '0000:04': device_add
[    5.956055] PM: Adding info for No Bus:0000:04
[    5.960156] acpiphp: Slot [1] registered
[    5.964003] pci 0000:00:1b.0: PCI bridge to [bus 04]
[    5.968023] device: '0000:05': device_add
[    5.972022] PM: Adding info for No Bus:0000:05
[    5.976145] pci 0000:05:00.0: [1b21:1080] type 01 class 0x060400
[    5.984127] pci 0000:05:00.0: supports D1 D2
[    5.988000] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    5.996020] device: '0000:05:00.0': device_add
[    6.000191] PM: Adding info for pci:0000:05:00.0
[    6.004006] pci 0000:00:1b.2: PCI bridge to [bus 05-06]
[    6.008042] device: '0000:06': device_add
[    6.012022] PM: Adding info for No Bus:0000:06
[    6.016060] pci 0000:05:00.0: PCI bridge to [bus 06]
[    6.024039] device: '0000:07': device_add
[    6.028021] PM: Adding info for No Bus:0000:07
[    6.032131] pci 0000:00:1b.3: PCI bridge to [bus 07]
[    6.036023] device: '0000:08': device_add
[    6.040023] PM: Adding info for No Bus:0000:08
[    6.044143] pci 0000:08:00.0: [1b21:1242] type 00 class 0x0c0330
[    6.052027] pci 0000:08:00.0: reg 0x10: [mem 0xefe00000-0xefe07fff 64bit]
[    6.056046] pci 0000:08:00.0: enabling Extended Tags
[    6.064072] pci 0000:08:00.0: PME# supported from D3hot D3cold
[    6.068030] device: '0000:08:00.0': device_add
[    6.072188] PM: Adding info for pci:0000:08:00.0
[    6.076006] pci 0000:00:1c.0: PCI bridge to [bus 08]
[    6.084003] pci 0000:00:1c.0:   bridge window [mem 0xefe00000-0xefefffff]
[    6.088023] device: '0000:09': device_add
[    6.092027] PM: Adding info for No Bus:0000:09
[    6.100131] pci 0000:00:1c.4: PCI bridge to [bus 09]
[    6.104026] device: '0000:0a': device_add
[    6.108022] PM: Adding info for No Bus:0000:0a
[    6.112126] pci 0000:00:1d.0: PCI bridge to [bus 0a]
[    6.116792] device: 'INT0800:00': device_add
[    6.124025] PM: Adding info for platform:INT0800:00
[    6.128137] device: 'PNP0103:00': device_add
[    6.132023] PM: Adding info for platform:PNP0103:00
[    6.136130] device: 'PNP0C04:00': device_add
[    6.140024] PM: Adding info for platform:PNP0C04:00
[    6.146828] device: 'PNP0C14:00': device_add
[    6.152024] PM: Adding info for platform:PNP0C14:00
[    6.156062] device: 'ACPI000C:00': device_add
[    6.164023] PM: Adding info for platform:ACPI000C:00
[    6.168155] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 *11 12 14 15)
[    6.176167] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *10 11 12 14 15)
[    6.180166] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 *11 12 14 15)
[    6.188164] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 *11 12 14 15)
[    6.196162] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 *11 12 14 15)
[    6.204162] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 *11 12 14 15)
[    6.208162] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 *11 12 14 15)
[    6.216160] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 *11 12 14 15)
[    6.224097] device: 'PNP0C0E:00': device_add
[    6.228027] PM: Adding info for platform:PNP0C0E:00
[    6.232026] device: 'PNP0C14:01': device_add
[    6.236023] PM: Adding info for platform:PNP0C14:01
[    6.240100] device: 'INT33A1:00': device_add
[    6.248023] PM: Adding info for platform:INT33A1:00
[    6.252081] device: 'PNP0C0C:00': device_add
[    6.256023] PM: Adding info for platform:PNP0C0C:00
[    6.260233] device: 'PNP0C0B:00': device_add
[    6.264025] PM: Adding info for platform:PNP0C0B:00
[    6.268092] device: 'PNP0C0B:01': device_add
[    6.276024] PM: Adding info for platform:PNP0C0B:01
[    6.280091] device: 'PNP0C0B:02': device_add
[    6.284023] PM: Adding info for platform:PNP0C0B:02
[    6.288090] device: 'PNP0C0B:03': device_add
[    6.292055] PM: Adding info for platform:PNP0C0B:03
[    6.296285] device: 'PNP0C0B:04': device_add
[    6.304024] PM: Adding info for platform:PNP0C0B:04
[    6.308266] device: 'LNXPWRBN:00': device_add
[    6.312017] PM: Adding info for acpi:LNXPWRBN:00
[    6.316085] initcall acpi_init+0x0/0x34c returned 0 after 3644531 usecs
[    6.324003] calling  pnp_init+0x0/0x11 @ 1
[    6.328016] initcall pnp_init+0x0/0x11 returned 0 after 0 usecs
[    6.332002] calling  balloon_init+0x0/0x1b0 @ 1
[    6.336001] initcall balloon_init+0x0/0x1b0 returned -19 after 0 usecs
[    6.344002] calling  xen_setup_shutdown_event+0x0/0x30 @ 1
[    6.348001] initcall xen_setup_shutdown_event+0x0/0x30 returned -19 after 0 usecs
[    6.356000] calling  xenbus_probe_backend_init+0x0/0x52 @ 1
[    6.364012] initcall xenbus_probe_backend_init+0x0/0x52 returned 0 after 0 usecs
[    6.368001] calling  xenbus_probe_frontend_init+0x0/0x52 @ 1
[    6.376013] initcall xenbus_probe_frontend_init+0x0/0x52 returned 0 after 0 usecs
[    6.384000] calling  xen_acpi_pad_init+0x0/0x45 @ 1
[    6.388001] initcall xen_acpi_pad_init+0x0/0x45 returned -19 after 0 usecs
[    6.396000] calling  pm8607_regulator_init+0x0/0x13 @ 1
[    6.400009] initcall pm8607_regulator_init+0x0/0x13 returned 0 after 0 usecs
[    6.408001] calling  lp8788_buck_init+0x0/0x13 @ 1
[    6.412007] initcall lp8788_buck_init+0x0/0x13 returned 0 after 0 usecs
[    6.420001] calling  lp8788_ldo_init+0x0/0x18 @ 1
[    6.424013] initcall lp8788_ldo_init+0x0/0x18 returned 0 after 0 usecs
[    6.428001] calling  misc_init+0x0/0xbb @ 1
[    6.432011] initcall misc_init+0x0/0xbb returned 0 after 0 usecs
[    6.440005] calling  tpm_init+0x0/0xd3 @ 1
[    6.444015] initcall tpm_init+0x0/0xd3 returned 0 after 0 usecs
[    6.452001] calling  vga_arb_device_init+0x0/0x23b @ 1
[    6.456003] device: 'vga_arbiter': device_add
[    6.460017] PM: Adding info for No Bus:vga_arbiter
[    6.464014] pci 0000:03:00.0: vgaarb: setting as boot VGA device
[    6.468000] pci 0000:03:00.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    6.480002] pci 0000:03:00.0: vgaarb: bridge control possible
[    6.484000] vgaarb: loaded
[    6.488001] initcall vga_arb_device_init+0x0/0x23b returned 0 after 31250 usecs
[    6.496001] calling  cn_init+0x0/0xb0 @ 1
[    6.500012] initcall cn_init+0x0/0xb0 returned 0 after 0 usecs
[    6.504001] calling  pm860x_i2c_init+0x0/0x2e @ 1
[    6.508010] initcall pm860x_i2c_init+0x0/0x2e returned 0 after 0 usecs
[    6.516001] calling  wm8400_module_init+0x0/0x2e @ 1
[    6.520008] initcall wm8400_module_init+0x0/0x2e returned 0 after 0 usecs
[    6.528001] calling  wm831x_i2c_init+0x0/0x2e @ 1
[    6.532007] initcall wm831x_i2c_init+0x0/0x2e returned 0 after 0 usecs
[    6.540001] calling  wm831x_spi_init+0x0/0x2a @ 1
[    6.544007] initcall wm831x_spi_init+0x0/0x2a returned 0 after 0 usecs
[    6.548001] calling  wm8350_i2c_init+0x0/0x13 @ 1
[    6.556007] initcall wm8350_i2c_init+0x0/0x13 returned 0 after 0 usecs
[    6.560001] calling  tps65910_i2c_init+0x0/0x13 @ 1
[    6.568008] initcall tps65910_i2c_init+0x0/0x13 returned 0 after 0 usecs
[    6.572001] calling  tps80031_init+0x0/0x13 @ 1
[    6.576008] initcall tps80031_init+0x0/0x13 returned 0 after 0 usecs
[    6.584001] calling  ezx_pcap_init+0x0/0x13 @ 1
[    6.588007] initcall ezx_pcap_init+0x0/0x13 returned 0 after 0 usecs
[    6.596001] calling  da903x_init+0x0/0x13 @ 1
[    6.600007] initcall da903x_init+0x0/0x13 returned 0 after 0 usecs
[    6.604001] calling  da9052_spi_init+0x0/0x2e @ 1
[    6.608007] initcall da9052_spi_init+0x0/0x2e returned 0 after 0 usecs
[    6.616001] calling  da9052_i2c_init+0x0/0x2e @ 1
[    6.620007] initcall da9052_i2c_init+0x0/0x2e returned 0 after 0 usecs
[    6.628001] calling  lp8788_init+0x0/0x13 @ 1
[    6.632006] initcall lp8788_init+0x0/0x13 returned 0 after 0 usecs
[    6.640001] calling  da9055_i2c_init+0x0/0x2e @ 1
[    6.644008] initcall da9055_i2c_init+0x0/0x2e returned 0 after 0 usecs
[    6.648001] calling  max8925_i2c_init+0x0/0x2e @ 1
[    6.656008] initcall max8925_i2c_init+0x0/0x2e returned 0 after 0 usecs
[    6.660001] calling  max8997_i2c_init+0x0/0x13 @ 1
[    6.664006] initcall max8997_i2c_init+0x0/0x13 returned 0 after 0 usecs
[    6.672001] calling  max8998_i2c_init+0x0/0x13 @ 1
[    6.676005] initcall max8998_i2c_init+0x0/0x13 returned 0 after 0 usecs
[    6.684001] calling  ab3100_i2c_init+0x0/0x13 @ 1
[    6.688005] initcall ab3100_i2c_init+0x0/0x13 returned 0 after 0 usecs
[    6.696001] calling  tps6586x_init+0x0/0x13 @ 1
[    6.700007] initcall tps6586x_init+0x0/0x13 returned 0 after 0 usecs
[    6.704001] calling  tps65090_init+0x0/0x13 @ 1
[    6.712007] initcall tps65090_init+0x0/0x13 returned 0 after 0 usecs
[    6.716001] calling  aat2870_init+0x0/0x13 @ 1
[    6.720007] initcall aat2870_init+0x0/0x13 returned 0 after 0 usecs
[    6.728001] calling  palmas_i2c_init+0x0/0x13 @ 1
[    6.732007] initcall palmas_i2c_init+0x0/0x13 returned 0 after 0 usecs
[    6.740001] calling  rc5t583_i2c_init+0x0/0x13 @ 1
[    6.744007] initcall rc5t583_i2c_init+0x0/0x13 returned 0 after 0 usecs
[    6.748001] calling  sec_pmic_init+0x0/0x13 @ 1
[    6.756007] initcall sec_pmic_init+0x0/0x13 returned 0 after 0 usecs
[    6.760001] calling  as3711_i2c_init+0x0/0x13 @ 1
[    6.764009] initcall as3711_i2c_init+0x0/0x13 returned 0 after 0 usecs
[    6.772001] calling  dax_fs_init+0x0/0xc9 @ 1
[    6.776054] initcall dax_fs_init+0x0/0xc9 returned 0 after 0 usecs
[    6.784001] calling  dma_buf_init+0x0/0xaf @ 1
[    6.788005] initcall dma_buf_init+0x0/0xaf returned 0 after 0 usecs
[    6.792001] calling  init_scsi+0x0/0x90 @ 1
[    6.796139] SCSI subsystem initialized
[    6.800001] initcall init_scsi+0x0/0x90 returned 0 after 3906 usecs
[    6.808002] calling  ata_init+0x0/0x39b @ 1
[    6.812027] libata version 3.00 loaded.
[    6.816003] initcall ata_init+0x0/0x39b returned 0 after 3906 usecs
[    6.824002] calling  phy_init+0x0/0x4c @ 1
[    6.828032] initcall phy_init+0x0/0x4c returned 0 after 0 usecs
[    6.832002] calling  usb_init+0x0/0x166 @ 1
[    6.836008] ACPI: bus type USB registered
[    6.840030] usbcore: registered new interface driver usbfs
[    6.844015] usbcore: registered new interface driver hub
[    6.852024] usbcore: registered new device driver usb
[    6.856002] initcall usb_init+0x0/0x166 returned 0 after 19531 usecs
[    6.864001] calling  serio_init+0x0/0x2c @ 1
[    6.868011] initcall serio_init+0x0/0x2c returned 0 after 0 usecs
[    6.872001] calling  input_init+0x0/0x104 @ 1
[    6.876008] initcall input_init+0x0/0x104 returned 0 after 0 usecs
[    6.884001] calling  rtc_init+0x0/0x4e @ 1
[    6.888008] initcall rtc_init+0x0/0x4e returned 0 after 0 usecs
[    6.892001] calling  pps_init+0x0/0xb2 @ 1
[    6.896005] pps_core: LinuxPPS API ver. 1 registered
[    6.904000] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
[    6.912001] initcall pps_init+0x0/0xb2 returned 0 after 15625 usecs
[    6.916000] calling  ptp_init+0x0/0x9f @ 1
[    6.924005] PTP clock support registered
[    6.928001] initcall ptp_init+0x0/0x9f returned 0 after 3906 usecs
[    6.932001] calling  power_supply_class_init+0x0/0x40 @ 1
[    6.936005] initcall power_supply_class_init+0x0/0x40 returned 0 after 0 usecs
[    6.944001] calling  hwmon_init+0x0/0xd2 @ 1
[    6.948005] initcall hwmon_init+0x0/0xd2 returned 0 after 0 usecs
[    6.956001] calling  md_init+0x0/0x162 @ 1
[    6.960020] initcall md_init+0x0/0x162 returned 0 after 0 usecs
[    6.964002] calling  edac_init+0x0/0x78 @ 1
[    6.968000] EDAC MC: Ver: 3.0.0
[    6.971150] device: 'edac': device_add
[    6.976013] PM: Adding info for No Bus:edac
[    6.980054] device: 'mc': device_add
[    6.984013] PM: Adding info for edac:mc
[    6.988013] initcall edac_init+0x0/0x78 returned 0 after 19531 usecs
[    6.996001] calling  mmc_init+0x0/0x39 @ 1
[    7.000023] initcall mmc_init+0x0/0x39 returned 0 after 0 usecs
[    7.004001] calling  leds_init+0x0/0x3c @ 1
[    7.008005] initcall leds_init+0x0/0x3c returned 0 after 0 usecs
[    7.016001] calling  dmi_init+0x0/0x11c @ 1
[    7.020014] initcall dmi_init+0x0/0x11c returned 0 after 0 usecs
[    7.024001] calling  efisubsys_init+0x0/0x2a4 @ 1
[    7.028001] initcall efisubsys_init+0x0/0x2a4 returned 0 after 0 usecs
[    7.036001] calling  devfreq_init+0x0/0xa7 @ 1
[    7.040013] initcall devfreq_init+0x0/0xa7 returned 0 after 0 usecs
[    7.048002] calling  devfreq_simple_ondemand_init+0x0/0x11 @ 1
[    7.052001] initcall devfreq_simple_ondemand_init+0x0/0x11 returned 0 after 0 usecs
[    7.060001] calling  devfreq_performance_init+0x0/0x11 @ 1
[    7.064001] initcall devfreq_performance_init+0x0/0x11 returned 0 after 0 usecs
[    7.072001] calling  devfreq_powersave_init+0x0/0x11 @ 1
[    7.080001] initcall devfreq_powersave_init+0x0/0x11 returned 0 after 0 usecs
[    7.084001] calling  devfreq_userspace_init+0x0/0x11 @ 1
[    7.092001] initcall devfreq_userspace_init+0x0/0x11 returned 0 after 0 usecs
[    7.096001] calling  ras_init+0x0/0xf @ 1
[    7.100006] initcall ras_init+0x0/0xf returned 0 after 0 usecs
[    7.108001] calling  nvmem_init+0x0/0x11 @ 1
[    7.112012] initcall nvmem_init+0x0/0x11 returned 0 after 0 usecs
[    7.120001] calling  pci_subsys_init+0x0/0x63 @ 1
[    7.124000] PCI: Using ACPI for IRQ routing
[    7.138711] PCI: pci_cache_line_size set to 64 bytes
[    7.144051] e820: reserve RAM buffer [mem 0x0009c800-0x0009ffff]
[    7.152004] initcall pci_subsys_init+0x0/0x63 returned 0 after 27343 usecs
[    7.156000] calling  proto_init+0x0/0x11 @ 1
[    7.160003] initcall proto_init+0x0/0x11 returned 0 after 3906 usecs
[    7.168001] calling  net_dev_init+0x0/0x1f2 @ 1
[    7.172038] device: 'lo': device_add
[    7.176076] PM: Adding info for No Bus:lo
[    7.180042] initcall net_dev_init+0x0/0x1f2 returned 0 after 7812 usecs
[    7.188001] calling  neigh_init+0x0/0x80 @ 1
[    7.192004] initcall neigh_init+0x0/0x80 returned 0 after 0 usecs
[    7.196000] calling  fib_notifier_init+0x0/0x11 @ 1
[    7.204001] initcall fib_notifier_init+0x0/0x11 returned 0 after 0 usecs
[    7.208000] calling  fib_rules_init+0x0/0xa8 @ 1
[    7.212002] initcall fib_rules_init+0x0/0xa8 returned 0 after 0 usecs
[    7.220001] calling  pktsched_init+0x0/0x113 @ 1
[    7.224006] initcall pktsched_init+0x0/0x113 returned 0 after 0 usecs
[    7.232001] calling  tc_filter_init+0x0/0xa9 @ 1
[    7.236010] initcall tc_filter_init+0x0/0xa9 returned 0 after 0 usecs
[    7.244001] calling  tc_action_init+0x0/0x6f @ 1
[    7.248006] initcall tc_action_init+0x0/0x6f returned 0 after 0 usecs
[    7.252001] calling  genl_init+0x0/0x38 @ 1
[    7.256008] initcall genl_init+0x0/0x38 returned 0 after 0 usecs
[    7.264001] calling  cipso_v4_init+0x0/0x71 @ 1
[    7.268002] initcall cipso_v4_init+0x0/0x71 returned 0 after 0 usecs
[    7.276001] calling  wireless_nlevent_init+0x0/0x3c @ 1
[    7.280001] initcall wireless_nlevent_init+0x0/0x3c returned 0 after 0 usecs
[    7.288002] calling  netlbl_init+0x0/0x83 @ 1
[    7.292000] NetLabel: Initializing
[    7.296000] NetLabel:  domain hash size = 128
[    7.300000] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    7.304025] NetLabel:  unlabeled traffic allowed by default
[    7.312001] initcall netlbl_init+0x0/0x83 returned 0 after 19531 usecs
[    7.316001] calling  rfkill_init+0x0/0xf2 @ 1
[    7.320007] device: 'rfkill': device_add
[    7.324014] PM: Adding info for No Bus:rfkill
[    7.328005] initcall rfkill_init+0x0/0xf2 returned 0 after 7812 usecs
[    7.336001] calling  xen_mcfg_late+0x0/0xd5 @ 1
[    7.340000] initcall xen_mcfg_late+0x0/0xd5 returned 0 after 0 usecs
[    7.348001] calling  watchdog_init+0x0/0x8a @ 1
[    7.352010] initcall watchdog_init+0x0/0x8a returned 0 after 0 usecs
[    7.356027] calling  nmi_warning_debugfs+0x0/0x27 @ 1
[    7.364005] initcall nmi_warning_debugfs+0x0/0x27 returned 0 after 0 usecs
[    7.368001] calling  save_microcode_in_initrd+0x0/0x7f @ 1
[    7.376002] initcall save_microcode_in_initrd+0x0/0x7f returned 0 after 0 usecs
[    7.384001] calling  hpet_late_init+0x0/0x106 @ 1
[    7.388040] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    7.392000] hpet0: 8 comparators, 64-bit 24.000000 MHz counter
[    7.402030] initcall hpet_late_init+0x0/0x106 returned 0 after 11718 usecs
[    7.408001] calling  init_amd_nbs+0x0/0xf7 @ 1
[    7.412003] initcall init_amd_nbs+0x0/0xf7 returned 0 after 0 usecs
[    7.420001] calling  clocksource_done_booting+0x0/0x42 @ 1
[    7.424009] clocksource: Switched to clocksource tsc-early
[    7.429490] initcall clocksource_done_booting+0x0/0x42 returned 0 after 5361 usecs
[    7.437056] calling  tracer_init_tracefs+0x0/0x1b3 @ 1
[    7.444007] initcall tracer_init_tracefs+0x0/0x1b3 returned 0 after 1770 usecs
[    7.451223] calling  init_trace_printk_function_export+0x0/0x2d @ 1
[    7.457491] initcall init_trace_printk_function_export+0x0/0x2d returned 0 after 1 usecs
[    7.465576] calling  init_graph_tracefs+0x0/0x2d @ 1
[    7.470543] initcall init_graph_tracefs+0x0/0x2d returned 0 after 1 usecs
[    7.477329] calling  event_trace_init+0x0/0x2d6 @ 1
[    7.497257] initcall event_trace_init+0x0/0x2d6 returned 0 after 14695 usecs
[    7.504299] calling  init_kprobe_trace+0x0/0x8c @ 1
[    7.509183] initcall init_kprobe_trace+0x0/0x8c returned 0 after 3 usecs
[    7.515876] calling  init_uprobe_trace+0x0/0x4f @ 1
[    7.520760] initcall init_uprobe_trace+0x0/0x4f returned 0 after 3 usecs
[    7.527455] calling  init_pipe_fs+0x0/0x47 @ 1
[    7.531936] initcall init_pipe_fs+0x0/0x47 returned 0 after 32 usecs
[    7.538290] calling  cgroup_writeback_init+0x0/0x2d @ 1
[    7.543530] initcall cgroup_writeback_init+0x0/0x2d returned 0 after 15 usecs
[    7.550659] calling  inotify_user_setup+0x0/0x4b @ 1
[    7.555627] initcall inotify_user_setup+0x0/0x4b returned 0 after 2 usecs
[    7.562408] calling  eventpoll_init+0x0/0xa1 @ 1
[    7.567048] initcall eventpoll_init+0x0/0xa1 returned 0 after 19 usecs
[    7.573572] calling  anon_inode_init+0x0/0x5f @ 1
[    7.578306] initcall anon_inode_init+0x0/0x5f returned 0 after 27 usecs
[    7.584915] calling  proc_locks_init+0x0/0x1f @ 1
[    7.589623] initcall proc_locks_init+0x0/0x1f returned 0 after 1 usecs
[    7.596147] calling  dquot_init+0x0/0x132 @ 1
[    7.600505] VFS: Disk quotas dquot_6.6.0
[    7.604472] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    7.611343] initcall dquot_init+0x0/0x132 returned 0 after 10582 usecs
[    7.617868] calling  quota_init+0x0/0x26 @ 1
[    7.622151] initcall quota_init+0x0/0x26 returned 0 after 10 usecs
[    7.628328] calling  proc_cmdline_init+0x0/0x1f @ 1
[    7.633207] initcall proc_cmdline_init+0x0/0x1f returned 0 after 1 usecs
[    7.639906] calling  proc_consoles_init+0x0/0x1f @ 1
[    7.644872] initcall proc_consoles_init+0x0/0x1f returned 0 after 0 usecs
[    7.651657] calling  proc_cpuinfo_init+0x0/0x1f @ 1
[    7.656529] initcall proc_cpuinfo_init+0x0/0x1f returned 0 after 0 usecs
[    7.663229] calling  proc_devices_init+0x0/0x1f @ 1
[    7.668107] initcall proc_devices_init+0x0/0x1f returned 0 after 0 usecs
[    7.674805] calling  proc_interrupts_init+0x0/0x1f @ 1
[    7.679937] initcall proc_interrupts_init+0x0/0x1f returned 0 after 0 usecs
[    7.686895] calling  proc_loadavg_init+0x0/0x1f @ 1
[    7.691767] initcall proc_loadavg_init+0x0/0x1f returned 0 after 0 usecs
[    7.698467] calling  proc_meminfo_init+0x0/0x1f @ 1
[    7.703347] initcall proc_meminfo_init+0x0/0x1f returned 0 after 0 usecs
[    7.710046] calling  proc_stat_init+0x0/0x1f @ 1
[    7.714665] initcall proc_stat_init+0x0/0x1f returned 0 after 0 usecs
[    7.721103] calling  proc_uptime_init+0x0/0x1f @ 1
[    7.725889] initcall proc_uptime_init+0x0/0x1f returned 0 after 0 usecs
[    7.732500] calling  proc_version_init+0x0/0x1f @ 1
[    7.737380] initcall proc_version_init+0x0/0x1f returned 0 after 0 usecs
[    7.744081] calling  proc_softirqs_init+0x0/0x1f @ 1
[    7.749046] initcall proc_softirqs_init+0x0/0x1f returned 0 after 0 usecs
[    7.755831] calling  proc_kcore_init+0x0/0x152 @ 1
[    7.760627] initcall proc_kcore_init+0x0/0x152 returned 0 after 4 usecs
[    7.767237] calling  vmcore_init+0x0/0x3e5 @ 1
[    7.771683] initcall vmcore_init+0x0/0x3e5 returned 0 after 0 usecs
[    7.777949] calling  proc_kmsg_init+0x0/0x22 @ 1
[    7.782570] initcall proc_kmsg_init+0x0/0x22 returned 0 after 1 usecs
[    7.789008] calling  proc_page_init+0x0/0x56 @ 1
[    7.793629] initcall proc_page_init+0x0/0x56 returned 0 after 3 usecs
[    7.800065] calling  init_ramfs_fs+0x0/0x20 @ 1
[    7.804598] initcall init_ramfs_fs+0x0/0x20 returned 0 after 0 usecs
[    7.810951] calling  init_hugetlbfs_fs+0x0/0x182 @ 1
[    7.816007] initcall init_hugetlbfs_fs+0x0/0x182 returned 0 after 85 usecs
[    7.822877] calling  tomoyo_initerface_init+0x0/0x17b @ 1
[    7.828278] initcall tomoyo_initerface_init+0x0/0x17b returned 0 after 0 usecs
[    7.835495] calling  aa_create_aafs+0x0/0x385 @ 1
[    7.840346] AppArmor: AppArmor Filesystem Enabled
[    7.845047] initcall aa_create_aafs+0x0/0x385 returned 0 after 4731 usecs
[    7.851833] calling  blk_scsi_ioctl_init+0x0/0x2ec @ 1
[    7.856971] initcall blk_scsi_ioctl_init+0x0/0x2ec returned 0 after 0 usecs
[    7.863930] calling  dynamic_debug_init_debugfs+0x0/0x64 @ 1
[    7.869594] initcall dynamic_debug_init_debugfs+0x0/0x64 returned 0 after 4 usecs
[    7.877069] calling  simplefb_init+0x0/0x13 @ 1
[    7.881620] initcall simplefb_init+0x0/0x13 returned 0 after 17 usecs
[    7.888059] calling  acpi_event_init+0x0/0x2f @ 1
[    7.892777] initcall acpi_event_init+0x0/0x2f returned 0 after 10 usecs
[    7.899388] calling  pnp_system_init+0x0/0x11 @ 1
[    7.904100] initcall pnp_system_init+0x0/0x11 returned 0 after 7 usecs
[    7.910627] calling  pnpacpi_init+0x0/0x74 @ 1
[    7.915071] pnp: PnP ACPI init
[    7.918127] device: 'pnp0': device_add
[    7.921889] PM: Adding info for No Bus:pnp0
[    7.926536] device: '00:00': device_add
[    7.930398] PM: Adding info for pnp:00:00
[    7.934420] devices_kset: Moving 00:00 to end of list
[    7.939472] system 00:00: [io  0x0a00-0x0a2f] has been reserved
[    7.945389] system 00:00: [io  0x0a30-0x0a3f] has been reserved
[    7.951309] system 00:00: [io  0x0a40-0x0a4f] has been reserved
[    7.957230] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    7.964936] pnp 00:01: [dma 0 disabled]
[    7.969022] device: '00:01': device_add
[    7.972886] PM: Adding info for pnp:00:01
[    7.976895] pnp 00:01: Plug and Play ACPI device, IDs PNP0400 (active)
[    7.984255] pnp 00:02: [dma 0 disabled]
[    7.988119] device: '00:02': device_add
[    7.991979] PM: Adding info for pnp:00:02
[    7.995988] pnp 00:02: Plug and Play ACPI device, IDs PNP0501 (active)
[    8.002690] device: '00:03': device_add
[    8.006551] PM: Adding info for pnp:00:03
[    8.010571] devices_kset: Moving 00:03 to end of list
[    8.015626] system 00:03: [io  0x0680-0x069f] has been reserved
[    8.021545] system 00:03: [io  0xffff] has been reserved
[    8.026856] system 00:03: [io  0xffff] has been reserved
[    8.032168] system 00:03: [io  0xffff] has been reserved
[    8.037482] system 00:03: [io  0x1800-0x18fe] has been reserved
[    8.043401] system 00:03: [io  0x164e-0x164f] has been reserved
[    8.049323] system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
[    8.056206] device: '00:04': device_add
[    8.060063] PM: Adding info for pnp:00:04
[    8.064080] devices_kset: Moving 00:04 to end of list
[    8.069133] system 00:04: [io  0x0800-0x087f] has been reserved
[    8.075054] system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
[    8.081854] device: '00:05': device_add
[    8.085715] PM: Adding info for pnp:00:05
[    8.089727] pnp 00:05: Plug and Play ACPI device, IDs PNP0b00 (active)
[    8.096299] device: '00:06': device_add
[    8.100157] PM: Adding info for pnp:00:06
[    8.104181] devices_kset: Moving 00:06 to end of list
[    8.109233] system 00:06: [io  0x1854-0x1857] has been reserved
[    8.115155] system 00:06: Plug and Play ACPI device, IDs INT3f0d PNP0c02 (active)
[    8.123121] device: '00:07': device_add
[    8.126979] PM: Adding info for pnp:00:07
[    8.130995] devices_kset: Moving 00:07 to end of list
[    8.136051] system 00:07: [mem 0xfed10000-0xfed17fff] has been reserved
[    8.142662] system 00:07: [mem 0xfed18000-0xfed18fff] has been reserved
[    8.149274] system 00:07: [mem 0xfed19000-0xfed19fff] has been reserved
[    8.155886] system 00:07: [mem 0xf0000000-0xf7ffffff] has been reserved
[    8.162498] system 00:07: [mem 0xfed20000-0xfed3ffff] has been reserved
[    8.169111] system 00:07: [mem 0xfed90000-0xfed93fff] could not be reserved
[    8.176071] system 00:07: [mem 0xfed45000-0xfed8ffff] has been reserved
[    8.182685] system 00:07: [mem 0xff000000-0xffffffff] has been reserved
[    8.189296] system 00:07: [mem 0xfee00000-0xfeefffff] could not be reserved
[    8.196257] system 00:07: [mem 0xeffe0000-0xefffffff] has been reserved
[    8.202869] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
[    8.209707] device: '00:08': device_add
[    8.213568] PM: Adding info for pnp:00:08
[    8.217582] devices_kset: Moving 00:08 to end of list
[    8.222637] system 00:08: [mem 0xfd000000-0xfdabffff] has been reserved
[    8.229359] system 00:08: [mem 0xfdad0000-0xfdadffff] has been reserved
[    8.235990] system 00:08: [mem 0xfdb00000-0xfdffffff] has been reserved
[    8.242633] system 00:08: [mem 0xfe000000-0xfe01ffff] could not be reserved
[    8.249591] system 00:08: [mem 0xfe036000-0xfe03bfff] has been reserved
[    8.256203] system 00:08: [mem 0xfe03d000-0xfe3fffff] has been reserved
[    8.262815] system 00:08: [mem 0xfe410000-0xfe7fffff] has been reserved
[    8.269431] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
[    8.276655] device: '00:09': device_add
[    8.280522] PM: Adding info for pnp:00:09
[    8.284542] devices_kset: Moving 00:09 to end of list
[    8.289597] system 00:09: [io  0xff00-0xfffe] has been reserved
[    8.295515] system 00:09: Plug and Play ACPI device, IDs PNP0c02 (active)
[    8.304866] device: '00:0a': device_add
[    8.308729] PM: Adding info for pnp:00:0a
[    8.312744] devices_kset: Moving 00:0a to end of list
[    8.317797] system 00:0a: [mem 0xfdaf0000-0xfdafffff] has been reserved
[    8.324411] system 00:0a: [mem 0xfdae0000-0xfdaeffff] has been reserved
[    8.331022] system 00:0a: [mem 0xfdac0000-0xfdacffff] has been reserved
[    8.337637] system 00:0a: Plug and Play ACPI device, IDs PNP0c02 (active)
[    8.346296] pnp: PnP ACPI: found 11 devices
[    8.350478] initcall pnpacpi_init+0x0/0x74 returned 0 after 425200 usecs
[    8.357176] calling  chr_dev_init+0x0/0xad @ 1
[    8.361634] device: 'mem': device_add
[    8.365311] PM: Adding info for No Bus:mem
[    8.369427] device: 'kmem': device_add
[    8.373187] PM: Adding info for No Bus:kmem
[    8.377381] device: 'null': device_add
[    8.381147] PM: Adding info for No Bus:null
[    8.385341] device: 'port': device_add
[    8.389101] PM: Adding info for No Bus:port
[    8.393502] device: 'zero': device_add
[    8.397263] PM: Adding info for No Bus:zero
[    8.401457] device: 'full': device_add
[    8.405219] PM: Adding info for No Bus:full
[    8.409415] device: 'random': device_add
[    8.413350] PM: Adding info for No Bus:random
[    8.417717] device: 'urandom': device_add
[    8.421738] PM: Adding info for No Bus:urandom
[    8.426191] device: 'kmsg': device_add
[    8.429952] PM: Adding info for No Bus:kmsg
[    8.434150] device: 'tty': device_add
[    8.437825] PM: Adding info for No Bus:tty
[    8.441933] device: 'console': device_add
[    8.445954] PM: Adding info for No Bus:console
[    8.450408] device: 'tty0': device_add
[    8.454171] PM: Adding info for No Bus:tty0
[    8.458372] device: 'vcs': device_add
[    8.462050] PM: Adding info for No Bus:vcs
[    8.466156] device: 'vcsa': device_add
[    8.469916] PM: Adding info for No Bus:vcsa
[    8.474114] device: 'vcs1': device_add
[    8.477877] PM: Adding info for No Bus:vcs1
[    8.482075] device: 'vcsa1': device_add
[    8.485926] PM: Adding info for No Bus:vcsa1
[    8.490210] device: 'tty1': device_add
[    8.493978] PM: Adding info for No Bus:tty1
[    8.498171] device: 'tty2': device_add
[    8.501932] PM: Adding info for No Bus:tty2
[    8.506128] device: 'tty3': device_add
[    8.509888] PM: Adding info for No Bus:tty3
[    8.514082] device: 'tty4': device_add
[    8.517844] PM: Adding info for No Bus:tty4
[    8.522041] device: 'tty5': device_add
[    8.525802] PM: Adding info for No Bus:tty5
[    8.529994] device: 'tty6': device_add
[    8.533758] PM: Adding info for No Bus:tty6
[    8.537954] device: 'tty7': device_add
[    8.541722] PM: Adding info for No Bus:tty7
[    8.545916] device: 'tty8': device_add
[    8.549678] PM: Adding info for No Bus:tty8
[    8.553871] device: 'tty9': device_add
[    8.557635] PM: Adding info for No Bus:tty9
[    8.561827] device: 'tty10': device_add
[    8.565675] PM: Adding info for No Bus:tty10
[    8.569958] device: 'tty11': device_add
[    8.573804] PM: Adding info for No Bus:tty11
[    8.578085] device: 'tty12': device_add
[    8.581934] PM: Adding info for No Bus:tty12
[    8.586216] device: 'tty13': device_add
[    8.590064] PM: Adding info for No Bus:tty13
[    8.594346] device: 'tty14': device_add
[    8.598192] PM: Adding info for No Bus:tty14
[    8.602477] device: 'tty15': device_add
[    8.606331] PM: Adding info for No Bus:tty15
[    8.610611] device: 'tty16': device_add
[    8.614461] PM: Adding info for No Bus:tty16
[    8.618741] device: 'tty17': device_add
[    8.622590] PM: Adding info for No Bus:tty17
[    8.626870] device: 'tty18': device_add
[    8.630719] PM: Adding info for No Bus:tty18
[    8.635002] device: 'tty19': device_add
[    8.638849] PM: Adding info for No Bus:tty19
[    8.643129] device: 'tty20': device_add
[    8.646977] PM: Adding info for No Bus:tty20
[    8.651259] device: 'tty21': device_add
[    8.655107] PM: Adding info for No Bus:tty21
[    8.659387] device: 'tty22': device_add
[    8.663237] PM: Adding info for No Bus:tty22
[    8.667518] device: 'tty23': device_add
[    8.671368] PM: Adding info for No Bus:tty23
[    8.675647] device: 'tty24': device_add
[    8.679497] PM: Adding info for No Bus:tty24
[    8.683776] device: 'tty25': device_add
[    8.687625] PM: Adding info for No Bus:tty25
[    8.691905] device: 'tty26': device_add
[    8.695755] PM: Adding info for No Bus:tty26
[    8.700036] device: 'tty27': device_add
[    8.703882] PM: Adding info for No Bus:tty27
[    8.708167] device: 'tty28': device_add
[    8.712022] PM: Adding info for No Bus:tty28
[    8.716302] device: 'tty29': device_add
[    8.720151] PM: Adding info for No Bus:tty29
[    8.724433] device: 'tty30': device_add
[    8.728280] PM: Adding info for No Bus:tty30
[    8.732562] device: 'tty31': device_add
[    8.736410] PM: Adding info for No Bus:tty31
[    8.740691] device: 'tty32': device_add
[    8.744538] PM: Adding info for No Bus:tty32
[    8.748820] device: 'tty33': device_add
[    8.752668] PM: Adding info for No Bus:tty33
[    8.756948] device: 'tty34': device_add
[    8.760799] PM: Adding info for No Bus:tty34
[    8.765084] device: 'tty35': device_add
[    8.768936] PM: Adding info for No Bus:tty35
[    8.773216] device: 'tty36': device_add
[    8.777064] PM: Adding info for No Bus:tty36
[    8.781345] device: 'tty37': device_add
[    8.785194] PM: Adding info for No Bus:tty37
[    8.789475] device: 'tty38': device_add
[    8.793323] PM: Adding info for No Bus:tty38
[    8.797609] device: 'tty39': device_add
[    8.801462] PM: Adding info for No Bus:tty39
[    8.805742] device: 'tty40': device_add
[    8.809589] PM: Adding info for No Bus:tty40
[    8.813873] device: 'tty41': device_add
[    8.817720] PM: Adding info for No Bus:tty41
[    8.822000] device: 'tty42': device_add
[    8.825851] PM: Adding info for No Bus:tty42
[    8.830131] device: 'tty43': device_add
[    8.833977] PM: Adding info for No Bus:tty43
[    8.838260] device: 'tty44': device_add
[    8.842107] PM: Adding info for No Bus:tty44
[    8.846390] device: 'tty45': device_add
[    8.850236] PM: Adding info for No Bus:tty45
[    8.854519] device: 'tty46': device_add
[    8.858367] PM: Adding info for No Bus:tty46
[    8.862648] device: 'tty47': device_add
[    8.866495] PM: Adding info for No Bus:tty47
[    8.870778] device: 'tty48': device_add
[    8.874625] PM: Adding info for No Bus:tty48
[    8.878905] device: 'tty49': device_add
[    8.882754] PM: Adding info for No Bus:tty49
[    8.887035] device: 'tty50': device_add
[    8.890884] PM: Adding info for No Bus:tty50
[    8.895166] device: 'tty51': device_add
[    8.899015] PM: Adding info for No Bus:tty51
[    8.903296] device: 'tty52': device_add
[    8.907143] PM: Adding info for No Bus:tty52
[    8.911423] device: 'tty53': device_add
[    8.915271] PM: Adding info for No Bus:tty53
[    8.919554] device: 'tty54': device_add
[    8.923401] PM: Adding info for No Bus:tty54
[    8.927684] device: 'tty55': device_add
[    8.931531] PM: Adding info for No Bus:tty55
[    8.935812] device: 'tty56': device_add
[    8.939658] PM: Adding info for No Bus:tty56
[    8.943942] device: 'tty57': device_add
[    8.947788] PM: Adding info for No Bus:tty57
[    8.952072] device: 'tty58': device_add
[    8.955917] PM: Adding info for No Bus:tty58
[    8.960203] device: 'tty59': device_add
[    8.964058] PM: Adding info for No Bus:tty59
[    8.968339] device: 'tty60': device_add
[    8.972186] PM: Adding info for No Bus:tty60
[    8.976467] device: 'tty61': device_add
[    8.980317] PM: Adding info for No Bus:tty61
[    8.984597] device: 'tty62': device_add
[    8.988444] PM: Adding info for No Bus:tty62
[    8.992726] device: 'tty63': device_add
[    8.996574] PM: Adding info for No Bus:tty63
[    9.000888] initcall chr_dev_init+0x0/0xad returned 0 after 624281 usecs
[    9.007584] calling  firmware_class_init+0x0/0x108 @ 1
[    9.012730] initcall firmware_class_init+0x0/0x108 returned 0 after 6 usecs
[    9.019682] calling  thermal_init+0x0/0xdd @ 1
[    9.024143] initcall thermal_init+0x0/0xdd returned 0 after 13 usecs
[    9.030490] calling  cpufreq_gov_performance_init+0x0/0x11 @ 1
[    9.036322] initcall cpufreq_gov_performance_init+0x0/0x11 returned 0 after 0 usecs
[    9.043977] calling  init_acpi_pm_clocksource+0x0/0xd9 @ 1
[    9.053943] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    9.062810] initcall init_acpi_pm_clocksource+0x0/0xd9 returned 0 after 13034 usecs
[    9.070462] calling  pcibios_assign_resources+0x0/0xbc @ 1
[    9.075991] pci 0000:02:00.0: PCI bridge to [bus 03]
[    9.080958] pci 0000:02:00.0:   bridge window [io  0xe000-0xefff]
[    9.087049] pci 0000:02:00.0:   bridge window [mem 0xefc00000-0xefcfffff]
[    9.093835] pci 0000:02:00.0:   bridge window [mem 0xd0000000-0xe01fffff 64bit pref]
[    9.101576] pci 0000:01:00.0: PCI bridge to [bus 02-03]
[    9.106800] pci 0000:01:00.0:   bridge window [io  0xe000-0xefff]
[    9.112894] pci 0000:01:00.0:   bridge window [mem 0xefc00000-0xefcfffff]
[    9.119679] pci 0000:01:00.0:   bridge window [mem 0xd0000000-0xe01fffff 64bit pref]
[    9.127420] pci 0000:00:01.0: PCI bridge to [bus 01-03]
[    9.132645] pci 0000:00:01.0:   bridge window [io  0xe000-0xefff]
[    9.138736] pci 0000:00:01.0:   bridge window [mem 0xefc00000-0xefdfffff]
[    9.145522] pci 0000:00:01.0:   bridge window [mem 0xd0000000-0xe01fffff 64bit pref]
[    9.153262] pci 0000:00:1b.0: PCI bridge to [bus 04]
[    9.158232] pci 0000:05:00.0: PCI bridge to [bus 06]
[    9.163206] pci 0000:00:1b.2: PCI bridge to [bus 05-06]
[    9.168435] pci 0000:00:1b.3: PCI bridge to [bus 07]
[    9.173399] pci 0000:00:1c.0: PCI bridge to [bus 08]
[    9.178363] pci 0000:00:1c.0:   bridge window [mem 0xefe00000-0xefefffff]
[    9.185150] pci 0000:00:1c.4: PCI bridge to [bus 09]
[    9.190117] pci 0000:00:1d.0: PCI bridge to [bus 0a]
[    9.195083] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    9.201257] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    9.207438] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    9.214308] pci_bus 0000:00: resource 7 [mem 0xc0000000-0xefffffff window]
[    9.221174] pci_bus 0000:00: resource 8 [mem 0xfd000000-0xfe7fffff window]
[    9.228047] pci_bus 0000:01: resource 0 [io  0xe000-0xefff]
[    9.233620] pci_bus 0000:01: resource 1 [mem 0xefc00000-0xefdfffff]
[    9.239884] pci_bus 0000:01: resource 2 [mem 0xd0000000-0xe01fffff 64bit pref]
[    9.247105] pci_bus 0000:02: resource 0 [io  0xe000-0xefff]
[    9.252677] pci_bus 0000:02: resource 1 [mem 0xefc00000-0xefcfffff]
[    9.258942] pci_bus 0000:02: resource 2 [mem 0xd0000000-0xe01fffff 64bit pref]
[    9.266163] pci_bus 0000:03: resource 0 [io  0xe000-0xefff]
[    9.271735] pci_bus 0000:03: resource 1 [mem 0xefc00000-0xefcfffff]
[    9.278000] pci_bus 0000:03: resource 2 [mem 0xd0000000-0xe01fffff 64bit pref]
[    9.285211] pci_bus 0000:08: resource 1 [mem 0xefe00000-0xefefffff]
[    9.291684] initcall pcibios_assign_resources+0x0/0xbc returned 0 after 210680 usecs
[    9.299416] calling  sysctl_core_init+0x0/0x2b @ 1
[    9.304219] initcall sysctl_core_init+0x0/0x2b returned 0 after 10 usecs
[    9.310916] calling  eth_offload_init+0x0/0x14 @ 1
[    9.315701] initcall eth_offload_init+0x0/0x14 returned 0 after 0 usecs
[    9.322315] calling  inet_init+0x0/0x283 @ 1
[    9.326631] NET: Registered protocol family 2
[    9.331204] tcp_listen_portaddr_hash hash table entries: 512 (order: 1, 8192 bytes)
[    9.338859] TCP established hash table entries: 8192 (order: 4, 65536 bytes)
[    9.345916] TCP bind hash table entries: 8192 (order: 5, 131072 bytes)
[    9.352445] TCP: Hash tables configured (established 8192 bind 8192)
[    9.358844] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    9.364768] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    9.371210] initcall inet_init+0x0/0x283 returned 0 after 43577 usecs
[    9.377652] calling  ipv4_offload_init+0x0/0x7a @ 1
[    9.382530] initcall ipv4_offload_init+0x0/0x7a returned 0 after 0 usecs
[    9.389229] calling  af_unix_init+0x0/0x50 @ 1
[    9.393678] NET: Registered protocol family 1
[    9.398040] initcall af_unix_init+0x0/0x50 returned 0 after 4261 usecs
[    9.404562] calling  ipv6_offload_init+0x0/0x83 @ 1
[    9.409439] initcall ipv6_offload_init+0x0/0x83 returned 0 after 0 usecs
[    9.416139] calling  pci_apply_final_quirks+0x0/0xfe @ 1
[    9.422129] pci 0000:03:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    9.430478] devices_kset: Moving 0000:03:00.1 to end of list
[    9.436133] PM: Moving pci:0000:03:00.1 to end of list
[    9.441273] pci 0000:03:00.1: Linked as a consumer to 0000:03:00.0
[    9.447863] PCI: CLS 64 bytes, default 64
[    9.451874] initcall pci_apply_final_quirks+0x0/0xfe returned 0 after 29708 usecs
[    9.459355] calling  acpi_reserve_resources+0x0/0xeb @ 1
[    9.464712] initcall acpi_reserve_resources+0x0/0xeb returned 0 after 45 usecs
[    9.471928] calling  populate_rootfs+0x0/0x109 @ 1
[    9.476764] Trying to unpack rootfs image as initramfs...
[    9.914821] Freeing initrd memory: 41704K
[    9.918937] initcall populate_rootfs+0x0/0x109 returned 0 after 431849 usecs
[    9.925984] calling  pci_iommu_init+0x0/0x3c @ 1
[    9.930650] initcall pci_iommu_init+0x0/0x3c returned 0 after 47 usecs
[    9.937173] calling  calgary_fixup_tce_spaces+0x0/0xee @ 1
[    9.942657] initcall calgary_fixup_tce_spaces+0x0/0xee returned -19 after 0 usecs
[    9.950138] calling  ir_dev_scope_init+0x0/0x34 @ 1
[    9.955015] initcall ir_dev_scope_init+0x0/0x34 returned 0 after 0 usecs
[    9.961739] calling  ia32_binfmt_init+0x0/0x14 @ 1
[    9.966533] initcall ia32_binfmt_init+0x0/0x14 returned 0 after 7 usecs
[    9.973146] calling  amd_uncore_init+0x0/0x27b @ 1
[    9.977938] initcall amd_uncore_init+0x0/0x27b returned -19 after 0 usecs
[    9.984726] calling  amd_ibs_init+0x0/0x197 @ 1
[    9.989256] initcall amd_ibs_init+0x0/0x197 returned -19 after 0 usecs
[    9.995783] calling  amd_iommu_pc_init+0x0/0x237 @ 1
[   10.000750] initcall amd_iommu_pc_init+0x0/0x237 returned -19 after 0 usecs
[   10.007708] calling  msr_init+0x0/0xbd @ 1
[   10.011818] initcall msr_init+0x0/0xbd returned 0 after 8 usecs
[   10.017736] calling  rapl_pmu_init+0x0/0x234 @ 1
[   10.022402] RAPL PMU: API unit is 2^-32 Joules, 5 fixed counters, 655360 ms ovfl timer
[   10.030312] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[   10.036057] RAPL PMU: hw unit of domain package 2^-14 Joules
[   10.041716] RAPL PMU: hw unit of domain dram 2^-14 Joules
[   10.047116] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[   10.052775] RAPL PMU: hw unit of domain psys 2^-14 Joules
[   10.058175] initcall rapl_pmu_init+0x0/0x234 returned 0 after 34981 usecs
[   10.064961] calling  intel_uncore_init+0x0/0x247 @ 1
[   10.069966] devices_kset: Moving 0000:00:00.0 to end of list
[   10.075780] initcall intel_uncore_init+0x0/0x247 returned 0 after 5716 usecs
[   10.082841] calling  cstate_pmu_init+0x0/0x177 @ 1
[   10.087699] initcall cstate_pmu_init+0x0/0x177 returned 0 after 64 usecs
[   10.094396] calling  register_kernel_offset_dumper+0x0/0x1b @ 1
[   10.100313] initcall register_kernel_offset_dumper+0x0/0x1b returned 0 after 0 usecs
[   10.108051] calling  i8259A_init_ops+0x0/0x21 @ 1
[   10.112763] initcall i8259A_init_ops+0x0/0x21 returned 0 after 3 usecs
[   10.119285] calling  init_tsc_clocksource+0x0/0xc4 @ 1
[   10.124423] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x311fd3cd494, max_idle_ns: 440795223879 ns
[   10.134423] clocksource: Switched to clocksource tsc
[   10.139391] initcall init_tsc_clocksource+0x0/0xc4 returned 0 after 14617 usecs
[   10.146696] calling  add_rtc_cmos+0x0/0xa9 @ 1
[   10.151144] initcall add_rtc_cmos+0x0/0xa9 returned 0 after 1 usecs
[   10.157409] calling  i8237A_init_ops+0x0/0x14 @ 1
[   10.162115] initcall i8237A_init_ops+0x0/0x14 returned 0 after 0 usecs
[   10.168639] calling  thermal_throttle_init_device+0x0/0x42 @ 1
[   10.174558] initcall thermal_throttle_init_device+0x0/0x42 returned 0 after 82 usecs
[   10.182290] calling  ioapic_init_ops+0x0/0x14 @ 1
[   10.186996] initcall ioapic_init_ops+0x0/0x14 returned 0 after 0 usecs
[   10.193523] calling  add_pcspkr+0x0/0x40 @ 1
[   10.197803] device: 'pcspkr': device_add
[   10.201750] PM: Adding info for platform:pcspkr
[   10.206288] initcall add_pcspkr+0x0/0x40 returned 0 after 8295 usecs
[   10.212641] calling  start_periodic_check_for_corruption+0x0/0x60 @ 1
[   10.219079] Scanning for low memory corruption every 60 seconds
[   10.225001] initcall start_periodic_check_for_corruption+0x0/0x60 returned 0 after 5782 usecs
[   10.233520] calling  sysfb_init+0x0/0x70 @ 1
[   10.237807] device: 'vesa-framebuffer.0': device_add
[   10.242794] PM: Adding info for platform:vesa-framebuffer.0
[   10.248369] initcall sysfb_init+0x0/0x70 returned 0 after 10329 usecs
[   10.254804] calling  audit_classes_init+0x0/0xaf @ 1
[   10.259777] initcall audit_classes_init+0x0/0xaf returned 0 after 7 usecs
[   10.266556] calling  crc32c_intel_mod_init+0x0/0x54 @ 1
[   10.271823] initcall crc32c_intel_mod_init+0x0/0x54 returned 0 after 41 usecs
[   10.278949] calling  iosf_mbi_init+0x0/0x1a @ 1
[   10.283494] initcall iosf_mbi_init+0x0/0x1a returned 0 after 11 usecs
[   10.289930] calling  proc_execdomains_init+0x0/0x1f @ 1
[   10.295159] initcall proc_execdomains_init+0x0/0x1f returned 0 after 2 usecs
[   10.302202] calling  register_warn_debugfs+0x0/0x24 @ 1
[   10.307439] initcall register_warn_debugfs+0x0/0x24 returned 0 after 10 usecs
[   10.314569] calling  cpuhp_sysfs_init+0x0/0x62 @ 1
[   10.319390] initcall cpuhp_sysfs_init+0x0/0x62 returned 0 after 28 usecs
[   10.326088] calling  ioresources_init+0x0/0x36 @ 1
[   10.330882] initcall ioresources_init+0x0/0x36 returned 0 after 2 usecs
[   10.337494] calling  init_sched_debug_procfs+0x0/0x29 @ 1
[   10.342893] initcall init_sched_debug_procfs+0x0/0x29 returned 0 after 1 usecs
[   10.350110] calling  snapshot_device_init+0x0/0x11 @ 1
[   10.355254] device: 'snapshot': device_add
[   10.359363] PM: Adding info for No Bus:snapshot
[   10.363916] initcall snapshot_device_init+0x0/0x11 returned 0 after 8460 usecs
[   10.371140] calling  irq_gc_init_ops+0x0/0x14 @ 1
[   10.375843] initcall irq_gc_init_ops+0x0/0x14 returned 0 after 0 usecs
[   10.382368] calling  irq_pm_init_ops+0x0/0x14 @ 1
[   10.387073] initcall irq_pm_init_ops+0x0/0x14 returned 0 after 0 usecs
[   10.393601] calling  timekeeping_init_ops+0x0/0x14 @ 1
[   10.398739] initcall timekeeping_init_ops+0x0/0x14 returned 0 after 0 usecs
[   10.405699] calling  init_clocksource_sysfs+0x0/0x69 @ 1
[   10.411024] device: 'clocksource': device_add
[   10.415390] PM: Adding info for No Bus:clocksource
[   10.420184] device: 'clocksource0': device_add
[   10.424641] PM: Adding info for clocksource:clocksource0
[   10.429955] initcall init_clocksource_sysfs+0x0/0x69 returned 0 after 18499 usecs
[   10.437427] calling  init_timer_list_procfs+0x0/0x29 @ 1
[   10.442742] initcall init_timer_list_procfs+0x0/0x29 returned 0 after 1 usecs
[   10.449872] calling  alarmtimer_init+0x0/0x109 @ 1
[   10.454680] device: 'alarmtimer': device_add
[   10.458961] PM: Adding info for platform:alarmtimer
[   10.463845] devices_kset: Moving alarmtimer to end of list
[   10.469332] initcall alarmtimer_init+0x0/0x109 returned 0 after 14322 usecs
[   10.476290] calling  init_posix_timers+0x0/0x2a @ 1
[   10.481183] initcall init_posix_timers+0x0/0x2a returned 0 after 12 usecs
[   10.487964] calling  clockevents_init_sysfs+0x0/0xc0 @ 1
[   10.493290] device: 'clockevents': device_add
[   10.497654] PM: Adding info for No Bus:clockevents
[   10.502448] device: 'clockevent0': device_add
[   10.506815] PM: Adding info for clockevents:clockevent0
[   10.512045] device: 'clockevent1': device_add
[   10.516410] PM: Adding info for clockevents:clockevent1
[   10.521639] device: 'clockevent2': device_add
[   10.526005] PM: Adding info for clockevents:clockevent2
[   10.531231] device: 'clockevent3': device_add
[   10.535598] PM: Adding info for clockevents:clockevent3
[   10.540826] device: 'clockevent4': device_add
[   10.545193] PM: Adding info for clockevents:clockevent4
[   10.550418] device: 'clockevent5': device_add
[   10.554786] PM: Adding info for clockevents:clockevent5
[   10.560015] device: 'clockevent6': device_add
[   10.564381] PM: Adding info for clockevents:clockevent6
[   10.569608] device: 'clockevent7': device_add
[   10.573975] PM: Adding info for clockevents:clockevent7
[   10.579202] device: 'broadcast': device_add
[   10.583392] PM: Adding info for clockevents:broadcast
[   10.588448] initcall clockevents_init_sysfs+0x0/0xc0 returned 0 after 92940 usecs
[   10.595924] calling  proc_dma_init+0x0/0x1f @ 1
[   10.600459] initcall proc_dma_init+0x0/0x1f returned 0 after 1 usecs
[   10.606809] calling  proc_modules_init+0x0/0x1f @ 1
[   10.611688] initcall proc_modules_init+0x0/0x1f returned 0 after 0 usecs
[   10.618388] calling  kallsyms_init+0x0/0x22 @ 1
[   10.622921] initcall kallsyms_init+0x0/0x22 returned 0 after 0 usecs
[   10.629274] calling  pid_namespaces_init+0x0/0x40 @ 1
[   10.634341] initcall pid_namespaces_init+0x0/0x40 returned 0 after 14 usecs
[   10.641295] calling  audit_watch_init+0x0/0x3a @ 1
[   10.646086] initcall audit_watch_init+0x0/0x3a returned 0 after 1 usecs
[   10.652699] calling  audit_fsnotify_init+0x0/0x3a @ 1
[   10.657753] initcall audit_fsnotify_init+0x0/0x3a returned 0 after 0 usecs
[   10.664625] calling  audit_tree_init+0x0/0x49 @ 1
[   10.669331] initcall audit_tree_init+0x0/0x49 returned 0 after 0 usecs
[   10.675855] calling  init_kprobes+0x0/0x1d6 @ 1
[   10.680584] initcall init_kprobes+0x0/0x1d6 returned 0 after 189 usecs
[   10.687105] calling  seccomp_sysctl_init+0x0/0x36 @ 1
[   10.692163] initcall seccomp_sysctl_init+0x0/0x36 returned 0 after 4 usecs
[   10.699030] calling  utsname_sysctl_init+0x0/0x14 @ 1
[   10.704080] initcall utsname_sysctl_init+0x0/0x14 returned 0 after 4 usecs
[   10.710949] calling  init_tracepoints+0x0/0x2a @ 1
[   10.715740] initcall init_tracepoints+0x0/0x2a returned 0 after 0 usecs
[   10.722354] calling  init_lstats_procfs+0x0/0x22 @ 1
[   10.727320] initcall init_lstats_procfs+0x0/0x22 returned 0 after 1 usecs
[   10.734106] calling  stack_trace_init+0x0/0xb0 @ 1
[   10.738908] initcall stack_trace_init+0x0/0xb0 returned 0 after 8 usecs
[   10.745518] calling  init_mmio_trace+0x0/0xc @ 1
[   10.750143] initcall init_mmio_trace+0x0/0xc returned 0 after 4 usecs
[   10.756578] calling  init_blk_tracer+0x0/0x52 @ 1
[   10.761292] initcall init_blk_tracer+0x0/0x52 returned 0 after 7 usecs
[   10.767820] calling  perf_event_sysfs_init+0x0/0x7f @ 1
[   10.773056] device: 'cstate_pkg': device_add
[   10.777350] PM: Adding info for event_source:cstate_pkg
[   10.782574] device: 'cstate_core': device_add
[   10.786950] PM: Adding info for event_source:cstate_core
[   10.792262] device: 'uncore_arb': device_add
[   10.796551] PM: Adding info for event_source:uncore_arb
[   10.801779] device: 'uncore_cbox_3': device_add
[   10.806332] PM: Adding info for event_source:uncore_cbox_3
[   10.811824] device: 'uncore_cbox_2': device_add
[   10.816376] PM: Adding info for event_source:uncore_cbox_2
[   10.821860] device: 'uncore_cbox_1': device_add
[   10.826413] PM: Adding info for event_source:uncore_cbox_1
[   10.831905] device: 'uncore_cbox_0': device_add
[   10.836455] PM: Adding info for event_source:uncore_cbox_0
[   10.841939] device: 'uncore_imc': device_add
[   10.846233] PM: Adding info for event_source:uncore_imc
[   10.851466] device: 'power': device_add
[   10.855331] PM: Adding info for event_source:power
[   10.860121] device: 'msr': device_add
[   10.863806] PM: Adding info for event_source:msr
[   10.868425] device: 'intel_pt': device_add
[   10.872560] PM: Adding info for event_source:intel_pt
[   10.877611] device: 'cpu': device_add
[   10.881330] PM: Adding info for event_source:cpu
[   10.885948] device: 'breakpoint': device_add
[   10.890233] PM: Adding info for event_source:breakpoint
[   10.895456] device: 'tracepoint': device_add
[   10.899738] PM: Adding info for event_source:tracepoint
[   10.904963] device: 'software': device_add
[   10.909072] PM: Adding info for event_source:software
[   10.914122] initcall perf_event_sysfs_init+0x0/0x7f returned 0 after 137770 usecs
[   10.921599] calling  init_uprobes+0x0/0x62 @ 1
[   10.926054] initcall init_uprobes+0x0/0x62 returned 0 after 6 usecs
[   10.932320] calling  padata_driver_init+0x0/0x39 @ 1
[   10.937286] initcall padata_driver_init+0x0/0x39 returned 0 after 0 usecs
[   10.944074] calling  system_trusted_keyring_init+0x0/0x78 @ 1
[   10.949817] Initialise system trusted keyrings
[   10.954269] initcall system_trusted_keyring_init+0x0/0x78 returned 0 after 4346 usecs
[   10.962092] calling  kswapd_init+0x0/0x84 @ 1
[   10.966471] initcall kswapd_init+0x0/0x84 returned 0 after 19 usecs
[   10.972735] calling  extfrag_debug_init+0x0/0x7a @ 1
[   10.977705] initcall extfrag_debug_init+0x0/0x7a returned 0 after 6 usecs
[   10.984485] calling  mm_compute_batch_init+0x0/0x19 @ 1
[   10.989713] initcall mm_compute_batch_init+0x0/0x19 returned 0 after 0 usecs
[   10.996757] calling  slab_proc_init+0x0/0x22 @ 1
[   11.001377] initcall slab_proc_init+0x0/0x22 returned 0 after 1 usecs
[   11.007816] calling  workingset_init+0x0/0x86 @ 1
[   11.012522] workingset: timestamp_bits=40 max_order=18 bucket_order=0
[   11.018964] initcall workingset_init+0x0/0x86 returned 0 after 6290 usecs
[   11.025747] calling  proc_vmalloc_init+0x0/0x22 @ 1
[   11.030628] initcall proc_vmalloc_init+0x0/0x22 returned 0 after 1 usecs
[   11.037327] calling  procswaps_init+0x0/0x1f @ 1
[   11.041946] initcall procswaps_init+0x0/0x1f returned 0 after 1 usecs
[   11.048384] calling  init_frontswap+0x0/0x93 @ 1
[   11.053013] initcall init_frontswap+0x0/0x93 returned 0 after 9 usecs
[   11.059452] calling  slab_sysfs_init+0x0/0xf6 @ 1
[   11.066863] initcall slab_sysfs_init+0x0/0xf6 returned 0 after 2639 usecs
[   11.073648] calling  init_cleancache+0x0/0x93 @ 1
[   11.078364] initcall init_cleancache+0x0/0x93 returned 0 after 10 usecs
[   11.084978] calling  zs_init+0x0/0x6b @ 1
[   11.089026] initcall zs_init+0x0/0x6b returned 0 after 38 usecs
[   11.094942] calling  fcntl_init+0x0/0x2a @ 1
[   11.099219] initcall fcntl_init+0x0/0x2a returned 0 after 2 usecs
[   11.105308] calling  proc_filesystems_init+0x0/0x1f @ 1
[   11.110533] initcall proc_filesystems_init+0x0/0x1f returned 0 after 1 usecs
[   11.117578] calling  start_dirtytime_writeback+0x0/0x2a @ 1
[   11.123153] initcall start_dirtytime_writeback+0x0/0x2a returned 0 after 0 usecs
[   11.130545] calling  blkdev_init+0x0/0x2a @ 1
[   11.134916] initcall blkdev_init+0x0/0x2a returned 0 after 11 usecs
[   11.141179] calling  dio_init+0x0/0x2d @ 1
[   11.145326] initcall dio_init+0x0/0x2d returned 0 after 47 usecs
[   11.151327] calling  dnotify_init+0x0/0x7b @ 1
[   11.155820] initcall dnotify_init+0x0/0x7b returned 0 after 45 usecs
[   11.162169] calling  fanotify_user_setup+0x0/0x77 @ 1
[   11.167226] initcall fanotify_user_setup+0x0/0x77 returned 0 after 4 usecs
[   11.174095] calling  aio_setup+0x0/0xa5 @ 1
[   11.178314] initcall aio_setup+0x0/0xa5 returned 0 after 33 usecs
[   11.184408] calling  init_sys32_ioctl+0x0/0x28 @ 1
[   11.189237] initcall init_sys32_ioctl+0x0/0x28 returned 0 after 36 usecs
[   11.195936] calling  mbcache_init+0x0/0x31 @ 1
[   11.200427] initcall mbcache_init+0x0/0x31 returned 0 after 45 usecs
[   11.206778] calling  init_devpts_fs+0x0/0x28 @ 1
[   11.211402] initcall init_devpts_fs+0x0/0x28 returned 0 after 6 usecs
[   11.217834] calling  ext4_init_fs+0x0/0x195 @ 1
[   11.222559] initcall ext4_init_fs+0x0/0x195 returned 0 after 186 usecs
[   11.229084] calling  journal_init+0x0/0x104 @ 1
[   11.233793] initcall journal_init+0x0/0x104 returned 0 after 172 usecs
[   11.240318] calling  init_fat_fs+0x0/0x4a @ 1
[   11.244757] initcall init_fat_fs+0x0/0x4a returned 0 after 78 usecs
[   11.251020] calling  init_vfat_fs+0x0/0x11 @ 1
[   11.255465] initcall init_vfat_fs+0x0/0x11 returned 0 after 0 usecs
[   11.261732] calling  ecryptfs_init+0x0/0x1b6 @ 1
[   11.266561] device: 'ecryptfs': device_add
[   11.270698] PM: Adding info for No Bus:ecryptfs
[   11.275245] initcall ecryptfs_init+0x0/0x1b6 returned 0 after 8684 usecs
[   11.281942] calling  init_nls_cp437+0x0/0x13 @ 1
[   11.286563] initcall init_nls_cp437+0x0/0x13 returned 0 after 0 usecs
[   11.293000] calling  fuse_init+0x0/0x1a3 @ 1
[   11.297274] fuse init (API version 7.26)
[   11.301293] device: 'fuse': device_add
[   11.305052] PM: Adding info for No Bus:fuse
[   11.309251] initcall fuse_init+0x0/0x1a3 returned 0 after 11696 usecs
[   11.315693] calling  init_pstore_fs+0x0/0x4a @ 1
[   11.320312] initcall init_pstore_fs+0x0/0x4a returned 0 after 1 usecs
[   11.326749] calling  efivarfs_init+0x0/0x2c @ 1
[   11.331281] initcall efivarfs_init+0x0/0x2c returned -19 after 0 usecs
[   11.337808] calling  ipc_init+0x0/0x50 @ 1
[   11.341916] initcall ipc_init+0x0/0x50 returned 0 after 9 usecs
[   11.347835] calling  ipc_sysctl_init+0x0/0x14 @ 1
[   11.352548] initcall ipc_sysctl_init+0x0/0x14 returned 0 after 5 usecs
[   11.359068] calling  init_mqueue_fs+0x0/0xa1 @ 1
[   11.363772] initcall init_mqueue_fs+0x0/0xa1 returned 0 after 84 usecs
[   11.370291] calling  key_proc_init+0x0/0x58 @ 1
[   11.374826] initcall key_proc_init+0x0/0x58 returned 0 after 2 usecs
[   11.381175] calling  selinux_nf_ip_init+0x0/0x3f @ 1
[   11.386141] initcall selinux_nf_ip_init+0x0/0x3f returned 0 after 0 usecs
[   11.392927] calling  init_sel_fs+0x0/0x9a @ 1
[   11.397289] initcall init_sel_fs+0x0/0x9a returned 0 after 0 usecs
[   11.403467] calling  selnl_init+0x0/0x59 @ 1
[   11.407748] initcall selnl_init+0x0/0x59 returned 0 after 9 usecs
[   11.413841] calling  sel_netif_init+0x0/0x37 @ 1
[   11.418459] initcall sel_netif_init+0x0/0x37 returned 0 after 0 usecs
[   11.424900] calling  sel_netnode_init+0x0/0x32 @ 1
[   11.429691] initcall sel_netnode_init+0x0/0x32 returned 0 after 0 usecs
[   11.436304] calling  sel_netport_init+0x0/0x32 @ 1
[   11.441098] initcall sel_netport_init+0x0/0x32 returned 0 after 0 usecs
[   11.447711] calling  aurule_init+0x0/0x2d @ 1
[   11.452071] initcall aurule_init+0x0/0x2d returned 0 after 1 usecs
[   11.458247] calling  init_smk_fs+0x0/0x110 @ 1
[   11.462694] initcall init_smk_fs+0x0/0x110 returned 0 after 0 usecs
[   11.468962] calling  crypto_algapi_init+0x0/0xd @ 1
[   11.473840] initcall crypto_algapi_init+0x0/0xd returned 0 after 1 usecs
[   11.480540] calling  seqiv_module_init+0x0/0x11 @ 1
[   11.485420] initcall seqiv_module_init+0x0/0x11 returned 0 after 0 usecs
[   11.492119] calling  rsa_init+0x0/0x40 @ 1
[   11.496242] initcall rsa_init+0x0/0x40 returned 0 after 23 usecs
[   11.502241] calling  hmac_module_init+0x0/0x11 @ 1
[   11.507033] initcall hmac_module_init+0x0/0x11 returned 0 after 0 usecs
[   11.513646] calling  crypto_null_mod_init+0x0/0x44 @ 1
[   11.518866] initcall crypto_null_mod_init+0x0/0x44 returned 0 after 79 usecs
[   11.525912] calling  md5_mod_init+0x0/0x11 @ 1
[   11.530374] initcall md5_mod_init+0x0/0x11 returned 0 after 16 usecs
[   11.536726] calling  sha1_generic_mod_init+0x0/0x11 @ 1
[   11.541973] initcall sha1_generic_mod_init+0x0/0x11 returned 0 after 21 usecs
[   11.549101] calling  sha256_generic_mod_init+0x0/0x16 @ 1
[   11.554544] initcall sha256_generic_mod_init+0x0/0x16 returned 0 after 40 usecs
[   11.561851] calling  sha512_generic_mod_init+0x0/0x16 @ 1
[   11.567291] initcall sha512_generic_mod_init+0x0/0x16 returned 0 after 40 usecs
[   11.574599] calling  crypto_ecb_module_init+0x0/0x11 @ 1
[   11.579913] initcall crypto_ecb_module_init+0x0/0x11 returned 0 after 0 usecs
[   11.587045] calling  crypto_cbc_module_init+0x0/0x11 @ 1
[   11.592356] initcall crypto_cbc_module_init+0x0/0x11 returned 0 after 0 usecs
[   11.599490] calling  crypto_ctr_module_init+0x0/0x3c @ 1
[   11.604803] initcall crypto_ctr_module_init+0x0/0x3c returned 0 after 0 usecs
[   11.611934] calling  crypto_gcm_module_init+0x0/0xc2 @ 1
[   11.617250] initcall crypto_gcm_module_init+0x0/0xc2 returned 0 after 1 usecs
[   11.624381] calling  aes_init+0x0/0x11 @ 1
[   11.628501] initcall aes_init+0x0/0x11 returned 0 after 19 usecs
[   11.634503] calling  crc32c_mod_init+0x0/0x11 @ 1
[   11.639229] initcall crc32c_mod_init+0x0/0x11 returned 0 after 19 usecs
[   11.645839] calling  crct10dif_mod_init+0x0/0x11 @ 1
[   11.650825] initcall crct10dif_mod_init+0x0/0x11 returned 0 after 19 usecs
[   11.657696] calling  lzo_mod_init+0x0/0x38 @ 1
[   11.662183] initcall lzo_mod_init+0x0/0x38 returned 0 after 41 usecs
[   11.668538] calling  drbg_init+0x0/0x7a @ 1
[   11.672889] initcall drbg_init+0x0/0x7a returned 0 after 161 usecs
[   11.679067] calling  jent_mod_init+0x0/0x30 @ 1
[   11.683708] initcall jent_mod_init+0x0/0x30 returned 0 after 104 usecs
[   11.690230] calling  ghash_mod_init+0x0/0x11 @ 1
[   11.694870] initcall ghash_mod_init+0x0/0x11 returned 0 after 19 usecs
[   11.701393] calling  asymmetric_key_init+0x0/0x11 @ 1
[   11.706445] Key type asymmetric registered
[   11.710545] initcall asymmetric_key_init+0x0/0x11 returned 0 after 4003 usecs
[   11.717678] calling  x509_key_init+0x0/0x11 @ 1
[   11.722207] Asymmetric key parser 'x509' registered
[   11.727079] initcall x509_key_init+0x0/0x11 returned 0 after 4756 usecs
[   11.733682] calling  proc_genhd_init+0x0/0x36 @ 1
[   11.738382] initcall proc_genhd_init+0x0/0x36 returned 0 after 2 usecs
[   11.744906] calling  bsg_init+0x0/0x12c @ 1
[   11.749148] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 247)
[   11.756538] initcall bsg_init+0x0/0x12c returned 0 after 7271 usecs
[   11.762803] calling  throtl_init+0x0/0x43 @ 1
[   11.767196] initcall throtl_init+0x0/0x43 returned 0 after 33 usecs
[   11.773457] calling  noop_init+0x0/0x11 @ 1
[   11.777641] io scheduler noop registered
[   11.781568] initcall noop_init+0x0/0x11 returned 0 after 3834 usecs
[   11.787833] calling  deadline_init+0x0/0x11 @ 1
[   11.792365] io scheduler deadline registered (default)
[   11.797506] initcall deadline_init+0x0/0x11 returned 0 after 5019 usecs
[   11.804119] calling  cfq_init+0x0/0x78 @ 1
[   11.808329] io scheduler cfq registered
[   11.812172] initcall cfq_init+0x0/0x78 returned 0 after 3862 usecs
[   11.818347] calling  deadline_init+0x0/0x11 @ 1
[   11.822880] io scheduler mq-deadline registered (default)
[   11.828270] initcall deadline_init+0x0/0x11 returned 0 after 5264 usecs
[   11.834875] calling  kyber_init+0x0/0x11 @ 1
[   11.839147] io scheduler kyber registered
[   11.843160] initcall kyber_init+0x0/0x11 returned 0 after 3918 usecs
[   11.849504] calling  btree_module_init+0x0/0x25 @ 1
[   11.854385] initcall btree_module_init+0x0/0x25 returned 0 after 7 usecs
[   11.861083] calling  crc_t10dif_mod_init+0x0/0x39 @ 1
[   11.866139] initcall crc_t10dif_mod_init+0x0/0x39 returned 0 after 2 usecs
[   11.873010] calling  percpu_counter_startup+0x0/0x51 @ 1
[   11.878344] initcall percpu_counter_startup+0x0/0x51 returned 0 after 21 usecs
[   11.885560] calling  digsig_init+0x0/0x38 @ 1
[   11.889920] initcall digsig_init+0x0/0x38 returned 0 after 1 usecs
[   11.896096] calling  sg_pool_init+0x0/0xc4 @ 1
[   11.900568] initcall sg_pool_init+0x0/0xc4 returned 0 after 23 usecs
[   11.906920] calling  phy_core_init+0x0/0x4c @ 1
[   11.911452] initcall phy_core_init+0x0/0x4c returned 0 after 7 usecs
[   11.917798] calling  pci_proc_init+0x0/0x62 @ 1
[   11.922359] initcall pci_proc_init+0x0/0x62 returned 0 after 28 usecs
[   11.928797] calling  pcie_portdrv_init+0x0/0x75 @ 1
[   11.933698] devices_kset: Moving 0000:00:01.0 to end of list
[   11.939678] device: '0000:00:01.0:pcie008': device_add
[   11.944827] PM: Adding info for pci_express:0000:00:01.0:pcie008
[   11.950855] devices_kset: Moving 0000:00:1b.0 to end of list
[   11.956767] devices_kset: Moving 0000:00:1b.2 to end of list
[   11.962459] devices_kset: Moving 0000:00:1b.3 to end of list
[   11.968398] devices_kset: Moving 0000:00:1c.0 to end of list
[   11.974086] devices_kset: Moving 0000:00:1c.4 to end of list
[   11.980026] devices_kset: Moving 0000:00:1d.0 to end of list
[   11.985945] devices_kset: Moving 0000:01:00.0 to end of list
[   11.991703] devices_kset: Moving 0000:02:00.0 to end of list
[   11.997451] devices_kset: Moving 0000:05:00.0 to end of list
[   12.003116] initcall pcie_portdrv_init+0x0/0x75 returned 0 after 67812 usecs
[   12.010160] calling  aer_service_init+0x0/0x3c @ 1
[   12.014959] initcall aer_service_init+0x0/0x3c returned 0 after 7 usecs
[   12.021564] calling  pcie_pme_service_init+0x0/0x11 @ 1
[   12.026797] initcall pcie_pme_service_init+0x0/0x11 returned 0 after 7 usecs
[   12.033836] calling  pci_hotplug_init+0x0/0x33 @ 1
[   12.038630] initcall pci_hotplug_init+0x0/0x33 returned 0 after 0 usecs
[   12.045242] calling  pcied_init+0x0/0x5a @ 1
[   12.049522] initcall pcied_init+0x0/0x5a returned 0 after 6 usecs
[   12.055607] calling  imsttfb_init+0x0/0xf7 @ 1
[   12.060085] initcall imsttfb_init+0x0/0xf7 returned 0 after 29 usecs
[   12.066432] calling  asiliantfb_init+0x0/0x32 @ 1
[   12.071156] initcall asiliantfb_init+0x0/0x32 returned 0 after 14 usecs
[   12.077770] calling  vesafb_driver_init+0x0/0x13 @ 1
[   12.082766] devices_kset: Moving vesa-framebuffer.0 to end of list
[   12.088955] vesafb: mode is 1920x1080x32, linelength=7680, pages=0
[   12.095127] vesafb: scrolling: redraw
[   12.098793] vesafb: Truecolor: size=0:8:8:8, shift=0:16:8:0
[   12.104374] vesafb: framebuffer at 0xd0000000, mapped to 0x00000000960f29a4, using 8128k, total 8128k
[   12.113597] device: 'fb0': device_add
[   12.117283] PM: Adding info for No Bus:fb0
[   12.121423] device: 'vtcon1': device_add
[   12.121443] PM: Adding info for No Bus:vtcon1
[   12.240266] Console: switching to colour frame buffer device 240x67
[   12.373162] fb0: VESA VGA frame buffer device
[   12.377531] initcall vesafb_driver_init+0x0/0x13 returned 0 after 287888 usecs
[   12.384750] calling  efifb_driver_init+0x0/0x13 @ 1
[   12.389638] initcall efifb_driver_init+0x0/0x13 returned 0 after 9 usecs
[   12.396339] calling  intel_idle_init+0x0/0x5af @ 1
[   12.401129] intel_idle: MWAIT substates: 0x142120
[   12.405836] intel_idle: v0.4.1 model 0x5E
[   12.410484] intel_idle: lapic_timer_reliable_states 0xffffffff
[   12.416314] initcall intel_idle_init+0x0/0x5af returned 0 after 14828 usecs
[   12.423274] calling  ipmi_init_msghandler_mod+0x0/0xd @ 1
[   12.428683] ipmi message handler version 39.2
[   12.433042] initcall ipmi_init_msghandler_mod+0x0/0xd returned 0 after 4265 usecs
[   12.440521] calling  acpi_ac_init+0x0/0x7c @ 1
[   12.445016] initcall acpi_ac_init+0x0/0x7c returned 0 after 47 usecs
[   12.451362] calling  acpi_button_driver_init+0x0/0x11 @ 1
[   12.456780] devices_kset: Moving PNP0C0E:00 to end of list
[   12.462271] device: 'input0': device_add
[   12.466227] PM: Adding info for No Bus:input0
[   12.470593] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input0
[   12.478955] ACPI: Sleep Button [SLPB]
[   12.482634] devices_kset: Moving PNP0C0C:00 to end of list
[   12.488120] device: 'input1': device_add
[   12.492078] PM: Adding info for No Bus:input1
[   12.496442] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
[   12.504795] ACPI: Power Button [PWRB]
[   12.508469] devices_kset: Moving LNXPWRBN:00 to end of list
[   12.514042] device: 'input2': device_add
[   12.518001] PM: Adding info for No Bus:input2
[   12.522364] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[   12.529766] ACPI: Power Button [PWRF]
[   12.533441] initcall acpi_button_driver_init+0x0/0x11 returned 0 after 74882 usecs
[   12.541001] calling  acpi_fan_driver_init+0x0/0x13 @ 1
[   12.546151] devices_kset: Moving PNP0C0B:00 to end of list
[   12.560440] device: 'cooling_device0': device_add
[   12.565171] PM: Adding info for No Bus:cooling_device0
[   12.570327] devices_kset: Moving PNP0C0B:01 to end of list
[   12.584429] device: 'cooling_device1': device_add
[   12.589182] PM: Adding info for No Bus:cooling_device1
[   12.594343] devices_kset: Moving PNP0C0B:02 to end of list
[   12.612430] device: 'cooling_device2': device_add
[   12.617149] PM: Adding info for No Bus:cooling_device2
[   12.622310] devices_kset: Moving PNP0C0B:03 to end of list
[   12.636426] device: 'cooling_device3': device_add
[   12.641149] PM: Adding info for No Bus:cooling_device3
[   12.646299] devices_kset: Moving PNP0C0B:04 to end of list
[   12.660424] device: 'cooling_device4': device_add
[   12.665157] PM: Adding info for No Bus:cooling_device4
[   12.670304] initcall acpi_fan_driver_init+0x0/0x13 returned 0 after 121252 usecs
[   12.677693] calling  acpi_processor_driver_init+0x0/0x97 @ 1
[   12.683360] devices_kset: Moving cpu0 to end of list
[   12.688335] device: 'cooling_device5': device_add
[   12.693057] PM: Adding info for No Bus:cooling_device5
[   12.698219] devices_kset: Moving cpu1 to end of list
[   12.703186] device: 'cooling_device6': device_add
[   12.707904] PM: Adding info for No Bus:cooling_device6
[   12.713064] devices_kset: Moving cpu2 to end of list
[   12.718032] device: 'cooling_device7': device_add
[   12.722750] PM: Adding info for No Bus:cooling_device7
[   12.727910] devices_kset: Moving cpu3 to end of list
[   12.732880] device: 'cooling_device8': device_add
[   12.732899] PM: Adding info for No Bus:cooling_device8
[   12.742747] devices_kset: Moving cpu4 to end of list
[   12.747716] device: 'cooling_device9': device_add
[   12.752433] PM: Adding info for No Bus:cooling_device9
[   12.757593] devices_kset: Moving cpu5 to end of list
[   12.762561] device: 'cooling_device10': device_add
[   12.767366] PM: Adding info for No Bus:cooling_device10
[   12.772612] devices_kset: Moving cpu6 to end of list
[   12.777581] device: 'cooling_device11': device_add
[   12.782407] PM: Adding info for No Bus:cooling_device11
[   12.787651] devices_kset: Moving cpu7 to end of list
[   12.792618] device: 'cooling_device12': device_add
[   12.797423] PM: Adding info for No Bus:cooling_device12
[   12.802670] initcall acpi_processor_driver_init+0x0/0x97 returned 0 after 116521 usecs
[   12.810579] calling  acpi_thermal_init+0x0/0x82 @ 1
[   12.815515] devices_kset: Moving LNXTHERM:00 to end of list
[   12.821967] device: 'thermal_zone0': device_add
[   12.826553] PM: Adding info for No Bus:thermal_zone0
[   12.831526] device: 'hwmon0': device_add
[   12.835469] PM: Adding info for No Bus:hwmon0
[   12.900603] thermal LNXTHERM:00: registered as thermal_zone0
[   12.906259] ACPI: Thermal Zone [TZ00] (28 C)
[   12.910545] devices_kset: Moving LNXTHERM:01 to end of list
[   12.916467] device: 'thermal_zone1': device_add
[   12.921037] PM: Adding info for No Bus:thermal_zone1
[   12.926098] thermal LNXTHERM:01: registered as thermal_zone1
[   12.931756] ACPI: Thermal Zone [TZ01] (30 C)
[   12.936041] initcall acpi_thermal_init+0x0/0x82 returned 0 after 117756 usecs
[   12.943170] calling  acpi_battery_init+0x0/0x2c @ 1
[   12.948049] initcall acpi_battery_init+0x0/0x2c returned 0 after 2 usecs
[   12.954748] calling  acpi_hed_driver_init+0x0/0x11 @ 1
[   12.959905] initcall acpi_hed_driver_init+0x0/0x11 returned 0 after 17 usecs
[   12.966952] calling  bgrt_init+0x0/0xbc @ 1
[   12.971136] initcall bgrt_init+0x0/0xbc returned -19 after 0 usecs
[   12.977317] calling  erst_init+0x0/0x2de @ 1
[   12.981589] initcall erst_init+0x0/0x2de returned 0 after 0 usecs
[   12.987680] calling  ghes_init+0x0/0x159 @ 1
[   12.991947] initcall ghes_init+0x0/0x159 returned -19 after 0 usecs
[   12.998210] calling  gpio_clk_driver_init+0x0/0x13 @ 1
[   13.003359] initcall gpio_clk_driver_init+0x0/0x13 returned 0 after 7 usecs
[   13.010320] calling  plt_clk_driver_init+0x0/0x13 @ 1
[   13.015379] initcall plt_clk_driver_init+0x0/0x13 returned 0 after 7 usecs
[   13.022256] calling  dw_pci_driver_init+0x0/0x1a @ 1
[   13.027252] initcall dw_pci_driver_init+0x0/0x1a returned 0 after 32 usecs
[   13.034131] calling  virtio_mmio_init+0x0/0x13 @ 1
[   13.038942] initcall virtio_mmio_init+0x0/0x13 returned 0 after 21 usecs
[   13.045639] calling  virtio_pci_driver_init+0x0/0x1a @ 1
[   13.050968] initcall virtio_pci_driver_init+0x0/0x1a returned 0 after 18 usecs
[   13.058185] calling  virtio_balloon_driver_init+0x0/0x11 @ 1
[   13.063850] initcall virtio_balloon_driver_init+0x0/0x11 returned 0 after 7 usecs
[   13.071323] calling  xenbus_probe_initcall+0x0/0x50 @ 1
[   13.076548] initcall xenbus_probe_initcall+0x0/0x50 returned -19 after 0 usecs
[   13.083767] calling  xenbus_init+0x0/0x3b @ 1
[   13.088118] initcall xenbus_init+0x0/0x3b returned -19 after 0 usecs
[   13.094462] calling  xenbus_backend_init+0x0/0x4d @ 1
[   13.099507] initcall xenbus_backend_init+0x0/0x4d returned -19 after 0 usecs
[   13.106554] calling  hypervisor_subsys_init+0x0/0x26 @ 1
[   13.111867] initcall hypervisor_subsys_init+0x0/0x26 returned -19 after 0 usecs
[   13.119172] calling  hyper_sysfs_init+0x0/0x188 @ 1
[   13.124050] initcall hyper_sysfs_init+0x0/0x188 returned -19 after 0 usecs
[   13.130925] calling  platform_driver_init+0x0/0x1a @ 1
[   13.136073] initcall platform_driver_init+0x0/0x1a returned 0 after 8 usecs
[   13.143032] calling  xen_late_init_mcelog+0x0/0x69 @ 1
[   13.148171] initcall xen_late_init_mcelog+0x0/0x69 returned -19 after 0 usecs
[   13.155304] calling  xen_acpi_processor_init+0x0/0x1ed @ 1
[   13.160787] initcall xen_acpi_processor_init+0x0/0x1ed returned -19 after 0 usecs
[   13.168259] calling  lp872x_driver_init+0x0/0x13 @ 1
[   13.173234] initcall lp872x_driver_init+0x0/0x13 returned 0 after 9 usecs
[   13.180022] calling  n_null_init+0x0/0x1f @ 1
[   13.184379] initcall n_null_init+0x0/0x1f returned 0 after 0 usecs
[   13.190558] calling  pty_init+0x0/0x38e @ 1
[   13.194747] device: 'ptmx': device_add
[   13.198512] PM: Adding info for No Bus:ptmx
[   13.202708] initcall pty_init+0x0/0x38e returned 0 after 7785 usecs
[   13.208967] calling  sysrq_init+0x0/0x75 @ 1
[   13.213240] initcall sysrq_init+0x0/0x75 returned 0 after 1 usecs
[   13.219333] calling  xen_hvc_init+0x0/0x24f @ 1
[   13.223864] initcall xen_hvc_init+0x0/0x24f returned -19 after 0 usecs
[   13.230382] calling  serial8250_init+0x0/0x14e @ 1
[   13.235175] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[   13.241550] devices_kset: Moving 00:02 to end of list
[   13.267102] 00:02: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[   13.274406] device: 'ttyS0': device_add
[   13.278274] PM: Adding info for No Bus:ttyS0
[   13.282593] device: 'serial8250': device_add
[   13.286879] PM: Adding info for platform:serial8250
[   13.291773] device: 'ttyS1': device_add
[   13.295638] PM: Adding info for No Bus:ttyS1
[   13.299944] device: 'ttyS2': device_add
[   13.303808] PM: Adding info for No Bus:ttyS2
[   13.308114] device: 'ttyS3': device_add
[   13.311980] PM: Adding info for No Bus:ttyS3
[   13.316274] device: 'ttyS4': device_add
[   13.320133] PM: Adding info for No Bus:ttyS4
[   13.324432] device: 'ttyS5': device_add
[   13.328297] PM: Adding info for No Bus:ttyS5
[   13.332593] device: 'ttyS6': device_add
[   13.336453] PM: Adding info for No Bus:ttyS6
[   13.340750] device: 'ttyS7': device_add
[   13.344610] PM: Adding info for No Bus:ttyS7
[   13.348905] device: 'ttyS8': device_add
[   13.352766] PM: Adding info for No Bus:ttyS8
[   13.357062] device: 'ttyS9': device_add
[   13.360920] PM: Adding info for No Bus:ttyS9
[   13.365216] device: 'ttyS10': device_add
[   13.369161] PM: Adding info for No Bus:ttyS10
[   13.373545] device: 'ttyS11': device_add
[   13.377492] PM: Adding info for No Bus:ttyS11
[   13.381873] device: 'ttyS12': device_add
[   13.385819] PM: Adding info for No Bus:ttyS12
[   13.390202] device: 'ttyS13': device_add
[   13.394147] PM: Adding info for No Bus:ttyS13
[   13.398530] device: 'ttyS14': device_add
[   13.402477] PM: Adding info for No Bus:ttyS14
[   13.406860] device: 'ttyS15': device_add
[   13.410805] PM: Adding info for No Bus:ttyS15
[   13.415188] device: 'ttyS16': device_add
[   13.419133] PM: Adding info for No Bus:ttyS16
[   13.423516] device: 'ttyS17': device_add
[   13.427462] PM: Adding info for No Bus:ttyS17
[   13.431846] device: 'ttyS18': device_add
[   13.435790] PM: Adding info for No Bus:ttyS18
[   13.440178] device: 'ttyS19': device_add
[   13.444135] PM: Adding info for No Bus:ttyS19
[   13.448516] device: 'ttyS20': device_add
[   13.452471] PM: Adding info for No Bus:ttyS20
[   13.456852] device: 'ttyS21': device_add
[   13.460811] PM: Adding info for No Bus:ttyS21
[   13.465198] device: 'ttyS22': device_add
[   13.469156] PM: Adding info for No Bus:ttyS22
[   13.473538] device: 'ttyS23': device_add
[   13.477492] PM: Adding info for No Bus:ttyS23
[   13.481874] device: 'ttyS24': device_add
[   13.485832] PM: Adding info for No Bus:ttyS24
[   13.490220] device: 'ttyS25': device_add
[   13.494175] PM: Adding info for No Bus:ttyS25
[   13.498556] device: 'ttyS26': device_add
[   13.502512] PM: Adding info for No Bus:ttyS26
[   13.506894] device: 'ttyS27': device_add
[   13.510849] PM: Adding info for No Bus:ttyS27
[   13.515235] device: 'ttyS28': device_add
[   13.519187] PM: Adding info for No Bus:ttyS28
[   13.523568] device: 'ttyS29': device_add
[   13.527525] PM: Adding info for No Bus:ttyS29
[   13.531906] device: 'ttyS30': device_add
[   13.535861] PM: Adding info for No Bus:ttyS30
[   13.540242] device: 'ttyS31': device_add
[   13.544202] PM: Adding info for No Bus:ttyS31
[   13.548597] devices_kset: Moving serial8250 to end of list
[   13.554093] initcall serial8250_init+0x0/0x14e returned 0 after 311442 usecs
[   13.561137] calling  serial_pci_driver_init+0x0/0x1a @ 1
[   13.566468] initcall serial_pci_driver_init+0x0/0x1a returned 0 after 17 usecs
[   13.573688] calling  exar_pci_driver_init+0x0/0x1a @ 1
[   13.578836] initcall exar_pci_driver_init+0x0/0x1a returned 0 after 10 usecs
[   13.585881] calling  lpss8250_pci_driver_init+0x0/0x1a @ 1
[   13.591377] initcall lpss8250_pci_driver_init+0x0/0x1a returned 0 after 10 usecs
[   13.598769] calling  mid8250_pci_driver_init+0x0/0x1a @ 1
[   13.604179] initcall mid8250_pci_driver_init+0x0/0x1a returned 0 after 11 usecs
[   13.611483] calling  max310x_uart_init+0x0/0x35 @ 1
[   13.616378] initcall max310x_uart_init+0x0/0x35 returned 0 after 15 usecs
[   13.623165] calling  sccnxp_uart_driver_init+0x0/0x13 @ 1
[   13.628572] initcall sccnxp_uart_driver_init+0x0/0x13 returned 0 after 8 usecs
[   13.635791] calling  init_kgdboc+0x0/0x16 @ 1
[   13.640153] initcall init_kgdboc+0x0/0x16 returned 0 after 0 usecs
[   13.646329] calling  ttyprintk_init+0x0/0xff @ 1
[   13.650957] device: 'ttyprintk': device_add
[   13.655154] PM: Adding info for No Bus:ttyprintk
[   13.659788] initcall ttyprintk_init+0x0/0xff returned 0 after 8630 usecs
[   13.666482] calling  init+0x0/0x104 @ 1
[   13.670349] initcall init+0x0/0x104 returned 0 after 27 usecs
[   13.676091] calling  hpet_init+0x0/0x65 @ 1
[   13.680279] device: 'hpet': device_add
[   13.684045] PM: Adding info for No Bus:hpet
[   13.688255] devices_kset: Moving PNP0103:00 to end of list
[   13.693853] initcall hpet_init+0x0/0x65 returned 0 after 13256 usecs
[   13.700205] calling  hwrng_modinit+0x0/0x96 @ 1
[   13.704740] device: 'hw_random': device_add
[   13.708941] PM: Adding info for No Bus:hw_random
[   13.713573] initcall hwrng_modinit+0x0/0x96 returned 0 after 8629 usecs
[   13.720182] calling  agp_init+0x0/0x26 @ 1
[   13.724278] Linux agpgart interface v0.103
[   13.728379] initcall agp_init+0x0/0x26 returned 0 after 4004 usecs
[   13.734557] calling  agp_amd64_mod_init+0x0/0x20 @ 1
[   13.739547] initcall agp_amd64_mod_init+0x0/0x20 returned -19 after 22 usecs
[   13.746586] calling  agp_intel_init+0x0/0x29 @ 1
[   13.751219] initcall agp_intel_init+0x0/0x29 returned 0 after 11 usecs
[   13.757741] calling  agp_via_init+0x0/0x29 @ 1
[   13.762197] initcall agp_via_init+0x0/0x29 returned 0 after 11 usecs
[   13.768548] calling  init_tis+0x0/0xb3 @ 1
[   13.772665] initcall init_tis+0x0/0xb3 returned 0 after 17 usecs
[   13.778672] calling  cn_proc_init+0x0/0x38 @ 1
[   13.783119] initcall cn_proc_init+0x0/0x38 returned 0 after 2 usecs
[   13.789382] calling  topology_sysfs_init+0x0/0x30 @ 1
[   13.794491] initcall topology_sysfs_init+0x0/0x30 returned 0 after 54 usecs
[   13.801448] calling  cacheinfo_sysfs_init+0x0/0x2c @ 1
[   13.806594] device: 'cache': device_add
[   13.810445] PM: Adding info for No Bus:cache
[   13.814720] device: 'index0': device_add
[   13.818661] PM: Adding info for No Bus:index0
[   13.823020] device: 'index1': device_add
[   13.826960] PM: Adding info for No Bus:index1
[   13.831321] device: 'index2': device_add
[   13.835263] PM: Adding info for No Bus:index2
[   13.839624] device: 'index3': device_add
[   13.843568] PM: Adding info for No Bus:index3
[   13.847936] device: 'cache': device_add
[   13.851787] PM: Adding info for No Bus:cache
[   13.856060] device: 'index0': device_add
[   13.859998] PM: Adding info for No Bus:index0
[   13.864359] device: 'index1': device_add
[   13.868302] PM: Adding info for No Bus:index1
[   13.872663] device: 'index2': device_add
[   13.876605] PM: Adding info for No Bus:index2
[   13.880963] device: 'index3': device_add
[   13.884907] PM: Adding info for No Bus:index3
[   13.889275] device: 'cache': device_add
[   13.893127] PM: Adding info for No Bus:cache
[   13.897400] device: 'index0': device_add
[   13.901343] PM: Adding info for No Bus:index0
[   13.905699] device: 'index1': device_add
[   13.909640] PM: Adding info for No Bus:index1
[   13.914002] device: 'index2': device_add
[   13.917944] PM: Adding info for No Bus:index2
[   13.922305] device: 'index3': device_add
[   13.926247] PM: Adding info for No Bus:index3
[   13.930654] device: 'cache': device_add
[   13.934504] PM: Adding info for No Bus:cache
[   13.938776] device: 'index0': device_add
[   13.942718] PM: Adding info for No Bus:index0
[   13.947075] device: 'index1': device_add
[   13.951022] PM: Adding info for No Bus:index1
[   13.955376] device: 'index2': device_add
[   13.959319] PM: Adding info for No Bus:index2
[   13.963678] device: 'index3': device_add
[   13.967620] PM: Adding info for No Bus:index3
[   13.972025] device: 'cache': device_add
[   13.975873] PM: Adding info for No Bus:cache
[   13.980152] device: 'index0': device_add
[   13.984099] PM: Adding info for No Bus:index0
[   13.988459] device: 'index1': device_add
[   13.992398] PM: Adding info for No Bus:index1
[   13.996760] device: 'index2': device_add
[   14.000702] PM: Adding info for No Bus:index2
[   14.005061] device: 'index3': device_add
[   14.009004] PM: Adding info for No Bus:index3
[   14.013392] device: 'cache': device_add
[   14.017242] PM: Adding info for No Bus:cache
[   14.021512] device: 'index0': device_add
[   14.025455] PM: Adding info for No Bus:index0
[   14.029815] device: 'index1': device_add
[   14.033756] PM: Adding info for No Bus:index1
[   14.038117] device: 'index2': device_add
[   14.042057] PM: Adding info for No Bus:index2
[   14.046411] device: 'index3': device_add
[   14.050352] PM: Adding info for No Bus:index3
[   14.054742] device: 'cache': device_add
[   14.058595] PM: Adding info for No Bus:cache
[   14.062870] device: 'index0': device_add
[   14.066815] PM: Adding info for No Bus:index0
[   14.071173] device: 'index1': device_add
[   14.075114] PM: Adding info for No Bus:index1
[   14.079476] device: 'index2': device_add
[   14.083418] PM: Adding info for No Bus:index2
[   14.087776] device: 'index3': device_add
[   14.091720] PM: Adding info for No Bus:index3
[   14.096113] device: 'cache': device_add
[   14.099973] PM: Adding info for No Bus:cache
[   14.104249] device: 'index0': device_add
[   14.108191] PM: Adding info for No Bus:index0
[   14.112548] device: 'index1': device_add
[   14.116494] PM: Adding info for No Bus:index1
[   14.120848] device: 'index2': device_add
[   14.124794] PM: Adding info for No Bus:index2
[   14.129153] device: 'index3': device_add
[   14.133097] PM: Adding info for No Bus:index3
[   14.137477] initcall cacheinfo_sysfs_init+0x0/0x2c returned 172 after 323135 usecs
[   14.145049] calling  devcoredump_init+0x0/0x18 @ 1
[   14.149848] initcall devcoredump_init+0x0/0x18 returned 0 after 9 usecs
[   14.156461] calling  brd_init+0x0/0x18d @ 1
[   14.162684] device: '1:0': device_add
[   14.166375] PM: Adding info for No Bus:1:0
[   14.170485] device: 'ram0': device_add
[   14.174263] PM: Adding info for No Bus:ram0
[   14.178628] device: '1:1': device_add
[   14.182347] PM: Adding info for No Bus:1:1
[   14.186458] device: 'ram1': device_add
[   14.190234] PM: Adding info for No Bus:ram1
[   14.194565] device: '1:2': device_add
[   14.198264] PM: Adding info for No Bus:1:2
[   14.202372] device: 'ram2': device_add
[   14.206146] PM: Adding info for No Bus:ram2
[   14.210476] device: '1:3': device_add
[   14.214189] PM: Adding info for No Bus:1:3
[   14.218298] device: 'ram3': device_add
[   14.222077] PM: Adding info for No Bus:ram3
[   14.226406] device: '1:4': device_add
[   14.230118] PM: Adding info for No Bus:1:4
[   14.234230] device: 'ram4': device_add
[   14.238003] PM: Adding info for No Bus:ram4
[   14.242330] device: '1:5': device_add
[   14.246032] PM: Adding info for No Bus:1:5
[   14.250150] device: 'ram5': device_add
[   14.253926] PM: Adding info for No Bus:ram5
[   14.258251] device: '1:6': device_add
[   14.261969] PM: Adding info for No Bus:1:6
[   14.266078] device: 'ram6': device_add
[   14.269853] PM: Adding info for No Bus:ram6
[   14.274180] device: '1:7': device_add
[   14.277896] PM: Adding info for No Bus:1:7
[   14.282008] device: 'ram7': device_add
[   14.285786] PM: Adding info for No Bus:ram7
[   14.290109] device: '1:8': device_add
[   14.293826] PM: Adding info for No Bus:1:8
[   14.297938] device: 'ram8': device_add
[   14.301714] PM: Adding info for No Bus:ram8
[   14.306039] device: '1:9': device_add
[   14.309742] PM: Adding info for No Bus:1:9
[   14.313851] device: 'ram9': device_add
[   14.317626] PM: Adding info for No Bus:ram9
[   14.321950] device: '1:10': device_add
[   14.325754] PM: Adding info for No Bus:1:10
[   14.329951] device: 'ram10': device_add
[   14.333813] PM: Adding info for No Bus:ram10
[   14.338227] device: '1:11': device_add
[   14.342031] PM: Adding info for No Bus:1:11
[   14.346226] device: 'ram11': device_add
[   14.350092] PM: Adding info for No Bus:ram11
[   14.354500] device: '1:12': device_add
[   14.358306] PM: Adding info for No Bus:1:12
[   14.362504] device: 'ram12': device_add
[   14.366365] PM: Adding info for No Bus:ram12
[   14.370780] device: '1:13': device_add
[   14.374582] PM: Adding info for No Bus:1:13
[   14.378784] device: 'ram13': device_add
[   14.382644] PM: Adding info for No Bus:ram13
[   14.387054] device: '1:14': device_add
[   14.390859] PM: Adding info for No Bus:1:14
[   14.395057] device: 'ram14': device_add
[   14.398919] PM: Adding info for No Bus:ram14
[   14.403331] device: '1:15': device_add
[   14.407135] PM: Adding info for No Bus:1:15
[   14.411331] device: 'ram15': device_add
[   14.415195] PM: Adding info for No Bus:ram15
[   14.419607] brd: module loaded
[   14.422668] initcall brd_init+0x0/0x18d returned 0 after 255862 usecs
[   14.429123] calling  loop_init+0x0/0x13b @ 1
[   14.433397] device: 'loop-control': device_add
[   14.437857] PM: Adding info for No Bus:loop-control
[   14.443015] device: '7:0': device_add
[   14.446735] PM: Adding info for No Bus:7:0
[   14.450845] device: 'loop0': device_add
[   14.454707] PM: Adding info for No Bus:loop0
[   14.459500] device: '7:1': device_add
[   14.463205] PM: Adding info for No Bus:7:1
[   14.467328] device: 'loop1': device_add
[   14.471190] PM: Adding info for No Bus:loop1
[   14.475974] device: '7:2': device_add
[   14.479678] PM: Adding info for No Bus:7:2
[   14.483803] device: 'loop2': device_add
[   14.487667] PM: Adding info for No Bus:loop2
[   14.492446] device: '7:3': device_add
[   14.496130] PM: Adding info for No Bus:7:3
[   14.500236] device: 'loop3': device_add
[   14.504099] PM: Adding info for No Bus:loop3
[   14.508874] device: '7:4': device_add
[   14.512563] PM: Adding info for No Bus:7:4
[   14.516675] device: 'loop4': device_add
[   14.520539] PM: Adding info for No Bus:loop4
[   14.525322] device: '7:5': device_add
[   14.529014] PM: Adding info for No Bus:7:5
[   14.533124] device: 'loop5': device_add
[   14.536987] PM: Adding info for No Bus:loop5
[   14.541780] device: '7:6': device_add
[   14.545473] PM: Adding info for No Bus:7:6
[   14.549581] device: 'loop6': device_add
[   14.553445] PM: Adding info for No Bus:loop6
[   14.558227] device: '7:7': device_add
[   14.561920] PM: Adding info for No Bus:7:7
[   14.566032] device: 'loop7': device_add
[   14.569898] PM: Adding info for No Bus:loop7
[   14.574457] loop: module loaded
[   14.577601] initcall loop_init+0x0/0x13b returned 0 after 140826 usecs
[   14.584142] calling  init+0x0/0x80 @ 1
[   14.587933] initcall init+0x0/0x80 returned 0 after 39 usecs
[   14.593588] calling  xlblk_init+0x0/0xf2 @ 1
[   14.597870] initcall xlblk_init+0x0/0xf2 returned -19 after 0 usecs
[   14.604136] calling  htcpld_core_init+0x0/0x2d @ 1
[   14.608947] initcall htcpld_core_init+0x0/0x2d returned -19 after 18 usecs
[   14.615817] calling  wm8994_i2c_driver_init+0x0/0x13 @ 1
[   14.621139] initcall wm8994_i2c_driver_init+0x0/0x13 returned 0 after 6 usecs
[   14.628273] calling  tps65912_i2c_driver_init+0x0/0x13 @ 1
[   14.633765] initcall tps65912_i2c_driver_init+0x0/0x13 returned 0 after 5 usecs
[   14.641064] calling  tps65912_spi_driver_init+0x0/0x13 @ 1
[   14.646555] initcall tps65912_spi_driver_init+0x0/0x13 returned 0 after 5 usecs
[   14.653855] calling  twl6040_driver_init+0x0/0x13 @ 1
[   14.658907] initcall twl6040_driver_init+0x0/0x13 returned 0 after 5 usecs
[   14.665773] calling  smsc_i2c_driver_init+0x0/0x13 @ 1
[   14.670918] initcall smsc_i2c_driver_init+0x0/0x13 returned 0 after 5 usecs
[   14.677872] calling  da9063_i2c_driver_init+0x0/0x13 @ 1
[   14.683189] initcall da9063_i2c_driver_init+0x0/0x13 returned 0 after 5 usecs
[   14.690317] calling  max77693_i2c_driver_init+0x0/0x13 @ 1
[   14.695809] initcall max77693_i2c_driver_init+0x0/0x13 returned 0 after 5 usecs
[   14.703110] calling  adp5520_driver_init+0x0/0x13 @ 1
[   14.708168] initcall adp5520_driver_init+0x0/0x13 returned 0 after 5 usecs
[   14.715034] calling  spi_transport_init+0x0/0x75 @ 1
[   14.720028] initcall spi_transport_init+0x0/0x75 returned 0 after 25 usecs
[   14.726898] calling  init_sd+0x0/0x168 @ 1
[   14.731033] initcall init_sd+0x0/0x168 returned 0 after 33 usecs
[   14.737040] calling  init_sr+0x0/0x46 @ 1
[   14.741058] initcall init_sr+0x0/0x46 returned 0 after 6 usecs
[   14.746884] calling  init_sg+0x0/0x11f @ 1
[   14.750998] initcall init_sg+0x0/0x11f returned 0 after 13 usecs
[   14.757000] calling  piix_init+0x0/0x29 @ 1
[   14.761213] initcall piix_init+0x0/0x29 returned 0 after 18 usecs
[   14.767303] calling  sis_pci_driver_init+0x0/0x1a @ 1
[   14.772370] initcall sis_pci_driver_init+0x0/0x1a returned 0 after 14 usecs
[   14.779325] calling  ata_generic_pci_driver_init+0x0/0x1a @ 1
[   14.785087] initcall ata_generic_pci_driver_init+0x0/0x1a returned 0 after 15 usecs
[   14.792739] calling  net_olddevs_init+0x0/0x56 @ 1
[   14.797534] initcall net_olddevs_init+0x0/0x56 returned 0 after 1 usecs
[   14.804144] calling  mdio_gpio_driver_init+0x0/0x13 @ 1
[   14.809378] initcall mdio_gpio_driver_init+0x0/0x13 returned 0 after 7 usecs
[   14.816416] calling  phy_module_init+0x0/0x18 @ 1
[   14.821130] initcall phy_module_init+0x0/0x18 returned 0 after 8 usecs
[   14.827649] calling  phy_module_init+0x0/0x18 @ 1
[   14.832375] initcall phy_module_init+0x0/0x18 returned 0 after 18 usecs
[   14.838984] calling  phy_module_init+0x0/0x18 @ 1
[   14.843706] initcall phy_module_init+0x0/0x18 returned 0 after 13 usecs
[   14.850312] calling  phy_module_init+0x0/0x18 @ 1
[   14.855119] initcall phy_module_init+0x0/0x18 returned 0 after 98 usecs
[   14.861726] calling  phy_module_init+0x0/0x18 @ 1
[   14.866447] initcall phy_module_init+0x0/0x18 returned 0 after 13 usecs
[   14.873055] calling  phy_module_init+0x0/0x18 @ 1
[   14.877787] initcall phy_module_init+0x0/0x18 returned 0 after 26 usecs
[   14.884399] calling  fixed_mdio_bus_init+0x0/0xc6 @ 1
[   14.889456] device: 'Fixed MDIO bus.0': device_add
[   14.894262] PM: Adding info for platform:Fixed MDIO bus.0
[   14.899670] device: 'fixed-0': device_add
[   14.903699] PM: Adding info for No Bus:fixed-0
[   14.908151] libphy: Fixed MDIO Bus: probed
[   14.912245] initcall fixed_mdio_bus_init+0x0/0xc6 returned 0 after 22258 usecs
[   14.919464] calling  phy_module_init+0x0/0x18 @ 1
[   14.924194] initcall phy_module_init+0x0/0x18 returned 0 after 23 usecs
[   14.930800] calling  phy_module_init+0x0/0x18 @ 1
[   14.935512] initcall phy_module_init+0x0/0x18 returned 0 after 6 usecs
[   14.942030] calling  phy_module_init+0x0/0x18 @ 1
[   14.946754] initcall phy_module_init+0x0/0x18 returned 0 after 24 usecs
[   14.953368] calling  phy_module_init+0x0/0x18 @ 1
[   14.958171] initcall phy_module_init+0x0/0x18 returned 0 after 94 usecs
[   14.964781] calling  phy_module_init+0x0/0x18 @ 1
[   14.969586] initcall phy_module_init+0x0/0x18 returned 0 after 95 usecs
[   14.976196] calling  phy_module_init+0x0/0x18 @ 1
[   14.980908] initcall phy_module_init+0x0/0x18 returned 0 after 6 usecs
[   14.987427] calling  phy_module_init+0x0/0x18 @ 1
[   14.992141] initcall phy_module_init+0x0/0x18 returned 0 after 6 usecs
[   14.998659] calling  phy_module_init+0x0/0x18 @ 1
[   15.003401] initcall phy_module_init+0x0/0x18 returned 0 after 35 usecs
[   15.010013] calling  phy_module_init+0x0/0x18 @ 1
[   15.014754] initcall phy_module_init+0x0/0x18 returned 0 after 35 usecs
[   15.021367] calling  phy_module_init+0x0/0x18 @ 1
[   15.026084] initcall phy_module_init+0x0/0x18 returned 0 after 10 usecs
[   15.032694] calling  phy_module_init+0x0/0x18 @ 1
[   15.037448] initcall phy_module_init+0x0/0x18 returned 0 after 48 usecs
[   15.044057] calling  tun_init+0x0/0xa9 @ 1
[   15.048155] tun: Universal TUN/TAP device driver, 1.6
[   15.053211] device: 'tun': device_add
[   15.056887] PM: Adding info for No Bus:tun
[   15.061028] initcall tun_init+0x0/0xa9 returned 0 after 12570 usecs
[   15.067292] calling  virtio_net_driver_init+0x0/0x92 @ 1
[   15.072622] initcall virtio_net_driver_init+0x0/0x92 returned 0 after 6 usecs
[   15.079753] calling  cavium_ptp_init_module+0x0/0x1a @ 1
[   15.085076] initcall cavium_ptp_init_module+0x0/0x1a returned 0 after 9 usecs
[   15.092208] calling  ppp_init+0x0/0x115 @ 1
[   15.096394] PPP generic driver version 2.4.2
[   15.100676] device: 'ppp': device_add
[   15.104353] PM: Adding info for No Bus:ppp
[   15.108485] initcall ppp_init+0x0/0x115 returned 0 after 11806 usecs
[   15.114851] calling  netif_init+0x0/0x6b @ 1
[   15.119119] initcall netif_init+0x0/0x6b returned -19 after 0 usecs
[   15.125391] calling  cdrom_init+0x0/0x16 @ 1
[   15.129696] initcall cdrom_init+0x0/0x16 returned 0 after 23 usecs
[   15.135870] calling  ehci_hcd_init+0x0/0xca @ 1
[   15.140403] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   15.146931] initcall ehci_hcd_init+0x0/0xca returned 0 after 6375 usecs
[   15.153542] calling  ehci_pci_init+0x0/0x65 @ 1
[   15.158073] ehci-pci: EHCI PCI platform driver
[   15.162520] initcall ehci_pci_init+0x0/0x65 returned 0 after 4342 usecs
[   15.169132] calling  ehci_platform_init+0x0/0x48 @ 1
[   15.174099] ehci-platform: EHCI generic platform driver
[   15.179334] initcall ehci_platform_init+0x0/0x48 returned 0 after 5111 usecs
[   15.186381] calling  ohci_hcd_mod_init+0x0/0x95 @ 1
[   15.191258] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   15.197445] initcall ohci_hcd_mod_init+0x0/0x95 returned 0 after 6041 usecs
[   15.204399] calling  ohci_pci_init+0x0/0x65 @ 1
[   15.208929] ohci-pci: OHCI PCI platform driver
[   15.213378] initcall ohci_pci_init+0x0/0x65 returned 0 after 4344 usecs
[   15.219989] calling  ohci_platform_init+0x0/0x48 @ 1
[   15.224954] ohci-platform: OHCI generic platform driver
[   15.230179] initcall ohci_platform_init+0x0/0x48 returned 0 after 5102 usecs
[   15.237219] calling  uhci_hcd_init+0x0/0x116 @ 1
[   15.241838] uhci_hcd: USB Universal Host Controller Interface driver
[   15.248214] initcall uhci_hcd_init+0x0/0x116 returned 0 after 6226 usecs
[   15.254909] calling  xhci_hcd_init+0x0/0x25 @ 1
[   15.259442] initcall xhci_hcd_init+0x0/0x25 returned 0 after 2 usecs
[   15.265792] calling  xhci_pci_init+0x0/0x43 @ 1
[   15.270336] devices_kset: Moving 0000:00:14.0 to end of list
[   15.276288] xhci_hcd 0000:00:14.0: xHCI Host Controller
[   15.281522] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[   15.289991] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x00109810
[   15.298426] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
[   15.305422] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[   15.312203] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   15.319431] usb usb1: Product: xHCI Host Controller
[   15.324310] usb usb1: Manufacturer: Linux 4.16.0-rc7-custom xhci-hcd
[   15.330662] usb usb1: SerialNumber: 0000:00:14.0
[   15.335282] device: 'usb1': device_add
[   15.339104] PM: Adding info for usb:usb1
[   15.343097] devices_kset: Moving usb1 to end of list
[   15.348083] device: '1-0:1.0': device_add
[   15.352140] PM: Adding info for usb:1-0:1.0
[   15.356338] devices_kset: Moving 1-0:1.0 to end of list
[   15.361561] hub 1-0:1.0: USB hub found
[   15.365332] hub 1-0:1.0: 16 ports detected
[   15.369458] device: 'usb1-port1': device_add
[   15.374036] PM: Adding info for No Bus:usb1-port1
[   15.378743] device: 'usb1-port2': device_add
[   15.383291] PM: Adding info for No Bus:usb1-port2
[   15.388000] device: 'usb1-port3': device_add
[   15.392566] PM: Adding info for No Bus:usb1-port3
[   15.397272] device: 'usb1-port4': device_add
[   15.401817] PM: Adding info for No Bus:usb1-port4
[   15.406527] device: 'usb1-port5': device_add
[   15.411072] PM: Adding info for No Bus:usb1-port5
[   15.415785] device: 'usb1-port6': device_add
[   15.420329] PM: Adding info for No Bus:usb1-port6
[   15.425041] device: 'usb1-port7': device_add
[   15.429588] PM: Adding info for No Bus:usb1-port7
[   15.434296] device: 'usb1-port8': device_add
[   15.438839] PM: Adding info for No Bus:usb1-port8
[   15.443553] device: 'usb1-port9': device_add
[   15.448127] PM: Adding info for No Bus:usb1-port9
[   15.452836] device: 'usb1-port10': device_add
[   15.457472] PM: Adding info for No Bus:usb1-port10
[   15.462273] device: 'usb1-port11': device_add
[   15.466916] PM: Adding info for No Bus:usb1-port11
[   15.471712] device: 'usb1-port12': device_add
[   15.476350] PM: Adding info for No Bus:usb1-port12
[   15.481149] device: 'usb1-port13': device_add
[   15.485787] PM: Adding info for No Bus:usb1-port13
[   15.490588] device: 'usb1-port14': device_add
[   15.495226] PM: Adding info for No Bus:usb1-port14
[   15.500030] device: 'usb1-port15': device_add
[   15.504676] PM: Adding info for No Bus:usb1-port15
[   15.509472] device: 'usb1-port16': device_add
[   15.514109] PM: Adding info for No Bus:usb1-port16
[   15.519038] device: 'ep_81': device_add
[   15.522924] PM: Adding info for No Bus:ep_81
[   15.527208] device: 'ep_00': device_add
[   15.531065] PM: Adding info for No Bus:ep_00
[   15.535344] xhci_hcd 0000:00:14.0: xHCI Host Controller
[   15.540573] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[   15.548058] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003
[   15.554849] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   15.562061] usb usb2: Product: xHCI Host Controller
[   15.566951] usb usb2: Manufacturer: Linux 4.16.0-rc7-custom xhci-hcd
[   15.573310] usb usb2: SerialNumber: 0000:00:14.0
[   15.577986] device: 'usb2': device_add
[   15.581811] PM: Adding info for usb:usb2
[   15.585851] devices_kset: Moving usb2 to end of list
[   15.590865] device: '2-0:1.0': device_add
[   15.594897] PM: Adding info for usb:2-0:1.0
[   15.599088] devices_kset: Moving 2-0:1.0 to end of list
[   15.604314] hub 2-0:1.0: USB hub found
[   15.608085] hub 2-0:1.0: 10 ports detected
[   15.612211] device: 'usb2-port1': device_add
[   15.616751] PM: Adding info for No Bus:usb2-port1
[   15.621469] device: 'usb2-port2': device_add
[   15.626000] PM: Adding info for No Bus:usb2-port2
[   15.630715] device: 'usb2-port3': device_add
[   15.635259] PM: Adding info for No Bus:usb2-port3
[   15.639982] device: 'usb2-port4': device_add
[   15.644500] PM: Adding info for No Bus:usb2-port4
[   15.649229] device: 'usb2-port5': device_add
[   15.653738] PM: Adding info for No Bus:usb2-port5
[   15.658455] device: 'usb2-port6': device_add
[   15.662970] PM: Adding info for No Bus:usb2-port6
[   15.667693] device: 'usb2-port7': device_add
[   15.672234] PM: Adding info for No Bus:usb2-port7
[   15.676962] device: 'usb2-port8': device_add
[   15.681481] PM: Adding info for No Bus:usb2-port8
[   15.686199] device: 'usb2-port9': device_add
[   15.690717] PM: Adding info for No Bus:usb2-port9
[   15.695427] device: 'usb2-port10': device_add
[   15.700028] PM: Adding info for No Bus:usb2-port10
[   15.704911] device: 'ep_81': device_add
[   15.708782] PM: Adding info for No Bus:ep_81
[   15.713075] device: 'ep_00': device_add
[   15.716951] PM: Adding info for No Bus:ep_00
[   15.721530] devices_kset: Moving 0000:08:00.0 to end of list
[   15.727272] xhci_hcd 0000:08:00.0: xHCI Host Controller
[   15.732499] xhci_hcd 0000:08:00.0: new USB bus registered, assigned bus number 3
[   15.798655] xhci_hcd 0000:08:00.0: hcc params 0x0200eec1 hci version 0x110 quirks 0x00000010
[   15.807545] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
[   15.814335] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   15.821569] usb usb3: Product: xHCI Host Controller
[   15.826447] usb usb3: Manufacturer: Linux 4.16.0-rc7-custom xhci-hcd
[   15.832802] usb usb3: SerialNumber: 0000:08:00.0
[   15.837421] device: 'usb3': device_add
[   15.841226] PM: Adding info for usb:usb3
[   15.845268] devices_kset: Moving usb3 to end of list
[   15.850259] device: '3-0:1.0': device_add
[   15.854321] PM: Adding info for usb:3-0:1.0
[   15.858519] devices_kset: Moving 3-0:1.0 to end of list
[   15.863742] hub 3-0:1.0: USB hub found
[   15.867502] hub 3-0:1.0: 2 ports detected
[   15.871545] device: 'usb3-port1': device_add
[   15.875844] PM: Adding info for No Bus:usb3-port1
[   15.880551] device: 'usb3-port2': device_add
[   15.884831] PM: Adding info for No Bus:usb3-port2
[   15.889561] device: 'ep_81': device_add
[   15.893433] PM: Adding info for No Bus:ep_81
[   15.897714] device: 'ep_00': device_add
[   15.901571] PM: Adding info for No Bus:ep_00
[   15.905852] xhci_hcd 0000:08:00.0: xHCI Host Controller
[   15.911082] xhci_hcd 0000:08:00.0: new USB bus registered, assigned bus number 4
[   15.918474] xhci_hcd 0000:08:00.0: Host supports USB 3.1 Enhanced SuperSpeed
[   15.925548] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
[   15.933680] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003
[   15.940468] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   15.947684] usb usb4: Product: xHCI Host Controller
[   15.952556] usb usb4: Manufacturer: Linux 4.16.0-rc7-custom xhci-hcd
[   15.958909] usb usb4: SerialNumber: 0000:08:00.0
[   15.963529] device: 'usb4': device_add
[   15.967332] PM: Adding info for usb:usb4
[   15.971377] devices_kset: Moving usb4 to end of list
[   15.976383] device: '4-0:1.0': device_add
[   15.980416] PM: Adding info for usb:4-0:1.0
[   15.984610] devices_kset: Moving 4-0:1.0 to end of list
[   15.989833] hub 4-0:1.0: USB hub found
[   15.993610] hub 4-0:1.0: 2 ports detected
[   15.997651] device: 'usb4-port1': device_add
[   16.001946] PM: Adding info for No Bus:usb4-port1
[   16.006656] device: 'usb4-port2': device_add
[   16.010955] PM: Adding info for No Bus:usb4-port2
[   16.015697] device: 'ep_81': device_add
[   16.019554] PM: Adding info for No Bus:ep_81
[   16.023831] device: 'ep_00': device_add
[   16.027688] PM: Adding info for No Bus:ep_00
[   16.031974] initcall xhci_pci_init+0x0/0x43 returned 0 after 743799 usecs
[   16.038756] calling  kgdbdbgp_start_thread+0x0/0x4f @ 1
[   16.043979] initcall kgdbdbgp_start_thread+0x0/0x4f returned 0 after 0 usecs
[   16.051019] calling  i8042_init+0x0/0x45f @ 1
[   16.055399] i8042: PNP: No PS/2 controller found.
[   16.060102] initcall i8042_init+0x0/0x45f returned -19 after 4613 usecs
[   16.066712] calling  input_leds_init+0x0/0x11 @ 1
[   16.071412] initcall input_leds_init+0x0/0x11 returned 0 after 0 usecs
[   16.077937] calling  mousedev_init+0x0/0x85 @ 1
[   16.082474] device: 'mice': device_add
[   16.086237] PM: Adding info for No Bus:mice
[   16.090552] device: 'psaux': device_add
[   16.094430] PM: Adding info for No Bus:psaux
[   16.098812] mousedev: PS/2 mouse device common for all mice
[   16.104399] initcall mousedev_init+0x0/0x85 returned 0 after 21414 usecs
[   16.111097] calling  evdev_init+0x0/0x11 @ 1
[   16.115374] device: 'event0': device_add
[   16.119327] PM: Adding info for No Bus:event0
[   16.123828] device: 'event1': device_add
[   16.127773] PM: Adding info for No Bus:event1
[   16.132185] device: 'event2': device_add
[   16.136138] PM: Adding info for No Bus:event2
[   16.140550] initcall evdev_init+0x0/0x11 returned 0 after 24591 usecs
[   16.147002] calling  atkbd_init+0x0/0x26 @ 1
[   16.151289] initcall atkbd_init+0x0/0x26 returned 0 after 13 usecs
[   16.157463] calling  uinput_misc_init+0x0/0x11 @ 1
[   16.162281] device: 'uinput': device_add
[   16.166233] PM: Adding info for No Bus:uinput
[   16.170638] initcall uinput_misc_init+0x0/0x11 returned 0 after 8177 usecs
[   16.177518] calling  cmos_init+0x0/0x76 @ 1
[   16.181712] devices_kset: Moving 00:05 to end of list
[   16.186771] rtc_cmos 00:05: RTC can wake from S4
[   16.191725] device: 'rtc0': device_add
[   16.195498] PM: Adding info for No Bus:rtc0
[   16.199718] rtc_cmos 00:05: rtc core: registered rtc_cmos as rtc0
[   16.205903] rtc_cmos 00:05: alarms up to one month, y3k, 242 bytes nvram, hpet irqs
[   16.213561] initcall cmos_init+0x0/0x76 returned 0 after 31111 usecs
[   16.219914] calling  ptp_kvm_init+0x0/0xee @ 1
[   16.224360] initcall ptp_kvm_init+0x0/0xee returned -19 after 0 usecs
[   16.230800] calling  dm_init+0x0/0x46 @ 1
[   16.234874] device-mapper: uevent: version 1.0.3
[   16.239577] device: 'device-mapper': device_add
[   16.244115] PM: Adding info for No Bus:device-mapper
[   16.249122] device-mapper: ioctl: 4.37.0-ioctl (2017-09-20) initialised: dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
[   16.257563] initcall dm_init+0x0/0x46 returned 0 after 22215 usecs
[   16.263749] calling  cpufreq_gov_powersave_init+0x0/0x11 @ 1
[   16.269401] initcall cpufreq_gov_powersave_init+0x0/0x11 returned 0 after 0 usecs
[   16.276881] calling  cpufreq_gov_userspace_init+0x0/0x11 @ 1
[   16.282538] initcall cpufreq_gov_userspace_init+0x0/0x11 returned 0 after 0 usecs
[   16.290011] calling  cpufreq_gov_dbs_init+0x0/0x11 @ 1
[   16.295150] initcall cpufreq_gov_dbs_init+0x0/0x11 returned 0 after 0 usecs
[   16.302109] calling  cpufreq_gov_dbs_init+0x0/0x11 @ 1
[   16.307249] initcall cpufreq_gov_dbs_init+0x0/0x11 returned 0 after 0 usecs
[   16.314206] calling  intel_pstate_init+0x0/0x301 @ 1
[   16.319165] intel_pstate: Intel P-state driver initializing
[   16.325397] intel_pstate: HWP enabled
[   16.329064] initcall intel_pstate_init+0x0/0x301 returned 0 after 9667 usecs
[   16.336108] calling  ledtrig_cpu_init+0x0/0xd8 @ 1
[   16.341136] ledtrig-cpu: registered to indicate activity on CPUs
[   16.347151] initcall ledtrig_cpu_init+0x0/0xd8 returned 0 after 6102 usecs
[   16.354034] calling  efivars_sysfs_init+0x0/0x220 @ 1
[   16.359084] initcall efivars_sysfs_init+0x0/0x220 returned -19 after 0 usecs
[   16.366130] calling  esrt_sysfs_init+0x0/0x30b @ 1
[   16.370921] initcall esrt_sysfs_init+0x0/0x30b returned -38 after 0 usecs
[   16.377699] calling  pmc_atom_init+0x0/0x270 @ 1
[   16.382322] initcall pmc_atom_init+0x0/0x270 returned -19 after 1 usecs
[   16.388951] calling  extcon_class_init+0x0/0x17 @ 1
[   16.393861] initcall extcon_class_init+0x0/0x17 returned 0 after 22 usecs
[   16.400640] calling  powercap_init+0x0/0x27d @ 1
[   16.405318] initcall powercap_init+0x0/0x27d returned 0 after 47 usecs
[   16.411838] calling  pm_check_save_msr+0x0/0x20 @ 1
[   16.416716] initcall pm_check_save_msr+0x0/0x20 returned 0 after 0 usecs
[   16.423415] calling  sock_diag_init+0x0/0x36 @ 1
[   16.428092] initcall sock_diag_init+0x0/0x36 returned 0 after 63 usecs
[   16.434615] calling  blackhole_init+0x0/0x11 @ 1
[   16.439242] initcall blackhole_init+0x0/0x11 returned 0 after 0 usecs
[   16.445681] calling  gre_offload_init+0x0/0x47 @ 1
[   16.450475] initcall gre_offload_init+0x0/0x47 returned 0 after 0 usecs
[   16.457087] calling  sysctl_ipv4_init+0x0/0x4e @ 1
[   16.461905] initcall sysctl_ipv4_init+0x0/0x4e returned 0 after 24 usecs
[   16.468606] calling  cubictcp_register+0x0/0x58 @ 1
[   16.473485] initcall cubictcp_register+0x0/0x58 returned 0 after 0 usecs
[   16.480182] calling  inet6_init+0x0/0x367 @ 1
[   16.484794] NET: Registered protocol family 10
[   16.489655] Segment Routing with IPv6
[   16.493352] initcall inet6_init+0x0/0x367 returned 0 after 8601 usecs
[   16.499805] calling  packet_init+0x0/0x42 @ 1
[   16.504163] NET: Registered protocol family 17
[   16.508612] initcall packet_init+0x0/0x42 returned 0 after 4344 usecs
[   16.515049] calling  dcbnl_init+0x0/0x4d @ 1
[   16.519324] initcall dcbnl_init+0x0/0x4d returned 0 after 1 usecs
[   16.525413] calling  init_dns_resolver+0x0/0xe8 @ 1
[   16.530291] Key type dns_resolver registered
[   16.534557] initcall init_dns_resolver+0x0/0xe8 returned 0 after 4173 usecs
[   16.541517] calling  mcheck_init_device+0x0/0x12c @ 1
[   16.546585] device: 'machinecheck': device_add
[   16.551035] PM: Adding info for No Bus:machinecheck
[   16.555940] device: 'machinecheck0': device_add
[   16.560488] PM: Adding info for machinecheck:machinecheck0
[   16.566044] device: 'machinecheck1': device_add
[   16.570604] PM: Adding info for machinecheck:machinecheck1
[   16.576164] device: 'machinecheck2': device_add
[   16.580723] PM: Adding info for machinecheck:machinecheck2
[   16.586315] device: 'machinecheck3': device_add
[   16.590871] PM: Adding info for machinecheck:machinecheck3
[   16.596491] device: 'machinecheck4': device_add
[   16.601043] PM: Adding info for machinecheck:machinecheck4
[   16.606644] device: 'machinecheck5': device_add
[   16.611194] PM: Adding info for machinecheck:machinecheck5
[   16.616747] device: 'machinecheck6': device_add
[   16.621315] PM: Adding info for machinecheck:machinecheck6
[   16.626929] device: 'machinecheck7': device_add
[   16.631478] PM: Adding info for machinecheck:machinecheck7
[   16.637019] initcall mcheck_init_device+0x0/0x12c returned 0 after 88327 usecs
[   16.644277] calling  tboot_late_init+0x0/0x2dc @ 1
[   16.649071] initcall tboot_late_init+0x0/0x2dc returned 0 after 0 usecs
[   16.655684] calling  mcheck_late_init+0x0/0x49 @ 1
[   16.660483] initcall mcheck_late_init+0x0/0x49 returned 0 after 7 usecs
[   16.667096] calling  severities_debugfs_init+0x0/0x3c @ 1
[   16.672497] initcall severities_debugfs_init+0x0/0x3c returned 0 after 2 usecs
[   16.679714] calling  threshold_init_device+0x0/0x46 @ 1
[   16.684933] initcall threshold_init_device+0x0/0x46 returned 0 after 0 usecs
[   16.691979] calling  microcode_init+0x0/0x1d7 @ 1
[   16.696688] device: 'microcode': device_add
[   16.700890] PM: Adding info for platform:microcode
[   16.705711] microcode: sig=0x506e3, pf=0x2, revision=0xa0
[   16.711277] device: 'microcode': device_add
[   16.715488] PM: Adding info for No Bus:microcode
[   16.720216] microcode: Microcode Update Driver: v2.2.
[   16.720218] initcall microcode_init+0x0/0x1d7 returned 0 after 22981 usecs
[   16.732168] calling  hpet_insert_resource+0x0/0x23 @ 1
[   16.737306] initcall hpet_insert_resource+0x0/0x23 returned 0 after 0 usecs
[   16.744266] calling  update_mp_table+0x0/0x4fc @ 1
[   16.749059] initcall update_mp_table+0x0/0x4fc returned 0 after 0 usecs
[   16.755670] calling  lapic_insert_resource+0x0/0x3f @ 1
[   16.760897] initcall lapic_insert_resource+0x0/0x3f returned 0 after 0 usecs
[   16.767942] calling  print_ICs+0x0/0x1ad @ 1
[   16.772216] initcall print_ICs+0x0/0x1ad returned 0 after 0 usecs
[   16.778308] calling  pat_memtype_list_init+0x0/0x32 @ 1
[   16.783539] initcall pat_memtype_list_init+0x0/0x32 returned 0 after 4 usecs
[   16.790578] calling  create_tlb_single_page_flush_ceiling+0x0/0x29 @ 1
[   16.797099] initcall create_tlb_single_page_flush_ceiling+0x0/0x29 returned 0 after 2 usecs
[   16.805443] calling  create_init_pkru_value+0x0/0x29 @ 1
[   16.810757] initcall create_init_pkru_value+0x0/0x29 returned 0 after 2 usecs
[   16.817890] calling  init_oops_id+0x0/0x40 @ 1
[   16.822334] initcall init_oops_id+0x0/0x40 returned 0 after 0 usecs
[   16.828601] calling  sched_clock_init_late+0x0/0x95 @ 1
[   16.833825] sched_clock: Marking stable (16833824463, 0)->(17018177373, -184352910)
[   16.841593] initcall sched_clock_init_late+0x0/0x95 returned 0 after 7584 usecs
[   16.848900] calling  sched_init_debug+0x0/0x3e @ 1
[   16.853696] initcall sched_init_debug+0x0/0x3e returned 0 after 5 usecs
[   16.860302] calling  pm_qos_power_init+0x0/0xba @ 1
[   16.865189] device: 'cpu_dma_latency': device_add
[   16.869902] PM: Adding info for No Bus:cpu_dma_latency
[   16.875059] device: 'network_latency': device_add
[   16.879774] PM: Adding info for No Bus:network_latency
[   16.884924] device: 'network_throughput': device_add
[   16.889904] PM: Adding info for No Bus:network_throughput
[   16.895316] device: 'memory_bandwidth': device_add
[   16.900124] PM: Adding info for No Bus:memory_bandwidth
[   16.905355] initcall pm_qos_power_init+0x0/0xba returned 0 after 39229 usecs
[   16.912399] calling  pm_debugfs_init+0x0/0x24 @ 1
[   16.917107] initcall pm_debugfs_init+0x0/0x24 returned 0 after 2 usecs
[   16.923631] calling  printk_late_init+0x0/0x160 @ 1
[   16.928511] initcall printk_late_init+0x0/0x160 returned 0 after 0 usecs
[   16.935209] calling  tk_debug_sleep_time_init+0x0/0x3c @ 1
[   16.940698] initcall tk_debug_sleep_time_init+0x0/0x3c returned 0 after 2 usecs
[   16.948001] calling  debugfs_kprobe_init+0x0/0xa9 @ 1
[   16.953065] initcall debugfs_kprobe_init+0x0/0xa9 returned 0 after 9 usecs
[   16.959936] calling  taskstats_init+0x0/0x39 @ 1
[   16.964560] registered taskstats version 1
[   16.968655] initcall taskstats_init+0x0/0x39 returned 0 after 4005 usecs
[   16.975353] calling  kdb_ftrace_register+0x0/0x2d @ 1
[   16.980405] initcall kdb_ftrace_register+0x0/0x2d returned 0 after 0 usecs
[   16.987277] calling  load_system_certificate_list+0x0/0x100 @ 1
[   16.993189] Loading compiled-in X.509 certificates
[   17.000213] Loaded X.509 cert 'Build time autogenerated kernel key: e07636c1c73ecd684448c6ff33d4baab5cdd84bd'
[   17.010118] initcall load_system_certificate_list+0x0/0x100 returned 0 after 16531 usecs
[   17.018203] calling  fault_around_debugfs+0x0/0x35 @ 1
[   17.023343] initcall fault_around_debugfs+0x0/0x35 returned 0 after 3 usecs
[   17.030299] calling  max_swapfiles_check+0x0/0x8 @ 1
[   17.035265] initcall max_swapfiles_check+0x0/0x8 returned 0 after 0 usecs
[   17.042051] calling  split_huge_pages_debugfs+0x0/0x35 @ 1
[   17.047541] initcall split_huge_pages_debugfs+0x0/0x35 returned 0 after 2 usecs
[   17.054844] calling  kmemleak_late_init+0x0/0x91 @ 1
[   17.059827] kmemleak: Kernel memory leak detector initialized
[   17.059828] kmemleak: Automatic memory scanning thread started
[   17.065574] initcall kmemleak_late_init+0x0/0x91 returned 0 after 5629 usecs
[   17.065576] calling  check_early_ioremap_leak+0x0/0x38 @ 1
[   17.083954] initcall check_early_ioremap_leak+0x0/0x38 returned 0 after 0 usecs
[   17.091265] calling  init_root_keyring+0x0/0xa @ 1
[   17.096062] initcall init_root_keyring+0x0/0xa returned 0 after 8 usecs
[   17.102675] calling  big_key_init+0x0/0x9a @ 1
[   17.110865] Key type big_key registered
[   17.114706] initcall big_key_init+0x0/0x9a returned 0 after 7407 usecs
[   17.121230] calling  init_trusted+0x0/0xbc @ 1
[   17.127573] Key type trusted registered
[   17.131422] initcall init_trusted+0x0/0xbc returned 0 after 5611 usecs
[   17.137947] calling  init_encrypted+0x0/0xcb @ 1
[   17.144373] Key type encrypted registered
[   17.148387] initcall init_encrypted+0x0/0xcb returned 0 after 5683 usecs
[   17.155083] calling  init_profile_hash+0x0/0x80 @ 1
[   17.159962] AppArmor: AppArmor sha1 policy hashing enabled
[   17.165449] initcall init_profile_hash+0x0/0x80 returned 0 after 5359 usecs
[   17.172408] calling  init_ima+0x0/0x39 @ 1
[   17.176506] ima: No TPM chip found, activating TPM-bypass! (rc=-19)
[   17.182797] initcall init_ima+0x0/0x39 returned 0 after 6143 usecs
[   17.188968] calling  init_evm+0x0/0x51 @ 1
[   17.193066] evm: HMAC attrs: 0x1
[   17.196297] initcall init_evm+0x0/0x51 returned 0 after 3154 usecs
[   17.202472] calling  prandom_reseed+0x0/0x2a @ 1
[   17.207094] initcall prandom_reseed+0x0/0x2a returned 0 after 3 usecs
[   17.213529] calling  init_error_injection+0x0/0x6a @ 1
[   17.218676] initcall init_error_injection+0x0/0x6a returned 0 after 5 usecs
[   17.225628] calling  pci_resource_alignment_sysfs_init+0x0/0x18 @ 1
[   17.231898] initcall pci_resource_alignment_sysfs_init+0x0/0x18 returned 0 after 1 usecs
[   17.239980] calling  pci_sysfs_init+0x0/0x4d @ 1
[   17.247294] initcall pci_sysfs_init+0x0/0x4d returned 0 after 2628 usecs
[   17.253998] calling  bert_init+0x0/0x216 @ 1
[   17.258267] initcall bert_init+0x0/0x216 returned 0 after 0 usecs
[   17.264362] calling  clk_debug_init+0x0/0x137 @ 1
[   17.269078] initcall clk_debug_init+0x0/0x137 returned 0 after 9 usecs
[   17.275602] calling  boot_wait_for_devices+0x0/0x28 @ 1
[   17.280827] initcall boot_wait_for_devices+0x0/0x28 returned -19 after 0 usecs
[   17.288048] calling  dmar_free_unused_resources+0x0/0xc7 @ 1
[   17.293715] initcall dmar_free_unused_resources+0x0/0xc7 returned 0 after 0 usecs
[   17.301195] calling  deferred_probe_initcall+0x0/0x30 @ 1
[   17.306596] initcall deferred_probe_initcall+0x0/0x30 returned 0 after 3 usecs
[   17.313813] calling  late_resume_init+0x0/0x1a0 @ 1
[   17.318691]   Magic number: 14:722:476
[   17.322499] initcall late_resume_init+0x0/0x1a0 returned 0 after 3718 usecs
[   17.329457] calling  rtc_hctosys+0x0/0xed @ 1
[   17.333945] rtc_cmos 00:05: setting system clock to 2018-04-10 10:29:35 UTC (1523356175)
[   17.342030] initcall rtc_hctosys+0x0/0xed returned 0 after 8024 usecs
[   17.348471] calling  charger_manager_init+0x0/0x8c @ 1
[   17.353762] initcall charger_manager_init+0x0/0x8c returned 0 after 147 usecs
[   17.360890] calling  acpi_cpufreq_init+0x0/0x28a @ 1
[   17.365862] initcall acpi_cpufreq_init+0x0/0x28a returned -17 after 0 usecs
[   17.372817] calling  powernowk8_init+0x0/0x1a0 @ 1
[   17.377607] initcall powernowk8_init+0x0/0x1a0 returned -19 after 0 usecs
[   17.384394] calling  pcc_cpufreq_init+0x0/0x4c2 @ 1
[   17.389282] initcall pcc_cpufreq_init+0x0/0x4c2 returned -19 after 9 usecs
[   17.396170] calling  centrino_init+0x0/0x28 @ 1
[   17.400695] initcall centrino_init+0x0/0x28 returned -19 after 0 usecs
[   17.407221] calling  edd_init+0x0/0x2d2 @ 1
[   17.411406] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[   17.417404] EDD information not available.
[   17.421505] initcall edd_init+0x0/0x2d2 returned -19 after 9861 usecs
[   17.427943] calling  firmware_memmap_init+0x0/0x33 @ 1
[   17.433171] initcall firmware_memmap_init+0x0/0x33 returned 0 after 85 usecs
[   17.440215] calling  register_update_efi_random_seed+0x0/0x20 @ 1
[   17.446308] initcall register_update_efi_random_seed+0x0/0x20 returned 0 after 0 usecs
[   17.454220] calling  efi_shutdown_init+0x0/0x3e @ 1
[   17.459100] initcall efi_shutdown_init+0x0/0x3e returned -19 after 0 usecs
[   17.465974] calling  pci_mmcfg_late_insert_resources+0x0/0x4b @ 1
[   17.472068] initcall pci_mmcfg_late_insert_resources+0x0/0x4b returned 0 after 0 usecs
[   17.479986] calling  tcp_congestion_default+0x0/0x18 @ 1
[   17.485300] initcall tcp_congestion_default+0x0/0x18 returned 0 after 0 usecs
[   17.492431] calling  ip_auto_config+0x0/0xf0c @ 1
[   17.497132] initcall ip_auto_config+0x0/0xf0c returned 0 after 2 usecs
[   17.503657] calling  software_resume+0x0/0x290 @ 1
[   17.508448] initcall software_resume+0x0/0x290 returned -2 after 0 usecs
[   17.515147] calling  clear_boot_tracer+0x0/0x28 @ 1
[   17.520039] initcall clear_boot_tracer+0x0/0x28 returned 0 after 0 usecs
[   17.526734] calling  clk_disable_unused+0x0/0x100 @ 1
[   17.531789] initcall clk_disable_unused+0x0/0x100 returned 0 after 0 usecs
[   17.538661] calling  regulator_init_complete+0x0/0x36 @ 1
[   17.544059] initcall regulator_init_complete+0x0/0x36 returned 0 after 0 usecs
[   17.553494] Freeing unused kernel memory: 2316K
[   17.558100] Write protecting the kernel read-only data: 18432k
[   17.564492] Freeing unused kernel memory: 2008K
[   17.569621] Freeing unused kernel memory: 376K
[   17.638811] calling  acpi_video_init+0x0/0x1000 [video] @ 174
[   17.644768] devices_kset: Moving LNXVIDEO:00 to end of list
[   17.644833] calling  acpi_wmi_init+0x0/0x1000 [wmi] @ 176
[   17.650533] initcall acpi_video_init+0x0/0x1000 [video] returned 0 after 5729 usecs
[   17.656061] devices_kset: Moving PNP0C14:00 to end of list
[   17.669375] device: 'wmi_bus-PNP0C14:00': device_add
[   17.674491] PM: Adding info for No Bus:wmi_bus-PNP0C14:00
[   17.674580] calling  e1000_init_module+0x0/0x1000 [e1000e] @ 188
[   17.674583] calling  ahci_pci_driver_init+0x0/0x1000 [ahci] @ 191
[   17.680002] device: 'F6CB5C3C-9CAE-4EBD-B577-931EA32A2CC0': device_add
[   17.686072] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[   17.692300] PM: Adding info for wmi:F6CB5C3C-9CAE-4EBD-B577-931EA32A2CC0
[   17.698916] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[   17.717734] devices_kset: Moving PNP0C14:01 to end of list
[   17.717806] devices_kset: Moving 0000:00:17.0 to end of list
[   17.723342] device: 'wmi_bus-PNP0C14:01': device_add
[   17.730112] ahci 0000:00:17.0: version 3.0
[   17.734216] PM: Adding info for No Bus:wmi_bus-PNP0C14:01
[   17.738793] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 6 ports 6 Gbps 0x3f impl SATA mode
[   17.743887] device: '86CCFD48-205E-4A77-9C48-2021CBEDE341': device_add
[   17.752234] ahci 0000:00:17.0: flags: 64bit ncq sntf pm led clo only pio slum part ems deso sadm sds apst 
[   17.758927] PM: Adding info for wmi:86CCFD48-205E-4A77-9C48-2021CBEDE341
[   17.775617] initcall acpi_wmi_init+0x0/0x1000 [wmi] returned 0 after 116857 usecs
[   17.784521] calling  mxm_wmi_init+0x0/0x1000 [mxm_wmi] @ 186
[   17.790313] initcall mxm_wmi_init+0x0/0x1000 [mxm_wmi] returned 0 after 0 usecs
[   17.828359] device: 'ata1': device_add
[   17.832205] PM: Adding info for No Bus:ata1
[   17.836459] device: 'ata1': device_add
[   17.840316] PM: Adding info for No Bus:ata1
[   17.844605] device: 'link1': device_add
[   17.848509] PM: Adding info for No Bus:link1
[   17.852835] device: 'link1': device_add
[   17.856762] PM: Adding info for No Bus:link1
[   17.861194] device: 'dev1.0': device_add
[   17.865201] PM: Adding info for No Bus:dev1.0
[   17.869633] device: 'dev1.0': device_add
[   17.873643] PM: Adding info for No Bus:dev1.0
[   17.878116] device: 'ata2': device_add
[   17.881968] PM: Adding info for No Bus:ata2
[   17.886230] device: 'ata2': device_add
[   17.890066] PM: Adding info for No Bus:ata2
[   17.894367] device: 'link2': device_add
[   17.898285] PM: Adding info for No Bus:link2
[   17.902645] device: 'link2': device_add
[   17.906560] PM: Adding info for No Bus:link2
[   17.911004] device: 'dev2.0': device_add
[   17.915018] PM: Adding info for No Bus:dev2.0
[   17.919439] device: 'dev2.0': device_add
[   17.923458] PM: Adding info for No Bus:dev2.0
[   17.927914] device: 'ata3': device_add
[   17.931757] PM: Adding info for No Bus:ata3
[   17.936039] device: 'ata3': device_add
[   17.939872] PM: Adding info for No Bus:ata3
[   17.944175] device: 'link3': device_add
[   17.948098] PM: Adding info for No Bus:link3
[   17.952433] device: 'link3': device_add
[   17.956368] PM: Adding info for No Bus:link3
[   17.960808] device: 'dev3.0': device_add
[   17.964806] PM: Adding info for No Bus:dev3.0
[   17.969237] device: 'dev3.0': device_add
[   17.973241] PM: Adding info for No Bus:dev3.0
[   17.977704] device: 'ata4': device_add
[   17.981531] PM: Adding info for No Bus:ata4
[   17.985801] device: 'ata4': device_add
[   17.989629] PM: Adding info for No Bus:ata4
[   17.993873] device: 'link4': device_add
[   17.997796] PM: Adding info for No Bus:link4
[   18.002162] device: 'link4': device_add
[   18.006087] PM: Adding info for No Bus:link4
[   18.010512] device: 'dev4.0': device_add
[   18.014544] PM: Adding info for No Bus:dev4.0
[   18.018966] device: 'dev4.0': device_add
[   18.022980] PM: Adding info for No Bus:dev4.0
[   18.027454] device: 'ata5': device_add
[   18.031293] PM: Adding info for No Bus:ata5
[   18.035538] device: 'ata5': device_add
[   18.039366] PM: Adding info for No Bus:ata5
[   18.043619] device: 'link5': device_add
[   18.047553] PM: Adding info for No Bus:link5
[   18.051901] device: 'link5': device_add
[   18.055843] PM: Adding info for No Bus:link5
[   18.060287] device: 'dev5.0': device_add
[   18.064291] PM: Adding info for No Bus:dev5.0
[   18.068731] device: 'dev5.0': device_add
[   18.072727] PM: Adding info for No Bus:dev5.0
[   18.077218] device: 'ata6': device_add
[   18.081058] PM: Adding info for No Bus:ata6
[   18.085330] device: 'ata6': device_add
[   18.089149] PM: Adding info for No Bus:ata6
[   18.093409] device: 'link6': device_add
[   18.097323] PM: Adding info for No Bus:link6
[   18.101674] device: 'link6': device_add
[   18.105598] PM: Adding info for No Bus:link6
[   18.110041] device: 'dev6.0': device_add
[   18.114048] PM: Adding info for No Bus:dev6.0
[   18.118461] device: 'dev6.0': device_add
[   18.122464] PM: Adding info for No Bus:dev6.0
[   18.127279] scsi host0: ahci
[   18.130314] device: 'host0': device_add
[   18.134244] PM: Adding info for scsi:host0
[   18.138452] device: 'host0': device_add
[   18.142389] PM: Adding info for No Bus:host0
[   18.147073] scsi host1: ahci
[   18.150023] device: 'host1': device_add
[   18.153949] PM: Adding info for scsi:host1
[   18.158140] device: 'host1': device_add
[   18.162078] PM: Adding info for No Bus:host1
[   18.166779] scsi host2: ahci
[   18.169742] device: 'host2': device_add
[   18.173658] PM: Adding info for scsi:host2
[   18.177827] device: 'host2': device_add
[   18.181768] PM: Adding info for No Bus:host2
[   18.186337] scsi host3: ahci
[   18.189280] device: 'host3': device_add
[   18.193209] PM: Adding info for scsi:host3
[   18.197387] device: 'host3': device_add
[   18.201335] PM: Adding info for No Bus:host3
[   18.205789] scsi host4: ahci
[   18.208734] device: 'host4': device_add
[   18.212674] PM: Adding info for scsi:host4
[   18.216859] device: 'host4': device_add
[   18.220784] PM: Adding info for No Bus:host4
[   18.225301] scsi host5: ahci
[   18.228266] device: 'host5': device_add
[   18.232200] PM: Adding info for scsi:host5
[   18.236369] device: 'host5': device_add
[   18.240286] PM: Adding info for No Bus:host5
[   18.244650] ata1: SATA max UDMA/133 abar m2048@0xeff4b000 port 0xeff4b100 irq 130
[   18.252274] ata2: SATA max UDMA/133 abar m2048@0xeff4b000 port 0xeff4b180 irq 130
[   18.259875] ata3: SATA max UDMA/133 abar m2048@0xeff4b000 port 0xeff4b200 irq 130
[   18.267518] ata4: SATA max UDMA/133 abar m2048@0xeff4b000 port 0xeff4b280 irq 130
[   18.275137] ata5: SATA max UDMA/133 abar m2048@0xeff4b000 port 0xeff4b300 irq 130
[   18.282753] ata6: SATA max UDMA/133 abar m2048@0xeff4b000 port 0xeff4b380 irq 130
[   18.290451] devices_kset: Moving 0000:00:1f.6 to end of list
[   18.290478] initcall ahci_pci_driver_init+0x0/0x1000 [ahci] returned 0 after 601456 usecs
[   18.296618] e1000e 0000:00:1f.6: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[   18.557675] device: 'ptp0': device_add
[   18.561532] PM: Adding info for No Bus:ptp0
[   18.565934] e1000e 0000:00:1f.6 0000:00:1f.6 (uninitialized): registered PHC clock
[   18.604721] ata3: SATA link down (SStatus 4 SControl 300)
[   18.610215] ata4: SATA link down (SStatus 4 SControl 300)
[   18.615727] ata2: SATA link down (SStatus 4 SControl 300)
[   18.621252] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   18.627552] ata5: SATA link down (SStatus 4 SControl 300)
[   18.633073] ata6: SATA link down (SStatus 4 SControl 300)
[   18.639038] ata1.00: ATA-8: ST500DM002-1BC142, JC4B, max UDMA/133
[   18.645254] ata1.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 31/32)
[   18.653547] ata1.00: configured for UDMA/133
[   18.658271] scsi 0:0:0:0: Direct-Access     ATA      ST500DM002-1BC14 JC4B PQ: 0 ANSI: 5
[   18.661367] device: 'eth0': device_add
[   18.666567] device: 'target0:0:0': device_add
[   18.670414] PM: Adding info for No Bus:eth0
[   18.674791] PM: Adding info for scsi:target0:0:0
[   18.679164] e1000e 0000:00:1f.6 eth0: (PCI Express:2.5GT/s:Width x1) 40:8d:5c:1f:f0:6f
[   18.683787] device: '0:0:0:0': device_add
[   18.691840] e1000e 0000:00:1f.6 eth0: Intel(R) PRO/1000 Network Connection
[   18.695983] PM: Adding info for scsi:0:0:0:0
[   18.703021] e1000e 0000:00:1f.6 eth0: MAC: 12, PHY: 12, PBA No: FFFFFF-0FF
[   18.707295] devices_kset: Moving 0:0:0:0 to end of list
[   18.714360] initcall e1000_init_module+0x0/0x1000 [e1000e] returned 0 after 1004169 usecs
[   18.719644] device: '0:0:0:0': device_add
[   18.732149] PM: Adding info for No Bus:0:0:0:0
[   18.732880] e1000e 0000:00:1f.6 enp0s31f6: renamed from eth0
[   18.736750] device: '0:0:0:0': device_add
[   18.736820] sd 0:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/466 GiB)
[   18.736827] sd 0:0:0:0: [sda] Write Protect is off
[   18.736827] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   18.736838] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   18.736871] device: '8:0': device_add
[   18.736893] PM: Adding info for No Bus:8:0
[   18.736926] device: 'sda': device_add
[   18.736955] PM: Adding info for No Bus:sda
[   18.742480] net eth0: renaming to enp0s31f6
[   18.766435]  sda: sda1 sda2 < sda5 >
[   18.773443] PM: Adding info for No Bus:0:0:0:0
[   18.777177] device: 'sda1': device_add
[   18.781376] device: 'sg0': device_add
[   18.785098] PM: Adding info for No Bus:sda1
[   18.789267] PM: Adding info for No Bus:sg0
[   18.793592] device: 'sda2': device_add
[   18.797204] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   18.801679] PM: Adding info for No Bus:sda2
[   18.805447] device: '0:0:0:0': device_add
[   18.809264] device: 'sda5': device_add
[   18.813462] PM: Adding info for No Bus:0:0:0:0
[   18.817625] PM: Adding info for No Bus:sda5
[   18.848093] sd 0:0:0:0: [sda] Attached SCSI disk
[   19.893675] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[   21.031950] calling  init_autofs4_fs+0x0/0x2a [autofs4] @ 1
[   21.037658] device: 'autofs': device_add
[   21.041654] PM: Adding info for No Bus:autofs
[   21.046138] initcall init_autofs4_fs+0x0/0x2a [autofs4] returned 0 after 8287 usecs
[   21.204048] systemd[1]: systemd 229 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ -LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN)
[   21.240095] systemd[1]: Detected architecture x86-64.
[   21.268147] systemd[1]: Set hostname to <jenkins-MS-7984>.
[   21.354716] random: crng init done
[   22.425282] systemd[1]: Listening on Journal Socket.
[   22.444255] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[   22.472081] systemd[1]: Listening on /dev/initctl Compatibility Named Pipe.
[   22.496036] systemd[1]: Reached target Encrypted Volumes.
[   22.516018] systemd[1]: PNFS blkmaping enablement. is not active.
[   22.536031] systemd[1]: Dependency failed for pNFS block layout mapping daemon.
[   22.560029] systemd[1]: nfs-blkmap.service: Job nfs-blkmap.service/start failed with result 'dependency'.
[   23.070047] calling  parport_default_proc_register+0x0/0x1000 [parport] @ 265
[   23.077595] initcall parport_default_proc_register+0x0/0x1000 [parport] returned 0 after 25 usecs
[   23.129250] calling  lp_init_module+0x0/0x1000 [lp] @ 265
[   23.328274] lp: driver loaded but no devices found
[   23.333184] initcall lp_init_module+0x0/0x1000 [lp] returned 0 after 193806 usecs
[   23.357688] calling  ppdev_init+0x0/0x1000 [ppdev] @ 265
[   23.364179] ppdev: user-space parallel port driver
[   23.369059] initcall ppdev_init+0x0/0x1000 [ppdev] returned 0 after 5824 usecs
[   23.441833] calling  parport_pc_init+0x0/0xf49 [parport_pc] @ 265
[   23.448099] devices_kset: Moving 00:01 to end of list
[   23.453246] parport_pc 00:01: reported by Plug and Play ACPI
[   23.459007] device: 'parport0': device_add
[   23.463218] PM: Adding info for parport:parport0
[   23.467950] devices_kset: Moving parport0 to end of list
[   23.473400] parport0: PC-style at 0x378, irq 5 [PCSPP,TRISTATE,EPP]
[   23.576107] device: 'lp0': device_add
[   23.579872] PM: Adding info for No Bus:lp0
[   23.584171] lp0: using parport0 (interrupt-driven).
[   23.589128] device: 'parport0': device_add
[   23.593328] PM: Adding info for No Bus:parport0
[   23.598027] device: 'parport_pc.956': device_add
[   23.604113] PM: Adding info for platform:parport_pc.956
[   23.610803] devices_kset: Moving parport_pc.956 to end of list
[   23.618110] device: 'parport1': device_add
[   23.622709] PM: Adding info for parport:parport1
[   23.627427] devices_kset: Moving parport1 to end of list
[   23.632889] device: 'parport1': device_unregister
[   23.637678] PM: Removing info for parport:parport1
[   23.642566] PM: Removing info for platform:parport_pc.956
[   23.648064] device: 'parport_pc.888': device_add
[   23.652777] PM: Adding info for platform:parport_pc.888
[   23.658149] devices_kset: Moving parport_pc.888 to end of list
[   23.664101] device: 'parport1': device_add
[   23.668305] PM: Adding info for parport:parport1
[   23.672994] devices_kset: Moving parport1 to end of list
[   23.678381] device: 'parport1': device_unregister
[   23.683177] PM: Removing info for parport:parport1
[   23.688099] PM: Removing info for platform:parport_pc.888
[   23.693620] device: 'parport_pc.632': device_add
[   23.698394] PM: Adding info for platform:parport_pc.632
[   23.703781] devices_kset: Moving parport_pc.632 to end of list
[   23.709755] device: 'parport1': device_add
[   23.710612] calling  init_sunrpc+0x0/0x72 [sunrpc] @ 274
[   23.713913] PM: Adding info for parport:parport1
[   23.719579] RPC: Registered named UNIX socket transport module.
[   23.723987] devices_kset: Moving parport1 to end of list
[   23.729997] RPC: Registered udp transport module.
[   23.735486] device: 'parport1': device_unregister
[   23.740197] RPC: Registered tcp transport module.
[   23.740197] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   23.740206] initcall init_sunrpc+0x0/0x72 [sunrpc] returned 0 after 20379 usecs
[   23.744988] PM: Removing info for parport:parport1
[   23.768737] PM: Removing info for platform:parport_pc.632
[   23.774301] initcall parport_pc_init+0x0/0xf49 [parport_pc] returned 0 after 318603 usecs
[   23.783165] calling  init_grace+0x0/0x1000 [grace] @ 275
[   23.789444] initcall init_grace+0x0/0x1000 [grace] returned 0 after 1 usecs
[   23.824031] calling  init_nlm+0x0/0x61 [lockd] @ 275
[   23.829106] initcall init_nlm+0x0/0x61 [lockd] returned 0 after 10 usecs
[   23.907743] calling  init_rpcsec_gss+0x0/0x1000 [auth_rpcgss] @ 275
[   23.914125] initcall init_rpcsec_gss+0x0/0x1000 [auth_rpcgss] returned 0 after 24 usecs
[   24.028161] calling  init_nfsd+0x0/0xe77 [nfsd] @ 275
[   24.033290] Installing knfsd (copyright (C) 1996 okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org).
[   24.033663] initcall init_nfsd+0x0/0xe77 [nfsd] returned 0 after 358 usecs
[   25.513995] EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro
[   25.969620] calling  mac_hid_init+0x0/0x1000 [mac_hid] @ 398
[   25.975386] initcall mac_hid_init+0x0/0x1000 [mac_hid] returned 0 after 7 usecs
[   26.071902] calling  acpi_pad_init+0x0/0x1000 [acpi_pad] @ 396
[   26.077874] devices_kset: Moving ACPI000C:00 to end of list
[   26.083620] initcall acpi_pad_init+0x0/0x1000 [acpi_pad] returned 0 after 5647 usecs
[   26.101425] calling  shpcd_init+0x0/0x1000 [shpchp] @ 376
[   26.106955] devices_kset: Moving 0000:05:00.0 to end of list
[   26.112775] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   26.119617] initcall shpcd_init+0x0/0x1000 [shpchp] returned 0 after 12399 usecs
[   26.128877] calling  init_soundcore+0x0/0x1000 [soundcore] @ 391
[   26.135012] initcall init_soundcore+0x0/0x1000 [soundcore] returned 0 after 21 usecs
[   26.182834] systemd-journald[271]: Received request to flush runtime journal from PID 1
[   26.226454] calling  alsa_sound_init+0x0/0x84 [snd] @ 422
[   26.232048] initcall alsa_sound_init+0x0/0x84 [snd] returned 0 after 81 usecs
[   26.239555] calling  mei_init+0x0/0xae [mei] @ 378
[   26.244499] initcall mei_init+0x0/0xae [mei] returned 0 after 67 usecs
[   26.251312] calling  alsa_timer_init+0x0/0x1000 [snd_timer] @ 428
[   26.257545] device: 'timer': device_add
[   26.261531] PM: Adding info for No Bus:timer
[   26.265894] initcall alsa_timer_init+0x0/0x1000 [snd_timer] returned 0 after 8159 usecs
[   26.323131] calling  cryptd_init+0x0/0x1000 [cryptd] @ 375
[   26.328746] cryptd: max_cpu_qlen set to 1000
[   26.333129] initcall cryptd_init+0x0/0x1000 [cryptd] returned 0 after 4296 usecs
[   26.363711] calling  alsa_pcm_init+0x0/0x6c [snd_pcm] @ 441
[   26.369393] initcall alsa_pcm_init+0x0/0x6c [snd_pcm] returned 0 after 8 usecs
[   26.376868] calling  alsa_seq_device_init+0x0/0x1000 [snd_seq_device] @ 428
[   26.383945] initcall alsa_seq_device_init+0x0/0x1000 [snd_seq_device] returned 0 after 36 usecs
[   26.384039] calling  mei_me_driver_init+0x0/0x1000 [mei_me] @ 378
[   26.399055] devices_kset: Moving 0000:00:16.0 to end of list
[   26.399062] initcall mei_me_driver_init+0x0/0x1000 [mei_me] returned 0 after 52 usecs
[   26.399147] calling  alsa_hwdep_init+0x0/0x1000 [snd_hwdep] @ 377
[   26.399156] initcall alsa_hwdep_init+0x0/0x1000 [snd_hwdep] returned 0 after 6 usecs
[   26.404854] mei_me 0000:00:16.0: enabling device (0000 -> 0002)
[   26.434017] calling  hda_bus_init+0x0/0x11 [snd_hda_core] @ 377
[   26.440450] initcall hda_bus_init+0x0/0x11 [snd_hda_core] returned 0 after 19 usecs
[   26.440500] device: 'mei0': device_add
[   26.446099] device: 'mei::082ee5a7-7c25-470a-9643-0c06f0466ea1:00': device_add
[   26.446130] PM: Adding info for mei:mei::082ee5a7-7c25-470a-9643-0c06f0466ea1:00
[   26.446144] device: 'mei::3c4852d6-d47b-4f46-b05e-b5edc1aa440e:01': device_add
[   26.446167] PM: Adding info for mei:mei::3c4852d6-d47b-4f46-b05e-b5edc1aa440e:01
[   26.446176] device: 'mei::5565a099-7fe2-45c1-a22b-d7e9dfea9a2e:01': device_add
[   26.446196] PM: Adding info for mei:mei::5565a099-7fe2-45c1-a22b-d7e9dfea9a2e:01
[   26.446204] device: 'mei::dba4d603-d7ed-4931-8823-17ad585705d5:01': device_add
[   26.446226] PM: Adding info for mei:mei::dba4d603-d7ed-4931-8823-17ad585705d5:01
[   26.446235] device: 'mei::f908627d-13bf-4a04-b91f-a64e9245323d:01': device_add
[   26.446255] PM: Adding info for mei:mei::f908627d-13bf-4a04-b91f-a64e9245323d:01
[   26.446263] device: 'mei::309dcde8-ccb1-4062-8f78-600115a34327:01': device_add
[   26.446282] PM: Adding info for mei:mei::309dcde8-ccb1-4062-8f78-600115a34327:01
[   26.446290] device: 'mei::8c2f4425-77d6-4755-aca3-891fdbc66a58:01': device_add
[   26.446312] PM: Adding info for mei:mei::8c2f4425-77d6-4755-aca3-891fdbc66a58:01
[   26.446320] device: 'mei::8e6a6715-9abc-4043-88ef-9e39c6f63e0f:01': device_add
[   26.446341] PM: Adding info for mei:mei::8e6a6715-9abc-4043-88ef-9e39c6f63e0f:01
[   26.446349] device: 'mei::01e88543-8050-4380-9d6f-4f9cec704917:01': device_add
[   26.446370] PM: Adding info for mei:mei::01e88543-8050-4380-9d6f-4f9cec704917:01
[   26.446378] device: 'mei::42b3ce2f-bd9f-485a-96ae-26406230b1ff:01': device_add
[   26.446398] PM: Adding info for mei:mei::42b3ce2f-bd9f-485a-96ae-26406230b1ff:01
[   26.446700] device: 'mei::55213584-9a29-4916-badf-0fb7ed682aeb:01': device_add
[   26.446722] PM: Adding info for mei:mei::55213584-9a29-4916-badf-0fb7ed682aeb:01
[   26.477239] calling  alsa_seq_init+0x0/0x4b [snd_seq] @ 445
[   26.484745] PM: Adding info for No Bus:mei0
[   26.492044] device: 'seq': device_add
[   26.633621] PM: Adding info for No Bus:seq
[   26.637891] initcall alsa_seq_init+0x0/0x4b [snd_seq] returned 0 after 142431 usecs
[   26.648889] calling  azx_driver_init+0x0/0xfd2 [snd_hda_intel] @ 377
[   26.656267] devices_kset: Moving 0000:00:1f.3 to end of list
[   26.663843] devices_kset: Moving 0000:03:00.1 to end of list
[   26.669772] snd_hda_intel 0000:03:00.1: Handle vga_switcheroo audio client
[   26.677106] initcall azx_driver_init+0x0/0xfd2 [snd_hda_intel] returned 0 after 20372 usecs
[   26.690064] device: 'hdaudioC0D0': device_add
[   26.695343] PM: Adding info for hdaudio:hdaudioC0D0
[   26.700783] device: 'hdaudioC1D0': device_add
[   26.705264] PM: Adding info for hdaudio:hdaudioC1D0
[   26.710392] calling  alsa_rawmidi_init+0x0/0x1000 [snd_rawmidi] @ 453
[   26.718260] initcall alsa_rawmidi_init+0x0/0x1000 [snd_rawmidi] returned 0 after 32 usecs
[   26.728133] calling  aes_init+0x0/0x1000 [aes_x86_64] @ 400
[   26.728178] calling  generic_driver_init+0x0/0x1000 [snd_hda_codec_generic] @ 459
[   26.735032] initcall aes_init+0x0/0x1000 [aes_x86_64] returned 0 after 39 usecs
[   26.742621] initcall generic_driver_init+0x0/0x1000 [snd_hda_codec_generic] returned 0 after 27 usecs
[   26.789665] calling  alsa_seq_midi_event_init+0x0/0x1000 [snd_seq_midi_event] @ 460
[   26.797465] initcall alsa_seq_midi_event_init+0x0/0x1000 [snd_seq_midi_event] returned 0 after 0 usecs
[   26.953729] calling  seq_midisynth_driver_init+0x0/0x1000 [snd_seq_midi] @ 460
[   26.961431] initcall seq_midisynth_driver_init+0x0/0x1000 [snd_seq_midi] returned 0 after 60 usecs
[   26.970788] calling  aesni_init+0x0/0x1ed [aesni_intel] @ 400
[   26.976682] AVX2 version of gcm_enc/dec engaged.
[   26.981414] AES CTR mode by8 optimization enabled
[   26.986493] calling  hdmi_driver_init+0x0/0x1000 [snd_hda_codec_hdmi] @ 458
[   26.993688] devices_kset: Moving hdaudioC1D0 to end of list
[   26.993754] calling  realtek_driver_init+0x0/0x1000 [snd_hda_codec_realtek] @ 459
[   27.001131] initcall hdmi_driver_init+0x0/0x1000 [snd_hda_codec_hdmi] returned 0 after 7299 usecs
[   27.006996] devices_kset: Moving hdaudioC0D0 to end of list
[   27.021720] snd_hda_codec_realtek hdaudioC0D0: ALC1150: SKU not ready 0x00000000
[   27.021830] device: 'card1': device_add
[   27.029770] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC1150: line_outs=4 (0x14/0x15/0x16/0x17/0x0) type:line
[   27.033172] PM: Adding info for No Bus:card1
[   27.044054] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   27.044055] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
[   27.048442] device: 'controlC1': device_add
[   27.056490] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
[   27.056491] snd_hda_codec_realtek hdaudioC0D0:    dig-out=0x11/0x0
[   27.064270] PM: Adding info for No Bus:controlC1
[   27.068552] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[   27.068553] snd_hda_codec_realtek hdaudioC0D0:      Front Mic=0x19
[   27.075086] device: 'pcmC1D3p': device_add
[   27.081321] snd_hda_codec_realtek hdaudioC0D0:      Rear Mic=0x18
[   27.081322] snd_hda_codec_realtek hdaudioC0D0:      Line=0x1a
[   27.093497] initcall realtek_driver_init+0x0/0x1000 [snd_hda_codec_realtek] returned 0 after 84488 usecs
[   27.097888] PM: Adding info for No Bus:pcmC1D3p
[   27.128389] device: 'card0': device_add
[   27.132378] PM: Adding info for No Bus:card0
[   27.136892] device: 'vcs2': device_add
[   27.136931] PM: Adding info for No Bus:vcs2
[   27.136943] device: 'controlC0': device_add
[   27.136993] PM: Adding info for No Bus:controlC0
[   27.137014] device: 'vcsa2': device_add
[   27.137021] device: 'pcmC1D7p': device_add
[   27.137049] PM: Adding info for No Bus:vcsa2
[   27.137075] PM: Adding info for No Bus:pcmC1D7p
[   27.137124] device: 'pcmC0D0p': device_add
[   27.175541] device: 'vcs3': device_add
[   27.175558] PM: Adding info for No Bus:pcmC0D0p
[   27.175560] calling  crypto_pcbc_module_init+0x0/0x1000 [pcbc] @ 490
[   27.175562] initcall crypto_pcbc_module_init+0x0/0x1000 [pcbc] returned 0 after 0 usecs
[   27.175578] PM: Adding info for No Bus:vcs3
[   27.175625] device: 'vcsa3': device_add
[   27.175641] PM: Adding info for No Bus:vcsa3
[   27.175826] initcall aesni_init+0x0/0x1ed [aesni_intel] returned 0 after 194472 usecs
[   27.179787] device: 'pcmC0D0c': device_add
[   27.223469] device: 'vcs4': device_add
[   27.223493] PM: Adding info for No Bus:vcs4
[   27.223524] device: 'vcsa4': device_add
[   27.223544] PM: Adding info for No Bus:vcsa4
[   27.227422] PM: Adding info for No Bus:pcmC0D0c
[   27.244642] device: 'pcmC1D8p': device_add
[   27.244690] calling  ghash_pclmulqdqni_mod_init+0x0/0x1000 [ghash_clmulni_intel] @ 374
[   27.248815] PM: Adding info for No Bus:pcmC1D8p
[   27.256969] initcall ghash_pclmulqdqni_mod_init+0x0/0x1000 [ghash_clmulni_intel] returned 0 after 85 usecs
[   27.261585] device: 'pcmC0D1p': device_add
[   27.275611] device: 'vcs5': device_add
[   27.275673] PM: Adding info for No Bus:vcs5
[   27.275678] PM: Adding info for No Bus:pcmC0D1p
[   27.275752] device: 'vcsa5': device_add
[   27.275773] device: 'pcmC1D9p': device_add
[   27.275797] PM: Adding info for No Bus:vcsa5
[   27.275814] PM: Adding info for No Bus:pcmC1D9p
[   27.275853] device: 'pcmC1D10p': device_add
[   27.296680] calling  crc32_pclmul_mod_init+0x0/0x1000 [crc32_pclmul] @ 374
[   27.301010] PM: Adding info for No Bus:pcmC1D10p
[   27.305629] initcall crc32_pclmul_mod_init+0x0/0x1000 [crc32_pclmul] returned 0 after 32 usecs
[   27.309918] device: 'pcmC0D2c': device_add
[   27.334532] PM: Adding info for No Bus:pcmC0D2c
[   27.334614] device: 'pcmC1D11p': device_add
[   27.344807] PM: Adding info for No Bus:pcmC1D11p
[   27.350876] device: 'hwC0D0': device_add
[   27.356288] device: 'vcs6': device_add
[   27.356305] PM: Adding info for No Bus:hwC0D0
[   27.356326] PM: Adding info for No Bus:vcs6
[   27.356345] device: 'input9': device_add
[   27.356366] device: 'vcsa6': device_add
[   27.356388] PM: Adding info for No Bus:vcsa6
[   27.356425] PM: Adding info for No Bus:input9
[   27.386746] device: 'hwC1D0': device_add
[   27.390840] PM: Adding info for No Bus:hwC1D0
[   27.390906] calling  crct10dif_intel_mod_init+0x0/0x1000 [crct10dif_pclmul] @ 395
[   27.395558] device: 'input3': device_add
[   27.403238] initcall crct10dif_intel_mod_init+0x0/0x1000 [crct10dif_pclmul] returned 0 after 88 usecs
[   27.407188] PM: Adding info for No Bus:input3
[   27.420931] input: HDA Intel PCH Front Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input9
[   27.420957] device: 'event3': device_add
[   27.433951] PM: Adding info for No Bus:event3
[   27.438418] input: HD-Audio Generic HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:01.0/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card1/input3
[   27.452920] device: 'input10': device_add
[   27.458420] PM: Adding info for No Bus:input10
[   27.464322] input: HDA Intel PCH Rear Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input10
[   27.474376] device: 'event4': device_add
[   27.478417] PM: Adding info for No Bus:event4
[   27.478466] device: 'input4': device_add
[   27.478546] PM: Adding info for No Bus:input4
[   27.478569] input: HD-Audio Generic HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:01.0/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card1/input4
[   27.478580] device: 'event5': device_add
[   27.478629] PM: Adding info for No Bus:event5
[   27.478675] device: 'input5': device_add
[   27.478762] PM: Adding info for No Bus:input5
[   27.478781] input: HD-Audio Generic HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:01.0/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card1/input5
[   27.478795] device: 'event6': device_add
[   27.478833] PM: Adding info for No Bus:event6
[   27.478889] device: 'event7': device_add
[   27.478929] PM: Adding info for No Bus:event7
[   27.478945] device: 'input11': device_add
[   27.478972] device: 'input6': device_add
[   27.479056] PM: Adding info for No Bus:input6
[   27.479077] input: HD-Audio Generic HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:01.0/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card1/input6
[   27.479087] device: 'event8': device_add
[   27.479129] PM: Adding info for No Bus:event8
[   27.479191] device: 'input7': device_add
[   27.479272] PM: Adding info for No Bus:input7
[   27.479296] input: HD-Audio Generic HDMI/DP,pcm=10 as /devices/pci0000:00/0000:00:01.0/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card1/input7
[   27.479308] device: 'event9': device_add
[   27.479358] PM: Adding info for No Bus:event9
[   27.479410] device: 'input8': device_add
[   27.479500] PM: Adding info for No Bus:input8
[   27.479525] input: HD-Audio Generic HDMI/DP,pcm=11 as /devices/pci0000:00/0000:00:01.0/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card1/input8
[   27.479536] device: 'event10': device_add
[   27.479576] PM: Adding info for No Bus:event10
[   27.479713] PM: Adding info for No Bus:input11
[   27.479737] input: HDA Intel PCH Line as /devices/pci0000:00/0000:00:1f.3/sound/card0/input11
[   27.479748] device: 'event11': device_add
[   27.479778] PM: Adding info for No Bus:event11
[   27.479879] device: 'input12': device_add
[   27.479933] PM: Adding info for No Bus:input12
[   27.479946] input: HDA Intel PCH Line Out Front as /devices/pci0000:00/0000:00:1f.3/sound/card0/input12
[   27.479954] device: 'event12': device_add
[   27.479975] PM: Adding info for No Bus:event12
[   27.480006] device: 'input13': device_add
[   27.480060] PM: Adding info for No Bus:input13
[   27.480072] input: HDA Intel PCH Line Out Surround as /devices/pci0000:00/0000:00:1f.3/sound/card0/input13
[   27.480078] device: 'event13': device_add
[   27.480104] PM: Adding info for No Bus:event13
[   27.480131] device: 'input14': device_add
[   27.480176] PM: Adding info for No Bus:input14
[   27.480186] input: HDA Intel PCH Line Out CLFE as /devices/pci0000:00/0000:00:1f.3/sound/card0/input14
[   27.480191] device: 'event14': device_add
[   27.480211] PM: Adding info for No Bus:event14
[   27.480245] device: 'input15': device_add
[   27.480292] PM: Adding info for No Bus:input15
[   27.480304] input: HDA Intel PCH Line Out Side as /devices/pci0000:00/0000:00:1f.3/sound/card0/input15
[   27.480310] device: 'event15': device_add
[   27.480332] PM: Adding info for No Bus:event15
[   27.480361] device: 'input16': device_add
[   27.480408] PM: Adding info for No Bus:input16
[   27.480419] input: HDA Intel PCH Front Headphone as /devices/pci0000:00/0000:00:1f.3/sound/card0/input16
[   27.480424] device: 'event16': device_add
[   27.480445] PM: Adding info for No Bus:event16
[   27.845280] calling  vmx_init+0x0/0x532 [kvm_intel] @ 395
[   27.927418] device: 'kvm': device_add
[   27.931941] PM: Adding info for No Bus:kvm
[   27.932145] initcall vmx_init+0x0/0x532 [kvm_intel] returned 0 after 5295 usecs
[   27.965771] calling  coretemp_init+0x0/0x1000 [coretemp] @ 395
[   27.971954] device: 'coretemp.0': device_add
[   27.976308] PM: Adding info for platform:coretemp.0
[   27.981292] devices_kset: Moving coretemp.0 to end of list
[   27.986894] device: 'hwmon1': device_add
[   27.990994] PM: Adding info for No Bus:hwmon1
[   27.995611] initcall coretemp_init+0x0/0x1000 [coretemp] returned 0 after 23161 usecs
[   28.413319] audit: type=1400 audit(1523356186.575:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/sbin/ippusbxd" pid=601 comm="apparmor_parser"
[   28.429158] audit: type=1400 audit(1523356186.587:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/snapd/snap-confine" pid=598 comm="apparmor_parser"
[   28.445846] audit: type=1400 audit(1523356186.587:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/snapd/snap-confine//mount-namespace-capture-helper" pid=598 comm="apparmor_parser"
[   28.514157] audit: type=1400 audit(1523356186.675:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/lightdm/lightdm-guest-session" pid=593 comm="apparmor_parser"
[   28.531724] audit: type=1400 audit(1523356186.675:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/lightdm/lightdm-guest-session//chromium" pid=593 comm="apparmor_parser"
[   28.550177] audit: type=1400 audit(1523356186.675:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/sbin/tcpdump" pid=604 comm="apparmor_parser"
[   28.565924] audit: type=1400 audit(1523356186.679:8): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/sbin/dhclient" pid=594 comm="apparmor_parser"
[   28.581429] audit: type=1400 audit(1523356186.679:9): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=594 comm="apparmor_parser"
[   28.599653] audit: type=1400 audit(1523356186.679:10): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/NetworkManager/nm-dhcp-helper" pid=594 comm="apparmor_parser"
[   28.617377] audit: type=1400 audit(1523356186.679:11): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/connman/scripts/dhclient-script" pid=594 comm="apparmor_parser"
[   28.911994] calling  powerclamp_init+0x0/0x1000 [intel_powerclamp] @ 394
[   28.918993] device: 'cooling_device13': device_add
[   28.923891] PM: Adding info for No Bus:cooling_device13
[   28.929287] initcall powerclamp_init+0x0/0x1000 [intel_powerclamp] returned 0 after 10214 usecs
[   28.939844] calling  pkg_temp_thermal_init+0x0/0x1000 [x86_pkg_temp_thermal] @ 400
[   28.947545] device: 'thermal_zone2': device_add
[   28.952377] PM: Adding info for No Bus:thermal_zone2
[   28.957543] initcall pkg_temp_thermal_init+0x0/0x1000 [x86_pkg_temp_thermal] returned 0 after 9796 usecs
[   29.059464] calling  rapl_init+0x0/0x1000 [intel_rapl] @ 374
[   29.065238] device: 'intel-rapl': device_add
[   29.069621] PM: Adding info for No Bus:intel-rapl
[   29.074405] intel_rapl: Found RAPL domain package
[   29.079179] intel_rapl: Found RAPL domain core
[   29.083686] intel_rapl: Found RAPL domain dram
[   29.088293] device: 'intel-rapl:0': device_add
[   29.092847] PM: Adding info for No Bus:intel-rapl:0
[   29.097888] device: 'intel-rapl:0:0': device_add
[   29.102624] PM: Adding info for No Bus:intel-rapl:0:0
[   29.107804] device: 'intel-rapl:0:1': device_add
[   29.112536] PM: Adding info for No Bus:intel-rapl:0:1
[   29.117815] initcall rapl_init+0x0/0x1000 [intel_rapl] returned 0 after 51362 usecs
[   31.547118] Adding 8348668k swap on /dev/sda5.  Priority:-2 extents:1 across:8348668k FS
[   33.597102] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
[   33.755309] device: 'lo': device_add
[   33.756083] NFSD: starting 90-second grace period (net f00000a1)
[   33.759456] PM: Adding info for No Bus:lo
[   33.863306] IPv6: ADDRCONF(NETDEV_UP): enp0s31f6: link is not ready
[   34.084589] IPv6: ADDRCONF(NETDEV_UP): enp0s31f6: link is not ready
[   36.907938] e1000e: enp0s31f6 NIC Link is Up 100 Mbps Full Duplex, Flow Control: Rx/Tx
[   36.915978] e1000e 0000:00:1f.6 enp0s31f6: 10/100 speed: disabling TSO
[   36.922728] IPv6: ADDRCONF(NETDEV_CHANGE): enp0s31f6: link becomes ready
[   42.108914] calling  fscache_init+0x0/0x200 [fscache] @ 1149
[   42.114888] FS-Cache: Loaded
[   42.119096] initcall fscache_init+0x0/0x200 [fscache] returned 0 after 4315 usecs
[   42.174793] calling  init_nfs_fs+0x0/0x169 [nfs] @ 1149
[   42.180161] FS-Cache: Netfs 'nfs' registered for caching
[   42.186164] initcall init_nfs_fs+0x0/0x169 [nfs] returned 0 after 5856 usecs
[   42.233006] calling  init_nfs_v4+0x0/0x37 [nfsv4] @ 1163
[   42.238423] NFS: Registering the id_resolver key type
[   42.243601] Key type id_resolver registered
[   42.247849] Key type id_legacy registered
[   42.252017] initcall init_nfs_v4+0x0/0x37 [nfsv4] returned 0 after 13263 usecs
[   42.281227] calling  init_kerberos_module+0x0/0x1000 [rpcsec_gss_krb5] @ 1171
[   42.288656] initcall init_kerberos_module+0x0/0x1000 [rpcsec_gss_krb5] returned 0 after 149 usecs
[   42.359360] device: '0:44': device_add
[   42.363254] PM: Adding info for No Bus:0:44
[   42.363449] device: '0:45': device_add
[   42.371525] PM: Adding info for No Bus:0:45
[   42.372695] device: '0:46': device_add
[   42.379759] PM: Adding info for No Bus:0:46
[   42.380392] device: '0:47': device_add
[   42.387902] PM: Adding info for No Bus:0:47
[   42.424549] device: '0:45': device_unregister
[   42.429091] PM: Removing info for No Bus:0:45
[   42.433541] device: '0:45': device_create_release
[   42.608418] device: '0:44': device_unregister
[   42.613966] PM: Removing info for No Bus:0:44
[   42.618537] device: '0:44': device_create_release
[   63.901110] PM: Removing info for No Bus:lo
[  509.638489] drm: loading out-of-tree module taints kernel.
[  509.644244] drm: module verification failed: signature and/or required key missing - tainting kernel
[  509.657327] calling  drm_core_init+0x0/0xd0 [drm] @ 1353
[  509.662754] initcall drm_core_init+0x0/0xd0 [drm] returned 0 after 34 usecs
[  509.672599] calling  drm_kms_helper_init+0x0/0x15 [drm_kms_helper] @ 1353
[  509.679526] initcall drm_kms_helper_init+0x0/0x15 [drm_kms_helper] returned 0 after 0 usecs
[  509.689650] calling  ttm_init+0x0/0x1000 [ttm] @ 1353
[  509.694865] device: 'ttm': device_add
[  509.698676] PM: Adding info for No Bus:ttm
[  509.702868] initcall ttm_init+0x0/0x1000 [ttm] returned 0 after 7832 usecs
[  509.710568] calling  drm_sched_fence_slab_init+0x0/0xec9 [gpu_sched] @ 1353
[  509.717675] initcall drm_sched_fence_slab_init+0x0/0xec9 [gpu_sched] returned 0 after 6 usecs
[  509.760632] calling  amdgpu_init+0x0/0x82 [amdgpu] @ 1353
[  509.766157] [drm] amdgpu kernel modesetting enabled.
[  509.771276] devices_kset: Moving 0000:03:00.0 to end of list
[  509.777078] checking generic (d0000000 7f0000) vs hw (d0000000 10000000)
[  509.783911] fb: switching to amdgpudrmfb from VESA VGA
[  509.789388] Console: switching to colour dummy device 80x25
[  509.795084] device: 'fb0': device_unregister
[  509.799533] PM: Removing info for No Bus:fb0
[  509.803975] device: 'fb0': device_create_release
[  509.808708] device: 'vtcon1': device_unregister
[  509.810455] device: 'renderD128': device_add
[  509.813347] PM: Removing info for No Bus:vtcon1
[  509.817747] PM: Adding info for No Bus:renderD128
[  509.822336] device: 'vtcon1': device_create_release
[  509.827328] device: 'card0': device_add
[  509.836079] PM: Adding info for No Bus:card0
[  509.840599] [drm] initializing kernel modesetting (VEGA10 0x1002:0x6868 0x1002:0x0A0C 0x00).
[  509.849287] [drm] register mmio base: 0xEFC00000
[  509.853998] [drm] register mmio size: 524288
[  509.858380] [drm] probing gen 2 caps for device 1022:1471 = 700d03/e
[  509.864895] [drm] probing mlw for device 1022:1471 = 700d03
[  509.870554] [drm] add ip block number 0 <soc15_common>
[  509.875795] [drm] add ip block number 1 <gmc_v9_0>
[  509.880702] [drm] add ip block number 2 <vega10_ih>
[  509.885693] [drm] add ip block number 3 <psp>
[  509.890157] [drm] add ip block number 4 <powerplay>
[  509.895115] [drm] add ip block number 5 <gfx_v9_0>
[  509.900011] [drm] add ip block number 6 <sdma_v4_0>
[  509.904995] [drm] add ip block number 7 <uvd_v7_0>
[  509.909899] [drm] add ip block number 8 <vce_v4_0>
[  509.953438] [drm:amdgpu_device_init [amdgpu]] *ERROR* disabled ip block: 7 <uvd_v7_0>
[  509.961426] [drm:amdgpu_device_init [amdgpu]] *ERROR* disabled ip block: 8 <vce_v4_0>
[  509.969419] amdgpu 0000:03:00.0: Invalid PCI ROM header signature: expecting 0xaa55, got 0xffff
[  509.978297] ATOM BIOS: 113-D0511100-004
[  509.982379] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, fragment size is 9-bit
[  509.991101] amdgpu 0000:03:00.0: VRAM: 8176M 0x000000F400000000 - 0x000000F5FEFFFFFF (8176M used)
[  510.000181] amdgpu 0000:03:00.0: GTT: 512M 0x000000F600000000 - 0x000000F61FFFFFFF
[  510.007920] Ray: stolen_size (7e9000)
[  510.011678] [drm] Detected VRAM RAM=8176M, BAR=256M
[  510.016630] [drm] RAM width 2048bits HBM
[  510.020858] [TTM] Zone  kernel: Available graphics memory: 503052 kiB
[  510.027415] [TTM] Initializing pool allocator
[  510.031873] [TTM] Initializing DMA pool allocator
[  510.036770] [drm] amdgpu: 8176M of VRAM memory ready
[  510.041826] [drm] amdgpu: 736M of GTT memory ready.
[  510.046869] [drm] GART: num cpu pages 131072, num gpu pages 131072
[  510.053337] [drm] PCIE GART of 512M enabled (table at 0x000000F4007E9000).
[  510.060449] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[  510.067191] [drm] Driver supports precise vblank timestamp query.
[  510.159034] [drm] use_doorbell being set to: [true]
[  510.164514] [drm] use_doorbell being set to: [true]
[  510.594077] device: 'hwmon2': device_add
[  510.598155] PM: Adding info for No Bus:hwmon2
[  510.602889] amdgpu 0000:03:00.0: ring 0(gfx) uses VM inv eng 4 on hub 0
[  510.609640] amdgpu 0000:03:00.0: ring 1(comp_1.0.0) uses VM inv eng 5 on hub 0
[  510.617038] amdgpu 0000:03:00.0: ring 2(comp_1.1.0) uses VM inv eng 6 on hub 0
[  510.624371] amdgpu 0000:03:00.0: ring 3(comp_1.2.0) uses VM inv eng 7 on hub 0
[  510.631755] amdgpu 0000:03:00.0: ring 4(comp_1.3.0) uses VM inv eng 8 on hub 0
[  510.639103] amdgpu 0000:03:00.0: ring 5(comp_1.0.1) uses VM inv eng 9 on hub 0
[  510.646478] amdgpu 0000:03:00.0: ring 6(comp_1.1.1) uses VM inv eng 10 on hub 0
[  510.653959] amdgpu 0000:03:00.0: ring 7(comp_1.2.1) uses VM inv eng 11 on hub 0
[  510.661421] amdgpu 0000:03:00.0: ring 8(comp_1.3.1) uses VM inv eng 12 on hub 0
[  510.668909] amdgpu 0000:03:00.0: ring 9(kiq_2.1.0) uses VM inv eng 13 on hub 0
[  510.676268] amdgpu 0000:03:00.0: ring 10(sdma0) uses VM inv eng 4 on hub 1
[  510.683287] amdgpu 0000:03:00.0: ring 11(sdma1) uses VM inv eng 5 on hub 1
[  510.690386] [drm] ECC is active.
[  510.694065] [drm] Initialized amdgpu 3.25.0 20150101 for 0000:03:00.0 on minor 0
[  510.701765] initcall amdgpu_init+0x0/0x82 [amdgpu] returned 0 after 913681 usecs
[  541.341753] device: 'vcs63': device_add
[  541.341833] PM: Adding info for No Bus:vcs63
[  541.342065] device: 'vcsa63': device_add
[  541.342172] PM: Adding info for No Bus:vcsa63
[  541.717487] PM: suspend entry (deep)
[  541.721262] PM: Syncing filesystems ... done.
[  541.866408] Freezing user space processes ... (elapsed 0.001 seconds) done.
[  541.874934] OOM killer disabled.
[  541.878210] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
[  541.887257] calling  coretemp.0+ @ 1410, parent: platform
[  541.892734] coretemp coretemp.0: bus suspend
[  541.897066] call coretemp.0+ returned 0 after 4232 usecs
[  541.902467] calling  input16+ @ 1410, parent: card0
[  541.907465] input input16: type suspend
[  541.911366] call input16+ returned 0 after 3809 usecs
[  541.916532] calling  input15+ @ 1410, parent: card0
[  541.921514] input input15: type suspend
[  541.925413] call input15+ returned 0 after 3808 usecs
[  541.930579] calling  input14+ @ 1410, parent: card0
[  541.935555] input input14: type suspend
[  541.939498] call input14+ returned 0 after 3850 usecs
[  541.944647] calling  input13+ @ 1410, parent: card0
[  541.949630] input input13: type suspend
[  541.953562] call input13+ returned 0 after 3840 usecs
[  541.958737] calling  input12+ @ 1410, parent: card0
[  541.963711] input input12: type suspend
[  541.967638] call input12+ returned 0 after 3834 usecs
[  541.972778] calling  input11+ @ 1410, parent: card0
[  541.977769] input input11: type suspend
[  541.981679] call input11+ returned 0 after 3818 usecs
[  541.986845] calling  input8+ @ 1410, parent: card1
[  541.991732] input input8: type suspend
[  541.995563] call input8+ returned 0 after 3741 usecs
[  542.000631] calling  input7+ @ 1410, parent: card1
[  542.005519] input input7: type suspend
[  542.009326] call input7+ returned 0 after 3717 usecs
[  542.014387] calling  input6+ @ 1410, parent: card1
[  542.019258] input input6: type suspend
[  542.023105] call input6+ returned 0 after 3757 usecs
[  542.028193] calling  input5+ @ 1410, parent: card1
[  542.033081] input input5: type suspend
[  542.036918] call input5+ returned 0 after 3747 usecs
[  542.041954] calling  input4+ @ 1410, parent: card1
[  542.046851] input input4: type suspend
[  542.050674] call input4+ returned 0 after 3733 usecs
[  542.055743] calling  input10+ @ 1410, parent: card0
[  542.060710] input input10: type suspend
[  542.064617] call input10+ returned 0 after 3815 usecs
[  542.069741] calling  input3+ @ 1410, parent: card1
[  542.074628] input input3: type suspend
[  542.078442] call input3+ returned 0 after 3724 usecs
[  542.083504] calling  input9+ @ 1410, parent: card0
[  542.088382] input input9: type suspend
[  542.092231] call input9+ returned 0 after 3759 usecs
[  542.097318] calling  hdaudioC0D0+ @ 1766, parent: 0000:00:1f.3
[  542.097322] calling  hdaudioC1D0+ @ 5, parent: 0000:03:00.1
[  542.097362] calling  0:0:0:0+ @ 207, parent: target0:0:0
[  542.097363] sd 0:0:0:0: bus suspend
[  542.097372] calling  microcode+ @ 1410, parent: platform
[  542.097373] platform microcode: bus suspend
[  542.097374] call microcode+ returned 0 after 0 usecs
[  542.097377] calling  rtc0+ @ 1410, parent: 00:05
[  542.097377] rtc rtc0: class suspend
[  542.097378] call rtc0+ returned 0 after 1 usecs
[  542.097465] calling  Fixed MDIO bus.0+ @ 1410, parent: platform
[  542.097466] platform Fixed MDIO bus.0: bus suspend
[  542.097466] call Fixed MDIO bus.0+ returned 0 after 0 usecs
[  542.097509] calling  serial8250+ @ 1410, parent: platform
[  542.097509] serial8250 serial8250: bus suspend
[  542.097510] call serial8250+ returned 0 after 1 usecs
[  542.097528] calling  input2+ @ 1410, parent: LNXPWRBN:00
[  542.097528] input input2: type suspend
[  542.097529] call input2+ returned 0 after 0 usecs
[  542.097529] calling  input1+ @ 1410, parent: PNP0C0C:00
[  542.097530] input input1: type suspend
[  542.097530] call input1+ returned 0 after 0 usecs
[  542.097531] calling  input0+ @ 1410, parent: PNP0C0E:00
[  542.097531] input input0: type suspend
[  542.097531] call input0+ returned 0 after 0 usecs
[  542.097554] calling  alarmtimer+ @ 1410, parent: platform
[  542.097554] alarmtimer alarmtimer: bus suspend
[  542.097555] call alarmtimer+ returned 0 after 0 usecs
[  542.097556] calling  vesa-framebuffer.0+ @ 1410, parent: platform
[  542.097557] vesa-framebuffer vesa-framebuffer.0: bus suspend
[  542.097557] call vesa-framebuffer.0+ returned 0 after 0 usecs
[  542.097558] calling  pcspkr+ @ 1410, parent: platform
[  542.097558] platform pcspkr: bus suspend
[  542.097571] call pcspkr+ returned 0 after 0 usecs
[  542.097587] calling  00:0a+ @ 1410, parent: pnp0
[  542.097588] system 00:0a: bus suspend
[  542.097589] call 00:0a+ returned 0 after 1 usecs
[  542.097589] calling  00:09+ @ 1410, parent: pnp0
[  542.097589] system 00:09: bus suspend
[  542.097590] call 00:09+ returned 0 after 0 usecs
[  542.097590] calling  00:08+ @ 1410, parent: pnp0
[  542.097591] system 00:08: bus suspend
[  542.097591] call 00:08+ returned 0 after 0 usecs
[  542.097591] calling  00:07+ @ 1410, parent: pnp0
[  542.097592] system 00:07: bus suspend
[  542.097592] call 00:07+ returned 0 after 0 usecs
[  542.097593] calling  00:06+ @ 1410, parent: pnp0
[  542.097593] system 00:06: bus suspend
[  542.097593] call 00:06+ returned 0 after 0 usecs
[  542.097594] calling  00:05+ @ 1410, parent: pnp0
[  542.097594] rtc_cmos 00:05: bus suspend, may wakeup
[  542.097641] calling  host5+ @ 1767, parent: ata6
[  542.097642] scsi host5: bus suspend
[  542.097643] call host5+ returned 0 after 1 usecs
[  542.097645] calling  host4+ @ 1767, parent: ata5
[  542.097645] scsi host4: bus suspend
[  542.097645] call host4+ returned 0 after 0 usecs
[  542.097647] calling  host3+ @ 1767, parent: ata4
[  542.097647] scsi host3: bus suspend
[  542.097648] call host3+ returned 0 after 0 usecs
[  542.097667] calling  host2+ @ 1767, parent: ata3
[  542.097667] scsi host2: bus suspend
[  542.097668] call host2+ returned 0 after 0 usecs
[  542.097669] calling  host1+ @ 1767, parent: ata2
[  542.097670] scsi host1: bus suspend
[  542.097670] call host1+ returned 0 after 0 usecs
[  542.097726] calling  ata6+ @ 1768, parent: 0000:00:17.0
[  542.097727]  ata6: type suspend
[  542.097759] call 00:05+ returned 0 after 160 usecs
[  542.097760] calling  00:04+ @ 1410, parent: pnp0
[  542.097760] system 00:04: bus suspend
[  542.097760] call 00:04+ returned 0 after 0 usecs
[  542.097761] calling  00:03+ @ 1410, parent: pnp0
[  542.097761] system 00:03: bus suspend
[  542.097762] call 00:03+ returned 0 after 0 usecs
[  542.097762] calling  00:02+ @ 1410, parent: pnp0
[  542.097763] serial 00:02: bus suspend
[  542.097770] call 00:02+ returned 0 after 7 usecs
[  542.097771] calling  00:01+ @ 1410, parent: pnp0
[  542.097771] parport_pc 00:01: bus suspend
[  542.097773] calling  ata5+ @ 1769, parent: 0000:00:17.0
[  542.097774]  ata5: type suspend
[  542.097780] call ata6+ returned 0 after 52 usecs
[  542.097784] calling  ata4+ @ 1768, parent: 0000:00:17.0
[  542.097785]  ata4: type suspend
[  542.097809] call ata5+ returned 0 after 34 usecs
[  542.097811] calling  ata3+ @ 1769, parent: 0000:00:17.0
[  542.097811]  ata3: type suspend
[  542.097836] calling  ata2+ @ 1770, parent: 0000:00:17.0
[  542.097837]  ata2: type suspend
[  542.097843] call ata3+ returned 0 after 31 usecs
[  542.097857] call ata4+ returned 0 after 71 usecs
[  542.097867] calling  usb4+ @ 1768, parent: 0000:08:00.0
[  542.097868] usb usb4: type suspend
[  542.097873] call ata2+ returned 0 after 34 usecs
[  542.097874] calling  usb3+ @ 1771, parent: 0000:08:00.0
[  542.097875] usb usb3: type suspend
[  542.097884] calling  usb2+ @ 1770, parent: 0000:00:14.0
[  542.097884] usb usb2: type suspend
[  542.097935] call usb4+ returned 0 after 65 usecs
[  542.097946] calling  usb1+ @ 1772, parent: 0000:00:14.0
[  542.097947] usb usb1: type suspend
[  542.097957] call usb3+ returned 0 after 80 usecs
[  542.098099] call usb2+ returned 0 after 209 usecs
[  542.098191] call usb1+ returned 0 after 239 usecs
[  542.098503] parport_pc 00:01: disabled
[  542.098504] call 00:01+ returned 0 after 715 usecs
[  542.098505] calling  00:00+ @ 1410, parent: pnp0
[  542.098505] system 00:00: bus suspend
[  542.098506] call 00:00+ returned 0 after 0 usecs
[  542.098508] calling  LNXPWRBN:00+ @ 1410, parent: LNXSYSTM:00
[  542.098509] button LNXPWRBN:00: driver suspend, may wakeup
[  542.098510] call LNXPWRBN:00+ returned 0 after 0 usecs
[  542.098510] calling  PNP0C0B:04+ @ 1410, parent: platform
[  542.098511] acpi-fan PNP0C0B:04: power domain suspend
[  542.098511] call PNP0C0B:04+ returned 0 after 0 usecs
[  542.098512] calling  PNP0C0B:03+ @ 1410, parent: platform
[  542.098512] acpi-fan PNP0C0B:03: power domain suspend
[  542.098513] call PNP0C0B:03+ returned 0 after 0 usecs
[  542.098513] calling  PNP0C0B:02+ @ 1410, parent: platform
[  542.098514] acpi-fan PNP0C0B:02: power domain suspend
[  542.098514] call PNP0C0B:02+ returned 0 after 0 usecs
[  542.098514] calling  PNP0C0B:01+ @ 1410, parent: platform
[  542.098515] acpi-fan PNP0C0B:01: power domain suspend
[  542.098515] call PNP0C0B:01+ returned 0 after 0 usecs
[  542.098516] calling  PNP0C0B:00+ @ 1410, parent: platform
[  542.098516] acpi-fan PNP0C0B:00: power domain suspend
[  542.098516] call PNP0C0B:00+ returned 0 after 0 usecs
[  542.098517] calling  PNP0C0C:00+ @ 1410, parent: platform
[  542.098518] platform PNP0C0C:00: bus suspend
[  542.098518] call PNP0C0C:00+ returned 0 after 0 usecs
[  542.098518] calling  INT33A1:00+ @ 1410, parent: platform
[  542.098519] platform INT33A1:00: bus suspend
[  542.098519] call INT33A1:00+ returned 0 after 0 usecs
[  542.098520] calling  PNP0C14:01+ @ 1410, parent: platform
[  542.098520] acpi-wmi PNP0C14:01: power domain suspend
[  542.098520] call PNP0C14:01+ returned 0 after 0 usecs
[  542.098521] calling  PNP0C0E:00+ @ 1410, parent: platform
[  542.098521] platform PNP0C0E:00: bus suspend
[  542.098522] call PNP0C0E:00+ returned 0 after 0 usecs
[  542.098522] calling  ACPI000C:00+ @ 1410, parent: platform
[  542.098523] platform ACPI000C:00: bus suspend
[  542.098523] call ACPI000C:00+ returned 0 after 0 usecs
[  542.098523] calling  PNP0C14:00+ @ 1410, parent: pci0000:00
[  542.098524] acpi-wmi PNP0C14:00: power domain suspend
[  542.098524] call PNP0C14:00+ returned 0 after 0 usecs
[  542.098525] calling  PNP0C04:00+ @ 1410, parent: 0000:00:1f.0
[  542.098525] platform PNP0C04:00: bus suspend
[  542.098525] call PNP0C04:00+ returned 0 after 0 usecs
[  542.098526] calling  PNP0103:00+ @ 1410, parent: 0000:00:1f.0
[  542.098526] platform PNP0103:00: bus suspend
[  542.098527] call PNP0103:00+ returned 0 after 0 usecs
[  542.098527] calling  INT0800:00+ @ 1410, parent: 0000:00:1f.0
[  542.098527] platform INT0800:00: bus suspend
[  542.098528] call INT0800:00+ returned 0 after 0 usecs
[  542.098533] calling  0000:08:00.0+ @ 1772, parent: 0000:00:1c.0
[  542.098534] xhci_hcd 0000:08:00.0: bus suspend, may wakeup
[  542.098536] calling  0000:05:00.0+ @ 1770, parent: 0000:00:1b.2
[  542.098537] pci 0000:05:00.0: bus suspend
[  542.098537] call 0000:05:00.0+ returned 0 after 1 usecs
[  542.098561] calling  LNXTHERM:01+ @ 1410, parent: LNXSYBUS:01
[  542.098561] thermal LNXTHERM:01: driver suspend
[  542.098562] call LNXTHERM:01+ returned 0 after 1 usecs
[  542.098563] calling  LNXTHERM:00+ @ 1410, parent: LNXSYBUS:01
[  542.098563] thermal LNXTHERM:00: driver suspend
[  542.098564] call LNXTHERM:00+ returned 0 after 0 usecs
[  542.098568] calling  PNP0C0C:00+ @ 1410, parent: LNXSYBUS:00
[  542.098569] button PNP0C0C:00: driver suspend, may wakeup
[  542.098569] call PNP0C0C:00+ returned 0 after 0 usecs
[  542.098571] calling  PNP0C0E:00+ @ 1410, parent: LNXSYBUS:00
[  542.098571] button PNP0C0E:00: driver suspend, may wakeup
[  542.098571] call PNP0C0E:00+ returned 0 after 0 usecs
[  542.098631] calling  reg-dummy+ @ 1410, parent: platform
[  542.098631] reg-dummy reg-dummy: bus suspend
[  542.098632] call reg-dummy+ returned 0 after 0 usecs
[  542.098648] calling  0000:00:1f.6+ @ 1773, parent: pci0000:00
[  542.098649] e1000e 0000:00:1f.6: bus suspend, may wakeup
[  542.098661] e1000e: EEE TX LPI TIMER: 00000011
[  542.098692] calling  0000:00:1f.4+ @ 1775, parent: pci0000:00
[  542.098692] pci 0000:00:1f.4: bus suspend
[  542.098693] call 0000:00:1f.4+ returned 0 after 0 usecs
[  542.098743] calling  0000:00:1f.2+ @ 1776, parent: pci0000:00
[  542.098744] pci 0000:00:1f.2: bus suspend
[  542.098745] call 0000:00:1f.2+ returned 0 after 1 usecs
[  542.098748] calling  0000:00:1f.0+ @ 1776, parent: pci0000:00
[  542.098749] pci 0000:00:1f.0: bus suspend
[  542.098749] call 0000:00:1f.0+ returned 0 after 0 usecs
[  542.098751] calling  0000:00:1d.0+ @ 1776, parent: pci0000:00
[  542.098752] pcieport 0000:00:1d.0: bus suspend
[  542.098756] call 0000:00:1d.0+ returned 0 after 4 usecs
[  542.098758] calling  0000:00:1c.4+ @ 1776, parent: pci0000:00
[  542.098759] pcieport 0000:00:1c.4: bus suspend
[  542.098763] call 0000:00:1c.4+ returned 0 after 3 usecs
[  542.098778] calling  0000:00:1b.3+ @ 1778, parent: pci0000:00
[  542.098779] pcieport 0000:00:1b.3: bus suspend
[  542.098783] call 0000:00:1b.3+ returned 0 after 3 usecs
[  542.098785] calling  0000:00:1b.2+ @ 1778, parent: pci0000:00
[  542.098786] pcieport 0000:00:1b.2: bus suspend
[  542.098786] call 0000:00:1b.2+ returned 0 after 0 usecs
[  542.098789] calling  0000:00:1b.0+ @ 1778, parent: pci0000:00
[  542.098789] pcieport 0000:00:1b.0: bus suspend
[  542.098793] call 0000:00:1b.0+ returned 0 after 3 usecs
[  542.098810] calling  0000:00:16.0+ @ 1779, parent: pci0000:00
[  542.098811] mei_me 0000:00:16.0: power domain suspend
[  542.098835] calling  0000:00:14.0+ @ 1780, parent: pci0000:00
[  542.098835] xhci_hcd 0000:00:14.0: bus suspend, may wakeup
[  542.098891] calling  0000:00:00.0+ @ 1782, parent: pci0000:00
[  542.098892] skl_uncore 0000:00:00.0: bus suspend
[  542.098893] call 0000:00:00.0+ returned 0 after 1 usecs
[  542.098959] call 0000:00:14.0+ returned 0 after 121 usecs
[  542.099400] call 0000:08:00.0+ returned 0 after 845 usecs
[  542.099402] calling  0000:00:1c.0+ @ 1776, parent: pci0000:00
[  542.099402] pcieport 0000:00:1c.0: bus suspend
[  542.099403] call 0000:00:1c.0+ returned 0 after 0 usecs
[  542.103321] snd_hda_codec_realtek hdaudioC0D0: driver suspend
[  542.108985] snd_hda_codec_hdmi hdaudioC1D0: driver suspend
[  542.109526] PM: Removing info for mei:mei::082ee5a7-7c25-470a-9643-0c06f0466ea1:00
[  542.109565] PM: Removing info for mei:mei::3c4852d6-d47b-4f46-b05e-b5edc1aa440e:01
[  542.109587] PM: Removing info for mei:mei::5565a099-7fe2-45c1-a22b-d7e9dfea9a2e:01
[  542.109608] PM: Removing info for mei:mei::dba4d603-d7ed-4931-8823-17ad585705d5:01
[  542.109626] PM: Removing info for mei:mei::f908627d-13bf-4a04-b91f-a64e9245323d:01
[  542.109644] PM: Removing info for mei:mei::309dcde8-ccb1-4062-8f78-600115a34327:01
[  542.109664] PM: Removing info for mei:mei::8c2f4425-77d6-4755-aca3-891fdbc66a58:01
[  542.109683] PM: Removing info for mei:mei::8e6a6715-9abc-4043-88ef-9e39c6f63e0f:01
[  542.109701] PM: Removing info for mei:mei::01e88543-8050-4380-9d6f-4f9cec704917:01
[  542.109718] PM: Removing info for mei:mei::42b3ce2f-bd9f-485a-96ae-26406230b1ff:01
[  542.109737] PM: Removing info for mei:mei::55213584-9a29-4916-badf-0fb7ed682aeb:01
[  542.109903] call 0000:00:16.0+ returned 0 after 10831 usecs
[  542.134616] call hdaudioC0D0+ returned 0 after 30561 usecs
[  542.137531] call hdaudioC1D0+ returned 0 after 27876 usecs
[  542.141080] calling  0000:00:1f.3+ @ 1775, parent: pci0000:00
[  542.145717] calling  0000:03:00.1+ @ 1768, parent: 0000:02:00.0
[  542.151741] snd_hda_intel 0000:00:1f.3: bus suspend
[  542.156767] snd_hda_intel 0000:03:00.1: bus suspend
[  542.158218] call 0000:00:1f.6+ returned 0 after 58173 usecs
[  542.163542] call 0000:00:1f.3+ returned 0 after 11524 usecs
[  542.167921] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[  542.167947] call 0000:03:00.1+ returned 0 after 10918 usecs
[  542.167952] calling  0000:03:00.0+ @ 1771, parent: 0000:02:00.0
[  542.167953] amdgpu 0000:03:00.0: bus suspend
[  543.318936] call 0000:03:00.0+ returned 0 after 1123996 usecs
[  543.324817] calling  0000:02:00.0+ @ 1770, parent: 0000:01:00.0
[  543.324824] sd 0:0:0:0: [sda] Stopping disk
[  543.330835] pcieport 0000:02:00.0: bus suspend
[  543.330836] call 0000:02:00.0+ returned 0 after 1 usecs
[  543.330862] calling  0000:01:00.0+ @ 1774, parent: 0000:00:01.0
[  543.351046] pcieport 0000:01:00.0: bus suspend
[  543.355587] call 0000:01:00.0+ returned 0 after 4435 usecs
[  543.361288] calling  0000:00:01.0+ @ 1781, parent: pci0000:00
[  543.367136] pcieport 0000:00:01.0: bus suspend
[  543.371691] call 0000:00:01.0+ returned 0 after 4449 usecs
[  543.614449] call 0:0:0:0+ returned 0 after 1481530 usecs
[  543.619925] calling  target0:0:0+ @ 1260, parent: host0
[  543.625243] scsi target0:0:0: bus suspend
[  543.629311] call target0:0:0+ returned 0 after 3974 usecs
[  543.634844] calling  host0+ @ 1767, parent: ata1
[  543.639649] scsi host0: bus suspend
[  543.643185] call host0+ returned 0 after 3454 usecs
[  543.648154] calling  ata1+ @ 1769, parent: 0000:00:17.0
[  543.653477]  ata1: type suspend
[  543.656716] call ata1+ returned 0 after 3163 usecs
[  543.661603] calling  0000:00:17.0+ @ 1778, parent: pci0000:00
[  543.667428] ahci 0000:00:17.0: bus suspend
[  543.671595] call 0000:00:17.0+ returned 0 after 4071 usecs
[  543.677579] calling  0000:03:00.1+ @ 1769, parent: 0000:02:00.0
[  543.677597] calling  PNP0C0B:04+ @ 1410, parent: platform
[  543.683624] snd_hda_intel 0000:03:00.1: late bus suspend
[  543.683626] call 0000:03:00.1+ returned 0 after 2 usecs
[  543.699778] acpi-fan PNP0C0B:04: late power domain suspend
[  543.705323] call PNP0C0B:04+ returned 0 after 5416 usecs
[  543.710662] calling  PNP0C0B:03+ @ 1410, parent: platform
[  543.716198] acpi-fan PNP0C0B:03: late power domain suspend
[  543.721773] call PNP0C0B:03+ returned 0 after 5444 usecs
[  543.727206] calling  PNP0C0B:02+ @ 1410, parent: platform
[  543.732745] acpi-fan PNP0C0B:02: late power domain suspend
[  543.738320] call PNP0C0B:02+ returned 0 after 5444 usecs
[  543.743734] calling  PNP0C0B:01+ @ 1410, parent: platform
[  543.749254] acpi-fan PNP0C0B:01: late power domain suspend
[  543.754847] call PNP0C0B:01+ returned 0 after 5462 usecs
[  543.760244] calling  PNP0C0B:00+ @ 1410, parent: platform
[  543.765771] acpi-fan PNP0C0B:00: late power domain suspend
[  543.771356] call PNP0C0B:00+ returned 0 after 5453 usecs
[  543.776787] calling  PNP0C14:01+ @ 1410, parent: platform
[  543.782291] acpi-wmi PNP0C14:01: late power domain suspend
[  543.787890] call PNP0C14:01+ returned 0 after 5468 usecs
[  543.793290] calling  PNP0C14:00+ @ 1410, parent: pci0000:00
[  543.798965] acpi-wmi PNP0C14:00: late power domain suspend
[  543.804572] call PNP0C14:00+ returned 0 after 5475 usecs
[  543.810032] calling  0000:08:00.0+ @ 1769, parent: 0000:00:1c.0
[  543.810056] calling  0000:05:00.0+ @ 1782, parent: 0000:00:1b.2
[  543.810062] calling  0000:03:00.0+ @ 1778, parent: 0000:02:00.0
[  543.810078] amdgpu 0000:03:00.0: late bus suspend
[  543.810083] call 0000:03:00.0+ returned 0 after 19 usecs
[  543.810086] calling  0000:02:00.0+ @ 1767, parent: 0000:01:00.0
[  543.810088] pcieport 0000:02:00.0: late bus suspend
[  543.810089] call 0000:02:00.0+ returned 0 after 1 usecs
[  543.810089] calling  0000:00:1f.6+ @ 1260, parent: pci0000:00
[  543.810090] e1000e 0000:00:1f.6: late bus suspend, may wakeup
[  543.810091] call 0000:00:1f.6+ returned 0 after 1 usecs
[  543.810092] calling  0000:01:00.0+ @ 1778, parent: 0000:00:01.0
[  543.810092] pcieport 0000:01:00.0: late bus suspend
[  543.810093] calling  0000:00:1f.4+ @ 207, parent: pci0000:00
[  543.810094] call 0000:01:00.0+ returned 0 after 1 usecs
[  543.810094] calling  0000:00:1f.3+ @ 1767, parent: pci0000:00
[  543.810095] calling  0000:00:1f.2+ @ 1260, parent: pci0000:00
[  543.810095] pci 0000:00:1f.4: late bus suspend
[  543.810096] snd_hda_intel 0000:00:1f.3: late bus suspend
[  543.810096] pci 0000:00:1f.2: late bus suspend
[  543.810097] calling  0000:00:1f.0+ @ 1778, parent: pci0000:00
[  543.810097] call 0000:00:1f.4+ returned 0 after 2 usecs
[  543.810098] call 0000:00:1f.3+ returned 0 after 1 usecs
[  543.810098] call 0000:00:1f.2+ returned 0 after 1 usecs
[  543.810099] pci 0000:00:1f.0: late bus suspend
[  543.810099] calling  0000:00:1d.0+ @ 1781, parent: pci0000:00
[  543.810100] call 0000:00:1f.0+ returned 0 after 1 usecs
[  543.810100] calling  0000:00:1c.4+ @ 207, parent: pci0000:00
[  543.810101] pcieport 0000:00:1d.0: late bus suspend
[  543.810101] calling  0000:00:1b.3+ @ 1260, parent: pci0000:00
[  543.810102] pcieport 0000:00:1c.4: late bus suspend
[  543.810102] call 0000:00:1d.0+ returned 0 after 1 usecs
[  543.810102] pcieport 0000:00:1b.3: late bus suspend
[  543.810103] call 0000:00:1c.4+ returned 0 after 1 usecs
[  543.810103] call 0000:00:1b.3+ returned 0 after 1 usecs
[  543.810104] calling  0000:00:1b.0+ @ 1774, parent: pci0000:00
[  543.810104] calling  0000:00:17.0+ @ 1781, parent: pci0000:00
[  543.810105] pcieport 0000:00:1b.0: late bus suspend
[  543.810105] calling  0000:00:16.0+ @ 207, parent: pci0000:00
[  543.810106] ahci 0000:00:17.0: late bus suspend
[  543.810106] call 0000:00:1b.0+ returned 0 after 0 usecs
[  543.810106] mei_me 0000:00:16.0: late power domain suspend
[  543.810107] call 0000:00:17.0+ returned 0 after 1 usecs
[  543.810107] calling  0000:00:14.0+ @ 1770, parent: pci0000:00
[  543.810108] call 0000:00:16.0+ returned 0 after 1 usecs
[  543.810108] calling  0000:00:00.0+ @ 1774, parent: pci0000:00
[  543.810108] calling  0000:00:01.0+ @ 1260, parent: pci0000:00
[  543.810109] xhci_hcd 0000:00:14.0: late bus suspend, may wakeup
[  543.810110] skl_uncore 0000:00:00.0: late bus suspend
[  543.810110] pcieport 0000:00:01.0: late bus suspend
[  543.810110] call 0000:00:14.0+ returned 0 after 1 usecs
[  543.810111] call 0000:00:00.0+ returned 0 after 1 usecs
[  543.810111] call 0000:00:01.0+ returned 0 after 1 usecs
[  543.810175] calling  regulator.0+ @ 1410, parent: reg-dummy
[  543.810176] regulator regulator.0: late class suspend
[  543.810177] call regulator.0+ returned 0 after 1 usecs
[  543.816057] xhci_hcd 0000:08:00.0: late bus suspend, may wakeup
[  543.816058] call 0000:08:00.0+ returned 0 after 0 usecs
[  543.816077] calling  0000:00:1c.0+ @ 1767, parent: pci0000:00
[  543.822064] pci 0000:05:00.0: late bus suspend
[  543.822064] call 0000:05:00.0+ returned 0 after 0 usecs
[  543.822096] calling  0000:00:1b.2+ @ 1778, parent: pci0000:00
[  543.828174] pcieport 0000:00:1c.0: late bus suspend
[  543.832853] pcieport 0000:00:1b.2: late bus suspend
[  543.838262] call 0000:00:1c.0+ returned 0 after 9851 usecs
[  544.163504] call 0000:00:1b.2+ returned 0 after 322903 usecs
[  544.169559] calling  0000:03:00.1+ @ 1778, parent: 0000:02:00.0
[  544.169572] calling  PNP0C0B:04+ @ 1410, parent: platform
[  544.175578] snd_hda_intel 0000:03:00.1: noirq bus suspend
[  544.186583] acpi-fan PNP0C0B:04: noirq power domain suspend
[  544.192258] call PNP0C0B:04+ returned 0 after 5542 usecs
[  544.194090] call 0000:03:00.1+ returned 0 after 18077 usecs
[  544.197641] calling  PNP0C0B:03+ @ 1410, parent: platform
[  544.208812] acpi-fan PNP0C0B:03: noirq power domain suspend
[  544.214514] call PNP0C0B:03+ returned 0 after 5568 usecs
[  544.219931] calling  PNP0C0B:02+ @ 1410, parent: platform
[  544.225419] acpi-fan PNP0C0B:02: noirq power domain suspend
[  544.231068] call PNP0C0B:02+ returned 0 after 5516 usecs
[  544.236477] calling  PNP0C0B:01+ @ 1410, parent: platform
[  544.241963] acpi-fan PNP0C0B:01: noirq power domain suspend
[  544.247630] call PNP0C0B:01+ returned 0 after 5533 usecs
[  544.253029] calling  PNP0C0B:00+ @ 1410, parent: platform
[  544.258517] acpi-fan PNP0C0B:00: noirq power domain suspend
[  544.264192] call PNP0C0B:00+ returned 0 after 5542 usecs
[  544.269591] calling  PNP0C14:01+ @ 1410, parent: platform
[  544.275060] acpi-wmi PNP0C14:01: noirq power domain suspend
[  544.280721] call PNP0C14:01+ returned 0 after 5527 usecs
[  544.286119] calling  PNP0C14:00+ @ 1410, parent: pci0000:00
[  544.291788] acpi-wmi PNP0C14:00: noirq power domain suspend
[  544.297481] call PNP0C14:00+ returned 0 after 5559 usecs
[  544.302877] calling  0000:08:00.0+ @ 1778, parent: 0000:00:1c.0
[  544.302880] calling  0000:05:00.0+ @ 1781, parent: 0000:00:1b.2
[  544.302885] calling  0000:03:00.0+ @ 1767, parent: 0000:02:00.0
[  544.302886] amdgpu 0000:03:00.0: noirq bus suspend
[  544.302887] call 0000:03:00.0+ returned 0 after 1 usecs
[  544.302890] calling  0000:02:00.0+ @ 1782, parent: 0000:01:00.0
[  544.302891] pcieport 0000:02:00.0: noirq bus suspend
[  544.302892] calling  0000:00:1f.6+ @ 1767, parent: pci0000:00
[  544.302893] e1000e 0000:00:1f.6: noirq bus suspend, may wakeup
[  544.302894] calling  0000:00:1f.4+ @ 1774, parent: pci0000:00
[  544.302896] pci 0000:00:1f.4: noirq bus suspend
[  544.302897] calling  0000:00:1f.3+ @ 1260, parent: pci0000:00
[  544.302898] snd_hda_intel 0000:00:1f.3: noirq bus suspend
[  544.302900] calling  0000:00:1f.2+ @ 1771, parent: pci0000:00
[  544.302901] pci 0000:00:1f.2: noirq bus suspend
[  544.303084] call 0000:00:1f.4+ returned 0 after 183 usecs
[  544.303087] calling  0000:00:1f.0+ @ 1774, parent: pci0000:00
[  544.303088] pci 0000:00:1f.0: noirq bus suspend
[  544.303094] call 0000:00:1f.2+ returned 0 after 188 usecs
[  544.303098] calling  0000:00:1d.0+ @ 1771, parent: pci0000:00
[  544.303099] pcieport 0000:00:1d.0: noirq bus suspend
[  544.303099] call 0000:00:1d.0+ returned 0 after 0 usecs
[  544.303102] calling  0000:00:1c.4+ @ 1771, parent: pci0000:00
[  544.303102] pcieport 0000:00:1c.4: noirq bus suspend
[  544.303103] call 0000:00:1c.4+ returned 0 after 0 usecs
[  544.303108] calling  0000:00:1b.3+ @ 1770, parent: pci0000:00
[  544.303108] pcieport 0000:00:1b.3: noirq bus suspend
[  544.303109] call 0000:00:1b.3+ returned 0 after 0 usecs
[  544.303114] calling  0000:00:1b.0+ @ 207, parent: pci0000:00
[  544.303115] pcieport 0000:00:1b.0: noirq bus suspend
[  544.303115] call 0000:00:1b.0+ returned 0 after 0 usecs
[  544.303118] calling  0000:00:17.0+ @ 207, parent: pci0000:00
[  544.303119] ahci 0000:00:17.0: noirq bus suspend
[  544.303208] call 0000:00:1f.0+ returned 0 after 117 usecs
[  544.303211] calling  0000:00:16.0+ @ 1774, parent: pci0000:00
[  544.303211] mei_me 0000:00:16.0: noirq power domain suspend
[  544.303253] calling  0000:00:14.0+ @ 1775, parent: pci0000:00
[  544.303253] xhci_hcd 0000:00:14.0: noirq bus suspend, may wakeup
[  544.303258] calling  0000:00:00.0+ @ 1773, parent: pci0000:00
[  544.303259] skl_uncore 0000:00:00.0: noirq bus suspend
[  544.303325] call 0000:00:00.0+ returned 0 after 64 usecs
[  544.308951] xhci_hcd 0000:08:00.0: noirq bus suspend, may wakeup
[  544.314945] pci 0000:05:00.0: noirq bus suspend
[  544.322085] call 0000:02:00.0+ returned 0 after 18744 usecs
[  544.322094] call 0000:00:16.0+ returned 0 after 18439 usecs
[  544.322096] call 0000:00:17.0+ returned 0 after 18532 usecs
[  544.322097] call 0000:00:1f.6+ returned 0 after 18754 usecs
[  544.325922] call 0000:05:00.0+ returned 0 after 10720 usecs
[  544.331129] calling  0000:01:00.0+ @ 1769, parent: 0000:00:01.0
[  544.337141] calling  0000:00:1b.2+ @ 1770, parent: pci0000:00
[  544.338099] call 0000:08:00.0+ returned 0 after 28464 usecs
[  544.338102] calling  0000:00:1c.0+ @ 1771, parent: pci0000:00
[  544.338103] pcieport 0000:00:1c.0: noirq bus suspend
[  544.342185] pcieport 0000:01:00.0: noirq bus suspend
[  544.348017] pcieport 0000:00:1b.2: noirq bus suspend
[  544.354181] call 0000:00:1f.3+ returned 0 after 50081 usecs
[  544.358090] call 0000:00:1c.0+ returned 0 after 19518 usecs
[  544.359852] call 0000:00:1b.2+ returned 0 after 11558 usecs
[  544.370079] call 0000:01:00.0+ returned 0 after 27241 usecs
[  544.370301] call 0000:00:14.0+ returned 0 after 65476 usecs
[  544.375770] calling  0000:00:01.0+ @ 1768, parent: pci0000:00
[  544.639841] pcieport 0000:00:01.0: noirq bus suspend
[  544.666317] call 0000:00:01.0+ returned 0 after 25855 usecs
[  544.672230] ACPI: Preparing to enter system sleep state S3
[  544.679539] PM: Saving platform NVS memory
[  544.683695] Disabling non-boot CPUs ...
[  544.702518] device: 'machinecheck1': device_unregister
[  544.707808] PM: Removing info for machinecheck:machinecheck1
[  544.713567] device: 'index0': device_unregister
[  544.718187] PM: Removing info for No Bus:index0
[  544.722814] device: 'index1': device_unregister
[  544.727443] PM: Removing info for No Bus:index1
[  544.732065] device: 'index2': device_unregister
[  544.736682] PM: Removing info for No Bus:index2
[  544.741277] device: 'index3': device_unregister
[  544.745903] PM: Removing info for No Bus:index3
[  544.750501] device: 'cache': device_unregister
[  544.755026] PM: Removing info for No Bus:cache
[  544.760620] smpboot: CPU 1 is now offline
[  544.778443] device: 'machinecheck2': device_unregister
[  544.783674] PM: Removing info for machinecheck:machinecheck2
[  544.789444] device: 'index0': device_unregister
[  544.794084] PM: Removing info for No Bus:index0
[  544.798659] device: 'index1': device_unregister
[  544.803286] PM: Removing info for No Bus:index1
[  544.807870] device: 'index2': device_unregister
[  544.812498] PM: Removing info for No Bus:index2
[  544.817108] device: 'index3': device_unregister
[  544.821743] PM: Removing info for No Bus:index3
[  544.826349] device: 'cache': device_unregister
[  544.830868] PM: Removing info for No Bus:cache
[  544.836448] smpboot: CPU 2 is now offline
[  544.854403] device: 'machinecheck3': device_unregister
[  544.859648] PM: Removing info for machinecheck:machinecheck3
[  544.865414] device: 'index0': device_unregister
[  544.870047] PM: Removing info for No Bus:index0
[  544.874657] device: 'index1': device_unregister
[  544.879274] PM: Removing info for No Bus:index1
[  544.883869] device: 'index2': device_unregister
[  544.888494] PM: Removing info for No Bus:index2
[  544.893107] device: 'index3': device_unregister
[  544.897725] PM: Removing info for No Bus:index3
[  544.902331] device: 'cache': device_unregister
[  544.906848] PM: Removing info for No Bus:cache
[  544.912399] smpboot: CPU 3 is now offline
[  544.930377] device: 'machinecheck4': device_unregister
[  544.935610] PM: Removing info for machinecheck:machinecheck4
[  544.941385] device: 'index0': device_unregister
[  544.945951] PM: Removing info for No Bus:index0
[  544.950543] device: 'index1': device_unregister
[  544.955161] PM: Removing info for No Bus:index1
[  544.959762] device: 'index2': device_unregister
[  544.964372] PM: Removing info for No Bus:index2
[  544.968975] device: 'index3': device_unregister
[  544.973611] PM: Removing info for No Bus:index3
[  544.978223] device: 'cache': device_unregister
[  544.982733] PM: Removing info for No Bus:cache
[  544.987294] IRQ 126: no longer affine to CPU4
[  544.991725] IRQ 127: no longer affine to CPU4
[  544.997153] smpboot: CPU 4 is now offline
[  545.010343] device: 'machinecheck5': device_unregister
[  545.015583] PM: Removing info for machinecheck:machinecheck5
[  545.021371] device: 'index0': device_unregister
[  545.025985] PM: Removing info for No Bus:index0
[  545.030579] device: 'index1': device_unregister
[  545.035206] PM: Removing info for No Bus:index1
[  545.039799] device: 'index2': device_unregister
[  545.044408] PM: Removing info for No Bus:index2
[  545.049020] device: 'index3': device_unregister
[  545.053647] PM: Removing info for No Bus:index3
[  545.058246] device: 'cache': device_unregister
[  545.062779] PM: Removing info for No Bus:cache
[  545.067348] IRQ 122: no longer affine to CPU5
[  545.071786] IRQ 123: no longer affine to CPU5
[  545.076200] IRQ 130: no longer affine to CPU5
[  545.081619] smpboot: CPU 5 is now offline
[  545.102311] device: 'machinecheck6': device_unregister
[  545.107562] PM: Removing info for machinecheck:machinecheck6
[  545.113347] device: 'index0': device_unregister
[  545.117955] PM: Removing info for No Bus:index0
[  545.122553] device: 'index1': device_unregister
[  545.127175] PM: Removing info for No Bus:index1
[  545.131778] device: 'index2': device_unregister
[  545.136407] PM: Removing info for No Bus:index2
[  545.141017] device: 'index3': device_unregister
[  545.145636] PM: Removing info for No Bus:index3
[  545.150242] device: 'cache': device_unregister
[  545.154776] PM: Removing info for No Bus:cache
[  545.159341] IRQ 121: no longer affine to CPU6
[  545.163767] IRQ 124: no longer affine to CPU6
[  545.168204] IRQ 125: no longer affine to CPU6
[  545.173653] smpboot: CPU 6 is now offline
[  545.190275] device: 'machinecheck7': device_unregister
[  545.195507] PM: Removing info for machinecheck:machinecheck7
[  545.201307] device: 'index0': device_unregister
[  545.205923] PM: Removing info for No Bus:index0
[  545.210534] device: 'index1': device_unregister
[  545.215151] PM: Removing info for No Bus:index1
[  545.219771] device: 'index2': device_unregister
[  545.224370] PM: Removing info for No Bus:index2
[  545.228967] device: 'index3': device_unregister
[  545.233575] PM: Removing info for No Bus:index3
[  545.238171] device: 'cache': device_unregister
[  545.242700] PM: Removing info for No Bus:cache
[  545.247259] IRQ 4: no longer affine to CPU7
[  545.251515] IRQ 5: no longer affine to CPU7
[  545.256781] smpboot: CPU 7 is now offline
[  545.261050] PM: Calling kvm_suspend+0x0/0x20 [kvm]
[  545.265938] PM: Calling mce_syscore_suspend+0x0/0x10
[  545.271016] PM: Calling ledtrig_cpu_syscore_suspend+0x0/0x20
[  545.276763] PM: Calling timekeeping_suspend+0x0/0x290
[  545.281994] PM: Calling irq_gc_suspend+0x0/0x60
[  545.286592] PM: Calling save_ioapic_entries+0x0/0x80
[  545.292849] PM: Calling i8259A_suspend+0x0/0x30
[  545.297449] PM: Calling fw_suspend+0x0/0x20
[  545.301715] PM: Calling acpi_save_bm_rld+0x0/0x20
[  545.306506] PM: Calling lapic_suspend+0x0/0x1a0
[  545.312083] ACPI: Low-level resume complete
[  545.316425] PM: Restoring platform NVS memory
[  545.320888] PM: Calling bsp_resume+0x0/0x20
[  545.325131] PM: Calling lapic_resume+0x0/0x260
[  545.329694] PM: Calling acpi_restore_bm_rld+0x0/0x40
[  545.334727] PM: Calling irqrouter_resume+0x0/0x50
[  545.339501] PM: Calling i8259A_resume+0x0/0x30
[  545.344168] PM: Calling i8237A_resume+0x0/0x90
[  545.348796] PM: Calling ioapic_resume+0x0/0xb0
[  545.353555] PM: Calling irq_gc_resume+0x0/0x60
[  545.358066] PM: Calling irq_pm_syscore_resume+0x0/0x10
[  545.363307] PM: Calling timekeeping_resume+0x0/0x1b0
[  545.368465] PM: Calling ledtrig_cpu_syscore_resume+0x0/0x10
[  545.374141] PM: Calling mce_syscore_resume+0x0/0x30
[  545.379115] PM: Calling mc_bp_resume+0x0/0x50
[  545.383573] PM: Calling kvm_resume+0x0/0x30 [kvm]
[  545.388431] Enabling non-boot CPUs ...
[  545.392283] x86: Booting SMP configuration:
[  545.396556] smpboot: Booting Node 0 Processor 1 APIC 0x2
[  545.402376] device: 'cache': device_add
[  545.406302] PM: Adding info for No Bus:cache
[  545.410638]  cache: parent cpu1 should not be sleeping
[  545.415860] device: 'index0': device_add
[  545.419900] PM: Adding info for No Bus:index0
[  545.424349] device: 'index1': device_add
[  545.428350] PM: Adding info for No Bus:index1
[  545.432817] device: 'index2': device_add
[  545.436857] PM: Adding info for No Bus:index2
[  545.441241] device: 'index3': device_add
[  545.445254] PM: Adding info for No Bus:index3
[  545.449687] device: 'machinecheck1': device_add
[  545.454358] PM: Adding info for machinecheck:machinecheck1
[  545.460182] CPU1 is up
[  545.462628] smpboot: Booting Node 0 Processor 2 APIC 0x4
[  545.468422] device: 'cache': device_add
[  545.472336] PM: Adding info for No Bus:cache
[  545.476699]  cache: parent cpu2 should not be sleeping
[  545.481921] device: 'index0': device_add
[  545.485941] PM: Adding info for No Bus:index0
[  545.490380] device: 'index1': device_add
[  545.494384] PM: Adding info for No Bus:index1
[  545.498797] device: 'index2': device_add
[  545.502811] PM: Adding info for No Bus:index2
[  545.507222] device: 'index3': device_add
[  545.511244] PM: Adding info for No Bus:index3
[  545.515683] device: 'machinecheck2': device_add
[  545.520321] PM: Adding info for machinecheck:machinecheck2
[  545.526168] CPU2 is up
[  545.528581] smpboot: Booting Node 0 Processor 3 APIC 0x6
[  545.534402] device: 'cache': device_add
[  545.538341] PM: Adding info for No Bus:cache
[  545.542685]  cache: parent cpu3 should not be sleeping
[  545.547917] device: 'index0': device_add
[  545.551940] PM: Adding info for No Bus:index0
[  545.556378] device: 'index1': device_add
[  545.560404] PM: Adding info for No Bus:index1
[  545.564845] device: 'index2': device_add
[  545.568868] PM: Adding info for No Bus:index2
[  545.573304] device: 'index3': device_add
[  545.577350] PM: Adding info for No Bus:index3
[  545.581791] device: 'machinecheck3': device_add
[  545.586407] PM: Adding info for machinecheck:machinecheck3
[  545.592300] CPU3 is up
[  545.594735] smpboot: Booting Node 0 Processor 4 APIC 0x1
[  545.600624] device: 'cache': device_add
[  545.604551] PM: Adding info for No Bus:cache
[  545.608897]  cache: parent cpu4 should not be sleeping
[  545.614121] device: 'index0': device_add
[  545.618163] PM: Adding info for No Bus:index0
[  545.622608] device: 'index1': device_add
[  545.626621] PM: Adding info for No Bus:index1
[  545.631085] device: 'index2': device_add
[  545.635116] PM: Adding info for No Bus:index2
[  545.639552] device: 'index3': device_add
[  545.643566] PM: Adding info for No Bus:index3
[  545.648005] device: 'machinecheck4': device_add
[  545.652610] PM: Adding info for machinecheck:machinecheck4
[  545.658510] CPU4 is up
[  545.660950] smpboot: Booting Node 0 Processor 5 APIC 0x3
[  545.666768] device: 'cache': device_add
[  545.670706] PM: Adding info for No Bus:cache
[  545.675066]  cache: parent cpu5 should not be sleeping
[  545.680310] device: 'index0': device_add
[  545.684332] PM: Adding info for No Bus:index0
[  545.688737] device: 'index1': device_add
[  545.692738] PM: Adding info for No Bus:index1
[  545.697143] device: 'index2': device_add
[  545.701157] PM: Adding info for No Bus:index2
[  545.705611] device: 'index3': device_add
[  545.709605] PM: Adding info for No Bus:index3
[  545.714035] device: 'machinecheck5': device_add
[  545.718676] PM: Adding info for machinecheck:machinecheck5
[  545.724592] CPU5 is up
[  545.727011] smpboot: Booting Node 0 Processor 6 APIC 0x5
[  545.732818] device: 'cache': device_add
[  545.736728] PM: Adding info for No Bus:cache
[  545.741064]  cache: parent cpu6 should not be sleeping
[  545.746376] device: 'index0': device_add
[  545.750386] PM: Adding info for No Bus:index0
[  545.754852] device: 'index1': device_add
[  545.758911] PM: Adding info for No Bus:index1
[  545.763349] device: 'index2': device_add
[  545.767396] PM: Adding info for No Bus:index2
[  545.771813] device: 'index3': device_add
[  545.775842] PM: Adding info for No Bus:index3
[  545.780275] device: 'machinecheck6': device_add
[  545.784916] PM: Adding info for machinecheck:machinecheck6
[  545.790847] CPU6 is up
[  545.793254] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  545.799019] device: 'cache': device_add
[  545.802942] PM: Adding info for No Bus:cache
[  545.807275]  cache: parent cpu7 should not be sleeping
[  545.812502] device: 'index0': device_add
[  545.816520] PM: Adding info for No Bus:index0
[  545.820948] device: 'index1': device_add
[  545.824973] PM: Adding info for No Bus:index1
[  545.829431] device: 'index2': device_add
[  545.833444] PM: Adding info for No Bus:index2
[  545.837862] device: 'index3': device_add
[  545.841859] PM: Adding info for No Bus:index3
[  545.846289] device: 'machinecheck7': device_add
[  545.850915] PM: Adding info for machinecheck:machinecheck7
[  545.856924] CPU7 is up
[  545.865199] ACPI: Waking up from system sleep state S3
[  545.888271] calling  0000:00:00.0+ @ 1775, parent: pci0000:00
[  545.888272] calling  0000:00:01.0+ @ 1768, parent: pci0000:00
[  545.888273] calling  0000:00:14.0+ @ 1769, parent: pci0000:00
[  545.888275] pcieport 0000:00:01.0: noirq bus resume
[  545.888276] calling  0000:00:16.0+ @ 1770, parent: pci0000:00
[  545.888278] mei_me 0000:00:16.0: noirq power domain resume
[  545.888279] calling  0000:00:17.0+ @ 1260, parent: pci0000:00
[  545.888280] ahci 0000:00:17.0: noirq bus resume
[  545.888285] calling  0000:00:1b.0+ @ 1771, parent: pci0000:00
[  545.888286] pcieport 0000:00:1b.0: noirq bus resume
[  545.888289] calling  0000:00:1b.2+ @ 1778, parent: pci0000:00
[  545.888289] pcieport 0000:00:1b.2: noirq bus resume
[  545.888368] call 0000:00:1b.2+ returned 0 after 76 usecs
[  545.888371] calling  0000:00:1b.3+ @ 1778, parent: pci0000:00
[  545.888371] pcieport 0000:00:1b.3: noirq bus resume
[  545.888375] calling  0000:00:1c.0+ @ 1781, parent: pci0000:00
[  545.888376] pcieport 0000:00:1c.0: noirq bus resume
[  545.888379] calling  0000:00:1c.4+ @ 1782, parent: pci0000:00
[  545.888380] pcieport 0000:00:1c.4: noirq bus resume
[  545.888381] calling  0000:00:1d.0+ @ 1767, parent: pci0000:00
[  545.888381] pcieport 0000:00:1d.0: noirq bus resume
[  545.888383] calling  0000:00:1f.0+ @ 207, parent: pci0000:00
[  545.888383] pci 0000:00:1f.0: noirq bus resume
[  545.888443] call 0000:00:1f.0+ returned 0 after 58 usecs
[  545.888445] calling  0000:00:1f.2+ @ 207, parent: pci0000:00
[  545.888445] pci 0000:00:1f.2: noirq bus resume
[  545.888479] call 0000:00:1f.2+ returned 0 after 32 usecs
[  545.888480] calling  0000:00:1f.3+ @ 207, parent: pci0000:00
[  545.888481] snd_hda_intel 0000:00:1f.3: noirq bus resume
[  545.888483] calling  0000:00:1f.4+ @ 1774, parent: pci0000:00
[  545.888484] pci 0000:00:1f.4: noirq bus resume
[  545.888486] calling  0000:00:1f.6+ @ 1773, parent: pci0000:00
[  545.888487] e1000e 0000:00:1f.6: noirq bus resume
[  545.888494] calling  0000:05:00.0+ @ 1772, parent: 0000:00:1b.2
[  545.888495] pci 0000:05:00.0: noirq bus resume
[  545.888590] call 0000:00:1f.4+ returned 0 after 103 usecs
[  545.888694] call 0000:05:00.0+ returned 0 after 195 usecs
[  545.888856] call 0000:00:01.0+ returned 0 after 569 usecs
[  545.888859] calling  0000:01:00.0+ @ 1766, parent: 0000:00:01.0
[  545.888860] pcieport 0000:01:00.0: noirq bus resume
[  545.888941] call 0000:01:00.0+ returned 0 after 79 usecs
[  545.888943] calling  0000:02:00.0+ @ 1779, parent: 0000:01:00.0
[  545.888944] pcieport 0000:02:00.0: noirq bus resume
[  545.889020] call 0000:02:00.0+ returned 0 after 74 usecs
[  545.889022] calling  0000:03:00.0+ @ 1776, parent: 0000:02:00.0
[  545.889023] amdgpu 0000:03:00.0: noirq bus resume
[  545.889138] call 0000:03:00.0+ returned 0 after 112 usecs
[  545.889139] calling  0000:03:00.1+ @ 1774, parent: 0000:02:00.0
[  545.889140] snd_hda_intel 0000:03:00.1: noirq bus resume
[  545.889213] call 0000:03:00.1+ returned 0 after 71 usecs
[  545.894135] skl_uncore 0000:00:00.0: noirq bus resume
[  545.894143] call 0000:00:00.0+ returned 0 after 8 usecs
[  545.899959] xhci_hcd 0000:00:14.0: noirq bus resume
[  545.904610] call 0000:00:1d.0+ returned 0 after 15848 usecs
[  545.904613] call 0000:00:1b.0+ returned 0 after 15943 usecs
[  545.904613] call 0000:00:1c.4+ returned 0 after 15852 usecs
[  545.904681] call 0000:00:1b.3+ returned 0 after 15927 usecs
[  545.904798] call 0000:00:16.0+ returned 0 after 16133 usecs
[  545.904802] call 0000:00:1f.6+ returned 0 after 15932 usecs
[  545.904816] call 0000:00:17.0+ returned 0 after 16148 usecs
[  545.904835] call 0000:00:1c.0+ returned 0 after 16073 usecs
[  545.904841] calling  0000:08:00.0+ @ 1780, parent: 0000:00:1c.0
[  545.904842] xhci_hcd 0000:08:00.0: noirq bus resume
[  545.908606] call 0000:00:1f.3+ returned 0 after 19654 usecs
[  545.910794] calling  PNP0C14:00+ @ 1410, parent: pci0000:00
[  545.924675] call 0000:00:14.0+ returned 0 after 24137 usecs
[  545.924731] call 0000:08:00.0+ returned 0 after 19423 usecs
[  545.928049] acpi-wmi PNP0C14:00: noirq power domain resume
[  546.259131] call PNP0C14:00+ returned 0 after 323324 usecs
[  546.264752] calling  PNP0C14:01+ @ 1410, parent: platform
[  546.270234] acpi-wmi PNP0C14:01: noirq power domain resume
[  546.275823] call PNP0C14:01+ returned 0 after 5457 usecs
[  546.281220] calling  PNP0C0B:00+ @ 1410, parent: platform
[  546.286715] acpi-fan PNP0C0B:00: noirq power domain resume
[  546.292279] call PNP0C0B:00+ returned 0 after 5433 usecs
[  546.297688] calling  PNP0C0B:01+ @ 1410, parent: platform
[  546.303157] acpi-fan PNP0C0B:01: noirq power domain resume
[  546.308754] call PNP0C0B:01+ returned 0 after 5466 usecs
[  546.314155] calling  PNP0C0B:02+ @ 1410, parent: platform
[  546.319666] acpi-fan PNP0C0B:02: noirq power domain resume
[  546.325257] call PNP0C0B:02+ returned 0 after 5459 usecs
[  546.330646] calling  PNP0C0B:03+ @ 1410, parent: platform
[  546.336133] acpi-fan PNP0C0B:03: noirq power domain resume
[  546.341715] call PNP0C0B:03+ returned 0 after 5451 usecs
[  546.347123] calling  PNP0C0B:04+ @ 1410, parent: platform
[  546.352608] acpi-fan PNP0C0B:04: noirq power domain resume
[  546.358182] call PNP0C0B:04+ returned 0 after 5443 usecs
[  546.363868] calling  regulator.0+ @ 1410, parent: reg-dummy
[  546.369509] regulator regulator.0: early class resume
[  546.374665] call regulator.0+ returned 0 after 5035 usecs
[  546.380215] calling  PNP0C14:00+ @ 1410, parent: pci0000:00
[  546.385898] acpi-wmi PNP0C14:00: early power domain resume
[  546.391495] call PNP0C14:00+ returned 0 after 5466 usecs
[  546.396903] calling  PNP0C14:01+ @ 1410, parent: platform
[  546.402381] acpi-wmi PNP0C14:01: early power domain resume
[  546.407996] call PNP0C14:01+ returned 0 after 5483 usecs
[  546.413433] calling  PNP0C0B:00+ @ 1410, parent: platform
[  546.418951] acpi-fan PNP0C0B:00: early power domain resume
[  546.437230] call PNP0C0B:00+ returned 0 after 17849 usecs
[  546.442730] calling  PNP0C0B:01+ @ 1410, parent: platform
[  546.448246] acpi-fan PNP0C0B:01: early power domain resume
[  546.465217] call PNP0C0B:01+ returned 0 after 16573 usecs
[  546.470732] calling  PNP0C0B:02+ @ 1410, parent: platform
[  546.476241] acpi-fan PNP0C0B:02: early power domain resume
[  546.493218] call PNP0C0B:02+ returned 0 after 16579 usecs
[  546.498753] calling  PNP0C0B:03+ @ 1410, parent: platform
[  546.504233] acpi-fan PNP0C0B:03: early power domain resume
[  546.521221] call PNP0C0B:03+ returned 0 after 16590 usecs
[  546.526744] calling  PNP0C0B:04+ @ 1410, parent: platform
[  546.532228] acpi-fan PNP0C0B:04: early power domain resume
[  546.549221] call PNP0C0B:04+ returned 0 after 16594 usecs
[  546.554865] calling  0000:00:00.0+ @ 1779, parent: pci0000:00
[  546.554872] calling  0000:00:01.0+ @ 1809, parent: pci0000:00
[  546.554895] calling  0000:00:14.0+ @ 1808, parent: pci0000:00
[  546.554897] xhci_hcd 0000:00:14.0: bus resume
[  546.554902] calling  0000:00:16.0+ @ 1791, parent: pci0000:00
[  546.554903] mei_me 0000:00:16.0: power domain resume
[  546.554907] calling  0000:00:17.0+ @ 1795, parent: pci0000:00
[  546.554908] ahci 0000:00:17.0: bus resume
[  546.554914] calling  0000:00:1b.0+ @ 1789, parent: pci0000:00
[  546.554915] pcieport 0000:00:1b.0: bus resume
[  546.554917] call 0000:00:1b.0+ returned 0 after 2 usecs
[  546.554919] calling  0000:00:1b.2+ @ 1776, parent: pci0000:00
[  546.554920] pcieport 0000:00:1b.2: bus resume
[  546.554920] calling  0000:00:1b.3+ @ 1789, parent: pci0000:00
[  546.554921] call 0000:00:1b.2+ returned 0 after 1 usecs
[  546.554921] pcieport 0000:00:1b.3: bus resume
[  546.554922] call 0000:00:1b.3+ returned 0 after 1 usecs
[  546.554924] calling  0000:00:1c.0+ @ 1776, parent: pci0000:00
[  546.554925] calling  0000:00:1c.4+ @ 1789, parent: pci0000:00
[  546.554925] pcieport 0000:00:1c.0: bus resume
[  546.554926] pcieport 0000:00:1c.4: bus resume
[  546.554927] call 0000:00:1c.0+ returned 0 after 1 usecs
[  546.554927] call 0000:00:1c.4+ returned 0 after 1 usecs
[  546.554928] calling  0000:00:1d.0+ @ 1776, parent: pci0000:00
[  546.554929] pcieport 0000:00:1d.0: bus resume
[  546.554930] call 0000:00:1d.0+ returned 0 after 0 usecs
[  546.554930] calling  0000:00:1f.0+ @ 1789, parent: pci0000:00
[  546.554931] pci 0000:00:1f.0: bus resume
[  546.554931] call 0000:00:1f.0+ returned 0 after 0 usecs
[  546.554933] calling  0000:00:1f.2+ @ 1776, parent: pci0000:00
[  546.554933] calling  0000:00:1f.3+ @ 1789, parent: pci0000:00
[  546.554934] pci 0000:00:1f.2: bus resume
[  546.554934] snd_hda_intel 0000:00:1f.3: bus resume
[  546.554935] call 0000:00:1f.2+ returned 0 after 1 usecs
[  546.554939] calling  0000:00:1f.4+ @ 1776, parent: pci0000:00
[  546.554939] pci 0000:00:1f.4: bus resume
[  546.554940] call 0000:00:1f.4+ returned 0 after 0 usecs
[  546.554941] calling  0000:00:1f.6+ @ 1776, parent: pci0000:00
[  546.554942] e1000e 0000:00:1f.6: bus resume
[  546.554996] call 0000:00:17.0+ returned 0 after 86 usecs
[  546.555049] calling  reg-dummy+ @ 1410, parent: platform
[  546.555050] reg-dummy reg-dummy: bus resume
[  546.555050] call reg-dummy+ returned 0 after 1 usecs
[  546.555103] calling  PNP0C0E:00+ @ 1410, parent: LNXSYBUS:00
[  546.555104] button PNP0C0E:00: driver resume
[  546.555104] call PNP0C0E:00+ returned 0 after 0 usecs
[  546.555105] calling  PNP0C0C:00+ @ 1410, parent: LNXSYBUS:00
[  546.555106] button PNP0C0C:00: driver resume
[  546.555106] call PNP0C0C:00+ returned 0 after 0 usecs
[  546.555111] calling  LNXTHERM:00+ @ 1410, parent: LNXSYBUS:01
[  546.555111] thermal LNXTHERM:00: driver resume
[  546.555149] calling  0000:05:00.0+ @ 1803, parent: 0000:00:1b.2
[  546.555150] pci 0000:05:00.0: bus resume
[  546.555150] call 0000:05:00.0+ returned 0 after 1 usecs
[  546.555152] calling  0000:08:00.0+ @ 1792, parent: 0000:00:1c.0
[  546.555152] xhci_hcd 0000:08:00.0: bus resume
[  546.555245] call 0000:00:14.0+ returned 0 after 341 usecs
[  546.555248] calling  usb1+ @ 1774, parent: 0000:00:14.0
[  546.555249] calling  usb2+ @ 1797, parent: 0000:00:14.0
[  546.555249] usb usb1: type resume
[  546.555250] usb usb2: type resume
[  546.555294] usb usb3: root hub lost power or was reset
[  546.555294] usb usb4: root hub lost power or was reset
[  546.555309] calling  ata1+ @ 1838, parent: 0000:00:17.0
[  546.555310]  ata1: type resume
[  546.555313] calling  ata2+ @ 1839, parent: 0000:00:17.0
[  546.555314] call ata1+ returned 0 after 3 usecs
[  546.555314]  ata2: type resume
[  546.555318] call ata2+ returned 0 after 4 usecs
[  546.555320] calling  ata3+ @ 1838, parent: 0000:00:17.0
[  546.555320]  ata3: type resume
[  546.555322] call ata3+ returned 0 after 1 usecs
[  546.555323] calling  ata4+ @ 1839, parent: 0000:00:17.0
[  546.555324]  ata4: type resume
[  546.555325] calling  ata5+ @ 1838, parent: 0000:00:17.0
[  546.555326]  ata5: type resume
[  546.555326] call ata4+ returned 0 after 2 usecs
[  546.555328] call ata5+ returned 0 after 1 usecs
[  546.555329] calling  ata6+ @ 1839, parent: 0000:00:17.0
[  546.555330]  ata6: type resume
[  546.555331] calling  host0+ @ 1838, parent: ata1
[  546.555332] scsi host0: bus resume
[  546.555332] call host0+ returned 0 after 0 usecs
[  546.555334] call ata6+ returned 0 after 3 usecs
[  546.555334] calling  host1+ @ 1838, parent: ata2
[  546.555335] scsi host1: bus resume
[  546.555335] call host1+ returned 0 after 0 usecs
[  546.555337] calling  host2+ @ 1839, parent: ata3
[  546.555338] scsi host2: bus resume
[  546.555339] call host2+ returned 0 after 1 usecs
[  546.555342] calling  host3+ @ 1839, parent: ata4
[  546.555342] scsi host3: bus resume
[  546.555343] call host3+ returned 0 after 0 usecs
[  546.555345] calling  host4+ @ 1839, parent: ata5
[  546.555345] scsi host4: bus resume
[  546.555346] call host4+ returned 0 after 0 usecs
[  546.555349] calling  host5+ @ 1839, parent: ata6
[  546.555349] scsi host5: bus resume
[  546.555350] call host5+ returned 0 after 0 usecs
[  546.555352] calling  target0:0:0+ @ 1839, parent: host0
[  546.555353] scsi target0:0:0: bus resume
[  546.555353] call target0:0:0+ returned 0 after 0 usecs
[  546.555355] calling  0:0:0:0+ @ 1839, parent: target0:0:0
[  546.555355] sd 0:0:0:0: bus resume
[  546.555358] call 0:0:0:0+ returned 0 after 2 usecs
[  546.555364] sd 0:0:0:0: [sda] Starting disk
[  546.555446] call usb2+ returned 0 after 191 usecs
[  546.555508] call usb1+ returned 0 after 253 usecs
[  546.555670] call LNXTHERM:00+ returned 0 after 544 usecs
[  546.555674] calling  LNXTHERM:01+ @ 1410, parent: LNXSYBUS:01
[  546.555675] thermal LNXTHERM:01: driver resume
[  546.555676] call LNXTHERM:01+ returned 0 after 1 usecs
[  546.559410] call 0000:00:1f.3+ returned 0 after 4371 usecs
[  546.559412] calling  hdaudioC0D0+ @ 1834, parent: 0000:00:1f.3
[  546.559413] snd_hda_codec_realtek hdaudioC0D0: driver resume
[  546.560958] skl_uncore 0000:00:00.0: bus resume
[  546.560959] call 0000:00:00.0+ returned 0 after 1 usecs
[  546.566773] call 0000:00:16.0+ returned 0 after 11592 usecs
[  546.566945] pcieport 0000:00:01.0: bus resume
[  546.570812] device: 'mei::082ee5a7-7c25-470a-9643-0c06f0466ea1:00': device_add
[  546.570841] PM: Adding info for mei:mei::082ee5a7-7c25-470a-9643-0c06f0466ea1:00
[  546.570863] device: 'mei::3c4852d6-d47b-4f46-b05e-b5edc1aa440e:01': device_add
[  546.570892] PM: Adding info for mei:mei::3c4852d6-d47b-4f46-b05e-b5edc1aa440e:01
[  546.570902] device: 'mei::5565a099-7fe2-45c1-a22b-d7e9dfea9a2e:01': device_add
[  546.570924] PM: Adding info for mei:mei::5565a099-7fe2-45c1-a22b-d7e9dfea9a2e:01
[  546.570935] device: 'mei::dba4d603-d7ed-4931-8823-17ad585705d5:01': device_add
[  546.570961] PM: Adding info for mei:mei::dba4d603-d7ed-4931-8823-17ad585705d5:01
[  546.570970] device: 'mei::f908627d-13bf-4a04-b91f-a64e9245323d:01': device_add
[  546.570993] PM: Adding info for mei:mei::f908627d-13bf-4a04-b91f-a64e9245323d:01
[  546.571003] device: 'mei::309dcde8-ccb1-4062-8f78-600115a34327:01': device_add
[  546.571023] PM: Adding info for mei:mei::309dcde8-ccb1-4062-8f78-600115a34327:01
[  546.571033] device: 'mei::8c2f4425-77d6-4755-aca3-891fdbc66a58:01': device_add
[  546.571052] PM: Adding info for mei:mei::8c2f4425-77d6-4755-aca3-891fdbc66a58:01
[  546.571062] device: 'mei::8e6a6715-9abc-4043-88ef-9e39c6f63e0f:01': device_add
[  546.571083] PM: Adding info for mei:mei::8e6a6715-9abc-4043-88ef-9e39c6f63e0f:01
[  546.571093] device: 'mei::01e88543-8050-4380-9d6f-4f9cec704917:01': device_add
[  546.571117] PM: Adding info for mei:mei::01e88543-8050-4380-9d6f-4f9cec704917:01
[  546.571127] device: 'mei::42b3ce2f-bd9f-485a-96ae-26406230b1ff:01': device_add
[  546.571148] PM: Adding info for mei:mei::42b3ce2f-bd9f-485a-96ae-26406230b1ff:01
[  546.571297] device: 'mei::55213584-9a29-4916-badf-0fb7ed682aeb:01': device_add
[  546.571320] PM: Adding info for mei:mei::55213584-9a29-4916-badf-0fb7ed682aeb:01
[  546.614919] call 0000:08:00.0+ returned 0 after 58366 usecs
[  546.615143] call 0000:00:01.0+ returned 0 after 47068 usecs
[  546.621047] calling  usb3+ @ 1817, parent: 0000:08:00.0
[  546.621072] calling  usb4+ @ 1843, parent: 0000:08:00.0
[  546.621073] usb usb4: type resume
[  546.625499] calling  0000:01:00.0+ @ 1795, parent: 0000:00:01.0
[  546.625500] pcieport 0000:01:00.0: bus resume
[  546.625516] call 0000:01:00.0+ returned 0 after 15 usecs
[  546.631416] usb usb3: type resume
[  546.636788] calling  0000:02:00.0+ @ 1807, parent: 0000:01:00.0
[  546.720241] call hdaudioC0D0+ returned 0 after 157058 usecs
[  546.720699] pcieport 0000:02:00.0: bus resume
[  546.720700] call 0000:02:00.0+ returned 0 after 1 usecs
[  546.720723] calling  INT0800:00+ @ 1410, parent: 0000:00:1f.0
[  546.720727] calling  0000:03:00.0+ @ 1806, parent: 0000:02:00.0
[  546.720728] amdgpu 0000:03:00.0: bus resume
[  546.728666] call usb4+ returned 0 after 105071 usecs
[  546.729601] platform INT0800:00: bus resume
[  546.748599] call usb3+ returned 0 after 114437 usecs
[  546.750036] call INT0800:00+ returned 0 after 19957 usecs
[  546.926741] ata2: SATA link down (SStatus 4 SControl 300)
[  546.929030] calling  PNP0103:00+ @ 1410, parent: 0000:00:1f.0
[  546.934373] ata6: SATA link down (SStatus 4 SControl 300)
[  546.937463] platform PNP0103:00: bus resume
[  546.937464] call PNP0103:00+ returned 0 after 0 usecs
[  546.942093] ata4: SATA link down (SStatus 4 SControl 300)
[  546.946691] calling  PNP0C04:00+ @ 1410, parent: 0000:00:1f.0
[  546.946692] platform PNP0C04:00: bus resume
[  546.952105] ata3: SATA link down (SStatus 4 SControl 300)
[  546.955210] call PNP0C04:00+ returned 0 after 8318 usecs
[  546.955211] calling  ACPI000C:00+ @ 1410, parent: platform
[  546.955212] platform ACPI000C:00: bus resume
[  546.959944] ata5: SATA link down (SStatus 4 SControl 300)
[  546.963383] call ACPI000C:00+ returned 0 after 7980 usecs
[  546.963384] calling  PNP0C0E:00+ @ 1410, parent: platform
[  547.013059] call 0000:00:1f.6+ returned 0 after 447380 usecs
[  547.016346] platform PNP0C0E:00: bus resume
[  547.493455] call PNP0C0E:00+ returned 0 after 465927 usecs
[  547.493455] calling  INT33A1:00+ @ 1410, parent: platform
[  547.493456] platform INT33A1:00: bus resume
[  547.493456] call INT33A1:00+ returned 0 after 0 usecs
[  547.493456] calling  PNP0C0C:00+ @ 1410, parent: platform
[  547.493457] platform PNP0C0C:00: bus resume
[  547.493457] call PNP0C0C:00+ returned 0 after 0 usecs
[  547.493472] calling  PNP0C0B:00+ @ 1410, parent: platform
[  547.493472] acpi-fan PNP0C0B:00: driver resume
[  547.493561] call PNP0C0B:00+ returned 0 after 86 usecs
[  547.493562] calling  PNP0C0B:01+ @ 1410, parent: platform
[  547.493562] acpi-fan PNP0C0B:01: driver resume
[  547.493623] call PNP0C0B:01+ returned 0 after 59 usecs
[  547.493624] calling  PNP0C0B:02+ @ 1410, parent: platform
[  547.493624] acpi-fan PNP0C0B:02: driver resume
[  547.493683] call PNP0C0B:02+ returned 0 after 57 usecs
[  547.493683] calling  PNP0C0B:03+ @ 1410, parent: platform
[  547.493684] acpi-fan PNP0C0B:03: driver resume
[  547.493742] call PNP0C0B:03+ returned 0 after 56 usecs
[  547.493742] calling  PNP0C0B:04+ @ 1410, parent: platform
[  547.493743] acpi-fan PNP0C0B:04: driver resume
[  547.493801] call PNP0C0B:04+ returned 0 after 56 usecs
[  547.493801] calling  LNXPWRBN:00+ @ 1410, parent: LNXSYSTM:00
[  547.493802] button LNXPWRBN:00: driver resume
[  547.493802] call LNXPWRBN:00+ returned 0 after 0 usecs
[  547.493803] calling  00:00+ @ 1410, parent: pnp0
[  547.493804] system 00:00: bus resume
[  547.493805] call 00:00+ returned 0 after 0 usecs
[  547.493805] calling  00:01+ @ 1410, parent: pnp0
[  547.493806] parport_pc 00:01: bus resume
[  547.495915] parport_pc 00:01: activated
[  547.495915] call 00:01+ returned 0 after 2060 usecs
[  547.495916] calling  00:02+ @ 1410, parent: pnp0
[  547.495917] serial 00:02: bus resume
[  547.497642] serial 00:02: activated
[  547.497659] call 00:02+ returned 0 after 1701 usecs
[  547.497659] calling  00:03+ @ 1410, parent: pnp0
[  547.497660] system 00:03: bus resume
[  547.497660] call 00:03+ returned 0 after 0 usecs
[  547.497661] calling  00:04+ @ 1410, parent: pnp0
[  547.497661] system 00:04: bus resume
[  547.497661] call 00:04+ returned 0 after 0 usecs
[  547.497662] calling  00:05+ @ 1410, parent: pnp0
[  547.497662] rtc_cmos 00:05: bus resume
[  547.497996] call 00:05+ returned 0 after 326 usecs
[  547.498125] calling  00:06+ @ 1410, parent: pnp0
[  547.498126] system 00:06: bus resume
[  547.498126] call 00:06+ returned 0 after 0 usecs
[  547.498126] calling  00:07+ @ 1410, parent: pnp0
[  547.498127] system 00:07: bus resume
[  547.498127] call 00:07+ returned 0 after 0 usecs
[  547.498127] calling  00:08+ @ 1410, parent: pnp0
[  547.498128] system 00:08: bus resume
[  547.498128] call 00:08+ returned 0 after 0 usecs
[  547.498128] calling  00:09+ @ 1410, parent: pnp0
[  547.498129] system 00:09: bus resume
[  547.498129] call 00:09+ returned 0 after 0 usecs
[  547.498129] calling  00:0a+ @ 1410, parent: pnp0
[  547.498130] system 00:0a: bus resume
[  547.498130] call 00:0a+ returned 0 after 0 usecs
[  547.498139] calling  pcspkr+ @ 1410, parent: platform
[  547.498139] platform pcspkr: bus resume
[  547.498140] call pcspkr+ returned 0 after 0 usecs
[  547.498140] calling  vesa-framebuffer.0+ @ 1410, parent: platform
[  547.498141] vesa-framebuffer vesa-framebuffer.0: bus resume
[  547.498141] call vesa-framebuffer.0+ returned 0 after 0 usecs
[  547.498142] calling  alarmtimer+ @ 1410, parent: platform
[  547.498143] alarmtimer alarmtimer: bus resume
[  547.498143] call alarmtimer+ returned 0 after 0 usecs
[  547.498146] calling  input0+ @ 1410, parent: PNP0C0E:00
[  547.498147] input input0: type resume
[  547.498147] call input0+ returned 0 after 0 usecs
[  547.498148] calling  input1+ @ 1410, parent: PNP0C0C:00
[  547.498148] input input1: type resume
[  547.498148] call input1+ returned 0 after 0 usecs
[  547.498149] calling  input2+ @ 1410, parent: LNXPWRBN:00
[  547.498149] input input2: type resume
[  547.498149] call input2+ returned 0 after 0 usecs
[  547.498152] calling  serial8250+ @ 1410, parent: platform
[  547.498153] serial8250 serial8250: bus resume
[  547.498153] call serial8250+ returned 0 after 1 usecs
[  547.498165] calling  Fixed MDIO bus.0+ @ 1410, parent: platform
[  547.498166] platform Fixed MDIO bus.0: bus resume
[  547.498166] call Fixed MDIO bus.0+ returned 0 after 0 usecs
[  547.498168] calling  rtc0+ @ 1410, parent: 00:05
[  547.498169] rtc rtc0: class resume
[  547.498170] call rtc0+ returned 0 after 0 usecs
[  547.498171] calling  microcode+ @ 1410, parent: platform
[  547.498171] platform microcode: bus resume
[  547.498171] call microcode+ returned 0 after 0 usecs
[  548.129151] [drm] PCIE GART of 512M enabled (table at 0x000000F400000000).
[  548.129159] [drm] PSP is resuming...
[  548.540016] amdgpu 0000:03:00.0: ring 0(gfx) uses VM inv eng 4 on hub 0
[  548.540017] amdgpu 0000:03:00.0: ring 1(comp_1.0.0) uses VM inv eng 5 on hub 0
[  548.540017] amdgpu 0000:03:00.0: ring 2(comp_1.1.0) uses VM inv eng 6 on hub 0
[  548.540018] amdgpu 0000:03:00.0: ring 3(comp_1.2.0) uses VM inv eng 7 on hub 0
[  548.540018] amdgpu 0000:03:00.0: ring 4(comp_1.3.0) uses VM inv eng 8 on hub 0
[  548.540019] amdgpu 0000:03:00.0: ring 5(comp_1.0.1) uses VM inv eng 9 on hub 0
[  548.540019] amdgpu 0000:03:00.0: ring 6(comp_1.1.1) uses VM inv eng 10 on hub 0
[  548.540020] amdgpu 0000:03:00.0: ring 7(comp_1.2.1) uses VM inv eng 11 on hub 0
[  548.540020] amdgpu 0000:03:00.0: ring 8(comp_1.3.1) uses VM inv eng 12 on hub 0
[  548.540020] amdgpu 0000:03:00.0: ring 9(kiq_2.1.0) uses VM inv eng 13 on hub 0
[  548.540021] amdgpu 0000:03:00.0: ring 10(sdma0) uses VM inv eng 4 on hub 1
[  548.540021] amdgpu 0000:03:00.0: ring 11(sdma1) uses VM inv eng 5 on hub 1
[  548.540056] [drm] ECC is active.
[  548.645858] e1000e: enp0s31f6 NIC Link is Up 100 Mbps Full Duplex, Flow Control: Rx/Tx
[  548.649131] call 0000:03:00.0+ returned 0 after 1883210 usecs
[  548.654345] e1000e 0000:00:1f.6 enp0s31f6: 10/100 speed: disabling TSO
[  549.090753] calling  0000:03:00.1+ @ 1803, parent: 0000:02:00.0
[  549.096800] snd_hda_intel 0000:03:00.1: bus resume
[  549.104307] call 0000:03:00.1+ returned 0 after 7330 usecs
[  549.109936] calling  hdaudioC1D0+ @ 1839, parent: 0000:03:00.1
[  549.109980] calling  input9+ @ 1410, parent: card0
[  549.115849] snd_hda_codec_hdmi hdaudioC1D0: driver resume
[  549.115850] call hdaudioC1D0+ returned 0 after 2 usecs
[  549.131498] input input9: type resume
[  549.135232] call input9+ returned 0 after 3646 usecs
[  549.140287] calling  input3+ @ 1410, parent: card1
[  549.145201] input input3: type resume
[  549.148952] call input3+ returned 0 after 3662 usecs
[  549.154013] calling  input10+ @ 1410, parent: card0
[  549.158971] input input10: type resume
[  549.162791] call input10+ returned 0 after 3730 usecs
[  549.167959] calling  input4+ @ 1410, parent: card1
[  549.172855] input input4: type resume
[  549.176603] call input4+ returned 0 after 3659 usecs
[  549.181660] calling  input5+ @ 1410, parent: card1
[  549.186539] input input5: type resume
[  549.190266] call input5+ returned 0 after 3640 usecs
[  549.195361] calling  input6+ @ 1410, parent: card1
[  549.200231] input input6: type resume
[  549.203968] call input6+ returned 0 after 3649 usecs
[  549.209047] calling  input7+ @ 1410, parent: card1
[  549.213918] input input7: type resume
[  549.217652] call input7+ returned 0 after 3646 usecs
[  549.222723] calling  input8+ @ 1410, parent: card1
[  549.227619] input input8: type resume
[  549.231353] call input8+ returned 0 after 3646 usecs
[  549.236408] calling  input11+ @ 1410, parent: card0
[  549.241400] input input11: type resume
[  549.245211] call input11+ returned 0 after 3721 usecs
[  549.250342] calling  input12+ @ 1410, parent: card0
[  549.255308] input input12: type resume
[  549.259139] call input12+ returned 0 after 3741 usecs
[  549.264270] calling  input13+ @ 1410, parent: card0
[  549.269244] input input13: type resume
[  549.273092] call input13+ returned 0 after 3758 usecs
[  549.278240] calling  input14+ @ 1410, parent: card0
[  549.283172] input input14: type resume
[  549.286986] call input14+ returned 0 after 3725 usecs
[  549.292132] calling  input15+ @ 1410, parent: card0
[  549.297091] input input15: type resume
[  549.300904] call input15+ returned 0 after 3723 usecs
[  549.306061] calling  input16+ @ 1410, parent: card0
[  549.311035] input input16: type resume
[  549.314858] call input16+ returned 0 after 3733 usecs
[  549.320007] calling  coretemp.0+ @ 1410, parent: platform
[  549.325492] coretemp coretemp.0: bus resume
[  549.329738] call coretemp.0+ returned 0 after 4147 usecs
[  549.335390] usb usb4: completing type resume
[  549.339766] usb usb3: completing type resume
[  549.344128] usb usb2: completing type resume
[  549.348501] usb usb1: completing type resume
[  549.352852] snd_hda_intel 0000:03:00.1: completing bus resume
[  549.358719] acpi-fan PNP0C0B:04: completing power domain resume
[  549.364736] acpi-fan PNP0C0B:03: completing power domain resume
[  549.370783] acpi-fan PNP0C0B:02: completing power domain resume
[  549.376791] acpi-fan PNP0C0B:01: completing power domain resume
[  549.382796] acpi-fan PNP0C0B:00: completing power domain resume
[  549.388836] acpi-wmi PNP0C14:01: completing power domain resume
[  549.394894] acpi-wmi PNP0C14:00: completing power domain resume
[  549.400936] xhci_hcd 0000:08:00.0: completing bus resume
[  549.406361] pci 0000:05:00.0: completing bus resume
[  549.411319] amdgpu 0000:03:00.0: completing bus resume
[  549.416552] pcieport 0000:02:00.0: completing bus resume
[  549.421978] pcieport 0000:01:00.0: completing bus resume
[  549.427396] e1000e 0000:00:1f.6: completing bus resume
[  549.432585] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[  549.432657] pci 0000:00:1f.4: completing bus resume
[  549.443940] snd_hda_intel 0000:00:1f.3: completing bus resume
[  549.449797] pci 0000:00:1f.2: completing bus resume
[  549.451605] ata1.00: configured for UDMA/133
[  549.454781] pci 0000:00:1f.0: completing bus resume
[  549.454782] pcieport 0000:00:1d.0: completing bus resume
[  549.454784] pcieport 0000:00:1c.4: completing bus resume
[  549.474899] pcieport 0000:00:1c.0: completing bus resume
[  549.480305] pcieport 0000:00:1b.3: completing bus resume
[  549.485706] pcieport 0000:00:1b.2: completing bus resume
[  549.491079] pcieport 0000:00:1b.0: completing bus resume
[  549.496485] ahci 0000:00:17.0: completing bus resume
[  549.501566] mei_me 0000:00:16.0: completing power domain resume
[  549.507622] xhci_hcd 0000:00:14.0: completing bus resume
[  549.513048] pcieport 0000:00:01.0: completing bus resume
[  549.518446] skl_uncore 0000:00:00.0: completing bus resume
[  549.524448] acpi LNXPOWER:16: Turning OFF
[  549.528674] acpi LNXPOWER:15: Turning OFF
[  549.532837] acpi LNXPOWER:14: Turning OFF
[  549.537049] acpi LNXPOWER:13: Turning OFF
[  549.541242] acpi LNXPOWER:12: Turning OFF
[  549.545394] acpi LNXPOWER:11: Turning OFF
[  549.549573] acpi LNXPOWER:10: Turning OFF
[  549.553758] acpi LNXPOWER:0f: Turning OFF
[  549.557910] acpi LNXPOWER:0e: Turning OFF
[  549.562075] acpi LNXPOWER:0d: Turning OFF
[  549.566237] acpi LNXPOWER:0c: Turning OFF
[  549.570406] acpi LNXPOWER:0b: Turning OFF
[  549.574594] acpi LNXPOWER:0a: Turning OFF
[  549.578769] acpi LNXPOWER:09: Turning OFF
[  549.582940] acpi LNXPOWER:08: Turning OFF
[  549.587140] acpi LNXPOWER:07: Turning OFF
[  549.591337] acpi LNXPOWER:06: Turning OFF
[  549.595523] acpi LNXPOWER:05: Turning OFF
[  549.599690] acpi LNXPOWER:04: Turning OFF
[  549.603843] acpi LNXPOWER:03: Turning OFF
[  549.608025] OOM killer enabled.
[  549.608382] pci_bus 0000:06: Allocating resources
[  549.611232] Restarting tasks ... done.
[  549.616198] pci 0000:05:00.0: bridge window [io  0x1000-0x0fff] to [bus 06] add_size 1000
[  549.628406] pci 0000:05:00.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 06] add_size 200000 add_align 100000
[  549.640089] pci 0000:05:00.0: bridge window [mem 0x00100000-0x000fffff] to [bus 06] add_size 200000 add_align 100000
[  549.650910] pci 0000:05:00.0: BAR 14: no space for [mem size 0x00200000]
[  549.657862] pci 0000:05:00.0: BAR 14: failed to assign [mem size 0x00200000]
[  549.665060] pci 0000:05:00.0: BAR 15: no space for [mem size 0x00200000 64bit pref]
[  549.672835] pci 0000:05:00.0: BAR 15: failed to assign [mem size 0x00200000 64bit pref]
[  549.681022] pci 0000:05:00.0: BAR 13: no space for [io  size 0x1000]
[  549.687562] pci 0000:05:00.0: BAR 13: failed to assign [io  size 0x1000]
[  549.687583] pci 0000:05:00.0: BAR 14: no space for [mem size 0x00200000]
[  549.694417] PM: suspend exit
[  549.701286] pci 0000:05:00.0: BAR 14: failed to assign [mem size 0x00200000]
[  549.701287] pci 0000:05:00.0: BAR 15: no space for [mem size 0x00200000 64bit pref]
[  549.701288] pci 0000:05:00.0: BAR 15: failed to assign [mem size 0x00200000 64bit pref]
[  549.701289] pci 0000:05:00.0: BAR 13: no space for [io  size 0x1000]
[  549.734014] pci 0000:05:00.0: BAR 13: failed to assign [io  size 0x1000]
[  549.734017] pci 0000:05:00.0: PCI bridge to [bus 06]
[  550.426057] device: 'vcs63': device_unregister
[  550.426214] PM: Removing info for No Bus:vcs63
[  550.426242] device: 'vcs63': device_create_release
[  550.426249] device: 'vcsa63': device_unregister
[  550.426324] PM: Removing info for No Bus:vcsa63
[  550.426349] device: 'vcsa63': device_create_release
[  563.108103] device: 'vcs63': device_add
[  563.108138] PM: Adding info for No Bus:vcs63
[  563.108325] device: 'vcsa63': device_add
[  563.108362] PM: Adding info for No Bus:vcsa63
[  563.424255] PM: suspend entry (deep)
[  563.427996] PM: Syncing filesystems ... done.
[  563.508365] Freezing user space processes ... (elapsed 0.001 seconds) done.
[  563.516944] OOM killer disabled.
[  563.520234] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
[  563.529331] calling  coretemp.0+ @ 2130, parent: platform
[  563.534842] coretemp coretemp.0: bus suspend
[  563.539209] call coretemp.0+ returned 0 after 4265 usecs
[  563.544687] calling  input16+ @ 2130, parent: card0
[  563.549660] input input16: type suspend
[  563.553559] call input16+ returned 0 after 3808 usecs
[  563.558769] calling  input15+ @ 2130, parent: card0
[  563.563708] input input15: type suspend
[  563.567651] call input15+ returned 0 after 3850 usecs
[  563.572851] calling  input14+ @ 2130, parent: card0
[  563.577800] input input14: type suspend
[  563.581680] call input14+ returned 0 after 3789 usecs
[  563.586814] calling  input13+ @ 2130, parent: card0
[  563.591875] input input13: type suspend
[  563.595791] call input13+ returned 0 after 3824 usecs
[  563.600930] calling  input12+ @ 2130, parent: card0
[  563.605974] input input12: type suspend
[  563.609873] call input12+ returned 0 after 3807 usecs
[  563.615013] calling  input11+ @ 2130, parent: card0
[  563.620075] input input11: type suspend
[  563.623983] call input11+ returned 0 after 3817 usecs
[  563.629114] calling  input8+ @ 2130, parent: card1
[  563.633978] input input8: type suspend
[  563.637887] call input8+ returned 0 after 3817 usecs
[  563.642947] calling  input7+ @ 2130, parent: card1
[  563.647801] input input7: type suspend
[  563.651718] call input7+ returned 0 after 3824 usecs
[  563.656787] calling  input6+ @ 2130, parent: card1
[  563.661657] input input6: type suspend
[  563.665470] call input6+ returned 0 after 3724 usecs
[  563.670602] calling  input5+ @ 2130, parent: card1
[  563.675499] input input5: type suspend
[  563.679303] call input5+ returned 0 after 3715 usecs
[  563.684470] calling  input4+ @ 2130, parent: card1
[  563.689338] input input4: type suspend
[  563.693168] call input4+ returned 0 after 3740 usecs
[  563.698292] calling  input10+ @ 2130, parent: card0
[  563.703257] input input10: type suspend
[  563.707149] call input10+ returned 0 after 3801 usecs
[  563.712316] calling  input3+ @ 2130, parent: card1
[  563.717280] input input3: type suspend
[  563.721102] call input3+ returned 0 after 3732 usecs
[  563.726129] calling  input9+ @ 2130, parent: card0
[  563.731087] input input9: type suspend
[  563.734899] call input9+ returned 0 after 3722 usecs
[  563.739959] calling  hdaudioC0D0+ @ 1803, parent: 0000:00:1f.3
[  563.739985] calling  hdaudioC1D0+ @ 1838, parent: 0000:03:00.1
[  563.739989] calling  0:0:0:0+ @ 5, parent: target0:0:0
[  563.739990] sd 0:0:0:0: bus suspend
[  563.739996] calling  host5+ @ 1806, parent: ata6
[  563.739997] scsi host5: bus suspend
[  563.739998] calling  host4+ @ 1776, parent: ata5
[  563.739999] call host5+ returned 0 after 0 usecs
[  563.739999] scsi host4: bus suspend
[  563.739999] call host4+ returned 0 after 0 usecs
[  563.740004] calling  host2+ @ 1776, parent: ata3
[  563.740005] scsi host2: bus suspend
[  563.740005] call host2+ returned 0 after 0 usecs
[  563.740006] calling  host1+ @ 1776, parent: ata2
[  563.740007] scsi host1: bus suspend
[  563.740007] call host1+ returned 0 after 0 usecs
[  563.740010] calling  ata6+ @ 1767, parent: 0000:00:17.0
[  563.740011] calling  ata5+ @ 1776, parent: 0000:00:17.0
[  563.740011]  ata6: type suspend
[  563.740012]  ata5: type suspend
[  563.740012] calling  host3+ @ 1806, parent: ata4
[  563.740013] calling  ata3+ @ 1780, parent: 0000:00:17.0
[  563.740013] scsi host3: bus suspend
[  563.740014]  ata3: type suspend
[  563.740014] call host3+ returned 0 after 1 usecs
[  563.740016] calling  microcode+ @ 2130, parent: platform
[  563.740017] platform microcode: bus suspend
[  563.740018] call microcode+ returned 0 after 0 usecs
[  563.740018] calling  ata2+ @ 1806, parent: 0000:00:17.0
[  563.740019]  ata2: type suspend
[  563.740020] calling  rtc0+ @ 2130, parent: 00:05
[  563.740021] rtc rtc0: class suspend
[  563.740021] call rtc0+ returned 0 after 1 usecs
[  563.740034] calling  usb4+ @ 1817, parent: 0000:08:00.0
[  563.740035] usb usb4: type suspend
[  563.740038] calling  ata4+ @ 207, parent: 0000:00:17.0
[  563.740039]  ata4: type suspend
[  563.740058] call ata3+ returned 0 after 43 usecs
[  563.740068] calling  usb3+ @ 1780, parent: 0000:08:00.0
[  563.740069] usb usb3: type suspend
[  563.740072] call ata2+ returned 0 after 52 usecs
[  563.740085] calling  usb2+ @ 1806, parent: 0000:00:14.0
[  563.740086] usb usb2: type suspend
[  563.740092] calling  Fixed MDIO bus.0+ @ 2130, parent: platform
[  563.740093] platform Fixed MDIO bus.0: bus suspend
[  563.740093] call Fixed MDIO bus.0+ returned 0 after 0 usecs
[  563.740095] call ata4+ returned 0 after 54 usecs
[  563.740098] calling  usb1+ @ 1832, parent: 0000:00:14.0
[  563.740098] usb usb1: type suspend
[  563.740119] calling  serial8250+ @ 2130, parent: platform
[  563.740120] serial8250 serial8250: bus suspend
[  563.740121] call serial8250+ returned 0 after 1 usecs
[  563.740127] calling  input2+ @ 2130, parent: LNXPWRBN:00
[  563.740127] input input2: type suspend
[  563.740128] call input2+ returned 0 after 0 usecs
[  563.740128] calling  input1+ @ 2130, parent: PNP0C0C:00
[  563.740129] input input1: type suspend
[  563.740129] call input1+ returned 0 after 0 usecs
[  563.740130] calling  input0+ @ 2130, parent: PNP0C0E:00
[  563.740131] input input0: type suspend
[  563.740131] call input0+ returned 0 after 0 usecs
[  563.740136] call usb4+ returned 0 after 99 usecs
[  563.740140] calling  alarmtimer+ @ 2130, parent: platform
[  563.740141] alarmtimer alarmtimer: bus suspend
[  563.740142] call alarmtimer+ returned 0 after 0 usecs
[  563.740143] calling  vesa-framebuffer.0+ @ 2130, parent: platform
[  563.740144] vesa-framebuffer vesa-framebuffer.0: bus suspend
[  563.740144] call vesa-framebuffer.0+ returned 0 after 0 usecs
[  563.740145] calling  pcspkr+ @ 2130, parent: platform
[  563.740145] platform pcspkr: bus suspend
[  563.740146] call pcspkr+ returned 0 after 0 usecs
[  563.740147] call usb3+ returned 0 after 76 usecs
[  563.740164] calling  00:0a+ @ 2130, parent: pnp0
[  563.740165] system 00:0a: bus suspend
[  563.740166] call 00:0a+ returned 0 after 1 usecs
[  563.740166] calling  00:09+ @ 2130, parent: pnp0
[  563.740167] system 00:09: bus suspend
[  563.740167] call 00:09+ returned 0 after 0 usecs
[  563.740168] calling  00:08+ @ 2130, parent: pnp0
[  563.740168] system 00:08: bus suspend
[  563.740168] call 00:08+ returned 0 after 0 usecs
[  563.740169] calling  00:07+ @ 2130, parent: pnp0
[  563.740169] system 00:07: bus suspend
[  563.740170] call 00:07+ returned 0 after 0 usecs
[  563.740170] calling  00:06+ @ 2130, parent: pnp0
[  563.740171] system 00:06: bus suspend
[  563.740171] call 00:06+ returned 0 after 0 usecs
[  563.740172] calling  00:05+ @ 2130, parent: pnp0
[  563.740172] rtc_cmos 00:05: bus suspend, may wakeup
[  563.740313] call 00:05+ returned 0 after 137 usecs
[  563.740314] calling  00:04+ @ 2130, parent: pnp0
[  563.740314] system 00:04: bus suspend
[  563.740314] call 00:04+ returned 0 after 0 usecs
[  563.740315] calling  00:03+ @ 2130, parent: pnp0
[  563.740315] system 00:03: bus suspend
[  563.740316] call 00:03+ returned 0 after 0 usecs
[  563.740316] calling  00:02+ @ 2130, parent: pnp0
[  563.740317] serial 00:02: bus suspend
[  563.740324] call 00:02+ returned 0 after 7 usecs
[  563.740325] calling  00:01+ @ 2130, parent: pnp0
[  563.740325] parport_pc 00:01: bus suspend
[  563.740353] call usb2+ returned 0 after 261 usecs
[  563.740459] call usb1+ returned 0 after 352 usecs
[  563.740880] parport_pc 00:01: disabled
[  563.740880] call 00:01+ returned 0 after 541 usecs
[  563.740881] calling  00:00+ @ 2130, parent: pnp0
[  563.740882] system 00:00: bus suspend
[  563.740882] call 00:00+ returned 0 after 0 usecs
[  563.740885] calling  LNXPWRBN:00+ @ 2130, parent: LNXSYSTM:00
[  563.740886] button LNXPWRBN:00: driver suspend, may wakeup
[  563.740886] call LNXPWRBN:00+ returned 0 after 0 usecs
[  563.740887] calling  PNP0C0B:04+ @ 2130, parent: platform
[  563.740887] acpi-fan PNP0C0B:04: power domain suspend
[  563.740888] call PNP0C0B:04+ returned 0 after 0 usecs
[  563.740888] calling  PNP0C0B:03+ @ 2130, parent: platform
[  563.740889] acpi-fan PNP0C0B:03: power domain suspend
[  563.740889] call PNP0C0B:03+ returned 0 after 0 usecs
[  563.740890] calling  PNP0C0B:02+ @ 2130, parent: platform
[  563.740890] acpi-fan PNP0C0B:02: power domain suspend
[  563.740890] call PNP0C0B:02+ returned 0 after 0 usecs
[  563.740891] calling  PNP0C0B:01+ @ 2130, parent: platform
[  563.740891] acpi-fan PNP0C0B:01: power domain suspend
[  563.740892] call PNP0C0B:01+ returned 0 after 0 usecs
[  563.740892] calling  PNP0C0B:00+ @ 2130, parent: platform
[  563.740893] acpi-fan PNP0C0B:00: power domain suspend
[  563.740893] call PNP0C0B:00+ returned 0 after 0 usecs
[  563.740894] calling  PNP0C0C:00+ @ 2130, parent: platform
[  563.740894] platform PNP0C0C:00: bus suspend
[  563.740894] call PNP0C0C:00+ returned 0 after 0 usecs
[  563.740895] calling  INT33A1:00+ @ 2130, parent: platform
[  563.740895] platform INT33A1:00: bus suspend
[  563.740896] call INT33A1:00+ returned 0 after 0 usecs
[  563.740896] calling  PNP0C14:01+ @ 2130, parent: platform
[  563.740897] acpi-wmi PNP0C14:01: power domain suspend
[  563.740897] call PNP0C14:01+ returned 0 after 0 usecs
[  563.740897] calling  PNP0C0E:00+ @ 2130, parent: platform
[  563.740898] platform PNP0C0E:00: bus suspend
[  563.740898] call PNP0C0E:00+ returned 0 after 0 usecs
[  563.740899] calling  ACPI000C:00+ @ 2130, parent: platform
[  563.740899] platform ACPI000C:00: bus suspend
[  563.740899] call ACPI000C:00+ returned 0 after 0 usecs
[  563.740900] calling  PNP0C14:00+ @ 2130, parent: pci0000:00
[  563.740900] acpi-wmi PNP0C14:00: power domain suspend
[  563.740901] call PNP0C14:00+ returned 0 after 0 usecs
[  563.740901] calling  PNP0C04:00+ @ 2130, parent: 0000:00:1f.0
[  563.740902] platform PNP0C04:00: bus suspend
[  563.740902] call PNP0C04:00+ returned 0 after 0 usecs
[  563.740902] calling  PNP0103:00+ @ 2130, parent: 0000:00:1f.0
[  563.740903] platform PNP0103:00: bus suspend
[  563.740903] call PNP0103:00+ returned 0 after 0 usecs
[  563.740904] calling  INT0800:00+ @ 2130, parent: 0000:00:1f.0
[  563.740904] platform INT0800:00: bus suspend
[  563.740904] call INT0800:00+ returned 0 after 0 usecs
[  563.740910] calling  0000:08:00.0+ @ 1832, parent: 0000:00:1c.0
[  563.740911] xhci_hcd 0000:08:00.0: bus suspend, may wakeup
[  563.740911] calling  0000:05:00.0+ @ 1806, parent: 0000:00:1b.2
[  563.740912] pci 0000:05:00.0: bus suspend
[  563.740913] call 0000:05:00.0+ returned 0 after 0 usecs
[  563.740920] calling  0000:00:1f.6+ @ 1841, parent: pci0000:00
[  563.740921] e1000e 0000:00:1f.6: bus suspend, may wakeup
[  563.740921] calling  0000:00:1f.4+ @ 1775, parent: pci0000:00
[  563.740922] pci 0000:00:1f.4: bus suspend
[  563.740922] call 0000:00:1f.4+ returned 0 after 0 usecs
[  563.740928] calling  0000:00:1f.0+ @ 1840, parent: pci0000:00
[  563.740928] calling  0000:00:1f.2+ @ 1775, parent: pci0000:00
[  563.740929] pci 0000:00:1f.0: bus suspend
[  563.740929] pci 0000:00:1f.2: bus suspend
[  563.740930] call 0000:00:1f.0+ returned 0 after 1 usecs
[  563.740930] call 0000:00:1f.2+ returned 0 after 1 usecs
[  563.740932] e1000e: EEE TX LPI TIMER: 00000011
[  563.740933] calling  0000:00:1c.4+ @ 1840, parent: pci0000:00
[  563.740933] pcieport 0000:00:1c.4: bus suspend
[  563.740935] calling  0000:00:1d.0+ @ 1843, parent: pci0000:00
[  563.740936] pcieport 0000:00:1d.0: bus suspend
[  563.740939] calling  LNXTHERM:01+ @ 2130, parent: LNXSYBUS:01
[  563.740940] thermal LNXTHERM:01: driver suspend
[  563.740941] call LNXTHERM:01+ returned 0 after 1 usecs
[  563.740941] calling  LNXTHERM:00+ @ 2130, parent: LNXSYBUS:01
[  563.740942] thermal LNXTHERM:00: driver suspend
[  563.740942] call LNXTHERM:00+ returned 0 after 0 usecs
[  563.740946] call 0000:00:1c.4+ returned 0 after 13 usecs
[  563.740948] calling  PNP0C0C:00+ @ 2130, parent: LNXSYBUS:00
[  563.740948] calling  0000:00:1b.3+ @ 1840, parent: pci0000:00
[  563.740949] button PNP0C0C:00: driver suspend, may wakeup
[  563.740949] pcieport 0000:00:1b.3: bus suspend
[  563.740949] call PNP0C0C:00+ returned 0 after 0 usecs
[  563.740951] call 0000:00:1d.0+ returned 0 after 14 usecs
[  563.740951] calling  PNP0C0E:00+ @ 2130, parent: LNXSYBUS:00
[  563.740952] button PNP0C0E:00: driver suspend, may wakeup
[  563.740952] call PNP0C0E:00+ returned 0 after 0 usecs
[  563.740954] calling  0000:00:1b.2+ @ 1843, parent: pci0000:00
[  563.740955] pcieport 0000:00:1b.2: bus suspend
[  563.740955] call 0000:00:1b.3+ returned 0 after 6 usecs
[  563.740957] calling  0000:00:1b.0+ @ 1840, parent: pci0000:00
[  563.740957] pcieport 0000:00:1b.0: bus suspend
[  563.740958] call 0000:00:1b.2+ returned 0 after 2 usecs
[  563.740962] call 0000:00:1b.0+ returned 0 after 5 usecs
[  563.740967] calling  0000:00:16.0+ @ 1840, parent: pci0000:00
[  563.740967] calling  0000:00:14.0+ @ 1843, parent: pci0000:00
[  563.740968] mei_me 0000:00:16.0: power domain suspend
[  563.740969] xhci_hcd 0000:00:14.0: bus suspend, may wakeup
[  563.740984] calling  0000:00:00.0+ @ 1795, parent: pci0000:00
[  563.740984] skl_uncore 0000:00:00.0: bus suspend
[  563.740985] call 0000:00:00.0+ returned 0 after 0 usecs
[  563.741022] calling  reg-dummy+ @ 2130, parent: platform
[  563.741023] reg-dummy reg-dummy: bus suspend
[  563.741023] call reg-dummy+ returned 0 after 0 usecs
[  563.741116] call 0000:00:14.0+ returned 0 after 145 usecs
[  563.741128] call ata5+ returned 0 after 1090 usecs
[  563.741809] call 0000:08:00.0+ returned 0 after 877 usecs
[  563.741811] calling  0000:00:1c.0+ @ 1775, parent: pci0000:00
[  563.741811] pcieport 0000:00:1c.0: bus suspend
[  563.741812] call 0000:00:1c.0+ returned 0 after 0 usecs
[  563.741814] call ata6+ returned 0 after 1761 usecs
[  563.745996] snd_hda_codec_realtek hdaudioC0D0: driver suspend
[  563.751618] PM: Removing info for mei:mei::082ee5a7-7c25-470a-9643-0c06f0466ea1:00
[  563.751665] PM: Removing info for mei:mei::3c4852d6-d47b-4f46-b05e-b5edc1aa440e:01
[  563.751690] PM: Removing info for mei:mei::5565a099-7fe2-45c1-a22b-d7e9dfea9a2e:01
[  563.751715] PM: Removing info for mei:mei::dba4d603-d7ed-4931-8823-17ad585705d5:01
[  563.751737] PM: Removing info for mei:mei::f908627d-13bf-4a04-b91f-a64e9245323d:01
[  563.751756] PM: Removing info for mei:mei::309dcde8-ccb1-4062-8f78-600115a34327:01
[  563.751775] PM: Removing info for mei:mei::8c2f4425-77d6-4755-aca3-891fdbc66a58:01
[  563.751794] PM: Removing info for mei:mei::8e6a6715-9abc-4043-88ef-9e39c6f63e0f:01
[  563.751816] PM: Removing info for mei:mei::01e88543-8050-4380-9d6f-4f9cec704917:01
[  563.751836] PM: Removing info for mei:mei::42b3ce2f-bd9f-485a-96ae-26406230b1ff:01
[  563.751859] PM: Removing info for mei:mei::55213584-9a29-4916-badf-0fb7ed682aeb:01
[  563.751941] snd_hda_codec_hdmi hdaudioC1D0: driver suspend
[  563.751999] call 0000:00:16.0+ returned 0 after 10773 usecs
[  563.777011] call hdaudioC0D0+ returned 0 after 30287 usecs
[  563.778623] call hdaudioC1D0+ returned 0 after 26057 usecs
[  563.782173] calling  0000:00:1f.3+ @ 1842, parent: pci0000:00
[  563.786893] calling  0000:03:00.1+ @ 1817, parent: 0000:02:00.0
[  563.791664] snd_hda_intel 0000:00:1f.3: bus suspend
[  563.795193] snd_hda_intel 0000:03:00.1: bus suspend
[  563.800488] call 0000:00:1f.6+ returned 0 after 58171 usecs
[  563.801092] call 0000:00:1f.3+ returned 0 after 9208 usecs
[  563.804738] call 0000:03:00.1+ returned 0 after 9320 usecs
[  564.945718] calling  0000:03:00.0+ @ 1780, parent: 0000:02:00.0
[  564.951764] amdgpu 0000:03:00.0: bus suspend
[  565.165453] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[  565.174938] sd 0:0:0:0: [sda] Stopping disk
[  565.232789] call 0000:03:00.0+ returned 0 after 274438 usecs
[  565.238574] calling  0000:02:00.0+ @ 1806, parent: 0000:01:00.0
[  565.244632] pcieport 0000:02:00.0: bus suspend
[  565.249166] call 0000:02:00.0+ returned 0 after 4428 usecs
[  565.254778] calling  0000:01:00.0+ @ 207, parent: 0000:00:01.0
[  565.260748] pcieport 0000:01:00.0: bus suspend
[  565.265294] call 0000:01:00.0+ returned 0 after 4440 usecs
[  565.270880] calling  0000:00:01.0+ @ 1807, parent: pci0000:00
[  565.276746] pcieport 0000:00:01.0: bus suspend
[  565.281276] call 0000:00:01.0+ returned 0 after 4424 usecs
[  565.458974] call 0:0:0:0+ returned 0 after 1678696 usecs
[  565.464420] calling  target0:0:0+ @ 1839, parent: host0
[  565.469720] scsi target0:0:0: bus suspend
[  565.473814] call target0:0:0+ returned 0 after 3999 usecs
[  565.479352] calling  host0+ @ 1844, parent: ata1
[  565.484088] scsi host0: bus suspend
[  565.487655] call host0+ returned 0 after 3484 usecs
[  565.492644] calling  ata1+ @ 1811, parent: 0000:00:17.0
[  565.497980]  ata1: type suspend
[  565.502488] call ata1+ returned 0 after 4401 usecs
[  565.507388] calling  0000:00:17.0+ @ 1834, parent: pci0000:00
[  565.513269] ahci 0000:00:17.0: bus suspend
[  565.517469] call 0000:00:17.0+ returned 0 after 4103 usecs
[  565.523359] calling  PNP0C0B:04+ @ 2130, parent: platform
[  565.523364] calling  0000:03:00.1+ @ 1811, parent: 0000:02:00.0
[  565.529010] acpi-fan PNP0C0B:04: late power domain suspend
[  565.534906] snd_hda_intel 0000:03:00.1: late bus suspend
[  565.534907] call 0000:03:00.1+ returned 0 after 1 usecs
[  565.540522] call PNP0C0B:04+ returned 0 after 11242 usecs
[  565.556799] calling  PNP0C0B:03+ @ 2130, parent: platform
[  565.562380] acpi-fan PNP0C0B:03: late power domain suspend
[  565.567980] call PNP0C0B:03+ returned 0 after 5469 usecs
[  565.573500] calling  PNP0C0B:02+ @ 2130, parent: platform
[  565.579020] acpi-fan PNP0C0B:02: late power domain suspend
[  565.584619] call PNP0C0B:02+ returned 0 after 5468 usecs
[  565.590148] calling  PNP0C0B:01+ @ 2130, parent: platform
[  565.595642] acpi-fan PNP0C0B:01: late power domain suspend
[  565.601251] call PNP0C0B:01+ returned 0 after 5477 usecs
[  565.606772] calling  PNP0C0B:00+ @ 2130, parent: platform
[  565.612265] acpi-fan PNP0C0B:00: late power domain suspend
[  565.617855] call PNP0C0B:00+ returned 0 after 5458 usecs
[  565.623386] calling  PNP0C14:01+ @ 2130, parent: platform
[  565.628886] acpi-wmi PNP0C14:01: late power domain suspend
[  565.634486] call PNP0C14:01+ returned 0 after 5468 usecs
[  565.639999] calling  PNP0C14:00+ @ 2130, parent: pci0000:00
[  565.645648] acpi-wmi PNP0C14:00: late power domain suspend
[  565.651326] call PNP0C14:00+ returned 0 after 5544 usecs
[  565.656751] calling  0000:08:00.0+ @ 1811, parent: 0000:00:1c.0
[  565.656754] calling  0000:05:00.0+ @ 1794, parent: 0000:00:1b.2
[  565.656777] calling  0000:03:00.0+ @ 1834, parent: 0000:02:00.0
[  565.656778] amdgpu 0000:03:00.0: late bus suspend
[  565.656795] call 0000:03:00.0+ returned 0 after 17 usecs
[  565.656798] calling  0000:02:00.0+ @ 1834, parent: 0000:01:00.0
[  565.656798] pcieport 0000:02:00.0: late bus suspend
[  565.656799] call 0000:02:00.0+ returned 0 after 0 usecs
[  565.656802] calling  0000:01:00.0+ @ 1844, parent: 0000:00:01.0
[  565.656803] calling  0000:00:1f.6+ @ 1834, parent: pci0000:00
[  565.656804] pcieport 0000:01:00.0: late bus suspend
[  565.656804] e1000e 0000:00:1f.6: late bus suspend, may wakeup
[  565.656804] call 0000:01:00.0+ returned 0 after 1 usecs
[  565.656805] call 0000:00:1f.6+ returned 0 after 1 usecs
[  565.656808] calling  0000:00:1f.4+ @ 1839, parent: pci0000:00
[  565.656808] calling  0000:00:1f.2+ @ 1834, parent: pci0000:00
[  565.656809] calling  0000:00:1f.3+ @ 1844, parent: pci0000:00
[  565.656809] pci 0000:00:1f.2: late bus suspend
[  565.656809] pci 0000:00:1f.4: late bus suspend
[  565.656810] snd_hda_intel 0000:00:1f.3: late bus suspend
[  565.656810] call 0000:00:1f.2+ returned 0 after 0 usecs
[  565.656811] call 0000:00:1f.4+ returned 0 after 1 usecs
[  565.656811] call 0000:00:1f.3+ returned 0 after 1 usecs
[  565.656812] calling  0000:00:1f.0+ @ 5, parent: pci0000:00
[  565.656812] calling  0000:00:1d.0+ @ 1834, parent: pci0000:00
[  565.656813] pci 0000:00:1f.0: late bus suspend
[  565.656813] calling  0000:00:1c.4+ @ 1839, parent: pci0000:00
[  565.656814] pcieport 0000:00:1d.0: late bus suspend
[  565.656814] call 0000:00:1f.0+ returned 0 after 1 usecs
[  565.656815] pcieport 0000:00:1c.4: late bus suspend
[  565.656815] call 0000:00:1d.0+ returned 0 after 1 usecs
[  565.656816] call 0000:00:1c.4+ returned 0 after 1 usecs
[  565.656816] calling  0000:00:1b.3+ @ 1807, parent: pci0000:00
[  565.656817] pcieport 0000:00:1b.3: late bus suspend
[  565.656818] call 0000:00:1b.3+ returned 0 after 0 usecs
[  565.656818] calling  0000:00:1b.0+ @ 1839, parent: pci0000:00
[  565.656819] pcieport 0000:00:1b.0: late bus suspend
[  565.656819] call 0000:00:1b.0+ returned 0 after 0 usecs
[  565.656820] calling  0000:00:17.0+ @ 207, parent: pci0000:00
[  565.656821] calling  0000:00:16.0+ @ 1807, parent: pci0000:00
[  565.656821] calling  0000:00:14.0+ @ 1839, parent: pci0000:00
[  565.656822] ahci 0000:00:17.0: late bus suspend
[  565.656822] mei_me 0000:00:16.0: late power domain suspend
[  565.656823] xhci_hcd 0000:00:14.0: late bus suspend, may wakeup
[  565.656823] call 0000:00:17.0+ returned 0 after 1 usecs
[  565.656824] call 0000:00:16.0+ returned 0 after 1 usecs
[  565.656824] call 0000:00:14.0+ returned 0 after 1 usecs
[  565.656824] calling  0000:00:01.0+ @ 1806, parent: pci0000:00
[  565.656825] pcieport 0000:00:01.0: late bus suspend
[  565.656826] call 0000:00:01.0+ returned 0 after 0 usecs
[  565.656826] calling  0000:00:00.0+ @ 1780, parent: pci0000:00
[  565.656827] skl_uncore 0000:00:00.0: late bus suspend
[  565.656828] call 0000:00:00.0+ returned 0 after 0 usecs
[  565.656902] calling  regulator.0+ @ 2130, parent: reg-dummy
[  565.656903] regulator regulator.0: late class suspend
[  565.656904] call regulator.0+ returned 0 after 1 usecs
[  565.662769] xhci_hcd 0000:08:00.0: late bus suspend, may wakeup
[  565.668790] pci 0000:05:00.0: late bus suspend
[  565.674804] call 0000:08:00.0+ returned 0 after 11753 usecs
[  565.679613] call 0000:05:00.0+ returned 0 after 10570 usecs
[  565.685076] calling  0000:00:1c.0+ @ 1844, parent: pci0000:00
[  565.691099] calling  0000:00:1b.2+ @ 5, parent: pci0000:00
[  565.696072] pcieport 0000:00:1c.0: late bus suspend
[  565.701418] pcieport 0000:00:1b.2: late bus suspend
[  565.707417] call 0000:00:1c.0+ returned 0 after 11080 usecs
[  565.713283] call 0000:00:1b.2+ returned 0 after 11587 usecs
[  566.016916] calling  0000:03:00.1+ @ 1794, parent: 0000:02:00.0
[  566.016931] calling  PNP0C0B:04+ @ 2130, parent: platform
[  566.022946] snd_hda_intel 0000:03:00.1: noirq bus suspend
[  566.028446] acpi-fan PNP0C0B:04: noirq power domain suspend
[  566.039619] call PNP0C0B:04+ returned 0 after 10912 usecs
[  566.045120] calling  PNP0C0B:03+ @ 2130, parent: platform
[  566.050632] acpi-fan PNP0C0B:03: noirq power domain suspend
[  566.052494] call 0000:03:00.1+ returned 0 after 28856 usecs
[  566.056292] call PNP0C0B:03+ returned 0 after 5528 usecs
[  566.067403] calling  PNP0C0B:02+ @ 2130, parent: platform
[  566.072888] acpi-fan PNP0C0B:02: noirq power domain suspend
[  566.078539] call PNP0C0B:02+ returned 0 after 5519 usecs
[  566.083923] calling  PNP0C0B:01+ @ 2130, parent: platform
[  566.089390] acpi-fan PNP0C0B:01: noirq power domain suspend
[  566.095057] call PNP0C0B:01+ returned 0 after 5533 usecs
[  566.100476] calling  PNP0C0B:00+ @ 2130, parent: platform
[  566.105936] acpi-fan PNP0C0B:00: noirq power domain suspend
[  566.111577] call PNP0C0B:00+ returned 0 after 5508 usecs
[  566.116984] calling  PNP0C14:01+ @ 2130, parent: platform
[  566.122472] acpi-wmi PNP0C14:01: noirq power domain suspend
[  566.128121] call PNP0C14:01+ returned 0 after 5516 usecs
[  566.133529] calling  PNP0C14:00+ @ 2130, parent: pci0000:00
[  566.139198] acpi-wmi PNP0C14:00: noirq power domain suspend
[  566.144850] call PNP0C14:00+ returned 0 after 5518 usecs
[  566.150270] calling  0000:08:00.0+ @ 1794, parent: 0000:00:1c.0
[  566.150273] calling  0000:05:00.0+ @ 5, parent: 0000:00:1b.2
[  566.150275] calling  0000:03:00.0+ @ 207, parent: 0000:02:00.0
[  566.150277] amdgpu 0000:03:00.0: noirq bus suspend
[  566.150277] call 0000:03:00.0+ returned 0 after 1 usecs
[  566.150280] calling  0000:02:00.0+ @ 1844, parent: 0000:01:00.0
[  566.150281] pcieport 0000:02:00.0: noirq bus suspend
[  566.150284] calling  0000:00:1f.6+ @ 1811, parent: pci0000:00
[  566.150285] e1000e 0000:00:1f.6: noirq bus suspend, may wakeup
[  566.150285] calling  0000:00:1f.4+ @ 1817, parent: pci0000:00
[  566.150286] pci 0000:00:1f.4: noirq bus suspend
[  566.150293] calling  0000:00:1f.3+ @ 1780, parent: pci0000:00
[  566.150294] snd_hda_intel 0000:00:1f.3: noirq bus suspend
[  566.150297] calling  0000:00:1f.2+ @ 1834, parent: pci0000:00
[  566.150297] pci 0000:00:1f.2: noirq bus suspend
[  566.150488] call 0000:00:1f.4+ returned 0 after 197 usecs
[  566.150491] calling  0000:00:1f.0+ @ 1817, parent: pci0000:00
[  566.150491] pci 0000:00:1f.0: noirq bus suspend
[  566.150507] call 0000:00:1f.2+ returned 0 after 204 usecs
[  566.150510] calling  0000:00:1d.0+ @ 1806, parent: pci0000:00
[  566.150511] pcieport 0000:00:1d.0: noirq bus suspend
[  566.150511] call 0000:00:1d.0+ returned 0 after 0 usecs
[  566.150517] calling  0000:00:1c.4+ @ 1839, parent: pci0000:00
[  566.150519] pcieport 0000:00:1c.4: noirq bus suspend
[  566.150519] calling  0000:00:1b.3+ @ 1807, parent: pci0000:00
[  566.150519] call 0000:00:1c.4+ returned 0 after 1 usecs
[  566.150520] pcieport 0000:00:1b.3: noirq bus suspend
[  566.150520] call 0000:00:1b.3+ returned 0 after 0 usecs
[  566.150521] calling  0000:00:1b.0+ @ 1807, parent: pci0000:00
[  566.150522] pcieport 0000:00:1b.0: noirq bus suspend
[  566.150522] call 0000:00:1b.0+ returned 0 after 0 usecs
[  566.150527] calling  0000:00:17.0+ @ 1807, parent: pci0000:00
[  566.150528] ahci 0000:00:17.0: noirq bus suspend
[  566.150549] calling  0000:00:16.0+ @ 1841, parent: pci0000:00
[  566.150550] mei_me 0000:00:16.0: noirq power domain suspend
[  566.150555] calling  0000:00:14.0+ @ 1842, parent: pci0000:00
[  566.150556] xhci_hcd 0000:00:14.0: noirq bus suspend, may wakeup
[  566.150569] calling  0000:00:00.0+ @ 1803, parent: pci0000:00
[  566.150570] skl_uncore 0000:00:00.0: noirq bus suspend
[  566.150670] call 0000:00:1f.0+ returned 0 after 175 usecs
[  566.150728] call 0000:00:00.0+ returned 0 after 154 usecs
[  566.156292] xhci_hcd 0000:08:00.0: noirq bus suspend, may wakeup
[  566.162062] pci 0000:05:00.0: noirq bus suspend
[  566.168493] call 0000:00:1f.6+ returned 0 after 17781 usecs
[  566.168500] call 0000:00:16.0+ returned 0 after 17529 usecs
[  566.168509] call 0000:02:00.0+ returned 0 after 17801 usecs
[  566.168510] call 0000:00:17.0+ returned 0 after 17560 usecs
[  566.168512] calling  0000:01:00.0+ @ 207, parent: 0000:00:01.0
[  566.168513] pcieport 0000:01:00.0: noirq bus suspend
[  566.168940] call 0000:00:1f.3+ returned 0 after 18209 usecs
[  566.172983] call 0000:05:00.0+ returned 0 after 10665 usecs
[  566.184508] call 0000:08:00.0+ returned 0 after 27555 usecs
[  566.189277] calling  0000:00:1b.2+ @ 1839, parent: pci0000:00
[  566.192491] call 0000:01:00.0+ returned 0 after 23416 usecs
[  566.192493] calling  0000:00:01.0+ @ 1838, parent: pci0000:00
[  566.192494] pcieport 0000:00:01.0: noirq bus suspend
[  566.195119] calling  0000:00:1c.0+ @ 1806, parent: pci0000:00
[  566.201028] pcieport 0000:00:1b.2: noirq bus suspend
[  566.201077] call 0000:00:1b.2+ returned 0 after 48 usecs
[  566.206843] pcieport 0000:00:1c.0: noirq bus suspend
[  566.211488] call 0000:00:14.0+ returned 0 after 59504 usecs
[  566.232724] call 0000:00:01.0+ returned 0 after 39287 usecs
[  566.236501] call 0000:00:1c.0+ returned 0 after 28963 usecs
[  566.497390] ACPI: Preparing to enter system sleep state S3
[  566.504655] PM: Saving platform NVS memory
[  566.508816] Disabling non-boot CPUs ...
[  566.529295] device: 'machinecheck1': device_unregister
[  566.534562] PM: Removing info for machinecheck:machinecheck1
[  566.540350] device: 'index0': device_unregister
[  566.545002] PM: Removing info for No Bus:index0
[  566.549592] device: 'index1': device_unregister
[  566.554248] PM: Removing info for No Bus:index1
[  566.558841] device: 'index2': device_unregister
[  566.563451] PM: Removing info for No Bus:index2
[  566.568078] device: 'index3': device_unregister
[  566.572671] PM: Removing info for No Bus:index3
[  566.577300] device: 'cache': device_unregister
[  566.581828] PM: Removing info for No Bus:cache
[  566.587412] smpboot: CPU 1 is now offline
[  566.609212] device: 'machinecheck2': device_unregister
[  566.614476] PM: Removing info for machinecheck:machinecheck2
[  566.620286] device: 'index0': device_unregister
[  566.624935] PM: Removing info for No Bus:index0
[  566.629565] device: 'index1': device_unregister
[  566.634208] PM: Removing info for No Bus:index1
[  566.638826] device: 'index2': device_unregister
[  566.643477] PM: Removing info for No Bus:index2
[  566.648133] device: 'index3': device_unregister
[  566.652788] PM: Removing info for No Bus:index3
[  566.657381] device: 'cache': device_unregister
[  566.661950] PM: Removing info for No Bus:cache
[  566.667788] smpboot: CPU 2 is now offline
[  566.693146] device: 'machinecheck3': device_unregister
[  566.698424] PM: Removing info for machinecheck:machinecheck3
[  566.704194] device: 'index0': device_unregister
[  566.708821] PM: Removing info for No Bus:index0
[  566.713455] device: 'index1': device_unregister
[  566.718081] PM: Removing info for No Bus:index1
[  566.722674] device: 'index2': device_unregister
[  566.727292] PM: Removing info for No Bus:index2
[  566.731886] device: 'index3': device_unregister
[  566.736497] PM: Removing info for No Bus:index3
[  566.741117] device: 'cache': device_unregister
[  566.745645] PM: Removing info for No Bus:cache
[  566.751193] smpboot: CPU 3 is now offline
[  566.773092] device: 'machinecheck4': device_unregister
[  566.778319] PM: Removing info for machinecheck:machinecheck4
[  566.784127] device: 'index0': device_unregister
[  566.788749] PM: Removing info for No Bus:index0
[  566.793326] device: 'index1': device_unregister
[  566.797918] PM: Removing info for No Bus:index1
[  566.802545] device: 'index2': device_unregister
[  566.807165] PM: Removing info for No Bus:index2
[  566.811760] device: 'index3': device_unregister
[  566.816376] PM: Removing info for No Bus:index3
[  566.820983] device: 'cache': device_unregister
[  566.825525] PM: Removing info for No Bus:cache
[  566.830094] irq_migrate_all_off_this_cpu: 5 callbacks suppressed
[  566.830095] IRQ 126: no longer affine to CPU4
[  566.840626] IRQ 127: no longer affine to CPU4
[  566.846057] smpboot: CPU 4 is now offline
[  566.865022] device: 'machinecheck5': device_unregister
[  566.870277] PM: Removing info for machinecheck:machinecheck5
[  566.876037] device: 'index0': device_unregister
[  566.880674] PM: Removing info for No Bus:index0
[  566.885340] device: 'index1': device_unregister
[  566.889949] PM: Removing info for No Bus:index1
[  566.894601] device: 'index2': device_unregister
[  566.899211] PM: Removing info for No Bus:index2
[  566.903821] device: 'index3': device_unregister
[  566.908426] PM: Removing info for No Bus:index3
[  566.913015] device: 'cache': device_unregister
[  566.917566] PM: Removing info for No Bus:cache
[  566.922117] IRQ 122: no longer affine to CPU5
[  566.926564] IRQ 123: no longer affine to CPU5
[  566.930949] IRQ 130: no longer affine to CPU5
[  566.936373] smpboot: CPU 5 is now offline
[  566.968981] device: 'machinecheck6': device_unregister
[  566.974240] PM: Removing info for machinecheck:machinecheck6
[  566.980045] device: 'index0': device_unregister
[  566.984699] PM: Removing info for No Bus:index0
[  566.989329] device: 'index1': device_unregister
[  566.993973] PM: Removing info for No Bus:index1
[  566.998623] device: 'index2': device_unregister
[  567.003253] PM: Removing info for No Bus:index2
[  567.007852] device: 'index3': device_unregister
[  567.012480] PM: Removing info for No Bus:index3
[  567.017125] device: 'cache': device_unregister
[  567.021678] PM: Removing info for No Bus:cache
[  567.026227] IRQ 121: no longer affine to CPU6
[  567.030651] IRQ 124: no longer affine to CPU6
[  567.035089] IRQ 125: no longer affine to CPU6
[  567.040553] smpboot: CPU 6 is now offline
[  567.060925] device: 'machinecheck7': device_unregister
[  567.066192] PM: Removing info for machinecheck:machinecheck7
[  567.072020] device: 'index0': device_unregister
[  567.076666] PM: Removing info for No Bus:index0
[  567.081290] device: 'index1': device_unregister
[  567.085930] PM: Removing info for No Bus:index1
[  567.090595] device: 'index2': device_unregister
[  567.095231] PM: Removing info for No Bus:index2
[  567.099847] device: 'index3': device_unregister
[  567.104459] PM: Removing info for No Bus:index3
[  567.109079] device: 'cache': device_unregister
[  567.113587] PM: Removing info for No Bus:cache
[  567.118156] IRQ 4: no longer affine to CPU7
[  567.122406] IRQ 5: no longer affine to CPU7
[  567.127661] smpboot: CPU 7 is now offline
[  567.131942] PM: Calling kvm_suspend+0x0/0x20 [kvm]
[  567.136819] PM: Calling mce_syscore_suspend+0x0/0x10
[  567.141853] PM: Calling ledtrig_cpu_syscore_suspend+0x0/0x20
[  567.147608] PM: Calling timekeeping_suspend+0x0/0x290
[  567.152849] PM: Calling irq_gc_suspend+0x0/0x60
[  567.157436] PM: Calling save_ioapic_entries+0x0/0x80
[  567.163683] PM: Calling i8259A_suspend+0x0/0x30
[  567.168321] PM: Calling fw_suspend+0x0/0x20
[  567.172576] PM: Calling acpi_save_bm_rld+0x0/0x20
[  567.177361] PM: Calling lapic_suspend+0x0/0x1a0
[  567.182931] ACPI: Low-level resume complete
[  567.187232] PM: Restoring platform NVS memory
[  567.191677] PM: Calling bsp_resume+0x0/0x20
[  567.195914] PM: Calling lapic_resume+0x0/0x260
[  567.200416] PM: Calling acpi_restore_bm_rld+0x0/0x40
[  567.205475] PM: Calling irqrouter_resume+0x0/0x50
[  567.210267] PM: Calling i8259A_resume+0x0/0x30
[  567.214926] PM: Calling i8237A_resume+0x0/0x90
[  567.219562] PM: Calling ioapic_resume+0x0/0xb0
[  567.224355] PM: Calling irq_gc_resume+0x0/0x60
[  567.228950] PM: Calling irq_pm_syscore_resume+0x0/0x10
[  567.234194] PM: Calling timekeeping_resume+0x0/0x1b0
[  567.239376] PM: Calling ledtrig_cpu_syscore_resume+0x0/0x10
[  567.245063] PM: Calling mce_syscore_resume+0x0/0x30
[  567.250069] PM: Calling mc_bp_resume+0x0/0x50
[  567.254521] PM: Calling kvm_resume+0x0/0x30 [kvm]
[  567.259307] Enabling non-boot CPUs ...
[  567.263273] x86: Booting SMP configuration:
[  567.267528] smpboot: Booting Node 0 Processor 1 APIC 0x2
[  567.273342] device: 'cache': device_add
[  567.277260] PM: Adding info for No Bus:cache
[  567.281630]  cache: parent cpu1 should not be sleeping
[  567.286888] device: 'index0': device_add
[  567.290915] PM: Adding info for No Bus:index0
[  567.295331] device: 'index1': device_add
[  567.299326] PM: Adding info for No Bus:index1
[  567.303759] device: 'index2': device_add
[  567.307776] PM: Adding info for No Bus:index2
[  567.312215] device: 'index3': device_add
[  567.316247] PM: Adding info for No Bus:index3
[  567.320702] device: 'machinecheck1': device_add
[  567.325321] PM: Adding info for machinecheck:machinecheck1
[  567.331116] CPU1 is up
[  567.333532] smpboot: Booting Node 0 Processor 2 APIC 0x4
[  567.339357] device: 'cache': device_add
[  567.343284] PM: Adding info for No Bus:cache
[  567.347608]  cache: parent cpu2 should not be sleeping
[  567.352841] device: 'index0': device_add
[  567.356870] PM: Adding info for No Bus:index0
[  567.361320] device: 'index1': device_add
[  567.365325] PM: Adding info for No Bus:index1
[  567.369753] device: 'index2': device_add
[  567.373760] PM: Adding info for No Bus:index2
[  567.378203] device: 'index3': device_add
[  567.382216] PM: Adding info for No Bus:index3
[  567.386656] device: 'machinecheck2': device_add
[  567.391286] PM: Adding info for machinecheck:machinecheck2
[  567.397129] CPU2 is up
[  567.399568] smpboot: Booting Node 0 Processor 3 APIC 0x6
[  567.405382] device: 'cache': device_add
[  567.409300] PM: Adding info for No Bus:cache
[  567.413661]  cache: parent cpu3 should not be sleeping
[  567.418908] device: 'index0': device_add
[  567.422926] PM: Adding info for No Bus:index0
[  567.427377] device: 'index1': device_add
[  567.431405] PM: Adding info for No Bus:index1
[  567.435843] device: 'index2': device_add
[  567.439877] PM: Adding info for No Bus:index2
[  567.444338] device: 'index3': device_add
[  567.448366] PM: Adding info for No Bus:index3
[  567.452807] device: 'machinecheck3': device_add
[  567.457440] PM: Adding info for machinecheck:machinecheck3
[  567.463294] CPU3 is up
[  567.465690] smpboot: Booting Node 0 Processor 4 APIC 0x1
[  567.471606] device: 'cache': device_add
[  567.475545] PM: Adding info for No Bus:cache
[  567.479912]  cache: parent cpu4 should not be sleeping
[  567.485184] device: 'index0': device_add
[  567.489192] PM: Adding info for No Bus:index0
[  567.493625] device: 'index1': device_add
[  567.497640] PM: Adding info for No Bus:index1
[  567.502076] device: 'index2': device_add
[  567.506061] PM: Adding info for No Bus:index2
[  567.510456] device: 'index3': device_add
[  567.514467] PM: Adding info for No Bus:index3
[  567.518945] device: 'machinecheck4': device_add
[  567.523626] PM: Adding info for machinecheck:machinecheck4
[  567.529526] CPU4 is up
[  567.531986] smpboot: Booting Node 0 Processor 5 APIC 0x3
[  567.537880] device: 'cache': device_add
[  567.541800] PM: Adding info for No Bus:cache
[  567.546117]  cache: parent cpu5 should not be sleeping
[  567.551358] device: 'index0': device_add
[  567.555372] PM: Adding info for No Bus:index0
[  567.559797] device: 'index1': device_add
[  567.563775] PM: Adding info for No Bus:index1
[  567.568175] device: 'index2': device_add
[  567.572195] PM: Adding info for No Bus:index2
[  567.576590] device: 'index3': device_add
[  567.580622] PM: Adding info for No Bus:index3
[  567.585050] device: 'machinecheck5': device_add
[  567.589675] PM: Adding info for machinecheck:machinecheck5
[  567.595646] CPU5 is up
[  567.598100] smpboot: Booting Node 0 Processor 6 APIC 0x5
[  567.603974] device: 'cache': device_add
[  567.607876] PM: Adding info for No Bus:cache
[  567.612201]  cache: parent cpu6 should not be sleeping
[  567.617423] device: 'index0': device_add
[  567.621454] PM: Adding info for No Bus:index0
[  567.625906] device: 'index1': device_add
[  567.629926] PM: Adding info for No Bus:index1
[  567.634354] device: 'index2': device_add
[  567.638386] PM: Adding info for No Bus:index2
[  567.642823] device: 'index3': device_add
[  567.646826] PM: Adding info for No Bus:index3
[  567.651283] device: 'machinecheck6': device_add
[  567.655923] PM: Adding info for machinecheck:machinecheck6
[  567.661896] CPU6 is up
[  567.664324] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  567.670136] device: 'cache': device_add
[  567.674063] PM: Adding info for No Bus:cache
[  567.678432]  cache: parent cpu7 should not be sleeping
[  567.683671] device: 'index0': device_add
[  567.687698] PM: Adding info for No Bus:index0
[  567.692144] device: 'index1': device_add
[  567.696158] PM: Adding info for No Bus:index1
[  567.700602] device: 'index2': device_add
[  567.704646] PM: Adding info for No Bus:index2
[  567.709087] device: 'index3': device_add
[  567.713100] PM: Adding info for No Bus:index3
[  567.717539] device: 'machinecheck7': device_add
[  567.722179] PM: Adding info for machinecheck:machinecheck7
[  567.728215] CPU7 is up
[  567.736489] ACPI: Waking up from system sleep state S3
[  567.758788] calling  0000:00:00.0+ @ 1838, parent: pci0000:00
[  567.758789] calling  0000:00:01.0+ @ 1806, parent: pci0000:00
[  567.758791] calling  0000:00:14.0+ @ 1842, parent: pci0000:00
[  567.758793] pcieport 0000:00:01.0: noirq bus resume
[  567.758795] calling  0000:00:16.0+ @ 1839, parent: pci0000:00
[  567.758797] mei_me 0000:00:16.0: noirq power domain resume
[  567.758798] calling  0000:00:17.0+ @ 1794, parent: pci0000:00
[  567.758799] ahci 0000:00:17.0: noirq bus resume
[  567.758801] calling  0000:00:1b.0+ @ 207, parent: pci0000:00
[  567.758802] pcieport 0000:00:1b.0: noirq bus resume
[  567.758813] calling  0000:00:1b.2+ @ 5, parent: pci0000:00
[  567.758813] pcieport 0000:00:1b.2: noirq bus resume
[  567.758815] calling  0000:00:1b.3+ @ 1811, parent: pci0000:00
[  567.758815] pcieport 0000:00:1b.3: noirq bus resume
[  567.758819] calling  0000:00:1c.0+ @ 1780, parent: pci0000:00
[  567.758820] pcieport 0000:00:1c.0: noirq bus resume
[  567.758828] calling  0000:00:1c.4+ @ 1844, parent: pci0000:00
[  567.758829] pcieport 0000:00:1c.4: noirq bus resume
[  567.758831] calling  0000:00:1d.0+ @ 1807, parent: pci0000:00
[  567.758832] pcieport 0000:00:1d.0: noirq bus resume
[  567.758842] calling  0000:00:1f.0+ @ 1841, parent: pci0000:00
[  567.758843] pci 0000:00:1f.0: noirq bus resume
[  567.758846] calling  0000:00:1f.2+ @ 1834, parent: pci0000:00
[  567.758846] pci 0000:00:1f.2: noirq bus resume
[  567.758953] call 0000:00:1f.0+ returned 0 after 107 usecs
[  567.758955] call 0000:00:1f.2+ returned 0 after 106 usecs
[  567.758955] calling  0000:00:1f.3+ @ 1841, parent: pci0000:00
[  567.758956] snd_hda_intel 0000:00:1f.3: noirq bus resume
[  567.758957] calling  0000:00:1f.4+ @ 1834, parent: pci0000:00
[  567.758958] pci 0000:00:1f.4: noirq bus resume
[  567.759040] call 0000:00:1b.2+ returned 0 after 221 usecs
[  567.759041] calling  0000:00:1f.6+ @ 5, parent: pci0000:00
[  567.759042] call 0000:00:1f.4+ returned 0 after 82 usecs
[  567.759042] e1000e 0000:00:1f.6: noirq bus resume
[  567.759051] calling  0000:05:00.0+ @ 1767, parent: 0000:00:1b.2
[  567.759052] pci 0000:05:00.0: noirq bus resume
[  567.759191] call 0000:05:00.0+ returned 0 after 135 usecs
[  567.759353] call 0000:00:01.0+ returned 0 after 549 usecs
[  567.759356] calling  0000:01:00.0+ @ 1834, parent: 0000:00:01.0
[  567.759356] pcieport 0000:01:00.0: noirq bus resume
[  567.759438] call 0000:01:00.0+ returned 0 after 80 usecs
[  567.759442] calling  0000:02:00.0+ @ 1803, parent: 0000:01:00.0
[  567.759443] pcieport 0000:02:00.0: noirq bus resume
[  567.759516] call 0000:02:00.0+ returned 0 after 72 usecs
[  567.759518] calling  0000:03:00.0+ @ 1840, parent: 0000:02:00.0
[  567.759519] amdgpu 0000:03:00.0: noirq bus resume
[  567.759635] call 0000:03:00.0+ returned 0 after 113 usecs
[  567.759638] calling  0000:03:00.1+ @ 1832, parent: 0000:02:00.0
[  567.759639] snd_hda_intel 0000:03:00.1: noirq bus resume
[  567.759708] call 0000:03:00.1+ returned 0 after 68 usecs
[  567.764708] skl_uncore 0000:00:00.0: noirq bus resume
[  567.770471] xhci_hcd 0000:00:14.0: noirq bus resume
[  567.775056] call 0000:00:1d.0+ returned 0 after 15844 usecs
[  567.775063] call 0000:00:1b.3+ returned 0 after 15866 usecs
[  567.775074] call 0000:00:1c.4+ returned 0 after 15864 usecs
[  567.775086] call 0000:00:1b.0+ returned 0 after 15902 usecs
[  567.775178] call 0000:00:16.0+ returned 0 after 15998 usecs
[  567.775190] call 0000:00:17.0+ returned 0 after 16007 usecs
[  567.775265] call 0000:00:1c.0+ returned 0 after 16059 usecs
[  567.775266] calling  0000:08:00.0+ @ 1775, parent: 0000:00:1c.0
[  567.775267] xhci_hcd 0000:08:00.0: noirq bus resume
[  567.775268] calling  PNP0C14:00+ @ 2130, parent: pci0000:00
[  567.775269] acpi-wmi PNP0C14:00: noirq power domain resume
[  567.775270] call PNP0C14:00+ returned 0 after 1 usecs
[  567.775271] calling  PNP0C14:01+ @ 2130, parent: platform
[  567.775271] acpi-wmi PNP0C14:01: noirq power domain resume
[  567.775272] call PNP0C14:01+ returned 0 after 0 usecs
[  567.775272] calling  PNP0C0B:00+ @ 2130, parent: platform
[  567.775273] acpi-fan PNP0C0B:00: noirq power domain resume
[  567.775273] call PNP0C0B:00+ returned 0 after 0 usecs
[  567.775274] calling  PNP0C0B:01+ @ 2130, parent: platform
[  567.775274] acpi-fan PNP0C0B:01: noirq power domain resume
[  567.775274] call PNP0C0B:01+ returned 0 after 0 usecs
[  567.775275] calling  PNP0C0B:02+ @ 2130, parent: platform
[  567.775275] acpi-fan PNP0C0B:02: noirq power domain resume
[  567.775275] call PNP0C0B:02+ returned 0 after 0 usecs
[  567.775276] calling  PNP0C0B:03+ @ 2130, parent: platform
[  567.775276] acpi-fan PNP0C0B:03: noirq power domain resume
[  567.775276] call PNP0C0B:03+ returned 0 after 0 usecs
[  567.775277] calling  PNP0C0B:04+ @ 2130, parent: platform
[  567.775277] acpi-fan PNP0C0B:04: noirq power domain resume
[  567.775278] call PNP0C0B:04+ returned 0 after 0 usecs
[  567.776338] call 0000:00:00.0+ returned 0 after 11357 usecs
[  567.783156] call 0000:00:1f.3+ returned 0 after 23633 usecs
[  567.783169] call 0000:00:1f.6+ returned 0 after 23561 usecs
[  567.795164] call 0000:08:00.0+ returned 0 after 19430 usecs
[  567.811069] call 0000:00:14.0+ returned 0 after 39647 usecs
[  568.232960] calling  regulator.0+ @ 2130, parent: reg-dummy
[  568.238611] regulator regulator.0: early class resume
[  568.243750] call regulator.0+ returned 0 after 5018 usecs
[  568.249315] calling  PNP0C14:00+ @ 2130, parent: pci0000:00
[  568.255032] acpi-wmi PNP0C14:00: early power domain resume
[  568.260623] call PNP0C14:00+ returned 0 after 5460 usecs
[  568.266034] calling  PNP0C14:01+ @ 2130, parent: platform
[  568.271542] acpi-wmi PNP0C14:01: early power domain resume
[  568.277159] call PNP0C14:01+ returned 0 after 5485 usecs
[  568.282575] calling  PNP0C0B:00+ @ 2130, parent: platform
[  568.288061] acpi-fan PNP0C0B:00: early power domain resume
[  568.303670] call PNP0C0B:00+ returned 0 after 15242 usecs
[  568.309178] calling  PNP0C0B:01+ @ 2130, parent: platform
[  568.314704] acpi-fan PNP0C0B:01: early power domain resume
[  568.331663] call PNP0C0B:01+ returned 0 after 16561 usecs
[  568.337163] calling  PNP0C0B:02+ @ 2130, parent: platform
[  568.342647] acpi-fan PNP0C0B:02: early power domain resume
[  568.359677] call PNP0C0B:02+ returned 0 after 16631 usecs
[  568.365227] calling  PNP0C0B:03+ @ 2130, parent: platform
[  568.370752] acpi-fan PNP0C0B:03: early power domain resume
[  568.387669] call PNP0C0B:03+ returned 0 after 16520 usecs
[  568.393182] calling  PNP0C0B:04+ @ 2130, parent: platform
[  568.398686] acpi-fan PNP0C0B:04: early power domain resume
[  568.415665] call PNP0C0B:04+ returned 0 after 16581 usecs
[  568.421331] calling  0000:00:00.0+ @ 1814, parent: pci0000:00
[  568.421338] calling  0000:00:01.0+ @ 1818, parent: pci0000:00
[  568.421363] calling  0000:00:14.0+ @ 1804, parent: pci0000:00
[  568.421365] xhci_hcd 0000:00:14.0: bus resume
[  568.421371] calling  0000:00:16.0+ @ 1805, parent: pci0000:00
[  568.421372] mei_me 0000:00:16.0: power domain resume
[  568.421377] calling  0000:00:17.0+ @ 1766, parent: pci0000:00
[  568.421378] ahci 0000:00:17.0: bus resume
[  568.421381] calling  0000:00:1b.0+ @ 1815, parent: pci0000:00
[  568.421383] pcieport 0000:00:1b.0: bus resume
[  568.421384] call 0000:00:1b.0+ returned 0 after 2 usecs
[  568.421387] calling  0000:00:1b.2+ @ 1783, parent: pci0000:00
[  568.421388] pcieport 0000:00:1b.2: bus resume
[  568.421388] calling  0000:00:1b.3+ @ 1815, parent: pci0000:00
[  568.421389] pcieport 0000:00:1b.3: bus resume
[  568.421389] call 0000:00:1b.2+ returned 0 after 1 usecs
[  568.421390] call 0000:00:1b.3+ returned 0 after 0 usecs
[  568.421393] calling  0000:00:1c.0+ @ 1783, parent: pci0000:00
[  568.421394] calling  0000:00:1c.4+ @ 1815, parent: pci0000:00
[  568.421394] pcieport 0000:00:1c.0: bus resume
[  568.421395] pcieport 0000:00:1c.4: bus resume
[  568.421395] call 0000:00:1c.0+ returned 0 after 1 usecs
[  568.421396] call 0000:00:1c.4+ returned 0 after 1 usecs
[  568.421397] calling  0000:00:1d.0+ @ 1783, parent: pci0000:00
[  568.421398] pcieport 0000:00:1d.0: bus resume
[  568.421399] call 0000:00:1d.0+ returned 0 after 0 usecs
[  568.421400] calling  0000:00:1f.0+ @ 1815, parent: pci0000:00
[  568.421400] pci 0000:00:1f.0: bus resume
[  568.421401] calling  0000:00:1f.2+ @ 1783, parent: pci0000:00
[  568.421401] call 0000:00:1f.0+ returned 0 after 1 usecs
[  568.421402] pci 0000:00:1f.2: bus resume
[  568.421402] call 0000:00:1f.2+ returned 0 after 1 usecs
[  568.421403] calling  0000:00:1f.3+ @ 1815, parent: pci0000:00
[  568.421404] snd_hda_intel 0000:00:1f.3: bus resume
[  568.421406] calling  0000:00:1f.4+ @ 1783, parent: pci0000:00
[  568.421406] pci 0000:00:1f.4: bus resume
[  568.421407] call 0000:00:1f.4+ returned 0 after 0 usecs
[  568.421409] calling  0000:00:1f.6+ @ 1783, parent: pci0000:00
[  568.421410] e1000e 0000:00:1f.6: bus resume
[  568.421459] call 0000:00:17.0+ returned 0 after 79 usecs
[  568.421488] calling  reg-dummy+ @ 2130, parent: platform
[  568.421489] reg-dummy reg-dummy: bus resume
[  568.421489] call reg-dummy+ returned 0 after 0 usecs
[  568.421529] calling  PNP0C0E:00+ @ 2130, parent: LNXSYBUS:00
[  568.421530] button PNP0C0E:00: driver resume
[  568.421531] call PNP0C0E:00+ returned 0 after 0 usecs
[  568.421532] calling  PNP0C0C:00+ @ 2130, parent: LNXSYBUS:00
[  568.421532] button PNP0C0C:00: driver resume
[  568.421532] call PNP0C0C:00+ returned 0 after 0 usecs
[  568.421535] calling  LNXTHERM:00+ @ 2130, parent: LNXSYBUS:01
[  568.421536] thermal LNXTHERM:00: driver resume
[  568.421559] calling  0000:05:00.0+ @ 1810, parent: 0000:00:1b.2
[  568.421560] pci 0000:05:00.0: bus resume
[  568.421561] call 0000:05:00.0+ returned 0 after 0 usecs
[  568.421563] calling  0000:08:00.0+ @ 1808, parent: 0000:00:1c.0
[  568.421564] xhci_hcd 0000:08:00.0: bus resume
[  568.421692] calling  ata1+ @ 1806, parent: 0000:00:17.0
[  568.421693] calling  ata2+ @ 1782, parent: 0000:00:17.0
[  568.421693]  ata1: type resume
[  568.421694]  ata2: type resume
[  568.421695] calling  ata3+ @ 1823, parent: 0000:00:17.0
[  568.421696]  ata3: type resume
[  568.421697] call ata1+ returned 0 after 3 usecs
[  568.421698] call ata2+ returned 0 after 4 usecs
[  568.421700] calling  ata4+ @ 1806, parent: 0000:00:17.0
[  568.421700] call ata3+ returned 0 after 3 usecs
[  568.421700]  ata4: type resume
[  568.421702] calling  ata5+ @ 1782, parent: 0000:00:17.0
[  568.421702] calling  ata6+ @ 1823, parent: 0000:00:17.0
[  568.421702]  ata5: type resume
[  568.421703]  ata6: type resume
[  568.421703] call ata4+ returned 0 after 3 usecs
[  568.421704] call ata5+ returned 0 after 2 usecs
[  568.421705] calling  host0+ @ 1806, parent: ata1
[  568.421706] scsi host0: bus resume
[  568.421706] call ata6+ returned 0 after 3 usecs
[  568.421706] call host0+ returned 0 after 1 usecs
[  568.421708] calling  host1+ @ 1823, parent: ata2
[  568.421708] scsi host1: bus resume
[  568.421709] call host1+ returned 0 after 0 usecs
[  568.421710] calling  host2+ @ 1823, parent: ata3
[  568.421711] scsi host2: bus resume
[  568.421713] call host2+ returned 0 after 1 usecs
[  568.421716] calling  host3+ @ 1823, parent: ata4
[  568.421719] scsi host3: bus resume
[  568.421719] call host3+ returned 0 after 2 usecs
[  568.421721] calling  host4+ @ 1823, parent: ata5
[  568.421721] scsi host4: bus resume
[  568.421722] call host4+ returned 0 after 0 usecs
[  568.421723] calling  host5+ @ 1823, parent: ata6
[  568.421723] scsi host5: bus resume
[  568.421724] call host5+ returned 0 after 0 usecs
[  568.421726] calling  target0:0:0+ @ 1823, parent: host0
[  568.421726] scsi target0:0:0: bus resume
[  568.421727] call target0:0:0+ returned 0 after 0 usecs
[  568.421728] calling  0:0:0:0+ @ 1823, parent: target0:0:0
[  568.421728] sd 0:0:0:0: bus resume
[  568.421733] call 0:0:0:0+ returned 0 after 5 usecs
[  568.421757] call 0000:00:14.0+ returned 0 after 384 usecs
[  568.421760] calling  usb1+ @ 1785, parent: 0000:00:14.0
[  568.421761] calling  usb2+ @ 1842, parent: 0000:00:14.0
[  568.421761] usb usb1: type resume
[  568.421762] usb usb2: type resume
[  568.421764] sd 0:0:0:0: [sda] Starting disk
[  568.421875] usb usb3: root hub lost power or was reset
[  568.421876] usb usb4: root hub lost power or was reset
[  568.421963] call usb2+ returned 0 after 197 usecs
[  568.422020] call usb1+ returned 0 after 252 usecs
[  568.422121] call LNXTHERM:00+ returned 0 after 570 usecs
[  568.422125] calling  LNXTHERM:01+ @ 2130, parent: LNXSYBUS:01
[  568.422126] thermal LNXTHERM:01: driver resume
[  568.422126] call LNXTHERM:01+ returned 0 after 1 usecs
[  568.425858] call 0000:00:1f.3+ returned 0 after 4350 usecs
[  568.425860] calling  hdaudioC0D0+ @ 1804, parent: 0000:00:1f.3
[  568.425861] snd_hda_codec_realtek hdaudioC0D0: driver resume
[  568.427401] skl_uncore 0000:00:00.0: bus resume
[  568.433437] pcieport 0000:00:01.0: bus resume
[  568.433438] call 0000:00:01.0+ returned 0 after 1 usecs
[  568.439486] call 0000:00:00.0+ returned 0 after 11803 usecs
[  568.481449] call 0000:08:00.0+ returned 0 after 58482 usecs
[  568.487277] calling  0000:01:00.0+ @ 1766, parent: 0000:00:01.0
[  568.487292] pcieport 0000:01:00.0: bus resume
[  568.487294] call 0000:01:00.0+ returned 0 after 1 usecs
[  568.491792] calling  usb4+ @ 1780, parent: 0000:08:00.0
[  568.491816] calling  usb3+ @ 1822, parent: 0000:08:00.0
[  568.491817] usb usb3: type resume
[  568.497707] calling  0000:02:00.0+ @ 1819, parent: 0000:01:00.0
[  568.497750] call 0000:00:16.0+ returned 0 after 74588 usecs
[  568.502258] usb usb4: type resume
[  568.503794] device: 'mei::082ee5a7-7c25-470a-9643-0c06f0466ea1:00': device_add
[  568.507703] pcieport 0000:02:00.0: bus resume
[  568.513101] PM: Adding info for mei:mei::082ee5a7-7c25-470a-9643-0c06f0466ea1:00
[  568.518916] call 0000:02:00.0+ returned 0 after 10950 usecs
[  568.524819] device: 'mei::3c4852d6-d47b-4f46-b05e-b5edc1aa440e:01': device_add
[  568.529240] calling  0000:03:00.0+ @ 1812, parent: 0000:02:00.0
[  568.529263] calling  INT0800:00+ @ 2130, parent: 0000:00:1f.0
[  568.529264] platform INT0800:00: bus resume
[  568.529265] call INT0800:00+ returned 0 after 1 usecs
[  568.529265] calling  PNP0103:00+ @ 2130, parent: 0000:00:1f.0
[  568.529266] platform PNP0103:00: bus resume
[  568.529266] call PNP0103:00+ returned 0 after 0 usecs
[  568.529267] calling  PNP0C04:00+ @ 2130, parent: 0000:00:1f.0
[  568.529267] platform PNP0C04:00: bus resume
[  568.529267] call PNP0C04:00+ returned 0 after 0 usecs
[  568.529268] calling  ACPI000C:00+ @ 2130, parent: platform
[  568.529269] platform ACPI000C:00: bus resume
[  568.529269] call ACPI000C:00+ returned 0 after 0 usecs
[  568.529269] calling  PNP0C0E:00+ @ 2130, parent: platform
[  568.529270] platform PNP0C0E:00: bus resume
[  568.529270] call PNP0C0E:00+ returned 0 after 0 usecs
[  568.529270] calling  INT33A1:00+ @ 2130, parent: platform
[  568.529271] platform INT33A1:00: bus resume
[  568.529271] call INT33A1:00+ returned 0 after 0 usecs
[  568.529272] calling  PNP0C0C:00+ @ 2130, parent: platform
[  568.529272] platform PNP0C0C:00: bus resume
[  568.529272] call PNP0C0C:00+ returned 0 after 0 usecs
[  568.529273] calling  PNP0C0B:00+ @ 2130, parent: platform
[  568.529273] acpi-fan PNP0C0B:00: driver resume
[  568.529359] call PNP0C0B:00+ returned 0 after 83 usecs
[  568.529359] calling  PNP0C0B:01+ @ 2130, parent: platform
[  568.529360] acpi-fan PNP0C0B:01: driver resume
[  568.529431] call PNP0C0B:01+ returned 0 after 69 usecs
[  568.529431] calling  PNP0C0B:02+ @ 2130, parent: platform
[  568.529432] acpi-fan PNP0C0B:02: driver resume
[  568.529499] call PNP0C0B:02+ returned 0 after 66 usecs
[  568.529500] calling  PNP0C0B:03+ @ 2130, parent: platform
[  568.529500] acpi-fan PNP0C0B:03: driver resume
[  568.529568] call PNP0C0B:03+ returned 0 after 65 usecs
[  568.529568] calling  PNP0C0B:04+ @ 2130, parent: platform
[  568.529568] acpi-fan PNP0C0B:04: driver resume
[  568.529635] call PNP0C0B:04+ returned 0 after 65 usecs
[  568.529636] calling  LNXPWRBN:00+ @ 2130, parent: LNXSYSTM:00
[  568.529636] button LNXPWRBN:00: driver resume
[  568.529637] call LNXPWRBN:00+ returned 0 after 0 usecs
[  568.529638] calling  00:00+ @ 2130, parent: pnp0
[  568.529639] system 00:00: bus resume
[  568.529639] call 00:00+ returned 0 after 0 usecs
[  568.529640] calling  00:01+ @ 2130, parent: pnp0
[  568.529640] parport_pc 00:01: bus resume
[  568.532037] parport_pc 00:01: activated
[  568.532038] call 00:01+ returned 0 after 2341 usecs
[  568.532038] calling  00:02+ @ 2130, parent: pnp0
[  568.532039] serial 00:02: bus resume
[  568.533772] PM: Adding info for mei:mei::3c4852d6-d47b-4f46-b05e-b5edc1aa440e:01
[  568.533974] serial 00:02: activated
[  568.534880] amdgpu 0000:03:00.0: bus resume
[  568.534894] call 00:02+ returned 0 after 2788 usecs
[  568.534895] calling  00:03+ @ 2130, parent: pnp0
[  568.534895] system 00:03: bus resume
[  568.534896] call 00:03+ returned 0 after 0 usecs
[  568.534896] calling  00:04+ @ 2130, parent: pnp0
[  568.534897] system 00:04: bus resume
[  568.534897] call 00:04+ returned 0 after 0 usecs
[  568.534897] calling  00:05+ @ 2130, parent: pnp0
[  568.534898] rtc_cmos 00:05: bus resume
[  568.535284] call 00:05+ returned 0 after 377 usecs
[  568.535426] calling  00:06+ @ 2130, parent: pnp0
[  568.535426] system 00:06: bus resume
[  568.535426] call 00:06+ returned 0 after 0 usecs
[  568.535427] calling  00:07+ @ 2130, parent: pnp0
[  568.535427] system 00:07: bus resume
[  568.535428] call 00:07+ returned 0 after 0 usecs
[  568.535428] calling  00:08+ @ 2130, parent: pnp0
[  568.535428] system 00:08: bus resume
[  568.535429] call 00:08+ returned 0 after 0 usecs
[  568.535429] calling  00:09+ @ 2130, parent: pnp0
[  568.535430] system 00:09: bus resume
[  568.535430] call 00:09+ returned 0 after 0 usecs
[  568.535430] calling  00:0a+ @ 2130, parent: pnp0
[  568.535431] system 00:0a: bus resume
[  568.535431] call 00:0a+ returned 0 after 0 usecs
[  568.535440] calling  pcspkr+ @ 2130, parent: platform
[  568.535441] platform pcspkr: bus resume
[  568.535441] call pcspkr+ returned 0 after 0 usecs
[  568.535442] calling  vesa-framebuffer.0+ @ 2130, parent: platform
[  568.535442] vesa-framebuffer vesa-framebuffer.0: bus resume
[  568.535443] call vesa-framebuffer.0+ returned 0 after 0 usecs
[  568.535443] calling  alarmtimer+ @ 2130, parent: platform
[  568.535444] alarmtimer alarmtimer: bus resume
[  568.535445] call alarmtimer+ returned 0 after 0 usecs
[  568.535448] calling  input0+ @ 2130, parent: PNP0C0E:00
[  568.535449] input input0: type resume
[  568.535450] call input0+ returned 0 after 0 usecs
[  568.535450] calling  input1+ @ 2130, parent: PNP0C0C:00
[  568.535450] input input1: type resume
[  568.535451] call input1+ returned 0 after 0 usecs
[  568.535451] calling  input2+ @ 2130, parent: LNXPWRBN:00
[  568.535452] input input2: type resume
[  568.535452] call input2+ returned 0 after 0 usecs
[  568.535455] calling  serial8250+ @ 2130, parent: platform
[  568.535456] serial8250 serial8250: bus resume
[  568.535457] call serial8250+ returned 0 after 1 usecs
[  568.535468] calling  Fixed MDIO bus.0+ @ 2130, parent: platform
[  568.535469] platform Fixed MDIO bus.0: bus resume
[  568.535469] call Fixed MDIO bus.0+ returned 0 after 0 usecs
[  568.535472] calling  rtc0+ @ 2130, parent: 00:05
[  568.535473] rtc rtc0: class resume
[  568.535473] call rtc0+ returned 0 after 1 usecs
[  568.535474] calling  microcode+ @ 2130, parent: platform
[  568.535475] platform microcode: bus resume
[  568.535475] call microcode+ returned 0 after 0 usecs
[  568.540297] device: 'mei::5565a099-7fe2-45c1-a22b-d7e9dfea9a2e:01': device_add
[  568.582669] call hdaudioC0D0+ returned 0 after 153132 usecs
[  568.586503] PM: Adding info for mei:mei::5565a099-7fe2-45c1-a22b-d7e9dfea9a2e:01
[  568.599122] call usb3+ returned 0 after 104790 usecs
[  568.603099] device: 'mei::dba4d603-d7ed-4931-8823-17ad585705d5:01': device_add
[  568.607061] call usb4+ returned 0 after 102347 usecs
[  568.849126] ata6: SATA link down (SStatus 4 SControl 300)
[  568.853010] PM: Adding info for mei:mei::dba4d603-d7ed-4931-8823-17ad585705d5:01
[  568.857716] ata4: SATA link down (SStatus 4 SControl 300)
[  568.861254] device: 'mei::f908627d-13bf-4a04-b91f-a64e9245323d:01': device_add
[  568.866067] ata2: SATA link down (SStatus 4 SControl 300)
[  568.871448] PM: Adding info for mei:mei::f908627d-13bf-4a04-b91f-a64e9245323d:01
[  568.875455] ata5: SATA link down (SStatus 4 SControl 300)
[  568.880675] device: 'mei::309dcde8-ccb1-4062-8f78-600115a34327:01': device_add
[  568.886220] ata3: SATA link down (SStatus 4 SControl 300)
[  568.887520] call 0000:00:1f.6+ returned 0 after 455185 usecs
[  568.889680] PM: Adding info for mei:mei::309dcde8-ccb1-4062-8f78-600115a34327:01
[  569.707565] device: 'mei::8c2f4425-77d6-4755-aca3-891fdbc66a58:01': device_add
[  569.707589] PM: Adding info for mei:mei::8c2f4425-77d6-4755-aca3-891fdbc66a58:01
[  569.707598] device: 'mei::8e6a6715-9abc-4043-88ef-9e39c6f63e0f:01': device_add
[  569.707617] PM: Adding info for mei:mei::8e6a6715-9abc-4043-88ef-9e39c6f63e0f:01
[  569.707626] device: 'mei::01e88543-8050-4380-9d6f-4f9cec704917:01': device_add
[  569.707649] PM: Adding info for mei:mei::01e88543-8050-4380-9d6f-4f9cec704917:01
[  569.707658] device: 'mei::42b3ce2f-bd9f-485a-96ae-26406230b1ff:01': device_add
[  569.707692] PM: Adding info for mei:mei::42b3ce2f-bd9f-485a-96ae-26406230b1ff:01
[  569.708061] device: 'mei::55213584-9a29-4916-badf-0fb7ed682aeb:01': device_add
[  569.708086] PM: Adding info for mei:mei::55213584-9a29-4916-badf-0fb7ed682aeb:01
[  570.343635] [drm] PCIE GART of 512M enabled (table at 0x000000F400000000).
[  570.343642] [drm] PSP is resuming...
[  570.343713] gmc_v9_0_process_interrupt: 12 callbacks suppressed
[  570.343715] amdgpu 0000:03:00.0: [mmhub] VMC page fault (src_id:0 ring:0 vmid:0 pasid:0)
[  570.343716] amdgpu 0000:03:00.0:   at page 0x000000f600700000 from 18
[  570.343716] amdgpu 0000:03:00.0: VM_L2_PROTECTION_FAULT_STATUS:0x00000010
[  570.525510] [drm:psp_resume [amdgpu]] *ERROR* PSP resume failed
[  570.525523] [drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *ERROR* resume of IP block <psp> failed -62
[  570.525536] [drm:amdgpu_device_resume [amdgpu]] *ERROR* amdgpu_device_ip_resume failed (-62).
[  570.536704] e1000e: enp0s31f6 NIC Link is Up 100 Mbps Full Duplex, Flow Control: Rx/Tx
[  570.540496] dpm_run_callback(): pci_pm_resume+0x0/0xa0 returns -62
[  570.547879] e1000e 0000:00:1f.6 enp0s31f6: 10/100 speed: disabling TSO
[  570.555434] call 0000:03:00.0+ returned -62 after 1973202 usecs
[  570.689812] PM: Device 0000:03:00.0 failed to resume async: error -62
[  570.689834] calling  0000:03:00.1+ @ 1810, parent: 0000:02:00.0
[  570.702422] snd_hda_intel 0000:03:00.1: bus resume
[  570.709958] call 0000:03:00.1+ returned 0 after 7358 usecs
[  570.715592] calling  hdaudioC1D0+ @ 1823, parent: 0000:03:00.1
[  570.715635] calling  input9+ @ 2130, parent: card0
[  570.721543] snd_hda_codec_hdmi hdaudioC1D0: driver resume
[  570.721559] call hdaudioC1D0+ returned 0 after 16 usecs
[  570.726447] input input9: type resume
[  570.741024] call input9+ returned 0 after 14235 usecs
[  570.746172] calling  input3+ @ 2130, parent: card1
[  570.751049] input input3: type resume
[  570.754784] call input3+ returned 0 after 3647 usecs
[  570.759838] calling  input10+ @ 2130, parent: card0
[  570.764813] input input10: type resume
[  570.768643] call input10+ returned 0 after 3740 usecs
[  570.773765] calling  input4+ @ 2130, parent: card1
[  570.778661] input input4: type resume
[  570.782405] call input4+ returned 0 after 3656 usecs
[  570.787475] calling  input5+ @ 2130, parent: card1
[  570.792382] input input5: type resume
[  570.796141] call input5+ returned 0 after 3671 usecs
[  570.801205] calling  input6+ @ 2130, parent: card1
[  570.806092] input input6: type resume
[  570.809846] call input6+ returned 0 after 3665 usecs
[  570.814889] calling  input7+ @ 2130, parent: card1
[  570.819801] input input7: type resume
[  570.823528] call input7+ returned 0 after 3640 usecs
[  570.828573] calling  input8+ @ 2130, parent: card1
[  570.833479] input input8: type resume
[  570.837239] call input8+ returned 0 after 3671 usecs
[  570.842294] calling  input11+ @ 2130, parent: card0
[  570.847311] input input11: type resume
[  570.851123] call input11+ returned 0 after 3723 usecs
[  570.856264] calling  input12+ @ 2130, parent: card0
[  570.861254] input input12: type resume
[  570.865077] call input12+ returned 0 after 3733 usecs
[  570.870200] calling  input13+ @ 2130, parent: card0
[  570.875172] input input13: type resume
[  570.878987] call input13+ returned 0 after 3725 usecs
[  570.884126] calling  input14+ @ 2130, parent: card0
[  570.889075] input input14: type resume
[  570.892887] call input14+ returned 0 after 3723 usecs
[  570.898062] calling  input15+ @ 2130, parent: card0
[  570.903055] input input15: type resume
[  570.906867] call input15+ returned 0 after 3722 usecs
[  570.912008] calling  input16+ @ 2130, parent: card0
[  570.916983] input input16: type resume
[  570.920803] call input16+ returned 0 after 3730 usecs
[  570.925935] calling  coretemp.0+ @ 2130, parent: platform
[  570.931439] coretemp coretemp.0: bus resume
[  570.935702] call coretemp.0+ returned 0 after 4162 usecs
[  570.941336] usb usb4: completing type resume
[  570.945707] usb usb3: completing type resume
[  570.950059] usb usb2: completing type resume
[  570.954475] usb usb1: completing type resume
[  570.958850] snd_hda_intel 0000:03:00.1: completing bus resume
[  570.964741] acpi-fan PNP0C0B:04: completing power domain resume
[  570.970786] acpi-fan PNP0C0B:03: completing power domain resume
[  570.976836] acpi-fan PNP0C0B:02: completing power domain resume
[  570.982865] acpi-fan PNP0C0B:01: completing power domain resume
[  570.988933] acpi-fan PNP0C0B:00: completing power domain resume
[  570.995014] acpi-wmi PNP0C14:01: completing power domain resume
[  571.001048] acpi-wmi PNP0C14:00: completing power domain resume
[  571.007075] xhci_hcd 0000:08:00.0: completing bus resume
[  571.012490] pci 0000:05:00.0: completing bus resume
[  571.017463] amdgpu 0000:03:00.0: completing bus resume
[  571.022690] pcieport 0000:02:00.0: completing bus resume
[  571.028132] pcieport 0000:01:00.0: completing bus resume
[  571.033531] e1000e 0000:00:1f.6: completing bus resume
[  571.038774] pci 0000:00:1f.4: completing bus resume
[  571.043740] snd_hda_intel 0000:00:1f.3: completing bus resume
[  571.049627] pci 0000:00:1f.2: completing bus resume
[  571.054593] pci 0000:00:1f.0: completing bus resume
[  571.059575] pcieport 0000:00:1d.0: completing bus resume
[  571.064975] pcieport 0000:00:1c.4: completing bus resume
[  571.070400] pcieport 0000:00:1c.0: completing bus resume
[  571.075826] pcieport 0000:00:1b.3: completing bus resume
[  571.081268] pcieport 0000:00:1b.2: completing bus resume
[  571.086693] pcieport 0000:00:1b.0: completing bus resume
[  571.092136] ahci 0000:00:17.0: completing bus resume
[  571.097206] mei_me 0000:00:16.0: completing power domain resume
[  571.103238] xhci_hcd 0000:00:14.0: completing bus resume
[  571.108638] pcieport 0000:00:01.0: completing bus resume
[  571.114080] skl_uncore 0000:00:00.0: completing bus resume
[  571.120155] acpi LNXPOWER:16: Turning OFF
[  571.124357] acpi LNXPOWER:15: Turning OFF
[  571.128552] acpi LNXPOWER:14: Turning OFF
[  571.132737] acpi LNXPOWER:13: Turning OFF
[  571.136887] acpi LNXPOWER:12: Turning OFF
[  571.141063] acpi LNXPOWER:11: Turning OFF
[  571.145234] acpi LNXPOWER:10: Turning OFF
[  571.149409] acpi LNXPOWER:0f: Turning OFF
[  571.153605] acpi LNXPOWER:0e: Turning OFF
[  571.157789] acpi LNXPOWER:0d: Turning OFF
[  571.161942] acpi LNXPOWER:0c: Turning OFF
[  571.166126] acpi LNXPOWER:0b: Turning OFF
[  571.170297] acpi LNXPOWER:0a: Turning OFF
[  571.174480] acpi LNXPOWER:09: Turning OFF
[  571.178636] acpi LNXPOWER:08: Turning OFF
[  571.182827] acpi LNXPOWER:07: Turning OFF
[  571.187021] acpi LNXPOWER:06: Turning OFF
[  571.191218] acpi LNXPOWER:05: Turning OFF
[  571.195414] acpi LNXPOWER:04: Turning OFF
[  571.199565] acpi LNXPOWER:03: Turning OFF
[  571.203728] OOM killer enabled.
[  571.204083] pci_bus 0000:06: Allocating resources
[  571.206941] Restarting tasks ... done.
[  571.211797] pci 0000:05:00.0: bridge window [io  0x1000-0x0fff] to [bus 06] add_size 1000
[  571.223983] pci 0000:05:00.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 06] add_size 200000 add_align 100000
[  571.235649] pci 0000:05:00.0: bridge window [mem 0x00100000-0x000fffff] to [bus 06] add_size 200000 add_align 100000
[  571.246409] pci 0000:05:00.0: BAR 14: no space for [mem size 0x00200000]
[  571.253276] pci 0000:05:00.0: BAR 14: failed to assign [mem size 0x00200000]
[  571.260480] pci 0000:05:00.0: BAR 15: no space for [mem size 0x00200000 64bit pref]
[  571.268294] pci 0000:05:00.0: BAR 15: failed to assign [mem size 0x00200000 64bit pref]
[  571.276443] pci 0000:05:00.0: BAR 13: no space for [io  size 0x1000]
[  571.276443] pci 0000:05:00.0: BAR 13: failed to assign [io  size 0x1000]
[  571.276446] pci 0000:05:00.0: BAR 14: no space for [mem size 0x00200000]
[  571.276446] pci 0000:05:00.0: BAR 14: failed to assign [mem size 0x00200000]
[  571.276447] pci 0000:05:00.0: BAR 15: no space for [mem size 0x00200000 64bit pref]
[  571.276447] pci 0000:05:00.0: BAR 15: failed to assign [mem size 0x00200000 64bit pref]
[  571.276448] pci 0000:05:00.0: BAR 13: no space for [io  size 0x1000]
[  571.276449] pci 0000:05:00.0: BAR 13: failed to assign [io  size 0x1000]
[  571.276450] pci 0000:05:00.0: PCI bridge to [bus 06]
[  571.335031] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[  571.338522] PM: suspend exit
[  571.351353] ata1.00: configured for UDMA/133
[  572.025554] device: 'vcs63': device_unregister
[  572.025620] PM: Removing info for No Bus:vcs63
[  572.025646] device: 'vcs63': device_create_release
[  572.025650] device: 'vcsa63': device_unregister
[  572.025701] PM: Removing info for No Bus:vcsa63
[  572.025711] device: 'vcsa63': device_create_release

--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--fdj2RfSjLxBAspz7--
