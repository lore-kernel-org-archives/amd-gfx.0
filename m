Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 888E3CEDD85
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 11:37:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33EE310E284;
	Wed,  9 Oct 2024 11:37:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V6ZlvNVn";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5721D10E284
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 11:37:56 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-37d2ddb61c8so1644399f8f.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 09 Oct 2024 04:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728473875; x=1729078675; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5drwwCb1OzpOunSX8r8nYgcmtrthCTSbTIlbrAFB5VU=;
 b=V6ZlvNVnq6GWd/vohyISLTaiawJdEvQuq6+wpXIbxHgilrKcLqGbHuc03leuMrHgne
 YFBHmMnZMsCYOwRi+qMXyZ0tUgxs/8zBsdaIs65ao+1QqaXjlFty2mgcDaUATD0u+QsJ
 J5jIHmGSzTHs1fSZNK0aLu5NEcLidIMFF2GJEl6E9H4GAmWH+UVsdk1vWLeep7CoMNxc
 tqnRf7scbjIcts7xegMiIbHXMXgnL0kcsUupjN537jWDTelAX0mWjIjuAfNP1ZoHF3xh
 VcBLc+W9nMX2kmqQ+8mG9EVaoxnGfDg7+Fhft9cAbz1eBxMpgf8SZIqXXf3rLwYdKByn
 5pGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728473875; x=1729078675;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5drwwCb1OzpOunSX8r8nYgcmtrthCTSbTIlbrAFB5VU=;
 b=jOSJaobf87MQ3pAUmfP0pkhanXTgB0JkqcuIUjGE6SxbZpVIo2zT5P++aVxPfbe76K
 oDV3c9oSe18mA83m8Xvsn0ouCQqsuI9qCDs+VRpDNf2WKdBRieHD2+SshnF+0B1dezuA
 0tuItzcxHbc65cZh+AGX7hJlTgHzTDsOYCx/0g3sR0H2Q2Z9RoiVy8+mcU4FfStaJ7nX
 8a1lU/+d4UYNUzjooZmiNaEsep3D1t881O6SDaCVuhTnMbxzUlIjWt9Th69vZP9Ne/OQ
 RI5tpr+JtakbP50L2IPX88NaoDiR//t0riJFz9oWYnCmVZh5kqczz3kK+HkC3EsqeSZG
 Jg8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWci+F4d/bzHKKNEPvydpgR78y8eFNHDQOmauBccxiEecPZZFwId6OVDGB4+JBf7EXq3pxKkPz4@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyaZoOxyB18m815bMeaUALdhZD/UqnBYQ9j2KrB0LoMs6R4EjFx
 IKExYftfQHr76UmrZ11FxSacAB9S5JSGX9ck0EPTkk5RuuvRN6kz47MFObqb
X-Google-Smtp-Source: AGHT+IEaPGcmSF+RIxCBOqRyPwo+4okp5s09F9rQQznyG27bpSUUqIkwExeraiSw0P/AI21usITtYQ==
X-Received: by 2002:a5d:4045:0:b0:37c:d2e3:1298 with SMTP id
 ffacd0b85a97d-37d3ab1c97fmr1582112f8f.55.1728473874277; 
 Wed, 09 Oct 2024 04:37:54 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-430d59b2412sm17629655e9.32.2024.10.09.04.37.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2024 04:37:53 -0700 (PDT)
Message-ID: <52c6f4ca-0e33-47a5-8bac-fe51ba27ab5f@gmail.com>
Date: Wed, 9 Oct 2024 13:37:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/32] drm/amd/pm: power up or down vcn by instance
To: boyuan.zhang@amd.com, amd-gfx@lists.freedesktop.org, leo.liu@amd.com,
 christian.koenig@amd.com, alexander.deucher@amd.com, sunil.khatri@amd.com
References: <20241008211553.36264-1-boyuan.zhang@amd.com>
 <20241008211553.36264-3-boyuan.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20241008211553.36264-3-boyuan.zhang@amd.com>
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



