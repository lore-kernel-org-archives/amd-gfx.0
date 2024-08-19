Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE21C3DA4A
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Aug 2024 14:13:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BEDF10E282;
	Mon, 19 Aug 2024 14:13:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HdbS8ayh";
	dkim-atps=neutral
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3BC710E282
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Aug 2024 14:13:11 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-7a23fbb372dso2525903a12.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Aug 2024 07:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724076791; x=1724681591; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E9nyer25LX0/Q7za3zN7Hq/p3i4Z7klwNSwuwFTvsPI=;
 b=HdbS8ayheLmTnEcDIBdzMgcUjH6FB1/OJeIIPpCV1xkZJkJdRQJgjmxbPe0liRy/2w
 XQDGv+Yzvxeq9/ay/bcezKF1hzczmdV2gjNRYQT9Ct0Pscz6O7sVb8UEwKItwz9/NBWw
 TOEMEjxLmzMS6CeZGczLnrjGFnSZP5ver4tE0l8MwNYzAgyiXacM1ejXCwHRocOmXltk
 M09QIcKDDj3wZJkycxAeew1gIwv8+/GY8wPqtI1i3Z5ufeatFIOhEdqLCM8Ky+qPvDE5
 l1/32h7trNTCo9FwjuYyfkT6pOS+0VdLCU8gBDhxA+u44OSek2pVT99t5LATNJvodFJG
 rwag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724076791; x=1724681591;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E9nyer25LX0/Q7za3zN7Hq/p3i4Z7klwNSwuwFTvsPI=;
 b=j+m1QgcZTolFj3/0tvmeOOFaxEJPsLYnIMWPHZJlzY8MG4tuSF99nmgmJKCDP8UOHd
 RI+wgesVz7SvcuVhldMEx3PsizHtnT4eTJpskWg4mir0KD9DKjSu2/BriUoas1SMMwUC
 WK8i7jUqxOLzFBPixqySXDPy/XGSKnzcG5e3EgEOoiJGpndGvXHji7Gv6k8g++yRpfGc
 Oj0X4/qdJSrzWqFIAKOPqrjm7xgD/RPEJQ208W0UZ8RismGHJ4RB9XXHVdsAAcMgyudc
 Wvt4kujztJ/tOLsFQUjxjC+j/ZfbvNNS+s9BG8OXFnuMYprmLH1jOmto5vcOYhCTLtU8
 Na6w==
X-Gm-Message-State: AOJu0YxHlcm0yXZiclUJcHGBAyuSEnhkZ177og/fDWhqXokXX/EaR/da
 Mv3KlvYzufagWLMSTw/RszjqqV6IJATMIZxel7zsO/1hsPGwmONFVomN6cKoTmPCxnYWE0FayQl
 cK8zlgDJf0sUkIPgE8Dvfru0nhwmGVg==
X-Google-Smtp-Source: AGHT+IHYxvlj1X9RniTdBoyI51wtib/T2A7tlR1QtDSky2Lb+zxprqHBZfxHhp0ZvrelUOqFVHkVo9dvYMr+BxKq2js=
X-Received: by 2002:a17:90b:4d8f:b0:2c9:a3d4:f044 with SMTP id
 98e67ed59e1d1-2d3dffc0f59mr9086559a91.11.1724076790781; Mon, 19 Aug 2024
 07:13:10 -0700 (PDT)
MIME-Version: 1.0
References: <CA+Y=x3n+X6PDza5KAG2fy2wLh0-w5mWQtvKbWvT3E3A0r_makg@mail.gmail.com>
In-Reply-To: <CA+Y=x3n+X6PDza5KAG2fy2wLh0-w5mWQtvKbWvT3E3A0r_makg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 19 Aug 2024 10:12:58 -0400
Message-ID: <CADnq5_N-pvp8czodNT=YDFsqRz-Tet4GHK-JWiDdHnfL-2YF-w@mail.gmail.com>
Subject: Re: v6.11-rc4 amdgpu regression from v6.10.0
To: Andrew Worsley <amworsley@gmail.com>
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

On Mon, Aug 19, 2024 at 9:55=E2=80=AFAM Andrew Worsley <amworsley@gmail.com=
> wrote:
>
> The v6.11-rc4 linux hangs during amdgpu start up where as the v6.10.0
> is fine. I had to take a photo of the screen (see attachment) from
> which I generated
> the following summary:
>
>     Booting linux v6.11-rc4 :
> ...
> amdgpu: Virtual CRAT table created for CPU
> amdgpu: Topology: Add CPU node
> initializing kernel modesetting (IP DISCOVERY 0x1002:0x15BF 0xF111:0x0005=
 0xC2).
