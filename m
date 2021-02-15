Return-Path: <SRS0=jhpT=HR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59196C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Feb 2021 21:32:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BB7864DEB
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Feb 2021 21:32:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BB7864DEB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB84889E0C;
	Mon, 15 Feb 2021 21:32:14 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4EDE89E0C;
 Mon, 15 Feb 2021 21:32:13 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id g5so10052666ejt.2;
 Mon, 15 Feb 2021 13:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4IZ+6tcJXefO0wP7XettVKiSAYw8xLoxhlV7k9i0lmc=;
 b=Zqi0URY23sSzLY8qr5zkiKJkbqC2D4RjLgMQ+dq7q9g+nI6Taxjd5dPFsJV3KKvZWS
 xr2qBphmoCOVbKcGg7nDY6gCtEHVn3X+DnnDl8WLtce6Myw9iB1aa6A5kgGwOm+eFp1N
 fFf/W5m7wnwJ+q8AS8NOgXRtTG5iNNgR7yj2rkssDlXxR5H1Egk7SAAg8cB+YTnxBg4r
 f67C2bElkuJj//OtbfPpRCHiqLdYMQV3Cfm/HE/iZsEZLRq27+4eI1zCpXfkJf8izs0g
 II6jaACTQ6V8mNjAnQNlBSTnahiZB1PH2uydf+mBrbe5iglj/Pao8QQD4KBedvFqt6uc
 /eIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4IZ+6tcJXefO0wP7XettVKiSAYw8xLoxhlV7k9i0lmc=;
 b=QIFYYyAn2EuTt4xzBXfaS0NbmOk46ySJloHwKdkIGQbXCOkqyHgj+vlWOmsZ1bPPNl
 L1/F9rRoazbxvl8K4E7QBzBf5ZsgNHcmlWJkTaN+D8MBi1UoVA0bUhw6O0JmAvzP2r8k
 QRq4Tw0u4Tb2G4b+zZYD3CDvKg649UAUmXu4Tr7gkqBXzDMEWCPmP/hUVMxOHL8l8rSN
 2wPOu1BSLPOkVqbFFJYSCDmWZn5VTl5OsU4alnmCvX5wjW0X7E1/UwjL10MJ7RafU/Cx
 DkHV3oWRcnwaXavPBGyp5kHvwXgtQcWxUCsUs9SdcTedkOb3vUDmAveeO5EUSsphXX2U
 bf7g==
X-Gm-Message-State: AOAM530SkEE0s/uqf8CvUMexK0AGrrK0XtMEVMZ8jhwSKitC4IG9PVEG
 /QRXjRGpu2ghySD8L8sK8eswlzsO0Llmb+xW/0o=
X-Google-Smtp-Source: ABdhPJyEXF43GE/IZOKoA9Kh5IZumMCVKuI7qx9eUF5CsilXPuV2WP+RJPbVdtPtvj1tPXC1bYf4aA7yS39dMeE3CUQ=
X-Received: by 2002:a17:906:4013:: with SMTP id
 v19mr17906648ejj.5.1613424732388; 
 Mon, 15 Feb 2021 13:32:12 -0800 (PST)
MIME-Version: 1.0
References: <20210212222954.6510-1-mario.kleiner.de@gmail.com>
 <CADnq5_OwuiAjDcP+xwspbN+H7+=aLdnGE51O0qiALnHhmjaZiQ@mail.gmail.com>
In-Reply-To: <CADnq5_OwuiAjDcP+xwspbN+H7+=aLdnGE51O0qiALnHhmjaZiQ@mail.gmail.com>
From: Mario Kleiner <mario.kleiner.de@gmail.com>
Date: Mon, 15 Feb 2021 22:32:00 +0100
Message-ID: <CAEsyxyjDNHtLiCx+ELjak5ezh8JjNUOSuuP3664aYO4dn3YzvQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Allow spatial dither to 10 bpc on all !=
 DCE-11.0.
To: Alex Deucher <alexdeucher@gmail.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, "Wentland,
 Harry" <harry.wentland@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0035889074=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0035889074==
Content-Type: multipart/alternative; boundary="0000000000000bbf2905bb66b87d"

--0000000000000bbf2905bb66b87d
Content-Type: text/plain; charset="UTF-8"

On Mon, Feb 15, 2021 at 8:09 PM Alex Deucher <alexdeucher@gmail.com> wrote:

