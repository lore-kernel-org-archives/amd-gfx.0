Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A938C678D4
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Mar 2023 14:07:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A974B10E28E;
	Mon,  6 Mar 2023 14:07:36 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD42410E25E
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Mar 2023 14:07:34 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 j19-20020a05600c191300b003eb3e1eb0caso8274552wmq.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Mar 2023 06:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1678111653;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UuM0IkwD2jbpcrUZ8EOJxICtizGy1JOFZO36deiy+fw=;
 b=nE23LUIJZF4hQ2YBS5gCYB9t6a4bK4opuFFua2yl0C1j8WmXLN6Dl0uNSc9aqNQ3pZ
 appc19b2ENdcW2xo2/k2VGvaPQZ6mayO6d5zcL3hLx8Q7FgLPX4QoH0VGs1wNSSO9/DT
 Rc6p8Ff49GztgVn4AXrjhdDFOp9++E4Q4s0R0On93VhYCW4Idlj/kp3q+LfyhZootH1Z
 SkZrBC4I2Ugm4CfLcazEMMkAKmdTXmTejJVfeR8WGR4cA1Dsr1LC3f2NsLm9fJ2aDoJ1
 TRR5iqqp/Htq/J5MpYFGFRX96oMEOlGwlv8yx+iV0foNlem76MzgQcgfnBtv8eUs9BBR
 hfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678111653;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UuM0IkwD2jbpcrUZ8EOJxICtizGy1JOFZO36deiy+fw=;
 b=3zeD1HfH8ES0UURr1j1G06c8lMGI/oGW4N0sZ+gSXSr8PCgnQ/WiNH+pLTGZtaHFrl
 f2RWaPrtSaz2PE1N8GK6wE7OKfXC+gFwnCCyMLq8Wm9A1QGFwrAG8X7y1qphihwIOlcT
 M9O5Vd8AP/rIS3xz0Gunw9uay9pUvhjAlyfmJbbB+uXnLAntXzLDl+c34pX6eZ2dbRjD
 AksUt92qgQ82q6S1BMb3M7jSl9u49G7n/ltHRgyoRyFhPfpKGMkuvUI/1BdN5UXGKJtd
 ZBpZlW1iVa3qOwj3mpkwzE30O57sOhNS0HiK9EZvoUYHwDarY6P3KeoP91bi2iulMLz3
 YSng==
X-Gm-Message-State: AO0yUKUVrC2StYQvjdtFQP5yvHFj98qMBnzJtkasGzcRMv+ZxX/zi04U
 JfpZeK3tmCc+KNLpwbDOJZ97itwJiTY=
X-Google-Smtp-Source: AK7set+kzLj+QDOSaqb0KhgNcR8P9u9IhKyXumo1BYz7L7PyUeXr6EPtV01vv/sqE77UYvDP88yMgw==
X-Received: by 2002:a05:600c:3148:b0:3dc:1687:9ba2 with SMTP id
 h8-20020a05600c314800b003dc16879ba2mr9714024wmo.35.1678111653013; 
 Mon, 06 Mar 2023 06:07:33 -0800 (PST)
Received: from [192.168.178.21] (p5b0ea2e7.dip0.t-ipconnect.de.
 [91.14.162.231]) by smtp.gmail.com with ESMTPSA id
 m1-20020a05600c4f4100b003e01493b136sm15119235wmq.43.2023.03.06.06.07.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Mar 2023 06:07:32 -0800 (PST)
Message-ID: <58be79b5-3e2b-6009-9e65-6cbbe670ae22@gmail.com>
Date: Mon, 6 Mar 2023 15:07:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] drm/amdgpu: Move to common indirect reg access helper
Content-Language: en-US
To: Hawking Zhang <Hawking.Zhang@amd.com>, amd-gfx@lists.freedesktop.org,
 Likun Gao <Likun.Gao@amd.com>
References: <20230306080401.20501-1-Hawking.Zhang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230306080401.20501-1-Hawking.Zhang@amd.com>
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

Am 06.03.23 um 09:04 schrieb Hawking Zhang:
> Replace soc15, nv, soc21 specific callbacks with common
> one. so we don't need to duplicate code when introduce
> new asics.

Nice cleanup. Is pcie_rreg/pcie_wreg/... now still set to anything else 
than the common functions? If not we might also remove the callback.

> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  4 --
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 32 +++++++-------
>   drivers/gpu/drm/amd/amdgpu/nv.c            | 49 ++--------------------
>   drivers/gpu/drm/amd/amdgpu/soc15.c         | 49 ++--------------------
>   drivers/gpu/drm/amd/amdgpu/soc21.c         | 48 ++-------------------
>   5 files changed, 30 insertions(+), 152 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 07e846510005..9387731afb8b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1142,16 +1142,12 @@ void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value)
>   uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset);
>   
>   u32 amdgpu_device_indirect_rreg(struct amdgpu_device *adev,
> -				u32 pcie_index, u32 pcie_data,
>   				u32 reg_addr);
>   u64 amdgpu_device_indirect_rreg64(struct amdgpu_device *adev,
> -				  u32 pcie_index, u32 pcie_data,
>   				  u32 reg_addr);
>   void amdgpu_device_indirect_wreg(struct amdgpu_device *adev,
> -				 u32 pcie_index, u32 pcie_data,
>   				 u32 reg_addr, u32 reg_data);
>   void amdgpu_device_indirect_wreg64(struct amdgpu_device *adev,
> -				   u32 pcie_index, u32 pcie_data,
>   				   u32 reg_addr, u64 reg_data);
>   
>   bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 77e6c8bf7190..b1b815dc69b3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -676,20 +676,20 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
>    * amdgpu_device_indirect_rreg - read an indirect register
>    *
>    * @adev: amdgpu_device pointer
> - * @pcie_index: mmio register offset
> - * @pcie_data: mmio register offset
>    * @reg_addr: indirect register address to read from
>    *
>    * Returns the value of indirect register @reg_addr
>    */
>   u32 amdgpu_device_indirect_rreg(struct amdgpu_device *adev,
> -				u32 pcie_index, u32 pcie_data,
>   				u32 reg_addr)
>   {
> -	unsigned long flags;
> -	u32 r;
> +	unsigned long flags, pcie_index, pcie_data;
>   	void __iomem *pcie_index_offset;
>   	void __iomem *pcie_data_offset;
> +	u32 r;
> +
> +	pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
> +	pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
>   
>   	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
>   	pcie_index_offset = (void __iomem *)adev->rmmio + pcie_index * 4;
> @@ -707,20 +707,20 @@ u32 amdgpu_device_indirect_rreg(struct amdgpu_device *adev,
>    * amdgpu_device_indirect_rreg64 - read a 64bits indirect register
>    *
>    * @adev: amdgpu_device pointer
> - * @pcie_index: mmio register offset
> - * @pcie_data: mmio register offset
>    * @reg_addr: indirect register address to read from
>    *
>    * Returns the value of indirect register @reg_addr
>    */
>   u64 amdgpu_device_indirect_rreg64(struct amdgpu_device *adev,
> -				  u32 pcie_index, u32 pcie_data,
>   				  u32 reg_addr)
>   {
> -	unsigned long flags;
> -	u64 r;
> +	unsigned long flags, pcie_index, pcie_data;
>   	void __iomem *pcie_index_offset;
>   	void __iomem *pcie_data_offset;
> +	u64 r;
> +
> +	pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
> +	pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
>   
>   	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
>   	pcie_index_offset = (void __iomem *)adev->rmmio + pcie_index * 4;
> @@ -750,13 +750,15 @@ u64 amdgpu_device_indirect_rreg64(struct amdgpu_device *adev,
>    *
>    */
>   void amdgpu_device_indirect_wreg(struct amdgpu_device *adev,
> -				 u32 pcie_index, u32 pcie_data,
>   				 u32 reg_addr, u32 reg_data)
>   {
> -	unsigned long flags;
> +	unsigned long flags, pcie_index, pcie_data;
>   	void __iomem *pcie_index_offset;
>   	void __iomem *pcie_data_offset;
>   
> +	pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
> +	pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
> +
>   	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
>   	pcie_index_offset = (void __iomem *)adev->rmmio + pcie_index * 4;
>   	pcie_data_offset = (void __iomem *)adev->rmmio + pcie_data * 4;
> @@ -779,13 +781,15 @@ void amdgpu_device_indirect_wreg(struct amdgpu_device *adev,
>    *
>    */
>   void amdgpu_device_indirect_wreg64(struct amdgpu_device *adev,
> -				   u32 pcie_index, u32 pcie_data,
>   				   u32 reg_addr, u64 reg_data)
>   {
> -	unsigned long flags;
> +	unsigned long flags, pcie_index, pcie_data;
>   	void __iomem *pcie_index_offset;
>   	void __iomem *pcie_data_offset;
>   
> +	pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
> +	pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
> +
>   	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
>   	pcie_index_offset = (void __iomem *)adev->rmmio + pcie_index * 4;
>   	pcie_data_offset = (void __iomem *)adev->rmmio + pcie_data * 4;
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index d972025f0d20..60c10132ed32 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -280,47 +280,6 @@ static int nv_query_video_codecs(struct amdgpu_device *adev, bool encode,
>   	}
>   }
>   
> -/*
> - * Indirect registers accessor
> - */
> -static u32 nv_pcie_rreg(struct amdgpu_device *adev, u32 reg)
> -{
> -	unsigned long address, data;
> -	address = adev->nbio.funcs->get_pcie_index_offset(adev);
> -	data = adev->nbio.funcs->get_pcie_data_offset(adev);
> -
> -	return amdgpu_device_indirect_rreg(adev, address, data, reg);
> -}
> -
> -static void nv_pcie_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
> -{
> -	unsigned long address, data;
> -
> -	address = adev->nbio.funcs->get_pcie_index_offset(adev);
> -	data = adev->nbio.funcs->get_pcie_data_offset(adev);
> -
> -	amdgpu_device_indirect_wreg(adev, address, data, reg, v);
> -}
> -
> -static u64 nv_pcie_rreg64(struct amdgpu_device *adev, u32 reg)
> -{
> -	unsigned long address, data;
> -	address = adev->nbio.funcs->get_pcie_index_offset(adev);
> -	data = adev->nbio.funcs->get_pcie_data_offset(adev);
> -
> -	return amdgpu_device_indirect_rreg64(adev, address, data, reg);
> -}
> -
> -static void nv_pcie_wreg64(struct amdgpu_device *adev, u32 reg, u64 v)
> -{
> -	unsigned long address, data;
> -
> -	address = adev->nbio.funcs->get_pcie_index_offset(adev);
> -	data = adev->nbio.funcs->get_pcie_data_offset(adev);
> -
> -	amdgpu_device_indirect_wreg64(adev, address, data, reg, v);
> -}
> -
>   static u32 nv_didt_rreg(struct amdgpu_device *adev, u32 reg)
>   {
>   	unsigned long flags, address, data;
> @@ -737,10 +696,10 @@ static int nv_common_early_init(void *handle)
>   	}
>   	adev->smc_rreg = NULL;
>   	adev->smc_wreg = NULL;
> -	adev->pcie_rreg = &nv_pcie_rreg;
> -	adev->pcie_wreg = &nv_pcie_wreg;
> -	adev->pcie_rreg64 = &nv_pcie_rreg64;
> -	adev->pcie_wreg64 = &nv_pcie_wreg64;
> +	adev->pcie_rreg = &amdgpu_device_indirect_rreg;
> +	adev->pcie_wreg = &amdgpu_device_indirect_wreg;
> +	adev->pcie_rreg64 = &amdgpu_device_indirect_rreg64;
> +	adev->pcie_wreg64 = &amdgpu_device_indirect_wreg64;
>   	adev->pciep_rreg = amdgpu_device_pcie_port_rreg;
>   	adev->pciep_wreg = amdgpu_device_pcie_port_wreg;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 7cd17dda32ce..6392d10e6eaf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -191,47 +191,6 @@ static int soc15_query_video_codecs(struct amdgpu_device *adev, bool encode,
>   	}
>   }
>   
> -/*
> - * Indirect registers accessor
> - */
> -static u32 soc15_pcie_rreg(struct amdgpu_device *adev, u32 reg)
> -{
> -	unsigned long address, data;
> -	address = adev->nbio.funcs->get_pcie_index_offset(adev);
> -	data = adev->nbio.funcs->get_pcie_data_offset(adev);
> -
> -	return amdgpu_device_indirect_rreg(adev, address, data, reg);
> -}
> -
> -static void soc15_pcie_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
> -{
> -	unsigned long address, data;
> -
> -	address = adev->nbio.funcs->get_pcie_index_offset(adev);
> -	data = adev->nbio.funcs->get_pcie_data_offset(adev);
> -
> -	amdgpu_device_indirect_wreg(adev, address, data, reg, v);
> -}
> -
> -static u64 soc15_pcie_rreg64(struct amdgpu_device *adev, u32 reg)
> -{
> -	unsigned long address, data;
> -	address = adev->nbio.funcs->get_pcie_index_offset(adev);
> -	data = adev->nbio.funcs->get_pcie_data_offset(adev);
> -
> -	return amdgpu_device_indirect_rreg64(adev, address, data, reg);
> -}
> -
> -static void soc15_pcie_wreg64(struct amdgpu_device *adev, u32 reg, u64 v)
> -{
> -	unsigned long address, data;
> -
> -	address = adev->nbio.funcs->get_pcie_index_offset(adev);
> -	data = adev->nbio.funcs->get_pcie_data_offset(adev);
> -
> -	amdgpu_device_indirect_wreg64(adev, address, data, reg, v);
> -}
> -
>   static u32 soc15_uvd_ctx_rreg(struct amdgpu_device *adev, u32 reg)
>   {
>   	unsigned long flags, address, data;
> @@ -935,10 +894,10 @@ static int soc15_common_early_init(void *handle)
>   	}
>   	adev->smc_rreg = NULL;
>   	adev->smc_wreg = NULL;
> -	adev->pcie_rreg = &soc15_pcie_rreg;
> -	adev->pcie_wreg = &soc15_pcie_wreg;
> -	adev->pcie_rreg64 = &soc15_pcie_rreg64;
> -	adev->pcie_wreg64 = &soc15_pcie_wreg64;
> +	adev->pcie_rreg = &amdgpu_device_indirect_rreg;
> +	adev->pcie_wreg = &amdgpu_device_indirect_wreg;
> +	adev->pcie_rreg64 = &amdgpu_device_indirect_rreg64;
> +	adev->pcie_wreg64 = &amdgpu_device_indirect_wreg64;
>   	adev->uvd_ctx_rreg = &soc15_uvd_ctx_rreg;
>   	adev->uvd_ctx_wreg = &soc15_uvd_ctx_wreg;
>   	adev->didt_rreg = &soc15_didt_rreg;
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
> index 78bd598d286f..9d91e20a22bb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -127,46 +127,6 @@ static int soc21_query_video_codecs(struct amdgpu_device *adev, bool encode,
>   		return -EINVAL;
>   	}
>   }
> -/*
> - * Indirect registers accessor
> - */
> -static u32 soc21_pcie_rreg(struct amdgpu_device *adev, u32 reg)
> -{
> -	unsigned long address, data;
> -	address = adev->nbio.funcs->get_pcie_index_offset(adev);
> -	data = adev->nbio.funcs->get_pcie_data_offset(adev);
> -
> -	return amdgpu_device_indirect_rreg(adev, address, data, reg);
> -}
> -
> -static void soc21_pcie_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
> -{
> -	unsigned long address, data;
> -
> -	address = adev->nbio.funcs->get_pcie_index_offset(adev);
> -	data = adev->nbio.funcs->get_pcie_data_offset(adev);
> -
> -	amdgpu_device_indirect_wreg(adev, address, data, reg, v);
> -}
> -
> -static u64 soc21_pcie_rreg64(struct amdgpu_device *adev, u32 reg)
> -{
> -	unsigned long address, data;
> -	address = adev->nbio.funcs->get_pcie_index_offset(adev);
> -	data = adev->nbio.funcs->get_pcie_data_offset(adev);
> -
> -	return amdgpu_device_indirect_rreg64(adev, address, data, reg);
> -}
> -
> -static void soc21_pcie_wreg64(struct amdgpu_device *adev, u32 reg, u64 v)
> -{
> -	unsigned long address, data;
> -
> -	address = adev->nbio.funcs->get_pcie_index_offset(adev);
> -	data = adev->nbio.funcs->get_pcie_data_offset(adev);
> -
> -	amdgpu_device_indirect_wreg64(adev, address, data, reg, v);
> -}
>   
>   static u32 soc21_didt_rreg(struct amdgpu_device *adev, u32 reg)
>   {
> @@ -581,10 +541,10 @@ static int soc21_common_early_init(void *handle)
>   	adev->rmmio_remap.bus_addr = adev->rmmio_base + MMIO_REG_HOLE_OFFSET;
>   	adev->smc_rreg = NULL;
>   	adev->smc_wreg = NULL;
> -	adev->pcie_rreg = &soc21_pcie_rreg;
> -	adev->pcie_wreg = &soc21_pcie_wreg;
> -	adev->pcie_rreg64 = &soc21_pcie_rreg64;
> -	adev->pcie_wreg64 = &soc21_pcie_wreg64;
> +	adev->pcie_rreg = &amdgpu_device_indirect_rreg;
> +	adev->pcie_wreg = &amdgpu_device_indirect_wreg;
> +	adev->pcie_rreg64 = &amdgpu_device_indirect_rreg64;
> +	adev->pcie_wreg64 = &amdgpu_device_indirect_wreg64;
>   	adev->pciep_rreg = amdgpu_device_pcie_port_rreg;
>   	adev->pciep_wreg = amdgpu_device_pcie_port_wreg;
>   

