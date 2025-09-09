Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DADC8CAC587
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Sep 2025 13:13:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 828F910E708;
	Tue,  9 Sep 2025 13:13:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Co5Wb45D";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6A4E10E24A
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Sep 2025 13:13:54 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-248f2da72edso10347055ad.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Sep 2025 06:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757423634; x=1758028434; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t8KrLCu/sg/OZJKnrIB5ON+nOjVJCff4x7eMOXiYRwg=;
 b=Co5Wb45D/IoiCH7IST+X3TzNM+s1HbrfJhAZxmig2TivDuFqmDpWmanTWzjRcWUBIu
 qcW1hNCPUWMOSjqRvwXklOg261V0rUPlRFDItspmdAvqrQM3K6zMc6bTdaz8Wx5+UOe7
 vXBN/u40/6YneLzRczy0yHdeq3qUXa84TcVKcjPwNMFh0qAh/qIECqHFqpy3Z+T0Z1dw
 bT+ZI14oagRfcxxqib3ETHmLJBIYWVY2BXWFGq+G1VGIXIgQCCwIlI47VOjWCgytd83e
 lpHHW+OcScC1JL1bxbNm7cMqmWEqc7MsAO2SSQdTOenecdO3/YpW2l4SYHN1bypyYrhN
 sS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757423634; x=1758028434;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t8KrLCu/sg/OZJKnrIB5ON+nOjVJCff4x7eMOXiYRwg=;
 b=NoUeJXbqZ4+Y21U9PKHUQtK7UVQvVoEl5g3Xlv7YWOiMowgulwEq+ZC4eS1yOePJIZ
 sTRcQ7DuVivgfxJy3yOc1zgDvQy8a5YH+p/CSDROdV84X2OV3wIk5X3FC6jnNdVfNmfM
 1n7mAceTLL0NNH0sAFKVaSMiR6k3M/af9Lz0MSm9u/XJQPkqJsv5quiLAuniMIjxwyGx
 qVLOSEKjtRsNTumYDYaa/nAfVMvw6YcpA1YBlD/oLTOvYUj4CwW0lYpeAEgmIuis6cPY
 mu9VU2JhUCOJuNrlZCgxMwx6dVJ9p3HHVp40UEAe29oAzaTdBkCTooF02SMzEqSkbc2k
 Pq2Q==
X-Gm-Message-State: AOJu0YzPp5oAXkXtMYZhjIzA+vpr+qKTNyTbeJjF8pjV+75XRKOhHbfl
 DLx8cU2bQC9mTVEYjcoPgT3UPMLGRZrLHL8/KF7WLcKn2tNr8FT7EgIiFdZnzK7BeF6EBGz9v6T
 qrEL7JyfbXV7CIR4XHJuji7M4qsR4HcFW6A==
X-Gm-Gg: ASbGncu2SVaivq2EA9bic9mwpPp0w+8I1Pf1dQTzOe+Y+feqqCrgLvQUcPOI/EL/axo
 O+r9WRnpDOfyAcBPljQoFNEJBDCfS4RmxtVefmkzCbfa8i0bdAdQXmT8oNjsp95kApMRgT316Cf
 DFpUtVsUx/Q+L1LYrROrg3OJhczYu6Abjq8ogCXkUebT7jWvfMCpuDdi/s0u6a0WzQVZLFsHDTg
 vR0LY/ADT9YhUAwHw==
X-Google-Smtp-Source: AGHT+IHdsl56ag73wDRsYsA/0Ib9acEt6924LSvnMrQVY0woZ9JkTe/yK0mczEF4W+BvvBNL2p+zldDEbr6/ScxsCJU=
X-Received: by 2002:a17:903:1cc:b0:248:a01f:a549 with SMTP id
 d9443c01a7336-251771d5b61mr89769855ad.11.1757423633975; Tue, 09 Sep 2025
 06:13:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250908084846.1873894-1-Prike.Liang@amd.com>
 <20250908084846.1873894-8-Prike.Liang@amd.com>
 <CADnq5_NrSjB3+kPuq_kQXOKfiOSSsoJgfdr+MUGpUzfMcCCbuQ@mail.gmail.com>
 <DS7PR12MB6005BF044FF3A865EE77C42BFB0FA@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB6005BF044FF3A865EE77C42BFB0FA@DS7PR12MB6005.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 9 Sep 2025 09:13:41 -0400
