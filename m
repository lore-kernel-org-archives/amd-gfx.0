Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E315FD8765
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 13:00:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B4DB10E010;
	Tue, 17 Mar 2026 13:00:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XHA0gJ+D";
	dkim-atps=neutral
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E11A10E010
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 13:00:15 +0000 (UTC)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-128bae6a35aso235061c88.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 06:00:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773752414; cv=none;
 d=google.com; s=arc-20240605;
 b=R3xqNFlid6w+l4hVXAqLYh0iTS34rZjBaVIrr90Vy4IjixCVwJrcrWqp3VnjtL9LAH
 Rr71MknPArbl3vK9Ha8N7fJDy/nf1S02qLgkPXQSwRP3acZlo9V5pHE5T8aZm5vyMI3x
 /g9uvcWuVQGkBAw10RZH6dsnEvRr2axsqroXWIMu6UUklzq2m0oemcl1A9b8CjuD44Jm
 7/ukX1qV+eKhpNfgTnL5rSIjxWPXPd16KtamW9p0Cqp8yAZfZwx+gtq8O0Hf8T3LzMgo
 Zu6h4vUYfe9/6tW280V6ldWZUkZ8u4RXwb/fgmQOmmjBP0rtr3HRASOm52n2Xb/pJgBZ
 7jZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=91gwtsKWq2ZMo7Ncq5Q9UNpQBa245zsBfX5xNWPTmuw=;
 fh=0wWEBRPlODUfTvdkl0Nzk+pKVwC5+qJM6Ea17tyM5Xk=;
 b=BoOjDQmPSp8dLQHar9fOM4rAydliOIIIQn4p6F7NifYqu5PJuW7bfT9l6xaakKC6Jn
 dI8CsnJDOW2HR6FV2L/ARL29y3z/++/Y1JA+Dc/huqjl2OeFNaL1yg3vjYgqLsYlK6RV
 TDRtNj1LNDLbeVn0aavUAj1SiR8MzxvS3GqR6FElGhbe8Qx7vrsacv5cVbc5GYLYhnOA
 iry+a0yix9hgOXpeAwNUuSF2unT0000wBoKcKzUU2qkRBzhiX7KDae+WoY7KfaFbX+wE
 +P09g54MyLUeoz/5Bm4eUTwojEEzAZVeKhNUpHSxxfljqi6OiYgZjwkzKrp9S5FrbW98
 qurg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773752414; x=1774357214; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=91gwtsKWq2ZMo7Ncq5Q9UNpQBa245zsBfX5xNWPTmuw=;
 b=XHA0gJ+DufgaoOdZ9WMk/FQoi8eWM3GHr+smAkBhfMl4J08tlWV4rqydX0shqMnhho
 98dZsv+wOxJps1qRIwd2vr96uTN/zk+1epL5TEV9iPWTGVHdW6WqtXDpkLFFTCSEnEKe
 n0+LIT+jpOWhDiw0nql58hPmppVTP9WIEZJ/Joem8s+LGaFkzEpMHehRx5ER+28+Qfp2
 j73jsPUEJmRxvppU9iQ/7kSQretc+2xJaj8e6tqWN5QoeZ2EydTkPryQP/TQ+TJjIsw1
 op8E1Y1uURIrJgCQRTTvmvhjkWKTfjwpBjvItfQmkUwI7sVGzNYdvehWpDxlKADqkP/8
 mklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773752414; x=1774357214;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=91gwtsKWq2ZMo7Ncq5Q9UNpQBa245zsBfX5xNWPTmuw=;
 b=oiF7n7meoiiwkm4iks4ETK44EcupVEwF/jG6vqqjQ/xTXEtxKE1jDygySC9fphDbsD
 yj0Xc1nxX0jqPOQH13TOi8tdfOq1ZkJATfZTTjTsl8GlYsqQ1jlfBAUup3XPcJ48cWgZ
 AjltJfUTwAtwN8mv0oRwf/SPfb1lLS74dtW8mYVlbqHNEmlBRlLx1UC01iuuNUKa5FW6
 Bh/MTezVX/obZoVWvrtj0Q1esMZFBoiPz+yVLgnOztvwR71lNruTKGo2m/aiK+cLAx3H
 A1LNjt1vAALSnlT183VHlPm8IOo22u+tXqplohRbrPWsDUtXsdeD9YKidAp/Q5Rx05cQ
 qhuQ==
