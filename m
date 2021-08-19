Return-Path: <SRS0=nAtJ=NK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D277EC4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 12:05:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4572661152
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 12:05:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4572661152
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fireburn.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D8056E942;
	Thu, 19 Aug 2021 12:04:59 +0000 (UTC)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25D336E83A
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Aug 2021 12:04:58 +0000 (UTC)
Received: by mail-qk1-x734.google.com with SMTP id o123so6781558qkf.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Aug 2021 05:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LYe3/Xdx+Ls0VceC3n9myA5w2pI2OY3JsXkkEP2Mgqk=;
 b=UeKe8wSN9ZFbI7lAhVWXpdU7vIwNES3qnC3Cs7eRz3A/qQVulzURHLb4FiAFDW99jI
 5RBErHuTXb1HwxwwR9QOWdecWOJiNcaCu7Jt9U5VNsoQdIOkqgqKkHxLQ9CULcn1UdQv
 2El7AsOjMpKXX0GFr940sOKMqET/NQ7WdR+g0SeJIpRkGrpBBihn2serzvxhHbsiFl5k
 ZN/qFCGI/98R5g3nrYuV9YfhtS5Gtdb+HFTI3cw1YVdlMumPRFXNlTeUIlusjacrfNs8
 FNme3jO8278XXxpxfRXw8wDX2oss5i2otYZQrXaE39eIvST3oTX9H5cxuUXKYZZTPYtr
 UXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LYe3/Xdx+Ls0VceC3n9myA5w2pI2OY3JsXkkEP2Mgqk=;
 b=uVhUfLOdqrbgWgJD7KBGgwfKgMT8XhRvw5WttVM0EZVQSEwLAy1XU54UwQC9Jx1zIn
 mrSXziqIPfx1/UZnZBlCmnk5EzSP3Bl3E//WxzFQNKpKN3b5A7l1APgPXl1/4BRHFk1O
 2jRocJglZVl/oqAhLmU8PFjvPn578ovsOeK4RtUjLM8KAHbRXvb8LO8bc6fJoF1lOW8E
 lv7kPlwK8wWywja5AFgW6zPXo3Dnt1gulhXTnuJZjL8nioXrgZNnb6F2X94MxAIKnz6R
 srcQ+fIGQLMFoAL1Aumn/0ys5zJXaauu7VH0Kfzp8oB9/f/MJiudoMtcwigLbyCNwH7w
 yooQ==
X-Gm-Message-State: AOAM531/+tqRza+vwUsv5KkmQeWzjmmiWEDSz7+G3f2nlu0JQI1LLT7Y
 aIl1nlqeqdQDE9u6DGj02lL1fqFrpd7bMeeOrxx3Mw==
X-Google-Smtp-Source: ABdhPJzQBtNMxpcqSrm7DeehaXv3y6NPGSAvbNVbDo9clAfysHpxtd9gUQkBK3Ld4ODEabLHN2sFy6KBsFmnjxJYsbQ=
X-Received: by 2002:a37:a88a:: with SMTP id r132mr3385416qke.212.1629374697035; 
 Thu, 19 Aug 2021 05:04:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210802051602.23822-1-guchun.chen@amd.com>
 <9b28973f-d71c-8ca1-32f3-e7dc23563a70@amd.com>
In-Reply-To: <9b28973f-d71c-8ca1-32f3-e7dc23563a70@amd.com>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Thu, 19 Aug 2021 13:04:45 +0100
Message-ID: <CAHbf0-HNwJvmv=D6KDQrNcmaCbtqj0cCZLgE9bWnSoMNBuqS+w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: avoid over-handle of fence driver fini in s3
 test (v2)
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc: Guchun Chen <guchun.chen@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 Likun Gao <Likun.Gao@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Hawking Zhang <Hawking.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Content-Type: multipart/alternative; boundary="00000000000005f18205c9e85c47"
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

--00000000000005f18205c9e85c47
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

Do I need to open a new bug report for this?

Cheers

Mike

