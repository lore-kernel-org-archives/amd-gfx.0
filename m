Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F6ECA0EE0
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 14:21:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3C4610E73F;
	Wed, 13 Aug 2025 14:21:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OUgxUWUM";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0052F10E74A
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 14:21:23 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-242abc28161so10548915ad.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 07:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755094883; x=1755699683; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qi3i4Anlypi2WoFOkK+KvzrTLI9399vWiLbaCSLsp8c=;
 b=OUgxUWUMELJeTeF5mxsonDU2HxqjcsT01biV3fxsR1gN68eIAQ5wfb7LoV039IB1eX
 UlBRyvaO2SAGH38s30MqCaDfzhwpKyKslpA0L+WbxTJnlAgHPkGIRxApXE+2ldLx0Xk5
 pu0QtwXS7eBrs3rabRYHGnt6K1fk5eytwIONAzQoXoBbQdpGPQw4RKUUYd/hYCNb+SQB
 X0SvcUy2xpRenZhuRTC41zoHtzLa86ltypUdRwQG9eImihTa1qsoqnlw6j2rXO0natbA
 1kevwENxUPcYeZaz1Rx5qCsoR3yHuVBw6WKSKcIF0QieDmwQpFmw+D2jDo1zIe0btLy3
 nK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755094883; x=1755699683;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qi3i4Anlypi2WoFOkK+KvzrTLI9399vWiLbaCSLsp8c=;
 b=eu/rcCYag+8YtT/l50LjhHsFsM46S9PpGws+l/Sys9ESMLQ/9F3hFT01/Eh8PGHR3Y
 g24i5eBlxmi0pbdgtrXgb6AEquD9rubaNSqymetAlg32fCmqV0GWuRb61VenBAombLaT
 odQczP00/KGpVfAFM2qWZUxr9exvU2MK7CysBNcgPKmidtMYQQrbjIBoqQ2wCXB6Aesc
 +YnNyTQot8waIvrVFSkO+/5LQqtPCogWhp8zb9xd9mwR1n/1Pbnh/Sk6SWRCVzwkYPL8
 DFXroRjp68k5Yho7enlajFl34GeRkPPQWtkg6zC32zrvwMZ+SnyiyxAfnNbDJc6gApAi
 xAzQ==
X-Gm-Message-State: AOJu0Yy6nvuKesLsNs17i7GIzUWrPlJ3cR/hK14AEifG9jekA1DJC560
 ah+9j6eL5n+y87wPhHf1leTTD5uJplUtrvMHBFM5gmFm49nv8LjSOI5EGKU8gWbrWApFDDptlcW
 vIMkL/5vNLjfcyG5//IhPLqnzXr4mKcQ=
X-Gm-Gg: ASbGnctoYRODiA6OgU/JvsG1qABC4iYTvDOmuuudaB9+pPtmRdkFA+h0DTuaWANN3/J
 7bUg/y8NRuwXiGC6dHqD5NTc95LyfKKT4V0COXSkFTuIATtF5lV9Fbk2rjNiITlpMSYffnPU2Ep
 WHQUF4RPaStFYeftAyF4X+HPIwPVuwV15+Iz+Zr9kcctlQ3hzm10sT8lurq9NtVJZazdc5s4DH6
 6KdTHbiADzEUI1coQ==
X-Google-Smtp-Source: AGHT+IHYTmbQSerA43ApLNP+/BjPjqveNbusEaUpc8zOoe9Z9r+LFMSHaPVNR+NX4drV5NrV8fCqYDcC4z29quU0zE8=
X-Received: by 2002:a17:903:1112:b0:240:33c7:fbf9 with SMTP id
 d9443c01a7336-2430d297958mr22805895ad.11.1755094883416; Wed, 13 Aug 2025
 07:21:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250813004625.111508-1-alexandre.f.demers@gmail.com>
In-Reply-To: <20250813004625.111508-1-alexandre.f.demers@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 13 Aug 2025 10:21:11 -0400
X-Gm-Features: Ac12FXxF0tUJpN4mVlKmMkA8J9AIxwrE-3UimesyLenuTqzL358M26kpCyHS15U
Message-ID: <CADnq5_NOFARkYk1tqj66mTJFfF9pg18o6Vfy_xFFcG410zi34Q@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: fix typos
To: Alexandre Demers <alexandre.f.demers@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
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

Applied.  Thanks!

