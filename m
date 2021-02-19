Return-Path: <SRS0=jKCf=HV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D408C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 02:28:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC75C64ED9
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 02:28:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC75C64ED9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 733226EA7A;
	Fri, 19 Feb 2021 02:28:18 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD4696EA7A
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Feb 2021 02:28:16 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id h10so6902521edl.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Feb 2021 18:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GG7CxeOjSsxNMcsShJqeoEt3lOP3ckNPy08TwZRtHAQ=;
 b=ZFZBlZw/+FSQlIwEtWkaUVqjUEA2i3c2qANS+V7Lh5dHtzCFO9ygAyJG9cw3CCjv9S
 eKGnfINT3VMWAtxIsUHPo4OfJapN80b+mRgQ2JfS3Sd/wq9RgmsSU8DCP1AHCVMx6hw4
 Twufeqv8WNL9cnU9ziyNwpr2SD3wb4z7c0NbBbIXxT2phyNsutqOK3+7cLvyuTAca/86
 KpGud/VcfofIxvCUzX0Tdu7pbg2aBdouLy84JmLaURvU+DaEBD8i9X7dBipv+zl6qMG+
 O8IFH5KUZcPdqmvCRtBBrTsFcsxO8r8NdNmv7pgd/hvnVnKgAkJPb4hxcVCYZfj447EC
 A6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GG7CxeOjSsxNMcsShJqeoEt3lOP3ckNPy08TwZRtHAQ=;
 b=pbIbXUbsqHMaEWAdm4uV6XUOaWB80FNhkA0iTySUkUZtIItzYTd57SvKsuDLr9QdAF
 4wHF/+B7Zo7chPuh8FzgHizE0+AWi1fuHFEO37vdVO4OYm63iLrt+nSnKfvVO5lE8fcd
 6Xi2N7bUwFPx31D7ghbf6911SNv3sV6uGOoXdP/BQfmoOjWY6bhqijNyLqUK3h/RBZsR
 nnKkUn9ADsdSZs3embA3dRuIx0wPy5HOB4x9sji5pB+TaibQQfYX4JRTwr72uRXUtBT7
 mXONCMSCjzeIkgGJr5hN7uN2XCAogR5LdocSEvCf3ohgvapWlCpWLVIC42PjZiF0XiCh
 ONzA==
X-Gm-Message-State: AOAM533Kz7P7ZQrPmajAdmY8XIPi3gDOI9cEhfkYOuG+hJYQpngSYiRx
 BIKNz2Ptk5pM5zDQEI3wuhIyqjoX70+1iBGoXsI=
X-Google-Smtp-Source: ABdhPJwUZ/xIKRe/UwxORlzPMUqFjHOUb1xsSXGsvCoKMYaIDkHFrf13JC7IHAikoUrMx4PR2ZWvqvxWpRrjiveY4DA=
X-Received: by 2002:a50:8ad3:: with SMTP id k19mr6935234edk.11.1613701695700; 
 Thu, 18 Feb 2021 18:28:15 -0800 (PST)
MIME-Version: 1.0
References: <20210217225123.2305227-1-alexander.deucher@amd.com>
In-Reply-To: <20210217225123.2305227-1-alexander.deucher@amd.com>
From: Mario Kleiner <mario.kleiner.de@gmail.com>
Date: Fri, 19 Feb 2021 03:28:04 +0100
Message-ID: <CAEsyxyg4oTe4cgUJUHiGt7NQrpv_kqwPzSuRNGsPMHn_HkzvKg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Allow spatial dither to 10 bpc on all DCE
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0100863107=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0100863107==
Content-Type: multipart/alternative; boundary="00000000000058829b05bba73468"

--00000000000058829b05bba73468
Content-Type: text/plain; charset="UTF-8"

Your v2 has my
Reviewed-by: Mario Kleiner <mario.kleiner.de@gmail.com>

thanks,
-mario

On Wed, Feb 17, 2021 at 11:51 PM Alex Deucher <alexdeucher@gmail.com> wrote:

> From: Mario Kleiner <mario.kleiner.de@gmail.com>
>
> Spatial dithering to 10 bpc depth was disabled for all DCE's.
>
> Testing on DCE-8.3 and DCE-11.2 did not show any obvious ill
> effects, but a measureable precision improvement (via colorimeter)
> when displaying a fp16 framebuffer to a 10 bpc DP or HDMI connected
> HDR-10 monitor.
>
> v2: enable it for all DCEs (Alex)
>
> Signed-off-by: Mario Kleiner <mario.kleiner.de@gmail.com>
> Cc: Alex Deucher <alexdeucher@gmail.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dce/dce_opp.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c
> b/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c
> index 4600231da6cb..895b015b02e8 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c
> @@ -216,9 +216,7 @@ static void set_spatial_dither(
>         REG_UPDATE(FMT_BIT_DEPTH_CONTROL,
>                 FMT_TEMPORAL_DITHER_EN, 0);
>
> -       /* no 10bpc on DCE11*/
> -       if (params->flags.SPATIAL_DITHER_ENABLED == 0 ||
> -               params->flags.SPATIAL_DITHER_DEPTH == 2)
> +       if (params->flags.SPATIAL_DITHER_ENABLED == 0)
>                 return;
>
>         /* only use FRAME_COUNTER_MAX if frameRandom == 1*/
> --
> 2.29.2
>
>

--00000000000058829b05bba73468
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Your v2 has my <br></div><div>Reviewed-by: Mario Klei=
ner &lt;<a href=3D"mailto:mario.kleiner.de@gmail.com" target=3D"_blank">mar=
io.kleiner.de@gmail.com</a>&gt;</div><div><br></div><div>thanks,</div><div>=
-mario</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"=
gmail_attr">On Wed, Feb 17, 2021 at 11:51 PM Alex Deucher &lt;<a href=3D"ma=
ilto:alexdeucher@gmail.com">alexdeucher@gmail.com</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">From: Mario Kleiner &lt;<a=
 href=3D"mailto:mario.kleiner.de@gmail.com" target=3D"_blank">mario.kleiner=
.de@gmail.com</a>&gt;<br>
<br>
Spatial dithering to 10 bpc depth was disabled for all DCE&#39;s.<br>
<br>
Testing on DCE-8.3 and DCE-11.2 did not show any obvious ill<br>
effects, but a measureable precision improvement (via colorimeter)<br>
when displaying a fp16 framebuffer to a 10 bpc DP or HDMI connected<br>
HDR-10 monitor.<br>
<br>
v2: enable it for all DCEs (Alex)<br>
<br>
Signed-off-by: Mario Kleiner &lt;<a href=3D"mailto:mario.kleiner.de@gmail.c=
om" target=3D"_blank">mario.kleiner.de@gmail.com</a>&gt;<br>
Cc: Alex Deucher &lt;<a href=3D"mailto:alexdeucher@gmail.com" target=3D"_bl=
ank">alexdeucher@gmail.com</a>&gt;<br>
Signed-off-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com=
" target=3D"_blank">alexander.deucher@amd.com</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/display/dc/dce/dce_opp.c | 4 +---<br>
=C2=A01 file changed, 1 insertion(+), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c b/drivers/gpu/drm=
/amd/display/dc/dce/dce_opp.c<br>
index 4600231da6cb..895b015b02e8 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c<br>
@@ -216,9 +216,7 @@ static void set_spatial_dither(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 REG_UPDATE(FMT_BIT_DEPTH_CONTROL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FMT_TEMPORAL_DITHER=
_EN, 0);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/* no 10bpc on DCE11*/<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (params-&gt;flags.SPATIAL_DITHER_ENABLED =3D=
=3D 0 ||<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0params-&gt;flags.SP=
ATIAL_DITHER_DEPTH =3D=3D 2)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (params-&gt;flags.SPATIAL_DITHER_ENABLED =3D=
=3D 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* only use FRAME_COUNTER_MAX if frameRandom =
=3D=3D 1*/<br>
-- <br>
2.29.2<br>
<br>
</blockquote></div>

--00000000000058829b05bba73468--

--===============0100863107==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0100863107==--
