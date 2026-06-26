Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32792C43458
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2026 17:10:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B432F10E3C1;
	Fri, 26 Jun 2026 17:10:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gFmdnczg";
	dkim-atps=neutral
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B72010E3C1
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2026 17:10:33 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-c07fcdd75d3so148274066b.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2026 10:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782493832; x=1783098632; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yOtaqERZkl+Ma6mTUJkmNPjVZoEmXMlvwvfsAcxXKys=;
 b=gFmdnczgD3PFYH5RBHaBsUTNBzj7SoaQrHLSO6xoRDV3v22VY2fDh7Y4BCgAC3OpDg
 aWGHP37Ma177XCTumNPceT4Siv28xcSWAEHEG6cBsQX+HMrJKVFU1b2Weh7aLr6XpAg2
 aciJc6RtSY5aV4Df7lTAJBKnZnpXGZJyxssnd1bBwWUjdvDI2DtMRp2iFqrTVODiOQY6
 IoKlqA40OLFbeGeJVmSzzvTfFilr8Qf+kXZov66QBg4bsS48BkDVQ10R1i48QuE2h4DN
 ApGtDLtPxvXENGblo5vFoSZ8N0wW9LcQ6TI5p0WqoTrJVvqnP53wzAnXl21ibquRwzaS
 b3yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782493832; x=1783098632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yOtaqERZkl+Ma6mTUJkmNPjVZoEmXMlvwvfsAcxXKys=;
 b=ZFCO75bEAXHL+AVtLIQq8wgNPIaZvciobHno83yh5rzlhgzDuFn6CFrnN2MZuyVEYz
 cgJgeXFxuBqt+USBCjEKNflZnNPhU77MC3JbWkJ1kHeyFpEXhLgX9pXEc4VRvfNuxuip
 J+e7VHkHrSnCc3WJqREwUV+tlmPcyOVwQhaiZF4+aspiPDiquBlTdZsyO+81sdXfC6Xw
 RD7whd85ChH9cVWOQ2neXoJkFaD34wUp0038zqUSF/iypN7zUYX8vmJ5ezul6i9MVzRf
 UFlurviHRK0L/tn6GCZBGIw8eBefEDNIEaXgbhPuOJt8Cr3lCLwRqIssnvk5W9D+wuMx
 mk2A==
X-Gm-Message-State: AOJu0YxknqQzZ61hWksvqFLDxe5UtC4+N3uJ2l3nBKU1G+g3JB/aJwn9
 XYbgwmQCxa5LLWMsIdxyF6Ae7kIclKPRWEUtyCxIRk+GVW3IjPJH4w4zHaD1ag==
X-Gm-Gg: AfdE7cnMcqYESLICXL237xbaugsxImpSuozRtDvPKxFkjs6GPYGvKyXWXSXpujHceZx
 IgOJl/VquQCknsI42ybmQ2tL82Y+G1upvfXsVBxkGMjfIyHl63YpdLwTMYAVrH3u1qvNd1OH5gD
 Cjd3k2TqIaXFxSAbDTKXpzFD+yQWI4jrCafgfcsB5ZfR0NPrnO+15txg+FXunWkRLA3NaB59lpV
 hFGOhOSmg/p91NRWa9Bzt4SATOP4Bis0CImIF03n16aUEE9fxD2GzSxCBtGNU2f7POkHlue7Mde
 +1/pK6Gr9Lm11YJZI0ODbMATaFKRHr2uCHpkyXtkfMzI6vIqS5hsNAkqDzNmz7ISoKV1FnbnVCe
 BDMKb7f07nxXa4ylbHsatsZWu9HlEqL8lzCoJB+6g1LYebXK1IinQPxvMUJna1u0NnYfJvftVyH
 xSOzSCjPlvPsMKupxpRprshymi+Vp6Ow==
X-Received: by 2002:a17:907:3f8c:b0:c12:1c9a:48a3 with SMTP id
 a640c23a62f3a-c121c9a607cmr371324366b.22.1782493831615; 
 Fri, 26 Jun 2026 10:10:31 -0700 (PDT)
Received: from timur-max.localnet ([2a0a:f640:1701:30c:61f9:a53e:4a65:c732])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c121bdad2f0sm165967166b.33.2026.06.26.10.10.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 10:10:31 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: [PATCH 2/3] drm/amdgpu: Save some cycles on the job submission
 path
Date: Fri, 26 Jun 2026 19:10:29 +0200
Message-ID: <3694635.dWV9SEqChM@timur-max>
In-Reply-To: <20260626085558.97923-3-tvrtko.ursulin@igalia.com>
References: <20260626085558.97923-1-tvrtko.ursulin@igalia.com>
 <20260626085558.97923-3-tvrtko.ursulin@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On 2026. j=C3=BAnius 26., p=C3=A9ntek 10:55:57 k=C3=B6z=C3=A9p-eur=C3=B3pai=
 ny=C3=A1ri id=C5=91 Tvrtko Ursulin=20
