Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F0DEB26EB
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 23:20:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 893EA10E054;
	Tue, 10 Feb 2026 23:20:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hRQx+BZS";
	dkim-atps=neutral
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF80C10E054
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 23:20:26 +0000 (UTC)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-1233be8d537so208738c88.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 15:20:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770765626; cv=none;
 d=google.com; s=arc-20240605;
 b=iXEN3XdybFfhVOfCFSRqhixK9hlJ1CZ/8g08rPPepZMN7MHQU3aiJWZEv04Lt60Tnk
 ZUYJ0krd4E05S0ui6jfNmUOBgiGa0zcQils4tYPRNJYAPHvVPBv8+zphQ60egrG5fMS5
 YxoHg9A2fceTX3gCXL8SSS1DdIW/ylmm4q/z4c+drD/WZt+PnOS/yQ+IKLbZp2GSSi6P
 Bt8KhAwIVtmJBz1iF3r3zcN4UgrCLv199fY2/e6D/k/nrq0BSCMCuiP0YCdjTQHww/AZ
 zYg8LdgXg83PrUsxFRhfnHVCsamZBKoHayrDS2IHjhZrIeLdQ25UUS+IUXA1W9m3YMu/
 Op9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kKTzvH8G1FLCL6IgdEBYEOkcljfpjK1b7KToDC66akw=;
 fh=cCJmFHoerL401E4WTln33sQe3ddmb4b7aGLd0mnk40I=;
 b=W76rr5gTChvS1vrv+xeODqfN/heVuCbiEIY0hLB15cBHXAAWW3pfNTei5JPYWSHFWz
 DvXQKcudWetiIPXG0ZVIA9turAh3X8O/qe9xrDSNMcF1SWBOxKp8CIDZa1ccgZhDrGFC
 nNHOewvstj6QP4BVN7tBD4LkHVIeUo7VyCixMRMBEOG2rf2R8AHeikRYf5sIDN3xtNGU
 oSKOxHhr/2aF8q1xPH/Xx2E6mYUJoBd41mz0mb9Rnokk6RuCXqL7W9TY2JI18CaPWgWd
 VZ+BNp+LHxLXVXX7QOS1qhjU68d1kqKSHw0fnxqDvg+GyzrUFnEgjDk5R6BaTkNaHlXf
 bIiQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770765626; x=1771370426; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kKTzvH8G1FLCL6IgdEBYEOkcljfpjK1b7KToDC66akw=;
 b=hRQx+BZSm7xdOQKF4G7UTddC7RkTUF2AcmogcXhu8imABfz851JA+XGFZj5P7POHJ3
 FPWKhnRCHyrLJw21jcR9wt69Os8D0y1pB7o6CIxbwdEDMMSn4BXc061ywS4nLQmojFxP
 9G8s58fmALWWhc8FW9DyFPV1oeKqXEdKx/3c5SuaL8eidH/Lt0WVNb+hbnUu9uGWNJkw
 lkCXdgGnSnyGxZXZvrBk5F19pPL5jaiIVIkuYzg5Nozg/gLdit6SKlUXv3wj8ztPtcWg
 TR3dp4Ge3Bm0/xi8MpKbZ4lTy5P4zNdNYvmSuTkTQwfHIIDB+9NBNQp6I+VglQtc4t7M
 i59Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770765626; x=1771370426;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kKTzvH8G1FLCL6IgdEBYEOkcljfpjK1b7KToDC66akw=;
 b=n+Mt04rOhjK1SkRy5e0B1DNCjyPxMHHDs7pE4O4YakPVPouaE6vATiT6xFcZD4C4l4
 nifQ/R0NWWXFm0oqKX2zgOEkBE4zbbOlDvOz165qaHOeFhPIqTnRiyEpUtErviqmlC5W
 uzF2IKMCehDkfzezTi2JEpQCO1X6bkXnLY20V+ONtydmgtsdwuBuJubbWc8mYXDE2imt
 MHN5XtA5DwVIqYs3PlSo5TMvsZKFinsJQ4AX3p1oWDS+nstCjW0MSsdr3I3kcMeTkHVB
 nin9Q2bJeSN8aXNe7VRvKMpb9bazpy21i/G6+uVX9Y3VKjWTCAEnEaeQv3WrIJLW03/d
 T/Dw==
X-Gm-Message-State: AOJu0YyTsdfR6FZlIgUMzcM3WHpKovVeuH1z0UuZAtZNSmyacJj8+/WJ
 gZFrmdwbOFxpryVoeozIJnt/cPgxLsXAszFgMmH3LVaLBb4Wqvx2cOVn/Wlh0RnXbnp79b3QjEZ
 3feHqv6vGqXP6e3HownUGAk5eJtjY2Cc=
