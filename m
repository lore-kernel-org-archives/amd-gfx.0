Return-Path: <SRS0=0ArA=CP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E65BC43461
	for <amd-gfx@archiver.kernel.org>; Sun,  6 Sep 2020 16:02:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 006FC20708
	for <amd-gfx@archiver.kernel.org>; Sun,  6 Sep 2020 16:02:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 006FC20708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rutgers.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84E7989E9E;
	Sun,  6 Sep 2020 16:02:34 +0000 (UTC)
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59B6689E9E
 for <amd-gfx@lists.freedesktop.org>; Sun,  6 Sep 2020 16:02:33 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id v4so11101357wmj.5
 for <amd-gfx@lists.freedesktop.org>; Sun, 06 Sep 2020 09:02:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pddDVeJenwYfh04G7/IkcNKdGLHeVQonCKyb4Nvbcvk=;
 b=tZKHTDHRngsBpQz3gD5lelee5SvFcH6s1YjNr1wX5tRPSPjgM/Nn40RioIMd0GR6lV
 n3y81vM5dnJ2J3ZxRBjt6KjJuKfgKjipr/t+asdWBPL8hYEVt84RG0doqbtAjj+0QnZm
 RAkUCapaIQArEb2Bdva7Cz75cSkX1tihj3AOP6mh55dOYMvVsiT1JgmWW2DhB6FBwwpl
 uz62ysbRjfFoUUj7EB90mZOwBsodDS/7vP3D/yUUhz7xZqjLWyqwUY3h1XN1+sK5czKE
 F0JgQPPyqIMCYXRgEK6YqEEh6Z6Nx+q7J4+LJssQuWJ/loecL2ShNMqxO48H8oHJUpVO
 NxBw==
X-Gm-Message-State: AOAM533Tb5NCUkIm6XiVWiLJrk6Xj3/oViwJlAXMMXyHvdw9IL6VhRyN
 EseqS1XCw8tot1e1Zy/m5HwrQnWNKHhBgv65ryvhlg==
X-Google-Smtp-Source: ABdhPJyvgh+AWY+nEOlHpkW0pXIyxbp22nUshnI8SR+1m+ybTNtoaP41vbnMJN+X881vt38lpwlcN1fBv4u2gKIo3W8=
X-Received: by 2002:a1c:988d:: with SMTP id a135mr16532723wme.8.1599408151784; 
 Sun, 06 Sep 2020 09:02:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190803000908.5310-1-andi@firstfloor.org>
 <47558836-612d-75e3-c4a8-7b8baf53036d@gmail.com>
In-Reply-To: <47558836-612d-75e3-c4a8-7b8baf53036d@gmail.com>
From: Jan Vesely <jan.vesely@rutgers.edu>
Date: Sun, 6 Sep 2020 12:02:20 -0400
Message-ID: <CABE_ZV3Uk69RXv9RYj5d7cNXi5pX16Ve8qkkGPB5=OAX5b_6Rg@mail.gmail.com>
Subject: Re: [PATCH] radeon: Use only a single work queue thread for crt
To: "Koenig, Christian" <christian.koenig@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Andi Kleen <ak@linux.intel.com>,
 Andi Kleen <andi@firstfloor.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============2074061098=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2074061098==
Content-Type: multipart/alternative; boundary="000000000000bd2e1205aea73a74"

--000000000000bd2e1205aea73a74
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 6, 2020 at 4:54 AM Christian K=C3=B6nig <
ckoenig.leichtzumerken@gmail.com> wrote:

> Am 03.08.19 um 02:09 schrieb Andi Kleen:
> > From: Andi Kleen <ak@linux.intel.com>
> >
> > I got tired of seeing a lot of radeon-crt kernel threads in ps on my
> > workstation, one for each CPU and one for each display, which never use
> any CPU time.
> > Surely a single kernel thread is enough to handle the display.
>
> NAK, radeon blocks inside the kernel thread and those need to run in
> parallel or otherwise the hardware can hang.
>

Shouldn't WQ_UNBOUND create a new worker thread whenever all current
workers go to sleep/block (and the total number of worker threads is below
'max_active') ?

