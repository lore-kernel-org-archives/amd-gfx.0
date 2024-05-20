Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2174C04FFE
	for <amd-gfx@archiver.kernel.org>; Mon, 20 May 2024 11:00:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A02D10E408;
	Mon, 20 May 2024 11:00:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ngKplQJy";
	dkim-atps=neutral
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com
 [209.85.167.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B36F10E43C
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 May 2024 11:00:44 +0000 (UTC)
Received: by mail-lf1-f50.google.com with SMTP id
 2adb3069b0e04-51ffff16400so6604170e87.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 May 2024 04:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716202843; x=1716807643; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zbU3zeRUyfJhQipGYR6FKYCuEp6+mBicTADebou1jyQ=;
 b=ngKplQJyJUQv5czDr1HI3bGAP4G3rIGuii+iugwIElteTfe3/cI9N6VXtkLVytc2ye
 F3HWc2yvqiIiILLyYisnMIbXvIGpUG2LqZzIykxaSNPSx0KnYitaaJ9sOAt0VpGEtGh2
 YcWPyzrsBV0rvv1+4+81LYw0oDTPz26AU7sj7zTKeDlz/hOb+qIWwkCjKDD7W568+Exr
 jGbf3UAsk8FYVPqIOirb/h5SlOVCfcbQF89cqGDuCSrFPFfr2Tw4INLD7/N5bgUXQVBw
 JAPvyUvC5Sv3V/kjQJzCTKMg+PQdYtD2bHNGDVudODS0FaWwU5n9QJJWi5jPrROSfJew
 9WoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716202843; x=1716807643;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zbU3zeRUyfJhQipGYR6FKYCuEp6+mBicTADebou1jyQ=;
 b=IInCWwlYc57r92E9hopTbjKthi89WyAPVH10LExC9Y1+FulTyXLKSeA8uKSfL1kyVP
 N+nMyFpuAIMrPbzScbKpw4KQKjPHciDLeza+5IJL4TYndnIi8wg34pxUlYcN7k4gUpn5
 +xEjT0RIvFDterZbJh8UEWou0RptU0a4Pc+tLSxiy98zbVQKY6NEWA7MTNLfFE0fM7E8
 D/LC0fX36BIwtEElazFXmu9lPeYodqmavYbD5Hvrk2gvSa2aYtIpPvFYf2uRkOU4Avxo
 B/RIPOb5mm0tA9kCIWlRTItu6pflfqJVjtnBRhuOt66VOY5GYMcVUe8L0K2AL5XCHojw
 7XSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4MQyxglnnBIKQwPNA8M9KRRAEkFTb8cdbbkE5phqi1PtTC9UrIuH0CxMweJmK1xeytzvhcwrKXX7Htu8sHMws2Tijqot0WHnfWX8hhA==
X-Gm-Message-State: AOJu0YyXwozaP0d5JfXqfWBAjW74OoL+u6LRnVZAR443uaj+P2SfycYk
 fdblTOzRSGcEYaevmC4ZRcKYveLCcVuRGaCCCC6mRvtT110akKlkNiKIKxffRZk=
X-Google-Smtp-Source: AGHT+IEoP2+bL0oMFj4P0Aa7CMuek/Wx23WK1fJZHUBxVQUK6n4Or8upEK0eOTuockV49z8ZJoyWZA==
X-Received: by 2002:ac2:504c:0:b0:51a:df97:cc8d with SMTP id
 2adb3069b0e04-5220fd7cc70mr18338046e87.26.1716202842997; 
 Mon, 20 May 2024 04:00:42 -0700 (PDT)
Received: from eriador.lumag.spb.ru
 (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-521f35ad5fdsm4253446e87.24.2024.05.20.04.00.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 May 2024 04:00:42 -0700 (PDT)
Date: Mon, 20 May 2024 14:00:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
 helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch,
 robdclark@gmail.com, 
 david.heidelberg@collabora.com, guilherme.gallo@collabora.com,
 sergi.blanch.torne@collabora.com, 
 mcanal@igalia.com, linux-mediatek@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, 
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] drm/ci: generate testlist from build
Message-ID: <o363vir3dqz2znrnifo6enbdwudalmxqbigdkci2ykxf5qjbnx@2ngllflxotgk>
References: <20240517092502.647420-1-vignesh.raman@collabora.com>
 <20240517092502.647420-3-vignesh.raman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517092502.647420-3-vignesh.raman@collabora.com>
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

On Fri, May 17, 2024 at 02:54:58PM +0530, Vignesh Raman wrote:
> Stop vendoring the testlist into the kernel. Instead, use the
> testlist from the IGT build to ensure we do not miss renamed
> or newly added tests.
> 
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
> 
> v2:
>   - Fix testlist generation for arm and arm64 builds.
> 
> ---
>  drivers/gpu/drm/ci/build-igt.sh  |   34 +
>  drivers/gpu/drm/ci/igt_runner.sh |    9 +-
>  drivers/gpu/drm/ci/testlist.txt  | 2761 ------------------------------
>  3 files changed, 39 insertions(+), 2765 deletions(-)
>  delete mode 100644 drivers/gpu/drm/ci/testlist.txt
> 
> diff --git a/drivers/gpu/drm/ci/build-igt.sh b/drivers/gpu/drm/ci/build-igt.sh
> index 7859554756c4..e62244728613 100644
> --- a/drivers/gpu/drm/ci/build-igt.sh
> +++ b/drivers/gpu/drm/ci/build-igt.sh

[...]

> @@ -26,6 +50,16 @@ meson build $MESON_OPTIONS $EXTRA_MESON_ARGS
>  ninja -C build -j${FDO_CI_CONCURRENT:-4} || ninja -C build -j 1
>  ninja -C build install
>  
> +if [[ "$KERNEL_ARCH" = "arm64" ]]; then
> +    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/igt/lib/aarch64-linux-gnu
> +elif [[ "$KERNEL_ARCH" = "arm" ]]; then
> +    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/igt/lib
> +else
> +    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/igt/lib64

Could you please clarify this part? The arm64 vs arm don't look logical
from my point of view.

The rest LGTM.

> +fi
> +
> +generate_testlist
> +
>  mkdir -p artifacts/
>  tar -cf artifacts/igt.tar /igt
>  
-- 
With best wishes
Dmitry
