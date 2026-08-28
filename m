Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F55DC61DBD
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 15:52:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B01010F3FE;
	Fri, 28 Aug 2026 15:52:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WMbKkT2Q";
	dkim-atps=neutral
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com
 [209.85.217.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77F5B10F3FE
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 15:52:36 +0000 (UTC)
Received: by mail-vs1-f52.google.com with SMTP id
 ada2fe7eead31-744ca620161so45884137.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 08:52:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787932355; cv=none;
 d=google.com; s=arc-20260327;
 b=oPwT6uPXNMEx2WXhtGOsu+pnfz07j/ZEahRvPqBuTjHtJ61vPt1qOu156ImDZ3GaEI
 hKV3V4mm875+dsR4Z61+4GvRNvz2c3txRGk/fs6wscRFq2gLamo4NiBJVZ+FffAsL6yi
 nMuwsw1QBa7OSY55zXwK+5DYKUgZvcntnmVQlwmtTt6c0T2wDkb/7Zurj1CyXyXvTdjN
 0iK2NnW+9/gclA8Q7KUi6NpK1ybhp7QNBVhoZhTL5iyErpWH+SOXqvu0gN22L14r+yt1
 HAdZHXOH49yPMWQJnmtQ4YOXcSXwEzO8c26Tn1rgHl48RoMeUNulfZmAqGarR08FPpbz
 7bWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9/4cUsnXVH7aYPWMih3Xsqyc5ZC2EuAvhjdYf9WCy8k=;
 fh=baYCDPiUBR/3nZafoZ2xV3+G77EJ/7iRj7HsWpHv9hw=;
 b=PJvv3Y70TQ/LONBcBfFCSH1Ettmh5I9g0HUCl/CU04QZCYOSnoloftepx3g+AtSMfR
 Bir+x6SxOv2J6DHEEJBs/oeZe2Rd2r78d5W68sgatd1gzCDE/yV6huaKMNcqZKrzN4oK
 /avKohEeCbGTfPcTnSzD2uEC0hR/ceLkhYL76bYf86VouItTygPhtSGAhLPOuOtzKBPM
 FX1fwuETjL0QIgLsFhOBTo0rDrk/jn7K14LOgvk8uEhZFKcau/dYHmVYt3DoxQ2br08s
 906pqWKt1IEO//1XIUZ/GeEygcGRSOYcr+jckgmfP28PXjztuObOCBfzSLNMFU2idP7H
 lDcg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787932355; x=1788537155; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9/4cUsnXVH7aYPWMih3Xsqyc5ZC2EuAvhjdYf9WCy8k=;
 b=WMbKkT2Q5Ml52tfuJm79jH3GuIEZ4Mxj7kAqbiXmr+SfPG0JZ25ohAs68vVXXQC7y4
 B0DLJ8qJom8kDoMxPpdVsnAlTp5DjwYCXOWyc41BB3eqnF4WS2IyXI1Bt/gug7ReAXXu
 SuXBDWPPd5iz6AOsUGUOJ+zNq13DZl0xXXuDP40Oa+AAOhNXyiQ6Mq99/yZAue3XBLhL
 okbshbCP8wtCWUXs8icd1UwN6xrlUmv/tEbJa+5dJCzH+0k77iZ0lAZ9MdxmqNKDW4zq
 B1zcFtF3fjJnz8WaDpW5Uc3N4CzW5aJGfZNz7FedPLHEHv3vzkIYpX0Q9k/XcDgYJv1v
 rVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787932355; x=1788537155;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9/4cUsnXVH7aYPWMih3Xsqyc5ZC2EuAvhjdYf9WCy8k=;
 b=brDlzoKd7nylFIxYtFaFTlwLwrL2XlBGlTSsM+vrJV4fCQSPJ1W/XTVe0DA1nFZGCE
 UN6+aba50cmn1QejNrpS6xKik41qCeOBnetn/7sve45bxMTBZuiQcbFIcYTDUHEkD/OF
 RSEhGbhifKcDcU7KOeiQfTtA47ftIoB5JQWUmq3lIHQ+zLjUH8BLbi60fDJaceIa2rEY
 mV4Lq3q6oNwvKF9fh+r23BlRfOBW08lEw72qYyqjBGC6MuFBdPkZMGaz84SPdYHbZXXy
 WkjNFjfqCzRNqvkyW+6GNm80WAF/v8Hg8tNeByNBOHKH55WIJ0gE9tMshU0tAXR1XIPj
 jtxg==
X-Gm-Message-State: AFuF++mRMEJYUG3UvE/+ZfQn3TIG5XFbNK6VEiV1uKOWspCVZPaptIKD
 XShkA6EobirqtrkAy9I1jK6dEn91TFFtvYmMsXAAVpnINEG/DccIGsNHiPGNVnYaoumTr4zyIgd
 uI4Nc6L5AvhgUpZNnwAbDTby6bUASAPo=
X-Gm-Gg: AR+sD105kgF2OErLY6+fTthOUt5amPE2q+9ys6yYbbb8qA51GFFd2M3GDwjnrxLE53P
 PRWtLVUgEzoR0LOBqySLV4XmhWy5p0itLH+4qacWRM3kAMkCcpW3hnjZwGk9c/Knd3sbNYqGrVQ
 HXwITsdJ3rODcFAtgRiprtrbPgC5vKWpieQxZZ1cmRsdZmSURdLTUEVGUNZ4jmOAHYyyYYV6Yok
 YARp4bVv8+o0vlvOxa81L54EWYubwTcs5F39EbzuYqmMugUA3G4betAntk49E6ryV0S94ihefup
 t+MlL0qk7B342W9zHAEexDf4idtllTiXnyI/j+3voTNGwr7sQ7lzQyUmX/xiNFON7lZh7SVqRm9
 zkqU1d4uxwgNymuPnDm//zLRu9v1fAkKJ
X-Received: by 2002:a05:6102:868b:20b0:786:d38d:f7c2 with SMTP id
 ada2fe7eead31-786d38e1dc9mr52599137.1.1787932355303; Fri, 28 Aug 2026
 08:52:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260828120729.25908-1-timur.kristof@gmail.com>
 <20260828120729.25908-4-timur.kristof@gmail.com>
 <032550fc-5680-4f6c-974c-fe96cc8083e1@amd.com>
 <EhsDbURtRYeOUXN6bnOG9Q@gmail.com>
In-Reply-To: <EhsDbURtRYeOUXN6bnOG9Q@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 28 Aug 2026 11:52:22 -0400
X-Gm-Features: AcwNN1UtDYl76DO4g3dN3FRTejHAKdslM4NcmUk7uYIFqd2ua4Hm73fOoC74dK0
Message-ID: <CADnq5_M9yN5zMm63PAhLpk_QzfKgmqknhRv6MvH0HKWJYXNQDA@mail.gmail.com>
Subject: Re: [PATCH 3/5] drm/amdgpu/sdma: Move SDMA v5.x queue reset to common
 code
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Natalie Vock <natalie.vock@gmx.de>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>, 
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Felix Kuehling <Felix.Kuehling@amd.com>, "Lazar, Lijo" <lijo.lazar@amd.com>
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

On Fri, Aug 28, 2026 at 11:45=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@=
gmail.com> wrote:
>
> On Friday, August 28, 2026 4:20:19=E2=80=AFPM Central European Summer Tim=
e Lazar, Lijo
> wrote:
> > On 28-Aug-26 5:37 PM, Timur Krist=C3=B3f wrote:
> > > The code was exactly the same between SDMA v5.0 and v5.2
> > > furthermore the exact same implementation can be shared
> > > between all SDMA versions that don't use MES.
> > >
> > > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > > ---
> > >
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 37 +++++++++++++++++++++=
+++
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  4 +++
> > >   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 25 +---------------
> > >   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 25 +---------------
> > >   4 files changed, 43 insertions(+), 48 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c index
> > > 66f278f77f71..9eebd8380834 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> > > @@ -635,3 +635,40 @@ int amdgpu_sdma_reset_engine(struct amdgpu_devic=
e
> > > *adev, uint32_t instance_id,>
> > >     return ret;
> > >
> > >   }
> > >
> > > +
> > > +/**
> > > + * amdgpu_sdma_reset_queue_legacy() - Reset legacy SDMA queue after
> > > timeout (without MES) + *
> > > + * @ring: Pointer to the ring of the SDMA queue
> > > + * @vmid: VMID of the timed out job
> > > + * @timedout_fence: Fence of the timed out job
> > > + *
> > > + * Common implementation for resetting SDMA queues without MES (lega=
cy).
> > > + * This relies on the proper amdgpu_sdma_funcs to be set up
> > > + * for the given ring.
> > > + *
> > > + * Applicable to SDMA versions that don't rely on the MES yet,
> > > + * that is all versions up to SDMA v5.x and older.
> > > + */
> > > +int amdgpu_sdma_reset_queue_legacy(struct amdgpu_ring *ring,
> > > +                              unsigned int vmid,
> > > +                              struct amdgpu_fence
> *timedout_fence)
> > > +{
> > > +   struct amdgpu_device *adev =3D ring->adev;
> > > +   int r;
> > > +
> > > +   if (ring->me >=3D adev->sdma.num_instances) {
> > > +           dev_err(adev->dev, "sdma instance not found\n");
> > > +           return -EINVAL;
> > > +   }
> > > +
> > > +   amdgpu_ring_reset_helper_begin(ring, timedout_fence);
> > > +
> > > +   amdgpu_amdkfd_suspend(adev, true);
> > > +   r =3D amdgpu_sdma_reset_engine(adev, ring->me, true);
> > > +   amdgpu_amdkfd_resume(adev, true);
> > > +   if (r)
> > > +           return r;
> > > +
> > > +   return amdgpu_ring_reset_helper_end(ring, timedout_fence);
> > > +}
> >
> > Instead of moving it here - sdma_v5_x_reset_queue and using it for 5.2
> > is better. This may not work in the same way for all legacy queues.
> >
> > Thanks,
> > Lijo
>
> Hi,
>
> As far as I see, this function can be reused for all generations that don=
't
> use MES. If you don't think so, please explain why not.

I think the context is missing that you want to extend this to older
generations as well and it's still applicable there.

Alex

>
> Thanks,
> Timur
>
> >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h index
> > > 4f4e56022c97..7c4e145ca0c1 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> > > @@ -160,6 +160,10 @@ struct amdgpu_buffer_funcs {
> > >
> > >   int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t
> > >   instance_id,>
> > >                          bool caller_handles_kernel_queues);
> > >
> > > +int amdgpu_sdma_reset_queue_legacy(struct amdgpu_ring *ring,
> > > +                              unsigned int vmid,
> > > +                              struct amdgpu_fence
> *timedout_fence);
> > > +
> > >
> > >   #define amdgpu_emit_copy_buffer(adev, ib, s, d, b, t)
> > >   (adev)->mman.buffer_funcs->emit_copy_buffer((ib),  (s), (d), (b), (=
t))
> > >   #define amdgpu_emit_fill_buffer(adev, ib, s, d, b)
> > >   (adev)->mman.buffer_funcs->emit_fill_buffer((ib), (s), (d), (b))>
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> > > b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c index 0da54c335822..76f8765f=
b175
> > > 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> > > @@ -1518,29 +1518,6 @@ static int sdma_v5_0_wait_for_idle(struct
> > > amdgpu_ip_block *ip_block)>
> > >     return -ETIMEDOUT;
> > >
> > >   }
> > >
> > > -static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring,
> > > -                            unsigned int vmid,
> > > -                            struct amdgpu_fence
> *timedout_fence)
> > > -{
> > > -   struct amdgpu_device *adev =3D ring->adev;
> > > -   int r;
> > > -
> > > -   if (ring->me >=3D adev->sdma.num_instances) {
> > > -           dev_err(adev->dev, "sdma instance not found\n");
> > > -           return -EINVAL;
> > > -   }
> > > -
> > > -   amdgpu_ring_reset_helper_begin(ring, timedout_fence);
> > > -
> > > -   amdgpu_amdkfd_suspend(adev, true);
> > > -   r =3D amdgpu_sdma_reset_engine(adev, ring->me, true);
> > > -   amdgpu_amdkfd_resume(adev, true);
> > > -   if (r)
> > > -           return r;
> > > -
> > > -   return amdgpu_ring_reset_helper_end(ring, timedout_fence);
> > > -}
> > > -
> > >
> > >   static int sdma_v5_0_stop_queue(struct amdgpu_ring *ring)
> > >   {
> > >
> > >     u32 f32_cntl, freeze, cntl, stat1_reg;
> > >
> > > @@ -1936,7 +1913,7 @@ static const struct amdgpu_ring_funcs
> > > sdma_v5_0_ring_funcs =3D {>
> > >     .emit_reg_write_reg_wait =3D
> sdma_v5_0_ring_emit_reg_write_reg_wait,
> > >     .init_cond_exec =3D sdma_v5_0_ring_init_cond_exec,
> > >     .preempt_ib =3D sdma_v5_0_ring_preempt_ib,
> > >
> > > -   .reset =3D sdma_v5_0_reset_queue,
> > > +   .reset =3D amdgpu_sdma_reset_queue_legacy,
> > >
> > >   };
> > >
> > >   static void sdma_v5_0_set_ring_funcs(struct amdgpu_device *adev)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > > b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c index 5543e381dcca..e7f4b74f=
27b4
> > > 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > > @@ -1436,29 +1436,6 @@ static int sdma_v5_2_wait_for_idle(struct
> > > amdgpu_ip_block *ip_block)>
> > >     return -ETIMEDOUT;
> > >
> > >   }
> > >
> > > -static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring,
> > > -                            unsigned int vmid,
> > > -                            struct amdgpu_fence
> *timedout_fence)
> > > -{
> > > -   struct amdgpu_device *adev =3D ring->adev;
> > > -   int r;
> > > -
> > > -   if (ring->me >=3D adev->sdma.num_instances) {
> > > -           dev_err(adev->dev, "sdma instance not found\n");
> > > -           return -EINVAL;
> > > -   }
> > > -
> > > -   amdgpu_ring_reset_helper_begin(ring, timedout_fence);
> > > -
> > > -   amdgpu_amdkfd_suspend(adev, true);
> > > -   r =3D amdgpu_sdma_reset_engine(adev, ring->me, true);
> > > -   amdgpu_amdkfd_resume(adev, true);
> > > -   if (r)
> > > -           return r;
> > > -
> > > -   return amdgpu_ring_reset_helper_end(ring, timedout_fence);
> > > -}
> > > -
> > >
> > >   static int sdma_v5_2_stop_queue(struct amdgpu_ring *ring)
> > >   {
> > >
> > >     u32 f32_cntl, freeze, cntl, stat1_reg;
> > >
> > > @@ -1951,7 +1928,7 @@ static const struct amdgpu_ring_funcs
> > > sdma_v5_2_ring_funcs =3D {>
> > >     .emit_reg_write_reg_wait =3D
> sdma_v5_2_ring_emit_reg_write_reg_wait,
> > >     .init_cond_exec =3D sdma_v5_2_ring_init_cond_exec,
> > >     .preempt_ib =3D sdma_v5_2_ring_preempt_ib,
> > >
> > > -   .reset =3D sdma_v5_2_reset_queue,
> > > +   .reset =3D amdgpu_sdma_reset_queue_legacy,
> > >
> > >   };
> > >
> > >   static void sdma_v5_2_set_ring_funcs(struct amdgpu_device *adev)
>
>
>
>
