Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B55C3ABBE
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 18:33:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB0ED10E954;
	Thu,  8 May 2025 18:33:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nGBOn+x1";
	dkim-atps=neutral
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F0A410E954
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 May 2025 18:33:41 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-7393eab4a75so222430b3a.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 08 May 2025 11:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746729221; x=1747334021; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4SmfqSh8LWqaDCs0eEO8C2+dVTovnu4BSWIUsBAqw84=;
 b=nGBOn+x1SwSDMMEGN/++sAglXGSGh531Tb7tJLfG0kW/H/+EN+wGrck4WPyKyP6GPj
 7rSp/hmtQ+KOCSlRXFIiqgHG/2k+xgqW0w/icLQCU/GqjvKb8WtK3omKpyl7GGHjfP9p
 wiD4+ILT0LPfaJoFh3eq+FQenpA0oUGXW9kI9mv2vvpgaQRd1Fz9FOjMiYRXJ4O6rxh8
 j2STdnNzsf4IIdlDyh/NtzlFhLjWQLPiaH8FZ8DyjE/+RFwaAEXbMimegQpsINMtFQ87
 qTbyvmNnlTU3mn4QBSgTUbPR8nXudAmRTq/w0hlpk50MtF1ahA6eQp/1/Xs9uttgYT+G
 8LKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746729221; x=1747334021;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4SmfqSh8LWqaDCs0eEO8C2+dVTovnu4BSWIUsBAqw84=;
 b=fVh+SAglj9sCov8NRK4OyXIanzUbVD9eIQqwdo6xQMjbCFr2pXD2BXyWMmdPM3Y9OG
 XF6V9Un/XlM7AermxG+d/u8yaYe0fVXeu9Ft0IAQwWHXI3ZZnxJqhQ/Lnulx0lYX6TPB
 T7Tmf5nuWU7tRd6iczXFIXyXRrjnrysWRHfi8/imtQToH5YFWbx5YcnNpqnyK6ZPWF+N
 C2/g9h4dZke//DIo1W9yVdadv+OiW1xGXPmEtp/iVoYD/Gt31VeCgNdGYTmp4RzYJEuB
 GwvzVZp0f1r5nDWXLiT2SVWA0cdEWzA2Ol8ucLPuZOCayGWyv70CboIWJtug9V5JzBLT
 STTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXT3hi/LtZ0+8grlMjjXgXFN8xVKhKpba0sRuZrPxwEmfJq6pgbuyHxhxjf6UV8wv5ABdFNmMbd@lists.freedesktop.org
X-Gm-Message-State: AOJu0YypeMdvKMUZzycaj5bkaksB2hLA6Q8H3UZA1vhjtXroiBhLq/wR
 8/bFos+CNI9OfOMq3XXBqdfNQf4OVNUGgDSntdM062lFYQk3tu2V3NXS6HVlFm/VdoOhxhxtSKp
 YIsU48GmzeqTRtuXtrl9fr1CLSss=
X-Gm-Gg: ASbGncuIjz+8GGzi5rnTjq+/A4ff1hOP7HReKX7glJgB2ertNCYOId9oMavGOQBRpuX
 geaXgRDXuFRiPPOiV1IKDG72vPHIHgz3fUAyQSr1iT5cUIeskS+g8gJGVpUNTKlXkOc9Spy6hqj
 JtkFW9RT7WCX1aOYLSXJapFtftz213HXP7
X-Google-Smtp-Source: AGHT+IFZEaouH0BJJSAiYgLwUUR3P148Y5uScyjm1WtSSVOAA/MdoyyxqHJgmjfltWT4c3VYoLHxSvc+cobBlwOqGQ4=
X-Received: by 2002:a17:903:1c7:b0:21d:cdb7:876c with SMTP id
 d9443c01a7336-22fc8b0f8a4mr2577135ad.3.1746729220920; Thu, 08 May 2025
 11:33:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250508120502.1467-1-christian.koenig@amd.com>
 <20250508120502.1467-2-christian.koenig@amd.com>
