Return-Path: <SRS0=LN+i=D3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B28C4363D
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2020 23:48:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E37D12222D
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2020 23:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTZ0nVx4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E37D12222D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 415D26E2B6;
	Tue, 20 Oct 2020 23:48:21 +0000 (UTC)
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90D076E2B6
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2020 23:48:19 +0000 (UTC)
Received: by mail-pl1-x643.google.com with SMTP id bf6so246531plb.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2020 16:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JZf0ws/pKxIdTJzG8KwBzAlk+5prDQZDKRsBr7ormmw=;
 b=LTZ0nVx4NzPnNjFpyTUk+ELR6UPbA9yyPgRWD5oGhtwZ9Xl1Pkep86HLEVo+JlRUWS
 8HqjvhqKk8S/ZntticrZd7xfrA/vJPkUfUjZy9eIVIouODZWZaB7Kp8+WT3VcUM3Suz8
 m+UC29g6AGB5k/k0MjgtCk3bWYp3Tt6YTVqRYm9EdSRLv63q4ovXmcnV7Q3NRXU1KbWu
 H3H8F1Yyo4b5bBGrRLtHF4k1jrZUrUIBtK3VAffNFtOy8gSRItdp/xHMHKyh4lwy/HHY
 GKfh9b+vGBYclw+1DguPedlOYM+R4xj+1+7V25973EYiIzsR+9qqxm5xza+WkJFYJhNI
 za1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JZf0ws/pKxIdTJzG8KwBzAlk+5prDQZDKRsBr7ormmw=;
 b=XUX+9rgtNjGPkD/VEo3b0afFJHk3ZoC/Jeg95FkpkO7Yjym82qsRyMadtwdJCEB0jo
 GjzBd3ZLdqOQxzxsoYC+ZZzLJwKtjIg0H7oO/S76waokP0ZQgv8/VAvWgsuTponIwBDc
 fD9Xc5Ek9I8NP2Qtyu34xgDUWK/gZ+Ofv2BdAoCBS/6VyeXRHaILrJ1NEvEy5QmZ4dRx
 GhRsjtCXNei1StcnUZGAuRhzIIgn2ksfFwh5m2JnwSDDSTZ4WikWAGZ43g+DdAq6hOtn
 bUYQEsxiGTIahAYQkacHV23cMti9BsYvqLfeR31bHEx3oQgG21UZyVOIl2qwJNv6smrx
 YRhw==
X-Gm-Message-State: AOAM530TiFPe86P43FVSpVEfEkGecnIqHZkgm1tsoClXeokosxRANCm6
 eRnp3mCde6SwQvejnuna1IYa6RfJkmmSbyR/fa4=
X-Google-Smtp-Source: ABdhPJzLWedPdXyojRIHxw1LX+ren+acPl2qtvXv56oreASH5vOEOSwQ3g3q+WrDcMqzbrGf6ZIZAul6XQFI9gYw35g=
X-Received: by 2002:a17:902:c1d2:b029:d3:ea72:cdec with SMTP id
 c18-20020a170902c1d2b02900d3ea72cdecmr550490plc.47.1603237699198; Tue, 20 Oct
 2020 16:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <20201020223113.310402-1-bas@basnieuwenhuizen.nl>
In-Reply-To: <20201020223113.310402-1-bas@basnieuwenhuizen.nl>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Tue, 20 Oct 2020 19:47:42 -0400
Message-ID: <CAAxE2A5HdVj41F7BhnXzZzEpGLDowPat0tWxVrAA0trvZ6p8JQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Initialize num_pkrs on VANGOGH.
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, Roman.Li@amd.com,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1277550041=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1277550041==
Content-Type: multipart/alternative; boundary="0000000000008d23cb05b222dd75"

--0000000000008d23cb05b222dd75
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

FYI, this fixes tiling on VanGogh.

Reviewed-by: Marek Ol=C5=A1=C3=A1k <marek.olsak@amd.com>

Marek

On Tue, Oct 20, 2020 at 6:31 PM Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
wrote:

> As far a I can tell uses a variant of DCN3xx which uses num_pkrs.
>
> If we do not initialize the variable we will set the register field
> to ilog2(0) =3D -1, though the mask will reduce that to 7. Pretty sure
> 7 is not the value we want here.
>
> Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> ---
>
> Found while rebasing my modifiers series. Not tested on HW.
>
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 6855aad7f312..2713caac4f2a 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4074,7 +4074,8 @@ fill_plane_buffer_attributes(struct amdgpu_device
> *adev,
>  #ifdef CONFIG_DRM_AMD_DC_DCN3_0
>                 if (adev->asic_type =3D=3D CHIP_SIENNA_CICHLID ||
>                     adev->asic_type =3D=3D CHIP_NAVY_FLOUNDER ||
> -                   adev->asic_type =3D=3D CHIP_DIMGREY_CAVEFISH)
> +                   adev->asic_type =3D=3D CHIP_DIMGREY_CAVEFISH ||
> +                   adev->asic_type =3D=3D CHIP_VANGOGH)
>                         tiling_info->gfx9.num_pkrs =3D
> adev->gfx.config.gb_addr_config_fields.num_pkrs;
>  #endif
>                 ret =3D fill_plane_dcc_attributes(adev, afb, format,
> rotation,
> --
> 2.28.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--0000000000008d23cb05b222dd75
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>FYI, this fixes tiling on VanGogh.</div><div><br></di=
v><div>Reviewed-by: Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:marek.olsak=
@amd.com">marek.olsak@amd.com</a>&gt;<br></div><div><br></div><div>Marek<br=
></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Tue, Oct 20, 2020 at 6:31 PM Bas Nieuwenhuizen &lt;<a href=3D"mai=
lto:bas@basnieuwenhuizen.nl">bas@basnieuwenhuizen.nl</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">As far a I can tell use=
s a variant of DCN3xx which uses num_pkrs.<br>
<br>
If we do not initialize the variable we will set the register field<br>
to ilog2(0) =3D -1, though the mask will reduce that to 7. Pretty sure<br>
7 is not the value we want here.<br>
<br>
Signed-off-by: Bas Nieuwenhuizen &lt;<a href=3D"mailto:bas@basnieuwenhuizen=
.nl" target=3D"_blank">bas@basnieuwenhuizen.nl</a>&gt;<br>
---<br>
<br>
Found while rebasing my modifiers series. Not tested on HW.<br>
<br>
=C2=A0drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-<br>
=C2=A01 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
index 6855aad7f312..2713caac4f2a 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
@@ -4074,7 +4074,8 @@ fill_plane_buffer_attributes(struct amdgpu_device *ad=
ev,<br>
=C2=A0#ifdef CONFIG_DRM_AMD_DC_DCN3_0<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (adev-&gt;asic_t=
ype =3D=3D CHIP_SIENNA_CICHLID ||<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 adev-=
&gt;asic_type =3D=3D CHIP_NAVY_FLOUNDER ||<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-=
&gt;asic_type =3D=3D CHIP_DIMGREY_CAVEFISH)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-=
&gt;asic_type =3D=3D CHIP_DIMGREY_CAVEFISH ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-=
&gt;asic_type =3D=3D CHIP_VANGOGH)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 tiling_info-&gt;gfx9.num_pkrs =3D adev-&gt;gfx.config.gb_addr_co=
nfig_fields.num_pkrs;<br>
=C2=A0#endif<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D fill_plane_=
dcc_attributes(adev, afb, format, rotation,<br>
-- <br>
2.28.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx</a><br>
</blockquote></div>

--0000000000008d23cb05b222dd75--

--===============1277550041==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1277550041==--
