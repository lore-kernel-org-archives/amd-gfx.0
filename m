Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D130DC624D7
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2026 20:43:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34AAA10E12C;
	Thu,  3 Sep 2026 20:43:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eI3nUn6R";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A256610E12C
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Sep 2026 20:43:42 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-39666bed442so22521a91.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Sep 2026 13:43:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788468222; cv=none;
 d=google.com; s=arc-20260327;
 b=UHX3hfZlhOqGaYgwzgmWkMjxhffESWtvsYu8wOnaQ/0xzvyqa5429sT9xLGkwLKImW
 IMfPcP04G95RKVUgiGbpQDb5xa0/0i2n7KazG7kBkZdCuBh0uaUsHM0qSfrAOnPbsWG4
 MsslxvJZECEBuSAa4W6BcoqdAi6yzmAox2lrbsetyQucHcINHg1oKl3SgdxkkqvR7hNf
 TQqYDnXW1+95BpJmCv1845m8jEYGCjl1DVjh1K6vBz77KeTCvO4bV/PltPl1PYWCw+vS
 XesZ3j1kKxfNf2+XGiROkf7DIHZjAaU6v3irBYycizB6cYhonjjXjk3keadRU0kP5+S4
 2aZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bZBNWe3LKZ515R48YvUYaELFC5urgB3HmK6pFpkrUbQ=;
 fh=ebTNwso63II8DpA1nWkka4IVKto+41y3i16bbjXht00=;
 b=QUSYo+++Hi58uLzqd3GmAFym6SMsILdN/Z0HUoqM2A11kv/IUVhLf3S9NzN4RSZv71
 LSafTN2kU2JiWgzUG5dh1sv3uMnX9Qo83koyBTHrIH32uRlORvYtdzvBOGZgtuSNGQpv
 87onHrboMXqccRTPq0NkunxS5TwqBz1K4VBzd8gFWxHwDFEuNwjaul9ugnCF0c4VhHht
 9CtIDgfbIC5kYuYAr6EOHi9EWi5wm2UEt2WFf5z+PWVyvVw8UUvGTf8tDrNznLnKXOj1
 5asUmVauw3T1xTS7Jq8ptvB05+/FXxVuuM7Kn0/99Q3IFqCuUmeKfsKxbdEYyP6lVWBC
 5qzg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788468222; x=1789073022; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bZBNWe3LKZ515R48YvUYaELFC5urgB3HmK6pFpkrUbQ=;
 b=eI3nUn6RgaN4GVzZd954DsrpB3dxV1Aq7rDDcKGVHBZdebp0gyFKuj0bemb6n2da9T
 aJAk9wD/jZczFtyTT4y5Milxlt3ZjJpmIxXXSsS1cQNSF/u+kO9DlVS0DSYsv+ARWCfJ
 WqsM3FuF/1EyK0N1fpb+WsT/WDcf499ziU8JvAAZOCk2vbFIfcCA84IjGo1VLioeq9rT
 kVBD+lUQOm2UUsD9mo7vhUldk3HaWg/ZGqUmwoXIIkpB8pZttuzl4Ys7JnYPS2AGpp+5
 c5mJIAbGZqhbeEEItZD69WfjT5tj/69oucSBmgfjYAZ0O1+Euvzo1wVUcEp87CdAtMgh
 VtGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788468222; x=1789073022;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bZBNWe3LKZ515R48YvUYaELFC5urgB3HmK6pFpkrUbQ=;
 b=AAx70/BQendo1+HAiSOt8tYamOmPmXD2fe4GlNAkg+RqnDJr1ky1xSSaLcCaLSCpcg
 lepXelRBEW9ZUP9qVH0+aTXdTeNusgXpeLWu3AAcK48JSwxz/on4i0j4VhYDhoSXgAHJ
 M2ujbxUyzOqm/PZxGebMtO6UI0Zat1v/oJCnFSjZkMX2FQq53VQvzPu+EdpIiKfdQ56U
 w0lk5qZDkFPQDfH4NBZiY9DTOSJwnfLn14PWVCIjEdZ+FuTc0RBrtuXYpeOmPNCiAuYu
 gCI1PTicAcKAOw7YcgSoSYGIVXuW3MPbcHVrP4kUcBRlxCpm+qFYmP/Zb5NJqoiT8HsS
 OoOw==
X-Gm-Message-State: AFuF++k9hg7lj6T6UPF0GcnicjUW0fqL8X7TODtmEscNoCvhM2QfmC70
 yws+IqkAfg7X2qzBWGWMPEDptU6cnodDv/6SvZe53jpNd62WcZdOK3EVCupSvjk9ZPAikKr6iuo
 6QqlfKa6xlig8k+cfYt/k1yC4nWiSxWw=
