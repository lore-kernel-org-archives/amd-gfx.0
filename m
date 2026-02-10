Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D603DEB2700
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 21:54:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AD2F10E5FB;
	Tue, 10 Feb 2026 21:54:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aEL04N3E";
	dkim-atps=neutral
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8446410E5FB
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 21:54:33 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-c5513f598c0so2202563a12.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 13:54:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770760473; cv=none;
 d=google.com; s=arc-20240605;
 b=jG3+h/tVaCF/pY2ed921JmlINixfXfCeCJ7RlfztiwqGm3M3G/OLMkRg6jl+QXIRDR
 uqtmNwsrTHf/Aa7H3pIOCpB40cOI13S8GzJpT4h8scobwukz0jtenH6JSrItaQmLoyIm
 f2vmbtfiLLqyvLEBNGbUhusK3OFGJUl/It6FrcyIjKonl51CuVa95467mzuYbkao4hD2
 8ajOtXXEHtMz0vr6e+eE70jUhcvtM/kq6w4zA4KSnZR5xBfs+fzWArhgXoZLod7A/0km
 UDUIqYZcLRbI8C/0GexLyjsQhzlK3QnewFYnr4TnIhLLcivuwGARv9WZcQjdrINVFZEE
 79Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tfY6VUjwexwTbdkOfeQgPF06j+EmCMqhkC8o9SmpWL4=;
 fh=oacQrf9WQh5fETomg4YFB/w28gRRuagFT/VU2u8RH3s=;
 b=lhVlUFIK/88Gjd0ROAY8i6m1EEgEkmzuCAnZv2fgkGFDu3rEGvi4nOhYMvwwlpdvTO
 zZAptHmnvGZilUVQkbDeaF9uOKPdzCFVMHjEydjWYAx7nyZAQ6LebInemANdvUIV7SQS
 9asmoO/lGX/oZ9JQpNR1p/Zvobw4aAHRbeh1Yz8UY3gTq37XwKtCWOHJS4IYAYUsEFYK
 tLUS/55p3sOMczEs+12pMEs8eg8PUCdKdYKjLGHzv3NzT7h/bACxAyOk0pylTSfkvf+P
 qljwAcewvXf+B55642SVqQD4NhL+PTLZSKVAlcVFSmcUxFxyf8yvB/0tzWPrebvGkdG2
 i57g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770760473; x=1771365273; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tfY6VUjwexwTbdkOfeQgPF06j+EmCMqhkC8o9SmpWL4=;
 b=aEL04N3EVDDsIuVu1ZKwlBsknpGhZguAUFYDmDG1IdL7GF5L4DYJgfDpF9wdC5pnBw
 2xghQW5lEc6k2R1slzXEH7rWacVTO5TKle4jIFFY0VtDAEb1yBsdYfyfTHH7t22SyC8m
 LgK35vVPrOOasSb8x3od0PYyvDWZGvsyN9PDy8KOv8d8jb5hHZg99zcyOeze9BlPX7zC
 H9TdZFiNnL/SufNVvq1EiLr2b6fknEyLpHieNlSR2X+cHDvZzmuOgvBvwF665yu87tSu
 D1S5g/1d+3z5+LoHD1lwGGe6gQGmi0g4kF7ysItVckgvI+34gbkzRi4qG+DMh6ov62nZ
 mCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770760473; x=1771365273;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tfY6VUjwexwTbdkOfeQgPF06j+EmCMqhkC8o9SmpWL4=;
 b=XZu5mCPD68ZmmIWyRn2t5yRo5CY4v8gROCJZRTiv4BQpZ2MBxFvel1gxUExbdGv9Lp
 zRbVR90aD6vEg79AfoRLnPGV/YK4dGx6vA5/RVR1jNkemSiJQ26zdPS71goWeuwUXnJj
 0Ce5wQwEsDxk60oadPdTXHU9Tc8OaWvSSFo/+zVbFB6mlIY6B+0h2VftVhMPBmQfpY25
 3sPFoYfJI/FpZP6rDw37hsIFDyvQC1Zc+pcwAV0P4DCRXH2ZoF5xR27F3Dk21tVlnoNq
 fyTMxZgJV1BuMlfamuftTYo9kPXw3yW98Z/Lz6+yinexoZAp9U4ZUB6nd9Gz/GtuY6Yo
 RnXw==
