Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D9D3C4829E
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Feb 2024 21:37:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9463910E098;
	Mon, 12 Feb 2024 21:37:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dg1d9UtZ";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 619F010E1D0
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Feb 2024 21:37:49 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-295c8b795e2so244796a91.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Feb 2024 13:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707773869; x=1708378669; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mFCQQ4K7HMQavgNVNIp8GEPzalzjpZDPiXf7pBeimhI=;
 b=dg1d9UtZOYQ8ar+9nSWGGR1+idQBCB+nx0ORUdO6++V2lNy9PgVGPDbtHCa4SgZywa
 I5j49mv89dQ93yQGGfUhT4W1nMDiJMjKwopEBAguS6Y8WIQuzi5gBGoBsQs6iakBfQ//
 jnaPA9eUpmSF6gpP2Ea9Oofk8AVz5DSdsgQJ/omHGVLj5/EL2x3idRAFXBHMZLWcUiTt
 /gcWGi1jjpZPaN1yBYkJP5OdaiQltYqrQ9RZtXjmPsgGPhCARSETFBQcbzMgsT5x/0qC
 Fz7jyoXzu0JUK1aF1oy2tI5f7frQqbE2KdgXAZNK9QYGZFDgxVbdRjtrHUeO/YCHihb6
 WeCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707773869; x=1708378669;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mFCQQ4K7HMQavgNVNIp8GEPzalzjpZDPiXf7pBeimhI=;
 b=gfFv8xW3vdNbq5fNiOu/EAUq4WnCrPh1wuYB0lTNSv/nw0o4nVqXHkR2qLdnj6Q2Md
 PbbaVN8/jWmdgaYq9OCmzTagpk1uW4bw6JuF/+TcEVNP+i/UUcMH9yfbQX9obCbaf99z
 oTOf06pccnR5gyBv80zZS3mvm1hXzYoaA4tg1/BG+CGDfVMsMDfbu9F9VyxPuFPoSdoM
 HmRAdhv1cyNPDjM2YDTf2kxLI3236TI9f+F+G0n6LI1nJLCvp4f8DrTdsasEszvX8Ukb
 dU3AaLQ2fICwjyXmcoAJexx/MUDqisjo1MLRfjx7uaJMNJS7pGzc27Tvs/lEfRhYCsXp
 qK8A==
X-Gm-Message-State: AOJu0YyZnRojysSiAni3gWBTos5okD9u3vk5qF7J3k//CdnoXSFx8IbD
 VlRT4yw6Xlenc79HjW57Dft77LZNZdQ7sRNrvq5K113fVYGCZMuRG8ImxOEkCRpcDWpAqPgAEbP
 4RgJpwM6afJfPzdwDzTZUiE+HmeU+3MeJSrQ=
X-Google-Smtp-Source: AGHT+IFa63uZNyEg725AwGmHTfwzPn0fCZDjlPwNV34FkByq+UX7xsfEWYPUqUGLQSAuMoXspnH8k6WkcyDiQ3AINVQ=
X-Received: by 2002:a17:90a:bb83:b0:295:eb32:8a1d with SMTP id
 v3-20020a17090abb8300b00295eb328a1dmr5544727pjr.38.1707773868730; Mon, 12 Feb
 2024 13:37:48 -0800 (PST)
MIME-Version: 1.0
References: <6dbb4988-5a8e-4c7f-bb52-9bff82e6f227@fedoraproject.org>
In-Reply-To: <6dbb4988-5a8e-4c7f-bb52-9bff82e6f227@fedoraproject.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 12 Feb 2024 16:37:36 -0500
Message-ID: <CADnq5_Pi2brdKs3usHV0f96kqz8pGgjw2qo_LJGQNWQ6X=qjOQ@mail.gmail.com>
Subject: Re: Blank screen after enabling amdgpu.seamless on a Barcelo APU
To: Luya Tshimbalanga <luya@fedoraproject.org>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
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