X-Gm-Message-State: AOJu0Yx2YBBFW9XTgMDxynto3r77fzt3tS7X78AWWIT8KXXggGqy93kA
 MXV3rVMj4Vuv4vKNoQLZJj+JSLcQY72yJRoPTm4TqdH2S5V9xhRjHYsOcvg8VkgZ0f2K5NAR1Fm
 +m4C+qDJHidEE5J294w9PRAdqve1hIYv/qPsz
X-Gm-Gg: ATEYQzw07qWu3rE2Jv9/fhBIhzwriLf4JB/ASgzNeAyjWC14ESVmSQU9JQ1T55f8DEv
 qnK+hDftYxeOGxVAnFHw6dhXnExnWqNtjTlTIjBiJ/WMG1Yx6EYvrVX1rdga0u5c4+tJItvXlar
 X0BesUexBS9eDUZrWzxiGwFal2hnSn3Bj+KZioGk10EGsdXCMtlBgTsuEac9IRwnNuCxAYe+XVF
 fQboCzR3YAb1hSpyisBGNTEXusTbGPQmMznRYdDMbxJP8nz/AzpR0xQtaqn8p+NR7pDKMOm2/9z
 AvB9xqLEvSG/GzLaE6KTvSV7xWSaTyuFLmGadv2dwERu9k9VGaBXli6VllQQjacaqRG4mA==
X-Received: by 2002:a05:7022:2391:b0:128:d4d5:93b9 with SMTP id
 a92af1059eb24-128f3ddb7e9mr3474949c88.7.1773752413954; Tue, 17 Mar 2026
 06:00:13 -0700 (PDT)
MIME-Version: 1.0
References: <dfce5e070c5857aaebd8e7136011b90e7d888eb1.camel@ieee.org>
In-Reply-To: <dfce5e070c5857aaebd8e7136011b90e7d888eb1.camel@ieee.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 Mar 2026 09:00:02 -0400
X-Gm-Features: AaiRm51OkZsgiLLo-dHci_ueRRDakzVVt35Hta2irDxRsk1Ntk6RCAqBgeURggI
Message-ID: <CADnq5_Nha0KqzAuoJayXtiFjsXq8DqbbPyWfoFinc=vPaAf9gg@mail.gmail.com>
Subject: Re: [Bug report] RADV GFX1200 (Navi 44 / RX 9060 XT): NULL page fault
 at 0x0 on gfxhub during Vulkan rendering
To: Cristian Cocos <cristi@ieee.org>
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

On Tue, Mar 17, 2026 at 4:24=E2=80=AFAM Cristian Cocos <cristi@ieee.org> wr=
ote:
>
> ## Summary
>
> RADV crashes with a `[gfxhub] Page fault at address: 0x0000000000000000` =
when performing Vulkan rendering on an AMD RX 9060 XT (Navi 44, GFX1200). T=
he crash occurs ~20-30 seconds into video playback in mpv using `vo=3Dgpu-n=
ext` with `gpu-api=3Dvulkan` (libplacebo). Multiple GPU rings (sdma0, gfx_0=
.0.0, comp_1.x.x) time out simultaneously. The kernel driver recovers the r=
ings, but the Vulkan context is lost.
>
> **Critically, the crash also occurs when video decode is offloaded to VA-=
API on a separate Intel iGPU** =E2=80=94 only the Vulkan rendering path (li=
bplacebo =E2=86=92 RADV =E2=86=92 `vkQueueSubmit2`) is involved. This rules=
 out VK_KHR_video_decode_queue as the cause.
>

Please file a mesa ticket:
https://gitlab.freedesktop.org/mesa/mesa/-/issues
And include your full dmesg output from boot to when the issue happens.

Alex

> ## System Information
>
> | Component | Version |
> |-----------|---------|
> | GPU | AMD Radeon RX 9060 XT =E2=80=94 Navi 44, RDNA 4, GFX1200 [1002:75=
90] (rev c0) |
> | Mesa | 26.0.2-1 (also reproduced on 26.0.1) |
> | vulkan-radeon | 26.0.2-1 |
> | libplacebo | v7.360.0 |
> | Kernel | 6.19.8-zen1-1-zen |
> | Firmware | linux-firmware-amdgpu 20260309-1 (SMC firmware 102.70.0) |
> | CPU | 13th Gen Intel Core i7-1360P |
> | Distro | blendOS (Arch-based, rolling) |
> | mpv | v0.41.0, FFmpeg n8.0.1 |
> | Connection | eGPU via Thunderbolt 4 (Razer Core X V2), PCIe 32 GT/s x16=
 link |
