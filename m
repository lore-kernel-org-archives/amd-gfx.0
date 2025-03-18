Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E31C28B2F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Mar 2025 13:11:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F06610E482;
	Tue, 18 Mar 2025 13:11:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A9Q/B8GI";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F11E10E482
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Mar 2025 13:11:10 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-301317939a0so799062a91.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Mar 2025 06:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742303469; x=1742908269; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U/ytMItHk9C8d+GHT93HS+yIdlISpapJ3P3bzwGyHyc=;
 b=A9Q/B8GI03iXipID6kHVEdQO6hHCK1DTRH6eqjqpSIA/3iA4OwHHXtCuPh+rvY63Vs
 F+r9PNH7hpLOA8t0PW23NXnnWWiWoWeumIHCQTdI6nVLMwmWKAGTqUiEm+enZPygetiy
 ht/DgnKl+tKz4Qk17UDvaoRXSLkurQd02qRF27Bajlfduh6Tu0GFlezfhc2MzDo7Iz0M
 zerGbfHRFFs0WBIhDFCICvTqPR3mDhuyICWqezlhS/8KV41j/fCkcXlWD1xKt18uVXbY
 ZwR5byUlN9oELMmNT1th5VVrCl+4FUVqMOU0NHhznLLxsQvFUIz0XRo0zikXPEOSiGPe
 BqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742303469; x=1742908269;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U/ytMItHk9C8d+GHT93HS+yIdlISpapJ3P3bzwGyHyc=;
 b=eMLNjjzpYOHTIAj+BQlZa1Siliuygj/zBikaNKCpJ5tufgAuvWNZuRbQWvzHrf0Ag5
 8iR+KNbtrTROnYyHHhVad/kxMS3gHgaHYGfevTpys2Z8jDZYcP9MeTeq7SSWZB4N9zT8
 AZ6x1n4gNPVOP1ZtT+nyP43TJiOq7C290n5R9XLNNQJ5fR20ojnX2jCBd9gOezS/i8Vt
 72D3LnJAtQCY6FyMnRwW3JTp370GBcq05UDxtJU8qaVg3QWNkCUtSJ9w35fF88On6ovq
 LDvXJxKe4g8mbEPAngq+V5jtl70Zv6vvKHcclpf9LfvXwhpUyPPh29iTzLw0e2hGyN56
 dxoA==
X-Gm-Message-State: AOJu0YxEA5zvRypYwCmGfyo5z7gtNCAbAgA/A+H8oTvebYi2F0w2/dky
 eSIxAxrshpH18YyS056RFcb+uliAOMxOINTn5nrozwTZKRkgmhJPfAs55v1pl90pu/p2slMYTD+
 ozwibOmXzkLsxG1uAcL0qQFeB1eA=
X-Gm-Gg: ASbGncsd/DqOm6lMDeBbkDHdCJrsyeBh2eLaLQyy3mvpzb6r7uZzs3F27OvQbq/w5W9
 C/SkOAvKElSipcD1YIhDQ4Y6Jnb5LcVRBzEs1HhbxwxqfoiR+6zdxNHbY9nWfInynE72iCjuRMK
 ebaDDKEKFOg0ywkx/lpk2WzPK1CQ==
X-Google-Smtp-Source: AGHT+IGmcN3FaXpAitjdQvqjt2ikiEml3j4K/khI8fmdyTOI6Ycdy55PG8TxS9xjjYIq+dkqNcHei8PdJinEFTCYRvQ=
X-Received: by 2002:a17:90b:3b46:b0:2ff:6ac2:c5ae with SMTP id
 98e67ed59e1d1-30151c795bbmr8146279a91.1.1742303469339; Tue, 18 Mar 2025
 06:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250317144603.809849-1-alexander.deucher@amd.com>
In-Reply-To: <20250317144603.809849-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 18 Mar 2025 09:10:57 -0400
X-Gm-Features: AQ5f1JrEG4YQJzKNty5yLX5PecMSdnK-chOT98MZaHI2wna5ZEIIDUehbd9RfmI
Message-ID: <CADnq5_Pa48X_CxFk5ft0MVPN+GP08h-Q7JXkgxDfs-HLLBYSqA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu/sdma: fix engine reset handling
To: Alex Deucher <alexander.deucher@amd.com>
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

Ping?

On Mon, Mar 17, 2025 at 11:02=E2=80=AFAM Alex Deucher <alexander.deucher@am=
d.com> wrote:
>
> Move the kfd suspend/resume code into the caller.  That
> is where the KFD is likely to detect a reset so on the KFD
> side there is no need to call them.  Also add a mutex to
> lock the actual reset sequence.
>
> v2: make the locking per instance
>
> Fixes: bac38ca8c475 ("drm/amdkfd: implement per queue sdma reset for gfx =
9.4+")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c          | 15 +++------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h          |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c          |  9 ++++++++-
>  .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c |  2 +-
>  4 files changed, 14 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_sdma.c
> index 03c4c012a1508..1b0b2598a90a7 100644
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
> +int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instan=
ce_id)
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
> +       mutex_lock(&sdma_instance->engine_reset_mutex);
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
> +       mutex_unlock(&sdma_instance->engine_reset_mutex);
>
>         return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_sdma.h
> index 9651693200655..8e7e794ff136f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -64,6 +64,7 @@ struct amdgpu_sdma_instance {
>         struct amdgpu_bo        *sdma_fw_obj;
>         uint64_t                sdma_fw_gpu_addr;
>         uint32_t                *sdma_fw_ptr;
> +       struct mutex            engine_reset_mutex;
>  };
>
>  enum amdgpu_sdma_ras_memory_id {
> @@ -169,7 +170,7 @@ struct amdgpu_buffer_funcs {
>  };
>
>  void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev,=
 struct sdma_on_reset_funcs *funcs);
> -int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instan=
ce_id, bool suspend_user_queues);
> +int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instan=
ce_id);
>
>  #define amdgpu_emit_copy_buffer(adev, ib, s, d, b, t) (adev)->mman.buffe=
r_funcs->emit_copy_buffer((ib),  (s), (d), (b), (t))
>  #define amdgpu_emit_fill_buffer(adev, ib, s, d, b) (adev)->mman.buffer_f=
uncs->emit_fill_buffer((ib), (s), (d), (b))
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v4_4_2.c
> index fd34dc1380811..927db7a080f0a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -1445,6 +1445,7 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_blo=
ck *ip_block)
>         }
>
>         for (i =3D 0; i < adev->sdma.num_instances; i++) {
> +               mutex_init(&adev->sdma.instance[i].engine_reset_mutex);
>                 ring =3D &adev->sdma.instance[i].ring;
>                 ring->ring_obj =3D NULL;
>                 ring->use_doorbell =3D true;
> @@ -1666,7 +1667,13 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_r=
ing *ring, unsigned int vmid)
>  {
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
nstance_id)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
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
