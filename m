Return-Path: <SRS0=Ao2y=GR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F26C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jan 2021 09:30:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4526E2395A
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jan 2021 09:30:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4526E2395A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECF896E118;
	Thu, 14 Jan 2021 09:30:33 +0000 (UTC)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9901289B0C
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jan 2021 08:57:58 +0000 (UTC)
Received: by mail-qk1-x733.google.com with SMTP id f26so6500214qka.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jan 2021 00:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=IZwepwjhAxk0pfHCpb+0X0BLb8EFe9aQ0uGi1DlGwo4=;
 b=B2ZeMl9j4na+DjOxW2m6YpOSNRzIog7re3Oo8FHBAQuUUPYQu9urpF0LD+QbumsG9S
 juhHS/fdP/IhQ/OregMJsqwJpLrCzdY8C77l7S8TMtv9WsK314M3iWzIdnu+nmWlDKp9
 4ZXulTQ/YDivz4iOcNk5MvTDm59L8vPNMSGyQscvm5l0wZmSOIhnvulhBxRWyBfNQu4P
 Z+7XaciW+GhxR3LBP06g3Y6KNUoDFrxijGnJIj2c1EA3zPeyGzzTMYTMFglF9ykjbpz6
 NwmHI0ss2gcXn4v1C3QHyi9Hz8EbHzfmm8GxsQConx7mEFYvJHxq96PKCkafTk9IP+tH
 w6SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=IZwepwjhAxk0pfHCpb+0X0BLb8EFe9aQ0uGi1DlGwo4=;
 b=WExp6JDNiV8wPoafd5xXEy4CMJZQUhVtixdF/xdavJLk7o0UjyBZ4bsIUGsvKZsVim
 156E95WWBd2fN7BjoQuGgXAo6r6ICTPXQjCQSkwHuhR3bMzwsw4Vye2cQUaMHOiYtcrv
 2Go3Q7O7TAVytxuiZf2Rfing3IeXx0/IEcwvCuUwWA1h7ppnyO6NiL3UHdUAk8BECHQl
 gVJ3wBJ6RZZhW57IxUojQQQXBgXLBrz0hGe09n85nRq5xZ7j6mOkAO58p0Qo8Y4Ti/w4
 TqefvHs0ymFnsPPI2ggvLlEM8bwjmkwIutTj+rdUMkwafqUgg40qgf4io57DKhEdW0Dh
 ve0A==
X-Gm-Message-State: AOAM5306F8/+3Rkd19N3YsaDB3tyMum1/N+qznP2Ph4TY/VWsGtSaDQU
 sHEPzxz3o7H8jT7Rk32ffSeKpDveY6mybpY2VLudCOEB
X-Google-Smtp-Source: ABdhPJwGYR4DW1xpYgTXz81smITbHPSFLNjFdX9Lbm1vtPDwLBCCDjFPIJyHS6w4eMBwSo7D7woJu2lyltmerHMa45M=
X-Received: by 2002:a25:5c2:: with SMTP id 185mr8959734ybf.161.1610614677136; 
 Thu, 14 Jan 2021 00:57:57 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7110:7a1:b029:30:3664:8494 with HTTP; Thu, 14 Jan 2021
 00:57:56 -0800 (PST)
In-Reply-To: <CADnq5_Nh7gdVfPNBix=u7HqUGHjhBuD=juFJZnxphFOpFPAh7w@mail.gmail.com>
References: <CAKR_QV+SN2Q962_v0WpeCL9tRBUBQpZ+EO6FvF8ZQ-8DG8UwMg@mail.gmail.com>
 <CAKR_QVJ6NRXZhrJEph=HxPe2O_DYwzhE3Hj52BKkX2PGEMoyAw@mail.gmail.com>
 <CADnq5_Nh7gdVfPNBix=u7HqUGHjhBuD=juFJZnxphFOpFPAh7w@mail.gmail.com>
From: Tom Psyborg <pozega.tomislav@gmail.com>
Date: Thu, 14 Jan 2021 09:57:56 +0100
Message-ID: <CAKR_QVL-D_01LJkuzWsdEyvny2wNogqhUZVnu3uXAEqHmsYqgA@mail.gmail.com>
Subject: Re: mclk stuck at low state
To: Alex Deucher <alexdeucher@gmail.com>
X-Mailman-Approved-At: Thu, 14 Jan 2021 09:30:32 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "alexander.deucher" <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 14/01/2021, Alex Deucher <alexdeucher@gmail.com> wrote:
> On Wed, Jan 13, 2021 at 8:51 AM Tom Psyborg <pozega.tomislav@gmail.com>
> wrote:
>>
>> Hi
>>
>> I see the message didn't make it to the mailing list? Any reason for
>> that?
>
> No idea.  I never saw it until now.
>
>>
>> On 10/01/2021, Tom Psyborg <pozega.tomislav@gmail.com> wrote:
>> > Hi
>> >
>> > Have an ubuntu 16.04 system here with kernel version 5.6.14, running
>> > on a laptop with FX9830P APU.
>> > During graphic load I notice the memory clock is always at the low
>> > state - 667MHz, never switching to 1200MHz. These two states are the
>> > only ones listed in pp_dpm_mclk output.
>> > I checked system memory with dmidecode, it is reported as 2400MHz.
>> > Same bug is still present with live booted ubuntu 20.10
>> >
>> > Does this introduce any regression in performance, or is just a
>> > cosmetic bug and actual mclk is the same as system memory clock?
>
> Can you provide your dmesg output?  On the APU the mclk is the system
> memory clock because the APU uses system memory.
>
> Alex
>

so it isn't possible the video part of system memory is throttled to
667MHz while the rest of it is running at 1200MHz?

[    0.000000] Linux version 5.6.14 (u16@u16-5576) (gcc version 5.4.0
20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.12)) #8 SMP Thu Jun 25 20:28:31
CEST 2020
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-5.6.14
root=UUID=d63d352b-3139-4d0b-8407-1b7c1031fbda ro quiet splash
amdgpu.dpm=1 vt.handoff=7
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Hygon HygonGenuine
[    0.000000]   Centaur CentaurHauls
[    0.000000]   zhaoxin   Shanghai
[    0.000000] [Firmware Info]: CPU: Re-enabling disabled Topology
Extensions Support.
[    0.000000] random: get_random_u32 called from
bsp_init_amd+0x241/0x2f0 with crng_init=0
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating
point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is
832 bytes, using 'standard' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009d7ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009d800-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000dc946fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000dc947000-0x00000000dd3fafff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000dd3fb000-0x00000000dd418fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000dd419000-0x00000000dd8eefff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000dd8ef000-0x00000000ddbeffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ddbf0000-0x00000000deffffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000df000000-0x00000000dfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fe200000-0x00000000fe200fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fe800000-0x00000000fe8fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000feb80000-0x00000000fec01fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec10000-0x00000000fec10fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed40000-0x00000000fed44fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed8ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fedc0000-0x00000000fedc0fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fedc2000-0x00000000fedc8fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000feefffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000029effffff] usable
[    0.000000] BIOS-e820: [mem 0x000000029f000000-0x000000031effffff] reserved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 3.0.0 present.
[    0.000000] DMI: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7 01/29/2018
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 3000.062 MHz processor
[    0.003047] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.003049] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.003056] last_pfn = 0x29f000 max_arch_pfn = 0x400000000
[    0.003062] MTRR default type: uncachable
[    0.003063] MTRR fixed ranges enabled:
[    0.003064]   00000-9FFFF write-back
[    0.003065]   A0000-BFFFF write-through
[    0.003066]   C0000-FFFFF write-protect
[    0.003067] MTRR variable ranges enabled:
[    0.003068]   0 base 000000000000 mask FFFF80000000 write-back
[    0.003070]   1 base 000080000000 mask FFFFC0000000 write-back
[    0.003071]   2 base 0000C0000000 mask FFFFE0000000 write-back
[    0.003072]   3 base 0000DF000000 mask FFFFFF000000 uncachable
[    0.003073]   4 disabled
[    0.003073]   5 disabled
[    0.003074]   6 disabled
[    0.003074]   7 disabled
[    0.003075] TOM2: 000000031f000000 aka 12784M
[    0.003343] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
[    0.003466] total RAM covered: 3568M
[    0.004093] Found optimal setting for mtrr clean up
[    0.004095]  gran_size: 64K 	chunk_size: 1G 	num_reg: 3  	lose cover RAM: 0G
[    0.004276] e820: update [mem 0xdf000000-0xffffffff] usable ==> reserved
[    0.004283] last_pfn = 0xdf000 max_arch_pfn = 0x400000000
[    0.009195] found SMP MP-table at [mem 0x000fcba0-0x000fcbaf]
[    0.009593] check: Scanning 1 areas for low memory corruption
[    0.009598] Using GB pages for direct mapping
[    0.009601] BRK [0x114201000, 0x114201fff] PGTABLE
[    0.009603] BRK [0x114202000, 0x114202fff] PGTABLE
[    0.009604] BRK [0x114203000, 0x114203fff] PGTABLE
[    0.009704] BRK [0x114204000, 0x114204fff] PGTABLE
[    0.009706] BRK [0x114205000, 0x114205fff] PGTABLE
[    0.010291] BRK [0x114206000, 0x114206fff] PGTABLE
[    0.010419] BRK [0x114207000, 0x114207fff] PGTABLE
[    0.010577] BRK [0x114208000, 0x114208fff] PGTABLE
[    0.010905] RAMDISK: [mem 0x31990000-0x34cbffff]
[    0.010915] ACPI: Early table checksum verification disabled
[    0.010919] ACPI: RSDP 0x00000000000F05B0 000024 (v02 DELL  )
[    0.010923] ACPI: XSDT 0x00000000DD402090 00009C (v01 DELL   QA09
  01072009 AMI  00010013)
