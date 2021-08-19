Return-Path: <SRS0=nAtJ=NK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE43BC4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 18:13:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8B4060F5E
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 18:13:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A8B4060F5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 410EC6E8F5;
	Thu, 19 Aug 2021 18:13:27 +0000 (UTC)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36F016E8F5
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Aug 2021 18:13:25 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 r38-20020a05683044a600b0051a2c6dd421so9814680otv.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Aug 2021 11:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=cEZ7G074dvRUncnt1gywviDa1sD5CvaczA2IIsq8XxE=;
 b=eI1GgiejGGFw/Pq3VGATQSK/paPGwDjQ6zeNsll6RJvE1EmO285AFfiEMPOz9s/7FZ
 7sZoKT7kJxYqjFryjwhu7MMwxxRe7uu/lXwXxKwQehKvNNT5+Rs+J7hPz0SiFl5GCXd8
 ptyViD5H89sf7Z0DlWYQgTTBxrbge3+uHmgl1npioCRuOjm9iChbYCU8Joi2ftspgCgi
 4nSEKfBo7ee5b/9i2uWa+u+LIM5mlcvp8V5i0dtjHwD16klGxoU5+/5VdFZW6hSME2RB
 2N0JJUvPcT8eYM4EXfRM/tzlkxrPbr1EiqPJgZVhdjcn9VmIvRCLgi0w7B9BlCOZDCRW
 YJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=cEZ7G074dvRUncnt1gywviDa1sD5CvaczA2IIsq8XxE=;
 b=jEHrzZJhvr3oOn3TXrrnjyddS9tAPFbeGmf5K8fNxi7UjpGu+iK0Vz2m0Dtbqq/EpU
 YmkwmuF6G+hRirY0wJCZqJqilykxM9mm0u4mPZd5tXEBquFMOrgwD9B+hNYT+mlL7oFn
 crDQJHRu0XUhmhAYYorFkNP/K0kkkFC6bL6YJROfeU0fK2OmEHI9iJcwGPbvvaZzRKva
 xgN1Z2+fEBthXhLfN+Kieqb4h3LtLrKjKO349QPcPJYpjYUJQilu/kQRKfcJuA46ZzDK
 NcAiSktZUQmJuOiMaxnQR1+Glu2rECxcWdmd4/Iz97y+7ifl+Y+qRwv+MUj7XJ21l1Nj
 C+5w==
X-Gm-Message-State: AOAM530nQWp7383CYskxiVZKRVuv0Q2Vj6gOXGlsS5SXrFzWMaa/wDV0
 nwlmrt0ICuMETAhbVQXtFoV9itubnAElQMcKVBc=
X-Google-Smtp-Source: ABdhPJy5X5TZlXwO+b95Z8XCeRsR7Ja12Kmc2Xlc7p5rCeqg3QmwjfXGGxr4zxUNqVYhrQwaynApKMUfUgb03eKZnDY=
X-Received: by 2002:a9d:5a15:: with SMTP id v21mr13553708oth.132.1629396804240; 
 Thu, 19 Aug 2021 11:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210802051602.23822-1-guchun.chen@amd.com>
 <9b28973f-d71c-8ca1-32f3-e7dc23563a70@amd.com>
 <CAHbf0-HNwJvmv=D6KDQrNcmaCbtqj0cCZLgE9bWnSoMNBuqS+w@mail.gmail.com>
In-Reply-To: <CAHbf0-HNwJvmv=D6KDQrNcmaCbtqj0cCZLgE9bWnSoMNBuqS+w@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 19 Aug 2021 14:13:13 -0400
Message-ID: <CADnq5_MtY6jHG+VUuuz_Wz2Ka9Tm7p+B-C37SQvwPhhAeLvcVw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: avoid over-handle of fence driver fini in s3
 test (v2)
To: Mike Lothian <mike@fireburn.co.uk>
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Guchun Chen <guchun.chen@amd.com>, 
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Likun Gao <Likun.Gao@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Hawking Zhang <Hawking.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
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

Please go ahead.  Thanks!

Alex

