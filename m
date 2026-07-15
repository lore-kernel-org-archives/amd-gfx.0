Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B08EC44507
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 21:30:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A252B10E23C;
	Wed, 15 Jul 2026 21:30:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P6YRF9HJ";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45E6010E23C
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 21:30:30 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-47d6c634f45so3371151f8f.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 14:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784151028; x=1784755828; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LwlQSPOgkerOqjoBQpU0A9UsHYlMPyhkUSdfQ/Sb0xQ=;
 b=P6YRF9HJmwTLRT3XvuMdfkLoi49Kobent943NiANqUZi9DTF0/0UTLgb5A6TZkaCEl
 grb7loomDC9uiN5LQw9f8+v98wRtzzc9ppjJYaCN6hV1K95tkiIK5uWfqSX38wGAO4WW
 S6iY53IonpV3IIs2Kmy9rtpuJ+RdnKQhjX0+45eaxAmhDJgF/owUJkmFMt31haaawOG5
 yeeLE+uZnahlGnDOvI9NiMU5kHN05DMo1GaCnKBlvF4P7hjwk/yOVj3fnJGyL6DwVSKJ
 R54Hsmq3f9oyWZLnQS3JAi6PAstFu1eFi2SwmTfHGnLF3FBAQzV6YKXYkCpq/2xmPfhO
 Cjeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784151028; x=1784755828;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LwlQSPOgkerOqjoBQpU0A9UsHYlMPyhkUSdfQ/Sb0xQ=;
 b=AyIPSmhkGnZ8Ymv6S0iERT2HScVUQRkz3sXRtDX2FMLsYWAiAboPQZJdb2nEy9+rKK
 g5t9Tog5Dc9vimKa5aU19V9Nd24jvAeJA7oW0VkQZHYd029aZKz8kPpVXPHBA7qTJuKk
 xas9RMGHSZz9qJ1SbTbKo0TjnBbmtU25iA3PdgG0u0IQkz/yfpxRnONM0hglQZlmrU+g
 CywJxU8hdH7C4EXksmr0YD9xGuee1FIg6Av57bCELOs6LIPc35TVPTt9Tw994VJ1sBdf
 i9QOf02o8wDr4RTI2PT5GdrdkwujrIYf7d1sp/mLaQEIuIkBncHA3bQXUjIUHSXIo5n9
 FY/g==
X-Gm-Message-State: AOJu0YwybrwqAUeWXfy7xxsWrIM8DR3B8BnDKbBNJxcE+oPQuH53UDzx
 zu6xkV8whgpJ8MhKAaz7YCNDF3+W8riHF5xQHaWdVwmyfg3k3ce8QB+B
X-Gm-Gg: AfdE7clzUbFClp4MnhCwzxVwkaX5HiE/TByay3BkmUqisLxyCa3BYDyTG+xFrOXhudY
 p0XWFJ9gicgHTpnX2IqLJQUC/EXsgQvapDfcQ9E6JKbDgIPnN4VpntJRg0vo0ynAJFaFGzoTmMv
 VqGqEk1TXxTGN0QZXOQauzSJxPxayzNk2hxaFEP1sPfIef3F64LsWVizsQfxGKfnhLcQ90EhWR1
 P5jOZFUiyDFDMrBMsghGFYd1f8tzPyrAhQzCHSswdROpHQB9bRk1bkuEIK+CQwvSYz16QHI3NIm
 wAaTavkcfFt8vhEN4wp8FXQj+r+91xUdffHzcdHQNOObBAxzygsdgpzkBhKMURpAzGnHm7L3qAT
 SFJcPQBfLydDhPM7eFlJqOODy1v37sy+EevBFUCVJMwCCeSop8lTgVZ/l/KyjPA6KMu9k1kLH6M
 stPwwfwUoeKRTadpxxa0t6pt1iWMoHn4m6+PIskY3jtW+0pVMe0/5pCMfUFy61d1P6qRA73uC5k
 e7YWWbX
X-Received: by 2002:a5d:59a4:0:b0:472:67de:27ca with SMTP id
 ffacd0b85a97d-47f488bf7afmr10043916f8f.41.1784151028398; 
 Wed, 15 Jul 2026 14:30:28 -0700 (PDT)
Received: from timur-max.localnet
 (20014C4E24CD7200F6BBA872344E1A32.dsl.pool.telekom.hu.
 [2001:4c4e:24cd:7200:f6bb:a872:344e:1a32])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f47688f29sm17091431f8f.21.2026.07.15.14.30.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 14:30:27 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, Tvrtko Ursulin <tursulin@ursulin.net>
