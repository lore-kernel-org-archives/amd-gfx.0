Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97971C44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 21:10:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26D4F10E4B6;
	Wed, 15 Jul 2026 21:10:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jaR8XVf8";
	dkim-atps=neutral
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42F5810E4B6
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 21:10:15 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-848554910d2so652903b3a.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 14:10:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784149815; cv=none;
 d=google.com; s=arc-20260327;
 b=cNmzdDiA4eSgO31dxyDeec9egCwDAFCROyKP7oEfDn86AYW/vTBWtX0bZ67mXINZcF
 ij/RvwfGImbtllHk8YGQqG2nGAIeNeLjCHvXDvVKyywOeRm+lQ3PjnRu/nLy7lKC4357
 LrZdFlBMuU8ctfu+Xrklg6SW2mLwsV+p17Clv6cZTw4kI3n+w7fT+DbVeTmN622NDgoQ
 oK/E0PwNIcZ36HpGaLf1R9moR/uLWgpEDrcR3ut+QkA6dLoG3CIjFxgX6YlFtlrx3wJX
 KlCgbLX6xn08a5SgAgYozfg/uGwgtxfrVzJmnBoTy7hurfntLK4CD9ge3TsmpYcjGy3W
 sb5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=D4mx8bEF0/fvjOxufljwrUNa6GRd1xFk5KBUh2Hy1T4=;
 fh=Z5+lJzJVrUGghoV2JaJWZjN0K+/3UzuWAbchkpFR9hU=;
 b=Te0S4wuMQTWCuVYIkQS/V+DdOH8uFvysRWT+rotRh/DLVAqbopzfoh17EF/uH4mgji
 uKLQh+Fr5tKNVSO0AEq2Vw1p5jN6LXSZHfNQREuK3Sq9tfP2bUg8d3P+h1Qez8rzAPoK
 4dKJpYEBZKuq7biCySUcfyuZdzOtLBiOjhQ5+nu1p4+O7xP7fimn6uzkuMHTlqakbobY
 JNw4ObRvKS7azahSLxOePdIu6rINo4rnzHFIYGtaA7QbnRJfDoHM1e0XY8g5ifuMEHwy
 Jle6p0+glllsAReIV8kcPXoQgoSSP81E2VWyQBKfWpxgKThnfEjuxcIVIfB2itMdpz3N
 9zdg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784149815; x=1784754615; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=D4mx8bEF0/fvjOxufljwrUNa6GRd1xFk5KBUh2Hy1T4=;
 b=jaR8XVf8jacsjpHTFPf617ZKvADXb4IvfAWNJhSeHV9MZMVayGLEcNcXkfuMtL32vV
 SlN0W5owuD8UhoFLJNl74uWzBUBQaWTDmegLZGcL6iqHGbQa9lzO9Ch8e6kJu/tAUBFW
 qKmucK/2WSJVhgx2E0221SmYIzsgqTNo5op8u4PJjBSvjJObvkZeWuuLtMtj3E+V+6wX
 ohLGI5uAI9A3HQ4vdQcoTBoWn3qqXLoHmQ8sCH3IlSCkC6ZGb9fef7z333BEE/+PvYzX
 xayvJo9l+VVwLnEM5xfY1yFBI+7ZnIJyYjL4rkkCi2LUajd9Dq1zGTLkTi+L/srFdSna
 NfSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784149815; x=1784754615;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=D4mx8bEF0/fvjOxufljwrUNa6GRd1xFk5KBUh2Hy1T4=;
 b=PMu3kc97g0wAaABFt6zn0njfmyo1dYq4EbkQgwY2QVhnV0F6tfojYKteKhbatQDp17
 ITwSOttW70r4A3iqFgkhu8ZQxmXAJyxkd2VFP1Xmf8w9ESjp928Re/HwqGxCD5xTuuR2
 oDahB658OqVXpuRJ1GcQSm4DG0wAQKRK698ucLuTuiQ8QHxBq1iFazna+U68ZJKc4Fsy
 OYRM6LKsF6UK78fuiN89bBA2QgKKNfya6fUcctjKSuu0+NamCb2w8pURF9Cxg1P+KNAH
 acCPE0XT0lD2nXwuhZoBXruldmtqqo9GOZXJzpwZBCr0WRCeJpehB5hI32oz7aAgUnJ9
 wMwQ==
