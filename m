Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA90CD5BA4
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 13:35:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B9BD10E3BA;
	Tue, 19 May 2026 13:35:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j/WTtOFj";
	dkim-atps=neutral
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A92DE10E3BA
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 13:35:25 +0000 (UTC)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-2f0f13b7c1eso170600eec.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 06:35:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779197725; cv=none;
 d=google.com; s=arc-20240605;
 b=gy8nYoZWIg5RXoENMcJVeCHqnVrWKH3a2/2GHbRGCP0Wd/7nh6pSMq46vqoxA4clJ2
 kJqjTDtDDTHX5fWW0Hg7/2fQNYPi9OfGymtgrwoACESSVbSr950Y1lLpNDE0Is3pUINx
 GfJ6yr8+gKwP19VLLCE6rle2+SDFDs2bc+eSa1A3TQHx6AYl12ApvRmJyDzUmI2b2jP7
 OLzyQkgxWEVe7ulHVfyUMuvZLWvG81+h6I/Y0O3zum1uUGbuP4Tj9FK5eQVnQHvQ1+zj
 LJdxJ/cXlW5GHmotAj18xG1WRiwzm/E17agYtphNAFZW4asi4bilFr+yShYYfm1Zhox8
 6o2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=A1Wqw1J35nbDF+/AK/aGPRuuCaRSB6Yh2K/coYPFh3k=;
 fh=M0ymKBTBfQnV7Wims3M/mWOJmavBdbnaSutXWRm9SU4=;
 b=IZuR3NYpe2oVlqq1D5BeQMIft9PSzoQCeUI2XS+uBobwqZyFUTMWUTg0RIQ1ZiIDB0
 VT9TNSfUWxxvT2094RsAZazmY5Xhs37Wa7NLEqQ59lgDBvTSID/4IhV33iof1UM9Ni22
 caM/93YIXovN80Da63IbTAKZrdAQzS5s4vpIse1Y4Vwarpj4vUBqlerlUqj8qvyFhG9S
 WGfw3TKpnbE0uBjO2kaT/WYaFv2UB3ls0XOp4b2aX1c9uji9UIhi1daxZEApvw+Qdw+x
 3Z9HmmeAlaW9Wa6be8nMeQsAk8i+I0jkWhMlxSlRmc1bQiNtKhT9jeg3EnvRwGBzmKVc
 nwdQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779197725; x=1779802525; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A1Wqw1J35nbDF+/AK/aGPRuuCaRSB6Yh2K/coYPFh3k=;
 b=j/WTtOFjMlNKl3FS62xR0IcQ5GJ+6UqTsc4o+7YCTuMUEFgAGgm12J8U/jxBb6S0oz
 gSEmf0pqVF8N0+Ne/gyTnD8rTGoAC6cPF1JMT7AvTZtaotggypT4Np9sYUsxz92S2+Dk
 wOAH90aOmjxJiwkEWR+BQTGJZMnuWHIxsUJVQlo65T+aSPDW/Q6bBbFTfK7WGYAt1ZxH
 EplFitwkg4wjb71k9yCpesP6qxi3qjF8Gpt5m8m70UE5NaaNI/6GOvW7gfvzRFkKo6u9
 MS/wzxJs+IxCOS4DWP7v+nW1ZJ30TCCqJyn5Iscpy0rnjScrke5bf5uUEPqZO30SurOy
 sXyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779197725; x=1779802525;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A1Wqw1J35nbDF+/AK/aGPRuuCaRSB6Yh2K/coYPFh3k=;
 b=bSnKaChmUC0pSw3LJTPbQsajGDgKpVo+uoFA6xPaCOlSiGlfQN8bsF66mauyP4FfYs
 eTPhi29jgVOi4+PiNMtK4ZZ6J3gQifnI1IMTSeKIka7HcRjq8BFG2+DHWrApftvNkDjO
 0/9eg4nbAokjCJz/L8QIBsriYmcueZ8y7QAqWrrp9O513Yv3Y256Ovfru0IK2s/Vvahu
 EF5jTspGVu6t31THvsPgf73VxQDbsCifL/ABK04GZK5eY7E0a7oWXc7A+hmUs/HLWY8F
 vHFAeW2ugl94KmwXkA4B26oymWxipLMvSfWMDSkOmmXkFjbPKYj3/vIXfXDDxxjAbBct
 jCxA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+P7I8jHyc3pPfL1gDhg5koaxNhI46VZVZAIQn+IhRLslbvPJvvgZ35RySbeIkFW8dOsgYIGo4X@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzXRqUKbM2VNO8f+U+3pLNHf64cO4v6CKfwG5Tya0N+whPZZFvs
 +ymSZ3GD3kOfJeFWWzTznRkABFklYYN4QNvQ2jjOQg080ZZOxiqrz2DW0lCjLdtvW/4FVsts+pc
 mYoG5mIkpppLPksJTaIRHyACHaFCbvqI=
