Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 478C9E77188
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2025 11:39:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED5BA10E894;
	Fri,  3 Jan 2025 11:39:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PhH0JEO5";
	dkim-atps=neutral
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com
 [209.85.167.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C54E810E880
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jan 2025 11:39:39 +0000 (UTC)
Received: by mail-lf1-f42.google.com with SMTP id
 2adb3069b0e04-5401fb9fa03so11687360e87.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 Jan 2025 03:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735904318; x=1736509118; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/m618hW0R2m1nQFr2zn8iDxB4stTlPC9L/MKkQZd3FA=;
 b=PhH0JEO5mxWELPU/aWhZUtECxDihFkr/nBTjYyZGhfBH8cCsKF8mikg81YDDB/va6z
 E1kQFw/UVYlG+Z1RlW5HLyNJRR/SkHreQtawg/6rv8Nqk8uQjuuiPRuPdDKvE1YZgpq5
 Dfz8FzxMUMs+JbuGK3YZvBjBTqWHW0P2YPxNGna75+QOStUAbHzxM/iymEN3Gh2wrRrk
 fYRyUi3OxJ5G5z0Wvh4Q8fVCtMeBdY5vloPYeipSaQw3NFS6H7F7MNAGmkbbF0QaIbok
 CQwyndz0J9CDzRAH89znoK/uCGNUxJ1kTEZglnSDZSu0AnfAMl3jtJagzxTYZmWubn93
 Laow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735904318; x=1736509118;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/m618hW0R2m1nQFr2zn8iDxB4stTlPC9L/MKkQZd3FA=;
 b=oxF8UzNGX5IBSjGFdRZaKbRotdLRqIxYQHJF1LOTk8eG/zbCorX2q4+NA/9ivtON7f
 GsQ1/TD1MCrlEIWDxp7Q2i345l82zrrCK5jkhDJ2Rn5BWNTjfsz46vKioPMW8kOxLqyx
 sP4N7cch6EO2Z8cRosGGjcOEwkTx8VttCzZqHay5TeEJI+lP8ZvweJSuBPTzoicKvoZc
 FjfbH0DF7QDX5Q0hEuOMRYh4Cmpx3kcJSE1EsOnSDMw+1tthtDTmMKk2XKwWqz5elR0t
 qZRrxhRKAQ74wdUy8Gz9LrZZdu9gfrnSYhi4l801W8FUOrc1Izr6FVrSIb69lrH1Lg8g
 /NoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWofkU903CzaMdr5xd0Ppz7iH5bFBFZuxQFxOH67SlFCF/N0oVycm1571NmfSf0n6pyBPMHcns6@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxPlp1P90lqN5TzWrMzrhJD6D+rYwwjkaqkO4xPSaC7zMpVL2Bb
 k4nRg3FzJDYmqzcIg9intZp8Zd0LPwjG2KS4DAaui1Z/5nQQfPuNwn8PCPCjP/YC8OYHG9GMrXA
 q
X-Gm-Gg: ASbGnctwDOYIfWF7neQzX53kljxgDYzRKu97gb498jW82is2lkTYJZe5lF98wrBEe8f
 0Du6LcR1nrWs6euUQ6avkGWISLaVUlSZ6ClOeK+elJ7WCiAOuYKlTJv0ep4X2AFpfo7Os2dnU+/
 S4Xic3glUb3D1XGzWLKfdB3jq5TE2c+qRpCUr0ZorHVUJ7MfdgbSrFKXBYZk4w88F3/SKdCruG+
 9O5sUJRHHhznh6Pcup9hgKLHL/PK3pSyKhztmaRsCCh6gsAS+wC+AII1ruuNbYj3klty1XDxlIm
 dtJewK0hQ0AVPTSIwrL248bMBKR/bPxBpsVi
X-Google-Smtp-Source: AGHT+IHqyYKM0jK9B76DdsBNsu1ksVUKqjrNzWi2li/1a+VHxpUAgfWN/haMqHCMVuXOoMkqVNCF/Q==
X-Received: by 2002:a2e:bc1b:0:b0:302:215f:94ee with SMTP id
 38308e7fff4ca-30458337550mr161864691fa.4.1735900686412; 
 Fri, 03 Jan 2025 02:38:06 -0800 (PST)
Received: from eriador.lumag.spb.ru
 (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3045b096cafsm45400051fa.123.2025.01.03.02.38.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jan 2025 02:38:05 -0800 (PST)
Date: Fri, 3 Jan 2025 12:38:03 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
 helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch,
 robdclark@gmail.com, 
 guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com, 
 linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, amd-gfx@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, 
 intel-gfx@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/ci: uprev IGT
Message-ID: <gxrc6hqlmjl2pdylvi33wdukxgz6wqbhzgwk4ptyx3i55jshic@uu45kcjailxa>
References: <20241217160655.2371138-1-vignesh.raman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217160655.2371138-1-vignesh.raman@collabora.com>
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

On Tue, Dec 17, 2024 at 09:36:52PM +0530, Vignesh Raman wrote:
> Uprev IGT to the latest version and update expectation files.
> 
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
> 
> v1:
>   - Pipeline link - https://gitlab.freedesktop.org/vigneshraman/linux/-/pipelines/1327810
>     Will update the flake bug report link after v1 is reviewed.
> 
> v2:
>   - Pipeline link - https://gitlab.freedesktop.org/vigneshraman/linux/-/pipelines/1331363
>     Updated flake test bug report links.
> 
> ---
>  drivers/gpu/drm/ci/gitlab-ci.yml              |   2 +-
>  .../gpu/drm/ci/xfails/amdgpu-stoney-fails.txt |   8 +-
>  .../drm/ci/xfails/amdgpu-stoney-flakes.txt    |  21 +-
>  .../gpu/drm/ci/xfails/amdgpu-stoney-skips.txt |   5 +
>  drivers/gpu/drm/ci/xfails/i915-amly-fails.txt |  20 +-
>  .../gpu/drm/ci/xfails/i915-amly-flakes.txt    |  14 +
>  drivers/gpu/drm/ci/xfails/i915-amly-skips.txt |   1 +
>  drivers/gpu/drm/ci/xfails/i915-apl-fails.txt  |   8 +-
>  drivers/gpu/drm/ci/xfails/i915-cml-fails.txt  |  22 +-
>  drivers/gpu/drm/ci/xfails/i915-cml-flakes.txt |   7 +
>  drivers/gpu/drm/ci/xfails/i915-cml-skips.txt  |   1 +
>  drivers/gpu/drm/ci/xfails/i915-glk-fails.txt  |  31 +-
>  drivers/gpu/drm/ci/xfails/i915-glk-flakes.txt |   7 +
>  drivers/gpu/drm/ci/xfails/i915-glk-skips.txt  | 298 ++++++++++
>  drivers/gpu/drm/ci/xfails/i915-jsl-fails.txt  |  18 +-
>  drivers/gpu/drm/ci/xfails/i915-jsl-flakes.txt |  15 +-
>  drivers/gpu/drm/ci/xfails/i915-kbl-skips.txt  | 112 ++++
>  drivers/gpu/drm/ci/xfails/i915-tgl-fails.txt  |  55 +-
>  drivers/gpu/drm/ci/xfails/i915-tgl-skips.txt  |  13 +
>  drivers/gpu/drm/ci/xfails/i915-whl-fails.txt  |  15 +-
>  drivers/gpu/drm/ci/xfails/i915-whl-flakes.txt |   7 +
>  .../drm/ci/xfails/mediatek-mt8173-fails.txt   |   7 +-
>  .../drm/ci/xfails/mediatek-mt8173-flakes.txt  |   7 +
>  .../drm/ci/xfails/mediatek-mt8173-skips.txt   |   5 +
>  .../drm/ci/xfails/mediatek-mt8183-fails.txt   |  12 +-
>  .../drm/ci/xfails/mediatek-mt8183-skips.txt   |   5 +
>  .../gpu/drm/ci/xfails/msm-apq8016-fails.txt   |   3 +
>  .../msm-sc7180-trogdor-kingoftown-fails.txt   |   1 -
>  .../msm-sc7180-trogdor-kingoftown-flakes.txt  |  14 +
>  .../msm-sc7180-trogdor-kingoftown-skips.txt   |   5 +
>  ...sm-sc7180-trogdor-lazor-limozeen-fails.txt |   1 -
>  ...sm-sc7180-trogdor-lazor-limozeen-skips.txt |   5 +
>  .../gpu/drm/ci/xfails/msm-sdm845-fails.txt    |   2 -
>  .../gpu/drm/ci/xfails/msm-sdm845-skips.txt    |   5 +
>  .../drm/ci/xfails/msm-sm8350-hdk-fails.txt    |   5 -
>  .../drm/ci/xfails/rockchip-rk3288-fails.txt   |  26 +-
>  .../drm/ci/xfails/rockchip-rk3399-fails.txt   |  13 +-
>  .../drm/ci/xfails/rockchip-rk3399-flakes.txt  |  56 ++
>  .../drm/ci/xfails/rockchip-rk3399-skips.txt   |   5 +
>  .../drm/ci/xfails/virtio_gpu-none-skips.txt   |   5 +
>  drivers/gpu/drm/ci/xfails/vkms-none-fails.txt |   8 -
>  drivers/gpu/drm/ci/xfails/vkms-none-skips.txt | 543 +++++++++++++++++-
>  42 files changed, 1202 insertions(+), 211 deletions(-)
> 


> diff --git a/drivers/gpu/drm/ci/xfails/msm-apq8016-fails.txt b/drivers/gpu/drm/ci/xfails/msm-apq8016-fails.txt
> index 066d24ee3e08..7752adff05c1 100644
> --- a/drivers/gpu/drm/ci/xfails/msm-apq8016-fails.txt
> +++ b/drivers/gpu/drm/ci/xfails/msm-apq8016-fails.txt
> @@ -1,4 +1,7 @@
>  kms_3d,Fail
> +kms_cursor_legacy@forked-bo,Fail
> +kms_cursor_legacy@forked-move,Fail
> +kms_cursor_legacy@single-bo,Fail
>  kms_cursor_legacy@torture-bo,Fail
>  kms_force_connector_basic@force-edid,Fail
>  kms_hdmi_inject@inject-4k,Fail

Interesting. Though this might by the platform legacy cursor code (it
doesn't use a plane for cursors).

Anyway,

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> # msm

-- 
With best wishes
Dmitry
