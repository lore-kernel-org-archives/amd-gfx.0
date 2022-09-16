Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B193ECAAA1
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Sep 2022 19:21:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABBD510ED8F;
	Fri, 16 Sep 2022 19:21:39 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6C8D10ED8F
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Sep 2022 19:21:35 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id s125so3220423oie.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Sep 2022 12:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date;
 bh=pbRu4bwrYKzHSWplGarx2dcdOT9sRxx1LZcoiFKTI94=;
 b=qJHSwC5sF1wS+kne+kP10/UEJld/qjCrAMuFz9hw7u1OA7BmeS2x3hfXnepFPovkxT
 LSTGahjwt+W51D7xMrt31N2N79eHCeK75DR4vxnJqodhvWQcUwqErQcz1cN5nRtgm5m6
 hDH+XoWVLvhLnOSWu/UMNAmp+89dldd+1jQqA88Q8uLcPtnNcoVV3+1T2q4Ipmz/nvoP
 pUiS1KHYXrGXwlNOWLkD991GHjK+Aw/21YGhzlAMzCpUeHhUQjxi/BMUtoN7JLirXY93
 /t3Md6/OQ8lQFiTzoTtD0MLT60C8D3q/BPGVyDEEgQmkRoHmGIRR7Vy8P6JSHIrTO0hx
 r6Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date;
 bh=pbRu4bwrYKzHSWplGarx2dcdOT9sRxx1LZcoiFKTI94=;
 b=tEbiFwsiwhjOglN4CKUIE/nIARs7S55os5Or5KJOaxRZB9rsA/30aTISlSUbtXhZiY
 oGY4fnVsRIT7En39Z1B4hkunrI32hqrLqSBy/PfmLczy0+tQnINJXatNInhs0XME4GTz
 Yqt27jIpOjtinCUWJ9RAVVJ/0TWlkBW/Hpmy9z7fvrLFQkkXJ+V2JndlaiEw9eCqfn/N
 Rfi67JK2ZjxqBBPFff5JBa2CirNljfQjweVKkZ0tGVp/lC1xg1ozGAFL6ND1xYiB4N0w
 12uKpgGpgpEzlOVn2KQJwi60Jza9xJYYDtop/RgxB86/3ALsfU1O6t3fexPX0xTcO+pK
 DlJg==
X-Gm-Message-State: ACrzQf3Opjb/FcoFtoV5l90Wpr0TsT3SShZOStiM1kzEhbSBA/KbvhG1
 fQUGAPAsYE9KSKwfsdGvwKv5polxq8F7WH68gLNI0L42iEc=
X-Google-Smtp-Source: AMsMyM5h5ym2fF2Hqvj7qNBHf+GOkT607qNoS5pTnbOEh8dqOsQVjz6GNuveRwEPQeX2b5M5e5qe4wxKvA2ZHyHvd0k=
X-Received: by 2002:a05:6808:2390:b0:350:5c6b:5ef9 with SMTP id
 bp16-20020a056808239000b003505c6b5ef9mr1798724oib.96.1663356094765; Fri, 16
 Sep 2022 12:21:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220916090845.3336-1-christian.koenig@amd.com>
 <20220916090845.3336-9-christian.koenig@amd.com>
