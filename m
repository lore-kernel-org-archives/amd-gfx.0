Return-Path: <SRS0=YYL8=OG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC29BC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Sep 2021 00:12:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 994896103B
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Sep 2021 00:12:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 994896103B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A9B76EA82;
	Thu, 16 Sep 2021 00:12:18 +0000 (UTC)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBBD06EA82
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Sep 2021 00:12:16 +0000 (UTC)
Received: by mail-pj1-x102a.google.com with SMTP id
 f3-20020a17090a638300b00199097ddf1aso6265683pjj.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Sep 2021 17:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HF7at2+2fqDHZYM+8hKA5o5AJgt9rHfAE/DoGG8T/ao=;
 b=ZkRFO2D73R+UE5z70eKMJB+rPy43gautr1zXl6eHBcCWJys+e8eSocw8KrMmZ5ncBK
 NHZT1OE8Z1XOKesoOg+WtBS6majmB8owgNGw/DOF1T8hC18JPARXIsD7f/rFe+1jA3Qt
 E6KsIOCm1GLlBgVbtPvK4DApgEVVo6dAJmTRMlmIIs4/aGEAlcTROJuFarC9jY4aWcu+
 cm3d3H4VcDgTt3sip3HJxKzgkj+hrTd4K79xvYZDPp63GpJPFycKZrmZBLixKC50uVTf
 TIoeaZV0JhrGQDtaJMDnU6afKcKH6G/EtSPg5ABLn6tryYE4o7/R4sDgwW8su+4rgb5i
 xMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HF7at2+2fqDHZYM+8hKA5o5AJgt9rHfAE/DoGG8T/ao=;
 b=06vaPrFPl+1RDR66v9iQx4pLYjbmR/k71mmZZX6mSdebZqKGGjYERpkySpuJZRsoqx
 dLpeaWZufEydKfZrL8AzywBulCwRQKWWc6FXz8iX28SS03aYzTWFjCTcGc5q2uFQ1VAv
 T9qRVS9vGDqyOZRRtO0GxTUktdiZA1T3Udm5g8+82okm1JMQrDJ33gEZnOe3mgonXS5v
 l1zy7uUYkqYrVFYHjtYAGlEe+RmtTW8gnov4NR0MIgUV7eW1U/EYvQC3NxnoUJ+lTl7l
 X60qd/Fd6jvwuTyhAAfwGS49ERAllMRyDR7Om+Ejmp6Zw329Lat2wg139OdFE4f3K4s5
 lJow==
X-Gm-Message-State: AOAM532Pekk4PY2TtJjeUMUQj6/ZhpQHPBjfTfwS2GTSaAkiR7qiKH1/
 3tQMeX1T2e6XUvhjaD23zw/Ai03Vg7fB/d0fzTkdMPre/PAhWw==
X-Google-Smtp-Source: ABdhPJxsAjULa6e2c273CkXBo7il0dPxZS9AzOt72Sm37YlIxFjDrvUfYfcqG5Utx4AUgKPKQfepWAYtui7HniP/0bo=
X-Received: by 2002:a17:902:b218:b029:11a:bf7b:1a80 with SMTP id
 t24-20020a170902b218b029011abf7b1a80mr2138410plr.82.1631751136332; Wed, 15
 Sep 2021 17:12:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210914235948.893422-1-joshua@froggi.es>
 <20210914235948.893422-3-joshua@froggi.es>
In-Reply-To: <20210914235948.893422-3-joshua@froggi.es>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Wed, 15 Sep 2021 20:11:40 -0400
Message-ID: <CAAxE2A4yR7aXPocAHdsKsyN-vVQFUKiX_7gyxD6-iG4mzHTs6A@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amd/display: Add modifiers capable of DCC image
 stores for gfx10_3
To: Joshua Ashton <joshua@froggi.es>
Cc: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, 
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Content-Type: multipart/alternative; boundary="000000000000d7d03405cc11aab2"
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

--000000000000d7d03405cc11aab2
Content-Type: text/plain; charset="UTF-8"

Based on the discussions we had about displayable DCC internally, only
MAX_COMPRESSED_BLOCK = 64B with both DCC_INDEPENDENT_64B_BLOCKS and
DCC_INDEPENDENT_128B_BLOCKS is supported by DCN on RDNA 2.

Is there something new on the hardware side that I missed?

Marek

On Tue, Sep 14, 2021 at 7:59 PM Joshua Ashton <joshua@froggi.es> wrote:

