Return-Path: <SRS0=tiv0=75=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA31C433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2020 07:10:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E32BA2082F
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2020 07:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eC2YqrSN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E32BA2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E12506E83B;
	Tue, 16 Jun 2020 07:09:42 +0000 (UTC)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 042FE6E802
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2020 07:09:19 +0000 (UTC)
Received: by mail-io1-xd2f.google.com with SMTP id u13so918278iol.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2020 00:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7JZn+FuB9xhM5RT+0VWvfwextTA8tzEcr448aYKv3k8=;
 b=eC2YqrSNieuvaPpPU0YYL0tYbW7OLXHXSTfwy5/5LAKBfAhoqss8iDghEaktP5/+2l
 D8YRJorW46vy8SdepZjWhTK+2T2xi5f9Dlq6t1wBPYQB2dK9v7vF4jIXDc3GD/jtCRag
 aU8YE5A90rNc00pjrMMV9r7DNnIJiCdRqSM3lg5s70OA4uqbRN3yVwmg7FKXz7URKQwY
 vMAgl4YHNVVAVObhxamzYveP3o7e4Dee3IuXywHWpQqhGrn/Z2CzPFkJud1ZCrt6NDQR
 vDxBXhqW9/OrnfhY3SYMvuZ09cmame90lgaXjgkvNI4b76s09Px4qX22htonAa07xJ9H
 gmAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7JZn+FuB9xhM5RT+0VWvfwextTA8tzEcr448aYKv3k8=;
 b=drWC4E4EH9r2mCTjdKHME8mYcqiGRw5jmjBO2B1nkrxXUcaSCzfRYfaZqLvEhV1w3b
 PX+xHkgQT1ep1bUpYhGKY6E5HiHuAH8l6GKA0CW1t2ycS1hcLJFLetDTCDFMBOW7DiT+
 PJaltvoq9NHKiOz6Of7uJe84FCOFKNtsaf6KS0jWvpt7SAdRAjBgjt25nCthNErYYt1Q
 KJM4MY+b6Io7D26iJfK8UfxV+/At6CjFGqdSOeGeo8q9n4U0CNEyJ4Yi9SDBJMqhNeyI
 g7r+GzaupDybmb0DCUUpH67T8IAUJlIU1ozzLfDYgimY1DoIc0Nag7YpaZFSoJLi4b0A
 I8pQ==
X-Gm-Message-State: AOAM531GbGOq2GLDKG/X5HkbyRuODKSkiMNpHcsYGlBfsawdh1FScotH
 kz6jFq2H6MlLqqF7isN+6Gpnsp+AojLvyoF2DMA=
X-Google-Smtp-Source: ABdhPJxlEIgeZW7RQpGMd2uUV/8yXGc852JJ2LKcLPidh5+bYnU7FRbghMJJUvPPjIjCtJmesWlNUt/FjZri44YTsI8=
X-Received: by 2002:a05:6602:2431:: with SMTP id
 g17mr1281452iob.3.1592291359298; 
 Tue, 16 Jun 2020 00:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAMpQs4L6=Fh8XEoz0K7t1rd34ZRXhW--NPp_CWa7fNoo+CKGUA@mail.gmail.com>
 <CADnq5_OCOmKSSid8nV8tPJTkY-CQXSkiYxGx5xoRkDj0G06QxQ@mail.gmail.com>
 <CAMpQs4+4O9aDb4CDaxwfSc8qA9gpRHAMjAEyESAHv+ALyzNU4g@mail.gmail.com>
In-Reply-To: <CAMpQs4+4O9aDb4CDaxwfSc8qA9gpRHAMjAEyESAHv+ALyzNU4g@mail.gmail.com>
From: =?UTF-8?Q?Ernst_Sj=C3=B6strand?= <ernstp@gmail.com>
Date: Tue, 16 Jun 2020 09:09:08 +0200
Message-ID: <CAD=4a=X0QT49jBnx8UgobR-F4g27MGwzcU67sab4VEj=ecFi8A@mail.gmail.com>
Subject: Re: The inherent defect of the AMDGPU driver about hotplug
To: Aaron Chou <zhoubb.aaron@gmail.com>
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
Cc: Alex Deucher <alexdeucher@gmail.com>, "Deucher,
 Alexander" <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1941661739=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1941661739==
