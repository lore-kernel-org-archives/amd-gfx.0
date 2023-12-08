Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85055C4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Dec 2023 14:36:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F354C10EA9E;
	Fri,  8 Dec 2023 14:36:27 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79B5810E964
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Dec 2023 14:36:25 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-54dcfca54e0so2524557a12.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Dec 2023 06:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702046184; x=1702650984; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nHuhQlAH0QW3XEd+T02ebmp4b9ydUf875g/dR4GJJmw=;
 b=JTOJ0W+TiMorDIQB9M9GBkVO7XVqN4Iud79jDsi/RQA0RaDbRqnWiv7t6Gfj8F1/oV
 Z3CKUMPvoXZpWcwkF+Adtb0fjmd71Ck3mlb8KRxXT2FY9s29gabvtzzSdlbrn6D4CNC6
 tVPKv3/Fj9w+09IfMatjNI7ArIcAiwl3uWlNTEq6icH+/Q9eW0kb+UCJL3sV4tlZR0HJ
 CS6EF8SG2jA8f9ZUcDebhjcB26htE1WBbjti5E2qJD1gW0xw+FDvd/zYpW82UkTqAlov
 wH889I6vdTDI4SkA70NG5xxwegAiNRvxI6pOQQjX9mwHxrvpSPnq8WbbQFlH/tCQ2Cqv
 RI5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702046184; x=1702650984;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nHuhQlAH0QW3XEd+T02ebmp4b9ydUf875g/dR4GJJmw=;
 b=AMaMqkFp8QlsczOV94JdcayxxILyMt6NGi5Qv6tsnhtuAP+rfe2eYrjMpRm272gvL8
 TAIVm91uceE3CplTks+mZLdUYbMKDBHA+dZQhFDGlQvC2Ize7jPEbQ+XwrF64WQ+oBn4
 PTQIyFSVylxEu8M1OfihH7x9w/Z/hkEyTD1scfcO+xpQAI4nrR/hA1RObNh90RziKGeu
 cxpk7MY/+eqhRJbZksBID2nlz9zBiakYDRrK7txhNDxA8jyskAPA3bvx1yOdvIIo7eRg
 EMGq+SR1PuxIjaCpjTj1NH2dZ/eM5KtL0n8BScCMGeQHR7L6b1SYnij24MvxDeGKqDdL
 4Lmw==
X-Gm-Message-State: AOJu0YxEzOohPWQjY+LWLR3kFvrjZ9bm2LgpCDbu7skbyKiPa5Ik7UBi
 anYysk08GzMDui9s5+truTR2zcVgLkAt4OdkX/1XHDip
X-Google-Smtp-Source: AGHT+IFZSKzDXCODgcna8z3v56k8F69LrNpWfuAv7dao68Yxt/f3gIsE0uc71gXD2meJseTGpARYePfNhMcGpMSJUbg=
X-Received: by 2002:a17:906:161b:b0:a19:a1ba:da6a with SMTP id
 m27-20020a170906161b00b00a19a1bada6amr40462ejd.145.1702046183537; Fri, 08 Dec
 2023 06:36:23 -0800 (PST)
MIME-Version: 1.0
References: <20231202001740.120840-1-friedrich.vock@gmx.de>
 <3525f437-9537-4fb4-80d0-65acd9d55d2f@gmx.de>
 <3cf226b8-c80b-43f6-9f6c-9610d224717a@amd.com>
In-Reply-To: <3cf226b8-c80b-43f6-9f6c-9610d224717a@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Fri, 8 Dec 2023 09:35:46 -0500
Message-ID: <CAAxE2A5B03OEzeeHYRHpmy5E_M0M1EY-cP4uDYzrwAbbBUZFqA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Enable tunneling on high-priority compute
 queues
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: multipart/alternative; boundary="00000000000029422f060c00826c"
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Friedrich Vock <friedrich.vock@gmx.de>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--00000000000029422f060c00826c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It's correct according to our documentation.

Reviewed-by: Marek Ol=C5=A1=C3=A1k <marek.olsak@amd.com>

Marek

