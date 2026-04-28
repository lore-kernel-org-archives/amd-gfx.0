Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83359FF885A
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 16:07:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0908B10E352;
	Tue, 28 Apr 2026 16:07:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ONQcPx1B";
	dkim-atps=neutral
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1774B10E352
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 16:07:52 +0000 (UTC)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-2e92c54ba73so631291eec.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 09:07:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777392471; cv=none;
 d=google.com; s=arc-20240605;
 b=FIzC+OCtALYAZgEduRiNFLc51cVcq0DiNrYz46sLYqQ3AhD4itiY3mxOEFfzHUoQ5W
 07YnzBYnO8h3do+5a/kqHHlQmaIhPS0YUAEXda2YMA2yN86/F47AwC/2UYoKLTXO4xnS
 o8WRzB2D945yNJH+RSu9bl7yGn7YVECPgx9q1I95p6LZXImmFx2tjm9sbjHDDLAppJW7
 1IRQDxHnBgTyqdFZVdAtDNs9zAtwnVY81MIArJvPJX9pam2F+MLj/9E7AntFuZZ+R6Jk
 o/diOFXweDjg/EgOgtRhRbQ322bDnfJSDgtsEqak31cC2avYb+s2y1ZYubCndbTlq+Ci
 kyNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=olDeWjloYaeTL1PBheI0cu9IruPda14JwSB8bRKtTy8=;
 fh=KuTVmZRp4oJZJj9SgzgBZ1Cv0rVJ4LoHCwEhp8iKJyQ=;
 b=jntl0btaFFdb1Ubc7BSmQjXsDZuO38GEMEnjl/a/Vx906PS1dnI7HYlsKGiLYQzQvB
 nJufyQt/qzKnGNwd/WRAM0CgX0SCRfllf3WkXDmWhSz/vMh2CPqktF7g1GpfCSvMzzdh
 w3RXnRzmpkIfMmYQGV26LI1cC2iNljQad9l7Nop677CV/d8mP01YB63ZXQwjI8/6KmWH
 5j0pR2KLeeLm1eIwn5CTn58iPclRvTil+wYmcAhLfDbvCvQYexEHdQLrBc3TV/SB8qC5
 zO9RBELsxeKvd6XV3oIRv1LiIZZM9119K1iuxqz5JRCjtNbLnDEhpWKOnHFdJmZRoshJ
 G7Bw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777392471; x=1777997271; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=olDeWjloYaeTL1PBheI0cu9IruPda14JwSB8bRKtTy8=;
 b=ONQcPx1BJSmYLAvvvngSfrk4hDd7v5sHgy3bIM+0tTAiCNHtj/kMzS+bhO2blgrZXe
 IqZOSAN6WwtZiZ04FEst/aNwf/kC3wb0Loc4c00p+hDOq6lBrDnyY6Nigpyn+5ShLKmm
 Yqh6BP6w2QwUqAhdOnwNvjBQpCkqoxQklpA8jXMsbxKmunGGmMMoVBLgXExQdSTTEch7
 M0xOHYa4PgCiRuKMkFmp4gsM6KKikoZVzqVjg6R4bdtP5l3+NdAOzSlcgjNcSxCw+bhy
 YQIQG14xdCiUEVDeJOgtRQJyuqxFdSEZhzEgli2mlxp9zs5igK8bxo+UJE1OkGRv6Gg+
 hmfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777392471; x=1777997271;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=olDeWjloYaeTL1PBheI0cu9IruPda14JwSB8bRKtTy8=;
 b=AI1A6EJikqGU8eXhSabVY5SzrSj0xRzIj5iq6V0OJmbdvx57XCS/FfaFnIDwrHPl2l
 XAR/+Y6+XU9txUZ4KTLZDRvBAIi5odrJZuJtzUgkG1uBvsazj+4tLApd9wkrGnn3Tahk
 124ARKFAb4eZ2Shn+zkR5qp+ix5HiLaEAT162utMZqwcNfYpag/0d/MLknLIwIe95y/a
 dXDx/2fMOt/JPZru2A/rwSlkH2Grh1BWMbSwufbSSCSVFhOjdInnt6KT9hWTU+IgPkvs
 HFkjRQpu5CAsvpylwOWfGiE9SIbAvI5kfgRHUGVr3shMVmMKxIQClnWDjP/oWFBthK0o
 fOjg==
