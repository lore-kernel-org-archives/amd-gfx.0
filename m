From: Tom St Denis <tstdenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: new KASAN running piglit
Date: Wed, 18 Jul 2018 12:09:30 -0400
Message-ID: <94969afa-5d7c-b1c5-cee5-28df3d2c7226@amd.com>
References: <2600416c-1f85-0d9d-06ad-a3d12e1fde70@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------7275574BAC90F9F72C938FFD"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <2600416c-1f85-0d9d-06ad-a3d12e1fde70-5C7GfCeVMHo@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

--------------7275574BAC90F9F72C938FFD
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Here's the dmesg I should have attached ...

Tom

On 07/18/2018 12:05 PM, Tom St Denis wrote:
> Hi Christian,
> 
> This patch:
> 
> [root@raven linux]# git bisect bad
> 90f362bdf0d0d06a126a5fd35b084436dd8250ad is the first bad commit
> commit 90f362bdf0d0d06a126a5fd35b084436dd8250ad
> Author: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> Date:   Mon Jul 16 14:58:48 2018 +0200
> 
>      drm/amdgpu: change ring priority after pushing the job
> 
>      Pushing a job can change the ring assignment of an entity.
> 
>      Signed-off-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>      Reviewed-by: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
> 
> :040000 040000 9a09d3e9d055e4f5024019861c334ee9cc0bd11b 
> 522540c31c3d1a4f4a6fbac75e985e9a7f7e93c9 M      drivers
> 
> causes a KASAN while running piglit.  It's reproduceable 100% of the 
> time.  The commit before this doesn't not cause a KASAN.
> 
> Tom

--------------7275574BAC90F9F72C938FFD
Content-Type: text/x-log;
 name="raven.dmesg.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="raven.dmesg.log"

[    0.000000] Linux version 4.18.0-rc1+ (root@raven) (gcc version 8.1.1 20180502 (Red Hat 8.1.1-1) (GCC)) #9 SMP Wed Jul 18 09:23:07 EDT 2018
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
[    0.000000] BIOS-e820: [mem 0x000000000b020000-0x0000000076462fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000076463000-0x000000007647bfff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000007647c000-0x000000007a5bdfff] usable
[    0.000000] BIOS-e820: [mem 0x000000007a5be000-0x000000007a6d5fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007a6d6000-0x000000007a6e1fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000007a6e2000-0x000000007a7e4fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007a7e5000-0x000000007ab9cfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000007ab9d000-0x000000007b942fff] reserved
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
[    0.000000] Using GB pages for direct mapping
[    0.000000] BRK [0x12e7a2000, 0x12e7a2fff] PGTABLE
[    0.000000] BRK [0x12e7a3000, 0x12e7a3fff] PGTABLE
[    0.000000] BRK [0x12e7a4000, 0x12e7a4fff] PGTABLE
[    0.000000] BRK [0x12e7a5000, 0x12e7a5fff] PGTABLE
[    0.000000] BRK [0x12e7a6000, 0x12e7a6fff] PGTABLE
[    0.000000] BRK [0x12e7a7000, 0x12e7a7fff] PGTABLE
[    0.000000] BRK [0x12e7a8000, 0x12e7a8fff] PGTABLE
[    0.000000] BRK [0x12e7a9000, 0x12e7a9fff] PGTABLE
[    0.000000] BRK [0x12e7aa000, 0x12e7aafff] PGTABLE
[    0.000000] BRK [0x12e7ab000, 0x12e7abfff] PGTABLE
[    0.000000] BRK [0x12e7ac000, 0x12e7acfff] PGTABLE
[    0.000000] BRK [0x12e7ad000, 0x12e7adfff] PGTABLE
[    0.000000] RAMDISK: [mem 0x34c83000-0x36639fff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F05B0 000024 (v02 ALASKA)
[    0.000000] ACPI: XSDT 0x00000000764630A0 0000BC (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FACP 0x000000007646D9C8 000114 (v06 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI BIOS Warning (bug): Optional FADT field Pm2ControlBlock has valid Length but zero Address: 0x0000000000000000/0x1 (20180531/tbfadt-624)
[    0.000000] ACPI: DSDT 0x00000000764631F8 00A7C9 (v02 ALASKA A M I    01072009 INTL 20120913)
[    0.000000] ACPI: FACS 0x000000007AB86E00 000040
[    0.000000] ACPI: APIC 0x000000007646DAE0 0000DE (v03 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FPDT 0x000000007646DBC0 000044 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FIDT 0x000000007646DC08 00009C (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: SSDT 0x000000007647A510 001A41 (v01 AMD    AmdTable 00000001 INTL 20120913)
[    0.000000] ACPI: SSDT 0x000000007646DD00 005367 (v02 AMD    AmdTable 00000002 MSFT 02000002)
[    0.000000] ACPI: SSDT 0x0000000076473068 00119C (v01 AMD    AMD CPU  00000001 AMD  00000001)
[    0.000000] ACPI: CRAT 0x0000000076474208 000810 (v01 AMD    AMD CRAT 00000001 AMD  00000001)
[    0.000000] ACPI: CDIT 0x0000000076474A18 000029 (v01 AMD    AMD CDIT 00000001 AMD  00000001)
[    0.000000] ACPI: SSDT 0x0000000076474A48 002DA8 (v01 AMD    AMD AOD  00000001 INTL 20120913)
[    0.000000] ACPI: MCFG 0x00000000764777F0 00003C (v01 ALASKA A M I    01072009 MSFT 00010013)
[    0.000000] ACPI: HPET 0x0000000076477830 000038 (v01 ALASKA A M I    01072009 AMI  00000005)
[    0.000000] ACPI: UEFI 0x0000000076477868 000042 (v01                 00000000      00000000)
[    0.000000] ACPI: IVRS 0x00000000764778B0 0000D0 (v02 AMD    AMD IVRS 00000001 AMD  00000000)
[    0.000000] ACPI: SSDT 0x0000000076477980 0000F8 (v01 AMD    AMD PT   00001000 INTL 20120913)
[    0.000000] ACPI: SSDT 0x0000000076477A78 000E96 (v01 AMD    AmdTable 00000001 INTL 20120913)
[    0.000000] ACPI: SSDT 0x0000000076478910 000850 (v01 AMD    AmdTable 00000001 INTL 20120913)
[    0.000000] ACPI: SSDT 0x0000000076479160 000B5E (v01 AMD    AmdTable 00000001 INTL 20120913)
[    0.000000] ACPI: SSDT 0x0000000076479CC0 000850 (v01 AMD    AmdTable 00000001 INTL 20120913)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000023f33ffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x23f33c000-0x23f33ffff]
[    0.000000] tsc: Using PIT calibration value
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
[    0.000000]   node   0: [mem 0x000000000b020000-0x0000000076462fff]
[    0.000000]   node   0: [mem 0x000000007647c000-0x000000007a5bdfff]
[    0.000000]   node   0: [mem 0x000000007a6e2000-0x000000007a7e4fff]
[    0.000000]   node   0: [mem 0x000000007b943000-0x000000007dffffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000023f33ffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000023f33ffff]
[    0.000000] On node 0 totalpages: 1817623
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 21 pages reserved
[    0.000000]   DMA zone: 3996 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 7909 pages used for memmap
[    0.000000]   DMA32 zone: 506171 pages, LIFO batch:31
[    0.000000]   Normal zone: 20429 pages used for memmap
[    0.000000]   Normal zone: 1307456 pages, LIFO batch:31
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
[    0.000000] PM: Registered nosave memory: [mem 0x76463000-0x7647bfff]
[    0.000000] PM: Registered nosave memory: [mem 0x7a5be000-0x7a6d5fff]
[    0.000000] PM: Registered nosave memory: [mem 0x7a6d6000-0x7a6e1fff]
[    0.000000] PM: Registered nosave memory: [mem 0x7a7e5000-0x7ab9cfff]
[    0.000000] PM: Registered nosave memory: [mem 0x7ab9d000-0x7b942fff]
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
[    0.000000] WARNING: WARNING: Bad or missing .orc_unwind table.  Disabling unwinder.
[    0.000000] random: get_random_bytes called from start_kernel+0xe0/0x5d6 with crng_init=0
[    0.000000] setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:16 nr_node_ids:1
[    0.000000] percpu: Embedded 52 pages/cpu @(____ptrval____) s175448 r8192 d29352 u262144
[    0.000000] pcpu-alloc: s175448 r8192 d29352 u262144 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 12 13 14 15 
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 1789200
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-4.18.0-rc1+ root=UUID=66163c80-0ca1-4beb-aeba-5cc130b813e6 ro rhgb quiet modprobe.blacklist=amdgpu,radeon LANG=en_CA.UTF-8
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Memory: 6094576K/7270492K available (22540K kernel code, 4878K rwdata, 6268K rodata, 1592K init, 9056K bss, 1175916K reserved, 0K cma-reserved)
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
[    0.007000] tsc: Detected 3594.056 MHz processor
[    0.007000] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x33ce64bf069, max_idle_ns: 440795383737 ns
[    0.007000] Calibrating delay loop (skipped), value calculated using timer frequency.. 7188.11 BogoMIPS (lpj=3594056)
[    0.007000] pid_max: default: 32768 minimum: 301
[    0.007000] Security Framework initialized
[    0.007000] SELinux:  Initializing.
[    0.007000] SELinux:  Starting in permissive mode
[    0.008694] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.009476] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.009517] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.009540] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.009823] CPU: Physical Processor ID: 0
[    0.009824] CPU: Processor Core ID: 0
[    0.009931] mce: CPU supports 23 MCE banks
[    0.009950] LVT offset 1 assigned for vector 0xf9
[    0.010011] LVT offset 2 assigned for vector 0xf4
[    0.010021] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 512
[    0.010022] Last level dTLB entries: 4KB 1536, 2MB 1536, 4MB 768, 1GB 0
[    0.010025] Spectre V2 : Mitigation: Full AMD retpoline
[    0.010026] Spectre V2 : Spectre v2 mitigation: Enabling Indirect Branch Prediction Barrier
[    0.010028] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
[    0.020936] Freeing SMP alternatives memory: 36K
[    0.022000] smpboot: CPU0: AMD Ryzen 5 2400G with Radeon Vega Graphics (family: 0x17, model: 0x11, stepping: 0x0)
[    0.022000] Performance Events: Fam17h core perfctr, AMD PMU driver.
[    0.022000] ... version:                0
[    0.022000] ... bit width:              48
[    0.022000] ... generic registers:      6
[    0.022000] ... value mask:             0000ffffffffffff
[    0.022000] ... max period:             00007fffffffffff
[    0.022000] ... fixed-purpose events:   0
[    0.022000] ... event mask:             000000000000003f
[    0.022000] Hierarchical SRCU implementation.
[    0.023488] MCE: In-kernel MCE decoding enabled.
[    0.023919] smp: Bringing up secondary CPUs ...
[    0.024163] x86: Booting SMP configuration:
[    0.024164] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7
[    0.035004] smp: Brought up 1 node, 8 CPUs
[    0.035005] smpboot: Max logical packages: 2
[    0.035007] smpboot: Total of 8 processors activated (57504.89 BogoMIPS)
[    0.037004] devtmpfs: initialized
[    0.039042] PM: Registering ACPI NVS region [mem 0x04000000-0x04009fff] (40960 bytes)
[    0.039046] PM: Registering ACPI NVS region [mem 0x7a7e5000-0x7ab9cfff] (3899392 bytes)
[    0.039422] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.039462] futex hash table entries: 4096 (order: 6, 262144 bytes)
[    0.039392] kworker/u32:0 (52) used greatest stack depth: 23576 bytes left
[    0.040264] RTC time: 16:07:01, date: 07/18/18
[    0.042130] NET: Registered protocol family 16
[    0.042354] audit: initializing netlink subsys (disabled)
[    0.042367] audit: type=2000 audit(1531930021.042:1): state=initialized audit_enabled=0 res=1
[    0.042367] cpuidle: using governor menu
[    0.043115] ACPI: bus type PCI registered
[    0.043242] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.043247] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
[    0.043261] PCI: Using configuration type 1 for base access
[    0.043148] kworker/u32:2 (70) used greatest stack depth: 22088 bytes left
[    0.043541] mtrr: your CPUs had inconsistent variable MTRR settings
[    0.043542] mtrr: probably your BIOS does not setup all CPUs.
[    0.043543] mtrr: corrected configuration.
[    0.045152] kworker/u32:2 (124) used greatest stack depth: 21624 bytes left
[    0.050251] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.051048] ACPI: Added _OSI(Module Device)
[    0.051048] ACPI: Added _OSI(Processor Device)
[    0.051048] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.051048] ACPI: Added _OSI(Processor Aggregator Device)
[    0.051048] ACPI: Added _OSI(Linux-Dell-Video)
[    0.071952] 
               3ACPI BIOS Error (bug): Failure creating [\_SB.SMIC], AE_ALREADY_EXISTS (20180531/dswload2-316)
