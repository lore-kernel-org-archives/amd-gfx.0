Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F40D3E2BC
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2024 19:33:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DE5910E53B;
	Mon, 28 Oct 2024 19:33:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D4BrZeOW";
	dkim-atps=neutral
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA96D10E53B
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 19:33:13 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-7ea6f99e6eeso300465a12.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 12:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730143993; x=1730748793; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IqdtjyIsXgdpHblltn+bOO9EvvLpRX95hVIBe7TrVig=;
 b=D4BrZeOWzcHtS0tGR4B5DLiQCVDPtIyMqlLMoFFXQZ8HSItqBwrQTtzu9QcFu4Orf6
 dBbQydiCKMhNu2NfSzFvDhh9/xSll2v0sjQM6s3Zx/pgL7IjKgBnZwRGZ58K81zWV4u1
 Kb0nZFYqBkwilJmM+dVTem3ubk5HXPZSw8rb/IeNZO32P0JDNQo+qEIhbUfqlK0z2jSf
 M8CkTwjybmLRLpNMqg53m6lLgSW+MvGAUqcOxup78VNJmkiv/HEPDiygaMi+D4hOrnd+
 g+XAaSbRefOYM/bpo8v5wkGhFDLbNHArLxngy7zf4ctKKhVkext329l4+bxXea2I5RtW
 ggHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730143993; x=1730748793;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IqdtjyIsXgdpHblltn+bOO9EvvLpRX95hVIBe7TrVig=;
 b=ZRjUSI83DDFutrzv9Vw4CTwJAUVrimi6DPTf7A6QAUHAcGCilfJcLYODcXpnpe/rcp
 +Lv3ERSAyR6xuTGic4fyGbQar9dQp4IMv8ceqaNGre1cjCV2FyLzf/w/GlEzAXFXxNtd
 P3vltAz1Kn3EfE3tS5POe849Q5x+aDqNrs/Q4BxtUFOHg3T6lClfy4liNP2icNVx6CdM
 QngYGI+uruO7uSFk+4rTqh3VfCfV3+JBpGwwR/A2+SryTmbcNMgXn+xDAfOehNXWci8B
 /sWVc2gnppKp9MfbdNqyW6TWKCoOJ2jIW4CD+jQuBz63BrGzWZtg7ry/g6RhptaawJmM
 Pn3g==
X-Gm-Message-State: AOJu0YzcO/rCGxcTupBnP33cV9/eqwyYmpNuPuwIf1PzC8R25NFf7GlJ
 pxucH5pfp4AtctjLP9uODKBW7pvVUzp5svLoLu+AvgR7KtAtcAEaqt0dUB7w9fojl/XBlFXYPcH
 Bu1zDKkQhOyFEvnGlUDxlf6K/Xllevm0H
X-Google-Smtp-Source: AGHT+IEGsgi/mjvE7n83/OaO8uA2OB/bcmpqdDJcwSc56EFf5dihDQkjEZL6Op/Ai0JeWXj7gI6pdBm2Z2xhHFlkjpQ=
X-Received: by 2002:a05:6a20:3946:b0:1cf:52ac:4ec9 with SMTP id
 adf61e73a8af0-1d9a84dd505mr6154527637.8.1730143993036; Mon, 28 Oct 2024
 12:33:13 -0700 (PDT)
MIME-Version: 1.0
References: <20241025023545.465886-1-boyuan.zhang@amd.com>
 <20241025023545.465886-20-boyuan.zhang@amd.com>
In-Reply-To: <20241025023545.465886-20-boyuan.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Oct 2024 15:33:01 -0400
Message-ID: <CADnq5_NKuhfUDth3CbxV0oTrw6g9h3Yi4xLuo9Bk=HkcTgeLNg@mail.gmail.com>
Subject: Re: [PATCH 19/29] drm/amdgpu: set powergating state by vcn instance
To: boyuan.zhang@amd.com
Cc: amd-gfx@lists.freedesktop.org, leo.liu@amd.com, christian.koenig@amd.com, 
 alexander.deucher@amd.com, sunil.khatri@amd.com
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

