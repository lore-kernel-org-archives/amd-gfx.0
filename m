Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A0EC636D4
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Feb 2023 16:17:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29D4510E40D;
	Mon,  6 Feb 2023 16:17:43 +0000 (UTC)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3827110E40D
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Feb 2023 16:17:41 +0000 (UTC)
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-1636eae256cso15766456fac.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Feb 2023 08:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MweV9EEFfTWdVbP9/lXVoeuNfE7d8OqNGvCtHtXh3k8=;
 b=bee9NQEH1izkXt1s6z341XhMGgzwf7eYEKLhmyoEYeBI8gPP8fo39HXZSLaIOO+yjK
 ZIYWlltDO4FkN6Z6yVhZnjdJASfHgcHoFX/3nETKndXF7qLWNA2Kld1eAe4rsot3Mhxp
 fbZvHgiJm6UwPnTpuNQWdPSFa9Gbi9rPpO/Ifu9IIbIjQko+6xHoMkMImT9PbWLOsDx6
 1Z9bN80vFT/XCF0CqWafKfsv49H0UAFFgd9RS6fCy0OvnHrxUOrB45uRShzu8glPgqOI
 qnmr3pSZRMWYqB7zBsWr83e44bvRDkQRbCRjeX+xNe58MHSy5OhJh+tSFkUZ7qxX5CNm
 DNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MweV9EEFfTWdVbP9/lXVoeuNfE7d8OqNGvCtHtXh3k8=;
 b=bSSeeGEBTWVKEfoEiLiYdyNnlbKLGOSmeL9pxmLvftU3ZSzKGgJZ0MhCGJrIAZCNGy
 t4t71k+fWqPE753DBddtp8wpLc9Fb4yRAXQVhhk0nNWARajsOpiVYZum2S04vZw73kNu
 StppZexla0O2nJ272M1WKh14CeMeLajtsVQUA+c2qBhrE8lmIGYL+NW5QttHs6zfI/5+
 s2wNojCaQQ66DzwWPX/f+1kQ395qpqxgdqp9149/iKJAY/gHoMdb3/Rvb1Ku86tiyl+o
 z9xIlsoek7cYN4qh4zBsahiKxFYJO81xyECdPSQRBFdk1KjM3YS4XhJc/6QwdJM58U3L
 B4Kw==
X-Gm-Message-State: AO0yUKVhWbm3ZLol7u7SFiQ5O7phBNVzdpalhS+eW4R5TvuQLK5mOBRj
 UF6mguxDcByL/vHv4lW9zIG/+QaZ7yr0fVv56j2r6OZl
X-Google-Smtp-Source: AK7set9HWYXd8aN7aPB/RSUNCMzLGgF9uPI292XNHnKCA+eHg35HbXCLoYm1fVRjJpQEaWsO4O7vb8EE9juAYxS7nvA=
X-Received: by 2002:a05:6870:891f:b0:163:8cc6:86a with SMTP id
 i31-20020a056870891f00b001638cc6086amr2137558oao.46.1675700259853; Mon, 06
 Feb 2023 08:17:39 -0800 (PST)
MIME-Version: 1.0
References: <20230203190836.1987-1-shashank.sharma@amd.com>
 <20230203190836.1987-3-shashank.sharma@amd.com>
 <6dfdd5da-d647-f5e6-007d-4c3c2fe8fb0e@amd.com>
In-Reply-To: <6dfdd5da-d647-f5e6-007d-4c3c2fe8fb0e@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 6 Feb 2023 11:17:27 -0500
Message-ID: <CADnq5_Nxf3F43iQwQ2Gg3cd4Zjgfx608w-tipqKzMHBb3aF3ig@mail.gmail.com>
Subject: Re: [PATCH 02/13] drm/amdgpu: rename vram_mgr functions to bar_mgr
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Feb 6, 2023 at 6:21 AM Christian K=C3=B6nig <christian.koenig@amd.c=
om> wrote:
>
> Am 03.02.23 um 20:08 schrieb Shashank Sharma:
> > From: Alex Deucher <alexander.deucher@amd.com>
> >
> > Rename the VRAM manager functions so they can be resused to manage
> > doorbell BAR as well.
>
> Yeah, as said before Alex did this before we had the buddy allocator.
>
> This doesn't makes sense any more and should probably be dropped complete=
ly.

I had suggested that we just use this as is for now so we could get
everything up and running to prove this out.  Now that we have this
actually working, we can look at dropping this.

Alex


