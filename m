Return-Path: <SRS0=8zgd=GH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C039CC433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Jan 2021 11:40:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58C5F21D79
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Jan 2021 11:40:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58C5F21D79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B6A189B38;
	Mon,  4 Jan 2021 11:40:36 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3C3389B4D
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Jan 2021 11:40:34 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id cw27so27014286edb.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Jan 2021 03:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=upMIWoJVSSELgkryH6Gyrp5NHWaD194lNsb6DfYSLt8=;
 b=qyW8lXoAsvj7HhTm/Iujsf6F+/7kmn1HtTsv22ZaiPARBB1ZGaHpCpspcA677SqN5f
 Y98dNVsnBG/wFsLYJCGes9IwSRxyfe0A/yiYbP9WuNXz1wHmR7jsEO4PSY5NVgEcC+GE
 sjpFiwhk8CnRbyDLEhJ5iH2gdvcC3J6e1K24x19TtU6ihWbHo94SvGq8nOEO2VNZ4Ogc
 EYXabFLTrFmF+6F/qCcV4nd5pUmqLA0ACOQhh5WWCzpI8U/E6q/D+odMTUM2qKePMsA9
 Yuka06W9XZq+06lEc5XFW6as0sSG1R6PjOfMYALvBEE8cjGqV6IbXaVYs7BUaqxtpMHz
 RlcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=upMIWoJVSSELgkryH6Gyrp5NHWaD194lNsb6DfYSLt8=;
 b=dy2a14gBhOsshGqCXj4j7leXxdDR972E3VIEKj/mR9+GnLMYf4wS4twyRwZZ5Ugmvb
 uFam7zWoJJEH6RJBCEQqa/BTQd59w9lMPlq5fqV48q3N/rtq3TEYBLvT1dTDff7nuCC4
 CIn6L8KFerLUf6LdES5MWWPpFttOxvLOTxmuOMpO19oKeAyflAoApRcXT/Hu/GiWnupZ
 sfo6ufRgHjlX3uecaXclTeEpE0rab5/vLmRRJ0d6/yfluVfXa6pNujHFTem2bOclWoMZ
 0ljoDUdsh+UKK/RKbvY1Z498uzt762L66FXpeQicJmKVH+ODir1kHin5kpZqeWnXiy12
 Ni+A==
X-Gm-Message-State: AOAM530ogvJoiAfm/aDf3xFP47bqgOggkAz00QunP9y/5iVxfhPX12Fh
 5OGEc6+LP6W28JdmV0aAUGw=
X-Google-Smtp-Source: ABdhPJzgfdKpzykhGcjRJruDZqDSCeKt9JDrB9PpjnsbbGwKFOJFCDwQbJM7KheAGOpqMOjKTLS9Lg==
X-Received: by 2002:a50:cdc8:: with SMTP id h8mr71612965edj.293.1609760433236; 
 Mon, 04 Jan 2021 03:40:33 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id j23sm30151262edv.45.2021.01.04.03.40.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Jan 2021 03:40:32 -0800 (PST)
Subject: Re: [PATCH 5/5] drm/amdgpu: remove redundant logic related HDP
To: Likun Gao <likun.gao@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201228091834.3240927-1-likun.gao@amd.com>
 <20201228091834.3240927-5-likun.gao@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <4d5202ed-f0ca-34e1-8a9d-a68ce167e05b@gmail.com>
Date: Mon, 4 Jan 2021 12:40:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201228091834.3240927-5-likun.gao@amd.com>
Content-Language: en-US
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
Reply-To: christian.koenig@amd.com
Cc: Hawking Zhang <hawking.zhang@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Looks like a nice cleanup to me.

Just one question: We have a flush_hdp and invalidate_hdp callback in 
the asic structure as well.

Would it make sense to replace those as well in the long term?

Thanks,
Christian.

