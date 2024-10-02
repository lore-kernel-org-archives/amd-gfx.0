Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A4DECF31B4
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Oct 2024 11:28:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 936AE10E08C;
	Wed,  2 Oct 2024 11:28:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AL/Pmbab";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CC6B10E6F8
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Oct 2024 11:28:42 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-42cb7a2e4d6so59138335e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Oct 2024 04:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727868521; x=1728473321; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Bo1UOBTngmAwI3vqiAWjlTIEr2mqJeRsMQkQAW1dQ9U=;
 b=AL/PmbabSZEGWs92mpkcLqkHfZIgcijFO86IaBXbUWzEUkkx6BH8w7TS/cLIWuSITc
 T5I4Q22H0PKM2SnFNF/qM/5KQ8eMTBeizs9bVhZZxuWWGo+sHHvsa4BGWEyO0BKMsfqM
 K+F5krwG2YuTOOKmDbV88AKdWPIbkDX+H+sNmG4ZU2yhC1V+5KT63tx8TwLK402W3QMG
 A5FQQfhaV/nuuuTGw9Cg68BrdRgkDffwyNmBN40oTNQ//MsMm2A9gVb72tiQ+owEQoG6
 a5GXqDsRcMjYJ2aVap5K79IAGRuAcqLOKg61wP4zeNLKjYeLYnqSDr2cF0RPqv3cvlcx
 bvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727868521; x=1728473321;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bo1UOBTngmAwI3vqiAWjlTIEr2mqJeRsMQkQAW1dQ9U=;
 b=VziTKcl1F6uhDRoa5xS2EqttWxSnNSkP8qUqIkf3RRnRsJQ9RjJ7EZXOeIFMdiduI/
 LTM2OD58QcuaQf0k06b6MG7MZd9vAk6BtnFZ8HeC7F52uTbvEF6HRTn645OSJUxIUYZC
 6AAItNQlSmrkz9BG6Dm3zuXkzXojqKcPKV/07e378rI2d0MTZ5Vyu3B/XAdp4xa+6iwX
 aJ3zceJ3fpjF06VQXNUjkl9SYHdqzu/3YpYGuEyqmKLKGmI2oNcCkztqlynMOugtIlwS
 giXbzhobSmihNmSxQtNCb7PfVxeZ+6O4DyQFXa9gy+mo4jXJbuzdADzryWlfoXjapiop
 ntqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGO1CimWTD5SDrkslvnNU2AQgG7ghf6c82RHqTByO+pmZEz5CAUxe1XZMUIFEY7mZrT1dcmm0Q@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzMH7NTfwGdthSK4FGIjbkUT4xgPPFRjQS11E7iia9PdaNVToQk
 QVVPX26+QBprJERfHR8qTfBg62ckhRnrne58zrqw0DIrccTIEcgQ3mwh+3WY
X-Google-Smtp-Source: AGHT+IExXUecmi+Af5kkzmntOnQyROjc227PJ1qrMk6bn+L7kIDi/Tuw6JEWsS4f7oHDNl8GiWyYpg==
X-Received: by 2002:a5d:58ee:0:b0:37c:cd64:939c with SMTP id
 ffacd0b85a97d-37cfba0791emr1808885f8f.44.1727868520745; 
 Wed, 02 Oct 2024 04:28:40 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cffdd6e92sm878109f8f.16.2024.10.02.04.28.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Oct 2024 04:28:40 -0700 (PDT)
Message-ID: <209c9c2a-1af0-4255-81c9-716658dba516@gmail.com>
Date: Wed, 2 Oct 2024 13:28:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/18] drm/amdgpu/vcn: separate gating state by instance
To: boyuan.zhang@amd.com, amd-gfx@lists.freedesktop.org, leo.liu@amd.com,
 christian.koenig@amd.com, alexander.deucher@amd.com, sunil.khatri@amd.com
References: <20241002043627.102414-1-boyuan.zhang@amd.com>
 <20241002043627.102414-8-boyuan.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20241002043627.102414-8-boyuan.zhang@amd.com>
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