[    0.071961] ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20180531/psobject-221)
[    0.072003] ACPI Error: Ignore error and continue table load (20180531/psobject-604)
[    0.072183] 
               3ACPI BIOS Error (bug): Failure creating [\_SB.SMIB], AE_ALREADY_EXISTS (20180531/dsfield-594)
[    0.073349] 
               3ACPI BIOS Error (bug): Failure creating [\_SB.MACO], AE_ALREADY_EXISTS (20180531/dswload2-316)
[    0.073355] ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20180531/psobject-221)
[    0.073563] ACPI Error: Ignore error and continue table load (20180531/psobject-604)
[    0.073867] ACPI: 10 ACPI AML tables successfully acquired and loaded
[    0.077755] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.086328] ACPI: Interpreter enabled
[    0.086361] ACPI: (supports S0 S3 S4 S5)
[    0.086363] ACPI: Using IOAPIC for interrupt routing
[    0.087016] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.087551] ACPI: Enabled 3 GPEs in block 00 to 1F
[    0.093911] ACPI: Power Resource [P0ST] (on)
[    0.093911] ACPI: Power Resource [P3ST] (on)
[    0.108727] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.108736] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.109145] acpi PNP0A08:00: _OSC: platform does not support [PME LTR]
[    0.109537] acpi PNP0A08:00: _OSC: OS now controls [AER PCIeCapability]
[    0.109558] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000 [bus 00-3f] only partially covers this bridge
[    0.110025] PCI host bridge to bus 0000:00
[    0.110028] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    0.110030] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    0.110033] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
[    0.110035] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.110037] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.110039] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff window]
[    0.110042] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfec2ffff window]
[    0.110044] pci_bus 0000:00: root bus resource [mem 0xfee00000-0xffffffff window]
[    0.110046] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.110059] pci 0000:00:00.0: [1022:15d0] type 00 class 0x060000
[    0.110270] pci 0000:00:00.2: [1022:15d1] type 00 class 0x080600
[    0.110498] pci 0000:00:01.0: [1022:1452] type 00 class 0x060000
[    0.110680] pci 0000:00:01.1: [1022:15d3] type 01 class 0x060400
[    0.110793] pci 0000:00:01.1: PME# supported from D0 D3hot D3cold
[    0.111034] pci 0000:00:01.2: [1022:15d3] type 01 class 0x060400
[    0.111081] pci 0000:00:01.2: PME# supported from D0 D3hot D3cold
[    0.111271] pci 0000:00:08.0: [1022:1452] type 00 class 0x060000
[    0.111453] pci 0000:00:08.1: [1022:15db] type 01 class 0x060400
[    0.111508] pci 0000:00:08.1: enabling Extended Tags
[    0.111570] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
[    0.111737] pci 0000:00:08.2: [1022:15dc] type 01 class 0x060400
[    0.111791] pci 0000:00:08.2: enabling Extended Tags
[    0.111849] pci 0000:00:08.2: PME# supported from D0 D3hot D3cold
[    0.112039] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500
[    0.112312] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100
[    0.112586] pci 0000:00:18.0: [1022:15e8] type 00 class 0x060000
[    0.112702] pci 0000:00:18.1: [1022:15e9] type 00 class 0x060000
[    0.113028] pci 0000:00:18.2: [1022:15ea] type 00 class 0x060000
[    0.113034] pci 0000:00:18.3: [1022:15eb] type 00 class 0x060000
[    0.113045] pci 0000:00:18.4: [1022:15ec] type 00 class 0x060000
[    0.113158] pci 0000:00:18.5: [1022:15ed] type 00 class 0x060000
[    0.113269] pci 0000:00:18.6: [1022:15ee] type 00 class 0x060000
[    0.113383] pci 0000:00:18.7: [1022:15ef] type 00 class 0x060000
[    0.113591] pci 0000:01:00.0: [1002:67c4] type 00 class 0x030000
[    0.113639] pci 0000:01:00.0: reg 0x10: [mem 0xe0000000-0xefffffff 64bit pref]
[    0.113654] pci 0000:01:00.0: reg 0x18: [mem 0xf0000000-0xf01fffff 64bit pref]
[    0.113664] pci 0000:01:00.0: reg 0x20: [io  0xf000-0xf0ff]
[    0.113674] pci 0000:01:00.0: reg 0x24: [mem 0xfe900000-0xfe93ffff]
[    0.113683] pci 0000:01:00.0: reg 0x30: [mem 0xfe940000-0xfe95ffff pref]
[    0.113800] pci 0000:01:00.0: supports D1 D2
[    0.113802] pci 0000:01:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.114001] pci 0000:01:00.1: [1002:aaf0] type 00 class 0x040300
[    0.114017] pci 0000:01:00.1: reg 0x10: [mem 0xfe960000-0xfe963fff 64bit]
[    0.114157] pci 0000:01:00.1: supports D1 D2
[    0.114355] pci 0000:00:01.1: PCI bridge to [bus 01]
[    0.114361] pci 0000:00:01.1:   bridge window [io  0xf000-0xffff]
[    0.114365] pci 0000:00:01.1:   bridge window [mem 0xfe900000-0xfe9fffff]
[    0.114371] pci 0000:00:01.1:   bridge window [mem 0xe0000000-0xf01fffff 64bit pref]
[    0.114446] pci 0000:02:00.0: [1022:43bb] type 00 class 0x0c0330
[    0.114478] pci 0000:02:00.0: reg 0x10: [mem 0xfe7a0000-0xfe7a7fff 64bit]
[    0.114592] pci 0000:02:00.0: PME# supported from D3hot D3cold
[    0.114719] pci 0000:02:00.1: [1022:43b7] type 00 class 0x010601
[    0.114785] pci 0000:02:00.1: reg 0x24: [mem 0xfe780000-0xfe79ffff]
[    0.114796] pci 0000:02:00.1: reg 0x30: [mem 0xfe700000-0xfe77ffff pref]
[    0.114856] pci 0000:02:00.1: PME# supported from D3hot D3cold
[    0.115020] pci 0000:02:00.2: [1022:43b2] type 01 class 0x060400
[    0.115082] pci 0000:02:00.2: PME# supported from D3hot D3cold
[    0.115253] pci 0000:00:01.2: PCI bridge to [bus 02-06]
[    0.115259] pci 0000:00:01.2:   bridge window [io  0xe000-0xefff]
[    0.115263] pci 0000:00:01.2:   bridge window [mem 0xfe600000-0xfe7fffff]
[    0.115338] pci 0000:03:00.0: [1022:43b4] type 01 class 0x060400
[    0.115465] pci 0000:03:00.0: PME# supported from D3hot D3cold
[    0.115609] pci 0000:03:01.0: [1022:43b4] type 01 class 0x060400
[    0.115736] pci 0000:03:01.0: PME# supported from D3hot D3cold
[    0.116032] pci 0000:03:04.0: [1022:43b4] type 01 class 0x060400
[    0.116032] pci 0000:03:04.0: PME# supported from D3hot D3cold
[    0.116170] pci 0000:02:00.2: PCI bridge to [bus 03-06]
[    0.116177] pci 0000:02:00.2:   bridge window [io  0xe000-0xefff]
[    0.116181] pci 0000:02:00.2:   bridge window [mem 0xfe600000-0xfe6fffff]
[    0.116268] pci 0000:04:00.0: [10ec:8168] type 00 class 0x020000
[    0.116319] pci 0000:04:00.0: reg 0x10: [io  0xe000-0xe0ff]
[    0.116362] pci 0000:04:00.0: reg 0x18: [mem 0xfe604000-0xfe604fff 64bit]
[    0.116389] pci 0000:04:00.0: reg 0x20: [mem 0xfe600000-0xfe603fff 64bit]
[    0.116551] pci 0000:04:00.0: supports D1 D2
[    0.116553] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.116772] pci 0000:03:00.0: PCI bridge to [bus 04]
[    0.116780] pci 0000:03:00.0:   bridge window [io  0xe000-0xefff]
[    0.116784] pci 0000:03:00.0:   bridge window [mem 0xfe600000-0xfe6fffff]
[    0.117027] pci 0000:03:01.0: PCI bridge to [bus 05]
[    0.117030] pci 0000:03:04.0: PCI bridge to [bus 06]
[    0.117046] pci 0000:07:00.0: [1002:15dd] type 00 class 0x030000
[    0.117095] pci 0000:07:00.0: reg 0x10: [mem 0xc0000000-0xcfffffff 64bit pref]
[    0.117115] pci 0000:07:00.0: reg 0x18: [mem 0xd0000000-0xd01fffff 64bit pref]
[    0.117128] pci 0000:07:00.0: reg 0x20: [io  0xd000-0xd0ff]
[    0.117142] pci 0000:07:00.0: reg 0x24: [mem 0xfe500000-0xfe57ffff]
[    0.117163] pci 0000:07:00.0: enabling Extended Tags
[    0.117275] pci 0000:07:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.117430] pci 0000:07:00.1: [1002:15de] type 00 class 0x040300
[    0.117462] pci 0000:07:00.1: reg 0x10: [mem 0xfe588000-0xfe58bfff]
[    0.117535] pci 0000:07:00.1: enabling Extended Tags
[    0.117612] pci 0000:07:00.1: PME# supported from D1 D2 D3hot D3cold
[    0.117743] pci 0000:07:00.2: [1022:15df] type 00 class 0x108000
[    0.117796] pci 0000:07:00.2: reg 0x18: [mem 0xfe400000-0xfe4fffff]
[    0.117830] pci 0000:07:00.2: reg 0x24: [mem 0xfe58c000-0xfe58dfff]
[    0.117851] pci 0000:07:00.2: enabling Extended Tags
[    0.118063] pci 0000:07:00.3: [1022:15e0] type 00 class 0x0c0330
[    0.118101] pci 0000:07:00.3: reg 0x10: [mem 0xfe300000-0xfe3fffff 64bit]
[    0.118164] pci 0000:07:00.3: enabling Extended Tags
[    0.118246] pci 0000:07:00.3: PME# supported from D0 D3hot D3cold
[    0.118387] pci 0000:07:00.4: [1022:15e1] type 00 class 0x0c0330
[    0.118425] pci 0000:07:00.4: reg 0x10: [mem 0xfe200000-0xfe2fffff 64bit]
[    0.118488] pci 0000:07:00.4: enabling Extended Tags
[    0.118571] pci 0000:07:00.4: PME# supported from D0 D3hot D3cold
[    0.118716] pci 0000:07:00.6: [1022:15e3] type 00 class 0x040300
[    0.118748] pci 0000:07:00.6: reg 0x10: [mem 0xfe580000-0xfe587fff]
[    0.118821] pci 0000:07:00.6: enabling Extended Tags
[    0.118895] pci 0000:07:00.6: PME# supported from D0 D3hot D3cold
[    0.119103] pci 0000:00:08.1: PCI bridge to [bus 07]
[    0.119110] pci 0000:00:08.1:   bridge window [io  0xd000-0xdfff]
[    0.119114] pci 0000:00:08.1:   bridge window [mem 0xfe200000-0xfe5fffff]
[    0.119121] pci 0000:00:08.1:   bridge window [mem 0xc0000000-0xd01fffff 64bit pref]
[    0.119203] pci 0000:08:00.0: [1022:7901] type 00 class 0x010601
[    0.119289] pci 0000:08:00.0: reg 0x24: [mem 0xfe800000-0xfe8007ff]
[    0.119310] pci 0000:08:00.0: enabling Extended Tags
[    0.119393] pci 0000:08:00.0: PME# supported from D3hot D3cold
[    0.119556] pci 0000:00:08.2: PCI bridge to [bus 08]
[    0.119565] pci 0000:00:08.2:   bridge window [mem 0xfe800000-0xfe8fffff]
[    0.120590] ACPI: PCI Interrupt Link [LNKA] (IRQs 4 5 7 10 11 14 15) *0
[    0.120717] ACPI: PCI Interrupt Link [LNKB] (IRQs 4 5 7 10 11 14 15) *0
[    0.120832] ACPI: PCI Interrupt Link [LNKC] (IRQs 4 5 7 10 11 14 15) *0
[    0.120964] ACPI: PCI Interrupt Link [LNKD] (IRQs 4 5 7 10 11 14 15) *0
[    0.121086] ACPI: PCI Interrupt Link [LNKE] (IRQs 4 5 7 10 11 14 15) *0
[    0.121195] ACPI: PCI Interrupt Link [LNKF] (IRQs 4 5 7 10 11 14 15) *0
[    0.121301] ACPI: PCI Interrupt Link [LNKG] (IRQs 4 5 7 10 11 14 15) *0
[    0.121401] ACPI: PCI Interrupt Link [LNKH] (IRQs 4 5 7 10 11 14 15) *0
[    0.122518] pci 0000:01:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
[    0.122518] pci 0000:07:00.0: vgaarb: setting as boot VGA device
[    0.122518] pci 0000:07:00.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.122518] pci 0000:07:00.0: vgaarb: bridge control possible
[    0.122518] pci 0000:01:00.0: vgaarb: bridge control possible
[    0.122518] vgaarb: loaded
[    0.123034] SCSI subsystem initialized
[    0.123058] libata version 3.00 loaded.
[    0.123109] ACPI: bus type USB registered
[    0.123109] usbcore: registered new interface driver usbfs
[    0.123109] usbcore: registered new interface driver hub
[    0.123165] usbcore: registered new device driver usb
[    0.123213] pps_core: LinuxPPS API ver. 1 registered
[    0.123215] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
[    0.123224] PTP clock support registered
[    0.123286] EDAC MC: Ver: 3.0.0
[    0.124034] Advanced Linux Sound Architecture Driver Initialized.
[    0.124042] PCI: Using ACPI for IRQ routing
[    0.126151] PCI: pci_cache_line_size set to 64 bytes
[    0.126254] e820: reserve RAM buffer [mem 0x0009d400-0x0009ffff]
[    0.126256] e820: reserve RAM buffer [mem 0x09c00000-0x0bffffff]
[    0.126258] e820: reserve RAM buffer [mem 0x0b000000-0x0bffffff]
[    0.126260] e820: reserve RAM buffer [mem 0x76463000-0x77ffffff]
[    0.126261] e820: reserve RAM buffer [mem 0x7a5be000-0x7bffffff]
[    0.126263] e820: reserve RAM buffer [mem 0x7a7e5000-0x7bffffff]
[    0.126265] e820: reserve RAM buffer [mem 0x7e000000-0x7fffffff]
[    0.126266] e820: reserve RAM buffer [mem 0x23f340000-0x23fffffff]
[    0.127050] NetLabel: Initializing
[    0.127050] NetLabel:  domain hash size = 128
[    0.127050] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.127050] NetLabel:  unlabeled traffic allowed by default
[    0.127149] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.127153] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.129068] clocksource: Switched to clocksource tsc-early
[    0.150854] VFS: Disk quotas dquot_6.6.0
[    0.150882] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.150988] pnp: PnP ACPI init
[    0.151206] system 00:00: [mem 0xf8000000-0xfbffffff] has been reserved
[    0.151222] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.151373] system 00:01: [mem 0xfeb80000-0xfebfffff] has been reserved
[    0.151384] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.151659] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.151965] system 00:03: [io  0x0300-0x030f] has been reserved
[    0.151968] system 00:03: [io  0x0230-0x023f] has been reserved
[    0.151971] system 00:03: [io  0x0290-0x029f] has been reserved
[    0.151981] system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.152536] pnp 00:04: [dma 0 disabled]
[    0.152614] pnp 00:04: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.153076] system 00:05: [io  0x04d0-0x04d1] has been reserved
[    0.153080] system 00:05: [io  0x040b] has been reserved
[    0.153084] system 00:05: [io  0x04d6] has been reserved
[    0.153087] system 00:05: [io  0x0c00-0x0c01] has been reserved
[    0.153090] system 00:05: [io  0x0c14] has been reserved
[    0.153094] system 00:05: [io  0x0c50-0x0c51] has been reserved
[    0.153097] system 00:05: [io  0x0c52] has been reserved
[    0.153101] system 00:05: [io  0x0c6c] has been reserved
[    0.153105] system 00:05: [io  0x0c6f] has been reserved
[    0.153109] system 00:05: [io  0x0cd0-0x0cd1] has been reserved
[    0.153112] system 00:05: [io  0x0cd2-0x0cd3] has been reserved
[    0.153115] system 00:05: [io  0x0cd4-0x0cd5] has been reserved
[    0.153117] system 00:05: [io  0x0cd6-0x0cd7] has been reserved
[    0.153120] system 00:05: [io  0x0cd8-0x0cdf] has been reserved
[    0.153123] system 00:05: [io  0x0800-0x089f] has been reserved
[    0.153125] system 00:05: [io  0x0b00-0x0b0f] has been reserved
[    0.153128] system 00:05: [io  0x0b20-0x0b3f] has been reserved
[    0.153131] system 00:05: [io  0x0900-0x090f] has been reserved
[    0.153133] system 00:05: [io  0x0910-0x091f] has been reserved
[    0.153137] system 00:05: [mem 0xfec00000-0xfec00fff] could not be reserved
[    0.153140] system 00:05: [mem 0xfec01000-0xfec01fff] could not be reserved
[    0.153143] system 00:05: [mem 0xfedc0000-0xfedc0fff] has been reserved
[    0.153146] system 00:05: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.153149] system 00:05: [mem 0xfed80000-0xfed8ffff] could not be reserved
[    0.153152] system 00:05: [mem 0xfec10000-0xfec10fff] has been reserved
[    0.153155] system 00:05: [mem 0xff000000-0xffffffff] has been reserved
[    0.153167] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.154127] pnp: PnP ACPI: found 6 devices
[    0.162223] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.162304] pci 0000:00:01.1: PCI bridge to [bus 01]
[    0.162308] pci 0000:00:01.1:   bridge window [io  0xf000-0xffff]
[    0.162314] pci 0000:00:01.1:   bridge window [mem 0xfe900000-0xfe9fffff]
[    0.162319] pci 0000:00:01.1:   bridge window [mem 0xe0000000-0xf01fffff 64bit pref]
[    0.162327] pci 0000:03:00.0: PCI bridge to [bus 04]
[    0.162330] pci 0000:03:00.0:   bridge window [io  0xe000-0xefff]
[    0.162336] pci 0000:03:00.0:   bridge window [mem 0xfe600000-0xfe6fffff]
[    0.162346] pci 0000:03:01.0: PCI bridge to [bus 05]
[    0.162359] pci 0000:03:04.0: PCI bridge to [bus 06]
[    0.162373] pci 0000:02:00.2: PCI bridge to [bus 03-06]
[    0.162376] pci 0000:02:00.2:   bridge window [io  0xe000-0xefff]
[    0.162381] pci 0000:02:00.2:   bridge window [mem 0xfe600000-0xfe6fffff]
[    0.162390] pci 0000:00:01.2: PCI bridge to [bus 02-06]
[    0.162393] pci 0000:00:01.2:   bridge window [io  0xe000-0xefff]
[    0.162399] pci 0000:00:01.2:   bridge window [mem 0xfe600000-0xfe7fffff]
[    0.162410] pci 0000:00:08.1: PCI bridge to [bus 07]
[    0.162413] pci 0000:00:08.1:   bridge window [io  0xd000-0xdfff]
[    0.162418] pci 0000:00:08.1:   bridge window [mem 0xfe200000-0xfe5fffff]
[    0.162423] pci 0000:00:08.1:   bridge window [mem 0xc0000000-0xd01fffff 64bit pref]
[    0.162429] pci 0000:00:08.2: PCI bridge to [bus 08]
[    0.162435] pci 0000:00:08.2:   bridge window [mem 0xfe800000-0xfe8fffff]
[    0.162446] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    0.162448] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
[    0.162450] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
[    0.162452] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    0.162454] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff window]
[    0.162456] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff window]
[    0.162458] pci_bus 0000:00: resource 10 [mem 0xc0000000-0xfec2ffff window]
[    0.162460] pci_bus 0000:00: resource 11 [mem 0xfee00000-0xffffffff window]
[    0.162463] pci_bus 0000:01: resource 0 [io  0xf000-0xffff]
[    0.162464] pci_bus 0000:01: resource 1 [mem 0xfe900000-0xfe9fffff]
[    0.162466] pci_bus 0000:01: resource 2 [mem 0xe0000000-0xf01fffff 64bit pref]
[    0.162468] pci_bus 0000:02: resource 0 [io  0xe000-0xefff]
[    0.162470] pci_bus 0000:02: resource 1 [mem 0xfe600000-0xfe7fffff]
[    0.162472] pci_bus 0000:03: resource 0 [io  0xe000-0xefff]
[    0.162474] pci_bus 0000:03: resource 1 [mem 0xfe600000-0xfe6fffff]
[    0.162476] pci_bus 0000:04: resource 0 [io  0xe000-0xefff]
[    0.162478] pci_bus 0000:04: resource 1 [mem 0xfe600000-0xfe6fffff]
[    0.162480] pci_bus 0000:07: resource 0 [io  0xd000-0xdfff]
[    0.162482] pci_bus 0000:07: resource 1 [mem 0xfe200000-0xfe5fffff]
[    0.162484] pci_bus 0000:07: resource 2 [mem 0xc0000000-0xd01fffff 64bit pref]
[    0.162486] pci_bus 0000:08: resource 1 [mem 0xfe800000-0xfe8fffff]
[    0.162634] NET: Registered protocol family 2
[    0.162897] tcp_listen_portaddr_hash hash table entries: 4096 (order: 4, 65536 bytes)
[    0.162972] TCP established hash table entries: 65536 (order: 7, 524288 bytes)
[    0.163316] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.163587] TCP: Hash tables configured (established 65536 bind 65536)
[    0.163680] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[    0.163743] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[    0.163905] NET: Registered protocol family 1
[    0.164155] RPC: Registered named UNIX socket transport module.
[    0.164156] RPC: Registered udp transport module.
[    0.164157] RPC: Registered tcp transport module.
[    0.164158] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.164437] pci 0000:01:00.1: Linked as a consumer to 0000:01:00.0
[    0.164732] pci 0000:07:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.164743] pci 0000:07:00.1: Linked as a consumer to 0000:07:00.0
[    0.165215] PCI: CLS 64 bytes, default 64
[    0.165282] Unpacking initramfs...
[    0.831676] Freeing initrd memory: 26332K
[    1.152554] AMD-Vi: IOMMU performance counters supported
[    1.152691] pci 0000:00:00.2: can't derive routing for PCI INT A
[    1.152694] pci 0000:00:00.2: PCI INT A: not connected
[    1.153116] iommu: Adding device 0000:00:01.0 to group 0
[    1.153319] iommu: Adding device 0000:00:01.1 to group 1
[    1.153492] iommu: Adding device 0000:00:01.2 to group 2
[    1.153699] iommu: Adding device 0000:00:08.0 to group 3
[    1.153894] iommu: Adding device 0000:00:08.1 to group 4
[    1.153942] iommu: Adding device 0000:00:08.2 to group 3
[    1.154133] iommu: Adding device 0000:00:14.0 to group 5
[    1.154165] iommu: Adding device 0000:00:14.3 to group 5
[    1.154405] iommu: Adding device 0000:00:18.0 to group 6
[    1.154438] iommu: Adding device 0000:00:18.1 to group 6
[    1.154469] iommu: Adding device 0000:00:18.2 to group 6
[    1.154501] iommu: Adding device 0000:00:18.3 to group 6
[    1.154531] iommu: Adding device 0000:00:18.4 to group 6
[    1.154562] iommu: Adding device 0000:00:18.5 to group 6
[    1.154592] iommu: Adding device 0000:00:18.6 to group 6
[    1.154623] iommu: Adding device 0000:00:18.7 to group 6
[    1.154846] iommu: Adding device 0000:01:00.0 to group 7
[    1.154896] iommu: Using direct mapping for device 0000:01:00.0
[    1.154955] iommu: Adding device 0000:01:00.1 to group 7
[    1.155161] iommu: Adding device 0000:02:00.0 to group 8
[    1.155211] iommu: Adding device 0000:02:00.1 to group 8
[    1.155259] iommu: Adding device 0000:02:00.2 to group 8
[    1.155288] iommu: Adding device 0000:03:00.0 to group 8
[    1.155315] iommu: Adding device 0000:03:01.0 to group 8
[    1.155343] iommu: Adding device 0000:03:04.0 to group 8
[    1.155388] iommu: Adding device 0000:04:00.0 to group 8
[    1.155670] iommu: Adding device 0000:07:00.0 to group 9
[    1.155769] iommu: Using direct mapping for device 0000:07:00.0
[    1.155980] iommu: Adding device 0000:07:00.1 to group 10
[    1.156040] iommu: Adding device 0000:07:00.2 to group 10
[    1.156093] iommu: Adding device 0000:07:00.3 to group 10
[    1.156146] iommu: Adding device 0000:07:00.4 to group 10
[    1.156198] iommu: Adding device 0000:07:00.6 to group 10
[    1.156229] iommu: Adding device 0000:08:00.0 to group 3
[    1.156572] AMD-Vi: Found IOMMU at 0000:00:00.2 cap 0x40
[    1.156573] AMD-Vi: Extended features (0x4f77ef22294ada):
[    1.156573]  PPR NX GT IA GA PC GA_vAPIC
[    1.156788] AMD-Vi: Lazy IO/TLB flushing enabled
[    1.161288] amd_uncore: AMD NB counters detected
[    1.161297] amd_uncore: AMD LLC counters detected
[    1.161716] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 counters/bank).
[    1.164141] Scanning for low memory corruption every 60 seconds
[    1.166138] Initialise system trusted keyrings
[    1.166277] workingset: timestamp_bits=56 max_order=21 bucket_order=0
[    1.174549] NFS: Registering the id_resolver key type
[    1.174599] Key type id_resolver registered
[    1.174600] Key type id_legacy registered
[    1.174851] SELinux:  Registering netfilter hooks
[    1.176562] jitterentropy: Initialization failed with host not compliant with requirements: 2
[    1.176605] Key type asymmetric registered
[    1.176606] Asymmetric key parser 'x509' registered
[    1.176662] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
[    1.176664] io scheduler noop registered
[    1.176665] io scheduler deadline registered
[    1.176751] io scheduler cfq registered (default)
[    1.176752] io scheduler mq-deadline registered
[    1.176753] io scheduler kyber registered
[    1.178479] pcieport 0000:00:01.1: AER enabled with IRQ 26
[    1.178541] pcieport 0000:00:01.2: AER enabled with IRQ 27
[    1.178786] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    1.178800] ACPI: Power Button [PWRB]
[    1.178868] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    1.178890] ACPI: Power Button [PWRF]
[    1.179039] ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
[    1.179374] acpi device:03: registered as cooling_device0
[    1.179450] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:02/LNXVIDEO:00/input/input2
[    1.179525] Monitor-Mwait will be used to enter C-1 state
[    1.181105] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.202074] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    1.202633] kworker/u32:4 (1120) used greatest stack depth: 19936 bytes left
[    1.202894] Non-volatile memory driver v1.3
[    1.202948] Linux agpgart interface v0.103
[    1.210530] loop: module loaded
[    1.210770] ahci 0000:02:00.1: version 3.0
[    1.210987] ahci 0000:02:00.1: SSS flag set, parallel bus scan disabled
[    1.211058] ahci 0000:02:00.1: AHCI 0001.0301 32 slots 8 ports 6 Gbps 0x33 impl SATA mode
[    1.211063] ahci 0000:02:00.1: flags: 64bit ncq sntf stag pm led clo only pmp pio slum part sxs deso sadm sds apst 
[    1.212235] scsi host0: ahci
[    1.212473] scsi host1: ahci
[    1.212707] scsi host2: ahci
[    1.212926] scsi host3: ahci
[    1.213165] scsi host4: ahci
[    1.213359] scsi host5: ahci
[    1.213573] scsi host6: ahci
[    1.213793] scsi host7: ahci
[    1.213894] ata1: SATA max UDMA/133 abar m131072@0xfe780000 port 0xfe780100 irq 35
[    1.213898] ata2: SATA max UDMA/133 abar m131072@0xfe780000 port 0xfe780180 irq 35
[    1.213900] ata3: DUMMY
[    1.213902] ata4: DUMMY
[    1.213905] ata5: SATA max UDMA/133 abar m131072@0xfe780000 port 0xfe780300 irq 35
[    1.213909] ata6: SATA max UDMA/133 abar m131072@0xfe780000 port 0xfe780380 irq 35
[    1.213910] ata7: DUMMY
[    1.213912] ata8: DUMMY
[    1.214268] ahci 0000:08:00.0: AHCI 0001.0301 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
[    1.214272] ahci 0000:08:00.0: flags: 64bit ncq sntf ilck pm led clo only pmp fbs pio slum part 
[    1.214573] scsi host8: ahci
[    1.214655] ata9: SATA max UDMA/133 abar m2048@0xfe800000 port 0xfe800100 irq 37
[    1.214864] e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2-NAPI
[    1.214866] e100: Copyright(c) 1999-2006 Intel Corporation
[    1.214900] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
[    1.214901] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    1.214934] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    1.214935] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    1.214980] sky2: driver version 1.30
[    1.215087] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[    1.220294] r8169 0000:04:00.0 eth0: RTL8168h/8111h, b0:6e:bf:2f:47:8d, XID 54100800, IRQ 38
[    1.220297] r8169 0000:04:00.0 eth0: jumbo features [frames: 9200 bytes, tx checksumming: ko]
[    1.220483] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.220484] ehci-pci: EHCI PCI platform driver
[    1.220525] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.220533] ohci-pci: OHCI PCI platform driver
[    1.220565] uhci_hcd: USB Universal Host Controller Interface driver
[    1.220810] xhci_hcd 0000:02:00.0: xHCI Host Controller
[    1.220907] xhci_hcd 0000:02:00.0: new USB bus registered, assigned bus number 1
[    1.276290] xhci_hcd 0000:02:00.0: hcc params 0x0200ef81 hci version 0x110 quirks 0x0000000048000410
[    1.276607] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.18
[    1.276609] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.276611] usb usb1: Product: xHCI Host Controller
[    1.276612] usb usb1: Manufacturer: Linux 4.18.0-rc1+ xhci-hcd
[    1.276614] usb usb1: SerialNumber: 0000:02:00.0
[    1.276799] hub 1-0:1.0: USB hub found
[    1.276822] hub 1-0:1.0: 10 ports detected
[    1.288860] xhci_hcd 0000:02:00.0: xHCI Host Controller
[    1.288933] xhci_hcd 0000:02:00.0: new USB bus registered, assigned bus number 2
[    1.288938] xhci_hcd 0000:02:00.0: Host supports USB 3.10 Enhanced SuperSpeed
[    1.288980] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[    1.289039] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 4.18
[    1.289041] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.289043] usb usb2: Product: xHCI Host Controller
[    1.289044] usb usb2: Manufacturer: Linux 4.18.0-rc1+ xhci-hcd
[    1.289046] usb usb2: SerialNumber: 0000:02:00.0
[    1.289236] hub 2-0:1.0: USB hub found
[    1.289252] hub 2-0:1.0: 4 ports detected
[    1.294495] xhci_hcd 0000:07:00.3: xHCI Host Controller
[    1.294565] xhci_hcd 0000:07:00.3: new USB bus registered, assigned bus number 3
[    1.294787] xhci_hcd 0000:07:00.3: hcc params 0x0270ffe5 hci version 0x110 quirks 0x0000000040000410
[    1.295370] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.18
[    1.295372] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.295374] usb usb3: Product: xHCI Host Controller
[    1.295376] usb usb3: Manufacturer: Linux 4.18.0-rc1+ xhci-hcd
[    1.295377] usb usb3: SerialNumber: 0000:07:00.3
[    1.295562] hub 3-0:1.0: USB hub found
[    1.295586] hub 3-0:1.0: 4 ports detected
[    1.296141] xhci_hcd 0000:07:00.3: xHCI Host Controller
[    1.296204] xhci_hcd 0000:07:00.3: new USB bus registered, assigned bus number 4
[    1.296209] xhci_hcd 0000:07:00.3: Host supports USB 3.10 Enhanced SuperSpeed
[    1.296289] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
[    1.296333] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 4.18
[    1.296335] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.296337] usb usb4: Product: xHCI Host Controller
[    1.296338] usb usb4: Manufacturer: Linux 4.18.0-rc1+ xhci-hcd
[    1.296340] usb usb4: SerialNumber: 0000:07:00.3
[    1.296522] hub 4-0:1.0: USB hub found
[    1.296545] hub 4-0:1.0: 4 ports detected
[    1.297215] xhci_hcd 0000:07:00.4: xHCI Host Controller
[    1.297280] xhci_hcd 0000:07:00.4: new USB bus registered, assigned bus number 5
[    1.297467] xhci_hcd 0000:07:00.4: hcc params 0x0260ffe5 hci version 0x110 quirks 0x0000000040000410
[    1.297966] usb usb5: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.18
[    1.297968] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.297970] usb usb5: Product: xHCI Host Controller
[    1.297971] usb usb5: Manufacturer: Linux 4.18.0-rc1+ xhci-hcd
[    1.297973] usb usb5: SerialNumber: 0000:07:00.4
[    1.298145] hub 5-0:1.0: USB hub found
[    1.298162] hub 5-0:1.0: 1 port detected
[    1.298330] xhci_hcd 0000:07:00.4: xHCI Host Controller
[    1.298384] xhci_hcd 0000:07:00.4: new USB bus registered, assigned bus number 6
[    1.298389] xhci_hcd 0000:07:00.4: Host supports USB 3.10 Enhanced SuperSpeed
[    1.298431] usb usb6: We don't know the algorithms for LPM for this host, disabling LPM.
[    1.298472] usb usb6: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 4.18
[    1.298474] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.298475] usb usb6: Product: xHCI Host Controller
[    1.298477] usb usb6: Manufacturer: Linux 4.18.0-rc1+ xhci-hcd
[    1.298478] usb usb6: SerialNumber: 0000:07:00.4
[    1.298646] hub 6-0:1.0: USB hub found
[    1.298662] hub 6-0:1.0: 1 port detected
[    1.298847] usbcore: registered new interface driver usblp
[    1.298893] usbcore: registered new interface driver usb-storage
[    1.298935] i8042: PNP: No PS/2 controller found.
[    1.299245] rtc_cmos 00:02: RTC can wake from S4
[    1.299533] rtc_cmos 00:02: registered as rtc0
[    1.299563] rtc_cmos 00:02: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    1.299871] device-mapper: ioctl: 4.39.0-ioctl (2018-04-03) initialised: dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
[    1.299902] hidraw: raw HID events driver (C) Jiri Kosina
[    1.300316] usbcore: registered new interface driver usbhid
[    1.300317] usbhid: USB HID core driver
[    1.300757] snd_hda_intel 0000:01:00.1: Force to non-snoop mode
[    1.302093] Initializing XFRM netlink socket
[    1.302380] NET: Registered protocol family 10
[    1.303107] Segment Routing with IPv6
[    1.303395] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    1.303719] NET: Registered protocol family 17
[    1.303782] Key type dns_resolver registered
[    1.304201] hdaudio hdaudioC0D0: Unable to bind the codec
[    1.305321] hdaudio hdaudioC1D0: Unable to bind the codec
[    1.306755] microcode: CPU0: patch_level=0x0810100b
[    1.306763] microcode: CPU1: patch_level=0x0810100b
[    1.306771] microcode: CPU2: patch_level=0x0810100b
[    1.306778] microcode: CPU3: patch_level=0x0810100b
[    1.306788] microcode: CPU4: patch_level=0x0810100b
[    1.306797] microcode: CPU5: patch_level=0x0810100b
[    1.306807] microcode: CPU6: patch_level=0x0810100b
[    1.306814] microcode: CPU7: patch_level=0x0810100b
[    1.306884] microcode: Microcode Update Driver: v2.2.
[    1.306920] sched_clock: Marking stable (1306870344, 0)->(1425396947, -118526603)
[    1.307278] registered taskstats version 1
[    1.307280] Loading compiled-in X.509 certificates
[    1.307342] Unable to create integrity sysfs dir: -19
[    1.308397]   Magic number: 10:121:136
[    1.308400]   hash matches drivers/base/power/main.c:1548
[    1.308410] usb usb4-port1: hash matches
[    1.308449] misc autofs: hash matches
[    1.308478] acpi PNP0C02:08: hash matches
[    1.308522] console [netcon0] enabled
[    1.308523] netconsole: network logging started
[    1.308737] acpi_cpufreq: overriding BIOS provided _PSD data
[    1.309649] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    1.313258] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    1.313265] ALSA device list:
[    1.313266]   No soundcards found.
[    1.313353] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[    1.313355] cfg80211: failed to load regulatory.db
[    1.315624] hdaudio hdaudioC2D0: Unable to bind the codec
[    1.525263] ata9: SATA link down (SStatus 0 SControl 300)
[    1.610244] usb 1-1: new high-speed USB device number 2 using xhci_hcd
[    1.679077] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.685966] ata1.00: ATA-8: KINGSTON SV300S37A120G, 608ABBF0, max UDMA/133
[    1.685970] ata1.00: 234441648 sectors, multi 1: LBA48 NCQ (depth 32), AA
[    1.692146] ata1.00: configured for UDMA/133
[    1.692361] scsi 0:0:0:0: Direct-Access     ATA      KINGSTON SV300S3 BBF0 PQ: 0 ANSI: 5
[    1.692753] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    1.693181] sd 0:0:0:0: [sda] 234441648 512-byte logical blocks: (120 GB/112 GiB)
[    1.693219] sd 0:0:0:0: [sda] Write Protect is off
[    1.693227] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.693303] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.694171]  sda: sda1 sda2 sda3
[    1.694855] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.749181] usb 1-1: New USB device found, idVendor=0409, idProduct=005a, bcdDevice= 1.00
[    1.749186] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    1.755243] hub 1-1:1.0: USB hub found
[    1.758293] hub 1-1:1.0: 4 ports detected
[    1.858483] usb 2-2: new SuperSpeed Gen 1 USB device number 2 using xhci_hcd
[    1.881898] usb 2-2: New USB device found, idVendor=2001, idProduct=4a00, bcdDevice= 1.00
[    1.881903] usb 2-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    1.881906] usb 2-2: Product: D-Link DUB-1312
[    1.881908] usb 2-2: Manufacturer: D-Link Elec. Corp.
[    1.881911] usb 2-2: SerialNumber: 000000000018A9
[    2.004113] random: fast init done
[    2.004317] ata2: SATA link down (SStatus 0 SControl 300)
[    2.090349] usb 1-1.4: new low-speed USB device number 3 using xhci_hcd
[    2.207357] tsc: Refined TSC clocksource calibration: 3596.264 MHz
[    2.207379] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x33d68a5cace, max_idle_ns: 440795334114 ns
[    2.207434] clocksource: Switched to clocksource tsc
[    2.309099] ata5: SATA link down (SStatus 0 SControl 300)
[    2.419002] usb 1-1.4: New USB device found, idVendor=046d, idProduct=c31c, bcdDevice=64.00
[    2.419024] usb 1-1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.419027] usb 1-1.4: Product: USB Keyboard
[    2.419029] usb 1-1.4: Manufacturer: Logitech
[    2.536653] input: Logitech USB Keyboard as /devices/pci0000:00/0000:00:01.2/0000:02:00.0/usb1/1-1/1-1.4/1-1.4:1.0/0003:046D:C31C.0001/input/input3
[    2.589181] hid-generic 0003:046D:C31C.0001: input,hidraw0: USB HID v1.10 Keyboard [Logitech USB Keyboard] on usb-0000:02:00.0-1.4/input0
[    2.623927] ata6: SATA link down (SStatus 0 SControl 300)
[    2.725459] input: Logitech USB Keyboard Consumer Control as /devices/pci0000:00/0000:00:01.2/0000:02:00.0/usb1/1-1/1-1.4/1-1.4:1.1/0003:046D:C31C.0002/input/input4
[    2.777318] input: Logitech USB Keyboard System Control as /devices/pci0000:00/0000:00:01.2/0000:02:00.0/usb1/1-1/1-1.4/1-1.4:1.1/0003:046D:C31C.0002/input/input5
[    2.777564] input: Logitech USB Keyboard Consumer Control as /devices/pci0000:00/0000:00:01.2/0000:02:00.0/usb1/1-1/1-1.4/1-1.4:1.1/0003:046D:C31C.0002/input/input6
[    2.777823] hid-generic 0003:046D:C31C.0002: input,hidraw1: USB HID v1.10 Device [Logitech USB Keyboard] on usb-0000:02:00.0-1.4/input1
[    2.813982] input: Logitech USB Keyboard as /devices/pci0000:00/0000:00:01.2/0000:02:00.0/usb1/1-1/1-1.4/1-1.4:1.2/0003:046D:C31C.0003/input/input7
[    2.814158] hid-generic 0003:046D:C31C.0003: input,hidraw2: USB HID v1.10 Mouse [Logitech USB Keyboard] on usb-0000:02:00.0-1.4/input2
[    3.114925] Freeing unused kernel memory: 1592K
[    3.125028] Write protecting the kernel read-only data: 32768k
[    3.127661] Freeing unused kernel memory: 2004K
[    3.134784] Freeing unused kernel memory: 1924K
[    3.150439] systemd[1]: systemd 238 running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=hybrid)
[    3.162662] systemd[1]: Detected architecture x86-64.
[    3.162666] systemd[1]: Running in initial RAM disk.
[    3.165128] systemd[1]: Set hostname to <raven>.
[    3.214097] systemd[1]: File /usr/lib/systemd/system/systemd-journald.service:35 configures an IP firewall (IPAddressDeny=any), but the local system does not support BPF/cgroup based firewalling.
[    3.214103] systemd[1]: Proceeding WITHOUT firewalling in effect! (This warning is only shown for the first loaded unit using IP firewalling.)
[    3.218572] random: systemd: uninitialized urandom read (16 bytes read)
[    3.218596] systemd[1]: Reached target Local File Systems.
[    3.218655] random: systemd: uninitialized urandom read (16 bytes read)
[    3.218675] systemd[1]: Reached target Timers.
[    3.218684] random: systemd: uninitialized urandom read (16 bytes read)
[    3.218808] systemd[1]: Listening on Journal Socket (/dev/log).
[    3.218938] systemd[1]: Listening on Journal Audit Socket.
[    3.290537] audit: type=1130 audit(1531930024.289:2): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-cmdline comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    3.317338] audit: type=1130 audit(1531930024.316:3): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-pre-udev comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    3.331277] audit: type=1130 audit(1531930024.330:4): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-udevd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    3.339603] audit: type=1130 audit(1531930024.338:5): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-vconsole-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    3.339624] audit: type=1131 audit(1531930024.338:6): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-vconsole-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    3.384606] audit: type=1130 audit(1531930024.383:7): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-journald comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    3.477323] audit: type=1130 audit(1531930024.476:8): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-udev-trigger comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    3.505551] audit: type=1130 audit(1531930024.504:9): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=plymouth-start comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    3.514640] r8169 0000:04:00.0 enp4s0: renamed from eth0
[    3.879296] ax88179_178a 2-2:1.0 eth0: register 'ax88179_178a' at usb-0000:02:00.0-2, D-Link DUB-1312 USB 3.0 to Gigabit Ethernet Adapter, 54:b8:0a:ef:ed:d7
[    3.879352] usbcore: registered new interface driver ax88179_178a
[    3.882674] ax88179_178a 2-2:1.0 enp2s0f0u2: renamed from eth0
[    3.906440] systemd-udevd (2109) used greatest stack depth: 19848 bytes left
[    3.911152] audit: type=1130 audit(1531930024.910:10): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-initqueue comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    3.949100] EXT4-fs (sda3): mounted filesystem with ordered data mode. Opts: (null)
[    4.348310] systemd-journald[1485]: Received SIGTERM from PID 1 (systemd).
[    4.389396] systemd: 23 output lines suppressed due to ratelimiting
[    4.464208] SELinux:  Disabled at runtime.
[    4.464223] SELinux:  Unregistering netfilter hooks
[    4.510098] systemd[1]: systemd 238 running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=hybrid)
[    4.522696] systemd[1]: Detected architecture x86-64.
[    4.523416] systemd[1]: Set hostname to <raven>.
[    4.559039] systemd-veritys (2485) used greatest stack depth: 19768 bytes left
[    4.574707] systemd-sysv-ge (2484) used greatest stack depth: 18648 bytes left
[    4.631947] systemd[1]: File /usr/lib/systemd/system/systemd-journald.service:35 configures an IP firewall (IPAddressDeny=any), but the local system does not support BPF/cgroup based firewalling.
[    4.631952] systemd[1]: Proceeding WITHOUT firewalling in effect! (This warning is only shown for the first loaded unit using IP firewalling.)
[    4.682194] systemd[1]: /usr/lib/systemd/system/virtlockd-admin.socket:7: Unknown lvalue 'Server' in section 'Socket'
[    4.713796] systemd[1]: Stopped Switch Root.
[    4.713967] systemd[1]: systemd-journald.service: Service has no hold-off time, scheduling restart.
[    4.714047] systemd[1]: systemd-journald.service: Scheduled restart job, restart counter is at 1.
[    4.714060] systemd[1]: Stopped Journal Service.
[    4.738871] EXT4-fs (sda3): re-mounted. Opts: (null)
[    4.759032] systemd-journald[2490]: Received request to flush runtime journal from PID 1
[    5.067307] kauditd_printk_skb: 49 callbacks suppressed
[    5.067310] audit: type=1130 audit(1531930026.066:60): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-journal-flush comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.175001] Adding 7826428k swap on /dev/sda2.  Priority:-2 extents:1 across:7826428k SS
[    5.315129] audit: type=1130 audit(1531930026.314:61): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-udev-settle comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.316438] audit: type=1130 audit(1531930026.315:62): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=lvm2-lvmetad comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.334022] audit: type=1130 audit(1531930026.332:63): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=lvm2-monitor comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.340563] audit: type=1130 audit(1531930026.339:64): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=dmraid-activation comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.340584] audit: type=1131 audit(1531930026.339:65): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=dmraid-activation comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.367316] audit: type=1130 audit(1531930026.366:66): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-fsck@dev-disk-by\x2duuid-05bc52dc\x2d0680\x2d4590\x2d9517\x2d8bc91c1cae3d comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.386682] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[    5.397403] audit: type=1130 audit(1531930026.396:67): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=dracut-shutdown comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.400820] audit: type=1130 audit(1531930026.399:68): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=nfs-config comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.400835] audit: type=1131 audit(1531930026.399:69): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=nfs-config comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.528814] random: crng init done
[    5.528818] random: 7 urandom warning(s) missed due to ratelimiting
[    5.822855] IPv6: ADDRCONF(NETDEV_UP): enp2s0f0u2: link is not ready
[    5.850470] plymouthd (2366) used greatest stack depth: 17336 bytes left
[    6.185889] IPv6: ADDRCONF(NETDEV_UP): enp2s0f0u2: link is not ready
[    6.189731] IPv6: ADDRCONF(NETDEV_UP): enp4s0: link is not ready
[    6.227056] r8169 0000:04:00.0 enp4s0: link down
[    6.227202] IPv6: ADDRCONF(NETDEV_UP): enp4s0: link is not ready
[    8.825116] ax88179_178a 2-2:1.0 enp2s0f0u2: ax88179 - Link status is: 1
[    8.844667] IPv6: ADDRCONF(NETDEV_CHANGE): enp2s0f0u2: link becomes ready
[   14.994210] [drm] amdgpu kernel modesetting enabled.
[   15.014284] Parsing CRAT table with 1 nodes
[   15.014297] Creating topology SYSFS entries
[   15.014383] Topology: Add APU node [0x0:0x0]
[   15.014384] Finished initializing topology
[   15.014465] kfd kfd: Initialized module
[   15.015021] amdgpu 0000:01:00.0: enabling device (0000 -> 0003)
[   15.015443] [drm] initializing kernel modesetting (POLARIS10 0x1002:0x67C4 0x1002:0x0B0D 0x00).
[   15.015467] [drm] register mmio base: 0xFE900000
[   15.015468] [drm] register mmio size: 262144
[   15.015492] [drm] add ip block number 0 <vi_common>
[   15.015494] [drm] add ip block number 1 <gmc_v8_0>
[   15.015495] [drm] add ip block number 2 <tonga_ih>
[   15.015496] [drm] add ip block number 3 <powerplay>
[   15.015498] [drm] add ip block number 4 <dm>
[   15.015499] [drm] add ip block number 5 <gfx_v8_0>
[   15.015501] [drm] add ip block number 6 <sdma_v3_0>
[   15.015502] [drm] add ip block number 7 <uvd_v6_0>
[   15.015504] [drm] add ip block number 8 <vce_v3_0>
[   15.015528] [drm] UVD is enabled in VM mode
[   15.015529] [drm] UVD ENC is enabled in VM mode
[   15.015532] [drm] VCE enabled in VM mode
[   15.129402] ATOM BIOS: 113-C9540101-006
[   15.129422] [drm] GPU posting now...
[   15.285854] [drm] vm size is 64 GB, 2 levels, block size is 10-bit, fragment size is 9-bit
[   15.288466] amdgpu 0000:01:00.0: VRAM: 8192M 0x000000F400000000 - 0x000000F5FFFFFFFF (8192M used)
[   15.288469] amdgpu 0000:01:00.0: GART: 256M 0x0000000000000000 - 0x000000000FFFFFFF
[   15.288480] [drm] Detected VRAM RAM=8192M, BAR=256M
[   15.288481] [drm] RAM width 256bits GDDR5
[   15.288713] [TTM] Zone  kernel: Available graphics memory: 3096208 kiB
[   15.288714] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[   15.288715] [TTM] Initializing pool allocator
[   15.288726] [TTM] Initializing DMA pool allocator
[   15.288767] [drm] amdgpu: 8192M of VRAM memory ready
[   15.288770] [drm] amdgpu: 4535M of GTT memory ready.
[   15.288786] [drm] GART: num cpu pages 65536, num gpu pages 65536
[   15.288931] [drm] PCIE GART of 256M enabled (table at 0x000000F400000000).
[   15.290204] [drm] Chained IB support enabled!
[   15.298398] [drm] Found UVD firmware Version: 1.79 Family ID: 16
[   15.298408] [drm] UVD ENC is disabled
[   15.299880] [drm] Found VCE firmware Version: 52.4 Binary ID: 3
[   15.371653] amdgpu: [powerplay] Failed to retrieve minimum clocks.
[   15.371654] amdgpu: [powerplay] Error in phm_get_clock_info 
[   15.371734] [drm] DM_PPLIB: values for Engine clock
[   15.371735] [drm] DM_PPLIB:	 300000
[   15.371736] [drm] DM_PPLIB:	 567000
[   15.371736] [drm] DM_PPLIB:	 849000
[   15.371737] [drm] DM_PPLIB:	 1076000
[   15.371738] [drm] DM_PPLIB:	 1153000
[   15.371738] [drm] DM_PPLIB:	 1181000
[   15.371739] [drm] DM_PPLIB:	 1209000
[   15.371739] [drm] DM_PPLIB:	 1243000
[   15.371740] [drm] DM_PPLIB: Validation clocks:
[   15.371741] [drm] DM_PPLIB:    engine_max_clock: 124300
[   15.371741] [drm] DM_PPLIB:    memory_max_clock: 175000
[   15.371742] [drm] DM_PPLIB:    level           : 0
[   15.371743] [drm] DM_PPLIB: values for Memory clock
[   15.371744] [drm] DM_PPLIB:	 300000
[   15.371744] [drm] DM_PPLIB:	 1750000
[   15.371745] [drm] DM_PPLIB: Validation clocks:
[   15.371745] [drm] DM_PPLIB:    engine_max_clock: 124300
[   15.371746] [drm] DM_PPLIB:    memory_max_clock: 175000
[   15.371746] [drm] DM_PPLIB:    level           : 0
[   15.372463] [drm] Display Core initialized with v3.1.56!
[   15.373726] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   15.373728] [drm] Driver supports precise vblank timestamp query.
[   15.403340] [drm] UVD initialized successfully.
[   15.504244] [drm] VCE initialized successfully.
[   15.507047] kfd kfd: Allocated 3969056 bytes on gart
[   15.507085] Topology: Add APU node [0x67c4:0x1002]
[   15.507197] kfd kfd: added device 1002:67c4
[   15.507537] [drm] Cannot find any crtc or sizes
[   15.511576] [drm] Initialized amdgpu 3.27.0 20150101 for 0000:01:00.0 on minor 0
[   15.511965] [drm] initializing kernel modesetting (RAVEN 0x1002:0x15DD 0x1043:0x876B 0xC6).
[   15.511986] [drm] register mmio base: 0xFE500000
[   15.511987] [drm] register mmio size: 524288
[   15.512007] [drm] add ip block number 0 <soc15_common>
[   15.512008] [drm] add ip block number 1 <gmc_v9_0>
[   15.512009] [drm] add ip block number 2 <vega10_ih>
[   15.512010] [drm] add ip block number 3 <psp>
[   15.512011] [drm] add ip block number 4 <powerplay>
[   15.512011] [drm] add ip block number 5 <dm>
[   15.512012] [drm] add ip block number 6 <gfx_v9_0>
[   15.512013] [drm] add ip block number 7 <sdma_v4_0>
[   15.512014] [drm] add ip block number 8 <vcn_v1_0>
[   15.514845] kfd kfd: DID 15dd is missing in supported_devices
[   15.514848] kfd kfd: kgd2kfd_probe failed
[   15.515013] [drm] VCN decode is enabled in VM mode
[   15.515015] [drm] VCN encode is enabled in VM mode
[   15.515016] [drm] VCN jpeg decode is enabled in VM mode
[   15.539026] [drm] BIOS signature incorrect 65 7
[   15.539080] ATOM BIOS: 113-RAVEN-106
[   15.539141] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, fragment size is 9-bit
[   15.539156] amdgpu 0000:07:00.0: VRAM: 1024M 0x000000F400000000 - 0x000000F43FFFFFFF (1024M used)
[   15.539159] amdgpu 0000:07:00.0: GART: 1024M 0x000000F500000000 - 0x000000F53FFFFFFF
[   15.539164] [drm] Detected VRAM RAM=1024M, BAR=1024M
[   15.539166] [drm] RAM width 128bits DDR4
[   15.539189] [drm] amdgpu: 1024M of VRAM memory ready
[   15.539192] [drm] amdgpu: 3072M of GTT memory ready.
[   15.539209] [drm] GART: num cpu pages 262144, num gpu pages 262144
[   15.539389] [drm] PCIE GART of 1024M enabled (table at 0x000000F400900000).
[   15.551968] [drm] use_doorbell being set to: [true]
[   15.554393] [drm] Found VCN firmware Version: 1.73 Family ID: 18
[   15.631198] amdgpu: [powerplay] dpm has been enabled
[   15.631303] [drm] DM_PPLIB: values for Invalid clock
[   15.631304] [drm] DM_PPLIB:	 0 in kHz
[   15.631305] [drm] DM_PPLIB:	 400000 in kHz
[   15.631306] [drm] DM_PPLIB:	 933000 in kHz
[   15.631307] [drm] DM_PPLIB:	 1067000 in kHz
[   15.631497] WARNING: CPU: 0 PID: 3738 at drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:1372 dcn_bw_update_from_pplib+0x309/0x530 [amdgpu]
[   15.631498] Modules linked in: amdkfd amdgpu(+) mfd_core chash gpu_sched ttm ax88179_178a usbnet
[   15.631509] CPU: 0 PID: 3738 Comm: modprobe Not tainted 4.18.0-rc1+ #9
[   15.631510] Hardware name: System manufacturer System Product Name/TUF B350M-PLUS GAMING, BIOS 4011 04/19/2018
[   15.631673] RIP: 0010:dcn_bw_update_from_pplib+0x309/0x530 [amdgpu]
[   15.631673] Code: 6a 1d 00 dc f9 d9 c9 dc 4c 24 08 dc 0d 30 6a 1d 00 de f1 d9 5c 24 08 e8 d5 bc 73 e6 f3 0f 10 5c 24 08 f3 41 0f 11 5f 4c eb 02 <0f> 0b 4c 8d a4 24 c0 00 00 00 48 8b 3c 24 be 04 00 00 00 4c 89 e2 
[   15.631705] RSP: 0018:ffff8801ebc2e908 EFLAGS: 00010246
[   15.631708] RAX: 0000000000000000 RBX: ffff8801ebc2e948 RCX: ffffffffc0626fc8
[   15.631710] RDX: 0000000000000007 RSI: dffffc0000000000 RDI: ffff8801ebc2e94c
[   15.631711] RBP: ffff8801ebaf5500 R08: ffffed0040003c9f R09: ffffed0040003c9e
[   15.631713] R10: ffffed0040003c9e R11: ffff88020001e4f7 R12: 0000000000000004
[   15.631714] R13: 1ffff1003d785d25 R14: ffff8801f4d72840 R15: 0000000000000000
[   15.631716] FS:  00007f05e13050c0(0000) GS:ffff880200000000(0000) knlGS:0000000000000000
[   15.631717] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   15.631719] CR2: 00007f886d158038 CR3: 00000001eebfe000 CR4: 00000000003406f0
[   15.631720] Call Trace:
[   15.631883]  ? dcn_find_dcfclk_suits_all+0x610/0x610 [amdgpu]
[   15.631888]  ? rcu_note_context_switch+0x2a0/0x2a0
[   15.632051]  ? dcn10_create_resource_pool+0x5f3/0xf00 [amdgpu]
[   15.632213]  ? dcn10_create_resource_pool+0x5f3/0xf00 [amdgpu]
[   15.632376]  ? dcn10_create_resource_pool+0xbef/0xf00 [amdgpu]
[   15.632538]  ? dal_i2caux_construct_engine+0x22/0x30 [amdgpu]
[   15.632700]  ? dal_aux_engine_dce110_create+0x9f/0xd0 [amdgpu]
[   15.632862]  ? dcn10_clock_source_destroy+0x30/0x30 [amdgpu]
[   15.633024]  ? dal_i2caux_dce110_construct+0x386/0x400 [amdgpu]
[   15.633185]  ? dc_create_resource_pool+0x8b/0x240 [amdgpu]
[   15.633345]  ? resource_parse_asic_id+0x170/0x170 [amdgpu]
[   15.633348]  ? kasan_kmalloc+0xbf/0xe0
[   15.633510]  ? dal_gpio_service_create+0xe7/0x180 [amdgpu]
[   15.633513]  ? __kmalloc+0x104/0x1f0
[   15.633675]  ? dal_gpio_service_create+0xe7/0x180 [amdgpu]
[   15.633836]  ? dc_create+0x407/0xc90 [amdgpu]
[   15.633997]  ? dc_create_state+0xe0/0xe0 [amdgpu]
[   15.634157]  ? amdgpu_dm_irq_unregister_interrupt+0x320/0x320 [amdgpu]
[   15.634296]  ? amdgpu_mm_rreg+0x1e4/0x210 [amdgpu]
[   15.634299]  ? rcu_note_context_switch+0x2a0/0x2a0
[   15.634301]  ? kasan_unpoison_shadow+0x30/0x40
[   15.634303]  ? kasan_kmalloc+0xbf/0xe0
[   15.634457]  ? amdgpu_cgs_create_device+0x27/0x60 [amdgpu]
[   15.634460]  ? kmem_cache_alloc_trace+0xea/0x1a0
[   15.634613]  ? amdgpu_cgs_create_device+0x27/0x60 [amdgpu]
[   15.634773]  ? dm_hw_init+0x20c/0x320 [amdgpu]
[   15.634933]  ? dm_resume+0x580/0x580 [amdgpu]
[   15.635092]  ? psm_set_states+0xc3/0xe0 [amdgpu]
[   15.635248]  ? hwmgr_hw_init+0x27e/0x2a0 [amdgpu]
[   15.635408]  ? amdgpu_device_init.cold.29+0x11ca/0x1784 [amdgpu]
[   15.635548]  ? amdgpu_device_has_dc_support+0x30/0x30 [amdgpu]
[   15.635553]  ? __alloc_pages_nodemask+0x26c/0x4e0
[   15.635555]  ? __alloc_pages_slowpath+0x1780/0x1780
[   15.635557]  ? save_stack+0x8c/0xb0
[   15.635561]  ? mutex_unlock+0x18/0x40
[   15.635564]  ? kernfs_activate+0x13f/0x180
[   15.635567]  ? kernfs_get+0x10/0x10
[   15.635569]  ? kasan_unpoison_shadow+0x30/0x40
[   15.635572]  ? kmalloc_order+0x46/0x60
[   15.635712]  ? amdgpu_driver_load_kms+0x110/0x3c0 [amdgpu]
[   15.635852]  ? amdgpu_driver_unload_kms+0xd0/0xd0 [amdgpu]
[   15.635855]  ? sysfs_do_create_link_sd.isra.2+0xef/0x190
[   15.635858]  ? __kasan_slab_free+0x13a/0x170
[   15.635861]  ? drm_dev_register+0x1a4/0x1f0
[   15.636001]  ? amdgpu_pci_probe+0x1af/0x230 [amdgpu]
[   15.636140]  ? amdgpu_pmops_runtime_idle+0x190/0x190 [amdgpu]
[   15.636144]  ? local_pci_probe+0x6b/0xc0
[   15.636147]  ? pci_device_probe+0x195/0x260
[   15.636149]  ? pci_device_remove+0x1d0/0x1d0
[   15.636152]  ? kobject_uevent_env+0x159/0x820
[   15.636156]  ? driver_probe_device+0x426/0x510
[   15.636158]  ? driver_probe_done+0xb0/0xb0
[   15.636161]  ? mutex_lock+0xa1/0x100
[   15.636163]  ? __mutex_lock_slowpath+0x10/0x10
[   15.636166]  ? driver_probe_device+0x510/0x510
[   15.636168]  ? __driver_attach+0x12c/0x130
[   15.636171]  ? bus_for_each_dev+0xe1/0x140
[   15.636173]  ? subsys_dev_iter_exit+0x10/0x10
[   15.636175]  ? bus_add_driver+0x78/0x2c0
[   15.636178]  ? kmem_cache_alloc_trace+0xea/0x1a0
[   15.636180]  ? bus_add_driver+0x276/0x2c0
[   15.636183]  ? driver_register+0xca/0x140
[   15.636186]  ? __pci_register_driver+0x144/0x170
[   15.636188]  ? pci_bus_num_vf+0x10/0x10
[   15.636190]  ? kmem_cache_create_usercopy+0x1a8/0x290
[   15.636193]  ? 0xffffffffc08d8000
[   15.636196]  ? do_one_initcall+0xa2/0x2cc
[   15.636198]  ? trace_event_raw_event_initcall_finish+0x130/0x130
[   15.636201]  ? __ia32_sys_sched_yield+0x10/0x10
[   15.636204]  ? llist_add_batch+0xbc/0x110
[   15.636206]  ? rcu_note_context_switch+0x2a0/0x2a0
[   15.636209]  ? kasan_unpoison_shadow+0x30/0x40
[   15.636211]  ? kasan_kmalloc+0xbf/0xe0
[   15.636213]  ? kasan_unpoison_shadow+0x30/0x40
[   15.636216]  ? do_init_module+0x14e/0x3c0
[   15.636219]  ? __x64_sys_delete_module+0x3c0/0x3c0
[   15.636221]  ? __kasan_slab_free+0x13a/0x170
[   15.636224]  ? load_module+0x3796/0x3f10
[   15.636229]  ? module_frob_arch_sections+0x20/0x20
[   15.636231]  ? __vfs_read+0x32f/0x370
[   15.636233]  ? __x64_sys_copy_file_range+0x360/0x360
[   15.636238]  ? __fsnotify_update_child_dentry_flags.part.3+0x2d0/0x2d0
[   15.636240]  ? __fsnotify_parent+0x7f/0x210
[   15.636243]  ? __fsnotify_update_child_dentry_flags.part.3+0x2d0/0x2d0
[   15.636245]  ? vfs_read+0x16c/0x1a0
[   15.636247]  ? vfs_read+0xbe/0x1a0
[   15.636249]  ? kernel_read+0x6f/0x90
[   15.636252]  ? kernel_read_file+0x210/0x2f0
[   15.636255]  ? free_bprm+0xf0/0xf0
[   15.636257]  ? up_read+0x20/0x20
[   15.636260]  ? __do_sys_finit_module+0x18f/0x1c0
[   15.636262]  ? __do_sys_finit_module+0x18f/0x1c0
[   15.636265]  ? __ia32_sys_init_module+0x40/0x40
[   15.636267]  ? vfs_statx_fd+0x3f/0x80
[   15.636269]  ? __do_sys_newfstat+0xb5/0xc0
[   15.636273]  ? do_syscall_64+0xf7/0x2a0
[   15.636275]  ? syscall_return_slowpath+0x1d0/0x1d0
[   15.636278]  ? do_page_fault+0x8a/0x210
[   15.636280]  ? __do_page_fault+0x680/0x680
[   15.636282]  ? prepare_exit_to_usermode+0xe8/0x150
[   15.636284]  ? perf_trace_sys_enter+0x4b0/0x4b0
[   15.636287]  ? __put_user_4+0x1c/0x30
[   15.636290]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   15.636292] ---[ end trace 6645162bbdbe304e ]---
[   15.636301] [drm] DM_PPLIB: values for Invalid clock
[   15.636302] [drm] DM_PPLIB:	 300000 in kHz
[   15.636303] [drm] DM_PPLIB:	 600000 in kHz
[   15.636304] [drm] DM_PPLIB:	 626000 in kHz
[   15.636304] [drm] DM_PPLIB:	 654000 in kHz
[   15.646754] [drm] Display Core initialized with v3.1.56!
[   15.671849] [drm] SADs count is: -524, don't need to read it
[   15.672766] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   15.672768] [drm] Driver supports precise vblank timestamp query.
[   15.697309] [drm] VCN decode and encode initialized successfully.
[   15.699217] [drm] fb mappable at 0x81100000
[   15.699219] [drm] vram apper at 0x80000000
[   15.699220] [drm] size 8294400
[   15.699221] [drm] fb depth is 24
[   15.699221] [drm]    pitch is 7680
[   15.699368] fbcon: amdgpudrmfb (fb0) is primary device
[   15.762636] Console: switching to colour frame buffer device 240x67
[   15.777875] amdgpu 0000:07:00.0: fb0: amdgpudrmfb frame buffer device
[   15.788945] amdgpu 0000:07:00.0: ring 0(gfx) uses VM inv eng 4 on hub 0
[   15.788950] amdgpu 0000:07:00.0: ring 1(comp_1.0.0) uses VM inv eng 5 on hub 0
[   15.788953] amdgpu 0000:07:00.0: ring 2(comp_1.1.0) uses VM inv eng 6 on hub 0
[   15.788957] amdgpu 0000:07:00.0: ring 3(comp_1.2.0) uses VM inv eng 7 on hub 0
[   15.788960] amdgpu 0000:07:00.0: ring 4(comp_1.3.0) uses VM inv eng 8 on hub 0
[   15.788964] amdgpu 0000:07:00.0: ring 5(comp_1.0.1) uses VM inv eng 9 on hub 0
[   15.788968] amdgpu 0000:07:00.0: ring 6(comp_1.1.1) uses VM inv eng 10 on hub 0
[   15.788971] amdgpu 0000:07:00.0: ring 7(comp_1.2.1) uses VM inv eng 11 on hub 0
[   15.788974] amdgpu 0000:07:00.0: ring 8(comp_1.3.1) uses VM inv eng 12 on hub 0
[   15.788989] amdgpu 0000:07:00.0: ring 9(kiq_2.1.0) uses VM inv eng 13 on hub 0
[   15.788993] amdgpu 0000:07:00.0: ring 10(sdma0) uses VM inv eng 4 on hub 1
[   15.788996] amdgpu 0000:07:00.0: ring 11(vcn_dec) uses VM inv eng 5 on hub 1
[   15.789011] amdgpu 0000:07:00.0: ring 12(vcn_enc0) uses VM inv eng 6 on hub 1
[   15.789013] amdgpu 0000:07:00.0: ring 13(vcn_enc1) uses VM inv eng 7 on hub 1
[   15.789016] amdgpu 0000:07:00.0: ring 14(vcn_jpeg) uses VM inv eng 8 on hub 1
[   16.240818] [drm] Initialized amdgpu 3.27.0 20150101 for 0000:07:00.0 on minor 1
[   16.241899] modprobe (3738) used greatest stack depth: 16248 bytes left
[   16.452227] WARNING: CPU: 6 PID: 1346 at drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:92 amdgpu_ttm_bo_destroy+0x386/0x3a0 [amdgpu]
[   16.452229] Modules linked in: amdkfd amdgpu mfd_core chash gpu_sched ttm ax88179_178a usbnet
[   16.452240] CPU: 6 PID: 1346 Comm: kworker/6:2 Tainted: G        W         4.18.0-rc1+ #9
[   16.452241] Hardware name: System manufacturer System Product Name/TUF B350M-PLUS GAMING, BIOS 4011 04/19/2018
[   16.452253] Workqueue: events ttm_bo_delayed_workqueue [ttm]
[   16.452387] RIP: 0010:amdgpu_ttm_bo_destroy+0x386/0x3a0 [amdgpu]
[   16.452388] Code: 5c 41 5d 41 5e 41 5f c3 4c 89 ef e8 34 01 94 e6 48 c7 83 70 03 00 00 00 00 00 00 e9 17 fe ff ff 4c 8d 64 24 40 e9 0d fe ff ff <0f> 0b 4c 89 ff e8 a0 fb ff ff e9 25 fd ff ff e8 e6 fc 67 e6 66 0f 
[   16.452425] RSP: 0018:ffff8801f48f7100 EFLAGS: 00010202
[   16.452428] RAX: 0000000000000001 RBX: ffff8801fcb388d8 RCX: ffffffffc0422b8c
[   16.452430] RDX: 0000000000000003 RSI: dffffc0000000000 RDI: ffff8801fcb38b28
[   16.452432] RBP: 1ffff1003e91ee24 R08: 0000000000000000 R09: ffff8801f48f6f70
[   16.452433] R10: ffffed003e91edf8 R11: ffff8801f48f6fc7 R12: 0000000000000000
[   16.452435] R13: ffff8801fcb388d8 R14: ffff8801fcb38990 R15: ffff8801fcb38880
[   16.452438] FS:  0000000000000000(0000) GS:ffff880200180000(0000) knlGS:0000000000000000
[   16.452439] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   16.452441] CR2: 0000000001bf70e8 CR3: 00000001ea742000 CR4: 00000000003406e0
[   16.452442] Call Trace:
[   16.452584]  ? amdgpu_bo_subtract_pin_size+0xd0/0xd0 [amdgpu]
[   16.452590]  ? mutex_unlock+0x18/0x40
[   16.452603]  ? ttm_bo_cleanup_refs+0x5be/0x630 [ttm]
[   16.452615]  ? ttm_bo_put+0x20/0x20 [ttm]
[   16.452619]  ? deref_stack_reg+0xe0/0xe0
[   16.452623]  ? __kasan_slab_free+0x13a/0x170
[   16.452636]  ? ttm_bo_release_list+0x3d2/0x480 [ttm]
[   16.452648]  ? ttm_bo_add_move_fence.isra.20+0x170/0x170 [ttm]
[   16.452652]  ? inotify_handle_event+0xa8/0x270
[   16.452655]  ? __kmalloc+0x104/0x1f0
[   16.452658]  ? inotify_handle_event+0x120/0x270
[   16.452663]  ? _atomic_dec_and_lock+0x9c/0x180
[   16.452665]  ? cpumask_local_spread+0x140/0x140
[   16.452668]  ? mutex_trylock+0xed/0x120
[   16.452671]  ? ww_mutex_unlock+0x40/0x40
[   16.452675]  ? pick_next_entity+0xed/0x1d0
[   16.452688]  ? ttm_bo_delayed_delete+0x25c/0x5e0 [ttm]
[   16.452701]  ? ttm_bo_cleanup_refs+0x630/0x630 [ttm]
[   16.452705]  ? ioc_destroy_icq+0x2c7/0x370
[   16.452708]  ? kernfs_put+0x99/0x3e0
[   16.452712]  ? find_inode_fast.isra.26+0x14a/0x170
[   16.452715]  ? rcu_note_context_switch+0x2a0/0x2a0
[   16.452717]  ? kernfs_get+0x10/0x10
[   16.452721]  ? _cond_resched+0x10/0x20
[   16.452723]  ? ilookup+0x146/0x1a0
[   16.452727]  ? clear_asid_other+0x40/0x40
[   16.452730]  ? _raw_spin_lock_irq+0xf/0x30
[   16.452733]  ? kernfs_notify_workfn+0x324/0x380
[   16.452736]  ? finish_task_switch+0x217/0x4e0
[   16.452740]  ? set_load_weight+0x100/0x100
[   16.452743]  ? read_word_at_a_time+0xe/0x20
[   16.452745]  ? strscpy+0x14b/0x280
[   16.452749]  ? read_word_at_a_time+0x20/0x20
[   16.452761]  ? ttm_bo_delayed_workqueue+0x12/0x40 [ttm]
[   16.452764]  ? process_one_work+0x5a8/0x980
[   16.452768]  ? max_active_store+0xe0/0xe0
[   16.452770]  ? __sched_text_start+0x8/0x8
[   16.452773]  ? move_queued_task.isra.84+0x290/0x290
[   16.452776]  ? rcu_note_context_switch+0x2a0/0x2a0
[   16.452779]  ? vsnprintf+0x4ac/0x790
[   16.452782]  ? __wake_up_common+0xb0/0x2e0
[   16.452786]  ? need_to_create_worker+0x150/0x150
[   16.452788]  ? wq_calc_node_cpumask+0x120/0x120
[   16.452791]  ? remove_wait_queue+0x150/0x150
[   16.452794]  ? __cpuidle_text_end+0x4/0x4
[   16.452797]  ? schedule+0xca/0x240
[   16.452799]  ? worker_enter_idle+0x217/0x330
[   16.452801]  ? __schedule+0xd50/0xd50
[   16.452804]  ? __wake_up_common+0x2e0/0x2e0
[   16.452806]  ? need_to_create_worker+0x13b/0x150
[   16.452809]  ? try_to_del_timer_sync+0x9c/0xe0
[   16.452812]  ? del_timer+0xe0/0xe0
[   16.452814]  ? cpu_load_update_active+0x190/0x190
[   16.452816]  ? worker_thread+0x17c/0xa70
[   16.452819]  ? process_one_work+0x980/0x980
[   16.452822]  ? __schedule+0x528/0xd50
[   16.452824]  ? migrate_swap_stop+0x430/0x430
[   16.452827]  ? __sched_text_start+0x8/0x8
[   16.452829]  ? save_stack+0x8c/0xb0
[   16.452833]  ? schedule+0xca/0x240
[   16.452836]  ? __schedule+0xd50/0xd50
[   16.452838]  ? remove_wait_queue+0x150/0x150
[   16.452840]  ? rcu_note_context_switch+0x2a0/0x2a0
[   16.452842]  ? kasan_unpoison_shadow+0x30/0x40
[   16.452845]  ? __kthread_parkme+0xc7/0x100
[   16.452847]  ? parse_args.cold.17+0x146/0x146
[   16.452850]  ? process_one_work+0x980/0x980
[   16.452852]  ? kthread+0x19b/0x1c0
[   16.452854]  ? kthread_create_worker_on_cpu+0xc0/0xc0
[   16.452856]  ? ret_from_fork+0x22/0x40
[   16.452859] ---[ end trace 6645162bbdbe304f ]---
[   18.637792] fuse init (API version 7.27)
[   20.764445] rfkill: input handler disabled
[   84.110151] ==================================================================
[   84.110314] BUG: KASAN: use-after-free in amdgpu_job_submit+0xae/0xe0 [amdgpu]
[   84.110319] Read of size 4 at addr ffff880158ca80c4 by task shader_runner/22222