On Fri, Dec 8, 2023 at 5:47=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com>
wrote:

> Well longer story short Alex and I have been digging up the
> documentation for this and as far as we can tell this isn't correct.
>
> You need to do quite a bit more before you can turn on this feature.
> What userspace side do you refer to?
>
> Regards,
> Christian.
>
> Am 08.12.23 um 09:19 schrieb Friedrich Vock:
> > Friendly ping on this one.
> > Userspace side got merged, so would be great to land this patch too :)
> >
> > On 02.12.23 01:17, Friedrich Vock wrote:
> >> This improves latency if the GPU is already busy with other work.
> >> This is useful for VR compositors that submit highly latency-sensitive
> >> compositing work on high-priority compute queues while the GPU is busy
> >> rendering the next frame.
> >>
> >> Userspace merge request:
> >> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/26462
> >>
> >> Signed-off-by: Friedrich Vock <friedrich.vock@gmx.de>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  1 +
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 10 ++++++----
> >>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |  3 ++-
> >>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   |  3 ++-
> >>   4 files changed, 11 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >> index 9505dc8f9d69..4b923a156c4e 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >> @@ -790,6 +790,7 @@ struct amdgpu_mqd_prop {
> >>       uint64_t eop_gpu_addr;
> >>       uint32_t hqd_pipe_priority;
> >>       uint32_t hqd_queue_priority;
> >> +    bool allow_tunneling;
> >>       bool hqd_active;
> >>   };
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> >> index 231d49132a56..4d98e8879be8 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> >> @@ -620,6 +620,10 @@ static void amdgpu_ring_to_mqd_prop(struct
> >> amdgpu_ring *ring,
> >>                       struct amdgpu_mqd_prop *prop)
> >>   {
> >>       struct amdgpu_device *adev =3D ring->adev;
> >> +    bool is_high_prio_compute =3D ring->funcs->type =3D=3D
> >> AMDGPU_RING_TYPE_COMPUTE &&
> >> + amdgpu_gfx_is_high_priority_compute_queue(adev, ring);
> >> +    bool is_high_prio_gfx =3D ring->funcs->type =3D=3D
> >> AMDGPU_RING_TYPE_GFX &&
> >> + amdgpu_gfx_is_high_priority_graphics_queue(adev, ring);
> >>
> >>       memset(prop, 0, sizeof(*prop));
> >>
> >> @@ -637,10 +641,8 @@ static void amdgpu_ring_to_mqd_prop(struct
> >> amdgpu_ring *ring,
> >>        */
> >>       prop->hqd_active =3D ring->funcs->type =3D=3D AMDGPU_RING_TYPE_K=
IQ;
> >>
> >> -    if ((ring->funcs->type =3D=3D AMDGPU_RING_TYPE_COMPUTE &&
> >> -         amdgpu_gfx_is_high_priority_compute_queue(adev, ring)) ||
> >> -        (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_GFX &&
> >> -         amdgpu_gfx_is_high_priority_graphics_queue(adev, ring))) {
> >> +    prop->allow_tunneling =3D is_high_prio_compute;
> >> +    if (is_high_prio_compute || is_high_prio_gfx) {
> >>           prop->hqd_pipe_priority =3D AMDGPU_GFX_PIPE_PRIO_HIGH;
> >>           prop->hqd_queue_priority =3D AMDGPU_GFX_QUEUE_PRIORITY_MAXIM=
UM;
> >>       }
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> >> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> >> index c8a3bf01743f..73f6d7e72c73 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> >> @@ -6593,7 +6593,8 @@ static int gfx_v10_0_compute_mqd_init(struct
> >> amdgpu_device *adev, void *m,
> >>       tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, ENDIAN_SWAP, 1);
> >>   #endif
> >>       tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 0)=
;
> >> -    tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH, 0)=
;
> >> +    tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH,
> >> +                prop->allow_tunneling);
> >>       tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
> >>       tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, 1);
> >>       mqd->cp_hqd_pq_control =3D tmp;
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> >> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> >> index c659ef0f47ce..bdcf96df69e6 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> >> @@ -3847,7 +3847,8 @@ static int gfx_v11_0_compute_mqd_init(struct
> >> amdgpu_device *adev, void *m,
> >>       tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, RPTR_BLOCK_SIZE,
> >>                   (order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - 1));
> >>       tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 0)=
;
> >> -    tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH, 0)=
;
> >> +    tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH,
> >> +                prop->allow_tunneling);
> >>       tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
> >>       tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, 1);
> >>       mqd->cp_hqd_pq_control =3D tmp;
> >> --
> >> 2.43.0
> >>
>
>

