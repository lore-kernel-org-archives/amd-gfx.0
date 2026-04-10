Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C235E9905A
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2026 07:07:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD1BC10E8DC;
	Fri, 10 Apr 2026 07:07:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=jqluv-com.20251104.gappssmtp.com header.i=@jqluv-com.20251104.gappssmtp.com header.b="eEvBXVH6";
	dkim-atps=neutral
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com
 [209.85.160.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCC9B10E897
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2026 06:22:13 +0000 (UTC)
Received: by mail-qt1-f174.google.com with SMTP id
 d75a77b69052e-50d59d249fbso18273321cf.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Apr 2026 23:22:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775802133; cv=none;
 d=google.com; s=arc-20240605;
 b=kqf5BjRk5z+z6X/pgnPAVOroAJ1ik1nJF4dlPx1HlRMI/9jg7r+umnJDb2ggffZl6W
 R9KC6ZuuPOJsOFaOUwSv5eiQwCGdtXtNevIaAfvqEb5qTwsyWD9DKaRqtL+HecUpUHZF
 mCTVJsO4RMSI2S7O7VEQJESBc7XHYK+Uf5P4Ou/h3GpUsC/yMYTDJk4GA2URb3BQwnFz
 gkgsBiC1t3U+k9cfnd/wzSw2SuzxK0iHIokG6ZVqKaXanPXYWEn/YlDkbnocucS4au2+
 /TGBcppeTKA3A7fBmHJG18feS6yY2yMAlamqNXKVm8C65SPDMfYPysmCQzub2ZdNN1ik
 TcAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9jkymA49WkuhSard3NKoPMlaT8t0ZFZl02NFSiqvDYo=;
 fh=VuTRX/vuqS3qyrdP1fS+WyE227OiPYWG9OUyI9+cxwA=;
 b=YYLTGqT5ARDnJjDVmdgQRTuIcv+nxMPikBkab88QK0Vc4xrRtdWHChiv1dhgAx8cRF
 JgKPQaFM5SzXAIh9djbbp4pZ7C13DS/2XauayQlRenpucYhNweu5qeheb/OLsHr8ZsNP
 CPglf+ZOQi6hycdhyCpJCDpDgxuJP3ivs0LT62e2HX7N9u0D44dF1W1VuzUUh59xtxRg
 h50i12NKD6fGXhcYBEWTnFaxGFgR0/tiUFT/w6mjGYiFAAzu1FLvwkfGePGU+h/nHemJ
 8sYt4R72UQV3f1LUaIT2uP8RD0dg339kRX0YaJ18XN3/v1uJkJsqodiBJugBAYGz1kYS
 575Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jqluv-com.20251104.gappssmtp.com; s=20251104; t=1775802133; x=1776406933;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9jkymA49WkuhSard3NKoPMlaT8t0ZFZl02NFSiqvDYo=;
 b=eEvBXVH6hzbLlJmFqed4WEEpfbmzP180Z1P7LlEK17gk3yn74WFfBnfG5R9xUcF6XM
 52NfKpCiKiB3NUbl5vQPzn8Nx5lrniqQF0HJbLNFm66rP3WLsvpZT3V2WCdhRzH3+YmB
 PBMpCzD7Tlp2uY1m8tVMh8J5Zn6QJJMUfw0qWwZA/G7wiGt3fYmbFTjO2oM28r6s21tk
 HDRz2qTsS9P2qVOfBjGgQ8N3Ox9+YEv4N8WehuvuuDQ+OKaZN2602F4XGiAO1cXqjYSF
 kabDP2g03y1XBE3dpM9Xvm6sxzeKtGEbkFSQyQ+xU+yOBkkWZyGeeUskYGK1OyCTlGWh
 H8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775802133; x=1776406933;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9jkymA49WkuhSard3NKoPMlaT8t0ZFZl02NFSiqvDYo=;
 b=ZYOlf6f+MPEZREa+prubUI8dRLPvw2wT8Ehf+aTvXfCjVBjwTrW0ahZ4l+a3Tp3qnl
 WzjyuJk3+ok9PzvVvZk3BmFR7XRGS/k4eou+N7Fsk/3WwwoqgImYZ9OIcuZoG+/265qn
 Kam4L1+6UfrCmx9l+RsrV1t+pKQlVtXBNPwFPll8jqcAOjMM4ThyElv/yRtqN7rnBa2+
 vFKev+4FQq4OoZNfYTJgegYsH2tbLZ8AXharaaw7W8hkolu68DHqz65Jelu2QvIBQ/0I
 vfAsQomPQC7/JOjmOX/yowevoPttkHgl6eKrO18kBHzWIPbgNQI7H6NGEVTs6mUoT/tM
 kWLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUa8v5XbphfLHxwTW2SZF5Z2X/jB7djLX++JEFDKEHeiSaZXQ7Ne7nAWBlOvkA7p5zlsh9WF6Zx@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyHDaOugrnkZZ8t2P8724sMHSGXK2uUuSAcMf8T1iMY6JWMSJbz
 lsHYa3fe9crjf1s8EnTiDQC9x5nMO+x+mIvcP+t3QMaUcglIK6P3lKofaXBufMCzTTohfsxr1Z2
 5a5TfuX1Pz1Kq9Egsj8EIU4dcmOr6bV9y4BZcNpO09A==
X-Gm-Gg: AeBDieuwcBFfOgt1LckTLnYlbeXUNrhJz8AjZ24GWPiEJGi98fQWGGgu+AfP2ro39iE
 GqIzfu9WTXRbFmTb2QXKVWFvb6BjaRGwXcn7+83BoCg0B+O/yltPHEgYq+rOJk0kbd0ydDcW9Yb
 ZpPZV7xOuocdckD6Z8wEJVoqzIJIeshDCSR5a8RoTh1EPcyZW6KqZkHawXsqyM7juDpNASUOqws
 QLhs4XguGLGE+4Mv2mTXz6i2iJcZPAAeBKGImBRO9UzKW+gaqOOjtsgXUu/HD2QzZjoo2sjdYG6
 WjqXwOrLKV9dQv5Ze02wye90HJBmnrqVwo0oC/CVLc8buHavVpg=
X-Received: by 2002:a05:622a:a707:b0:50d:a466:6d11 with SMTP id
 d75a77b69052e-50dd5b77e0cmr24572661cf.33.1775802132410; Thu, 09 Apr 2026
 23:22:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAGpo2mebCaP4vFuTnn6jgu6OjjE_ssS7i8ENepuUjwwHXddCHA@mail.gmail.com>
 <243af06e-912b-4915-bc64-5aa16dad7db0@amd.com>
 <47306de6-cbf6-4b2d-847e-d1e5d933516d@amd.com>
 <CAGpo2mfy+eWLrfYe2u=DEuP9xdY5pGedGEmpbGB4cetCVYWSAQ@mail.gmail.com>
In-Reply-To: <CAGpo2mfy+eWLrfYe2u=DEuP9xdY5pGedGEmpbGB4cetCVYWSAQ@mail.gmail.com>
From: Geramy Loveless <gloveless@jqluv.com>
Date: Thu, 9 Apr 2026 23:22:00 -0700
X-Gm-Features: AQROBzBBC0bKocKHL6VnBDnva1fGGUoV8oJHWSGOsGKvniGeAXTYvwqmUT474jQ
Message-ID: <CAGpo2me6SjmijfQ_QyAvudaakB5zBOy47vALLqrtSXsP9yE3Vg@mail.gmail.com>
Subject: Re: [PATCH] amdgpu: recover Thunderbolt PCIe link after MODE1 GPU
 reset
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 10 Apr 2026 07:07:32 +0000
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

Before you guys waste your time reading all the below, dont.
I had made a mistake in my patch to PCI basically causing the entire
tree of devices to get released, I was using an unsafe version of the
pci API.
It has been corrected following suggestions by the reviewer on the
original patch.

https://lore.kernel.org/linux-pci/20260410052918.5556-2-gloveless@jqluv.com=
/

If you would like I still could submit some safety patch work as mario
was suggesting that its not a bad idea to have the ability
to handle edge case situations to prevent crashing in the future if
something goes awry. There was also one basically the GPU would not
get initialized correctly and it would attempt to access null
reference rings which never got filled.

I appreciate the help and explanation of how the systems on the GPU
work and look forward to learning more but hopefully not because of a
bug that either
I cause or run across haha :) I am going to start backing out the
kernel parameters in hopes that everything is happy with the pci fix I
implemented and hopefully i dont need to set params.