[   84.110329] CPU: 2 PID: 22222 Comm: shader_runner Tainted: G        W         4.18.0-rc1+ #9
[   84.110331] Hardware name: System manufacturer System Product Name/TUF B350M-PLUS GAMING, BIOS 4011 04/19/2018
[   84.110332] Call Trace:
[   84.110340]  ? dump_stack+0xad/0x12c
[   84.110344]  ? dump_stack_print_info.cold.1+0x2f/0x2f
[   84.110349]  ? kmsg_dump_rewind_nolock+0x54/0x54
[   84.110488]  ? amdgpu_sync_create+0x50/0x50 [amdgpu]
[   84.110642]  ? amdgpu_job_alloc+0x192/0x1e0 [amdgpu]
[   84.110803]  ? amdgpu_job_submit+0xae/0xe0 [amdgpu]
[   84.110810]  ? print_address_description+0x60/0x229
[   84.110975]  ? amdgpu_job_submit+0xae/0xe0 [amdgpu]
[   84.110978]  ? kasan_report.cold.6+0x241/0x2fd
[   84.111140]  ? amdgpu_job_submit+0xae/0xe0 [amdgpu]
[   84.111290]  ? sdma_v3_0_vm_set_pte_pde+0x1a0/0x1a0 [amdgpu]
[   84.111476]  ? amdgpu_vm_bo_update_mapping+0x5ff/0x7a0 [amdgpu]
[   84.111657]  ? amdgpu_vm_frag_ptes+0x150/0x150 [amdgpu]
[   84.111662]  ? unwind_next_frame+0x1f9/0xa40
[   84.111665]  ? unwind_next_frame+0x1f9/0xa40
[   84.111849]  ? amdgpu_vm_bo_base_init+0x4b0/0x4b0 [amdgpu]
[   84.111854]  ? __save_stack_trace+0x59/0xf0
[   84.112032]  ? amdgpu_vm_bo_update+0x741/0xf50 [amdgpu]
[   84.112218]  ? amdgpu_vm_bo_update_mapping+0x7a0/0x7a0 [amdgpu]
[   84.112223]  ? __unwind_start+0x3b1/0x420
[   84.112227]  ? save_stack+0x8c/0xb0
[   84.112245]  ? ttm_eu_reserve_buffers+0x446/0x750 [ttm]
[   84.112431]  ? amdgpu_vm_it_insert+0xb6/0xf0 [amdgpu]
[   84.112604]  ? amdgpu_vm_bo_insert_map+0x1cc/0x440 [amdgpu]
[   84.112786]  ? amdgpu_vm_num_entries+0x86/0xc0 [amdgpu]
[   84.112958]  ? amdgpu_vm_prt_get.part.12+0x40/0x40 [amdgpu]
[   84.113093]  ? amdgpu_vm_alloc_levels+0x275/0x560 [amdgpu]
[   84.113228]  ? amdgpu_vm_clear_freed+0x263/0x360 [amdgpu]
[   84.113368]  ? amdgpu_vm_bo_update+0xf50/0xf50 [amdgpu]
[   84.113374]  ? kasan_unpoison_shadow+0x30/0x40
[   84.113376]  ? kasan_kmalloc+0xbf/0xe0
[   84.113503]  ? amdgpu_vm_bo_map+0xe8/0x1c0 [amdgpu]
[   84.113508]  ? kmem_cache_alloc_trace+0xea/0x1a0
[   84.113640]  ? amdgpu_vm_ready+0x70/0xa0 [amdgpu]
[   84.113778]  ? amdgpu_vm_validate_pt_bos+0x580/0x580 [amdgpu]
[   84.113909]  ? amdgpu_vm_bo_map+0x13c/0x1c0 [amdgpu]
[   84.114050]  ? amdgpu_gem_va_ioctl+0x93a/0x950 [amdgpu]
[   84.114054]  ? __radix_tree_preload+0x30/0xd0
[   84.114194]  ? amdgpu_gem_metadata_ioctl+0x3a0/0x3a0 [amdgpu]
[   84.114324]  ? amdgpu_gem_object_free+0x60/0xb0 [amdgpu]
[   84.114328]  ? mutex_lock+0xa1/0x100
[   84.114330]  ? __mutex_lock_slowpath+0x10/0x10
[   84.114462]  ? amdgpu_gem_create_ioctl+0x320/0x540 [amdgpu]
[   84.114466]  ? rpm_resume+0x1a1/0xee0
[   84.114469]  ? rpm_callback+0xd0/0xd0
[   84.114474]  ? __lru_cache_add+0x18e/0x1b0
[   84.114477]  ? __pagevec_lru_add+0x10/0x10
[   84.114480]  ? can_vma_merge_before+0x74/0x1c0
[   84.114484]  ? __srcu_read_lock+0x99/0xe0
[   84.114487]  ? rcu_sync_dtor+0x180/0x180
[   84.114493]  ? drm_ioctl_kernel+0x14f/0x1a0
[   84.114623]  ? amdgpu_gem_metadata_ioctl+0x3a0/0x3a0 [amdgpu]
[   84.114627]  ? drm_setversion+0x330/0x330
[   84.114630]  ? follow_pfn+0x1a0/0x1a0
[   84.114763]  ? amdgpu_gem_metadata_ioctl+0x3a0/0x3a0 [amdgpu]
[   84.114767]  ? drm_ioctl+0x30c/0x580
[   84.114771]  ? drm_getunique+0xe0/0xe0
[   84.114779]  ? __cpuidle_text_end+0x4/0x4
[   84.114783]  ? arch_get_unmapped_area+0x320/0x320
[   84.114786]  ? __schedule+0x528/0xd50
[   84.114913]  ? amdgpu_drm_ioctl+0xca/0x180 [amdgpu]
[   84.114916]  ? 0xffffffffc0400000
[   84.114921]  ? do_vfs_ioctl+0x13d/0xa50
[   84.114925]  ? down_write_killable+0x9f/0xe0
[   84.114929]  ? ioctl_preallocate+0x170/0x170
[   84.114934]  ? vm_mmap_pgoff+0x176/0x1b0
[   84.114939]  ? __fget_light+0x1f5/0x210
[   84.114943]  ? expand_files.part.9+0x560/0x560
[   84.114947]  ? vmacache_find+0xa9/0x110
[   84.114950]  ? rcu_note_context_switch+0x2a0/0x2a0
[   84.114953]  ? handle_mm_fault+0xf7/0x1a0
[   84.114957]  ? __do_page_fault+0x3fc/0x680
[   84.114959]  ? ksys_ioctl+0x5b/0x90
[   84.114962]  ? __x64_sys_ioctl+0x38/0x40
[   84.114965]  ? do_syscall_64+0xf7/0x2a0
[   84.114967]  ? syscall_return_slowpath+0x1d0/0x1d0
[   84.114969]  ? do_page_fault+0x8a/0x210
[   84.114971]  ? __do_page_fault+0x680/0x680
[   84.114974]  ? prepare_exit_to_usermode+0xe8/0x150
[   84.114976]  ? perf_trace_sys_enter+0x4b0/0x4b0
[   84.114979]  ? __put_user_4+0x1c/0x30
[   84.114983]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9

