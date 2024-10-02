Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6389FCF31B4
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Oct 2024 11:19:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E841210E6F7;
	Wed,  2 Oct 2024 11:19:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qn13sQt5";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC05810E6F7
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Oct 2024 11:19:36 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-37cd0b5515fso3450575f8f.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Oct 2024 04:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727867975; x=1728472775; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=53x49EoS/yodd+lSnAv6dNKT+UtPRsbOe7f/RUT96vY=;
 b=Qn13sQt5fGRbB5HMa8JKoMNaf3ZcPhY2ezzst29dt0zMzn7SUAUhSS5LXtpmf/Bwx6
 tVShwqLGeoiGQRRT5RDyDTD1xxzLLMuS1MaK6MZ8g+LZejA3xJ3f4EIzNPT4noXyctKQ
 vVEhhSx21pEjyryWfFMBwUvG77MAIifgl87bhflnKt1oWmbbsx5nwm/dFi9uxLwjRMey
 63ntPvgXriEbAV7eUOWivraQt2WEsH27V8f8AUi3ej/LeDMxLsmpmnhNYKF3Z8fse/av
 8OH8+6WjUqA2Rv3tBK6rMYUiErwAGo/wKPRBim+Rn+Y2QqMxsYkUSDtf3kWLN57DZhpT
 El2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727867975; x=1728472775;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=53x49EoS/yodd+lSnAv6dNKT+UtPRsbOe7f/RUT96vY=;
 b=C0JGkuJ74nCCUmnQ6w2aiuF2XXnM4/GzciOwtcYekV97sNHFO5wYL+LXpG4qIc3nkX
 ZKCoaXsaW5tS/B3XNgkfs9725eATuhoFw7OcUXf5X3x/63RJL4eILaIAxuu+4Z4iTPwQ
 FEHAQ72v+A1KJatFgsgwRAbeEYE9Y5JqLSlhs+aM2N4cnPcNgkBCipW7NjyhQqNNHca2
 fzU1qIdowUslv2VhimDQVUCJ2tA8IcZ/T9Lf0W2V7ukB2fn4ZV3Q42prCF7gAxyDhJ7F
 mMe0Q05h1dtPolvZP39Ma1rhT/0MxX0bJIhXYHZjsQgkmsr7w7kZnGjptpdiqziviOQs
 RxzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQ9asfcNqgCmuyIVAuAz0/Rx2K7yskv/19+aRZNn/3/DJpQ5KrEuaSX52dLPSA0mL+B6//7Uvo@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx13i7qIAOkfqGBCnOLq4ofMmjH9/8yMApfz9wihFIk79k5SktV
 94vJjzm3/nspeXtfQokzSGyB3NPrWwlR8gcbhaB8mTY/myAMlFcA
X-Google-Smtp-Source: AGHT+IHKfIZT2hTTRHAgegcp89K6EX+qNXgEArn4IkIjxV9Kx7v8BiyURqKv0dPvusbdrFchoXgNWw==
X-Received: by 2002:a5d:4c87:0:b0:37c:c870:b454 with SMTP id
 ffacd0b85a97d-37cfba0a5a1mr1419247f8f.49.1727867974872; 
 Wed, 02 Oct 2024 04:19:34 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd57427b9sm13708937f8f.95.2024.10.02.04.19.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Oct 2024 04:19:34 -0700 (PDT)
Message-ID: <5adab3db-d24b-43b5-8436-5f871b085c02@gmail.com>
Date: Wed, 2 Oct 2024 13:19:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/18] drm/amd/pm: set vcn enable by instance
To: boyuan.zhang@amd.com, amd-gfx@lists.freedesktop.org, leo.liu@amd.com,
 christian.koenig@amd.com, alexander.deucher@amd.com, sunil.khatri@amd.com
References: <20241002043627.102414-1-boyuan.zhang@amd.com>
 <20241002043627.102414-6-boyuan.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20241002043627.102414-6-boyuan.zhang@amd.com>
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

