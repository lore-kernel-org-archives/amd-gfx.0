Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB286C44507
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 21:34:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A68D10E250;
	Wed, 15 Jul 2026 21:34:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Nm6rB/bX";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 041EB10E250
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 21:34:56 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2cecdc24b1cso4929725ad.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 14:34:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784151295; cv=none;
 d=google.com; s=arc-20260327;
 b=ehS3739heh23rque3HLxgwxjlJH7lBaF7BVxpUjuPvBMu3flF5f+3gfiGM4RVRirwv
 aITQO56tqmRqeCSuKFORr/njwvtsWD6qs9XI4EpOQw1XIv1jdKwTpBEoHl+i34YjdiFr
 E7qxyJQIJXG4fQleMv6GTGZfSLG9bC2V2vZp8Ua4kolZHSOyEn5kmaBI7ixHmaXM8uAo
 f9h9e90rs5I4hhZMsGn/vK7qW3u2rBG4XeCwbAoCZBXzFiCbNXCQPbsoIA5Dl3bwBLCu
 tBwKwIVgUsOHmJRlEJcQS9G28aGRKVg8fp2JW8XFYuDtdp5rjKoXMflSDa58DAO5qkjl
 xUug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=uC/ON1Q+VIdIj43AyuvwFDb2NA2AC98M3BYEuKCHRMk=;
 fh=Z5+lJzJVrUGghoV2JaJWZjN0K+/3UzuWAbchkpFR9hU=;
 b=nUEYuMN82MnieFPVYKzFa6RR+kuZqd6j8S/7T8Fit7p7STFEgOXUswd0q+yLj0g+AT
 qKndN013a+NPsiHKxlgby3Fk8bSxvpaybfHt1LwtOiZ9XJxyGivNhHgqxXf2rp0MmH9D
 sXan3S7puOCTy05aqgKodt9egTJu1dsmOgJs5qpHhMRiuZaK9wgMrzE+bn5DaX+8r8M5
 VppOJ0U8WvFsvL+DsCxk+Kq+r2qCY7+m4LoYdh/qpOIcyoKB4fdoqCH00qoY/DvKCPmR
 Nev7Dx8C8GOOtW8bOuskAuCfy+v8zM+eC8k9i1oen/BG35bP7TsjNK4JhrFyE967nYTP
 Hnnw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784151295; x=1784756095; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uC/ON1Q+VIdIj43AyuvwFDb2NA2AC98M3BYEuKCHRMk=;
 b=Nm6rB/bXPSglSBmToSdLRotX0z9kL2aurO7V1JhpVK9wSQvLh+unjAfpuCUPZByhSy
 FFDaP29l2VOkJrz8qINnc2UTFbBYo7GHRLmZ1dqwRT6IsaBIcJDO3bnQlwyZvOpz1CRF
 RYJnhOnD8O8T/kc1qhV+Tkppu1O7JVbwCpwkUHk3fNapuOUn28TcbCCJ2yOKd3Cyz0WA
 66R5v4D3QX606BRMYG/ezImqhiH4s42tYiptLE6vH5bHgPmg/gOMAhseMRYPQSsTk9UW
 5+lnmyJFKBTgwkkY8HvFhOdBZcTeRgD0WGtSL7VGf8pFQ8TTSoSZZmE13+znxO0CcrG3
 T31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784151295; x=1784756095;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uC/ON1Q+VIdIj43AyuvwFDb2NA2AC98M3BYEuKCHRMk=;
 b=aiuE9RH2nn1PGwgOnxxdVdwRJ4LDAGgyt5u2DV12/0MwzWhvfplC7iZTk1bs11OC5W
 lCl80bxga/tAl+PfgL8+y8nvNq5yOTbzHihl+/hZllh1xmXtYweMu46NUk1fcYmZwMMY
 LohH7ScMsVtrd2Viwc8WEDo37LRA69jkeEggSOSd4Q3mx5XVonpzgO1LQ+iWN43zht/x
 2YO7CeepcDT+LviaGdMP4RK3Wc1yZ0/pnbCjsKATQZE+h4+27+xIWBMPRVmaddZrK0Dd
 ei6rzRo4tvnXfkjXK4LKZUwcFl5+s+nk6mi0gMJy79y3bZHSgvdHHlsn1UlwaNP2QfuA
 o9cg==
