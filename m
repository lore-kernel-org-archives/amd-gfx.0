Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90499F41998
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2026 12:59:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20B2E10E6D8;
	Wed, 15 Apr 2026 12:59:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aadVevOC";
	dkim-atps=neutral
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BCE910E6D8
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2026 12:59:19 +0000 (UTC)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-12736a0147cso505800c88.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2026 05:59:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776257958; cv=none;
 d=google.com; s=arc-20240605;
 b=U+EvynGnXPZezLXT1L6YpeBHTXVD2NVA+qh4gHq5NvIt9s/0ylyKeXs9i8NXghIrx7
 toyUCVguid3nFpKkaCiYhPVdo5oVB6OPyEMGv7islef4OS1k5nat1HPDbrG1D+z6Mx8t
 HX4wOdVT/PLj6PlV8yVDIpqRaIyCKvyBfzcdqd4gxYLnlsarvuoqXzNiNnL9fOt2WJI4
 iirtzUimE2fpRSAMFBHtzJEUMdiFrWBQxHvCL7sSBuwwdA1ftmzH0tJARGlCXlaV/RME
 m9J9SbiSaC3LW/VRXnK1KtS+i7NtjZ8tdtOYok2YZdulFL+u69e46GaHosWkM3cSMFzw
 DoTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=YbAg75inuAX6qfe171ed5cAQ3ilGhu1WuPU93+xAM3I=;
 fh=R6Fmee1A4nD37QI/kpfDXuHAQy20vjQ77SHPjhidz1c=;
 b=Gv6Bi3ltFVWPt2vCCXY9fXAibUKekqhUMy50DEYafgfRWSx+G9cP3u/9TtDAsYybJ7
 +H4PgtI3X3tmv6moFmB7OTWPkYS+EfAWIMAVOpP6ZF6liteQjCLDDvZvywFeHw2LhniF
 zU3GJeTrkQ1zysKHbxE2cEHCtFJgiusOhGgX3yFVVmZlD2sUMUnsvxwOeiYPecvNqN0U
 B8Io6tncvYhkqNGBm4o70GyMboZEVYF9RYB8SQBbJPGGHqRPsW7qH0UxOmHj99Ok0jHd
 s9PWiALBDfToGRKxMwfOk5LQ9cYZ9AF3rO0RrPOvKSToe3zlm786VLINx7IdhAH60rqQ
 TyXg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776257958; x=1776862758; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YbAg75inuAX6qfe171ed5cAQ3ilGhu1WuPU93+xAM3I=;
 b=aadVevOCeOwdfmbXK7v5CfA4evDlzDcqOZ755Sok2EvmVOFv5OHs5QpYCTS+6cxvpR
 7rNvvTEQwlHNgluAvHjkIJ6vpaVer2KTd13rRoFkZ3SWfUvDySJ1RUeddsTZGxnScsue
 RK/wBwGVoMm6rHujzWuczz/528cZchfFpC3ipIxHAQu2oXCrGHY1PEl5hndpNJjx2dzB
 duzNaGtSqMn512CbQ+tfEkPnEQFEY9dtsfTHwBstzkKU/YlTRFmoAMHsTUGL7+Wi+4ey
 WaLXFYDHJhsnvrCTM0yQZltqGARMyO/Q+YYuA9qNryNTtHjz/yCYLUwbEFroaSofJHf9
 MrgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776257958; x=1776862758;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YbAg75inuAX6qfe171ed5cAQ3ilGhu1WuPU93+xAM3I=;
 b=pbt1ESPnBnbYx4vJZQe6In4ddxwwP15LPUh8YrLXGtx3IqGwsqXWBQFy99JNUW3tIN
 4icXrou/Yl69L2X8Q58P5el4Y2fkgFn5DorkKFIqaY9exmcNuEj/zFIifuazWEYwVBMA
 HktW1vMFeVCVuv2Z6gzaM85IpdWKKbJjJfFJjox9WF3LFtGvuV4t2eRzcnpkAewTbS7m
 qNNZXv1D69fKGtBooZbD/1DGUGeE8XRoidomqh/ipTPjZlzDT/7k72cmV1TTnoZpKbDS
 KseZtUjnJ2M9252nU8b0xEfI9yrU/vvq6ZmV27FOGMw5r0xo1tqy1arihu7ciXzjglR2
 l86w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+dCsDoT3w0O/vJctNno7K8Q02t7PP8apK3D9+xOogVKOSX1D0Ry8EuhFsEvP46tLmianb3Y0Pe@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzkNK/4WCLEvhLW5UPWf49hZg6oQXM5CMXQNHS3a9nFSBOi29+C
 wE/VmZ+KGBEDyrb31aCXw2nsBTuWp1/nRioDX/PiLCgIVTNRWkjQVvOUd80zwKHq3amMwT0sn/X
 2l3sVkCdj26A5psqGmAxXOs6hCm3CYIQ=