On Thu, Oct 24, 2024 at 11:33=E2=80=AFPM <boyuan.zhang@amd.com> wrote:
>
> From: Boyuan Zhang <boyuan.zhang@amd.com>
>
> Set powergating state by vcn instance in idle_work_handler() and
> ring_begin_use() functions for vcn with multiple instances.
>
> v2: Add instance parameter to amdgpu_device_ip_set_powergating_state(),
> instead of creating new function.
>
> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h                  |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c           |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c             |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c              |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c              |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c              | 10 ++++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c              |  8 ++++----
>  drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c                |  2 +-
>  drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c                |  2 +-
>  drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c                |  2 +-
>  drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c                |  2 +-
>  drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c                |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vce_v2_0.c                |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vce_v3_0.c                |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vce_v4_0.c                |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c                |  4 ++--
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c                  |  6 ++++--
>  drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c           |  8 ++++----
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c |  6 ++++--
>  .../amd/pm/powerplay/hwmgr/smu7_clockpowergating.c   | 12 ++++++++----
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c  | 12 ++++++++----
>  .../gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c    |  6 ++++--
>  22 files changed, 65 insertions(+), 44 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 2e2c6a556cc8..03ae6f614969 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -357,7 +357,8 @@ int amdgpu_device_ip_set_clockgating_state(void *dev,
>                                            enum amd_clockgating_state sta=
te);
>  int amdgpu_device_ip_set_powergating_state(void *dev,
>                                            enum amd_ip_block_type block_t=
ype,
> -                                          enum amd_powergating_state sta=
te);
> +                                          enum amd_powergating_state sta=
te,
> +                                          int inst);
>  void amdgpu_device_ip_get_clockgating_state(struct amdgpu_device *adev,
>                                             u64 *flags);
>  int amdgpu_device_ip_wait_for_idle(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 065463b5d6a9..7a44ceeb7ec9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2177,7 +2177,8 @@ int amdgpu_device_ip_set_clockgating_state(void *de=
v,
>   */
>  int amdgpu_device_ip_set_powergating_state(void *dev,
>                                            enum amd_ip_block_type block_t=
ype,
> -                                          enum amd_powergating_state sta=
te)
> +                                          enum amd_powergating_state sta=
te,
> +                                          int inst)
>  {
>         struct amdgpu_device *adev =3D dev;
>         int i, r =3D 0;
> @@ -2187,6 +2188,9 @@ int amdgpu_device_ip_set_powergating_state(void *de=
v,
>                         continue;
>                 if (adev->ip_blocks[i].version->type !=3D block_type)
>                         continue;
> +               if (block_type =3D=3D AMD_IP_BLOCK_TYPE_VCN &&
> +                               adev->ip_blocks[i].instance !=3D inst)
> +                       continue;
>                 if (!adev->ip_blocks[i].version->funcs->set_powergating_s=
tate)
>                         continue;
>                 r =3D adev->ip_blocks[i].version->funcs->set_powergating_=
state(
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_jpeg.c
> index 95e2796919fc..78fd1ff28a57 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> @@ -119,7 +119,7 @@ static void amdgpu_jpeg_idle_work_handler(struct work=
_struct *work)
>
>         if (!fences && !atomic_read(&adev->jpeg.total_submission_cnt))
>                 amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK=
_TYPE_JPEG,
> -                                                      AMD_PG_STATE_GATE)=
;
> +                                                      AMD_PG_STATE_GATE,=
 0);
>         else
>                 schedule_delayed_work(&adev->jpeg.idle_work, JPEG_IDLE_TI=
MEOUT);
>  }
> @@ -133,7 +133,7 @@ void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring *r=
ing)
>
>         mutex_lock(&adev->jpeg.jpeg_pg_lock);
>         amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_JP=
EG,
> -                                                      AMD_PG_STATE_UNGAT=
E);
> +                                                      AMD_PG_STATE_UNGAT=
E, 0);
>         mutex_unlock(&adev->jpeg.jpeg_pg_lock);
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_uvd.c
> index 31fd30dcd593..09844953a1fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -1277,7 +1277,7 @@ static void amdgpu_uvd_idle_work_handler(struct wor=
k_struct *work)
>                         amdgpu_asic_set_uvd_clocks(adev, 0, 0);
>                         /* shutdown the UVD block */
>                         amdgpu_device_ip_set_powergating_state(adev, AMD_=
IP_BLOCK_TYPE_UVD,
> -                                                              AMD_PG_STA=
TE_GATE);
> +                                                              AMD_PG_STA=
TE_GATE, 0);
>                         amdgpu_device_ip_set_clockgating_state(adev, AMD_=
IP_BLOCK_TYPE_UVD,
>                                                                AMD_CG_STA=
TE_GATE);
>                 }
> @@ -1303,7 +1303,7 @@ void amdgpu_uvd_ring_begin_use(struct amdgpu_ring *=
ring)
>                         amdgpu_device_ip_set_clockgating_state(adev, AMD_=
IP_BLOCK_TYPE_UVD,
>                                                                AMD_CG_STA=
TE_UNGATE);
>                         amdgpu_device_ip_set_powergating_state(adev, AMD_=
IP_BLOCK_TYPE_UVD,
> -                                                              AMD_PG_STA=
TE_UNGATE);
> +                                                              AMD_PG_STA=
TE_UNGATE, 0);
>                 }
>         }
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vce.c
> index 74fdbf71d95b..a061fb8a2fcf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -344,7 +344,7 @@ static void amdgpu_vce_idle_work_handler(struct work_=
struct *work)
>                 } else {
>                         amdgpu_asic_set_vce_clocks(adev, 0, 0);
>                         amdgpu_device_ip_set_powergating_state(adev, AMD_=
IP_BLOCK_TYPE_VCE,
> -                                                              AMD_PG_STA=
TE_GATE);
> +                                                              AMD_PG_STA=
TE_GATE, 0);
>                         amdgpu_device_ip_set_clockgating_state(adev, AMD_=
IP_BLOCK_TYPE_VCE,
>                                                                AMD_CG_STA=
TE_GATE);
>                 }
> @@ -378,7 +378,7 @@ void amdgpu_vce_ring_begin_use(struct amdgpu_ring *ri=
ng)
>                         amdgpu_device_ip_set_clockgating_state(adev, AMD_=
IP_BLOCK_TYPE_VCE,
>                                                                AMD_CG_STA=
TE_UNGATE);
>                         amdgpu_device_ip_set_powergating_state(adev, AMD_=
IP_BLOCK_TYPE_VCE,
> -                                                              AMD_PG_STA=
TE_UNGATE);
> +                                                              AMD_PG_STA=
TE_UNGATE, 0);
>
>                 }
>         }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vcn.c
> index 3d2d2a0d98c8..efd6c9eb3502 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -416,8 +416,9 @@ static void amdgpu_vcn_idle_work_handler(struct work_=
struct *work)
>         fence +=3D amdgpu_fence_count_emitted(&adev->vcn.inst[inst].ring_=
dec);
>
>         if (!fence && !atomic_read(&adev->vcn.total_submission_cnt)) {
> -               amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK=
_TYPE_VCN,
> -                      AMD_PG_STATE_GATE);
> +               amdgpu_device_ip_set_powergating_state(adev,
> +                       AMD_IP_BLOCK_TYPE_VCN, AMD_PG_STATE_GATE, inst);
> +
>                 r =3D amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_=
PROFILE_VIDEO,
>                                                                          =
               false);
