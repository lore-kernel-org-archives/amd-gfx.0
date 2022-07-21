Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD933C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jul 2022 22:06:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B2001129FB;
	Thu, 21 Jul 2022 22:06:18 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10FA7112B95
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Jul 2022 22:06:17 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id z22so3832043edd.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Jul 2022 15:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6Ux4KOygwYu8Sap7AgbbffMl70G/uKSyMvuDco5McwE=;
 b=N66sDDJjyjcdgM/y1vyYmOalvMpSxzPN30/T5f2QsAw3M30JdKiPqrlPUaasJjLImn
 st1nZOntC4Cv+MarZEY5YUSHtixuln1WnYXRwr2J4r1qvhRa8IlaV50+/hvwsrlYk5sF
 rnGonoAt1vPLXw5HGzjC7oQMrCBRG2EW879s/kwABe/cA45jw+vvdOGExqwojmEEbcQG
 DNScuGFYl2q/mAVsBmMpGguP6Oo5lk+VOONaMZs+mSA9f47dhytmV2JmS1ADpPB7xRXr
 A4+JDXxW3+A6kaaJzniN4yD339fKcnysBUqFKlVrZ2UFH0Qll4pZc93F9zXd49FsRrri
 djOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6Ux4KOygwYu8Sap7AgbbffMl70G/uKSyMvuDco5McwE=;
 b=r51OY71Pwhb3tttwoUKI43A8Tbx5mBwdlAsn9CXTlJljK6ptiJDxzx9PnuCnzdxxsz
 C+HcVANko0g31YMDw7FSL3EMcqFK312Eaq6qjZpElw2AesSxYY+HcDocqX5fP7Yvduxo
 9YhEexlbq8MkHyf9aRvRXPTYFI8kbHkwOl6IbZOVYiHJDeePSpDH7hBZf2eQNQhGg5XD
 W7eDT64ufoz5y8TRw3DrCrt65HB63NU2h9vmuTt5I1O8q4OJhG9BfYfFayYBGmnKV30G
 rSxisdbakyYTqyUZb3H+Mt9nacx5zQ8ACve9hhSfwktxslmI7O2jgoJJE8VZxXN0+yY/
 jnzA==
X-Gm-Message-State: AJIora+dz3nayhs/H7P5eFpMU+KSY4TC5a3zqYGRCtkrSEePuLwijICW
 pm7kF3Novj19V2ZC2HpwgtpJ91BfqvH+KlE0GLB4/HDV
X-Google-Smtp-Source: AGRyM1uy2mqrF+NsyMkxYDM/rCbhvLGb2VIK1jYxNVSlh2LaLP3N6EOIcmzrFTCkFhs7IV/oykK2Zy1m3lrgD6uiZaM=
X-Received: by 2002:a05:6402:1e94:b0:43a:9e92:bf2 with SMTP id
 f20-20020a0564021e9400b0043a9e920bf2mr503252edf.248.1658441175456; Thu, 21
 Jul 2022 15:06:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220721220423.32618-1-Roman.Li@amd.com>
 <20220721220423.32618-2-Roman.Li@amd.com>
In-Reply-To: <20220721220423.32618-2-Roman.Li@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 21 Jul 2022 18:06:03 -0400
Message-ID: <CADnq5_O4OGKu5AikYDfQg4ttuMnEE5VN=BFg9_RR_5_EtypiLQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/display: Specify supported modifiers for
 dcn314
To: Roman.Li@amd.com
Content-Type: multipart/alternative; boundary="00000000000024dfc305e457ed0f"
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
Cc: Alexander.Deucher@amd.com, nicholas.kazlauskas@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--00000000000024dfc305e457ed0f
Content-Type: text/plain; charset="UTF-8"

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Thu, Jul 21, 2022 at 6:04 PM <Roman.Li@amd.com> wrote:

> From: Roman Li <roman.li@amd.com>
>
> Use same modifiers as for AMDGPU_FAMILY_GC_11_0_0
>
> Signed-off-by: Roman Li <roman.li@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index e27621e11947..2b3de9d0d3f3 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -1404,6 +1404,7 @@ static bool dm_plane_format_mod_supported(struct
> drm_plane *plane,
>                 }
>                 break;
>         case AMDGPU_FAMILY_GC_11_0_0:
> +       case AMDGPU_FAMILY_GC_11_0_2:
>                 switch (AMD_FMT_MOD_GET(TILE, modifier)) {
>                 case AMD_FMT_MOD_TILE_GFX11_256K_R_X:
>                 case AMD_FMT_MOD_TILE_GFX9_64K_R_X:
> --
> 2.17.1
>
>

--00000000000024dfc305e457ed0f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Series is:</div><div>Reviewed-by: Alex Deucher &lt;<a=
 href=3D"mailto:alexander.deucher@amd.com">alexander.deucher@amd.com</a>&gt=
;<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"g=
mail_attr">On Thu, Jul 21, 2022 at 6:04 PM &lt;<a href=3D"mailto:Roman.Li@a=
md.com">Roman.Li@amd.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">From: Roman Li &lt;<a href=3D"mailto:roman.li@amd.c=
om" target=3D"_blank">roman.li@amd.com</a>&gt;<br>
<br>
Use same modifiers as for AMDGPU_FAMILY_GC_11_0_0<br>
<br>
Signed-off-by: Roman Li &lt;<a href=3D"mailto:roman.li@amd.com" target=3D"_=
blank">roman.li@amd.com</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/driv=
ers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c<br>
index e27621e11947..2b3de9d0d3f3 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c<br>
@@ -1404,6 +1404,7 @@ static bool dm_plane_format_mod_supported(struct drm_=
plane *plane,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case AMDGPU_FAMILY_GC_11_0_0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case AMDGPU_FAMILY_GC_11_0_2:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (AMD_FMT_MOD=
_GET(TILE, modifier)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case AMD_FMT_MOD_TI=
LE_GFX11_256K_R_X:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case AMD_FMT_MOD_TI=
LE_GFX9_64K_R_X:<br>
-- <br>
2.17.1<br>
<br>
</blockquote></div>

--00000000000024dfc305e457ed0f--
