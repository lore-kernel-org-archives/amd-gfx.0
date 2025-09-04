Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD75DCA1002
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Sep 2025 15:26:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D3F210EA85;
	Thu,  4 Sep 2025 15:26:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Dcpcdupw";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 508A910EA98
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Sep 2025 15:26:37 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-24602f6d8b6so2112785ad.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Sep 2025 08:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756999597; x=1757604397; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=21YnSHupxscgxApUW6Rf/Wz6cYpPT39TpEw62YeYcno=;
 b=DcpcdupwpVEIYf+VxczTvcO+Enlo/Ue6e3XyQcCt+RNIAcNcVqSn64H8MXGxgJon4Y
 cRY5jel3Y/khcnh0QGOUaiFqbb/fTSsgu/fvv3axc93BO1ZRWSP3xPuKifwWs70bIRTd
 mG4Idbe1MomC8k9N9frYTFphQyiWQ5Rn/d8mF71hHxLza2kjrUUJCmiTaKRmB6LPQesF
 5I2M7a7EaC1OREAbrFeFUYnItDnX0s6Dtfs+UPwH8jcIOxjA46qMtTW2MvS3ucViEmkb
 tWzFd4/meruIMWuQJp0fItJ1TIG+wODMUl3wr8PM0W/HSlvQDWAoKvYRVOFk+/8qlK3g
 IHLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756999597; x=1757604397;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=21YnSHupxscgxApUW6Rf/Wz6cYpPT39TpEw62YeYcno=;
 b=Fsm0nZrroQ5WWKzZhIWpxsHiSH14jbFL/VuYjCPni2IOOqluHENptArmekhqQ2F6Uy
 u9mLeyDPv3bEHQXDkz0xfke3mlgSKVoxQcfFZqo/NPdd8ckLlWWPP6grPVOk2ukjssnD
 2/5lvbKPfwONxXkt0kV6de9w0OIu7uW2u+/Iupl6cPDwevUe5k2vX/zyL77UPUk6Lz6t
 jRmfG7P8c/ak5kqPcyjeoxZQgOzBUqAQcLYPtM9l1chP1ZCW2Fkheo2eGh9y6ClT48B9
 RT7XvDaxbR4p0YLVTdh12AmW7WsI0xD48JDWrlcpPFjrhGpz9oONTcWxNTLWA4tDOO0G
 zREA==
X-Gm-Message-State: AOJu0Yyh0im5fk1GFW9pB5ckbJPuXrx2pMmPIQKOvq8rlUFf5mfwuKo7
 cQmlq5gsuRdXlrizVdg6lrhdpsblX2bDuTzrgVFU+hV2Pb8X4lGHOHJ3ciK8qQcwNBkinlT38OD
 t8Qdxle+Q0ZmTpF1XVBSfN0dBivHfJ5t/qw==
X-Gm-Gg: ASbGncsdzlg8ZRsuRyuTel6mjnBViwrrqq8drJtZPgql4x5QzkMS6hADGowZ290C4xD
 r7qOy6PJizQ7giY77hqqjRO7SVOMrJf5Cb4HHElbfdIkmwLEyt+YocP1UvQ/bm40j8qs3sILRKu
 2GV+Lbs2eNDyoRRR96pqULA8b3DMTcjfoNQszGx8bkGi7zHl7qM4rzJg0p0lMy8DAYyAxp06ymI
 g2vXYDq+76486w6Vg==
