From: Tom St Denis <tstdenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: dmesg warning during init
Date: Mon, 16 Jul 2018 13:14:22 -0400
Message-ID: <fb9f4142-a44c-ff4b-c63f-9394a21e5775@amd.com>
References: <4202bddf-090d-dd45-6b0a-aeb3a2534f3c@amd.com>
 <2b60a98b-f4a5-9dab-24be-ead1da757dcd@daenzer.net>
 <aff64c92-6611-041f-319b-fd444f67a239@amd.com>
 <bc26fc6d-d0ce-8c17-7fbf-83ea3fc1abb3@daenzer.net>
 <64856fd3-f121-29d0-3386-3742fdddf8db@amd.com>
 <3e9472a6-c883-13fd-9007-c8ea0c9e245e@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------DA343ACE399DD6B3F778E680"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <3e9472a6-c883-13fd-9007-c8ea0c9e245e-otUistvHUpPR7s880joybQ@public.gmane.org>
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

--------------DA343ACE399DD6B3F778E680
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

With the tip of drm-next I get this KASAN immediately.

Tom

On 07/16/2018 12:40 PM, Michel Dänzer wrote:
> On 2018-07-16 06:36 PM, Tom St Denis wrote:
>> Will in a bit.  I'm tracking down a KASAN oops that the tip of drm-next
>> causes with unigine-heaven.
> 
> Is it different from the one I reported an hour ago?
> 
> https://lists.freedesktop.org/archives/amd-gfx/2018-July/024207.html
> 
> 

--------------DA343ACE399DD6B3F778E680
Content-Type: text/x-log;
 name="raven.dmesg.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="raven.dmesg.log"

[    0.000000] Linux version 4.18.0-rc1+ (root@raven) (gcc version 8.1.1 20180502 (Red Hat 8.1.1-1) (GCC)) #8 SMP Mon Jul 16 12:16:53 EDT 2018
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
[    0.000000] BRK [0x523a2000, 0x523a2fff] PGTABLE
[    0.000000] BRK [0x523a3000, 0x523a3fff] PGTABLE
[    0.000000] BRK [0x523a4000, 0x523a4fff] PGTABLE
[    0.000000] BRK [0x523a5000, 0x523a5fff] PGTABLE
[    0.000000] BRK [0x523a6000, 0x523a6fff] PGTABLE
[    0.000000] BRK [0x523a7000, 0x523a7fff] PGTABLE
[    0.000000] BRK [0x523a8000, 0x523a8fff] PGTABLE
[    0.000000] BRK [0x523a9000, 0x523a9fff] PGTABLE
[    0.000000] BRK [0x523aa000, 0x523aafff] PGTABLE
[    0.000000] RAMDISK: [mem 0x34c87000-0x3663bfff]
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
[    0.000000] Memory: 6094576K/7270496K available (22540K kernel code, 4878K rwdata, 6268K rodata, 1592K init, 9056K bss, 1175920K reserved, 0K cma-reserved)
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
[    0.007000] tsc: Detected 3593.858 MHz processor
[    0.007000] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x33cda95b3b0, max_idle_ns: 440795244181 ns
[    0.007000] Calibrating delay loop (skipped), value calculated using timer frequency.. 7187.71 BogoMIPS (lpj=3593858)
[    0.008002] pid_max: default: 32768 minimum: 301
[    0.008039] Security Framework initialized
[    0.008041] SELinux:  Initializing.
[    0.008069] SELinux:  Starting in permissive mode
[    0.009448] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.010190] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.010229] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.010258] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.010547] CPU: Physical Processor ID: 0
[    0.010548] CPU: Processor Core ID: 0
[    0.010655] mce: CPU supports 23 MCE banks
[    0.010675] LVT offset 1 assigned for vector 0xf9
[    0.010724] LVT offset 2 assigned for vector 0xf4
[    0.010734] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 512
[    0.010735] Last level dTLB entries: 4KB 1536, 2MB 1536, 4MB 768, 1GB 0
[    0.010738] Spectre V2 : Mitigation: Full AMD retpoline
[    0.010739] Spectre V2 : Spectre v2 mitigation: Enabling Indirect Branch Prediction Barrier
[    0.010741] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
[    0.021694] Freeing SMP alternatives memory: 36K
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
[    0.024482] MCE: In-kernel MCE decoding enabled.
[    0.024918] smp: Bringing up secondary CPUs ...
[    0.025168] x86: Booting SMP configuration:
[    0.025170] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7
[    0.036004] smp: Brought up 1 node, 8 CPUs
[    0.036005] smpboot: Max logical packages: 2
[    0.036007] smpboot: Total of 8 processors activated (57501.72 BogoMIPS)
[    0.038004] devtmpfs: initialized
[    0.040085] PM: Registering ACPI NVS region [mem 0x04000000-0x04009fff] (40960 bytes)
[    0.040089] PM: Registering ACPI NVS region [mem 0x9a7e5000-0x9ab9cfff] (3899392 bytes)
[    0.040459] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.040499] futex hash table entries: 4096 (order: 6, 262144 bytes)
[    0.040585] kworker/u32:0 (52) used greatest stack depth: 23576 bytes left
[    0.041343] RTC time: 17:10:41, date: 07/16/18
[    0.043201] NET: Registered protocol family 16
[    0.043422] audit: initializing netlink subsys (disabled)
[    0.043434] audit: type=2000 audit(1531761041.043:1): state=initialized audit_enabled=0 res=1
[    0.044092] kworker/u32:0 (58) used greatest stack depth: 22856 bytes left
[    0.044076] kworker/u32:0 (60) used greatest stack depth: 22416 bytes left
[    0.044128] kworker/u32:0 (56) used greatest stack depth: 22088 bytes left
[    0.044130] cpuidle: using governor menu
[    0.044136] ACPI: bus type PCI registered
[    0.044228] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.044232] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
[    0.044245] PCI: Using configuration type 1 for base access
[    0.045201] mtrr: your CPUs had inconsistent variable MTRR settings
[    0.045202] mtrr: probably your BIOS does not setup all CPUs.
[    0.045203] mtrr: corrected configuration.
[    0.046181] kworker/u32:2 (147) used greatest stack depth: 18664 bytes left
[    0.051081] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.051126] ACPI: Added _OSI(Module Device)
[    0.051126] ACPI: Added _OSI(Processor Device)
[    0.051126] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.051126] ACPI: Added _OSI(Processor Aggregator Device)
[    0.051126] ACPI: Added _OSI(Linux-Dell-Video)
[    0.074561] 
               3ACPI BIOS Error (bug): Failure creating [\_SB.SMIC], AE_ALREADY_EXISTS (20180531/dswload2-316)
[    0.074571] ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20180531/psobject-221)
[    0.074777] ACPI Error: Ignore error and continue table load (20180531/psobject-604)
[    0.074959] 
               3ACPI BIOS Error (bug): Failure creating [\_SB.SMIB], AE_ALREADY_EXISTS (20180531/dsfield-594)
