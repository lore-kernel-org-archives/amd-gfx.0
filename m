From: Shawn Starr <shawn.starr-bJEeYj9oJeDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: Print type if we get wrong ObjectID from
 bios
Date: Mon, 27 Nov 2017 17:23:46 -0500
Message-ID: <3eae0c78-1ce7-d1ff-9899-59c9c675dfb7@rogers.com>
References: <c24d7ce0-c40e-9edb-ee2e-a88da7f53013@rogers.com>
 <20171124144423.32257-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------BFD5BA05234FBEE871417F3F"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171124144423.32257-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
To: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--------------BFD5BA05234FBEE871417F3F
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/24/2017 09:44 AM, Harry Wentland wrote:
> We've seen a bunch of issues where we can't get the connector from vbios
> for what we think should be a valid connector id. Print some more info
> when this happens.
> 
> Change-Id: I96aee657ed4632fbc0ab313671da356dc225c8c4
> Signed-off-by: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
> ---
> 
> Hi Shawn,
> 
> mind trying this patch? It won't fix anything but should give us a bit
> more info on why you're getting this invalid connector ObjectId.
> 
> Harry
> 

Hi Harry,

here's dmesg from kernel with dc=1 with patch applied, this is against 
Linus's 4.15-rc1 git tag.

Thanks,

Shawn.




--------------BFD5BA05234FBEE871417F3F
Content-Type: text/x-log;
 name="dmesg.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg.log"

