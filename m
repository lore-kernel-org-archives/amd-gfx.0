Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B0EBC282DE
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Mar 2025 01:50:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 918E410E23F;
	Fri, 14 Mar 2025 01:50:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MJviGWpv";
	dkim-atps=neutral
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E6B910E23F
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 01:50:26 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-223f7b10cbbso4303685ad.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Mar 2025 18:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741917026; x=1742521826; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+EC4dm/AMfkG7RjkyNNe2XHwk6e997pQDPBV22DFItA=;
 b=MJviGWpvTyKqrXSRCiVAqNbGLIqnf2Da6GsvtGyCgyYkdfYxuwB/fPTuSMFYIuGyC7
 twR9dYX1Vlo5zqVtHJB2d2rFlwilYvfcn3PYi9IexeYYloZNGiZEI0kL6hyxaZzl5kM6
 FmHbXV/+oqBDJjch7CrqkLbrgJFo3AA7J+fVm3gj+fGE8IGV1XYS0O1aJRGz6XksVwGV
 b9ewvFM6zApKY73AcUIiF/36RkmSmJlaJxUipvM8zTWSbUo5WXLhyo6DGKiqYUDUXIM4
 CayoD5skJAOYf8PUXwl2Wsn9HoXAnphqsXQ6ItyS/ry51YmbGerHrx+gnEORELUST+Zg
 qjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741917026; x=1742521826;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+EC4dm/AMfkG7RjkyNNe2XHwk6e997pQDPBV22DFItA=;
 b=KiFpYJmjPMH74wB0N7KkJVQ96kWLqVA5bk6oRQLGe8bNta8xVxyJyDEJUUlFSRdekO
 aYeEiEaSnYc0L1QtM+e5NK6wtP6gjebhQxksl795k9eAk2iYtfhyxm+OsPKhIrCJOv3L
 7eLXmbET+iyi9owg2tUEvyT2qoam855QCcvs9fuXRHMll0Gu9QyLbnw1+Ooa+8B9sjuh
 HOIGGmPXuj+Q/8QkRH1d+N+i3ExSLGN8n6l8fG36NLCUbyloOoCbDCBzNoBf/CifbMpY
 q7kAsDdkd1Z/2CMXaHe0tekQBJ4HhCksprncJI/BxJdXKCXi71oqARbQ39fa81mzmoET
 JZUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOP9ZDXQWNa0PoOZMk6w8IfNZBC3B8ukUHeU2KrCjDbn9m64yPKk3f97g1EqFxx0/yW9D3/BQg@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwNgiiXeejj9+S2rX6AqZLBKd1c2bxmu/v5+ENkKk+KhEnoVeLu
 CDOWrYF9DCuZsI0L56AzA/vmDXlD+TG/WP27HWdj9gzVGMuQy1fJWzfzL4Rf8Hh3bANOf8lrmHR
 yUq9uPiYsREpfkaJzPiEPkl6IKN+Quw==
X-Gm-Gg: ASbGncs/gykEIo83LZeJwvR1n4O0BeQrQ8d7n0L3ty5frjXQiQObgcxQVpTKmm9Y72U
 25B7DEBqzw8VSA0Oj3o4vAS3s1Kt7wclrwxNIXilQ1utwwXwBaVc0gdR4Pfuv5hdbrycbZBunYA
 IAyYGTU3HPrx8Axi9CsOSDecJ/Qg==
X-Google-Smtp-Source: AGHT+IFVaQxX8RpPIGkv/kuf2HfpSJAL+arQQru3ctqeaBKPFAUU88MLPCZehTf5zdPjq5oC/BTT5nvYmXyF4Y/Z+pc=
X-Received: by 2002:a17:902:f68c:b0:220:cddb:5918 with SMTP id
 d9443c01a7336-225e0afb3aemr3468375ad.9.1741917025295; Thu, 13 Mar 2025
 18:50:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250313144136.1117072-1-alexander.deucher@amd.com>
 <20250313144136.1117072-8-alexander.deucher@amd.com>
 <3wiqqnjoatmdt2j65f6fiu7bxbdyex5zku7ftrlouqqvf5mzwz@niv54l3lkkza>
