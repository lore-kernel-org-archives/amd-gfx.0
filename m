Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF3A0C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 12 May 2022 02:39:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6893B10F088;
	Thu, 12 May 2022 02:39:33 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED9E910F088
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 May 2022 02:39:31 +0000 (UTC)
Received: by mail-pl1-x62d.google.com with SMTP id j14so3615084plx.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 May 2022 19:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4fYFmupOUgWyAJnsfpIwOyUViYkOwo0UdiBZO3vkBg8=;
 b=FF03I63dx6FB7O9+okb9VIKvwShr+fhoHXHuyWaA2ozOcSXRgXCP7K/B8gHDk4zXAq
 2jHS4PEzT4XX1BAyO+sE/8alTnjNW/0UmC9/ZopaIVmB2j2YZrr+X4llM9M+8IkMoMnM
 ZoU7adaOrgW4t1gy8uvvWRctOIbjmdjVK+3YYxUmnIB96z1FMdbv8D2oeFs0cOaLkGBg
 V8//Kn+P220VcYTxNiVAYX2XXHzvmvxdFKU7qeAmx+Hxu+9i9uDGXOONnjd/jVryFLzC
 vWpKB4j2c9f7Nv6n7sZZp8WQC7NgnedQy6edPd4G8qsE3YYT+jahWUE6rALukrmA1EEa
 D2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4fYFmupOUgWyAJnsfpIwOyUViYkOwo0UdiBZO3vkBg8=;
 b=dwdgUKtwAHQSBkF9auXmM2X3sjGH/jZdIclr4y2Wqm6zWKnR0VTESiy3iAFhzrKCeg
 7NLgl9Zt+uXkezzF8YbwVa2H/i8R72yD2r6u2GIZEfbqeEoh76GELMIdinxMiRqqvdjw
 B1avJDeKOOlcTU3Rcp3nn++PD/k4FPYUqu8WWlM3vc6ziXc5eccEEUzEuIbSiAmpRT9H
 RjPq0+Urw19EJB/FI/u8PxJZSkvARNmlrZjD4aQefZlh8hKno9R4sqsr/tFNLuH0pDCa
 vHcYofy/kWsHe9a/1onrUuCPgFsMvq9tWxPy0vRp6zjU1209kkpwmOawBh/0R8AcbMVG
 h/BA==
X-Gm-Message-State: AOAM530I65Zq+jDxozwlNQIwOWETxdgNSTBiVb/gTEcCFRwYhQm1XkQB
 sIjVXkJkBs9+DTWSN3DJJeVosWclarUvlqs0WGcttLLc3gQ=
X-Google-Smtp-Source: ABdhPJx392I0LNb885olo7C8ppiDxxJiCqnOHcms53qrCV5paHmcI0IqgmQseIevUu3qqsEp3UmBtL6DJY0Mro3yfCc=
X-Received: by 2002:a17:903:18a:b0:15e:c983:7c2e with SMTP id
 z10-20020a170903018a00b0015ec9837c2emr27619106plg.29.1652323171490; Wed, 11
 May 2022 19:39:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220506112312.347519-1-christian.koenig@amd.com>
 <20220506112312.347519-3-christian.koenig@amd.com>
 <CADnq5_ONANC=SML3sHv3RKG5X2ZYNiv5gvzW_ExRdQdbg=oyhg@mail.gmail.com>
In-Reply-To: <CADnq5_ONANC=SML3sHv3RKG5X2ZYNiv5gvzW_ExRdQdbg=oyhg@mail.gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Wed, 11 May 2022 22:38:55 -0400
Message-ID: <CAAxE2A4W+crVwwz4qNgSTNGc1DXRWu7-WZdAqApNr2cjpz+=Ng@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: bump minor version number
To: Alex Deucher <alexdeucher@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000b0e0c505dec77704"
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
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--000000000000b0e0c505dec77704
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/16466

Marek

On Fri, May 6, 2022 at 9:35 AM Alex Deucher <alexdeucher@gmail.com> wrote:

> On Fri, May 6, 2022 at 7:23 AM Christian K=C3=B6nig
> <ckoenig.leichtzumerken@gmail.com> wrote:
> >
> > Increase the minor version number to indicate that the new flags are
> > avaiable.
>
> typo: available.  Other than that the series is:
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> Once we get the Mesa patches.
>
> Alex
>
>
> >
> > Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > index 16871baee784..3dbf406b4194 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > @@ -99,10 +99,11 @@
> >   * - 3.43.0 - Add device hot plug/unplug support
> >   * - 3.44.0 - DCN3 supports DCC independent block settings: !64B &&
> 128B, 64B && 128B
> >   * - 3.45.0 - Add context ioctl stable pstate interface
> > - * * 3.46.0 - To enable hot plug amdgpu tests in libdrm
> > + * - 3.46.0 - To enable hot plug amdgpu tests in libdrm
> > + * * 3.47.0 - Add AMDGPU_GEM_CREATE_DISCARDABLE and AMDGPU_VM_NOALLOC
> flags
> >   */
> >  #define KMS_DRIVER_MAJOR       3
> > -#define KMS_DRIVER_MINOR       46
> > +#define KMS_DRIVER_MINOR       47
> >  #define KMS_DRIVER_PATCHLEVEL  0
> >
> >  int amdgpu_vram_limit;
> > --
> > 2.25.1
> >
>

--000000000000b0e0c505dec77704
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><a href=3D"https://gitlab.freedesktop.org/mesa/mesa/-=
/merge_requests/16466">https://gitlab.freedesktop.org/mesa/mesa/-/merge_req=
uests/16466</a></div><div><br></div><div>Marek<br></div></div><br><div clas=
s=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, May 6, 2022=
 at 9:35 AM Alex Deucher &lt;<a href=3D"mailto:alexdeucher@gmail.com">alexd=
eucher@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">On Fri, May 6, 2022 at 7:23 AM Christian K=C3=B6nig<br>
&lt;<a href=3D"mailto:ckoenig.leichtzumerken@gmail.com" target=3D"_blank">c=
koenig.leichtzumerken@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Increase the minor version number to indicate that the new flags are<b=
r>
&gt; avaiable.<br>
<br>
typo: available.=C2=A0 Other than that the series is:<br>
Reviewed-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com" =
target=3D"_blank">alexander.deucher@amd.com</a>&gt;<br>
Once we get the Mesa patches.<br>
<br>
Alex<br>
<br>
<br>
&gt;<br>
&gt; Signed-off-by: Christian K=C3=B6nig &lt;<a href=3D"mailto:christian.ko=
enig@amd.com" target=3D"_blank">christian.koenig@amd.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 +++--<br>
&gt;=C2=A0 1 file changed, 3 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_drv.c<br>
&gt; index 16871baee784..3dbf406b4194 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt; @@ -99,10 +99,11 @@<br>
&gt;=C2=A0 =C2=A0* - 3.43.0 - Add device hot plug/unplug support<br>
&gt;=C2=A0 =C2=A0* - 3.44.0 - DCN3 supports DCC independent block settings:=
 !64B &amp;&amp; 128B, 64B &amp;&amp; 128B<br>
&gt;=C2=A0 =C2=A0* - 3.45.0 - Add context ioctl stable pstate interface<br>
&gt; - * * 3.46.0 - To enable hot plug amdgpu tests in libdrm<br>
&gt; + * - 3.46.0 - To enable hot plug amdgpu tests in libdrm<br>
&gt; + * * 3.47.0 - Add AMDGPU_GEM_CREATE_DISCARDABLE and AMDGPU_VM_NOALLOC=
 flags<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 #define KMS_DRIVER_MAJOR=C2=A0 =C2=A0 =C2=A0 =C2=A03<br>
&gt; -#define KMS_DRIVER_MINOR=C2=A0 =C2=A0 =C2=A0 =C2=A046<br>
&gt; +#define KMS_DRIVER_MINOR=C2=A0 =C2=A0 =C2=A0 =C2=A047<br>
&gt;=C2=A0 #define KMS_DRIVER_PATCHLEVEL=C2=A0 0<br>
&gt;<br>
&gt;=C2=A0 int amdgpu_vram_limit;<br>
&gt; --<br>
&gt; 2.25.1<br>
&gt;<br>
</blockquote></div>

--000000000000b0e0c505dec77704--