Jan

>
> Christian.
>
> >
> > Signed-off-by: Andi Kleen <ak@linux.intel.com>
> > ---
> >   drivers/gpu/drm/radeon/radeon_display.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/radeon/radeon_display.c
> b/drivers/gpu/drm/radeon/radeon_display.c
> > index bd52f15e6330..fb0ca688f6fe 100644
> > --- a/drivers/gpu/drm/radeon/radeon_display.c
> > +++ b/drivers/gpu/drm/radeon/radeon_display.c
> > @@ -682,7 +682,7 @@ static void radeon_crtc_init(struct drm_device *dev=
,
> int index)
> >
> >       drm_mode_crtc_set_gamma_size(&radeon_crtc->base, 256);
> >       radeon_crtc->crtc_id =3D index;
> > -     radeon_crtc->flip_queue =3D alloc_workqueue("radeon-crtc",
> WQ_HIGHPRI, 0);
> > +     radeon_crtc->flip_queue =3D alloc_workqueue("radeon-crtc",
> WQ_HIGHPRI|WQ_UNBOUND, 0);
> >       rdev->mode_info.crtcs[index] =3D radeon_crtc;
> >
> >       if (rdev->family >=3D CHIP_BONAIRE) {
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--000000000000bd2e1205aea73a74
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sun, Sep 6, 2020 at 4:54 AM Christ=
ian K=C3=B6nig &lt;<a href=3D"mailto:ckoenig.leichtzumerken@gmail.com">ckoe=
nig.leichtzumerken@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">Am 03.08.19 um 02:09 schrieb Andi Kleen:<br>
&gt; From: Andi Kleen &lt;<a href=3D"mailto:ak@linux.intel.com" target=3D"_=
blank">ak@linux.intel.com</a>&gt;<br>
&gt;<br>
&gt; I got tired of seeing a lot of radeon-crt kernel threads in ps on my<b=
r>
&gt; workstation, one for each CPU and one for each display, which never us=
e any CPU time.<br>
&gt; Surely a single kernel thread is enough to handle the display.<br>
<br>
NAK, radeon blocks inside the kernel thread and those need to run in <br>
parallel or otherwise the hardware can hang.<br></blockquote><div><br>Shoul=
dn&#39;t WQ_UNBOUND create a new worker thread whenever all current workers=
 go to sleep/block (and the total number of worker threads is below &#39;ma=
x_active&#39;) ?<br><br></div><div>Jan</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
<br>
Christian.<br>
<br>
&gt;<br>
&gt; Signed-off-by: Andi Kleen &lt;<a href=3D"mailto:ak@linux.intel.com" ta=
rget=3D"_blank">ak@linux.intel.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0drivers/gpu/drm/radeon/radeon_display.c | 2 +-<br>
&gt;=C2=A0 =C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm=
/radeon/radeon_display.c<br>
&gt; index bd52f15e6330..fb0ca688f6fe 100644<br>
&gt; --- a/drivers/gpu/drm/radeon/radeon_display.c<br>
&gt; +++ b/drivers/gpu/drm/radeon/radeon_display.c<br>
&gt; @@ -682,7 +682,7 @@ static void radeon_crtc_init(struct drm_device *de=
v, int index)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0drm_mode_crtc_set_gamma_size(&amp;radeon_crt=
c-&gt;base, 256);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0radeon_crtc-&gt;crtc_id =3D index;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0radeon_crtc-&gt;flip_queue =3D alloc_workqueue(&q=
uot;radeon-crtc&quot;, WQ_HIGHPRI, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0radeon_crtc-&gt;flip_queue =3D alloc_workqueue(&q=
uot;radeon-crtc&quot;, WQ_HIGHPRI|WQ_UNBOUND, 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rdev-&gt;mode_info.crtcs[index] =3D radeon_c=
rtc;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rdev-&gt;family &gt;=3D CHIP_BONAIRE) {<=
br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx</a><br>
</blockquote></div></div>

--000000000000bd2e1205aea73a74--

--===============2074061098==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2074061098==--
