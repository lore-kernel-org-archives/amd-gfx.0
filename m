Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07532EB64D7
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jun 2023 13:17:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7CFD10E1F8;
	Mon, 26 Jun 2023 13:17:09 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC44D10E1F8
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jun 2023 13:17:07 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-313df030ccaso2905982f8f.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jun 2023 06:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687785424; x=1690377424;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e3LHDLUsakyzMwlaMnxNS8n0HrOwS+AYkmqIldSW+z0=;
 b=VQOA6BRxcOcvht8/WXK6QUaclouWhc27kLoH86hB51oFazl0eNcaXJvfhMdFop0wDo
 bLI8e6Ce8pGVxF3SlUskkwIIZW6wquV9u5Ye5VTcxnPBBNG3AE53nmtxJMsoOUEGYMQs
 9c3J/TtRLxjTjUv+SOpHVQsGQszjLscBGC7iuvG4xEqBOKhqoF7po1sPnubxkLgNddpD
 CaqKRLU1xWrcwGD4e2I23kZl+4k7tspypSbPFOy8KODKNEcy3FidpiOiYGEpo8I/GXNX
 Vs8imzg/+wWFr0VCI8PrZoj6MoTTqmANEU2Zpi58U48e2kx5PqGqtXWWbIXFMDZ0hup5
 PpPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687785424; x=1690377424;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e3LHDLUsakyzMwlaMnxNS8n0HrOwS+AYkmqIldSW+z0=;
 b=WcihTAHiHQxd92f8aOjR8PNbnsz3O61iSTS29UT5vm5WZTn++EF/CAf2QvhOG/dGJP
 SN2BtVWjQCFIO6nPNQLL3DhsbvzBP5T5TPz2eei283lXEwNyBuWzyhMgMlKofvOZnM0g
 82REdf6El8s8fMS4lMr79V8GcsHA0AOvbbP8FutFfXTQicTOXIeHC5bUeoSivEq8h9BQ
 Ec7EIoG7SgfizJgGi7qTXN1C9owuakNTtV1YqluTDSXWpcR1zhU95WPvvnH10SDrttVK
 ZscZGIn/hqK/uIznAIpIbglV8qCe7Z84cGi0VBO7fslzSBPaDk8WLTO09UANin6GVEzT
 plGw==
X-Gm-Message-State: AC+VfDwkfQCe7mbnA6B2fi4BBx1NoPgyK0ifhGrieSfqI5duuvV/AxK/
 G97FIyRcJuJvHn3SaHDZnrw=
X-Google-Smtp-Source: ACHHUZ4IVSB9AMqe0fuAZLgPb2svG43995yNPL+i/8w2KC6tfnhejLrirGmHVh3oJhviId3T3HMYLA==
X-Received: by 2002:adf:ec45:0:b0:30f:af06:7320 with SMTP id
 w5-20020adfec45000000b0030faf067320mr11003562wrn.23.1687785424149; 
 Mon, 26 Jun 2023 06:17:04 -0700 (PDT)
Received: from ?IPV6:2a00:e180:158d:7600:d62f:c4fb:6eee:7b87?
 ([2a00:e180:158d:7600:d62f:c4fb:6eee:7b87])
 by smtp.gmail.com with ESMTPSA id
 bf11-20020a0560001ccb00b003062b2c5255sm7369447wrb.40.2023.06.26.06.17.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 06:17:03 -0700 (PDT)
Message-ID: <ffcac6b3-c35b-1f62-50d2-715f806a0707@gmail.com>
Date: Mon, 26 Jun 2023 15:17:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] Revert "drm/amdgpu: Enable VM_CONTEXT1_CNTL after page
 table addr is set."
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230531143906.3472425-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230531143906.3472425-1-alexander.deucher@amd.com>
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
Cc: Zibin Liu <ghostfly23333@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 31.05.23 um 16:39 schrieb Alex Deucher:
> This reverts commit f57a74f5b42d1627bd5366f88952d42819e91146.
>
> After talking this over with Christian, the original programming
> sequence was correct.  The enable bit needs to be set before
> programming the rest of the context.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Zibin Liu <ghostfly23333@gmail.com>

