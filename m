Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EACDCC5DF87
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 13:01:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7014310E226;
	Fri, 21 Aug 2026 13:01:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pb6No2s4";
	dkim-atps=neutral
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com
 [209.85.167.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0AB810E226
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 13:01:44 +0000 (UTC)
Received: by mail-oi1-f172.google.com with SMTP id
 5614622812f47-4a453848173so118194b6e.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 06:01:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787317304; cv=none;
 d=google.com; s=arc-20260327;
 b=rvowE7YDkfi5Qwmz29gPQ9Rae1HGByPZ1Z3eTFHtmqsVw/99ZIqE3yR2OerWJqjV0x
 PRCSffaFqg1AuKECPPdpYiQwJjtQ73E/pu2x2D8aAZj7pR88iFYrTjymlMRASbwAN85j
 cApe3AUFD2bNsuXIj1OsimrljzAmsyKg6WvR8HZTSTfDlbm2bdfDnsV00SrYAPHDm6X4
 Vo7rzSab760fqCfDhQ+ac7HYQTJav/Sjy76VpM0WTFPwAiGqs+EaU/A9JQriD6juSmtA
 Kn+dE20jVMb8Hqn9UTdbfRQJY4nqEo0LPLHp4TIqQNwe96Y1vUuYLH6Izr1crd/Rubz3
 JRzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pmBpNo9izKZl3cr6183eoF/4yRYwU/OV1hERej/BX6Q=;
 fh=DzLnC5BbIFaHdkDUOVaQPnjnemygSl5Ge93itfSqX0c=;
 b=DWthf4XtEfySc+Plp1lONd/6PBHyHpHWS75Aly9F/rW9EwMYe3XeGvhNuUvPeM7AVy
 BKM1pPEYfvsu+Xs6JFHPZqwear3k05sdqpDJbsr2rIxEy9dO5jUXubqg6KBLR+ax/97h
 /snXgpIiFK5Gm+ECJvMA+SBPg0TrkhTwJcODz/wGaGcgtLL8GiRdAq9Bhy6Y8qDlgwUz
 ZXadLDckU2nDZKVs6o/xgsBTQbnSkCUp9cr9XXIPM6fDZzbrKoIVu8fFL9EEdw9Bu4zi
 d/NlFn7RH+fCy2egTe67mvQfpJFKQSu3bi4Zw2th9nDCgHFf23O51qNLs7ArUUfi6WIE
 ozIg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787317304; x=1787922104; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pmBpNo9izKZl3cr6183eoF/4yRYwU/OV1hERej/BX6Q=;
 b=pb6No2s44glYiqNd7RJ9Kpm5us0bknEIrL/nTUBMiUTdPZ6MobWrYkuzLdkTlIsI/2
 p1JhMP6HlJEDHwmk7rqj/Jl/bz85ovxAckcaWaofecVLATxZX8QpJ+zfVyvlsSNFmAUD
 G30XxEe47oFavuv0JHDSHBlslQdm3L+S5ctH9fh4XHVj3+ELhp2UpLG/TuD0L4gTP4Vn
 4ob5HHT1ynLylc+x3moQKGo5GkdhQKpQafZE4W1YgqfWg/ek3fvVnC1F1B3SDzTh/UL1
 rBPQrl7xBPERTab6VZnO8Ie5TG+qfTbqw3Cvd9XAivxWSMQ1+0ol1BdrynzWrpN7PD6k
 vwtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787317304; x=1787922104;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pmBpNo9izKZl3cr6183eoF/4yRYwU/OV1hERej/BX6Q=;
 b=EQHrXAXDcsRulnI1Lk3/baHu6VE3kRjVpqHDxkItlkeOkhKQJlq5jCCvrf1hMvv0IO
 aKaC1LjAujv1ITUeqxRvWSbh0lnq9iPOmlxHUFa/s/LFsEmBfJAk0dbcBMHPsflZQ5Po
 fRPwbNcFI9gPFBG74CPYpddrMXESCFXMtogsKnxLk3gBblKPkpn/KMn5ZMRWereXuGEW
 aSSvqcMs+M0KXxwAwKIkaA43oulmiqLpCiwMOiE6rw2eSGW5ZWaqKpifXJWN19hFJByq
 Y3gepi0u1DbYx4p6GIg0T7CISY5cuApchObHYOdNhmYr2qkjf5SWUrBluDtZzJpQ58Ul
 t83A==
X-Gm-Message-State: AOJu0YzkcHZIQ7l0hvdzokBYKNx4bKtiS6JvqYe98IeMnnpUvrkvttpf
 TN0NW8sk0vBa0o8OyG2WVmNaChSOuqVD5hPpSN631T3TCWdSxQEtF1bIUcnji4cNNDmvCzQ/p9l
 lp43Bg/FrSOY1Cgt1NPfqK1B/zlLnpi0=
X-Gm-Gg: AR+sD10XbmPBTLAYGFzRZH+rRj4+WmitCV3DObvWiTvT11wxdvNuS6scD/3JE2JxzJN
 37pZYLycvGaAxoxmA2hBaPtz8kASUyLo/NPfCeAblaCAbzrV8lT4V3qpSrgzHUJi3NkV+VbDoxh
 n0poWZv4n1A6q1smHZtvLC4OZecr2s6sRogRkFgkxBq3+9t0eGeTEM1uttRBBl+AqBpMg6hKE2N
 Rdp25qVJfU7z+cv90HmkrxGdTrJ8SUHu9eP1NCsL0mnsrTCmT6IcwhydAU6kvV2kL9RKhx2muu2
 nilW+5coCAleUA/mIWOFzr2tewsZa55AL0POwaKaYVH9pXvXQZf4zAcV0kTLJe7IxbQIp72RMG4
 1WzMU09q3eZk8FdWN4mYMMNdRRXe/EpM=
X-Received: by 2002:a05:6808:1b0a:b0:4af:5d69:1cb8 with SMTP id
 5614622812f47-4b2eef4b138mr3544042b6e.0.1787317303616; Fri, 21 Aug 2026
 06:01:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260814033302.406402-1-Prike.Liang@amd.com>
 <CADnq5_OMJpBgYYev6nBf7BJD-+WxPc5YS-42vHkxQH_udD5hCQ@mail.gmail.com>
 <DS7PR12MB60058101B79694CFFE687FC8FBA32@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB60058101B79694CFFE687FC8FBA32@DS7PR12MB6005.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 21 Aug 2026 09:01:30 -0400
X-Gm-Features: AcwNN1XJSyqQwxpKv6I3bqIA-bBzL4Y3FqhUH9M-VRKWYJNfsZnbzUwNQ7lRPiE
Message-ID: <CADnq5_OOdb2z_Di1GMNFrJVe2ML7v829rQsd_UKiTqtLJp6tGQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu/userq: fix lock missing for userq fence
 error set
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

On Fri, Aug 21, 2026 at 5:09=E2=80=AFAM Liang, Prike <Prike.Liang@amd.com> =
wrote:
>
> AMD General
>
> Regards,
>       Prike
>
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Wednesday, August 19, 2026 11:52 PM
> > To: Liang, Prike <Prike.Liang@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.co=
m>
> > Subject: Re: [PATCH v2] drm/amdgpu/userq: fix lock missing for userq fe=
nce error
> > set
> >
> > On Thu, Aug 13, 2026 at 11:50=E2=80=AFPM Prike Liang <Prike.Liang@amd.c=
om> wrote:
> > >
> > > amdgpu_userq_fence_driver() and amdgpu_userq_fence_driver_destroy()
> > > don't acquire the dma_fence spinlock, so locking the dma_fence lock
> > > before test the signaled state and set error state.
> > >
> > > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > > ---
> > >  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 20 ++++++++++++-----=
--
> > >  1 file changed, 13 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> > > index 19af1adc2921..09e2079cfdbd 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> > > @@ -191,14 +191,15 @@ void amdgpu_userq_fence_driver_destroy(struct k=
ref
> > *ref)
> > >         struct dma_fence *f;
> > >
> > >         spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
> > > +       lockdep_assert_held(&fence_drv->fence_list_lock);
> > >         list_for_each_entry_safe(fence, tmp, &fence_drv->fences, link=
) {
> > >                 f =3D &fence->base;
> > > -
> > > -               if (!dma_fence_is_signaled(f)) {
> > > +               spin_lock(dma_fence_spinlock(f));
> > > +               if (!dma_fence_is_signaled_locked(f)) {
> > >                         dma_fence_set_error(f, -ECANCELED);
> > > -                       dma_fence_signal(f);
> > > +                       dma_fence_signal_locked(f);
> > >                 }
> > > -
> > > +               spin_unlock(dma_fence_spinlock(f));
> > >                 list_del(&fence->link);
> > >                 dma_fence_put(f);
> > >         }
> > > @@ -423,11 +424,16 @@ amdgpu_userq_fence_driver_set_error(struct
> > amdgpu_userq_fence *fence,
> > >         struct dma_fence *f;
> > >
> > >         spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
> > > -
> > > +       lockdep_assert_held(&fence_drv->fence_list_lock);
> > >         f =3D rcu_dereference_protected(&fence->base,
> > >                                       lockdep_is_held(&fence_drv->fen=
ce_list_lock));
> > > -       if (f && !dma_fence_is_signaled_locked(f))
> > > -               dma_fence_set_error(f, error);
> > > +       if (f) {
> > > +               /* nest f->lock inside fence_list_lock */
> > > +               spin_lock(dma_fence_spinlock(f));
> >
> > Why do we need to take the fence spinlock for userqs, but not for kerne=
l queues?
> > See amdgpu_fence.c
>
> For the kernel queue ring fence, we also need to hold the dma_fence lock =
when calling dma_fence_is_signaled_locked(). The reason that does not asser=
t the lock missing for the kernel ring fence is the .signaled() callback is=
 not implemented, so dma_fence_signal_locked() will never be invoked.
>

Sounds like we need to fix up the kernel queue fences as well.

Acked-by: Alex Deucher <alexander.deucher@amd.com>


> Thanks,
> Prike
>
> > Alex
> >
> > > +               if (!dma_fence_is_signaled_locked(f))
> > > +                       dma_fence_set_error(f, error);
> > > +               spin_unlock(dma_fence_spinlock(f));
> > > +       }
> > >         spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);  =
}
> > >
> > > --
> > > 2.34.1
> > >
