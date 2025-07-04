Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBEF1C83F03
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jul 2025 18:31:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A01210E0AB;
	Fri,  4 Jul 2025 18:31:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="akSKb2rL";
	dkim-atps=neutral
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com
 [209.85.161.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73A8B10E0AB
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jul 2025 18:31:42 +0000 (UTC)
Received: by mail-oo1-f45.google.com with SMTP id
 006d021491bc7-60d54b1adacso111908eaf.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Jul 2025 11:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751653901; x=1752258701; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YSdwSS3DN+3G6VB4VCbubdii7BMnj8hhgpMm24A0s0I=;
 b=akSKb2rLD5JaK9qfP4BEZ3NVihcYP6Bd9ZxxxuBq8GYJJetCAhQwFWM4fzHQRFM47T
 Qvow4WkTX1sNejAhzA2Fg/zGTHlz0FTLMRlQO3YAPDvXChe1LzaSVL9YbeXBbxmaSuzx
 WVpOOD9T9y0KT8t0c/rwyDjJOi4zRLw/XHjohvhZCo3ubHmNAXLE+rTjV1sAvzK+fM2j
 6/VGuwQoOeH7Q9P0XUFM7OmPXuXkqSWCxRvcGIxO7w/fmMMOyOI3rY8jOOfVM6/SpS7X
 CY39g32aE9YwWjNcosJn0fB/YZJSsJ8K306GoWtazWK36nAAigHbsZYN/k0vac9TTuDo
 3EKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751653901; x=1752258701;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YSdwSS3DN+3G6VB4VCbubdii7BMnj8hhgpMm24A0s0I=;
 b=RoNCPn+IP9sgu/U/PB40hi1ED4ebTAsH2IOuFVo0JtlY4ge57df2XRLcAcVDOflZlS
 S4n4z7d7du8QW7l//QVwFzTK04drNwJHwOsUoQavO4GXFa1LcbdM0dosyTDSzZybh6Xm
 j4YfXkynKjf54HsYoAlv/DMwNWBwxN/+KEZMKTleOxrxKEoQBJSDFLCiTWrUO3v7cONk
 o60eZeFxK+IqJBjU/PCCPpvNUL5cr0EeHQhf0GKKG3NiI+G9KGLiBp6hKWLgRuk7s8GI
 vJzcDOn3lMptmUsKQ1eRnSdoaNNT5O36yp8w891Mi2dRsSgtYDa5PSyMMsWkc6srDB5v
 FWDA==
X-Gm-Message-State: AOJu0YxTkEPxkm9JScWGWUqsH40WIgaxzC3lDo/2a/pzxxUcMdCP465L
 XXd4eEWABcHe/JC68bhvC4IMcYBA/nLyYvrpG7RHPZNQFrs9dFyXIkCmFk3Q2fEm+UilhiuRNd2
 CzosYeawLpdX6DM59wMiDWwJb6jc5VeY=
X-Gm-Gg: ASbGnctd/9JgOET4aHhswHIOXE3lzI+zBeNDzYtAD5ULwbo8kd1ou8wLOx8FxioymMN
 rsIiOyA4ePdbMYH3YUOW+jyMoesz9qAuNDmKbjjgIm8P47GZMU8Rwr1m+gd/LUZEKOCAxWcrtVK
 FkVj17eydAwOJBoN63cWG1eBjMKBd9QvB6boT6JDtYy+A0
X-Google-Smtp-Source: AGHT+IEcCXCg3vAb+OUrIoY4thV65wt1RaTkUC3FzKghbd5rMDetMPZaoUYUtKdBErb9injxEJP3CX1kRAmGNpPmhxE=
X-Received: by 2002:a05:6820:210:b0:611:c6e0:e0e6 with SMTP id
 006d021491bc7-6139192b488mr828290eaf.0.1751653901217; Fri, 04 Jul 2025
 11:31:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250704072657.553572-1-jesse.zhang@amd.com>
In-Reply-To: <20250704072657.553572-1-jesse.zhang@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Fri, 4 Jul 2025 14:31:04 -0400
X-Gm-Features: Ac12FXwYqAEd3TmfgcVl-8wSix4KV1Ro7uZ-gI49SxTvOw3L5SWhGdv_LG-rKfU
Message-ID: <CAAxE2A6vxAFBtrvte+K4a66eXuU=hq6hyWqu41VRBtSJLBV9TQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Replace HQD terminology with slots naming
To: Jesse Zhang <jesse.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>, Marek.Olsak@amd.com
Content-Type: multipart/alternative; boundary="0000000000008d343806391eb42d"
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

--0000000000008d343806391eb42d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Marek Ol=C5=A1=C3=A1k <marek.olsak@amd.com>

Marek

On Fri, Jul 4, 2025 at 3:43=E2=80=AFAM Jesse Zhang <jesse.zhang@amd.com> wr=
ote:

> The term "HQD" is CP-specific and doesn't
> accurately describe the queue resources for other IP blocks like SDMA,
> VCN, or VPE. This change:
>
> 1. Renames `num_hqds` to `num_slots` in amdgpu_kms.c to better reflect
>    the generic nature of the resource counting
> 2. Updates the UAPI struct member from `userq_num_hqds` to
> `userq_num_slots`
> 3. Maintains the same functionality while using more appropriate
> terminology
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 10 +++++-----
>  include/uapi/drm/amdgpu_drm.h           |  4 ++--
>  2 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 4aab5e394ce2..e2aa2264fa0b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -399,7 +399,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device
> *adev,
>         uint32_t ib_size_alignment =3D 0;
>         enum amd_ip_block_type type;
>         unsigned int num_rings =3D 0;
> -       uint32_t num_hqds =3D 0;
> +       uint32_t num_slots =3D 0;
>         unsigned int i, j;
>
>         if (info->query_hw_ip.ip_instance >=3D
> AMDGPU_HW_IP_INSTANCE_MAX_COUNT)
> @@ -415,7 +415,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device
> *adev,
>
>                 if (!adev->gfx.disable_uq) {
>                         for (i =3D 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++)
> -                               num_hqds +=3D
> hweight32(adev->mes.gfx_hqd_mask[i]);
> +                               num_slots +=3D
> hweight32(adev->mes.gfx_hqd_mask[i]);
>                 }
>
>                 ib_start_alignment =3D 32;
> @@ -430,7 +430,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device
> *adev,
>
>                 if (!adev->sdma.disable_uq) {
>                         for (i =3D 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i=
++)
> -                               num_hqds +=3D
> hweight32(adev->mes.compute_hqd_mask[i]);
> +                               num_slots +=3D
> hweight32(adev->mes.compute_hqd_mask[i]);
>                 }
>
>                 ib_start_alignment =3D 32;
> @@ -445,7 +445,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device
> *adev,
>
>                 if (!adev->gfx.disable_uq) {
>                         for (i =3D 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++)
> -                               num_hqds +=3D
> hweight32(adev->mes.sdma_hqd_mask[i]);
> +                               num_slots +=3D
> hweight32(adev->mes.sdma_hqd_mask[i]);
>                 }
>
>                 ib_start_alignment =3D 256;
> @@ -589,7 +589,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device
> *adev,
>         }
>         result->capabilities_flags =3D 0;
>         result->available_rings =3D (1 << num_rings) - 1;
> -       result->userq_num_hqds =3D num_hqds;
> +       result->userq_num_slots =3D num_slots;
>         result->ib_start_alignment =3D ib_start_alignment;
>         result->ib_size_alignment =3D ib_size_alignment;
>         return 0;
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index 66c4a03ac9f9..bdedbaccf776 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -1493,8 +1493,8 @@ struct drm_amdgpu_info_hw_ip {
>         __u32  available_rings;
>         /** version info: bits 23:16 major, 15:8 minor, 7:0 revision */
>         __u32  ip_discovery_version;
> -       /* Userq available hqds */
> -       __u32  userq_num_hqds;
> +       /* Userq available slots */
> +       __u32  userq_num_slots;
>  };
>
>  /* GFX metadata BO sizes and alignment info (in bytes) */
> --
> 2.34.1
>
>

