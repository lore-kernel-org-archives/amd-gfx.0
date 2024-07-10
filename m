Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71DC9C3DA41
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 14:50:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DBE310E7FF;
	Wed, 10 Jul 2024 14:50:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eLMgrk+3";
	dkim-atps=neutral
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com
 [209.85.167.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 543D910E6F9
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 14:50:02 +0000 (UTC)
Received: by mail-lf1-f42.google.com with SMTP id
 2adb3069b0e04-52e97e5a84bso9767295e87.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 07:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720623000; x=1721227800; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xtEjmJUei0ipcb/TgSNMmIFsqE9NFNyVl4pTLmVNxzo=;
 b=eLMgrk+39GeXEdx+rz6dC6os6iT31AWWnQTIS7Vo7AJ9M3bPWclp250KSf0vG7nTKM
 dhfnDIv1C4RAHF2iBQNlbvIXbXDFwIhj7Hb263xxQjNuG1TcxE7h4ehorK+olQQd1I8x
 8Z8lfwBXnU6pf4HW/61FwyNyB/6r4CetjSLMLwAkwxrjuL5swD2qDX9vZA9ZZXdq9g4v
 R5u35FPzwLZp073nEbMwGw5NSQg7ZkGAGoKwsZ6SyNcUSZrjO8VCYAVJ8Qv7z/2KFjox
 MSTMPtJ6Vkiu3ntgTZa0hBLxGLzErnuGp0xuFSzDPEmKtwkgrhQNh+9N2pZxK0ahJUJS
 MatQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720623000; x=1721227800;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xtEjmJUei0ipcb/TgSNMmIFsqE9NFNyVl4pTLmVNxzo=;
 b=eiUQ3DVRT833FzBGO3dcJoiLfzzEfSSvZNUcwJAuMiSQqymHIQon4Jlr9TTgfxZHb3
 p05slvxh4hIzFQ5jgg/GThzjmJcJHsxMZnJYRx3Q+vftQYhTXLuR7R4ReXIMR2UiTo7k
 WpkTwJcYQcklsZQBhZ378yTycVpofB2qGUfhKP53qWuUqmE4Ii7LwyB25BzxeF4GGaZB
 uF+WjNOfpMPBRjO7GrEjWwZvLdbA92rEhyLBj7taqirK/V7vfRmP86/DLz1FTY7zFSXp
 RKV+Y6i5rsHi/32CJGn3Lgjq06/89s4byMPUxETabNVTutsuBAnar4NwLnh61itPZGns
 2+mw==
X-Gm-Message-State: AOJu0YwsZZ6A84XPjr+GWFa/vvYfB63RjI6X3qDoFWB+S3T9vD6jtuxg
 RfAdoQdIwEB3ETknukJTQSqiayN4hJO4yp2p43XtaF7baWMIMMwd2XOC/PWauQ0/KHMYPPkEJMo
 +waqYnGicXYMCoEYbk+fB0ehs7tg=
X-Google-Smtp-Source: AGHT+IGPb641FuknhFmQYWO6ZQh/NGvAnomB30fB7pTfVTjExZ58rOtD3ANQ9OsHUVHTU7x7AC8UUe0U8QTgcepGr/Q=
X-Received: by 2002:a05:6512:2245:b0:52c:c9e4:3291 with SMTP id
 2adb3069b0e04-52eb99d653amr5246363e87.60.1720623000063; Wed, 10 Jul 2024
 07:50:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240708160610.1354015-1-aurabindo.pillai@amd.com>
In-Reply-To: <20240708160610.1354015-1-aurabindo.pillai@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Wed, 10 Jul 2024 10:49:23 -0400
Message-ID: <CAAxE2A4gOcABsskv2e3Dwc_XVaXs-CmfK_D34nZgFjY3H_qY2w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Allow display DCC for DCN401
To: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, rodrigo.siqueira@amd.com, 
 marek.olsak@amd.com, harry.wentland@amd.com, alexdeucher@gmail.com
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

This will enable display DCC for Wayland because Mesa already exposes
modifiers with DCC. Has it been tested?

Marek

On Mon, Jul 8, 2024 at 12:06=E2=80=AFPM Aurabindo Pillai
<aurabindo.pillai@amd.com> wrote:
>
> To enable mesa to use display dcc, DM should expose them in the
> supported modifiers. Add the best (most efficient) modifiers first.
>
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
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
