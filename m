Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 216D0E7C4D0
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 15:15:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8421610E38A;
	Wed,  4 Oct 2023 15:15:56 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2325810E38A
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 15:15:54 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-32157c8e4c7so2231498f8f.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Oct 2023 08:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696432552; x=1697037352; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e3LcVfalqcOTFc5eb+M4/ztP7lQTpDYvHJGrg01x+So=;
 b=K863JGs6DKb9lz43kPSM+kauwz6dKLoBOpf6NZa4jcy+u88/w3GDMS67VWyIql0RRk
 1G8F+uKzbVC+tuOxXsHrNmFT9mWKdtSdqufPz12h5QuuxcVRI7w0Dz6FtYPKvEpY42l3
 ztz9WtyBKX4OHEvh1iaEWSdksTvPujIy4ofI710gudS9yEXCcav02b9RVsGkL4o0ZFp+
 osuYNk0vxqQKP0Q33zRvb5wSN5YCDX5ohS720fdkh9E83PgR6gN7gkk0sQ7Zng05iuDV
 mM0CiGNEQEoIdel2ExMO0WJJKF+HHmPLKCcFfJaZE085FN7HhJDXJ0hEuszdOQ4oU/KH
 ADRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696432552; x=1697037352;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e3LcVfalqcOTFc5eb+M4/ztP7lQTpDYvHJGrg01x+So=;
 b=gpZ3/5KiR/qyHZ1Tu0548sy3Mr+j9OmyVjDyXbWTvOS2QJ0pI/2JHe0KccM+yY+vp5
 MMzXwem/+zwg7wwECn6ESxEj8EXjAoquDDZPy6W+GCf7rsJ3W0gb3QAwC5S3uWdxaBTM
 /qqcrcaITXPdys0HTxk1m7rsqRhBcbIu1G5W/un5v/kkOQi6UL5S6DnAizDtHWz9FOUx
 Pz7QZUfE0qpRO9KNvIobnxcuwhGG+qkWa07TbW+yELqhYXAs+yJWmuhKiDsHCrum6utg
 Q31NNreBBGRgcdT8vaihgVVCvQbAPUvef4ICwo+Uz4NxK5CNuUEylU6lyTSvTQEnp9xK
 xOxA==
X-Gm-Message-State: AOJu0YznQ2tgi56b1coDPu/aIgK6+t92YFM6yPwfYPkVmJyyFMQKCxvj
 ETqFEg38SPpeiKS9jGGNpjDEPaARyBaqzA==
X-Google-Smtp-Source: AGHT+IFH0P6naFc+W75qJa0N2GHgdJyr9cwcIrgiUeqTr+AxVdhtl7YsHygPR3z2fsCMvFSVpRROrw==
X-Received: by 2002:a05:6000:1b08:b0:31f:d4ad:544c with SMTP id
 f8-20020a0560001b0800b0031fd4ad544cmr2524198wrz.52.1696432551963; 
 Wed, 04 Oct 2023 08:15:51 -0700 (PDT)
Received: from [10.254.108.106] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 e7-20020a5d5307000000b003217c096c1esm4232478wrv.73.2023.10.04.08.15.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 08:15:51 -0700 (PDT)
Message-ID: <d4d504be-f3dd-43dd-ba94-b5bb6c2f5380@gmail.com>
Date: Wed, 4 Oct 2023 17:15:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Enable SMU 13.0.0 optimizations when ROCm is
 active
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231003190731.106594-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20231003190731.106594-1-alexander.deucher@amd.com>
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

Am 03.10.23 um 21:07 schrieb Alex Deucher:
> When ROCm is active enable additional SMU 13.0.0 optimizations.
> This reuses the unused powersave profile on PMFW.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 38b5457baded..b6c0c42de725 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -714,6 +714,14 @@ void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool idle)
>   	amdgpu_dpm_switch_power_profile(adev,
>   					PP_SMC_POWER_PROFILE_COMPUTE,
>   					!idle);
> +	/* Add optimizations for SMU13.0.0.  Reuse the power saving profile */
> +	if ((amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 0)) &&
> +	    ((adev->pm.fw_version == 0x004e6601) ||
> +	     (adev->pm.fw_version >= 0x004e7300))) {
> +		amdgpu_dpm_switch_power_profile(adev,
> +						PP_SMC_POWER_PROFILE_POWERSAVING,
> +						!idle);
> +	}
>   }
>   
>   bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid)