X-Gm-Gg: AYBFou1M69BV7cm9AtI9EdYhJgpfy80msFsLNMjZcwEq9qQX0QGOW1qJuUhKiDIS/58
 Ho8U/ZcHsIV16VV96DlbGiVSfqf33iOE5W31IWpueb3jehmAceFAwzex0g2Erjwz1JUPLA/qN4q
 W9W1UwqO4ahhyRsxmUbpxXsObusmYQ26uevQXNql6GtswciaYDAASc3M1fMx5m8pdyTIfL+/lUy
 cn61SdG/X5vhrldJd1GRtRJNxWtCmBjv8Gfzm+MxjJo4sidFesvGM39JXUJSc4v25lG+FgnmuUH
 J0pATd9ZvlqayHqIan+RgvsJxz+uKPqhqslpVj1FlsXU0c0/+38gNQiDgBw8G7WeNV/PJUQ6vTX
 67arKX/szP1lAB2miiPWZya6gjuDgkmM=
X-Received: by 2002:a17:90b:3bcf:b0:396:d27c:8696 with SMTP id
 98e67ed59e1d1-39b2693597emr869005a91.4.1788468221943; Thu, 03 Sep 2026
 13:43:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260901084115.262457-1-timur.kristof@gmail.com>
 <20260901084115.262457-8-timur.kristof@gmail.com>
In-Reply-To: <20260901084115.262457-8-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 3 Sep 2026 16:43:29 -0400
X-Gm-Features: AcwNN1XNUXM8sFGzBJwW6ARLY9whQ3Bu6s6D1puoYo4tWfkwNs4AgiZlS5s_vbo
Message-ID: <CADnq5_PyPdCWt11oSrP_zF2gpV+xz=+pFWWTh7r8e4CQtad6uQ@mail.gmail.com>
Subject: Re: [PATCH 7/8] drm/amdgpu/sdma: Always handle kernel queues in
 amdgpu_sdma_reset_engine()
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Natalie Vock <natalie.vock@gmx.de>, Tvrtko Ursulin <tursulin@ursulin.net>, 
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
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