X-Gm-Message-State: AOJu0YwjlsbMviXLoeA1RoOTyko+Gn+fJSbcM/ZcILULA0DRbCEqu+DV
 VZD1D72C1cCgEqtvVfiYwjXDn8H7yV6Y9ESc0PUtbJUgXwBUjNNucvLSs4UmPECcbnYKUI8kvTs
 nxVaYyRBj1sBJV8UTsWIreesngNCXM4lX4mLB
X-Gm-Gg: AeBDietvo1T8moWvWQ9Pay1oVoQhjgu1qDUyPLbr3E5dDsGa0A8rxSHD8qvIK3XDUUp
 BhqDvbFkF0hoW0/moCaZBE1W95w2eyeigv5XjgmZtVqz0Dq2RP74cyL09UGRVnh0C/v/fkomUIZ
 git1qQYsEMqVYL3zkYlWeaKTcvnr1weK/OOjRInSBXy0e5gEsu01fzfIh2+++a0XF7Flya5C5eV
 oFucWxhqRGg3e6WxZB4vGmO4FE9NRkI+Xf+QJEKbT1UCl0chyTdJuwc8LHxnkc8IBc53yiz7b4l
 wXBGWEw1Lpf177BOuBF9p9iyKDe+gac0t/AO9oQ+D//VTuFZFf328S1lyf5w3U3sgzoIZ49pUQX
 Mgqtw
X-Received: by 2002:a05:7022:618c:b0:12d:c389:ae54 with SMTP id
 a92af1059eb24-12ddd4e12admr991605c88.2.1777392470725; Tue, 28 Apr 2026
 09:07:50 -0700 (PDT)
MIME-Version: 1.0
References: <832b0927-fff2-90b3-538c-8e1890f3f42c@xwax.org>
In-Reply-To: <832b0927-fff2-90b3-538c-8e1890f3f42c@xwax.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 28 Apr 2026 12:07:37 -0400
X-Gm-Features: AVHnY4JnL761aUjr8rIQp3TjLa0xldU2lMjVnqOmbt3l6sYH8LxDW3DrYlwZhtM
Message-ID: <CADnq5_Px_vh0OLLjT9vohcp07yK9m_5NNLPvHz=KMfo564gJTQ@mail.gmail.com>
Subject: Re: Radeon Pro WX7100 regression since v6.19, no display
To: Mark Hills <mark@xwax.org>
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

On Tue, Apr 28, 2026 at 7:44=E2=80=AFAM Mark Hills <mark@xwax.org> wrote:
>
> The last kernel I have been able to use is v6.19.3, because shortly after
> I lose functionality of my Radeon Pro WX7100.
>
> Normally around the point udevd is run, I see a switch from "BIOS"-style
> console to some kind of framebuffer one, followed by launching Xorg.
>
> With later kernels, around the time of udevd the displays (LG DualUp,
> DisplayPort) freeze and swich to "no signal". The host is alive to SSH.
>
> I can boot the last 'good' kernel (v6.19.3) and today (v7.0.1), with the
> diff shown below.
>
> There doesn't seem to be an obvious or visible error to investigate,
> mostly:
>
> * No longer any information printed about connected displays
>
> * The bad kernel is printing initialisation "successful" messages in a
>   slow loop, which I presume is Xorg re-starting
>
> * The missing "fb0: amdgpudrmfb frame buffer device" which is
>   presumably by Xorg complains about no /dev/fb0
>
> I hope this is a credible bug report and perhaps clear what's going on to
> those who understand how the parts (drm,amdgpu,fb,fbcon,modesetting) fit
> together.
>
> At this stage a "bisect" would be quite involved, but not ruled out.
>
> System is i5-6500, losely based on Slackware-current, I run my own kernel
> and rc scripts, with no initrd.

Looks like you built your kernel without CONFIG_DRM_AMD_DC=3Dy.  That is
necessary for the display hardware support to be built into your
kernel.  7.0.x dropped support for the old legacy display support
since it's deprecated for years and has much less functionality
compared to DC.

Alex

