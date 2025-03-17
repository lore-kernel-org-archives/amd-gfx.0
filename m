Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 996D8C28B30
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 12:58:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3736F10E068;
	Mon, 17 Mar 2025 12:58:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="APmcmzwZ";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43A3810E068
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 12:58:20 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-2ff53b26af2so424253a91.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 05:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742216300; x=1742821100; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9oHObi2jkMzm8JqpPhFM2OyjmOsdFszYWKeh1JFFUhk=;
 b=APmcmzwZI7D7GJR2BE3SxgADEnXrM8eqAxF2xRFoQBnGMAJOvXd42MeA6JiePxpQ5k
 CJmtwiSaMa88SXMw25BeWack3uo9lEGG4BwzLf3T/2xRVVvFA4omah4MBnwfw2XtpPUJ
 CxIZlS/K/ayzbuqzOKqjj9NWDL3nhQNx3qAGs23zItyJt5C7MPtMmygbaqEJ7bgxQm2c
 FgRmA5gTolLgoKQGhU35zRZQ9vcT3UaUdUPDCwdRtA0QdoPL0uYnZ2p6MIZnRN3y73eD
 Vq+JkJFYTfAlIpk3l3nNpKj0BTbL+l9f++tc9yoLjVQuVpgAjJSCuxQVgcDCu0pyZeJD
 T3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742216300; x=1742821100;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9oHObi2jkMzm8JqpPhFM2OyjmOsdFszYWKeh1JFFUhk=;
 b=hXeUcLdVGETzFP3Yvf4IqfOi9AJ9AFe8bxnkHO1qBNX27rwhMK/kw/hal/Gbibpp5M
 dDHaxynvxyeyI9lFsgHCdW7ZI0MjyR8q5D/8Z5Cblt1kOG9tVZTAY6fM4iRuCCpNiTjU
 cs0q149nDpnFkHrHP/OgK1jGBulY/y8PI8d52HGRgsnEpB8mGYn01y0DMuX0wi8qpw/r
 zQELUThJhMsgyWEB7OCx9z8TXTkVSVVDwdDqWd+YD5B0Dp07swkUs+DAsjllltWyr/z8
 cFp1sxn5uIhHCPufhsHO0nYloMKTMVY8b8SX8dRDTgVn7ER2EUhcq35ZdhwRnd2gW3/3
 DTkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0C4KuqG+hbuuWogvN/1+JLJ5mHYZlgokh9I+nIcPCu8nlBa4lW71mOE/3UR1Hsxm3NnYhEJof@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx0j8RUjuzHMCzvIYQidsg+SrZi4dIGdQ3h34UC4j/Uc097X7aj
 UzhXYvdkPylSEiCZqCC8Eg/fnUyqoEW6cZsEtSHC8WyB01bhnlWlg7g69w0hLmQzoVgkIpQ04h2
 emxu/BAwXT6tK+pN0cSjYkGIarZA=
X-Gm-Gg: ASbGncs4Zzo4Q8KkH0nfA/D4ZjUv8L03ooQNdubql72QzWGLTedXq7bnfrK8CVvpUrz
 hLL0AJn1WzT94TzLLtljv1faAlyNMHQ5G2wWnde9BoY1ANKnyQEGbHI+mvaOWpMl/ryNoqc5J8z
 PSHepATCtOGEIn6rLCaVaksyzdhw==
X-Google-Smtp-Source: AGHT+IGSYdLc59UgPtXcYgrsCEl0OZur9QIJRkQ6JiI9Mg3j+xWr5SffaiIPrlf1QqXEdjeNPyZ5x9oG/emxyEST+XY=
X-Received: by 2002:a17:90b:4b12:b0:2ff:4be6:c5e2 with SMTP id
 98e67ed59e1d1-30151d8e5camr5492647a91.7.1742216300114; Mon, 17 Mar 2025
 05:58:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250315172150.3901918-1-alexander.deucher@amd.com>
 <DM4PR12MB5152B9429807E8AA1B7EFDB5E3DF2@DM4PR12MB5152.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5152B9429807E8AA1B7EFDB5E3DF2@DM4PR12MB5152.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 17 Mar 2025 08:58:08 -0400
X-Gm-Features: AQ5f1JrLIYw-YB7ExeUwwARMlvU0sCZV2X5XRapI5TIJRtXMGaFbozxM8q0Nx8Y
Message-ID: <CADnq5_Oqytt+rkcyiNxvpzdh1xoqA941GBM1Nz1YJdgjp6+f-g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/sdma: fix engine reset handling
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
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

