Return-Path: <SRS0=fQkT=AY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1FAC433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 08:38:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 321982065D
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 08:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vcYC9MzS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 321982065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B5636E4AD;
	Mon, 13 Jul 2020 08:38:46 +0000 (UTC)
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com
 [IPv6:2a00:1450:4864:20::641])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07EC96E150
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2020 08:38:43 +0000 (UTC)
Received: by mail-ej1-x641.google.com with SMTP id a1so15570003ejg.12
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2020 01:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=MWSjISawslL5FK02vEoeW/8lkkAu2qJgPjeQ2BLlVfs=;
 b=vcYC9MzSpeN/QQl7HkVNYVA+4qbK/YNiIbKtVnqecZ099z4Lv4lgIy0gte3LchbENl
 WDcCismlCQsKf/8wq11fSH7wUZOTMAFdmlPZtwi6ubJY9Ny0RzcRTDutb13kP9NPtqLl
 TD3EXNhZ40VbGmmShsgY9YKAv+sJ0T3NTplCyu8kDGUZZdTZjpqnPImrLlwvX4qZ9LwC
 /m0h5DWb5jUJ9BNSmS4/byZ0+ra79x17YS0btLrNqOfjxeOsRvKDdCBvuTpEYgGL17AN
 AFhPVH/SuUR9aclQnAGZD1D8X7T6atk2Wb/uDHfDyEL9jpgCxM8Xzd7hJf68lj03LFwe
 kN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=MWSjISawslL5FK02vEoeW/8lkkAu2qJgPjeQ2BLlVfs=;
 b=kwD127P7baXeFoeMKWW8z82WlUXfBDKqp25XjxccyF8RnCniuZyL35XyRmz97M7ZUm
 qGbJnsfEKNn0P5N4vKPxpZDeIwaZtHfatG4RG3PP/UbO0y6jEKXlKw3KGj8yTGqtxGes
 paI46jtHHS2XSrGHTeEq1j39frAg+drHt5hnr2RVM7XGzlaF07/6YjjGo2NHNuVv58YW
 sX8CefnIkBIjpIKevJSr9dQjX3R59r6Gdv09h24Vos2uXT8bB/HDp9iBCTgHP+12sKww
 E5SsfQ74ztdsJJqlIUP87dtN/9hqLGVX870f7xupMh6PPfNk0ot6xc2MV5FP1qOqUehb
 jRng==
X-Gm-Message-State: AOAM530bLFDVncL9AKqR4n3ua8fhj5WfVY0ehVM2En+6Cb6jfDNB+/xj
 Ibdu8AC5BSg2yYZIp60Rndms4RQO
X-Google-Smtp-Source: ABdhPJx925dMxO1mlext7JkUPoUsPuzrdXSrMbgaDdsN+Xc/bfwDeRoBdedXJnDsUSggeBaASnl1kg==
X-Received: by 2002:a17:906:4a87:: with SMTP id
 x7mr75049163eju.44.1594629522288; 
 Mon, 13 Jul 2020 01:38:42 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id v9sm4847777ejd.102.2020.07.13.01.38.41
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 13 Jul 2020 01:38:41 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: use ARRAY_SIZE() to add amdgpu debugfs files
To: Xiaojie Yuan <xiaojie.yuan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200713055950.19611-1-xiaojie.yuan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <59e9b843-ee3f-2b70-f9eb-f96289be3a9a@gmail.com>
Date: Mon, 13 Jul 2020 10:38:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200713055950.19611-1-xiaojie.yuan@amd.com>
Content-Language: en-US
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
Reply-To: christian.koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 13.07.20 um 07:59 schrieb Xiaojie Yuan:
> to easily add new debugfs file w/o changing the hardcoded list count.

In general a good idea, but I would rather like to see 
amdgpu_debugfs_add_files() completely removed and debugfs_create_file() 
used directly instead.

Christian.

>
> Signed-off-by: Xiaojie Yuan <xiaojie.yuan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 6 ++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c   | 3 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    | 3 ++-
>   3 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index b8ce43c28116..58d4c219178a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -781,8 +781,10 @@ int amdgpu_debugfs_fence_init(struct amdgpu_device *adev)
>   {
>   #if defined(CONFIG_DEBUG_FS)
>   	if (amdgpu_sriov_vf(adev))
> -		return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_fence_list_sriov, 1);
> -	return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_fence_list, 2);
> +		return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_fence_list_sriov,
> +						ARRAY_SIZE(amdgpu_debugfs_fence_list_sriov));
> +	return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_fence_list,
> +					ARRAY_SIZE(amdgpu_debugfs_fence_list));
>   #else
>   	return 0;
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 77d988a0033f..8c64d8d6cb82 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -928,7 +928,8 @@ static const struct drm_info_list amdgpu_debugfs_gem_list[] = {
>   int amdgpu_debugfs_gem_init(struct amdgpu_device *adev)
>   {
>   #if defined(CONFIG_DEBUG_FS)
> -	return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_gem_list, 1);
> +	return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_gem_list,
> +					ARRAY_SIZE(amdgpu_debugfs_gem_list));
>   #endif
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index 4ffc32b78745..dcd492170598 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -468,7 +468,8 @@ static const struct drm_info_list amdgpu_debugfs_sa_list[] = {
>   int amdgpu_debugfs_sa_init(struct amdgpu_device *adev)
>   {
>   #if defined(CONFIG_DEBUG_FS)
> -	return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_sa_list, 1);
> +	return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_sa_list,
> +					ARRAY_SIZE(amdgpu_debugfs_sa_list));
>   #else
>   	return 0;
>   #endif

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
