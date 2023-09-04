Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB5FC83F33
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Sep 2023 08:43:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AB6210E2F5;
	Mon,  4 Sep 2023 08:43:29 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 525BB10E2FC
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Sep 2023 08:43:26 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-31c8321c48fso1196234f8f.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Sep 2023 01:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693817004; x=1694421804; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IS3qAMsG+bjvjvJZJXoCBKJo+IvVfpTtY/aDV0+KlFc=;
 b=bXxcpF6zkIsrAd5AJy+rhNR3aq5wI9hVGgsWnqhDzzFf2n0hsJ9vmcV+HZtV9/+T6i
 tu4JZpXvJrgMkT/Ku0GbcDA0mstRsOi4jiV6AjZlCanP1novH2OlAbH373BG/pS3EzfH
 airI5bVBO4d4ehZQ5MlhmU7q9WuB6jCUdWIsIlN+wgoiyAKN1DMfupaB07+/uL6vkS/J
 GGBAihQ2etzUzZB25JYaOipNU8jJ16D1UaNWAiY4UqXH2DPp2C48Y8NeH4nu1DWHcWZF
 mFUFyqyfq8hFdcaUDno3GTlpEBwZUKVmDQHqYrbrsd5ezjDvDRWNUn00ucfY1JIvEm0+
 eQvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693817004; x=1694421804;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IS3qAMsG+bjvjvJZJXoCBKJo+IvVfpTtY/aDV0+KlFc=;
 b=Dqpa7+G5QPF5ano+ON9Ej2RCAFgzhxNkdaEYKOCMQMaxUc2hIvwJSfYpQj9OWax6YE
 3GV7gXd0OTezWfqF5YzA4SjyLzMLmCiT3hCoJcleveJGe8xZPa8z+vOOd4mihRITcdlY
 QI2VtecKlAzqEmiDUTh7u+AZQRDNvp5dfXmwSDyHvj9Ls/TMxaoE25gyts9PsABDhZfq
 0T9vi2h+/LjkTGqNBQTWiI6Uki8W/nQ3M4lDHREny2ar86e9El4hnQY6UvQZ5OVJD1ls
 di3ajxJLj7oF+likcvSrRL55eEjnA1BzVr45VIxEHNBVQTHTvESIeqi2oz7dJ2Zive9W
 mlBQ==
X-Gm-Message-State: AOJu0YyJs+ntQALG2sckyn4IW1J0R3+bg4eZ+2PbLyeRlarYScwe2snj
 0RFd2cBIE091SwA9KTBdAEM=
X-Google-Smtp-Source: AGHT+IHU5QBVrKDI1EFKZ1caYkmINcWGvrFeBHhZ+330S/jTQfnIrloVPG7TDVShuQiLqzMR4RRTIg==
X-Received: by 2002:a5d:67cd:0:b0:314:314e:fdda with SMTP id
 n13-20020a5d67cd000000b00314314efddamr9410257wrw.23.1693817004260; 
 Mon, 04 Sep 2023 01:43:24 -0700 (PDT)
Received: from [10.254.108.106] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 a3-20020a056000050300b003179d5aee67sm13768970wrf.94.2023.09.04.01.43.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Sep 2023 01:43:23 -0700 (PDT)
Message-ID: <1e1f4a83-1483-6279-6824-8b1b67553cd2@gmail.com>
Date: Mon, 4 Sep 2023 10:43:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdgpu: Declare array with strings as pointers
 constant
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20230903060548.1972667-1-srinivasan.shanmugam@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230903060548.1972667-1-srinivasan.shanmugam@amd.com>
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 03.09.23 um 08:05 schrieb Srinivasan Shanmugam:
> This warning is for the declaration of a static array, and it is
> recommended to declare it as type "static const char * const" instead of
> "static const char *".
>
> an array pointer declared as type "static const char *" can point to a
> different character constant because the pointer is mutable. However, if
> it is declared as type "static const char * const", the pointer will
> point to an immutable character constant, preventing it from being
> modified which can better ensure the safety and stability of the
> program.
>
> Fixes the below:
>
> WARNING: static const char * array should probably be static const char * const
>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 6 +++---
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c | 4 ++--
>   2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 458faf657042..5c85ac34360f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -6454,7 +6454,7 @@ static int gfx_v9_0_ras_error_inject(struct amdgpu_device *adev,
>   	return ret;
>   }
>   
> -static const char *vml2_mems[] = {
> +static const char * const vml2_mems[] = {
>   	"UTC_VML2_BANK_CACHE_0_BIGK_MEM0",
>   	"UTC_VML2_BANK_CACHE_0_BIGK_MEM1",
>   	"UTC_VML2_BANK_CACHE_0_4K_MEM0",
> @@ -6473,7 +6473,7 @@ static const char *vml2_mems[] = {
>   	"UTC_VML2_BANK_CACHE_3_4K_MEM1",
>   };
>   
> -static const char *vml2_walker_mems[] = {
> +static const char * const vml2_walker_mems[] = {
>   	"UTC_VML2_CACHE_PDE0_MEM0",
>   	"UTC_VML2_CACHE_PDE0_MEM1",
>   	"UTC_VML2_CACHE_PDE1_MEM0",
> @@ -6483,7 +6483,7 @@ static const char *vml2_walker_mems[] = {
>   	"UTC_VML2_RDIF_LOG_FIFO",
>   };
>   
> -static const char *atc_l2_cache_2m_mems[] = {
> +static const char * const atc_l2_cache_2m_mems[] = {
>   	"UTC_ATCL2_CACHE_2M_BANK0_WAY0_MEM",
>   	"UTC_ATCL2_CACHE_2M_BANK0_WAY1_MEM",
>   	"UTC_ATCL2_CACHE_2M_BANK1_WAY0_MEM",
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
> index 63f6843a069e..e7ae37233234 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
> @@ -1548,8 +1548,8 @@ static void gfx_v9_4_2_log_utc_edc_count(struct amdgpu_device *adev,
>   					 uint32_t ded_cnt)
>   {
>   	uint32_t bank, way, mem;
> -	static const char *vml2_way_str[] = { "BIGK", "4K" };
> -	static const char *utcl2_rounter_str[] = { "VMC", "APT" };
> +	static const char * const vml2_way_str[] = { "BIGK", "4K" };
> +	static const char * const utcl2_rounter_str[] = { "VMC", "APT" };
>   
>   	mem = instance % blk->num_mem_blocks;
>   	way = (instance / blk->num_mem_blocks) % blk->num_ways;

