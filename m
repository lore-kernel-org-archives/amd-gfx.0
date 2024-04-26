Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 963B4C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 11:39:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CDF110EC10;
	Fri, 26 Apr 2024 11:39:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Og2bXFtP";
	dkim-atps=neutral
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com
 [209.85.208.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0AE310EC10
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 11:39:00 +0000 (UTC)
Received: by mail-lj1-f171.google.com with SMTP id
 38308e7fff4ca-2d895e2c6efso28818051fa.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 04:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714131539; x=1714736339; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OGEdcWFj4xfF0LUQSvBQILujRnfcByHYjOSF19AukR4=;
 b=Og2bXFtPNvVgE+e3PVXm8dpFKxbhdXPIwCrc1xI+aLt5FYci7K/HjMVk/5xF4HRe1W
 J3nxq1n7THndwOxjExsH+E3VFMHPP9Jo5eu1fZKL9Mn1C/D/q8wvREzFvTtsVkgxOYab
 TwLFWD+kfGdYftlmxigCAWT2vNnK9YxYVmp7fKbP8Bbm+N1cYTmXP+wIfop/h5O0tQ4Y
 MbS8qCN/tqfPLWut0JfzxcnYzs9nhTlTKFNRMmxP+8SD3aj/SRBA62KRdiVW65H0qY6U
 hpSUXTwhbYXrEtUeBuNJstBY3W3qhx13bTR7hRlIonPwevPJL0a5eBhY64/v+EfYwpK4
 s9+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714131539; x=1714736339;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OGEdcWFj4xfF0LUQSvBQILujRnfcByHYjOSF19AukR4=;
 b=MOrcf/QQy1pYtOJu/jbxbaN3JFdT0W5fcDU2RuJyVnwZHBHzRDnvxHh52d6sO3jVWQ
 q6uZ6Yu0MrYbPtPMJLEqgYlVrgrF9iYYGLthzunsK9OFZiLSmjgUyjq9t+LrR2ZOPsr5
 PnRO+wvmRYjElR4fTHY3mckYf0B2UeeCTd5tPU+R09gnzwPDdeIGypU2yZgcjAjI0Ug7
 x4DbXNgb/g/CnA2aLGtPU4Oxw1+FZ9E+XiwWin4bwCyW1fH7xGNqsEOHa9dq0XOgsCbc
 QR15kseMDfz0DRDhy/WTMXcN0YU5umXvwyfbNoV8PLhsqUEcjRIDybwxSLSD+pPbvC5d
 D5mQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0LItA5uCeeCVaQGwg8FujVLwnB9n8F+GxKpWxEf/Lc8+VwZ+WFeIEU/jprNj4x0alQTeQiUMhdb8rUliC6UpVqOy3Zi5VCdADCfq7pg==
X-Gm-Message-State: AOJu0Yxbj2r9GV1Ezxr+nyKUGSM5sVgdkJcRXFl90wWjx8I+E9TuQluj
 qpOnzeOFG7EE1BNyZDAQj2UkdgBUVJWvs3jSlHGEUyE3MqIUhVyU
X-Google-Smtp-Source: AGHT+IHQ0XraJ6cOiiD4njtnDzcDkeCBojzQliQaQJMnOpP+UskY+ZQxh6Li7Z+VRxHbheo2KU+B8w==
X-Received: by 2002:a2e:be83:0:b0:2dd:74d3:7ca8 with SMTP id
 a3-20020a2ebe83000000b002dd74d37ca8mr1771380ljr.27.1714131538519; 
 Fri, 26 Apr 2024 04:38:58 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 j10-20020a05600c190a00b00418a9961c47sm30664588wmq.47.2024.04.26.04.38.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Apr 2024 04:38:57 -0700 (PDT)
Message-ID: <af9531ef-d623-4ef9-a93f-28796dedfa7c@gmail.com>
Date: Fri, 26 Apr 2024 13:38:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: fix uninitialized variable warning for
 smu8_hwmgr
To: Tim Huang <Tim.Huang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, christian.koenig@amd.com
References: <20240426092909.1350037-1-Tim.Huang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240426092909.1350037-1-Tim.Huang@amd.com>
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

Am 26.04.24 um 11:29 schrieb Tim Huang:
> Clear warnings that using uninitialized value level when fails
> to get the value from SMU.
>
> Signed-off-by: Tim Huang <Tim.Huang@amd.com>

Maybe drop the blank line before the "if (ret)", apart from that 
Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   .../drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c    | 18 +++++++++++++++---
>   1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
> index b015a601b385..4e4146ce71c1 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
> @@ -584,6 +584,7 @@ static int smu8_init_uvd_limit(struct pp_hwmgr *hwmgr)
>   				hwmgr->dyn_state.uvd_clock_voltage_dependency_table;
>   	unsigned long clock = 0;
>   	uint32_t level;
> +	int ret;
>   
>   	if (NULL == table || table->count <= 0)
>   		return -EINVAL;
> @@ -591,7 +592,10 @@ static int smu8_init_uvd_limit(struct pp_hwmgr *hwmgr)
>   	data->uvd_dpm.soft_min_clk = 0;
>   	data->uvd_dpm.hard_min_clk = 0;
>   
> -	smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxUvdLevel, &level);
> +	ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxUvdLevel, &level);
> +
> +	if (ret)
> +		return ret;
>   
>   	if (level < table->count)
>   		clock = table->entries[level].vclk;
> @@ -611,6 +615,7 @@ static int smu8_init_vce_limit(struct pp_hwmgr *hwmgr)
>   				hwmgr->dyn_state.vce_clock_voltage_dependency_table;
>   	unsigned long clock = 0;
>   	uint32_t level;
> +	int ret;
>   
>   	if (NULL == table || table->count <= 0)
>   		return -EINVAL;
> @@ -618,7 +623,10 @@ static int smu8_init_vce_limit(struct pp_hwmgr *hwmgr)
>   	data->vce_dpm.soft_min_clk = 0;
>   	data->vce_dpm.hard_min_clk = 0;
>   
> -	smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxEclkLevel, &level);
> +	ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxEclkLevel, &level);
> +
> +	if (ret)
> +		return ret;
>   
>   	if (level < table->count)
>   		clock = table->entries[level].ecclk;
> @@ -638,6 +646,7 @@ static int smu8_init_acp_limit(struct pp_hwmgr *hwmgr)
>   				hwmgr->dyn_state.acp_clock_voltage_dependency_table;
>   	unsigned long clock = 0;
>   	uint32_t level;
> +	int ret;
>   
>   	if (NULL == table || table->count <= 0)
>   		return -EINVAL;
> @@ -645,7 +654,10 @@ static int smu8_init_acp_limit(struct pp_hwmgr *hwmgr)
>   	data->acp_dpm.soft_min_clk = 0;
>   	data->acp_dpm.hard_min_clk = 0;
>   
> -	smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxAclkLevel, &level);
> +	ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxAclkLevel, &level);
> +
> +	if (ret)
> +		return ret;
>   
>   	if (level < table->count)
>   		clock = table->entries[level].acpclk;