X-Gm-Message-State: AOJu0YzyNJapi3w4TgVzny8pLG27czOyMYI6VZMd81Vb9mxSqxiWwlqR
 sZfa7m1P9M+znXT6MxK2Lab6Itj3Uflr4D/XLEX2z9HOqou7RULl/9ynuFvlfSGa3HX+0F5EUog
 gvzZ3QaEA3GLF0xFz55UYjOka8QCupSc=
X-Gm-Gg: AfdE7cnKkXa7gWSo5Ku7WItLmEljTEcVFM9AMViwxxkZZ04KsgRvHDY77pAFYU3XSyz
 qsEbh9rbS8flBe2Pgy/HEmGOUAsipS7Y+kk3Q4Xub4sMtMBBfXv1GX8+Gv6AI+tKT8uXKLpGrsT
 8fyy+bCZ7zDURqA5336SMny2IzV2D1pVJ3+oOinN+zWzEUSje92LRj5BFVe6NlGAEyjbcTIWH6J
 sEfMMd9QBOFyhPEdrWZyF2GXSC5+7qXPhVYGkusM8dATJtFeq5H5ji1uSTcgJwQwaHP6C8+9DzP
 O9bieWbQJm63jl7i+Rr0FC6oMvqqgeHscOsSQnPeNkXC1Lng
X-Received: by 2002:a17:902:f60c:b0:2c9:e846:a582 with SMTP id
 d9443c01a7336-2ce9e1d9c59mr154972245ad.0.1784151295492; Wed, 15 Jul 2026
 14:34:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260713125838.30607-1-timur.kristof@gmail.com>
 <13037802.F6SAcFxjWL@timur-max>
 <CADnq5_N=xveePDCw_3XX1M7pc1P5Oh54KO0KtXVzeXH9X3NfuA@mail.gmail.com>
 <10038148.V6nBDHxoPA@timur-max>
In-Reply-To: <10038148.V6nBDHxoPA@timur-max>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 15 Jul 2026 17:34:43 -0400
X-Gm-Features: AUfX_mzKx-wwA0ccCQ2SkmzJtfuINGoiWY7lK_J67KHa7PjW7HaRABwKqV-3R24
Message-ID: <CADnq5_PU_A+m64yCuibgJxTi_gr91SO8bjzO4vkTx+UaBPm1Kg@mail.gmail.com>
Subject: Re: [PATCH 2/9] drm/amdgpu/gfx7: Refactor MQD initialization and
 finalization
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com, 
 Natalie Vock <natalie.vock@gmx.de>, Tvrtko Ursulin <tursulin@ursulin.net>
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

