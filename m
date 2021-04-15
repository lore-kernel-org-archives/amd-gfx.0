Return-Path: <SRS0=drzA=JM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD6FC433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Apr 2021 18:07:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5564F6137D
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Apr 2021 18:07:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5564F6137D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=basnieuwenhuizen.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09CA86EAA8;
	Thu, 15 Apr 2021 18:07:20 +0000 (UTC)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5103A6EAA8
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Apr 2021 18:07:19 +0000 (UTC)
Received: by mail-il1-x12b.google.com with SMTP id i22so16223047ila.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Apr 2021 11:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gWLGERMP/RCSBtLwMLrcaWnDWn9dCbXznxreD1Ak2sc=;
 b=VXo782WJCvK4NzNYVyNmWfm+UlpmLdLHi9gl2UEa4vD3YsAlf/pn5J9ojfo/292lM8
 YpJ5urAt6mrLT+8qTTmzZpwVv5dNzsvV86kmH6DhssS5lCD4KKoPwiaor9JhAAEK7cNd
 02oMLo0ZZQn1l7K2/E014iRFaFl+WC+LVZB8fZXwo/1sLLn2LljM14HmBRXjXFT+vKSm
 RsqV9CIDUKCZiowD3O3aJUDhVBYAQasVHMNo7ha4Hqa1DlLgi7vY5tnFyV+M6GUq/7CA
 3qWj6Z9DslYzaVyAkkJN+8JWWfOdFVZb7Ru0wvFXQu+9lxQOeRUz1+hwyq5kCWOojx5T
 AbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gWLGERMP/RCSBtLwMLrcaWnDWn9dCbXznxreD1Ak2sc=;
 b=M26DaZB2ZxSZnDXw4kmKWEzcj5cFy3SwEKqmKund3UmHeX583CkKNq5IqCDNTwNmPl
 M41KM4E5ztXNVnrDqW3TO0ivRRBxnbzcnCNaLPgFQxaFs5+YSqoiT+J2gzACFMrSCDnN
 H5BzAi8fLHu9NFZ+M3t72JtGAg7w+JmQod6dWcUlKwDQTjKgw8TT2z5xjl9sckXaBxC2
 uDD1MyA0flfjAySRZgYOx68SBsW3n8uQK5bfvk+UIKakvfI0E60JcYwNthC6Q5TzIFiF
 Byd8TIw1D4C39JAgZtrPIfrGln/yFI/eYExYJ7UtuOYMi0Tg6SoE30l80Tfb3HC02tsC
 w6fg==
X-Gm-Message-State: AOAM533Ntouq8DCfG2AFj9FtnAla8SDcKEFelJ1ivXZEEWO/ystCJOWQ
 EecjG1OA/6SJhCP2xcZxI1a8dlxxEHVopHzoaWxMVA==
X-Google-Smtp-Source: ABdhPJwrasY9JcPFiwLwa+43qJOp5mIpvdCszm1mNMgddNodQbwFVvhxDXFbeGXmw+BZqLUOn/xNE/GTMXvfEd3WSbE=
X-Received: by 2002:a92:d68a:: with SMTP id p10mr3777714iln.40.1618510038696; 
 Thu, 15 Apr 2021 11:07:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210415173507.4235-1-qingqing.zhuo@amd.com>
In-Reply-To: <20210415173507.4235-1-qingqing.zhuo@amd.com>
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Date: Thu, 15 Apr 2021 20:07:15 +0200
Message-ID: <CAP+8YyFQ5zBLomdfzNu6QbDcKUUyU2Ok8aizwE3yC2v0poP99g@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/display: Update modifier list for gfx10_3
To: Qingqing Zhuo <qingqing.zhuo@amd.com>
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
Cc: Mark Yacoub <markyacoub@chromium.org>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, "Wheeler,
 Daniel" <daniel.wheeler@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Content-Type: multipart/mixed; boundary="===============1657310032=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1657310032==
Content-Type: multipart/alternative; boundary="000000000000ec1ee105c006bba0"

--000000000000ec1ee105c006bba0
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Tested-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>

(Checked that Weston on SIENNA_CICHLID now gets DCC)

Thanks!

On Thu, Apr 15, 2021 at 7:35 PM Qingqing Zhuo <qingqing.zhuo@amd.com> wrote:

> [Why]
> Current list supports modifiers that have DCC_MAX_COMPRESSED_BLOCK
> set to AMD_FMT_MOD_DCC_BLOCK_128B, while AMD_FMT_MOD_DCC_BLOCK_64B
> is used instead by userspace.
>
> [How]
> Replace AMD_FMT_MOD_DCC_BLOCK_128B with AMD_FMT_MOD_DCC_BLOCK_64B
> for modifiers with DCC supported.
>
> Fixes: 91e54fd70c6a ("drm/amd/display: Expose modifiers")
> Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index e29cb2e956db..9fded25d2363 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4544,7 +4544,7 @@ add_gfx10_3_modifiers(const struct amdgpu_device
> *adev,
>                     AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
>                     AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
>                     AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
> -                   AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK,
> AMD_FMT_MOD_DCC_BLOCK_128B));
> +                   AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK,
> AMD_FMT_MOD_DCC_BLOCK_64B));
>
>         add_modifier(mods, size, capacity, AMD_FMT_MOD |
>                     AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
> @@ -4556,7 +4556,7 @@ add_gfx10_3_modifiers(const struct amdgpu_device
> *adev,
>                     AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
>                     AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
>                     AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
> -                   AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK,
> AMD_FMT_MOD_DCC_BLOCK_128B));
> +                   AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK,
> AMD_FMT_MOD_DCC_BLOCK_64B));
>
>         add_modifier(mods, size, capacity, AMD_FMT_MOD |
>                     AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
> --
> 2.17.1
>
>

--000000000000ec1ee105c006bba0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Reviewed-by: Bas Nieuwenhuizen &lt;<a href=3D"mailto:=
bas@basnieuwenhuizen.nl">bas@basnieuwenhuizen.nl</a>&gt;</div><div>Tested-b=
y: Bas Nieuwenhuizen &lt;<a href=3D"mailto:bas@basnieuwenhuizen.nl">bas@bas=
nieuwenhuizen.nl</a>&gt;</div><div><br></div><div>(Checked that Weston on S=
IENNA_CICHLID now gets DCC)</div><div><br></div><div>Thanks!<br></div></div=
><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Th=
u, Apr 15, 2021 at 7:35 PM Qingqing Zhuo &lt;<a href=3D"mailto:qingqing.zhu=
o@amd.com">qingqing.zhuo@amd.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">[Why]<br>
Current list supports modifiers that have DCC_MAX_COMPRESSED_BLOCK<br>
set to AMD_FMT_MOD_DCC_BLOCK_128B, while AMD_FMT_MOD_DCC_BLOCK_64B<br>
is used instead by userspace.<br>
<br>
[How]<br>
Replace AMD_FMT_MOD_DCC_BLOCK_128B with AMD_FMT_MOD_DCC_BLOCK_64B<br>
for modifiers with DCC supported.<br>
<br>
Fixes: 91e54fd70c6a (&quot;drm/amd/display: Expose modifiers&quot;)<br>
Signed-off-by: Qingqing Zhuo &lt;<a href=3D"mailto:qingqing.zhuo@amd.com" t=
arget=3D"_blank">qingqing.zhuo@amd.com</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--<br>
=C2=A01 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
index e29cb2e956db..9fded25d2363 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
@@ -4544,7 +4544,7 @@ add_gfx10_3_modifiers(const struct amdgpu_device *ade=
v,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_F=
MT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_F=
MT_MOD_SET(DCC_INDEPENDENT_64B, 1) |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_F=
MT_MOD_SET(DCC_INDEPENDENT_128B, 1) |<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_F=
MT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_128B));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_F=
MT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B));<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 add_modifier(mods, size, capacity, AMD_FMT_MOD =
|<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_F=
MT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |<br>
@@ -4556,7 +4556,7 @@ add_gfx10_3_modifiers(const struct amdgpu_device *ade=
v,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_F=
MT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_F=
MT_MOD_SET(DCC_INDEPENDENT_64B, 1) |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_F=
MT_MOD_SET(DCC_INDEPENDENT_128B, 1) |<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_F=
MT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_128B));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_F=
MT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B));<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 add_modifier(mods, size, capacity, AMD_FMT_MOD =
|<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_F=
MT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |<br>
-- <br>
2.17.1<br>
<br>
</blockquote></div>

--000000000000ec1ee105c006bba0--

--===============1657310032==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1657310032==--