On Thu, Apr 9, 2026 at 5:12=E2=80=AFPM Geramy Loveless <gloveless@jqluv.com=
> wrote:
>
> Hey,
>
> I have nearly finished my patch, I need to double check some stuff
> first but here is a summary of the real cause that I can see.
> See below for a in depth in depth analysis. I am not sure technically
> if thunderbolt is at fault in this scenario or the amdgpu please let
> me know what your opinion is on this and where it should be patched
> at. Of course the patch i'm working on allows for a resolution path if
> it happens which is a nice recovery mode but it doesnt solve it
> occuring.
>
> ## Summary
>
> R9700 Pro [1002:7551] (gfx1201) connected via Thunderbolt 5 dock. GPU
> initializes fully but MMIO becomes unreachable while PCIe config space
> continues to work. MMIO becomes unresponsive,
> cascading into SDMA timeouts and GPU reset loops. Reproduced on two
> separate boots (10s and 96s after init).
>
> The split between working config space and dead MMIO points to the
> Thunderbolt PCIe tunnel selectively dropping memory transactions while
> continuing to pass configuration transactions.
>
> ## Hardware
>
> - Host: MSI MS-S1 MAX (Strix Halo), AMD IOMMU
> - Thunderbolt host controller: Intel Barlow Ridge TB5 [8086:5780] at 67:0=
0.0
> - Dock: Razer Core X V2 (TB4, FW 59.82)
> - GPU: AMD R9700 Pro [1002:7551] gfx1201, 32GB GDDR6
> - Connection: TB5 host =E2=86=92 TB4 dock, 40 Gb/s dual lane
> - TB tunnel: PCIe 0:10 <-> 3:9, extended encapsulation enabled
> - PCIe topology through dock:
> ```
> 66:03.0 TB bridge (32GB pref window)
> 93:00.0 Intel 5786 Upstream Switch
> 94:00.0 Intel 5786 Downstream Switch (Gen4 x4 to AMD switch)
> 95:00.0 AMD 1478 Upstream Switch
> 96:00.0 AMD 1479 Downstream Switch (Gen5 x16 to GPU)
> 97:00.0 GPU [1002:7551]
> ```
> - No display connected to eGPU
>
> ## Kernel
>
> ```
> Linux 7.0.0-rc7-egpu+ #7 SMP PREEMPT_DYNAMIC
> cmdline: pcie_port_pm=3Doff pcie_aspm=3Doff amdgpu.runpm=3D0
> ```
>
> ## The evidence
>
> ### 1. GPU initializes successfully on both boots
>
> Boot -1 (7.0.0-rc7-egpu+, journalctl, precise timestamps):
> ```
> 16:45:46.038 SMU is initialized successfully!
> 16:45:46.038 [drm] Display Core v3.2.369 initialized on DCN 4.0.1
> 16:45:46.131 runtime pm is manually disabled
> 16:45:46.131 [drm] Initialized amdgpu 3.64.0 for 0000:97:00.0 on minor 0
> ```
>
> Boot 0 (7.0.0-rc7-egpu+, dmesg):
> ```
> [9551.162] SMU is initialized successfully!
> [9551.163] [drm] Display Core v3.2.369 initialized on DCN 4.0.1
> [9551.248] runtime pm is manually disabled
> [9551.249] [drm] Initialized amdgpu 3.64.0 for 0000:97:00.0 on minor 0
> ```
>
> All IP blocks come up clean. 32624MB VRAM. 64 CUs. SMU responds to
> all init-time messages. No errors during initialization.
>
> ### 2. SMU becomes unreachable after variable delay
>
> Boot -1 =E2=80=94 **10 seconds** after init:
> ```
> 16:45:56.192 Failed to disable gfxoff!
> 16:45:56.192 SMU is in hanged state, failed to send smu message!
> 16:45:56.192 Failed to export SMU metrics table!
> (repeated ~30 times)
> ```
>
> Boot 0 =E2=80=94 **96 seconds** after init:
> ```
> [9647.872] Failed to export SMU metrics table!
> [9647.872] SMU is in hanged state, failed to send smu message!
> (repeated)
> [9661.567] Failed to disable gfxoff!
> ```
>
> The delay is not consistent (10s vs 96s), ruling out a fixed firmware
> timer. The first failing operation varies (gfxoff disable vs metrics
> export), suggesting the SMU itself isn't crashing =E2=80=94 the communica=
tion
> path to it is dying.
>
> ### 3. Config space alive, MMIO dead (proved during boot 0 crash)
>
> Tested during the active crash with the GPU in "SMU hanged" state:
>
> **Config space (works):**
> ```
> $ sudo setpci -s 97:00.0 0x00.l
> 75511002 =E2=86=90 correct vendor/device ID
> $ sudo setpci -s 97:00.0 0x04.l
> 00100406 =E2=86=90 status/command register OK
> ```
>
> **MMIO BAR5 at 0xc4000000 =E2=80=94 SMU register space (dead):**
> ```python
> fd =3D os.open('/sys/bus/pci/devices/0000:97:00.0/resource5', os.O_RDONLY=
)
> data =3D os.read(fd, 4)
> # OSError: [Errno 5] Input/output error
> ```
>
> **MMIO BAR0 at 0x8880000000 =E2=80=94 VRAM (dead):**
> ```python
> fd =3D os.open('/sys/bus/pci/devices/0000:97:00.0/resource0', os.O_RDONLY=
)
> data =3D os.read(fd, 4)
> # OSError: [Errno 5] Input/output error
> ```
>
> Config transactions reach the device through the TB tunnel. Memory
> transactions do not. This is the root cause of the "SMU hanged state" =E2=
=80=94
> the SMU firmware is likely fine, but the MMIO writes to its mailbox
> registers never arrive.
>
> ### 4. Thunderbolt host router and dock are runtime-suspended
>
> Monitored with 2-second polling during the crash:
> ```
> 16:54:06 host=3Dsuspended dock=3Dsuspended gpu_errors=3D1
> 16:54:09 host=3Dsuspended dock=3Dsuspended gpu_errors=3D3
> 16:54:11 host=3Dsuspended dock=3Dsuspended gpu_errors=3D5
> ...
> 16:54:57 host=3Dsuspended dock=3Dsuspended gpu_errors=3D119
> ```
>
> TB host router runtime PM configuration:
> ```
> /sys/bus/thunderbolt/devices/0-0/power/control =3D auto
> /sys/bus/thunderbolt/devices/0-0/power/autosuspend_delay_ms =3D 15000
> /sys/bus/thunderbolt/devices/0-0/power/runtime_status =3D suspended
> ```
>
> Both the TB host router and dock switch show `suspended` throughout
> the crash. The PCIe tunnel was activated while they were in this state.
>
> ### 5. Waking TB host router does not restore MMIO
>
> ```
> $ echo "on" > /sys/bus/thunderbolt/devices/0-0/power/control
> $ cat /sys/bus/thunderbolt/devices/0-0/power/runtime_status
> active
>
> $ python3 -c "os.read(os.open('/sys/bus/pci/devices/.../resource5', ...),=
 4)"
> # OSError: [Errno 5] Input/output error =E2=86=90 still dead
> ```
>
> Once MMIO is lost, waking the TB host router doesn't recover it. The
> damage to the memory transaction path persists until device removal
> and re-enumeration (or reboot).
>
> ### 6. Full crash cascade (boot -1)
>
> ```
> 16:45:46 Init complete
> 16:45:56 SMU hanged (MMIO path dead)
> 16:45:58 SDMA ring timeout =E2=86=92 ring reset succeeds
> 16:46:00 SDMA ring timeout again =E2=86=92 ring reset succeeds
> 16:51:16 Full GPU reset (MODE1 via SMU)
> 16:51:33 GPU reset succeeded, SMU resumed
> GPU runs for 37 more minutes
> 17:28:17 SDMA timeout =E2=86=92 ring reset FAILS
> 17:28:17 GPU reset returns -ENODEV (device gone from bus)
> Infinite reset loop, system unusable
> ```
>
> MODE1 reset succeeds once (re-establishing the MMIO path temporarily)
> but the problem recurs, and the second MODE1 reset kills the PCIe link
> entirely (-ENODEV).
>
> ## Configuration notes
>
> - `amdgpu.runpm=3D0` is set and confirmed. GPU runtime PM (BOCO) is not
> active. This does not prevent the crash.
> - `pcie_port_pm=3Doff pcie_aspm=3Doff` are set. PCIe link power managemen=
t
> is disabled. This does not prevent the crash.
> - TB host router runtime PM (`power/control=3Dauto`) is NOT disabled by
> any of the above kernel parameters.
> - SMU FW version mismatch: driver expects interface 0x2e, FW reports 0x32=
.
> Init succeeds despite mismatch.
> - "PCIE atomic ops is not supported" =E2=80=94 TB bridge doesn't support =
AtomicOps.
>
> ## Related
>
> - GitLab issue: https://gitlab.freedesktop.org/drm/amd/-/work_items/4978
> - Device: [1002:7551] (gfx1201, Navi 48, R9700 Pro)
> - SMU FW: smu_v14_0_2, version 0x00684a00 (104.74.0)
> - SMU driver if version 0x2e, fw if version 0x32 (mismatch)
> - TB host controller: Intel Barlow Ridge [8086:5780], FW 61.83
> - TB dock: Razer Core X V2, FW 59.82
>
>
>
>
> Geramy L. Loveless
> Founder & Chief Innovation Officer
>
> JQluv.net, Inc.
> Site: JQluv.com
> Mobile: 559.999.1557
> Office: 1 (877) 44 JQluv
>
>
>
>
> On Thu, Apr 9, 2026 at 11:12=E2=80=AFAM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
> >
> >
> >
> > On 4/9/26 06:42, Christian K=C3=B6nig wrote:
> > > On 4/9/26 02:05, Geramy Loveless wrote:
> > >> When an AMD GPU behind a Thunderbolt PCIe tunnel undergoes a MODE1 o=
n
> > >> Thunderbolt the TB driver receives no notification and the tunnel
> > >> stays up while the endpoint is unreachable.
> > >
> > > IIRC a MODE1 reset should keep the bus active and so the endpoint sho=
uld still be reachable.
> > >
> > >> All subsequent PCIe
> > >> reads return 0xFFFFFFFF and MES firmware cannot reinitialize,
> > >> triggering an infinite reset loop that hangs the system.
> > >
> > > That sounds more like the MODE1 reset failed.
> > >
> > >> After MODE1 reset completes, check whether the PCIe endpoint is stil=
l
> > >> reachable using pci_device_is_present(). If the device is behind
> > >> Thunderbolt and the link is dead, walk up parent bridges calling
> > >> pci_bridge_secondary_bus_reset() to retrain the physical PCIe link
> > >> inside the dock.
> > >
> > > Well that is then a bus reset.
> > >
> > > I mean that is a reasonable mitigation when a MODE1 reset failed, but=
 the question is rather why does the MODE1 reset fails in the first place?
