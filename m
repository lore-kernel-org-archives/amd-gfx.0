Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E42CC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 30 May 2022 07:11:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4E8E10E7C5;
	Mon, 30 May 2022 07:11:48 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAEE910E730
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 May 2022 07:11:47 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id v19so4948296edd.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 May 2022 00:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=qZOLddaoEw3KCHZh7GaMMVOdAPLLyDKox4A49/M1ONI=;
 b=by3E4mKvsCAbf4Sp7sVfxeynFBoHxEuCeoMj5/n+5RYcvqajrS8qpt6ZJ2zR9nIwHy
 mpc1nFA/XvcW9dSGV69JWfBN9Mmk0TpWs3y6kBsxTkWZmupObhmvH6Snz5iJ2ERoXsTX
 0/cZZSoTkQ+zGpRdEdVe3tFp/yd+9vi/92TYsHJoWCHvElol+hgDHdIC3QWpAOXU4NJx
 FnOJm98VMDpNNjlEC1pzdRge4EBpAutK2vJ6SJcJfGxwCaz7IjuYmjNyPeO5usVWpfnm
 8QD43T0OOQZdpqTe6kas1oKcmhUxDh2KRM8odSpBc4HpgGmIhRETC/iTQd9f27xwLQX0
 UB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=qZOLddaoEw3KCHZh7GaMMVOdAPLLyDKox4A49/M1ONI=;
 b=7KoSeNUqBN/N1wEo+i/S3doEKKw32Ldr+l8EnSEI08E+fosbjt/nvMcCFXOKUCgebs
 G7dAejdjdFw8vn0GOkjuMcKeiiRic6s10uf5gAHFfqi01oTVwBVm1BEB3JTeqfA5qNEp
 TeYoBLYP4fkwmkLKgu5HiVjDliWNlcObcI7sNdXyK4ZMWivc8OYQEq4zkAB1aok+0bzl
 vIlEDBm/YKftxNmd/F60ZKUI6w9Z35KVd2axfEZch0dlJR/sAvzITef0FsqPdwLgNc2b
 HRHUCsdZA2cjrnGBEL4hCAKu5bnzAAaMcDK5G4ZXOw7MLjQ5vXZpRMvfuG3GfLM+8Sl2
 4Q/g==
X-Gm-Message-State: AOAM530QMNxE/iYshe/sWU2hw6SFM5Jle0k/iBCdQ13GlEJr1UaBpN+/
 iatQN9kFQfj0Zo2ozCPbo9Q=
X-Google-Smtp-Source: ABdhPJyNPsFP5BwsB0NBYPuNYEO4QzOLB5iPedMRFxRkpqdck/sL5HusuojmS3aDJhzbnp+Q1vWb5w==
X-Received: by 2002:a05:6402:31fa:b0:42d:cd6d:c8fd with SMTP id
 dy26-20020a05640231fa00b0042dcd6dc8fdmr5829144edb.347.1653894706349; 
 Mon, 30 May 2022 00:11:46 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea17a.dip0.t-ipconnect.de.
 [91.14.161.122]) by smtp.gmail.com with ESMTPSA id
 x5-20020a170906804500b006fed99e1143sm3734325ejw.61.2022.05.30.00.11.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 May 2022 00:11:45 -0700 (PDT)
Message-ID: <a32cfe57-cb97-b411-35e6-46141ee9e739@gmail.com>
Date: Mon, 30 May 2022 09:11:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amdgpu: suppress compile warnings
Content-Language: en-US
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220530065032.677498-1-evan.quan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220530065032.677498-1-evan.quan@amd.com>
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
Cc: Alexander.Deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 30.05.22 um 08:50 schrieb Evan Quan:
> Suppress the compile warnings below:
>
> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:1407:12: warning:
> stack frame size (1040) exceeds limit (1024) in 'smu_v13_0_7_get_power_profile_mode' [-Wframe-larger-than]
> drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:1986:6: warning:
> no previous prototype for function 'gfx_v11_0_rlc_stop' [-Wmissing-prototypes]
>
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: I679436c91cb98afb9fcbef8942fd90a17e5234b5
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c               |  2 +-
>   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 12 ++++++++++--
>   2 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 8c0a3fc7aaa6..cb581cfc7464 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1983,7 +1983,7 @@ static int gfx_v11_0_init_csb(struct amdgpu_device *adev)
>   	return 0;
>   }
>   
> -void gfx_v11_0_rlc_stop(struct amdgpu_device *adev)
> +static void gfx_v11_0_rlc_stop(struct amdgpu_device *adev)
>   {
>   	u32 tmp = RREG32_SOC15(GC, 0, regRLC_CNTL);
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index 4e1861fb2c6a..8fd7652ae883 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -1406,7 +1406,7 @@ static int smu_v13_0_7_get_power_limit(struct smu_context *smu,
>   
>   static int smu_v13_0_7_get_power_profile_mode(struct smu_context *smu, char *buf)
>   {
> -	DpmActivityMonitorCoeffIntExternal_t activity_monitor_external[PP_SMC_POWER_PROFILE_COUNT];
> +	DpmActivityMonitorCoeffIntExternal_t *activity_monitor_external;
>   	uint32_t i, j, size = 0;
>   	int16_t workload_type = 0;
>   	int result = 0;
> @@ -1414,6 +1414,11 @@ static int smu_v13_0_7_get_power_profile_mode(struct smu_context *smu, char *buf
>   	if (!buf)
>   		return -EINVAL;
>   
> +	activity_monitor_external = kzalloc(sizeof(DpmActivityMonitorCoeffIntExternal_t) * PP_SMC_POWER_PROFILE_COUNT,
> +					    GFP_KERNEL);

The static checkers will warn about that as well. Please use 
kcalloc(sizeof(...), count, GFP_KERNEL);

Apart from that looks good to me.

Regards,
Christian.

> +	if (!activity_monitor_external)
> +		return -ENOMEM;
> +
>   	size += sysfs_emit_at(buf, size, "                              ");
>   	for (i = 0; i <= PP_SMC_POWER_PROFILE_WINDOW3D; i++)
>   		size += sysfs_emit_at(buf, size, "%-14s%s", amdgpu_pp_profile_name[i],
> @@ -1426,14 +1431,17 @@ static int smu_v13_0_7_get_power_profile_mode(struct smu_context *smu, char *buf
>   		workload_type = smu_cmn_to_asic_specific_index(smu,
>   							       CMN2ASIC_MAPPING_WORKLOAD,
>   							       i);
> -		if (workload_type < 0)
> +		if (workload_type < 0) {
> +			kfree(activity_monitor_external);
>   			return -EINVAL;
> +		}
>   
>   		result = smu_cmn_update_table(smu,
>   					  SMU_TABLE_ACTIVITY_MONITOR_COEFF, workload_type,
>   					  (void *)(&activity_monitor_external[i]), false);
>   		if (result) {
>   			dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
> +			kfree(activity_monitor_external);
>   			return result;
>   		}
>   	}

