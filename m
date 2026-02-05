Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092A6EC1EBF
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 14:01:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3241A10E8B9;
	Thu,  5 Feb 2026 14:01:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SXtXe/Oo";
	dkim-atps=neutral
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com
 [74.125.224.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E07E310E229
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 06:12:57 +0000 (UTC)
Received: by mail-yx1-f41.google.com with SMTP id
 956f58d0204a3-649ba337157so53498d50.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Feb 2026 22:12:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770271976; cv=none;
 d=google.com; s=arc-20240605;
 b=Ugn2VJUrJSAcEhmphJjsSf1A/ZxLnn4Ab1ROJ+kT6mvOzTGJyxj2hkVN3NCe5qTgeN
 HjDlJpVsaL1s2ozt8ReaLeQxWnlI+lIAGYe8b3XQ7hN562w/PxS9JWcLkvFSy2Y7s3EU
 tqHCHBGPOIcLTKWEFu+O0WKkko8d+tBn+iRIPjhdGXfC0HHbyEI38RFGgux60jiDqYtx
 TSPs9ZnLiV3LCa2+0yttzH4QZleH0Y+MtEfsu3cus30epk2PhlYSJCZGeDqvrcDOCvjx
 HuJNwx1aAYw5DJt9ESJp1dmWY8wTxH6D/9L9GyWhNYI3YqpAE1kNCXzuhKmHlAp9SIcP
 Zv+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=JXLBvcfnmwhrtpMnKC5p6uPW1FT3ie0KOZbGUjH36vU=;
 fh=aEbeo1SK68HH/SEmFhzP5622h69LsKW2mwuhb5YQPQI=;
 b=ldhu0LtMSCFHMeLq3dn0/rHw9ctKVJqqqYiZ1a1auaoI4z9QtwlhzpU0S/RrSwS/KV
 ZmXoMBY2nbZ4TTj1l/yRTv4SoqzcVzv/EIfM/lBflLBIzEAGgnvRCryklfNF3YhvdvjF
 u3pFe8y1u46tg6UjE3UAoJPQtYTXJZPzhtwaYqbk0/kxEVzNUHUKdGzS7VNCsBUKJ1bs
 2a7PfQX/Cr/tD0oU2Yg0t4IQo2gC1hqsxd9ZPzvkz43d3Li5KcKu+yjtFRrKYUm13C4i
 w12J9EjvEGosBXvDJnWY3RTRVmo3dSgLMP7P+Q34nvDqx/JbRFWOOaVKh8ix6E++I1l5
 +0vw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770271976; x=1770876776; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JXLBvcfnmwhrtpMnKC5p6uPW1FT3ie0KOZbGUjH36vU=;
 b=SXtXe/OoVvqvgSymltHEOUPwwVdrBdQ4TLAN59PoAuo2+sJS1UYNqMSJD83BgiudQT
 gUgjucD1uO26t1xpgvV4E4vT4MMyIKmoWLCnn23bBn69uNS58n2NDpHHkZ523k2x7CMO
 OKYjbyfNtbE5Od3H2nPLuDv0c3Ax95WbrjhPY/v/bwumCe4JJvKrWvZfaPxpXB9LLUEG
 czxhpBDMzoQeErmx+EuShwKJGjCrlgxGDT1n8ClmEArFeXSMybSSvmkkmGPj9XbEUEc5
 Qg154ngEi7AG0KOwgrrLuQVgg8WyF7hU/QxolGQTLBLVnFLgXmkO3CWBmIbO8UTMFMmf
 ofXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770271976; x=1770876776;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JXLBvcfnmwhrtpMnKC5p6uPW1FT3ie0KOZbGUjH36vU=;
 b=sVsqHzTA5oLKk1ydTnwPb2Qy5VJu38yfH0TSTHRSX4X7OvXV3KNJn+jqBt2HicRHjL
 uTIymtorGwS5kZtLhN4+HfVruhns6JTRW/PZMySmdAFz+jCSFNlEt+t7S8b7lVcZu96N
 qZKlBVGbU6qSnkCciArytSX/9QYPgWwRVoqXWgdcncXRVgHs74TINiO2+oOOoNHl3btU
 P2acqJIyajGY6YPho0a+nYMeKanB84riraeQOT1YTGYbwUqGURprDSiMoQK+PiQGyAPH
 FLb2hdK7r34MUooTO6nZb66egzKEqfOHjBpJPbzzMsTV8c+dzJdVsD9U6iFMEL42yJ8F
 aoyQ==
X-Gm-Message-State: AOJu0YzyFc5NSFFmcT+CPrHQt8Q7P9W/VMk8v84Fe8/p0XScTaKolZLP
 oCHmBybEHDzHArGArVry3NzKYURsG61uVD2JaAG8gBKs9uf/Grfzcbi7+zIplqB9EJ+ssbF23M2
 fqxeJWaG1ulsPyjR2ZAlHnsunfYzD0Xw=
X-Gm-Gg: AZuq6aLBVZSbfMfwZeHSFJmuag+LPtKiiBXGxD/5CCa6+7faqKFnkrDgCK//G6eJVxT
 eIc1MIODD6PGBna1UGmQyBpWeupB41ZyVYrwVsPhRMz6QGLtju9p52+cSByvCOEfEwmc5S8EE9F
 RhAYe+aFqcaOX3DrNAftyhBFNra25GkHlzDLxrM5R5qxNzCE0ec1/g4bdF+b/WNDuzTt/KAxvty
 JiO971yZxtKKaoXCGsuy2w62kN1LGp4rlN//PUqB++Pr6o/byFbM2LRLj2P+DyMyiXBHp49XYkO
 KHO2uUt7NnEc3JL7xDXPBK0tyWI=
X-Received: by 2002:a05:690e:b8b:b0:649:b31e:8f5a with SMTP id
 956f58d0204a3-649db4bd38amr4070962d50.8.1770271974592; Wed, 04 Feb 2026
 22:12:54 -0800 (PST)
MIME-Version: 1.0
References: <CAKR_QVJBiwDrUiJh5BGS-1tU4n6B-DbpA1ebTa+DF=F5kAzaTA@mail.gmail.com>
 <CADnq5_M4kkqsWnTQVuXVitqZR_UUzgmqZSqVPy+E8sgpbXHb8A@mail.gmail.com>
In-Reply-To: <CADnq5_M4kkqsWnTQVuXVitqZR_UUzgmqZSqVPy+E8sgpbXHb8A@mail.gmail.com>
From: Tom Psyborg <pozega.tomislav@gmail.com>
Date: Thu, 5 Feb 2026 07:12:38 +0100
X-Gm-Features: AZwV_QiqKpfAIt0iUqRk9iiXV0X0uI1P8BEcFm-5DWsbYQbmOHOLirMuf_tJz1E
Message-ID: <CAKR_QVKOYvbKzqWT43x9smSj4M7jJB8Lq6=qhs5rj3R43_Fgyw@mail.gmail.com>
Subject: Re: UVD not responding, kiq_0.2.1.0 test failed on suspend
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/alternative; boundary="000000000000339502064a0d901c"
X-Mailman-Approved-At: Thu, 05 Feb 2026 14:01:18 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--000000000000339502064a0d901c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 4 Feb 2026 at 16:46, Alex Deucher <alexdeucher@gmail.com> wrote:

> On Wed, Feb 4, 2026 at 3:10=E2=80=AFAM Tom Psyborg <pozega.tomislav@gmail=
.com>
> wrote:
> >
> > Hi
> >
> > I try live boot of ubuntu 26.04 snapshot 3 (6.18.0-9) on dell inspiron
> 5576 with RX460 dGPU, everything seems ok, until i try to put system to
> sleep:
> > (sleep/suspend worked fine on ubuntu 22.04 last time i checked and it
> works fine in windows)
>
> Can you bisect or at least narrow down when this broke?
>
> Alex
>
>
>
6.14.0-27-generic (ubuntu mate 24.04) still good

6.15.4-arch2-1 driver crash


[    0.000000] Linux version 6.15.4-arch2-1 (linux@archlinux) (gcc (GCC)
15.1.1 20250425, GNU ld (GNU Binutils) 2.44.0) #1 SMP PREEMPT_DYNAMIC Fri,
27 Jun 2025 16:35:07 +0000
[    0.000000] Command line: BOOT_IMAGE=3D/arch/boot/x86_64/vmlinuz-linux
archisobasedir=3Darch archisosearchuuid=3D2025-07-01-17-34-06-00
initrd=3D/arch/boot/x86_64/initramfs-linux.img
[    0.000000] [Firmware Info]: CPU: Re-enabling disabled Topology
Extensions Support.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009d7ff] usabl=
e
[    0.000000] BIOS-e820: [mem 0x000000000009d800-0x000000000009ffff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff]
reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000cc96efff] usabl=
e
[    0.000000] BIOS-e820: [mem 0x00000000cc96f000-0x00000000cd420fff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000cd421000-0x00000000cd452fff] ACPI
data
[    0.000000] BIOS-e820: [mem 0x00000000cd453000-0x00000000cd8e2fff] ACPI
NVS
[    0.000000] BIOS-e820: [mem 0x00000000cd8e3000-0x00000000cdbe3fff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000cdbe4000-0x00000000ceffffff] usabl=
e
[    0.000000] BIOS-e820: [mem 0x00000000cf000000-0x00000000cfffffff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fe200000-0x00000000fe200fff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fe600000-0x00000000fe6fffff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000feb80000-0x00000000fec01fff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec10000-0x00000000fec10fff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed40000-0x00000000fed44fff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed8ffff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fedc0000-0x00000000fedc0fff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fedc2000-0x00000000fedc8fff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000feefffff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff]
reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x00000003aeffffff] usabl=
e
[    0.000000] BIOS-e820: [mem 0x00000003af000000-0x000000042effffff]
reserved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] SMBIOS 3.0.0 present.
[    0.000000] DMI: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7 01/29/2018
[    0.000000] DMI: Memory slots populated: 2/2
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2999.703 MHz processor
[    0.000869] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.000872] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000883] last_pfn =3D 0x3af000 max_arch_pfn =3D 0x400000000
[    0.000892] total RAM covered: 3312M
[    0.001089] Found optimal setting for mtrr clean up
[    0.001089]  gran_size: 64K chunk_size: 32M num_reg: 4   lose cover RAM:
0G
[    0.001095] MTRR map: 6 entries (3 fixed + 3 variable; max 20), built
from 9 variable MTRRs
[    0.001097] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT

[    0.001312] e820: update [mem 0xcf000000-0xffffffff] usable =3D=3D> rese=
rved
[    0.001322] last_pfn =3D 0xcf000 max_arch_pfn =3D 0x400000000
[    0.005489] found SMP MP-table at [mem 0x000fcbd0-0x000fcbdf]
[    0.005509] Using GB pages for direct mapping
[    0.005830] RAMDISK: [mem 0x766a2000-0x7fffffff]
[    0.006745] ACPI: Early table checksum verification disabled
[    0.006749] ACPI: RSDP 0x00000000000F05B0 000024 (v02 DELL  )
[    0.006753] ACPI: XSDT 0x00000000CD43C090 0000A4 (v01 DELL   QA09
01072009 AMI  00010013)
[    0.006760] ACPI: FACP 0x00000000CD445ED0 00010C (v05 DELL   QA09
01072009 AMI  00010013)
[    0.006765] ACPI BIOS Warning (bug): Optional FADT field Pm2ControlBlock
has valid Length but zero Address: 0x0000000000000000/0x1
(20240827/tbfadt-611)
[    0.006769] ACPI: DSDT 0x00000000CD43C1C8 009D08 (v02 DELL   QA09
01072009 INTL 20120913)
[    0.006773] ACPI: FACS 0x00000000CD8E1CC0 000040
[    0.006775] ACPI: APIC 0x00000000CD445FE0 00007E (v03 DELL   QA09
01072009 AMI  00010013)
[    0.006778] ACPI: FPDT 0x00000000CD446060 000044 (v01 DELL   QA09
01072009 AMI  00010013)
[    0.006781] ACPI: FIDT 0x00000000CD4460A8 00009C (v01 DELL   QA09
01072009 AMI  00010013)
[    0.006784] ACPI: MCFG 0x00000000CD446148 00003C (v01 DELL   QA09
01072009 MSFT 00010013)
[    0.006786] ACPI: BOOT 0x00000000CD446188 000028 (v01 DELL   QA09
01072009 AMI  00010013)
[    0.006789] ACPI: SLIC 0x00000000CD4461B0 000176 (v01 DELL   QA09
01072009 AMI  00010013)
[    0.006791] ACPI: HPET 0x00000000CD446328 000038 (v01 DELL   QA09
01072009 AMI  00000005)
[    0.006794] ACPI: UEFI 0x00000000CD446360 000042 (v01
00000000      00000000)
[    0.006796] ACPI: MSDM 0x00000000CD4463A8 000055 (v03 DELL   QA09
01072009 AMI  00010013)
[    0.006799] ACPI: IVRS 0x00000000CD446400 0000D0 (v02 AMD    AGESA
 00000001 AMD  00000000)
[    0.006801] ACPI: SSDT 0x00000000CD4464D0 00888F (v02 AMD    AGESA
 00000002 MSFT 04000000)
[    0.006804] ACPI: CRAT 0x00000000CD44ED60 0005A0 (v01 AMD    AGESA
 00000001 AMD  00000001)
[    0.006807] ACPI: SSDT 0x00000000CD44F300 001587 (v01 AMD    CPMDFIGP
00000001 INTL 20120913)
[    0.006809] ACPI: SSDT 0x00000000CD450888 000A71 (v01 AMD    CPMDFDGP
00000001 INTL 20120913)
[    0.006812] ACPI: SSDT 0x00000000CD451300 00165E (v01 AMD    CPMCMN
00000001 INTL 20120913)
[    0.006814] ACPI: Reserving FACP table memory at [mem
0xcd445ed0-0xcd445fdb]
[    0.006816] ACPI: Reserving DSDT table memory at [mem
0xcd43c1c8-0xcd445ecf]
[    0.006817] ACPI: Reserving FACS table memory at [mem
0xcd8e1cc0-0xcd8e1cff]
[    0.006818] ACPI: Reserving APIC table memory at [mem
0xcd445fe0-0xcd44605d]
[    0.006819] ACPI: Reserving FPDT table memory at [mem
0xcd446060-0xcd4460a3]
[    0.006820] ACPI: Reserving FIDT table memory at [mem
0xcd4460a8-0xcd446143]
[    0.006820] ACPI: Reserving MCFG table memory at [mem
0xcd446148-0xcd446183]
[    0.006821] ACPI: Reserving BOOT table memory at [mem
0xcd446188-0xcd4461af]
[    0.006822] ACPI: Reserving SLIC table memory at [mem
0xcd4461b0-0xcd446325]
[    0.006823] ACPI: Reserving HPET table memory at [mem
0xcd446328-0xcd44635f]
[    0.006824] ACPI: Reserving UEFI table memory at [mem
0xcd446360-0xcd4463a1]
[    0.006825] ACPI: Reserving MSDM table memory at [mem
0xcd4463a8-0xcd4463fc]
[    0.006826] ACPI: Reserving IVRS table memory at [mem
0xcd446400-0xcd4464cf]
[    0.006827] ACPI: Reserving SSDT table memory at [mem
0xcd4464d0-0xcd44ed5e]
[    0.006828] ACPI: Reserving CRAT table memory at [mem
0xcd44ed60-0xcd44f2ff]
[    0.006828] ACPI: Reserving SSDT table memory at [mem
0xcd44f300-0xcd450886]
[    0.006829] ACPI: Reserving SSDT table memory at [mem
0xcd450888-0xcd4512f8]
[    0.006830] ACPI: Reserving SSDT table memory at [mem
0xcd451300-0xcd45295d]
[    0.006900] No NUMA configuration found
[    0.006901] Faking a node at [mem 0x0000000000000000-0x00000003aeffffff]
[    0.006910] NODE_DATA(0) allocated [mem 0x3aefd5280-0x3aeffffff]
[    0.007154] Zone ranges:
[    0.007155]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.007158]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.007159]   Normal   [mem 0x0000000100000000-0x00000003aeffffff]
[    0.007160]   Device   empty
[    0.007161] Movable zone start for each node
[    0.007163] Early memory node ranges
[    0.007163]   node   0: [mem 0x0000000000001000-0x000000000009cfff]
[    0.007165]   node   0: [mem 0x0000000000100000-0x00000000cc96efff]
[    0.007166]   node   0: [mem 0x00000000cdbe4000-0x00000000ceffffff]
[    0.007167]   node   0: [mem 0x0000000100000000-0x00000003aeffffff]
[    0.007169] Initmem setup node 0 [mem
0x0000000000001000-0x00000003aeffffff]
[    0.007175] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.007204] On node 0, zone DMA: 99 pages in unavailable ranges
[    0.016295] On node 0, zone DMA32: 4725 pages in unavailable ranges
[    0.046733] On node 0, zone Normal: 4096 pages in unavailable ranges
[    0.046780] On node 0, zone Normal: 4096 pages in unavailable ranges
[    0.046889] ACPI: PM-Timer IO Port: 0x808
[    0.046897] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.046907] IOAPIC[0]: apic_id 0, version 33, address 0xfec00000, GSI
0-23
[    0.046910] IOAPIC[1]: apic_id 1, version 33, address 0xfec01000, GSI
24-55
[    0.046913] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.046915] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.046919] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.046920] ACPI: HPET id: 0x10228201 base: 0xfed00000
[    0.046934] CPU topo: Max. logical packages:   1
[    0.046935] CPU topo: Max. logical dies:       1
[    0.046936] CPU topo: Max. dies per package:   1
[    0.046947] CPU topo: Max. threads per core:   1
[    0.046948] CPU topo: Num. cores per package:     4
[    0.046948] CPU topo: Num. threads per package:   4
[    0.046949] CPU topo: Allowing 4 present CPUs plus 0 hotplug CPUs
[    0.046968] PM: hibernation: Registered nosave memory: [mem
0x00000000-0x00000fff]
[    0.046970] PM: hibernation: Registered nosave memory: [mem
0x0009d000-0x000fffff]
[    0.046971] PM: hibernation: Registered nosave memory: [mem
0xcc96f000-0xcdbe3fff]
[    0.046973] PM: hibernation: Registered nosave memory: [mem
0xcf000000-0xffffffff]
[    0.046975] [mem 0xd0000000-0xf7ffffff] available for PCI devices
[    0.046976] Booting paravirtualized kernel on bare hardware
[    0.046979] clocksource: refined-jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.052230] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:4 nr_cpu_ids:4
nr_node_ids:1
[    0.052722] percpu: Embedded 62 pages/cpu s217088 r8192 d28672 u524288
[    0.052728] pcpu-alloc: s217088 r8192 d28672 u524288 alloc=3D1*2097152
[    0.052731] pcpu-alloc: [0] 0 1 2 3
[    0.052749] Kernel command line:
BOOT_IMAGE=3D/arch/boot/x86_64/vmlinuz-linux archisobasedir=3Darch
archisosearchuuid=3D2025-07-01-17-34-06-00
initrd=3D/arch/boot/x86_64/initramfs-linux.img
[    0.052836] Unknown kernel command line parameters
"BOOT_IMAGE=3D/arch/boot/x86_64/vmlinuz-linux archisobasedir=3Darch
archisosearchuuid=3D2025-07-01-17-34-06-00", will be passed to user space.
[    0.052859] random: crng init done
[    0.052860] printk: log buffer data + meta data: 131072 + 458752 =3D
589824 bytes
[    0.055642] Dentry cache hash table entries: 2097152 (order: 12,
16777216 bytes, linear)
[    0.057050] Inode-cache hash table entries: 1048576 (order: 11, 8388608
bytes, linear)
[    0.057128] software IO TLB: area num 4.
[    0.079753] Fallback order for Node 0: 0
[    0.079758] Built 1 zonelists, mobility grouping on.  Total pages:
3656999
[    0.079760] Policy zone: Normal
[    0.080175] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    0.131696] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D4, N=
odes=3D1
[    0.143929] ftrace: allocating 55579 entries in 220 pages
[    0.143933] ftrace: allocated 220 pages with 5 groups
[    0.144049] Dynamic Preempt: full
[    0.144094] rcu: Preemptible hierarchical RCU implementation.
[    0.144096] rcu: RCU restricting CPUs from NR_CPUS=3D8192 to nr_cpu_ids=
=3D4.
[    0.144097] rcu: RCU priority boosting: priority 1 delay 500 ms.
[    0.144098] Trampoline variant of Tasks RCU enabled.
[    0.144099] Rude variant of Tasks RCU enabled.
[    0.144099] Tracing variant of Tasks RCU enabled.
[    0.144100] rcu: RCU calculated value of scheduler-enlistment delay is
100 jiffies.
[    0.144101] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D4
[    0.144108] RCU Tasks: Setting shift to 2 and lim to 1
rcu_task_cb_adjust=3D1 rcu_task_cpu_ids=3D4.
[    0.144111] RCU Tasks Rude: Setting shift to 2 and lim to 1
rcu_task_cb_adjust=3D1 rcu_task_cpu_ids=3D4.
[    0.144112] RCU Tasks Trace: Setting shift to 2 and lim to 1
rcu_task_cb_adjust=3D1 rcu_task_cpu_ids=3D4.
[    0.150599] NR_IRQS: 524544, nr_irqs: 1000, preallocated irqs: 16
[    0.150819] rcu: srcu_init: Setting srcu_struct sizes based on
contention.
[    0.150952] kfence: initialized - using 2097152 bytes for 255 objects at
0x(____ptrval____)-0x(____ptrval____)
[    0.153200] Console: colour VGA+ 80x25
[    0.153204] printk: legacy console [tty0] enabled
[    0.153258] ACPI: Core revision 20240827
[    0.153361] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff,
max_idle_ns: 133484873504 ns
[    0.153377] APIC: Switch to symmetric I/O mode setup
[    0.154200] AMD-Vi: Using global IVHD EFR:0x77ef22294ada, EFR2:0x0
[    0.155173] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    0.159378] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:
0x2b3d2cddc5c, max_idle_ns: 440795280308 ns
[    0.159388] Calibrating delay loop (skipped), value calculated using
timer frequency.. 5999.40 BogoMIPS (lpj=3D2999703)
[    0.159407] BIOS may not properly restore RDRAND after suspend, hiding
RDRAND via CPUID. Use rdrand=3Dforce to reenable.
[    0.159439] LVT offset 1 assigned for vector 0xf9
[    0.159448] Last level iTLB entries: 4KB 512, 2MB 1024, 4MB 512
[    0.159449] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 512, 1GB 0
[    0.159456] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user
pointer sanitization
[    0.159458] Spectre V2 : Mitigation: Retpolines
[    0.159459] Spectre V2 : Spectre v2 / SpectreRSB: Filling RSB on context
switch and VMEXIT
[    0.159460] Spectre V2 : Enabling Speculation Barrier for firmware calls
[    0.159461] RETBleed: Mitigation: untrained return thunk
[    0.159464] Spectre V2 : mitigation: Enabling conditional Indirect
Branch Prediction Barrier
[    0.159465] Speculative Store Bypass: Mitigation: Speculative Store
Bypass disabled via prctl
[    0.159471] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point
registers'
[    0.159473] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.159474] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.159476] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.159477] x86/fpu: Enabled xstate features 0x7, context size is 832
bytes, using 'standard' format.
[    0.189276] Freeing SMP alternatives memory: 52K
[    0.189285] pid_max: default: 32768 minimum: 301
[    0.189333] LSM: initializing lsm=3Dcapability,landlock,lockdown,yama,bp=
f
[    0.189424] landlock: Up and running.
[    0.189427] Yama: becoming mindful.
[    0.189659] LSM support for eBPF active
[    0.189717] Mount-cache hash table entries: 32768 (order: 6, 262144
bytes, linear)
[    0.189751] Mountpoint-cache hash table entries: 32768 (order: 6, 262144
bytes, linear)
[    0.292615] smpboot: CPU0: AMD FX-9830P RADEON R7, 12 COMPUTE CORES
4C+8G (family: 0x15, model: 0x65, stepping: 0x1)
[    0.292888] Performance Events: Fam15h core perfctr, AMD PMU driver.
[    0.292895] ... version:                0
[    0.292896] ... bit width:              48
[    0.292897] ... generic registers:      6
[    0.292898] ... value mask:             0000ffffffffffff
[    0.292899] ... max period:             00007fffffffffff
[    0.292900] ... fixed-purpose events:   0
[    0.292901] ... event mask:             000000000000003f
[    0.293018] signal: max sigframe size: 1776
[    0.293061] rcu: Hierarchical SRCU implementation.
[    0.293063] rcu: Max phase no-delay instances is 400.
[    0.293154] Timer migration: 1 hierarchy levels; 8 children per group; 1
crossnode level
[    0.299483] MCE: In-kernel MCE decoding enabled.
[    0.299592] NMI watchdog: Enabled. Permanently consumes one hw-PMU
counter.
[    0.299662] smp: Bringing up secondary CPUs ...
[    0.299804] smpboot: x86: Booting SMP configuration:
[    0.299806] .... node  #0, CPUs:      #1 #2 #3
[    0.304460] smp: Brought up 1 node, 4 CPUs
[    0.304477] smpboot: Total of 4 processors activated (23997.62 BogoMIPS)
[    0.305320] Memory: 14075928K/14627996K available (19692K kernel code,
2940K rwdata, 16520K rodata, 4632K init, 5036K bss, 538880K reserved, 0K
cma-reserved)
[    0.306469] devtmpfs: initialized
[    0.306500] x86/mm: Memory block size: 128MB
[    0.308422] ACPI: PM: Registering ACPI NVS region [mem
0xcd453000-0xcd8e2fff] (4784128 bytes)
[    0.308547] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.308547] posixtimers hash table entries: 2048 (order: 3, 32768 bytes,
linear)
[    0.308547] futex hash table entries: 1024 (order: 4, 65536 bytes,
linear)
[    0.308607] pinctrl core: initialized pinctrl subsystem
[    0.309425] PM: RTC time: 06:54:35, date: 2026-02-05
[    0.310701] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.311317] DMA: preallocated 2048 KiB GFP_KERNEL pool for atomic
allocations
[    0.311799] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA pool for
atomic allocations
[    0.312191] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA32 pool for
atomic allocations
[    0.312213] audit: initializing netlink subsys (disabled)
[    0.312417] audit: type=3D2000 audit(1770274474.159:1): state=3Dinitiali=
zed
audit_enabled=3D0 res=3D1
[    0.312554] thermal_sys: Registered thermal governor 'fair_share'
[    0.312558] thermal_sys: Registered thermal governor 'bang_bang'
[    0.312560] thermal_sys: Registered thermal governor 'step_wise'
[    0.312561] thermal_sys: Registered thermal governor 'user_space'
[    0.312562] thermal_sys: Registered thermal governor 'power_allocator'
[    0.312571] cpuidle: using governor ladder
[    0.312571] cpuidle: using governor menu
[    0.312571] Simple Boot Flag at 0x47 set to 0x1
[    0.312598] ACPI FADT declares the system doesn't support PCIe ASPM, so
disable it
[    0.312600] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.312725] PCI: ECAM [mem 0xf8000000-0xfbffffff] (base 0xf8000000) for
domain 0000 [bus 00-3f]
[    0.312742] PCI: Using configuration type 1 for base access
[    0.313465] kprobes: kprobe jump-optimization is enabled. All kprobes
are optimized if possible.
[    0.313548] HugeTLB: allocation took 0ms with
hugepage_allocation_threads=3D1
[    0.313548] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 page=
s
[    0.313548] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.313548] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 page=
s
[    0.313548] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.314566] raid6: skipped pq benchmark and selected avx2x4
[    0.314566] raid6: using avx2x2 recovery algorithm
[    0.314566] ACPI: Added _OSI(Module Device)
[    0.314566] ACPI: Added _OSI(Processor Device)
[    0.314566] ACPI: Added _OSI(Processor Aggregator Device)
[    0.328355] ACPI: 5 ACPI AML tables successfully acquired and loaded
[    0.334670] ACPI: EC: EC started
[    0.334675] ACPI: EC: interrupt blocked
[    0.336252] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.336255] ACPI: \_SB_.PCI0.SBRG.EC__: Boot DSDT EC used to handle
transactions
[    0.336258] ACPI: Interpreter enabled
[    0.336282] ACPI: PM: (supports S0 S3 S4 S5)
[    0.336284] ACPI: Using IOAPIC for interrupt routing
[    0.337072] PCI: Using host bridge windows from ACPI; if necessary, use
"pci=3Dnocrs" and report a bug
[    0.337074] PCI: Using E820 reservations for host bridge windows
[    0.337348] ACPI: Enabled 3 GPEs in block 00 to 1F
[    0.340650] ACPI: \_SB_.P0ST: New power resource
[    0.340687] ACPI: \_SB_.P3ST: New power resource
[    0.341140] ACPI: \_SB_.P0U2: New power resource
[    0.341175] ACPI: \_SB_.P3U2: New power resource
[    0.341532] ACPI: \_SB_.P0U3: New power resource
[    0.341562] ACPI: \_SB_.P3U3: New power resource
[    0.342546] ACPI: \_SB_.P0SD: New power resource
[    0.342572] ACPI: \_SB_.P3SD: New power resource
[    0.365088] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.365100] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM
ClockPM Segments MSI EDR HPX-Type3]
[    0.365193] acpi PNP0A08:00: _OSC: platform does not support
[SHPCHotplug LTR DPC]
[    0.365342] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER
PCIeCapability]
[    0.365344] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using
BIOS configuration
[    0.365357] acpi PNP0A08:00: [Firmware Info]: ECAM [mem
0xf8000000-0xfbffffff] for domain 0000 [bus 00-3f] only partially covers
this bridge
[    0.365866] PCI host bridge to bus 0000:00
[    0.365870] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window=
]
[    0.365872] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window=
]
[    0.365874] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window=
]
[    0.365875] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window=
]
[    0.365877] pci_bus 0000:00: root bus resource [mem
0x000a0000-0x000dffff window]
[    0.365879] pci_bus 0000:00: root bus resource [mem
0xd0000000-0xfed3ffff window]
[    0.365881] pci_bus 0000:00: root bus resource [mem
0xfedca000-0xffffffff window]
[    0.365882] pci_bus 0000:00: root bus resource [mem
0x47f000000-0xfffffffff window]
[    0.365884] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.365954] pci 0000:00:00.0: [1022:1576] type 00 class 0x060000
conventional PCI endpoint
[    0.366080] pci 0000:00:00.2: [1022:1577] type 00 class 0x080600
conventional PCI endpoint
[    0.366194] pci 0000:00:01.0: [1002:9874] type 00 class 0x030000 PCIe
Root Complex Integrated Endpoint
[    0.366222] pci 0000:00:01.0: BAR 0 [mem 0xd0000000-0xdfffffff 64bit
pref]
[    0.366225] pci 0000:00:01.0: BAR 2 [mem 0xf0800000-0xf0ffffff 64bit
pref]
[    0.366227] pci 0000:00:01.0: BAR 4 [io  0xf000-0xf0ff]
[    0.366230] pci 0000:00:01.0: BAR 5 [mem 0xfea00000-0xfea3ffff]
[    0.366232] pci 0000:00:01.0: ROM [mem 0xfea40000-0xfea5ffff pref]
[    0.366237] pci 0000:00:01.0: enabling Extended Tags
[    0.366251] pci 0000:00:01.0: Video device with shadowed ROM at [mem
0x000c0000-0x000dffff]
[    0.366284] pci 0000:00:01.0: supports D1 D2
[    0.366285] pci 0000:00:01.0: PME# supported from D1 D2 D3hot
[    0.366387] pci 0000:00:01.1: [1002:9840] type 00 class 0x040300 PCIe
Root Complex Integrated Endpoint
[    0.366415] pci 0000:00:01.1: BAR 0 [mem 0xfea64000-0xfea67fff 64bit]
[    0.366423] pci 0000:00:01.1: enabling Extended Tags
[    0.366455] pci 0000:00:01.1: supports D1 D2
[    0.366510] pci 0000:00:02.0: [1022:157b] type 00 class 0x060000
conventional PCI endpoint
[    0.366583] pci 0000:00:02.2: [1022:157c] type 01 class 0x060400 PCIe
Root Port
[    0.366603] pci 0000:00:02.2: PCI bridge to [bus 01]
[    0.366610] pci 0000:00:02.2:   bridge window [mem 0xfe400000-0xfe5fffff=
]
[    0.366699] pci 0000:00:02.2: enabling Extended Tags
[    0.366756] pci 0000:00:02.2: PME# supported from D0 D3hot D3cold
[    0.366783] pci 0000:00:02.3: [1022:157c] type 01 class 0x060400 PCIe
Root Port
[    0.366783] pci 0000:00:02.3: PCI bridge to [bus 02]
[    0.366783] pci 0000:00:02.3:   bridge window [io  0xe000-0xefff]
[    0.366783] pci 0000:00:02.3:   bridge window [mem 0xfe900000-0xfe9fffff=
]
[    0.366783] pci 0000:00:02.3: enabling Extended Tags
[    0.366783] pci 0000:00:02.3: PME# supported from D0 D3hot D3cold
[    0.366783] pci 0000:00:03.0: [1022:157b] type 00 class 0x060000
conventional PCI endpoint
[    0.366849] pci 0000:00:03.1: [1022:157c] type 01 class 0x060400 PCIe
Root Port
[    0.366868] pci 0000:00:03.1: PCI bridge to [bus 03]
[    0.366873] pci 0000:00:03.1:   bridge window [io  0xd000-0xdfff]
[    0.366876] pci 0000:00:03.1:   bridge window [mem 0xfe800000-0xfe8fffff=
]
[    0.366883] pci 0000:00:03.1:   bridge window [mem 0xe0000000-0xf01fffff
64bit pref]
[    0.366904] pci 0000:00:03.1: enabling Extended Tags
[    0.366950] pci 0000:00:03.1: PME# supported from D0 D3hot D3cold
[    0.367053] pci 0000:00:08.0: [1022:1578] type 00 class 0x108000
conventional PCI endpoint
[    0.367075] pci 0000:00:08.0: BAR 0 [mem 0xf1000000-0xf101ffff 64bit
pref]
[    0.367077] pci 0000:00:08.0: BAR 2 [mem 0xfe700000-0xfe7fffff]
[    0.367079] pci 0000:00:08.0: BAR 3 [mem 0xfea6f000-0xfea6ffff]
[    0.367081] pci 0000:00:08.0: BAR 5 [mem 0xfea6a000-0xfea6bfff]
[    0.367164] pci 0000:00:09.0: [1022:157d] type 00 class 0x060000
conventional PCI endpoint
[    0.367445] pci 0000:00:09.2: [1022:157a] type 00 class 0x040300
conventional PCI endpoint
[    0.367466] pci 0000:00:09.2: BAR 0 [mem 0xfea60000-0xfea63fff]
[    0.367486] pci 0000:00:09.2: PME# supported from D0 D3hot D3cold
[    0.367577] pci 0000:00:10.0: [1022:7914] type 00 class 0x0c0330 PCIe
Root Complex Integrated Endpoint
[    0.367626] pci 0000:00:10.0: BAR 0 [mem 0xfea68000-0xfea69fff 64bit]
[    0.367698] pci 0000:00:10.0: PME# supported from D0 D3hot D3cold
[    0.367807] pci 0000:00:11.0: [1022:7901] type 00 class 0x010601
conventional PCI endpoint
[    0.367846] pci 0000:00:11.0: BAR 0 [io  0xf140-0xf147]
[    0.367848] pci 0000:00:11.0: BAR 1 [io  0xf130-0xf133]
[    0.367851] pci 0000:00:11.0: BAR 2 [io  0xf120-0xf127]
[    0.367853] pci 0000:00:11.0: BAR 3 [io  0xf110-0xf113]
[    0.367855] pci 0000:00:11.0: BAR 4 [io  0xf100-0xf10f]
[    0.367857] pci 0000:00:11.0: BAR 5 [mem 0xfea6d000-0xfea6d3ff]
[    0.367888] pci 0000:00:11.0: PME# supported from D3hot
[    0.367970] pci 0000:00:12.0: [1022:7908] type 00 class 0x0c0320
conventional PCI endpoint
[    0.368009] pci 0000:00:12.0: BAR 0 [mem 0xfea6c000-0xfea6c0ff]
[    0.368044] pci 0000:00:12.0: supports D1 D2
[    0.368045] pci 0000:00:12.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.368171] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500
conventional PCI endpoint
[    0.368283] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100
conventional PCI endpoint
[    0.368410] pci 0000:00:18.0: [1022:1570] type 00 class 0x060000
conventional PCI endpoint
[    0.368497] pci 0000:00:18.1: [1022:1571] type 00 class 0x060000
conventional PCI endpoint
[    0.368544] pci 0000:00:18.2: [1022:1572] type 00 class 0x060000
conventional PCI endpoint
[    0.368603] pci 0000:00:18.3: [1022:1573] type 00 class 0x060000
conventional PCI endpoint
[    0.368654] pci 0000:00:18.4: [1022:1574] type 00 class 0x060000
conventional PCI endpoint
[    0.368708] pci 0000:00:18.5: [1022:1575] type 00 class 0x060000
conventional PCI endpoint
[    0.368977] pci 0000:01:00.0: [168c:0042] type 00 class 0x028000 PCIe
Endpoint
[    0.369316] pci 0000:01:00.0: BAR 0 [mem 0xfe400000-0xfe5fffff 64bit]
[    0.369900] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    0.370761] pci 0000:00:02.2: PCI bridge to [bus 01]
[    0.370839] pci 0000:02:00.0: [10ec:8168] type 00 class 0x020000 PCIe
Endpoint
[    0.370890] pci 0000:02:00.0: BAR 0 [io  0xe000-0xe0ff]
[    0.370895] pci 0000:02:00.0: BAR 2 [mem 0xfe904000-0xfe904fff 64bit]
[    0.370899] pci 0000:02:00.0: BAR 4 [mem 0xfe900000-0xfe903fff 64bit]
[    0.370989] pci 0000:02:00.0: supports D1 D2
[    0.370991] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.371197] pci 0000:00:02.3: PCI bridge to [bus 02]
[    0.371317] pci 0000:03:00.0: [1002:67ef] type 00 class 0x038000 PCIe
Legacy Endpoint
[    0.371402] pci 0000:03:00.0: BAR 0 [mem 0xe0000000-0xefffffff 64bit
pref]
[    0.371406] pci 0000:03:00.0: BAR 2 [mem 0xf0000000-0xf01fffff 64bit
pref]
[    0.371409] pci 0000:03:00.0: BAR 4 [io  0xd000-0xd0ff]
[    0.371411] pci 0000:03:00.0: BAR 5 [mem 0xfe800000-0xfe83ffff]
[    0.371414] pci 0000:03:00.0: ROM [mem 0xfe840000-0xfe85ffff pref]
[    0.371423] pci 0000:03:00.0: enabling Extended Tags
[    0.371578] pci 0000:03:00.0: supports D1 D2
[    0.371579] pci 0000:03:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.371781] pci 0000:00:03.1: PCI bridge to [bus 03]
[    0.372708] ACPI: PCI: Interrupt link LNKA configured for IRQ 5
[    0.372763] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
[    0.372811] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
[    0.372867] ACPI: PCI: Interrupt link LNKD configured for IRQ 4
[    0.372918] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.372960] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.373003] ACPI: PCI: Interrupt link LNKG configured for IRQ 11
[    0.373046] ACPI: PCI: Interrupt link LNKH configured for IRQ 10
[    0.374058] ACPI: EC: interrupt unblocked
[    0.374060] ACPI: EC: event unblocked
[    0.374068] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.374069] ACPI: EC: GPE=3D0x3
[    0.374071] ACPI: \_SB_.PCI0.SBRG.EC__: Boot DSDT EC initialization
complete
[    0.374074] ACPI: \_SB_.PCI0.SBRG.EC__: EC: Used to handle transactions
and events
[    0.374540] iommu: Default domain type: Translated
[    0.374540] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.374542] SCSI subsystem initialized
[    0.374545] libata version 3.00 loaded.
[    0.374545] ACPI: bus type USB registered
[    0.374545] usbcore: registered new interface driver usbfs
[    0.374545] usbcore: registered new interface driver hub
[    0.374545] usbcore: registered new device driver usb
[    0.377845] EDAC MC: Ver: 3.0.0
[    0.378740] NetLabel: Initializing
[    0.378745] NetLabel:  domain hash size =3D 128
[    0.378747] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    0.378762] NetLabel:  unlabeled traffic allowed by default
[    0.378766] mctp: management component transport protocol core
[    0.378767] NET: Registered PF_MCTP protocol family
[    0.378777] PCI: Using ACPI for IRQ routing
[    0.380805] PCI: pci_cache_line_size set to 64 bytes
[    0.380963] e820: reserve RAM buffer [mem 0x0009d800-0x0009ffff]
[    0.380967] e820: reserve RAM buffer [mem 0xcc96f000-0xcfffffff]
[    0.380969] e820: reserve RAM buffer [mem 0xcf000000-0xcfffffff]
[    0.380970] e820: reserve RAM buffer [mem 0x3af000000-0x3afffffff]
[    0.381405] pci 0000:00:01.0: vgaarb: setting as boot VGA device
[    0.381405] pci 0000:00:01.0: vgaarb: bridge control possible
[    0.381405] pci 0000:00:01.0: vgaarb: VGA device added:
decodes=3Dio+mem,owns=3Dio+mem,locks=3Dnone
[    0.381409] vgaarb: loaded
[    0.381469] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.381469] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.383582] clocksource: Switched to clocksource tsc-early
[    0.384361] VFS: Disk quotas dquot_6.6.0
[    0.384376] VFS: Dquot-cache hash table entries: 512 (order 0, 4096
bytes)
[    0.384775] pnp: PnP ACPI init
[    0.384933] system 00:00: [mem 0xf8000000-0xfbffffff] has been reserved
[    0.385007] system 00:01: [mem 0x50000000-0xcfffffff] could not be
reserved
[    0.385077] system 00:02: [mem 0xfeb80000-0xfebfffff] could not be
reserved
[    0.385591] system 00:06: [io  0x04d0-0x04d1] has been reserved
[    0.385594] system 00:06: [io  0x040b] has been reserved
[    0.385595] system 00:06: [io  0x04d6] has been reserved
[    0.385597] system 00:06: [io  0x0c00-0x0c01] has been reserved
[    0.385598] system 00:06: [io  0x0c14] has been reserved
[    0.385600] system 00:06: [io  0x0c50-0x0c51] has been reserved
[    0.385601] system 00:06: [io  0x0c52] has been reserved
[    0.385603] system 00:06: [io  0x0c6c] has been reserved
[    0.385604] system 00:06: [io  0x0c6f] has been reserved
[    0.385606] system 00:06: [io  0x0cd0-0x0cd1] has been reserved
[    0.385607] system 00:06: [io  0x0cd2-0x0cd3] has been reserved
[    0.385609] system 00:06: [io  0x0cd4-0x0cd5] has been reserved
[    0.385610] system 00:06: [io  0x0cd6-0x0cd7] has been reserved
[    0.385611] system 00:06: [io  0x0cd8-0x0cdf] has been reserved
[    0.385613] system 00:06: [io  0x0800-0x089f] has been reserved
[    0.385614] system 00:06: [io  0x0b00-0x0b0f] has been reserved
[    0.385616] system 00:06: [io  0x0b20-0x0b3f] has been reserved
[    0.385617] system 00:06: [io  0x0900-0x090f] has been reserved
[    0.385619] system 00:06: [io  0x0910-0x091f] has been reserved
[    0.385620] system 00:06: [io  0x0380-0x0381] has been reserved
[    0.385622] system 00:06: [io  0xfe00-0xfefe] has been reserved
[    0.385624] system 00:06: [mem 0xfec00000-0xfec00fff] could not be
reserved
[    0.385626] system 00:06: [mem 0xfec01000-0xfec01fff] could not be
reserved
[    0.385628] system 00:06: [mem 0xfedc0000-0xfedc0fff] has been reserved
[    0.385630] system 00:06: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.385632] system 00:06: [mem 0xfed80000-0xfed8ffff] could not be
reserved
[    0.385633] system 00:06: [mem 0xfed61000-0xfed70fff] has been reserved
[    0.385636] system 00:06: [mem 0xfe200000-0xfe200fff] has been reserved
[    0.385638] system 00:06: [mem 0xfec10000-0xfec10fff] has been reserved
[    0.385640] system 00:06: [mem 0xff000000-0xffffffff] has been reserved
[    0.387001] pnp: PnP ACPI: found 7 devices
[    0.393269] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff,
max_idle_ns: 2085701024 ns
[    0.393354] NET: Registered PF_INET protocol family
[    0.393737] IP idents hash table entries: 262144 (order: 9, 2097152
bytes, linear)
[    0.412743] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5,
131072 bytes, linear)
[    0.412786] Table-perturb hash table entries: 65536 (order: 6, 262144
bytes, linear)
[    0.412945] TCP established hash table entries: 131072 (order: 8,
1048576 bytes, linear)
[    0.413580] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes,
linear)
[    0.414149] TCP: Hash tables configured (established 131072 bind 65536)
[    0.414337] MPTCP token hash table entries: 16384 (order: 6, 393216
bytes, linear)
[    0.414483] UDP hash table entries: 8192 (order: 7, 524288 bytes, linear=
)
[    0.414621] UDP-Lite hash table entries: 8192 (order: 7, 524288 bytes,
linear)
[    0.414718] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.414731] NET: Registered PF_XDP protocol family
[    0.414752] pci 0000:00:02.2: PCI bridge to [bus 01]
[    0.414760] pci 0000:00:02.2:   bridge window [mem 0xfe400000-0xfe5fffff=
]
[    0.414768] pci 0000:00:02.3: PCI bridge to [bus 02]
[    0.414770] pci 0000:00:02.3:   bridge window [io  0xe000-0xefff]
[    0.414774] pci 0000:00:02.3:   bridge window [mem 0xfe900000-0xfe9fffff=
]
[    0.414781] pci 0000:00:03.1: PCI bridge to [bus 03]
[    0.414783] pci 0000:00:03.1:   bridge window [io  0xd000-0xdfff]
[    0.414787] pci 0000:00:03.1:   bridge window [mem 0xfe800000-0xfe8fffff=
]
[    0.414790] pci 0000:00:03.1:   bridge window [mem 0xe0000000-0xf01fffff
64bit pref]
[    0.414797] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    0.414799] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
[    0.414801] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
[    0.414802] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    0.414803] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000dffff
window]
[    0.414805] pci_bus 0000:00: resource 9 [mem 0xd0000000-0xfed3ffff
window]
[    0.414806] pci_bus 0000:00: resource 10 [mem 0xfedca000-0xffffffff
window]
[    0.414808] pci_bus 0000:00: resource 11 [mem 0x47f000000-0xfffffffff
window]
[    0.414810] pci_bus 0000:01: resource 1 [mem 0xfe400000-0xfe5fffff]
[    0.414811] pci_bus 0000:02: resource 0 [io  0xe000-0xefff]
[    0.414813] pci_bus 0000:02: resource 1 [mem 0xfe900000-0xfe9fffff]
[    0.414814] pci_bus 0000:03: resource 0 [io  0xd000-0xdfff]
[    0.414816] pci_bus 0000:03: resource 1 [mem 0xfe800000-0xfe8fffff]
[    0.414817] pci_bus 0000:03: resource 2 [mem 0xe0000000-0xf01fffff 64bit
pref]
[    0.414947] pci 0000:00:01.1: D0 power state depends on 0000:00:01.0
[    0.415235] pci 0000:00:10.0: PME# does not work under D0, disabling it
[    0.428169] pci 0000:00:12.0: quirk_usb_early_handoff+0x0/0x770 took
12620 usecs
[    0.428247] PCI: CLS 0 bytes, default 64
[    0.428266] AMD-Vi: [Firmware Warn]: EFR mismatch. Use IVHD EFR
(0x37ef22294ada : 0x77ef22294ada), EFR2 (0x0 : 0x0).
[    0.428273] pci 0000:00:00.2: AMD-Vi: IOMMU performance counters
supported
[    0.428328] Trying to unpack rootfs image as initramfs...
[    0.428337] pci 0000:00:00.0: Adding to iommu group 0
[    0.428369] pci 0000:00:01.0: Adding to iommu group 1
[    0.428382] pci 0000:00:01.1: Adding to iommu group 1
[    0.428418] pci 0000:00:02.0: Adding to iommu group 2
[    0.428451] pci 0000:00:02.2: Adding to iommu group 2
[    0.428474] pci 0000:00:02.3: Adding to iommu group 2
[    0.428508] pci 0000:00:03.0: Adding to iommu group 3
[    0.428529] pci 0000:00:03.1: Adding to iommu group 3
[    0.428551] pci 0000:00:08.0: Adding to iommu group 4
[    0.428592] pci 0000:00:09.0: Adding to iommu group 5
[    0.428613] pci 0000:00:09.2: Adding to iommu group 5
[    0.428635] pci 0000:00:10.0: Adding to iommu group 6
[    0.428656] pci 0000:00:11.0: Adding to iommu group 7
[    0.428676] pci 0000:00:12.0: Adding to iommu group 8
[    0.428717] pci 0000:00:14.0: Adding to iommu group 9
[    0.428738] pci 0000:00:14.3: Adding to iommu group 9
[    0.428817] pci 0000:00:18.0: Adding to iommu group 10
[    0.428841] pci 0000:00:18.1: Adding to iommu group 10
[    0.428863] pci 0000:00:18.2: Adding to iommu group 10
[    0.428887] pci 0000:00:18.3: Adding to iommu group 10
[    0.428911] pci 0000:00:18.4: Adding to iommu group 10
[    0.428939] pci 0000:00:18.5: Adding to iommu group 10
[    0.428948] pci 0000:01:00.0: Adding to iommu group 2
[    0.428957] pci 0000:02:00.0: Adding to iommu group 2
[    0.428970] pci 0000:03:00.0: Adding to iommu group 3
[    0.430728] AMD-Vi: Extended features (0x77ef22294ada, 0x0): PPR NX GT
IA GA PC GA_vAPIC
[    0.430742] AMD-Vi: Interrupt remapping enabled
[    0.431039] AMD-Vi: Virtual APIC enabled
[    0.431046] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.431047] software IO TLB: mapped [mem
0x00000000c896f000-0x00000000cc96f000] (64MB)
[    0.431112] LVT offset 0 assigned for vector 0x400
[    0.433770] perf: AMD IBS detected (0x000007ff)
[    0.433785] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4
counters/bank).
[    0.471249] Initialise system trusted keyrings
[    0.471265] Key type blacklist registered
[    0.471355] workingset: timestamp_bits=3D36 max_order=3D22 bucket_order=
=3D0
[    0.471629] fuse: init (API version 7.43)
[    0.471745] integrity: Platform Keyring initialized
[    0.471750] integrity: Machine keyring initialized
[    0.482974] xor: automatically using best checksumming function   avx

[    0.482976] Key type asymmetric registered
[    0.482978] Asymmetric key parser 'x509' registered
[    0.483001] Block layer SCSI generic (bsg) driver version 0.4 loaded
(major 246)
[    0.483076] io scheduler mq-deadline registered
[    0.483078] io scheduler kyber registered
[    0.483091] io scheduler bfq registered
[    0.484256] ledtrig-cpu: registered to indicate activity on CPUs
[    0.484515] pcieport 0000:00:02.2: PME: Signaling with IRQ 26
[    0.484692] pcieport 0000:00:02.3: PME: Signaling with IRQ 27
[    0.484883] pcieport 0000:00:03.1: PME: Signaling with IRQ 29
[    0.484908] pcieport 0000:00:03.1: pciehp: Slot #0 AttnBtn- PwrCtrl-
MRL- AttnInd- PwrInd- HotPlug+ Surprise- Interlock- NoCompl+ IbPresDis-
LLActRep+
[    0.486063] ACPI: AC: AC Adapter [ACAD] (on-line)
[    0.486129] input: Power Button as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    0.486151] ACPI: button: Power Button [PWRB]
[    0.486183] input: Lid Switch as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input1
[    0.490191] ACPI: button: Lid Switch [LID0]
[    0.490267] input: Sleep Button as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input2
[    0.490297] ACPI: button: Sleep Button [SLPB]
[    0.490332] input: Power Button as
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[    0.490376] ACPI: button: Power Button [PWRF]
[    0.490648] Could not retrieve perf counters (-19)
[    0.490981] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.493254] Non-volatile memory driver v1.3
[    0.493259] Linux agpgart interface v0.103
[    0.493319] ACPI: bus type drm_connector registered
[    0.493999] ahci 0000:00:11.0: version 3.0
[    0.494234] ahci 0000:00:11.0: AHCI vers 0001.0300, 32 command slots, 6
Gbps, SATA mode
[    0.494238] ahci 0000:00:11.0: 1/1 ports implemented (port mask 0x1)
[    0.494240] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck led clo pmp
fbs pio slum part
[    0.494497] scsi host0: ahci
[    0.494557] ata1: SATA max UDMA/133 abar m1024@0xfea6d000 port
0xfea6d100 irq 19 lpm-pol 3
[    0.494945] xhci_hcd 0000:00:10.0: xHCI Host Controller
[    0.494954] xhci_hcd 0000:00:10.0: new USB bus registered, assigned bus
number 1
[    0.495171] xhci_hcd 0000:00:10.0: hcc params 0x014040c3 hci version
0x100 quirks 0x0000000000000010
[    0.495474] ehci-pci 0000:00:12.0: EHCI Host Controller
[    0.495481] ehci-pci 0000:00:12.0: new USB bus registered, assigned bus
number 2
[    0.495493] ehci-pci 0000:00:12.0: debug port 2
[    0.495549] ehci-pci 0000:00:12.0: irq 18, io mem 0xfea6c000
[    0.495563] xhci_hcd 0000:00:10.0: xHCI Host Controller
[    0.495566] xhci_hcd 0000:00:10.0: new USB bus registered, assigned bus
number 3
[    0.495569] xhci_hcd 0000:00:10.0: Host supports USB 3.0 SuperSpeed
[    0.500186] ACPI: battery: Slot [BAT0] (battery present)
[    0.502114] ehci-pci 0000:00:12.0: USB 2.0 started, EHCI 1.00
[    0.502166] usb usb1: New USB device found, idVendor=3D1d6b,
idProduct=3D0002, bcdDevice=3D 6.15
[    0.502169] usb usb1: New USB device strings: Mfr=3D3, Product=3D2,
SerialNumber=3D1
[    0.502171] usb usb1: Product: xHCI Host Controller
[    0.502173] usb usb1: Manufacturer: Linux 6.15.4-arch2-1 xhci-hcd
[    0.502174] usb usb1: SerialNumber: 0000:00:10.0
[    0.502318] hub 1-0:1.0: USB hub found
[    0.502329] hub 1-0:1.0: 4 ports detected
[    0.502534] usb usb3: We don't know the algorithms for LPM for this
host, disabling LPM.
[    0.502556] usb usb3: New USB device found, idVendor=3D1d6b,
idProduct=3D0003, bcdDevice=3D 6.15
[    0.502558] usb usb3: New USB device strings: Mfr=3D3, Product=3D2,
SerialNumber=3D1
[    0.502560] usb usb3: Product: xHCI Host Controller
[    0.502561] usb usb3: Manufacturer: Linux 6.15.4-arch2-1 xhci-hcd
[    0.502562] usb usb3: SerialNumber: 0000:00:10.0
[    0.502646] hub 3-0:1.0: USB hub found
[    0.502656] hub 3-0:1.0: 4 ports detected
[    0.502874] usb usb2: New USB device found, idVendor=3D1d6b,
idProduct=3D0002, bcdDevice=3D 6.15
[    0.502877] usb usb2: New USB device strings: Mfr=3D3, Product=3D2,
SerialNumber=3D1
[    0.502879] usb usb2: Product: EHCI Host Controller
[    0.502881] usb usb2: Manufacturer: Linux 6.15.4-arch2-1 ehci_hcd
[    0.502883] usb usb2: SerialNumber: 0000:00:12.0
[    0.502950] usbcore: registered new interface driver usbserial_generic
[    0.502962] usbserial: USB Serial support registered for generic
[    0.503006] hub 2-0:1.0: USB hub found
[    0.503008] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at
0x60,0x64 irq 1,12
[    0.503014] hub 2-0:1.0: 2 ports detected
[    0.505601] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.505637] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.505798] rtc_cmos 00:03: RTC can wake from S4
[    0.506009] rtc_cmos 00:03: registered as rtc0
[    0.506034] rtc_cmos 00:03: setting system clock to 2026-02-05T06:54:35
UTC (1770274475)
[    0.506063] rtc_cmos 00:03: alarms up to one month, y3k, 114 bytes
nvram, hpet irqs
[    0.506120] amd_pstate: the _CPC object is not present in SBIOS or ACPI
disabled
[    0.506410] hid: raw HID events driver (C) Jiri Kosina
[    0.506437] usbcore: registered new interface driver usbhid
[    0.506438] usbhid: USB HID core driver
[    0.506506] drop_monitor: Initializing network drop monitor service
[    0.506636] NET: Registered PF_INET6 protocol family
[    0.507161] input: AT Translated Set 2 keyboard as
/devices/platform/i8042/serio0/input/input4
[    0.738504] usb 1-2: new high-speed USB device number 2 using xhci_hcd
[    0.738525] usb 2-1: new high-speed USB device number 2 using ehci-pci
[    0.864063] usb 2-1: New USB device found, idVendor=3D0438,
idProduct=3D7900, bcdDevice=3D 0.18
[    0.864072] usb 2-1: New USB device strings: Mfr=3D0, Product=3D0,
SerialNumber=3D0
[    0.864339] hub 2-1:1.0: USB hub found
[    0.864432] hub 2-1:1.0: 4 ports detected
[    0.866105] usb 1-2: New USB device found, idVendor=3D05e3,
idProduct=3D0747, bcdDevice=3D 8.19
[    0.866109] usb 1-2: New USB device strings: Mfr=3D3, Product=3D4,
SerialNumber=3D5
[    0.866111] usb 1-2: Product: USB Storage
[    0.866113] usb 1-2: Manufacturer: Generic
[    0.866114] usb 1-2: SerialNumber: 000000000819
[    0.970785] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    0.972217] ata1.00: ATA-9: SSD, U1124A0, max UDMA/133
[    0.973054] ata1.00: 500118192 sectors, multi 1: LBA48 NCQ (depth 32), A=
A
[    0.976536] ata1.00: configured for UDMA/133
[    0.976677] scsi 0:0:0:0: Direct-Access     ATA      SSD
 4A0  PQ: 0 ANSI: 5
[    0.977002] sd 0:0:0:0: [sda] 500118192 512-byte logical blocks: (256
GB/238 GiB)
[    0.977018] sd 0:0:0:0: [sda] Write Protect is off
[    0.977021] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    0.977036] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,
doesn't support DPO or FUA
[    0.977064] sd 0:0:0:0: [sda] Preferred minimum I/O size 512 bytes
[    0.984741]  sda: sda1 sda2 sda3
[    0.984900] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.147542] usb 2-1.2: new full-speed USB device number 3 using ehci-pci
[    1.235631] usb 2-1.2: New USB device found, idVendor=3D0cf3,
idProduct=3De009, bcdDevice=3D 0.01
[    1.235646] usb 2-1.2: New USB device strings: Mfr=3D0, Product=3D0,
SerialNumber=3D0
[    1.310566] usb 2-1.4: new high-speed USB device number 4 using ehci-pci
[    1.399862] usb 2-1.4: New USB device found, idVendor=3D0bda,
idProduct=3D0129, bcdDevice=3D39.60
[    1.399871] usb 2-1.4: New USB device strings: Mfr=3D1, Product=3D2,
SerialNumber=3D3
[    1.399882] usb 2-1.4: Product: USB2.0-CRW
[    1.399883] usb 2-1.4: Manufacturer: Generic
[    1.399885] usb 2-1.4: SerialNumber: 20100201396000000
[    1.465556] tsc: Refined TSC clocksource calibration: 2999.999 MHz
[    1.465568] clocksource: tsc: mask: 0xffffffffffffffff max_cycles:
0x2b3e44b2357, max_idle_ns: 440795324996 ns
[    1.465679] clocksource: Switched to clocksource tsc
[    1.783849] Freeing initrd memory: 157048K
[    1.793748] Segment Routing with IPv6
[    1.793754] RPL Segment Routing with IPv6
[    1.793776] In-situ OAM (IOAM) with IPv6
[    1.793811] NET: Registered PF_PACKET protocol family
[    1.794099] x86/pm: family 0x15 cpu detected, MSR saving is needed
during suspending.
[    1.794802] microcode: Current revision: 0x0600611a
[    1.795255] IPI shorthand broadcast: enabled
[    1.797778] sched_clock: Marking stable (1795002193,
2539590)->(1811761560, -14219777)
[    1.798061] registered taskstats version 1
[    1.799235] Loading compiled-in X.509 certificates
[    1.807770] Loaded X.509 cert 'Build time autogenerated kernel key:
1263cc237f7edc3f3e8acdd3ae1809e6a89d0f66'
[    1.811777] zswap: loaded using pool zstd/zsmalloc
[    1.811969] Demotion targets for Node 0: null
[    1.812132] Key type .fscrypt registered
[    1.812133] Key type fscrypt-provisioning registered
[    1.813417] Btrfs loaded, zoned=3Dyes, fsverity=3Dyes
[    1.813471] Key type big_key registered
[    1.813869] PM:   Magic number: 14:873:922
[    1.816792] RAS: Correctable Errors collector initialized.
[    1.827032] clk: Disabling unused clocks
[    1.827039] PM: genpd: Disabling unused power domains
[    1.829010] Freeing unused decrypted memory: 2028K
[    1.830358] Freeing unused kernel image (initmem) memory: 4632K
[    1.830399] Write protecting the kernel read-only data: 38912k
[    1.830873] Freeing unused kernel image (text/rodata gap) memory: 784K
[    1.831464] Freeing unused kernel image (rodata/data gap) memory: 1912K
[    1.959064] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.959072] rodata_test: all tests were successful
[    1.959079] Run /init as init process
[    1.959081]   with arguments:
[    1.959082]     /init
[    1.959084]   with environment:
[    1.959084]     HOME=3D/
[    1.959085]     TERM=3Dlinux
[    1.959086]     BOOT_IMAGE=3D/arch/boot/x86_64/vmlinuz-linux
[    1.959087]     archisobasedir=3Darch
[    1.959088]     archisosearchuuid=3D2025-07-01-17-34-06-00
[    2.094052] wmi_bus wmi_bus-PNP0C14:00: [Firmware Bug]: WQBC data block
query control method not found
[    2.094107] wmi_bus wmi_bus-PNP0C14:00: [Firmware Bug]: WMBD method
block execution control method not found
[    2.100074] ACPI: video: Video Device [VGA] (multi-head: yes  rom: no
 post: no)
[    2.100396] input: Video Bus as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input6
[    2.100607] ACPI: video: Video Device [VGA2] (multi-head: yes  rom: no
 post: no)
[    2.100711] input: Video Bus as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:0e/LNXVIDEO:02/input/inp=
ut7
[    2.123878] usb-storage 1-2:1.0: USB Mass Storage device detected
[    2.128086] scsi host1: usb-storage 1-2:1.0
[    2.128289] usbcore: registered new interface driver usb-storage
[    2.137065] usbcore: registered new interface driver uas
[    2.142867] usbcore: registered new interface driver rtsx_usb
[    2.147323] cryptd: max_cpu_qlen set to 1000
[    2.170761] r8169 0000:02:00.0: can't disable ASPM; OS doesn't have ASPM
control
[    2.178499] r8169 0000:02:00.0 eth0: RTL8168h/8111h, f4:8e:38:f1:b0:dc,
XID 541, IRQ 36
[    2.178508] r8169 0000:02:00.0 eth0: jumbo features [frames: 9194 bytes,
tx checksumming: ko]
[    3.131112] scsi 1:0:0:0: Direct-Access     Generic  STORAGE DEVICE
0819 PQ: 0 ANSI: 6
[    3.376795] sd 1:0:0:0: [sdb] 31116288 512-byte logical blocks: (15.9
GB/14.8 GiB)
[    3.378070] sd 1:0:0:0: [sdb] Write Protect is off
[    3.378078] sd 1:0:0:0: [sdb] Mode Sense: 87 00 00 00
[    3.379452] sd 1:0:0:0: [sdb] Write cache: disabled, read cache:
enabled, doesn't support DPO or FUA
[    3.585717]  sdb: sdb1 sdb2
[    3.586122] sd 1:0:0:0: [sdb] Attached SCSI removable disk
[   11.146216] [drm] amdgpu kernel modesetting enabled.
[   11.146244] amdgpu: vga_switcheroo: detected switching method
\_SB_.PCI0.VGA_.ATPX handle
[   11.146683] amdgpu: ATPX version 1, functions 0x00000003
[   11.149571] amdgpu: Virtual CRAT table created for CPU
[   11.149588] amdgpu: Topology: Add CPU node
[   11.149876] [drm] initializing kernel modesetting (CARRIZO 0x1002:0x9874
0x1028:0x07E2 0xCC).
[   11.152265] [drm] register mmio base: 0xFEA00000
[   11.152271] [drm] register mmio size: 262144
[   11.152541] amdgpu 0000:00:01.0: amdgpu: detected ip block number 0
<vi_common>
[   11.152549] amdgpu 0000:00:01.0: amdgpu: detected ip block number 1
<gmc_v8_0>
[   11.152551] amdgpu 0000:00:01.0: amdgpu: detected ip block number 2
<cz_ih>
[   11.152553] amdgpu 0000:00:01.0: amdgpu: detected ip block number 3
<gfx_v8_0>
[   11.152555] amdgpu 0000:00:01.0: amdgpu: detected ip block number 4
<sdma_v3_0>
[   11.152556] amdgpu 0000:00:01.0: amdgpu: detected ip block number 5
<powerplay>
[   11.152558] amdgpu 0000:00:01.0: amdgpu: detected ip block number 6 <dm>
[   11.152560] amdgpu 0000:00:01.0: amdgpu: detected ip block number 7
<uvd_v6_0>
[   11.152562] amdgpu 0000:00:01.0: amdgpu: detected ip block number 8
<vce_v3_0>
[   11.152563] amdgpu 0000:00:01.0: amdgpu: detected ip block number 9
<acp_ip>
[   11.164692] amdgpu 0000:00:01.0: amdgpu: Fetched VBIOS from ROM BAR
[   11.164695] amdgpu: ATOM BIOS: 109-C95010-006
[   11.164975] [drm] UVD is enabled in physical mode
[   11.164979] [drm] VCE enabled in physical mode
[   11.165030] amdgpu 0000:00:01.0: vgaarb: deactivate vga console
[   11.165793] Console: switching to colour dummy device 80x25
[   11.165807] amdgpu 0000:00:01.0: amdgpu: Trusted Memory Zone (TMZ)
feature not supported
[   11.165914] [drm] vm size is 64 GB, 2 levels, block size is 10-bit,
fragment size is 9-bit
[   11.165921] amdgpu 0000:00:01.0: amdgpu: VRAM: 2048M 0x000000F400000000
- 0x000000F47FFFFFFF (2048M used)
[   11.165924] amdgpu 0000:00:01.0: amdgpu: GART: 1024M 0x000000FF00000000
- 0x000000FF3FFFFFFF
[   11.165934] [drm] Detected VRAM RAM=3D2048M, BAR=3D2048M
[   11.165935] [drm] RAM width 128bits UNKNOWN
[   11.166106] [drm] amdgpu: 2048M of VRAM memory ready
[   11.166109] [drm] amdgpu: 6960M of GTT memory ready.
[   11.166138] [drm] GART: num cpu pages 262144, num gpu pages 262144
[   11.166191] [drm] PCIE GART of 1024M enabled (table at
0x000000F400A00000).
[   11.171004] amdgpu: hwmgr_sw_init smu backed is smu8_smu
[   11.172860] [drm] Found UVD firmware Version: 1.91 Family ID: 11
[   11.172906] [drm] UVD ENC is disabled
[   11.174646] [drm] Found VCE firmware Version: 52.4 Binary ID: 3
[   11.176113] amdgpu: smu version 27.17.00
[   11.181831] [drm] DM_PPLIB: values for Engine clock
[   11.181837] [drm] DM_PPLIB: 300000
[   11.181838] [drm] DM_PPLIB: 464520
[   11.181839] [drm] DM_PPLIB: 576000
[   11.181840] [drm] DM_PPLIB: 654550
[   11.181841] [drm] DM_PPLIB: 720000
[   11.181842] [drm] DM_PPLIB: 800000
[   11.181842] [drm] DM_PPLIB: 847060
[   11.181843] [drm] DM_PPLIB: 900000
[   11.181844] [drm] DM_PPLIB: Validation clocks:
[   11.181845] [drm] DM_PPLIB:    engine_max_clock: 90000
[   11.181846] [drm] DM_PPLIB:    memory_max_clock: 120000
[   11.181847] [drm] DM_PPLIB:    level           : 8
[   11.181848] [drm] DM_PPLIB: values for Display clock
[   11.181849] [drm] DM_PPLIB: 300000
[   11.181850] [drm] DM_PPLIB: 400000
[   11.181851] [drm] DM_PPLIB: 496560
[   11.181852] [drm] DM_PPLIB: 626090
[   11.181852] [drm] DM_PPLIB: 685720
[   11.181853] [drm] DM_PPLIB: 757900
[   11.181854] [drm] DM_PPLIB: 800000
[   11.181854] [drm] DM_PPLIB: 847060
[   11.181855] [drm] DM_PPLIB: Validation clocks:
[   11.181856] [drm] DM_PPLIB:    engine_max_clock: 90000
[   11.181856] [drm] DM_PPLIB:    memory_max_clock: 120000
[   11.181857] [drm] DM_PPLIB:    level           : 8
[   11.181858] [drm] DM_PPLIB: values for Memory clock
[   11.181859] [drm] DM_PPLIB: 667000
[   11.181860] [drm] DM_PPLIB: 1200000
[   11.181861] [drm] DM_PPLIB: Validation clocks:
[   11.181861] [drm] DM_PPLIB:    engine_max_clock: 90000
[   11.181862] [drm] DM_PPLIB:    memory_max_clock: 120000
[   11.181863] [drm] DM_PPLIB:    level           : 8
[   11.181895] [drm:bios_parser_get_connector_id [amdgpu]] *ERROR* Can't
find connector id 3 in connector table of size 3.
[   11.183144] [drm:bios_parser_get_connector_id [amdgpu]] *ERROR* Can't
find connector id 4 in connector table of size 3.
[   11.184339] [drm:bios_parser_get_connector_id [amdgpu]] *ERROR* Can't
find connector id 5 in connector table of size 3.
[   11.185536] [drm:bios_parser_get_connector_id [amdgpu]] *ERROR* Can't
find connector id 6 in connector table of size 3.
[   11.186737] [drm:bios_parser_get_connector_id [amdgpu]] *ERROR* Can't
find connector id 7 in connector table of size 3.
[   11.187931] [drm:bios_parser_get_connector_id [amdgpu]] *ERROR* Can't
find connector id 8 in connector table of size 3.
[   11.189127] [drm:bios_parser_get_connector_id [amdgpu]] *ERROR* Can't
find connector id 9 in connector table of size 3.
[   11.190335] [drm:bios_parser_get_connector_id [amdgpu]] *ERROR* Can't
find connector id 10 in connector table of size 3.
[   11.191544] [drm:bios_parser_get_connector_id [amdgpu]] *ERROR* Can't
find connector id 11 in connector table of size 3.
[   11.192746] [drm:bios_parser_get_connector_id [amdgpu]] *ERROR* Can't
find connector id 12 in connector table of size 3.
[   11.193946] [drm:bios_parser_get_connector_id [amdgpu]] *ERROR* Can't
find connector id 13 in connector table of size 3.
[   11.195231] [drm] Display Core v3.2.325 initialized on DCE 11.0
[   11.282044] [drm] UVD initialized successfully.
[   11.482701] [drm] VCE initialized successfully.
[   11.486844] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[   11.486865] kfd kfd: amdgpu: Total number of KFD nodes to be created: 1
[   11.487064] amdgpu: Virtual CRAT table created for GPU
[   11.487125] amdgpu: Topology: Add dGPU node [0x9874:0x1002]
[   11.487128] kfd kfd: amdgpu: added device 1002:9874
[   11.487139] amdgpu 0000:00:01.0: amdgpu: SE 1, SH per SE 1, CU per SH 8,
active_cu_number 8
[   11.488968] amdgpu: pp_dpm_get_sclk_od was not implemented.
[   11.488971] amdgpu: pp_dpm_get_mclk_od was not implemented.
[   11.489094] amdgpu 0000:00:01.0: amdgpu: Runtime PM not available
[   11.490757] amdgpu 0000:00:01.0: amdgpu: [drm] Using custom brightness
curve
[   11.490977] amdgpu 0000:00:01.0: [drm] Registered 3 planes with drm pani=
c
[   11.490980] [drm] Initialized amdgpu 3.63.0 for 0000:00:01.0 on minor 0
[   11.498432] fbcon: amdgpudrmfb (fb0) is primary device
[   12.428917] Console: switching to colour frame buffer device 240x67
[   12.433935] amdgpu 0000:00:01.0: [drm] fb0: amdgpudrmfb frame buffer
device
[   12.440052] [drm] initializing kernel modesetting (POLARIS11
0x1002:0x67EF 0x1028:0x07E2 0xCF).
[   12.441286] [drm] register mmio base: 0xFE800000
[   12.441288] [drm] register mmio size: 262144
[   12.441478] amdgpu 0000:03:00.0: amdgpu: detected ip block number 0
<vi_common>
[   12.441481] amdgpu 0000:03:00.0: amdgpu: detected ip block number 1
<gmc_v8_0>
[   12.441483] amdgpu 0000:03:00.0: amdgpu: detected ip block number 2
<tonga_ih>
[   12.441485] amdgpu 0000:03:00.0: amdgpu: detected ip block number 3
<gfx_v8_0>
[   12.441487] amdgpu 0000:03:00.0: amdgpu: detected ip block number 4
<sdma_v3_0>
[   12.441496] amdgpu 0000:03:00.0: amdgpu: detected ip block number 5
<powerplay>
[   12.441498] amdgpu 0000:03:00.0: amdgpu: detected ip block number 6 <dm>
[   12.441500] amdgpu 0000:03:00.0: amdgpu: detected ip block number 7
<uvd_v6_0>
[   12.441501] amdgpu 0000:03:00.0: amdgpu: detected ip block number 8
<vce_v3_0>
[   12.557053] amdgpu 0000:03:00.0: amdgpu: Fetched VBIOS from ATRM
[   12.557062] amdgpu: ATOM BIOS: SWBRT01017.001
[   12.557376] [drm] UVD is enabled in VM mode
[   12.557378] [drm] UVD ENC is enabled in VM mode
[   12.557381] [drm] VCE enabled in VM mode
[   12.557393] amdgpu 0000:03:00.0: amdgpu: Trusted Memory Zone (TMZ)
feature not supported
[   12.557397] amdgpu 0000:03:00.0: amdgpu: PCIE atomic ops is not supporte=
d
[   12.557406] [drm] GPU posting now...
[   12.568644] [drm] vm size is 64 GB, 2 levels, block size is 10-bit,
fragment size is 9-bit
[   12.568987] amdgpu 0000:03:00.0: BAR 2 [mem 0xf0000000-0xf01fffff 64bit
pref]: releasing
[   12.568992] amdgpu 0000:03:00.0: BAR 0 [mem 0xe0000000-0xefffffff 64bit
pref]: releasing
[   12.569004] pcieport 0000:00:03.1: bridge window [mem
0xe0000000-0xf01fffff 64bit pref]: releasing
[   12.569013] pcieport 0000:00:03.1: bridge window [mem
0x480000000-0x5ffffffff 64bit pref]: assigned
[   12.569016] amdgpu 0000:03:00.0: BAR 0 [mem 0x500000000-0x5ffffffff
64bit pref]: assigned
[   12.569025] amdgpu 0000:03:00.0: BAR 2 [mem 0x480000000-0x4801fffff
64bit pref]: assigned
[   12.569034] pcieport 0000:00:03.1: PCI bridge to [bus 03]
[   12.569037] pcieport 0000:00:03.1:   bridge window [io  0xd000-0xdfff]
[   12.569041] pcieport 0000:00:03.1:   bridge window [mem
0xfe800000-0xfe8fffff]
[   12.569044] pcieport 0000:00:03.1:   bridge window [mem
0x480000000-0x5ffffffff 64bit pref]
[   12.569052] amdgpu 0000:03:00.0: amdgpu: VRAM: 4096M 0x000000F400000000
- 0x000000F4FFFFFFFF (4096M used)
[   12.569054] amdgpu 0000:03:00.0: amdgpu: GART: 256M 0x000000FF00000000 -
0x000000FF0FFFFFFF
[   12.569068] [drm] Detected VRAM RAM=3D4096M, BAR=3D4096M
[   12.569070] [drm] RAM width 128bits GDDR5
[   12.569196] [drm] amdgpu: 4096M of VRAM memory ready
[   12.569199] [drm] amdgpu: 6960M of GTT memory ready.
[   12.569235] [drm] GART: num cpu pages 65536, num gpu pages 65536
[   12.569964] [drm] PCIE GART of 256M enabled (table at
0x000000F4FFF80000).
[   12.571318] [drm] Chained IB support enabled!
[   12.574548] amdgpu: hwmgr_sw_init smu backed is polaris10_smu
[   12.577033] [drm] Found UVD firmware Version: 1.130 Family ID: 16
[   12.578921] [drm] Found VCE firmware Version: 53.26 Binary ID: 3
[   12.911076] [drm] Display Core v3.2.325 initialized on DCE 11.2
[   12.960744] [drm] UVD and UVD ENC initialized successfully.
[   13.071674] [drm] VCE initialized successfully.
[   13.072500] kfd kfd: amdgpu: skipped device 1002:67ef, PCI rejects
atomics 730<0
[   13.072515] amdgpu 0000:03:00.0: amdgpu: SE 2, SH per SE 1, CU per SH 8,
active_cu_number 14
[   13.076889] amdgpu 0000:03:00.0: amdgpu: Using ATPX for runtime pm
[   13.077203] amdgpu 0000:03:00.0: [drm] Registered 5 planes with drm pani=
c
[   13.077206] [drm] Initialized amdgpu 3.63.0 for 0000:03:00.0 on minor 1
[   13.246645] ISO 9660 Extensions: Microsoft Joliet Level 3
[   13.247455] ISO 9660 Extensions: RRIP_1991A
[   38.703983] loop: module loaded
[   38.704839] loop0: detected capacity change from 0 to 1930608
[   38.728074] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[   38.752721] overlayfs: "xino" feature enabled using 2 upper inode bits.
[   39.796919] systemd[1]: systemd 257.7-1-arch running in system mode
(+PAM +AUDIT -SELINUX -APPARMOR -IMA +IPE +SMACK +SECCOMP +GCRYPT +GNUTLS
+OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD
+LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT
+QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +BTF +XKBCOMMON
+UTMP -SYSVINIT +LIBARCHIVE)
[   39.796930] systemd[1]: Detected architecture x86-64.
[   39.823976] systemd[1]: Detected first boot.
[   39.851785] systemd[1]: Hostname set to <archiso>.
[   39.853192] systemd[1]: Initializing machine ID from random generator.
[   40.052281] systemd[1]: bpf-restrict-fs: LSM BPF program attached
[   40.976009] systemd[1]: Populated /etc with preset unit settings.
[   41.249961] systemd[1]: Queued start job for default target Graphical
Interface.
[   41.281971] systemd[1]: Created slice Slice /system/dirmngr.
[   41.282882] systemd[1]: Created slice Slice /system/getty.
[   41.284648] systemd[1]: Created slice Slice /system/gpg-agent.
[   41.285841] systemd[1]: Created slice Slice /system/gpg-agent-browser.
[   41.286996] systemd[1]: Created slice Slice /system/gpg-agent-extra.
[   41.287716] systemd[1]: Created slice Slice /system/gpg-agent-ssh.
[   41.288318] systemd[1]: Created slice Slice /system/keyboxd.
[   41.288918] systemd[1]: Created slice Slice /system/modprobe.
[   41.289315] systemd[1]: Created slice User and Session Slice.
[   41.289436] systemd[1]: Started Dispatch Password Requests to Console
Directory Watch.
[   41.289525] systemd[1]: Started Forward Password Requests to Wall
Directory Watch.
[   41.289755] systemd[1]: Set up automount Arbitrary Executable File
Formats File System Automount Point.
[   41.289838] systemd[1]: Reached target Local Encrypted Volumes.
[   41.289893] systemd[1]: Reached target Local Integrity Protected Volumes=
.
[   41.289957] systemd[1]: Reached target Path Units.
[   41.290003] systemd[1]: Reached target Remote Encrypted Volumes.
[   41.290046] systemd[1]: Reached target Remote File Systems.
[   41.290088] systemd[1]: Reached target Slice Units.
[   41.290133] systemd[1]: Reached target Swaps.
[   41.290194] systemd[1]: Reached target Local Verity Protected Volumes.
[   41.290345] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[   41.290505] systemd[1]: Listening on LVM2 poll daemon socket.
[   41.293056] systemd[1]: Listening on Process Core Dump Socket.
[   41.295092] systemd[1]: Listening on Credential Encryption/Decryption.
[   41.296255] systemd[1]: Listening on Journal Audit Socket.
[   41.297215] systemd[1]: Listening on Journal Socket (/dev/log).
[   41.298197] systemd[1]: Listening on Journal Sockets.
[   41.299149] systemd[1]: Listening on DDI File System Mounter Socket.
[   41.300153] systemd[1]: Listening on Network Service Netlink Socket.
[   41.301089] systemd[1]: Listening on Namespace Resource Manager Socket.
[   41.302717] systemd[1]: TPM PCR Measurements was skipped because of an
unmet condition check (ConditionSecurity=3Dmeasured-uki).
[   41.302752] systemd[1]: Make TPM PCR Policy was skipped because of an
unmet condition check (ConditionSecurity=3Dmeasured-uki).
[   41.302983] systemd[1]: Listening on udev Control Socket.
[   41.304020] systemd[1]: Listening on udev Kernel Socket.
[   41.304977] systemd[1]: Listening on User Database Manager Socket.
[   41.334376] systemd[1]: Mounting Huge Pages File System...
[   41.336423] systemd[1]: Mounting POSIX Message Queue File System...
[   41.338750] systemd[1]: Mounting Kernel Debug File System...
[   41.341644] systemd[1]: Mounting Kernel Trace File System...
[   41.352931] systemd[1]: Mounting Temporary Directory /tmp...
[   41.388053] systemd[1]: Starting Create List of Static Device Nodes...
[   41.392292] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots
etc. using dmeventd or progress polling...
[   41.404000] systemd[1]: Starting Load Kernel Module configfs...
[   41.408710] systemd[1]: Starting Load Kernel Module dm_mod...
[   41.412758] systemd[1]: Starting Load Kernel Module drm...
[   41.416714] systemd[1]: Starting Load Kernel Module efi_pstore...
[   41.420542] systemd[1]: Starting Load Kernel Module fuse...
[   41.424746] systemd[1]: Starting Load Kernel Module loop...
[   41.425545] systemd[1]: Clear Stale Hibernate Storage Info was skipped
because of an unmet condition check
(ConditionPathExists=3D/sys/firmware/efi/efivars/HibernateLocation-8cf2644b=
-4b0b-428f-9387-6d876050dc67).
[   41.427870] systemd[1]: Starting Journal Service...
[   41.478513] device-mapper: uevent: version 1.0.3
[   41.478617] device-mapper: ioctl: 4.49.0-ioctl (2025-01-17) initialised:
dm-devel@lists.linux.dev
[   41.496155] systemd[1]: Starting Load Kernel Modules...
[   41.499380] systemd[1]: Starting Generate network units from Kernel
command line...
[   41.500151] systemd[1]: TPM PCR Machine ID Measurement was skipped
because of an unmet condition check (ConditionSecurity=3Dmeasured-uki).
[   41.505724] systemd[1]: Starting Remount Root and Kernel File Systems...
[   41.510052] systemd[1]: Starting Wait Until Kernel Time Synchronized...
[   41.512642] systemd[1]: Early TPM SRK Setup was skipped because of an
unmet condition check (ConditionSecurity=3Dmeasured-uki).
[   41.517044] systemd[1]: Starting Load udev Rules from Credentials...
[   41.523720] systemd[1]: Starting Coldplug All udev Devices...
[   41.529298] systemd[1]: Mounted Huge Pages File System.
[   41.530141] systemd[1]: Mounted POSIX Message Queue File System.
[   41.530969] systemd[1]: Mounted Kernel Debug File System.
[   41.531777] systemd[1]: Mounted Kernel Trace File System.
[   41.532578] systemd[1]: Mounted Temporary Directory /tmp.
[   41.533598] systemd[1]: Finished Create List of Static Device Nodes.
[   41.534700] systemd[1]: modprobe@configfs.service: Deactivated
successfully.
[   41.534952] systemd[1]: Finished Load Kernel Module configfs.
[   41.536271] systemd[1]: modprobe@dm_mod.service: Deactivated
successfully.
[   41.536511] systemd[1]: Finished Load Kernel Module dm_mod.
[   41.537667] systemd[1]: modprobe@drm.service: Deactivated successfully.
[   41.537873] systemd[1]: Finished Load Kernel Module drm.
[   41.538924] systemd[1]: modprobe@efi_pstore.service: Deactivated
successfully.
[   41.539163] systemd[1]: Finished Load Kernel Module efi_pstore.
[   41.540144] systemd[1]: modprobe@fuse.service: Deactivated successfully.
[   41.540351] systemd[1]: Finished Load Kernel Module fuse.
[   41.541396] systemd[1]: modprobe@loop.service: Deactivated successfully.
[   41.541886] systemd[1]: Finished Load Kernel Module loop.
[   41.543999] systemd[1]: Mounting FUSE Control File System...
[   41.545733] systemd[1]: Mounting Kernel Configuration File System...
[   41.637133] systemd[1]: Repartition Root Disk was skipped because no
trigger condition checks were met.
[   41.638535] systemd[1]: Starting Create Static Device Nodes in /dev
gracefully...
[   41.642840] systemd[1]: Finished Generate network units from Kernel
command line.
[   41.644718] systemd[1]: Finished Remount Root and Kernel File Systems.
[   41.645605] systemd[1]: Mounted FUSE Control File System.
[   41.646435] systemd[1]: Mounted Kernel Configuration File System.
[   41.647297] systemd[1]: Reached target Preparation for Network.
[   41.655628] systemd-journald[532]: Collecting audit messages is enabled.
[   41.757073] systemd[1]: Rebuild Hardware Database was skipped because no
trigger condition checks were met.
[   41.757166] systemd[1]: Platform Persistent Storage Archival was skipped
because of an unmet condition check
(ConditionDirectoryNotEmpty=3D/sys/fs/pstore).
[   41.760184] systemd[1]: Starting Load/Save OS Random Seed...
[   41.763578] systemd[1]: TPM SRK Setup was skipped because of an unmet
condition check (ConditionSecurity=3Dmeasured-uki).
[   41.764402] systemd[1]: Started Journal Service.
[   41.765310] audit: type=3D1130 audit(1770273939.755:2): pid=3D1 uid=3D0
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-journald comm=3D"s=
ystemd"
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Ds=
uccess'
[   41.777524] audit: type=3D1130 audit(1770273939.767:3): pid=3D1 uid=3D0
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-udev-load-credenti=
als
comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? ter=
minal=3D?
res=3Dsuccess'
[   41.805393] Asymmetric key parser 'pkcs8' registered
[   41.807525] audit: type=3D1130 audit(1770273939.797:4): pid=3D1 uid=3D0
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-modules-load
comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? ter=
minal=3D?
res=3Dsuccess'
[   41.892147] audit: type=3D1130 audit(1770273939.882:5): pid=3D1 uid=3D0
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-random-seed comm=
=3D"systemd"
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Ds=
uccess'
[   41.902735] audit: type=3D1130 audit(1770273939.893:6): pid=3D1 uid=3D0
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-udev-trigger
comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? ter=
minal=3D?
res=3Dsuccess'
[   41.986332] systemd-journald[532]: Received client request to flush
runtime journal.
[   41.989019] audit: type=3D1130 audit(1770273939.979:7): pid=3D1 uid=3D0
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-journal-flush
comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? ter=
minal=3D?
res=3Dsuccess'
[   42.044719] audit: type=3D1130 audit(1770273940.035:8): pid=3D1 uid=3D0
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-sysctl comm=3D"sys=
temd"
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Ds=
uccess'
[   42.070815] audit: type=3D1334 audit(1770273940.061:9): prog-id=3D25 op=
=3DLOAD
[   42.070922] audit: type=3D1334 audit(1770273940.061:10): prog-id=3D26 op=
=3DLOAD
[   42.070954] audit: type=3D1334 audit(1770273940.061:11): prog-id=3D27 op=
=3DLOAD
[   43.619692] cfg80211: Loading compiled-in X.509 certificates for
regulatory database
[   43.627913] r8169 0000:02:00.0 enp2s0: renamed from eth0
[   43.677599] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   43.677819] Loaded X.509 cert 'wens:
61c038651aabdcf94bd0ac7ff06c7248db18c600'
[   43.697124] input: DELL Wireless hotkeys as
/devices/virtual/input/input19
[   43.737974] dcdbas dcdbas: Dell Systems Management Base Driver (version
5.6.0-3.4)
[   43.745928] dell-smbios A80593CE-A997-11DA-B012-B622A1EF5492: WMI SMBIOS
userspace interface not supported(0), try upgrading to a newer BIOS
[   43.816760] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00,
revision 0
[   43.816768] piix4_smbus 0000:00:14.0: Using register 0x02 for SMBus port
selection
[   43.817734] i2c i2c-5: Successfully instantiated SPD at 0x50
[   43.818332] i2c i2c-5: Successfully instantiated SPD at 0x51
[   43.818396] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Controller at
0xb20
[   43.840460] input: PC Speaker as /devices/platform/pcspkr/input/input21
[   43.937251] input: ELAN1010:00 04F3:3012 Mouse as
/devices/platform/AMD0010:00/i2c-0/i2c-ELAN1010:00/0018:04F3:3012.0001/inpu=
t/input22
[   43.937466] input: ELAN1010:00 04F3:3012 Touchpad as
/devices/platform/AMD0010:00/i2c-0/i2c-ELAN1010:00/0018:04F3:3012.0001/inpu=
t/input23
[   43.937555] hid-generic 0018:04F3:3012.0001: input,hidraw0: I2C HID
v1.00 Mouse [ELAN1010:00 04F3:3012] on i2c-ELAN1010:00
[   44.100710] psmouse serio1: elantech: assuming hardware version 4 (with
firmware version 0x4d5f02)
[   44.113931] psmouse serio1: elantech: Synaptics capabilities query
result 0x00, 0x15, 0x10.
[   44.127739] psmouse serio1: elantech: Elan sample query result 0c, 02, 7=
5
[   44.205227] input: ETPS/2 Elantech Touchpad as
/devices/platform/i8042/serio1/input/input20
[   44.254176] input: Dell WMI hotkeys as
/devices/platform/PNP0C14:00/wmi_bus/wmi_bus-PNP0C14:00/9DBB5994-A997-11DA-=
B012-B622A1EF5492/input/input24
[   44.254735] Bluetooth: Core ver 2.22
[   44.254779] NET: Registered PF_BLUETOOTH protocol family
[   44.254781] Bluetooth: HCI device and connection manager initialized
[   44.254787] Bluetooth: HCI socket layer initialized
[   44.254790] Bluetooth: L2CAP socket layer initialized
[   44.254794] Bluetooth: SCO socket layer initialized
[   44.299869] mousedev: PS/2 mouse device common for all mice
[   44.412234] input: ELAN1010:00 04F3:3012 Mouse as
/devices/platform/AMD0010:00/i2c-0/i2c-ELAN1010:00/0018:04F3:3012.0001/inpu=
t/input25
[   44.413714] input: ELAN1010:00 04F3:3012 Touchpad as
/devices/platform/AMD0010:00/i2c-0/i2c-ELAN1010:00/0018:04F3:3012.0001/inpu=
t/input26
[   44.414881] hid-multitouch 0018:04F3:3012.0001: input,hidraw0: I2C HID
v1.00 Mouse [ELAN1010:00 04F3:3012] on i2c-ELAN1010:00
[   44.424240] usbcore: registered new interface driver btusb
[   44.428215] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver
[   44.428339] sp5100-tco sp5100-tco: Using 0xfed80b00 for watchdog MMIO
address
[   44.428345] sp5100-tco sp5100-tco: Watchdog hardware is disabled
[   44.609556] Bluetooth: hci0: using rampatch file:
qca/rampatch_usb_00000302.bin
[   44.609564] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware
rome 0x302 build 0x111
[   44.644988] ee1004 5-0050: 512 byte EE1004-compliant SPD EEPROM,
read-only
[   44.646910] ee1004 5-0051: 512 byte EE1004-compliant SPD EEPROM,
read-only
[   44.741832] ath10k_pci 0000:01:00.0: pci irq msi oper_irq_mode 2
irq_mode 0 reset_mode 0
[   44.793889] snd_hda_intel 0000:00:01.1: Force to non-snoop mode
[   44.836727] snd_hda_intel 0000:00:01.1: bound 0000:00:01.0 (ops
amdgpu_dm_audio_component_bind_ops [amdgpu])
[   44.849685] input: HDA ATI HDMI HDMI/DP,pcm=3D3 as
/devices/pci0000:00/0000:00:01.1/sound/card0/input27
[   44.877404] snd_hda_codec_realtek hdaudioC1D0: ALC3246: picked fixup
 (pin match)
[   44.910881] snd_hda_codec_realtek hdaudioC1D0: autoconfig for ALC3246:
line_outs=3D1 (0x14/0x0/0x0/0x0/0x0) type:speaker
[   44.910896] snd_hda_codec_realtek hdaudioC1D0:    speaker_outs=3D0
(0x0/0x0/0x0/0x0/0x0)
[   44.910899] snd_hda_codec_realtek hdaudioC1D0:    hp_outs=3D1
(0x21/0x0/0x0/0x0/0x0)
[   44.910902] snd_hda_codec_realtek hdaudioC1D0:    mono: mono_out=3D0x0
[   44.910904] snd_hda_codec_realtek hdaudioC1D0:    inputs:
[   44.910905] snd_hda_codec_realtek hdaudioC1D0:      Internal Mic=3D0x12
[   44.910907] snd_hda_codec_realtek hdaudioC1D0:      Headset Mic=3D0x19
[   44.910910] snd_hda_codec_realtek hdaudioC1D0:      Headphone Mic=3D0x1a
[   44.932611] wl: loading out-of-tree module taints kernel.
[   44.932621] wl: module license 'MIXED/Proprietary' taints kernel.
[   44.932622] Disabling lock debugging due to kernel taint
[   44.932624] wl: module verification failed: signature and/or required
key missing - tainting kernel
[   44.932625] wl: module license taints kernel.
[   44.976558] You are using the broadcom-wl driver, which is not
maintained and is incompatible with Linux kernel security mitigations. It
is heavily recommended to replace the hardware and remove the driver.
Proceed at your own risk!
[   44.976566] ------------[ cut here ]------------
[   44.976568] Unpatched return thunk in use. This should not happen!
[   44.976573] WARNING: CPU: 1 PID: 637 at arch/x86/kernel/cpu/bugs.c:3230
__warn_thunk+0x2a/0x40
[   44.976583] Modules linked in: wl(POE+) kvm snd_hda_codec_realtek(+)
snd_hda_codec_generic snd_hda_scodec_component irqbypass snd_hda_codec_hdmi
snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi dell_pc ath10k_pci
snd_ctl_led snd_hda_codec snd_hda_core snd_hwdep ath10k_core snd_pcm
snd_timer ath ee1004 snd polyval_clmulni soundcore platform_profile
mac80211 rtsx_usb_ms libarc4 polyval_generic sp5100_tco dell_laptop btusb
joydev hid_multitouch memstick mousedev ghash_clmulni_intel btrtl btintel
btbcm btmtk dell_wmi dell_smm_hwmon bluetooth sparse_keymap sha1_ssse3
pcspkr i2c_piix4 i2c_hid_acpi dell_smbios dcdbas dell_wmi_descriptor
dell_rbtn psmouse wmi_bmof i2c_hid i2c_smbus fam15h_power k10temp cfg80211
mac_hid rfkill pkcs8_key_parser dm_mod nfnetlink ip_tables x_tables overlay
squashfs loop isofs cdrom amdgpu amdxcp gpu_sched rtsx_usb_sdmmc
drm_panel_backlight_quirks drm_buddy mmc_core drm_exec sha512_ssse3
drm_suballoc_helper sha256_ssse3 r8169 drm_ttm_helper aesni_intel realtek
ttm crypto_simd cryptd i2c_algo_bit
[   44.976646]  mdio_devres uas serio_raw rtsx_usb drm_display_helper
libphy usb_storage cec video wmi
[   44.976657] CPU: 1 UID: 0 PID: 637 Comm: (udev-worker) Tainted: P
    OE       6.15.4-arch2-1 #1 PREEMPT(full)
 bf56011d6043294f437da1888a30a6d02e6dd116
[   44.976663] Tainted: [P]=3DPROPRIETARY_MODULE, [O]=3DOOT_MODULE,
[E]=3DUNSIGNED_MODULE
[   44.976665] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7
01/29/2018
[   44.976675] RIP: 0010:__warn_thunk+0x2a/0x40
[   44.976679] Code: 66 0f 1f 00 0f 1f 44 00 00 80 3d 8c 23 59 02 00 74 05
e9 59 05 04 01 48 c7 c7 d8 89 59 96 c6 05 77 23 59 02 01 e8 e6 bc 06 00
<0f> 0b e9 3f 05 04 01 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00
[   44.976681] RSP: 0018:ffffd08642e8fbb8 EFLAGS: 00010246
[   44.976684] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
0000000000000027
[   44.976685] RDX: ffff8c59a0c9cbc8 RSI: 0000000000000001 RDI:
ffff8c59a0c9cbc0
[   44.976687] RBP: ffffd08642e8fc08 R08: 0000000000000000 R09:
00000000ffffefff
[   44.976688] R10: ffffffff97060f20 R11: ffffd08642e8fa50 R12:
ffffffffc26a9b05
[   44.976690] R13: ffffffffc0ffc010 R14: 00007f2ff056d2f2 R15:
0000000000000000
[   44.976692] FS:  00007f2ff2053880(0000) GS:ffff8c5a08faf000(0000)
knlGS:0000000000000000
[   44.976694] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   44.976695] CR2: 00007fb941b1a000 CR3: 0000000119d1b000 CR4:
00000000001506f0
[   44.976697] Call Trace:
[   44.976700]  <TASK>
[   44.976701]  warn_thunk_thunk+0x16/0x30
[   44.976714]  getvar+0x20/0x70 [wl
549af82e86b3a0529f547b91bef45f08130629c2]
[   44.976790]  ? __UNIQUE_ID_vermagic475+0x2f797d40943c/0x2f797d40943c [wl
549af82e86b3a0529f547b91bef45f08130629c2]
[   44.976826]  wl_module_init+0x23/0xb0 [wl
549af82e86b3a0529f547b91bef45f08130629c2]
[   44.976861]  ? do_one_initcall+0x5b/0x300
[   44.976865]  ? do_init_module+0x62/0x240
[   44.976870]  ? init_module_from_file+0x8a/0xe0
[   44.976874]  ? idempotent_init_module+0x114/0x310
[   44.976878]  ? __x64_sys_finit_module+0x67/0xc0
[   44.976881]  ? do_syscall_64+0x7b/0x810
[   44.976887]  ? switch_fpu_return+0x4e/0xd0
[   44.976890]  ? arch_exit_to_user_mode_prepare.isra.0+0x7c/0x90
[   44.976892]  ? syscall_exit_to_user_mode+0x37/0x1c0
[   44.976895]  ? do_syscall_64+0x87/0x810
[   44.976897]  ? irqentry_exit_to_user_mode+0x2c/0x1b0
[   44.976900]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   44.976904]  </TASK>
[   44.976905] ---[ end trace 0000000000000000 ]---
[   45.062865] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
[   45.085789] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection
command is advertised, but not supported.
[   45.088568] ath10k_pci 0000:01:00.0: qca9377 hw1.1 target 0x05020001
chip_id 0x003821ff sub 1028:1810
[   45.088576] ath10k_pci 0000:01:00.0: kconfig debug 1 debugfs 1 tracing 1
dfs 0 testmode 0
[   45.088699] ath10k_pci 0000:01:00.0: firmware ver
WLAN.TF.2.1-00021-QCARMSWP-1 api 6 features wowlan,ignore-otp crc32 42e4187=
7
[   45.093607] kvm_amd: TSC scaling supported
[   45.093614] kvm_amd: Nested Virtualization enabled
[   45.093615] kvm_amd: Nested Paging enabled
[   45.093617] kvm_amd: LBR virtualization supported
[   45.093622] kvm_amd: Virtual GIF supported
[   45.103555] Generic FE-GE Realtek PHY r8169-0-200:00: attached PHY
driver (mii_bus:phy_addr=3Dr8169-0-200:00, irq=3DMAC)
[   45.108806] input: HD-Audio Generic Headphone Mic as
/devices/pci0000:00/0000:00:09.2/sound/card1/input28
[   45.159204] ath10k_pci 0000:01:00.0: board_file api 2 bmi_id N/A crc32
8aedfa4a
[   45.270679] r8169 0000:02:00.0 enp2s0: Link is Down
[   45.329901] ath10k_pci 0000:01:00.0: htt-ver 3.56 wmi-op 4 htt-op 3 cal
otp max-sta 32 raw 0 hwcrypto 1
[   45.388418] ath: EEPROM regdomain: 0x6c
[   45.388426] ath: EEPROM indicates we should expect a direct regpair map
[   45.388428] ath: Country alpha2 being used: 00
[   45.388430] ath: Regpair used: 0x6c
[   48.966269] kauditd_printk_skb: 132 callbacks suppressed
[   48.966274] audit: type=3D1130 audit(1770273946.956:86): pid=3D1 uid=3D0
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dldconfig comm=3D"systemd"
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Ds=
uccess'
[   49.011037] audit: type=3D1130 audit(1770273947.001:87): pid=3D1 uid=3D0
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-update-done comm=
=3D"systemd"
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Ds=
uccess'
[   49.027087] audit: type=3D1334 audit(1770273947.017:88): prog-id=3D54 op=
=3DLOAD
[   49.113344] audit: type=3D1130 audit(1770273947.103:89): pid=3D1 uid=3D0
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Ddbus-broker comm=3D"system=
d"
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Ds=
uccess'
[   49.119593] audit: type=3D1334 audit(1770273947.110:90): prog-id=3D55 op=
=3DLOAD
[   49.123271] audit: type=3D1334 audit(1770273947.113:91): prog-id=3D56 op=
=3DLOAD
[   49.136111] audit: type=3D1334 audit(1770273947.126:92): prog-id=3D57 op=
=3DLOAD
[   49.141195] audit: type=3D1334 audit(1770273947.131:93): prog-id=3D58 op=
=3DLOAD
[   49.141619] audit: type=3D1334 audit(1770273947.131:94): prog-id=3D59 op=
=3DLOAD
[   49.141649] audit: type=3D1334 audit(1770273947.131:95): prog-id=3D60 op=
=3DLOAD
[   49.273168] NET: Registered PF_ALG protocol family
[   49.621612] NET: Registered PF_QIPCRTR protocol family
[   54.984555] kauditd_printk_skb: 13 callbacks suppressed
[   54.984561] audit: type=3D1101 audit(1770273952.974:109): pid=3D866 uid=
=3D0
auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting
grantors=3Dpam_access,pam_unix,pam_permit,pam_time acct=3D"root"
exe=3D"/usr/bin/login" hostname=3Darchiso addr=3D? terminal=3D/dev/tty1 res=
=3Dsuccess'
[   55.011362] audit: type=3D1103 audit(1770273953.001:110): pid=3D866 uid=
=3D0
auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred
grantors=3Dpam_shells,pam_faillock,pam_permit,pam_env,pam_faillock
acct=3D"root" exe=3D"/usr/bin/login" hostname=3Darchiso addr=3D? terminal=
=3D/dev/tty1
res=3Dsuccess'
[   55.011406] audit: type=3D1006 audit(1770273953.001:111): pid=3D866 uid=
=3D0
old-auid=3D4294967295 auid=3D0 tty=3Dtty1 old-ses=3D4294967295 ses=3D1 res=
=3D1
[   55.011417] audit: type=3D1300 audit(1770273953.001:111): arch=3Dc000003=
e
syscall=3D1 success=3Dyes exit=3D1 a0=3D3 a1=3D7ffc79f80020 a2=3D1 a3=3D0 i=
tems=3D0 ppid=3D1
pid=3D866 auid=3D0 uid=3D0 gid=3D0 euid=3D0 suid=3D0 fsuid=3D0 egid=3D0 sgi=
d=3D0 fsgid=3D0
tty=3Dtty1 ses=3D1 comm=3D"login" exe=3D"/usr/bin/login" key=3D(null)
[   55.011421] audit: type=3D1327 audit(1770273953.001:111):
proctitle=3D2F62696E2F6C6F67696E002D70002D66002D2D
[   55.104082] audit: type=3D1130 audit(1770273953.094:112): pid=3D1 uid=3D=
0
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Duser-runtime-dir@0 comm=3D=
"systemd"
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Ds=
uccess'
[   55.127409] audit: type=3D1101 audit(1770273953.117:113): pid=3D876 uid=
=3D0
auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting
grantors=3Dpam_access,pam_unix,pam_permit,pam_time acct=3D"root"
exe=3D"/usr/lib/systemd/systemd-executor" hostname=3D? addr=3D? terminal=3D=
?
res=3Dsuccess'
[   55.127469] audit: type=3D1103 audit(1770273953.117:114): pid=3D876 uid=
=3D0
auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred grantors=3D? acc=
t=3D"root"
exe=3D"/usr/lib/systemd/systemd-executor" hostname=3D? addr=3D? terminal=3D=
?
res=3Dfailed'
[   55.127547] audit: type=3D1006 audit(1770273953.118:115): pid=3D876 uid=
=3D0
old-auid=3D4294967295 auid=3D0 tty=3D(none) old-ses=3D4294967295 ses=3D2 re=
s=3D1
[   55.127551] audit: type=3D1300 audit(1770273953.118:115): arch=3Dc000003=
e
syscall=3D1 success=3Dyes exit=3D1 a0=3D8 a1=3D7ffffa356ae0 a2=3D1 a3=3D0 i=
tems=3D0 ppid=3D1
pid=3D876 auid=3D0 uid=3D0 gid=3D0 euid=3D0 suid=3D0 fsuid=3D0 egid=3D0 sgi=
d=3D0 fsgid=3D0
tty=3D(none) ses=3D2 comm=3D"(systemd)" exe=3D"/usr/lib/systemd/systemd-exe=
cutor"
key=3D(null)
[  156.754056] PM: suspend entry (deep)
[  156.754099] Filesystems sync: 0.000 seconds
[  156.757908] Freezing user space processes
[  156.759436] Freezing user space processes completed (elapsed 0.001
seconds)
[  156.759450] OOM killer disabled.
[  156.759452] Freezing remaining freezable tasks
[  156.760785] Freezing remaining freezable tasks completed (elapsed 0.001
seconds)
[  156.760851] printk: Suspending console(s) (use no_console_suspend to
debug)
[  156.950461] ------------[ cut here ]------------
[  156.950468] WARNING: CPU: 2 PID: 944 at
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:3008
dm_prepare_suspend+0x44/0x50 [amdgpu]
[  156.951785] Modules linked in: ccm algif_aead qrtr crypto_null
des3_ede_x86_64 des_generic libdes algif_skcipher cmac md4 algif_hash
af_alg kvm_amd ccp wl(POE) kvm snd_hda_codec_realtek snd_hda_codec_generic
snd_hda_scodec_component irqbypass snd_hda_codec_hdmi snd_hda_intel
snd_intel_dspcfg snd_intel_sdw_acpi dell_pc ath10k_pci snd_ctl_led
snd_hda_codec snd_hda_core snd_hwdep ath10k_core snd_pcm snd_timer ath
ee1004 snd polyval_clmulni soundcore platform_profile mac80211 rtsx_usb_ms
libarc4 polyval_generic sp5100_tco dell_laptop btusb joydev hid_multitouch
memstick mousedev ghash_clmulni_intel btrtl btintel btbcm btmtk dell_wmi
dell_smm_hwmon bluetooth sparse_keymap sha1_ssse3 pcspkr i2c_piix4
i2c_hid_acpi dell_smbios dcdbas dell_wmi_descriptor dell_rbtn psmouse
wmi_bmof i2c_hid i2c_smbus fam15h_power k10temp cfg80211 mac_hid rfkill
pkcs8_key_parser dm_mod nfnetlink ip_tables x_tables overlay squashfs loop
isofs cdrom amdgpu amdxcp gpu_sched rtsx_usb_sdmmc
drm_panel_backlight_quirks drm_buddy mmc_core drm_exec
[  156.951859]  sha512_ssse3 drm_suballoc_helper sha256_ssse3 r8169
drm_ttm_helper aesni_intel realtek ttm crypto_simd cryptd i2c_algo_bit
mdio_devres uas serio_raw rtsx_usb drm_display_helper libphy usb_storage
cec video wmi
[  156.951881] CPU: 2 UID: 0 PID: 944 Comm: systemd-sleep Tainted: P
 W  OE       6.15.4-arch2-1 #1 PREEMPT(full)
 bf56011d6043294f437da1888a30a6d02e6dd116
[  156.951887] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_MOD=
ULE,
[E]=3DUNSIGNED_MODULE
[  156.951889] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7
01/29/2018
[  156.951891] RIP: 0010:dm_prepare_suspend+0x44/0x50 [amdgpu]
[  156.953187] Code: 48 83 bb 60 6c 04 00 00 75 20 48 8d 7b 10 e8 23 0b d0
d4 48 89 83 60 6c 04 00 48 3d 00 f0 ff ff 77 02 31 c0 5b e9 8c 80 1e d5
<0f> 0b eb dc 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90
[  156.953189] RSP: 0018:ffffd0864370ba98 EFLAGS: 00010282
[  156.953192] RAX: 0000000000000000 RBX: ffff8c5717d00000 RCX:
0000000000000000
[  156.953194] RDX: ffff8c5718043600 RSI: 000000007fffffff RDI:
ffff8c5717d00000
[  156.953195] RBP: 0000000000000006 R08: ffffd0864370b9e0 R09:
ffff8c5717d0fb68
[  156.953196] R10: ffff8c5717d0fb08 R11: 0000000000000000 R12:
ffff8c5717d00010
[  156.953197] R13: 0000000000000000 R14: 0000000000000002 R15:
000000007f89bb00
[  156.953198] FS:  00007fa0da923880(0000) GS:ffff8c5a0902f000(0000)
knlGS:0000000000000000
[  156.953200] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  156.953201] CR2: 000055a701f39168 CR3: 000000010f832000 CR4:
00000000001506f0
[  156.953203] Call Trace:
[  156.953210]  <TASK>
[  156.953215]  amdgpu_device_prepare+0x8b/0xc0 [amdgpu
fd2a24652620738c2ec44a27ca03228c2099e273]
[  156.954448]  pci_pm_prepare+0x2c/0x70
[  156.954457]  dpm_prepare+0x166/0x4d0
[  156.954463]  ? __pfx_pci_pm_prepare+0x10/0x10
[  156.954466]  dpm_suspend_start+0x1e/0x60
[  156.954468]  suspend_devices_and_enter+0x168/0x880
[  156.954474]  pm_suspend.cold+0x303/0x36b
[  156.954479]  state_store+0x6c/0xd0
[  156.954483]  kernfs_fop_write_iter+0x138/0x1f0
[  156.954488]  vfs_write+0x28e/0x470
[  156.954498]  ksys_write+0x73/0xe0
[  156.954501]  do_syscall_64+0x7b/0x810
[  156.954506]  ? __mod_memcg_lruvec_state+0xb1/0x1c0
[  156.954510]  ? __lruvec_stat_mod_folio+0x85/0xd0
[  156.954513]  ? __folio_mod_stat+0x2d/0x90
[  156.954517]  ? set_ptes.isra.0+0x36/0x80
[  156.954520]  ? do_anonymous_page+0xf7/0x8b0
[  156.954522]  ? ___pte_offset_map+0x1b/0x180
[  156.954525]  ? __handle_mm_fault+0xb46/0xfd0
[  156.954528]  ? __count_memcg_events+0xb0/0x150
[  156.954530]  ? count_memcg_events.constprop.0+0x1a/0x30
[  156.954532]  ? handle_mm_fault+0x1d2/0x2d0
[  156.954534]  ? do_user_addr_fault+0x21a/0x690
[  156.954538]  ? irqentry_exit_to_user_mode+0x2c/0x1b0
[  156.954542]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  156.954545] RIP: 0033:0x7fa0da78a006
[  156.954569] Code: 5d e8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 75 19 83
e2 39 83 fa 08 75 11 e8 26 ff ff ff 66 0f 1f 44 00 00 48 8b 45 10 0f 05
<48> 8b 5d f8 c9 c3 0f 1f 40 00 f3 0f 1e fa 55 48 89 e5 48 83 ec 08
[  156.954571] RSP: 002b:00007ffeb73d8e50 EFLAGS: 00000202 ORIG_RAX:
0000000000000001
[  156.954573] RAX: ffffffffffffffda RBX: 0000000000000004 RCX:
00007fa0da78a006
[  156.954575] RDX: 0000000000000004 RSI: 000055a701f39870 RDI:
0000000000000007
[  156.954576] RBP: 00007ffeb73d8e70 R08: 0000000000000000 R09:
0000000000000000
[  156.954577] R10: 0000000000000000 R11: 0000000000000202 R12:
0000000000000004
[  156.954578] R13: 000055a701f39870 R14: 000055a701f312a0 R15:
00007ffeb73d9000
[  156.954581]  </TASK>
[  156.954582] ---[ end trace 0000000000000000 ]---
[  157.188778] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[  157.193757] ata1.00: Entering standby power mode
[  157.438247] [drm] PCIE GART of 256M enabled (table at
0x000000F4FFF80000).
[  157.707831] amdgpu 0000:03:00.0: [drm:amdgpu_ring_test_helper [amdgpu]]
*ERROR* ring comp_1.0.1 test failed (-110)
[  159.027308] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding,
trying to reset the VCPU!!!
[  160.048538] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding,
trying to reset the VCPU!!!
[  161.069752] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding,
trying to reset the VCPU!!!
[  162.090976] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding,
trying to reset the VCPU!!!
[  163.112200] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding,
trying to reset the VCPU!!!
[  164.133425] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding,
trying to reset the VCPU!!!
[  165.154643] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding,
trying to reset the VCPU!!!
[  166.175857] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding,
trying to reset the VCPU!!!
[  167.197087] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding,
trying to reset the VCPU!!!
[  168.218294] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding,
trying to reset the VCPU!!!
[  168.239193] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding,
giving up!!!
[  168.240067] [drm:amdgpu_device_ip_set_powergating_state [amdgpu]]
*ERROR* set_powergating_state of IP block <uvd_v6_0> failed -1
[  168.511268] amdgpu 0000:03:00.0: [drm:amdgpu_ring_test_helper [amdgpu]]
*ERROR* ring uvd test failed (-110)
[  168.512140] amdgpu 0000:03:00.0: amdgpu: resume of IP block <uvd_v6_0>
failed -110
[  168.512144] amdgpu 0000:03:00.0: amdgpu: amdgpu_device_ip_resume failed
(-110).
[  168.512751] ------------[ cut here ]------------
[  168.512753] WARNING: CPU: 0 PID: 13 at
drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:631 amdgpu_irq_put+0x46/0x70
[amdgpu]
[  168.513638] Modules linked in: ccm algif_aead qrtr crypto_null
des3_ede_x86_64 des_generic libdes algif_skcipher cmac md4 algif_hash
af_alg kvm_amd ccp wl(POE) kvm snd_hda_codec_realtek snd_hda_codec_generic
snd_hda_scodec_component irqbypass snd_hda_codec_hdmi snd_hda_intel
snd_intel_dspcfg snd_intel_sdw_acpi dell_pc ath10k_pci snd_ctl_led
snd_hda_codec snd_hda_core snd_hwdep ath10k_core snd_pcm snd_timer ath
ee1004 snd polyval_clmulni soundcore platform_profile mac80211 rtsx_usb_ms
libarc4 polyval_generic sp5100_tco dell_laptop btusb joydev hid_multitouch
memstick mousedev ghash_clmulni_intel btrtl btintel btbcm btmtk dell_wmi
dell_smm_hwmon bluetooth sparse_keymap sha1_ssse3 pcspkr i2c_piix4
i2c_hid_acpi dell_smbios dcdbas dell_wmi_descriptor dell_rbtn psmouse
wmi_bmof i2c_hid i2c_smbus fam15h_power k10temp cfg80211 mac_hid rfkill
pkcs8_key_parser dm_mod nfnetlink ip_tables x_tables overlay squashfs loop
isofs cdrom amdgpu amdxcp gpu_sched rtsx_usb_sdmmc
drm_panel_backlight_quirks drm_buddy mmc_core drm_exec
[  168.513703]  sha512_ssse3 drm_suballoc_helper sha256_ssse3 r8169
drm_ttm_helper aesni_intel realtek ttm crypto_simd cryptd i2c_algo_bit
mdio_devres uas serio_raw rtsx_usb drm_display_helper libphy usb_storage
cec video wmi
[  168.513721] CPU: 0 UID: 0 PID: 13 Comm: kworker/u16:1 Tainted: P
 W  OE       6.15.4-arch2-1 #1 PREEMPT(full)
 bf56011d6043294f437da1888a30a6d02e6dd116
[  168.513727] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_MOD=
ULE,
[E]=3DUNSIGNED_MODULE
[  168.513728] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7
01/29/2018
[  168.513730] Workqueue: async async_run_entry_fn
[  168.513737] RIP: 0010:amdgpu_irq_put+0x46/0x70 [amdgpu]
[  168.514625] Code: c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 d1 48 8d 04
88 8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9 5f c6 44 d5 e9 5a fd ff ff
<0f> 0b b8 ea ff ff ff e9 4e c6 44 d5 b8 ea ff ff ff e9 44 c6 44 d5
[  168.514627] RSP: 0018:ffffd0864011fd10 EFLAGS: 00010246
[  168.514629] RAX: ffff8c57107c4500 RBX: ffff8c5717d18b50 RCX:
0000000000000000
[  168.514631] RDX: 0000000000000000 RSI: ffff8c5717d259a0 RDI:
ffff8c5717d00000
[  168.514632] RBP: ffff8c5717d10388 R08: ffffd0864011fc98 R09:
ffff8c5717d0fb68
[  168.514633] R10: ffff8c5717d0fb08 R11: 0000000000000000 R12:
ffff8c5717d10830
[  168.514634] R13: 0000000000000002 R14: ffff8c5717d00000 R15:
ffff8c5717d259a0
[  168.514636] FS:  0000000000000000(0000) GS:ffff8c5a08f2f000(0000)
knlGS:0000000000000000
[  168.514637] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  168.514638] CR2: 00007fb941b67000 CR3: 000000010f832000 CR4:
00000000001506f0
[  168.514640] Call Trace:
[  168.514644]  <TASK>
[  168.514646]  amdgpu_fence_driver_hw_fini+0xf9/0x130 [amdgpu
fd2a24652620738c2ec44a27ca03228c2099e273]
[  168.515512]  amdgpu_device_suspend+0xbc/0x160 [amdgpu
fd2a24652620738c2ec44a27ca03228c2099e273]
[  168.516370]  pci_pm_suspend+0x80/0x170
[  168.516375]  ? __pfx_pci_pm_suspend+0x10/0x10
[  168.516377]  dpm_run_callback+0x4a/0x150
[  168.516382]  device_suspend+0x14d/0x540
[  168.516385]  async_suspend+0x21/0x30
[  168.516387]  async_run_entry_fn+0x36/0x140
[  168.516392]  process_one_work+0x193/0x350
[  168.516396]  worker_thread+0x2d7/0x410
[  168.516398]  ? __pfx_worker_thread+0x10/0x10
[  168.516400]  kthread+0xfc/0x240
[  168.516403]  ? __pfx_kthread+0x10/0x10
[  168.516405]  ret_from_fork+0x34/0x50
[  168.516408]  ? __pfx_kthread+0x10/0x10
[  168.516410]  ret_from_fork_asm+0x1a/0x30
[  168.516415]  </TASK>
[  168.516416] ---[ end trace 0000000000000000 ]---
[  168.516517] ------------[ cut here ]------------
[  168.516518] WARNING: CPU: 0 PID: 13 at
drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:631 amdgpu_irq_put+0x46/0x70
[amdgpu]
[  168.517406] Modules linked in: ccm algif_aead qrtr crypto_null
des3_ede_x86_64 des_generic libdes algif_skcipher cmac md4 algif_hash
af_alg kvm_amd ccp wl(POE) kvm snd_hda_codec_realtek snd_hda_codec_generic
snd_hda_scodec_component irqbypass snd_hda_codec_hdmi snd_hda_intel
snd_intel_dspcfg snd_intel_sdw_acpi dell_pc ath10k_pci snd_ctl_led
snd_hda_codec snd_hda_core snd_hwdep ath10k_core snd_pcm snd_timer ath
ee1004 snd polyval_clmulni soundcore platform_profile mac80211 rtsx_usb_ms
libarc4 polyval_generic sp5100_tco dell_laptop btusb joydev hid_multitouch
memstick mousedev ghash_clmulni_intel btrtl btintel btbcm btmtk dell_wmi
dell_smm_hwmon bluetooth sparse_keymap sha1_ssse3 pcspkr i2c_piix4
i2c_hid_acpi dell_smbios dcdbas dell_wmi_descriptor dell_rbtn psmouse
wmi_bmof i2c_hid i2c_smbus fam15h_power k10temp cfg80211 mac_hid rfkill
pkcs8_key_parser dm_mod nfnetlink ip_tables x_tables overlay squashfs loop
isofs cdrom amdgpu amdxcp gpu_sched rtsx_usb_sdmmc
drm_panel_backlight_quirks drm_buddy mmc_core drm_exec
[  168.517469]  sha512_ssse3 drm_suballoc_helper sha256_ssse3 r8169
drm_ttm_helper aesni_intel realtek ttm crypto_simd cryptd i2c_algo_bit
mdio_devres uas serio_raw rtsx_usb drm_display_helper libphy usb_storage
cec video wmi
[  168.517487] CPU: 0 UID: 0 PID: 13 Comm: kworker/u16:1 Tainted: P
 W  OE       6.15.4-arch2-1 #1 PREEMPT(full)
 bf56011d6043294f437da1888a30a6d02e6dd116
[  168.517491] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_MOD=
ULE,
[E]=3DUNSIGNED_MODULE
[  168.517492] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7
01/29/2018
[  168.517503] Workqueue: async async_run_entry_fn
[  168.517509] RIP: 0010:amdgpu_irq_put+0x46/0x70 [amdgpu]
[  168.518373] Code: c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 d1 48 8d 04
88 8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9 5f c6 44 d5 e9 5a fd ff ff
<0f> 0b b8 ea ff ff ff e9 4e c6 44 d5 b8 ea ff ff ff e9 44 c6 44 d5
[  168.518375] RSP: 0018:ffffd0864011fd10 EFLAGS: 00010246
[  168.518378] RAX: ffff8c57107c4508 RBX: ffff8c5717d19198 RCX:
0000000000000000
[  168.518379] RDX: 0000000000000002 RSI: ffff8c5717d259a0 RDI:
ffff8c5717d00000
[  168.518380] RBP: ffff8c5717d10390 R08: ffffd0864011fc98 R09:
ffff8c5717d0fb68
[  168.518381] R10: ffff8c5717d0fb08 R11: 0000000000000000 R12:
ffff8c5717d10830
[  168.518382] R13: 0000000000000002 R14: ffff8c5717d00000 R15:
ffff8c5717d259a0
[  168.518383] FS:  0000000000000000(0000) GS:ffff8c5a08f2f000(0000)
knlGS:0000000000000000
[  168.518385] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  168.518386] CR2: 00007fb941b67000 CR3: 000000010f832000 CR4:
00000000001506f0
[  168.518387] Call Trace:
[  168.518390]  <TASK>
[  168.518391]  amdgpu_fence_driver_hw_fini+0xf9/0x130 [amdgpu
fd2a24652620738c2ec44a27ca03228c2099e273]
[  168.519250]  amdgpu_device_suspend+0xbc/0x160 [amdgpu
fd2a24652620738c2ec44a27ca03228c2099e273]
[  168.520117]  pci_pm_suspend+0x80/0x170
[  168.520123]  ? __pfx_pci_pm_suspend+0x10/0x10
[  168.520125]  dpm_run_callback+0x4a/0x150
[  168.520129]  device_suspend+0x14d/0x540
[  168.520132]  async_suspend+0x21/0x30
[  168.520134]  async_run_entry_fn+0x36/0x140
[  168.520139]  process_one_work+0x193/0x350
[  168.520142]  worker_thread+0x2d7/0x410
[  168.520145]  ? __pfx_worker_thread+0x10/0x10
[  168.520147]  kthread+0xfc/0x240
[  168.520150]  ? __pfx_kthread+0x10/0x10
[  168.520151]  ret_from_fork+0x34/0x50
[  168.520155]  ? __pfx_kthread+0x10/0x10
[  168.520156]  ret_from_fork_asm+0x1a/0x30
[  168.520162]  </TASK>
[  168.520163] ---[ end trace 0000000000000000 ]---
[  168.520249] ------------[ cut here ]------------
[  168.520249] WARNING: CPU: 0 PID: 13 at
drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:631 amdgpu_irq_put+0x46/0x70
[amdgpu]
[  168.521131] Modules linked in: ccm algif_aead qrtr crypto_null
des3_ede_x86_64 des_generic libdes algif_skcipher cmac md4 algif_hash
af_alg kvm_amd ccp wl(POE) kvm snd_hda_codec_realtek snd_hda_codec_generic
snd_hda_scodec_component irqbypass snd_hda_codec_hdmi snd_hda_intel
snd_intel_dspcfg snd_intel_sdw_acpi dell_pc ath10k_pci snd_ctl_led
snd_hda_codec snd_hda_core snd_hwdep ath10k_core snd_pcm snd_timer ath
ee1004 snd polyval_clmulni soundcore platform_profile mac80211 rtsx_usb_ms
libarc4 polyval_generic sp5100_tco dell_laptop btusb joydev hid_multitouch
memstick mousedev ghash_clmulni_intel btrtl btintel btbcm btmtk dell_wmi
dell_smm_hwmon bluetooth sparse_keymap sha1_ssse3 pcspkr i2c_piix4
i2c_hid_acpi dell_smbios dcdbas dell_wmi_descriptor dell_rbtn psmouse
wmi_bmof i2c_hid i2c_smbus fam15h_power k10temp cfg80211 mac_hid rfkill
pkcs8_key_parser dm_mod nfnetlink ip_tables x_tables overlay squashfs loop
isofs cdrom amdgpu amdxcp gpu_sched rtsx_usb_sdmmc
drm_panel_backlight_quirks drm_buddy mmc_core drm_exec
[  168.521195]  sha512_ssse3 drm_suballoc_helper sha256_ssse3 r8169
drm_ttm_helper aesni_intel realtek ttm crypto_simd cryptd i2c_algo_bit
mdio_devres uas serio_raw rtsx_usb drm_display_helper libphy usb_storage
cec video wmi
[  168.521211] CPU: 0 UID: 0 PID: 13 Comm: kworker/u16:1 Tainted: P
 W  OE       6.15.4-arch2-1 #1 PREEMPT(full)
 bf56011d6043294f437da1888a30a6d02e6dd116
[  168.521215] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_MOD=
ULE,
[E]=3DUNSIGNED_MODULE
[  168.521216] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7
01/29/2018
[  168.521218] Workqueue: async async_run_entry_fn
[  168.521223] RIP: 0010:amdgpu_irq_put+0x46/0x70 [amdgpu]
[  168.522110] Code: c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 d1 48 8d 04
88 8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9 5f c6 44 d5 e9 5a fd ff ff
<0f> 0b b8 ea ff ff ff e9 4e c6 44 d5 b8 ea ff ff ff e9 44 c6 44 d5
[  168.522113] RSP: 0018:ffffd0864011fd10 EFLAGS: 00010246
[  168.522115] RAX: ffff8c57107c4508 RBX: ffff8c5717d194b8 RCX:
0000000000000000
[  168.522116] RDX: 0000000000000002 RSI: ffff8c5717d259a0 RDI:
ffff8c5717d00000
[  168.522117] RBP: ffff8c5717d10398 R08: ffffd0864011fc98 R09:
ffff8c5717d0fb68
[  168.522118] R10: ffff8c5717d0fb08 R11: 0000000000000000 R12:
ffff8c5717d10830
[  168.522119] R13: 0000000000000002 R14: ffff8c5717d00000 R15:
ffff8c5717d259a0
[  168.522121] FS:  0000000000000000(0000) GS:ffff8c5a08f2f000(0000)
knlGS:0000000000000000
[  168.522122] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  168.522123] CR2: 00007fb941b67000 CR3: 000000010f832000 CR4:
00000000001506f0
[  168.522124] Call Trace:
[  168.522128]  <TASK>
[  168.522129]  amdgpu_fence_driver_hw_fini+0xf9/0x130 [amdgpu
fd2a24652620738c2ec44a27ca03228c2099e273]
[  168.522996]  amdgpu_device_suspend+0xbc/0x160 [amdgpu
fd2a24652620738c2ec44a27ca03228c2099e273]
[  168.523861]  pci_pm_suspend+0x80/0x170
[  168.523867]  ? __pfx_pci_pm_suspend+0x10/0x10
[  168.523869]  dpm_run_callback+0x4a/0x150
[  168.523873]  device_suspend+0x14d/0x540
[  168.523876]  async_suspend+0x21/0x30
[  168.523879]  async_run_entry_fn+0x36/0x140
[  168.523884]  process_one_work+0x193/0x350
[  168.523887]  worker_thread+0x2d7/0x410
[  168.523890]  ? __pfx_worker_thread+0x10/0x10
[  168.523892]  kthread+0xfc/0x240
[  168.523894]  ? __pfx_kthread+0x10/0x10
[  168.523896]  ret_from_fork+0x34/0x50
[  168.523900]  ? __pfx_kthread+0x10/0x10
[  168.523902]  ret_from_fork_asm+0x1a/0x30
[  168.523907]  </TASK>
[  168.523908] ---[ end trace 0000000000000000 ]---
[  168.523995] ------------[ cut here ]------------
[  168.523996] WARNING: CPU: 0 PID: 13 at
drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:631 amdgpu_irq_put+0x46/0x70
[amdgpu]
[  168.524876] Modules linked in: ccm algif_aead qrtr crypto_null
des3_ede_x86_64 des_generic libdes algif_skcipher cmac md4 algif_hash
af_alg kvm_amd ccp wl(POE) kvm snd_hda_codec_realtek snd_hda_codec_generic
snd_hda_scodec_component irqbypass snd_hda_codec_hdmi snd_hda_intel
snd_intel_dspcfg snd_intel_sdw_acpi dell_pc ath10k_pci snd_ctl_led
snd_hda_codec snd_hda_core snd_hwdep ath10k_core snd_pcm snd_timer ath
ee1004 snd polyval_clmulni soundcore platform_profile mac80211 rtsx_usb_ms
libarc4 polyval_generic sp5100_tco dell_laptop btusb joydev hid_multitouch
memstick mousedev ghash_clmulni_intel btrtl btintel btbcm btmtk dell_wmi
dell_smm_hwmon bluetooth sparse_keymap sha1_ssse3 pcspkr i2c_piix4
i2c_hid_acpi dell_smbios dcdbas dell_wmi_descriptor dell_rbtn psmouse
wmi_bmof i2c_hid i2c_smbus fam15h_power k10temp cfg80211 mac_hid rfkill
pkcs8_key_parser dm_mod nfnetlink ip_tables x_tables overlay squashfs loop
isofs cdrom amdgpu amdxcp gpu_sched rtsx_usb_sdmmc
drm_panel_backlight_quirks drm_buddy mmc_core drm_exec
[  168.524940]  sha512_ssse3 drm_suballoc_helper sha256_ssse3 r8169
drm_ttm_helper aesni_intel realtek ttm crypto_simd cryptd i2c_algo_bit
mdio_devres uas serio_raw rtsx_usb drm_display_helper libphy usb_storage
cec video wmi
[  168.524957] CPU: 0 UID: 0 PID: 13 Comm: kworker/u16:1 Tainted: P
 W  OE       6.15.4-arch2-1 #1 PREEMPT(full)
 bf56011d6043294f437da1888a30a6d02e6dd116
[  168.524962] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_MOD=
ULE,
[E]=3DUNSIGNED_MODULE
[  168.524963] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7
01/29/2018
[  168.524964] Workqueue: async async_run_entry_fn
[  168.524969] RIP: 0010:amdgpu_irq_put+0x46/0x70 [amdgpu]
[  168.525868] Code: c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 d1 48 8d 04
88 8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9 5f c6 44 d5 e9 5a fd ff ff
<0f> 0b b8 ea ff ff ff e9 4e c6 44 d5 b8 ea ff ff ff e9 44 c6 44 d5
[  168.525870] RSP: 0018:ffffd0864011fd10 EFLAGS: 00010246
[  168.525873] RAX: ffff8c57107c4508 RBX: ffff8c5717d197d8 RCX:
0000000000000000
[  168.525874] RDX: 0000000000000002 RSI: ffff8c5717d259a0 RDI:
ffff8c5717d00000
[  168.525875] RBP: ffff8c5717d103a0 R08: ffffd0864011fc98 R09:
ffff8c5717d0fb68
[  168.525876] R10: ffff8c5717d0fb08 R11: 0000000000000000 R12:
ffff8c5717d10830
[  168.525877] R13: 0000000000000002 R14: ffff8c5717d00000 R15:
ffff8c5717d259a0
[  168.525878] FS:  0000000000000000(0000) GS:ffff8c5a08f2f000(0000)
knlGS:0000000000000000
[  168.525880] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  168.525881] CR2: 00007fb941b67000 CR3: 000000010f832000 CR4:
00000000001506f0
[  168.525883] Call Trace:
[  168.525885]  <TASK>
[  168.525887]  amdgpu_fence_driver_hw_fini+0xf9/0x130 [amdgpu
fd2a24652620738c2ec44a27ca03228c2099e273]
[  168.526753]  amdgpu_device_suspend+0xbc/0x160 [amdgpu
fd2a24652620738c2ec44a27ca03228c2099e273]
[  168.527608]  pci_pm_suspend+0x80/0x170
[  168.527614]  ? __pfx_pci_pm_suspend+0x10/0x10
[  168.527616]  dpm_run_callback+0x4a/0x150
[  168.527621]  device_suspend+0x14d/0x540
[  168.527624]  async_suspend+0x21/0x30
[  168.527626]  async_run_entry_fn+0x36/0x140
[  168.527631]  process_one_work+0x193/0x350
[  168.527634]  worker_thread+0x2d7/0x410
[  168.527637]  ? __pfx_worker_thread+0x10/0x10
[  168.527639]  kthread+0xfc/0x240
[  168.527641]  ? __pfx_kthread+0x10/0x10
[  168.527643]  ret_from_fork+0x34/0x50
[  168.527647]  ? __pfx_kthread+0x10/0x10
[  168.527649]  ret_from_fork_asm+0x1a/0x30
[  168.527654]  </TASK>
[  168.527655] ---[ end trace 0000000000000000 ]---
[  168.527743] ------------[ cut here ]------------
[  168.527744] WARNING: CPU: 0 PID: 13 at
drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:631 amdgpu_irq_put+0x46/0x70
[amdgpu]
[  168.528621] Modules linked in: ccm algif_aead qrtr crypto_null
des3_ede_x86_64 des_generic libdes algif_skcipher cmac md4 algif_hash
af_alg kvm_amd ccp wl(POE) kvm snd_hda_codec_realtek snd_hda_codec_generic
snd_hda_scodec_component irqbypass snd_hda_codec_hdmi snd_hda_intel
snd_intel_dspcfg snd_intel_sdw_acpi dell_pc ath10k_pci snd_ctl_led
snd_hda_codec snd_hda_core snd_hwdep ath10k_core snd_pcm snd_timer ath
ee1004 snd polyval_clmulni soundcore platform_profile mac80211 rtsx_usb_ms
libarc4 polyval_generic sp5100_tco dell_laptop btusb joydev hid_multitouch
memstick mousedev ghash_clmulni_intel btrtl btintel btbcm btmtk dell_wmi
dell_smm_hwmon bluetooth sparse_keymap sha1_ssse3 pcspkr i2c_piix4
i2c_hid_acpi dell_smbios dcdbas dell_wmi_descriptor dell_rbtn psmouse
wmi_bmof i2c_hid i2c_smbus fam15h_power k10temp cfg80211 mac_hid rfkill
pkcs8_key_parser dm_mod nfnetlink ip_tables x_tables overlay squashfs loop
isofs cdrom amdgpu amdxcp gpu_sched rtsx_usb_sdmmc
drm_panel_backlight_quirks drm_buddy mmc_core drm_exec
[  168.528685]  sha512_ssse3 drm_suballoc_helper sha256_ssse3 r8169
drm_ttm_helper aesni_intel realtek ttm crypto_simd cryptd i2c_algo_bit
mdio_devres uas serio_raw rtsx_usb drm_display_helper libphy usb_storage
cec video wmi
[  168.528702] CPU: 0 UID: 0 PID: 13 Comm: kworker/u16:1 Tainted: P
 W  OE       6.15.4-arch2-1 #1 PREEMPT(full)
 bf56011d6043294f437da1888a30a6d02e6dd116
[  168.528706] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_MOD=
ULE,
[E]=3DUNSIGNED_MODULE
[  168.528707] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7
01/29/2018
[  168.528709] Workqueue: async async_run_entry_fn
[  168.528714] RIP: 0010:amdgpu_irq_put+0x46/0x70 [amdgpu]
[  168.529586] Code: c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 d1 48 8d 04
88 8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9 5f c6 44 d5 e9 5a fd ff ff
<0f> 0b b8 ea ff ff ff e9 4e c6 44 d5 b8 ea ff ff ff e9 44 c6 44 d5
[  168.529588] RSP: 0018:ffffd0864011fd10 EFLAGS: 00010246
[  168.529591] RAX: ffff8c57107c4508 RBX: ffff8c5717d19af8 RCX:
0000000000000000
[  168.529592] RDX: 0000000000000002 RSI: ffff8c5717d259a0 RDI:
ffff8c5717d00000
[  168.529593] RBP: ffff8c5717d103a8 R08: ffffd0864011fc98 R09:
ffff8c5717d0fb68
[  168.529594] R10: ffff8c5717d0fb08 R11: 0000000000000000 R12:
ffff8c5717d10830
[  168.529595] R13: 0000000000000002 R14: ffff8c5717d00000 R15:
ffff8c5717d259a0
[  168.529596] FS:  0000000000000000(0000) GS:ffff8c5a08f2f000(0000)
knlGS:0000000000000000
[  168.529598] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  168.529599] CR2: 00007fb941b67000 CR3: 000000010f832000 CR4:
00000000001506f0
[  168.529600] Call Trace:
[  168.529603]  <TASK>
[  168.529604]  amdgpu_fence_driver_hw_fini+0xf9/0x130 [amdgpu
fd2a24652620738c2ec44a27ca03228c2099e273]
[  168.530461]  amdgpu_device_suspend+0xbc/0x160 [amdgpu
fd2a24652620738c2ec44a27ca03228c2099e273]
[  168.531322]  pci_pm_suspend+0x80/0x170
[  168.531328]  ? __pfx_pci_pm_suspend+0x10/0x10
[  168.531330]  dpm_run_callback+0x4a/0x150
[  168.531334]  device_suspend+0x14d/0x540
[  168.531337]  async_suspend+0x21/0x30
[  168.531339]  async_run_entry_fn+0x36/0x140
[  168.531343]  process_one_work+0x193/0x350
[  168.531347]  worker_thread+0x2d7/0x410
[  168.531349]  ? __pfx_worker_thread+0x10/0x10
[  168.531352]  kthread+0xfc/0x240
[  168.531354]  ? __pfx_kthread+0x10/0x10
[  168.531356]  ret_from_fork+0x34/0x50
[  168.531359]  ? __pfx_kthread+0x10/0x10
[  168.531361]  ret_from_fork_asm+0x1a/0x30
[  168.531366]  </TASK>
[  168.531367] ---[ end trace 0000000000000000 ]---
[  168.531453] ------------[ cut here ]------------
[  168.531453] WARNING: CPU: 0 PID: 13 at
drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:631 amdgpu_irq_put+0x46/0x70
[amdgpu]
[  168.532330] Modules linked in: ccm algif_aead qrtr crypto_null
des3_ede_x86_64 des_generic libdes algif_skcipher cmac md4 algif_hash
af_alg kvm_amd ccp wl(POE) kvm snd_hda_codec_realtek snd_hda_codec_generic
snd_hda_scodec_component irqbypass snd_hda_codec_hdmi snd_hda_intel
snd_intel_dspcfg snd_intel_sdw_acpi dell_pc ath10k_pci snd_ctl_led
snd_hda_codec snd_hda_core snd_hwdep ath10k_core snd_pcm snd_timer ath
ee1004 snd polyval_clmulni soundcore platform_profile mac80211 rtsx_usb_ms
libarc4 polyval_generic sp5100_tco dell_laptop btusb joydev hid_multitouch
memstick mousedev ghash_clmulni_intel btrtl btintel btbcm btmtk dell_wmi
dell_smm_hwmon bluetooth sparse_keymap sha1_ssse3 pcspkr i2c_piix4
i2c_hid_acpi dell_smbios dcdbas dell_wmi_descriptor dell_rbtn psmouse
wmi_bmof i2c_hid i2c_smbus fam15h_power k10temp cfg80211 mac_hid rfkill
pkcs8_key_parser dm_mod nfnetlink ip_tables x_tables overlay squashfs loop
isofs cdrom amdgpu amdxcp gpu_sched rtsx_usb_sdmmc
drm_panel_backlight_quirks drm_buddy mmc_core drm_exec
[  168.532393]  sha512_ssse3 drm_suballoc_helper sha256_ssse3 r8169
drm_ttm_helper aesni_intel realtek ttm crypto_simd cryptd i2c_algo_bit
mdio_devres uas serio_raw rtsx_usb drm_display_helper libphy usb_storage
cec video wmi
[  168.532410] CPU: 0 UID: 0 PID: 13 Comm: kworker/u16:1 Tainted: P
 W  OE       6.15.4-arch2-1 #1 PREEMPT(full)
 bf56011d6043294f437da1888a30a6d02e6dd116
[  168.532414] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_MOD=
ULE,
[E]=3DUNSIGNED_MODULE
[  168.532415] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7
01/29/2018
[  168.532417] Workqueue: async async_run_entry_fn
[  168.532422] RIP: 0010:amdgpu_irq_put+0x46/0x70 [amdgpu]
[  168.533294] Code: c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 d1 48 8d 04
88 8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9 5f c6 44 d5 e9 5a fd ff ff
<0f> 0b b8 ea ff ff ff e9 4e c6 44 d5 b8 ea ff ff ff e9 44 c6 44 d5
[  168.533296] RSP: 0018:ffffd0864011fd10 EFLAGS: 00010246
[  168.533298] RAX: ffff8c57107c4508 RBX: ffff8c5717d19e18 RCX:
0000000000000000
[  168.533299] RDX: 0000000000000002 RSI: ffff8c5717d259a0 RDI:
ffff8c5717d00000
[  168.533300] RBP: ffff8c5717d103b0 R08: ffffd0864011fc98 R09:
ffff8c5717d0fb68
[  168.533301] R10: ffff8c5717d0fb08 R11: 0000000000000000 R12:
ffff8c5717d10830
[  168.533302] R13: 0000000000000002 R14: ffff8c5717d00000 R15:
ffff8c5717d259a0
[  168.533303] FS:  0000000000000000(0000) GS:ffff8c5a08f2f000(0000)
knlGS:0000000000000000
[  168.533305] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  168.533306] CR2: 00007fb941b67000 CR3: 000000010f832000 CR4:
00000000001506f0
[  168.533307] Call Trace:
[  168.533310]  <TASK>
[  168.533311]  amdgpu_fence_driver_hw_fini+0xf9/0x130 [amdgpu
fd2a24652620738c2ec44a27ca03228c2099e273]
[  168.534176]  amdgpu_device_suspend+0xbc/0x160 [amdgpu
fd2a24652620738c2ec44a27ca03228c2099e273]
[  168.535038]  pci_pm_suspend+0x80/0x170
[  168.535043]  ? __pfx_pci_pm_suspend+0x10/0x10
[  168.535045]  dpm_run_callback+0x4a/0x150
[  168.535049]  device_suspend+0x14d/0x540
[  168.535052]  async_suspend+0x21/0x30
[  168.535054]  async_run_entry_fn+0x36/0x140
[  168.535059]  process_one_work+0x193/0x350
[  168.535062]  worker_thread+0x2d7/0x410
[  168.535064]  ? __pfx_worker_thread+0x10/0x10
[  168.535067]  kthread+0xfc/0x240
[  168.535069]  ? __pfx_kthread+0x10/0x10
[  168.535071]  ret_from_fork+0x34/0x50
[  168.535075]  ? __pfx_kthread+0x10/0x10
[  168.535076]  ret_from_fork_asm+0x1a/0x30
[  168.535081]  </TASK>
[  168.535082] ---[ end trace 0000000000000000 ]---
[  168.535169] ------------[ cut here ]------------
[  168.535170] WARNING: CPU: 0 PID: 13 at
drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:631 amdgpu_irq_put+0x46/0x70
[amdgpu]
[  168.536047] Modules linked in: ccm algif_aead qrtr crypto_null
des3_ede_x86_64 des_generic libdes algif_skcipher cmac md4 algif_hash
af_alg kvm_amd ccp wl(POE) kvm snd_hda_codec_realtek snd_hda_codec_generic
snd_hda_scodec_component irqbypass snd_hda_codec_hdmi snd_hda_intel
snd_intel_dspcfg snd_intel_sdw_acpi dell_pc ath10k_pci snd_ctl_led
snd_hda_codec snd_hda_core snd_hwdep ath10k_core snd_pcm snd_timer ath
ee1004 snd polyval_clmulni soundcore platform_profile mac80211 rtsx_usb_ms
libarc4 polyval_generic sp5100_tco dell_laptop btusb joydev hid_multitouch
memstick mousedev ghash_clmulni_intel btrtl btintel btbcm btmtk dell_wmi
dell_smm_hwmon bluetooth sparse_keymap sha1_ssse3 pcspkr i2c_piix4
i2c_hid_acpi dell_smbios dcdbas dell_wmi_descriptor dell_rbtn psmouse
wmi_bmof i2c_hid i2c_smbus fam15h_power k10temp cfg80211 mac_hid rfkill
pkcs8_key_parser dm_mod nfnetlink ip_tables x_tables overlay squashfs loop
isofs cdrom amdgpu amdxcp gpu_sched rtsx_usb_sdmmc
drm_panel_backlight_quirks drm_buddy mmc_core drm_exec
[  168.536112]  sha512_ssse3 drm_suballoc_helper sha256_ssse3 r8169
drm_ttm_helper aesni_intel realtek ttm crypto_simd cryptd i2c_algo_bit
mdio_devres uas serio_raw rtsx_usb drm_display_helper libphy usb_storage
cec video wmi
[  168.536128] CPU: 0 UID: 0 PID: 13 Comm: kworker/u16:1 Tainted: P
 W  OE       6.15.4-arch2-1 #1 PREEMPT(full)
 bf56011d6043294f437da1888a30a6d02e6dd116
[  168.536133] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_MOD=
ULE,
[E]=3DUNSIGNED_MODULE
[  168.536134] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7
01/29/2018
[  168.536135] Workqueue: async async_run_entry_fn
[  168.536140] RIP: 0010:amdgpu_irq_put+0x46/0x70 [amdgpu]
[  168.537014] Code: c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 d1 48 8d 04
88 8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9 5f c6 44 d5 e9 5a fd ff ff
<0f> 0b b8 ea ff ff ff e9 4e c6 44 d5 b8 ea ff ff ff e9 44 c6 44 d5
[  168.537017] RSP: 0018:ffffd0864011fd10 EFLAGS: 00010246
[  168.537019] RAX: ffff8c57107c4508 RBX: ffff8c5717d1a138 RCX:
0000000000000000
[  168.537020] RDX: 0000000000000002 RSI: ffff8c5717d259a0 RDI:
ffff8c5717d00000
[  168.537021] RBP: ffff8c5717d103b8 R08: ffffd0864011fc98 R09:
ffff8c5717d0fb68
[  168.537022] R10: ffff8c5717d0fb08 R11: 0000000000000000 R12:
ffff8c5717d10830
[  168.537023] R13: 0000000000000002 R14: ffff8c5717d00000 R15:
ffff8c5717d259a0
[  168.537024] FS:  0000000000000000(0000) GS:ffff8c5a08f2f000(0000)
knlGS:0000000000000000
[  168.537025] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  168.537027] CR2: 00007fb941b67000 CR3: 000000010f832000 CR4:
00000000001506f0
[  168.537028] Call Trace:
[  168.537031]  <TASK>
[  168.537032]  amdgpu_fence_driver_hw_fini+0xf9/0x130 [amdgpu
fd2a24652620738c2ec44a27ca03228c2099e273]
[  168.537905]  amdgpu_device_suspend+0xbc/0x160 [amdgpu
fd2a24652620738c2ec44a27ca03228c2099e273]
[  168.538771]  pci_pm_suspend+0x80/0x170
[  168.538776]  ? __pfx_pci_pm_suspend+0x10/0x10
[  168.538778]  dpm_run_callback+0x4a/0x150
[  168.538782]  device_suspend+0x14d/0x540
[  168.538785]  async_suspend+0x21/0x30
[  168.538787]  async_run_entry_fn+0x36/0x140
[  168.538792]  process_one_work+0x193/0x350
[  168.538795]  worker_thread+0x2d7/0x410
[  168.538798]  ? __pfx_worker_thread+0x10/0x10
[  168.538800]  kthread+0xfc/0x240
[  168.538802]  ? __pfx_kthread+0x10/0x10
[  168.538804]  ret_from_fork+0x34/0x50
[  168.538808]  ? __pfx_kthread+0x10/0x10
[  168.538810]  ret_from_fork_asm+0x1a/0x30
[  168.538814]  </TASK>
[  168.538815] ---[ end trace 0000000000000000 ]---
[  168.538904] ------------[ cut here ]------------
[  168.538905] WARNING: CPU: 0 PID: 13 at
drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:631 amdgpu_irq_put+0x46/0x70
[amdgpu]
[  168.539784] Modules linked in: ccm algif_aead qrtr crypto_null
des3_ede_x86_64 des_generic libdes algif_skcipher cmac md4 algif_hash
af_alg kvm_amd ccp wl(POE) kvm snd_hda_codec_realtek snd_hda_codec_generic
snd_hda_scodec_component irqbypass snd_hda_codec_hdmi snd_hda_intel
snd_intel_dspcfg snd_intel_sdw_acpi dell_pc ath10k_pci snd_ctl_led
snd_hda_codec snd_hda_core snd_hwdep ath10k_core snd_pcm snd_timer ath
ee1004 snd polyval_clmulni soundcore platform_profile mac80211 rtsx_usb_ms
libarc4 polyval_generic sp5100_tco dell_laptop btusb joydev hid_multitouch
memstick mousedev ghash_clmulni_intel btrtl btintel btbcm btmtk dell_wmi
dell_smm_hwmon bluetooth sparse_keymap sha1_ssse3 pcspkr i2c_piix4
i2c_hid_acpi dell_smbios dcdbas dell_wmi_descriptor dell_rbtn psmouse
wmi_bmof i2c_hid i2c_smbus fam15h_power k10temp cfg80211 mac_hid rfkill
pkcs8_key_parser dm_mod nfnetlink ip_tables x_tables overlay squashfs loop
isofs cdrom amdgpu amdxcp gpu_sched rtsx_usb_sdmmc
drm_panel_backlight_quirks drm_buddy mmc_core drm_exec
[  168.539848]  sha512_ssse3 drm_suballoc_helper sha256_ssse3 r8169
drm_ttm_helper aesni_intel realtek ttm crypto_simd cryptd i2c_algo_bit
mdio_devres uas serio_raw rtsx_usb drm_display_helper libphy usb_storage
cec video wmi
[  168.539865] CPU: 0 UID: 0 PID: 13 Comm: kworker/u16:1 Tainted: P
 W  OE       6.15.4-arch2-1 #1 PREEMPT(full)
 bf56011d6043294f437da1888a30a6d02e6dd116
[  168.539869] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_MOD=
ULE,
[E]=3DUNSIGNED_MODULE
[  168.539870] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7
01/29/2018
[  168.539871] Workqueue: async async_run_entry_fn
[  168.539877] RIP: 0010:amdgpu_irq_put+0x46/0x70 [amdgpu]
[  168.540753] Code: c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 d1 48 8d 04
88 8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9 5f c6 44 d5 e9 5a fd ff ff
<0f> 0b b8 ea ff ff ff e9 4e c6 44 d5 b8 ea ff ff ff e9 44 c6 44 d5
[  168.540755] RSP: 0018:ffffd0864011fd10 EFLAGS: 00010246
[  168.540757] RAX: ffff8c57107c4508 RBX: ffff8c5717d1a458 RCX:
0000000000000000
[  168.540758] RDX: 0000000000000002 RSI: ffff8c5717d259a0 RDI:
ffff8c5717d00000
[  168.540759] RBP: ffff8c5717d103c0 R08: ffffd0864011fc98 R09:
ffff8c5717d0fb68
[  168.540760] R10: ffff8c5717d0fb08 R11: 0000000000000000 R12:
ffff8c5717d10830
[  168.540761] R13: 0000000000000002 R14: ffff8c5717d00000 R15:
ffff8c5717d259a0
[  168.540762] FS:  0000000000000000(0000) GS:ffff8c5a08f2f000(0000)
knlGS:0000000000000000
[  168.540764] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  168.540765] CR2: 00007fb941b67000 CR3: 000000010f832000 CR4:
00000000001506f0
[  168.540766] Call Trace:
[  168.540769]  <TASK>
[  168.540770]  amdgpu_fence_driver_hw_fini+0xf9/0x130 [amdgpu
fd2a24652620738c2ec44a27ca03228c2099e273]
[  168.541634]  amdgpu_device_suspend+0xbc/0x160 [amdgpu
fd2a24652620738c2ec44a27ca03228c2099e273]
[  168.542508]  pci_pm_suspend+0x80/0x170
[  168.542513]  ? __pfx_pci_pm_suspend+0x10/0x10
[  168.542516]  dpm_run_callback+0x4a/0x150
[  168.542519]  device_suspend+0x14d/0x540
[  168.542522]  async_suspend+0x21/0x30
[  168.542524]  async_run_entry_fn+0x36/0x140
[  168.542529]  process_one_work+0x193/0x350
[  168.542532]  worker_thread+0x2d7/0x410
[  168.542535]  ? __pfx_worker_thread+0x10/0x10
[  168.542537]  kthread+0xfc/0x240
[  168.542539]  ? __pfx_kthread+0x10/0x10
[  168.542541]  ret_from_fork+0x34/0x50
[  168.542544]  ? __pfx_kthread+0x10/0x10
[  168.542546]  ret_from_fork_asm+0x1a/0x30
[  168.542551]  </TASK>
[  168.542552] ---[ end trace 0000000000000000 ]---
[  168.542641] ------------[ cut here ]------------
[  168.542642] WARNING: CPU: 0 PID: 13 at
drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:631 amdgpu_irq_put+0x46/0x70
[amdgpu]
[  168.543532] Modules linked in: ccm algif_aead qrtr crypto_null
des3_ede_x86_64 des_generic libdes algif_skcipher cmac md4 algif_hash
af_alg kvm_amd ccp wl(POE) kvm snd_hda_codec_realtek snd_hda_codec_generic
snd_hda_scodec_component irqbypass snd_hda_codec_hdmi snd_hda_intel
snd_intel_dspcfg snd_intel_sdw_acpi dell_pc ath10k_pci snd_ctl_led
snd_hda_codec snd_hda_core snd_hwdep ath10k_core snd_pcm snd_timer ath
ee1004 snd polyval_clmulni soundcore platform_profile mac80211 rtsx_usb_ms
libarc4 polyval_generic sp5100_tco dell_laptop btusb joydev hid_multitouch
memstick mousedev ghash_clmulni_intel btrtl btintel btbcm btmtk dell_wmi
dell_smm_hwmon bluetooth sparse_keymap sha1_ssse3 pcspkr i2c_piix4
i2c_hid_acpi dell_smbios dcdbas dell_wmi_descriptor dell_rbtn psmouse
wmi_bmof i2c_hid i2c_smbus fam15h_power k10temp cfg80211 mac_hid rfkill
pkcs8_key_parser dm_mod nfnetlink ip_tables x_tables overlay squashfs loop
isofs cdrom amdgpu amdxcp gpu_sched rtsx_usb_sdmmc
drm_panel_backlight_quirks drm_buddy mmc_core drm_exec
[  168.543597]  sha512_ssse3 drm_suballoc_helper sha256_ssse3 r8169
drm_ttm_helper aesni_intel realtek ttm crypto_simd cryptd i2c_algo_bit
mdio_devres uas serio_raw rtsx_usb drm_display_helper libphy usb_storage
cec video wmi
[  168.543614] CPU: 0 UID: 0 PID: 13 Comm: kworker/u16:1 Tainted: P
 W  OE       6.15.4-arch2-1 #1 PREEMPT(full)
 bf56011d6043294f437da1888a30a6d02e6dd116
[  168.543618] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_MOD=
ULE,
[E]=3DUNSIGNED_MODULE
[  168.543619] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7
01/29/2018
[  168.543620] Workqueue: async async_run_entry_fn
[  168.543625] RIP: 0010:amdgpu_irq_put+0x46/0x70 [amdgpu]
[  168.544513] Code: c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 d1 48 8d 04
88 8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9 5f c6 44 d5 e9 5a fd ff ff
<0f> 0b b8 ea ff ff ff e9 4e c6 44 d5 b8 ea ff ff ff e9 44 c6 44 d5
[  168.544516] RSP: 0018:ffffd0864011fd10 EFLAGS: 00010246
[  168.544518] RAX: ffff8c57107c4508 RBX: ffff8c5717d1a778 RCX:
0000000000000000
[  168.544519] RDX: 0000000000000002 RSI: ffff8c5717d259a0 RDI:
ffff8c5717d00000
[  168.544520] RBP: ffff8c5717d103c8 R08: ffffd0864011fc98 R09:
ffff8c5717d0fb68
[  168.544521] R10: ffff8c5717d0fb08 R11: 0000000000000000 R12:
ffff8c5717d10830
[  168.544522] R13: 0000000000000002 R14: ffff8c5717d00000 R15:
ffff8c5717d259a0
[  168.544523] FS:  0000000000000000(0000) GS:ffff8c5a08f2f000(0000)
knlGS:0000000000000000
[  168.544524] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  168.544526] CR2: 00007fb941b67000 CR3: 000000010f832000 CR4:
00000000001506f0
[  168.544527] Call Trace:
[  168.544529]  <TASK>
[  168.544530]  amdgpu_fence_driver_hw_fini+0xf9/0x130 [amdgpu
fd2a24652620738c2ec44a27ca03228c2099e273]
[  168.545393]  amdgpu_device_suspend+0xbc/0x160 [amdgpu
fd2a24652620738c2ec44a27ca03228c2099e273]
[  168.546253]  pci_pm_suspend+0x80/0x170
[  168.546259]  ? __pfx_pci_pm_suspend+0x10/0x10
[  168.546261]  dpm_run_callback+0x4a/0x150
[  168.546265]  device_suspend+0x14d/0x540
[  168.546268]  async_suspend+0x21/0x30
[  168.546270]  async_run_entry_fn+0x36/0x140
[  168.546275]  process_one_work+0x193/0x350
[  168.546278]  worker_thread+0x2d7/0x410
[  168.546281]  ? __pfx_worker_thread+0x10/0x10
[  168.546283]  kthread+0xfc/0x240
[  168.546285]  ? __pfx_kthread+0x10/0x10
[  168.546287]  ret_from_fork+0x34/0x50
[  168.546291]  ? __pfx_kthread+0x10/0x10
[  168.546292]  ret_from_fork_asm+0x1a/0x30
[  168.546297]  </TASK>
[  168.546298] ---[ end trace 0000000000000000 ]---
[  168.546392] ------------[ cut here ]------------
[  168.546393] WARNING: CPU: 0 PID: 13 at
drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:631 amdgpu_irq_put+0x46/0x70
[amdgpu]
[  168.547276] Modules linked in: ccm algif_aead qrtr crypto_null
des3_ede_x86_64 des_generic libdes algif_skcipher cmac md4 algif_hash
af_alg kvm_amd ccp wl(POE) kvm snd_hda_codec_realtek snd_hda_codec_generic
snd_hda_scodec_component irqbypass snd_hda_codec_hdmi snd_hda_intel
snd_intel_dspcfg snd_intel_sdw_acpi dell_pc ath10k_pci snd_ctl_led
snd_hda_codec snd_hda_core snd_hwdep ath10k_core snd_pcm snd_timer ath
ee1004 snd polyval_clmulni soundcore platform_profile mac80211 rtsx_usb_ms
libarc4 polyval_generic sp5100_tco dell_laptop btusb joydev hid_multitouch
memstick mousedev ghash_clmulni_intel btrtl btintel btbcm btmtk dell_wmi
dell_smm_hwmon bluetooth sparse_keymap sha1_ssse3 pcspkr i2c_piix4
i2c_hid_acpi dell_smbios dcdbas dell_wmi_descriptor dell_rbtn psmouse
wmi_bmof i2c_hid i2c_smbus fam15h_power k10temp cfg80211 mac_hid rfkill
pkcs8_key_parser dm_mod nfnetlink ip_tables x_tables overlay squashfs loop
isofs cdrom amdgpu amdxcp gpu_sched rtsx_usb_sdmmc
drm_panel_backlight_quirks drm_buddy mmc_core drm_exec
[  168.547340]  sha512_ssse3 drm_suballoc_helper sha256_ssse3 r8169
drm_ttm_helper aesni_intel realtek ttm crypto_simd cryptd i2c_algo_bit
mdio_devres uas serio_raw rtsx_usb drm_display_helper libphy usb_storage
cec video wmi
[  168.547356] CPU: 0 UID: 0 PID: 13 Comm: kworker/u16:1 Tainted: P
 W  OE       6.15.4-arch2-1 #1 PREEMPT(full)
 bf56011d6043294f437da1888a30a6d02e6dd116
[  168.547361] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_MOD=
ULE,
[E]=3DUNSIGNED_MODULE
[  168.547362] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7
01/29/2018
[  168.547363] Workqueue: async async_run_entry_fn
[  168.547368] RIP: 0010:amdgpu_irq_put+0x46/0x70 [amdgpu]
[  168.548257] Code: c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 d1 48 8d 04
88 8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9 5f c6 44 d5 e9 5a fd ff ff
<0f> 0b b8 ea ff ff ff e9 4e c6 44 d5 b8 ea ff ff ff e9 44 c6 44 d5
[  168.548259] RSP: 0018:ffffd0864011fd10 EFLAGS: 00010246
[  168.548261] RAX: ffff8c571466b040 RBX: ffff8c5717d269c8 RCX:
0000000000000000
[  168.548262] RDX: 0000000000000000 RSI: ffff8c5717d2d338 RDI:
ffff8c5717d00000
[  168.548263] RBP: ffff8c5717d103d8 R08: ffffd0864011fc98 R09:
ffff8c5717d0fb68
[  168.548264] R10: ffff8c5717d0fb08 R11: 0000000000000000 R12:
ffff8c5717d10830
[  168.548265] R13: 0000000000000002 R14: ffff8c5717d00000 R15:
ffff8c5717d2d338
[  168.548266] FS:  0000000000000000(0000) GS:ffff8c5a08f2f000(0000)
knlGS:0000000000000000
[  168.548267] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  168.548269] CR2: 00007fb941b67000 CR3: 000000010f832000 CR4:
00000000001506f0
[  168.548270] Call Trace:
[  168.548273]  <TASK>
[  168.548274]  amdgpu_fence_driver_hw_fini+0xf9/0x130 [amdgpu
fd2a24652620738c2ec44a27ca03228c2099e273]
[  168.549135]  amdgpu_device_suspend+0xbc/0x160 [amdgpu
fd2a24652620738c2ec44a27ca03228c2099e273]
[  168.550007]  pci_pm_suspend+0x80/0x170
[  168.550013]  ? __pfx_pci_pm_suspend+0x10/0x10
[  168.550015]  dpm_run_callback+0x4a/0x150
[  168.550019]  device_suspend+0x14d/0x540
[  168.550022]  async_suspend+0x21/0x30
[  168.550024]  async_run_entry_fn+0x36/0x140
[  168.550028]  process_one_work+0x193/0x350
[  168.550032]  worker_thread+0x2d7/0x410
[  168.550034]  ? __pfx_worker_thread+0x10/0x10
[  168.550037]  kthread+0xfc/0x240
[  168.550039]  ? __pfx_kthread+0x10/0x10
[  168.550041]  ret_from_fork+0x34/0x50
[  168.550044]  ? __pfx_kthread+0x10/0x10
[  168.550046]  ret_from_fork_asm+0x1a/0x30
[  168.550051]  </TASK>
[  168.550052] ---[ end trace 0000000000000000 ]---
[  168.550139] ------------[ cut here ]------------
[  168.550140] WARNING: CPU: 0 PID: 13 at
drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:631 amdgpu_irq_put+0x46/0x70
[amdgpu]
[  168.551023] Modules linked in: ccm algif_aead qrtr crypto_null
des3_ede_x86_64 des_generic libdes algif_skcipher cmac md4 algif_hash
af_alg kvm_amd ccp wl(POE) kvm snd_hda_codec_realtek snd_hda_codec_generic
snd_hda_scodec_component irqbypass snd_hda_codec_hdmi snd_hda_intel
snd_intel_dspcfg snd_intel_sdw_acpi dell_pc ath10k_pci snd_ctl_led
snd_hda_codec snd_hda_core snd_hwdep ath10k_core snd_pcm snd_timer ath
ee1004 snd polyval_clmulni soundcore platform_profile mac80211 rtsx_usb_ms
libarc4 polyval_generic sp5100_tco dell_laptop btusb joydev hid_multitouch
memstick mousedev ghash_clmulni_intel btrtl btintel btbcm btmtk dell_wmi
dell_smm_hwmon bluetooth sparse_keymap sha1_ssse3 pcspkr i2c_piix4
i2c_hid_acpi dell_smbios dcdbas dell_wmi_descriptor dell_rbtn psmouse
wmi_bmof i2c_hid i2c_smbus fam15h_power k10temp cfg80211 mac_hid rfkill
pkcs8_key_parser dm_mod nfnetlink ip_tables x_tables overlay squashfs loop
isofs cdrom amdgpu amdxcp gpu_sched rtsx_usb_sdmmc
drm_panel_backlight_quirks drm_buddy mmc_core drm_exec
[  168.551087]  sha512_ssse3 drm_suballoc_helper sha256_ssse3 r8169
drm_ttm_helper aesni_intel realtek ttm crypto_simd cryptd i2c_algo_bit
mdio_devres uas serio_raw rtsx_usb drm_display_helper libphy usb_storage
cec video wmi
[  168.551104] CPU: 0 UID: 0 PID: 13 Comm: kworker/u16:1 Tainted: P
 W  OE       6.15.4-arch2-1 #1 PREEMPT(full)
 bf56011d6043294f437da1888a30a6d02e6dd116
[  168.551108] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_MOD=
ULE,
[E]=3DUNSIGNED_MODULE
[  168.551109] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7
01/29/2018
[  168.551110] Workqueue: async async_run_entry_fn
[  168.551115] RIP: 0010:amdgpu_irq_put+0x46/0x70 [amdgpu]
[  168.551995] Code: c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 d1 48 8d 04
88 8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9 5f c6 44 d5 e9 5a fd ff ff
<0f> 0b b8 ea ff ff ff e9 4e c6 44 d5 b8 ea ff ff ff e9 44 c6 44 d5
[  168.551997] RSP: 0018:ffffd0864011fd10 EFLAGS: 00010246
[  168.551999] RAX: ffff8c571466b044 RBX: ffff8c5717d27060 RCX:
0000000000000000
[  168.552001] RDX: 0000000000000001 RSI: ffff8c5717d2d338 RDI:
ffff8c5717d00000
[  168.552002] RBP: ffff8c5717d103e0 R08: ffffd0864011fc98 R09:
ffff8c5717d0fb68
[  168.552003] R10: ffff8c5717d0fb08 R11: 0000000000000000 R12:
ffff8c5717d10830
[  168.552004] R13: 0000000000000002 R14: ffff8c5717d00000 R15:
ffff8c5717d2d338
[  168.552005] FS:  0000000000000000(0000) GS:ffff8c5a08f2f000(0000)
knlGS:0000000000000000
[  168.552006] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  168.552007] CR2: 00007fb941b67000 CR3: 000000010f832000 CR4:
00000000001506f0
[  168.552008] Call Trace:
[  168.552011]  <TASK>
[  168.552012]  amdgpu_fence_driver_hw_fini+0xf9/0x130 [amdgpu
fd2a24652620738c2ec44a27ca03228c2099e273]
[  168.552877]  amdgpu_device_suspend+0xbc/0x160 [amdgpu
fd2a24652620738c2ec44a27ca03228c2099e273]
[  168.553735]  pci_pm_suspend+0x80/0x170
[  168.553740]  ? __pfx_pci_pm_suspend+0x10/0x10
[  168.553743]  dpm_run_callback+0x4a/0x150
[  168.553747]  device_suspend+0x14d/0x540
[  168.553750]  async_suspend+0x21/0x30
[  168.553752]  async_run_entry_fn+0x36/0x140
[  168.553756]  process_one_work+0x193/0x350
[  168.553760]  worker_thread+0x2d7/0x410
[  168.553762]  ? __pfx_worker_thread+0x10/0x10
[  168.553764]  kthread+0xfc/0x240
[  168.553766]  ? __pfx_kthread+0x10/0x10
[  168.553768]  ret_from_fork+0x34/0x50
[  168.553772]  ? __pfx_kthread+0x10/0x10
[  168.553774]  ret_from_fork_asm+0x1a/0x30
[  168.553779]  </TASK>
[  168.553780] ---[ end trace 0000000000000000 ]---
[  168.553869] ------------[ cut here ]------------
[  168.553870] WARNING: CPU: 0 PID: 13 at
drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:631 amdgpu_irq_put+0x46/0x70
[amdgpu]
[  168.554748] Modules linked in: ccm algif_aead qrtr crypto_null
des3_ede_x86_64 des_generic libdes algif_skcipher cmac md4 algif_hash
af_alg kvm_amd ccp wl(POE) kvm snd_hda_codec_realtek snd_hda_codec_generic
snd_hda_scodec_component irqbypass snd_hda_codec_hdmi snd_hda_intel
snd_intel_dspcfg snd_intel_sdw_acpi dell_pc ath10k_pci snd_ctl_led
snd_hda_codec snd_hda_core snd_hwdep ath10k_core snd_pcm snd_timer ath
ee1004 snd polyval_clmulni soundcore platform_profile mac80211 rtsx_usb_ms
libarc4 polyval_generic sp5100_tco dell_laptop btusb joydev hid_multitouch
memstick mousedev ghash_clmulni_intel btrtl btintel btbcm btmtk dell_wmi
dell_smm_hwmon bluetooth sparse_keymap sha1_ssse3 pcspkr i2c_piix4
i2c_hid_acpi dell_smbios dcdbas dell_wmi_descriptor dell_rbtn psmouse
wmi_bmof i2c_hid i2c_smbus fam15h_power k10temp cfg80211 mac_hid rfkill
pkcs8_key_parser dm_mod nfnetlink ip_tables x_tables overlay squashfs loop
isofs cdrom amdgpu amdxcp gpu_sched rtsx_usb_sdmmc
drm_panel_backlight_quirks drm_buddy mmc_core drm_exec
[  168.554814]  sha512_ssse3 drm_suballoc_helper sha256_ssse3 r8169
drm_ttm_helper aesni_intel realtek ttm crypto_simd cryptd i2c_algo_bit
mdio_devres uas serio_raw rtsx_usb drm_display_helper libphy usb_storage
cec video wmi
[  168.554831] CPU: 0 UID: 0 PID: 13 Comm: kworker/u16:1 Tainted: P
 W  OE       6.15.4-arch2-1 #1 PREEMPT(full)
 bf56011d6043294f437da1888a30a6d02e6dd116
[  168.554835] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_MOD=
ULE,
[E]=3DUNSIGNED_MODULE
[  168.554836] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7
01/29/2018
[  168.554838] Workqueue: async async_run_entry_fn
[  168.554843] RIP: 0010:amdgpu_irq_put+0x46/0x70 [amdgpu]
[  168.555725] Code: c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 d1 48 8d 04
88 8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9 5f c6 44 d5 e9 5a fd ff ff
<0f> 0b b8 ea ff ff ff e9 4e c6 44 d5 b8 ea ff ff ff e9 44 c6 44 d5
[  168.555727] RSP: 0018:ffffd0864011fd10 EFLAGS: 00010246
[  168.555729] RAX: ffff8c5715874800 RBX: ffff8c5717d2d480 RCX:
0000000000000000
[  168.555731] RDX: 0000000000000000 RSI: ffff8c5717d2dde0 RDI:
ffff8c5717d00000
[  168.555732] RBP: ffff8c5717d103e8 R08: ffffd0864011fc98 R09:
ffff8c5717d0fb68
[  168.555733] R10: ffff8c5717d0fb08 R11: 0000000000000000 R12:
ffff8c5717d10830
[  168.555734] R13: 0000000000000002 R14: ffff8c5717d00000 R15:
ffff8c5717d2dde0
[  168.555735] FS:  0000000000000000(0000) GS:ffff8c5a08f2f000(0000)
knlGS:0000000000000000
[  168.555736] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  168.555737] CR2: 00007fb941b67000 CR3: 000000010f832000 CR4:
00000000001506f0
[  168.555738] Call Trace:
[  168.555741]  <TASK>
[  168.555742]  amdgpu_fence_driver_hw_fini+0xf9/0x130 [amdgpu
fd2a24652620738c2ec44a27ca03228c2099e273]
[  168.556614]  amdgpu_device_suspend+0xbc/0x160 [amdgpu
fd2a24652620738c2ec44a27ca03228c2099e273]
[  168.557476]  pci_pm_suspend+0x80/0x170
[  168.557481]  ? __pfx_pci_pm_suspend+0x10/0x10
[  168.557484]  dpm_run_callback+0x4a/0x150
[  168.557488]  device_suspend+0x14d/0x540
[  168.557491]  async_suspend+0x21/0x30
[  168.557493]  async_run_entry_fn+0x36/0x140
[  168.557505]  process_one_work+0x193/0x350
[  168.557510]  worker_thread+0x2d7/0x410
[  168.557513]  ? __pfx_worker_thread+0x10/0x10
[  168.557515]  kthread+0xfc/0x240
[  168.557518]  ? __pfx_kthread+0x10/0x10
[  168.557519]  ret_from_fork+0x34/0x50
[  168.557523]  ? __pfx_kthread+0x10/0x10
[  168.557525]  ret_from_fork_asm+0x1a/0x30
[  168.557530]  </TASK>
[  168.557531] ---[ end trace 0000000000000000 ]---
[  168.557617] ------------[ cut here ]------------
[  168.557617] WARNING: CPU: 0 PID: 13 at
drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:631 amdgpu_irq_put+0x46/0x70
[amdgpu]
[  168.558505] Modules linked in: ccm algif_aead qrtr crypto_null
des3_ede_x86_64 des_generic libdes algif_skcipher cmac md4 algif_hash
af_alg kvm_amd ccp wl(POE) kvm snd_hda_codec_realtek snd_hda_codec_generic
snd_hda_scodec_component irqbypass snd_hda_codec_hdmi snd_hda_intel
snd_intel_dspcfg snd_intel_sdw_acpi dell_pc ath10k_pci snd_ctl_led
snd_hda_codec snd_hda_core snd_hwdep ath10k_core snd_pcm snd_timer ath
ee1004 snd polyval_clmulni soundcore platform_profile mac80211 rtsx_usb_ms
libarc4 polyval_generic sp5100_tco dell_laptop btusb joydev hid_multitouch
memstick mousedev ghash_clmulni_intel btrtl btintel btbcm btmtk dell_wmi
dell_smm_hwmon bluetooth sparse_keymap sha1_ssse3 pcspkr i2c_piix4
i2c_hid_acpi dell_smbios dcdbas dell_wmi_descriptor dell_rbtn psmouse
wmi_bmof i2c_hid i2c_smbus fam15h_power k10temp cfg80211 mac_hid rfkill
pkcs8_key_parser dm_mod nfnetlink ip_tables x_tables overlay squashfs loop
isofs cdrom amdgpu amdxcp gpu_sched rtsx_usb_sdmmc
drm_panel_backlight_quirks drm_buddy mmc_core drm_exec
[  168.558569]  sha512_ssse3 drm_suballoc_helper sha256_ssse3 r8169
drm_ttm_helper aesni_intel realtek ttm crypto_simd cryptd i2c_algo_bit
mdio_devres uas serio_raw rtsx_usb drm_display_helper libphy usb_storage
cec video wmi
[  168.558586] CPU: 0 UID: 0 PID: 13 Comm: kworker/u16:1 Tainted: P
 W  OE       6.15.4-arch2-1 #1 PREEMPT(full)
 bf56011d6043294f437da1888a30a6d02e6dd116
[  168.558591] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_MOD=
ULE,
[E]=3DUNSIGNED_MODULE
[  168.558592] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7
01/29/2018
[  168.558593] Workqueue: async async_run_entry_fn
[  168.558599] RIP: 0010:amdgpu_irq_put+0x46/0x70 [amdgpu]
[  168.559474] Code: c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 d1 48 8d 04
88 8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9 5f c6 44 d5 e9 5a fd ff ff
<0f> 0b b8 ea ff ff ff e9 4e c6 44 d5 b8 ea ff ff ff e9 44 c6 44 d5
[  168.559476] RSP: 0018:ffffd0864011fd10 EFLAGS: 00010246
[  168.559478] RAX: ffff8c5715874800 RBX: ffff8c5717d2d7a0 RCX:
0000000000000000
[  168.559479] RDX: 0000000000000000 RSI: ffff8c5717d2dde0 RDI:
ffff8c5717d00000
[  168.559480] RBP: ffff8c5717d103f0 R08: ffffd0864011fc98 R09:
ffff8c5717d0fb68
[  168.559481] R10: ffff8c5717d0fb08 R11: 0000000000000000 R12:
ffff8c5717d10830
[  168.559482] R13: 0000000000000002 R14: ffff8c5717d00000 R15:
ffff8c5717d2dde0
[  168.559484] FS:  0000000000000000(0000) GS:ffff8c5a08f2f000(0000)
knlGS:0000000000000000
[  168.559485] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  168.559487] CR2: 00007fb941b67000 CR3: 000000010f832000 CR4:
00000000001506f0
[  168.559488] Call Trace:
[  168.559491]  <TASK>
[  168.559492]  amdgpu_fence_driver_hw_fini+0xf9/0x130 [amdgpu
fd2a24652620738c2ec44a27ca03228c2099e273]
[  168.560355]  amdgpu_device_suspend+0xbc/0x160 [amdgpu
fd2a24652620738c2ec44a27ca03228c2099e273]
[  168.561214]  pci_pm_suspend+0x80/0x170
[  168.561220]  ? __pfx_pci_pm_suspend+0x10/0x10
[  168.561222]  dpm_run_callback+0x4a/0x150
[  168.561226]  device_suspend+0x14d/0x540
[  168.561229]  async_suspend+0x21/0x30
[  168.561231]  async_run_entry_fn+0x36/0x140
[  168.561235]  process_one_work+0x193/0x350
[  168.561239]  worker_thread+0x2d7/0x410
[  168.561241]  ? __pfx_worker_thread+0x10/0x10
[  168.561243]  kthread+0xfc/0x240
[  168.561246]  ? __pfx_kthread+0x10/0x10
[  168.561248]  ret_from_fork+0x34/0x50
[  168.561251]  ? __pfx_kthread+0x10/0x10
[  168.561253]  ret_from_fork_asm+0x1a/0x30
[  168.561258]  </TASK>
[  168.561259] ---[ end trace 0000000000000000 ]---
[  168.561348] ------------[ cut here ]------------
[  168.561349] WARNING: CPU: 0 PID: 13 at
drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:631 amdgpu_irq_put+0x46/0x70
[amdgpu]
[  168.562229] Modules linked in: ccm algif_aead qrtr crypto_null
des3_ede_x86_64 des_generic libdes algif_skcipher cmac md4 algif_hash
af_alg kvm_amd ccp wl(POE) kvm snd_hda_codec_realtek snd_hda_codec_generic
snd_hda_scodec_component irqbypass snd_hda_codec_hdmi snd_hda_intel
snd_intel_dspcfg snd_intel_sdw_acpi dell_pc ath10k_pci snd_ctl_led
snd_hda_codec snd_hda_core snd_hwdep ath10k_core snd_pcm snd_timer ath
ee1004 snd polyval_clmulni soundcore platform_profile mac80211 rtsx_usb_ms
libarc4 polyval_generic sp5100_tco dell_laptop btusb joydev hid_multitouch
memstick mousedev ghash_clmulni_intel btrtl btintel btbcm btmtk dell_wmi
dell_smm_hwmon bluetooth sparse_keymap sha1_ssse3 pcspkr i2c_piix4
i2c_hid_acpi dell_smbios dcdbas dell_wmi_descriptor dell_rbtn psmouse
wmi_bmof i2c_hid i2c_smbus fam15h_power k10temp cfg80211 mac_hid rfkill
pkcs8_key_parser dm_mod nfnetlink ip_tables x_tables overlay squashfs loop
isofs cdrom amdgpu amdxcp gpu_sched rtsx_usb_sdmmc
drm_panel_backlight_quirks drm_buddy mmc_core drm_exec
[  168.562294]  sha512_ssse3 drm_suballoc_helper sha256_ssse3 r8169
drm_ttm_helper aesni_intel realtek ttm crypto_simd cryptd i2c_algo_bit
mdio_devres uas serio_raw rtsx_usb drm_display_helper libphy usb_storage
cec video wmi
[  168.562310] CPU: 0 UID: 0 PID: 13 Comm: kworker/u16:1 Tainted: P
 W  OE       6.15.4-arch2-1 #1 PREEMPT(full)
 bf56011d6043294f437da1888a30a6d02e6dd116
[  168.562315] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_MOD=
ULE,
[E]=3DUNSIGNED_MODULE
[  168.562316] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7
01/29/2018
[  168.562317] Workqueue: async async_run_entry_fn
[  168.562322] RIP: 0010:amdgpu_irq_put+0x46/0x70 [amdgpu]
[  168.563198] Code: c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 d1 48 8d 04
88 8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9 5f c6 44 d5 e9 5a fd ff ff
<0f> 0b b8 ea ff ff ff e9 4e c6 44 d5 b8 ea ff ff ff e9 44 c6 44 d5
[  168.563200] RSP: 0018:ffffd0864011fd10 EFLAGS: 00010246
[  168.563202] RAX: ffff8c5715874800 RBX: ffff8c5717d2dac0 RCX:
0000000000000000
[  168.563204] RDX: 0000000000000000 RSI: ffff8c5717d2dde0 RDI:
ffff8c5717d00000
[  168.563205] RBP: ffff8c5717d103f8 R08: ffffd0864011fc98 R09:
ffff8c5717d0fb68
[  168.563206] R10: ffff8c5717d0fb08 R11: 0000000000000000 R12:
ffff8c5717d10830
[  168.563207] R13: 0000000000000002 R14: ffff8c5717d00000 R15:
ffff8c5717d2dde0
[  168.563208] FS:  0000000000000000(0000) GS:ffff8c5a08f2f000(0000)
knlGS:0000000000000000
[  168.563209] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  168.563210] CR2: 00007fb941b67000 CR3: 000000010f832000 CR4:
00000000001506f0
[  168.563212] Call Trace:
[  168.563214]  <TASK>
[  168.563215]  amdgpu_fence_driver_hw_fini+0xf9/0x130 [amdgpu
fd2a24652620738c2ec44a27ca03228c2099e273]
[  168.564083]  amdgpu_device_suspend+0xbc/0x160 [amdgpu
fd2a24652620738c2ec44a27ca03228c2099e273]
[  168.564940]  pci_pm_suspend+0x80/0x170
[  168.564946]  ? __pfx_pci_pm_suspend+0x10/0x10
[  168.564948]  dpm_run_callback+0x4a/0x150
[  168.564952]  device_suspend+0x14d/0x540
[  168.564954]  async_suspend+0x21/0x30
[  168.564956]  async_run_entry_fn+0x36/0x140
[  168.564961]  process_one_work+0x193/0x350
[  168.564965]  worker_thread+0x2d7/0x410
[  168.564967]  ? __pfx_worker_thread+0x10/0x10
[  168.564969]  kthread+0xfc/0x240
[  168.564972]  ? __pfx_kthread+0x10/0x10
[  168.564973]  ret_from_fork+0x34/0x50
[  168.564978]  ? __pfx_kthread+0x10/0x10
[  168.564979]  ret_from_fork_asm+0x1a/0x30
[  168.564984]  </TASK>
[  168.564985] ---[ end trace 0000000000000000 ]---
[  168.565077] ------------[ cut here ]------------
[  168.565078] WARNING: CPU: 0 PID: 13 at
drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:631 amdgpu_irq_put+0x46/0x70
[amdgpu]
[  168.565969] Modules linked in: ccm algif_aead qrtr crypto_null
des3_ede_x86_64 des_generic libdes algif_skcipher cmac md4 algif_hash
af_alg kvm_amd ccp wl(POE) kvm snd_hda_codec_realtek snd_hda_codec_generic
snd_hda_scodec_component irqbypass snd_hda_codec_hdmi snd_hda_intel
snd_intel_dspcfg snd_intel_sdw_acpi dell_pc ath10k_pci snd_ctl_led
snd_hda_codec snd_hda_core snd_hwdep ath10k_core snd_pcm snd_timer ath
ee1004 snd polyval_clmulni soundcore platform_profile mac80211 rtsx_usb_ms
libarc4 polyval_generic sp5100_tco dell_laptop btusb joydev hid_multitouch
memstick mousedev ghash_clmulni_intel btrtl btintel btbcm btmtk dell_wmi
dell_smm_hwmon bluetooth sparse_keymap sha1_ssse3 pcspkr i2c_piix4
i2c_hid_acpi dell_smbios dcdbas dell_wmi_descriptor dell_rbtn psmouse
wmi_bmof i2c_hid i2c_smbus fam15h_power k10temp cfg80211 mac_hid rfkill
pkcs8_key_parser dm_mod nfnetlink ip_tables x_tables overlay squashfs loop
isofs cdrom amdgpu amdxcp gpu_sched rtsx_usb_sdmmc
drm_panel_backlight_quirks drm_buddy mmc_core drm_exec
[  168.566034]  sha512_ssse3 drm_suballoc_helper sha256_ssse3 r8169
drm_ttm_helper aesni_intel realtek ttm crypto_simd cryptd i2c_algo_bit
mdio_devres uas serio_raw rtsx_usb drm_display_helper libphy usb_storage
cec video wmi
[  168.566051] CPU: 0 UID: 0 PID: 13 Comm: kworker/u16:1 Tainted: P
 W  OE       6.15.4-arch2-1 #1 PREEMPT(full)
 bf56011d6043294f437da1888a30a6d02e6dd116
[  168.566055] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_MOD=
ULE,
[E]=3DUNSIGNED_MODULE
[  168.566056] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7
01/29/2018
[  168.566058] Workqueue: async async_run_entry_fn
[  168.566063] RIP: 0010:amdgpu_irq_put+0x46/0x70 [amdgpu]
[  168.566938] Code: c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 d1 48 8d 04
88 8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9 5f c6 44 d5 e9 5a fd ff ff
<0f> 0b b8 ea ff ff ff e9 4e c6 44 d5 b8 ea ff ff ff e9 44 c6 44 d5
[  168.566940] RSP: 0018:ffffd0864011fd10 EFLAGS: 00010246
[  168.566942] RAX: ffff8c5702797338 RBX: ffff8c5717d2ec70 RCX:
0000000000000000
[  168.566943] RDX: 0000000000000000 RSI: ffff8c5717d2f5d0 RDI:
ffff8c5717d00000
[  168.566944] RBP: ffff8c5717d10400 R08: ffffd0864011fc98 R09:
ffff8c5717d0fb68
[  168.566945] R10: ffff8c5717d0fb08 R11: 0000000000000000 R12:
ffff8c5717d10830
[  168.566946] R13: 0000000000000002 R14: ffff8c5717d00000 R15:
ffff8c5717d2f5d0
[  168.566947] FS:  0000000000000000(0000) GS:ffff8c5a08f2f000(0000)
knlGS:0000000000000000
[  168.566949] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  168.566950] CR2: 00007fb941b67000 CR3: 000000010f832000 CR4:
00000000001506f0
[  168.566951] Call Trace:
[  168.566954]  <TASK>
[  168.566955]  amdgpu_fence_driver_hw_fini+0xf9/0x130 [amdgpu
fd2a24652620738c2ec44a27ca03228c2099e273]
[  168.567819]  amdgpu_device_suspend+0xbc/0x160 [amdgpu
fd2a24652620738c2ec44a27ca03228c2099e273]
[  168.568692]  pci_pm_suspend+0x80/0x170
[  168.568697]  ? __pfx_pci_pm_suspend+0x10/0x10
[  168.568699]  dpm_run_callback+0x4a/0x150
[  168.568704]  device_suspend+0x14d/0x540
[  168.568706]  async_suspend+0x21/0x30
[  168.568708]  async_run_entry_fn+0x36/0x140
[  168.568713]  process_one_work+0x193/0x350
[  168.568717]  worker_thread+0x2d7/0x410
[  168.568719]  ? __pfx_worker_thread+0x10/0x10
[  168.568721]  kthread+0xfc/0x240
[  168.568724]  ? __pfx_kthread+0x10/0x10
[  168.568725]  ret_from_fork+0x34/0x50
[  168.568729]  ? __pfx_kthread+0x10/0x10
[  168.568731]  ret_from_fork_asm+0x1a/0x30
[  168.568736]  </TASK>
[  168.568737] ---[ end trace 0000000000000000 ]---
[  168.568825] ------------[ cut here ]------------
[  168.568826] WARNING: CPU: 0 PID: 13 at
drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:631 amdgpu_irq_put+0x46/0x70
[amdgpu]
[  168.569709] Modules linked in: ccm algif_aead qrtr crypto_null
des3_ede_x86_64 des_generic libdes algif_skcipher cmac md4 algif_hash
af_alg kvm_amd ccp wl(POE) kvm snd_hda_codec_realtek snd_hda_codec_generic
snd_hda_scodec_component irqbypass snd_hda_codec_hdmi snd_hda_intel
snd_intel_dspcfg snd_intel_sdw_acpi dell_pc ath10k_pci snd_ctl_led
snd_hda_codec snd_hda_core snd_hwdep ath10k_core snd_pcm snd_timer ath
ee1004 snd polyval_clmulni soundcore platform_profile mac80211 rtsx_usb_ms
libarc4 polyval_generic sp5100_tco dell_laptop btusb joydev hid_multitouch
memstick mousedev ghash_clmulni_intel btrtl btintel btbcm btmtk dell_wmi
dell_smm_hwmon bluetooth sparse_keymap sha1_ssse3 pcspkr i2c_piix4
i2c_hid_acpi dell_smbios dcdbas dell_wmi_descriptor dell_rbtn psmouse
wmi_bmof i2c_hid i2c_smbus fam15h_power k10temp cfg80211 mac_hid rfkill
pkcs8_key_parser dm_mod nfnetlink ip_tables x_tables overlay squashfs loop
isofs cdrom amdgpu amdxcp gpu_sched rtsx_usb_sdmmc
drm_panel_backlight_quirks drm_buddy mmc_core drm_exec
[  168.569774]  sha512_ssse3 drm_suballoc_helper sha256_ssse3 r8169
drm_ttm_helper aesni_intel realtek ttm crypto_simd cryptd i2c_algo_bit
mdio_devres uas serio_raw rtsx_usb drm_display_helper libphy usb_storage
cec video wmi
[  168.569790] CPU: 0 UID: 0 PID: 13 Comm: kworker/u16:1 Tainted: P
 W  OE       6.15.4-arch2-1 #1 PREEMPT(full)
 bf56011d6043294f437da1888a30a6d02e6dd116
[  168.569795] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_MOD=
ULE,
[E]=3DUNSIGNED_MODULE
[  168.569796] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7
01/29/2018
[  168.569797] Workqueue: async async_run_entry_fn
[  168.569802] RIP: 0010:amdgpu_irq_put+0x46/0x70 [amdgpu]
[  168.570671] Code: c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 d1 48 8d 04
88 8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9 5f c6 44 d5 e9 5a fd ff ff
<0f> 0b b8 ea ff ff ff e9 4e c6 44 d5 b8 ea ff ff ff e9 44 c6 44 d5
[  168.570673] RSP: 0018:ffffd0864011fd10 EFLAGS: 00010246
[  168.570675] RAX: ffff8c5702797338 RBX: ffff8c5717d2ef90 RCX:
0000000000000000
[  168.570676] RDX: 0000000000000000 RSI: ffff8c5717d2f5d0 RDI:
ffff8c5717d00000
[  168.570677] RBP: ffff8c5717d10408 R08: ffffd0864011fc98 R09:
ffff8c5717d0fb68
[  168.570678] R10: ffff8c5717d0fb08 R11: 0000000000000000 R12:
ffff8c5717d10830
[  168.570679] R13: 0000000000000002 R14: ffff8c5717d00000 R15:
ffff8c5717d2f5d0
[  168.570681] FS:  0000000000000000(0000) GS:ffff8c5a08f2f000(0000)
knlGS:0000000000000000
[  168.570682] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  168.570683] CR2: 00007fb941b67000 CR3: 000000010f832000 CR4:
00000000001506f0
[  168.570684] Call Trace:
[  168.570687]  <TASK>
[  168.570688]  amdgpu_fence_driver_hw_fini+0xf9/0x130 [amdgpu
fd2a24652620738c2ec44a27ca03228c2099e273]
[  168.571545]  amdgpu_device_suspend+0xbc/0x160 [amdgpu
fd2a24652620738c2ec44a27ca03228c2099e273]
[  168.572393]  pci_pm_suspend+0x80/0x170
[  168.572398]  ? __pfx_pci_pm_suspend+0x10/0x10
[  168.572400]  dpm_run_callback+0x4a/0x150
[  168.572404]  device_suspend+0x14d/0x540
[  168.572407]  async_suspend+0x21/0x30
[  168.572409]  async_run_entry_fn+0x36/0x140
[  168.572414]  process_one_work+0x193/0x350
[  168.572417]  worker_thread+0x2d7/0x410
[  168.572420]  ? __pfx_worker_thread+0x10/0x10
[  168.572422]  kthread+0xfc/0x240
[  168.572424]  ? __pfx_kthread+0x10/0x10
[  168.572426]  ret_from_fork+0x34/0x50
[  168.572429]  ? __pfx_kthread+0x10/0x10
[  168.572431]  ret_from_fork_asm+0x1a/0x30
[  168.572436]  </TASK>
[  168.572437] ---[ end trace 0000000000000000 ]---
[  168.572527] ------------[ cut here ]------------
[  168.572528] WARNING: CPU: 0 PID: 13 at
drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:631 amdgpu_irq_put+0x46/0x70
[amdgpu]
[  168.573409] Modules linked in: ccm algif_aead qrtr crypto_null
des3_ede_x86_64 des_generic libdes algif_skcipher cmac md4 algif_hash
af_alg kvm_amd ccp wl(POE) kvm snd_hda_codec_realtek snd_hda_codec_generic
snd_hda_scodec_component irqbypass snd_hda_codec_hdmi snd_hda_intel
snd_intel_dspcfg snd_intel_sdw_acpi dell_pc ath10k_pci snd_ctl_led
snd_hda_codec snd_hda_core snd_hwdep ath10k_core snd_pcm snd_timer ath
ee1004 snd polyval_clmulni soundcore platform_profile mac80211 rtsx_usb_ms
libarc4 polyval_generic sp5100_tco dell_laptop btusb joydev hid_multitouch
memstick mousedev ghash_clmulni_intel btrtl btintel btbcm btmtk dell_wmi
dell_smm_hwmon bluetooth sparse_keymap sha1_ssse3 pcspkr i2c_piix4
i2c_hid_acpi dell_smbios dcdbas dell_wmi_descriptor dell_rbtn psmouse
wmi_bmof i2c_hid i2c_smbus fam15h_power k10temp cfg80211 mac_hid rfkill
pkcs8_key_parser dm_mod nfnetlink ip_tables x_tables overlay squashfs loop
isofs cdrom amdgpu amdxcp gpu_sched rtsx_usb_sdmmc
drm_panel_backlight_quirks drm_buddy mmc_core drm_exec
[  168.573473]  sha512_ssse3 drm_suballoc_helper sha256_ssse3 r8169
drm_ttm_helper aesni_intel realtek ttm crypto_simd cryptd i2c_algo_bit
mdio_devres uas serio_raw rtsx_usb drm_display_helper libphy usb_storage
cec video wmi
[  168.573489] CPU: 0 UID: 0 PID: 13 Comm: kworker/u16:1 Tainted: P
 W  OE       6.15.4-arch2-1 #1 PREEMPT(full)
 bf56011d6043294f437da1888a30a6d02e6dd116
[  168.573501] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_MOD=
ULE,
[E]=3DUNSIGNED_MODULE
[  168.573502] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7
01/29/2018
[  168.573504] Workqueue: async async_run_entry_fn
[  168.573509] RIP: 0010:amdgpu_irq_put+0x46/0x70 [amdgpu]
[  168.574385] Code: c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 d1 48 8d 04
88 8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9 5f c6 44 d5 e9 5a fd ff ff
<0f> 0b b8 ea ff ff ff e9 4e c6 44 d5 b8 ea ff ff ff e9 44 c6 44 d5
[  168.574387] RSP: 0018:ffffd0864011fd10 EFLAGS: 00010246
[  168.574389] RAX: ffff8c5702797338 RBX: ffff8c5717d2f2b0 RCX:
0000000000000000
[  168.574390] RDX: 0000000000000000 RSI: ffff8c5717d2f5d0 RDI:
ffff8c5717d00000
[  168.574392] RBP: ffff8c5717d10410 R08: ffffd0864011fc98 R09:
ffff8c5717d0fb68
[  168.574392] R10: ffff8c5717d0fb08 R11: 0000000000000000 R12:
ffff8c5717d10830
[  168.574393] R13: 0000000000000002 R14: ffff8c5717d00000 R15:
ffff8c5717d2f5d0
[  168.574395] FS:  0000000000000000(0000) GS:ffff8c5a08f2f000(0000)
knlGS:0000000000000000
[  168.574396] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  168.574397] CR2: 00007fb941b67000 CR3: 000000010f832000 CR4:
00000000001506f0
[  168.574399] Call Trace:
[  168.574401]  <TASK>
[  168.574402]  amdgpu_fence_driver_hw_fini+0xf9/0x130 [amdgpu
fd2a24652620738c2ec44a27ca03228c2099e273]
[  168.575267]  amdgpu_device_suspend+0xbc/0x160 [amdgpu
fd2a24652620738c2ec44a27ca03228c2099e273]
[  168.576129]  pci_pm_suspend+0x80/0x170
[  168.576134]  ? __pfx_pci_pm_suspend+0x10/0x10
[  168.576136]  dpm_run_callback+0x4a/0x150
[  168.576141]  device_suspend+0x14d/0x540
[  168.576143]  async_suspend+0x21/0x30
[  168.576145]  async_run_entry_fn+0x36/0x140
[  168.576150]  process_one_work+0x193/0x350
[  168.576154]  worker_thread+0x2d7/0x410
[  168.576156]  ? __pfx_worker_thread+0x10/0x10
[  168.576158]  kthread+0xfc/0x240
[  168.576161]  ? __pfx_kthread+0x10/0x10
[  168.576163]  ret_from_fork+0x34/0x50
[  168.576166]  ? __pfx_kthread+0x10/0x10
[  168.576168]  ret_from_fork_asm+0x1a/0x30
[  168.576173]  </TASK>
[  168.576174] ---[ end trace 0000000000000000 ]---
[  168.590885] ------------[ cut here ]------------
[  168.590887] WARNING: CPU: 0 PID: 13 at
drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:631 amdgpu_irq_put+0x46/0x70
[amdgpu]
[  168.591773] Modules linked in: ccm algif_aead qrtr crypto_null
des3_ede_x86_64 des_generic libdes algif_skcipher cmac md4 algif_hash
af_alg kvm_amd ccp wl(POE) kvm snd_hda_codec_realtek snd_hda_codec_generic
snd_hda_scodec_component irqbypass snd_hda_codec_hdmi snd_hda_intel
snd_intel_dspcfg snd_intel_sdw_acpi dell_pc ath10k_pci snd_ctl_led
snd_hda_codec snd_hda_core snd_hwdep ath10k_core snd_pcm snd_timer ath
ee1004 snd polyval_clmulni soundcore platform_profile mac80211 rtsx_usb_ms
libarc4 polyval_generic sp5100_tco dell_laptop btusb joydev hid_multitouch
memstick mousedev ghash_clmulni_intel btrtl btintel btbcm btmtk dell_wmi
dell_smm_hwmon bluetooth sparse_keymap sha1_ssse3 pcspkr i2c_piix4
i2c_hid_acpi dell_smbios dcdbas dell_wmi_descriptor dell_rbtn psmouse
wmi_bmof i2c_hid i2c_smbus fam15h_power k10temp cfg80211 mac_hid rfkill
pkcs8_key_parser dm_mod nfnetlink ip_tables x_tables overlay squashfs loop
isofs cdrom amdgpu amdxcp gpu_sched rtsx_usb_sdmmc
drm_panel_backlight_quirks drm_buddy mmc_core drm_exec
[  168.591838]  sha512_ssse3 drm_suballoc_helper sha256_ssse3 r8169
drm_ttm_helper aesni_intel realtek ttm crypto_simd cryptd i2c_algo_bit
mdio_devres uas serio_raw rtsx_usb drm_display_helper libphy usb_storage
cec video wmi
[  168.591855] CPU: 0 UID: 0 PID: 13 Comm: kworker/u16:1 Tainted: P
 W  OE       6.15.4-arch2-1 #1 PREEMPT(full)
 bf56011d6043294f437da1888a30a6d02e6dd116
[  168.591860] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_MOD=
ULE,
[E]=3DUNSIGNED_MODULE
[  168.591861] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7
01/29/2018
[  168.591863] Workqueue: async async_run_entry_fn
[  168.591868] RIP: 0010:amdgpu_irq_put+0x46/0x70 [amdgpu]
[  168.592747] Code: c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 d1 48 8d 04
88 8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9 5f c6 44 d5 e9 5a fd ff ff
<0f> 0b b8 ea ff ff ff e9 4e c6 44 d5 b8 ea ff ff ff e9 44 c6 44 d5
[  168.592749] RSP: 0018:ffffd0864011fcf8 EFLAGS: 00010246
[  168.592752] RAX: ffff8c57027976e8 RBX: ffff8c5717d00000 RCX:
0000000000000000
[  168.592753] RDX: 0000000000000000 RSI: ffff8c5717d259b8 RDI:
ffff8c5717d00000
[  168.592754] RBP: ffff8c5717d16fa0 R08: 0000000000000001 R09:
ffffffffc0a8cfd0
[  168.592755] R10: 0000000000005398 R11: 0000000000000000 R12:
ffff8c5717d50368
[  168.592756] R13: ffff8c5717cfffe8 R14: 0000000000000000 R15:
ffff8c5716adbec0
[  168.592758] FS:  0000000000000000(0000) GS:ffff8c5a08f2f000(0000)
knlGS:0000000000000000
[  168.592759] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  168.592760] CR2: 00007fb941b67000 CR3: 000000010f832000 CR4:
00000000001506f0
[  168.592762] Call Trace:
[  168.592765]  <TASK>
[  168.592766]  gfx_v8_0_hw_fini+0x2c/0x350 [amdgpu
fd2a24652620738c2ec44a27ca03228c2099e273]
[  168.593658]  amdgpu_ip_block_suspend+0x27/0x50 [amdgpu
fd2a24652620738c2ec44a27ca03228c2099e273]
[  168.594515]  amdgpu_device_ip_suspend_phase2+0x93/0x200 [amdgpu
fd2a24652620738c2ec44a27ca03228c2099e273]
[  168.595365]  amdgpu_device_suspend+0xc4/0x160 [amdgpu
fd2a24652620738c2ec44a27ca03228c2099e273]
[  168.596230]  pci_pm_suspend+0x80/0x170
[  168.596236]  ? __pfx_pci_pm_suspend+0x10/0x10
[  168.596238]  dpm_run_callback+0x4a/0x150
[  168.596242]  device_suspend+0x14d/0x540
[  168.596245]  async_suspend+0x21/0x30
[  168.596247]  async_run_entry_fn+0x36/0x140
[  168.596252]  process_one_work+0x193/0x350
[  168.596255]  worker_thread+0x2d7/0x410
[  168.596258]  ? __pfx_worker_thread+0x10/0x10
[  168.596260]  kthread+0xfc/0x240
[  168.596262]  ? __pfx_kthread+0x10/0x10
[  168.596264]  ret_from_fork+0x34/0x50
[  168.596268]  ? __pfx_kthread+0x10/0x10
[  168.596270]  ret_from_fork_asm+0x1a/0x30
[  168.596275]  </TASK>
[  168.596276] ---[ end trace 0000000000000000 ]---
[  168.596362] ------------[ cut here ]------------
[  168.596363] WARNING: CPU: 0 PID: 13 at
drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:631 amdgpu_irq_put+0x46/0x70
[amdgpu]
[  168.597247] Modules linked in: ccm algif_aead qrtr crypto_null
des3_ede_x86_64 des_generic libdes algif_skcipher cmac md4 algif_hash
af_alg kvm_amd ccp wl(POE) kvm snd_hda_codec_realtek snd_hda_codec_generic
snd_hda_scodec_component irqbypass snd_hda_codec_hdmi snd_hda_intel
snd_intel_dspcfg snd_intel_sdw_acpi dell_pc ath10k_pci snd_ctl_led
snd_hda_codec snd_hda_core snd_hwdep ath10k_core snd_pcm snd_timer ath
ee1004 snd polyval_clmulni soundcore platform_profile mac80211 rtsx_usb_ms
libarc4 polyval_generic sp5100_tco dell_laptop btusb joydev hid_multitouch
memstick mousedev ghash_clmulni_intel btrtl btintel btbcm btmtk dell_wmi
dell_smm_hwmon bluetooth sparse_keymap sha1_ssse3 pcspkr i2c_piix4
i2c_hid_acpi dell_smbios dcdbas dell_wmi_descriptor dell_rbtn psmouse
wmi_bmof i2c_hid i2c_smbus fam15h_power k10temp cfg80211 mac_hid rfkill
pkcs8_key_parser dm_mod nfnetlink ip_tables x_tables overlay squashfs loop
isofs cdrom amdgpu amdxcp gpu_sched rtsx_usb_sdmmc
drm_panel_backlight_quirks drm_buddy mmc_core drm_exec
[  168.597312]  sha512_ssse3 drm_suballoc_helper sha256_ssse3 r8169
drm_ttm_helper aesni_intel realtek ttm crypto_simd cryptd i2c_algo_bit
mdio_devres uas serio_raw rtsx_usb drm_display_helper libphy usb_storage
cec video wmi
[  168.597329] CPU: 0 UID: 0 PID: 13 Comm: kworker/u16:1 Tainted: P
 W  OE       6.15.4-arch2-1 #1 PREEMPT(full)
 bf56011d6043294f437da1888a30a6d02e6dd116
[  168.597334] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_MOD=
ULE,
[E]=3DUNSIGNED_MODULE
[  168.597334] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7
01/29/2018
[  168.597336] Workqueue: async async_run_entry_fn
[  168.597341] RIP: 0010:amdgpu_irq_put+0x46/0x70 [amdgpu]
[  168.598228] Code: c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 d1 48 8d 04
88 8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9 5f c6 44 d5 e9 5a fd ff ff
<0f> 0b b8 ea ff ff ff e9 4e c6 44 d5 b8 ea ff ff ff e9 44 c6 44 d5
[  168.598230] RSP: 0018:ffffd0864011fcf8 EFLAGS: 00010246
[  168.598232] RAX: ffff8c57027975b8 RBX: ffff8c5717d00000 RCX:
0000000000000000
[  168.598233] RDX: 0000000000000000 RSI: ffff8c5717d259d0 RDI:
ffff8c5717d00000
[  168.598234] RBP: ffff8c5717d16fa0 R08: 0000000000000001 R09:
ffffffffc0a8cfd0
[  168.598235] R10: 0000000000005398 R11: 0000000000000000 R12:
ffff8c5717d50368
[  168.598236] R13: ffff8c5717cfffe8 R14: 0000000000000000 R15:
ffff8c5716adbec0
[  168.598238] FS:  0000000000000000(0000) GS:ffff8c5a08f2f000(0000)
knlGS:0000000000000000
[  168.598239] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  168.598240] CR2: 00007fb941b67000 CR3: 000000010f832000 CR4:
00000000001506f0
[  168.598241] Call Trace:
[  168.598244]  <TASK>
[  168.598245]  gfx_v8_0_hw_fini+0x3d/0x350 [amdgpu
fd2a24652620738c2ec44a27ca03228c2099e273]
[  168.599123]  amdgpu_ip_block_suspend+0x27/0x50 [amdgpu
fd2a24652620738c2ec44a27ca03228c2099e273]
[  168.599979]  amdgpu_device_ip_suspend_phase2+0x93/0x200 [amdgpu
fd2a24652620738c2ec44a27ca03228c2099e273]
[  168.600831]  amdgpu_device_suspend+0xc4/0x160 [amdgpu
fd2a24652620738c2ec44a27ca03228c2099e273]
[  168.601701]  pci_pm_suspend+0x80/0x170
[  168.601707]  ? __pfx_pci_pm_suspend+0x10/0x10
[  168.601709]  dpm_run_callback+0x4a/0x150
[  168.601713]  device_suspend+0x14d/0x540
[  168.601716]  async_suspend+0x21/0x30
[  168.601718]  async_run_entry_fn+0x36/0x140
[  168.601723]  process_one_work+0x193/0x350
[  168.601727]  worker_thread+0x2d7/0x410
[  168.601729]  ? __pfx_worker_thread+0x10/0x10
[  168.601732]  kthread+0xfc/0x240
[  168.601734]  ? __pfx_kthread+0x10/0x10
[  168.601736]  ret_from_fork+0x34/0x50
[  168.601739]  ? __pfx_kthread+0x10/0x10
[  168.601741]  ret_from_fork_asm+0x1a/0x30
[  168.601746]  </TASK>
[  168.601747] ---[ end trace 0000000000000000 ]---
[  168.601837] ------------[ cut here ]------------
[  168.601838] WARNING: CPU: 0 PID: 13 at
drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:631 amdgpu_irq_put+0x46/0x70
[amdgpu]
[  168.602712] Modules linked in: ccm algif_aead qrtr crypto_null
des3_ede_x86_64 des_generic libdes algif_skcipher cmac md4 algif_hash
af_alg kvm_amd ccp wl(POE) kvm snd_hda_codec_realtek snd_hda_codec_generic
snd_hda_scodec_component irqbypass snd_hda_codec_hdmi snd_hda_intel
snd_intel_dspcfg snd_intel_sdw_acpi dell_pc ath10k_pci snd_ctl_led
snd_hda_codec snd_hda_core snd_hwdep ath10k_core snd_pcm snd_timer ath
ee1004 snd polyval_clmulni soundcore platform_profile mac80211 rtsx_usb_ms
libarc4 polyval_generic sp5100_tco dell_laptop btusb joydev hid_multitouch
memstick mousedev ghash_clmulni_intel btrtl btintel btbcm btmtk dell_wmi
dell_smm_hwmon bluetooth sparse_keymap sha1_ssse3 pcspkr i2c_piix4
i2c_hid_acpi dell_smbios dcdbas dell_wmi_descriptor dell_rbtn psmouse
wmi_bmof i2c_hid i2c_smbus fam15h_power k10temp cfg80211 mac_hid rfkill
pkcs8_key_parser dm_mod nfnetlink ip_tables x_tables overlay squashfs loop
isofs cdrom amdgpu amdxcp gpu_sched rtsx_usb_sdmmc
drm_panel_backlight_quirks drm_buddy mmc_core drm_exec
[  168.602777]  sha512_ssse3 drm_suballoc_helper sha256_ssse3 r8169
drm_ttm_helper aesni_intel realtek ttm crypto_simd cryptd i2c_algo_bit
mdio_devres uas serio_raw rtsx_usb drm_display_helper libphy usb_storage
cec video wmi
[  168.602794] CPU: 0 UID: 0 PID: 13 Comm: kworker/u16:1 Tainted: P
 W  OE       6.15.4-arch2-1 #1 PREEMPT(full)
 bf56011d6043294f437da1888a30a6d02e6dd116
[  168.602798] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_MOD=
ULE,
[E]=3DUNSIGNED_MODULE
[  168.602799] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7
01/29/2018
[  168.602801] Workqueue: async async_run_entry_fn
[  168.602806] RIP: 0010:amdgpu_irq_put+0x46/0x70 [amdgpu]
[  168.603681] Code: c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 d1 48 8d 04
88 8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9 5f c6 44 d5 e9 5a fd ff ff
<0f> 0b b8 ea ff ff ff e9 4e c6 44 d5 b8 ea ff ff ff e9 44 c6 44 d5
[  168.603683] RSP: 0018:ffffd0864011fcf8 EFLAGS: 00010246
[  168.603686] RAX: ffff8c5702797d28 RBX: ffff8c5717d00000 RCX:
0000000000000000
[  168.603687] RDX: 0000000000000000 RSI: ffff8c5717d25a00 RDI:
ffff8c5717d00000
[  168.603688] RBP: ffff8c5717d16fa0 R08: 0000000000000001 R09:
ffffffffc0a8cfd0
[  168.603689] R10: 0000000000005398 R11: 0000000000000000 R12:
ffff8c5717d50368
[  168.603690] R13: ffff8c5717cfffe8 R14: 0000000000000000 R15:
ffff8c5716adbec0
[  168.603691] FS:  0000000000000000(0000) GS:ffff8c5a08f2f000(0000)
knlGS:0000000000000000
[  168.603693] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  168.603694] CR2: 00007fb941b67000 CR3: 000000010f832000 CR4:
00000000001506f0
[  168.603695] Call Trace:
[  168.603698]  <TASK>
[  168.603699]  gfx_v8_0_hw_fini+0x4e/0x350 [amdgpu
fd2a24652620738c2ec44a27ca03228c2099e273]
[  168.604588]  amdgpu_ip_block_suspend+0x27/0x50 [amdgpu
fd2a24652620738c2ec44a27ca03228c2099e273]
[  168.605444]  amdgpu_device_ip_suspend_phase2+0x93/0x200 [amdgpu
fd2a24652620738c2ec44a27ca03228c2099e273]
[  168.606307]  amdgpu_device_suspend+0xc4/0x160 [amdgpu
fd2a24652620738c2ec44a27ca03228c2099e273]
[  168.607159]  pci_pm_suspend+0x80/0x170
[  168.607165]  ? __pfx_pci_pm_suspend+0x10/0x10
[  168.607167]  dpm_run_callback+0x4a/0x150
[  168.607171]  device_suspend+0x14d/0x540
[  168.607174]  async_suspend+0x21/0x30
[  168.607176]  async_run_entry_fn+0x36/0x140
[  168.607181]  process_one_work+0x193/0x350
[  168.607184]  worker_thread+0x2d7/0x410
[  168.607187]  ? __pfx_worker_thread+0x10/0x10
[  168.607189]  kthread+0xfc/0x240
[  168.607191]  ? __pfx_kthread+0x10/0x10
[  168.607193]  ret_from_fork+0x34/0x50
[  168.607197]  ? __pfx_kthread+0x10/0x10
[  168.607199]  ret_from_fork_asm+0x1a/0x30
[  168.607204]  </TASK>
[  168.607205] ---[ end trace 0000000000000000 ]---
[  168.607293] ------------[ cut here ]------------
[  168.607293] WARNING: CPU: 0 PID: 13 at
drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:631 amdgpu_irq_put+0x46/0x70
[amdgpu]
[  168.608182] Modules linked in: ccm algif_aead qrtr crypto_null
des3_ede_x86_64 des_generic libdes algif_skcipher cmac md4 algif_hash
af_alg kvm_amd ccp wl(POE) kvm snd_hda_codec_realtek snd_hda_codec_generic
snd_hda_scodec_component irqbypass snd_hda_codec_hdmi snd_hda_intel
snd_intel_dspcfg snd_intel_sdw_acpi dell_pc ath10k_pci snd_ctl_led
snd_hda_codec snd_hda_core snd_hwdep ath10k_core snd_pcm snd_timer ath
ee1004 snd polyval_clmulni soundcore platform_profile mac80211 rtsx_usb_ms
libarc4 polyval_generic sp5100_tco dell_laptop btusb joydev hid_multitouch
memstick mousedev ghash_clmulni_intel btrtl btintel btbcm btmtk dell_wmi
dell_smm_hwmon bluetooth sparse_keymap sha1_ssse3 pcspkr i2c_piix4
i2c_hid_acpi dell_smbios dcdbas dell_wmi_descriptor dell_rbtn psmouse
wmi_bmof i2c_hid i2c_smbus fam15h_power k10temp cfg80211 mac_hid rfkill
pkcs8_key_parser dm_mod nfnetlink ip_tables x_tables overlay squashfs loop
isofs cdrom amdgpu amdxcp gpu_sched rtsx_usb_sdmmc
drm_panel_backlight_quirks drm_buddy mmc_core drm_exec
[  168.608248]  sha512_ssse3 drm_suballoc_helper sha256_ssse3 r8169
drm_ttm_helper aesni_intel realtek ttm crypto_simd cryptd i2c_algo_bit
mdio_devres uas serio_raw rtsx_usb drm_display_helper libphy usb_storage
cec video wmi
[  168.608265] CPU: 0 UID: 0 PID: 13 Comm: kworker/u16:1 Tainted: P
 W  OE       6.15.4-arch2-1 #1 PREEMPT(full)
 bf56011d6043294f437da1888a30a6d02e6dd116
[  168.608269] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_MOD=
ULE,
[E]=3DUNSIGNED_MODULE
[  168.608270] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7
01/29/2018
[  168.608272] Workqueue: async async_run_entry_fn
[  168.608277] RIP: 0010:amdgpu_irq_put+0x46/0x70 [amdgpu]
[  168.609158] Code: c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 d1 48 8d 04
88 8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9 5f c6 44 d5 e9 5a fd ff ff
<0f> 0b b8 ea ff ff ff e9 4e c6 44 d5 b8 ea ff ff ff e9 44 c6 44 d5
[  168.609160] RSP: 0018:ffffd0864011fcf8 EFLAGS: 00010246
[  168.609162] RAX: ffff8c5702797678 RBX: ffff8c5717d00000 RCX:
0000000000000000
[  168.609164] RDX: 0000000000000000 RSI: ffff8c5717d25a18 RDI:
ffff8c5717d00000
[  168.609165] RBP: ffff8c5717d16fa0 R08: 0000000000000001 R09:
ffffffffc0a8cfd0
[  168.609166] R10: 0000000000005398 R11: 0000000000000000 R12:
ffff8c5717d50368
[  168.609167] R13: ffff8c5717cfffe8 R14: 0000000000000000 R15:
ffff8c5716adbec0
[  168.609168] FS:  0000000000000000(0000) GS:ffff8c5a08f2f000(0000)
knlGS:0000000000000000
[  168.609170] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  168.609171] CR2: 00007fb941b67000 CR3: 000000010f832000 CR4:
00000000001506f0
[  168.609172] Call Trace:
[  168.609174]  <TASK>
[  168.609175]  gfx_v8_0_hw_fini+0x5f/0x350 [amdgpu
fd2a24652620738c2ec44a27ca03228c2099e273]
[  168.610062]  amdgpu_ip_block_suspend+0x27/0x50 [amdgpu
fd2a24652620738c2ec44a27ca03228c2099e273]
[  168.610919]  amdgpu_device_ip_suspend_phase2+0x93/0x200 [amdgpu
fd2a24652620738c2ec44a27ca03228c2099e273]
[  168.611771]  amdgpu_device_suspend+0xc4/0x160 [amdgpu
fd2a24652620738c2ec44a27ca03228c2099e273]
[  168.612624]  pci_pm_suspend+0x80/0x170
[  168.612629]  ? __pfx_pci_pm_suspend+0x10/0x10
[  168.612632]  dpm_run_callback+0x4a/0x150
[  168.612636]  device_suspend+0x14d/0x540
[  168.612639]  async_suspend+0x21/0x30
[  168.612641]  async_run_entry_fn+0x36/0x140
[  168.612646]  process_one_work+0x193/0x350
[  168.612649]  worker_thread+0x2d7/0x410
[  168.612652]  ? __pfx_worker_thread+0x10/0x10
[  168.612654]  kthread+0xfc/0x240
[  168.612656]  ? __pfx_kthread+0x10/0x10
[  168.612658]  ret_from_fork+0x34/0x50
[  168.612662]  ? __pfx_kthread+0x10/0x10
[  168.612663]  ret_from_fork_asm+0x1a/0x30
[  168.612668]  </TASK>
[  168.612669] ---[ end trace 0000000000000000 ]---
[  168.852463] amdgpu 0000:03:00.0: [drm:amdgpu_ring_test_helper [amdgpu]]
*ERROR* ring kiq_0.2.1.0 test failed (-110)
[  168.853329] [drm:gfx_v8_0_hw_fini [amdgpu]] *ERROR* KCQ disable failed
[  169.089064] amdgpu: cp is busy, skip halt cp
[  169.323986] amdgpu: rlc is busy, skip halt rlc
[  169.325086] ------------[ cut here ]------------
[  169.325087] WARNING: CPU: 0 PID: 13 at
drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:631 amdgpu_irq_put+0x46/0x70
[amdgpu]
[  169.325978] Modules linked in: ccm algif_aead qrtr crypto_null
des3_ede_x86_64 des_generic libdes algif_skcipher cmac md4 algif_hash
af_alg kvm_amd ccp wl(POE) kvm snd_hda_codec_realtek snd_hda_codec_generic
snd_hda_scodec_component irqbypass snd_hda_codec_hdmi snd_hda_intel
snd_intel_dspcfg snd_intel_sdw_acpi dell_pc ath10k_pci snd_ctl_led
snd_hda_codec snd_hda_core snd_hwdep ath10k_core snd_pcm snd_timer ath
ee1004 snd polyval_clmulni soundcore platform_profile mac80211 rtsx_usb_ms
libarc4 polyval_generic sp5100_tco dell_laptop btusb joydev hid_multitouch
memstick mousedev ghash_clmulni_intel btrtl btintel btbcm btmtk dell_wmi
dell_smm_hwmon bluetooth sparse_keymap sha1_ssse3 pcspkr i2c_piix4
i2c_hid_acpi dell_smbios dcdbas dell_wmi_descriptor dell_rbtn psmouse
wmi_bmof i2c_hid i2c_smbus fam15h_power k10temp cfg80211 mac_hid rfkill
pkcs8_key_parser dm_mod nfnetlink ip_tables x_tables overlay squashfs loop
isofs cdrom amdgpu amdxcp gpu_sched rtsx_usb_sdmmc
drm_panel_backlight_quirks drm_buddy mmc_core drm_exec
[  169.326045]  sha512_ssse3 drm_suballoc_helper sha256_ssse3 r8169
drm_ttm_helper aesni_intel realtek ttm crypto_simd cryptd i2c_algo_bit
mdio_devres uas serio_raw rtsx_usb drm_display_helper libphy usb_storage
cec video wmi
[  169.326062] CPU: 0 UID: 0 PID: 13 Comm: kworker/u16:1 Tainted: P
 W  OE       6.15.4-arch2-1 #1 PREEMPT(full)
 bf56011d6043294f437da1888a30a6d02e6dd116
[  169.326067] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_MOD=
ULE,
[E]=3DUNSIGNED_MODULE
[  169.326068] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7
01/29/2018
[  169.326070] Workqueue: async async_run_entry_fn
[  169.326076] RIP: 0010:amdgpu_irq_put+0x46/0x70 [amdgpu]
[  169.326963] Code: c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 d1 48 8d 04
88 8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9 5f c6 44 d5 e9 5a fd ff ff
<0f> 0b b8 ea ff ff ff e9 4e c6 44 d5 b8 ea ff ff ff e9 44 c6 44 d5
[  169.326965] RSP: 0018:ffffd0864011fd08 EFLAGS: 00010246
[  169.326967] RAX: ffff8c5700ba5a00 RBX: ffff8c5717d00000 RCX:
0000000000000000
[  169.326968] RDX: 0000000000000000 RSI: ffff8c5717d00c78 RDI:
ffff8c5717d00000
[  169.326969] RBP: ffff8c5717d00000 R08: 0000000000000000 R09:
00000000ffffefff
[  169.326971] R10: ffffffff97060f20 R11: ffffd0864011fad8 R12:
0000000000000001
[  169.326972] R13: ffff8c5717cfffe8 R14: 0000000000000000 R15:
ffff8c5716adbec0
[  169.326973] FS:  0000000000000000(0000) GS:ffff8c5a08f2f000(0000)
knlGS:0000000000000000
[  169.326974] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  169.326976] CR2: 00007fb941b67000 CR3: 000000010f832000 CR4:
00000000001506f0
[  169.326977] Call Trace:
[  169.326980]  <TASK>
[  169.326982]  gmc_v8_0_hw_fini+0x1f/0xa0 [amdgpu
fd2a24652620738c2ec44a27ca03228c2099e273]
[  169.327859]  amdgpu_ip_block_suspend+0x27/0x50 [amdgpu
fd2a24652620738c2ec44a27ca03228c2099e273]
[  169.328718]  amdgpu_device_ip_suspend_phase2+0x93/0x200 [amdgpu
fd2a24652620738c2ec44a27ca03228c2099e273]
[  169.329571]  amdgpu_device_suspend+0xc4/0x160 [amdgpu
fd2a24652620738c2ec44a27ca03228c2099e273]
[  169.330437]  pci_pm_suspend+0x80/0x170
[  169.330442]  ? __pfx_pci_pm_suspend+0x10/0x10
[  169.330445]  dpm_run_callback+0x4a/0x150
[  169.330449]  device_suspend+0x14d/0x540
[  169.330451]  async_suspend+0x21/0x30
[  169.330454]  async_run_entry_fn+0x36/0x140
[  169.330458]  process_one_work+0x193/0x350
[  169.330461]  worker_thread+0x2d7/0x410
[  169.330464]  ? __pfx_worker_thread+0x10/0x10
[  169.330466]  kthread+0xfc/0x240
[  169.330469]  ? __pfx_kthread+0x10/0x10
[  169.330470]  ret_from_fork+0x34/0x50
[  169.330474]  ? __pfx_kthread+0x10/0x10
[  169.330476]  ret_from_fork_asm+0x1a/0x30
[  169.330481]  </TASK>
[  169.330482] ---[ end trace 0000000000000000 ]---
[  169.331853] amdgpu 0000:03:00.0: amdgpu: PCI CONFIG reset
[  169.331892] ACPI: EC: interrupt blocked
[  169.356423] ACPI: PM: Preparing to enter system sleep state S3
[  169.683675] ACPI Warning: Time parameter 120 us > 100 us violating ACPI
spec, please fix the firmware. (20240827/exsystem-142)
[  169.684493] ACPI: EC: event blocked
[  169.684494] ACPI: EC: EC stopped
[  169.684499] ACPI: PM: Saving platform NVS memory
[  169.684597] Disabling non-boot CPUs ...
[  169.686850] smpboot: CPU 3 is now offline
[  169.689865] smpboot: CPU 2 is now offline
[  169.691960] smpboot: CPU 1 is now offline
[  169.693173] ACPI: PM: Low-level resume complete
[  169.693207] ACPI: EC: EC started
[  169.693209] ACPI: PM: Restoring platform NVS memory
[  169.693373] AMD-Vi: Virtual APIC enabled
[  169.693399] AMD-Vi: Virtual APIC enabled
[  169.693402] LVT offset 0 assigned for vector 0x400
[  169.693879] Enabling non-boot CPUs ...
[  169.694017] smpboot: Booting Node 0 Processor 1 APIC 0x11
[  169.697328] CPU1 is up
[  169.697443] smpboot: Booting Node 0 Processor 2 APIC 0x12
[  169.700804] CPU2 is up
[  169.700852] smpboot: Booting Node 0 Processor 3 APIC 0x13
[  169.704275] CPU3 is up
[  169.705527] ACPI: PM: Waking up from system sleep state S3
[  169.756540] ACPI: EC: interrupt unblocked
[  169.762681] ACPI: EC: event unblocked
[  169.762744] [drm] PCIE GART of 1024M enabled (table at
0x000000F400A00000).
[  169.762777] amdgpu: smu version 27.17.00
[  169.779692] [drm] PCIE GART of 256M enabled (table at
0x000000F4FFF80000).
[  169.796793] [drm] UVD initialized successfully.
[  169.886421] r8169 0000:02:00.0 enp2s0: Link is Down
[  169.997757] [drm] VCE initialized successfully.
[  170.005696] usb 1-2: reset high-speed USB device number 2 using xhci_hcd
[  170.015456] usb 2-1.2: reset full-speed USB device number 3 using
ehci-pci
[  170.098578] amdgpu 0000:03:00.0: [drm:amdgpu_ring_test_helper [amdgpu]]
*ERROR* ring comp_1.0.0 test failed (-110)
[  170.177583] usb 2-1.4: reset high-speed USB device number 4 using
ehci-pci
[  170.226387] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[  170.228682] sd 0:0:0:0: [sda] Starting disk
[  170.232144] ata1.00: configured for UDMA/133
[  170.351309] amdgpu 0000:03:00.0: [drm:amdgpu_ring_test_helper [amdgpu]]
*ERROR* ring comp_1.0.1 test failed (-110)
[  170.571090] amdgpu 0000:03:00.0: [drm:amdgpu_ring_test_helper [amdgpu]]
*ERROR* ring comp_1.0.2 test failed (-110)
[  170.805800] amdgpu 0000:03:00.0: [drm:amdgpu_ring_test_helper [amdgpu]]
*ERROR* ring comp_1.0.3 test failed (-110)
[  171.023340] amdgpu 0000:03:00.0: [drm:amdgpu_ring_test_helper [amdgpu]]
*ERROR* ring comp_1.0.4 test failed (-110)
[  171.240880] amdgpu 0000:03:00.0: [drm:amdgpu_ring_test_helper [amdgpu]]
*ERROR* ring comp_1.0.5 test failed (-110)
[  171.458377] amdgpu 0000:03:00.0: [drm:amdgpu_ring_test_helper [amdgpu]]
*ERROR* ring comp_1.0.6 test failed (-110)
[  171.675888] amdgpu 0000:03:00.0: [drm:amdgpu_ring_test_helper [amdgpu]]
*ERROR* ring comp_1.0.7 test failed (-110)
[  171.815833] [drm] UVD and UVD ENC initialized successfully.
[  171.926824] [drm] VCE initialized successfully.
[  171.933077] Bluetooth: hci0: using rampatch file:
qca/rampatch_usb_00000302.bin
[  171.947453] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware
rome 0x302 build 0x111
[  171.947605] OOM killer enabled.
[  171.947609] Restarting tasks ... done.
[  171.948631] random: crng reseeded on system resumption
[  171.954861] kauditd_printk_skb: 101 callbacks suppressed
[  171.954867] audit: type=3D1130 audit(1770274074.259:152): pid=3D1 uid=3D=
0
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-networkd-wait-onli=
ne
comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? ter=
minal=3D?
res=3Dfailed'
[  171.958630] audit: type=3D1334 audit(1770274074.263:153): prog-id=3D77
op=3DLOAD
[  171.959752] PM: suspend exit
[  171.975426] audit: type=3D1130 audit(1770274074.280:154): pid=3D1 uid=3D=
0
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-suspend comm=3D"sy=
stemd"
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Ds=
uccess'
[  171.975463] audit: type=3D1131 audit(1770274074.280:155): pid=3D1 uid=3D=
0
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-suspend comm=3D"sy=
stemd"
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Ds=
uccess'
[  171.996521] audit: type=3D1130 audit(1770274074.301:156): pid=3D1 uid=3D=
0
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-rfkill comm=3D"sys=
temd"
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Ds=
uccess'
[  172.318079] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
[  172.340918] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection
command is advertised, but not supported.
[  172.370988]  sdb: sdb1 sdb2
[  174.760490] audit: type=3D1130 audit(1770274077.065:157): pid=3D1 uid=3D=
0
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dreflector comm=3D"systemd"
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Df=
ailed'
[  174.771802] audit: type=3D1334 audit(1770274077.076:158): prog-id=3D77
op=3DUNLOAD
[  177.004176] audit: type=3D1131 audit(1770274079.308:159): pid=3D1 uid=3D=
0
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-rfkill comm=3D"sys=
temd"
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Ds=
uccess'
[  184.802183] audit: type=3D1334 audit(1770274087.106:160): prog-id=3D78
op=3DLOAD
[  185.038826] audit: type=3D1130 audit(1770274087.343:161): pid=3D1 uid=3D=
0
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dreflector comm=3D"systemd"
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Df=
ailed'
[  185.045739] audit: type=3D1334 audit(1770274087.350:162): prog-id=3D78
op=3DUNLOAD

--000000000000339502064a0d901c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, 4 Feb 2026 a=
t 16:46, Alex Deucher &lt;<a href=3D"mailto:alexdeucher@gmail.com" target=
=3D"_blank">alexdeucher@gmail.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">On Wed, Feb 4, 2026 at 3:10=E2=80=AFAM Tom=
 Psyborg &lt;<a href=3D"mailto:pozega.tomislav@gmail.com" target=3D"_blank"=
>pozega.tomislav@gmail.com</a>&gt; wrote:<br>&gt;<br>&gt; Hi<br>&gt;<br>&gt=
; I try live boot of ubuntu 26.04 snapshot 3 (6.18.0-9) on dell inspiron 55=
76 with RX460 dGPU, everything seems ok, until i try to put system to sleep=
:<br>&gt; (sleep/suspend worked fine on ubuntu 22.04 last time i checked an=
d it works fine in windows)<br><br>Can you bisect or at least narrow down w=
hen this broke?<br><br>Alex<br><br><br></blockquote><div><br></div><div>6.1=
4.0-27-generic (ubuntu mate 24.04) still good</div><div><br></div><div>6.15=
.4-arch2-1 driver crash<br></div><div><br></div><div><br></div><div>[ =C2=
=A0 =C2=A00.000000] Linux version 6.15.4-arch2-1 (linux@archlinux) (gcc (GC=
C) 15.1.1 20250425, GNU ld (GNU Binutils) 2.44.0) #1 SMP PREEMPT_DYNAMIC Fr=
i, 27 Jun 2025 16:35:07 +0000<br>[ =C2=A0 =C2=A00.000000] Command line: BOO=
T_IMAGE=3D/arch/boot/x86_64/vmlinuz-linux archisobasedir=3Darch archisosear=
chuuid=3D2025-07-01-17-34-06-00 initrd=3D/arch/boot/x86_64/initramfs-linux.=
img<br>[ =C2=A0 =C2=A00.000000] [Firmware Info]: CPU: Re-enabling disabled =
Topology Extensions Support.<br>[ =C2=A0 =C2=A00.000000] BIOS-provided phys=
ical RAM map:<br>[ =C2=A0 =C2=A00.000000] BIOS-e820: [mem 0x000000000000000=
0-0x000000000009d7ff] usable<br>[ =C2=A0 =C2=A00.000000] BIOS-e820: [mem 0x=
000000000009d800-0x000000000009ffff] reserved<br>[ =C2=A0 =C2=A00.000000] B=
IOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved<br>[ =C2=A0 =
=C2=A00.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000cc96efff] usab=
le<br>[ =C2=A0 =C2=A00.000000] BIOS-e820: [mem 0x00000000cc96f000-0x0000000=
0cd420fff] reserved<br>[ =C2=A0 =C2=A00.000000] BIOS-e820: [mem 0x00000000c=
d421000-0x00000000cd452fff] ACPI data<br>[ =C2=A0 =C2=A00.000000] BIOS-e820=
: [mem 0x00000000cd453000-0x00000000cd8e2fff] ACPI NVS<br>[ =C2=A0 =C2=A00.=
000000] BIOS-e820: [mem 0x00000000cd8e3000-0x00000000cdbe3fff] reserved<br>=
[ =C2=A0 =C2=A00.000000] BIOS-e820: [mem 0x00000000cdbe4000-0x00000000cefff=
fff] usable<br>[ =C2=A0 =C2=A00.000000] BIOS-e820: [mem 0x00000000cf000000-=
0x00000000cfffffff] reserved<br>[ =C2=A0 =C2=A00.000000] BIOS-e820: [mem 0x=
00000000f8000000-0x00000000fbffffff] reserved<br>[ =C2=A0 =C2=A00.000000] B=
IOS-e820: [mem 0x00000000fe200000-0x00000000fe200fff] reserved<br>[ =C2=A0 =
=C2=A00.000000] BIOS-e820: [mem 0x00000000fe600000-0x00000000fe6fffff] rese=
rved<br>[ =C2=A0 =C2=A00.000000] BIOS-e820: [mem 0x00000000feb80000-0x00000=
000fec01fff] reserved<br>[ =C2=A0 =C2=A00.000000] BIOS-e820: [mem 0x0000000=
0fec10000-0x00000000fec10fff] reserved<br>[ =C2=A0 =C2=A00.000000] BIOS-e82=
0: [mem 0x00000000fed00000-0x00000000fed00fff] reserved<br>[ =C2=A0 =C2=A00=
.000000] BIOS-e820: [mem 0x00000000fed40000-0x00000000fed44fff] reserved<br=
>[ =C2=A0 =C2=A00.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed8=
ffff] reserved<br>[ =C2=A0 =C2=A00.000000] BIOS-e820: [mem 0x00000000fedc00=
00-0x00000000fedc0fff] reserved<br>[ =C2=A0 =C2=A00.000000] BIOS-e820: [mem=
 0x00000000fedc2000-0x00000000fedc8fff] reserved<br>[ =C2=A0 =C2=A00.000000=
] BIOS-e820: [mem 0x00000000fee00000-0x00000000feefffff] reserved<br>[ =C2=
=A0 =C2=A00.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] =
reserved<br>[ =C2=A0 =C2=A00.000000] BIOS-e820: [mem 0x0000000100000000-0x0=
0000003aeffffff] usable<br>[ =C2=A0 =C2=A00.000000] BIOS-e820: [mem 0x00000=
003af000000-0x000000042effffff] reserved<br>[ =C2=A0 =C2=A00.000000] NX (Ex=
ecute Disable) protection: active<br>[ =C2=A0 =C2=A00.000000] APIC: Static =
calls initialized<br>[ =C2=A0 =C2=A00.000000] SMBIOS 3.0.0 present.<br>[ =
=C2=A0 =C2=A00.000000] DMI: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7 01/2=
9/2018<br>[ =C2=A0 =C2=A00.000000] DMI: Memory slots populated: 2/2<br>[ =
=C2=A0 =C2=A00.000000] tsc: Fast TSC calibration using PIT<br>[ =C2=A0 =C2=
=A00.000000] tsc: Detected 2999.703 MHz processor<br>[ =C2=A0 =C2=A00.00086=
9] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D&gt; reserved<br>[=
 =C2=A0 =C2=A00.000872] e820: remove [mem 0x000a0000-0x000fffff] usable<br>=
[ =C2=A0 =C2=A00.000883] last_pfn =3D 0x3af000 max_arch_pfn =3D 0x400000000=
<br>[ =C2=A0 =C2=A00.000892] total RAM covered: 3312M<br>[ =C2=A0 =C2=A00.0=
01089] Found optimal setting for mtrr clean up<br>[ =C2=A0 =C2=A00.001089] =
=C2=A0gran_size: 64K chunk_size: 32M num_reg: 4 =C2=A0 lose cover RAM: 0G<b=
r>[ =C2=A0 =C2=A00.001095] MTRR map: 6 entries (3 fixed + 3 variable; max 2=
0), built from 9 variable MTRRs<br>[ =C2=A0 =C2=A00.001097] x86/PAT: Config=
uration [0-7]: WB =C2=A0WC =C2=A0UC- UC =C2=A0WB =C2=A0WP =C2=A0UC- WT =C2=
=A0<br>[ =C2=A0 =C2=A00.001312] e820: update [mem 0xcf000000-0xffffffff] us=
able =3D=3D&gt; reserved<br>[ =C2=A0 =C2=A00.001322] last_pfn =3D 0xcf000 m=
ax_arch_pfn =3D 0x400000000<br>[ =C2=A0 =C2=A00.005489] found SMP MP-table =
at [mem 0x000fcbd0-0x000fcbdf]<br>[ =C2=A0 =C2=A00.005509] Using GB pages f=
or direct mapping<br>[ =C2=A0 =C2=A00.005830] RAMDISK: [mem 0x766a2000-0x7f=
ffffff]<br>[ =C2=A0 =C2=A00.006745] ACPI: Early table checksum verification=
 disabled<br>[ =C2=A0 =C2=A00.006749] ACPI: RSDP 0x00000000000F05B0 000024 =
(v02 DELL =C2=A0)<br>[ =C2=A0 =C2=A00.006753] ACPI: XSDT 0x00000000CD43C090=
 0000A4 (v01 DELL =C2=A0 QA09 =C2=A0 =C2=A0 01072009 AMI =C2=A000010013)<br=
>[ =C2=A0 =C2=A00.006760] ACPI: FACP 0x00000000CD445ED0 00010C (v05 DELL =
=C2=A0 QA09 =C2=A0 =C2=A0 01072009 AMI =C2=A000010013)<br>[ =C2=A0 =C2=A00.=
006765] ACPI BIOS Warning (bug): Optional FADT field Pm2ControlBlock has va=
lid Length but zero Address: 0x0000000000000000/0x1 (20240827/tbfadt-611)<b=
r>[ =C2=A0 =C2=A00.006769] ACPI: DSDT 0x00000000CD43C1C8 009D08 (v02 DELL =
=C2=A0 QA09 =C2=A0 =C2=A0 01072009 INTL 20120913)<br>[ =C2=A0 =C2=A00.00677=
3] ACPI: FACS 0x00000000CD8E1CC0 000040<br>[ =C2=A0 =C2=A00.006775] ACPI: A=
PIC 0x00000000CD445FE0 00007E (v03 DELL =C2=A0 QA09 =C2=A0 =C2=A0 01072009 =
AMI =C2=A000010013)<br>[ =C2=A0 =C2=A00.006778] ACPI: FPDT 0x00000000CD4460=
60 000044 (v01 DELL =C2=A0 QA09 =C2=A0 =C2=A0 01072009 AMI =C2=A000010013)<=
br>[ =C2=A0 =C2=A00.006781] ACPI: FIDT 0x00000000CD4460A8 00009C (v01 DELL =
=C2=A0 QA09 =C2=A0 =C2=A0 01072009 AMI =C2=A000010013)<br>[ =C2=A0 =C2=A00.=
006784] ACPI: MCFG 0x00000000CD446148 00003C (v01 DELL =C2=A0 QA09 =C2=A0 =
=C2=A0 01072009 MSFT 00010013)<br>[ =C2=A0 =C2=A00.006786] ACPI: BOOT 0x000=
00000CD446188 000028 (v01 DELL =C2=A0 QA09 =C2=A0 =C2=A0 01072009 AMI =C2=
=A000010013)<br>[ =C2=A0 =C2=A00.006789] ACPI: SLIC 0x00000000CD4461B0 0001=
76 (v01 DELL =C2=A0 QA09 =C2=A0 =C2=A0 01072009 AMI =C2=A000010013)<br>[ =
=C2=A0 =C2=A00.006791] ACPI: HPET 0x00000000CD446328 000038 (v01 DELL =C2=
=A0 QA09 =C2=A0 =C2=A0 01072009 AMI =C2=A000000005)<br>[ =C2=A0 =C2=A00.006=
794] ACPI: UEFI 0x00000000CD446360 000042 (v01 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 00000000 =C2=A0 =C2=A0 =C2=A000000000)<br>[ =C2=
=A0 =C2=A00.006796] ACPI: MSDM 0x00000000CD4463A8 000055 (v03 DELL =C2=A0 Q=
A09 =C2=A0 =C2=A0 01072009 AMI =C2=A000010013)<br>[ =C2=A0 =C2=A00.006799] =
ACPI: IVRS 0x00000000CD446400 0000D0 (v02 AMD =C2=A0 =C2=A0AGESA =C2=A0 =C2=
=A000000001 AMD =C2=A000000000)<br>[ =C2=A0 =C2=A00.006801] ACPI: SSDT 0x00=
000000CD4464D0 00888F (v02 AMD =C2=A0 =C2=A0AGESA =C2=A0 =C2=A000000002 MSF=
T 04000000)<br>[ =C2=A0 =C2=A00.006804] ACPI: CRAT 0x00000000CD44ED60 0005A=
0 (v01 AMD =C2=A0 =C2=A0AGESA =C2=A0 =C2=A000000001 AMD =C2=A000000001)<br>=
[ =C2=A0 =C2=A00.006807] ACPI: SSDT 0x00000000CD44F300 001587 (v01 AMD =C2=
=A0 =C2=A0CPMDFIGP 00000001 INTL 20120913)<br>[ =C2=A0 =C2=A00.006809] ACPI=
: SSDT 0x00000000CD450888 000A71 (v01 AMD =C2=A0 =C2=A0CPMDFDGP 00000001 IN=
TL 20120913)<br>[ =C2=A0 =C2=A00.006812] ACPI: SSDT 0x00000000CD451300 0016=
5E (v01 AMD =C2=A0 =C2=A0CPMCMN =C2=A0 00000001 INTL 20120913)<br>[ =C2=A0 =
=C2=A00.006814] ACPI: Reserving FACP table memory at [mem 0xcd445ed0-0xcd44=
5fdb]<br>[ =C2=A0 =C2=A00.006816] ACPI: Reserving DSDT table memory at [mem=
 0xcd43c1c8-0xcd445ecf]<br>[ =C2=A0 =C2=A00.006817] ACPI: Reserving FACS ta=
ble memory at [mem 0xcd8e1cc0-0xcd8e1cff]<br>[ =C2=A0 =C2=A00.006818] ACPI:=
 Reserving APIC table memory at [mem 0xcd445fe0-0xcd44605d]<br>[ =C2=A0 =C2=
=A00.006819] ACPI: Reserving FPDT table memory at [mem 0xcd446060-0xcd4460a=
3]<br>[ =C2=A0 =C2=A00.006820] ACPI: Reserving FIDT table memory at [mem 0x=
cd4460a8-0xcd446143]<br>[ =C2=A0 =C2=A00.006820] ACPI: Reserving MCFG table=
 memory at [mem 0xcd446148-0xcd446183]<br>[ =C2=A0 =C2=A00.006821] ACPI: Re=
serving BOOT table memory at [mem 0xcd446188-0xcd4461af]<br>[ =C2=A0 =C2=A0=
0.006822] ACPI: Reserving SLIC table memory at [mem 0xcd4461b0-0xcd446325]<=
br>[ =C2=A0 =C2=A00.006823] ACPI: Reserving HPET table memory at [mem 0xcd4=
46328-0xcd44635f]<br>[ =C2=A0 =C2=A00.006824] ACPI: Reserving UEFI table me=
mory at [mem 0xcd446360-0xcd4463a1]<br>[ =C2=A0 =C2=A00.006825] ACPI: Reser=
ving MSDM table memory at [mem 0xcd4463a8-0xcd4463fc]<br>[ =C2=A0 =C2=A00.0=
06826] ACPI: Reserving IVRS table memory at [mem 0xcd446400-0xcd4464cf]<br>=
[ =C2=A0 =C2=A00.006827] ACPI: Reserving SSDT table memory at [mem 0xcd4464=
d0-0xcd44ed5e]<br>[ =C2=A0 =C2=A00.006828] ACPI: Reserving CRAT table memor=
y at [mem 0xcd44ed60-0xcd44f2ff]<br>[ =C2=A0 =C2=A00.006828] ACPI: Reservin=
g SSDT table memory at [mem 0xcd44f300-0xcd450886]<br>[ =C2=A0 =C2=A00.0068=
29] ACPI: Reserving SSDT table memory at [mem 0xcd450888-0xcd4512f8]<br>[ =
=C2=A0 =C2=A00.006830] ACPI: Reserving SSDT table memory at [mem 0xcd451300=
-0xcd45295d]<br>[ =C2=A0 =C2=A00.006900] No NUMA configuration found<br>[ =
=C2=A0 =C2=A00.006901] Faking a node at [mem 0x0000000000000000-0x00000003a=
effffff]<br>[ =C2=A0 =C2=A00.006910] NODE_DATA(0) allocated [mem 0x3aefd528=
0-0x3aeffffff]<br>[ =C2=A0 =C2=A00.007154] Zone ranges:<br>[ =C2=A0 =C2=A00=
.007155] =C2=A0 DMA =C2=A0 =C2=A0 =C2=A0[mem 0x0000000000001000-0x000000000=
0ffffff]<br>[ =C2=A0 =C2=A00.007158] =C2=A0 DMA32 =C2=A0 =C2=A0[mem 0x00000=
00001000000-0x00000000ffffffff]<br>[ =C2=A0 =C2=A00.007159] =C2=A0 Normal =
=C2=A0 [mem 0x0000000100000000-0x00000003aeffffff]<br>[ =C2=A0 =C2=A00.0071=
60] =C2=A0 Device =C2=A0 empty<br>[ =C2=A0 =C2=A00.007161] Movable zone sta=
rt for each node<br>[ =C2=A0 =C2=A00.007163] Early memory node ranges<br>[ =
=C2=A0 =C2=A00.007163] =C2=A0 node =C2=A0 0: [mem 0x0000000000001000-0x0000=
00000009cfff]<br>[ =C2=A0 =C2=A00.007165] =C2=A0 node =C2=A0 0: [mem 0x0000=
000000100000-0x00000000cc96efff]<br>[ =C2=A0 =C2=A00.007166] =C2=A0 node =
=C2=A0 0: [mem 0x00000000cdbe4000-0x00000000ceffffff]<br>[ =C2=A0 =C2=A00.0=
07167] =C2=A0 node =C2=A0 0: [mem 0x0000000100000000-0x00000003aeffffff]<br=
>[ =C2=A0 =C2=A00.007169] Initmem setup node 0 [mem 0x0000000000001000-0x00=
000003aeffffff]<br>[ =C2=A0 =C2=A00.007175] On node 0, zone DMA: 1 pages in=
 unavailable ranges<br>[ =C2=A0 =C2=A00.007204] On node 0, zone DMA: 99 pag=
es in unavailable ranges<br>[ =C2=A0 =C2=A00.016295] On node 0, zone DMA32:=
 4725 pages in unavailable ranges<br>[ =C2=A0 =C2=A00.046733] On node 0, zo=
ne Normal: 4096 pages in unavailable ranges<br>[ =C2=A0 =C2=A00.046780] On =
node 0, zone Normal: 4096 pages in unavailable ranges<br>[ =C2=A0 =C2=A00.0=
46889] ACPI: PM-Timer IO Port: 0x808<br>[ =C2=A0 =C2=A00.046897] ACPI: LAPI=
C_NMI (acpi_id[0xff] high edge lint[0x1])<br>[ =C2=A0 =C2=A00.046907] IOAPI=
C[0]: apic_id 0, version 33, address 0xfec00000, GSI 0-23<br>[ =C2=A0 =C2=
=A00.046910] IOAPIC[1]: apic_id 1, version 33, address 0xfec01000, GSI 24-5=
5<br>[ =C2=A0 =C2=A00.046913] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq=
 2 dfl dfl)<br>[ =C2=A0 =C2=A00.046915] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 =
global_irq 9 low level)<br>[ =C2=A0 =C2=A00.046919] ACPI: Using ACPI (MADT)=
 for SMP configuration information<br>[ =C2=A0 =C2=A00.046920] ACPI: HPET i=
d: 0x10228201 base: 0xfed00000<br>[ =C2=A0 =C2=A00.046934] CPU topo: Max. l=
ogical packages: =C2=A0 1<br>[ =C2=A0 =C2=A00.046935] CPU topo: Max. logica=
l dies: =C2=A0 =C2=A0 =C2=A0 1<br>[ =C2=A0 =C2=A00.046936] CPU topo: Max. d=
ies per package: =C2=A0 1<br>[ =C2=A0 =C2=A00.046947] CPU topo: Max. thread=
s per core: =C2=A0 1<br>[ =C2=A0 =C2=A00.046948] CPU topo: Num. cores per p=
ackage: =C2=A0 =C2=A0 4<br>[ =C2=A0 =C2=A00.046948] CPU topo: Num. threads =
per package: =C2=A0 4<br>[ =C2=A0 =C2=A00.046949] CPU topo: Allowing 4 pres=
ent CPUs plus 0 hotplug CPUs<br>[ =C2=A0 =C2=A00.046968] PM: hibernation: R=
egistered nosave memory: [mem 0x00000000-0x00000fff]<br>[ =C2=A0 =C2=A00.04=
6970] PM: hibernation: Registered nosave memory: [mem 0x0009d000-0x000fffff=
]<br>[ =C2=A0 =C2=A00.046971] PM: hibernation: Registered nosave memory: [m=
em 0xcc96f000-0xcdbe3fff]<br>[ =C2=A0 =C2=A00.046973] PM: hibernation: Regi=
stered nosave memory: [mem 0xcf000000-0xffffffff]<br>[ =C2=A0 =C2=A00.04697=
5] [mem 0xd0000000-0xf7ffffff] available for PCI devices<br>[ =C2=A0 =C2=A0=
0.046976] Booting paravirtualized kernel on bare hardware<br>[ =C2=A0 =C2=
=A00.046979] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xf=
fffffff, max_idle_ns: 1910969940391419 ns<br>[ =C2=A0 =C2=A00.052230] setup=
_percpu: NR_CPUS:8192 nr_cpumask_bits:4 nr_cpu_ids:4 nr_node_ids:1<br>[ =C2=
=A0 =C2=A00.052722] percpu: Embedded 62 pages/cpu s217088 r8192 d28672 u524=
288<br>[ =C2=A0 =C2=A00.052728] pcpu-alloc: s217088 r8192 d28672 u524288 al=
loc=3D1*2097152<br>[ =C2=A0 =C2=A00.052731] pcpu-alloc: [0] 0 1 2 3<br>[ =
=C2=A0 =C2=A00.052749] Kernel command line: BOOT_IMAGE=3D/arch/boot/x86_64/=
vmlinuz-linux archisobasedir=3Darch archisosearchuuid=3D2025-07-01-17-34-06=
-00 initrd=3D/arch/boot/x86_64/initramfs-linux.img<br>[ =C2=A0 =C2=A00.0528=
36] Unknown kernel command line parameters &quot;BOOT_IMAGE=3D/arch/boot/x8=
6_64/vmlinuz-linux archisobasedir=3Darch archisosearchuuid=3D2025-07-01-17-=
34-06-00&quot;, will be passed to user space.<br>[ =C2=A0 =C2=A00.052859] r=
andom: crng init done<br>[ =C2=A0 =C2=A00.052860] printk: log buffer data +=
 meta data: 131072 + 458752 =3D 589824 bytes<br>[ =C2=A0 =C2=A00.055642] De=
ntry cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)<=
br>[ =C2=A0 =C2=A00.057050] Inode-cache hash table entries: 1048576 (order:=
 11, 8388608 bytes, linear)<br>[ =C2=A0 =C2=A00.057128] software IO TLB: ar=
ea num 4.<br>[ =C2=A0 =C2=A00.079753] Fallback order for Node 0: 0<br>[ =C2=
=A0 =C2=A00.079758] Built 1 zonelists, mobility grouping on.=C2=A0 Total pa=
ges: 3656999<br>[ =C2=A0 =C2=A00.079760] Policy zone: Normal<br>[ =C2=A0 =
=C2=A00.080175] mem auto-init: stack:all(zero), heap alloc:on, heap free:of=
f<br>[ =C2=A0 =C2=A00.131696] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=
=3D0, CPUs=3D4, Nodes=3D1<br>[ =C2=A0 =C2=A00.143929] ftrace: allocating 55=
579 entries in 220 pages<br>[ =C2=A0 =C2=A00.143933] ftrace: allocated 220 =
pages with 5 groups<br>[ =C2=A0 =C2=A00.144049] Dynamic Preempt: full<br>[ =
=C2=A0 =C2=A00.144094] rcu: Preemptible hierarchical RCU implementation.<br=
>[ =C2=A0 =C2=A00.144096] rcu: RCU restricting CPUs from NR_CPUS=3D8192 to =
nr_cpu_ids=3D4.<br>[ =C2=A0 =C2=A00.144097] rcu: RCU priority boosting: pri=
ority 1 delay 500 ms.<br>[ =C2=A0 =C2=A00.144098] Trampoline variant of Tas=
ks RCU enabled.<br>[ =C2=A0 =C2=A00.144099] Rude variant of Tasks RCU enabl=
ed.<br>[ =C2=A0 =C2=A00.144099] Tracing variant of Tasks RCU enabled.<br>[ =
=C2=A0 =C2=A00.144100] rcu: RCU calculated value of scheduler-enlistment de=
lay is 100 jiffies.<br>[ =C2=A0 =C2=A00.144101] rcu: Adjusting geometry for=
 rcu_fanout_leaf=3D16, nr_cpu_ids=3D4<br>[ =C2=A0 =C2=A00.144108] RCU Tasks=
: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=3D1 rcu_task_cpu_ids=
=3D4.<br>[ =C2=A0 =C2=A00.144111] RCU Tasks Rude: Setting shift to 2 and li=
m to 1 rcu_task_cb_adjust=3D1 rcu_task_cpu_ids=3D4.<br>[ =C2=A0 =C2=A00.144=
112] RCU Tasks Trace: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=3D=
1 rcu_task_cpu_ids=3D4.<br>[ =C2=A0 =C2=A00.150599] NR_IRQS: 524544, nr_irq=
s: 1000, preallocated irqs: 16<br>[ =C2=A0 =C2=A00.150819] rcu: srcu_init: =
Setting srcu_struct sizes based on contention.<br>[ =C2=A0 =C2=A00.150952] =
kfence: initialized - using 2097152 bytes for 255 objects at 0x(____ptrval_=
___)-0x(____ptrval____)<br>[ =C2=A0 =C2=A00.153200] Console: colour VGA+ 80=
x25<br>[ =C2=A0 =C2=A00.153204] printk: legacy console [tty0] enabled<br>[ =
=C2=A0 =C2=A00.153258] ACPI: Core revision 20240827<br>[ =C2=A0 =C2=A00.153=
361] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_n=
s: 133484873504 ns<br>[ =C2=A0 =C2=A00.153377] APIC: Switch to symmetric I/=
O mode setup<br>[ =C2=A0 =C2=A00.154200] AMD-Vi: Using global IVHD EFR:0x77=
ef22294ada, EFR2:0x0<br>[ =C2=A0 =C2=A00.155173] ..TIMER: vector=3D0x30 api=
c1=3D0 pin1=3D2 apic2=3D-1 pin2=3D-1<br>[ =C2=A0 =C2=A00.159378] clocksourc=
e: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x2b3d2cddc5c, max_idle_=
ns: 440795280308 ns<br>[ =C2=A0 =C2=A00.159388] Calibrating delay loop (ski=
pped), value calculated using timer frequency.. 5999.40 BogoMIPS (lpj=3D299=
9703)<br>[ =C2=A0 =C2=A00.159407] BIOS may not properly restore RDRAND afte=
r suspend, hiding RDRAND via CPUID. Use rdrand=3Dforce to reenable.<br>[ =
=C2=A0 =C2=A00.159439] LVT offset 1 assigned for vector 0xf9<br>[ =C2=A0 =
=C2=A00.159448] Last level iTLB entries: 4KB 512, 2MB 1024, 4MB 512<br>[ =
=C2=A0 =C2=A00.159449] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 512=
, 1GB 0<br>[ =C2=A0 =C2=A00.159456] Spectre V1 : Mitigation: usercopy/swapg=
s barriers and __user pointer sanitization<br>[ =C2=A0 =C2=A00.159458] Spec=
tre V2 : Mitigation: Retpolines<br>[ =C2=A0 =C2=A00.159459] Spectre V2 : Sp=
ectre v2 / SpectreRSB: Filling RSB on context switch and VMEXIT<br>[ =C2=A0=
 =C2=A00.159460] Spectre V2 : Enabling Speculation Barrier for firmware cal=
ls<br>[ =C2=A0 =C2=A00.159461] RETBleed: Mitigation: untrained return thunk=
<br>[ =C2=A0 =C2=A00.159464] Spectre V2 : mitigation: Enabling conditional =
Indirect Branch Prediction Barrier<br>[ =C2=A0 =C2=A00.159465] Speculative =
Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl<br>[ =
=C2=A0 =C2=A00.159471] x86/fpu: Supporting XSAVE feature 0x001: &#39;x87 fl=
oating point registers&#39;<br>[ =C2=A0 =C2=A00.159473] x86/fpu: Supporting=
 XSAVE feature 0x002: &#39;SSE registers&#39;<br>[ =C2=A0 =C2=A00.159474] x=
86/fpu: Supporting XSAVE feature 0x004: &#39;AVX registers&#39;<br>[ =C2=A0=
 =C2=A00.159476] x86/fpu: xstate_offset[2]: =C2=A0576, xstate_sizes[2]: =C2=
=A0256<br>[ =C2=A0 =C2=A00.159477] x86/fpu: Enabled xstate features 0x7, co=
ntext size is 832 bytes, using &#39;standard&#39; format.<br>[ =C2=A0 =C2=
=A00.189276] Freeing SMP alternatives memory: 52K<br>[ =C2=A0 =C2=A00.18928=
5] pid_max: default: 32768 minimum: 301<br>[ =C2=A0 =C2=A00.189333] LSM: in=
itializing lsm=3Dcapability,landlock,lockdown,yama,bpf<br>[ =C2=A0 =C2=A00.=
189424] landlock: Up and running.<br>[ =C2=A0 =C2=A00.189427] Yama: becomin=
g mindful.<br>[ =C2=A0 =C2=A00.189659] LSM support for eBPF active<br>[ =C2=
=A0 =C2=A00.189717] Mount-cache hash table entries: 32768 (order: 6, 262144=
 bytes, linear)<br>[ =C2=A0 =C2=A00.189751] Mountpoint-cache hash table ent=
ries: 32768 (order: 6, 262144 bytes, linear)<br>[ =C2=A0 =C2=A00.292615] sm=
pboot: CPU0: AMD FX-9830P RADEON R7, 12 COMPUTE CORES 4C+8G (family: 0x15, =
model: 0x65, stepping: 0x1)<br>[ =C2=A0 =C2=A00.292888] Performance Events:=
 Fam15h core perfctr, AMD PMU driver.<br>[ =C2=A0 =C2=A00.292895] ... versi=
on: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00<br>[ =C2=A0 =
=C2=A00.292896] ... bit width: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A048<br>[ =C2=A0 =C2=A00.292897] ... generic registers: =C2=A0 =C2=A0 =
=C2=A06<br>[ =C2=A0 =C2=A00.292898] ... value mask: =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 0000ffffffffffff<br>[ =C2=A0 =C2=A00.292899] ... max p=
eriod: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 00007fffffffffff<br>[ =C2=
=A0 =C2=A00.292900] ... fixed-purpose events: =C2=A0 0<br>[ =C2=A0 =C2=A00.=
292901] ... event mask: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 000000000=
000003f<br>[ =C2=A0 =C2=A00.293018] signal: max sigframe size: 1776<br>[ =
=C2=A0 =C2=A00.293061] rcu: Hierarchical SRCU implementation.<br>[ =C2=A0 =
=C2=A00.293063] rcu: Max phase no-delay instances is 400.<br>[ =C2=A0 =C2=
=A00.293154] Timer migration: 1 hierarchy levels; 8 children per group; 1 c=
rossnode level<br>[ =C2=A0 =C2=A00.299483] MCE: In-kernel MCE decoding enab=
led.<br>[ =C2=A0 =C2=A00.299592] NMI watchdog: Enabled. Permanently consume=
s one hw-PMU counter.<br>[ =C2=A0 =C2=A00.299662] smp: Bringing up secondar=
y CPUs ...<br>[ =C2=A0 =C2=A00.299804] smpboot: x86: Booting SMP configurat=
ion:<br>[ =C2=A0 =C2=A00.299806] .... node =C2=A0#0, CPUs: =C2=A0 =C2=A0 =
=C2=A0#1 #2 #3<br>[ =C2=A0 =C2=A00.304460] smp: Brought up 1 node, 4 CPUs<b=
r>[ =C2=A0 =C2=A00.304477] smpboot: Total of 4 processors activated (23997.=
62 BogoMIPS)<br>[ =C2=A0 =C2=A00.305320] Memory: 14075928K/14627996K availa=
ble (19692K kernel code, 2940K rwdata, 16520K rodata, 4632K init, 5036K bss=
, 538880K reserved, 0K cma-reserved)<br>[ =C2=A0 =C2=A00.306469] devtmpfs: =
initialized<br>[ =C2=A0 =C2=A00.306500] x86/mm: Memory block size: 128MB<br=
>[ =C2=A0 =C2=A00.308422] ACPI: PM: Registering ACPI NVS region [mem 0xcd45=
3000-0xcd8e2fff] (4784128 bytes)<br>[ =C2=A0 =C2=A00.308547] clocksource: j=
iffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275=
000 ns<br>[ =C2=A0 =C2=A00.308547] posixtimers hash table entries: 2048 (or=
der: 3, 32768 bytes, linear)<br>[ =C2=A0 =C2=A00.308547] futex hash table e=
ntries: 1024 (order: 4, 65536 bytes, linear)<br>[ =C2=A0 =C2=A00.308607] pi=
nctrl core: initialized pinctrl subsystem<br>[ =C2=A0 =C2=A00.309425] PM: R=
TC time: 06:54:35, date: 2026-02-05<br>[ =C2=A0 =C2=A00.310701] NET: Regist=
ered PF_NETLINK/PF_ROUTE protocol family<br>[ =C2=A0 =C2=A00.311317] DMA: p=
reallocated 2048 KiB GFP_KERNEL pool for atomic allocations<br>[ =C2=A0 =C2=
=A00.311799] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA pool for atomic =
allocations<br>[ =C2=A0 =C2=A00.312191] DMA: preallocated 2048 KiB GFP_KERN=
EL|GFP_DMA32 pool for atomic allocations<br>[ =C2=A0 =C2=A00.312213] audit:=
 initializing netlink subsys (disabled)<br>[ =C2=A0 =C2=A00.312417] audit: =
type=3D2000 audit(1770274474.159:1): state=3Dinitialized audit_enabled=3D0 =
res=3D1<br>[ =C2=A0 =C2=A00.312554] thermal_sys: Registered thermal governo=
r &#39;fair_share&#39;<br>[ =C2=A0 =C2=A00.312558] thermal_sys: Registered =
thermal governor &#39;bang_bang&#39;<br>[ =C2=A0 =C2=A00.312560] thermal_sy=
s: Registered thermal governor &#39;step_wise&#39;<br>[ =C2=A0 =C2=A00.3125=
61] thermal_sys: Registered thermal governor &#39;user_space&#39;<br>[ =C2=
=A0 =C2=A00.312562] thermal_sys: Registered thermal governor &#39;power_all=
ocator&#39;<br>[ =C2=A0 =C2=A00.312571] cpuidle: using governor ladder<br>[=
 =C2=A0 =C2=A00.312571] cpuidle: using governor menu<br>[ =C2=A0 =C2=A00.31=
2571] Simple Boot Flag at 0x47 set to 0x1<br>[ =C2=A0 =C2=A00.312598] ACPI =
FADT declares the system doesn&#39;t support PCIe ASPM, so disable it<br>[ =
=C2=A0 =C2=A00.312600] acpiphp: ACPI Hot Plug PCI Controller Driver version=
: 0.5<br>[ =C2=A0 =C2=A00.312725] PCI: ECAM [mem 0xf8000000-0xfbffffff] (ba=
se 0xf8000000) for domain 0000 [bus 00-3f]<br>[ =C2=A0 =C2=A00.312742] PCI:=
 Using configuration type 1 for base access<br>[ =C2=A0 =C2=A00.313465] kpr=
obes: kprobe jump-optimization is enabled. All kprobes are optimized if pos=
sible.<br>[ =C2=A0 =C2=A00.313548] HugeTLB: allocation took 0ms with hugepa=
ge_allocation_threads=3D1<br>[ =C2=A0 =C2=A00.313548] HugeTLB: registered 1=
.00 GiB page size, pre-allocated 0 pages<br>[ =C2=A0 =C2=A00.313548] HugeTL=
B: 16380 KiB vmemmap can be freed for a 1.00 GiB page<br>[ =C2=A0 =C2=A00.3=
13548] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages<br>[ =
=C2=A0 =C2=A00.313548] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB =
page<br>[ =C2=A0 =C2=A00.314566] raid6: skipped pq benchmark and selected a=
vx2x4<br>[ =C2=A0 =C2=A00.314566] raid6: using avx2x2 recovery algorithm<br=
>[ =C2=A0 =C2=A00.314566] ACPI: Added _OSI(Module Device)<br>[ =C2=A0 =C2=
=A00.314566] ACPI: Added _OSI(Processor Device)<br>[ =C2=A0 =C2=A00.314566]=
 ACPI: Added _OSI(Processor Aggregator Device)<br>[ =C2=A0 =C2=A00.328355] =
ACPI: 5 ACPI AML tables successfully acquired and loaded<br>[ =C2=A0 =C2=A0=
0.334670] ACPI: EC: EC started<br>[ =C2=A0 =C2=A00.334675] ACPI: EC: interr=
upt blocked<br>[ =C2=A0 =C2=A00.336252] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_D=
ATA=3D0x62<br>[ =C2=A0 =C2=A00.336255] ACPI: \_SB_.PCI0.SBRG.EC__: Boot DSD=
T EC used to handle transactions<br>[ =C2=A0 =C2=A00.336258] ACPI: Interpre=
ter enabled<br>[ =C2=A0 =C2=A00.336282] ACPI: PM: (supports S0 S3 S4 S5)<br=
>[ =C2=A0 =C2=A00.336284] ACPI: Using IOAPIC for interrupt routing<br>[ =C2=
=A0 =C2=A00.337072] PCI: Using host bridge windows from ACPI; if necessary,=
 use &quot;pci=3Dnocrs&quot; and report a bug<br>[ =C2=A0 =C2=A00.337074] P=
CI: Using E820 reservations for host bridge windows<br>[ =C2=A0 =C2=A00.337=
348] ACPI: Enabled 3 GPEs in block 00 to 1F<br>[ =C2=A0 =C2=A00.340650] ACP=
I: \_SB_.P0ST: New power resource<br>[ =C2=A0 =C2=A00.340687] ACPI: \_SB_.P=
3ST: New power resource<br>[ =C2=A0 =C2=A00.341140] ACPI: \_SB_.P0U2: New p=
ower resource<br>[ =C2=A0 =C2=A00.341175] ACPI: \_SB_.P3U2: New power resou=
rce<br>[ =C2=A0 =C2=A00.341532] ACPI: \_SB_.P0U3: New power resource<br>[ =
=C2=A0 =C2=A00.341562] ACPI: \_SB_.P3U3: New power resource<br>[ =C2=A0 =C2=
=A00.342546] ACPI: \_SB_.P0SD: New power resource<br>[ =C2=A0 =C2=A00.34257=
2] ACPI: \_SB_.P3SD: New power resource<br>[ =C2=A0 =C2=A00.365088] ACPI: P=
CI Root Bridge [PCI0] (domain 0000 [bus 00-ff])<br>[ =C2=A0 =C2=A00.365100]=
 acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments M=
SI EDR HPX-Type3]<br>[ =C2=A0 =C2=A00.365193] acpi PNP0A08:00: _OSC: platfo=
rm does not support [SHPCHotplug LTR DPC]<br>[ =C2=A0 =C2=A00.365342] acpi =
PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]<br>[=
 =C2=A0 =C2=A00.365344] acpi PNP0A08:00: FADT indicates ASPM is unsupported=
, using BIOS configuration<br>[ =C2=A0 =C2=A00.365357] acpi PNP0A08:00: [Fi=
rmware Info]: ECAM [mem 0xf8000000-0xfbffffff] for domain 0000 [bus 00-3f] =
only partially covers this bridge<br>[ =C2=A0 =C2=A00.365866] PCI host brid=
ge to bus 0000:00<br>[ =C2=A0 =C2=A00.365870] pci_bus 0000:00: root bus res=
ource [io =C2=A00x0000-0x03af window]<br>[ =C2=A0 =C2=A00.365872] pci_bus 0=
000:00: root bus resource [io =C2=A00x03e0-0x0cf7 window]<br>[ =C2=A0 =C2=
=A00.365874] pci_bus 0000:00: root bus resource [io =C2=A00x03b0-0x03df win=
dow]<br>[ =C2=A0 =C2=A00.365875] pci_bus 0000:00: root bus resource [io =C2=
=A00x0d00-0xffff window]<br>[ =C2=A0 =C2=A00.365877] pci_bus 0000:00: root =
bus resource [mem 0x000a0000-0x000dffff window]<br>[ =C2=A0 =C2=A00.365879]=
 pci_bus 0000:00: root bus resource [mem 0xd0000000-0xfed3ffff window]<br>[=
 =C2=A0 =C2=A00.365881] pci_bus 0000:00: root bus resource [mem 0xfedca000-=
0xffffffff window]<br>[ =C2=A0 =C2=A00.365882] pci_bus 0000:00: root bus re=
source [mem 0x47f000000-0xfffffffff window]<br>[ =C2=A0 =C2=A00.365884] pci=
_bus 0000:00: root bus resource [bus 00-ff]<br>[ =C2=A0 =C2=A00.365954] pci=
 0000:00:00.0: [1022:1576] type 00 class 0x060000 conventional PCI endpoint=
<br>[ =C2=A0 =C2=A00.366080] pci 0000:00:00.2: [1022:1577] type 00 class 0x=
080600 conventional PCI endpoint<br>[ =C2=A0 =C2=A00.366194] pci 0000:00:01=
.0: [1002:9874] type 00 class 0x030000 PCIe Root Complex Integrated Endpoin=
t<br>[ =C2=A0 =C2=A00.366222] pci 0000:00:01.0: BAR 0 [mem 0xd0000000-0xdff=
fffff 64bit pref]<br>[ =C2=A0 =C2=A00.366225] pci 0000:00:01.0: BAR 2 [mem =
0xf0800000-0xf0ffffff 64bit pref]<br>[ =C2=A0 =C2=A00.366227] pci 0000:00:0=
1.0: BAR 4 [io =C2=A00xf000-0xf0ff]<br>[ =C2=A0 =C2=A00.366230] pci 0000:00=
:01.0: BAR 5 [mem 0xfea00000-0xfea3ffff]<br>[ =C2=A0 =C2=A00.366232] pci 00=
00:00:01.0: ROM [mem 0xfea40000-0xfea5ffff pref]<br>[ =C2=A0 =C2=A00.366237=
] pci 0000:00:01.0: enabling Extended Tags<br>[ =C2=A0 =C2=A00.366251] pci =
0000:00:01.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]=
<br>[ =C2=A0 =C2=A00.366284] pci 0000:00:01.0: supports D1 D2<br>[ =C2=A0 =
=C2=A00.366285] pci 0000:00:01.0: PME# supported from D1 D2 D3hot<br>[ =C2=
=A0 =C2=A00.366387] pci 0000:00:01.1: [1002:9840] type 00 class 0x040300 PC=
Ie Root Complex Integrated Endpoint<br>[ =C2=A0 =C2=A00.366415] pci 0000:00=
:01.1: BAR 0 [mem 0xfea64000-0xfea67fff 64bit]<br>[ =C2=A0 =C2=A00.366423] =
pci 0000:00:01.1: enabling Extended Tags<br>[ =C2=A0 =C2=A00.366455] pci 00=
00:00:01.1: supports D1 D2<br>[ =C2=A0 =C2=A00.366510] pci 0000:00:02.0: [1=
022:157b] type 00 class 0x060000 conventional PCI endpoint<br>[ =C2=A0 =C2=
=A00.366583] pci 0000:00:02.2: [1022:157c] type 01 class 0x060400 PCIe Root=
 Port<br>[ =C2=A0 =C2=A00.366603] pci 0000:00:02.2: PCI bridge to [bus 01]<=
br>[ =C2=A0 =C2=A00.366610] pci 0000:00:02.2: =C2=A0 bridge window [mem 0xf=
e400000-0xfe5fffff]<br>[ =C2=A0 =C2=A00.366699] pci 0000:00:02.2: enabling =
Extended Tags<br>[ =C2=A0 =C2=A00.366756] pci 0000:00:02.2: PME# supported =
from D0 D3hot D3cold<br>[ =C2=A0 =C2=A00.366783] pci 0000:00:02.3: [1022:15=
7c] type 01 class 0x060400 PCIe Root Port<br>[ =C2=A0 =C2=A00.366783] pci 0=
000:00:02.3: PCI bridge to [bus 02]<br>[ =C2=A0 =C2=A00.366783] pci 0000:00=
:02.3: =C2=A0 bridge window [io =C2=A00xe000-0xefff]<br>[ =C2=A0 =C2=A00.36=
6783] pci 0000:00:02.3: =C2=A0 bridge window [mem 0xfe900000-0xfe9fffff]<br=
>[ =C2=A0 =C2=A00.366783] pci 0000:00:02.3: enabling Extended Tags<br>[ =C2=
=A0 =C2=A00.366783] pci 0000:00:02.3: PME# supported from D0 D3hot D3cold<b=
r>[ =C2=A0 =C2=A00.366783] pci 0000:00:03.0: [1022:157b] type 00 class 0x06=
0000 conventional PCI endpoint<br>[ =C2=A0 =C2=A00.366849] pci 0000:00:03.1=
: [1022:157c] type 01 class 0x060400 PCIe Root Port<br>[ =C2=A0 =C2=A00.366=
868] pci 0000:00:03.1: PCI bridge to [bus 03]<br>[ =C2=A0 =C2=A00.366873] p=
ci 0000:00:03.1: =C2=A0 bridge window [io =C2=A00xd000-0xdfff]<br>[ =C2=A0 =
=C2=A00.366876] pci 0000:00:03.1: =C2=A0 bridge window [mem 0xfe800000-0xfe=
8fffff]<br>[ =C2=A0 =C2=A00.366883] pci 0000:00:03.1: =C2=A0 bridge window =
[mem 0xe0000000-0xf01fffff 64bit pref]<br>[ =C2=A0 =C2=A00.366904] pci 0000=
:00:03.1: enabling Extended Tags<br>[ =C2=A0 =C2=A00.366950] pci 0000:00:03=
.1: PME# supported from D0 D3hot D3cold<br>[ =C2=A0 =C2=A00.367053] pci 000=
0:00:08.0: [1022:1578] type 00 class 0x108000 conventional PCI endpoint<br>=
[ =C2=A0 =C2=A00.367075] pci 0000:00:08.0: BAR 0 [mem 0xf1000000-0xf101ffff=
 64bit pref]<br>[ =C2=A0 =C2=A00.367077] pci 0000:00:08.0: BAR 2 [mem 0xfe7=
00000-0xfe7fffff]<br>[ =C2=A0 =C2=A00.367079] pci 0000:00:08.0: BAR 3 [mem =
0xfea6f000-0xfea6ffff]<br>[ =C2=A0 =C2=A00.367081] pci 0000:00:08.0: BAR 5 =
[mem 0xfea6a000-0xfea6bfff]<br>[ =C2=A0 =C2=A00.367164] pci 0000:00:09.0: [=
1022:157d] type 00 class 0x060000 conventional PCI endpoint<br>[ =C2=A0 =C2=
=A00.367445] pci 0000:00:09.2: [1022:157a] type 00 class 0x040300 conventio=
nal PCI endpoint<br>[ =C2=A0 =C2=A00.367466] pci 0000:00:09.2: BAR 0 [mem 0=
xfea60000-0xfea63fff]<br>[ =C2=A0 =C2=A00.367486] pci 0000:00:09.2: PME# su=
pported from D0 D3hot D3cold<br>[ =C2=A0 =C2=A00.367577] pci 0000:00:10.0: =
[1022:7914] type 00 class 0x0c0330 PCIe Root Complex Integrated Endpoint<br=
>[ =C2=A0 =C2=A00.367626] pci 0000:00:10.0: BAR 0 [mem 0xfea68000-0xfea69ff=
f 64bit]<br>[ =C2=A0 =C2=A00.367698] pci 0000:00:10.0: PME# supported from =
D0 D3hot D3cold<br>[ =C2=A0 =C2=A00.367807] pci 0000:00:11.0: [1022:7901] t=
ype 00 class 0x010601 conventional PCI endpoint<br>[ =C2=A0 =C2=A00.367846]=
 pci 0000:00:11.0: BAR 0 [io =C2=A00xf140-0xf147]<br>[ =C2=A0 =C2=A00.36784=
8] pci 0000:00:11.0: BAR 1 [io =C2=A00xf130-0xf133]<br>[ =C2=A0 =C2=A00.367=
851] pci 0000:00:11.0: BAR 2 [io =C2=A00xf120-0xf127]<br>[ =C2=A0 =C2=A00.3=
67853] pci 0000:00:11.0: BAR 3 [io =C2=A00xf110-0xf113]<br>[ =C2=A0 =C2=A00=
.367855] pci 0000:00:11.0: BAR 4 [io =C2=A00xf100-0xf10f]<br>[ =C2=A0 =C2=
=A00.367857] pci 0000:00:11.0: BAR 5 [mem 0xfea6d000-0xfea6d3ff]<br>[ =C2=
=A0 =C2=A00.367888] pci 0000:00:11.0: PME# supported from D3hot<br>[ =C2=A0=
 =C2=A00.367970] pci 0000:00:12.0: [1022:7908] type 00 class 0x0c0320 conve=
ntional PCI endpoint<br>[ =C2=A0 =C2=A00.368009] pci 0000:00:12.0: BAR 0 [m=
em 0xfea6c000-0xfea6c0ff]<br>[ =C2=A0 =C2=A00.368044] pci 0000:00:12.0: sup=
ports D1 D2<br>[ =C2=A0 =C2=A00.368045] pci 0000:00:12.0: PME# supported fr=
om D0 D1 D2 D3hot D3cold<br>[ =C2=A0 =C2=A00.368171] pci 0000:00:14.0: [102=
2:790b] type 00 class 0x0c0500 conventional PCI endpoint<br>[ =C2=A0 =C2=A0=
0.368283] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100 conventional=
 PCI endpoint<br>[ =C2=A0 =C2=A00.368410] pci 0000:00:18.0: [1022:1570] typ=
e 00 class 0x060000 conventional PCI endpoint<br>[ =C2=A0 =C2=A00.368497] p=
ci 0000:00:18.1: [1022:1571] type 00 class 0x060000 conventional PCI endpoi=
nt<br>[ =C2=A0 =C2=A00.368544] pci 0000:00:18.2: [1022:1572] type 00 class =
0x060000 conventional PCI endpoint<br>[ =C2=A0 =C2=A00.368603] pci 0000:00:=
18.3: [1022:1573] type 00 class 0x060000 conventional PCI endpoint<br>[ =C2=
=A0 =C2=A00.368654] pci 0000:00:18.4: [1022:1574] type 00 class 0x060000 co=
nventional PCI endpoint<br>[ =C2=A0 =C2=A00.368708] pci 0000:00:18.5: [1022=
:1575] type 00 class 0x060000 conventional PCI endpoint<br>[ =C2=A0 =C2=A00=
.368977] pci 0000:01:00.0: [168c:0042] type 00 class 0x028000 PCIe Endpoint=
<br>[ =C2=A0 =C2=A00.369316] pci 0000:01:00.0: BAR 0 [mem 0xfe400000-0xfe5f=
ffff 64bit]<br>[ =C2=A0 =C2=A00.369900] pci 0000:01:00.0: PME# supported fr=
om D0 D3hot D3cold<br>[ =C2=A0 =C2=A00.370761] pci 0000:00:02.2: PCI bridge=
 to [bus 01]<br>[ =C2=A0 =C2=A00.370839] pci 0000:02:00.0: [10ec:8168] type=
 00 class 0x020000 PCIe Endpoint<br>[ =C2=A0 =C2=A00.370890] pci 0000:02:00=
.0: BAR 0 [io =C2=A00xe000-0xe0ff]<br>[ =C2=A0 =C2=A00.370895] pci 0000:02:=
00.0: BAR 2 [mem 0xfe904000-0xfe904fff 64bit]<br>[ =C2=A0 =C2=A00.370899] p=
ci 0000:02:00.0: BAR 4 [mem 0xfe900000-0xfe903fff 64bit]<br>[ =C2=A0 =C2=A0=
0.370989] pci 0000:02:00.0: supports D1 D2<br>[ =C2=A0 =C2=A00.370991] pci =
0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold<br>[ =C2=A0 =C2=A00=
.371197] pci 0000:00:02.3: PCI bridge to [bus 02]<br>[ =C2=A0 =C2=A00.37131=
7] pci 0000:03:00.0: [1002:67ef] type 00 class 0x038000 PCIe Legacy Endpoin=
t<br>[ =C2=A0 =C2=A00.371402] pci 0000:03:00.0: BAR 0 [mem 0xe0000000-0xeff=
fffff 64bit pref]<br>[ =C2=A0 =C2=A00.371406] pci 0000:03:00.0: BAR 2 [mem =
0xf0000000-0xf01fffff 64bit pref]<br>[ =C2=A0 =C2=A00.371409] pci 0000:03:0=
0.0: BAR 4 [io =C2=A00xd000-0xd0ff]<br>[ =C2=A0 =C2=A00.371411] pci 0000:03=
:00.0: BAR 5 [mem 0xfe800000-0xfe83ffff]<br>[ =C2=A0 =C2=A00.371414] pci 00=
00:03:00.0: ROM [mem 0xfe840000-0xfe85ffff pref]<br>[ =C2=A0 =C2=A00.371423=
] pci 0000:03:00.0: enabling Extended Tags<br>[ =C2=A0 =C2=A00.371578] pci =
0000:03:00.0: supports D1 D2<br>[ =C2=A0 =C2=A00.371579] pci 0000:03:00.0: =
PME# supported from D1 D2 D3hot D3cold<br>[ =C2=A0 =C2=A00.371781] pci 0000=
:00:03.1: PCI bridge to [bus 03]<br>[ =C2=A0 =C2=A00.372708] ACPI: PCI: Int=
errupt link LNKA configured for IRQ 5<br>[ =C2=A0 =C2=A00.372763] ACPI: PCI=
: Interrupt link LNKB configured for IRQ 0<br>[ =C2=A0 =C2=A00.372811] ACPI=
: PCI: Interrupt link LNKC configured for IRQ 11<br>[ =C2=A0 =C2=A00.372867=
] ACPI: PCI: Interrupt link LNKD configured for IRQ 4<br>[ =C2=A0 =C2=A00.3=
72918] ACPI: PCI: Interrupt link LNKE configured for IRQ 0<br>[ =C2=A0 =C2=
=A00.372960] ACPI: PCI: Interrupt link LNKF configured for IRQ 0<br>[ =C2=
=A0 =C2=A00.373003] ACPI: PCI: Interrupt link LNKG configured for IRQ 11<br=
>[ =C2=A0 =C2=A00.373046] ACPI: PCI: Interrupt link LNKH configured for IRQ=
 10<br>[ =C2=A0 =C2=A00.374058] ACPI: EC: interrupt unblocked<br>[ =C2=A0 =
=C2=A00.374060] ACPI: EC: event unblocked<br>[ =C2=A0 =C2=A00.374068] ACPI:=
 EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62<br>[ =C2=A0 =C2=A00.374069] ACPI: =
EC: GPE=3D0x3<br>[ =C2=A0 =C2=A00.374071] ACPI: \_SB_.PCI0.SBRG.EC__: Boot =
DSDT EC initialization complete<br>[ =C2=A0 =C2=A00.374074] ACPI: \_SB_.PCI=
0.SBRG.EC__: EC: Used to handle transactions and events<br>[ =C2=A0 =C2=A00=
.374540] iommu: Default domain type: Translated<br>[ =C2=A0 =C2=A00.374540]=
 iommu: DMA domain TLB invalidation policy: lazy mode<br>[ =C2=A0 =C2=A00.3=
74542] SCSI subsystem initialized<br>[ =C2=A0 =C2=A00.374545] libata versio=
n 3.00 loaded.<br>[ =C2=A0 =C2=A00.374545] ACPI: bus type USB registered<br=
>[ =C2=A0 =C2=A00.374545] usbcore: registered new interface driver usbfs<br=
>[ =C2=A0 =C2=A00.374545] usbcore: registered new interface driver hub<br>[=
 =C2=A0 =C2=A00.374545] usbcore: registered new device driver usb<br>[ =C2=
=A0 =C2=A00.377845] EDAC MC: Ver: 3.0.0<br>[ =C2=A0 =C2=A00.378740] NetLabe=
l: Initializing<br>[ =C2=A0 =C2=A00.378745] NetLabel: =C2=A0domain hash siz=
e =3D 128<br>[ =C2=A0 =C2=A00.378747] NetLabel: =C2=A0protocols =3D UNLABEL=
ED CIPSOv4 CALIPSO<br>[ =C2=A0 =C2=A00.378762] NetLabel: =C2=A0unlabeled tr=
affic allowed by default<br>[ =C2=A0 =C2=A00.378766] mctp: management compo=
nent transport protocol core<br>[ =C2=A0 =C2=A00.378767] NET: Registered PF=
_MCTP protocol family<br>[ =C2=A0 =C2=A00.378777] PCI: Using ACPI for IRQ r=
outing<br>[ =C2=A0 =C2=A00.380805] PCI: pci_cache_line_size set to 64 bytes=
<br>[ =C2=A0 =C2=A00.380963] e820: reserve RAM buffer [mem 0x0009d800-0x000=
9ffff]<br>[ =C2=A0 =C2=A00.380967] e820: reserve RAM buffer [mem 0xcc96f000=
-0xcfffffff]<br>[ =C2=A0 =C2=A00.380969] e820: reserve RAM buffer [mem 0xcf=
000000-0xcfffffff]<br>[ =C2=A0 =C2=A00.380970] e820: reserve RAM buffer [me=
m 0x3af000000-0x3afffffff]<br>[ =C2=A0 =C2=A00.381405] pci 0000:00:01.0: vg=
aarb: setting as boot VGA device<br>[ =C2=A0 =C2=A00.381405] pci 0000:00:01=
.0: vgaarb: bridge control possible<br>[ =C2=A0 =C2=A00.381405] pci 0000:00=
:01.0: vgaarb: VGA device added: decodes=3Dio+mem,owns=3Dio+mem,locks=3Dnon=
e<br>[ =C2=A0 =C2=A00.381409] vgaarb: loaded<br>[ =C2=A0 =C2=A00.381469] hp=
et0: at MMIO 0xfed00000, IRQs 2, 8, 0<br>[ =C2=A0 =C2=A00.381469] hpet0: 3 =
comparators, 32-bit 14.318180 MHz counter<br>[ =C2=A0 =C2=A00.383582] clock=
source: Switched to clocksource tsc-early<br>[ =C2=A0 =C2=A00.384361] VFS: =
Disk quotas dquot_6.6.0<br>[ =C2=A0 =C2=A00.384376] VFS: Dquot-cache hash t=
able entries: 512 (order 0, 4096 bytes)<br>[ =C2=A0 =C2=A00.384775] pnp: Pn=
P ACPI init<br>[ =C2=A0 =C2=A00.384933] system 00:00: [mem 0xf8000000-0xfbf=
fffff] has been reserved<br>[ =C2=A0 =C2=A00.385007] system 00:01: [mem 0x5=
0000000-0xcfffffff] could not be reserved<br>[ =C2=A0 =C2=A00.385077] syste=
m 00:02: [mem 0xfeb80000-0xfebfffff] could not be reserved<br>[ =C2=A0 =C2=
=A00.385591] system 00:06: [io =C2=A00x04d0-0x04d1] has been reserved<br>[ =
=C2=A0 =C2=A00.385594] system 00:06: [io =C2=A00x040b] has been reserved<br=
>[ =C2=A0 =C2=A00.385595] system 00:06: [io =C2=A00x04d6] has been reserved=
<br>[ =C2=A0 =C2=A00.385597] system 00:06: [io =C2=A00x0c00-0x0c01] has bee=
n reserved<br>[ =C2=A0 =C2=A00.385598] system 00:06: [io =C2=A00x0c14] has =
been reserved<br>[ =C2=A0 =C2=A00.385600] system 00:06: [io =C2=A00x0c50-0x=
0c51] has been reserved<br>[ =C2=A0 =C2=A00.385601] system 00:06: [io =C2=
=A00x0c52] has been reserved<br>[ =C2=A0 =C2=A00.385603] system 00:06: [io =
=C2=A00x0c6c] has been reserved<br>[ =C2=A0 =C2=A00.385604] system 00:06: [=
io =C2=A00x0c6f] has been reserved<br>[ =C2=A0 =C2=A00.385606] system 00:06=
: [io =C2=A00x0cd0-0x0cd1] has been reserved<br>[ =C2=A0 =C2=A00.385607] sy=
stem 00:06: [io =C2=A00x0cd2-0x0cd3] has been reserved<br>[ =C2=A0 =C2=A00.=
385609] system 00:06: [io =C2=A00x0cd4-0x0cd5] has been reserved<br>[ =C2=
=A0 =C2=A00.385610] system 00:06: [io =C2=A00x0cd6-0x0cd7] has been reserve=
d<br>[ =C2=A0 =C2=A00.385611] system 00:06: [io =C2=A00x0cd8-0x0cdf] has be=
en reserved<br>[ =C2=A0 =C2=A00.385613] system 00:06: [io =C2=A00x0800-0x08=
9f] has been reserved<br>[ =C2=A0 =C2=A00.385614] system 00:06: [io =C2=A00=
x0b00-0x0b0f] has been reserved<br>[ =C2=A0 =C2=A00.385616] system 00:06: [=
io =C2=A00x0b20-0x0b3f] has been reserved<br>[ =C2=A0 =C2=A00.385617] syste=
m 00:06: [io =C2=A00x0900-0x090f] has been reserved<br>[ =C2=A0 =C2=A00.385=
619] system 00:06: [io =C2=A00x0910-0x091f] has been reserved<br>[ =C2=A0 =
=C2=A00.385620] system 00:06: [io =C2=A00x0380-0x0381] has been reserved<br=
>[ =C2=A0 =C2=A00.385622] system 00:06: [io =C2=A00xfe00-0xfefe] has been r=
eserved<br>[ =C2=A0 =C2=A00.385624] system 00:06: [mem 0xfec00000-0xfec00ff=
f] could not be reserved<br>[ =C2=A0 =C2=A00.385626] system 00:06: [mem 0xf=
ec01000-0xfec01fff] could not be reserved<br>[ =C2=A0 =C2=A00.385628] syste=
m 00:06: [mem 0xfedc0000-0xfedc0fff] has been reserved<br>[ =C2=A0 =C2=A00.=
385630] system 00:06: [mem 0xfee00000-0xfee00fff] has been reserved<br>[ =
=C2=A0 =C2=A00.385632] system 00:06: [mem 0xfed80000-0xfed8ffff] could not =
be reserved<br>[ =C2=A0 =C2=A00.385633] system 00:06: [mem 0xfed61000-0xfed=
70fff] has been reserved<br>[ =C2=A0 =C2=A00.385636] system 00:06: [mem 0xf=
e200000-0xfe200fff] has been reserved<br>[ =C2=A0 =C2=A00.385638] system 00=
:06: [mem 0xfec10000-0xfec10fff] has been reserved<br>[ =C2=A0 =C2=A00.3856=
40] system 00:06: [mem 0xff000000-0xffffffff] has been reserved<br>[ =C2=A0=
 =C2=A00.387001] pnp: PnP ACPI: found 7 devices<br>[ =C2=A0 =C2=A00.393269]=
 clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 20=
85701024 ns<br>[ =C2=A0 =C2=A00.393354] NET: Registered PF_INET protocol fa=
mily<br>[ =C2=A0 =C2=A00.393737] IP idents hash table entries: 262144 (orde=
r: 9, 2097152 bytes, linear)<br>[ =C2=A0 =C2=A00.412743] tcp_listen_portadd=
r_hash hash table entries: 8192 (order: 5, 131072 bytes, linear)<br>[ =C2=
=A0 =C2=A00.412786] Table-perturb hash table entries: 65536 (order: 6, 2621=
44 bytes, linear)<br>[ =C2=A0 =C2=A00.412945] TCP established hash table en=
tries: 131072 (order: 8, 1048576 bytes, linear)<br>[ =C2=A0 =C2=A00.413580]=
 TCP bind hash table entries: 65536 (order: 9, 2097152 bytes, linear)<br>[ =
=C2=A0 =C2=A00.414149] TCP: Hash tables configured (established 131072 bind=
 65536)<br>[ =C2=A0 =C2=A00.414337] MPTCP token hash table entries: 16384 (=
order: 6, 393216 bytes, linear)<br>[ =C2=A0 =C2=A00.414483] UDP hash table =
entries: 8192 (order: 7, 524288 bytes, linear)<br>[ =C2=A0 =C2=A00.414621] =
UDP-Lite hash table entries: 8192 (order: 7, 524288 bytes, linear)<br>[ =C2=
=A0 =C2=A00.414718] NET: Registered PF_UNIX/PF_LOCAL protocol family<br>[ =
=C2=A0 =C2=A00.414731] NET: Registered PF_XDP protocol family<br>[ =C2=A0 =
=C2=A00.414752] pci 0000:00:02.2: PCI bridge to [bus 01]<br>[ =C2=A0 =C2=A0=
0.414760] pci 0000:00:02.2: =C2=A0 bridge window [mem 0xfe400000-0xfe5fffff=
]<br>[ =C2=A0 =C2=A00.414768] pci 0000:00:02.3: PCI bridge to [bus 02]<br>[=
 =C2=A0 =C2=A00.414770] pci 0000:00:02.3: =C2=A0 bridge window [io =C2=A00x=
e000-0xefff]<br>[ =C2=A0 =C2=A00.414774] pci 0000:00:02.3: =C2=A0 bridge wi=
ndow [mem 0xfe900000-0xfe9fffff]<br>[ =C2=A0 =C2=A00.414781] pci 0000:00:03=
.1: PCI bridge to [bus 03]<br>[ =C2=A0 =C2=A00.414783] pci 0000:00:03.1: =
=C2=A0 bridge window [io =C2=A00xd000-0xdfff]<br>[ =C2=A0 =C2=A00.414787] p=
ci 0000:00:03.1: =C2=A0 bridge window [mem 0xfe800000-0xfe8fffff]<br>[ =C2=
=A0 =C2=A00.414790] pci 0000:00:03.1: =C2=A0 bridge window [mem 0xe0000000-=
0xf01fffff 64bit pref]<br>[ =C2=A0 =C2=A00.414797] pci_bus 0000:00: resourc=
e 4 [io =C2=A00x0000-0x03af window]<br>[ =C2=A0 =C2=A00.414799] pci_bus 000=
0:00: resource 5 [io =C2=A00x03e0-0x0cf7 window]<br>[ =C2=A0 =C2=A00.414801=
] pci_bus 0000:00: resource 6 [io =C2=A00x03b0-0x03df window]<br>[ =C2=A0 =
=C2=A00.414802] pci_bus 0000:00: resource 7 [io =C2=A00x0d00-0xffff window]=
<br>[ =C2=A0 =C2=A00.414803] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x=
000dffff window]<br>[ =C2=A0 =C2=A00.414805] pci_bus 0000:00: resource 9 [m=
em 0xd0000000-0xfed3ffff window]<br>[ =C2=A0 =C2=A00.414806] pci_bus 0000:0=
0: resource 10 [mem 0xfedca000-0xffffffff window]<br>[ =C2=A0 =C2=A00.41480=
8] pci_bus 0000:00: resource 11 [mem 0x47f000000-0xfffffffff window]<br>[ =
=C2=A0 =C2=A00.414810] pci_bus 0000:01: resource 1 [mem 0xfe400000-0xfe5fff=
ff]<br>[ =C2=A0 =C2=A00.414811] pci_bus 0000:02: resource 0 [io =C2=A00xe00=
0-0xefff]<br>[ =C2=A0 =C2=A00.414813] pci_bus 0000:02: resource 1 [mem 0xfe=
900000-0xfe9fffff]<br>[ =C2=A0 =C2=A00.414814] pci_bus 0000:03: resource 0 =
[io =C2=A00xd000-0xdfff]<br>[ =C2=A0 =C2=A00.414816] pci_bus 0000:03: resou=
rce 1 [mem 0xfe800000-0xfe8fffff]<br>[ =C2=A0 =C2=A00.414817] pci_bus 0000:=
03: resource 2 [mem 0xe0000000-0xf01fffff 64bit pref]<br>[ =C2=A0 =C2=A00.4=
14947] pci 0000:00:01.1: D0 power state depends on 0000:00:01.0<br>[ =C2=A0=
 =C2=A00.415235] pci 0000:00:10.0: PME# does not work under D0, disabling i=
t<br>[ =C2=A0 =C2=A00.428169] pci 0000:00:12.0: quirk_usb_early_handoff+0x0=
/0x770 took 12620 usecs<br>[ =C2=A0 =C2=A00.428247] PCI: CLS 0 bytes, defau=
lt 64<br>[ =C2=A0 =C2=A00.428266] AMD-Vi: [Firmware Warn]: EFR mismatch. Us=
e IVHD EFR (0x37ef22294ada : 0x77ef22294ada), EFR2 (0x0 : 0x0).<br>[ =C2=A0=
 =C2=A00.428273] pci 0000:00:00.2: AMD-Vi: IOMMU performance counters suppo=
rted<br>[ =C2=A0 =C2=A00.428328] Trying to unpack rootfs image as initramfs=
...<br>[ =C2=A0 =C2=A00.428337] pci 0000:00:00.0: Adding to iommu group 0<b=
r>[ =C2=A0 =C2=A00.428369] pci 0000:00:01.0: Adding to iommu group 1<br>[ =
=C2=A0 =C2=A00.428382] pci 0000:00:01.1: Adding to iommu group 1<br>[ =C2=
=A0 =C2=A00.428418] pci 0000:00:02.0: Adding to iommu group 2<br>[ =C2=A0 =
=C2=A00.428451] pci 0000:00:02.2: Adding to iommu group 2<br>[ =C2=A0 =C2=
=A00.428474] pci 0000:00:02.3: Adding to iommu group 2<br>[ =C2=A0 =C2=A00.=
428508] pci 0000:00:03.0: Adding to iommu group 3<br>[ =C2=A0 =C2=A00.42852=
9] pci 0000:00:03.1: Adding to iommu group 3<br>[ =C2=A0 =C2=A00.428551] pc=
i 0000:00:08.0: Adding to iommu group 4<br>[ =C2=A0 =C2=A00.428592] pci 000=
0:00:09.0: Adding to iommu group 5<br>[ =C2=A0 =C2=A00.428613] pci 0000:00:=
09.2: Adding to iommu group 5<br>[ =C2=A0 =C2=A00.428635] pci 0000:00:10.0:=
 Adding to iommu group 6<br>[ =C2=A0 =C2=A00.428656] pci 0000:00:11.0: Addi=
ng to iommu group 7<br>[ =C2=A0 =C2=A00.428676] pci 0000:00:12.0: Adding to=
 iommu group 8<br>[ =C2=A0 =C2=A00.428717] pci 0000:00:14.0: Adding to iomm=
u group 9<br>[ =C2=A0 =C2=A00.428738] pci 0000:00:14.3: Adding to iommu gro=
up 9<br>[ =C2=A0 =C2=A00.428817] pci 0000:00:18.0: Adding to iommu group 10=
<br>[ =C2=A0 =C2=A00.428841] pci 0000:00:18.1: Adding to iommu group 10<br>=
[ =C2=A0 =C2=A00.428863] pci 0000:00:18.2: Adding to iommu group 10<br>[ =
=C2=A0 =C2=A00.428887] pci 0000:00:18.3: Adding to iommu group 10<br>[ =C2=
=A0 =C2=A00.428911] pci 0000:00:18.4: Adding to iommu group 10<br>[ =C2=A0 =
=C2=A00.428939] pci 0000:00:18.5: Adding to iommu group 10<br>[ =C2=A0 =C2=
=A00.428948] pci 0000:01:00.0: Adding to iommu group 2<br>[ =C2=A0 =C2=A00.=
428957] pci 0000:02:00.0: Adding to iommu group 2<br>[ =C2=A0 =C2=A00.42897=
0] pci 0000:03:00.0: Adding to iommu group 3<br>[ =C2=A0 =C2=A00.430728] AM=
D-Vi: Extended features (0x77ef22294ada, 0x0): PPR NX GT IA GA PC GA_vAPIC<=
br>[ =C2=A0 =C2=A00.430742] AMD-Vi: Interrupt remapping enabled<br>[ =C2=A0=
 =C2=A00.431039] AMD-Vi: Virtual APIC enabled<br>[ =C2=A0 =C2=A00.431046] P=
CI-DMA: Using software bounce buffering for IO (SWIOTLB)<br>[ =C2=A0 =C2=A0=
0.431047] software IO TLB: mapped [mem 0x00000000c896f000-0x00000000cc96f00=
0] (64MB)<br>[ =C2=A0 =C2=A00.431112] LVT offset 0 assigned for vector 0x40=
0<br>[ =C2=A0 =C2=A00.433770] perf: AMD IBS detected (0x000007ff)<br>[ =C2=
=A0 =C2=A00.433785] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 count=
ers/bank).<br>[ =C2=A0 =C2=A00.471249] Initialise system trusted keyrings<b=
r>[ =C2=A0 =C2=A00.471265] Key type blacklist registered<br>[ =C2=A0 =C2=A0=
0.471355] workingset: timestamp_bits=3D36 max_order=3D22 bucket_order=3D0<b=
r>[ =C2=A0 =C2=A00.471629] fuse: init (API version 7.43)<br>[ =C2=A0 =C2=A0=
0.471745] integrity: Platform Keyring initialized<br>[ =C2=A0 =C2=A00.47175=
0] integrity: Machine keyring initialized<br>[ =C2=A0 =C2=A00.482974] xor: =
automatically using best checksumming function =C2=A0 avx =C2=A0 =C2=A0 =C2=
=A0<br>[ =C2=A0 =C2=A00.482976] Key type asymmetric registered<br>[ =C2=A0 =
=C2=A00.482978] Asymmetric key parser &#39;x509&#39; registered<br>[ =C2=A0=
 =C2=A00.483001] Block layer SCSI generic (bsg) driver version 0.4 loaded (=
major 246)<br>[ =C2=A0 =C2=A00.483076] io scheduler mq-deadline registered<=
br>[ =C2=A0 =C2=A00.483078] io scheduler kyber registered<br>[ =C2=A0 =C2=
=A00.483091] io scheduler bfq registered<br>[ =C2=A0 =C2=A00.484256] ledtri=
g-cpu: registered to indicate activity on CPUs<br>[ =C2=A0 =C2=A00.484515] =
pcieport 0000:00:02.2: PME: Signaling with IRQ 26<br>[ =C2=A0 =C2=A00.48469=
2] pcieport 0000:00:02.3: PME: Signaling with IRQ 27<br>[ =C2=A0 =C2=A00.48=
4883] pcieport 0000:00:03.1: PME: Signaling with IRQ 29<br>[ =C2=A0 =C2=A00=
.484908] pcieport 0000:00:03.1: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- Attn=
Ind- PwrInd- HotPlug+ Surprise- Interlock- NoCompl+ IbPresDis- LLActRep+<br=
>[ =C2=A0 =C2=A00.486063] ACPI: AC: AC Adapter [ACAD] (on-line)<br>[ =C2=A0=
 =C2=A00.486129] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PN=
P0C0C:00/input/input0<br>[ =C2=A0 =C2=A00.486151] ACPI: button: Power Butto=
n [PWRB]<br>[ =C2=A0 =C2=A00.486183] input: Lid Switch as /devices/LNXSYSTM=
:00/LNXSYBUS:00/PNP0C0D:00/input/input1<br>[ =C2=A0 =C2=A00.490191] ACPI: b=
utton: Lid Switch [LID0]<br>[ =C2=A0 =C2=A00.490267] input: Sleep Button as=
 /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input2<br>[ =C2=A0 =C2=
=A00.490297] ACPI: button: Sleep Button [SLPB]<br>[ =C2=A0 =C2=A00.490332] =
input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3<br>[ =
=C2=A0 =C2=A00.490376] ACPI: button: Power Button [PWRF]<br>[ =C2=A0 =C2=A0=
0.490648] Could not retrieve perf counters (-19)<br>[ =C2=A0 =C2=A00.490981=
] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled<br>[ =C2=A0 =C2=
=A00.493254] Non-volatile memory driver v1.3<br>[ =C2=A0 =C2=A00.493259] Li=
nux agpgart interface v0.103<br>[ =C2=A0 =C2=A00.493319] ACPI: bus type drm=
_connector registered<br>[ =C2=A0 =C2=A00.493999] ahci 0000:00:11.0: versio=
n 3.0<br>[ =C2=A0 =C2=A00.494234] ahci 0000:00:11.0: AHCI vers 0001.0300, 3=
2 command slots, 6 Gbps, SATA mode<br>[ =C2=A0 =C2=A00.494238] ahci 0000:00=
:11.0: 1/1 ports implemented (port mask 0x1)<br>[ =C2=A0 =C2=A00.494240] ah=
ci 0000:00:11.0: flags: 64bit ncq sntf ilck led clo pmp fbs pio slum part<b=
r>[ =C2=A0 =C2=A00.494497] scsi host0: ahci<br>[ =C2=A0 =C2=A00.494557] ata=
1: SATA max UDMA/133 abar m1024@0xfea6d000 port 0xfea6d100 irq 19 lpm-pol 3=
<br>[ =C2=A0 =C2=A00.494945] xhci_hcd 0000:00:10.0: xHCI Host Controller<br=
>[ =C2=A0 =C2=A00.494954] xhci_hcd 0000:00:10.0: new USB bus registered, as=
signed bus number 1<br>[ =C2=A0 =C2=A00.495171] xhci_hcd 0000:00:10.0: hcc =
params 0x014040c3 hci version 0x100 quirks 0x0000000000000010<br>[ =C2=A0 =
=C2=A00.495474] ehci-pci 0000:00:12.0: EHCI Host Controller<br>[ =C2=A0 =C2=
=A00.495481] ehci-pci 0000:00:12.0: new USB bus registered, assigned bus nu=
mber 2<br>[ =C2=A0 =C2=A00.495493] ehci-pci 0000:00:12.0: debug port 2<br>[=
 =C2=A0 =C2=A00.495549] ehci-pci 0000:00:12.0: irq 18, io mem 0xfea6c000<br=
>[ =C2=A0 =C2=A00.495563] xhci_hcd 0000:00:10.0: xHCI Host Controller<br>[ =
=C2=A0 =C2=A00.495566] xhci_hcd 0000:00:10.0: new USB bus registered, assig=
ned bus number 3<br>[ =C2=A0 =C2=A00.495569] xhci_hcd 0000:00:10.0: Host su=
pports USB 3.0 SuperSpeed<br>[ =C2=A0 =C2=A00.500186] ACPI: battery: Slot [=
BAT0] (battery present)<br>[ =C2=A0 =C2=A00.502114] ehci-pci 0000:00:12.0: =
USB 2.0 started, EHCI 1.00<br>[ =C2=A0 =C2=A00.502166] usb usb1: New USB de=
vice found, idVendor=3D1d6b, idProduct=3D0002, bcdDevice=3D 6.15<br>[ =C2=
=A0 =C2=A00.502169] usb usb1: New USB device strings: Mfr=3D3, Product=3D2,=
 SerialNumber=3D1<br>[ =C2=A0 =C2=A00.502171] usb usb1: Product: xHCI Host =
Controller<br>[ =C2=A0 =C2=A00.502173] usb usb1: Manufacturer: Linux 6.15.4=
-arch2-1 xhci-hcd<br>[ =C2=A0 =C2=A00.502174] usb usb1: SerialNumber: 0000:=
00:10.0<br>[ =C2=A0 =C2=A00.502318] hub 1-0:1.0: USB hub found<br>[ =C2=A0 =
=C2=A00.502329] hub 1-0:1.0: 4 ports detected<br>[ =C2=A0 =C2=A00.502534] u=
sb usb3: We don&#39;t know the algorithms for LPM for this host, disabling =
LPM.<br>[ =C2=A0 =C2=A00.502556] usb usb3: New USB device found, idVendor=
=3D1d6b, idProduct=3D0003, bcdDevice=3D 6.15<br>[ =C2=A0 =C2=A00.502558] us=
b usb3: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1<br>[=
 =C2=A0 =C2=A00.502560] usb usb3: Product: xHCI Host Controller<br>[ =C2=A0=
 =C2=A00.502561] usb usb3: Manufacturer: Linux 6.15.4-arch2-1 xhci-hcd<br>[=
 =C2=A0 =C2=A00.502562] usb usb3: SerialNumber: 0000:00:10.0<br>[ =C2=A0 =
=C2=A00.502646] hub 3-0:1.0: USB hub found<br>[ =C2=A0 =C2=A00.502656] hub =
3-0:1.0: 4 ports detected<br>[ =C2=A0 =C2=A00.502874] usb usb2: New USB dev=
ice found, idVendor=3D1d6b, idProduct=3D0002, bcdDevice=3D 6.15<br>[ =C2=A0=
 =C2=A00.502877] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D1<br>[ =C2=A0 =C2=A00.502879] usb usb2: Product: EHCI Host Con=
troller<br>[ =C2=A0 =C2=A00.502881] usb usb2: Manufacturer: Linux 6.15.4-ar=
ch2-1 ehci_hcd<br>[ =C2=A0 =C2=A00.502883] usb usb2: SerialNumber: 0000:00:=
12.0<br>[ =C2=A0 =C2=A00.502950] usbcore: registered new interface driver u=
sbserial_generic<br>[ =C2=A0 =C2=A00.502962] usbserial: USB Serial support =
registered for generic<br>[ =C2=A0 =C2=A00.503006] hub 2-0:1.0: USB hub fou=
nd<br>[ =C2=A0 =C2=A00.503008] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PN=
P0f13:PS2M] at 0x60,0x64 irq 1,12<br>[ =C2=A0 =C2=A00.503014] hub 2-0:1.0: =
2 ports detected<br>[ =C2=A0 =C2=A00.505601] serio: i8042 KBD port at 0x60,=
0x64 irq 1<br>[ =C2=A0 =C2=A00.505637] serio: i8042 AUX port at 0x60,0x64 i=
rq 12<br>[ =C2=A0 =C2=A00.505798] rtc_cmos 00:03: RTC can wake from S4<br>[=
 =C2=A0 =C2=A00.506009] rtc_cmos 00:03: registered as rtc0<br>[ =C2=A0 =C2=
=A00.506034] rtc_cmos 00:03: setting system clock to 2026-02-05T06:54:35 UT=
C (1770274475)<br>[ =C2=A0 =C2=A00.506063] rtc_cmos 00:03: alarms up to one=
 month, y3k, 114 bytes nvram, hpet irqs<br>[ =C2=A0 =C2=A00.506120] amd_pst=
ate: the _CPC object is not present in SBIOS or ACPI disabled<br>[ =C2=A0 =
=C2=A00.506410] hid: raw HID events driver (C) Jiri Kosina<br>[ =C2=A0 =C2=
=A00.506437] usbcore: registered new interface driver usbhid<br>[ =C2=A0 =
=C2=A00.506438] usbhid: USB HID core driver<br>[ =C2=A0 =C2=A00.506506] dro=
p_monitor: Initializing network drop monitor service<br>[ =C2=A0 =C2=A00.50=
6636] NET: Registered PF_INET6 protocol family<br>[ =C2=A0 =C2=A00.507161] =
input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input=
/input4<br>[ =C2=A0 =C2=A00.738504] usb 1-2: new high-speed USB device numb=
er 2 using xhci_hcd<br>[ =C2=A0 =C2=A00.738525] usb 2-1: new high-speed USB=
 device number 2 using ehci-pci<br>[ =C2=A0 =C2=A00.864063] usb 2-1: New US=
B device found, idVendor=3D0438, idProduct=3D7900, bcdDevice=3D 0.18<br>[ =
=C2=A0 =C2=A00.864072] usb 2-1: New USB device strings: Mfr=3D0, Product=3D=
0, SerialNumber=3D0<br>[ =C2=A0 =C2=A00.864339] hub 2-1:1.0: USB hub found<=
br>[ =C2=A0 =C2=A00.864432] hub 2-1:1.0: 4 ports detected<br>[ =C2=A0 =C2=
=A00.866105] usb 1-2: New USB device found, idVendor=3D05e3, idProduct=3D07=
47, bcdDevice=3D 8.19<br>[ =C2=A0 =C2=A00.866109] usb 1-2: New USB device s=
trings: Mfr=3D3, Product=3D4, SerialNumber=3D5<br>[ =C2=A0 =C2=A00.866111] =
usb 1-2: Product: USB Storage<br>[ =C2=A0 =C2=A00.866113] usb 1-2: Manufact=
urer: Generic<br>[ =C2=A0 =C2=A00.866114] usb 1-2: SerialNumber: 0000000008=
19<br>[ =C2=A0 =C2=A00.970785] ata1: SATA link up 6.0 Gbps (SStatus 133 SCo=
ntrol 300)<br>[ =C2=A0 =C2=A00.972217] ata1.00: ATA-9: SSD, U1124A0, max UD=
MA/133<br>[ =C2=A0 =C2=A00.973054] ata1.00: 500118192 sectors, multi 1: LBA=
48 NCQ (depth 32), AA<br>[ =C2=A0 =C2=A00.976536] ata1.00: configured for U=
DMA/133<br>[ =C2=A0 =C2=A00.976677] scsi 0:0:0:0: Direct-Access =C2=A0 =C2=
=A0 ATA =C2=A0 =C2=A0 =C2=A0SSD =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A04A0 =C2=A0PQ: 0 ANSI: 5<br>[ =C2=A0 =C2=A00.977002] sd 0:0:0:0: [sda]=
 500118192 512-byte logical blocks: (256 GB/238 GiB)<br>[ =C2=A0 =C2=A00.97=
7018] sd 0:0:0:0: [sda] Write Protect is off<br>[ =C2=A0 =C2=A00.977021] sd=
 0:0:0:0: [sda] Mode Sense: 00 3a 00 00<br>[ =C2=A0 =C2=A00.977036] sd 0:0:=
0:0: [sda] Write cache: enabled, read cache: enabled, doesn&#39;t support D=
PO or FUA<br>[ =C2=A0 =C2=A00.977064] sd 0:0:0:0: [sda] Preferred minimum I=
/O size 512 bytes<br>[ =C2=A0 =C2=A00.984741] =C2=A0sda: sda1 sda2 sda3<br>=
[ =C2=A0 =C2=A00.984900] sd 0:0:0:0: [sda] Attached SCSI disk<br>[ =C2=A0 =
=C2=A01.147542] usb 2-1.2: new full-speed USB device number 3 using ehci-pc=
i<br>[ =C2=A0 =C2=A01.235631] usb 2-1.2: New USB device found, idVendor=3D0=
cf3, idProduct=3De009, bcdDevice=3D 0.01<br>[ =C2=A0 =C2=A01.235646] usb 2-=
1.2: New USB device strings: Mfr=3D0, Product=3D0, SerialNumber=3D0<br>[ =
=C2=A0 =C2=A01.310566] usb 2-1.4: new high-speed USB device number 4 using =
ehci-pci<br>[ =C2=A0 =C2=A01.399862] usb 2-1.4: New USB device found, idVen=
dor=3D0bda, idProduct=3D0129, bcdDevice=3D39.60<br>[ =C2=A0 =C2=A01.399871]=
 usb 2-1.4: New USB device strings: Mfr=3D1, Product=3D2, SerialNumber=3D3<=
br>[ =C2=A0 =C2=A01.399882] usb 2-1.4: Product: USB2.0-CRW<br>[ =C2=A0 =C2=
=A01.399883] usb 2-1.4: Manufacturer: Generic<br>[ =C2=A0 =C2=A01.399885] u=
sb 2-1.4: SerialNumber: 20100201396000000<br>[ =C2=A0 =C2=A01.465556] tsc: =
Refined TSC clocksource calibration: 2999.999 MHz<br>[ =C2=A0 =C2=A01.46556=
8] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2b3e44b2357, ma=
x_idle_ns: 440795324996 ns<br>[ =C2=A0 =C2=A01.465679] clocksource: Switche=
d to clocksource tsc<br>[ =C2=A0 =C2=A01.783849] Freeing initrd memory: 157=
048K<br>[ =C2=A0 =C2=A01.793748] Segment Routing with IPv6<br>[ =C2=A0 =C2=
=A01.793754] RPL Segment Routing with IPv6<br>[ =C2=A0 =C2=A01.793776] In-s=
itu OAM (IOAM) with IPv6<br>[ =C2=A0 =C2=A01.793811] NET: Registered PF_PAC=
KET protocol family<br>[ =C2=A0 =C2=A01.794099] x86/pm: family 0x15 cpu det=
ected, MSR saving is needed during suspending.<br>[ =C2=A0 =C2=A01.794802] =
microcode: Current revision: 0x0600611a<br>[ =C2=A0 =C2=A01.795255] IPI sho=
rthand broadcast: enabled<br>[ =C2=A0 =C2=A01.797778] sched_clock: Marking =
stable (1795002193, 2539590)-&gt;(1811761560, -14219777)<br>[ =C2=A0 =C2=A0=
1.798061] registered taskstats version 1<br>[ =C2=A0 =C2=A01.799235] Loadin=
g compiled-in X.509 certificates<br>[ =C2=A0 =C2=A01.807770] Loaded X.509 c=
ert &#39;Build time autogenerated kernel key: 1263cc237f7edc3f3e8acdd3ae180=
9e6a89d0f66&#39;<br>[ =C2=A0 =C2=A01.811777] zswap: loaded using pool zstd/=
zsmalloc<br>[ =C2=A0 =C2=A01.811969] Demotion targets for Node 0: null<br>[=
 =C2=A0 =C2=A01.812132] Key type .fscrypt registered<br>[ =C2=A0 =C2=A01.81=
2133] Key type fscrypt-provisioning registered<br>[ =C2=A0 =C2=A01.813417] =
Btrfs loaded, zoned=3Dyes, fsverity=3Dyes<br>[ =C2=A0 =C2=A01.813471] Key t=
ype big_key registered<br>[ =C2=A0 =C2=A01.813869] PM: =C2=A0 Magic number:=
 14:873:922<br>[ =C2=A0 =C2=A01.816792] RAS: Correctable Errors collector i=
nitialized.<br>[ =C2=A0 =C2=A01.827032] clk: Disabling unused clocks<br>[ =
=C2=A0 =C2=A01.827039] PM: genpd: Disabling unused power domains<br>[ =C2=
=A0 =C2=A01.829010] Freeing unused decrypted memory: 2028K<br>[ =C2=A0 =C2=
=A01.830358] Freeing unused kernel image (initmem) memory: 4632K<br>[ =C2=
=A0 =C2=A01.830399] Write protecting the kernel read-only data: 38912k<br>[=
 =C2=A0 =C2=A01.830873] Freeing unused kernel image (text/rodata gap) memor=
y: 784K<br>[ =C2=A0 =C2=A01.831464] Freeing unused kernel image (rodata/dat=
a gap) memory: 1912K<br>[ =C2=A0 =C2=A01.959064] x86/mm: Checked W+X mappin=
gs: passed, no W+X pages found.<br>[ =C2=A0 =C2=A01.959072] rodata_test: al=
l tests were successful<br>[ =C2=A0 =C2=A01.959079] Run /init as init proce=
ss<br>[ =C2=A0 =C2=A01.959081] =C2=A0 with arguments:<br>[ =C2=A0 =C2=A01.9=
59082] =C2=A0 =C2=A0 /init<br>[ =C2=A0 =C2=A01.959084] =C2=A0 with environm=
ent:<br>[ =C2=A0 =C2=A01.959084] =C2=A0 =C2=A0 HOME=3D/<br>[ =C2=A0 =C2=A01=
.959085] =C2=A0 =C2=A0 TERM=3Dlinux<br>[ =C2=A0 =C2=A01.959086] =C2=A0 =C2=
=A0 BOOT_IMAGE=3D/arch/boot/x86_64/vmlinuz-linux<br>[ =C2=A0 =C2=A01.959087=
] =C2=A0 =C2=A0 archisobasedir=3Darch<br>[ =C2=A0 =C2=A01.959088] =C2=A0 =
=C2=A0 archisosearchuuid=3D2025-07-01-17-34-06-00<br>[ =C2=A0 =C2=A02.09405=
2] wmi_bus wmi_bus-PNP0C14:00: [Firmware Bug]: WQBC data block query contro=
l method not found<br>[ =C2=A0 =C2=A02.094107] wmi_bus wmi_bus-PNP0C14:00: =
[Firmware Bug]: WMBD method block execution control method not found<br>[ =
=C2=A0 =C2=A02.100074] ACPI: video: Video Device [VGA] (multi-head: yes =C2=
=A0rom: no =C2=A0post: no)<br>[ =C2=A0 =C2=A02.100396] input: Video Bus as =
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input6<br>[ =
=C2=A0 =C2=A02.100607] ACPI: video: Video Device [VGA2] (multi-head: yes =
=C2=A0rom: no =C2=A0post: no)<br>[ =C2=A0 =C2=A02.100711] input: Video Bus =
as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:0e/LNXVIDEO:02/input/=
input7<br>[ =C2=A0 =C2=A02.123878] usb-storage 1-2:1.0: USB Mass Storage de=
vice detected<br>[ =C2=A0 =C2=A02.128086] scsi host1: usb-storage 1-2:1.0<b=
r>[ =C2=A0 =C2=A02.128289] usbcore: registered new interface driver usb-sto=
rage<br>[ =C2=A0 =C2=A02.137065] usbcore: registered new interface driver u=
as<br>[ =C2=A0 =C2=A02.142867] usbcore: registered new interface driver rts=
x_usb<br>[ =C2=A0 =C2=A02.147323] cryptd: max_cpu_qlen set to 1000<br>[ =C2=
=A0 =C2=A02.170761] r8169 0000:02:00.0: can&#39;t disable ASPM; OS doesn&#3=
9;t have ASPM control<br>[ =C2=A0 =C2=A02.178499] r8169 0000:02:00.0 eth0: =
RTL8168h/8111h, f4:8e:38:f1:b0:dc, XID 541, IRQ 36<br>[ =C2=A0 =C2=A02.1785=
08] r8169 0000:02:00.0 eth0: jumbo features [frames: 9194 bytes, tx checksu=
mming: ko]<br>[ =C2=A0 =C2=A03.131112] scsi 1:0:0:0: Direct-Access =C2=A0 =
=C2=A0 Generic =C2=A0STORAGE DEVICE =C2=A0 0819 PQ: 0 ANSI: 6<br>[ =C2=A0 =
=C2=A03.376795] sd 1:0:0:0: [sdb] 31116288 512-byte logical blocks: (15.9 G=
B/14.8 GiB)<br>[ =C2=A0 =C2=A03.378070] sd 1:0:0:0: [sdb] Write Protect is =
off<br>[ =C2=A0 =C2=A03.378078] sd 1:0:0:0: [sdb] Mode Sense: 87 00 00 00<b=
r>[ =C2=A0 =C2=A03.379452] sd 1:0:0:0: [sdb] Write cache: disabled, read ca=
che: enabled, doesn&#39;t support DPO or FUA<br>[ =C2=A0 =C2=A03.585717] =
=C2=A0sdb: sdb1 sdb2<br>[ =C2=A0 =C2=A03.586122] sd 1:0:0:0: [sdb] Attached=
 SCSI removable disk<br>[ =C2=A0 11.146216] [drm] amdgpu kernel modesetting=
 enabled.<br>[ =C2=A0 11.146244] amdgpu: vga_switcheroo: detected switching=
 method \_SB_.PCI0.VGA_.ATPX handle<br>[ =C2=A0 11.146683] amdgpu: ATPX ver=
sion 1, functions 0x00000003<br>[ =C2=A0 11.149571] amdgpu: Virtual CRAT ta=
ble created for CPU<br>[ =C2=A0 11.149588] amdgpu: Topology: Add CPU node<b=
r>[ =C2=A0 11.149876] [drm] initializing kernel modesetting (CARRIZO 0x1002=
:0x9874 0x1028:0x07E2 0xCC).<br>[ =C2=A0 11.152265] [drm] register mmio bas=
e: 0xFEA00000<br>[ =C2=A0 11.152271] [drm] register mmio size: 262144<br>[ =
=C2=A0 11.152541] amdgpu 0000:00:01.0: amdgpu: detected ip block number 0 &=
lt;vi_common&gt;<br>[ =C2=A0 11.152549] amdgpu 0000:00:01.0: amdgpu: detect=
ed ip block number 1 &lt;gmc_v8_0&gt;<br>[ =C2=A0 11.152551] amdgpu 0000:00=
:01.0: amdgpu: detected ip block number 2 &lt;cz_ih&gt;<br>[ =C2=A0 11.1525=
53] amdgpu 0000:00:01.0: amdgpu: detected ip block number 3 &lt;gfx_v8_0&gt=
;<br>[ =C2=A0 11.152555] amdgpu 0000:00:01.0: amdgpu: detected ip block num=
ber 4 &lt;sdma_v3_0&gt;<br>[ =C2=A0 11.152556] amdgpu 0000:00:01.0: amdgpu:=
 detected ip block number 5 &lt;powerplay&gt;<br>[ =C2=A0 11.152558] amdgpu=
 0000:00:01.0: amdgpu: detected ip block number 6 &lt;dm&gt;<br>[ =C2=A0 11=
.152560] amdgpu 0000:00:01.0: amdgpu: detected ip block number 7 &lt;uvd_v6=
_0&gt;<br>[ =C2=A0 11.152562] amdgpu 0000:00:01.0: amdgpu: detected ip bloc=
k number 8 &lt;vce_v3_0&gt;<br>[ =C2=A0 11.152563] amdgpu 0000:00:01.0: amd=
gpu: detected ip block number 9 &lt;acp_ip&gt;<br>[ =C2=A0 11.164692] amdgp=
u 0000:00:01.0: amdgpu: Fetched VBIOS from ROM BAR<br>[ =C2=A0 11.164695] a=
mdgpu: ATOM BIOS: 109-C95010-006<br>[ =C2=A0 11.164975] [drm] UVD is enable=
d in physical mode<br>[ =C2=A0 11.164979] [drm] VCE enabled in physical mod=
e<br>[ =C2=A0 11.165030] amdgpu 0000:00:01.0: vgaarb: deactivate vga consol=
e<br>[ =C2=A0 11.165793] Console: switching to colour dummy device 80x25<br=
>[ =C2=A0 11.165807] amdgpu 0000:00:01.0: amdgpu: Trusted Memory Zone (TMZ)=
 feature not supported<br>[ =C2=A0 11.165914] [drm] vm size is 64 GB, 2 lev=
els, block size is 10-bit, fragment size is 9-bit<br>[ =C2=A0 11.165921] am=
dgpu 0000:00:01.0: amdgpu: VRAM: 2048M 0x000000F400000000 - 0x000000F47FFFF=
FFF (2048M used)<br>[ =C2=A0 11.165924] amdgpu 0000:00:01.0: amdgpu: GART: =
1024M 0x000000FF00000000 - 0x000000FF3FFFFFFF<br>[ =C2=A0 11.165934] [drm] =
Detected VRAM RAM=3D2048M, BAR=3D2048M<br>[ =C2=A0 11.165935] [drm] RAM wid=
th 128bits UNKNOWN<br>[ =C2=A0 11.166106] [drm] amdgpu: 2048M of VRAM memor=
y ready<br>[ =C2=A0 11.166109] [drm] amdgpu: 6960M of GTT memory ready.<br>=
[ =C2=A0 11.166138] [drm] GART: num cpu pages 262144, num gpu pages 262144<=
br>[ =C2=A0 11.166191] [drm] PCIE GART of 1024M enabled (table at 0x000000F=
400A00000).<br>[ =C2=A0 11.171004] amdgpu: hwmgr_sw_init smu backed is smu8=
_smu<br>[ =C2=A0 11.172860] [drm] Found UVD firmware Version: 1.91 Family I=
D: 11<br>[ =C2=A0 11.172906] [drm] UVD ENC is disabled<br>[ =C2=A0 11.17464=
6] [drm] Found VCE firmware Version: 52.4 Binary ID: 3<br>[ =C2=A0 11.17611=
3] amdgpu: smu version 27.17.00<br>[ =C2=A0 11.181831] [drm] DM_PPLIB: valu=
es for Engine clock<br>[ =C2=A0 11.181837] [drm] DM_PPLIB: 300000<br>[ =C2=
=A0 11.181838] [drm] DM_PPLIB: 464520<br>[ =C2=A0 11.181839] [drm] DM_PPLIB=
: 576000<br>[ =C2=A0 11.181840] [drm] DM_PPLIB: 654550<br>[ =C2=A0 11.18184=
1] [drm] DM_PPLIB: 720000<br>[ =C2=A0 11.181842] [drm] DM_PPLIB: 800000<br>=
[ =C2=A0 11.181842] [drm] DM_PPLIB: 847060<br>[ =C2=A0 11.181843] [drm] DM_=
PPLIB: 900000<br>[ =C2=A0 11.181844] [drm] DM_PPLIB: Validation clocks:<br>=
[ =C2=A0 11.181845] [drm] DM_PPLIB: =C2=A0 =C2=A0engine_max_clock: 90000<br=
>[ =C2=A0 11.181846] [drm] DM_PPLIB: =C2=A0 =C2=A0memory_max_clock: 120000<=
br>[ =C2=A0 11.181847] [drm] DM_PPLIB: =C2=A0 =C2=A0level =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 : 8<br>[ =C2=A0 11.181848] [drm] DM_PPLIB: values for Dis=
play clock<br>[ =C2=A0 11.181849] [drm] DM_PPLIB: 300000<br>[ =C2=A0 11.181=
850] [drm] DM_PPLIB: 400000<br>[ =C2=A0 11.181851] [drm] DM_PPLIB: 496560<b=
r>[ =C2=A0 11.181852] [drm] DM_PPLIB: 626090<br>[ =C2=A0 11.181852] [drm] D=
M_PPLIB: 685720<br>[ =C2=A0 11.181853] [drm] DM_PPLIB: 757900<br>[ =C2=A0 1=
1.181854] [drm] DM_PPLIB: 800000<br>[ =C2=A0 11.181854] [drm] DM_PPLIB: 847=
060<br>[ =C2=A0 11.181855] [drm] DM_PPLIB: Validation clocks:<br>[ =C2=A0 1=
1.181856] [drm] DM_PPLIB: =C2=A0 =C2=A0engine_max_clock: 90000<br>[ =C2=A0 =
11.181856] [drm] DM_PPLIB: =C2=A0 =C2=A0memory_max_clock: 120000<br>[ =C2=
=A0 11.181857] [drm] DM_PPLIB: =C2=A0 =C2=A0level =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 : 8<br>[ =C2=A0 11.181858] [drm] DM_PPLIB: values for Memory clo=
ck<br>[ =C2=A0 11.181859] [drm] DM_PPLIB: 667000<br>[ =C2=A0 11.181860] [dr=
m] DM_PPLIB: 1200000<br>[ =C2=A0 11.181861] [drm] DM_PPLIB: Validation cloc=
ks:<br>[ =C2=A0 11.181861] [drm] DM_PPLIB: =C2=A0 =C2=A0engine_max_clock: 9=
0000<br>[ =C2=A0 11.181862] [drm] DM_PPLIB: =C2=A0 =C2=A0memory_max_clock: =
120000<br>[ =C2=A0 11.181863] [drm] DM_PPLIB: =C2=A0 =C2=A0level =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 : 8<br>[ =C2=A0 11.181895] [drm:bios_parser_get_co=
nnector_id [amdgpu]] *ERROR* Can&#39;t find connector id 3 in connector tab=
le of size 3.<br>[ =C2=A0 11.183144] [drm:bios_parser_get_connector_id [amd=
gpu]] *ERROR* Can&#39;t find connector id 4 in connector table of size 3.<b=
r>[ =C2=A0 11.184339] [drm:bios_parser_get_connector_id [amdgpu]] *ERROR* C=
an&#39;t find connector id 5 in connector table of size 3.<br>[ =C2=A0 11.1=
85536] [drm:bios_parser_get_connector_id [amdgpu]] *ERROR* Can&#39;t find c=
onnector id 6 in connector table of size 3.<br>[ =C2=A0 11.186737] [drm:bio=
s_parser_get_connector_id [amdgpu]] *ERROR* Can&#39;t find connector id 7 i=
n connector table of size 3.<br>[ =C2=A0 11.187931] [drm:bios_parser_get_co=
nnector_id [amdgpu]] *ERROR* Can&#39;t find connector id 8 in connector tab=
le of size 3.<br>[ =C2=A0 11.189127] [drm:bios_parser_get_connector_id [amd=
gpu]] *ERROR* Can&#39;t find connector id 9 in connector table of size 3.<b=
r>[ =C2=A0 11.190335] [drm:bios_parser_get_connector_id [amdgpu]] *ERROR* C=
an&#39;t find connector id 10 in connector table of size 3.<br>[ =C2=A0 11.=
191544] [drm:bios_parser_get_connector_id [amdgpu]] *ERROR* Can&#39;t find =
connector id 11 in connector table of size 3.<br>[ =C2=A0 11.192746] [drm:b=
ios_parser_get_connector_id [amdgpu]] *ERROR* Can&#39;t find connector id 1=
2 in connector table of size 3.<br>[ =C2=A0 11.193946] [drm:bios_parser_get=
_connector_id [amdgpu]] *ERROR* Can&#39;t find connector id 13 in connector=
 table of size 3.<br>[ =C2=A0 11.195231] [drm] Display Core v3.2.325 initia=
lized on DCE 11.0<br>[ =C2=A0 11.282044] [drm] UVD initialized successfully=
.<br>[ =C2=A0 11.482701] [drm] VCE initialized successfully.<br>[ =C2=A0 11=
.486844] kfd kfd: amdgpu: Allocated 3969056 bytes on gart<br>[ =C2=A0 11.48=
6865] kfd kfd: amdgpu: Total number of KFD nodes to be created: 1<br>[ =C2=
=A0 11.487064] amdgpu: Virtual CRAT table created for GPU<br>[ =C2=A0 11.48=
7125] amdgpu: Topology: Add dGPU node [0x9874:0x1002]<br>[ =C2=A0 11.487128=
] kfd kfd: amdgpu: added device 1002:9874<br>[ =C2=A0 11.487139] amdgpu 000=
0:00:01.0: amdgpu: SE 1, SH per SE 1, CU per SH 8, active_cu_number 8<br>[ =
=C2=A0 11.488968] amdgpu: pp_dpm_get_sclk_od was not implemented.<br>[ =C2=
=A0 11.488971] amdgpu: pp_dpm_get_mclk_od was not implemented.<br>[ =C2=A0 =
11.489094] amdgpu 0000:00:01.0: amdgpu: Runtime PM not available<br>[ =C2=
=A0 11.490757] amdgpu 0000:00:01.0: amdgpu: [drm] Using custom brightness c=
urve<br>[ =C2=A0 11.490977] amdgpu 0000:00:01.0: [drm] Registered 3 planes =
with drm panic<br>[ =C2=A0 11.490980] [drm] Initialized amdgpu 3.63.0 for 0=
000:00:01.0 on minor 0<br>[ =C2=A0 11.498432] fbcon: amdgpudrmfb (fb0) is p=
rimary device<br>[ =C2=A0 12.428917] Console: switching to colour frame buf=
fer device 240x67<br>[ =C2=A0 12.433935] amdgpu 0000:00:01.0: [drm] fb0: am=
dgpudrmfb frame buffer device<br>[ =C2=A0 12.440052] [drm] initializing ker=
nel modesetting (POLARIS11 0x1002:0x67EF 0x1028:0x07E2 0xCF).<br>[ =C2=A0 1=
2.441286] [drm] register mmio base: 0xFE800000<br>[ =C2=A0 12.441288] [drm]=
 register mmio size: 262144<br>[ =C2=A0 12.441478] amdgpu 0000:03:00.0: amd=
gpu: detected ip block number 0 &lt;vi_common&gt;<br>[ =C2=A0 12.441481] am=
dgpu 0000:03:00.0: amdgpu: detected ip block number 1 &lt;gmc_v8_0&gt;<br>[=
 =C2=A0 12.441483] amdgpu 0000:03:00.0: amdgpu: detected ip block number 2 =
&lt;tonga_ih&gt;<br>[ =C2=A0 12.441485] amdgpu 0000:03:00.0: amdgpu: detect=
ed ip block number 3 &lt;gfx_v8_0&gt;<br>[ =C2=A0 12.441487] amdgpu 0000:03=
:00.0: amdgpu: detected ip block number 4 &lt;sdma_v3_0&gt;<br>[ =C2=A0 12.=
441496] amdgpu 0000:03:00.0: amdgpu: detected ip block number 5 &lt;powerpl=
ay&gt;<br>[ =C2=A0 12.441498] amdgpu 0000:03:00.0: amdgpu: detected ip bloc=
k number 6 &lt;dm&gt;<br>[ =C2=A0 12.441500] amdgpu 0000:03:00.0: amdgpu: d=
etected ip block number 7 &lt;uvd_v6_0&gt;<br>[ =C2=A0 12.441501] amdgpu 00=
00:03:00.0: amdgpu: detected ip block number 8 &lt;vce_v3_0&gt;<br>[ =C2=A0=
 12.557053] amdgpu 0000:03:00.0: amdgpu: Fetched VBIOS from ATRM<br>[ =C2=
=A0 12.557062] amdgpu: ATOM BIOS: SWBRT01017.001<br>[ =C2=A0 12.557376] [dr=
m] UVD is enabled in VM mode<br>[ =C2=A0 12.557378] [drm] UVD ENC is enable=
d in VM mode<br>[ =C2=A0 12.557381] [drm] VCE enabled in VM mode<br>[ =C2=
=A0 12.557393] amdgpu 0000:03:00.0: amdgpu: Trusted Memory Zone (TMZ) featu=
re not supported<br>[ =C2=A0 12.557397] amdgpu 0000:03:00.0: amdgpu: PCIE a=
tomic ops is not supported<br>[ =C2=A0 12.557406] [drm] GPU posting now...<=
br>[ =C2=A0 12.568644] [drm] vm size is 64 GB, 2 levels, block size is 10-b=
it, fragment size is 9-bit<br>[ =C2=A0 12.568987] amdgpu 0000:03:00.0: BAR =
2 [mem 0xf0000000-0xf01fffff 64bit pref]: releasing<br>[ =C2=A0 12.568992] =
amdgpu 0000:03:00.0: BAR 0 [mem 0xe0000000-0xefffffff 64bit pref]: releasin=
g<br>[ =C2=A0 12.569004] pcieport 0000:00:03.1: bridge window [mem 0xe00000=
00-0xf01fffff 64bit pref]: releasing<br>[ =C2=A0 12.569013] pcieport 0000:0=
0:03.1: bridge window [mem 0x480000000-0x5ffffffff 64bit pref]: assigned<br=
>[ =C2=A0 12.569016] amdgpu 0000:03:00.0: BAR 0 [mem 0x500000000-0x5fffffff=
f 64bit pref]: assigned<br>[ =C2=A0 12.569025] amdgpu 0000:03:00.0: BAR 2 [=
mem 0x480000000-0x4801fffff 64bit pref]: assigned<br>[ =C2=A0 12.569034] pc=
ieport 0000:00:03.1: PCI bridge to [bus 03]<br>[ =C2=A0 12.569037] pcieport=
 0000:00:03.1: =C2=A0 bridge window [io =C2=A00xd000-0xdfff]<br>[ =C2=A0 12=
.569041] pcieport 0000:00:03.1: =C2=A0 bridge window [mem 0xfe800000-0xfe8f=
ffff]<br>[ =C2=A0 12.569044] pcieport 0000:00:03.1: =C2=A0 bridge window [m=
em 0x480000000-0x5ffffffff 64bit pref]<br>[ =C2=A0 12.569052] amdgpu 0000:0=
3:00.0: amdgpu: VRAM: 4096M 0x000000F400000000 - 0x000000F4FFFFFFFF (4096M =
used)<br>[ =C2=A0 12.569054] amdgpu 0000:03:00.0: amdgpu: GART: 256M 0x0000=
00FF00000000 - 0x000000FF0FFFFFFF<br>[ =C2=A0 12.569068] [drm] Detected VRA=
M RAM=3D4096M, BAR=3D4096M<br>[ =C2=A0 12.569070] [drm] RAM width 128bits G=
DDR5<br>[ =C2=A0 12.569196] [drm] amdgpu: 4096M of VRAM memory ready<br>[ =
=C2=A0 12.569199] [drm] amdgpu: 6960M of GTT memory ready.<br>[ =C2=A0 12.5=
69235] [drm] GART: num cpu pages 65536, num gpu pages 65536<br>[ =C2=A0 12.=
569964] [drm] PCIE GART of 256M enabled (table at 0x000000F4FFF80000).<br>[=
 =C2=A0 12.571318] [drm] Chained IB support enabled!<br>[ =C2=A0 12.574548]=
 amdgpu: hwmgr_sw_init smu backed is polaris10_smu<br>[ =C2=A0 12.577033] [=
drm] Found UVD firmware Version: 1.130 Family ID: 16<br>[ =C2=A0 12.578921]=
 [drm] Found VCE firmware Version: 53.26 Binary ID: 3<br>[ =C2=A0 12.911076=
] [drm] Display Core v3.2.325 initialized on DCE 11.2<br>[ =C2=A0 12.960744=
] [drm] UVD and UVD ENC initialized successfully.<br>[ =C2=A0 13.071674] [d=
rm] VCE initialized successfully.<br>[ =C2=A0 13.072500] kfd kfd: amdgpu: s=
kipped device 1002:67ef, PCI rejects atomics 730&lt;0<br>[ =C2=A0 13.072515=
] amdgpu 0000:03:00.0: amdgpu: SE 2, SH per SE 1, CU per SH 8, active_cu_nu=
mber 14<br>[ =C2=A0 13.076889] amdgpu 0000:03:00.0: amdgpu: Using ATPX for =
runtime pm<br>[ =C2=A0 13.077203] amdgpu 0000:03:00.0: [drm] Registered 5 p=
lanes with drm panic<br>[ =C2=A0 13.077206] [drm] Initialized amdgpu 3.63.0=
 for 0000:03:00.0 on minor 1<br>[ =C2=A0 13.246645] ISO 9660 Extensions: Mi=
crosoft Joliet Level 3<br>[ =C2=A0 13.247455] ISO 9660 Extensions: RRIP_199=
1A<br>[ =C2=A0 38.703983] loop: module loaded<br>[ =C2=A0 38.704839] loop0:=
 detected capacity change from 0 to 1930608<br>[ =C2=A0 38.728074] squashfs=
: version 4.0 (2009/01/31) Phillip Lougher<br>[ =C2=A0 38.752721] overlayfs=
: &quot;xino&quot; feature enabled using 2 upper inode bits.<br>[ =C2=A0 39=
.796919] systemd[1]: systemd 257.7-1-arch running in system mode (+PAM +AUD=
IT -SELINUX -APPARMOR -IMA +IPE +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +A=
CL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIB=
CRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZI=
P2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +BTF +XKBCOMMON +UTMP -SYSVINIT +LIB=
ARCHIVE)<br>[ =C2=A0 39.796930] systemd[1]: Detected architecture x86-64.<b=
r>[ =C2=A0 39.823976] systemd[1]: Detected first boot.<br>[ =C2=A0 39.85178=
5] systemd[1]: Hostname set to &lt;archiso&gt;.<br>[ =C2=A0 39.853192] syst=
emd[1]: Initializing machine ID from random generator.<br>[ =C2=A0 40.05228=
1] systemd[1]: bpf-restrict-fs: LSM BPF program attached<br>[ =C2=A0 40.976=
009] systemd[1]: Populated /etc with preset unit settings.<br>[ =C2=A0 41.2=
49961] systemd[1]: Queued start job for default target Graphical Interface.=
<br>[ =C2=A0 41.281971] systemd[1]: Created slice Slice /system/dirmngr.<br=
>[ =C2=A0 41.282882] systemd[1]: Created slice Slice /system/getty.<br>[ =
=C2=A0 41.284648] systemd[1]: Created slice Slice /system/gpg-agent.<br>[ =
=C2=A0 41.285841] systemd[1]: Created slice Slice /system/gpg-agent-browser=
.<br>[ =C2=A0 41.286996] systemd[1]: Created slice Slice /system/gpg-agent-=
extra.<br>[ =C2=A0 41.287716] systemd[1]: Created slice Slice /system/gpg-a=
gent-ssh.<br>[ =C2=A0 41.288318] systemd[1]: Created slice Slice /system/ke=
yboxd.<br>[ =C2=A0 41.288918] systemd[1]: Created slice Slice /system/modpr=
obe.<br>[ =C2=A0 41.289315] systemd[1]: Created slice User and Session Slic=
e.<br>[ =C2=A0 41.289436] systemd[1]: Started Dispatch Password Requests to=
 Console Directory Watch.<br>[ =C2=A0 41.289525] systemd[1]: Started Forwar=
d Password Requests to Wall Directory Watch.<br>[ =C2=A0 41.289755] systemd=
[1]: Set up automount Arbitrary Executable File Formats File System Automou=
nt Point.<br>[ =C2=A0 41.289838] systemd[1]: Reached target Local Encrypted=
 Volumes.<br>[ =C2=A0 41.289893] systemd[1]: Reached target Local Integrity=
 Protected Volumes.<br>[ =C2=A0 41.289957] systemd[1]: Reached target Path =
Units.<br>[ =C2=A0 41.290003] systemd[1]: Reached target Remote Encrypted V=
olumes.<br>[ =C2=A0 41.290046] systemd[1]: Reached target Remote File Syste=
ms.<br>[ =C2=A0 41.290088] systemd[1]: Reached target Slice Units.<br>[ =C2=
=A0 41.290133] systemd[1]: Reached target Swaps.<br>[ =C2=A0 41.290194] sys=
temd[1]: Reached target Local Verity Protected Volumes.<br>[ =C2=A0 41.2903=
45] systemd[1]: Listening on Device-mapper event daemon FIFOs.<br>[ =C2=A0 =
41.290505] systemd[1]: Listening on LVM2 poll daemon socket.<br>[ =C2=A0 41=
.293056] systemd[1]: Listening on Process Core Dump Socket.<br>[ =C2=A0 41.=
295092] systemd[1]: Listening on Credential Encryption/Decryption.<br>[ =C2=
=A0 41.296255] systemd[1]: Listening on Journal Audit Socket.<br>[ =C2=A0 4=
1.297215] systemd[1]: Listening on Journal Socket (/dev/log).<br>[ =C2=A0 4=
1.298197] systemd[1]: Listening on Journal Sockets.<br>[ =C2=A0 41.299149] =
systemd[1]: Listening on DDI File System Mounter Socket.<br>[ =C2=A0 41.300=
153] systemd[1]: Listening on Network Service Netlink Socket.<br>[ =C2=A0 4=
1.301089] systemd[1]: Listening on Namespace Resource Manager Socket.<br>[ =
=C2=A0 41.302717] systemd[1]: TPM PCR Measurements was skipped because of a=
n unmet condition check (ConditionSecurity=3Dmeasured-uki).<br>[ =C2=A0 41.=
302752] systemd[1]: Make TPM PCR Policy was skipped because of an unmet con=
dition check (ConditionSecurity=3Dmeasured-uki).<br>[ =C2=A0 41.302983] sys=
temd[1]: Listening on udev Control Socket.<br>[ =C2=A0 41.304020] systemd[1=
]: Listening on udev Kernel Socket.<br>[ =C2=A0 41.304977] systemd[1]: List=
ening on User Database Manager Socket.<br>[ =C2=A0 41.334376] systemd[1]: M=
ounting Huge Pages File System...<br>[ =C2=A0 41.336423] systemd[1]: Mounti=
ng POSIX Message Queue File System...<br>[ =C2=A0 41.338750] systemd[1]: Mo=
unting Kernel Debug File System...<br>[ =C2=A0 41.341644] systemd[1]: Mount=
ing Kernel Trace File System...<br>[ =C2=A0 41.352931] systemd[1]: Mounting=
 Temporary Directory /tmp...<br>[ =C2=A0 41.388053] systemd[1]: Starting Cr=
eate List of Static Device Nodes...<br>[ =C2=A0 41.392292] systemd[1]: Star=
ting Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress =
polling...<br>[ =C2=A0 41.404000] systemd[1]: Starting Load Kernel Module c=
onfigfs...<br>[ =C2=A0 41.408710] systemd[1]: Starting Load Kernel Module d=
m_mod...<br>[ =C2=A0 41.412758] systemd[1]: Starting Load Kernel Module drm=
...<br>[ =C2=A0 41.416714] systemd[1]: Starting Load Kernel Module efi_psto=
re...<br>[ =C2=A0 41.420542] systemd[1]: Starting Load Kernel Module fuse..=
.<br>[ =C2=A0 41.424746] systemd[1]: Starting Load Kernel Module loop...<br=
>[ =C2=A0 41.425545] systemd[1]: Clear Stale Hibernate Storage Info was ski=
pped because of an unmet condition check (ConditionPathExists=3D/sys/firmwa=
re/efi/efivars/HibernateLocation-8cf2644b-4b0b-428f-9387-6d876050dc67).<br>=
[ =C2=A0 41.427870] systemd[1]: Starting Journal Service...<br>[ =C2=A0 41.=
478513] device-mapper: uevent: version 1.0.3<br>[ =C2=A0 41.478617] device-=
mapper: ioctl: 4.49.0-ioctl (2025-01-17) initialised:=C2=A0<a href=3D"mailt=
o:dm-devel@lists.linux.dev" target=3D"_blank">dm-devel@lists.linux.dev</a><=
br>[ =C2=A0 41.496155] systemd[1]: Starting Load Kernel Modules...<br>[ =C2=
=A0 41.499380] systemd[1]: Starting Generate network units from Kernel comm=
and line...<br>[ =C2=A0 41.500151] systemd[1]: TPM PCR Machine ID Measureme=
nt was skipped because of an unmet condition check (ConditionSecurity=3Dmea=
sured-uki).<br>[ =C2=A0 41.505724] systemd[1]: Starting Remount Root and Ke=
rnel File Systems...<br>[ =C2=A0 41.510052] systemd[1]: Starting Wait Until=
 Kernel Time Synchronized...<br>[ =C2=A0 41.512642] systemd[1]: Early TPM S=
RK Setup was skipped because of an unmet condition check (ConditionSecurity=
=3Dmeasured-uki).<br>[ =C2=A0 41.517044] systemd[1]: Starting Load udev Rul=
es from Credentials...<br>[ =C2=A0 41.523720] systemd[1]: Starting Coldplug=
 All udev Devices...<br>[ =C2=A0 41.529298] systemd[1]: Mounted Huge Pages =
File System.<br>[ =C2=A0 41.530141] systemd[1]: Mounted POSIX Message Queue=
 File System.<br>[ =C2=A0 41.530969] systemd[1]: Mounted Kernel Debug File =
System.<br>[ =C2=A0 41.531777] systemd[1]: Mounted Kernel Trace File System=
.<br>[ =C2=A0 41.532578] systemd[1]: Mounted Temporary Directory /tmp.<br>[=
 =C2=A0 41.533598] systemd[1]: Finished Create List of Static Device Nodes.=
<br>[ =C2=A0 41.534700] systemd[1]: modprobe@configfs.service: Deactivated =
successfully.<br>[ =C2=A0 41.534952] systemd[1]: Finished Load Kernel Modul=
e configfs.<br>[ =C2=A0 41.536271] systemd[1]: modprobe@dm_mod.service: Dea=
ctivated successfully.<br>[ =C2=A0 41.536511] systemd[1]: Finished Load Ker=
nel Module dm_mod.<br>[ =C2=A0 41.537667] systemd[1]: modprobe@drm.service:=
 Deactivated successfully.<br>[ =C2=A0 41.537873] systemd[1]: Finished Load=
 Kernel Module drm.<br>[ =C2=A0 41.538924] systemd[1]: modprobe@efi_pstore.=
service: Deactivated successfully.<br>[ =C2=A0 41.539163] systemd[1]: Finis=
hed Load Kernel Module efi_pstore.<br>[ =C2=A0 41.540144] systemd[1]: modpr=
obe@fuse.service: Deactivated successfully.<br>[ =C2=A0 41.540351] systemd[=
1]: Finished Load Kernel Module fuse.<br>[ =C2=A0 41.541396] systemd[1]: mo=
dprobe@loop.service: Deactivated successfully.<br>[ =C2=A0 41.541886] syste=
md[1]: Finished Load Kernel Module loop.<br>[ =C2=A0 41.543999] systemd[1]:=
 Mounting FUSE Control File System...<br>[ =C2=A0 41.545733] systemd[1]: Mo=
unting Kernel Configuration File System...<br>[ =C2=A0 41.637133] systemd[1=
]: Repartition Root Disk was skipped because no trigger condition checks we=
re met.<br>[ =C2=A0 41.638535] systemd[1]: Starting Create Static Device No=
des in /dev gracefully...<br>[ =C2=A0 41.642840] systemd[1]: Finished Gener=
ate network units from Kernel command line.<br>[ =C2=A0 41.644718] systemd[=
1]: Finished Remount Root and Kernel File Systems.<br>[ =C2=A0 41.645605] s=
ystemd[1]: Mounted FUSE Control File System.<br>[ =C2=A0 41.646435] systemd=
[1]: Mounted Kernel Configuration File System.<br>[ =C2=A0 41.647297] syste=
md[1]: Reached target Preparation for Network.<br>[ =C2=A0 41.655628] syste=
md-journald[532]: Collecting audit messages is enabled.<br>[ =C2=A0 41.7570=
73] systemd[1]: Rebuild Hardware Database was skipped because no trigger co=
ndition checks were met.<br>[ =C2=A0 41.757166] systemd[1]: Platform Persis=
tent Storage Archival was skipped because of an unmet condition check (Cond=
itionDirectoryNotEmpty=3D/sys/fs/pstore).<br>[ =C2=A0 41.760184] systemd[1]=
: Starting Load/Save OS Random Seed...<br>[ =C2=A0 41.763578] systemd[1]: T=
PM SRK Setup was skipped because of an unmet condition check (ConditionSecu=
rity=3Dmeasured-uki).<br>[ =C2=A0 41.764402] systemd[1]: Started Journal Se=
rvice.<br>[ =C2=A0 41.765310] audit: type=3D1130 audit(1770273939.755:2): p=
id=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D&#39;unit=3Dsystemd=
-journald comm=3D&quot;systemd&quot; exe=3D&quot;/usr/lib/systemd/systemd&q=
uot; hostname=3D? addr=3D? terminal=3D? res=3Dsuccess&#39;<br>[ =C2=A0 41.7=
77524] audit: type=3D1130 audit(1770273939.767:3): pid=3D1 uid=3D0 auid=3D4=
294967295 ses=3D4294967295 msg=3D&#39;unit=3Dsystemd-udev-load-credentials =
comm=3D&quot;systemd&quot; exe=3D&quot;/usr/lib/systemd/systemd&quot; hostn=
ame=3D? addr=3D? terminal=3D? res=3Dsuccess&#39;<br>[ =C2=A0 41.805393] Asy=
mmetric key parser &#39;pkcs8&#39; registered<br>[ =C2=A0 41.807525] audit:=
 type=3D1130 audit(1770273939.797:4): pid=3D1 uid=3D0 auid=3D4294967295 ses=
=3D4294967295 msg=3D&#39;unit=3Dsystemd-modules-load comm=3D&quot;systemd&q=
uot; exe=3D&quot;/usr/lib/systemd/systemd&quot; hostname=3D? addr=3D? termi=
nal=3D? res=3Dsuccess&#39;<br>[ =C2=A0 41.892147] audit: type=3D1130 audit(=
1770273939.882:5): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 msg=
=3D&#39;unit=3Dsystemd-random-seed comm=3D&quot;systemd&quot; exe=3D&quot;/=
usr/lib/systemd/systemd&quot; hostname=3D? addr=3D? terminal=3D? res=3Dsucc=
ess&#39;<br>[ =C2=A0 41.902735] audit: type=3D1130 audit(1770273939.893:6):=
 pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D&#39;unit=3Dsyste=
md-udev-trigger comm=3D&quot;systemd&quot; exe=3D&quot;/usr/lib/systemd/sys=
temd&quot; hostname=3D? addr=3D? terminal=3D? res=3Dsuccess&#39;<br>[ =C2=
=A0 41.986332] systemd-journald[532]: Received client request to flush runt=
ime journal.<br>[ =C2=A0 41.989019] audit: type=3D1130 audit(1770273939.979=
:7): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D&#39;unit=3Ds=
ystemd-journal-flush comm=3D&quot;systemd&quot; exe=3D&quot;/usr/lib/system=
d/systemd&quot; hostname=3D? addr=3D? terminal=3D? res=3Dsuccess&#39;<br>[ =
=C2=A0 42.044719] audit: type=3D1130 audit(1770273940.035:8): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D&#39;unit=3Dsystemd-sysctl co=
mm=3D&quot;systemd&quot; exe=3D&quot;/usr/lib/systemd/systemd&quot; hostnam=
e=3D? addr=3D? terminal=3D? res=3Dsuccess&#39;<br>[ =C2=A0 42.070815] audit=
: type=3D1334 audit(1770273940.061:9): prog-id=3D25 op=3DLOAD<br>[ =C2=A0 4=
2.070922] audit: type=3D1334 audit(1770273940.061:10): prog-id=3D26 op=3DLO=
AD<br>[ =C2=A0 42.070954] audit: type=3D1334 audit(1770273940.061:11): prog=
-id=3D27 op=3DLOAD<br>[ =C2=A0 43.619692] cfg80211: Loading compiled-in X.5=
09 certificates for regulatory database<br>[ =C2=A0 43.627913] r8169 0000:0=
2:00.0 enp2s0: renamed from eth0<br>[ =C2=A0 43.677599] Loaded X.509 cert &=
#39;sforshee: 00b28ddf47aef9cea7&#39;<br>[ =C2=A0 43.677819] Loaded X.509 c=
ert &#39;wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600&#39;<br>[ =C2=A0 43=
.697124] input: DELL Wireless hotkeys as /devices/virtual/input/input19<br>=
[ =C2=A0 43.737974] dcdbas dcdbas: Dell Systems Management Base Driver (ver=
sion 5.6.0-3.4)<br>[ =C2=A0 43.745928] dell-smbios A80593CE-A997-11DA-B012-=
B622A1EF5492: WMI SMBIOS userspace interface not supported(0), try upgradin=
g to a newer BIOS<br>[ =C2=A0 43.816760] piix4_smbus 0000:00:14.0: SMBus Ho=
st Controller at 0xb00, revision 0<br>[ =C2=A0 43.816768] piix4_smbus 0000:=
00:14.0: Using register 0x02 for SMBus port selection<br>[ =C2=A0 43.817734=
] i2c i2c-5: Successfully instantiated SPD at 0x50<br>[ =C2=A0 43.818332] i=
2c i2c-5: Successfully instantiated SPD at 0x51<br>[ =C2=A0 43.818396] piix=
4_smbus 0000:00:14.0: Auxiliary SMBus Host Controller at 0xb20<br>[ =C2=A0 =
43.840460] input: PC Speaker as /devices/platform/pcspkr/input/input21<br>[=
 =C2=A0 43.937251] input: ELAN1010:00 04F3:3012 Mouse as /devices/platform/=
AMD0010:00/i2c-0/i2c-ELAN1010:00/0018:04F3:3012.0001/input/input22<br>[ =C2=
=A0 43.937466] input: ELAN1010:00 04F3:3012 Touchpad as /devices/platform/A=
MD0010:00/i2c-0/i2c-ELAN1010:00/0018:04F3:3012.0001/input/input23<br>[ =C2=
=A0 43.937555] hid-generic 0018:04F3:3012.0001: input,hidraw0: I2C HID v1.0=
0 Mouse [ELAN1010:00 04F3:3012] on i2c-ELAN1010:00<br>[ =C2=A0 44.100710] p=
smouse serio1: elantech: assuming hardware version 4 (with firmware version=
 0x4d5f02)<br>[ =C2=A0 44.113931] psmouse serio1: elantech: Synaptics capab=
ilities query result 0x00, 0x15, 0x10.<br>[ =C2=A0 44.127739] psmouse serio=
1: elantech: Elan sample query result 0c, 02, 75<br>[ =C2=A0 44.205227] inp=
ut: ETPS/2 Elantech Touchpad as /devices/platform/i8042/serio1/input/input2=
0<br>[ =C2=A0 44.254176] input: Dell WMI hotkeys as /devices/platform/PNP0C=
14:00/wmi_bus/wmi_bus-PNP0C14:00/9DBB5994-A997-11DA-B012-B622A1EF5492/input=
/input24<br>[ =C2=A0 44.254735] Bluetooth: Core ver 2.22<br>[ =C2=A0 44.254=
779] NET: Registered PF_BLUETOOTH protocol family<br>[ =C2=A0 44.254781] Bl=
uetooth: HCI device and connection manager initialized<br>[ =C2=A0 44.25478=
7] Bluetooth: HCI socket layer initialized<br>[ =C2=A0 44.254790] Bluetooth=
: L2CAP socket layer initialized<br>[ =C2=A0 44.254794] Bluetooth: SCO sock=
et layer initialized<br>[ =C2=A0 44.299869] mousedev: PS/2 mouse device com=
mon for all mice<br>[ =C2=A0 44.412234] input: ELAN1010:00 04F3:3012 Mouse =
as /devices/platform/AMD0010:00/i2c-0/i2c-ELAN1010:00/0018:04F3:3012.0001/i=
nput/input25<br>[ =C2=A0 44.413714] input: ELAN1010:00 04F3:3012 Touchpad a=
s /devices/platform/AMD0010:00/i2c-0/i2c-ELAN1010:00/0018:04F3:3012.0001/in=
put/input26<br>[ =C2=A0 44.414881] hid-multitouch 0018:04F3:3012.0001: inpu=
t,hidraw0: I2C HID v1.00 Mouse [ELAN1010:00 04F3:3012] on i2c-ELAN1010:00<b=
r>[ =C2=A0 44.424240] usbcore: registered new interface driver btusb<br>[ =
=C2=A0 44.428215] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver<br>[ =
=C2=A0 44.428339] sp5100-tco sp5100-tco: Using 0xfed80b00 for watchdog MMIO=
 address<br>[ =C2=A0 44.428345] sp5100-tco sp5100-tco: Watchdog hardware is=
 disabled<br>[ =C2=A0 44.609556] Bluetooth: hci0: using rampatch file: qca/=
rampatch_usb_00000302.bin<br>[ =C2=A0 44.609564] Bluetooth: hci0: QCA: patc=
h rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111<br>[ =C2=A0 44.64=
4988] ee1004 5-0050: 512 byte EE1004-compliant SPD EEPROM, read-only<br>[ =
=C2=A0 44.646910] ee1004 5-0051: 512 byte EE1004-compliant SPD EEPROM, read=
-only<br>[ =C2=A0 44.741832] ath10k_pci 0000:01:00.0: pci irq msi oper_irq_=
mode 2 irq_mode 0 reset_mode 0<br>[ =C2=A0 44.793889] snd_hda_intel 0000:00=
:01.1: Force to non-snoop mode<br>[ =C2=A0 44.836727] snd_hda_intel 0000:00=
:01.1: bound 0000:00:01.0 (ops amdgpu_dm_audio_component_bind_ops [amdgpu])=
<br>[ =C2=A0 44.849685] input: HDA ATI HDMI HDMI/DP,pcm=3D3 as /devices/pci=
0000:00/0000:00:01.1/sound/card0/input27<br>[ =C2=A0 44.877404] snd_hda_cod=
ec_realtek hdaudioC1D0: ALC3246: picked fixup =C2=A0(pin match)<br>[ =C2=A0=
 44.910881] snd_hda_codec_realtek hdaudioC1D0: autoconfig for ALC3246: line=
_outs=3D1 (0x14/0x0/0x0/0x0/0x0) type:speaker<br>[ =C2=A0 44.910896] snd_hd=
a_codec_realtek hdaudioC1D0: =C2=A0 =C2=A0speaker_outs=3D0 (0x0/0x0/0x0/0x0=
/0x0)<br>[ =C2=A0 44.910899] snd_hda_codec_realtek hdaudioC1D0: =C2=A0 =C2=
=A0hp_outs=3D1 (0x21/0x0/0x0/0x0/0x0)<br>[ =C2=A0 44.910902] snd_hda_codec_=
realtek hdaudioC1D0: =C2=A0 =C2=A0mono: mono_out=3D0x0<br>[ =C2=A0 44.91090=
4] snd_hda_codec_realtek hdaudioC1D0: =C2=A0 =C2=A0inputs:<br>[ =C2=A0 44.9=
10905] snd_hda_codec_realtek hdaudioC1D0: =C2=A0 =C2=A0 =C2=A0Internal Mic=
=3D0x12<br>[ =C2=A0 44.910907] snd_hda_codec_realtek hdaudioC1D0: =C2=A0 =
=C2=A0 =C2=A0Headset Mic=3D0x19<br>[ =C2=A0 44.910910] snd_hda_codec_realte=
k hdaudioC1D0: =C2=A0 =C2=A0 =C2=A0Headphone Mic=3D0x1a<br>[ =C2=A0 44.9326=
11] wl: loading out-of-tree module taints kernel.<br>[ =C2=A0 44.932621] wl=
: module license &#39;MIXED/Proprietary&#39; taints kernel.<br>[ =C2=A0 44.=
932622] Disabling lock debugging due to kernel taint<br>[ =C2=A0 44.932624]=
 wl: module verification failed: signature and/or required key missing - ta=
inting kernel<br>[ =C2=A0 44.932625] wl: module license taints kernel.<br>[=
 =C2=A0 44.976558] You are using the broadcom-wl driver, which is not maint=
ained and is incompatible with Linux kernel security mitigations. It is hea=
vily recommended to replace the hardware and remove the driver. Proceed at =
your own risk!<br>[ =C2=A0 44.976566] ------------[ cut here ]------------<=
br>[ =C2=A0 44.976568] Unpatched return thunk in use. This should not happe=
n!<br>[ =C2=A0 44.976573] WARNING: CPU: 1 PID: 637 at arch/x86/kernel/cpu/b=
ugs.c:3230 __warn_thunk+0x2a/0x40<br>[ =C2=A0 44.976583] Modules linked in:=
 wl(POE+) kvm snd_hda_codec_realtek(+) snd_hda_codec_generic snd_hda_scodec=
_component irqbypass snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_=
intel_sdw_acpi dell_pc ath10k_pci snd_ctl_led snd_hda_codec snd_hda_core sn=
d_hwdep ath10k_core snd_pcm snd_timer ath ee1004 snd polyval_clmulni soundc=
ore platform_profile mac80211 rtsx_usb_ms libarc4 polyval_generic sp5100_tc=
o dell_laptop btusb joydev hid_multitouch memstick mousedev ghash_clmulni_i=
ntel btrtl btintel btbcm btmtk dell_wmi dell_smm_hwmon bluetooth sparse_key=
map sha1_ssse3 pcspkr i2c_piix4 i2c_hid_acpi dell_smbios dcdbas dell_wmi_de=
scriptor dell_rbtn psmouse wmi_bmof i2c_hid i2c_smbus fam15h_power k10temp =
cfg80211 mac_hid rfkill pkcs8_key_parser dm_mod nfnetlink ip_tables x_table=
s overlay squashfs loop isofs cdrom amdgpu amdxcp gpu_sched rtsx_usb_sdmmc =
drm_panel_backlight_quirks drm_buddy mmc_core drm_exec sha512_ssse3 drm_sub=
alloc_helper sha256_ssse3 r8169 drm_ttm_helper aesni_intel realtek ttm cryp=
to_simd cryptd i2c_algo_bit<br>[ =C2=A0 44.976646] =C2=A0mdio_devres uas se=
rio_raw rtsx_usb drm_display_helper libphy usb_storage cec video wmi<br>[ =
=C2=A0 44.976657] CPU: 1 UID: 0 PID: 637 Comm: (udev-worker) Tainted: P =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OE =C2=A0 =C2=A0 =C2=A0 6.15.4-arch2-1 #1 P=
REEMPT(full) =C2=A0bf56011d6043294f437da1888a30a6d02e6dd116<br>[ =C2=A0 44.=
976663] Tainted: [P]=3DPROPRIETARY_MODULE, [O]=3DOOT_MODULE, [E]=3DUNSIGNED=
_MODULE<br>[ =C2=A0 44.976665] Hardware name: Dell Inc. Inspiron 5576/0JW8X=
C, BIOS 1.0.7 01/29/2018<br>[ =C2=A0 44.976675] RIP: 0010:__warn_thunk+0x2a=
/0x40<br>[ =C2=A0 44.976679] Code: 66 0f 1f 00 0f 1f 44 00 00 80 3d 8c 23 5=
9 02 00 74 05 e9 59 05 04 01 48 c7 c7 d8 89 59 96 c6 05 77 23 59 02 01 e8 e=
6 bc 06 00 &lt;0f&gt; 0b e9 3f 05 04 01 66 2e 0f 1f 84 00 00 00 00 00 0f 1f=
 44 00 00<br>[ =C2=A0 44.976681] RSP: 0018:ffffd08642e8fbb8 EFLAGS: 0001024=
6<br>[ =C2=A0 44.976684] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0=
000000000000027<br>[ =C2=A0 44.976685] RDX: ffff8c59a0c9cbc8 RSI: 000000000=
0000001 RDI: ffff8c59a0c9cbc0<br>[ =C2=A0 44.976687] RBP: ffffd08642e8fc08 =
R08: 0000000000000000 R09: 00000000ffffefff<br>[ =C2=A0 44.976688] R10: fff=
fffff97060f20 R11: ffffd08642e8fa50 R12: ffffffffc26a9b05<br>[ =C2=A0 44.97=
6690] R13: ffffffffc0ffc010 R14: 00007f2ff056d2f2 R15: 0000000000000000<br>=
[ =C2=A0 44.976692] FS: =C2=A000007f2ff2053880(0000) GS:ffff8c5a08faf000(00=
00) knlGS:0000000000000000<br>[ =C2=A0 44.976694] CS: =C2=A00010 DS: 0000 E=
S: 0000 CR0: 0000000080050033<br>[ =C2=A0 44.976695] CR2: 00007fb941b1a000 =
CR3: 0000000119d1b000 CR4: 00000000001506f0<br>[ =C2=A0 44.976697] Call Tra=
ce:<br>[ =C2=A0 44.976700] =C2=A0&lt;TASK&gt;<br>[ =C2=A0 44.976701] =C2=A0=
warn_thunk_thunk+0x16/0x30<br>[ =C2=A0 44.976714] =C2=A0getvar+0x20/0x70 [w=
l 549af82e86b3a0529f547b91bef45f08130629c2]<br>[ =C2=A0 44.976790] =C2=A0? =
__UNIQUE_ID_vermagic475+0x2f797d40943c/0x2f797d40943c [wl 549af82e86b3a0529=
f547b91bef45f08130629c2]<br>[ =C2=A0 44.976826] =C2=A0wl_module_init+0x23/0=
xb0 [wl 549af82e86b3a0529f547b91bef45f08130629c2]<br>[ =C2=A0 44.976861] =
=C2=A0? do_one_initcall+0x5b/0x300<br>[ =C2=A0 44.976865] =C2=A0? do_init_m=
odule+0x62/0x240<br>[ =C2=A0 44.976870] =C2=A0? init_module_from_file+0x8a/=
0xe0<br>[ =C2=A0 44.976874] =C2=A0? idempotent_init_module+0x114/0x310<br>[=
 =C2=A0 44.976878] =C2=A0? __x64_sys_finit_module+0x67/0xc0<br>[ =C2=A0 44.=
976881] =C2=A0? do_syscall_64+0x7b/0x810<br>[ =C2=A0 44.976887] =C2=A0? swi=
tch_fpu_return+0x4e/0xd0<br>[ =C2=A0 44.976890] =C2=A0? arch_exit_to_user_m=
ode_prepare.isra.0+0x7c/0x90<br>[ =C2=A0 44.976892] =C2=A0? syscall_exit_to=
_user_mode+0x37/0x1c0<br>[ =C2=A0 44.976895] =C2=A0? do_syscall_64+0x87/0x8=
10<br>[ =C2=A0 44.976897] =C2=A0? irqentry_exit_to_user_mode+0x2c/0x1b0<br>=
[ =C2=A0 44.976900] =C2=A0? entry_SYSCALL_64_after_hwframe+0x76/0x7e<br>[ =
=C2=A0 44.976904] =C2=A0&lt;/TASK&gt;<br>[ =C2=A0 44.976905] ---[ end trace=
 0000000000000000 ]---<br>[ =C2=A0 45.062865] Bluetooth: hci0: using NVM fi=
le: qca/nvm_usb_00000302.bin<br>[ =C2=A0 45.085789] Bluetooth: hci0: HCI En=
hanced Setup Synchronous Connection command is advertised, but not supporte=
d.<br>[ =C2=A0 45.088568] ath10k_pci 0000:01:00.0: qca9377 hw1.1 target 0x0=
5020001 chip_id 0x003821ff sub 1028:1810<br>[ =C2=A0 45.088576] ath10k_pci =
0000:01:00.0: kconfig debug 1 debugfs 1 tracing 1 dfs 0 testmode 0<br>[ =C2=
=A0 45.088699] ath10k_pci 0000:01:00.0: firmware ver WLAN.TF.2.1-00021-QCAR=
MSWP-1 api 6 features wowlan,ignore-otp crc32 42e41877<br>[ =C2=A0 45.09360=
7] kvm_amd: TSC scaling supported<br>[ =C2=A0 45.093614] kvm_amd: Nested Vi=
rtualization enabled<br>[ =C2=A0 45.093615] kvm_amd: Nested Paging enabled<=
br>[ =C2=A0 45.093617] kvm_amd: LBR virtualization supported<br>[ =C2=A0 45=
.093622] kvm_amd: Virtual GIF supported<br>[ =C2=A0 45.103555] Generic FE-G=
E Realtek PHY r8169-0-200:00: attached PHY driver (mii_bus:phy_addr=3Dr8169=
-0-200:00, irq=3DMAC)<br>[ =C2=A0 45.108806] input: HD-Audio Generic Headph=
one Mic as /devices/pci0000:00/0000:00:09.2/sound/card1/input28<br>[ =C2=A0=
 45.159204] ath10k_pci 0000:01:00.0: board_file api 2 bmi_id N/A crc32 8aed=
fa4a<br>[ =C2=A0 45.270679] r8169 0000:02:00.0 enp2s0: Link is Down<br>[ =
=C2=A0 45.329901] ath10k_pci 0000:01:00.0: htt-ver 3.56 wmi-op 4 htt-op 3 c=
al otp max-sta 32 raw 0 hwcrypto 1<br>[ =C2=A0 45.388418] ath: EEPROM regdo=
main: 0x6c<br>[ =C2=A0 45.388426] ath: EEPROM indicates we should expect a =
direct regpair map<br>[ =C2=A0 45.388428] ath: Country alpha2 being used: 0=
0<br>[ =C2=A0 45.388430] ath: Regpair used: 0x6c<br>[ =C2=A0 48.966269] kau=
ditd_printk_skb: 132 callbacks suppressed<br>[ =C2=A0 48.966274] audit: typ=
e=3D1130 audit(1770273946.956:86): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D=
4294967295 msg=3D&#39;unit=3Dldconfig comm=3D&quot;systemd&quot; exe=3D&quo=
t;/usr/lib/systemd/systemd&quot; hostname=3D? addr=3D? terminal=3D? res=3Ds=
uccess&#39;<br>[ =C2=A0 49.011037] audit: type=3D1130 audit(1770273947.001:=
87): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D&#39;unit=3Ds=
ystemd-update-done comm=3D&quot;systemd&quot; exe=3D&quot;/usr/lib/systemd/=
systemd&quot; hostname=3D? addr=3D? terminal=3D? res=3Dsuccess&#39;<br>[ =
=C2=A0 49.027087] audit: type=3D1334 audit(1770273947.017:88): prog-id=3D54=
 op=3DLOAD<br>[ =C2=A0 49.113344] audit: type=3D1130 audit(1770273947.103:8=
9): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D&#39;unit=3Ddb=
us-broker comm=3D&quot;systemd&quot; exe=3D&quot;/usr/lib/systemd/systemd&q=
uot; hostname=3D? addr=3D? terminal=3D? res=3Dsuccess&#39;<br>[ =C2=A0 49.1=
19593] audit: type=3D1334 audit(1770273947.110:90): prog-id=3D55 op=3DLOAD<=
br>[ =C2=A0 49.123271] audit: type=3D1334 audit(1770273947.113:91): prog-id=
=3D56 op=3DLOAD<br>[ =C2=A0 49.136111] audit: type=3D1334 audit(1770273947.=
126:92): prog-id=3D57 op=3DLOAD<br>[ =C2=A0 49.141195] audit: type=3D1334 a=
udit(1770273947.131:93): prog-id=3D58 op=3DLOAD<br>[ =C2=A0 49.141619] audi=
t: type=3D1334 audit(1770273947.131:94): prog-id=3D59 op=3DLOAD<br>[ =C2=A0=
 49.141649] audit: type=3D1334 audit(1770273947.131:95): prog-id=3D60 op=3D=
LOAD<br>[ =C2=A0 49.273168] NET: Registered PF_ALG protocol family<br>[ =C2=
=A0 49.621612] NET: Registered PF_QIPCRTR protocol family<br>[ =C2=A0 54.98=
4555] kauditd_printk_skb: 13 callbacks suppressed<br>[ =C2=A0 54.984561] au=
dit: type=3D1101 audit(1770273952.974:109): pid=3D866 uid=3D0 auid=3D429496=
7295 ses=3D4294967295 msg=3D&#39;op=3DPAM:accounting grantors=3Dpam_access,=
pam_unix,pam_permit,pam_time acct=3D&quot;root&quot; exe=3D&quot;/usr/bin/l=
ogin&quot; hostname=3Darchiso addr=3D? terminal=3D/dev/tty1 res=3Dsuccess&#=
39;<br>[ =C2=A0 55.011362] audit: type=3D1103 audit(1770273953.001:110): pi=
d=3D866 uid=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D&#39;op=3DPAM:setc=
red grantors=3Dpam_shells,pam_faillock,pam_permit,pam_env,pam_faillock acct=
=3D&quot;root&quot; exe=3D&quot;/usr/bin/login&quot; hostname=3Darchiso add=
r=3D? terminal=3D/dev/tty1 res=3Dsuccess&#39;<br>[ =C2=A0 55.011406] audit:=
 type=3D1006 audit(1770273953.001:111): pid=3D866 uid=3D0 old-auid=3D429496=
7295 auid=3D0 tty=3Dtty1 old-ses=3D4294967295 ses=3D1 res=3D1<br>[ =C2=A0 5=
5.011417] audit: type=3D1300 audit(1770273953.001:111): arch=3Dc000003e sys=
call=3D1 success=3Dyes exit=3D1 a0=3D3 a1=3D7ffc79f80020 a2=3D1 a3=3D0 item=
s=3D0 ppid=3D1 pid=3D866 auid=3D0 uid=3D0 gid=3D0 euid=3D0 suid=3D0 fsuid=
=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3Dtty1 ses=3D1 comm=3D&quot;login&quot=
; exe=3D&quot;/usr/bin/login&quot; key=3D(null)<br>[ =C2=A0 55.011421] audi=
t: type=3D1327 audit(1770273953.001:111): proctitle=3D2F62696E2F6C6F67696E0=
02D70002D66002D2D<br>[ =C2=A0 55.104082] audit: type=3D1130 audit(177027395=
3.094:112): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D&#39;u=
nit=3Duser-runtime-dir@0 comm=3D&quot;systemd&quot; exe=3D&quot;/usr/lib/sy=
stemd/systemd&quot; hostname=3D? addr=3D? terminal=3D? res=3Dsuccess&#39;<b=
r>[ =C2=A0 55.127409] audit: type=3D1101 audit(1770273953.117:113): pid=3D8=
76 uid=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D&#39;op=3DPAM:accountin=
g grantors=3Dpam_access,pam_unix,pam_permit,pam_time acct=3D&quot;root&quot=
; exe=3D&quot;/usr/lib/systemd/systemd-executor&quot; hostname=3D? addr=3D?=
 terminal=3D? res=3Dsuccess&#39;<br>[ =C2=A0 55.127469] audit: type=3D1103 =
audit(1770273953.117:114): pid=3D876 uid=3D0 auid=3D4294967295 ses=3D429496=
7295 msg=3D&#39;op=3DPAM:setcred grantors=3D? acct=3D&quot;root&quot; exe=
=3D&quot;/usr/lib/systemd/systemd-executor&quot; hostname=3D? addr=3D? term=
inal=3D? res=3Dfailed&#39;<br>[ =C2=A0 55.127547] audit: type=3D1006 audit(=
1770273953.118:115): pid=3D876 uid=3D0 old-auid=3D4294967295 auid=3D0 tty=
=3D(none) old-ses=3D4294967295 ses=3D2 res=3D1<br>[ =C2=A0 55.127551] audit=
: type=3D1300 audit(1770273953.118:115): arch=3Dc000003e syscall=3D1 succes=
s=3Dyes exit=3D1 a0=3D8 a1=3D7ffffa356ae0 a2=3D1 a3=3D0 items=3D0 ppid=3D1 =
pid=3D876 auid=3D0 uid=3D0 gid=3D0 euid=3D0 suid=3D0 fsuid=3D0 egid=3D0 sgi=
d=3D0 fsgid=3D0 tty=3D(none) ses=3D2 comm=3D&quot;(systemd)&quot; exe=3D&qu=
ot;/usr/lib/systemd/systemd-executor&quot; key=3D(null)<br>[ =C2=A0156.7540=
56] PM: suspend entry (deep)<br>[ =C2=A0156.754099] Filesystems sync: 0.000=
 seconds<br>[ =C2=A0156.757908] Freezing user space processes<br>[ =C2=A015=
6.759436] Freezing user space processes completed (elapsed 0.001 seconds)<b=
r>[ =C2=A0156.759450] OOM killer disabled.<br>[ =C2=A0156.759452] Freezing =
remaining freezable tasks<br>[ =C2=A0156.760785] Freezing remaining freezab=
le tasks completed (elapsed 0.001 seconds)<br>[ =C2=A0156.760851] printk: S=
uspending console(s) (use no_console_suspend to debug)<br>[ =C2=A0156.95046=
1] ------------[ cut here ]------------<br>[ =C2=A0156.950468] WARNING: CPU=
: 2 PID: 944 at drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c=
:3008 dm_prepare_suspend+0x44/0x50 [amdgpu]<br>[ =C2=A0156.951785] Modules =
linked in: ccm algif_aead qrtr crypto_null des3_ede_x86_64 des_generic libd=
es algif_skcipher cmac md4 algif_hash af_alg kvm_amd ccp wl(POE) kvm snd_hd=
a_codec_realtek snd_hda_codec_generic snd_hda_scodec_component irqbypass sn=
d_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi dell_pc =
ath10k_pci snd_ctl_led snd_hda_codec snd_hda_core snd_hwdep ath10k_core snd=
_pcm snd_timer ath ee1004 snd polyval_clmulni soundcore platform_profile ma=
c80211 rtsx_usb_ms libarc4 polyval_generic sp5100_tco dell_laptop btusb joy=
dev hid_multitouch memstick mousedev ghash_clmulni_intel btrtl btintel btbc=
m btmtk dell_wmi dell_smm_hwmon bluetooth sparse_keymap sha1_ssse3 pcspkr i=
2c_piix4 i2c_hid_acpi dell_smbios dcdbas dell_wmi_descriptor dell_rbtn psmo=
use wmi_bmof i2c_hid i2c_smbus fam15h_power k10temp cfg80211 mac_hid rfkill=
 pkcs8_key_parser dm_mod nfnetlink ip_tables x_tables overlay squashfs loop=
 isofs cdrom amdgpu amdxcp gpu_sched rtsx_usb_sdmmc drm_panel_backlight_qui=
rks drm_buddy mmc_core drm_exec<br>[ =C2=A0156.951859] =C2=A0sha512_ssse3 d=
rm_suballoc_helper sha256_ssse3 r8169 drm_ttm_helper aesni_intel realtek tt=
m crypto_simd cryptd i2c_algo_bit mdio_devres uas serio_raw rtsx_usb drm_di=
splay_helper libphy usb_storage cec video wmi<br>[ =C2=A0156.951881] CPU: 2=
 UID: 0 PID: 944 Comm: systemd-sleep Tainted: P =C2=A0 =C2=A0 =C2=A0 =C2=A0=
W =C2=A0OE =C2=A0 =C2=A0 =C2=A0 6.15.4-arch2-1 #1 PREEMPT(full) =C2=A0bf560=
11d6043294f437da1888a30a6d02e6dd116<br>[ =C2=A0156.951887] Tainted: [P]=3DP=
ROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE<br>[=
 =C2=A0156.951889] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.=
7 01/29/2018<br>[ =C2=A0156.951891] RIP: 0010:dm_prepare_suspend+0x44/0x50 =
[amdgpu]<br>[ =C2=A0156.953187] Code: 48 83 bb 60 6c 04 00 00 75 20 48 8d 7=
b 10 e8 23 0b d0 d4 48 89 83 60 6c 04 00 48 3d 00 f0 ff ff 77 02 31 c0 5b e=
9 8c 80 1e d5 &lt;0f&gt; 0b eb dc 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90=
 90 90 90 90<br>[ =C2=A0156.953189] RSP: 0018:ffffd0864370ba98 EFLAGS: 0001=
0282<br>[ =C2=A0156.953192] RAX: 0000000000000000 RBX: ffff8c5717d00000 RCX=
: 0000000000000000<br>[ =C2=A0156.953194] RDX: ffff8c5718043600 RSI: 000000=
007fffffff RDI: ffff8c5717d00000<br>[ =C2=A0156.953195] RBP: 00000000000000=
06 R08: ffffd0864370b9e0 R09: ffff8c5717d0fb68<br>[ =C2=A0156.953196] R10: =
ffff8c5717d0fb08 R11: 0000000000000000 R12: ffff8c5717d00010<br>[ =C2=A0156=
.953197] R13: 0000000000000000 R14: 0000000000000002 R15: 000000007f89bb00<=
br>[ =C2=A0156.953198] FS: =C2=A000007fa0da923880(0000) GS:ffff8c5a0902f000=
(0000) knlGS:0000000000000000<br>[ =C2=A0156.953200] CS: =C2=A00010 DS: 000=
0 ES: 0000 CR0: 0000000080050033<br>[ =C2=A0156.953201] CR2: 000055a701f391=
68 CR3: 000000010f832000 CR4: 00000000001506f0<br>[ =C2=A0156.953203] Call =
Trace:<br>[ =C2=A0156.953210] =C2=A0&lt;TASK&gt;<br>[ =C2=A0156.953215] =C2=
=A0amdgpu_device_prepare+0x8b/0xc0 [amdgpu fd2a24652620738c2ec44a27ca03228c=
2099e273]<br>[ =C2=A0156.954448] =C2=A0pci_pm_prepare+0x2c/0x70<br>[ =C2=A0=
156.954457] =C2=A0dpm_prepare+0x166/0x4d0<br>[ =C2=A0156.954463] =C2=A0? __=
pfx_pci_pm_prepare+0x10/0x10<br>[ =C2=A0156.954466] =C2=A0dpm_suspend_start=
+0x1e/0x60<br>[ =C2=A0156.954468] =C2=A0suspend_devices_and_enter+0x168/0x8=
80<br>[ =C2=A0156.954474] =C2=A0pm_suspend.cold+0x303/0x36b<br>[ =C2=A0156.=
954479] =C2=A0state_store+0x6c/0xd0<br>[ =C2=A0156.954483] =C2=A0kernfs_fop=
_write_iter+0x138/0x1f0<br>[ =C2=A0156.954488] =C2=A0vfs_write+0x28e/0x470<=
br>[ =C2=A0156.954498] =C2=A0ksys_write+0x73/0xe0<br>[ =C2=A0156.954501] =
=C2=A0do_syscall_64+0x7b/0x810<br>[ =C2=A0156.954506] =C2=A0? __mod_memcg_l=
ruvec_state+0xb1/0x1c0<br>[ =C2=A0156.954510] =C2=A0? __lruvec_stat_mod_fol=
io+0x85/0xd0<br>[ =C2=A0156.954513] =C2=A0? __folio_mod_stat+0x2d/0x90<br>[=
 =C2=A0156.954517] =C2=A0? set_ptes.isra.0+0x36/0x80<br>[ =C2=A0156.954520]=
 =C2=A0? do_anonymous_page+0xf7/0x8b0<br>[ =C2=A0156.954522] =C2=A0? ___pte=
_offset_map+0x1b/0x180<br>[ =C2=A0156.954525] =C2=A0? __handle_mm_fault+0xb=
46/0xfd0<br>[ =C2=A0156.954528] =C2=A0? __count_memcg_events+0xb0/0x150<br>=
[ =C2=A0156.954530] =C2=A0? count_memcg_events.constprop.0+0x1a/0x30<br>[ =
=C2=A0156.954532] =C2=A0? handle_mm_fault+0x1d2/0x2d0<br>[ =C2=A0156.954534=
] =C2=A0? do_user_addr_fault+0x21a/0x690<br>[ =C2=A0156.954538] =C2=A0? irq=
entry_exit_to_user_mode+0x2c/0x1b0<br>[ =C2=A0156.954542] =C2=A0entry_SYSCA=
LL_64_after_hwframe+0x76/0x7e<br>[ =C2=A0156.954545] RIP: 0033:0x7fa0da78a0=
06<br>[ =C2=A0156.954569] Code: 5d e8 41 8b 93 08 03 00 00 59 5e 48 83 f8 f=
c 75 19 83 e2 39 83 fa 08 75 11 e8 26 ff ff ff 66 0f 1f 44 00 00 48 8b 45 1=
0 0f 05 &lt;48&gt; 8b 5d f8 c9 c3 0f 1f 40 00 f3 0f 1e fa 55 48 89 e5 48 83=
 ec 08<br>[ =C2=A0156.954571] RSP: 002b:00007ffeb73d8e50 EFLAGS: 00000202 O=
RIG_RAX: 0000000000000001<br>[ =C2=A0156.954573] RAX: ffffffffffffffda RBX:=
 0000000000000004 RCX: 00007fa0da78a006<br>[ =C2=A0156.954575] RDX: 0000000=
000000004 RSI: 000055a701f39870 RDI: 0000000000000007<br>[ =C2=A0156.954576=
] RBP: 00007ffeb73d8e70 R08: 0000000000000000 R09: 0000000000000000<br>[ =
=C2=A0156.954577] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000=
00000004<br>[ =C2=A0156.954578] R13: 000055a701f39870 R14: 000055a701f312a0=
 R15: 00007ffeb73d9000<br>[ =C2=A0156.954581] =C2=A0&lt;/TASK&gt;<br>[ =C2=
=A0156.954582] ---[ end trace 0000000000000000 ]---<br>[ =C2=A0157.188778] =
sd 0:0:0:0: [sda] Synchronizing SCSI cache<br>[ =C2=A0157.193757] ata1.00: =
Entering standby power mode<br>[ =C2=A0157.438247] [drm] PCIE GART of 256M =
enabled (table at 0x000000F4FFF80000).<br>[ =C2=A0157.707831] amdgpu 0000:0=
3:00.0: [drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring comp_1.0.1 test=
 failed (-110)<br>[ =C2=A0159.027308] [drm:uvd_v6_0_start [amdgpu]] *ERROR*=
 UVD not responding, trying to reset the VCPU!!!<br>[ =C2=A0160.048538] [dr=
m:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding, trying to reset the =
VCPU!!!<br>[ =C2=A0161.069752] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD no=
t responding, trying to reset the VCPU!!!<br>[ =C2=A0162.090976] [drm:uvd_v=
6_0_start [amdgpu]] *ERROR* UVD not responding, trying to reset the VCPU!!!=
<br>[ =C2=A0163.112200] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not respo=
nding, trying to reset the VCPU!!!<br>[ =C2=A0164.133425] [drm:uvd_v6_0_sta=
rt [amdgpu]] *ERROR* UVD not responding, trying to reset the VCPU!!!<br>[ =
=C2=A0165.154643] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding,=
 trying to reset the VCPU!!!<br>[ =C2=A0166.175857] [drm:uvd_v6_0_start [am=
dgpu]] *ERROR* UVD not responding, trying to reset the VCPU!!!<br>[ =C2=A01=
67.197087] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding, trying=
 to reset the VCPU!!!<br>[ =C2=A0168.218294] [drm:uvd_v6_0_start [amdgpu]] =
*ERROR* UVD not responding, trying to reset the VCPU!!!<br>[ =C2=A0168.2391=
93] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding, giving up!!!<=
br>[ =C2=A0168.240067] [drm:amdgpu_device_ip_set_powergating_state [amdgpu]=
] *ERROR* set_powergating_state of IP block &lt;uvd_v6_0&gt; failed -1<br>[=
 =C2=A0168.511268] amdgpu 0000:03:00.0: [drm:amdgpu_ring_test_helper [amdgp=
u]] *ERROR* ring uvd test failed (-110)<br>[ =C2=A0168.512140] amdgpu 0000:=
03:00.0: amdgpu: resume of IP block &lt;uvd_v6_0&gt; failed -110<br>[ =C2=
=A0168.512144] amdgpu 0000:03:00.0: amdgpu: amdgpu_device_ip_resume failed =
(-110).<br>[ =C2=A0168.512751] ------------[ cut here ]------------<br>[ =
=C2=A0168.512753] WARNING: CPU: 0 PID: 13 at drivers/gpu/drm/amd/amdgpu/amd=
gpu_irq.c:631 amdgpu_irq_put+0x46/0x70 [amdgpu]<br>[ =C2=A0168.513638] Modu=
les linked in: ccm algif_aead qrtr crypto_null des3_ede_x86_64 des_generic =
libdes algif_skcipher cmac md4 algif_hash af_alg kvm_amd ccp wl(POE) kvm sn=
d_hda_codec_realtek snd_hda_codec_generic snd_hda_scodec_component irqbypas=
s snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi dell=
_pc ath10k_pci snd_ctl_led snd_hda_codec snd_hda_core snd_hwdep ath10k_core=
 snd_pcm snd_timer ath ee1004 snd polyval_clmulni soundcore platform_profil=
e mac80211 rtsx_usb_ms libarc4 polyval_generic sp5100_tco dell_laptop btusb=
 joydev hid_multitouch memstick mousedev ghash_clmulni_intel btrtl btintel =
btbcm btmtk dell_wmi dell_smm_hwmon bluetooth sparse_keymap sha1_ssse3 pcsp=
kr i2c_piix4 i2c_hid_acpi dell_smbios dcdbas dell_wmi_descriptor dell_rbtn =
psmouse wmi_bmof i2c_hid i2c_smbus fam15h_power k10temp cfg80211 mac_hid rf=
kill pkcs8_key_parser dm_mod nfnetlink ip_tables x_tables overlay squashfs =
loop isofs cdrom amdgpu amdxcp gpu_sched rtsx_usb_sdmmc drm_panel_backlight=
_quirks drm_buddy mmc_core drm_exec<br>[ =C2=A0168.513703] =C2=A0sha512_sss=
e3 drm_suballoc_helper sha256_ssse3 r8169 drm_ttm_helper aesni_intel realte=
k ttm crypto_simd cryptd i2c_algo_bit mdio_devres uas serio_raw rtsx_usb dr=
m_display_helper libphy usb_storage cec video wmi<br>[ =C2=A0168.513721] CP=
U: 0 UID: 0 PID: 13 Comm: kworker/u16:1 Tainted: P =C2=A0 =C2=A0 =C2=A0 =C2=
=A0W =C2=A0OE =C2=A0 =C2=A0 =C2=A0 6.15.4-arch2-1 #1 PREEMPT(full) =C2=A0bf=
56011d6043294f437da1888a30a6d02e6dd116<br>[ =C2=A0168.513727] Tainted: [P]=
=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE<=
br>[ =C2=A0168.513728] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS =
1.0.7 01/29/2018<br>[ =C2=A0168.513730] Workqueue: async async_run_entry_fn=
<br>[ =C2=A0168.513737] RIP: 0010:amdgpu_irq_put+0x46/0x70 [amdgpu]<br>[ =
=C2=A0168.514625] Code: c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 d1 48 8d =
04 88 8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9 5f c6 44 d5 e9 5a fd ff ff =
&lt;0f&gt; 0b b8 ea ff ff ff e9 4e c6 44 d5 b8 ea ff ff ff e9 44 c6 44 d5<b=
r>[ =C2=A0168.514627] RSP: 0018:ffffd0864011fd10 EFLAGS: 00010246<br>[ =C2=
=A0168.514629] RAX: ffff8c57107c4500 RBX: ffff8c5717d18b50 RCX: 00000000000=
00000<br>[ =C2=A0168.514631] RDX: 0000000000000000 RSI: ffff8c5717d259a0 RD=
I: ffff8c5717d00000<br>[ =C2=A0168.514632] RBP: ffff8c5717d10388 R08: ffffd=
0864011fc98 R09: ffff8c5717d0fb68<br>[ =C2=A0168.514633] R10: ffff8c5717d0f=
b08 R11: 0000000000000000 R12: ffff8c5717d10830<br>[ =C2=A0168.514634] R13:=
 0000000000000002 R14: ffff8c5717d00000 R15: ffff8c5717d259a0<br>[ =C2=A016=
8.514636] FS: =C2=A00000000000000000(0000) GS:ffff8c5a08f2f000(0000) knlGS:=
0000000000000000<br>[ =C2=A0168.514637] CS: =C2=A00010 DS: 0000 ES: 0000 CR=
0: 0000000080050033<br>[ =C2=A0168.514638] CR2: 00007fb941b67000 CR3: 00000=
0010f832000 CR4: 00000000001506f0<br>[ =C2=A0168.514640] Call Trace:<br>[ =
=C2=A0168.514644] =C2=A0&lt;TASK&gt;<br>[ =C2=A0168.514646] =C2=A0amdgpu_fe=
nce_driver_hw_fini+0xf9/0x130 [amdgpu fd2a24652620738c2ec44a27ca03228c2099e=
273]<br>[ =C2=A0168.515512] =C2=A0amdgpu_device_suspend+0xbc/0x160 [amdgpu =
fd2a24652620738c2ec44a27ca03228c2099e273]<br>[ =C2=A0168.516370] =C2=A0pci_=
pm_suspend+0x80/0x170<br>[ =C2=A0168.516375] =C2=A0? __pfx_pci_pm_suspend+0=
x10/0x10<br>[ =C2=A0168.516377] =C2=A0dpm_run_callback+0x4a/0x150<br>[ =C2=
=A0168.516382] =C2=A0device_suspend+0x14d/0x540<br>[ =C2=A0168.516385] =C2=
=A0async_suspend+0x21/0x30<br>[ =C2=A0168.516387] =C2=A0async_run_entry_fn+=
0x36/0x140<br>[ =C2=A0168.516392] =C2=A0process_one_work+0x193/0x350<br>[ =
=C2=A0168.516396] =C2=A0worker_thread+0x2d7/0x410<br>[ =C2=A0168.516398] =
=C2=A0? __pfx_worker_thread+0x10/0x10<br>[ =C2=A0168.516400] =C2=A0kthread+=
0xfc/0x240<br>[ =C2=A0168.516403] =C2=A0? __pfx_kthread+0x10/0x10<br>[ =C2=
=A0168.516405] =C2=A0ret_from_fork+0x34/0x50<br>[ =C2=A0168.516408] =C2=A0?=
 __pfx_kthread+0x10/0x10<br>[ =C2=A0168.516410] =C2=A0ret_from_fork_asm+0x1=
a/0x30<br>[ =C2=A0168.516415] =C2=A0&lt;/TASK&gt;<br>[ =C2=A0168.516416] --=
-[ end trace 0000000000000000 ]---<br>[ =C2=A0168.516517] ------------[ cut=
 here ]------------<br>[ =C2=A0168.516518] WARNING: CPU: 0 PID: 13 at drive=
rs/gpu/drm/amd/amdgpu/amdgpu_irq.c:631 amdgpu_irq_put+0x46/0x70 [amdgpu]<br=
>[ =C2=A0168.517406] Modules linked in: ccm algif_aead qrtr crypto_null des=
3_ede_x86_64 des_generic libdes algif_skcipher cmac md4 algif_hash af_alg k=
vm_amd ccp wl(POE) kvm snd_hda_codec_realtek snd_hda_codec_generic snd_hda_=
scodec_component irqbypass snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcf=
g snd_intel_sdw_acpi dell_pc ath10k_pci snd_ctl_led snd_hda_codec snd_hda_c=
ore snd_hwdep ath10k_core snd_pcm snd_timer ath ee1004 snd polyval_clmulni =
soundcore platform_profile mac80211 rtsx_usb_ms libarc4 polyval_generic sp5=
100_tco dell_laptop btusb joydev hid_multitouch memstick mousedev ghash_clm=
ulni_intel btrtl btintel btbcm btmtk dell_wmi dell_smm_hwmon bluetooth spar=
se_keymap sha1_ssse3 pcspkr i2c_piix4 i2c_hid_acpi dell_smbios dcdbas dell_=
wmi_descriptor dell_rbtn psmouse wmi_bmof i2c_hid i2c_smbus fam15h_power k1=
0temp cfg80211 mac_hid rfkill pkcs8_key_parser dm_mod nfnetlink ip_tables x=
_tables overlay squashfs loop isofs cdrom amdgpu amdxcp gpu_sched rtsx_usb_=
sdmmc drm_panel_backlight_quirks drm_buddy mmc_core drm_exec<br>[ =C2=A0168=
.517469] =C2=A0sha512_ssse3 drm_suballoc_helper sha256_ssse3 r8169 drm_ttm_=
helper aesni_intel realtek ttm crypto_simd cryptd i2c_algo_bit mdio_devres =
uas serio_raw rtsx_usb drm_display_helper libphy usb_storage cec video wmi<=
br>[ =C2=A0168.517487] CPU: 0 UID: 0 PID: 13 Comm: kworker/u16:1 Tainted: P=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0W =C2=A0OE =C2=A0 =C2=A0 =C2=A0 6.15.4-arch2-1 =
#1 PREEMPT(full) =C2=A0bf56011d6043294f437da1888a30a6d02e6dd116<br>[ =C2=A0=
168.517491] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_MODULE=
, [E]=3DUNSIGNED_MODULE<br>[ =C2=A0168.517492] Hardware name: Dell Inc. Ins=
piron 5576/0JW8XC, BIOS 1.0.7 01/29/2018<br>[ =C2=A0168.517503] Workqueue: =
async async_run_entry_fn<br>[ =C2=A0168.517509] RIP: 0010:amdgpu_irq_put+0x=
46/0x70 [amdgpu]<br>[ =C2=A0168.518373] Code: c0 74 33 48 8b 4e 10 48 83 39=
 00 74 29 89 d1 48 8d 04 88 8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9 5f c6=
 44 d5 e9 5a fd ff ff &lt;0f&gt; 0b b8 ea ff ff ff e9 4e c6 44 d5 b8 ea ff =
ff ff e9 44 c6 44 d5<br>[ =C2=A0168.518375] RSP: 0018:ffffd0864011fd10 EFLA=
GS: 00010246<br>[ =C2=A0168.518378] RAX: ffff8c57107c4508 RBX: ffff8c5717d1=
9198 RCX: 0000000000000000<br>[ =C2=A0168.518379] RDX: 0000000000000002 RSI=
: ffff8c5717d259a0 RDI: ffff8c5717d00000<br>[ =C2=A0168.518380] RBP: ffff8c=
5717d10390 R08: ffffd0864011fc98 R09: ffff8c5717d0fb68<br>[ =C2=A0168.51838=
1] R10: ffff8c5717d0fb08 R11: 0000000000000000 R12: ffff8c5717d10830<br>[ =
=C2=A0168.518382] R13: 0000000000000002 R14: ffff8c5717d00000 R15: ffff8c57=
17d259a0<br>[ =C2=A0168.518383] FS: =C2=A00000000000000000(0000) GS:ffff8c5=
a08f2f000(0000) knlGS:0000000000000000<br>[ =C2=A0168.518385] CS: =C2=A0001=
0 DS: 0000 ES: 0000 CR0: 0000000080050033<br>[ =C2=A0168.518386] CR2: 00007=
fb941b67000 CR3: 000000010f832000 CR4: 00000000001506f0<br>[ =C2=A0168.5183=
87] Call Trace:<br>[ =C2=A0168.518390] =C2=A0&lt;TASK&gt;<br>[ =C2=A0168.51=
8391] =C2=A0amdgpu_fence_driver_hw_fini+0xf9/0x130 [amdgpu fd2a24652620738c=
2ec44a27ca03228c2099e273]<br>[ =C2=A0168.519250] =C2=A0amdgpu_device_suspen=
d+0xbc/0x160 [amdgpu fd2a24652620738c2ec44a27ca03228c2099e273]<br>[ =C2=A01=
68.520117] =C2=A0pci_pm_suspend+0x80/0x170<br>[ =C2=A0168.520123] =C2=A0? _=
_pfx_pci_pm_suspend+0x10/0x10<br>[ =C2=A0168.520125] =C2=A0dpm_run_callback=
+0x4a/0x150<br>[ =C2=A0168.520129] =C2=A0device_suspend+0x14d/0x540<br>[ =
=C2=A0168.520132] =C2=A0async_suspend+0x21/0x30<br>[ =C2=A0168.520134] =C2=
=A0async_run_entry_fn+0x36/0x140<br>[ =C2=A0168.520139] =C2=A0process_one_w=
ork+0x193/0x350<br>[ =C2=A0168.520142] =C2=A0worker_thread+0x2d7/0x410<br>[=
 =C2=A0168.520145] =C2=A0? __pfx_worker_thread+0x10/0x10<br>[ =C2=A0168.520=
147] =C2=A0kthread+0xfc/0x240<br>[ =C2=A0168.520150] =C2=A0? __pfx_kthread+=
0x10/0x10<br>[ =C2=A0168.520151] =C2=A0ret_from_fork+0x34/0x50<br>[ =C2=A01=
68.520155] =C2=A0? __pfx_kthread+0x10/0x10<br>[ =C2=A0168.520156] =C2=A0ret=
_from_fork_asm+0x1a/0x30<br>[ =C2=A0168.520162] =C2=A0&lt;/TASK&gt;<br>[ =
=C2=A0168.520163] ---[ end trace 0000000000000000 ]---<br>[ =C2=A0168.52024=
9] ------------[ cut here ]------------<br>[ =C2=A0168.520249] WARNING: CPU=
: 0 PID: 13 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:631 amdgpu_irq_put+0=
x46/0x70 [amdgpu]<br>[ =C2=A0168.521131] Modules linked in: ccm algif_aead =
qrtr crypto_null des3_ede_x86_64 des_generic libdes algif_skcipher cmac md4=
 algif_hash af_alg kvm_amd ccp wl(POE) kvm snd_hda_codec_realtek snd_hda_co=
dec_generic snd_hda_scodec_component irqbypass snd_hda_codec_hdmi snd_hda_i=
ntel snd_intel_dspcfg snd_intel_sdw_acpi dell_pc ath10k_pci snd_ctl_led snd=
_hda_codec snd_hda_core snd_hwdep ath10k_core snd_pcm snd_timer ath ee1004 =
snd polyval_clmulni soundcore platform_profile mac80211 rtsx_usb_ms libarc4=
 polyval_generic sp5100_tco dell_laptop btusb joydev hid_multitouch memstic=
k mousedev ghash_clmulni_intel btrtl btintel btbcm btmtk dell_wmi dell_smm_=
hwmon bluetooth sparse_keymap sha1_ssse3 pcspkr i2c_piix4 i2c_hid_acpi dell=
_smbios dcdbas dell_wmi_descriptor dell_rbtn psmouse wmi_bmof i2c_hid i2c_s=
mbus fam15h_power k10temp cfg80211 mac_hid rfkill pkcs8_key_parser dm_mod n=
fnetlink ip_tables x_tables overlay squashfs loop isofs cdrom amdgpu amdxcp=
 gpu_sched rtsx_usb_sdmmc drm_panel_backlight_quirks drm_buddy mmc_core drm=
_exec<br>[ =C2=A0168.521195] =C2=A0sha512_ssse3 drm_suballoc_helper sha256_=
ssse3 r8169 drm_ttm_helper aesni_intel realtek ttm crypto_simd cryptd i2c_a=
lgo_bit mdio_devres uas serio_raw rtsx_usb drm_display_helper libphy usb_st=
orage cec video wmi<br>[ =C2=A0168.521211] CPU: 0 UID: 0 PID: 13 Comm: kwor=
ker/u16:1 Tainted: P =C2=A0 =C2=A0 =C2=A0 =C2=A0W =C2=A0OE =C2=A0 =C2=A0 =
=C2=A0 6.15.4-arch2-1 #1 PREEMPT(full) =C2=A0bf56011d6043294f437da1888a30a6=
d02e6dd116<br>[ =C2=A0168.521215] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3D=
WARN, [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE<br>[ =C2=A0168.521216] Hardwa=
re name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7 01/29/2018<br>[ =C2=A01=
68.521218] Workqueue: async async_run_entry_fn<br>[ =C2=A0168.521223] RIP: =
0010:amdgpu_irq_put+0x46/0x70 [amdgpu]<br>[ =C2=A0168.522110] Code: c0 74 3=
3 48 8b 4e 10 48 83 39 00 74 29 89 d1 48 8d 04 88 8b 08 85 c9 74 11 f0 ff 0=
8 74 07 31 c0 e9 5f c6 44 d5 e9 5a fd ff ff &lt;0f&gt; 0b b8 ea ff ff ff e9=
 4e c6 44 d5 b8 ea ff ff ff e9 44 c6 44 d5<br>[ =C2=A0168.522113] RSP: 0018=
:ffffd0864011fd10 EFLAGS: 00010246<br>[ =C2=A0168.522115] RAX: ffff8c57107c=
4508 RBX: ffff8c5717d194b8 RCX: 0000000000000000<br>[ =C2=A0168.522116] RDX=
: 0000000000000002 RSI: ffff8c5717d259a0 RDI: ffff8c5717d00000<br>[ =C2=A01=
68.522117] RBP: ffff8c5717d10398 R08: ffffd0864011fc98 R09: ffff8c5717d0fb6=
8<br>[ =C2=A0168.522118] R10: ffff8c5717d0fb08 R11: 0000000000000000 R12: f=
fff8c5717d10830<br>[ =C2=A0168.522119] R13: 0000000000000002 R14: ffff8c571=
7d00000 R15: ffff8c5717d259a0<br>[ =C2=A0168.522121] FS: =C2=A0000000000000=
0000(0000) GS:ffff8c5a08f2f000(0000) knlGS:0000000000000000<br>[ =C2=A0168.=
522122] CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 0000000080050033<br>[ =C2=A01=
68.522123] CR2: 00007fb941b67000 CR3: 000000010f832000 CR4: 00000000001506f=
0<br>[ =C2=A0168.522124] Call Trace:<br>[ =C2=A0168.522128] =C2=A0&lt;TASK&=
gt;<br>[ =C2=A0168.522129] =C2=A0amdgpu_fence_driver_hw_fini+0xf9/0x130 [am=
dgpu fd2a24652620738c2ec44a27ca03228c2099e273]<br>[ =C2=A0168.522996] =C2=
=A0amdgpu_device_suspend+0xbc/0x160 [amdgpu fd2a24652620738c2ec44a27ca03228=
c2099e273]<br>[ =C2=A0168.523861] =C2=A0pci_pm_suspend+0x80/0x170<br>[ =C2=
=A0168.523867] =C2=A0? __pfx_pci_pm_suspend+0x10/0x10<br>[ =C2=A0168.523869=
] =C2=A0dpm_run_callback+0x4a/0x150<br>[ =C2=A0168.523873] =C2=A0device_sus=
pend+0x14d/0x540<br>[ =C2=A0168.523876] =C2=A0async_suspend+0x21/0x30<br>[ =
=C2=A0168.523879] =C2=A0async_run_entry_fn+0x36/0x140<br>[ =C2=A0168.523884=
] =C2=A0process_one_work+0x193/0x350<br>[ =C2=A0168.523887] =C2=A0worker_th=
read+0x2d7/0x410<br>[ =C2=A0168.523890] =C2=A0? __pfx_worker_thread+0x10/0x=
10<br>[ =C2=A0168.523892] =C2=A0kthread+0xfc/0x240<br>[ =C2=A0168.523894] =
=C2=A0? __pfx_kthread+0x10/0x10<br>[ =C2=A0168.523896] =C2=A0ret_from_fork+=
0x34/0x50<br>[ =C2=A0168.523900] =C2=A0? __pfx_kthread+0x10/0x10<br>[ =C2=
=A0168.523902] =C2=A0ret_from_fork_asm+0x1a/0x30<br>[ =C2=A0168.523907] =C2=
=A0&lt;/TASK&gt;<br>[ =C2=A0168.523908] ---[ end trace 0000000000000000 ]--=
-<br>[ =C2=A0168.523995] ------------[ cut here ]------------<br>[ =C2=A016=
8.523996] WARNING: CPU: 0 PID: 13 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.=
c:631 amdgpu_irq_put+0x46/0x70 [amdgpu]<br>[ =C2=A0168.524876] Modules link=
ed in: ccm algif_aead qrtr crypto_null des3_ede_x86_64 des_generic libdes a=
lgif_skcipher cmac md4 algif_hash af_alg kvm_amd ccp wl(POE) kvm snd_hda_co=
dec_realtek snd_hda_codec_generic snd_hda_scodec_component irqbypass snd_hd=
a_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi dell_pc ath1=
0k_pci snd_ctl_led snd_hda_codec snd_hda_core snd_hwdep ath10k_core snd_pcm=
 snd_timer ath ee1004 snd polyval_clmulni soundcore platform_profile mac802=
11 rtsx_usb_ms libarc4 polyval_generic sp5100_tco dell_laptop btusb joydev =
hid_multitouch memstick mousedev ghash_clmulni_intel btrtl btintel btbcm bt=
mtk dell_wmi dell_smm_hwmon bluetooth sparse_keymap sha1_ssse3 pcspkr i2c_p=
iix4 i2c_hid_acpi dell_smbios dcdbas dell_wmi_descriptor dell_rbtn psmouse =
wmi_bmof i2c_hid i2c_smbus fam15h_power k10temp cfg80211 mac_hid rfkill pkc=
s8_key_parser dm_mod nfnetlink ip_tables x_tables overlay squashfs loop iso=
fs cdrom amdgpu amdxcp gpu_sched rtsx_usb_sdmmc drm_panel_backlight_quirks =
drm_buddy mmc_core drm_exec<br>[ =C2=A0168.524940] =C2=A0sha512_ssse3 drm_s=
uballoc_helper sha256_ssse3 r8169 drm_ttm_helper aesni_intel realtek ttm cr=
ypto_simd cryptd i2c_algo_bit mdio_devres uas serio_raw rtsx_usb drm_displa=
y_helper libphy usb_storage cec video wmi<br>[ =C2=A0168.524957] CPU: 0 UID=
: 0 PID: 13 Comm: kworker/u16:1 Tainted: P =C2=A0 =C2=A0 =C2=A0 =C2=A0W =C2=
=A0OE =C2=A0 =C2=A0 =C2=A0 6.15.4-arch2-1 #1 PREEMPT(full) =C2=A0bf56011d60=
43294f437da1888a30a6d02e6dd116<br>[ =C2=A0168.524962] Tainted: [P]=3DPROPRI=
ETARY_MODULE, [W]=3DWARN, [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE<br>[ =C2=
=A0168.524963] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7 01=
/29/2018<br>[ =C2=A0168.524964] Workqueue: async async_run_entry_fn<br>[ =
=C2=A0168.524969] RIP: 0010:amdgpu_irq_put+0x46/0x70 [amdgpu]<br>[ =C2=A016=
8.525868] Code: c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 d1 48 8d 04 88 8b=
 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9 5f c6 44 d5 e9 5a fd ff ff &lt;0f&g=
t; 0b b8 ea ff ff ff e9 4e c6 44 d5 b8 ea ff ff ff e9 44 c6 44 d5<br>[ =C2=
=A0168.525870] RSP: 0018:ffffd0864011fd10 EFLAGS: 00010246<br>[ =C2=A0168.5=
25873] RAX: ffff8c57107c4508 RBX: ffff8c5717d197d8 RCX: 0000000000000000<br=
>[ =C2=A0168.525874] RDX: 0000000000000002 RSI: ffff8c5717d259a0 RDI: ffff8=
c5717d00000<br>[ =C2=A0168.525875] RBP: ffff8c5717d103a0 R08: ffffd0864011f=
c98 R09: ffff8c5717d0fb68<br>[ =C2=A0168.525876] R10: ffff8c5717d0fb08 R11:=
 0000000000000000 R12: ffff8c5717d10830<br>[ =C2=A0168.525877] R13: 0000000=
000000002 R14: ffff8c5717d00000 R15: ffff8c5717d259a0<br>[ =C2=A0168.525878=
] FS: =C2=A00000000000000000(0000) GS:ffff8c5a08f2f000(0000) knlGS:00000000=
00000000<br>[ =C2=A0168.525880] CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 00000=
00080050033<br>[ =C2=A0168.525881] CR2: 00007fb941b67000 CR3: 000000010f832=
000 CR4: 00000000001506f0<br>[ =C2=A0168.525883] Call Trace:<br>[ =C2=A0168=
.525885] =C2=A0&lt;TASK&gt;<br>[ =C2=A0168.525887] =C2=A0amdgpu_fence_drive=
r_hw_fini+0xf9/0x130 [amdgpu fd2a24652620738c2ec44a27ca03228c2099e273]<br>[=
 =C2=A0168.526753] =C2=A0amdgpu_device_suspend+0xbc/0x160 [amdgpu fd2a24652=
620738c2ec44a27ca03228c2099e273]<br>[ =C2=A0168.527608] =C2=A0pci_pm_suspen=
d+0x80/0x170<br>[ =C2=A0168.527614] =C2=A0? __pfx_pci_pm_suspend+0x10/0x10<=
br>[ =C2=A0168.527616] =C2=A0dpm_run_callback+0x4a/0x150<br>[ =C2=A0168.527=
621] =C2=A0device_suspend+0x14d/0x540<br>[ =C2=A0168.527624] =C2=A0async_su=
spend+0x21/0x30<br>[ =C2=A0168.527626] =C2=A0async_run_entry_fn+0x36/0x140<=
br>[ =C2=A0168.527631] =C2=A0process_one_work+0x193/0x350<br>[ =C2=A0168.52=
7634] =C2=A0worker_thread+0x2d7/0x410<br>[ =C2=A0168.527637] =C2=A0? __pfx_=
worker_thread+0x10/0x10<br>[ =C2=A0168.527639] =C2=A0kthread+0xfc/0x240<br>=
[ =C2=A0168.527641] =C2=A0? __pfx_kthread+0x10/0x10<br>[ =C2=A0168.527643] =
=C2=A0ret_from_fork+0x34/0x50<br>[ =C2=A0168.527647] =C2=A0? __pfx_kthread+=
0x10/0x10<br>[ =C2=A0168.527649] =C2=A0ret_from_fork_asm+0x1a/0x30<br>[ =C2=
=A0168.527654] =C2=A0&lt;/TASK&gt;<br>[ =C2=A0168.527655] ---[ end trace 00=
00000000000000 ]---<br>[ =C2=A0168.527743] ------------[ cut here ]--------=
----<br>[ =C2=A0168.527744] WARNING: CPU: 0 PID: 13 at drivers/gpu/drm/amd/=
amdgpu/amdgpu_irq.c:631 amdgpu_irq_put+0x46/0x70 [amdgpu]<br>[ =C2=A0168.52=
8621] Modules linked in: ccm algif_aead qrtr crypto_null des3_ede_x86_64 de=
s_generic libdes algif_skcipher cmac md4 algif_hash af_alg kvm_amd ccp wl(P=
OE) kvm snd_hda_codec_realtek snd_hda_codec_generic snd_hda_scodec_componen=
t irqbypass snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw=
_acpi dell_pc ath10k_pci snd_ctl_led snd_hda_codec snd_hda_core snd_hwdep a=
th10k_core snd_pcm snd_timer ath ee1004 snd polyval_clmulni soundcore platf=
orm_profile mac80211 rtsx_usb_ms libarc4 polyval_generic sp5100_tco dell_la=
ptop btusb joydev hid_multitouch memstick mousedev ghash_clmulni_intel btrt=
l btintel btbcm btmtk dell_wmi dell_smm_hwmon bluetooth sparse_keymap sha1_=
ssse3 pcspkr i2c_piix4 i2c_hid_acpi dell_smbios dcdbas dell_wmi_descriptor =
dell_rbtn psmouse wmi_bmof i2c_hid i2c_smbus fam15h_power k10temp cfg80211 =
mac_hid rfkill pkcs8_key_parser dm_mod nfnetlink ip_tables x_tables overlay=
 squashfs loop isofs cdrom amdgpu amdxcp gpu_sched rtsx_usb_sdmmc drm_panel=
_backlight_quirks drm_buddy mmc_core drm_exec<br>[ =C2=A0168.528685] =C2=A0=
sha512_ssse3 drm_suballoc_helper sha256_ssse3 r8169 drm_ttm_helper aesni_in=
tel realtek ttm crypto_simd cryptd i2c_algo_bit mdio_devres uas serio_raw r=
tsx_usb drm_display_helper libphy usb_storage cec video wmi<br>[ =C2=A0168.=
528702] CPU: 0 UID: 0 PID: 13 Comm: kworker/u16:1 Tainted: P =C2=A0 =C2=A0 =
=C2=A0 =C2=A0W =C2=A0OE =C2=A0 =C2=A0 =C2=A0 6.15.4-arch2-1 #1 PREEMPT(full=
) =C2=A0bf56011d6043294f437da1888a30a6d02e6dd116<br>[ =C2=A0168.528706] Tai=
nted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_MODULE, [E]=3DUNSIGNE=
D_MODULE<br>[ =C2=A0168.528707] Hardware name: Dell Inc. Inspiron 5576/0JW8=
XC, BIOS 1.0.7 01/29/2018<br>[ =C2=A0168.528709] Workqueue: async async_run=
_entry_fn<br>[ =C2=A0168.528714] RIP: 0010:amdgpu_irq_put+0x46/0x70 [amdgpu=
]<br>[ =C2=A0168.529586] Code: c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 d1=
 48 8d 04 88 8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9 5f c6 44 d5 e9 5a fd=
 ff ff &lt;0f&gt; 0b b8 ea ff ff ff e9 4e c6 44 d5 b8 ea ff ff ff e9 44 c6 =
44 d5<br>[ =C2=A0168.529588] RSP: 0018:ffffd0864011fd10 EFLAGS: 00010246<br=
>[ =C2=A0168.529591] RAX: ffff8c57107c4508 RBX: ffff8c5717d19af8 RCX: 00000=
00000000000<br>[ =C2=A0168.529592] RDX: 0000000000000002 RSI: ffff8c5717d25=
9a0 RDI: ffff8c5717d00000<br>[ =C2=A0168.529593] RBP: ffff8c5717d103a8 R08:=
 ffffd0864011fc98 R09: ffff8c5717d0fb68<br>[ =C2=A0168.529594] R10: ffff8c5=
717d0fb08 R11: 0000000000000000 R12: ffff8c5717d10830<br>[ =C2=A0168.529595=
] R13: 0000000000000002 R14: ffff8c5717d00000 R15: ffff8c5717d259a0<br>[ =
=C2=A0168.529596] FS: =C2=A00000000000000000(0000) GS:ffff8c5a08f2f000(0000=
) knlGS:0000000000000000<br>[ =C2=A0168.529598] CS: =C2=A00010 DS: 0000 ES:=
 0000 CR0: 0000000080050033<br>[ =C2=A0168.529599] CR2: 00007fb941b67000 CR=
3: 000000010f832000 CR4: 00000000001506f0<br>[ =C2=A0168.529600] Call Trace=
:<br>[ =C2=A0168.529603] =C2=A0&lt;TASK&gt;<br>[ =C2=A0168.529604] =C2=A0am=
dgpu_fence_driver_hw_fini+0xf9/0x130 [amdgpu fd2a24652620738c2ec44a27ca0322=
8c2099e273]<br>[ =C2=A0168.530461] =C2=A0amdgpu_device_suspend+0xbc/0x160 [=
amdgpu fd2a24652620738c2ec44a27ca03228c2099e273]<br>[ =C2=A0168.531322] =C2=
=A0pci_pm_suspend+0x80/0x170<br>[ =C2=A0168.531328] =C2=A0? __pfx_pci_pm_su=
spend+0x10/0x10<br>[ =C2=A0168.531330] =C2=A0dpm_run_callback+0x4a/0x150<br=
>[ =C2=A0168.531334] =C2=A0device_suspend+0x14d/0x540<br>[ =C2=A0168.531337=
] =C2=A0async_suspend+0x21/0x30<br>[ =C2=A0168.531339] =C2=A0async_run_entr=
y_fn+0x36/0x140<br>[ =C2=A0168.531343] =C2=A0process_one_work+0x193/0x350<b=
r>[ =C2=A0168.531347] =C2=A0worker_thread+0x2d7/0x410<br>[ =C2=A0168.531349=
] =C2=A0? __pfx_worker_thread+0x10/0x10<br>[ =C2=A0168.531352] =C2=A0kthrea=
d+0xfc/0x240<br>[ =C2=A0168.531354] =C2=A0? __pfx_kthread+0x10/0x10<br>[ =
=C2=A0168.531356] =C2=A0ret_from_fork+0x34/0x50<br>[ =C2=A0168.531359] =C2=
=A0? __pfx_kthread+0x10/0x10<br>[ =C2=A0168.531361] =C2=A0ret_from_fork_asm=
+0x1a/0x30<br>[ =C2=A0168.531366] =C2=A0&lt;/TASK&gt;<br>[ =C2=A0168.531367=
] ---[ end trace 0000000000000000 ]---<br>[ =C2=A0168.531453] ------------[=
 cut here ]------------<br>[ =C2=A0168.531453] WARNING: CPU: 0 PID: 13 at d=
rivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:631 amdgpu_irq_put+0x46/0x70 [amdgpu=
]<br>[ =C2=A0168.532330] Modules linked in: ccm algif_aead qrtr crypto_null=
 des3_ede_x86_64 des_generic libdes algif_skcipher cmac md4 algif_hash af_a=
lg kvm_amd ccp wl(POE) kvm snd_hda_codec_realtek snd_hda_codec_generic snd_=
hda_scodec_component irqbypass snd_hda_codec_hdmi snd_hda_intel snd_intel_d=
spcfg snd_intel_sdw_acpi dell_pc ath10k_pci snd_ctl_led snd_hda_codec snd_h=
da_core snd_hwdep ath10k_core snd_pcm snd_timer ath ee1004 snd polyval_clmu=
lni soundcore platform_profile mac80211 rtsx_usb_ms libarc4 polyval_generic=
 sp5100_tco dell_laptop btusb joydev hid_multitouch memstick mousedev ghash=
_clmulni_intel btrtl btintel btbcm btmtk dell_wmi dell_smm_hwmon bluetooth =
sparse_keymap sha1_ssse3 pcspkr i2c_piix4 i2c_hid_acpi dell_smbios dcdbas d=
ell_wmi_descriptor dell_rbtn psmouse wmi_bmof i2c_hid i2c_smbus fam15h_powe=
r k10temp cfg80211 mac_hid rfkill pkcs8_key_parser dm_mod nfnetlink ip_tabl=
es x_tables overlay squashfs loop isofs cdrom amdgpu amdxcp gpu_sched rtsx_=
usb_sdmmc drm_panel_backlight_quirks drm_buddy mmc_core drm_exec<br>[ =C2=
=A0168.532393] =C2=A0sha512_ssse3 drm_suballoc_helper sha256_ssse3 r8169 dr=
m_ttm_helper aesni_intel realtek ttm crypto_simd cryptd i2c_algo_bit mdio_d=
evres uas serio_raw rtsx_usb drm_display_helper libphy usb_storage cec vide=
o wmi<br>[ =C2=A0168.532410] CPU: 0 UID: 0 PID: 13 Comm: kworker/u16:1 Tain=
ted: P =C2=A0 =C2=A0 =C2=A0 =C2=A0W =C2=A0OE =C2=A0 =C2=A0 =C2=A0 6.15.4-ar=
ch2-1 #1 PREEMPT(full) =C2=A0bf56011d6043294f437da1888a30a6d02e6dd116<br>[ =
=C2=A0168.532414] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_=
MODULE, [E]=3DUNSIGNED_MODULE<br>[ =C2=A0168.532415] Hardware name: Dell In=
c. Inspiron 5576/0JW8XC, BIOS 1.0.7 01/29/2018<br>[ =C2=A0168.532417] Workq=
ueue: async async_run_entry_fn<br>[ =C2=A0168.532422] RIP: 0010:amdgpu_irq_=
put+0x46/0x70 [amdgpu]<br>[ =C2=A0168.533294] Code: c0 74 33 48 8b 4e 10 48=
 83 39 00 74 29 89 d1 48 8d 04 88 8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9=
 5f c6 44 d5 e9 5a fd ff ff &lt;0f&gt; 0b b8 ea ff ff ff e9 4e c6 44 d5 b8 =
ea ff ff ff e9 44 c6 44 d5<br>[ =C2=A0168.533296] RSP: 0018:ffffd0864011fd1=
0 EFLAGS: 00010246<br>[ =C2=A0168.533298] RAX: ffff8c57107c4508 RBX: ffff8c=
5717d19e18 RCX: 0000000000000000<br>[ =C2=A0168.533299] RDX: 00000000000000=
02 RSI: ffff8c5717d259a0 RDI: ffff8c5717d00000<br>[ =C2=A0168.533300] RBP: =
ffff8c5717d103b0 R08: ffffd0864011fc98 R09: ffff8c5717d0fb68<br>[ =C2=A0168=
.533301] R10: ffff8c5717d0fb08 R11: 0000000000000000 R12: ffff8c5717d10830<=
br>[ =C2=A0168.533302] R13: 0000000000000002 R14: ffff8c5717d00000 R15: fff=
f8c5717d259a0<br>[ =C2=A0168.533303] FS: =C2=A00000000000000000(0000) GS:ff=
ff8c5a08f2f000(0000) knlGS:0000000000000000<br>[ =C2=A0168.533305] CS: =C2=
=A00010 DS: 0000 ES: 0000 CR0: 0000000080050033<br>[ =C2=A0168.533306] CR2:=
 00007fb941b67000 CR3: 000000010f832000 CR4: 00000000001506f0<br>[ =C2=A016=
8.533307] Call Trace:<br>[ =C2=A0168.533310] =C2=A0&lt;TASK&gt;<br>[ =C2=A0=
168.533311] =C2=A0amdgpu_fence_driver_hw_fini+0xf9/0x130 [amdgpu fd2a246526=
20738c2ec44a27ca03228c2099e273]<br>[ =C2=A0168.534176] =C2=A0amdgpu_device_=
suspend+0xbc/0x160 [amdgpu fd2a24652620738c2ec44a27ca03228c2099e273]<br>[ =
=C2=A0168.535038] =C2=A0pci_pm_suspend+0x80/0x170<br>[ =C2=A0168.535043] =
=C2=A0? __pfx_pci_pm_suspend+0x10/0x10<br>[ =C2=A0168.535045] =C2=A0dpm_run=
_callback+0x4a/0x150<br>[ =C2=A0168.535049] =C2=A0device_suspend+0x14d/0x54=
0<br>[ =C2=A0168.535052] =C2=A0async_suspend+0x21/0x30<br>[ =C2=A0168.53505=
4] =C2=A0async_run_entry_fn+0x36/0x140<br>[ =C2=A0168.535059] =C2=A0process=
_one_work+0x193/0x350<br>[ =C2=A0168.535062] =C2=A0worker_thread+0x2d7/0x41=
0<br>[ =C2=A0168.535064] =C2=A0? __pfx_worker_thread+0x10/0x10<br>[ =C2=A01=
68.535067] =C2=A0kthread+0xfc/0x240<br>[ =C2=A0168.535069] =C2=A0? __pfx_kt=
hread+0x10/0x10<br>[ =C2=A0168.535071] =C2=A0ret_from_fork+0x34/0x50<br>[ =
=C2=A0168.535075] =C2=A0? __pfx_kthread+0x10/0x10<br>[ =C2=A0168.535076] =
=C2=A0ret_from_fork_asm+0x1a/0x30<br>[ =C2=A0168.535081] =C2=A0&lt;/TASK&gt=
;<br>[ =C2=A0168.535082] ---[ end trace 0000000000000000 ]---<br>[ =C2=A016=
8.535169] ------------[ cut here ]------------<br>[ =C2=A0168.535170] WARNI=
NG: CPU: 0 PID: 13 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:631 amdgpu_ir=
q_put+0x46/0x70 [amdgpu]<br>[ =C2=A0168.536047] Modules linked in: ccm algi=
f_aead qrtr crypto_null des3_ede_x86_64 des_generic libdes algif_skcipher c=
mac md4 algif_hash af_alg kvm_amd ccp wl(POE) kvm snd_hda_codec_realtek snd=
_hda_codec_generic snd_hda_scodec_component irqbypass snd_hda_codec_hdmi sn=
d_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi dell_pc ath10k_pci snd_ctl_=
led snd_hda_codec snd_hda_core snd_hwdep ath10k_core snd_pcm snd_timer ath =
ee1004 snd polyval_clmulni soundcore platform_profile mac80211 rtsx_usb_ms =
libarc4 polyval_generic sp5100_tco dell_laptop btusb joydev hid_multitouch =
memstick mousedev ghash_clmulni_intel btrtl btintel btbcm btmtk dell_wmi de=
ll_smm_hwmon bluetooth sparse_keymap sha1_ssse3 pcspkr i2c_piix4 i2c_hid_ac=
pi dell_smbios dcdbas dell_wmi_descriptor dell_rbtn psmouse wmi_bmof i2c_hi=
d i2c_smbus fam15h_power k10temp cfg80211 mac_hid rfkill pkcs8_key_parser d=
m_mod nfnetlink ip_tables x_tables overlay squashfs loop isofs cdrom amdgpu=
 amdxcp gpu_sched rtsx_usb_sdmmc drm_panel_backlight_quirks drm_buddy mmc_c=
ore drm_exec<br>[ =C2=A0168.536112] =C2=A0sha512_ssse3 drm_suballoc_helper =
sha256_ssse3 r8169 drm_ttm_helper aesni_intel realtek ttm crypto_simd crypt=
d i2c_algo_bit mdio_devres uas serio_raw rtsx_usb drm_display_helper libphy=
 usb_storage cec video wmi<br>[ =C2=A0168.536128] CPU: 0 UID: 0 PID: 13 Com=
m: kworker/u16:1 Tainted: P =C2=A0 =C2=A0 =C2=A0 =C2=A0W =C2=A0OE =C2=A0 =
=C2=A0 =C2=A0 6.15.4-arch2-1 #1 PREEMPT(full) =C2=A0bf56011d6043294f437da18=
88a30a6d02e6dd116<br>[ =C2=A0168.536133] Tainted: [P]=3DPROPRIETARY_MODULE,=
 [W]=3DWARN, [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE<br>[ =C2=A0168.536134]=
 Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7 01/29/2018<br>[ =
=C2=A0168.536135] Workqueue: async async_run_entry_fn<br>[ =C2=A0168.536140=
] RIP: 0010:amdgpu_irq_put+0x46/0x70 [amdgpu]<br>[ =C2=A0168.537014] Code: =
c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 d1 48 8d 04 88 8b 08 85 c9 74 11 =
f0 ff 08 74 07 31 c0 e9 5f c6 44 d5 e9 5a fd ff ff &lt;0f&gt; 0b b8 ea ff f=
f ff e9 4e c6 44 d5 b8 ea ff ff ff e9 44 c6 44 d5<br>[ =C2=A0168.537017] RS=
P: 0018:ffffd0864011fd10 EFLAGS: 00010246<br>[ =C2=A0168.537019] RAX: ffff8=
c57107c4508 RBX: ffff8c5717d1a138 RCX: 0000000000000000<br>[ =C2=A0168.5370=
20] RDX: 0000000000000002 RSI: ffff8c5717d259a0 RDI: ffff8c5717d00000<br>[ =
=C2=A0168.537021] RBP: ffff8c5717d103b8 R08: ffffd0864011fc98 R09: ffff8c57=
17d0fb68<br>[ =C2=A0168.537022] R10: ffff8c5717d0fb08 R11: 0000000000000000=
 R12: ffff8c5717d10830<br>[ =C2=A0168.537023] R13: 0000000000000002 R14: ff=
ff8c5717d00000 R15: ffff8c5717d259a0<br>[ =C2=A0168.537024] FS: =C2=A000000=
00000000000(0000) GS:ffff8c5a08f2f000(0000) knlGS:0000000000000000<br>[ =C2=
=A0168.537025] CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 0000000080050033<br>[ =
=C2=A0168.537027] CR2: 00007fb941b67000 CR3: 000000010f832000 CR4: 00000000=
001506f0<br>[ =C2=A0168.537028] Call Trace:<br>[ =C2=A0168.537031] =C2=A0&l=
t;TASK&gt;<br>[ =C2=A0168.537032] =C2=A0amdgpu_fence_driver_hw_fini+0xf9/0x=
130 [amdgpu fd2a24652620738c2ec44a27ca03228c2099e273]<br>[ =C2=A0168.537905=
] =C2=A0amdgpu_device_suspend+0xbc/0x160 [amdgpu fd2a24652620738c2ec44a27ca=
03228c2099e273]<br>[ =C2=A0168.538771] =C2=A0pci_pm_suspend+0x80/0x170<br>[=
 =C2=A0168.538776] =C2=A0? __pfx_pci_pm_suspend+0x10/0x10<br>[ =C2=A0168.53=
8778] =C2=A0dpm_run_callback+0x4a/0x150<br>[ =C2=A0168.538782] =C2=A0device=
_suspend+0x14d/0x540<br>[ =C2=A0168.538785] =C2=A0async_suspend+0x21/0x30<b=
r>[ =C2=A0168.538787] =C2=A0async_run_entry_fn+0x36/0x140<br>[ =C2=A0168.53=
8792] =C2=A0process_one_work+0x193/0x350<br>[ =C2=A0168.538795] =C2=A0worke=
r_thread+0x2d7/0x410<br>[ =C2=A0168.538798] =C2=A0? __pfx_worker_thread+0x1=
0/0x10<br>[ =C2=A0168.538800] =C2=A0kthread+0xfc/0x240<br>[ =C2=A0168.53880=
2] =C2=A0? __pfx_kthread+0x10/0x10<br>[ =C2=A0168.538804] =C2=A0ret_from_fo=
rk+0x34/0x50<br>[ =C2=A0168.538808] =C2=A0? __pfx_kthread+0x10/0x10<br>[ =
=C2=A0168.538810] =C2=A0ret_from_fork_asm+0x1a/0x30<br>[ =C2=A0168.538814] =
=C2=A0&lt;/TASK&gt;<br>[ =C2=A0168.538815] ---[ end trace 0000000000000000 =
]---<br>[ =C2=A0168.538904] ------------[ cut here ]------------<br>[ =C2=
=A0168.538905] WARNING: CPU: 0 PID: 13 at drivers/gpu/drm/amd/amdgpu/amdgpu=
_irq.c:631 amdgpu_irq_put+0x46/0x70 [amdgpu]<br>[ =C2=A0168.539784] Modules=
 linked in: ccm algif_aead qrtr crypto_null des3_ede_x86_64 des_generic lib=
des algif_skcipher cmac md4 algif_hash af_alg kvm_amd ccp wl(POE) kvm snd_h=
da_codec_realtek snd_hda_codec_generic snd_hda_scodec_component irqbypass s=
nd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi dell_pc=
 ath10k_pci snd_ctl_led snd_hda_codec snd_hda_core snd_hwdep ath10k_core sn=
d_pcm snd_timer ath ee1004 snd polyval_clmulni soundcore platform_profile m=
ac80211 rtsx_usb_ms libarc4 polyval_generic sp5100_tco dell_laptop btusb jo=
ydev hid_multitouch memstick mousedev ghash_clmulni_intel btrtl btintel btb=
cm btmtk dell_wmi dell_smm_hwmon bluetooth sparse_keymap sha1_ssse3 pcspkr =
i2c_piix4 i2c_hid_acpi dell_smbios dcdbas dell_wmi_descriptor dell_rbtn psm=
ouse wmi_bmof i2c_hid i2c_smbus fam15h_power k10temp cfg80211 mac_hid rfkil=
l pkcs8_key_parser dm_mod nfnetlink ip_tables x_tables overlay squashfs loo=
p isofs cdrom amdgpu amdxcp gpu_sched rtsx_usb_sdmmc drm_panel_backlight_qu=
irks drm_buddy mmc_core drm_exec<br>[ =C2=A0168.539848] =C2=A0sha512_ssse3 =
drm_suballoc_helper sha256_ssse3 r8169 drm_ttm_helper aesni_intel realtek t=
tm crypto_simd cryptd i2c_algo_bit mdio_devres uas serio_raw rtsx_usb drm_d=
isplay_helper libphy usb_storage cec video wmi<br>[ =C2=A0168.539865] CPU: =
0 UID: 0 PID: 13 Comm: kworker/u16:1 Tainted: P =C2=A0 =C2=A0 =C2=A0 =C2=A0=
W =C2=A0OE =C2=A0 =C2=A0 =C2=A0 6.15.4-arch2-1 #1 PREEMPT(full) =C2=A0bf560=
11d6043294f437da1888a30a6d02e6dd116<br>[ =C2=A0168.539869] Tainted: [P]=3DP=
ROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE<br>[=
 =C2=A0168.539870] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.=
7 01/29/2018<br>[ =C2=A0168.539871] Workqueue: async async_run_entry_fn<br>=
[ =C2=A0168.539877] RIP: 0010:amdgpu_irq_put+0x46/0x70 [amdgpu]<br>[ =C2=A0=
168.540753] Code: c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 d1 48 8d 04 88 =
8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9 5f c6 44 d5 e9 5a fd ff ff &lt;0f=
&gt; 0b b8 ea ff ff ff e9 4e c6 44 d5 b8 ea ff ff ff e9 44 c6 44 d5<br>[ =
=C2=A0168.540755] RSP: 0018:ffffd0864011fd10 EFLAGS: 00010246<br>[ =C2=A016=
8.540757] RAX: ffff8c57107c4508 RBX: ffff8c5717d1a458 RCX: 0000000000000000=
<br>[ =C2=A0168.540758] RDX: 0000000000000002 RSI: ffff8c5717d259a0 RDI: ff=
ff8c5717d00000<br>[ =C2=A0168.540759] RBP: ffff8c5717d103c0 R08: ffffd08640=
11fc98 R09: ffff8c5717d0fb68<br>[ =C2=A0168.540760] R10: ffff8c5717d0fb08 R=
11: 0000000000000000 R12: ffff8c5717d10830<br>[ =C2=A0168.540761] R13: 0000=
000000000002 R14: ffff8c5717d00000 R15: ffff8c5717d259a0<br>[ =C2=A0168.540=
762] FS: =C2=A00000000000000000(0000) GS:ffff8c5a08f2f000(0000) knlGS:00000=
00000000000<br>[ =C2=A0168.540764] CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 00=
00000080050033<br>[ =C2=A0168.540765] CR2: 00007fb941b67000 CR3: 000000010f=
832000 CR4: 00000000001506f0<br>[ =C2=A0168.540766] Call Trace:<br>[ =C2=A0=
168.540769] =C2=A0&lt;TASK&gt;<br>[ =C2=A0168.540770] =C2=A0amdgpu_fence_dr=
iver_hw_fini+0xf9/0x130 [amdgpu fd2a24652620738c2ec44a27ca03228c2099e273]<b=
r>[ =C2=A0168.541634] =C2=A0amdgpu_device_suspend+0xbc/0x160 [amdgpu fd2a24=
652620738c2ec44a27ca03228c2099e273]<br>[ =C2=A0168.542508] =C2=A0pci_pm_sus=
pend+0x80/0x170<br>[ =C2=A0168.542513] =C2=A0? __pfx_pci_pm_suspend+0x10/0x=
10<br>[ =C2=A0168.542516] =C2=A0dpm_run_callback+0x4a/0x150<br>[ =C2=A0168.=
542519] =C2=A0device_suspend+0x14d/0x540<br>[ =C2=A0168.542522] =C2=A0async=
_suspend+0x21/0x30<br>[ =C2=A0168.542524] =C2=A0async_run_entry_fn+0x36/0x1=
40<br>[ =C2=A0168.542529] =C2=A0process_one_work+0x193/0x350<br>[ =C2=A0168=
.542532] =C2=A0worker_thread+0x2d7/0x410<br>[ =C2=A0168.542535] =C2=A0? __p=
fx_worker_thread+0x10/0x10<br>[ =C2=A0168.542537] =C2=A0kthread+0xfc/0x240<=
br>[ =C2=A0168.542539] =C2=A0? __pfx_kthread+0x10/0x10<br>[ =C2=A0168.54254=
1] =C2=A0ret_from_fork+0x34/0x50<br>[ =C2=A0168.542544] =C2=A0? __pfx_kthre=
ad+0x10/0x10<br>[ =C2=A0168.542546] =C2=A0ret_from_fork_asm+0x1a/0x30<br>[ =
=C2=A0168.542551] =C2=A0&lt;/TASK&gt;<br>[ =C2=A0168.542552] ---[ end trace=
 0000000000000000 ]---<br>[ =C2=A0168.542641] ------------[ cut here ]-----=
-------<br>[ =C2=A0168.542642] WARNING: CPU: 0 PID: 13 at drivers/gpu/drm/a=
md/amdgpu/amdgpu_irq.c:631 amdgpu_irq_put+0x46/0x70 [amdgpu]<br>[ =C2=A0168=
.543532] Modules linked in: ccm algif_aead qrtr crypto_null des3_ede_x86_64=
 des_generic libdes algif_skcipher cmac md4 algif_hash af_alg kvm_amd ccp w=
l(POE) kvm snd_hda_codec_realtek snd_hda_codec_generic snd_hda_scodec_compo=
nent irqbypass snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_=
sdw_acpi dell_pc ath10k_pci snd_ctl_led snd_hda_codec snd_hda_core snd_hwde=
p ath10k_core snd_pcm snd_timer ath ee1004 snd polyval_clmulni soundcore pl=
atform_profile mac80211 rtsx_usb_ms libarc4 polyval_generic sp5100_tco dell=
_laptop btusb joydev hid_multitouch memstick mousedev ghash_clmulni_intel b=
trtl btintel btbcm btmtk dell_wmi dell_smm_hwmon bluetooth sparse_keymap sh=
a1_ssse3 pcspkr i2c_piix4 i2c_hid_acpi dell_smbios dcdbas dell_wmi_descript=
or dell_rbtn psmouse wmi_bmof i2c_hid i2c_smbus fam15h_power k10temp cfg802=
11 mac_hid rfkill pkcs8_key_parser dm_mod nfnetlink ip_tables x_tables over=
lay squashfs loop isofs cdrom amdgpu amdxcp gpu_sched rtsx_usb_sdmmc drm_pa=
nel_backlight_quirks drm_buddy mmc_core drm_exec<br>[ =C2=A0168.543597] =C2=
=A0sha512_ssse3 drm_suballoc_helper sha256_ssse3 r8169 drm_ttm_helper aesni=
_intel realtek ttm crypto_simd cryptd i2c_algo_bit mdio_devres uas serio_ra=
w rtsx_usb drm_display_helper libphy usb_storage cec video wmi<br>[ =C2=A01=
68.543614] CPU: 0 UID: 0 PID: 13 Comm: kworker/u16:1 Tainted: P =C2=A0 =C2=
=A0 =C2=A0 =C2=A0W =C2=A0OE =C2=A0 =C2=A0 =C2=A0 6.15.4-arch2-1 #1 PREEMPT(=
full) =C2=A0bf56011d6043294f437da1888a30a6d02e6dd116<br>[ =C2=A0168.543618]=
 Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_MODULE, [E]=3DUNS=
IGNED_MODULE<br>[ =C2=A0168.543619] Hardware name: Dell Inc. Inspiron 5576/=
0JW8XC, BIOS 1.0.7 01/29/2018<br>[ =C2=A0168.543620] Workqueue: async async=
_run_entry_fn<br>[ =C2=A0168.543625] RIP: 0010:amdgpu_irq_put+0x46/0x70 [am=
dgpu]<br>[ =C2=A0168.544513] Code: c0 74 33 48 8b 4e 10 48 83 39 00 74 29 8=
9 d1 48 8d 04 88 8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9 5f c6 44 d5 e9 5=
a fd ff ff &lt;0f&gt; 0b b8 ea ff ff ff e9 4e c6 44 d5 b8 ea ff ff ff e9 44=
 c6 44 d5<br>[ =C2=A0168.544516] RSP: 0018:ffffd0864011fd10 EFLAGS: 0001024=
6<br>[ =C2=A0168.544518] RAX: ffff8c57107c4508 RBX: ffff8c5717d1a778 RCX: 0=
000000000000000<br>[ =C2=A0168.544519] RDX: 0000000000000002 RSI: ffff8c571=
7d259a0 RDI: ffff8c5717d00000<br>[ =C2=A0168.544520] RBP: ffff8c5717d103c8 =
R08: ffffd0864011fc98 R09: ffff8c5717d0fb68<br>[ =C2=A0168.544521] R10: fff=
f8c5717d0fb08 R11: 0000000000000000 R12: ffff8c5717d10830<br>[ =C2=A0168.54=
4522] R13: 0000000000000002 R14: ffff8c5717d00000 R15: ffff8c5717d259a0<br>=
[ =C2=A0168.544523] FS: =C2=A00000000000000000(0000) GS:ffff8c5a08f2f000(00=
00) knlGS:0000000000000000<br>[ =C2=A0168.544524] CS: =C2=A00010 DS: 0000 E=
S: 0000 CR0: 0000000080050033<br>[ =C2=A0168.544526] CR2: 00007fb941b67000 =
CR3: 000000010f832000 CR4: 00000000001506f0<br>[ =C2=A0168.544527] Call Tra=
ce:<br>[ =C2=A0168.544529] =C2=A0&lt;TASK&gt;<br>[ =C2=A0168.544530] =C2=A0=
amdgpu_fence_driver_hw_fini+0xf9/0x130 [amdgpu fd2a24652620738c2ec44a27ca03=
228c2099e273]<br>[ =C2=A0168.545393] =C2=A0amdgpu_device_suspend+0xbc/0x160=
 [amdgpu fd2a24652620738c2ec44a27ca03228c2099e273]<br>[ =C2=A0168.546253] =
=C2=A0pci_pm_suspend+0x80/0x170<br>[ =C2=A0168.546259] =C2=A0? __pfx_pci_pm=
_suspend+0x10/0x10<br>[ =C2=A0168.546261] =C2=A0dpm_run_callback+0x4a/0x150=
<br>[ =C2=A0168.546265] =C2=A0device_suspend+0x14d/0x540<br>[ =C2=A0168.546=
268] =C2=A0async_suspend+0x21/0x30<br>[ =C2=A0168.546270] =C2=A0async_run_e=
ntry_fn+0x36/0x140<br>[ =C2=A0168.546275] =C2=A0process_one_work+0x193/0x35=
0<br>[ =C2=A0168.546278] =C2=A0worker_thread+0x2d7/0x410<br>[ =C2=A0168.546=
281] =C2=A0? __pfx_worker_thread+0x10/0x10<br>[ =C2=A0168.546283] =C2=A0kth=
read+0xfc/0x240<br>[ =C2=A0168.546285] =C2=A0? __pfx_kthread+0x10/0x10<br>[=
 =C2=A0168.546287] =C2=A0ret_from_fork+0x34/0x50<br>[ =C2=A0168.546291] =C2=
=A0? __pfx_kthread+0x10/0x10<br>[ =C2=A0168.546292] =C2=A0ret_from_fork_asm=
+0x1a/0x30<br>[ =C2=A0168.546297] =C2=A0&lt;/TASK&gt;<br>[ =C2=A0168.546298=
] ---[ end trace 0000000000000000 ]---<br>[ =C2=A0168.546392] ------------[=
 cut here ]------------<br>[ =C2=A0168.546393] WARNING: CPU: 0 PID: 13 at d=
rivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:631 amdgpu_irq_put+0x46/0x70 [amdgpu=
]<br>[ =C2=A0168.547276] Modules linked in: ccm algif_aead qrtr crypto_null=
 des3_ede_x86_64 des_generic libdes algif_skcipher cmac md4 algif_hash af_a=
lg kvm_amd ccp wl(POE) kvm snd_hda_codec_realtek snd_hda_codec_generic snd_=
hda_scodec_component irqbypass snd_hda_codec_hdmi snd_hda_intel snd_intel_d=
spcfg snd_intel_sdw_acpi dell_pc ath10k_pci snd_ctl_led snd_hda_codec snd_h=
da_core snd_hwdep ath10k_core snd_pcm snd_timer ath ee1004 snd polyval_clmu=
lni soundcore platform_profile mac80211 rtsx_usb_ms libarc4 polyval_generic=
 sp5100_tco dell_laptop btusb joydev hid_multitouch memstick mousedev ghash=
_clmulni_intel btrtl btintel btbcm btmtk dell_wmi dell_smm_hwmon bluetooth =
sparse_keymap sha1_ssse3 pcspkr i2c_piix4 i2c_hid_acpi dell_smbios dcdbas d=
ell_wmi_descriptor dell_rbtn psmouse wmi_bmof i2c_hid i2c_smbus fam15h_powe=
r k10temp cfg80211 mac_hid rfkill pkcs8_key_parser dm_mod nfnetlink ip_tabl=
es x_tables overlay squashfs loop isofs cdrom amdgpu amdxcp gpu_sched rtsx_=
usb_sdmmc drm_panel_backlight_quirks drm_buddy mmc_core drm_exec<br>[ =C2=
=A0168.547340] =C2=A0sha512_ssse3 drm_suballoc_helper sha256_ssse3 r8169 dr=
m_ttm_helper aesni_intel realtek ttm crypto_simd cryptd i2c_algo_bit mdio_d=
evres uas serio_raw rtsx_usb drm_display_helper libphy usb_storage cec vide=
o wmi<br>[ =C2=A0168.547356] CPU: 0 UID: 0 PID: 13 Comm: kworker/u16:1 Tain=
ted: P =C2=A0 =C2=A0 =C2=A0 =C2=A0W =C2=A0OE =C2=A0 =C2=A0 =C2=A0 6.15.4-ar=
ch2-1 #1 PREEMPT(full) =C2=A0bf56011d6043294f437da1888a30a6d02e6dd116<br>[ =
=C2=A0168.547361] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_=
MODULE, [E]=3DUNSIGNED_MODULE<br>[ =C2=A0168.547362] Hardware name: Dell In=
c. Inspiron 5576/0JW8XC, BIOS 1.0.7 01/29/2018<br>[ =C2=A0168.547363] Workq=
ueue: async async_run_entry_fn<br>[ =C2=A0168.547368] RIP: 0010:amdgpu_irq_=
put+0x46/0x70 [amdgpu]<br>[ =C2=A0168.548257] Code: c0 74 33 48 8b 4e 10 48=
 83 39 00 74 29 89 d1 48 8d 04 88 8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9=
 5f c6 44 d5 e9 5a fd ff ff &lt;0f&gt; 0b b8 ea ff ff ff e9 4e c6 44 d5 b8 =
ea ff ff ff e9 44 c6 44 d5<br>[ =C2=A0168.548259] RSP: 0018:ffffd0864011fd1=
0 EFLAGS: 00010246<br>[ =C2=A0168.548261] RAX: ffff8c571466b040 RBX: ffff8c=
5717d269c8 RCX: 0000000000000000<br>[ =C2=A0168.548262] RDX: 00000000000000=
00 RSI: ffff8c5717d2d338 RDI: ffff8c5717d00000<br>[ =C2=A0168.548263] RBP: =
ffff8c5717d103d8 R08: ffffd0864011fc98 R09: ffff8c5717d0fb68<br>[ =C2=A0168=
.548264] R10: ffff8c5717d0fb08 R11: 0000000000000000 R12: ffff8c5717d10830<=
br>[ =C2=A0168.548265] R13: 0000000000000002 R14: ffff8c5717d00000 R15: fff=
f8c5717d2d338<br>[ =C2=A0168.548266] FS: =C2=A00000000000000000(0000) GS:ff=
ff8c5a08f2f000(0000) knlGS:0000000000000000<br>[ =C2=A0168.548267] CS: =C2=
=A00010 DS: 0000 ES: 0000 CR0: 0000000080050033<br>[ =C2=A0168.548269] CR2:=
 00007fb941b67000 CR3: 000000010f832000 CR4: 00000000001506f0<br>[ =C2=A016=
8.548270] Call Trace:<br>[ =C2=A0168.548273] =C2=A0&lt;TASK&gt;<br>[ =C2=A0=
168.548274] =C2=A0amdgpu_fence_driver_hw_fini+0xf9/0x130 [amdgpu fd2a246526=
20738c2ec44a27ca03228c2099e273]<br>[ =C2=A0168.549135] =C2=A0amdgpu_device_=
suspend+0xbc/0x160 [amdgpu fd2a24652620738c2ec44a27ca03228c2099e273]<br>[ =
=C2=A0168.550007] =C2=A0pci_pm_suspend+0x80/0x170<br>[ =C2=A0168.550013] =
=C2=A0? __pfx_pci_pm_suspend+0x10/0x10<br>[ =C2=A0168.550015] =C2=A0dpm_run=
_callback+0x4a/0x150<br>[ =C2=A0168.550019] =C2=A0device_suspend+0x14d/0x54=
0<br>[ =C2=A0168.550022] =C2=A0async_suspend+0x21/0x30<br>[ =C2=A0168.55002=
4] =C2=A0async_run_entry_fn+0x36/0x140<br>[ =C2=A0168.550028] =C2=A0process=
_one_work+0x193/0x350<br>[ =C2=A0168.550032] =C2=A0worker_thread+0x2d7/0x41=
0<br>[ =C2=A0168.550034] =C2=A0? __pfx_worker_thread+0x10/0x10<br>[ =C2=A01=
68.550037] =C2=A0kthread+0xfc/0x240<br>[ =C2=A0168.550039] =C2=A0? __pfx_kt=
hread+0x10/0x10<br>[ =C2=A0168.550041] =C2=A0ret_from_fork+0x34/0x50<br>[ =
=C2=A0168.550044] =C2=A0? __pfx_kthread+0x10/0x10<br>[ =C2=A0168.550046] =
=C2=A0ret_from_fork_asm+0x1a/0x30<br>[ =C2=A0168.550051] =C2=A0&lt;/TASK&gt=
;<br>[ =C2=A0168.550052] ---[ end trace 0000000000000000 ]---<br>[ =C2=A016=
8.550139] ------------[ cut here ]------------<br>[ =C2=A0168.550140] WARNI=
NG: CPU: 0 PID: 13 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:631 amdgpu_ir=
q_put+0x46/0x70 [amdgpu]<br>[ =C2=A0168.551023] Modules linked in: ccm algi=
f_aead qrtr crypto_null des3_ede_x86_64 des_generic libdes algif_skcipher c=
mac md4 algif_hash af_alg kvm_amd ccp wl(POE) kvm snd_hda_codec_realtek snd=
_hda_codec_generic snd_hda_scodec_component irqbypass snd_hda_codec_hdmi sn=
d_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi dell_pc ath10k_pci snd_ctl_=
led snd_hda_codec snd_hda_core snd_hwdep ath10k_core snd_pcm snd_timer ath =
ee1004 snd polyval_clmulni soundcore platform_profile mac80211 rtsx_usb_ms =
libarc4 polyval_generic sp5100_tco dell_laptop btusb joydev hid_multitouch =
memstick mousedev ghash_clmulni_intel btrtl btintel btbcm btmtk dell_wmi de=
ll_smm_hwmon bluetooth sparse_keymap sha1_ssse3 pcspkr i2c_piix4 i2c_hid_ac=
pi dell_smbios dcdbas dell_wmi_descriptor dell_rbtn psmouse wmi_bmof i2c_hi=
d i2c_smbus fam15h_power k10temp cfg80211 mac_hid rfkill pkcs8_key_parser d=
m_mod nfnetlink ip_tables x_tables overlay squashfs loop isofs cdrom amdgpu=
 amdxcp gpu_sched rtsx_usb_sdmmc drm_panel_backlight_quirks drm_buddy mmc_c=
ore drm_exec<br>[ =C2=A0168.551087] =C2=A0sha512_ssse3 drm_suballoc_helper =
sha256_ssse3 r8169 drm_ttm_helper aesni_intel realtek ttm crypto_simd crypt=
d i2c_algo_bit mdio_devres uas serio_raw rtsx_usb drm_display_helper libphy=
 usb_storage cec video wmi<br>[ =C2=A0168.551104] CPU: 0 UID: 0 PID: 13 Com=
m: kworker/u16:1 Tainted: P =C2=A0 =C2=A0 =C2=A0 =C2=A0W =C2=A0OE =C2=A0 =
=C2=A0 =C2=A0 6.15.4-arch2-1 #1 PREEMPT(full) =C2=A0bf56011d6043294f437da18=
88a30a6d02e6dd116<br>[ =C2=A0168.551108] Tainted: [P]=3DPROPRIETARY_MODULE,=
 [W]=3DWARN, [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE<br>[ =C2=A0168.551109]=
 Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7 01/29/2018<br>[ =
=C2=A0168.551110] Workqueue: async async_run_entry_fn<br>[ =C2=A0168.551115=
] RIP: 0010:amdgpu_irq_put+0x46/0x70 [amdgpu]<br>[ =C2=A0168.551995] Code: =
c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 d1 48 8d 04 88 8b 08 85 c9 74 11 =
f0 ff 08 74 07 31 c0 e9 5f c6 44 d5 e9 5a fd ff ff &lt;0f&gt; 0b b8 ea ff f=
f ff e9 4e c6 44 d5 b8 ea ff ff ff e9 44 c6 44 d5<br>[ =C2=A0168.551997] RS=
P: 0018:ffffd0864011fd10 EFLAGS: 00010246<br>[ =C2=A0168.551999] RAX: ffff8=
c571466b044 RBX: ffff8c5717d27060 RCX: 0000000000000000<br>[ =C2=A0168.5520=
01] RDX: 0000000000000001 RSI: ffff8c5717d2d338 RDI: ffff8c5717d00000<br>[ =
=C2=A0168.552002] RBP: ffff8c5717d103e0 R08: ffffd0864011fc98 R09: ffff8c57=
17d0fb68<br>[ =C2=A0168.552003] R10: ffff8c5717d0fb08 R11: 0000000000000000=
 R12: ffff8c5717d10830<br>[ =C2=A0168.552004] R13: 0000000000000002 R14: ff=
ff8c5717d00000 R15: ffff8c5717d2d338<br>[ =C2=A0168.552005] FS: =C2=A000000=
00000000000(0000) GS:ffff8c5a08f2f000(0000) knlGS:0000000000000000<br>[ =C2=
=A0168.552006] CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 0000000080050033<br>[ =
=C2=A0168.552007] CR2: 00007fb941b67000 CR3: 000000010f832000 CR4: 00000000=
001506f0<br>[ =C2=A0168.552008] Call Trace:<br>[ =C2=A0168.552011] =C2=A0&l=
t;TASK&gt;<br>[ =C2=A0168.552012] =C2=A0amdgpu_fence_driver_hw_fini+0xf9/0x=
130 [amdgpu fd2a24652620738c2ec44a27ca03228c2099e273]<br>[ =C2=A0168.552877=
] =C2=A0amdgpu_device_suspend+0xbc/0x160 [amdgpu fd2a24652620738c2ec44a27ca=
03228c2099e273]<br>[ =C2=A0168.553735] =C2=A0pci_pm_suspend+0x80/0x170<br>[=
 =C2=A0168.553740] =C2=A0? __pfx_pci_pm_suspend+0x10/0x10<br>[ =C2=A0168.55=
3743] =C2=A0dpm_run_callback+0x4a/0x150<br>[ =C2=A0168.553747] =C2=A0device=
_suspend+0x14d/0x540<br>[ =C2=A0168.553750] =C2=A0async_suspend+0x21/0x30<b=
r>[ =C2=A0168.553752] =C2=A0async_run_entry_fn+0x36/0x140<br>[ =C2=A0168.55=
3756] =C2=A0process_one_work+0x193/0x350<br>[ =C2=A0168.553760] =C2=A0worke=
r_thread+0x2d7/0x410<br>[ =C2=A0168.553762] =C2=A0? __pfx_worker_thread+0x1=
0/0x10<br>[ =C2=A0168.553764] =C2=A0kthread+0xfc/0x240<br>[ =C2=A0168.55376=
6] =C2=A0? __pfx_kthread+0x10/0x10<br>[ =C2=A0168.553768] =C2=A0ret_from_fo=
rk+0x34/0x50<br>[ =C2=A0168.553772] =C2=A0? __pfx_kthread+0x10/0x10<br>[ =
=C2=A0168.553774] =C2=A0ret_from_fork_asm+0x1a/0x30<br>[ =C2=A0168.553779] =
=C2=A0&lt;/TASK&gt;<br>[ =C2=A0168.553780] ---[ end trace 0000000000000000 =
]---<br>[ =C2=A0168.553869] ------------[ cut here ]------------<br>[ =C2=
=A0168.553870] WARNING: CPU: 0 PID: 13 at drivers/gpu/drm/amd/amdgpu/amdgpu=
_irq.c:631 amdgpu_irq_put+0x46/0x70 [amdgpu]<br>[ =C2=A0168.554748] Modules=
 linked in: ccm algif_aead qrtr crypto_null des3_ede_x86_64 des_generic lib=
des algif_skcipher cmac md4 algif_hash af_alg kvm_amd ccp wl(POE) kvm snd_h=
da_codec_realtek snd_hda_codec_generic snd_hda_scodec_component irqbypass s=
nd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi dell_pc=
 ath10k_pci snd_ctl_led snd_hda_codec snd_hda_core snd_hwdep ath10k_core sn=
d_pcm snd_timer ath ee1004 snd polyval_clmulni soundcore platform_profile m=
ac80211 rtsx_usb_ms libarc4 polyval_generic sp5100_tco dell_laptop btusb jo=
ydev hid_multitouch memstick mousedev ghash_clmulni_intel btrtl btintel btb=
cm btmtk dell_wmi dell_smm_hwmon bluetooth sparse_keymap sha1_ssse3 pcspkr =
i2c_piix4 i2c_hid_acpi dell_smbios dcdbas dell_wmi_descriptor dell_rbtn psm=
ouse wmi_bmof i2c_hid i2c_smbus fam15h_power k10temp cfg80211 mac_hid rfkil=
l pkcs8_key_parser dm_mod nfnetlink ip_tables x_tables overlay squashfs loo=
p isofs cdrom amdgpu amdxcp gpu_sched rtsx_usb_sdmmc drm_panel_backlight_qu=
irks drm_buddy mmc_core drm_exec<br>[ =C2=A0168.554814] =C2=A0sha512_ssse3 =
drm_suballoc_helper sha256_ssse3 r8169 drm_ttm_helper aesni_intel realtek t=
tm crypto_simd cryptd i2c_algo_bit mdio_devres uas serio_raw rtsx_usb drm_d=
isplay_helper libphy usb_storage cec video wmi<br>[ =C2=A0168.554831] CPU: =
0 UID: 0 PID: 13 Comm: kworker/u16:1 Tainted: P =C2=A0 =C2=A0 =C2=A0 =C2=A0=
W =C2=A0OE =C2=A0 =C2=A0 =C2=A0 6.15.4-arch2-1 #1 PREEMPT(full) =C2=A0bf560=
11d6043294f437da1888a30a6d02e6dd116<br>[ =C2=A0168.554835] Tainted: [P]=3DP=
ROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE<br>[=
 =C2=A0168.554836] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.=
7 01/29/2018<br>[ =C2=A0168.554838] Workqueue: async async_run_entry_fn<br>=
[ =C2=A0168.554843] RIP: 0010:amdgpu_irq_put+0x46/0x70 [amdgpu]<br>[ =C2=A0=
168.555725] Code: c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 d1 48 8d 04 88 =
8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9 5f c6 44 d5 e9 5a fd ff ff &lt;0f=
&gt; 0b b8 ea ff ff ff e9 4e c6 44 d5 b8 ea ff ff ff e9 44 c6 44 d5<br>[ =
=C2=A0168.555727] RSP: 0018:ffffd0864011fd10 EFLAGS: 00010246<br>[ =C2=A016=
8.555729] RAX: ffff8c5715874800 RBX: ffff8c5717d2d480 RCX: 0000000000000000=
<br>[ =C2=A0168.555731] RDX: 0000000000000000 RSI: ffff8c5717d2dde0 RDI: ff=
ff8c5717d00000<br>[ =C2=A0168.555732] RBP: ffff8c5717d103e8 R08: ffffd08640=
11fc98 R09: ffff8c5717d0fb68<br>[ =C2=A0168.555733] R10: ffff8c5717d0fb08 R=
11: 0000000000000000 R12: ffff8c5717d10830<br>[ =C2=A0168.555734] R13: 0000=
000000000002 R14: ffff8c5717d00000 R15: ffff8c5717d2dde0<br>[ =C2=A0168.555=
735] FS: =C2=A00000000000000000(0000) GS:ffff8c5a08f2f000(0000) knlGS:00000=
00000000000<br>[ =C2=A0168.555736] CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 00=
00000080050033<br>[ =C2=A0168.555737] CR2: 00007fb941b67000 CR3: 000000010f=
832000 CR4: 00000000001506f0<br>[ =C2=A0168.555738] Call Trace:<br>[ =C2=A0=
168.555741] =C2=A0&lt;TASK&gt;<br>[ =C2=A0168.555742] =C2=A0amdgpu_fence_dr=
iver_hw_fini+0xf9/0x130 [amdgpu fd2a24652620738c2ec44a27ca03228c2099e273]<b=
r>[ =C2=A0168.556614] =C2=A0amdgpu_device_suspend+0xbc/0x160 [amdgpu fd2a24=
652620738c2ec44a27ca03228c2099e273]<br>[ =C2=A0168.557476] =C2=A0pci_pm_sus=
pend+0x80/0x170<br>[ =C2=A0168.557481] =C2=A0? __pfx_pci_pm_suspend+0x10/0x=
10<br>[ =C2=A0168.557484] =C2=A0dpm_run_callback+0x4a/0x150<br>[ =C2=A0168.=
557488] =C2=A0device_suspend+0x14d/0x540<br>[ =C2=A0168.557491] =C2=A0async=
_suspend+0x21/0x30<br>[ =C2=A0168.557493] =C2=A0async_run_entry_fn+0x36/0x1=
40<br>[ =C2=A0168.557505] =C2=A0process_one_work+0x193/0x350<br>[ =C2=A0168=
.557510] =C2=A0worker_thread+0x2d7/0x410<br>[ =C2=A0168.557513] =C2=A0? __p=
fx_worker_thread+0x10/0x10<br>[ =C2=A0168.557515] =C2=A0kthread+0xfc/0x240<=
br>[ =C2=A0168.557518] =C2=A0? __pfx_kthread+0x10/0x10<br>[ =C2=A0168.55751=
9] =C2=A0ret_from_fork+0x34/0x50<br>[ =C2=A0168.557523] =C2=A0? __pfx_kthre=
ad+0x10/0x10<br>[ =C2=A0168.557525] =C2=A0ret_from_fork_asm+0x1a/0x30<br>[ =
=C2=A0168.557530] =C2=A0&lt;/TASK&gt;<br>[ =C2=A0168.557531] ---[ end trace=
 0000000000000000 ]---<br>[ =C2=A0168.557617] ------------[ cut here ]-----=
-------<br>[ =C2=A0168.557617] WARNING: CPU: 0 PID: 13 at drivers/gpu/drm/a=
md/amdgpu/amdgpu_irq.c:631 amdgpu_irq_put+0x46/0x70 [amdgpu]<br>[ =C2=A0168=
.558505] Modules linked in: ccm algif_aead qrtr crypto_null des3_ede_x86_64=
 des_generic libdes algif_skcipher cmac md4 algif_hash af_alg kvm_amd ccp w=
l(POE) kvm snd_hda_codec_realtek snd_hda_codec_generic snd_hda_scodec_compo=
nent irqbypass snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_=
sdw_acpi dell_pc ath10k_pci snd_ctl_led snd_hda_codec snd_hda_core snd_hwde=
p ath10k_core snd_pcm snd_timer ath ee1004 snd polyval_clmulni soundcore pl=
atform_profile mac80211 rtsx_usb_ms libarc4 polyval_generic sp5100_tco dell=
_laptop btusb joydev hid_multitouch memstick mousedev ghash_clmulni_intel b=
trtl btintel btbcm btmtk dell_wmi dell_smm_hwmon bluetooth sparse_keymap sh=
a1_ssse3 pcspkr i2c_piix4 i2c_hid_acpi dell_smbios dcdbas dell_wmi_descript=
or dell_rbtn psmouse wmi_bmof i2c_hid i2c_smbus fam15h_power k10temp cfg802=
11 mac_hid rfkill pkcs8_key_parser dm_mod nfnetlink ip_tables x_tables over=
lay squashfs loop isofs cdrom amdgpu amdxcp gpu_sched rtsx_usb_sdmmc drm_pa=
nel_backlight_quirks drm_buddy mmc_core drm_exec<br>[ =C2=A0168.558569] =C2=
=A0sha512_ssse3 drm_suballoc_helper sha256_ssse3 r8169 drm_ttm_helper aesni=
_intel realtek ttm crypto_simd cryptd i2c_algo_bit mdio_devres uas serio_ra=
w rtsx_usb drm_display_helper libphy usb_storage cec video wmi<br>[ =C2=A01=
68.558586] CPU: 0 UID: 0 PID: 13 Comm: kworker/u16:1 Tainted: P =C2=A0 =C2=
=A0 =C2=A0 =C2=A0W =C2=A0OE =C2=A0 =C2=A0 =C2=A0 6.15.4-arch2-1 #1 PREEMPT(=
full) =C2=A0bf56011d6043294f437da1888a30a6d02e6dd116<br>[ =C2=A0168.558591]=
 Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_MODULE, [E]=3DUNS=
IGNED_MODULE<br>[ =C2=A0168.558592] Hardware name: Dell Inc. Inspiron 5576/=
0JW8XC, BIOS 1.0.7 01/29/2018<br>[ =C2=A0168.558593] Workqueue: async async=
_run_entry_fn<br>[ =C2=A0168.558599] RIP: 0010:amdgpu_irq_put+0x46/0x70 [am=
dgpu]<br>[ =C2=A0168.559474] Code: c0 74 33 48 8b 4e 10 48 83 39 00 74 29 8=
9 d1 48 8d 04 88 8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9 5f c6 44 d5 e9 5=
a fd ff ff &lt;0f&gt; 0b b8 ea ff ff ff e9 4e c6 44 d5 b8 ea ff ff ff e9 44=
 c6 44 d5<br>[ =C2=A0168.559476] RSP: 0018:ffffd0864011fd10 EFLAGS: 0001024=
6<br>[ =C2=A0168.559478] RAX: ffff8c5715874800 RBX: ffff8c5717d2d7a0 RCX: 0=
000000000000000<br>[ =C2=A0168.559479] RDX: 0000000000000000 RSI: ffff8c571=
7d2dde0 RDI: ffff8c5717d00000<br>[ =C2=A0168.559480] RBP: ffff8c5717d103f0 =
R08: ffffd0864011fc98 R09: ffff8c5717d0fb68<br>[ =C2=A0168.559481] R10: fff=
f8c5717d0fb08 R11: 0000000000000000 R12: ffff8c5717d10830<br>[ =C2=A0168.55=
9482] R13: 0000000000000002 R14: ffff8c5717d00000 R15: ffff8c5717d2dde0<br>=
[ =C2=A0168.559484] FS: =C2=A00000000000000000(0000) GS:ffff8c5a08f2f000(00=
00) knlGS:0000000000000000<br>[ =C2=A0168.559485] CS: =C2=A00010 DS: 0000 E=
S: 0000 CR0: 0000000080050033<br>[ =C2=A0168.559487] CR2: 00007fb941b67000 =
CR3: 000000010f832000 CR4: 00000000001506f0<br>[ =C2=A0168.559488] Call Tra=
ce:<br>[ =C2=A0168.559491] =C2=A0&lt;TASK&gt;<br>[ =C2=A0168.559492] =C2=A0=
amdgpu_fence_driver_hw_fini+0xf9/0x130 [amdgpu fd2a24652620738c2ec44a27ca03=
228c2099e273]<br>[ =C2=A0168.560355] =C2=A0amdgpu_device_suspend+0xbc/0x160=
 [amdgpu fd2a24652620738c2ec44a27ca03228c2099e273]<br>[ =C2=A0168.561214] =
=C2=A0pci_pm_suspend+0x80/0x170<br>[ =C2=A0168.561220] =C2=A0? __pfx_pci_pm=
_suspend+0x10/0x10<br>[ =C2=A0168.561222] =C2=A0dpm_run_callback+0x4a/0x150=
<br>[ =C2=A0168.561226] =C2=A0device_suspend+0x14d/0x540<br>[ =C2=A0168.561=
229] =C2=A0async_suspend+0x21/0x30<br>[ =C2=A0168.561231] =C2=A0async_run_e=
ntry_fn+0x36/0x140<br>[ =C2=A0168.561235] =C2=A0process_one_work+0x193/0x35=
0<br>[ =C2=A0168.561239] =C2=A0worker_thread+0x2d7/0x410<br>[ =C2=A0168.561=
241] =C2=A0? __pfx_worker_thread+0x10/0x10<br>[ =C2=A0168.561243] =C2=A0kth=
read+0xfc/0x240<br>[ =C2=A0168.561246] =C2=A0? __pfx_kthread+0x10/0x10<br>[=
 =C2=A0168.561248] =C2=A0ret_from_fork+0x34/0x50<br>[ =C2=A0168.561251] =C2=
=A0? __pfx_kthread+0x10/0x10<br>[ =C2=A0168.561253] =C2=A0ret_from_fork_asm=
+0x1a/0x30<br>[ =C2=A0168.561258] =C2=A0&lt;/TASK&gt;<br>[ =C2=A0168.561259=
] ---[ end trace 0000000000000000 ]---<br>[ =C2=A0168.561348] ------------[=
 cut here ]------------<br>[ =C2=A0168.561349] WARNING: CPU: 0 PID: 13 at d=
rivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:631 amdgpu_irq_put+0x46/0x70 [amdgpu=
]<br>[ =C2=A0168.562229] Modules linked in: ccm algif_aead qrtr crypto_null=
 des3_ede_x86_64 des_generic libdes algif_skcipher cmac md4 algif_hash af_a=
lg kvm_amd ccp wl(POE) kvm snd_hda_codec_realtek snd_hda_codec_generic snd_=
hda_scodec_component irqbypass snd_hda_codec_hdmi snd_hda_intel snd_intel_d=
spcfg snd_intel_sdw_acpi dell_pc ath10k_pci snd_ctl_led snd_hda_codec snd_h=
da_core snd_hwdep ath10k_core snd_pcm snd_timer ath ee1004 snd polyval_clmu=
lni soundcore platform_profile mac80211 rtsx_usb_ms libarc4 polyval_generic=
 sp5100_tco dell_laptop btusb joydev hid_multitouch memstick mousedev ghash=
_clmulni_intel btrtl btintel btbcm btmtk dell_wmi dell_smm_hwmon bluetooth =
sparse_keymap sha1_ssse3 pcspkr i2c_piix4 i2c_hid_acpi dell_smbios dcdbas d=
ell_wmi_descriptor dell_rbtn psmouse wmi_bmof i2c_hid i2c_smbus fam15h_powe=
r k10temp cfg80211 mac_hid rfkill pkcs8_key_parser dm_mod nfnetlink ip_tabl=
es x_tables overlay squashfs loop isofs cdrom amdgpu amdxcp gpu_sched rtsx_=
usb_sdmmc drm_panel_backlight_quirks drm_buddy mmc_core drm_exec<br>[ =C2=
=A0168.562294] =C2=A0sha512_ssse3 drm_suballoc_helper sha256_ssse3 r8169 dr=
m_ttm_helper aesni_intel realtek ttm crypto_simd cryptd i2c_algo_bit mdio_d=
evres uas serio_raw rtsx_usb drm_display_helper libphy usb_storage cec vide=
o wmi<br>[ =C2=A0168.562310] CPU: 0 UID: 0 PID: 13 Comm: kworker/u16:1 Tain=
ted: P =C2=A0 =C2=A0 =C2=A0 =C2=A0W =C2=A0OE =C2=A0 =C2=A0 =C2=A0 6.15.4-ar=
ch2-1 #1 PREEMPT(full) =C2=A0bf56011d6043294f437da1888a30a6d02e6dd116<br>[ =
=C2=A0168.562315] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_=
MODULE, [E]=3DUNSIGNED_MODULE<br>[ =C2=A0168.562316] Hardware name: Dell In=
c. Inspiron 5576/0JW8XC, BIOS 1.0.7 01/29/2018<br>[ =C2=A0168.562317] Workq=
ueue: async async_run_entry_fn<br>[ =C2=A0168.562322] RIP: 0010:amdgpu_irq_=
put+0x46/0x70 [amdgpu]<br>[ =C2=A0168.563198] Code: c0 74 33 48 8b 4e 10 48=
 83 39 00 74 29 89 d1 48 8d 04 88 8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9=
 5f c6 44 d5 e9 5a fd ff ff &lt;0f&gt; 0b b8 ea ff ff ff e9 4e c6 44 d5 b8 =
ea ff ff ff e9 44 c6 44 d5<br>[ =C2=A0168.563200] RSP: 0018:ffffd0864011fd1=
0 EFLAGS: 00010246<br>[ =C2=A0168.563202] RAX: ffff8c5715874800 RBX: ffff8c=
5717d2dac0 RCX: 0000000000000000<br>[ =C2=A0168.563204] RDX: 00000000000000=
00 RSI: ffff8c5717d2dde0 RDI: ffff8c5717d00000<br>[ =C2=A0168.563205] RBP: =
ffff8c5717d103f8 R08: ffffd0864011fc98 R09: ffff8c5717d0fb68<br>[ =C2=A0168=
.563206] R10: ffff8c5717d0fb08 R11: 0000000000000000 R12: ffff8c5717d10830<=
br>[ =C2=A0168.563207] R13: 0000000000000002 R14: ffff8c5717d00000 R15: fff=
f8c5717d2dde0<br>[ =C2=A0168.563208] FS: =C2=A00000000000000000(0000) GS:ff=
ff8c5a08f2f000(0000) knlGS:0000000000000000<br>[ =C2=A0168.563209] CS: =C2=
=A00010 DS: 0000 ES: 0000 CR0: 0000000080050033<br>[ =C2=A0168.563210] CR2:=
 00007fb941b67000 CR3: 000000010f832000 CR4: 00000000001506f0<br>[ =C2=A016=
8.563212] Call Trace:<br>[ =C2=A0168.563214] =C2=A0&lt;TASK&gt;<br>[ =C2=A0=
168.563215] =C2=A0amdgpu_fence_driver_hw_fini+0xf9/0x130 [amdgpu fd2a246526=
20738c2ec44a27ca03228c2099e273]<br>[ =C2=A0168.564083] =C2=A0amdgpu_device_=
suspend+0xbc/0x160 [amdgpu fd2a24652620738c2ec44a27ca03228c2099e273]<br>[ =
=C2=A0168.564940] =C2=A0pci_pm_suspend+0x80/0x170<br>[ =C2=A0168.564946] =
=C2=A0? __pfx_pci_pm_suspend+0x10/0x10<br>[ =C2=A0168.564948] =C2=A0dpm_run=
_callback+0x4a/0x150<br>[ =C2=A0168.564952] =C2=A0device_suspend+0x14d/0x54=
0<br>[ =C2=A0168.564954] =C2=A0async_suspend+0x21/0x30<br>[ =C2=A0168.56495=
6] =C2=A0async_run_entry_fn+0x36/0x140<br>[ =C2=A0168.564961] =C2=A0process=
_one_work+0x193/0x350<br>[ =C2=A0168.564965] =C2=A0worker_thread+0x2d7/0x41=
0<br>[ =C2=A0168.564967] =C2=A0? __pfx_worker_thread+0x10/0x10<br>[ =C2=A01=
68.564969] =C2=A0kthread+0xfc/0x240<br>[ =C2=A0168.564972] =C2=A0? __pfx_kt=
hread+0x10/0x10<br>[ =C2=A0168.564973] =C2=A0ret_from_fork+0x34/0x50<br>[ =
=C2=A0168.564978] =C2=A0? __pfx_kthread+0x10/0x10<br>[ =C2=A0168.564979] =
=C2=A0ret_from_fork_asm+0x1a/0x30<br>[ =C2=A0168.564984] =C2=A0&lt;/TASK&gt=
;<br>[ =C2=A0168.564985] ---[ end trace 0000000000000000 ]---<br>[ =C2=A016=
8.565077] ------------[ cut here ]------------<br>[ =C2=A0168.565078] WARNI=
NG: CPU: 0 PID: 13 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:631 amdgpu_ir=
q_put+0x46/0x70 [amdgpu]<br>[ =C2=A0168.565969] Modules linked in: ccm algi=
f_aead qrtr crypto_null des3_ede_x86_64 des_generic libdes algif_skcipher c=
mac md4 algif_hash af_alg kvm_amd ccp wl(POE) kvm snd_hda_codec_realtek snd=
_hda_codec_generic snd_hda_scodec_component irqbypass snd_hda_codec_hdmi sn=
d_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi dell_pc ath10k_pci snd_ctl_=
led snd_hda_codec snd_hda_core snd_hwdep ath10k_core snd_pcm snd_timer ath =
ee1004 snd polyval_clmulni soundcore platform_profile mac80211 rtsx_usb_ms =
libarc4 polyval_generic sp5100_tco dell_laptop btusb joydev hid_multitouch =
memstick mousedev ghash_clmulni_intel btrtl btintel btbcm btmtk dell_wmi de=
ll_smm_hwmon bluetooth sparse_keymap sha1_ssse3 pcspkr i2c_piix4 i2c_hid_ac=
pi dell_smbios dcdbas dell_wmi_descriptor dell_rbtn psmouse wmi_bmof i2c_hi=
d i2c_smbus fam15h_power k10temp cfg80211 mac_hid rfkill pkcs8_key_parser d=
m_mod nfnetlink ip_tables x_tables overlay squashfs loop isofs cdrom amdgpu=
 amdxcp gpu_sched rtsx_usb_sdmmc drm_panel_backlight_quirks drm_buddy mmc_c=
ore drm_exec<br>[ =C2=A0168.566034] =C2=A0sha512_ssse3 drm_suballoc_helper =
sha256_ssse3 r8169 drm_ttm_helper aesni_intel realtek ttm crypto_simd crypt=
d i2c_algo_bit mdio_devres uas serio_raw rtsx_usb drm_display_helper libphy=
 usb_storage cec video wmi<br>[ =C2=A0168.566051] CPU: 0 UID: 0 PID: 13 Com=
m: kworker/u16:1 Tainted: P =C2=A0 =C2=A0 =C2=A0 =C2=A0W =C2=A0OE =C2=A0 =
=C2=A0 =C2=A0 6.15.4-arch2-1 #1 PREEMPT(full) =C2=A0bf56011d6043294f437da18=
88a30a6d02e6dd116<br>[ =C2=A0168.566055] Tainted: [P]=3DPROPRIETARY_MODULE,=
 [W]=3DWARN, [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE<br>[ =C2=A0168.566056]=
 Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7 01/29/2018<br>[ =
=C2=A0168.566058] Workqueue: async async_run_entry_fn<br>[ =C2=A0168.566063=
] RIP: 0010:amdgpu_irq_put+0x46/0x70 [amdgpu]<br>[ =C2=A0168.566938] Code: =
c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 d1 48 8d 04 88 8b 08 85 c9 74 11 =
f0 ff 08 74 07 31 c0 e9 5f c6 44 d5 e9 5a fd ff ff &lt;0f&gt; 0b b8 ea ff f=
f ff e9 4e c6 44 d5 b8 ea ff ff ff e9 44 c6 44 d5<br>[ =C2=A0168.566940] RS=
P: 0018:ffffd0864011fd10 EFLAGS: 00010246<br>[ =C2=A0168.566942] RAX: ffff8=
c5702797338 RBX: ffff8c5717d2ec70 RCX: 0000000000000000<br>[ =C2=A0168.5669=
43] RDX: 0000000000000000 RSI: ffff8c5717d2f5d0 RDI: ffff8c5717d00000<br>[ =
=C2=A0168.566944] RBP: ffff8c5717d10400 R08: ffffd0864011fc98 R09: ffff8c57=
17d0fb68<br>[ =C2=A0168.566945] R10: ffff8c5717d0fb08 R11: 0000000000000000=
 R12: ffff8c5717d10830<br>[ =C2=A0168.566946] R13: 0000000000000002 R14: ff=
ff8c5717d00000 R15: ffff8c5717d2f5d0<br>[ =C2=A0168.566947] FS: =C2=A000000=
00000000000(0000) GS:ffff8c5a08f2f000(0000) knlGS:0000000000000000<br>[ =C2=
=A0168.566949] CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 0000000080050033<br>[ =
=C2=A0168.566950] CR2: 00007fb941b67000 CR3: 000000010f832000 CR4: 00000000=
001506f0<br>[ =C2=A0168.566951] Call Trace:<br>[ =C2=A0168.566954] =C2=A0&l=
t;TASK&gt;<br>[ =C2=A0168.566955] =C2=A0amdgpu_fence_driver_hw_fini+0xf9/0x=
130 [amdgpu fd2a24652620738c2ec44a27ca03228c2099e273]<br>[ =C2=A0168.567819=
] =C2=A0amdgpu_device_suspend+0xbc/0x160 [amdgpu fd2a24652620738c2ec44a27ca=
03228c2099e273]<br>[ =C2=A0168.568692] =C2=A0pci_pm_suspend+0x80/0x170<br>[=
 =C2=A0168.568697] =C2=A0? __pfx_pci_pm_suspend+0x10/0x10<br>[ =C2=A0168.56=
8699] =C2=A0dpm_run_callback+0x4a/0x150<br>[ =C2=A0168.568704] =C2=A0device=
_suspend+0x14d/0x540<br>[ =C2=A0168.568706] =C2=A0async_suspend+0x21/0x30<b=
r>[ =C2=A0168.568708] =C2=A0async_run_entry_fn+0x36/0x140<br>[ =C2=A0168.56=
8713] =C2=A0process_one_work+0x193/0x350<br>[ =C2=A0168.568717] =C2=A0worke=
r_thread+0x2d7/0x410<br>[ =C2=A0168.568719] =C2=A0? __pfx_worker_thread+0x1=
0/0x10<br>[ =C2=A0168.568721] =C2=A0kthread+0xfc/0x240<br>[ =C2=A0168.56872=
4] =C2=A0? __pfx_kthread+0x10/0x10<br>[ =C2=A0168.568725] =C2=A0ret_from_fo=
rk+0x34/0x50<br>[ =C2=A0168.568729] =C2=A0? __pfx_kthread+0x10/0x10<br>[ =
=C2=A0168.568731] =C2=A0ret_from_fork_asm+0x1a/0x30<br>[ =C2=A0168.568736] =
=C2=A0&lt;/TASK&gt;<br>[ =C2=A0168.568737] ---[ end trace 0000000000000000 =
]---<br>[ =C2=A0168.568825] ------------[ cut here ]------------<br>[ =C2=
=A0168.568826] WARNING: CPU: 0 PID: 13 at drivers/gpu/drm/amd/amdgpu/amdgpu=
_irq.c:631 amdgpu_irq_put+0x46/0x70 [amdgpu]<br>[ =C2=A0168.569709] Modules=
 linked in: ccm algif_aead qrtr crypto_null des3_ede_x86_64 des_generic lib=
des algif_skcipher cmac md4 algif_hash af_alg kvm_amd ccp wl(POE) kvm snd_h=
da_codec_realtek snd_hda_codec_generic snd_hda_scodec_component irqbypass s=
nd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi dell_pc=
 ath10k_pci snd_ctl_led snd_hda_codec snd_hda_core snd_hwdep ath10k_core sn=
d_pcm snd_timer ath ee1004 snd polyval_clmulni soundcore platform_profile m=
ac80211 rtsx_usb_ms libarc4 polyval_generic sp5100_tco dell_laptop btusb jo=
ydev hid_multitouch memstick mousedev ghash_clmulni_intel btrtl btintel btb=
cm btmtk dell_wmi dell_smm_hwmon bluetooth sparse_keymap sha1_ssse3 pcspkr =
i2c_piix4 i2c_hid_acpi dell_smbios dcdbas dell_wmi_descriptor dell_rbtn psm=
ouse wmi_bmof i2c_hid i2c_smbus fam15h_power k10temp cfg80211 mac_hid rfkil=
l pkcs8_key_parser dm_mod nfnetlink ip_tables x_tables overlay squashfs loo=
p isofs cdrom amdgpu amdxcp gpu_sched rtsx_usb_sdmmc drm_panel_backlight_qu=
irks drm_buddy mmc_core drm_exec<br>[ =C2=A0168.569774] =C2=A0sha512_ssse3 =
drm_suballoc_helper sha256_ssse3 r8169 drm_ttm_helper aesni_intel realtek t=
tm crypto_simd cryptd i2c_algo_bit mdio_devres uas serio_raw rtsx_usb drm_d=
isplay_helper libphy usb_storage cec video wmi<br>[ =C2=A0168.569790] CPU: =
0 UID: 0 PID: 13 Comm: kworker/u16:1 Tainted: P =C2=A0 =C2=A0 =C2=A0 =C2=A0=
W =C2=A0OE =C2=A0 =C2=A0 =C2=A0 6.15.4-arch2-1 #1 PREEMPT(full) =C2=A0bf560=
11d6043294f437da1888a30a6d02e6dd116<br>[ =C2=A0168.569795] Tainted: [P]=3DP=
ROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE<br>[=
 =C2=A0168.569796] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.=
7 01/29/2018<br>[ =C2=A0168.569797] Workqueue: async async_run_entry_fn<br>=
[ =C2=A0168.569802] RIP: 0010:amdgpu_irq_put+0x46/0x70 [amdgpu]<br>[ =C2=A0=
168.570671] Code: c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 d1 48 8d 04 88 =
8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9 5f c6 44 d5 e9 5a fd ff ff &lt;0f=
&gt; 0b b8 ea ff ff ff e9 4e c6 44 d5 b8 ea ff ff ff e9 44 c6 44 d5<br>[ =
=C2=A0168.570673] RSP: 0018:ffffd0864011fd10 EFLAGS: 00010246<br>[ =C2=A016=
8.570675] RAX: ffff8c5702797338 RBX: ffff8c5717d2ef90 RCX: 0000000000000000=
<br>[ =C2=A0168.570676] RDX: 0000000000000000 RSI: ffff8c5717d2f5d0 RDI: ff=
ff8c5717d00000<br>[ =C2=A0168.570677] RBP: ffff8c5717d10408 R08: ffffd08640=
11fc98 R09: ffff8c5717d0fb68<br>[ =C2=A0168.570678] R10: ffff8c5717d0fb08 R=
11: 0000000000000000 R12: ffff8c5717d10830<br>[ =C2=A0168.570679] R13: 0000=
000000000002 R14: ffff8c5717d00000 R15: ffff8c5717d2f5d0<br>[ =C2=A0168.570=
681] FS: =C2=A00000000000000000(0000) GS:ffff8c5a08f2f000(0000) knlGS:00000=
00000000000<br>[ =C2=A0168.570682] CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 00=
00000080050033<br>[ =C2=A0168.570683] CR2: 00007fb941b67000 CR3: 000000010f=
832000 CR4: 00000000001506f0<br>[ =C2=A0168.570684] Call Trace:<br>[ =C2=A0=
168.570687] =C2=A0&lt;TASK&gt;<br>[ =C2=A0168.570688] =C2=A0amdgpu_fence_dr=
iver_hw_fini+0xf9/0x130 [amdgpu fd2a24652620738c2ec44a27ca03228c2099e273]<b=
r>[ =C2=A0168.571545] =C2=A0amdgpu_device_suspend+0xbc/0x160 [amdgpu fd2a24=
652620738c2ec44a27ca03228c2099e273]<br>[ =C2=A0168.572393] =C2=A0pci_pm_sus=
pend+0x80/0x170<br>[ =C2=A0168.572398] =C2=A0? __pfx_pci_pm_suspend+0x10/0x=
10<br>[ =C2=A0168.572400] =C2=A0dpm_run_callback+0x4a/0x150<br>[ =C2=A0168.=
572404] =C2=A0device_suspend+0x14d/0x540<br>[ =C2=A0168.572407] =C2=A0async=
_suspend+0x21/0x30<br>[ =C2=A0168.572409] =C2=A0async_run_entry_fn+0x36/0x1=
40<br>[ =C2=A0168.572414] =C2=A0process_one_work+0x193/0x350<br>[ =C2=A0168=
.572417] =C2=A0worker_thread+0x2d7/0x410<br>[ =C2=A0168.572420] =C2=A0? __p=
fx_worker_thread+0x10/0x10<br>[ =C2=A0168.572422] =C2=A0kthread+0xfc/0x240<=
br>[ =C2=A0168.572424] =C2=A0? __pfx_kthread+0x10/0x10<br>[ =C2=A0168.57242=
6] =C2=A0ret_from_fork+0x34/0x50<br>[ =C2=A0168.572429] =C2=A0? __pfx_kthre=
ad+0x10/0x10<br>[ =C2=A0168.572431] =C2=A0ret_from_fork_asm+0x1a/0x30<br>[ =
=C2=A0168.572436] =C2=A0&lt;/TASK&gt;<br>[ =C2=A0168.572437] ---[ end trace=
 0000000000000000 ]---<br>[ =C2=A0168.572527] ------------[ cut here ]-----=
-------<br>[ =C2=A0168.572528] WARNING: CPU: 0 PID: 13 at drivers/gpu/drm/a=
md/amdgpu/amdgpu_irq.c:631 amdgpu_irq_put+0x46/0x70 [amdgpu]<br>[ =C2=A0168=
.573409] Modules linked in: ccm algif_aead qrtr crypto_null des3_ede_x86_64=
 des_generic libdes algif_skcipher cmac md4 algif_hash af_alg kvm_amd ccp w=
l(POE) kvm snd_hda_codec_realtek snd_hda_codec_generic snd_hda_scodec_compo=
nent irqbypass snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_=
sdw_acpi dell_pc ath10k_pci snd_ctl_led snd_hda_codec snd_hda_core snd_hwde=
p ath10k_core snd_pcm snd_timer ath ee1004 snd polyval_clmulni soundcore pl=
atform_profile mac80211 rtsx_usb_ms libarc4 polyval_generic sp5100_tco dell=
_laptop btusb joydev hid_multitouch memstick mousedev ghash_clmulni_intel b=
trtl btintel btbcm btmtk dell_wmi dell_smm_hwmon bluetooth sparse_keymap sh=
a1_ssse3 pcspkr i2c_piix4 i2c_hid_acpi dell_smbios dcdbas dell_wmi_descript=
or dell_rbtn psmouse wmi_bmof i2c_hid i2c_smbus fam15h_power k10temp cfg802=
11 mac_hid rfkill pkcs8_key_parser dm_mod nfnetlink ip_tables x_tables over=
lay squashfs loop isofs cdrom amdgpu amdxcp gpu_sched rtsx_usb_sdmmc drm_pa=
nel_backlight_quirks drm_buddy mmc_core drm_exec<br>[ =C2=A0168.573473] =C2=
=A0sha512_ssse3 drm_suballoc_helper sha256_ssse3 r8169 drm_ttm_helper aesni=
_intel realtek ttm crypto_simd cryptd i2c_algo_bit mdio_devres uas serio_ra=
w rtsx_usb drm_display_helper libphy usb_storage cec video wmi<br>[ =C2=A01=
68.573489] CPU: 0 UID: 0 PID: 13 Comm: kworker/u16:1 Tainted: P =C2=A0 =C2=
=A0 =C2=A0 =C2=A0W =C2=A0OE =C2=A0 =C2=A0 =C2=A0 6.15.4-arch2-1 #1 PREEMPT(=
full) =C2=A0bf56011d6043294f437da1888a30a6d02e6dd116<br>[ =C2=A0168.573501]=
 Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_MODULE, [E]=3DUNS=
IGNED_MODULE<br>[ =C2=A0168.573502] Hardware name: Dell Inc. Inspiron 5576/=
0JW8XC, BIOS 1.0.7 01/29/2018<br>[ =C2=A0168.573504] Workqueue: async async=
_run_entry_fn<br>[ =C2=A0168.573509] RIP: 0010:amdgpu_irq_put+0x46/0x70 [am=
dgpu]<br>[ =C2=A0168.574385] Code: c0 74 33 48 8b 4e 10 48 83 39 00 74 29 8=
9 d1 48 8d 04 88 8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9 5f c6 44 d5 e9 5=
a fd ff ff &lt;0f&gt; 0b b8 ea ff ff ff e9 4e c6 44 d5 b8 ea ff ff ff e9 44=
 c6 44 d5<br>[ =C2=A0168.574387] RSP: 0018:ffffd0864011fd10 EFLAGS: 0001024=
6<br>[ =C2=A0168.574389] RAX: ffff8c5702797338 RBX: ffff8c5717d2f2b0 RCX: 0=
000000000000000<br>[ =C2=A0168.574390] RDX: 0000000000000000 RSI: ffff8c571=
7d2f5d0 RDI: ffff8c5717d00000<br>[ =C2=A0168.574392] RBP: ffff8c5717d10410 =
R08: ffffd0864011fc98 R09: ffff8c5717d0fb68<br>[ =C2=A0168.574392] R10: fff=
f8c5717d0fb08 R11: 0000000000000000 R12: ffff8c5717d10830<br>[ =C2=A0168.57=
4393] R13: 0000000000000002 R14: ffff8c5717d00000 R15: ffff8c5717d2f5d0<br>=
[ =C2=A0168.574395] FS: =C2=A00000000000000000(0000) GS:ffff8c5a08f2f000(00=
00) knlGS:0000000000000000<br>[ =C2=A0168.574396] CS: =C2=A00010 DS: 0000 E=
S: 0000 CR0: 0000000080050033<br>[ =C2=A0168.574397] CR2: 00007fb941b67000 =
CR3: 000000010f832000 CR4: 00000000001506f0<br>[ =C2=A0168.574399] Call Tra=
ce:<br>[ =C2=A0168.574401] =C2=A0&lt;TASK&gt;<br>[ =C2=A0168.574402] =C2=A0=
amdgpu_fence_driver_hw_fini+0xf9/0x130 [amdgpu fd2a24652620738c2ec44a27ca03=
228c2099e273]<br>[ =C2=A0168.575267] =C2=A0amdgpu_device_suspend+0xbc/0x160=
 [amdgpu fd2a24652620738c2ec44a27ca03228c2099e273]<br>[ =C2=A0168.576129] =
=C2=A0pci_pm_suspend+0x80/0x170<br>[ =C2=A0168.576134] =C2=A0? __pfx_pci_pm=
_suspend+0x10/0x10<br>[ =C2=A0168.576136] =C2=A0dpm_run_callback+0x4a/0x150=
<br>[ =C2=A0168.576141] =C2=A0device_suspend+0x14d/0x540<br>[ =C2=A0168.576=
143] =C2=A0async_suspend+0x21/0x30<br>[ =C2=A0168.576145] =C2=A0async_run_e=
ntry_fn+0x36/0x140<br>[ =C2=A0168.576150] =C2=A0process_one_work+0x193/0x35=
0<br>[ =C2=A0168.576154] =C2=A0worker_thread+0x2d7/0x410<br>[ =C2=A0168.576=
156] =C2=A0? __pfx_worker_thread+0x10/0x10<br>[ =C2=A0168.576158] =C2=A0kth=
read+0xfc/0x240<br>[ =C2=A0168.576161] =C2=A0? __pfx_kthread+0x10/0x10<br>[=
 =C2=A0168.576163] =C2=A0ret_from_fork+0x34/0x50<br>[ =C2=A0168.576166] =C2=
=A0? __pfx_kthread+0x10/0x10<br>[ =C2=A0168.576168] =C2=A0ret_from_fork_asm=
+0x1a/0x30<br>[ =C2=A0168.576173] =C2=A0&lt;/TASK&gt;<br>[ =C2=A0168.576174=
] ---[ end trace 0000000000000000 ]---<br>[ =C2=A0168.590885] ------------[=
 cut here ]------------<br>[ =C2=A0168.590887] WARNING: CPU: 0 PID: 13 at d=
rivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:631 amdgpu_irq_put+0x46/0x70 [amdgpu=
]<br>[ =C2=A0168.591773] Modules linked in: ccm algif_aead qrtr crypto_null=
 des3_ede_x86_64 des_generic libdes algif_skcipher cmac md4 algif_hash af_a=
lg kvm_amd ccp wl(POE) kvm snd_hda_codec_realtek snd_hda_codec_generic snd_=
hda_scodec_component irqbypass snd_hda_codec_hdmi snd_hda_intel snd_intel_d=
spcfg snd_intel_sdw_acpi dell_pc ath10k_pci snd_ctl_led snd_hda_codec snd_h=
da_core snd_hwdep ath10k_core snd_pcm snd_timer ath ee1004 snd polyval_clmu=
lni soundcore platform_profile mac80211 rtsx_usb_ms libarc4 polyval_generic=
 sp5100_tco dell_laptop btusb joydev hid_multitouch memstick mousedev ghash=
_clmulni_intel btrtl btintel btbcm btmtk dell_wmi dell_smm_hwmon bluetooth =
sparse_keymap sha1_ssse3 pcspkr i2c_piix4 i2c_hid_acpi dell_smbios dcdbas d=
ell_wmi_descriptor dell_rbtn psmouse wmi_bmof i2c_hid i2c_smbus fam15h_powe=
r k10temp cfg80211 mac_hid rfkill pkcs8_key_parser dm_mod nfnetlink ip_tabl=
es x_tables overlay squashfs loop isofs cdrom amdgpu amdxcp gpu_sched rtsx_=
usb_sdmmc drm_panel_backlight_quirks drm_buddy mmc_core drm_exec<br>[ =C2=
=A0168.591838] =C2=A0sha512_ssse3 drm_suballoc_helper sha256_ssse3 r8169 dr=
m_ttm_helper aesni_intel realtek ttm crypto_simd cryptd i2c_algo_bit mdio_d=
evres uas serio_raw rtsx_usb drm_display_helper libphy usb_storage cec vide=
o wmi<br>[ =C2=A0168.591855] CPU: 0 UID: 0 PID: 13 Comm: kworker/u16:1 Tain=
ted: P =C2=A0 =C2=A0 =C2=A0 =C2=A0W =C2=A0OE =C2=A0 =C2=A0 =C2=A0 6.15.4-ar=
ch2-1 #1 PREEMPT(full) =C2=A0bf56011d6043294f437da1888a30a6d02e6dd116<br>[ =
=C2=A0168.591860] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_=
MODULE, [E]=3DUNSIGNED_MODULE<br>[ =C2=A0168.591861] Hardware name: Dell In=
c. Inspiron 5576/0JW8XC, BIOS 1.0.7 01/29/2018<br>[ =C2=A0168.591863] Workq=
ueue: async async_run_entry_fn<br>[ =C2=A0168.591868] RIP: 0010:amdgpu_irq_=
put+0x46/0x70 [amdgpu]<br>[ =C2=A0168.592747] Code: c0 74 33 48 8b 4e 10 48=
 83 39 00 74 29 89 d1 48 8d 04 88 8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9=
 5f c6 44 d5 e9 5a fd ff ff &lt;0f&gt; 0b b8 ea ff ff ff e9 4e c6 44 d5 b8 =
ea ff ff ff e9 44 c6 44 d5<br>[ =C2=A0168.592749] RSP: 0018:ffffd0864011fcf=
8 EFLAGS: 00010246<br>[ =C2=A0168.592752] RAX: ffff8c57027976e8 RBX: ffff8c=
5717d00000 RCX: 0000000000000000<br>[ =C2=A0168.592753] RDX: 00000000000000=
00 RSI: ffff8c5717d259b8 RDI: ffff8c5717d00000<br>[ =C2=A0168.592754] RBP: =
ffff8c5717d16fa0 R08: 0000000000000001 R09: ffffffffc0a8cfd0<br>[ =C2=A0168=
.592755] R10: 0000000000005398 R11: 0000000000000000 R12: ffff8c5717d50368<=
br>[ =C2=A0168.592756] R13: ffff8c5717cfffe8 R14: 0000000000000000 R15: fff=
f8c5716adbec0<br>[ =C2=A0168.592758] FS: =C2=A00000000000000000(0000) GS:ff=
ff8c5a08f2f000(0000) knlGS:0000000000000000<br>[ =C2=A0168.592759] CS: =C2=
=A00010 DS: 0000 ES: 0000 CR0: 0000000080050033<br>[ =C2=A0168.592760] CR2:=
 00007fb941b67000 CR3: 000000010f832000 CR4: 00000000001506f0<br>[ =C2=A016=
8.592762] Call Trace:<br>[ =C2=A0168.592765] =C2=A0&lt;TASK&gt;<br>[ =C2=A0=
168.592766] =C2=A0gfx_v8_0_hw_fini+0x2c/0x350 [amdgpu fd2a24652620738c2ec44=
a27ca03228c2099e273]<br>[ =C2=A0168.593658] =C2=A0amdgpu_ip_block_suspend+0=
x27/0x50 [amdgpu fd2a24652620738c2ec44a27ca03228c2099e273]<br>[ =C2=A0168.5=
94515] =C2=A0amdgpu_device_ip_suspend_phase2+0x93/0x200 [amdgpu fd2a2465262=
0738c2ec44a27ca03228c2099e273]<br>[ =C2=A0168.595365] =C2=A0amdgpu_device_s=
uspend+0xc4/0x160 [amdgpu fd2a24652620738c2ec44a27ca03228c2099e273]<br>[ =
=C2=A0168.596230] =C2=A0pci_pm_suspend+0x80/0x170<br>[ =C2=A0168.596236] =
=C2=A0? __pfx_pci_pm_suspend+0x10/0x10<br>[ =C2=A0168.596238] =C2=A0dpm_run=
_callback+0x4a/0x150<br>[ =C2=A0168.596242] =C2=A0device_suspend+0x14d/0x54=
0<br>[ =C2=A0168.596245] =C2=A0async_suspend+0x21/0x30<br>[ =C2=A0168.59624=
7] =C2=A0async_run_entry_fn+0x36/0x140<br>[ =C2=A0168.596252] =C2=A0process=
_one_work+0x193/0x350<br>[ =C2=A0168.596255] =C2=A0worker_thread+0x2d7/0x41=
0<br>[ =C2=A0168.596258] =C2=A0? __pfx_worker_thread+0x10/0x10<br>[ =C2=A01=
68.596260] =C2=A0kthread+0xfc/0x240<br>[ =C2=A0168.596262] =C2=A0? __pfx_kt=
hread+0x10/0x10<br>[ =C2=A0168.596264] =C2=A0ret_from_fork+0x34/0x50<br>[ =
=C2=A0168.596268] =C2=A0? __pfx_kthread+0x10/0x10<br>[ =C2=A0168.596270] =
=C2=A0ret_from_fork_asm+0x1a/0x30<br>[ =C2=A0168.596275] =C2=A0&lt;/TASK&gt=
;<br>[ =C2=A0168.596276] ---[ end trace 0000000000000000 ]---<br>[ =C2=A016=
8.596362] ------------[ cut here ]------------<br>[ =C2=A0168.596363] WARNI=
NG: CPU: 0 PID: 13 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:631 amdgpu_ir=
q_put+0x46/0x70 [amdgpu]<br>[ =C2=A0168.597247] Modules linked in: ccm algi=
f_aead qrtr crypto_null des3_ede_x86_64 des_generic libdes algif_skcipher c=
mac md4 algif_hash af_alg kvm_amd ccp wl(POE) kvm snd_hda_codec_realtek snd=
_hda_codec_generic snd_hda_scodec_component irqbypass snd_hda_codec_hdmi sn=
d_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi dell_pc ath10k_pci snd_ctl_=
led snd_hda_codec snd_hda_core snd_hwdep ath10k_core snd_pcm snd_timer ath =
ee1004 snd polyval_clmulni soundcore platform_profile mac80211 rtsx_usb_ms =
libarc4 polyval_generic sp5100_tco dell_laptop btusb joydev hid_multitouch =
memstick mousedev ghash_clmulni_intel btrtl btintel btbcm btmtk dell_wmi de=
ll_smm_hwmon bluetooth sparse_keymap sha1_ssse3 pcspkr i2c_piix4 i2c_hid_ac=
pi dell_smbios dcdbas dell_wmi_descriptor dell_rbtn psmouse wmi_bmof i2c_hi=
d i2c_smbus fam15h_power k10temp cfg80211 mac_hid rfkill pkcs8_key_parser d=
m_mod nfnetlink ip_tables x_tables overlay squashfs loop isofs cdrom amdgpu=
 amdxcp gpu_sched rtsx_usb_sdmmc drm_panel_backlight_quirks drm_buddy mmc_c=
ore drm_exec<br>[ =C2=A0168.597312] =C2=A0sha512_ssse3 drm_suballoc_helper =
sha256_ssse3 r8169 drm_ttm_helper aesni_intel realtek ttm crypto_simd crypt=
d i2c_algo_bit mdio_devres uas serio_raw rtsx_usb drm_display_helper libphy=
 usb_storage cec video wmi<br>[ =C2=A0168.597329] CPU: 0 UID: 0 PID: 13 Com=
m: kworker/u16:1 Tainted: P =C2=A0 =C2=A0 =C2=A0 =C2=A0W =C2=A0OE =C2=A0 =
=C2=A0 =C2=A0 6.15.4-arch2-1 #1 PREEMPT(full) =C2=A0bf56011d6043294f437da18=
88a30a6d02e6dd116<br>[ =C2=A0168.597334] Tainted: [P]=3DPROPRIETARY_MODULE,=
 [W]=3DWARN, [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE<br>[ =C2=A0168.597334]=
 Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7 01/29/2018<br>[ =
=C2=A0168.597336] Workqueue: async async_run_entry_fn<br>[ =C2=A0168.597341=
] RIP: 0010:amdgpu_irq_put+0x46/0x70 [amdgpu]<br>[ =C2=A0168.598228] Code: =
c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 d1 48 8d 04 88 8b 08 85 c9 74 11 =
f0 ff 08 74 07 31 c0 e9 5f c6 44 d5 e9 5a fd ff ff &lt;0f&gt; 0b b8 ea ff f=
f ff e9 4e c6 44 d5 b8 ea ff ff ff e9 44 c6 44 d5<br>[ =C2=A0168.598230] RS=
P: 0018:ffffd0864011fcf8 EFLAGS: 00010246<br>[ =C2=A0168.598232] RAX: ffff8=
c57027975b8 RBX: ffff8c5717d00000 RCX: 0000000000000000<br>[ =C2=A0168.5982=
33] RDX: 0000000000000000 RSI: ffff8c5717d259d0 RDI: ffff8c5717d00000<br>[ =
=C2=A0168.598234] RBP: ffff8c5717d16fa0 R08: 0000000000000001 R09: ffffffff=
c0a8cfd0<br>[ =C2=A0168.598235] R10: 0000000000005398 R11: 0000000000000000=
 R12: ffff8c5717d50368<br>[ =C2=A0168.598236] R13: ffff8c5717cfffe8 R14: 00=
00000000000000 R15: ffff8c5716adbec0<br>[ =C2=A0168.598238] FS: =C2=A000000=
00000000000(0000) GS:ffff8c5a08f2f000(0000) knlGS:0000000000000000<br>[ =C2=
=A0168.598239] CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 0000000080050033<br>[ =
=C2=A0168.598240] CR2: 00007fb941b67000 CR3: 000000010f832000 CR4: 00000000=
001506f0<br>[ =C2=A0168.598241] Call Trace:<br>[ =C2=A0168.598244] =C2=A0&l=
t;TASK&gt;<br>[ =C2=A0168.598245] =C2=A0gfx_v8_0_hw_fini+0x3d/0x350 [amdgpu=
 fd2a24652620738c2ec44a27ca03228c2099e273]<br>[ =C2=A0168.599123] =C2=A0amd=
gpu_ip_block_suspend+0x27/0x50 [amdgpu fd2a24652620738c2ec44a27ca03228c2099=
e273]<br>[ =C2=A0168.599979] =C2=A0amdgpu_device_ip_suspend_phase2+0x93/0x2=
00 [amdgpu fd2a24652620738c2ec44a27ca03228c2099e273]<br>[ =C2=A0168.600831]=
 =C2=A0amdgpu_device_suspend+0xc4/0x160 [amdgpu fd2a24652620738c2ec44a27ca0=
3228c2099e273]<br>[ =C2=A0168.601701] =C2=A0pci_pm_suspend+0x80/0x170<br>[ =
=C2=A0168.601707] =C2=A0? __pfx_pci_pm_suspend+0x10/0x10<br>[ =C2=A0168.601=
709] =C2=A0dpm_run_callback+0x4a/0x150<br>[ =C2=A0168.601713] =C2=A0device_=
suspend+0x14d/0x540<br>[ =C2=A0168.601716] =C2=A0async_suspend+0x21/0x30<br=
>[ =C2=A0168.601718] =C2=A0async_run_entry_fn+0x36/0x140<br>[ =C2=A0168.601=
723] =C2=A0process_one_work+0x193/0x350<br>[ =C2=A0168.601727] =C2=A0worker=
_thread+0x2d7/0x410<br>[ =C2=A0168.601729] =C2=A0? __pfx_worker_thread+0x10=
/0x10<br>[ =C2=A0168.601732] =C2=A0kthread+0xfc/0x240<br>[ =C2=A0168.601734=
] =C2=A0? __pfx_kthread+0x10/0x10<br>[ =C2=A0168.601736] =C2=A0ret_from_for=
k+0x34/0x50<br>[ =C2=A0168.601739] =C2=A0? __pfx_kthread+0x10/0x10<br>[ =C2=
=A0168.601741] =C2=A0ret_from_fork_asm+0x1a/0x30<br>[ =C2=A0168.601746] =C2=
=A0&lt;/TASK&gt;<br>[ =C2=A0168.601747] ---[ end trace 0000000000000000 ]--=
-<br>[ =C2=A0168.601837] ------------[ cut here ]------------<br>[ =C2=A016=
8.601838] WARNING: CPU: 0 PID: 13 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.=
c:631 amdgpu_irq_put+0x46/0x70 [amdgpu]<br>[ =C2=A0168.602712] Modules link=
ed in: ccm algif_aead qrtr crypto_null des3_ede_x86_64 des_generic libdes a=
lgif_skcipher cmac md4 algif_hash af_alg kvm_amd ccp wl(POE) kvm snd_hda_co=
dec_realtek snd_hda_codec_generic snd_hda_scodec_component irqbypass snd_hd=
a_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi dell_pc ath1=
0k_pci snd_ctl_led snd_hda_codec snd_hda_core snd_hwdep ath10k_core snd_pcm=
 snd_timer ath ee1004 snd polyval_clmulni soundcore platform_profile mac802=
11 rtsx_usb_ms libarc4 polyval_generic sp5100_tco dell_laptop btusb joydev =
hid_multitouch memstick mousedev ghash_clmulni_intel btrtl btintel btbcm bt=
mtk dell_wmi dell_smm_hwmon bluetooth sparse_keymap sha1_ssse3 pcspkr i2c_p=
iix4 i2c_hid_acpi dell_smbios dcdbas dell_wmi_descriptor dell_rbtn psmouse =
wmi_bmof i2c_hid i2c_smbus fam15h_power k10temp cfg80211 mac_hid rfkill pkc=
s8_key_parser dm_mod nfnetlink ip_tables x_tables overlay squashfs loop iso=
fs cdrom amdgpu amdxcp gpu_sched rtsx_usb_sdmmc drm_panel_backlight_quirks =
drm_buddy mmc_core drm_exec<br>[ =C2=A0168.602777] =C2=A0sha512_ssse3 drm_s=
uballoc_helper sha256_ssse3 r8169 drm_ttm_helper aesni_intel realtek ttm cr=
ypto_simd cryptd i2c_algo_bit mdio_devres uas serio_raw rtsx_usb drm_displa=
y_helper libphy usb_storage cec video wmi<br>[ =C2=A0168.602794] CPU: 0 UID=
: 0 PID: 13 Comm: kworker/u16:1 Tainted: P =C2=A0 =C2=A0 =C2=A0 =C2=A0W =C2=
=A0OE =C2=A0 =C2=A0 =C2=A0 6.15.4-arch2-1 #1 PREEMPT(full) =C2=A0bf56011d60=
43294f437da1888a30a6d02e6dd116<br>[ =C2=A0168.602798] Tainted: [P]=3DPROPRI=
ETARY_MODULE, [W]=3DWARN, [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE<br>[ =C2=
=A0168.602799] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7 01=
/29/2018<br>[ =C2=A0168.602801] Workqueue: async async_run_entry_fn<br>[ =
=C2=A0168.602806] RIP: 0010:amdgpu_irq_put+0x46/0x70 [amdgpu]<br>[ =C2=A016=
8.603681] Code: c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 d1 48 8d 04 88 8b=
 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9 5f c6 44 d5 e9 5a fd ff ff &lt;0f&g=
t; 0b b8 ea ff ff ff e9 4e c6 44 d5 b8 ea ff ff ff e9 44 c6 44 d5<br>[ =C2=
=A0168.603683] RSP: 0018:ffffd0864011fcf8 EFLAGS: 00010246<br>[ =C2=A0168.6=
03686] RAX: ffff8c5702797d28 RBX: ffff8c5717d00000 RCX: 0000000000000000<br=
>[ =C2=A0168.603687] RDX: 0000000000000000 RSI: ffff8c5717d25a00 RDI: ffff8=
c5717d00000<br>[ =C2=A0168.603688] RBP: ffff8c5717d16fa0 R08: 0000000000000=
001 R09: ffffffffc0a8cfd0<br>[ =C2=A0168.603689] R10: 0000000000005398 R11:=
 0000000000000000 R12: ffff8c5717d50368<br>[ =C2=A0168.603690] R13: ffff8c5=
717cfffe8 R14: 0000000000000000 R15: ffff8c5716adbec0<br>[ =C2=A0168.603691=
] FS: =C2=A00000000000000000(0000) GS:ffff8c5a08f2f000(0000) knlGS:00000000=
00000000<br>[ =C2=A0168.603693] CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 00000=
00080050033<br>[ =C2=A0168.603694] CR2: 00007fb941b67000 CR3: 000000010f832=
000 CR4: 00000000001506f0<br>[ =C2=A0168.603695] Call Trace:<br>[ =C2=A0168=
.603698] =C2=A0&lt;TASK&gt;<br>[ =C2=A0168.603699] =C2=A0gfx_v8_0_hw_fini+0=
x4e/0x350 [amdgpu fd2a24652620738c2ec44a27ca03228c2099e273]<br>[ =C2=A0168.=
604588] =C2=A0amdgpu_ip_block_suspend+0x27/0x50 [amdgpu fd2a24652620738c2ec=
44a27ca03228c2099e273]<br>[ =C2=A0168.605444] =C2=A0amdgpu_device_ip_suspen=
d_phase2+0x93/0x200 [amdgpu fd2a24652620738c2ec44a27ca03228c2099e273]<br>[ =
=C2=A0168.606307] =C2=A0amdgpu_device_suspend+0xc4/0x160 [amdgpu fd2a246526=
20738c2ec44a27ca03228c2099e273]<br>[ =C2=A0168.607159] =C2=A0pci_pm_suspend=
+0x80/0x170<br>[ =C2=A0168.607165] =C2=A0? __pfx_pci_pm_suspend+0x10/0x10<b=
r>[ =C2=A0168.607167] =C2=A0dpm_run_callback+0x4a/0x150<br>[ =C2=A0168.6071=
71] =C2=A0device_suspend+0x14d/0x540<br>[ =C2=A0168.607174] =C2=A0async_sus=
pend+0x21/0x30<br>[ =C2=A0168.607176] =C2=A0async_run_entry_fn+0x36/0x140<b=
r>[ =C2=A0168.607181] =C2=A0process_one_work+0x193/0x350<br>[ =C2=A0168.607=
184] =C2=A0worker_thread+0x2d7/0x410<br>[ =C2=A0168.607187] =C2=A0? __pfx_w=
orker_thread+0x10/0x10<br>[ =C2=A0168.607189] =C2=A0kthread+0xfc/0x240<br>[=
 =C2=A0168.607191] =C2=A0? __pfx_kthread+0x10/0x10<br>[ =C2=A0168.607193] =
=C2=A0ret_from_fork+0x34/0x50<br>[ =C2=A0168.607197] =C2=A0? __pfx_kthread+=
0x10/0x10<br>[ =C2=A0168.607199] =C2=A0ret_from_fork_asm+0x1a/0x30<br>[ =C2=
=A0168.607204] =C2=A0&lt;/TASK&gt;<br>[ =C2=A0168.607205] ---[ end trace 00=
00000000000000 ]---<br>[ =C2=A0168.607293] ------------[ cut here ]--------=
----<br>[ =C2=A0168.607293] WARNING: CPU: 0 PID: 13 at drivers/gpu/drm/amd/=
amdgpu/amdgpu_irq.c:631 amdgpu_irq_put+0x46/0x70 [amdgpu]<br>[ =C2=A0168.60=
8182] Modules linked in: ccm algif_aead qrtr crypto_null des3_ede_x86_64 de=
s_generic libdes algif_skcipher cmac md4 algif_hash af_alg kvm_amd ccp wl(P=
OE) kvm snd_hda_codec_realtek snd_hda_codec_generic snd_hda_scodec_componen=
t irqbypass snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw=
_acpi dell_pc ath10k_pci snd_ctl_led snd_hda_codec snd_hda_core snd_hwdep a=
th10k_core snd_pcm snd_timer ath ee1004 snd polyval_clmulni soundcore platf=
orm_profile mac80211 rtsx_usb_ms libarc4 polyval_generic sp5100_tco dell_la=
ptop btusb joydev hid_multitouch memstick mousedev ghash_clmulni_intel btrt=
l btintel btbcm btmtk dell_wmi dell_smm_hwmon bluetooth sparse_keymap sha1_=
ssse3 pcspkr i2c_piix4 i2c_hid_acpi dell_smbios dcdbas dell_wmi_descriptor =
dell_rbtn psmouse wmi_bmof i2c_hid i2c_smbus fam15h_power k10temp cfg80211 =
mac_hid rfkill pkcs8_key_parser dm_mod nfnetlink ip_tables x_tables overlay=
 squashfs loop isofs cdrom amdgpu amdxcp gpu_sched rtsx_usb_sdmmc drm_panel=
_backlight_quirks drm_buddy mmc_core drm_exec<br>[ =C2=A0168.608248] =C2=A0=
sha512_ssse3 drm_suballoc_helper sha256_ssse3 r8169 drm_ttm_helper aesni_in=
tel realtek ttm crypto_simd cryptd i2c_algo_bit mdio_devres uas serio_raw r=
tsx_usb drm_display_helper libphy usb_storage cec video wmi<br>[ =C2=A0168.=
608265] CPU: 0 UID: 0 PID: 13 Comm: kworker/u16:1 Tainted: P =C2=A0 =C2=A0 =
=C2=A0 =C2=A0W =C2=A0OE =C2=A0 =C2=A0 =C2=A0 6.15.4-arch2-1 #1 PREEMPT(full=
) =C2=A0bf56011d6043294f437da1888a30a6d02e6dd116<br>[ =C2=A0168.608269] Tai=
nted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_MODULE, [E]=3DUNSIGNE=
D_MODULE<br>[ =C2=A0168.608270] Hardware name: Dell Inc. Inspiron 5576/0JW8=
XC, BIOS 1.0.7 01/29/2018<br>[ =C2=A0168.608272] Workqueue: async async_run=
_entry_fn<br>[ =C2=A0168.608277] RIP: 0010:amdgpu_irq_put+0x46/0x70 [amdgpu=
]<br>[ =C2=A0168.609158] Code: c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 d1=
 48 8d 04 88 8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9 5f c6 44 d5 e9 5a fd=
 ff ff &lt;0f&gt; 0b b8 ea ff ff ff e9 4e c6 44 d5 b8 ea ff ff ff e9 44 c6 =
44 d5<br>[ =C2=A0168.609160] RSP: 0018:ffffd0864011fcf8 EFLAGS: 00010246<br=
>[ =C2=A0168.609162] RAX: ffff8c5702797678 RBX: ffff8c5717d00000 RCX: 00000=
00000000000<br>[ =C2=A0168.609164] RDX: 0000000000000000 RSI: ffff8c5717d25=
a18 RDI: ffff8c5717d00000<br>[ =C2=A0168.609165] RBP: ffff8c5717d16fa0 R08:=
 0000000000000001 R09: ffffffffc0a8cfd0<br>[ =C2=A0168.609166] R10: 0000000=
000005398 R11: 0000000000000000 R12: ffff8c5717d50368<br>[ =C2=A0168.609167=
] R13: ffff8c5717cfffe8 R14: 0000000000000000 R15: ffff8c5716adbec0<br>[ =
=C2=A0168.609168] FS: =C2=A00000000000000000(0000) GS:ffff8c5a08f2f000(0000=
) knlGS:0000000000000000<br>[ =C2=A0168.609170] CS: =C2=A00010 DS: 0000 ES:=
 0000 CR0: 0000000080050033<br>[ =C2=A0168.609171] CR2: 00007fb941b67000 CR=
3: 000000010f832000 CR4: 00000000001506f0<br>[ =C2=A0168.609172] Call Trace=
:<br>[ =C2=A0168.609174] =C2=A0&lt;TASK&gt;<br>[ =C2=A0168.609175] =C2=A0gf=
x_v8_0_hw_fini+0x5f/0x350 [amdgpu fd2a24652620738c2ec44a27ca03228c2099e273]=
<br>[ =C2=A0168.610062] =C2=A0amdgpu_ip_block_suspend+0x27/0x50 [amdgpu fd2=
a24652620738c2ec44a27ca03228c2099e273]<br>[ =C2=A0168.610919] =C2=A0amdgpu_=
device_ip_suspend_phase2+0x93/0x200 [amdgpu fd2a24652620738c2ec44a27ca03228=
c2099e273]<br>[ =C2=A0168.611771] =C2=A0amdgpu_device_suspend+0xc4/0x160 [a=
mdgpu fd2a24652620738c2ec44a27ca03228c2099e273]<br>[ =C2=A0168.612624] =C2=
=A0pci_pm_suspend+0x80/0x170<br>[ =C2=A0168.612629] =C2=A0? __pfx_pci_pm_su=
spend+0x10/0x10<br>[ =C2=A0168.612632] =C2=A0dpm_run_callback+0x4a/0x150<br=
>[ =C2=A0168.612636] =C2=A0device_suspend+0x14d/0x540<br>[ =C2=A0168.612639=
] =C2=A0async_suspend+0x21/0x30<br>[ =C2=A0168.612641] =C2=A0async_run_entr=
y_fn+0x36/0x140<br>[ =C2=A0168.612646] =C2=A0process_one_work+0x193/0x350<b=
r>[ =C2=A0168.612649] =C2=A0worker_thread+0x2d7/0x410<br>[ =C2=A0168.612652=
] =C2=A0? __pfx_worker_thread+0x10/0x10<br>[ =C2=A0168.612654] =C2=A0kthrea=
d+0xfc/0x240<br>[ =C2=A0168.612656] =C2=A0? __pfx_kthread+0x10/0x10<br>[ =
=C2=A0168.612658] =C2=A0ret_from_fork+0x34/0x50<br>[ =C2=A0168.612662] =C2=
=A0? __pfx_kthread+0x10/0x10<br>[ =C2=A0168.612663] =C2=A0ret_from_fork_asm=
+0x1a/0x30<br>[ =C2=A0168.612668] =C2=A0&lt;/TASK&gt;<br>[ =C2=A0168.612669=
] ---[ end trace 0000000000000000 ]---<br>[ =C2=A0168.852463] amdgpu 0000:0=
3:00.0: [drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring kiq_0.2.1.0 tes=
t failed (-110)<br>[ =C2=A0168.853329] [drm:gfx_v8_0_hw_fini [amdgpu]] *ERR=
OR* KCQ disable failed<br>[ =C2=A0169.089064] amdgpu: cp is busy, skip halt=
 cp<br>[ =C2=A0169.323986] amdgpu: rlc is busy, skip halt rlc<br>[ =C2=A016=
9.325086] ------------[ cut here ]------------<br>[ =C2=A0169.325087] WARNI=
NG: CPU: 0 PID: 13 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:631 amdgpu_ir=
q_put+0x46/0x70 [amdgpu]<br>[ =C2=A0169.325978] Modules linked in: ccm algi=
f_aead qrtr crypto_null des3_ede_x86_64 des_generic libdes algif_skcipher c=
mac md4 algif_hash af_alg kvm_amd ccp wl(POE) kvm snd_hda_codec_realtek snd=
_hda_codec_generic snd_hda_scodec_component irqbypass snd_hda_codec_hdmi sn=
d_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi dell_pc ath10k_pci snd_ctl_=
led snd_hda_codec snd_hda_core snd_hwdep ath10k_core snd_pcm snd_timer ath =
ee1004 snd polyval_clmulni soundcore platform_profile mac80211 rtsx_usb_ms =
libarc4 polyval_generic sp5100_tco dell_laptop btusb joydev hid_multitouch =
memstick mousedev ghash_clmulni_intel btrtl btintel btbcm btmtk dell_wmi de=
ll_smm_hwmon bluetooth sparse_keymap sha1_ssse3 pcspkr i2c_piix4 i2c_hid_ac=
pi dell_smbios dcdbas dell_wmi_descriptor dell_rbtn psmouse wmi_bmof i2c_hi=
d i2c_smbus fam15h_power k10temp cfg80211 mac_hid rfkill pkcs8_key_parser d=
m_mod nfnetlink ip_tables x_tables overlay squashfs loop isofs cdrom amdgpu=
 amdxcp gpu_sched rtsx_usb_sdmmc drm_panel_backlight_quirks drm_buddy mmc_c=
ore drm_exec<br>[ =C2=A0169.326045] =C2=A0sha512_ssse3 drm_suballoc_helper =
sha256_ssse3 r8169 drm_ttm_helper aesni_intel realtek ttm crypto_simd crypt=
d i2c_algo_bit mdio_devres uas serio_raw rtsx_usb drm_display_helper libphy=
 usb_storage cec video wmi<br>[ =C2=A0169.326062] CPU: 0 UID: 0 PID: 13 Com=
m: kworker/u16:1 Tainted: P =C2=A0 =C2=A0 =C2=A0 =C2=A0W =C2=A0OE =C2=A0 =
=C2=A0 =C2=A0 6.15.4-arch2-1 #1 PREEMPT(full) =C2=A0bf56011d6043294f437da18=
88a30a6d02e6dd116<br>[ =C2=A0169.326067] Tainted: [P]=3DPROPRIETARY_MODULE,=
 [W]=3DWARN, [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE<br>[ =C2=A0169.326068]=
 Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7 01/29/2018<br>[ =
=C2=A0169.326070] Workqueue: async async_run_entry_fn<br>[ =C2=A0169.326076=
] RIP: 0010:amdgpu_irq_put+0x46/0x70 [amdgpu]<br>[ =C2=A0169.326963] Code: =
c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 d1 48 8d 04 88 8b 08 85 c9 74 11 =
f0 ff 08 74 07 31 c0 e9 5f c6 44 d5 e9 5a fd ff ff &lt;0f&gt; 0b b8 ea ff f=
f ff e9 4e c6 44 d5 b8 ea ff ff ff e9 44 c6 44 d5<br>[ =C2=A0169.326965] RS=
P: 0018:ffffd0864011fd08 EFLAGS: 00010246<br>[ =C2=A0169.326967] RAX: ffff8=
c5700ba5a00 RBX: ffff8c5717d00000 RCX: 0000000000000000<br>[ =C2=A0169.3269=
68] RDX: 0000000000000000 RSI: ffff8c5717d00c78 RDI: ffff8c5717d00000<br>[ =
=C2=A0169.326969] RBP: ffff8c5717d00000 R08: 0000000000000000 R09: 00000000=
ffffefff<br>[ =C2=A0169.326971] R10: ffffffff97060f20 R11: ffffd0864011fad8=
 R12: 0000000000000001<br>[ =C2=A0169.326972] R13: ffff8c5717cfffe8 R14: 00=
00000000000000 R15: ffff8c5716adbec0<br>[ =C2=A0169.326973] FS: =C2=A000000=
00000000000(0000) GS:ffff8c5a08f2f000(0000) knlGS:0000000000000000<br>[ =C2=
=A0169.326974] CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 0000000080050033<br>[ =
=C2=A0169.326976] CR2: 00007fb941b67000 CR3: 000000010f832000 CR4: 00000000=
001506f0<br>[ =C2=A0169.326977] Call Trace:<br>[ =C2=A0169.326980] =C2=A0&l=
t;TASK&gt;<br>[ =C2=A0169.326982] =C2=A0gmc_v8_0_hw_fini+0x1f/0xa0 [amdgpu =
fd2a24652620738c2ec44a27ca03228c2099e273]<br>[ =C2=A0169.327859] =C2=A0amdg=
pu_ip_block_suspend+0x27/0x50 [amdgpu fd2a24652620738c2ec44a27ca03228c2099e=
273]<br>[ =C2=A0169.328718] =C2=A0amdgpu_device_ip_suspend_phase2+0x93/0x20=
0 [amdgpu fd2a24652620738c2ec44a27ca03228c2099e273]<br>[ =C2=A0169.329571] =
=C2=A0amdgpu_device_suspend+0xc4/0x160 [amdgpu fd2a24652620738c2ec44a27ca03=
228c2099e273]<br>[ =C2=A0169.330437] =C2=A0pci_pm_suspend+0x80/0x170<br>[ =
=C2=A0169.330442] =C2=A0? __pfx_pci_pm_suspend+0x10/0x10<br>[ =C2=A0169.330=
445] =C2=A0dpm_run_callback+0x4a/0x150<br>[ =C2=A0169.330449] =C2=A0device_=
suspend+0x14d/0x540<br>[ =C2=A0169.330451] =C2=A0async_suspend+0x21/0x30<br=
>[ =C2=A0169.330454] =C2=A0async_run_entry_fn+0x36/0x140<br>[ =C2=A0169.330=
458] =C2=A0process_one_work+0x193/0x350<br>[ =C2=A0169.330461] =C2=A0worker=
_thread+0x2d7/0x410<br>[ =C2=A0169.330464] =C2=A0? __pfx_worker_thread+0x10=
/0x10<br>[ =C2=A0169.330466] =C2=A0kthread+0xfc/0x240<br>[ =C2=A0169.330469=
] =C2=A0? __pfx_kthread+0x10/0x10<br>[ =C2=A0169.330470] =C2=A0ret_from_for=
k+0x34/0x50<br>[ =C2=A0169.330474] =C2=A0? __pfx_kthread+0x10/0x10<br>[ =C2=
=A0169.330476] =C2=A0ret_from_fork_asm+0x1a/0x30<br>[ =C2=A0169.330481] =C2=
=A0&lt;/TASK&gt;<br>[ =C2=A0169.330482] ---[ end trace 0000000000000000 ]--=
-<br>[ =C2=A0169.331853] amdgpu 0000:03:00.0: amdgpu: PCI CONFIG reset<br>[=
 =C2=A0169.331892] ACPI: EC: interrupt blocked<br>[ =C2=A0169.356423] ACPI:=
 PM: Preparing to enter system sleep state S3<br>[ =C2=A0169.683675] ACPI W=
arning: Time parameter 120 us &gt; 100 us violating ACPI spec, please fix t=
he firmware. (20240827/exsystem-142)<br>[ =C2=A0169.684493] ACPI: EC: event=
 blocked<br>[ =C2=A0169.684494] ACPI: EC: EC stopped<br>[ =C2=A0169.684499]=
 ACPI: PM: Saving platform NVS memory<br>[ =C2=A0169.684597] Disabling non-=
boot CPUs ...<br>[ =C2=A0169.686850] smpboot: CPU 3 is now offline<br>[ =C2=
=A0169.689865] smpboot: CPU 2 is now offline<br>[ =C2=A0169.691960] smpboot=
: CPU 1 is now offline<br>[ =C2=A0169.693173] ACPI: PM: Low-level resume co=
mplete<br>[ =C2=A0169.693207] ACPI: EC: EC started<br>[ =C2=A0169.693209] A=
CPI: PM: Restoring platform NVS memory<br>[ =C2=A0169.693373] AMD-Vi: Virtu=
al APIC enabled<br>[ =C2=A0169.693399] AMD-Vi: Virtual APIC enabled<br>[ =
=C2=A0169.693402] LVT offset 0 assigned for vector 0x400<br>[ =C2=A0169.693=
879] Enabling non-boot CPUs ...<br>[ =C2=A0169.694017] smpboot: Booting Nod=
e 0 Processor 1 APIC 0x11<br>[ =C2=A0169.697328] CPU1 is up<br>[ =C2=A0169.=
697443] smpboot: Booting Node 0 Processor 2 APIC 0x12<br>[ =C2=A0169.700804=
] CPU2 is up<br>[ =C2=A0169.700852] smpboot: Booting Node 0 Processor 3 API=
C 0x13<br>[ =C2=A0169.704275] CPU3 is up<br>[ =C2=A0169.705527] ACPI: PM: W=
aking up from system sleep state S3<br>[ =C2=A0169.756540] ACPI: EC: interr=
upt unblocked<br>[ =C2=A0169.762681] ACPI: EC: event unblocked<br>[ =C2=A01=
69.762744] [drm] PCIE GART of 1024M enabled (table at 0x000000F400A00000).<=
br>[ =C2=A0169.762777] amdgpu: smu version 27.17.00<br>[ =C2=A0169.779692] =
[drm] PCIE GART of 256M enabled (table at 0x000000F4FFF80000).<br>[ =C2=A01=
69.796793] [drm] UVD initialized successfully.<br>[ =C2=A0169.886421] r8169=
 0000:02:00.0 enp2s0: Link is Down<br>[ =C2=A0169.997757] [drm] VCE initial=
ized successfully.<br>[ =C2=A0170.005696] usb 1-2: reset high-speed USB dev=
ice number 2 using xhci_hcd<br>[ =C2=A0170.015456] usb 2-1.2: reset full-sp=
eed USB device number 3 using ehci-pci<br>[ =C2=A0170.098578] amdgpu 0000:0=
3:00.0: [drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring comp_1.0.0 test=
 failed (-110)<br>[ =C2=A0170.177583] usb 2-1.4: reset high-speed USB devic=
e number 4 using ehci-pci<br>[ =C2=A0170.226387] ata1: SATA link up 6.0 Gbp=
s (SStatus 133 SControl 300)<br>[ =C2=A0170.228682] sd 0:0:0:0: [sda] Start=
ing disk<br>[ =C2=A0170.232144] ata1.00: configured for UDMA/133<br>[ =C2=
=A0170.351309] amdgpu 0000:03:00.0: [drm:amdgpu_ring_test_helper [amdgpu]] =
*ERROR* ring comp_1.0.1 test failed (-110)<br>[ =C2=A0170.571090] amdgpu 00=
00:03:00.0: [drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring comp_1.0.2 =
test failed (-110)<br>[ =C2=A0170.805800] amdgpu 0000:03:00.0: [drm:amdgpu_=
ring_test_helper [amdgpu]] *ERROR* ring comp_1.0.3 test failed (-110)<br>[ =
=C2=A0171.023340] amdgpu 0000:03:00.0: [drm:amdgpu_ring_test_helper [amdgpu=
]] *ERROR* ring comp_1.0.4 test failed (-110)<br>[ =C2=A0171.240880] amdgpu=
 0000:03:00.0: [drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring comp_1.0=
.5 test failed (-110)<br>[ =C2=A0171.458377] amdgpu 0000:03:00.0: [drm:amdg=
pu_ring_test_helper [amdgpu]] *ERROR* ring comp_1.0.6 test failed (-110)<br=
>[ =C2=A0171.675888] amdgpu 0000:03:00.0: [drm:amdgpu_ring_test_helper [amd=
gpu]] *ERROR* ring comp_1.0.7 test failed (-110)<br>[ =C2=A0171.815833] [dr=
m] UVD and UVD ENC initialized successfully.<br>[ =C2=A0171.926824] [drm] V=
CE initialized successfully.<br>[ =C2=A0171.933077] Bluetooth: hci0: using =
rampatch file: qca/rampatch_usb_00000302.bin<br>[ =C2=A0171.947453] Bluetoo=
th: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x11=
1<br>[ =C2=A0171.947605] OOM killer enabled.<br>[ =C2=A0171.947609] Restart=
ing tasks ... done.<br>[ =C2=A0171.948631] random: crng reseeded on system =
resumption<br>[ =C2=A0171.954861] kauditd_printk_skb: 101 callbacks suppres=
sed<br>[ =C2=A0171.954867] audit: type=3D1130 audit(1770274074.259:152): pi=
d=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D&#39;unit=3Dsystemd-=
networkd-wait-online comm=3D&quot;systemd&quot; exe=3D&quot;/usr/lib/system=
d/systemd&quot; hostname=3D? addr=3D? terminal=3D? res=3Dfailed&#39;<br>[ =
=C2=A0171.958630] audit: type=3D1334 audit(1770274074.263:153): prog-id=3D7=
7 op=3DLOAD<br>[ =C2=A0171.959752] PM: suspend exit<br>[ =C2=A0171.975426] =
audit: type=3D1130 audit(1770274074.280:154): pid=3D1 uid=3D0 auid=3D429496=
7295 ses=3D4294967295 msg=3D&#39;unit=3Dsystemd-suspend comm=3D&quot;system=
d&quot; exe=3D&quot;/usr/lib/systemd/systemd&quot; hostname=3D? addr=3D? te=
rminal=3D? res=3Dsuccess&#39;<br>[ =C2=A0171.975463] audit: type=3D1131 aud=
it(1770274074.280:155): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 =
msg=3D&#39;unit=3Dsystemd-suspend comm=3D&quot;systemd&quot; exe=3D&quot;/u=
sr/lib/systemd/systemd&quot; hostname=3D? addr=3D? terminal=3D? res=3Dsucce=
ss&#39;<br>[ =C2=A0171.996521] audit: type=3D1130 audit(1770274074.301:156)=
: pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D&#39;unit=3Dsyst=
emd-rfkill comm=3D&quot;systemd&quot; exe=3D&quot;/usr/lib/systemd/systemd&=
quot; hostname=3D? addr=3D? terminal=3D? res=3Dsuccess&#39;<br>[ =C2=A0172.=
318079] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin<br>[ =C2=
=A0172.340918] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection c=
ommand is advertised, but not supported.<br>[ =C2=A0172.370988] =C2=A0sdb: =
sdb1 sdb2<br>[ =C2=A0174.760490] audit: type=3D1130 audit(1770274077.065:15=
7): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D&#39;unit=3Dre=
flector comm=3D&quot;systemd&quot; exe=3D&quot;/usr/lib/systemd/systemd&quo=
t; hostname=3D? addr=3D? terminal=3D? res=3Dfailed&#39;<br>[ =C2=A0174.7718=
02] audit: type=3D1334 audit(1770274077.076:158): prog-id=3D77 op=3DUNLOAD<=
br>[ =C2=A0177.004176] audit: type=3D1131 audit(1770274079.308:159): pid=3D=
1 uid=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D&#39;unit=3Dsystemd-rfki=
ll comm=3D&quot;systemd&quot; exe=3D&quot;/usr/lib/systemd/systemd&quot; ho=
stname=3D? addr=3D? terminal=3D? res=3Dsuccess&#39;<br>[ =C2=A0184.802183] =
audit: type=3D1334 audit(1770274087.106:160): prog-id=3D78 op=3DLOAD<br>[ =
=C2=A0185.038826] audit: type=3D1130 audit(1770274087.343:161): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D&#39;unit=3Dreflector comm=3D=
&quot;systemd&quot; exe=3D&quot;/usr/lib/systemd/systemd&quot; hostname=3D?=
 addr=3D? terminal=3D? res=3Dfailed&#39;<br>[ =C2=A0185.045739] audit: type=
=3D1334 audit(1770274087.350:162): prog-id=3D78 op=3DUNLOAD</div></div>

--000000000000339502064a0d901c--
