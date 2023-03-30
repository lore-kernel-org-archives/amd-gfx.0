Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A68C6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 06:15:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 637EC10E19B;
	Thu, 30 Mar 2023 06:15:23 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1EB510E19B
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 06:15:21 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id er13so31243951edb.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 23:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680156920;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iSyUVfiBN54GIC1AUWILb6eDFCOmBaid3CGMG4zkqBE=;
 b=lJfgyl3OMgBfV6ZH3gNtKhlPqXg74XT1DYFG64GRlCz8GSGkJfphjuztvWc7R1hTEP
 zxa/yncXzmTzXIKhkB/8rGPzmSMDkmjsoK31Uay7RePJvhE0F78vJlPhFSkMFT7pMOJ1
 lRGz9nFeDpzpuuGJxqdnoihNiE6hsFmmPVxMaRbElnyrMs5ai/oJp03HmwdozCmM0BZm
 MxLKSFO4C4I8mMtJ2RsFtke/bQ4Kk8q7isrMkG/joA8VaU6JTE8u9QSOyYRaIDy0Eeja
 3gMmtQVnUbEG/0RE4uErmE0fXatzZZo+6nBm1o0pqzFwjqw+I3u9cpvOyMtSRTp8Eyn1
 0w/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680156920;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iSyUVfiBN54GIC1AUWILb6eDFCOmBaid3CGMG4zkqBE=;
 b=DW5zT/Aa+R1QsU9T891tZnu6/hEiEhx+qOq1Q0Gi0/4hj5+YHAxee+tpgulZMuy8e0
 Lt88Iz5lhk/dP5VYPOoyb2rC8ojzO5dkfkyrfX+VbnUDzuSXkg+DzPFuzv5QlT9uFrwz
 w6oB2WEFaP9p+LWeK4EgYDCKaFgyxJPjR+tx5C5XfZ8Kbn8XM1RB8DPKYr1K5f79lXGW
 NslWBr8I54z9MI0/yL+T+t7380IsjusvqRidvQejo7eZz/U5nRBZHPq89wTwwLZHAcBu
 TUMrV74b0RSndyIaxPEP4FFFVFs5SqDKTOPZub2aZjoeI2J4PrScphtTj3FS5fm+S8tx
 WP3g==
X-Gm-Message-State: AAQBX9d0UcVm9WteannmsEtCe2hhgbr2A7UvTWMLoV+j2X6G0kTQmcc+
 0+4M1vyfnj1VvXXlTmxaljM=
X-Google-Smtp-Source: AKy350bZFLHf+jAAY5oZH3qSG0BnzG80+5XCg5mDt9ZSceOmrPJpJDJ+D7YlsKiZAeAqeHRygLLmgg==
X-Received: by 2002:a17:906:9f22:b0:933:4556:d1cd with SMTP id
 fy34-20020a1709069f2200b009334556d1cdmr6504778ejc.33.1680156919940; 
 Wed, 29 Mar 2023 23:15:19 -0700 (PDT)
Received: from [192.168.178.21] (p4fc2092b.dip0.t-ipconnect.de. [79.194.9.43])
 by smtp.gmail.com with ESMTPSA id
 sd13-20020a170906ce2d00b008e09deb6610sm17151805ejb.200.2023.03.29.23.15.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Mar 2023 23:15:19 -0700 (PDT)
Message-ID: <5bb62161-7863-4515-5d0c-c92f4be8a631@gmail.com>
Date: Thu, 30 Mar 2023 08:15:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 08/13] drm/amdgpu: add gfx shadow callback
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230329152521.1980681-1-alexander.deucher@amd.com>
 <20230329152521.1980681-9-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230329152521.1980681-9-alexander.deucher@amd.com>
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

Am 29.03.23 um 17:25 schrieb Alex Deucher:
> To provide IP specific shadow sizes.  UMDs will use
> this to query the kernel driver for the size of the
> shadow buffers.
>
> v2: make callback return an int (Alex)
> v3: drop GDS (Alex)
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 4ad9e225d6e6..62047a541c21 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -219,6 +219,13 @@ struct amdgpu_gfx_ras {
>   						struct amdgpu_iv_entry *entry);
>   };
>   
> +struct amdgpu_gfx_shadow_info {
> +	u32 shadow_size;
> +	u32 shadow_alignment;
> +	u32 csa_size;
> +	u32 csa_alignment;
> +};
> +
>   struct amdgpu_gfx_funcs {
>   	/* get the gpu clock counter */
>   	uint64_t (*get_gpu_clock_counter)(struct amdgpu_device *adev);
> @@ -236,6 +243,8 @@ struct amdgpu_gfx_funcs {
>   				 u32 queue, u32 vmid);
>   	void (*init_spm_golden)(struct amdgpu_device *adev);
>   	void (*update_perfmon_mgcg)(struct amdgpu_device *adev, bool enable);
> +	int (*get_gfx_shadow_info)(struct amdgpu_device *adev,
> +				   struct amdgpu_gfx_shadow_info *shadow_info);
>   };
>   
>   struct sq_work {
> @@ -372,6 +381,7 @@ struct amdgpu_gfx {
>   #define amdgpu_gfx_select_se_sh(adev, se, sh, instance) (adev)->gfx.funcs->select_se_sh((adev), (se), (sh), (instance))
>   #define amdgpu_gfx_select_me_pipe_q(adev, me, pipe, q, vmid) (adev)->gfx.funcs->select_me_pipe_q((adev), (me), (pipe), (q), (vmid))
>   #define amdgpu_gfx_init_spm_golden(adev) (adev)->gfx.funcs->init_spm_golden((adev))
> +#define amdgpu_gfx_get_gfx_shadow_info(adev, si) (adev)->gfx.funcs->get_gfx_shadow_info((adev), (si))
>   
>   /**
>    * amdgpu_gfx_create_bitmask - create a bitmask