In-Reply-To: <20250508120502.1467-2-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 8 May 2025 14:33:29 -0400
X-Gm-Features: ATxdqUFMsab3x7S7wOsCe4r2uZ_sr2W6U2zXZlweS30npjEDE9VGFlxo_7LXM1s
Message-ID: <CADnq5_NwHQdE6aAR_ca88VGWmjXr9vtDf5_YQrL=DijA-6=UYw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: cleanup amdgpu_vm_flush v7
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: srinivasan.shanmugam@amd.com, amd-gfx@lists.freedesktop.org
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

On Thu, May 8, 2025 at 8:05=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Check if the cleaner shader should run directly.
>
> While at it remove amdgpu_vm_need_pipeline_sync(), we also check again
> if the VMID has seen a GPU reset since last use and the gds switch
> setiing can be handled more simply as well.
>
> Also remove some duplicate checks and re-order and document the code.
>
> v2: restructure the while function
> v3: fix logic error pointed out by Srini
> v4: fix typo in comment, fix crash caused by incorrect check
> v5: once more fix the logic
> v6: separate cleaner shader checks as suggested by Srini
> v7: re-order incorrect check
> v8: separate the revert
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Reviewed-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c |   6 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 106 ++++++++++---------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |   5 +-
>  3 files changed, 46 insertions(+), 71 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ib.c
> index 5eab1c1a380c..30b58772598c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -189,10 +189,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, uns=
igned int num_ibs,
>         }
>
>         need_ctx_switch =3D ring->current_ctx !=3D fence_ctx;
> -       if (ring->funcs->emit_pipeline_sync && job &&
> -           ((tmp =3D amdgpu_sync_get_fence(&job->explicit_sync)) ||
> -            (amdgpu_sriov_vf(adev) && need_ctx_switch) ||
> -            amdgpu_vm_need_pipeline_sync(ring, job))) {
> +       if ((job && (tmp =3D amdgpu_sync_get_fence(&job->explicit_sync)))=
 ||
> +            (amdgpu_sriov_vf(adev) && need_ctx_switch)) {
>                 need_pipe_sync =3D true;
>
>                 if (tmp)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index 0a80c011e678..31c423663b54 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -707,37 +707,6 @@ void amdgpu_vm_check_compute_bug(struct amdgpu_devic=
e *adev)
>         }
>  }
>
> -/**
> - * amdgpu_vm_need_pipeline_sync - Check if pipe sync is needed for job.
> - *
> - * @ring: ring on which the job will be submitted
> - * @job: job to submit
> - *
> - * Returns:
> - * True if sync is needed.
> - */
> -bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
> -                                 struct amdgpu_job *job)
> -{
> -       struct amdgpu_device *adev =3D ring->adev;
> -       unsigned vmhub =3D ring->vm_hub;
> -       struct amdgpu_vmid_mgr *id_mgr =3D &adev->vm_manager.id_mgr[vmhub=
];
> -
> -       if (job->vmid =3D=3D 0)
> -               return false;
> -
> -       if (job->vm_needs_flush || ring->has_compute_vm_bug)
> -               return true;
> -
> -       if (ring->funcs->emit_gds_switch && job->gds_switch_needed)
> -               return true;
> -
> -       if (amdgpu_vmid_had_gpu_reset(adev, &id_mgr->ids[job->vmid]))
> -               return true;
> -
> -       return false;
> -}
> -
>  /**
>   * amdgpu_vm_flush - hardware flush the vm
>   *
> @@ -758,44 +727,52 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struc=
t amdgpu_job *job,
>         unsigned vmhub =3D ring->vm_hub;
>         struct amdgpu_vmid_mgr *id_mgr =3D &adev->vm_manager.id_mgr[vmhub=
];
>         struct amdgpu_vmid *id =3D &id_mgr->ids[job->vmid];
> -       bool spm_update_needed =3D job->spm_update_needed;
> -       bool gds_switch_needed =3D ring->funcs->emit_gds_switch &&
> -               job->gds_switch_needed;
> -       bool vm_flush_needed =3D job->vm_needs_flush;
> -       bool cleaner_shader_needed =3D false;
> -       bool pasid_mapping_needed =3D false;
> -       struct dma_fence *fence =3D NULL;
> +       bool gds_switch_needed, vm_flush_needed, spm_update_needed,
> +            cleaner_shader_needed, pasid_mapping_needed;

Would be good to document what all of these flags are used for.  E.g

/* need_pipe_sync - if set, we wait for the last fence on the ring to
signal before executing more commands
 * cleaner_shader_needed - if set we emit the cleaner shader to clean
up GPRs and LDS before a new command is submitted
 * etc.
 */