Subject: Re: [PATCH 2/9] drm/amdgpu/gfx7: Refactor MQD initialization and
 finalization
Date: Wed, 15 Jul 2026 23:30:26 +0200
Message-ID: <10038148.V6nBDHxoPA@timur-max>
In-Reply-To: <CADnq5_N=xveePDCw_3XX1M7pc1P5Oh54KO0KtXVzeXH9X3NfuA@mail.gmail.com>
References: <20260713125838.30607-1-timur.kristof@gmail.com>
 <13037802.F6SAcFxjWL@timur-max>
 <CADnq5_N=xveePDCw_3XX1M7pc1P5Oh54KO0KtXVzeXH9X3NfuA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On 2026. j=C3=BAlius 15., szerda 23:10:02 k=C3=B6z=C3=A9p-eur=C3=B3pai ny=
=C3=A1ri id=C5=91 Alex Deucher=20
wrote:
> On Wed, Jul 15, 2026 at 4:32=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof=
@gmail.com>=20
wrote:
> > On 2026. j=C3=BAlius 15., szerda 21:50:53 k=C3=B6z=C3=A9p-eur=C3=B3pai =
ny=C3=A1ri id=C5=91 Alex Deucher
> >=20
> > wrote:
> > > On Wed, Jul 15, 2026 at 11:54=E2=80=AFAM Timur Krist=C3=B3f <timur.kr=
istof@gmail.com>
> >=20
> > wrote:
> > > > On 2026. j=C3=BAlius 14., kedd 20:47:14 k=C3=B6z=C3=A9p-eur=C3=B3pa=
i ny=C3=A1ri id=C5=91 Tvrtko
> > > > Ursulin
> > > >=20
> > > > wrote:
> > > > > On 13/07/2026 13:58, Timur Krist=C3=B3f wrote:
> > > > > > Call amdgpu_gfx_mqd_sw_init()/_fini() on GFX7 to initialize and
> > > > > > finalize the MQD, just like GFX8 and newer; instead of doing
> > > > > > an ad-hoc BO allocation. This introduces the possibility of
> > > > > > doing an MQD backup instead of trying to reinitialize the
> > > > > > MQD every time.
> > > > > >=20
> > > > > > This solves an issue with GFX IP block soft reset where
> > > > > > all compute rings would hang after the reset.
> > > > > >=20
> > > > > > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > > > > > ---
> > > > > >=20
> > > > > >   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 106
> > > > > >   +++++++++++++-------------
> > > > > >   1 file changed, 51 insertions(+), 55 deletions(-)
> > > > > >=20
> > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> > > > > > b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c index
> > > > > > 65b8497ad5f0..9c4b3ac27e1f
> > > > > > 100644
> > > > > > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> > > > > > @@ -2698,25 +2698,6 @@ static int
> > > > > > gfx_v7_0_cp_compute_load_microcode(struct amdgpu_device *adev)>
> > > > > >=20
> > > > > >     return 0;
> > > > > >  =20
> > > > > >   }
> > > > > >=20
> > > > > > -/**
> > > > > > - * gfx_v7_0_cp_compute_fini - stop the compute queues
> > > > > > - *
> > > > > > - * @adev: amdgpu_device pointer
> > > > > > - *
> > > > > > - * Stop the compute queues and tear down the driver queue
> > > > > > - * info.
> > > > > > - */
> > > > > > -static void gfx_v7_0_cp_compute_fini(struct amdgpu_device *ade=
v)
> > > > > > -{
> > > > > > -   int i;
> > > > > > -
> > > > > > -   for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
> > > > > > -           struct amdgpu_ring *ring =3D &adev->gfx.compute_rin=
g[i];
> > > > > > -
> > > > > > -           amdgpu_bo_free_kernel(&ring->mqd_obj, NULL, NULL);
> > > > > > -   }
> > > > > > -}
> > > > > > -
> > > > > >=20
> > > > > >   static void gfx_v7_0_mec_fini(struct amdgpu_device *adev)
> > > > > >   {
> > > > > >  =20
> > > > > >     amdgpu_bo_free_kernel(&adev->gfx.mec.hpd_eop_obj, NULL, NUL=
L);
> > > > > >=20
> > > > > > @@ -2788,28 +2769,29 @@ static void
> > > > > > gfx_v7_0_compute_pipe_init(struct
> > > > > > amdgpu_device *adev,>
> > > > > >=20
> > > > > >     mutex_unlock(&adev->srbm_mutex);
> > > > > >  =20
> > > > > >   }
> > > > > >=20
> > > > > > -static int gfx_v7_0_mqd_deactivate(struct amdgpu_device *adev)
> > > > > > +static int gfx_v7_0_mqd_deactivate(struct amdgpu_device *adev,
> > > > > > u32
> > > > > > req)
> > > > > >=20
> > > > > >   {
> > > > > >=20
> > > > > > -   int i;
> > > > > > +   int i, r =3D 0;
> > > > > >=20
> > > > > >     /* disable the queue if it's active */
> > > > > >=20
> > > > > > -   if (RREG32(mmCP_HQD_ACTIVE) & 1) {
> > > > > > -           WREG32(mmCP_HQD_DEQUEUE_REQUEST, 1);
> > > > > > +   if (RREG32(mmCP_HQD_ACTIVE) & CP_HQD_ACTIVE__ACTIVE_MASK) {
> > > > > > +           WREG32_FIELD(CP_HQD_DEQUEUE_REQUEST, DEQUEUE_REQ,
> > > > > > req);
> > > > > >=20
> > > > > >             for (i =3D 0; i < adev->usec_timeout; i++) {
> > > > > >=20
> > > > > > -                   if (!(RREG32(mmCP_HQD_ACTIVE) & 1))
> > > > > > +                   if (!(RREG32(mmCP_HQD_ACTIVE) &
> > > >=20
> > > > CP_HQD_ACTIVE__ACTIVE_MASK))
> > > >=20
> > > > > >                             break;
> > > > > >                    =20
> > > > > >                     udelay(1);
> > > > > >            =20
> > > > > >             }
> > > > > >            =20
> > > > > >             if (i =3D=3D adev->usec_timeout)
> > > > > >=20
> > > > > > -                   return -ETIMEDOUT;
> > > > > > +                   r =3D -ETIMEDOUT;
> > > > > >=20
> > > > > > -           WREG32(mmCP_HQD_DEQUEUE_REQUEST, 0);
> > > > > > -           WREG32(mmCP_HQD_PQ_RPTR, 0);
> > > > > > -           WREG32(mmCP_HQD_PQ_WPTR, 0);
> > > > > >=20
> > > > > >     }
> > > > > >=20
> > > > > > -   return 0;
> > > > > > +   WREG32(mmCP_HQD_DEQUEUE_REQUEST, 0);
> > > > > > +   WREG32(mmCP_HQD_PQ_RPTR, 0);
> > > > > > +   WREG32(mmCP_HQD_PQ_WPTR, 0);
> > > > > > +
> > > > > > +   return r;
> > > > >=20
> > > > > I can see this matches gfx_v8_0_deactivate_hqd. If I am not missi=
ng
> > > > > anything only to replace the hardcoded 1 with
> > > > > CP_HQD_ACTIVE__ACTIVE_MASK?
> > > >=20
> > > > There are two changes here:
> > > > - Replacing the hardcoded "1" with the define from the register
> > > > definition
> > > > - When it times out, still write the CP_HQD_ registers afterwards l=
ike
> > > > gfx8
> > > >=20
> > > > > Is it okay to call the function mqd if the registers are hqd and =
is
> > > > > v7
> > > > > or v8 (which calls it hqd) more correct? Not saying either way, j=
ust
> > > > > observing a curiosity.
> > > >=20
> > > > My best guess is that it's just that they used a different naming
> > > > convention and forgot to update the older code.
> > >=20
> > > Technically, the MQD (Memory Queue Descriptor) and HQD (Hardware Queue
> > > Descriptor) are separate things.  The MQD is a structure stored in
> > > memory which stores the state of a queue.  The HQD is the hardware
> > > state which stores the queue when it's mapped to hardware.  The way
> > > it's supposed to work is that the driver sets up MQDs in memory and
> > > then asks KIQ to map those queues to an HQD or put them on a runlist
> > > (for user queues) if there are more MQDs than HQDs.  For gfx8 and
> > > newer the driver sets up the MQD and then uses the KIQ to map the
> > > queues.  gfx7 could work that way as well, but we never got around to
> > > porting the changes back to gfx7.  Instead the driver maps the queues
> > > to the HQD directly via MMIO rather than having KIQ do it on gfx7.
> > >=20
> > > Alex
> >=20
> > As far as I understood, Tvrtko's point was why the function is called
> > gfx_v7_0_mqd_deactivate() when what it does is the same as
> > gfx_v8_0_deactivate_hqd(), ie. why does one have MQD in the name while =
the
> > other has HQD in the name.
>=20
> I don't remember why it's named like that, but deactivate_hqd() is
> better aligned with what it actually does.  This is effectively the
> MMIO equivalent of submitting an unmap queue packet to the KIQ.
>=20
> Alex

Would it be OK if I renamed it?
gfx_v7_0_mqd_deactivate() --> gfx_v7_0_deactivate_hqd()
to better align it with gfx8 and ease the confusion.


>=20
> > > > > >   }
> > > > > >  =20
> > > > > >   static void gfx_v7_0_mqd_init(struct amdgpu_device *adev,
> > > > > >=20
> > > > > > @@ -2964,31 +2946,42 @@ static int gfx_v7_0_mqd_commit(struct
> > > > > > amdgpu_device *adev, struct cik_mqd *mqd)>
> > > > > >=20
> > > > > >   static int gfx_v7_0_compute_queue_init(struct amdgpu_device
> > > > > >   *adev,
> > > > > >   int
> > > > > >   ring_id) {
> > > > > >=20
> > > > > > -   int r;
> > > > > > -   u64 mqd_gpu_addr;
> > > > > > -   struct cik_mqd *mqd;
> > > > > >=20
> > > > > >     struct amdgpu_ring *ring =3D &adev->gfx.compute_ring[ring_i=
d];
> > > > > >=20
> > > > > > -
> > > > > > -   r =3D amdgpu_bo_create_reserved(adev, sizeof(struct cik_mqd=
),
> > > >=20
> > > > PAGE_SIZE,
> > > >=20
> > > > > > -                                 AMDGPU_GEM_DOMAIN_GTT,
> > > >=20
> > > > &ring->mqd_obj,
> > > >=20
> > > > > > -                                 &mqd_gpu_addr, (void
> > > >=20
> > > > **)&mqd);
> > > >=20
> > > > > > -   if (r) {
> > > > > > -           dev_warn(adev->dev, "(%d) create MQD bo failed\n", =
r);
> > > > > > -           return r;
> > > > > > +   struct cik_mqd *mqd =3D ring->mqd_ptr;
> > > > > > +   int mqd_idx =3D ring - &adev->gfx.compute_ring[0];
> > > > > > +
> > > > > > +   if (!amdgpu_in_reset(adev) && !adev->in_suspend) {
> > > > > > +           memset((void *)mqd, 0, ring->mqd_size);
> > > > > > +           mutex_lock(&adev->srbm_mutex);
> > > > > > +           cik_srbm_select(adev, ring->me, ring->pipe, ring-
> > > > >
> > > > >queue, 0);
> > > > >
> > > > > > +           gfx_v7_0_mqd_init(adev, mqd, ring->mqd_gpu_addr,
> > > > > > ring);
> > > > > > +           gfx_v7_0_mqd_deactivate(adev, 1);
> > > > > > +           gfx_v7_0_mqd_commit(adev, mqd);
> > > > > > +           cik_srbm_select(adev, 0, 0, 0, 0);
> > > > > > +           mutex_unlock(&adev->srbm_mutex);
> > > > > > +
> > > > > > +           if (adev->gfx.mec.mqd_backup[mqd_idx])
> > > > > > +                   memcpy(adev->gfx.mec.mqd_backup[mqd_idx],
> > > >=20
> > > > mqd, ring->mqd_size);
> > > >=20
> > > > > > +   } else {
> > > > > > +           /* restore MQD to a clean status */
> > > > > > +           if (adev->gfx.mec.mqd_backup[mqd_idx])
> > > > > > +                   memcpy(mqd, adev-
> > > > >
> > > > >gfx.mec.mqd_backup[mqd_idx], ring->mqd_size);
> > > > >
> > > > > > +
> > > > > > +           /* Re-commit the restored backup */
> > > > > > +           mutex_lock(&adev->srbm_mutex);
> > > > > > +           cik_srbm_select(adev, ring->me, ring->pipe, ring-
> > > > >
> > > > >queue, 0);
> > > > >
> > > > > > +           gfx_v7_0_mqd_deactivate(adev, 2);
> > > > > > +           gfx_v7_0_mqd_commit(adev, mqd);
> > > > > > +           cik_srbm_select(adev, 0, 0, 0, 0);
> > > > > > +           mutex_unlock(&adev->srbm_mutex);
> > > > > > +
> > > > > > +           /* reset ring buffer */
> > > > > > +           ring->wptr =3D 0;
> > > > > > +           atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0);
> > > > > > +           atomic64_set((atomic64_t *)ring->rptr_cpu_addr, 0);
> > > > > > +           amdgpu_ring_clear_ring(ring);
> > > > > >=20
> > > > > >     }
> > > > > >=20
> > > > > > -   mutex_lock(&adev->srbm_mutex);
> > > > > > -   cik_srbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
> > > > > > -
> > > > > > -   gfx_v7_0_mqd_init(adev, mqd, mqd_gpu_addr, ring);
> > > > > > -   gfx_v7_0_mqd_deactivate(adev);
> > > > > > -   gfx_v7_0_mqd_commit(adev, mqd);
> > > > > > -
> > > > > > -   cik_srbm_select(adev, 0, 0, 0, 0);
> > > > > > -   mutex_unlock(&adev->srbm_mutex);
> > > > > > -
> > > > > > -   amdgpu_bo_kunmap(ring->mqd_obj);
> > > > > > -   amdgpu_bo_unreserve(ring->mqd_obj);
> > > > > >=20
> > > > > >     return 0;
> > > > > >  =20
> > > > > >   }
> > > > >=20
> > > > > I think I can follow this - only the wptr and rptr reset is a bit
> > > > > different than what v8 does it. Any specific reason? Gfx9 then
> > > > > reverts
> > > > > back to a single ring->wptr =3D 0. I guess v8 is somehow special?
> > > > >=20
> > > > > > @@ -3020,10 +3013,8 @@ static int
> > > > > > gfx_v7_0_cp_compute_resume(struct
> > > > > > amdgpu_device *adev)>
> > > > > >=20
> > > > > >     /* init the queues */
> > > > > >     for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
> > > > > >    =20
> > > > > >             r =3D gfx_v7_0_compute_queue_init(adev, i);
> > > > > >=20
> > > > > > -           if (r) {
> > > > > > -                   gfx_v7_0_cp_compute_fini(adev);
> > > > > > +           if (r)
> > > > > >=20
> > > > > >                     return r;
> > > > > >=20
> > > > > > -           }
> > > > > >=20
> > > > > >     }
> > > > > >    =20
> > > > > >     gfx_v7_0_cp_compute_enable(adev, true);
> > > > > >=20
> > > > > > @@ -4430,6 +4421,11 @@ static int gfx_v7_0_sw_init(struct
> > > > > > amdgpu_ip_block
> > > > > > *ip_block)>
> > > > > >=20
> > > > > >             }
> > > > > >    =20
> > > > > >     }
> > > > > >=20
> > > > > > +   /* create MQD for all compute queues */
> > > > > > +   r =3D amdgpu_gfx_mqd_sw_init(adev, sizeof(struct cik_mqd), =
0);
> > > > > > +   if (r)
> > > > > > +           return r;
> > > > > > +
> > > > > >=20
> > > > > >     adev->gfx.ce_ram_size =3D 0x8000;
> > > > > >    =20
> > > > > >     gfx_v7_0_gpu_early_init(adev);
> > > > > >=20
> > > > > > @@ -4452,7 +4448,7 @@ static int gfx_v7_0_sw_fini(struct
> > > > > > amdgpu_ip_block
> > > > > > *ip_block)>
> > > > > >=20
> > > > > >     for (i =3D 0; i < adev->gfx.num_compute_rings; i++)
> > > > > >    =20
> > > > > >             amdgpu_ring_fini(&adev->gfx.compute_ring[i]);
> > > > > >=20
> > > > > > -   gfx_v7_0_cp_compute_fini(adev);
> > > > > > +   amdgpu_gfx_mqd_sw_fini(adev, 0);
> > > > > >=20
> > > > > >     amdgpu_gfx_rlc_fini(adev);
> > > > > >     gfx_v7_0_mec_fini(adev);
> > > > > >     amdgpu_bo_free_kernel(&adev->gfx.rlc.clear_state_obj,
> > > > >=20
> > > > > I am assuming all this applies only to compute because gfx is sin=
gle
> > > > > instance on v7?
> > > >=20
> > > > It applies only to compute because only compute has HQD/MQD
> > > > on these hardware generations.
> > > >=20
> > > > > Anyway, it looks plausible to me so assuming you were able to
> > > > > exercise
> > > > > both paths
> > > >=20
> > > > What do you mean by "both paths"?
> > > >=20
> > > > Thanks,
> > > > Timur