X-Gm-Message-State: AOJu0YzrthLAC9KNjFvBqCdUH7hukp3noGFCQGQkdhAJ5GlB8PRuJUvO
 pt0AaeqOgMkheggFiaqPg//++sEUswwZLbsNzbXccFyFYfO+TDW25UVVAOchbhdmM8zfm3AVjIm
 QAf9vkEHM23OV1ZmE6ZfZMIeh+xsH0Gs=
X-Gm-Gg: AZuq6aLvHYhoPjjzILv92Ja68lbdlT/2p1BB87AgbDt5GPQ56t1kWCW1k3CmenpV7ez
 VY1dCDhSNLsqmcfFYjixYRSC8s9lKQJ496+1zjDZ4CBoJ7/+h1GYGFSXW3ja26XPmC6jDj/3vvx
 z+OGVeE3Gs4gbjrLAULqhd2a42zmZkRb+AwVJI07mQ4n836UICqqfMrm1XZERJR3FMTF6H+hl/o
 +rXTfFg0e3ll9aVqqmji+KM0UUQU4QNZjcOaPwdvSbp2Mym9SjdeCvP/WjKmPa9uCA/PmDHp+fR
 qliZKOvr5Q==
X-Received: by 2002:a17:90b:3eca:b0:354:a439:d9e0 with SMTP id
 98e67ed59e1d1-354b3d095d6mr12748160a91.36.1770760472886; Tue, 10 Feb 2026
 13:54:32 -0800 (PST)
MIME-Version: 1.0
References: <20260210203600.9035-1-ekurzinger@gmail.com>
 <CADnq5_OPq09r1FUcFBtJY-wHhOcZkjWq6TnrKUvV1uhr4RkxnA@mail.gmail.com>
In-Reply-To: <CADnq5_OPq09r1FUcFBtJY-wHhOcZkjWq6TnrKUvV1uhr4RkxnA@mail.gmail.com>
From: Erik Kurzinger <ekurzinger@gmail.com>
Date: Tue, 10 Feb 2026 16:54:21 -0500
X-Gm-Features: AZwV_QjqqH2sx8jRBVLebF7bNhh5GWL97e5clzvX88RB5y_9MKJni-gEhqT8OVA
Message-ID: <CAMPXRiu311UCuS_+fSVSkU746r4TFKTQZtcP7VCvnBfeEVa1qw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove duplicate format modifier
To: Alex Deucher <alexdeucher@gmail.com>
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

On Tue, Feb 10, 2026 at 3:57=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Tue, Feb 10, 2026 at 3:36=E2=80=AFPM Erik Kurzinger <ekurzinger@gmail.=
com> wrote:
> >
> > amdgpu_dm_plane_get_plane_modifiers always adds DRM_FORMAT_MOD_LINEAR t=
o
> > the list of modifiers. However, with gfx12,
> > amdgpu_dm_plane_add_gfx12_modifiers also adds that modifier to the list=
.
> > So we end up with two copies. Most apps just ignore this but some (like
> > Weston) don't like it.
> >
> > As a fix, we modify amdgpu_dm_plane_add_gfx12_modifiers to not add
> > DRM_FORMAT_MOD_LINEAR to the list, matching the behavior of similar
> > functions for other chips.
> >
> > Signed-off-by: Erik Kurzinger <ekurzinger@gmail.com>
>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>

Whoops, sorry, I've realized this is not correct. The logic later in the
function assumes linear will be at the end of the array. I'll send a
revised patch shortly.

> > ---
> >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/=
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> > index d3e62f511c8f..12bd0c908d09 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> > @@ -704,7 +704,7 @@ static void amdgpu_dm_plane_add_gfx12_modifiers(str=
uct amdgpu_device *adev,
> >         uint8_t max_comp_block[] =3D {2, 1, 0};
> >         uint64_t max_comp_block_mod[ARRAY_SIZE(max_comp_block)] =3D {0}=
;
> >         uint8_t i =3D 0, j =3D 0;
> > -       uint64_t gfx12_modifiers[] =3D {mod_256k, mod_64k, mod_4k, mod_=
256b, DRM_FORMAT_MOD_LINEAR};
> > +       uint64_t gfx12_modifiers[] =3D {mod_256k, mod_64k, mod_4k, mod_=
256b};
> >
> >         for (i =3D 0; i < ARRAY_SIZE(max_comp_block); i++)
> >                 max_comp_block_mod[i] =3D AMD_FMT_MOD_SET(DCC_MAX_COMPR=
ESSED_BLOCK, max_comp_block[i]);
> > --
> > 2.53.0
> >