Am 08.10.24 um 23:15 schrieb boyuan.zhang@amd.com:
> From: Boyuan Zhang <boyuan.zhang@amd.com>
>
> For smu ip with multiple vcn instances (smu 11/13/14), remove all the
> for loop in dpm_set_vcn_enable() functions. And use the instance
> argument to power up/down vcn for the given instance only, instead
> of powering up/down for all vcn instances.
>
> v2: remove all duplicated functions in v1.
>
> remove for-loop from each ip, and temporarily move to dpm_set_vcn_enable,
> in order to keep the exact same logic as before, until further separation
> in the next patch.
>
> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  7 +++-
>   .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 20 +++++------
>   .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 16 ++++-----
>   .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    | 35 ++++++++-----------
>   4 files changed, 35 insertions(+), 43 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 6305fd7d2573..410d5baedfbc 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -237,6 +237,7 @@ static int smu_dpm_set_vcn_enable(struct smu_context *smu,
>   {
>   	struct smu_power_context *smu_power = &smu->smu_power;
>   	struct smu_power_gate *power_gate = &smu_power->power_gate;
> +	struct amdgpu_device *adev = smu->adev;
>   	int ret = 0;
>   
>   	/*
> @@ -251,7 +252,11 @@ static int smu_dpm_set_vcn_enable(struct smu_context *smu,
>   	if (atomic_read(&power_gate->vcn_gated) ^ enable)
>   		return 0;
>   
> -	ret = smu->ppt_funcs->dpm_set_vcn_enable(smu, enable, 0xff);
> +	for (int i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		ret = smu->ppt_funcs->dpm_set_vcn_enable(smu, enable, i);
> +		if (ret)
> +			return ret;
> +	}
>   	if (!ret)

I think you should be able to drop this if (!ret) now.

Apart from that looks really good,
Christian.

>   		atomic_set(&power_gate->vcn_gated, !enable);
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 2438f813d6db..f41d8fd09bce 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -1157,19 +1157,15 @@ static int sienna_cichlid_dpm_set_vcn_enable(struct smu_context *smu,
>   					      int inst)
>   {
>   	struct amdgpu_device *adev = smu->adev;
> -	int i, ret = 0;
> +	int ret = 0;
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> -		if (adev->vcn.harvest_config & (1 << i))
> -			continue;
> -		/* vcn dpm on is a prerequisite for vcn power gate messages */
> -		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
> -			ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
> -							      SMU_MSG_PowerUpVcn : SMU_MSG_PowerDownVcn,
> -							      0x10000 * i, NULL);
> -			if (ret)
> -				return ret;
> -		}
> +	if (adev->vcn.harvest_config & (1 << inst))
> +		return ret;
> +	/* vcn dpm on is a prerequisite for vcn power gate messages */
> +	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
> +		ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
> +                                            SMU_MSG_PowerUpVcn : SMU_MSG_PowerDownVcn,
> +                                            0x10000 * inst, NULL);
>   	}
>   
>   	return ret;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index 1d37b9e251d4..e57d4926250e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -2092,18 +2092,14 @@ int smu_v13_0_set_vcn_enable(struct smu_context *smu,
>   			      int inst)
>   {
>   	struct amdgpu_device *adev = smu->adev;
> -	int i, ret = 0;
> +	int ret = 0;
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> -		if (adev->vcn.harvest_config & (1 << i))
> -			continue;
> +	if (adev->vcn.harvest_config & (1 << inst))
> +		return ret;
>   
> -		ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
> -						      SMU_MSG_PowerUpVcn : SMU_MSG_PowerDownVcn,
> -						      i << 16U, NULL);
> -		if (ret)
> -			return ret;
> -	}
> +	ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
> +					      SMU_MSG_PowerUpVcn : SMU_MSG_PowerDownVcn,
> +					      inst << 16U, NULL);
>   
>   	return ret;
>   }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> index 5e1165ecdf7b..20822ac623c7 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> @@ -1496,29 +1496,24 @@ int smu_v14_0_set_vcn_enable(struct smu_context *smu,
>   			      int inst)
>   {
>   	struct amdgpu_device *adev = smu->adev;
> -	int i, ret = 0;
> +	int ret = 0;
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> -		if (adev->vcn.harvest_config & (1 << i))
> -			continue;
> +	if (adev->vcn.harvest_config & (1 << inst))
> +		return ret;
>   
> -		if (smu->is_apu) {
> -			if (i == 0)
> -				ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
> -								      SMU_MSG_PowerUpVcn0 : SMU_MSG_PowerDownVcn0,
> -								      i << 16U, NULL);
> -			else if (i == 1)
> -				ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
> -								      SMU_MSG_PowerUpVcn1 : SMU_MSG_PowerDownVcn1,
> -								      i << 16U, NULL);
> -		} else {
> +	if (smu->is_apu) {
> +		if (inst == 0)
>   			ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
> -							      SMU_MSG_PowerUpVcn : SMU_MSG_PowerDownVcn,
> -							      i << 16U, NULL);
> -		}
> -
> -		if (ret)
> -			return ret;
> +							      SMU_MSG_PowerUpVcn0 : SMU_MSG_PowerDownVcn0,
> +							      inst << 16U, NULL);
> +		else if (inst == 1)
> +			ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
> +							      SMU_MSG_PowerUpVcn1 : SMU_MSG_PowerDownVcn1,
> +							      inst << 16U, NULL);
> +	} else {
> +		ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
> +						      SMU_MSG_PowerUpVcn : SMU_MSG_PowerDownVcn,
> +						      inst << 16U, NULL);
>   	}
>   
>   	return ret;