> Some games, ie. Doom Eternal, present from compute following compute
> post-fx and would benefit from having DCC image stores available.
>
> DCN on gfx10_3 doesn't need INDEPENDENT_128B_BLOCKS = 0 so we can expose
> these modifiers capable of DCC image stores.
>
> Signed-off-by: Joshua Ashton <joshua@froggi.es>
> Reviewed-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 2a24e43623cb..a4e33a4336a0 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4817,6 +4817,16 @@ add_gfx10_3_modifiers(const struct amdgpu_device
> *adev,
>                     AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
>                     AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK,
> AMD_FMT_MOD_DCC_BLOCK_64B));
>
> +       add_modifier(mods, size, capacity, AMD_FMT_MOD |
> +                   AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
> +                   AMD_FMT_MOD_SET(TILE_VERSION,
> AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
> +                   AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
> +                   AMD_FMT_MOD_SET(PACKERS, pkrs) |
> +                   AMD_FMT_MOD_SET(DCC, 1) |
> +                   AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
> +                   AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
> +                   AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK,
> AMD_FMT_MOD_DCC_BLOCK_128B));
> +
>         add_modifier(mods, size, capacity, AMD_FMT_MOD |
>                     AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
>                     AMD_FMT_MOD_SET(TILE_VERSION,
> AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
> @@ -4829,6 +4839,17 @@ add_gfx10_3_modifiers(const struct amdgpu_device
> *adev,
>                     AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
>                     AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK,
> AMD_FMT_MOD_DCC_BLOCK_64B));
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
> +                   AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
> +                   AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK,
> AMD_FMT_MOD_DCC_BLOCK_128B));
> +
>         add_modifier(mods, size, capacity, AMD_FMT_MOD |
>                     AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
>                     AMD_FMT_MOD_SET(TILE_VERSION,
> AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
> --
> 2.33.0
>
>

--000000000000d7d03405cc11aab2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Based on the discussions we had about displayable DCC=
 internally, only MAX_COMPRESSED_BLOCK =3D 64B with both DCC_INDEPENDENT_64=
B_BLOCKS and DCC_INDEPENDENT_128B_BLOCKS is supported by DCN on RDNA 2.</di=
v><div><br></div><div>Is there something new on the hardware side that I mi=
ssed?<br></div><div><br></div><div>Marek<br></div></div><br><div class=3D"g=
mail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 14, 2021 at 7=
:59 PM Joshua Ashton &lt;<a href=3D"mailto:joshua@froggi.es">joshua@froggi.=
es</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">Some games, ie. Doom Eternal, present from compute following compute<br>
post-fx and would benefit from having DCC image stores available.<br>
<br>
DCN on gfx10_3 doesn&#39;t need INDEPENDENT_128B_BLOCKS =3D 0 so we can exp=
ose<br>
these modifiers capable of DCC image stores.<br>
<br>
Signed-off-by: Joshua Ashton &lt;<a href=3D"mailto:joshua@froggi.es" target=
=3D"_blank">joshua@froggi.es</a>&gt;<br>
Reviewed-by: Bas Nieuwenhuizen &lt;<a href=3D"mailto:bas@basnieuwenhuizen.n=
l" target=3D"_blank">bas@basnieuwenhuizen.nl</a>&gt;<br>
---<br>
=C2=A0.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 21 ++++++++++++++++++=
+<br>
=C2=A01 file changed, 21 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
index 2a24e43623cb..a4e33a4336a0 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
@@ -4817,6 +4817,16 @@ add_gfx10_3_modifiers(const struct amdgpu_device *ad=
ev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_F=
MT_MOD_SET(DCC_INDEPENDENT_128B, 1) |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_F=
MT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B));<br>
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
MT_MOD_SET(DCC_INDEPENDENT_128B, 1) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_F=
MT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_128B));<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 add_modifier(mods, size, capacity, AMD_FMT_MOD =
|<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_F=
MT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_F=
MT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |<br>
@@ -4829,6 +4839,17 @@ add_gfx10_3_modifiers(const struct amdgpu_device *ad=
ev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_F=
MT_MOD_SET(DCC_INDEPENDENT_128B, 1) |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_F=
MT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B));<br>
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
MT_MOD_SET(DCC_INDEPENDENT_128B, 1) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_F=
MT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_128B));<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 add_modifier(mods, size, capacity, AMD_FMT_MOD =
|<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_F=
MT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_F=
MT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |<br>
-- <br>
2.33.0<br>
<br>
</blockquote></div>

--000000000000d7d03405cc11aab2--
