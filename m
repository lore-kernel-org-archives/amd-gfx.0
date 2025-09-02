Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2CF1CA1005
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 15:46:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84E6210E7A4;
	Tue,  2 Sep 2025 15:46:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ub2kGt6J";
	dkim-atps=neutral
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C5B810E7A4
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 15:46:14 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-b49cf060d2bso448141a12.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Sep 2025 08:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756827974; x=1757432774; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9FYKKUKfTkSEmbNbzPMeX4HmyDIcQzy3TH7WUrTS7y0=;
 b=Ub2kGt6JcL/rK64Fn2WX1xsyZIRHkbxHFNlOzQimgsMc/OERlOOshpzLocpu9YRIkK
 6Uu68rlOHgcK9/RJyU5jYg48YFF2QGIedG9O6w9DRur6xhv+qwaFGi/5IhqTVTI0Y9EP
 dFC6KJe4/A1d2m1WqD0pR0ydDoj+mwb4wQCUbaHBd8B6PjOil14oDvl8dCUB558v3KlO
 ugljqFVOH83X0AOVDe+x60Xa8/OoFIuYrI7sSduNBqSvHCy3kxjPV8DFVwslViIHHi8D
 fmMFxZpKkPxBkZUiVNIw2UWEjoToZwuTeU5AgwT8s1N9p9TkDi1ZW+4FxkQfkwMFjEzx
 wd3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756827974; x=1757432774;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9FYKKUKfTkSEmbNbzPMeX4HmyDIcQzy3TH7WUrTS7y0=;
 b=tBIxRZgXjb6PWK2aV0cAjmvdqh24oJ7sAKNeuvpznYt32fD+q+4cMLNMEOpaZ44/ET
 xa//rDUqb+LuLqgQd3f9X7gEtjkd/55p8x6+hsuUFhFfkbQmi0p1ZQ6OL0CwiIEf8pTL
 H6ePiclChw2/6KUzSCCBQbmolGnn4xn/iaY3xvsXkMczQ5yBnOvgkJtL49iZfX+Mq5E4
 GOjrDssZExeiec6Y0K3XwuLk62fud4bBtDim/9O8D7saAMPd+kCw6shRFfKDxsgB4tx6
 dGgL+PDp57Fghd9QE1vKSHhmuyjj+0jiKBKDoc0dk9jsMG5B2UW3gyXuYc6rINUFVukh
 X71A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbT76B4cbwF+sPPAE6gzrZq2G8/jF1L61qW60Lj2Bvkhxk+VXvYum4VOyzCQvDP4Sb72xPeJ2k@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz8M5kup+udMemDESb2pLDT/QbBCFdw+wh3M9W5b4FXUuJrn1+L
 H060QvU9W989qt7r+RjEv0m9rdyg1z53WV69FA2dUFknpDZsB1VKv/7Ga6aGbB9ybmyGi3X2bt+
 q/i7PmJYchJzyqurtUkzTpQZHKvejtD0i7uRy
X-Gm-Gg: ASbGncthKDQqlQelfDtWzEJ8MKCmN9xNh3zFhXZS0W88M7m48W1dKGAf6rpZeko3Gh7
 Ui5FNO7tCfM/16RmW4qoaot+6deDKdSSuvep5lqzZPu2abRfQzrwSqA15rGoXwJ1PTNRKBA+WNT
 WA87UzFRv+1vOJxT/Qv6YVYyN3mDUxx/Uoswbn07R8jeZkNbkkpL+jgwkcShhSo8aNR8SzGIef0
 WGVxWXsAa6yu38dxeQ8b9R1Fzk/
