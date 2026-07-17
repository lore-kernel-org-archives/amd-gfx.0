Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE50C4451B
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2026 21:20:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A267E10E1A6;
	Fri, 17 Jul 2026 21:20:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TmVo8kL4";
	dkim-atps=neutral
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E514610E09A
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jul 2026 21:20:19 +0000 (UTC)
Received: by mail-qt1-f173.google.com with SMTP id
 d75a77b69052e-51c05dcdf49so95964111cf.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jul 2026 14:20:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784323219; cv=none;
 d=google.com; s=arc-20260327;
 b=FenrBA0C2rAq9aJuwS9jLGrL+c4TAGCu2kGdL5vTYn9UWVUh6IelVhuBhk2h89HYH/
 hP2P+hGStMG+i5mQj4VTfcRImi4xRZ3q6BjOnN53XUKlkBqQHtoiGz3lkA2PHT8Yd802
 zresjyKtqvsNABVF1YSPQ6+AbSriN4rouPuJeRSgZkWyVxaAUA4otieVT+1jbdksIbjY
 FQlLvkE+oksl6QD5/Imslt4iz5/wW1lcaRykR2RloVy5BMqGLcsTcP65hCvP8Aglkmcq
 9otjeonGsRmAalRYp+0fHlQXKFRgJFiDT/2so4/0T7uTIKthP44hlxtr8PdxuZCB4GSq
 fGgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LVO9oFcqHAfiXoC8yBmRh7SOK0Mm4H1Q9jwyseAbOfg=;
 fh=eexG6Q8SwC49V8/TQ5GGt2yI3kNFjJ9V1pA0dnlQXIY=;
 b=OTqHFy6M4qM6vJVLdbnc11iIdAQmOrJJA7YOLq40j2uFEMzvaKxBSWvRSF9MUgxXAZ
 pVd7u96xGebYNU3vbfNvwAYTmS93e/zkhYexP1AObd5bpztz2qye0k2Q9DnnLcmsvq6X
 Jlennar/avszcFJJZ4EFPf33yWLrsvJcs791N07WUyHEhwv45XR1kv2AfRdM6FbbLu0T
 zp7UT9vHrubQNxslwslcDREA9OScZyTqNMNKXne2WXp2WvE+kfxTdP6atbg8xrE40xub
 +1CCJvw24jCKwWZ42j1558YKbBfeJHuZChztzDGO/753RH5sGOELvfIVN6gzm1CxptRB
 7YEA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784323219; x=1784928019; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LVO9oFcqHAfiXoC8yBmRh7SOK0Mm4H1Q9jwyseAbOfg=;
 b=TmVo8kL4nVFKuAL9JL5J/y1BKi6NlaccepKSR3Ui4wjOplwP7vu9cehIx3s47c2Ypq
 Mw9imSwpAIrvRA1j+XXi17uOtp/z5If2A3gZ6OKJUPVAUAzlRRNpeudvrB8cn6xYkhoU
 PSz/rcMSTccqrX/k7RssIJ+M0Q8XDcbTjNlYJQtM/GrpdyLlV5QBGHO59KeiZSenfP68
 UB7BglcehkVqVyyfeynCHnkOcnezF3BaG8THxF58SKAeLnTR2DJefOMuxOw9l3v8Saic
 HWtc/7kTef76fxEj5nS5xvLxpwxX2A0i4CiRTLlfXEOLAarUvf/Qrw7RTCgOAzXUpVGX
 3ANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784323219; x=1784928019;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LVO9oFcqHAfiXoC8yBmRh7SOK0Mm4H1Q9jwyseAbOfg=;
 b=GqmiI8xeVHUuFFxvxFVCfkNmqFBa3rals+qLvIEMPNFNa5gIdno26CVBrI+HvZ6QrN
 +ACoVCOnCL+BP9B24SVhvM4uj5QM8MDvQq+ql5V9B88YnYN4+kUp4J+vtVHqczESICIa
 Nm5tgcP69qyWZHV+oz5m8DwCSdUKl/0QAOPen+3W63rfQVpxwf347ADXdBUhvVTgAoC5
 b5rnlY03lATZuw0s64jtNOr2goe5K1lzhIN9pQc7EHX7hcytRz/IiqWTe4v5y7e+dECO
 uru0z2wLOCgnt6+rKeTbw666XbL8B4oT3SfyWMFOQfahwJBiw1N6kKlKML6IwVVyFV5Y
 /P+w==
