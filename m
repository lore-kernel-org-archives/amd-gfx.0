Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C4E0109C058
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 18:41:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04F2B10E905;
	Wed, 25 Mar 2026 18:41:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NiHLoqPL";
	dkim-atps=neutral
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 620A110E905
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 18:41:15 +0000 (UTC)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-2bda3b4318dso21866eec.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 11:41:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774464075; cv=none;
 d=google.com; s=arc-20240605;
 b=hvwWK5Nv+O+S59e976nf/Ba4BsGcxt1EkT3mzVJP6X9XuXT1miwxYL4IZNRJqGkIjp
 GYQYiKJqWaYNz+1GqddGmhbZhonivCDSURLK3cYey1DQDV7LwzrFLTbCzo7vW2L8fJPT
 hJmxBVzQB35YSk2qxap2ZBUW0GsPZuaEQeX1tIUgN/7PeZ/Id0k0pLQsrZ7L4YHhnzEX
 BX3E7+9KD4II/shsuOUZeeeoMINgt2k55InpuqzOcI+2Eo/DXLlXjVdqJiASsgQzG+/9
 JHJbBHXMVbBrVsfZTQ0IL9KpkYgS380WxGrZY0Kmt8BrgVk0v8s8OD5iTmiEAUvtOeMc
 l30A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HXGIXx3/DMcopIZZkPlSfT0Eb4kZMukBc/kBlntYhmM=;
 fh=xEBxS2WUXznvMAtVcJ0D6uL4t6y8U/RZh3owsPn03wc=;
 b=UhawubEU+1DWOUKQz/GoIZMYd/iSmTY+5cHGiK410HBt4P13Ac7Jqq6zuqdacglQoG
 WKQ8VAlvTtQ++XNUtwOiYsdn1SI8B4jRmrtlK/Iz5IHJGzO4e6FVS7jHcMlqgiJwWsBe
 Dvixa1mAi/gbhsRyhd6UUuPMjreM74oxTb/IUdIy2LQzvwSOtqD01VohImBWCOGJnACk
 HgPpqt/xBcA+lM8o8irZJ2vXeCWdp7jmbWxCdlBom8vq6zW5v0f4Ic4C+iTz6TFRazWb
 JVSXRJ1UhLN17gl8bbprOAqSWS2xIVH+mpycqzXkOU1Y46VuPvkuY3Dgd8R9JcLoX0I1
 MhrQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774464075; x=1775068875; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HXGIXx3/DMcopIZZkPlSfT0Eb4kZMukBc/kBlntYhmM=;
 b=NiHLoqPLX3D+NHNVoEXYvG1pB8NFUotEL4u6T9td5CQH+Txerd/t6Z/iG3Ls31Orml
 t1EJAbRSFlJwGij5opQIbeZHV0L9sMhHEKonZmU/evHKh/ZmGm1qtQ7oAhFjU1qyp2iu
 AMWolnM5Y8wXIZKRiSy6DuhlwnXBAv9+XhAwrzCkNoYRHKR1qgm1cWO0WAFBICuzPI70
 /UgvZIpgfRUY/wMPKtO6KSRYRWG4c4ye2Oty4UCI5NwrW0aEReSGSPlibViFChnDHgZH
 1/+I8X+KkBRbv47omzf8hFdBVx55ZuUdDqD+RtnB9uEg3fsiOo7v1eDXyTuv0lKq9ZPB
 ZJ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774464075; x=1775068875;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HXGIXx3/DMcopIZZkPlSfT0Eb4kZMukBc/kBlntYhmM=;
 b=VrJtYVLHBOID158TZoJQyVxNYCAZPF6zqJsOg/FYrw9t/t0jY1/D/cGQXCge5E2GE8
 zhimFe68MWDy27zG0RPk7K1yfB5kpBxleZW4+r2MBwV7LjQejFE1WFIYF6sXPRovnlZw
 ZB0Eqr/hYyv0yqlkaEmc/SNdQY/HJ82taodya8qbgNliOyJTW7wzaN98+fAbAO2ScnIg
 JghCM+IyOmQe7uuFSZwBqZMkzg/tocSIhiWi83q27DH27i5qUhh7qJEkZHaSdcU7GTMH
 pOpech++oq3wnPaftW6ooQnWVAeBFdG5gBEeIpr2OL4dFLsM1QaJ6UvedCHh5CNDvRX6
 JIdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCURQIy16AUaIO4T7FnSEYYBKSjWVDYJqmJox3qt06NpUL6YEHpEpBxozrEZB6/KSw76BmlSCeb+@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzJ42oLjviDZLzeglEneT2KTJlJbF9KL3k2HZb7pfL2lbW6Su9g
 lBpJXWO+0opRrnQLo5kH8i6jaEutolN+3FbhuYcXofONk9uByMu7pK/oropRgWVkSGlurY1N+kz
 Hpr8l6RR07qlCOFovjNpySZPOGUcVbKQ=
