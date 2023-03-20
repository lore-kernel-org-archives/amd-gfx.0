Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC911C77B60
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Mar 2023 15:57:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 684D910E5DF;
	Mon, 20 Mar 2023 15:57:57 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B5ED10E2DD
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Mar 2023 15:57:56 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id r29so10827413wra.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Mar 2023 08:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1679327874;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6c030WDoQG2I1dMmOX4l9Hz+n1tz6XM6hoC7E/5bP4g=;
 b=iBazN77N9LPSTdSh8mrlg3u+ztLKIpmqmT7gAX+2P+vGDdW0pYGamUTbC0ba6+W1rv
 I7qS/rOt8Hk0pCOP6AH8w9X6+iAUAb6hQwItijmUz/r0DQB0l/5oMGLdyD3USr7VYoa7
 Iu57QbGRHqVpVf+TcGE0WTzUYy6ge27bzF6UQtFoskB0jo43nHLB3v/7yJF2AUZGakvj
 OsfaK7kTXKenWDRmIokNuQkGYrAD/XUqQWe9PYe1AMXiUx5udx1VEcQ9393jExy5w+FT
 PbsXxZomZuBLw5TlAjiKN+RPt2ookNmSJ1FxL/o7TzbNlvfNG2GMpnrm9mk8gaqkwbLv
 QzJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679327874;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6c030WDoQG2I1dMmOX4l9Hz+n1tz6XM6hoC7E/5bP4g=;
 b=dPgFCCT4KmXkwV8kkrBqJFejNW/fOzAYrIbCSNXXpAJ+cVHVdmkUCzUAZIvIRv6CQl
 7U58f5aKtmX7iolg/CeJZuqpA3r2f0izyzw+X1/4T1/bZmEDnVdtXEHBfRVSEjpIdvA3
 bIoRb1nSO5VGjdeTBBNKW8DQs6h38txH7SSuGxhJHZLqgQaAysZ2Wh9URC/ppZrKynFT
 qUH2eGRCNpBgrIuaw34bv1waZOW/bTAfBAwRJHAWnP0GfsT7DhUZW8eKN1kyASaKF/Q/
 pPwafBkhLWGxADhCyfK7G4Xbem0bzyKzV6BsR5UvqNsRK7AhRjOzyrhAgoKcnHDPYGPe
 keQg==
X-Gm-Message-State: AO0yUKWP5wax9k5k1xDYoUx7Ik+Y746gqhsqkmiEFvRP7utweZYKpiWk
 x2DNFiJueccowOpA5iP4zBy9K0tavig=
X-Google-Smtp-Source: AK7set/V4t+524mWCy2nG747DKzVzJZZCovNuAa8KLH1IZGRj4f1Y4SmmuywgkDNFgIWQ5DYEBa76Q==
X-Received: by 2002:a5d:4c81:0:b0:2c5:67e3:808d with SMTP id
 z1-20020a5d4c81000000b002c567e3808dmr9308747wrs.35.1679327874534; 
 Mon, 20 Mar 2023 08:57:54 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:fae3:596:f1a7:6853?
 ([2a02:908:1256:79a0:fae3:596:f1a7:6853])
 by smtp.gmail.com with ESMTPSA id
 u8-20020adfdb88000000b002cff06039d7sm9216063wri.39.2023.03.20.08.57.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Mar 2023 08:57:54 -0700 (PDT)
Message-ID: <fd529eb8-2070-320f-27bf-371ac294c574@gmail.com>
Date: Mon, 20 Mar 2023 16:57:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 07/10] drm/amdgpu: add gfx shadow callback
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230317171748.682691-1-alexander.deucher@amd.com>
 <20230317171748.682691-8-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230317171748.682691-8-alexander.deucher@amd.com>
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

Am 17.03.23 um 18:17 schrieb Alex Deucher:
> To provide IP specific shadow sizes.  UMDs will use
> this to query the kernel driver for the size of the
> shadow buffers.
>
> v2: make callback return an int (Alex)
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 4ad9e225d6e6..8826f1efc75f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -219,6 +219,15 @@ struct amdgpu_gfx_ras {
>   						struct amdgpu_iv_entry *entry);
>   };
>   
> +struct amdgpu_gfx_shadow_info {
> +	u32 shadow_size;
> +	u32 shadow_alignment;
> +	u32 csa_size;
> +	u32 csa_alignment;
> +	u32 gds_size;
> +	u32 gds_alignment;

I don't think we need an alignment for those. Otherwise we would run 
into problems with the VA mappings as well.

Regards,
Christian.

> +};
> +
>   struct amdgpu_gfx_funcs {
>   	/* get the gpu clock counter */
>   	uint64_t (*get_gpu_clock_counter)(struct amdgpu_device *adev);
> @@ -236,6 +245,8 @@ struct amdgpu_gfx_funcs {
>   				 u32 queue, u32 vmid);
>   	void (*init_spm_golden)(struct amdgpu_device *adev);
>   	void (*update_perfmon_mgcg)(struct amdgpu_device *adev, bool enable);
> +	int (*get_gfx_shadow_info)(struct amdgpu_device *adev,
> +				   struct amdgpu_gfx_shadow_info *shadow_info);
>   };
>   
>   struct sq_work {
> @@ -372,6 +383,7 @@ struct amdgpu_gfx {
>   #define amdgpu_gfx_select_se_sh(adev, se, sh, instance) (adev)->gfx.funcs->select_se_sh((adev), (se), (sh), (instance))
>   #define amdgpu_gfx_select_me_pipe_q(adev, me, pipe, q, vmid) (adev)->gfx.funcs->select_me_pipe_q((adev), (me), (pipe), (q), (vmid))
>   #define amdgpu_gfx_init_spm_golden(adev) (adev)->gfx.funcs->init_spm_golden((adev))
> +#define amdgpu_gfx_get_gfx_shadow_info(adev, si) (adev)->gfx.funcs->get_gfx_shadow_info((adev), (si))
>   
>   /**
>    * amdgpu_gfx_create_bitmask - create a bitmask

