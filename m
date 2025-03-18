Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C5F4C28B28
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Mar 2025 13:15:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9595710E487;
	Tue, 18 Mar 2025 13:15:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RNsckiDv";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC94D10E486
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Mar 2025 13:15:42 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-2ff7255b8c6so577821a91.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Mar 2025 06:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742303742; x=1742908542; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=70E/FULVI6xVR4NycO8IAMYJ5/Tzlfojep+ps6oVDe0=;
 b=RNsckiDvnAyxHBaVQvGImCTTyQqrsh+Sud+6Rw+w3lVgtCZLkX5j+e2wXYdnFkb/o8
 aiefcSv/hAjGv/dQrqpJBNp535tYnPWJWIEgu0R6q3gfUYLFRYN4M1bCfPPz2VmXkswE
 bhjM7a8aPsWTxB2vVAFVnWVq1dsjMLHwkA4WKyohPWmg4PadK79kTD3qmgR/b7MyVVbD
 oJGeWO8U8ZF2Wv70wK6qE/v9uZyhT7hVdxvasSOSm5uM+wHePCxLFfmK8Ami2Bk7BABW
 lcxcESZIZD57d0iUghvjEYuS9GCtsof3gcwuYMOhHu2VaQGtzH8ZcTUWl/BA3HnYbXLG
 /2yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742303742; x=1742908542;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=70E/FULVI6xVR4NycO8IAMYJ5/Tzlfojep+ps6oVDe0=;
 b=NICgojYSpKi4AOSsGbLBPKnFR8JCR9DheLBGbK8ljK2TPrYsI/PwP+elbl8md6Cg5k
 51IhcGTPimjxqINcY0IZXnqy4Ge/Llt6u1VU1iMoj/Zi2+X36xlVZ7rqnX6nnahpPZGB
 uqh0EKeBF7e7R0p+6lti9jDEnJTQXw3HgHbljbZhWkvauf89u+ugVs1obi2DF4FuQeNY
 1lC0A52GWopsF7z/lw65mq0r+YSLPOSFArniCRdkvPgLMKdfP0/Q3IIbBuYzK5G7ryNF
 7Mb/u9aNxEi5JhrmyDKutoeBWza05k94IRPx1zh2AIxNoVWHkD8IlQ0gMG8xke/TaOQL
 bx+g==
X-Gm-Message-State: AOJu0Yy6SMrPnQmgBWNyCQPCXdypiMAobAyL/kJHSlG00RjtFcNu2WVL
 nJ+g0cWcd4HlInLABH9jLpMLAg3dxRmEB3WoPzronaFJlbErIMPznhpnAdK0SKJgVcRk4sl164T
 74+IBuwirSGwbR5JFnv8MkfXZYEqyPQ==
X-Gm-Gg: ASbGncvqm6Pj8EmwPJIyOMDAns0R7gnakHnxxSD+l/xE3QkTXgrIPEY2fjZ/fAhwnbm
 PqNgAkDvBqg/BBfOtSTUFuStrSYBfV8x1XxykbPOdMcoRC1jgcQnSq4AGrsCgyAvHF16n0h74xl
 HA+popNVesx/BlZRqYUvptboxlOg==
X-Google-Smtp-Source: AGHT+IFJm77ppdpHmFSqbp7XmNRRDfPUYArkpslMRhvks+IlFbb0SOYTAnAHLPlrQEgcbgNAQh+rU6Ja9r8pW4iX2qg=
X-Received: by 2002:a17:90b:1c0e:b0:2fe:b972:a2c3 with SMTP id
 98e67ed59e1d1-30151ad6199mr8151704a91.0.1742303741421; Tue, 18 Mar 2025
 06:15:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250312175657.187396-1-alexander.deucher@amd.com>
In-Reply-To: <20250312175657.187396-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 18 Mar 2025 09:15:29 -0400
X-Gm-Features: AQ5f1JpEB8HhCPJgicXzK0jBg3B4CaUTP3rORBUbINR2G4QF_q2zgwY8zogTXkk
Message-ID: <CADnq5_Oj4s9QWjgGJBFkfwRsjKt=erAYrBBvK5pxEQXZCVenvA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: remove is_mes_queue flag
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