X-Gm-Message-State: AOJu0Yw80ZRCvl4e15t4j6XeIacNVB6GUGp7MmhjTKyS5iSHg2E6fL01
 5jOOwD9Tr43i2UXgKZW5+zvxROyN5mYx3q9ydzX6UKpY8zXzQekLFbpno+9n4onxm2E5LRilKi8
 QHcVZ37YAFTdFhC9E4VKXmpG+ueR+tyk=
X-Gm-Gg: AfdE7cnPgkcFPc1QI9WfEJsxay9eHJ7NQk6Lcp3XGn9dWQKzOQXF/xi+lN2jxDWwcWv
 4fY8kXpn7aNZF+YJbkhnMFe24wKGsUGFZ4phIv/KwS5G48SUuLNbUIuyXTqF/ZdV7wVJ9htFU5i
 CdfaLIyiAN83iW+d6V05IOjm/UM6bI6KJgBHsJdH88DVTr7894/7LFjnJwW8d1sNFNsupoO65yJ
 iKt3L3RIaKWwjzSro43DVi4gukk2i5EW4m/fs94BHMnuYcNDK9VJE9CAlrrC9OQgzyuAxKfbk0c
 LsukyDwavtav26TRBkGtPRmy++obyScWrgNoomRyzavsRM8=
X-Received: by 2002:a05:620a:290e:b0:92e:ecbd:3445 with SMTP id
 af79cd13be357-930b41d057amr496262485a.48.1784323217761; Fri, 17 Jul 2026
 14:20:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260716153020.3171253-1-alexander.deucher@amd.com>
In-Reply-To: <20260716153020.3171253-1-alexander.deucher@amd.com>
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 18 Jul 2026 07:20:06 +1000
X-Gm-Features: AUfX_mynCTXnSZVwHW70F9swYp9kKUCZes0m8B3CGbf_52ZPwccd1uaV1RPjgaE
Message-ID: <CAPM=9tw3H_vuNJdNtMw+3=G8PXGydjxAEHHk9syG3cf7XYHx3Q@mail.gmail.com>
Subject: Re: [pull] amdgpu, amdkfd drm-fixes-7.2
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 simona.vetter@ffwll.ch
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

On Fri, 17 Jul 2026 at 01:30, Alex Deucher <alexander.deucher@amd.com> wrot=
e:
>
> Hi Dave, Simona,
>
> Fixes for 7.2.
>
> The following changes since commit a13c140cc289c0b7b3770bce5b3ad42ab35074=
aa:
>
>   Linux 7.2-rc3 (2026-07-12 14:16:39 -0700)

I pulled this then I jumped through hoops to unpull it.

Alex, there are missing signoffs on at least 4 commits in here from
you, it's probably not massively severe but I think it's good to make
sure it's done.

Dave.