>                 if (r)
> @@ -442,8 +443,9 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ri=
ng)
>         }
>
>         mutex_lock(&adev->vcn.vcn_pg_lock);
> -       amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VC=
N,
> -              AMD_PG_STATE_UNGATE);
> +
> +       amdgpu_device_ip_set_powergating_state(adev,
> +               AMD_IP_BLOCK_TYPE_VCN, AMD_PG_STATE_UNGATE, ring->me);
>
>         /* Only set DPG pause for VCN3 or below, VCN4 and above will be h=
andled by FW */
>         if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vpe.c
> index 0a884215f59b..cbc0347a8d95 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> @@ -330,7 +330,7 @@ static void vpe_idle_work_handler(struct work_struct =
*work)
>         fences +=3D amdgpu_fence_count_emitted(&adev->vpe.ring);
>
>         if (fences =3D=3D 0)
> -               amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK=
_TYPE_VPE, AMD_PG_STATE_GATE);
> +               amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK=
_TYPE_VPE, AMD_PG_STATE_GATE, 0);
>         else
>                 schedule_delayed_work(&adev->vpe.idle_work, VPE_IDLE_TIME=
OUT);
>  }
> @@ -406,7 +406,7 @@ static int vpe_hw_init(struct amdgpu_ip_block *ip_blo=
ck)
>
>         /* Power on VPE */
>         ret =3D amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK=
_TYPE_VPE,
> -                                                    AMD_PG_STATE_UNGATE)=
;
> +                                                    AMD_PG_STATE_UNGATE,=
 0);