[    0.075663] ACPI: 8 ACPI AML tables successfully acquired and loaded
[    0.079709] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.088415] ACPI: Interpreter enabled
[    0.088449] ACPI: (supports S0 S3 S4 S5)
[    0.088452] ACPI: Using IOAPIC for interrupt routing
[    0.089070] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.089660] ACPI: Enabled 3 GPEs in block 00 to 1F
[    0.096331] ACPI: Power Resource [P0ST] (on)
[    0.096406] ACPI: Power Resource [P3ST] (on)
[    0.109399] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.109407] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.109807] acpi PNP0A08:00: _OSC: platform does not support [PME LTR]
[    0.110194] acpi PNP0A08:00: _OSC: OS now controls [AER PCIeCapability]
[    0.110211] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000 [bus 00-3f] only partially covers this bridge
[    0.110666] PCI host bridge to bus 0000:00
[    0.110670] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    0.110672] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    0.110675] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
[    0.110677] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.110679] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.110682] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff window]
[    0.110685] pci_bus 0000:00: root bus resource [mem 0xe0000000-0xfec2ffff window]
[    0.110688] pci_bus 0000:00: root bus resource [mem 0xfee00000-0xffffffff window]
[    0.110691] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.110703] pci 0000:00:00.0: [1022:15d0] type 00 class 0x060000
[    0.110912] pci 0000:00:00.2: [1022:15d1] type 00 class 0x080600
[    0.111152] pci 0000:00:01.0: [1022:1452] type 00 class 0x060000
[    0.111344] pci 0000:00:01.2: [1022:15d3] type 01 class 0x060400
[    0.111457] pci 0000:00:01.2: PME# supported from D0 D3hot D3cold
[    0.111648] pci 0000:00:08.0: [1022:1452] type 00 class 0x060000
[    0.111834] pci 0000:00:08.1: [1022:15db] type 01 class 0x060400
[    0.111889] pci 0000:00:08.1: enabling Extended Tags
[    0.111949] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
[    0.112127] pci 0000:00:08.2: [1022:15dc] type 01 class 0x060400
[    0.112182] pci 0000:00:08.2: enabling Extended Tags
[    0.112239] pci 0000:00:08.2: PME# supported from D0 D3hot D3cold
[    0.112426] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500
[    0.112712] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100
[    0.113004] pci 0000:00:18.0: [1022:15e8] type 00 class 0x060000
[    0.113123] pci 0000:00:18.1: [1022:15e9] type 00 class 0x060000
[    0.113238] pci 0000:00:18.2: [1022:15ea] type 00 class 0x060000
[    0.113350] pci 0000:00:18.3: [1022:15eb] type 00 class 0x060000
[    0.113464] pci 0000:00:18.4: [1022:15ec] type 00 class 0x060000
[    0.113580] pci 0000:00:18.5: [1022:15ed] type 00 class 0x060000
[    0.113696] pci 0000:00:18.6: [1022:15ee] type 00 class 0x060000
[    0.113810] pci 0000:00:18.7: [1022:15ef] type 00 class 0x060000
[    0.114020] pci 0000:01:00.0: [1022:43bb] type 00 class 0x0c0330
[    0.114053] pci 0000:01:00.0: reg 0x10: [mem 0xfe8a0000-0xfe8a7fff 64bit]
[    0.114168] pci 0000:01:00.0: PME# supported from D3hot D3cold
[    0.114296] pci 0000:01:00.1: [1022:43b7] type 00 class 0x010601
[    0.114363] pci 0000:01:00.1: reg 0x24: [mem 0xfe880000-0xfe89ffff]
[    0.114374] pci 0000:01:00.1: reg 0x30: [mem 0xfe800000-0xfe87ffff pref]
[    0.114435] pci 0000:01:00.1: PME# supported from D3hot D3cold
[    0.114548] pci 0000:01:00.2: [1022:43b2] type 01 class 0x060400
[    0.114658] pci 0000:01:00.2: PME# supported from D3hot D3cold
[    0.114836] pci 0000:00:01.2: PCI bridge to [bus 01-05]
[    0.114844] pci 0000:00:01.2:   bridge window [io  0xf000-0xffff]
[    0.114849] pci 0000:00:01.2:   bridge window [mem 0xfe700000-0xfe8fffff]
[    0.114927] pci 0000:02:00.0: [1022:43b4] type 01 class 0x060400
[    0.115061] pci 0000:02:00.0: PME# supported from D3hot D3cold
[    0.115206] pci 0000:02:01.0: [1022:43b4] type 01 class 0x060400
[    0.115334] pci 0000:02:01.0: PME# supported from D3hot D3cold
[    0.115476] pci 0000:02:04.0: [1022:43b4] type 01 class 0x060400
[    0.115604] pci 0000:02:04.0: PME# supported from D3hot D3cold
[    0.115768] pci 0000:01:00.2: PCI bridge to [bus 02-05]
[    0.115775] pci 0000:01:00.2:   bridge window [io  0xf000-0xffff]
[    0.115780] pci 0000:01:00.2:   bridge window [mem 0xfe700000-0xfe7fffff]
[    0.115868] pci 0000:03:00.0: [10ec:8168] type 00 class 0x020000
[    0.115919] pci 0000:03:00.0: reg 0x10: [io  0xf000-0xf0ff]
[    0.115963] pci 0000:03:00.0: reg 0x18: [mem 0xfe704000-0xfe704fff 64bit]
[    0.115990] pci 0000:03:00.0: reg 0x20: [mem 0xfe700000-0xfe703fff 64bit]
[    0.116156] pci 0000:03:00.0: supports D1 D2
[    0.116158] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.116377] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.116385] pci 0000:02:00.0:   bridge window [io  0xf000-0xffff]
[    0.116389] pci 0000:02:00.0:   bridge window [mem 0xfe700000-0xfe7fffff]
[    0.116454] pci 0000:02:01.0: PCI bridge to [bus 04]
[    0.116524] pci 0000:02:04.0: PCI bridge to [bus 05]
[    0.116646] pci 0000:06:00.0: [1002:15dd] type 00 class 0x030000
[    0.116695] pci 0000:06:00.0: reg 0x10: [mem 0xe0000000-0xefffffff 64bit pref]
[    0.116714] pci 0000:06:00.0: reg 0x18: [mem 0xf0000000-0xf01fffff 64bit pref]
[    0.116728] pci 0000:06:00.0: reg 0x20: [io  0xe000-0xe0ff]
[    0.116741] pci 0000:06:00.0: reg 0x24: [mem 0xfe600000-0xfe67ffff]
[    0.116762] pci 0000:06:00.0: enabling Extended Tags
[    0.116874] pci 0000:06:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.117036] pci 0000:06:00.1: [1002:15de] type 00 class 0x040300
[    0.117069] pci 0000:06:00.1: reg 0x10: [mem 0xfe688000-0xfe68bfff]
[    0.117143] pci 0000:06:00.1: enabling Extended Tags
[    0.117217] pci 0000:06:00.1: PME# supported from D1 D2 D3hot D3cold
[    0.117347] pci 0000:06:00.2: [1022:15df] type 00 class 0x108000
[    0.117401] pci 0000:06:00.2: reg 0x18: [mem 0xfe500000-0xfe5fffff]
[    0.117435] pci 0000:06:00.2: reg 0x24: [mem 0xfe68c000-0xfe68dfff]
[    0.117456] pci 0000:06:00.2: enabling Extended Tags
[    0.117667] pci 0000:06:00.3: [1022:15e0] type 00 class 0x0c0330
[    0.117706] pci 0000:06:00.3: reg 0x10: [mem 0xfe400000-0xfe4fffff 64bit]
[    0.117769] pci 0000:06:00.3: enabling Extended Tags
[    0.117850] pci 0000:06:00.3: PME# supported from D0 D3hot D3cold
[    0.117991] pci 0000:06:00.4: [1022:15e1] type 00 class 0x0c0330
[    0.118033] pci 0000:06:00.4: reg 0x10: [mem 0xfe300000-0xfe3fffff 64bit]
[    0.118096] pci 0000:06:00.4: enabling Extended Tags
[    0.118180] pci 0000:06:00.4: PME# supported from D0 D3hot D3cold
[    0.118322] pci 0000:06:00.6: [1022:15e3] type 00 class 0x040300
[    0.118354] pci 0000:06:00.6: reg 0x10: [mem 0xfe680000-0xfe687fff]
[    0.118427] pci 0000:06:00.6: enabling Extended Tags
[    0.118501] pci 0000:06:00.6: PME# supported from D0 D3hot D3cold
[    0.118700] pci 0000:00:08.1: PCI bridge to [bus 06]
[    0.118707] pci 0000:00:08.1:   bridge window [io  0xe000-0xefff]
[    0.118711] pci 0000:00:08.1:   bridge window [mem 0xfe300000-0xfe6fffff]
[    0.118718] pci 0000:00:08.1:   bridge window [mem 0xe0000000-0xf01fffff 64bit pref]
[    0.118801] pci 0000:07:00.0: [1022:7901] type 00 class 0x010601
[    0.118888] pci 0000:07:00.0: reg 0x24: [mem 0xfe900000-0xfe9007ff]
[    0.118909] pci 0000:07:00.0: enabling Extended Tags
[    0.118993] pci 0000:07:00.0: PME# supported from D3hot D3cold
[    0.119166] pci 0000:00:08.2: PCI bridge to [bus 07]
[    0.119176] pci 0000:00:08.2:   bridge window [mem 0xfe900000-0xfe9fffff]
[    0.120190] ACPI: PCI Interrupt Link [LNKA] (IRQs 4 5 7 10 11 14 15) *0
[    0.120315] ACPI: PCI Interrupt Link [LNKB] (IRQs 4 5 7 10 11 14 15) *0
[    0.120430] ACPI: PCI Interrupt Link [LNKC] (IRQs 4 5 7 10 11 14 15) *0
[    0.120565] ACPI: PCI Interrupt Link [LNKD] (IRQs 4 5 7 10 11 14 15) *0
[    0.120693] ACPI: PCI Interrupt Link [LNKE] (IRQs 4 5 7 10 11 14 15) *0
[    0.120801] ACPI: PCI Interrupt Link [LNKF] (IRQs 4 5 7 10 11 14 15) *0
[    0.120905] ACPI: PCI Interrupt Link [LNKG] (IRQs 4 5 7 10 11 14 15) *0
[    0.121019] ACPI: PCI Interrupt Link [LNKH] (IRQs 4 5 7 10 11 14 15) *0
[    0.122162] pci 0000:06:00.0: vgaarb: setting as boot VGA device
[    0.122162] pci 0000:06:00.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.122162] pci 0000:06:00.0: vgaarb: bridge control possible
[    0.122162] vgaarb: loaded
[    0.122230] SCSI subsystem initialized
[    0.122273] libata version 3.00 loaded.
[    0.122273] ACPI: bus type USB registered
[    0.122273] usbcore: registered new interface driver usbfs
[    0.122273] usbcore: registered new interface driver hub
[    0.122273] usbcore: registered new device driver usb
[    0.122285] pps_core: LinuxPPS API ver. 1 registered
[    0.122287] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
[    0.122294] PTP clock support registered
[    0.122350] EDAC MC: Ver: 3.0.0
[    0.123066] Advanced Linux Sound Architecture Driver Initialized.
[    0.123093] PCI: Using ACPI for IRQ routing
[    0.125755] PCI: pci_cache_line_size set to 64 bytes
[    0.125853] e820: reserve RAM buffer [mem 0x0009d400-0x0009ffff]
[    0.125855] e820: reserve RAM buffer [mem 0x09c00000-0x0bffffff]
[    0.125856] e820: reserve RAM buffer [mem 0x0b000000-0x0bffffff]
[    0.125858] e820: reserve RAM buffer [mem 0x96464000-0x97ffffff]
[    0.125860] e820: reserve RAM buffer [mem 0x9a5be000-0x9bffffff]
[    0.125862] e820: reserve RAM buffer [mem 0x9a7e5000-0x9bffffff]
[    0.125864] e820: reserve RAM buffer [mem 0x9e000000-0x9fffffff]
[    0.125866] e820: reserve RAM buffer [mem 0x21f340000-0x21fffffff]
[    0.126081] NetLabel: Initializing
[    0.126083] NetLabel:  domain hash size = 128
[    0.126083] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.126113] NetLabel:  unlabeled traffic allowed by default
[    0.126143] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.126146] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.129083] clocksource: Switched to clocksource tsc-early
[    0.150837] VFS: Disk quotas dquot_6.6.0
[    0.150862] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.150970] pnp: PnP ACPI init
[    0.151185] system 00:00: [mem 0xf8000000-0xfbffffff] has been reserved
[    0.151199] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.151338] system 00:01: [mem 0xfeb80000-0xfebfffff] has been reserved
[    0.151347] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.151586] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.151894] system 00:03: [io  0x0300-0x030f] has been reserved
[    0.151897] system 00:03: [io  0x0230-0x023f] has been reserved
[    0.151900] system 00:03: [io  0x0290-0x029f] has been reserved
[    0.151908] system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.152456] pnp 00:04: [dma 0 disabled]
[    0.152536] pnp 00:04: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.152972] system 00:05: [io  0x04d0-0x04d1] has been reserved
[    0.152975] system 00:05: [io  0x040b] has been reserved
[    0.152978] system 00:05: [io  0x04d6] has been reserved
[    0.152980] system 00:05: [io  0x0c00-0x0c01] has been reserved
[    0.152983] system 00:05: [io  0x0c14] has been reserved
[    0.152986] system 00:05: [io  0x0c50-0x0c51] has been reserved
[    0.152988] system 00:05: [io  0x0c52] has been reserved
[    0.152991] system 00:05: [io  0x0c6c] has been reserved
[    0.152993] system 00:05: [io  0x0c6f] has been reserved
[    0.152996] system 00:05: [io  0x0cd0-0x0cd1] has been reserved
[    0.152999] system 00:05: [io  0x0cd2-0x0cd3] has been reserved
[    0.153001] system 00:05: [io  0x0cd4-0x0cd5] has been reserved
[    0.153004] system 00:05: [io  0x0cd6-0x0cd7] has been reserved
[    0.153007] system 00:05: [io  0x0cd8-0x0cdf] has been reserved
[    0.153009] system 00:05: [io  0x0800-0x089f] has been reserved
[    0.153012] system 00:05: [io  0x0b00-0x0b0f] has been reserved
[    0.153015] system 00:05: [io  0x0b20-0x0b3f] has been reserved
[    0.153017] system 00:05: [io  0x0900-0x090f] has been reserved
[    0.153020] system 00:05: [io  0x0910-0x091f] has been reserved
[    0.153024] system 00:05: [mem 0xfec00000-0xfec00fff] could not be reserved
[    0.153027] system 00:05: [mem 0xfec01000-0xfec01fff] could not be reserved
[    0.153030] system 00:05: [mem 0xfedc0000-0xfedc0fff] has been reserved
[    0.153033] system 00:05: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.153036] system 00:05: [mem 0xfed80000-0xfed8ffff] could not be reserved
[    0.153039] system 00:05: [mem 0xfec10000-0xfec10fff] has been reserved
[    0.153042] system 00:05: [mem 0xff000000-0xffffffff] has been reserved
[    0.153051] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.154009] pnp: PnP ACPI: found 6 devices
[    0.161928] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.162003] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.162008] pci 0000:02:00.0:   bridge window [io  0xf000-0xffff]
[    0.162014] pci 0000:02:00.0:   bridge window [mem 0xfe700000-0xfe7fffff]
[    0.162024] pci 0000:02:01.0: PCI bridge to [bus 04]
[    0.162038] pci 0000:02:04.0: PCI bridge to [bus 05]
[    0.162051] pci 0000:01:00.2: PCI bridge to [bus 02-05]
[    0.162055] pci 0000:01:00.2:   bridge window [io  0xf000-0xffff]
[    0.162060] pci 0000:01:00.2:   bridge window [mem 0xfe700000-0xfe7fffff]
[    0.162069] pci 0000:00:01.2: PCI bridge to [bus 01-05]
[    0.162072] pci 0000:00:01.2:   bridge window [io  0xf000-0xffff]
[    0.162078] pci 0000:00:01.2:   bridge window [mem 0xfe700000-0xfe8fffff]
[    0.162092] pci 0000:00:08.1: PCI bridge to [bus 06]
[    0.162095] pci 0000:00:08.1:   bridge window [io  0xe000-0xefff]
[    0.162101] pci 0000:00:08.1:   bridge window [mem 0xfe300000-0xfe6fffff]
[    0.162106] pci 0000:00:08.1:   bridge window [mem 0xe0000000-0xf01fffff 64bit pref]
[    0.162113] pci 0000:00:08.2: PCI bridge to [bus 07]
[    0.162118] pci 0000:00:08.2:   bridge window [mem 0xfe900000-0xfe9fffff]
[    0.162130] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    0.162132] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
[    0.162134] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
[    0.162136] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    0.162138] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff window]
[    0.162140] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff window]
[    0.162142] pci_bus 0000:00: resource 10 [mem 0xe0000000-0xfec2ffff window]
[    0.162144] pci_bus 0000:00: resource 11 [mem 0xfee00000-0xffffffff window]
[    0.162146] pci_bus 0000:01: resource 0 [io  0xf000-0xffff]
[    0.162148] pci_bus 0000:01: resource 1 [mem 0xfe700000-0xfe8fffff]
[    0.162150] pci_bus 0000:02: resource 0 [io  0xf000-0xffff]
[    0.162152] pci_bus 0000:02: resource 1 [mem 0xfe700000-0xfe7fffff]
[    0.162154] pci_bus 0000:03: resource 0 [io  0xf000-0xffff]
[    0.162156] pci_bus 0000:03: resource 1 [mem 0xfe700000-0xfe7fffff]
[    0.162158] pci_bus 0000:06: resource 0 [io  0xe000-0xefff]
[    0.162160] pci_bus 0000:06: resource 1 [mem 0xfe300000-0xfe6fffff]
[    0.162162] pci_bus 0000:06: resource 2 [mem 0xe0000000-0xf01fffff 64bit pref]
[    0.162164] pci_bus 0000:07: resource 1 [mem 0xfe900000-0xfe9fffff]
[    0.162319] NET: Registered protocol family 2
[    0.162580] tcp_listen_portaddr_hash hash table entries: 4096 (order: 4, 65536 bytes)
[    0.162659] TCP established hash table entries: 65536 (order: 7, 524288 bytes)
[    0.162999] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.163266] TCP: Hash tables configured (established 65536 bind 65536)
[    0.163347] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[    0.163408] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[    0.163564] NET: Registered protocol family 1
[    0.163810] RPC: Registered named UNIX socket transport module.
[    0.163811] RPC: Registered udp transport module.
[    0.163812] RPC: Registered tcp transport module.
[    0.163813] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.164296] pci 0000:06:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.164307] pci 0000:06:00.1: Linked as a consumer to 0000:06:00.0
[    0.164782] PCI: CLS 64 bytes, default 64
[    0.164855] Unpacking initramfs...
[    0.839528] Freeing initrd memory: 26324K
[    1.160595] AMD-Vi: IOMMU performance counters supported
[    1.160730] pci 0000:00:00.2: can't derive routing for PCI INT A
[    1.160733] pci 0000:00:00.2: PCI INT A: not connected
[    1.161151] iommu: Adding device 0000:00:01.0 to group 0
[    1.161360] iommu: Adding device 0000:00:01.2 to group 1
[    1.161551] iommu: Adding device 0000:00:08.0 to group 2
[    1.161743] iommu: Adding device 0000:00:08.1 to group 3
[    1.161790] iommu: Adding device 0000:00:08.2 to group 2
[    1.161990] iommu: Adding device 0000:00:14.0 to group 4
[    1.162044] iommu: Adding device 0000:00:14.3 to group 4
[    1.162249] iommu: Adding device 0000:00:18.0 to group 5
[    1.162279] iommu: Adding device 0000:00:18.1 to group 5
[    1.162310] iommu: Adding device 0000:00:18.2 to group 5
[    1.162342] iommu: Adding device 0000:00:18.3 to group 5
[    1.162372] iommu: Adding device 0000:00:18.4 to group 5
[    1.162402] iommu: Adding device 0000:00:18.5 to group 5
[    1.162432] iommu: Adding device 0000:00:18.6 to group 5
[    1.162462] iommu: Adding device 0000:00:18.7 to group 5
[    1.162691] iommu: Adding device 0000:01:00.0 to group 6
[    1.162739] iommu: Adding device 0000:01:00.1 to group 6
[    1.162787] iommu: Adding device 0000:01:00.2 to group 6
[    1.162815] iommu: Adding device 0000:02:00.0 to group 6
[    1.162846] iommu: Adding device 0000:02:01.0 to group 6
[    1.162875] iommu: Adding device 0000:02:04.0 to group 6
[    1.162920] iommu: Adding device 0000:03:00.0 to group 6
[    1.163190] iommu: Adding device 0000:06:00.0 to group 7
[    1.163289] iommu: Using direct mapping for device 0000:06:00.0
[    1.163507] iommu: Adding device 0000:06:00.1 to group 8
[    1.163560] iommu: Adding device 0000:06:00.2 to group 8
[    1.163613] iommu: Adding device 0000:06:00.3 to group 8
[    1.163667] iommu: Adding device 0000:06:00.4 to group 8
[    1.163722] iommu: Adding device 0000:06:00.6 to group 8
[    1.163750] iommu: Adding device 0000:07:00.0 to group 2
[    1.164085] AMD-Vi: Found IOMMU at 0000:00:00.2 cap 0x40
[    1.164086] AMD-Vi: Extended features (0x4f77ef22294ada):
[    1.164087]  PPR NX GT IA GA PC GA_vAPIC
[    1.164379] AMD-Vi: Lazy IO/TLB flushing enabled
[    1.168895] amd_uncore: AMD NB counters detected
[    1.168904] amd_uncore: AMD LLC counters detected
[    1.169328] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 counters/bank).
[    1.171391] Scanning for low memory corruption every 60 seconds
[    1.173376] Initialise system trusted keyrings
[    1.173567] workingset: timestamp_bits=56 max_order=21 bucket_order=0
[    1.181785] NFS: Registering the id_resolver key type
[    1.181808] Key type id_resolver registered
[    1.181809] Key type id_legacy registered
[    1.182064] SELinux:  Registering netfilter hooks
[    1.184233] Key type asymmetric registered
[    1.184235] Asymmetric key parser 'x509' registered
[    1.184308] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
[    1.184310] io scheduler noop registered
[    1.184312] io scheduler deadline registered
[    1.184391] io scheduler cfq registered (default)
[    1.184392] io scheduler mq-deadline registered
[    1.184393] io scheduler kyber registered
[    1.186011] pcieport 0000:00:01.2: AER enabled with IRQ 26
[    1.186249] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    1.186264] ACPI: Power Button [PWRB]
[    1.186340] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    1.186368] ACPI: Power Button [PWRF]
[    1.186527] Monitor-Mwait will be used to enter C-1 state
[    1.188256] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.209225] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    1.210061] Non-volatile memory driver v1.3
[    1.210119] Linux agpgart interface v0.103
[    1.215900] loop: module loaded
[    1.216158] ahci 0000:01:00.1: version 3.0
[    1.216345] ahci 0000:01:00.1: SSS flag set, parallel bus scan disabled
[    1.216403] ahci 0000:01:00.1: AHCI 0001.0301 32 slots 8 ports 6 Gbps 0x33 impl SATA mode
[    1.216407] ahci 0000:01:00.1: flags: 64bit ncq sntf stag pm led clo only pmp pio slum part sxs deso sadm sds apst 
[    1.217729] scsi host0: ahci
[    1.217968] scsi host1: ahci
[    1.218152] scsi host2: ahci
[    1.218331] scsi host3: ahci
[    1.218530] scsi host4: ahci
[    1.218748] scsi host5: ahci
[    1.218962] scsi host6: ahci
[    1.219246] scsi host7: ahci
[    1.219348] ata1: SATA max UDMA/133 abar m131072@0xfe880000 port 0xfe880100 irq 34
[    1.219352] ata2: SATA max UDMA/133 abar m131072@0xfe880000 port 0xfe880180 irq 34
[    1.219354] ata3: DUMMY
[    1.219355] ata4: DUMMY
[    1.219358] ata5: SATA max UDMA/133 abar m131072@0xfe880000 port 0xfe880300 irq 34
[    1.219362] ata6: SATA max UDMA/133 abar m131072@0xfe880000 port 0xfe880380 irq 34
[    1.219363] ata7: DUMMY
[    1.219364] ata8: DUMMY
[    1.219740] ahci 0000:07:00.0: AHCI 0001.0301 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
[    1.219746] ahci 0000:07:00.0: flags: 64bit ncq sntf ilck pm led clo only pmp fbs pio slum part 
[    1.220136] scsi host8: ahci
[    1.220244] ata9: SATA max UDMA/133 abar m2048@0xfe900000 port 0xfe900100 irq 36
[    1.220536] e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2-NAPI
[    1.220538] e100: Copyright(c) 1999-2006 Intel Corporation
[    1.220577] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
[    1.220579] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    1.220614] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    1.220615] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    1.220658] sky2: driver version 1.30
[    1.220779] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[    1.225298] r8169 0000:03:00.0 eth0: RTL8168h/8111h, b0:6e:bf:2f:47:8d, XID 54100800, IRQ 37
[    1.225301] r8169 0000:03:00.0 eth0: jumbo features [frames: 9200 bytes, tx checksumming: ko]
[    1.225533] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.225534] ehci-pci: EHCI PCI platform driver
[    1.225559] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.225565] ohci-pci: OHCI PCI platform driver
[    1.225590] uhci_hcd: USB Universal Host Controller Interface driver
[    1.225786] xhci_hcd 0000:01:00.0: xHCI Host Controller
[    1.225862] xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 1
[    1.281248] xhci_hcd 0000:01:00.0: hcc params 0x0200ef81 hci version 0x110 quirks 0x0000000048000410
[    1.281591] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.18
[    1.281593] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.281595] usb usb1: Product: xHCI Host Controller
[    1.281597] usb usb1: Manufacturer: Linux 4.18.0-rc1+ xhci-hcd
[    1.281598] usb usb1: SerialNumber: 0000:01:00.0
[    1.281802] hub 1-0:1.0: USB hub found
[    1.281826] hub 1-0:1.0: 10 ports detected
[    1.293856] xhci_hcd 0000:01:00.0: xHCI Host Controller
[    1.293938] xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 2
[    1.293943] xhci_hcd 0000:01:00.0: Host supports USB 3.10 Enhanced SuperSpeed
[    1.293987] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[    1.294045] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 4.18
[    1.294047] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.294049] usb usb2: Product: xHCI Host Controller
[    1.294051] usb usb2: Manufacturer: Linux 4.18.0-rc1+ xhci-hcd
[    1.294052] usb usb2: SerialNumber: 0000:01:00.0
[    1.294229] hub 2-0:1.0: USB hub found
[    1.294245] hub 2-0:1.0: 4 ports detected
[    1.299126] xhci_hcd 0000:06:00.3: xHCI Host Controller
[    1.299202] xhci_hcd 0000:06:00.3: new USB bus registered, assigned bus number 3
[    1.299415] xhci_hcd 0000:06:00.3: hcc params 0x0270ffe5 hci version 0x110 quirks 0x0000000040000410
[    1.299954] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.18
[    1.299956] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.299957] usb usb3: Product: xHCI Host Controller
[    1.299959] usb usb3: Manufacturer: Linux 4.18.0-rc1+ xhci-hcd
[    1.299961] usb usb3: SerialNumber: 0000:06:00.3
[    1.300137] hub 3-0:1.0: USB hub found
[    1.300154] hub 3-0:1.0: 4 ports detected
[    1.300693] xhci_hcd 0000:06:00.3: xHCI Host Controller
[    1.300748] xhci_hcd 0000:06:00.3: new USB bus registered, assigned bus number 4
[    1.300752] xhci_hcd 0000:06:00.3: Host supports USB 3.10 Enhanced SuperSpeed
[    1.300798] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
[    1.300837] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 4.18
[    1.300839] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.300840] usb usb4: Product: xHCI Host Controller
[    1.300842] usb usb4: Manufacturer: Linux 4.18.0-rc1+ xhci-hcd
[    1.300843] usb usb4: SerialNumber: 0000:06:00.3
[    1.301017] hub 4-0:1.0: USB hub found
[    1.301033] hub 4-0:1.0: 4 ports detected
[    1.301671] xhci_hcd 0000:06:00.4: xHCI Host Controller
[    1.301732] xhci_hcd 0000:06:00.4: new USB bus registered, assigned bus number 5
[    1.301909] xhci_hcd 0000:06:00.4: hcc params 0x0260ffe5 hci version 0x110 quirks 0x0000000040000410
[    1.302386] usb usb5: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.18
[    1.302388] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.302389] usb usb5: Product: xHCI Host Controller
[    1.302391] usb usb5: Manufacturer: Linux 4.18.0-rc1+ xhci-hcd
[    1.302392] usb usb5: SerialNumber: 0000:06:00.4
[    1.302553] hub 5-0:1.0: USB hub found
[    1.302565] hub 5-0:1.0: 1 port detected
[    1.302725] xhci_hcd 0000:06:00.4: xHCI Host Controller
[    1.302780] xhci_hcd 0000:06:00.4: new USB bus registered, assigned bus number 6
[    1.302785] xhci_hcd 0000:06:00.4: Host supports USB 3.10 Enhanced SuperSpeed
[    1.302828] usb usb6: We don't know the algorithms for LPM for this host, disabling LPM.
[    1.302869] usb usb6: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 4.18
[    1.302871] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.302872] usb usb6: Product: xHCI Host Controller
[    1.302874] usb usb6: Manufacturer: Linux 4.18.0-rc1+ xhci-hcd
[    1.302875] usb usb6: SerialNumber: 0000:06:00.4
[    1.303042] hub 6-0:1.0: USB hub found
[    1.303058] hub 6-0:1.0: 1 port detected
[    1.303237] usbcore: registered new interface driver usblp
[    1.303283] usbcore: registered new interface driver usb-storage
[    1.303321] i8042: PNP: No PS/2 controller found.
[    1.303603] rtc_cmos 00:02: RTC can wake from S4
[    1.303868] rtc_cmos 00:02: registered as rtc0
[    1.303895] rtc_cmos 00:02: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    1.304215] device-mapper: ioctl: 4.39.0-ioctl (2018-04-03) initialised: dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
[    1.304265] hidraw: raw HID events driver (C) Jiri Kosina
[    1.304817] usbcore: registered new interface driver usbhid
[    1.304818] usbhid: USB HID core driver
[    1.306540] Initializing XFRM netlink socket
[    1.306942] NET: Registered protocol family 10
[    1.307675] Segment Routing with IPv6
[    1.307904] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    1.308159] NET: Registered protocol family 17
[    1.308199] Key type dns_resolver registered
[    1.309995] microcode: CPU0: patch_level=0x0810100b
[    1.310016] microcode: CPU1: patch_level=0x0810100b
[    1.310029] microcode: CPU2: patch_level=0x0810100b
[    1.310037] microcode: CPU3: patch_level=0x0810100b
[    1.310049] microcode: CPU4: patch_level=0x0810100b
[    1.310056] microcode: CPU5: patch_level=0x0810100b
[    1.310063] microcode: CPU6: patch_level=0x0810100b
[    1.310071] microcode: CPU7: patch_level=0x0810100b
[    1.310146] microcode: Microcode Update Driver: v2.2.
[    1.310183] sched_clock: Marking stable (1310130573, 0)->(1428049111, -117918538)
[    1.310456] hdaudio hdaudioC0D0: Unable to bind the codec
[    1.310549] registered taskstats version 1
[    1.310629] Loading compiled-in X.509 certificates
[    1.310678] Unable to create integrity sysfs dir: -19
[    1.311838]   Magic number: 10:627:188
[    1.311924] acpi device:47: hash matches
[    1.311933] acpi device:1a: hash matches
[    1.311964] console [netcon0] enabled
[    1.311965] netconsole: network logging started
[    1.312226] acpi_cpufreq: overriding BIOS provided _PSD data
[    1.313256] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    1.316367] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    1.316419] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[    1.316421] cfg80211: failed to load regulatory.db
[    1.316442] ALSA device list:
[    1.316443]   No soundcards found.
[    1.318715] hdaudio hdaudioC1D0: Unable to bind the codec
[    1.527347] ata9: SATA link down (SStatus 0 SControl 300)
[    1.618365] usb 1-1: new high-speed USB device number 2 using xhci_hcd
[    1.687066] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.694038] ata1.00: ATA-8: KINGSTON SV300S37A120G, 608ABBF0, max UDMA/133
[    1.694042] ata1.00: 234441648 sectors, multi 1: LBA48 NCQ (depth 32), AA
[    1.694130] random: fast init done
[    1.703333] ata1.00: configured for UDMA/133
[    1.703727] scsi 0:0:0:0: Direct-Access     ATA      KINGSTON SV300S3 BBF0 PQ: 0 ANSI: 5
[    1.704526] sd 0:0:0:0: [sda] 234441648 512-byte logical blocks: (120 GB/112 GiB)
[    1.704530] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    1.704555] sd 0:0:0:0: [sda] Write Protect is off
[    1.704559] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.704600] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.705497]  sda: sda1 sda2 sda3
[    1.706137] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.757214] usb 1-1: New USB device found, idVendor=0409, idProduct=005a, bcdDevice= 1.00
[    1.757222] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    1.762223] hub 1-1:1.0: USB hub found
[    1.765201] hub 1-1:1.0: 4 ports detected
[    1.866975] usb 2-2: new SuperSpeed Gen 1 USB device number 2 using xhci_hcd
[    1.890152] usb 2-2: New USB device found, idVendor=2001, idProduct=4a00, bcdDevice= 1.00
[    1.890157] usb 2-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    1.890159] usb 2-2: Product: D-Link DUB-1312
[    1.890162] usb 2-2: Manufacturer: D-Link Elec. Corp.
[    1.890164] usb 2-2: SerialNumber: 000000000018A9
[    2.012551] ata2: SATA link down (SStatus 0 SControl 300)
[    2.098356] usb 1-1.4: new low-speed USB device number 3 using xhci_hcd
[    2.207371] tsc: Refined TSC clocksource calibration: 3596.293 MHz
[    2.207394] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x33d6a542a31, max_idle_ns: 440795320725 ns
[    2.207455] clocksource: Switched to clocksource tsc
[    2.325353] ata5: SATA link down (SStatus 0 SControl 300)
[    2.427988] usb 1-1.4: New USB device found, idVendor=046d, idProduct=c31c, bcdDevice=64.00
[    2.427992] usb 1-1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.427995] usb 1-1.4: Product: USB Keyboard
[    2.427998] usb 1-1.4: Manufacturer: Logitech
[    2.543897] input: Logitech USB Keyboard as /devices/pci0000:00/0000:00:01.2/0000:01:00.0/usb1/1-1/1-1.4/1-1.4:1.0/0003:046D:C31C.0001/input/input2
[    2.596183] hid-generic 0003:046D:C31C.0001: input,hidraw0: USB HID v1.10 Keyboard [Logitech USB Keyboard] on usb-0000:01:00.0-1.4/input0
[    2.639225] ata6: SATA link down (SStatus 0 SControl 300)
[    2.718496] input: Logitech USB Keyboard Consumer Control as /devices/pci0000:00/0000:00:01.2/0000:01:00.0/usb1/1-1/1-1.4/1-1.4:1.1/0003:046D:C31C.0002/input/input3
[    2.770326] input: Logitech USB Keyboard System Control as /devices/pci0000:00/0000:00:01.2/0000:01:00.0/usb1/1-1/1-1.4/1-1.4:1.1/0003:046D:C31C.0002/input/input4
[    2.770580] input: Logitech USB Keyboard Consumer Control as /devices/pci0000:00/0000:00:01.2/0000:01:00.0/usb1/1-1/1-1.4/1-1.4:1.1/0003:046D:C31C.0002/input/input5
[    2.770738] hid-generic 0003:046D:C31C.0002: input,hidraw1: USB HID v1.10 Device [Logitech USB Keyboard] on usb-0000:01:00.0-1.4/input1
[    2.810964] input: Logitech USB Keyboard as /devices/pci0000:00/0000:00:01.2/0000:01:00.0/usb1/1-1/1-1.4/1-1.4:1.2/0003:046D:C31C.0003/input/input6
[    2.811132] hid-generic 0003:046D:C31C.0003: input,hidraw2: USB HID v1.10 Mouse [Logitech USB Keyboard] on usb-0000:01:00.0-1.4/input2
[    3.129310] Freeing unused kernel memory: 1592K
[    3.142280] Write protecting the kernel read-only data: 32768k
[    3.144841] Freeing unused kernel memory: 2004K
[    3.152605] Freeing unused kernel memory: 1924K
[    3.167830] systemd[1]: systemd 238 running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=hybrid)
[    3.180590] systemd[1]: Detected architecture x86-64.
[    3.180594] systemd[1]: Running in initial RAM disk.
[    3.182865] systemd[1]: Set hostname to <raven>.
[    3.232147] systemd[1]: File /usr/lib/systemd/system/systemd-journald.service:35 configures an IP firewall (IPAddressDeny=any), but the local system does not support BPF/cgroup based firewalling.
[    3.232152] systemd[1]: Proceeding WITHOUT firewalling in effect! (This warning is only shown for the first loaded unit using IP firewalling.)
[    3.236547] random: systemd: uninitialized urandom read (16 bytes read)
[    3.236673] systemd[1]: Listening on Journal Socket (/dev/log).
[    3.236729] random: systemd: uninitialized urandom read (16 bytes read)
[    3.236853] systemd[1]: Listening on Journal Socket.
[    3.236866] random: systemd: uninitialized urandom read (16 bytes read)
[    3.236887] systemd[1]: Reached target Timers.
[    3.236912] systemd[1]: Reached target Local File Systems.
[    3.252744] audit: type=1130 audit(1531761044.251:2): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-sysctl comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    3.309021] audit: type=1130 audit(1531761044.307:3): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-cmdline comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    3.334148] audit: type=1130 audit(1531761044.333:4): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-pre-udev comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    3.346551] audit: type=1130 audit(1531761044.345:5): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-udevd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    3.353753] audit: type=1130 audit(1531761044.352:6): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-vconsole-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    3.353778] audit: type=1131 audit(1531761044.352:7): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-vconsole-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    3.384382] audit: type=1130 audit(1531761044.383:8): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-journald comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    3.488097] audit: type=1130 audit(1531761044.487:9): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-udev-trigger comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    3.511258] audit: type=1130 audit(1531761044.510:10): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=plymouth-start comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    3.522284] r8169 0000:03:00.0 enp3s0: renamed from eth0
[    3.890808] ax88179_178a 2-2:1.0 eth0: register 'ax88179_178a' at usb-0000:01:00.0-2, D-Link DUB-1312 USB 3.0 to Gigabit Ethernet Adapter, 54:b8:0a:ef:ed:d7
[    3.890877] usbcore: registered new interface driver ax88179_178a
[    3.894528] ax88179_178a 2-2:1.0 enp1s0f0u2: renamed from eth0
[    3.959664] EXT4-fs (sda3): mounted filesystem with ordered data mode. Opts: (null)
[    4.352300] systemd-journald[1471]: Received SIGTERM from PID 1 (systemd).
[    4.390148] systemd: 23 output lines suppressed due to ratelimiting
[    4.467684] SELinux:  Disabled at runtime.
[    4.467701] SELinux:  Unregistering netfilter hooks
[    4.514362] systemd[1]: systemd 238 running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=hybrid)
[    4.526636] systemd[1]: Detected architecture x86-64.
[    4.527339] systemd[1]: Set hostname to <raven>.
[    4.634936] systemd[1]: File /usr/lib/systemd/system/systemd-journald.service:35 configures an IP firewall (IPAddressDeny=any), but the local system does not support BPF/cgroup based firewalling.
[    4.634942] systemd[1]: Proceeding WITHOUT firewalling in effect! (This warning is only shown for the first loaded unit using IP firewalling.)
[    4.685389] systemd[1]: /usr/lib/systemd/system/virtlockd-admin.socket:7: Unknown lvalue 'Server' in section 'Socket'
[    4.718973] systemd[1]: Stopped Switch Root.
[    4.719169] systemd[1]: systemd-journald.service: Service has no hold-off time, scheduling restart.
[    4.719235] systemd[1]: systemd-journald.service: Scheduled restart job, restart counter is at 1.
[    4.719249] systemd[1]: Stopped Journal Service.
[    4.748069] EXT4-fs (sda3): re-mounted. Opts: (null)
[    4.763671] systemd-journald[2466]: Received request to flush runtime journal from PID 1
[    5.104770] Adding 7826428k swap on /dev/sda2.  Priority:-2 extents:1 across:7826428k SS
[    5.254232] kauditd_printk_skb: 50 callbacks suppressed
[    5.254236] audit: type=1130 audit(1531761046.253:61): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-udev-settle comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.257299] audit: type=1130 audit(1531761046.256:62): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=lvm2-lvmetad comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.274189] audit: type=1130 audit(1531761046.273:63): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=lvm2-monitor comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.276612] audit: type=1130 audit(1531761046.275:64): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=dmraid-activation comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.276624] audit: type=1131 audit(1531761046.275:65): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=dmraid-activation comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.302820] audit: type=1130 audit(1531761046.301:66): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-fsck@dev-disk-by\x2duuid-05bc52dc\x2d0680\x2d4590\x2d9517\x2d8bc91c1cae3d comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.321469] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[    5.332276] audit: type=1130 audit(1531761046.331:67): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=dracut-shutdown comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.336366] audit: type=1130 audit(1531761046.335:68): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=nfs-config comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.336378] audit: type=1131 audit(1531761046.335:69): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=nfs-config comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.338823] audit: type=1130 audit(1531761046.337:70): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=plymouth-read-write comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.452646] random: crng init done
[    5.452648] random: 7 urandom warning(s) missed due to ratelimiting
[    5.452967] mcelog (3383) used greatest stack depth: 18608 bytes left
[    5.459847] lm_sensors-modp (3384) used greatest stack depth: 18232 bytes left
[    5.716324] plymouthd (2337) used greatest stack depth: 17336 bytes left
[    5.734008] IPv6: ADDRCONF(NETDEV_UP): enp1s0f0u2: link is not ready
[    6.102990] IPv6: ADDRCONF(NETDEV_UP): enp1s0f0u2: link is not ready
[    6.106452] IPv6: ADDRCONF(NETDEV_UP): enp3s0: link is not ready
[    6.143107] r8169 0000:03:00.0 enp3s0: link down
[    6.143232] IPv6: ADDRCONF(NETDEV_UP): enp3s0: link is not ready
[    8.730108] ax88179_178a 2-2:1.0 enp1s0f0u2: ax88179 - Link status is: 1
[    8.749694] IPv6: ADDRCONF(NETDEV_CHANGE): enp1s0f0u2: link becomes ready
[   92.100413] [drm] amdgpu kernel modesetting enabled.
[   92.121151] Parsing CRAT table with 1 nodes
[   92.121164] Creating topology SYSFS entries
[   92.121239] Topology: Add APU node [0x0:0x0]
[   92.121239] Finished initializing topology
[   92.121313] kfd kfd: Initialized module
[   92.122156] [drm] initializing kernel modesetting (RAVEN 0x1002:0x15DD 0x1043:0x876B 0xC6).
[   92.122186] [drm] register mmio base: 0xFE600000
[   92.122187] [drm] register mmio size: 524288
[   92.122217] [drm] add ip block number 0 <soc15_common>
[   92.122219] [drm] add ip block number 1 <gmc_v9_0>
[   92.122221] [drm] add ip block number 2 <vega10_ih>
[   92.122223] [drm] add ip block number 3 <psp>
[   92.122224] [drm] add ip block number 4 <powerplay>
[   92.122227] [drm] add ip block number 5 <dm>
[   92.122229] [drm] add ip block number 6 <gfx_v9_0>
[   92.122230] [drm] add ip block number 7 <sdma_v4_0>
[   92.122232] [drm] add ip block number 8 <vcn_v1_0>
[   92.124415] kfd kfd: DID 15dd is missing in supported_devices
[   92.124419] kfd kfd: kgd2kfd_probe failed
[   92.124599] [drm] VCN decode is enabled in VM mode
[   92.124600] [drm] VCN encode is enabled in VM mode
[   92.124601] [drm] VCN jpeg decode is enabled in VM mode
[   92.148220] [drm] BIOS signature incorrect 65 7
[   92.148268] ATOM BIOS: 113-RAVEN-106
[   92.148340] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, fragment size is 9-bit
[   92.148356] amdgpu 0000:06:00.0: VRAM: 1024M 0x000000F400000000 - 0x000000F43FFFFFFF (1024M used)
[   92.148359] amdgpu 0000:06:00.0: GART: 1024M 0x000000F500000000 - 0x000000F53FFFFFFF
[   92.148364] [drm] Detected VRAM RAM=1024M, BAR=1024M
[   92.148365] [drm] RAM width 128bits DDR4
[   92.148475] [TTM] Zone  kernel: Available graphics memory: 3096204 kiB
[   92.148476] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[   92.148477] [TTM] Initializing pool allocator
[   92.148487] [TTM] Initializing DMA pool allocator
[   92.148603] [drm] amdgpu: 1024M of VRAM memory ready
[   92.148605] [drm] amdgpu: 3072M of GTT memory ready.
[   92.148624] [drm] GART: num cpu pages 262144, num gpu pages 262144
[   92.148808] [drm] PCIE GART of 1024M enabled (table at 0x000000F400900000).
[   92.156791] [drm] use_doorbell being set to: [true]
[   92.157981] [drm] Found VCN firmware Version: 1.24 Family ID: 18
[   92.226714] amdgpu: [powerplay] dpm has been enabled
[   92.226821] [drm] DM_PPLIB: values for Invalid clock
[   92.226823] [drm] DM_PPLIB:	 0 in kHz
[   92.226824] [drm] DM_PPLIB:	 400000 in kHz
[   92.226824] [drm] DM_PPLIB:	 933000 in kHz
[   92.226825] [drm] DM_PPLIB:	 1067000 in kHz
[   92.227016] WARNING: CPU: 5 PID: 3705 at drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:1372 dcn_bw_update_from_pplib+0x309/0x530 [amdgpu]
[   92.227017] Modules linked in: amdkfd amdgpu(+) mfd_core chash gpu_sched ttm ax88179_178a usbnet
[   92.227028] CPU: 5 PID: 3705 Comm: modprobe Not tainted 4.18.0-rc1+ #8
[   92.227030] Hardware name: System manufacturer System Product Name/TUF B350M-PLUS GAMING, BIOS 4011 04/19/2018
[   92.227192] RIP: 0010:dcn_bw_update_from_pplib+0x309/0x530 [amdgpu]
[   92.227193] Code: 64 1d 00 dc f9 d9 c9 dc 4c 24 08 dc 0d b0 64 1d 00 de f1 d9 5c 24 08 e8 55 b6 14 d2 f3 0f 10 5c 24 08 f3 41 0f 11 5f 4c eb 02 <0f> 0b 4c 8d a4 24 c0 00 00 00 48 8b 3c 24 be 04 00 00 00 4c 89 e2 
[   92.227225] RSP: 0018:ffff8801d7756908 EFLAGS: 00010246
[   92.227227] RAX: 0000000000000000 RBX: ffff8801d7756948 RCX: ffffffffc0417648
[   92.227229] RDX: 0000000000000007 RSI: dffffc0000000000 RDI: ffff8801d775694c
[   92.227230] RBP: ffff8801cb66d500 R08: ffffed003c02bc9f R09: ffffed003c02bc9e
[   92.227232] R10: ffffed003c02bc9e R11: ffff8801e015e4f7 R12: 0000000000000004
[   92.227233] R13: 1ffff1003aeead25 R14: ffff8801d2e615c0 R15: 0000000000000000
[   92.227235] FS:  00007fc87494e0c0(0000) GS:ffff8801e0140000(0000) knlGS:0000000000000000
[   92.227237] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   92.227238] CR2: 0000563712cb2a00 CR3: 00000001dbed4000 CR4: 00000000003406e0
[   92.227239] Call Trace:
[   92.227403]  ? dcn_find_dcfclk_suits_all+0x610/0x610 [amdgpu]
[   92.227409]  ? rcu_note_context_switch+0x2a0/0x2a0
[   92.227572]  ? dcn10_create_resource_pool+0x5e6/0xef0 [amdgpu]
[   92.227734]  ? dcn10_create_resource_pool+0x5e6/0xef0 [amdgpu]
[   92.227897]  ? dcn10_create_resource_pool+0xbe2/0xef0 [amdgpu]
[   92.228060]  ? dal_i2caux_construct_engine+0x22/0x30 [amdgpu]
[   92.228222]  ? dal_aux_engine_dce110_create+0x9f/0xd0 [amdgpu]
[   92.228384]  ? dcn10_clock_source_destroy+0x30/0x30 [amdgpu]
[   92.228546]  ? dal_i2caux_dce110_construct+0x386/0x400 [amdgpu]
[   92.228706]  ? dc_create_resource_pool+0x8b/0x240 [amdgpu]
[   92.228866]  ? resource_parse_asic_id+0x170/0x170 [amdgpu]
[   92.228870]  ? kasan_kmalloc+0xbf/0xe0
[   92.229032]  ? dal_gpio_service_create+0xe7/0x180 [amdgpu]
[   92.229035]  ? __kmalloc+0x104/0x1f0
[   92.229197]  ? dal_gpio_service_create+0xe7/0x180 [amdgpu]
[   92.229357]  ? dc_create+0x407/0xc90 [amdgpu]
[   92.229519]  ? dc_create_state+0xe0/0xe0 [amdgpu]
[   92.229679]  ? amdgpu_dm_irq_unregister_interrupt+0x320/0x320 [amdgpu]
[   92.229818]  ? amdgpu_mm_rreg+0x1e4/0x210 [amdgpu]
[   92.229821]  ? rcu_note_context_switch+0x2a0/0x2a0
[   92.229823]  ? kasan_unpoison_shadow+0x30/0x40
[   92.229825]  ? kasan_kmalloc+0xbf/0xe0
[   92.229979]  ? amdgpu_cgs_create_device+0x27/0x60 [amdgpu]
[   92.229982]  ? kmem_cache_alloc_trace+0xea/0x1a0
[   92.230135]  ? amdgpu_cgs_create_device+0x27/0x60 [amdgpu]
[   92.230296]  ? dm_hw_init+0x20c/0x320 [amdgpu]
[   92.230456]  ? dm_resume+0x580/0x580 [amdgpu]
[   92.230615]  ? psm_set_states+0xc3/0xe0 [amdgpu]
[   92.230771]  ? hwmgr_hw_init+0x27e/0x2a0 [amdgpu]
[   92.230931]  ? amdgpu_device_init.cold.29+0x11ca/0x1784 [amdgpu]
[   92.231071]  ? amdgpu_device_has_dc_support+0x30/0x30 [amdgpu]
[   92.231075]  ? __alloc_pages_nodemask+0x26c/0x4e0
[   92.231078]  ? __alloc_pages_slowpath+0x1780/0x1780
[   92.231080]  ? save_stack+0x8c/0xb0
[   92.231084]  ? mutex_unlock+0x18/0x40
[   92.231087]  ? kernfs_activate+0x13f/0x180
[   92.231090]  ? kernfs_get+0x10/0x10
[   92.231092]  ? kasan_unpoison_shadow+0x30/0x40
[   92.231095]  ? kmalloc_order+0x46/0x60
[   92.231235]  ? amdgpu_driver_load_kms+0x110/0x3c0 [amdgpu]
[   92.231375]  ? amdgpu_driver_unload_kms+0xd0/0xd0 [amdgpu]
[   92.231378]  ? sysfs_do_create_link_sd.isra.2+0xef/0x190
[   92.231381]  ? __kasan_slab_free+0x13a/0x170
[   92.231384]  ? drm_dev_register+0x1a4/0x1f0
[   92.231524]  ? amdgpu_pci_probe+0x1af/0x230 [amdgpu]
[   92.231663]  ? amdgpu_pmops_runtime_idle+0x190/0x190 [amdgpu]
[   92.231667]  ? local_pci_probe+0x6b/0xc0
[   92.231669]  ? pci_device_probe+0x195/0x260
[   92.231672]  ? pci_device_remove+0x1d0/0x1d0
[   92.231676]  ? driver_probe_device+0x426/0x510
[   92.231679]  ? driver_probe_done+0xb0/0xb0
[   92.231681]  ? mutex_lock+0xa1/0x100
[   92.231684]  ? __mutex_lock_slowpath+0x10/0x10
[   92.231687]  ? driver_probe_device+0x510/0x510
[   92.231689]  ? __driver_attach+0x12c/0x130
[   92.231691]  ? bus_for_each_dev+0xe1/0x140
[   92.231694]  ? subsys_dev_iter_exit+0x10/0x10
[   92.231696]  ? bus_add_driver+0x78/0x2c0
[   92.231698]  ? kmem_cache_alloc_trace+0xea/0x1a0
[   92.231701]  ? bus_add_driver+0x276/0x2c0
[   92.231704]  ? driver_register+0xca/0x140
[   92.231707]  ? __pci_register_driver+0x144/0x170
[   92.231709]  ? pci_bus_num_vf+0x10/0x10
[   92.231711]  ? kmem_cache_create_usercopy+0x1a8/0x290
[   92.231714]  ? 0xffffffffc06c8000
[   92.231717]  ? do_one_initcall+0xa2/0x2cc
[   92.231719]  ? trace_event_raw_event_initcall_finish+0x130/0x130
[   92.231722]  ? qlist_free_all+0x32/0xc0
[   92.231724]  ? qlist_free_all+0x47/0xc0
[   92.231727]  ? __srcu_read_unlock+0x19/0x30
[   92.231729]  ? quarantine_reduce+0x14c/0x160
[   92.231731]  ? kasan_unpoison_shadow+0x30/0x40
[   92.231733]  ? kasan_kmalloc+0xbf/0xe0
[   92.231735]  ? kasan_unpoison_shadow+0x30/0x40
[   92.231739]  ? do_init_module+0x14e/0x3c0
[   92.231741]  ? __x64_sys_delete_module+0x3c0/0x3c0
[   92.231744]  ? __kasan_slab_free+0x13a/0x170
[   92.231746]  ? load_module+0x3796/0x3f10
[   92.231752]  ? module_frob_arch_sections+0x20/0x20
[   92.231754]  ? __vfs_read+0x32f/0x370
[   92.231756]  ? __x64_sys_copy_file_range+0x360/0x360
[   92.231760]  ? __fsnotify_update_child_dentry_flags.part.3+0x2d0/0x2d0
[   92.231762]  ? __fsnotify_parent+0x7f/0x210
[   92.231765]  ? __fsnotify_update_child_dentry_flags.part.3+0x2d0/0x2d0
[   92.231768]  ? vfs_read+0x16c/0x1a0
[   92.231770]  ? vfs_read+0xbe/0x1a0
[   92.231772]  ? kernel_read+0x6f/0x90
[   92.231775]  ? kernel_read_file+0x210/0x2f0
[   92.231777]  ? free_bprm+0xf0/0xf0
[   92.231780]  ? up_read+0x20/0x20
[   92.231783]  ? __do_sys_finit_module+0x18f/0x1c0
[   92.231785]  ? __do_sys_finit_module+0x18f/0x1c0
[   92.231787]  ? __ia32_sys_init_module+0x40/0x40
[   92.231790]  ? vfs_statx_fd+0x3f/0x80
[   92.231792]  ? __do_sys_newfstat+0xb5/0xc0
[   92.231796]  ? do_syscall_64+0xf7/0x2a0
[   92.231798]  ? syscall_return_slowpath+0x1d0/0x1d0
[   92.231801]  ? do_page_fault+0x8a/0x210
[   92.231803]  ? __do_page_fault+0x680/0x680
[   92.231805]  ? prepare_exit_to_usermode+0xe8/0x150
[   92.231807]  ? perf_trace_sys_enter+0x4b0/0x4b0
[   92.231810]  ? __put_user_4+0x1c/0x30
[   92.231813]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   92.231816] ---[ end trace 36f5b1fcd27e12f5 ]---
[   92.231826] [drm] DM_PPLIB: values for Invalid clock
[   92.231827] [drm] DM_PPLIB:	 300000 in kHz
[   92.231828] [drm] DM_PPLIB:	 600000 in kHz
[   92.231829] [drm] DM_PPLIB:	 626000 in kHz
[   92.231829] [drm] DM_PPLIB:	 654000 in kHz
[   92.247387] [drm] Display Core initialized with v3.1.55!
[   92.272411] [drm] SADs count is: -524, don't need to read it
[   92.273032] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   92.273033] [drm] Driver supports precise vblank timestamp query.
[   92.295987] [drm] VCN decode and encode initialized successfully.
[   92.298592] [drm] fb mappable at 0xA1100000
[   92.298594] [drm] vram apper at 0xA0000000
[   92.298595] [drm] size 8294400
[   92.298596] [drm] fb depth is 24
[   92.298597] [drm]    pitch is 7680
[   92.298729] fbcon: amdgpudrmfb (fb0) is primary device
[   92.363839] Console: switching to colour frame buffer device 240x67
[   92.378502] amdgpu 0000:06:00.0: fb0: amdgpudrmfb frame buffer device
[   92.384493] amdgpu 0000:06:00.0: ring 0(gfx) uses VM inv eng 4 on hub 0
[   92.384496] amdgpu 0000:06:00.0: ring 1(comp_1.0.0) uses VM inv eng 5 on hub 0
[   92.384499] amdgpu 0000:06:00.0: ring 2(comp_1.1.0) uses VM inv eng 6 on hub 0
[   92.384501] amdgpu 0000:06:00.0: ring 3(comp_1.2.0) uses VM inv eng 7 on hub 0
[   92.384503] amdgpu 0000:06:00.0: ring 4(comp_1.3.0) uses VM inv eng 8 on hub 0
[   92.384505] amdgpu 0000:06:00.0: ring 5(comp_1.0.1) uses VM inv eng 9 on hub 0
[   92.384507] amdgpu 0000:06:00.0: ring 6(comp_1.1.1) uses VM inv eng 10 on hub 0
[   92.384509] amdgpu 0000:06:00.0: ring 7(comp_1.2.1) uses VM inv eng 11 on hub 0
[   92.384511] amdgpu 0000:06:00.0: ring 8(comp_1.3.1) uses VM inv eng 12 on hub 0
[   92.384513] amdgpu 0000:06:00.0: ring 9(kiq_2.1.0) uses VM inv eng 13 on hub 0
[   92.384515] amdgpu 0000:06:00.0: ring 10(sdma0) uses VM inv eng 4 on hub 1
[   92.384517] amdgpu 0000:06:00.0: ring 11(vcn_dec) uses VM inv eng 5 on hub 1
[   92.384519] amdgpu 0000:06:00.0: ring 12(vcn_enc0) uses VM inv eng 6 on hub 1
[   92.384521] amdgpu 0000:06:00.0: ring 13(vcn_enc1) uses VM inv eng 7 on hub 1
[   92.384523] amdgpu 0000:06:00.0: ring 14(vcn_jpeg) uses VM inv eng 8 on hub 1
[   92.841033] [drm] Initialized amdgpu 3.27.0 20150101 for 0000:06:00.0 on minor 0
[   92.841777] modprobe (3705) used greatest stack depth: 16472 bytes left
[   93.547536] WARNING: CPU: 4 PID: 1084 at drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:92 amdgpu_ttm_bo_destroy+0x386/0x3a0 [amdgpu]
[   93.547539] Modules linked in: amdkfd amdgpu mfd_core chash gpu_sched ttm ax88179_178a usbnet
[   93.547550] CPU: 4 PID: 1084 Comm: kworker/4:1 Tainted: G        W         4.18.0-rc1+ #8
[   93.547551] Hardware name: System manufacturer System Product Name/TUF B350M-PLUS GAMING, BIOS 4011 04/19/2018
[   93.547563] Workqueue: events ttm_bo_delayed_workqueue [ttm]
[   93.547678] RIP: 0010:amdgpu_ttm_bo_destroy+0x386/0x3a0 [amdgpu]
[   93.547678] Code: 5c 41 5d 41 5e 41 5f c3 4c 89 ef e8 34 01 35 d2 48 c7 83 70 03 00 00 00 00 00 00 e9 17 fe ff ff 4c 8d 64 24 40 e9 0d fe ff ff <0f> 0b 4c 89 ff e8 a0 fb ff ff e9 25 fd ff ff e8 e6 fc 08 d2 66 0f 
[   93.547710] RSP: 0018:ffff8801d5bbf100 EFLAGS: 00010202
[   93.547712] RAX: 0000000000000001 RBX: ffff8801cce8f758 RCX: ffffffffc0212b8c
[   93.547714] RDX: 0000000000000003 RSI: dffffc0000000000 RDI: ffff8801cce8f9a8
[   93.547715] RBP: 1ffff1003ab77e24 R08: 0000000000000000 R09: ffff8801d5bbef70
[   93.547716] R10: ffffed003ab77df8 R11: ffff8801d5bbefc7 R12: 0000000000000000
[   93.547718] R13: ffff8801cce8f758 R14: ffff8801cce8f810 R15: ffff8801cce8f700
[   93.547720] FS:  0000000000000000(0000) GS:ffff8801e0100000(0000) knlGS:0000000000000000
[   93.547721] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   93.547723] CR2: 0000000000987000 CR3: 00000001d9822000 CR4: 00000000003406e0
[   93.547724] Call Trace:
[   93.547839]  ? amdgpu_bo_subtract_pin_size+0xd0/0xd0 [amdgpu]
[   93.547844]  ? update_nohz_stats+0x70/0x140
[   93.547849]  ? mutex_unlock+0x18/0x40
[   93.547859]  ? ttm_bo_cleanup_refs+0x5be/0x630 [ttm]
[   93.547869]  ? ttm_bo_put+0x20/0x20 [ttm]
[   93.547873]  ? __kasan_slab_free+0x13a/0x170
[   93.547883]  ? ttm_bo_release_list+0x3d2/0x480 [ttm]
[   93.547893]  ? ttm_bo_add_move_fence.isra.20+0x170/0x170 [ttm]
[   93.547896]  ? kernfs_put+0x2aa/0x3e0
[   93.547899]  ? get_nohz_timer_target+0xd2/0x390
[   93.547901]  ? resched_cpu+0x70/0x70
[   93.547904]  ? detach_if_pending+0x85/0x240
[   93.547907]  ? init_timer_key+0x160/0x160
[   93.547909]  ? __internal_add_timer+0x10e/0x160
[   93.547911]  ? mutex_trylock+0xed/0x120
[   93.547914]  ? ww_mutex_unlock+0x40/0x40
[   93.547916]  ? pick_next_entity+0xed/0x1d0
[   93.547927]  ? ttm_bo_delayed_delete+0x25c/0x5e0 [ttm]
[   93.547937]  ? ttm_bo_cleanup_refs+0x630/0x630 [ttm]
[   93.547940]  ? rcu_note_context_switch+0x2a0/0x2a0
[   93.547943]  ? rcu_segcblist_extract_pend_cbs+0xa0/0xa0
[   93.547945]  ? __cpuidle_text_end+0x4/0x4
[   93.547949]  ? gc_worker+0x4b0/0x690
[   93.547952]  ? rcu_rnp_online_cpus+0xa0/0xa0
[   93.547954]  ? __update_idle_core+0x127/0x280
[   93.547957]  ? finish_task_switch+0x217/0x4e0
[   93.547960]  ? set_load_weight+0x100/0x100
[   93.547963]  ? read_word_at_a_time+0xe/0x20
[   93.547965]  ? strscpy+0x14b/0x280
[   93.547967]  ? read_word_at_a_time+0x20/0x20
[   93.547978]  ? ttm_bo_delayed_workqueue+0x12/0x40 [ttm]
[   93.547981]  ? process_one_work+0x5a8/0x980
[   93.547983]  ? max_active_store+0xe0/0xe0
[   93.547985]  ? __sched_text_start+0x8/0x8
[   93.547988]  ? pick_next_entity+0xed/0x1d0
[   93.547990]  ? pick_next_task_fair+0x970/0xb20
[   93.547993]  ? run_rebalance_domains+0x250/0x250
[   93.547995]  ? resched_curr+0x87/0x190
[   93.547998]  ? schedule+0xca/0x240
[   93.548001]  ? worker_enter_idle+0x217/0x330
[   93.548003]  ? __schedule+0xd50/0xd50
[   93.548006]  ? fork_usermode_blob+0x130/0x130
[   93.548008]  ? call_function_single_interrupt+0xa/0x20
[   93.548010]  ? worker_thread+0x2f3/0xa70
[   93.548013]  ? worker_thread+0x17c/0xa70
[   93.548016]  ? process_one_work+0x980/0x980
[   93.548018]  ? try_to_wake_up+0x105/0x920
[   93.548020]  ? __schedule+0x528/0xd50
[   93.548022]  ? migrate_swap_stop+0x430/0x430
[   93.548025]  ? __sched_text_start+0x8/0x8
[   93.548027]  ? save_stack+0x8c/0xb0
[   93.548031]  ? schedule+0xca/0x240
[   93.548034]  ? __schedule+0xd50/0xd50
[   93.548036]  ? remove_wait_queue+0x150/0x150
[   93.548038]  ? rcu_note_context_switch+0x2a0/0x2a0
[   93.548041]  ? kasan_unpoison_shadow+0x30/0x40
[   93.548043]  ? __kthread_parkme+0xc7/0x100
[   93.548045]  ? parse_args.cold.17+0x146/0x146
[   93.548048]  ? process_one_work+0x980/0x980
[   93.548050]  ? kthread+0x19b/0x1c0
[   93.548052]  ? kthread_create_worker_on_cpu+0xc0/0xc0
[   93.548054]  ? ret_from_fork+0x22/0x40
[   93.548057] ---[ end trace 36f5b1fcd27e12f6 ]---
[   95.087371] fuse init (API version 7.27)
[   97.376418] rfkill: input handler disabled
[  169.008965] BUG: unable to handle kernel paging request at ffffffffffffff88
[  169.008975] PGD 51410067 P4D 51410067 PUD 51412067 PMD 0 
[  169.008982] Oops: 0000 [#1] SMP KASAN NOPTI
[  169.008987] CPU: 2 PID: 4555 Comm: heaven_x64 Tainted: G        W         4.18.0-rc1+ #8
[  169.008989] Hardware name: System manufacturer System Product Name/TUF B350M-PLUS GAMING, BIOS 4011 04/19/2018
[  169.009093] RIP: 0010:amdgpu_job_free_resources+0x8e/0xe0 [amdgpu]
[  169.009095] Code: 44 24 08 48 8b 3c 24 e8 c0 0f 20 d2 89 d8 48 8b 7c 24 08 83 c3 01 48 8d 14 80 48 8b 85 e8 01 00 00 4c 8d 3c d0 e8 a2 0f 20 d2 <49> 8b 7e 88 4c 89 e2 4c 89 fe e8 33 b5 ee ff 4c 89 ef e8 8b 0e 20 
[  169.009120] RSP: 0018:ffff8801dd49f260 EFLAGS: 00010246
[  169.009123] RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffffffc0361f5e
[  169.009125] RDX: dffffc0000000000 RSI: dffffc0000000000 RDI: ffffffffffffff88
[  169.009128] RBP: ffff8801ca9b1680 R08: ffffed0039cf0691 R09: ffffed0039cf0690
[  169.009130] R10: ffffed0039cf0690 R11: ffff8801ce783483 R12: 0000000000000000
[  169.009132] R13: ffff8801ca9b187c R14: 0000000000000000 R15: ffff8801ca9b18d0
[  169.009134] FS:  00007f8d39713d00(0000) GS:ffff8801e0080000(0000) knlGS:0000000000000000
[  169.009136] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  169.009138] CR2: ffffffffffffff88 CR3: 00000001d9e3e000 CR4: 00000000003406e0
[  169.009140] Call Trace:
[  169.009240]  ? amdgpu_job_free+0x9/0x60 [amdgpu]
[  169.009330]  ? amdgpu_vm_update_directories+0x9d1/0xac0 [amdgpu]
[  169.009421]  ? amdgpu_vm_bo_find+0x70/0x70 [amdgpu]
[  169.009511]  ? amdgpu_vm_clear_bo+0x530/0x530 [amdgpu]
[  169.009522]  ? ttm_eu_reserve_buffers+0x446/0x750 [ttm]
[  169.009611]  ? amdgpu_vm_it_insert+0xb6/0xf0 [amdgpu]
[  169.009616]  ? _raw_spin_lock+0xe/0x30
[  169.009706]  ? amdgpu_vm_bo_insert_map+0x423/0x440 [amdgpu]
[  169.009796]  ? amdgpu_vm_it_iter_first.isra.22+0x70/0x70 [amdgpu]
[  169.009890]  ? amdgpu_vm_clear_freed+0x263/0x360 [amdgpu]
[  169.009980]  ? amdgpu_vm_bo_update+0xf50/0xf50 [amdgpu]
[  169.009984]  ? kasan_unpoison_shadow+0x30/0x40
[  169.009986]  ? kasan_kmalloc+0xbf/0xe0
[  169.010076]  ? amdgpu_vm_bo_map+0xe8/0x1c0 [amdgpu]
[  169.010080]  ? kmem_cache_alloc_trace+0xea/0x1a0
[  169.010170]  ? amdgpu_vm_ready+0x70/0xa0 [amdgpu]
[  169.010259]  ? amdgpu_vm_validate_pt_bos+0x580/0x580 [amdgpu]
[  169.010349]  ? amdgpu_vm_bo_map+0x13c/0x1c0 [amdgpu]
[  169.010438]  ? amdgpu_gem_va_ioctl+0x904/0x950 [amdgpu]
[  169.010442]  ? __radix_tree_preload+0x30/0xd0
[  169.010531]  ? amdgpu_gem_metadata_ioctl+0x3a0/0x3a0 [amdgpu]
[  169.010534]  ? mutex_lock+0xa1/0x100
[  169.010537]  ? __mutex_lock_slowpath+0x10/0x10
[  169.010626]  ? amdgpu_gem_create_ioctl+0x320/0x540 [amdgpu]
[  169.010629]  ? rpm_resume+0x1a1/0xee0
[  169.010632]  ? rpm_callback+0xd0/0xd0
[  169.010636]  ? __srcu_read_lock+0x99/0xe0
[  169.010639]  ? rcu_sync_dtor+0x180/0x180
[  169.010643]  ? drm_ioctl_kernel+0x14f/0x1a0
[  169.010732]  ? amdgpu_gem_metadata_ioctl+0x3a0/0x3a0 [amdgpu]
[  169.010735]  ? drm_setversion+0x330/0x330
[  169.010824]  ? amdgpu_gem_metadata_ioctl+0x3a0/0x3a0 [amdgpu]
[  169.010826]  ? drm_ioctl+0x30c/0x580
[  169.010829]  ? drm_getunique+0xe0/0xe0
[  169.010833]  ? __cpuidle_text_end+0x4/0x4
[  169.010836]  ? __kasan_slab_free+0x120/0x170
[  169.010839]  ? filename_lookup+0x1ef/0x2c0
[  169.010841]  ? kmem_cache_free+0x6e/0x190
[  169.010928]  ? amdgpu_drm_ioctl+0xca/0x180 [amdgpu]
[  169.010930]  ? 0xffffffffc01f0000
[  169.010934]  ? do_vfs_ioctl+0x13d/0xa50
[  169.010936]  ? ioctl_preallocate+0x170/0x170
[  169.010940]  ? __fget_light+0x1f5/0x210
[  169.010943]  ? expand_files.part.9+0x560/0x560
[  169.010946]  ? __do_sys_newstat+0x77/0xd0
[  169.010949]  ? __ia32_sys_newfstat+0x30/0x30
[  169.010952]  ? handle_mm_fault+0xf7/0x1a0
[  169.010956]  ? __do_page_fault+0x3fc/0x680
[  169.010959]  ? ksys_ioctl+0x5b/0x90
[  169.010961]  ? __x64_sys_ioctl+0x38/0x40
[  169.010965]  ? do_syscall_64+0xf7/0x2a0
[  169.010968]  ? syscall_return_slowpath+0x1d0/0x1d0
[  169.010970]  ? do_page_fault+0x8a/0x210
[  169.010974]  ? __do_page_fault+0x680/0x680
[  169.010978]  ? prepare_exit_to_usermode+0xe8/0x150
[  169.010982]  ? perf_trace_sys_enter+0x4b0/0x4b0
[  169.010986]  ? __put_user_4+0x1c/0x30
[  169.010990]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  169.010993] Modules linked in: fuse amdkfd amdgpu mfd_core chash gpu_sched ttm ax88179_178a usbnet
[  169.011003] CR2: ffffffffffffff88
[  169.011006] ---[ end trace 36f5b1fcd27e12f7 ]---
[  169.011122] RIP: 0010:amdgpu_job_free_resources+0x8e/0xe0 [amdgpu]
[  169.011124] Code: 44 24 08 48 8b 3c 24 e8 c0 0f 20 d2 89 d8 48 8b 7c 24 08 83 c3 01 48 8d 14 80 48 8b 85 e8 01 00 00 4c 8d 3c d0 e8 a2 0f 20 d2 <49> 8b 7e 88 4c 89 e2 4c 89 fe e8 33 b5 ee ff 4c 89 ef e8 8b 0e 20 
[  169.011150] RSP: 0018:ffff8801dd49f260 EFLAGS: 00010246
[  169.011152] RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffffffc0361f5e
[  169.011155] RDX: dffffc0000000000 RSI: dffffc0000000000 RDI: ffffffffffffff88
[  169.011157] RBP: ffff8801ca9b1680 R08: ffffed0039cf0691 R09: ffffed0039cf0690
[  169.011159] R10: ffffed0039cf0690 R11: ffff8801ce783483 R12: 0000000000000000
[  169.011161] R13: ffff8801ca9b187c R14: 0000000000000000 R15: ffff8801ca9b18d0
[  169.011163] FS:  00007f8d39713d00(0000) GS:ffff8801e0080000(0000) knlGS:0000000000000000
[  169.011166] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  169.011168] CR2: ffffffffffffff88 CR3: 00000001d9e3e000 CR4: 00000000003406e0
[  169.011172] ==================================================================
[  169.011177] BUG: KASAN: stack-out-of-bounds in tick_sched_handle+0x5f/0x80
[  169.011179] Read of size 8 at addr ffff8801dd49f810 by task heaven_x64/4555