[   84.114991] Allocated by task 22222:
[   84.114993] (stack is not available)

[   84.114998] Freed by task 1090:
[   84.114999] (stack is not available)

[   84.115005] The buggy address belongs to the object at ffff880158ca8000
                which belongs to the cache kmalloc-1024 of size 1024
[   84.115009] The buggy address is located 196 bytes inside of
                1024-byte region [ffff880158ca8000, ffff880158ca8400)
[   84.115012] The buggy address belongs to the page:
[   84.115017] page:ffffea0005632a00 count:1 mapcount:0 mapping:ffff8801ff803180 index:0x0 compound_mapcount: 0
[   84.115023] flags: 0x200000000008100(slab|head)
[   84.115029] raw: 0200000000008100 dead000000000100 dead000000000200 ffff8801ff803180
[   84.115033] raw: 0000000000000000 00000000801c001c 00000001ffffffff 0000000000000000
[   84.115036] page dumped because: kasan: bad access detected

[   84.115039] Memory state around the buggy address:
[   84.115043]  ffff880158ca7f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   84.115046]  ffff880158ca8000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   84.115049] >ffff880158ca8080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   84.115052]                                            ^
[   84.115055]  ffff880158ca8100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   84.115058]  ffff880158ca8180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   84.115060] ==================================================================
[   84.115063] Disabling lock debugging due to kernel taint

--------------7275574BAC90F9F72C938FFD
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------7275574BAC90F9F72C938FFD--