Am 02.10.24 um 06:36 schrieb boyuan.zhang@amd.com:
> From: Boyuan Zhang <boyuan.zhang@amd.com>
>
> The new function smu_dpm_set_vcn_enable_instance() will be used to enable
> or disable vcn engine dynamic power for the given vcn instance only.
>
> The original function smu_dpm_set_vcn_enable() will still be used to enable
> or disable vcn engine dynamic power for all VCN instances as before.
>
> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 132 +++++++++++++++---
>   drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |   2 +-
>   2 files changed, 115 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 939e15b24f86..ddfed7189708 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -232,12 +232,15 @@ static bool is_vcn_enabled(struct amdgpu_device *adev)
>   	return true;
>   }
>   
> -static int smu_dpm_set_vcn_enable(struct smu_context *smu,
> -				  bool enable)
> +static int smu_dpm_set_vcn_enable_instance(struct smu_context *smu,
> +				  bool enable,
> +				  int inst)
>   {
>   	struct smu_power_context *smu_power = &smu->smu_power;
>   	struct smu_power_gate *power_gate = &smu_power->power_gate;
> +	struct amdgpu_device *adev = smu->adev;
>   	int ret = 0;
> +	bool single_inst = (adev->vcn.num_vcn_inst == 1);

Please keep the reverse xmas tree order, e.g. defines like ret last.

Apart from that patches #1-'6 are Acked-by: Christian König 
<christian.koenig@amd.com>, but Alex should probably take a look as well 
since I'm not that deep into PM.

Regards,
Christian.

>   
>   	/*
>   	 * don't poweron vcn/jpeg when they are skipped.
> @@ -245,15 +248,33 @@ static int smu_dpm_set_vcn_enable(struct smu_context *smu,
>   	if (!is_vcn_enabled(smu->adev))
>   		return 0;
>   
> -	if (!smu->ppt_funcs->dpm_set_vcn_enable)
> +	if (!smu->ppt_funcs->dpm_set_vcn_enable_instance && !single_inst)
>   		return 0;
>   
> -	if (atomic_read(&power_gate->vcn_gated) ^ enable)
> +	if (!smu->ppt_funcs->dpm_set_vcn_enable && single_inst)
>   		return 0;
>   
> -	ret = smu->ppt_funcs->dpm_set_vcn_enable(smu, enable);
> +	if (atomic_read(&power_gate->vcn_gated[inst]) ^ enable)
> +		return 0;
> +
> +	if (single_inst)
> +		ret = smu->ppt_funcs->dpm_set_vcn_enable(smu, enable);
> +	else
> +		ret = smu->ppt_funcs->dpm_set_vcn_enable_instance(smu, enable, inst);
>   	if (!ret)
> -		atomic_set(&power_gate->vcn_gated, !enable);
> +		atomic_set(&power_gate->vcn_gated[inst], !enable);
> +
> +	return ret;
> +}
> +
> +static int smu_dpm_set_vcn_enable(struct smu_context *smu,
> +				  bool enable)
> +{
> +	struct amdgpu_device *adev = smu->adev;
> +	int ret = 0;
> +
> +	for (int i = 0; i < adev->vcn.num_vcn_inst; i++)
> +		ret = smu_dpm_set_vcn_enable_instance(smu, enable, i);
>   
>   	return ret;
>   }
> @@ -408,6 +429,81 @@ static int smu_dpm_set_power_gate(void *handle,
>   	return ret;
>   }
>   
> +/**
> + * smu_dpm_set_power_gate_instance - power gate/ungate the specific IP block
> + *                                   for the specific instance
> + *
> + * @handle:     smu_context pointer
> + * @block_type: the IP block to power gate/ungate
> + * @gate:       to power gate if true, ungate otherwise
> + * @inst:       the instance to power gate/ungate
> + *
> + * This API uses no smu->mutex lock protection due to:
> + * 1. It is either called by other IP block(gfx/sdma/vcn/uvd/vce).
> + *    This is guarded to be race condition free by the caller.
> + * 2. Or get called on user setting request of power_dpm_force_performance_level.
> + *    Under this case, the smu->mutex lock protection is already enforced on
> + *    the parent API smu_force_performance_level of the call path.
> + */
> +static int smu_dpm_set_power_gate_instance(void *handle,
> +				  uint32_t block_type,
> +				  bool gate,
> +				  int inst)
> +{
> +	struct smu_context *smu = handle;
> +	int ret = 0;
> +
> +	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled) {
> +		dev_WARN(smu->adev->dev,
> +			 "SMU uninitialized but power %s requested for %u!\n",
> +			 gate ? "gate" : "ungate", block_type);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	switch (block_type) {
> +	/*
> +	 * Some legacy code of amdgpu_vcn.c and vcn_v2*.c still uses
> +	 * AMD_IP_BLOCK_TYPE_UVD for VCN. So, here both of them are kept.
> +	 */
> +	case AMD_IP_BLOCK_TYPE_UVD:
> +	case AMD_IP_BLOCK_TYPE_VCN:
> +		ret = smu_dpm_set_vcn_enable_instance(smu, !gate, inst);
> +		if (ret)
> +			dev_err(smu->adev->dev, "Failed to power %s VCN!\n",
> +				gate ? "gate" : "ungate");
> +		break;
> +	case AMD_IP_BLOCK_TYPE_GFX:
> +		ret = smu_gfx_off_control(smu, gate);
> +		if (ret)
> +			dev_err(smu->adev->dev, "Failed to %s gfxoff!\n",
> +				gate ? "enable" : "disable");
> +		break;
> +	case AMD_IP_BLOCK_TYPE_SDMA:
> +		ret = smu_powergate_sdma(smu, gate);
> +		if (ret)
> +			dev_err(smu->adev->dev, "Failed to power %s SDMA!\n",
> +				gate ? "gate" : "ungate");
> +		break;
> +	case AMD_IP_BLOCK_TYPE_JPEG:
> +		ret = smu_dpm_set_jpeg_enable(smu, !gate);
> +		if (ret)
> +			dev_err(smu->adev->dev, "Failed to power %s JPEG!\n",
> +				gate ? "gate" : "ungate");
> +		break;
> +	case AMD_IP_BLOCK_TYPE_VPE:
> +		ret = smu_dpm_set_vpe_enable(smu, !gate);
> +		if (ret)
> +			dev_err(smu->adev->dev, "Failed to power %s VPE!\n",
> +				gate ? "gate" : "ungate");
> +		break;
> +	default:
> +		dev_err(smu->adev->dev, "Unsupported block type!\n");
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
>   /**
>    * smu_set_user_clk_dependencies - set user profile clock dependencies
>    *
> @@ -774,19 +870,11 @@ static int smu_early_init(struct amdgpu_ip_block *ip_block)
>   static int smu_set_default_dpm_table(struct smu_context *smu)
>   {
>   	struct amdgpu_device *adev = smu->adev;
> -	struct smu_power_context *smu_power = &smu->smu_power;
> -	struct smu_power_gate *power_gate = &smu_power->power_gate;
> -	int vcn_gate, jpeg_gate;
>   	int ret = 0;
>   
>   	if (!smu->ppt_funcs->set_default_dpm_table)
>   		return 0;
>   
> -	if (adev->pg_flags & AMD_PG_SUPPORT_VCN)
> -		vcn_gate = atomic_read(&power_gate->vcn_gated);
> -	if (adev->pg_flags & AMD_PG_SUPPORT_JPEG)
> -		jpeg_gate = atomic_read(&power_gate->jpeg_gated);
> -
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
>   		ret = smu_dpm_set_vcn_enable(smu, true);
>   		if (ret)
> @@ -805,10 +893,10 @@ static int smu_set_default_dpm_table(struct smu_context *smu)
>   			"Failed to setup default dpm clock tables!\n");
>   
>   	if (adev->pg_flags & AMD_PG_SUPPORT_JPEG)
> -		smu_dpm_set_jpeg_enable(smu, !jpeg_gate);
> +		smu_dpm_set_jpeg_enable(smu, false);
>   err_out:
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN)
> -		smu_dpm_set_vcn_enable(smu, !vcn_gate);
> +		smu_dpm_set_vcn_enable(smu, false);
>   
>   	return ret;
>   }
> @@ -1253,7 +1341,8 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
>   	smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>   	smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>   
> -	atomic_set(&smu->smu_power.power_gate.vcn_gated, 1);
> +	for (int i = 0; i < adev->vcn.num_vcn_inst; i++)
> +		atomic_set(&smu->smu_power.power_gate.vcn_gated[i], 1);
>   	atomic_set(&smu->smu_power.power_gate.jpeg_gated, 1);
>   	atomic_set(&smu->smu_power.power_gate.vpe_gated, 1);
>   	atomic_set(&smu->smu_power.power_gate.umsch_mm_gated, 1);
> @@ -2932,6 +3021,7 @@ static int smu_read_sensor(void *handle,
>   			   int *size_arg)
>   {
>   	struct smu_context *smu = handle;
> +	struct amdgpu_device *adev = smu->adev;
>   	struct smu_umd_pstate_table *pstate_table =
>   				&smu->pstate_table;
>   	int ret = 0;
> @@ -2980,7 +3070,13 @@ static int smu_read_sensor(void *handle,
>   		*size = 4;
>   		break;
>   	case AMDGPU_PP_SENSOR_VCN_POWER_STATE:
> -		*(uint32_t *)data = atomic_read(&smu->smu_power.power_gate.vcn_gated) ? 0 : 1;
> +		*(uint32_t *)data = 0;
> +		for (int i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +			if (!atomic_read(&smu->smu_power.power_gate.vcn_gated[i])) {
> +				*(uint32_t *)data = 1;
> +				break;
> +			}
> +		}
>   		*size = 4;
>   		break;
>   	case AMDGPU_PP_SENSOR_MIN_FAN_RPM:
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index f88241cdf9b9..b8b6050877c1 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -399,7 +399,7 @@ struct smu_dpm_context {
>   struct smu_power_gate {
>   	bool uvd_gated;
>   	bool vce_gated;
> -	atomic_t vcn_gated;
> +	atomic_t vcn_gated[AMDGPU_MAX_VCN_INSTANCES];
>   	atomic_t jpeg_gated;
>   	atomic_t vpe_gated;
>   	atomic_t umsch_mm_gated;

