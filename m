Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F09D5C636D4
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Feb 2023 16:30:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51B5E10E40B;
	Mon,  6 Feb 2023 16:30:24 +0000 (UTC)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 491F710E40B
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Feb 2023 16:30:22 +0000 (UTC)
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-16a27344a17so6383828fac.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Feb 2023 08:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uGgBD+fRIPT6GMwuQsq3uggiIEmseaUMqxHVVV0kVSg=;
 b=P8rV+naST7smIC4BXO6SJ/yIfNNKvzmeyjMrhvnDxUzjqp5jzJulAixIym/UUinRN6
 bfmyNd1S4Chxm040/P4ABMSWe+D/glP7e7aJBj3BGfOJ65qQVK/QBE3XGpNGZ2gdNVOA
 O8Bz7aMT01Fsxb4cAC7J+nytjVX5JfuUUvrb/2ThI0vOnQeMC3AMDoiy//rr7LO01LSt
 1G7kC6ctA4yf0qBOjNpsNAgJog7A5HLvhZ4DIIJCLG5UJpLhQOc32POH0zRjtiOLZNPk
 rqI8b4g9l8JoGk14GlUiL7vWHr1RRFnTraA7cw63SZRBtDS0wuc5m+r0nJClS/d75/p8
 oVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uGgBD+fRIPT6GMwuQsq3uggiIEmseaUMqxHVVV0kVSg=;
 b=ZJMN1mgS7zD5HbBJWoXlL2oD3SDvZAOMMg2EoNECrNaq27A3/SPKvuENd+wwAs4kWL
 k8yYeYuImA01tcUDwBt33DW3Eg2HSbBonPI7KpdmVJijygddVQd+JhCUsws3zD1kxIVf
 I6OsFELcVNYjvhLNP7bVXMUwtm4k+ESala1cIB166oj6Z+sB22Iwk08Xagtc2eTP3Ba+
 PeSy8iHpuy71K3fvbyeQSXukrLY0qoVCsXc/X/jX2J1n5/coAmPqU7oGg91cH8PHGhce
 XYeyekXCFfXw2ikhHZDgoaNLGv1lVHFbV8Uz7HRGBFKj25G+gKsGqAtSu+qovLr/U6ug
 GklQ==
X-Gm-Message-State: AO0yUKXeIoao1Tcsl6g1qBoeC+NPOI4RCy9gVmMhQlpfy628fCmqXvC+
 w3w7vOCzrY5dNaYOeRi2c7OwKXAzMHIp5PO+x3eGEC1U
X-Google-Smtp-Source: AK7set8nCkrXwFktlKQey46fw1kUb2HJUotG3TA6VyYoqyoRVq8Nul3iB+iu77XJSeVevsAyYIPuT7C2AfaCkBllh4w=
X-Received: by 2002:a05:6870:891f:b0:163:8cc6:86a with SMTP id
 i31-20020a056870891f00b001638cc6086amr2143526oao.46.1675701021351; Mon, 06
 Feb 2023 08:30:21 -0800 (PST)
MIME-Version: 1.0
References: <20230203190836.1987-1-shashank.sharma@amd.com>
 <20230203190836.1987-10-shashank.sharma@amd.com>
 <ba704ad1-b4e4-e376-ee93-dc9b9e4e97a2@amd.com>
In-Reply-To: <ba704ad1-b4e4-e376-ee93-dc9b9e4e97a2@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 6 Feb 2023 11:30:09 -0500
Message-ID: <CADnq5_PFapb1a19ceYA2ACewm8Y0VQ3aOy8NBdDdvpNg5ZVa_A@mail.gmail.com>
Subject: Re: [PATCH 09/13] drm/amdgpu: accommodate DOMAIN/PL_DOORBELL
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

