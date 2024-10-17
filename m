Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C76D2A53A
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 11:58:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0D5F10E166;
	Thu, 17 Oct 2024 11:58:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AjFasFnO";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CACAC10E166
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 11:58:44 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4315df7b43fso3429655e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 04:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729166323; x=1729771123; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FcZSDhKwKzOaU7hanYf6IiS2J3fBfX9QWah/7Pv4cQg=;
 b=AjFasFnO9+xwzQ5pmMc7JodeVwt3ftOpAVWUxA7jL7pJTplrWa68qxdoAP3BY1vz8K
 AOEk+loGSdqBr7fsKlDaMNiFsXS0Nl3qQ8Y6TRHFnVnSbU11xp3nSaQbHnnKXeEYCZOO
 yG/fA5PXYrTZztGHlqp6qnOCJ6P+u5t7PSiLSr2f76OacPVIIju2t39rBvFxMqjfd8Wd
 eg4qOqYKM1cIUjKuEAbWHnrx2Oj3W1T6UcY0XImxlG0uEH1S/9NyUt6SW/uGdjaiNe7h
 tlkzSsUvDFnhJMGRzbFhZnNrrfuLPD0RA9ky+KRzH6WIE/Ik5xkbubWAH6q7XFMt4u1X
 wXqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729166323; x=1729771123;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FcZSDhKwKzOaU7hanYf6IiS2J3fBfX9QWah/7Pv4cQg=;
 b=kmjRX729SC9isYJAVtDnf5e+01y5b54A7sUEmMgmiYLSAqhPgjhRZPVzkiUM/U8lFJ
 9ETnWSOO5jTX/fadwjtY9De0S5Sa1ODrqMNWm2WSw+HCj+9SYz3hDtp3K3qyHXAMZYkB
 3+jWyyou/NR+eNvp0R7uucI8MHMUVRMkwI8LezUuZEaDUt0urRTJDeIg/PxJqW1CmX3G
 Jm5nkn+5lj2Ldie1arAFU2oP8lhSC+DfZTvzxHN5L0WlUOCPusVXM6gyYMfhTnEg7t1A
 Ms9FNayDEvT8UPG/KuutOw5lqcpJojMLKGPo0PbCphSOshhCPw5S1gqg6qPf4KCGrMhy
 ZO7A==
X-Gm-Message-State: AOJu0Yx9jWVgFzabaEYP7rPruUpFlkciBfo2ynrzeOJG7E3N5Z1nNtrg
 esEtMuGlgY4Jti0ZhbYpdbVaDfIc8gesXru/Gqb6gJpWSuGbp22R
X-Google-Smtp-Source: AGHT+IG7Dhv+sx6f9fXXF/D60ZKloqT4mOlOg6655CgGGAj+gKZEtWR1ZbYirarU4E/UVrytDiOVxg==
X-Received: by 2002:a5d:6e08:0:b0:37d:49d1:1e89 with SMTP id
 ffacd0b85a97d-37d86bda18cmr4270024f8f.27.1729166322819; 
 Thu, 17 Oct 2024 04:58:42 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fbf838dsm7103800f8f.78.2024.10.17.04.58.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2024 04:58:42 -0700 (PDT)
Message-ID: <6c44c6b7-bdb9-483b-9027-8e93380a710c@gmail.com>
Date: Thu, 17 Oct 2024 13:58:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/15] drm/amdgpu: clean the dummy hw_fini functions
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20241017100615.1492144-1-sunil.khatri@amd.com>
 <20241017100615.1492144-12-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20241017100615.1492144-12-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Am 17.10.24 um 12:06 schrieb Sunil Khatri:
> Remove the dummy hw_fini functions for all
> ip blocks.

As discussed on the call hw_init() and hw_fini() are the only two 
functions I consider mandatory.

So please drop this patch here and as a follow up task maybe look into 
why vkms and mes_v12 don't have a hw_fini function.

For SI and CIK we probably don't care any more since those are to old.

Regards,
Christian.