>         if (ret)
>                 return ret;
>
> @@ -429,7 +429,7 @@ static int vpe_hw_fini(struct amdgpu_ip_block *ip_blo=
ck)
>         vpe_ring_stop(vpe);
>
>         /* Power off VPE */
> -       amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VP=
E, AMD_PG_STATE_GATE);
> +       amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VP=
E, AMD_PG_STATE_GATE, 0);
>
>         return 0;
>  }
> @@ -845,7 +845,7 @@ static void vpe_ring_begin_use(struct amdgpu_ring *ri=
ng)
>                 uint32_t context_notify;
>
>                 /* Power on VPE */
> -               amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK=
_TYPE_VPE, AMD_PG_STATE_UNGATE);
> +               amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK=
_TYPE_VPE, AMD_PG_STATE_UNGATE, 0);
>
>                 /* Indicates that a job from a new context has been submi=
tted. */
>                 context_notify =3D RREG32(vpe_get_reg_offset(vpe, 0, vpe-=
>regs.context_indicator));
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/=
amdgpu/uvd_v3_1.c
> index 5830e799c0a3..0986f7a83401 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> @@ -735,7 +735,7 @@ static int uvd_v3_1_suspend(struct amdgpu_ip_block *i=
p_block)
>                 amdgpu_asic_set_uvd_clocks(adev, 0, 0);
>                 /* shutdown the UVD block */
>                 amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK=
_TYPE_UVD,
> -                                                      AMD_PG_STATE_GATE)=
;
> +                                                      AMD_PG_STATE_GATE,=
 0);
>                 amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK=
_TYPE_UVD,
>                                                        AMD_CG_STATE_GATE)=
;
>         }
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/=
amdgpu/uvd_v4_2.c
> index f93079e09215..565632478c3e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> @@ -249,7 +249,7 @@ static int uvd_v4_2_suspend(struct amdgpu_ip_block *i=
p_block)
>                 amdgpu_asic_set_uvd_clocks(adev, 0, 0);
>                 /* shutdown the UVD block */
>                 amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK=
_TYPE_UVD,
> -                                                      AMD_PG_STATE_GATE)=
;
> +                                                      AMD_PG_STATE_GATE,=
 0);
