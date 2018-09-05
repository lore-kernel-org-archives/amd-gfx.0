From: Tom St Denis <tstdenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: two KASANs in TTM logic
Date: Wed, 5 Sep 2018 09:27:15 -0400
Message-ID: <84c7fd33-b9aa-001a-82b8-0f832096d649@amd.com>
References: <62eed98f-e37c-6a72-3553-cfd10b13e49f@amd.com>
 <63c23f00-92dd-2311-5dc9-21e29b3bbb8b@gmail.com>
 <3bca643b-306f-d403-f304-3b22d98b6a9d@amd.com>
 <7c88bc11-05aa-eb72-edf5-70f558dffa52@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------431FD4F7776F526BDAD4A76A"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <7c88bc11-05aa-eb72-edf5-70f558dffa52-5C7GfCeVMHo@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, "Daenzer, Michel" <Michel.Daenzer-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>

--------------431FD4F7776F526BDAD4A76A
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Logs attached.

Tom



On 09/05/2018 08:02 AM, Christian König wrote:
> Still not the slightest idea what is causing this and the patch 
> definitely fixes things a lot.
> 
> Can you try to enable list debugging in your kernel?
> 
> Thanks,
> Christian.
> 
> Am 04.09.2018 um 19:18 schrieb Tom St Denis:
>> Sure:
>>
>> d2917f399e0b250f47d07da551a335843a24f835 is the first bad commit
>> commit d2917f399e0b250f47d07da551a335843a24f835
>> Author: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>> Date:   Thu Aug 30 10:04:53 2018 +0200
>>
>>     drm/amdgpu: fix "use bulk moves for efficient VM LRU handling" v2
>>
>>     First step to fix the LRU corruption, we accidentially tried to 
>> move things
>>     on the LRU after dropping the lock.
>>
>>     Signed-off-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>>     Tested-by: Michel Dänzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>
>>
>> :040000 040000 ed5be1ad4da129c4154b2b43acf7ef349a470700 
>> 0008c4e2fb56512f41559618dd474c916fc09a37 M      drivers
>>
>>
>> The commit before that I can run xonotic-glx and piglit on my Carrizo 
>> without a KASAN.
>>
>> Tom
>>
>> On 09/04/2018 10:05 AM, Christian König wrote:
>>> The first one should already be fixed.
>>>
>>> Not sure where the second comes from. Can you narrow that down further?
>>>
>>> Christian.
>>>
>>> Am 04.09.2018 um 15:46 schrieb Tom St Denis:
>>>> First is caused by this commit while running a GL heavy application.
>>>>
>>>> d78c1fa0c9f815fe951fd57001acca3d35262a17 is the first bad commit
>>>> commit d78c1fa0c9f815fe951fd57001acca3d35262a17
>>>> Author: Michel Dänzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>
>>>> Date:   Wed Aug 29 11:59:38 2018 +0200
>>>>
>>>>     Revert "drm/amdgpu: move PD/PT bos on LRU again"
>>>>
>>>>     This reverts commit 31625ccae4464b61ec8cdb9740df848bbc857a5b.
>>>>
>>>>     It triggered various badness on my development machine when 
>>>> running the
>>>>     piglit gpu profile with radeonsi on Bonaire, looks like memory
>>>>     corruption due to insufficiently protected list manipulations.
>>>>
>>>>     Signed-off-by: Michel Dänzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>
>>>>     Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
>>>>
>>>> :040000 040000 b7169f0cf0c7decec631751a9896a92badb67f9d 
>>>> 42ea58f43199d26fc0c7ddcc655e6d0964b81817 M      drivers
>>>>
>>>> The second is caused by something between that and the tip of the 
>>>> 4.19-rc1 amd-staging-drm-next (I haven't pinned it down yet) while 
>>>> loading GNOME.
>>>>
>>>> Tom
>>>>
>>>>
>>>>
>>>> _______________________________________________
>>>> amd-gfx mailing list
>>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>>
> 

--------------431FD4F7776F526BDAD4A76A
Content-Type: text/x-log;
 name="dmesg.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg.log"

[    0.000000] Linux version 4.19.0-rc1+ (root@raven) (gcc version 8.1.1 20180712 (Red Hat 8.1.1-5) (GCC)) #24 SMP Wed Sep 5 08:59:20 EDT 2018
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
[    0.000000] Using GB pages for direct mapping
[    0.000000] BRK [0x1082ff000, 0x1082fffff] PGTABLE
[    0.000000] BRK [0x108300000, 0x108300fff] PGTABLE
[    0.000000] BRK [0x108301000, 0x108301fff] PGTABLE
[    0.000000] BRK [0x108302000, 0x108302fff] PGTABLE
[    0.000000] BRK [0x108303000, 0x108303fff] PGTABLE
[    0.000000] BRK [0x108304000, 0x108304fff] PGTABLE
[    0.000000] BRK [0x108305000, 0x108305fff] PGTABLE
[    0.000000] BRK [0x108306000, 0x108306fff] PGTABLE
[    0.000000] BRK [0x108307000, 0x108307fff] PGTABLE
[    0.000000] BRK [0x108308000, 0x108308fff] PGTABLE
[    0.000000] BRK [0x108309000, 0x108309fff] PGTABLE
[    0.000000] BRK [0x10830a000, 0x10830afff] PGTABLE
[    0.000000] RAMDISK: [mem 0x3483a000-0x36414fff]
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
[    0.000000] random: get_random_bytes called from start_kernel+0xe5/0x5fb with crng_init=0
[    0.000000] setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:16 nr_node_ids:1
[    0.000000] percpu: Embedded 54 pages/cpu @(____ptrval____) s180616 r8192 d32376 u262144
[    0.000000] pcpu-alloc: s180616 r8192 d32376 u262144 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 12 13 14 15 
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 1789181
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-4.19.0-rc1+ root=UUID=66163c80-0ca1-4beb-aeba-5cc130b813e6 ro rhgb quiet modprobe.blacklist=amdgpu,radeon LANG=en_CA.UTF-8
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Memory: 6071372K/7270416K available (22540K kernel code, 5571K rwdata, 6628K rodata, 1604K init, 21008K bss, 1199044K reserved, 0K cma-reserved)
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
[    0.006000] tsc: Detected 3592.727 MHz processor
[    0.000031] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x33c97d1afcb, max_idle_ns: 440795377937 ns
[    0.000051] Calibrating delay loop (skipped), value calculated using timer frequency.. 7185.45 BogoMIPS (lpj=3592727)
[    0.000057] pid_max: default: 32768 minimum: 301
[    0.000206] Security Framework initialized
[    0.000212] SELinux:  Initializing.
[    0.002071] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.003009] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.003105] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.003942] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.005474] mce: CPU supports 23 MCE banks
[    0.005533] LVT offset 1 assigned for vector 0xf9
[    0.005604] LVT offset 2 assigned for vector 0xf4
[    0.005615] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 512
[    0.005618] Last level dTLB entries: 4KB 1536, 2MB 1536, 4MB 768, 1GB 0
[    0.005622] Spectre V2 : Mitigation: Full AMD retpoline
[    0.005625] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.005627] Spectre V2 : Spectre v2 mitigation: Enabling Indirect Branch Prediction Barrier
[    0.005631] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
[    0.015886] Freeing SMP alternatives memory: 36K
[    0.017040] smpboot: CPU0: AMD Ryzen 5 2400G with Radeon Vega Graphics (family: 0x17, model: 0x11, stepping: 0x0)
[    0.017040] Performance Events: Fam17h core perfctr, AMD PMU driver.
[    0.017040] ... version:                0
[    0.017040] ... bit width:              48
[    0.017040] ... generic registers:      6
[    0.017040] ... value mask:             0000ffffffffffff
[    0.017040] ... max period:             00007fffffffffff
[    0.017040] ... fixed-purpose events:   0
[    0.017040] ... event mask:             000000000000003f
[    0.017084] rcu: Hierarchical SRCU implementation.
[    0.019636] MCE: In-kernel MCE decoding enabled.
[    0.020818] smp: Bringing up secondary CPUs ...
[    0.021682] x86: Booting SMP configuration:
[    0.021691] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7
[    0.036195] smp: Brought up 1 node, 8 CPUs
[    0.036195] smpboot: Max logical packages: 2
[    0.036195] smpboot: Total of 8 processors activated (57483.63 BogoMIPS)
[    0.040076] devtmpfs: initialized
[    0.044239] PM: Registering ACPI NVS region [mem 0x04000000-0x04009fff] (40960 bytes)
[    0.044284] PM: Registering ACPI NVS region [mem 0x7a7d2000-0x7ab89fff] (3899392 bytes)
[    0.048508] kworker/u32:1 (52) used greatest stack depth: 21592 bytes left
[    0.049230] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.049230] futex hash table entries: 4096 (order: 7, 524288 bytes)
[    0.051173] RTC time: 13:11:27, date: 09/05/18
[    0.053806] NET: Registered protocol family 16
[    0.054990] audit: initializing netlink subsys (disabled)
[    0.055136] audit: type=2000 audit(1536153087.061:1): state=initialized audit_enabled=0 res=1
[    0.056702] cpuidle: using governor menu
[    0.057221] ACPI: bus type PCI registered
[    0.058199] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.058199] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
[    0.058199] PCI: Using configuration type 1 for base access
[    0.062139] mtrr: your CPUs had inconsistent variable MTRR settings
[    0.062139] mtrr: probably your BIOS does not setup all CPUs.
[    0.062139] mtrr: corrected configuration.
[    0.092286] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.093687] ACPI: Added _OSI(Module Device)
[    0.093691] ACPI: Added _OSI(Processor Device)
[    0.093695] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.093698] ACPI: Added _OSI(Processor Aggregator Device)
[    0.093714] ACPI: Added _OSI(Linux-Dell-Video)
[    0.093727] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.372863] ACPI BIOS Error (bug): Failure creating [\_SB.SMIC], AE_ALREADY_EXISTS (20180810/dswload2-316)
[    0.373053] ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20180810/psobject-221)
[    0.373414] ACPI BIOS Error (bug): Failure creating [\_SB.SMIB], AE_ALREADY_EXISTS (20180810/dsfield-626)
[    0.384671] ACPI BIOS Error (bug): Failure creating [\_SB.MACO], AE_ALREADY_EXISTS (20180810/dswload2-316)
[    0.385048] ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20180810/psobject-221)
[    0.386618] ACPI: 10 ACPI AML tables successfully acquired and loaded
[    0.428870] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.480682] ACPI: Interpreter enabled
[    0.480876] ACPI: (supports S0 S3 S4 S5)
[    0.480880] ACPI: Using IOAPIC for interrupt routing
[    0.486028] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.492995] ACPI: Enabled 3 GPEs in block 00 to 1F
[    0.577714] ACPI: Power Resource [P0ST] (on)
[    0.578551] ACPI: Power Resource [P3ST] (on)
[    0.737822] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.737857] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.743917] acpi PNP0A08:00: _OSC: platform does not support [PME LTR]
[    0.749753] acpi PNP0A08:00: _OSC: OS now controls [AER PCIeCapability]
[    0.749960] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000 [bus 00-3f] only partially covers this bridge
[    0.756797] PCI host bridge to bus 0000:00
[    0.756811] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    0.756822] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    0.756833] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
[    0.756844] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.756855] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.756866] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff window]
[    0.756877] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfec2ffff window]
[    0.756888] pci_bus 0000:00: root bus resource [mem 0xfee00000-0xffffffff window]
[    0.756900] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.756967] pci 0000:00:00.0: [1022:15d0] type 00 class 0x060000
[    0.758746] pci 0000:00:00.2: [1022:15d1] type 00 class 0x080600
[    0.760371] pci 0000:00:01.0: [1022:1452] type 00 class 0x060000
[    0.761721] pci 0000:00:01.1: [1022:15d3] type 01 class 0x060400
[    0.761938] pci 0000:00:01.1: PME# supported from D0 D3hot D3cold
[    0.763620] pci 0000:00:01.2: [1022:15d3] type 01 class 0x060400
[    0.763838] pci 0000:00:01.2: PME# supported from D0 D3hot D3cold
[    0.765471] pci 0000:00:08.0: [1022:1452] type 00 class 0x060000
[    0.766851] pci 0000:00:08.1: [1022:15db] type 01 class 0x060400
[    0.766926] pci 0000:00:08.1: enabling Extended Tags
[    0.767087] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
[    0.768633] pci 0000:00:08.2: [1022:15dc] type 01 class 0x060400
[    0.768706] pci 0000:00:08.2: enabling Extended Tags
[    0.768845] pci 0000:00:08.2: PME# supported from D0 D3hot D3cold
[    0.770469] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500
[    0.772203] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100
[    0.773958] pci 0000:00:18.0: [1022:15e8] type 00 class 0x060000
[    0.775273] pci 0000:00:18.1: [1022:15e9] type 00 class 0x060000
[    0.776549] pci 0000:00:18.2: [1022:15ea] type 00 class 0x060000
[    0.777815] pci 0000:00:18.3: [1022:15eb] type 00 class 0x060000
[    0.779119] pci 0000:00:18.4: [1022:15ec] type 00 class 0x060000
[    0.780390] pci 0000:00:18.5: [1022:15ed] type 00 class 0x060000
[    0.781667] pci 0000:00:18.6: [1022:15ee] type 00 class 0x060000
[    0.782945] pci 0000:00:18.7: [1022:15ef] type 00 class 0x060000
[    0.784553] pci 0000:01:00.0: [1002:67c4] type 00 class 0x030000
[    0.784614] pci 0000:01:00.0: reg 0x10: [mem 0xe0000000-0xefffffff 64bit pref]
[    0.784636] pci 0000:01:00.0: reg 0x18: [mem 0xf0000000-0xf01fffff 64bit pref]
[    0.784651] pci 0000:01:00.0: reg 0x20: [io  0xf000-0xf0ff]
[    0.784665] pci 0000:01:00.0: reg 0x24: [mem 0xfe900000-0xfe93ffff]
[    0.784679] pci 0000:01:00.0: reg 0x30: [mem 0xfe940000-0xfe95ffff pref]
[    0.784956] pci 0000:01:00.0: supports D1 D2
[    0.784961] pci 0000:01:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.785066] pci 0000:01:00.0: 63.008 Gb/s available PCIe bandwidth, limited by 8 GT/s x8 link at 0000:00:01.1 (capable of 126.016 Gb/s with 8 GT/s x16 link)
[    0.785932] pci 0000:01:00.1: [1002:aaf0] type 00 class 0x040300
[    0.785986] pci 0000:01:00.1: reg 0x10: [mem 0xfe960000-0xfe963fff 64bit]
[    0.786304] pci 0000:01:00.1: supports D1 D2
[    0.787258] pci 0000:00:01.1: PCI bridge to [bus 01]
[    0.787269] pci 0000:00:01.1:   bridge window [io  0xf000-0xffff]
[    0.787276] pci 0000:00:01.1:   bridge window [mem 0xfe900000-0xfe9fffff]
[    0.787286] pci 0000:00:01.1:   bridge window [mem 0xe0000000-0xf01fffff 64bit pref]
[    0.787552] pci 0000:02:00.0: [1022:43bb] type 00 class 0x0c0330
[    0.787596] pci 0000:02:00.0: reg 0x10: [mem 0xfe7a0000-0xfe7a7fff 64bit]
[    0.787867] pci 0000:02:00.0: PME# supported from D3hot D3cold
[    0.788748] pci 0000:02:00.1: [1022:43b7] type 00 class 0x010601
[    0.788839] pci 0000:02:00.1: reg 0x24: [mem 0xfe780000-0xfe79ffff]
[    0.788856] pci 0000:02:00.1: reg 0x30: [mem 0xfe700000-0xfe77ffff pref]
[    0.789075] pci 0000:02:00.1: PME# supported from D3hot D3cold
[    0.789918] pci 0000:02:00.2: [1022:43b2] type 01 class 0x060400
[    0.790215] pci 0000:02:00.2: PME# supported from D3hot D3cold
[    0.791131] pci 0000:00:01.2: PCI bridge to [bus 02-06]
[    0.791142] pci 0000:00:01.2:   bridge window [io  0xe000-0xefff]
[    0.791149] pci 0000:00:01.2:   bridge window [mem 0xfe600000-0xfe7fffff]
[    0.791437] pci 0000:03:00.0: [1022:43b4] type 01 class 0x060400
[    0.791801] pci 0000:03:00.0: PME# supported from D3hot D3cold
[    0.792994] pci 0000:03:01.0: [1022:43b4] type 01 class 0x060400
[    0.793360] pci 0000:03:01.0: PME# supported from D3hot D3cold
[    0.794524] pci 0000:03:04.0: [1022:43b4] type 01 class 0x060400
[    0.794876] pci 0000:03:04.0: PME# supported from D3hot D3cold
[    0.796056] pci 0000:02:00.2: PCI bridge to [bus 03-06]
[    0.796070] pci 0000:02:00.2:   bridge window [io  0xe000-0xefff]
[    0.796078] pci 0000:02:00.2:   bridge window [mem 0xfe600000-0xfe6fffff]
[    0.796389] pci 0000:04:00.0: [10ec:8168] type 00 class 0x020000
[    0.796451] pci 0000:04:00.0: reg 0x10: [io  0xe000-0xe0ff]
[    0.796503] pci 0000:04:00.0: reg 0x18: [mem 0xfe604000-0xfe604fff 64bit]
[    0.796537] pci 0000:04:00.0: reg 0x20: [mem 0xfe600000-0xfe603fff 64bit]
[    0.796996] pci 0000:04:00.0: supports D1 D2
[    0.797001] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.797963] pci 0000:03:00.0: PCI bridge to [bus 04]
[    0.797974] pci 0000:03:00.0:   bridge window [io  0xe000-0xefff]
[    0.797982] pci 0000:03:00.0:   bridge window [mem 0xfe600000-0xfe6fffff]
[    0.798269] pci 0000:03:01.0: PCI bridge to [bus 05]
[    0.798532] pci 0000:03:04.0: PCI bridge to [bus 06]
[    0.798858] pci 0000:07:00.0: [1002:15dd] type 00 class 0x030000
[    0.798921] pci 0000:07:00.0: reg 0x10: [mem 0xc0000000-0xcfffffff 64bit pref]
[    0.798948] pci 0000:07:00.0: reg 0x18: [mem 0xd0000000-0xd01fffff 64bit pref]
[    0.798967] pci 0000:07:00.0: reg 0x20: [io  0xd000-0xd0ff]
[    0.798986] pci 0000:07:00.0: reg 0x24: [mem 0xfe500000-0xfe57ffff]
[    0.799014] pci 0000:07:00.0: enabling Extended Tags
[    0.799303] pci 0000:07:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.800415] pci 0000:07:00.1: [1002:15de] type 00 class 0x040300
[    0.800457] pci 0000:07:00.1: reg 0x10: [mem 0xfe588000-0xfe58bfff]
[    0.800554] pci 0000:07:00.1: enabling Extended Tags
[    0.800776] pci 0000:07:00.1: PME# supported from D1 D2 D3hot D3cold
[    0.801838] pci 0000:07:00.2: [1022:15df] type 00 class 0x108000
[    0.801907] pci 0000:07:00.2: reg 0x18: [mem 0xfe400000-0xfe4fffff]
[    0.801952] pci 0000:07:00.2: reg 0x24: [mem 0xfe58c000-0xfe58dfff]
[    0.801980] pci 0000:07:00.2: enabling Extended Tags
[    0.803233] pci 0000:07:00.3: [1022:15e0] type 00 class 0x0c0330
[    0.803282] pci 0000:07:00.3: reg 0x10: [mem 0xfe300000-0xfe3fffff 64bit]
[    0.803363] pci 0000:07:00.3: enabling Extended Tags
[    0.803592] pci 0000:07:00.3: PME# supported from D0 D3hot D3cold
[    0.804671] pci 0000:07:00.4: [1022:15e1] type 00 class 0x0c0330
[    0.804720] pci 0000:07:00.4: reg 0x10: [mem 0xfe200000-0xfe2fffff 64bit]
[    0.804801] pci 0000:07:00.4: enabling Extended Tags
[    0.805032] pci 0000:07:00.4: PME# supported from D0 D3hot D3cold
[    0.806147] pci 0000:07:00.6: [1022:15e3] type 00 class 0x040300
[    0.806188] pci 0000:07:00.6: reg 0x10: [mem 0xfe580000-0xfe587fff]
[    0.806285] pci 0000:07:00.6: enabling Extended Tags
[    0.806510] pci 0000:07:00.6: PME# supported from D0 D3hot D3cold
[    0.807648] pci 0000:00:08.1: PCI bridge to [bus 07]
[    0.807659] pci 0000:00:08.1:   bridge window [io  0xd000-0xdfff]
[    0.807666] pci 0000:00:08.1:   bridge window [mem 0xfe200000-0xfe5fffff]
[    0.807677] pci 0000:00:08.1:   bridge window [mem 0xc0000000-0xd01fffff 64bit pref]
[    0.807954] pci 0000:08:00.0: [1022:7901] type 00 class 0x010601
[    0.808080] pci 0000:08:00.0: reg 0x24: [mem 0xfe800000-0xfe8007ff]
[    0.808108] pci 0000:08:00.0: enabling Extended Tags
[    0.808342] pci 0000:08:00.0: PME# supported from D3hot D3cold
[    0.809335] pci 0000:00:08.2: PCI bridge to [bus 08]
[    0.809350] pci 0000:00:08.2:   bridge window [mem 0xfe800000-0xfe8fffff]
[    0.821016] ACPI: PCI Interrupt Link [LNKA] (IRQs 4 5 7 10 11 14 15) *0
[    0.822390] ACPI: PCI Interrupt Link [LNKB] (IRQs 4 5 7 10 11 14 15) *0
[    0.823619] ACPI: PCI Interrupt Link [LNKC] (IRQs 4 5 7 10 11 14 15) *0
[    0.825014] ACPI: PCI Interrupt Link [LNKD] (IRQs 4 5 7 10 11 14 15) *0
[    0.826351] ACPI: PCI Interrupt Link [LNKE] (IRQs 4 5 7 10 11 14 15) *0
[    0.827473] ACPI: PCI Interrupt Link [LNKF] (IRQs 4 5 7 10 11 14 15) *0
[    0.828600] ACPI: PCI Interrupt Link [LNKG] (IRQs 4 5 7 10 11 14 15) *0
[    0.829725] ACPI: PCI Interrupt Link [LNKH] (IRQs 4 5 7 10 11 14 15) *0
[    0.841194] pci 0000:01:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
[    0.841229] pci 0000:07:00.0: vgaarb: setting as boot VGA device
[    0.841233] pci 0000:07:00.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.841243] pci 0000:07:00.0: vgaarb: bridge control possible
[    0.841247] pci 0000:01:00.0: vgaarb: bridge control possible
[    0.841250] vgaarb: loaded
[    0.842699] SCSI subsystem initialized
[    0.843152] libata version 3.00 loaded.
[    0.843593] ACPI: bus type USB registered
[    0.843925] usbcore: registered new interface driver usbfs
[    0.844123] usbcore: registered new interface driver hub
[    0.844362] usbcore: registered new device driver usb
[    0.844735] pps_core: LinuxPPS API ver. 1 registered
[    0.844739] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
[    0.844799] PTP clock support registered
[    0.845194] EDAC MC: Ver: 3.0.0
[    0.846448] Advanced Linux Sound Architecture Driver Initialized.
[    0.846622] PCI: Using ACPI for IRQ routing
[    0.851003] PCI: pci_cache_line_size set to 64 bytes
[    0.851170] e820: reserve RAM buffer [mem 0x0009d400-0x0009ffff]
[    0.851195] e820: reserve RAM buffer [mem 0x09c00000-0x0bffffff]
[    0.851207] e820: reserve RAM buffer [mem 0x0b000000-0x0bffffff]
[    0.851218] e820: reserve RAM buffer [mem 0x73964000-0x73ffffff]
[    0.851230] e820: reserve RAM buffer [mem 0x7a5ab000-0x7bffffff]
[    0.851242] e820: reserve RAM buffer [mem 0x7a7d2000-0x7bffffff]
[    0.851253] e820: reserve RAM buffer [mem 0x7e000000-0x7fffffff]
[    0.851264] e820: reserve RAM buffer [mem 0x23f340000-0x23fffffff]
[    0.852844] NetLabel: Initializing
[    0.852847] NetLabel:  domain hash size = 128
[    0.852850] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.853077] NetLabel:  unlabeled traffic allowed by default
[    0.853357] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.853370] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.855218] clocksource: Switched to clocksource tsc-early
[    1.002725] VFS: Disk quotas dquot_6.6.0
[    1.002794] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.003432] pnp: PnP ACPI init
[    1.004845] system 00:00: [mem 0xf8000000-0xfbffffff] has been reserved
[    1.004970] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    1.006224] system 00:01: [mem 0xfeb80000-0xfebfffff] has been reserved
[    1.006271] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.008731] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
[    1.011852] system 00:03: [io  0x0300-0x030f] has been reserved
[    1.011874] system 00:03: [io  0x0230-0x023f] has been reserved
[    1.011898] system 00:03: [io  0x0290-0x029f] has been reserved
[    1.011946] system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.017532] pnp 00:04: [dma 0 disabled]
[    1.017942] pnp 00:04: Plug and Play ACPI device, IDs PNP0501 (active)
[    1.022299] system 00:05: [io  0x04d0-0x04d1] has been reserved
[    1.022320] system 00:05: [io  0x040b] has been reserved
[    1.022341] system 00:05: [io  0x04d6] has been reserved
[    1.022362] system 00:05: [io  0x0c00-0x0c01] has been reserved
[    1.022383] system 00:05: [io  0x0c14] has been reserved
[    1.022404] system 00:05: [io  0x0c50-0x0c51] has been reserved
[    1.022425] system 00:05: [io  0x0c52] has been reserved
[    1.022445] system 00:05: [io  0x0c6c] has been reserved
[    1.022466] system 00:05: [io  0x0c6f] has been reserved
[    1.022489] system 00:05: [io  0x0cd0-0x0cd1] has been reserved
[    1.022509] system 00:05: [io  0x0cd2-0x0cd3] has been reserved
[    1.022530] system 00:05: [io  0x0cd4-0x0cd5] has been reserved
[    1.022551] system 00:05: [io  0x0cd6-0x0cd7] has been reserved
[    1.022572] system 00:05: [io  0x0cd8-0x0cdf] has been reserved
[    1.022593] system 00:05: [io  0x0800-0x089f] has been reserved
[    1.022614] system 00:05: [io  0x0b00-0x0b0f] has been reserved
[    1.022635] system 00:05: [io  0x0b20-0x0b3f] has been reserved
[    1.022656] system 00:05: [io  0x0900-0x090f] has been reserved
[    1.022676] system 00:05: [io  0x0910-0x091f] has been reserved
[    1.022709] system 00:05: [mem 0xfec00000-0xfec00fff] could not be reserved
[    1.022739] system 00:05: [mem 0xfec01000-0xfec01fff] could not be reserved
[    1.022760] system 00:05: [mem 0xfedc0000-0xfedc0fff] has been reserved
[    1.022781] system 00:05: [mem 0xfee00000-0xfee00fff] has been reserved
[    1.022811] system 00:05: [mem 0xfed80000-0xfed8ffff] could not be reserved
[    1.022832] system 00:05: [mem 0xfec10000-0xfec10fff] has been reserved
[    1.022853] system 00:05: [mem 0xff000000-0xffffffff] has been reserved
[    1.022901] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.032685] pnp: PnP ACPI: found 6 devices
[    1.059150] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    1.059255] pci 0000:00:01.1: PCI bridge to [bus 01]
[    1.059261] pci 0000:00:01.1:   bridge window [io  0xf000-0xffff]
[    1.059270] pci 0000:00:01.1:   bridge window [mem 0xfe900000-0xfe9fffff]
[    1.059278] pci 0000:00:01.1:   bridge window [mem 0xe0000000-0xf01fffff 64bit pref]
[    1.059289] pci 0000:03:00.0: PCI bridge to [bus 04]
[    1.059294] pci 0000:03:00.0:   bridge window [io  0xe000-0xefff]
[    1.059303] pci 0000:03:00.0:   bridge window [mem 0xfe600000-0xfe6fffff]
[    1.059317] pci 0000:03:01.0: PCI bridge to [bus 05]
[    1.059335] pci 0000:03:04.0: PCI bridge to [bus 06]
[    1.059353] pci 0000:02:00.2: PCI bridge to [bus 03-06]
[    1.059359] pci 0000:02:00.2:   bridge window [io  0xe000-0xefff]
[    1.059367] pci 0000:02:00.2:   bridge window [mem 0xfe600000-0xfe6fffff]
[    1.059380] pci 0000:00:01.2: PCI bridge to [bus 02-06]
[    1.059386] pci 0000:00:01.2:   bridge window [io  0xe000-0xefff]
[    1.059394] pci 0000:00:01.2:   bridge window [mem 0xfe600000-0xfe7fffff]
[    1.059409] pci 0000:00:08.1: PCI bridge to [bus 07]
[    1.059414] pci 0000:00:08.1:   bridge window [io  0xd000-0xdfff]
[    1.059423] pci 0000:00:08.1:   bridge window [mem 0xfe200000-0xfe5fffff]
[    1.059430] pci 0000:00:08.1:   bridge window [mem 0xc0000000-0xd01fffff 64bit pref]
[    1.059440] pci 0000:00:08.2: PCI bridge to [bus 08]
[    1.059449] pci 0000:00:08.2:   bridge window [mem 0xfe800000-0xfe8fffff]
[    1.059464] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    1.059468] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
[    1.059472] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
[    1.059476] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    1.059480] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff window]
[    1.059484] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff window]
[    1.059489] pci_bus 0000:00: resource 10 [mem 0xc0000000-0xfec2ffff window]
[    1.059493] pci_bus 0000:00: resource 11 [mem 0xfee00000-0xffffffff window]
[    1.059497] pci_bus 0000:01: resource 0 [io  0xf000-0xffff]
[    1.059500] pci_bus 0000:01: resource 1 [mem 0xfe900000-0xfe9fffff]
[    1.059505] pci_bus 0000:01: resource 2 [mem 0xe0000000-0xf01fffff 64bit pref]
[    1.059509] pci_bus 0000:02: resource 0 [io  0xe000-0xefff]
[    1.059513] pci_bus 0000:02: resource 1 [mem 0xfe600000-0xfe7fffff]
[    1.059517] pci_bus 0000:03: resource 0 [io  0xe000-0xefff]
[    1.059521] pci_bus 0000:03: resource 1 [mem 0xfe600000-0xfe6fffff]
[    1.059525] pci_bus 0000:04: resource 0 [io  0xe000-0xefff]
[    1.059529] pci_bus 0000:04: resource 1 [mem 0xfe600000-0xfe6fffff]
[    1.059533] pci_bus 0000:07: resource 0 [io  0xd000-0xdfff]
[    1.059537] pci_bus 0000:07: resource 1 [mem 0xfe200000-0xfe5fffff]
[    1.059541] pci_bus 0000:07: resource 2 [mem 0xc0000000-0xd01fffff 64bit pref]
[    1.059545] pci_bus 0000:08: resource 1 [mem 0xfe800000-0xfe8fffff]
[    1.060968] NET: Registered protocol family 2
[    1.062259] tcp_listen_portaddr_hash hash table entries: 4096 (order: 6, 294912 bytes)
[    1.062527] TCP established hash table entries: 65536 (order: 7, 524288 bytes)
[    1.063386] TCP bind hash table entries: 65536 (order: 10, 4194304 bytes)
[    1.065956] TCP: Hash tables configured (established 65536 bind 65536)
[    1.066851] UDP hash table entries: 4096 (order: 7, 655360 bytes)
[    1.067317] UDP-Lite hash table entries: 4096 (order: 7, 655360 bytes)
[    1.068481] NET: Registered protocol family 1
[    1.069520] RPC: Registered named UNIX socket transport module.
[    1.069528] RPC: Registered udp transport module.
[    1.069531] RPC: Registered tcp transport module.
[    1.069534] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    1.070339] pci 0000:01:00.1: Linked as a consumer to 0000:01:00.0
[    1.072079] pci 0000:07:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    1.072121] pci 0000:07:00.1: Linked as a consumer to 0000:07:00.0
[    1.075549] PCI: CLS 64 bytes, default 64
[    1.076040] Unpacking initramfs...
[    2.071517] Freeing initrd memory: 28524K
[    2.435628] AMD-Vi: Unable to write to IOMMU perf counter.
[    2.436896] pci 0000:00:00.2: can't derive routing for PCI INT A
[    2.436901] pci 0000:00:00.2: PCI INT A: not connected
[    2.440516] iommu: Adding device 0000:00:01.0 to group 0
[    2.442205] iommu: Adding device 0000:00:01.1 to group 1
[    2.443815] iommu: Adding device 0000:00:01.2 to group 2
[    2.445526] iommu: Adding device 0000:00:08.0 to group 3
[    2.447193] iommu: Adding device 0000:00:08.1 to group 4
[    2.447338] iommu: Adding device 0000:00:08.2 to group 3
[    2.448936] iommu: Adding device 0000:00:14.0 to group 5
[    2.449086] iommu: Adding device 0000:00:14.3 to group 5
[    2.450946] iommu: Adding device 0000:00:18.0 to group 6
[    2.451100] iommu: Adding device 0000:00:18.1 to group 6
[    2.451239] iommu: Adding device 0000:00:18.2 to group 6
[    2.451379] iommu: Adding device 0000:00:18.3 to group 6
[    2.451517] iommu: Adding device 0000:00:18.4 to group 6
[    2.451654] iommu: Adding device 0000:00:18.5 to group 6
[    2.451792] iommu: Adding device 0000:00:18.6 to group 6
[    2.451933] iommu: Adding device 0000:00:18.7 to group 6
[    2.453615] iommu: Adding device 0000:01:00.0 to group 7
[    2.454400] iommu: Using direct mapping for device 0000:01:00.0
[    2.454560] iommu: Adding device 0000:01:00.1 to group 7
[    2.456204] iommu: Adding device 0000:02:00.0 to group 8
[    2.456365] iommu: Adding device 0000:02:00.1 to group 8
[    2.456527] iommu: Adding device 0000:02:00.2 to group 8
[    2.456634] iommu: Adding device 0000:03:00.0 to group 8
[    2.456741] iommu: Adding device 0000:03:01.0 to group 8
[    2.456851] iommu: Adding device 0000:03:04.0 to group 8
[    2.456968] iommu: Adding device 0000:04:00.0 to group 8
[    2.458720] iommu: Adding device 0000:07:00.0 to group 9
[    2.459523] iommu: Using direct mapping for device 0000:07:00.0
[    2.461267] iommu: Adding device 0000:07:00.1 to group 10
[    2.461450] iommu: Adding device 0000:07:00.2 to group 10
[    2.461632] iommu: Adding device 0000:07:00.3 to group 10
[    2.461812] iommu: Adding device 0000:07:00.4 to group 10
[    2.461992] iommu: Adding device 0000:07:00.6 to group 10
[    2.462115] iommu: Adding device 0000:08:00.0 to group 3
[    2.462465] AMD-Vi: Found IOMMU at 0000:00:00.2 cap 0x40
[    2.462468] AMD-Vi: Extended features (0x4f77ef22294ada):
[    2.462471]  PPR NX GT IA GA PC GA_vAPIC
[    2.463157] AMD-Vi: Lazy IO/TLB flushing enabled
[    2.471079] amd_uncore: AMD NB counters detected
[    2.471096] amd_uncore: AMD LLC counters detected
[    2.481437] Scanning for low memory corruption every 60 seconds
[    2.488272] Initialise system trusted keyrings
[    2.488613] workingset: timestamp_bits=56 max_order=21 bucket_order=0
[    2.521095] NFS: Registering the id_resolver key type
[    2.521161] Key type id_resolver registered
[    2.521169] Key type id_legacy registered
[    2.528392] Key type asymmetric registered
[    2.528417] Asymmetric key parser 'x509' registered
[    2.528506] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
[    2.528525] io scheduler noop registered
[    2.528528] io scheduler deadline registered
[    2.528989] io scheduler cfq registered (default)
[    2.528993] io scheduler mq-deadline registered
[    2.528996] io scheduler kyber registered
[    2.538316] pcieport 0000:00:01.1: AER enabled with IRQ 26
[    2.538483] pcieport 0000:00:01.2: AER enabled with IRQ 27
[    2.539716] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    2.539864] ACPI: Power Button [PWRB]
[    2.540400] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    2.540605] ACPI: Power Button [PWRF]
[    2.541844] ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
[    2.545713] acpi device:03: registered as cooling_device0
[    2.546458] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:02/LNXVIDEO:00/input/input2
[    2.547118] Monitor-Mwait will be used to enter C-1 state
[    2.556005] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    2.577253] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    2.581570] Non-volatile memory driver v1.3
[    2.581874] Linux agpgart interface v0.103
[    2.621516] loop: module loaded
[    2.622593] ahci 0000:02:00.1: version 3.0
[    2.623652] ahci 0000:02:00.1: SSS flag set, parallel bus scan disabled
[    2.623714] ahci 0000:02:00.1: AHCI 0001.0301 32 slots 8 ports 6 Gbps 0x33 impl SATA mode
[    2.623720] ahci 0000:02:00.1: flags: 64bit ncq sntf stag pm led clo only pmp pio slum part sxs deso sadm sds apst 
[    2.633440] scsi host0: ahci
[    2.635398] scsi host1: ahci
[    2.636653] scsi host2: ahci
[    2.637840] scsi host3: ahci
[    2.638864] scsi host4: ahci
[    2.639871] scsi host5: ahci
[    2.640897] scsi host6: ahci
[    2.641847] scsi host7: ahci
[    2.642787] ata1: SATA max UDMA/133 abar m131072@0xfe780000 port 0xfe780100 irq 35
[    2.642793] ata2: SATA max UDMA/133 abar m131072@0xfe780000 port 0xfe780180 irq 35
[    2.642798] ata3: DUMMY
[    2.642802] ata4: DUMMY
[    2.642808] ata5: SATA max UDMA/133 abar m131072@0xfe780000 port 0xfe780300 irq 35
[    2.642814] ata6: SATA max UDMA/133 abar m131072@0xfe780000 port 0xfe780380 irq 35
[    2.642817] ata7: DUMMY
[    2.642819] ata8: DUMMY
[    2.644431] ahci 0000:08:00.0: AHCI 0001.0301 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
[    2.644438] ahci 0000:08:00.0: flags: 64bit ncq sntf ilck pm led clo only pmp fbs pio slum part 
[    2.646028] scsi host8: ahci
[    2.646736] ata9: SATA max UDMA/133 abar m2048@0xfe800000 port 0xfe800100 irq 37
[    2.648620] e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2-NAPI
[    2.648624] e100: Copyright(c) 1999-2006 Intel Corporation
[    2.648782] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
[    2.648786] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    2.648978] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    2.648981] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    2.649238] sky2: driver version 1.30
[    2.659266] libphy: r8169: probed
[    2.660576] r8169 0000:04:00.0 eth0: RTL8168h/8111h, b0:6e:bf:2f:47:8d, XID 54100800, IRQ 38
[    2.660582] r8169 0000:04:00.0 eth0: jumbo features [frames: 9200 bytes, tx checksumming: ko]
[    2.661335] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.661338] ehci-pci: EHCI PCI platform driver
[    2.661437] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    2.661462] ohci-pci: OHCI PCI platform driver
[    2.661556] uhci_hcd: USB Universal Host Controller Interface driver
[    2.662868] xhci_hcd 0000:02:00.0: xHCI Host Controller
[    2.663767] xhci_hcd 0000:02:00.0: new USB bus registered, assigned bus number 1
[    2.719709] xhci_hcd 0000:02:00.0: hcc params 0x0200ef81 hci version 0x110 quirks 0x0000000048000410
[    2.722762] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.19
[    2.722772] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.722776] usb usb1: Product: xHCI Host Controller
[    2.722780] usb usb1: Manufacturer: Linux 4.19.0-rc1+ xhci-hcd
[    2.722784] usb usb1: SerialNumber: 0000:02:00.0
[    2.724602] hub 1-0:1.0: USB hub found
[    2.724821] hub 1-0:1.0: 10 ports detected
[    2.951872] ata9: SATA link down (SStatus 0 SControl 300)
[    2.990462] xhci_hcd 0000:02:00.0: xHCI Host Controller
[    2.991105] xhci_hcd 0000:02:00.0: new USB bus registered, assigned bus number 2
[    2.991130] xhci_hcd 0000:02:00.0: Host supports USB 3.10 Enhanced SuperSpeed
[    2.991392] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[    2.991897] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 4.19
[    2.991902] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.991906] usb usb2: Product: xHCI Host Controller
[    2.991909] usb usb2: Manufacturer: Linux 4.19.0-rc1+ xhci-hcd
[    2.991913] usb usb2: SerialNumber: 0000:02:00.0
[    2.993377] hub 2-0:1.0: USB hub found
[    2.993547] hub 2-0:1.0: 4 ports detected
[    3.098637] xhci_hcd 0000:07:00.3: xHCI Host Controller
[    3.099213] xhci_hcd 0000:07:00.3: new USB bus registered, assigned bus number 3
[    3.099736] xhci_hcd 0000:07:00.3: hcc params 0x0270ffe5 hci version 0x110 quirks 0x0000000040000410
[    3.103481] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.19
[    3.103486] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.103490] usb usb3: Product: xHCI Host Controller
[    3.103494] usb usb3: Manufacturer: Linux 4.19.0-rc1+ xhci-hcd
[    3.103498] usb usb3: SerialNumber: 0000:07:00.3
[    3.104745] hub 3-0:1.0: USB hub found
[    3.104883] hub 3-0:1.0: 4 ports detected
[    3.105116] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    3.108117] xhci_hcd 0000:07:00.3: xHCI Host Controller
[    3.108523] xhci_hcd 0000:07:00.3: new USB bus registered, assigned bus number 4
[    3.108543] xhci_hcd 0000:07:00.3: Host supports USB 3.10 Enhanced SuperSpeed
[    3.108760] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
[    3.109221] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 4.19
[    3.109226] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.109230] usb usb4: Product: xHCI Host Controller
[    3.109234] usb usb4: Manufacturer: Linux 4.19.0-rc1+ xhci-hcd
[    3.109237] usb usb4: SerialNumber: 0000:07:00.3
[    3.110522] hub 4-0:1.0: USB hub found
[    3.110663] hub 4-0:1.0: 4 ports detected
[    3.111955] ata1.00: ATA-8: KINGSTON SV300S37A120G, 608ABBF0, max UDMA/133
[    3.111961] ata1.00: 234441648 sectors, multi 1: LBA48 NCQ (depth 32), AA
[    3.114807] xhci_hcd 0000:07:00.4: xHCI Host Controller
[    3.115287] xhci_hcd 0000:07:00.4: new USB bus registered, assigned bus number 5
[    3.115746] xhci_hcd 0000:07:00.4: hcc params 0x0260ffe5 hci version 0x110 quirks 0x0000000040000410
[    3.117079] ata1.00: configured for UDMA/133
[    3.118452] scsi 0:0:0:0: Direct-Access     ATA      KINGSTON SV300S3 BBF0 PQ: 0 ANSI: 5
[    3.119030] usb usb5: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.19
[    3.119035] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.119039] usb usb5: Product: xHCI Host Controller
[    3.119057] usb usb5: Manufacturer: Linux 4.19.0-rc1+ xhci-hcd
[    3.119061] usb usb5: SerialNumber: 0000:07:00.4
[    3.120315] hub 5-0:1.0: USB hub found
[    3.120453] hub 5-0:1.0: 1 port detected
[    3.122137] xhci_hcd 0000:07:00.4: xHCI Host Controller
[    3.122585] sd 0:0:0:0: [sda] 234441648 512-byte logical blocks: (120 GB/112 GiB)
[    3.122591] xhci_hcd 0000:07:00.4: new USB bus registered, assigned bus number 6
[    3.122612] xhci_hcd 0000:07:00.4: Host supports USB 3.10 Enhanced SuperSpeed
[    3.122726] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    3.122799] sd 0:0:0:0: [sda] Write Protect is off
[    3.122834] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    3.122839] usb usb6: We don't know the algorithms for LPM for this host, disabling LPM.
[    3.123098] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    3.123315] usb usb6: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 4.19
[    3.123320] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.123324] usb usb6: Product: xHCI Host Controller
[    3.123328] usb usb6: Manufacturer: Linux 4.19.0-rc1+ xhci-hcd
[    3.123331] usb usb6: SerialNumber: 0000:07:00.4
[    3.124723] hub 6-0:1.0: USB hub found
[    3.124888] hub 6-0:1.0: 1 port detected
[    3.126564] usbcore: registered new interface driver usblp
[    3.126701] usbcore: registered new interface driver usb-storage
[    3.126910] i8042: PNP: No PS/2 controller found.
[    3.128120]  sda: sda1 sda2 sda3
[    3.128628] rtc_cmos 00:02: RTC can wake from S4
[    3.129483] rtc_cmos 00:02: registered as rtc0
[    3.129743] rtc_cmos 00:02: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    3.131562] device-mapper: ioctl: 4.39.0-ioctl (2018-04-03) initialised: dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
[    3.131754] hidraw: raw HID events driver (C) Jiri Kosina
[    3.132003] sd 0:0:0:0: [sda] Attached SCSI disk
[    3.133531] usbcore: registered new interface driver usbhid
[    3.133534] usbhid: USB HID core driver
[    3.136248] snd_hda_intel 0000:01:00.1: Force to non-snoop mode
[    3.141987] hdaudio hdaudioC0D0: Unable to bind the codec
[    3.143472] hdaudio hdaudioC1D0: Unable to bind the codec
[    3.145646] Initializing XFRM netlink socket
[    3.149482] NET: Registered protocol family 10
[    3.153515] Segment Routing with IPv6
[    3.154614] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    3.155732] hdaudio hdaudioC2D0: Unable to bind the codec
[    3.155838] NET: Registered protocol family 17
[    3.156222] Key type dns_resolver registered
[    3.163587] microcode: CPU0: patch_level=0x0810100b
[    3.163631] microcode: CPU1: patch_level=0x0810100b
[    3.163662] microcode: CPU2: patch_level=0x0810100b
[    3.163706] microcode: CPU3: patch_level=0x0810100b
[    3.163731] microcode: CPU4: patch_level=0x0810100b
[    3.163763] microcode: CPU5: patch_level=0x0810100b
[    3.163788] microcode: CPU6: patch_level=0x0810100b
[    3.163812] microcode: CPU7: patch_level=0x0810100b
[    3.164095] microcode: Microcode Update Driver: v2.2.
[    3.164190] sched_clock: Marking stable (3170008581, -5959518)->(3289999433, -125950370)
[    3.165431] registered taskstats version 1
[    3.165434] Loading compiled-in X.509 certificates
[    3.172256]   Magic number: 2:388:179
[    3.172363] acpi device:0f: hash matches
[    3.172536] console [netcon0] enabled
[    3.172539] netconsole: network logging started
[    3.174159] acpi_cpufreq: overriding BIOS provided _PSD data
[    3.179817] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    3.191581] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    3.192279] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[    3.192336] cfg80211: failed to load regulatory.db
[    3.192590] ALSA device list:
[    3.192594]   No soundcards found.
[    3.317102] usb 1-1: new high-speed USB device number 2 using xhci_hcd
[    3.431975] ata2: SATA link down (SStatus 0 SControl 300)
[    3.454237] usb 1-1: New USB device found, idVendor=0409, idProduct=005a, bcdDevice= 1.00
[    3.454251] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    3.461878] hub 1-1:1.0: USB hub found
[    3.464417] hub 1-1:1.0: 4 ports detected
[    3.481185] tsc: Refined TSC clocksource calibration: 3593.252 MHz
[    3.481212] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x33cb6cd4eba, max_idle_ns: 440795374140 ns
[    3.481397] clocksource: Switched to clocksource tsc
[    3.564562] usb 2-2: new SuperSpeed Gen 1 USB device number 2 using xhci_hcd
[    3.588177] usb 2-2: New USB device found, idVendor=2001, idProduct=4a00, bcdDevice= 1.00
[    3.588185] usb 2-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.588190] usb 2-2: Product: D-Link DUB-1312
[    3.588196] usb 2-2: Manufacturer: D-Link Elec. Corp.
[    3.588201] usb 2-2: SerialNumber: 000000000018A9
[    3.744168] ata5: SATA link down (SStatus 0 SControl 300)
[    3.796460] usb 1-1.4: new low-speed USB device number 3 using xhci_hcd
[    4.055976] ata6: SATA link down (SStatus 0 SControl 300)
[    4.121262] usb 1-1.4: New USB device found, idVendor=046d, idProduct=c31c, bcdDevice=64.00
[    4.121275] usb 1-1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    4.121284] usb 1-1.4: Product: USB Keyboard
[    4.121294] usb 1-1.4: Manufacturer: Logitech
[    4.233576] input: Logitech USB Keyboard as /devices/pci0000:00/0000:00:01.2/0000:02:00.0/usb1/1-1/1-1.4/1-1.4:1.0/0003:046D:C31C.0001/input/input3
[    4.291809] hid-generic 0003:046D:C31C.0001: input,hidraw0: USB HID v1.10 Keyboard [Logitech USB Keyboard] on usb-0000:02:00.0-1.4/input0
[    4.422393] input: Logitech USB Keyboard Consumer Control as /devices/pci0000:00/0000:00:01.2/0000:02:00.0/usb1/1-1/1-1.4/1-1.4:1.1/0003:046D:C31C.0002/input/input4
[    4.475383] input: Logitech USB Keyboard System Control as /devices/pci0000:00/0000:00:01.2/0000:02:00.0/usb1/1-1/1-1.4/1-1.4:1.1/0003:046D:C31C.0002/input/input5
[    4.476660] input: Logitech USB Keyboard Consumer Control as /devices/pci0000:00/0000:00:01.2/0000:02:00.0/usb1/1-1/1-1.4/1-1.4:1.1/0003:046D:C31C.0002/input/input6
[    4.477871] hid-generic 0003:046D:C31C.0002: input,hidraw1: USB HID v1.10 Device [Logitech USB Keyboard] on usb-0000:02:00.0-1.4/input1
[    4.520315] input: Logitech USB Keyboard as /devices/pci0000:00/0000:00:01.2/0000:02:00.0/usb1/1-1/1-1.4/1-1.4:1.2/0003:046D:C31C.0003/input/input7
[    4.521511] hid-generic 0003:046D:C31C.0003: input,hidraw2: USB HID v1.10 Mouse [Logitech USB Keyboard] on usb-0000:02:00.0-1.4/input2
[    4.554225] Freeing unused kernel image memory: 1604K
[    4.566704] Write protecting the kernel read-only data: 32768k
[    4.571658] Freeing unused kernel image memory: 2004K
[    4.572649] Freeing unused kernel image memory: 1564K
[    4.572675] Run /init as init process
[    4.646229] systemd[1]: systemd 238 running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=hybrid)
[    4.659687] systemd[1]: Detected architecture x86-64.
[    4.659704] systemd[1]: Running in initial RAM disk.
[    4.664310] systemd[1]: Set hostname to <raven>.
[    4.816286] systemd[1]: File /usr/lib/systemd/system/systemd-journald.service:35 configures an IP firewall (IPAddressDeny=any), but the local system does not support BPF/cgroup based firewalling.
[    4.816302] systemd[1]: Proceeding WITHOUT firewalling in effect! (This warning is only shown for the first loaded unit using IP firewalling.)
[    4.827260] random: systemd: uninitialized urandom read (16 bytes read)
[    4.827970] systemd[1]: Listening on Journal Socket.
[    4.828201] random: systemd: uninitialized urandom read (16 bytes read)
[    4.828236] systemd[1]: Reached target Local File Systems.
[    4.828701] random: systemd: uninitialized urandom read (16 bytes read)
[    4.828737] systemd[1]: Reached target Swap.
[    4.828800] systemd[1]: Reached target Slices.
[    4.882188] audit: type=1130 audit(1536153091.886:2): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-tmpfiles-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    4.885115] audit: type=1130 audit(1536153091.889:3): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-tmpfiles-setup-dev comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.026180] dracut-cmdline (1503) used greatest stack depth: 21336 bytes left
[    5.027897] audit: type=1130 audit(1536153092.032:4): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-cmdline comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.094655] audit: type=1130 audit(1536153092.099:5): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-pre-udev comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.127635] audit: type=1130 audit(1536153092.132:6): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-vconsole-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.127760] audit: type=1131 audit(1536153092.132:7): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-vconsole-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.128789] audit: type=1130 audit(1536153092.133:8): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-udevd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.239319] audit: type=1130 audit(1536153092.244:9): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-journald comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.850526] audit: type=1130 audit(1536153092.849:10): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-udev-trigger comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.898825] r8169 0000:04:00.0 enp4s0: renamed from eth0
[    5.909259] ata_id (2398) used greatest stack depth: 20896 bytes left
[    5.917898] audit: type=1130 audit(1536153092.921:11): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=plymouth-start comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    6.255989] ax88179_178a 2-2:1.0 eth0: register 'ax88179_178a' at usb-0000:02:00.0-2, D-Link DUB-1312 USB 3.0 to Gigabit Ethernet Adapter, 54:b8:0a:ef:ed:d7
[    6.257235] usbcore: registered new interface driver ax88179_178a
[    6.265544] ax88179_178a 2-2:1.0 enp2s0f0u2: renamed from eth0
[    6.368949] systemd-udevd (2094) used greatest stack depth: 20256 bytes left
[    6.373773] systemd-udevd (2027) used greatest stack depth: 18744 bytes left
[    6.380327] audit: type=1130 audit(1536153093.385:12): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-initqueue comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    6.444425] audit: type=1130 audit(1536153093.449:13): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-fsck-root comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    6.449964] random: fast init done
[    6.493721] EXT4-fs (sda3): mounted filesystem with ordered data mode. Opts: (null)
[    6.559944] systemd-fstab-g (2438) used greatest stack depth: 18376 bytes left
[    6.748635] audit: type=1130 audit(1536153093.753:14): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=initrd-parse-etc comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    7.362180] systemd-journald[1499]: Received SIGTERM from PID 1 (systemd).
[    7.502628] systemd: 23 output lines suppressed due to ratelimiting
[    7.620141] SELinux:  Disabled at runtime.
[    7.692439] systemd[1]: systemd 238 running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=hybrid)
[    7.704945] systemd[1]: Detected architecture x86-64.
[    7.706438] systemd[1]: Set hostname to <raven>.
[    7.815397] anaconda-genera (2496) used greatest stack depth: 17792 bytes left
[    7.896348] systemd[1]: File /usr/lib/systemd/system/systemd-journald.service:35 configures an IP firewall (IPAddressDeny=any), but the local system does not support BPF/cgroup based firewalling.
[    7.896365] systemd[1]: Proceeding WITHOUT firewalling in effect! (This warning is only shown for the first loaded unit using IP firewalling.)
[    8.054348] systemd[1]: Stopped Switch Root.
[    8.055034] systemd[1]: systemd-journald.service: Service has no hold-off time, scheduling restart.
[    8.055145] systemd[1]: systemd-journald.service: Scheduled restart job, restart counter is at 1.
[    8.055182] systemd[1]: Stopped Journal Service.
[    8.059417] systemd[1]: Starting Journal Service...
[    8.112180] EXT4-fs (sda3): re-mounted. Opts: (null)
[    8.197248] systemd-journald[2517]: Received request to flush runtime journal from PID 1
[    8.473568] journal-offline (2770) used greatest stack depth: 17704 bytes left
[    9.384246] Adding 7826428k swap on /dev/sda2.  Priority:-2 extents:1 across:7826428k SS
[    9.797203] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[   10.786692] random: crng init done
[   10.786701] random: 7 urandom warning(s) missed due to ratelimiting
[   10.807059] IPv6: ADDRCONF(NETDEV_UP): enp2s0f0u2: link is not ready
[   11.140496] plymouthd (2397) used greatest stack depth: 15712 bytes left
[   11.173304] IPv6: ADDRCONF(NETDEV_UP): enp2s0f0u2: link is not ready
[   11.181689] IPv6: ADDRCONF(NETDEV_UP): enp4s0: link is not ready
[   11.197626] Generic PHY r8169-400:00: attached PHY driver [Generic PHY] (mii_bus:phy_addr=r8169-400:00, irq=IGNORE)
[   11.284951] IPv6: ADDRCONF(NETDEV_UP): enp4s0: link is not ready
[   14.110188] ax88179_178a 2-2:1.0 enp2s0f0u2: ax88179 - Link status is: 1
[   14.131256] IPv6: ADDRCONF(NETDEV_CHANGE): enp2s0f0u2: link becomes ready
[   33.848271] [drm] amdgpu kernel modesetting enabled.
[   33.849321] Parsing CRAT table with 1 nodes
[   33.849596] Creating topology SYSFS entries
[   33.850767] Topology: Add APU node [0x0:0x0]
[   33.850771] Finished initializing topology
[   33.851920] amdgpu 0000:01:00.0: enabling device (0000 -> 0003)
[   33.855393] [drm] initializing kernel modesetting (POLARIS10 0x1002:0x67C4 0x1002:0x0B0D 0x00).
[   33.855512] [drm] register mmio base: 0xFE900000
[   33.855515] [drm] register mmio size: 262144
[   33.855604] [drm] add ip block number 0 <vi_common>
[   33.855607] [drm] add ip block number 1 <gmc_v8_0>
[   33.855611] [drm] add ip block number 2 <tonga_ih>
[   33.855614] [drm] add ip block number 3 <powerplay>
[   33.855617] [drm] add ip block number 4 <dm>
[   33.855621] [drm] add ip block number 5 <gfx_v8_0>
[   33.855624] [drm] add ip block number 6 <sdma_v3_0>
[   33.855627] [drm] add ip block number 7 <uvd_v6_0>
[   33.855630] [drm] add ip block number 8 <vce_v3_0>
[   33.855874] [drm] UVD is enabled in VM mode
[   33.855877] [drm] UVD ENC is enabled in VM mode
[   33.855883] [drm] VCE enabled in VM mode
[   33.971305] ATOM BIOS: 113-C9540101-006
[   33.971351] [drm] GPU posting now...
[   34.131029] [drm] vm size is 64 GB, 2 levels, block size is 10-bit, fragment size is 9-bit
[   34.140329] amdgpu 0000:01:00.0: VRAM: 8192M 0x000000F400000000 - 0x000000F5FFFFFFFF (8192M used)
[   34.140336] amdgpu 0000:01:00.0: GART: 256M 0x00000000F0000000 - 0x00000000FFFFFFFF
[   34.140369] [drm] Detected VRAM RAM=8192M, BAR=256M
[   34.140372] [drm] RAM width 256bits GDDR5
[   34.142048] [TTM] Zone  kernel: Available graphics memory: 3085528 kiB
[   34.142072] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[   34.142076] [TTM] Initializing pool allocator
[   34.142433] [TTM] Initializing DMA pool allocator
[   34.143470] [drm] amdgpu: 8192M of VRAM memory ready
[   34.143532] [drm] amdgpu: 4519M of GTT memory ready.
[   34.143959] [drm] GART: num cpu pages 65536, num gpu pages 65536
[   34.145428] [drm] PCIE GART of 256M enabled (table at 0x000000F400000000).
[   34.150238] [drm] Chained IB support enabled!
[   34.168205] [drm] Found UVD firmware Version: 65.4 Family ID: 16
[   34.172870] [drm] Found VCE firmware Version: 55.1 Binary ID: 3
[   34.263789] [drm] DM_PPLIB: values for Engine clock
[   34.263794] [drm] DM_PPLIB:	 300000
[   34.263796] [drm] DM_PPLIB:	 567000
[   34.263799] [drm] DM_PPLIB:	 849000
[   34.263802] [drm] DM_PPLIB:	 1076000
[   34.263804] [drm] DM_PPLIB:	 1153000
[   34.263807] [drm] DM_PPLIB:	 1181000
[   34.263809] [drm] DM_PPLIB:	 1209000
[   34.263812] [drm] DM_PPLIB:	 1243000
[   34.263815] [drm] DM_PPLIB: Validation clocks:
[   34.263818] [drm] DM_PPLIB:    engine_max_clock: 124300
[   34.263821] [drm] DM_PPLIB:    memory_max_clock: 175000
[   34.263823] [drm] DM_PPLIB:    level           : 8
[   34.263827] [drm] DM_PPLIB: values for Memory clock
[   34.263830] [drm] DM_PPLIB:	 300000
[   34.263833] [drm] DM_PPLIB:	 1750000
[   34.263836] [drm] DM_PPLIB: Validation clocks:
[   34.263838] [drm] DM_PPLIB:    engine_max_clock: 124300
[   34.263841] [drm] DM_PPLIB:    memory_max_clock: 175000
[   34.263843] [drm] DM_PPLIB:    level           : 8
[   34.265515] [drm] Display Core initialized with v3.1.65!
[   34.279860] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   34.279864] [drm] Driver supports precise vblank timestamp query.
[   34.312026] [drm] UVD and UVD ENC initialized successfully.
[   34.413013] [drm] VCE initialized successfully.
[   34.419601] kfd kfd: Allocated 3969056 bytes on gart
[   34.419791] Topology: Add APU node [0x67c4:0x1002]
[   34.421100] kfd kfd: added device 1002:67c4
[   34.422722] [drm] Cannot find any crtc or sizes
[   34.443249] [drm] Initialized amdgpu 3.27.0 20150101 for 0000:01:00.0 on minor 0
[   34.446588] [drm] initializing kernel modesetting (RAVEN 0x1002:0x15DD 0x1043:0x876B 0xC6).
[   34.446683] [drm] register mmio base: 0xFE500000
[   34.446686] [drm] register mmio size: 524288
[   34.446767] [drm] add ip block number 0 <soc15_common>
[   34.446770] [drm] add ip block number 1 <gmc_v9_0>
[   34.446773] [drm] add ip block number 2 <vega10_ih>
[   34.446776] [drm] add ip block number 3 <psp>
[   34.446779] [drm] add ip block number 4 <powerplay>
[   34.446782] [drm] add ip block number 5 <dm>
[   34.446785] [drm] add ip block number 6 <gfx_v9_0>
[   34.446788] [drm] add ip block number 7 <sdma_v4_0>
[   34.446791] [drm] add ip block number 8 <vcn_v1_0>
[   34.449187] kfd kfd: DID 15dd is missing in supported_devices
[   34.449192] kfd kfd: kgd2kfd_probe failed
[   34.449538] [drm] VCN decode is enabled in VM mode
[   34.449541] [drm] VCN encode is enabled in VM mode
[   34.449543] [drm] VCN jpeg decode is enabled in VM mode
[   34.474029] [drm] BIOS signature incorrect 20 7
[   34.474160] ATOM BIOS: 113-RAVEN-106
[   34.475052] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, fragment size is 9-bit
[   34.475121] amdgpu 0000:07:00.0: VRAM: 1024M 0x000000F400000000 - 0x000000F43FFFFFFF (1024M used)
[   34.475126] amdgpu 0000:07:00.0: GART: 1024M 0x0000000000000000 - 0x000000003FFFFFFF
[   34.475153] [drm] Detected VRAM RAM=1024M, BAR=1024M
[   34.475157] [drm] RAM width 128bits DDR4
[   34.475323] [drm] amdgpu: 1024M of VRAM memory ready
[   34.475348] [drm] amdgpu: 3072M of GTT memory ready.
[   34.475591] [drm] GART: num cpu pages 262144, num gpu pages 262144
[   34.476243] [drm] PCIE GART of 1024M enabled (table at 0x000000F400900000).
[   34.498234] [drm] use_doorbell being set to: [true]
[   34.500496] [drm] Found VCN firmware Version ENC: 1.4 DEC: 1 VEP: 0 Revision: 0
[   34.500565] [drm] PSP loading VCN firmware
[   34.526243] [drm] reserve 0x400000 from 0xf400e00000 for PSP TMR SIZE
[   34.583317] amdgpu: [powerplay] dpm has been enabled
[   34.584373] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:908
[   34.584516] in_atomic(): 1, irqs_disabled(): 0, pid: 3855, name: modprobe
[   34.584633] 2 locks held by modprobe/3855:
[   34.584636]  #0: 000000008c30d48f (&dev->mutex){....}, at: __driver_attach+0x9b/0x140
[   34.584663]  #1: 00000000d0eda65e (drm_global_mutex){+.+.}, at: drm_dev_register+0x32/0x1f0
[   34.584689] CPU: 0 PID: 3855 Comm: modprobe Not tainted 4.19.0-rc1+ #24
[   34.584693] Hardware name: System manufacturer System Product Name/TUF B350M-PLUS GAMING, BIOS 4011 04/19/2018
[   34.584697] Call Trace:
[   34.584704]  dump_stack+0xd1/0x16c
[   34.584711]  ? dump_stack_print_info.cold.1+0x2f/0x2f
[   34.584726]  ___might_sleep.cold.82+0xbd/0xce
[   34.584732]  ? cpu_extra_stat_show+0x10/0x10
[   34.584737]  ? match_held_lock+0x92/0x330
[   34.584744]  ? save_trace+0x1b0/0x1b0
[   34.584748]  ? __might_sleep+0x2c/0xc0
[   34.584758]  __mutex_lock+0x138/0xee0
[   34.584763]  ? save_trace+0x1b0/0x1b0
[   34.584768]  ? match_held_lock+0x92/0x330
[   34.584960]  ? pp_get_clock_by_type_with_voltage+0x36/0x60 [amdgpu]
[   34.584971]  ? mutex_trylock+0x1b0/0x1b0
[   34.584977]  ? print_usage_bug+0xf0/0xf0
[   34.584984]  ? find_held_lock+0xac/0xd0
[   34.584994]  ? __is_insn_slot_addr+0x179/0x240
[   34.585002]  ? lock_downgrade+0x300/0x300
[   34.585007]  ? match_held_lock+0x7f/0x330
[   34.585013]  ? save_trace+0x1b0/0x1b0
[   34.585018]  ? lock_release+0x480/0x480
[   34.585023]  ? __module_address+0x25b/0x340
[   34.585033]  ? rcu_is_watching+0x98/0xe0
[   34.585042]  ? deref_stack_reg+0x9d/0xe0
[   34.585051]  ? find_held_lock+0xac/0xd0
[   34.585061]  ? depot_save_stack+0x288/0x460
[   34.585070]  ? mark_held_locks+0x8b/0xb0
[   34.585076]  ? _raw_spin_unlock_irqrestore+0x3e/0x50
[   34.585083]  ? lockdep_hardirqs_on+0x17a/0x250
[   34.585088]  ? _raw_spin_unlock_irqrestore+0x3e/0x50
[   34.585093]  ? trace_hardirqs_on+0x72/0x1b0
[   34.585099]  ? trace_hardirqs_off_caller+0x1b0/0x1b0
[   34.585106]  ? unwind_get_return_address+0x2a/0x40
[   34.585298]  ? pp_set_watermarks_for_clocks_ranges+0x60/0x60 [amdgpu]
[   34.585484]  ? pp_get_clock_by_type_with_voltage+0x36/0x60 [amdgpu]
[   34.585668]  pp_get_clock_by_type_with_voltage+0x36/0x60 [amdgpu]
[   34.585857]  dm_pp_get_clock_levels_by_type_with_voltage+0xeb/0x140 [amdgpu]
[   34.586047]  ? dm_pp_get_clock_levels_by_type_with_latency+0x270/0x270 [amdgpu]
[   34.586234]  ? dcn10_create_resource_pool+0x5fb/0xff0 [amdgpu]
[   34.586250]  ? do_init_module+0x14e/0x3c0
[   34.586254]  ? load_module+0x3bfe/0x3f00
[   34.586259]  ? __do_sys_finit_module+0x18f/0x1c0
[   34.586264]  ? do_syscall_64+0xfc/0x370
[   34.586270]  ? entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   34.586461]  dcn_bw_update_from_pplib+0xf1/0x530 [amdgpu]
[   34.586652]  ? dcn_find_dcfclk_suits_all+0x610/0x610 [amdgpu]
[   34.586859]  ? dcn10_create_resource_pool+0x5fb/0xff0 [amdgpu]
[   34.587046]  ? dcn10_create_resource_pool+0x5fb/0xff0 [amdgpu]
[   34.587237]  dcn10_create_resource_pool+0xbf5/0xff0 [amdgpu]
[   34.587244]  ? save_trace+0x1b0/0x1b0
[   34.587436]  ? dcn10_clock_source_destroy+0x30/0x30 [amdgpu]
[   34.587626]  ? dal_gpio_service_create+0xe7/0x180 [amdgpu]
[   34.587817]  dc_create_resource_pool+0x8b/0x240 [amdgpu]
[   34.588004]  ? resource_parse_asic_id+0x170/0x170 [amdgpu]
[   34.588012]  ? kasan_kmalloc+0xbf/0xe0
[   34.588202]  ? dal_gpio_service_create+0xe7/0x180 [amdgpu]
[   34.588207]  ? __kmalloc+0x121/0x290
[   34.588393]  ? dal_gpio_service_create+0xe7/0x180 [amdgpu]
[   34.588585]  dc_create+0x407/0xc80 [amdgpu]
[   34.588594]  ? save_trace+0x1b0/0x1b0
[   34.588800]  ? dc_create_state+0xe0/0xe0 [amdgpu]
[   34.588816]  ? kasan_unpoison_shadow+0x30/0x40
[   34.588822]  ? kasan_kmalloc+0xbf/0xe0
[   34.588996]  ? amdgpu_cgs_create_device+0x27/0x60 [amdgpu]
[   34.589000]  ? kmem_cache_alloc_trace+0x107/0x230
[   34.589162]  ? amdgpu_cgs_create_device+0x27/0x60 [amdgpu]
[   34.589334]  dm_hw_init+0x212/0x320 [amdgpu]
[   34.589504]  ? dm_resume+0x580/0x580 [amdgpu]
[   34.589509]  ? kmsg_dump_rewind_nolock+0x54/0x54
[   34.589682]  ? psm_set_states+0xc3/0xe0 [amdgpu]
[   34.589850]  ? hwmgr_hw_init+0x27e/0x2a0 [amdgpu]
[   34.590022]  amdgpu_device_init.cold.33+0x11c9/0x1783 [amdgpu]
[   34.590175]  ? amdgpu_device_has_dc_support+0x30/0x30 [amdgpu]
[   34.590187]  ? rcu_read_lock_sched_held+0x93/0xa0
[   34.590192]  ? __alloc_pages_nodemask+0x5b8/0x600
[   34.590199]  ? __alloc_pages_slowpath+0x1aa0/0x1aa0
[   34.590204]  ? __save_stack_trace+0x8d/0xf0
[   34.590217]  ? save_trace+0x1b0/0x1b0
[   34.590224]  ? __kasan_slab_free+0x125/0x170
[   34.590227]  ? kfree+0xcd/0x260
[   34.590232]  ? drm_dev_register+0x164/0x1f0
[   34.590383]  ? amdgpu_pci_probe+0x19e/0x220 [amdgpu]
[   34.590388]  ? local_pci_probe+0x6b/0xc0
[   34.590392]  ? pci_device_probe+0x195/0x260
[   34.590397]  ? driver_probe_device+0x69/0xf0
[   34.590401]  ? __driver_attach+0x130/0x140
[   34.590405]  ? bus_for_each_dev+0xe4/0x140
[   34.590409]  ? bus_add_driver+0x279/0x2c0
[   34.590418]  ? __lock_is_held+0x51/0xc0
[   34.590562]  ? amdgpu_driver_load_kms+0xe4/0x410 [amdgpu]
[   34.590566]  ? rcu_read_lock_sched_held+0x93/0xa0
[   34.590693]  amdgpu_driver_load_kms+0x121/0x410 [amdgpu]
[   34.590819]  ? amdgpu_driver_unload_kms+0xd0/0xd0 [amdgpu]
[   34.590823]  ? drm_dev_register+0x164/0x1f0
[   34.590828]  ? lockdep_hardirqs_on+0x17a/0x250
[   34.590839]  ? __kasan_slab_free+0x13a/0x170
[   34.590848]  drm_dev_register+0x1a6/0x1f0
[   34.590975]  amdgpu_pci_probe+0x19e/0x220 [amdgpu]
[   34.591101]  ? amdgpu_pmops_runtime_idle+0x190/0x190 [amdgpu]
[   34.591106]  local_pci_probe+0x6b/0xc0
[   34.591112]  pci_device_probe+0x195/0x260
[   34.591117]  ? pci_device_remove+0x240/0x240
[   34.591128]  really_probe+0x3a5/0x480
[   34.591134]  ? device_attach+0x10/0x10
[   34.591138]  ? trace_hardirqs_off_caller+0x1b0/0x1b0
[   34.591142]  ? _raw_spin_unlock_irqrestore+0x3e/0x50
[   34.591151]  ? driver_probe_device+0xf0/0xf0
[   34.591157]  ? driver_probe_device+0xf0/0xf0
[   34.591161]  driver_probe_device+0x69/0xf0
[   34.591167]  __driver_attach+0x130/0x140
[   34.591173]  bus_for_each_dev+0xe4/0x140
[   34.591178]  ? subsys_dev_iter_exit+0x10/0x10
[   34.591183]  ? bus_add_driver+0x78/0x2c0
[   34.591187]  ? kmem_cache_alloc_trace+0x107/0x230
[   34.591194]  bus_add_driver+0x279/0x2c0
[   34.591201]  driver_register+0xca/0x140
[   34.591208]  __pci_register_driver+0x148/0x180
[   34.591214]  ? pci_bus_num_vf+0x10/0x10
[   34.591219]  ? 0xffffffffc0948000
[   34.591226]  ? 0xffffffffc0948000
[   34.591231]  do_one_initcall+0xd5/0x462
[   34.591236]  ? trace_event_raw_event_initcall_finish+0x130/0x130
[   34.591240]  ? find_held_lock+0xac/0xd0
[   34.591248]  ? trace_hardirqs_on_thunk+0x1a/0x1c
[   34.591254]  ? irq_exit+0x81/0x110
[   34.591259]  ? retint_kernel+0x10/0x10
[   34.591271]  ? __memset+0x24/0x30
[   34.591276]  ? kasan_unpoison_shadow+0x30/0x40
[   34.591285]  do_init_module+0x14e/0x3c0
[   34.591291]  ? __x64_sys_delete_module+0x3c0/0x3c0
[   34.591294]  ? __lock_is_held+0x38/0xc0
[   34.591305]  load_module+0x3bfe/0x3f00
[   34.591327]  ? module_frob_arch_sections+0x20/0x20
[   34.591332]  ? fsnotify+0x954/0x970
[   34.591342]  ? fsnotify+0x970/0x970
[   34.591346]  ? __fsnotify_parent+0x7f/0x210
[   34.591351]  ? fsnotify+0x970/0x970
[   34.591362]  ? vfs_read+0x181/0x1b0
[   34.591366]  ? vfs_read+0xce/0x1b0
[   34.591372]  ? kernel_read+0x6f/0x90
[   34.591380]  ? kernel_read_file+0x201/0x420
[   34.591386]  ? __ia32_sys_uselib+0x1e0/0x1e0
[   34.591392]  ? do_mmap+0x58a/0x8b0
[   34.591400]  ? up_write+0xc1/0x160
[   34.591404]  ? up_read+0x90/0x90
[   34.591417]  ? __do_sys_finit_module+0x18f/0x1c0
[   34.591421]  __do_sys_finit_module+0x18f/0x1c0
[   34.591426]  ? __ia32_sys_init_module+0x40/0x40
[   34.591431]  ? vfs_statx_fd+0x3f/0x80
[   34.591438]  ? __do_sys_newfstat+0xb5/0xc0
[   34.591442]  ? mark_held_locks+0x23/0xb0
[   34.591446]  ? do_syscall_64+0x8a/0x370
[   34.591461]  do_syscall_64+0xfc/0x370
[   34.591466]  ? syscall_return_slowpath+0x2a0/0x2a0
[   34.591469]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[   34.591474]  ? trace_hardirqs_on_caller+0x1b0/0x1b0
[   34.591478]  ? prepare_exit_to_usermode+0x1e0/0x1e0
[   34.591482]  ? lockdep_hardirqs_on+0x17a/0x250
[   34.591486]  ? _raw_spin_unlock_irq+0x24/0x30
[   34.591489]  ? lockdep_sys_exit+0x16/0x31
[   34.591496]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[   34.591505]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   34.591508] RIP: 0033:0x7f1790b4e879
[   34.591513] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d f7 45 2c 00 f7 d8 64 89 01 48
[   34.591516] RSP: 002b:00007fff0cb7bce8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   34.591522] RAX: ffffffffffffffda RBX: 0000561603ac8b80 RCX: 00007f1790b4e879
[   34.591525] RDX: 0000000000000000 RSI: 00005616022e43e6 RDI: 0000000000000007
[   34.591527] RBP: 00005616022e43e6 R08: 0000000000000000 R09: 0000000000000000
[   34.591530] R10: 0000000000000007 R11: 0000000000000246 R12: 0000000000000000
[   34.591533] R13: 0000561603ac8cb0 R14: 0000000000040000 R15: 0000000000000000
[   34.591581] [drm] DM_PPLIB: values for Invalid clock
[   34.591584] [drm] DM_PPLIB:	 0 in kHz
[   34.591587] [drm] DM_PPLIB:	 400000 in kHz
[   34.591589] [drm] DM_PPLIB:	 933000 in kHz
[   34.591592] [drm] DM_PPLIB:	 1067000 in kHz
[   34.591800] WARNING: CPU: 0 PID: 3855 at drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:1379 dcn_bw_update_from_pplib+0x309/0x530 [amdgpu]
[   34.591804] Modules linked in: amdgpu(+) mfd_core chash gpu_sched ttm ax88179_178a usbnet
[   34.591826] CPU: 0 PID: 3855 Comm: modprobe Tainted: G        W         4.19.0-rc1+ #24
[   34.591828] Hardware name: System manufacturer System Product Name/TUF B350M-PLUS GAMING, BIOS 4011 04/19/2018
[   34.591970] RIP: 0010:dcn_bw_update_from_pplib+0x309/0x530 [amdgpu]
[   34.591977] Code: 75 2b 00 dc f9 d9 c9 dc 4c 24 08 dc 0d 08 75 2b 00 de f1 d9 5c 24 08 e8 05 0f 41 c9 f3 0f 10 5c 24 08 f3 41 0f 11 5f 4c eb 02 <0f> 0b 4c 8d a4 24 c0 00 00 00 48 8b 3c 24 be 04 00 00 00 4c 89 e2
[   34.591979] RSP: 0018:ffff8801ecefe798 EFLAGS: 00010246
[   34.591984] RAX: 0000000000000000 RBX: ffff8801ecefe7d8 RCX: ffffffffc0592af8
[   34.591987] RDX: 0000000000000007 RSI: dffffc0000000000 RDI: ffff8801ecefe7dc
[   34.591990] RBP: ffff8801f2711100 R08: ffffed003ff83ccb R09: ffffed003ff83cca
[   34.591993] R10: ffffed003ff83cca R11: ffff8801ffc1e657 R12: 0000000000000004
[   34.591996] R13: 1ffff1003d9dfcf7 R14: ffff8801f5fca780 R15: 0000000000000000
[   34.591999] FS:  00007f17916700c0(0000) GS:ffff8801ffc00000(0000) knlGS:0000000000000000
[   34.592004] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   34.592009] CR2: 000055f7acf85e10 CR3: 00000001f0d56000 CR4: 00000000003406f0
[   34.592012] Call Trace:
[   34.592158]  ? dcn_find_dcfclk_suits_all+0x610/0x610 [amdgpu]
[   34.592317]  ? dcn10_create_resource_pool+0x5fb/0xff0 [amdgpu]
[   34.592464]  ? dcn10_create_resource_pool+0x5fb/0xff0 [amdgpu]
[   34.592611]  dcn10_create_resource_pool+0xbf5/0xff0 [amdgpu]
[   34.592620]  ? save_trace+0x1b0/0x1b0
[   34.592766]  ? dcn10_clock_source_destroy+0x30/0x30 [amdgpu]
[   34.592914]  ? dal_gpio_service_create+0xe7/0x180 [amdgpu]
[   34.593063]  dc_create_resource_pool+0x8b/0x240 [amdgpu]
[   34.593208]  ? resource_parse_asic_id+0x170/0x170 [amdgpu]
[   34.593216]  ? kasan_kmalloc+0xbf/0xe0
[   34.593361]  ? dal_gpio_service_create+0xe7/0x180 [amdgpu]
[   34.593366]  ? __kmalloc+0x121/0x290
[   34.593508]  ? dal_gpio_service_create+0xe7/0x180 [amdgpu]
[   34.593656]  dc_create+0x407/0xc80 [amdgpu]
[   34.593664]  ? save_trace+0x1b0/0x1b0
[   34.593820]  ? dc_create_state+0xe0/0xe0 [amdgpu]
[   34.593832]  ? kasan_unpoison_shadow+0x30/0x40
[   34.593836]  ? kasan_kmalloc+0xbf/0xe0
[   34.593976]  ? amdgpu_cgs_create_device+0x27/0x60 [amdgpu]
[   34.593981]  ? kmem_cache_alloc_trace+0x107/0x230
[   34.594117]  ? amdgpu_cgs_create_device+0x27/0x60 [amdgpu]
[   34.594265]  dm_hw_init+0x212/0x320 [amdgpu]
[   34.594412]  ? dm_resume+0x580/0x580 [amdgpu]
[   34.594416]  ? kmsg_dump_rewind_nolock+0x54/0x54
[   34.594563]  ? psm_set_states+0xc3/0xe0 [amdgpu]
[   34.594706]  ? hwmgr_hw_init+0x27e/0x2a0 [amdgpu]
[   34.594852]  amdgpu_device_init.cold.33+0x11c9/0x1783 [amdgpu]
[   34.594982]  ? amdgpu_device_has_dc_support+0x30/0x30 [amdgpu]
[   34.594994]  ? rcu_read_lock_sched_held+0x93/0xa0
[   34.594998]  ? __alloc_pages_nodemask+0x5b8/0x600
[   34.595004]  ? __alloc_pages_slowpath+0x1aa0/0x1aa0
[   34.595008]  ? __save_stack_trace+0x8d/0xf0
[   34.595019]  ? save_trace+0x1b0/0x1b0
[   34.595025]  ? __kasan_slab_free+0x125/0x170
[   34.595028]  ? kfree+0xcd/0x260
[   34.595032]  ? drm_dev_register+0x164/0x1f0
[   34.595166]  ? amdgpu_pci_probe+0x19e/0x220 [amdgpu]
[   34.595171]  ? local_pci_probe+0x6b/0xc0
[   34.595174]  ? pci_device_probe+0x195/0x260
[   34.595179]  ? driver_probe_device+0x69/0xf0
[   34.595182]  ? __driver_attach+0x130/0x140
[   34.595187]  ? bus_for_each_dev+0xe4/0x140
[   34.595191]  ? bus_add_driver+0x279/0x2c0
[   34.595203]  ? __lock_is_held+0x51/0xc0
[   34.595356]  ? amdgpu_driver_load_kms+0xe4/0x410 [amdgpu]
[   34.595361]  ? rcu_read_lock_sched_held+0x93/0xa0
[   34.595491]  amdgpu_driver_load_kms+0x121/0x410 [amdgpu]
[   34.595622]  ? amdgpu_driver_unload_kms+0xd0/0xd0 [amdgpu]
[   34.595627]  ? drm_dev_register+0x164/0x1f0
[   34.595632]  ? lockdep_hardirqs_on+0x17a/0x250
[   34.595645]  ? __kasan_slab_free+0x13a/0x170
[   34.595655]  drm_dev_register+0x1a6/0x1f0
[   34.595795]  amdgpu_pci_probe+0x19e/0x220 [amdgpu]
[   34.595922]  ? amdgpu_pmops_runtime_idle+0x190/0x190 [amdgpu]
[   34.595931]  local_pci_probe+0x6b/0xc0
[   34.595938]  pci_device_probe+0x195/0x260
[   34.595943]  ? pci_device_remove+0x240/0x240
[   34.595954]  really_probe+0x3a5/0x480
[   34.595960]  ? device_attach+0x10/0x10
[   34.595964]  ? trace_hardirqs_off_caller+0x1b0/0x1b0
[   34.595968]  ? _raw_spin_unlock_irqrestore+0x3e/0x50
[   34.595977]  ? driver_probe_device+0xf0/0xf0
[   34.595984]  ? driver_probe_device+0xf0/0xf0
[   34.595988]  driver_probe_device+0x69/0xf0
[   34.595993]  __driver_attach+0x130/0x140
[   34.596001]  bus_for_each_dev+0xe4/0x140
[   34.596006]  ? subsys_dev_iter_exit+0x10/0x10
[   34.596012]  ? bus_add_driver+0x78/0x2c0
[   34.596015]  ? kmem_cache_alloc_trace+0x107/0x230
[   34.596022]  bus_add_driver+0x279/0x2c0
[   34.596030]  driver_register+0xca/0x140
[   34.596037]  __pci_register_driver+0x148/0x180
[   34.596042]  ? pci_bus_num_vf+0x10/0x10
[   34.596047]  ? 0xffffffffc0948000
[   34.596054]  ? 0xffffffffc0948000
[   34.596060]  do_one_initcall+0xd5/0x462
[   34.596065]  ? trace_event_raw_event_initcall_finish+0x130/0x130
[   34.596072]  ? find_held_lock+0xac/0xd0
[   34.596084]  ? trace_hardirqs_on_thunk+0x1a/0x1c
[   34.596094]  ? irq_exit+0x81/0x110
[   34.596099]  ? retint_kernel+0x10/0x10
[   34.596114]  ? __memset+0x24/0x30
[   34.596125]  ? kasan_unpoison_shadow+0x30/0x40
[   34.596139]  do_init_module+0x14e/0x3c0
[   34.596149]  ? __x64_sys_delete_module+0x3c0/0x3c0
[   34.596154]  ? __lock_is_held+0x38/0xc0
[   34.596173]  load_module+0x3bfe/0x3f00
[   34.596197]  ? module_frob_arch_sections+0x20/0x20
[   34.596201]  ? fsnotify+0x954/0x970
[   34.596212]  ? fsnotify+0x970/0x970
[   34.596215]  ? __fsnotify_parent+0x7f/0x210
[   34.596220]  ? fsnotify+0x970/0x970
[   34.596232]  ? vfs_read+0x181/0x1b0
[   34.596235]  ? vfs_read+0xce/0x1b0
[   34.596242]  ? kernel_read+0x6f/0x90
[   34.596251]  ? kernel_read_file+0x201/0x420
[   34.596257]  ? __ia32_sys_uselib+0x1e0/0x1e0
[   34.596263]  ? do_mmap+0x58a/0x8b0
[   34.596270]  ? up_write+0xc1/0x160
[   34.596274]  ? up_read+0x90/0x90
[   34.596288]  ? __do_sys_finit_module+0x18f/0x1c0
[   34.596292]  __do_sys_finit_module+0x18f/0x1c0
[   34.596297]  ? __ia32_sys_init_module+0x40/0x40
[   34.596302]  ? vfs_statx_fd+0x3f/0x80
[   34.596309]  ? __do_sys_newfstat+0xb5/0xc0
[   34.596312]  ? mark_held_locks+0x23/0xb0
[   34.596317]  ? do_syscall_64+0x8a/0x370
[   34.596332]  do_syscall_64+0xfc/0x370
[   34.596337]  ? syscall_return_slowpath+0x2a0/0x2a0
[   34.596340]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[   34.596345]  ? trace_hardirqs_on_caller+0x1b0/0x1b0
[   34.596349]  ? prepare_exit_to_usermode+0x1e0/0x1e0
[   34.596353]  ? lockdep_hardirqs_on+0x17a/0x250
[   34.596356]  ? _raw_spin_unlock_irq+0x24/0x30
[   34.596360]  ? lockdep_sys_exit+0x16/0x31
[   34.596367]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[   34.596377]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   34.596381] RIP: 0033:0x7f1790b4e879
[   34.596385] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d f7 45 2c 00 f7 d8 64 89 01 48
[   34.596388] RSP: 002b:00007fff0cb7bce8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   34.596393] RAX: ffffffffffffffda RBX: 0000561603ac8b80 RCX: 00007f1790b4e879
[   34.596396] RDX: 0000000000000000 RSI: 00005616022e43e6 RDI: 0000000000000007
[   34.596399] RBP: 00005616022e43e6 R08: 0000000000000000 R09: 0000000000000000
[   34.596401] R10: 0000000000000007 R11: 0000000000000246 R12: 0000000000000000
[   34.596404] R13: 0000561603ac8cb0 R14: 0000000000040000 R15: 0000000000000000
[   34.596418] irq event stamp: 408654
[   34.596424] hardirqs last  enabled at (408653): [<ffffffff89777e94>] console_unlock+0x644/0x860
[   34.596428] hardirqs last disabled at (408654): [<ffffffff896031a2>] trace_hardirqs_off_thunk+0x1a/0x1c
[   34.596432] softirqs last  enabled at (408622): [<ffffffff8ac00574>] __do_softirq+0x574/0x6f6
[   34.596436] softirqs last disabled at (408607): [<ffffffff896b7345>] irq_exit+0x105/0x110
[   34.596438] ---[ end trace f7cfb3830c82563d ]---
[   34.596528] [drm] DM_PPLIB: values for Invalid clock
[   34.596533] [drm] DM_PPLIB:	 300000 in kHz
[   34.596537] [drm] DM_PPLIB:	 600000 in kHz
[   34.596540] [drm] DM_PPLIB:	 626000 in kHz
[   34.596542] [drm] DM_PPLIB:	 654000 in kHz
[   34.598856] [drm] Display Core initialized with v3.1.65!
[   34.628186] [drm] SADs count is: -524, don't need to read it
[   34.634651] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   34.634656] [drm] Driver supports precise vblank timestamp query.
[   34.661068] [drm] VCN decode and encode initialized successfully.
[   34.669319] [drm] fb mappable at 0x81200000
[   34.669324] [drm] vram apper at 0x80000000
[   34.669327] [drm] size 8294400
[   34.669330] [drm] fb depth is 24
[   34.669333] [drm]    pitch is 7680
[   34.671573] fbcon: amdgpudrmfb (fb0) is primary device
[   34.747448] Console: switching to colour frame buffer device 240x67
[   34.763068] amdgpu 0000:07:00.0: fb0: amdgpudrmfb frame buffer device
[   34.774499] amdgpu 0000:07:00.0: ring 0(gfx) uses VM inv eng 4 on hub 0
[   34.774506] amdgpu 0000:07:00.0: ring 1(comp_1.0.0) uses VM inv eng 5 on hub 0
[   34.774512] amdgpu 0000:07:00.0: ring 2(comp_1.1.0) uses VM inv eng 6 on hub 0
[   34.774518] amdgpu 0000:07:00.0: ring 3(comp_1.2.0) uses VM inv eng 7 on hub 0
[   34.774523] amdgpu 0000:07:00.0: ring 4(comp_1.3.0) uses VM inv eng 8 on hub 0
[   34.774529] amdgpu 0000:07:00.0: ring 5(comp_1.0.1) uses VM inv eng 9 on hub 0
[   34.774534] amdgpu 0000:07:00.0: ring 6(comp_1.1.1) uses VM inv eng 10 on hub 0
[   34.774539] amdgpu 0000:07:00.0: ring 7(comp_1.2.1) uses VM inv eng 11 on hub 0
[   34.774545] amdgpu 0000:07:00.0: ring 8(comp_1.3.1) uses VM inv eng 12 on hub 0
[   34.774550] amdgpu 0000:07:00.0: ring 9(kiq_2.1.0) uses VM inv eng 13 on hub 0
[   34.774555] amdgpu 0000:07:00.0: ring 10(sdma0) uses VM inv eng 4 on hub 1
[   34.774561] amdgpu 0000:07:00.0: ring 11(vcn_dec) uses VM inv eng 5 on hub 1
[   34.774566] amdgpu 0000:07:00.0: ring 12(vcn_enc0) uses VM inv eng 6 on hub 1
[   34.774571] amdgpu 0000:07:00.0: ring 13(vcn_enc1) uses VM inv eng 7 on hub 1
[   34.774577] amdgpu 0000:07:00.0: ring 14(vcn_jpeg) uses VM inv eng 8 on hub 1
[   34.790852] [drm] Initialized amdgpu 3.27.0 20150101 for 0000:07:00.0 on minor 1
[   34.793317] modprobe (3855) used greatest stack depth: 14664 bytes left
[   37.775649] fuse init (API version 7.27)
[   42.439228] rfkill: input handler disabled
[   66.143009] ==================================================================
[   66.143254] BUG: KASAN: use-after-free in ttm_bo_bulk_move_lru_tail+0x2b/0x100 [ttm]
[   66.143263] Read of size 8 at addr ffff8801f193d550 by task gnome-shel:cs0/4194