On Wed, Mar 12, 2025 at 1:57=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> This was leftover from MES bring up when we had MES
> user queues in the kernel.  It's no longer used so
> remove it.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c   |   4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 112 ++++++---------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  14 --
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c |  22 +--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   |   2 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   |  84 +++---------
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   | 143 ++++---------------
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    |  67 ++-------
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   |   4 -
>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c   |   4 -
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c   |   4 -
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 166 +++++++----------------
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   |  83 ++++--------
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   |  83 ++++--------
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   | 164 +++++++---------------
>  15 files changed, 259 insertions(+), 697 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ib.c
> index eac96a3d8c6c3..6efa0c5717dcf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -163,12 +163,12 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, un=
signed int num_ibs,
>                 init_shadow =3D false;
>         }
>
> -       if (!ring->sched.ready && !ring->is_mes_queue) {
> +       if (!ring->sched.ready) {
>                 dev_err(adev->dev, "couldn't schedule ib on ring <%s>\n",=
 ring->name);
>                 return -EINVAL;
>         }
>
> -       if (vm && !job->vmid && !ring->is_mes_queue) {
> +       if (vm && !job->vmid) {
>                 dev_err(adev->dev, "VM IB without ID\n");
>                 return -EINVAL;
>         }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ring.c
> index d55c8b7fdb596..ba8f2785865af 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -187,14 +187,10 @@ void amdgpu_ring_undo(struct amdgpu_ring *ring)
>  }
>
>  #define amdgpu_ring_get_gpu_addr(ring, offset)                         \
> -       (ring->is_mes_queue ?                                           \
> -        (ring->mes_ctx->meta_data_gpu_addr + offset) :                 \
> -        (ring->adev->wb.gpu_addr + offset * 4))
> +        (ring->adev->wb.gpu_addr + offset * 4)
>
>  #define amdgpu_ring_get_cpu_addr(ring, offset)                         \
> -       (ring->is_mes_queue ?                                           \
> -        (void *)((uint8_t *)(ring->mes_ctx->meta_data_ptr) + offset) : \
> -        (&ring->adev->wb.wb[offset]))
> +        (&ring->adev->wb.wb[offset])
>
>  /**
>   * amdgpu_ring_init - init driver ring struct.
> @@ -243,57 +239,42 @@ int amdgpu_ring_init(struct amdgpu_device *adev, st=
ruct amdgpu_ring *ring,
>                 ring->sched_score =3D sched_score;
>                 ring->vmid_wait =3D dma_fence_get_stub();
>
> -               if (!ring->is_mes_queue) {
> -                       ring->idx =3D adev->num_rings++;
> -                       adev->rings[ring->idx] =3D ring;
> -               }
> +               ring->idx =3D adev->num_rings++;
> +               adev->rings[ring->idx] =3D ring;
>
>                 r =3D amdgpu_fence_driver_init_ring(ring);
>                 if (r)
>                         return r;
>         }
>
> -       if (ring->is_mes_queue) {
> -               ring->rptr_offs =3D amdgpu_mes_ctx_get_offs(ring,
> -                               AMDGPU_MES_CTX_RPTR_OFFS);
> -               ring->wptr_offs =3D amdgpu_mes_ctx_get_offs(ring,
> -                               AMDGPU_MES_CTX_WPTR_OFFS);
> -               ring->fence_offs =3D amdgpu_mes_ctx_get_offs(ring,
> -                               AMDGPU_MES_CTX_FENCE_OFFS);
> -               ring->trail_fence_offs =3D amdgpu_mes_ctx_get_offs(ring,
> -                               AMDGPU_MES_CTX_TRAIL_FENCE_OFFS);
> -               ring->cond_exe_offs =3D amdgpu_mes_ctx_get_offs(ring,
> -                               AMDGPU_MES_CTX_COND_EXE_OFFS);
> -       } else {
> -               r =3D amdgpu_device_wb_get(adev, &ring->rptr_offs);
> -               if (r) {
> -                       dev_err(adev->dev, "(%d) ring rptr_offs wb alloc =
failed\n", r);
> -                       return r;
> -               }
> +       r =3D amdgpu_device_wb_get(adev, &ring->rptr_offs);
> +       if (r) {
> +               dev_err(adev->dev, "(%d) ring rptr_offs wb alloc failed\n=
", r);
> +               return r;
> +       }
>
> -               r =3D amdgpu_device_wb_get(adev, &ring->wptr_offs);
> -               if (r) {
> -                       dev_err(adev->dev, "(%d) ring wptr_offs wb alloc =
failed\n", r);
> -                       return r;
> -               }
> +       r =3D amdgpu_device_wb_get(adev, &ring->wptr_offs);
> +       if (r) {
> +               dev_err(adev->dev, "(%d) ring wptr_offs wb alloc failed\n=
", r);
> +               return r;
> +       }
>
> -               r =3D amdgpu_device_wb_get(adev, &ring->fence_offs);
> -               if (r) {
> -                       dev_err(adev->dev, "(%d) ring fence_offs wb alloc=
 failed\n", r);
> -                       return r;
> -               }
> +       r =3D amdgpu_device_wb_get(adev, &ring->fence_offs);
> +       if (r) {
> +               dev_err(adev->dev, "(%d) ring fence_offs wb alloc failed\=
n", r);
> +               return r;
> +       }
>
> -               r =3D amdgpu_device_wb_get(adev, &ring->trail_fence_offs)=
;
> -               if (r) {
> -                       dev_err(adev->dev, "(%d) ring trail_fence_offs wb=
 alloc failed\n", r);
> -                       return r;
> -               }
> +       r =3D amdgpu_device_wb_get(adev, &ring->trail_fence_offs);
> +       if (r) {
> +               dev_err(adev->dev, "(%d) ring trail_fence_offs wb alloc f=
ailed\n", r);
> +               return r;
> +       }
>
> -               r =3D amdgpu_device_wb_get(adev, &ring->cond_exe_offs);
> -               if (r) {
> -                       dev_err(adev->dev, "(%d) ring cond_exec_polling w=
b alloc failed\n", r);
> -                       return r;
> -               }
> +       r =3D amdgpu_device_wb_get(adev, &ring->cond_exe_offs);
> +       if (r) {
> +               dev_err(adev->dev, "(%d) ring cond_exec_polling wb alloc =
failed\n", r);
> +               return r;
>         }
>
>         ring->fence_gpu_addr =3D
> @@ -353,18 +334,7 @@ int amdgpu_ring_init(struct amdgpu_device *adev, str=
uct amdgpu_ring *ring,
>         ring->cached_rptr =3D 0;
>
>         /* Allocate ring buffer */
> -       if (ring->is_mes_queue) {
> -               int offset =3D 0;
> -
> -               BUG_ON(ring->ring_size > PAGE_SIZE*4);
> -
> -               offset =3D amdgpu_mes_ctx_get_offs(ring,
> -                                        AMDGPU_MES_CTX_RING_OFFS);
> -               ring->gpu_addr =3D amdgpu_mes_ctx_get_offs_gpu_addr(ring,=
 offset);
> -               ring->ring =3D amdgpu_mes_ctx_get_offs_cpu_addr(ring, off=
set);
> -               amdgpu_ring_clear_ring(ring);
> -
> -       } else if (ring->ring_obj =3D=3D NULL) {
> +       if (ring->ring_obj =3D=3D NULL) {
>                 r =3D amdgpu_bo_create_kernel(adev, ring->ring_size + rin=
g->funcs->extra_dw, PAGE_SIZE,
>                                             AMDGPU_GEM_DOMAIN_GTT,
>                                             &ring->ring_obj,
> @@ -401,32 +371,26 @@ void amdgpu_ring_fini(struct amdgpu_ring *ring)
>  {
>
>         /* Not to finish a ring which is not initialized */
> -       if (!(ring->adev) ||
> -           (!ring->is_mes_queue && !(ring->adev->rings[ring->idx])))
> +       if (!(ring->adev) || !(ring->adev->rings[ring->idx]))
>                 return;
>
>         ring->sched.ready =3D false;
>
> -       if (!ring->is_mes_queue) {
> -               amdgpu_device_wb_free(ring->adev, ring->rptr_offs);
> -               amdgpu_device_wb_free(ring->adev, ring->wptr_offs);
> +       amdgpu_device_wb_free(ring->adev, ring->rptr_offs);
> +       amdgpu_device_wb_free(ring->adev, ring->wptr_offs);
>
> -               amdgpu_device_wb_free(ring->adev, ring->cond_exe_offs);
> -               amdgpu_device_wb_free(ring->adev, ring->fence_offs);
> +       amdgpu_device_wb_free(ring->adev, ring->cond_exe_offs);
> +       amdgpu_device_wb_free(ring->adev, ring->fence_offs);
>
> -               amdgpu_bo_free_kernel(&ring->ring_obj,
> -                                     &ring->gpu_addr,
> -                                     (void **)&ring->ring);
> -       } else {
> -               kfree(ring->fence_drv.fences);
> -       }
> +       amdgpu_bo_free_kernel(&ring->ring_obj,
> +                             &ring->gpu_addr,
> +                             (void **)&ring->ring);
>
>         dma_fence_put(ring->vmid_wait);
>         ring->vmid_wait =3D NULL;
>         ring->me =3D 0;
>
> -       if (!ring->is_mes_queue)
> -               ring->adev->rings[ring->idx] =3D NULL;
> +       ring->adev->rings[ring->idx] =3D NULL;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ring.h
> index d93d3047553b3..bea3747f9550b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -306,11 +306,6 @@ struct amdgpu_ring {
>         unsigned                num_hw_submission;
>         atomic_t                *sched_score;
>
> -       /* used for mes */
> -       bool                    is_mes_queue;
> -       uint32_t                hw_queue_id;
> -       struct amdgpu_mes_ctx_data *mes_ctx;
> -
>         bool            is_sw_ring;
>         unsigned int    entry_index;
>         /* store the cached rptr to restore after reset */
> @@ -440,15 +435,6 @@ static inline void amdgpu_ring_patch_cond_exec(struc=
t amdgpu_ring *ring,
>         ring->ring[offset] =3D cur - offset;
>  }
>
> -#define amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset)                 \
> -       (ring->is_mes_queue && ring->mes_ctx ?                          \
> -        (ring->mes_ctx->meta_data_gpu_addr + offset) : 0)
> -
> -#define amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset)                 \
> -       (ring->is_mes_queue && ring->mes_ctx ?                          \
> -        (void *)((uint8_t *)(ring->mes_ctx->meta_data_ptr) + offset) : \
> -        NULL)
> -
>  int amdgpu_ring_test_helper(struct amdgpu_ring *ring);
>
>  void amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_sdma.c
> index 3a4cef8960185..03c4c012a1508 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -76,22 +76,14 @@ uint64_t amdgpu_sdma_get_csa_mc_addr(struct amdgpu_ri=
ng *ring,
>         if (amdgpu_sriov_vf(adev) || vmid =3D=3D 0 || !adev->gfx.mcbp)
>                 return 0;
>
> -       if (ring->is_mes_queue) {
> -               uint32_t offset =3D 0;
> +       r =3D amdgpu_sdma_get_index_from_ring(ring, &index);
>
> -               offset =3D offsetof(struct amdgpu_mes_ctx_meta_data,
> -                                 sdma[ring->idx].sdma_meta_data);
> -               csa_mc_addr =3D amdgpu_mes_ctx_get_offs_gpu_addr(ring, of=
fset);
> -       } else {
> -               r =3D amdgpu_sdma_get_index_from_ring(ring, &index);
> -
> -               if (r || index > 31)
> -                       csa_mc_addr =3D 0;
> -               else
> -                       csa_mc_addr =3D amdgpu_csa_vaddr(adev) +
> -                               AMDGPU_CSA_SDMA_OFFSET +
> -                               index * AMDGPU_CSA_SDMA_SIZE;
> -       }
> +       if (r || index > 31)
> +               csa_mc_addr =3D 0;
> +       else
> +               csa_mc_addr =3D amdgpu_csa_vaddr(adev) +
> +                       AMDGPU_CSA_SDMA_OFFSET +
> +                       index * AMDGPU_CSA_SDMA_SIZE;
>
>         return csa_mc_addr;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index ef4fe2df8398c..ea18484d1d7a7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -702,7 +702,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct =
amdgpu_job *job,
>         if (spm_update_needed && adev->gfx.rlc.funcs->update_spm_vmid)
>                 adev->gfx.rlc.funcs->update_spm_vmid(adev, ring, job->vmi=
d);
>
> -       if (!ring->is_mes_queue && ring->funcs->emit_gds_switch &&
> +       if (ring->funcs->emit_gds_switch &&
>             gds_switch_needed) {
>                 amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_bas=
e,
>                                             job->gds_size, job->gws_base,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 2cf663d25881d..719c4aa90a0e0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -582,33 +582,18 @@ static int gfx_v11_0_ring_test_ib(struct amdgpu_rin=
g *ring, long timeout)
>
>         memset(&ib, 0, sizeof(ib));
>
> -       if (ring->is_mes_queue) {
> -               uint32_t padding, offset;
> -
> -               offset =3D amdgpu_mes_ctx_get_offs(ring, AMDGPU_MES_CTX_I=
B_OFFS);
> -               padding =3D amdgpu_mes_ctx_get_offs(ring,
> -                                                 AMDGPU_MES_CTX_PADDING_=
OFFS);
> -
> -               ib.gpu_addr =3D amdgpu_mes_ctx_get_offs_gpu_addr(ring, of=
fset);
> -               ib.ptr =3D amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset)=
;
> -
> -               gpu_addr =3D amdgpu_mes_ctx_get_offs_gpu_addr(ring, paddi=
ng);
> -               cpu_ptr =3D amdgpu_mes_ctx_get_offs_cpu_addr(ring, paddin=
g);
> -               *cpu_ptr =3D cpu_to_le32(0xCAFEDEAD);
> -       } else {
> -               r =3D amdgpu_device_wb_get(adev, &index);
> -               if (r)
> -                       return r;
> +       r =3D amdgpu_device_wb_get(adev, &index);
> +       if (r)
> +               return r;
>
> -               gpu_addr =3D adev->wb.gpu_addr + (index * 4);
> -               adev->wb.wb[index] =3D cpu_to_le32(0xCAFEDEAD);
> -               cpu_ptr =3D &adev->wb.wb[index];
> +       gpu_addr =3D adev->wb.gpu_addr + (index * 4);
> +       adev->wb.wb[index] =3D cpu_to_le32(0xCAFEDEAD);
> +       cpu_ptr =3D &adev->wb.wb[index];
>
> -               r =3D amdgpu_ib_get(adev, NULL, 20, AMDGPU_IB_POOL_DIRECT=
, &ib);
> -               if (r) {
> -                       DRM_ERROR("amdgpu: failed to get ib (%ld).\n", r)=
;
> -                       goto err1;
> -               }
> +       r =3D amdgpu_ib_get(adev, NULL, 20, AMDGPU_IB_POOL_DIRECT, &ib);
> +       if (r) {
> +               DRM_ERROR("amdgpu: failed to get ib (%ld).\n", r);
> +               goto err1;
>         }
>
>         ib.ptr[0] =3D PACKET3(PACKET3_WRITE_DATA, 3);
> @@ -635,12 +620,10 @@ static int gfx_v11_0_ring_test_ib(struct amdgpu_rin=
g *ring, long timeout)
>         else
>                 r =3D -EINVAL;
>  err2:
> -       if (!ring->is_mes_queue)
> -               amdgpu_ib_free(&ib, NULL);
> +       amdgpu_ib_free(&ib, NULL);
>         dma_fence_put(f);
>  err1:
> -       if (!ring->is_mes_queue)
> -               amdgpu_device_wb_free(adev, index);
> +       amdgpu_device_wb_free(adev, index);
>         return r;
>  }
>
> @@ -5760,10 +5743,6 @@ static void gfx_v11_0_ring_emit_ib_gfx(struct amdg=
pu_ring *ring,
>                                     (!amdgpu_sriov_vf(ring->adev) && flag=
s & AMDGPU_IB_PREEMPTED) ? true : false);
>         }
>
> -       if (ring->is_mes_queue)
> -               /* inherit vmid from mqd */
> -               control |=3D 0x400000;
> -
>         amdgpu_ring_write(ring, header);
>         BUG_ON(ib->gpu_addr & 0x3); /* Dword align */
>         amdgpu_ring_write(ring,
> @@ -5783,10 +5762,6 @@ static void gfx_v11_0_ring_emit_ib_compute(struct =
amdgpu_ring *ring,
>         unsigned vmid =3D AMDGPU_JOB_GET_VMID(job);
>         u32 control =3D INDIRECT_BUFFER_VALID | ib->length_dw | (vmid << =
24);
>
> -       if (ring->is_mes_queue)
> -               /* inherit vmid from mqd */
> -               control |=3D 0x40000000;
> -
>         /* Currently, there is a high possibility to get wave ID mismatch
>          * between ME and GDS, leading to a hw deadlock, because ME gener=
ates
>          * different wave IDs than the GDS expects. This situation happen=
s
> @@ -5844,8 +5819,7 @@ static void gfx_v11_0_ring_emit_fence(struct amdgpu=
_ring *ring, u64 addr,
>         amdgpu_ring_write(ring, upper_32_bits(addr));
>         amdgpu_ring_write(ring, lower_32_bits(seq));
>         amdgpu_ring_write(ring, upper_32_bits(seq));
> -       amdgpu_ring_write(ring, ring->is_mes_queue ?
> -                        (ring->hw_queue_id | AMDGPU_FENCE_MES_QUEUE_FLAG=
) : 0);
> +       amdgpu_ring_write(ring, 0);
>  }
>
>  static void gfx_v11_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
> @@ -5873,10 +5847,7 @@ static void gfx_v11_0_ring_invalidate_tlbs(struct =
amdgpu_ring *ring,
>  static void gfx_v11_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
>                                          unsigned vmid, uint64_t pd_addr)
>  {
> -       if (ring->is_mes_queue)
> -               gfx_v11_0_ring_invalidate_tlbs(ring, 0, 0, false, 0);
> -       else
> -               amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
> +       amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
>
>         /* compute doesn't have PFP */
>         if (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_GFX) {
> @@ -6105,28 +6076,13 @@ static void gfx_v11_0_ring_emit_de_meta(struct am=
dgpu_ring *ring, bool resume)
>         void *de_payload_cpu_addr;
>         int cnt;
>
> -       if (ring->is_mes_queue) {
> -               offset =3D offsetof(struct amdgpu_mes_ctx_meta_data,
> -                                 gfx[0].gfx_meta_data) +
> -                       offsetof(struct v10_gfx_meta_data, de_payload);
> -               de_payload_gpu_addr =3D
> -                       amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
> -               de_payload_cpu_addr =3D
> -                       amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
> -
> -               offset =3D offsetof(struct amdgpu_mes_ctx_meta_data,
> -                                 gfx[0].gds_backup) +
> -                       offsetof(struct v10_gfx_meta_data, de_payload);
> -               gds_addr =3D amdgpu_mes_ctx_get_offs_gpu_addr(ring, offse=
t);
> -       } else {
> -               offset =3D offsetof(struct v10_gfx_meta_data, de_payload)=
;
> -               de_payload_gpu_addr =3D amdgpu_csa_vaddr(ring->adev) + of=
fset;
> -               de_payload_cpu_addr =3D adev->virt.csa_cpu_addr + offset;
> +       offset =3D offsetof(struct v10_gfx_meta_data, de_payload);
> +       de_payload_gpu_addr =3D amdgpu_csa_vaddr(ring->adev) + offset;
> +       de_payload_cpu_addr =3D adev->virt.csa_cpu_addr + offset;
>
> -               gds_addr =3D ALIGN(amdgpu_csa_vaddr(ring->adev) +
> -                                AMDGPU_CSA_SIZE - adev->gds.gds_size,
> -                                PAGE_SIZE);
> -       }
> +       gds_addr =3D ALIGN(amdgpu_csa_vaddr(ring->adev) +
> +                        AMDGPU_CSA_SIZE - adev->gds.gds_size,
> +                        PAGE_SIZE);
>
>         de_payload.gds_backup_addrlo =3D lower_32_bits(gds_addr);
>         de_payload.gds_backup_addrhi =3D upper_32_bits(gds_addr);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_0.c
> index 60d8630a05c82..9db2becab68fe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -477,33 +477,18 @@ static int gfx_v12_0_ring_test_ib(struct amdgpu_rin=
g *ring, long timeout)
>
>         memset(&ib, 0, sizeof(ib));
>
> -       if (ring->is_mes_queue) {
> -               uint32_t padding, offset;
> -
> -               offset =3D amdgpu_mes_ctx_get_offs(ring, AMDGPU_MES_CTX_I=
B_OFFS);
> -               padding =3D amdgpu_mes_ctx_get_offs(ring,
> -                                                 AMDGPU_MES_CTX_PADDING_=
OFFS);
> -
> -               ib.gpu_addr =3D amdgpu_mes_ctx_get_offs_gpu_addr(ring, of=
fset);
> -               ib.ptr =3D amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset)=
;
> -
> -               gpu_addr =3D amdgpu_mes_ctx_get_offs_gpu_addr(ring, paddi=
ng);
> -               cpu_ptr =3D amdgpu_mes_ctx_get_offs_cpu_addr(ring, paddin=
g);
> -               *cpu_ptr =3D cpu_to_le32(0xCAFEDEAD);
> -       } else {
> -               r =3D amdgpu_device_wb_get(adev, &index);
> -               if (r)
> -                       return r;
> +       r =3D amdgpu_device_wb_get(adev, &index);
> +       if (r)
> +               return r;
>
> -               gpu_addr =3D adev->wb.gpu_addr + (index * 4);
> -               adev->wb.wb[index] =3D cpu_to_le32(0xCAFEDEAD);
> -               cpu_ptr =3D &adev->wb.wb[index];
> +       gpu_addr =3D adev->wb.gpu_addr + (index * 4);
> +       adev->wb.wb[index] =3D cpu_to_le32(0xCAFEDEAD);
> +       cpu_ptr =3D &adev->wb.wb[index];
>
> -               r =3D amdgpu_ib_get(adev, NULL, 16, AMDGPU_IB_POOL_DIRECT=
, &ib);
> -               if (r) {
> -                       dev_err(adev->dev, "amdgpu: failed to get ib (%ld=
).\n", r);
> -                       goto err1;
> -               }
> +       r =3D amdgpu_ib_get(adev, NULL, 16, AMDGPU_IB_POOL_DIRECT, &ib);
> +       if (r) {
> +               dev_err(adev->dev, "amdgpu: failed to get ib (%ld).\n", r=
);
> +               goto err1;
>         }
>
>         ib.ptr[0] =3D PACKET3(PACKET3_WRITE_DATA, 3);
> @@ -530,12 +515,10 @@ static int gfx_v12_0_ring_test_ib(struct amdgpu_rin=
g *ring, long timeout)
>         else
>                 r =3D -EINVAL;
>  err2:
> -       if (!ring->is_mes_queue)
> -               amdgpu_ib_free(&ib, NULL);
> +       amdgpu_ib_free(&ib, NULL);
>         dma_fence_put(f);
>  err1:
> -       if (!ring->is_mes_queue)
> -               amdgpu_device_wb_free(adev, index);
> +       amdgpu_device_wb_free(adev, index);
>         return r;
>  }
>
> @@ -4283,45 +4266,17 @@ static u64 gfx_v12_0_ring_get_wptr_gfx(struct amd=
gpu_ring *ring)
>  static void gfx_v12_0_ring_set_wptr_gfx(struct amdgpu_ring *ring)
>  {
>         struct amdgpu_device *adev =3D ring->adev;
> -       uint32_t *wptr_saved;
> -       uint32_t *is_queue_unmap;
> -       uint64_t aggregated_db_index;
> -       uint32_t mqd_size =3D adev->mqds[AMDGPU_HW_IP_GFX].mqd_size;
> -       uint64_t wptr_tmp;
> -
> -       if (ring->is_mes_queue) {
> -               wptr_saved =3D (uint32_t *)(ring->mqd_ptr + mqd_size);
> -               is_queue_unmap =3D (uint32_t *)(ring->mqd_ptr + mqd_size =
+
> -                                             sizeof(uint32_t));
> -               aggregated_db_index =3D
> -                       amdgpu_mes_get_aggregated_doorbell_index(adev,
> -                                                                ring->hw=
_prio);
> -
> -               wptr_tmp =3D ring->wptr & ring->buf_mask;
> -               atomic64_set((atomic64_t *)ring->wptr_cpu_addr, wptr_tmp)=
;
> -               *wptr_saved =3D wptr_tmp;
> -               /* assume doorbell always being used by mes mapped queue =
*/
> -               if (*is_queue_unmap) {
> -                       WDOORBELL64(aggregated_db_index, wptr_tmp);
> -                       WDOORBELL64(ring->doorbell_index, wptr_tmp);
> -               } else {
> -                       WDOORBELL64(ring->doorbell_index, wptr_tmp);
>
> -                       if (*is_queue_unmap)
> -                               WDOORBELL64(aggregated_db_index, wptr_tmp=
);
> -               }
> +       if (ring->use_doorbell) {
> +               /* XXX check if swapping is necessary on BE */
> +               atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
> +                            ring->wptr);
> +               WDOORBELL64(ring->doorbell_index, ring->wptr);
>         } else {
> -               if (ring->use_doorbell) {
> -                       /* XXX check if swapping is necessary on BE */
> -                       atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
> -                                    ring->wptr);
> -                       WDOORBELL64(ring->doorbell_index, ring->wptr);
> -               } else {
> -                       WREG32_SOC15(GC, 0, regCP_RB0_WPTR,
> -                                    lower_32_bits(ring->wptr));
> -                       WREG32_SOC15(GC, 0, regCP_RB0_WPTR_HI,
> -                                    upper_32_bits(ring->wptr));
> -               }
> +               WREG32_SOC15(GC, 0, regCP_RB0_WPTR,
> +                            lower_32_bits(ring->wptr));
> +               WREG32_SOC15(GC, 0, regCP_RB0_WPTR_HI,
> +                            upper_32_bits(ring->wptr));
>         }
>  }
>
> @@ -4346,42 +4301,14 @@ static u64 gfx_v12_0_ring_get_wptr_compute(struct=
 amdgpu_ring *ring)
>  static void gfx_v12_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
>  {
>         struct amdgpu_device *adev =3D ring->adev;
> -       uint32_t *wptr_saved;
> -       uint32_t *is_queue_unmap;
> -       uint64_t aggregated_db_index;
> -       uint32_t mqd_size =3D adev->mqds[AMDGPU_HW_IP_COMPUTE].mqd_size;
> -       uint64_t wptr_tmp;
> -
> -       if (ring->is_mes_queue) {
> -               wptr_saved =3D (uint32_t *)(ring->mqd_ptr + mqd_size);
> -               is_queue_unmap =3D (uint32_t *)(ring->mqd_ptr + mqd_size =
+
> -                                             sizeof(uint32_t));
> -               aggregated_db_index =3D
> -                       amdgpu_mes_get_aggregated_doorbell_index(adev,
> -                                                                ring->hw=
_prio);
> -
> -               wptr_tmp =3D ring->wptr & ring->buf_mask;
> -               atomic64_set((atomic64_t *)ring->wptr_cpu_addr, wptr_tmp)=
;
> -               *wptr_saved =3D wptr_tmp;
> -               /* assume doorbell always used by mes mapped queue */
> -               if (*is_queue_unmap) {
> -                       WDOORBELL64(aggregated_db_index, wptr_tmp);
> -                       WDOORBELL64(ring->doorbell_index, wptr_tmp);
> -               } else {
> -                       WDOORBELL64(ring->doorbell_index, wptr_tmp);
>
> -                       if (*is_queue_unmap)
> -                               WDOORBELL64(aggregated_db_index, wptr_tmp=
);
> -               }
> +       /* XXX check if swapping is necessary on BE */
> +       if (ring->use_doorbell) {
> +               atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
> +                            ring->wptr);
> +               WDOORBELL64(ring->doorbell_index, ring->wptr);
>         } else {
> -               /* XXX check if swapping is necessary on BE */
> -               if (ring->use_doorbell) {
> -                       atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
> -                                    ring->wptr);
> -                       WDOORBELL64(ring->doorbell_index, ring->wptr);
> -               } else {
> -                       BUG(); /* only DOORBELL method supported on gfx12=
 now */
> -               }
> +               BUG(); /* only DOORBELL method supported on gfx12 now */
>         }
>  }
>
> @@ -4428,10 +4355,6 @@ static void gfx_v12_0_ring_emit_ib_gfx(struct amdg=
pu_ring *ring,
>
>         control |=3D ib->length_dw | (vmid << 24);
>
> -       if (ring->is_mes_queue)
> -               /* inherit vmid from mqd */
> -               control |=3D 0x400000;
> -
>         amdgpu_ring_write(ring, header);
>         BUG_ON(ib->gpu_addr & 0x3); /* Dword align */
>         amdgpu_ring_write(ring,
> @@ -4451,10 +4374,6 @@ static void gfx_v12_0_ring_emit_ib_compute(struct =
amdgpu_ring *ring,
>         unsigned vmid =3D AMDGPU_JOB_GET_VMID(job);
>         u32 control =3D INDIRECT_BUFFER_VALID | ib->length_dw | (vmid << =
24);
>
> -       if (ring->is_mes_queue)
> -               /* inherit vmid from mqd */
> -               control |=3D 0x40000000;
> -
>         amdgpu_ring_write(ring, PACKET3(PACKET3_INDIRECT_BUFFER, 2));
>         BUG_ON(ib->gpu_addr & 0x3); /* Dword align */
>         amdgpu_ring_write(ring,
> @@ -4494,8 +4413,7 @@ static void gfx_v12_0_ring_emit_fence(struct amdgpu=
_ring *ring, u64 addr,
>         amdgpu_ring_write(ring, upper_32_bits(addr));
>         amdgpu_ring_write(ring, lower_32_bits(seq));
>         amdgpu_ring_write(ring, upper_32_bits(seq));
> -       amdgpu_ring_write(ring, ring->is_mes_queue ?
> -                        (ring->hw_queue_id | AMDGPU_FENCE_MES_QUEUE_FLAG=
) : 0);
> +       amdgpu_ring_write(ring, 0);
>  }
>
>  static void gfx_v12_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
> @@ -4523,10 +4441,7 @@ static void gfx_v12_0_ring_invalidate_tlbs(struct =
amdgpu_ring *ring,
>  static void gfx_v12_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
>                                          unsigned vmid, uint64_t pd_addr)
>  {
> -       if (ring->is_mes_queue)
> -               gfx_v12_0_ring_invalidate_tlbs(ring, 0, 0, false, 0);
> -       else
> -               amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
> +       amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
>
>         /* compute doesn't have PFP */
>         if (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_GFX) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_0.c
> index 734f2dd986290..f4dfa1418b740 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -5472,16 +5472,8 @@ static void gfx_v9_0_ring_patch_ce_meta(struct amd=
gpu_ring *ring,
>
>         payload_size =3D sizeof(struct v9_ce_ib_state);
>
> -       if (ring->is_mes_queue) {
> -               payload_offset =3D offsetof(struct amdgpu_mes_ctx_meta_da=
ta,
> -                                         gfx[0].gfx_meta_data) +
> -                       offsetof(struct v9_gfx_meta_data, ce_payload);
> -               ce_payload_cpu_addr =3D
> -                       amdgpu_mes_ctx_get_offs_cpu_addr(ring, payload_of=
fset);
> -       } else {
> -               payload_offset =3D offsetof(struct v9_gfx_meta_data, ce_p=
ayload);
> -               ce_payload_cpu_addr =3D adev->virt.csa_cpu_addr + payload=
_offset;
> -       }
> +       payload_offset =3D offsetof(struct v9_gfx_meta_data, ce_payload);
> +       ce_payload_cpu_addr =3D adev->virt.csa_cpu_addr + payload_offset;
>
>         if (offset + (payload_size >> 2) <=3D ring->buf_mask + 1) {
>                 memcpy((void *)&ring->ring[offset], ce_payload_cpu_addr, =
payload_size);
> @@ -5504,16 +5496,8 @@ static void gfx_v9_0_ring_patch_de_meta(struct amd=
gpu_ring *ring,
>
>         payload_size =3D sizeof(struct v9_de_ib_state);
>
> -       if (ring->is_mes_queue) {
> -               payload_offset =3D offsetof(struct amdgpu_mes_ctx_meta_da=
ta,
> -                                         gfx[0].gfx_meta_data) +
> -                       offsetof(struct v9_gfx_meta_data, de_payload);
> -               de_payload_cpu_addr =3D
> -                       amdgpu_mes_ctx_get_offs_cpu_addr(ring, payload_of=
fset);
> -       } else {
> -               payload_offset =3D offsetof(struct v9_gfx_meta_data, de_p=
ayload);
> -               de_payload_cpu_addr =3D adev->virt.csa_cpu_addr + payload=
_offset;
> -       }
> +       payload_offset =3D offsetof(struct v9_gfx_meta_data, de_payload);
> +       de_payload_cpu_addr =3D adev->virt.csa_cpu_addr + payload_offset;
>
>         ((struct v9_de_ib_state *)de_payload_cpu_addr)->ib_completion_sta=
tus =3D
>                 IB_COMPLETION_STATUS_PREEMPTED;
> @@ -5703,19 +5687,9 @@ static void gfx_v9_0_ring_emit_ce_meta(struct amdg=
pu_ring *ring, bool resume)
>
>         cnt =3D (sizeof(ce_payload) >> 2) + 4 - 2;
>
> -       if (ring->is_mes_queue) {
> -               offset =3D offsetof(struct amdgpu_mes_ctx_meta_data,
> -                                 gfx[0].gfx_meta_data) +
> -                       offsetof(struct v9_gfx_meta_data, ce_payload);
> -               ce_payload_gpu_addr =3D
> -                       amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
> -               ce_payload_cpu_addr =3D
> -                       amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
> -       } else {
> -               offset =3D offsetof(struct v9_gfx_meta_data, ce_payload);
> -               ce_payload_gpu_addr =3D amdgpu_csa_vaddr(ring->adev) + of=
fset;
> -               ce_payload_cpu_addr =3D adev->virt.csa_cpu_addr + offset;
> -       }
> +       offset =3D offsetof(struct v9_gfx_meta_data, ce_payload);
> +       ce_payload_gpu_addr =3D amdgpu_csa_vaddr(ring->adev) + offset;
> +       ce_payload_cpu_addr =3D adev->virt.csa_cpu_addr + offset;
>
>         amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, cnt));
>         amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(2) |
> @@ -5801,28 +5775,13 @@ static void gfx_v9_0_ring_emit_de_meta(struct amd=
gpu_ring *ring, bool resume, bo
>         void *de_payload_cpu_addr;
>         int cnt;
>
> -       if (ring->is_mes_queue) {
> -               offset =3D offsetof(struct amdgpu_mes_ctx_meta_data,
> -                                 gfx[0].gfx_meta_data) +
> -                       offsetof(struct v9_gfx_meta_data, de_payload);
> -               de_payload_gpu_addr =3D
> -                       amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
> -               de_payload_cpu_addr =3D
> -                       amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
> -
> -               offset =3D offsetof(struct amdgpu_mes_ctx_meta_data,
> -                                 gfx[0].gds_backup) +
> -                       offsetof(struct v9_gfx_meta_data, de_payload);
> -               gds_addr =3D amdgpu_mes_ctx_get_offs_gpu_addr(ring, offse=
t);
> -       } else {
> -               offset =3D offsetof(struct v9_gfx_meta_data, de_payload);
> -               de_payload_gpu_addr =3D amdgpu_csa_vaddr(ring->adev) + of=
fset;
> -               de_payload_cpu_addr =3D adev->virt.csa_cpu_addr + offset;
> +       offset =3D offsetof(struct v9_gfx_meta_data, de_payload);
> +       de_payload_gpu_addr =3D amdgpu_csa_vaddr(ring->adev) + offset;
> +       de_payload_cpu_addr =3D adev->virt.csa_cpu_addr + offset;
>
> -               gds_addr =3D ALIGN(amdgpu_csa_vaddr(ring->adev) +
> -                                AMDGPU_CSA_SIZE - adev->gds.gds_size,
> -                                PAGE_SIZE);
> -       }
> +       gds_addr =3D ALIGN(amdgpu_csa_vaddr(ring->adev) +
> +                        AMDGPU_CSA_SIZE - adev->gds.gds_size,
> +                        PAGE_SIZE);
>
>         if (usegds) {
>                 de_payload.gds_backup_addrlo =3D lower_32_bits(gds_addr);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v10_0.c
> index 95d894a231fcf..8ae4c031162bc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -428,10 +428,6 @@ static void gmc_v10_0_emit_pasid_mapping(struct amdg=
pu_ring *ring, unsigned int
>         struct amdgpu_device *adev =3D ring->adev;
>         uint32_t reg;
>
> -       /* MES fw manages IH_VMID_x_LUT updating */
> -       if (ring->is_mes_queue)
> -               return;
> -
>         if (ring->vm_hub =3D=3D AMDGPU_GFXHUB(0))
>                 reg =3D SOC15_REG_OFFSET(OSSSYS, 0, mmIH_VMID_0_LUT) + vm=
id;
>         else
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v11_0.c
> index ad099f136f84e..5c91d4445418c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -393,10 +393,6 @@ static void gmc_v11_0_emit_pasid_mapping(struct amdg=
pu_ring *ring, unsigned int
>         struct amdgpu_device *adev =3D ring->adev;
>         uint32_t reg;
>
> -       /* MES fw manages IH_VMID_x_LUT updating */
> -       if (ring->is_mes_queue)
> -               return;
> -
>         if (ring->vm_hub =3D=3D AMDGPU_GFXHUB(0))
>                 reg =3D SOC15_REG_OFFSET(OSSSYS, 0, regIH_VMID_0_LUT) + v=
mid;
>         else
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v12_0.c
> index bf8d01da88154..0a1946c824118 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -413,10 +413,6 @@ static void gmc_v12_0_emit_pasid_mapping(struct amdg=
pu_ring *ring, unsigned vmid
>         struct amdgpu_device *adev =3D ring->adev;
>         uint32_t reg;
>
> -       /* MES fw manages IH_VMID_x_LUT updating */
> -       if (ring->is_mes_queue)
> -               return;
> -
>         if (ring->vm_hub =3D=3D AMDGPU_GFXHUB(0))
>                 reg =3D SOC15_REG_OFFSET(OSSSYS, 0, regIH_VMID_0_LUT) + v=
mid;
>         else
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v5_0.c
> index 44a401870509f..712392671a3cf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -369,67 +369,36 @@ static uint64_t sdma_v5_0_ring_get_wptr(struct amdg=
pu_ring *ring)
>  static void sdma_v5_0_ring_set_wptr(struct amdgpu_ring *ring)
>  {
>         struct amdgpu_device *adev =3D ring->adev;
> -       uint32_t *wptr_saved;
> -       uint32_t *is_queue_unmap;
> -       uint64_t aggregated_db_index;
> -       uint32_t mqd_size =3D adev->mqds[AMDGPU_HW_IP_DMA].mqd_size;
>
>         DRM_DEBUG("Setting write pointer\n");
> -       if (ring->is_mes_queue) {
> -               wptr_saved =3D (uint32_t *)(ring->mqd_ptr + mqd_size);
> -               is_queue_unmap =3D (uint32_t *)(ring->mqd_ptr + mqd_size =
+
> -                                             sizeof(uint32_t));
> -               aggregated_db_index =3D
> -                       amdgpu_mes_get_aggregated_doorbell_index(adev,
> -                       AMDGPU_MES_PRIORITY_LEVEL_NORMAL);
> -
> +       if (ring->use_doorbell) {
> +               DRM_DEBUG("Using doorbell -- "
> +                         "wptr_offs =3D=3D 0x%08x "
> +                         "lower_32_bits(ring->wptr) << 2 =3D=3D 0x%08x "
> +                         "upper_32_bits(ring->wptr) << 2 =3D=3D 0x%08x\n=
",
> +                         ring->wptr_offs,
> +                         lower_32_bits(ring->wptr << 2),
> +                         upper_32_bits(ring->wptr << 2));
> +               /* XXX check if swapping is necessary on BE */
>                 atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
>                              ring->wptr << 2);
> -               *wptr_saved =3D ring->wptr << 2;
> -               if (*is_queue_unmap) {
> -                       WDOORBELL64(aggregated_db_index, ring->wptr << 2)=
;
> -                       DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)=
\n",
> -                                       ring->doorbell_index, ring->wptr =
<< 2);
> -                       WDOORBELL64(ring->doorbell_index, ring->wptr << 2=
);
> -               } else {
> -                       DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)=
\n",
> -                                       ring->doorbell_index, ring->wptr =
<< 2);
> -                       WDOORBELL64(ring->doorbell_index, ring->wptr << 2=
);
> -
> -                       if (*is_queue_unmap)
> -                               WDOORBELL64(aggregated_db_index,
> -                                           ring->wptr << 2);
> -               }
> +               DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)\n",
> +                         ring->doorbell_index, ring->wptr << 2);
> +               WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
>         } else {
> -               if (ring->use_doorbell) {
> -                       DRM_DEBUG("Using doorbell -- "
> -                                 "wptr_offs =3D=3D 0x%08x "
> -                                 "lower_32_bits(ring->wptr) << 2 =3D=3D =
0x%08x "
> -                                 "upper_32_bits(ring->wptr) << 2 =3D=3D =
0x%08x\n",
> -                                 ring->wptr_offs,
> -                                 lower_32_bits(ring->wptr << 2),
> -                                 upper_32_bits(ring->wptr << 2));
> -                       /* XXX check if swapping is necessary on BE */
> -                       atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
> -                                    ring->wptr << 2);
> -                       DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)=
\n",
> -                                 ring->doorbell_index, ring->wptr << 2);
> -                       WDOORBELL64(ring->doorbell_index, ring->wptr << 2=
);
> -               } else {
> -                       DRM_DEBUG("Not using doorbell -- "
> -                                 "mmSDMA%i_GFX_RB_WPTR =3D=3D 0x%08x "
> -                                 "mmSDMA%i_GFX_RB_WPTR_HI =3D=3D 0x%08x\=
n",
> -                                 ring->me,
> -                                 lower_32_bits(ring->wptr << 2),
> -                                 ring->me,
> -                                 upper_32_bits(ring->wptr << 2));
> -                       WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev=
,
> -                                            ring->me, mmSDMA0_GFX_RB_WPT=
R),
> -                                       lower_32_bits(ring->wptr << 2));
> -                       WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev=
,
> -                                            ring->me, mmSDMA0_GFX_RB_WPT=
R_HI),
> -                                       upper_32_bits(ring->wptr << 2));
> -               }
> +               DRM_DEBUG("Not using doorbell -- "
> +                         "mmSDMA%i_GFX_RB_WPTR =3D=3D 0x%08x "
> +                         "mmSDMA%i_GFX_RB_WPTR_HI =3D=3D 0x%08x\n",
> +                         ring->me,
> +                         lower_32_bits(ring->wptr << 2),
> +                         ring->me,
> +                         upper_32_bits(ring->wptr << 2));
> +               WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev,
> +                                                            ring->me, mm=
SDMA0_GFX_RB_WPTR),
> +                               lower_32_bits(ring->wptr << 2));
> +               WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev,
> +                                                            ring->me, mm=
SDMA0_GFX_RB_WPTR_HI),
> +                               upper_32_bits(ring->wptr << 2));
>         }
>  }
>
> @@ -575,11 +544,9 @@ static void sdma_v5_0_ring_emit_fence(struct amdgpu_=
ring *ring, u64 addr, u64 se
>         }
>
>         if (flags & AMDGPU_FENCE_FLAG_INT) {
> -               uint32_t ctx =3D ring->is_mes_queue ?
> -                       (ring->hw_queue_id | AMDGPU_FENCE_MES_QUEUE_FLAG)=
 : 0;
>                 /* generate an interrupt */
>                 amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_TRAP))=
;
> -               amdgpu_ring_write(ring, SDMA_PKT_TRAP_INT_CONTEXT_INT_CON=
TEXT(ctx));
> +               amdgpu_ring_write(ring, SDMA_PKT_TRAP_INT_CONTEXT_INT_CON=
TEXT(0));
>         }
>  }
>
> @@ -1046,33 +1013,22 @@ static int sdma_v5_0_ring_test_ring(struct amdgpu=
_ring *ring)
>         int r;
>         u32 tmp;
>         u64 gpu_addr;
> -       volatile uint32_t *cpu_ptr =3D NULL;
>
>         tmp =3D 0xCAFEDEAD;
>
> -       if (ring->is_mes_queue) {
> -               uint32_t offset =3D 0;
> -               offset =3D amdgpu_mes_ctx_get_offs(ring,
> -                                        AMDGPU_MES_CTX_PADDING_OFFS);
> -               gpu_addr =3D amdgpu_mes_ctx_get_offs_gpu_addr(ring, offse=
t);
> -               cpu_ptr =3D amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset=
);
> -               *cpu_ptr =3D tmp;
> -       } else {
> -               r =3D amdgpu_device_wb_get(adev, &index);
> -               if (r) {
> -                       dev_err(adev->dev, "(%d) failed to allocate wb sl=
ot\n", r);
> -                       return r;
> -               }
> -
> -               gpu_addr =3D adev->wb.gpu_addr + (index * 4);
> -               adev->wb.wb[index] =3D cpu_to_le32(tmp);
> +       r =3D amdgpu_device_wb_get(adev, &index);
> +       if (r) {
> +               dev_err(adev->dev, "(%d) failed to allocate wb slot\n", r=
);
> +               return r;
>         }
>
> +       gpu_addr =3D adev->wb.gpu_addr + (index * 4);
> +       adev->wb.wb[index] =3D cpu_to_le32(tmp);
> +
>         r =3D amdgpu_ring_alloc(ring, 20);
>         if (r) {
>                 DRM_ERROR("amdgpu: dma failed to lock ring %d (%d).\n", r=
ing->idx, r);
> -               if (!ring->is_mes_queue)
> -                       amdgpu_device_wb_free(adev, index);
> +               amdgpu_device_wb_free(adev, index);
>                 return r;
>         }
>
> @@ -1085,10 +1041,7 @@ static int sdma_v5_0_ring_test_ring(struct amdgpu_=
ring *ring)
>         amdgpu_ring_commit(ring);
>
>         for (i =3D 0; i < adev->usec_timeout; i++) {
> -               if (ring->is_mes_queue)
> -                       tmp =3D le32_to_cpu(*cpu_ptr);
> -               else
> -                       tmp =3D le32_to_cpu(adev->wb.wb[index]);
> +               tmp =3D le32_to_cpu(adev->wb.wb[index]);
>                 if (tmp =3D=3D 0xDEADBEEF)
>                         break;
>                 if (amdgpu_emu_mode =3D=3D 1)
> @@ -1100,8 +1053,7 @@ static int sdma_v5_0_ring_test_ring(struct amdgpu_r=
ing *ring)
>         if (i >=3D adev->usec_timeout)
>                 r =3D -ETIMEDOUT;
>
> -       if (!ring->is_mes_queue)
> -               amdgpu_device_wb_free(adev, index);
> +       amdgpu_device_wb_free(adev, index);
>
>         return r;
>  }
> @@ -1124,38 +1076,24 @@ static int sdma_v5_0_ring_test_ib(struct amdgpu_r=
ing *ring, long timeout)
>         long r;
>         u32 tmp =3D 0;
>         u64 gpu_addr;
> -       volatile uint32_t *cpu_ptr =3D NULL;
>
>         tmp =3D 0xCAFEDEAD;
>         memset(&ib, 0, sizeof(ib));
>
> -       if (ring->is_mes_queue) {
> -               uint32_t offset =3D 0;
> -               offset =3D amdgpu_mes_ctx_get_offs(ring, AMDGPU_MES_CTX_I=
B_OFFS);
> -               ib.gpu_addr =3D amdgpu_mes_ctx_get_offs_gpu_addr(ring, of=
fset);
> -               ib.ptr =3D (void *)amdgpu_mes_ctx_get_offs_cpu_addr(ring,=
 offset);
> -
> -               offset =3D amdgpu_mes_ctx_get_offs(ring,
> -                                        AMDGPU_MES_CTX_PADDING_OFFS);
> -               gpu_addr =3D amdgpu_mes_ctx_get_offs_gpu_addr(ring, offse=
t);
> -               cpu_ptr =3D amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset=
);
> -               *cpu_ptr =3D tmp;
> -       } else {
> -               r =3D amdgpu_device_wb_get(adev, &index);
> -               if (r) {
> -                       dev_err(adev->dev, "(%ld) failed to allocate wb s=
lot\n", r);
> -                       return r;
> -               }
> +       r =3D amdgpu_device_wb_get(adev, &index);
> +       if (r) {
> +               dev_err(adev->dev, "(%ld) failed to allocate wb slot\n", =
r);
> +               return r;
> +       }
>
> -               gpu_addr =3D adev->wb.gpu_addr + (index * 4);
> -               adev->wb.wb[index] =3D cpu_to_le32(tmp);
> +       gpu_addr =3D adev->wb.gpu_addr + (index * 4);
> +       adev->wb.wb[index] =3D cpu_to_le32(tmp);
>
> -               r =3D amdgpu_ib_get(adev, NULL, 256,
> -                                       AMDGPU_IB_POOL_DIRECT, &ib);
> -               if (r) {
> -                       DRM_ERROR("amdgpu: failed to get ib (%ld).\n", r)=
;
> -                       goto err0;
> -               }
> +       r =3D amdgpu_ib_get(adev, NULL, 256,
> +                         AMDGPU_IB_POOL_DIRECT, &ib);
> +       if (r) {
> +               DRM_ERROR("amdgpu: failed to get ib (%ld).\n", r);
> +               goto err0;
>         }
>
>         ib.ptr[0] =3D SDMA_PKT_HEADER_OP(SDMA_OP_WRITE) |
> @@ -1183,10 +1121,7 @@ static int sdma_v5_0_ring_test_ib(struct amdgpu_ri=
ng *ring, long timeout)
>                 goto err1;
>         }
>
> -       if (ring->is_mes_queue)
> -               tmp =3D le32_to_cpu(*cpu_ptr);
> -       else
> -               tmp =3D le32_to_cpu(adev->wb.wb[index]);
> +       tmp =3D le32_to_cpu(adev->wb.wb[index]);
>
>         if (tmp =3D=3D 0xDEADBEEF)
>                 r =3D 0;
> @@ -1197,8 +1132,7 @@ static int sdma_v5_0_ring_test_ib(struct amdgpu_rin=
g *ring, long timeout)
>         amdgpu_ib_free(&ib, NULL);
>         dma_fence_put(f);
>  err0:
> -       if (!ring->is_mes_queue)
> -               amdgpu_device_wb_free(adev, index);
> +       amdgpu_device_wb_free(adev, index);
>         return r;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v5_2.c
> index cb2a3e5592855..2c0bf2fc6d380 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -394,11 +394,9 @@ static void sdma_v5_2_ring_emit_fence(struct amdgpu_=
ring *ring, u64 addr, u64 se
>         }
>
>         if ((flags & AMDGPU_FENCE_FLAG_INT)) {
> -               uint32_t ctx =3D ring->is_mes_queue ?
> -                       (ring->hw_queue_id | AMDGPU_FENCE_MES_QUEUE_FLAG)=
 : 0;
>                 /* generate an interrupt */
>                 amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_TRAP))=
;
> -               amdgpu_ring_write(ring, SDMA_PKT_TRAP_INT_CONTEXT_INT_CON=
TEXT(ctx));
> +               amdgpu_ring_write(ring, SDMA_PKT_TRAP_INT_CONTEXT_INT_CON=
TEXT(0));
>         }
>  }
>
> @@ -903,33 +901,22 @@ static int sdma_v5_2_ring_test_ring(struct amdgpu_r=
ing *ring)
>         int r;
>         u32 tmp;
>         u64 gpu_addr;
> -       volatile uint32_t *cpu_ptr =3D NULL;
>
>         tmp =3D 0xCAFEDEAD;
>
> -       if (ring->is_mes_queue) {
> -               uint32_t offset =3D 0;
> -               offset =3D amdgpu_mes_ctx_get_offs(ring,
> -                                        AMDGPU_MES_CTX_PADDING_OFFS);
> -               gpu_addr =3D amdgpu_mes_ctx_get_offs_gpu_addr(ring, offse=
t);
> -               cpu_ptr =3D amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset=
);
> -               *cpu_ptr =3D tmp;
> -       } else {
> -               r =3D amdgpu_device_wb_get(adev, &index);
> -               if (r) {
> -                       dev_err(adev->dev, "(%d) failed to allocate wb sl=
ot\n", r);
> -                       return r;
> -               }
> -
> -               gpu_addr =3D adev->wb.gpu_addr + (index * 4);
> -               adev->wb.wb[index] =3D cpu_to_le32(tmp);
> +       r =3D amdgpu_device_wb_get(adev, &index);
> +       if (r) {
> +               dev_err(adev->dev, "(%d) failed to allocate wb slot\n", r=
);
> +               return r;
>         }
>
> +       gpu_addr =3D adev->wb.gpu_addr + (index * 4);
> +       adev->wb.wb[index] =3D cpu_to_le32(tmp);
> +
>         r =3D amdgpu_ring_alloc(ring, 20);
>         if (r) {
>                 DRM_ERROR("amdgpu: dma failed to lock ring %d (%d).\n", r=
ing->idx, r);
> -               if (!ring->is_mes_queue)
> -                       amdgpu_device_wb_free(adev, index);
> +               amdgpu_device_wb_free(adev, index);
>                 return r;
>         }
>
> @@ -942,10 +929,7 @@ static int sdma_v5_2_ring_test_ring(struct amdgpu_ri=
ng *ring)
>         amdgpu_ring_commit(ring);
>
>         for (i =3D 0; i < adev->usec_timeout; i++) {
> -               if (ring->is_mes_queue)
> -                       tmp =3D le32_to_cpu(*cpu_ptr);
> -               else
> -                       tmp =3D le32_to_cpu(adev->wb.wb[index]);
> +               tmp =3D le32_to_cpu(adev->wb.wb[index]);
>                 if (tmp =3D=3D 0xDEADBEEF)
>                         break;
>                 if (amdgpu_emu_mode =3D=3D 1)
> @@ -957,8 +941,7 @@ static int sdma_v5_2_ring_test_ring(struct amdgpu_rin=
g *ring)
>         if (i >=3D adev->usec_timeout)
>                 r =3D -ETIMEDOUT;
>
> -       if (!ring->is_mes_queue)
> -               amdgpu_device_wb_free(adev, index);
> +       amdgpu_device_wb_free(adev, index);
>
>         return r;
>  }
> @@ -981,37 +964,23 @@ static int sdma_v5_2_ring_test_ib(struct amdgpu_rin=
g *ring, long timeout)
>         long r;
>         u32 tmp =3D 0;
>         u64 gpu_addr;
> -       volatile uint32_t *cpu_ptr =3D NULL;
>
>         tmp =3D 0xCAFEDEAD;
>         memset(&ib, 0, sizeof(ib));
>
> -       if (ring->is_mes_queue) {
> -               uint32_t offset =3D 0;
> -               offset =3D amdgpu_mes_ctx_get_offs(ring, AMDGPU_MES_CTX_I=
B_OFFS);
> -               ib.gpu_addr =3D amdgpu_mes_ctx_get_offs_gpu_addr(ring, of=
fset);
> -               ib.ptr =3D (void *)amdgpu_mes_ctx_get_offs_cpu_addr(ring,=
 offset);
> -
> -               offset =3D amdgpu_mes_ctx_get_offs(ring,
> -                                        AMDGPU_MES_CTX_PADDING_OFFS);
> -               gpu_addr =3D amdgpu_mes_ctx_get_offs_gpu_addr(ring, offse=
t);
> -               cpu_ptr =3D amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset=
);
> -               *cpu_ptr =3D tmp;
> -       } else {
> -               r =3D amdgpu_device_wb_get(adev, &index);
> -               if (r) {
> -                       dev_err(adev->dev, "(%ld) failed to allocate wb s=
lot\n", r);
> -                       return r;
> -               }
> +       r =3D amdgpu_device_wb_get(adev, &index);
> +       if (r) {
> +               dev_err(adev->dev, "(%ld) failed to allocate wb slot\n", =
r);
> +               return r;
> +       }
>
> -               gpu_addr =3D adev->wb.gpu_addr + (index * 4);
> -               adev->wb.wb[index] =3D cpu_to_le32(tmp);
> +       gpu_addr =3D adev->wb.gpu_addr + (index * 4);
> +       adev->wb.wb[index] =3D cpu_to_le32(tmp);
>
> -               r =3D amdgpu_ib_get(adev, NULL, 256, AMDGPU_IB_POOL_DIREC=
T, &ib);
> -               if (r) {
> -                       DRM_ERROR("amdgpu: failed to get ib (%ld).\n", r)=
;
> -                       goto err0;
> -               }
> +       r =3D amdgpu_ib_get(adev, NULL, 256, AMDGPU_IB_POOL_DIRECT, &ib);
> +       if (r) {
> +               DRM_ERROR("amdgpu: failed to get ib (%ld).\n", r);
> +               goto err0;
>         }
>
>         ib.ptr[0] =3D SDMA_PKT_HEADER_OP(SDMA_OP_WRITE) |
> @@ -1039,10 +1008,7 @@ static int sdma_v5_2_ring_test_ib(struct amdgpu_ri=
ng *ring, long timeout)
>                 goto err1;
>         }
>
> -       if (ring->is_mes_queue)
> -               tmp =3D le32_to_cpu(*cpu_ptr);
> -       else
> -               tmp =3D le32_to_cpu(adev->wb.wb[index]);
> +       tmp =3D le32_to_cpu(adev->wb.wb[index]);
>
>         if (tmp =3D=3D 0xDEADBEEF)
>                 r =3D 0;
> @@ -1053,8 +1019,7 @@ static int sdma_v5_2_ring_test_ib(struct amdgpu_rin=
g *ring, long timeout)
>         amdgpu_ib_free(&ib, NULL);
>         dma_fence_put(f);
>  err0:
> -       if (!ring->is_mes_queue)
> -               amdgpu_device_wb_free(adev, index);
> +       amdgpu_device_wb_free(adev, index);
>         return r;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v6_0.c
> index f1a02ce844e0f..d0f7874730f06 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -377,11 +377,9 @@ static void sdma_v6_0_ring_emit_fence(struct amdgpu_=
ring *ring, u64 addr, u64 se
>         }
>
>         if (flags & AMDGPU_FENCE_FLAG_INT) {
> -               uint32_t ctx =3D ring->is_mes_queue ?
> -                       (ring->hw_queue_id | AMDGPU_FENCE_MES_QUEUE_FLAG)=
 : 0;
>                 /* generate an interrupt */
>                 amdgpu_ring_write(ring, SDMA_PKT_COPY_LINEAR_HEADER_OP(SD=
MA_OP_TRAP));
> -               amdgpu_ring_write(ring, SDMA_PKT_TRAP_INT_CONTEXT_INT_CON=
TEXT(ctx));
> +               amdgpu_ring_write(ring, SDMA_PKT_TRAP_INT_CONTEXT_INT_CON=
TEXT(0));
>         }
>  }
>
> @@ -921,33 +919,22 @@ static int sdma_v6_0_ring_test_ring(struct amdgpu_r=
ing *ring)
>         int r;
>         u32 tmp;
>         u64 gpu_addr;
> -       volatile uint32_t *cpu_ptr =3D NULL;
>
>         tmp =3D 0xCAFEDEAD;
>
> -       if (ring->is_mes_queue) {
> -               uint32_t offset =3D 0;
> -               offset =3D amdgpu_mes_ctx_get_offs(ring,
> -                                        AMDGPU_MES_CTX_PADDING_OFFS);
> -               gpu_addr =3D amdgpu_mes_ctx_get_offs_gpu_addr(ring, offse=
t);
> -               cpu_ptr =3D amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset=
);
> -               *cpu_ptr =3D tmp;
> -       } else {
> -               r =3D amdgpu_device_wb_get(adev, &index);
> -               if (r) {
> -                       dev_err(adev->dev, "(%d) failed to allocate wb sl=
ot\n", r);
> -                       return r;
> -               }
> -
> -               gpu_addr =3D adev->wb.gpu_addr + (index * 4);
> -               adev->wb.wb[index] =3D cpu_to_le32(tmp);
> +       r =3D amdgpu_device_wb_get(adev, &index);
> +       if (r) {
> +               dev_err(adev->dev, "(%d) failed to allocate wb slot\n", r=
);
> +               return r;
>         }
>
> +       gpu_addr =3D adev->wb.gpu_addr + (index * 4);
> +       adev->wb.wb[index] =3D cpu_to_le32(tmp);
> +
>         r =3D amdgpu_ring_alloc(ring, 5);
>         if (r) {
>                 DRM_ERROR("amdgpu: dma failed to lock ring %d (%d).\n", r=
ing->idx, r);
> -               if (!ring->is_mes_queue)
> -                       amdgpu_device_wb_free(adev, index);
> +               amdgpu_device_wb_free(adev, index);
>                 return r;
>         }
>
> @@ -960,10 +947,7 @@ static int sdma_v6_0_ring_test_ring(struct amdgpu_ri=
ng *ring)
>         amdgpu_ring_commit(ring);
>
>         for (i =3D 0; i < adev->usec_timeout; i++) {
> -               if (ring->is_mes_queue)
> -                       tmp =3D le32_to_cpu(*cpu_ptr);
> -               else
> -                       tmp =3D le32_to_cpu(adev->wb.wb[index]);
> +               tmp =3D le32_to_cpu(adev->wb.wb[index]);
>                 if (tmp =3D=3D 0xDEADBEEF)
>                         break;
>                 if (amdgpu_emu_mode =3D=3D 1)
> @@ -975,8 +959,7 @@ static int sdma_v6_0_ring_test_ring(struct amdgpu_rin=
g *ring)
>         if (i >=3D adev->usec_timeout)
>                 r =3D -ETIMEDOUT;
>
> -       if (!ring->is_mes_queue)
> -               amdgpu_device_wb_free(adev, index);
> +       amdgpu_device_wb_free(adev, index);
>
>         return r;
>  }
> @@ -999,37 +982,23 @@ static int sdma_v6_0_ring_test_ib(struct amdgpu_rin=
g *ring, long timeout)
>         long r;
>         u32 tmp =3D 0;
>         u64 gpu_addr;
> -       volatile uint32_t *cpu_ptr =3D NULL;
>
>         tmp =3D 0xCAFEDEAD;
>         memset(&ib, 0, sizeof(ib));
>
> -       if (ring->is_mes_queue) {
> -               uint32_t offset =3D 0;
> -               offset =3D amdgpu_mes_ctx_get_offs(ring, AMDGPU_MES_CTX_I=
B_OFFS);
> -               ib.gpu_addr =3D amdgpu_mes_ctx_get_offs_gpu_addr(ring, of=
fset);
> -               ib.ptr =3D (void *)amdgpu_mes_ctx_get_offs_cpu_addr(ring,=
 offset);
> -
> -               offset =3D amdgpu_mes_ctx_get_offs(ring,
> -                                        AMDGPU_MES_CTX_PADDING_OFFS);
> -               gpu_addr =3D amdgpu_mes_ctx_get_offs_gpu_addr(ring, offse=
t);
> -               cpu_ptr =3D amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset=
);
> -               *cpu_ptr =3D tmp;
> -       } else {
> -               r =3D amdgpu_device_wb_get(adev, &index);
> -               if (r) {
> -                       dev_err(adev->dev, "(%ld) failed to allocate wb s=
lot\n", r);
> -                       return r;
> -               }
> +       r =3D amdgpu_device_wb_get(adev, &index);
> +       if (r) {
> +               dev_err(adev->dev, "(%ld) failed to allocate wb slot\n", =
r);
> +               return r;
> +       }
>
> -               gpu_addr =3D adev->wb.gpu_addr + (index * 4);
> -               adev->wb.wb[index] =3D cpu_to_le32(tmp);
> +       gpu_addr =3D adev->wb.gpu_addr + (index * 4);
> +       adev->wb.wb[index] =3D cpu_to_le32(tmp);
>
> -               r =3D amdgpu_ib_get(adev, NULL, 256, AMDGPU_IB_POOL_DIREC=
T, &ib);
> -               if (r) {
> -                       DRM_ERROR("amdgpu: failed to get ib (%ld).\n", r)=
;
> -                       goto err0;
> -               }
> +       r =3D amdgpu_ib_get(adev, NULL, 256, AMDGPU_IB_POOL_DIRECT, &ib);
> +       if (r) {
> +               DRM_ERROR("amdgpu: failed to get ib (%ld).\n", r);
> +               goto err0;
>         }
>
>         ib.ptr[0] =3D SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_WRITE) |
> @@ -1057,10 +1026,7 @@ static int sdma_v6_0_ring_test_ib(struct amdgpu_ri=
ng *ring, long timeout)
>                 goto err1;
>         }
>
> -       if (ring->is_mes_queue)
> -               tmp =3D le32_to_cpu(*cpu_ptr);
> -       else
> -               tmp =3D le32_to_cpu(adev->wb.wb[index]);
> +       tmp =3D le32_to_cpu(adev->wb.wb[index]);
>
>         if (tmp =3D=3D 0xDEADBEEF)
>                 r =3D 0;
> @@ -1071,8 +1037,7 @@ static int sdma_v6_0_ring_test_ib(struct amdgpu_rin=
g *ring, long timeout)
>         amdgpu_ib_free(&ib, NULL);
>         dma_fence_put(f);
>  err0:
> -       if (!ring->is_mes_queue)
> -               amdgpu_device_wb_free(adev, index);
> +       amdgpu_device_wb_free(adev, index);
>         return r;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v7_0.c
> index f10de8e2fcae2..7a788da2ef5d7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> @@ -205,66 +205,39 @@ static uint64_t sdma_v7_0_ring_get_wptr(struct amdg=
pu_ring *ring)
>  static void sdma_v7_0_ring_set_wptr(struct amdgpu_ring *ring)
>  {
>         struct amdgpu_device *adev =3D ring->adev;
> -       uint32_t *wptr_saved;
> -       uint32_t *is_queue_unmap;
> -       uint64_t aggregated_db_index;
> -       uint32_t mqd_size =3D adev->mqds[AMDGPU_HW_IP_DMA].mqd_size;
>
>         DRM_DEBUG("Setting write pointer\n");
>
> -       if (ring->is_mes_queue) {
> -               wptr_saved =3D (uint32_t *)(ring->mqd_ptr + mqd_size);
> -               is_queue_unmap =3D (uint32_t *)(ring->mqd_ptr + mqd_size =
+
> -                                             sizeof(uint32_t));
> -               aggregated_db_index =3D
> -                       amdgpu_mes_get_aggregated_doorbell_index(adev,
> -                                                        ring->hw_prio);
> -
> +       if (ring->use_doorbell) {
> +               DRM_DEBUG("Using doorbell -- "
> +                         "wptr_offs =3D=3D 0x%08x "
> +                         "lower_32_bits(ring->wptr) << 2 =3D=3D 0x%08x "
> +                         "upper_32_bits(ring->wptr) << 2 =3D=3D 0x%08x\n=
",
> +                         ring->wptr_offs,
> +                         lower_32_bits(ring->wptr << 2),
> +                         upper_32_bits(ring->wptr << 2));
> +               /* XXX check if swapping is necessary on BE */
>                 atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
>                              ring->wptr << 2);
> -               *wptr_saved =3D ring->wptr << 2;
> -               if (*is_queue_unmap) {
> -                       WDOORBELL64(aggregated_db_index, ring->wptr << 2)=
;
> -                       DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)=
\n",
> -                                       ring->doorbell_index, ring->wptr =
<< 2);
> -                       WDOORBELL64(ring->doorbell_index, ring->wptr << 2=
);
> -               } else {
> -                       DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)=
\n",
> -                                       ring->doorbell_index, ring->wptr =
<< 2);
> -                       WDOORBELL64(ring->doorbell_index, ring->wptr << 2=
);
> -               }
> +               DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)\n",
> +                         ring->doorbell_index, ring->wptr << 2);
> +               WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
>         } else {
> -               if (ring->use_doorbell) {
> -                       DRM_DEBUG("Using doorbell -- "
> -                                 "wptr_offs =3D=3D 0x%08x "
> -                                 "lower_32_bits(ring->wptr) << 2 =3D=3D =
0x%08x "
> -                                 "upper_32_bits(ring->wptr) << 2 =3D=3D =
0x%08x\n",
> -                                 ring->wptr_offs,
> -                                 lower_32_bits(ring->wptr << 2),
> -                                 upper_32_bits(ring->wptr << 2));
> -                       /* XXX check if swapping is necessary on BE */
> -                       atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
> -                                    ring->wptr << 2);
> -                       DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)=
\n",
> -                                 ring->doorbell_index, ring->wptr << 2);
> -                       WDOORBELL64(ring->doorbell_index, ring->wptr << 2=
);
> -               } else {
> -                       DRM_DEBUG("Not using doorbell -- "
> -                                 "regSDMA%i_GFX_RB_WPTR =3D=3D 0x%08x "
> -                                 "regSDMA%i_GFX_RB_WPTR_HI =3D=3D 0x%08x=
\n",
> -                                 ring->me,
> -                                 lower_32_bits(ring->wptr << 2),
> -                                 ring->me,
> -                                 upper_32_bits(ring->wptr << 2));
> -                       WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev=
,
> -                                                                    ring=
->me,
> -                                                                    regS=
DMA0_QUEUE0_RB_WPTR),
> -                                       lower_32_bits(ring->wptr << 2));
> -                       WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev=
,
> -                                                                    ring=
->me,
> -                                                                    regS=
DMA0_QUEUE0_RB_WPTR_HI),
> -                                       upper_32_bits(ring->wptr << 2));
> -               }
> +               DRM_DEBUG("Not using doorbell -- "
> +                         "regSDMA%i_GFX_RB_WPTR =3D=3D 0x%08x "
> +                         "regSDMA%i_GFX_RB_WPTR_HI =3D=3D 0x%08x\n",
> +                         ring->me,
> +                         lower_32_bits(ring->wptr << 2),
> +                         ring->me,
> +                         upper_32_bits(ring->wptr << 2));
> +               WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev,
> +                                                            ring->me,
> +                                                            regSDMA0_QUE=
UE0_RB_WPTR),
> +                               lower_32_bits(ring->wptr << 2));
> +               WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev,
> +                                                            ring->me,
> +                                                            regSDMA0_QUE=
UE0_RB_WPTR_HI),
> +                               upper_32_bits(ring->wptr << 2));
>         }
>  }
>
> @@ -408,11 +381,9 @@ static void sdma_v7_0_ring_emit_fence(struct amdgpu_=
ring *ring, u64 addr, u64 se
>         }
>
>         if (flags & AMDGPU_FENCE_FLAG_INT) {
> -               uint32_t ctx =3D ring->is_mes_queue ?
> -                       (ring->hw_queue_id | AMDGPU_FENCE_MES_QUEUE_FLAG)=
 : 0;
>                 /* generate an interrupt */
>                 amdgpu_ring_write(ring, SDMA_PKT_COPY_LINEAR_HEADER_OP(SD=
MA_OP_TRAP));
> -               amdgpu_ring_write(ring, SDMA_PKT_TRAP_INT_CONTEXT_INT_CON=
TEXT(ctx));
> +               amdgpu_ring_write(ring, SDMA_PKT_TRAP_INT_CONTEXT_INT_CON=
TEXT(0));
>         }
>  }
>
> @@ -965,33 +936,22 @@ static int sdma_v7_0_ring_test_ring(struct amdgpu_r=
ing *ring)
>         int r;
>         u32 tmp;
>         u64 gpu_addr;
> -       volatile uint32_t *cpu_ptr =3D NULL;
>
>         tmp =3D 0xCAFEDEAD;
>
> -       if (ring->is_mes_queue) {
> -               uint32_t offset =3D 0;
> -               offset =3D amdgpu_mes_ctx_get_offs(ring,
> -                                        AMDGPU_MES_CTX_PADDING_OFFS);
> -               gpu_addr =3D amdgpu_mes_ctx_get_offs_gpu_addr(ring, offse=
t);
> -               cpu_ptr =3D amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset=
);
> -               *cpu_ptr =3D tmp;
> -       } else {
> -               r =3D amdgpu_device_wb_get(adev, &index);
> -               if (r) {
> -                       dev_err(adev->dev, "(%d) failed to allocate wb sl=
ot\n", r);
> -                       return r;
> -               }
> -
> -               gpu_addr =3D adev->wb.gpu_addr + (index * 4);
> -               adev->wb.wb[index] =3D cpu_to_le32(tmp);
> +       r =3D amdgpu_device_wb_get(adev, &index);
> +       if (r) {
> +               dev_err(adev->dev, "(%d) failed to allocate wb slot\n", r=
);
> +               return r;
>         }
>
> +       gpu_addr =3D adev->wb.gpu_addr + (index * 4);
> +       adev->wb.wb[index] =3D cpu_to_le32(tmp);
> +
>         r =3D amdgpu_ring_alloc(ring, 5);
>         if (r) {
>                 DRM_ERROR("amdgpu: dma failed to lock ring %d (%d).\n", r=
ing->idx, r);
> -               if (!ring->is_mes_queue)
> -                       amdgpu_device_wb_free(adev, index);
> +               amdgpu_device_wb_free(adev, index);
>                 return r;
>         }
>
> @@ -1004,10 +964,7 @@ static int sdma_v7_0_ring_test_ring(struct amdgpu_r=
ing *ring)
>         amdgpu_ring_commit(ring);
>
>         for (i =3D 0; i < adev->usec_timeout; i++) {
> -               if (ring->is_mes_queue)
> -                       tmp =3D le32_to_cpu(*cpu_ptr);
> -               else
> -                       tmp =3D le32_to_cpu(adev->wb.wb[index]);
> +               tmp =3D le32_to_cpu(adev->wb.wb[index]);
>                 if (tmp =3D=3D 0xDEADBEEF)
>                         break;
>                 if (amdgpu_emu_mode =3D=3D 1)
> @@ -1019,8 +976,7 @@ static int sdma_v7_0_ring_test_ring(struct amdgpu_ri=
ng *ring)
>         if (i >=3D adev->usec_timeout)
>                 r =3D -ETIMEDOUT;
>
> -       if (!ring->is_mes_queue)
> -               amdgpu_device_wb_free(adev, index);
> +       amdgpu_device_wb_free(adev, index);
>
>         return r;
>  }
> @@ -1043,37 +999,23 @@ static int sdma_v7_0_ring_test_ib(struct amdgpu_ri=
ng *ring, long timeout)
>         long r;
>         u32 tmp =3D 0;
>         u64 gpu_addr;
> -       volatile uint32_t *cpu_ptr =3D NULL;
>
>         tmp =3D 0xCAFEDEAD;
>         memset(&ib, 0, sizeof(ib));
>
> -       if (ring->is_mes_queue) {
> -               uint32_t offset =3D 0;
> -               offset =3D amdgpu_mes_ctx_get_offs(ring, AMDGPU_MES_CTX_I=
B_OFFS);
> -               ib.gpu_addr =3D amdgpu_mes_ctx_get_offs_gpu_addr(ring, of=
fset);
> -               ib.ptr =3D (void *)amdgpu_mes_ctx_get_offs_cpu_addr(ring,=
 offset);
> -
> -               offset =3D amdgpu_mes_ctx_get_offs(ring,
> -                                        AMDGPU_MES_CTX_PADDING_OFFS);
> -               gpu_addr =3D amdgpu_mes_ctx_get_offs_gpu_addr(ring, offse=
t);
> -               cpu_ptr =3D amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset=
);
> -               *cpu_ptr =3D tmp;
> -       } else {
> -               r =3D amdgpu_device_wb_get(adev, &index);
> -               if (r) {
> -                       dev_err(adev->dev, "(%ld) failed to allocate wb s=
lot\n", r);
> -                       return r;
> -               }
> +       r =3D amdgpu_device_wb_get(adev, &index);
> +       if (r) {
> +               dev_err(adev->dev, "(%ld) failed to allocate wb slot\n", =
r);
> +               return r;
> +       }
>
> -               gpu_addr =3D adev->wb.gpu_addr + (index * 4);
> -               adev->wb.wb[index] =3D cpu_to_le32(tmp);
> +       gpu_addr =3D adev->wb.gpu_addr + (index * 4);
> +       adev->wb.wb[index] =3D cpu_to_le32(tmp);
>
> -               r =3D amdgpu_ib_get(adev, NULL, 256, AMDGPU_IB_POOL_DIREC=
T, &ib);
> -               if (r) {
> -                       DRM_ERROR("amdgpu: failed to get ib (%ld).\n", r)=
;
> -                       goto err0;
> -               }
> +       r =3D amdgpu_ib_get(adev, NULL, 256, AMDGPU_IB_POOL_DIRECT, &ib);
> +       if (r) {
> +               DRM_ERROR("amdgpu: failed to get ib (%ld).\n", r);
> +               goto err0;
>         }
>
>         ib.ptr[0] =3D SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_WRITE) |
> @@ -1101,10 +1043,7 @@ static int sdma_v7_0_ring_test_ib(struct amdgpu_ri=
ng *ring, long timeout)
>                 goto err1;
>         }
>
> -       if (ring->is_mes_queue)
> -               tmp =3D le32_to_cpu(*cpu_ptr);
> -       else
> -               tmp =3D le32_to_cpu(adev->wb.wb[index]);
> +       tmp =3D le32_to_cpu(adev->wb.wb[index]);
>
>         if (tmp =3D=3D 0xDEADBEEF)
>                 r =3D 0;
> @@ -1115,8 +1054,7 @@ static int sdma_v7_0_ring_test_ib(struct amdgpu_rin=
g *ring, long timeout)
>         amdgpu_ib_free(&ib, NULL);
>         dma_fence_put(f);
>  err0:
> -       if (!ring->is_mes_queue)
> -               amdgpu_device_wb_free(adev, index);
> +       amdgpu_device_wb_free(adev, index);
>         return r;
>  }
>
> --
> 2.48.1
>