>                 amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK=
_TYPE_UVD,
>                                                        AMD_CG_STATE_GATE)=
;
>         }
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/=
amdgpu/uvd_v5_0.c
> index 050a0f309390..ce7f205899f2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> @@ -247,7 +247,7 @@ static int uvd_v5_0_suspend(struct amdgpu_ip_block *i=
p_block)
>                 amdgpu_asic_set_uvd_clocks(adev, 0, 0);
>                 /* shutdown the UVD block */
>                 amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK=
_TYPE_UVD,
> -                                                      AMD_PG_STATE_GATE)=
;
> +                                                      AMD_PG_STATE_GATE,=
 0);
>                 amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK=
_TYPE_UVD,
>                                                        AMD_CG_STATE_GATE)=
;
>         }
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/uvd_v6_0.c
> index d9d036ee51fb..ccf8dde8cd71 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> @@ -571,7 +571,7 @@ static int uvd_v6_0_suspend(struct amdgpu_ip_block *i=
p_block)
>                 amdgpu_asic_set_uvd_clocks(adev, 0, 0);
>                 /* shutdown the UVD block */
>                 amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK=
_TYPE_UVD,
> -                                                      AMD_PG_STATE_GATE)=
;
> +                                                      AMD_PG_STATE_GATE,=
 0);
>                 amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK=
_TYPE_UVD,
>                                                        AMD_CG_STATE_GATE)=
;
>         }
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/=
amdgpu/uvd_v7_0.c
> index 53249d4ff8ec..c93eb5122bd1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> @@ -639,7 +639,7 @@ static int uvd_v7_0_suspend(struct amdgpu_ip_block *i=
p_block)
>                 amdgpu_asic_set_uvd_clocks(adev, 0, 0);
>                 /* shutdown the UVD block */
>                 amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK=
_TYPE_UVD,
> -                                                      AMD_PG_STATE_GATE)=
;
> +                                                      AMD_PG_STATE_GATE,=
 0);
>                 amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK=
_TYPE_UVD,
>                                                        AMD_CG_STATE_GATE)=
;
>         }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/=
amdgpu/vce_v2_0.c
> index c633b7ff2943..4b4d295802a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> @@ -512,7 +512,7 @@ static int vce_v2_0_suspend(struct amdgpu_ip_block *i=
p_block)
>         } else {
>                 amdgpu_asic_set_vce_clocks(adev, 0, 0);
>                 amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK=
_TYPE_VCE,
> -                                                      AMD_PG_STATE_GATE)=
;
> +                                                      AMD_PG_STATE_GATE,=
 0);
>                 amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK=
_TYPE_VCE,
>                                                        AMD_CG_STATE_GATE)=
;
>         }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/=
amdgpu/vce_v3_0.c
> index f8bddcd19b68..fc7d80c2a841 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> @@ -523,7 +523,7 @@ static int vce_v3_0_suspend(struct amdgpu_ip_block *i=
p_block)
>         } else {
>                 amdgpu_asic_set_vce_clocks(adev, 0, 0);
>                 amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK=
_TYPE_VCE,
> -                                                      AMD_PG_STATE_GATE)=
;
> +                                                      AMD_PG_STATE_GATE,=
 0);
>                 amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK=
_TYPE_VCE,
>                                                        AMD_CG_STATE_GATE)=
;
>         }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/=
amdgpu/vce_v4_0.c
> index 335bda64ff5b..e7b6f8cc8b74 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> @@ -589,7 +589,7 @@ static int vce_v4_0_suspend(struct amdgpu_ip_block *i=
p_block)
>         } else {
>                 amdgpu_asic_set_vce_clocks(adev, 0, 0);
>                 amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK=
_TYPE_VCE,
> -                                                      AMD_PG_STATE_GATE)=
;
> +                                                      AMD_PG_STATE_GATE,=
 0);