>
> Thanks
>
> --
> Mark
>
>
> $ diff -up <(grep -E '(amdgpu|drm|fb|fbcon)' dmesg.good) <(grep -E '(amdg=
pu|drm|fb|fbcon)' dmesg.bad)
> --- /dev/fd/63  2026-04-28 11:18:51.152662564 +0100
> +++ /dev/fd/62  2026-04-28 11:18:51.152662564 +0100
> @@ -1,77 +1,75 @@
> +Command line: root=3D/dev/sda2 fbcon=3Drotate_all:1 BOOT_IMAGE=3Dvmlinuz
> +Kernel command line: root=3D/dev/sda2 fbcon=3Drotate_all:1 BOOT_IMAGE=3D=
vmlinuz
> +Unknown kernel command line parameters "fbcon=3Drotate_all:1", will be p=
assed to user space.
>  pci 0000:00:1c.4:   bridge window [mem 0xefb00000-0xefbfffff]
>  pci 0000:0b:00.0: BAR 0 [mem 0xefb00000-0xefb03fff 64bit]
>  pci 0000:00:1c.4:   bridge window [mem 0xefb00000-0xefbfffff]
>  pci_bus 0000:0b: resource 1 [mem 0xefb00000-0xefbfffff]
> +    fbcon=3Drotate_all:1
>  ACPI: bus type drm_connector registered
> -[drm] amdgpu kernel modesetting enabled.
> -[drm] initializing kernel modesetting (POLARIS10 0x1002:0x67C4 0x1002:0x=
0B0D 0x00).
> -[drm] register mmio base: 0xEFE00000
> -[drm] register mmio size: 262144
> -amdgpu 0000:01:00.0: amdgpu: detected ip block number 0 <vi_common>
> -amdgpu 0000:01:00.0: amdgpu: detected ip block number 1 <gmc_v8_0>
> -amdgpu 0000:01:00.0: amdgpu: detected ip block number 2 <tonga_ih>
> -amdgpu 0000:01:00.0: amdgpu: detected ip block number 3 <gfx_v8_0>
> -amdgpu 0000:01:00.0: amdgpu: detected ip block number 4 <sdma_v3_0>
> -amdgpu 0000:01:00.0: amdgpu: detected ip block number 5 <powerplay>
> -amdgpu 0000:01:00.0: amdgpu: detected ip block number 6 <dce_v11_0>
> -amdgpu 0000:01:00.0: amdgpu: detected ip block number 7 <uvd_v6_0>
> -amdgpu 0000:01:00.0: amdgpu: detected ip block number 8 <vce_v3_0>
> +amdgpu 0000:01:00.0: initializing kernel modesetting (POLARIS10 0x1002:0=
x67C4 0x1002:0x0B0D 0x00).
> +amdgpu 0000:01:00.0: register mmio base: 0xEFE00000
> +amdgpu 0000:01:00.0: register mmio size: 262144
> +amdgpu 0000:01:00.0: detected ip block number 0 <common_v1_0_0> (vi_comm=
on)
> +amdgpu 0000:01:00.0: detected ip block number 1 <gmc_v8_1_0> (gmc_v8_0)
> +amdgpu 0000:01:00.0: detected ip block number 2 <ih_v3_0_0> (tonga_ih)
> +amdgpu 0000:01:00.0: detected ip block number 3 <gfx_v8_0_0> (gfx_v8_0)
> +amdgpu 0000:01:00.0: detected ip block number 4 <sdma_v3_1_0> (sdma_v3_0=
)
> +amdgpu 0000:01:00.0: detected ip block number 5 <smu_v1_0_0> (powerplay)
> +amdgpu 0000:01:00.0: detected ip block number 6 <uvd_v6_3_0> (uvd_v6_0)
> +amdgpu 0000:01:00.0: detected ip block number 7 <vce_v3_4_0> (vce_v3_0)
>  amdgpu 0000:01:00.0: No more image in the PCI ROM
> -amdgpu 0000:01:00.0: amdgpu: Fetched VBIOS from ROM BAR
> -amdgpu: ATOM BIOS: 113-C9540101-103
> -[drm] UVD is enabled in VM mode
> -[drm] UVD ENC is enabled in VM mode
> -[drm] VCE enabled in VM mode
> +amdgpu 0000:01:00.0: Fetched VBIOS from ROM BAR
> +amdgpu 0000:01:00.0: [drm] ATOM BIOS: 113-C9540101-103
> +amdgpu 0000:01:00.0: [drm] UVD is enabled in VM mode
> +amdgpu 0000:01:00.0: [drm] UVD ENC is enabled in VM mode
> +amdgpu 0000:01:00.0: Found VCE firmware Version: 53.26 Binary ID: 3
> +amdgpu 0000:01:00.0: [drm] VCE enabled in VM mode
>  amdgpu 0000:01:00.0: vgaarb: deactivate vga console
> -amdgpu 0000:01:00.0: amdgpu: Trusted Memory Zone (TMZ) feature not suppo=
rted
> -[drm] vm size is 128 GB, 2 levels, block size is 10-bit, fragment size i=
s 9-bit
> -[drm] System can't access extended configuration space, please check!!
> -amdgpu 0000:01:00.0: BAR 2 [mem 0xe0000000-0xe01fffff 64bit pref]: relea=
sing
> -amdgpu 0000:01:00.0: BAR 0 [mem 0xd0000000-0xdfffffff 64bit pref]: relea=
sing
> -amdgpu 0000:01:00.0: BAR 0 [mem 0xd0000000-0xdfffffff 64bit pref]: assig=
ned
> -amdgpu 0000:01:00.0: BAR 2 [mem 0xe0000000-0xe01fffff 64bit pref]: assig=
ned
> -amdgpu 0000:01:00.0: amdgpu: VRAM: 8192M 0x000000F400000000 - 0x000000F5=
FFFFFFFF (8192M used)
> -amdgpu 0000:01:00.0: amdgpu: GART: 256M 0x000000FF00000000 - 0x000000FF0=
FFFFFFF
> -[drm] Detected VRAM RAM=3D8192M, BAR=3D256M
> -[drm] RAM width 256bits GDDR5
> -[drm] amdgpu: 8192M of VRAM memory ready
> -[drm] amdgpu: 20047M of GTT memory ready.
> -[drm] GART: num cpu pages 65536, num gpu pages 65536
> -[drm] PCIE GART of 256M enabled (table at 0x000000F400900000).
> -[drm] Chained IB support enabled!
> +amdgpu 0000:01:00.0: Trusted Memory Zone (TMZ) feature not supported
> +amdgpu 0000:01:00.0: vm size is 128 GB, 2 levels, block size is 10-bit, =
fragment size is 9-bit
> +amdgpu 0000:01:00.0: System can't access extended configuration space, p=
lease check!!
> +amdgpu 0000:01:00.0: VRAM: 8192M 0x000000F400000000 - 0x000000F5FFFFFFFF=
 (8192M used)
