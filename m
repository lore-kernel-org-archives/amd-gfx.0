Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42510CA101F
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 14:52:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6F3110E939;
	Wed, 10 Sep 2025 14:52:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jAFZbamJ";
	dkim-atps=neutral
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com
 [209.85.210.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22B5310E939
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 14:52:51 +0000 (UTC)
Received: by mail-ot1-f50.google.com with SMTP id
 46e09a7af769-74381fc96a5so1078858a34.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 07:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757515970; x=1758120770; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=g43rONXYC2xbVfiYrZMBhecUxl1lB2OHhsx3SRnwQ20=;
 b=jAFZbamJammdJvgVNKDVeyo8R17bkAudA5x/MYjfI/X+GSwGrQRDwbtl2DZpxx/Sgb
 L9JN4UuBYl4DSK3GT719c9B2HZownP2sAnMVySCnG8KVIId/91He2n369pkpfEVBzR1s
 YeYx8c5enUVxNKVK9vu1W6n/JmmbjRAffDrsmkSCOnS34GhArAmzclZbll2pJ0B8gFuN
 toOV3xkU6GZosMQGW6mzMQ5PE620N10tJRNWB59gs2c6jHz11h3r2ED5IQuosrU5E7N3
 SNaa4YNKC4djNzKOWGkIRoptXRPOhQ9Kp63/FYcpICdltw/7SgajFaVcGj7T8ktwpsNi
 bpIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757515970; x=1758120770;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g43rONXYC2xbVfiYrZMBhecUxl1lB2OHhsx3SRnwQ20=;
 b=L6gPjtkn3RZsMpUFHhjBvLIZQH6TgMTuX8fJCcU+OyCyq7A4d5iFL+9qWc1c/S9vx4
 /LFQgupnZCdSAXoJrMRPIdzIl6/dJJmK1QV2FiaDdazloh4hWgvI9TcuODa8tP1e4LoM
 KqzixVO7gm/1zR2o4mUquMq6Mlc581C4GyrNcKyMNtJcgSnput8jex2S9kUCRCoAT9AN
 zpNmkhOLlFS3HkDust49yTdU0SmfYL62tZVdeS1cS3MyLBSPbPhHtJRDcMDFU6qAw/7P
 FdQGhzJc1IhN26fddKafKc4dnCTPhE8CxU4mzeOB4/k+ru8Qb6thlFfjTosxMPB6QEFq
 xxZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEACEV4LO74RCy0GN/ir7PGgB6nNI9QTDdXb655/2RuxEybUTP0nrYtB4qFbJB/+SKrs72L5be@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwpkGzheGg5X6cZjppyQYZkbKIKrYpBry5OCHnu4Dle4eikxnIy
 M3ExEGbzJZ63IKmqpHa4GeOY0fgBSsthQeWXMGLI1e66z7+SY36cIJFqn/FKgHj0R7zPS10mqVz
 e5a0bR2ysvKb0Ig72lxnRbsSE3B9aURU=
X-Gm-Gg: ASbGncsLFlEiN8e2RSTkkD4j6UnUNa2wh3+nwoGRT/BXH6jW4OKAjNjatvXSm8BaLCb
 A5set+egWar7mIjjGbPwRQZnwlEA2bQSXylZJh6jYI+++YU2WlwVRoRnRiPgMW6jojAb4SxusYN
 A2g31Libox3f8EMXeiyLOaR0HTKBrXfUW3LwFARSLq/EHwCvL+JAbDqk8cKvJSUiULX1ObR3dLf
 /ykd0OS
X-Google-Smtp-Source: AGHT+IF8uMMP4/77G+fU0RI6fEAZ5WMvTez7BGpnMF5A7ZlRyhNdMxglHCuV3mqtCrwKDEXOHI/yCmtHyobEkSOTzkg=
X-Received: by 2002:a05:6820:4385:b0:621:aaa2:3734 with SMTP id
 006d021491bc7-621aaa23b1bmr413168eaf.2.1757515970009; Wed, 10 Sep 2025
 07:52:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250909144937.22452-1-timur.kristof@gmail.com>
 <20250909144937.22452-2-timur.kristof@gmail.com>
 <26b5d36d-1c9b-4891-962c-ec13b65f02ac@amd.com>
 <a065f044dd629a9863ca18bb0e913d8f9299bedc.camel@gmail.com>
 <32b1c868-8b0d-41fd-94b9-0ebfbc6b3711@amd.com>
 <0d07fe34d3857ece68d29ce21ea2768e43538aa6.camel@gmail.com>
 <a77a5934-afa8-48e5-bb15-a7f55087c245@amd.com>
In-Reply-To: <a77a5934-afa8-48e5-bb15-a7f55087c245@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Wed, 10 Sep 2025 10:52:13 -0400
X-Gm-Features: Ac12FXy-dCmJEU04dqDasHFcg-QJwrQ_3JW1ug42VHPT7x4JC4J3HVh9FIVXcUs
Message-ID: <CAAxE2A4ZUG_DLnMpW7yd=pSqnGoyELmxi_u9GveLg1zra82_wg@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/amdgpu: Set SDMA v3 copy_max_bytes to 0x3fff00
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 "Olsak, Marek" <Marek.Olsak@amd.com>
Content-Type: multipart/alternative; boundary="000000000000145eb3063e7393f8"
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

--000000000000145eb3063e7393f8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It's probably better to use 0x3fff00 to match Mesa and PAL. There is no
benefit in using a different limit, not even a perf benefit, and it's
better to be consistent with all UMDs.

Marek

On Wed, Sep 10, 2025 at 7:54=E2=80=AFAM Christian K=C3=B6nig <christian.koe=
nig@amd.com>
wrote:

> On 10.09.25 11:34, Timur Krist=C3=B3f wrote:
> > On Wed, 2025-09-10 at 10:34 +0200, Christian K=C3=B6nig wrote:
> >> On 09.09.25 18:56, Timur Krist=C3=B3f wrote:
> >>>> Even when we apply it I think we should drop that, the value the
> >>>> kernel uses is correct.
> >>>
> >>> Hi Christian,
> >>>
> >>> The kernel and Mesa disagree on the limits for almost all SDMA
> >>> versions, so it would be nice to actually understand what the
> >>> limits of
> >>> the SDMA HW are and use the same limit in the kernel and Mesa, or
> >>> if
> >>> that isn't viable, let's document why the different limits make
> >>> sense.
> >>>
> >>> I'm adding Marek to CC, he wrote the comment that I referenced
> >>> here.
> >>> As far as I understand from my conversation with Marek, the kernel
> >>> is
> >>> actually wrong.
> >>>
> >>> If the limits depend on alignment, then we should either set a
> >>> limit
> >>> that is always safe, or make sure SDMA copies in the kernel are
> >>> always
> >>> aligned and add assertions about it.
> >>
> >> That's already done. See the size restrictions applied to BOs and the
> >> callers of amdgpu_copy_buffer().
> >
> > Based on the code comments I cited, as far as I understand, the issue
> > is with copying the last 256 bytes of 2^22-1. Do I understood your
> > response correctly that you are saying that the kernel isn't affected
> > by this issue because it always copies things that are 256 byte
> > aligned?
>
> Yes, see the kernel always works with at least PAGE_SIZE buffers (between
> 4k and 64k depending on CPU architecture). You never get anything smaller
> than that.
>
> The only exception is the debugger interface, but that always copies <
> PAGE_SIZE, so the SDMA limits are irrelevant.
>
> > I checked the callers of amdgpu_copy_buffer and can't find what you are
> > referring to. However, assuming that all callers use amdgpu_copy_buffer
> > on 256 byte aligned addresses, there is still an issue with large BOs:
> >
> > When the kernel copies a BO that is larger than 0x3fffe0 bytes then it
> > needs to emit multiple SDMA copy packets, and the copy done by the
> > second packet (and other subsequent packets) won't be 256 byte aligned.
>
> I've just double checked the documentation and for SI it clearly states
> that the limit is 0x3fffe0. Documentation for later HW says 2^22 - 1 -
> start_addr[4:2] (which is 0x1f in the worst case so you end up with
> 0x3fffe0 again).
>
> For backward, tiled and windowed copies a 256byte bounce buffer is used
> instead of the 32byte buffer for the linear copy. So the limit is then
> 0x3fff00.
>
> Looks like that buffer is also used for byte aligned copies and that limi=
t
> applies there as well.
>
> >>
> >> We could add another warning to amdgpu_copy_buffer(), but that is
> >> just the backend function.
> >>
> >>> Looking at the implementation of
> >>> amdgpu_copy_buffer in the kernel, I see that it relies on
> >>> copy_max_bytes and doesn't take alignment into account, so with the
> >>> current limit it could issue subsequent copies that aren't 256 byte
> >>> aligned.
> >>
> >> "Due to HW limitation, the maximum count may not be 2^n-1, can only
> >> be 2^n - 1 - start_addr[4:2]"
> >>
> >> Well according to this comments the size restriction is 32 bytes (256
> >> bits!) and not 256 bytes.
> >>
> >> Were do you actually get the 256 bytes restriction from?
> >
> > The comments I cited above are from the following sources:
> >
> > PAL uses 1<<22-256 =3D 0x3fff00 here:
> >
> https://github.com/GPUOpen-Drivers/pal/blob/bcec463efe5260776d486a5e3da0c=
549bc0a75d2/src/core/hw/ossip/oss2/oss2DmaCmdBuffer.cpp#L308
> >
> > Mesa also uses 0x3fff00 here:
> >
> https://gitlab.freedesktop.org/mesa/mesa/-/blob/47f5d25f93fd36224c112ee2d=
48e511ae078f8c2/src/amd/common/sid.h#L390
> >
> > The limit in Mesa was added by this commit:
> >
> https://gitlab.freedesktop.org/mesa/mesa/-/commit/2c1f249f2b61be50222411b=
c0d41c095004232ed
> > According to the commit message, Dave added this limit when hitting an
> > issue trying to use SDMA with buffers that are larger than this.
> >
> > For SDMA v5.2 and newer, a larger limit was added by Marek later:
> >
> https://gitlab.freedesktop.org/mesa/mesa/-/commit/a54bcb9429666fcbe38c046=
60cc4b3f8abbde259
> > Which confirms the same issue copying the last 256 bytes on these
> > versions, although in this case the kernel isn't technically wrong
> > because it uses a smaller overall maximum.
>
> Yeah, I mean that totally makes sense. When you want allow byte aligned
> copies as well then you have to use 0x3fff00 as maximum.
>
> The PAL code even has extra checks to speed up copies where src and dst
> are byte aligned, but size isn't:
>
>     if (IsPow2Aligned(srcGpuAddr, sizeof(uint32)) &&
>         IsPow2Aligned(dstGpuAddr, sizeof(uint32)) &&
>         (*pBytesCopied >=3D sizeof(uint32)))
> ....
>
> So it totally makes sense to use the lower limit in Mesa but not for the
> kernel.
>
> Regards,
> Christian.
>

--000000000000145eb3063e7393f8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>It&#39;s probably better to use=C2=A00x3fff00 to matc=
h Mesa and PAL. There is no benefit in using a different limit,=C2=A0not ev=
en a perf benefit, and it&#39;s better to be consistent with all UMDs.</div=
><div><br></div><div>Marek</div></div><br><div class=3D"gmail_quote gmail_q=
uote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 10, 2025 =
at 7:54=E2=80=AFAM Christian K=C3=B6nig &lt;<a href=3D"mailto:christian.koe=
nig@amd.com">christian.koenig@amd.com</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">On 10.09.25 11:34, Timur Krist=C3=B3f =
wrote:<br>
&gt; On Wed, 2025-09-10 at 10:34 +0200, Christian K=C3=B6nig wrote:<br>
&gt;&gt; On 09.09.25 18:56, Timur Krist=C3=B3f wrote:<br>
&gt;&gt;&gt;&gt; Even when we apply it I think we should drop that, the val=
ue the<br>
&gt;&gt;&gt;&gt; kernel uses is correct.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Hi Christian,<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; The kernel and Mesa disagree on the limits for almost all SDMA=
<br>
&gt;&gt;&gt; versions, so it would be nice to actually understand what the<=
br>
&gt;&gt;&gt; limits of<br>
&gt;&gt;&gt; the SDMA HW are and use the same limit in the kernel and Mesa,=
 or<br>
&gt;&gt;&gt; if<br>
&gt;&gt;&gt; that isn&#39;t viable, let&#39;s document why the different li=
mits make<br>
&gt;&gt;&gt; sense.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I&#39;m adding Marek to CC, he wrote the comment that I refere=
nced<br>
&gt;&gt;&gt; here.<br>
&gt;&gt;&gt; As far as I understand from my conversation with Marek, the ke=
rnel<br>
&gt;&gt;&gt; is<br>
&gt;&gt;&gt; actually wrong.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; If the limits depend on alignment, then we should either set a=
<br>
&gt;&gt;&gt; limit<br>
&gt;&gt;&gt; that is always safe, or make sure SDMA copies in the kernel ar=
e<br>
&gt;&gt;&gt; always<br>
&gt;&gt;&gt; aligned and add assertions about it.<br>
&gt;&gt;<br>
&gt;&gt; That&#39;s already done. See the size restrictions applied to BOs =
and the<br>
&gt;&gt; callers of amdgpu_copy_buffer().<br>
&gt; <br>
&gt; Based on the code comments I cited, as far as I understand, the issue<=
br>
&gt; is with copying the last 256 bytes of 2^22-1. Do I understood your<br>
&gt; response correctly that you are saying that the kernel isn&#39;t affec=
ted<br>
&gt; by this issue because it always copies things that are 256 byte<br>
&gt; aligned?<br>
<br>
Yes, see the kernel always works with at least PAGE_SIZE buffers (between 4=
k and 64k depending on CPU architecture). You never get anything smaller th=
an that.<br>
<br>
The only exception is the debugger interface, but that always copies &lt; P=
AGE_SIZE, so the SDMA limits are irrelevant.<br>
<br>
&gt; I checked the callers of amdgpu_copy_buffer and can&#39;t find what yo=
u are<br>
&gt; referring to. However, assuming that all callers use amdgpu_copy_buffe=
r<br>
&gt; on 256 byte aligned addresses, there is still an issue with large BOs:=
<br>
&gt; <br>
&gt; When the kernel copies a BO that is larger than 0x3fffe0 bytes then it=
<br>
&gt; needs to emit multiple SDMA copy packets, and the copy done by the<br>
&gt; second packet (and other subsequent packets) won&#39;t be 256 byte ali=
gned.<br>
<br>
I&#39;ve just double checked the documentation and for SI it clearly states=
 that the limit is 0x3fffe0. Documentation for later HW says 2^22 - 1 - sta=
rt_addr[4:2] (which is 0x1f in the worst case so you end up with 0x3fffe0 a=
gain).<br>
<br>
For backward, tiled and windowed copies a 256byte bounce buffer is used ins=
tead of the 32byte buffer for the linear copy. So the limit is then 0x3fff0=
0.<br>
<br>
Looks like that buffer is also used for byte aligned copies and that limit =
applies there as well.<br>
<br>
&gt;&gt;<br>
&gt;&gt; We could add another warning to amdgpu_copy_buffer(), but that is<=
br>
&gt;&gt; just the backend function.<br>
&gt;&gt;<br>
&gt;&gt;&gt; Looking at the implementation of<br>
&gt;&gt;&gt; amdgpu_copy_buffer in the kernel, I see that it relies on<br>
&gt;&gt;&gt; copy_max_bytes and doesn&#39;t take alignment into account, so=
 with the<br>
&gt;&gt;&gt; current limit it could issue subsequent copies that aren&#39;t=
 256 byte<br>
&gt;&gt;&gt; aligned.<br>
&gt;&gt;<br>
&gt;&gt; &quot;Due to HW limitation, the maximum count may not be 2^n-1, ca=
n only<br>
&gt;&gt; be 2^n - 1 - start_addr[4:2]&quot;<br>
&gt;&gt;<br>
&gt;&gt; Well according to this comments the size restriction is 32 bytes (=
256<br>
&gt;&gt; bits!) and not 256 bytes.<br>
&gt;&gt;<br>
&gt;&gt; Were do you actually get the 256 bytes restriction from?<br>
&gt; <br>
&gt; The comments I cited above are from the following sources:<br>
&gt; <br>
&gt; PAL uses 1&lt;&lt;22-256 =3D 0x3fff00 here:<br>
&gt; <a href=3D"https://github.com/GPUOpen-Drivers/pal/blob/bcec463efe52607=
76d486a5e3da0c549bc0a75d2/src/core/hw/ossip/oss2/oss2DmaCmdBuffer.cpp#L308"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/GPUOpen-Drivers/pa=
l/blob/bcec463efe5260776d486a5e3da0c549bc0a75d2/src/core/hw/ossip/oss2/oss2=
DmaCmdBuffer.cpp#L308</a><br>
&gt; <br>
&gt; Mesa also uses 0x3fff00 here:<br>
&gt; <a href=3D"https://gitlab.freedesktop.org/mesa/mesa/-/blob/47f5d25f93f=
d36224c112ee2d48e511ae078f8c2/src/amd/common/sid.h#L390" rel=3D"noreferrer"=
 target=3D"_blank">https://gitlab.freedesktop.org/mesa/mesa/-/blob/47f5d25f=
93fd36224c112ee2d48e511ae078f8c2/src/amd/common/sid.h#L390</a><br>
&gt; <br>
&gt; The limit in Mesa was added by this commit:<br>
&gt; <a href=3D"https://gitlab.freedesktop.org/mesa/mesa/-/commit/2c1f249f2=
b61be50222411bc0d41c095004232ed" rel=3D"noreferrer" target=3D"_blank">https=
://gitlab.freedesktop.org/mesa/mesa/-/commit/2c1f249f2b61be50222411bc0d41c0=
95004232ed</a><br>
&gt; According to the commit message, Dave added this limit when hitting an=
<br>
&gt; issue trying to use SDMA with buffers that are larger than this.<br>
&gt; <br>
&gt; For SDMA v5.2 and newer, a larger limit was added by Marek later:<br>
&gt; <a href=3D"https://gitlab.freedesktop.org/mesa/mesa/-/commit/a54bcb942=
9666fcbe38c04660cc4b3f8abbde259" rel=3D"noreferrer" target=3D"_blank">https=
://gitlab.freedesktop.org/mesa/mesa/-/commit/a54bcb9429666fcbe38c04660cc4b3=
f8abbde259</a><br>
&gt; Which confirms the same issue copying the last 256 bytes on these<br>
&gt; versions, although in this case the kernel isn&#39;t technically wrong=
<br>
&gt; because it uses a smaller overall maximum.<br>
<br>
Yeah, I mean that totally makes sense. When you want allow byte aligned cop=
ies as well then you have to use 0x3fff00 as maximum.<br>
<br>
The PAL code even has extra checks to speed up copies where src and dst are=
 byte aligned, but size isn&#39;t:<br>
<br>
=C2=A0 =C2=A0 if (IsPow2Aligned(srcGpuAddr, sizeof(uint32)) &amp;&amp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 IsPow2Aligned(dstGpuAddr, sizeof(uint32)) &amp;=
&amp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (*pBytesCopied &gt;=3D sizeof(uint32)))<br>
....<br>
<br>
So it totally makes sense to use the lower limit in Mesa but not for the ke=
rnel.<br>
<br>
Regards,<br>
Christian.<br>
</blockquote></div>

--000000000000145eb3063e7393f8--
