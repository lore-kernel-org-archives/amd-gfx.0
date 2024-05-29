Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E2D9C25B75
	for <amd-gfx@archiver.kernel.org>; Wed, 29 May 2024 08:09:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F079710E229;
	Wed, 29 May 2024 08:09:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="y6WY+R+O";
	dkim-atps=neutral
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com
 [209.85.167.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 772F810E476
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 May 2024 08:09:57 +0000 (UTC)
Received: by mail-lf1-f43.google.com with SMTP id
 2adb3069b0e04-52965199234so2003387e87.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 May 2024 01:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716970195; x=1717574995; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=enlxS5GkWub7qfeq6FBQU5uJl3JqVotYfwFdD9Rt9Ng=;
 b=y6WY+R+OOt3nFg/9O5UrjVUUAIA2P2ALNNcFi/HGwuLZLkvI3C45eS+hRmoU1QgeTy
 k5xcMLChJy3qxCUuQZcY0MkPQCaRh2CxAcHuADIxO2DURGB0TzfJOaEwMtLN1IXBLL4A
 xA1d2X13XfN/PbkbkuUO1YBT2yAOAagObkth54gccdFHUF/KrB4BVw3SOm9D5qO9nHXT
 GiM1lyLjiIG+VWRb36wNGrrOA52OVbKgL7VR6nWjdC1D61YwKdoYomC14gUQ3vXgrQk7
 YK2I4UqoMLTFQTPZt0+A4FI2SP88D3R5dFKSR5I0btC5/eABy3yQ3WL4879MYsyuLbu5
 dN2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716970195; x=1717574995;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=enlxS5GkWub7qfeq6FBQU5uJl3JqVotYfwFdD9Rt9Ng=;
 b=Gps8EyKF8LUwzY5i5ZIOWJalfVhlteVL88eu3NiGarCe37pMq2zrklnJxDB+fGkufs
 A0vJRTmZo5A3p8161ytI5IG0IDjVOJ+LzOnLEnKlQ6vCMLiIp9cQqLI3wYQlaOSGOc2e
 WxSADkvP69oZ++M3aKkAfr+TWBZ990q7JHGZOTDe26fd09PFksC/xpPHTx/D8aARARgO
 o2nLsEqQVtq7n+R3sZxVexBvCz1S1fO/ouN52BYrKjRpxy8BoW5IbjeMh0rMwV61nJtw
 qE+Jgf9yHQhqEsr7ZOcELixaNsPnuJaQQ7T32XoJPm//VyyWaddspeGm7Q9zRqDXuwhu
 14/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZy2gugJvzE5tPew2jDofDeaKuWDHAjkMNF2jbBsaZImxlRQS3MUZiR4erqUO5eMrqTDlWgEjNW2k1U5MvJLO2JwjGm8pYWoKe/cwHtA==
X-Gm-Message-State: AOJu0YwB0HsxQOPi1IwoYb8lvdSfi5raGmqMGM4yut+O9kRnyQM35NN/
 9VLHqiIlGDpJuZYpdLtmk2MPtM//MnHBsPHSpB6hwCa8LOF59S2oAg3JPXj/qlE=
X-Google-Smtp-Source: AGHT+IHAAOSe1YF9ohma3qLilcNBhTgUrp5XW+R17Dfxhf/XQBKuTb9CXtbrrq9LBMBwT336LwrXXQ==
X-Received: by 2002:a05:6512:3128:b0:522:33cd:64bd with SMTP id
 2adb3069b0e04-52964aba466mr8988769e87.27.1716970195416; 
 Wed, 29 May 2024 01:09:55 -0700 (PDT)
Received: from eriador.lumag.spb.ru
 (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-529aa049e3csm859093e87.167.2024.05.29.01.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 01:09:55 -0700 (PDT)
Date: Wed, 29 May 2024 11:09:53 +0300
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
Subject: Re: [PATCH v3 4/6] drm/ci: uprev IGT
Message-ID: <bj6mpegmxo6i5o34xyxwiytdaokv2u6p5iu4eoek3ctqimwviy@jbo5aw7gy4ue>
References: <20240529024049.356327-1-vignesh.raman@collabora.com>
 <20240529024049.356327-5-vignesh.raman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529024049.356327-5-vignesh.raman@collabora.com>
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

On Wed, May 29, 2024 at 08:10:47AM +0530, Vignesh Raman wrote:
> test-list.txt and test-list-full.txt are not generated for
> cross-builds and they are required by drm-ci for testing
> arm32 targets. This is fixed in igt-gpu-tools. So uprev
> IGT to include the commit which fixes this issue. Also
> disable building xe driver tests for non-intel platforms.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
> 
> v2:
>   - Split IGT uprev to seperate patch.
> 
> v3:
>   - No changes.
> 
> ---
>  drivers/gpu/drm/ci/build-igt.sh  | 4 ++++
>  drivers/gpu/drm/ci/gitlab-ci.yml | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/ci/build-igt.sh b/drivers/gpu/drm/ci/build-igt.sh
> index b7d2a49a6db3..eddb5f782a5e 100644
> --- a/drivers/gpu/drm/ci/build-igt.sh
> +++ b/drivers/gpu/drm/ci/build-igt.sh
> @@ -45,6 +45,10 @@ MESON_OPTIONS="-Doverlay=disabled                    \
>                 -Dlibunwind=enabled                   \
>                 -Dprefix=/igt"
>  
> +if [[ "$KERNEL_ARCH" = "arm64" ]] || [[ "$KERNEL_ARCH" = "arm" ]]; then
> +    MESON_OPTIONS="$MESON_OPTIONS -Dxe_driver=disabled"
> +fi
> +
>  mkdir -p /igt
>  meson build $MESON_OPTIONS $EXTRA_MESON_ARGS
>  ninja -C build -j${FDO_CI_CONCURRENT:-4} || ninja -C build -j 1
> diff --git a/drivers/gpu/drm/ci/gitlab-ci.yml b/drivers/gpu/drm/ci/gitlab-ci.yml
> index 8f32de63d92e..1b29c3b6406b 100644
> --- a/drivers/gpu/drm/ci/gitlab-ci.yml
> +++ b/drivers/gpu/drm/ci/gitlab-ci.yml
> @@ -5,7 +5,7 @@ variables:
>    UPSTREAM_REPO: git://anongit.freedesktop.org/drm/drm
>    TARGET_BRANCH: drm-next
>  
> -  IGT_VERSION: d2af13d9f5be5ce23d996e4afd3e45990f5ab977
> +  IGT_VERSION: 0df7b9b97f9da0e364f5ee30fe331004b8c86b56

Let's land this, then I'll ask to uprev to
dc2d7fb4f978048b87707ea9ec32da748b01b378, which fixes an issue with the
writeback tests on MSM devices.

>  
>    DEQP_RUNNER_GIT_URL: https://gitlab.freedesktop.org/anholt/deqp-runner.git
>    DEQP_RUNNER_GIT_TAG: v0.15.0
> -- 
> 2.40.1
> 

-- 
With best wishes
Dmitry