X-Gm-Features: Ac12FXzlq9T2vOJ-Iv-XEEORU0EV3Uz95c1HK9pwzNHq5zB3Uwlfu0wPJn8NaM4
Message-ID: <CADnq5_PT5abwesfLyNEPaBebT34tLBxzbFeBMfqM-eyG6qYRog@mail.gmail.com>
Subject: Re: [PATCH v10 08/14] drm/amdgpu: add userq object va track helpers
To: "Liang, Prike" <Prike.Liang@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
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

On Tue, Sep 9, 2025 at 2:50=E2=80=AFAM Liang, Prike <Prike.Liang@amd.com> w=
rote:
>
> [Public]
>
> Regards,
>       Prike
>
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Tuesday, September 9, 2025 5:55 AM
> > To: Liang, Prike <Prike.Liang@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.co=
m>
> > Subject: Re: [PATCH v10 08/14] drm/amdgpu: add userq object va track he=
lpers
> >
> > On Mon, Sep 8, 2025 at 4:4=E2=80=AFAM Prike Liang <Prike.Liang@amd.com>=
 wrote:
> > >
> > > Add the userq object virtual address get(),mapped() and put() helpers
> > > for tracking the userq obj va address usage.
> >
> > This adds too much queue specific info to the user queue structure.
> > Just set the bo_va flag when you validate the VAs in patch 7.  Then whe=
n we
> > validate the BOs in amdgpu_userq_restore_worker() verify that all of th=
e buffers with
> > the bo_va flag are present.  If they are not, fail the buffer validatio=
n and set the error
> > on the queue(s).  If you want a per queue list, just use a list_head in=
 the userq
> > structure for critical VAs.
> When the bo_va flag is set during queue creation, what is the correct poi=
nt to clear it?
> If we perform cleanup in the GEM unmap phase (amdgpu_vm_bo_unmap()), do w=
e need
> to check that the userq has already been destroyed before unmapping its V=
A? Or
> we keep the unmap path userq-agnostic and just defer userq VA validation =
to amdgpu_userq_restore_worker()?

We clear it on queue destruction.  The critical buffers are the queue
buffers and their relevant metadata.  Without them, the queues are not
operable. So they need to be mapped and resident for the life of the
queues.  So mark them as critical on queue creation and unmark them on
queue destruction.

Alex

