Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BBD9C4345F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 15:19:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0A8810F68F;
	Thu,  2 May 2024 15:19:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eVXxwzYj";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9470210F9E9
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 15:19:57 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-41c7ac6f635so28092135e9.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 May 2024 08:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714663196; x=1715267996; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7qvBvJuY0VohOFziJdyfZKShbNUE1WNkMPeux6pO5nA=;
 b=eVXxwzYjTeVe406HwI+MqXbfFLYRvOxhwJajM9cEVUAhxU8gtmjMhIThdw9U1xBlbV
 LCK1O4j0esMimpiZzrcVFdIkX16bxszPvXUmn12B/INAatotvBQl+septsFFSlGxxmOK
 5JcpFPbaqPue9m4mcZU2CkXSK3I6Lqgdv0TtwhsN6qN4OFA/WEhCyQVnA0v7i6qOJnO/
 w3aU2WZ21QWu1Gln9QAegkppwsKJmJ6jHTJyFKMdlFE6s/EsA84E6h0HaRTIiNWdn3+d
 97XUUcZ3Jo6IFAf4XtnfJVdzMWJKSE73crm/APChwytFtRpu6GqPUuzlG8YeLjbMRys0
 yBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714663196; x=1715267996;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7qvBvJuY0VohOFziJdyfZKShbNUE1WNkMPeux6pO5nA=;
 b=BbM2tsGlkvKnG8bMR+69kiu+UUPt0CQwU78N+RKzLX+7pg5qCCEjU2AOm4OfQ0Bajv
 4K4UdzEVe1zzFj+psYPmeQPWYiwoFRNuNG2OIgikPn6sHFrDRG2Hswjd0mPl/U63j7C1
 kUz3gAxXL9Kf373CK0IrRHMTOikcjMynEt4NIfqu4I0EgspxRX/78taUvVsmv8njYEel
 xfp66ahaJlHGuXao8ck4VhYfe6F6ZDkWZ51mBFj7G3CDU5cwxYbBnMn4oEWIbQruRbqc
 R0YCPaSeRnL/B4wg6cbOBQmLV2rniKkaZBQFmqF3N7HPqRVO3in+m1WsTU1gECi5HvJp
 BkUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWs4jBoDGk8v8gtJdN8cmSYxmvIOvLgmVo69DlMwqSY7YIdXWJ42xFcZ6C1wOHiAryxx3RkA4o1dLJZlIZh50Vf1FT+TH0wsF1hes23qg==
X-Gm-Message-State: AOJu0Yyy3sarz5BI5+UYc/fjYp5wp1HdtcCuxuRj7QZnBrI/nU4CZJ44
 BLY+VqGNmOjNXRp/XSN4h50VtMTfbv1I9IqWP0cJa8ipyDoi4KDw0LHt8jgt
X-Google-Smtp-Source: AGHT+IH1+mANuUmcm5MmLxC4Rub/dCH2/MyweCuJSa/V/Yh84mIN34xEdYMKqgdURHnm9hQSQ9oTFA==
X-Received: by 2002:a05:600c:4f52:b0:41b:7c07:cfeb with SMTP id
 m18-20020a05600c4f5200b0041b7c07cfebmr26174wmq.40.1714663195682; 
 Thu, 02 May 2024 08:19:55 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 w6-20020a05600c474600b004182b87aaacsm2302599wmo.14.2024.05.02.08.19.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 May 2024 08:19:55 -0700 (PDT)
Message-ID: <9ac9bff9-35eb-4726-a89f-0f72b5989117@gmail.com>
Date: Thu, 2 May 2024 17:19:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 11/14] drm/amdgpu: fix MES GFX mask
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Arvind Yadav <arvind.yadav@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <Christian.Koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20240426134810.1250-1-shashank.sharma@amd.com>
 <20240426134810.1250-12-shashank.sharma@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240426134810.1250-12-shashank.sharma@amd.com>
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

