Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F055CCA0FED
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Aug 2025 22:06:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E91810E8DA;
	Wed, 27 Aug 2025 22:06:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fpGTYECE";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BE6410E8DA
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Aug 2025 22:06:03 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2489359cc48so596895ad.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Aug 2025 15:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756332363; x=1756937163; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cRp6WVQWWJGvLv+uu27rjt2As2BDGFvSiolaogeVju8=;
 b=fpGTYECEcrVRLiG5TBFRLuYnRPkUyHIBCjd3DjVlmV0e2+fyRuc7JrW56VeaTrMFj/
 MYcLX0ab860DD+kyku/nOA1ipYLAnlzQQge1VhF9uo+V9BjyuF1OqmVV0xnyHsRS+zxe
 OAC7rldou9fhCqC3TDP3vB6oQQIoIHbn+zhTrM1YCd4uFKD4/JrsjUoH+GkFq+njcP8o
 PgGFuC3XX71eo1OVeYdDdYEmkll4uXWaBpRGTJYd9g7An4DhAlbl46yXI1heDVAIcU0h
 ye2pye2RbhXslRr/VBVEY0q5W5nLNY/1ZKw7glF4Qew+TM8Ef6wSeNtpvg1FZ8OaP3Wy
 CWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756332363; x=1756937163;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cRp6WVQWWJGvLv+uu27rjt2As2BDGFvSiolaogeVju8=;
 b=IO3dXTR79z5eKM6t+TFFdrbijQgYiOEVGS4eVQPR+vACiaeMEWSv16Vk8EHM/GwiCz
 AVPkz1l4thU23Y2dDNGiuVVP7GZgCrMGikoyMSQ19XOKAYoQy/jseSQhUY2uqNTcl+0z
 cT1J80+zpgkohyOAU3nKoBYd10/6gqKe3wTdsuGmZjmaxgnSEwdV/KOcAIk6WmSzjrG2
 utNbKaHa5wE7Wipm6VbNgELDslrGPhUXVsxxf1MphOdQNVE/QAhzP0eaxxki012f0nsd
 N3Wc5I956H742XAQJ+y68vehNHUD05oEs1+QMtA9NRiadPpsQCL7+QBUlYeS9klYZVv6
 CNKw==
X-Gm-Message-State: AOJu0YxIw5n1/8r0FEq3J2XqYvbZxFx6w8C9Z1EksJWjwqJV7BCAFwiN
 63wcLRBcWQXqQXVLMgBLevfbFQ+VBPz75uC7tyHfCW6qCiaR4JJYJwQ0ErmxNkajoWx+SFY9S7g
 YB/VOXUHDv6PvvCjUTk6m/tnRjDinM+oXXQ==
X-Gm-Gg: ASbGncu2hVtQKBDKjuTyReeDmnsRw5+UqWHzUfb2AHRcNKPMzWOYOAwYaNChPIhK5Mf
 FVh9R5PrAnXvOJDF8TEf4+SLAakzLmPyhl8MgWSDSVcPZDCIriWd5oI/d8yd1hJXwUOdLU5KxAy
 6h+LNXf93Fwie8Yj0EmN480UxuzfsWFe1fgbeE2iHLYpwxSu5CZfJkM25aZ8lMoe+R8FliqFuky
 IcNlbacTWJpbr9EcQ==
X-Google-Smtp-Source: AGHT+IHNeczk+fM+f0mf/vh3WNHhqjgT6TxHp0FbEywicZ9WTExNkltQwpzqtydqWdQnE/qpWrkOFtbBdqNH3cuvup0=
X-Received: by 2002:a17:902:f691:b0:248:c914:ed58 with SMTP id
 d9443c01a7336-248c914f132mr13227775ad.0.1756332362758; Wed, 27 Aug 2025
 15:06:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250826074646.1775241-1-Prike.Liang@amd.com>
 <20250826074646.1775241-7-Prike.Liang@amd.com>
 <CADnq5_PsrmrqtAQCYZjPXiYFJbmGoaTvgHbRBOEkg6=LX64pew@mail.gmail.com>
 <PH7PR12MB6000567ED73E40D31AE816AFFB38A@PH7PR12MB6000.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB6000567ED73E40D31AE816AFFB38A@PH7PR12MB6000.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 27 Aug 2025 18:05:51 -0400