--0000000000008d343806391eb42d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Reviewed-by: Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mai=
lto:marek.olsak@amd.com">marek.olsak@amd.com</a>&gt;</div><div><br></div><d=
iv>Marek</div></div><br><div class=3D"gmail_quote gmail_quote_container"><d=
iv dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 4, 2025 at 3:43=E2=80=AFAM =
Jesse Zhang &lt;<a href=3D"mailto:jesse.zhang@amd.com">jesse.zhang@amd.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">T=
he term &quot;HQD&quot; is CP-specific and doesn&#39;t<br>
accurately describe the queue resources for other IP blocks like SDMA,<br>
VCN, or VPE. This change:<br>
<br>
1. Renames `num_hqds` to `num_slots` in amdgpu_kms.c to better reflect<br>
=C2=A0 =C2=A0the generic nature of the resource counting<br>
2. Updates the UAPI struct member from `userq_num_hqds` to `userq_num_slots=
`<br>
3. Maintains the same functionality while using more appropriate terminolog=
y<br>
<br>
Signed-off-by: Jesse Zhang &lt;<a href=3D"mailto:Jesse.Zhang@amd.com" targe=
t=3D"_blank">Jesse.Zhang@amd.com</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 10 +++++-----<br>
=C2=A0include/uapi/drm/amdgpu_drm.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 4 ++--<br>
=C2=A02 files changed, 7 insertions(+), 7 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_kms.c<br>
index 4aab5e394ce2..e2aa2264fa0b 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
@@ -399,7 +399,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t ib_size_alignment =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 enum amd_ip_block_type type;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int num_rings =3D 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t num_hqds =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t num_slots =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int i, j;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (info-&gt;query_hw_ip.ip_instance &gt;=3D AM=
DGPU_HW_IP_INSTANCE_MAX_COUNT)<br>
@@ -415,7 +415,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev=
,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!adev-&gt;gfx.d=
isable_uq) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 for (i =3D 0; i &lt; AMDGPU_MES_MAX_GFX_PIPES; i++)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0num_hqds +=3D hweight32(adev-&gt;mes.=
gfx_hqd_mask[i]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0num_slots +=3D hweight32(adev-&gt;mes=
.gfx_hqd_mask[i]);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ib_start_alignment =
=3D 32;<br>
@@ -430,7 +430,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev=
,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!adev-&gt;sdma.=
disable_uq) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 for (i =3D 0; i &lt; AMDGPU_MES_MAX_COMPUTE_PIPES; i++)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0num_hqds +=3D hweight32(adev-&gt;mes.=
compute_hqd_mask[i]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0num_slots +=3D hweight32(adev-&gt;mes=
.compute_hqd_mask[i]);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ib_start_alignment =
=3D 32;<br>
@@ -445,7 +445,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev=
,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!adev-&gt;gfx.d=
isable_uq) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 for (i =3D 0; i &lt; AMDGPU_MES_MAX_SDMA_PIPES; i++)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0num_hqds +=3D hweight32(adev-&gt;mes.=
sdma_hqd_mask[i]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0num_slots +=3D hweight32(adev-&gt;mes=
.sdma_hqd_mask[i]);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ib_start_alignment =
=3D 256;<br>
@@ -589,7 +589,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 result-&gt;capabilities_flags =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 result-&gt;available_rings =3D (1 &lt;&lt; num_=
rings) - 1;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0result-&gt;userq_num_hqds =3D num_hqds;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0result-&gt;userq_num_slots =3D num_slots;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 result-&gt;ib_start_alignment =3D ib_start_alig=
nment;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 result-&gt;ib_size_alignment =3D ib_size_alignm=
ent;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h<=
br>
index 66c4a03ac9f9..bdedbaccf776 100644<br>
--- a/include/uapi/drm/amdgpu_drm.h<br>
+++ b/include/uapi/drm/amdgpu_drm.h<br>
@@ -1493,8 +1493,8 @@ struct drm_amdgpu_info_hw_ip {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 __u32=C2=A0 available_rings;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /** version info: bits 23:16 major, 15:8 minor,=
 7:0 revision */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 __u32=C2=A0 ip_discovery_version;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Userq available hqds */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32=C2=A0 userq_num_hqds;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Userq available slots */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32=C2=A0 userq_num_slots;<br>
=C2=A0};<br>
<br>
=C2=A0/* GFX metadata BO sizes and alignment info (in bytes) */<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div>

--0000000000008d343806391eb42d--
