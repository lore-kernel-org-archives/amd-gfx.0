Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C77C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jan 2022 22:07:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B57310E246;
	Wed, 19 Jan 2022 22:07:14 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 510AB10E1EE
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 21:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1642629110;
 bh=FfPmS7bpU3wrsGRTv1JARm3abmFPO4N7hu6YoJ1031k=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:Date;
 b=bKBbU3y7YolETi8hSz5XczuE0gs29QzfmvbbL/SZqyBLA/D7vt996RTwpKNbSF9A1
 XJ2sxhjtbZeA04OOAPp83tSHWlFjnlXWq99htejZRVF6CZrzLSAwn7NTyMZeqMG7/n
 6167cdCq0nJHesSD0ooAo43oTVJkXpQpmlANQjq4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.0.101] ([88.152.98.65]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mpl0r-1mVnVQ2Bm1-00pmmC; Wed, 19
 Jan 2022 22:51:49 +0100
Message-ID: <2d7fe1c0ddde50a1836b49dff8a02decdfcbe00d.camel@web.de>
Subject: amd-staging-drm-next breaks suspend
From: Bert Karwatzki <spasswolf@web.de>
To: amd-gfx@lists.freedesktop.org
Date: Wed, 19 Jan 2022 22:51:48 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Yi+SkCP8yqyUX93hgrFhGOoCUpCIm7NZRxPJ6Fdi9pzkc5WChqQ
 yinlkkb2h5V4TSyjRNRI1Dw6lZJcALWpaokNGxcQF64bxmMjDWVK7NTRlEc4Q5jZYbjBZfn
 3GEiYBn3kTHs1x/KKaSMiAjXgYznc0NiaWx94UxMcYHtULCL6qB9ZV2AEiN2JdAoXr1oAL4
 LStc1p7pl+xBIPQi9WiPg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4UdIkDqxsyo=:hEdpT9MiLH9OxZR/nUGxIK
 YltqSOww23tCouNdAZRmdXRJ+FxCKHXS3L+pJe2kkoLoEi9Ni0TdRwbMoRxUOMixkqIgeuidj
 n8OGD0zlJsbniyE0Z7oHm8dDDvdyS1Aj/GKd+n+Cekr6i6gLGU5OfM1Upm4Hr2Bn9jD2JJFDX
 erKjIv2V/UF51xolROwyICXUsogs0ReqqZIvfj3Jpp+W8GjHl5o95gIBN3sGmLFNOT1qEOfDv
 9OFlmPcTTqe36xxV/eUbf79mH/CkpMCYgM7o01CTTXBG1H4hVvPfa3uVFREXQrQrV957HnkF3
 0agYIBP1OLkranJ9ELKbRb2f4HZZlru9cJl036CYFSBGRb3L+HdgHXKsda0Nu2oryLnSJseo2
 F6Ogqh+usZS+X+Uhw2ptzcBvlBa1il8imZbLq//XR2Eg85KRZk/NRIPZOKjdqjjq0fuKArZhV
 xLJe/qNqH2qYb3psC1WVmHDaJpjdoUHnlpYBZK6B5gQ6EGygSxB7+ocW71XYhgtxzCwxpAW7S
 6eI7GsKWKG+vsl/pE/fPywqxcGco/PNE6uyqA3jVGhdhBbST9ykvOy8yIuo1Fqo3wCSlRTT2E
 xtNBF94FkiKkXbhC7XQPh+Cc5QVzE8Gg1pGh/vv1Ph13XrtKx8JoSd0F0qCYWtzNdsq7J++4h
 bF+Bg+Mu5ur+iyuVtCQMzPmhZUmm0uk5cWXt9WhUbCTBined71ZlUAhW1r+eRtZvwyY+T0xeP
 q1AWJvLvBKD0HiH+YrvhZ9Egww1qTOcalIgCE9lizTYA09+Xav0K0AtYcWtsDSWdrzyufPOAZ
 kJCLGUT2mLuHyNOlWalfthw8817UmxJ9ezeRw3ZlvfpArgo5hA4bVzbeIiecmglEkhsUGZCtY
 GOttybE6sJmA3Ewgh+NkC0uD2GZ6a+zeKuod7TyuomyBlPTLk6EtnNJVB+fL32eC7W1qnV9qr
 SEAk/XeDDtfV+MLubbrGZuBpFnVZpr6NwBBO7ZghvxmlW7XSWpPBHA33RA2QkEEeN3tEe/t3S
 gEFoJB91GNmWI56zadXGjO0bJ7ngxL6n8nkmWMIqVak4r77cj0mpcsU81LJnEds4DU5ZFOO2K
 vE4RoY4xVOZA0k=
X-Mailman-Approved-At: Wed, 19 Jan 2022 22:07:12 +0000
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
Cc: Chris Hixon <linux-kernel-bugs@hixontech.com>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, Scott Bruce <smbruce@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>,
 Kazlauskas Nicholas <Nicholas.Kazlauskas@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I just tested drm-staging-drm-next with HEAD
f1b2924ee6929cb431440e6f961f06eb65d52beb:
Going into suspend leads to a hang again:
This is probably caused by
[ 1.310551] trying to bind memory to uninitialized GART !
and/or
[ 3.976438] trying to bind memory to uninitialized GART !


Here's the complete dmesg:
[ 0.000000] Linux version 5.13.0+ (bert@lisa) (gcc (Debian 11.2.0-14)
11.2.0, GNU ld (GNU Binutils for Debian) 2.37.50.20220106) #4 SMP Wed
Jan 19 22:19:19 CET 2022
[ 0.000000] Command line: BOOT_IMAGE=3D/boot/vmlinuz-5.13.0+
root=3DUUID=3D78dcbf14-902d-49c0-9d4d-b7ad84550d9a ro
mt7921e.disable_aspm=3D1 quiet
[ 0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating
point registers'
[ 0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[ 0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[ 0.000000] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys
User registers'
[ 0.000000] x86/fpu: xstate_offset[2]: 576, xstate_sizes[2]: 256
[ 0.000000] x86/fpu: xstate_offset[9]: 832, xstate_sizes[9]: 8
[ 0.000000] x86/fpu: Enabled xstate features 0x207, context size is 840
bytes, using 'compacted' format.
[ 0.000000] BIOS-provided physical RAM map:
[ 0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff]
usable
[ 0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff]
reserved
[ 0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000009bfefff]
usable
[ 0.000000] BIOS-e820: [mem 0x0000000009bff000-0x000000000a000fff]
reserved
[ 0.000000] BIOS-e820: [mem 0x000000000a001000-0x000000000a1fffff]
usable
[ 0.000000] BIOS-e820: [mem 0x000000000a200000-0x000000000a20efff] ACPI
NVS
[ 0.000000] BIOS-e820: [mem 0x000000000a20f000-0x00000000e9e1ffff]
usable
[ 0.000000] BIOS-e820: [mem 0x00000000e9e20000-0x00000000eb33efff]
reserved
[ 0.000000] BIOS-e820: [mem 0x00000000eb33f000-0x00000000eb39efff] ACPI
data
[ 0.000000] BIOS-e820: [mem 0x00000000eb39f000-0x00000000eb556fff] ACPI
NVS
[ 0.000000] BIOS-e820: [mem 0x00000000eb557000-0x00000000ed17cfff]
reserved
[ 0.000000] BIOS-e820: [mem 0x00000000ed17d000-0x00000000ed1fefff] type
20
[ 0.000000] BIOS-e820: [mem 0x00000000ed1ff000-0x00000000edffffff]
usable
[ 0.000000] BIOS-e820: [mem 0x00000000ee000000-0x00000000f7ffffff]
reserved
[ 0.000000] BIOS-e820: [mem 0x00000000fd000000-0x00000000fdffffff]
reserved
[ 0.000000] BIOS-e820: [mem 0x00000000feb80000-0x00000000fec01fff]
reserved
[ 0.000000] BIOS-e820: [mem 0x00000000fec10000-0x00000000fec10fff]
reserved
[ 0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff]
reserved
[ 0.000000] BIOS-e820: [mem 0x00000000fed40000-0x00000000fed44fff]
reserved
[ 0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed8ffff]
reserved
[ 0.000000] BIOS-e820: [mem 0x00000000fedc4000-0x00000000fedc9fff]
reserved
[ 0.000000] BIOS-e820: [mem 0x00000000fedcc000-0x00000000fedcefff]
reserved
[ 0.000000] BIOS-e820: [mem 0x00000000fedd5000-0x00000000fedd5fff]
reserved
[ 0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff]
reserved
[ 0.000000] BIOS-e820: [mem 0x0000000100000000-0x00000003ee2fffff]
usable
[ 0.000000] BIOS-e820: [mem 0x00000003ee300000-0x000000040fffffff]
reserved
[ 0.000000] NX (Execute Disable) protection: active
[ 0.000000] efi: EFI v2.70 by American Megatrends
[ 0.000000] efi: ACPI=3D0xeb540000 ACPI 2.0=3D0xeb540014
TPMFinalLog=3D0xeb50c000 SMBIOS=3D0xed020000 SMBIOS 3.0=3D0xed01f000
MEMATTR=3D0xe6fa3018 ESRT=3D0xe87cb918 MOKvar=3D0xe6fa0000
[ 0.000000] SMBIOS 3.3.0 present.
[ 0.000000] DMI: Micro-Star International Co., Ltd. Alpha 15 B5EEK/MS-
158L, BIOS E158LAMS.107 11/10/2021
[ 0.000000] tsc: Fast TSC calibration using PIT
[ 0.000000] tsc: Detected 3194.034 MHz processor
[ 0.000125] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D>
reserved
[ 0.000126] e820: remove [mem 0x000a0000-0x000fffff] usable
[ 0.000131] last_pfn =3D 0x3ee300 max_arch_pfn =3D 0x400000000
[ 0.000363] x86/PAT: Configuration [0-7]: WB WC UC- UC WB WP UC- WT
[ 0.000577] e820: update [mem 0xf0000000-0xffffffff] usable =3D=3D>
reserved
[ 0.000582] last_pfn =3D 0xee000 max_arch_pfn =3D 0x400000000
[ 0.003213] esrt: Reserving ESRT space from 0x00000000e87cb918 to
0x00000000e87cb950.
[ 0.003217] e820: update [mem 0xe87cb000-0xe87cbfff] usable =3D=3D>
reserved
[ 0.003225] e820: update [mem 0xe6fa0000-0xe6fa2fff] usable =3D=3D>
reserved
[ 0.003235] Using GB pages for direct mapping
[ 0.003498] Secure boot disabled
[ 0.003499] RAMDISK: [mem 0x2efa5000-0x337c9fff]
[ 0.003502] ACPI: Early table checksum verification disabled
[ 0.003504] ACPI: RSDP 0x00000000EB540014 000024 (v02 MSI_NB)
[ 0.003507] ACPI: XSDT 0x00000000EB53F728 000114 (v01 MSI_NB MEGABOOK
01072009 AMI 01000013)
[ 0.003510] ACPI: FACP 0x00000000EB390000 000114 (v06 MSI_NB MEGABOOK
01072009 AMI 00010013)
[ 0.003513] ACPI: DSDT 0x00000000EB383000 00C50C (v02 MSI_NB MEGABOOK
01072009 INTL 20190509)
[ 0.003515] ACPI: FACS 0x00000000EB50A000 000040
[ 0.003516] ACPI: SLIC 0x00000000EB39E000 000176 (v01 MSI_NB MEGABOOK
01072009 AMI 01000013)
[ 0.003518] ACPI: SSDT 0x00000000EB396000 0072B0 (v02 AMD AmdTable
00000002 MSFT 04000000)
[ 0.003519] ACPI: IVRS 0x00000000EB395000 0001A4 (v02 AMD AmdTable
00000001 AMD 00000000)
[ 0.003521] ACPI: SSDT 0x00000000EB391000 003A21 (v01 AMD AMD AOD
00000001 INTL 20190509)
[ 0.003522] ACPI: FIDT 0x00000000EB382000 00009C (v01 MSI_NB MEGABOOK
01072009 AMI 00010013)
[ 0.003524] ACPI: ECDT 0x00000000EB381000 0000C1 (v01 MSI_NB MEGABOOK
01072009 AMI. 00010013)
[ 0.003525] ACPI: MCFG 0x00000000EB380000 00003C (v01 MSI_NB MEGABOOK
01072009 MSFT 00010013)
[ 0.003526] ACPI: HPET 0x00000000EB37F000 000038 (v01 MSI_NB MEGABOOK
01072009 AMI 00000005)
[ 0.003528] ACPI: VFCT 0x00000000EB371000 00D884 (v01 MSI_NB MEGABOOK
00000001 AMD 31504F47)
[ 0.003529] ACPI: BGRT 0x00000000EB370000 000038 (v01 MSI_NB MEGABOOK
01072009 AMI 00010013)
[ 0.003530] ACPI: TPM2 0x00000000EB36F000 00004C (v04 MSI_NB MEGABOOK
00000001 AMI 00000000)
[ 0.003532] ACPI: SSDT 0x00000000EB369000 005354 (v02 AMD AmdTable
00000001 AMD 00000001)
[ 0.003533] ACPI: CRAT 0x00000000EB368000 000EE8 (v01 AMD AmdTable
00000001 AMD 00000001)
[ 0.003535] ACPI: CDIT 0x00000000EB367000 000029 (v01 AMD AmdTable
00000001 AMD 00000001)
[ 0.003536] ACPI: SSDT 0x00000000EB366000 000149 (v01 AMD AmdTable
00000001 INTL 20190509)
[ 0.003537] ACPI: SSDT 0x00000000EB364000 00148E (v01 AMD AmdTable
00000001 INTL 20190509)
[ 0.003539] ACPI: SSDT 0x00000000EB362000 00153F (v01 AMD AmdTable
00000001 INTL 20190509)
[ 0.003540] ACPI: SSDT 0x00000000EB361000 000696 (v01 AMD AmdTable
00000001 INTL 20190509)
[ 0.003542] ACPI: SSDT 0x00000000EB35F000 001A56 (v01 AMD AmdTable
00000001 INTL 20190509)
[ 0.003543] ACPI: SSDT 0x00000000EB35E000 0005DE (v01 AMD AmdTable
00000001 INTL 20190509)
[ 0.003544] ACPI: SSDT 0x00000000EB35A000 0036E9 (v01 AMD AmdTable
00000001 INTL 20190509)
[ 0.003546] ACPI: WSMT 0x00000000EB359000 000028 (v01 MSI_NB MEGABOOK
01072009 AMI 00010013)
[ 0.003547] ACPI: APIC 0x00000000EB358000 0000DE (v03 MSI_NB MEGABOOK
01072009 AMI 00010013)
[ 0.003548] ACPI: SSDT 0x00000000EB357000 00008D (v01 AMD AmdTable
00000001 INTL 20190509)
[ 0.003550] ACPI: SSDT 0x00000000EB356000 0008A8 (v01 AMD AmdTable
00000001 INTL 20190509)
[ 0.003551] ACPI: SSDT 0x00000000EB355000 0001B7 (v01 AMD AmdTable
00000001 INTL 20190509)
[ 0.003552] ACPI: SSDT 0x00000000EB354000 0007B1 (v01 AMD AmdTable
00000001 INTL 20190509)
[ 0.003554] ACPI: SSDT 0x00000000EB353000 00097D (v01 AMD AmdTable
00000001 INTL 20190509)
[ 0.003555] ACPI: FPDT 0x00000000EB352000 000044 (v01 MSI_NB A M I
01072009 AMI 01000013)
[ 0.003556] ACPI: Reserving FACP table memory at [mem 0xeb390000-
0xeb390113]
[ 0.003557] ACPI: Reserving DSDT table memory at [mem 0xeb383000-
0xeb38f50b]
[ 0.003558] ACPI: Reserving FACS table memory at [mem 0xeb50a000-
0xeb50a03f]
[ 0.003558] ACPI: Reserving SLIC table memory at [mem 0xeb39e000-
0xeb39e175]
[ 0.003559] ACPI: Reserving SSDT table memory at [mem 0xeb396000-
0xeb39d2af]
[ 0.003559] ACPI: Reserving IVRS table memory at [mem 0xeb395000-
0xeb3951a3]
[ 0.003560] ACPI: Reserving SSDT table memory at [mem 0xeb391000-
0xeb394a20]
[ 0.003560] ACPI: Reserving FIDT table memory at [mem 0xeb382000-
0xeb38209b]
[ 0.003560] ACPI: Reserving ECDT table memory at [mem 0xeb381000-
0xeb3810c0]
[ 0.003561] ACPI: Reserving MCFG table memory at [mem 0xeb380000-
0xeb38003b]
[ 0.003561] ACPI: Reserving HPET table memory at [mem 0xeb37f000-
0xeb37f037]
[ 0.003562] ACPI: Reserving VFCT table memory at [mem 0xeb371000-
0xeb37e883]
[ 0.003562] ACPI: Reserving BGRT table memory at [mem 0xeb370000-
0xeb370037]
[ 0.003563] ACPI: Reserving TPM2 table memory at [mem 0xeb36f000-
0xeb36f04b]
[ 0.003563] ACPI: Reserving SSDT table memory at [mem 0xeb369000-
0xeb36e353]
[ 0.003564] ACPI: Reserving CRAT table memory at [mem 0xeb368000-
0xeb368ee7]
[ 0.003564] ACPI: Reserving CDIT table memory at [mem 0xeb367000-
0xeb367028]
[ 0.003565] ACPI: Reserving SSDT table memory at [mem 0xeb366000-
0xeb366148]
[ 0.003565] ACPI: Reserving SSDT table memory at [mem 0xeb364000-
0xeb36548d]
[ 0.003566] ACPI: Reserving SSDT table memory at [mem 0xeb362000-
0xeb36353e]
[ 0.003566] ACPI: Reserving SSDT table memory at [mem 0xeb361000-
0xeb361695]
[ 0.003567] ACPI: Reserving SSDT table memory at [mem 0xeb35f000-
0xeb360a55]
[ 0.003567] ACPI: Reserving SSDT table memory at [mem 0xeb35e000-
0xeb35e5dd]
[ 0.003568] ACPI: Reserving SSDT table memory at [mem 0xeb35a000-
0xeb35d6e8]
[ 0.003568] ACPI: Reserving WSMT table memory at [mem 0xeb359000-
0xeb359027]
[ 0.003569] ACPI: Reserving APIC table memory at [mem 0xeb358000-
0xeb3580dd]
[ 0.003569] ACPI: Reserving SSDT table memory at [mem 0xeb357000-
0xeb35708c]
[ 0.003570] ACPI: Reserving SSDT table memory at [mem 0xeb356000-
0xeb3568a7]
[ 0.003570] ACPI: Reserving SSDT table memory at [mem 0xeb355000-
0xeb3551b6]
[ 0.003571] ACPI: Reserving SSDT table memory at [mem 0xeb354000-
0xeb3547b0]
[ 0.003571] ACPI: Reserving SSDT table memory at [mem 0xeb353000-
0xeb35397c]
[ 0.003572] ACPI: Reserving FPDT table memory at [mem 0xeb352000-
0xeb352043]
[ 0.003582] ACPI: Local APIC address 0xfee00000
[ 0.003625] No NUMA configuration found
[ 0.003625] Faking a node at [mem 0x0000000000000000-
0x00000003ee2fffff]
[ 0.003630] NODE_DATA(0) allocated [mem 0x3ee2d6000-0x3ee2fffff]
[ 0.003795] Zone ranges:
[ 0.003796] DMA [mem 0x0000000000001000-0x0000000000ffffff]
[ 0.003797] DMA32 [mem 0x0000000001000000-0x00000000ffffffff]
[ 0.003798] Normal [mem 0x0000000100000000-0x00000003ee2fffff]
[ 0.003798] Device empty
[ 0.003799] Movable zone start for each node
[ 0.003800] Early memory node ranges
[ 0.003800] node 0: [mem 0x0000000000001000-0x000000000009ffff]
[ 0.003801] node 0: [mem 0x0000000000100000-0x0000000009bfefff]
[ 0.003802] node 0: [mem 0x000000000a001000-0x000000000a1fffff]
[ 0.003802] node 0: [mem 0x000000000a20f000-0x00000000e9e1ffff]
[ 0.003803] node 0: [mem 0x00000000ed1ff000-0x00000000edffffff]
[ 0.003803] node 0: [mem 0x0000000100000000-0x00000003ee2fffff]
[ 0.003805] Initmem setup node 0 [mem 0x0000000000001000-
0x00000003ee2fffff]
[ 0.003806] On node 0 totalpages: 4033199
[ 0.003807] DMA zone: 64 pages used for memmap
[ 0.003807] DMA zone: 159 pages reserved
[ 0.003808] DMA zone: 3999 pages, LIFO batch:0
[ 0.003928] DMA zone: 28769 pages in unavailable ranges
[ 0.003929] DMA32 zone: 14945 pages used for memmap
[ 0.003929] DMA32 zone: 956432 pages, LIFO batch:63
[ 0.008424] DMA32 zone: 22512 pages in unavailable ranges
[ 0.008427] Normal zone: 48012 pages used for memmap
[ 0.008428] Normal zone: 3072768 pages, LIFO batch:63
[ 0.008626] Normal zone: 7424 pages in unavailable ranges
[ 0.014725] ACPI: PM-Timer IO Port: 0x808
[ 0.014726] ACPI: Local APIC address 0xfee00000
[ 0.014730] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[ 0.014742] IOAPIC[0]: apic_id 33, version 33, address 0xfec00000, GSI
0-23
[ 0.014746] IOAPIC[1]: apic_id 34, version 33, address 0xfec01000, GSI
24-55
[ 0.014747] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[ 0.014748] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[ 0.014749] ACPI: IRQ0 used by override.
[ 0.014750] ACPI: IRQ9 used by override.
[ 0.014751] Using ACPI (MADT) for SMP configuration information
[ 0.014752] ACPI: HPET id: 0x10228201 base: 0xfed00000
[ 0.014758] e820: update [mem 0xe62ee000-0xe63e1fff] usable =3D=3D>
reserved
[ 0.014766] smpboot: Allowing 16 CPUs, 0 hotplug CPUs
[ 0.014783] PM: hibernation: Registered nosave memory: [mem 0x00000000-
0x00000fff]
[ 0.014784] PM: hibernation: Registered nosave memory: [mem 0x000a0000-
0x000fffff]
[ 0.014785] PM: hibernation: Registered nosave memory: [mem 0x09bff000-
0x0a000fff]
[ 0.014786] PM: hibernation: Registered nosave memory: [mem 0x0a200000-
0x0a20efff]
[ 0.014787] PM: hibernation: Registered nosave memory: [mem 0xe62ee000-
0xe63e1fff]
[ 0.014788] PM: hibernation: Registered nosave memory: [mem 0xe6fa0000-
0xe6fa2fff]
[ 0.014789] PM: hibernation: Registered nosave memory: [mem 0xe87cb000-
0xe87cbfff]
[ 0.014790] PM: hibernation: Registered nosave memory: [mem 0xe9e20000-
0xeb33efff]
[ 0.014790] PM: hibernation: Registered nosave memory: [mem 0xeb33f000-
0xeb39efff]
[ 0.014791] PM: hibernation: Registered nosave memory: [mem 0xeb39f000-
0xeb556fff]
[ 0.014791] PM: hibernation: Registered nosave memory: [mem 0xeb557000-
0xed17cfff]
[ 0.014791] PM: hibernation: Registered nosave memory: [mem 0xed17d000-
0xed1fefff]
[ 0.014792] PM: hibernation: Registered nosave memory: [mem 0xee000000-
0xf7ffffff]
[ 0.014793] PM: hibernation: Registered nosave memory: [mem 0xf8000000-
0xfcffffff]
[ 0.014793] PM: hibernation: Registered nosave memory: [mem 0xfd000000-
0xfdffffff]
[ 0.014793] PM: hibernation: Registered nosave memory: [mem 0xfe000000-
0xfeb7ffff]
[ 0.014794] PM: hibernation: Registered nosave memory: [mem 0xfeb80000-
0xfec01fff]
[ 0.014794] PM: hibernation: Registered nosave memory: [mem 0xfec02000-
0xfec0ffff]
[ 0.014794] PM: hibernation: Registered nosave memory: [mem 0xfec10000-
0xfec10fff]
[ 0.014795] PM: hibernation: Registered nosave memory: [mem 0xfec11000-
0xfecfffff]
[ 0.014795] PM: hibernation: Registered nosave memory: [mem 0xfed00000-
0xfed00fff]
[ 0.014795] PM: hibernation: Registered nosave memory: [mem 0xfed01000-
0xfed3ffff]
[ 0.014796] PM: hibernation: Registered nosave memory: [mem 0xfed40000-
0xfed44fff]
[ 0.014796] PM: hibernation: Registered nosave memory: [mem 0xfed45000-
0xfed7ffff]
[ 0.014796] PM: hibernation: Registered nosave memory: [mem 0xfed80000-
0xfed8ffff]
[ 0.014797] PM: hibernation: Registered nosave memory: [mem 0xfed90000-
0xfedc3fff]
[ 0.014797] PM: hibernation: Registered nosave memory: [mem 0xfedc4000-
0xfedc9fff]
[ 0.014797] PM: hibernation: Registered nosave memory: [mem 0xfedca000-
0xfedcbfff]
[ 0.014798] PM: hibernation: Registered nosave memory: [mem 0xfedcc000-
0xfedcefff]
[ 0.014798] PM: hibernation: Registered nosave memory: [mem 0xfedcf000-
0xfedd4fff]
[ 0.014799] PM: hibernation: Registered nosave memory: [mem 0xfedd5000-
0xfedd5fff]
[ 0.014799] PM: hibernation: Registered nosave memory: [mem 0xfedd6000-
0xfeffffff]
[ 0.014799] PM: hibernation: Registered nosave memory: [mem 0xff000000-
0xffffffff]
[ 0.014800] [mem 0xf8000000-0xfcffffff] available for PCI devices
[ 0.014801] Booting paravirtualized kernel on bare hardware
[ 0.014803] clocksource: refined-jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 7645519600211568 ns
[ 0.017070] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:16 nr_cpu_ids:16
nr_node_ids:1
[ 0.017388] percpu: Embedded 56 pages/cpu s192512 r8192 d28672 u262144
[ 0.017393] pcpu-alloc: s192512 r8192 d28672 u262144 alloc=3D1*2097152
[ 0.017394] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 12
13 14 15
[ 0.017416] Built 1 zonelists, mobility grouping on. Total pages:
3970019
[ 0.017417] Policy zone: Normal
[ 0.017417] Kernel command line: BOOT_IMAGE=3D/boot/vmlinuz-5.13.0+
root=3DUUID=3D78dcbf14-902d-49c0-9d4d-b7ad84550d9a ro
mt7921e.disable_aspm=3D1 quiet
[ 0.017801] Dentry cache hash table entries: 2097152 (order: 12,
16777216 bytes, linear)
[ 0.017980] Inode-cache hash table entries: 1048576 (order: 11, 8388608
bytes, linear)
[ 0.018008] mem auto-init: stack:off, heap alloc:on, heap free:off
[ 0.025783] Memory: 3716024K/16132796K available (12295K kernel code,
2667K rwdata, 8232K rodata, 2620K init, 5288K bss, 539660K reserved, 0K
cma-reserved)
[ 0.025788] random: get_random_u64 called from
__kmem_cache_create+0x2a/0x570 with crng_init=3D0
[ 0.025850] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D16, No=
des=3D1
[ 0.025858] ftrace: allocating 37432 entries in 147 pages
[ 0.035300] ftrace: allocated 147 pages with 4 groups
[ 0.035377] rcu: Hierarchical RCU implementation.
[ 0.035378] rcu: RCU restricting CPUs from NR_CPUS=3D8192 to
nr_cpu_ids=3D16.
[ 0.035380] Rude variant of Tasks RCU enabled.
[ 0.035380] Tracing variant of Tasks RCU enabled.
[ 0.035380] rcu: RCU calculated value of scheduler-enlistment delay is
25 jiffies.
[ 0.035381] rcu: Adjusting geometry for rcu_fanout_leaf=3D16,
nr_cpu_ids=3D16
[ 0.037479] NR_IRQS: 524544, nr_irqs: 1096, preallocated irqs: 16
[ 0.037742] random: crng done (trusting CPU's manufacturer)
[ 0.037758] Console: colour dummy device 80x25
[ 0.037766] printk: console [tty0] enabled
[ 0.037774] ACPI: Core revision 20210331
[ 0.037905] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff,
max_idle_ns: 133484873504 ns
[ 0.037920] APIC: Switch to symmetric I/O mode setup
[ 0.038454] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR0, rdevid:160
[ 0.038455] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR1, rdevid:160
[ 0.038455] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR2, rdevid:160
[ 0.038456] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR3, rdevid:160
[ 0.038693] x2apic enabled
[ 0.038697] Switched APIC routing to cluster x2apic.
[ 0.039293] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D-1
[ 0.057928] clocksource: tsc-early: mask: 0xffffffffffffffff
max_cycles: 0x2e0a45ee145, max_idle_ns: 440795207223 ns
[ 0.057931] Calibrating delay loop (skipped), value calculated using
timer frequency.. 6388.06 BogoMIPS (lpj=3D12776136)
[ 0.057933] pid_max: default: 32768 minimum: 301
[ 0.059203] LSM: Security Framework initializing
[ 0.059214] Yama: becoming mindful.
[ 0.059232] AppArmor: AppArmor initialized
[ 0.059233] TOMOYO Linux initialized
[ 0.059273] Mount-cache hash table entries: 32768 (order: 6, 262144
bytes, linear)
[ 0.059305] Mountpoint-cache hash table entries: 32768 (order: 6,
262144 bytes, linear)
[ 0.059473] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[ 0.059503] LVT offset 1 assigned for vector 0xf9
[ 0.059611] LVT offset 2 assigned for vector 0xf4
[ 0.059636] Last level iTLB entries: 4KB 512, 2MB 512, 4MB 256
[ 0.059637] Last level dTLB entries: 4KB 2048, 2MB 2048, 4MB 1024, 1GB
0
[ 0.059639] Spectre V1 : Mitigation: usercopy/swapgs barriers and
__user pointer sanitization
[ 0.059641] Spectre V2 : Mitigation: Full AMD retpoline
[ 0.059641] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling
RSB on context switch
[ 0.059642] Spectre V2 : Enabling Restricted Speculation for firmware
calls
[ 0.059643] Spectre V2 : mitigation: Enabling conditional Indirect
Branch Prediction Barrier
[ 0.059644] Spectre V2 : User space: Mitigation: STIBP always-on
protection
[ 0.059645] Speculative Store Bypass: Mitigation: Speculative Store
Bypass disabled via prctl and seccomp
[ 0.063183] Freeing SMP alternatives memory: 32K
[ 0.171688] smpboot: CPU0: AMD Ryzen 7 5800H with Radeon Graphics
(family: 0x19, model: 0x50, stepping: 0x0)
[ 0.171808] Performance Events: Fam17h+ core perfctr, AMD PMU driver.
[ 0.171812] ... version: 0
[ 0.171812] ... bit width: 48
[ 0.171813] ... generic registers: 6
[ 0.171813] ... value mask: 0000ffffffffffff
[ 0.171814] ... max period: 00007fffffffffff
[ 0.171814] ... fixed-purpose events: 0
[ 0.171814] ... event mask: 000000000000003f
[ 0.171854] rcu: Hierarchical SRCU implementation.
[ 0.172097] NMI watchdog: Enabled. Permanently consumes one hw-PMU
counter.
[ 0.172203] smp: Bringing up secondary CPUs ...
[ 0.172258] x86: Booting SMP configuration:
[ 0.172259] .... node #0, CPUs: #1
[ 0.173929] Spectre V2 : Update user space SMT mitigation: STIBP
always-on
[ 0.173929] #2 #3 #4 #5 #6 #7 #8 #9 #10 #11 #12 #13 #14 #15
[ 0.204072] smp: Brought up 1 node, 16 CPUs
[ 0.204072] smpboot: Max logical packages: 1
[ 0.204072] smpboot: Total of 16 processors activated (102209.08
BogoMIPS)
[ 0.218608] node 0 deferred pages initialised in 16ms
[ 0.218608] devtmpfs: initialized
[ 0.218608] x86/mm: Memory block size: 128MB
[ 0.218706] PM: Registering ACPI NVS region [mem 0x0a200000-0x0a20efff]
(61440 bytes)
[ 0.218706] PM: Registering ACPI NVS region [mem 0xeb39f000-0xeb556fff]
(1802240 bytes)
[ 0.218706] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 7645041785100000 ns
[ 0.218706] futex hash table entries: 4096 (order: 6, 262144 bytes,
linear)
[ 0.218706] pinctrl core: initialized pinctrl subsystem
[ 0.218706] NET: Registered protocol family 16
[ 0.218706] DMA: preallocated 2048 KiB GFP_KERNEL pool for atomic
allocations
[ 0.218706] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA pool for
atomic allocations
[ 0.218731] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA32 pool for
atomic allocations
[ 0.218738] audit: initializing netlink subsys (disabled)
[ 0.218745] audit: type=3D2000 audit(1642627605.180:1): state=3Dinitialize=
d
audit_enabled=3D0 res=3D1
[ 0.218745] thermal_sys: Registered thermal governor 'fair_share'
[ 0.218745] thermal_sys: Registered thermal governor 'bang_bang'
[ 0.218745] thermal_sys: Registered thermal governor 'step_wise'
[ 0.218745] thermal_sys: Registered thermal governor 'user_space'
[ 0.218745] thermal_sys: Registered thermal governor 'power_allocator'
[ 0.218745] cpuidle: using governor ladder
[ 0.218745] cpuidle: using governor menu
[ 0.218745] ACPI: bus type PCI registered
[ 0.218745] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[ 0.218745] PCI: MMCONFIG for domain 0000 [bus 00-7f] at [mem
0xf0000000-0xf7ffffff] (base 0xf0000000)
[ 0.218745] PCI: MMCONFIG at [mem 0xf0000000-0xf7ffffff] reserved in
E820
[ 0.218745] PCI: Using configuration type 1 for base access
[ 0.218745] Kprobes globally optimized
[ 0.221949] HugeTLB registered 1.00 GiB page size, pre-allocated 0
pages
[ 0.221949] HugeTLB registered 2.00 MiB page size, pre-allocated 0
pages
[ 0.286206] ACPI: Added _OSI(Module Device)
[ 0.286206] ACPI: Added _OSI(Processor Device)
[ 0.286206] ACPI: Added _OSI(3.0 _SCP Extensions)
[ 0.286206] ACPI: Added _OSI(Processor Aggregator Device)
[ 0.286206] ACPI: Added _OSI(Linux-Dell-Video)
[ 0.286206] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[ 0.286206] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[ 0.294612] ACPI: 16 ACPI AML tables successfully acquired and loaded
[ 0.295064] ACPI: EC: EC started
[ 0.295064] ACPI: EC: interrupt blocked
[ 0.296201] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[ 0.296202] ACPI: EC: Boot ECDT EC used to handle transactions
[ 0.296511] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[ 0.297426] ACPI: Interpreter enabled
[ 0.297435] ACPI: (supports S0 S4 S5)
[ 0.297436] ACPI: Using IOAPIC for interrupt routing
[ 0.297559] PCI: Using host bridge windows from ACPI; if necessary, use
"pci=3Dnocrs" and report a bug
[ 0.297796] ACPI: Enabled 1 GPEs in block 00 to 1F
[ 0.298044] ACPI: PM: Power Resource [M237] (on)
[ 0.298119] ACPI: PM: Power Resource [M237] (on)
[ 0.298158] ACPI: PM: Power Resource [M237] (on)
[ 0.298551] ACPI: PM: Power Resource [P0U0] (on)
[ 0.298562] ACPI: PM: Power Resource [P3U0] (off)
[ 0.298675] ACPI: PM: Power Resource [P0U1] (on)
[ 0.298685] ACPI: PM: Power Resource [P3U1] (off)
[ 0.299182] ACPI: PM: Power Resource [P0NV] (on)
[ 0.299274] ACPI: PM: Power Resource [P0NX] (on)
[ 0.301752] ACPI: PM: Power Resource [PRWB] (on)
[ 0.302437] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[ 0.302441] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM
ClockPM Segments MSI HPX-Type3]
[ 0.302512] acpi PNP0A08:00: _OSC: platform does not support
[SHPCHotplug LTR]
[ 0.302577] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER
PCIeCapability]
[ 0.302584] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000
[bus 00-7f] only partially covers this bridge
[ 0.302741] PCI host bridge to bus 0000:00
[ 0.302741] pci_bus 0000:00: root bus resource [io 0x0000-0x03af
window]
[ 0.302743] pci_bus 0000:00: root bus resource [io 0x03e0-0x0cf7
window]
[ 0.302743] pci_bus 0000:00: root bus resource [io 0x03b0-0x03df
window]
[ 0.302744] pci_bus 0000:00: root bus resource [io 0x0d00-0xffff
window]
[ 0.302744] pci_bus 0000:00: root bus resource [mem 0x000a0000-
0x000bffff window]
[ 0.302745] pci_bus 0000:00: root bus resource [mem 0x000c0000-
0x000dffff window]
[ 0.302745] pci_bus 0000:00: root bus resource [mem 0xf0000000-
0xfcffffff window]
[ 0.302746] pci_bus 0000:00: root bus resource [mem 0x410000000-
0xffffffffff window]
[ 0.302747] pci_bus 0000:00: root bus resource [bus 00-ff]
[ 0.302755] pci 0000:00:00.0: [1022:1630] type 00 class 0x060000
[ 0.302827] pci 0000:00:00.2: [1022:1631] type 00 class 0x080600
[ 0.302903] pci 0000:00:01.0: [1022:1632] type 00 class 0x060000
[ 0.302959] pci 0000:00:01.1: [1022:1633] type 01 class 0x060400
[ 0.303017] pci 0000:00:01.1: PME# supported from D0 D3hot D3cold
[ 0.303075] pci 0000:00:02.0: [1022:1632] type 00 class 0x060000
[ 0.303132] pci 0000:00:02.1: [1022:1634] type 01 class 0x060400
[ 0.303178] pci 0000:00:02.1: PME# supported from D0 D3hot D3cold
[ 0.303235] pci 0000:00:02.2: [1022:1634] type 01 class 0x060400
[ 0.303255] pci 0000:00:02.2: enabling Extended Tags
[ 0.303283] pci 0000:00:02.2: PME# supported from D0 D3hot D3cold
[ 0.303339] pci 0000:00:02.3: [1022:1634] type 01 class 0x060400
[ 0.303358] pci 0000:00:02.3: enabling Extended Tags
[ 0.303386] pci 0000:00:02.3: PME# supported from D0 D3hot D3cold
[ 0.303440] pci 0000:00:02.4: [1022:1634] type 01 class 0x060400
[ 0.303487] pci 0000:00:02.4: PME# supported from D0 D3hot D3cold
[ 0.303551] pci 0000:00:08.0: [1022:1632] type 00 class 0x060000
[ 0.303609] pci 0000:00:08.1: [1022:1635] type 01 class 0x060400
[ 0.303627] pci 0000:00:08.1: enabling Extended Tags
[ 0.303654] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
[ 0.303738] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500
[ 0.303842] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100
[ 0.303950] pci 0000:00:18.0: [1022:166a] type 00 class 0x060000
[ 0.303985] pci 0000:00:18.1: [1022:166b] type 00 class 0x060000
[ 0.304020] pci 0000:00:18.2: [1022:166c] type 00 class 0x060000
[ 0.304055] pci 0000:00:18.3: [1022:166d] type 00 class 0x060000
[ 0.304091] pci 0000:00:18.4: [1022:166e] type 00 class 0x060000
[ 0.304126] pci 0000:00:18.5: [1022:166f] type 00 class 0x060000
[ 0.304162] pci 0000:00:18.6: [1022:1670] type 00 class 0x060000
[ 0.304196] pci 0000:00:18.7: [1022:1671] type 00 class 0x060000
[ 0.304288] pci 0000:01:00.0: [1002:1478] type 01 class 0x060400
[ 0.304300] pci 0000:01:00.0: reg 0x10: [mem 0xfcc00000-0xfcc03fff]
[ 0.304387] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[ 0.304448] pci 0000:01:00.0: 63.008 Gb/s available PCIe bandwidth,
limited by 8.0 GT/s PCIe x8 link at 0000:00:01.1 (capable of 126.024
Gb/s with 16.0 GT/s PCIe x8 link)
[ 0.304490] pci 0000:00:01.1: PCI bridge to [bus 01-03]
[ 0.304494] pci 0000:00:01.1: bridge window [mem 0xfca00000-0xfccfffff]
[ 0.304496] pci 0000:00:01.1: bridge window [mem 0xfc00000000-
0xfe0fffffff 64bit pref]
[ 0.304545] pci 0000:02:00.0: [1002:1479] type 01 class 0x060400
[ 0.304641] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[ 0.304831] pci 0000:01:00.0: PCI bridge to [bus 02-03]
[ 0.304837] pci 0000:01:00.0: bridge window [mem 0xfca00000-0xfcbfffff]
[ 0.304841] pci 0000:01:00.0: bridge window [mem 0xfc00000000-
0xfe0fffffff 64bit pref]
[ 0.304894] pci 0000:03:00.0: [1002:73ff] type 00 class 0x038000
[ 0.304908] pci 0000:03:00.0: reg 0x10: [mem 0xfc00000000-0xfdffffffff
64bit pref]
[ 0.304916] pci 0000:03:00.0: reg 0x18: [mem 0xfe00000000-0xfe0fffffff
64bit pref]
[ 0.304925] pci 0000:03:00.0: reg 0x24: [mem 0xfca00000-0xfcafffff]
[ 0.304930] pci 0000:03:00.0: reg 0x30: [mem 0xfcb00000-0xfcb1ffff
pref]
[ 0.305004] pci 0000:03:00.0: PME# supported from D1 D2 D3hot D3cold
[ 0.305070] pci 0000:03:00.0: 63.008 Gb/s available PCIe bandwidth,
limited by 8.0 GT/s PCIe x8 link at 0000:00:01.1 (capable of 252.048
Gb/s with 16.0 GT/s PCIe x16 link)
[ 0.305111] pci 0000:03:00.1: [1002:ab28] type 00 class 0x040300
[ 0.305121] pci 0000:03:00.1: reg 0x10: [mem 0xfcb20000-0xfcb23fff]
[ 0.305195] pci 0000:03:00.1: PME# supported from D1 D2 D3hot D3cold
[ 0.305272] pci 0000:02:00.0: PCI bridge to [bus 03]
[ 0.305277] pci 0000:02:00.0: bridge window [mem 0xfca00000-0xfcbfffff]
[ 0.305281] pci 0000:02:00.0: bridge window [mem 0xfc00000000-
0xfe0fffffff 64bit pref]
[ 0.306372] pci 0000:04:00.0: [14c3:0608] type 00 class 0x028000
[ 0.306436] pci 0000:04:00.0: reg 0x10: [mem 0xfe30300000-0xfe303fffff
64bit pref]
[ 0.306474] pci 0000:04:00.0: reg 0x18: [mem 0xfe30400000-0xfe30403fff
64bit pref]
[ 0.306538] pci 0000:04:00.0: reg 0x20: [mem 0xfe30404000-0xfe30404fff
64bit pref]
[ 0.306682] pci 0000:04:00.0: supports D1 D2
[ 0.306682] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[ 0.310280] pci 0000:00:02.1: PCI bridge to [bus 04]
[ 0.310285] pci 0000:00:02.1: bridge window [mem 0xfe30300000-
0xfe304fffff 64bit pref]
[ 0.310330] pci 0000:05:00.0: [10ec:8168] type 00 class 0x020000
[ 0.310346] pci 0000:05:00.0: reg 0x10: [io 0xf000-0xf0ff]
[ 0.310367] pci 0000:05:00.0: reg 0x18: [mem 0xfcf04000-0xfcf04fff
64bit]
[ 0.310379] pci 0000:05:00.0: reg 0x20: [mem 0xfcf00000-0xfcf03fff
64bit]
[ 0.310462] pci 0000:05:00.0: supports D1 D2
[ 0.310463] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[ 0.310576] pci 0000:00:02.2: PCI bridge to [bus 05]
[ 0.310579] pci 0000:00:02.2: bridge window [io 0xf000-0xffff]
[ 0.310580] pci 0000:00:02.2: bridge window [mem 0xfcf00000-0xfcffffff]
[ 0.310928] pci 0000:06:00.0: [c0a9:2263] type 00 class 0x010802
[ 0.310947] pci 0000:06:00.0: reg 0x10: [mem 0xfce00000-0xfce03fff
64bit]
[ 0.313949] pci 0000:00:02.3: PCI bridge to [bus 06]
[ 0.313952] pci 0000:00:02.3: bridge window [mem 0xfce00000-0xfcefffff]
[ 0.314242] pci 0000:07:00.0: [2646:500c] type 00 class 0x010802
[ 0.314284] pci 0000:07:00.0: reg 0x10: [mem 0xfcd00000-0xfcd03fff
64bit]
[ 0.314967] pci 0000:00:02.4: PCI bridge to [bus 07]
[ 0.314971] pci 0000:00:02.4: bridge window [mem 0xfcd00000-0xfcdfffff]
[ 0.315026] pci 0000:08:00.0: [1002:1638] type 00 class 0x030000
[ 0.315039] pci 0000:08:00.0: reg 0x10: [mem 0xfe20000000-0xfe2fffffff
64bit pref]
[ 0.315047] pci 0000:08:00.0: reg 0x18: [mem 0xfe30000000-0xfe301fffff
64bit pref]
[ 0.315053] pci 0000:08:00.0: reg 0x20: [io 0xe000-0xe0ff]
[ 0.315058] pci 0000:08:00.0: reg 0x24: [mem 0xfc900000-0xfc97ffff]
[ 0.315068] pci 0000:08:00.0: enabling Extended Tags
[ 0.315079] pci 0000:08:00.0: BAR 0: assigned to efifb
[ 0.315127] pci 0000:08:00.0: PME# supported from D1 D2 D3hot D3cold
[ 0.315170] pci 0000:08:00.0: 126.016 Gb/s available PCIe bandwidth,
limited by 8.0 GT/s PCIe x16 link at 0000:00:08.1 (capable of 252.048
Gb/s with 16.0 GT/s PCIe x16 link)
[ 0.315209] pci 0000:08:00.1: [1002:1637] type 00 class 0x040300
[ 0.315217] pci 0000:08:00.1: reg 0x10: [mem 0xfc9c8000-0xfc9cbfff]
[ 0.315241] pci 0000:08:00.1: enabling Extended Tags
[ 0.315275] pci 0000:08:00.1: PME# supported from D1 D2 D3hot D3cold
[ 0.315327] pci 0000:08:00.2: [1022:15df] type 00 class 0x108000
[ 0.315342] pci 0000:08:00.2: reg 0x18: [mem 0xfc800000-0xfc8fffff]
[ 0.315352] pci 0000:08:00.2: reg 0x24: [mem 0xfc9ce000-0xfc9cffff]
[ 0.315360] pci 0000:08:00.2: enabling Extended Tags
[ 0.315445] pci 0000:08:00.3: [1022:1639] type 00 class 0x0c0330
[ 0.315457] pci 0000:08:00.3: reg 0x10: [mem 0xfc700000-0xfc7fffff
64bit]
[ 0.315486] pci 0000:08:00.3: enabling Extended Tags
[ 0.315522] pci 0000:08:00.3: PME# supported from D0 D3hot D3cold
[ 0.315575] pci 0000:08:00.4: [1022:1639] type 00 class 0x0c0330
[ 0.315586] pci 0000:08:00.4: reg 0x10: [mem 0xfc600000-0xfc6fffff
64bit]
[ 0.315614] pci 0000:08:00.4: enabling Extended Tags
[ 0.315650] pci 0000:08:00.4: PME# supported from D0 D3hot D3cold
[ 0.315711] pci 0000:08:00.5: [1022:15e2] type 00 class 0x048000
[ 0.315717] pci 0000:08:00.5: reg 0x10: [mem 0xfc980000-0xfc9bffff]
[ 0.315736] pci 0000:08:00.5: enabling Extended Tags
[ 0.315761] pci 0000:08:00.5: PME# supported from D0 D3hot D3cold
[ 0.315805] pci 0000:08:00.6: [1022:15e3] type 00 class 0x040300
[ 0.315811] pci 0000:08:00.6: reg 0x10: [mem 0xfc9c0000-0xfc9c7fff]
[ 0.315829] pci 0000:08:00.6: enabling Extended Tags
[ 0.315856] pci 0000:08:00.6: PME# supported from D0 D3hot D3cold
[ 0.315900] pci 0000:08:00.7: [1022:15e4] type 00 class 0x118000
[ 0.315912] pci 0000:08:00.7: reg 0x18: [mem 0xfc500000-0xfc5fffff]
[ 0.315920] pci 0000:08:00.7: reg 0x24: [mem 0xfc9cc000-0xfc9cdfff]
[ 0.315926] pci 0000:08:00.7: enabling Extended Tags
[ 0.316009] pci 0000:00:08.1: PCI bridge to [bus 08]
[ 0.316011] pci 0000:00:08.1: bridge window [io 0xe000-0xefff]
[ 0.316012] pci 0000:00:08.1: bridge window [mem 0xfc500000-0xfc9fffff]
[ 0.316014] pci 0000:00:08.1: bridge window [mem 0xfe20000000-
0xfe301fffff 64bit pref]
[ 0.316544] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[ 0.316570] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
[ 0.316592] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[ 0.316619] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[ 0.316643] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[ 0.316663] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[ 0.316684] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[ 0.316703] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[ 0.317984] acpi LNXPOWER:09: Turning OFF
[ 0.318024] ACPI: EC: interrupt unblocked
[ 0.318025] ACPI: EC: event unblocked
[ 0.318029] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[ 0.318029] ACPI: EC: GPE=3D0x3
[ 0.318030] ACPI: \_SB_.PCI0.SBRG.EC__: Boot ECDT EC initialization
complete
[ 0.318031] ACPI: \_SB_.PCI0.SBRG.EC__: EC: Used to handle transactions
and events
[ 0.318064] iommu: Default domain type: Translated
[ 0.318064] pci 0000:08:00.0: vgaarb: VGA device added:
decodes=3Dio+mem,owns=3Dnone,locks=3Dnone
[ 0.318064] pci 0000:08:00.0: vgaarb: bridge control possible
[ 0.318064] pci 0000:08:00.0: vgaarb: setting as boot device
[ 0.318064] vgaarb: loaded
[ 0.319535] EDAC MC: Ver: 3.0.0
[ 0.325948] Registered efivars operations
[ 0.326006] NetLabel: Initializing
[ 0.326006] NetLabel: domain hash size =3D 128
[ 0.326007] NetLabel: protocols =3D UNLABELED CIPSOv4 CALIPSO
[ 0.326015] NetLabel: unlabeled traffic allowed by default
[ 0.326016] PCI: Using ACPI for IRQ routing
[ 0.330384] PCI: pci_cache_line_size set to 64 bytes
[ 0.335428] Expanded resource Reserved due to conflict with PCI Bus
0000:00
[ 0.335430] e820: reserve RAM buffer [mem 0x09bff000-0x0bffffff]
[ 0.335431] e820: reserve RAM buffer [mem 0x0a200000-0x0bffffff]
[ 0.335432] e820: reserve RAM buffer [mem 0xe62ee000-0xe7ffffff]
[ 0.335432] e820: reserve RAM buffer [mem 0xe6fa0000-0xe7ffffff]
[ 0.335433] e820: reserve RAM buffer [mem 0xe87cb000-0xebffffff]
[ 0.335433] e820: reserve RAM buffer [mem 0xe9e20000-0xebffffff]
[ 0.335434] e820: reserve RAM buffer [mem 0xee000000-0xefffffff]
[ 0.335434] e820: reserve RAM buffer [mem 0x3ee300000-0x3efffffff]
[ 0.335453] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[ 0.335456] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[ 0.338972] clocksource: Switched to clocksource tsc-early
[ 0.341249] VFS: Disk quotas dquot_6.6.0
[ 0.341256] VFS: Dquot-cache hash table entries: 512 (order 0, 4096
bytes)
[ 0.341316] AppArmor: AppArmor Filesystem Enabled
[ 0.341323] pnp: PnP ACPI init
[ 0.341366] system 00:00: [mem 0xf0000000-0xf7ffffff] has been reserved
[ 0.341370] system 00:00: Plug and Play ACPI device, IDs PNP0c01
(active)
[ 0.341421] pnp 00:01: Plug and Play ACPI device, IDs PNP0b00 (active)
[ 0.341437] pnp 00:02: Plug and Play ACPI device, IDs PNP0f13 (active)
[ 0.341446] pnp 00:03: Plug and Play ACPI device, IDs MSI0007 PNP0303
(active)
[ 0.341740] system 00:04: [io 0x04d0-0x04d1] has been reserved
[ 0.341742] system 00:04: [io 0x040b] has been reserved
[ 0.341743] system 00:04: [io 0x04d6] has been reserved
[ 0.341744] system 00:04: [io 0x0c00-0x0c01] has been reserved
[ 0.341744] system 00:04: [io 0x0c14] has been reserved
[ 0.341745] system 00:04: [io 0x0c50-0x0c51] has been reserved
[ 0.341746] system 00:04: [io 0x0c52] has been reserved
[ 0.341746] system 00:04: [io 0x0c6c] has been reserved
[ 0.341747] system 00:04: [io 0x0c6f] has been reserved
[ 0.341747] system 00:04: [io 0x0cd8-0x0cdf] has been reserved
[ 0.341748] system 00:04: [io 0x0800-0x089f] has been reserved
[ 0.341748] system 00:04: [io 0x0b00-0x0b0f] has been reserved
[ 0.341749] system 00:04: [io 0x0b20-0x0b3f] has been reserved
[ 0.341750] system 00:04: [io 0x0900-0x090f] has been reserved
[ 0.341750] system 00:04: [io 0x0910-0x091f] has been reserved
[ 0.341751] system 00:04: [mem 0xfec00000-0xfec00fff] could not be
reserved
[ 0.341752] system 00:04: [mem 0xfec01000-0xfec01fff] could not be
reserved
[ 0.341753] system 00:04: [mem 0xfedc0000-0xfedc0fff] has been reserved
[ 0.341755] system 00:04: [mem 0xfee00000-0xfee00fff] has been reserved
[ 0.341755] system 00:04: [mem 0xfed80000-0xfed8ffff] could not be
reserved
[ 0.341756] system 00:04: [mem 0xfec10000-0xfec10fff] has been reserved
[ 0.341757] system 00:04: [mem 0xff000000-0xffffffff] has been reserved
[ 0.341760] system 00:04: Plug and Play ACPI device, IDs PNP0c02
(active)
[ 0.342163] pnp: PnP ACPI: found 5 devices
[ 0.347426] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff,
max_idle_ns: 2085701024 ns
[ 0.347477] NET: Registered protocol family 2
[ 0.347652] IP idents hash table entries: 262144 (order: 9, 2097152
bytes, linear)
[ 0.349066] tcp_listen_portaddr_hash hash table entries: 8192 (order:
5, 131072 bytes, linear)
[ 0.349215] TCP established hash table entries: 131072 (order: 8,
1048576 bytes, linear)
[ 0.349412] TCP bind hash table entries: 65536 (order: 8, 1048576
bytes, linear)
[ 0.349471] TCP: Hash tables configured (established 131072 bind 65536)
[ 0.349540] MPTCP token hash table entries: 16384 (order: 6, 393216
bytes, linear)
[ 0.349574] UDP hash table entries: 8192 (order: 6, 262144 bytes,
linear)
[ 0.349606] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes,
linear)
[ 0.349655] NET: Registered protocol family 1
[ 0.349658] NET: Registered protocol family 44
[ 0.349663] pci 0000:00:01.1: bridge window [io 0x1000-0x0fff] to [bus
01-03] add_size 1000
[ 0.349668] pci 0000:00:01.1: BAR 13: assigned [io 0x1000-0x1fff]
[ 0.349670] pci 0000:02:00.0: PCI bridge to [bus 03]
[ 0.349677] pci 0000:02:00.0: bridge window [mem 0xfca00000-0xfcbfffff]
[ 0.349680] pci 0000:02:00.0: bridge window [mem 0xfc00000000-
0xfe0fffffff 64bit pref]
[ 0.349684] pci 0000:01:00.0: PCI bridge to [bus 02-03]
[ 0.349687] pci 0000:01:00.0: bridge window [mem 0xfca00000-0xfcbfffff]
[ 0.349689] pci 0000:01:00.0: bridge window [mem 0xfc00000000-
0xfe0fffffff 64bit pref]
[ 0.349693] pci 0000:00:01.1: PCI bridge to [bus 01-03]
[ 0.349694] pci 0000:00:01.1: bridge window [io 0x1000-0x1fff]
[ 0.349696] pci 0000:00:01.1: bridge window [mem 0xfca00000-0xfccfffff]
[ 0.349697] pci 0000:00:01.1: bridge window [mem 0xfc00000000-
0xfe0fffffff 64bit pref]
[ 0.349700] pci 0000:00:02.1: PCI bridge to [bus 04]
[ 0.349703] pci 0000:00:02.1: bridge window [mem 0xfe30300000-
0xfe304fffff 64bit pref]
[ 0.349705] pci 0000:00:02.2: PCI bridge to [bus 05]
[ 0.349706] pci 0000:00:02.2: bridge window [io 0xf000-0xffff]
[ 0.349708] pci 0000:00:02.2: bridge window [mem 0xfcf00000-0xfcffffff]
[ 0.349711] pci 0000:00:02.3: PCI bridge to [bus 06]
[ 0.349713] pci 0000:00:02.3: bridge window [mem 0xfce00000-0xfcefffff]
[ 0.349717] pci 0000:00:02.4: PCI bridge to [bus 07]
[ 0.349718] pci 0000:00:02.4: bridge window [mem 0xfcd00000-0xfcdfffff]
[ 0.349722] pci 0000:00:08.1: PCI bridge to [bus 08]
[ 0.349723] pci 0000:00:08.1: bridge window [io 0xe000-0xefff]
[ 0.349725] pci 0000:00:08.1: bridge window [mem 0xfc500000-0xfc9fffff]
[ 0.349726] pci 0000:00:08.1: bridge window [mem 0xfe20000000-
0xfe301fffff 64bit pref]
[ 0.349729] pci_bus 0000:00: resource 4 [io 0x0000-0x03af window]
[ 0.349729] pci_bus 0000:00: resource 5 [io 0x03e0-0x0cf7 window]
[ 0.349730] pci_bus 0000:00: resource 6 [io 0x03b0-0x03df window]
[ 0.349731] pci_bus 0000:00: resource 7 [io 0x0d00-0xffff window]
[ 0.349731] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff
window]
[ 0.349732] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff
window]
[ 0.349732] pci_bus 0000:00: resource 10 [mem 0xf0000000-0xfcffffff
window]
[ 0.349733] pci_bus 0000:00: resource 11 [mem 0x410000000-0xffffffffff
window]
[ 0.349733] pci_bus 0000:01: resource 0 [io 0x1000-0x1fff]
[ 0.349734] pci_bus 0000:01: resource 1 [mem 0xfca00000-0xfccfffff]
[ 0.349735] pci_bus 0000:01: resource 2 [mem 0xfc00000000-0xfe0fffffff
64bit pref]
[ 0.349735] pci_bus 0000:02: resource 1 [mem 0xfca00000-0xfcbfffff]
[ 0.349736] pci_bus 0000:02: resource 2 [mem 0xfc00000000-0xfe0fffffff
64bit pref]
[ 0.349736] pci_bus 0000:03: resource 1 [mem 0xfca00000-0xfcbfffff]
[ 0.349737] pci_bus 0000:03: resource 2 [mem 0xfc00000000-0xfe0fffffff
64bit pref]
[ 0.349737] pci_bus 0000:04: resource 2 [mem 0xfe30300000-0xfe304fffff
64bit pref]
[ 0.349738] pci_bus 0000:05: resource 0 [io 0xf000-0xffff]
[ 0.349739] pci_bus 0000:05: resource 1 [mem 0xfcf00000-0xfcffffff]
[ 0.349739] pci_bus 0000:06: resource 1 [mem 0xfce00000-0xfcefffff]
[ 0.349740] pci_bus 0000:07: resource 1 [mem 0xfcd00000-0xfcdfffff]
[ 0.349740] pci_bus 0000:08: resource 0 [io 0xe000-0xefff]
[ 0.349741] pci_bus 0000:08: resource 1 [mem 0xfc500000-0xfc9fffff]
[ 0.349741] pci_bus 0000:08: resource 2 [mem 0xfe20000000-0xfe301fffff
64bit pref]
[ 0.349797] pci 0000:03:00.1: D0 power state depends on 0000:03:00.0
[ 0.355328] pci 0000:08:00.1: D0 power state depends on 0000:08:00.0
[ 0.355332] pci 0000:08:00.3: extending delay after power-on from D3hot
to 20 msec
[ 0.355454] pci 0000:08:00.4: extending delay after power-on from D3hot
to 20 msec
[ 0.355501] PCI: CLS 64 bytes, default 64
[ 0.355511] pci 0000:00:00.2: AMD-Vi: IOMMU performance counters
supported
[ 0.355542] pci 0000:00:00.2: can't derive routing for PCI INT A
[ 0.355543] pci 0000:00:00.2: PCI INT A: not connected
[ 0.355557] pci 0000:00:01.0: Adding to iommu group 0
[ 0.355558] Trying to unpack rootfs image as initramfs...
[ 0.355563] pci 0000:00:01.1: Adding to iommu group 1
[ 0.355573] pci 0000:00:02.0: Adding to iommu group 2
[ 0.355578] pci 0000:00:02.1: Adding to iommu group 3
[ 0.355585] pci 0000:00:02.2: Adding to iommu group 4
[ 0.355590] pci 0000:00:02.3: Adding to iommu group 5
[ 0.355594] pci 0000:00:02.4: Adding to iommu group 6
[ 0.355600] pci 0000:00:08.0: Adding to iommu group 7
[ 0.355606] pci 0000:00:08.1: Adding to iommu group 8
[ 0.355612] pci 0000:00:14.0: Adding to iommu group 9
[ 0.355615] pci 0000:00:14.3: Adding to iommu group 9
[ 0.355629] pci 0000:00:18.0: Adding to iommu group 10
[ 0.355633] pci 0000:00:18.1: Adding to iommu group 10
[ 0.355636] pci 0000:00:18.2: Adding to iommu group 10
[ 0.355640] pci 0000:00:18.3: Adding to iommu group 10
[ 0.355644] pci 0000:00:18.4: Adding to iommu group 10
[ 0.355647] pci 0000:00:18.5: Adding to iommu group 10
[ 0.355651] pci 0000:00:18.6: Adding to iommu group 10
[ 0.355654] pci 0000:00:18.7: Adding to iommu group 10
[ 0.355659] pci 0000:01:00.0: Adding to iommu group 11
[ 0.355665] pci 0000:02:00.0: Adding to iommu group 12
[ 0.355674] pci 0000:03:00.0: Adding to iommu group 13
[ 0.355682] pci 0000:03:00.1: Adding to iommu group 14
[ 0.355687] pci 0000:04:00.0: Adding to iommu group 15
[ 0.355692] pci 0000:05:00.0: Adding to iommu group 16
[ 0.355698] pci 0000:06:00.0: Adding to iommu group 17
[ 0.355702] pci 0000:07:00.0: Adding to iommu group 18
[ 0.355719] pci 0000:08:00.0: Adding to iommu group 19
[ 0.355726] pci 0000:08:00.1: Adding to iommu group 20
[ 0.355731] pci 0000:08:00.2: Adding to iommu group 21
[ 0.355737] pci 0000:08:00.3: Adding to iommu group 22
[ 0.355744] pci 0000:08:00.4: Adding to iommu group 23
[ 0.355751] pci 0000:08:00.5: Adding to iommu group 24
[ 0.355757] pci 0000:08:00.6: Adding to iommu group 25
[ 0.355762] pci 0000:08:00.7: Adding to iommu group 26
[ 0.357702] pci 0000:00:00.2: AMD-Vi: Found IOMMU cap 0x40
[ 0.357704] pci 0000:00:00.2: AMD-Vi: Extended features
(0x206d73ef22254ade):
[ 0.357705] PPR X2APIC NX GT IA GA PC GA_vAPIC
[ 0.357707] AMD-Vi: Interrupt remapping enabled
[ 0.357708] AMD-Vi: Virtual APIC enabled
[ 0.357708] AMD-Vi: X2APIC enabled
[ 0.392506] AMD-Vi: Lazy IO/TLB flushing enabled
[ 0.392537] amd_uncore: 4 amd_df counters detected
[ 0.392539] amd_uncore: 6 amd_l3 counters detected
[ 0.393084] LVT offset 0 assigned for vector 0x400
[ 0.393333] perf: AMD IBS detected (0x000003ff)
[ 0.393335] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4
counters/bank).
[ 0.393616] Initialise system trusted keyrings
[ 0.393622] Key type blacklist registered
[ 0.393655] workingset: timestamp_bits=3D36 max_order=3D22 bucket_order=3D=
0
[ 0.394098] zbud: loaded
[ 0.394232] integrity: Platform Keyring initialized
[ 0.394234] Key type asymmetric registered
[ 0.394235] Asymmetric key parser 'x509' registered
[ 0.394242] Block layer SCSI generic (bsg) driver version 0.4 loaded
(major 250)
[ 0.394279] io scheduler mq-deadline registered
[ 0.395486] pcieport 0000:00:01.1: PME: Signaling with IRQ 41
[ 0.395499] pcieport 0000:00:01.1: pciehp: Slot #0 AttnBtn- PwrCtrl-
MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis-
LLActRep+
[ 0.395606] pcieport 0000:00:02.1: PME: Signaling with IRQ 42
[ 0.395679] pcieport 0000:00:02.2: PME: Signaling with IRQ 43
[ 0.395752] pcieport 0000:00:02.3: PME: Signaling with IRQ 44
[ 0.395829] pcieport 0000:00:02.4: PME: Signaling with IRQ 45
[ 0.395906] pcieport 0000:00:08.1: PME: Signaling with IRQ 46
[ 0.396229] shpchp: Standard Hot Plug PCI Controller Driver version:
0.4
[ 0.396237] efifb: probing for efifb
[ 0.396244] efifb: framebuffer at 0xfe20000000, using 3072k, total
3072k
[ 0.396245] efifb: mode is 1024x768x32, linelength=3D4096, pages=3D1
[ 0.396245] efifb: scrolling: redraw
[ 0.396246] efifb: Truecolor: size=3D8:8:8:8, shift=3D24:16:8:0
[ 0.396292] Console: switching to colour frame buffer device 128x48
[ 0.407123] fb0: EFI VGA frame buffer device
[ 0.407196] smpboot: Estimated ratio of average max frequency by base
frequency (times 1024): 1226
[ 0.407207] Monitor-Mwait will be used to enter C-1 state
[ 0.407210] ACPI: \_SB_.PLTF.P000: Found 3 idle states
[ 0.407270] ACPI: \_SB_.PLTF.P001: Found 3 idle states
[ 0.407380] ACPI: \_SB_.PLTF.P002: Found 3 idle states
[ 0.407510] ACPI: \_SB_.PLTF.P003: Found 3 idle states
[ 0.408176] ACPI: \_SB_.PLTF.P004: Found 3 idle states
[ 0.408329] ACPI: \_SB_.PLTF.P005: Found 3 idle states
[ 0.408460] ACPI: \_SB_.PLTF.P006: Found 3 idle states
[ 0.408615] ACPI: \_SB_.PLTF.P007: Found 3 idle states
[ 0.408795] ACPI: \_SB_.PLTF.P008: Found 3 idle states
[ 0.408927] ACPI: \_SB_.PLTF.P009: Found 3 idle states
[ 0.409015] ACPI: \_SB_.PLTF.P00A: Found 3 idle states
[ 0.409137] ACPI: \_SB_.PLTF.P00B: Found 3 idle states
[ 0.409214] ACPI: \_SB_.PLTF.P00C: Found 3 idle states
[ 0.409263] ACPI: \_SB_.PLTF.P00D: Found 3 idle states
[ 0.409344] ACPI: \_SB_.PLTF.P00E: Found 3 idle states
[ 0.409442] ACPI: \_SB_.PLTF.P00F: Found 3 idle states
[ 0.410178] thermal LNXTHERM:00: registered as thermal_zone0
[ 0.410181] ACPI: thermal: Thermal Zone [THRM] (55 C)
[ 0.410314] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[ 0.410521] Linux agpgart interface v0.103
[ 0.461022] AMD-Vi: AMD IOMMUv2 driver by Joerg Roedel
<jroedel@suse.de>
[ 0.462267] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at
0x60,0x64 irq 1,12
[ 0.470388] serio: i8042 KBD port at 0x60,0x64 irq 1
[ 0.470395] serio: i8042 AUX port at 0x60,0x64 irq 12
[ 0.470542] mousedev: PS/2 mouse device common for all mice
[ 0.470582] rtc_cmos 00:01: RTC can wake from S4
[ 0.470801] rtc_cmos 00:01: registered as rtc0
[ 0.470868] rtc_cmos 00:01: setting system clock to 2022-01-19T21:26:45
UTC (1642627605)
[ 0.470892] rtc_cmos 00:01: alarms up to one month, y3k, 114 bytes
nvram, hpet irqs
[ 0.471280] ledtrig-cpu: registered to indicate activity on CPUs
[ 0.471503] NET: Registered protocol family 10
[ 0.481448] input: AT Translated Set 2 keyboard as
/devices/platform/i8042/serio0/input/input0
[ 0.906467] Freeing initrd memory: 73876K
[ 0.912406] Segment Routing with IPv6
[ 0.912429] mip6: Mobile IPv6
[ 0.912430] NET: Registered protocol family 17
[ 0.912536] mpls_gso: MPLS GSO support
[ 0.913823] microcode: CPU0: patch_level=3D0x0a50000c
[ 0.913827] microcode: CPU1: patch_level=3D0x0a50000c
[ 0.913850] microcode: CPU2: patch_level=3D0x0a50000c
[ 0.913863] microcode: CPU3: patch_level=3D0x0a50000c
[ 0.913884] microcode: CPU4: patch_level=3D0x0a50000c
[ 0.913900] microcode: CPU5: patch_level=3D0x0a50000c
[ 0.913923] microcode: CPU6: patch_level=3D0x0a50000c
[ 0.913940] microcode: CPU7: patch_level=3D0x0a50000c
[ 0.913962] microcode: CPU8: patch_level=3D0x0a50000c
[ 0.913979] microcode: CPU9: patch_level=3D0x0a50000c
[ 0.914000] microcode: CPU10: patch_level=3D0x0a50000c
[ 0.914017] microcode: CPU11: patch_level=3D0x0a50000c
[ 0.914039] microcode: CPU12: patch_level=3D0x0a50000c
[ 0.914056] microcode: CPU13: patch_level=3D0x0a50000c
[ 0.914078] microcode: CPU14: patch_level=3D0x0a50000c
[ 0.914094] microcode: CPU15: patch_level=3D0x0a50000c
[ 0.914099] microcode: Microcode Update Driver: v2.2.
[ 0.914474] resctrl: L3 allocation detected
[ 0.914475] resctrl: L3DATA allocation detected
[ 0.914476] resctrl: L3CODE allocation detected
[ 0.914477] resctrl: MB allocation detected
[ 0.914477] resctrl: L3 monitoring detected
[ 0.914480] IPI shorthand broadcast: enabled
[ 0.914487] sched_clock: Marking stable (914194393, 264100)-
>(921446453, -6987960)
[ 0.914808] registered taskstats version 1
[ 0.914811] Loading compiled-in X.509 certificates
[ 0.929029] Loaded X.509 cert 'Build time autogenerated kernel key:
d87fdd800a83b6e58ed667c66180ae0da0be3c16'
[ 0.929379] zswap: loaded using pool lzo/zbud
[ 0.929749] Key type ._fscrypt registered
[ 0.929751] Key type .fscrypt registered
[ 0.929752] Key type fscrypt-provisioning registered
[ 0.932624] Key type encrypted registered
[ 0.932630] AppArmor: AppArmor sha1 policy hashing enabled
[ 0.932756] integrity: Loading X.509 certificate: UEFI:db
[ 0.932783] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA
2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[ 0.932784] integrity: Loading X.509 certificate: UEFI:db
[ 0.932795] integrity: Loaded X.509 cert 'Microsoft Windows Production
PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[ 0.933227] integrity: Loading X.509 certificate: UEFI:MokListRT
(MOKvar table)
[ 0.933351] integrity: Loaded X.509 cert 'Debian Secure Boot CA:
6ccece7e4c6c0d1f6149f3dd27dfcc5cbb419ea1'
[ 0.933355] ima: Allocated hash algorithm: sha256
[ 1.100300] ima: No architecture policies found
[ 1.100318] evm: Initialising EVM extended attributes:
[ 1.100319] evm: security.selinux
[ 1.100320] evm: security.apparmor
[ 1.100320] evm: security.ima
[ 1.100320] evm: security.capability
[ 1.100321] evm: HMAC attrs: 0x1
[ 1.101658] ACPI BIOS Error (bug): Could not resolve symbol
[\_SB.PCI0.GP17.MP2], AE_NOT_FOUND (20210331/psargs-330)
[ 1.101695] pci_bus 0000:03: Allocating resources
[ 1.101943] ACPI Error: Aborting method \_SB.GPIO._EVT due to previous
error (AE_NOT_FOUND) (20210331/psparse-529)
[ 1.102903] Freeing unused decrypted memory: 2036K
[ 1.103165] Freeing unused kernel image (initmem) memory: 2620K
[ 1.114307] Write protecting the kernel read-only data: 24576k
[ 1.115048] Freeing unused kernel image (text/rodata gap) memory: 2040K
[ 1.115361] Freeing unused kernel image (rodata/data gap) memory: 2008K
[ 1.137324] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[ 1.137335] Run /init as init process
[ 1.137336] with arguments:
[ 1.137337] /init
[ 1.137338] with environment:
[ 1.137338] HOME=3D/
[ 1.137339] TERM=3Dlinux
[ 1.137339] BOOT_IMAGE=3D/boot/vmlinuz-5.13.0+
[ 1.188580] hid: raw HID events driver (C) Jiri Kosina
[ 1.188643] input: Lid Switch as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:33/PNP0C09:00/PNP0C0
D:00/input/input2
[ 1.188669] ACPI: bus type USB registered
[ 1.188679] ACPI: button: Lid Switch [LID0]
[ 1.188683] usbcore: registered new interface driver usbfs
[ 1.188688] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xff00,
revision 15
[ 1.188689] usbcore: registered new interface driver hub
[ 1.188691] piix4_smbus 0000:00:14.0: Using register 0x02 for SMBus
port selection
[ 1.188707] usbcore: registered new device driver usb
[ 1.188741] input: Power Button as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input3
[ 1.188766] ACPI: button: Power Button [PWRB]
[ 1.188809] input: Sleep Button as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input4
[ 1.188826] ACPI: button: Sleep Button [SLPB]
[ 1.188843] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Controller
at 0xff20
[ 1.189024] ACPI: video: Video Device [VGA] (multi-head: yes rom: no
post: no)
[ 1.191077] pcie_mp2_amd 0000:08:00.7: enabling device (0000 -> 0002)
[ 1.194911] xhci_hcd 0000:08:00.3: xHCI Host Controller
[ 1.194916] xhci_hcd 0000:08:00.3: new USB bus registered, assigned bus
number 1
[ 1.195008] xhci_hcd 0000:08:00.3: hcc params 0x0268ffe5 hci version
0x110 quirks 0x0000020000000410
[ 1.195294] usb usb1: New USB device found, idVendor=3D1d6b,
idProduct=3D0002, bcdDevice=3D 5.13
[ 1.195296] usb usb1: New USB device strings: Mfr=3D3, Product=3D2,
SerialNumber=3D1
[ 1.195298] usb usb1: Product: xHCI Host Controller
[ 1.195299] usb usb1: Manufacturer: Linux 5.13.0+ xhci-hcd
[ 1.195300] usb usb1: SerialNumber: 0000:08:00.3
[ 1.195404] hub 1-0:1.0: USB hub found
[ 1.195411] hub 1-0:1.0: 4 ports detected
[ 1.196552] xhci_hcd 0000:08:00.3: xHCI Host Controller
[ 1.196554] xhci_hcd 0000:08:00.3: new USB bus registered, assigned bus
number 2
[ 1.196557] xhci_hcd 0000:08:00.3: Host supports USB 3.1 Enhanced
SuperSpeed
[ 1.196565] usb usb2: We don't know the algorithms for LPM for this
host, disabling LPM.
[ 1.196575] usb usb2: New USB device found, idVendor=3D1d6b,
idProduct=3D0003, bcdDevice=3D 5.13
[ 1.196576] usb usb2: New USB device strings: Mfr=3D3, Product=3D2,
SerialNumber=3D1
[ 1.196577] usb usb2: Product: xHCI Host Controller
[ 1.196578] usb usb2: Manufacturer: Linux 5.13.0+ xhci-hcd
[ 1.196578] usb usb2: SerialNumber: 0000:08:00.3
[ 1.196681] hub 2-0:1.0: USB hub found
[ 1.196688] hub 2-0:1.0: 2 ports detected
[ 1.197191] xhci_hcd 0000:08:00.4: xHCI Host Controller
[ 1.197194] xhci_hcd 0000:08:00.4: new USB bus registered, assigned bus
number 3
[ 1.197288] xhci_hcd 0000:08:00.4: hcc params 0x0268ffe5 hci version
0x110 quirks 0x0000020000000410
[ 1.197555] usb usb3: New USB device found, idVendor=3D1d6b,
idProduct=3D0002, bcdDevice=3D 5.13
[ 1.197556] usb usb3: New USB device strings: Mfr=3D3, Product=3D2,
SerialNumber=3D1
[ 1.197557] usb usb3: Product: xHCI Host Controller
[ 1.197558] usb usb3: Manufacturer: Linux 5.13.0+ xhci-hcd
[ 1.197559] usb usb3: SerialNumber: 0000:08:00.4
[ 1.197647] hub 3-0:1.0: USB hub found
[ 1.197652] hub 3-0:1.0: 4 ports detected
[ 1.198445] acpi device:14: registered as cooling_device16
[ 1.198559] input: Video Bus as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:13/LNXVIDEO:00/input
/input6
[ 1.198749] xhci_hcd 0000:08:00.4: xHCI Host Controller
[ 1.198755] xhci_hcd 0000:08:00.4: new USB bus registered, assigned bus
number 4
[ 1.198759] xhci_hcd 0000:08:00.4: Host supports USB 3.1 Enhanced
SuperSpeed
[ 1.198776] usb usb4: We don't know the algorithms for LPM for this
host, disabling LPM.
[ 1.198787] usb usb4: New USB device found, idVendor=3D1d6b,
idProduct=3D0003, bcdDevice=3D 5.13
[ 1.198789] usb usb4: New USB device strings: Mfr=3D3, Product=3D2,
SerialNumber=3D1
[ 1.198790] usb usb4: Product: xHCI Host Controller
[ 1.198790] usb usb4: Manufacturer: Linux 5.13.0+ xhci-hcd
[ 1.198791] usb usb4: SerialNumber: 0000:08:00.4
[ 1.198933] hub 4-0:1.0: USB hub found
[ 1.198942] hub 4-0:1.0: 2 ports detected
[ 1.199024] nvme 0000:06:00.0: platform quirk: setting simple suspend
[ 1.199062] nvme nvme0: pci function 0000:06:00.0
[ 1.199082] nvme 0000:07:00.0: platform quirk: setting simple suspend
[ 1.199386] nvme nvme1: pci function 0000:07:00.0
[ 1.203349] hid-generic 0020:1022:0001.0001: hidraw0: <UNKNOWN> HID
v0.00 Device [hid-amdtp 1022:0001] on
[ 1.203427] hid-generic 0020:1022:0001.0002: hidraw1: <UNKNOWN> HID
v0.00 Device [hid-amdtp 1022:0001] on
[ 1.203521] hid-generic 0020:1022:0001.0003: hidraw2: <UNKNOWN> HID
v0.00 Device [hid-amdtp 1022:0001] on
[ 1.203632] hid-generic 0020:1022:0001.0004: hidraw3: <UNKNOWN> HID
v0.00 Device [hid-amdtp 1022:0001] on
[ 1.206797] nvme nvme1: missing or invalid SUBNQN field.
[ 1.206828] nvme nvme1: Shutdown timeout set to 10 seconds
[ 1.207697] nvme nvme0: missing or invalid SUBNQN field.
[ 1.208941] nvme nvme1: 8/0/0 default/read/poll queues
[ 1.211519] nvme1n1: p1 p2 p3 p4
[ 1.212608] nvme nvme0: 15/0/0 default/read/poll queues
[ 1.213110] libphy: r8169: probed
[ 1.213240] r8169 0000:05:00.0 eth0: RTL8168h/8111h, d8:bb:c1:ab:dd:5e,
XID 541, IRQ 82
[ 1.213243] r8169 0000:05:00.0 eth0: jumbo features [frames: 9194
bytes, tx checksumming: ko]
[ 1.213558] nvme0n1: p1
[ 1.213772] r8169 0000:05:00.0 enp5s0: renamed from eth0
[ 1.297597] [drm] amdgpu kernel modesetting enabled.
[ 1.297613] amdgpu: vga_switcheroo: detected switching method
\_SB_.PCI0.GP17.VGA_.ATPX handle
[ 1.297811] ATPX version 1, functions 0x00000001
[ 1.297830] ATPX Hybrid Graphics
[ 1.301111] amdgpu: Virtual CRAT table created for CPU
[ 1.301118] amdgpu: Topology: Add CPU node
[ 1.301158] checking generic (fe20000000 300000) vs hw (fc00000000
200000000)
[ 1.301160] checking generic (fe20000000 300000) vs hw (fc00000000
200000000)
[ 1.301161] checking generic (fe20000000 300000) vs hw (fe00000000
10000000)
[ 1.301161] checking generic (fe20000000 300000) vs hw (fca00000
100000)
[ 1.301190] amdgpu 0000:03:00.0: enabling device (0000 -> 0002)
[ 1.301217] [drm] initializing kernel modesetting (DIMGREY_CAVEFISH
0x1002:0x73FF 0x1462:0x1313 0xC3).
[ 1.301219] amdgpu 0000:03:00.0: amdgpu: Trusted Memory Zone (TMZ)
feature not supported
[ 1.301226] [drm] register mmio base: 0xFCA00000
[ 1.301226] [drm] register mmio size: 1048576
[ 1.302103] ACPI: battery: Slot [BAT1] (battery present)
[ 1.302911] [drm] add ip block number 0 <nv_common>
[ 1.302914] [drm] add ip block number 1 <gmc_v10_0>
[ 1.302914] [drm] add ip block number 2 <navi10_ih>
[ 1.302915] [drm] add ip block number 3 <psp>
[ 1.302915] [drm] add ip block number 4 <smu>
[ 1.302916] [drm] add ip block number 5 <dm>
[ 1.302916] [drm] add ip block number 6 <gfx_v10_0>
[ 1.302917] [drm] add ip block number 7 <sdma_v5_2>
[ 1.302918] [drm] add ip block number 8 <vcn_v3_0>
[ 1.302918] [drm] add ip block number 9 <jpeg_v3_0>
[ 1.302934] amdgpu 0000:03:00.0: amdgpu: ACPI VFCT table present but
broken (too short #2),skipping
[ 1.310441] amdgpu 0000:03:00.0: amdgpu: Fetched VBIOS from ROM BAR
[ 1.310444] amdgpu: ATOM BIOS: SWBRT77181.001
[ 1.310453] [drm] VCN(0) decode is enabled in VM mode
[ 1.310454] [drm] VCN(0) encode is enabled in VM mode
[ 1.310456] [drm] JPEG decode is enabled in VM mode
[ 1.310475] [drm] GPU posting now...
[ 1.310496] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit,
fragment size is 9-bit
[ 1.310500] amdgpu 0000:03:00.0: amdgpu: VRAM: 8176M 0x0000008000000000
- 0x00000081FEFFFFFF (8176M used)
[ 1.310502] amdgpu 0000:03:00.0: amdgpu: GART: 512M 0x0000000000000000
- 0x000000001FFFFFFF
[ 1.310502] amdgpu 0000:03:00.0: amdgpu: AGP: 267894784M
0x0000008400000000 - 0x0000FFFFFFFFFFFF
[ 1.310509] [drm] Detected VRAM RAM=3D8176M, BAR=3D8192M
[ 1.310510] [drm] RAM width 128bits GDDR6
[ 1.310540] [drm] amdgpu: 8176M of VRAM memory ready
[ 1.310541] [drm] amdgpu: 8176M of GTT memory ready.
[ 1.310550] ------------[ cut here ]------------
[ 1.310551] trying to bind memory to uninitialized GART !
[ 1.310556] WARNING: CPU: 9 PID: 252 at
drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c:254 amdgpu_gart_bind+0x2e/0x40
[amdgpu]
[ 1.310659] Modules linked in: amdgpu(+) gpu_sched i2c_algo_bit
drm_ttm_helper hid_sensor_hub ttm hid_generic nvme drm_kms_helper
nvme_core cec xhci_pci t10_pi r8169 rc_core crc32_pclmul crc_t10dif
i2c_hid_acpi realtek xhci_hcd psmouse crc32c_intel crct10dif_generic
i2c_hid amd_sfh mdio_devres crct10dif_pclmul drm i2c_piix4 usbcore
libphy crct10dif_common wmi button battery video fjes(-) hid
[ 1.310672] CPU: 9 PID: 252 Comm: systemd-udevd Not tainted 5.13.0+ #4
[ 1.310673] Hardware name: Micro-Star International Co., Ltd. Alpha 15
B5EEK/MS-158L, BIOS E158LAMS.107 11/10/2021
[ 1.310674] RIP: 0010:amdgpu_gart_bind+0x2e/0x40 [amdgpu]
[ 1.310762] Code: 00 80 bf 34 25 00 00 00 74 14 4c 8b 8f 20 25 00 00 4d
85 c9 74 05 e9 01 ff ff ff 31 c0 c3 48 c7 c7 68 36 dd c0 e8 86 db 19 e8
<0f> 0b b8 ea ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00
[ 1.310763] RSP: 0018:ffffb19d00c33920 EFLAGS: 00010282
[ 1.310764] RAX: 0000000000000000 RBX: 0000000000000067 RCX:
ffffffffa9abb208
[ 1.310765] RDX: 0000000000000000 RSI: 00000000ffffefff RDI:
ffffffffa9a63200
[ 1.310766] RBP: ffff985ce2a796c0 R08: 0000000000000000 R09:
ffffb19d00c33748
[ 1.310766] R10: ffffb19d00c33740 R11: ffffffffa9ad3248 R12:
0000000000000000
[ 1.310766] R13: ffff985cd45a0000 R14: ffff985cd45a0000 R15:
0000000000000000
[ 1.310767] FS: 00007f69fabdc8c0(0000) GS:ffff985f9e640000(0000)
knlGS:0000000000000000
[ 1.310768] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1.310768] CR2: 00007f69fabc5dca CR3: 00000001139ec000 CR4:
0000000000750ee0
[ 1.310769] PKRU: 55555554
[ 1.310770] Call Trace:
[ 1.310772] amdgpu_ttm_gart_bind+0x79/0xc0 [amdgpu]
[ 1.310858] amdgpu_ttm_alloc_gart+0x146/0x1a0 [amdgpu]
[ 1.310942] amdgpu_bo_create_reserved.part.0+0xf8/0x1b0 [amdgpu]
[ 1.311025] ? amdgpu_ttm_debugfs_init+0x110/0x110 [amdgpu]
[ 1.311145] amdgpu_bo_create_kernel+0x3b/0xa0 [amdgpu]
[ 1.311229] amdgpu_ttm_init.cold+0x165/0x17f [amdgpu]
[ 1.311349] gmc_v10_0_sw_init+0x2dc/0x430 [amdgpu]
[ 1.311455] amdgpu_device_init.cold+0x1544/0x1b54 [amdgpu]
[ 1.311570] ? acpi_ns_get_node+0x4f/0x5a
[ 1.311574] ? acpi_get_handle+0x8e/0xb7
[ 1.311576] amdgpu_driver_load_kms+0x67/0x320 [amdgpu]
[ 1.311664] amdgpu_pci_probe+0x1bc/0x290 [amdgpu]
[ 1.311750] local_pci_probe+0x42/0x80
[ 1.311753] ? __cond_resched+0x16/0x40
[ 1.311755] pci_device_probe+0xfd/0x1b0
[ 1.311756] really_probe+0xf2/0x460
[ 1.311759] driver_probe_device+0xe8/0x160
[ 1.311760] device_driver_attach+0xa1/0xb0
[ 1.311761] __driver_attach+0x8f/0x150
[ 1.311763] ? device_driver_attach+0xb0/0xb0
[ 1.311764] ? device_driver_attach+0xb0/0xb0
[ 1.311765] bus_for_each_dev+0x78/0xc0
[ 1.311766] bus_add_driver+0x12b/0x1e0
[ 1.311768] driver_register+0x8f/0xe0
[ 1.311769] ? 0xffffffffc1828000
[ 1.311770] do_one_initcall+0x44/0x1d0
[ 1.311772] ? kmem_cache_alloc_trace+0x103/0x240
[ 1.311775] do_init_module+0x5c/0x270
[ 1.311777] __do_sys_finit_module+0xb1/0x110
[ 1.311779] do_syscall_64+0x40/0xb0
[ 1.311781] entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 1.311783] RIP: 0033:0x7f69fb094679
[ 1.311785] Code: 48 8d 3d 9a a1 0c 00 0f 05 eb a5 66 0f 1f 44 00 00 48
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05
<48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c7 57 0c 00 f7 d8 64 89 01 48
[ 1.311786] RSP: 002b:00007ffce4131708 EFLAGS: 00000246 ORIG_RAX:
0000000000000139
[ 1.311788] RAX: ffffffffffffffda RBX: 000055d71350a3a0 RCX:
00007f69fb094679
[ 1.311788] RDX: 0000000000000000 RSI: 00007f69fb234eed RDI:
0000000000000013
[ 1.311789] RBP: 0000000000020000 R08: 0000000000000000 R09:
000055d7134f3930
[ 1.311789] R10: 0000000000000013 R11: 0000000000000246 R12:
00007f69fb234eed
[ 1.311790] R13: 0000000000000000 R14: 000055d7134da0f0 R15:
000055d71350a3a0
[ 1.311791] ---[ end trace ff47998e3140e95d ]---
[ 1.311793] [drm:amdgpu_ttm_gart_bind [amdgpu]] *ERROR* failed to bind
1 pages at 0x00400000
[ 1.312100] amdgpu 0000:03:00.0: amdgpu: 00000000989bdfac bind failed
[ 1.312282] [drm] Debug VRAM access will use slowpath MM access
[ 1.312289] [drm] GART: num cpu pages 131072, num gpu pages 131072
[ 1.312446] [drm] PCIE GART of 512M enabled (table at
0x0000008000000000).
[ 1.312620] amdgpu 0000:03:00.0: amdgpu: PSP runtime database doesn't
exist
[ 1.348721] input: PNP0C50:0e 06CB:7E7E Mouse as
/devices/platform/AMDI0010:03/i2c-0/i2c-
PNP0C50:0e/0018:06CB:7E7E.0005/input/input7
[ 1.348845] input: PNP0C50:0e 06CB:7E7E Touchpad as
/devices/platform/AMDI0010:03/i2c-0/i2c-
PNP0C50:0e/0018:06CB:7E7E.0005/input/input8
[ 1.349016] hid-generic 0018:06CB:7E7E.0005: input,hidraw0: I2C HID
v1.00 Mouse [PNP0C50:0e 06CB:7E7E] on i2c-PNP0C50:0e
[ 1.410629] tsc: Refined TSC clocksource calibration: 3199.354 MHz
[ 1.410655] clocksource: tsc: mask: 0xffffffffffffffff max_cycles:
0x2e1de77b28d, max_idle_ns: 440795251477 ns
[ 3.646325] clocksource: Switched to clocksource tsc
[ 3.646330] usb 1-4: new high-speed USB device number 2 using xhci_hcd
[ 3.646375] usb 3-3: new high-speed USB device number 2 using xhci_hcd
[ 3.646972] amdgpu 0000:03:00.0: amdgpu: STB initialized to 2048
entries
[ 3.647065] [drm] Loading DMUB firmware via PSP: version=3D0x02020007
[ 3.648404] [drm] use_doorbell being set to: [true]
[ 3.648446] [drm] use_doorbell being set to: [true]
[ 3.648579] [drm] Found VCN firmware Version ENC: 1.16 DEC: 2 VEP: 0
Revision: 1
[ 3.648609] amdgpu 0000:03:00.0: amdgpu: Will use PSP to load VCN
firmware
[ 3.806080] usb 1-4: New USB device found, idVendor=3D30c9,
idProduct=3D0042, bcdDevice=3D 0.03
[ 3.806085] usb 1-4: New USB device strings: Mfr=3D1, Product=3D2,
SerialNumber=3D3
[ 3.806087] usb 1-4: Product: Integrated Camera
[ 3.806088] usb 1-4: Manufacturer: S1F0009330LB620L420004LP
[ 3.806089] usb 1-4: SerialNumber: SunplusIT Inc
[ 3.806450] [drm] reserve 0xa00000 from 0x81fe000000 for PSP TMR
[ 3.876378] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras ta ucode is
not available
[ 3.877920] usb 3-3: New USB device found, idVendor=3D0e8d,
idProduct=3D0608, bcdDevice=3D 1.00
[ 3.877923] usb 3-3: New USB device strings: Mfr=3D5, Product=3D6,
SerialNumber=3D7
[ 3.877924] usb 3-3: Product: Wireless_Device
[ 3.877925] usb 3-3: Manufacturer: MediaTek Inc.
[ 3.877926] usb 3-3: SerialNumber: 000000000
[ 3.885409] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: securedisplay
ta ucode is not available
[ 3.885436] amdgpu 0000:03:00.0: amdgpu: smu driver if version =3D
0x0000000f, smu fw if version =3D 0x00000013, smu fw version =3D 0x003b250=
0
(59.37.0)
[ 3.885438] amdgpu 0000:03:00.0: amdgpu: SMU driver if version not
matched
[ 3.885442] amdgpu 0000:03:00.0: amdgpu: use vbios provided pptable
[ 3.935690] amdgpu 0000:03:00.0: amdgpu: SMU is initialized
successfully!
[ 3.935896] [drm] Display Core initialized with v3.2.169!
[ 3.937049] [drm] DMUB hardware initialized: version=3D0x02020007
[ 3.958940] [drm] kiq ring mec 2 pipe 1 q 0
[ 3.961978] [drm] VCN decode and encode initialized successfully(under
DPG Mode).
[ 3.962658] [drm] JPEG decode initialized successfully.
[ 3.963606] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[ 3.964176] amdgpu: SRAT table not found
[ 3.964178] amdgpu: Virtual CRAT table created for GPU
[ 3.964250] amdgpu: Topology: Add dGPU node [0x73ff:0x1002]
[ 3.964252] kfd kfd: amdgpu: added device 1002:73ff
[ 3.964270] amdgpu 0000:03:00.0: amdgpu: SE 2, SH per SE 2, CU per SH
8, active_cu_number 28
[ 3.964335] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng
0 on hub 0
[ 3.964337] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv
eng 1 on hub 0
[ 3.964337] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv
eng 4 on hub 0
[ 3.964338] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM inv
eng 5 on hub 0
[ 3.964338] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM inv
eng 6 on hub 0
[ 3.964339] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv
eng 7 on hub 0
[ 3.964339] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv
eng 8 on hub 0
[ 3.964340] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM inv
eng 9 on hub 0
[ 3.964340] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM inv
eng 10 on hub 0
[ 3.964341] amdgpu 0000:03:00.0: amdgpu: ring kiq_2.1.0 uses VM inv eng
11 on hub 0
[ 3.964342] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 12
on hub 0
[ 3.964342] amdgpu 0000:03:00.0: amdgpu: ring sdma1 uses VM inv eng 13
on hub 0
[ 3.964343] amdgpu 0000:03:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng
0 on hub 1
[ 3.964343] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv
eng 1 on hub 1
[ 3.964344] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv
eng 4 on hub 1
[ 3.964345] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM inv eng
5 on hub 1
[ 3.964776] amdgpu 0000:03:00.0: amdgpu: Using BOCO for runtime pm
[ 3.971954] [drm] Initialized amdgpu 3.44.0 20150101 for 0000:03:00.0
on minor 0
[ 3.974863] amdgpu 0000:03:00.0: [drm] Cannot find any crtc or sizes
[ 3.975073] checking generic (fe20000000 300000) vs hw (fe20000000
10000000)
[ 3.975078] checking generic (fe20000000 300000) vs hw (fe20000000
10000000)
[ 3.975079] fb0: switching to amdgpudrmfb from EFI VGA
[ 3.975153] Console: switching to colour dummy device 80x25
[ 3.975180] amdgpu 0000:08:00.0: vgaarb: deactivate vga console
[ 3.975197] amdgpu 0000:08:00.0: enabling device (0006 -> 0007)
[ 3.975255] [drm] initializing kernel modesetting (RENOIR 0x1002:0x1638
0x1462:0x1313 0xC5).
[ 3.975258] amdgpu 0000:08:00.0: amdgpu: Trusted Memory Zone (TMZ)
feature enabled
[ 3.975305] [drm] register mmio base: 0xFC900000
[ 3.975307] [drm] register mmio size: 524288
[ 3.976335] [drm] add ip block number 0 <soc15_common>
[ 3.976336] [drm] add ip block number 1 <gmc_v9_0>
[ 3.976337] [drm] add ip block number 2 <vega10_ih>
[ 3.976337] [drm] add ip block number 3 <psp>
[ 3.976338] [drm] add ip block number 4 <smu>
[ 3.976338] [drm] add ip block number 5 <dm>
[ 3.976339] [drm] add ip block number 6 <gfx_v9_0>
[ 3.976340] [drm] add ip block number 7 <sdma_v4_0>
[ 3.976340] [drm] add ip block number 8 <vcn_v2_0>
[ 3.976341] [drm] add ip block number 9 <jpeg_v2_0>
[ 3.976350] amdgpu 0000:08:00.0: amdgpu: Fetched VBIOS from VFCT
[ 3.976352] amdgpu: ATOM BIOS: 113-CEZANNE-018
[ 3.976381] [drm] VCN decode is enabled in VM mode
[ 3.976382] [drm] VCN encode is enabled in VM mode
[ 3.976382] [drm] JPEG decode is enabled in VM mode
[ 3.976383] amdgpu 0000:08:00.0: amdgpu: PCIE atomic ops is not
supported
[ 3.976402] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit,
fragment size is 9-bit
[ 3.976406] amdgpu 0000:08:00.0: amdgpu: VRAM: 512M 0x000000F400000000
- 0x000000F41FFFFFFF (512M used)
[ 3.976408] amdgpu 0000:08:00.0: amdgpu: GART: 1024M 0x0000000000000000
- 0x000000003FFFFFFF
[ 3.976409] amdgpu 0000:08:00.0: amdgpu: AGP: 267419648M
0x000000F800000000 - 0x0000FFFFFFFFFFFF
[ 3.976413] [drm] Detected VRAM RAM=3D512M, BAR=3D512M
[ 3.976413] [drm] RAM width 128bits DDR4
[ 3.976431] [drm] amdgpu: 512M of VRAM memory ready
[ 3.976431] [drm] amdgpu: 3072M of GTT memory ready.
[ 3.976437] ------------[ cut here ]------------
[ 3.976438] trying to bind memory to uninitialized GART !
[ 3.976442] WARNING: CPU: 15 PID: 252 at
drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c:254 amdgpu_gart_bind+0x2e/0x40
[amdgpu]
[ 3.976547] Modules linked in: fjes(-) amdgpu(+) gpu_sched i2c_algo_bit
drm_ttm_helper hid_sensor_hub ttm hid_generic nvme drm_kms_helper
nvme_core cec xhci_pci t10_pi r8169 rc_core crc32_pclmul crc_t10dif
i2c_hid_acpi realtek xhci_hcd psmouse crc32c_intel crct10dif_generic
i2c_hid amd_sfh mdio_devres crct10dif_pclmul drm i2c_piix4 usbcore
libphy crct10dif_common wmi button battery video hid
[ 3.976562] CPU: 15 PID: 252 Comm: systemd-udevd Tainted: G W 5.13.0+
#4
[ 3.976564] Hardware name: Micro-Star International Co., Ltd. Alpha 15
B5EEK/MS-158L, BIOS E158LAMS.107 11/10/2021
[ 3.976565] RIP: 0010:amdgpu_gart_bind+0x2e/0x40 [amdgpu]
[ 3.976654] Code: 00 80 bf 34 25 00 00 00 74 14 4c 8b 8f 20 25 00 00 4d
85 c9 74 05 e9 01 ff ff ff 31 c0 c3 48 c7 c7 68 36 dd c0 e8 86 db 19 e8
<0f> 0b b8 ea ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00
[ 3.976655] RSP: 0018:ffffb19d00c33920 EFLAGS: 00010282
[ 3.976656] RAX: 0000000000000000 RBX: 0000000000000067 RCX:
ffffffffa9abb208
[ 3.976656] RDX: 0000000000000000 RSI: 00000000ffffefff RDI:
ffffffffa9a63200
[ 3.976657] RBP: ffff985ce2ee2240 R08: 0000000000000000 R09:
ffffb19d00c33748
[ 3.976657] R10: ffffb19d00c33740 R11: ffffffffa9ad3248 R12:
0000000000000000
[ 3.976658] R13: ffff985ce28c0000 R14: ffff985ce28c0000 R15:
0000000000000000
[ 3.976659] FS: 00007f69fabdc8c0(0000) GS:ffff985f9e7c0000(0000)
knlGS:0000000000000000
[ 3.976659] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3.976660] CR2: 00007f69fb15e480 CR3: 00000001139ec000 CR4:
0000000000750ee0
[ 3.976660] PKRU: 55555554
[ 3.976661] Call Trace:
[ 3.976663] amdgpu_ttm_gart_bind+0x79/0xc0 [amdgpu]
[ 3.976751] amdgpu_ttm_alloc_gart+0x146/0x1a0 [amdgpu]
[ 3.976834] amdgpu_bo_create_reserved.part.0+0xf8/0x1b0 [amdgpu]
[ 3.976916] ? amdgpu_ttm_debugfs_init+0x110/0x110 [amdgpu]
[ 3.976996] amdgpu_bo_create_kernel+0x3b/0xa0 [amdgpu]
[ 3.977075] amdgpu_ttm_init.cold+0x165/0x17f [amdgpu]
[ 3.977192] gmc_v9_0_sw_init+0x388/0x6a0 [amdgpu]
[ 3.977286] amdgpu_device_init.cold+0x1544/0x1b54 [amdgpu]
[ 3.977397] ? pci_bus_read_config_word+0x49/0x70
[ 3.977400] amdgpu_driver_load_kms+0x67/0x320 [amdgpu]
[ 3.977486] amdgpu_pci_probe+0x1bc/0x290 [amdgpu]
[ 3.977568] local_pci_probe+0x42/0x80
[ 3.977571] ? __cond_resched+0x16/0x40
[ 3.977573] pci_device_probe+0xfd/0x1b0
[ 3.977574] really_probe+0xf2/0x460
[ 3.977576] driver_probe_device+0xe8/0x160
[ 3.977578] device_driver_attach+0xa1/0xb0
[ 3.977579] __driver_attach+0x8f/0x150
[ 3.977580] ? device_driver_attach+0xb0/0xb0
[ 3.977581] ? device_driver_attach+0xb0/0xb0
[ 3.977582] bus_for_each_dev+0x78/0xc0
[ 3.977584] bus_add_driver+0x12b/0x1e0
[ 3.977585] driver_register+0x8f/0xe0
[ 3.977586] ? 0xffffffffc1828000
[ 3.977587] do_one_initcall+0x44/0x1d0
[ 3.977589] ? kmem_cache_alloc_trace+0x103/0x240
[ 3.977592] do_init_module+0x5c/0x270
[ 3.977594] __do_sys_finit_module+0xb1/0x110
[ 3.977596] do_syscall_64+0x40/0xb0
[ 3.977598] entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 3.977600] RIP: 0033:0x7f69fb094679
[ 3.977601] Code: 48 8d 3d 9a a1 0c 00 0f 05 eb a5 66 0f 1f 44 00 00 48
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05
<48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c7 57 0c 00 f7 d8 64 89 01 48
[ 3.977602] RSP: 002b:00007ffce4131708 EFLAGS: 00000246 ORIG_RAX:
0000000000000139
[ 3.977603] RAX: ffffffffffffffda RBX: 000055d71350a3a0 RCX:
00007f69fb094679
[ 3.977604] RDX: 0000000000000000 RSI: 00007f69fb234eed RDI:
0000000000000013
[ 3.977604] RBP: 0000000000020000 R08: 0000000000000000 R09:
000055d7134f3930
[ 3.977605] R10: 0000000000000013 R11: 0000000000000246 R12:
00007f69fb234eed
[ 3.977605] R13: 0000000000000000 R14: 000055d7134da0f0 R15:
000055d71350a3a0
[ 3.977606] ---[ end trace ff47998e3140e95e ]---
[ 3.977607] [drm:amdgpu_ttm_gart_bind [amdgpu]] *ERROR* failed to bind
1 pages at 0x00400000
[ 3.977693] amdgpu 0000:08:00.0: amdgpu: 000000002574478a bind failed
[ 3.977698] [drm] Debug VRAM access will use slowpath MM access
[ 3.977699] [drm] GART: num cpu pages 262144, num gpu pages 262144
[ 3.977812] [drm] PCIE GART of 1024M enabled.
[ 3.977814] [drm] PTB located at 0x000000F400900000
[ 3.977940] amdgpu 0000:08:00.0: amdgpu: PSP runtime database doesn't
exist
[ 3.977967] [drm] Loading DMUB firmware via PSP: version=3D0x0101001C
[ 3.978772] [drm] Found VCN firmware Version ENC: 1.16 DEC: 5 VEP: 0
Revision: 3
[ 3.978777] amdgpu 0000:08:00.0: amdgpu: Will use PSP to load VCN
firmware
[ 4.014217] usb 3-4: new full-speed USB device number 3 using xhci_hcd
[ 4.202151] usb 3-4: New USB device found, idVendor=3D1462,
idProduct=3D1563, bcdDevice=3D 2.00
[ 4.202155] usb 3-4: New USB device strings: Mfr=3D1, Product=3D2,
SerialNumber=3D3
[ 4.202156] usb 3-4: Product: MysticLight MS-1563 v0001
[ 4.202157] usb 3-4: Manufacturer: MSI
[ 4.202158] usb 3-4: SerialNumber: 2064386A5430
[ 4.690677] hid-generic 0003:1462:1563.0006: hiddev0,hidraw1: USB HID
v1.11 Device [MSI MysticLight MS-1563 v0001] on usb-0000:08:00.4-
4/input0
[ 4.690711] usbcore: registered new interface driver usbhid
[ 4.690713] usbhid: USB HID core driver
[ 4.697658] [drm] reserve 0x400000 from 0xf41f800000 for PSP TMR
[ 4.782953] amdgpu 0000:08:00.0: amdgpu: RAS: optional ras ta ucode is
not available
[ 4.791781] amdgpu 0000:08:00.0: amdgpu: RAP: optional rap ta ucode is
not available
[ 4.791784] amdgpu 0000:08:00.0: amdgpu: SECUREDISPLAY: securedisplay
ta ucode is not available
[ 4.792337] amdgpu 0000:08:00.0: amdgpu: SMU is initialized
successfully!
[ 4.793287] [drm] Display Core initialized with v3.2.169!
[ 4.793826] [drm] DMUB hardware initialized: version=3D0x0101001C
[ 4.938830] [drm] kiq ring mec 2 pipe 1 q 0
[ 4.942374] [drm] VCN decode and encode initialized successfully(under
DPG Mode).
[ 4.942398] [drm] JPEG decode initialized successfully.
[ 4.943492] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[ 4.943694] amdgpu: SRAT table not found
[ 4.943696] amdgpu: Virtual CRAT table created for GPU
[ 4.944237] amdgpu: Topology: Add dGPU node [0x1638:0x1002]
[ 4.944248] kfd kfd: amdgpu: added device 1002:1638
[ 4.944323] amdgpu 0000:08:00.0: amdgpu: SE 1, SH per SE 1, CU per SH
8, active_cu_number 8
[ 4.945180] amdgpu 0000:08:00.0: amdgpu: ring gfx uses VM inv eng 0 on
hub 0
[ 4.945182] amdgpu 0000:08:00.0: amdgpu: ring comp_1.0.0 uses VM inv
eng 1 on hub 0
[ 4.945183] amdgpu 0000:08:00.0: amdgpu: ring comp_1.1.0 uses VM inv
eng 4 on hub 0
[ 4.945184] amdgpu 0000:08:00.0: amdgpu: ring comp_1.2.0 uses VM inv
eng 5 on hub 0
[ 4.945184] amdgpu 0000:08:00.0: amdgpu: ring comp_1.3.0 uses VM inv
eng 6 on hub 0
[ 4.945185] amdgpu 0000:08:00.0: amdgpu: ring comp_1.0.1 uses VM inv
eng 7 on hub 0
[ 4.945186] amdgpu 0000:08:00.0: amdgpu: ring comp_1.1.1 uses VM inv
eng 8 on hub 0
[ 4.945186] amdgpu 0000:08:00.0: amdgpu: ring comp_1.2.1 uses VM inv
eng 9 on hub 0
[ 4.945187] amdgpu 0000:08:00.0: amdgpu: ring comp_1.3.1 uses VM inv
eng 10 on hub 0
[ 4.945188] amdgpu 0000:08:00.0: amdgpu: ring kiq_2.1.0 uses VM inv eng
11 on hub 0
[ 4.945189] amdgpu 0000:08:00.0: amdgpu: ring sdma0 uses VM inv eng 0
on hub 1
[ 4.945189] amdgpu 0000:08:00.0: amdgpu: ring vcn_dec uses VM inv eng 1
on hub 1
[ 4.945190] amdgpu 0000:08:00.0: amdgpu: ring vcn_enc0 uses VM inv eng
4 on hub 1
[ 4.945191] amdgpu 0000:08:00.0: amdgpu: ring vcn_enc1 uses VM inv eng
5 on hub 1
[ 4.945191] amdgpu 0000:08:00.0: amdgpu: ring jpeg_dec uses VM inv eng
6 on hub 1
[ 4.946254] [drm] Initialized amdgpu 3.44.0 20150101 for 0000:08:00.0
on minor 1
[ 4.950674] fbcon: amdgpu (fb0) is primary device
[ 4.977020] Console: switching to colour frame buffer device 240x67
[ 4.985696] amdgpu 0000:08:00.0: [drm] fb0: amdgpu frame buffer device
[ 5.194626] PM: Image not found (code -22)
[ 5.242742] EXT4-fs (nvme1n1p2): mounted filesystem with ordered data
mode. Opts: (null). Quota mode: none.
[ 5.281777] Not activating Mandatory Access Control as /sbin/tomoyo-
init does not exist.
[ 5.362297] systemd[1]: Inserted module 'autofs4'
[ 5.377920] systemd[1]: systemd 250.3-1 running in system mode (+PAM
+AUDIT +SELINUX +APPARMOR +IMA +SMACK +SECCOMP +GCRYPT +GNUTLS -OPENSSL
+ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD
+LIBCRYPTSETUP +LIBFDISK +PCRE2 -PWQUALITY -P11KIT -QRENCODE +BZIP2
+LZ4 +XZ +ZLIB +ZSTD -BPF_FRAMEWORK -XKBCOMMON +UTMP +SYSVINIT default-
hierarchy=3Dunified)
[ 5.394602] systemd[1]: Detected architecture x86-64.
[ 5.395340] systemd[1]: Hostname set to <lisa>.
[ 5.529191] systemd[1]: Queued start job for default target Graphical
Interface.
[ 5.530341] systemd[1]: Created slice Slice /system/getty.
[ 5.530578] systemd[1]: Created slice Slice /system/modprobe.
[ 5.530764] systemd[1]: Created slice Slice /system/systemd-fsck.
[ 5.530854] systemd[1]: Created slice User and Session Slice.
[ 5.530889] systemd[1]: Started Forward Password Requests to Wall
Directory Watch.
[ 5.530987] systemd[1]: Set up automount Arbitrary Executable File
Formats File System Automount Point.
[ 5.531022] systemd[1]: Reached target Local Integrity Protected
Volumes.
[ 5.531034] systemd[1]: Reached target User and Group Name Lookups.
[ 5.531042] systemd[1]: Reached target Remote File Systems.
[ 5.531048] systemd[1]: Reached target Slice Units.
[ 5.531063] systemd[1]: Reached target Local Verity Protected Volumes.
[ 5.531262] systemd[1]: Listening on Syslog Socket.
[ 5.531311] systemd[1]: Listening on fsck to fsckd communication
Socket.
[ 5.531338] systemd[1]: Listening on initctl Compatibility Named Pipe.
[ 5.531408] systemd[1]: Listening on Journal Audit Socket.
[ 5.531447] systemd[1]: Listening on Journal Socket (/dev/log).
[ 5.531492] systemd[1]: Listening on Journal Socket.
[ 5.531677] systemd[1]: Listening on udev Control Socket.
[ 5.531717] systemd[1]: Listening on udev Kernel Socket.
[ 5.532499] systemd[1]: Mounting Huge Pages File System...
[ 5.532833] systemd[1]: Mounting POSIX Message Queue File System...
[ 5.533398] systemd[1]: Mounting Kernel Debug File System...
[ 5.533873] systemd[1]: Mounting Kernel Trace File System...
[ 5.534557] systemd[1]: Starting Set the console keyboard layout...
[ 5.535269] systemd[1]: Starting Create List of Static Device Nodes...
[ 5.535902] systemd[1]: Starting Load Kernel Module configfs...
[ 5.536570] systemd[1]: Starting Load Kernel Module drm...
[ 5.537175] systemd[1]: Starting Load Kernel Module fuse...
[ 5.537236] systemd[1]: File System Check on Root Device was skipped
because of a failed condition check
(ConditionPathExists=3D!/run/initramfs/fsck-root).
[ 5.538776] systemd[1]: Starting Journal Service...
[ 5.540358] systemd[1]: Starting Load Kernel Modules...
[ 5.541252] systemd[1]: Starting Remount Root and Kernel File
Systems...
[ 5.541315] systemd[1]: Repartition Root Disk was skipped because all
trigger condition checks failed.
[ 5.542134] systemd[1]: Starting Coldplug All udev Devices...
[ 5.543151] systemd[1]: Mounted Huge Pages File System.
[ 5.543281] systemd[1]: Mounted POSIX Message Queue File System.
[ 5.543339] systemd[1]: Mounted Kernel Debug File System.
[ 5.543443] systemd[1]: Mounted Kernel Trace File System.
[ 5.543565] systemd[1]: Finished Create List of Static Device Nodes.
[ 5.543996] systemd[1]: modprobe@configfs.service: Deactivated
successfully.
[ 5.544040] fuse: init (API version 7.33)
[ 5.544084] systemd[1]: Finished Load Kernel Module configfs.
[ 5.544330] systemd[1]: modprobe@drm.service: Deactivated successfully.
[ 5.544418] systemd[1]: Finished Load Kernel Module drm.
[ 5.544605] systemd[1]: modprobe@fuse.service: Deactivated
successfully.
[ 5.544688] systemd[1]: Finished Load Kernel Module fuse.
[ 5.545372] systemd[1]: Mounting FUSE Control File System...
[ 5.545991] systemd[1]: Mounting Kernel Configuration File System...
[ 5.547359] systemd[1]: Mounted FUSE Control File System.
[ 5.547458] EXT4-fs (nvme1n1p2): re-mounted. Opts: errors=3Dremount-ro.
Quota mode: none.
[ 5.547957] systemd[1]: Mounted Kernel Configuration File System.
[ 5.548145] systemd[1]: Finished Remount Root and Kernel File Systems.
[ 5.548317] systemd[1]: Platform Persistent Storage Archival was
skipped because of a failed condition check
(ConditionDirectoryNotEmpty=3D/sys/fs/pstore).
[ 5.548938] systemd[1]: Starting Load/Save Random Seed...
[ 5.549517] systemd[1]: Starting Create System Users...
[ 5.557414] systemd[1]: Finished Load/Save Random Seed.
[ 5.557571] systemd[1]: First Boot Complete was skipped because of a
failed condition check (ConditionFirstBoot=3Dyes).
[ 5.560453] IPMI message handler: version 39.2
[ 5.561499] ipmi device interface
[ 5.562392] systemd[1]: Finished Create System Users.
[ 5.562615] systemd[1]: Finished Load Kernel Modules.
[ 5.563147] systemd[1]: Starting Apply Kernel Variables...
[ 5.563684] systemd[1]: Starting Create Static Device Nodes in /dev...
[ 5.573001] systemd[1]: Finished Apply Kernel Variables.
[ 5.575495] systemd[1]: Finished Create Static Device Nodes in /dev.
[ 5.576698] systemd[1]: Starting Rule-based Manager for Device Events
and Files...
[ 5.579570] systemd[1]: Finished Set the console keyboard layout.
[ 5.579678] systemd[1]: Reached target Preparation for Local File
Systems.
[ 5.584927] systemd[1]: Started Journal Service.
[ 5.588849] systemd-journald[414]: Received client request to flush
runtime journal.
[ 5.708454] soc_button_array ACPI0011:00: Unknown button index 0 upage
01 usage c6, ignoring
[ 5.730178] ACPI: AC: AC Adapter [ADP1] (on-line)
[ 5.733341] input: PC Speaker as /devices/platform/pcspkr/input/input10
[ 5.734596] pstore: Using crash dump compression: deflate
[ 5.734605] pstore: Registered efi as persistent store backend
[ 5.735328] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver
[ 5.735402] sp5100-tco sp5100-tco: Using 0xfeb00000 for watchdog MMIO
address
[ 5.735407] sp5100-tco sp5100-tco: Watchdog hardware is disabled
[ 5.740345] ccp 0000:08:00.2: enabling device (0000 -> 0002)
[ 5.740495] ccp 0000:08:00.2: ccp: unable to access the device: you
might be running a broken BIOS.
[ 5.740735] snd_rn_pci_acp3x 0000:08:00.5: enabling device (0000 ->
0002)
[ 5.740791] input: MSI WMI hotkeys as /devices/virtual/input/input11
[ 5.748464] RAPL PMU: API unit is 2^-32 Joules, 1 fixed counters,
163840 ms ovfl timer
[ 5.748466] RAPL PMU: hw unit of domain package 2^-16 Joules
[ 5.750629] ccp 0000:08:00.2: tee enabled
[ 5.750632] ccp 0000:08:00.2: psp enabled
[ 5.755746] cryptd: max_cpu_qlen set to 1000
[ 5.756379] mc: Linux media interface: v0.10
[ 5.762977] AVX2 version of gcm_enc/dec engaged.
[ 5.763013] AES CTR mode by8 optimization enabled
[ 5.763294] videodev: Linux video capture interface: v2.00
[ 5.782974] EXT4-fs (nvme1n1p4): mounted filesystem with ordered data
mode. Opts: (null). Quota mode: none.
[ 5.794358] Adding 16601084k swap on /dev/nvme1n1p3. Priority:-2
extents:1 across:16601084k SSFS
[ 5.871432] alg: No test for ecdh-nist-p192 (ecdh-generic)
[ 5.872621] Error: Driver 'pcspkr' is already registered, aborting...
[ 5.878112] input: gpio-keys as /devices/platform/ACPI0011:00/gpio-
keys.5.auto/input/input12
[ 5.878781] snd_hda_intel 0000:03:00.1: enabling device (0000 -> 0002)
[ 5.878939] snd_hda_intel 0000:03:00.1: Handle vga_switcheroo audio
client
[ 5.878941] snd_hda_intel 0000:03:00.1: Force to non-snoop mode
[ 5.879234] snd_hda_intel 0000:08:00.1: enabling device (0000 -> 0002)
[ 5.879283] snd_hda_intel 0000:08:00.1: Handle vga_switcheroo audio
client
[ 5.879315] snd_hda_intel 0000:08:00.6: enabling device (0000 -> 0002)
[ 5.880003] alg: No test for fips(ansi_cprng) (fips_ansi_cprng)
[ 5.881262] usb 1-4: Found UVC 1.00 device Integrated Camera
(30c9:0042)
[ 5.888616] snd_hda_intel 0000:08:00.1: bound 0000:08:00.0 (ops
amdgpu_dm_audio_component_bind_ops [amdgpu])
[ 5.889891] snd_hda_intel 0000:03:00.1: bound 0000:03:00.0 (ops
amdgpu_dm_audio_component_bind_ops [amdgpu])
[ 5.891079] input: HDA ATI HDMI HDMI/DP,pcm=3D3 as
/devices/pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.1
/sound/card0/input17
[ 5.891136] input: HD-Audio Generic HDMI/DP,pcm=3D3 as
/devices/pci0000:00/0000:00:08.1/0000:08:00.1/sound/card1/input13
[ 5.901700] input: Integrated Camera: Integrated C as
/devices/pci0000:00/0000:00:08.1/0000:08:00.3/usb1/1-4/1-
4:1.0/input/input22
[ 5.903329] input: HDA ATI HDMI HDMI/DP,pcm=3D7 as
/devices/pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.1
/sound/card0/input18
[ 5.903369] input: HDA ATI HDMI HDMI/DP,pcm=3D8 as
/devices/pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.1
/sound/card0/input19
[ 5.903411] input: HD-Audio Generic HDMI/DP,pcm=3D7 as
/devices/pci0000:00/0000:00:08.1/0000:08:00.1/sound/card1/input14
[ 5.903450] usbcore: registered new interface driver uvcvideo
[ 5.903462] input: HDA ATI HDMI HDMI/DP,pcm=3D9 as
/devices/pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.1
/sound/card0/input20
[ 5.903493] input: HDA ATI HDMI HDMI/DP,pcm=3D10 as
/devices/pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.1
/sound/card0/input21
[ 5.903522] input: HD-Audio Generic HDMI/DP,pcm=3D8 as
/devices/pci0000:00/0000:00:08.1/0000:08:00.1/sound/card1/input15
[ 5.903565] input: HD-Audio Generic HDMI/DP,pcm=3D9 as
/devices/pci0000:00/0000:00:08.1/0000:08:00.1/sound/card1/input16
[ 5.910862] input: PNP0C50:0e 06CB:7E7E Mouse as
/devices/platform/AMDI0010:03/i2c-0/i2c-
PNP0C50:0e/0018:06CB:7E7E.0005/input/input23
[ 5.910982] input: PNP0C50:0e 06CB:7E7E Touchpad as
/devices/platform/AMDI0010:03/i2c-0/i2c-
PNP0C50:0e/0018:06CB:7E7E.0005/input/input24
[ 5.911102] hid-multitouch 0018:06CB:7E7E.0005: input,hidraw0: I2C HID
v1.00 Mouse [PNP0C50:0e 06CB:7E7E] on i2c-PNP0C50:0e
[ 5.967465] snd_hda_codec_realtek hdaudioC2D0: autoconfig for ALC233:
line_outs=3D1 (0x14/0x0/0x0/0x0/0x0) type:speaker
[ 5.967469] snd_hda_codec_realtek hdaudioC2D0: speaker_outs=3D0
(0x0/0x0/0x0/0x0/0x0)
[ 5.967470] snd_hda_codec_realtek hdaudioC2D0: hp_outs=3D1
(0x21/0x0/0x0/0x0/0x0)
[ 5.967471] snd_hda_codec_realtek hdaudioC2D0: mono: mono_out=3D0x0
[ 5.967472] snd_hda_codec_realtek hdaudioC2D0: inputs:
[ 5.967473] snd_hda_codec_realtek hdaudioC2D0: Mic=3D0x19
[ 6.051390] input: HD-Audio Generic Mic as
/devices/pci0000:00/0000:00:08.1/0000:08:00.6/sound/card2/input26
[ 6.051437] input: HD-Audio Generic Headphone as
/devices/pci0000:00/0000:00:08.1/0000:08:00.6/sound/card2/input27
[ 6.056679] kvm: Nested Virtualization enabled
[ 6.056682] SVM: kvm: Nested Paging enabled
[ 6.056690] SVM: Virtual VMLOAD VMSAVE supported
[ 6.056691] SVM: Virtual GIF supported
[ 6.063915] MCE: In-kernel MCE decoding enabled.
[ 6.069935] Bluetooth: Core ver 2.22
[ 6.069958] NET: Registered protocol family 31
[ 6.069959] Bluetooth: HCI device and connection manager initialized
[ 6.069962] Bluetooth: HCI socket layer initialized
[ 6.069964] Bluetooth: L2CAP socket layer initialized
[ 6.069966] Bluetooth: SCO socket layer initialized
[ 6.075974] usbcore: registered new interface driver btusb
[ 6.082581] acp_pdm_mach acp_pdm_mach.0: snd_soc_register_card(acp)
failed: -517
[ 6.207665] intel_rapl_common: Found RAPL domain package
[ 6.207668] intel_rapl_common: Found RAPL domain core
[ 6.223619] Bluetooth: hci0: Device setup in 144153 usecs
[ 7.618157] EXT4-fs (nvme0n1p1): mounted filesystem with ordered data
mode. Opts: (null). Quota mode: none.
[ 7.647166] audit: type=3D1400 audit(1642627612.675:2): apparmor=3D"STATUS=
"
operation=3D"profile_load" profile=3D"unconfined" name=3D"libreoffice-
xpdfimport" pid=3D739 comm=3D"apparmor_parser"
[ 7.647191] audit: type=3D1400 audit(1642627612.675:3): apparmor=3D"STATUS=
"
operation=3D"profile_load" profile=3D"unconfined" name=3D"libreoffice-
senddoc" pid=3D737 comm=3D"apparmor_parser"
[ 7.647233] audit: type=3D1400 audit(1642627612.675:4): apparmor=3D"STATUS=
"
operation=3D"profile_load" profile=3D"unconfined" name=3D"lsb_release"
pid=3D732 comm=3D"apparmor_parser"
[ 7.647474] audit: type=3D1400 audit(1642627612.675:5): apparmor=3D"STATUS=
"
operation=3D"profile_load" profile=3D"unconfined" name=3D"libreoffice-
oosplash" pid=3D736 comm=3D"apparmor_parser"
[ 7.647744] audit: type=3D1400 audit(1642627612.675:6): apparmor=3D"STATUS=
"
operation=3D"profile_load" profile=3D"unconfined" name=3D"nvidia_modprobe"
pid=3D733 comm=3D"apparmor_parser"
[ 7.647758] audit: type=3D1400 audit(1642627612.675:7): apparmor=3D"STATUS=
"
operation=3D"profile_load" profile=3D"unconfined"
name=3D"nvidia_modprobe//kmod" pid=3D733 comm=3D"apparmor_parser"
[ 7.647792] audit: type=3D1400 audit(1642627612.675:8): apparmor=3D"STATUS=
"
operation=3D"profile_load" profile=3D"unconfined" name=3D"/usr/bin/man"
pid=3D735 comm=3D"apparmor_parser"
[ 7.647794] audit: type=3D1400 audit(1642627612.675:9): apparmor=3D"STATUS=
"
operation=3D"profile_load" profile=3D"unconfined" name=3D"man_filter" pid=
=3D735
comm=3D"apparmor_parser"
[ 7.647796] audit: type=3D1400 audit(1642627612.675:10):
apparmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined"
name=3D"man_groff" pid=3D735 comm=3D"apparmor_parser"
[ 7.690089] audit: type=3D1400 audit(1642627612.715:11):
apparmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined"
name=3D"/usr/bin/evince" pid=3D734 comm=3D"apparmor_parser"
[ 7.894263] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[ 7.894265] Bluetooth: BNEP filters: protocol multicast
[ 7.894267] Bluetooth: BNEP socket layer initialized
[ 7.896828] NET: Registered protocol family 38
[ 7.998238] Generic FE-GE Realtek PHY r8169-500:00: attached PHY driver
(mii_bus:phy_addr=3Dr8169-500:00, irq=3DMAC)
[ 8.207607] r8169 0000:05:00.0 enp5s0: Link is Down
[ 8.465983] Bluetooth: RFCOMM TTY layer initialized
[ 8.465990] Bluetooth: RFCOMM socket layer initialized
[ 8.465994] Bluetooth: RFCOMM ver 1.11
[ 9.943306] rfkill: input handler disabled
[ 16.249503] [drm] free PSP TMR buffer
[ 17.041800] rfkill: input handler enabled
[ 17.434947] [drm] PCIE GART of 512M enabled (table at
0x0000008000000000).
[ 17.434975] [drm] PSP is resuming...
[ 17.605566] [drm] reserve 0xa00000 from 0x81fe000000 for PSP TMR
[ 17.676841] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras ta ucode is
not available
[ 17.685933] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: securedisplay
ta ucode is not available
[ 17.685940] amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
[ 17.685946] amdgpu 0000:03:00.0: amdgpu: smu driver if version =3D
0x0000000f, smu fw if version =3D 0x00000013, smu fw version =3D 0x003b250=
0
(59.37.0)
[ 17.685952] amdgpu 0000:03:00.0: amdgpu: SMU driver if version not
matched
[ 17.736212] amdgpu 0000:03:00.0: amdgpu: SMU is resumed successfully!
[ 17.737407] [drm] DMUB hardware initialized: version=3D0x02020007
[ 17.776779] [drm] kiq ring mec 2 pipe 1 q 0
[ 17.780869] [drm] VCN decode and encode initialized successfully(under
DPG Mode).
[ 17.781560] [drm] JPEG decode initialized successfully.
[ 17.781578] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses VM inv
eng 0 on hub 0
[ 17.781580] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv
eng 1 on hub 0
[ 17.781581] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv
eng 4 on hub 0
[ 17.781582] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM inv
eng 5 on hub 0
[ 17.781582] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM inv
eng 6 on hub 0
[ 17.781583] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv
eng 7 on hub 0
[ 17.781583] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv
eng 8 on hub 0
[ 17.781584] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM inv
eng 9 on hub 0
[ 17.781584] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM inv
eng 10 on hub 0
[ 17.781585] amdgpu 0000:03:00.0: amdgpu: ring kiq_2.1.0 uses VM inv
eng 11 on hub 0
[ 17.781586] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 12
on hub 0
[ 17.781586] amdgpu 0000:03:00.0: amdgpu: ring sdma1 uses VM inv eng 13
on hub 0
[ 17.781587] amdgpu 0000:03:00.0: amdgpu: ring vcn_dec_0 uses VM inv
eng 0 on hub 1
[ 17.781587] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv
eng 1 on hub 1
[ 17.781588] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv
eng 4 on hub 1
[ 17.781588] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM inv eng
5 on hub 1
[ 17.784817] amdgpu 0000:03:00.0: [drm] Cannot find any crtc or sizes
[ 17.784823] amdgpu 0000:03:00.0: [drm] Cannot find any crtc or sizes
[ 19.403506] rfkill: input handler disabled
[ 26.349732] [drm] free PSP TMR buffer