> +amdgpu 0000:01:00.0: GART: 256M 0x000000FF00000000 - 0x000000FF0FFFFFFF
> +amdgpu 0000:01:00.0: [drm] Detected VRAM RAM=3D8192M, BAR=3D256M
> +amdgpu 0000:01:00.0: [drm] RAM width 256bits GDDR5
> +amdgpu 0000:01:00.0:  8192M of VRAM memory ready
> +amdgpu 0000:01:00.0:  20047M of GTT memory ready.
> +amdgpu 0000:01:00.0: [drm] GART: num cpu pages 65536, num gpu pages 6553=
6
> +amdgpu 0000:01:00.0: [drm] PCIE GART of 256M enabled (table at 0x000000F=
400900000).
> +amdgpu 0000:01:00.0: [drm] Chained IB support enabled!
>  amdgpu: hwmgr_sw_init smu backed is polaris10_smu
> -[drm] AMDGPU Display Connectors
> -[drm] Connector 0:
> -[drm]   DP-1
> -[drm]   HPD6
> -[drm]   DDC: 0x4868 0x4868 0x4869 0x4869 0x486a 0x486a 0x486b 0x486b
> -[drm]   Encoders:
> -[drm]     DFP1: INTERNAL_UNIPHY2
> -[drm] Connector 1:
> -[drm]   DP-2
> -[drm]   HPD4
> -[drm]   DDC: 0x4870 0x4870 0x4871 0x4871 0x4872 0x4872 0x4873 0x4873
> -[drm]   Encoders:
> -[drm]     DFP2: INTERNAL_UNIPHY2
> -[drm] Connector 2:
> -[drm]   DP-3
> -[drm]   HPD1
> -[drm]   DDC: 0x486c 0x486c 0x486d 0x486d 0x486e 0x486e 0x486f 0x486f
> -[drm]   Encoders:
> -[drm]     DFP3: INTERNAL_UNIPHY1
> -[drm] Connector 3:
> -[drm]   DP-4
> -[drm]   HPD3
> -[drm]   DDC: 0x4874 0x4874 0x4875 0x4875 0x4876 0x4876 0x4877 0x4877
> -[drm]   Encoders:
> -[drm]     DFP4: INTERNAL_UNIPHY
> -[drm] Found UVD firmware Version: 1.130 Family ID: 16
> -[drm] Found VCE firmware Version: 53.26 Binary ID: 3
> -[drm] UVD and UVD ENC initialized successfully.
> -[drm] VCE initialized successfully.
> -amdgpu 0000:01:00.0: amdgpu: SE 4, SH per SE 1, CU per SH 9, active_cu_n=
umber 36
> -amdgpu 0000:01:00.0: amdgpu: Using BACO for runtime pm
> +amdgpu 0000:01:00.0: [drm] Found UVD firmware Version: 1.130 Family ID: =
16
> +amdgpu 0000:01:00.0: [drm] UVD and UVD ENC initialized successfully.
> +amdgpu 0000:01:00.0: [drm] VCE initialized successfully.
> +amdgpu 0000:01:00.0: SE 4, SH per SE 1, CU per SH 9, active_cu_number 36
> +amdgpu 0000:01:00.0: Using BACO for runtime pm
>  [drm] Initialized amdgpu 3.64.0 for 0000:01:00.0 on minor 0
> -fbcon: amdgpudrmfb (fb0) is primary device
> -amdgpu 0000:01:00.0: [drm] fb0: amdgpudrmfb frame buffer device
>  EXT4-fs (dm-9): mounted filesystem 21691fb4-85ac-422e-b598-3443874357d4 =
r/w with ordered data mode. Quota mode: disabled.
> +amdgpu 0000:01:00.0: [drm] PCIE GART of 256M enabled (table at 0x000000F=
400900000).
> +amdgpu 0000:01:00.0: [drm] UVD and UVD ENC initialized successfully.
> +amdgpu 0000:01:00.0: [drm] VCE initialized successfully.
> +amdgpu 0000:01:00.0: [drm] PCIE GART of 256M enabled (table at 0x000000F=
400900000).
> +amdgpu 0000:01:00.0: [drm] UVD and UVD ENC initialized successfully.
> +amdgpu 0000:01:00.0: [drm] VCE initialized successfully.
> +amdgpu 0000:01:00.0: [drm] PCIE GART of 256M enabled (table at 0x000000F=
400900000).
> +amdgpu 0000:01:00.0: [drm] UVD and UVD ENC initialized successfully.
> +amdgpu 0000:01:00.0: [drm] VCE initialized successfully.
> +amdgpu 0000:01:00.0: [drm] PCIE GART of 256M enabled (table at 0x000000F=
400900000).
> +amdgpu 0000:01:00.0: [drm] UVD and UVD ENC initialized successfully.
> +amdgpu 0000:01:00.0: [drm] VCE initialized successfully.
> +amdgpu 0000:01:00.0: [drm] PCIE GART of 256M enabled (table at 0x000000F=
400900000).
> +amdgpu 0000:01:00.0: [drm] UVD and UVD ENC initialized successfully.
> +amdgpu 0000:01:00.0: [drm] VCE initialized successfully.
> +amdgpu 0000:01:00.0: [drm] PCIE GART of 256M enabled (table at 0x000000F=
400900000).
> +amdgpu 0000:01:00.0: [drm] UVD and UVD ENC initialized successfully.
> +amdgpu 0000:01:00.0: [drm] VCE initialized successfully.
> +amdgpu 0000:01:00.0: [drm] PCIE GART of 256M enabled (table at 0x000000F=
400900000).
> +amdgpu 0000:01:00.0: [drm] UVD and UVD ENC initialized successfully.
> +amdgpu 0000:01:00.0: [drm] VCE initialized successfully.
> +amdgpu 0000:01:00.0: [drm] PCIE GART of 256M enabled (table at 0x000000F=
400900000).
> +amdgpu 0000:01:00.0: [drm] UVD and UVD ENC initialized successfully.
> +amdgpu 0000:01:00.0: [drm] VCE initialized successfully.
> +amdgpu 0000:01:00.0: [drm] PCIE GART of 256M enabled (table at 0x000000F=
400900000).
> +amdgpu 0000:01:00.0: [drm] UVD and UVD ENC initialized successfully.
> +amdgpu 0000:01:00.0: [drm] VCE initialized successfully.
>
>
> $ grep -E '(amdgpu|EE|modeset)' /var/log/Xorg.0.log
> [  1537.962] Current Operating System: Linux stax 7.0.2-mh #187 SMP PREEM=
PT Tue Apr 28 10:05:44 BST 2026 x86_64
>         (WW) warning, (EE) error, (NI) not implemented, (??) unknown.
> [  1537.963] (EE) dbus-core: error connecting to system bus: org.freedesk=
top.DBus.Error.NoServer (Failed to connect to socket /var/run/dbus/system_b=
us_socket: Connection refused)
> [  1537.965] (=3D=3D) Matched modesetting as autoconfigured driver 1
> [  1537.966] (II) LoadModule: "amdgpu"
> [  1537.966] (WW) Warning, couldn't open module amdgpu
> [  1537.966] (EE) Failed to load module "amdgpu" (module does not exist, =
0)
> [  1537.966] (II) LoadModule: "modesetting"
> [  1537.966] (II) Loading /usr/lib64/xorg/modules/drivers/modesetting_drv=
.so
> [  1537.966] (II) Module modesetting: vendor=3D"X.Org Foundation"
> [  1537.966] (II) modesetting: Driver for Modesetting Kernel Drivers: kms
> [  1537.966] (II) modeset(0): using drv /dev/dri/card0
> [  1537.967] (EE) open /dev/fb0: No such file or directory
> [  1537.967] (II) modeset(0): Using 24bpp hw front buffer with 32bpp shad=
ow
> [  1537.967] (II) modeset(0): Creating default Display subsection in Scre=
en section
> [  1537.967] (=3D=3D) modeset(0): Depth 24, (=3D=3D) framebuffer bpp 32
> [  1537.967] (=3D=3D) modeset(0): RGB weight 888
> [  1537.967] (=3D=3D) modeset(0): Default visual is TrueColor
> [  1537.967] (**) modeset(0): Cannot use glamor with 24bpp packed fb
> [  1537.967] (II) modeset(0): ShadowFB: preferred YES, enabled FORCE
> [  1537.967] (II) modeset(0): Double-buffered shadow updates: off
> [  1537.967] (WW) modeset(0): TearFree requires Glamor acceleration
> [  1537.967] (WW) modeset(0): No outputs definitely connected, trying aga=
in...
> [  1537.967] (WW) modeset(0): Unable to find connected outputs - setting =
1024x768 initial framebuffer
> [  1537.967] (=3D=3D) modeset(0): Using gamma correction (1.0, 1.0, 1.0)
> [  1537.967] (EE) modeset(0): No modes.
> [  1537.967] (II) UnloadModule: "modesetting"
> [  1537.967] (EE) Screen(s) found, but none have a usable configuration.
> [  1537.967] (EE)
> [  1537.967] (EE) no screens found(EE)
> [  1537.967] (EE)
> [  1537.967] (EE) Please also check the log file at "/var/log/Xorg.0.log"=
 for additional information.