Am 26.04.24 um 15:48 schrieb Shashank Sharma:
> Current MES GFX mask prevents FW to enable oversubscription. This patch
> does the following:
> - Fixes the mask values and adds a description for the same.
> - Removes the central mask setup and makes it IP specific, as it would
>    be different when the number of pipes and queues are different.
>
> V9: introduce this patch in the series

As far as I can see this is a bug fix for existing code and should be 
pushed completely independent of the other work to amd-staging-drm-next.

Regards,
Christian.

>
> Cc: Christian König <Christian.Koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 3 ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 1 -
>   drivers/gpu/drm/amd/amdgpu/mes_v10_1.c  | 9 +++++++--
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 9 +++++++--
>   4 files changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index a00cf4756ad0..b405fafc0b71 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -151,9 +151,6 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>   		adev->mes.compute_hqd_mask[i] = 0xc;
>   	}
>   
> -	for (i = 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++)
> -		adev->mes.gfx_hqd_mask[i] = i ? 0 : 0xfffffffe;
> -
>   	for (i = 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++) {
>   		if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) <
>   		    IP_VERSION(6, 0, 0))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index 4c8fc3117ef8..598556619337 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -110,7 +110,6 @@ struct amdgpu_mes {
>   	uint32_t                        vmid_mask_gfxhub;
>   	uint32_t                        vmid_mask_mmhub;
>   	uint32_t                        compute_hqd_mask[AMDGPU_MES_MAX_COMPUTE_PIPES];
> -	uint32_t                        gfx_hqd_mask[AMDGPU_MES_MAX_GFX_PIPES];
>   	uint32_t                        sdma_hqd_mask[AMDGPU_MES_MAX_SDMA_PIPES];
>   	uint32_t                        aggregated_doorbells[AMDGPU_MES_PRIORITY_NUM_LEVELS];
>   	uint32_t                        sch_ctx_offs;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
> index 1e5ad1e08d2a..4d1121d1a1e7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
> @@ -290,8 +290,13 @@ static int mes_v10_1_set_hw_resources(struct amdgpu_mes *mes)
>   		mes_set_hw_res_pkt.compute_hqd_mask[i] =
>   			mes->compute_hqd_mask[i];
>   
> -	for (i = 0; i < MAX_GFX_PIPES; i++)
> -		mes_set_hw_res_pkt.gfx_hqd_mask[i] = mes->gfx_hqd_mask[i];
> +	/*
> +	 * GFX pipe 0 queue 0 is being used by kernel
> +	 * Set GFX pipe 0 queue 1 for MES scheduling
> +	 * GFX pipe 1 can't be used for MES due to HW limitation.
> +	 */
> +	mes_set_hw_res_pkt.gfx_hqd_mask[0] = 0x2;
> +	mes_set_hw_res_pkt.gfx_hqd_mask[1] = 0;
>   
>   	for (i = 0; i < MAX_SDMA_PIPES; i++)
>   		mes_set_hw_res_pkt.sdma_hqd_mask[i] = mes->sdma_hqd_mask[i];
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index 63f281a9984d..feb7fa2c304c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -387,8 +387,13 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
>   		mes_set_hw_res_pkt.compute_hqd_mask[i] =
>   			mes->compute_hqd_mask[i];
>   
> -	for (i = 0; i < MAX_GFX_PIPES; i++)
> -		mes_set_hw_res_pkt.gfx_hqd_mask[i] = mes->gfx_hqd_mask[i];
> +	/*
> +	 * GFX pipe 0 queue 0 is being used by kernel
> +	 * Set GFX pipe 0 queue 1 for MES scheduling
> +	 * GFX pipe 1 can't be used for MES due to HW limitation.
> +	 */
> +	mes_set_hw_res_pkt.gfx_hqd_mask[0] = 0x2;
> +	mes_set_hw_res_pkt.gfx_hqd_mask[1] = 0;
>   
>   	for (i = 0; i < MAX_SDMA_PIPES; i++)
>   		mes_set_hw_res_pkt.sdma_hqd_mask[i] = mes->sdma_hqd_mask[i];

