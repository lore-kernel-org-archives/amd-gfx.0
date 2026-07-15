Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3343FC44508
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 19:51:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B32D210E114;
	Wed, 15 Jul 2026 19:51:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Kdeuaslw";
	dkim-atps=neutral
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 796C210E114
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 19:51:05 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2cf1777c25aso555955ad.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 12:51:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784145065; cv=none;
 d=google.com; s=arc-20260327;
 b=nJX2OVzVG+iODMaF7o2ORZLwp9vIe+fWp6Fi/BuwWpmBfWX64+NZCENIhyAlSQ5z3G
 sDRtDF00yezyA9Hy7aQ6aTydCnfMJA88tVa2SsaizpFXz04CCLEXuPNHllnCg12Qp6In
 WtDDKgTCIntgiewigjKwOQYVkS2ub0cHz1j+lqKwyToGVOi0QR0C3afuaYm4ovakLbeM
 M6Eihp7hy9ku56R1Nu4alWj6Ph8q/dLMRirip1dim9D0LzHLaPL6JJiCcZ132I5np6ha
 D219DAwBdIadCSRAltNnjUZ42I2pmOKW+uc/fv5Tiv+PKZJO3TYRudnnY3rEivFsBcac
 eU3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jRirA46e+5eL3/vklb0NYpcSllQksExzLx/8bDK/e54=;
 fh=Z5+lJzJVrUGghoV2JaJWZjN0K+/3UzuWAbchkpFR9hU=;
 b=Ptv4xjPWXTUsylwAQ9HCwYOINY1YMS73OfUStXFwHPevHYKxxM/E6F6F381moF1YLh
 L8dcuvXRSXuGb2CIGTPyZuTndfZ9DsDbvejMCV9IL31IiI0HVGqxtWr/IfcP+83Ya3N+
 8RSQmgZIvfYds792i/6YRTXlqtPoQEOpUJVUz9MrbERwL3rMbZBLwoWKzdOCnEVzRtAN
 zbYtlDb3958rS6aEGt/XaAFUVjqHHqR4VCE4i7JrG1hB1E+HZSXcX9AaGBgUo8XIlbHr
 VZKUOPDtNTmdTdcNndytSDvwch9JE5WGmhtHpIjFMpSCVW3kl0YmvHzsIOKrmQT2xEWQ
 3BqA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784145065; x=1784749865; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jRirA46e+5eL3/vklb0NYpcSllQksExzLx/8bDK/e54=;
 b=KdeuaslwXIbEoh9cKHh/F/ogAzKh+s2+As6/CDCU1UsMWhbBvKDKVgNVgcazw09WxG
 C0QO1q/YgDpCTjLZEOKl0Rte8HfXWiEphm809Si3sRl8OxVe7/5aHplHJTZC2vUMmx7P
 db2X4YusCHpa1Nmbwx+E05l8yRrtVxqw1WAjdK54fq+6HpGcPELjWMvlvnnL7KQGl3IR
 ZCpKcuY8LsX7nfU+CQUMp95MF2TdCMjNJgEnx/F2p5WrNwQAO8LFIAfRKUeHl2TxSHbb
 +X/J4Z/0+vO9+ImK8cu6mVwdbrK10Kh+pWBavt+kAYDnuTL7mBhlX89UqjGZAeiVd6Nt
 ccCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784145065; x=1784749865;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jRirA46e+5eL3/vklb0NYpcSllQksExzLx/8bDK/e54=;
 b=a0waGZ+Wpj6GNU0FTyuTcCujL08pVsMLxmPr94uI987tQfzAfN/bDUnLRWiPBr99sG
 RBpShlrXDFPQQ83DBLRX6pbtfrBQWlS5vQNllDlLqa2QXTNhiiVqhunomrkotIEEtI+6
 FMKIjGXfDTwo/ZZ76+s8pm401aQGZxOPN32FJ/tWr8LJOIFRBlca9LopkELHG4i2WWSW
 Fmyq5bFK1lUHLtnHp6WDFvnYkiwA2I8jyMx51mKoUIptoLAk2/HVkUfOD4Jbkf38gh5k
 LFZyYVslwfME3Y9t+DokDUwEIiQYtqy2ES0aA+JsChHKojosuavWMiBPGTGCitzInG7i
 tsFQ==
X-Gm-Message-State: AOJu0Yz+AAIdzYtoWB6cXTkfM5jnC3Ef34ZK2+H6HiOOHlUCDtz7nhWv
 nLbmwtqWnSOoNf0LpLvSwTbwkHmXiIMeKwvHUWD0ULinWzUvL647PitTUR8vyx991bQhsM9poDP
 dxPjc1Y177DAs2xDyt5qDPf5rg8Y54Yc=