X-Google-Smtp-Source: AGHT+IHQtXbeVHo8MKoOYe3gCbVK9TPkhnU6QmKdvXAR8XqbgrTzx2SlYqvcwjHB/ughCbqC/BKozoBEY9ev0Otw/Ok=
X-Received: by 2002:a17:902:ecce:b0:24c:7a1a:ae72 with SMTP id
 d9443c01a7336-24c7a1ab42fmr57733805ad.10.1756999596687; Thu, 04 Sep 2025
 08:26:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250826074646.1775241-1-Prike.Liang@amd.com>
 <20250826074646.1775241-8-Prike.Liang@amd.com>
 <CADnq5_PDwsgY-sjkeCQ=eiiCF4Z4XXcGN3Q5d5D05obr6BXeZQ@mail.gmail.com>
 <PH7PR12MB600043FCEDC15FB294FB7966FB38A@PH7PR12MB6000.namprd12.prod.outlook.com>
 <CADnq5_P0so23DcH3+JO70RYxDDGWYdofeQJkrzCWy+PHOUyMPw@mail.gmail.com>
 <DS7PR12MB6005421EF6E18DA1BDD4B29AFB07A@DS7PR12MB6005.namprd12.prod.outlook.com>
 <CADnq5_M5MGLnzYQzTikfKiqWKZpnA03dgawd2Y54tHW57N0u+A@mail.gmail.com>
 <DS7PR12MB600594D4B760FE58BC07B744FB01A@DS7PR12MB6005.namprd12.prod.outlook.com>
 <CADnq5_M9MPuat=Rivq27A-4TEm9i5zDi76Wj4avUJUo2PW+8OA@mail.gmail.com>
In-Reply-To: <CADnq5_M9MPuat=Rivq27A-4TEm9i5zDi76Wj4avUJUo2PW+8OA@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 4 Sep 2025 11:26:25 -0400
X-Gm-Features: Ac12FXz2tNwHMYzyXhPg3ST_8flRJE8DI9g1g3sNsjsxvntkY_treAEmvygO3oI
Message-ID: <CADnq5_PcjZEdZ325R8uMofOY9+8uo_gyJ=G5j8JDsG9DFYSapA@mail.gmail.com>
Subject: Re: [PATCH v9 08/14] drm/amdgpu: add userq object va track helpers
To: "Liang, Prike" <Prike.Liang@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
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

On Wed, Sep 3, 2025 at 6:19=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com>=
 wrote:
>
> On Wed, Sep 3, 2025 at 8:56=E2=80=AFAM Liang, Prike <Prike.Liang@amd.com>=
 wrote:
> >
> > [Public]
> >
> > Regards,
> >       Prike
> >
> > > -----Original Message-----
> > > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Al=
ex
> > > Deucher
> > > Sent: Tuesday, September 2, 2025 11:46 PM
> > > To: Liang, Prike <Prike.Liang@amd.com>
> > > Cc: Koenig, Christian <Christian.Koenig@amd.com>; amd-
> > > gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.=
com>
> > > Subject: Re: [PATCH v9 08/14] drm/amdgpu: add userq object va track h=
elpers
> > >
> > > On Mon, Sep 1, 2025 at 5:13=E2=80=AFAM Liang, Prike <Prike.Liang@amd.=
com> wrote:
> > > >
> > > > [Public]
> > > >
> > > >
> > > >
> > > > Regards,
> > > >       Prike
> > > >
> > > > > -----Original Message-----
> > > > > From: Alex Deucher <alexdeucher@gmail.com>
> > > > > Sent: Thursday, August 28, 2025 6:13 AM
> > > > > To: Liang, Prike <Prike.Liang@amd.com>; Koenig, Christian
> > > > > <Christian.Koenig@amd.com>
> > > > > Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> > > > > <Alexander.Deucher@amd.com>
> > > > > Subject: Re: [PATCH v9 08/14] drm/amdgpu: add userq object va tra=
ck
> > > > > helpers
> > > > >
> > > > > On Wed, Aug 27, 2025 at 8:07=E2=80=AFAM Liang, Prike <Prike.Liang=
@amd.com> wrote:
> > > > > >
> > > > > > [Public]
> > > > > >
> > > > > > Regards,
> > > > > >       Prike
> > > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: Alex Deucher <alexdeucher@gmail.com>
> > > > > > > Sent: Tuesday, August 26, 2025 11:22 PM
> > > > > > > To: Liang, Prike <Prike.Liang@amd.com>
> > > > > > > Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> > > > > > > <Alexander.Deucher@amd.com>; Koenig, Christian
> > > > > > > <Christian.Koenig@amd.com>
> > > > > > > Subject: Re: [PATCH v9 08/14] drm/amdgpu: add userq object va
> > > > > > > track helpers
> > > > > > >
> > > > > > > On Tue, Aug 26, 2025 at 3:47=E2=80=AFAM Prike Liang <Prike.Li=
ang@amd.com>
> > > wrote:
> > > > > > > >
> > > > > > > > Add the userq object virtual address get(),mapped() and put=
()
> > > > > > > > helpers for tracking the userq obj va address usage.
> > > > > > > >
> > > > > > > > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > > > > > > > ---
> > > > > > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 172
> > > > > > > > ++++++++++++++++++++-
> > > > > > > > ++++++++++++++++++++drivers/gpu/drm/amd/amdgpu/amdgpu_userq=
.h
> > > > > > > > ++++++++++++++++++++|  14
> > > > > > > ++
> > > > > > > >  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |   4 +
> > > > > > > >  3 files changed, 189 insertions(+), 1 deletion(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > > > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > > > > > > index 0aeb7a96ccbf..562d12f9d0d2 100644
> > > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > > > > > > @@ -76,6 +76,174 @@ int amdgpu_userq_input_va_validate(stru=
ct
> > > > > > > > amdgpu_vm
> > > > > > > *vm, u64 addr,
> > > > > > > >         return r;
> > > > > > > >  }
> > > > > > > >
> > > > > > > > +int amdgpu_userq_buffer_va_get(struct amdgpu_vm *vm, u64 a=
ddr) {
> > > > > > > > +       struct amdgpu_bo_va_mapping *mapping;
> > > > > > > > +       u64 user_addr;
> > > > > > > > +       int r;
> > > > > > > > +
> > > > > > > > +       user_addr =3D (addr & AMDGPU_GMC_HOLE_MASK) >>
> > > > > > > AMDGPU_GPU_PAGE_SHIFT;
> > > > > > > > +       r =3D amdgpu_bo_reserve(vm->root.bo, false);
> > > > > > > > +       if (r)
> > > > > > > > +               return r;
> > > > > > > > +
> > > > > > > > +       mapping =3D amdgpu_vm_bo_lookup_mapping(vm, user_ad=
dr);
> > > > > > > > +       if (!mapping)
> > > > > > > > +               goto out_err;
> > > > > > > > +
> > > > > > > > +       /*
> > > > > > > > +        * Need to unify the following userq va reference.
> > > > > > > > +        *  mqd  bo
> > > > > > > > +        *  rptr bo
> > > > > > > > +        *  wptr bo
> > > > > > > > +        *  eop  bo
> > > > > > > > +        *  shadow bo
> > > > > > > > +        *  csa bo
> > > > > > > > +        */
> > > > > > > > +       /*amdgpu_bo_ref(mapping->bo_va->base.bo);*/
> > > > > > > > +       mapping->bo_va->queue_refcount++;
> > > > > > > > +
> > > > > > > > +       amdgpu_bo_unreserve(vm->root.bo);
> > > > > > > > +       return 0;
> > > > > > > > +
> > > > > > > > +out_err:
> > > > > > > > +       amdgpu_bo_unreserve(vm->root.bo);
> > > > > > > > +       return -EINVAL;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u=
64
> > > addr) {
> > > > > > > > +       struct amdgpu_bo_va_mapping *mapping;
> > > > > > > > +       u64 user_addr;
> > > > > > > > +       bool r;
> > > > > > > > +
> > > > > > > > +       user_addr =3D (addr & AMDGPU_GMC_HOLE_MASK) >>
> > > > > > > > + AMDGPU_GPU_PAGE_SHIFT;
> > > > > > > > +
> > > > > > > > +       if (amdgpu_bo_reserve(vm->root.bo, false))
> > > > > > > > +               return false;
> > > > > > > > +
> > > > > > > > +       mapping =3D amdgpu_vm_bo_lookup_mapping(vm, user_ad=
dr);
> > > > > > > > +       if (!IS_ERR_OR_NULL(mapping) && mapping->bo_va-
> > > > > >queue_refcount > 0)
> > > > > > > > +               r =3D true;
> > > > > > > > +       else
> > > > > > > > +               r =3D false;
> > > > > > > > +       amdgpu_bo_unreserve(vm->root.bo);
> > > > > > > > +
> > > > > > > > +       return r;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_vm *vm,
> > > > > > > > +                       struct amdgpu_usermode_queue *queue=
) {
> > > > > > > > +
> > > > > > > > +       switch (queue->queue_type) {
> > > > > > > > +       case AMDGPU_HW_IP_GFX:
> > > > > > > > +               if (amdgpu_userq_buffer_va_mapped(vm, queue=
->queue_va) ||
> > > > > > > > +                   amdgpu_userq_buffer_va_mapped(vm, queue=
->rptr_va) ||
> > > > > > > > +                   amdgpu_userq_buffer_va_mapped(vm, queue=
->wptr_va) ||
> > > > > > > > +                   amdgpu_userq_buffer_va_mapped(vm, queue=
->shadow_va)
> > > ||
> > > > > > > > +                   amdgpu_userq_buffer_va_mapped(vm, queue=
->csa_va))
> > > > > > > > +                       return true;
> > > > > > > > +               break;
> > > > > > > > +       case AMDGPU_HW_IP_COMPUTE:
> > > > > > > > +               if (amdgpu_userq_buffer_va_mapped(vm, queue=
->queue_va) ||
> > > > > > > > +                   amdgpu_userq_buffer_va_mapped(vm, queue=
->rptr_va) ||
> > > > > > > > +                   amdgpu_userq_buffer_va_mapped(vm, queue=
->wptr_va) ||
> > > > > > > > +                   amdgpu_userq_buffer_va_mapped(vm, queue=
->eop_va))
> > > > > > > > +                       return true;
> > > > > > > > +               break;
> > > > > > > > +       case AMDGPU_HW_IP_DMA:
> > > > > > > > +               if (amdgpu_userq_buffer_va_mapped(vm, queue=
->queue_va) ||
> > > > > > > > +                   amdgpu_userq_buffer_va_mapped(vm, queue=
->rptr_va) ||
> > > > > > > > +                   amdgpu_userq_buffer_va_mapped(vm, queue=
->wptr_va) ||
> > > > > > > > +                   amdgpu_userq_buffer_va_mapped(vm, queue=
->csa_va))
> > > > > > > > +                       return true;
> > > > > > > > +               break;
> > > > > > > > +       default:
> > > > > > > > +               break;
> > > > > > > > +       }
> > > > > > > > +
> > > > > > > > +       return false;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +int amdgpu_userq_buffer_va_put(struct amdgpu_vm *vm, u64 a=
ddr) {
> > > > > > > > +       struct amdgpu_bo_va_mapping *mapping;
> > > > > > > > +       u64 user_addr;
> > > > > > > > +       int r;
> > > > > > > > +
> > > > > > > > +       user_addr =3D (addr & AMDGPU_GMC_HOLE_MASK) >>
> > > > > > > AMDGPU_GPU_PAGE_SHIFT;
> > > > > > > > +       r =3D amdgpu_bo_reserve(vm->root.bo, false);
> > > > > > > > +       if (r)
> > > > > > > > +               return r;
> > > > > > > > +
> > > > > > > > +       mapping =3D amdgpu_vm_bo_lookup_mapping(vm, user_ad=
dr);
> > > > > > > > +       if (!mapping)
> > > > > > > > +               goto out_err;
> > > > > > > > +       /*
> > > > > > > > +        * TODO: It requires figuring out the root cause of=
 userq va mapping
> > > > > > > > +        * reference imbalance issue.
> > > > > > > > +        */
> > > > > > > > +       /*amdgpu_bo_unref(&mapping->bo_va->base.bo);*/
> > > > > > > > +       mapping->bo_va->queue_refcount--;
> > > > > > > > +
> > > > > > > > +       amdgpu_bo_unreserve(vm->root.bo);
> > > > > > > > +       return 0;
> > > > > > > > +
> > > > > > > > +out_err:
> > > > > > > > +       amdgpu_bo_unreserve(vm->root.bo);
> > > > > > > > +       return -EINVAL;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static void amdgpu_userq_buffer_vas_get(struct amdgpu_vm *=
vm,
> > > > > > > > +                       struct amdgpu_usermode_queue *queue=
) {
> > > > > > > > +
> > > > > > > > +
> > > > > > > > +       amdgpu_userq_buffer_va_get(vm, queue->queue_va);
> > > > > > > > +       amdgpu_userq_buffer_va_get(vm, queue->rptr_va);
> > > > > > > > +       amdgpu_userq_buffer_va_get(vm, queue->wptr_va);
> > > > > > > > +
> > > > > > > > +       switch (queue->queue_type) {
> > > > > > > > +       case AMDGPU_HW_IP_GFX:
> > > > > > > > +               amdgpu_userq_buffer_va_get(vm, queue->shado=
w_va);
> > > > > > > > +               amdgpu_userq_buffer_va_get(vm, queue->csa_v=
a);
> > > > > > > > +               break;
> > > > > > > > +       case AMDGPU_HW_IP_COMPUTE:
> > > > > > > > +               amdgpu_userq_buffer_va_get(vm, queue->eop_v=
a);
> > > > > > > > +               break;
> > > > > > > > +       case AMDGPU_HW_IP_DMA:
> > > > > > > > +               amdgpu_userq_buffer_va_get(vm, queue->csa_v=
a);
> > > > > > > > +               break;
> > > > > > > > +       default:
> > > > > > > > +               break;
> > > > > > > > +       }
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +int amdgpu_userq_buffer_vas_put(struct amdgpu_vm *vm,
> > > > > > > > +                       struct amdgpu_usermode_queue *queue=
) {
> > > > > > > > +       amdgpu_userq_buffer_va_put(vm, queue->queue_va);
> > > > > > > > +       amdgpu_userq_buffer_va_put(vm, queue->rptr_va);
> > > > > > > > +       amdgpu_userq_buffer_va_put(vm, queue->wptr_va);
> > > > > > > > +
> > > > > > > > +       switch (queue->queue_type) {
> > > > > > > > +       case AMDGPU_HW_IP_GFX:
> > > > > > > > +               amdgpu_userq_buffer_va_put(vm, queue->shado=
w_va);
> > > > > > > > +               amdgpu_userq_buffer_va_put(vm, queue->csa_v=
a);
> > > > > > > > +               break;
> > > > > > > > +       case AMDGPU_HW_IP_COMPUTE:
> > > > > > > > +               amdgpu_userq_buffer_va_put(vm, queue->eop_v=
a);
> > > > > > > > +               break;
> > > > > > > > +       case AMDGPU_HW_IP_DMA:
> > > > > > > > +               amdgpu_userq_buffer_va_put(vm, queue->csa_v=
a);
> > > > > > > > +               break;
> > > > > > > > +       default:
> > > > > > > > +               break;
> > > > > > > > +       }
> > > > > > > > +       return 0;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > >  static int
> > > > > > > >  amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
> > > > > > > >                           struct amdgpu_usermode_queue *que=
ue)
> > > > > > > > @@
> > > > > > > > -445,6 +613,9 @@ amdgpu_userq_create(struct drm_file *filp,
> > > > > > > > union
> > > > > > > drm_amdgpu_userq *args)
> > > > > > > >         queue->vm =3D &fpriv->vm;
> > > > > > > >         queue->priority =3D priority;
> > > > > > > >         queue->generation =3D amdgpu_vm_generation(adev,
> > > > > > > > &fpriv->vm);
> > > > > > > > +       queue->queue_va =3D args->in.queue_va;
> > > > > > > > +       queue->rptr_va =3D args->in.rptr_va;
> > > > > > > > +       queue->wptr_va =3D args->in.wptr_va;
> > > > > > > >
> > > > > > > >         db_info.queue_type =3D queue->queue_type;
> > > > > > > >         db_info.doorbell_handle =3D queue->doorbell_handle;=
 @@
> > > > > > > > -475,7
> > > > > > > > +646,6 @@ amdgpu_userq_create(struct drm_file *filp, union
> > > > > > > > +drm_amdgpu_userq
> > > > > > > *args)
> > > > > > > >                 goto unlock;
> > > > > > > >         }
> > > > > > > >
> > > > > > > > -
> > > > > > > >         qid =3D idr_alloc(&uq_mgr->userq_idr, queue, 1,
> > > > > > > AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
> > > > > > > >         if (qid < 0) {
> > > > > > > >                 drm_file_err(uq_mgr->file, "Failed to alloc=
ate
> > > > > > > > a queue id\n"); diff --git
> > > > > > > > a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> > > > > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> > > > > > > > index 0eb2a9c2e340..30067f80eadf 100644
> > > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> > > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> > > > > > > > @@ -54,6 +54,13 @@ struct amdgpu_usermode_queue {
> > > > > > > >         enum amdgpu_userq_state state;
> > > > > > > >         uint64_t                doorbell_handle;
> > > > > > > >         uint64_t                doorbell_index;
> > > > > > > > +       uint64_t                queue_va;
> > > > > > > > +       uint64_t                rptr_va;
> > > > > > > > +       uint64_t                wptr_va;
> > > > > > > > +       uint64_t                eop_va;
> > > > > > > > +       uint64_t                shadow_va;
> > > > > > > > +       uint64_t                csa_va;
> > > > > > >
> > > > > > > Just store a list of critical virtual addresses.  Otherwise w=
e
> > > > > > > are going to have a ton of IP specific things in here.  For e=
ach
> > > > > > > critical address, just
> > > > > push the address on the list.
> > > > > > > Then in the VM unmap code, just walk the list for each queue =
and
> > > > > > > if the user tries to umap a critical buffer, preempt the queu=
e and set an error
> > > on it.
> > > > > > Is enough to track the queue_va for validating the userq VA unm=
ap operation?
> > > > > > I proposed a similar solution for retrieving the userq by walki=
ng
> > > > > > over VA list, but
> > > > > Christian rejected this for the overhead cause.
> > > > > >
> > > > >
> > > > > I think queue creation and unmap are the only cases that we care
> > > > > about.  We don't want to create a queue with an invalid addresses
> > > > > and we don't want to unmap a virtual address that is critical for=
 the queue before
> > > the queue is destroyed.
> > > > >
> > > > > I think all we need to do in the unmap case is to walk the critic=
al
> > > > > VA lists for each user queue associated with the VM and check it.
> > > > > @Christian Koenig did you have something else in mind?
> > > >
> > > >
> > > > Limiting tracking to a subset of user-queue VAs would lower overhea=
d. Would
> > > tracking only queue_va, rptr_va, and wptr_va be sufficient to validat=
e user-queue VA
> > > unmaps?
> > >
> > > We should track all of the critical buffer VAs.
> > >
> > > > However, partial tracking risks missing invalid unmap events on unt=
racked VAs.
> > > > Although patch #14 can detect invalid user-queue VA unmaps by check=
ing bo_va-
> > > >queue_refcount, but if we only look up a partial VA list, we may sti=
ll fail to identify
> > > the specific queue whose VA was improperly unmapped, and therefore we=
 cannot
> > > preempt and mark that queue as invalid. Thought?
> > >
> > > We can store the critical buffers list in the struct amdgpu_usermode_=
queue.  Then
> > > walk the lists when we unmap the VA:
> > >
> > > idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
> > >     if (amdgpu_userq_critical_va(queue, va_address, va_size)) {
> > >           preempt(queue);
> > >           queue->status =3D AMDGPU_USERQ_STATE_INVALID_VA;
> > >     }
> > > }
> > >
> > > Alex
> >
> > Thank you for the proposal. If there are no objections, I will update t=
he userq retrieval method to walk the VA list instead of checking the mappi=
ng range.
>
> Sure.  @Christian Koenig any concerns on your end?

I talked to Christian, and he suggested we add a flag on the bo_va
structure and set it for the critical buffers.  If the flag is set,
we'd wait for the bookkeeping fences when we unmap.  Then on resume,
when we validate the buffers, if those buffers are not present we skip
the queue resume and set an error on the queue.

Alex

>
> Thanks,
>
> Alex
>
> >
> > > >
> > > >
> > > > Thanks,
> > > > Prike
> > > >
> > > > > Thanks,
> > > > >
> > > > > Alex
> > > > >
> > > > > > > Alex
> > > > > > >
> > > > > > > > +
> > > > > > > >         uint64_t                flags;
> > > > > > > >         struct amdgpu_mqd_prop  *userq_prop;
> > > > > > > >         struct amdgpu_userq_mgr *userq_mgr; @@ -137,4 +144,=
11
> > > > > > > > @@ int amdgpu_userq_start_sched_for_enforce_isolation(struc=
t
> > > > > > > > amdgpu_device *adev,
> > > > > > > >
> > > > > > > >  int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u=
64 addr,
> > > > > > > >                         u64 expected_size);
> > > > > > > > +int amdgpu_userq_buffer_va_get(struct amdgpu_vm *vm, u64
> > > > > > > > +addr); bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm
> > > > > > > > +*vm, u64 addr); bool amdgpu_userq_buffer_vas_mapped(struct
> > > amdgpu_vm *vm,
> > > > > > > > +                       struct amdgpu_usermode_queue *queue=
);
> > > > > > > > +int amdgpu_userq_buffer_va_put(struct amdgpu_vm *vm, u64
> > > > > > > > +addr); int amdgpu_userq_buffer_vas_put(struct amdgpu_vm *v=
m,
> > > > > > > > +                       struct amdgpu_usermode_queue *queue=
);
> > > > > > > >  #endif
> > > > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > > > > > > > b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > > > > > > > index 6e29e85bbf9f..42d6cd90be59 100644
> > > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > > > > > > > @@ -262,6 +262,7 @@ static int mes_userq_mqd_create(struct
> > > > > > > amdgpu_userq_mgr *uq_mgr,
> > > > > > > >                 userq_props->hqd_active =3D false;
> > > > > > > >                 userq_props->tmz_queue =3D
> > > > > > > >                         mqd_user->flags &
> > > > > > > > AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
> > > > > > > > +               queue->eop_va =3D compute_mqd->eop_va;
> > > > > > > >                 kfree(compute_mqd);
> > > > > > > >         } else if (queue->queue_type =3D=3D AMDGPU_HW_IP_GF=
X) {
> > > > > > > >                 struct drm_amdgpu_userq_mqd_gfx11
> > > > > > > > *mqd_gfx_v11; @@
> > > > > > > > -283,6 +284,8 @@ static int mes_userq_mqd_create(struct
> > > > > > > > amdgpu_userq_mgr
> > > > > > > *uq_mgr,
> > > > > > > >                 userq_props->csa_addr =3D mqd_gfx_v11->csa_=
va;
> > > > > > > >                 userq_props->tmz_queue =3D
> > > > > > > >                         mqd_user->flags &
> > > > > > > > AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
> > > > > > > > +               queue->shadow_va =3D mqd_gfx_v11->shadow_va=
;
> > > > > > > > +               queue->csa_va =3D mqd_gfx_v11->csa_va;
> > > > > > > >
> > > > > > > >                 if (amdgpu_userq_input_va_validate(queue->v=
m,
> > > > > > > >mqd_gfx_v11- shadow_va,
> > > > > > > >
> > > > > > > >shadow_info.shadow_size)) { @@
> > > > > > > > -314,6 +317,7 @@ static int mes_userq_mqd_create(struct
> > > > > > > >amdgpu_userq_mgr
> > > > > > > *uq_mgr,
> > > > > > > >                 }
> > > > > > > >
> > > > > > > >                 userq_props->csa_addr =3D mqd_sdma_v11->csa=
_va;
> > > > > > > > +               queue->csa_va =3D mqd_sdma_v11->csa_va;
> > > > > > > >                 kfree(mqd_sdma_v11);
> > > > > > > >         }
> > > > > > > >
> > > > > > > > --
> > > > > > > > 2.34.1
> > > > > > > >