> > >
> > >> If recovery fails, return -ENODEV to prevent the
> > >> reset retry loop.
> > >>
> > >> This also causes the GPU fan to be at 100% and basically when it
> > >> happens and you are not there, you now have a GPU with fan at 100% a=
nd
> > >> cant reset it.
> > >> I wanted to notate some other things I am finding sometimes before
> > >> this adventure of patches to the kernel and amdgpu driver.
> > >> Sometimes a crash could happen in the drive and then the GPU fan spe=
ed
> > >> hits 100% and the air is hot coming out without any workload, other
> > >> times
> > >> I have seen it have barely any fan speed at all and heat up more tha=
n
> > >> it should at the fan level its curently operating at. These are thin=
gs
> > >> I have seen with this gpu in a TB5 dock with the driver and
> > >> instability. I'm not sure exactly whats going on there but I figured
> > >> since im communicating with these patches I might as well bring you =
up
> > >> to speed and supermario has been great help throughout me trying to
> > >> get the AMD AI R9700 Pro working on my MS-S1 Halo Strix with a TB5 /
> > >> USB4v2 dock!
> > >
> > > Adding Mario as well. That strongly sounds like you crashed the SMU w=
hich would also explain the failed MODE1 reset.
> > >
> > > But all of that are only symptoms. Question is what is actually going=
 on here? e.g. what is the root cause?