>
> ### Module parameters
>
> ```
> options amdgpu runpm=3D0 rebar=3D0 ppfeaturemask=3D0xFFFF7FFF
> ```
>
> - `runpm=3D0` =E2=80=94 runtime PM disabled (TB eGPU SMU limitation)
> - `rebar=3D0` =E2=80=94 BIOS assigns full 16 GB BAR, driver does not resi=
ze
> - `ppfeaturemask=3D0xFFFF7FFF` =E2=80=94 GFXOFF disabled (bit 15) due to =
SMU IF version mismatch (driver 0x2E vs firmware 0x33)
>
> **Note:** The SMU interface version mismatch (`smu_v14_0: SMU driver if v=
ersion not matched`) is a separate known issue. GFXOFF is disabled to preve=
nt a bus-loss crash, but the rendering crash described here is unrelated =
=E2=80=94 it occurs during active rendering, not during idle.
>
> ## Steps to Reproduce
>
> 1. Install an AMD RX 9060 XT (Navi 44)
> 2. Configure mpv with Vulkan rendering:
> ```
> vo=3Dgpu-next
> gpu-api=3Dvulkan
> gpu-context=3Dwaylandvk
> vulkan-device=3D'AMD Radeon RX 9060 XT (RADV GFX1200)'
> vulkan-async-compute=3Dyes
> vulkan-async-transfer=3Dyes
> ```
> 3. Play any video file: `mpv /path/to/video.mkv`
> 4. Wait ~20-30 seconds
>
> ### Test 1: Vulkan decode + Vulkan rendering (`hwdec=3Dvulkan`)
>
> Crashes after ~26 seconds.
>
> ### Test 2: VA-API decode (Intel iGPU) + Vulkan rendering (`hwdec=3Dvaapi=
`)
>
> **Also crashes after ~26 seconds.** VA-API decode runs on the Intel iGPU =
(`iHD_drv_video.so`), only Vulkan rendering runs on the AMD GPU via RADV. T=
his isolates the bug to the RADV rendering path.
>
> ## RADV Error Output
>
> ```
> radv/amdgpu: The CS has been cancelled because the context is lost.
> This context is guilty of a hard recovery.
>
> [vo/gpu-next/libplacebo] vkQueueSubmit2: VK_ERROR_DEVICE_LOST (../src/vul=
kan/command.c:514)
> [vo/gpu-next/libplacebo] Retrieving query pool results: VK_ERROR_DEVICE_L=
OST (../src/vulkan/gpu.c:105)
> [vo/gpu-next/libplacebo] Failed holding swapchain image for presentation
> [vo/gpu-next] Failed presenting frame!
> [ffmpeg] vk: Unable to submit command buffer: VK_ERROR_DEVICE_LOST
> [ffmpeg/video] h264: hardware accelerator failed to decode picture
> ```
>
> ## Kernel Log (Crash 1 =E2=80=94 hwdec=3Dvulkan, Mesa 26.0.2)
>
> ```
> amdgpu 0000:06:00.0: amdgpu: Dumping IP State
> amdgpu 0000:06:00.0: amdgpu: [drm] AMDGPU device coredump file has been c=
reated
> amdgpu 0000:06:00.0: amdgpu: ring sdma0 timeout, signaled seq=3D11425, em=
itted seq=3D11427
> amdgpu 0000:06:00.0: amdgpu: Starting sdma0 ring reset
> amdgpu 0000:06:00.0: amdgpu: Ring sdma0 reset succeeded
> amdgpu 0000:06:00.0: [drm] device wedged, but recovered through reset
> amdgpu 0000:06:00.0: amdgpu: ring gfx_0.0.0 timeout, signaled seq=3D16289=
, emitted seq=3D16291
> amdgpu 0000:06:00.0: amdgpu: Process mpv pid 44985 thread vo pid 45004
> amdgpu 0000:06:00.0: amdgpu: Ring gfx_0.0.0 reset succeeded
> amdgpu 0000:06:00.0: [drm] device wedged, but recovered through reset
> amdgpu 0000:06:00.0: amdgpu: ring comp_1.1.0 timeout, signaled seq=3D13, =
emitted seq=3D14
> amdgpu 0000:06:00.0: amdgpu: Process mpv pid 44985 thread vo pid 45004
> amdgpu 0000:06:00.0: amdgpu: Ring comp_1.1.0 reset succeeded
> amdgpu 0000:06:00.0: [drm] device wedged, but recovered through reset
> amdgpu 0000:06:00.0: amdgpu: Fence fallback timer expired on ring sdma1
> amdgpu 0000:06:00.0: [drm] *ERROR* [CRTC:416:crtc-0] flip_done timed out
> ```
>
> ## Kernel Log (Crash 2 =E2=80=94 hwdec=3Dvaapi, Mesa 26.0.2)
>
> ```
> amdgpu 0000:06:00.0: amdgpu: ring sdma0 timeout, signaled seq=3D13615, em=
itted seq=3D13617
> amdgpu 0000:06:00.0: amdgpu: Ring sdma0 reset succeeded
> amdgpu 0000:06:00.0: [drm] device wedged, but recovered through reset
> amdgpu 0000:06:00.0: amdgpu: ring gfx_0.0.0 timeout, signaled seq=3D30731=
, emitted seq=3D30733
> amdgpu 0000:06:00.0: amdgpu: Process mpv pid 66481 thread vo pid 66500
> amdgpu 0000:06:00.0: amdgpu: Ring gfx_0.0.0 reset succeeded
> amdgpu 0000:06:00.0: [drm] device wedged, but recovered through reset
> amdgpu 0000:06:00.0: amdgpu: ring comp_1.1.1 timeout, signaled seq=3D312,=
 emitted seq=3D313