On Thu, Aug 19, 2021 at 8:05 AM Mike Lothian <mike@fireburn.co.uk> wrote:
>
> Hi
>
> Do I need to open a new bug report for this?
>
> Cheers
>
> Mike
>
> On Wed, 18 Aug 2021 at 06:26, Andrey Grodzovsky <andrey.grodzovsky@amd.co=
m> wrote:
>>
>>
>> On 2021-08-02 1:16 a.m., Guchun Chen wrote:
>> > In amdgpu_fence_driver_hw_fini, no need to call drm_sched_fini to stop
>> > scheduler in s3 test, otherwise, fence related failure will arrive
>> > after resume. To fix this and for a better clean up, move drm_sched_fi=
ni
>> > from fence_hw_fini to fence_sw_fini, as it's part of driver shutdown, =
and
>> > should never be called in hw_fini.
>> >
>> > v2: rename amdgpu_fence_driver_init to amdgpu_fence_driver_sw_init,
>> > to keep sw_init and sw_fini paired.
>> >
>> > Fixes: cd87a6dcf6af drm/amdgpu: adjust fence driver enable sequence
>> > Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>> > Signed-off-by: Guchun Chen <guchun.chen@amd.com>
>> > ---
>> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  5 ++---
>> >   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 12 +++++++-----
>> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |  4 ++--
>> >   3 files changed, 11 insertions(+), 10 deletions(-)
>> >
>> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c
>> > index b1d2dc39e8be..9e53ff851496 100644
>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> > @@ -3646,9 +3646,9 @@ int amdgpu_device_init(struct amdgpu_device *ade=
v,
>> >
>> >   fence_driver_init:
>> >       /* Fence driver */
>> > -     r =3D amdgpu_fence_driver_init(adev);
>> > +     r =3D amdgpu_fence_driver_sw_init(adev);
>> >       if (r) {
>> > -             dev_err(adev->dev, "amdgpu_fence_driver_init failed\n");
>> > +             dev_err(adev->dev, "amdgpu_fence_driver_sw_init failed\n=
");
>> >               amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_FENCE_INIT_FAI=
L, 0, 0);
>> >               goto failed;
>> >       }
>> > @@ -3988,7 +3988,6 @@ int amdgpu_device_resume(struct drm_device *dev,=
 bool fbcon)
>> >       }
>> >       amdgpu_fence_driver_hw_init(adev);
>> >
>> > -
>> >       r =3D amdgpu_device_ip_late_init(adev);
>> >       if (r)
>> >               return r;
>> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_fence.c
>> > index 49c5c7331c53..7495911516c2 100644
>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> > @@ -498,7 +498,7 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_ri=
ng *ring,
>> >   }
>> >
>> >   /**
>> > - * amdgpu_fence_driver_init - init the fence driver
>> > + * amdgpu_fence_driver_sw_init - init the fence driver
>> >    * for all possible rings.
>> >    *
>> >    * @adev: amdgpu device pointer
>> > @@ -509,13 +509,13 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_=
ring *ring,
>> >    * amdgpu_fence_driver_start_ring().
>> >    * Returns 0 for success.
>> >    */
>> > -int amdgpu_fence_driver_init(struct amdgpu_device *adev)
>> > +int amdgpu_fence_driver_sw_init(struct amdgpu_device *adev)
>> >   {
>> >       return 0;
>> >   }
>> >
>> >   /**
>> > - * amdgpu_fence_driver_fini - tear down the fence driver
>> > + * amdgpu_fence_driver_hw_fini - tear down the fence driver
>> >    * for all possible rings.
>> >    *
>> >    * @adev: amdgpu device pointer
>> > @@ -531,8 +531,7 @@ void amdgpu_fence_driver_hw_fini(struct amdgpu_dev=
ice *adev)
>> >
>> >               if (!ring || !ring->fence_drv.initialized)
>> >                       continue;
>> > -             if (!ring->no_scheduler)
>> > -                     drm_sched_fini(&ring->sched);
>> > +
>> >               /* You can't wait for HW to signal if it's gone */
>> >               if (!drm_dev_is_unplugged(&adev->ddev))
>> >                       r =3D amdgpu_fence_wait_empty(ring);
>>
>>
>> Sorry for late notice, missed this patch. By moving drm_sched_fini
>> past amdgpu_fence_wait_empty a race is created as even after you waited
>> for all fences on the ring to signal the sw scheduler will keep submitti=
ng
>> new jobs on the ring and so the ring won't stay empty.
>>
>> For hot device removal also we want to prevent any access to HW past PCI
>> removal
>> in order to not do any MMIO accesses inside the physical MMIO range that
>> no longer
>> belongs to this device after it's removal by the PCI core. Stopping all
>> the schedulers prevents any MMIO
>> accesses done during job submissions and that why drm_sched_fini was
>> done as part of amdgpu_fence_driver_hw_fini
>> and not amdgpu_fence_driver_sw_fini
>>
>> Andrey
>>
>> > @@ -560,6 +559,9 @@ void amdgpu_fence_driver_sw_fini(struct amdgpu_dev=
ice *adev)
>> >               if (!ring || !ring->fence_drv.initialized)
>> >                       continue;
>> >
>> > +             if (!ring->no_scheduler)
>> > +                     drm_sched_fini(&ring->sched);
>> > +
>> >               for (j =3D 0; j <=3D ring->fence_drv.num_fences_mask; ++=
j)
>> >                       dma_fence_put(ring->fence_drv.fences[j]);
>> >               kfree(ring->fence_drv.fences);
>> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_ring.h
>> > index 27adffa7658d..9c11ced4312c 100644
>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> > @@ -106,7 +106,6 @@ struct amdgpu_fence_driver {
>> >       struct dma_fence                **fences;
>> >   };
>> >
>> > -int amdgpu_fence_driver_init(struct amdgpu_device *adev);
>> >   void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
>> >
>> >   int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring,
>> > @@ -115,9 +114,10 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_r=
ing *ring,
>> >   int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
>> >                                  struct amdgpu_irq_src *irq_src,
>> >                                  unsigned irq_type);
>> > +void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);
>> >   void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev);
>> > +int amdgpu_fence_driver_sw_init(struct amdgpu_device *adev);
>> >   void amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev);
>> > -void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);
>> >   int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f=
ence,
>> >                     unsigned flags);
>> >   int amdgpu_fence_emit_polling(struct amdgpu_ring *ring, uint32_t *s,