X-Gm-Gg: AZuq6aJ4onCalDZeoSiRLAlNh86xPmZMHUynf2fuDQrPda6AYN9ZLjTEc7ww8eJMzID
 plKA9ui344JCc3/Q254ZPyfuBRYkqv1DXiPgoUf1yPTUl1RPqyrL65RnwoH7XgjSdLPAhIbYTh4
 WT0UehKUCp96JP7LhU37i6FkpzcQ/BD2Ietw3lMS06nCjryQ3RqCzVPoyhQbb0kUkelJPaxXKID
 zFOb64Lw/xHm4KnU93N/r5aanNWrSrzEnpQhIZi+NvW1AlOkT2whXlBLHeXTPwPNS/rhkdrLuxx
 fYQixfDQ
X-Received: by 2002:a05:7022:699c:b0:119:e56b:46b6 with SMTP id
 a92af1059eb24-1272489a391mr764503c88.0.1770765625861; Tue, 10 Feb 2026
 15:20:25 -0800 (PST)
MIME-Version: 1.0
References: <20260210221555.1309-1-ekurzinger@gmail.com>
In-Reply-To: <20260210221555.1309-1-ekurzinger@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 10 Feb 2026 18:20:13 -0500
X-Gm-Features: AZwV_QiQ3vwt9YCX9qgxeAhP8w6zSnKI1eMyVJpR_YkobFXRCnl6QIn2R0pDWVU
Message-ID: <CADnq5_Nf4-tZCo7D1-i-V1utyoED1AEZbrvo=caE3fwFLeo3CQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/display: remove duplicate format modifier
To: Erik Kurzinger <ekurzinger@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, harry.wentland@amd.com, sunpeng.li@amd.com, 
 alexander.deucher@amd.com, christian.koenig@amd.com
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

On Tue, Feb 10, 2026 at 5:16=E2=80=AFPM Erik Kurzinger <ekurzinger@gmail.co=
m> wrote:
>
> amdgpu_dm_plane_get_plane_modifiers always adds DRM_FORMAT_MOD_LINEAR to
> the list of modifiers. However, with gfx12,
> amdgpu_dm_plane_add_gfx12_modifiers also adds that modifier to the list.
> So we end up with two copies. Most apps just ignore this but some
> (Weston) don't like it.
>
> As a fix, we change amdgpu_dm_plane_add_gfx12_modifiers to not add
> DRM_FORMAT_MOD_LINEAR to the list, matching the behavior of analogous
> functions for other chips.
>
> Signed-off-by: Erik Kurzinger <ekurzinger@gmail.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index d3e62f511c8f..a0a7c3b5ee03 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -704,21 +704,21 @@ static void amdgpu_dm_plane_add_gfx12_modifiers(str=
uct amdgpu_device *adev,
>         uint8_t max_comp_block[] =3D {2, 1, 0};
>         uint64_t max_comp_block_mod[ARRAY_SIZE(max_comp_block)] =3D {0};
>         uint8_t i =3D 0, j =3D 0;
> -       uint64_t gfx12_modifiers[] =3D {mod_256k, mod_64k, mod_4k, mod_25=
6b, DRM_FORMAT_MOD_LINEAR};
> +       /* Note, linear (no DCC) gets added to the modifier list for all =
chips by the caller. */
> +       uint64_t gfx12_modifiers[] =3D {mod_256k, mod_64k, mod_4k, mod_25=
6b};
>
>         for (i =3D 0; i < ARRAY_SIZE(max_comp_block); i++)
>                 max_comp_block_mod[i] =3D AMD_FMT_MOD_SET(DCC_MAX_COMPRES=
SED_BLOCK, max_comp_block[i]);
>
>         /* With DCC: Best choice should be kept first. Hence, add all 256=
k modifiers of different
>          * max compressed blocks first and then move on to the next small=
er sized layouts.
> -        * Do not add the linear modifier here, and hence the condition o=
f size-1 for the loop
>          */
> -       for (j =3D 0; j < ARRAY_SIZE(gfx12_modifiers) - 1; j++)
> +       for (j =3D 0; j < ARRAY_SIZE(gfx12_modifiers); j++)
>                 for (i =3D 0; i < ARRAY_SIZE(max_comp_block); i++)
>                         amdgpu_dm_plane_add_modifier(mods, size, capacity=
,
>                                                      ver | dcc | max_comp=
_block_mod[i] | gfx12_modifiers[j]);
>
> -       /* Without DCC. Add all modifiers including linear at the end */
> +       /* Without DCC. */
>         for (i =3D 0; i < ARRAY_SIZE(gfx12_modifiers); i++)
>                 amdgpu_dm_plane_add_modifier(mods, size, capacity, gfx12_=
modifiers[i]);
>
> --
> 2.53.0
>