> +       struct dma_fence *fence;
>         unsigned int patch;
>         int r;
>
> +       /* First of all figure out what needs to be done */
>         if (amdgpu_vmid_had_gpu_reset(adev, id)) {

Please add a comment here to explain why we set all of these to true
if we had a GPU reset.

> +               need_pipe_sync =3D true;
>                 gds_switch_needed =3D true;
>                 vm_flush_needed =3D true;
>                 pasid_mapping_needed =3D true;
>                 spm_update_needed =3D true;
> +               cleaner_shader_needed =3D true;
> +       } else {

Would be good to document all of these cases as well.

> +               gds_switch_needed =3D job->gds_switch_needed;
> +               vm_flush_needed =3D job->vm_needs_flush;
> +               mutex_lock(&id_mgr->lock);
> +               pasid_mapping_needed =3D id->pasid !=3D job->pasid ||
> +                       !id->pasid_mapping ||
> +                       !dma_fence_is_signaled(id->pasid_mapping);
> +               mutex_unlock(&id_mgr->lock);
> +               spm_update_needed =3D job->spm_update_needed;

E.g.:
/* The spearhead marks the first submission from a new client.  We
need to run the cleaner shader
 * if it is requested by the job and we have a new spearhead so that
we clean up before it runs.
 */

> +               cleaner_shader_needed =3D job->run_cleaner_shader &&
> +                       job->base.s_fence && &job->base.s_fence->schedule=
d =3D=3D
> +                       isolation->spearhead;

E.g.,
/* This will cause the queue to wait for the current fence on the ring
to signal before new work executes (wait for idle).
 * This is needed as a workaround for some hardware
(ring->has_compute_vm_bug), if we are updating
 * the vmid or page tables (vm_flush_needed), if we need to emit the
cleaner shader (which must execute while the
 * queue is idle), or if the job uses gds and we need to update the
gds mappings (gds_switch_needed).
 */

> +               need_pipe_sync |=3D ring->has_compute_vm_bug || vm_flush_=
needed ||
> +                       cleaner_shader_needed || gds_switch_needed;
>         }
>
> -       mutex_lock(&id_mgr->lock);
> -       if (id->pasid !=3D job->pasid || !id->pasid_mapping ||
> -           !dma_fence_is_signaled(id->pasid_mapping))
> -               pasid_mapping_needed =3D true;
> -       mutex_unlock(&id_mgr->lock);
> -
> +       /* Then check the pre-requisites */
> +       need_pipe_sync &=3D !!ring->funcs->emit_pipeline_sync;
>         gds_switch_needed &=3D !!ring->funcs->emit_gds_switch;
>         vm_flush_needed &=3D !!ring->funcs->emit_vm_flush  &&
>                         job->vm_pd_addr !=3D AMDGPU_BO_INVALID_OFFSET;
>         pasid_mapping_needed &=3D adev->gmc.gmc_funcs->emit_pasid_mapping=
 &&
