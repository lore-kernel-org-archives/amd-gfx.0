Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78901CA1012
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Sep 2025 22:19:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB8A810E2AE;
	Wed,  3 Sep 2025 22:19:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WTf6MFAI";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1152B10E2AE
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Sep 2025 22:19:22 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-24498e93b8fso774345ad.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 Sep 2025 15:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756937961; x=1757542761; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t5SVPmLbIgozY8xhmuqdI6tTna+NZ9OGD/riNeElhtc=;
 b=WTf6MFAI9hu9BXjvu+mUL2Tdcvs+80qI9pIFqHduQXQXzimq88ULY/HIHPgtLjq7dJ
 6NpzxFEMZPgk0PqtvwozATJdIGz2ldqESyuFYzN+e6yaMF7KpQxSQoRJCmml5qB236sg
 zcn33Pw4BBdqQnvJWRK/FhnKFS0Ait982aYYgzfGTOSYDxg0u4aPu7401x7TsgWrymmh
 Vc1CsgI0wlrSxQen9sIVFLOs5985Y+wTIq5gbBvQbpotg3rg11MkmILlBxWWZy6NGJNA
 cPNtl/har+BGzpHm9hAZHmsF67MnRGzaE9yc87gXZnvcj2ghyDOPsdI5LfctmLdyYoiO
 BqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756937961; x=1757542761;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t5SVPmLbIgozY8xhmuqdI6tTna+NZ9OGD/riNeElhtc=;
 b=FgsEGDTgdmBS1IOm5qJBywhw6fgBJV+BPFM0mX20Ru/02DRJGmTgLLDuei6miDXU8g
 FsGRNnSmJ3M6pxJgMt9LzMOMcywq0bavBP/HVCcPUea8bkdvWpwota6K9avtLRnKpo0t
 hgJFKOgfK+kMTDFlYbheKGj/sp2bL8dO3+VIlHa0FlvqFY+9HTHlR4aOPZzwD8YPG3bp
 U2TryGFOxUReIx2qHfUpACqGx8uMtuCQTIUw9gPIsqUNUtSI5VDZTQi3EOPxy2jVOBs9
 OVmyg2AR3X3PnPE1caWk/oXEvUyA0t7FiiBT+wHXXDKobIxE32lXAlCrEyn9s/xVlI4u
 rCng==
X-Gm-Message-State: AOJu0YyhX3tdHUBNOa6RAP0qbdNZ7E3P+5vQeNXVNi63QQxFy9EBFOeO
 h7HbP/URhg0ZzE9BSv6Xqx+ZMEUZ/ip2YvZ5s7Tr7n63QdpWoUdNjRmd7N8SRfTXWpkP6o2qESf
 hP6p9vSPM2V0ttA+jr2BxsNCqBql+kus=
X-Gm-Gg: ASbGnctB3uhLUjDQeWIGcv1HsDL4Tr7/+gxD7ISNJH61z7JMCWJChxfYGdYTWRzQ5iC
 RJommAnvH8gb7+7ON670wyHP9yh2R/K5AeMVJ9WFNwXVReRGNpY2YBhg4B8B5GTt6o2NSaor6nA
 MoA2jiYOC42ND0YRn1Oh1bASUwpoRbvNBbwtR2l3khV7A+/R9hDqpn6Mu6EDJYdjiG5ttUKSfMu
 Rmg2Gs=
X-Google-Smtp-Source: AGHT+IFHZ7UgYr4jgDPELBzkkr020IpG756AE2crPNbOXaUKhWkmN0gMOkk8ZLf6z+94xAXOKQcTLOlLwmF2XTIh99Q=
X-Received: by 2002:a17:902:c409:b0:248:79d4:939f with SMTP id
 d9443c01a7336-2490fc97225mr137759565ad.7.1756937961215; Wed, 03 Sep 2025
 15:19:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250826074646.1775241-1-Prike.Liang@amd.com>
 <20250826074646.1775241-8-Prike.Liang@amd.com>
 <CADnq5_PDwsgY-sjkeCQ=eiiCF4Z4XXcGN3Q5d5D05obr6BXeZQ@mail.gmail.com>
 <PH7PR12MB600043FCEDC15FB294FB7966FB38A@PH7PR12MB6000.namprd12.prod.outlook.com>
 <CADnq5_P0so23DcH3+JO70RYxDDGWYdofeQJkrzCWy+PHOUyMPw@mail.gmail.com>
 <DS7PR12MB6005421EF6E18DA1BDD4B29AFB07A@DS7PR12MB6005.namprd12.prod.outlook.com>
 <CADnq5_M5MGLnzYQzTikfKiqWKZpnA03dgawd2Y54tHW57N0u+A@mail.gmail.com>
 <DS7PR12MB600594D4B760FE58BC07B744FB01A@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB600594D4B760FE58BC07B744FB01A@DS7PR12MB6005.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 3 Sep 2025 18:19:09 -0400