[    0.000000] microcode: microcode updated early to revision 0x22, date = 2017-01-27
[    0.000000] Linux version 4.15.0-rc1+ (spstarr-RRHT56Q3PSMGBMjmSbuoWl6hYfS7NtTn@public.gmane.org) (gcc version 7.2.1 20170915 (Red Hat 7.2.1-2) (GCC)) #1 SMP Mon Nov 27 16:39:35 EST 2017
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-4.15.0-rc1+ root=UUID=c88abf6f-2561-41e5-bec5-c3b2881d0ffc ro rhgb slub_debug=- cgroup_disable=memory console=tty0 console=ttyUSB0,9600n8 nmi_watchdog=0 audit=0 radeon.cik_support=0 amdgpu.cik_support=1 resume=/dev/sda7 i915.enable_rc6=1 i915.semaphores=1 i915.enable_psr=1 i915.enable_fbc=1 drm_kms_helper.poll=0 mce=off amdgpu.dc=1
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000004efff] usable
[    0.000000] BIOS-e820: [mem 0x000000000004f000-0x000000000004ffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000050000-0x000000000009efff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009f000-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000c2f6efff] usable
[    0.000000] BIOS-e820: [mem 0x00000000c2f6f000-0x00000000c2f75fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000c2f76000-0x00000000c3943fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000c3944000-0x00000000c3e1cfff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000c3e1d000-0x00000000cadb2fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000cadb3000-0x00000000caffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000cb000000-0x00000000cb758fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000cb759000-0x00000000cb7fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000cb800000-0x00000000cbf92fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000cbf93000-0x00000000cbffffff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000cc000000-0x00000000cd6d3fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000cd6d4000-0x00000000cd7fffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000cd800000-0x00000000cecdcfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000cecdd000-0x00000000ceffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed03fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000082dffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] e820: update [mem 0xc85e8018-0xc8604857] usable ==> usable
[    0.000000] e820: update [mem 0xc85e8018-0xc8604857] usable ==> usable
[    0.000000] e820: update [mem 0xc85d8018-0xc85e7c57] usable ==> usable
[    0.000000] e820: update [mem 0xc85d8018-0xc85e7c57] usable ==> usable
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 0x0000000000000000-0x000000000004efff] usable
[    0.000000] reserve setup_data: [mem 0x000000000004f000-0x000000000004ffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000050000-0x000000000009efff] usable
[    0.000000] reserve setup_data: [mem 0x000000000009f000-0x000000000009ffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000100000-0x00000000c2f6efff] usable
[    0.000000] reserve setup_data: [mem 0x00000000c2f6f000-0x00000000c2f75fff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x00000000c2f76000-0x00000000c3943fff] usable
[    0.000000] reserve setup_data: [mem 0x00000000c3944000-0x00000000c3e1cfff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000c3e1d000-0x00000000c85d8017] usable
[    0.000000] reserve setup_data: [mem 0x00000000c85d8018-0x00000000c85e7c57] usable
[    0.000000] reserve setup_data: [mem 0x00000000c85e7c58-0x00000000c85e8017] usable
[    0.000000] reserve setup_data: [mem 0x00000000c85e8018-0x00000000c8604857] usable
[    0.000000] reserve setup_data: [mem 0x00000000c8604858-0x00000000cadb2fff] usable
[    0.000000] reserve setup_data: [mem 0x00000000cadb3000-0x00000000caffffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000cb000000-0x00000000cb758fff] usable
[    0.000000] reserve setup_data: [mem 0x00000000cb759000-0x00000000cb7fffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000cb800000-0x00000000cbf92fff] usable
[    0.000000] reserve setup_data: [mem 0x00000000cbf93000-0x00000000cbffffff] ACPI data
[    0.000000] reserve setup_data: [mem 0x00000000cc000000-0x00000000cd6d3fff] usable
[    0.000000] reserve setup_data: [mem 0x00000000cd6d4000-0x00000000cd7fffff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x00000000cd800000-0x00000000cecdcfff] usable
[    0.000000] reserve setup_data: [mem 0x00000000cecdd000-0x00000000ceffffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fed00000-0x00000000fed03fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000100000000-0x000000082dffffff] usable
[    0.000000] efi: EFI v2.31 by American Megatrends
[    0.000000] efi:  ACPI 2.0=0xcbfd4000  ACPI=0xcbfd4000  SMBIOS=0xf04c0  MPS=0xfd700 
[    0.000000] random: fast init done
[    0.000000] SMBIOS 2.7 present.
[    0.000000] DMI: Dell Inc. Precision M6800/05NG6V, BIOS A19 05/14/2017
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x82e000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-CFFFF write-protect
[    0.000000]   D0000-DFFFF uncachable
[    0.000000]   E0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 0000000000 mask 7800000000 write-back
[    0.000000]   1 base 0800000000 mask 7FE0000000 write-back
[    0.000000]   2 base 0820000000 mask 7FF8000000 write-back
[    0.000000]   3 base 0828000000 mask 7FFC000000 write-back
[    0.000000]   4 base 082C000000 mask 7FFE000000 write-back
[    0.000000]   5 base 00E0000000 mask 7FE0000000 uncachable
[    0.000000]   6 base 00D0000000 mask 7FF0000000 uncachable
[    0.000000]   7 disabled
[    0.000000]   8 disabled
[    0.000000]   9 disabled
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000000] e820: update [mem 0xd0000000-0xffffffff] usable ==> reserved
[    0.000000] e820: last_pfn = 0xcecdd max_arch_pfn = 0x400000000
[    0.000000] found SMP MP-table at [mem 0x000fda50-0x000fda5f] mapped at [ffffffffff240a50]
[    0.000000] Base memory trampoline at [ffff8b8f40097000] 97000 size 24576
[    0.000000] Using GB pages for direct mapping
[    0.000000] BRK [0x271611000, 0x271611fff] PGTABLE
[    0.000000] BRK [0x271612000, 0x271612fff] PGTABLE
[    0.000000] BRK [0x271613000, 0x271613fff] PGTABLE
[    0.000000] BRK [0x271614000, 0x271614fff] PGTABLE
[    0.000000] BRK [0x271615000, 0x271615fff] PGTABLE
[    0.000000] BRK [0x271616000, 0x271616fff] PGTABLE
[    0.000000] BRK [0x271617000, 0x271617fff] PGTABLE
[    0.000000] BRK [0x271618000, 0x271618fff] PGTABLE
[    0.000000] BRK [0x271619000, 0x271619fff] PGTABLE
[    0.000000] BRK [0x27161a000, 0x27161afff] PGTABLE
[    0.000000] BRK [0x27161b000, 0x27161bfff] PGTABLE
[    0.000000] BRK [0x27161c000, 0x27161cfff] PGTABLE
[    0.000000] Secure boot disabled
[    0.000000] RAMDISK: [mem 0x371b7000-0x3e5ecfff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000CBFD4000 000024 (v02 DELL  )
[    0.000000] ACPI: XSDT 0x00000000CBFD4098 0000AC (v01 DELL   CBX3     01072009 AMI  00010013)
[    0.000000] ACPI: FACP 0x00000000CBFE6080 00010C (v05 DELL   CBX3     01072009 AMI  00010013)
[    0.000000] ACPI: DSDT 0x00000000CBFD41D0 011EB0 (v02 DELL   CBX3     00000014 INTL 20120711)
[    0.000000] ACPI: FACS 0x00000000CD7FE080 000040
[    0.000000] ACPI: APIC 0x00000000CBFE6190 000092 (v03 DELL   CBX3     01072009 AMI  00010013)
[    0.000000] ACPI: FPDT 0x00000000CBFE6228 000044 (v01 DELL   CBX3     01072009 AMI  00010013)
[    0.000000] ACPI: SLIC 0x00000000CBFE6270 000176 (v03 DELL   CBX3     01072009 MSFT 00010013)
[    0.000000] ACPI: LPIT 0x00000000CBFE63E8 00005C (v01 DELL   CBX3     00000000 AMI. 00000005)
[    0.000000] ACPI: SSDT 0x00000000CBFE6448 000228 (v01 INTEL  sensrhub 00000000 INTL 20120711)
[    0.000000] ACPI: SSDT 0x00000000CBFE6670 000160 (v01 Intel  zpodd    00001000 INTL 20120711)
[    0.000000] ACPI: SSDT 0x00000000CBFE67D0 00051F (v01 PmRef  Cpu0Ist  00003000 INTL 20120711)
[    0.000000] ACPI: SSDT 0x00000000CBFE6CF0 000AD8 (v01 PmRef  CpuPm    00003000 INTL 20120711)
[    0.000000] ACPI: HPET 0x00000000CBFE77C8 000038 (v01 DELL   CBX3     01072009 AMI. 00000005)
[    0.000000] ACPI: SSDT 0x00000000CBFE7800 000447 (v01 SataRe SataTabl 00001000 INTL 20120711)
[    0.000000] ACPI: MCFG 0x00000000CBFE7C48 00003C (v01 DELL   CBX3     01072009 MSFT 00000097)
[    0.000000] ACPI: ASF! 0x00000000CBFE7C88 0000A5 (v32 INTEL   HCG     00000001 TFSM 000F4240)
[    0.000000] ACPI: MSDM 0x00000000CBFE7D30 000055 (v03 DELL   CBX3     06222004 AMI  00010013)
[    0.000000] ACPI: BGRT 0x00000000CBFE7D88 000038 (v00 \xf3\xee              01072009 AMI  00010013)
[    0.000000] ACPI: DMAR 0x00000000CBFE7DC0 000080 (v01 INTEL  HSW      00000001 INTL 00000001)
[    0.000000] ACPI: SSDT 0x00000000CBFE7E40 000B25 (v01 AmdRef AmdTabl  00001000 INTL 20120711)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000082dffffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x82dfd3000-0x82dffdfff]
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000082dffffff]
[    0.000000]   Device   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000004efff]
[    0.000000]   node   0: [mem 0x0000000000050000-0x000000000009efff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x00000000c2f6efff]
[    0.000000]   node   0: [mem 0x00000000c2f76000-0x00000000c3943fff]
[    0.000000]   node   0: [mem 0x00000000c3e1d000-0x00000000cadb2fff]
[    0.000000]   node   0: [mem 0x00000000cb000000-0x00000000cb758fff]
[    0.000000]   node   0: [mem 0x00000000cb800000-0x00000000cbf92fff]
[    0.000000]   node   0: [mem 0x00000000cc000000-0x00000000cd6d3fff]
[    0.000000]   node   0: [mem 0x00000000cd800000-0x00000000cecdcfff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000082dffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000082dffffff]
[    0.000000] On node 0 totalpages: 8373005
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 25 pages reserved
[    0.000000]   DMA zone: 3997 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 13134 pages used for memmap
[    0.000000]   DMA32 zone: 840560 pages, LIFO batch:31
[    0.000000]   Normal zone: 117632 pages used for memmap
[    0.000000]   Normal zone: 7528448 pages, LIFO batch:31
[    0.000000] Reserved but unavailable: 98 pages
[    0.000000] ACPI: PM-Timer IO Port: 0x1808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.000000] smpboot: Allowing 8 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0004f000-0x0004ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xc2f6f000-0xc2f75fff]
[    0.000000] PM: Registered nosave memory: [mem 0xc3944000-0xc3e1cfff]
[    0.000000] PM: Registered nosave memory: [mem 0xc85d8000-0xc85d8fff]
[    0.000000] PM: Registered nosave memory: [mem 0xc85e7000-0xc85e7fff]
[    0.000000] PM: Registered nosave memory: [mem 0xc85e8000-0xc85e8fff]
[    0.000000] PM: Registered nosave memory: [mem 0xc8604000-0xc8604fff]
[    0.000000] PM: Registered nosave memory: [mem 0xcadb3000-0xcaffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xcb759000-0xcb7fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xcbf93000-0xcbffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xcd6d4000-0xcd7fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xcecdd000-0xceffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xcf000000-0xf7ffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xf8000000-0xfbffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfc000000-0xfebfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec01000-0xfecfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed00000-0xfed03fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed04000-0xfed1bfff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed1c000-0xfed1ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed20000-0xfedfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee01000-0xfeffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xff000000-0xffffffff]
[    0.000000] e820: [mem 0xcf000000-0xf7ffffff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.000000] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:1
[    0.000000] percpu: Embedded 38 pages/cpu @ffff8b976dc00000 s118784 r8192 d28672 u262144
[    0.000000] pcpu-alloc: s118784 r8192 d28672 u262144 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 8242150
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-4.15.0-rc1+ root=UUID=c88abf6f-2561-41e5-bec5-c3b2881d0ffc ro rhgb slub_debug=- cgroup_disable=memory console=tty0 console=ttyUSB0,9600n8 nmi_watchdog=0 audit=0 radeon.cik_support=0 amdgpu.cik_support=1 resume=/dev/sda7 i915.enable_rc6=1 i915.semaphores=1 i915.enable_psr=1 i915.enable_fbc=1 drm_kms_helper.poll=0 mce=off amdgpu.dc=1
[    0.000000] audit: disabled (until reboot)
[    0.000000] Memory: 32644336K/33492020K available (8761K kernel code, 1431K rwdata, 3736K rodata, 2032K init, 1288K bss, 847684K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] ftrace: allocating 35735 entries in 140 pages
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	Tasks RCU enabled.
[    0.000000] NR_IRQS: 4352, nr_irqs: 488, preallocated irqs: 16
[    0.000000] 	Offload RCU callbacks from CPUs: .
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] ACPI: Core revision 20170831
[    0.000000] ACPI: 7 ACPI AML tables successfully acquired and loaded
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
[    0.000000] hpet clockevent registered
[    0.000000] APIC: Switch to symmetric I/O mode setup
[    0.000000] DMAR: Host address width 39
[    0.000000] DMAR: DRHD base: 0x000000fed90000 flags: 0x1
[    0.000000] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap d2008c20660462 ecap f010da
[    0.000000] DMAR: RMRR base: 0x000000caf19000 end: 0x000000caf27fff
[    0.000000] DMAR-IR: IOAPIC id 8 under DRHD base  0xfed90000 IOMMU 0
[    0.000000] DMAR-IR: HPET id 0 under DRHD base 0xfed90000
[    0.000000] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
[    0.000000] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.000000] x2apic enabled
[    0.000000] Switched APIC routing to cluster x2apic.
[    0.000000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.005000] tsc: Fast TSC calibration using PIT
[    0.006000] tsc: Detected 2893.331 MHz processor
[    0.006000] Calibrating delay loop (skipped), value calculated using timer frequency.. 5786.66 BogoMIPS (lpj=2893331)
[    0.006000] pid_max: default: 32768 minimum: 301
[    0.006000] Security Framework initialized
[    0.006000] Yama: becoming mindful.
[    0.006000] SELinux:  Initializing.
[    0.006000] SELinux:  Starting in permissive mode
[    0.010189] Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes)
[    0.012003] Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes)
[    0.012081] Mount-cache hash table entries: 65536 (order: 7, 524288 bytes)
[    0.012143] Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes)
[    0.012427] Disabling memory control group subsystem
[    0.012453] CPU: Physical Processor ID: 0
[    0.012454] CPU: Processor Core ID: 0
[    0.012458] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.012460] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
[    0.012463] process: using mwait in idle threads
[    0.012466] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 1024
[    0.012467] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 1024, 1GB 4
[    0.012920] Freeing SMP alternatives memory: 36K
[    0.016567] TSC deadline timer enabled
[    0.016569] smpboot: CPU0: Intel(R) Core(TM) i7-4910MQ CPU @ 2.90GHz (family: 0x6, model: 0x3c, stepping: 0x3)
[    0.016610] Performance Events: PEBS fmt2+, Haswell events, 16-deep LBR, full-width counters, Intel PMU driver.
[    0.016633] ... version:                3
[    0.016634] ... bit width:              48
[    0.016635] ... generic registers:      4
[    0.016636] ... value mask:             0000ffffffffffff
[    0.016637] ... max period:             00007fffffffffff
[    0.016637] ... fixed-purpose events:   3
[    0.016638] ... event mask:             000000070000000f
[    0.016660] Hierarchical SRCU implementation.
[    0.017000] smp: Bringing up secondary CPUs ...
[    0.017000] x86: Booting SMP configuration:
[    0.017000] .... node  #0, CPUs:      #1 #2 #3 #4 #5 #6 #7
[    0.024515] smp: Brought up 1 node, 8 CPUs
[    0.024515] smpboot: Max logical packages: 1
[    0.024515] smpboot: Total of 8 processors activated (46293.29 BogoMIPS)
[    0.025586] devtmpfs: initialized
[    0.025586] x86/mm: Memory block size: 128MB
[    0.026830] PM: Registering ACPI NVS region [mem 0xc2f6f000-0xc2f75fff] (28672 bytes)
[    0.026830] PM: Registering ACPI NVS region [mem 0xcd6d4000-0xcd7fffff] (1228800 bytes)
[    0.026830] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.026830] futex hash table entries: 2048 (order: 5, 131072 bytes)
[    0.027028] pinctrl core: initialized pinctrl subsystem
[    0.027065] RTC time: 22:16:53, date: 11/27/17
[    0.027119] NET: Registered protocol family 16
[    0.027249] cpuidle: using governor menu
[    0.027249] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    0.027249] ACPI: bus type PCI registered
[    0.027249] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.027249] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.027249] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
[    0.027249] pmd_set_huge: Cannot satisfy [mem 0xf8000000-0xf8200000] with a huge-page mapping due to MTRR override.
[    0.027249] PCI: Using configuration type 1 for base access
[    0.027263] core: PMU erratum BJ122, BV98, HSD29 worked around, HT is on
[    0.028552] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.028552] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.028554] ACPI: Added _OSI(Module Device)
[    0.028554] ACPI: Added _OSI(Processor Device)
[    0.028554] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.028554] ACPI: Added _OSI(Processor Aggregator Device)
[    0.028554] ACPI: Executed 2 blocks of module-level executable AML code
[    0.032024] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.035574] ACPI: Dynamic OEM Table Load:
[    0.035579] ACPI: SSDT 0xFFFF8B974950B400 0003D3 (v01 PmRef  Cpu0Cst  00003001 INTL 20120711)
[    0.035786] ACPI: Dynamic OEM Table Load:
[    0.035790] ACPI: SSDT 0xFFFF8B9749555800 0005AA (v01 PmRef  ApIst    00003000 INTL 20120711)
[    0.036018] ACPI: Dynamic OEM Table Load:
[    0.036021] ACPI: SSDT 0xFFFF8B97494F4800 000119 (v01 PmRef  ApCst    00003000 INTL 20120711)
[    0.036990] ACPI: EC: EC started
[    0.036991] ACPI: EC: interrupt blocked
[    0.037964] ACPI: \_SB_.PCI0.LPCB.ECDV: Used as first EC
[    0.037966] ACPI: \_SB_.PCI0.LPCB.ECDV: GPE=0x10, EC_CMD/EC_SC=0x934, EC_DATA=0x930
[    0.037968] ACPI: \_SB_.PCI0.LPCB.ECDV: Used as boot DSDT EC to handle transactions
[    0.037969] ACPI: Interpreter enabled
[    0.037991] ACPI: (supports S0 S3 S4 S5)
[    0.037992] ACPI: Using IOAPIC for interrupt routing
[    0.038011] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.038228] ACPI: Enabled 5 GPEs in block 00 to 3F
[    0.051139] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e])
[    0.051143] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.051289] acpi PNP0A08:00: _OSC: platform does not support [PCIeHotplug PME]
[    0.051361] acpi PNP0A08:00: _OSC: OS now controls [AER PCIeCapability]
[    0.051363] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
[    0.051645] PCI host bridge to bus 0000:00
[    0.051647] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.051649] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.051650] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.051652] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000d3fff window]
[    0.051653] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d7fff window]
[    0.051654] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000dbfff window]
[    0.051656] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000dffff window]
[    0.051657] pci_bus 0000:00: root bus resource [mem 0xd0000000-0xfeafffff window]
[    0.051659] pci_bus 0000:00: root bus resource [bus 00-3e]
[    0.051664] pci 0000:00:00.0: [8086:0c04] type 00 class 0x060000
[    0.051734] pci 0000:00:01.0: [8086:0c01] type 01 class 0x060400
[    0.051758] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.051851] pci 0000:00:14.0: [8086:8c31] type 00 class 0x0c0330
[    0.051869] pci 0000:00:14.0: reg 0x10: [mem 0xf7f20000-0xf7f2ffff 64bit]
[    0.051917] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.051969] pci 0000:00:16.0: [8086:8c3a] type 00 class 0x078000
[    0.051987] pci 0000:00:16.0: reg 0x10: [mem 0xf7f3c000-0xf7f3c00f 64bit]
[    0.052040] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    0.052092] pci 0000:00:16.3: [8086:8c3d] type 00 class 0x070002
[    0.052105] pci 0000:00:16.3: reg 0x10: [io  0xf0a0-0xf0a7]
[    0.052110] pci 0000:00:16.3: reg 0x14: [mem 0xf7f3a000-0xf7f3afff]
[    0.052202] pci 0000:00:19.0: [8086:153a] type 00 class 0x020000
[    0.052217] pci 0000:00:19.0: reg 0x10: [mem 0xf7f00000-0xf7f1ffff]
[    0.052223] pci 0000:00:19.0: reg 0x14: [mem 0xf7f39000-0xf7f39fff]
[    0.052229] pci 0000:00:19.0: reg 0x18: [io  0xf040-0xf05f]
[    0.052276] pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
[    0.052328] pci 0000:00:1a.0: [8086:8c2d] type 00 class 0x0c0320
[    0.052346] pci 0000:00:1a.0: reg 0x10: [mem 0xf7f38000-0xf7f383ff]
[    0.052414] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    0.052469] pci 0000:00:1b.0: [8086:8c20] type 00 class 0x040300
[    0.052485] pci 0000:00:1b.0: reg 0x10: [mem 0xf7f30000-0xf7f33fff 64bit]
[    0.052541] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.052596] pci 0000:00:1c.0: [8086:8c10] type 01 class 0x060400
[    0.052651] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.052727] pci 0000:00:1c.2: [8086:8c14] type 01 class 0x060400
[    0.052783] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    0.052854] pci 0000:00:1c.3: [8086:8c16] type 01 class 0x060400
[    0.052910] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
[    0.052983] pci 0000:00:1c.4: [8086:8c18] type 01 class 0x060400
[    0.053047] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.053122] pci 0000:00:1c.7: [8086:8c1e] type 01 class 0x060400
[    0.053185] pci 0000:00:1c.7: PME# supported from D0 D3hot D3cold
[    0.053258] pci 0000:00:1d.0: [8086:8c26] type 00 class 0x0c0320
[    0.053276] pci 0000:00:1d.0: reg 0x10: [mem 0xf7f37000-0xf7f373ff]
[    0.053345] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.053399] pci 0000:00:1f.0: [8086:8c4f] type 00 class 0x060100
[    0.053538] pci 0000:00:1f.2: [8086:8c03] type 00 class 0x010601
[    0.053551] pci 0000:00:1f.2: reg 0x10: [io  0xf090-0xf097]
[    0.053557] pci 0000:00:1f.2: reg 0x14: [io  0xf080-0xf083]
[    0.053562] pci 0000:00:1f.2: reg 0x18: [io  0xf070-0xf077]
[    0.053567] pci 0000:00:1f.2: reg 0x1c: [io  0xf060-0xf063]
[    0.053573] pci 0000:00:1f.2: reg 0x20: [io  0xf020-0xf03f]
[    0.053579] pci 0000:00:1f.2: reg 0x24: [mem 0xf7f36000-0xf7f367ff]
[    0.053607] pci 0000:00:1f.2: PME# supported from D3hot
[    0.053655] pci 0000:00:1f.3: [8086:8c22] type 00 class 0x0c0500
[    0.053669] pci 0000:00:1f.3: reg 0x10: [mem 0xf7f35000-0xf7f350ff 64bit]
[    0.053685] pci 0000:00:1f.3: reg 0x20: [io  0xf000-0xf01f]
[    0.053772] pci 0000:01:00.0: [1002:6640] type 00 class 0x030000
[    0.053795] pci 0000:01:00.0: reg 0x10: [mem 0xe0000000-0xefffffff 64bit pref]
[    0.053804] pci 0000:01:00.0: reg 0x18: [mem 0xf0000000-0xf07fffff 64bit pref]
[    0.053811] pci 0000:01:00.0: reg 0x20: [io  0xe000-0xe0ff]
[    0.053817] pci 0000:01:00.0: reg 0x24: [mem 0xf7e00000-0xf7e3ffff]
[    0.053823] pci 0000:01:00.0: reg 0x30: [mem 0xf7e40000-0xf7e5ffff pref]
[    0.053833] pci 0000:01:00.0: BAR 0: assigned to efifb
[    0.053876] pci 0000:01:00.0: supports D1 D2
[    0.053877] pci 0000:01:00.0: PME# supported from D1 D2 D3hot
[    0.053923] pci 0000:01:00.1: [1002:aac0] type 00 class 0x040300
[    0.053942] pci 0000:01:00.1: reg 0x10: [mem 0xf7e60000-0xf7e63fff 64bit]
[    0.054012] pci 0000:01:00.1: supports D1 D2
[    0.057014] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.057017] pci 0000:00:01.0:   bridge window [io  0xe000-0xefff]
[    0.057018] pci 0000:00:01.0:   bridge window [mem 0xf7e00000-0xf7efffff]
[    0.057020] pci 0000:00:01.0:   bridge window [mem 0xe0000000-0xf07fffff 64bit pref]
[    0.057067] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.057149] pci 0000:03:00.0: [8086:08b1] type 00 class 0x028000
[    0.057220] pci 0000:03:00.0: reg 0x10: [mem 0xf7d00000-0xf7d01fff 64bit]
[    0.057426] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
[    0.060042] pci 0000:00:1c.2: PCI bridge to [bus 03]
[    0.060047] pci 0000:00:1c.2:   bridge window [mem 0xf7d00000-0xf7dfffff]
[    0.060092] pci 0000:00:1c.3: PCI bridge to [bus 04-07]
[    0.060096] pci 0000:00:1c.3:   bridge window [io  0xd000-0xdfff]
[    0.060099] pci 0000:00:1c.3:   bridge window [mem 0xf7200000-0xf7bfffff]
[    0.060103] pci 0000:00:1c.3:   bridge window [mem 0xf1300000-0xf1cfffff 64bit pref]
[    0.060144] pci 0000:00:1c.4: PCI bridge to [bus 08]
[    0.060148] pci 0000:00:1c.4:   bridge window [io  0xc000-0xcfff]
[    0.060151] pci 0000:00:1c.4:   bridge window [mem 0xf6800000-0xf71fffff]
[    0.060155] pci 0000:00:1c.4:   bridge window [mem 0xf0900000-0xf12fffff 64bit pref]
[    0.060279] pci 0000:09:00.0: [1217:8520] type 00 class 0x080501
[    0.060308] pci 0000:09:00.0: reg 0x10: [mem 0xf7c01000-0xf7c01fff]
[    0.060319] pci 0000:09:00.0: reg 0x14: [mem 0xf7c00000-0xf7c007ff]
[    0.060438] pci 0000:09:00.0: PME# supported from D3hot D3cold
[    0.063087] pci 0000:00:1c.7: PCI bridge to [bus 09]
[    0.063093] pci 0000:00:1c.7:   bridge window [mem 0xf7c00000-0xf7cfffff]
[    0.064326] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.064377] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *10 11 12 14 15)
[    0.064426] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 *10 11 12 14 15)
[    0.064475] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 10 11 12 14 15)
[    0.064528] ACPI: PCI Interrupt Link [LNKE] (IRQs *3 4 5 6 10 11 12 14 15)
[    0.064560] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 *5 6 10 11 12 14 15)
[    0.064593] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.064629] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.066058] ACPI: EC: interrupt unblocked
[    0.066069] ACPI: EC: event unblocked
[    0.066084] ACPI: \_SB_.PCI0.LPCB.ECDV: GPE=0x10, EC_CMD/EC_SC=0x934, EC_DATA=0x930
[    0.066085] ACPI: \_SB_.PCI0.LPCB.ECDV: Used as boot DSDT EC to handle transactions and events
[    0.066120] pci 0000:01:00.0: vgaarb: setting as boot VGA device
[    0.066120] pci 0000:01:00.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.066120] pci 0000:01:00.0: vgaarb: bridge control possible
[    0.066120] vgaarb: loaded
[    0.066120] SCSI subsystem initialized
[    0.066120] libata version 3.00 loaded.
[    0.066120] ACPI: bus type USB registered
[    0.066120] usbcore: registered new interface driver usbfs
[    0.066120] usbcore: registered new interface driver hub
[    0.066120] usbcore: registered new device driver usb
[    0.066135] EDAC MC: Ver: 3.0.0
[    0.066147] Registered efivars operations
[    0.069110] PCI: Using ACPI for IRQ routing
[    0.070191] PCI: pci_cache_line_size set to 64 bytes
[    0.070336] e820: reserve RAM buffer [mem 0x0004f000-0x0004ffff]
[    0.070337] e820: reserve RAM buffer [mem 0x0009f000-0x0009ffff]
[    0.070337] e820: reserve RAM buffer [mem 0xc2f6f000-0xc3ffffff]
[    0.070338] e820: reserve RAM buffer [mem 0xc3944000-0xc3ffffff]
[    0.070338] e820: reserve RAM buffer [mem 0xc85d8018-0xcbffffff]
[    0.070339] e820: reserve RAM buffer [mem 0xc85e8018-0xcbffffff]
[    0.070340] e820: reserve RAM buffer [mem 0xcadb3000-0xcbffffff]
[    0.070341] e820: reserve RAM buffer [mem 0xcb759000-0xcbffffff]
[    0.070341] e820: reserve RAM buffer [mem 0xcbf93000-0xcbffffff]
[    0.070342] e820: reserve RAM buffer [mem 0xcd6d4000-0xcfffffff]
[    0.070343] e820: reserve RAM buffer [mem 0xcecdd000-0xcfffffff]
[    0.070343] e820: reserve RAM buffer [mem 0x82e000000-0x82fffffff]
[    0.070407] NetLabel: Initializing
[    0.070409] NetLabel:  domain hash size = 128
[    0.070410] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.070420] NetLabel:  unlabeled traffic allowed by default
[    0.071083] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.071087] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    0.074017] clocksource: Switched to clocksource hpet
[    0.081348] VFS: Disk quotas dquot_6.6.0
[    0.081361] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.081401] pnp: PnP ACPI init
[    0.081452] system 00:00: [mem 0xfed40000-0xfed44fff] has been reserved
[    0.081456] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.081565] system 00:01: [io  0x0680-0x069f] has been reserved
[    0.081567] system 00:01: [io  0xffff] has been reserved
[    0.081568] system 00:01: [io  0xffff] has been reserved
[    0.081570] system 00:01: [io  0xffff] has been reserved
[    0.081571] system 00:01: [io  0x1c00-0x1cfe] has been reserved
[    0.081572] system 00:01: [io  0x1d00-0x1dfe] has been reserved
[    0.081574] system 00:01: [io  0x1e00-0x1efe] has been reserved
[    0.081575] system 00:01: [io  0x1f00-0x1ffe] has been reserved
[    0.081576] system 00:01: [io  0x1800-0x18fe] has been reserved
[    0.081578] system 00:01: [io  0x164e-0x164f] has been reserved
[    0.081580] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.081590] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.081615] system 00:03: [io  0x1854-0x1857] has been reserved
[    0.081617] system 00:03: Plug and Play ACPI device, IDs INT3f0d PNP0c02 (active)
[    0.081641] system 00:04: [io  0x04d0-0x04d1] has been reserved
[    0.081643] system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.081659] pnp 00:05: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.081668] pnp 00:06: Plug and Play ACPI device, IDs DLL05cd PNP0f13 (active)
[    0.082140] pnp 00:07: Plug and Play ACPI device, IDs PNP0401 (disabled)
[    0.082548] system 00:08: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.082550] system 00:08: [mem 0xfed10000-0xfed17fff] has been reserved
[    0.082552] system 00:08: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.082554] system 00:08: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.082555] system 00:08: [mem 0xf8000000-0xfbffffff] has been reserved
[    0.082557] system 00:08: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.082559] system 00:08: [mem 0xfed90000-0xfed93fff] could not be reserved
[    0.082561] system 00:08: [mem 0xfed45000-0xfed8ffff] has been reserved
[    0.082562] system 00:08: [mem 0xff000000-0xffffffff] has been reserved
[    0.082564] system 00:08: [mem 0xfee00000-0xfeefffff] could not be reserved
[    0.082565] system 00:08: [mem 0xf7fdf000-0xf7fdffff] has been reserved
[    0.082567] system 00:08: [mem 0xf7fe0000-0xf7feffff] has been reserved
[    0.082570] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.084319] pnp: PnP ACPI: found 9 devices
[    0.090374] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.090408] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.090410] pci 0000:00:01.0:   bridge window [io  0xe000-0xefff]
[    0.090412] pci 0000:00:01.0:   bridge window [mem 0xf7e00000-0xf7efffff]
[    0.090414] pci 0000:00:01.0:   bridge window [mem 0xe0000000-0xf07fffff 64bit pref]
[    0.090417] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.090426] pci 0000:00:1c.2: PCI bridge to [bus 03]
[    0.090430] pci 0000:00:1c.2:   bridge window [mem 0xf7d00000-0xf7dfffff]
[    0.090437] pci 0000:00:1c.3: PCI bridge to [bus 04-07]
[    0.090439] pci 0000:00:1c.3:   bridge window [io  0xd000-0xdfff]
[    0.090443] pci 0000:00:1c.3:   bridge window [mem 0xf7200000-0xf7bfffff]
[    0.090446] pci 0000:00:1c.3:   bridge window [mem 0xf1300000-0xf1cfffff 64bit pref]
[    0.090452] pci 0000:00:1c.4: PCI bridge to [bus 08]
[    0.090454] pci 0000:00:1c.4:   bridge window [io  0xc000-0xcfff]
[    0.090458] pci 0000:00:1c.4:   bridge window [mem 0xf6800000-0xf71fffff]
[    0.090461] pci 0000:00:1c.4:   bridge window [mem 0xf0900000-0xf12fffff 64bit pref]
[    0.090467] pci 0000:00:1c.7: PCI bridge to [bus 09]
[    0.090471] pci 0000:00:1c.7:   bridge window [mem 0xf7c00000-0xf7cfffff]
[    0.090479] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.090479] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.090480] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.090480] pci_bus 0000:00: resource 7 [mem 0x000d0000-0x000d3fff window]
[    0.090481] pci_bus 0000:00: resource 8 [mem 0x000d4000-0x000d7fff window]
[    0.090482] pci_bus 0000:00: resource 9 [mem 0x000d8000-0x000dbfff window]
[    0.090482] pci_bus 0000:00: resource 10 [mem 0x000dc000-0x000dffff window]
[    0.090483] pci_bus 0000:00: resource 11 [mem 0xd0000000-0xfeafffff window]
[    0.090484] pci_bus 0000:01: resource 0 [io  0xe000-0xefff]
[    0.090484] pci_bus 0000:01: resource 1 [mem 0xf7e00000-0xf7efffff]
[    0.090485] pci_bus 0000:01: resource 2 [mem 0xe0000000-0xf07fffff 64bit pref]
[    0.090485] pci_bus 0000:03: resource 1 [mem 0xf7d00000-0xf7dfffff]
[    0.090486] pci_bus 0000:04: resource 0 [io  0xd000-0xdfff]
[    0.090487] pci_bus 0000:04: resource 1 [mem 0xf7200000-0xf7bfffff]
[    0.090487] pci_bus 0000:04: resource 2 [mem 0xf1300000-0xf1cfffff 64bit pref]
[    0.090488] pci_bus 0000:08: resource 0 [io  0xc000-0xcfff]
[    0.090488] pci_bus 0000:08: resource 1 [mem 0xf6800000-0xf71fffff]
[    0.090489] pci_bus 0000:08: resource 2 [mem 0xf0900000-0xf12fffff 64bit pref]
[    0.090490] pci_bus 0000:09: resource 1 [mem 0xf7c00000-0xf7cfffff]
[    0.090573] NET: Registered protocol family 2
[    0.090718] TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.090945] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.091053] TCP: Hash tables configured (established 262144 bind 65536)
[    0.091085] UDP hash table entries: 16384 (order: 7, 524288 bytes)
[    0.091145] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes)
[    0.091226] NET: Registered protocol family 1
[    0.091609] pci 0000:01:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.091701] PCI: CLS 64 bytes, default 64
[    0.091723] Unpacking initramfs...
[    1.409684] Freeing initrd memory: 119000K
[    1.409745] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    1.409748] software IO TLB [mem 0xbbe3f000-0xbfe3f000] (64MB) mapped at [ffff8b8ffbe3f000-ffff8b8fffe3efff]
[    1.411034] Initialise system trusted keyrings
[    1.411043] Key type blacklist registered
[    1.411084] workingset: timestamp_bits=36 max_order=23 bucket_order=0
[    1.411836] zbud: loaded
[    1.412243] SELinux:  Registering netfilter hooks
[    1.523844] NET: Registered protocol family 38
[    1.523848] Key type asymmetric registered
[    1.523850] Asymmetric key parser 'x509' registered
[    1.523882] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 247)
[    1.523920] io scheduler noop registered
[    1.523922] io scheduler deadline registered
[    1.523957] io scheduler cfq registered (default)
[    1.523959] io scheduler mq-deadline registered
[    1.524045] atomic64_test: passed for x86-64 platform with CX8 and with SSE
[    1.524739] efifb: probing for efifb
[    1.524757] efifb: framebuffer at 0xe0000000, using 9000k, total 9000k
[    1.524759] efifb: mode is 1920x1200x32, linelength=7680, pages=1
[    1.524760] efifb: scrolling: redraw
[    1.524762] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    1.528207] Console: switching to colour frame buffer device 240x75
[    1.531374] fb0: EFI VGA frame buffer device
[    1.531390] intel_idle: MWAIT substates: 0x42120
[    1.531390] intel_idle: v0.4.1 model 0x3C
[    1.531604] intel_idle: lapic_timer_reliable_states 0xffffffff
[    1.532066] ACPI: AC Adapter [AC] (on-line)
[    1.532115] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input0
[    1.532151] ACPI: Lid Switch [LID0]
[    1.532176] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
[    1.532207] ACPI: Power Button [PBTN]
[    1.532229] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input2
[    1.532269] ACPI: Sleep Button [SBTN]
[    1.532298] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[    1.532329] ACPI: Power Button [PWRF]
[    1.532977] (NULL device *): hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
[    1.533224] thermal LNXTHERM:00: registered as thermal_zone0
[    1.533241] ACPI: Thermal Zone [THM] (25 C)
[    1.533396] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    1.534695] serial 0000:00:16.3: enabling device (0000 -> 0003)
[    1.555264] 0000:00:16.3: ttyS4 at I/O 0xf0a0 (irq = 19, base_baud = 115200) is a 16550A
[    1.556063] Non-volatile memory driver v1.3
[    1.556152] Linux agpgart interface v0.103
[    1.556676] ahci 0000:00:1f.2: version 3.0
[    1.556871] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps 0x23 impl SATA mode
[    1.556894] ahci 0000:00:1f.2: flags: 64bit ncq ilck pm led clo pio slum part ems apst 
[    1.563504] scsi host0: ahci
[    1.563672] scsi host1: ahci
[    1.563798] scsi host2: ahci
[    1.563883] scsi host3: ahci
[    1.563956] scsi host4: ahci
[    1.564053] scsi host5: ahci
[    1.564098] ata1: SATA max UDMA/133 abar m2048@0xf7f36000 port 0xf7f36100 irq 25
[    1.564126] ata2: SATA max UDMA/133 abar m2048@0xf7f36000 port 0xf7f36180 irq 25
[    1.564149] ata3: DUMMY
[    1.564157] ata4: DUMMY
[    1.564165] ata5: DUMMY
[    1.564179] ata6: SATA max UDMA/133 abar m2048@0xf7f36000 port 0xf7f36380 irq 25
[    1.564244] libphy: Fixed MDIO Bus: probed
[    1.564296] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.564317] ehci-pci: EHCI PCI platform driver
[    1.564417] ehci-pci 0000:00:1a.0: EHCI Host Controller
[    1.564468] ehci-pci 0000:00:1a.0: new USB bus registered, assigned bus number 1
[    1.564504] ehci-pci 0000:00:1a.0: debug port 2
[    1.567929] ACPI: Battery Slot [BAT0] (battery present)
[    1.568424] ehci-pci 0000:00:1a.0: cache line size of 64 is not supported
[    1.568433] ehci-pci 0000:00:1a.0: irq 16, io mem 0xf7f38000
[    1.569210] ACPI: Battery Slot [BAT1] (battery absent)
[    1.575022] ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[    1.575068] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    1.575089] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.575111] usb usb1: Product: EHCI Host Controller
[    1.576070] usb usb1: Manufacturer: Linux 4.15.0-rc1+ ehci_hcd
[    1.576893] usb usb1: SerialNumber: 0000:00:1a.0
[    1.577906] hub 1-0:1.0: USB hub found
[    1.578705] hub 1-0:1.0: 3 ports detected
[    1.579562] ehci-pci 0000:00:1d.0: EHCI Host Controller
[    1.580245] ehci-pci 0000:00:1d.0: new USB bus registered, assigned bus number 2
[    1.580990] ehci-pci 0000:00:1d.0: debug port 2
[    1.585605] ehci-pci 0000:00:1d.0: cache line size of 64 is not supported
[    1.585613] ehci-pci 0000:00:1d.0: irq 21, io mem 0xf7f37000
[    1.593041] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    1.593977] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[    1.594882] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.595619] usb usb2: Product: EHCI Host Controller
[    1.596349] usb usb2: Manufacturer: Linux 4.15.0-rc1+ ehci_hcd
[    1.597074] usb usb2: SerialNumber: 0000:00:1d.0
[    1.597851] hub 2-0:1.0: USB hub found
[    1.598582] hub 2-0:1.0: 3 ports detected
[    1.599392] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.600134] ohci-pci: OHCI PCI platform driver
[    1.600861] uhci_hcd: USB Universal Host Controller Interface driver
[    1.601685] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.602461] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 3
[    1.604288] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x00009810
[    1.605033] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
[    1.605130] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
[    1.605864] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.606606] usb usb3: Product: xHCI Host Controller
[    1.607342] usb usb3: Manufacturer: Linux 4.15.0-rc1+ xhci-hcd
[    1.608081] usb usb3: SerialNumber: 0000:00:14.0
[    1.608860] hub 3-0:1.0: USB hub found
[    1.609597] hub 3-0:1.0: 15 ports detected
[    1.611852] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.612519] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 4
[    1.613248] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003
[    1.613941] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.614638] usb usb4: Product: xHCI Host Controller
[    1.615329] usb usb4: Manufacturer: Linux 4.15.0-rc1+ xhci-hcd
[    1.615998] usb usb4: SerialNumber: 0000:00:14.0
[    1.616715] hub 4-0:1.0: USB hub found
[    1.617383] hub 4-0:1.0: 6 ports detected
[    1.618388] usbcore: registered new interface driver usbserial_generic
[    1.619050] usbserial: USB Serial support registered for generic
[    1.619712] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    1.621001] i8042: Warning: Keylock active
[    1.624248] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.624892] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.625675] mousedev: PS/2 mouse device common for all mice
[    1.626592] rtc_cmos 00:02: RTC can wake from S4
[    1.627437] rtc_cmos 00:02: rtc core: registered rtc_cmos as rtc0
[    1.628130] rtc_cmos 00:02: alarms up to one month, y3k, 242 bytes nvram, hpet irqs
[    1.628293] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input4
[    1.630353] device-mapper: uevent: version 1.0.3
[    1.631081] device-mapper: ioctl: 4.37.0-ioctl (2017-09-20) initialised: dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
[    1.631903] intel_pstate: Intel P-state driver initializing
[    1.633949] hidraw: raw HID events driver (C) Jiri Kosina
[    1.637131] usbcore: registered new interface driver usbhid
[    1.640503] usbhid: USB HID core driver
[    1.643928] drop_monitor: Initializing network drop monitor service
[    1.647372] ip_tables: (C) 2000-2006 Netfilter Core Team
[    1.648331] Initializing XFRM netlink socket
[    1.649256] NET: Registered protocol family 10
[    1.651681] Segment Routing with IPv6
[    1.652377] mip6: Mobile IPv6
[    1.653276] NET: Registered protocol family 17
[    1.654090] mce: Unable to init MCE device (rc: -5)
[    1.654959] RAS: Correctable Errors collector initialized.
[    1.655709] microcode: sig=0x306c3, pf=0x10, revision=0x22
[    1.656621] microcode: Microcode Update Driver: v2.2.
[    1.656626] AVX2 version of gcm_enc/dec engaged.
[    1.657965] AES CTR mode by8 optimization enabled
[    1.667659] sched_clock: Marking stable (1667656567, 0)->(1676055218, -8398651)
[    1.668743] registered taskstats version 1
[    1.669617] Loading compiled-in X.509 certificates
[    1.701084] Loaded X.509 cert 'Build time autogenerated kernel key: 32d96690a282f0be84f4f3e57ec6a2a1d66d1e1f'
[    1.701716] zswap: loaded using pool lzo/zbud
[    1.705066] Key type big_key registered
[    1.707020] Key type encrypted registered
[    1.708186]   Magic number: 9:116:301
[    1.708830] tty tty30: hash matches
[    1.709659] rtc_cmos 00:02: setting system clock to 2017-11-27 22:16:55 UTC (1511821015)
[    1.869759] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.871563] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    1.872783] ata6: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.874159] ata2.00: ATAPI: PLDS DVD+/-RW DU-8A5LH, DD11, max UDMA/133
[    1.875223] ata1.00: supports DRM functions and may not be fully accessible
[    1.876915] ata2.00: configured for UDMA/133
[    1.878488] ata1.00: disabling queued TRIM support
[    1.878490] ata1.00: ATA-9: Samsung SSD 850 PRO 1TB, EXM04B6Q, max UDMA/133
[    1.879761] ata1.00: 2000409264 sectors, multi 1: LBA48 NCQ (depth 31/32), AA
[    1.883569] ata1.00: supports DRM functions and may not be fully accessible
[    1.885398] ata1.00: disabling queued TRIM support
[    1.887481] ata1.00: configured for UDMA/133
[    1.888641] scsi 0:0:0:0: Direct-Access     ATA      Samsung SSD 850  4B6Q PQ: 0 ANSI: 5
[    1.889827] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    1.890074] sd 0:0:0:0: [sda] 2000409264 512-byte logical blocks: (1.02 TB/954 GiB)
[    1.890113] sd 0:0:0:0: [sda] Write Protect is off
[    1.890114] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.890198] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.891920]  sda: sda1 sda2 sda3 sda4
[    1.892738] sd 0:0:0:0: [sda] supports TCG Opal
[    1.892739] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.896406] scsi 1:0:0:0: CD-ROM            PLDS     DVD+-RW DU-8A5LH DD11 PQ: 0 ANSI: 5
[    1.905024] usb 1-1: new high-speed USB device number 2 using ehci-pci
[    1.911424] sr 1:0:0:0: [sr0] scsi3-mmc drive: 31x/62x writer dvd-ram cd/rw xa/form2 cdda tray
[    1.912404] cdrom: Uniform CD-ROM driver Revision: 3.20
[    1.913334] sr 1:0:0:0: Attached scsi CD-ROM sr0
[    1.913399] sr 1:0:0:0: Attached scsi generic sg1 type 5
[    1.919270] ata6.00: ACPI cmd ef/10:06:00:00:00:00 (SET FEATURES) succeeded
[    1.919272] ata6.00: ACPI cmd f5/00:00:00:00:00:00 (SECURITY FREEZE LOCK) filtered out
[    1.920516] ata6.00: ACPI cmd b1/c1:00:00:00:00:00 (DEVICE CONFIGURATION OVERLAY) filtered out
[    1.921013] usb 2-1: new high-speed USB device number 2 using ehci-pci
[    1.937016] usb 3-1: new full-speed USB device number 2 using xhci_hcd
[    1.963702] ata6.00: ATA-9: ST1000LM014-1EJ164, DEMA, max UDMA/133
[    1.965005] ata6.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    2.008081] ata6.00: ACPI cmd ef/10:06:00:00:00:00 (SET FEATURES) succeeded
[    2.008083] ata6.00: ACPI cmd f5/00:00:00:00:00:00 (SECURITY FREEZE LOCK) filtered out
[    2.009409] ata6.00: ACPI cmd b1/c1:00:00:00:00:00 (DEVICE CONFIGURATION OVERLAY) filtered out
[    2.034382] usb 1-1: New USB device found, idVendor=8087, idProduct=8008
[    2.035695] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.037280] hub 1-1:1.0: USB hub found
[    2.038624] hub 1-1:1.0: 6 ports detected
[    2.051379] usb 2-1: New USB device found, idVendor=8087, idProduct=8000
[    2.052472] ata6.00: configured for UDMA/133
[    2.052674] scsi 5:0:0:0: Direct-Access     ATA      ST1000LM014-1EJ1 DEMA PQ: 0 ANSI: 5
[    2.052944] sd 5:0:0:0: Attached scsi generic sg2 type 0
[    2.053146] sd 5:0:0:0: [sdb] 1953525168 512-byte logical blocks: (1.00 TB/932 GiB)
[    2.053148] sd 5:0:0:0: [sdb] 4096-byte physical blocks
[    2.053191] sd 5:0:0:0: [sdb] Write Protect is off
[    2.053193] sd 5:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    2.053285] sd 5:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.057212]  sdb: sdb1 sdb2
[    2.057909] sd 5:0:0:0: [sdb] Attached SCSI disk
[    2.061093] usb 2-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.061989] hub 2-1:1.0: USB hub found
[    2.062870] hub 2-1:1.0: 8 ports detected
[    2.092101] usb 3-1: New USB device found, idVendor=046d, idProduct=0a44
[    2.093402] usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.094701] usb 3-1: Product: Logitech USB Headset
[    2.096003] usb 3-1: Manufacturer: Logitech
[    2.099289] input: Logitech Logitech USB Headset as /devices/pci0000:00/0000:00:14.0/usb3/3-1/3-1:1.3/0003:046D:0A44.0001/input/input7
[    2.152121] hid-generic 0003:046D:0A44.0001: input,hidraw0: USB HID v1.00 Device [Logitech Logitech USB Headset] on usb-0000:00:14.0-1/input3
[    2.267006] usb 3-5: new full-speed USB device number 3 using xhci_hcd
[    2.311011] usb 1-1.5: new high-speed USB device number 3 using ehci-pci
[    2.394348] usb 3-5: New USB device found, idVendor=0557, idProduct=7000
[    2.395970] usb 3-5: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.397940] hub 3-5:1.0: USB hub found
[    2.399624] hub 3-5:1.0: 4 ports detected
[    2.463037] tsc: Refined TSC clocksource calibration: 2893.312 MHz
[    2.464638] usb 1-1.5: New USB device found, idVendor=0c45, idProduct=64d0
[    2.464639] usb 1-1.5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
[    2.464640] usb 1-1.5: Product: Laptop_Integrated_Webcam_HD
[    2.464641] usb 1-1.5: Manufacturer: CN0767N9724874ATB1GHA01
[    2.471004] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x29b494ed163, max_idle_ns: 440795232905 ns
[    2.671090] usb 3-5.1: new low-speed USB device number 4 using xhci_hcd
[    2.809475] usb 3-5.1: New USB device found, idVendor=0557, idProduct=2213
[    2.811157] usb 3-5.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.812793] usb 3-5.1: Product: CS-1734A V4.3.421
[    2.814409] usb 3-5.1: Manufacturer: ATEN
[    2.843546] input: ATEN CS-1734A V4.3.421 as /devices/pci0000:00/0000:00:14.0/usb3/3-5/3-5.1/3-5.1:1.0/0003:0557:2213.0002/input/input8
[    2.897329] hid-generic 0003:0557:2213.0002: input,hidraw1: USB HID v1.00 Keyboard [ATEN CS-1734A V4.3.421] on usb-0000:00:14.0-5.1/input0
[    2.917898] input: ATEN CS-1734A V4.3.421 as /devices/pci0000:00/0000:00:14.0/usb3/3-5/3-5.1/3-5.1:1.1/0003:0557:2213.0003/input/input9
[    2.921018] hid-generic 0003:0557:2213.0003: input,hidraw2: USB HID v1.00 Mouse [ATEN CS-1734A V4.3.421] on usb-0000:00:14.0-5.1/input1
[    2.982024] input: AlpsPS/2 ALPS DualPoint Stick as /devices/platform/i8042/serio1/input/input10
[    2.987093] usb 3-5.2: new full-speed USB device number 5 using xhci_hcd
[    2.996387] input: AlpsPS/2 ALPS DualPoint TouchPad as /devices/platform/i8042/serio1/input/input6
[    3.004112] PM: Image not found (code -6)
[    3.006457] Freeing unused kernel memory: 2032K
[    3.008264] Write protecting the kernel read-only data: 14336k
[    3.010511] Freeing unused kernel memory: 1456K
[    3.013299] Freeing unused kernel memory: 360K
[    3.018554] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    3.019435] rodata_test: all tests were successful
[    3.066183] usb 3-5.2: New USB device found, idVendor=1532, idProduct=021a
[    3.068371] usb 3-5.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.070754] usb 3-5.2: Product: Razer BlackWidow X Tournament Edition Chroma
[    3.072174] usb 3-5.2: Manufacturer: Razer
[    3.074522] input: Razer Razer BlackWidow X Tournament Edition Chroma as /devices/pci0000:00/0000:00:14.0/usb3/3-5/3-5.2/3-5.2:1.0/0003:1532:021A.0004/input/input11
[    3.127208] hid-generic 0003:1532:021A.0004: input,hidraw3: USB HID v1.11 Keyboard [Razer Razer BlackWidow X Tournament Edition Chroma] on usb-0000:00:14.0-5.2/input0
[    3.129016] input: Razer Razer BlackWidow X Tournament Edition Chroma as /devices/pci0000:00/0000:00:14.0/usb3/3-5/3-5.2/3-5.2:1.1/0003:1532:021A.0005/input/input12
[    3.181101] hid-generic 0003:1532:021A.0005: input,hidraw4: USB HID v1.11 Keyboard [Razer Razer BlackWidow X Tournament Edition Chroma] on usb-0000:00:14.0-5.2/input1
[    3.182919] input: Razer Razer BlackWidow X Tournament Edition Chroma as /devices/pci0000:00/0000:00:14.0/usb3/3-5/3-5.2/3-5.2:1.2/0003:1532:021A.0006/input/input13
[    3.184242] hid-generic 0003:1532:021A.0006: input,hidraw5: USB HID v1.11 Mouse [Razer Razer BlackWidow X Tournament Edition Chroma] on usb-0000:00:14.0-5.2/input2
[    3.249007] usb 3-5.3: new full-speed USB device number 6 using xhci_hcd
[    3.270954] pps_core: LinuxPPS API ver. 1 registered
[    3.272900] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
[    3.283144] PTP clock support registered
[    3.297389] sdhci: Secure Digital Host Controller Interface driver
[    3.299347] sdhci: Copyright(c) Pierre Ossman
[    3.310131] sdhci-pci 0000:09:00.0: SDHCI controller found [1217:8520] (rev 1)
[    3.312092] mmc0: Unknown controller version (3). You may experience problems.
[    3.313886] mmc0: SDHCI controller on PCI [0000:09:00.0] using ADMA
[    3.325456] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    3.326502] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    3.326656] e1000e 0000:00:19.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[    3.353357] usb 3-5.3: New USB device found, idVendor=1b1c, idProduct=1b12
[    3.354793] usb 3-5.3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.356772] usb 3-5.3: Product: Corsair M65 RGB Gaming Mouse
[    3.358716] usb 3-5.3: Manufacturer: Corsair
[    3.360625] usb 3-5.3: SerialNumber: 0801A018AEA8A0C554E314EEF5001945
[    3.363749] input: Corsair Corsair M65 RGB Gaming Mouse as /devices/pci0000:00/0000:00:14.0/usb3/3-5/3-5.3/3-5.3:1.0/0003:1B1C:1B12.0007/input/input14
[    3.365765] hid-generic 0003:1B1C:1B12.0007: input,hidraw6: USB HID v1.11 Mouse [Corsair Corsair M65 RGB Gaming Mouse] on usb-0000:00:14.0-5.3/input0
[    3.368600] input: Corsair Corsair M65 RGB Gaming Mouse as /devices/pci0000:00/0000:00:14.0/usb3/3-5/3-5.3/3-5.3:1.1/0003:1B1C:1B12.0008/input/input15
[    3.414272] e1000e 0000:00:19.0 0000:00:19.0 (uninitialized): registered PHC clock
[    3.423080] hid-generic 0003:1B1C:1B12.0008: input,hiddev96,hidraw7: USB HID v1.11 Mouse [Corsair Corsair M65 RGB Gaming Mouse] on usb-0000:00:14.0-5.3/input1
[    3.424243] usbhid 3-5.3:1.2: couldn't find an input interrupt endpoint
[    4.381771] clocksource: Switched to clocksource tsc
[    4.389727] e1000e 0000:00:19.0 eth0: (PCI Express:2.5GT/s:Width x1) 34:e6:d7:29:a8:f0
[    4.391413] e1000e 0000:00:19.0 eth0: Intel(R) PRO/1000 Network Connection
[    4.393069] e1000e 0000:00:19.0 eth0: MAC: 11, PHY: 12, PBA No: FFFFFF-0FF
[    4.395682] e1000e 0000:00:19.0 eno1: renamed from eth0
[    4.396973] [drm] amdgpu kernel modesetting enabled.
[    4.400285] AMD IOMMUv2 driver by Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
[    4.401343] AMD IOMMUv2 functionality not available on this system
[    4.426591] CRAT table not found
[    4.427729] Finished initializing topology ret=0
[    4.428798] kfd kfd: Initialized module
[    4.429961] checking generic (e0000000 8ca000) vs hw (e0000000 10000000)
[    4.429962] fb: switching to amdgpudrmfb from EFI VGA
[    4.431025] Console: switching to colour dummy device 80x25
[    4.431311] [drm] initializing kernel modesetting (BONAIRE 0x1002:0x6640 0x1028:0x15CD 0x00).
[    4.431325] [drm] register mmio base: 0xF7E00000
[    4.431326] [drm] register mmio size: 262144
[    4.431333] [drm] probing gen 2 caps for device 8086:c01 = 261ad03/e
[    4.431334] [drm] probing mlw for device 8086:c01 = 261ad03
[    4.431406] resource sanity check: requesting [mem 0x000c0000-0x000dffff], which spans more than PCI Bus 0000:00 [mem 0x000d0000-0x000d3fff window]
[    4.431411] caller pci_map_rom+0x58/0xe0 mapping multiple BARs
[    4.431413] amdgpu 0000:01:00.0: Invalid PCI ROM header signature: expecting 0xaa55, got 0xffff
[    4.431444] ATOM BIOS: BR44934.001
[    4.431451] [drm] GPU post is not needed
[    4.431452] [drm] Changing default dispclk from 600Mhz to 625Mhz
[    4.431465] [drm] vm size is 64 GB, block size is 13-bit, fragment size is 9-bit
[    4.431502] amdgpu 0000:01:00.0: VRAM: 2048M 0x000000F400000000 - 0x000000F47FFFFFFF (2048M used)
[    4.431504] amdgpu 0000:01:00.0: GTT: 1024M 0x0000000000000000 - 0x000000003FFFFFFF
[    4.431507] [drm] Detected VRAM RAM=2048M, BAR=256M
[    4.431508] [drm] RAM width 128bits GDDR5
[    4.431621] [TTM] Zone  kernel: Available graphics memory: 16440300 kiB
[    4.431623] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[    4.431625] [TTM] Initializing pool allocator
[    4.431627] [TTM] Initializing DMA pool allocator
[    4.431641] [drm] amdgpu: 2048M of VRAM memory ready
[    4.431642] [drm] amdgpu: 3072M of GTT memory ready.
[    4.431652] [drm] GART: num cpu pages 262144, num gpu pages 262144
[    4.432158] [drm] PCIE GART of 1024M enabled (table at 0x000000F400040000).
[    4.432208] amdgpu 0000:01:00.0: amdgpu: using MSI.
[    4.432226] [drm] amdgpu: irq initialized.
[    4.432267] [drm] Internal thermal controller without fan control
[    4.432282] [drm] amdgpu: dpm initialized
[    4.432414] amdgpu 0000:01:00.0: fence driver on ring 0 use gpu addr 0x0000000000400080, cpu addr 0xffffb8194341e080
[    4.432463] amdgpu 0000:01:00.0: fence driver on ring 1 use gpu addr 0x0000000000400100, cpu addr 0xffffb8194341e100
[    4.432500] amdgpu 0000:01:00.0: fence driver on ring 2 use gpu addr 0x0000000000400180, cpu addr 0xffffb8194341e180
[    4.432538] amdgpu 0000:01:00.0: fence driver on ring 3 use gpu addr 0x0000000000400200, cpu addr 0xffffb8194341e200
[    4.432567] amdgpu 0000:01:00.0: fence driver on ring 4 use gpu addr 0x0000000000400280, cpu addr 0xffffb8194341e280
[    4.432593] amdgpu 0000:01:00.0: fence driver on ring 5 use gpu addr 0x0000000000400300, cpu addr 0xffffb8194341e300
[    4.432614] amdgpu 0000:01:00.0: fence driver on ring 6 use gpu addr 0x0000000000400380, cpu addr 0xffffb8194341e380
[    4.432632] amdgpu 0000:01:00.0: fence driver on ring 7 use gpu addr 0x0000000000400400, cpu addr 0xffffb8194341e400
[    4.432648] amdgpu 0000:01:00.0: fence driver on ring 8 use gpu addr 0x0000000000400480, cpu addr 0xffffb8194341e480
[    4.432691] amdgpu 0000:01:00.0: fence driver on ring 9 use gpu addr 0x0000000000400500, cpu addr 0xffffb8194341e500
[    4.432708] amdgpu 0000:01:00.0: fence driver on ring 10 use gpu addr 0x0000000000400580, cpu addr 0xffffb8194341e580
[    4.432758] [drm] Found UVD firmware Version: 1.64 Family ID: 9
[    4.432996] amdgpu 0000:01:00.0: fence driver on ring 11 use gpu addr 0x000000f40028bd30, cpu addr 0xffffb81943e38d30
[    4.433046] [drm] Found VCE firmware Version: 50.10 Binary ID: 2
[    4.433092] amdgpu 0000:01:00.0: fence driver on ring 12 use gpu addr 0x0000000000400680, cpu addr 0xffffb8194341e680
[    4.433112] amdgpu 0000:01:00.0: fence driver on ring 13 use gpu addr 0x0000000000400700, cpu addr 0xffffb8194341e700
[    4.433172] [drm] PCIE gen 3 link speeds already enabled
[    4.441068] [drm] DC: create_links: connectors_num: physical:6, virtual:0
[    4.441131] [drm:bios_parser_get_connector_id [amdgpu]] *ERROR* Can't find connector id 0 in connector table of size 6.
[    4.441179] [drm:bios_parser_get_connector_id [amdgpu]] *ERROR* Can't find connector id 1 in connector table of size 6.
[    4.441217] [drm:construct [amdgpu]] *ERROR* construct: Invalid Connector ObjectID from Adapter Service for connector index:1! type 0 expected 3
[    4.441254] [drm:bios_parser_get_connector_id [amdgpu]] *ERROR* Can't find connector id 2 in connector table of size 6.
[    4.441257] [drm] dal_graphics_object_id_is_equal: Warning: comparing invalid object 'id2'!
[    4.441261] [drm] dal_graphics_object_id_is_equal: Warning: comparing invalid object 'id2'!
[    4.441264] [drm] dal_graphics_object_id_is_equal: Warning: comparing invalid object 'id2'!
[    4.441266] [drm] dal_graphics_object_id_is_equal: Warning: comparing invalid object 'id2'!
[    4.441270] [drm] dal_graphics_object_id_is_equal: Warning: comparing invalid object 'id2'!
[    4.441272] [drm] dal_graphics_object_id_is_equal: Warning: comparing invalid object 'id2'!
[    4.441359] [drm:bios_parser_get_connector_id [amdgpu]] *ERROR* Can't find connector id 3 in connector table of size 6.
[    4.441362] [drm] dal_graphics_object_id_is_equal: Warning: comparing invalid object 'id2'!
[    4.441365] [drm] dal_graphics_object_id_is_equal: Warning: comparing invalid object 'id2'!
[    4.441367] [drm] dal_graphics_object_id_is_equal: Warning: comparing invalid object 'id2'!
[    4.441369] [drm] dal_graphics_object_id_is_equal: Warning: comparing invalid object 'id2'!
[    4.441372] [drm] dal_graphics_object_id_is_equal: Warning: comparing invalid object 'id2'!
[    4.441375] [drm] dal_graphics_object_id_is_equal: Warning: comparing invalid object 'id2'!
[    4.441419] [drm:bios_parser_get_connector_id [amdgpu]] *ERROR* Can't find connector id 4 in connector table of size 6.
[    4.441422] [drm] dal_graphics_object_id_is_equal: Warning: comparing invalid object 'id2'!
[    4.441424] [drm] dal_graphics_object_id_is_equal: Warning: comparing invalid object 'id2'!
[    4.441427] [drm] dal_graphics_object_id_is_equal: Warning: comparing invalid object 'id2'!
[    4.441429] [drm] dal_graphics_object_id_is_equal: Warning: comparing invalid object 'id2'!
[    4.441432] [drm] dal_graphics_object_id_is_equal: Warning: comparing invalid object 'id2'!
[    4.441434] [drm] dal_graphics_object_id_is_equal: Warning: comparing invalid object 'id2'!
[    4.441483] [drm:bios_parser_get_connector_id [amdgpu]] *ERROR* Can't find connector id 5 in connector table of size 6.
[    4.441486] [drm] dal_graphics_object_id_is_equal: Warning: comparing invalid object 'id2'!
[    4.457053] [drm] Display Core initialized!
[    4.457288] [drm] dal_graphics_object_id_is_equal: Warning: comparing invalid object 'id2'!
[    4.457423] [drm] dal_graphics_object_id_is_equal: Warning: comparing invalid object 'id2'!
[    4.457497] [drm] dal_graphics_object_id_is_equal: Warning: comparing invalid object 'id2'!
[    4.457513] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    4.457514] [drm] Driver supports precise vblank timestamp query.
[    4.459713] [drm] ring test on 0 succeeded in 14 usecs
[    4.459978] [drm] ring test on 1 succeeded in 2 usecs
[    4.460005] [drm] ring test on 2 succeeded in 5 usecs
[    4.460029] [drm] ring test on 3 succeeded in 11 usecs
[    4.460054] [drm] ring test on 4 succeeded in 12 usecs
[    4.460079] [drm] ring test on 5 succeeded in 12 usecs
[    4.460104] [drm] ring test on 6 succeeded in 7 usecs
[    4.460128] [drm] ring test on 7 succeeded in 12 usecs
[    4.460153] [drm] ring test on 8 succeeded in 13 usecs
[    4.460280] [drm] ring test on 9 succeeded in 4 usecs
[    4.460286] [drm] ring test on 10 succeeded in 4 usecs
[    4.495730] [drm] ring test on 11 succeeded in 1 usecs
[    4.495734] [drm] UVD initialized successfully.
[    4.544112] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
[    4.623710] [drm] ring test on 12 succeeded in 7 usecs
[    4.623720] [drm] ring test on 13 succeeded in 2 usecs
[    4.623721] [drm] VCE initialized successfully.
[    4.623939] [drm] ib test on ring 0 succeeded
[    4.623958] [drm] ib test on ring 1 succeeded
[    4.623977] [drm] ib test on ring 2 succeeded
[    4.624011] [drm] ib test on ring 3 succeeded
[    4.624076] [drm] ib test on ring 4 succeeded
[    4.624127] [drm] ib test on ring 5 succeeded
[    4.624178] [drm] ib test on ring 6 succeeded
[    4.624229] [drm] ib test on ring 7 succeeded
[    4.624258] [drm] ib test on ring 8 succeeded
[    4.624310] [drm] ib test on ring 9 succeeded
[    4.624324] [drm] ib test on ring 10 succeeded
[    4.624642] [drm] ib test on ring 11 succeeded
[    4.624954] [drm] ib test on ring 12 succeeded
[    4.624961] [drm] Cannot find any crtc or sizes
[    4.626800] amdgpu 0000:01:00.0: kfd not supported on this ASIC
[    4.626826] [drm] Initialized amdgpu 3.23.0 20150101 for 0000:01:00.0 on minor 0
[    4.820168] systemd-journald[242]: Received SIGTERM from PID 1 (systemd).
[    4.881312] SELinux:  Disabled at runtime.
[    4.881331] SELinux:  Unregistering netfilter hooks
[    5.056862] EXT4-fs (sda2): re-mounted. Opts: (null)
[    5.067270] systemd-journald[511]: Received request to flush runtime journal from PID 1
[    5.135552] ACPI: Video Device [PEGP] (multi-head: yes  rom: no  post: no)
[    5.180215] random: crng init done
[    5.243603] acpi device:52: registered as cooling_device8
[    5.244163] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:50/LNXVIDEO:00/input/input16
[    5.267395] wmi_bus wmi_bus-PNP0C14:00: WQBC data block query control method not found
[    5.268308] EDAC ie31200: No ECC support
[    5.268443] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    5.320445] ACPI Warning: SystemIO range 0x0000000000001828-0x000000000000182F conflicts with OpRegion 0x0000000000001800-0x000000000000187F (\PMIO) (20170831/utaddress-247)
[    5.320458] ACPI Warning: 
[    5.320464] parport_pc 00:07: [io  0x0378-0x037b]
[    5.320465] SystemIO range 0x0000000000001828-0x000000000000182F conflicts with OpRegion 0x0000000000001800-0x000000000000183F (\_SB.PCI0.EHC2.E1PM) (20170831/utaddress-247)
[    5.320468] ACPI Warning: SystemIO range 0x0000000000001828-0x000000000000182F conflicts with OpRegion 0x0000000000001800-0x000000000000183F (\_SB.PCI0.EHC1.E1PM) (20170831/utaddress-247)
[    5.320471] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[    5.320473] ACPI Warning: SystemIO range 0x0000000000001C40-0x0000000000001C4F conflicts with OpRegion 0x0000000000001C00-0x0000000000001FFF (\GPR) (20170831/utaddress-247)
[    5.320476] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[    5.320477] ACPI Warning: SystemIO range 0x0000000000001C30-0x0000000000001C3F conflicts with OpRegion 0x0000000000001C00-0x0000000000001C3F (\GPRL) (20170831/utaddress-247)
[    5.320481] ACPI Warning: SystemIO range 0x0000000000001C30-0x0000000000001C3F conflicts with OpRegion 0x0000000000001C00-0x0000000000001FFF (\GPR) (20170831/utaddress-247)
[    5.320484] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[    5.320484] ACPI Warning: SystemIO range 0x0000000000001C00-0x0000000000001C2F conflicts with OpRegion 0x0000000000001C00-0x0000000000001C3F (\GPRL) (20170831/utaddress-247)
[    5.320487] ACPI Warning: SystemIO range 0x0000000000001C00-0x0000000000001C2F conflicts with OpRegion 0x0000000000001C00-0x0000000000001FFF (\GPR) (20170831/utaddress-247)
[    5.320489] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[    5.320490] lpc_ich: Resource conflict(s) found affecting gpio_ich
[    5.320667] parport_pc 00:07: [irq 5]
[    5.321979] parport_pc 00:07: activated
[    5.321992] parport_pc 00:07: reported by Plug and Play ACPI
[    5.333444] media: Linux media interface: v0.10
[    5.347885] input: PC Speaker as /devices/platform/pcspkr/input/input17
[    5.351165] i801_smbus 0000:00:1f.3: SPD Write Disable is set
[    5.351193] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
[    5.422547] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    5.422795] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    5.428471] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[    5.428478] cfg80211: failed to load regulatory.db
[    5.460007] Linux video capture interface: v2.00
[    5.565836] input: Dell WMI hotkeys as /devices/platform/PNP0C14:00/wmi_bus/wmi_bus-PNP0C14:00/9DBB5994-A997-11DA-B012-B622A1EF5492/input/input18
[    5.569876] iTCO_vendor_support: vendor-support=0
[    5.570376] dcdbas dcdbas: Dell Systems Management Base Driver (version 5.6.0-3.2)
[    5.578265] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[    5.578318] iTCO_wdt: Found a Lynx Point TCO device (Version=2, TCOBASE=0x1860)
[    5.578391] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[    5.583853] ppdev: user-space parallel port driver
[    5.587700] Intel(R) Wireless WiFi driver for Linux
[    5.587704] Copyright(c) 2003- 2015 Intel Corporation
[    5.587780] iwlwifi 0000:03:00.0: enabling device (0000 -> 0002)
[    5.592390] iwlwifi 0000:03:00.0: loaded firmware version 17.459231.0 op_mode iwlmvm
[    5.594889] RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
[    5.594893] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    5.594895] RAPL PMU: hw unit of domain package 2^-14 Joules
[    5.594897] RAPL PMU: hw unit of domain dram 2^-14 Joules
[    5.594898] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[    5.596652] usbcore: registered new interface driver snd-usb-audio
[    5.597521] snd_hda_intel 0000:00:1b.0: Applying patch firmware 'hda-init.fw'
[    5.597764] snd_hda_intel 0000:01:00.1: Handle vga_switcheroo audio client
[    5.597766] snd_hda_intel 0000:01:00.1: Force to non-snoop mode
[    5.598992] uvcvideo: Found UVC 1.00 device Laptop_Integrated_Webcam_HD (0c45:64d0)
[    5.634392] input: HDA ATI HDMI HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card2/input19
[    5.635041] input: HDA ATI HDMI HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card2/input20
[    5.635125] input: HDA ATI HDMI HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card2/input21
[    5.635222] input: HDA ATI HDMI HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card2/input22
[    5.635291] input: HDA ATI HDMI HDMI/DP,pcm=10 as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card2/input23
[    5.635340] input: HDA ATI HDMI HDMI/DP,pcm=11 as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card2/input24
[    5.640889] uvcvideo 1-1.5:1.0: Entity type for entity Extension 4 was not initialized!
[    5.640896] uvcvideo 1-1.5:1.0: Entity type for entity Extension 3 was not initialized!
[    5.640899] uvcvideo 1-1.5:1.0: Entity type for entity Processing 2 was not initialized!
[    5.640902] uvcvideo 1-1.5:1.0: Entity type for entity Camera 1 was not initialized!
[    5.640954] input: Laptop_Integrated_Webcam_HD: In as /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.5/1-1.5:1.0/input/input25
[    5.641041] usbcore: registered new interface driver uvcvideo
[    5.641043] USB Video Class driver (1.1.1)
[    5.670439] snd_hda_codec_realtek hdaudioC1D0: autoconfig for ALC3226: line_outs=1 (0x16/0x0/0x0/0x0/0x0) type:line
[    5.670446] snd_hda_codec_realtek hdaudioC1D0:    speaker_outs=1 (0x14/0x0/0x0/0x0/0x0)
[    5.670449] snd_hda_codec_realtek hdaudioC1D0:    hp_outs=1 (0x15/0x0/0x0/0x0/0x0)
[    5.670452] snd_hda_codec_realtek hdaudioC1D0:    mono: mono_out=0x0
[    5.670454] snd_hda_codec_realtek hdaudioC1D0:    inputs:
[    5.670457] snd_hda_codec_realtek hdaudioC1D0:      Front Mic=0x18
[    5.670460] snd_hda_codec_realtek hdaudioC1D0:      Dock Mic=0x19
[    5.670462] snd_hda_codec_realtek hdaudioC1D0:      Headset Mic=0x1a
[    5.670465] snd_hda_codec_realtek hdaudioC1D0:      Internal Mic=0x12
[    5.813128] input: HDA Intel PCH Front Mic as /devices/pci0000:00/0000:00:1b.0/sound/card1/input26
[    5.813173] input: HDA Intel PCH Dock Mic as /devices/pci0000:00/0000:00:1b.0/sound/card1/input27
[    5.813210] input: HDA Intel PCH Dock Line Out as /devices/pci0000:00/0000:00:1b.0/sound/card1/input28
[    5.813248] input: HDA Intel PCH Front Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card1/input29
[    5.953424] dell_laptop: Using dell-rbtn acpi driver for receiving events
[    5.974515] WARNING: CPU: 5 PID: 644 at kernel/workqueue.c:1443 __queue_work+0x324/0x3d0
[    5.974522] Modules linked in: intel_powerclamp(+) coretemp mac80211 kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul snd_hda_codec_realtek ghash_clmulni_intel snd_hda_codec_generic intel_cstate snd_hda_codec_hdmi intel_uncore snd_hda_intel uvcvideo snd_usb_audio dell_laptop(+) snd_hda_codec iwlwifi snd_soc_rt5640 mei_wdt dell_smbios_smm iTCO_wdt snd_soc_rl6231 dcdbas ppdev iTCO_vendor_support dell_smbios_wmi dell_wmi snd_soc_core dell_smbios videobuf2_vmalloc wmi_bmof sparse_keymap snd_hda_core dell_wmi_descriptor snd_usbmidi_lib snd_compress dell_smm_hwmon videobuf2_memops videobuf2_v4l2 intel_rapl_perf videobuf2_core snd_pcm_dmaengine snd_hwdep snd_rawmidi videodev ac97_bus snd_seq snd_seq_device cfg80211 snd_pcm i2c_i801 pcspkr media lpc_ich snd_timer mei_me joydev parport_pc s
 nd_soc_sst_acpi
