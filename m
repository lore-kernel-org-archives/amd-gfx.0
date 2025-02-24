Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0FF7C021BB
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2025 14:06:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7421B10E44F;
	Mon, 24 Feb 2025 14:06:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mbIxhBM5";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D19210E44F
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2025 14:06:08 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-2f9b8ef4261so1140003a91.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2025 06:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740405968; x=1741010768; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gAbVg61pCWeIbZgTI2u2EoGMecAtiHrnGrNqwi3nBus=;
 b=mbIxhBM5xp/MO0jLpRXTxWI3PWcse9oVMtBNAdXVpr4baZJoQ3TCo0Mx7lRv2/vF6I
 kk1XfrgzdHzps10a6s4trPnni+dIhLMvVYDLimLK6gVK3Zeit3locEzNxpHY0SwH7feC
 d+SWJNUjHcLJgcSJ4nIsnwOUJ4KGLEwGTn2APLodHL1SJeno+PJF1b7kqa15I5DzcaNe
 +uLU9I4v9ZtioGoO8RQz6wu7ebvDzEi2jkKtm8fdbPg1HSJamHBHHOkVrG3tTaGLr9fz
 PzPmqaWnLY33Pa73erfSIviuAKu6OMMNGBiyC1hV+9mzr+5Leesd4gid1cPNHMYpSlyG
 VShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740405968; x=1741010768;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gAbVg61pCWeIbZgTI2u2EoGMecAtiHrnGrNqwi3nBus=;
 b=CT3s5mupV/eKBZs5rJLr5pkmmnnI4Dz4KI9k3zEdq4zoZmTHtPFiu6o+cuRqywX01I
 pCngRzffMPuLNrrVQvFI1ouDJWxpyY/CJSWv3n/jpP6Fy9unoYRBN9WOtGrxzyLrSraL
 cSvs7xsO3zOFLCPb43DKN098FAm0X9WqlqKWFxmrzsDmvEXJrNCzU6GWL7k40ha1hWNv
 fyd+iPqVur/1aglWoogHWizyHa9ThdivATGrJAIvpu89hYbSSOc/VV4OViD0WMJW7nBJ
 Hw79ayiqyV5u9VFp1+WoKJPj5/bQKlaX0o7hLuk8GwI3qdwNYpWg4cDuMyClZRxVBbTU
 APsQ==
X-Gm-Message-State: AOJu0YzJu47cXPeNraypwTjQwME80VpejA/H9DDRiVCEWaU4+p75hFx8
 wyy6se8HBlIbWOF0dqPFJd37FAbyjlBBa9NJU/81MZ/7sq07uJLfm2OckrP+56g7IQXyteWUM2D
 /5dfuNXNwX4NSbDOmZhSq8uD3YAEXxQ==
X-Gm-Gg: ASbGnct63o3qt3mI5TWoJI7X+elbw4kIGIQv/sV1snqb1ANOF8u9YjK/ZeTQf5ciVS7
 6A1bknOMb17RhtDmZoUOBtHFWUacm1FF+V4UA8oZCKt+x+0s0kaCXlVAqhEK2hRKz1b9a5C0emV
 vfzBYNoOM=
X-Google-Smtp-Source: AGHT+IHARLFTlhs1QDTuPCd2rpszgU8i9hEiLxcRJJXleKwD3jnF0J5zr1NdOnr3mmEp76SdWUX5mASkzOLLGHhwNdg=
X-Received: by 2002:a17:90b:350c:b0:2ee:e518:c1d4 with SMTP id
 98e67ed59e1d1-2fce77a63cfmr9132884a91.1.1740405967565; Mon, 24 Feb 2025
 06:06:07 -0800 (PST)
MIME-Version: 1.0
References: <87seo3ga1t.fsf@tarshish>
In-Reply-To: <87seo3ga1t.fsf@tarshish>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 24 Feb 2025 09:05:56 -0500
X-Gm-Features: AWEUYZkSjUsN3lVKkUWgyu9HDJUuKpkE_9AcXbVfN3AMKipb8JwGOMapODTFHbg
Message-ID: <CADnq5_P+_iGePpp9c1Sr85-z7fgWxq1iejpHxuyVO_G5nW8kYw@mail.gmail.com>
Subject: Re: [drm:amdgpu_ring_test_helper] *ERROR* ring kiq_0.2.1.0 test
 failed (-110)