X-Gm-Message-State: AOJu0YxdMo/W0a+NWKeOLSNKPdCgCoRqWohGdDeJzDIgKlqqfejckoGp
 afNKo7F0+oaJUFGL4AM2kh6xQ/NvVt4eWqVhaP+Hw+ToQ/zwspjwfXFKco+TE30fUxwWDMXEtb8
 kXSDPrpA3ZzY231BcAmQom8YpEsTTgRo=
X-Gm-Gg: AfdE7cnLg/FeaTfWeTIVuj4Jvk5pQWImiwJBrHM4VFN4eMzd9iRdOkDusxcb9od+GyU
 Tty76cpAbSTH9iFoAw020/KW0m6XLBas2QV8VO2/78nN6vOZ/Whj1Vp4F9sxDdAbuGxoU7I/pnA
 Afk9069Lg0xFWa5HyAgPjRnAapSu6xfKJ1BgbPNSDX9ZxQ71Bgz0R+huiJLpln0UUHrPOx9RHvU
 A+JxPVAcJnDSJENmCEHbI/48xkfSzU6AqQFmcquToZkwebiF5IQndk6nqE2iXp6qmWz8lNGFsAx
 UjQgciX5i50oXIWAnWDwznToQPPihj9IZoh5pvFVHHOos4wzzbMD4la8QlA=
X-Received: by 2002:a17:903:b85:b0:2c0:db23:4a6 with SMTP id
 d9443c01a7336-2ce9e2a0fb7mr5301665ad.1.1784149814570; Wed, 15 Jul 2026
 14:10:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260713125838.30607-1-timur.kristof@gmail.com>
 <4566110.UPlyArG6xL@timur-max>
 <CADnq5_OFgNWvM-CoE4yVa_kxiu83r50XeLuZw=+B3e95QF_b6g@mail.gmail.com>
 <13037802.F6SAcFxjWL@timur-max>
In-Reply-To: <13037802.F6SAcFxjWL@timur-max>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 15 Jul 2026 17:10:02 -0400
X-Gm-Features: AUfX_mwaOy1SxVP7Pw_Cn0DIFBnWl3s_BvJ-_8i4Te8jV2RzCl3_UlEUmyLq1Yw
Message-ID: <CADnq5_N=xveePDCw_3XX1M7pc1P5Oh54KO0KtXVzeXH9X3NfuA@mail.gmail.com>
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

