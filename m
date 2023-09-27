Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C075E80A8B
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Sep 2023 05:31:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5EE210E466;
	Wed, 27 Sep 2023 05:31:17 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F083310E466
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Sep 2023 05:31:16 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-31fa15f4cc6so9820184f8f.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Sep 2023 22:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695792675; x=1696397475; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j3tb4Ss2D8U7hnR/TIltY4pDBvwxhDMYeUcwjOEdc4g=;
 b=CNhfVjmhUDInDrFmtj7ieVU/xS5dtdflrtSbHbHGQ5iV6SMBG/T34Aw9DXjtEBJB9P
 E95UXCcEU9RPgPn35yD6HPsbcbJ0jUb3oN3m6ZUB/TIO9kCM+mC28WJ875STPnVZ+ivc
 xCT2YoF03Ut/EDSwB88E/yYXPKZ+RxQe08KQHePB1e2zK3YrHehL4kpAjpC0qlQl5y++
 uSoYe9qvhN+jTHKjgQa5h0YOXllC3VPsvCTNmc2q8U+/pRz4+C0/kkS8pnRAmw9agdHF
 ButDgnTE8WbjBJjLUGnerzQCof71ofkWf6A92OietXZ3WkINB2iGd3cnP13tKg3y9M0u
 nebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695792675; x=1696397475;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j3tb4Ss2D8U7hnR/TIltY4pDBvwxhDMYeUcwjOEdc4g=;
 b=oP4ivWcLKYWacBDq7jw9aTJQq3F3TXdJzBkIFjk/p19yNkUnfn+5hJNvcQlswVlU6o
 HlDwHT1Dl2sZswRrNZb4VK4ATbVBa4Qfy9O3AgDXSOZndXW/XymCTkiOF1cjh87AZAfK
 s4Hwe3497ijiJUpAFSkCmxk8/KoowEWADVSqiKoWLMYpMXbnsM+Tbi2CFrvQRbmGtUM5
 7CM2ew6EIoh8RxuuTquXrDuLDm5JsUHaBjwULTeRBsNq6VNuAIMWm9DZgwNyXQDLzK9d
 Q5WDdYm+nmibwheoGT3M12HQfjoEHWqpcGWJ5pkl8SRoAtLMOZuHiCsPjzoDNPfntcV7
 Finw==
X-Gm-Message-State: AOJu0YyGO0Ky2VrOvww0bV+UFJUDpHxAWV95TIaI2Fo1//OJpTJJadHg
 eam4r5OGY5S7gY1Fim/+rGA=
X-Google-Smtp-Source: AGHT+IGWklV7Jl/eN/A+jYHv/ebuc7jtp15zLj32lrSZKzRDWbUUNezZ5tG3Uxx/YmF1HDIwopmwnw==
X-Received: by 2002:a5d:67cd:0:b0:321:63d0:1f0e with SMTP id
 n13-20020a5d67cd000000b0032163d01f0emr791028wrw.20.1695792674884; 
 Tue, 26 Sep 2023 22:31:14 -0700 (PDT)
Received: from [192.168.178.25] ([185.254.126.195])
 by smtp.gmail.com with ESMTPSA id
 z4-20020a05600c220400b003fe61c33df5sm3806200wml.3.2023.09.26.22.31.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Sep 2023 22:31:14 -0700 (PDT)
Message-ID: <7ba44481-5b4e-9de1-bf16-85cd47fb61ca@gmail.com>
Date: Wed, 27 Sep 2023 07:31:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] drm/amdkfd: reduce stack size in
 kfd_topology_add_device()
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230926163938.1013775-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230926163938.1013775-1-alexander.deucher@amd.com>
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
Cc: Arnd Bergmann <arnd@kernel.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 26.09.23 um 18:39 schrieb Alex Deucher:
> kfd_topology.c:2082:1: warning: the frame size of 1440 bytes is larger than 1024 bytes
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2866
> Cc: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Christian König <christian.koenig@amd.com> for the series, but 
Felix probably want to take a look as well.

> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index c8c75ff7cea8..3f9f882d3f5c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1918,7 +1918,7 @@ int kfd_topology_add_device(struct kfd_node *gpu)
>   {
>   	uint32_t gpu_id;
>   	struct kfd_topology_device *dev;
> -	struct kfd_cu_info cu_info;
> +	struct kfd_cu_info *cu_info;
>   	int res = 0;
>   	int i;
>   	const char *asic_name = amdgpu_asic_name[gpu->adev->asic_type];
> @@ -1959,8 +1959,11 @@ int kfd_topology_add_device(struct kfd_node *gpu)
>   	/* Fill-in additional information that is not available in CRAT but
>   	 * needed for the topology
>   	 */
> +	cu_info = kzalloc(sizeof(struct kfd_cu_info), GFP_KERNEL);
> +	if (!cu_info)
> +		return -ENOMEM;
>   
> -	amdgpu_amdkfd_get_cu_info(dev->gpu->adev, &cu_info);
> +	amdgpu_amdkfd_get_cu_info(dev->gpu->adev, cu_info);
>   
>   	for (i = 0; i < KFD_TOPOLOGY_PUBLIC_NAME_SIZE-1; i++) {
>   		dev->node_props.name[i] = __tolower(asic_name[i]);
> @@ -1970,7 +1973,7 @@ int kfd_topology_add_device(struct kfd_node *gpu)
>   	dev->node_props.name[i] = '\0';
>   
>   	dev->node_props.simd_arrays_per_engine =
> -		cu_info.num_shader_arrays_per_engine;
> +		cu_info->num_shader_arrays_per_engine;
>   
>   	dev->node_props.gfx_target_version =
>   				gpu->kfd->device_info.gfx_target_version;
> @@ -2051,7 +2054,7 @@ int kfd_topology_add_device(struct kfd_node *gpu)
>   	 */
>   	if (dev->gpu->adev->asic_type == CHIP_CARRIZO) {
>   		dev->node_props.simd_count =
> -			cu_info.simd_per_cu * cu_info.cu_active_number;
> +			cu_info->simd_per_cu * cu_info->cu_active_number;
>   		dev->node_props.max_waves_per_simd = 10;
>   	}
>   
> @@ -2078,6 +2081,8 @@ int kfd_topology_add_device(struct kfd_node *gpu)
>   
>   	kfd_notify_gpu_change(gpu_id, 1);
>   
> +	kfree(cu_info);
> +
>   	return 0;
>   }
>   

