Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B629CD98E4
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 13:04:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FD1F89F71;
	Wed, 17 Jun 2026 13:04:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G3p2M0cJ";
	dkim-atps=neutral
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 045B289F71
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 13:04:27 +0000 (UTC)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-304dc707c7eso505334eec.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 06:04:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781701466; cv=none;
 d=google.com; s=arc-20240605;
 b=ghPNWkkeorcdacPbIeLgp22QfoA7imku+BEI3Abvehmmtsu0aAIjqmd/zN9lzj3Rbn
 iftdaFjskgdgR7zEKuwlPLdjJc7nizXDUEJcRl/RCo+rFxi8HCE4oEPgTa5LXXawMC7S
 EeKY5h2IFFpXRs2oCvNaHvcFyb2maFwnpnBdEbYLSXBreZIW/bE7ayUPJa4lP21s+2Xs
 bR98GP9xR+RpFEO/rQv5f4jaHZyvu+wL+VdSFaESafpH5yYgDgpawlCOX6rRjHuDVCAb
 xORAT+nbpdeU/0zGe3FkJA430kknkuwBu6f6t5wKRl/ZHQTHe7TnvhNyXalmBaKPrZ4y
 LpJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TotNHTuxOjLbpMKUWS1UFqizeyqAzc6zfw0BJnOrMuo=;
 fh=Zb7Lb0ioCflwJOHHJ+iz/Ov4miE4fRJWfMbyNqjaLdg=;
 b=YiBHexnE7Sk5mBNyNkm8HJbtyc5/MqpcI/nnDRBZ8NOdn6u4ReBSKI9CvnLpmuVctY
 Rlxb0Tv7LkkOaqsS+QxxIirjykDb2oUHpbtLo3v9p6hgRbhU1stwCQnZorS6RDL14e+5
 y1Vp5C5i//0tmynAfhVk1x9w7ms919oV4U4/5BdaHFqSKs1XW+paR4K0tvr5F0YWvtMb
 IjPFnOyEsT18wC9XffT3HVLjKpizfSZ2V+Y+mn+1QHmJyRK+M42MnfLXGLAUjktOw5k6
 gHN8dGprZibhV4W1/cm0vx+wQ+VglwfPHadVw0M1emk1bo0l577iUUGo2uOGMI9DCo8b
 D/cw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781701466; x=1782306266; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TotNHTuxOjLbpMKUWS1UFqizeyqAzc6zfw0BJnOrMuo=;
 b=G3p2M0cJW7dSJPhwmJlfiZfBhFXJKSkXOUBrrj8blnCYKe7xN/XB7JszxiMY1vqosd
 OC+46tErAg05aVfRVjg1WLeyrf47RLMk0XJW7F1Jib7Uhl+0Lasc7+12b2Ckm9B/7nva
 PqtxXgyuFU1ZYagESOtd5lK3AYsNC5+eT4iUHzKISFVuS++tJ5XMyyrOJsZbLhbYHWt+
 WpZsgSorTt6wndnDLaueB/k5EqqwH298kCtAMEhekS4HYyTYSxGBau+kgogKSOYQ7d7P
 sYzPls8KkjGo8bsfbaTR+7JrfeAzGbSpkXwEUhTdOYCohs4rd/ZoFc8e/T13zn+Seobt
 8KVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781701466; x=1782306266;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TotNHTuxOjLbpMKUWS1UFqizeyqAzc6zfw0BJnOrMuo=;
 b=ncGQRXTt2KYKgv7BTjHq0gvqNGYoCXA80X4tqSt3rxPL1ZUqLavl5DPkbEf3q4BLOu
 iQ64CynN/J3tD+07DBepbOX1wMweOvUJaRFTpfwQmDk0DjRbr8Aq9xppf6LwEBJO88TY
 Pu8GyDsU3Gh8zEYK/CnlnUib5lDpStFWzPhOJR1ieFbNPxersJ40w6hIZWFsNeOXad8I
 EW5zEuKZ1Aby4jkiFlcHkvQF1DG/O6Fy54JOtou9dXReRsYXdwfhB3ru/xJ8b+IOcnr8
 cXmV6E15DNRd3UEx5zkEeh5ef9PWlSMyRAtb69wAAsEgM4Cu6KWv8PmHqgM0/WdkqKxu
 xKUw==