X-Gm-Gg: AfdE7ckHNrd4qMGDBZ8SbSWLDFTBq0UnTcx+dyA5k/+xYadfnf09mIUIbv6jlFTm+JC
 5WHDGp2xEkl1maXqlxTSwFZlUBHwEQLLNRvCt9eB8scJGTrEcTT9JvptLaHsy5ZX9ApMf/imj7y
 yNh991tUWCkBy9uVCezr8dLN1AsW3QcRRE4lgSW9E17icRegq5IlvSc+M2QngX6Vv7FI1+PZwaG
 xRxMIGjMt0btwAAVZEqyxpHhKVmnkWgm/TF8cSDxb07IGWdE3AbHN0rI5+Y6hp4eToiFuaPnSVY
 XYX4wY1hn6/ueam1whdaeg9csJ0SZvuAzXignfVq/vkzWVN2OKThef+qwWU=
X-Received: by 2002:a17:902:da2d:b0:2ca:bca8:109b with SMTP id
 d9443c01a7336-2ce9f176961mr136947375ad.5.1784145064871; Wed, 15 Jul 2026
 12:51:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260713125838.30607-1-timur.kristof@gmail.com>
 <20260713125838.30607-3-timur.kristof@gmail.com>
 <f0fe75db-5ded-4370-b931-3ef3827f0b16@ursulin.net>
 <4566110.UPlyArG6xL@timur-max>
In-Reply-To: <4566110.UPlyArG6xL@timur-max>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 15 Jul 2026 15:50:53 -0400
X-Gm-Features: AUfX_my4kMxn0B5q5WUKbxCer5Q69vbS5XqroyRGqoGA-K6mBnxYJLmrnIxh_ec
Message-ID: <CADnq5_OFgNWvM-CoE4yVa_kxiu83r50XeLuZw=+B3e95QF_b6g@mail.gmail.com>
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

