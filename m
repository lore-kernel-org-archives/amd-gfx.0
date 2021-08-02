Return-Path: <SRS0=SMOw=MZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446E7C4338F
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Aug 2021 16:19:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92F4A60F9E
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Aug 2021 16:19:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 92F4A60F9E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fireburn.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AE7A6E1D6;
	Mon,  2 Aug 2021 16:19:18 +0000 (UTC)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED1086E1D6
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Aug 2021 16:19:16 +0000 (UTC)
Received: by mail-qk1-x72c.google.com with SMTP id x3so17084862qkl.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Aug 2021 09:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ix8LsoMJwn8iq7L61ONv/ojBQnq8awl3JZIlspoi5ZU=;
 b=v49YZkSHkN/zUtEVq9GNRDhfBdBOORkggn70WpIflA5djrl+3FYnSh1KprSHKsgZGE
 E8Y+vIGfhbILyfzk8W0A0mklRQ5cz12ROOwUPIR8nKOX7VWrUv3ePQZmvk+NGc/4NMER
 NcoOdPp7U7bco/ae+g5//bpzT1OXg/Q5ClYmFChclmtWNiEFOTK77GT+aw19bi9k/Nip
 CWFeugdAXQ91LEc7mJQ+xTkdW2iJIHk7bKiyVD9mivcd5I19yQXEsKXLMd148jji7DoP
 Yu4vNFU6nAwkn4mDKG6NyDT9zHOtEG5ClxaiY/nGk8YCfkxlzZisheHndclV1CyklXmK
 UVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ix8LsoMJwn8iq7L61ONv/ojBQnq8awl3JZIlspoi5ZU=;
 b=F/IP2kUUn0VocWlh8gkm7InwI5QFuP4m+LrpkklaPO8LquJt0Xd4ByKNw3Emuy8uqD
 mbn4NS/TZSJzKBKI/iJ7fTHjn5VWAgmiOVKYettB/G4UPl39viDky2hq1QVAqTH0Y0TQ
 YetwzEyIPyaJmPZmLnfzksKw+6a+5FhmDlzW5jd9sDEeD4gnObpm5+wIXXoISuk890HI
 CTgMBi4ZxU4ZFUuu0HnTXYmffET052reYJACxvsHU7J+yUqeP9yNcf42kH7q0CEvxbdD
 qa+mdzcoKcLHmez5rKvUo14WFLzDlIrGO2ODrrX8NIw8isnnr7M3OiaU/yS2jIKP/UdB
 a8Ow==
X-Gm-Message-State: AOAM530aBI0kvohw5R7c8CxUdgckm8I5c+a4AWO+Rry7MGdCS0FUh6O8
 350R2vD3+WwQypQkUQrx6TEXjh71WhuLNzMh+Bi2KA==
X-Google-Smtp-Source: ABdhPJy7uvinq4Hh1MYPIRif/sksi3iciRa6tPX9UyduYgbgzPf8TBOY+OlS2mIyXKGngBHMmc6HG7omEZWkbeVOVsw=
X-Received: by 2002:a05:620a:1728:: with SMTP id
 az40mr16467979qkb.491.1627921155888; 
 Mon, 02 Aug 2021 09:19:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210802051602.23822-1-guchun.chen@amd.com>
 <b7218d98-9eb1-2d41-157a-bc417ef496ab@gmail.com>
 <DM5PR12MB2469A94D544647D893DA0FAAF1EF9@DM5PR12MB2469.namprd12.prod.outlook.com>
 <CADnq5_N_56yTXq4W8N3GG2kNsyEaCD1-xF8Mip8=26q0oRw39A@mail.gmail.com>
In-Reply-To: <CADnq5_N_56yTXq4W8N3GG2kNsyEaCD1-xF8Mip8=26q0oRw39A@mail.gmail.com>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Mon, 2 Aug 2021 17:19:04 +0100
Message-ID: <CAHbf0-EquoLAz5nxEbE3v=mWNED2Bipt7FmMZ=eD0xzB93Bykg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: avoid over-handle of fence driver fini in s3
 test (v2)
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "Chen, Guchun" <Guchun.Chen@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Gao,
 Likun" <Likun.Gao@amd.com>, 
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: multipart/alternative; boundary="000000000000382b2205c895ee13"
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

--000000000000382b2205c895ee13
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I've just tested it and it seem to fix my issue

Feel free to add my

Tested-by: Mike Lothian <mike@fireburn.co.uk>

On Mon, 2 Aug 2021 at 14:35, Alex Deucher <alexdeucher@gmail.com> wrote:

> On Mon, Aug 2, 2021 at 4:23 AM Chen, Guchun <Guchun.Chen@amd.com> wrote:
> >
> > [Public]
> >
> > Thank you, Christian.
> >
> > Regarding fence_drv.initialized, it looks to a bit redundant, anyway le=
t
> me look into this more.
>
> Does this patch fix this bug?
> https://gitlab.freedesktop.org/drm/amd/-/issues/1668
>
> If so, please add:
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1668
> to the commit message.
>
> Alex
>
> >
> > Regards,
> > Guchun
> >
> > -----Original Message-----
> > From: Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>
> > Sent: Monday, August 2, 2021 2:56 PM
> > To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org;
> Gao, Likun <Likun.Gao@amd.com>; Koenig, Christian <
> Christian.Koenig@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>;
> Deucher, Alexander <Alexander.Deucher@amd.com>
> > Subject: Re: [PATCH] drm/amdgpu: avoid over-handle of fence driver fini
> in s3 test (v2)
> >
> > Am 02.08.21 um 07:16 schrieb Guchun Chen:
> > > In amdgpu_fence_driver_hw_fini, no need to call drm_sched_fini to sto=
p
> > > scheduler in s3 test, otherwise, fence related failure will arrive
> > > after resume. To fix this and for a better clean up, move
> > > drm_sched_fini from fence_hw_fini to fence_sw_fini, as it's part of
> > > driver shutdown, and should never be called in hw_fini.
> > >
> > > v2: rename amdgpu_fence_driver_init to amdgpu_fence_driver_sw_init, t=
o
> > > keep sw_init and sw_fini paired.
> > >
> > > Fixes: cd87a6dcf6af drm/amdgpu: adjust fence driver enable sequence
> > > Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> >
> > It's a bit ambiguous now what fence_drv.initialized means, but I think
> we can live with that for now.
> >
> > Patch is Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>.
> >
> > Regards,
> > Christian.
> >
> > > ---
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  5 ++---
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 12 +++++++-----
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |  4 ++--
> > >   3 files changed, 11 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > index b1d2dc39e8be..9e53ff851496 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > @@ -3646,9 +3646,9 @@ int amdgpu_device_init(struct amdgpu_device
> > > *adev,
> > >
> > >   fence_driver_init:
> > >       /* Fence driver */
> > > -     r =3D amdgpu_fence_driver_init(adev);
> > > +     r =3D amdgpu_fence_driver_sw_init(adev);
> > >       if (r) {
> > > -             dev_err(adev->dev, "amdgpu_fence_driver_init failed\n")=
;
> > > +             dev_err(adev->dev, "amdgpu_fence_driver_sw_init
> failed\n");
> > >               amdgpu_vf_error_put(adev,
> AMDGIM_ERROR_VF_FENCE_INIT_FAIL, 0, 0);
> > >               goto failed;
> > >       }
> > > @@ -3988,7 +3988,6 @@ int amdgpu_device_resume(struct drm_device *dev=
,
> bool fbcon)
> > >       }
> > >       amdgpu_fence_driver_hw_init(adev);
> > >
> > > -
> > >       r =3D amdgpu_device_ip_late_init(adev);
> > >       if (r)
> > >               return r;
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > > index 49c5c7331c53..7495911516c2 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > > @@ -498,7 +498,7 @@ int amdgpu_fence_driver_init_ring(struct
> amdgpu_ring *ring,
> > >   }
> > >
> > >   /**
> > > - * amdgpu_fence_driver_init - init the fence driver
> > > + * amdgpu_fence_driver_sw_init - init the fence driver
> > >    * for all possible rings.
> > >    *
> > >    * @adev: amdgpu device pointer
> > > @@ -509,13 +509,13 @@ int amdgpu_fence_driver_init_ring(struct
> amdgpu_ring *ring,
> > >    * amdgpu_fence_driver_start_ring().
> > >    * Returns 0 for success.
> > >    */
> > > -int amdgpu_fence_driver_init(struct amdgpu_device *adev)
> > > +int amdgpu_fence_driver_sw_init(struct amdgpu_device *adev)
> > >   {
> > >       return 0;
> > >   }
> > >
> > >   /**
> > > - * amdgpu_fence_driver_fini - tear down the fence driver
> > > + * amdgpu_fence_driver_hw_fini - tear down the fence driver
> > >    * for all possible rings.
> > >    *
> > >    * @adev: amdgpu device pointer
> > > @@ -531,8 +531,7 @@ void amdgpu_fence_driver_hw_fini(struct
> > > amdgpu_device *adev)
> > >
> > >               if (!ring || !ring->fence_drv.initialized)
> > >                       continue;
> > > -             if (!ring->no_scheduler)
> > > -                     drm_sched_fini(&ring->sched);
> > > +
> > >               /* You can't wait for HW to signal if it's gone */
> > >               if (!drm_dev_is_unplugged(&adev->ddev))
> > >                       r =3D amdgpu_fence_wait_empty(ring); @@ -560,6
> +559,9 @@ void
> > > amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev)
> > >               if (!ring || !ring->fence_drv.initialized)
> > >                       continue;
> > >
> > > +             if (!ring->no_scheduler)
> > > +                     drm_sched_fini(&ring->sched);
> > > +
> > >               for (j =3D 0; j <=3D ring->fence_drv.num_fences_mask; +=
+j)
> > >                       dma_fence_put(ring->fence_drv.fences[j]);
> > >               kfree(ring->fence_drv.fences);
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > > index 27adffa7658d..9c11ced4312c 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > > @@ -106,7 +106,6 @@ struct amdgpu_fence_driver {
> > >       struct dma_fence                **fences;
> > >   };
> > >
> > > -int amdgpu_fence_driver_init(struct amdgpu_device *adev);
> > >   void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring)=
;
> > >
> > >   int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring, @@
> > > -115,9 +114,10 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_rin=
g
> *ring,
> > >   int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
> > >                                  struct amdgpu_irq_src *irq_src,
> > >                                  unsigned irq_type);
> > > +void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);
> > >   void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev);
> > > +int amdgpu_fence_driver_sw_init(struct amdgpu_device *adev);
> > >   void amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev); -void
> > > amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);
> > >   int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence
> **fence,
> > >                     unsigned flags);
> > >   int amdgpu_fence_emit_polling(struct amdgpu_ring *ring, uint32_t *s=
,
>

--000000000000382b2205c895ee13
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I&#39;ve just tested it and it seem to fix my issue<div><b=
r></div><div>Feel free to add my=C2=A0</div><div><br></div><div>Tested-by: =
Mike Lothian &lt;<a href=3D"mailto:mike@fireburn.co.uk">mike@fireburn.co.uk=
</a>&gt;</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Mon, 2 Aug 2021 at 14:35, Alex Deucher &lt;<a href=3D"ma=
ilto:alexdeucher@gmail.com">alexdeucher@gmail.com</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">On Mon, Aug 2, 2021 at 4:2=
3 AM Chen, Guchun &lt;<a href=3D"mailto:Guchun.Chen@amd.com" target=3D"_bla=
nk">Guchun.Chen@amd.com</a>&gt; wrote:<br>
&gt;<br>
&gt; [Public]<br>
&gt;<br>
&gt; Thank you, Christian.<br>
&gt;<br>
&gt; Regarding fence_drv.initialized, it looks to a bit redundant, anyway l=
et me look into this more.<br>
<br>
Does this patch fix this bug?<br>
<a href=3D"https://gitlab.freedesktop.org/drm/amd/-/issues/1668" rel=3D"nor=
eferrer" target=3D"_blank">https://gitlab.freedesktop.org/drm/amd/-/issues/=
1668</a><br>
<br>
If so, please add:<br>
Bug: <a href=3D"https://gitlab.freedesktop.org/drm/amd/-/issues/1668" rel=
=3D"noreferrer" target=3D"_blank">https://gitlab.freedesktop.org/drm/amd/-/=
issues/1668</a><br>
to the commit message.<br>
<br>
Alex<br>
<br>
&gt;<br>
&gt; Regards,<br>
&gt; Guchun<br>
&gt;<br>
&gt; -----Original Message-----<br>
&gt; From: Christian K=C3=B6nig &lt;<a href=3D"mailto:ckoenig.leichtzumerke=
n@gmail.com" target=3D"_blank">ckoenig.leichtzumerken@gmail.com</a>&gt;<br>
&gt; Sent: Monday, August 2, 2021 2:56 PM<br>
&gt; To: Chen, Guchun &lt;<a href=3D"mailto:Guchun.Chen@amd.com" target=3D"=
_blank">Guchun.Chen@amd.com</a>&gt;; <a href=3D"mailto:amd-gfx@lists.freede=
sktop.org" target=3D"_blank">amd-gfx@lists.freedesktop.org</a>; Gao, Likun =
&lt;<a href=3D"mailto:Likun.Gao@amd.com" target=3D"_blank">Likun.Gao@amd.co=
m</a>&gt;; Koenig, Christian &lt;<a href=3D"mailto:Christian.Koenig@amd.com=
" target=3D"_blank">Christian.Koenig@amd.com</a>&gt;; Zhang, Hawking &lt;<a=
 href=3D"mailto:Hawking.Zhang@amd.com" target=3D"_blank">Hawking.Zhang@amd.=
com</a>&gt;; Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd=
.com" target=3D"_blank">Alexander.Deucher@amd.com</a>&gt;<br>
&gt; Subject: Re: [PATCH] drm/amdgpu: avoid over-handle of fence driver fin=
i in s3 test (v2)<br>
&gt;<br>
&gt; Am 02.08.21 um 07:16 schrieb Guchun Chen:<br>
&gt; &gt; In amdgpu_fence_driver_hw_fini, no need to call drm_sched_fini to=
 stop<br>
&gt; &gt; scheduler in s3 test, otherwise, fence related failure will arriv=
e<br>
&gt; &gt; after resume. To fix this and for a better clean up, move<br>
&gt; &gt; drm_sched_fini from fence_hw_fini to fence_sw_fini, as it&#39;s p=
art of<br>
&gt; &gt; driver shutdown, and should never be called in hw_fini.<br>
&gt; &gt;<br>
&gt; &gt; v2: rename amdgpu_fence_driver_init to amdgpu_fence_driver_sw_ini=
t, to<br>
&gt; &gt; keep sw_init and sw_fini paired.<br>
&gt; &gt;<br>
&gt; &gt; Fixes: cd87a6dcf6af drm/amdgpu: adjust fence driver enable sequen=
ce<br>
&gt; &gt; Suggested-by: Christian K=C3=B6nig &lt;<a href=3D"mailto:christia=
n.koenig@amd.com" target=3D"_blank">christian.koenig@amd.com</a>&gt;<br>
&gt; &gt; Signed-off-by: Guchun Chen &lt;<a href=3D"mailto:guchun.chen@amd.=
com" target=3D"_blank">guchun.chen@amd.com</a>&gt;<br>
&gt;<br>
&gt; It&#39;s a bit ambiguous now what fence_drv.initialized means, but I t=
hink we can live with that for now.<br>
&gt;<br>
&gt; Patch is Reviewed-by: Christian K=C3=B6nig &lt;<a href=3D"mailto:chris=
tian.koenig@amd.com" target=3D"_blank">christian.koenig@amd.com</a>&gt;.<br=
>
&gt;<br>
&gt; Regards,<br>
&gt; Christian.<br>
&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |=C2=A0 5 =
++---<br>
&gt; &gt;=C2=A0 =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c=C2=A0 | 12 =
+++++++-----<br>
&gt; &gt;=C2=A0 =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h=C2=A0 =C2=A0=
|=C2=A0 4 ++--<br>
&gt; &gt;=C2=A0 =C2=A03 files changed, 11 insertions(+), 10 deletions(-)<br=
>
&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; index b1d2dc39e8be..9e53ff851496 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; @@ -3646,9 +3646,9 @@ int amdgpu_device_init(struct amdgpu_device=
<br>
&gt; &gt; *adev,<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0fence_driver_init:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Fence driver */<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0r =3D amdgpu_fence_driver_init(adev);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0r =3D amdgpu_fence_driver_sw_init(adev);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (r) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(adev-&gt=
;dev, &quot;amdgpu_fence_driver_init failed\n&quot;);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(adev-&gt=
;dev, &quot;amdgpu_fence_driver_sw_init failed\n&quot;);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_vf_e=
rror_put(adev, AMDGIM_ERROR_VF_FENCE_INIT_FAIL, 0, 0);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto failed=
;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; @@ -3988,7 +3988,6 @@ int amdgpu_device_resume(struct drm_device =
*dev, bool fbcon)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_fence_driver_hw_init(adev);<br>
&gt; &gt;<br>
&gt; &gt; -<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amdgpu_device_ip_late_init(adev);=
<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (r)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return r;<b=
r>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c<br>
&gt; &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c<br>
&gt; &gt; index 49c5c7331c53..7495911516c2 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c<br>
&gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c<br>
&gt; &gt; @@ -498,7 +498,7 @@ int amdgpu_fence_driver_init_ring(struct amdg=
pu_ring *ring,<br>
&gt; &gt;=C2=A0 =C2=A0}<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0/**<br>
&gt; &gt; - * amdgpu_fence_driver_init - init the fence driver<br>
&gt; &gt; + * amdgpu_fence_driver_sw_init - init the fence driver<br>
&gt; &gt;=C2=A0 =C2=A0 * for all possible rings.<br>
&gt; &gt;=C2=A0 =C2=A0 *<br>
&gt; &gt;=C2=A0 =C2=A0 * @adev: amdgpu device pointer<br>
&gt; &gt; @@ -509,13 +509,13 @@ int amdgpu_fence_driver_init_ring(struct am=
dgpu_ring *ring,<br>
&gt; &gt;=C2=A0 =C2=A0 * amdgpu_fence_driver_start_ring().<br>
&gt; &gt;=C2=A0 =C2=A0 * Returns 0 for success.<br>
&gt; &gt;=C2=A0 =C2=A0 */<br>
&gt; &gt; -int amdgpu_fence_driver_init(struct amdgpu_device *adev)<br>
&gt; &gt; +int amdgpu_fence_driver_sw_init(struct amdgpu_device *adev)<br>
&gt; &gt;=C2=A0 =C2=A0{<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; &gt;=C2=A0 =C2=A0}<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0/**<br>
&gt; &gt; - * amdgpu_fence_driver_fini - tear down the fence driver<br>
&gt; &gt; + * amdgpu_fence_driver_hw_fini - tear down the fence driver<br>
&gt; &gt;=C2=A0 =C2=A0 * for all possible rings.<br>
&gt; &gt;=C2=A0 =C2=A0 *<br>
&gt; &gt;=C2=A0 =C2=A0 * @adev: amdgpu device pointer<br>
&gt; &gt; @@ -531,8 +531,7 @@ void amdgpu_fence_driver_hw_fini(struct<br>
&gt; &gt; amdgpu_device *adev)<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ring |=
| !ring-&gt;fence_drv.initialized)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0continue;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ring-&gt;no=
_scheduler)<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0drm_sched_fini(&amp;ring-&gt;sched);<br>
&gt; &gt; +<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* You can&=
#39;t wait for HW to signal if it&#39;s gone */<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!drm_de=
v_is_unplugged(&amp;adev-&gt;ddev))<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0r =3D amdgpu_fence_wait_empty(ring); @@ -560,6 +559,9 @@ v=
oid<br>
&gt; &gt; amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ring |=
| !ring-&gt;fence_drv.initialized)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0continue;<br>
&gt; &gt;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ring-&gt;no=
_scheduler)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0drm_sched_fini(&amp;ring-&gt;sched);<br>
&gt; &gt; +<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (j =3D =
0; j &lt;=3D ring-&gt;fence_drv.num_fences_mask; ++j)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0dma_fence_put(ring-&gt;fence_drv.fences[j]);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(ring-=
&gt;fence_drv.fences);<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br>
&gt; &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br>
&gt; &gt; index 27adffa7658d..9c11ced4312c 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br>
&gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br>
&gt; &gt; @@ -106,7 +106,6 @@ struct amdgpu_fence_driver {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct dma_fence=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 **fences;<br>
&gt; &gt;=C2=A0 =C2=A0};<br>
&gt; &gt;<br>
&gt; &gt; -int amdgpu_fence_driver_init(struct amdgpu_device *adev);<br>
&gt; &gt;=C2=A0 =C2=A0void amdgpu_fence_driver_force_completion(struct amdg=
pu_ring *ring);<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0int amdgpu_fence_driver_init_ring(struct amdgpu_ring =
*ring, @@<br>
&gt; &gt; -115,9 +114,10 @@ int amdgpu_fence_driver_init_ring(struct amdgpu=
_ring *ring,<br>
&gt; &gt;=C2=A0 =C2=A0int amdgpu_fence_driver_start_ring(struct amdgpu_ring=
 *ring,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct amdgpu_irq_src =
*irq_src,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned irq_type);<br=
>
&gt; &gt; +void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);<br=
>
&gt; &gt;=C2=A0 =C2=A0void amdgpu_fence_driver_hw_fini(struct amdgpu_device=
 *adev);<br>
&gt; &gt; +int amdgpu_fence_driver_sw_init(struct amdgpu_device *adev);<br>
&gt; &gt;=C2=A0 =C2=A0void amdgpu_fence_driver_sw_fini(struct amdgpu_device=
 *adev); -void<br>
&gt; &gt; amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);<br>
&gt; &gt;=C2=A0 =C2=A0int amdgpu_fence_emit(struct amdgpu_ring *ring, struc=
t dma_fence **fence,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0unsigned flags);<br>
&gt; &gt;=C2=A0 =C2=A0int amdgpu_fence_emit_polling(struct amdgpu_ring *rin=
g, uint32_t *s,<br>
</blockquote></div>

--000000000000382b2205c895ee13--