Am 02.10.24 um 06:36 schrieb boyuan.zhang@amd.com:
> From: Boyuan Zhang <boyuan.zhang@amd.com>
>
> vcn gating state should now be based on instance. For example, instance 0
> can be gated while instance 1 is ungated, or vice versa.
>
> Therefore, change the cur_state to be an array, so that it can track the
> gating status for each vcn instance now.
>
> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>

Mhm, some questions. See below.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h   |  2 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c     |  6 ++--
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c     |  8 ++---
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c     | 23 +++++++------
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c     | 38 +++++++++++----------
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c     | 41 ++++++++++++-----------
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c   | 41 +++++++++++++----------
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c   | 23 +++++++------
>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c   | 23 +++++++------
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c |  3 +-
>   10 files changed, 114 insertions(+), 94 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index 2a1f3dbb14d3..f6717f780acd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -308,7 +308,7 @@ struct amdgpu_vcn {
>   	struct delayed_work	idle_work;
>   	const struct firmware	*fw[AMDGPU_MAX_VCN_INSTANCES];	/* VCN firmware */
>   	unsigned		num_enc_rings;
> -	enum amd_powergating_state cur_state;
> +	enum amd_powergating_state cur_state[AMDGPU_MAX_VCN_INSTANCES];
>   	bool			indirect_sram;
>   
>   	uint8_t	num_vcn_inst;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index 6717ff692d8d..bafdd6d5ff24 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -279,7 +279,7 @@ static int vcn_v1_0_hw_fini(void *handle)
>   	cancel_delayed_work_sync(&adev->vcn.idle_work);
>   
>   	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> -		(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> +		(adev->vcn.cur_state[0] != AMD_PG_STATE_GATE &&
>   		 RREG32_SOC15(VCN, 0, mmUVD_STATUS))) {
>   		vcn_v1_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
>   	}
> @@ -1813,7 +1813,7 @@ static int vcn_v1_0_set_powergating_state(void *handle,
>   	int ret;
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> -	if (state == adev->vcn.cur_state)
> +	if (state == adev->vcn.cur_state[0])
>   		return 0;
>   
>   	if (state == AMD_PG_STATE_GATE)
> @@ -1822,7 +1822,7 @@ static int vcn_v1_0_set_powergating_state(void *handle,
>   		ret = vcn_v1_0_start(adev);
>   
>   	if (!ret)
> -		adev->vcn.cur_state = state;
> +		adev->vcn.cur_state[0] = state;
>   	return ret;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index be6998ed56bc..72e36fbaad39 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -316,7 +316,7 @@ static int vcn_v2_0_hw_fini(void *handle)
>   	cancel_delayed_work_sync(&adev->vcn.idle_work);
>   
>   	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> -	    (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> +	    (adev->vcn.cur_state[0] != AMD_PG_STATE_GATE &&
>   	      RREG32_SOC15(VCN, 0, mmUVD_STATUS)))
>   		vcn_v2_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
>   
> @@ -1812,11 +1812,11 @@ static int vcn_v2_0_set_powergating_state(void *handle,
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
>   	if (amdgpu_sriov_vf(adev)) {
> -		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
> +		adev->vcn.cur_state[0] = AMD_PG_STATE_UNGATE;
>   		return 0;
>   	}
>   
> -	if (state == adev->vcn.cur_state)
> +	if (state == adev->vcn.cur_state[0])
>   		return 0;
>   
>   	if (state == AMD_PG_STATE_GATE)
> @@ -1825,7 +1825,7 @@ static int vcn_v2_0_set_powergating_state(void *handle,
>   		ret = vcn_v2_0_start(adev);
>   
>   	if (!ret)
> -		adev->vcn.cur_state = state;
> +		adev->vcn.cur_state[0] = state;
>   	return ret;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index 7ab0314b27ec..09b342ad02cd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -397,9 +397,10 @@ static int vcn_v2_5_hw_fini(void *handle)
>   			continue;
>   
>   		if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> -		    (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> -		     RREG32_SOC15(VCN, i, mmUVD_STATUS)))
> +		    (adev->vcn.cur_state[i] != AMD_PG_STATE_GATE &&
> +		     RREG32_SOC15(VCN, i, mmUVD_STATUS))) {
>   			vcn_v2_5_set_powergating_state(adev, AMD_PG_STATE_GATE);
> +		}
>   
>   		if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
>   			amdgpu_irq_put(adev, &adev->vcn.inst[i].ras_poison_irq, 0);
> @@ -1832,16 +1833,18 @@ static int vcn_v2_5_set_powergating_state(void *handle,
>   	if (amdgpu_sriov_vf(adev))
>   		return 0;
>   
> -	if(state == adev->vcn.cur_state)
> -		return 0;
> +	for (int i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (state == adev->vcn.cur_state[i])
> +			return 0;

Shouldn't this only check the first instance for the HW generations 
which work with only one instance?

Could be that this becomes redundant when the function is called per 
instance later on.

Regards,
Christian.

>   
> -	if (state == AMD_PG_STATE_GATE)
> -		ret = vcn_v2_5_stop(adev);
> -	else
> -		ret = vcn_v2_5_start(adev);
> +		if (state == AMD_PG_STATE_GATE)
> +			ret = vcn_v2_5_stop(adev);
> +		else
> +			ret = vcn_v2_5_start(adev);
>   
> -	if(!ret)
> -		adev->vcn.cur_state = state;
> +		if (!ret)
> +			adev->vcn.cur_state[i] = state;
> +	}
>   
>   	return ret;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index 38452446fcb0..ee9a40443d65 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -430,8 +430,8 @@ static int vcn_v3_0_hw_fini(void *handle)
>   
>   		if (!amdgpu_sriov_vf(adev)) {
>   			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> -					(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> -					 RREG32_SOC15(VCN, i, mmUVD_STATUS))) {
> +				(adev->vcn.cur_state[i] != AMD_PG_STATE_GATE &&
> +				 RREG32_SOC15(VCN, i, mmUVD_STATUS))) {
>   				vcn_v3_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
>   			}
>   		}
> @@ -2163,25 +2163,27 @@ static int vcn_v3_0_set_powergating_state(void *handle,
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   	int ret;
>   
> -	/* for SRIOV, guest should not control VCN Power-gating
> -	 * MMSCH FW should control Power-gating and clock-gating
> -	 * guest should avoid touching CGC and PG
> -	 */
> -	if (amdgpu_sriov_vf(adev)) {
> -		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
> -		return 0;
> -	}
> +	for (int i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		/* for SRIOV, guest should not control VCN Power-gating
> +		* MMSCH FW should control Power-gating and clock-gating
> +		* guest should avoid touching CGC and PG
> +		*/
> +		if (amdgpu_sriov_vf(adev)) {
> +			adev->vcn.cur_state[i] = AMD_PG_STATE_UNGATE;
> +			return 0;
> +		}
>   
> -	if (state == adev->vcn.cur_state)
> -		return 0;
> +		if (state == adev->vcn.cur_state[i])
> +			return 0;
>   
> -	if (state == AMD_PG_STATE_GATE)
> -		ret = vcn_v3_0_stop(adev);
> -	else
> -		ret = vcn_v3_0_start(adev);
> +		if (state == AMD_PG_STATE_GATE)
> +			ret = vcn_v3_0_stop(adev);
> +		else
> +			ret = vcn_v3_0_start(adev);
>   
> -	if (!ret)
> -		adev->vcn.cur_state = state;
> +		if (!ret)
> +			adev->vcn.cur_state[i] = state;
> +	}
>   
>   	return ret;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index 078bb30497e0..aaecc680b631 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -355,11 +355,12 @@ static int vcn_v4_0_hw_fini(void *handle)
>   	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>   		if (adev->vcn.harvest_config & (1 << i))
>   			continue;
> +
>   		if (!amdgpu_sriov_vf(adev)) {
>   			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> -                        (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> -                                RREG32_SOC15(VCN, i, regUVD_STATUS))) {
> -                        vcn_v4_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
> +				(adev->vcn.cur_state[i] != AMD_PG_STATE_GATE &&
> +				 RREG32_SOC15(VCN, i, regUVD_STATUS))) {
> +				vcn_v4_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
>   			}
>   		}
>   		if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
> @@ -2040,25 +2041,27 @@ static int vcn_v4_0_set_powergating_state(void *handle, enum amd_powergating_sta
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   	int ret;
>   
> -	/* for SRIOV, guest should not control VCN Power-gating
> -	 * MMSCH FW should control Power-gating and clock-gating
> -	 * guest should avoid touching CGC and PG
> -	 */
> -	if (amdgpu_sriov_vf(adev)) {
> -		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
> -		return 0;
> -	}
> +	for (int i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		/* for SRIOV, guest should not control VCN Power-gating
> +		* MMSCH FW should control Power-gating and clock-gating
> +		* guest should avoid touching CGC and PG
> +		*/
> +		if (amdgpu_sriov_vf(adev)) {
> +			adev->vcn.cur_state[i] = AMD_PG_STATE_UNGATE;
> +			return 0;
> +		}
>   
> -	if (state == adev->vcn.cur_state)
> -		return 0;
> +		if (state == adev->vcn.cur_state[i])
> +			return 0;
>   
> -	if (state == AMD_PG_STATE_GATE)
> -		ret = vcn_v4_0_stop(adev);
> -	else
> -		ret = vcn_v4_0_start(adev);
> +		if (state == AMD_PG_STATE_GATE)
> +			ret = vcn_v4_0_stop(adev);
> +		else
> +			ret = vcn_v4_0_start(adev);
>   
> -	if (!ret)
> -		adev->vcn.cur_state = state;
> +		if (!ret)
> +			adev->vcn.cur_state[i] = state;
> +	}
>   
>   	return ret;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index be7b0bfba27a..87c04c512357 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -318,8 +318,11 @@ static int vcn_v4_0_3_hw_fini(void *handle)
>   
>   	cancel_delayed_work_sync(&adev->vcn.idle_work);
>   
> -	if (adev->vcn.cur_state != AMD_PG_STATE_GATE)
> -		vcn_v4_0_3_set_powergating_state(adev, AMD_PG_STATE_GATE);
> +	for (int i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->vcn.cur_state[i] != AMD_PG_STATE_GATE) {
> +			vcn_v4_0_3_set_powergating_state(adev, AMD_PG_STATE_GATE);
> +		}
> +	}
>   
>   	return 0;
>   }
> @@ -1627,25 +1630,27 @@ static int vcn_v4_0_3_set_powergating_state(void *handle,
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   	int ret;
>   
> -	/* for SRIOV, guest should not control VCN Power-gating
> -	 * MMSCH FW should control Power-gating and clock-gating
> -	 * guest should avoid touching CGC and PG
> -	 */
> -	if (amdgpu_sriov_vf(adev)) {
> -		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
> -		return 0;
> -	}
> +	for (int i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		/* for SRIOV, guest should not control VCN Power-gating
> +		* MMSCH FW should control Power-gating and clock-gating
> +		* guest should avoid touching CGC and PG
> +		*/
> +		if (amdgpu_sriov_vf(adev)) {
> +			adev->vcn.cur_state[i] = AMD_PG_STATE_UNGATE;
> +			return 0;
> +		}
>   
> -	if (state == adev->vcn.cur_state)
> -		return 0;
> +		if (state == adev->vcn.cur_state[i])
> +			return 0;
>   
> -	if (state == AMD_PG_STATE_GATE)
> -		ret = vcn_v4_0_3_stop(adev);
> -	else
> -		ret = vcn_v4_0_3_start(adev);
> +		if (state == AMD_PG_STATE_GATE)
> +			ret = vcn_v4_0_3_stop(adev);
> +		else
> +			ret = vcn_v4_0_3_start(adev);
>   
> -	if (!ret)
> -		adev->vcn.cur_state = state;
> +		if (!ret)
> +			adev->vcn.cur_state[i] = state;
> +	}
>   
>   	return ret;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index 0e70df04ceb9..2092360e133a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -305,10 +305,11 @@ static int vcn_v4_0_5_hw_fini(void *handle)
>   	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>   		if (adev->vcn.harvest_config & (1 << i))
>   			continue;
> +
>   		if (!amdgpu_sriov_vf(adev)) {
>   			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> -				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> -				RREG32_SOC15(VCN, i, regUVD_STATUS))) {
> +				(adev->vcn.cur_state[i] != AMD_PG_STATE_GATE &&
> +				 RREG32_SOC15(VCN, i, regUVD_STATUS))) {
>   				vcn_v4_0_5_set_powergating_state(adev, AMD_PG_STATE_GATE);
>   			}
>   		}
> @@ -1534,16 +1535,18 @@ static int vcn_v4_0_5_set_powergating_state(void *handle, enum amd_powergating_s
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   	int ret;
>   
> -	if (state == adev->vcn.cur_state)
> -		return 0;
> +	for (int i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (state == adev->vcn.cur_state[i])
> +			return 0;
>   
> -	if (state == AMD_PG_STATE_GATE)
> -		ret = vcn_v4_0_5_stop(adev);
> -	else
> -		ret = vcn_v4_0_5_start(adev);
> +		if (state == AMD_PG_STATE_GATE)
> +			ret = vcn_v4_0_5_stop(adev);
> +		else
> +			ret = vcn_v4_0_5_start(adev);
>   
> -	if (!ret)
> -		adev->vcn.cur_state = state;
> +		if (!ret)
> +			adev->vcn.cur_state[i] = state;
> +	}
>   
>   	return ret;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index 6b38927024d1..045ac9c8d8be 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -269,10 +269,11 @@ static int vcn_v5_0_0_hw_fini(void *handle)
>   	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>   		if (adev->vcn.harvest_config & (1 << i))
>   			continue;
> +
>   		if (!amdgpu_sriov_vf(adev)) {
>   			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> -				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> -				RREG32_SOC15(VCN, i, regUVD_STATUS))) {
> +				(adev->vcn.cur_state[i] != AMD_PG_STATE_GATE &&
> +				 RREG32_SOC15(VCN, i, regUVD_STATUS))) {
>   				vcn_v5_0_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
>   			}
>   		}
> @@ -1261,16 +1262,18 @@ static int vcn_v5_0_0_set_powergating_state(void *handle, enum amd_powergating_s
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   	int ret;
>   
> -	if (state == adev->vcn.cur_state)
> -		return 0;
> +	for (int i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (state == adev->vcn.cur_state[i])
> +			return 0;
>   
> -	if (state == AMD_PG_STATE_GATE)
> -		ret = vcn_v5_0_0_stop(adev);
> -	else
> -		ret = vcn_v5_0_0_start(adev);
> +		if (state == AMD_PG_STATE_GATE)
> +			ret = vcn_v5_0_0_stop(adev);
> +		else
> +			ret = vcn_v5_0_0_start(adev);
>   
> -	if (!ret)
> -		adev->vcn.cur_state = state;
> +		if (!ret)
> +			adev->vcn.cur_state[i] = state;
> +	}
>   
>   	return ret;
>   }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 449925105889..86001682e13e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2112,7 +2112,8 @@ static int smu_hw_fini(void *handle)
>   	smu_dpm_set_vpe_enable(smu, false);
>   	smu_dpm_set_umsch_mm_enable(smu, false);
>   
> -	adev->vcn.cur_state = AMD_PG_STATE_GATE;
> +	for (int i = 0; i < adev->vcn.num_vcn_inst; ++i)
> +		adev->vcn.cur_state[i] = AMD_PG_STATE_GATE;
>   	adev->jpeg.cur_state = AMD_PG_STATE_GATE;
>   
>   	if (!smu->pm_enabled)