X-Gm-Message-State: AOJu0YwypKsQ0nRGQYSHm8nyjI0Df6/Dnb0ZgCvkvLQ6I2Q6CJX07uHR
 qC7mlxmGRGkyL+MD+Dw0650Cx/7nzRvU1ho1/uAutbYlhN57lQHQsVCRzjpJ1cFc2Hib63CAt2p
 kypTw54KI1pVTuHPYnJRjmKGtZ1t1XLc=
X-Gm-Gg: Acq92OHlsUfTxPQuZXI5isO+dHZC+3nMtlZWUlleA6E37YRWS+PhgKQC7WWlRllQafo
 BkVfguyuEA9vQAB9xQEBeuthtOdWg2i+JJqHYpJ+fIYYRtYlVylb4gqvrveLzmp+3C4XuP3LYMr
 /VNhxk4PnJQauN3B99FjWrg50jjA/aFeHj5o0i2dwz8oVP6xfhyzyriBP+Uh0zM+N264Q5zYRca
 AcKA28Mh7ys8v/Ch551cGVqiC14wsg/gDQTJR85iHF/Hv/joCiurREi9tptjTdS4FxqFNdd1IkZ
 vwYXW+8rDENkY1BSiC4qk2XiJA13OhNOompWrUP6RSnvSSOxAidz+nxCcE0=
X-Received: by 2002:a05:7022:622:b0:137:ec1a:f405 with SMTP id
 a92af1059eb24-1398f56699bmr692733c88.0.1781701465734; Wed, 17 Jun 2026
 06:04:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260611035747.548780-1-Jesse.Zhang@amd.com>
 <CADnq5_OjqsxVGNAn6YkSaZg9WygBCJXoKnQLW=bKQ0a5yfE5yg@mail.gmail.com>
 <DM4PR12MB51522F08CBA830C0C27824AFE3E42@DM4PR12MB5152.namprd12.prod.outlook.com>
 <DM4PR12MB5152666FD62B1EE9B1B3E16BE3E42@DM4PR12MB5152.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5152666FD62B1EE9B1B3E16BE3E42@DM4PR12MB5152.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 17 Jun 2026 09:04:14 -0400
X-Gm-Features: AVVi8Ce1jiw9qUowJSK7nXVMvm01JK7SeF3V7XCkBA2gOYotin1yAvDmowzvzGU
Message-ID: <CADnq5_Mig4uw0GU9RwQpU_3pFNjx54f2ttQHgMCB1AFSGBgQ6Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] drm/amdgpu/userq: add reset helper and identify
 guilty user queue
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
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