>
> are available in the Git repository at:
>
>   https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-fixes-7.2-2=
026-07-16
>
> for you to fetch changes up to c9ab9622f5b2799fe624a4a134e60112149271dd:
>
>   Revert "drm/amd/display: Restore 5s vbl offdelay for NV3x+ DGPUs" (2026=
-07-15 09:55:55 -0400)
>
> ----------------------------------------------------------------
> amd-drm-fixes-7.2-2026-07-16:
>
> amdgpu:
> - DCN 4.2 fixes
> - NUTMEG fixes
> - 8K panel fix
> - Backlight fixes
> - UserQ fix
> - Fix bo->pin leaking in amdgpu_bo_create_reserved()
> - VFCT fixes
> - devcoredump fixes
> - Display fixes
> - SMU7 DPM fix
> - AC/DC fixes for SMU7 and SI
> - Queue reset fix
> - PCIe DPM fix
> - XHCI/GPU resume ordering fix
> - Pageflip timeout fix
>
> amdkfd:
> - Fix potential overflow in CWSR size calculation
> - DQM error clean up fixes
>
> ----------------------------------------------------------------
> Alessandro Rinaldi (1):
>       drm/amd/display: Force PWM backlight on Lenovo Legion 5 15ARH05
>
> Alex Deucher (1):
>       drm/amdgpu: always emit the job vm fence
>
> Andriy Korud (1):
>       drm/amd/display: dce100: skip non-DP stream encoders for DP MST
>
> Dmytro Laktyushkin (2):
>       drm/amd/display: fix dcn42 det allocation order
>       drm/amd/display: fix dcn42b det allocation order
>
> Fangzhi Zuo (1):
>       drm/amd/display: Fix 8K Mode Not Parsed by EDID
>
> Guangshuo Li (1):
>       drm/amdkfd: free MQD managers on DQM init failures
>
> Jesse Zhang (1):
>       drm/amdgpu/userq: fix indefinite fence wait during GPU reset
>
> Leo Li (3):
>       drm/amd/display: consolidate DCN vblank/flip handling onto vupdate_=
no_lock
>       drm/amd/display: check GRPH_FLIP status before sending event
>       Revert "drm/amd/display: Restore 5s vbl offdelay for NV3x+ DGPUs"
>
> Mario Limonciello (5):
>       drm/amd/display: Fix backlight max_brightness to match exported ran=
ge
>       drm/amdgpu: Fix VFCT bus number matching with soft filter
>       drm/amdgpu: Release VFCT ACPI table reference
>       drm/amdgpu: Disable PCIe dynamic speed switching on Ryzen Pinnacle =
Ridge
>       drm/amd: Create a device link between APU display and XHCI devices
>
> Matthew Stewart (1):
>       drm/amd/display: Fix DCN42B null registers & register masks
>
> Pengpeng Hou (1):
>       drm/amd/display: wire DCN42B mcache programming callback
>
> Roman Li (1):
>       drm/amdgpu/discovery: Fix device family for DCN42
>
> Timur Krist=C3=B3f (10):
>       drm/amd/display: Fix preferred link rate for NUTMEG
>       drm/amd/display: Add dp_skip_rbr flag for NUTMEG
>       drm/amdgpu: Print vmid, pasid and more task info in devcoredump
>       drm/amdgpu: Reserve space for IB contents in devcoredumps
>       drm/amd/pm/ci: Don't disable MCLK DPM on Bonaire 0x6658 (R7 260X)
>       drm/amd/display: Set native cursor mode for disabled CRTCs
>       drm/amd/pm/si: Don't schedule thermal work when queue isn't initial=
ized
>       drm/amd/pm/si: Fix AC/DC switch notification
>       drm/amd/pm/smu7: Fix AC/DC switch notification
>       drm/amdgpu/ttm: Consider concurrent VM flushes for buffer entities
>
> WenTao Liang (1):
>       drm/amd/display: set new_stream to NULL after release
>
> Yongqiang Sun (1):
>       drm/amdkfd: fix 32-bit overflow in CWSR total size calculation
>
> Zhu Lingshan (1):
>       drm/amdgpu: fix bo->pin leaking in amdgpu_bo_create_reserved
>
> yanglinlin (1):
>       drm/amd/display: fix __udivdi3 link error
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c           |  62 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c   |  10 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h   |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   9 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |   4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |  13 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |  20 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          |  21 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  10 +-
>  .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |   4 +
>  drivers/gpu/drm/amd/amdkfd/kfd_queue.c             |  23 +-
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 551 +++++++++++++--=
------
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |  70 +--
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |  20 +-
>  drivers/gpu/drm/amd/display/dc/core/dc.c           |  45 ++
>  drivers/gpu/drm/amd/display/dc/dc.h                |   3 +
>  .../gpu/drm/amd/display/dc/dce/dce_clock_source.c  |  11 +-
>  .../gpu/drm/amd/display/dc/link/link_detection.c   |   2 +-
>  .../display/dc/link/protocols/link_dp_capability.c |   6 +-
>  .../display/dc/resource/dce100/dce100_resource.c   |   7 +-
>  .../amd/display/dc/resource/dcn42/dcn42_resource.c |   1 +
>  .../display/dc/resource/dcn42b/dcn42b_resource.c   |  23 +-
>  .../display/dc/resource/dcn42b/dcn42b_resource.h   | 116 +----
>  drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c         |  17 +-
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c     |   7 +-
>  .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c    |  16 +-
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |  12 +
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h      |  12 +-
>  .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c   |  45 ++
>  drivers/gpu/drm/drm_panel_backlight_quirks.c       |   9 +
>  include/drm/drm_utils.h                            |   1 +
>  31 files changed, 720 insertions(+), 431 deletions(-)