X-Google-Smtp-Source: AGHT+IG8LPRbTh40Ch05aq3hjSfPxflpHETslddFd63VU0uSFI7GO+r8ChPAWA6SC8AQ/YRi4JXykrvIV6OejMaK8m0=
X-Received: by 2002:a17:90b:33d0:b0:327:c784:7c38 with SMTP id
 98e67ed59e1d1-327e6584d88mr11323536a91.2.1756827973747; Tue, 02 Sep 2025
 08:46:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250826074646.1775241-1-Prike.Liang@amd.com>
 <20250826074646.1775241-8-Prike.Liang@amd.com>
 <CADnq5_PDwsgY-sjkeCQ=eiiCF4Z4XXcGN3Q5d5D05obr6BXeZQ@mail.gmail.com>
 <PH7PR12MB600043FCEDC15FB294FB7966FB38A@PH7PR12MB6000.namprd12.prod.outlook.com>
 <CADnq5_P0so23DcH3+JO70RYxDDGWYdofeQJkrzCWy+PHOUyMPw@mail.gmail.com>
 <DS7PR12MB6005421EF6E18DA1BDD4B29AFB07A@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB6005421EF6E18DA1BDD4B29AFB07A@DS7PR12MB6005.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 2 Sep 2025 11:46:02 -0400
X-Gm-Features: Ac12FXxQ8927z6liCy8bmxSeGbldxchf480OD_Vui_CzbOZHXIrei335kATpJ78
Message-ID: <CADnq5_M5MGLnzYQzTikfKiqWKZpnA03dgawd2Y54tHW57N0u+A@mail.gmail.com>
Subject: Re: [PATCH v9 08/14] drm/amdgpu: add userq object va track helpers
To: "Liang, Prike" <Prike.Liang@amd.com>
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
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

