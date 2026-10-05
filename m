Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EAB6CA6006
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Oct 2026 07:35:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EC7810F223;
	Tue,  6 Oct 2026 07:35:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MhQ6DRN2";
	dkim-atps=neutral
Received: from mail-ej2-f42.google.com (mail-ej2-f42.google.com
 [74.125.228.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7482410E040
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Oct 2026 16:07:03 +0000 (UTC)
Received: by mail-ej2-f42.google.com with SMTP id
 a640c23a62f3a-c2e59b02972so263419966b.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 05 Oct 2026 09:07:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791216422; cv=none;
 d=google.com; s=arc-20260327;
 b=OZKOiUj+EA3saBMVyL+BizlghQRgJCmqS5aLOIpIL8DgAWr+kxynnTOPE66ZmupAqj
 5+HIc9N+1gxAOOmGu8IvxKkGgi+3A7vftPclyE4XIvQQh0T3Wd2K7FCcTQNkruGOzLQ1
 lcYb6aXl25wnF1FAC12899yIM83Z+MeCLyHuDJhtONAn4huZsPrd1TeLpudTzSo5p5G5
 pWSlF0k+8PQnDjUrks6AMiCccfQSCb4rd8TyK6z3skdcGBjXycbzAuZ4j1SsDUWUj3k1
 yTMFwLT/vJEQzzjgCHldBeRu7rT0HEbqb0y7/rNqtSxlt4kZtBgVFE1vgDiJF81JcP11
 JQ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fJFsvBli7jaBCNoclVzjX14IRtwCvcCp0LFrKHjfLFU=;
 fh=IY98SR0cNO93Tj0qH750yd04bAXFkNbDKtBTzSqo1Bw=;
 b=Jqv15cCsYRnpmq0wKEOCh005yUsPIx5O6Kb3bczd1hnDP8on/7KzoyCN1YIyp0liu1
 2Q7TN6qzerYaKQCZvyysBcc4k6eqFTV2HIfV3+YOL/Zi7vrkj4aEHOHkplbgS5u7NiGr
 ahdu6r9eg8SpnGip82JjxLBtjs/MAYLa0rqvYZlcaI7qATfIxa0Dk4BLCp+oWo9PVhMf
 jNWRe+EKWAeZHbZO0KGInFn/sJnR7rqP6agDjuJIWuJHnOgZCcjiIsf88wkqNRT/ySZF
 ToIVNIdERxci8OdQHELhguJ9+XXjfkMADb/fa8MhJ1CD3/iFewzN+Kcly/eDTETM6Q2K
 bOPw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791216422; x=1791821222; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fJFsvBli7jaBCNoclVzjX14IRtwCvcCp0LFrKHjfLFU=;
 b=MhQ6DRN2y9djLf3MmElSJGZrZcHcdXAFcjm0ezyFDYPMYbL7gVznr2hDN0+rGh7i07
 JQYHaBZ2AcOO9mqzjelI8oWIEnwOmMSd/PgXVoCAfsFz1oTXJ5qelvOZNE6bzC8rlold
 /yONAFdXXwDcefkFfuOZ3jFTVXmalq/vHYLLEYg5mWcdLEJK2G3CMy60QMCyXsg7ArnK
 dbP9SdAaMvqYY58ewNYKPcF3XNQiBmA199eVh/o7mVGC/axhmVe5QWHAe/Dci4o205ur
 cLTViEE9cIOtjPulNirGVEF8IxqH7jhitXX2c5Inr7O23YEQxUvN+rMZWgMSYTloxVOF
 7Ygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791216422; x=1791821222;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fJFsvBli7jaBCNoclVzjX14IRtwCvcCp0LFrKHjfLFU=;
 b=n9i7NtsaSz6AzwfsKuPoWF742t9Vaidemzf+X+ZIQSoqs4fhiQsSqXwmJQ1b9FeflG
 D2QCfx/MgxHxLjiqtUhU8yYayifFJpq6dgARdHdrA379In2kfFaZfsJidNV7XXMu+h8c
 BwKiHyzysDdClSSMqIkXUyYJsKVzyCKJpUZ3epW0bWh2t/VKR0ZNc4I4JXS96c/OKpDl
 ZC/BDMxktwOkihblWdVEDvmYx2egxE3ceXKdhgn3qiKLuGBeKQlW/g2uEQoosMcN7lIu
 uqvy/eNG1WdtBwGKo/ZKivOGt6kPx815R10TILGe58JDvu6lgik0gqR0v03zzCq47V9/
 KhUA==
X-Gm-Message-State: AFq9FYKUSIu+S1Cy2AVGDQKyQ77tPsrLY/PPVIfVCopB9nn7SFVPmiSj
 /MJKqlHwWbmxwI4pNGSwSslB/PFF3pug+Cefk+22+CBzXCpt3g9JnVnmGyID+Q2ZqnhT1SIURyz
 ds50ZFG4ZJGS3bGRycP5zvMU751HkCabROQJQ
X-Gm-Gg: AYBFou0yeMCSa4BTod+J1axF3WXHyZNFBPWC9r5YR7d7POvA5XtlZ9TN8AiouGYxPXm
 1+CVFwJBgRLecOAa55PffxuPUqqYQHbvkFU0a/MzLDo6unxz1NFs4csQfDn5n3i7Q/P4PiNDr7G
 ibLuZ1DKcdJiWgP+GE4zCzt5XWUHPPhZQMfWVANMBi6//jlVLJ4jenRVMsnqSSIo7zYtnTSgE+f
 sC12Ne8lmb+fLRDieTqO+kWgICfKAvgmsBT0WHioojZLysDNpgfxxFo9deLQXlIsmKcFIOFww/o
 4kgP+YMEdf77Vhe1GAQP2QZoSU60Y9EYrW2DyaDJ8SbvGq/66ktJSg==
X-Received: by 2002:a17:907:daa:b0:c26:1649:47b2 with SMTP id
 a640c23a62f3a-c2e4af9af5bmr1029403566b.40.1791216421537; Mon, 05 Oct 2026
 09:07:01 -0700 (PDT)
MIME-Version: 1.0
References: <20261005132822.2486852-1-alexander.deucher@amd.com>
In-Reply-To: <20261005132822.2486852-1-alexander.deucher@amd.com>
From: =?UTF-8?B?QXloYW4gw4dpY2Vr?= <ayhancicek@gmail.com>
Date: Mon, 5 Oct 2026 19:06:49 +0300
X-Gm-Features: AclHuK9NfXN0pRqVxATvkWR9h_CrcKkcneuhPEWCOV7Mz0cO26HypHaQy1s8ysA
Message-ID: <CAL556cc1fboqHNGOq7rnV6-giXaoz0CRb2J8oZr9fBFCVP_f7Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: make Mac FB workaround generic
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="000000000000858d6c065d1a12c6"
X-Mailman-Approved-At: Tue, 06 Oct 2026 07:35:16 +0000
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

--000000000000858d6c065d1a12c6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, Alex.
That makes sense. I agree that checking for the Apple subsystem
vendor together with VRAM at
address 0 is a cleaner and more general solution than adding per-ASIC cases=
.

Thanks as well for incorporating my test result into the patch. The
generic version has remained stable on my MacBookPro11,5 with the
Radeon R9 M370X (VERDE), with the hardware cursor enabled.


Best regards,
Ayhan

5 Eki 2026 Pzt 16:28 tarihinde Alex Deucher <alexander.deucher@amd.com>
=C5=9Funu yazd=C4=B1:

> Rather than adding a case of every chip where this is seen
> just check if the FB is at 0 and the ssid is apple.  This
> should cover all chips which fall into this case.
>
> Tested-by: Ayhan =C3=87i=C3=A7ek <ayhancicek@gmail.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index d25ca903e21b8..5d4276cd0f7d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -1190,20 +1190,17 @@ void amdgpu_gmc_init_vga_resv_regions(struct
> amdgpu_device *adev)
>         case CHIP_RENOIR:
>                 adev->mman.keep_stolen_vga_memory =3D true;
>                 break;
> -       case CHIP_POLARIS10:
> -       case CHIP_POLARIS11:
> -       case CHIP_POLARIS12:
> -               /* MacBookPros with switchable graphics put VRAM at 0 whe=
n
> -                * the iGPU is enabled which results in cursor issues if
> -                * the cursor ends up at 0.  Reserve vram at 0 in that
> case.
> -                */
> -               if (adev->gmc.vram_start =3D=3D 0)
> -                       adev->mman.keep_stolen_vga_memory =3D true;
> -               break;
>         default:
>                 adev->mman.keep_stolen_vga_memory =3D false;
>                 break;
>         }
> +       /* MacBookPros with switchable graphics put VRAM at 0 when
> +        * the iGPU is enabled which results in cursor issues if
> +        * the cursor ends up at 0.  Reserve vram at 0 in that case.
> +        */
> +       if ((adev->pdev->subsystem_vendor =3D=3D PCI_VENDOR_ID_APPLE) &&
> +           (adev->gmc.vram_start =3D=3D 0))
> +               adev->mman.keep_stolen_vga_memory =3D true;
>
>         if (amdgpu_sriov_vf(adev) ||
>             !amdgpu_device_has_display_hardware(adev)) {
> --
> 2.55.0
>
>

--000000000000858d6c065d1a12c6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Thanks,=C2=A0Alex.</div><div dir=3D"auto">That=C2=A0=
makes=C2=A0sense.=C2=A0I=C2=A0agree=C2=A0that checking=C2=A0for=C2=A0the=C2=
=A0Apple=C2=A0subsystem</div><div dir=3D"auto">vendor=C2=A0together=C2=A0wi=
th=C2=A0VRAM=C2=A0at</div><div dir=3D"auto">address=C2=A00 is=C2=A0a=C2=A0c=
leaner=C2=A0and=C2=A0more=C2=A0general=C2=A0solution=C2=A0than=C2=A0adding=
=C2=A0per-ASIC=C2=A0cases.</div><div dir=3D"auto"><br></div><div dir=3D"aut=
o">Thanks=C2=A0as=C2=A0well=C2=A0for=C2=A0incorporating=C2=A0my=C2=A0test=
=C2=A0result=C2=A0into=C2=A0the=C2=A0patch.=C2=A0The generic=C2=A0version=
=C2=A0has=C2=A0remained=C2=A0stable=C2=A0on=C2=A0my=C2=A0MacBookPro11,5=C2=
=A0with=C2=A0the=C2=A0Radeon=C2=A0R9=C2=A0M370X=C2=A0(VERDE),=C2=A0with=C2=
=A0the=C2=A0hardware=C2=A0cursor=C2=A0enabled.</div><div dir=3D"auto"><br><=
/div><div dir=3D"auto"><br></div><div dir=3D"auto">Best=C2=A0regards,</div>=
<div dir=3D"auto">Ayhan</div></div><br><div class=3D"gmail_quote gmail_quot=
e_container"><div dir=3D"ltr" class=3D"gmail_attr">5 Eki 2026 Pzt 16:28 tar=
ihinde Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com">alexan=
der.deucher@amd.com</a>&gt; =C5=9Funu yazd=C4=B1:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">Rather than adding a case of every chip where this is seen<b=
r>
just check if the FB is at 0 and the ssid is apple.=C2=A0 This<br>
should cover all chips which fall into this case.<br>
<br>
Tested-by: Ayhan =C3=87i=C3=A7ek &lt;<a href=3D"mailto:ayhancicek@gmail.com=
" target=3D"_blank" rel=3D"noreferrer">ayhancicek@gmail.com</a>&gt;<br>
Signed-off-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com=
" target=3D"_blank" rel=3D"noreferrer">alexander.deucher@amd.com</a>&gt;<br=
>
---<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 17 +++++++----------<br>
=C2=A01 file changed, 7 insertions(+), 10 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.c<br>
index d25ca903e21b8..5d4276cd0f7d3 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
@@ -1190,20 +1190,17 @@ void amdgpu_gmc_init_vga_resv_regions(struct amdgpu=
_device *adev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case CHIP_RENOIR:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 adev-&gt;mman.keep_=
stolen_vga_memory =3D true;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0case CHIP_POLARIS10:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0case CHIP_POLARIS11:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0case CHIP_POLARIS12:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* MacBookPros with=
 switchable graphics put VRAM at 0 when<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * the iGPU is enab=
led which results in cursor issues if<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * the cursor ends =
up at 0.=C2=A0 Reserve vram at 0 in that case.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (adev-&gt;gmc.vr=
am_start =3D=3D 0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0adev-&gt;mman.keep_stolen_vga_memory =3D true;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 adev-&gt;mman.keep_=
stolen_vga_memory =3D false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* MacBookPros with switchable graphics put VRA=
M at 0 when<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * the iGPU is enabled which results in cursor =
issues if<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * the cursor ends up at 0.=C2=A0 Reserve vram =
at 0 in that case.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((adev-&gt;pdev-&gt;subsystem_vendor =3D=3D =
PCI_VENDOR_ID_APPLE) &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(adev-&gt;gmc.vram_start =3D=3D 0=
))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;mman.keep_=
stolen_vga_memory =3D true;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (amdgpu_sriov_vf(adev) ||<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !amdgpu_device_has_display_hardwa=
re(adev)) {<br>
-- <br>
2.55.0<br>
<br>
</blockquote></div>

--000000000000858d6c065d1a12c6--