[   66.143281] CPU: 3 PID: 4194 Comm: gnome-shel:cs0 Tainted: G        W         4.19.0-rc1+ #24
[   66.143285] Hardware name: System manufacturer System Product Name/TUF B350M-PLUS GAMING, BIOS 4011 04/19/2018
[   66.143289] Call Trace:
[   66.143298]  dump_stack+0xd1/0x16c
[   66.143306]  ? dump_stack_print_info.cold.1+0x2f/0x2f
[   66.143313]  ? kmsg_dump_rewind_nolock+0x54/0x54
[   66.143337]  ? ttm_bo_bulk_move_lru_tail+0x2b/0x100 [ttm]
[   66.143344]  print_address_description+0x60/0x229
[   66.143362]  ? ttm_bo_bulk_move_lru_tail+0x2b/0x100 [ttm]
[   66.143369]  kasan_report.cold.6+0x241/0x2ff
[   66.143390]  ttm_bo_bulk_move_lru_tail+0x2b/0x100 [ttm]
[   66.143550]  amdgpu_vm_move_to_lru_tail+0x127/0x140 [amdgpu]
[   66.143710]  amdgpu_cs_ioctl+0x3022/0x3b00 [amdgpu]
[   66.143878]  ? amdgpu_cs_find_mapping+0x270/0x270 [amdgpu]
[   66.143886]  ? finish_task_switch+0x20f/0x4e0
[   66.143892]  ? mark_lock+0x116/0xb50
[   66.143901]  ? print_usage_bug+0xf0/0xf0
[   66.143908]  ? __switch_to_asm+0x34/0x70
[   66.143913]  ? __switch_to_asm+0x34/0x70
[   66.143918]  ? __switch_to_asm+0x40/0x70
[   66.143923]  ? __switch_to_asm+0x34/0x70
[   66.143929]  ? __switch_to_asm+0x34/0x70
[   66.143934]  ? __switch_to_asm+0x40/0x70
[   66.143939]  ? mark_lock+0x116/0xb50
[   66.143945]  ? __switch_to_asm+0x34/0x70
[   66.143949]  ? __switch_to_asm+0x40/0x70
[   66.143954]  ? mark_lock+0x116/0xb50
[   66.143961]  ? print_usage_bug+0xf0/0xf0
[   66.143969]  ? print_usage_bug+0xf0/0xf0
[   66.143976]  ? __schedule+0x4f3/0x10a0
[   66.143981]  ? save_trace+0x1b0/0x1b0
[   66.143995]  ? __sched_text_start+0x8/0x8
[   66.144002]  ? default_send_IPI_single_phys+0x15/0x70
[   66.144010]  ? lockdep_hardirqs_off+0x67/0x100
[   66.144016]  ? resched_curr+0xf3/0x2b0
[   66.144021]  ? trace_hardirqs_off+0x93/0x1a0
[   66.144026]  ? match_held_lock+0x7f/0x330
[   66.144031]  ? match_held_lock+0x7f/0x330
[   66.144036]  ? match_held_lock+0x7f/0x330
[   66.144044]  ? get_futex_key_refs.isra.16+0x15/0x50
[   66.144050]  ? mark_lock+0x116/0xb50
[   66.144063]  ? __lock_acquire+0x66f/0x25c0
[   66.144070]  ? print_usage_bug+0xf0/0xf0
[   66.144089]  ? mark_held_locks+0xb0/0xb0
[   66.144105]  ? mark_held_locks+0xb0/0xb0
[   66.144113]  ? mark_held_locks+0xb0/0xb0
[   66.144118]  ? cpu_extra_stat_show+0x10/0x10
[   66.144126]  ? __might_sleep+0x2c/0xc0
[   66.144138]  ? __lock_acquire+0x66f/0x25c0
[   66.144149]  ? __lock_acquire+0x66f/0x25c0
[   66.144170]  ? mark_held_locks+0xb0/0xb0
[   66.144178]  ? futex_wake+0x390/0x390
[   66.144188]  ? futex_wake+0x365/0x390
[   66.144197]  ? drop_futex_key_refs.isra.17+0x15/0x60
[   66.144203]  ? futex_wait+0x4ba/0x550
[   66.144215]  ? match_held_lock+0x7f/0x330
[   66.144221]  ? futex_wait_setup+0x230/0x230
[   66.144227]  ? save_trace+0x1b0/0x1b0
[   66.144286]  drm_ioctl_kernel+0x14f/0x1a0
[   66.144440]  ? amdgpu_cs_find_mapping+0x270/0x270 [amdgpu]
[   66.144448]  ? drm_setversion+0x330/0x330
[   66.144612]  ? amdgpu_cs_find_mapping+0x270/0x270 [amdgpu]
[   66.144618]  drm_ioctl+0x30c/0x580
[   66.144631]  ? drm_getunique+0xe0/0xe0
[   66.144637]  ? mark_held_locks+0x23/0xb0
[   66.144644]  ? _raw_spin_unlock_irqrestore+0x3e/0x50
[   66.144654]  ? _raw_spin_unlock_irqrestore+0x3e/0x50
[   66.144659]  ? trace_hardirqs_on+0x72/0x1b0
[   66.144666]  ? trace_hardirqs_off_caller+0x1b0/0x1b0
[   66.144832]  amdgpu_drm_ioctl+0xca/0x180 [amdgpu]
[   66.144841]  ? 0xffffffffc0340000
[   66.144850]  ? __do_page_fault+0x3be/0x6d0
[   66.144864]  do_vfs_ioctl+0x12f/0xab0
[   66.144872]  ? lockdep_hardirqs_on+0x17a/0x250
[   66.144878]  ? trace_hardirqs_on_thunk+0x1a/0x1c
[   66.144885]  ? ioctl_preallocate+0x180/0x180
[   66.144896]  ? __fget_light+0x1f5/0x210
[   66.144904]  ? fget_raw+0x10/0x10
[   66.144917]  ? __x64_sys_futex+0x216/0x283
[   66.144924]  ? mark_held_locks+0x23/0xb0
[   66.144930]  ? do_syscall_64+0x8a/0x370
[   66.144938]  ? lockdep_hardirqs_on+0x17a/0x250
[   66.144944]  ? do_syscall_64+0x8a/0x370
[   66.144955]  ksys_ioctl+0x5b/0x90
[   66.144965]  __x64_sys_ioctl+0x38/0x40
[   66.144972]  do_syscall_64+0xfc/0x370
[   66.144979]  ? syscall_return_slowpath+0x2a0/0x2a0
[   66.144984]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[   66.144992]  ? trace_hardirqs_on_caller+0x1b0/0x1b0
[   66.144998]  ? prepare_exit_to_usermode+0x1e0/0x1e0
[   66.145004]  ? lockdep_hardirqs_on+0x17a/0x250
[   66.145010]  ? _raw_spin_unlock_irq+0x24/0x30
[   66.145015]  ? lockdep_sys_exit+0x16/0x31
[   66.145026]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[   66.145039]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   66.145044] RIP: 0033:0x7f4866d4dc57
[   66.145050] Code: 00 00 90 48 8b 05 49 82 2c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 19 82 2c 00 f7 d8 64 89 01 48
[   66.145054] RSP: 002b:00007f483e0b87b8 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
[   66.145063] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f4866d4dc57
[   66.145068] RDX: 00007f483e0b8890 RSI: 00000000c0186444 RDI: 000000000000000c
[   66.145072] RBP: 00007f483e0b87f0 R08: 00007f483e0b8980 R09: 00007f483e0b89f8
[   66.145077] R10: 0000000000000000 R11: 0000000000000206 R12: 00007ffc68bc35ce
[   66.145081] R13: 00007ffc68bc35cf R14: 00007ffc68bc35d0 R15: 0000000000000000