On Tue, Aug 12, 2025 at 8:46=E2=80=AFPM Alexandre Demers
<alexandre.f.demers@gmail.com> wrote:
>
> Various small typos found around.
>
> Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
> ---
>  drivers/gpu/drm/radeon/radeon_device.c | 4 ++--
>  drivers/gpu/drm/radeon/radeon_test.c   | 4 ++--
>  drivers/gpu/drm/radeon/radeon_vce.c    | 6 +++---
>  3 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/rad=
eon/radeon_device.c
> index 40b49bd4a10b..5328ff18ed61 100644
> --- a/drivers/gpu/drm/radeon/radeon_device.c
> +++ b/drivers/gpu/drm/radeon/radeon_device.c
> @@ -555,7 +555,7 @@ int radeon_wb_init(struct radeon_device *rdev)
>   * cover the whole aperture even if VRAM size is inferior to aperture si=
ze
>   * Novell bug 204882 + along with lots of ubuntu ones
>   *
> - * Note 3: when limiting vram it's safe to overwritte real_vram_size bec=
ause
> + * Note 3: when limiting vram it's safe to overwrite real_vram_size beca=
use
>   * we are not in case where real_vram_size is inferior to mc_vram_size (=
ie
>   * note affected by bogus hw of Novell bug 204882 + along with lots of u=
buntu
>   * ones)
> @@ -563,7 +563,7 @@ int radeon_wb_init(struct radeon_device *rdev)
>   * Note 4: IGP TOM addr should be the same as the aperture addr, we don'=
t
>   * explicitly check for that thought.
>   *
> - * FIXME: when reducing VRAM size align new size on power of 2.
> + * FIXME: when reducing VRAM size, align new size on power of 2.
>   */
>  void radeon_vram_location(struct radeon_device *rdev, struct radeon_mc *=
mc, u64 base)
>  {
> diff --git a/drivers/gpu/drm/radeon/radeon_test.c b/drivers/gpu/drm/radeo=
n/radeon_test.c
> index c9fef9b61ced..818554e60537 100644
> --- a/drivers/gpu/drm/radeon/radeon_test.c
> +++ b/drivers/gpu/drm/radeon/radeon_test.c
> @@ -455,7 +455,7 @@ static void radeon_test_ring_sync2(struct radeon_devi=
ce *rdev,
>
>         r =3D radeon_ring_lock(rdev, ringC, 64);
>         if (r) {
> -               DRM_ERROR("Failed to lock ring B %p\n", ringC);
> +               DRM_ERROR("Failed to lock ring C %p\n", ringC);
>                 goto out_cleanup;
>         }
>         radeon_semaphore_emit_signal(rdev, ringC->idx, semaphore);
> @@ -481,7 +481,7 @@ static void radeon_test_ring_sync2(struct radeon_devi=
ce *rdev,
>
>         r =3D radeon_ring_lock(rdev, ringC, 64);
>         if (r) {
> -               DRM_ERROR("Failed to lock ring B %p\n", ringC);
> +               DRM_ERROR("Failed to lock ring C %p\n", ringC);
>                 goto out_cleanup;
>         }
>         radeon_semaphore_emit_signal(rdev, ringC->idx, semaphore);
> diff --git a/drivers/gpu/drm/radeon/radeon_vce.c b/drivers/gpu/drm/radeon=
/radeon_vce.c
> index 761e8b453e1e..0b9bca3860ba 100644
> --- a/drivers/gpu/drm/radeon/radeon_vce.c
> +++ b/drivers/gpu/drm/radeon/radeon_vce.c
> @@ -86,7 +86,7 @@ int radeon_vce_init(struct radeon_device *rdev)
>
>         r =3D request_firmware(&rdev->vce_fw, fw_name, rdev->dev);
>         if (r) {
> -               dev_err(rdev->dev, "radeon_vce: Can't load firmware \"%s\=
"\n",
> +               dev_err(rdev->dev, "radeon_vce: can't load firmware \"%s\=
"\n",
>                         fw_name);
>                 return r;
>         }
> @@ -126,7 +126,7 @@ int radeon_vce_init(struct radeon_device *rdev)
>
>         rdev->vce.fw_version =3D (start << 24) | (mid << 16) | (end << 8)=
;
>
> -       /* we can only work with this fw version for now */
> +       /* we can only work with these fw versions for now */
>         if ((rdev->vce.fw_version !=3D ((40 << 24) | (2 << 16) | (2 << 8)=
)) &&
>             (rdev->vce.fw_version !=3D ((50 << 24) | (0 << 16) | (1 << 8)=
)) &&
>             (rdev->vce.fw_version !=3D ((50 << 24) | (1 << 16) | (2 << 8)=
)))
> @@ -281,7 +281,7 @@ static void radeon_vce_idle_work_handler(struct work_=
struct *work)
>   *
>   * @rdev: radeon_device pointer
>   *
> - * Make sure VCE is powerd up when we want to use it
> + * Make sure VCE is powered up when we want to use it
>   */
>  void radeon_vce_note_usage(struct radeon_device *rdev)
>  {
> --
> 2.50.1
>