[    5.974557]  snd snd_soc_acpi ie31200_edac shpchp mei wmi parport soundcore snd_soc_acpi_intel_match elan_i2c dell_smo8800 dell_rbtn dw_dmac rfkill video spi_pxa2xx_platform binfmt_misc amdkfd amd_iommu_v2 amdgpu chash i2c_algo_bit drm_kms_helper ttm drm e1000e sdhci_pci sdhci_acpi sdhci crc32c_intel mmc_core ptp serio_raw pps_core i2c_hid
[    5.974578] CPU: 5 PID: 644 Comm: systemd-backlig Not tainted 4.15.0-rc1+ #1
[    5.974580] Hardware name: Dell Inc. Precision M6800/05NG6V, BIOS A19 05/14/2017
[    5.974582] task: ffff8b9730241e40 task.stack: ffffb81943f90000
[    5.974585] RIP: 0010:__queue_work+0x324/0x3d0
[    5.974587] RSP: 0018:ffffb81943f93da0 EFLAGS: 00010086
[    5.974589] RAX: 0000000000000000 RBX: ffff8b976dd5f500 RCX: 0000000000000000
[    5.974591] RDX: ffffffffc09c40d8 RSI: 0000000000000000 RDI: ffff8b976dd59900
[    5.974593] RBP: ffffffffbcd46400 R08: ffff8b974cc00920 R09: ffff8b976dc19900
[    5.974595] R10: 0000000000000000 R11: 0000000000000040 R12: 0000000000000005
[    5.974597] R13: 0000000000000008 R14: ffff8b974d018c00 R15: ffffffffc09c40d0
[    5.974600] FS:  00007fed02c96940(0000) GS:ffff8b976dd40000(0000) knlGS:0000000000000000
[    5.974602] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.974604] CR2: 00007fed027f1590 CR3: 00000007f0c02001 CR4: 00000000001606a0
[    5.974606] Call Trace:
[    5.974612]  queue_work_on+0x33/0x40
[    5.974617]  brightness_store+0x6d/0xb0
[    5.974621]  kernfs_fop_write+0x108/0x190
[    5.974626]  __vfs_write+0x33/0x170
[    5.974631]  ? list_lru_add+0x91/0x140
[    5.974634]  ? __check_object_size+0xaf/0x1b0
[    5.974637]  vfs_write+0xad/0x1a0
[    5.974639]  SyS_write+0x52/0xc0
[    5.974643]  entry_SYSCALL_64_fastpath+0x1a/0x7d
[    5.974646] RIP: 0033:0x7fed027cdea4
[    5.974647] RSP: 002b:00007ffcc859d098 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[    5.974650] RAX: ffffffffffffffda RBX: 0000555a18f54290 RCX: 00007fed027cdea4
[    5.974652] RDX: 0000000000000001 RSI: 0000555a18f58a40 RDI: 0000000000000004
[    5.974654] RBP: 00007fed02aa1400 R08: ffffffffffffffb0 R09: 0000555a18f58a40
[    5.974655] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[    5.974657] R13: 0000555a18f54e00 R14: 0000555a18f587c0 R15: 0000555a18f551b0
[    5.974660] Code: 3c 25 c0 d2 00 00 f6 47 4c 20 74 18 e8 66 80 00 00 48 85 c0 74 0e 48 8b 40 20 4c 3b 70 08 0f 84 0f fd ff ff 0f ff e9 e1 fd ff ff <0f> ff 48 8b 03 c6 00 00 e9 d4 fd ff ff 41 83 cc 02 48 8d 53 60 
[    5.974685] ---[ end trace 9f410c074f1d3eae ]---
[    6.059344] iwlwifi 0000:03:00.0: Detected Intel(R) Dual Band Wireless AC 7260, REV=0x144
[    6.065286] iwlwifi 0000:03:00.0: reporting RF_KILL (radio disabled)
[    6.066835] intel_rapl: Found RAPL domain package
[    6.066838] intel_rapl: Found RAPL domain core
[    6.066839] intel_rapl: Found RAPL domain dram
[    6.066841] intel_rapl: RAPL package 0 domain package locked by BIOS
[    6.066844] intel_rapl: RAPL package 0 domain dram locked by BIOS
[    6.079827] iwlwifi 0000:03:00.0: base HW address: 48:51:b7:bf:c2:b4
[    6.102303] ieee80211 phy0: Selected rate control algorithm 'iwl-mvm-rs'
[    6.103897] iwlwifi 0000:03:00.0 wlp3s0: renamed from wlan0
[    7.129749] EXT4-fs (sdb1): mounted filesystem with ordered data mode. Opts: (null)
[    7.269297] RPC: Registered named UNIX socket transport module.
[    7.269302] RPC: Registered udp transport module.
[    7.269303] RPC: Registered tcp transport module.
[    7.269305] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    7.391770] IPv6: ADDRCONF(NETDEV_UP): eno1: link is not ready
[    7.599207] IPv6: ADDRCONF(NETDEV_UP): eno1: link is not ready
[    7.601953] IPv6: ADDRCONF(NETDEV_UP): wlp3s0: link is not ready
[    7.691526] bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
[    7.697574] IPv6: ADDRCONF(NETDEV_UP): bridge0: link is not ready
[    7.877767] ip6_tables: (C) 2000-2006 Netfilter Core Team
[    7.922984] Ebtables v2.0 registered
[    8.255075] iwlwifi 0000:03:00.0: RF_KILL bit toggled to enable radio.
[    8.255078] iwlwifi 0000:03:00.0: reporting RF_KILL (radio enabled)
[   12.767538] e1000e: eno1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
[   12.767623] IPv6: ADDRCONF(NETDEV_CHANGE): eno1: link becomes ready
[   12.775265] bridge0: port 1(eno1) entered blocking state
[   12.775277] bridge0: port 1(eno1) entered disabled state
[   12.775509] device eno1 entered promiscuous mode
[   12.775664] bridge0: port 1(eno1) entered blocking state
[   12.775673] bridge0: port 1(eno1) entered forwarding state
[   13.855492] usb 3-5.2: USB disconnect, device number 5
[   14.041203] usb 3-5.3: USB disconnect, device number 6
[   15.828137] iwlwifi 0000:03:00.0: RF_KILL bit toggled to disable radio.
[   15.828141] iwlwifi 0000:03:00.0: reporting RF_KILL (radio disabled)

--------------BFD5BA05234FBEE871417F3F
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------BFD5BA05234FBEE871417F3F--