Sorry for the delay, I'm only catching up to mails from lost month by now.

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c   | 5 +----
>   drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c   | 5 +----
>   drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c   | 5 +----
>   drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c   | 5 +----
>   drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c   | 5 +----
>   drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c | 5 +----
>   drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c    | 5 +----
>   drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c    | 5 +----
>   drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c    | 6 +-----
>   drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c    | 5 +----
>   drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c    | 5 +----
>   drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c    | 5 +----
>   drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c  | 5 +----
>   drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c  | 5 +----
>   drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c    | 7 +------
>   15 files changed, 15 insertions(+), 63 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> index 52a1e79ee4d8..d94cc1ec7242 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> @@ -261,7 +261,7 @@ static void gfxhub_v1_0_setup_vmid_config(struct amdgpu_device *adev)
>   
>   	for (i = 0; i <= 14; i++) {
>   		tmp = RREG32_SOC15_OFFSET(GC, 0, mmVM_CONTEXT1_CNTL, i);
> -		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 0);
> +		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
>   		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
>   				    num_level);
>   		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
> @@ -302,9 +302,6 @@ static void gfxhub_v1_0_setup_vmid_config(struct amdgpu_device *adev)
>   		WREG32_SOC15_OFFSET(GC, 0, mmVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
>   				    i * hub->ctx_addr_distance,
>   				    upper_32_bits(adev->vm_manager.max_pfn - 1));
> -		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
> -		WREG32_SOC15_OFFSET(GC, 0, mmVM_CONTEXT1_CNTL,
> -				    i * hub->ctx_distance, tmp);
>   	}
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> index 108674f6eef0..4dabf910334b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> @@ -330,7 +330,7 @@ static void gfxhub_v1_2_xcc_setup_vmid_config(struct amdgpu_device *adev,
>   		hub = &adev->vmhub[AMDGPU_GFXHUB(j)];
>   		for (i = 0; i <= 14; i++) {
>   			tmp = RREG32_SOC15_OFFSET(GC, GET_INST(GC, j), regVM_CONTEXT1_CNTL, i);
> -			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 0);
> +			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
>   			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
>   					    num_level);
>   			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
> @@ -377,9 +377,6 @@ static void gfxhub_v1_2_xcc_setup_vmid_config(struct amdgpu_device *adev,
>   					    regVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
>   					    i * hub->ctx_addr_distance,
>   					    upper_32_bits(adev->vm_manager.max_pfn - 1));
> -			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
> -			WREG32_SOC15_OFFSET(GC, GET_INST(GC, j), regVM_CONTEXT1_CNTL,
> -					    i * hub->ctx_distance, tmp);
>   		}
>   	}
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> index 502cb6e1fe84..f173a61c6c15 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> @@ -288,7 +288,7 @@ static void gfxhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
>   
>   	for (i = 0; i <= 14; i++) {
>   		tmp = RREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_CNTL, i);
> -		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 0);
> +		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
>   		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
>   				    adev->vm_manager.num_level);
>   		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
> @@ -324,9 +324,6 @@ static void gfxhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
>   		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
>   				    i * hub->ctx_addr_distance,
>   				    upper_32_bits(adev->vm_manager.max_pfn - 1));
> -		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
> -		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_CNTL,
> -				    i * hub->ctx_distance, tmp);
>   	}
>   
>   	hub->vm_cntx_cntl = tmp;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> index c5dbd5af23f0..d8fc3e8088cd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> @@ -297,7 +297,7 @@ static void gfxhub_v2_1_setup_vmid_config(struct amdgpu_device *adev)
>   
>   	for (i = 0; i <= 14; i++) {
>   		tmp = RREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_CNTL, i);
> -		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 0);
> +		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
>   		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
>   				    adev->vm_manager.num_level);
>   		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
> @@ -333,9 +333,6 @@ static void gfxhub_v2_1_setup_vmid_config(struct amdgpu_device *adev)
>   		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
>   				    i * hub->ctx_addr_distance,
>   				    upper_32_bits(adev->vm_manager.max_pfn - 1));
> -		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
> -		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_CNTL,
> -				    i * hub->ctx_distance, tmp);
>   	}
>   
>   	hub->vm_cntx_cntl = tmp;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
> index d7f86a6834a1..c53147f9c9fc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
> @@ -296,7 +296,7 @@ static void gfxhub_v3_0_setup_vmid_config(struct amdgpu_device *adev)
>   
>   	for (i = 0; i <= 14; i++) {
>   		tmp = RREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_CNTL, i);
> -		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 0);
> +		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
>   		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
>   				    adev->vm_manager.num_level);
>   		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
> @@ -332,9 +332,6 @@ static void gfxhub_v3_0_setup_vmid_config(struct amdgpu_device *adev)
>   		WREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
>   				    i * hub->ctx_addr_distance,
>   				    upper_32_bits(adev->vm_manager.max_pfn - 1));
> -		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
> -		WREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_CNTL,
> -				    i * hub->ctx_distance, tmp);
>   	}
>   
>   	hub->vm_cntx_cntl = tmp;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
> index 3371597a7280..ae777487d72e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
> @@ -301,7 +301,7 @@ static void gfxhub_v3_0_3_setup_vmid_config(struct amdgpu_device *adev)
>   
>   	for (i = 0; i <= 14; i++) {
>   		tmp = RREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_CNTL, i);
> -		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 0);
> +		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
>   		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
>   				    adev->vm_manager.num_level);
>   		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
> @@ -337,9 +337,6 @@ static void gfxhub_v3_0_3_setup_vmid_config(struct amdgpu_device *adev)
>   		WREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
>   				    i * hub->ctx_addr_distance,
>   				    upper_32_bits(adev->vm_manager.max_pfn - 1));
> -		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
> -		WREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_CNTL,
> -				    i * hub->ctx_distance, tmp);
>   	}
>   
>   	hub->vm_cntx_cntl = tmp;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> index 22070a379140..fb91b31056ca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> @@ -243,7 +243,7 @@ static void mmhub_v1_0_setup_vmid_config(struct amdgpu_device *adev)
>   
>   	for (i = 0; i <= 14; i++) {
>   		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, mmVM_CONTEXT1_CNTL, i);
> -		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 0);
> +		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
>   		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
>   				    num_level);
>   		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
> @@ -280,9 +280,6 @@ static void mmhub_v1_0_setup_vmid_config(struct amdgpu_device *adev)
>   		WREG32_SOC15_OFFSET(MMHUB, 0, mmVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
>   				    i * hub->ctx_addr_distance,
>   				    upper_32_bits(adev->vm_manager.max_pfn - 1));
> -		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
> -		WREG32_SOC15_OFFSET(MMHUB, 0, mmVM_CONTEXT1_CNTL,
> -				    i * hub->ctx_distance, tmp);
>   	}
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
> index f746981a7d4e..9086f2fdfaf4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
> @@ -275,7 +275,7 @@ static void mmhub_v1_7_setup_vmid_config(struct amdgpu_device *adev)
>   
>   	for (i = 0; i <= 14; i++) {
>   		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT1_CNTL, i);
> -		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 0);
> +		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
>   		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
>   				    num_level);
>   		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
> @@ -314,9 +314,6 @@ static void mmhub_v1_7_setup_vmid_config(struct amdgpu_device *adev)
>   		WREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
>   				    i * hub->ctx_addr_distance,
>   				    upper_32_bits(adev->vm_manager.max_pfn - 1));
> -		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
> -		WREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT1_CNTL,
> -				    i * hub->ctx_distance, tmp);
>   	}
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> index 618019caca8e..5e8b493f8699 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> @@ -346,7 +346,7 @@ static void mmhub_v1_8_setup_vmid_config(struct amdgpu_device *adev)
>   			tmp = RREG32_SOC15_OFFSET(MMHUB, j, regVM_CONTEXT1_CNTL,
>   						  i);
>   			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
> -					    ENABLE_CONTEXT, 0);
> +					    ENABLE_CONTEXT, 1);
>   			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
>   					    PAGE_TABLE_DEPTH, num_level);
>   			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
> @@ -388,10 +388,6 @@ static void mmhub_v1_8_setup_vmid_config(struct amdgpu_device *adev)
>   				regVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
>   				i * hub->ctx_addr_distance,
>   				upper_32_bits(adev->vm_manager.max_pfn - 1));
> -			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
> -					    ENABLE_CONTEXT, 1);
> -			WREG32_SOC15_OFFSET(MMHUB, j, regVM_CONTEXT1_CNTL,
> -					    i * hub->ctx_distance, tmp);
>   		}
>   	}
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> index d4b9796389cf..8f76c6ecf50a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> @@ -368,7 +368,7 @@ static void mmhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
>   
>   	for (i = 0; i <= 14; i++) {
>   		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_CNTL, i);
> -		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 0);
> +		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
>   		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
>   				    adev->vm_manager.num_level);
>   		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
> @@ -405,9 +405,6 @@ static void mmhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
>   		WREG32_SOC15_OFFSET_RLC(MMHUB, 0, mmMMVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
>   				    i * hub->ctx_addr_distance,
>   				    upper_32_bits(adev->vm_manager.max_pfn - 1));
> -		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
> -		WREG32_SOC15_OFFSET_RLC(MMHUB, 0, mmMMVM_CONTEXT1_CNTL,
> -				    i * hub->ctx_distance, tmp);
>   	}
>   
>   	hub->vm_cntx_cntl = tmp;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
> index d9d5e698060e..8bd0fc8d9d25 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
> @@ -286,7 +286,7 @@ static void mmhub_v2_3_setup_vmid_config(struct amdgpu_device *adev)
>   
>   	for (i = 0; i <= 14; i++) {
>   		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_CNTL, i);
> -		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 0);
> +		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
>   		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
>   				    adev->vm_manager.num_level);
>   		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
> @@ -323,9 +323,6 @@ static void mmhub_v2_3_setup_vmid_config(struct amdgpu_device *adev)
>   		WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
>   				    i * hub->ctx_addr_distance,
>   				    upper_32_bits(adev->vm_manager.max_pfn - 1));
> -		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
> -		WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_CNTL,
> -				    i * hub->ctx_distance, tmp);
>   	}
>   
>   	hub->vm_cntx_cntl = tmp;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
> index a18b61a39866..441379e91cfa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
> @@ -325,7 +325,7 @@ static void mmhub_v3_0_setup_vmid_config(struct amdgpu_device *adev)
>   
>   	for (i = 0; i <= 14; i++) {
>   		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL, i);
> -		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 0);
> +		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
>   		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
>   				    adev->vm_manager.num_level);
>   		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
> @@ -362,9 +362,6 @@ static void mmhub_v3_0_setup_vmid_config(struct amdgpu_device *adev)
>   		WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
>   				    i * hub->ctx_addr_distance,
>   				    upper_32_bits(adev->vm_manager.max_pfn - 1));
> -		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
> -		WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL,
> -				    i * hub->ctx_distance, tmp);
>   	}
>   
>   	hub->vm_cntx_cntl = tmp;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
> index 92e86bc64bcb..12c7f4b46ea9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
> @@ -312,7 +312,7 @@ static void mmhub_v3_0_1_setup_vmid_config(struct amdgpu_device *adev)
>   
>   	for (i = 0; i <= 14; i++) {
>   		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL, i);
> -		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 0);
> +		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
>   		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
>   				    adev->vm_manager.num_level);
>   		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
> @@ -349,9 +349,6 @@ static void mmhub_v3_0_1_setup_vmid_config(struct amdgpu_device *adev)
>   		WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
>   				    i * hub->ctx_addr_distance,
>   				    upper_32_bits(adev->vm_manager.max_pfn - 1));
> -		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
> -		WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL,
> -				    i * hub->ctx_distance, tmp);
>   	}
>   
>   	hub->vm_cntx_cntl = tmp;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
> index 0f01ead6d105..5dadc85abf7e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
> @@ -317,7 +317,7 @@ static void mmhub_v3_0_2_setup_vmid_config(struct amdgpu_device *adev)
>   
>   	for (i = 0; i <= 14; i++) {
>   		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL, i);
> -		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 0);
> +		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
>   		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
>   				    adev->vm_manager.num_level);
>   		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
> @@ -354,9 +354,6 @@ static void mmhub_v3_0_2_setup_vmid_config(struct amdgpu_device *adev)
>   		WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
>   				    i * hub->ctx_addr_distance,
>   				    upper_32_bits(adev->vm_manager.max_pfn - 1));
> -		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
> -		WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL,
> -				    i * hub->ctx_distance, tmp);
>   	}
>   
>   	hub->vm_cntx_cntl = tmp;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> index 18391a0fdf0c..e790f890aec6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> @@ -310,7 +310,7 @@ static void mmhub_v9_4_setup_vmid_config(struct amdgpu_device *adev, int hubid)
>   		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, mmVML2VC0_VM_CONTEXT1_CNTL,
>   				hubid * MMHUB_INSTANCE_REGISTER_OFFSET + i);
>   		tmp = REG_SET_FIELD(tmp, VML2VC0_VM_CONTEXT1_CNTL,
> -				    ENABLE_CONTEXT, 0);
> +				    ENABLE_CONTEXT, 1);
>   		tmp = REG_SET_FIELD(tmp, VML2VC0_VM_CONTEXT1_CNTL,
>   				    PAGE_TABLE_DEPTH,
>   				    num_level);
> @@ -357,11 +357,6 @@ static void mmhub_v9_4_setup_vmid_config(struct amdgpu_device *adev, int hubid)
>   				hubid * MMHUB_INSTANCE_REGISTER_OFFSET +
>   				i * hub->ctx_addr_distance,
>   				upper_32_bits(adev->vm_manager.max_pfn - 1));
> -		tmp = REG_SET_FIELD(tmp, VML2VC0_VM_CONTEXT1_CNTL,
> -				    ENABLE_CONTEXT, 1);
> -		WREG32_SOC15_OFFSET(MMHUB, 0, mmVML2VC0_VM_CONTEXT1_CNTL,
> -				    hubid * MMHUB_INSTANCE_REGISTER_OFFSET +
> -				    i * hub->ctx_distance, tmp);
>   	}
>   }
>   