On Wed, Jul 15, 2026 at 4:32=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> On 2026. j=C3=BAlius 15., szerda 21:50:53 k=C3=B6z=C3=A9p-eur=C3=B3pai ny=
=C3=A1ri id=C5=91 Alex Deucher
> wrote:
> > On Wed, Jul 15, 2026 at 11:54=E2=80=AFAM Timur Krist=C3=B3f <timur.kris=
tof@gmail.com>
> wrote:
> > > On 2026. j=C3=BAlius 14., kedd 20:47:14 k=C3=B6z=C3=A9p-eur=C3=B3pai =
ny=C3=A1ri id=C5=91 Tvrtko Ursulin
> > >
> > > wrote:
> > > > On 13/07/2026 13:58, Timur Krist=C3=B3f wrote:
> > > > > Call amdgpu_gfx_mqd_sw_init()/_fini() on GFX7 to initialize and
> > > > > finalize the MQD, just like GFX8 and newer; instead of doing
> > > > > an ad-hoc BO allocation. This introduces the possibility of
> > > > > doing an MQD backup instead of trying to reinitialize the
> > > > > MQD every time.
> > > > >
> > > > > This solves an issue with GFX IP block soft reset where
> > > > > all compute rings would hang after the reset.
> > > > >
> > > > > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > > > > ---
> > > > >
> > > > >   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 106
> > > > >   +++++++++++++-------------
> > > > >   1 file changed, 51 insertions(+), 55 deletions(-)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> > > > > b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c index
> > > > > 65b8497ad5f0..9c4b3ac27e1f
> > > > > 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> > > > > @@ -2698,25 +2698,6 @@ static int
> > > > > gfx_v7_0_cp_compute_load_microcode(struct amdgpu_device *adev)>
> > > > >
> > > > >     return 0;
> > > > >
> > > > >   }
> > > > >
> > > > > -/**
> > > > > - * gfx_v7_0_cp_compute_fini - stop the compute queues
> > > > > - *
> > > > > - * @adev: amdgpu_device pointer
> > > > > - *
> > > > > - * Stop the compute queues and tear down the driver queue
> > > > > - * info.
> > > > > - */
> > > > > -static void gfx_v7_0_cp_compute_fini(struct amdgpu_device *adev)
> > > > > -{
> > > > > -   int i;
> > > > > -
> > > > > -   for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
> > > > > -           struct amdgpu_ring *ring =3D &adev->gfx.compute_ring[=
i];
> > > > > -
> > > > > -           amdgpu_bo_free_kernel(&ring->mqd_obj, NULL, NULL);
> > > > > -   }
> > > > > -}
> > > > > -
> > > > >
> > > > >   static void gfx_v7_0_mec_fini(struct amdgpu_device *adev)
> > > > >   {
> > > > >
> > > > >     amdgpu_bo_free_kernel(&adev->gfx.mec.hpd_eop_obj, NULL, NULL)=
;
> > > > >
> > > > > @@ -2788,28 +2769,29 @@ static void gfx_v7_0_compute_pipe_init(st=
ruct
> > > > > amdgpu_device *adev,>
> > > > >
> > > > >     mutex_unlock(&adev->srbm_mutex);
> > > > >
> > > > >   }
> > > > >
> > > > > -static int gfx_v7_0_mqd_deactivate(struct amdgpu_device *adev)
> > > > > +static int gfx_v7_0_mqd_deactivate(struct amdgpu_device *adev, u=
32
> > > > > req)
> > > > >
> > > > >   {
> > > > >
> > > > > -   int i;
> > > > > +   int i, r =3D 0;
> > > > >
> > > > >     /* disable the queue if it's active */
> > > > >
> > > > > -   if (RREG32(mmCP_HQD_ACTIVE) & 1) {
> > > > > -           WREG32(mmCP_HQD_DEQUEUE_REQUEST, 1);
> > > > > +   if (RREG32(mmCP_HQD_ACTIVE) & CP_HQD_ACTIVE__ACTIVE_MASK) {
> > > > > +           WREG32_FIELD(CP_HQD_DEQUEUE_REQUEST, DEQUEUE_REQ, req=
);
> > > > >
> > > > >             for (i =3D 0; i < adev->usec_timeout; i++) {
> > > > >
> > > > > -                   if (!(RREG32(mmCP_HQD_ACTIVE) & 1))
> > > > > +                   if (!(RREG32(mmCP_HQD_ACTIVE) &
> > >
> > > CP_HQD_ACTIVE__ACTIVE_MASK))
> > >
> > > > >                             break;
> > > > >
> > > > >                     udelay(1);
> > > > >
> > > > >             }
> > > > >
> > > > >             if (i =3D=3D adev->usec_timeout)
> > > > >
> > > > > -                   return -ETIMEDOUT;
> > > > > +                   r =3D -ETIMEDOUT;
> > > > >
> > > > > -           WREG32(mmCP_HQD_DEQUEUE_REQUEST, 0);
> > > > > -           WREG32(mmCP_HQD_PQ_RPTR, 0);
> > > > > -           WREG32(mmCP_HQD_PQ_WPTR, 0);
> > > > >
> > > > >     }
> > > > >
> > > > > -   return 0;
> > > > > +   WREG32(mmCP_HQD_DEQUEUE_REQUEST, 0);
> > > > > +   WREG32(mmCP_HQD_PQ_RPTR, 0);
> > > > > +   WREG32(mmCP_HQD_PQ_WPTR, 0);
> > > > > +
> > > > > +   return r;
> > > >
> > > > I can see this matches gfx_v8_0_deactivate_hqd. If I am not missing
> > > > anything only to replace the hardcoded 1 with
> > > > CP_HQD_ACTIVE__ACTIVE_MASK?
> > >
> > > There are two changes here:
> > > - Replacing the hardcoded "1" with the define from the register defin=
ition
> > > - When it times out, still write the CP_HQD_ registers afterwards lik=
e
> > > gfx8
> > >
> > > > Is it okay to call the function mqd if the registers are hqd and is=
 v7
> > > > or v8 (which calls it hqd) more correct? Not saying either way, jus=
t
> > > > observing a curiosity.
> > >
> > > My best guess is that it's just that they used a different naming
> > > convention and forgot to update the older code.
> >
> > Technically, the MQD (Memory Queue Descriptor) and HQD (Hardware Queue
> > Descriptor) are separate things.  The MQD is a structure stored in
> > memory which stores the state of a queue.  The HQD is the hardware
> > state which stores the queue when it's mapped to hardware.  The way
> > it's supposed to work is that the driver sets up MQDs in memory and
> > then asks KIQ to map those queues to an HQD or put them on a runlist
> > (for user queues) if there are more MQDs than HQDs.  For gfx8 and
> > newer the driver sets up the MQD and then uses the KIQ to map the
> > queues.  gfx7 could work that way as well, but we never got around to
> > porting the changes back to gfx7.  Instead the driver maps the queues
> > to the HQD directly via MMIO rather than having KIQ do it on gfx7.
> >
> > Alex
>
> As far as I understood, Tvrtko's point was why the function is called
> gfx_v7_0_mqd_deactivate() when what it does is the same as
> gfx_v8_0_deactivate_hqd(), ie. why does one have MQD in the name while th=
e
> other has HQD in the name.

I don't remember why it's named like that, but deactivate_hqd() is
better aligned with what it actually does.  This is effectively the
MMIO equivalent of submitting an unmap queue packet to the KIQ.

Alex

>
>
> >
> > > > >   }
> > > > >
> > > > >   static void gfx_v7_0_mqd_init(struct amdgpu_device *adev,
> > > > >
> > > > > @@ -2964,31 +2946,42 @@ static int gfx_v7_0_mqd_commit(struct
> > > > > amdgpu_device *adev, struct cik_mqd *mqd)>
> > > > >
> > > > >   static int gfx_v7_0_compute_queue_init(struct amdgpu_device *ad=
ev,
> > > > >   int
> > > > >   ring_id) {
> > > > >
> > > > > -   int r;
> > > > > -   u64 mqd_gpu_addr;
> > > > > -   struct cik_mqd *mqd;
> > > > >
> > > > >     struct amdgpu_ring *ring =3D &adev->gfx.compute_ring[ring_id]=
;
> > > > >
> > > > > -
> > > > > -   r =3D amdgpu_bo_create_reserved(adev, sizeof(struct cik_mqd),
> > >
> > > PAGE_SIZE,
> > >
> > > > > -                                 AMDGPU_GEM_DOMAIN_GTT,
> > >
> > > &ring->mqd_obj,
> > >
> > > > > -                                 &mqd_gpu_addr, (void
> > >
> > > **)&mqd);
> > >
> > > > > -   if (r) {
> > > > > -           dev_warn(adev->dev, "(%d) create MQD bo failed\n", r)=
;
> > > > > -           return r;
> > > > > +   struct cik_mqd *mqd =3D ring->mqd_ptr;
> > > > > +   int mqd_idx =3D ring - &adev->gfx.compute_ring[0];
> > > > > +
> > > > > +   if (!amdgpu_in_reset(adev) && !adev->in_suspend) {
> > > > > +           memset((void *)mqd, 0, ring->mqd_size);
> > > > > +           mutex_lock(&adev->srbm_mutex);
> > > > > +           cik_srbm_select(adev, ring->me, ring->pipe, ring-
> > > >
> > > >queue, 0);
> > > >
> > > > > +           gfx_v7_0_mqd_init(adev, mqd, ring->mqd_gpu_addr, ring=
);
> > > > > +           gfx_v7_0_mqd_deactivate(adev, 1);
> > > > > +           gfx_v7_0_mqd_commit(adev, mqd);
> > > > > +           cik_srbm_select(adev, 0, 0, 0, 0);
> > > > > +           mutex_unlock(&adev->srbm_mutex);
> > > > > +
> > > > > +           if (adev->gfx.mec.mqd_backup[mqd_idx])
> > > > > +                   memcpy(adev->gfx.mec.mqd_backup[mqd_idx],
> > >
> > > mqd, ring->mqd_size);
> > >
> > > > > +   } else {
> > > > > +           /* restore MQD to a clean status */
> > > > > +           if (adev->gfx.mec.mqd_backup[mqd_idx])
> > > > > +                   memcpy(mqd, adev-
> > > >
> > > >gfx.mec.mqd_backup[mqd_idx], ring->mqd_size);
> > > >
> > > > > +
> > > > > +           /* Re-commit the restored backup */
> > > > > +           mutex_lock(&adev->srbm_mutex);
> > > > > +           cik_srbm_select(adev, ring->me, ring->pipe, ring-
> > > >
> > > >queue, 0);
> > > >
> > > > > +           gfx_v7_0_mqd_deactivate(adev, 2);
> > > > > +           gfx_v7_0_mqd_commit(adev, mqd);
> > > > > +           cik_srbm_select(adev, 0, 0, 0, 0);
> > > > > +           mutex_unlock(&adev->srbm_mutex);
> > > > > +
> > > > > +           /* reset ring buffer */
> > > > > +           ring->wptr =3D 0;
> > > > > +           atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0);
> > > > > +           atomic64_set((atomic64_t *)ring->rptr_cpu_addr, 0);
> > > > > +           amdgpu_ring_clear_ring(ring);
> > > > >
> > > > >     }
> > > > >
> > > > > -   mutex_lock(&adev->srbm_mutex);
> > > > > -   cik_srbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
> > > > > -
> > > > > -   gfx_v7_0_mqd_init(adev, mqd, mqd_gpu_addr, ring);
> > > > > -   gfx_v7_0_mqd_deactivate(adev);
> > > > > -   gfx_v7_0_mqd_commit(adev, mqd);
> > > > > -
> > > > > -   cik_srbm_select(adev, 0, 0, 0, 0);
> > > > > -   mutex_unlock(&adev->srbm_mutex);
> > > > > -
> > > > > -   amdgpu_bo_kunmap(ring->mqd_obj);
> > > > > -   amdgpu_bo_unreserve(ring->mqd_obj);
> > > > >
> > > > >     return 0;
> > > > >
> > > > >   }
> > > >
> > > > I think I can follow this - only the wptr and rptr reset is a bit
> > > > different than what v8 does it. Any specific reason? Gfx9 then reve=
rts
> > > > back to a single ring->wptr =3D 0. I guess v8 is somehow special?
> > > >
> > > > > @@ -3020,10 +3013,8 @@ static int gfx_v7_0_cp_compute_resume(stru=
ct
> > > > > amdgpu_device *adev)>
> > > > >
> > > > >     /* init the queues */
> > > > >     for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
> > > > >
> > > > >             r =3D gfx_v7_0_compute_queue_init(adev, i);
> > > > >
> > > > > -           if (r) {
> > > > > -                   gfx_v7_0_cp_compute_fini(adev);
> > > > > +           if (r)
> > > > >
> > > > >                     return r;
> > > > >
> > > > > -           }
> > > > >
> > > > >     }
> > > > >
> > > > >     gfx_v7_0_cp_compute_enable(adev, true);
> > > > >
> > > > > @@ -4430,6 +4421,11 @@ static int gfx_v7_0_sw_init(struct
> > > > > amdgpu_ip_block
> > > > > *ip_block)>
> > > > >
> > > > >             }
> > > > >
> > > > >     }
> > > > >
> > > > > +   /* create MQD for all compute queues */
> > > > > +   r =3D amdgpu_gfx_mqd_sw_init(adev, sizeof(struct cik_mqd), 0)=
;
> > > > > +   if (r)
> > > > > +           return r;
> > > > > +
> > > > >
> > > > >     adev->gfx.ce_ram_size =3D 0x8000;
> > > > >
> > > > >     gfx_v7_0_gpu_early_init(adev);
> > > > >
> > > > > @@ -4452,7 +4448,7 @@ static int gfx_v7_0_sw_fini(struct
> > > > > amdgpu_ip_block
> > > > > *ip_block)>
> > > > >
> > > > >     for (i =3D 0; i < adev->gfx.num_compute_rings; i++)
> > > > >
> > > > >             amdgpu_ring_fini(&adev->gfx.compute_ring[i]);
> > > > >
> > > > > -   gfx_v7_0_cp_compute_fini(adev);
> > > > > +   amdgpu_gfx_mqd_sw_fini(adev, 0);
> > > > >
> > > > >     amdgpu_gfx_rlc_fini(adev);
> > > > >     gfx_v7_0_mec_fini(adev);
> > > > >     amdgpu_bo_free_kernel(&adev->gfx.rlc.clear_state_obj,
> > > >
> > > > I am assuming all this applies only to compute because gfx is singl=
e
> > > > instance on v7?
> > >
> > > It applies only to compute because only compute has HQD/MQD
> > > on these hardware generations.
> > >
> > > > Anyway, it looks plausible to me so assuming you were able to exerc=
ise
> > > > both paths
> > >
> > > What do you mean by "both paths"?
> > >
> > > Thanks,
> > > Timur
>
>
>
>