On Mon, Feb 6, 2023 at 6:30 AM Christian K=C3=B6nig <christian.koenig@amd.c=
om> wrote:
>
> Am 03.02.23 um 20:08 schrieb Shashank Sharma:
> > From: Alex Deucher <alexander.deucher@amd.com>
> >
> > This patch adds changes to accommodate the new GEM/TTM domain
> > for doorbell memory.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  1 +
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_bar_mgr.c | 19 ++++++++++------
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c |  3 ++-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 24 ++++++++++++++++++++=
-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  |  2 +-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 17 ++++++++++++++-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  3 ++-
> >   7 files changed, 58 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu.h
> > index e3e2e6e3b485..e1c1a360614e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -974,6 +974,7 @@ struct amdgpu_device {
> >       atomic64_t vram_pin_size;
> >       atomic64_t visible_pin_size;
> >       atomic64_t gart_pin_size;
> > +     atomic64_t doorbell_pin_size;
>
> Please drop that, the amount of pinned doorbells is not needed as far as
> I can see.
>
> >
> >       /* soc15 register offset based on ip, instance and  segment */
> >       uint32_t                *reg_offset[MAX_HWIP][HWIP_MAX_INSTANCE];
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bar_mgr.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_bar_mgr.c
> > index 0656e5bb4f05..43a3137019b1 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bar_mgr.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bar_mgr.c
> > @@ -659,15 +659,17 @@ static void amdgpu_bar_mgr_del(struct ttm_resourc=
e_manager *man,
> >    * @dev: the other device
> >    * @dir: dma direction
> >    * @sgt: resulting sg table
> > + * @mem_type: memory type
> >    *
> >    * Allocate and fill a sg table from a VRAM allocation.
> >    */
> >   int amdgpu_bar_mgr_alloc_sgt(struct amdgpu_device *adev,
> > -                           struct ttm_resource *res,
> > -                           u64 offset, u64 length,
> > -                           struct device *dev,
> > -                           enum dma_data_direction dir,
> > -                           struct sg_table **sgt)
> > +                          struct ttm_resource *res,
> > +                          u64 offset, u64 length,
> > +                          struct device *dev,
> > +                          enum dma_data_direction dir,
> > +                          struct sg_table **sgt,
> > +                          u32 mem_type)
>
> And again that doesn't make any sense at all.
>
> For now we don't want to export doorbells through DMA-buf.
>
> >   {
> >       struct amdgpu_res_cursor cursor;
> >       struct scatterlist *sg;
> > @@ -701,10 +703,15 @@ int amdgpu_bar_mgr_alloc_sgt(struct amdgpu_device=
 *adev,
> >        */
> >       amdgpu_res_first(res, offset, length, &cursor);
> >       for_each_sgtable_sg((*sgt), sg, i) {
> > -             phys_addr_t phys =3D cursor.start + adev->gmc.vram_aper_b=
ase;
> > +             phys_addr_t phys =3D cursor.start;
> >               size_t size =3D cursor.size;
> >               dma_addr_t addr;
> >
> > +             if (mem_type =3D=3D TTM_PL_VRAM)
> > +                     phys +=3D adev->gmc.vram_aper_base;
> > +             else
> > +                     phys +=3D adev->gmc.doorbell_aper_base;
> > +
> >               addr =3D dma_map_resource(dev, phys, size, dir,
> >                                       DMA_ATTR_SKIP_CPU_SYNC);
> >               r =3D dma_mapping_error(dev, addr);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_dma_buf.c
> > index c48ccde281c3..c645bdc49f34 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> > @@ -179,9 +179,10 @@ static struct sg_table *amdgpu_dma_buf_map(struct =
dma_buf_attachment *attach,
> >               break;
> >
> >       case TTM_PL_VRAM:
> > +     case AMDGPU_PL_DOORBELL:
> >               r =3D amdgpu_bar_mgr_alloc_sgt(adev, bo->tbo.resource, 0,
> >                                            bo->tbo.base.size, attach->d=
ev,
> > -                                          dir, &sgt);
> > +                                          dir, &sgt, bo->tbo.resource-=
>mem_type);
> >               if (r)
> >                       return ERR_PTR(r);
> >               break;
>
> That stuff can be dropped as well as far as I can see.
>
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_object.c
> > index 887fc53a7d16..b2cfd46c459b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > @@ -147,6 +147,18 @@ void amdgpu_bo_placement_from_domain(struct amdgpu=
_bo *abo, u32 domain)
> >               c++;
> >       }
> >
> > +     if (domain & AMDGPU_GEM_DOMAIN_DOORBELL) {
> > +             places[c].fpfn =3D 0;
> > +             places[c].lpfn =3D 0;
> > +             places[c].mem_type =3D AMDGPU_PL_DOORBELL;
> > +             places[c].flags =3D 0;
> > +             places[c].flags |=3D TTM_PL_FLAG_TOPDOWN;
> > +
> > +             if (flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)
> > +                     places[c].flags |=3D TTM_PL_FLAG_CONTIGUOUS;
> > +             c++;
> > +     }
> > +
> >       if (domain & AMDGPU_GEM_DOMAIN_GTT) {
> >               places[c].fpfn =3D 0;
> >               places[c].lpfn =3D 0;
> > @@ -464,6 +476,13 @@ static bool amdgpu_bo_validate_size(struct amdgpu_=
device *adev,
> >               if (man && size < man->size)
> >                       return true;
> >               goto fail;
> > +     } else if (domain & AMDGPU_GEM_DOMAIN_DOORBELL) {
> > +             man =3D ttm_manager_type(&adev->mman.bdev, AMDGPU_PL_DOOR=
BELL);
> > +
> > +             if (size < man->size)
> > +                     return true;
> > +             else
> > +                     goto fail;
>
> Do we ever want userspace to allocate more than one doorbell page at a ti=
me?

One 4k page would support 512 64 bit doorbells and hence 512 user
queues.  That seems like a reasonable queue limit.

Alex

>
> >       }
> >
> >       /* TODO add more domains checks, such as AMDGPU_GEM_DOMAIN_CPU */
> > @@ -962,8 +981,9 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, =
u32 domain,
> >                            &adev->visible_pin_size);
> >       } else if (domain =3D=3D AMDGPU_GEM_DOMAIN_GTT) {
> >               atomic64_add(amdgpu_bo_size(bo), &adev->gart_pin_size);
> > +     } else if (domain =3D=3D AMDGPU_GEM_DOMAIN_DOORBELL) {
> > +             atomic64_add(amdgpu_bo_size(bo), &adev->doorbell_pin_size=
);
>
> Can be dropped.
>
> >       }
> > -
> >   error:
> >       return r;
> >   }
> > @@ -1013,6 +1033,8 @@ void amdgpu_bo_unpin(struct amdgpu_bo *bo)
> >                            &adev->visible_pin_size);
> >       } else if (bo->tbo.resource->mem_type =3D=3D TTM_PL_TT) {
> >               atomic64_sub(amdgpu_bo_size(bo), &adev->gart_pin_size);
> > +     } else if (bo->tbo.resource->mem_type =3D=3D AMDGPU_PL_DOORBELL) =
{
> > +             atomic64_sub(amdgpu_bo_size(bo), &adev->doorbell_pin_size=
);
>
> Dito.
>
> >       }
> >   }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_object.h
> > index 93207badf83f..082f451d26f4 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> > @@ -326,7 +326,7 @@ int amdgpu_bo_sync_wait(struct amdgpu_bo *bo, void =
*owner, bool intr);
> >   u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo);
> >   u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo);
> >   void amdgpu_bo_get_memory(struct amdgpu_bo *bo, uint64_t *vram_mem,
> > -                             uint64_t *gtt_mem, uint64_t *cpu_mem);
> > +                       uint64_t *gtt_mem, uint64_t *cpu_mem);
> >   void amdgpu_bo_add_to_shadow_list(struct amdgpu_bo_vm *vmbo);
> >   int amdgpu_bo_restore_shadow(struct amdgpu_bo *shadow,
> >                            struct dma_fence **fence);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ttm.c
> > index bb2230d14ea6..71eff2f195a7 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > @@ -128,6 +128,7 @@ static void amdgpu_evict_flags(struct ttm_buffer_ob=
ject *bo,
> >       case AMDGPU_PL_GDS:
> >       case AMDGPU_PL_GWS:
> >       case AMDGPU_PL_OA:
> > +     case AMDGPU_PL_DOORBELL:
> >               placement->num_placement =3D 0;
> >               placement->num_busy_placement =3D 0;
> >               return;
> > @@ -500,9 +501,11 @@ static int amdgpu_bo_move(struct ttm_buffer_object=
 *bo, bool evict,
> >       if (old_mem->mem_type =3D=3D AMDGPU_PL_GDS ||
> >           old_mem->mem_type =3D=3D AMDGPU_PL_GWS ||
> >           old_mem->mem_type =3D=3D AMDGPU_PL_OA ||
> > +         old_mem->mem_type =3D=3D AMDGPU_PL_DOORBELL ||
> >           new_mem->mem_type =3D=3D AMDGPU_PL_GDS ||
> >           new_mem->mem_type =3D=3D AMDGPU_PL_GWS ||
> > -         new_mem->mem_type =3D=3D AMDGPU_PL_OA) {
> > +         new_mem->mem_type =3D=3D AMDGPU_PL_OA ||
> > +         new_mem->mem_type =3D=3D AMDGPU_PL_DOORBELL) {
> >               /* Nothing to save here */
> >               ttm_bo_move_null(bo, new_mem);
> >               goto out;
> > @@ -586,6 +589,17 @@ static int amdgpu_ttm_io_mem_reserve(struct ttm_de=
vice *bdev,
> >               mem->bus.offset +=3D adev->gmc.vram_aper_base;
> >               mem->bus.is_iomem =3D true;
> >               break;
> > +     case AMDGPU_PL_DOORBELL:
> > +             mem->bus.offset =3D mem->start << PAGE_SHIFT;
>
> That here won't work if we ever allow allocating more than one page for
> a doorbell.
>
> > +
> > +             if (adev->mman.doorbell_aper_base_kaddr &&
> > +                 mem->placement & TTM_PL_FLAG_CONTIGUOUS)
> > +                     mem->bus.addr =3D (u8 *)adev->mman.doorbell_aper_=
base_kaddr +
> > +                                     mem->bus.offset;
>
> This doesn't make any sense at all. TTM_PL_FLAG_CONTIGUOUS should
> probably be completely ignored for doorbells.
>
> Regards,
> Christian.
>
> > +
> > +             mem->bus.offset +=3D adev->gmc.doorbell_aper_base;
> > +             mem->bus.is_iomem =3D true;
> > +             break;
> >       default:
> >               return -EINVAL;
> >       }
> > @@ -1267,6 +1281,7 @@ uint64_t amdgpu_ttm_tt_pde_flags(struct ttm_tt *t=
tm, struct ttm_resource *mem)
> >               flags |=3D AMDGPU_PTE_VALID;
> >
> >       if (mem && (mem->mem_type =3D=3D TTM_PL_TT ||
> > +                 mem->mem_type =3D=3D AMDGPU_PL_DOORBELL ||
> >                   mem->mem_type =3D=3D AMDGPU_PL_PREEMPT)) {
> >               flags |=3D AMDGPU_PTE_SYSTEM;
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ttm.h
> > index 243deb1ffc54..9971665d7d99 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> > @@ -124,7 +124,8 @@ int amdgpu_bar_mgr_alloc_sgt(struct amdgpu_device *=
adev,
> >                            u64 offset, u64 size,
> >                            struct device *dev,
> >                            enum dma_data_direction dir,
> > -                          struct sg_table **sgt);
> > +                          struct sg_table **sgt,
> > +                          u32 mem_type);
> >   void amdgpu_bar_mgr_free_sgt(struct device *dev,
> >                            enum dma_data_direction dir,
> >                            struct sg_table *sgt);
>