X-Gm-Features: Ac12FXyxfKxJ-zrOS4FQhUsj6fUZV50rGd4PeSt2SPCTQrcu8TBQ5SFHaSjwusc
Message-ID: <CADnq5_OxwF-BPka=Annb76j9BUzuVP1OD8h1xK7JU1S9OhFN2g@mail.gmail.com>
Subject: Re: [PATCH v9 07/14] drm/amdgpu: validate userq buffer virtual
 address and size
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

On Wed, Aug 27, 2025 at 7:41=E2=80=AFAM Liang, Prike <Prike.Liang@amd.com> =
wrote:
>
> [Public]
>
> Regards,
>       Prike
>
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Tuesday, August 26, 2025 11:00 PM
> > To: Liang, Prike <Prike.Liang@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.co=
m>
> > Subject: Re: [PATCH v9 07/14] drm/amdgpu: validate userq buffer virtual=
 address
> > and size
> >
> > On Tue, Aug 26, 2025 at 4:03=E2=80=AFAM Prike Liang <Prike.Liang@amd.co=
m> wrote:
> > >
> > > It needs to validate the userq object virtual address to determin
> > > whether it is residented in a valid vm mapping.
> >
> > determine
> >
> > >
> > > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > > Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 41
> > > ++++++++++++++++++++++  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |
> > > 2 ++  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 22 ++++++++++++
> > >  3 files changed, 65 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > index b670ca8111f3..0aeb7a96ccbf 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > @@ -44,6 +44,38 @@ u32 amdgpu_userq_get_supported_ip_mask(struct
> > amdgpu_device *adev)
> > >         return userq_ip_mask;
> > >  }
> > >
> > > +int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
> > > +                               u64 expected_size) {
> > > +       struct amdgpu_bo_va_mapping *va_map;
> > > +       u64 user_addr;
> > > +       u64 size;
> > > +       int r =3D 0;
> > > +
> > > +       user_addr =3D (addr & AMDGPU_GMC_HOLE_MASK) >>
> > AMDGPU_GPU_PAGE_SHIFT;
> > > +       size =3D expected_size >> AMDGPU_GPU_PAGE_SHIFT;
> > > +
> > > +       r =3D amdgpu_bo_reserve(vm->root.bo, false);
> > > +       if (r)
> > > +               return r;
> > > +
> > > +       va_map =3D amdgpu_vm_bo_lookup_mapping(vm, user_addr);
> > > +       if (!va_map) {
> > > +               r =3D -EINVAL;
> > > +               goto out_err;
> > > +       }
> > > +       /* Only validate the userq whether resident in the VM mapping=
 range */
> > > +       if (user_addr >=3D va_map->start  &&
> > > +           va_map->last - user_addr + 1 >=3D size) {
> > > +               amdgpu_bo_unreserve(vm->root.bo);
> > > +               return 0;
> > > +       }
> > > +
> > > +out_err:
> > > +       amdgpu_bo_unreserve(vm->root.bo);
> > > +       return r;
> > > +}
> > > +
> > >  static int
> > >  amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
> > >                           struct amdgpu_usermode_queue *queue) @@
> > > -399,6 +431,15 @@ amdgpu_userq_create(struct drm_file *filp, union
> > drm_amdgpu_userq *args)
> > >                 r =3D -ENOMEM;
> > >                 goto unlock;
> > >         }
> > > +
> > > +       /* Validate the userq virtual address.*/
> > > +       if (amdgpu_userq_input_va_validate(&fpriv->vm, args->in.queue=
_va, args-
> > >in.queue_size) ||
> > > +           amdgpu_userq_input_va_validate(&fpriv->vm, args->in.rptr_=
va,
> > PAGE_SIZE) ||
> > > +           amdgpu_userq_input_va_validate(&fpriv->vm,
> > > + args->in.wptr_va, PAGE_SIZE)) {
> >
> > I think the sizes here should be AMDGPU_GPU_PAGE_SIZE rather than
> > PAGE_SIZE
> Yes, even the two value are equal but that more sense for validating the =
GPU VA.

Well, they don't have to be.  E.g., if you compile the kernel with a
different page size they won't be equal.  Plus some other platforms
default to a non-4K page.

Alex

>
> > > +               queue->state =3D AMDGPU_USERQ_STATE_INVALID_ARG;
> > > +               kfree(queue);
> > > +               goto unlock;
> > > +       }
> > >         queue->doorbell_handle =3D args->in.doorbell_handle;
> > >         queue->queue_type =3D args->in.ip_type;
> > >         queue->vm =3D &fpriv->vm;
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> > > index 694f850d102e..0eb2a9c2e340 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> > > @@ -135,4 +135,6 @@ int
> > > amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *a=
dev,
> > int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device=
 *adev,