On Wed, Jul 15, 2026 at 11:54=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@=
gmail.com> wrote:
>
> On 2026. j=C3=BAlius 14., kedd 20:47:14 k=C3=B6z=C3=A9p-eur=C3=B3pai ny=
=C3=A1ri id=C5=91 Tvrtko Ursulin
> wrote:
> > On 13/07/2026 13:58, Timur Krist=C3=B3f wrote:
> > > Call amdgpu_gfx_mqd_sw_init()/_fini() on GFX7 to initialize and
> > > finalize the MQD, just like GFX8 and newer; instead of doing
> > > an ad-hoc BO allocation. This introduces the possibility of
> > > doing an MQD backup instead of trying to reinitialize the
> > > MQD every time.
> > >
> > > This solves an issue with GFX IP block soft reset where
> > > all compute rings would hang after the reset.
> > >
> > > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > > ---
> > >
> > >   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 106 +++++++++++++----------=
---
> > >   1 file changed, 51 insertions(+), 55 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> > > b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c index 65b8497ad5f0..9c4b3ac27=
e1f
> > > 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> > > @@ -2698,25 +2698,6 @@ static int
> > > gfx_v7_0_cp_compute_load_microcode(struct amdgpu_device *adev)>
> > >     return 0;
> > >
> > >   }
> > >
> > > -/**
> > > - * gfx_v7_0_cp_compute_fini - stop the compute queues
> > > - *
> > > - * @adev: amdgpu_device pointer
> > > - *
> > > - * Stop the compute queues and tear down the driver queue
> > > - * info.
> > > - */
> > > -static void gfx_v7_0_cp_compute_fini(struct amdgpu_device *adev)
> > > -{
> > > -   int i;
> > > -
> > > -   for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
> > > -           struct amdgpu_ring *ring =3D &adev->gfx.compute_ring[i];
> > > -
> > > -           amdgpu_bo_free_kernel(&ring->mqd_obj, NULL, NULL);
> > > -   }
> > > -}
> > > -
> > >
> > >   static void gfx_v7_0_mec_fini(struct amdgpu_device *adev)
> > >   {
> > >
> > >     amdgpu_bo_free_kernel(&adev->gfx.mec.hpd_eop_obj, NULL, NULL);
> > >
> > > @@ -2788,28 +2769,29 @@ static void gfx_v7_0_compute_pipe_init(struct
> > > amdgpu_device *adev,>
> > >     mutex_unlock(&adev->srbm_mutex);
> > >
> > >   }
> > >
> > > -static int gfx_v7_0_mqd_deactivate(struct amdgpu_device *adev)
> > > +static int gfx_v7_0_mqd_deactivate(struct amdgpu_device *adev, u32 r=
eq)
> > >
> > >   {
> > >
> > > -   int i;
> > > +   int i, r =3D 0;
> > >
> > >     /* disable the queue if it's active */
> > >
> > > -   if (RREG32(mmCP_HQD_ACTIVE) & 1) {
> > > -           WREG32(mmCP_HQD_DEQUEUE_REQUEST, 1);
> > > +   if (RREG32(mmCP_HQD_ACTIVE) & CP_HQD_ACTIVE__ACTIVE_MASK) {
> > > +           WREG32_FIELD(CP_HQD_DEQUEUE_REQUEST, DEQUEUE_REQ, req);
> > >
> > >             for (i =3D 0; i < adev->usec_timeout; i++) {
> > >
> > > -                   if (!(RREG32(mmCP_HQD_ACTIVE) & 1))
> > > +                   if (!(RREG32(mmCP_HQD_ACTIVE) &
> CP_HQD_ACTIVE__ACTIVE_MASK))
> > >
> > >                             break;
> > >
> > >                     udelay(1);
> > >
> > >             }
> > >
> > >             if (i =3D=3D adev->usec_timeout)
> > >
> > > -                   return -ETIMEDOUT;
> > > +                   r =3D -ETIMEDOUT;
> > >
> > > -           WREG32(mmCP_HQD_DEQUEUE_REQUEST, 0);
> > > -           WREG32(mmCP_HQD_PQ_RPTR, 0);
> > > -           WREG32(mmCP_HQD_PQ_WPTR, 0);
> > >
> > >     }
> > >
> > > -   return 0;
> > > +   WREG32(mmCP_HQD_DEQUEUE_REQUEST, 0);
> > > +   WREG32(mmCP_HQD_PQ_RPTR, 0);
> > > +   WREG32(mmCP_HQD_PQ_WPTR, 0);
> > > +
> > > +   return r;
> >
> > I can see this matches gfx_v8_0_deactivate_hqd. If I am not missing
> > anything only to replace the hardcoded 1 with CP_HQD_ACTIVE__ACTIVE_MAS=
K?
>
> There are two changes here:
> - Replacing the hardcoded "1" with the define from the register definitio=
n
> - When it times out, still write the CP_HQD_ registers afterwards like gf=
x8
>
> > Is it okay to call the function mqd if the registers are hqd and is v7
> > or v8 (which calls it hqd) more correct? Not saying either way, just
> > observing a curiosity.
>
> My best guess is that it's just that they used a different naming convent=
ion
> and forgot to update the older code.

Technically, the MQD (Memory Queue Descriptor) and HQD (Hardware Queue
Descriptor) are separate things.  The MQD is a structure stored in
memory which stores the state of a queue.  The HQD is the hardware
state which stores the queue when it's mapped to hardware.  The way
it's supposed to work is that the driver sets up MQDs in memory and
then asks KIQ to map those queues to an HQD or put them on a runlist
(for user queues) if there are more MQDs than HQDs.  For gfx8 and
newer the driver sets up the MQD and then uses the KIQ to map the
queues.  gfx7 could work that way as well, but we never got around to
porting the changes back to gfx7.  Instead the driver maps the queues
to the HQD directly via MMIO rather than having KIQ do it on gfx7.

Alex

>
> >
> > >   }
> > >
> > >   static void gfx_v7_0_mqd_init(struct amdgpu_device *adev,
> > >
> > > @@ -2964,31 +2946,42 @@ static int gfx_v7_0_mqd_commit(struct
> > > amdgpu_device *adev, struct cik_mqd *mqd)>
> > >   static int gfx_v7_0_compute_queue_init(struct amdgpu_device *adev, =
int
> > >   ring_id) {
> > >
> > > -   int r;
> > > -   u64 mqd_gpu_addr;
> > > -   struct cik_mqd *mqd;
> > >
> > >     struct amdgpu_ring *ring =3D &adev->gfx.compute_ring[ring_id];
> > >
> > > -
> > > -   r =3D amdgpu_bo_create_reserved(adev, sizeof(struct cik_mqd),
> PAGE_SIZE,
> > > -                                 AMDGPU_GEM_DOMAIN_GTT,
> &ring->mqd_obj,
> > > -                                 &mqd_gpu_addr, (void
> **)&mqd);
> > > -   if (r) {
> > > -           dev_warn(adev->dev, "(%d) create MQD bo failed\n", r);
> > > -           return r;
> > > +   struct cik_mqd *mqd =3D ring->mqd_ptr;
> > > +   int mqd_idx =3D ring - &adev->gfx.compute_ring[0];
> > > +
> > > +   if (!amdgpu_in_reset(adev) && !adev->in_suspend) {
> > > +           memset((void *)mqd, 0, ring->mqd_size);
> > > +           mutex_lock(&adev->srbm_mutex);
> > > +           cik_srbm_select(adev, ring->me, ring->pipe, ring-
> >queue, 0);
> > > +           gfx_v7_0_mqd_init(adev, mqd, ring->mqd_gpu_addr, ring);
> > > +           gfx_v7_0_mqd_deactivate(adev, 1);
> > > +           gfx_v7_0_mqd_commit(adev, mqd);
> > > +           cik_srbm_select(adev, 0, 0, 0, 0);
> > > +           mutex_unlock(&adev->srbm_mutex);
> > > +
> > > +           if (adev->gfx.mec.mqd_backup[mqd_idx])
> > > +                   memcpy(adev->gfx.mec.mqd_backup[mqd_idx],
> mqd, ring->mqd_size);
> > > +   } else {
> > > +           /* restore MQD to a clean status */
> > > +           if (adev->gfx.mec.mqd_backup[mqd_idx])
> > > +                   memcpy(mqd, adev-
> >gfx.mec.mqd_backup[mqd_idx], ring->mqd_size);
> > > +
> > > +           /* Re-commit the restored backup */
> > > +           mutex_lock(&adev->srbm_mutex);
> > > +           cik_srbm_select(adev, ring->me, ring->pipe, ring-
> >queue, 0);
> > > +           gfx_v7_0_mqd_deactivate(adev, 2);
> > > +           gfx_v7_0_mqd_commit(adev, mqd);
> > > +           cik_srbm_select(adev, 0, 0, 0, 0);
> > > +           mutex_unlock(&adev->srbm_mutex);
> > > +
> > > +           /* reset ring buffer */
> > > +           ring->wptr =3D 0;
> > > +           atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0);
> > > +           atomic64_set((atomic64_t *)ring->rptr_cpu_addr, 0);
> > > +           amdgpu_ring_clear_ring(ring);
> > >
> > >     }
> > >
> > > -   mutex_lock(&adev->srbm_mutex);
> > > -   cik_srbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
> > > -
> > > -   gfx_v7_0_mqd_init(adev, mqd, mqd_gpu_addr, ring);
> > > -   gfx_v7_0_mqd_deactivate(adev);
> > > -   gfx_v7_0_mqd_commit(adev, mqd);
> > > -
> > > -   cik_srbm_select(adev, 0, 0, 0, 0);
> > > -   mutex_unlock(&adev->srbm_mutex);
> > > -
> > > -   amdgpu_bo_kunmap(ring->mqd_obj);
> > > -   amdgpu_bo_unreserve(ring->mqd_obj);
> > >
> > >     return 0;
> > >
> > >   }
> >
> > I think I can follow this - only the wptr and rptr reset is a bit
> > different than what v8 does it. Any specific reason? Gfx9 then reverts
> > back to a single ring->wptr =3D 0. I guess v8 is somehow special?
> >
> > > @@ -3020,10 +3013,8 @@ static int gfx_v7_0_cp_compute_resume(struct
> > > amdgpu_device *adev)>
> > >     /* init the queues */
> > >     for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
> > >
> > >             r =3D gfx_v7_0_compute_queue_init(adev, i);
> > >
> > > -           if (r) {
> > > -                   gfx_v7_0_cp_compute_fini(adev);
> > > +           if (r)
> > >
> > >                     return r;
> > >
> > > -           }
> > >
> > >     }
> > >
> > >     gfx_v7_0_cp_compute_enable(adev, true);
> > >
> > > @@ -4430,6 +4421,11 @@ static int gfx_v7_0_sw_init(struct amdgpu_ip_b=
lock
> > > *ip_block)>
> > >             }
> > >
> > >     }
> > >
> > > +   /* create MQD for all compute queues */
> > > +   r =3D amdgpu_gfx_mqd_sw_init(adev, sizeof(struct cik_mqd), 0);
> > > +   if (r)
> > > +           return r;
> > > +
> > >
> > >     adev->gfx.ce_ram_size =3D 0x8000;
> > >
> > >     gfx_v7_0_gpu_early_init(adev);
> > >
> > > @@ -4452,7 +4448,7 @@ static int gfx_v7_0_sw_fini(struct amdgpu_ip_bl=
ock
> > > *ip_block)>
> > >     for (i =3D 0; i < adev->gfx.num_compute_rings; i++)
> > >
> > >             amdgpu_ring_fini(&adev->gfx.compute_ring[i]);
> > >
> > > -   gfx_v7_0_cp_compute_fini(adev);
> > > +   amdgpu_gfx_mqd_sw_fini(adev, 0);
> > >
> > >     amdgpu_gfx_rlc_fini(adev);
> > >     gfx_v7_0_mec_fini(adev);
> > >     amdgpu_bo_free_kernel(&adev->gfx.rlc.clear_state_obj,
> >
> > I am assuming all this applies only to compute because gfx is single
> > instance on v7?
>
> It applies only to compute because only compute has HQD/MQD
> on these hardware generations.
>
> > Anyway, it looks plausible to me so assuming you were able to exercise
> > both paths
>
> What do you mean by "both paths"?
>
> Thanks,
> Timur
>
>
