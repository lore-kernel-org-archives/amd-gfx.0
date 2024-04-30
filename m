Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CBA7C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 10:17:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9D0110FBB1;
	Tue, 30 Apr 2024 10:17:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Tf1cRUDY";
	dkim-atps=neutral
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com
 [209.85.208.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E365410FBBF
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 10:17:20 +0000 (UTC)
Received: by mail-lj1-f173.google.com with SMTP id
 38308e7fff4ca-2dd19c29c41so66794981fa.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 03:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714472239; x=1715077039; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vLkLH0SSmvOSmWzdY7vcX+RCH3AFTNGOUA3YHRv8hu4=;
 b=Tf1cRUDYcOXqBJ36EltEHXfT6wM+60kHmcooCsvvZ2jp1Xajxx6xtl7Jr9DH4CqEDu
 lduGDwRNKMsl23M6P0bsI82jFTCMr0hujCeOTyt3kaXWs4JQNC0RSdsgoi3pDH0XseGx
 iqVHc/g27+3isF/JIyiou9GFMNi0hJV7qemtiJPMVu9MHvcdEf0Wi2R910GBy1+3haG5
 M9H1hl2doNixnOJj8QXunvYFs+4F5pAiFRneelkOMy3hgFksD0VTR+MuO3cRH4YArTJO
 W6af5ksv5IDfIBL0mQSjhpqvVqL4uFVsMtejcWYAPVggN1Rml/6C92VNeXwPYhRI3Dgu
 gx6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714472239; x=1715077039;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vLkLH0SSmvOSmWzdY7vcX+RCH3AFTNGOUA3YHRv8hu4=;
 b=a2Z/OM2gl4Lu+84be26k4BUlmQ0LtrWE92sBHoQEOf5pwe7q6IiAqEKrBrDWnN5hNu
 8FpaqwblwSSxqmAuaDc/a8XhvsU5cOt6wuZ7C/14LT7CT+sTgmSNaGgNpXywEDicbfrG
 p3TqB0PeD5eXxZTQ+kWCqY1MgTmO6KyVoExBjlJrywnHd6glr0MNk28/SmQH2fDWlqL+
 fBqnmYn3y8Oxkp77mxZLIFbW21dLA6AyiPKSkVcjPYQl6Hmsh+75AXa+rIOh//SUaGDQ
 1gS981ycB+wOj0kkBnbOaOREYdaxxGhKtW0gHdIz7XtcGAjTbIlEBAwC36Ny7MLjXKKJ
 eW8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJQFPsVjOgClhVCdCvEwX9NCmEy1kjT9QbTQDTEcKhQSB7r2MqAF6RtlN9eDC1vuj/3eIZ1bOkASzIhMBYIYGpsg/BCsPtCupGa+X14Q==
X-Gm-Message-State: AOJu0YxqbCXAGqiGnwB7+I6XcxWlWd7N5f/UzpCOdWyfkodmYTgiU2Cg
 VRS+Wit2bzL4jk80nSV+1tNAawYXfntTHej/YwBfJNd3a3mtphQQIfJ+BSRUT9I=
X-Google-Smtp-Source: AGHT+IHaFm4lzkxq9U1a8iPWUfix49p5Xd5gLpx7H0AEzCvQ84t8kRB/7beeUSB3FIO6fjrXa0k+4A==
X-Received: by 2002:a2e:8e23:0:b0:2e0:e129:7011 with SMTP id
 r3-20020a2e8e23000000b002e0e1297011mr1308756ljk.16.1714472238962; 
 Tue, 30 Apr 2024 03:17:18 -0700 (PDT)
Received: from eriador.lumag.spb.ru
 (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
 by smtp.gmail.com with ESMTPSA id
 f28-20020a2eb5bc000000b002e0e78240a4sm205475ljn.77.2024.04.30.03.17.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 03:17:18 -0700 (PDT)
Date: Tue, 30 Apr 2024 13:17:17 +0300
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
Subject: Re: [PATCH v1 2/5] drm/ci: generate testlist from build
Message-ID: <k7sepoksttro3dgxxtwxfmlxwv5w5zn3aeso7p24mm3n74bo45@kx2dpe2qkqgo>
References: <20240430091121.508099-1-vignesh.raman@collabora.com>
 <20240430091121.508099-3-vignesh.raman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430091121.508099-3-vignesh.raman@collabora.com>
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

On Tue, Apr 30, 2024 at 02:41:18PM +0530, Vignesh Raman wrote:
> Stop vendoring the testlist into the kernel. Instead, use the
> testlist from the IGT build to ensure we do not miss renamed
> or newly added tests.
> 
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
>  drivers/gpu/drm/ci/build-igt.sh  |   23 +
>  drivers/gpu/drm/ci/igt_runner.sh |    9 +-
>  drivers/gpu/drm/ci/testlist.txt  | 2761 ------------------------------
>  3 files changed, 28 insertions(+), 2765 deletions(-)
>  delete mode 100644 drivers/gpu/drm/ci/testlist.txt
> 
> diff --git a/drivers/gpu/drm/ci/build-igt.sh b/drivers/gpu/drm/ci/build-igt.sh
> index 500fa4f5c30a..cedc62baba1e 100644
> --- a/drivers/gpu/drm/ci/build-igt.sh
> +++ b/drivers/gpu/drm/ci/build-igt.sh
> @@ -26,6 +26,29 @@ meson build $MESON_OPTIONS $EXTRA_MESON_ARGS
>  ninja -C build -j${FDO_CI_CONCURRENT:-4} || ninja -C build -j 1
>  ninja -C build install
>  
> +set +ex
> +export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/igt/lib64
> +while read -r line; do
> +    if [ "$line" = "TESTLIST" ] || [ "$line" = "END TESTLIST" ]; then
> +        continue
> +    fi
> +
> +    tests=$(echo "$line" | tr ' ' '\n')
> +
> +    for test in $tests; do
> +        output=$(/igt/libexec/igt-gpu-tools/"$test" --list-subtests)
> +
> +        if [ -z "$output" ]; then
> +            echo "$test"
> +        else
> +            echo "$output" | while read -r subtest; do
> +                echo "$test@$subtest"
> +            done
> +        fi
> +    done
> +done < /igt/libexec/igt-gpu-tools/test-list.txt > /igt/libexec/igt-gpu-tools/testlist.txt
> +set -ex

Is the list in sync between x86 and arm/arm64 IGT builds? Is there a
chance of having a safety net here?

> +
>  mkdir -p artifacts/
>  tar -cf artifacts/igt.tar /igt
>  
> diff --git a/drivers/gpu/drm/ci/igt_runner.sh b/drivers/gpu/drm/ci/igt_runner.sh
> index f1a08b9b146f..20026612a9bd 100755
> --- a/drivers/gpu/drm/ci/igt_runner.sh
> +++ b/drivers/gpu/drm/ci/igt_runner.sh
> @@ -59,25 +59,26 @@ fi
>  
>  curl -L --retry 4 -f --retry-all-errors --retry-delay 60 -s ${FDO_HTTP_CACHE_URI:-}$PIPELINE_ARTIFACTS_BASE/$ARCH/igt.tar.gz | tar --zstd -v -x -C /
>  
> +TESTLIST="/igt/libexec/igt-gpu-tools/testlist.txt"
>  
>  # If the job is parallel at the gitab job level, take the corresponding fraction
>  # of the caselist.
>  if [ -n "$CI_NODE_INDEX" ]; then
> -    sed -ni $CI_NODE_INDEX~$CI_NODE_TOTAL"p" /install/testlist.txt
> +    sed -ni $CI_NODE_INDEX~$CI_NODE_TOTAL"p" $TESTLIST
>  fi
>  
>  # core_getversion checks if the driver is loaded and probed correctly
>  # so run it in all shards
> -if ! grep -q "core_getversion" /install/testlist.txt; then
> +if ! grep -q "core_getversion" $TESTLIST; then
>      # Add the line to the file
> -    echo "core_getversion" >> /install/testlist.txt
> +    echo "core_getversion" >> $TESTLIST
>  fi
>  
>  set +e
>  igt-runner \
>      run \
>      --igt-folder /igt/libexec/igt-gpu-tools \
> -    --caselist /install/testlist.txt \
> +    --caselist $TESTLIST \
>      --output /results \
>      $IGT_SKIPS \
>      $IGT_FLAKES \

-- 
With best wishes
Dmitry
