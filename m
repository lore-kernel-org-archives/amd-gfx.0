Return-Path: <SRS0=SMOw=MZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B169C4338F
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Aug 2021 13:35:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0429360FA0
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Aug 2021 13:35:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0429360FA0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FA026E503;
	Mon,  2 Aug 2021 13:35:34 +0000 (UTC)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 566786E183
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Aug 2021 13:35:32 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 c7-20020a9d27870000b02904d360fbc71bso17419701otb.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Aug 2021 06:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=VDbVDsxQMfHITye1FB7mIgqO0izs3K855owQgND4yBE=;
 b=BuWZ54e5rETXMtGAFCaxoX83IMX3X8twUs/7ZBNdofGMoYOLILbb9hca9NHwMZcpMW
 RIlvGO75o3CLFfUOiWPoZMwCwvBgKAdka+UXwE6gZ0NNY3BFt4fZpS5lja+4Rc0MrC9m
 JvbA6sfDT4F0mRFw3x/nSSM5QkjQAbHdXaO3AkeCMrmDiFyxzjUaXjG4bCQ5Hpczmm6e
 u+ErtoSN5PIiNBwnqxTVh//hjscTDNIsTFMudvMqPiRdFGgBIakszg252x0tUBXbIXUd
 fqTZG6dMtwo/V9Plxom5rfQ9OI1ygbsNIuO16PxbxW5/u3kZ0Al/GEWNo0AXBmYTmr5N
 ZAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=VDbVDsxQMfHITye1FB7mIgqO0izs3K855owQgND4yBE=;
 b=MvBJw0bn7+CYy6HPQ33Pm7SSSvFtiQ4LxY2KSfE+y/S9+iNPiEO9/Xu+b9WL9BFwgk
 8HoOFm6yV1NW45IZHOa1QcJ9OIK4T/wbJBtLhEJaoVEFyBp6UqNJJOSnf8L5jIUjFWNZ
 L/2Um/VwFxq8uxGF4UEtQolhqO9GlCGhvuVG8eSdG/wH5C3ExvgXa3uwN4uVpCuVScFi
 axmtOUbXrOKttRlGuixx3R+znEeC4xZ4zJPAR4BG+4osUE79hMjzcqa1N1xlxNgrWWU7
 Q53NZ2YZycvoqgbCr4BfUoJ/OuROWjunHHx1acR6w1XL6UHHO65uS8wU7PCJZHSJKWq/
 Tj5g==
X-Gm-Message-State: AOAM531XNHmZf/DhelUBlUnasQd/1xPL3MqdbLzz0wN3XIYmIw13th9y
 QLnCFJeH+h5+ja5LMYKp04t5qFvnbUazvaWqTVQ=
X-Google-Smtp-Source: ABdhPJy+gyLPFI1x737d+uTdXz9E6I2zw2MayBQv45IFvNa5RY/aB+9AkvSX30FtZF5n3yTe2WE2xAX2JwvhO8Ie3VE=
X-Received: by 2002:a9d:2072:: with SMTP id
 n105mr12184952ota.132.1627911331865; 
 Mon, 02 Aug 2021 06:35:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210802051602.23822-1-guchun.chen@amd.com>
 <b7218d98-9eb1-2d41-157a-bc417ef496ab@gmail.com>
 <DM5PR12MB2469A94D544647D893DA0FAAF1EF9@DM5PR12MB2469.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB2469A94D544647D893DA0FAAF1EF9@DM5PR12MB2469.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Aug 2021 09:35:21 -0400
Message-ID: <CADnq5_N_56yTXq4W8N3GG2kNsyEaCD1-xF8Mip8=26q0oRw39A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: avoid over-handle of fence driver fini in s3
 test (v2)
To: "Chen, Guchun" <Guchun.Chen@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Gao,
 Likun" <Likun.Gao@amd.com>, 
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, 
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

On Mon, Aug 2, 2021 at 4:23 AM Chen, Guchun <Guchun.Chen@amd.com> wrote:
>
> [Public]
>
> Thank you, Christian.
>
> Regarding fence_drv.initialized, it looks to a bit redundant, anyway let =
me look into this more.

Does this patch fix this bug?
https://gitlab.freedesktop.org/drm/amd/-/issues/1668

If so, please add:
Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1668
to the commit message.

Alex

>
> Regards,
> Guchun
>
> -----Original Message-----
> From: Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>
> Sent: Monday, August 2, 2021 2:56 PM
> To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org; Ga=
o, Likun <Likun.Gao@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>;=
 Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.Deuc=