[    0.010929] ACPI: FACP 0x00000000DD40BEC0 00010C (v05 DELL   QA09
  01072009 AMI  00010013)
[    0.010934] ACPI BIOS Warning (bug): Optional FADT field
Pm2ControlBlock has valid Length but zero Address:
0x0000000000000000/0x1 (20200110/tbfadt-624)
[    0.010939] ACPI: DSDT 0x00000000DD4021B8 009D08 (v02 DELL   QA09
  01072009 INTL 20120913)
[    0.010943] ACPI: FACS 0x00000000DD8EDCC0 000040
[    0.010945] ACPI: APIC 0x00000000DD40BFD0 00007E (v03 DELL   QA09
  01072009 AMI  00010013)
[    0.010948] ACPI: FPDT 0x00000000DD40C050 000044 (v01 DELL   QA09
  01072009 AMI  00010013)
[    0.010951] ACPI: FIDT 0x00000000DD40C098 00009C (v01 DELL   QA09
  01072009 AMI  00010013)
[    0.010954] ACPI: MCFG 0x00000000DD40C138 00003C (v01 DELL   QA09
  01072009 MSFT 00010013)
[    0.010956] ACPI: BOOT 0x00000000DD40C178 000028 (v01 DELL   QA09
  01072009 AMI  00010013)
[    0.010959] ACPI: SLIC 0x00000000DD40C1A0 000176 (v01 DELL   QA09
  01072009 AMI  00010013)
[    0.010962] ACPI: HPET 0x00000000DD40C318 000038 (v01 DELL   QA09
  01072009 AMI  00000005)
[    0.010965] ACPI: UEFI 0x00000000DD40C350 000042 (v01
  00000000      00000000)
[    0.010968] ACPI: MSDM 0x00000000DD40C398 000055 (v03 DELL   QA09
  01072009 AMI  00010013)
[    0.010970] ACPI: SSDT 0x00000000DD40C3F0 000B9C (v01 AMD    AGESA
  00000001 AMD  00000001)
[    0.010973] ACPI: SSDT 0x00000000DD40CF90 00888F (v02 AMD    AGESA
  00000002 MSFT 04000000)
[    0.010976] ACPI: CRAT 0x00000000DD415820 000528 (v01 AMD    AGESA
  00000001 AMD  00000001)
[    0.010978] ACPI: SSDT 0x00000000DD415D48 001587 (v01 AMD
CPMDFIGP 00000001 INTL 20120913)
[    0.010981] ACPI: SSDT 0x00000000DD4172D0 00165E (v01 AMD    CPMCMN
  00000001 INTL 20120913)