Am 28.12.20 um 10:18 schrieb Likun Gao:
> From: Likun Gao <Likun.Gao@amd.com>
>
> Remove hdp_flush function from amdgpu_nbio struct as it have been unfied
> into hdp struct.
> Remove the include about hdp register which was not used.
>
> Signed-off-by: Likun Gao <Likun.Gao@amd.com>
> Change-Id: I7b1ce7424a97efe82ccb6ce63505e724530715ac
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h |  1 -
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    |  1 -
>   drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c   | 10 ----------
>   drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c   | 13 -------------
>   drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c   | 10 ----------
>   drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c   | 10 ----------
>   drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c   | 10 ----------
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   |  1 -
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   |  1 -
>   drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c    |  1 -
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    |  1 -
>   11 files changed, 59 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
> index e62cc0e1a5ad..4ba0024aedf1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
> @@ -57,7 +57,6 @@ struct amdgpu_nbio_funcs {
>   	u32 (*get_pcie_port_data_offset)(struct amdgpu_device *adev);
>   	u32 (*get_rev_id)(struct amdgpu_device *adev);
>   	void (*mc_access_enable)(struct amdgpu_device *adev, bool enable);
> -	void (*hdp_flush)(struct amdgpu_device *adev, struct amdgpu_ring *ring);
>   	u32 (*get_memsize)(struct amdgpu_device *adev);
>   	void (*sdma_doorbell_range)(struct amdgpu_device *adev, int instance,
>   			bool use_doorbell, int doorbell_index, int doorbell_size);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 5f4805e4d04a..a896e3d0fcf8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -38,7 +38,6 @@
>   #include "gc/gc_9_0_sh_mask.h"
>   
>   #include "vega10_enum.h"
> -#include "hdp/hdp_4_0_offset.h"
>   
>   #include "soc15_common.h"
>   #include "clearstate_gfx9.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
> index b5c3db16c2b0..b860f1c7b5b1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
> @@ -80,15 +80,6 @@ static void nbio_v2_3_mc_access_enable(struct amdgpu_device *adev, bool enable)
>   		WREG32_SOC15(NBIO, 0, mmBIF_FB_EN, 0);
>   }
>   
> -static void nbio_v2_3_hdp_flush(struct amdgpu_device *adev,
> -				struct amdgpu_ring *ring)
> -{
> -	if (!ring || !ring->funcs->emit_wreg)
> -		WREG32_NO_KIQ((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
> -	else
> -		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
> -}
> -
>   static u32 nbio_v2_3_get_memsize(struct amdgpu_device *adev)
>   {
>   	return RREG32_SOC15(NBIO, 0, mmRCC_DEV0_EPF0_RCC_CONFIG_MEMSIZE);
> @@ -366,7 +357,6 @@ const struct amdgpu_nbio_funcs nbio_v2_3_funcs = {
>   	.get_pcie_data_offset = nbio_v2_3_get_pcie_data_offset,
>   	.get_rev_id = nbio_v2_3_get_rev_id,
>   	.mc_access_enable = nbio_v2_3_mc_access_enable,
> -	.hdp_flush = nbio_v2_3_hdp_flush,
>   	.get_memsize = nbio_v2_3_get_memsize,
>   	.sdma_doorbell_range = nbio_v2_3_sdma_doorbell_range,
>   	.vcn_doorbell_range = nbio_v2_3_vcn_doorbell_range,
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
> index d2f1fe55d388..8427f10712ff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
> @@ -50,18 +50,6 @@ static void nbio_v6_1_mc_access_enable(struct amdgpu_device *adev, bool enable)
>   		WREG32_SOC15(NBIO, 0, mmBIF_FB_EN, 0);
>   }
>   
> -static void nbio_v6_1_hdp_flush(struct amdgpu_device *adev,
> -				struct amdgpu_ring *ring)
> -{
> -	if (!ring || !ring->funcs->emit_wreg)
> -		WREG32_SOC15_NO_KIQ(NBIO, 0,
> -				    mmBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL,
> -				    0);
> -	else
> -		amdgpu_ring_emit_wreg(ring, SOC15_REG_OFFSET(
> -			NBIO, 0, mmBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL), 0);
> -}
> -
>   static u32 nbio_v6_1_get_memsize(struct amdgpu_device *adev)
>   {
>   	return RREG32_SOC15(NBIO, 0, mmRCC_PF_0_0_RCC_CONFIG_MEMSIZE);
> @@ -266,7 +254,6 @@ const struct amdgpu_nbio_funcs nbio_v6_1_funcs = {
>   	.get_pcie_data_offset = nbio_v6_1_get_pcie_data_offset,
>   	.get_rev_id = nbio_v6_1_get_rev_id,
>   	.mc_access_enable = nbio_v6_1_mc_access_enable,
> -	.hdp_flush = nbio_v6_1_hdp_flush,
>   	.get_memsize = nbio_v6_1_get_memsize,
>   	.sdma_doorbell_range = nbio_v6_1_sdma_doorbell_range,
>   	.enable_doorbell_aperture = nbio_v6_1_enable_doorbell_aperture,
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
> index ae685813c419..3c00666a13e1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
> @@ -60,15 +60,6 @@ static void nbio_v7_0_mc_access_enable(struct amdgpu_device *adev, bool enable)
>   		WREG32_SOC15(NBIO, 0, mmBIF_FB_EN, 0);
>   }
>   
> -static void nbio_v7_0_hdp_flush(struct amdgpu_device *adev,
> -				struct amdgpu_ring *ring)
> -{
> -	if (!ring || !ring->funcs->emit_wreg)
> -		WREG32_NO_KIQ((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
> -	else
> -		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
> -}
> -
>   static u32 nbio_v7_0_get_memsize(struct amdgpu_device *adev)
>   {
>   	return RREG32_SOC15(NBIO, 0, mmRCC_CONFIG_MEMSIZE);
> @@ -292,7 +283,6 @@ const struct amdgpu_nbio_funcs nbio_v7_0_funcs = {
>   	.get_pcie_data_offset = nbio_v7_0_get_pcie_data_offset,
>   	.get_rev_id = nbio_v7_0_get_rev_id,
>   	.mc_access_enable = nbio_v7_0_mc_access_enable,
> -	.hdp_flush = nbio_v7_0_hdp_flush,
>   	.get_memsize = nbio_v7_0_get_memsize,
>   	.sdma_doorbell_range = nbio_v7_0_sdma_doorbell_range,
>   	.vcn_doorbell_range = nbio_v7_0_vcn_doorbell_range,
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
> index aa36022670f9..598ce0e93627 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
> @@ -56,15 +56,6 @@ static void nbio_v7_2_mc_access_enable(struct amdgpu_device *adev, bool enable)
>   		WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN, 0);
>   }
>   
> -static void nbio_v7_2_hdp_flush(struct amdgpu_device *adev,
> -				struct amdgpu_ring *ring)
> -{
> -	if (!ring || !ring->funcs->emit_wreg)
> -		WREG32_NO_KIQ((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
> -	else
> -		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
> -}
> -
>   static u32 nbio_v7_2_get_memsize(struct amdgpu_device *adev)
>   {
>   	return RREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF0_0_RCC_CONFIG_MEMSIZE);
> @@ -325,7 +316,6 @@ const struct amdgpu_nbio_funcs nbio_v7_2_funcs = {
>   	.get_pcie_port_data_offset = nbio_v7_2_get_pcie_port_data_offset,
>   	.get_rev_id = nbio_v7_2_get_rev_id,
>   	.mc_access_enable = nbio_v7_2_mc_access_enable,
> -	.hdp_flush = nbio_v7_2_hdp_flush,
>   	.get_memsize = nbio_v7_2_get_memsize,
>   	.sdma_doorbell_range = nbio_v7_2_sdma_doorbell_range,
>   	.vcn_doorbell_range = nbio_v7_2_vcn_doorbell_range,
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> index eadc9526d33f..4bc1d1434065 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> @@ -82,15 +82,6 @@ static void nbio_v7_4_mc_access_enable(struct amdgpu_device *adev, bool enable)
>   		WREG32_SOC15(NBIO, 0, mmBIF_FB_EN, 0);
>   }
>   
> -static void nbio_v7_4_hdp_flush(struct amdgpu_device *adev,
> -				struct amdgpu_ring *ring)
> -{
> -	if (!ring || !ring->funcs->emit_wreg)
> -		WREG32_NO_KIQ((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
> -	else
> -		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
> -}
> -
>   static u32 nbio_v7_4_get_memsize(struct amdgpu_device *adev)
>   {
>   	return RREG32_SOC15(NBIO, 0, mmRCC_CONFIG_MEMSIZE);
> @@ -541,7 +532,6 @@ const struct amdgpu_nbio_funcs nbio_v7_4_funcs = {
>   	.get_pcie_data_offset = nbio_v7_4_get_pcie_data_offset,
>   	.get_rev_id = nbio_v7_4_get_rev_id,
>   	.mc_access_enable = nbio_v7_4_mc_access_enable,
> -	.hdp_flush = nbio_v7_4_hdp_flush,
>   	.get_memsize = nbio_v7_4_get_memsize,
>   	.sdma_doorbell_range = nbio_v7_4_sdma_doorbell_range,
>   	.vcn_doorbell_range = nbio_v7_4_vcn_doorbell_range,
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index ce56e93c6886..c8c22c1d1e65 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -46,7 +46,6 @@
>   #include "sdma6/sdma6_4_2_2_sh_mask.h"
>   #include "sdma7/sdma7_4_2_2_offset.h"
>   #include "sdma7/sdma7_4_2_2_sh_mask.h"
> -#include "hdp/hdp_4_0_offset.h"
>   #include "sdma0/sdma0_4_1_default.h"
>   
>   #include "soc15_common.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> index b208b81005bb..d345e324837d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -32,7 +32,6 @@
>   
>   #include "gc/gc_10_1_0_offset.h"
>   #include "gc/gc_10_1_0_sh_mask.h"
> -#include "hdp/hdp_5_0_0_offset.h"
>   #include "ivsrcid/sdma0/irqsrcs_sdma0_5_0.h"
>   #include "ivsrcid/sdma1/irqsrcs_sdma1_5_0.h"
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> index 312ecf6d24a0..7cd67cb2ac5f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> @@ -36,7 +36,6 @@
>   #include "vce/vce_4_0_default.h"
>   #include "vce/vce_4_0_sh_mask.h"
>   #include "nbif/nbif_6_1_offset.h"
> -#include "hdp/hdp_4_0_offset.h"
>   #include "mmhub/mmhub_1_0_offset.h"
>   #include "mmhub/mmhub_1_0_sh_mask.h"
>   #include "ivsrcid/uvd/irqsrcs_uvd_7_0.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index c734e31a9e65..6117931fa8d7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -32,7 +32,6 @@
>   
>   #include "vcn/vcn_1_0_offset.h"
>   #include "vcn/vcn_1_0_sh_mask.h"
> -#include "hdp/hdp_4_0_offset.h"
>   #include "mmhub/mmhub_9_1_offset.h"
>   #include "mmhub/mmhub_9_1_sh_mask.h"
>   

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