On Wed, Jul 15, 2026 at 5:30=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> On 2026. j=C3=BAlius 15., szerda 23:10:02 k=C3=B6z=C3=A9p-eur=C3=B3pai ny=
=C3=A1ri id=C5=91 Alex Deucher
> wrote:
> > On Wed, Jul 15, 2026 at 4:32=E2=80=AFPM Timur Krist=C3=B3f <timur.krist=
of@gmail.com>
> wrote:
> > > On 2026. j=C3=BAlius 15., szerda 21:50:53 k=C3=B6z=C3=A9p-eur=C3=B3pa=
i ny=C3=A1ri id=C5=91 Alex Deucher
> > >
> > > wrote:
> > > > On Wed, Jul 15, 2026 at 11:54=E2=80=AFAM Timur Krist=C3=B3f <timur.=
kristof@gmail.com>
> > >
> > > wrote:
> > > > > On 2026. j=C3=BAlius 14., kedd 20:47:14 k=C3=B6z=C3=A9p-eur=C3=B3=
pai ny=C3=A1ri id=C5=91 Tvrtko
> > > > > Ursulin
> > > > >
> > > > > wrote:
> > > > > > On 13/07/2026 13:58, Timur Krist=C3=B3f wrote:
> > > > > > > Call amdgpu_gfx_mqd_sw_init()/_fini() on GFX7 to initialize a=
nd
> > > > > > > finalize the MQD, just like GFX8 and newer; instead of doing
> > > > > > > an ad-hoc BO allocation. This introduces the possibility of
> > > > > > > doing an MQD backup instead of trying to reinitialize the
> > > > > > > MQD every time.
> > > > > > >
> > > > > > > This solves an issue with GFX IP block soft reset where
> > > > > > > all compute rings would hang after the reset.
> > > > > > >
> > > > > > > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > > > > > > ---
> > > > > > >
> > > > > > >   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 106
> > > > > > >   +++++++++++++-------------
> > > > > > >   1 file changed, 51 insertions(+), 55 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> > > > > > > b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c index
> > > > > > > 65b8497ad5f0..9c4b3ac27e1f
> > > > > > > 100644
> > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> > > > > > > @@ -2698,25 +2698,6 @@ static int
> > > > > > > gfx_v7_0_cp_compute_load_microcode(struct amdgpu_device *adev=
)>
> > > > > > >
> > > > > > >     return 0;
> > > > > > >
> > > > > > >   }
> > > > > > >
> > > > > > > -/**
> > > > > > > - * gfx_v7_0_cp_compute_fini - stop the compute queues
> > > > > > > - *
> > > > > > > - * @adev: amdgpu_device pointer
> > > > > > > - *
> > > > > > > - * Stop the compute queues and tear down the driver queue
> > > > > > > - * info.
> > > > > > > - */
> > > > > > > -static void gfx_v7_0_cp_compute_fini(struct amdgpu_device *a=
dev)
> > > > > > > -{
> > > > > > > -   int i;
> > > > > > > -
> > > > > > > -   for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
> > > > > > > -           struct amdgpu_ring *ring =3D &adev->gfx.compute_r=
ing[i];
> > > > > > > -
> > > > > > > -           amdgpu_bo_free_kernel(&ring->mqd_obj, NULL, NULL)=
;
> > > > > > > -   }
> > > > > > > -}
> > > > > > > -
> > > > > > >
> > > > > > >   static void gfx_v7_0_mec_fini(struct amdgpu_device *adev)
> > > > > > >   {
> > > > > > >
> > > > > > >     amdgpu_bo_free_kernel(&adev->gfx.mec.hpd_eop_obj, NULL, N=
ULL);
> > > > > > >
> > > > > > > @@ -2788,28 +2769,29 @@ static void
> > > > > > > gfx_v7_0_compute_pipe_init(struct
> > > > > > > amdgpu_device *adev,>
> > > > > > >
> > > > > > >     mutex_unlock(&adev->srbm_mutex);
> > > > > > >
> > > > > > >   }
> > > > > > >
> > > > > > > -static int gfx_v7_0_mqd_deactivate(struct amdgpu_device *ade=
v)
> > > > > > > +static int gfx_v7_0_mqd_deactivate(struct amdgpu_device *ade=
v,
> > > > > > > u32
> > > > > > > req)
> > > > > > >
> > > > > > >   {
> > > > > > >
> > > > > > > -   int i;
> > > > > > > +   int i, r =3D 0;
> > > > > > >
> > > > > > >     /* disable the queue if it's active */
> > > > > > >
> > > > > > > -   if (RREG32(mmCP_HQD_ACTIVE) & 1) {
> > > > > > > -           WREG32(mmCP_HQD_DEQUEUE_REQUEST, 1);
> > > > > > > +   if (RREG32(mmCP_HQD_ACTIVE) & CP_HQD_ACTIVE__ACTIVE_MASK)=
 {
> > > > > > > +           WREG32_FIELD(CP_HQD_DEQUEUE_REQUEST, DEQUEUE_REQ,
> > > > > > > req);
> > > > > > >
> > > > > > >             for (i =3D 0; i < adev->usec_timeout; i++) {
> > > > > > >
> > > > > > > -                   if (!(RREG32(mmCP_HQD_ACTIVE) & 1))
> > > > > > > +                   if (!(RREG32(mmCP_HQD_ACTIVE) &
> > > > >
> > > > > CP_HQD_ACTIVE__ACTIVE_MASK))
> > > > >
> > > > > > >                             break;
> > > > > > >
> > > > > > >                     udelay(1);
> > > > > > >
> > > > > > >             }
> > > > > > >
> > > > > > >             if (i =3D=3D adev->usec_timeout)
> > > > > > >
> > > > > > > -                   return -ETIMEDOUT;
> > > > > > > +                   r =3D -ETIMEDOUT;
> > > > > > >
> > > > > > > -           WREG32(mmCP_HQD_DEQUEUE_REQUEST, 0);
> > > > > > > -           WREG32(mmCP_HQD_PQ_RPTR, 0);
> > > > > > > -           WREG32(mmCP_HQD_PQ_WPTR, 0);
> > > > > > >
> > > > > > >     }
> > > > > > >
> > > > > > > -   return 0;
> > > > > > > +   WREG32(mmCP_HQD_DEQUEUE_REQUEST, 0);
> > > > > > > +   WREG32(mmCP_HQD_PQ_RPTR, 0);
> > > > > > > +   WREG32(mmCP_HQD_PQ_WPTR, 0);
> > > > > > > +
> > > > > > > +   return r;
> > > > > >
> > > > > > I can see this matches gfx_v8_0_deactivate_hqd. If I am not mis=
sing
> > > > > > anything only to replace the hardcoded 1 with
> > > > > > CP_HQD_ACTIVE__ACTIVE_MASK?
> > > > >
> > > > > There are two changes here:
> > > > > - Replacing the hardcoded "1" with the define from the register
> > > > > definition
> > > > > - When it times out, still write the CP_HQD_ registers afterwards=
 like
> > > > > gfx8
> > > > >
> > > > > > Is it okay to call the function mqd if the registers are hqd an=
d is
> > > > > > v7
> > > > > > or v8 (which calls it hqd) more correct? Not saying either way,=
 just
> > > > > > observing a curiosity.
> > > > >
> > > > > My best guess is that it's just that they used a different naming
> > > > > convention and forgot to update the older code.
> > > >
> > > > Technically, the MQD (Memory Queue Descriptor) and HQD (Hardware Qu=
eue
> > > > Descriptor) are separate things.  The MQD is a structure stored in
> > > > memory which stores the state of a queue.  The HQD is the hardware
> > > > state which stores the queue when it's mapped to hardware.  The way
> > > > it's supposed to work is that the driver sets up MQDs in memory and
> > > > then asks KIQ to map those queues to an HQD or put them on a runlis=
t
> > > > (for user queues) if there are more MQDs than HQDs.  For gfx8 and
> > > > newer the driver sets up the MQD and then uses the KIQ to map the
> > > > queues.  gfx7 could work that way as well, but we never got around =
to
> > > > porting the changes back to gfx7.  Instead the driver maps the queu=
es
> > > > to the HQD directly via MMIO rather than having KIQ do it on gfx7.
> > > >
> > > > Alex
> > >
> > > As far as I understood, Tvrtko's point was why the function is called
> > > gfx_v7_0_mqd_deactivate() when what it does is the same as
> > > gfx_v8_0_deactivate_hqd(), ie. why does one have MQD in the name whil=
e the
> > > other has HQD in the name.
> >
> > I don't remember why it's named like that, but deactivate_hqd() is
> > better aligned with what it actually does.  This is effectively the
> > MMIO equivalent of submitting an unmap queue packet to the KIQ.
> >
> > Alex
>
> Would it be OK if I renamed it?
> gfx_v7_0_mqd_deactivate() --> gfx_v7_0_deactivate_hqd()
> to better align it with gfx8 and ease the confusion.

yeah, that would be better.

Alex

>
>
> >
> > > > > > >   }
> > > > > > >
> > > > > > >   static void gfx_v7_0_mqd_init(struct amdgpu_device *adev,
> > > > > > >
> > > > > > > @@ -2964,31 +2946,42 @@ static int gfx_v7_0_mqd_commit(struct
> > > > > > > amdgpu_device *adev, struct cik_mqd *mqd)>
> > > > > > >
> > > > > > >   static int gfx_v7_0_compute_queue_init(struct amdgpu_device
> > > > > > >   *adev,
> > > > > > >   int
> > > > > > >   ring_id) {
> > > > > > >
> > > > > > > -   int r;
> > > > > > > -   u64 mqd_gpu_addr;
> > > > > > > -   struct cik_mqd *mqd;
> > > > > > >
> > > > > > >     struct amdgpu_ring *ring =3D &adev->gfx.compute_ring[ring=
_id];
> > > > > > >
> > > > > > > -
> > > > > > > -   r =3D amdgpu_bo_create_reserved(adev, sizeof(struct cik_m=
qd),
> > > > >
> > > > > PAGE_SIZE,
> > > > >
> > > > > > > -                                 AMDGPU_GEM_DOMAIN_GTT,
> > > > >
> > > > > &ring->mqd_obj,
> > > > >
> > > > > > > -                                 &mqd_gpu_addr, (void
> > > > >
> > > > > **)&mqd);
> > > > >
> > > > > > > -   if (r) {
> > > > > > > -           dev_warn(adev->dev, "(%d) create MQD bo failed\n"=
, r);
> > > > > > > -           return r;
> > > > > > > +   struct cik_mqd *mqd =3D ring->mqd_ptr;
> > > > > > > +   int mqd_idx =3D ring - &adev->gfx.compute_ring[0];
> > > > > > > +
> > > > > > > +   if (!amdgpu_in_reset(adev) && !adev->in_suspend) {
> > > > > > > +           memset((void *)mqd, 0, ring->mqd_size);
> > > > > > > +           mutex_lock(&adev->srbm_mutex);
> > > > > > > +           cik_srbm_select(adev, ring->me, ring->pipe, ring-
> > > > > >
> > > > > >queue, 0);
> > > > > >
> > > > > > > +           gfx_v7_0_mqd_init(adev, mqd, ring->mqd_gpu_addr,
> > > > > > > ring);
> > > > > > > +           gfx_v7_0_mqd_deactivate(adev, 1);
> > > > > > > +           gfx_v7_0_mqd_commit(adev, mqd);
> > > > > > > +           cik_srbm_select(adev, 0, 0, 0, 0);
> > > > > > > +           mutex_unlock(&adev->srbm_mutex);
> > > > > > > +
> > > > > > > +           if (adev->gfx.mec.mqd_backup[mqd_idx])
> > > > > > > +                   memcpy(adev->gfx.mec.mqd_backup[mqd_idx],
> > > > >
> > > > > mqd, ring->mqd_size);
> > > > >
> > > > > > > +   } else {
> > > > > > > +           /* restore MQD to a clean status */
> > > > > > > +           if (adev->gfx.mec.mqd_backup[mqd_idx])
> > > > > > > +                   memcpy(mqd, adev-
> > > > > >
> > > > > >gfx.mec.mqd_backup[mqd_idx], ring->mqd_size);
> > > > > >
> > > > > > > +
> > > > > > > +           /* Re-commit the restored backup */
> > > > > > > +           mutex_lock(&adev->srbm_mutex);
> > > > > > > +           cik_srbm_select(adev, ring->me, ring->pipe, ring-
> > > > > >
> > > > > >queue, 0);
> > > > > >
> > > > > > > +           gfx_v7_0_mqd_deactivate(adev, 2);
> > > > > > > +           gfx_v7_0_mqd_commit(adev, mqd);
> > > > > > > +           cik_srbm_select(adev, 0, 0, 0, 0);
> > > > > > > +           mutex_unlock(&adev->srbm_mutex);
> > > > > > > +
> > > > > > > +           /* reset ring buffer */
> > > > > > > +           ring->wptr =3D 0;
> > > > > > > +           atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0=
);
> > > > > > > +           atomic64_set((atomic64_t *)ring->rptr_cpu_addr, 0=
);
> > > > > > > +           amdgpu_ring_clear_ring(ring);
> > > > > > >
> > > > > > >     }
> > > > > > >
> > > > > > > -   mutex_lock(&adev->srbm_mutex);
> > > > > > > -   cik_srbm_select(adev, ring->me, ring->pipe, ring->queue, =
0);
> > > > > > > -
> > > > > > > -   gfx_v7_0_mqd_init(adev, mqd, mqd_gpu_addr, ring);
> > > > > > > -   gfx_v7_0_mqd_deactivate(adev);
> > > > > > > -   gfx_v7_0_mqd_commit(adev, mqd);
> > > > > > > -
> > > > > > > -   cik_srbm_select(adev, 0, 0, 0, 0);
> > > > > > > -   mutex_unlock(&adev->srbm_mutex);
> > > > > > > -
> > > > > > > -   amdgpu_bo_kunmap(ring->mqd_obj);
> > > > > > > -   amdgpu_bo_unreserve(ring->mqd_obj);
> > > > > > >
> > > > > > >     return 0;
> > > > > > >
> > > > > > >   }
> > > > > >
> > > > > > I think I can follow this - only the wptr and rptr reset is a b=
it
> > > > > > different than what v8 does it. Any specific reason? Gfx9 then
> > > > > > reverts
> > > > > > back to a single ring->wptr =3D 0. I guess v8 is somehow specia=
l?
> > > > > >
> > > > > > > @@ -3020,10 +3013,8 @@ static int
> > > > > > > gfx_v7_0_cp_compute_resume(struct
> > > > > > > amdgpu_device *adev)>
> > > > > > >
> > > > > > >     /* init the queues */
> > > > > > >     for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
> > > > > > >
> > > > > > >             r =3D gfx_v7_0_compute_queue_init(adev, i);
> > > > > > >
> > > > > > > -           if (r) {
> > > > > > > -                   gfx_v7_0_cp_compute_fini(adev);
> > > > > > > +           if (r)
> > > > > > >
> > > > > > >                     return r;
> > > > > > >
> > > > > > > -           }
> > > > > > >
> > > > > > >     }
> > > > > > >
> > > > > > >     gfx_v7_0_cp_compute_enable(adev, true);
> > > > > > >
> > > > > > > @@ -4430,6 +4421,11 @@ static int gfx_v7_0_sw_init(struct
> > > > > > > amdgpu_ip_block
> > > > > > > *ip_block)>
> > > > > > >
> > > > > > >             }
> > > > > > >
> > > > > > >     }
> > > > > > >
> > > > > > > +   /* create MQD for all compute queues */
> > > > > > > +   r =3D amdgpu_gfx_mqd_sw_init(adev, sizeof(struct cik_mqd)=
, 0);
> > > > > > > +   if (r)
> > > > > > > +           return r;
> > > > > > > +
> > > > > > >
> > > > > > >     adev->gfx.ce_ram_size =3D 0x8000;
> > > > > > >
> > > > > > >     gfx_v7_0_gpu_early_init(adev);
> > > > > > >
> > > > > > > @@ -4452,7 +4448,7 @@ static int gfx_v7_0_sw_fini(struct
> > > > > > > amdgpu_ip_block
> > > > > > > *ip_block)>
> > > > > > >
> > > > > > >     for (i =3D 0; i < adev->gfx.num_compute_rings; i++)
> > > > > > >
> > > > > > >             amdgpu_ring_fini(&adev->gfx.compute_ring[i]);
> > > > > > >
> > > > > > > -   gfx_v7_0_cp_compute_fini(adev);
> > > > > > > +   amdgpu_gfx_mqd_sw_fini(adev, 0);
> > > > > > >
> > > > > > >     amdgpu_gfx_rlc_fini(adev);
> > > > > > >     gfx_v7_0_mec_fini(adev);
> > > > > > >     amdgpu_bo_free_kernel(&adev->gfx.rlc.clear_state_obj,
> > > > > >
> > > > > > I am assuming all this applies only to compute because gfx is s=
ingle
> > > > > > instance on v7?
> > > > >
> > > > > It applies only to compute because only compute has HQD/MQD
> > > > > on these hardware generations.
> > > > >
> > > > > > Anyway, it looks plausible to me so assuming you were able to
> > > > > > exercise
> > > > > > both paths
> > > > >
> > > > > What do you mean by "both paths"?
> > > > >
> > > > > Thanks,
> > > > > Timur
>
>
>
>