On Mon, Feb 12, 2024 at 5:11=E2=80=AFAM Luya Tshimbalanga
<luya@fedoraproject.org> wrote:
>
> Hello team,
>
> Testing "amdgpu.seamless=3D1" on Ryzen 7 5825u using kernel 6.7.4 led to =
a blank screen after the initial boot screen as tested on Dell Inc. Inspiro=
n 14 7425 2-in-1 with the following message from boot:
>
> "Feb 11 13:43:37 kernel: amdgpu 0000:04:00.0: [drm] *ERROR* [CRTC:73:crtc=
-0] flip_done timed out"
>
>
> Here is the journalctl report sorted by amdgpu:
>
> '''
>
> journalctl -b -2 --no-hostname | grep amdgpu
> Feb 11 13:43:14 kernel: Command line: root=3DUUID=3Db8250ad0-059a-4eb7-89=
3d-9757e1c0599d ro rootflags=3Dsubvol=3Droot rhgb quiet amdgpu.seamless=3D1=
 root=3DUUID=3Db8250ad0-059a-4eb7-893d-9757e1c0599d ro rootflags=3Dsubvol=
=3Droot rhgb quiet
> Feb 11 13:43:14 kernel: Kernel command line: root=3DUUID=3Db8250ad0-059a-=
4eb7-893d-9757e1c0599d ro rootflags=3Dsubvol=3Droot rhgb quiet amdgpu.seaml=
ess=3D1 root=3DUUID=3Db8250ad0-059a-4eb7-893d-9757e1c0599d ro rootflags=3Ds=
ubvol=3Droot rhgb quiet
> Feb 11 13:43:14 dracut-cmdline[398]: Using kernel command line parameters=
:  rd.driver.pre=3Dbtrfs   root=3DUUID=3Db8250ad0-059a-4eb7-893d-9757e1c059=
9d ro rootflags=3Dsubvol=3Droot rhgb quiet amdgpu.seamless=3D1 root=3DUUID=
=3Db8250ad0-059a-4eb7-893d-9757e1c0599d ro rootflags=3Dsubvol=3Droot rhgb q=
uiet
> Feb 11 13:43:16 kernel: [drm] amdgpu kernel modesetting enabled.
> Feb 11 13:43:16 kernel: amdgpu: Virtual CRAT table created for CPU
> Feb 11 13:43:16 kernel: amdgpu: Topology: Add CPU node
> Feb 11 13:43:16 kernel: amdgpu 0000:04:00.0: enabling device (0006 -> 000=
7)
> Feb 11 13:43:16 kernel: amdgpu 0000:04:00.0: amdgpu: Fetched VBIOS from V=
FCT
> Feb 11 13:43:16 kernel: amdgpu: ATOM BIOS: 113-BARCELO-003
> Feb 11 13:43:16 kernel: amdgpu 0000:04:00.0: vgaarb: deactivate vga conso=
le
> Feb 11 13:43:16 kernel: amdgpu 0000:04:00.0: amdgpu: Trusted Memory Zone =
(TMZ) feature enabled
> Feb 11 13:43:16 kernel: amdgpu 0000:04:00.0: amdgpu: MODE2 reset
> Feb 11 13:43:16 kernel: amdgpu 0000:04:00.0: amdgpu: VRAM: 2048M 0x000000=
F400000000 - 0x000000F47FFFFFFF (2048M used)
> Feb 11 13:43:16 kernel: amdgpu 0000:04:00.0: amdgpu: GART: 1024M 0x000000=
0000000000 - 0x000000003FFFFFFF
> Feb 11 13:43:16 kernel: [drm] amdgpu: 2048M of VRAM memory ready
> Feb 11 13:43:16 kernel: [drm] amdgpu: 14960M of GTT memory ready.
> Feb 11 13:43:16 kernel: amdgpu 0000:04:00.0: amdgpu: Will use PSP to load=
 VCN firmware
> Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: RAS: optional ras ta=
 ucode is not available
> Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: RAP: optional rap ta=
 ucode is not available
> Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: SECUREDISPLAY: secur=
edisplay ta ucode is not available
> Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: SMU is initialized s=
uccessfully!
> Feb 11 13:43:17 kernel: amdgpu: HMM registered 2048MB device memory
> Feb 11 13:43:17 kernel: kfd kfd: amdgpu: Allocated 3969056 bytes on gart
> Feb 11 13:43:17 kernel: kfd kfd: amdgpu: Total number of KFD nodes to be =
created: 1
> Feb 11 13:43:17 kernel: amdgpu: Virtual CRAT table created for GPU
> Feb 11 13:43:17 kernel: amdgpu: Topology: Add dGPU node [0x15e7:0x1002]
> Feb 11 13:43:17 kernel: kfd kfd: amdgpu: added device 1002:15e7
> Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: SE 1, SH per SE 1, C=
U per SH 8, active_cu_number 8
> Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: ring gfx uses VM inv=
 eng 0 on hub 0
> Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: ring gfx_low uses VM=
 inv eng 1 on hub 0
> Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: ring gfx_high uses V=
M inv eng 4 on hub 0
> Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: ring comp_1.0.0 uses=
 VM inv eng 5 on hub 0
> Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: ring comp_1.1.0 uses=
 VM inv eng 6 on hub 0
> Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: ring comp_1.2.0 uses=
 VM inv eng 7 on hub 0
> Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: ring comp_1.3.0 uses=
 VM inv eng 8 on hub 0
> Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: ring comp_1.0.1 uses=
 VM inv eng 9 on hub 0
> Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: ring comp_1.1.1 uses=
 VM inv eng 10 on hub 0
> Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: ring comp_1.2.1 uses=
 VM inv eng 11 on hub 0
> Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: ring comp_1.3.1 uses=
 VM inv eng 12 on hub 0
> Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: ring kiq_0.2.1.0 use=
s VM inv eng 13 on hub 0
> Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: ring sdma0 uses VM i=
nv eng 0 on hub 8
> Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: ring vcn_dec uses VM=
 inv eng 1 on hub 8
> Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: ring vcn_enc0 uses V=
M inv eng 4 on hub 8
> Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: ring vcn_enc1 uses V=
M inv eng 5 on hub 8
> Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: ring jpeg_dec uses V=
M inv eng 6 on hub 8
> Feb 11 13:43:17 kernel: [drm] Initialized amdgpu 3.57.0 20150101 for 0000=
:04:00.0 on minor 1
> Feb 11 13:43:17 kernel: fbcon: amdgpudrmfb (fb0) is primary device
> Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: [drm] fb0: amdgpudrmfb frame=
 buffer device
> Feb 11 13:43:20 systemd[1]: Starting systemd-backlight@backlight:amdgpu_b=
l1.service - Load/Save Screen Backlight Brightness of backlight:amdgpu_bl1.=
..
> Feb 11 13:43:20 systemd[1]: Finished systemd-backlight@backlight:amdgpu_b=
l1.service - Load/Save Screen Backlight Brightness of backlight:amdgpu_bl1.
> Feb 11 13:43:20 audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D4294967295=
 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 msg=3D'unit=3Dsystemd-=
backlight@backlight:amdgpu_bl1 comm=3D"systemd" exe=3D"/usr/lib/systemd/sys=
temd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> Feb 11 13:43:20 kernel: snd_hda_intel 0000:04:00.1: bound 0000:04:00.0 (o=
ps amdgpu_dm_audio_component_bind_ops [amdgpu])
> Feb 11 13:43:25 gnome-shell[1539]: Added device '/dev/dri/card1' (amdgpu)=
 using atomic mode setting.
> Feb 11 13:43:37 kernel: amdgpu 0000:04:00.0: [drm] *ERROR* [CRTC:73:crtc-=
0] flip_done timed out
> '''
>
> Should I submit the issue to the kernel bug report or here?

Please file an issue here:
https://gitlab.freedesktop.org/drm/amd/-/issues

Akex

>
> --
> Luya Tshimbalanga
> Fedora Design Team
> Fedora Design Suite maintainer