> register mmio base: 0x90500000
> register mmio size: 524288
> add ip block number 0 <soc21_common>
> add ip block number 1 <gmc_v11_0>
> add ip block number 2 <ih_v6_0>
> add ip block number 3 <psp>
> add ip block number 4 <smu>
> add ip block number 5 <dm>
> add ip block number 6 <gfx_v11_0>
> add ip block number 7 <sdma_v6_0>
> add ip block number 8 <vcn_v4_0>
> add ip block number 9 <jpeg_v4_0>
> add ip block number 10 <mes_v11_0>
> amdgpu 0000:c1:00.0: amdgpu: Fetched VBIOS from VFCT
> amdgpu: ATOM BIOS: 113-PHXGENERIC-001
> amdgpu 0000:c1:00.0: Direct firmware load for
> amdgpu/gc_11_0_1_mes_2.bin failed with error -2
> amdgpu 0000:c1:00.0: amdgpu: try to fall back to amdgpu/gc_11_0_1_mes.bin

-2 is -ENOENT which means the driver was not able to find the
firmware.  I suspect you either didn't include the firmware in your
kernel image (if you are building the driver in), or didn't include
the firmware in your initrd (if the driver was built as a module).

Alex

>
>   *** Hangs with this displayed on the console ****
>     - have to power off computer to recover
>
> Perfectly successful boot with v6.10.0 kernel :
>
> [    2.478302] [drm] amdgpu kernel modesetting enabled.
> [    2.485206] amdgpu: Virtual CRAT table created for CPU
> [    2.485817] amdgpu: Topology: Add CPU node
> [    2.486525] [drm] initializing kernel modesetting (IP DISCOVERY
> 0x1002:0x15BF 0xF111:0x0005 0xC2).
> [    2.487225] [drm] register mmio base: 0x90500000
> [    2.487809] [drm] register mmio size: 524288
> [    2.492629] [drm] add ip block number 0 <soc21_common>
> [    2.493310] [drm] add ip block number 1 <gmc_v11_0>
> [    2.493973] [drm] add ip block number 2 <ih_v6_0>
> [    2.494617] [drm] add ip block number 3 <psp>
> [    2.495255] [drm] add ip block number 4 <smu>
> [    2.495880] [drm] add ip block number 5 <dm>
> [    2.496499] [drm] add ip block number 6 <gfx_v11_0>
> [    2.497114] [drm] add ip block number 7 <sdma_v6_0>
> [    2.497717] [drm] add ip block number 8 <vcn_v4_0>
> [    2.498313] [drm] add ip block number 9 <jpeg_v4_0>
> [    2.498899] [drm] add ip block number 10 <mes_v11_0>
> [    2.499479] amdgpu 0000:c1:00.0: amdgpu: Fetched VBIOS from VFCT
> [    2.500063] amdgpu: ATOM BIOS: 113-PHXGENERIC-001
> [    2.501760] [drm] VCN(0) encode/decode are enabled in VM mode
> [    2.502588] amdgpu 0000:c1:00.0: [drm:jpeg_v4_0_early_init
> [amdgpu]] JPEG decode is enabled in VM mode
> [    2.503426] amdgpu 0000:c1:00.0: Direct firmware load for
> amdgpu/gc_11_0_1_mes_2.bin failed with error -2
> [    2.504043] [drm] try to fall back to amdgpu/gc_11_0_1_mes.bin
> [    2.505117] Console: switching to colour dummy device 80x25
> [    2.505144] amdgpu 0000:c1:00.0: vgaarb: deactivate vga console
> [    2.505147] amdgpu 0000:c1:00.0: amdgpu: Trusted Memory Zone (TMZ)
> feature enabled
> [    2.505193] [drm] vm size is 262144 GB, 4 levels, block size is
> 9-bit, fragment size is 9-bit
> [    2.505218] amdgpu 0000:c1:00.0: amdgpu: VRAM: 2048M
> 0x0000008000000000 - 0x000000807FFFFFFF (2048M used)
> [    2.505223] amdgpu 0000:c1:00.0: amdgpu: GART: 512M
> 0x00007FFF00000000 - 0x00007FFF1FFFFFFF
> [    2.505237] [drm] Detected VRAM RAM=3D2048M, BAR=3D2048M
> [    2.505240] [drm] RAM width 128bits DDR5
> [    2.505418] [drm] amdgpu: 2048M of VRAM memory ready
> [    2.505422] [drm] amdgpu: 31048M of GTT memory ready.
> [    2.505436] [drm] GART: num cpu pages 131072, num gpu pages 131072
> [    2.505600] [drm] PCIE GART of 512M enabled (table at 0x000000807FD000=
00).
> [    2.506246] [drm] Loading DMUB firmware via PSP: version=3D0x08000500
> [    2.506550] [drm] Found VCN firmware Version ENC: 1.10 DEC: 5 VEP:
> 0 Revision: 0
> [    2.506558] amdgpu 0000:c1:00.0: amdgpu: Will use PSP to load VCN firm=
ware
> [    2.531970] amdgpu 0000:c1:00.0: amdgpu: reserve 0x4000000 from
> 0x8078000000 for PSP TMR