--00000000000029422f060c00826c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>It&#39;s correct according to our documentation.<br><=
/div><div><br></div><div>Reviewed-by: Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"=
mailto:marek.olsak@amd.com" target=3D"_blank">marek.olsak@amd.com</a>&gt;</=
div><div><br></div><div>Marek<br></div></div><br><div class=3D"gmail_quote"=
><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Dec 8, 2023 at 5:47=E2=80=AF=
AM Christian K=C3=B6nig &lt;<a href=3D"mailto:christian.koenig@amd.com" tar=
get=3D"_blank">christian.koenig@amd.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">Well longer story short Alex and I h=
ave been digging up the <br>
documentation for this and as far as we can tell this isn&#39;t correct.<br=
>
<br>
You need to do quite a bit more before you can turn on this feature. <br>
What userspace side do you refer to?<br>
<br>
Regards,<br>
Christian.<br>
<br>
Am 08.12.23 um 09:19 schrieb Friedrich Vock:<br>
&gt; Friendly ping on this one.<br>
&gt; Userspace side got merged, so would be great to land this patch too :)=
<br>
&gt;<br>
&gt; On 02.12.23 01:17, Friedrich Vock wrote:<br>
&gt;&gt; This improves latency if the GPU is already busy with other work.<=
br>
&gt;&gt; This is useful for VR compositors that submit highly latency-sensi=
tive<br>
&gt;&gt; compositing work on high-priority compute queues while the GPU is =
busy<br>
&gt;&gt; rendering the next frame.<br>
&gt;&gt;<br>
&gt;&gt; Userspace merge request:<br>
&gt;&gt; <a href=3D"https://gitlab.freedesktop.org/mesa/mesa/-/merge_reques=
ts/26462" rel=3D"noreferrer" target=3D"_blank">https://gitlab.freedesktop.o=
rg/mesa/mesa/-/merge_requests/26462</a><br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Friedrich Vock &lt;<a href=3D"mailto:friedrich.vock=
@gmx.de" target=3D"_blank">friedrich.vock@gmx.de</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt; =C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 1 +<br>
&gt;&gt; =C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 10 ++++++----<br=
>
&gt;&gt; =C2=A0 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c=C2=A0=C2=A0 |=C2=A0 =
3 ++-<br>
&gt;&gt; =C2=A0 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c=C2=A0=C2=A0 |=C2=A0 =
3 ++-<br>
&gt;&gt; =C2=A0 4 files changed, 11 insertions(+), 6 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h <br>
&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt;&gt; index 9505dc8f9d69..4b923a156c4e 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt;&gt; @@ -790,6 +790,7 @@ struct amdgpu_mqd_prop {<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t eop_gpu_addr;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t hqd_pipe_priority;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t hqd_queue_priority;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 bool allow_tunneling;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool hqd_active;<br>
&gt;&gt; =C2=A0 };<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c <br>
&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c<br>
&gt;&gt; index 231d49132a56..4d98e8879be8 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c<br>
&gt;&gt; @@ -620,6 +620,10 @@ static void amdgpu_ring_to_mqd_prop(struct <b=
r>
&gt;&gt; amdgpu_ring *ring,<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_=
mqd_prop *prop)<br>
&gt;&gt; =C2=A0 {<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_device *adev =3D ring=
-&gt;adev;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 bool is_high_prio_compute =3D ring-&gt;funcs-&=
gt;type =3D=3D <br>
&gt;&gt; AMDGPU_RING_TYPE_COMPUTE &amp;&amp;<br>
&gt;&gt; + amdgpu_gfx_is_high_priority_compute_queue(adev, ring);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 bool is_high_prio_gfx =3D ring-&gt;funcs-&gt;t=
ype =3D=3D <br>
&gt;&gt; AMDGPU_RING_TYPE_GFX &amp;&amp;<br>
&gt;&gt; + amdgpu_gfx_is_high_priority_graphics_queue(adev, ring);<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memset(prop, 0, sizeof(*prop));<br>
&gt;&gt;<br>
&gt;&gt; @@ -637,10 +641,8 @@ static void amdgpu_ring_to_mqd_prop(struct <b=
r>
&gt;&gt; amdgpu_ring *ring,<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prop-&gt;hqd_active =3D ring-&gt;fu=
ncs-&gt;type =3D=3D AMDGPU_RING_TYPE_KIQ;<br>
&gt;&gt;<br>
&gt;&gt; -=C2=A0=C2=A0=C2=A0 if ((ring-&gt;funcs-&gt;type =3D=3D AMDGPU_RIN=
G_TYPE_COMPUTE &amp;&amp;<br>
&gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 amdgpu_gfx_is_hi=
gh_priority_compute_queue(adev, ring)) ||<br>
&gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (ring-&gt;funcs-&gt;ty=
pe =3D=3D AMDGPU_RING_TYPE_GFX &amp;&amp;<br>
&gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 amdgpu_gfx_is_hi=
gh_priority_graphics_queue(adev, ring))) {<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 prop-&gt;allow_tunneling =3D is_high_prio_comp=
ute;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 if (is_high_prio_compute || is_high_prio_gfx) =
{<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prop-&gt;hq=
d_pipe_priority =3D AMDGPU_GFX_PIPE_PRIO_HIGH;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prop-&gt;hq=
d_queue_priority =3D AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c <br>
&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
&gt;&gt; index c8a3bf01743f..73f6d7e72c73 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
&gt;&gt; @@ -6593,7 +6593,8 @@ static int gfx_v10_0_compute_mqd_init(struct=
 <br>
&gt;&gt; amdgpu_device *adev, void *m,<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp, CP_HQD_P=
Q_CONTROL, ENDIAN_SWAP, 1);<br>
&gt;&gt; =C2=A0 #endif<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp, CP_HQD_P=
Q_CONTROL, UNORD_DISPATCH, 0);<br>
&gt;&gt; -=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, =
TUNNEL_DISPATCH, 0);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, =
TUNNEL_DISPATCH,<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 prop-&gt;allow_tunneling);<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp, CP_HQD_P=
Q_CONTROL, PRIV_STATE, 1);<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp, CP_HQD_P=
Q_CONTROL, KMD_QUEUE, 1);<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mqd-&gt;cp_hqd_pq_control =3D tmp;<=
br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c <br>
&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<br>
&gt;&gt; index c659ef0f47ce..bdcf96df69e6 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<br>
&gt;&gt; @@ -3847,7 +3847,8 @@ static int gfx_v11_0_compute_mqd_init(struct=
 <br>
&gt;&gt; amdgpu_device *adev, void *m,<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp, CP_HQD_P=
Q_CONTROL, RPTR_BLOCK_SIZE,<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (order_base_2(AMDGPU_GPU_PAGE_SIZE / 4=
) - 1));<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp, CP_HQD_P=
Q_CONTROL, UNORD_DISPATCH, 0);<br>
&gt;&gt; -=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, =
TUNNEL_DISPATCH, 0);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, =
TUNNEL_DISPATCH,<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 prop-&gt;allow_tunneling);<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp, CP_HQD_P=
Q_CONTROL, PRIV_STATE, 1);<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp, CP_HQD_P=
Q_CONTROL, KMD_QUEUE, 1);<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mqd-&gt;cp_hqd_pq_control =3D tmp;<=
br>
&gt;&gt; -- <br>
&gt;&gt; 2.43.0<br>
&gt;&gt;<br>
<br>
</blockquote></div>

--00000000000029422f060c00826c--