X-Gm-Gg: AeBDieuJ9zzOxtBJKQhKF8axG+tplyC9PGhR2nLpnuE9Vx5OZGQhlg+d2BUpEPGbUga
 ZTThVR7bCQeeJxuhxUBTdwWn0QlGBzU9xmWRHrXPx/xgJ8qL0IJEbbmoIhZS9wRQDGngkKbhfoA
 ZkgOU6gzGAgzTsCDIq8qzcF6AgCu0Iomh/zBQ5etz7kKrm/dbQTB0C0AYvUkJ7+eLpH7sen81D/
 sOZ6Bg1p4lqcveCtpuOw24hqRDVCqgdOa7umPVdkitPnOVROdGbJhsO/JOc6gLUwB0iCWy8QdQ7
 akXucyvh9aibd0h3rmdwNI1+LFJIbX2rGs8bzvetVqvlM7iRzecVSxrKZJ2EkJRDxoGZHA==
X-Received: by 2002:a05:7022:618c:b0:127:332d:63e with SMTP id
 a92af1059eb24-12c5d4d0c7dmr506525c88.5.1776257958465; Wed, 15 Apr 2026
 05:59:18 -0700 (PDT)
MIME-Version: 1.0
References: <CADnq5_OVN+uCioTWNeuHkGpkUU-VhEio_uMEBMVur6-hWXwtug@mail.gmail.com>
 <20260414211437.154315-1-werner@verivus.com>
In-Reply-To: <20260414211437.154315-1-werner@verivus.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 15 Apr 2026 08:59:06 -0400
X-Gm-Features: AQROBzAeYix9JIhJ4gNGCdBtQrUS7rMQvoooy6xeRQZh2Q7drV282ZxpZgFSuFU
Message-ID: <CADnq5_Prw=X66ByOAutSV_jFCJ7guuRSMPWnEqttr+xe_j_Y4g@mail.gmail.com>
Subject: Re: [PATCH v2] drm/radeon: fix integer overflow in
 radeon_align_pitch()
To: Werner Kasselman <werner@verivus.ai>
Cc: "alexander.deucher@amd.com" <alexander.deucher@amd.com>, 
 "christian.koenig@amd.com" <christian.koenig@amd.com>,
 "airlied@gmail.com" <airlied@gmail.com>, 
 "simona@ffwll.ch" <simona@ffwll.ch>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "stable@vger.kernel.org" <stable@vger.kernel.org>
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

Can you squash this with the previous radeon patch?  I only applied
the amdgpu patch at this point.

Alex

On Tue, Apr 14, 2026 at 5:14=E2=80=AFPM Werner Kasselman <werner@verivus.ai=
> wrote:
>
> radeon_align_pitch() has the same kind of overflow issue as the old
> amdgpu helper: the alignment round-up add and the final 'aligned * cpp'
> calculation can overflow signed int.
>
> If that wraps to 0, radeon_mode_dumb_create() can end up with an invalid
> pitch value from DRM_IOCTL_MODE_CREATE_DUMB.
>
> Fix this by using check_add_overflow() for the alignment round-up and
> check_mul_overflow() for the final pitch calculation, returning 0 on
> overflow.
>
> Found via AST-based call-graph analysis using sqry.
>
> Fixes: ff72145badb8 ("drm: dumb scanout create/mmap for intel/radeon (v3)=
")
> Cc: stable@vger.kernel.org
> Signed-off-by: Werner Kasselman <werner@verivus.com>
> ---
> v2:
> - Use overflow helpers like amdgpu.
> - Drop the stale zero pitch/size change from the original submission.
> - Fix the changelog wording around reachability.
>
>  drivers/gpu/drm/radeon/radeon_gem.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon=
/radeon_gem.c
> index 2cd179fef347..8ce180e22d1d 100644
> --- a/drivers/gpu/drm/radeon/radeon_gem.c
> +++ b/drivers/gpu/drm/radeon/radeon_gem.c
> @@ -28,6 +28,7 @@
>
>  #include <linux/debugfs.h>
>  #include <linux/iosys-map.h>
> +#include <linux/overflow.h>
>  #include <linux/pci.h>
>
>  #include <drm/drm_device.h>
> @@ -812,6 +813,7 @@ int radeon_align_pitch(struct radeon_device *rdev, in=
t width, int cpp, bool tile
>         int aligned =3D width;
>         int align_large =3D (ASIC_IS_AVIVO(rdev)) || tiled;
>         int pitch_mask =3D 0;
> +       int pitch;
>
>         switch (cpp) {
>         case 1:
> @@ -826,14 +828,12 @@ int radeon_align_pitch(struct radeon_device *rdev, =
int width, int cpp, bool tile
>                 break;
>         }
>
> -       aligned +=3D pitch_mask;
> +       if (check_add_overflow(aligned, pitch_mask, &aligned))
> +               return 0;
>         aligned &=3D ~pitch_mask;
> -
> -       /* Guard against integer overflow in aligned * cpp. */
> -       if (aligned > INT_MAX / (cpp ? cpp : 1) || aligned <=3D 0)
> +       if (check_mul_overflow(aligned, cpp, &pitch))
>                 return 0;
> -
> -       return aligned * cpp;
> +       return pitch;
>  }
>
>  int radeon_mode_dumb_create(struct drm_file *file_priv,
> --
> 2.43.0