In-Reply-To: <20220916090845.3336-9-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 16 Sep 2022 15:21:23 -0400
Message-ID: <CADnq5_MFhWdsdSgXCHcf9zf7KOW8xDJ6w+kXA_5tp2Px4ZXYcw@mail.gmail.com>
Subject: Re: [PATCH 8/8] drm/amdgpu: add gang submit frontend v5
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: alexander.deucher@amd.com, timur.kristof@gmail.com,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, bas@basnieuwenhuizen.nl
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Sep 16, 2022 at 5:09 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Allows submitting jobs as gang which needs to run on multiple engines at =
the
> same time.
>
> All members of the gang get the same implicit, explicit and VM dependenci=
es. So
> no gang member will start running until everything else is ready.
>
> The last job is considered the gang leader (usually a submission to the G=
FX
> ring) and used for signaling output dependencies.
>
> Each job is remembered individually as user of a buffer object, so there =
is no
> joining of work at the end.
>
> v2: rebase and fix review comments from Andrey and Yogesh
> v3: use READ instead of BOOKKEEP for now because of VM unmaps, set gang
>     leader only when necessary
> v4: fix order of pushing jobs and adding fences found by Trigger.
> v5: fix job index calculation and adding IBs to jobs
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c     | 269 ++++++++++++++-------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h     |  10 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h  |  12 +-
>  5 files changed, 195 insertions(+), 99 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_amdkfd.c
> index 4f5bd96000ec..c7b1a2dfde13 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -686,6 +686,7 @@ int amdgpu_amdkfd_submit_ib(struct amdgpu_device *ade=
v,
>         ib->length_dw =3D ib_len;
>         /* This works for NO_HWS. TODO: need to handle without knowing VM=
ID */
>         job->vmid =3D vmid;
> +       job->num_ibs =3D 1;
>
>         ret =3D amdgpu_ib_schedule(ring, 1, ib, job, &f);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_cs.c
> index 58088c663125..964052377991 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -64,11 +64,11 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_par=
ser *p,
>         return 0;
>  }
>
> -static int amdgpu_cs_p1_ib(struct amdgpu_cs_parser *p,
> -                          struct drm_amdgpu_cs_chunk_ib *chunk_ib,
> -                          unsigned int *num_ibs)
> +static int amdgpu_cs_job_idx(struct amdgpu_cs_parser *p,
> +                            struct drm_amdgpu_cs_chunk_ib *chunk_ib)
>  {
>         struct drm_sched_entity *entity;
> +       unsigned int i;
>         int r;
>
>         r =3D amdgpu_ctx_get_entity(p->ctx, chunk_ib->ip_type,
> @@ -77,17 +77,38 @@ static int amdgpu_cs_p1_ib(struct amdgpu_cs_parser *p=
,
>         if (r)
>                 return r;
>
> -       /* Abort if there is no run queue associated with this entity.
> -        * Possibly because of disabled HW IP*/
> +       /*
> +        * Abort if there is no run queue associated with this entity.
> +        * Possibly because of disabled HW IP.
> +        */
>         if (entity->rq =3D=3D NULL)
>                 return -EINVAL;
>
> -       /* Currently we don't support submitting to multiple entities */
> -       if (p->entity && p->entity !=3D entity)
> +       /* Check if we can add this IB to some existing job */
> +       for (i =3D 0; i < p->gang_size; ++i)
> +               if (p->entities[i] =3D=3D entity)
> +                       return i;
> +
> +       /* If not increase the gang size if possible */
> +       if (i =3D=3D AMDGPU_CS_GANG_SIZE)
>                 return -EINVAL;
>
> -       p->entity =3D entity;
> -       ++(*num_ibs);
> +       p->entities[i] =3D entity;
> +       p->gang_size =3D i + 1;
> +       return i;
> +}
> +
> +static int amdgpu_cs_p1_ib(struct amdgpu_cs_parser *p,
> +                          struct drm_amdgpu_cs_chunk_ib *chunk_ib,
> +                          unsigned int *num_ibs)
> +{
> +       int r;
> +
> +       r =3D amdgpu_cs_job_idx(p, chunk_ib);
> +       if (r < 0)
> +               return r;
> +
> +       ++(num_ibs[r]);
>         return 0;
>  }
>
> @@ -161,11 +182,12 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser =
*p,
>                            union drm_amdgpu_cs *cs)
>  {
>         struct amdgpu_fpriv *fpriv =3D p->filp->driver_priv;
> +       unsigned int num_ibs[AMDGPU_CS_GANG_SIZE] =3D { };
>         struct amdgpu_vm *vm =3D &fpriv->vm;
>         uint64_t *chunk_array_user;
>         uint64_t *chunk_array;
> -       unsigned size, num_ibs =3D 0;
>         uint32_t uf_offset =3D 0;
> +       unsigned int size;
>         int ret;
>         int i;
>
> @@ -228,7 +250,7 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p=
,
>                         if (size < sizeof(struct drm_amdgpu_cs_chunk_ib))
>                                 goto free_partial_kdata;
>
> -                       ret =3D amdgpu_cs_p1_ib(p, p->chunks[i].kdata, &n=
um_ibs);
> +                       ret =3D amdgpu_cs_p1_ib(p, p->chunks[i].kdata, nu=
m_ibs);
>                         if (ret)
>                                 goto free_partial_kdata;
>                         break;
> @@ -265,21 +287,28 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser =
*p,
>                 }
>         }
>
> -       ret =3D amdgpu_job_alloc(p->adev, num_ibs, &p->job, vm);
> -       if (ret)
> -               goto free_all_kdata;
> +       if (!p->gang_size)
> +               return -EINVAL;
>
> -       ret =3D drm_sched_job_init(&p->job->base, p->entity, &fpriv->vm);
> -       if (ret)
> -               goto free_all_kdata;
> +       for (i =3D 0; i < p->gang_size; ++i) {
> +               ret =3D amdgpu_job_alloc(p->adev, num_ibs[i], &p->jobs[i]=
, vm);
> +               if (ret)
> +                       goto free_all_kdata;
>
> -       if (p->ctx->vram_lost_counter !=3D p->job->vram_lost_counter) {
> +               ret =3D drm_sched_job_init(&p->jobs[i]->base, p->entities=
[i],
> +                                        &fpriv->vm);
> +               if (ret)
> +                       goto free_all_kdata;
> +       }
> +       p->gang_leader =3D p->jobs[p->gang_size - 1];
> +
> +       if (p->ctx->vram_lost_counter !=3D p->gang_leader->vram_lost_coun=
ter) {
>                 ret =3D -ECANCELED;
>                 goto free_all_kdata;
>         }
>
>         if (p->uf_entry.tv.bo)
> -               p->job->uf_addr =3D uf_offset;
> +               p->gang_leader->uf_addr =3D uf_offset;
>         kvfree(chunk_array);
>
>         /* Use this opportunity to fill in task info for the vm */
> @@ -303,17 +332,25 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser =
*p,
>
>  static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *p,
>                            struct amdgpu_cs_chunk *chunk,
> -                          unsigned int *num_ibs,
>                            unsigned int *ce_preempt,
>                            unsigned int *de_preempt)
>  {
>         struct drm_amdgpu_cs_chunk_ib *chunk_ib =3D chunk->kdata;
>         struct amdgpu_fpriv *fpriv =3D p->filp->driver_priv;
> -       struct amdgpu_ring *ring =3D amdgpu_job_ring(p->job);
> -       struct amdgpu_ib *ib =3D &p->job->ibs[*num_ibs];
>         struct amdgpu_vm *vm =3D &fpriv->vm;
> +       struct amdgpu_ring *ring;
> +       struct amdgpu_job *job;
> +       struct amdgpu_ib *ib;
>         int r;
>
> +       r =3D amdgpu_cs_job_idx(p, chunk_ib);
> +       if (r < 0)
> +               return r;
> +
> +       job =3D p->jobs[r];
> +       ring =3D amdgpu_job_ring(job);
> +       ib =3D &job->ibs[job->num_ibs++];
> +
>         /* MM engine doesn't support user fences */
>         if (p->uf_entry.tv.bo && ring->funcs->no_user_fence)
>                 return -EINVAL;
> @@ -332,7 +369,7 @@ static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *p=
,
>         }
>
>         if (chunk_ib->flags & AMDGPU_IB_FLAG_PREAMBLE)
> -               p->job->preamble_status |=3D AMDGPU_PREAMBLE_IB_PRESENT;
> +               job->preamble_status |=3D AMDGPU_PREAMBLE_IB_PRESENT;
>
>         r =3D  amdgpu_ib_get(p->adev, vm, ring->funcs->parse_cs ?
>                            chunk_ib->ib_bytes : 0,
> @@ -345,8 +382,6 @@ static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *p=
,
>         ib->gpu_addr =3D chunk_ib->va_start;
>         ib->length_dw =3D chunk_ib->ib_bytes / 4;
>         ib->flags =3D chunk_ib->flags;
> -
> -       (*num_ibs)++;
>         return 0;
>  }
>
> @@ -395,7 +430,7 @@ static int amdgpu_cs_p2_dependencies(struct amdgpu_cs=
_parser *p,
>                         dma_fence_put(old);
>                 }
>
> -               r =3D amdgpu_sync_fence(&p->job->sync, fence);
> +               r =3D amdgpu_sync_fence(&p->gang_leader->sync, fence);
>                 dma_fence_put(fence);
>                 if (r)
>                         return r;
> @@ -417,7 +452,7 @@ static int amdgpu_syncobj_lookup_and_add(struct amdgp=
u_cs_parser *p,
>                 return r;
>         }
>
> -       r =3D amdgpu_sync_fence(&p->job->sync, fence);
> +       r =3D amdgpu_sync_fence(&p->gang_leader->sync, fence);
>         dma_fence_put(fence);
>
>         return r;
> @@ -540,7 +575,7 @@ static int amdgpu_cs_p2_syncobj_timeline_signal(struc=
t amdgpu_cs_parser *p,
>
>  static int amdgpu_cs_pass2(struct amdgpu_cs_parser *p)
>  {
> -       unsigned int num_ibs =3D 0, ce_preempt =3D 0, de_preempt =3D 0;
> +       unsigned int ce_preempt =3D 0, de_preempt =3D 0;
>         int i, r;
>
>         for (i =3D 0; i < p->nchunks; ++i) {
> @@ -550,8 +585,7 @@ static int amdgpu_cs_pass2(struct amdgpu_cs_parser *p=
)
>
>                 switch (chunk->chunk_id) {
>                 case AMDGPU_CHUNK_ID_IB:
> -                       r =3D amdgpu_cs_p2_ib(p, chunk, &num_ibs,
> -                                           &ce_preempt, &de_preempt);
> +                       r =3D amdgpu_cs_p2_ib(p, chunk, &ce_preempt, &de_=
preempt);
>                         if (r)
>                                 return r;
>                         break;
> @@ -822,6 +856,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_pars=
er *p,
>         struct amdgpu_vm *vm =3D &fpriv->vm;
>         struct amdgpu_bo_list_entry *e;
>         struct list_head duplicates;
> +       unsigned int i;
>         int r;
>
>         INIT_LIST_HEAD(&p->validated);
> @@ -905,16 +940,6 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_par=
ser *p,
>                 e->bo_va =3D amdgpu_vm_bo_find(vm, bo);
>         }
>
> -       /* Move fence waiting after getting reservation lock of
> -        * PD root. Then there is no need on a ctx mutex lock.
> -        */
> -       r =3D amdgpu_ctx_wait_prev_fence(p->ctx, p->entity);
> -       if (unlikely(r !=3D 0)) {
> -               if (r !=3D -ERESTARTSYS)
> -                       DRM_ERROR("amdgpu_ctx_wait_prev_fence failed.\n")=
;
> -               goto error_validate;
> -       }
> -
>         amdgpu_cs_get_threshold_for_moves(p->adev, &p->bytes_moved_thresh=
old,
>                                           &p->bytes_moved_vis_threshold);
>         p->bytes_moved =3D 0;
> @@ -942,13 +967,16 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_pa=
rser *p,
>                 if (r)
>                         goto error_validate;
>
> -               p->job->uf_addr +=3D amdgpu_bo_gpu_offset(uf);
> +               p->gang_leader->uf_addr +=3D amdgpu_bo_gpu_offset(uf);
>         }
>
>         amdgpu_cs_report_moved_bytes(p->adev, p->bytes_moved,
>                                      p->bytes_moved_vis);
> -       amdgpu_job_set_resources(p->job, p->bo_list->gds_obj,
> -                                p->bo_list->gws_obj, p->bo_list->oa_obj)=
;
> +
> +       for (i =3D 0; i < p->gang_size; ++i)
> +               amdgpu_job_set_resources(p->jobs[i], p->bo_list->gds_obj,
> +                                        p->bo_list->gws_obj,
> +                                        p->bo_list->oa_obj);
>         return 0;
>
>  error_validate:
> @@ -967,20 +995,24 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_pa=
rser *p,
>         return r;
>  }
>
> -static void trace_amdgpu_cs_ibs(struct amdgpu_cs_parser *parser)
> +static void trace_amdgpu_cs_ibs(struct amdgpu_cs_parser *p)
>  {
> -       int i;
> +       int i, j;
>
>         if (!trace_amdgpu_cs_enabled())
>                 return;
>
> -       for (i =3D 0; i < parser->job->num_ibs; i++)
> -               trace_amdgpu_cs(parser, i);
> +       for (i =3D 0; i < p->gang_size; ++i) {
> +               struct amdgpu_job *job =3D p->jobs[i];
> +
> +               for (j =3D 0; j < job->num_ibs; ++j)
> +                       trace_amdgpu_cs(p, job, &job->ibs[j]);
> +       }
>  }
>
> -static int amdgpu_cs_patch_ibs(struct amdgpu_cs_parser *p)
> +static int amdgpu_cs_patch_ibs(struct amdgpu_cs_parser *p,
> +                              struct amdgpu_job *job)
>  {
> -       struct amdgpu_job *job =3D p->job;
>         struct amdgpu_ring *ring =3D amdgpu_job_ring(job);
>         unsigned int i;
>         int r;
> @@ -1021,12 +1053,12 @@ static int amdgpu_cs_patch_ibs(struct amdgpu_cs_p=
arser *p)
>                         memcpy(ib->ptr, kptr, ib->length_dw * 4);
>                         amdgpu_bo_kunmap(aobj);
>
> -                       r =3D amdgpu_ring_parse_cs(ring, p, p->job, ib);
> +                       r =3D amdgpu_ring_parse_cs(ring, p, job, ib);
>                         if (r)
>                                 return r;
>                 } else {
>                         ib->ptr =3D (uint32_t *)kptr;
> -                       r =3D amdgpu_ring_patch_cs_in_place(ring, p, p->j=
ob, ib);
> +                       r =3D amdgpu_ring_patch_cs_in_place(ring, p, job,=
 ib);
>                         amdgpu_bo_kunmap(aobj);
>                         if (r)
>                                 return r;
> @@ -1036,19 +1068,31 @@ static int amdgpu_cs_patch_ibs(struct amdgpu_cs_p=
arser *p)
>         return 0;
>  }
>
> +static int amdgpu_cs_patch_jobs(struct amdgpu_cs_parser *p)
> +{
> +       unsigned int i;
> +       int r;
> +
> +       for (i =3D 0; i < p->gang_size; ++i) {
> +               r =3D amdgpu_cs_patch_ibs(p, p->jobs[i]);
> +               if (r)
> +                       return r;
> +       }
> +       return 0;
> +}
> +
>  static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
>  {
>         struct amdgpu_fpriv *fpriv =3D p->filp->driver_priv;
> +       struct amdgpu_job *job =3D p->gang_leader;
>         struct amdgpu_device *adev =3D p->adev;
>         struct amdgpu_vm *vm =3D &fpriv->vm;
>         struct amdgpu_bo_list_entry *e;
>         struct amdgpu_bo_va *bo_va;
>         struct amdgpu_bo *bo;
> +       unsigned int i;
>         int r;
>
> -       if (!p->job->vm)
> -               return 0;
> -
>         r =3D amdgpu_vm_clear_freed(adev, vm, NULL);
>         if (r)
>                 return r;
> @@ -1057,7 +1101,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_p=
arser *p)
>         if (r)
>                 return r;
>
> -       r =3D amdgpu_sync_fence(&p->job->sync, fpriv->prt_va->last_pt_upd=
ate);
> +       r =3D amdgpu_sync_fence(&job->sync, fpriv->prt_va->last_pt_update=
);
>         if (r)
>                 return r;
>
> @@ -1068,7 +1112,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_p=
arser *p)
>                 if (r)
>                         return r;
>
> -               r =3D amdgpu_sync_fence(&p->job->sync, bo_va->last_pt_upd=
ate);
> +               r =3D amdgpu_sync_fence(&job->sync, bo_va->last_pt_update=
);
>                 if (r)
>                         return r;
>         }
> @@ -1087,7 +1131,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_p=
arser *p)
>                 if (r)
>                         return r;
>
> -               r =3D amdgpu_sync_fence(&p->job->sync, bo_va->last_pt_upd=
ate);
> +               r =3D amdgpu_sync_fence(&job->sync, bo_va->last_pt_update=
);
>                 if (r)
>                         return r;
>         }
> @@ -1100,11 +1144,18 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs=
_parser *p)
>         if (r)
>                 return r;
>
> -       r =3D amdgpu_sync_fence(&p->job->sync, vm->last_update);
> +       r =3D amdgpu_sync_fence(&job->sync, vm->last_update);
>         if (r)
>                 return r;
>
> -       p->job->vm_pd_addr =3D amdgpu_gmc_pd_addr(vm->root.bo);
> +       for (i =3D 0; i < p->gang_size; ++i) {
> +               job =3D p->jobs[i];
> +
> +               if (!job->vm)
> +                       continue;
> +
> +               job->vm_pd_addr =3D amdgpu_gmc_pd_addr(vm->root.bo);
> +       }
>
>         if (amdgpu_vm_debug) {
>                 /* Invalidate all BOs to test for userspace bugs */
> @@ -1125,7 +1176,9 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_p=
arser *p)
>  static int amdgpu_cs_sync_rings(struct amdgpu_cs_parser *p)
>  {
>         struct amdgpu_fpriv *fpriv =3D p->filp->driver_priv;
> +       struct amdgpu_job *leader =3D p->gang_leader;
>         struct amdgpu_bo_list_entry *e;
> +       unsigned int i;
>         int r;
>
>         list_for_each_entry(e, &p->validated, tv.head) {
> @@ -1135,12 +1188,23 @@ static int amdgpu_cs_sync_rings(struct amdgpu_cs_=
parser *p)
>
>                 sync_mode =3D amdgpu_bo_explicit_sync(bo) ?
>                         AMDGPU_SYNC_EXPLICIT : AMDGPU_SYNC_NE_OWNER;
> -               r =3D amdgpu_sync_resv(p->adev, &p->job->sync, resv, sync=
_mode,
> +               r =3D amdgpu_sync_resv(p->adev, &leader->sync, resv, sync=
_mode,
>                                      &fpriv->vm);
>                 if (r)
>                         return r;
>         }
> -       return 0;
> +
> +       for (i =3D 0; i < p->gang_size - 1; ++i) {
> +               r =3D amdgpu_sync_clone(&leader->sync, &p->jobs[i]->sync)=
;
> +               if (r)
> +                       return r;
> +       }
> +
> +       r =3D amdgpu_ctx_wait_prev_fence(p->ctx, p->entities[p->gang_size=
 - 1]);
> +       if (r && r !=3D -ERESTARTSYS)
> +               DRM_ERROR("amdgpu_ctx_wait_prev_fence failed.\n");
> +
> +       return r;
>  }
>
>  static void amdgpu_cs_post_dependencies(struct amdgpu_cs_parser *p)
> @@ -1164,16 +1228,28 @@ static int amdgpu_cs_submit(struct amdgpu_cs_pars=
er *p,
>                             union drm_amdgpu_cs *cs)
>  {
>         struct amdgpu_fpriv *fpriv =3D p->filp->driver_priv;
> -       struct drm_sched_entity *entity =3D p->entity;
> +       struct amdgpu_job *leader =3D p->gang_leader;
>         struct amdgpu_bo_list_entry *e;
> -       struct amdgpu_job *job;
> +       unsigned int i;
>         uint64_t seq;
>         int r;
>
> -       job =3D p->job;
> -       p->job =3D NULL;
> +       for (i =3D 0; i < p->gang_size; ++i)
> +               drm_sched_job_arm(&p->jobs[i]->base);
>
> -       drm_sched_job_arm(&job->base);
> +       for (i =3D 0; i < (p->gang_size - 1); ++i) {
> +               struct dma_fence *fence;
> +
> +               fence =3D &p->jobs[i]->base.s_fence->scheduled;
> +               r =3D amdgpu_sync_fence(&leader->sync, fence);
> +               if (r)
> +                       goto error_cleanup;
> +       }
> +
> +       if (p->gang_size > 1) {
> +               for (i =3D 0; i < p->gang_size; ++i)
> +                       amdgpu_job_set_gang_leader(p->jobs[i], leader);
> +       }
>
>         /* No memory allocation is allowed while holding the notifier loc=
k.
>          * The lock is held until amdgpu_cs_submit is finished and fence =
is
> @@ -1191,45 +1267,57 @@ static int amdgpu_cs_submit(struct amdgpu_cs_pars=
er *p,
>         }
>         if (r) {
>                 r =3D -EAGAIN;
> -               goto error_abort;
> +               goto error_unlock;
>         }
>
> -       p->fence =3D dma_fence_get(&job->base.s_fence->finished);
> +       p->fence =3D dma_fence_get(&leader->base.s_fence->finished);
> +       list_for_each_entry(e, &p->validated, tv.head) {
> +
> +               /* Everybody except for the gang leader uses READ */
> +               for (i =3D 0; i < (p->gang_size - 1); ++i) {
> +                       dma_resv_add_fence(e->tv.bo->base.resv,
> +                                          &p->jobs[i]->base.s_fence->fin=
ished,
> +                                          DMA_RESV_USAGE_READ);
> +               }
> +
> +               /* The gang leader as remembered as writer */

typo:
The gang leader IS remembered as writer

> +               e->tv.num_shared =3D 0;
> +       }
>
> -       seq =3D amdgpu_ctx_add_fence(p->ctx, entity, p->fence);
> +       seq =3D amdgpu_ctx_add_fence(p->ctx, p->entities[p->gang_size - 1=
],
> +                                  p->fence);
>         amdgpu_cs_post_dependencies(p);
>
> -       if ((job->preamble_status & AMDGPU_PREAMBLE_IB_PRESENT) &&
> +       if ((leader->preamble_status & AMDGPU_PREAMBLE_IB_PRESENT) &&
>             !p->ctx->preamble_presented) {
> -               job->preamble_status |=3D AMDGPU_PREAMBLE_IB_PRESENT_FIRS=
T;
> +               leader->preamble_status |=3D AMDGPU_PREAMBLE_IB_PRESENT_F=
IRST;
>                 p->ctx->preamble_presented =3D true;
>         }
>
>         cs->out.handle =3D seq;
> -       job->uf_sequence =3D seq;
> +       leader->uf_sequence =3D seq;
>
> -       amdgpu_job_free_resources(job);
> -
> -       trace_amdgpu_cs_ioctl(job);
>         amdgpu_vm_bo_trace_cs(&fpriv->vm, &p->ticket);
> -       drm_sched_entity_push_job(&job->base);
> +       for (i =3D 0; i < p->gang_size; ++i) {
> +               amdgpu_job_free_resources(p->jobs[i]);
> +               trace_amdgpu_cs_ioctl(p->jobs[i]);
> +               drm_sched_entity_push_job(&p->jobs[i]->base);
> +               p->jobs[i] =3D NULL;
> +       }
>
>         amdgpu_vm_move_to_lru_tail(p->adev, &fpriv->vm);
> -
> -       /* Make sure all BOs are remembered as writers */
> -       amdgpu_bo_list_for_each_entry(e, p->bo_list)
> -               e->tv.num_shared =3D 0;
> -
>         ttm_eu_fence_buffer_objects(&p->ticket, &p->validated, p->fence);
> +
>         mutex_unlock(&p->adev->notifier_lock);
>         mutex_unlock(&p->bo_list->bo_list_mutex);
> -
>         return 0;
>
> -error_abort:
> -       drm_sched_job_cleanup(&job->base);
> +error_unlock:
>         mutex_unlock(&p->adev->notifier_lock);
> -       amdgpu_job_free(job);
> +
> +error_cleanup:
> +       for (i =3D 0; i < p->gang_size; ++i)
> +               drm_sched_job_cleanup(&p->jobs[i]->base);
>         return r;
>  }
>
> @@ -1246,17 +1334,18 @@ static void amdgpu_cs_parser_fini(struct amdgpu_c=
s_parser *parser)
>
>         dma_fence_put(parser->fence);
>
> -       if (parser->ctx) {
> +       if (parser->ctx)
>                 amdgpu_ctx_put(parser->ctx);
> -       }
>         if (parser->bo_list)
>                 amdgpu_bo_list_put(parser->bo_list);
>
>         for (i =3D 0; i < parser->nchunks; i++)
>                 kvfree(parser->chunks[i].kdata);
>         kvfree(parser->chunks);
> -       if (parser->job)
> -               amdgpu_job_free(parser->job);
> +       for (i =3D 0; i < parser->gang_size; ++i) {
> +               if (parser->jobs[i])
> +                       amdgpu_job_free(parser->jobs[i]);
> +       }
>         if (parser->uf_entry.tv.bo) {
>                 struct amdgpu_bo *uf =3D ttm_to_amdgpu_bo(parser->uf_entr=
y.tv.bo);
>
> @@ -1300,7 +1389,7 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *d=
ata, struct drm_file *filp)
>                 goto error_fini;
>         }
>
> -       r =3D amdgpu_cs_patch_ibs(&parser);
> +       r =3D amdgpu_cs_patch_jobs(&parser);
>         if (r)
>                 goto error_backoff;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_cs.h
> index 30ecc4917f81..cbaa19b2b8a3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
> @@ -27,6 +27,8 @@
>  #include "amdgpu_bo_list.h"
>  #include "amdgpu_ring.h"
>
> +#define AMDGPU_CS_GANG_SIZE    4
> +
>  struct amdgpu_bo_va_mapping;
>
>  struct amdgpu_cs_chunk {
> @@ -50,9 +52,11 @@ struct amdgpu_cs_parser {
>         unsigned                nchunks;
>         struct amdgpu_cs_chunk  *chunks;
>
> -       /* scheduler job object */
> -       struct amdgpu_job       *job;
> -       struct drm_sched_entity *entity;
> +       /* scheduler job objects */
> +       unsigned int            gang_size;
> +       struct drm_sched_entity *entities[AMDGPU_CS_GANG_SIZE];
> +       struct amdgpu_job       *jobs[AMDGPU_CS_GANG_SIZE];
> +       struct amdgpu_job       *gang_leader;
>
>         /* buffer objects */
>         struct ww_acquire_ctx           ticket;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_job.c
> index cfbe19cfe9af..46c99331d7f1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -105,7 +105,6 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, unsi=
gned num_ibs,
>          */
>         (*job)->base.sched =3D &adev->rings[0]->sched;
>         (*job)->vm =3D vm;
> -       (*job)->num_ibs =3D num_ibs;
>
>         amdgpu_sync_create(&(*job)->sync);
>         amdgpu_sync_create(&(*job)->sched_sync);
> @@ -125,6 +124,7 @@ int amdgpu_job_alloc_with_ib(struct amdgpu_device *ad=
ev, unsigned size,
>         if (r)
>                 return r;
>
> +       (*job)->num_ibs =3D 1;
>         r =3D amdgpu_ib_get(adev, NULL, size, pool_type, &(*job)->ibs[0])=
;
>         if (r)
>                 kfree(*job);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_trace.h
> index 06dfcf297a8d..5e6ddc7e101c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> @@ -140,8 +140,10 @@ TRACE_EVENT(amdgpu_bo_create,
>  );
>
>  TRACE_EVENT(amdgpu_cs,
> -           TP_PROTO(struct amdgpu_cs_parser *p, int i),
> -           TP_ARGS(p, i),
> +           TP_PROTO(struct amdgpu_cs_parser *p,
> +                    struct amdgpu_job *job,
> +                    struct amdgpu_ib *ib),
> +           TP_ARGS(p, job, ib),
>             TP_STRUCT__entry(
>                              __field(struct amdgpu_bo_list *, bo_list)
>                              __field(u32, ring)
> @@ -151,10 +153,10 @@ TRACE_EVENT(amdgpu_cs,
>
>             TP_fast_assign(
>                            __entry->bo_list =3D p->bo_list;
> -                          __entry->ring =3D to_amdgpu_ring(p->entity->rq=
->sched)->idx;
> -                          __entry->dw =3D p->job->ibs[i].length_dw;
> +                          __entry->ring =3D to_amdgpu_ring(job->base.sch=
ed)->idx;
> +                          __entry->dw =3D ib->length_dw;
>                            __entry->fences =3D amdgpu_fence_count_emitted=
(
> -                               to_amdgpu_ring(p->entity->rq->sched));
> +                               to_amdgpu_ring(job->base.sched));
>                            ),
>             TP_printk("bo_list=3D%p, ring=3D%u, dw=3D%u, fences=3D%u",
>                       __entry->bo_list, __entry->ring, __entry->dw,
> --
> 2.25.1
>