>
> Christian.
>
> >
> > Cc: Christian Koenig <christian.koenig@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |   2 +-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c   |   8 +-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   4 +-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   4 +-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |   4 +-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |   4 +-
> >   .../gpu/drm/amd/amdgpu/amdgpu_res_cursor.h    |  14 +-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |   4 +-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  36 ++--
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |   2 +-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c  | 200 ++++++++++-------=
-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h  |  18 +-
> >   12 files changed, 157 insertions(+), 143 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_cs.c
> > index 7b5ce00f0602..e34eae8d64cf 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > @@ -723,7 +723,7 @@ static void amdgpu_cs_get_threshold_for_moves(struc=
t amdgpu_device *adev,
> >       if (!amdgpu_gmc_vram_full_visible(&adev->gmc)) {
> >               u64 total_vis_vram =3D adev->gmc.visible_vram_size;
> >               u64 used_vis_vram =3D
> > -               amdgpu_vram_mgr_vis_usage(&adev->mman.vram_mgr);
> > +               amdgpu_bar_mgr_vis_usage(&adev->mman.vram_mgr);
> >
> >               if (used_vis_vram < total_vis_vram) {
> >                       u64 free_vis_vram =3D total_vis_vram - used_vis_v=
ram;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_dma_buf.c
> > index 271e30e34d93..c48ccde281c3 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> > @@ -179,9 +179,9 @@ static struct sg_table *amdgpu_dma_buf_map(struct d=
ma_buf_attachment *attach,
> >               break;
> >
> >       case TTM_PL_VRAM:
> > -             r =3D amdgpu_vram_mgr_alloc_sgt(adev, bo->tbo.resource, 0=
,
> > -                                           bo->tbo.base.size, attach->=
dev,
> > -                                           dir, &sgt);
> > +             r =3D amdgpu_bar_mgr_alloc_sgt(adev, bo->tbo.resource, 0,
> > +                                          bo->tbo.base.size, attach->d=
ev,
> > +                                          dir, &sgt);
> >               if (r)
> >                       return ERR_PTR(r);
> >               break;
> > @@ -215,7 +215,7 @@ static void amdgpu_dma_buf_unmap(struct dma_buf_att=
achment *attach,
> >               sg_free_table(sgt);
> >               kfree(sgt);
> >       } else {
> > -             amdgpu_vram_mgr_free_sgt(attach->dev, dir, sgt);
> > +             amdgpu_bar_mgr_free_sgt(attach->dev, dir, sgt);
> >       }
> >   }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_drv.c
> > index cd4caaa29528..9f148ea7ca66 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > @@ -2807,12 +2807,12 @@ static struct pci_error_handlers amdgpu_pci_err=
_handler =3D {
> >       .resume         =3D amdgpu_pci_resume,
> >   };
> >
> > -extern const struct attribute_group amdgpu_vram_mgr_attr_group;
> > +extern const struct attribute_group amdgpu_bar_mgr_attr_group;
> >   extern const struct attribute_group amdgpu_gtt_mgr_attr_group;
> >   extern const struct attribute_group amdgpu_vbios_version_attr_group;
> >
> >   static const struct attribute_group *amdgpu_sysfs_groups[] =3D {
> > -     &amdgpu_vram_mgr_attr_group,
> > +     &amdgpu_bar_mgr_attr_group,
> >       &amdgpu_gtt_mgr_attr_group,
> >       &amdgpu_vbios_version_attr_group,
> >       NULL,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_kms.c
> > index 7aa7e52ca784..2ce11434fb22 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > @@ -650,7 +650,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void =
*data, struct drm_file *filp)
> >               ui64 =3D ttm_resource_manager_usage(&adev->mman.vram_mgr.=
manager);
> >               return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT =
: 0;
> >       case AMDGPU_INFO_VIS_VRAM_USAGE:
> > -             ui64 =3D amdgpu_vram_mgr_vis_usage(&adev->mman.vram_mgr);
> > +             ui64 =3D amdgpu_bar_mgr_vis_usage(&adev->mman.vram_mgr);
> >               return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT =
: 0;
> >       case AMDGPU_INFO_GTT_USAGE:
> >               ui64 =3D ttm_resource_manager_usage(&adev->mman.gtt_mgr.m=
anager);
> > @@ -704,7 +704,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void =
*data, struct drm_file *filp)
> >                           atomic64_read(&adev->visible_pin_size),
> >                           mem.vram.usable_heap_size);
> >               mem.cpu_accessible_vram.heap_usage =3D
> > -                     amdgpu_vram_mgr_vis_usage(&adev->mman.vram_mgr);
> > +                     amdgpu_bar_mgr_vis_usage(&adev->mman.vram_mgr);
> >               mem.cpu_accessible_vram.max_allocation =3D
> >                       mem.cpu_accessible_vram.usable_heap_size * 3 / 4;
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_object.c
> > index 25a68d8888e0..ca85d64a72c2 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > @@ -958,7 +958,7 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, =
u32 domain,
> >       domain =3D amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type);
> >       if (domain =3D=3D AMDGPU_GEM_DOMAIN_VRAM) {
> >               atomic64_add(amdgpu_bo_size(bo), &adev->vram_pin_size);
> > -             atomic64_add(amdgpu_vram_mgr_bo_visible_size(bo),
> > +             atomic64_add(amdgpu_bar_mgr_bo_visible_size(bo),
> >                            &adev->visible_pin_size);
> >       } else if (domain =3D=3D AMDGPU_GEM_DOMAIN_GTT) {
> >               atomic64_add(amdgpu_bo_size(bo), &adev->gart_pin_size);
> > @@ -1009,7 +1009,7 @@ void amdgpu_bo_unpin(struct amdgpu_bo *bo)
> >
> >       if (bo->tbo.resource->mem_type =3D=3D TTM_PL_VRAM) {
> >               atomic64_sub(amdgpu_bo_size(bo), &adev->vram_pin_size);
> > -             atomic64_sub(amdgpu_vram_mgr_bo_visible_size(bo),
> > +             atomic64_sub(amdgpu_bar_mgr_bo_visible_size(bo),
> >                            &adev->visible_pin_size);
> >       } else if (bo->tbo.resource->mem_type =3D=3D TTM_PL_TT) {
> >               atomic64_sub(amdgpu_bo_size(bo), &adev->gart_pin_size);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ras.c
> > index ad490c1e2f57..4e64a035d49d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > @@ -1899,7 +1899,7 @@ static int amdgpu_ras_badpages_read(struct amdgpu=
_device *adev,
> >                       .size =3D AMDGPU_GPU_PAGE_SIZE,
> >                       .flags =3D AMDGPU_RAS_RETIRE_PAGE_RESERVED,
> >               };
> > -             status =3D amdgpu_vram_mgr_query_page_status(&adev->mman.=
vram_mgr,
> > +             status =3D amdgpu_bar_mgr_query_page_status(&adev->mman.v=
ram_mgr,
> >                               data->bps[i].retired_page);
> >               if (status =3D=3D -EBUSY)
> >                       (*bps)[i].flags =3D AMDGPU_RAS_RETIRE_PAGE_PENDIN=
G;
> > @@ -2012,7 +2012,7 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device=
 *adev,
> >                       goto out;
> >               }
> >
> > -             amdgpu_vram_mgr_reserve_range(&adev->mman.vram_mgr,
> > +             amdgpu_bar_mgr_reserve_range(&adev->mman.vram_mgr,
> >                       bps[i].retired_page << AMDGPU_GPU_PAGE_SHIFT,
> >                       AMDGPU_GPU_PAGE_SIZE);
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_res_cursor.h
> > index 5c4f93ee0c57..dd2b43acc600 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
> > @@ -68,7 +68,7 @@ static inline void amdgpu_res_first(struct ttm_resour=
ce *res,
> >
> >       switch (cur->mem_type) {
> >       case TTM_PL_VRAM:
> > -             head =3D &to_amdgpu_vram_mgr_resource(res)->blocks;
> > +             head =3D &to_amdgpu_bar_mgr_resource(res)->blocks;
> >
> >               block =3D list_first_entry_or_null(head,
> >                                                struct drm_buddy_block,
> > @@ -76,16 +76,16 @@ static inline void amdgpu_res_first(struct ttm_reso=
urce *res,
> >               if (!block)
> >                       goto fallback;
> >
> > -             while (start >=3D amdgpu_vram_mgr_block_size(block)) {
> > -                     start -=3D amdgpu_vram_mgr_block_size(block);
> > +             while (start >=3D amdgpu_bar_mgr_block_size(block)) {
> > +                     start -=3D amdgpu_bar_mgr_block_size(block);
> >
> >                       next =3D block->link.next;
> >                       if (next !=3D head)
> >                               block =3D list_entry(next, struct drm_bud=
dy_block, link);
> >               }
> >
> > -             cur->start =3D amdgpu_vram_mgr_block_start(block) + start=
;
> > -             cur->size =3D min(amdgpu_vram_mgr_block_size(block) - sta=
rt, size);
> > +             cur->start =3D amdgpu_bar_mgr_block_start(block) + start;
> > +             cur->size =3D min(amdgpu_bar_mgr_block_size(block) - star=
t, size);
> >               cur->remaining =3D size;
> >               cur->node =3D block;
> >               break;
> > @@ -148,8 +148,8 @@ static inline void amdgpu_res_next(struct amdgpu_re=
s_cursor *cur, uint64_t size)
> >               block =3D list_entry(next, struct drm_buddy_block, link);
> >
> >               cur->node =3D block;
> > -             cur->start =3D amdgpu_vram_mgr_block_start(block);
> > -             cur->size =3D min(amdgpu_vram_mgr_block_size(block), cur-=
>remaining);
> > +             cur->start =3D amdgpu_bar_mgr_block_start(block);
> > +             cur->size =3D min(amdgpu_bar_mgr_block_size(block), cur->=
remaining);
> >               break;
> >       case TTM_PL_TT:
> >               node =3D cur->node;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ttm.c
> > index 55e0284b2bdd..668826653591 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > @@ -1735,7 +1735,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
> >       adev->mman.initialized =3D true;
> >
> >       /* Initialize VRAM pool with all of VRAM divided into pages */
> > -     r =3D amdgpu_vram_mgr_init(adev);
> > +     r =3D amdgpu_bar_mgr_init(adev, TTM_PL_VRAM);
> >       if (r) {
> >               DRM_ERROR("Failed initializing VRAM heap.\n");
> >               return r;
> > @@ -1911,7 +1911,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
> >               drm_dev_exit(idx);
> >       }
> >
> > -     amdgpu_vram_mgr_fini(adev);
> > +     amdgpu_bar_mgr_fini(adev, TTM_PL_VRAM);
> >       amdgpu_gtt_mgr_fini(adev);
> >       amdgpu_preempt_mgr_fini(adev);
> >       ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_GDS);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ttm.h
> > index e2cd5894afc9..a918bbd67004 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> > @@ -61,7 +61,7 @@ struct amdgpu_mman {
> >       /* Scheduler entity for buffer moves */
> >       struct drm_sched_entity                 entity;
> >
> > -     struct amdgpu_vram_mgr vram_mgr;
> > +     struct amdgpu_bar_mgr vram_mgr;
> >       struct amdgpu_gtt_mgr gtt_mgr;
> >       struct ttm_resource_manager preempt_mgr;
> >
> > @@ -107,29 +107,29 @@ int amdgpu_gtt_mgr_init(struct amdgpu_device *ade=
v, uint64_t gtt_size);
> >   void amdgpu_gtt_mgr_fini(struct amdgpu_device *adev);
> >   int amdgpu_preempt_mgr_init(struct amdgpu_device *adev);
> >   void amdgpu_preempt_mgr_fini(struct amdgpu_device *adev);
> > -int amdgpu_vram_mgr_init(struct amdgpu_device *adev);
> > -void amdgpu_vram_mgr_fini(struct amdgpu_device *adev);
> > +int amdgpu_bar_mgr_init(struct amdgpu_device *adev, u32 domain);
> > +void amdgpu_bar_mgr_fini(struct amdgpu_device *adev, u32 domain);
> >
> >   bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *mem);
> >   void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr);
> >
> >   uint64_t amdgpu_preempt_mgr_usage(struct ttm_resource_manager *man);
> >
> > -u64 amdgpu_vram_mgr_bo_visible_size(struct amdgpu_bo *bo);
> > -int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
> > -                           struct ttm_resource *mem,
> > -                           u64 offset, u64 size,
> > -                           struct device *dev,
> > -                           enum dma_data_direction dir,
> > -                           struct sg_table **sgt);
> > -void amdgpu_vram_mgr_free_sgt(struct device *dev,
> > -                           enum dma_data_direction dir,
> > -                           struct sg_table *sgt);
> > -uint64_t amdgpu_vram_mgr_vis_usage(struct amdgpu_vram_mgr *mgr);
> > -int amdgpu_vram_mgr_reserve_range(struct amdgpu_vram_mgr *mgr,
> > -                               uint64_t start, uint64_t size);
> > -int amdgpu_vram_mgr_query_page_status(struct amdgpu_vram_mgr *mgr,
> > -                                   uint64_t start);
> > +u64 amdgpu_bar_mgr_bo_visible_size(struct amdgpu_bo *bo);
> > +int amdgpu_bar_mgr_alloc_sgt(struct amdgpu_device *adev,
> > +                          struct ttm_resource *mem,
> > +                          u64 offset, u64 size,
> > +                          struct device *dev,
> > +                          enum dma_data_direction dir,
> > +                          struct sg_table **sgt);
> > +void amdgpu_bar_mgr_free_sgt(struct device *dev,
> > +                          enum dma_data_direction dir,
> > +                          struct sg_table *sgt);
> > +uint64_t amdgpu_bar_mgr_vis_usage(struct amdgpu_bar_mgr *mgr);
> > +int amdgpu_bar_mgr_reserve_range(struct amdgpu_bar_mgr *mgr,
> > +                              uint64_t start, uint64_t size);
> > +int amdgpu_bar_mgr_query_page_status(struct amdgpu_bar_mgr *mgr,
> > +                                  uint64_t start);
> >
> >   int amdgpu_ttm_init(struct amdgpu_device *adev);
> >   void amdgpu_ttm_fini(struct amdgpu_device *adev);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_virt.c
> > index 2994b9db196f..fc9edc3028b6 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> > @@ -599,7 +599,7 @@ static int amdgpu_virt_write_vf2pf_data(struct amdg=
pu_device *adev)
> >       vf2pf_info->fb_usage =3D
> >               ttm_resource_manager_usage(&adev->mman.vram_mgr.manager) =
>> 20;
> >       vf2pf_info->fb_vis_usage =3D
> > -             amdgpu_vram_mgr_vis_usage(&adev->mman.vram_mgr) >> 20;
> > +             amdgpu_bar_mgr_vis_usage(&adev->mman.vram_mgr) >> 20;
> >       vf2pf_info->fb_size =3D adev->gmc.real_vram_size >> 20;
> >       vf2pf_info->fb_vis_size =3D adev->gmc.visible_vram_size >> 20;
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_vram_mgr.c
> > index 9fa1d814508a..30d68e3a2469 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> > @@ -31,46 +31,46 @@
> >   #include "amdgpu_atomfirmware.h"
> >   #include "atom.h"
> >
> > -struct amdgpu_vram_reservation {
> > +struct amdgpu_bar_reservation {
> >       u64 start;
> >       u64 size;
> >       struct list_head allocated;
> >       struct list_head blocks;
> >   };
> >
> > -static inline struct amdgpu_vram_mgr *
> > -to_vram_mgr(struct ttm_resource_manager *man)
> > +static inline struct amdgpu_bar_mgr *
> > +to_bar_mgr(struct ttm_resource_manager *man)
> >   {
> > -     return container_of(man, struct amdgpu_vram_mgr, manager);
> > +     return container_of(man, struct amdgpu_bar_mgr, manager);
> >   }
> >
> >   static inline struct amdgpu_device *
> > -to_amdgpu_device(struct amdgpu_vram_mgr *mgr)
> > +to_amdgpu_device(struct amdgpu_bar_mgr *mgr)
> >   {
> >       return container_of(mgr, struct amdgpu_device, mman.vram_mgr);
> >   }
> >
> >   static inline struct drm_buddy_block *
> > -amdgpu_vram_mgr_first_block(struct list_head *list)
> > +amdgpu_bar_mgr_first_block(struct list_head *list)
> >   {
> >       return list_first_entry_or_null(list, struct drm_buddy_block, lin=
k);
> >   }
> >
> > -static inline bool amdgpu_is_vram_mgr_blocks_contiguous(struct list_he=
ad *head)
> > +static inline bool amdgpu_is_bar_mgr_blocks_contiguous(struct list_hea=
d *head)
> >   {
> >       struct drm_buddy_block *block;
> >       u64 start, size;
> >
> > -     block =3D amdgpu_vram_mgr_first_block(head);
> > +     block =3D amdgpu_bar_mgr_first_block(head);
> >       if (!block)
> >               return false;
> >
> >       while (head !=3D block->link.next) {
> > -             start =3D amdgpu_vram_mgr_block_start(block);
> > -             size =3D amdgpu_vram_mgr_block_size(block);
> > +             start =3D amdgpu_bar_mgr_block_start(block);
> > +             size =3D amdgpu_bar_mgr_block_size(block);
> >
> >               block =3D list_entry(block->link.next, struct drm_buddy_b=
lock, link);
> > -             if (start + size !=3D amdgpu_vram_mgr_block_start(block))
> > +             if (start + size !=3D amdgpu_bar_mgr_block_start(block))
> >                       return false;
> >       }
> >
> > @@ -100,7 +100,7 @@ static ssize_t amdgpu_mem_info_vram_total_show(stru=
ct device *dev,
> >    * DOC: mem_info_vis_vram_total
> >    *
> >    * The amdgpu driver provides a sysfs API for reporting current total
> > - * visible VRAM available on the device
> > + * visible BAR available on the device
> >    * The file mem_info_vis_vram_total is used for this and returns the =
total
> >    * amount of visible VRAM in bytes
> >    */
> > @@ -148,7 +148,7 @@ static ssize_t amdgpu_mem_info_vis_vram_used_show(s=
truct device *dev,
> >       struct amdgpu_device *adev =3D drm_to_adev(ddev);
> >
> >       return sysfs_emit(buf, "%llu\n",
> > -                       amdgpu_vram_mgr_vis_usage(&adev->mman.vram_mgr)=
);
> > +                       amdgpu_bar_mgr_vis_usage(&adev->mman.vram_mgr))=
;
> >   }
> >
> >   /**
> > @@ -203,7 +203,7 @@ static DEVICE_ATTR(mem_info_vis_vram_used, S_IRUGO,
> >   static DEVICE_ATTR(mem_info_vram_vendor, S_IRUGO,
> >                  amdgpu_mem_info_vram_vendor, NULL);
> >
> > -static struct attribute *amdgpu_vram_mgr_attributes[] =3D {
> > +static struct attribute *amdgpu_bar_mgr_attributes[] =3D {
> >       &dev_attr_mem_info_vram_total.attr,
> >       &dev_attr_mem_info_vis_vram_total.attr,
> >       &dev_attr_mem_info_vram_used.attr,
> > @@ -212,23 +212,23 @@ static struct attribute *amdgpu_vram_mgr_attribut=
es[] =3D {
> >       NULL
> >   };
> >
> > -const struct attribute_group amdgpu_vram_mgr_attr_group =3D {
> > -     .attrs =3D amdgpu_vram_mgr_attributes
> > +const struct attribute_group amdgpu_bar_mgr_attr_group =3D {
> > +     .attrs =3D amdgpu_bar_mgr_attributes
> >   };
> >
> >   /**
> > - * amdgpu_vram_mgr_vis_size - Calculate visible block size
> > + * amdgpu_bar_mgr_vis_size - Calculate visible block size
> >    *
> >    * @adev: amdgpu_device pointer
> >    * @block: DRM BUDDY block structure
> >    *
> >    * Calculate how many bytes of the DRM BUDDY block are inside visible=
 VRAM
> >    */
> > -static u64 amdgpu_vram_mgr_vis_size(struct amdgpu_device *adev,
> > +static u64 amdgpu_bar_mgr_vis_size(struct amdgpu_device *adev,
> >                                   struct drm_buddy_block *block)
> >   {
> > -     u64 start =3D amdgpu_vram_mgr_block_start(block);
> > -     u64 end =3D start + amdgpu_vram_mgr_block_size(block);
> > +     u64 start =3D amdgpu_bar_mgr_block_start(block);
> > +     u64 end =3D start + amdgpu_bar_mgr_block_size(block);
> >
> >       if (start >=3D adev->gmc.visible_vram_size)
> >               return 0;
> > @@ -238,18 +238,18 @@ static u64 amdgpu_vram_mgr_vis_size(struct amdgpu=
_device *adev,
> >   }
> >
> >   /**
> > - * amdgpu_vram_mgr_bo_visible_size - CPU visible BO size
> > + * amdgpu_bar_mgr_bo_visible_size - CPU visible BO size
> >    *
> >    * @bo: &amdgpu_bo buffer object (must be in VRAM)
> >    *
> >    * Returns:
> >    * How much of the given &amdgpu_bo buffer object lies in CPU visible=
 VRAM.
> >    */
> > -u64 amdgpu_vram_mgr_bo_visible_size(struct amdgpu_bo *bo)
> > +u64 amdgpu_bar_mgr_bo_visible_size(struct amdgpu_bo *bo)
> >   {
> >       struct amdgpu_device *adev =3D amdgpu_ttm_adev(bo->tbo.bdev);
> >       struct ttm_resource *res =3D bo->tbo.resource;
> > -     struct amdgpu_vram_mgr_resource *vres =3D to_amdgpu_vram_mgr_reso=
urce(res);
> > +     struct amdgpu_bar_mgr_resource *vres =3D to_amdgpu_bar_mgr_resour=
ce(res);
> >       struct drm_buddy_block *block;
> >       u64 usage =3D 0;
> >
> > @@ -260,18 +260,18 @@ u64 amdgpu_vram_mgr_bo_visible_size(struct amdgpu=
_bo *bo)
> >               return 0;
> >
> >       list_for_each_entry(block, &vres->blocks, link)
> > -             usage +=3D amdgpu_vram_mgr_vis_size(adev, block);
> > +             usage +=3D amdgpu_bar_mgr_vis_size(adev, block);
> >
> >       return usage;
> >   }
> >
> >   /* Commit the reservation of VRAM pages */
> > -static void amdgpu_vram_mgr_do_reserve(struct ttm_resource_manager *ma=
n)
> > +static void amdgpu_bar_mgr_do_reserve(struct ttm_resource_manager *man=
)
> >   {
> > -     struct amdgpu_vram_mgr *mgr =3D to_vram_mgr(man);
> > +     struct amdgpu_bar_mgr *mgr =3D to_bar_mgr(man);
> >       struct amdgpu_device *adev =3D to_amdgpu_device(mgr);
> >       struct drm_buddy *mm =3D &mgr->mm;
> > -     struct amdgpu_vram_reservation *rsv, *temp;
> > +     struct amdgpu_bar_reservation *rsv, *temp;
> >       struct drm_buddy_block *block;
> >       uint64_t vis_usage;
> >
> > @@ -281,14 +281,14 @@ static void amdgpu_vram_mgr_do_reserve(struct ttm=
_resource_manager *man)
> >                                          DRM_BUDDY_RANGE_ALLOCATION))
> >                       continue;
> >
> > -             block =3D amdgpu_vram_mgr_first_block(&rsv->allocated);
> > +             block =3D amdgpu_bar_mgr_first_block(&rsv->allocated);
> >               if (!block)
> >                       continue;
> >
> >               dev_dbg(adev->dev, "Reservation 0x%llx - %lld, Succeeded\=
n",
> >                       rsv->start, rsv->size);
> >
> > -             vis_usage =3D amdgpu_vram_mgr_vis_size(adev, block);
> > +             vis_usage =3D amdgpu_bar_mgr_vis_size(adev, block);
> >               atomic64_add(vis_usage, &mgr->vis_usage);
> >               spin_lock(&man->bdev->lru_lock);
> >               man->usage +=3D rsv->size;
> > @@ -298,18 +298,18 @@ static void amdgpu_vram_mgr_do_reserve(struct ttm=
_resource_manager *man)
> >   }
> >
> >   /**
> > - * amdgpu_vram_mgr_reserve_range - Reserve a range from VRAM
> > + * amdgpu_bar_mgr_reserve_range - Reserve a range from VRAM
> >    *
> > - * @mgr: amdgpu_vram_mgr pointer
> > + * @mgr: amdgpu_bar_mgr pointer
> >    * @start: start address of the range in VRAM
> >    * @size: size of the range
> >    *
> >    * Reserve memory from start address with the specified size in VRAM
> >    */
> > -int amdgpu_vram_mgr_reserve_range(struct amdgpu_vram_mgr *mgr,
> > +int amdgpu_bar_mgr_reserve_range(struct amdgpu_bar_mgr *mgr,
> >                                 uint64_t start, uint64_t size)
> >   {
> > -     struct amdgpu_vram_reservation *rsv;
> > +     struct amdgpu_bar_reservation *rsv;
> >
> >       rsv =3D kzalloc(sizeof(*rsv), GFP_KERNEL);
> >       if (!rsv)
> > @@ -323,16 +323,16 @@ int amdgpu_vram_mgr_reserve_range(struct amdgpu_v=
ram_mgr *mgr,
> >
> >       mutex_lock(&mgr->lock);
> >       list_add_tail(&rsv->blocks, &mgr->reservations_pending);
> > -     amdgpu_vram_mgr_do_reserve(&mgr->manager);
> > +     amdgpu_bar_mgr_do_reserve(&mgr->manager);
> >       mutex_unlock(&mgr->lock);
> >
> >       return 0;
> >   }
> >
> >   /**
> > - * amdgpu_vram_mgr_query_page_status - query the reservation status
> > + * amdgpu_bar_mgr_query_page_status - query the reservation status
> >    *
> > - * @mgr: amdgpu_vram_mgr pointer
> > + * @mgr: amdgpu_bar_mgr pointer
> >    * @start: start address of a page in VRAM
> >    *
> >    * Returns:
> > @@ -340,10 +340,10 @@ int amdgpu_vram_mgr_reserve_range(struct amdgpu_v=
ram_mgr *mgr,
> >    *  0: the page has been reserved
> >    *  -ENOENT: the input page is not a reservation
> >    */
> > -int amdgpu_vram_mgr_query_page_status(struct amdgpu_vram_mgr *mgr,
> > +int amdgpu_bar_mgr_query_page_status(struct amdgpu_bar_mgr *mgr,
> >                                     uint64_t start)
> >   {
> > -     struct amdgpu_vram_reservation *rsv;
> > +     struct amdgpu_bar_reservation *rsv;
> >       int ret;
> >
> >       mutex_lock(&mgr->lock);
> > @@ -371,7 +371,7 @@ int amdgpu_vram_mgr_query_page_status(struct amdgpu=
_vram_mgr *mgr,
> >   }
> >
> >   /**
> > - * amdgpu_vram_mgr_new - allocate new ranges
> > + * amdgpu_bar_mgr_new - allocate new ranges
> >    *
> >    * @man: TTM memory type manager
> >    * @tbo: TTM BO we need this range for
> > @@ -380,15 +380,15 @@ int amdgpu_vram_mgr_query_page_status(struct amdg=
pu_vram_mgr *mgr,
> >    *
> >    * Allocate VRAM for the given BO.
> >    */
> > -static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
> > +static int amdgpu_bar_mgr_new(struct ttm_resource_manager *man,
> >                              struct ttm_buffer_object *tbo,
> >                              const struct ttm_place *place,
> >                              struct ttm_resource **res)
> >   {
> >       u64 vis_usage =3D 0, max_bytes, cur_size, min_block_size;
> > -     struct amdgpu_vram_mgr *mgr =3D to_vram_mgr(man);
> > +     struct amdgpu_bar_mgr *mgr =3D to_bar_mgr(man);
> >       struct amdgpu_device *adev =3D to_amdgpu_device(mgr);
> > -     struct amdgpu_vram_mgr_resource *vres;
> > +     struct amdgpu_bar_mgr_resource *vres;
> >       u64 size, remaining_size, lpfn, fpfn;
> >       struct drm_buddy *mm =3D &mgr->mm;
> >       struct drm_buddy_block *block;
> > @@ -512,7 +512,7 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_=
manager *man,
> >                        * Compute the original_size value by subtracting=
 the
> >                        * last block size with (aligned size - original =
size)
> >                        */
> > -                     original_size =3D amdgpu_vram_mgr_block_size(bloc=
k) - (size - cur_size);
> > +                     original_size =3D amdgpu_bar_mgr_block_size(block=
) - (size - cur_size);
> >               }
> >
> >               mutex_lock(&mgr->lock);
> > @@ -529,8 +529,8 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_=
manager *man,
> >       list_for_each_entry(block, &vres->blocks, link) {
> >               unsigned long start;
> >
> > -             start =3D amdgpu_vram_mgr_block_start(block) +
> > -                     amdgpu_vram_mgr_block_size(block);
> > +             start =3D amdgpu_bar_mgr_block_start(block) +
> > +                     amdgpu_bar_mgr_block_size(block);
> >               start >>=3D PAGE_SHIFT;
> >
> >               if (start > PFN_UP(vres->base.size))
> > @@ -539,10 +539,10 @@ static int amdgpu_vram_mgr_new(struct ttm_resourc=
e_manager *man,
> >                       start =3D 0;
> >               vres->base.start =3D max(vres->base.start, start);
> >
> > -             vis_usage +=3D amdgpu_vram_mgr_vis_size(adev, block);
> > +             vis_usage +=3D amdgpu_bar_mgr_vis_size(adev, block);
> >       }
> >
> > -     if (amdgpu_is_vram_mgr_blocks_contiguous(&vres->blocks))
> > +     if (amdgpu_is_bar_mgr_blocks_contiguous(&vres->blocks))
> >               vres->base.placement |=3D TTM_PL_FLAG_CONTIGUOUS;
> >
> >       if (adev->gmc.xgmi.connected_to_cpu)
> > @@ -565,18 +565,18 @@ static int amdgpu_vram_mgr_new(struct ttm_resourc=
e_manager *man,
> >   }
> >
> >   /**
> > - * amdgpu_vram_mgr_del - free ranges
> > + * amdgpu_bar_mgr_del - free ranges
> >    *
> >    * @man: TTM memory type manager
> >    * @res: TTM memory object
> >    *
> >    * Free the allocated VRAM again.
> >    */
> > -static void amdgpu_vram_mgr_del(struct ttm_resource_manager *man,
> > +static void amdgpu_bar_mgr_del(struct ttm_resource_manager *man,
> >                               struct ttm_resource *res)
> >   {
> > -     struct amdgpu_vram_mgr_resource *vres =3D to_amdgpu_vram_mgr_reso=
urce(res);
> > -     struct amdgpu_vram_mgr *mgr =3D to_vram_mgr(man);
> > +     struct amdgpu_bar_mgr_resource *vres =3D to_amdgpu_bar_mgr_resour=
ce(res);
> > +     struct amdgpu_bar_mgr *mgr =3D to_bar_mgr(man);
> >       struct amdgpu_device *adev =3D to_amdgpu_device(mgr);
> >       struct drm_buddy *mm =3D &mgr->mm;
> >       struct drm_buddy_block *block;
> > @@ -584,9 +584,9 @@ static void amdgpu_vram_mgr_del(struct ttm_resource=
_manager *man,
> >
> >       mutex_lock(&mgr->lock);
> >       list_for_each_entry(block, &vres->blocks, link)
> > -             vis_usage +=3D amdgpu_vram_mgr_vis_size(adev, block);
> > +             vis_usage +=3D amdgpu_bar_mgr_vis_size(adev, block);
> >
> > -     amdgpu_vram_mgr_do_reserve(man);
> > +     amdgpu_bar_mgr_do_reserve(man);
> >
> >       drm_buddy_free_list(mm, &vres->blocks);
> >       mutex_unlock(&mgr->lock);
> > @@ -598,7 +598,7 @@ static void amdgpu_vram_mgr_del(struct ttm_resource=
_manager *man,
> >   }
> >
> >   /**
> > - * amdgpu_vram_mgr_alloc_sgt - allocate and fill a sg table
> > + * amdgpu_bar_mgr_alloc_sgt - allocate and fill a sg table
> >    *
> >    * @adev: amdgpu device pointer
> >    * @res: TTM memory object
> > @@ -610,7 +610,7 @@ static void amdgpu_vram_mgr_del(struct ttm_resource=
_manager *man,
> >    *
> >    * Allocate and fill a sg table from a VRAM allocation.
> >    */
> > -int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
> > +int amdgpu_bar_mgr_alloc_sgt(struct amdgpu_device *adev,
> >                             struct ttm_resource *res,
> >                             u64 offset, u64 length,
> >                             struct device *dev,
> > @@ -685,7 +685,7 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device =
*adev,
> >   }
> >
> >   /**
> > - * amdgpu_vram_mgr_free_sgt - allocate and fill a sg table
> > + * amdgpu_bar_mgr_free_sgt - allocate and fill a sg table
> >    *
> >    * @dev: device pointer
> >    * @dir: data direction of resource to unmap
> > @@ -693,7 +693,7 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device =
*adev,
> >    *
> >    * Free a previously allocate sg table.
> >    */
> > -void amdgpu_vram_mgr_free_sgt(struct device *dev,
> > +void amdgpu_bar_mgr_free_sgt(struct device *dev,
> >                             enum dma_data_direction dir,
> >                             struct sg_table *sgt)
> >   {
> > @@ -709,19 +709,19 @@ void amdgpu_vram_mgr_free_sgt(struct device *dev,
> >   }
> >
> >   /**
> > - * amdgpu_vram_mgr_vis_usage - how many bytes are used in the visible =
part
> > + * amdgpu_bar_mgr_vis_usage - how many bytes are used in the visible p=
art
> >    *
> > - * @mgr: amdgpu_vram_mgr pointer
> > + * @mgr: amdgpu_bar_mgr pointer
> >    *
> >    * Returns how many bytes are used in the visible part of VRAM
> >    */
> > -uint64_t amdgpu_vram_mgr_vis_usage(struct amdgpu_vram_mgr *mgr)
> > +uint64_t amdgpu_bar_mgr_vis_usage(struct amdgpu_bar_mgr *mgr)
> >   {
> >       return atomic64_read(&mgr->vis_usage);
> >   }
> >
> >   /**
> > - * amdgpu_vram_mgr_intersects - test each drm buddy block for intersec=
tion
> > + * amdgpu_bar_mgr_intersects - test each drm buddy block for intersect=
ion
> >    *
> >    * @man: TTM memory type manager
> >    * @res: The resource to test
> > @@ -730,20 +730,20 @@ uint64_t amdgpu_vram_mgr_vis_usage(struct amdgpu_=
vram_mgr *mgr)
> >    *
> >    * Test each drm buddy block for intersection for eviction decision.
> >    */
> > -static bool amdgpu_vram_mgr_intersects(struct ttm_resource_manager *ma=
n,
> > +static bool amdgpu_bar_mgr_intersects(struct ttm_resource_manager *man=
,
> >                                      struct ttm_resource *res,
> >                                      const struct ttm_place *place,
> >                                      size_t size)
> >   {
> > -     struct amdgpu_vram_mgr_resource *mgr =3D to_amdgpu_vram_mgr_resou=
rce(res);
> > +     struct amdgpu_bar_mgr_resource *mgr =3D to_amdgpu_bar_mgr_resourc=
e(res);
> >       struct drm_buddy_block *block;
> >
> >       /* Check each drm buddy block individually */
> >       list_for_each_entry(block, &mgr->blocks, link) {
> >               unsigned long fpfn =3D
> > -                     amdgpu_vram_mgr_block_start(block) >> PAGE_SHIFT;
> > +                     amdgpu_bar_mgr_block_start(block) >> PAGE_SHIFT;
> >               unsigned long lpfn =3D fpfn +
> > -                     (amdgpu_vram_mgr_block_size(block) >> PAGE_SHIFT)=
;
> > +                     (amdgpu_bar_mgr_block_size(block) >> PAGE_SHIFT);
> >
> >               if (place->fpfn < lpfn &&
> >                   (!place->lpfn || place->lpfn > fpfn))
> > @@ -754,7 +754,7 @@ static bool amdgpu_vram_mgr_intersects(struct ttm_r=
esource_manager *man,
> >   }
> >
> >   /**
> > - * amdgpu_vram_mgr_compatible - test each drm buddy block for compatib=
ility
> > + * amdgpu_bar_mgr_compatible - test each drm buddy block for compatibi=
lity
> >    *
> >    * @man: TTM memory type manager
> >    * @res: The resource to test
> > @@ -763,20 +763,20 @@ static bool amdgpu_vram_mgr_intersects(struct ttm=
_resource_manager *man,
> >    *
> >    * Test each drm buddy block for placement compatibility.
> >    */
> > -static bool amdgpu_vram_mgr_compatible(struct ttm_resource_manager *ma=
n,
> > +static bool amdgpu_bar_mgr_compatible(struct ttm_resource_manager *man=
,
> >                                      struct ttm_resource *res,
> >                                      const struct ttm_place *place,
> >                                      size_t size)
> >   {
> > -     struct amdgpu_vram_mgr_resource *mgr =3D to_amdgpu_vram_mgr_resou=
rce(res);
> > +     struct amdgpu_bar_mgr_resource *mgr =3D to_amdgpu_bar_mgr_resourc=
e(res);
> >       struct drm_buddy_block *block;
> >
> >       /* Check each drm buddy block individually */
> >       list_for_each_entry(block, &mgr->blocks, link) {
> >               unsigned long fpfn =3D
> > -                     amdgpu_vram_mgr_block_start(block) >> PAGE_SHIFT;
> > +                     amdgpu_bar_mgr_block_start(block) >> PAGE_SHIFT;
> >               unsigned long lpfn =3D fpfn +
> > -                     (amdgpu_vram_mgr_block_size(block) >> PAGE_SHIFT)=
;
> > +                     (amdgpu_bar_mgr_block_size(block) >> PAGE_SHIFT);
> >
> >               if (fpfn < place->fpfn ||
> >                   (place->lpfn && lpfn > place->lpfn))
> > @@ -787,22 +787,22 @@ static bool amdgpu_vram_mgr_compatible(struct ttm=
_resource_manager *man,
> >   }
> >
> >   /**
> > - * amdgpu_vram_mgr_debug - dump VRAM table
> > + * amdgpu_bar_mgr_debug - dump VRAM table
> >    *
> >    * @man: TTM memory type manager
> >    * @printer: DRM printer to use
> >    *
> >    * Dump the table content using printk.
> >    */
> > -static void amdgpu_vram_mgr_debug(struct ttm_resource_manager *man,
> > +static void amdgpu_bar_mgr_debug(struct ttm_resource_manager *man,
> >                                 struct drm_printer *printer)
> >   {
> > -     struct amdgpu_vram_mgr *mgr =3D to_vram_mgr(man);
> > +     struct amdgpu_bar_mgr *mgr =3D to_bar_mgr(man);
> >       struct drm_buddy *mm =3D &mgr->mm;
> >       struct drm_buddy_block *block;
> >
> >       drm_printf(printer, "  vis usage:%llu\n",
> > -                amdgpu_vram_mgr_vis_usage(mgr));
> > +                amdgpu_bar_mgr_vis_usage(mgr));
> >
> >       mutex_lock(&mgr->lock);
> >       drm_printf(printer, "default_page_size: %lluKiB\n",
> > @@ -816,31 +816,38 @@ static void amdgpu_vram_mgr_debug(struct ttm_reso=
urce_manager *man,
> >       mutex_unlock(&mgr->lock);
> >   }
> >
> > -static const struct ttm_resource_manager_func amdgpu_vram_mgr_func =3D=
 {
> > -     .alloc  =3D amdgpu_vram_mgr_new,
> > -     .free   =3D amdgpu_vram_mgr_del,
> > -     .intersects =3D amdgpu_vram_mgr_intersects,
> > -     .compatible =3D amdgpu_vram_mgr_compatible,
> > -     .debug  =3D amdgpu_vram_mgr_debug
> > +static const struct ttm_resource_manager_func amdgpu_bar_mgr_func =3D =
{
> > +     .alloc  =3D amdgpu_bar_mgr_new,
> > +     .free   =3D amdgpu_bar_mgr_del,
> > +     .intersects =3D amdgpu_bar_mgr_intersects,
> > +     .compatible =3D amdgpu_bar_mgr_compatible,
> > +     .debug  =3D amdgpu_bar_mgr_debug
> >   };
> >
> >   /**
> > - * amdgpu_vram_mgr_init - init VRAM manager and DRM MM
> > + * amdgpu_bar_mgr_init - init BAR manager and DRM MM
> >    *
> >    * @adev: amdgpu_device pointer
> > + * @domain: memory domain to initialize
> >    *
> >    * Allocate and initialize the VRAM manager.
> >    */
> > -int amdgpu_vram_mgr_init(struct amdgpu_device *adev)
> > +int amdgpu_bar_mgr_init(struct amdgpu_device *adev, u32 domain)
> >   {
> > -     struct amdgpu_vram_mgr *mgr =3D &adev->mman.vram_mgr;
> > -     struct ttm_resource_manager *man =3D &mgr->manager;
> > +     struct amdgpu_bar_mgr *mgr;
> > +     struct ttm_resource_manager *man;
> >       int err;
> >
> > +     if (domain !=3D TTM_PL_VRAM)
> > +             return -EINVAL;
> > +
> > +     mgr =3D &adev->mman.vram_mgr;
> > +     man =3D &mgr->manager;
> > +
> >       ttm_resource_manager_init(man, &adev->mman.bdev,
> >                                 adev->gmc.real_vram_size);
> >
> > -     man->func =3D &amdgpu_vram_mgr_func;
> > +     man->func =3D &amdgpu_bar_mgr_func;
> >
> >       err =3D drm_buddy_init(&mgr->mm, man->size, PAGE_SIZE);
> >       if (err)
> > @@ -851,25 +858,32 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *ad=
ev)
> >       INIT_LIST_HEAD(&mgr->reserved_pages);
> >       mgr->default_page_size =3D PAGE_SIZE;
> >
> > -     ttm_set_driver_manager(&adev->mman.bdev, TTM_PL_VRAM, &mgr->manag=
er);
> > +     ttm_set_driver_manager(&adev->mman.bdev, domain, &mgr->manager);
> >       ttm_resource_manager_set_used(man, true);
> >       return 0;
> >   }
> >
> >   /**
> > - * amdgpu_vram_mgr_fini - free and destroy VRAM manager
> > + * amdgpu_bar_mgr_fini - free and destroy VRAM manager
> >    *
> >    * @adev: amdgpu_device pointer
> > + * @domain: memory domain to destroy
> >    *
> > - * Destroy and free the VRAM manager, returns -EBUSY if ranges are sti=
ll
> > + * Destroy and free the BAR manager, returns -EBUSY if ranges are stil=
l
> >    * allocated inside it.
> >    */
> > -void amdgpu_vram_mgr_fini(struct amdgpu_device *adev)
> > +void amdgpu_bar_mgr_fini(struct amdgpu_device *adev, u32 domain)
> >   {
> > -     struct amdgpu_vram_mgr *mgr =3D &adev->mman.vram_mgr;
> > -     struct ttm_resource_manager *man =3D &mgr->manager;
> > +     struct amdgpu_bar_mgr *mgr;
> > +     struct ttm_resource_manager *man;
> >       int ret;
> > -     struct amdgpu_vram_reservation *rsv, *temp;
> > +     struct amdgpu_bar_reservation *rsv, *temp;
> > +
> > +     if (domain !=3D TTM_PL_VRAM)
> > +             return;
> > +
> > +     mgr =3D &adev->mman.vram_mgr;
> > +     man =3D &mgr->manager;
> >
> >       ttm_resource_manager_set_used(man, false);
> >
> > @@ -889,5 +903,5 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device *ade=
v)
> >       mutex_unlock(&mgr->lock);
> >
> >       ttm_resource_manager_cleanup(man);
> > -     ttm_set_driver_manager(&adev->mman.bdev, TTM_PL_VRAM, NULL);
> > +     ttm_set_driver_manager(&adev->mman.bdev, domain, NULL);
> >   }
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_vram_mgr.h
> > index 0e04e42cf809..241faba5ae55 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
> > @@ -21,12 +21,12 @@
> >    *
> >    */
> >
> > -#ifndef __AMDGPU_VRAM_MGR_H__
> > -#define __AMDGPU_VRAM_MGR_H__
> > +#ifndef __AMDGPU_BAR_MGR_H__
> > +#define __AMDGPU_BAR_MGR_H__
> >
> >   #include <drm/drm_buddy.h>
> >
> > -struct amdgpu_vram_mgr {
> > +struct amdgpu_bar_mgr {
> >       struct ttm_resource_manager manager;
> >       struct drm_buddy mm;
> >       /* protects access to buffer objects */
> > @@ -37,26 +37,26 @@ struct amdgpu_vram_mgr {
> >       u64 default_page_size;
> >   };
> >
> > -struct amdgpu_vram_mgr_resource {
> > +struct amdgpu_bar_mgr_resource {
> >       struct ttm_resource base;
> >       struct list_head blocks;
> >       unsigned long flags;
> >   };
> >
> > -static inline u64 amdgpu_vram_mgr_block_start(struct drm_buddy_block *=
block)
> > +static inline u64 amdgpu_bar_mgr_block_start(struct drm_buddy_block *b=
lock)
> >   {
> >       return drm_buddy_block_offset(block);
> >   }
> >
> > -static inline u64 amdgpu_vram_mgr_block_size(struct drm_buddy_block *b=
lock)
> > +static inline u64 amdgpu_bar_mgr_block_size(struct drm_buddy_block *bl=
ock)
> >   {
> >       return (u64)PAGE_SIZE << drm_buddy_block_order(block);
> >   }
> >
> > -static inline struct amdgpu_vram_mgr_resource *
> > -to_amdgpu_vram_mgr_resource(struct ttm_resource *res)
> > +static inline struct amdgpu_bar_mgr_resource *
> > +to_amdgpu_bar_mgr_resource(struct ttm_resource *res)
> >   {
> > -     return container_of(res, struct amdgpu_vram_mgr_resource, base);
> > +     return container_of(res, struct amdgpu_bar_mgr_resource, base);
> >   }
> >
> >   #endif
>