> [  1537.967] (EE)
> [  1537.967] (EE) Server terminated with error (1). Closing log file.
>
>
> stax$ lsmod | grep -E '(amdgpu|fb|drm)'
> amdgpu               5550080  0
> drm_ttm_helper         16384  1 amdgpu
> syscopyarea            12288  1 drm_ttm_helper
> ttm                    77824  2 amdgpu,drm_ttm_helper
> sysfillrect            12288  1 drm_ttm_helper
> sysimgblt              12288  1 drm_ttm_helper
> fb_sys_fops            12288  1 drm_ttm_helper
> drm_client_lib         16384  1 amdgpu
> amdxcp                 12288  1 amdgpu
> drm_exec               12288  1 amdgpu
> gpu_sched              49152  1 amdgpu
> drm_buddy              16384  1 amdgpu
> drm_suballoc_helper    16384  1 amdgpu
> drm_display_helper    155648  1 amdgpu
> drm_kms_helper        151552  4 drm_display_helper,amdgpu,drm_ttm_helper,=
drm_client_lib
> drm                   524288  12 gpu_sched,drm_kms_helper,drm_exec,drm_su=
balloc_helper,drm_display_helper,drm_buddy,amdgpu,drm_ttm_helper,drm_client=
_lib,ttm,amdxcp
> drm_panel_orientation_quirks    32768  1 drm
> i2c_algo_bit           12288  1 amdgpu
> fb                    114688  2 drm_kms_helper,drm_ttm_helper
> video                  69632  1 amdgpu
> font                   16384  1 fb
> backlight              16384  4 video,drm_display_helper,amdgpu,drm
> i2c_core               81920  6 i2c_algo_bit,drm_display_helper,i2c_smbus=
,amdgpu,i2c_i801,drm
>
>
> $ zcat /proc/config.gz | grep -iE '(amdgpu|drm|fb)' | grep -v 'not set'
> CONFIG_DRM=3Dm
> # DRM debugging options
> # end of DRM debugging options
> CONFIG_DRM_KMS_HELPER=3Dm
> CONFIG_DRM_CLIENT=3Dy
> CONFIG_DRM_CLIENT_LIB=3Dm
> CONFIG_DRM_CLIENT_SELECTION=3Dm
> CONFIG_DRM_CLIENT_SETUP=3Dy
> # Supported DRM clients
> CONFIG_DRM_FBDEV_EMULATION=3Dy
> CONFIG_DRM_FBDEV_OVERALLOC=3D100
> CONFIG_DRM_CLIENT_DEFAULT_FBDEV=3Dy
> CONFIG_DRM_CLIENT_DEFAULT=3D"fbdev"
> # end of Supported DRM clients
> CONFIG_DRM_DISPLAY_HELPER=3Dm
> CONFIG_DRM_DISPLAY_DP_HELPER=3Dy
> CONFIG_DRM_DISPLAY_DSC_HELPER=3Dy
> CONFIG_DRM_DISPLAY_HDCP_HELPER=3Dy
> CONFIG_DRM_DISPLAY_HDMI_HELPER=3Dy
> CONFIG_DRM_TTM=3Dm
> CONFIG_DRM_EXEC=3Dm
> CONFIG_DRM_BUDDY=3Dm
> CONFIG_DRM_TTM_HELPER=3Dm
> CONFIG_DRM_SUBALLOC_HELPER=3Dm
> CONFIG_DRM_SCHED=3Dm
> CONFIG_DRM_PANEL_BACKLIGHT_QUIRKS=3Dm
> CONFIG_DRM_AMDGPU=3Dm
> CONFIG_DRM_AMDGPU_CIK=3Dy
> CONFIG_DRM_BRIDGE=3Dy
> CONFIG_DRM_PANEL_BRIDGE=3Dy
> CONFIG_DRM_PANEL=3Dy
> CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=3Dm
> CONFIG_FB=3Dm
> CONFIG_FB_RADEON=3Dm
> CONFIG_FB_RADEON_I2C=3Dy
> CONFIG_FB_CORE=3Dm
> CONFIG_FB_NOTIFY=3Dy
> CONFIG_FB_DDC=3Dm
> CONFIG_FB_CFB_FILLRECT=3Dm
> CONFIG_FB_CFB_COPYAREA=3Dm
> CONFIG_FB_CFB_IMAGEBLIT=3Dm
> CONFIG_FB_SYS_FILLRECT=3Dm
> CONFIG_FB_SYS_COPYAREA=3Dm
> CONFIG_FB_SYS_IMAGEBLIT=3Dm
> CONFIG_FB_SYSMEM_FOPS=3Dm
> CONFIG_FB_DEFERRED_IO=3Dy
> CONFIG_FB_IOMEM_FOPS=3Dm
> CONFIG_FB_IOMEM_HELPERS=3Dy
> CONFIG_FB_SYSMEM_HELPERS=3Dy
> CONFIG_FB_SYSMEM_HELPERS_DEFERRED=3Dy
> CONFIG_FB_MODE_HELPERS=3Dy
> CONFIG_CRYPTO_LIB_AESCFB=3Dm
>