[   66.145108] Allocated by task 4164:
[   66.145117]  kasan_kmalloc+0xbf/0xe0
[   66.145122]  kmem_cache_alloc_trace+0x107/0x230
[   66.145275]  amdgpu_bo_do_create+0x237/0xb50 [amdgpu]
[   66.145426]  amdgpu_bo_create+0x9f/0x4f0 [amdgpu]
[   66.145579]  amdgpu_gem_object_create+0x178/0x240 [amdgpu]
[   66.145734]  amdgpu_gem_create_ioctl+0x25a/0x500 [amdgpu]
[   66.145740]  drm_ioctl_kernel+0x14f/0x1a0
[   66.145745]  drm_ioctl+0x30c/0x580
[   66.145896]  amdgpu_drm_ioctl+0xca/0x180 [amdgpu]
[   66.145901]  do_vfs_ioctl+0x12f/0xab0
[   66.145906]  ksys_ioctl+0x5b/0x90
[   66.145911]  __x64_sys_ioctl+0x38/0x40
[   66.145916]  do_syscall_64+0xfc/0x370
[   66.145921]  entry_SYSCALL_64_after_hwframe+0x49/0xbe

[   66.145932] Freed by task 4164:
[   66.145941]  __kasan_slab_free+0x125/0x170
[   66.145945]  kfree+0xcd/0x260
[   66.146099]  amdgpu_bo_destroy+0x2ba/0x320 [amdgpu]
[   66.146115]  ttm_bo_release_list+0x3fc/0x4a0 [ttm]
[   66.146130]  ttm_bo_release+0x24c/0x5b0 [ttm]
[   66.146284]  amdgpu_bo_unref+0x1a/0x30 [amdgpu]
[   66.146438]  amdgpu_gem_object_free+0x7e/0xb0 [amdgpu]
[   66.146444]  drm_gem_object_free+0x9f/0x170
[   66.146449]  drm_gem_object_release_handle+0x86/0xd0
[   66.146454]  drm_gem_handle_delete+0x5c/0x90
[   66.146459]  drm_ioctl_kernel+0x14f/0x1a0
[   66.146464]  drm_ioctl+0x30c/0x580
[   66.146615]  amdgpu_drm_ioctl+0xca/0x180 [amdgpu]
[   66.146621]  do_vfs_ioctl+0x12f/0xab0
[   66.146626]  ksys_ioctl+0x5b/0x90
[   66.146631]  __x64_sys_ioctl+0x38/0x40
[   66.146636]  do_syscall_64+0xfc/0x370
[   66.146641]  entry_SYSCALL_64_after_hwframe+0x49/0xbe