[  169.011185] CPU: 2 PID: 4555 Comm: heaven_x64 Tainted: G      D W         4.18.0-rc1+ #8
[  169.011187] Hardware name: System manufacturer System Product Name/TUF B350M-PLUS GAMING, BIOS 4011 04/19/2018
[  169.011189] Call Trace:
[  169.011190]  <IRQ>
[  169.011194]  ? dump_stack+0xad/0x12c
[  169.011198]  ? dump_stack_print_info.cold.1+0x2f/0x2f
[  169.011201]  ? kmsg_dump_rewind_nolock+0x54/0x54
[  169.011204]  ? ktime_get_raw_ts64+0x1e0/0x1e0
[  169.011207]  ? tick_sched_handle+0x5f/0x80
[  169.011210]  ? print_address_description+0x60/0x229
[  169.011213]  ? tick_sched_handle+0x5f/0x80
[  169.011215]  ? kasan_report.cold.6+0x241/0x2fd
[  169.011218]  ? tick_sched_handle+0x5f/0x80
[  169.011221]  ? tick_sched_timer+0x32/0x90
[  169.011224]  ? __hrtimer_run_queues+0x27c/0x540
[  169.011227]  ? tick_sched_do_timer+0x80/0x80
[  169.011230]  ? hrtimer_init+0x140/0x140
[  169.011233]  ? rcu_nmi_exit+0x18d/0x3e0
[  169.011236]  ? ktime_get_update_offsets_now+0x13d/0x260
[  169.011238]  ? do_timer+0x20/0x20
[  169.011241]  ? rcu_idle_exit+0x260/0x260
[  169.011244]  ? __cpuidle_text_end+0x4/0x4
[  169.011247]  ? _raw_spin_trylock+0x90/0xf0
[  169.011250]  ? hrtimer_interrupt+0x1a0/0x340
[  169.011253]  ? smp_apic_timer_interrupt+0xe5/0x2a0
[  169.011256]  ? smp_call_function_single_interrupt+0x230/0x230
[  169.011260]  ? task_prio+0x20/0x20
[  169.011263]  ? handle_irq+0x111/0x193
[  169.011266]  ? apic_timer_interrupt+0xf/0x20
[  169.011268]  </IRQ>
[  169.011272]  ? exit_signals+0x283/0x3e0
[  169.011274]  ? exit_signals+0x174/0x3e0
[  169.011277]  ? get_signal+0xab0/0xab0
[  169.011280]  ? __srcu_read_lock+0x99/0xe0
[  169.011283]  ? rcu_sync_dtor+0x180/0x180
[  169.011286]  ? blocking_notifier_call_chain+0x8b/0x110
[  169.011289]  ? srcu_init_notifier_head+0x40/0x40
[  169.011293]  ? do_exit+0x2a8/0x11f0
[  169.011296]  ? drm_setversion+0x330/0x330
[  169.011299]  ? release_task.part.22+0xc80/0xc80
[  169.011396]  ? amdgpu_gem_metadata_ioctl+0x3a0/0x3a0 [amdgpu]
[  169.011399]  ? drm_ioctl+0x30c/0x580
[  169.011403]  ? drm_getunique+0xe0/0xe0
[  169.011406]  ? __cpuidle_text_end+0x4/0x4
[  169.011409]  ? __kasan_slab_free+0x120/0x170
[  169.011412]  ? filename_lookup+0x1ef/0x2c0
[  169.011415]  ? kmem_cache_free+0x6e/0x190
[  169.011510]  ? amdgpu_drm_ioctl+0xca/0x180 [amdgpu]
[  169.011512]  ? 0xffffffffc01f0000
[  169.011516]  ? do_vfs_ioctl+0x13d/0xa50
[  169.011519]  ? ioctl_preallocate+0x170/0x170
[  169.011522]  ? __fget_light+0x1f5/0x210
[  169.011525]  ? expand_files.part.9+0x560/0x560
[  169.011529]  ? __do_sys_newstat+0x77/0xd0
[  169.011532]  ? __ia32_sys_newfstat+0x30/0x30
[  169.011534]  ? handle_mm_fault+0xf7/0x1a0
[  169.011537]  ? __do_page_fault+0x3fc/0x680
[  169.011540]  ? ksys_ioctl+0x5b/0x90
[  169.011543]  ? __x64_sys_ioctl+0x38/0x40
[  169.011546]  ? do_syscall_64+0xf7/0x2a0
[  169.011548]  ? syscall_return_slowpath+0x1d0/0x1d0
[  169.011551]  ? do_page_fault+0x8a/0x210
[  169.011554]  ? __do_page_fault+0x680/0x680
[  169.011557]  ? prepare_exit_to_usermode+0xe8/0x150
[  169.011559]  ? perf_trace_sys_enter+0x4b0/0x4b0
[  169.011562]  ? __put_user_4+0x1c/0x30
[  169.011565]  ? rewind_stack_do_exit+0x17/0x20