X-Gm-Gg: ATEYQzw4RkjNLt2IVh+ZcoFzVWj7l8SNm8U/DUw9x/4mVe/6JpjKHbBLBk2nQUHGcUv
 TD6LFUdPPboyz1CFLDsSLSGclV6O083j40ohLjRLO5j5qrfvR0eTFKe8l4L7icqtaTDlHsOdfzq
 sjS9v9jl7hZYrhCVS5odvEyecgaJ+O12XcJp3IqsebQdSsPrVMSOCC9g4ueM1v4QtfjPvMe6GaN
 w/r2fl7v3cD/4eMHGisHXVFFppPkFZNI4KdB/IPj5Px6z4HfJHkTuf5FH1eTC2m8FkpmTsB9UHW
 hCyoWJBaCJjxyxJc3s8sLlMbSuPZE7ZtS/dVbh/UP+NCDEc7fU2NeLonjE/oXL+FIAy3qA==
X-Received: by 2002:a05:7022:628e:b0:128:d590:2947 with SMTP id
 a92af1059eb24-12a96ec2d71mr1065837c88.4.1774464074570; Wed, 25 Mar 2026
 11:41:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1774239489.git.donettom@linux.ibm.com>
 <d4b7297891badff6bc6030c71e51dddc27c54451.1774239489.git.donettom@linux.ibm.com>
 <8f8d5d6b-ce50-42a7-a556-b878ca4a1fc3@amd.com>
In-Reply-To: <8f8d5d6b-ce50-42a7-a556-b878ca4a1fc3@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 25 Mar 2026 14:41:03 -0400
X-Gm-Features: AaiRm52wa2Etd7b8JPMB-8zJqYTrkCE3hWgtZ-Y1CVkppT9C3Hy1S-9DtenIS0M
Message-ID: <CADnq5_OaO-RN1hLhu35x46+xR9w5schA_v+zWuxtjeoKfHwivQ@mail.gmail.com>
Subject: Re: [RESEND RFC PATCH v3 5/6] drm/amd: Fix MQD and control stack
 alignment for non-4K
To: "Kuehling, Felix" <felix.kuehling@amd.com>
Cc: Donet Tom <donettom@linux.ibm.com>, amd-gfx@lists.freedesktop.org, 
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com, 
 Philip Yang <yangp@amd.com>, David.YatSin@amd.com, Kent.Russell@amd.com, 
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>
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

Applied.  Thanks!

Alex