On Mon, Sep 1, 2025 at 5:13=E2=80=AFAM Liang, Prike <Prike.Liang@amd.com> w=
rote:
>
> [Public]
>
>
>
> Regards,
>       Prike
>
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Thursday, August 28, 2025 6:13 AM
> > To: Liang, Prike <Prike.Liang@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> > <Alexander.Deucher@amd.com>
> > Subject: Re: [PATCH v9 08/14] drm/amdgpu: add userq object va track hel=
pers
> >
> > On Wed, Aug 27, 2025 at 8:07=E2=80=AFAM Liang, Prike <Prike.Liang@amd.c=
om> wrote:
> > >
> > > [Public]
> > >
> > > Regards,
> > >       Prike
> > >
> > > > -----Original Message-----
> > > > From: Alex Deucher <alexdeucher@gmail.com>
> > > > Sent: Tuesday, August 26, 2025 11:22 PM
> > > > To: Liang, Prike <Prike.Liang@amd.com>
> > > > Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> > > > <Alexander.Deucher@amd.com>; Koenig, Christian
> > > > <Christian.Koenig@amd.com>
> > > > Subject: Re: [PATCH v9 08/14] drm/amdgpu: add userq object va track
> > > > helpers
> > > >
> > > > On Tue, Aug 26, 2025 at 3:47=E2=80=AFAM Prike Liang <Prike.Liang@am=
d.com> wrote:
> > > > >
> > > > > Add the userq object virtual address get(),mapped() and put()
> > > > > helpers for tracking the userq obj va address usage.
> > > > >
> > > > > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > > > > ---
> > > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 172
> > > > > ++++++++++++++++++++-  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> > > > > ++++++++++++++++++++|  14
> > > > ++
> > > > >  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |   4 +
> > > > >  3 files changed, 189 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > > > index 0aeb7a96ccbf..562d12f9d0d2 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > > > @@ -76,6 +76,174 @@ int amdgpu_userq_input_va_validate(struct
> > > > > amdgpu_vm
> > > > *vm, u64 addr,
> > > > >         return r;
> > > > >  }
> > > > >
> > > > > +int amdgpu_userq_buffer_va_get(struct amdgpu_vm *vm, u64 addr) {
> > > > > +       struct amdgpu_bo_va_mapping *mapping;
> > > > > +       u64 user_addr;
> > > > > +       int r;
> > > > > +
> > > > > +       user_addr =3D (addr & AMDGPU_GMC_HOLE_MASK) >>
> > > > AMDGPU_GPU_PAGE_SHIFT;
> > > > > +       r =3D amdgpu_bo_reserve(vm->root.bo, false);
> > > > > +       if (r)
> > > > > +               return r;
> > > > > +
> > > > > +       mapping =3D amdgpu_vm_bo_lookup_mapping(vm, user_addr);
> > > > > +       if (!mapping)
> > > > > +               goto out_err;
> > > > > +
> > > > > +       /*
> > > > > +        * Need to unify the following userq va reference.
> > > > > +        *  mqd  bo
> > > > > +        *  rptr bo
> > > > > +        *  wptr bo
> > > > > +        *  eop  bo
> > > > > +        *  shadow bo
> > > > > +        *  csa bo
> > > > > +        */
> > > > > +       /*amdgpu_bo_ref(mapping->bo_va->base.bo);*/
> > > > > +       mapping->bo_va->queue_refcount++;
> > > > > +
> > > > > +       amdgpu_bo_unreserve(vm->root.bo);
> > > > > +       return 0;
> > > > > +
> > > > > +out_err:
> > > > > +       amdgpu_bo_unreserve(vm->root.bo);
> > > > > +       return -EINVAL;
> > > > > +}
> > > > > +
> > > > > +bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 add=
r) {
> > > > > +       struct amdgpu_bo_va_mapping *mapping;
> > > > > +       u64 user_addr;
> > > > > +       bool r;
> > > > > +
> > > > > +       user_addr =3D (addr & AMDGPU_GMC_HOLE_MASK) >>
> > > > > + AMDGPU_GPU_PAGE_SHIFT;
> > > > > +
> > > > > +       if (amdgpu_bo_reserve(vm->root.bo, false))
> > > > > +               return false;
> > > > > +
> > > > > +       mapping =3D amdgpu_vm_bo_lookup_mapping(vm, user_addr);
> > > > > +       if (!IS_ERR_OR_NULL(mapping) && mapping->bo_va-
> > >queue_refcount > 0)
> > > > > +               r =3D true;
> > > > > +       else
> > > > > +               r =3D false;
> > > > > +       amdgpu_bo_unreserve(vm->root.bo);
> > > > > +
> > > > > +       return r;
> > > > > +}
> > > > > +
> > > > > +bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_vm *vm,
> > > > > +                       struct amdgpu_usermode_queue *queue) {
> > > > > +
> > > > > +       switch (queue->queue_type) {
> > > > > +       case AMDGPU_HW_IP_GFX:
> > > > > +               if (amdgpu_userq_buffer_va_mapped(vm, queue->queu=
e_va) ||
> > > > > +                   amdgpu_userq_buffer_va_mapped(vm, queue->rptr=
_va) ||
> > > > > +                   amdgpu_userq_buffer_va_mapped(vm, queue->wptr=
_va) ||
> > > > > +                   amdgpu_userq_buffer_va_mapped(vm, queue->shad=
ow_va) ||
> > > > > +                   amdgpu_userq_buffer_va_mapped(vm, queue->csa_=
va))
> > > > > +                       return true;
> > > > > +               break;
> > > > > +       case AMDGPU_HW_IP_COMPUTE:
> > > > > +               if (amdgpu_userq_buffer_va_mapped(vm, queue->queu=
e_va) ||
> > > > > +                   amdgpu_userq_buffer_va_mapped(vm, queue->rptr=
_va) ||
> > > > > +                   amdgpu_userq_buffer_va_mapped(vm, queue->wptr=
_va) ||
> > > > > +                   amdgpu_userq_buffer_va_mapped(vm, queue->eop_=
va))
> > > > > +                       return true;
> > > > > +               break;
> > > > > +       case AMDGPU_HW_IP_DMA:
> > > > > +               if (amdgpu_userq_buffer_va_mapped(vm, queue->queu=
e_va) ||
> > > > > +                   amdgpu_userq_buffer_va_mapped(vm, queue->rptr=
_va) ||
> > > > > +                   amdgpu_userq_buffer_va_mapped(vm, queue->wptr=
_va) ||
> > > > > +                   amdgpu_userq_buffer_va_mapped(vm, queue->csa_=
va))
> > > > > +                       return true;
> > > > > +               break;
> > > > > +       default:
> > > > > +               break;
> > > > > +       }
> > > > > +
> > > > > +       return false;
> > > > > +}
> > > > > +
> > > > > +int amdgpu_userq_buffer_va_put(struct amdgpu_vm *vm, u64 addr) {
> > > > > +       struct amdgpu_bo_va_mapping *mapping;
> > > > > +       u64 user_addr;
> > > > > +       int r;
> > > > > +
> > > > > +       user_addr =3D (addr & AMDGPU_GMC_HOLE_MASK) >>
> > > > AMDGPU_GPU_PAGE_SHIFT;
> > > > > +       r =3D amdgpu_bo_reserve(vm->root.bo, false);
> > > > > +       if (r)
> > > > > +               return r;
> > > > > +
> > > > > +       mapping =3D amdgpu_vm_bo_lookup_mapping(vm, user_addr);
> > > > > +       if (!mapping)
> > > > > +               goto out_err;
> > > > > +       /*
> > > > > +        * TODO: It requires figuring out the root cause of userq=
 va mapping
> > > > > +        * reference imbalance issue.
> > > > > +        */
> > > > > +       /*amdgpu_bo_unref(&mapping->bo_va->base.bo);*/
> > > > > +       mapping->bo_va->queue_refcount--;
> > > > > +
> > > > > +       amdgpu_bo_unreserve(vm->root.bo);
> > > > > +       return 0;
> > > > > +
> > > > > +out_err:
> > > > > +       amdgpu_bo_unreserve(vm->root.bo);
> > > > > +       return -EINVAL;
> > > > > +}
> > > > > +
> > > > > +static void amdgpu_userq_buffer_vas_get(struct amdgpu_vm *vm,
> > > > > +                       struct amdgpu_usermode_queue *queue) {
> > > > > +
> > > > > +
> > > > > +       amdgpu_userq_buffer_va_get(vm, queue->queue_va);
> > > > > +       amdgpu_userq_buffer_va_get(vm, queue->rptr_va);
> > > > > +       amdgpu_userq_buffer_va_get(vm, queue->wptr_va);
> > > > > +
> > > > > +       switch (queue->queue_type) {
> > > > > +       case AMDGPU_HW_IP_GFX:
> > > > > +               amdgpu_userq_buffer_va_get(vm, queue->shadow_va);
> > > > > +               amdgpu_userq_buffer_va_get(vm, queue->csa_va);
> > > > > +               break;
> > > > > +       case AMDGPU_HW_IP_COMPUTE:
> > > > > +               amdgpu_userq_buffer_va_get(vm, queue->eop_va);
> > > > > +               break;
> > > > > +       case AMDGPU_HW_IP_DMA:
> > > > > +               amdgpu_userq_buffer_va_get(vm, queue->csa_va);
> > > > > +               break;
> > > > > +       default:
> > > > > +               break;
> > > > > +       }
> > > > > +}
> > > > > +
> > > > > +int amdgpu_userq_buffer_vas_put(struct amdgpu_vm *vm,
> > > > > +                       struct amdgpu_usermode_queue *queue) {
> > > > > +       amdgpu_userq_buffer_va_put(vm, queue->queue_va);
> > > > > +       amdgpu_userq_buffer_va_put(vm, queue->rptr_va);
> > > > > +       amdgpu_userq_buffer_va_put(vm, queue->wptr_va);
> > > > > +
> > > > > +       switch (queue->queue_type) {
> > > > > +       case AMDGPU_HW_IP_GFX:
> > > > > +               amdgpu_userq_buffer_va_put(vm, queue->shadow_va);
> > > > > +               amdgpu_userq_buffer_va_put(vm, queue->csa_va);
> > > > > +               break;
> > > > > +       case AMDGPU_HW_IP_COMPUTE:
> > > > > +               amdgpu_userq_buffer_va_put(vm, queue->eop_va);
> > > > > +               break;
> > > > > +       case AMDGPU_HW_IP_DMA:
> > > > > +               amdgpu_userq_buffer_va_put(vm, queue->csa_va);
> > > > > +               break;
> > > > > +       default:
> > > > > +               break;
> > > > > +       }
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > > >  static int
> > > > >  amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
> > > > >                           struct amdgpu_usermode_queue *queue) @@
> > > > > -445,6 +613,9 @@ amdgpu_userq_create(struct drm_file *filp, union
> > > > drm_amdgpu_userq *args)
> > > > >         queue->vm =3D &fpriv->vm;
> > > > >         queue->priority =3D priority;
> > > > >         queue->generation =3D amdgpu_vm_generation(adev,
> > > > > &fpriv->vm);
> > > > > +       queue->queue_va =3D args->in.queue_va;
> > > > > +       queue->rptr_va =3D args->in.rptr_va;
> > > > > +       queue->wptr_va =3D args->in.wptr_va;
> > > > >
> > > > >         db_info.queue_type =3D queue->queue_type;
> > > > >         db_info.doorbell_handle =3D queue->doorbell_handle; @@
> > > > > -475,7
> > > > > +646,6 @@ amdgpu_userq_create(struct drm_file *filp, union
> > > > > +drm_amdgpu_userq
> > > > *args)
> > > > >                 goto unlock;
> > > > >         }
> > > > >
> > > > > -
> > > > >         qid =3D idr_alloc(&uq_mgr->userq_idr, queue, 1,
> > > > AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
> > > > >         if (qid < 0) {
> > > > >                 drm_file_err(uq_mgr->file, "Failed to allocate a
> > > > > queue id\n"); diff --git
> > > > > a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> > > > > index 0eb2a9c2e340..30067f80eadf 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> > > > > @@ -54,6 +54,13 @@ struct amdgpu_usermode_queue {
> > > > >         enum amdgpu_userq_state state;
> > > > >         uint64_t                doorbell_handle;
> > > > >         uint64_t                doorbell_index;
> > > > > +       uint64_t                queue_va;
> > > > > +       uint64_t                rptr_va;
> > > > > +       uint64_t                wptr_va;
> > > > > +       uint64_t                eop_va;
> > > > > +       uint64_t                shadow_va;
> > > > > +       uint64_t                csa_va;
> > > >
> > > > Just store a list of critical virtual addresses.  Otherwise we are
> > > > going to have a ton of IP specific things in here.  For each critic=
al address, just
> > push the address on the list.
> > > > Then in the VM unmap code, just walk the list for each queue and if
> > > > the user tries to umap a critical buffer, preempt the queue and set=
 an error on it.
> > > Is enough to track the queue_va for validating the userq VA unmap ope=
ration?
> > > I proposed a similar solution for retrieving the userq by walking ove=
r VA list, but
> > Christian rejected this for the overhead cause.
> > >
> >
> > I think queue creation and unmap are the only cases that we care about.=
  We don't
> > want to create a queue with an invalid addresses and we don't want to u=
nmap a
> > virtual address that is critical for the queue before the queue is dest=
royed.
> >
> > I think all we need to do in the unmap case is to walk the critical VA =
lists for each
> > user queue associated with the VM and check it.
> > @Christian Koenig did you have something else in mind?
>
>
> Limiting tracking to a subset of user-queue VAs would lower overhead. Wou=
ld tracking only queue_va, rptr_va, and wptr_va be sufficient to validate u=
ser-queue VA unmaps?

We should track all of the critical buffer VAs.

> However, partial tracking risks missing invalid unmap events on untracked=
 VAs.
> Although patch #14 can detect invalid user-queue VA unmaps by checking bo=
_va->queue_refcount, but if we only look up a partial VA list, we may still=
 fail to identify the specific queue whose VA was improperly unmapped, and =
therefore we cannot preempt and mark that queue as invalid. Thought?

We can store the critical buffers list in the struct
amdgpu_usermode_queue.  Then walk the lists when we unmap the VA:

idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
    if (amdgpu_userq_critical_va(queue, va_address, va_size)) {
          preempt(queue);
          queue->status =3D AMDGPU_USERQ_STATE_INVALID_VA;
    }
}

Alex

>
>
> Thanks,
> Prike
>
> > Thanks,
> >
> > Alex
> >
> > > > Alex
> > > >
> > > > > +
> > > > >         uint64_t                flags;
> > > > >         struct amdgpu_mqd_prop  *userq_prop;
> > > > >         struct amdgpu_userq_mgr *userq_mgr; @@ -137,4 +144,11 @@
> > > > > int amdgpu_userq_start_sched_for_enforce_isolation(struct
> > > > > amdgpu_device *adev,
> > > > >
> > > > >  int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 add=
r,
> > > > >                         u64 expected_size);
> > > > > +int amdgpu_userq_buffer_va_get(struct amdgpu_vm *vm, u64 addr);
> > > > > +bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64
> > > > > +addr); bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_vm *vm,
> > > > > +                       struct amdgpu_usermode_queue *queue); int
> > > > > +amdgpu_userq_buffer_va_put(struct amdgpu_vm *vm, u64 addr); int
> > > > > +amdgpu_userq_buffer_vas_put(struct amdgpu_vm *vm,
> > > > > +                       struct amdgpu_usermode_queue *queue);
> > > > >  #endif
> > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > > > > b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > > > > index 6e29e85bbf9f..42d6cd90be59 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > > > > @@ -262,6 +262,7 @@ static int mes_userq_mqd_create(struct
> > > > amdgpu_userq_mgr *uq_mgr,
> > > > >                 userq_props->hqd_active =3D false;
> > > > >                 userq_props->tmz_queue =3D
> > > > >                         mqd_user->flags &
> > > > > AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
> > > > > +               queue->eop_va =3D compute_mqd->eop_va;
> > > > >                 kfree(compute_mqd);
> > > > >         } else if (queue->queue_type =3D=3D AMDGPU_HW_IP_GFX) {
> > > > >                 struct drm_amdgpu_userq_mqd_gfx11 *mqd_gfx_v11; @=
@
> > > > > -283,6 +284,8 @@ static int mes_userq_mqd_create(struct
> > > > > amdgpu_userq_mgr
> > > > *uq_mgr,
> > > > >                 userq_props->csa_addr =3D mqd_gfx_v11->csa_va;
> > > > >                 userq_props->tmz_queue =3D
> > > > >                         mqd_user->flags &
> > > > > AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
> > > > > +               queue->shadow_va =3D mqd_gfx_v11->shadow_va;
> > > > > +               queue->csa_va =3D mqd_gfx_v11->csa_va;
> > > > >
> > > > >                 if (amdgpu_userq_input_va_validate(queue->vm,
> > > > >mqd_gfx_v11- shadow_va,
> > > > >                                         shadow_info.shadow_size))
> > > > >{ @@
> > > > > -314,6 +317,7 @@ static int mes_userq_mqd_create(struct
> > > > >amdgpu_userq_mgr
> > > > *uq_mgr,
> > > > >                 }
> > > > >
> > > > >                 userq_props->csa_addr =3D mqd_sdma_v11->csa_va;
> > > > > +               queue->csa_va =3D mqd_sdma_v11->csa_va;
> > > > >                 kfree(mqd_sdma_v11);
> > > > >         }
> > > > >
> > > > > --
> > > > > 2.34.1
> > > > >