[  169.011569] The buggy address belongs to the page:
[  169.011572] page:ffffea00077527c0 count:0 mapcount:0 mapping:0000000000000000 index:0x0
[  169.011574] flags: 0x200000000000000()
[  169.011579] raw: 0200000000000000 0000000000000000 ffffea00077527c8 0000000000000000
[  169.011582] raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
[  169.011584] page dumped because: kasan: bad access detected

[  169.011586] Memory state around the buggy address:
[  169.011589]  ffff8801dd49f700: f2 f2 f2 f2 00 00 00 f2 f2 f2 f2 f2 00 00 00 00
[  169.011591]  ffff8801dd49f780: f2 f2 f2 00 00 00 00 00 00 00 00 00 00 f2 f2 f2
[  169.011594] >ffff8801dd49f800: f2 f2 f2 f2 f8 f2 f1 f1 f1 f1 f8 f2 f2 f2 f2 f2
[  169.011595]                          ^
[  169.011598]  ffff8801dd49f880: f2 f2 00 f2 f2 f2 f2 f2 f2 f2 f8 f2 f2 f2 00 00
[  169.011600]  ffff8801dd49f900: 00 00 00 00 00 00 f1 f1 f1 f1 f8 f2 f2 f2 00 00
[  169.011601] ==================================================================

--------------DA343ACE399DD6B3F778E680
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------DA343ACE399DD6B3F778E680--