> On Fri, Feb 12, 2021 at 5:30 PM Mario Kleiner
> <mario.kleiner.de@gmail.com> wrote:
> >
> > Spatial dithering to 10 bpc depth was disabled for all DCE's.
> > Restrict this to DCE-11.0, but allow it on other DCE's.
> >
> > Testing on DCE-8.3 and DCE-11.2 did not show any obvious ill
> > effects, but a measureable precision improvement (via colorimeter)
> > when displaying a fp16 framebuffer to a 10 bpc DP or HDMI connected
> > HDR-10 monitor.
> >
> > Alex suggests this may have been a workaround for some DCE-11.0
> > Carrizo and Stoney Asics, so lets try to restrict this to DCE 11.0.
> >
> > Signed-off-by: Mario Kleiner <mario.kleiner.de@gmail.com>
> > Cc: Alex Deucher <alexdeucher@gmail.com>
> > ---
> >  drivers/gpu/drm/amd/display/dc/dce/dce_opp.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c
> b/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c
> > index 4600231da6cb..4ed886cdb8d8 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c
> > @@ -216,9 +216,12 @@ static void set_spatial_dither(
> >         REG_UPDATE(FMT_BIT_DEPTH_CONTROL,
> >                 FMT_TEMPORAL_DITHER_EN, 0);
> >
> > -       /* no 10bpc on DCE11*/
> > -       if (params->flags.SPATIAL_DITHER_ENABLED == 0 ||
> > -               params->flags.SPATIAL_DITHER_DEPTH == 2)
> > +       if (params->flags.SPATIAL_DITHER_ENABLED == 0)
> > +               return;
> > +
> > +       /* No dithering to 10 bpc on DCE-11.0 */
> > +       if (params->flags.SPATIAL_DITHER_DEPTH == 2 &&
> > +               opp110->base.ctx->dce_version == DCE_VERSION_11_0)
> >                 return;
>
> I'm inclined to just remove this check altogether.  This is just the
> dithering control.  I think the limitations are more around the
> formats (e.g., FP formats) than the dithering.
>
> Alex
>
>
Certainly no objections from myself.
-mario



>
> >
> >         /* only use FRAME_COUNTER_MAX if frameRandom == 1*/
> > --
> > 2.25.1
> >
>

--0000000000000bbf2905bb66b87d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Mon, Feb 15, 2021 at 8:09 PM Alex Deuc=
her &lt;<a href=3D"mailto:alexdeucher@gmail.com">alexdeucher@gmail.com</a>&=
gt; wrote:<br></div><div class=3D"gmail_quote"><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">On Fri, Feb 12, 2021 at 5:30 PM Mario Kleiner<br>
&lt;<a href=3D"mailto:mario.kleiner.de@gmail.com" target=3D"_blank">mario.k=
leiner.de@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Spatial dithering to 10 bpc depth was disabled for all DCE&#39;s.<br>
&gt; Restrict this to DCE-11.0, but allow it on other DCE&#39;s.<br>
&gt;<br>
&gt; Testing on DCE-8.3 and DCE-11.2 did not show any obvious ill<br>
&gt; effects, but a measureable precision improvement (via colorimeter)<br>
&gt; when displaying a fp16 framebuffer to a 10 bpc DP or HDMI connected<br=
>
&gt; HDR-10 monitor.<br>
&gt;<br>
&gt; Alex suggests this may have been a workaround for some DCE-11.0<br>
&gt; Carrizo and Stoney Asics, so lets try to restrict this to DCE 11.0.<br=
>
&gt;<br>
&gt; Signed-off-by: Mario Kleiner &lt;<a href=3D"mailto:mario.kleiner.de@gm=
ail.com" target=3D"_blank">mario.kleiner.de@gmail.com</a>&gt;<br>
&gt; Cc: Alex Deucher &lt;<a href=3D"mailto:alexdeucher@gmail.com" target=
=3D"_blank">alexdeucher@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/gpu/drm/amd/display/dc/dce/dce_opp.c | 9 ++++++---<br>
&gt;=C2=A0 1 file changed, 6 insertions(+), 3 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c b/drivers/gp=
u/drm/amd/display/dc/dce/dce_opp.c<br>
&gt; index 4600231da6cb..4ed886cdb8d8 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c<br>
&gt; @@ -216,9 +216,12 @@ static void set_spatial_dither(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0REG_UPDATE(FMT_BIT_DEPTH_CONTROL,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0FMT_TEMPO=
RAL_DITHER_EN, 0);<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0/* no 10bpc on DCE11*/<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (params-&gt;flags.SPATIAL_DITHER_ENABLE=
D =3D=3D 0 ||<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0params-&gt;fla=
gs.SPATIAL_DITHER_DEPTH =3D=3D 2)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (params-&gt;flags.SPATIAL_DITHER_ENABLE=
D =3D=3D 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* No dithering to 10 bpc on DCE-11.0 */<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (params-&gt;flags.SPATIAL_DITHER_DEPTH =
=3D=3D 2 &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0opp110-&gt;bas=
e.ctx-&gt;dce_version =3D=3D DCE_VERSION_11_0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<b=
r>
<br>
I&#39;m inclined to just remove this check altogether.=C2=A0 This is just t=
he<br>
dithering control.=C2=A0 I think the limitations are more around the<br>
formats (e.g., FP formats) than the dithering.<br>
<br>
Alex<br>
<br></blockquote><div>=C2=A0</div><div>Certainly no objections from myself.=
</div><div>-mario<br></div><div><br></div><div>=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* only use FRAME_COUNTER_MAX if fram=
eRandom =3D=3D 1*/<br>
&gt; --<br>
&gt; 2.25.1<br>
&gt;<br>
</blockquote></div></div>

--0000000000000bbf2905bb66b87d--

--===============0035889074==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0035889074==--