wrote:
> Every job submission on the Steam Deck ends up walking the list of IP
> blocks looking for AMD_IP_BLOCK_TYPE_SMC. Half of the call chain is like
> the below, while the second half is from amdgpu_gfx_profile_ring_end_use:
>=20
>  amdgpu_gfx_profile_ring_begin_use
>   amdgpu_dpm_is_overdrive_enabled
>    is_support_sw_smu
>     amdgpu_device_ip_is_valid
>=20
> On a game menu screen at 90Hz refresh rate we end up with ~840 calls per
> second which sticks out when the submission worker is profiled with perf:
>=20
>   13.78%  [kernel]  [k] __lock_text_start
>   10.86%  [kernel]  [k] __lookup_object
>    8.76%  [kernel]  [k] __mod_timer
>    4.94%  [kernel]  [k] queued_spin_lock_slowpath
>    1.66%  [kernel]  [k] amdgpu_device_ip_is_valid
>    1.54%  [kernel]  [k] preempt_count_add
>    1.42%  [kernel]  [k] amdgpu_sync_peek_fence
>    1.18%  [kernel]  [k] amdgpu_vmid_grab
>    1.17%  [kernel]  [k] amdgpu_ib_schedule
>    1.14%  [kernel]  [k] kthread_worker_fn
>=20
> Lets short-circuit this walk by simply caching the result of
> is_support_sw_smu() in the device.
>=20
> This is a micro-improvement but it is at least conceptually nicer to avoid
> repeating the same walk so much.

Hi,

I agree with cleaning up this thing.
Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

That being said, I think is_support_sw_smu() is horrible and should be remo=
ved=20
alltogether, because it goes against how the rest of the power management c=
ode=20
works.

In my opinion, we should instead:

1. Hook up some function pointers and check those instead,
=46or example in amdgpu_pm_acpi_event_handler() we should just hook up=20
smu_set_ac_dc() to the notify_ac_dc() function pointer. There are plenty of=
=20
other similar cases.
Another example, for amdgpu_dpm_mode1_reset() we should introduce a new=20
asic_reset_mode_1() pointer in amd_pm_funcs() similar to how it works with=
=20
MODE2 reset for consistency.

2. Eliminate redundant functions where the same thing is already done=20
elsewhere.
=46or example in amdgpu_dpm_is_mode1_reset_supported() it checks=20
smu_mode1_reset_is_support() which is redundant because the supported reset=
=20
type is available on the ASIC functions already and we can just use that.

What do you think?

Thanks & best regards,
Timur

>=20
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> ---
> v2:
>  * Approach changed to cache sw_smu status only.
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  3 +++
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 14 +++++---------
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  8 +++++++-
>  4 files changed, 16 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h index 7b09410d6d8f..9803967d15f9
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -851,6 +851,7 @@ struct amdgpu_device {
>  	struct dev_pm_domain		vga_pm_domain;
>  	bool				have_disp_power_ref;
>  	bool                            have_atomics_support;
> +	bool				is_sw_smu;
>=20
>  	/* BIOS */
>  	bool				is_atom_fw;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c index
> 1e6b75ecafe4..7f935a5778b0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -74,6 +74,7 @@
>  #include "amdgpu_ras.h"
>  #include "amdgpu_ras_mgr.h"
>  #include "amdgpu_pmu.h"
> +#include "amdgpu_smu.h"
>  #include "amdgpu_fru_eeprom.h"
>  #include "amdgpu_reset.h"
>  #include "amdgpu_virt.h"
> @@ -2130,6 +2131,8 @@ static int amdgpu_device_ip_early_init(struct
> amdgpu_device *adev) adev->cg_flags &=3D amdgpu_cg_mask;
>  	adev->pg_flags &=3D amdgpu_pg_mask;
>=20
> +	amdgpu_smu_early_init(adev);
> +
>  	return 0;
>  }
>=20
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c index
> 208a2fba6d40..82c9ae6a5092 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -591,17 +591,13 @@ static int smu_get_power_num_states(void *handle,
>  	return 0;
>  }
>=20
> -bool is_support_sw_smu(struct amdgpu_device *adev)
> +void amdgpu_smu_early_init(struct amdgpu_device *adev)
>  {
>  	/* vega20 is 11.0.2, but it's supported via the powerplay code */
> -	if (adev->asic_type =3D=3D CHIP_VEGA20)
> -		return false;
> -
> -	if ((amdgpu_ip_version(adev, MP1_HWIP, 0) >=3D IP_VERSION(11, 0, 0))=20
&&
> -	    amdgpu_device_ip_is_valid(adev, AMD_IP_BLOCK_TYPE_SMC))
> -		return true;
> -
> -	return false;
> +	adev->is_sw_smu =3D adev->asic_type !=3D CHIP_VEGA20 &&
> +			  (amdgpu_ip_version(adev, MP1_HWIP, 0) >=3D
> +			   IP_VERSION(11, 0, 0) &&
> +			   amdgpu_device_ip_is_valid(adev,=20
AMD_IP_BLOCK_TYPE_SMC));
>  }
>=20
>  bool is_support_cclk_dpm(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h index
> d76e0b005308..efc52d97058b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -1952,7 +1952,13 @@ int smu_link_reset(struct smu_context *smu);
>=20
>  extern const struct amd_ip_funcs smu_ip_funcs;
>=20
> -bool is_support_sw_smu(struct amdgpu_device *adev);
> +void amdgpu_smu_early_init(struct amdgpu_device *adev);
> +
> +static inline bool is_support_sw_smu(struct amdgpu_device *adev)
> +{
> +	return adev->is_sw_smu;
> +}
> +
>  bool is_support_cclk_dpm(struct amdgpu_device *adev);
>  int smu_write_watermarks_table(struct smu_context *smu);




