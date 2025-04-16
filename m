Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF73C369BD
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Apr 2025 13:40:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C3DE10E91D;
	Wed, 16 Apr 2025 13:40:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R9gXj5ic";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C63E10E91B
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 13:40:51 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-43cfb6e9031so62599895e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 06:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744810849; x=1745415649; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M4cIrlK1waPMygkyFQ81iO6zSle0mM4cxa3SvGj5Vhw=;
 b=R9gXj5icGUuLjMYnCb3gYJYKqVIFHqxaLo1bT9k6Dp4uBXJIaHqTZKtrgMX2R7/+J2
 ZVYSu+3OdwuZ1s+3JENThxiT9XsPCutfEHUyU0VG0mJNMwLZL4zg9eTYqP1kjxBIrNnu
 Ppqu80tEDo1Sg+1e+nHFKS0p9S7CKGRv0VQiGUi+XpNs/8JB2Fv77Rmae6upiyJ8SolN
 gUjUCvOa3UMkfp4WOe38nmKcNv0Y4QJymf4xzF3NgKLFnPHB3afhACYeQa1NNzKDNj9H
 zyJUABIyKa0buSHt7Vnj2iyym/HYRVolSzai4IFi43mQ/SUyBb/JA2VYE8YSv4eiLdiL
 tAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744810849; x=1745415649;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M4cIrlK1waPMygkyFQ81iO6zSle0mM4cxa3SvGj5Vhw=;
 b=AbZyMH0sUDtrx5Y9n1XLn2/E2a0TJfoSKhPM/CniQNBZhAHUJJq5cz/5t9eDj+Fsxj
 cEGw2Tq0Pg25nWFQKVlR8or6u2buizVos/EGpLvjcyKpH0x7zR10vsUGK2DoTRismo8P
 +WpPXAPdpkhLwabkXuQjlRDiKjvA8P2IYajlsfwshayhgUzScV/qd2d00BI3ZZLIyr3v
 FUL81xhQoJJYIHUvNHProyAZgIS1E2G23ERXyP1wblCOHof6xPzwhltwzZ37vA7kD2Oi
 49gusKhgxLBZahdr0jcu6J1XkJCPaBI4b3PhuyP6ya3Qsd3W5CSjFqqtkyKKFYEW6Ywb
 Koqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQlx6iUJlRO7u+l0iJ52KDbeloJmLQ1rEgA04T+d45Mb6MkoJ9EA1rNvuS8YWDfEQCLTn4Pklm@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxU/2RQzkSLw75LPpuPcBbo0yfq/sBItI0D5CLLSaFOZw0gz2TK
 /bzvQ2YGeQL1FlGW7gm+L/niEzucckJT3Kl/UFI3r3BVSSzVNI+R
X-Gm-Gg: ASbGncvE74BHuNtQmHlOwWh0QsDFQeuZft4j3lgvYzOCvz4daCgQ+PW22b7RJq0p2TM
 mjPULcV5u5a2EzimECkTbSqscwHeu/paGmifZ8Slclo+LEvivrH3liPMrzcIV4IIwYkh93aQWI/
 ar8ERsrmM8C8U6JvgPn9dZYG8XBboJzvou+p9alNs3mO2XLw/NFolhg1q6RqCo4ZlzALGOonGI7
 rfWALLuefO34iIZVYsFMiD+LmFC5AWlEHgL5oUVsXEh0JnzF81xaiuQR4zrXx35eCXO1Qm2SF0i
 RRy1NB1vOhd6ImJevINBs7IIc7fW2TVYj/DDyFCA+krhA+wk70sg+chppsNuNka85aDWIA==
X-Google-Smtp-Source: AGHT+IEkCloaL8Q5qV3s2vxsW2jA1hIiukvkdRM/mKPGUnWKQMMRc00ExvtiGRYeBydwvGvvav4TNw==
X-Received: by 2002:a05:600c:4688:b0:43c:fa52:7d2d with SMTP id
 5b1f17b1804b1-4405d69b7acmr14986815e9.20.1744810849513; 
 Wed, 16 Apr 2025 06:40:49 -0700 (PDT)
Received: from [10.254.108.83] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae96407esm17303698f8f.17.2025.04.16.06.40.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 06:40:49 -0700 (PDT)
Message-ID: <8a622322-883b-4eb4-b77d-db293ed532f3@gmail.com>
Date: Wed, 16 Apr 2025 15:40:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] drm/amdgpu: update XGMI physical node id and GMC
 configs on resume