Content-Type: multipart/alternative; boundary="000000000000d99a2e05a82e389b"

--000000000000d99a2e05a82e389b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Have you tried a much later kernel btw? I saw you mentioned 4.19.

Den tis 16 juni 2020 kl 02:50 skrev Aaron Chou <zhoubb.aaron@gmail.com>:

> Yes, I agree.
>
> On Tue, Jun 16, 2020 at 3:08 AM Alex Deucher <alexdeucher@gmail.com>
> wrote:
> >
> > On Mon, Jun 15, 2020 at 5:30 AM Aaron Chou <zhoubb.aaron@gmail.com>
> wrote:
> > >
> > > About one month ago, I have asked a question about HDMI hotplug, the
> link is:
> > >
> > > https://gitlab.freedesktop.org/drm/amd/-/issues/1135#note_492460
> > >
> > > And I have put one patch to fix this, as follows:
> > >
> > >  39 diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> > >  40 index f355d9a752d2..ee657db9a228 100644
> > >  41 --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> > >  42 +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> > >  43 @@ -973,7 +973,7 @@ amdgpu_connector_dvi_detect(struct
> > > drm_connector *connector, bool force)
> > >  44         const struct drm_encoder_helper_funcs *encoder_funcs;
> > >  45         int r;
> > >  46         enum drm_connector_status ret =3D
> > > connector_status_disconnected;
> > >  47 -       bool dret =3D false, broken_edid =3D false;
> > >  48 +       bool dret =3D false, broken_edid =3D false, undefined_fla=
g =3D
> > > false;
> > >  49
> > >  50         if (!drm_kms_helper_is_poll_worker()) {
> > >  51                 r =3D pm_runtime_get_sync(connector->dev->dev);
> > >  52 @@ -988,7 +988,12 @@ amdgpu_connector_dvi_detect(struct
> > > drm_connector *connector, bool force)
> > >  53
> > >  54         if (amdgpu_connector->ddc_bus)
> > >  55                 dret =3D amdgpu_display_ddc_probe(amdgpu_connecto=
r,
> > > false);
> > >  56 -       if (dret) {
> > >  57 +
> > >  58 +       /* Check the HDMI HPD pin status again */
> > >  59 +       if (!amdgpu_display_hpd_sense(adev,
> > > amdgpu_connector->hpd.hpd))
> > >  60 +               undefined_flag =3D true;
> > >  61 +
> > >  62 +       if (dret && !undefined_flag) {
> > >  63                 amdgpu_connector->detected_by_load =3D false;
> > >  64                 amdgpu_connector_free_edid(connector);
> > >  65                 amdgpu_connector_get_edid(connector);
> > >
> > > Maybe the fix is sloppy, so I write the another patch:
> > >
> > >  16 diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> > >  17 index c770d73352a7..bb59ebc9a6c8 100644
> > >  18 --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> > >  19 +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> > >  20 @@ -991,6 +991,7 @@ amdgpu_connector_dvi_detect(struct
> > > drm_connector *connector, bool force)
> > >  21         if (amdgpu_connector->ddc_bus)
> > >  22                 dret =3D amdgpu_display_ddc_probe(amdgpu_connecto=
r,
> > > false);
> > >  23         if (dret) {
> > >  24 +               schedule_work(&adev->hotplug_work);
> > >  25                 amdgpu_connector->detected_by_load =3D false;
> > >  26                 amdgpu_connector_free_edid(connector);
> > >  27                 amdgpu_connector_get_edid(connector);
> > >
> > > Which is better, or neither=EF=BC=9F
> >
> > As per the last discussion:
> >
> > "This is the part I don't understand.  The logic already checks the HPD
> > status in amdgpu_connector_check_hpd_status_unchanged().  Does it
> > still report connected at that point?  After that it tries to read the
> > EDID in amdgpu_display_ddc_probe().  If the monitor is disconnected,
> > there should be no EDID so dret should be false.  We should try and
> > figure out why the first HPD check reports connected and the EDID
> > probe returns true."
> >
> > There is already an HPD probe in the current logic.  We should try and
> > understand why we need a second one rather than just adding one.  Does
> > a delay at the top of that function help?
> >
> > Alex
> >
> > >
> > > --
> > > Regards,
> > > Aaron
> > > _______________________________________________
> > > amd-gfx mailing list
> > > amd-gfx@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--000000000000d99a2e05a82e389b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:arial,he=
lvetica,sans-serif">Have you tried a much later kernel btw? I saw you menti=
oned 4.19.<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" c=
lass=3D"gmail_attr">Den tis 16 juni 2020 kl 02:50 skrev Aaron Chou &lt;<a h=
ref=3D"mailto:zhoubb.aaron@gmail.com">zhoubb.aaron@gmail.com</a>&gt;:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">Yes, I agree.<br>
<br>
On Tue, Jun 16, 2020 at 3:08 AM Alex Deucher &lt;<a href=3D"mailto:alexdeuc=
her@gmail.com" target=3D"_blank">alexdeucher@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; On Mon, Jun 15, 2020 at 5:30 AM Aaron Chou &lt;<a href=3D"mailto:zhoub=
b.aaron@gmail.com" target=3D"_blank">zhoubb.aaron@gmail.com</a>&gt; wrote:<=
br>
&gt; &gt;<br>
&gt; &gt; About one month ago, I have asked a question about HDMI hotplug, =
the link is:<br>
&gt; &gt;<br>
&gt; &gt; <a href=3D"https://gitlab.freedesktop.org/drm/amd/-/issues/1135#n=
ote_492460" rel=3D"noreferrer" target=3D"_blank">https://gitlab.freedesktop=
.org/drm/amd/-/issues/1135#note_492460</a><br>
&gt; &gt;<br>
&gt; &gt; And I have put one patch to fix this, as follows:<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 39 diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connector=
s.c<br>
&gt; &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c<br>
&gt; &gt;=C2=A0 40 index f355d9a752d2..ee657db9a228 100644<br>
&gt; &gt;=C2=A0 41 --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c<br>
&gt; &gt;=C2=A0 42 +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c<br>
&gt; &gt;=C2=A0 43 @@ -973,7 +973,7 @@ amdgpu_connector_dvi_detect(struct<b=
r>
&gt; &gt; drm_connector *connector, bool force)<br>
&gt; &gt;=C2=A0 44=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct drm_encode=
r_helper_funcs *encoder_funcs;<br>
&gt; &gt;=C2=A0 45=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int r;<br>
&gt; &gt;=C2=A0 46=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enum drm_connector_stat=
us ret =3D<br>
&gt; &gt; connector_status_disconnected;<br>
&gt; &gt;=C2=A0 47 -=C2=A0 =C2=A0 =C2=A0 =C2=A0bool dret =3D false, broken_=
edid =3D false;<br>
&gt; &gt;=C2=A0 48 +=C2=A0 =C2=A0 =C2=A0 =C2=A0bool dret =3D false, broken_=
edid =3D false, undefined_flag =3D<br>
&gt; &gt; false;<br>
&gt; &gt;=C2=A0 49<br>
&gt; &gt;=C2=A0 50=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!drm_kms_helper_is_=
poll_worker()) {<br>
&gt; &gt;=C2=A0 51=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0r =3D pm_runtime_get_sync(connector-&gt;dev-&gt;dev);<br>
&gt; &gt;=C2=A0 52 @@ -988,7 +988,12 @@ amdgpu_connector_dvi_detect(struct<=
br>
&gt; &gt; drm_connector *connector, bool force)<br>
&gt; &gt;=C2=A0 53<br>
&gt; &gt;=C2=A0 54=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (amdgpu_connector-&g=
t;ddc_bus)<br>
&gt; &gt;=C2=A0 55=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0dret =3D amdgpu_display_ddc_probe(amdgpu_connector,<br>
&gt; &gt; false);<br>
&gt; &gt;=C2=A0 56 -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (dret) {<br>
&gt; &gt;=C2=A0 57 +<br>
&gt; &gt;=C2=A0 58 +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Check the HDMI HPD pin st=
atus again */<br>
&gt; &gt;=C2=A0 59 +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!amdgpu_display_hpd_sens=
e(adev,<br>
&gt; &gt; amdgpu_connector-&gt;hpd.hpd))<br>
&gt; &gt;=C2=A0 60 +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
undefined_flag =3D true;<br>
&gt; &gt;=C2=A0 61 +<br>
&gt; &gt;=C2=A0 62 +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (dret &amp;&amp; !undefin=
ed_flag) {<br>
&gt; &gt;=C2=A0 63=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0amdgpu_connector-&gt;detected_by_load =3D false;<br>
&gt; &gt;=C2=A0 64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0amdgpu_connector_free_edid(connector);<br>
&gt; &gt;=C2=A0 65=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0amdgpu_connector_get_edid(connector);<br>
&gt; &gt;<br>
&gt; &gt; Maybe the fix is sloppy, so I write the another patch:<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 16 diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connector=
s.c<br>
&gt; &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c<br>
&gt; &gt;=C2=A0 17 index c770d73352a7..bb59ebc9a6c8 100644<br>
&gt; &gt;=C2=A0 18 --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c<br>
&gt; &gt;=C2=A0 19 +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c<br>
&gt; &gt;=C2=A0 20 @@ -991,6 +991,7 @@ amdgpu_connector_dvi_detect(struct<b=
r>
&gt; &gt; drm_connector *connector, bool force)<br>
&gt; &gt;=C2=A0 21=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (amdgpu_connector-&g=
t;ddc_bus)<br>
&gt; &gt;=C2=A0 22=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0dret =3D amdgpu_display_ddc_probe(amdgpu_connector,<br>
&gt; &gt; false);<br>
&gt; &gt;=C2=A0 23=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dret) {<br>
&gt; &gt;=C2=A0 24 +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
schedule_work(&amp;adev-&gt;hotplug_work);<br>
&gt; &gt;=C2=A0 25=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0amdgpu_connector-&gt;detected_by_load =3D false;<br>
&gt; &gt;=C2=A0 26=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0amdgpu_connector_free_edid(connector);<br>
&gt; &gt;=C2=A0 27=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0amdgpu_connector_get_edid(connector);<br>
&gt; &gt;<br>
&gt; &gt; Which is better, or neither=EF=BC=9F<br>
&gt;<br>
&gt; As per the last discussion:<br>
&gt;<br>
&gt; &quot;This is the part I don&#39;t understand.=C2=A0 The logic already=
 checks the HPD<br>
&gt; status in amdgpu_connector_check_hpd_status_unchanged().=C2=A0 Does it=
<br>
&gt; still report connected at that point?=C2=A0 After that it tries to rea=
d the<br>
&gt; EDID in amdgpu_display_ddc_probe().=C2=A0 If the monitor is disconnect=
ed,<br>
&gt; there should be no EDID so dret should be false.=C2=A0 We should try a=
nd<br>
&gt; figure out why the first HPD check reports connected and the EDID<br>
&gt; probe returns true.&quot;<br>
&gt;<br>
&gt; There is already an HPD probe in the current logic.=C2=A0 We should tr=
y and<br>
&gt; understand why we need a second one rather than just adding one.=C2=A0=
 Does<br>
&gt; a delay at the top of that function help?<br>
&gt;<br>
&gt; Alex<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; --<br>
&gt; &gt; Regards,<br>
&gt; &gt; Aaron<br>
&gt; &gt; _______________________________________________<br>
&gt; &gt; amd-gfx mailing list<br>
&gt; &gt; <a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank=
">amd-gfx@lists.freedesktop.org</a><br>
&gt; &gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx=
" rel=3D"noreferrer" target=3D"_blank">https://lists.freedesktop.org/mailma=
n/listinfo/amd-gfx</a><br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx</a><br>
</blockquote></div>

--000000000000d99a2e05a82e389b--

--===============1941661739==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1941661739==--