> ```
>
> ## GPU Device Coredump (Crash 1)
>
> ```
> **** AMDGPU Device Coredump ****
> version: 1
> kernel: 6.19.8-zen1-1-zen
> module: amdgpu
> time: 3054.167340782
>
> SOC Device id: 30096
> SOC Family: 152
> SOC External Revision id: 65
>
> HWIP: GC[1][0]: v12.0.0.0.0
> HWIP: SDMA0[3][0]: v7.0.0.0.0
> HWIP: MMHUB[12][0]: v4.1.0.0.0
>
> Ring timed out details
> IP Type: 2 Ring Name: sdma0
>
> [gfxhub] Page fault observed
> Faulty page starting at address: 0x0000000000000000
> Protection fault status register: 0x0
> ```
>
> **Full coredump available on request** (543 KB).
>
> ## Analysis
>
> - The crash is a **NULL pointer dereference at GPU virtual address 0x0** =
=E2=80=94 RADV is submitting commands that reference unmapped memory.
> - The `Protection fault status register: 0x0` suggests the fault info its=
elf is zeroed, which may indicate the fault occurred very early in command =
processing or in an SDMA copy from a NULL source.
> - The fault hits sdma0 first, then cascades to gfx_0.0.0 and a compute ri=
ng =E2=80=94 consistent with a resource upload (SDMA) referencing a NULL bu=
ffer, followed by the GFX/compute rings trying to use the result.
> - After ring resets, the GPU fully recovers (all fences drain, PCIe link =
stays up at 32 GT/s x16), confirming this is a userspace (RADV) command str=
eam issue, not a hardware or kernel driver bug.
> - The `flip_done timed out` on CRTC-0 is a secondary effect =E2=80=94 the=
 compositor's page flip can't complete while rings are being reset, which r=
estarts the GNOME session.
>
> ## Additional Notes
>
> - The GPU is connected via Thunderbolt 4 (eGPU enclosure), but the PCIe l=
ink stays healthy through the crash =E2=80=94 this is not a link/BAR issue.
> - This was also reproduced on Mesa 26.0.1 with kernel 6.19.6 and firmware=
 20260221 (SMC 102.69.0) =E2=80=94 same crash signature.
> - Desktop compositing (GNOME Shell / Mutter on Wayland) works fine on thi=
s GPU =E2=80=94 only mpv's libplacebo rendering pipeline triggers the crash=
.
> - `vulkan-async-compute=3Dyes` was enabled. Not yet tested with async com=
pute disabled, though the fault is on sdma0, not a compute ring.