In-Reply-To: <3wiqqnjoatmdt2j65f6fiu7bxbdyex5zku7ftrlouqqvf5mzwz@niv54l3lkkza>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 13 Mar 2025 21:50:13 -0400
X-Gm-Features: AQ5f1JpPoakPAyx4l2vEXswup7RU7mX4qHK6rGkbHGlvZ1FS1tmNFQFv_dhm-jg
Message-ID: <CADnq5_P72ie6EV-ktcZu7ungRZfenwi6rTvPtSAcBUTgvBkuzA@mail.gmail.com>
Subject: Re: [PATCH 07/11] drm/amdgpu/gfx11: add support for disable_kq
To: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Thu, Mar 13, 2025 at 6:08=E2=80=AFPM Rodrigo Siqueira <siqueira@igalia.c=
om> wrote:
>
> On 03/13, Alex Deucher wrote:
> > Plumb in support for disabling kernel queues in
> > GFX11.  We have to bring up a GFX queue briefly in
> > order to initialize the clear state.  After that
> > we can disable it.
> >
> > v2: use ring counts per Felix' suggestion
> > v3: fix stream fault handler, enable EOP interrupts
> > v4: fix MEC interrupt offset (Sunil)
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 191 ++++++++++++++++++-------
> >  1 file changed, 136 insertions(+), 55 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v11_0.c
> > index 95eefd9a40d28..fde8464cbd3b3 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > @@ -1145,6 +1145,10 @@ static int gfx_v11_0_gfx_ring_init(struct amdgpu=
_device *adev, int ring_id,
> >
> >       ring->ring_obj =3D NULL;
> >       ring->use_doorbell =3D true;
> > +     if (adev->gfx.disable_kq) {
> > +             ring->no_scheduler =3D true;
>
> Hi Alex,
>
> Just a question about this no_scheduler part.
>
> Set no_scheduler to true, means that all of the queues of GFX11 will not
> be preempted, right? I suppose you have to do it because you want to
> initialize the clear state?

Not exactly.  We just spin up a gfx queue long enough to submit the
clear state setup and then we tear it down so its queue slot is
available for user queues.  So it's not actually a usable kernel queue
at runtime.  Setting the no_scheduler flag prevents a drm scheduler
from being initialized for the queue.

Alex

>
> Thanks
>
> > +             ring->no_user_submission =3D true;
> > +     }
> >
> >       if (!ring_id)
> >               ring->doorbell_index =3D adev->doorbell_index.gfx_ring0 <=
< 1;
> > @@ -1577,7 +1581,7 @@ static void gfx_v11_0_alloc_ip_dump(struct amdgpu=
_device *adev)
> >
> >  static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
> >  {
> > -     int i, j, k, r, ring_id =3D 0;
> > +     int i, j, k, r, ring_id;
> >       int xcc_id =3D 0;
> >       struct amdgpu_device *adev =3D ip_block->adev;
> >
> > @@ -1710,37 +1714,42 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_b=
lock *ip_block)
> >               return r;
> >       }
> >
> > -     /* set up the gfx ring */
> > -     for (i =3D 0; i < adev->gfx.me.num_me; i++) {
> > -             for (j =3D 0; j < adev->gfx.me.num_queue_per_pipe; j++) {
> > -                     for (k =3D 0; k < adev->gfx.me.num_pipe_per_me; k=
++) {
> > -                             if (!amdgpu_gfx_is_me_queue_enabled(adev,=
 i, k, j))
> > -                                     continue;
> > -
> > -                             r =3D gfx_v11_0_gfx_ring_init(adev, ring_=
id,
> > -                                                         i, k, j);
> > -                             if (r)
> > -                                     return r;
> > -                             ring_id++;
> > +     if (adev->gfx.num_gfx_rings) {
> > +             ring_id =3D 0;
> > +             /* set up the gfx ring */
> > +             for (i =3D 0; i < adev->gfx.me.num_me; i++) {
> > +                     for (j =3D 0; j < adev->gfx.me.num_queue_per_pipe=
; j++) {
> > +                             for (k =3D 0; k < adev->gfx.me.num_pipe_p=
er_me; k++) {
> > +                                     if (!amdgpu_gfx_is_me_queue_enabl=
ed(adev, i, k, j))
> > +                                             continue;
> > +
> > +                                     r =3D gfx_v11_0_gfx_ring_init(ade=
v, ring_id,
> > +                                                                 i, k,=
 j);
> > +                                     if (r)
> > +                                             return r;
> > +                                     ring_id++;
> > +                             }
> >                       }
> >               }
> >       }
> >
> > -     ring_id =3D 0;
> > -     /* set up the compute queues - allocate horizontally across pipes=
 */
> > -     for (i =3D 0; i < adev->gfx.mec.num_mec; ++i) {
> > -             for (j =3D 0; j < adev->gfx.mec.num_queue_per_pipe; j++) =
{
> > -                     for (k =3D 0; k < adev->gfx.mec.num_pipe_per_mec;=
 k++) {
> > -                             if (!amdgpu_gfx_is_mec_queue_enabled(adev=
, 0, i,
> > -                                                                  k, j=
))
> > -                                     continue;
> > +     if (adev->gfx.num_compute_rings) {
> > +             ring_id =3D 0;
> > +             /* set up the compute queues - allocate horizontally acro=
ss pipes */
> > +             for (i =3D 0; i < adev->gfx.mec.num_mec; ++i) {
> > +                     for (j =3D 0; j < adev->gfx.mec.num_queue_per_pip=
e; j++) {
> > +                             for (k =3D 0; k < adev->gfx.mec.num_pipe_=
per_mec; k++) {
> > +                                     if (!amdgpu_gfx_is_mec_queue_enab=
led(adev, 0, i,
> > +                                                                      =
    k, j))
> > +                                             continue;
> >
> > -                             r =3D gfx_v11_0_compute_ring_init(adev, r=
ing_id,
> > -                                                             i, k, j);
> > -                             if (r)
> > -                                     return r;
> > +                                     r =3D gfx_v11_0_compute_ring_init=
(adev, ring_id,
> > +                                                                     i=
, k, j);
> > +                                     if (r)
> > +                                             return r;
> >
> > -                             ring_id++;
> > +                                     ring_id++;
> > +                             }
> >                       }
> >               }
> >       }
> > @@ -4578,11 +4587,23 @@ static int gfx_v11_0_cp_resume(struct amdgpu_de=
vice *adev)
> >                       return r;
> >       }
> >
> > -     for (i =3D 0; i < adev->gfx.num_gfx_rings; i++) {
> > -             ring =3D &adev->gfx.gfx_ring[i];
> > -             r =3D amdgpu_ring_test_helper(ring);
> > -             if (r)
> > -                     return r;
> > +     if (adev->gfx.disable_kq) {
> > +             for (i =3D 0; i < adev->gfx.num_gfx_rings; i++) {
> > +                     ring =3D &adev->gfx.gfx_ring[i];
> > +                     /* we don't want to set ring->ready */
> > +                     r =3D amdgpu_ring_test_ring(ring);
> > +                     if (r)
> > +                             return r;
> > +             }
> > +             if (amdgpu_async_gfx_ring)
> > +                     amdgpu_gfx_disable_kgq(adev, 0);
> > +     } else {
> > +             for (i =3D 0; i < adev->gfx.num_gfx_rings; i++) {
> > +                     ring =3D &adev->gfx.gfx_ring[i];
> > +                     r =3D amdgpu_ring_test_helper(ring);
> > +                     if (r)
> > +                             return r;
> > +             }
> >       }
> >
> >       for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
> > @@ -4791,6 +4812,46 @@ static int gfx_v11_0_hw_init(struct amdgpu_ip_bl=
ock *ip_block)
> >       return r;
> >  }
> >
> > +static int gfx_v11_0_set_userq_eop_interrupts(struct amdgpu_device *ad=
ev,
> > +                                           bool enable)
> > +{
> > +     if (adev->gfx.disable_kq) {
> > +             unsigned int irq_type;
> > +             int m, p, r;
> > +
> > +             for (m =3D 0; m < adev->gfx.me.num_me; m++) {
> > +                     for (p =3D 0; p < adev->gfx.me.num_pipe_per_me; p=
++) {
> > +                             irq_type =3D AMDGPU_CP_IRQ_GFX_ME0_PIPE0_=
EOP + p;
> > +                             if (enable)
> > +                                     r =3D amdgpu_irq_get(adev, &adev-=
>gfx.eop_irq,
> > +                                                        irq_type);
> > +                             else
> > +                                     r =3D amdgpu_irq_put(adev, &adev-=
>gfx.eop_irq,
> > +                                                        irq_type);
> > +                             if (r)
> > +                                     return r;
> > +                     }
> > +             }
> > +
> > +             for (m =3D 0; m < adev->gfx.mec.num_mec; ++m) {
> > +                     for (p =3D 0; p < adev->gfx.mec.num_pipe_per_mec;=
 p++) {
> > +                             irq_type =3D AMDGPU_CP_IRQ_COMPUTE_MEC1_P=
IPE0_EOP
> > +                                     + (m * adev->gfx.mec.num_pipe_per=
_mec)
> > +                                     + p;
> > +                             if (enable)
> > +                                     r =3D amdgpu_irq_get(adev, &adev-=
>gfx.eop_irq,
> > +                                                        irq_type);
> > +                             else
> > +                                     r =3D amdgpu_irq_put(adev, &adev-=
>gfx.eop_irq,
> > +                                                        irq_type);
> > +                             if (r)
> > +                                     return r;
> > +                     }
> > +             }
> > +     }
> > +     return 0;
> > +}
> > +
> >  static int gfx_v11_0_hw_fini(struct amdgpu_ip_block *ip_block)
> >  {
> >       struct amdgpu_device *adev =3D ip_block->adev;
> > @@ -4800,9 +4861,11 @@ static int gfx_v11_0_hw_fini(struct amdgpu_ip_bl=
ock *ip_block)
> >       amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
> >       amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
> >       amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
> > +     gfx_v11_0_set_userq_eop_interrupts(adev, false);
> >
> >       if (!adev->no_hw_access) {
> > -             if (amdgpu_async_gfx_ring) {
> > +             if (amdgpu_async_gfx_ring &&
> > +                 !adev->gfx.disable_kq) {
> >                       if (amdgpu_gfx_disable_kgq(adev, 0))
> >                               DRM_ERROR("KGQ disable failed\n");
> >               }
> > @@ -5128,11 +5191,22 @@ static int gfx_v11_0_early_init(struct amdgpu_i=
p_block *ip_block)
> >  {
> >       struct amdgpu_device *adev =3D ip_block->adev;
> >
> > +     if (amdgpu_disable_kq =3D=3D 1)
> > +             adev->gfx.disable_kq =3D true;
> > +
> >       adev->gfx.funcs =3D &gfx_v11_0_gfx_funcs;
> >
> > -     adev->gfx.num_gfx_rings =3D GFX11_NUM_GFX_RINGS;
> > -     adev->gfx.num_compute_rings =3D min(amdgpu_gfx_get_num_kcq(adev),
> > -                                       AMDGPU_MAX_COMPUTE_RINGS);
> > +     if (adev->gfx.disable_kq) {
> > +             /* We need one GFX ring temporarily to set up
> > +              * the clear state.
> > +              */
> > +             adev->gfx.num_gfx_rings =3D 1;
> > +             adev->gfx.num_compute_rings =3D 0;
> > +     } else {
> > +             adev->gfx.num_gfx_rings =3D GFX11_NUM_GFX_RINGS;
> > +             adev->gfx.num_compute_rings =3D min(amdgpu_gfx_get_num_kc=
q(adev),
> > +                                               AMDGPU_MAX_COMPUTE_RING=
S);
> > +     }
> >
> >       gfx_v11_0_set_kiq_pm4_funcs(adev);
> >       gfx_v11_0_set_ring_funcs(adev);
> > @@ -5163,6 +5237,11 @@ static int gfx_v11_0_late_init(struct amdgpu_ip_=
block *ip_block)
> >       r =3D amdgpu_irq_get(adev, &adev->gfx.bad_op_irq, 0);
> >       if (r)
> >               return r;
> > +
> > +     r =3D gfx_v11_0_set_userq_eop_interrupts(adev, true);
> > +     if (r)
> > +             return r;
> > +
> >       return 0;
> >  }
> >
> > @@ -6548,27 +6627,29 @@ static void gfx_v11_0_handle_priv_fault(struct =
amdgpu_device *adev,
> >       pipe_id =3D (entry->ring_id & 0x03) >> 0;
> >       queue_id =3D (entry->ring_id & 0x70) >> 4;
> >
> > -     switch (me_id) {
> > -     case 0:
> > -             for (i =3D 0; i < adev->gfx.num_gfx_rings; i++) {
> > -                     ring =3D &adev->gfx.gfx_ring[i];
> > -                     if (ring->me =3D=3D me_id && ring->pipe =3D=3D pi=
pe_id &&
> > -                         ring->queue =3D=3D queue_id)
> > -                             drm_sched_fault(&ring->sched);
> > -             }
> > -             break;
> > -     case 1:
> > -     case 2:
> > -             for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
> > -                     ring =3D &adev->gfx.compute_ring[i];
> > -                     if (ring->me =3D=3D me_id && ring->pipe =3D=3D pi=
pe_id &&
> > -                         ring->queue =3D=3D queue_id)
> > -                             drm_sched_fault(&ring->sched);
> > +     if (!adev->gfx.disable_kq) {
> > +             switch (me_id) {
> > +             case 0:
> > +                     for (i =3D 0; i < adev->gfx.num_gfx_rings; i++) {
> > +                             ring =3D &adev->gfx.gfx_ring[i];
> > +                             if (ring->me =3D=3D me_id && ring->pipe =
=3D=3D pipe_id &&
> > +                                 ring->queue =3D=3D queue_id)
> > +                                     drm_sched_fault(&ring->sched);
> > +                     }
> > +                     break;
> > +             case 1:
> > +             case 2:
> > +                     for (i =3D 0; i < adev->gfx.num_compute_rings; i+=
+) {
> > +                             ring =3D &adev->gfx.compute_ring[i];
> > +                             if (ring->me =3D=3D me_id && ring->pipe =
=3D=3D pipe_id &&
> > +                                 ring->queue =3D=3D queue_id)
> > +                                     drm_sched_fault(&ring->sched);
> > +                     }
> > +                     break;
> > +             default:
> > +                     BUG();
> > +                     break;
> >               }
> > -             break;
> > -     default:
> > -             BUG();
> > -             break;
> >       }
> >  }
> >
> > --
> > 2.48.1
> >
>
> --
> Rodrigo Siqueira