her@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: avoid over-handle of fence driver fini i=
n s3 test (v2)
>
> Am 02.08.21 um 07:16 schrieb Guchun Chen:
> > In amdgpu_fence_driver_hw_fini, no need to call drm_sched_fini to stop
> > scheduler in s3 test, otherwise, fence related failure will arrive
> > after resume. To fix this and for a better clean up, move
> > drm_sched_fini from fence_hw_fini to fence_sw_fini, as it's part of
> > driver shutdown, and should never be called in hw_fini.
> >
> > v2: rename amdgpu_fence_driver_init to amdgpu_fence_driver_sw_init, to
> > keep sw_init and sw_fini paired.
> >
> > Fixes: cd87a6dcf6af drm/amdgpu: adjust fence driver enable sequence
> > Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Signed-off-by: Guchun Chen <guchun.chen@amd.com>
>
> It's a bit ambiguous now what fence_drv.initialized means, but I think we=
 can live with that for now.
>
> Patch is Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>.
>
> Regards,
> Christian.
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  5 ++---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 12 +++++++-----
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |  4 ++--
> >   3 files changed, 11 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index b1d2dc39e8be..9e53ff851496 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -3646,9 +3646,9 @@ int amdgpu_device_init(struct amdgpu_device
> > *adev,
> >
> >   fence_driver_init:
> >       /* Fence driver */
> > -     r =3D amdgpu_fence_driver_init(adev);
> > +     r =3D amdgpu_fence_driver_sw_init(adev);
> >       if (r) {
> > -             dev_err(adev->dev, "amdgpu_fence_driver_init failed\n");
> > +             dev_err(adev->dev, "amdgpu_fence_driver_sw_init failed\n"=
);
> >               amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_FENCE_INIT_FAIL=
, 0, 0);
> >               goto failed;
> >       }
> > @@ -3988,7 +3988,6 @@ int amdgpu_device_resume(struct drm_device *dev, =
bool fbcon)
> >       }
> >       amdgpu_fence_driver_hw_init(adev);
> >
> > -
> >       r =3D amdgpu_device_ip_late_init(adev);
> >       if (r)
> >               return r;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > index 49c5c7331c53..7495911516c2 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > @@ -498,7 +498,7 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_rin=
g *ring,
> >   }
> >
> >   /**
> > - * amdgpu_fence_driver_init - init the fence driver
> > + * amdgpu_fence_driver_sw_init - init the fence driver
> >    * for all possible rings.
> >    *
> >    * @adev: amdgpu device pointer
> > @@ -509,13 +509,13 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_r=
ing *ring,
> >    * amdgpu_fence_driver_start_ring().
> >    * Returns 0 for success.
> >    */
> > -int amdgpu_fence_driver_init(struct amdgpu_device *adev)
> > +int amdgpu_fence_driver_sw_init(struct amdgpu_device *adev)
> >   {
> >       return 0;
> >   }
> >
> >   /**
> > - * amdgpu_fence_driver_fini - tear down the fence driver
> > + * amdgpu_fence_driver_hw_fini - tear down the fence driver
> >    * for all possible rings.
> >    *
> >    * @adev: amdgpu device pointer
> > @@ -531,8 +531,7 @@ void amdgpu_fence_driver_hw_fini(struct
> > amdgpu_device *adev)
> >
> >               if (!ring || !ring->fence_drv.initialized)
> >                       continue;
> > -             if (!ring->no_scheduler)
> > -                     drm_sched_fini(&ring->sched);
> > +
> >               /* You can't wait for HW to signal if it's gone */
> >               if (!drm_dev_is_unplugged(&adev->ddev))
> >                       r =3D amdgpu_fence_wait_empty(ring); @@ -560,6 +5=
59,9 @@ void
> > amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev)
> >               if (!ring || !ring->fence_drv.initialized)
> >                       continue;
> >
> > +             if (!ring->no_scheduler)
> > +                     drm_sched_fini(&ring->sched);
> > +
> >               for (j =3D 0; j <=3D ring->fence_drv.num_fences_mask; ++j=
)
> >                       dma_fence_put(ring->fence_drv.fences[j]);
> >               kfree(ring->fence_drv.fences);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > index 27adffa7658d..9c11ced4312c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > @@ -106,7 +106,6 @@ struct amdgpu_fence_driver {
> >       struct dma_fence                **fences;
> >   };
> >
> > -int amdgpu_fence_driver_init(struct amdgpu_device *adev);
> >   void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
> >
> >   int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring, @@
> > -115,9 +114,10 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_ring =
*ring,
> >   int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
> >                                  struct amdgpu_irq_src *irq_src,
> >                                  unsigned irq_type);
> > +void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);
> >   void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev);
> > +int amdgpu_fence_driver_sw_init(struct amdgpu_device *adev);
> >   void amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev); -void
> > amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);
> >   int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **fe=
nce,
> >                     unsigned flags);
> >   int amdgpu_fence_emit_polling(struct amdgpu_ring *ring, uint32_t *s,