> > >                                                    u32 idx);
> > >
> > > +int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
> > > +                       u64 expected_size);
> > >  #endif
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > > b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > > index 1457fb49a794..6e29e85bbf9f 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > > @@ -206,6 +206,7 @@ static int mes_userq_mqd_create(struct
> > amdgpu_userq_mgr *uq_mgr,
> > >         struct amdgpu_mqd *mqd_hw_default =3D &adev->mqds[queue->queu=
e_type];
> > >         struct drm_amdgpu_userq_in *mqd_user =3D args_in;
> > >         struct amdgpu_mqd_prop *userq_props;
> > > +       struct amdgpu_gfx_shadow_info shadow_info;
> > >         int r;
> > >
> > >         /* Structure to initialize MQD for userqueue using generic MQ=
D
> > > init function */ @@ -231,6 +232,8 @@ static int mes_userq_mqd_create(=
struct
> > amdgpu_userq_mgr *uq_mgr,
> > >         userq_props->doorbell_index =3D queue->doorbell_index;
> > >         userq_props->fence_address =3D queue->fence_drv->gpu_addr;
> > >
> > > +       if (adev->gfx.funcs->get_gfx_shadow_info)
> > > +               adev->gfx.funcs->get_gfx_shadow_info(adev,
> > > + &shadow_info, true);
> > >         if (queue->queue_type =3D=3D AMDGPU_HW_IP_COMPUTE) {
> > >                 struct drm_amdgpu_userq_mqd_compute_gfx11
> > > *compute_mqd;
> > >
> > > @@ -247,6 +250,12 @@ static int mes_userq_mqd_create(struct
> > amdgpu_userq_mgr *uq_mgr,
> > >                         goto free_mqd;
> > >                 }
> > >
> > > +               if (amdgpu_userq_input_va_validate(queue->vm, compute=
_mqd-
> > >eop_va,
> > > +                                       max_t(u32, PAGE_SIZE,
> > AMDGPU_GPU_PAGE_SIZE))) {
> > > +                       queue->state =3D AMDGPU_USERQ_STATE_INVALID_A=
RG;
> >
> > Rather than setting the queue->state, just return -EINVAL.  We shouldn'=
t create the
> > queue in the first place if the addresses are invalid.
> Note.
>
> > > +                       goto free_mqd;
> > > +               }
> > > +
> > >                 userq_props->eop_gpu_addr =3D compute_mqd->eop_va;
> > >                 userq_props->hqd_pipe_priority =3D
> > AMDGPU_GFX_PIPE_PRIO_NORMAL;
> > >                 userq_props->hqd_queue_priority =3D
> > > AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM;
> > > @@ -274,6 +283,13 @@ static int mes_userq_mqd_create(struct
> > amdgpu_userq_mgr *uq_mgr,
> > >                 userq_props->csa_addr =3D mqd_gfx_v11->csa_va;
> > >                 userq_props->tmz_queue =3D
> > >                         mqd_user->flags &
> > > AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
> > > +
> > > +               if (amdgpu_userq_input_va_validate(queue->vm, mqd_gfx=
_v11-
> > >shadow_va,
> > > +                                       shadow_info.shadow_size)) {
> > > +                       queue->state =3D AMDGPU_USERQ_STATE_INVALID_A=
RG;
> >
> > Same comment here.
> >
> > > +                       goto free_mqd;
> > > +               }
> > > +
> > >                 kfree(mqd_gfx_v11);
> > >         } else if (queue->queue_type =3D=3D AMDGPU_HW_IP_DMA) {
> > >                 struct drm_amdgpu_userq_mqd_sdma_gfx11 *mqd_sdma_v11;
> > > @@ -291,6 +307,12 @@ static int mes_userq_mqd_create(struct
> > amdgpu_userq_mgr *uq_mgr,
> > >                         goto free_mqd;
> > >                 }
> > >
> > > +               if (amdgpu_userq_input_va_validate(queue->vm, mqd_sdm=
a_v11-
> > >csa_va,
> > > +                                       shadow_info.csa_size)) {
> > > +                       queue->state =3D AMDGPU_USERQ_STATE_INVALID_A=
RG;
> >
> > and here.
> >
> > Alex
> >
> > > +                       goto free_mqd;
> > > +               }
> > > +
> > >                 userq_props->csa_addr =3D mqd_sdma_v11->csa_va;
> > >                 kfree(mqd_sdma_v11);
> > >         }
> > > --
> > > 2.34.1
> > >
