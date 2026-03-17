Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF8AFF6E8C
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 08:34:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D713010E75F;
	Wed, 18 Mar 2026 08:34:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ieee.org header.i=@ieee.org header.b="Fhxge7Fs";
	dkim-atps=neutral
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9397010E4AA
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 14:48:54 +0000 (UTC)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-8cd75abd09dso698185185a.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 07:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ieee.org; s=google; t=1773758933; x=1774363733; darn=lists.freedesktop.org; 
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=6QTFDPyJK9loFucZq2khlxngKi04ZppTVp9BJcNudiM=;
 b=Fhxge7FsiIDLJtXzpljB1i7quW7opbs08l/LP1SoSRyi4eN72DHyNWfx+oXdQ4Ev9Q
 8tk8iRegsQmsjFkKRGu8ZyqXq3Hb3Or+HrRd/NChCbCR/OIAuwTte5/Ckd3izXXCLdS4
 QdI4ZKgHzvI6kbZSDzlqITvlBg6e1uIxWRfAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773758933; x=1774363733;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6QTFDPyJK9loFucZq2khlxngKi04ZppTVp9BJcNudiM=;
 b=lIXCKY4T03URY4OixDRy6Vn5b1WAlPdzmbQKeGdII237HduXSoy7jdCAiHPHNpiEXX
 aqaswpPhrIlxvneDwAxxC85hhA9mkdkW4gTAR2ncXALO9k6aTP5Up59s2i+aHJIAL1/M
 3KJNvnpvcj6Cah/LgMZ6RNWoK5TE6Km/b2wQO9VoFgFZwuyzsf2vGjm2LASmhjf7DNqq
 eB3rmbfmTTD1LP7TkKk4QbGiqQnf/lVytQfps8/ktkiJ7iwXlmZzsHmSYuc1PYDA+C0R
 2+1dPnYqQ8rtWq+igfWecswflLE6iSqqcd5G0HArxUJEIdY61hxboZMYtM5uj61yNOP/
 RrsA==
X-Gm-Message-State: AOJu0YzJaNZ0FNpolUX4FEicLHLUtMJ7Ve+ve9qFW/9jcvPxzZeKiIS9
 TiYzowbIPY5el6s/gd6orMewcC8EmxIIu/px1jQ9L6257Qhgw+ap1cEuySxErvM8AA==
X-Gm-Gg: ATEYQzyA6EC/UZ97k89c76OaKvA3E3Vw3zFskIvJcK6xmu23piTRdZs6WM0BvKfs+vU
 bYAcN+Esil3yaG+dMhUAltdjz9gfSBWIxR2h257BjoN7sf3qRSrmDYjjWCGINcIA5SniJoTTOGY
 aVazIXe1NWRsYHrOlNsIilk+aOfvJ90LVuort3XzKIrstGM8M3PTFGJYSuQYhMyIw/QhSzN2LMm
 m/iMsRjnyVbppo2gGu7lZILluYo6coIDpcjGq5rmA885HKK72IH7cDIa/I+FoUtHaWCxOFthOUE
 aLeeOXgIrpziZi+hxrRtb4EZNomolfoGfiEtghnUcKjniGROyq2IKozAyTxlHXrPWk5wB5T/PY5
 WUw90yLsfmxjpX0IaZdJILTuz3CSnSomRGZC57BGWw01As6qtJZhFsOmoVuIsr8xLHCaUTsKzRk
 abvzLGvkoZPvkjk+VrMyNpA74=
X-Received: by 2002:a05:622a:1a87:b0:509:4091:affe with SMTP id
 d75a77b69052e-50957e28510mr241846851cf.69.1773758932727; 
 Tue, 17 Mar 2026 07:48:52 -0700 (PDT)
Received: from [192.168.153.215] ([73.29.38.247])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50b1348a168sm182431cf.5.2026.03.17.07.48.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 07:48:52 -0700 (PDT)
Message-ID: <c1d7dd3c64791c3c1ba4e295eebb98fe6ad7a848.camel@ieee.org>
Subject: Re: [Bug report] RADV GFX1200 (Navi 44 / RX 9060 XT): NULL page
 fault at 0x0 on gfxhub during Vulkan rendering
