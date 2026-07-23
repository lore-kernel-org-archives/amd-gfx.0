Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F0EC531D0
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 22:54:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 136D910F24C;
	Thu, 23 Jul 2026 22:54:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="p1g9wNIN";
	dkim-atps=neutral
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com
 [209.85.167.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4F8310F24C
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 22:54:24 +0000 (UTC)
Received: by mail-oi1-f180.google.com with SMTP id
 5614622812f47-4960a66d36dso280075b6e.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 15:54:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784847263; cv=none;
 d=google.com; s=arc-20260327;
 b=pzy06jO6LvxlRgrAJN1dq2HnUIdz4bDp7p2eIiLl2o9pOVS80lQl82GhP4L3Uc54eb
 vaxUYl3ztt3xEZy1dfPFwLRWbIuMzl0IUZYAC5gn9JaCd4fKCrn3aVjS0MeAN6czR6R1
 8wZuyt8ffjAkq/4gyat7R6efEVNJ+1fFIK2xWUM8KkKjJzrQuFTDyEGwT/gqHeOYuTKV
 8CgXMxkA7Ux/1Tw3DVP1cvoU6LitlqQiOl9mNOV3zrAJDZG9/yyUQkBgATdVEOlTl7ww
 Ktt0ugapN2yY7dfztrr/PSCbAwaUOhJ/AUIeEfhTf8o/U8H+melxLSY+PU3wtsLnRNG9
 xtcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=eXY+V2rK9rCsJuNZNyHkN8x5ePMDDKmj1rEQdv2DayA=;
 fh=+fUc5Tu9QqCJRwFOzWVm3mt3NUC3HYnu9pWbNeQBI44=;
 b=LMQD/5Yl8ZxT6oR5RGJM0dxTK0rOrUO9okTWVNS64U9npF/NeqbMCy09h9oO8TU/7Z
 wXtdSRSZaMPEiGVL8Y6AKwdlZk6PjAeK1ES1YGWpkYtv9kD17Z0FsQbW4RyMj4zrW5qI
 rnccoG1F8fC5WVFo+kfNZvq1wwMnO9K87zNeRrHBGXqqdI/ivYOfKsx2nY5Ry7mPhmQl
 s980lZRdutaRd69u6zWjeoNan9Y9NjsGvoka/CGxfl15WTSbzYRry6K2HIAaRKDDjU1d
 1Og9sCCGaKePcQfXU1/xA24HYOzBGK5vnkyzdS/YyLhnoVRVpa7hVuY3r3PLrnqAzcyd
 MOKg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784847263; x=1785452063; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eXY+V2rK9rCsJuNZNyHkN8x5ePMDDKmj1rEQdv2DayA=;
 b=p1g9wNINVEQh5WmRayO49UrsxqCWXQkOh/d89LzkPsdLRp7S8bO2yxGvB8ft2XxaD3
 N7aqJes1glAbHUhvoOrMe+4/FMkSXQstU44bBxSihzQKjBmDGBhjvvpmiG+vlRLrO+oT
 x9LK+XdNMsNB6pJ3qxpfec3qtxol1TE2zPgN0YJzDPNCbxky4vWLNrdTcddp66cz04c4
 +IprpBcM/zm625DWlzH7sduoCMpbnb7+7Fg5c7ILnt1x0nB4t4s5potTJXtVMpJhq/Ts
 OFJgxg4yp3+kCKLPfKDGNCMtkjNbJI6jihREesFbdScIs0KSlpYno35EnbJTRGYVIDDt
 OqGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784847263; x=1785452063;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eXY+V2rK9rCsJuNZNyHkN8x5ePMDDKmj1rEQdv2DayA=;
 b=TiecDDLaSTKlrUxfwCq5aD5uukRZMgePGZ7xGUf1rz4PLN55VUiSwa6uRKSThTVT6S
 IYllND+dbwfN5BIrwOtyM0l3WTWG9KwbstNSR2H8PiBxDJkHbCFR2Ri9qVWKMYVItaJC
 huxoeLdoHSlrPoAkbpyYHszaH3vprzivE9cDfn8JBdgJ0Ji54iLnAV5DSdFqBaDKlCzX
 /AgFZ4Rdaxq77gZx23UJdMsBUQAOOk9CipcB2jQxxAjjKHyNSO4ni5BpOEWQWpgH4cpH
 gOBfCpL6zAcC+fz9tCl3pDjmmQPrwpJpMOAcZUga5kt3JZr7qLptBcS2zc+7VlCZFzpS
 NgFg==
X-Gm-Message-State: AOJu0YzAufw8bzozq85P8q8ysJXJp71tE0Y6r/YBMHVTNXA9P+KtgS/R
 umRePgc5vkO1rq8XmC79uPcAaPDh6he2/2yRT3W+7N7qsE2fdQuVWQnhDCZ8O8muSmdrNHeGaYe
 QbhKZglLhvxWBXzbDbrcL3j1x3jYgKzs=
X-Gm-Gg: AR+sD13D3vG4Q1AGnRWwQa0QF+N2YYgoSwGDw8b8L8tH1oZTWK4xOFF2baS+LzFHm8Y
 lQnScHvHTtQhTxsIyUGEGMIgmmC784coy1dI2gsClnDBk56hLAPm0xVLd6SDmzmPrQsNUDgNGse
 kahsknuq4ZC0jnf5O6EijLieATwZxPNbyJoQvqfavL3YH/JorhBM91sO/qYe2bsxucHBS5YAMMb
 EaN0+SPq65f3sm2Gbn8MQgWlEsp1j8jNdH8WiMAEXp6sUnlPk1gu/UFC4rcCTi8FNe9C6pk60s=
X-Received: by 2002:a05:6808:1824:b0:486:7a1b:5a9a with SMTP id
 5614622812f47-4ab351dca54mr1746150b6e.2.1784847263625; Thu, 23 Jul 2026
 15:54:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260723095431.2831513-1-qiang.yu@amd.com>
In-Reply-To: <20260723095431.2831513-1-qiang.yu@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Thu, 23 Jul 2026 18:53:46 -0400
X-Gm-Features: AUfX_mx_pan_JTHo6eU1s0cDdyI0uaOE75pfSNCe84HzhSajQLnjuofF8jL7JUA
Message-ID: <CAAxE2A6SC=pQ8v1BLNhK_ViUGEs24akL+sB58SmUNM3DmR0TmQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: read TRUNCATE_COORD_MODE on gfx12
To: Qiang Yu <qiang.yu@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Qiang Yu <yuq825@gmail.com>
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

Reviewed-by: Marek Ol=C5=A1=C3=A1k <maraeo@gmail.com>


Marek

On Thu, Jul 23, 2026 at 5:55=E2=80=AFAM Qiang Yu <qiang.yu@amd.com> wrote:
>
> From: Qiang Yu <Qiang.Yu@amd.com>
>
> TA_CNTL2.TRUNCATE_COORD_MODE selects whether texture coordinate
> truncation is D3D9/GL/Vulkan conformant. gfx11 reads it and reports it to
> userspace via AMDGPU_IDS_FLAGS_CONFORMANT_TRUNC_COORD, but gfx12 never
> read it, so the flag was always reported as 0 and userspace fell back to
> the non-conformant path.
>
> Read it in gfx_v12_0_constants_init() like gfx11 does.
>
> Fixes: 52cb80c12e8a ("drm/amdgpu: Add gfx v12_0 ip block support (v6)")
> Signed-off-by: Qiang Yu <Qiang.Yu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_0.c
> index b3887c5262a0..d109fa06e32a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -1827,6 +1827,12 @@ static void gfx_v12_0_constants_init(struct amdgpu=
_device *adev)
>         gfx_v12_0_get_cu_info(adev, &adev->gfx.cu_info);
>         gfx_v12_0_get_tcc_info(adev);
>         adev->gfx.config.pa_sc_tile_steering_override =3D 0;
> +
> +       /* Set whether texture coordinate truncation is conformant. */
> +       tmp =3D RREG32_SOC15(GC, 0, regTA_CNTL2);
> +       adev->gfx.config.ta_cntl2_truncate_coord_mode =3D
> +               REG_GET_FIELD(tmp, TA_CNTL2, TRUNCATE_COORD_MODE);
> +
>         /* Program DB_RING_CONTROL for multiple GFX pipes
>          * Default power up value is 1.
>          * Possible values:
> --
> 2.43.0
>
