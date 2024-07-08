Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE9E9C3271E
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jul 2024 16:16:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68B6310E313;
	Mon,  8 Jul 2024 16:16:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cQ7mxexe";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92E2F10E313
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jul 2024 16:16:57 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-1fb4a332622so13558825ad.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Jul 2024 09:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720455417; x=1721060217; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6aBMuuUnv1UZ2LDUJWOYNaUOMpeEZS//uiLmP4Ulkp4=;
 b=cQ7mxexeXJ6Mzk7Bi2Qc9RePOWd19XaN1+1oDjyhxU4pvPKnG3z+MErMYQsKTxeNOD
 Pc2+Dxat9hCxgLD0H8Hjz4D7qXBgdRfvEluvXCqMEXVBOmv1GATwtAWHq+HaECXlqie0
 jpSzeX/YOcFztsapP4d8iL0nCHSWaGKMCxRHhJwkRJy6rz1dtD+CK58xqbWvfswljlKu
 AUYkPSXiMI63ZZtLev2D6ASmZ9At0xbGTAKNUHYw+41hDWWJ2A8cv2NTRPS67aoM3isY
 eNE78xo8I9BvMe6Mq19OiemL/Z24+4dZcnn2CLSLZViOzVA6YkSWzklakw0/mi5i4I9u
 9t3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720455417; x=1721060217;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6aBMuuUnv1UZ2LDUJWOYNaUOMpeEZS//uiLmP4Ulkp4=;
 b=DT/BRi+fzlJaqlVaLGxy6VdxGkTo7UAbOETWXQ2thifXFRhUDI7TmR64x5nQQCVIP2
 Tn9s81AOelRpji8OWGfMx9MihlOebS1F2tgmAi4mq/pnMS37dv1yrx/czntZruTkA2In
 XOQIzFqfntd8knbxxO7ww3E6ux50DkLDk50I7sTBh2BfqioveessL9h9QWN8MO37/fgl
 /lsjvMlD1kzzzs5cmTvxIWz+y5Ziq6dNhCVjpMcAj9MJfNzSAQrAWYxbheWA0uqscR7X
 N7UfrNQ69kABWxKzsh999161WlzG/TqOdxsKEFwr/yLC/ggKk0kv5C9a/cIW+FEyJl9E
 zBow==
X-Gm-Message-State: AOJu0Yww84ZgdMNhlqLvEVIg3mDu8jSizqzbXjtG2bxetz5ymZWGTJzo
 HrL8vorGclqodF1MCe/st/+Vp3KgmT56c7IX2Xxw5UT6PJL9Ebt/1uUgzMWhC88e1ep+L4H9RPY
 NXCEM8odMv3akqvraI0IUHHDSIgGwXg==
X-Google-Smtp-Source: AGHT+IGc5uaxWbuqAMzVu7yacM+Q6PRuEXrewST3R5g7D7xV0sJwRcpyqUTzSSuDADhhTm+sjlYfaVwm5R1wQ50uhzk=
X-Received: by 2002:a17:90b:180e:b0:2c4:e333:35e5 with SMTP id
 98e67ed59e1d1-2ca35d43471mr158034a91.36.1720455416946; Mon, 08 Jul 2024
 09:16:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240708160610.1354015-1-aurabindo.pillai@amd.com>
In-Reply-To: <20240708160610.1354015-1-aurabindo.pillai@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 8 Jul 2024 12:16:45 -0400
Message-ID: <CADnq5_OtZgMpQd0a-KYZ=1-N3qshKqq7HZ6WLUNP_TRrAQqO5Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Allow display DCC for DCN401
To: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, rodrigo.siqueira@amd.com, 
 marek.olsak@amd.com, harry.wentland@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Jul 8, 2024 at 12:06=E2=80=AFPM Aurabindo Pillai
<aurabindo.pillai@amd.com> wrote:
>
> To enable mesa to use display dcc, DM should expose them in the
> supported modifiers. Add the best (most efficient) modifiers first.
>
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 31 +++++++++++++++----
>  1 file changed, 25 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index 0320200dae94..a83bd0331c3b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -689,13 +689,32 @@ static void amdgpu_dm_plane_add_gfx12_modifiers(str=
uct amdgpu_device *adev,
>                       uint64_t **mods, uint64_t *size, uint64_t *capacity=
)
>  {
>         uint64_t ver =3D AMD_FMT_MOD | AMD_FMT_MOD_SET(TILE_VERSION, AMD_=
FMT_MOD_TILE_VER_GFX12);
> +       uint64_t mod_256k =3D ver | AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TIL=
E_GFX12_256K_2D);
> +       uint64_t mod_64k =3D ver | AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE=
_GFX12_64K_2D);
> +       uint64_t mod_4k =3D ver | AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_=
GFX12_4K_2D);
> +       uint64_t mod_256b =3D ver | AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TIL=
E_GFX12_256B_2D);
> +       uint64_t dcc =3D ver | AMD_FMT_MOD_SET(DCC, 1);
> +       uint8_t max_comp_block[] =3D {1, 0};
> +       uint64_t max_comp_block_mod[ARRAY_SIZE(max_comp_block)] =3D {0};
> +       uint8_t i =3D 0, j =3D 0;
> +       uint64_t gfx12_modifiers[] =3D {mod_256k, mod_64k, mod_4k, mod_25=
6b, DRM_FORMAT_MOD_LINEAR};
> +
> +       for (i =3D 0; i < ARRAY_SIZE(max_comp_block); i++)
> +               max_comp_block_mod[i] =3D AMD_FMT_MOD_SET(DCC_MAX_COMPRES=
SED_BLOCK, max_comp_block[i]);
> +
> +       /* With DCC: Best choice should be kept first. Hence, add all 256=
k modifiers of different
> +        * max compressed blocks first and then move on to the next small=
er sized layouts.
> +        * Do not add the linear modifier here, and hence the condition o=
f size-1 for the loop
> +        */
> +       for (j =3D 0; j < ARRAY_SIZE(gfx12_modifiers) - 1; j++)
> +               for (i =3D 0; i < ARRAY_SIZE(max_comp_block); i++)
> +                       amdgpu_dm_plane_add_modifier(mods, size, capacity=
,
> +                                                    ver | dcc | max_comp=
_block_mod[i] | gfx12_modifiers[j]);
> +
> +       /* Without DCC. Add all modifiers including linear at the end */
> +       for (i =3D 0; i < ARRAY_SIZE(gfx12_modifiers); i++)
> +               amdgpu_dm_plane_add_modifier(mods, size, capacity, gfx12_=
modifiers[i]);
>
> -       /* Without DCC: */
> -       amdgpu_dm_plane_add_modifier(mods, size, capacity, ver | AMD_FMT_=
MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX12_256K_2D));
> -       amdgpu_dm_plane_add_modifier(mods, size, capacity, ver | AMD_FMT_=
MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX12_64K_2D));
> -       amdgpu_dm_plane_add_modifier(mods, size, capacity, ver | AMD_FMT_=
MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX12_4K_2D));
> -       amdgpu_dm_plane_add_modifier(mods, size, capacity, ver | AMD_FMT_=
MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX12_256B_2D));
> -       amdgpu_dm_plane_add_modifier(mods, size, capacity, DRM_FORMAT_MOD=
_LINEAR);
>  }
>
>  static int amdgpu_dm_plane_get_plane_modifiers(struct amdgpu_device *ade=
v, unsigned int plane_type, uint64_t **mods)
> --
> 2.45.2
>