From: Cristian Cocos <cristi@ieee.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
Date: Tue, 17 Mar 2026 10:48:32 -0400
In-Reply-To: <CADnq5_Nha0KqzAuoJayXtiFjsXq8DqbbPyWfoFinc=vPaAf9gg@mail.gmail.com>
References: <dfce5e070c5857aaebd8e7136011b90e7d888eb1.camel@ieee.org>
 <CADnq5_Nha0KqzAuoJayXtiFjsXq8DqbbPyWfoFinc=vPaAf9gg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (by Flathub.org) 
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 18 Mar 2026 08:34:37 +0000
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

Mesa ticket:=C2=A0https://gitlab.freedesktop.org/mesa/mesa/-
/issues/15037#note_3376627

On Tue, 2026-03-17 at 09:00 -0400, Alex Deucher wrote:
> On Tue, Mar 17, 2026 at 4:24=E2=80=AFAM Cristian Cocos <cristi@ieee.org>
> wrote:
> >=20
> > ## Summary
> >=20
> > RADV crashes with a `[gfxhub] Page fault at address:
> > 0x0000000000000000` when performing Vulkan rendering on an AMD RX
> > 9060 XT (Navi 44, GFX1200). The crash occurs ~20-30 seconds into
> > video playback in mpv using `vo=3Dgpu-next` with `gpu-api=3Dvulkan`
> > (libplacebo). Multiple GPU rings (sdma0, gfx_0.0.0, comp_1.x.x)
> > time out simultaneously. The kernel driver recovers the rings, but
> > the Vulkan context is lost.
> >=20
> > **Critically, the crash also occurs when video decode is offloaded
> > to VA-API on a separate Intel iGPU** =E2=80=94 only the Vulkan renderin=
g
> > path (libplacebo =E2=86=92 RADV =E2=86=92 `vkQueueSubmit2`) is involved=
. This rules
> > out VK_KHR_video_decode_queue as the cause.
> >=20
>=20
> Please file a mesa ticket:
> https://gitlab.freedesktop.org/mesa/mesa/-/issues
> And include your full dmesg output from boot to when the issue
> happens.
>=20
> Alex
>=20
> > ## System Information
> >=20
> > > Component | Version |
> > > -----------|---------|
> > > GPU | AMD Radeon RX 9060 XT =E2=80=94 Navi 44, RDNA 4, GFX1200
> > > [1002:7590] (rev c0) |
> > > Mesa | 26.0.2-1 (also reproduced on 26.0.1) |
> > > vulkan-radeon | 26.0.2-1 |
> > > libplacebo | v7.360.0 |
> > > Kernel | 6.19.8-zen1-1-zen |
> > > Firmware | linux-firmware-amdgpu 20260309-1 (SMC firmware
> > > 102.70.0) |
> > > CPU | 13th Gen Intel Core i7-1360P |
> > > Distro | blendOS (Arch-based, rolling) |
> > > mpv | v0.41.0, FFmpeg n8.0.1 |
> > > Connection | eGPU via Thunderbolt 4 (Razer Core X V2), PCIe 32
> > > GT/s x16 link |
> >=20
> > ### Module parameters
> >=20
> > ```
> > options amdgpu runpm=3D0 rebar=3D0 ppfeaturemask=3D0xFFFF7FFF
> > ```
> >=20
> > - `runpm=3D0` =E2=80=94 runtime PM disabled (TB eGPU SMU limitation)
> > - `rebar=3D0` =E2=80=94 BIOS assigns full 16 GB BAR, driver does not re=
size
> > - `ppfeaturemask=3D0xFFFF7FFF` =E2=80=94 GFXOFF disabled (bit 15) due t=
o SMU
> > IF version mismatch (driver 0x2E vs firmware 0x33)
> >=20
> > **Note:** The SMU interface version mismatch (`smu_v14_0: SMU
> > driver if version not matched`) is a separate known issue. GFXOFF
> > is disabled to prevent a bus-loss crash, but the rendering crash
> > described here is unrelated =E2=80=94 it occurs during active rendering=
,
> > not during idle.
> >=20
> > ## Steps to Reproduce
> >=20
> > 1. Install an AMD RX 9060 XT (Navi 44)
> > 2. Configure mpv with Vulkan rendering:
> > ```
> > vo=3Dgpu-next
> > gpu-api=3Dvulkan
> > gpu-context=3Dwaylandvk
> > vulkan-device=3D'AMD Radeon RX 9060 XT (RADV GFX1200)'
> > vulkan-async-compute=3Dyes
> > vulkan-async-transfer=3Dyes
> > ```
> > 3. Play any video file: `mpv /path/to/video.mkv`
> > 4. Wait ~20-30 seconds
> >=20
> > ### Test 1: Vulkan decode + Vulkan rendering (`hwdec=3Dvulkan`)
> >=20
> > Crashes after ~26 seconds.
> >=20
> > ### Test 2: VA-API decode (Intel iGPU) + Vulkan rendering
> > (`hwdec=3Dvaapi`)
> >=20
> > **Also crashes after ~26 seconds.** VA-API decode runs on the Intel
> > iGPU (`iHD_drv_video.so`), only Vulkan rendering runs on the AMD
> > GPU via RADV. This isolates the bug to the RADV rendering path.
> >=20
> > ## RADV Error Output
> >=20
> > ```
> > radv/amdgpu: The CS has been cancelled because the context is lost.
> > This context is guilty of a hard recovery.
> >=20
> > [vo/gpu-next/libplacebo] vkQueueSubmit2: VK_ERROR_DEVICE_LOST
> > (../src/vulkan/command.c:514)
> > [vo/gpu-next/libplacebo] Retrieving query pool results:
> > VK_ERROR_DEVICE_LOST (../src/vulkan/gpu.c:105)
> > [vo/gpu-next/libplacebo] Failed holding swapchain image for
> > presentation
> > [vo/gpu-next] Failed presenting frame!
> > [ffmpeg] vk: Unable to submit command buffer: VK_ERROR_DEVICE_LOST
> > [ffmpeg/video] h264: hardware accelerator failed to decode picture
> > ```
> >=20
> > ## Kernel Log (Crash 1 =E2=80=94 hwdec=3Dvulkan, Mesa 26.0.2)
> >=20
> > ```
> > amdgpu 0000:06:00.0: amdgpu: Dumping IP State
> > amdgpu 0000:06:00.0: amdgpu: [drm] AMDGPU device coredump file has
> > been created
> > amdgpu 0000:06:00.0: amdgpu: ring sdma0 timeout, signaled
> > seq=3D11425, emitted seq=3D11427
> > amdgpu 0000:06:00.0: amdgpu: Starting sdma0 ring reset
> > amdgpu 0000:06:00.0: amdgpu: Ring sdma0 reset succeeded
> > amdgpu 0000:06:00.0: [drm] device wedged, but recovered through
> > reset
> > amdgpu 0000:06:00.0: amdgpu: ring gfx_0.0.0 timeout, signaled
> > seq=3D16289, emitted seq=3D16291
> > amdgpu 0000:06:00.0: amdgpu: Process mpv pid 44985 thread vo pid
> > 45004
> > amdgpu 0000:06:00.0: amdgpu: Ring gfx_0.0.0 reset succeeded
> > amdgpu 0000:06:00.0: [drm] device wedged, but recovered through
> > reset
> > amdgpu 0000:06:00.0: amdgpu: ring comp_1.1.0 timeout, signaled
> > seq=3D13, emitted seq=3D14
> > amdgpu 0000:06:00.0: amdgpu: Process mpv pid 44985 thread vo pid
> > 45004
> > amdgpu 0000:06:00.0: amdgpu: Ring comp_1.1.0 reset succeeded
> > amdgpu 0000:06:00.0: [drm] device wedged, but recovered through
> > reset
> > amdgpu 0000:06:00.0: amdgpu: Fence fallback timer expired on ring
> > sdma1
> > amdgpu 0000:06:00.0: [drm] *ERROR* [CRTC:416:crtc-0] flip_done
> > timed out
> > ```
> >=20
> > ## Kernel Log (Crash 2 =E2=80=94 hwdec=3Dvaapi, Mesa 26.0.2)
> >=20
> > ```
> > amdgpu 0000:06:00.0: amdgpu: ring sdma0 timeout, signaled
> > seq=3D13615, emitted seq=3D13617
> > amdgpu 0000:06:00.0: amdgpu: Ring sdma0 reset succeeded
> > amdgpu 0000:06:00.0: [drm] device wedged, but recovered through
> > reset
> > amdgpu 0000:06:00.0: amdgpu: ring gfx_0.0.0 timeout, signaled
> > seq=3D30731, emitted seq=3D30733
> > amdgpu 0000:06:00.0: amdgpu: Process mpv pid 66481 thread vo pid
> > 66500
> > amdgpu 0000:06:00.0: amdgpu: Ring gfx_0.0.0 reset succeeded
> > amdgpu 0000:06:00.0: [drm] device wedged, but recovered through
> > reset
> > amdgpu 0000:06:00.0: amdgpu: ring comp_1.1.1 timeout, signaled
> > seq=3D312, emitted seq=3D313
> > ```
> >=20
> > ## GPU Device Coredump (Crash 1)
> >=20
> > ```
> > **** AMDGPU Device Coredump ****
> > version: 1
> > kernel: 6.19.8-zen1-1-zen
> > module: amdgpu
> > time: 3054.167340782
> >=20
> > SOC Device id: 30096
> > SOC Family: 152
> > SOC External Revision id: 65
> >=20
> > HWIP: GC[1][0]: v12.0.0.0.0
> > HWIP: SDMA0[3][0]: v7.0.0.0.0
> > HWIP: MMHUB[12][0]: v4.1.0.0.0
> >=20
> > Ring timed out details
> > IP Type: 2 Ring Name: sdma0
> >=20
> > [gfxhub] Page fault observed
> > Faulty page starting at address: 0x0000000000000000
> > Protection fault status register: 0x0
> > ```
> >=20
> > **Full coredump available on request** (543 KB).
> >=20
> > ## Analysis
> >=20
> > - The crash is a **NULL pointer dereference at GPU virtual address
> > 0x0** =E2=80=94 RADV is submitting commands that reference unmapped mem=
ory.
> > - The `Protection fault status register: 0x0` suggests the fault
> > info itself is zeroed, which may indicate the fault occurred very
> > early in command processing or in an SDMA copy from a NULL source.
> > - The fault hits sdma0 first, then cascades to gfx_0.0.0 and a
> > compute ring =E2=80=94 consistent with a resource upload (SDMA) referen=
cing
> > a NULL buffer, followed by the GFX/compute rings trying to use the
> > result.
> > - After ring resets, the GPU fully recovers (all fences drain, PCIe
> > link stays up at 32 GT/s x16), confirming this is a userspace
> > (RADV) command stream issue, not a hardware or kernel driver bug.
> > - The `flip_done timed out` on CRTC-0 is a secondary effect =E2=80=94 t=
he
> > compositor's page flip can't complete while rings are being reset,
> > which restarts the GNOME session.
> >=20
> > ## Additional Notes
> >=20
> > - The GPU is connected via Thunderbolt 4 (eGPU enclosure), but the
> > PCIe link stays healthy through the crash =E2=80=94 this is not a link/=
BAR
> > issue.
> > - This was also reproduced on Mesa 26.0.1 with kernel 6.19.6 and
> > firmware 20260221 (SMC 102.69.0) =E2=80=94 same crash signature.
> > - Desktop compositing (GNOME Shell / Mutter on Wayland) works fine
> > on this GPU =E2=80=94 only mpv's libplacebo rendering pipeline triggers=
 the
> > crash.
> > - `vulkan-async-compute=3Dyes` was enabled. Not yet tested with async
> > compute disabled, though the fault is on sdma0, not a compute ring.