>                 ring->funcs->emit_wreg;
> -
> -       cleaner_shader_needed =3D job->run_cleaner_shader &&
> -               adev->gfx.enable_cleaner_shader &&
> -               ring->funcs->emit_cleaner_shader && job->base.s_fence &&
> -               &job->base.s_fence->scheduled =3D=3D isolation->spearhead=
;
> +       spm_update_needed &=3D !!adev->gfx.rlc.funcs->update_spm_vmid;
> +       cleaner_shader_needed &=3D adev->gfx.enable_cleaner_shader &&
> +               ring->funcs->emit_cleaner_shader;
>
>         if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync &&
> -           !cleaner_shader_needed)
> +           !cleaner_shader_needed && !spm_update_needed)
>                 return 0;
>
> +       /* Then actually prepare the submission frame */
>         amdgpu_ring_ib_begin(ring);
>         if (ring->funcs->init_cond_exec)
>                 patch =3D amdgpu_ring_init_cond_exec(ring,
> @@ -815,23 +792,34 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struc=
t amdgpu_job *job,
>         if (pasid_mapping_needed)
>                 amdgpu_gmc_emit_pasid_mapping(ring, job->vmid, job->pasid=
);
>
> -       if (spm_update_needed && adev->gfx.rlc.funcs->update_spm_vmid)
> +       if (spm_update_needed)
>                 adev->gfx.rlc.funcs->update_spm_vmid(adev, ring, job->vmi=
d);
>
> -       if (ring->funcs->emit_gds_switch &&
> -           gds_switch_needed) {
> +       if (gds_switch_needed)
>                 amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_bas=
e,
>                                             job->gds_size, job->gws_base,
>                                             job->gws_size, job->oa_base,
>                                             job->oa_size);
> -       }
>
>         if (vm_flush_needed || pasid_mapping_needed || cleaner_shader_nee=
ded) {
>                 r =3D amdgpu_fence_emit(ring, &fence, NULL, 0);
>                 if (r)
>                         return r;
> +       } else {
> +               fence =3D NULL;
> +       }
> +
> +       amdgpu_ring_patch_cond_exec(ring, patch);
> +
> +       /* the double SWITCH_BUFFER here *cannot* be skipped by COND_EXEC=
 */
> +       if (ring->funcs->emit_switch_buffer) {
> +               amdgpu_ring_emit_switch_buffer(ring);
> +               amdgpu_ring_emit_switch_buffer(ring);
>         }
>
> +       amdgpu_ring_ib_end(ring);
> +
> +       /* And finally remember what the ring has executed */
>         if (vm_flush_needed) {
>                 mutex_lock(&id_mgr->lock);
>                 dma_fence_put(id->last_flush);
> @@ -861,16 +849,6 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct=
 amdgpu_job *job,
>                 mutex_unlock(&adev->enforce_isolation_mutex);
>         }
>         dma_fence_put(fence);
> -
> -       amdgpu_ring_patch_cond_exec(ring, patch);
> -
> -       /* the double SWITCH_BUFFER here *cannot* be skipped by COND_EXEC=
 */
> -       if (ring->funcs->emit_switch_buffer) {
> -               amdgpu_ring_emit_switch_buffer(ring);
> -               amdgpu_ring_emit_switch_buffer(ring);
> -       }
> -
> -       amdgpu_ring_ib_end(ring);
>         return 0;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.h
> index f3ad687125ad..c9578b7f670c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -498,7 +498,8 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, st=
ruct amdgpu_vm *vm,
>                        struct ww_acquire_ctx *ticket,
>                        int (*callback)(void *p, struct amdgpu_bo *bo),
>                        void *param);
> -int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job, bo=
ol need_pipe_sync);
> +int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
> +                   bool need_pipe_sync);
>  int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>                           struct amdgpu_vm *vm, bool immediate);
>  int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
> @@ -559,8 +560,6 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev=
, uint32_t min_vm_size,
>                            uint32_t fragment_size_default, unsigned max_l=
evel,
>                            unsigned max_bits);
>  int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file =
*filp);
> -bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
> -                                 struct amdgpu_job *job);
>  void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev);
>
>  struct amdgpu_task_info *
> --
> 2.34.1
>