>
> Thanks,
> Prike
> > Alex
> >
> >
> > Alex
> >
> >
> > >
> > > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 172
> > > ++++++++++++++++++++-  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  =
14
> > ++
> > >  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |   4 +
> > >  3 files changed, 189 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > index 739135c3f450..5aebce63d86f 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > @@ -76,6 +76,174 @@ int amdgpu_userq_input_va_validate(struct amdgpu_=
vm
> > *vm, u64 addr,
> > >         return r;
> > >  }
> > >
> > > +int amdgpu_userq_buffer_va_get(struct amdgpu_vm *vm, u64 addr) {
> > > +       struct amdgpu_bo_va_mapping *mapping;
> > > +       u64 user_addr;
> > > +       int r;
> > > +
> > > +       user_addr =3D (addr & AMDGPU_GMC_HOLE_MASK) >>
> > AMDGPU_GPU_PAGE_SHIFT;
> > > +       r =3D amdgpu_bo_reserve(vm->root.bo, false);
> > > +       if (r)
> > > +               return r;
> > > +
> > > +       mapping =3D amdgpu_vm_bo_lookup_mapping(vm, user_addr);
> > > +       if (!mapping)
> > > +               goto out_err;
> > > +
> > > +       /*
> > > +        * Need to unify the following userq va reference.
> > > +        *  mqd  bo
> > > +        *  rptr bo
> > > +        *  wptr bo
> > > +        *  eop  bo
> > > +        *  shadow bo
> > > +        *  csa bo
> > > +        */
> > > +       /*amdgpu_bo_ref(mapping->bo_va->base.bo);*/
> > > +       mapping->bo_va->queue_refcount++;
> > > +
> > > +       amdgpu_bo_unreserve(vm->root.bo);
> > > +       return 0;
> > > +
> > > +out_err:
> > > +       amdgpu_bo_unreserve(vm->root.bo);
> > > +       return -EINVAL;
> > > +}
> > > +
> > > +bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr) {
> > > +       struct amdgpu_bo_va_mapping *mapping;
> > > +       u64 user_addr;
> > > +       bool r;
> > > +
> > > +       user_addr =3D (addr & AMDGPU_GMC_HOLE_MASK) >>
> > > + AMDGPU_GPU_PAGE_SHIFT;
> > > +
> > > +       if (amdgpu_bo_reserve(vm->root.bo, false))
> > > +               return false;
> > > +
> > > +       mapping =3D amdgpu_vm_bo_lookup_mapping(vm, user_addr);
> > > +       if (!IS_ERR_OR_NULL(mapping) && mapping->bo_va->queue_refcoun=
t > 0)
> > > +               r =3D true;
> > > +       else
> > > +               r =3D false;
> > > +       amdgpu_bo_unreserve(vm->root.bo);
> > > +
> > > +       return r;
> > > +}
> > > +
> > > +bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_vm *vm,
> > > +                       struct amdgpu_usermode_queue *queue) {
> > > +
> > > +       switch (queue->queue_type) {
> > > +       case AMDGPU_HW_IP_GFX:
> > > +               if (amdgpu_userq_buffer_va_mapped(vm, queue->queue_va=
) ||
> > > +                   amdgpu_userq_buffer_va_mapped(vm, queue->rptr_va)=
 ||
> > > +                   amdgpu_userq_buffer_va_mapped(vm, queue->wptr_va)=
 ||
> > > +                   amdgpu_userq_buffer_va_mapped(vm, queue->shadow_v=
a) ||
> > > +                   amdgpu_userq_buffer_va_mapped(vm, queue->csa_va))
> > > +                       return true;
> > > +               break;
> > > +       case AMDGPU_HW_IP_COMPUTE:
> > > +               if (amdgpu_userq_buffer_va_mapped(vm, queue->queue_va=
) ||
> > > +                   amdgpu_userq_buffer_va_mapped(vm, queue->rptr_va)=
 ||
> > > +                   amdgpu_userq_buffer_va_mapped(vm, queue->wptr_va)=
 ||
> > > +                   amdgpu_userq_buffer_va_mapped(vm, queue->eop_va))
> > > +                       return true;
> > > +               break;
> > > +       case AMDGPU_HW_IP_DMA:
> > > +               if (amdgpu_userq_buffer_va_mapped(vm, queue->queue_va=
) ||
> > > +                   amdgpu_userq_buffer_va_mapped(vm, queue->rptr_va)=
 ||
> > > +                   amdgpu_userq_buffer_va_mapped(vm, queue->wptr_va)=
 ||
> > > +                   amdgpu_userq_buffer_va_mapped(vm, queue->csa_va))
> > > +                       return true;
> > > +               break;
> > > +       default:
> > > +               break;
> > > +       }
> > > +
> > > +       return false;
> > > +}
> > > +
> > > +int amdgpu_userq_buffer_va_put(struct amdgpu_vm *vm, u64 addr) {
> > > +       struct amdgpu_bo_va_mapping *mapping;
> > > +       u64 user_addr;
> > > +       int r;
> > > +
> > > +       user_addr =3D (addr & AMDGPU_GMC_HOLE_MASK) >>
> > AMDGPU_GPU_PAGE_SHIFT;
> > > +       r =3D amdgpu_bo_reserve(vm->root.bo, false);
> > > +       if (r)
> > > +               return r;
> > > +
> > > +       mapping =3D amdgpu_vm_bo_lookup_mapping(vm, user_addr);
> > > +       if (!mapping)
> > > +               goto out_err;
> > > +       /*
> > > +        * TODO: It requires figuring out the root cause of userq va =
mapping
> > > +        * reference imbalance issue.
> > > +        */
> > > +       /*amdgpu_bo_unref(&mapping->bo_va->base.bo);*/
> > > +       mapping->bo_va->queue_refcount--;
> > > +
> > > +       amdgpu_bo_unreserve(vm->root.bo);
> > > +       return 0;
> > > +
> > > +out_err:
> > > +       amdgpu_bo_unreserve(vm->root.bo);
> > > +       return -EINVAL;
> > > +}
> > > +
> > > +static void amdgpu_userq_buffer_vas_get(struct amdgpu_vm *vm,
> > > +                       struct amdgpu_usermode_queue *queue) {
> > > +
> > > +
> > > +       amdgpu_userq_buffer_va_get(vm, queue->queue_va);
> > > +       amdgpu_userq_buffer_va_get(vm, queue->rptr_va);
> > > +       amdgpu_userq_buffer_va_get(vm, queue->wptr_va);
> > > +
> > > +       switch (queue->queue_type) {
> > > +       case AMDGPU_HW_IP_GFX:
> > > +               amdgpu_userq_buffer_va_get(vm, queue->shadow_va);
> > > +               amdgpu_userq_buffer_va_get(vm, queue->csa_va);
> > > +               break;
> > > +       case AMDGPU_HW_IP_COMPUTE:
> > > +               amdgpu_userq_buffer_va_get(vm, queue->eop_va);
> > > +               break;
> > > +       case AMDGPU_HW_IP_DMA:
> > > +               amdgpu_userq_buffer_va_get(vm, queue->csa_va);
> > > +               break;
> > > +       default:
> > > +               break;
> > > +       }
> > > +}
> > > +
> > > +int amdgpu_userq_buffer_vas_put(struct amdgpu_vm *vm,
> > > +                       struct amdgpu_usermode_queue *queue) {
> > > +       amdgpu_userq_buffer_va_put(vm, queue->queue_va);
> > > +       amdgpu_userq_buffer_va_put(vm, queue->rptr_va);
> > > +       amdgpu_userq_buffer_va_put(vm, queue->wptr_va);
> > > +
> > > +       switch (queue->queue_type) {
> > > +       case AMDGPU_HW_IP_GFX:
> > > +               amdgpu_userq_buffer_va_put(vm, queue->shadow_va);
> > > +               amdgpu_userq_buffer_va_put(vm, queue->csa_va);
> > > +               break;
> > > +       case AMDGPU_HW_IP_COMPUTE:
> > > +               amdgpu_userq_buffer_va_put(vm, queue->eop_va);
> > > +               break;
> > > +       case AMDGPU_HW_IP_DMA:
> > > +               amdgpu_userq_buffer_va_put(vm, queue->csa_va);
> > > +               break;
> > > +       default:
> > > +               break;
> > > +       }
> > > +       return 0;
> > > +}
> > > +
> > >  static int
> > >  amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
> > >                           struct amdgpu_usermode_queue *queue) @@
> > > -444,6 +612,9 @@ amdgpu_userq_create(struct drm_file *filp, union
> > drm_amdgpu_userq *args)
> > >         queue->vm =3D &fpriv->vm;
> > >         queue->priority =3D priority;
> > >         queue->generation =3D amdgpu_vm_generation(adev, &fpriv->vm);
> > > +       queue->queue_va =3D args->in.queue_va;
> > > +       queue->rptr_va =3D args->in.rptr_va;
> > > +       queue->wptr_va =3D args->in.wptr_va;
> > >
> > >         db_info.queue_type =3D queue->queue_type;
> > >         db_info.doorbell_handle =3D queue->doorbell_handle; @@ -474,7
> > > +645,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu=
_userq
> > *args)
> > >                 goto unlock;
> > >         }
> > >
> > > -
> > >         qid =3D idr_alloc(&uq_mgr->userq_idr, queue, 1,
> > AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
> > >         if (qid < 0) {
> > >                 drm_file_err(uq_mgr->file, "Failed to allocate a queu=
e
> > > id\n"); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> > > index 46e927df67c1..39d9bc6fc47a 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> > > @@ -53,6 +53,13 @@ struct amdgpu_usermode_queue {
> > >         enum amdgpu_userq_state state;
> > >         uint64_t                doorbell_handle;
> > >         uint64_t                doorbell_index;
> > > +       uint64_t                queue_va;
> > > +       uint64_t                rptr_va;
> > > +       uint64_t                wptr_va;
> > > +       uint64_t                eop_va;
> > > +       uint64_t                shadow_va;
> > > +       uint64_t                csa_va;
> > > +
> > >         uint64_t                flags;
> > >         struct amdgpu_mqd_prop  *userq_prop;
> > >         struct amdgpu_userq_mgr *userq_mgr; @@ -136,4 +143,11 @@ int
> > > amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device
> > > *adev,
> > >
> > >  int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
> > >                         u64 expected_size);
> > > +int amdgpu_userq_buffer_va_get(struct amdgpu_vm *vm, u64 addr); bool
> > > +amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr); bool
> > > +amdgpu_userq_buffer_vas_mapped(struct amdgpu_vm *vm,
> > > +                       struct amdgpu_usermode_queue *queue); int
> > > +amdgpu_userq_buffer_va_put(struct amdgpu_vm *vm, u64 addr); int
> > > +amdgpu_userq_buffer_vas_put(struct amdgpu_vm *vm,
> > > +                       struct amdgpu_usermode_queue *queue);
> > >  #endif
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > > b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > > index 3bf328eb7b69..431397158fe5 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > > @@ -260,6 +260,7 @@ static int mes_userq_mqd_create(struct
> > amdgpu_userq_mgr *uq_mgr,
> > >                 userq_props->hqd_active =3D false;
> > >                 userq_props->tmz_queue =3D
> > >                         mqd_user->flags &
> > > AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
> > > +               queue->eop_va =3D compute_mqd->eop_va;
> > >                 kfree(compute_mqd);
> > >         } else if (queue->queue_type =3D=3D AMDGPU_HW_IP_GFX) {
> > >                 struct drm_amdgpu_userq_mqd_gfx11 *mqd_gfx_v11; @@
> > > -281,6 +282,8 @@ static int mes_userq_mqd_create(struct amdgpu_userq_=
mgr
> > *uq_mgr,
> > >                 userq_props->csa_addr =3D mqd_gfx_v11->csa_va;
> > >                 userq_props->tmz_queue =3D
> > >                         mqd_user->flags &
> > > AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
> > > +               queue->shadow_va =3D mqd_gfx_v11->shadow_va;
> > > +               queue->csa_va =3D mqd_gfx_v11->csa_va;
> > >
> > >                 if (amdgpu_userq_input_va_validate(queue->vm, mqd_gfx=
_v11-
> > >shadow_va,
> > >                                         shadow_info.shadow_size)) @@
> > > -308,6 +311,7 @@ static int mes_userq_mqd_create(struct amdgpu_userq_=
mgr
> > *uq_mgr,
> > >                         goto free_mqd;
> > >
> > >                 userq_props->csa_addr =3D mqd_sdma_v11->csa_va;
> > > +               queue->csa_va =3D mqd_sdma_v11->csa_va;
> > >                 kfree(mqd_sdma_v11);
> > >         }
> > >
> > > --
> > > 2.34.1
> > >