To: Baruch Siach <baruch@tkos.co.il>
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Feb 24, 2025 at 8:51=E2=80=AFAM Baruch Siach <baruch@tkos.co.il> wr=
ote:
>
> Hi amd-gfx list,
>
> I see this failure on probe when trying to bring up amdgpu on a new arm64
> platform.  Kernel is v6.14-rc4, and aldebaran firmware is latest
> (linux-firmware commit 4f47e84d06f9).
>
> Tested with these kernel command line parameters:
>
> amdgpu.vm_size=3D1 amdgpu.msi=3D1 amdgpu.gartsize=3D32 amdgpu.vramlimit=
=3D32 amdgpu.gttsize=3D32

Why are you setting those?  Does the driver load ok if you do not
specify those driver options?

>
> I guess the "CP firmware version" warning is bogus. IP version for GC_HWI=
P is
> 9.4.2.
>
> Any idea?

Potentially the driver parameters combination is causing a problem, or
your ARM SoC may not be PCIe compliant.  A lot of small SoC's just
throw a PCIe bridge on the SoC without proper coherency in place
between the CPU and the PCIe bus.  PCIe requires cohorency with the
CPU (i.e., the device can snoop the CPU's cache).

Alex

>
> Relevant log snippets follows:
>
> [    1.792949] pci 0000:05:00.0: [1002:740f] type 00 class 0x038000 PCIe =
Endpoint
> [    1.800652] pci 0000:05:00.0: BAR 0 [mem 0x00000000-0xfffffffff 64bit =
pref]
> [    1.807629] pci 0000:05:00.0: BAR 2 [mem 0x00000000-0x001fffff 64bit p=
ref]
> [    1.814506] pci 0000:05:00.0: BAR 4 [io  0x0000-0x00ff]
> [    1.819729] pci 0000:05:00.0: BAR 5 [mem 0x00000000-0x0007ffff]
> [    1.825647] pci 0000:05:00.0: ROM [mem 0x00000000-0x0001ffff pref]
> [    1.833297] pci 0000:05:00.0: PME# supported from D1 D2 D3hot D3cold
> [    1.840118] pci 0000:05:00.0: 126.024 Gb/s available PCIe bandwidth, l=
imited by 16.0 GT/s PCIe x8 link at 0000:02:00.0 (capable of 252.048 Gb/s w=
ith 16.0 GT/s PCIe x16 link)
> [    1.857150] pci_bus 0000:05: busn_res: [bus 05-ff] end is updated to 0=
5
> ...
> [    2.615336] pci 0000:05:00.0: BAR 0 [mem 0x1000000000-0x1fffffffff 64b=
it pref]: assigned
> [    2.623529] pci 0000:05:00.0: BAR 2 [mem 0x2000000000-0x20001fffff 64b=
it pref]: assigned
> [    2.631720] pci 0000:05:00.0: BAR 5 [mem 0x5d000000-0x5d07ffff]: assig=
ned
> [    2.638544] pci 0000:05:00.0: ROM [mem 0x5d080000-0x5d09ffff pref]: as=
signed
> [    2.645583] pci 0000:05:00.0: BAR 4 [io  size 0x0100]: can't assign; n=
o space
> [    2.652707] pci 0000:05:00.0: BAR 4 [io  size 0x0100]: failed to assig=
n
> ...
> [    3.153154] amdgpu 0000:05:00.0: enabling device (0000 -> 0002)
> [    3.159112] [drm] initializing kernel modesetting (ALDEBARAN 0x1002:0x=
740F 0x1002:0x0C34 0x02).
> [    3.167817] [drm] register mmio base: 0x5D000000
> [    3.172425] [drm] register mmio size: 524288
> [    3.176775] amdgpu 0000:05:00.0: amdgpu: detected ip block number 0 <s=
oc15_common>
> [    3.184341] amdgpu 0000:05:00.0: amdgpu: detected ip block number 1 <g=
mc_v9_0>
> [    3.191558] amdgpu 0000:05:00.0: amdgpu: detected ip block number 2 <v=
ega20_ih>
> [    3.198858] amdgpu 0000:05:00.0: amdgpu: detected ip block number 3 <p=
sp>
> [    3.205639] amdgpu 0000:05:00.0: amdgpu: detected ip block number 4 <s=
mu>
> [    3.212421] amdgpu 0000:05:00.0: amdgpu: detected ip block number 5 <g=
fx_v9_0>
> [    3.219635] amdgpu 0000:05:00.0: amdgpu: detected ip block number 6 <s=
dma_v4_0>
> [    3.226935] amdgpu 0000:05:00.0: amdgpu: detected ip block number 7 <v=
cn_v2_6>
> [    3.234149] amdgpu 0000:05:00.0: amdgpu: detected ip block number 8 <j=
peg_v2_6>
> [    3.247351] amdgpu 0000:05:00.0: amdgpu: Fetched VBIOS from ROM BAR
> [    3.253626] amdgpu: ATOM BIOS: 113-D67301V-073
> [    3.259731] [drm] CP firmware version too old, please update!
> [    3.260400] amdgpu 0000:05:00.0: amdgpu: Trusted Memory Zone (TMZ) fea=
ture not supported
> [    3.274294] amdgpu 0000:05:00.0: amdgpu: PCIE atomic ops is not suppor=
ted
> [    3.281115] amdgpu 0000:05:00.0: amdgpu: MEM ECC is active.
> [    3.286679] amdgpu 0000:05:00.0: amdgpu: SRAM ECC is active.
> [    3.292351] amdgpu 0000:05:00.0: amdgpu: RAS INFO: ras initialized suc=
cessfully, hardware ability[7ff7f] ras_mask[7ff7f]
> [    3.303232] [drm] vm size is 1 GB, 2 levels, block size is 9-bit, frag=
ment size is 9-bit
> [    3.311338] amdgpu 0000:05:00.0: amdgpu: VRAM: 65520M 0x00000200000000=
00 - 0x0000020FFEFFFFFF (32M used)
> [    3.320811] amdgpu 0000:05:00.0: amdgpu: GART: 32M 0x0000000000000000 =
- 0x0000000001FFFFFF
> [    3.329070] [drm] Detected VRAM RAM=3D65520M, BAR=3D65536M
> [    3.334199] [drm] RAM width 4096bits HBM
> [    3.338251] [drm] amdgpu: 32M of VRAM memory ready
> [    3.343039] [drm] amdgpu: 32M of GTT memory ready.
> [    3.347861] [drm] GART: num cpu pages 8192, num gpu pages 8192
> [    3.353779] [drm] PCIE GART of 32M enabled.
> [    3.357955] [drm] PTB located at 0x0000020001FF0000
> [    3.365901] [drm] Found VCN firmware Version ENC: 1.1 DEC: 1 VEP: 0 Re=
vision: 28
> [    3.432199] amdgpu 0000:05:00.0: amdgpu: reserve 0x800000 from 0x20001=
000000 for PSP TMR
> [    3.504497] amdgpu 0000:05:00.0: amdgpu: smu driver if version =3D 0x0=
0000008, smu fw if version =3D 0x00000009, smu fw program =3D 0, smu fw ver=
sion =3D 0x00443f00 (68.63.0)
> [    3.519356] amdgpu 0000:05:00.0: amdgpu: SMU driver if version not mat=
ched
> [    3.526265] amdgpu 0000:05:00.0: amdgpu: use vbios provided pptable
> [    3.532523] amdgpu 0000:05:00.0: amdgpu: smc_dpm_info table revision(f=
ormat.content): 4.10
> [    3.560964] amdgpu 0000:05:00.0: amdgpu: SMU is initialized successful=
ly!
> [    3.568167] [drm] kiq ring mec 2 pipe 1 q 0
> [    3.785160] amdgpu 0000:05:00.0: [drm:amdgpu_ring_test_helper] *ERROR*=
 ring kiq_0.2.1.0 test failed (-110)
> [    3.794825] [drm:amdgpu_gfx_enable_kcq] *ERROR* KCQ enable failed
> [    3.800929] [drm:amdgpu_device_init] *ERROR* hw_init of IP block <gfx_=
v9_0> failed -110
> [    3.808929] amdgpu 0000:05:00.0: amdgpu: amdgpu_device_ip_init failed
> [    3.815361] amdgpu 0000:05:00.0: amdgpu: Fatal error during GPU init
> [    3.821705] amdgpu 0000:05:00.0: amdgpu: amdgpu: finishing device.
>
> Thanks,
> baruch
>
> --
>                                                      ~. .~   Tk Open Syst=
ems
> =3D}------------------------------------------------ooO--U--Ooo----------=
--{=3D
>    - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