On Sun, Mar 16, 2025 at 10:01=E2=80=AFPM Zhang, Jesse(Jie) <Jesse.Zhang@amd=
.com> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex D=
eucher
> Sent: Sunday, March 16, 2025 1:22 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu/sdma: fix engine reset handling
>
> Move the kfd suspend/resume code into the caller.  That is where the KFD =
is likely to detect a reset so on the KFD side there is no need to call the=
m.  Also add a mutex to lock the actual reset sequence.
>
> Fixes: bac38ca8c475 ("drm/amdkfd: implement per queue sdma reset for gfx =
9.4+")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c        |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c          | 15 +++------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h          |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c          |  8 +++++++-
>  .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c |  2 +-
>  5 files changed, 14 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 1d8cfdc51bdcb..611b27c91a18a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4281,6 +4281,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>         mutex_init(&adev->gfx.kfd_sch_mutex);
>         mutex_init(&adev->gfx.workload_profile_mutex);
>         mutex_init(&adev->vcn.workload_profile_mutex);
> +       mutex_init(&adev->sdma.engine_reset_mutex);
>
>         amdgpu_device_init_apu_flags(adev);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_sdma.c
> index 03c4c012a1508..0b2529ef5a963 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -524,7 +524,6 @@ void amdgpu_sdma_register_on_reset_callbacks(struct a=
mdgpu_device *adev, struct
>   * amdgpu_sdma_reset_engine - Reset a specific SDMA engine
>   * @adev: Pointer to the AMDGPU device
>   * @instance_id: ID of the SDMA engine instance to reset
> - * @suspend_user_queues: check if suspend user queue.
>   *
>   * This function performs the following steps:
>   * 1. Calls all registered pre_reset callbacks to allow KFD and AMDGPU t=
o save their state.
> @@ -533,7 +532,7 @@ void amdgpu_sdma_register_on_reset_callbacks(struct a=
mdgpu_device *adev, struct
>   *
>   * Returns: 0 on success, or a negative error code on failure.
>   */
> -int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instan=
ce_id, bool suspend_user_queues)
> +int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t
> +instance_id)
>  {
>         struct sdma_on_reset_funcs *funcs;
>         int ret =3D 0;
> @@ -542,13 +541,7 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *a=
dev, uint32_t instance_id, b
>         struct amdgpu_ring *page_ring =3D &sdma_instance->page;
>         bool gfx_sched_stopped =3D false, page_sched_stopped =3D false;
>
> -       /* Suspend KFD if suspend_user_queues is true.
> -        * prevent the destruction of in-flight healthy user queue packet=
s and
> -        * avoid race conditions between KFD and KGD during the reset pro=
cess.
> -        */
> -       if (suspend_user_queues)
> -               amdgpu_amdkfd_suspend(adev, false);
> -
> +       mutex_lock(&adev->sdma.engine_reset_mutex);
>         /* Stop the scheduler's work queue for the GFX and page rings if =
they are running.
>         * This ensures that no new tasks are submitted to the queues whil=
e
>         * the reset is in progress.
> @@ -609,9 +602,7 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *ad=
ev, uint32_t instance_id, b
>                         drm_sched_wqueue_start(&page_ring->sched);
>                 }
>         }
> -
> -       if (suspend_user_queues)
> -               amdgpu_amdkfd_resume(adev, false);
> +       mutex_unlock(&adev->sdma.engine_reset_mutex);
>
>         return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_sdma.h
> index 9651693200655..d3a44a8cf6104 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -129,6 +129,7 @@ struct amdgpu_sdma {
>         /* track guilty state of GFX and PAGE queues */
>         bool gfx_guilty;
>         bool page_guilty;
> +       struct mutex            engine_reset_mutex;
>  };
>
> Should we move the definition of engine_reset_mutex to struct amdgpu_sdma=
_instance
> to avoid races on different smda instances?

Yes, we can make the lock per instance since amdgpu_dpm_reset_sdma()
has its own locking on the smu side.

Alex

>
> Except for that question, the  patch is Reviewed-by: Jesse.Zhang <Jesse.z=
hang@amd.com>
>
>  /*
> @@ -169,7 +170,7 @@ struct amdgpu_buffer_funcs {  };
>
>  void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev,=
 struct sdma_on_reset_funcs *funcs); -int amdgpu_sdma_reset_engine(struct a=
mdgpu_device *adev, uint32_t instance_id, bool suspend_user_queues);
> +int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t
> +instance_id);
>
>  #define amdgpu_emit_copy_buffer(adev, ib, s, d, b, t) (adev)->mman.buffe=
r_funcs->emit_copy_buffer((ib),  (s), (d), (b), (t))  #define amdgpu_emit_f=
ill_buffer(adev, ib, s, d, b) (adev)->mman.buffer_funcs->emit_fill_buffer((=
ib), (s), (d), (b)) diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b=
/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index fd34dc1380811..14e4f7358cc4c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -1666,7 +1666,13 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_r=
ing *ring, unsigned int vmid)  {
>         struct amdgpu_device *adev =3D ring->adev;
>         u32 id =3D GET_INST(SDMA0, ring->me);
> -       return amdgpu_sdma_reset_engine(adev, id, true);
> +       int r;
> +
> +       amdgpu_amdkfd_suspend(adev, false);
> +       r =3D amdgpu_sdma_reset_engine(adev, id);
> +       amdgpu_amdkfd_resume(adev, false);
> +
> +       return r;
>  }
>
>  static int sdma_v4_4_2_stop_queue(struct amdgpu_device *adev, uint32_t i=
nstance_id) diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manage=
r.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 2ed003d3ff0e0..c610e172a2b83 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -2310,7 +2310,7 @@ static int reset_hung_queues_sdma(struct device_que=
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
> 2.48.1
>