>                 amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK=
_TYPE_VCE,
>                                                        AMD_CG_STATE_GATE)=
;
>         }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v1_0.c
> index f07a5a8393c0..8b860db34584 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -1861,7 +1861,7 @@ static void vcn_v1_0_idle_work_handler(struct work_=
struct *work)
>                         amdgpu_dpm_enable_vcn(adev, false, 0);
>                 else
>                         amdgpu_device_ip_set_powergating_state(adev, AMD_=
IP_BLOCK_TYPE_VCN,
> -                              AMD_PG_STATE_GATE);
> +                              AMD_PG_STATE_GATE, 0);
>         } else {
>                 schedule_delayed_work(&adev->vcn.inst[0].idle_work, VCN_I=
DLE_TIMEOUT);
>         }
> @@ -1891,7 +1891,7 @@ void vcn_v1_0_set_pg_for_begin_use(struct amdgpu_ri=
ng *ring, bool set_clocks)
>                         amdgpu_dpm_enable_vcn(adev, true, 0);
>                 else
>                         amdgpu_device_ip_set_powergating_state(adev, AMD_=
IP_BLOCK_TYPE_VCN,
> -                              AMD_PG_STATE_UNGATE);
> +                              AMD_PG_STATE_UNGATE, 0);
>         }
>
>         if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm=
/amdgpu_dpm.c
> index 5a9006bfc3cd..d4c264814b61 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -1026,7 +1026,8 @@ int amdgpu_dpm_force_performance_level(struct amdgp=
u_device *adev,
>                 /* enter UMD Pstate */
>                 amdgpu_device_ip_set_powergating_state(adev,
>                                                        AMD_IP_BLOCK_TYPE_=
GFX,
> -                                                      AMD_PG_STATE_UNGAT=
E);
> +                                                      AMD_PG_STATE_UNGAT=
E,
> +                                                      0);
>                 amdgpu_device_ip_set_clockgating_state(adev,
>                                                        AMD_IP_BLOCK_TYPE_=
GFX,
>                                                        AMD_CG_STATE_UNGAT=
E);
> @@ -1038,7 +1039,8 @@ int amdgpu_dpm_force_performance_level(struct amdgp=
u_device *adev,
>                                                        AMD_CG_STATE_GATE)=
;
>                 amdgpu_device_ip_set_powergating_state(adev,
>                                                        AMD_IP_BLOCK_TYPE_=
GFX,
> -                                                      AMD_PG_STATE_GATE)=
;
> +                                                      AMD_PG_STATE_GATE,
> +                                                      0);
>         }
>
>         mutex_lock(&adev->pm.mutex);
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm=
/amd/pm/legacy-dpm/kv_dpm.c
> index 67a8e22b1126..e54be4b386f2 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> @@ -1675,7 +1675,7 @@ static void kv_dpm_powergate_uvd(void *handle, bool=
 gate)
>         if (gate) {
>                 /* stop the UVD block */
>                 amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK=
_TYPE_UVD,
> -                                                      AMD_PG_STATE_GATE)=
;
> +                                                      AMD_PG_STATE_GATE,=
 0);
>                 kv_update_uvd_dpm(adev, gate);
>                 if (pi->caps_uvd_pg)
>                         /* power off the UVD block */
> @@ -1688,7 +1688,7 @@ static void kv_dpm_powergate_uvd(void *handle, bool=
 gate)
>                 kv_update_uvd_dpm(adev, gate);
>
>                 amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK=
_TYPE_UVD,
> -                                                      AMD_PG_STATE_UNGAT=
E);
> +                                                      AMD_PG_STATE_UNGAT=
E, 0);
>         }
>  }
>
> @@ -1702,7 +1702,7 @@ static void kv_dpm_powergate_vce(void *handle, bool=
 gate)
>         if (gate) {
>                 /* stop the VCE block */
>                 amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK=
_TYPE_VCE,
> -                                                      AMD_PG_STATE_GATE)=
;
> +                                                      AMD_PG_STATE_GATE,=
 0);