On Tue, Sep 1, 2026 at 5:00=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@gm=
ail.com> wrote:
>
> Remove the caller_handles_kernel_queues argument from
> the amdgpu_sdma_reset_engine() function and make it
> always handle kernel queues.
>
> Now the SDMA recovery sequence is more consistent
> between callers for the KFD as follows.
> Before recovery: first the KFD is suspended,
> then the SDMA queue contents are backed up.
> After recovery: first the SDMA queue contents
> are restored, then the KFD is resumed.
>
> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c      | 68 ++++++++++---------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h      |  3 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      |  2 +-
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c |  2 +-
>  4 files changed, 38 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_sdma.c
> index 9eebd8380834..e586df5f97bc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -542,16 +542,14 @@ static int amdgpu_sdma_soft_reset(struct amdgpu_dev=
ice *adev, u32 instance_id)
>  }
>
>  /**
> - * amdgpu_sdma_reset_engine - Reset a specific SDMA engine
> + * amdgpu_sdma_reset_engine() - Reset a specific SDMA engine instance.
> + *
>   * @adev: Pointer to the AMDGPU device
>   * @instance_id: Logical ID of the SDMA engine instance to reset
> - * @caller_handles_kernel_queues: Skip kernel queue processing. Caller
> - * will handle it.
>   *
>   * Returns: 0 on success, or a negative error code on failure.
>   */
> -int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instan=
ce_id,
> -                            bool caller_handles_kernel_queues)
> +int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instan=
ce_id)
>  {
>         struct amdgpu_sdma_instance *sdma_instance =3D &adev->sdma.instan=
ce[instance_id];
>         struct amdgpu_ring *gfx_ring =3D &sdma_instance->ring;
> @@ -564,20 +562,23 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *=
adev, uint32_t instance_id,
>
>         mutex_lock(&sdma_instance->engine_reset_mutex);
>
> -       if (!caller_handles_kernel_queues) {
> -               /* Stop the scheduler's work queue for the GFX and page r=
ings if they are running.
> -                * This ensures that no new tasks are submitted to the qu=
eues while
> -                * the reset is in progress.
> -                */
> +       /*
> +        * Stop the scheduler's work queue for the GFX and page rings if =
they are running.
> +        * This ensures that no new tasks are submitted to the queues whi=
le
> +        * the reset is in progress.
> +        */
> +       if (amdgpu_ring_sched_ready(gfx_ring) && !drm_sched_is_stopped(&g=
fx_ring->sched))
>                 drm_sched_wqueue_stop(&gfx_ring->sched);
> -               gfx_fence =3D amdgpu_ring_find_guilty_fence(gfx_ring);
> -               amdgpu_ring_reset_helper_begin(gfx_ring, gfx_fence);
>
> -               if (adev->sdma.has_page_queue) {
> +       gfx_fence =3D amdgpu_ring_find_guilty_fence(gfx_ring);
> +       amdgpu_ring_reset_helper_begin(gfx_ring, gfx_fence);
> +
> +       if (adev->sdma.has_page_queue) {
> +               if (amdgpu_ring_sched_ready(gfx_ring) && !drm_sched_is_st=
opped(&gfx_ring->sched))

These should use page_ring.  Other than that, it looks good to me.

Alex

>                         drm_sched_wqueue_stop(&page_ring->sched);
> -                       page_fence =3D amdgpu_ring_find_guilty_fence(page=
_ring);
> -                       amdgpu_ring_reset_helper_begin(page_ring, page_fe=
nce);
> -               }
> +
> +               page_fence =3D amdgpu_ring_find_guilty_fence(page_ring);
> +               amdgpu_ring_reset_helper_begin(page_ring, page_fence);
>         }
>
>         if (sdma_instance->funcs->stop_kernel_queue) {
> @@ -612,22 +613,25 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *=
adev, uint32_t instance_id,
>         }
>
>  exit:
> -       if (!caller_handles_kernel_queues) {
> -               /* Restart the scheduler's work queue for the GFX and pag=
e rings
> -                * if they were stopped by this function. This allows new=
 tasks
> -                * to be submitted to the queues after the reset is compl=
ete.
> -                */
> -               if (!ret) {
> -                       ret =3D amdgpu_ring_reset_helper_end(gfx_ring, gf=
x_fence);
> +       /* Restart the scheduler's work queue for the GFX and page rings
> +        * if they were stopped by this function. This allows new tasks
> +        * to be submitted to the queues after the reset is complete.
> +        */
> +       if (!ret) {
> +               ret =3D amdgpu_ring_reset_helper_end(gfx_ring, gfx_fence)=
;
> +               if (ret)
> +                       goto unlock;
> +
> +               if (amdgpu_ring_sched_ready(gfx_ring))
> +                       drm_sched_wqueue_start(&gfx_ring->sched);
> +
> +               if (adev->sdma.has_page_queue) {
> +                       ret =3D amdgpu_ring_reset_helper_end(page_ring, p=
age_fence);
>                         if (ret)
>                                 goto unlock;
> -                       drm_sched_wqueue_start(&gfx_ring->sched);
> -                       if (adev->sdma.has_page_queue) {
> -                               ret =3D amdgpu_ring_reset_helper_end(page=
_ring, page_fence);
> -                               if (ret)
> -                                       goto unlock;
> +
> +                       if (amdgpu_ring_sched_ready(page_ring))
>                                 drm_sched_wqueue_start(&page_ring->sched)=
;
> -                       }
>                 }
>         }
>  unlock:
> @@ -662,13 +666,11 @@ int amdgpu_sdma_reset_queue_legacy(struct amdgpu_ri=
ng *ring,
>                 return -EINVAL;
>         }
>
> -       amdgpu_ring_reset_helper_begin(ring, timedout_fence);
> -
>         amdgpu_amdkfd_suspend(adev, true);
> -       r =3D amdgpu_sdma_reset_engine(adev, ring->me, true);
> +       r =3D amdgpu_sdma_reset_engine(adev, ring->me);
>         amdgpu_amdkfd_resume(adev, true);
>         if (r)
>                 return r;
>
> -       return amdgpu_ring_reset_helper_end(ring, timedout_fence);
> +       return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_sdma.h
> index cb41453c1a19..5709d438e824 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -153,8 +153,7 @@ struct amdgpu_buffer_funcs {
>                                  uint32_t byte_count);
>  };
>
> -int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instan=
ce_id,
> -                            bool caller_handles_kernel_queues);
> +int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instan=
ce_id);
>
>  int amdgpu_sdma_reset_queue_legacy(struct amdgpu_ring *ring,
>                                    unsigned int vmid,
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v4_4_2.c
> index 77f385b9ef53..796ea9f74763 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -1583,7 +1583,7 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ri=
ng *ring,
>         int r;
>
>         amdgpu_amdkfd_suspend(adev, true);
> -       r =3D amdgpu_sdma_reset_engine(adev, id, false);
> +       r =3D amdgpu_sdma_reset_engine(adev, id);
>         amdgpu_amdkfd_resume(adev, true);
>         return r;
>  }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index a23384571193..f9fbc5628fb4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -2576,7 +2576,7 @@ static int reset_hung_queues_sdma(struct device_que=
ue_manager *dqm)
>                                 continue;
>
>                         /* Reset engine and check. */
> -                       if (amdgpu_sdma_reset_engine(dqm->dev->adev, i, f=
alse) ||
> +                       if (amdgpu_sdma_reset_engine(dqm->dev->adev, i) |=
|
>                             dqm->dev->kfd2kgd->hqd_sdma_get_doorbell(dqm-=
>dev->adev, i, j) ||
>                             !set_sdma_queue_as_reset(dqm, doorbell_off)) =
{
>                                 r =3D -ENOTRECOVERABLE;
> --
> 2.55.0
>