X-Gm-Gg: Acq92OGE0OlG2XIc44/6oQEFFwXE4TkmCafaeJmcd7cOUICuwxRt5Y7IB8cfdEnQzg6
 +VYZCekcnNGCqXWpeJUilxQFfJehUKYTKIumbFQDsKQmvm6F9ABPsGmZNBNk7g8c+8kBfehxjqq
 OGelxF1wJJntENIoupm+YP9SrK0CVmxs4EJTZlsBhpvu7divg1W3DdrSiJleqDwpLA2t/ceOEpg
 a67tnB1gTP74YFzH7aW71u08sd2g9Rczm6N3eISWfINVmZ1/WM3p/BTKEBSwMVHBQMslsaSSsnC
 d3wEGhWj1YloU5xLNtnTIMY0vJztU/05Jm5AaM+/hCNzdLfl5njUGe5wecLGCeAJ3FMUjQ==
X-Received: by 2002:a05:7301:6089:b0:2c1:7ca:cec2 with SMTP id
 5a478bee46e88-3039876f398mr4026613eec.8.1779197724728; Tue, 19 May 2026
 06:35:24 -0700 (PDT)
MIME-Version: 1.0
References: <CADnq5_PhXmCNOGz9zK8mz7Y0Jw-J9uexhVjGLRqMA4AOHsJ5TQ@mail.gmail.com>
 <20260518211409.4868-5-gilles.risch@gmail.com>
In-Reply-To: <20260518211409.4868-5-gilles.risch@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 19 May 2026 09:35:13 -0400
X-Gm-Features: AVHnY4IzTKq_zQB4h5SQg76RD5Kl2iayBtjjx9iFm2Qna5e1bD25pJiYB2dHyYE
Message-ID: <CADnq5_NTwvFEN4s6OdOmoNQAMckZwBOs-aoqsREmuK4GbY6KwQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] drm/radeon: fix internal display on iMac11,
 1 (RV770/DCE3.1)
To: Gilles Risch <gilles.risch@gmail.com>
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, lkp@intel.com
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