[   66.146653] The buggy address belongs to the object at ffff8801f193d500
                which belongs to the cache kmalloc-2048 of size 2048
[   66.146663] The buggy address is located 80 bytes inside of
                2048-byte region [ffff8801f193d500, ffff8801f193dd00)
[   66.146672] The buggy address belongs to the page:
[   66.146680] page:ffffea0007c64e00 count:1 mapcount:0 mapping:ffff8801ff80ed00 index:0x0 compound_mapcount: 0
[   66.146696] flags: 0x200000000008100(slab|head)
[   66.146707] raw: 0200000000008100 0000000000000000 0000000600000001 ffff8801ff80ed00
[   66.146717] raw: 0000000000000000 00000000000f000f 00000001ffffffff 0000000000000000
[   66.146724] page dumped because: kasan: bad access detected

[   66.146737] Memory state around the buggy address:
[   66.146746]  ffff8801f193d400: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   66.146754]  ffff8801f193d480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   66.146762] >ffff8801f193d500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   66.146770]                                                  ^
[   66.146778]  ffff8801f193d580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   66.146786]  ffff8801f193d600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   66.146793] ==================================================================
[   66.146800] Disabling lock debugging due to kernel taint
[  106.193732] ------------[ cut here ]------------
[  106.193738] kernel BUG at drivers/gpu/drm/ttm/ttm_bo.c:187!
[  106.193753] invalid opcode: 0000 [#1] SMP KASAN NOPTI
[  106.193763] CPU: 2 PID: 7561 Comm: shader_runner Tainted: G    B   W         4.19.0-rc1+ #24
[  106.193770] Hardware name: System manufacturer System Product Name/TUF B350M-PLUS GAMING, BIOS 4011 04/19/2018
[  106.193794] RIP: 0010:ttm_bo_ref_bug+0x0/0x10 [ttm]
[  106.193801] Code: ff 48 83 c4 08 31 c0 5b 5d 41 5c 41 5d 41 5e 41 5f c3 48 83 c4 08 b8 01 00 00 00 5b 5d 41 5c 41 5d 41 5e 41 5f c3 31 c0 c3 90 <0f> 0b 0f 1f 40 00 66 2e 0f 1f 84 00 00 00 00 00 41 55 41 54 55 53
[  106.193807] RSP: 0018:ffff88007c31f200 EFLAGS: 00010246
[  106.193816] RAX: 0000000000000000 RBX: 1ffff1000f863e43 RCX: ffffffffc02ccbf0
[  106.193823] RDX: dffffc0000000000 RSI: dffffc0000000000 RDI: ffff8801f61499fc
[  106.193830] RBP: ffff8801f61499d0 R08: ffffed003db0c86b R09: ffffed003db0c86a
[  106.193835] R10: ffffed003db0c86a R11: ffff8801ed864353 R12: ffff8801f61499fc
[  106.193841] R13: ffff8801f0b6e6f8 R14: ffffed000f863e6f R15: ffff8801f8542b78
[  106.193848] FS:  00007f571646b6c0(0000) GS:ffff8801ffc80000(0000) knlGS:0000000000000000
[  106.193854] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  106.193859] CR2: 00005567b8ba1000 CR3: 00000001f66f0000 CR4: 00000000003406e0
[  106.193864] Call Trace:
[  106.193886]  ttm_bo_del_from_lru+0x33b/0x340 [ttm]
[  106.193908]  ? ttm_bo_release_list+0x4a0/0x4a0 [ttm]
[  106.193920]  ? kernel_text_address+0xe6/0xf0
[  106.193928]  ? __kernel_text_address+0x9/0x30
[  106.193936]  ? unwind_get_return_address+0x2a/0x40
[  106.193955]  ? ttm_eu_reserve_buffers+0x468/0xb30 [ttm]
[  106.193963]  ? lock_release+0x480/0x480
[  106.193968]  ? lock_release+0x480/0x480
[  106.193975]  ? save_stack+0x8c/0xb0
[  106.193983]  ? rcu_note_context_switch+0x450/0x450
[  106.193988]  ? cpu_extra_stat_show+0x10/0x10
[  106.193995]  ? drm_gem_handle_create_tail+0x18b/0x240
[  106.194016]  ttm_eu_reserve_buffers+0x48b/0xb30 [ttm]
[  106.194036]  ? ttm_eu_fence_buffer_objects+0x220/0x220 [ttm]
[  106.194044]  ? __radix_tree_lookup+0x1dd/0x2b0
[  106.194052]  ? debug_lockdep_rcu_enabled+0x22/0x40
[  106.194057]  ? drm_gem_object_lookup+0x3c/0x50
[  106.194064]  ? lock_downgrade+0x300/0x300
[  106.194071]  ? do_raw_spin_unlock+0x152/0x1e0
[  106.194078]  ? do_raw_spin_trylock+0x120/0x120
[  106.194084]  ? __mutex_unlock_slowpath+0x114/0x530
[  106.194090]  ? __lock_acquire+0x176/0x25c0
[  106.194265]  ? amdgpu_vm_get_pd_bo+0x10b/0x140 [amdgpu]
[  106.194440]  ? amdgpu_vm_alloc_levels+0x430/0x430 [amdgpu]
[  106.194613]  amdgpu_gem_va_ioctl+0x613/0x970 [amdgpu]
[  106.194620]  ? mark_held_locks+0xb0/0xb0
[  106.194797]  ? amdgpu_gem_metadata_ioctl+0x350/0x350 [amdgpu]
[  106.194973]  ? amdgpu_gem_force_release+0x1e0/0x1e0 [amdgpu]
[  106.194982]  ? drm_vma_node_allow+0x10b/0x140
[  106.194990]  ? drm_gem_handle_create_tail+0x19c/0x240
[  106.194997]  ? drm_gem_destroy+0x50/0x50
[  106.195007]  ? debug_lockdep_rcu_enabled+0x22/0x40
[  106.195015]  ? lock_downgrade+0x300/0x300
[  106.195022]  ? lock_release+0x480/0x480
[  106.195029]  ? lock_acquire+0x12a/0x2d0
[  106.195041]  drm_ioctl_kernel+0x14f/0x1a0
[  106.195209]  ? amdgpu_gem_metadata_ioctl+0x350/0x350 [amdgpu]
[  106.195216]  ? drm_setversion+0x330/0x330
[  106.195415]  ? amdgpu_gem_metadata_ioctl+0x350/0x350 [amdgpu]
[  106.195423]  drm_ioctl+0x30c/0x580
[  106.195436]  ? drm_getunique+0xe0/0xe0
[  106.195447]  ? do_raw_spin_unlock+0x152/0x1e0
[  106.195460]  ? trace_hardirqs_off_caller+0x1b0/0x1b0
[  106.195671]  amdgpu_drm_ioctl+0xca/0x180 [amdgpu]
[  106.195680]  ? 0xffffffffc0340000
[  106.195689]  ? debug_lockdep_rcu_enabled+0x22/0x40
[  106.195697]  ? __do_page_fault+0x3be/0x6d0
[  106.195708]  do_vfs_ioctl+0x12f/0xab0
[  106.195715]  ? __do_page_fault+0x201/0x6d0
[  106.195723]  ? downgrade_write+0x1c0/0x1c0
[  106.195731]  ? ioctl_preallocate+0x180/0x180
[  106.195742]  ? __fget_light+0x1f5/0x210
[  106.195750]  ? fget_raw+0x10/0x10
[  106.195761]  ? __x64_sys_futex+0x216/0x283
[  106.195770]  ? __ia32_sys_futex+0x280/0x280
[  106.195778]  ? lockdep_hardirqs_on+0x11/0x250
[  106.195786]  ? do_syscall_64+0x8a/0x370
[  106.195795]  ksys_ioctl+0x5b/0x90
[  106.195805]  __x64_sys_ioctl+0x38/0x40
[  106.195813]  do_syscall_64+0xfc/0x370
[  106.195820]  ? syscall_return_slowpath+0x2a0/0x2a0
[  106.195827]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[  106.195835]  ? trace_hardirqs_on_caller+0x1b0/0x1b0
[  106.195844]  ? lockdep_sys_exit+0x16/0x31
[  106.195853]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[  106.195865]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  106.195871] RIP: 0033:0x7f5713b46c57
[  106.195880] Code: 00 00 90 48 8b 05 49 82 2c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 19 82 2c 00 f7 d8 64 89 01 48
[  106.195886] RSP: 002b:00007ffc2ea3efd8 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
[  106.195895] RAX: ffffffffffffffda RBX: 000000040000000a RCX: 00007f5713b46c57
[  106.195901] RDX: 00007ffc2ea3f090 RSI: 00000000c0286448 RDI: 0000000000000006
[  106.195907] RBP: 00007ffc2ea3f010 R08: 0000000100100000 R09: 000000000000000e
[  106.195912] R10: 00005567b86a8010 R11: 0000000000000202 R12: 0000000000000000
[  106.195918] R13: 00000000000000fa R14: 00000000000000fa R15: 00007ffc2ea3f9f0
[  106.195929] Modules linked in: fuse amdgpu mfd_core chash gpu_sched ttm ax88179_178a usbnet
[  106.196012] ---[ end trace f7cfb3830c82563e ]---
[  106.196034] RIP: 0010:ttm_bo_ref_bug+0x0/0x10 [ttm]
[  106.196044] Code: ff 48 83 c4 08 31 c0 5b 5d 41 5c 41 5d 41 5e 41 5f c3 48 83 c4 08 b8 01 00 00 00 5b 5d 41 5c 41 5d 41 5e 41 5f c3 31 c0 c3 90 <0f> 0b 0f 1f 40 00 66 2e 0f 1f 84 00 00 00 00 00 41 55 41 54 55 53
[  106.196051] RSP: 0018:ffff88007c31f200 EFLAGS: 00010246
[  106.196060] RAX: 0000000000000000 RBX: 1ffff1000f863e43 RCX: ffffffffc02ccbf0
[  106.196066] RDX: dffffc0000000000 RSI: dffffc0000000000 RDI: ffff8801f61499fc
[  106.196074] RBP: ffff8801f61499d0 R08: ffffed003db0c86b R09: ffffed003db0c86a
[  106.196080] R10: ffffed003db0c86a R11: ffff8801ed864353 R12: ffff8801f61499fc
[  106.196087] R13: ffff8801f0b6e6f8 R14: ffffed000f863e6f R15: ffff8801f8542b78
[  106.196095] FS:  00007f571646b6c0(0000) GS:ffff8801ffc80000(0000) knlGS:0000000000000000
[  106.196101] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  106.196106] CR2: 00005567b8ba1000 CR3: 00000001f66f0000 CR4: 00000000003406e0
[  106.196115] BUG: sleeping function called from invalid context at include/linux/percpu-rwsem.h:34
[  106.196122] in_atomic(): 1, irqs_disabled(): 0, pid: 7561, name: shader_runner
[  106.196128] INFO: lockdep is turned off.
[  106.196137] CPU: 2 PID: 7561 Comm: shader_runner Tainted: G    B D W         4.19.0-rc1+ #24
[  106.196144] Hardware name: System manufacturer System Product Name/TUF B350M-PLUS GAMING, BIOS 4011 04/19/2018
[  106.196150] Call Trace:
[  106.196159]  dump_stack+0xd1/0x16c
[  106.196168]  ? dump_stack_print_info.cold.1+0x2f/0x2f
[  106.196177]  ? lock_downgrade+0x300/0x300
[  106.196190]  ___might_sleep.cold.82+0xbd/0xce
[  106.196199]  ? cpu_extra_stat_show+0x10/0x10
[  106.196209]  ? __might_sleep+0x2c/0xc0
[  106.196219]  exit_signals+0x81/0x420
[  106.196227]  ? get_signal+0xd20/0xd20
[  106.196236]  ? blocking_notifier_call_chain+0x91/0x110
[  106.196245]  ? srcu_init_notifier_head+0x50/0x50
[  106.196254]  ? drm_setversion+0x330/0x330
[  106.196267]  do_exit+0x267/0x1260
[  106.196274]  ? drm_ioctl+0x30c/0x580
[  106.196285]  ? release_task.part.23+0xdb0/0xdb0
[  106.196293]  ? drm_getunique+0xe0/0xe0
[  106.196303]  ? do_raw_spin_unlock+0x152/0x1e0
[  106.196315]  ? trace_hardirqs_off_caller+0x1b0/0x1b0
[  106.196527]  ? amdgpu_drm_ioctl+0xca/0x180 [amdgpu]
[  106.196536]  ? 0xffffffffc0340000
[  106.196546]  ? debug_lockdep_rcu_enabled+0x22/0x40
[  106.196554]  ? __do_page_fault+0x3be/0x6d0
[  106.196567]  ? do_vfs_ioctl+0x12f/0xab0
[  106.196574]  ? __do_page_fault+0x201/0x6d0
[  106.196583]  ? downgrade_write+0x1c0/0x1c0
[  106.196592]  ? ioctl_preallocate+0x180/0x180
[  106.196603]  ? __fget_light+0x1f5/0x210
[  106.196612]  ? fget_raw+0x10/0x10
[  106.196625]  ? __x64_sys_futex+0x216/0x283
[  106.196635]  ? __ia32_sys_futex+0x280/0x280
[  106.196643]  ? lockdep_hardirqs_on+0x11/0x250
[  106.196651]  ? do_syscall_64+0x8a/0x370
[  106.196662]  ? ksys_ioctl+0x5b/0x90
[  106.196672]  ? __x64_sys_ioctl+0x38/0x40
[  106.196680]  ? do_syscall_64+0xfc/0x370
[  106.196689]  ? syscall_return_slowpath+0x2a0/0x2a0
[  106.196696]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[  106.196705]  ? trace_hardirqs_on_caller+0x1b0/0x1b0
[  106.196715]  ? lockdep_sys_exit+0x16/0x31
[  106.196725]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[  106.196737]  rewind_stack_do_exit+0x17/0x20
[  106.196768] note: shader_runner[7561] exited with preempt_count 1
[  132.171140] rcu: INFO: rcu_sched self-detected stall on CPU
[  132.171155] rcu: 	3-....: (25998 ticks this GP) idle=dae/1/0x4000000000000002 softirq=13574/13574 fqs=6350 
[  132.171159] rcu: 	 (t=26000 jiffies g=45577 q=1951)
[  132.171167] NMI backtrace for cpu 3
[  132.171175] CPU: 3 PID: 4004 Comm: Xorg:cs0 Tainted: G    B D W         4.19.0-rc1+ #24
[  132.171180] Hardware name: System manufacturer System Product Name/TUF B350M-PLUS GAMING, BIOS 4011 04/19/2018
[  132.171184] Call Trace:
[  132.171189]  <IRQ>
[  132.171198]  dump_stack+0xd1/0x16c
[  132.171205]  ? dump_stack_print_info.cold.1+0x2f/0x2f
[  132.171212]  ? lockdep_hardirqs_off+0x1a/0x100
[  132.171218]  ? _raw_spin_lock_irqsave+0xd/0x40
[  132.171224]  ? trace_hardirqs_off+0x93/0x1a0
[  132.171232]  nmi_cpu_backtrace.cold.3+0x13/0x58
[  132.171241]  ? lapic_can_unplug_cpu.cold.26+0x36/0x36
[  132.171247]  nmi_trigger_cpumask_backtrace+0xa2/0xaf
[  132.171254]  rcu_dump_cpu_stacks+0xe2/0x12b
[  132.171262]  print_cpu_stall.cold.88+0x1ee/0x2e4
[  132.171270]  ? rcu_dynticks_snap+0x20/0x20
[  132.171276]  ? select_task_rq_fair+0x2200/0x2200
[  132.171281]  ? lock_release+0x480/0x480
[  132.171288]  ? rcu_jiffies_till_stall_check+0x92/0x170
[  132.171294]  ? rcu_test_sync_prims+0x20/0x20
[  132.171300]  ? rcu_bh_qs+0x72/0x280
[  132.171307]  ? rcu_all_qs+0x140/0x140
[  132.171314]  ? mark_held_locks+0xb0/0xb0
[  132.171319]  ? do_raw_spin_lock+0x8f/0xe0
[  132.171327]  ? xhci_giveback_urb_in_irq.isra.44+0x159/0x300
[  132.171333]  ? run_posix_cpu_timers+0x3fc/0x10d0
[  132.171339]  ? rb_insert_color+0x13a/0x7c0
[  132.171346]  rcu_check_callbacks+0xa70/0xaf0
[  132.171355]  ? rcu_cpu_stall_reset+0x130/0x130
[  132.171362]  ? trigger_load_balance+0x23d/0x9a0
[  132.171371]  ? mark_held_locks+0xb0/0xb0
[  132.171376]  ? xhci_irq+0x384/0x2cd0
[  132.171382]  ? __lock_acquire+0x176/0x25c0
[  132.171387]  ? lock_downgrade+0x300/0x300
[  132.171392]  ? inc_deq+0x28e/0x320
[  132.171401]  ? debug_lockdep_rcu_enabled+0x22/0x40
[  132.171406]  ? cpuacct_account_field+0x183/0x2b0
[  132.171413]  ? lock_downgrade+0x300/0x300
[  132.171420]  ? lock_release+0x480/0x480
[  132.171425]  ? cpu_load_update+0x77/0x270
[  132.171431]  ? lockdep_hardirqs_off+0x1a/0x100
[  132.171436]  ? trace_hardirqs_off+0x93/0x1a0
[  132.171442]  ? trace_hardirqs_on+0x1b0/0x1b0
[  132.171449]  ? taskstats_exit+0x720/0x720
[  132.171457]  ? raise_softirq+0x133/0x270
[  132.171463]  ? raise_softirq_irqoff+0x240/0x240
[  132.171469]  ? cgroup_rstat_updated+0x82/0x200
[  132.171476]  ? ktime_get+0xc6/0x230
[  132.171481]  ? trace_hardirqs_off+0x93/0x1a0
[  132.171488]  ? hrtimer_run_queues+0x2c/0x1b0
[  132.171495]  ? run_local_timers+0xee/0x130
[  132.171500]  ? timer_clear_idle+0x20/0x20
[  132.171506]  ? ktime_get_raw_ts64+0x250/0x250
[  132.171513]  ? lockdep_hardirqs_off+0x1a/0x100
[  132.171518]  ? _raw_spin_unlock_irqrestore+0x2f/0x50
[  132.171523]  ? trace_hardirqs_off+0x93/0x1a0
[  132.171531]  update_process_times+0x23/0x60
[  132.171537]  tick_sched_handle+0x71/0x80
[  132.171544]  tick_sched_timer+0x32/0x90
[  132.171550]  __hrtimer_run_queues+0x281/0x840
[  132.171557]  ? tick_sched_do_timer+0x80/0x80
[  132.171565]  ? hrtimer_init+0x230/0x230
[  132.171572]  ? lock_release+0x480/0x480
[  132.171578]  ? debug_lockdep_rcu_enabled+0x22/0x40
[  132.171583]  ? rcu_nmi_exit+0x1c0/0x580
[  132.171588]  ? lockdep_hardirqs_off+0x1a/0x100
[  132.171594]  ? ktime_get_update_offsets_now+0xb5/0x2d0
[  132.171599]  ? trace_hardirqs_off+0x93/0x1a0
[  132.171605]  ? trace_hardirqs_on+0x1b0/0x1b0
[  132.171614]  ? ktime_get_update_offsets_now+0x169/0x2d0
[  132.171621]  ? do_timer+0x20/0x20
[  132.171626]  ? trace_hardirqs_off+0x93/0x1a0
[  132.171635]  ? do_raw_spin_lock+0x8f/0xe0
[  132.171642]  hrtimer_interrupt+0x1a0/0x340
[  132.171653]  smp_apic_timer_interrupt+0x11b/0x450
[  132.171660]  ? smp_call_function_single_interrupt+0x3d0/0x3d0
[  132.171666]  ? lockdep_hardirqs_off+0x1a/0x100
[  132.171673]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[  132.171678]  ? trace_hardirqs_off_caller+0x95/0x1b0
[  132.171683]  ? trace_hardirqs_on_caller+0x1b0/0x1b0
[  132.171688]  ? trace_hardirqs_on_caller+0x1b0/0x1b0
[  132.171693]  ? trace_hardirqs_off+0x93/0x1a0
[  132.171699]  ? idle_cpu+0x91/0x110
[  132.171705]  ? task_prio+0x20/0x20
[  132.171712]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[  132.171721]  apic_timer_interrupt+0xf/0x20
[  132.171725]  </IRQ>
[  132.171731] RIP: 0010:queued_spin_lock_slowpath+0x64b/0x730
[  132.171737] Code: d7 e9 b3 fc ff ff 85 c9 74 4a 4c 8d b4 24 70 01 00 00 48 b8 00 00 00 00 00 fc ff df 4d 89 f5 49 c1 ed 03 49 01 c5 eb 02 f3 90 <41> c6 45 00 04 48 89 df e8 48 4f 24 00 44 8b 23 4c 89 f7 e8 bd 4f
[  132.171742] RSP: 0018:ffff8801e79eea20 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
[  132.171750] RAX: 0000000000000000 RBX: ffff8801ed864350 RCX: ffffffff8975ec23
[  132.171754] RDX: 0000000000000003 RSI: dffffc0000000000 RDI: ffff8801e79eeb90
[  132.171759] RBP: 1ffff1003cf3dd46 R08: ffffed003db0c86b R09: ffffed003db0c86a
[  132.171764] R10: ffffed003db0c86a R11: ffff8801ed864353 R12: 0000000000040101
[  132.171768] R13: ffffed003cf3dd72 R14: ffff8801e79eeb90 R15: 0000000000000000
[  132.171777]  ? queued_spin_lock_slowpath+0x663/0x730
[  132.171785]  ? __is_insn_slot_addr+0x179/0x240
[  132.171792]  ? osq_unlock+0x240/0x240
[  132.171797]  ? lock_downgrade+0x300/0x300
[  132.171804]  ? lock_release+0x480/0x480
[  132.171809]  ? __module_address+0x25b/0x340
[  132.171818]  ? debug_lockdep_rcu_enabled+0x22/0x40
[  132.171823]  ? __is_insn_slot_addr+0x179/0x240
[  132.171830]  ? lock_downgrade+0x300/0x300
[  132.171836]  ? lock_release+0x480/0x480
[  132.171841]  ? __module_address+0x25b/0x340
[  132.171851]  ? deref_stack_reg+0x9d/0xe0
[  132.171858]  ? __is_insn_slot_addr+0x198/0x240
[  132.171864]  ? __free_insn_slot+0x380/0x380
[  132.171871]  ? rcu_is_watching+0x98/0xe0
[  132.171877]  ? _rcu_barrier_trace+0x2b0/0x2b0
[  132.172025]  ? amdgpu_bo_list_get_list+0x294/0x360 [amdgpu]
[  132.172033]  ? lock_acquire+0x12a/0x2d0
[  132.172049]  ? ttm_eu_reserve_buffers+0x468/0xb30 [ttm]
[  132.172056]  ? lock_release+0x480/0x480
[  132.172062]  ? lock_release+0x480/0x480
[  132.172068]  ? debug_lockdep_rcu_enabled+0x22/0x40
[  132.172074]  ? rcu_note_context_switch+0x450/0x450
[  132.172080]  ? cpu_extra_stat_show+0x10/0x10
[  132.172086]  ? debug_lockdep_rcu_enabled+0x22/0x40
[  132.172093]  do_raw_spin_lock+0xd2/0xe0
[  132.172109]  ttm_eu_reserve_buffers+0x468/0xb30 [ttm]
[  132.172128]  ? ttm_eu_fence_buffer_objects+0x220/0x220 [ttm]
[  132.172291]  ? amdgpu_vm_get_pd_bo+0x10b/0x140 [amdgpu]
[  132.172438]  ? amdgpu_vm_alloc_levels+0x430/0x430 [amdgpu]
[  132.172585]  amdgpu_cs_ioctl+0xc9d/0x3b00 [amdgpu]
[  132.172595]  ? _raw_spin_unlock_irq+0x2c/0x30
[  132.172739]  ? amdgpu_cs_find_mapping+0x270/0x270 [amdgpu]
[  132.172745]  ? _raw_spin_unlock_irq+0x24/0x30
[  132.172750]  ? finish_task_switch+0x16b/0x4e0
[  132.172755]  ? finish_task_switch+0x101/0x4e0
[  132.172761]  ? __switch_to_asm+0x34/0x70
[  132.172766]  ? __switch_to_asm+0x34/0x70
[  132.172772]  ? set_load_weight+0x100/0x100
[  132.172777]  ? __switch_to_asm+0x34/0x70
[  132.172782]  ? __switch_to_asm+0x34/0x70
[  132.172787]  ? __switch_to_asm+0x40/0x70
[  132.172792]  ? __switch_to_asm+0x34/0x70
[  132.172797]  ? __switch_to_asm+0x34/0x70
[  132.172802]  ? __switch_to_asm+0x40/0x70
[  132.172807]  ? __switch_to_asm+0x34/0x70
[  132.172812]  ? __switch_to_asm+0x34/0x70
[  132.172817]  ? __switch_to_asm+0x40/0x70
[  132.172822]  ? __switch_to_asm+0x34/0x70
[  132.172827]  ? __switch_to_asm+0x40/0x70
[  132.172832]  ? __switch_to_asm+0x34/0x70
[  132.172837]  ? __switch_to_asm+0x40/0x70
[  132.172845]  ? __schedule+0x4f3/0x10a0
[  132.172853]  ? __sched_text_start+0x8/0x8
[  132.172859]  ? cgroup_rstat_updated+0x82/0x200
[  132.172867]  ? get_futex_key_refs.isra.16+0x15/0x50
[  132.172873]  ? get_futex_key+0x7b9/0xde0
[  132.172881]  ? __lock_acquire+0x176/0x25c0
[  132.172889]  ? node_random+0x40/0x40
[  132.172895]  ? __update_load_avg_blocked_se+0x410/0x410
[  132.172901]  ? __lock_acquire+0x176/0x25c0
[  132.172908]  ? mark_held_locks+0xb0/0xb0
[  132.172914]  ? __schedule+0x10a0/0x10a0
[  132.172922]  ? mark_held_locks+0xb0/0xb0
[  132.172928]  ? mark_held_locks+0xb0/0xb0
[  132.172933]  ? cpu_extra_stat_show+0x10/0x10
[  132.172939]  ? __might_sleep+0x2c/0xc0
[  132.172947]  ? futex_wait_queue_me+0x342/0x420
[  132.172952]  ? __lock_acquire+0x176/0x25c0
[  132.172959]  ? refill_pi_state_cache.part.12+0x1d0/0x1d0
[  132.172965]  ? __lock_acquire+0x176/0x25c0
[  132.172973]  ? lock_release+0x480/0x480
[  132.172981]  ? mark_held_locks+0xb0/0xb0
[  132.172987]  ? futex_wake+0x390/0x390
[  132.172993]  ? __unqueue_futex+0x132/0x190
[  132.172999]  ? debug_lockdep_rcu_enabled+0x22/0x40
[  132.173005]  ? futex_wake+0x365/0x390
[  132.173012]  ? drop_futex_key_refs.isra.17+0x15/0x60
[  132.173018]  ? futex_wait+0x4ba/0x550
[  132.173026]  ? futex_wait_setup+0x230/0x230
[  132.173032]  ? mark_wake_futex+0xf3/0x110
[  132.173052]  ? lock_release+0x480/0x480
[  132.173062]  drm_ioctl_kernel+0x14f/0x1a0
[  132.173208]  ? amdgpu_cs_find_mapping+0x270/0x270 [amdgpu]
[  132.173215]  ? drm_setversion+0x330/0x330
[  132.173362]  ? amdgpu_cs_find_mapping+0x270/0x270 [amdgpu]
[  132.173368]  drm_ioctl+0x30c/0x580
[  132.173376]  ? drm_getunique+0xe0/0xe0
[  132.173383]  ? do_raw_spin_unlock+0x152/0x1e0
[  132.173390]  ? _raw_spin_unlock_irqrestore+0x3e/0x50
[  132.173395]  ? trace_hardirqs_on+0x72/0x1b0
[  132.173401]  ? trace_hardirqs_off_caller+0x1b0/0x1b0
[  132.173547]  amdgpu_drm_ioctl+0xca/0x180 [amdgpu]
[  132.173554]  ? 0xffffffffc0340000
[  132.173561]  ? vm_munmap+0xc9/0x110
[  132.173570]  do_vfs_ioctl+0x12f/0xab0
[  132.173578]  ? ioctl_preallocate+0x180/0x180
[  132.173586]  ? __fget_light+0x1f5/0x210
[  132.173592]  ? fget_raw+0x10/0x10
[  132.173600]  ? __x64_sys_futex+0x216/0x283
[  132.173608]  ? __ia32_sys_futex+0x280/0x280
[  132.173614]  ? lockdep_hardirqs_on+0x11/0x250
[  132.173619]  ? do_syscall_64+0x8a/0x370
[  132.173627]  ksys_ioctl+0x5b/0x90
[  132.173634]  __x64_sys_ioctl+0x38/0x40
[  132.173640]  do_syscall_64+0xfc/0x370
[  132.173646]  ? syscall_return_slowpath+0x2a0/0x2a0
[  132.173651]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[  132.173657]  ? trace_hardirqs_on_caller+0x1b0/0x1b0
[  132.173664]  ? lockdep_sys_exit+0x16/0x31
[  132.173671]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[  132.173679]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  132.173684] RIP: 0033:0x7fce5c84ec57
[  132.173690] Code: 00 00 90 48 8b 05 49 82 2c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 19 82 2c 00 f7 d8 64 89 01 48
[  132.173695] RSP: 002b:00007fce523917e8 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
[  132.173702] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fce5c84ec57
[  132.173706] RDX: 00007fce523918c0 RSI: 00000000c0186444 RDI: 000000000000000d
[  132.173711] RBP: 00007fce52391820 R08: 00007fce52391980 R09: 00007fce523919f8
[  132.173715] R10: 0000000000000000 R11: 0000000000000206 R12: 00007ffd671e039e
[  132.173720] R13: 00007ffd671e039f R14: 00007ffd671e03a0 R15: 0000000000000000

--------------431FD4F7776F526BDAD4A76A
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------431FD4F7776F526BDAD4A76A--