X-Gm-Features: Ac12FXyL8f4HPUJyvdoJrwUfcUnoTTN1yCyJGzvKGpLXLBYxURZ0EuHirVnEnCE
Message-ID: <CADnq5_M9MPuat=Rivq27A-4TEm9i5zDi76Wj4avUJUo2PW+8OA@mail.gmail.com>
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

On Wed, Sep 3, 2025 at 8:56=E2=80=AFAM Liang, Prike <Prike.Liang@amd.com> w=
rote:
>
> [Public]
>
> Regards,
>       Prike
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> > Deucher
> > Sent: Tuesday, September 2, 2025 11:46 PM
> > To: Liang, Prike <Prike.Liang@amd.com>
> > Cc: Koenig, Christian <Christian.Koenig@amd.com>; amd-
> > gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.co=
m>
> > Subject: Re: [PATCH v9 08/14] drm/amdgpu: add userq object va track hel=
pers
> >
> > On Mon, Sep 1, 2025 at 5:13=E2=80=AFAM Liang, Prike <Prike.Liang@amd.co=
m> wrote:
> > >
> > > [Public]
> > >
> > >
> > >
> > > Regards,
> > >       Prike
> > >
> > > > -----Original Message-----
> > > > From: Alex Deucher <alexdeucher@gmail.com>
> > > > Sent: Thursday, August 28, 2025 6:13 AM
> > > > To: Liang, Prike <Prike.Liang@amd.com>; Koenig, Christian
> > > > <Christian.Koenig@amd.com>
> > > > Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> > > > <Alexander.Deucher@amd.com>
> > > > Subject: Re: [PATCH v9 08/14] drm/amdgpu: add userq object va track
> > > > helpers
> > > >
> > > > On Wed, Aug 27, 2025 at 8:07=E2=80=AFAM Liang, Prike <Prike.Liang@a=
md.com> wrote:
> > > > >
> > > > > [Public]
> > > > >
> > > > > Regards,
> > > > >       Prike
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Alex Deucher <alexdeucher@gmail.com>
> > > > > > Sent: Tuesday, August 26, 2025 11:22 PM
> > > > > > To: Liang, Prike <Prike.Liang@amd.com>
> > > > > > Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> > > > > > <Alexander.Deucher@amd.com>; Koenig, Christian
> > > > > > <Christian.Koenig@amd.com>
> > > > > > Subject: Re: [PATCH v9 08/14] drm/amdgpu: add userq object va
> > > > > > track helpers
> > > > > >
> > > > > > On Tue, Aug 26, 2025 at 3:47=E2=80=AFAM Prike Liang <Prike.Lian=
g@amd.com>
> > wrote:
> > > > > > >
> > > > > > > Add the userq object virtual address get(),mapped() and put()
> > > > > > > helpers for tracking the userq obj va address usage.
> > > > > > >
> > > > > > > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > > > > > > ---
> > > > > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 172
> > > > > > > ++++++++++++++++++++-
> > > > > > > ++++++++++++++++++++drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> > > > > > > ++++++++++++++++++++|  14
> > > > > > ++
> > > > > > >  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |   4 +
> > > > > > >  3 files changed, 189 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > > > > > index 0aeb7a96ccbf..562d12f9d0d2 100644
> > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > > > > > @@ -76,6 +76,174 @@ int amdgpu_userq_input_va_validate(struct
> > > > > > > amdgpu_vm
> > > > > > *vm, u64 addr,
> > > > > > >         return r;
> > > > > > >  }
> > > > > > >
> > > > > > > +int amdgpu_userq_buffer_va_get(struct amdgpu_vm *vm, u64 add=
r) {
> > > > > > > +       struct amdgpu_bo_va_mapping *mapping;
> > > > > > > +       u64 user_addr;
> > > > > > > +       int r;
> > > > > > > +
> > > > > > > +       user_addr =3D (addr & AMDGPU_GMC_HOLE_MASK) >>
> > > > > > AMDGPU_GPU_PAGE_SHIFT;
> > > > > > > +       r =3D amdgpu_bo_reserve(vm->root.bo, false);
> > > > > > > +       if (r)
> > > > > > > +               return r;
> > > > > > > +
> > > > > > > +       mapping =3D amdgpu_vm_bo_lookup_mapping(vm, user_addr=
);
> > > > > > > +       if (!mapping)
> > > > > > > +               goto out_err;
> > > > > > > +
> > > > > > > +       /*
> > > > > > > +        * Need to unify the following userq va reference.
> > > > > > > +        *  mqd  bo
> > > > > > > +        *  rptr bo
> > > > > > > +        *  wptr bo
> > > > > > > +        *  eop  bo
> > > > > > > +        *  shadow bo
> > > > > > > +        *  csa bo
> > > > > > > +        */
> > > > > > > +       /*amdgpu_bo_ref(mapping->bo_va->base.bo);*/
> > > > > > > +       mapping->bo_va->queue_refcount++;
> > > > > > > +
> > > > > > > +       amdgpu_bo_unreserve(vm->root.bo);
> > > > > > > +       return 0;
> > > > > > > +
> > > > > > > +out_err:
> > > > > > > +       amdgpu_bo_unreserve(vm->root.bo);
> > > > > > > +       return -EINVAL;
> > > > > > > +}
> > > > > > > +
> > > > > > > +bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64
> > addr) {
> > > > > > > +       struct amdgpu_bo_va_mapping *mapping;
> > > > > > > +       u64 user_addr;
> > > > > > > +       bool r;
> > > > > > > +
> > > > > > > +       user_addr =3D (addr & AMDGPU_GMC_HOLE_MASK) >>
> > > > > > > + AMDGPU_GPU_PAGE_SHIFT;
> > > > > > > +
> > > > > > > +       if (amdgpu_bo_reserve(vm->root.bo, false))
> > > > > > > +               return false;
> > > > > > > +
> > > > > > > +       mapping =3D amdgpu_vm_bo_lookup_mapping(vm, user_addr=
);
> > > > > > > +       if (!IS_ERR_OR_NULL(mapping) && mapping->bo_va-
> > > > >queue_refcount > 0)
> > > > > > > +               r =3D true;
> > > > > > > +       else
> > > > > > > +               r =3D false;
> > > > > > > +       amdgpu_bo_unreserve(vm->root.bo);
> > > > > > > +
> > > > > > > +       return r;
> > > > > > > +}
> > > > > > > +
> > > > > > > +bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_vm *vm,
> > > > > > > +                       struct amdgpu_usermode_queue *queue) =
{
> > > > > > > +
> > > > > > > +       switch (queue->queue_type) {
> > > > > > > +       case AMDGPU_HW_IP_GFX:
> > > > > > > +               if (amdgpu_userq_buffer_va_mapped(vm, queue->=
queue_va) ||
> > > > > > > +                   amdgpu_userq_buffer_va_mapped(vm, queue->=
rptr_va) ||
> > > > > > > +                   amdgpu_userq_buffer_va_mapped(vm, queue->=
wptr_va) ||
> > > > > > > +                   amdgpu_userq_buffer_va_mapped(vm, queue->=
shadow_va)
> > ||
> > > > > > > +                   amdgpu_userq_buffer_va_mapped(vm, queue->=
csa_va))
> > > > > > > +                       return true;
> > > > > > > +               break;
> > > > > > > +       case AMDGPU_HW_IP_COMPUTE:
> > > > > > > +               if (amdgpu_userq_buffer_va_mapped(vm, queue->=
queue_va) ||
> > > > > > > +                   amdgpu_userq_buffer_va_mapped(vm, queue->=
rptr_va) ||
> > > > > > > +                   amdgpu_userq_buffer_va_mapped(vm, queue->=
wptr_va) ||
> > > > > > > +                   amdgpu_userq_buffer_va_mapped(vm, queue->=
eop_va))
> > > > > > > +                       return true;
> > > > > > > +               break;
> > > > > > > +       case AMDGPU_HW_IP_DMA:
> > > > > > > +               if (amdgpu_userq_buffer_va_mapped(vm, queue->=
queue_va) ||
> > > > > > > +                   amdgpu_userq_buffer_va_mapped(vm, queue->=
rptr_va) ||
> > > > > > > +                   amdgpu_userq_buffer_va_mapped(vm, queue->=
wptr_va) ||
> > > > > > > +                   amdgpu_userq_buffer_va_mapped(vm, queue->=
csa_va))
> > > > > > > +                       return true;
> > > > > > > +               break;
> > > > > > > +       default:
> > > > > > > +               break;
> > > > > > > +       }
> > > > > > > +
> > > > > > > +       return false;
> > > > > > > +}
> > > > > > > +
> > > > > > > +int amdgpu_userq_buffer_va_put(struct amdgpu_vm *vm, u64 add=
r) {
> > > > > > > +       struct amdgpu_bo_va_mapping *mapping;
> > > > > > > +       u64 user_addr;
> > > > > > > +       int r;
> > > > > > > +
> > > > > > > +       user_addr =3D (addr & AMDGPU_GMC_HOLE_MASK) >>
> > > > > > AMDGPU_GPU_PAGE_SHIFT;
> > > > > > > +       r =3D amdgpu_bo_reserve(vm->root.bo, false);
> > > > > > > +       if (r)
> > > > > > > +               return r;
> > > > > > > +
> > > > > > > +       mapping =3D amdgpu_vm_bo_lookup_mapping(vm, user_addr=
);
> > > > > > > +       if (!mapping)
> > > > > > > +               goto out_err;
> > > > > > > +       /*
> > > > > > > +        * TODO: It requires figuring out the root cause of u=
serq va mapping
> > > > > > > +        * reference imbalance issue.
> > > > > > > +        */
> > > > > > > +       /*amdgpu_bo_unref(&mapping->bo_va->base.bo);*/
> > > > > > > +       mapping->bo_va->queue_refcount--;
> > > > > > > +
> > > > > > > +       amdgpu_bo_unreserve(vm->root.bo);
> > > > > > > +       return 0;
> > > > > > > +
> > > > > > > +out_err:
> > > > > > > +       amdgpu_bo_unreserve(vm->root.bo);
> > > > > > > +       return -EINVAL;
> > > > > > > +}
> > > > > > > +
> > > > > > > +static void amdgpu_userq_buffer_vas_get(struct amdgpu_vm *vm=
,
> > > > > > > +                       struct amdgpu_usermode_queue *queue) =
{
> > > > > > > +
> > > > > > > +
> > > > > > > +       amdgpu_userq_buffer_va_get(vm, queue->queue_va);
> > > > > > > +       amdgpu_userq_buffer_va_get(vm, queue->rptr_va);
> > > > > > > +       amdgpu_userq_buffer_va_get(vm, queue->wptr_va);
> > > > > > > +
> > > > > > > +       switch (queue->queue_type) {
> > > > > > > +       case AMDGPU_HW_IP_GFX:
> > > > > > > +               amdgpu_userq_buffer_va_get(vm, queue->shadow_=
va);
> > > > > > > +               amdgpu_userq_buffer_va_get(vm, queue->csa_va)=
;
> > > > > > > +               break;
> > > > > > > +       case AMDGPU_HW_IP_COMPUTE:
> > > > > > > +               amdgpu_userq_buffer_va_get(vm, queue->eop_va)=
;
> > > > > > > +               break;
> > > > > > > +       case AMDGPU_HW_IP_DMA:
> > > > > > > +               amdgpu_userq_buffer_va_get(vm, queue->csa_va)=
;
> > > > > > > +               break;
> > > > > > > +       default:
> > > > > > > +               break;
> > > > > > > +       }
> > > > > > > +}
> > > > > > > +
> > > > > > > +int amdgpu_userq_buffer_vas_put(struct amdgpu_vm *vm,
> > > > > > > +                       struct amdgpu_usermode_queue *queue) =
{
> > > > > > > +       amdgpu_userq_buffer_va_put(vm, queue->queue_va);
> > > > > > > +       amdgpu_userq_buffer_va_put(vm, queue->rptr_va);
> > > > > > > +       amdgpu_userq_buffer_va_put(vm, queue->wptr_va);
> > > > > > > +
> > > > > > > +       switch (queue->queue_type) {
> > > > > > > +       case AMDGPU_HW_IP_GFX:
> > > > > > > +               amdgpu_userq_buffer_va_put(vm, queue->shadow_=
va);
> > > > > > > +               amdgpu_userq_buffer_va_put(vm, queue->csa_va)=
;
> > > > > > > +               break;
> > > > > > > +       case AMDGPU_HW_IP_COMPUTE:
> > > > > > > +               amdgpu_userq_buffer_va_put(vm, queue->eop_va)=
;
> > > > > > > +               break;
> > > > > > > +       case AMDGPU_HW_IP_DMA:
> > > > > > > +               amdgpu_userq_buffer_va_put(vm, queue->csa_va)=
;
> > > > > > > +               break;
> > > > > > > +       default:
> > > > > > > +               break;
> > > > > > > +       }
> > > > > > > +       return 0;
> > > > > > > +}
> > > > > > > +
> > > > > > >  static int
> > > > > > >  amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
> > > > > > >                           struct amdgpu_usermode_queue *queue=
)
> > > > > > > @@
> > > > > > > -445,6 +613,9 @@ amdgpu_userq_create(struct drm_file *filp,
> > > > > > > union
> > > > > > drm_amdgpu_userq *args)
> > > > > > >         queue->vm =3D &fpriv->vm;
> > > > > > >         queue->priority =3D priority;
> > > > > > >         queue->generation =3D amdgpu_vm_generation(adev,
> > > > > > > &fpriv->vm);
> > > > > > > +       queue->queue_va =3D args->in.queue_va;
> > > > > > > +       queue->rptr_va =3D args->in.rptr_va;
> > > > > > > +       queue->wptr_va =3D args->in.wptr_va;
> > > > > > >
> > > > > > >         db_info.queue_type =3D queue->queue_type;
> > > > > > >         db_info.doorbell_handle =3D queue->doorbell_handle; @=
@
> > > > > > > -475,7
> > > > > > > +646,6 @@ amdgpu_userq_create(struct drm_file *filp, union
> > > > > > > +drm_amdgpu_userq
> > > > > > *args)
> > > > > > >                 goto unlock;
> > > > > > >         }
> > > > > > >
> > > > > > > -
> > > > > > >         qid =3D idr_alloc(&uq_mgr->userq_idr, queue, 1,
> > > > > > AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
> > > > > > >         if (qid < 0) {
> > > > > > >                 drm_file_err(uq_mgr->file, "Failed to allocat=
e
> > > > > > > a queue id\n"); diff --git
> > > > > > > a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> > > > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> > > > > > > index 0eb2a9c2e340..30067f80eadf 100644
> > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> > > > > > > @@ -54,6 +54,13 @@ struct amdgpu_usermode_queue {
> > > > > > >         enum amdgpu_userq_state state;
> > > > > > >         uint64_t                doorbell_handle;
> > > > > > >         uint64_t                doorbell_index;
> > > > > > > +       uint64_t                queue_va;
> > > > > > > +       uint64_t                rptr_va;
> > > > > > > +       uint64_t                wptr_va;
> > > > > > > +       uint64_t                eop_va;
> > > > > > > +       uint64_t                shadow_va;
> > > > > > > +       uint64_t                csa_va;
> > > > > >
> > > > > > Just store a list of critical virtual addresses.  Otherwise we
> > > > > > are going to have a ton of IP specific things in here.  For eac=
h
> > > > > > critical address, just
> > > > push the address on the list.
> > > > > > Then in the VM unmap code, just walk the list for each queue an=
d
> > > > > > if the user tries to umap a critical buffer, preempt the queue =
and set an error
> > on it.
> > > > > Is enough to track the queue_va for validating the userq VA unmap=
 operation?
> > > > > I proposed a similar solution for retrieving the userq by walking
> > > > > over VA list, but
> > > > Christian rejected this for the overhead cause.
> > > > >
> > > >
> > > > I think queue creation and unmap are the only cases that we care
> > > > about.  We don't want to create a queue with an invalid addresses
> > > > and we don't want to unmap a virtual address that is critical for t=
he queue before
> > the queue is destroyed.
> > > >
> > > > I think all we need to do in the unmap case is to walk the critical
> > > > VA lists for each user queue associated with the VM and check it.
> > > > @Christian Koenig did you have something else in mind?
> > >
> > >
> > > Limiting tracking to a subset of user-queue VAs would lower overhead.=
 Would
> > tracking only queue_va, rptr_va, and wptr_va be sufficient to validate =
user-queue VA
> > unmaps?
> >
> > We should track all of the critical buffer VAs.
> >
> > > However, partial tracking risks missing invalid unmap events on untra=
cked VAs.
> > > Although patch #14 can detect invalid user-queue VA unmaps by checkin=
g bo_va-
> > >queue_refcount, but if we only look up a partial VA list, we may still=
 fail to identify
> > the specific queue whose VA was improperly unmapped, and therefore we c=
annot
> > preempt and mark that queue as invalid. Thought?
> >
> > We can store the critical buffers list in the struct amdgpu_usermode_qu=
eue.  Then
> > walk the lists when we unmap the VA:
> >
> > idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
> >     if (amdgpu_userq_critical_va(queue, va_address, va_size)) {
> >           preempt(queue);
> >           queue->status =3D AMDGPU_USERQ_STATE_INVALID_VA;
> >     }
> > }
> >
> > Alex
>
> Thank you for the proposal. If there are no objections, I will update the=
 userq retrieval method to walk the VA list instead of checking the mapping=
 range.

Sure.  @Christian Koenig any concerns on your end?

Thanks,

Alex

>
> > >
> > >
> > > Thanks,
> > > Prike
> > >
> > > > Thanks,
> > > >
> > > > Alex
> > > >
> > > > > > Alex
> > > > > >
> > > > > > > +
> > > > > > >         uint64_t                flags;
> > > > > > >         struct amdgpu_mqd_prop  *userq_prop;
> > > > > > >         struct amdgpu_userq_mgr *userq_mgr; @@ -137,4 +144,11
> > > > > > > @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct
> > > > > > > amdgpu_device *adev,
> > > > > > >
> > > > > > >  int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64=
 addr,
> > > > > > >                         u64 expected_size);
> > > > > > > +int amdgpu_userq_buffer_va_get(struct amdgpu_vm *vm, u64
> > > > > > > +addr); bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm
> > > > > > > +*vm, u64 addr); bool amdgpu_userq_buffer_vas_mapped(struct
> > amdgpu_vm *vm,
> > > > > > > +                       struct amdgpu_usermode_queue *queue);
> > > > > > > +int amdgpu_userq_buffer_va_put(struct amdgpu_vm *vm, u64
> > > > > > > +addr); int amdgpu_userq_buffer_vas_put(struct amdgpu_vm *vm,
> > > > > > > +                       struct amdgpu_usermode_queue *queue);
> > > > > > >  #endif
> > > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > > > > > > b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > > > > > > index 6e29e85bbf9f..42d6cd90be59 100644
> > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > > > > > > @@ -262,6 +262,7 @@ static int mes_userq_mqd_create(struct
> > > > > > amdgpu_userq_mgr *uq_mgr,
> > > > > > >                 userq_props->hqd_active =3D false;
> > > > > > >                 userq_props->tmz_queue =3D
> > > > > > >                         mqd_user->flags &
> > > > > > > AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
> > > > > > > +               queue->eop_va =3D compute_mqd->eop_va;
> > > > > > >                 kfree(compute_mqd);
> > > > > > >         } else if (queue->queue_type =3D=3D AMDGPU_HW_IP_GFX)=
 {
> > > > > > >                 struct drm_amdgpu_userq_mqd_gfx11
> > > > > > > *mqd_gfx_v11; @@
> > > > > > > -283,6 +284,8 @@ static int mes_userq_mqd_create(struct
> > > > > > > amdgpu_userq_mgr
> > > > > > *uq_mgr,
> > > > > > >                 userq_props->csa_addr =3D mqd_gfx_v11->csa_va=
;
> > > > > > >                 userq_props->tmz_queue =3D
> > > > > > >                         mqd_user->flags &
> > > > > > > AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
> > > > > > > +               queue->shadow_va =3D mqd_gfx_v11->shadow_va;
> > > > > > > +               queue->csa_va =3D mqd_gfx_v11->csa_va;
> > > > > > >
> > > > > > >                 if (amdgpu_userq_input_va_validate(queue->vm,
> > > > > > >mqd_gfx_v11- shadow_va,
> > > > > > >
> > > > > > >shadow_info.shadow_size)) { @@
> > > > > > > -314,6 +317,7 @@ static int mes_userq_mqd_create(struct
> > > > > > >amdgpu_userq_mgr
> > > > > > *uq_mgr,
> > > > > > >                 }
> > > > > > >
> > > > > > >                 userq_props->csa_addr =3D mqd_sdma_v11->csa_v=
a;
> > > > > > > +               queue->csa_va =3D mqd_sdma_v11->csa_va;
> > > > > > >                 kfree(mqd_sdma_v11);
> > > > > > >         }
> > > > > > >
> > > > > > > --
> > > > > > > 2.34.1
> > > > > > >