>                 kv_enable_vce_dpm(adev, false);
>                 if (pi->caps_vce_pg) /* power off the VCE block */
>                         amdgpu_kv_notify_message_to_smu(adev, PPSMC_MSG_V=
CEPowerOFF);
> @@ -1712,7 +1712,7 @@ static void kv_dpm_powergate_vce(void *handle, bool=
 gate)
>                 kv_enable_vce_dpm(adev, true);
>                 /* re-init the VCE block */
>                 amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK=
_TYPE_VCE,
> -                                                      AMD_PG_STATE_UNGAT=
E);
> +                                                      AMD_PG_STATE_UNGAT=
E, 0);
>         }
>  }
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drive=
rs/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> index a8c732e07006..41dbf043f59b 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> @@ -1407,7 +1407,8 @@ static void smu10_powergate_vcn(struct pp_hwmgr *hw=
mgr, bool bgate)
>         if (bgate) {
>                 amdgpu_device_ip_set_powergating_state(hwmgr->adev,
>                                                 AMD_IP_BLOCK_TYPE_VCN,
> -                                               AMD_PG_STATE_GATE);
> +                                               AMD_PG_STATE_GATE,
> +                                               0);
>                 smum_send_msg_to_smc_with_parameter(hwmgr,
>                                         PPSMC_MSG_PowerDownVcn, 0, NULL);
>                 smu10_data->vcn_power_gated =3D true;
> @@ -1416,7 +1417,8 @@ static void smu10_powergate_vcn(struct pp_hwmgr *hw=
mgr, bool bgate)
>                                                 PPSMC_MSG_PowerUpVcn, 0, =
NULL);
>                 amdgpu_device_ip_set_powergating_state(hwmgr->adev,
>                                                 AMD_IP_BLOCK_TYPE_VCN,
> -                                               AMD_PG_STATE_UNGATE);
> +                                               AMD_PG_STATE_UNGATE,
> +                                               0);
>                 smu10_data->vcn_power_gated =3D false;
>         }
>  }
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating=
.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.c
> index f2bda3bcbbde..b496b77153e9 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.c
> @@ -120,7 +120,8 @@ void smu7_powergate_uvd(struct pp_hwmgr *hwmgr, bool =
bgate)
>         if (bgate) {
>                 amdgpu_device_ip_set_powergating_state(hwmgr->adev,
>                                                 AMD_IP_BLOCK_TYPE_UVD,
> -                                               AMD_PG_STATE_GATE);
> +                                               AMD_PG_STATE_GATE,
> +                                               0);
>                 amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
>                                 AMD_IP_BLOCK_TYPE_UVD,
>                                 AMD_CG_STATE_GATE);
> @@ -133,7 +134,8 @@ void smu7_powergate_uvd(struct pp_hwmgr *hwmgr, bool =
bgate)
>                                 AMD_CG_STATE_UNGATE);
>                 amdgpu_device_ip_set_powergating_state(hwmgr->adev,
>                                                 AMD_IP_BLOCK_TYPE_UVD,
> -                                               AMD_PG_STATE_UNGATE);
> +                                               AMD_PG_STATE_UNGATE,
> +                                               0);
>                 smu7_update_uvd_dpm(hwmgr, false);
>         }
>
> @@ -148,7 +150,8 @@ void smu7_powergate_vce(struct pp_hwmgr *hwmgr, bool =
bgate)
>         if (bgate) {
>                 amdgpu_device_ip_set_powergating_state(hwmgr->adev,
>                                                 AMD_IP_BLOCK_TYPE_VCE,
> -                                               AMD_PG_STATE_GATE);
> +                                               AMD_PG_STATE_GATE,
> +                                               0);
>                 amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
>                                 AMD_IP_BLOCK_TYPE_VCE,
>                                 AMD_CG_STATE_GATE);
> @@ -161,7 +164,8 @@ void smu7_powergate_vce(struct pp_hwmgr *hwmgr, bool =
bgate)
>                                 AMD_CG_STATE_UNGATE);
>                 amdgpu_device_ip_set_powergating_state(hwmgr->adev,
>                                                 AMD_IP_BLOCK_TYPE_VCE,
> -                                               AMD_PG_STATE_UNGATE);
> +                                               AMD_PG_STATE_UNGATE,
> +                                               0);
>                 smu7_update_vce_dpm(hwmgr, false);
>         }
>  }
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c b/driver=
s/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
> index 7e1197420873..2ccce2bc3b4a 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
> @@ -1985,7 +1985,8 @@ static void smu8_dpm_powergate_uvd(struct pp_hwmgr =
*hwmgr, bool bgate)
>         if (bgate) {
>                 amdgpu_device_ip_set_powergating_state(hwmgr->adev,
>                                                 AMD_IP_BLOCK_TYPE_UVD,
> -                                               AMD_PG_STATE_GATE);
> +                                               AMD_PG_STATE_GATE,
> +                                               0);
>                 amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
>                                                 AMD_IP_BLOCK_TYPE_UVD,
>                                                 AMD_CG_STATE_GATE);
> @@ -1998,7 +1999,8 @@ static void smu8_dpm_powergate_uvd(struct pp_hwmgr =
*hwmgr, bool bgate)
>                                                 AMD_CG_STATE_UNGATE);
>                 amdgpu_device_ip_set_powergating_state(hwmgr->adev,
>                                                 AMD_IP_BLOCK_TYPE_UVD,
> -                                               AMD_PG_STATE_UNGATE);
> +                                               AMD_PG_STATE_UNGATE,
> +                                               0);
>                 smu8_dpm_update_uvd_dpm(hwmgr, false);
>         }
>
> @@ -2017,7 +2019,8 @@ static void smu8_dpm_powergate_vce(struct pp_hwmgr =
*hwmgr, bool bgate)
>         if (bgate) {
>                 amdgpu_device_ip_set_powergating_state(hwmgr->adev,
>                                         AMD_IP_BLOCK_TYPE_VCE,
> -                                       AMD_PG_STATE_GATE);
> +                                       AMD_PG_STATE_GATE,
> +                                       0);
>                 amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
>                                         AMD_IP_BLOCK_TYPE_VCE,
>                                         AMD_CG_STATE_GATE);
> @@ -2032,7 +2035,8 @@ static void smu8_dpm_powergate_vce(struct pp_hwmgr =
*hwmgr, bool bgate)
>                                         AMD_CG_STATE_UNGATE);
>                 amdgpu_device_ip_set_powergating_state(hwmgr->adev,
>                                         AMD_IP_BLOCK_TYPE_VCE,
> -                                       AMD_PG_STATE_UNGATE);
> +                                       AMD_PG_STATE_UNGATE,
> +                                       0);
>                 smu8_dpm_update_vce_dpm(hwmgr);
>                 smu8_enable_disable_vce_dpm(hwmgr, true);
>         }
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/driv=
ers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
> index baf251fe5d82..64ef8c8398ff 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
> @@ -3715,11 +3715,13 @@ static void vega20_power_gate_vce(struct pp_hwmgr=
 *hwmgr, bool bgate)
>                 vega20_enable_disable_vce_dpm(hwmgr, !bgate);
>                 amdgpu_device_ip_set_powergating_state(hwmgr->adev,
>                                                 AMD_IP_BLOCK_TYPE_VCE,
> -                                               AMD_PG_STATE_GATE);
> +                                               AMD_PG_STATE_GATE,
> +                                               0);
>         } else {
>                 amdgpu_device_ip_set_powergating_state(hwmgr->adev,
>                                                 AMD_IP_BLOCK_TYPE_VCE,
> -                                               AMD_PG_STATE_UNGATE);
> +                                               AMD_PG_STATE_UNGATE,
> +                                               0);
>                 vega20_enable_disable_vce_dpm(hwmgr, !bgate);
>         }
>
> --
> 2.34.1
>