On Tue, May 19, 2026 at 3:19=E2=80=AFAM Gilles Risch <gilles.risch@gmail.co=
m> wrote:
>
> The Apple iMac11,1 (late 2009) has an integrated ATI Mobility Radeon
> HD 4850 (RV770/M98L) with a 2560x1440 internal panel connected via an
> internal DisplayPort path. This machine suffers from a similar problem
> as the iMac10,1 (late 2009) and the iMac11,2 (mid 2010). Without this
> fix the display stays dark under KMS. Two issues are addressed:
>
> 1. The RV770 implements DCE3.1 and not DCE3.2. ASIC_IS_DCE32() starts at
>    CHIP_RV730 which is newer than RV770, so the RV770 never matched the
>    DCE3.2 PLL and encoder logic. Introduce ASIC_IS_DCE31() starting at
>    CHIP_RV770 to fix this.
>
> 2. Apple routed the internal display through Link B of the DIG encoder
>    instead of Link A, as observed in the kernel display connector log.
>    The same quirk already exists for iMac10,1 and iMac11,2 - iMac11,1
>    was simply missing from the list.
>
> Note: resume from suspend still results in a dark screen as the DP
> re-driver chips on the mainboard lose their state during power-off.
> This will be addressed in a follow-up patch.
>
> Fixes freedesktop issue 164
> Link: https://gitlab.freedesktop.org/xorg/driver/xf86-video-ati/-/issues/=
164
>
> Signed-off-by: Gilles Risch <gilles.risch@gmail.com>
> ---
> v3: No code changes.
>
>  drivers/gpu/drm/radeon/atombios_crtc.c     | 4 ++--
>  drivers/gpu/drm/radeon/atombios_encoders.c | 9 +++++----
>  drivers/gpu/drm/radeon/radeon.h            | 1 +
>  3 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/atombios_crtc.c b/drivers/gpu/drm/rad=
eon/atombios_crtc.c
> index 2fc0334e0d6c..3c6d332739e3 100644
> --- a/drivers/gpu/drm/radeon/atombios_crtc.c
> +++ b/drivers/gpu/drm/radeon/atombios_crtc.c
> @@ -580,7 +580,7 @@ static u32 atombios_adjust_pll(struct drm_crtc *crtc,
>                         radeon_crtc->pll_flags |=3D (/*RADEON_PLL_USE_FRA=
C_FB_DIV |*/
>                                 RADEON_PLL_PREFER_CLOSEST_LOWER);
>
> -               if (ASIC_IS_DCE32(rdev) && mode->clock > 200000)        /=
* range limits??? */
> +               if (ASIC_IS_DCE31(rdev) && mode->clock > 200000)        /=
* range limits??? */
>                         radeon_crtc->pll_flags |=3D RADEON_PLL_PREFER_HIG=
H_FB_DIV;
>                 else
>                         radeon_crtc->pll_flags |=3D RADEON_PLL_PREFER_LOW=
_REF_DIV;
> @@ -594,7 +594,7 @@ static u32 atombios_adjust_pll(struct drm_crtc *crtc,
>                 if (((rdev->family =3D=3D CHIP_RS780) || (rdev->family =
=3D=3D CHIP_RS880))
>                     && !radeon_crtc->ss_enabled)
>                         radeon_crtc->pll_flags |=3D RADEON_PLL_USE_FRAC_F=
B_DIV;
> -               if (ASIC_IS_DCE32(rdev) && mode->clock > 165000)
> +               if (ASIC_IS_DCE31(rdev) && mode->clock > 165000)

Can you switch these to dmi matches as well?  This change will also
change the behavior for other boards with respect to the PLL
calculations which are often pretty sensitive and may cause
regressions.

Alex

>                         radeon_crtc->pll_flags |=3D RADEON_PLL_USE_FRAC_F=
B_DIV;
>         } else {
>                 radeon_crtc->pll_flags |=3D RADEON_PLL_LEGACY;
> diff --git a/drivers/gpu/drm/radeon/atombios_encoders.c b/drivers/gpu/drm=
/radeon/atombios_encoders.c
> index 5cfd8fcfa5e8..4e984973c043 100644
> --- a/drivers/gpu/drm/radeon/atombios_encoders.c
> +++ b/drivers/gpu/drm/radeon/atombios_encoders.c
> @@ -2123,12 +2123,13 @@ int radeon_atom_pick_dig_encoder(struct drm_encod=
er *encoder, int fe_idx)
>         }
>
>         /*
> -        * On DCE32 any encoder can drive any block so usually just use c=
rtc id,
> -        * but Apple thinks different at least on iMac10,1 and iMac11,2, =
so there use linkb,
> -        * otherwise the internal eDP panel will stay dark.
> +        * On DCE31 and DCE32 any encoder can drive any block so usually =
just use crtc id,
> +        * but Apple thinks different at least on iMac10,1, iMac11,1 and =
iMac11,2,
> +        * so there use linkb, otherwise the internal eDP panel will stay=
 dark.
>          */
> -       if (ASIC_IS_DCE32(rdev)) {
> +       if (ASIC_IS_DCE31(rdev)) {
>                 if (dmi_match(DMI_PRODUCT_NAME, "iMac10,1") ||
> +                   dmi_match(DMI_PRODUCT_NAME, "iMac11,1") ||
>                     dmi_match(DMI_PRODUCT_NAME, "iMac11,2"))
>                         enc_idx =3D (dig->linkb) ? 1 : 0;
>                 else
> diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/rad=
eon.h
> index 527b9d19d730..6b7c0abe49fb 100644
> --- a/drivers/gpu/drm/radeon/radeon.h
> +++ b/drivers/gpu/drm/radeon/radeon.h
> @@ -2625,6 +2625,7 @@ void r100_pll_errata_after_index(struct radeon_devi=
ce *rdev);
>                             (rdev->family =3D=3D CHIP_RS740)  ||    \
>                             (rdev->family >=3D CHIP_R600))
>  #define ASIC_IS_DCE3(rdev) ((rdev->family >=3D CHIP_RV620))
> +#define ASIC_IS_DCE31(rdev) ((rdev->family >=3D CHIP_RV770))
>  #define ASIC_IS_DCE32(rdev) ((rdev->family >=3D CHIP_RV730))
>  #define ASIC_IS_DCE4(rdev) ((rdev->family >=3D CHIP_CEDAR))
>  #define ASIC_IS_DCE41(rdev) ((rdev->family >=3D CHIP_PALM) && \
> --
> 2.47.3
>
