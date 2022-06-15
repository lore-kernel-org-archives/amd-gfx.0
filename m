Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A42CCA495
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jun 2022 16:13:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 885811125BC;
	Wed, 15 Jun 2022 16:13:16 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AED7B1125BC
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jun 2022 16:13:15 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id 25so16864335edw.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jun 2022 09:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :references:from:in-reply-to:content-transfer-encoding;
 bh=XBQA+8lmXAjQFAadxPxi4KEaAVzgK4Z2i7oHYJvKXic=;
 b=PvcjSUhJRSeI+/e3lUl+VfjH3eX72bdAqBchoSaI4McvuI0coNSyHAATuLe5/a/8Fr
 yo7hz1bIozwE3roqqzWABnXIDJZKwPz/T7BQoCJ1NkedUcTNQ24pyhcWVYpkT1LJEgy3
 3FcrdGRwcs/SoXLEbxmcu6ZUhjH8x1qSQH1lvNy3FNsmHyVJqQplBeG6Zqz4vSd1M/fU
 AgRMoZpgrNvkW+afItayblKSJQbTn2a7E5ozURzJCI0eRQeqPwBuCwTNjoEmQzd4XEDC
 K/DFpvH9vcgYoUL3dw27kWe9h4eBR+ds1HkRWWW6BwmFKzCHZcLPOB+GplYAHxRMmm5T
 ZzZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=XBQA+8lmXAjQFAadxPxi4KEaAVzgK4Z2i7oHYJvKXic=;
 b=wQE8o9hm9OWko0wVRDGp8HZdir88tRVAEkgkdoGaNxkfwlnOhCde8AnQEwWNGXQqqi
 GE4zHtkiG6+XapAWl83svR6xtRBoVdGEtsWa/2j4sw9wnYDWkzopYfae8y2yrLHvlsms
 KhejM+U1OmLnexIuPZvKeZz659oVpUwm/J8xF6m9GsoBnoqy1YnQAStdtosTyttIFQXR
 MBiqXTEXEcfE9oblKZ9ymtEgikLDLteAoidYsT9LS4aN2FX1yHOzU3gzjZz26rgDcOHX
 WaCVssRWEFfYrQieGA8Gl1MfXsVGGAa+/L6p7J4vhEu1Vs4qCe5Tn1Q/RnIuZ6eWmxNB
 A+ug==
X-Gm-Message-State: AJIora8idi3Qr4j1CdwdT3j9yT/6DX/uPob6JMDLQLSZvS6gk3Kmuc0q
 Uo/2S67vDPusMb6IT9mgjzXpOES+fCc=
X-Google-Smtp-Source: AGRyM1vxaGDyB7hhDeNz1he6frCdK5dj6NnSAjzVeqQOLpQpYIk6jmEmgpGsqz5PbAab1FcrJlnbrg==
X-Received: by 2002:a05:6402:4248:b0:431:1133:aecb with SMTP id
 g8-20020a056402424800b004311133aecbmr632720edb.222.1655309594174; 
 Wed, 15 Jun 2022 09:13:14 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:baf7:baba:975a:5c1f?
 ([2a02:908:1256:79a0:baf7:baba:975a:5c1f])
 by smtp.gmail.com with ESMTPSA id
 f22-20020a0564021e9600b0043173ab6728sm10071354edf.7.2022.06.15.09.13.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jun 2022 09:13:13 -0700 (PDT)
Message-ID: <30c2b6c6-246c-1e9b-25b6-a80dbd1f2e33@gmail.com>
Date: Wed, 15 Jun 2022 18:13:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/radeon: fix incorrrect SPDX-License-Identifiers
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220615161133.3761804-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220615161133.3761804-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Am 15.06.22 um 18:11 schrieb Alex Deucher:
> radeon is MIT.  This were incorrectly changed in
> commit b24413180f56 ("License cleanup: add SPDX GPL-2.0 license identifier to files with no license")
> and
> commit d198b34f3855 (".gitignore: add SPDX License Identifier")
> and:
> commit ec8f24b7faaf ("treewide: Add SPDX license identifier - Makefile/Kconfig")
>
> Fixes: d198b34f3855 (".gitignore: add SPDX License Identifier")
> Fixes: ec8f24b7faaf ("treewide: Add SPDX license identifier - Makefile/Kconfig")
> Fixes: b24413180f56 ("License cleanup: add SPDX GPL-2.0 license identifier to files with no license")
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2053
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/radeon/.gitignore | 2 +-
>   drivers/gpu/drm/radeon/Kconfig    | 2 +-
>   drivers/gpu/drm/radeon/Makefile   | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/.gitignore b/drivers/gpu/drm/radeon/.gitignore
> index 9c1a94153983..d8777383a64a 100644
> --- a/drivers/gpu/drm/radeon/.gitignore
> +++ b/drivers/gpu/drm/radeon/.gitignore
> @@ -1,4 +1,4 @@
> -# SPDX-License-Identifier: GPL-2.0-only
> +# SPDX-License-Identifier: MIT
>   mkregtable
>   *_reg_safe.h
>   
> diff --git a/drivers/gpu/drm/radeon/Kconfig b/drivers/gpu/drm/radeon/Kconfig
> index 6f60f4840cc5..52819e7f1fca 100644
> --- a/drivers/gpu/drm/radeon/Kconfig
> +++ b/drivers/gpu/drm/radeon/Kconfig
> @@ -1,4 +1,4 @@
> -# SPDX-License-Identifier: GPL-2.0-only
> +# SPDX-License-Identifier: MIT
>   config DRM_RADEON_USERPTR
>   	bool "Always enable userptr support"
>   	depends on DRM_RADEON
> diff --git a/drivers/gpu/drm/radeon/Makefile b/drivers/gpu/drm/radeon/Makefile
> index ea5380e24c3c..e3ab3aca1396 100644
> --- a/drivers/gpu/drm/radeon/Makefile
> +++ b/drivers/gpu/drm/radeon/Makefile
> @@ -1,4 +1,4 @@
> -# SPDX-License-Identifier: GPL-2.0
> +# SPDX-License-Identifier: MIT
>   #
>   # Makefile for the drm device driver.  This driver provides support for the
>   # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.