[    0.010991] ACPI: Local APIC address 0xfee00000
[    0.011087] No NUMA configuration found
[    0.011088] Faking a node at [mem 0x0000000000000000-0x000000029effffff]
[    0.011098] NODE_DATA(0) allocated [mem 0x29efd5000-0x29effffff]
[    0.011477] Zone ranges:
[    0.011478]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.011479]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.011481]   Normal   [mem 0x0000000100000000-0x000000029effffff]
[    0.011482]   Device   empty
[    0.011482] Movable zone start for each node
[    0.011484] Early memory node ranges
[    0.011485]   node   0: [mem 0x0000000000001000-0x000000000009cfff]
[    0.011486]   node   0: [mem 0x0000000000100000-0x00000000dc946fff]
[    0.011487]   node   0: [mem 0x00000000ddbf0000-0x00000000deffffff]
[    0.011488]   node   0: [mem 0x0000000100000000-0x000000029effffff]
[    0.011628] Zeroed struct page in unavailable ranges: 13069 pages
[    0.011629] Initmem setup node 0 [mem 0x0000000000001000-0x000000029effffff]
[    0.011631] On node 0 totalpages: 2608371
[    0.011633]   DMA zone: 64 pages used for memmap
[    0.011633]   DMA zone: 21 pages reserved
[    0.011634]   DMA zone: 3996 pages, LIFO batch:0
[    0.011697]   DMA32 zone: 14134 pages used for memmap
[    0.011698]   DMA32 zone: 904535 pages, LIFO batch:63
[    0.023828]   Normal zone: 26560 pages used for memmap
[    0.023829]   Normal zone: 1699840 pages, LIFO batch:63
[    0.047768] ACPI: PM-Timer IO Port: 0x808
[    0.047770] ACPI: Local APIC address 0xfee00000
[    0.047778] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.047786] IOAPIC[0]: apic_id 0, version 33, address 0xfec00000, GSI 0-23
[    0.047789] IOAPIC[1]: apic_id 1, version 33, address 0xfec01000, GSI 24-55
[    0.047791] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.047793] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.047794] ACPI: IRQ0 used by override.
[    0.047796] ACPI: IRQ9 used by override.
[    0.047798] Using ACPI (MADT) for SMP configuration information
[    0.047800] ACPI: HPET id: 0x10228201 base: 0xfed00000
[    0.047804] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.047830] PM: hibernation: Registered nosave memory: [mem
0x00000000-0x00000fff]
[    0.047831] PM: hibernation: Registered nosave memory: [mem
0x0009d000-0x0009dfff]
[    0.047832] PM: hibernation: Registered nosave memory: [mem
0x0009e000-0x0009ffff]
[    0.047833] PM: hibernation: Registered nosave memory: [mem
0x000a0000-0x000dffff]
[    0.047833] PM: hibernation: Registered nosave memory: [mem
0x000e0000-0x000fffff]
[    0.047835] PM: hibernation: Registered nosave memory: [mem
0xdc947000-0xdd3fafff]
[    0.047836] PM: hibernation: Registered nosave memory: [mem
0xdd3fb000-0xdd418fff]
[    0.047836] PM: hibernation: Registered nosave memory: [mem
0xdd419000-0xdd8eefff]
[    0.047837] PM: hibernation: Registered nosave memory: [mem
0xdd8ef000-0xddbeffff]
[    0.047838] PM: hibernation: Registered nosave memory: [mem
0xdf000000-0xdfffffff]
[    0.047839] PM: hibernation: Registered nosave memory: [mem
0xe0000000-0xf7ffffff]
[    0.047839] PM: hibernation: Registered nosave memory: [mem
0xf8000000-0xfbffffff]
[    0.047840] PM: hibernation: Registered nosave memory: [mem
0xfc000000-0xfe1fffff]
[    0.047840] PM: hibernation: Registered nosave memory: [mem
0xfe200000-0xfe200fff]
[    0.047841] PM: hibernation: Registered nosave memory: [mem
0xfe201000-0xfe7fffff]
[    0.047842] PM: hibernation: Registered nosave memory: [mem
0xfe800000-0xfe8fffff]
[    0.047842] PM: hibernation: Registered nosave memory: [mem
0xfe900000-0xfeb7ffff]
[    0.047843] PM: hibernation: Registered nosave memory: [mem
0xfeb80000-0xfec01fff]
[    0.047843] PM: hibernation: Registered nosave memory: [mem
0xfec02000-0xfec0ffff]
[    0.047844] PM: hibernation: Registered nosave memory: [mem
0xfec10000-0xfec10fff]
[    0.047844] PM: hibernation: Registered nosave memory: [mem
0xfec11000-0xfecfffff]
[    0.047845] PM: hibernation: Registered nosave memory: [mem
0xfed00000-0xfed00fff]
[    0.047845] PM: hibernation: Registered nosave memory: [mem
0xfed01000-0xfed3ffff]
[    0.047846] PM: hibernation: Registered nosave memory: [mem
0xfed40000-0xfed44fff]
[    0.047846] PM: hibernation: Registered nosave memory: [mem
0xfed45000-0xfed7ffff]
[    0.047847] PM: hibernation: Registered nosave memory: [mem
0xfed80000-0xfed8ffff]
[    0.047848] PM: hibernation: Registered nosave memory: [mem
0xfed90000-0xfedbffff]
[    0.047848] PM: hibernation: Registered nosave memory: [mem
0xfedc0000-0xfedc0fff]
[    0.047849] PM: hibernation: Registered nosave memory: [mem
0xfedc1000-0xfedc1fff]
[    0.047849] PM: hibernation: Registered nosave memory: [mem
0xfedc2000-0xfedc8fff]
[    0.047850] PM: hibernation: Registered nosave memory: [mem
0xfedc9000-0xfedfffff]
[    0.047850] PM: hibernation: Registered nosave memory: [mem
0xfee00000-0xfeefffff]
[    0.047851] PM: hibernation: Registered nosave memory: [mem
0xfef00000-0xfeffffff]
[    0.047851] PM: hibernation: Registered nosave memory: [mem
0xff000000-0xffffffff]
[    0.047853] [mem 0xe0000000-0xf7ffffff] available for PCI devices
[    0.047854] Booting paravirtualized kernel on bare hardware
[    0.047858] clocksource: refined-jiffies: mask: 0xffffffff
max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.047864] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:4
nr_cpu_ids:4 nr_node_ids:1
[    0.048429] percpu: Embedded 56 pages/cpu s192512 r8192 d28672 u524288
[    0.048436] pcpu-alloc: s192512 r8192 d28672 u524288 alloc=1*2097152
[    0.048437] pcpu-alloc: [0] 0 1 2 3
[    0.048469] Built 1 zonelists, mobility grouping on.  Total pages: 2567592
[    0.048470] Policy zone: Normal
[    0.048472] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-5.6.14
root=UUID=d63d352b-3139-4d0b-8407-1b7c1031fbda ro quiet splash
amdgpu.dpm=1 vt.handoff=7
[    0.051551] Dentry cache hash table entries: 2097152 (order: 12,
16777216 bytes, linear)
[    0.053055] Inode-cache hash table entries: 1048576 (order: 11,
8388608 bytes, linear)
[    0.053084] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.102713] Memory: 10092704K/10433484K available (14339K kernel
code, 2473K rwdata, 4784K rodata, 2420K init, 5208K bss, 340780K
reserved, 0K cma-reserved)
[    0.102855] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.102870] ftrace: allocating 43403 entries in 170 pages
[    0.122507] ftrace: allocated 170 pages with 4 groups
[    0.122617] rcu: Hierarchical RCU implementation.
[    0.122619] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=4.
[    0.122620] 	Tasks RCU enabled.
[    0.122621] rcu: RCU calculated value of scheduler-enlistment delay
is 25 jiffies.
[    0.122621] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.125925] NR_IRQS: 524544, nr_irqs: 1000, preallocated irqs: 16
[    0.126262] spurious 8259A interrupt: IRQ7.
[    0.126280] Console: colour dummy device 80x25
[    0.126285] printk: console [tty0] enabled
[    0.126306] ACPI: Core revision 20200110
[    0.126448] clocksource: hpet: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 133484873504 ns
[    0.126462] APIC: Switch to symmetric I/O mode setup
[    0.126852] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.146463] clocksource: tsc-early: mask: 0xffffffffffffffff
max_cycles: 0x2b3e800c180, max_idle_ns: 440795345743 ns
[    0.146468] Calibrating delay loop (skipped), value calculated
using timer frequency.. 6000.12 BogoMIPS (lpj=12000248)
[    0.146470] pid_max: default: 32768 minimum: 301
[    0.146510] LSM: Security Framework initializing
[    0.146521] Yama: becoming mindful.
[    0.146543] AppArmor: AppArmor initialized
[    0.146545] TOMOYO Linux initialized
[    0.146623] Mount-cache hash table entries: 32768 (order: 6, 262144
bytes, linear)
[    0.146663] Mountpoint-cache hash table entries: 32768 (order: 6,
262144 bytes, linear)
[    0.146930] BIOS may not properly restore RDRAND after suspend,
hiding RDRAND via CPUID. Use rdrand=force to reenable.
[    0.146948] LVT offset 1 assigned for vector 0xf9
[    0.146957] Last level iTLB entries: 4KB 512, 2MB 1024, 4MB 512
[    0.146957] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 512, 1GB 0
[    0.146962] Spectre V1 : Mitigation: usercopy/swapgs barriers and
__user pointer sanitization
[    0.146963] Spectre V2 : Mitigation: Full AMD retpoline
[    0.146964] Spectre V2 : Spectre v2 / SpectreRSB mitigation:
Filling RSB on context switch
[    0.146966] Speculative Store Bypass: Mitigation: Speculative Store
Bypass disabled via prctl and seccomp
[    0.147152] Freeing SMP alternatives memory: 40K
[    0.262010] smpboot: CPU0: AMD FX-9830P RADEON R7, 12 COMPUTE CORES
4C+8G (family: 0x15, model: 0x65, stepping: 0x1)
[    0.262139] Performance Events: Fam15h core perfctr, AMD PMU driver.
[    0.262143] ... version:                0
[    0.262144] ... bit width:              48
[    0.262144] ... generic registers:      6
[    0.262145] ... value mask:             0000ffffffffffff
[    0.262146] ... max period:             00007fffffffffff
[    0.262146] ... fixed-purpose events:   0
[    0.262147] ... event mask:             000000000000003f
[    0.262187] rcu: Hierarchical SRCU implementation.
[    0.262464] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.262464] smp: Bringing up secondary CPUs ...
[    0.262464] x86: Booting SMP configuration:
[    0.262464] .... node  #0, CPUs:      #1 #2 #3
[    0.266579] smp: Brought up 1 node, 4 CPUs
[    0.266582] smpboot: Max logical packages: 1
[    0.266585] smpboot: Total of 4 processors activated (24000.49 BogoMIPS)
[    0.267744] devtmpfs: initialized
[    0.267744] x86/mm: Memory block size: 128MB
[    0.267744] PM: Registering ACPI NVS region [mem
0xdd419000-0xdd8eefff] (5070848 bytes)
[    0.267744] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.267744] futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
[    0.267744] pinctrl core: initialized pinctrl subsystem
[    0.267744] PM: RTC time: 09:48:01, date: 2021-01-14
[    0.267744] thermal_sys: Registered thermal governor 'fair_share'
[    0.267744] thermal_sys: Registered thermal governor 'bang_bang'
[    0.267744] thermal_sys: Registered thermal governor 'step_wise'
[    0.267744] thermal_sys: Registered thermal governor 'user_space'
[    0.267744] NET: Registered protocol family 16
[    0.267744] audit: initializing netlink subsys (disabled)
[    0.270495] audit: type=2000 audit(1610617681.144:1):
state=initialized audit_enabled=0 res=1
[    0.270703] cpuidle: using governor ladder
[    0.270703] cpuidle: using governor menu
[    0.270703] Simple Boot Flag at 0x47 set to 0x1
[    0.270703] ACPI FADT declares the system doesn't support PCIe
ASPM, so disable it
[    0.270703] ACPI: bus type PCI registered
[    0.270703] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.270703] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem
0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.270703] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
[    0.270703] pmd_set_huge: Cannot satisfy [mem
0xf8000000-0xf8200000] with a huge-page mapping due to MTRR override.
[    0.270764] PCI: Using configuration type 1 for base access
[    0.274563] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.274563] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.310572] ACPI: Added _OSI(Module Device)
[    0.310574] ACPI: Added _OSI(Processor Device)
[    0.310575] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.310575] ACPI: Added _OSI(Processor Aggregator Device)
[    0.310576] ACPI: Added _OSI(Linux-Dell-Video)
[    0.310577] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.310578] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.327891] ACPI: 5 ACPI AML tables successfully acquired and loaded
[    0.335506] ACPI: EC: EC started
[    0.335507] ACPI: EC: interrupt blocked
[    0.336857] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.336860] ACPI: \_SB_.PCI0.SBRG.EC__: Boot DSDT EC used to handle
transactions
[    0.336860] ACPI: Interpreter enabled
[    0.336887] ACPI: (supports S0 S3 S4 S5)
[    0.336888] ACPI: Using IOAPIC for interrupt routing
[    0.336925] PCI: Using host bridge windows from ACPI; if necessary,
use "pci=nocrs" and report a bug
[    0.337294] ACPI: Enabled 3 GPEs in block 00 to 1F
[    0.340885] ACPI: Power Resource [P0ST] (on)
[    0.340926] ACPI: Power Resource [P3ST] (on)
[    0.341581] ACPI: Power Resource [P0U2] (off)
[    0.341619] ACPI: Power Resource [P3U2] (off)
[    0.342128] ACPI: Power Resource [P0U3] (off)
[    0.342167] ACPI: Power Resource [P3U3] (off)
[    0.343367] ACPI: Power Resource [P0SD] (off)
[    0.343402] ACPI: Power Resource [P3SD] (off)
[    0.384676] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.384684] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM
ClockPM Segments MSI HPX-Type3]
[    0.384924] acpi PNP0A08:00: _OSC: platform does not support [LTR]
[    0.385143] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME
AER PCIeCapability]
[    0.385144] acpi PNP0A08:00: FADT indicates ASPM is unsupported,
using BIOS configuration
[    0.385162] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain
0000 [bus 00-3f] only partially covers this bridge
[    0.385639] PCI host bridge to bus 0000:00
[    0.385641] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    0.385642] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    0.385643] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
[    0.385644] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.385646] pci_bus 0000:00: root bus resource [mem
0x000a0000-0x000bffff window]
[    0.385647] pci_bus 0000:00: root bus resource [mem
0x000c0000-0x000dffff window]
[    0.385648] pci_bus 0000:00: root bus resource [mem
0xe0000000-0xfed3ffff window]
[    0.385649] pci_bus 0000:00: root bus resource [mem
0xfedca000-0xffffffff window]
[    0.385650] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.385661] pci 0000:00:00.0: [1022:1576] type 00 class 0x060000
[    0.385794] pci 0000:00:01.0: [1002:9874] type 00 class 0x030000
[    0.385813] pci 0000:00:01.0: reg 0x10: [mem 0xe0000000-0xefffffff
64bit pref]
[    0.385822] pci 0000:00:01.0: reg 0x18: [mem 0xf0000000-0xf07fffff
64bit pref]
[    0.385827] pci 0000:00:01.0: reg 0x20: [io  0xf000-0xf0ff]
[    0.385833] pci 0000:00:01.0: reg 0x24: [mem 0xfeb00000-0xfeb3ffff]
[    0.385839] pci 0000:00:01.0: reg 0x30: [mem 0xfeb40000-0xfeb5ffff pref]
[    0.385842] pci 0000:00:01.0: enabling Extended Tags
[    0.385883] pci 0000:00:01.0: supports D1 D2
[    0.385884] pci 0000:00:01.0: PME# supported from D1 D2 D3hot
[    0.385994] pci 0000:00:01.1: [1002:9840] type 00 class 0x040300
[    0.386009] pci 0000:00:01.1: reg 0x10: [mem 0xfeb64000-0xfeb67fff 64bit]
[    0.386035] pci 0000:00:01.1: enabling Extended Tags
[    0.386068] pci 0000:00:01.1: supports D1 D2
[    0.386150] pci 0000:00:02.0: [1022:157b] type 00 class 0x060000
[    0.386249] pci 0000:00:02.2: [1022:157c] type 01 class 0x060400
[    0.386289] pci 0000:00:02.2: enabling Extended Tags
[    0.386335] pci 0000:00:02.2: PME# supported from D0 D3hot D3cold
[    0.386515] pci 0000:00:02.3: [1022:157c] type 01 class 0x060400
[    0.386554] pci 0000:00:02.3: enabling Extended Tags
[    0.386598] pci 0000:00:02.3: PME# supported from D0 D3hot D3cold
[    0.386706] pci 0000:00:03.0: [1022:157b] type 00 class 0x060000
[    0.386802] pci 0000:00:03.1: [1022:157c] type 01 class 0x060400
[    0.386843] pci 0000:00:03.1: enabling Extended Tags
[    0.386925] pci 0000:00:03.1: PME# supported from D0 D3hot D3cold
[    0.387042] pci 0000:00:08.0: [1022:1578] type 00 class 0x108000
[    0.387055] pci 0000:00:08.0: reg 0x10: [mem 0xf0800000-0xf081ffff
64bit pref]
[    0.387060] pci 0000:00:08.0: reg 0x18: [mem 0xfe900000-0xfe9fffff]
[    0.387064] pci 0000:00:08.0: reg 0x1c: [mem 0xfeb6f000-0xfeb6ffff]
[    0.387072] pci 0000:00:08.0: reg 0x24: [mem 0xfeb6a000-0xfeb6bfff]
[    0.387178] pci 0000:00:09.0: [1022:157d] type 00 class 0x060000
[    0.387271] pci 0000:00:09.2: [1022:157a] type 00 class 0x040300
[    0.387281] pci 0000:00:09.2: reg 0x10: [mem 0xfeb60000-0xfeb63fff]
[    0.387318] pci 0000:00:09.2: PME# supported from D0 D3hot D3cold
[    0.387427] pci 0000:00:10.0: [1022:7914] type 00 class 0x0c0330
[    0.387454] pci 0000:00:10.0: reg 0x10: [mem 0xfeb68000-0xfeb69fff 64bit]
[    0.387558] pci 0000:00:10.0: PME# supported from D0 D3hot D3cold
[    0.387674] pci 0000:00:11.0: [1022:7901] type 00 class 0x010601
[    0.387692] pci 0000:00:11.0: reg 0x10: [io  0xf140-0xf147]
[    0.387700] pci 0000:00:11.0: reg 0x14: [io  0xf130-0xf133]
[    0.387708] pci 0000:00:11.0: reg 0x18: [io  0xf120-0xf127]
[    0.387716] pci 0000:00:11.0: reg 0x1c: [io  0xf110-0xf113]
[    0.387724] pci 0000:00:11.0: reg 0x20: [io  0xf100-0xf10f]
[    0.387732] pci 0000:00:11.0: reg 0x24: [mem 0xfeb6d000-0xfeb6d3ff]
[    0.387768] pci 0000:00:11.0: PME# supported from D3hot
[    0.387865] pci 0000:00:12.0: [1022:7908] type 00 class 0x0c0320
[    0.387883] pci 0000:00:12.0: reg 0x10: [mem 0xfeb6c000-0xfeb6c0ff]
[    0.387953] pci 0000:00:12.0: supports D1 D2
[    0.387954] pci 0000:00:12.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.388046] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500
[    0.388192] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100
[    0.388344] pci 0000:00:18.0: [1022:1570] type 00 class 0x060000
[    0.388426] pci 0000:00:18.1: [1022:1571] type 00 class 0x060000
[    0.388505] pci 0000:00:18.2: [1022:1572] type 00 class 0x060000
[    0.388591] pci 0000:00:18.3: [1022:1573] type 00 class 0x060000
[    0.388675] pci 0000:00:18.4: [1022:1574] type 00 class 0x060000
[    0.388752] pci 0000:00:18.5: [1022:1575] type 00 class 0x060000
[    0.389061] pci 0000:01:00.0: [168c:0042] type 00 class 0x028000
[    0.389245] pci 0000:01:00.0: reg 0x10: [mem 0xfe600000-0xfe7fffff 64bit]
[    0.389927] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    0.390530] pci 0000:00:02.2: PCI bridge to [bus 01]
[    0.390536] pci 0000:00:02.2:   bridge window [mem 0xfe600000-0xfe7fffff]
[    0.390611] pci 0000:02:00.0: [10ec:8168] type 00 class 0x020000
[    0.390638] pci 0000:02:00.0: reg 0x10: [io  0xe000-0xe0ff]
[    0.390662] pci 0000:02:00.0: reg 0x18: [mem 0xfea04000-0xfea04fff 64bit]
[    0.390677] pci 0000:02:00.0: reg 0x20: [mem 0xfea00000-0xfea03fff 64bit]
[    0.390768] pci 0000:02:00.0: supports D1 D2
[    0.390769] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.390913] pci 0000:00:02.3: PCI bridge to [bus 02]
[    0.390917] pci 0000:00:02.3:   bridge window [io  0xe000-0xefff]
[    0.390920] pci 0000:00:02.3:   bridge window [mem 0xfea00000-0xfeafffff]
[    0.391018] pci 0000:00:03.1: PCI bridge to [bus 03]
[    0.391870] ACPI: PCI Interrupt Link [LNKA] (IRQs 4 *5 7 10 11 14 15)
[    0.391948] ACPI: PCI Interrupt Link [LNKB] (IRQs 4 5 7 10 11 14 15) *0
[    0.392018] ACPI: PCI Interrupt Link [LNKC] (IRQs *4 5 7 10 11 14 15)
[    0.392099] ACPI: PCI Interrupt Link [LNKD] (IRQs 4 5 7 10 *11 14 15)
[    0.392188] ACPI: PCI Interrupt Link [LNKE] (IRQs 4 5 7 10 11 14 15) *0
[    0.392251] ACPI: PCI Interrupt Link [LNKF] (IRQs 4 5 7 10 11 14 15) *0
[    0.392313] ACPI: PCI Interrupt Link [LNKG] (IRQs 4 5 7 10 *11 14 15)
[    0.392375] ACPI: PCI Interrupt Link [LNKH] (IRQs 4 5 7 *10 11 14 15)
[    0.394482] ACPI: EC: interrupt unblocked
[    0.394482] ACPI: EC: event unblocked
[    0.394484] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.394484] ACPI: EC: GPE=0x3
[    0.394484] ACPI: \_SB_.PCI0.SBRG.EC__: Boot DSDT EC used to handle
transactions and events
[    0.394510] iommu: Default domain type: Translated
[    0.394517] pci 0000:00:01.0: vgaarb: setting as boot VGA device
[    0.394517] pci 0000:00:01.0: vgaarb: VGA device added:
decodes=io+mem,owns=io+mem,locks=none
[    0.394517] pci 0000:00:01.0: vgaarb: bridge control possible
[    0.394517] vgaarb: loaded
[    0.394721] SCSI subsystem initialized
[    0.394757] libata version 3.00 loaded.
[    0.394757] ACPI: bus type USB registered
[    0.394757] usbcore: registered new interface driver usbfs
[    0.394757] usbcore: registered new interface driver hub
[    0.394757] usbcore: registered new device driver usb
[    0.396260] EDAC MC: Ver: 3.0.0
[    0.398566] PCI: Using ACPI for IRQ routing
[    0.398939] PCI: pci_cache_line_size set to 64 bytes
[    0.399079] e820: reserve RAM buffer [mem 0x0009d800-0x0009ffff]
[    0.399081] e820: reserve RAM buffer [mem 0xdc947000-0xdfffffff]
[    0.399082] e820: reserve RAM buffer [mem 0xdf000000-0xdfffffff]
[    0.399083] e820: reserve RAM buffer [mem 0x29f000000-0x29fffffff]
[    0.399212] NetLabel: Initializing
[    0.399212] NetLabel:  domain hash size = 128
[    0.399213] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.399238] NetLabel:  unlabeled traffic allowed by default
[    0.399270] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.399270] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.402474] clocksource: Switched to clocksource tsc-early
[    0.418864] VFS: Disk quotas dquot_6.6.0
[    0.418882] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.419027] AppArmor: AppArmor Filesystem Enabled
[    0.419060] pnp: PnP ACPI init
[    0.419245] system 00:00: [mem 0xf8000000-0xfbffffff] has been reserved
[    0.419252] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.419335] system 00:01: [mem 0x60000000-0xdfffffff] could not be reserved
[    0.419339] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.419414] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.419547] pnp 00:03: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.419705] pnp 00:04: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.419743] pnp 00:05: Plug and Play ACPI device, IDs DLL07e2
PNP0f13 (active)
[    0.420041] system 00:06: [io  0x04d0-0x04d1] has been reserved
[    0.420042] system 00:06: [io  0x040b] has been reserved
[    0.420044] system 00:06: [io  0x04d6] has been reserved
[    0.420045] system 00:06: [io  0x0c00-0x0c01] has been reserved
[    0.420046] system 00:06: [io  0x0c14] has been reserved
[    0.420047] system 00:06: [io  0x0c50-0x0c51] has been reserved
[    0.420048] system 00:06: [io  0x0c52] has been reserved
[    0.420050] system 00:06: [io  0x0c6c] has been reserved
[    0.420051] system 00:06: [io  0x0c6f] has been reserved
[    0.420052] system 00:06: [io  0x0cd0-0x0cd1] has been reserved
[    0.420056] system 00:06: [io  0x0cd2-0x0cd3] has been reserved
[    0.420057] system 00:06: [io  0x0cd4-0x0cd5] has been reserved
[    0.420058] system 00:06: [io  0x0cd6-0x0cd7] has been reserved
[    0.420059] system 00:06: [io  0x0cd8-0x0cdf] has been reserved
[    0.420061] system 00:06: [io  0x0800-0x089f] has been reserved
[    0.420062] system 00:06: [io  0x0b00-0x0b0f] has been reserved
[    0.420063] system 00:06: [io  0x0b20-0x0b3f] has been reserved
[    0.420064] system 00:06: [io  0x0900-0x090f] has been reserved
[    0.420065] system 00:06: [io  0x0910-0x091f] has been reserved
[    0.420067] system 00:06: [io  0x0380-0x0381] has been reserved
[    0.420069] system 00:06: [io  0xfe00-0xfefe] has been reserved
[    0.420071] system 00:06: [mem 0xfec00000-0xfec00fff] could not be reserved
[    0.420072] system 00:06: [mem 0xfec01000-0xfec01fff] could not be reserved
[    0.420073] system 00:06: [mem 0xfedc0000-0xfedc0fff] has been reserved
[    0.420075] system 00:06: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.420076] system 00:06: [mem 0xfed80000-0xfed8ffff] could not be reserved
[    0.420078] system 00:06: [mem 0xfed61000-0xfed70fff] has been reserved
[    0.420079] system 00:06: [mem 0xfe200000-0xfe200fff] has been reserved
[    0.420080] system 00:06: [mem 0xfec10000-0xfec10fff] has been reserved
[    0.420082] system 00:06: [mem 0xff000000-0xffffffff] has been reserved
[    0.420085] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.421048] pnp: PnP ACPI: found 7 devices
[    0.427072] clocksource: acpi_pm: mask: 0xffffff max_cycles:
0xffffff, max_idle_ns: 2085701024 ns
[    0.427114] pci 0000:00:03.1: bridge window [io  0x1000-0x0fff] to
[bus 03] add_size 1000
[    0.427116] pci 0000:00:03.1: bridge window [mem
0x00100000-0x000fffff 64bit pref] to [bus 03] add_size 200000
add_align 100000
[    0.427118] pci 0000:00:03.1: bridge window [mem
0x00100000-0x000fffff] to [bus 03] add_size 200000 add_align 100000
[    0.427126] pci 0000:00:03.1: BAR 14: assigned [mem 0xf0900000-0xf0afffff]
[    0.427132] pci 0000:00:03.1: BAR 15: assigned [mem
0xf0b00000-0xf0cfffff 64bit pref]
[    0.427135] pci 0000:00:03.1: BAR 13: assigned [io  0x1000-0x1fff]
[    0.427138] pci 0000:00:02.2: PCI bridge to [bus 01]
[    0.427143] pci 0000:00:02.2:   bridge window [mem 0xfe600000-0xfe7fffff]
[    0.427149] pci 0000:00:02.3: PCI bridge to [bus 02]
[    0.427152] pci 0000:00:02.3:   bridge window [io  0xe000-0xefff]
[    0.427155] pci 0000:00:02.3:   bridge window [mem 0xfea00000-0xfeafffff]
[    0.427161] pci 0000:00:03.1: PCI bridge to [bus 03]
[    0.427162] pci 0000:00:03.1:   bridge window [io  0x1000-0x1fff]
[    0.427166] pci 0000:00:03.1:   bridge window [mem 0xf0900000-0xf0afffff]
[    0.427169] pci 0000:00:03.1:   bridge window [mem
0xf0b00000-0xf0cfffff 64bit pref]
[    0.427174] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    0.427176] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
[    0.427177] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
[    0.427178] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    0.427179] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff window]
[    0.427180] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff window]
[    0.427181] pci_bus 0000:00: resource 10 [mem 0xe0000000-0xfed3ffff window]
[    0.427182] pci_bus 0000:00: resource 11 [mem 0xfedca000-0xffffffff window]
[    0.427184] pci_bus 0000:01: resource 1 [mem 0xfe600000-0xfe7fffff]
[    0.427185] pci_bus 0000:02: resource 0 [io  0xe000-0xefff]
[    0.427186] pci_bus 0000:02: resource 1 [mem 0xfea00000-0xfeafffff]
[    0.427187] pci_bus 0000:03: resource 0 [io  0x1000-0x1fff]
[    0.427188] pci_bus 0000:03: resource 1 [mem 0xf0900000-0xf0afffff]
[    0.427189] pci_bus 0000:03: resource 2 [mem 0xf0b00000-0xf0cfffff
64bit pref]
[    0.427311] NET: Registered protocol family 2
[    0.427537] tcp_listen_portaddr_hash hash table entries: 8192
(order: 5, 131072 bytes, linear)
[    0.427563] TCP established hash table entries: 131072 (order: 8,
1048576 bytes, linear)
[    0.427733] TCP bind hash table entries: 65536 (order: 8, 1048576
bytes, linear)
[    0.427926] TCP: Hash tables configured (established 131072 bind 65536)
[    0.427981] UDP hash table entries: 8192 (order: 6, 262144 bytes, linear)
[    0.428034] UDP-Lite hash table entries: 8192 (order: 6, 262144
bytes, linear)
[    0.428146] NET: Registered protocol family 1
[    0.428176] pci 0000:00:01.0: Video device with shadowed ROM at
[mem 0x000c0000-0x000dffff]
[    0.428182] pci 0000:00:01.1: D0 power state depends on 0000:00:01.0
[    0.428470] pci 0000:00:10.0: PME# does not work under D0, disabling it
[    0.451781] pci 0000:00:12.0: quirk_usb_early_handoff+0x0/0x6c0
took 22748 usecs
[    0.451855] PCI: CLS 0 bytes, default 64
[    0.451907] Trying to unpack rootfs image as initramfs...
[    1.258781] Freeing initrd memory: 52416K
[    1.258821] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    1.258823] software IO TLB: mapped [mem 0xd8947000-0xdc947000] (64MB)
[    1.258884] amd_uncore: AMD NB counters detected
[    1.259484] LVT offset 0 assigned for vector 0x400
[    1.259911] perf: AMD IBS detected (0x000007ff)
[    1.259988] check: Scanning for low memory corruption every 60 seconds
[    1.262388] Initialise system trusted keyrings
[    1.262398] Key type blacklist registered
[    1.262603] workingset: timestamp_bits=36 max_order=22 bucket_order=0
[    1.264087] zbud: loaded
[    1.264397] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    1.264963] fuse: init (API version 7.31)
[    1.270617] Key type asymmetric registered
[    1.270619] Asymmetric key parser 'x509' registered
[    1.270639] Block layer SCSI generic (bsg) driver version 0.4
loaded (major 247)
[    1.270715] io scheduler mq-deadline registered
[    1.271513] pcieport 0000:00:02.2: PME: Signaling with IRQ 25
[    1.271677] pcieport 0000:00:02.3: PME: Signaling with IRQ 26
[    1.271843] pcieport 0000:00:03.1: PME: Signaling with IRQ 28
[    1.271868] pcieport 0000:00:03.1: pciehp: Slot #0 AttnBtn-
PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise- Interlock- NoCompl+
LLActRep+
[    1.272408] vesafb: mode is 1920x1080x32, linelength=7680, pages=0
[    1.272410] vesafb: scrolling: redraw
[    1.272411] vesafb: Truecolor: size=0:8:8:8, shift=0:16:8:0
[    1.272436] vesafb: framebuffer at 0xe0000000, mapped to
0x(____ptrval____), using 8128k, total 8128k
[    1.272539] Console: switching to colour frame buffer device 240x67
[    1.296487] fb0: VESA VGA frame buffer device
[    1.297772] ACPI: AC Adapter [ACAD] (on-line)
[    1.297867] input: Power Button as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    1.297885] ACPI: Power Button [PWRB]
[    1.297923] input: Lid Switch as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input1
[    1.297964] ACPI: Lid Switch [LID0]
[    1.297993] input: Sleep Button as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input2
[    1.298008] ACPI: Sleep Button [SLPB]
[    1.298038] input: Power Button as
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[    1.298067] ACPI: Power Button [PWRF]
[    1.298117] ACPI: \_PR_.P000: Found 2 idle states
[    1.298294] ACPI: \_PR_.P001: Found 2 idle states
[    1.298374] ACPI: \_PR_.P002: Found 2 idle states
[    1.298441] ACPI: \_PR_.P003: Found 2 idle states
[    1.298968] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    1.299284] battery: ACPI: Battery Slot [BAT0] (battery absent)
[    1.301049] Linux agpgart interface v0.103
[    1.304947] loop: module loaded
[    1.305236] libphy: Fixed MDIO Bus: probed
[    1.305237] tun: Universal TUN/TAP device driver, 1.6
[    1.305385] PPP generic driver version 2.4.2
[    1.305428] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.305430] ehci-pci: EHCI PCI platform driver
[    1.305613] ehci-pci 0000:00:12.0: EHCI Host Controller
[    1.305625] ehci-pci 0000:00:12.0: new USB bus registered, assigned
bus number 1
[    1.305637] ehci-pci 0000:00:12.0: debug port 2
[    1.305680] ehci-pci 0000:00:12.0: irq 18, io mem 0xfeb6c000
[    1.318705] ehci-pci 0000:00:12.0: USB 2.0 started, EHCI 1.00
[    1.318784] usb usb1: New USB device found, idVendor=1d6b,
idProduct=0002, bcdDevice= 5.06
[    1.318786] usb usb1: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    1.318787] usb usb1: Product: EHCI Host Controller
[    1.318788] usb usb1: Manufacturer: Linux 5.6.14 ehci_hcd
[    1.318789] usb usb1: SerialNumber: 0000:00:12.0
[    1.318958] hub 1-0:1.0: USB hub found
[    1.318964] hub 1-0:1.0: 2 ports detected
[    1.319180] ehci-platform: EHCI generic platform driver
[    1.319203] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.319206] ohci-pci: OHCI PCI platform driver
[    1.319217] ohci-platform: OHCI generic platform driver
[    1.319226] uhci_hcd: USB Universal Host Controller Interface driver
[    1.319356] xhci_hcd 0000:00:10.0: xHCI Host Controller
[    1.319362] xhci_hcd 0000:00:10.0: new USB bus registered, assigned
bus number 2
[    1.319538] xhci_hcd 0000:00:10.0: hcc params 0x014040c3 hci
version 0x100 quirks 0x0000000000000410
[    1.319778] usb usb2: New USB device found, idVendor=1d6b,
idProduct=0002, bcdDevice= 5.06
[    1.319779] usb usb2: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    1.319780] usb usb2: Product: xHCI Host Controller
[    1.319782] usb usb2: Manufacturer: Linux 5.6.14 xhci-hcd
[    1.319782] usb usb2: SerialNumber: 0000:00:10.0
[    1.320006] hub 2-0:1.0: USB hub found
[    1.320015] hub 2-0:1.0: 4 ports detected
[    1.320254] xhci_hcd 0000:00:10.0: xHCI Host Controller
[    1.320257] xhci_hcd 0000:00:10.0: new USB bus registered, assigned
bus number 3
[    1.320259] xhci_hcd 0000:00:10.0: Host supports USB 3.0 SuperSpeed
[    1.326471] usb usb3: We don't know the algorithms for LPM for this
host, disabling LPM.
[    1.326498] usb usb3: New USB device found, idVendor=1d6b,
idProduct=0003, bcdDevice= 5.06
[    1.326499] usb usb3: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    1.326500] usb usb3: Product: xHCI Host Controller
[    1.326501] usb usb3: Manufacturer: Linux 5.6.14 xhci-hcd
[    1.326502] usb usb3: SerialNumber: 0000:00:10.0
[    1.326656] hub 3-0:1.0: USB hub found
[    1.326665] hub 3-0:1.0: 4 ports detected
[    1.326878] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M]
at 0x60,0x64 irq 1,12
[    1.330174] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.330178] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.330419] mousedev: PS/2 mouse device common for all mice
[    1.330619] rtc_cmos 00:03: RTC can wake from S4
[    1.330795] rtc_cmos 00:03: registered as rtc0
[    1.330813] rtc_cmos 00:03: alarms up to one month, y3k, 114 bytes
nvram, hpet irqs
[    1.330819] i2c /dev entries driver
[    1.330929] device-mapper: uevent: version 1.0.3
[    1.330990] device-mapper: ioctl: 4.42.0-ioctl (2020-02-27)
initialised: dm-devel@redhat.com
[    1.331048] ledtrig-cpu: registered to indicate activity on CPUs
[    1.331110] x86/pm: family 0x15 cpu detected, MSR saving is needed
during suspending.
[    1.331136] drop_monitor: Initializing network drop monitor service
[    1.331338] NET: Registered protocol family 10
[    1.337145] input: AT Translated Set 2 keyboard as
/devices/platform/i8042/serio0/input/input4
[    1.337357] Segment Routing with IPv6
[    1.337387] NET: Registered protocol family 17
[    1.337471] Key type dns_resolver registered
[    1.337767] RAS: Correctable Errors collector initialized.
[    1.337809] microcode: CPU0: patch_level=0x06006118
[    1.337815] microcode: CPU1: patch_level=0x06006118
[    1.337819] microcode: CPU2: patch_level=0x06006118
[    1.337825] microcode: CPU3: patch_level=0x06006118
[    1.337856] microcode: Microcode Update Driver: v2.2.
[    1.337861] IPI shorthand broadcast: enabled
[    1.337867] sched_clock: Marking stable (1337497139,
354321)->(1353925902, -16074442)
[    1.337947] registered taskstats version 1
[    1.337958] Loading compiled-in X.509 certificates
[    1.339873] Loaded X.509 cert 'Build time autogenerated kernel key:
8287e02fa3211d1858f5852279ded266930e245f'
[    1.339914] zswap: loaded using pool lzo/zbud
[    1.340114] Key type ._fscrypt registered
[    1.340115] Key type .fscrypt registered
[    1.340115] Key type fscrypt-provisioning registered
[    1.346251] Key type big_key registered
[    1.349328] Key type encrypted registered
[    1.349334] AppArmor: AppArmor sha1 policy hashing enabled
[    1.349345] ima: No TPM chip found, activating TPM-bypass!
[    1.349352] ima: Allocated hash algorithm: sha1
[    1.349361] ima: No architecture policies found
[    1.349371] evm: Initialising EVM extended attributes:
[    1.349371] evm: security.selinux
[    1.349372] evm: security.SMACK64
[    1.349372] evm: security.SMACK64EXEC
[    1.349373] evm: security.SMACK64TRANSMUTE
[    1.349373] evm: security.SMACK64MMAP
[    1.349374] evm: security.apparmor
[    1.349374] evm: security.ima
[    1.349374] evm: security.capability
[    1.349376] evm: HMAC attrs: 0x1
[    1.349743] PM:   Magic number: 5:760:828
[    1.349938] rtc_cmos 00:03: setting system clock to
2021-01-14T09:48:02 UTC (1610617682)
[    1.350209] acpi_cpufreq: overriding BIOS provided _PSD data
[    1.352382] Freeing unused decrypted memory: 2040K
[    1.353097] Freeing unused kernel image (initmem) memory: 2420K
[    1.370746] Write protecting the kernel read-only data: 22528k
[    1.371454] Freeing unused kernel image (text/rodata gap) memory: 2044K
[    1.371883] Freeing unused kernel image (rodata/data gap) memory: 1360K
[    1.401623] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.401627] Run /init as init process
[    1.401629]   with arguments:
[    1.401629]     /init
[    1.401630]     splash
[    1.401630]   with environment:
[    1.401631]     HOME=/
[    1.401631]     TERM=linux
[    1.401632]     BOOT_IMAGE=/boot/vmlinuz-5.6.14
[    1.414308] random: systemd-udevd: uninitialized urandom read (16 bytes read)
[    1.414382] random: systemd-udevd: uninitialized urandom read (16 bytes read)
[    1.414394] random: systemd-udevd: uninitialized urandom read (16 bytes read)
[    1.459700] hid: raw HID events driver (C) Jiri Kosina
[    1.461105] ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
[    1.461581] acpi device:02: registered as cooling_device4
[    1.461641] input: Video Bus as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input7
[    1.469213] i2c_hid i2c-ELAN1010:00: i2c-ELAN1010:00 supply vdd not
found, using dummy regulator
[    1.469238] i2c_hid i2c-ELAN1010:00: i2c-ELAN1010:00 supply vddl
not found, using dummy regulator
[    1.474403] wmi_bus wmi_bus-PNP0C14:00: WQBC data block query
control method not found
[    1.479474] ahci 0000:00:11.0: version 3.0
[    1.479724] ahci 0000:00:11.0: AHCI 0001.0300 32 slots 1 ports 6
Gbps 0x2 impl SATA mode
[    1.479727] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led
clo pmp fbs pio slum part
[    1.481583] r8169 0000:02:00.0: can't disable ASPM; OS doesn't have
ASPM control
[    1.484249] scsi host0: ahci
[    1.486574] scsi host1: ahci
[    1.486662] ata1: DUMMY
[    1.486665] ata2: SATA max UDMA/133 abar m1024@0xfeb6d000 port
0xfeb6d180 irq 19
[    1.486796] random: fast init done
[    1.496133] libphy: r8169: probed
[    1.496347] r8169 0000:02:00.0 eth0: RTL8168h/8111h,
f4:8e:38:f1:b0:dc, XID 541, IRQ 36
[    1.496349] r8169 0000:02:00.0 eth0: jumbo features [frames: 9200
bytes, tx checksumming: ko]
[    1.520639] r8169 0000:02:00.0 enp2s0: renamed from eth0
[    1.521655] input: ELAN1010:00 04F3:3012 Mouse as
/devices/platform/AMD0010:00/i2c-0/i2c-ELAN1010:00/0018:04F3:3012.0001/input/input9
[    1.521777] input: ELAN1010:00 04F3:3012 Touchpad as
/devices/platform/AMD0010:00/i2c-0/i2c-ELAN1010:00/0018:04F3:3012.0001/input/input10
[    1.521874] hid-generic 0018:04F3:3012.0001: input,hidraw0: I2C HID
v1.00 Mouse [ELAN1010:00 04F3:3012] on i2c-ELAN1010:00
[    1.584046] [drm] amdgpu kernel modesetting enabled.
[    1.584105] checking generic (e0000000 7f0000) vs hw (e0000000 10000000)
[    1.584106] fb0: switching to amdgpudrmfb from VESA VGA
[    1.584199] Console: switching to colour dummy device 80x25
[    1.584271] amdgpu 0000:00:01.0: vgaarb: deactivate vga console
[    1.585691] [drm] initializing kernel modesetting (CARRIZO
0x1002:0x9874 0x1028:0x07E2 0xCC).
[    1.596342] [drm] register mmio base: 0xFEB00000
[    1.596344] [drm] register mmio size: 262144
[    1.596350] [drm] add ip block number 0 <vi_common>
[    1.596351] [drm] add ip block number 1 <gmc_v8_0>
[    1.596352] [drm] add ip block number 2 <cz_ih>
[    1.596353] [drm] add ip block number 3 <gfx_v8_0>
[    1.596354] [drm] add ip block number 4 <sdma_v3_0>
[    1.596355] [drm] add ip block number 5 <powerplay>
[    1.596356] [drm] add ip block number 6 <dm>
[    1.596357] [drm] add ip block number 7 <uvd_v6_0>
[    1.596358] [drm] add ip block number 8 <vce_v3_0>
[    1.596358] [drm] add ip block number 9 <acp_ip>
[    1.607916] [drm] BIOS signature incorrect 0 0
[    1.607972] ATOM BIOS: 113-C75100-031
[    1.607993] [drm] UVD is enabled in physical mode
[    1.607996] [drm] VCE enabled in physical mode
[    1.608038] [drm] vm size is 64 GB, 2 levels, block size is 10-bit,
fragment size is 9-bit
[    1.608045] amdgpu 0000:00:01.0: VRAM: 2048M 0x000000F400000000 -
0x000000F47FFFFFFF (2048M used)
[    1.608047] amdgpu 0000:00:01.0: GART: 1024M 0x000000FF00000000 -
0x000000FF3FFFFFFF
[    1.608051] [drm] Detected VRAM RAM=2048M, BAR=2048M
[    1.608051] [drm] RAM width 128bits UNKNOWN
[    1.608246] [TTM] Zone  kernel: Available graphics memory: 5076512 KiB
[    1.608247] [TTM] Zone   dma32: Available graphics memory: 2097152 KiB
[    1.608248] [TTM] Initializing pool allocator
[    1.608252] [TTM] Initializing DMA pool allocator
[    1.608341] [drm] amdgpu: 2048M of VRAM memory ready
[    1.608345] [drm] amdgpu: 3072M of GTT memory ready.
[    1.608363] [drm] GART: num cpu pages 262144, num gpu pages 262144
[    1.608403] [drm] PCIE GART of 1024M enabled (table at 0x000000F4007E9000).
[    1.609930] amdgpu: [powerplay] hwmgr_sw_init smu backed is smu8_smu
[    1.610065] [drm] Found UVD firmware Version: 1.87 Family ID: 11
[    1.610068] [drm] UVD ENC is disabled
[    1.610736] [drm] Found VCE firmware Version: 52.4 Binary ID: 3
[    1.611173] smu version 27.17.00
[    1.616050] [drm] DM_PPLIB: values for Engine clock
[    1.616051] [drm] DM_PPLIB:	 300000
[    1.616051] [drm] DM_PPLIB:	 464520
[    1.616052] [drm] DM_PPLIB:	 576000
[    1.616052] [drm] DM_PPLIB:	 654550
[    1.616053] [drm] DM_PPLIB:	 720000
[    1.616053] [drm] DM_PPLIB:	 800000
[    1.616054] [drm] DM_PPLIB:	 847060
[    1.616054] [drm] DM_PPLIB:	 900000
[    1.616055] [drm] DM_PPLIB: Validation clocks:
[    1.616055] [drm] DM_PPLIB:    engine_max_clock: 90000
[    1.616056] [drm] DM_PPLIB:    memory_max_clock: 120000
[    1.616056] [drm] DM_PPLIB:    level           : 8
[    1.616058] [drm] DM_PPLIB: values for Display clock
[    1.616058] [drm] DM_PPLIB:	 300000
[    1.616059] [drm] DM_PPLIB:	 400000
[    1.616059] [drm] DM_PPLIB:	 496560
[    1.616060] [drm] DM_PPLIB:	 626090
[    1.616060] [drm] DM_PPLIB:	 685720
[    1.616060] [drm] DM_PPLIB:	 757900
[    1.616061] [drm] DM_PPLIB:	 800000
[    1.616061] [drm] DM_PPLIB:	 847060
[    1.616062] [drm] DM_PPLIB: Validation clocks:
[    1.616062] [drm] DM_PPLIB:    engine_max_clock: 90000
[    1.616062] [drm] DM_PPLIB:    memory_max_clock: 120000
[    1.616063] [drm] DM_PPLIB:    level           : 8
[    1.616064] [drm] DM_PPLIB: values for Memory clock
[    1.616064] [drm] DM_PPLIB:	 667000
[    1.616065] [drm] DM_PPLIB:	 1200000
[    1.616065] [drm] DM_PPLIB: Validation clocks:
[    1.616065] [drm] DM_PPLIB:    engine_max_clock: 90000
[    1.616066] [drm] DM_PPLIB:    memory_max_clock: 120000
[    1.616066] [drm] DM_PPLIB:    level           : 8
[    1.616132] [drm] Display Core initialized with v3.2.69!
[    1.645672] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    1.645674] [drm] Driver supports precise vblank timestamp query.
[    1.654594] usb 1-1: new high-speed USB device number 2 using ehci-pci
[    1.671629] [drm] UVD initialized successfully.
[    1.810877] usb 1-1: New USB device found, idVendor=0438,
idProduct=7900, bcdDevice= 0.18
[    1.810880] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    1.811156] hub 1-1:1.0: USB hub found
[    1.811243] hub 1-1:1.0: 4 ports detected
[    1.871484] [drm] VCE initialized successfully.
[    1.872299] [drm] fb mappable at 0x29FDCC000
[    1.872300] [drm] vram apper at 0x29F000000
[    1.872300] [drm] size 8294400
[    1.872301] [drm] fb depth is 24
[    1.872301] [drm]    pitch is 7680
[    1.872382] fbcon: amdgpudrmfb (fb0) is primary device
[    1.883575] Console: switching to colour frame buffer device 240x67
[    1.904414] amdgpu 0000:00:01.0: fb0: amdgpudrmfb frame buffer device
[    1.927346] [drm] Initialized amdgpu 3.36.0 20150101 for
0000:00:01.0 on minor 0
[    1.962675] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.963688] ata2.00: ATA-10: MTFDDAK512MBF-1AN1ZABHA, M603, max UDMA/133
[    1.963689] ata2.00: 1000215216 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    1.967108] ata2.00: configured for UDMA/133
[    1.967252] scsi 1:0:0:0: Direct-Access     ATA
MTFDDAK512MBF-1A M603 PQ: 0 ANSI: 5
[    1.967463] sd 1:0:0:0: Attached scsi generic sg0 type 0
[    1.967544] sd 1:0:0:0: [sda] 1000215216 512-byte logical blocks:
(512 GB/477 GiB)
[    1.967553] sd 1:0:0:0: [sda] Write Protect is off
[    1.967555] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.967567] sd 1:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    1.983310]  sda: sda1 sda2 sda3 sda4 < sda5 >
[    1.983770] sd 1:0:0:0: [sda] Attached SCSI disk
[    2.114664] usb 1-1.2: new full-speed USB device number 3 using ehci-pci
[    2.228813] usb 1-1.2: New USB device found, idVendor=0cf3,
idProduct=e009, bcdDevice= 0.01
[    2.228816] usb 1-1.2: New USB device strings: Mfr=0, Product=0,
SerialNumber=0
[    2.270641] tsc: Refined TSC clocksource calibration: 2999.999 MHz
[    2.270648] clocksource: tsc: mask: 0xffffffffffffffff max_cycles:
0x2b3e44b2357, max_idle_ns: 440795324996 ns
[    2.270673] clocksource: Switched to clocksource tsc
[    2.310622] usb 1-1.3: new high-speed USB device number 4 using ehci-pci
[    2.362279] process '/bin/fstype' started with executable stack
[    2.438486] psmouse serio1: elantech: synaptics_send_cmd query 0x01 failed.
[    2.438524] psmouse serio1: elantech: failed to query firmware version.
[    2.451622] EXT4-fs (sda5): mounted filesystem with ordered data
mode. Opts: (null)
[    2.478907] usb 1-1.3: New USB device found, idVendor=1bcf,
idProduct=2b8a, bcdDevice=47.11
[    2.478910] usb 1-1.3: New USB device strings: Mfr=1, Product=2,
SerialNumber=0
[    2.478912] usb 1-1.3: Product: Integrated_Webcam_HD
[    2.478913] usb 1-1.3: Manufacturer: CNFDH73N114020000502
[    2.492987] Not activating Mandatory Access Control as
/sbin/tomoyo-init does not exist.
[    2.563241] systemd[1]: systemd 229 running in system mode. (+PAM
+AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP
+GCRYPT +GNUTLS +ACL +XZ -LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN)
[    2.582813] systemd[1]: Detected architecture x86-64.
[    2.583049] systemd[1]: Set hostname to <u16-5576>.
[    2.634573] usb 1-1.4: new high-speed USB device number 5 using ehci-pci
[    2.645289] systemd[1]: Reached target User and Group Name Lookups.
[    2.645408] systemd[1]: Listening on Syslog Socket.
[    2.645440] systemd[1]: Listening on udev Kernel Socket.
[    2.645553] systemd[1]: Created slice System Slice.
[    2.645630] systemd[1]: Listening on Journal Audit Socket.
[    2.645685] systemd[1]: Created slice User and Session Slice.
[    2.645714] systemd[1]: Listening on udev Control Socket.
[    2.665338] EXT4-fs (sda5): re-mounted. Opts: errors=remount-ro
[    2.670721] lp: driver loaded but no devices found
[    2.674215] ppdev: user-space parallel port driver
[    2.712783] systemd-journald[311]: Received request to flush
runtime journal from PID 1
[    2.747507] usb 1-1.4: New USB device found, idVendor=0bda,
idProduct=0129, bcdDevice=39.60
[    2.747510] usb 1-1.4: New USB device strings: Mfr=1, Product=2,
SerialNumber=3
[    2.747512] usb 1-1.4: Product: USB2.0-CRW
[    2.747513] usb 1-1.4: Manufacturer: Generic
[    2.747515] usb 1-1.4: SerialNumber: 20100201396000000
[    2.870897] input: DELL Wireless hotkeys as /devices/virtual/input/input11
[    2.920128] audit: type=1400 audit(1610617684.064:2):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="/sbin/dhclient" pid=520 comm="apparmor_parser"
[    2.920133] audit: type=1400 audit(1610617684.064:3):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=520
comm="apparmor_parser"
[    2.920135] audit: type=1400 audit(1610617684.064:4):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="/usr/lib/NetworkManager/nm-dhcp-helper" pid=520
comm="apparmor_parser"
[    2.920137] audit: type=1400 audit(1610617684.064:5):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="/usr/lib/connman/scripts/dhclient-script" pid=520
comm="apparmor_parser"
[    2.945487] audit: type=1400 audit(1610617684.088:6):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="/usr/lib/lightdm/lightdm-guest-session" pid=519
comm="apparmor_parser"
[    2.945493] audit: type=1400 audit(1610617684.088:7):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="/usr/lib/lightdm/lightdm-guest-session//chromium" pid=519
comm="apparmor_parser"
[    2.953484] audit: type=1400 audit(1610617684.096:8):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="webbrowser-app" pid=524 comm="apparmor_parser"
[    2.953489] audit: type=1400 audit(1610617684.096:9):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="webbrowser-app//oxide_helper" pid=524 comm="apparmor_parser"
[    2.983926] audit: type=1400 audit(1610617684.128:10):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="/usr/bin/evince" pid=522 comm="apparmor_parser"
[    3.012962] piix4_smbus 0000:00:14.0: SMBus Host Controller at
0xb00, revision 0
[    3.012966] piix4_smbus 0000:00:14.0: Using register 0x02 for SMBus
port selection
[    3.066689] cfg80211: Loading compiled-in X.509 certificates for
regulatory database
[    3.074290] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    3.091050] dcdbas dcdbas: Dell Systems Management Base Driver
(version 5.6.0-3.3)
[    3.096069] dell-smbios A80593CE-A997-11DA-B012-B622A1EF5492: WMI
SMBIOS userspace interface not supported(0), try upgrading to a newer
BIOS
[    3.101656] cryptd: max_cpu_qlen set to 1000
[    3.114969] input: PS/2 Logitech Wheel Mouse as
/devices/platform/i8042/serio1/input/input8
[    3.133687] input: Dell WMI hotkeys as
/devices/platform/PNP0C14:00/wmi_bus/wmi_bus-PNP0C14:00/9DBB5994-A997-11DA-B012-B622A1EF5492/input/input12
[    3.136315] AVX2 version of gcm_enc/dec engaged.
[    3.136317] AES CTR mode by8 optimization enabled
[    3.148874] input: ELAN1010:00 04F3:3012 Mouse as
/devices/platform/AMD0010:00/i2c-0/i2c-ELAN1010:00/0018:04F3:3012.0001/input/input13
[    3.149034] input: ELAN1010:00 04F3:3012 Touchpad as
/devices/platform/AMD0010:00/i2c-0/i2c-ELAN1010:00/0018:04F3:3012.0001/input/input14
[    3.149187] hid-multitouch 0018:04F3:3012.0001: input,hidraw0: I2C
HID v1.00 Mouse [ELAN1010:00 04F3:3012] on i2c-ELAN1010:00
[    3.218744] ath10k_pci 0000:01:00.0: pci irq msi oper_irq_mode 2
irq_mode 0 reset_mode 0
[    3.260316] snd_hda_intel 0000:00:01.1: Force to non-snoop mode
[    3.270215] snd_hda_intel 0000:00:01.1: bound 0000:00:01.0 (ops
amdgpu_dm_audio_component_bind_ops [amdgpu])
[    3.271008] input: HDA ATI HDMI HDMI/DP,pcm=3 as
/devices/pci0000:00/0000:00:01.1/sound/card0/input15
[    3.367254] snd_hda_codec_realtek hdaudioC1D0: autoconfig for
ALC3246: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
[    3.367262] snd_hda_codec_realtek hdaudioC1D0:    speaker_outs=0
(0x0/0x0/0x0/0x0/0x0)
[    3.367264] snd_hda_codec_realtek hdaudioC1D0:    hp_outs=1
(0x21/0x0/0x0/0x0/0x0)
[    3.367265] snd_hda_codec_realtek hdaudioC1D0:    mono: mono_out=0x0
[    3.367266] snd_hda_codec_realtek hdaudioC1D0:    inputs:
[    3.367268] snd_hda_codec_realtek hdaudioC1D0:      Headset Mic=0x19
[    3.367269] snd_hda_codec_realtek hdaudioC1D0:      Headphone Mic=0x1a
[    3.367271] snd_hda_codec_realtek hdaudioC1D0:      Internal Mic=0x12
[    3.379223] kvm: Nested Virtualization enabled
[    3.379227] kvm: Nested Paging enabled
[    3.379227] SVM: Virtual VMLOAD VMSAVE supported
[    3.379228] SVM: Virtual GIF supported
[    3.385341] MCE: In-kernel MCE decoding enabled.
[    3.401996] EDAC amd64: F15h detected (node 0).
[    3.402006] EDAC amd64: Error: F1 not found: device 0x1601 (broken BIOS?)
[    3.440468] input: HD-Audio Generic Headphone Mic as
/devices/pci0000:00/0000:00:09.2/sound/card1/input16
[    3.463058] EDAC amd64: F15h detected (node 0).
[    3.463067] EDAC amd64: Error: F1 not found: device 0x1601 (broken BIOS?)
[    3.502783] ath10k_pci 0000:01:00.0: qca9377 hw1.1 target
0x05020001 chip_id 0x003821ff sub 1028:1810
[    3.502787] ath10k_pci 0000:01:00.0: kconfig debug 0 debugfs 1
tracing 1 dfs 0 testmode 0
[    3.503225] ath10k_pci 0000:01:00.0: firmware ver
WLAN.TF.1.0-00267-1 api 5 features ignore-otp crc32 79cea2c7
[    3.539269] EDAC amd64: F15h detected (node 0).
[    3.539279] EDAC amd64: Error: F1 not found: device 0x1601 (broken BIOS?)
[    3.595583] ath10k_pci 0000:01:00.0: failed to fetch board data for
bus=pci,vendor=168c,device=0042,subsystem-vendor=1028,subsystem-device=1810
from ath10k/QCA9377/hw1.0/board-2.bin
[    3.595873] ath10k_pci 0000:01:00.0: board_file api 1 bmi_id N/A
crc32 544289f7
[    3.615031] EDAC amd64: F15h detected (node 0).
[    3.615041] EDAC amd64: Error: F1 not found: device 0x1601 (broken BIOS?)
[    3.651653] Generic FE-GE Realtek PHY r8169-200:00: attached PHY
driver [Generic FE-GE Realtek PHY] (mii_bus:phy_addr=r8169-200:00,
irq=IGNORE)
[    3.679528] ath10k_pci 0000:01:00.0: htt-ver 3.1 wmi-op 4 htt-op 3
cal otp max-sta 32 raw 0 hwcrypto 1
[    3.776625] ath: EEPROM regdomain: 0x6c
[    3.776628] ath: EEPROM indicates we should expect a direct regpair map
[    3.776630] ath: Country alpha2 being used: 00
[    3.776630] ath: Regpair used: 0x6c
[    3.780090] r8169 0000:02:00.0 enp2s0: Link is Down
[    3.789735] ath10k_pci 0000:01:00.0 wlp1s0: renamed from wlan0
[    3.978064] random: crng init done
[    3.978067] random: 7 urandom warning(s) missed due to ratelimiting
[    3.994090] usbcore: registered new interface driver rtsx_usb
[    4.020595] mc: Linux media interface: v0.10
[    4.027124] Bluetooth: Core ver 2.22
[    4.027149] NET: Registered protocol family 31
[    4.027150] Bluetooth: HCI device and connection manager initialized
[    4.027155] Bluetooth: HCI socket layer initialized
[    4.027157] Bluetooth: L2CAP socket layer initialized
[    4.027160] Bluetooth: SCO socket layer initialized
[    4.031635] videodev: Linux video capture interface: v2.00
[    4.038962] usbcore: registered new interface driver btusb
[    4.041370] Bluetooth: hci0: using rampatch file:
qca/rampatch_usb_00000302.bin
[    4.041373] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8,
firmware rome 0x302 build 0x111
[    4.050225] uvcvideo: Found UVC 1.00 device Integrated_Webcam_HD (1bcf:2b8a)
[    4.072422] uvcvideo 1-1.3:1.0: Entity type for entity Extension 4
was not initialized!
[    4.072425] uvcvideo 1-1.3:1.0: Entity type for entity Extension 3
was not initialized!
[    4.072427] uvcvideo 1-1.3:1.0: Entity type for entity Processing 2
was not initialized!
[    4.072428] uvcvideo 1-1.3:1.0: Entity type for entity Camera 1 was
not initialized!
[    4.072516] input: Integrated_Webcam_HD: Integrate as
/devices/pci0000:00/0000:00:12.0/usb1/1-1/1-1.3/1-1.3:1.0/input/input17
[    4.072619] usbcore: registered new interface driver uvcvideo
[    4.072620] USB Video Class driver (1.1.1)
[    4.108253] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
[    4.630575] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    4.630577] Bluetooth: BNEP filters: protocol multicast
[    4.630581] Bluetooth: BNEP socket layer initialized
[    7.556021] Bluetooth: RFCOMM TTY layer initialized
[    7.556029] Bluetooth: RFCOMM socket layer initialized
[    7.556039] Bluetooth: RFCOMM ver 1.11
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
