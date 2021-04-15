Return-Path: <SRS0=drzA=JM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08438C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Apr 2021 11:25:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34BD861249
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Apr 2021 11:25:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34BD861249
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=basnieuwenhuizen.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF6DA6EA39;
	Thu, 15 Apr 2021 11:25:55 +0000 (UTC)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D3136EA39
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Apr 2021 11:25:55 +0000 (UTC)
Received: by mail-io1-xd35.google.com with SMTP id p8so2463317iol.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Apr 2021 04:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oHOJlzbzbGhC2F6nRwyEe4wfHAomSrzm5Iwa2Cpb7mU=;
 b=beioRa2T8BLBQIRY9h1p4dlbdq0aBEfR4yYFF9vSVKUtzfrnRl2+JvDZ924lTebvcC
 J9jDPwIoNYTwI6hFGhLDZVNBU9HHWcu3NO6WkTMY2FsKlWmbKVy0yzjCqygM2laL0x8G
 9EZ1HH35DPoSQpKh7g4HGRvi7TzKp1EFs1nJ24lZODhQI5TBpa0VjUBP9OZncSXt25RG
 0dj29nYXDCdWV1AkUXqVsPlngO2RWD/juJ9hKsAfUchSBZbN4u9oYZvCHgGP5x3n2qZJ
 ht6spx9lJ2cM5b9aNIjm0bMv2cfjbvs/6UxIYi6J0HuatbaN/al776kZLiuKyk2kUHQn
 9Ivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oHOJlzbzbGhC2F6nRwyEe4wfHAomSrzm5Iwa2Cpb7mU=;
 b=BrFp4qOjdE45mPdF7+TkGjYXobFXZBykat8Q0OLubg9L7L9iaIcynYSYNjQQ7daeEY
 Nu+BsMTMkNoVlm3bqHHpdnvaJHKUL04ql3g2bkVPEdAsq3Wf08UTtNhI4zV0pu+K46QN
 7gsEQKWd1UAeTW7uP2EmwRH4dQb33UysbQwhNFzwQ9d6/5aZWJ9vNYP4af7jtEP7q7Ly
 1BCc2aDmMfXeqnugABwnwsekU98pTetSw6RwyPKMzbAj6lKJZg4juzbC3UJBy3mhly6z
 Ze7FQvB9ksWgpGH5IES4N1fkKy7WL3HZkZXxzCnB16WNWXEDfkju8voDrz3Py2vYr4EA
 l+Fg==
X-Gm-Message-State: AOAM532XKedftOFFAZrBujaNWDeCJX/AIymMqB8cRJsGqe0urGCzNyis
 AQ6Ou75UUuGC63BiXOAT8VKUNzaekCt64qOaNNxaAQ==
X-Google-Smtp-Source: ABdhPJwxIPZsbJxTwSjUwfQbYZbOf3esIR6PGiAI6nFj5Tk9L8P7b1iV6H6wr6mmd8lqnKqVVspPpbxHahECABa/deQ=
X-Received: by 2002:a05:6638:238c:: with SMTP id
 q12mr2454425jat.114.1618485954763; 
 Thu, 15 Apr 2021 04:25:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210414233533.24012-1-qingqing.zhuo@amd.com>
In-Reply-To: <20210414233533.24012-1-qingqing.zhuo@amd.com>
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Date: Thu, 15 Apr 2021 13:25:35 +0200
Message-ID: <CAP+8YyHU8GtCzFk71h1qjQWKYQpMwrA=s88dw2Fu3_0LXSMEWA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amd/display: Update modifier list for gfx10_3
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
Cc: Mark Yacoub <markyacoub@chromium.org>, Rodrigo.Siqueira@amd.com,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, daniel.wheeler@amd.com,
 Alex Deucher <alexander.deucher@amd.com>, "Kazlauskas,
 Nicholas" <nicholas.kazlauskas@amd.com>
Content-Type: multipart/mixed; boundary="===============1063931235=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1063931235==
Content-Type: multipart/alternative; boundary="000000000000686de005c0012000"

--000000000000686de005c0012000
Content-Type: text/plain; charset="UTF-8"

On Thu, Apr 15, 2021 at 1:35 AM Qingqing Zhuo <qingqing.zhuo@amd.com> wrote:

> [Why]
> Current list only includes modifiers where DCC_MAX_COMPRESSED_BLOCK
> is set to AMD_FMT_MOD_DCC_BLOCK_128B, while AMD_FMT_MOD_DCC_BLOCK_64B
> is also supported and used by userspace.
>
> [How]
> Add AMD_FMT_MOD_DCC_BLOCK_64B to modifiers with DCC supported.
>
> Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index e29cb2e956db..c3cbc3d298e7 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4535,6 +4535,17 @@ add_gfx10_3_modifiers(const struct amdgpu_device
> *adev,
>         int pipe_xor_bits =
> ilog2(adev->gfx.config.gb_addr_config_fields.num_pipes);
>         int pkrs = ilog2(adev->gfx.config.gb_addr_config_fields.num_pkrs);
>
> +       add_modifier(mods, size, capacity, AMD_FMT_MOD |
> +                   AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
> +                   AMD_FMT_MOD_SET(TILE_VERSION,
> AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
> +                   AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
> +                   AMD_FMT_MOD_SET(PACKERS, pkrs) |
> +                   AMD_FMT_MOD_SET(DCC, 1) |
> +                   AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
> +                   AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
> +                   AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
> +                   AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK,
> AMD_FMT_MOD_DCC_BLOCK_64B));
>

Thanks for finding this issue. Looking at it it looks to me like the
original entries are mistaken. Can we just change the
DCC_MAX_COMPRESSED_BLOCK in the already existing DCC entries? Looks like
Mesa always uses the AMD_FMT_MOD_DCC_BLOCK_64B anyway, and I don't think
DCC_INDEPENDENT_64B=1 + DCC_MAX_COMPRESSED_BLOCK=AMD_FMT_MOD_DCC_BLOCK_128B
makes sense.

+
>         add_modifier(mods, size, capacity, AMD_FMT_MOD |
>                     AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
>                     AMD_FMT_MOD_SET(TILE_VERSION,
> AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
> @@ -4546,6 +4557,18 @@ add_gfx10_3_modifiers(const struct amdgpu_device
> *adev,
>                     AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
>                     AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK,
> AMD_FMT_MOD_DCC_BLOCK_128B));
>
> +       add_modifier(mods, size, capacity, AMD_FMT_MOD |
> +                   AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
> +                   AMD_FMT_MOD_SET(TILE_VERSION,
> AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
> +                   AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
> +                   AMD_FMT_MOD_SET(PACKERS, pkrs) |
> +                   AMD_FMT_MOD_SET(DCC, 1) |
> +                   AMD_FMT_MOD_SET(DCC_RETILE, 1) |
> +                   AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
> +                   AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
> +                   AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
> +                   AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK,
> AMD_FMT_MOD_DCC_BLOCK_64B));
> +
>         add_modifier(mods, size, capacity, AMD_FMT_MOD |
>                     AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
>                     AMD_FMT_MOD_SET(TILE_VERSION,
> AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
> --
> 2.17.1
>
>

--000000000000686de005c0012000
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Apr 15, 2021 at 1:35 AM Qingq=
ing Zhuo &lt;<a href=3D"mailto:qingqing.zhuo@amd.com">qingqing.zhuo@amd.com=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
[Why]<br>
Current list only includes modifiers where DCC_MAX_COMPRESSED_BLOCK<br>
is set to AMD_FMT_MOD_DCC_BLOCK_128B, while AMD_FMT_MOD_DCC_BLOCK_64B<br>
is also supported and used by userspace.<br>
<br>
[How]<br>
Add AMD_FMT_MOD_DCC_BLOCK_64B to modifiers with DCC supported.<br>
<br>
Signed-off-by: Qingqing Zhuo &lt;<a href=3D"mailto:qingqing.zhuo@amd.com" t=
arget=3D"_blank">qingqing.zhuo@amd.com</a>&gt;<br>
---<br>
=C2=A0.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 23 ++++++++++++++++++=
+<br>
=C2=A01 file changed, 23 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
index e29cb2e956db..c3cbc3d298e7 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
@@ -4535,6 +4535,17 @@ add_gfx10_3_modifiers(const struct amdgpu_device *ad=
ev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int pipe_xor_bits =3D ilog2(adev-&gt;gfx.config=
.gb_addr_config_fields.num_pipes);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int pkrs =3D ilog2(adev-&gt;gfx.config.gb_addr_=
config_fields.num_pkrs);<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0add_modifier(mods, size, capacity, AMD_FMT_MOD =
|<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_F=
MT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_F=
MT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_F=
MT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_F=
MT_MOD_SET(PACKERS, pkrs) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_F=
MT_MOD_SET(DCC, 1) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_F=
MT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_F=
MT_MOD_SET(DCC_INDEPENDENT_64B, 1) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_F=
MT_MOD_SET(DCC_INDEPENDENT_128B, 1) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_F=
MT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B));<br></bloc=
kquote><div><br></div><div>Thanks for finding this issue. Looking at it it =
looks to me like the original entries are mistaken. Can we just change the=
=C2=A0 DCC_MAX_COMPRESSED_BLOCK in the already existing DCC entries? Looks =
like Mesa always uses the AMD_FMT_MOD_DCC_BLOCK_64B anyway, and I don&#39;t=
 think DCC_INDEPENDENT_64B=3D1 + DCC_MAX_COMPRESSED_BLOCK=3DAMD_FMT_MOD_DCC=
_BLOCK_128B makes sense.</div><div><br></div><div> </div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 add_modifier(mods, size, capacity, AMD_FMT_MOD =
|<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_F=
MT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_F=
MT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |<br>
@@ -4546,6 +4557,18 @@ add_gfx10_3_modifiers(const struct amdgpu_device *ad=
ev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_F=
MT_MOD_SET(DCC_INDEPENDENT_128B, 1) |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_F=
MT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_128B));<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0add_modifier(mods, size, capacity, AMD_FMT_MOD =
|<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_F=
MT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_F=
MT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_F=
MT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_F=
MT_MOD_SET(PACKERS, pkrs) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_F=
MT_MOD_SET(DCC, 1) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_F=
MT_MOD_SET(DCC_RETILE, 1) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_F=
MT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_F=
MT_MOD_SET(DCC_INDEPENDENT_64B, 1) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_F=
MT_MOD_SET(DCC_INDEPENDENT_128B, 1) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_F=
MT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B));<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 add_modifier(mods, size, capacity, AMD_FMT_MOD =
|<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_F=
MT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_F=
MT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |<br>
-- <br>
2.17.1<br>
<br>
</blockquote></div></div>

--000000000000686de005c0012000--

--===============1063931235==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1063931235==--
