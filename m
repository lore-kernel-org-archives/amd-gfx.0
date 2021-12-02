Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71BCAC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Dec 2021 09:03:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C23B46EA2C;
	Thu,  2 Dec 2021 09:03:16 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 237486EA2B
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Dec 2021 09:03:15 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 d72-20020a1c1d4b000000b00331140f3dc8so3023347wmd.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 Dec 2021 01:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=gtqwHVimAjjxw2VnQ6LxSD7Hvra2aEfqXnq+BuOAWqc=;
 b=TWHQ+dmrZ/Xrsonvhhs/furjzip6hAfYhd8rNyQiSiYxJSd3+HKIsQ2S/WC11W3JE+
 Ui41QPkqfbWOa2AeZ0Tmhpz/NP5CWdzNSK+Vb4xl5hqU26o6FUgCDyRVk6jooWr0fxZF
 9HMheEVJZIpre4eQnKFcPUsrcxVHhWDFctA7de3EmRpSZUKLOZ997jxqGDTN8Cs4wuMK
 zJHIIUgeB5Kv2+o+lyyyI0jai/r+16mBx/5OePRTKp23zd7SUWEcH2ugCDdsaPaycj4O
 I4d3C9SRZc6VtnAXEVw+v9uXyGSLIlLT//HaIM8B2yTGPUGc/qMXAPCmKW3T+touXydO
 31DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=gtqwHVimAjjxw2VnQ6LxSD7Hvra2aEfqXnq+BuOAWqc=;
 b=1od4muefPibZxLk4Vn9YWZsZhyiCsgUJc3ZsU/Ghfd1V6OD/wfnvYIFmasysKe2XrV
 xfGjHXP34ZtnrH+XbV14elW3GxvRz1noOfmdQsPk6OyZHh4MCWL9wmRwPfWocQNLcBiR
 cZes5sCWGNliKkhFL2jyHEjvHwPygI3z6uT5IcHNn/ocVk5IKN/4O9e0TIMm9Zxlxd2e
 y1cPKSHt93f/Rz7ACtyhHZLCt9PFmJoccN3V5MfPlgEc8YdpWYZhcCSUAbDdkVO+bGjf
 tVmIEL64tWeig9vqlMVvYAGuYE6OcZ2ownKxXeWjyOnrces1IrjCepU2Xkxii3sOGV0K
 G2wQ==
X-Gm-Message-State: AOAM532sMEy3s99zm5jtED8pTe54KtcAKdC7wjcZ0paDmmpOJ+wIkUU4
 eHRwMMxXljO/fQznzIL5uzTnyLiS9VY=
X-Google-Smtp-Source: ABdhPJwL4mxjlCQB/1Yyl+HVgd9eY5NlFnQAfXzZC+GEvUcpIZtehQM7g4ZHWQzNKPz6KsHNmlrDwQ==
X-Received: by 2002:a05:600c:d0:: with SMTP id u16mr4654657wmm.7.1638435792735; 
 Thu, 02 Dec 2021 01:03:12 -0800 (PST)
Received: from [192.168.178.21] (p57b0b77b.dip0.t-ipconnect.de.
 [87.176.183.123])
 by smtp.gmail.com with ESMTPSA id x4sm1493414wmi.3.2021.12.02.01.02.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Dec 2021 01:02:50 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: handle SRIOV VCN revision parsing
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211201213546.1090031-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <1a7c3444-70a1-becf-12e6-d47c6e673ab1@gmail.com>
Date: Thu, 2 Dec 2021 10:02:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211201213546.1090031-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 01.12.21 um 22:35 schrieb Alex Deucher:
> For SR-IOV, the IP discovery revision number encodes
> additional information.  Handle that case here.
>
> v2: drop additional IP versions
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

I was already wondering why SRIOV needs special handling for the 
revision, going to keep an eye open for more stuff like that.

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 17 ++++++++++++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |  2 --
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h       |  1 +
>   drivers/gpu/drm/amd/amdgpu/nv.c               |  2 --
>   4 files changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index ea00090b3fb3..552031950518 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -379,8 +379,21 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>   				  ip->major, ip->minor,
>   				  ip->revision);
>   
> -			if (le16_to_cpu(ip->hw_id) == VCN_HWID)
> +			if (le16_to_cpu(ip->hw_id) == VCN_HWID) {
> +				if (amdgpu_sriov_vf(adev)) {
> +					/* SR-IOV modifies each VCN’s revision (uint8)
> +					 * Bit [5:0]: original revision value
> +					 * Bit [7:6]: en/decode capability:
> +					 *     0b00 : VCN function normally
> +					 *     0b10 : encode is disabled
> +					 *     0b01 : decode is disabled
> +					 */
> +					adev->vcn.sriov_config[adev->vcn.num_vcn_inst] =
> +						(ip->revision & 0xc0) >> 6;
> +					ip->revision &= ~0xc0;
> +				}
>   				adev->vcn.num_vcn_inst++;
> +			}
>   			if (le16_to_cpu(ip->hw_id) == SDMA0_HWID ||
>   			    le16_to_cpu(ip->hw_id) == SDMA1_HWID ||
>   			    le16_to_cpu(ip->hw_id) == SDMA2_HWID ||
> @@ -917,10 +930,8 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
>   			break;
>   		case IP_VERSION(3, 0, 0):
>   		case IP_VERSION(3, 0, 16):
> -		case IP_VERSION(3, 0, 64):
>   		case IP_VERSION(3, 1, 1):
>   		case IP_VERSION(3, 0, 2):
> -		case IP_VERSION(3, 0, 192):
>   			amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
>   			if (!amdgpu_sriov_vf(adev))
>   				amdgpu_device_ip_block_add(adev, &jpeg_v3_0_ip_block);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 585961c2f5f2..2658414c503d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -134,8 +134,6 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
>   			adev->vcn.indirect_sram = true;
>   		break;
>   	case IP_VERSION(3, 0, 0):
> -	case IP_VERSION(3, 0, 64):
> -	case IP_VERSION(3, 0, 192):
>   		if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 3, 0))
>   			fw_name = FIRMWARE_SIENNA_CICHLID;
>   		else
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index bfa27ea94804..938a5ead3f20 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -235,6 +235,7 @@ struct amdgpu_vcn {
>   
>   	uint8_t	num_vcn_inst;
>   	struct amdgpu_vcn_inst	 inst[AMDGPU_MAX_VCN_INSTANCES];
> +	uint8_t			 sriov_config[AMDGPU_MAX_VCN_INSTANCES];
>   	struct amdgpu_vcn_reg	 internal;
>   	struct mutex		 vcn_pg_lock;
>   	struct mutex		vcn1_jpeg1_workaround;
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index 2ec1ffb36b1f..7088528079c6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -182,8 +182,6 @@ static int nv_query_video_codecs(struct amdgpu_device *adev, bool encode,
>   {
>   	switch (adev->ip_versions[UVD_HWIP][0]) {
>   	case IP_VERSION(3, 0, 0):
> -	case IP_VERSION(3, 0, 64):
> -	case IP_VERSION(3, 0, 192):
>   		if (amdgpu_sriov_vf(adev)) {
>   			if (encode)
>   				*codecs = &sriov_sc_video_codecs_encode;