>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c |  6 ------
>   drivers/gpu/drm/amd/amdgpu/cik.c         |  6 ------
>   drivers/gpu/drm/amd/amdgpu/mes_v12_0.c   | 11 +----------
>   drivers/gpu/drm/amd/amdgpu/si.c          |  6 ------
>   4 files changed, 1 insertion(+), 28 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> index ed8015313827..e3a399bfab61 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> @@ -600,11 +600,6 @@ static int amdgpu_vkms_hw_init(struct amdgpu_ip_block *ip_block)
>   	return 0;
>   }
>   
> -static int amdgpu_vkms_hw_fini(struct amdgpu_ip_block *ip_block)
> -{
> -	return 0;
> -}
> -
>   static int amdgpu_vkms_suspend(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> @@ -661,7 +656,6 @@ static const struct amd_ip_funcs amdgpu_vkms_ip_funcs = {
>   	.sw_init = amdgpu_vkms_sw_init,
>   	.sw_fini = amdgpu_vkms_sw_fini,
>   	.hw_init = amdgpu_vkms_hw_init,
> -	.hw_fini = amdgpu_vkms_hw_fini,
>   	.suspend = amdgpu_vkms_suspend,
>   	.resume = amdgpu_vkms_resume,
>   	.is_idle = amdgpu_vkms_is_idle,
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
> index c8fb592f13df..9cb25d0d1051 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik.c
> @@ -2138,11 +2138,6 @@ static int cik_common_hw_init(struct amdgpu_ip_block *ip_block)
>   	return 0;
>   }
>   
> -static int cik_common_hw_fini(struct amdgpu_ip_block *ip_block)
> -{
> -	return 0;
> -}
> -
>   static int cik_common_resume(struct amdgpu_ip_block *ip_block)
>   {
>   	return cik_common_hw_init(ip_block);
> @@ -2181,7 +2176,6 @@ static const struct amd_ip_funcs cik_common_ip_funcs = {
>   	.early_init = cik_common_early_init,
>   	.late_init = NULL,
>   	.hw_init = cik_common_hw_init,
> -	.hw_fini = cik_common_hw_fini,
>   	.resume = cik_common_resume,
>   	.is_idle = cik_common_is_idle,
>   	.wait_for_idle = cik_common_wait_for_idle,
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> index 9d0e342a2f81..a1af5c90f79a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -40,7 +40,6 @@ MODULE_FIRMWARE("amdgpu/gc_12_0_1_mes1.bin");
>   MODULE_FIRMWARE("amdgpu/gc_12_0_1_uni_mes.bin");
>   
>   static int mes_v12_0_hw_init(struct amdgpu_ip_block *ip_block);
> -static int mes_v12_0_hw_fini(struct amdgpu_ip_block *ip_block);
>   static int mes_v12_0_kiq_hw_init(struct amdgpu_device *adev);
>   static int mes_v12_0_kiq_hw_fini(struct amdgpu_device *adev);
>   
> @@ -1516,7 +1515,6 @@ static int mes_v12_0_kiq_hw_init(struct amdgpu_device *adev)
>   	return r;
>   
>   failure:
> -	mes_v12_0_hw_fini(ip_block);
>   	return r;
>   }
>   
> @@ -1600,15 +1598,9 @@ static int mes_v12_0_hw_init(struct amdgpu_ip_block *ip_block)
>   	return 0;
>   
>   failure:
> -	mes_v12_0_hw_fini(ip_block);
>   	return r;
>   }
>   
> -static int mes_v12_0_hw_fini(struct amdgpu_ip_block *ip_block)
> -{
> -	return 0;
> -}
> -
>   static int mes_v12_0_suspend(struct amdgpu_ip_block *ip_block)
>   {
>   	int r;
> @@ -1617,7 +1609,7 @@ static int mes_v12_0_suspend(struct amdgpu_ip_block *ip_block)
>   	if (r)
>   		return r;
>   
> -	return mes_v12_0_hw_fini(ip_block);
> +	return 0;
>   }
>   
>   static int mes_v12_0_resume(struct amdgpu_ip_block *ip_block)
> @@ -1663,7 +1655,6 @@ static const struct amd_ip_funcs mes_v12_0_ip_funcs = {
>   	.sw_init = mes_v12_0_sw_init,
>   	.sw_fini = mes_v12_0_sw_fini,
>   	.hw_init = mes_v12_0_hw_init,
> -	.hw_fini = mes_v12_0_hw_fini,
>   	.suspend = mes_v12_0_suspend,
>   	.resume = mes_v12_0_resume,
>   };
> diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
> index 66ccb76eb72a..e1b3bef6992a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si.c
> @@ -2634,11 +2634,6 @@ static int si_common_hw_init(struct amdgpu_ip_block *ip_block)
>   	return 0;
>   }
>   
> -static int si_common_hw_fini(struct amdgpu_ip_block *ip_block)
> -{
> -	return 0;
> -}
> -
>   static int si_common_resume(struct amdgpu_ip_block *ip_block)
>   {
>   	return si_common_hw_init(ip_block);
> @@ -2676,7 +2671,6 @@ static const struct amd_ip_funcs si_common_ip_funcs = {
>   	.early_init = si_common_early_init,
>   	.late_init = NULL,
>   	.hw_init = si_common_hw_init,
> -	.hw_fini = si_common_hw_fini,
>   	.resume = si_common_resume,
>   	.is_idle = si_common_is_idle,
>   	.wait_for_idle = si_common_wait_for_idle,