> >
> > We don't spend a lot of time in recovery scenarios for when =F0=9F=92=
=A9 hits the
> > fan.  I think in addition to finding and fixing the real root cause
> > having a reproducible workload to cause the crash is a good opportunity
> > to try to put in place better recovery too.
> >
> > Generally speaking I like the idea of if a mode1 reset fails to do a
> > harder reset.  At least in the path that we have GPU recovery
> > (amdgpu.gpu_recovery module parameter) set, adding a fallback case to d=
o
> > a full device reset makes sense to me.
> >
> > I think the placement is wrong though.  amdgpu_device_mode1_reset() has
> > a bunch of callers, and if you end up with a mode1 reset doing a full
> > reset that might be a surprise to those callers.
> >
> > So I think a more logical place to put this would be explicitly in the
> > GPU recovery path (amdgpu_device_gpu_recover).  Maybe as part of the
> > mode1 reset failure you can:
> >
> > set_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
> >
> > And then the GPU recovery path can jump right into a full reset?  Not
> > sure if that jives with your stack trace though.
> >
> > Furthermore; even though you reproduced this on Thunderbolt; I have no
> > reason to believe it's specific to thunderbolt.  An SMU crash can happe=
n
> > in any hardware.  We may as well try full reset for recovery for any
> > hardware.
> >
> > >
> > >>
> > >> It seems to be finally working with bar resizing after my kernel
> > >> patch. Which allows you to safely release a empty switch bridge at t=
he
> > >> device end.
> > >> Then it rebuilds it afterwords with the increased bar. This was done
> > >> on Kernel 7.0-rc7 i believe it is and latest changes from pci/resour=
ce
> > >> branch with my patch here.
> > >>
> > >> https://lore.kernel.org/linux-pci/CAGpo2meKY6SXsESU-D0PGgbESLqdF8UBF=
-tmThxOvk2XUDpEzw@mail.gmail.com/T/#u
> > >
> > > Where is the MMIO register BAR before and after the rebuild?
> > >
> > > Regards,
> > > Christian.
> > >
> > >>
> > >> Thank you!
> > >>
> > >> Signed-off-by: Geramy Loveless <gloveless@jqluv.com>
> > >> ---
> > >> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 40 ++++++++++++++++++++=
++
> > >> 1 file changed, 40 insertions(+)
> > >>
> > >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > >> index 31a60173c..91d01d538 100644
> > >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > >> @@ -5770,6 +5770,46 @@ int amdgpu_device_mode1_reset(struct amdgpu_d=
evice *adev)
> > >> /* ensure no_hw_access is updated before we access hw */
> > >> smp_mb();
> > >> + /*
> > >> + * On Thunderbolt-attached GPUs, MODE1 reset kills the PCIe
> > >> + * endpoint but the TB tunnel stays up unaware. Detect the
> > >> + * dead link and attempt recovery by resetting parent bridges
> > >> + * to retrain the physical PCIe link inside the dock.
> > >> + */
> > >> + if (!pci_device_is_present(adev->pdev) &&
> > >> + pci_is_thunderbolt_attached(adev->pdev)) {
> > >> + struct pci_dev *bridge;
> > >> + bool recovered =3D false;
> > >> +
> > >> + dev_info(adev->dev,
> > >> + "PCIe link lost after mode1 reset, attempting Thunderbolt recovery=
\n");
> > >> +
> > >> + bridge =3D pci_upstream_bridge(adev->pdev);
> > >> + while (bridge && !pci_is_root_bus(bridge->bus)) {
> > >> + dev_info(adev->dev,
> > >> + "attempting link recovery via %s\n",
> > >> + pci_name(bridge));
> > >> + pci_bridge_secondary_bus_reset(bridge);
> > >> + msleep(100);
> > >> + if (pci_device_is_present(adev->pdev)) {
> > >> + recovered =3D true;
> > >> + break;
> > >> + }
> > >> + bridge =3D pci_upstream_bridge(bridge);
> > >> + }
> > >> +
> > >> + if (!recovered) {
> > >> + dev_err(adev->dev,
> > >> + "Thunderbolt PCIe link recovery failed\n");
> > >> + ret =3D -ENODEV;
> > >> + goto mode1_reset_failed;
> > >> + }
> > >> +
> > >> + dev_info(adev->dev,
> > >> + "Thunderbolt PCIe link recovered via %s\n",
> > >> + pci_name(bridge));
> > >> + }
> > >> +
> > >> amdgpu_device_load_pci_state(adev->pdev);
> > >> ret =3D amdgpu_psp_wait_for_bootloader(adev);
> > >> if (ret)
> > >> --
> > >> 2.51.0
> > >
> >