To: Samuel Zhang <guoqing.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: victor.zhao@amd.com, haijun.chang@amd.com, emily.deng@amd.com,
 Jiang Liu <gerry@linux.alibaba.com>
References: <20250414104655.336497-1-guoqing.zhang@amd.com>
 <20250414104655.336497-2-guoqing.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20250414104655.336497-2-guoqing.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
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

Am 14.04.25 um 12:46 schrieb Samuel Zhang:
> For virtual machine with vGPUs in SRIOV single device mode and XGMI
> is enabled, XGMI physical node ids may change when waking up from
> hiberation with different vGPU devices. So update XGMI physical node
> ids on resume.
>
> Update GPU memory controller configuration on resume if XGMI physical
> node ids are changed.
>
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
> Change-Id: I0bcac2d46fdeed66c9cf7e6a378134769c95df61
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 25 ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h   |  2 ++
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  8 +++++++
>  4 files changed, 37 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index f212ce3f5d34..12f115602ab2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5098,6 +5098,28 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
>  	return 0;
>  }
>  
> +static int amdgpu_device_update_xgmi_nodes(struct amdgpu_device *adev)
> +{
> +	int r = 0;
> +	/* Get xgmi info again for sriov to detect device changes */

General coding style: Don't initialize return values if not necessary and add an empty line between declaration and code.

> +	if (amdgpu_sriov_vf(adev) &&
> +	    !(adev->flags & AMD_IS_APU) &&
> +	    adev->gmc.xgmi.supported &&
> +	    !adev->gmc.xgmi.connected_to_cpu) {
> +		adev->gmc.xgmi.prev_physical_node_id = adev->gmc.xgmi.physical_node_id;
> +		r = adev->gfxhub.funcs->get_xgmi_info(adev);
> +		if (r)
> +			return r;
> +
> +		adev->gmc.xgmi.physical_node_id_changed =
> +			adev->gmc.xgmi.physical_node_id != adev->gmc.xgmi.prev_physical_node_id;
> +		dev_info(adev->dev, "xgmi node, old id %d, new id %d\n",
> +			adev->gmc.xgmi.prev_physical_node_id, adev->gmc.xgmi.physical_node_id);
> +	}
> +	return 0;
> +}
> +
> +
>  /**
>   * amdgpu_device_resume - initiate device resume
>   *
> @@ -5117,6 +5139,9 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
>  		r = amdgpu_virt_request_full_gpu(adev, true);
>  		if (r)
>  			return r;
> +		r = amdgpu_device_update_xgmi_nodes(adev);
> +		if (r)
> +			return r;
>  	}
>  
>  	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index ecb74ccf1d90..5b60d714e089 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -1288,6 +1288,8 @@ int amdgpu_gmc_get_nps_memranges(struct amdgpu_device *adev,
>  
>  	refresh = (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) &&
>  		  (adev->gmc.reset_flags & AMDGPU_GMC_INIT_RESET_NPS);
> +	if (adev->gmc.xgmi.physical_node_id_changed)
> +		refresh = true;
>  	ret = amdgpu_discovery_get_nps_info(adev, &nps_type, &ranges,
>  					    &range_cnt, refresh);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> index 32dabba4062f..3d5f01a1b657 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> @@ -89,6 +89,8 @@ struct amdgpu_xgmi {
>  	u64 node_segment_size;
>  	/* physical node (0-3) */
>  	unsigned physical_node_id;
> +	unsigned prev_physical_node_id;
> +	bool physical_node_id_changed;

Please drop that.

>  	/* number of nodes (0-4) */
>  	unsigned num_physical_nodes;
>  	/* gpu list in the same hive */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 8d3560314e5b..7c7a9fe6be6d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -2515,6 +2515,14 @@ static int gmc_v9_0_resume(struct amdgpu_ip_block *ip_block)
>  	struct amdgpu_device *adev = ip_block->adev;
>  	int r;
>  
> +	/* Update MC configuration if XGMI physical node id has changed for dGPU. */
> +	if (adev->gmc.xgmi.physical_node_id_changed) {
> +		r = gmc_v9_0_mc_init(adev);
> +		if (r)
> +			return r;
> +		gmc_v9_0_init_sw_mem_ranges(adev, adev->gmc.mem_partitions);
> +	}
> +

Just always update that on resume.

Regards,
Christian.

>  	/* If a reset is done for NPS mode switch, read the memory range
>  	 * information again.
>  	 */