On Tue, Mar 24, 2026 at 10:58=E2=80=AFPM Kuehling, Felix <felix.kuehling@am=
d.com> wrote:
>
>
> On 2026-03-23 00:28, Donet Tom wrote:
> > For gfxV9, due to a hardware bug ("based on the comments in the code
> > here [1]"), the control stack of a user-mode compute queue must be
> > allocated immediately after the page boundary of its regular MQD buffer=
.
> > To handle this, we allocate an enlarged MQD buffer where the first page
> > is used as the MQD and the remaining pages store the control stack.
> > Although these regions share the same BO, they require different memory
> > types: the MQD must be UC (uncached), while the control stack must be
> > NC (non-coherent), matching the behavior when the control stack is
> > allocated in user space.
> >
> > This logic works correctly on systems where the CPU page size matches
> > the GPU page size (4K). However, the current implementation aligns both
> > the MQD and the control stack to the CPU PAGE_SIZE. On systems with a
> > larger CPU page size, the entire first CPU page is marked UC=E2=80=94ev=
en though
> > that page may contain multiple GPU pages. The GPU treats the second 4K
> > GPU page inside that CPU page as part of the control stack, but it is
> > incorrectly mapped as UC.
> >
> > This patch fixes the issue by aligning both the MQD and control stack
> > sizes to the GPU page size (4K). The first 4K page is correctly marked
> > as UC for the MQD, and the remaining GPU pages are marked NC for the
> > control stack. This ensures proper memory type assignment on systems
> > with larger CPU page sizes.
> >
> > [1]: https://elixir.bootlin.com/linux/v6.18/source/drivers/gpu/drm/amd/=
amdkfd/kfd_mqd_manager_v9.c#L118
> >
> > Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>
> Acked-by: Felix Kuehling <felix.kuehling@amd.com>
>
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c      | 44 ++++++++++++++++++=
+
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h      |  2 +
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 16 ++-----
> >   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 23 ++++++----
> >   4 files changed, 64 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_gart.c
> > index ec911dce345f..4d884180cf61 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> > @@ -403,6 +403,50 @@ void amdgpu_gart_map_vram_range(struct amdgpu_devi=
ce *adev, uint64_t pa,
> >       drm_dev_exit(idx);
> >   }
> >
> > +/**
> > + * amdgpu_gart_map_gfx9_mqd - map mqd and ctrl_stack dma_addresses int=
o GART entries
> > + *
> > + * @adev: amdgpu_device pointer
> > + * @offset: offset into the GPU's gart aperture
> > + * @pages: number of pages to bind
> > + * @dma_addr: DMA addresses of pages
> > + * @flags: page table entry flags
> > + *
> > + * Map the MQD and control stack addresses into GART entries with the =
correct
> > + * memory types on gfxv9. The MQD occupies the first 4KB and is follow=
ed by
> > + * the control stack. The MQD uses UC (uncached) memory, while the con=
trol stack
> > + * uses NC (non-coherent) memory.
> > + */
> > +void amdgpu_gart_map_gfx9_mqd(struct amdgpu_device *adev, uint64_t off=
set,
> > +                     int pages, dma_addr_t *dma_addr, uint64_t flags)
> > +{
> > +     uint64_t page_base;
> > +     unsigned int i, j, t;
> > +     int idx;
> > +     uint64_t ctrl_flags =3D AMDGPU_PTE_MTYPE_VG10(flags, AMDGPU_MTYPE=
_NC);
> > +     void *dst;
> > +
> > +     if (!adev->gart.ptr)
> > +             return;
> > +
> > +     if (!drm_dev_enter(adev_to_drm(adev), &idx))
> > +             return;
> > +
> > +     t =3D offset / AMDGPU_GPU_PAGE_SIZE;
> > +     dst =3D adev->gart.ptr;
> > +     for (i =3D 0; i < pages; i++) {
> > +             page_base =3D dma_addr[i];
> > +             for (j =3D 0; j < AMDGPU_GPU_PAGES_IN_CPU_PAGE; j++, t++)=
 {
> > +                     if ((i =3D=3D 0) && (j =3D=3D 0))
> > +                             amdgpu_gmc_set_pte_pde(adev, dst, t, page=
_base, flags);
> > +                     else
> > +                             amdgpu_gmc_set_pte_pde(adev, dst, t, page=
_base, ctrl_flags);
> > +                     page_base +=3D AMDGPU_GPU_PAGE_SIZE;
> > +             }
> > +     }
> > +     drm_dev_exit(idx);
> > +}
> > +
> >   /**
> >    * amdgpu_gart_bind - bind pages into the gart page table
> >    *
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_gart.h
> > index d3118275ddae..6ebd2da32ea6 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
> > @@ -62,6 +62,8 @@ void amdgpu_gart_unbind(struct amdgpu_device *adev, u=
int64_t offset,
> >   void amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
> >                    int pages, dma_addr_t *dma_addr, uint64_t flags,
> >                    void *dst);
> > +void amdgpu_gart_map_gfx9_mqd(struct amdgpu_device *adev, uint64_t off=
set,
> > +                     int pages, dma_addr_t *dma_addr, uint64_t flags);
> >   void amdgpu_gart_bind(struct amdgpu_device *adev, uint64_t offset,
> >                     int pages, dma_addr_t *dma_addr, uint64_t flags);
> >   void amdgpu_gart_map_vram_range(struct amdgpu_device *adev, uint64_t =
pa,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ttm.c
> > index 67983955a124..e086eb1d2b24 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > @@ -855,25 +855,15 @@ static void amdgpu_ttm_gart_bind_gfx9_mqd(struct =
amdgpu_device *adev,
> >       int num_xcc =3D max(1U, adev->gfx.num_xcc_per_xcp);
> >       uint64_t page_idx, pages_per_xcc;
> >       int i;
> > -     uint64_t ctrl_flags =3D AMDGPU_PTE_MTYPE_VG10(flags, AMDGPU_MTYPE=
_NC);
> >
> >       pages_per_xcc =3D total_pages;
> >       do_div(pages_per_xcc, num_xcc);
> >
> >       for (i =3D 0, page_idx =3D 0; i < num_xcc; i++, page_idx +=3D pag=
es_per_xcc) {
> > -             /* MQD page: use default flags */
> > -             amdgpu_gart_bind(adev,
> > +             amdgpu_gart_map_gfx9_mqd(adev,
> >                               gtt->offset + (page_idx << PAGE_SHIFT),
> > -                             1, &gtt->ttm.dma_address[page_idx], flags=
);
> > -             /*
> > -              * Ctrl pages - modify the memory type to NC (ctrl_flags)=
 from
> > -              * the second page of the BO onward.
> > -              */
> > -             amdgpu_gart_bind(adev,
> > -                             gtt->offset + ((page_idx + 1) << PAGE_SHI=
FT),
> > -                             pages_per_xcc - 1,
> > -                             &gtt->ttm.dma_address[page_idx + 1],
> > -                             ctrl_flags);
> > +                             pages_per_xcc, &gtt->ttm.dma_address[page=
_idx],
> > +                             flags);
> >       }
> >   }
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/=
gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> > index dcf4bbfa641b..ff0e483514da 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> > @@ -42,9 +42,16 @@ static uint64_t mqd_stride_v9(struct mqd_manager *mm=
,
> >                               struct queue_properties *q)
> >   {
> >       if (mm->dev->kfd->cwsr_enabled &&
> > -         q->type =3D=3D KFD_QUEUE_TYPE_COMPUTE)
> > -             return ALIGN(q->ctl_stack_size, PAGE_SIZE) +
> > -                     ALIGN(sizeof(struct v9_mqd), PAGE_SIZE);
> > +         q->type =3D=3D KFD_QUEUE_TYPE_COMPUTE) {
> > +
> > +             /* On gfxv9, the MQD resides in the first 4K page,
> > +              * followed by the control stack. Align both to
> > +              * AMDGPU_GPU_PAGE_SIZE to maintain the required 4K bound=
ary.
> > +              */
> > +
> > +             return ALIGN(ALIGN(q->ctl_stack_size, AMDGPU_GPU_PAGE_SIZ=
E) +
> > +                     ALIGN(sizeof(struct v9_mqd), AMDGPU_GPU_PAGE_SIZE=
), PAGE_SIZE);
> > +     }
> >
> >       return mm->mqd_size;
> >   }
> > @@ -148,8 +155,8 @@ static struct kfd_mem_obj *allocate_mqd(struct mqd_=
manager *mm,
> >               if (!mqd_mem_obj)
> >                       return NULL;
> >               retval =3D amdgpu_amdkfd_alloc_kernel_mem(node->adev,
> > -                     (ALIGN(q->ctl_stack_size, PAGE_SIZE) +
> > -                     ALIGN(sizeof(struct v9_mqd), PAGE_SIZE)) *
> > +                     (ALIGN(ALIGN(q->ctl_stack_size, AMDGPU_GPU_PAGE_S=
IZE) +
> > +                     ALIGN(sizeof(struct v9_mqd), AMDGPU_GPU_PAGE_SIZE=
), PAGE_SIZE)) *
> >                       NUM_XCC(node->xcc_mask),
> >                       mqd_on_vram(node->adev) ? AMDGPU_GEM_DOMAIN_VRAM =
:
> >                                                 AMDGPU_GEM_DOMAIN_GTT,
> > @@ -357,7 +364,7 @@ static int get_wave_state(struct mqd_manager *mm, v=
oid *mqd,
> >       struct kfd_context_save_area_header header;
> >
> >       /* Control stack is located one page after MQD. */
> > -     void *mqd_ctl_stack =3D (void *)((uintptr_t)mqd + PAGE_SIZE);
> > +     void *mqd_ctl_stack =3D (void *)((uintptr_t)mqd + AMDGPU_GPU_PAGE=
_SIZE);
> >
> >       m =3D get_mqd(mqd);
> >
> > @@ -394,7 +401,7 @@ static void checkpoint_mqd(struct mqd_manager *mm, =
void *mqd, void *mqd_dst, voi
> >   {
> >       struct v9_mqd *m;
> >       /* Control stack is located one page after MQD. */
> > -     void *ctl_stack =3D (void *)((uintptr_t)mqd + PAGE_SIZE);
> > +     void *ctl_stack =3D (void *)((uintptr_t)mqd + AMDGPU_GPU_PAGE_SIZ=
E);
> >
> >       m =3D get_mqd(mqd);
> >
> > @@ -440,7 +447,7 @@ static void restore_mqd(struct mqd_manager *mm, voi=
d **mqd,
> >               *gart_addr =3D addr;
> >
> >       /* Control stack is located one page after MQD. */
> > -     ctl_stack =3D (void *)((uintptr_t)*mqd + PAGE_SIZE);
> > +     ctl_stack =3D (void *)((uintptr_t)*mqd + AMDGPU_GPU_PAGE_SIZE);
> >       memcpy(ctl_stack, ctl_stack_src, ctl_stack_size);
> >
> >       m->cp_hqd_pq_doorbell_control =3D
