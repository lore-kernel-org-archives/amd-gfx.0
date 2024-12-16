Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA82E7717F
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2024 17:50:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA01A10E735;
	Mon, 16 Dec 2024 17:50:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UaKC8svm";
	dkim-atps=neutral
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93C3510E735
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2024 17:50:33 +0000 (UTC)
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7c3d415f85eso283341a12.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2024 09:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734371433; x=1734976233; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BxhfQB7oQb1N3FhKE+rj/bKw2KZHQyl8RU2PBOl0wU8=;
 b=UaKC8svm7vLXo9yM+6Qs1H80780wmMDAH1KFR4TFrNWP78oQOrq+9sdhVj6cJiS5ey
 DE6B0PkkWmDYefZrMAoj9WQK/nkVdOTkvSkpXQKradOztHdMIPruNUFZqj1wpWM1bHSZ
 F+fUxaEGrx4rdCmN9dz0nZoDDj8PJGilRhux98LoK8/sDfhcInEYftIn2okwKRiFdB/3
 /rIy6uLdgarQSDV+pDRwiR+y7QiBybqr0LwfFw48EuAyIau/Cue7V2U/OhvN7/VtNSsA
 qGIjU67miPruVvuorhtguMaH6InkwdTubqmZIk1poKd2jajIc/dt91rHNLaD0s06bP4j
 Rp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734371433; x=1734976233;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BxhfQB7oQb1N3FhKE+rj/bKw2KZHQyl8RU2PBOl0wU8=;
 b=dzpQUA5qYDiboWGn420Hxz2y1sJnjDoI7bFUCuD4JaXwxAJpNvalrJKu7nx6oZiUd+
 PHkj4//j5xDeHUtiyBZ1vcGK3KA6sFcffhGaKAmR7T/4WFA4wlRTZ0b/x9c7DF/8U75S
 i3J+bQc+ui1pJNLOivf0Deuf6WmpuED+VfTUCNBHGSsucUi4cGE1eLJxMVrZfcxbQaHz
 pHxQQD4zqwHT0EjL2eul9H+NNfDFaee/BTUsPygeRPr6+lJtPZIbzGR9H1MQ2Wpcenev
 K/cfAmtj+nvcW1qmgWlurzWdcrohFqKkJ9nuK6R+rshUnvgfOtb4HJ/LPNFWLKAreCkx
 nlFQ==
X-Gm-Message-State: AOJu0Yy8R12KhulK6daljpF3VAWouZ2td/iEMskLnQc+Q/Ov89SDmZ4K
 o/BKKRkL9w1W55rTyrWB18i0gl6+iwaNe0/6Bi27HOOA30QBKiSjXqFn5f/lNqYrSQ53KIXkk1x
 eoOpNjDgWoo4HRRfKRcISBhdPaO0=
X-Gm-Gg: ASbGnctNCe4h29Lm9IhpoFJw/nUdMT9NRsh6N56UNmGbQ1OdpWQIRmfHcx7DZrPxyCc
 c1uq2k2Wup+4nUfM9OZD9vo2UHpmPZOgsJSgzKg==
X-Google-Smtp-Source: AGHT+IHTtxXlK4LU17X0i/3ARJ4WgKaQI7saBXS5AGpBmqPDrSdScmHZbH5NkI0fBfeLUGR6AZl7dyUTVOBEnYWJ3EQ=
X-Received: by 2002:a17:90b:5444:b0:2ef:93:154e with SMTP id
 98e67ed59e1d1-2f2901b2b70mr7385901a91.5.1734371432876; Mon, 16 Dec 2024
 09:50:32 -0800 (PST)
MIME-Version: 1.0
References: <20241213085255.1449-1-christian.koenig@amd.com>
 <20241213085255.1449-3-christian.koenig@amd.com>
In-Reply-To: <20241213085255.1449-3-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Dec 2024 12:50:21 -0500
Message-ID: <CADnq5_O-+BFpPCDGxrg+HD8atXy1GFuqSizr18Z9FXKm9uraEA@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: partially revert "reduce reset time"
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com
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

On Fri, Dec 13, 2024 at 4:03=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> This partially reverts commit 194eb174cbe4fe2b3376ac30acca2dc8c8beca00.
>
> This commit introduced a new state variable into adev without even
> remotely worrying about CPU barriers.
>
> Since we already have the amdgpu_in_reset() function exactly for this
> use case partially revert that.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 3 ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 2 +-
>  5 files changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 7051b697530b..5e55a44f9eef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1192,7 +1192,6 @@ struct amdgpu_device {
>
>         struct work_struct              reset_work;
>
> -       bool                            job_hang;
>         bool                            dc_enabled;
>         /* Mask of active clusters */
>         uint32_t                        aid_mask;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_amdkfd.c
> index 503051352922..dca5a4ef2734 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -836,7 +836,7 @@ int amdgpu_amdkfd_unmap_hiq(struct amdgpu_device *ade=
v, u32 doorbell_off,
>         if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
>                 return -EINVAL;
>
> -       if (!kiq_ring->sched.ready || adev->job_hang)
> +       if (!kiq_ring->sched.ready || amdgpu_in_reset(adev))
>                 return 0;
>
>         ring_funcs =3D kzalloc(sizeof(*ring_funcs), GFP_KERNEL);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index a4dde54512b1..2e6829e1554b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -515,7 +515,7 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev=
, int xcc_id)
>         if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
>                 return -EINVAL;
>
> -       if (!kiq_ring->sched.ready || adev->job_hang || amdgpu_in_reset(a=
dev))
> +       if (!kiq_ring->sched.ready || amdgpu_in_reset(adev))
>                 return 0;
>
>         spin_lock(&kiq->ring_lock);
> @@ -567,7 +567,7 @@ int amdgpu_gfx_disable_kgq(struct amdgpu_device *adev=
, int xcc_id)
>         if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
>                 return -EINVAL;
>
> -       if (!adev->gfx.kiq[0].ring.sched.ready || adev->job_hang)
> +       if (!adev->gfx.kiq[0].ring.sched.ready || amdgpu_in_reset(adev))
>                 return 0;
>
>         if (amdgpu_gfx_is_master_xcc(adev, xcc_id)) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_job.c
> index 7fdf7b047317..6cc44eb2586f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -102,8 +102,6 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(st=
ruct drm_sched_job *s_job)
>                 return DRM_GPU_SCHED_STAT_ENODEV;
>         }
>
> -       adev->job_hang =3D true;
> -
>         /*
>          * Do the coredump immediately after a job timeout to get a very
>          * close dump/snapshot/representation of GPU's current error stat=
us
> @@ -181,7 +179,6 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(st=
ruct drm_sched_job *s_job)
>         }
>
>  exit:
> -       adev->job_hang =3D false;
>         drm_dev_exit(idx);
>         return DRM_GPU_SCHED_STAT_NOMINAL;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v10_0.c
> index c4e15418e187..714a6caeb679 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -5957,7 +5957,7 @@ static int gfx_v10_0_cp_gfx_enable(struct amdgpu_de=
vice *adev, bool enable)
>         else
>                 WREG32_SOC15(GC, 0, mmCP_ME_CNTL, tmp);
>
> -       if (adev->job_hang && !enable)
> +       if (amdgpu_in_reset(adev) && !enable)
>                 return 0;
>
>         for (i =3D 0; i < adev->usec_timeout; i++) {
> --
> 2.34.1
>