On Wed, 18 Aug 2021 at 06:26, Andrey Grodzovsky <andrey.grodzovsky@amd.com>
wrote:

>
> On 2021-08-02 1:16 a.m., Guchun Chen wrote:
> > In amdgpu_fence_driver_hw_fini, no need to call drm_sched_fini to stop
> > scheduler in s3 test, otherwise, fence related failure will arrive
> > after resume. To fix this and for a better clean up, move drm_sched_fin=
i
> > from fence_hw_fini to fence_sw_fini, as it's part of driver shutdown, a=
nd
> > should never be called in hw_fini.
> >
> > v2: rename amdgpu_fence_driver_init to amdgpu_fence_driver_sw_init,
> > to keep sw_init and sw_fini paired.
> >
> > Fixes: cd87a6dcf6af drm/amdgpu: adjust fence driver enable sequence
> > Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  5 ++---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 12 +++++++-----
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |  4 ++--
> >   3 files changed, 11 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index b1d2dc39e8be..9e53ff851496 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -3646,9 +3646,9 @@ int amdgpu_device_init(struct amdgpu_device *adev=
,
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
,
> 0, 0);
> >               goto failed;
> >       }
> > @@ -3988,7 +3988,6 @@ int amdgpu_device_resume(struct drm_device *dev,
> bool fbcon)
> >       }
> >       amdgpu_fence_driver_hw_init(adev);
> >
> > -
> >       r =3D amdgpu_device_ip_late_init(adev);
> >       if (r)
> >               return r;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > index 49c5c7331c53..7495911516c2 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > @@ -498,7 +498,7 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_rin=
g
> *ring,
> >   }
> >
> >   /**
> > - * amdgpu_fence_driver_init - init the fence driver
> > + * amdgpu_fence_driver_sw_init - init the fence driver
> >    * for all possible rings.
> >    *
> >    * @adev: amdgpu device pointer
> > @@ -509,13 +509,13 @@ int amdgpu_fence_driver_init_ring(struct
> amdgpu_ring *ring,
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
> amdgpu_device *adev)
> >
> >               if (!ring || !ring->fence_drv.initialized)
> >                       continue;
> > -             if (!ring->no_scheduler)
> > -                     drm_sched_fini(&ring->sched);
> > +
> >               /* You can't wait for HW to signal if it's gone */
> >               if (!drm_dev_is_unplugged(&adev->ddev))
> >                       r =3D amdgpu_fence_wait_empty(ring);
>
>
> Sorry for late notice, missed this patch. By moving drm_sched_fini
> past amdgpu_fence_wait_empty a race is created as even after you waited
> for all fences on the ring to signal the sw scheduler will keep submittin=
g
> new jobs on the ring and so the ring won't stay empty.
>
> For hot device removal also we want to prevent any access to HW past PCI
> removal
> in order to not do any MMIO accesses inside the physical MMIO range that
> no longer
> belongs to this device after it's removal by the PCI core. Stopping all
> the schedulers prevents any MMIO
> accesses done during job submissions and that why drm_sched_fini was
> done as part of amdgpu_fence_driver_hw_fini
> and not amdgpu_fence_driver_sw_fini
>
> Andrey
>
> > @@ -560,6 +559,9 @@ void amdgpu_fence_driver_sw_fini(struct
> amdgpu_device *adev)
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
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
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
> >   int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring,
> > @@ -115,9 +114,10 @@ int amdgpu_fence_driver_init_ring(struct
> amdgpu_ring *ring,
> >   int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
> >                                  struct amdgpu_irq_src *irq_src,
> >                                  unsigned irq_type);
> > +void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);
> >   void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev);
> > +int amdgpu_fence_driver_sw_init(struct amdgpu_device *adev);
> >   void amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev);
> > -void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);
> >   int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence
> **fence,
> >                     unsigned flags);
> >   int amdgpu_fence_emit_polling(struct amdgpu_ring *ring, uint32_t *s,
>

--00000000000005f18205c9e85c47
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi<div><br></div><div>Do I need to open a new bug report f=
or this?</div><div><br></div><div>Cheers</div><div><br></div><div>Mike</div=
></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr"=
>On Wed, 18 Aug 2021 at 06:26, Andrey Grodzovsky &lt;<a href=3D"mailto:andr=
ey.grodzovsky@amd.com">andrey.grodzovsky@amd.com</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex"><br>
On 2021-08-02 1:16 a.m., Guchun Chen wrote:<br>
&gt; In amdgpu_fence_driver_hw_fini, no need to call drm_sched_fini to stop=
<br>
&gt; scheduler in s3 test, otherwise, fence related failure will arrive<br>
&gt; after resume. To fix this and for a better clean up, move drm_sched_fi=
ni<br>
&gt; from fence_hw_fini to fence_sw_fini, as it&#39;s part of driver shutdo=
wn, and<br>
&gt; should never be called in hw_fini.<br>
&gt;<br>
&gt; v2: rename amdgpu_fence_driver_init to amdgpu_fence_driver_sw_init,<br=
>
&gt; to keep sw_init and sw_fini paired.<br>
&gt;<br>
&gt; Fixes: cd87a6dcf6af drm/amdgpu: adjust fence driver enable sequence<br=
>
&gt; Suggested-by: Christian K=C3=B6nig &lt;<a href=3D"mailto:christian.koe=
nig@amd.com" target=3D"_blank">christian.koenig@amd.com</a>&gt;<br>
&gt; Signed-off-by: Guchun Chen &lt;<a href=3D"mailto:guchun.chen@amd.com" =
target=3D"_blank">guchun.chen@amd.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |=C2=A0 5 ++---=
<br>
&gt;=C2=A0 =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c=C2=A0 | 12 +++++=
++-----<br>
&gt;=C2=A0 =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h=C2=A0 =C2=A0|=C2=
=A0 4 ++--<br>
&gt;=C2=A0 =C2=A03 files changed, 11 insertions(+), 10 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c<br>
&gt; index b1d2dc39e8be..9e53ff851496 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; @@ -3646,9 +3646,9 @@ int amdgpu_device_init(struct amdgpu_device *ade=
v,<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0fence_driver_init:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Fence driver */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0r =3D amdgpu_fence_driver_init(adev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0r =3D amdgpu_fence_driver_sw_init(adev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (r) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(adev-&gt;dev,=
 &quot;amdgpu_fence_driver_init failed\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(adev-&gt;dev,=
 &quot;amdgpu_fence_driver_sw_init failed\n&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_vf_error_=
put(adev, AMDGIM_ERROR_VF_FENCE_INIT_FAIL, 0, 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto failed;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; @@ -3988,7 +3988,6 @@ int amdgpu_device_resume(struct drm_device *dev,=
 bool fbcon)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_fence_driver_hw_init(adev);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amdgpu_device_ip_late_init(adev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (r)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return r;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_fence.c<br>
&gt; index 49c5c7331c53..7495911516c2 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c<br>
&gt; @@ -498,7 +498,7 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_ri=
ng *ring,<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0/**<br>
&gt; - * amdgpu_fence_driver_init - init the fence driver<br>
&gt; + * amdgpu_fence_driver_sw_init - init the fence driver<br>
&gt;=C2=A0 =C2=A0 * for all possible rings.<br>
&gt;=C2=A0 =C2=A0 *<br>
&gt;=C2=A0 =C2=A0 * @adev: amdgpu device pointer<br>
&gt; @@ -509,13 +509,13 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_=
ring *ring,<br>
&gt;=C2=A0 =C2=A0 * amdgpu_fence_driver_start_ring().<br>
&gt;=C2=A0 =C2=A0 * Returns 0 for success.<br>
&gt;=C2=A0 =C2=A0 */<br>
&gt; -int amdgpu_fence_driver_init(struct amdgpu_device *adev)<br>
&gt; +int amdgpu_fence_driver_sw_init(struct amdgpu_device *adev)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0/**<br>
&gt; - * amdgpu_fence_driver_fini - tear down the fence driver<br>
&gt; + * amdgpu_fence_driver_hw_fini - tear down the fence driver<br>
&gt;=C2=A0 =C2=A0 * for all possible rings.<br>
&gt;=C2=A0 =C2=A0 *<br>
&gt;=C2=A0 =C2=A0 * @adev: amdgpu device pointer<br>
&gt; @@ -531,8 +531,7 @@ void amdgpu_fence_driver_hw_fini(struct amdgpu_dev=
ice *adev)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ring || !ri=
ng-&gt;fence_drv.initialized)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0continue;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ring-&gt;no_sche=
duler)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0drm_sched_fini(&amp;ring-&gt;sched);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* You can&#39;t=
 wait for HW to signal if it&#39;s gone */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!drm_dev_is_=
unplugged(&amp;adev-&gt;ddev))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0r =3D amdgpu_fence_wait_empty(ring);<br>
<br>
<br>
Sorry for late notice, missed this patch. By moving drm_sched_fini<br>
past amdgpu_fence_wait_empty a race is created as even after you waited<br>
for all fences on the ring to signal the sw scheduler will keep submitting<=
br>
new jobs on the ring and so the ring won&#39;t stay empty.<br>
<br>
For hot device removal also we want to prevent any access to HW past PCI <b=
r>
removal<br>
in order to not do any MMIO accesses inside the physical MMIO range that <b=
r>
no longer<br>
belongs to this device after it&#39;s removal by the PCI core. Stopping all=
 <br>
the schedulers prevents any MMIO<br>
accesses done during job submissions and that why drm_sched_fini was <br>
done as part of amdgpu_fence_driver_hw_fini<br>
and not amdgpu_fence_driver_sw_fini<br>
<br>
Andrey<br>
<br>
&gt; @@ -560,6 +559,9 @@ void amdgpu_fence_driver_sw_fini(struct amdgpu_dev=
ice *adev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ring || !ri=
ng-&gt;fence_drv.initialized)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0continue;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ring-&gt;no_sche=
duler)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0drm_sched_fini(&amp;ring-&gt;sched);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (j =3D 0; j =
&lt;=3D ring-&gt;fence_drv.num_fences_mask; ++j)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0dma_fence_put(ring-&gt;fence_drv.fences[j]);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(ring-&gt;f=
ence_drv.fences);<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_ring.h<br>
&gt; index 27adffa7658d..9c11ced4312c 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br>
&gt; @@ -106,7 +106,6 @@ struct amdgpu_fence_driver {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct dma_fence=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 **fences;<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -int amdgpu_fence_driver_init(struct amdgpu_device *adev);<br>
&gt;=C2=A0 =C2=A0void amdgpu_fence_driver_force_completion(struct amdgpu_ri=
ng *ring);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring=
,<br>
&gt; @@ -115,9 +114,10 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_r=
ing *ring,<br>
&gt;=C2=A0 =C2=A0int amdgpu_fence_driver_start_ring(struct amdgpu_ring *rin=
g,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct amdgpu_irq_src *irq=
_src,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned irq_type);<br>
&gt; +void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);<br>
&gt;=C2=A0 =C2=A0void amdgpu_fence_driver_hw_fini(struct amdgpu_device *ade=
v);<br>
&gt; +int amdgpu_fence_driver_sw_init(struct amdgpu_device *adev);<br>
&gt;=C2=A0 =C2=A0void amdgpu_fence_driver_sw_fini(struct amdgpu_device *ade=
v);<br>
&gt; -void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);<br>
&gt;=C2=A0 =C2=A0int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma=
_fence **fence,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0unsigned flags);<br>
&gt;=C2=A0 =C2=A0int amdgpu_fence_emit_polling(struct amdgpu_ring *ring, ui=
nt32_t *s,<br>
</blockquote></div>

--00000000000005f18205c9e85c47--