On Wed, Jun 17, 2026 at 4:53=E2=80=AFAM Zhang, Jesse(Jie) <Jesse.Zhang@amd.=
com> wrote:
>
> AMD General
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhan=
g,
> > Jesse(Jie)
> > Sent: Wednesday, June 17, 2026 1:52 PM
> > To: Alex Deucher <alexdeucher@gmail.com>
> > Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.co=
m>
> > Subject: RE: [PATCH v2 1/7] drm/amdgpu/userq: add reset helper and iden=
tify guilty
> > user queue
> >
> > AMD General
> >
> > > -----Original Message-----
> > > From: Alex Deucher <alexdeucher@gmail.com>
> > > Sent: Wednesday, June 17, 2026 5:47 AM
> > > To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> > > Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> > > <Alexander.Deucher@amd.com>; Koenig, Christian
> > > <Christian.Koenig@amd.com>
> > > Subject: Re: [PATCH v2 1/7] drm/amdgpu/userq: add reset helper and
> > > identify guilty user queue
> > >
> > > On Thu, Jun 11, 2026 at 12:34=E2=80=AFAM Jesse Zhang <Jesse.Zhang@amd=
.com>
> > wrote:
> > > >
> > > > From: Alex Deucher <alexander.deucher@amd.com>
> > >
> > > Feel free to take over the authorship of this patch.  You've done mos=
t of the work.
> > >
> > > >
> > > > If we get an interrupt for a bad user queue (bad opcode, etc.), add
> > > > a helper to handle the reset for user queues.
> > > >
> > > > v2: squash in fixes
> > > >
> > > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > > Co-developed-by: Jesse Zhang <jesse.zhang@amd.com>
> > > > Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> > > > ---
> > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 40
> > > > +++++++++++++++++++++--  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> > |
> > > > 12 +++++++
> > > >  2 files changed, 49 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > > index de6848b4fd67..231ffb29fe5e 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > > @@ -140,9 +140,14 @@ static void
> > > > amdgpu_userq_hang_detect_work(struct
> > > work_struct *work)
> > > >                                                  AMDGPU_RESET_TYPE_=
PER_QUEUE)) {
> > > >                 int r;
> > > >
> > > > -               if (queue->queue_type =3D=3D AMDGPU_HW_IP_COMPUTE)
> > > > -                       r =3D amdgpu_gfx_reset_mes_compute(adev, NU=
LL, NULL, NULL,
> > > NULL, NULL);
> > > > -               else
> > > > +               if (queue->queue_type =3D=3D AMDGPU_HW_IP_COMPUTE) =
{
> > > > +                       struct amdgpu_usermode_queue *guilty_uq;
> > > > +
> > > > +                       /* IRQ-side WRITE_ONCE(guilty,true) hand-of=
f via xchg */
> > > > +                       guilty_uq =3D xchg(&queue->guilty, false) ?=
 queue : NULL;
> > > > +                       r =3D amdgpu_gfx_reset_mes_compute(adev, NU=
LL, NULL,
> > > > +                                                        guilty_uq,=
 NULL, NULL);
> > > > +               } else
> > > >                         r =3D userq_funcs->reset(queue);
> > > >                 if (r)
> > > >                         gpu_reset =3D true; @@ -671,6 +676,7 @@
> > > > amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *=
args)
> > > >         }
> > > >
> > > >         queue->doorbell_index =3D index;
> > > > +       queue->doorbell_offset =3D (u32)args->in.doorbell_offset;
> > > >         r =3D uq_funcs->mqd_create(queue, &args->in);
> > > >         if (r) {
> > > >                 drm_file_err(uq_mgr->file, "Failed to create
> > > > Queue\n"); @@ -1111,6 +1117,34 @@ static void
> > > amdgpu_userq_restore_worker(struct work_struct *work)
> > > >         dma_fence_put(ev_fence);
> > > >  }
> > > >
> > > > +void amdgpu_userq_process_reset_irq(struct amdgpu_device *adev,
> > > > +                                   u32 pasid, u32 doorbell_offset)=
 {
> > > > +       struct xarray *xa =3D &adev->userq_doorbell_xa;
> > > > +       struct amdgpu_usermode_queue *queue;
> > > > +       unsigned long flags, idx;
> > > > +
> > > > +       /*
> > > > +        * CP priv-fault payload is (pasid, src_data[0] & 0x3ff) =
=E2=80=94 the same
> > > > +        * per-process doorbell encoding KFD extracts via
> > > > +        * KFD_CTXID0_DOORBELL_ID_MASK. Find the offending queue by=
 the
> > > > +        * (vm->pasid, doorbell_offset) pair, mark it guilty and fi=
re
> > > > +        * hang_detect immediately (queue_delayed_work() would no-o=
p if the
> > > > +        * work is already armed at submit time).
> > > > +        */
> > > > +       xa_lock_irqsave(xa, flags);
> > > > +       xa_for_each(xa, idx, queue) {
> > > > +               if (queue->vm && queue->vm->pasid =3D=3D pasid &&
> > > > +                   queue->doorbell_offset =3D=3D doorbell_offset) =
{
> > > > +                       WRITE_ONCE(queue->guilty, true);
> > > > +                       mod_delayed_work(adev->reset_domain->wq,
> > > > +                                        &queue->hang_detect_work,
> > > > + 0);
> > >
> > > Why wouldn't we use queue_delayed_work()?  If we get multiple
> > > interrupts we want to queue resets for all of them.  Additionally why
> > > do we need the extra guilty tracking?
> >
> >    Thanks Alex, will fix it , and replace mod_delayed_work with
> > amdgpu_userq_start_hang_detect_work which will call queue_delayed_work.
> >
> > About the guilty tracking:
> > the reason we pass the queue to mes_userq_reset() directly (rather than=
 relying on
> > MES detect) is that for the bad-opcode case we've seen, the queue is cl=
early
> > broken but amdgpu_mes_detect_and_reset_hung_queues() does not report it=
 as
> > hung.
> > So the HW priv-fault IRQ is the only reliable signal for which queue to=
 reset.
> >
> Think more about it. Maybe we can drop the per-queue guilty flag and alwa=
ys pass the queue into the reset path,
> regardless of whether the reset is triggered by a userq fence timeout (th=
e hang-detect work start when the fence is initialized)
> or by a hung queue reported through an error interrupt.

RIght.  We know which queue is guilty from the interrupt vector.  The
work item is hung off the queue so we can just pass that queue in
directly in amdgpu_userq_hang_detect_work().

Alex

> > Jesse
> > >
> > > Alex
> > >
> > > > +                       break;
> > > > +               }
> > > > +       }
> > > > +       xa_unlock_irqrestore(xa, flags); }
> > > > +
> > > >  static int
> > > >  amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)  { diff
> > > > --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> > > > index 9df1b78407f5..a55d57e2c169 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> > > > @@ -53,6 +53,7 @@ struct amdgpu_usermode_queue {
> > > >         enum amdgpu_userq_state state;
> > > >         uint64_t                doorbell_handle;
> > > >         uint64_t                doorbell_index;
> > > > +       u32                     doorbell_offset;
> > > >         uint64_t                flags;
> > > >         struct amdgpu_mqd_prop  *userq_prop;
> > > >         struct amdgpu_userq_mgr *userq_mgr; @@ -86,6 +87,7 @@ struc=
t
> > > > amdgpu_usermode_queue {
> > > >          * Delayed work which runs when userq_fences time out.
> > > >          */
> > > >         struct delayed_work     hang_detect_work;
> > > > +       bool                    guilty;
> > > >         struct kref             refcount;
> > > >
> > > >         union {
> > > > @@ -176,6 +178,16 @@ int amdgpu_userq_post_reset(struct
> > > > amdgpu_device *adev, bool vram_lost);  void
> > > > amdgpu_userq_start_hang_detect_work(struct amdgpu_usermode_queue
> > > > *queue);  void amdgpu_userq_process_fence_irq(struct amdgpu_device
> > > > *adev, u32 doorbell);
> > > >
> > > > +/*
> > > > + * CP packs the per-process doorbell_id of the queue in
> > > > + * CTXID0[9:0] on priv-fault (same encoding KFD uses via
> > > > + * KFD_CTXID0_DOORBELL_ID_MASK)
> > > > + */
> > > > +#define AMDGPU_CTXID0_DOORBELL_ID_MASK 0x3ff
> > > > +
> > > > +void amdgpu_userq_process_reset_irq(struct amdgpu_device *adev,
> > > > +                                   u32 pasid, u32 doorbell_offset)=
;
> > > > +
> > > >  int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
> > > >                                    struct amdgpu_usermode_queue *qu=
eue,
> > > >                                    u64 addr, u64 expected_size, u64
> > > > *va_out);
> > > > --
> > > > 2.49.0
> > > >
