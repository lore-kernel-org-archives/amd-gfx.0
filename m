Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E2F5D6DDF3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2024 12:29:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97E7F10E85F;
	Fri, 15 Nov 2024 12:29:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MynfXpR0";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A139E10E2D0
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2024 12:29:16 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4315839a7c9so15061055e9.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2024 04:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731673755; x=1732278555; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U0mTFOfD+l5vALccNE5EJ7BeyTd1Cm6wAWQjzfyNB3Y=;
 b=MynfXpR00rk5TkxbEvQxJtAqFOlIVHKOeVyBItX4I25pZSK+ICOQFcDWQccmIDe06Z
 fYiW2HGQrRA9nlx3OSjjqxcUb01pjqsEhXy9yKcu71SPY1OO7QJRnA+snRmiO/KnYGX2
 oLF8U/mkdJLfufCUfZmlaTXC/o6/CIRKO+9tB3xcKhB5qWU4UuocYcmSzeKHMG+rhm3O
 p814b1WWCSQ8eOJTZ68uGtCiYWBT2uua3kpkoKmEBAhPxk07uh6l3GOmR9m1Y+MRxWw8
 koO6rnjVrKz8CirPYh+VKi3W+XpGPQtREHB6LbOiaT0qHOqFRFO3UCEp9XuM/TytfCmR
 4mWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731673755; x=1732278555;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U0mTFOfD+l5vALccNE5EJ7BeyTd1Cm6wAWQjzfyNB3Y=;
 b=OWyvi4hTaKUZAplyAWS2eulu+5tYGMImQ1oGY49f2QSmSSz9GHZ2tX5x7sv7zEBC/f
 YUsMeVITySH8FAC7okrYE6kq/nbw3JarSdowIT+vOhgIZ4aoAYYagOEJFNlv20EwxQ1w
 BAwgDkCWlANGXMI8QTIg8kcKIU334qpG8Fmm8q7LIpBLIOr9La7GQMqNMKVvvFqp8YCZ
 zgBf5FlB5YWsy5rYvexAOLRWJVjQL92ykLvh5Ib9JXJNdOvV5Bj0PSBjjoJSb5O6cGQ9
 JMK8jBRphXmxXMx0gWvfURPhoaIC78bOs4QBZz8mU3057YSHJXpiv7FQ18CPlfOX4hwP
 xhqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxbXk4I+3fjn48R4Ts/gPDEiiztOztqCA5aetEHIg1F8xsNmvB1FNIu4sn4vKLVyMb8E2jiTRe@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwP0nTv+U0xqKrlsfO8fHOJ2TbbRgSe+ZIYnxZKZ4LYIrU1hkKi
 u6TAOePy44lozdvhoOdFI3zwmPiY6AArOwqyEC46dYH8FT7s/f8w
X-Google-Smtp-Source: AGHT+IFa5GfFLlxjeYCNJZvXoTjlx5I+NU1oWAOAngdvoTUtCmAGxmkrk5HSerghRCulCgfXYx4rNA==
X-Received: by 2002:a05:600c:190a:b0:426:647b:1bfc with SMTP id
 5b1f17b1804b1-432df791dc9mr22356835e9.30.1731673753670; 
 Fri, 15 Nov 2024 04:29:13 -0800 (PST)
Received: from [10.254.108.83] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dab721d7sm53980595e9.9.2024.11.15.04.29.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Nov 2024 04:29:12 -0800 (PST)
Message-ID: <27bf3799-107c-4fde-807c-a4c7090d706e@gmail.com>
Date: Fri, 15 Nov 2024 13:29:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/15] drm/amdgpu: partially revert VCN IP block
 instancing support
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20241113214453.17081-1-alexander.deucher@amd.com>
 <20241113214453.17081-2-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20241113214453.17081-2-alexander.deucher@amd.com>
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

Am 13.11.24 um 22:44 schrieb Alex Deucher:
> This partially reverts the VCN IP block rework.  There
> are too many corner cases and chances for regressions.
>
> While this aligned better with the original design, years
> of hardware has used the old pattern.  Best to stick with
> it at this point.

I really don't think that this is a good idea.

We should keep that at least for the VCN generations Boyuan has tested 
and start to sort out the problems.

Regards,
Christian.


>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |    6 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   31 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   23 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |   12 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c      |   14 +-
>   .../gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c   |    8 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c     |   13 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c      |   10 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c       |    4 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c       |    4 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |  377 +++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h       |   26 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c       |   17 +-
>   drivers/gpu/drm/amd/amdgpu/df_v3_6.c          |    8 +-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c        |    2 +-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c        |    2 +-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c        |    2 +-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c        |    2 +-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c        |    2 +-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c      |    2 +-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c      |    2 +-
>   drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c         |    2 +-
>   drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c         |    2 +-
>   drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c         |    2 +-
>   drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c         |    2 +-
>   drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c         |    2 +-
>   drivers/gpu/drm/amd/amdgpu/vce_v2_0.c         |    2 +-
>   drivers/gpu/drm/amd/amdgpu/vce_v3_0.c         |    2 +-
>   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c         |    2 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c         |  128 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c         |  113 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         | 1145 +++++++++--------
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         |  897 ++++++-------
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c         |  796 ++++++------
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c       |  727 +++++------
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c       |  761 +++++------
>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c       |  692 +++++-----
>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |    6 +-
>   drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    |    8 +-
>   .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  |    6 +-
>   .../powerplay/hwmgr/smu7_clockpowergating.c   |   12 +-
>   .../drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c   |   12 +-
>   .../drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c |    6 +-
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |    8 +-
>   44 files changed, 2938 insertions(+), 2962 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index a37e687acbbc..acb6d49bd00c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -363,8 +363,7 @@ int amdgpu_device_ip_set_clockgating_state(void *dev,
>   					   enum amd_clockgating_state state);
>   int amdgpu_device_ip_set_powergating_state(void *dev,
>   					   enum amd_ip_block_type block_type,
> -					   enum amd_powergating_state state,
> -					   int inst);
> +					   enum amd_powergating_state state);
>   void amdgpu_device_ip_get_clockgating_state(struct amdgpu_device *adev,
>   					    u64 *flags);
>   int amdgpu_device_ip_wait_for_idle(struct amdgpu_device *adev,
> @@ -397,9 +396,6 @@ struct amdgpu_ip_block {
>   	struct amdgpu_ip_block_status status;
>   	const struct amdgpu_ip_block_version *version;
>   	struct amdgpu_device *adev;
> -	unsigned int instance;
> -	/* IP reg dump */
> -	uint32_t *ip_dump;
>   };
>   
>   int amdgpu_device_ip_block_version_cmp(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 8c1d5b192ff4..343c9f2ab1a0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2177,8 +2177,7 @@ int amdgpu_device_ip_set_clockgating_state(void *dev,
>    */
>   int amdgpu_device_ip_set_powergating_state(void *dev,
>   					   enum amd_ip_block_type block_type,
> -					   enum amd_powergating_state state,
> -					   int inst)
> +					   enum amd_powergating_state state)
>   {
>   	struct amdgpu_device *adev = dev;
>   	int i, r = 0;
> @@ -2188,9 +2187,6 @@ int amdgpu_device_ip_set_powergating_state(void *dev,
>   			continue;
>   		if (adev->ip_blocks[i].version->type != block_type)
>   			continue;
> -		if (block_type == AMD_IP_BLOCK_TYPE_VCN &&
> -				adev->ip_blocks[i].instance != inst)
> -			continue;
>   		if (!adev->ip_blocks[i].version->funcs->set_powergating_state)
>   			continue;
>   		r = adev->ip_blocks[i].version->funcs->set_powergating_state(
> @@ -2326,28 +2322,6 @@ int amdgpu_device_ip_block_version_cmp(struct amdgpu_device *adev,
>   	return 1;
>   }
>   
> -/**
> - * amdgpu_device_ip_get_num_instances - get number of instances of an IP block
> - *
> - * @adev: amdgpu_device pointer
> - * @type: Type of hardware IP (SMU, GFX, UVD, etc.)
> - *
> - * Returns the count of the hardware IP blocks structure for that type.
> - */
> -static unsigned int
> -amdgpu_device_ip_get_num_instances(struct amdgpu_device *adev,
> -				    enum amd_ip_block_type type)
> -{
> -	unsigned int i, count = 0;
> -
> -	for (i = 0; i < adev->num_ip_blocks; i++) {
> -		if (adev->ip_blocks[i].version->type == type)
> -			count++;
> -	}
> -
> -	return count;
> -}
> -
>   /**
>    * amdgpu_device_ip_block_add
>    *
> @@ -2380,8 +2354,7 @@ int amdgpu_device_ip_block_add(struct amdgpu_device *adev,
>   		  ip_block_version->funcs->name);
>   
>   	adev->ip_blocks[adev->num_ip_blocks].adev = adev;
> -	adev->ip_blocks[adev->num_ip_blocks].instance =
> -		amdgpu_device_ip_get_num_instances(adev, ip_block_version->type);
> +
>   	adev->ip_blocks[adev->num_ip_blocks++].version = ip_block_version;
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 482c883a53b2..b8845c74ec00 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -2280,8 +2280,6 @@ static int amdgpu_discovery_set_sdma_ip_blocks(struct amdgpu_device *adev)
>   
>   static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
>   {
> -	int i;
> -
>   	if (amdgpu_ip_version(adev, VCE_HWIP, 0)) {
>   		switch (amdgpu_ip_version(adev, UVD_HWIP, 0)) {
>   		case IP_VERSION(7, 0, 0):
> @@ -2325,13 +2323,11 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
>   		case IP_VERSION(2, 0, 3):
>   			break;
>   		case IP_VERSION(2, 5, 0):
> -			for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
> -				amdgpu_device_ip_block_add(adev, &vcn_v2_5_ip_block);
> +			amdgpu_device_ip_block_add(adev, &vcn_v2_5_ip_block);
>   			amdgpu_device_ip_block_add(adev, &jpeg_v2_5_ip_block);
>   			break;
>   		case IP_VERSION(2, 6, 0):
> -			for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
> -				amdgpu_device_ip_block_add(adev, &vcn_v2_6_ip_block);
> +			amdgpu_device_ip_block_add(adev, &vcn_v2_6_ip_block);
>   			amdgpu_device_ip_block_add(adev, &jpeg_v2_6_ip_block);
>   			break;
>   		case IP_VERSION(3, 0, 0):
> @@ -2339,8 +2335,7 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
>   		case IP_VERSION(3, 1, 1):
>   		case IP_VERSION(3, 1, 2):
>   		case IP_VERSION(3, 0, 2):
> -			for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
> -				amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
> +			amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
>   			if (!amdgpu_sriov_vf(adev))
>   				amdgpu_device_ip_block_add(adev, &jpeg_v3_0_ip_block);
>   			break;
> @@ -2350,24 +2345,20 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
>   		case IP_VERSION(4, 0, 0):
>   		case IP_VERSION(4, 0, 2):
>   		case IP_VERSION(4, 0, 4):
> -			for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
> -				amdgpu_device_ip_block_add(adev, &vcn_v4_0_ip_block);
> +			amdgpu_device_ip_block_add(adev, &vcn_v4_0_ip_block);
>   			amdgpu_device_ip_block_add(adev, &jpeg_v4_0_ip_block);
>   			break;
>   		case IP_VERSION(4, 0, 3):
> -			for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
> -				amdgpu_device_ip_block_add(adev, &vcn_v4_0_3_ip_block);
> +			amdgpu_device_ip_block_add(adev, &vcn_v4_0_3_ip_block);
>   			amdgpu_device_ip_block_add(adev, &jpeg_v4_0_3_ip_block);
>   			break;
>   		case IP_VERSION(4, 0, 5):
>   		case IP_VERSION(4, 0, 6):
> -			for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
> -				amdgpu_device_ip_block_add(adev, &vcn_v4_0_5_ip_block);
> +			amdgpu_device_ip_block_add(adev, &vcn_v4_0_5_ip_block);
>   			amdgpu_device_ip_block_add(adev, &jpeg_v4_0_5_ip_block);
>   			break;
>   		case IP_VERSION(5, 0, 0):
> -			for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
> -				amdgpu_device_ip_block_add(adev, &vcn_v5_0_0_ip_block);
> +			amdgpu_device_ip_block_add(adev, &vcn_v5_0_0_ip_block);
>   			amdgpu_device_ip_block_add(adev, &jpeg_v5_0_0_ip_block);
>   			break;
>   		default:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index c65feb97167d..3c89c74d67e0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -25,7 +25,6 @@
>   
>   #include <linux/firmware.h>
>   #include <linux/pm_runtime.h>
> -#include <drm/drm_drv.h>
>   
>   #include "amdgpu.h"
>   #include "amdgpu_gfx.h"
> @@ -1779,14 +1778,9 @@ int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
>   
>   void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)
>   {
> -	int idx;
> -
> -	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> -		amdgpu_gfx_sysfs_xcp_fini(adev);
> -		amdgpu_gfx_sysfs_isolation_shader_fini(adev);
> -		amdgpu_gfx_sysfs_reset_mask_fini(adev);
> -		drm_dev_exit(idx);
> -	}
> +	amdgpu_gfx_sysfs_xcp_fini(adev);
> +	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
> +	amdgpu_gfx_sysfs_reset_mask_fini(adev);
>   }
>   
>   int amdgpu_gfx_cleaner_shader_sw_init(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> index bf4dbceb18e1..04eb51674596 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> @@ -24,7 +24,6 @@
>    *
>    */
>   
> -#include <drm/drm_drv.h>
>   #include "amdgpu.h"
>   #include "amdgpu_jpeg.h"
>   #include "amdgpu_pm.h"
> @@ -120,7 +119,7 @@ static void amdgpu_jpeg_idle_work_handler(struct work_struct *work)
>   
>   	if (!fences && !atomic_read(&adev->jpeg.total_submission_cnt))
>   		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_JPEG,
> -						       AMD_PG_STATE_GATE, 0);
> +						       AMD_PG_STATE_GATE);
>   	else
>   		schedule_delayed_work(&adev->jpeg.idle_work, JPEG_IDLE_TIMEOUT);
>   }
> @@ -134,7 +133,7 @@ void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring *ring)
>   
>   	mutex_lock(&adev->jpeg.jpeg_pg_lock);
>   	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_JPEG,
> -						       AMD_PG_STATE_UNGATE, 0);
> +						       AMD_PG_STATE_UNGATE);
>   	mutex_unlock(&adev->jpeg.jpeg_pg_lock);
>   }
>   
> @@ -448,11 +447,6 @@ int amdgpu_jpeg_sysfs_reset_mask_init(struct amdgpu_device *adev)
>   
>   void amdgpu_jpeg_sysfs_reset_mask_fini(struct amdgpu_device *adev)
>   {
> -	int idx;
> -
> -	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> -		if (adev->jpeg.num_jpeg_inst)
> -			device_remove_file(adev->dev, &dev_attr_jpeg_reset_mask);
> -		drm_dev_exit(idx);
> -	}
> +	if (adev->jpeg.num_jpeg_inst)
> +		device_remove_file(adev->dev, &dev_attr_jpeg_reset_mask);
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
> index 9a0346ed6ea4..e8adfd0a570a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
> @@ -23,7 +23,6 @@
>    * Authors: Christian König, Felix Kuehling
>    */
>   
> -#include <drm/drm_drv.h>
>   #include "amdgpu.h"
>   
>   /**
> @@ -130,7 +129,7 @@ int amdgpu_preempt_mgr_init(struct amdgpu_device *adev)
>   void amdgpu_preempt_mgr_fini(struct amdgpu_device *adev)
>   {
>   	struct ttm_resource_manager *man = &adev->mman.preempt_mgr;
> -	int idx, ret;
> +	int ret;
>   
>   	ttm_resource_manager_set_used(man, false);
>   
> @@ -138,10 +137,7 @@ void amdgpu_preempt_mgr_fini(struct amdgpu_device *adev)
>   	if (ret)
>   		return;
>   
> -	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> -		device_remove_file(adev->dev, &dev_attr_mem_info_preempt_used);
> -		drm_dev_exit(idx);
> -	}
> +	device_remove_file(adev->dev, &dev_attr_mem_info_preempt_used);
>   
>   	ttm_resource_manager_cleanup(man);
>   	ttm_set_driver_manager(&adev->mman.bdev, AMDGPU_PL_PREEMPT, NULL);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> index 4fc0ee01d56b..24dae7cdbe95 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> @@ -42,15 +42,14 @@ static int amdgpu_reset_xgmi_reset_on_init_suspend(struct amdgpu_device *adev)
>   		/* XXX handle errors */
>   		amdgpu_ip_block_suspend(&adev->ip_blocks[i]);
>   		adev->ip_blocks[i].status.hw = false;
> -
> -		/* VCN FW shared region is in frambuffer, there are some flags
> -		* initialized in that region during sw_init. Make sure the region is
> -		* backed up.
> -		*/
> -		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_VCN)
> -			amdgpu_vcn_save_vcpu_bo(adev, adev->ip_blocks[i].instance);
>   	}
>   
> +	/* VCN FW shared region is in frambuffer, there are some flags
> +	 * initialized in that region during sw_init. Make sure the region is
> +	 * backed up.
> +	 */
> +	amdgpu_vcn_save_vcpu_bo(adev);
> +
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index 24e9daacaabb..8c89b69edc20 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -21,7 +21,6 @@
>    *
>    */
>   
> -#include <drm/drm_drv.h>
>   #include <linux/firmware.h>
>   #include "amdgpu.h"
>   #include "amdgpu_sdma.h"
> @@ -449,14 +448,9 @@ int amdgpu_sdma_sysfs_reset_mask_init(struct amdgpu_device *adev)
>   
>   void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev)
>   {
> -	int idx;
> -
>   	if (!amdgpu_gpu_recovery)
>   		return;
>   
> -	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> -		if (adev->sdma.num_instances)
> -			device_remove_file(adev->dev, &dev_attr_sdma_reset_mask);
> -		drm_dev_exit(idx);
> -	}
> +	if (adev->sdma.num_instances)
> +		device_remove_file(adev->dev, &dev_attr_sdma_reset_mask);
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> index 09844953a1fa..31fd30dcd593 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -1277,7 +1277,7 @@ static void amdgpu_uvd_idle_work_handler(struct work_struct *work)
>   			amdgpu_asic_set_uvd_clocks(adev, 0, 0);
>   			/* shutdown the UVD block */
>   			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
> -							       AMD_PG_STATE_GATE, 0);
> +							       AMD_PG_STATE_GATE);
>   			amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
>   							       AMD_CG_STATE_GATE);
>   		}
> @@ -1303,7 +1303,7 @@ void amdgpu_uvd_ring_begin_use(struct amdgpu_ring *ring)
>   			amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
>   							       AMD_CG_STATE_UNGATE);
>   			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
> -							       AMD_PG_STATE_UNGATE, 0);
> +							       AMD_PG_STATE_UNGATE);
>   		}
>   	}
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> index a061fb8a2fcf..74fdbf71d95b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -344,7 +344,7 @@ static void amdgpu_vce_idle_work_handler(struct work_struct *work)
>   		} else {
>   			amdgpu_asic_set_vce_clocks(adev, 0, 0);
>   			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
> -							       AMD_PG_STATE_GATE, 0);
> +							       AMD_PG_STATE_GATE);
>   			amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
>   							       AMD_CG_STATE_GATE);
>   		}
> @@ -378,7 +378,7 @@ void amdgpu_vce_ring_begin_use(struct amdgpu_ring *ring)
>   			amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
>   							       AMD_CG_STATE_UNGATE);
>   			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
> -							       AMD_PG_STATE_UNGATE, 0);
> +							       AMD_PG_STATE_UNGATE);
>   
>   		}
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 25f490ad3a85..49802e66a358 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -91,43 +91,39 @@ MODULE_FIRMWARE(FIRMWARE_VCN5_0_0);
>   
>   static void amdgpu_vcn_idle_work_handler(struct work_struct *work);
>   
> -int amdgpu_vcn_early_init(struct amdgpu_device *adev, int inst)
> +int amdgpu_vcn_early_init(struct amdgpu_device *adev)
>   {
>   	char ucode_prefix[25];
> -	int r;
> +	int r, i;
>   
>   	amdgpu_ucode_ip_version_decode(adev, UVD_HWIP, ucode_prefix, sizeof(ucode_prefix));
> -
> -	if (inst == 1 && amdgpu_ip_version(adev, UVD_HWIP, 0) ==  IP_VERSION(4, 0, 6))
> -		r = amdgpu_ucode_request(adev, &adev->vcn.inst[inst].fw, "amdgpu/%s_%d.bin", ucode_prefix, inst);
> -	else
> -		r = amdgpu_ucode_request(adev, &adev->vcn.inst[inst].fw, "amdgpu/%s.bin", ucode_prefix);
> -
> -	if (r) {
> -		amdgpu_ucode_release(&adev->vcn.inst[inst].fw);
> -		return r;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		if (i == 1 && amdgpu_ip_version(adev, UVD_HWIP, 0) ==  IP_VERSION(4, 0, 6))
> +			r = amdgpu_ucode_request(adev, &adev->vcn.inst[i].fw, "amdgpu/%s_%d.bin", ucode_prefix, i);
> +		else
> +			r = amdgpu_ucode_request(adev, &adev->vcn.inst[i].fw, "amdgpu/%s.bin", ucode_prefix);
> +		if (r) {
> +			amdgpu_ucode_release(&adev->vcn.inst[i].fw);
> +			return r;
> +		}
>   	}
> -
>   	return r;
>   }
>   
> -int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int inst)
> +int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
>   {
>   	unsigned long bo_size;
>   	const struct common_firmware_header *hdr;
>   	unsigned char fw_check;
>   	unsigned int fw_shared_size, log_offset;
> -	int r;
> -
> -	adev->vcn.inst[inst].adev = adev;
> -	adev->vcn.inst[inst].work_inst = inst;
> -	INIT_DELAYED_WORK(&adev->vcn.inst[inst].idle_work, amdgpu_vcn_idle_work_handler);
> +	int i, r;
>   
> +	INIT_DELAYED_WORK(&adev->vcn.idle_work, amdgpu_vcn_idle_work_handler);
>   	mutex_init(&adev->vcn.vcn_pg_lock);
>   	mutex_init(&adev->vcn.vcn1_jpeg1_workaround);
>   	atomic_set(&adev->vcn.total_submission_cnt, 0);
> -
> -	atomic_set(&adev->vcn.inst[inst].dpg_enc_submission_cnt, 0);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
> +		atomic_set(&adev->vcn.inst[i].dpg_enc_submission_cnt, 0);
>   
>   	if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
>   	    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
> @@ -205,74 +201,78 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int inst)
>   	if (amdgpu_vcnfw_log)
>   		bo_size += AMDGPU_VCNFW_LOG_SIZE;
>   
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		return 0;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
>   
> -	r = amdgpu_bo_create_kernel(adev, bo_size, PAGE_SIZE,
> -					AMDGPU_GEM_DOMAIN_VRAM |
> -					AMDGPU_GEM_DOMAIN_GTT,
> -					&adev->vcn.inst[inst].vcpu_bo,
> -					&adev->vcn.inst[inst].gpu_addr,
> -					&adev->vcn.inst[inst].cpu_addr);
> -	if (r) {
> -		dev_err(adev->dev, "(%d) failed to allocate vcn bo\n", r);
> -		return r;
> -	}
> +		r = amdgpu_bo_create_kernel(adev, bo_size, PAGE_SIZE,
> +					    AMDGPU_GEM_DOMAIN_VRAM |
> +					    AMDGPU_GEM_DOMAIN_GTT,
> +					    &adev->vcn.inst[i].vcpu_bo,
> +					    &adev->vcn.inst[i].gpu_addr,
> +					    &adev->vcn.inst[i].cpu_addr);
> +		if (r) {
> +			dev_err(adev->dev, "(%d) failed to allocate vcn bo\n", r);
> +			return r;
> +		}
>   
> -	adev->vcn.inst[inst].fw_shared.cpu_addr = adev->vcn.inst[inst].cpu_addr +
> -			bo_size - fw_shared_size;
> -	adev->vcn.inst[inst].fw_shared.gpu_addr = adev->vcn.inst[inst].gpu_addr +
> -			bo_size - fw_shared_size;
> +		adev->vcn.inst[i].fw_shared.cpu_addr = adev->vcn.inst[i].cpu_addr +
> +				bo_size - fw_shared_size;
> +		adev->vcn.inst[i].fw_shared.gpu_addr = adev->vcn.inst[i].gpu_addr +
> +				bo_size - fw_shared_size;
>   
> -	adev->vcn.inst[inst].fw_shared.mem_size = fw_shared_size;
> +		adev->vcn.inst[i].fw_shared.mem_size = fw_shared_size;
>   
> -	if (amdgpu_vcnfw_log) {
> -		adev->vcn.inst[inst].fw_shared.cpu_addr -= AMDGPU_VCNFW_LOG_SIZE;
> -		adev->vcn.inst[inst].fw_shared.gpu_addr -= AMDGPU_VCNFW_LOG_SIZE;
> -		adev->vcn.inst[inst].fw_shared.log_offset = log_offset;
> -	}
> +		if (amdgpu_vcnfw_log) {
> +			adev->vcn.inst[i].fw_shared.cpu_addr -= AMDGPU_VCNFW_LOG_SIZE;
> +			adev->vcn.inst[i].fw_shared.gpu_addr -= AMDGPU_VCNFW_LOG_SIZE;
> +			adev->vcn.inst[i].fw_shared.log_offset = log_offset;
> +		}
>   
> -	if (adev->vcn.indirect_sram) {
> -		r = amdgpu_bo_create_kernel(adev, 64 * 2 * 4, PAGE_SIZE,
> -				AMDGPU_GEM_DOMAIN_VRAM |
> -				AMDGPU_GEM_DOMAIN_GTT,
> -				&adev->vcn.inst[inst].dpg_sram_bo,
> -				&adev->vcn.inst[inst].dpg_sram_gpu_addr,
> -				&adev->vcn.inst[inst].dpg_sram_cpu_addr);
> -		if (r) {
> -			dev_err(adev->dev, "VCN %d (%d) failed to allocate DPG bo\n", inst, r);
> -			return r;
> +		if (adev->vcn.indirect_sram) {
> +			r = amdgpu_bo_create_kernel(adev, 64 * 2 * 4, PAGE_SIZE,
> +					AMDGPU_GEM_DOMAIN_VRAM |
> +					AMDGPU_GEM_DOMAIN_GTT,
> +					&adev->vcn.inst[i].dpg_sram_bo,
> +					&adev->vcn.inst[i].dpg_sram_gpu_addr,
> +					&adev->vcn.inst[i].dpg_sram_cpu_addr);
> +			if (r) {
> +				dev_err(adev->dev, "VCN %d (%d) failed to allocate DPG bo\n", i, r);
> +				return r;
> +			}
>   		}
>   	}
>   
>   	return 0;
>   }
>   
> -int amdgpu_vcn_sw_fini(struct amdgpu_device *adev, int inst)
> +int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
>   {
> -	int i;
> +	int i, j;
> +
> +	for (j = 0; j < adev->vcn.num_vcn_inst; ++j) {
> +		if (adev->vcn.harvest_config & (1 << j))
> +			continue;
>   
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		goto done;
> +		amdgpu_bo_free_kernel(
> +			&adev->vcn.inst[j].dpg_sram_bo,
> +			&adev->vcn.inst[j].dpg_sram_gpu_addr,
> +			(void **)&adev->vcn.inst[j].dpg_sram_cpu_addr);
>   
> -	amdgpu_bo_free_kernel(
> -		&adev->vcn.inst[inst].dpg_sram_bo,
> -		&adev->vcn.inst[inst].dpg_sram_gpu_addr,
> -		(void **)&adev->vcn.inst[inst].dpg_sram_cpu_addr);
> +		kvfree(adev->vcn.inst[j].saved_bo);
>   
> -	kvfree(adev->vcn.inst[inst].saved_bo);
> +		amdgpu_bo_free_kernel(&adev->vcn.inst[j].vcpu_bo,
> +					  &adev->vcn.inst[j].gpu_addr,
> +					  (void **)&adev->vcn.inst[j].cpu_addr);
>   
> -	amdgpu_bo_free_kernel(&adev->vcn.inst[inst].vcpu_bo,
> -				  &adev->vcn.inst[inst].gpu_addr,
> -				  (void **)&adev->vcn.inst[inst].cpu_addr);
> +		amdgpu_ring_fini(&adev->vcn.inst[j].ring_dec);
>   
> -	amdgpu_ring_fini(&adev->vcn.inst[inst].ring_dec);
> +		for (i = 0; i < adev->vcn.num_enc_rings; ++i)
> +			amdgpu_ring_fini(&adev->vcn.inst[j].ring_enc[i]);
>   
> -	for (i = 0; i < adev->vcn.num_enc_rings; ++i)
> -		amdgpu_ring_fini(&adev->vcn.inst[inst].ring_enc[i]);
> +		amdgpu_ucode_release(&adev->vcn.inst[j].fw);
> +	}
>   
> -	amdgpu_ucode_release(&adev->vcn.inst[inst].fw);
> -done:
>   	mutex_destroy(&adev->vcn.vcn1_jpeg1_workaround);
>   	mutex_destroy(&adev->vcn.vcn_pg_lock);
>   
> @@ -294,131 +294,134 @@ bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev, enum vcn_ring_type t
>   	return ret;
>   }
>   
> -int amdgpu_vcn_save_vcpu_bo(struct amdgpu_device *adev, int inst)
> +int amdgpu_vcn_save_vcpu_bo(struct amdgpu_device *adev)
>   {
>   	unsigned int size;
>   	void *ptr;
> -	int idx;
> -
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		return 0;
> +	int i, idx;
>   
> -	if (adev->vcn.inst[inst].vcpu_bo == NULL)
> -		return 0;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
> +		if (adev->vcn.inst[i].vcpu_bo == NULL)
> +			return 0;
>   
> -	size = amdgpu_bo_size(adev->vcn.inst[inst].vcpu_bo);
> -	ptr = adev->vcn.inst[inst].cpu_addr;
> +		size = amdgpu_bo_size(adev->vcn.inst[i].vcpu_bo);
> +		ptr = adev->vcn.inst[i].cpu_addr;
>   
> -	adev->vcn.inst[inst].saved_bo = kvmalloc(size, GFP_KERNEL);
> -	if (!adev->vcn.inst[inst].saved_bo)
> -		return -ENOMEM;
> +		adev->vcn.inst[i].saved_bo = kvmalloc(size, GFP_KERNEL);
> +		if (!adev->vcn.inst[i].saved_bo)
> +			return -ENOMEM;
>   
> -	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> -		memcpy_fromio(adev->vcn.inst[inst].saved_bo, ptr, size);
> -		drm_dev_exit(idx);
> +		if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> +			memcpy_fromio(adev->vcn.inst[i].saved_bo, ptr, size);
> +			drm_dev_exit(idx);
> +		}
>   	}
>   
>   	return 0;
>   }
>   
> -int amdgpu_vcn_suspend(struct amdgpu_device *adev, int inst)
> +int amdgpu_vcn_suspend(struct amdgpu_device *adev)
>   {
>   	bool in_ras_intr = amdgpu_ras_intr_triggered();
>   
> -	cancel_delayed_work_sync(&adev->vcn.inst[inst].idle_work);
> +	cancel_delayed_work_sync(&adev->vcn.idle_work);
>   
>   	/* err_event_athub will corrupt VCPU buffer, so we need to
>   	 * restore fw data and clear buffer in amdgpu_vcn_resume() */
>   	if (in_ras_intr)
>   		return 0;
>   
> -	return amdgpu_vcn_save_vcpu_bo(adev, inst);
> +	return amdgpu_vcn_save_vcpu_bo(adev);
>   }
>   
> -int amdgpu_vcn_resume(struct amdgpu_device *adev, int inst)
> +int amdgpu_vcn_resume(struct amdgpu_device *adev)
>   {
>   	unsigned int size;
>   	void *ptr;
> -	int idx;
> -
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		return 0;
> +	int i, idx;
>   
> -	if (adev->vcn.inst[inst].vcpu_bo == NULL)
> -		return -EINVAL;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
> +		if (adev->vcn.inst[i].vcpu_bo == NULL)
> +			return -EINVAL;
>   
> -	size = amdgpu_bo_size(adev->vcn.inst[inst].vcpu_bo);
> -	ptr = adev->vcn.inst[inst].cpu_addr;
> +		size = amdgpu_bo_size(adev->vcn.inst[i].vcpu_bo);
> +		ptr = adev->vcn.inst[i].cpu_addr;
>   
> -	if (adev->vcn.inst[inst].saved_bo != NULL) {
> -		if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> -			memcpy_toio(ptr, adev->vcn.inst[inst].saved_bo, size);
> -			drm_dev_exit(idx);
> -		}
> -		kvfree(adev->vcn.inst[inst].saved_bo);
> -		adev->vcn.inst[inst].saved_bo = NULL;
> -	} else {
> -		const struct common_firmware_header *hdr;
> -		unsigned int offset;
> -
> -		hdr = (const struct common_firmware_header *)adev->vcn.inst[inst].fw->data;
> -		if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
> -			offset = le32_to_cpu(hdr->ucode_array_offset_bytes);
> +		if (adev->vcn.inst[i].saved_bo != NULL) {
>   			if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> -				memcpy_toio(adev->vcn.inst[inst].cpu_addr,
> -						adev->vcn.inst[inst].fw->data + offset,
> -						le32_to_cpu(hdr->ucode_size_bytes));
> +				memcpy_toio(ptr, adev->vcn.inst[i].saved_bo, size);
>   				drm_dev_exit(idx);
>   			}
> -			size -= le32_to_cpu(hdr->ucode_size_bytes);
> -			ptr += le32_to_cpu(hdr->ucode_size_bytes);
> +			kvfree(adev->vcn.inst[i].saved_bo);
> +			adev->vcn.inst[i].saved_bo = NULL;
> +		} else {
> +			const struct common_firmware_header *hdr;
> +			unsigned int offset;
> +
> +			hdr = (const struct common_firmware_header *)adev->vcn.inst[i].fw->data;
> +			if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
> +				offset = le32_to_cpu(hdr->ucode_array_offset_bytes);
> +				if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> +					memcpy_toio(adev->vcn.inst[i].cpu_addr,
> +						    adev->vcn.inst[i].fw->data + offset,
> +						    le32_to_cpu(hdr->ucode_size_bytes));
> +					drm_dev_exit(idx);
> +				}
> +				size -= le32_to_cpu(hdr->ucode_size_bytes);
> +				ptr += le32_to_cpu(hdr->ucode_size_bytes);
> +			}
> +			memset_io(ptr, 0, size);
>   		}
> -		memset_io(ptr, 0, size);
>   	}
> -
>   	return 0;
>   }
>   
>   static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>   {
> -	struct amdgpu_vcn_inst *vcn_inst =
> -		container_of(work, struct amdgpu_vcn_inst, idle_work.work);
> -	struct amdgpu_device *adev = vcn_inst->adev;
> -	unsigned int inst = vcn_inst->work_inst;
> -	unsigned int fence = 0;
> -	unsigned int i;
> +	struct amdgpu_device *adev =
> +		container_of(work, struct amdgpu_device, vcn.idle_work.work);
> +	unsigned int fences = 0, fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
> +	unsigned int i, j;
>   	int r = 0;
>   
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		return;
> +	for (j = 0; j < adev->vcn.num_vcn_inst; ++j) {
> +		if (adev->vcn.harvest_config & (1 << j))
> +			continue;
>   
> -	for (i = 0; i < adev->vcn.num_enc_rings; ++i)
> -		fence += amdgpu_fence_count_emitted(&adev->vcn.inst[inst].ring_enc[i]);
> +		for (i = 0; i < adev->vcn.num_enc_rings; ++i)
> +			fence[j] += amdgpu_fence_count_emitted(&adev->vcn.inst[j].ring_enc[i]);
>   
> -	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
> -	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
> -			!adev->vcn.using_unified_queue) {
> -		struct dpg_pause_state new_state;
> -		if (fence ||
> -				unlikely(atomic_read(&adev->vcn.inst[inst].dpg_enc_submission_cnt)))
> -			new_state.fw_based = VCN_DPG_STATE__PAUSE;
> -		else
> -			new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
> -		adev->vcn.pause_dpg_mode(adev, inst, &new_state);
> -	}
> +		/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
> +		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
> +		    !adev->vcn.using_unified_queue) {
> +			struct dpg_pause_state new_state;
>   
> -	fence += amdgpu_fence_count_emitted(&adev->vcn.inst[inst].ring_dec);
> +			if (fence[j] ||
> +				unlikely(atomic_read(&adev->vcn.inst[j].dpg_enc_submission_cnt)))
> +				new_state.fw_based = VCN_DPG_STATE__PAUSE;
> +			else
> +				new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
>   
> -	if (!fence && !atomic_read(&adev->vcn.total_submission_cnt)) {
> -		amdgpu_device_ip_set_powergating_state(adev,
> -			AMD_IP_BLOCK_TYPE_VCN, AMD_PG_STATE_GATE, inst);
> +			adev->vcn.pause_dpg_mode(adev, j, &new_state);
> +		}
> +
> +		fence[j] += amdgpu_fence_count_emitted(&adev->vcn.inst[j].ring_dec);
> +		fences += fence[j];
> +	}
>   
> +	if (!fences && !atomic_read(&adev->vcn.total_submission_cnt)) {
> +		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
> +		       AMD_PG_STATE_GATE);
>   		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
> -											false);
> +				false);
>   		if (r)
>   			dev_warn(adev->dev, "(%d) failed to disable video power profile mode\n", r);
>   	} else {
> -		schedule_delayed_work(&adev->vcn.inst[inst].idle_work, VCN_IDLE_TIMEOUT);
> +		schedule_delayed_work(&adev->vcn.idle_work, VCN_IDLE_TIMEOUT);
>   	}
>   }
>   
> @@ -429,7 +432,7 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>   
>   	atomic_inc(&adev->vcn.total_submission_cnt);
>   
> -	if (!cancel_delayed_work_sync(&adev->vcn.inst[ring->me].idle_work)) {
> +	if (!cancel_delayed_work_sync(&adev->vcn.idle_work)) {
>   		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
>   				true);
>   		if (r)
> @@ -437,9 +440,8 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>   	}
>   
>   	mutex_lock(&adev->vcn.vcn_pg_lock);
> -
> -	amdgpu_device_ip_set_powergating_state(adev,
> -		AMD_IP_BLOCK_TYPE_VCN, AMD_PG_STATE_UNGATE, ring->me);
> +	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
> +	       AMD_PG_STATE_UNGATE);
>   
>   	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
> @@ -479,7 +481,7 @@ void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring)
>   
>   	atomic_dec(&ring->adev->vcn.total_submission_cnt);
>   
> -	schedule_delayed_work(&ring->adev->vcn.inst[ring->me].idle_work, VCN_IDLE_TIMEOUT);
> +	schedule_delayed_work(&ring->adev->vcn.idle_work, VCN_IDLE_TIMEOUT);
>   }
>   
>   int amdgpu_vcn_dec_ring_test_ring(struct amdgpu_ring *ring)
> @@ -1049,31 +1051,34 @@ enum amdgpu_ring_priority_level amdgpu_vcn_get_enc_ring_prio(int ring)
>   	}
>   }
>   
> -void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev, int inst)
> +void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev)
>   {
> +	int i;
>   	unsigned int idx;
>   
>   	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
>   		const struct common_firmware_header *hdr;
>   
> -		if (adev->vcn.harvest_config & (1 << inst))
> -			return;
> +		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +			if (adev->vcn.harvest_config & (1 << i))
> +				continue;
>   
> -		hdr = (const struct common_firmware_header *)adev->vcn.inst[inst].fw->data;
> -		/* currently only support 2 FW instances */
> -		if (inst >= 2) {
> -			dev_info(adev->dev, "More then 2 VCN FW instances!\n");
> -			return;
> +			hdr = (const struct common_firmware_header *)adev->vcn.inst[i].fw->data;
> +			/* currently only support 2 FW instances */
> +			if (i >= 2) {
> +				dev_info(adev->dev, "More then 2 VCN FW instances!\n");
> +				break;
> +			}
> +			idx = AMDGPU_UCODE_ID_VCN + i;
> +			adev->firmware.ucode[idx].ucode_id = idx;
> +			adev->firmware.ucode[idx].fw = adev->vcn.inst[i].fw;
> +			adev->firmware.fw_size +=
> +				ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
> +
> +			if (amdgpu_ip_version(adev, UVD_HWIP, 0) ==
> +			    IP_VERSION(4, 0, 3))
> +				break;
>   		}
> -		idx = AMDGPU_UCODE_ID_VCN + inst;
> -		adev->firmware.ucode[idx].ucode_id = idx;
> -		adev->firmware.ucode[idx].fw = adev->vcn.inst[inst].fw;
> -		adev->firmware.fw_size +=
> -			ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
> -
> -		if (amdgpu_ip_version(adev, UVD_HWIP, 0) ==
> -			IP_VERSION(4, 0, 3))
> -			return;
>   	}
>   }
>   
> @@ -1278,43 +1283,3 @@ int amdgpu_vcn_psp_update_sram(struct amdgpu_device *adev, int inst_idx,
>   
>   	return psp_execute_ip_fw_load(&adev->psp, &ucode);
>   }
> -
> -static ssize_t amdgpu_get_vcn_reset_mask(struct device *dev,
> -						struct device_attribute *attr,
> -						char *buf)
> -{
> -	struct drm_device *ddev = dev_get_drvdata(dev);
> -	struct amdgpu_device *adev = drm_to_adev(ddev);
> -
> -	if (!adev)
> -		return -ENODEV;
> -
> -	return amdgpu_show_reset_mask(buf, adev->vcn.supported_reset);
> -}
> -
> -static DEVICE_ATTR(vcn_reset_mask, 0444,
> -		   amdgpu_get_vcn_reset_mask, NULL);
> -
> -int amdgpu_vcn_sysfs_reset_mask_init(struct amdgpu_device *adev)
> -{
> -	int r = 0;
> -
> -	if (adev->vcn.num_vcn_inst) {
> -		r = device_create_file(adev->dev, &dev_attr_vcn_reset_mask);
> -		if (r)
> -			return r;
> -	}
> -
> -	return r;
> -}
> -
> -void amdgpu_vcn_sysfs_reset_mask_fini(struct amdgpu_device *adev)
> -{
> -	int idx;
> -
> -	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> -		if (adev->vcn.num_vcn_inst)
> -			device_remove_file(adev->dev, &dev_attr_vcn_reset_mask);
> -		drm_dev_exit(idx);
> -	}
> -}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index 7ff4ae2a0432..ba58b4f07643 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -279,7 +279,6 @@ struct amdgpu_vcn_fw_shared {
>   };
>   
>   struct amdgpu_vcn_inst {
> -	struct amdgpu_device *adev;
>   	struct amdgpu_bo	*vcpu_bo;
>   	void			*cpu_addr;
>   	uint64_t		gpu_addr;
> @@ -299,11 +298,8 @@ struct amdgpu_vcn_inst {
>   	struct amdgpu_vcn_fw_shared fw_shared;
>   	uint8_t			aid_id;
>   	const struct firmware	*fw; /* VCN firmware */
> -	enum amd_powergating_state cur_state;
>   	uint8_t			vcn_config;
>   	uint32_t		vcn_codec_disable_mask;
> -	struct delayed_work	idle_work;
> -	uint8_t 		work_inst;
>   };
>   
>   struct amdgpu_vcn_ras {
> @@ -312,7 +308,9 @@ struct amdgpu_vcn_ras {
>   
>   struct amdgpu_vcn {
>   	unsigned		fw_version;
> +	struct delayed_work	idle_work;
>   	unsigned		num_enc_rings;
> +	enum amd_powergating_state cur_state;
>   	bool			indirect_sram;
>   
>   	uint8_t	num_vcn_inst;
> @@ -332,7 +330,9 @@ struct amdgpu_vcn {
>   	uint16_t inst_mask;
>   	uint8_t	num_inst_per_aid;
>   	bool using_unified_queue;
> -	uint32_t		supported_reset;
> +
> +	/* IP reg dump */
> +	uint32_t		*ip_dump;
>   };
>   
>   struct amdgpu_fw_shared_rb_ptrs_struct {
> @@ -481,11 +481,11 @@ enum vcn_ring_type {
>   	VCN_UNIFIED_RING,
>   };
>   
> -int amdgpu_vcn_early_init(struct amdgpu_device *adev, int inst);
> -int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int inst);
> -int amdgpu_vcn_sw_fini(struct amdgpu_device *adev, int inst);
> -int amdgpu_vcn_suspend(struct amdgpu_device *adev, int inst);
> -int amdgpu_vcn_resume(struct amdgpu_device *adev, int inst);
> +int amdgpu_vcn_early_init(struct amdgpu_device *adev);
> +int amdgpu_vcn_sw_init(struct amdgpu_device *adev);
> +int amdgpu_vcn_sw_fini(struct amdgpu_device *adev);
> +int amdgpu_vcn_suspend(struct amdgpu_device *adev);
> +int amdgpu_vcn_resume(struct amdgpu_device *adev);
>   void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring);
>   void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring);
>   
> @@ -503,7 +503,7 @@ int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout);
>   
>   enum amdgpu_ring_priority_level amdgpu_vcn_get_enc_ring_prio(int ring);
>   
> -void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev, int inst);
> +void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev);
>   
>   void amdgpu_vcn_fwlog_init(struct amdgpu_vcn_inst *vcn);
>   void amdgpu_debugfs_vcn_fwlog_init(struct amdgpu_device *adev,
> @@ -518,8 +518,6 @@ int amdgpu_vcn_ras_sw_init(struct amdgpu_device *adev);
>   
>   int amdgpu_vcn_psp_update_sram(struct amdgpu_device *adev, int inst_idx,
>   			       enum AMDGPU_UCODE_ID ucode_id);
> -int amdgpu_vcn_save_vcpu_bo(struct amdgpu_device *adev, int inst);
> -int amdgpu_vcn_sysfs_reset_mask_init(struct amdgpu_device *adev);
> -void amdgpu_vcn_sysfs_reset_mask_fini(struct amdgpu_device *adev);
> +int amdgpu_vcn_save_vcpu_bo(struct amdgpu_device *adev);
>   
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> index b5f5a1a81c29..74e671c74142 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> @@ -330,7 +330,7 @@ static void vpe_idle_work_handler(struct work_struct *work)
>   	fences += amdgpu_fence_count_emitted(&adev->vpe.ring);
>   
>   	if (fences == 0)
> -		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE, AMD_PG_STATE_GATE, 0);
> +		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE, AMD_PG_STATE_GATE);
>   	else
>   		schedule_delayed_work(&adev->vpe.idle_work, VPE_IDLE_TIMEOUT);
>   }
> @@ -414,7 +414,7 @@ static int vpe_hw_init(struct amdgpu_ip_block *ip_block)
>   
>   	/* Power on VPE */
>   	ret = amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE,
> -						     AMD_PG_STATE_UNGATE, 0);
> +						     AMD_PG_STATE_UNGATE);
>   	if (ret)
>   		return ret;
>   
> @@ -437,7 +437,7 @@ static int vpe_hw_fini(struct amdgpu_ip_block *ip_block)
>   	vpe_ring_stop(vpe);
>   
>   	/* Power off VPE */
> -	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE, AMD_PG_STATE_GATE, 0);
> +	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE, AMD_PG_STATE_GATE);
>   
>   	return 0;
>   }
> @@ -853,7 +853,7 @@ static void vpe_ring_begin_use(struct amdgpu_ring *ring)
>   		uint32_t context_notify;
>   
>   		/* Power on VPE */
> -		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE, AMD_PG_STATE_UNGATE, 0);
> +		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE, AMD_PG_STATE_UNGATE);
>   
>   		/* Indicates that a job from a new context has been submitted. */
>   		context_notify = RREG32(vpe_get_reg_offset(vpe, 0, vpe->regs.context_indicator));
> @@ -904,13 +904,8 @@ int amdgpu_vpe_sysfs_reset_mask_init(struct amdgpu_device *adev)
>   
>   void amdgpu_vpe_sysfs_reset_mask_fini(struct amdgpu_device *adev)
>   {
> -	int idx;
> -
> -	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> -		if (adev->vpe.num_instances)
> -			device_remove_file(adev->dev, &dev_attr_vpe_reset_mask);
> -		drm_dev_exit(idx);
> -	}
> +	if (adev->vpe.num_instances)
> +		device_remove_file(adev->dev, &dev_attr_vpe_reset_mask);
>   }
>   
>   static const struct amdgpu_ring_funcs vpe_ring_funcs = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> index 54c05af2eed2..483a441b46aa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> +++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> @@ -20,7 +20,6 @@
>    * OTHER DEALINGS IN THE SOFTWARE.
>    *
>    */
> -#include <drm/drm_drv.h>
>   #include "amdgpu.h"
>   #include "df_v3_6.h"
>   
> @@ -255,12 +254,9 @@ static void df_v3_6_sw_init(struct amdgpu_device *adev)
>   
>   static void df_v3_6_sw_fini(struct amdgpu_device *adev)
>   {
> -	int idx;
>   
> -	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> -		device_remove_file(adev->dev, &dev_attr_df_cntr_avail);
> -		drm_dev_exit(idx);
> -	}
> +	device_remove_file(adev->dev, &dev_attr_df_cntr_avail);
> +
>   }
>   
>   static void df_v3_6_enable_broadcast_mode(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
> index 8031406e20ff..03b8b7cd5229 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
> @@ -604,7 +604,7 @@ static void jpeg_v1_0_set_irq_funcs(struct amdgpu_device *adev)
>   static void jpeg_v1_0_ring_begin_use(struct amdgpu_ring *ring)
>   {
>   	struct	amdgpu_device *adev = ring->adev;
> -	bool	set_clocks = !cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
> +	bool	set_clocks = !cancel_delayed_work_sync(&adev->vcn.idle_work);
>   	int		cnt = 0;
>   
>   	mutex_lock(&adev->vcn.vcn1_jpeg1_workaround);
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> index aed61615299d..1100d832abfc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> @@ -150,7 +150,7 @@ static int jpeg_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
>   
> -	cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
> +	cancel_delayed_work_sync(&adev->vcn.idle_work);
>   
>   	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
>   	      RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS))
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> index 28a1e8ce417f..3d72e383b7df 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> @@ -211,7 +211,7 @@ static int jpeg_v2_5_hw_fini(struct amdgpu_ip_block *ip_block)
>   	struct amdgpu_device *adev = ip_block->adev;
>   	int i;
>   
> -	cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
> +	cancel_delayed_work_sync(&adev->vcn.idle_work);
>   
>   	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>   		if (adev->jpeg.harvest_config & (1 << i))
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> index f83c7a58b91a..200403a07d34 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> @@ -164,7 +164,7 @@ static int jpeg_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
>   
> -	cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
> +	cancel_delayed_work_sync(&adev->vcn.idle_work);
>   
>   	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
>   	      RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS))
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> index db5b13b46339..afba0eaa1500 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> @@ -202,7 +202,7 @@ static int jpeg_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
>   
> -	cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
> +	cancel_delayed_work_sync(&adev->vcn.idle_work);
>   	if (!amdgpu_sriov_vf(adev)) {
>   		if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
>   			RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> index ec8118e3668f..e05ca131c1e6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> @@ -227,7 +227,7 @@ static int jpeg_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
>   	struct amdgpu_device *adev = ip_block->adev;
>   	int i;
>   
> -	cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
> +	cancel_delayed_work_sync(&adev->vcn.idle_work);
>   
>   	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>   		if (adev->jpeg.harvest_config & (1 << i))
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> index 1889b8a7ec82..8a14108361d4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> @@ -168,7 +168,7 @@ static int jpeg_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
>   
> -	cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
> +	cancel_delayed_work_sync(&adev->vcn.idle_work);
>   
>   	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
>   	      RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> index 0986f7a83401..5830e799c0a3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> @@ -735,7 +735,7 @@ static int uvd_v3_1_suspend(struct amdgpu_ip_block *ip_block)
>   		amdgpu_asic_set_uvd_clocks(adev, 0, 0);
>   		/* shutdown the UVD block */
>   		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
> -						       AMD_PG_STATE_GATE, 0);
> +						       AMD_PG_STATE_GATE);
>   		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
>   						       AMD_CG_STATE_GATE);
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> index 565632478c3e..f93079e09215 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> @@ -249,7 +249,7 @@ static int uvd_v4_2_suspend(struct amdgpu_ip_block *ip_block)
>   		amdgpu_asic_set_uvd_clocks(adev, 0, 0);
>   		/* shutdown the UVD block */
>   		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
> -						       AMD_PG_STATE_GATE, 0);
> +						       AMD_PG_STATE_GATE);
>   		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
>   						       AMD_CG_STATE_GATE);
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> index ce7f205899f2..050a0f309390 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> @@ -247,7 +247,7 @@ static int uvd_v5_0_suspend(struct amdgpu_ip_block *ip_block)
>   		amdgpu_asic_set_uvd_clocks(adev, 0, 0);
>   		/* shutdown the UVD block */
>   		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
> -						       AMD_PG_STATE_GATE, 0);
> +						       AMD_PG_STATE_GATE);
>   		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
>   						       AMD_CG_STATE_GATE);
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> index ccf8dde8cd71..d9d036ee51fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> @@ -571,7 +571,7 @@ static int uvd_v6_0_suspend(struct amdgpu_ip_block *ip_block)
>   		amdgpu_asic_set_uvd_clocks(adev, 0, 0);
>   		/* shutdown the UVD block */
>   		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
> -						       AMD_PG_STATE_GATE, 0);
> +						       AMD_PG_STATE_GATE);
>   		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
>   						       AMD_CG_STATE_GATE);
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> index c93eb5122bd1..53249d4ff8ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> @@ -639,7 +639,7 @@ static int uvd_v7_0_suspend(struct amdgpu_ip_block *ip_block)
>   		amdgpu_asic_set_uvd_clocks(adev, 0, 0);
>   		/* shutdown the UVD block */
>   		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
> -						       AMD_PG_STATE_GATE, 0);
> +						       AMD_PG_STATE_GATE);
>   		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
>   						       AMD_CG_STATE_GATE);
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> index 4b4d295802a2..c633b7ff2943 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> @@ -512,7 +512,7 @@ static int vce_v2_0_suspend(struct amdgpu_ip_block *ip_block)
>   	} else {
>   		amdgpu_asic_set_vce_clocks(adev, 0, 0);
>   		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
> -						       AMD_PG_STATE_GATE, 0);
> +						       AMD_PG_STATE_GATE);
>   		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
>   						       AMD_CG_STATE_GATE);
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> index fc7d80c2a841..f8bddcd19b68 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> @@ -523,7 +523,7 @@ static int vce_v3_0_suspend(struct amdgpu_ip_block *ip_block)
>   	} else {
>   		amdgpu_asic_set_vce_clocks(adev, 0, 0);
>   		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
> -						       AMD_PG_STATE_GATE, 0);
> +						       AMD_PG_STATE_GATE);
>   		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
>   						       AMD_CG_STATE_GATE);
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> index e7b6f8cc8b74..335bda64ff5b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> @@ -589,7 +589,7 @@ static int vce_v4_0_suspend(struct amdgpu_ip_block *ip_block)
>   	} else {
>   		amdgpu_asic_set_vce_clocks(adev, 0, 0);
>   		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
> -						       AMD_PG_STATE_GATE, 0);
> +						       AMD_PG_STATE_GATE);
>   		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
>   						       AMD_CG_STATE_GATE);
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index f31fdd620c86..5ea96c983517 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -104,7 +104,6 @@ static void vcn_v1_0_ring_begin_use(struct amdgpu_ring *ring);
>   static int vcn_v1_0_early_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int inst = ip_block->instance;
>   
>   	adev->vcn.num_enc_rings = 2;
>   
> @@ -114,7 +113,7 @@ static int vcn_v1_0_early_init(struct amdgpu_ip_block *ip_block)
>   
>   	jpeg_v1_0_early_init(ip_block);
>   
> -	return amdgpu_vcn_early_init(adev, inst);
> +	return amdgpu_vcn_early_init(adev);
>   }
>   
>   /**
> @@ -126,12 +125,11 @@ static int vcn_v1_0_early_init(struct amdgpu_ip_block *ip_block)
>    */
>   static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = ip_block->adev;
> -	int inst = ip_block->instance;
>   	struct amdgpu_ring *ring;
>   	int i, r;
>   	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_1_0);
>   	uint32_t *ptr;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	/* VCN DEC TRAP */
>   	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
> @@ -147,16 +145,16 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
>   			return r;
>   	}
>   
> -	r = amdgpu_vcn_sw_init(adev, inst);
> +	r = amdgpu_vcn_sw_init(adev);
>   	if (r)
>   		return r;
>   
>   	/* Override the work func */
> -	adev->vcn.inst[0].idle_work.work.func = vcn_v1_0_idle_work_handler;
> +	adev->vcn.idle_work.work.func = vcn_v1_0_idle_work_handler;
>   
> -	amdgpu_vcn_setup_ucode(adev, inst);
> +	amdgpu_vcn_setup_ucode(adev);
>   
> -	r = amdgpu_vcn_resume(adev, inst);
> +	r = amdgpu_vcn_resume(adev);
>   	if (r)
>   		return r;
>   
> @@ -203,12 +201,12 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	r = jpeg_v1_0_sw_init(ip_block);
>   
>   	/* Allocate memory for VCN IP Dump buffer */
> -	ptr = kcalloc(reg_count, sizeof(uint32_t), GFP_KERNEL);
> +	ptr = kcalloc(adev->vcn.num_vcn_inst * reg_count, sizeof(uint32_t), GFP_KERNEL);
>   	if (!ptr) {
>   		DRM_ERROR("Failed to allocate memory for VCN IP Dump\n");
> -		ip_block->ip_dump = NULL;
> +		adev->vcn.ip_dump = NULL;
>   	} else {
> -		ip_block->ip_dump = ptr;
> +		adev->vcn.ip_dump = ptr;
>   	}
>   	return r;
>   }
> @@ -222,19 +220,18 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
>    */
>   static int vcn_v1_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = ip_block->adev;
> -	int inst = ip_block->instance;
>   	int r;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
> -	r = amdgpu_vcn_suspend(adev, inst);
> +	r = amdgpu_vcn_suspend(adev);
>   	if (r)
>   		return r;
>   
>   	jpeg_v1_0_sw_fini(ip_block);
>   
> -	r = amdgpu_vcn_sw_fini(adev, inst);
> +	r = amdgpu_vcn_sw_fini(adev);
>   
> -	kfree(ip_block->ip_dump);
> +	kfree(adev->vcn.ip_dump);
>   
>   	return r;
>   }
> @@ -280,10 +277,10 @@ static int vcn_v1_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
>   
> -	cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
> +	cancel_delayed_work_sync(&adev->vcn.idle_work);
>   
>   	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> -		(adev->vcn.inst[0].cur_state != AMD_PG_STATE_GATE &&
> +		(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
>   		 RREG32_SOC15(VCN, 0, mmUVD_STATUS))) {
>   		vcn_v1_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
>   	}
> @@ -300,12 +297,11 @@ static int vcn_v1_0_hw_fini(struct amdgpu_ip_block *ip_block)
>    */
>   static int vcn_v1_0_suspend(struct amdgpu_ip_block *ip_block)
>   {
> +	int r;
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int inst = ip_block->instance;
>   	bool idle_work_unexecuted;
> -	int r;
>   
> -	idle_work_unexecuted = cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
> +	idle_work_unexecuted = cancel_delayed_work_sync(&adev->vcn.idle_work);
>   	if (idle_work_unexecuted) {
>   		if (adev->pm.dpm_enabled)
>   			amdgpu_dpm_enable_vcn(adev, false, 0);
> @@ -315,7 +311,7 @@ static int vcn_v1_0_suspend(struct amdgpu_ip_block *ip_block)
>   	if (r)
>   		return r;
>   
> -	r = amdgpu_vcn_suspend(adev, inst);
> +	r = amdgpu_vcn_suspend(adev);
>   
>   	return r;
>   }
> @@ -331,7 +327,7 @@ static int vcn_v1_0_resume(struct amdgpu_ip_block *ip_block)
>   {
>   	int r;
>   
> -	r = amdgpu_vcn_resume(ip_block->adev, ip_block->instance);
> +	r = amdgpu_vcn_resume(ip_block->adev);
>   	if (r)
>   		return r;
>   
> @@ -1817,7 +1813,7 @@ static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   	int ret;
>   	struct amdgpu_device *adev = ip_block->adev;
>   
> -	if (state == adev->vcn.inst[0].cur_state)
> +	if (state == adev->vcn.cur_state)
>   		return 0;
>   
>   	if (state == AMD_PG_STATE_GATE)
> @@ -1826,15 +1822,14 @@ static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   		ret = vcn_v1_0_start(adev);
>   
>   	if (!ret)
> -		adev->vcn.inst[0].cur_state = state;
> -
> +		adev->vcn.cur_state = state;
>   	return ret;
>   }
>   
>   static void vcn_v1_0_idle_work_handler(struct work_struct *work)
>   {
>   	struct amdgpu_device *adev =
> -		container_of(work, struct amdgpu_device, vcn.inst[0].idle_work.work);
> +		container_of(work, struct amdgpu_device, vcn.idle_work.work);
>   	unsigned int fences = 0, i;
>   
>   	for (i = 0; i < adev->vcn.num_enc_rings; ++i)
> @@ -1865,16 +1860,16 @@ static void vcn_v1_0_idle_work_handler(struct work_struct *work)
>   			amdgpu_dpm_enable_vcn(adev, false, 0);
>   		else
>   			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
> -			       AMD_PG_STATE_GATE, 0);
> +			       AMD_PG_STATE_GATE);
>   	} else {
> -		schedule_delayed_work(&adev->vcn.inst[0].idle_work, VCN_IDLE_TIMEOUT);
> +		schedule_delayed_work(&adev->vcn.idle_work, VCN_IDLE_TIMEOUT);
>   	}
>   }
>   
>   static void vcn_v1_0_ring_begin_use(struct amdgpu_ring *ring)
>   {
>   	struct	amdgpu_device *adev = ring->adev;
> -	bool set_clocks = !cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
> +	bool set_clocks = !cancel_delayed_work_sync(&adev->vcn.idle_work);
>   
>   	mutex_lock(&adev->vcn.vcn1_jpeg1_workaround);
>   
> @@ -1895,7 +1890,7 @@ void vcn_v1_0_set_pg_for_begin_use(struct amdgpu_ring *ring, bool set_clocks)
>   			amdgpu_dpm_enable_vcn(adev, true, 0);
>   		else
>   			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
> -			       AMD_PG_STATE_UNGATE, 0);
> +			       AMD_PG_STATE_UNGATE);
>   	}
>   
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> @@ -1926,65 +1921,68 @@ void vcn_v1_0_set_pg_for_begin_use(struct amdgpu_ring *ring, bool set_clocks)
>   
>   void vcn_v1_0_ring_end_use(struct amdgpu_ring *ring)
>   {
> -	schedule_delayed_work(&ring->adev->vcn.inst[0].idle_work, VCN_IDLE_TIMEOUT);
> +	schedule_delayed_work(&ring->adev->vcn.idle_work, VCN_IDLE_TIMEOUT);
>   	mutex_unlock(&ring->adev->vcn.vcn1_jpeg1_workaround);
>   }
>   
>   static void vcn_v1_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int i;
> +	int i, j;
>   	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_1_0);
> -	uint32_t is_powered;
> -	int inst = ip_block->instance;
> +	uint32_t inst_off, is_powered;
>   
> -	if (!ip_block->ip_dump)
> +	if (!adev->vcn.ip_dump)
>   		return;
>   
> -	drm_printf(p, "Instance no:VCN%d\n", inst);
> -
> -	if (adev->vcn.harvest_config & (1 << inst)) {
> -		drm_printf(p, "\nHarvested Instance:VCN%d Skipping dump\n", inst);
> -		return;
> -	}
> +	drm_printf(p, "num_instances:%d\n", adev->vcn.num_vcn_inst);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		if (adev->vcn.harvest_config & (1 << i)) {
> +			drm_printf(p, "\nHarvested Instance:VCN%d Skipping dump\n", i);
> +			continue;
> +		}
>   
> -	is_powered = (ip_block->ip_dump[0] &
> -		      UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
> +		inst_off = i * reg_count;
> +		is_powered = (adev->vcn.ip_dump[inst_off] &
> +				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
>   
> -	if (is_powered) {
> -		drm_printf(p, "\nActive Instance:VCN%d\n", inst);
> -		for (i = 0; i < reg_count; i++)
> -			drm_printf(p, "%-50s \t 0x%08x\n",
> -				   vcn_reg_list_1_0[i].reg_name,
> -				   ip_block->ip_dump[i]);
> -	} else {
> -		drm_printf(p, "\nInactive Instance:VCN%d\n", inst);
> +		if (is_powered) {
> +			drm_printf(p, "\nActive Instance:VCN%d\n", i);
> +			for (j = 0; j < reg_count; j++)
> +				drm_printf(p, "%-50s \t 0x%08x\n", vcn_reg_list_1_0[j].reg_name,
> +					   adev->vcn.ip_dump[inst_off + j]);
> +		} else {
> +			drm_printf(p, "\nInactive Instance:VCN%d\n", i);
> +		}
>   	}
>   }
>   
>   static void vcn_v1_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int i;
> -	int inst = ip_block->instance;
> +	int i, j;
>   	bool is_powered;
> +	uint32_t inst_off;
>   	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_1_0);
>   
> -	if (!ip_block->ip_dump)
> +	if (!adev->vcn.ip_dump)
>   		return;
>   
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		return;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
>   
> -	/* mmUVD_POWER_STATUS is always readable and is first element of the array */
> -	ip_block->ip_dump[0] = RREG32_SOC15(VCN, inst, mmUVD_POWER_STATUS);
> -	is_powered = (ip_block->ip_dump[0] &
> -		      UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
> +		inst_off = i * reg_count;
> +		/* mmUVD_POWER_STATUS is always readable and is first element of the array */
> +		adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, mmUVD_POWER_STATUS);
> +		is_powered = (adev->vcn.ip_dump[inst_off] &
> +				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
>   
> -	if (is_powered)
> -		for (i = 1; i < reg_count; i++)
> -			ip_block->ip_dump[i] =
> -				RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_1_0[i], inst));
> +		if (is_powered)
> +			for (j = 1; j < reg_count; j++)
> +				adev->vcn.ip_dump[inst_off + j] =
> +					RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_1_0[j], i));
> +	}
>   }
>   
>   static const struct amd_ip_funcs vcn_v1_0_ip_funcs = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index f1c28944ff3e..e42cfc731ad8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -108,7 +108,6 @@ static int vcn_v2_0_start_sriov(struct amdgpu_device *adev);
>   static int vcn_v2_0_early_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int inst = ip_block->instance;
>   
>   	if (amdgpu_sriov_vf(adev))
>   		adev->vcn.num_enc_rings = 1;
> @@ -119,7 +118,7 @@ static int vcn_v2_0_early_init(struct amdgpu_ip_block *ip_block)
>   	vcn_v2_0_set_enc_ring_funcs(adev);
>   	vcn_v2_0_set_irq_funcs(adev);
>   
> -	return amdgpu_vcn_early_init(adev, inst);
> +	return amdgpu_vcn_early_init(adev);
>   }
>   
>   /**
> @@ -131,12 +130,11 @@ static int vcn_v2_0_early_init(struct amdgpu_ip_block *ip_block)
>    */
>   static int vcn_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = ip_block->adev;
> -	int inst = ip_block->instance;
>   	struct amdgpu_ring *ring;
>   	int i, r;
>   	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_2_0);
>   	uint32_t *ptr;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	volatile struct amdgpu_fw_shared *fw_shared;
>   
>   	/* VCN DEC TRAP */
> @@ -155,13 +153,13 @@ static int vcn_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
>   			return r;
>   	}
>   
> -	r = amdgpu_vcn_sw_init(adev, inst);
> +	r = amdgpu_vcn_sw_init(adev);
>   	if (r)
>   		return r;
>   
> -	amdgpu_vcn_setup_ucode(adev, inst);
> +	amdgpu_vcn_setup_ucode(adev);
>   
> -	r = amdgpu_vcn_resume(adev, inst);
> +	r = amdgpu_vcn_resume(adev);
>   	if (r)
>   		return r;
>   
> @@ -225,12 +223,12 @@ static int vcn_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
>   		amdgpu_vcn_fwlog_init(adev->vcn.inst);
>   
>   	/* Allocate memory for VCN IP Dump buffer */
> -	ptr = kcalloc(reg_count, sizeof(uint32_t), GFP_KERNEL);
> +	ptr = kcalloc(adev->vcn.num_vcn_inst * reg_count, sizeof(uint32_t), GFP_KERNEL);
>   	if (!ptr) {
>   		DRM_ERROR("Failed to allocate memory for VCN IP Dump\n");
> -		ip_block->ip_dump = NULL;
> +		adev->vcn.ip_dump = NULL;
>   	} else {
> -		ip_block->ip_dump = ptr;
> +		adev->vcn.ip_dump = ptr;
>   	}
>   
>   	return 0;
> @@ -245,10 +243,9 @@ static int vcn_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
>    */
>   static int vcn_v2_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   {
> +	int r, idx;
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int inst = ip_block->instance;
>   	volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst->fw_shared.cpu_addr;
> -	int r, idx;
>   
>   	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>   		fw_shared->present_flag_0 = 0;
> @@ -257,13 +254,13 @@ static int vcn_v2_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   
>   	amdgpu_virt_free_mm_table(adev);
>   
> -	r = amdgpu_vcn_suspend(adev, inst);
> +	r = amdgpu_vcn_suspend(adev);
>   	if (r)
>   		return r;
>   
> -	r = amdgpu_vcn_sw_fini(adev, inst);
> +	r = amdgpu_vcn_sw_fini(adev);
>   
> -	kfree(ip_block->ip_dump);
> +	kfree(adev->vcn.ip_dump);
>   
>   	return r;
>   }
> @@ -316,10 +313,10 @@ static int vcn_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
>   
> -	cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
> +	cancel_delayed_work_sync(&adev->vcn.idle_work);
>   
>   	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> -	    (adev->vcn.inst[0].cur_state != AMD_PG_STATE_GATE &&
> +	    (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
>   	      RREG32_SOC15(VCN, 0, mmUVD_STATUS)))
>   		vcn_v2_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
>   
> @@ -335,15 +332,13 @@ static int vcn_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
>    */
>   static int vcn_v2_0_suspend(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = ip_block->adev;
> -	int inst = ip_block->instance;
>   	int r;
>   
>   	r = vcn_v2_0_hw_fini(ip_block);
>   	if (r)
>   		return r;
>   
> -	r = amdgpu_vcn_suspend(adev, inst);
> +	r = amdgpu_vcn_suspend(ip_block->adev);
>   
>   	return r;
>   }
> @@ -359,7 +354,7 @@ static int vcn_v2_0_resume(struct amdgpu_ip_block *ip_block)
>   {
>   	int r;
>   
> -	r = amdgpu_vcn_resume(ip_block->adev, ip_block->instance);
> +	r = amdgpu_vcn_resume(ip_block->adev);
>   	if (r)
>   		return r;
>   
> @@ -1815,11 +1810,11 @@ static int vcn_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   	struct amdgpu_device *adev = ip_block->adev;
>   
>   	if (amdgpu_sriov_vf(adev)) {
> -		adev->vcn.inst[0].cur_state = AMD_PG_STATE_UNGATE;
> +		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
>   		return 0;
>   	}
>   
> -	if (state == adev->vcn.inst[0].cur_state)
> +	if (state == adev->vcn.cur_state)
>   		return 0;
>   
>   	if (state == AMD_PG_STATE_GATE)
> @@ -1828,8 +1823,7 @@ static int vcn_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   		ret = vcn_v2_0_start(adev);
>   
>   	if (!ret)
> -		adev->vcn.inst[0].cur_state = state;
> -
> +		adev->vcn.cur_state = state;
>   	return ret;
>   }
>   
> @@ -2041,58 +2035,61 @@ static int vcn_v2_0_start_sriov(struct amdgpu_device *adev)
>   static void vcn_v2_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int i;
> +	int i, j;
>   	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_2_0);
> -	uint32_t is_powered;
> -	int inst = ip_block->instance;
> +	uint32_t inst_off, is_powered;
>   
> -	if (!ip_block->ip_dump)
> +	if (!adev->vcn.ip_dump)
>   		return;
>   
> -	drm_printf(p, "Instance no:VCN%d\n", inst);
> -
> -	if (adev->vcn.harvest_config & (1 << inst)) {
> -		drm_printf(p, "\nHarvested Instance:VCN%d Skipping dump\n", inst);
> -		return;
> -	}
> +	drm_printf(p, "num_instances:%d\n", adev->vcn.num_vcn_inst);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		if (adev->vcn.harvest_config & (1 << i)) {
> +			drm_printf(p, "\nHarvested Instance:VCN%d Skipping dump\n", i);
> +			continue;
> +		}
>   
> -	is_powered = (ip_block->ip_dump[0] &
> -		      UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
> +		inst_off = i * reg_count;
> +		is_powered = (adev->vcn.ip_dump[inst_off] &
> +				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
>   
> -	if (is_powered) {
> -		drm_printf(p, "\nActive Instance:VCN%d\n", inst);
> -		for (i = 0; i < reg_count; i++)
> -			drm_printf(p, "%-50s \t 0x%08x\n",
> -				   vcn_reg_list_2_0[i].reg_name,
> -				   ip_block->ip_dump[i]);
> -	} else {
> -		drm_printf(p, "\nInactive Instance:VCN%d\n", inst);
> +		if (is_powered) {
> +			drm_printf(p, "\nActive Instance:VCN%d\n", i);
> +			for (j = 0; j < reg_count; j++)
> +				drm_printf(p, "%-50s \t 0x%08x\n", vcn_reg_list_2_0[j].reg_name,
> +					   adev->vcn.ip_dump[inst_off + j]);
> +		} else {
> +			drm_printf(p, "\nInactive Instance:VCN%d\n", i);
> +		}
>   	}
>   }
>   
>   static void vcn_v2_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int i;
> +	int i, j;
>   	bool is_powered;
> +	uint32_t inst_off;
>   	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_2_0);
> -	int inst = ip_block->instance;
>   
> -	if (!ip_block->ip_dump)
> +	if (!adev->vcn.ip_dump)
>   		return;
>   
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		return;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
>   
> -	/* mmUVD_POWER_STATUS is always readable and is first element of the array */
> -	ip_block->ip_dump[0] = RREG32_SOC15(VCN, inst, mmUVD_POWER_STATUS);
> -	is_powered = (ip_block->ip_dump[0] &
> -		      UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
> +		inst_off = i * reg_count;
> +		/* mmUVD_POWER_STATUS is always readable and is first element of the array */
> +		adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, mmUVD_POWER_STATUS);
> +		is_powered = (adev->vcn.ip_dump[inst_off] &
> +				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
>   
> -	if (is_powered)
> -		for (i = 1; i < reg_count; i++)
> -			ip_block->ip_dump[i] =
> -				RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_2_0[i], inst));
> +		if (is_powered)
> +			for (j = 1; j < reg_count; j++)
> +				adev->vcn.ip_dump[inst_off + j] =
> +					RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_2_0[j], i));
> +	}
>   }
>   
>   static const struct amd_ip_funcs vcn_v2_0_ip_funcs = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index bdbc04ec31a0..b518202955ca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -92,9 +92,9 @@ static const struct amdgpu_hwip_reg_entry vcn_reg_list_2_5[] = {
>   	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_DPG_PAUSE)
>   };
>   
> -static void vcn_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev, int inst);
> -static void vcn_v2_5_set_enc_ring_funcs(struct amdgpu_device *adev, int inst);
> -static void vcn_v2_5_set_irq_funcs(struct amdgpu_device *adev, int inst);
> +static void vcn_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev);
> +static void vcn_v2_5_set_enc_ring_funcs(struct amdgpu_device *adev);
> +static void vcn_v2_5_set_irq_funcs(struct amdgpu_device *adev);
>   static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   				enum amd_powergating_state state);
>   static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
> @@ -118,7 +118,6 @@ static int amdgpu_ih_clientid_vcns[] = {
>   static int vcn_v2_5_early_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int inst = ip_block->instance;
>   
>   	if (amdgpu_sriov_vf(adev)) {
>   		adev->vcn.num_vcn_inst = 2;
> @@ -126,11 +125,13 @@ static int vcn_v2_5_early_init(struct amdgpu_ip_block *ip_block)
>   		adev->vcn.num_enc_rings = 1;
>   	} else {
>   		u32 harvest;
> +		int i;
>   
> -		harvest = RREG32_SOC15(VCN, inst, mmCC_UVD_HARVESTING);
> -		if (harvest & CC_UVD_HARVESTING__UVD_DISABLE_MASK)
> -			adev->vcn.harvest_config |= 1 << inst;
> -
> +		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +			harvest = RREG32_SOC15(VCN, i, mmCC_UVD_HARVESTING);
> +			if (harvest & CC_UVD_HARVESTING__UVD_DISABLE_MASK)
> +				adev->vcn.harvest_config |= 1 << i;
> +		}
>   		if (adev->vcn.harvest_config == (AMDGPU_VCN_HARVEST_VCN0 |
>   					AMDGPU_VCN_HARVEST_VCN1))
>   			/* both instances are harvested, disable the block */
> @@ -139,12 +140,12 @@ static int vcn_v2_5_early_init(struct amdgpu_ip_block *ip_block)
>   		adev->vcn.num_enc_rings = 2;
>   	}
>   
> -	vcn_v2_5_set_dec_ring_funcs(adev, inst);
> -	vcn_v2_5_set_enc_ring_funcs(adev, inst);
> -	vcn_v2_5_set_irq_funcs(adev, inst);
> +	vcn_v2_5_set_dec_ring_funcs(adev);
> +	vcn_v2_5_set_enc_ring_funcs(adev);
> +	vcn_v2_5_set_irq_funcs(adev);
>   	vcn_v2_5_set_ras_funcs(adev);
>   
> -	return amdgpu_vcn_early_init(adev, inst);
> +	return amdgpu_vcn_early_init(adev);
>   }
>   
>   /**
> @@ -156,113 +157,116 @@ static int vcn_v2_5_early_init(struct amdgpu_ip_block *ip_block)
>    */
>   static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = ip_block->adev;
> -	int inst = ip_block->instance;
>   	struct amdgpu_ring *ring;
> -	int i, r;
> +	int i, j, r;
>   	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_2_5);
>   	uint32_t *ptr;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		goto sw_init;
> -	/* VCN DEC TRAP */
> -	r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
> -			VCN_2_0__SRCID__UVD_SYSTEM_MESSAGE_INTERRUPT, &adev->vcn.inst[inst].irq);
> -	if (r)
> -		return r;
> -
> -	/* VCN ENC TRAP */
> -	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
> -		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
> -			i + VCN_2_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst[inst].irq);
> +	for (j = 0; j < adev->vcn.num_vcn_inst; j++) {
> +		if (adev->vcn.harvest_config & (1 << j))
> +			continue;
> +		/* VCN DEC TRAP */
> +		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[j],
> +				VCN_2_0__SRCID__UVD_SYSTEM_MESSAGE_INTERRUPT, &adev->vcn.inst[j].irq);
>   		if (r)
>   			return r;
> -	}
>   
> -	/* VCN POISON TRAP */
> -	r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
> -		VCN_2_6__SRCID_UVD_POISON, &adev->vcn.inst[inst].ras_poison_irq);
> -	if (r)
> -		return r;
> -sw_init:
> -	r = amdgpu_vcn_sw_init(adev, inst);
> -	if (r)
> -		return r;
> +		/* VCN ENC TRAP */
> +		for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
> +			r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[j],
> +				i + VCN_2_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst[j].irq);
> +			if (r)
> +				return r;
> +		}
>   
> -	amdgpu_vcn_setup_ucode(adev, inst);
> +		/* VCN POISON TRAP */
> +		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[j],
> +			VCN_2_6__SRCID_UVD_POISON, &adev->vcn.inst[j].ras_poison_irq);
> +		if (r)
> +			return r;
> +	}
>   
> -	r = amdgpu_vcn_resume(adev, inst);
> +	r = amdgpu_vcn_sw_init(adev);
>   	if (r)
>   		return r;
>   
> -	volatile struct amdgpu_fw_shared *fw_shared;
> -
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		goto done;
> -	adev->vcn.internal.context_id = mmUVD_CONTEXT_ID_INTERNAL_OFFSET;
> -	adev->vcn.internal.ib_vmid = mmUVD_LMI_RBC_IB_VMID_INTERNAL_OFFSET;
> -	adev->vcn.internal.ib_bar_low = mmUVD_LMI_RBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET;
> -	adev->vcn.internal.ib_bar_high = mmUVD_LMI_RBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET;
> -	adev->vcn.internal.ib_size = mmUVD_RBC_IB_SIZE_INTERNAL_OFFSET;
> -	adev->vcn.internal.gp_scratch8 = mmUVD_GP_SCRATCH8_INTERNAL_OFFSET;
> -
> -	adev->vcn.internal.scratch9 = mmUVD_SCRATCH9_INTERNAL_OFFSET;
> -	adev->vcn.inst[inst].external.scratch9 = SOC15_REG_OFFSET(VCN, inst, mmUVD_SCRATCH9);
> -	adev->vcn.internal.data0 = mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFSET;
> -	adev->vcn.inst[inst].external.data0 = SOC15_REG_OFFSET(VCN, inst, mmUVD_GPCOM_VCPU_DATA0);
> -	adev->vcn.internal.data1 = mmUVD_GPCOM_VCPU_DATA1_INTERNAL_OFFSET;
> -	adev->vcn.inst[inst].external.data1 = SOC15_REG_OFFSET(VCN, inst, mmUVD_GPCOM_VCPU_DATA1);
> -	adev->vcn.internal.cmd = mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET;
> -	adev->vcn.inst[inst].external.cmd = SOC15_REG_OFFSET(VCN, inst, mmUVD_GPCOM_VCPU_CMD);
> -	adev->vcn.internal.nop = mmUVD_NO_OP_INTERNAL_OFFSET;
> -	adev->vcn.inst[inst].external.nop = SOC15_REG_OFFSET(VCN, inst, mmUVD_NO_OP);
> -
> -	ring = &adev->vcn.inst[inst].ring_dec;
> -	ring->use_doorbell = true;
> -
> -	ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
> -			(amdgpu_sriov_vf(adev) ? 2*inst : 8*inst);
> -
> -	if (amdgpu_ip_version(adev, UVD_HWIP, 0) == IP_VERSION(2, 5, 0))
> -		ring->vm_hub = AMDGPU_MMHUB1(0);
> -	else
> -		ring->vm_hub = AMDGPU_MMHUB0(0);
> +	amdgpu_vcn_setup_ucode(adev);
>   
> -	sprintf(ring->name, "vcn_dec_%d", inst);
> -	r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[inst].irq,
> -				 0, AMDGPU_RING_PRIO_DEFAULT, NULL);
> +	r = amdgpu_vcn_resume(adev);
>   	if (r)
>   		return r;
>   
> -	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
> -		enum amdgpu_ring_priority_level hw_prio = amdgpu_vcn_get_enc_ring_prio(i);
> +	for (j = 0; j < adev->vcn.num_vcn_inst; j++) {
> +		volatile struct amdgpu_fw_shared *fw_shared;
>   
> -		ring = &adev->vcn.inst[inst].ring_enc[i];
> +		if (adev->vcn.harvest_config & (1 << j))
> +			continue;
> +		adev->vcn.internal.context_id = mmUVD_CONTEXT_ID_INTERNAL_OFFSET;
> +		adev->vcn.internal.ib_vmid = mmUVD_LMI_RBC_IB_VMID_INTERNAL_OFFSET;
> +		adev->vcn.internal.ib_bar_low = mmUVD_LMI_RBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET;
> +		adev->vcn.internal.ib_bar_high = mmUVD_LMI_RBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET;
> +		adev->vcn.internal.ib_size = mmUVD_RBC_IB_SIZE_INTERNAL_OFFSET;
> +		adev->vcn.internal.gp_scratch8 = mmUVD_GP_SCRATCH8_INTERNAL_OFFSET;
> +
> +		adev->vcn.internal.scratch9 = mmUVD_SCRATCH9_INTERNAL_OFFSET;
> +		adev->vcn.inst[j].external.scratch9 = SOC15_REG_OFFSET(VCN, j, mmUVD_SCRATCH9);
> +		adev->vcn.internal.data0 = mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFSET;
> +		adev->vcn.inst[j].external.data0 = SOC15_REG_OFFSET(VCN, j, mmUVD_GPCOM_VCPU_DATA0);
> +		adev->vcn.internal.data1 = mmUVD_GPCOM_VCPU_DATA1_INTERNAL_OFFSET;
> +		adev->vcn.inst[j].external.data1 = SOC15_REG_OFFSET(VCN, j, mmUVD_GPCOM_VCPU_DATA1);
> +		adev->vcn.internal.cmd = mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET;
> +		adev->vcn.inst[j].external.cmd = SOC15_REG_OFFSET(VCN, j, mmUVD_GPCOM_VCPU_CMD);
> +		adev->vcn.internal.nop = mmUVD_NO_OP_INTERNAL_OFFSET;
> +		adev->vcn.inst[j].external.nop = SOC15_REG_OFFSET(VCN, j, mmUVD_NO_OP);
> +
> +		ring = &adev->vcn.inst[j].ring_dec;
>   		ring->use_doorbell = true;
>   
>   		ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
> -				(amdgpu_sriov_vf(adev) ? (1 + i + 2*inst) : (2 + i + 8*inst));
> +				(amdgpu_sriov_vf(adev) ? 2*j : 8*j);
>   
> -		if (amdgpu_ip_version(adev, UVD_HWIP, 0) ==
> -			IP_VERSION(2, 5, 0))
> +		if (amdgpu_ip_version(adev, UVD_HWIP, 0) == IP_VERSION(2, 5, 0))
>   			ring->vm_hub = AMDGPU_MMHUB1(0);
>   		else
>   			ring->vm_hub = AMDGPU_MMHUB0(0);
>   
> -		sprintf(ring->name, "vcn_enc_%d.%d", inst, i);
> -		r = amdgpu_ring_init(adev, ring, 512,
> -					 &adev->vcn.inst[inst].irq, 0,
> -					 hw_prio, NULL);
> +		sprintf(ring->name, "vcn_dec_%d", j);
> +		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[j].irq,
> +				     0, AMDGPU_RING_PRIO_DEFAULT, NULL);
>   		if (r)
>   			return r;
> -	}
>   
> -	fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
> -	fw_shared->present_flag_0 = cpu_to_le32(AMDGPU_VCN_MULTI_QUEUE_FLAG);
> +		for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
> +			enum amdgpu_ring_priority_level hw_prio = amdgpu_vcn_get_enc_ring_prio(i);
> +
> +			ring = &adev->vcn.inst[j].ring_enc[i];
> +			ring->use_doorbell = true;
> +
> +			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
> +					(amdgpu_sriov_vf(adev) ? (1 + i + 2*j) : (2 + i + 8*j));
> +
> +			if (amdgpu_ip_version(adev, UVD_HWIP, 0) ==
> +			    IP_VERSION(2, 5, 0))
> +				ring->vm_hub = AMDGPU_MMHUB1(0);
> +			else
> +				ring->vm_hub = AMDGPU_MMHUB0(0);
> +
> +			sprintf(ring->name, "vcn_enc_%d.%d", j, i);
> +			r = amdgpu_ring_init(adev, ring, 512,
> +					     &adev->vcn.inst[j].irq, 0,
> +					     hw_prio, NULL);
> +			if (r)
> +				return r;
> +		}
> +
> +		fw_shared = adev->vcn.inst[j].fw_shared.cpu_addr;
> +		fw_shared->present_flag_0 = cpu_to_le32(AMDGPU_VCN_MULTI_QUEUE_FLAG);
> +
> +		if (amdgpu_vcnfw_log)
> +			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
> +	}
>   
> -	if (amdgpu_vcnfw_log)
> -		amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
> -done:
>   	if (amdgpu_sriov_vf(adev)) {
>   		r = amdgpu_virt_alloc_mm_table(adev);
>   		if (r)
> @@ -277,12 +281,12 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
>   		return r;
>   
>   	/* Allocate memory for VCN IP Dump buffer */
> -	ptr = kcalloc(reg_count, sizeof(uint32_t), GFP_KERNEL);
> +	ptr = kcalloc(adev->vcn.num_vcn_inst * reg_count, sizeof(uint32_t), GFP_KERNEL);
>   	if (!ptr) {
>   		DRM_ERROR("Failed to allocate memory for VCN IP Dump\n");
> -		ip_block->ip_dump = NULL;
> +		adev->vcn.ip_dump = NULL;
>   	} else {
> -		ip_block->ip_dump = ptr;
> +		adev->vcn.ip_dump = ptr;
>   	}
>   
>   	return 0;
> @@ -297,18 +301,17 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
>    */
>   static int vcn_v2_5_sw_fini(struct amdgpu_ip_block *ip_block)
>   {
> +	int i, r, idx;
>   	struct amdgpu_device *adev = ip_block->adev;
>   	volatile struct amdgpu_fw_shared *fw_shared;
> -	int inst = ip_block->instance;
> -	int r, idx;
>   
>   	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> -		if (adev->vcn.harvest_config & (1 << inst))
> -			goto done;
> -
> -		fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
> -		fw_shared->present_flag_0 = 0;
> -	done:
> +		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +			if (adev->vcn.harvest_config & (1 << i))
> +				continue;
> +			fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
> +			fw_shared->present_flag_0 = 0;
> +		}
>   		drm_dev_exit(idx);
>   	}
>   
> @@ -316,13 +319,13 @@ static int vcn_v2_5_sw_fini(struct amdgpu_ip_block *ip_block)
>   	if (amdgpu_sriov_vf(adev))
>   		amdgpu_virt_free_mm_table(adev);
>   
> -	r = amdgpu_vcn_suspend(adev, inst);
> +	r = amdgpu_vcn_suspend(adev);
>   	if (r)
>   		return r;
>   
> -	r = amdgpu_vcn_sw_fini(adev, inst);
> +	r = amdgpu_vcn_sw_fini(adev);
>   
> -	kfree(ip_block->ip_dump);
> +	kfree(adev->vcn.ip_dump);
>   
>   	return r;
>   }
> @@ -338,36 +341,37 @@ static int vcn_v2_5_hw_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
>   	struct amdgpu_ring *ring;
> -	int inst = ip_block->instance;
> -	int i, r = 0;
> +	int i, j, r = 0;
>   
>   	if (amdgpu_sriov_vf(adev))
>   		r = vcn_v2_5_sriov_start(adev);
>   
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		return r;
> -
> -	if (amdgpu_sriov_vf(adev)) {
> -		adev->vcn.inst[inst].ring_enc[0].sched.ready = true;
> -		adev->vcn.inst[inst].ring_enc[1].sched.ready = false;
> -		adev->vcn.inst[inst].ring_enc[2].sched.ready = false;
> -		adev->vcn.inst[inst].ring_dec.sched.ready = true;
> -	} else {
> +	for (j = 0; j < adev->vcn.num_vcn_inst; ++j) {
> +		if (adev->vcn.harvest_config & (1 << j))
> +			continue;
>   
> -		ring = &adev->vcn.inst[inst].ring_dec;
> +		if (amdgpu_sriov_vf(adev)) {
> +			adev->vcn.inst[j].ring_enc[0].sched.ready = true;
> +			adev->vcn.inst[j].ring_enc[1].sched.ready = false;
> +			adev->vcn.inst[j].ring_enc[2].sched.ready = false;
> +			adev->vcn.inst[j].ring_dec.sched.ready = true;
> +		} else {
>   
> -		adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
> -						 ring->doorbell_index, inst);
> +			ring = &adev->vcn.inst[j].ring_dec;
>   
> -		r = amdgpu_ring_test_helper(ring);
> -		if (r)
> -			return r;
> +			adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
> +						     ring->doorbell_index, j);
>   
> -		for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
> -			ring = &adev->vcn.inst[inst].ring_enc[i];
>   			r = amdgpu_ring_test_helper(ring);
>   			if (r)
>   				return r;
> +
> +			for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
> +				ring = &adev->vcn.inst[j].ring_enc[i];
> +				r = amdgpu_ring_test_helper(ring);
> +				if (r)
> +					return r;
> +			}
>   		}
>   	}
>   
> @@ -384,21 +388,22 @@ static int vcn_v2_5_hw_init(struct amdgpu_ip_block *ip_block)
>   static int vcn_v2_5_hw_fini(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int inst = ip_block->instance;
> +	int i;
>   
> -	cancel_delayed_work_sync(&adev->vcn.inst[inst].idle_work);
> +	cancel_delayed_work_sync(&adev->vcn.idle_work);
>   
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		return 0;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
>   
> -	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> -	    (adev->vcn.inst[inst].cur_state != AMD_PG_STATE_GATE &&
> -	     RREG32_SOC15(VCN, inst, mmUVD_STATUS))) {
> -		vcn_v2_5_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
> -	}
> +		if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> +		    (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> +		     RREG32_SOC15(VCN, i, mmUVD_STATUS)))
> +			vcn_v2_5_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
>   
> -	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
> -		amdgpu_irq_put(adev, &adev->vcn.inst[inst].ras_poison_irq, 0);
> +		if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
> +			amdgpu_irq_put(adev, &adev->vcn.inst[i].ras_poison_irq, 0);
> +	}
>   
>   	return 0;
>   }
> @@ -412,15 +417,13 @@ static int vcn_v2_5_hw_fini(struct amdgpu_ip_block *ip_block)
>    */
>   static int vcn_v2_5_suspend(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = ip_block->adev;
> -	int inst = ip_block->instance;
>   	int r;
>   
>   	r = vcn_v2_5_hw_fini(ip_block);
>   	if (r)
>   		return r;
>   
> -	r = amdgpu_vcn_suspend(adev, inst);
> +	r = amdgpu_vcn_suspend(ip_block->adev);
>   
>   	return r;
>   }
> @@ -436,7 +439,7 @@ static int vcn_v2_5_resume(struct amdgpu_ip_block *ip_block)
>   {
>   	int r;
>   
> -	r = amdgpu_vcn_resume(ip_block->adev, ip_block->instance);
> +	r = amdgpu_vcn_resume(ip_block->adev);
>   	if (r)
>   		return r;
>   
> @@ -609,115 +612,117 @@ static void vcn_v2_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx
>    * vcn_v2_5_disable_clock_gating - disable VCN clock gating
>    *
>    * @adev: amdgpu_device pointer
> - * @inst: VCN instance index for which to disable clock gating
>    *
>    * Disable clock gating for VCN block
>    */
> -static void vcn_v2_5_disable_clock_gating(struct amdgpu_device *adev, int inst)
> +static void vcn_v2_5_disable_clock_gating(struct amdgpu_device *adev)
>   {
>   	uint32_t data;
> +	int i;
>   
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		return;
> -	/* UVD disable CGC */
> -	data = RREG32_SOC15(VCN, inst, mmUVD_CGC_CTRL);
> -	if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
> -		data |= 1 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
> -	else
> -		data &= ~UVD_CGC_CTRL__DYN_CLOCK_MODE_MASK;
> -	data |= 1 << UVD_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
> -	data |= 4 << UVD_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
> -	WREG32_SOC15(VCN, inst, mmUVD_CGC_CTRL, data);
> -
> -	data = RREG32_SOC15(VCN, inst, mmUVD_CGC_GATE);
> -	data &= ~(UVD_CGC_GATE__SYS_MASK
> -		| UVD_CGC_GATE__UDEC_MASK
> -		| UVD_CGC_GATE__MPEG2_MASK
> -		| UVD_CGC_GATE__REGS_MASK
> -		| UVD_CGC_GATE__RBC_MASK
> -		| UVD_CGC_GATE__LMI_MC_MASK
> -		| UVD_CGC_GATE__LMI_UMC_MASK
> -		| UVD_CGC_GATE__IDCT_MASK
> -		| UVD_CGC_GATE__MPRD_MASK
> -		| UVD_CGC_GATE__MPC_MASK
> -		| UVD_CGC_GATE__LBSI_MASK
> -		| UVD_CGC_GATE__LRBBM_MASK
> -		| UVD_CGC_GATE__UDEC_RE_MASK
> -		| UVD_CGC_GATE__UDEC_CM_MASK
> -		| UVD_CGC_GATE__UDEC_IT_MASK
> -		| UVD_CGC_GATE__UDEC_DB_MASK
> -		| UVD_CGC_GATE__UDEC_MP_MASK
> -		| UVD_CGC_GATE__WCB_MASK
> -		| UVD_CGC_GATE__VCPU_MASK
> -		| UVD_CGC_GATE__MMSCH_MASK);
> -
> -	WREG32_SOC15(VCN, inst, mmUVD_CGC_GATE, data);
> -
> -	SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_CGC_GATE, 0,  0xFFFFFFFF);
> -
> -	data = RREG32_SOC15(VCN, inst, mmUVD_CGC_CTRL);
> -	data &= ~(UVD_CGC_CTRL__UDEC_RE_MODE_MASK
> -		| UVD_CGC_CTRL__UDEC_CM_MODE_MASK
> -		| UVD_CGC_CTRL__UDEC_IT_MODE_MASK
> -		| UVD_CGC_CTRL__UDEC_DB_MODE_MASK
> -		| UVD_CGC_CTRL__UDEC_MP_MODE_MASK
> -		| UVD_CGC_CTRL__SYS_MODE_MASK
> -		| UVD_CGC_CTRL__UDEC_MODE_MASK
> -		| UVD_CGC_CTRL__MPEG2_MODE_MASK
> -		| UVD_CGC_CTRL__REGS_MODE_MASK
> -		| UVD_CGC_CTRL__RBC_MODE_MASK
> -		| UVD_CGC_CTRL__LMI_MC_MODE_MASK
> -		| UVD_CGC_CTRL__LMI_UMC_MODE_MASK
> -		| UVD_CGC_CTRL__IDCT_MODE_MASK
> -		| UVD_CGC_CTRL__MPRD_MODE_MASK
> -		| UVD_CGC_CTRL__MPC_MODE_MASK
> -		| UVD_CGC_CTRL__LBSI_MODE_MASK
> -		| UVD_CGC_CTRL__LRBBM_MODE_MASK
> -		| UVD_CGC_CTRL__WCB_MODE_MASK
> -		| UVD_CGC_CTRL__VCPU_MODE_MASK
> -		| UVD_CGC_CTRL__MMSCH_MODE_MASK);
> -	WREG32_SOC15(VCN, inst, mmUVD_CGC_CTRL, data);
> -
> -	/* turn on */
> -	data = RREG32_SOC15(VCN, inst, mmUVD_SUVD_CGC_GATE);
> -	data |= (UVD_SUVD_CGC_GATE__SRE_MASK
> -		| UVD_SUVD_CGC_GATE__SIT_MASK
> -		| UVD_SUVD_CGC_GATE__SMP_MASK
> -		| UVD_SUVD_CGC_GATE__SCM_MASK
> -		| UVD_SUVD_CGC_GATE__SDB_MASK
> -		| UVD_SUVD_CGC_GATE__SRE_H264_MASK
> -		| UVD_SUVD_CGC_GATE__SRE_HEVC_MASK
> -		| UVD_SUVD_CGC_GATE__SIT_H264_MASK
> -		| UVD_SUVD_CGC_GATE__SIT_HEVC_MASK
> -		| UVD_SUVD_CGC_GATE__SCM_H264_MASK
> -		| UVD_SUVD_CGC_GATE__SCM_HEVC_MASK
> -		| UVD_SUVD_CGC_GATE__SDB_H264_MASK
> -		| UVD_SUVD_CGC_GATE__SDB_HEVC_MASK
> -		| UVD_SUVD_CGC_GATE__SCLR_MASK
> -		| UVD_SUVD_CGC_GATE__UVD_SC_MASK
> -		| UVD_SUVD_CGC_GATE__ENT_MASK
> -		| UVD_SUVD_CGC_GATE__SIT_HEVC_DEC_MASK
> -		| UVD_SUVD_CGC_GATE__SIT_HEVC_ENC_MASK
> -		| UVD_SUVD_CGC_GATE__SITE_MASK
> -		| UVD_SUVD_CGC_GATE__SRE_VP9_MASK
> -		| UVD_SUVD_CGC_GATE__SCM_VP9_MASK
> -		| UVD_SUVD_CGC_GATE__SIT_VP9_DEC_MASK
> -		| UVD_SUVD_CGC_GATE__SDB_VP9_MASK
> -		| UVD_SUVD_CGC_GATE__IME_HEVC_MASK);
> -	WREG32_SOC15(VCN, inst, mmUVD_SUVD_CGC_GATE, data);
> -
> -	data = RREG32_SOC15(VCN, inst, mmUVD_SUVD_CGC_CTRL);
> -	data &= ~(UVD_SUVD_CGC_CTRL__SRE_MODE_MASK
> -		| UVD_SUVD_CGC_CTRL__SIT_MODE_MASK
> -		| UVD_SUVD_CGC_CTRL__SMP_MODE_MASK
> -		| UVD_SUVD_CGC_CTRL__SCM_MODE_MASK
> -		| UVD_SUVD_CGC_CTRL__SDB_MODE_MASK
> -		| UVD_SUVD_CGC_CTRL__SCLR_MODE_MASK
> -		| UVD_SUVD_CGC_CTRL__UVD_SC_MODE_MASK
> -		| UVD_SUVD_CGC_CTRL__ENT_MODE_MASK
> -		| UVD_SUVD_CGC_CTRL__IME_MODE_MASK
> -		| UVD_SUVD_CGC_CTRL__SITE_MODE_MASK);
> -	WREG32_SOC15(VCN, inst, mmUVD_SUVD_CGC_CTRL, data);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
> +		/* UVD disable CGC */
> +		data = RREG32_SOC15(VCN, i, mmUVD_CGC_CTRL);
> +		if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
> +			data |= 1 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
> +		else
> +			data &= ~UVD_CGC_CTRL__DYN_CLOCK_MODE_MASK;
> +		data |= 1 << UVD_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
> +		data |= 4 << UVD_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
> +		WREG32_SOC15(VCN, i, mmUVD_CGC_CTRL, data);
> +
> +		data = RREG32_SOC15(VCN, i, mmUVD_CGC_GATE);
> +		data &= ~(UVD_CGC_GATE__SYS_MASK
> +			| UVD_CGC_GATE__UDEC_MASK
> +			| UVD_CGC_GATE__MPEG2_MASK
> +			| UVD_CGC_GATE__REGS_MASK
> +			| UVD_CGC_GATE__RBC_MASK
> +			| UVD_CGC_GATE__LMI_MC_MASK
> +			| UVD_CGC_GATE__LMI_UMC_MASK
> +			| UVD_CGC_GATE__IDCT_MASK
> +			| UVD_CGC_GATE__MPRD_MASK
> +			| UVD_CGC_GATE__MPC_MASK
> +			| UVD_CGC_GATE__LBSI_MASK
> +			| UVD_CGC_GATE__LRBBM_MASK
> +			| UVD_CGC_GATE__UDEC_RE_MASK
> +			| UVD_CGC_GATE__UDEC_CM_MASK
> +			| UVD_CGC_GATE__UDEC_IT_MASK
> +			| UVD_CGC_GATE__UDEC_DB_MASK
> +			| UVD_CGC_GATE__UDEC_MP_MASK
> +			| UVD_CGC_GATE__WCB_MASK
> +			| UVD_CGC_GATE__VCPU_MASK
> +			| UVD_CGC_GATE__MMSCH_MASK);
> +
> +		WREG32_SOC15(VCN, i, mmUVD_CGC_GATE, data);
> +
> +		SOC15_WAIT_ON_RREG(VCN, i, mmUVD_CGC_GATE, 0,  0xFFFFFFFF);
> +
> +		data = RREG32_SOC15(VCN, i, mmUVD_CGC_CTRL);
> +		data &= ~(UVD_CGC_CTRL__UDEC_RE_MODE_MASK
> +			| UVD_CGC_CTRL__UDEC_CM_MODE_MASK
> +			| UVD_CGC_CTRL__UDEC_IT_MODE_MASK
> +			| UVD_CGC_CTRL__UDEC_DB_MODE_MASK
> +			| UVD_CGC_CTRL__UDEC_MP_MODE_MASK
> +			| UVD_CGC_CTRL__SYS_MODE_MASK
> +			| UVD_CGC_CTRL__UDEC_MODE_MASK
> +			| UVD_CGC_CTRL__MPEG2_MODE_MASK
> +			| UVD_CGC_CTRL__REGS_MODE_MASK
> +			| UVD_CGC_CTRL__RBC_MODE_MASK
> +			| UVD_CGC_CTRL__LMI_MC_MODE_MASK
> +			| UVD_CGC_CTRL__LMI_UMC_MODE_MASK
> +			| UVD_CGC_CTRL__IDCT_MODE_MASK
> +			| UVD_CGC_CTRL__MPRD_MODE_MASK
> +			| UVD_CGC_CTRL__MPC_MODE_MASK
> +			| UVD_CGC_CTRL__LBSI_MODE_MASK
> +			| UVD_CGC_CTRL__LRBBM_MODE_MASK
> +			| UVD_CGC_CTRL__WCB_MODE_MASK
> +			| UVD_CGC_CTRL__VCPU_MODE_MASK
> +			| UVD_CGC_CTRL__MMSCH_MODE_MASK);
> +		WREG32_SOC15(VCN, i, mmUVD_CGC_CTRL, data);
> +
> +		/* turn on */
> +		data = RREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_GATE);
> +		data |= (UVD_SUVD_CGC_GATE__SRE_MASK
> +			| UVD_SUVD_CGC_GATE__SIT_MASK
> +			| UVD_SUVD_CGC_GATE__SMP_MASK
> +			| UVD_SUVD_CGC_GATE__SCM_MASK
> +			| UVD_SUVD_CGC_GATE__SDB_MASK
> +			| UVD_SUVD_CGC_GATE__SRE_H264_MASK
> +			| UVD_SUVD_CGC_GATE__SRE_HEVC_MASK
> +			| UVD_SUVD_CGC_GATE__SIT_H264_MASK
> +			| UVD_SUVD_CGC_GATE__SIT_HEVC_MASK
> +			| UVD_SUVD_CGC_GATE__SCM_H264_MASK
> +			| UVD_SUVD_CGC_GATE__SCM_HEVC_MASK
> +			| UVD_SUVD_CGC_GATE__SDB_H264_MASK
> +			| UVD_SUVD_CGC_GATE__SDB_HEVC_MASK
> +			| UVD_SUVD_CGC_GATE__SCLR_MASK
> +			| UVD_SUVD_CGC_GATE__UVD_SC_MASK
> +			| UVD_SUVD_CGC_GATE__ENT_MASK
> +			| UVD_SUVD_CGC_GATE__SIT_HEVC_DEC_MASK
> +			| UVD_SUVD_CGC_GATE__SIT_HEVC_ENC_MASK
> +			| UVD_SUVD_CGC_GATE__SITE_MASK
> +			| UVD_SUVD_CGC_GATE__SRE_VP9_MASK
> +			| UVD_SUVD_CGC_GATE__SCM_VP9_MASK
> +			| UVD_SUVD_CGC_GATE__SIT_VP9_DEC_MASK
> +			| UVD_SUVD_CGC_GATE__SDB_VP9_MASK
> +			| UVD_SUVD_CGC_GATE__IME_HEVC_MASK);
> +		WREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_GATE, data);
> +
> +		data = RREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL);
> +		data &= ~(UVD_SUVD_CGC_CTRL__SRE_MODE_MASK
> +			| UVD_SUVD_CGC_CTRL__SIT_MODE_MASK
> +			| UVD_SUVD_CGC_CTRL__SMP_MODE_MASK
> +			| UVD_SUVD_CGC_CTRL__SCM_MODE_MASK
> +			| UVD_SUVD_CGC_CTRL__SDB_MODE_MASK
> +			| UVD_SUVD_CGC_CTRL__SCLR_MODE_MASK
> +			| UVD_SUVD_CGC_CTRL__UVD_SC_MODE_MASK
> +			| UVD_SUVD_CGC_CTRL__ENT_MODE_MASK
> +			| UVD_SUVD_CGC_CTRL__IME_MODE_MASK
> +			| UVD_SUVD_CGC_CTRL__SITE_MODE_MASK);
> +		WREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL, data);
> +	}
>   }
>   
>   static void vcn_v2_5_clock_gating_dpg_mode(struct amdgpu_device *adev,
> @@ -772,60 +777,62 @@ static void vcn_v2_5_clock_gating_dpg_mode(struct amdgpu_device *adev,
>    * vcn_v2_5_enable_clock_gating - enable VCN clock gating
>    *
>    * @adev: amdgpu_device pointer
> - * @inst: VCN instance index for which to enable clock gating
>    *
>    * Enable clock gating for VCN block
>    */
> -static void vcn_v2_5_enable_clock_gating(struct amdgpu_device *adev, int inst)
> +static void vcn_v2_5_enable_clock_gating(struct amdgpu_device *adev)
>   {
>   	uint32_t data = 0;
> +	int i;
>   
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		return;
> -	/* enable UVD CGC */
> -	data = RREG32_SOC15(VCN, inst, mmUVD_CGC_CTRL);
> -	if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
> -		data |= 1 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
> -	else
> -		data |= 0 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
> -	data |= 1 << UVD_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
> -	data |= 4 << UVD_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
> -	WREG32_SOC15(VCN, inst, mmUVD_CGC_CTRL, data);
> -
> -	data = RREG32_SOC15(VCN, inst, mmUVD_CGC_CTRL);
> -	data |= (UVD_CGC_CTRL__UDEC_RE_MODE_MASK
> -		| UVD_CGC_CTRL__UDEC_CM_MODE_MASK
> -		| UVD_CGC_CTRL__UDEC_IT_MODE_MASK
> -		| UVD_CGC_CTRL__UDEC_DB_MODE_MASK
> -		| UVD_CGC_CTRL__UDEC_MP_MODE_MASK
> -		| UVD_CGC_CTRL__SYS_MODE_MASK
> -		| UVD_CGC_CTRL__UDEC_MODE_MASK
> -		| UVD_CGC_CTRL__MPEG2_MODE_MASK
> -		| UVD_CGC_CTRL__REGS_MODE_MASK
> -		| UVD_CGC_CTRL__RBC_MODE_MASK
> -		| UVD_CGC_CTRL__LMI_MC_MODE_MASK
> -		| UVD_CGC_CTRL__LMI_UMC_MODE_MASK
> -		| UVD_CGC_CTRL__IDCT_MODE_MASK
> -		| UVD_CGC_CTRL__MPRD_MODE_MASK
> -		| UVD_CGC_CTRL__MPC_MODE_MASK
> -		| UVD_CGC_CTRL__LBSI_MODE_MASK
> -		| UVD_CGC_CTRL__LRBBM_MODE_MASK
> -		| UVD_CGC_CTRL__WCB_MODE_MASK
> -		| UVD_CGC_CTRL__VCPU_MODE_MASK);
> -	WREG32_SOC15(VCN, inst, mmUVD_CGC_CTRL, data);
> -
> -	data = RREG32_SOC15(VCN, inst, mmUVD_SUVD_CGC_CTRL);
> -	data |= (UVD_SUVD_CGC_CTRL__SRE_MODE_MASK
> -		| UVD_SUVD_CGC_CTRL__SIT_MODE_MASK
> -		| UVD_SUVD_CGC_CTRL__SMP_MODE_MASK
> -		| UVD_SUVD_CGC_CTRL__SCM_MODE_MASK
> -		| UVD_SUVD_CGC_CTRL__SDB_MODE_MASK
> -		| UVD_SUVD_CGC_CTRL__SCLR_MODE_MASK
> -		| UVD_SUVD_CGC_CTRL__UVD_SC_MODE_MASK
> -		| UVD_SUVD_CGC_CTRL__ENT_MODE_MASK
> -		| UVD_SUVD_CGC_CTRL__IME_MODE_MASK
> -		| UVD_SUVD_CGC_CTRL__SITE_MODE_MASK);
> -	WREG32_SOC15(VCN, inst, mmUVD_SUVD_CGC_CTRL, data);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
> +		/* enable UVD CGC */
> +		data = RREG32_SOC15(VCN, i, mmUVD_CGC_CTRL);
> +		if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
> +			data |= 1 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
> +		else
> +			data |= 0 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
> +		data |= 1 << UVD_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
> +		data |= 4 << UVD_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
> +		WREG32_SOC15(VCN, i, mmUVD_CGC_CTRL, data);
> +
> +		data = RREG32_SOC15(VCN, i, mmUVD_CGC_CTRL);
> +		data |= (UVD_CGC_CTRL__UDEC_RE_MODE_MASK
> +			| UVD_CGC_CTRL__UDEC_CM_MODE_MASK
> +			| UVD_CGC_CTRL__UDEC_IT_MODE_MASK
> +			| UVD_CGC_CTRL__UDEC_DB_MODE_MASK
> +			| UVD_CGC_CTRL__UDEC_MP_MODE_MASK
> +			| UVD_CGC_CTRL__SYS_MODE_MASK
> +			| UVD_CGC_CTRL__UDEC_MODE_MASK
> +			| UVD_CGC_CTRL__MPEG2_MODE_MASK
> +			| UVD_CGC_CTRL__REGS_MODE_MASK
> +			| UVD_CGC_CTRL__RBC_MODE_MASK
> +			| UVD_CGC_CTRL__LMI_MC_MODE_MASK
> +			| UVD_CGC_CTRL__LMI_UMC_MODE_MASK
> +			| UVD_CGC_CTRL__IDCT_MODE_MASK
> +			| UVD_CGC_CTRL__MPRD_MODE_MASK
> +			| UVD_CGC_CTRL__MPC_MODE_MASK
> +			| UVD_CGC_CTRL__LBSI_MODE_MASK
> +			| UVD_CGC_CTRL__LRBBM_MODE_MASK
> +			| UVD_CGC_CTRL__WCB_MODE_MASK
> +			| UVD_CGC_CTRL__VCPU_MODE_MASK);
> +		WREG32_SOC15(VCN, i, mmUVD_CGC_CTRL, data);
> +
> +		data = RREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL);
> +		data |= (UVD_SUVD_CGC_CTRL__SRE_MODE_MASK
> +			| UVD_SUVD_CGC_CTRL__SIT_MODE_MASK
> +			| UVD_SUVD_CGC_CTRL__SMP_MODE_MASK
> +			| UVD_SUVD_CGC_CTRL__SCM_MODE_MASK
> +			| UVD_SUVD_CGC_CTRL__SDB_MODE_MASK
> +			| UVD_SUVD_CGC_CTRL__SCLR_MODE_MASK
> +			| UVD_SUVD_CGC_CTRL__UVD_SC_MODE_MASK
> +			| UVD_SUVD_CGC_CTRL__ENT_MODE_MASK
> +			| UVD_SUVD_CGC_CTRL__IME_MODE_MASK
> +			| UVD_SUVD_CGC_CTRL__SITE_MODE_MASK);
> +		WREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL, data);
> +	}
>   }
>   
>   static void vcn_v2_6_enable_ras(struct amdgpu_device *adev, int inst_idx,
> @@ -999,192 +1006,197 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
>   	return 0;
>   }
>   
> -static int vcn_v2_5_start(struct amdgpu_device *adev, unsigned int inst)
> +static int vcn_v2_5_start(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_ring *ring;
>   	uint32_t rb_bufsz, tmp;
> -	int j, k, r;
> +	int i, j, k, r;
>   
> -	if (adev->pm.dpm_enabled)
> -		amdgpu_dpm_enable_vcn(adev, true, inst);
> -
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		return 0;
> -
> -	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> -		r = vcn_v2_5_start_dpg_mode(adev, inst, adev->vcn.indirect_sram);
> -		return r;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->pm.dpm_enabled)
> +			amdgpu_dpm_enable_vcn(adev, true, i);
>   	}
>   
> -	/* disable register anti-hang mechanism */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_POWER_STATUS), 0,
> -		~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
> +		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> +			r = vcn_v2_5_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
> +			continue;
> +		}
> +
> +		/* disable register anti-hang mechanism */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_POWER_STATUS), 0,
> +			~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
>   
> -	/* set uvd status busy */
> -	tmp = RREG32_SOC15(VCN, inst, mmUVD_STATUS) | UVD_STATUS__UVD_BUSY;
> -	WREG32_SOC15(VCN, inst, mmUVD_STATUS, tmp);
> +		/* set uvd status busy */
> +		tmp = RREG32_SOC15(VCN, i, mmUVD_STATUS) | UVD_STATUS__UVD_BUSY;
> +		WREG32_SOC15(VCN, i, mmUVD_STATUS, tmp);
> +	}
>   
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
>   		return 0;
>   
>   	/*SW clock gating */
> -	vcn_v2_5_disable_clock_gating(adev, inst);
> +	vcn_v2_5_disable_clock_gating(adev);
>   
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		return 0;
> -
> -	/* enable VCPU clock */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL),
> -		UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
> -
> -	/* disable master interrupt */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_MASTINT_EN), 0,
> -		~UVD_MASTINT_EN__VCPU_EN_MASK);
> -
> -	/* setup mmUVD_LMI_CTRL */
> -	tmp = RREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL);
> -	tmp &= ~0xff;
> -	WREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL, tmp | 0x8|
> -		UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK	|
> -		UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
> -		UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
> -		UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
> -
> -	/* setup mmUVD_MPC_CNTL */
> -	tmp = RREG32_SOC15(VCN, inst, mmUVD_MPC_CNTL);
> -	tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
> -	tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
> -	WREG32_SOC15(VCN, inst, mmUVD_MPC_CNTL, tmp);
> -
> -	/* setup UVD_MPC_SET_MUXA0 */
> -	WREG32_SOC15(VCN, inst, mmUVD_MPC_SET_MUXA0,
> -		((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
> -		(0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
> -		(0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
> -		(0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
> -
> -	/* setup UVD_MPC_SET_MUXB0 */
> -	WREG32_SOC15(VCN, inst, mmUVD_MPC_SET_MUXB0,
> -		((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
> -		(0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
> -		(0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
> -		(0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
> -
> -	/* setup mmUVD_MPC_SET_MUX */
> -	WREG32_SOC15(VCN, inst, mmUVD_MPC_SET_MUX,
> -		((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
> -		(0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
> -		(0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
> +		/* enable VCPU clock */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
> +			UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
> +
> +		/* disable master interrupt */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN), 0,
> +			~UVD_MASTINT_EN__VCPU_EN_MASK);
> +
> +		/* setup mmUVD_LMI_CTRL */
> +		tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL);
> +		tmp &= ~0xff;
> +		WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL, tmp | 0x8|
> +			UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK	|
> +			UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
> +			UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
> +			UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
> +
> +		/* setup mmUVD_MPC_CNTL */
> +		tmp = RREG32_SOC15(VCN, i, mmUVD_MPC_CNTL);
> +		tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
> +		tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
> +		WREG32_SOC15(VCN, i, mmUVD_MPC_CNTL, tmp);
> +
> +		/* setup UVD_MPC_SET_MUXA0 */
> +		WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXA0,
> +			((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
> +			(0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
> +			(0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
> +			(0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
> +
> +		/* setup UVD_MPC_SET_MUXB0 */
> +		WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXB0,
> +			((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
> +			(0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
> +			(0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
> +			(0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
> +
> +		/* setup mmUVD_MPC_SET_MUX */
> +		WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUX,
> +			((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
> +			(0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
> +			(0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
> +	}
>   
>   	vcn_v2_5_mc_resume(adev);
>   
> -	volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		return 0;
> -
> -	/* VCN global tiling registers */
> -	WREG32_SOC15(VCN, inst, mmUVD_GFX8_ADDR_CONFIG,
> -		adev->gfx.config.gb_addr_config);
> -	WREG32_SOC15(VCN, inst, mmUVD_GFX8_ADDR_CONFIG,
> -		adev->gfx.config.gb_addr_config);
> -
> -	/* enable LMI MC and UMC channels */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_LMI_CTRL2), 0,
> -		~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
> +		/* VCN global tiling registers */
> +		WREG32_SOC15(VCN, i, mmUVD_GFX8_ADDR_CONFIG,
> +			adev->gfx.config.gb_addr_config);
> +		WREG32_SOC15(VCN, i, mmUVD_GFX8_ADDR_CONFIG,
> +			adev->gfx.config.gb_addr_config);
>   
> -	/* unblock VCPU register access */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_RB_ARB_CTRL), 0,
> -		~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> +		/* enable LMI MC and UMC channels */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_LMI_CTRL2), 0,
> +			~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
>   
> -	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL), 0,
> -		~UVD_VCPU_CNTL__BLK_RST_MASK);
> +		/* unblock VCPU register access */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL), 0,
> +			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
>   
> -	for (k = 0; k < 10; ++k) {
> -		uint32_t status;
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
> +			~UVD_VCPU_CNTL__BLK_RST_MASK);
>   
> -		for (j = 0; j < 100; ++j) {
> -			status = RREG32_SOC15(VCN, inst, mmUVD_STATUS);
> +		for (k = 0; k < 10; ++k) {
> +			uint32_t status;
> +
> +			for (j = 0; j < 100; ++j) {
> +				status = RREG32_SOC15(VCN, i, mmUVD_STATUS);
> +				if (status & 2)
> +					break;
> +				if (amdgpu_emu_mode == 1)
> +					msleep(500);
> +				else
> +					mdelay(10);
> +			}
> +			r = 0;
>   			if (status & 2)
>   				break;
> -			if (amdgpu_emu_mode == 1)
> -				msleep(500);
> -			else
> -				mdelay(10);
> -		}
> -		r = 0;
> -		if (status & 2)
> -			break;
>   
> -		DRM_ERROR("VCN decode not responding, trying to reset the VCPU!!!\n");
> -		WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL),
> -			UVD_VCPU_CNTL__BLK_RST_MASK,
> -			~UVD_VCPU_CNTL__BLK_RST_MASK);
> -		mdelay(10);
> -		WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL), 0,
> -			~UVD_VCPU_CNTL__BLK_RST_MASK);
> +			DRM_ERROR("VCN decode not responding, trying to reset the VCPU!!!\n");
> +			WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
> +				UVD_VCPU_CNTL__BLK_RST_MASK,
> +				~UVD_VCPU_CNTL__BLK_RST_MASK);
> +			mdelay(10);
> +			WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
> +				~UVD_VCPU_CNTL__BLK_RST_MASK);
>   
> -		mdelay(10);
> -		r = -1;
> -	}
> +			mdelay(10);
> +			r = -1;
> +		}
>   
> -	if (r) {
> -		DRM_ERROR("VCN decode not responding, giving up!!!\n");
> -		return r;
> -	}
> +		if (r) {
> +			DRM_ERROR("VCN decode not responding, giving up!!!\n");
> +			return r;
> +		}
>   
> -	/* enable master interrupt */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_MASTINT_EN),
> -		UVD_MASTINT_EN__VCPU_EN_MASK,
> -		~UVD_MASTINT_EN__VCPU_EN_MASK);
> +		/* enable master interrupt */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN),
> +			UVD_MASTINT_EN__VCPU_EN_MASK,
> +			~UVD_MASTINT_EN__VCPU_EN_MASK);
>   
> -	/* clear the busy bit of VCN_STATUS */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_STATUS), 0,
> -		~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
> +		/* clear the busy bit of VCN_STATUS */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_STATUS), 0,
> +			~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
>   
> -	WREG32_SOC15(VCN, inst, mmUVD_LMI_RBC_RB_VMID, 0);
> +		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_VMID, 0);
>   
> -	ring = &adev->vcn.inst[inst].ring_dec;
> -	/* force RBC into idle state */
> -	rb_bufsz = order_base_2(ring->ring_size);
> -	tmp = REG_SET_FIELD(0, UVD_RBC_RB_CNTL, RB_BUFSZ, rb_bufsz);
> -	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_BLKSZ, 1);
> -	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH, 1);
> -	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE, 1);
> -	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
> -	WREG32_SOC15(VCN, inst, mmUVD_RBC_RB_CNTL, tmp);
> +		ring = &adev->vcn.inst[i].ring_dec;
> +		/* force RBC into idle state */
> +		rb_bufsz = order_base_2(ring->ring_size);
> +		tmp = REG_SET_FIELD(0, UVD_RBC_RB_CNTL, RB_BUFSZ, rb_bufsz);
> +		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_BLKSZ, 1);
> +		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH, 1);
> +		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE, 1);
> +		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
> +		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_CNTL, tmp);
>   
> -	fw_shared->multi_queue.decode_queue_mode |= FW_QUEUE_RING_RESET;
> -	/* program the RB_BASE for ring buffer */
> -	WREG32_SOC15(VCN, inst, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
> -		lower_32_bits(ring->gpu_addr));
> -	WREG32_SOC15(VCN, inst, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
> -		upper_32_bits(ring->gpu_addr));
> +		fw_shared->multi_queue.decode_queue_mode |= FW_QUEUE_RING_RESET;
> +		/* program the RB_BASE for ring buffer */
> +		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
> +			lower_32_bits(ring->gpu_addr));
> +		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
> +			upper_32_bits(ring->gpu_addr));
>   
> -	/* Initialize the ring buffer's read and write pointers */
> -	WREG32_SOC15(VCN, inst, mmUVD_RBC_RB_RPTR, 0);
> +		/* Initialize the ring buffer's read and write pointers */
> +		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR, 0);
>   
> -	ring->wptr = RREG32_SOC15(VCN, inst, mmUVD_RBC_RB_RPTR);
> -	WREG32_SOC15(VCN, inst, mmUVD_RBC_RB_WPTR,
> -			lower_32_bits(ring->wptr));
> -	fw_shared->multi_queue.decode_queue_mode &= ~FW_QUEUE_RING_RESET;
> +		ring->wptr = RREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR);
> +		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_WPTR,
> +				lower_32_bits(ring->wptr));
> +		fw_shared->multi_queue.decode_queue_mode &= ~FW_QUEUE_RING_RESET;
>   
> -	fw_shared->multi_queue.encode_generalpurpose_queue_mode |= FW_QUEUE_RING_RESET;
> -	ring = &adev->vcn.inst[inst].ring_enc[0];
> -	WREG32_SOC15(VCN, inst, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
> -	WREG32_SOC15(VCN, inst, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
> -	WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_LO, ring->gpu_addr);
> -	WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
> -	WREG32_SOC15(VCN, inst, mmUVD_RB_SIZE, ring->ring_size / 4);
> -	fw_shared->multi_queue.encode_generalpurpose_queue_mode &= ~FW_QUEUE_RING_RESET;
> -
> -	fw_shared->multi_queue.encode_lowlatency_queue_mode |= FW_QUEUE_RING_RESET;
> -	ring = &adev->vcn.inst[inst].ring_enc[1];
> -	WREG32_SOC15(VCN, inst, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr));
> -	WREG32_SOC15(VCN, inst, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
> -	WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_LO2, ring->gpu_addr);
> -	WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
> -	WREG32_SOC15(VCN, inst, mmUVD_RB_SIZE2, ring->ring_size / 4);
> -	fw_shared->multi_queue.encode_lowlatency_queue_mode &= ~FW_QUEUE_RING_RESET;
> +		fw_shared->multi_queue.encode_generalpurpose_queue_mode |= FW_QUEUE_RING_RESET;
> +		ring = &adev->vcn.inst[i].ring_enc[0];
> +		WREG32_SOC15(VCN, i, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
> +		WREG32_SOC15(VCN, i, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
> +		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO, ring->gpu_addr);
> +		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
> +		WREG32_SOC15(VCN, i, mmUVD_RB_SIZE, ring->ring_size / 4);
> +		fw_shared->multi_queue.encode_generalpurpose_queue_mode &= ~FW_QUEUE_RING_RESET;
> +
> +		fw_shared->multi_queue.encode_lowlatency_queue_mode |= FW_QUEUE_RING_RESET;
> +		ring = &adev->vcn.inst[i].ring_enc[1];
> +		WREG32_SOC15(VCN, i, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr));
> +		WREG32_SOC15(VCN, i, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
> +		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO2, ring->gpu_addr);
> +		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
> +		WREG32_SOC15(VCN, i, mmUVD_RB_SIZE2, ring->ring_size / 4);
> +		fw_shared->multi_queue.encode_lowlatency_queue_mode &= ~FW_QUEUE_RING_RESET;
> +	}
>   
>   	return 0;
>   }
> @@ -1413,69 +1425,72 @@ static int vcn_v2_5_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
>   	return 0;
>   }
>   
> -static int vcn_v2_5_stop(struct amdgpu_device *adev, unsigned int inst)
> +static int vcn_v2_5_stop(struct amdgpu_device *adev)
>   {
>   	uint32_t tmp;
> -	int r = 0;
> +	int i, r = 0;
>   
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		goto done;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
> +		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> +			r = vcn_v2_5_stop_dpg_mode(adev, i);
> +			continue;
> +		}
>   
> -	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> -		r = vcn_v2_5_stop_dpg_mode(adev, inst);
> -		goto done;
> -	}
> +		/* wait for vcn idle */
> +		r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7);
> +		if (r)
> +			return r;
>   
> -	/* wait for vcn idle */
> -	r = SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7);
> -	if (r)
> -		return r;
> +		tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
> +			UVD_LMI_STATUS__READ_CLEAN_MASK |
> +			UVD_LMI_STATUS__WRITE_CLEAN_MASK |
> +			UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
> +		r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
> +		if (r)
> +			return r;
>   
> -	tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
> -		UVD_LMI_STATUS__READ_CLEAN_MASK |
> -		UVD_LMI_STATUS__WRITE_CLEAN_MASK |
> -		UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
> -	r = SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_LMI_STATUS, tmp, tmp);
> -	if (r)
> -		return r;
> +		/* block LMI UMC channel */
> +		tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2);
> +		tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
> +		WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2, tmp);
>   
> -	/* block LMI UMC channel */
> -	tmp = RREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL2);
> -	tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
> -	WREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL2, tmp);
> +		tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK|
> +			UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
> +		r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
> +		if (r)
> +			return r;
>   
> -	tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK|
> -		UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
> -	r = SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_LMI_STATUS, tmp, tmp);
> -	if (r)
> -		return r;
> +		/* block VCPU register access */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL),
> +			UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
> +			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
>   
> -	/* block VCPU register access */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_RB_ARB_CTRL),
> -		UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
> -		~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> +		/* reset VCPU */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
> +			UVD_VCPU_CNTL__BLK_RST_MASK,
> +			~UVD_VCPU_CNTL__BLK_RST_MASK);
>   
> -	/* reset VCPU */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL),
> -		UVD_VCPU_CNTL__BLK_RST_MASK,
> -		~UVD_VCPU_CNTL__BLK_RST_MASK);
> +		/* disable VCPU clock */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
> +			~(UVD_VCPU_CNTL__CLK_EN_MASK));
>   
> -	/* disable VCPU clock */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL), 0,
> -		~(UVD_VCPU_CNTL__CLK_EN_MASK));
> +		/* clear status */
> +		WREG32_SOC15(VCN, i, mmUVD_STATUS, 0);
>   
> -	/* clear status */
> -	WREG32_SOC15(VCN, inst, mmUVD_STATUS, 0);
> +		vcn_v2_5_enable_clock_gating(adev);
>   
> -	vcn_v2_5_enable_clock_gating(adev, inst);
> +		/* enable register anti-hang mechanism */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_POWER_STATUS),
> +			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK,
> +			~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
> +	}
>   
> -	/* enable register anti-hang mechanism */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_POWER_STATUS),
> -		UVD_POWER_STATUS__UVD_POWER_STATUS_MASK,
> -		~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
> -done:
> -	if (adev->pm.dpm_enabled)
> -		amdgpu_dpm_enable_vcn(adev, false, inst);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->pm.dpm_enabled)
> +			amdgpu_dpm_enable_vcn(adev, false, i);
> +	}
>   
>   	return 0;
>   }
> @@ -1733,25 +1748,29 @@ static const struct amdgpu_ring_funcs vcn_v2_5_enc_ring_vm_funcs = {
>   	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
>   };
>   
> -static void vcn_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev, int inst)
> +static void vcn_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev)
>   {
> -		if (adev->vcn.harvest_config & (1 << inst))
> -			return;
> +	int i;
>   
> -		adev->vcn.inst[inst].ring_dec.funcs = &vcn_v2_5_dec_ring_vm_funcs;
> -		adev->vcn.inst[inst].ring_dec.me = inst;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
> +		adev->vcn.inst[i].ring_dec.funcs = &vcn_v2_5_dec_ring_vm_funcs;
> +		adev->vcn.inst[i].ring_dec.me = i;
> +	}
>   }
>   
> -static void vcn_v2_5_set_enc_ring_funcs(struct amdgpu_device *adev, int inst)
> +static void vcn_v2_5_set_enc_ring_funcs(struct amdgpu_device *adev)
>   {
> -	int i;
> -
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		return;
> +	int i, j;
>   
> -	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
> -		adev->vcn.inst[inst].ring_enc[i].funcs = &vcn_v2_5_enc_ring_vm_funcs;
> -		adev->vcn.inst[inst].ring_enc[i].me = inst;
> +	for (j = 0; j < adev->vcn.num_vcn_inst; ++j) {
> +		if (adev->vcn.harvest_config & (1 << j))
> +			continue;
> +		for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
> +			adev->vcn.inst[j].ring_enc[i].funcs = &vcn_v2_5_enc_ring_vm_funcs;
> +			adev->vcn.inst[j].ring_enc[i].me = j;
> +		}
>   	}
>   }
>   
> @@ -1773,14 +1792,16 @@ static bool vcn_v2_5_is_idle(void *handle)
>   static int vcn_v2_5_wait_for_idle(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int inst = ip_block->instance;
> -	int ret;
> -
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		return 0;
> +	int i, ret = 0;
>   
> -	ret = SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_STATUS, UVD_STATUS__IDLE,
> -		UVD_STATUS__IDLE);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
> +		ret = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_STATUS, UVD_STATUS__IDLE,
> +			UVD_STATUS__IDLE);
> +		if (ret)
> +			return ret;
> +	}
>   
>   	return ret;
>   }
> @@ -1790,7 +1811,6 @@ static int vcn_v2_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
>   	bool enable = (state == AMD_CG_STATE_GATE);
> -	int inst = ip_block->instance;
>   
>   	if (amdgpu_sriov_vf(adev))
>   		return 0;
> @@ -1798,9 +1818,9 @@ static int vcn_v2_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   	if (enable) {
>   		if (!vcn_v2_5_is_idle(adev))
>   			return -EBUSY;
> -		vcn_v2_5_enable_clock_gating(adev, inst);
> +		vcn_v2_5_enable_clock_gating(adev);
>   	} else {
> -		vcn_v2_5_disable_clock_gating(adev, inst);
> +		vcn_v2_5_disable_clock_gating(adev);
>   	}
>   
>   	return 0;
> @@ -1810,22 +1830,21 @@ static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int inst = ip_block->instance;
>   	int ret;
>   
>   	if (amdgpu_sriov_vf(adev))
>   		return 0;
>   
> -	if (state == adev->vcn.inst[inst].cur_state)
> +	if(state == adev->vcn.cur_state)
>   		return 0;
>   
>   	if (state == AMD_PG_STATE_GATE)
> -		ret = vcn_v2_5_stop(adev, inst);
> +		ret = vcn_v2_5_stop(adev);
>   	else
> -		ret = vcn_v2_5_start(adev, inst);
> +		ret = vcn_v2_5_start(adev);
>   
> -	if (!ret)
> -		adev->vcn.inst[inst].cur_state = state;
> +	if(!ret)
> +		adev->vcn.cur_state = state;
>   
>   	return ret;
>   }
> @@ -1895,73 +1914,79 @@ static const struct amdgpu_irq_src_funcs vcn_v2_6_ras_irq_funcs = {
>   	.process = amdgpu_vcn_process_poison_irq,
>   };
>   
> -static void vcn_v2_5_set_irq_funcs(struct amdgpu_device *adev, int inst)
> +static void vcn_v2_5_set_irq_funcs(struct amdgpu_device *adev)
>   {
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		return;
> +	int i;
>   
> -	adev->vcn.inst[inst].irq.num_types = adev->vcn.num_enc_rings + 1;
> -	adev->vcn.inst[inst].irq.funcs = &vcn_v2_5_irq_funcs;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
> +		adev->vcn.inst[i].irq.num_types = adev->vcn.num_enc_rings + 1;
> +		adev->vcn.inst[i].irq.funcs = &vcn_v2_5_irq_funcs;
>   
> -	adev->vcn.inst[inst].ras_poison_irq.num_types = adev->vcn.num_enc_rings + 1;
> -	adev->vcn.inst[inst].ras_poison_irq.funcs = &vcn_v2_6_ras_irq_funcs;
> +		adev->vcn.inst[i].ras_poison_irq.num_types = adev->vcn.num_enc_rings + 1;
> +		adev->vcn.inst[i].ras_poison_irq.funcs = &vcn_v2_6_ras_irq_funcs;
> +	}
>   }
>   
>   static void vcn_v2_5_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int i;
> +	int i, j;
>   	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_2_5);
> -	uint32_t is_powered;
> -	int inst = ip_block->instance;
> +	uint32_t inst_off, is_powered;
>   
> -	if (!ip_block->ip_dump)
> +	if (!adev->vcn.ip_dump)
>   		return;
>   
> -	drm_printf(p, "Instance no:VCN%d\n", inst);
> -
> -	if (adev->vcn.harvest_config & (1 << inst)) {
> -		drm_printf(p, "\nHarvested Instance:VCN%d Skipping dump\n", inst);
> -		return;
> -	}
> +	drm_printf(p, "num_instances:%d\n", adev->vcn.num_vcn_inst);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		if (adev->vcn.harvest_config & (1 << i)) {
> +			drm_printf(p, "\nHarvested Instance:VCN%d Skipping dump\n", i);
> +			continue;
> +		}
>   
> -	is_powered = (ip_block->ip_dump[0] &
> -		      UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
> +		inst_off = i * reg_count;
> +		is_powered = (adev->vcn.ip_dump[inst_off] &
> +				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
>   
> -	if (is_powered) {
> -		drm_printf(p, "\nActive Instance:VCN%d\n", inst);
> -		for (i = 0; i < reg_count; i++)
> -			drm_printf(p, "%-50s \t 0x%08x\n",
> -				   vcn_reg_list_2_5[i].reg_name,
> -				   ip_block->ip_dump[i]);
> -	} else {
> -		drm_printf(p, "\nInactive Instance:VCN%d\n", inst);
> +		if (is_powered) {
> +			drm_printf(p, "\nActive Instance:VCN%d\n", i);
> +			for (j = 0; j < reg_count; j++)
> +				drm_printf(p, "%-50s \t 0x%08x\n", vcn_reg_list_2_5[j].reg_name,
> +					   adev->vcn.ip_dump[inst_off + j]);
> +		} else {
> +			drm_printf(p, "\nInactive Instance:VCN%d\n", i);
> +		}
>   	}
>   }
>   
>   static void vcn_v2_5_dump_ip_state(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int i;
> +	int i, j;
>   	bool is_powered;
> +	uint32_t inst_off;
>   	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_2_5);
> -	int inst = ip_block->instance;
>   
> -	if (!ip_block->ip_dump)
> +	if (!adev->vcn.ip_dump)
>   		return;
>   
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		return;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
>   
> -	/* mmUVD_POWER_STATUS is always readable and is first element of the array */
> -	ip_block->ip_dump[0] = RREG32_SOC15(VCN, inst, mmUVD_POWER_STATUS);
> -	is_powered = (ip_block->ip_dump[0] &
> -		      UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
> +		inst_off = i * reg_count;
> +		/* mmUVD_POWER_STATUS is always readable and is first element of the array */
> +		adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, mmUVD_POWER_STATUS);
> +		is_powered = (adev->vcn.ip_dump[inst_off] &
> +				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
>   
> -	if (is_powered)
> -		for (i = 1; i < reg_count; i++)
> -			ip_block->ip_dump[i] =
> -			RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_2_5[i], inst));
> +		if (is_powered)
> +			for (j = 1; j < reg_count; j++)
> +				adev->vcn.ip_dump[inst_off + j] =
> +					RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_2_5[j], i));
> +	}
>   }
>   
>   static const struct amd_ip_funcs vcn_v2_5_ip_funcs = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index 1c149b5f5a79..63ddd4cca910 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -102,9 +102,9 @@ static int amdgpu_ih_clientid_vcns[] = {
>   };
>   
>   static int vcn_v3_0_start_sriov(struct amdgpu_device *adev);
> -static void vcn_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev, int inst);
> -static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev, int inst);
> -static void vcn_v3_0_set_irq_funcs(struct amdgpu_device *adev, int inst);
> +static void vcn_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev);
> +static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev);
> +static void vcn_v3_0_set_irq_funcs(struct amdgpu_device *adev);
>   static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   			enum amd_powergating_state state);
>   static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
> @@ -124,7 +124,6 @@ static void vcn_v3_0_enc_ring_set_wptr(struct amdgpu_ring *ring);
>   static int vcn_v3_0_early_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int inst = ip_block->instance;
>   
>   	if (amdgpu_sriov_vf(adev)) {
>   		adev->vcn.num_vcn_inst = VCN_INSTANCES_SIENNA_CICHLID;
> @@ -144,11 +143,11 @@ static int vcn_v3_0_early_init(struct amdgpu_ip_block *ip_block)
>   			adev->vcn.num_enc_rings = 2;
>   	}
>   
> -	vcn_v3_0_set_dec_ring_funcs(adev, inst);
> -	vcn_v3_0_set_enc_ring_funcs(adev, inst);
> -	vcn_v3_0_set_irq_funcs(adev, inst);
> +	vcn_v3_0_set_dec_ring_funcs(adev);
> +	vcn_v3_0_set_enc_ring_funcs(adev);
> +	vcn_v3_0_set_irq_funcs(adev);
>   
> -	return amdgpu_vcn_early_init(adev, inst);
> +	return amdgpu_vcn_early_init(adev);
>   }
>   
>   /**
> @@ -160,21 +159,20 @@ static int vcn_v3_0_early_init(struct amdgpu_ip_block *ip_block)
>    */
>   static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = ip_block->adev;
> -	int inst = ip_block->instance;
>   	struct amdgpu_ring *ring;
> +	int i, j, r;
>   	int vcn_doorbell_index = 0;
>   	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_3_0);
>   	uint32_t *ptr;
> -	int j, r;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
> -	r = amdgpu_vcn_sw_init(adev, inst);
> +	r = amdgpu_vcn_sw_init(adev);
>   	if (r)
>   		return r;
>   
> -	amdgpu_vcn_setup_ucode(adev, inst);
> +	amdgpu_vcn_setup_ucode(adev);
>   
> -	r = amdgpu_vcn_resume(adev, inst);
> +	r = amdgpu_vcn_resume(adev);
>   	if (r)
>   		return r;
>   
> @@ -191,91 +189,93 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
>   		vcn_doorbell_index = vcn_doorbell_index << 1;
>   	}
>   
> -	volatile struct amdgpu_fw_shared *fw_shared;
> -
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		goto done;
> -
> -	adev->vcn.internal.context_id = mmUVD_CONTEXT_ID_INTERNAL_OFFSET;
> -	adev->vcn.internal.ib_vmid = mmUVD_LMI_RBC_IB_VMID_INTERNAL_OFFSET;
> -	adev->vcn.internal.ib_bar_low = mmUVD_LMI_RBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET;
> -	adev->vcn.internal.ib_bar_high = mmUVD_LMI_RBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET;
> -	adev->vcn.internal.ib_size = mmUVD_RBC_IB_SIZE_INTERNAL_OFFSET;
> -	adev->vcn.internal.gp_scratch8 = mmUVD_GP_SCRATCH8_INTERNAL_OFFSET;
> -
> -	adev->vcn.internal.scratch9 = mmUVD_SCRATCH9_INTERNAL_OFFSET;
> -	adev->vcn.inst[inst].external.scratch9 = SOC15_REG_OFFSET(VCN, inst, mmUVD_SCRATCH9);
> -	adev->vcn.internal.data0 = mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFSET;
> -	adev->vcn.inst[inst].external.data0 = SOC15_REG_OFFSET(VCN, inst, mmUVD_GPCOM_VCPU_DATA0);
> -	adev->vcn.internal.data1 = mmUVD_GPCOM_VCPU_DATA1_INTERNAL_OFFSET;
> -	adev->vcn.inst[inst].external.data1 = SOC15_REG_OFFSET(VCN, inst, mmUVD_GPCOM_VCPU_DATA1);
> -	adev->vcn.internal.cmd = mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET;
> -	adev->vcn.inst[inst].external.cmd = SOC15_REG_OFFSET(VCN, inst, mmUVD_GPCOM_VCPU_CMD);
> -	adev->vcn.internal.nop = mmUVD_NO_OP_INTERNAL_OFFSET;
> -	adev->vcn.inst[inst].external.nop = SOC15_REG_OFFSET(VCN, inst, mmUVD_NO_OP);
> -
> -	/* VCN DEC TRAP */
> -	r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
> -			VCN_2_0__SRCID__UVD_SYSTEM_MESSAGE_INTERRUPT, &adev->vcn.inst[inst].irq);
> -	if (r)
> -		return r;
> -
> -	atomic_set(&adev->vcn.inst[inst].sched_score, 0);
> -
> -	ring = &adev->vcn.inst[inst].ring_dec;
> -	ring->use_doorbell = true;
> -	if (amdgpu_sriov_vf(adev)) {
> -		ring->doorbell_index = vcn_doorbell_index + inst * (adev->vcn.num_enc_rings + 1);
> -	} else {
> -		ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 8 * inst;
> -	}
> -	ring->vm_hub = AMDGPU_MMHUB0(0);
> -	sprintf(ring->name, "vcn_dec_%d", inst);
> -	r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[inst].irq, 0,
> -				 AMDGPU_RING_PRIO_DEFAULT,
> -				 &adev->vcn.inst[inst].sched_score);
> -	if (r)
> -		return r;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		volatile struct amdgpu_fw_shared *fw_shared;
>   
> -	for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
> -		enum amdgpu_ring_priority_level hw_prio = amdgpu_vcn_get_enc_ring_prio(j);
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
>   
> -		/* VCN ENC TRAP */
> -		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
> -			j + VCN_2_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst[inst].irq);
> +		adev->vcn.internal.context_id = mmUVD_CONTEXT_ID_INTERNAL_OFFSET;
> +		adev->vcn.internal.ib_vmid = mmUVD_LMI_RBC_IB_VMID_INTERNAL_OFFSET;
> +		adev->vcn.internal.ib_bar_low = mmUVD_LMI_RBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET;
> +		adev->vcn.internal.ib_bar_high = mmUVD_LMI_RBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET;
> +		adev->vcn.internal.ib_size = mmUVD_RBC_IB_SIZE_INTERNAL_OFFSET;
> +		adev->vcn.internal.gp_scratch8 = mmUVD_GP_SCRATCH8_INTERNAL_OFFSET;
> +
> +		adev->vcn.internal.scratch9 = mmUVD_SCRATCH9_INTERNAL_OFFSET;
> +		adev->vcn.inst[i].external.scratch9 = SOC15_REG_OFFSET(VCN, i, mmUVD_SCRATCH9);
> +		adev->vcn.internal.data0 = mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFSET;
> +		adev->vcn.inst[i].external.data0 = SOC15_REG_OFFSET(VCN, i, mmUVD_GPCOM_VCPU_DATA0);
> +		adev->vcn.internal.data1 = mmUVD_GPCOM_VCPU_DATA1_INTERNAL_OFFSET;
> +		adev->vcn.inst[i].external.data1 = SOC15_REG_OFFSET(VCN, i, mmUVD_GPCOM_VCPU_DATA1);
> +		adev->vcn.internal.cmd = mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET;
> +		adev->vcn.inst[i].external.cmd = SOC15_REG_OFFSET(VCN, i, mmUVD_GPCOM_VCPU_CMD);
> +		adev->vcn.internal.nop = mmUVD_NO_OP_INTERNAL_OFFSET;
> +		adev->vcn.inst[i].external.nop = SOC15_REG_OFFSET(VCN, i, mmUVD_NO_OP);
> +
> +		/* VCN DEC TRAP */
> +		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[i],
> +				VCN_2_0__SRCID__UVD_SYSTEM_MESSAGE_INTERRUPT, &adev->vcn.inst[i].irq);
>   		if (r)
>   			return r;
>   
> -		ring = &adev->vcn.inst[inst].ring_enc[j];
> +		atomic_set(&adev->vcn.inst[i].sched_score, 0);
> +
> +		ring = &adev->vcn.inst[i].ring_dec;
>   		ring->use_doorbell = true;
>   		if (amdgpu_sriov_vf(adev)) {
> -			ring->doorbell_index = vcn_doorbell_index + inst * (adev->vcn.num_enc_rings + 1) + 1 + j;
> +			ring->doorbell_index = vcn_doorbell_index + i * (adev->vcn.num_enc_rings + 1);
>   		} else {
> -			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 2 + j + 8 * inst;
> +			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 8 * i;
>   		}
>   		ring->vm_hub = AMDGPU_MMHUB0(0);
> -		sprintf(ring->name, "vcn_enc_%d.%d", inst, j);
> -		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[inst].irq, 0,
> -					 hw_prio, &adev->vcn.inst[inst].sched_score);
> +		sprintf(ring->name, "vcn_dec_%d", i);
> +		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[i].irq, 0,
> +				     AMDGPU_RING_PRIO_DEFAULT,
> +				     &adev->vcn.inst[i].sched_score);
>   		if (r)
>   			return r;
> +
> +		for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
> +			enum amdgpu_ring_priority_level hw_prio = amdgpu_vcn_get_enc_ring_prio(j);
> +
> +			/* VCN ENC TRAP */
> +			r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[i],
> +				j + VCN_2_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst[i].irq);
> +			if (r)
> +				return r;
> +
> +			ring = &adev->vcn.inst[i].ring_enc[j];
> +			ring->use_doorbell = true;
> +			if (amdgpu_sriov_vf(adev)) {
> +				ring->doorbell_index = vcn_doorbell_index + i * (adev->vcn.num_enc_rings + 1) + 1 + j;
> +			} else {
> +				ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 2 + j + 8 * i;
> +			}
> +			ring->vm_hub = AMDGPU_MMHUB0(0);
> +			sprintf(ring->name, "vcn_enc_%d.%d", i, j);
> +			r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[i].irq, 0,
> +					     hw_prio, &adev->vcn.inst[i].sched_score);
> +			if (r)
> +				return r;
> +		}
> +
> +		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
> +		fw_shared->present_flag_0 |= cpu_to_le32(AMDGPU_VCN_SW_RING_FLAG) |
> +					     cpu_to_le32(AMDGPU_VCN_MULTI_QUEUE_FLAG) |
> +					     cpu_to_le32(AMDGPU_VCN_FW_SHARED_FLAG_0_RB);
> +		fw_shared->sw_ring.is_enabled = cpu_to_le32(DEC_SW_RING_ENABLED);
> +		fw_shared->present_flag_0 |= AMDGPU_VCN_SMU_VERSION_INFO_FLAG;
> +		if (amdgpu_ip_version(adev, UVD_HWIP, 0) == IP_VERSION(3, 1, 2))
> +			fw_shared->smu_interface_info.smu_interface_type = 2;
> +		else if (amdgpu_ip_version(adev, UVD_HWIP, 0) ==
> +			 IP_VERSION(3, 1, 1))
> +			fw_shared->smu_interface_info.smu_interface_type = 1;
> +
> +		if (amdgpu_vcnfw_log)
> +			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
>   	}
>   
> -	fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
> -	fw_shared->present_flag_0 |= cpu_to_le32(AMDGPU_VCN_SW_RING_FLAG) |
> -					 cpu_to_le32(AMDGPU_VCN_MULTI_QUEUE_FLAG) |
> -					 cpu_to_le32(AMDGPU_VCN_FW_SHARED_FLAG_0_RB);
> -	fw_shared->sw_ring.is_enabled = cpu_to_le32(DEC_SW_RING_ENABLED);
> -	fw_shared->present_flag_0 |= AMDGPU_VCN_SMU_VERSION_INFO_FLAG;
> -	if (amdgpu_ip_version(adev, UVD_HWIP, 0) == IP_VERSION(3, 1, 2))
> -		fw_shared->smu_interface_info.smu_interface_type = 2;
> -	else if (amdgpu_ip_version(adev, UVD_HWIP, 0) ==
> -		 IP_VERSION(3, 1, 1))
> -		fw_shared->smu_interface_info.smu_interface_type = 1;
> -
> -	if (amdgpu_vcnfw_log)
> -		amdgpu_vcn_fwlog_init(&adev->vcn.inst[inst]);
> -done:
>   	if (amdgpu_sriov_vf(adev)) {
>   		r = amdgpu_virt_alloc_mm_table(adev);
>   		if (r)
> @@ -285,12 +285,12 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
>   		adev->vcn.pause_dpg_mode = vcn_v3_0_pause_dpg_mode;
>   
>   	/* Allocate memory for VCN IP Dump buffer */
> -	ptr = kcalloc(reg_count, sizeof(uint32_t), GFP_KERNEL);
> +	ptr = kcalloc(adev->vcn.num_vcn_inst * reg_count, sizeof(uint32_t), GFP_KERNEL);
>   	if (ptr == NULL) {
>   		DRM_ERROR("Failed to allocate memory for VCN IP Dump\n");
> -		ip_block->ip_dump = NULL;
> +		adev->vcn.ip_dump = NULL;
>   	} else {
> -		ip_block->ip_dump = ptr;
> +		adev->vcn.ip_dump = ptr;
>   	}
>   
>   	return 0;
> @@ -306,32 +306,32 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
>   static int vcn_v3_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int inst = ip_block->instance;
> -	int r, idx;
> +	int i, r, idx;
>   
>   	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> -		volatile struct amdgpu_fw_shared *fw_shared;
> -
> -		if (adev->vcn.harvest_config & (1 << inst))
> -			goto done;
> +		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +			volatile struct amdgpu_fw_shared *fw_shared;
> +
> +			if (adev->vcn.harvest_config & (1 << i))
> +				continue;
> +			fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
> +			fw_shared->present_flag_0 = 0;
> +			fw_shared->sw_ring.is_enabled = false;
> +		}
>   
> -		fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
> -		fw_shared->present_flag_0 = 0;
> -		fw_shared->sw_ring.is_enabled = false;
> -	done:
>   		drm_dev_exit(idx);
>   	}
>   
>   	if (amdgpu_sriov_vf(adev))
>   		amdgpu_virt_free_mm_table(adev);
>   
> -	r = amdgpu_vcn_suspend(adev, inst);
> +	r = amdgpu_vcn_suspend(adev);
>   	if (r)
>   		return r;
>   
> -	r = amdgpu_vcn_sw_fini(adev, inst);
> +	r = amdgpu_vcn_sw_fini(adev);
>   
> -	kfree(ip_block->ip_dump);
> +	kfree(adev->vcn.ip_dump);
>   	return r;
>   }
>   
> @@ -345,9 +345,8 @@ static int vcn_v3_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   static int vcn_v3_0_hw_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int inst = ip_block->instance;
>   	struct amdgpu_ring *ring;
> -	int j, r;
> +	int i, j, r;
>   
>   	if (amdgpu_sriov_vf(adev)) {
>   		r = vcn_v3_0_start_sriov(adev);
> @@ -355,53 +354,57 @@ static int vcn_v3_0_hw_init(struct amdgpu_ip_block *ip_block)
>   			return r;
>   
>   		/* initialize VCN dec and enc ring buffers */
> -		if (adev->vcn.harvest_config & (1 << inst))
> -			return 0;
> -
> -		ring = &adev->vcn.inst[inst].ring_dec;
> -		if (amdgpu_vcn_is_disabled_vcn(adev, VCN_DECODE_RING, inst)) {
> -			ring->sched.ready = false;
> -			ring->no_scheduler = true;
> -			dev_info(adev->dev, "ring %s is disabled by hypervisor\n", ring->name);
> -		} else {
> -			ring->wptr = 0;
> -			ring->wptr_old = 0;
> -			vcn_v3_0_dec_ring_set_wptr(ring);
> -			ring->sched.ready = true;
> -		}
> +		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +			if (adev->vcn.harvest_config & (1 << i))
> +				continue;
>   
> -		for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
> -			ring = &adev->vcn.inst[inst].ring_enc[j];
> -			if (amdgpu_vcn_is_disabled_vcn(adev, VCN_ENCODE_RING, inst)) {
> +			ring = &adev->vcn.inst[i].ring_dec;
> +			if (amdgpu_vcn_is_disabled_vcn(adev, VCN_DECODE_RING, i)) {
>   				ring->sched.ready = false;
>   				ring->no_scheduler = true;
>   				dev_info(adev->dev, "ring %s is disabled by hypervisor\n", ring->name);
>   			} else {
>   				ring->wptr = 0;
>   				ring->wptr_old = 0;
> -				vcn_v3_0_enc_ring_set_wptr(ring);
> +				vcn_v3_0_dec_ring_set_wptr(ring);
>   				ring->sched.ready = true;
>   			}
> -		}
> -	}
>   
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		return 0;
> +			for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
> +				ring = &adev->vcn.inst[i].ring_enc[j];
> +				if (amdgpu_vcn_is_disabled_vcn(adev, VCN_ENCODE_RING, i)) {
> +					ring->sched.ready = false;
> +					ring->no_scheduler = true;
> +					dev_info(adev->dev, "ring %s is disabled by hypervisor\n", ring->name);
> +				} else {
> +					ring->wptr = 0;
> +					ring->wptr_old = 0;
> +					vcn_v3_0_enc_ring_set_wptr(ring);
> +					ring->sched.ready = true;
> +				}
> +			}
> +		}
> +	} else {
> +		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +			if (adev->vcn.harvest_config & (1 << i))
> +				continue;
>   
> -	ring = &adev->vcn.inst[inst].ring_dec;
> +			ring = &adev->vcn.inst[i].ring_dec;
>   
> -	adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
> -					 ring->doorbell_index, inst);
> +			adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
> +						     ring->doorbell_index, i);
>   
> -	r = amdgpu_ring_test_helper(ring);
> -	if (r)
> -		return r;
> +			r = amdgpu_ring_test_helper(ring);
> +			if (r)
> +				return r;
>   
> -	for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
> -		ring = &adev->vcn.inst[inst].ring_enc[j];
> -		r = amdgpu_ring_test_helper(ring);
> -		if (r)
> -			return r;
> +			for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
> +				ring = &adev->vcn.inst[i].ring_enc[j];
> +				r = amdgpu_ring_test_helper(ring);
> +				if (r)
> +					return r;
> +			}
> +		}
>   	}
>   
>   	return 0;
> @@ -417,18 +420,20 @@ static int vcn_v3_0_hw_init(struct amdgpu_ip_block *ip_block)
>   static int vcn_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int inst = ip_block->instance;
> +	int i;
>   
> -	cancel_delayed_work_sync(&adev->vcn.inst[inst].idle_work);
> +	cancel_delayed_work_sync(&adev->vcn.idle_work);
>   
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		return 0;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
>   
> -	if (!amdgpu_sriov_vf(adev)) {
> -		if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> -		    (adev->vcn.inst[inst].cur_state != AMD_PG_STATE_GATE &&
> -		     RREG32_SOC15(VCN, inst, mmUVD_STATUS))) {
> -			vcn_v3_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
> +		if (!amdgpu_sriov_vf(adev)) {
> +			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> +				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> +				 RREG32_SOC15(VCN, i, mmUVD_STATUS))) {
> +				vcn_v3_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
> +			}
>   		}
>   	}
>   
> @@ -444,15 +449,13 @@ static int vcn_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
>    */
>   static int vcn_v3_0_suspend(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = ip_block->adev;
> -	int inst = ip_block->instance;
>   	int r;
>   
>   	r = vcn_v3_0_hw_fini(ip_block);
>   	if (r)
>   		return r;
>   
> -	r = amdgpu_vcn_suspend(adev, inst);
> +	r = amdgpu_vcn_suspend(ip_block->adev);
>   
>   	return r;
>   }
> @@ -468,7 +471,7 @@ static int vcn_v3_0_resume(struct amdgpu_ip_block *ip_block)
>   {
>   	int r;
>   
> -	r = amdgpu_vcn_resume(ip_block->adev, ip_block->instance);
> +	r = amdgpu_vcn_resume(ip_block->adev);
>   	if (r)
>   		return r;
>   
> @@ -1131,188 +1134,192 @@ static int vcn_v3_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
>   	return 0;
>   }
>   
> -static int vcn_v3_0_start(struct amdgpu_device *adev, unsigned int inst)
> +static int vcn_v3_0_start(struct amdgpu_device *adev)
>   {
>   	volatile struct amdgpu_fw_shared *fw_shared;
>   	struct amdgpu_ring *ring;
>   	uint32_t rb_bufsz, tmp;
> -	int j, k, r;
> -
> -	if (adev->pm.dpm_enabled)
> -		amdgpu_dpm_enable_vcn(adev, true, inst);
> -
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		return 0;
> +	int i, j, k, r;
>   
> -	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> -		r = vcn_v3_0_start_dpg_mode(adev, inst, adev->vcn.indirect_sram);
> -		return r;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->pm.dpm_enabled)
> +			amdgpu_dpm_enable_vcn(adev, true, i);
>   	}
>   
> -	/* disable VCN power gating */
> -	vcn_v3_0_disable_static_power_gating(adev, inst);
> -
> -	/* set VCN status busy */
> -	tmp = RREG32_SOC15(VCN, inst, mmUVD_STATUS) | UVD_STATUS__UVD_BUSY;
> -	WREG32_SOC15(VCN, inst, mmUVD_STATUS, tmp);
> -
> -	/*SW clock gating */
> -	vcn_v3_0_disable_clock_gating(adev, inst);
> -
> -	/* enable VCPU clock */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL),
> -		UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
> -
> -	/* disable master interrupt */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_MASTINT_EN), 0,
> -		~UVD_MASTINT_EN__VCPU_EN_MASK);
> -
> -	/* enable LMI MC and UMC channels */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_LMI_CTRL2), 0,
> -		~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
> -
> -	tmp = RREG32_SOC15(VCN, inst, mmUVD_SOFT_RESET);
> -	tmp &= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> -	tmp &= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> -	WREG32_SOC15(VCN, inst, mmUVD_SOFT_RESET, tmp);
> -
> -	/* setup mmUVD_LMI_CTRL */
> -	tmp = RREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL);
> -	WREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL, tmp |
> -		UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK	|
> -		UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
> -		UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
> -		UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
> -
> -	/* setup mmUVD_MPC_CNTL */
> -	tmp = RREG32_SOC15(VCN, inst, mmUVD_MPC_CNTL);
> -	tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
> -	tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
> -	WREG32_SOC15(VCN, inst, mmUVD_MPC_CNTL, tmp);
> -
> -	/* setup UVD_MPC_SET_MUXA0 */
> -	WREG32_SOC15(VCN, inst, mmUVD_MPC_SET_MUXA0,
> -		((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
> -		(0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
> -		(0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
> -		(0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
> -
> -	/* setup UVD_MPC_SET_MUXB0 */
> -	WREG32_SOC15(VCN, inst, mmUVD_MPC_SET_MUXB0,
> -		((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
> -		(0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
> -		(0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
> -		(0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
> -
> -	/* setup mmUVD_MPC_SET_MUX */
> -	WREG32_SOC15(VCN, inst, mmUVD_MPC_SET_MUX,
> -		((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
> -		(0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
> -		(0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
> -
> -	vcn_v3_0_mc_resume(adev, inst);
> -
> -	/* VCN global tiling registers */
> -	WREG32_SOC15(VCN, inst, mmUVD_GFX10_ADDR_CONFIG,
> -		adev->gfx.config.gb_addr_config);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
>   
> -	/* unblock VCPU register access */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_RB_ARB_CTRL), 0,
> -		~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> +		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> +			r = vcn_v3_0_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
> +			continue;
> +		}
>   
> -	/* release VCPU reset to boot */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL), 0,
> -		~UVD_VCPU_CNTL__BLK_RST_MASK);
> +		/* disable VCN power gating */
> +		vcn_v3_0_disable_static_power_gating(adev, i);
> +
> +		/* set VCN status busy */
> +		tmp = RREG32_SOC15(VCN, i, mmUVD_STATUS) | UVD_STATUS__UVD_BUSY;
> +		WREG32_SOC15(VCN, i, mmUVD_STATUS, tmp);
> +
> +		/*SW clock gating */
> +		vcn_v3_0_disable_clock_gating(adev, i);
> +
> +		/* enable VCPU clock */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
> +			UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
> +
> +		/* disable master interrupt */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN), 0,
> +			~UVD_MASTINT_EN__VCPU_EN_MASK);
> +
> +		/* enable LMI MC and UMC channels */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_LMI_CTRL2), 0,
> +			~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
> +
> +		tmp = RREG32_SOC15(VCN, i, mmUVD_SOFT_RESET);
> +		tmp &= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> +		tmp &= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> +		WREG32_SOC15(VCN, i, mmUVD_SOFT_RESET, tmp);
> +
> +		/* setup mmUVD_LMI_CTRL */
> +		tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL);
> +		WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL, tmp |
> +			UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK	|
> +			UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
> +			UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
> +			UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
> +
> +		/* setup mmUVD_MPC_CNTL */
> +		tmp = RREG32_SOC15(VCN, i, mmUVD_MPC_CNTL);
> +		tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
> +		tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
> +		WREG32_SOC15(VCN, i, mmUVD_MPC_CNTL, tmp);
> +
> +		/* setup UVD_MPC_SET_MUXA0 */
> +		WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXA0,
> +			((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
> +			(0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
> +			(0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
> +			(0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
> +
> +		/* setup UVD_MPC_SET_MUXB0 */
> +		WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXB0,
> +			((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
> +			(0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
> +			(0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
> +			(0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
> +
> +		/* setup mmUVD_MPC_SET_MUX */
> +		WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUX,
> +			((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
> +			(0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
> +			(0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
> +
> +		vcn_v3_0_mc_resume(adev, i);
> +
> +		/* VCN global tiling registers */
> +		WREG32_SOC15(VCN, i, mmUVD_GFX10_ADDR_CONFIG,
> +			adev->gfx.config.gb_addr_config);
> +
> +		/* unblock VCPU register access */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL), 0,
> +			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> +
> +		/* release VCPU reset to boot */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
> +			~UVD_VCPU_CNTL__BLK_RST_MASK);
>   
> -	for (j = 0; j < 10; ++j) {
> -		uint32_t status;
> +		for (j = 0; j < 10; ++j) {
> +			uint32_t status;
>   
> -		for (k = 0; k < 100; ++k) {
> -			status = RREG32_SOC15(VCN, inst, mmUVD_STATUS);
> +			for (k = 0; k < 100; ++k) {
> +				status = RREG32_SOC15(VCN, i, mmUVD_STATUS);
> +				if (status & 2)
> +					break;
> +				mdelay(10);
> +			}
> +			r = 0;
>   			if (status & 2)
>   				break;
> -			mdelay(10);
> -		}
> -		r = 0;
> -		if (status & 2)
> -			break;
> -
> -		DRM_ERROR("VCN[%d] decode not responding, trying to reset the VCPU!!!\n", inst);
> -		WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL),
> -			UVD_VCPU_CNTL__BLK_RST_MASK,
> -			~UVD_VCPU_CNTL__BLK_RST_MASK);
> -		mdelay(10);
> -		WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL), 0,
> -			~UVD_VCPU_CNTL__BLK_RST_MASK);
>   
> -		mdelay(10);
> -		r = -1;
> -	}
> +			DRM_ERROR("VCN[%d] decode not responding, trying to reset the VCPU!!!\n", i);
> +			WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
> +				UVD_VCPU_CNTL__BLK_RST_MASK,
> +				~UVD_VCPU_CNTL__BLK_RST_MASK);
> +			mdelay(10);
> +			WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
> +				~UVD_VCPU_CNTL__BLK_RST_MASK);
>   
> -	if (r) {
> -		DRM_ERROR("VCN[%d] decode not responding, giving up!!!\n", inst);
> -		return r;
> -	}
> +			mdelay(10);
> +			r = -1;
> +		}
>   
> -	/* enable master interrupt */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_MASTINT_EN),
> -		UVD_MASTINT_EN__VCPU_EN_MASK,
> -		~UVD_MASTINT_EN__VCPU_EN_MASK);
> +		if (r) {
> +			DRM_ERROR("VCN[%d] decode not responding, giving up!!!\n", i);
> +			return r;
> +		}
>   
> -	/* clear the busy bit of VCN_STATUS */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_STATUS), 0,
> -		~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
> +		/* enable master interrupt */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN),
> +			UVD_MASTINT_EN__VCPU_EN_MASK,
> +			~UVD_MASTINT_EN__VCPU_EN_MASK);
>   
> -	WREG32_SOC15(VCN, inst, mmUVD_LMI_RBC_RB_VMID, 0);
> +		/* clear the busy bit of VCN_STATUS */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_STATUS), 0,
> +			~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
>   
> -	ring = &adev->vcn.inst[inst].ring_dec;
> -	/* force RBC into idle state */
> -	rb_bufsz = order_base_2(ring->ring_size);
> -	tmp = REG_SET_FIELD(0, UVD_RBC_RB_CNTL, RB_BUFSZ, rb_bufsz);
> -	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_BLKSZ, 1);
> -	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH, 1);
> -	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE, 1);
> -	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
> -	WREG32_SOC15(VCN, inst, mmUVD_RBC_RB_CNTL, tmp);
> +		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_VMID, 0);
>   
> -	fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
> -	fw_shared->multi_queue.decode_queue_mode |= cpu_to_le32(FW_QUEUE_RING_RESET);
> +		ring = &adev->vcn.inst[i].ring_dec;
> +		/* force RBC into idle state */
> +		rb_bufsz = order_base_2(ring->ring_size);
> +		tmp = REG_SET_FIELD(0, UVD_RBC_RB_CNTL, RB_BUFSZ, rb_bufsz);
> +		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_BLKSZ, 1);
> +		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH, 1);
> +		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE, 1);
> +		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
> +		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_CNTL, tmp);
>   
> -	/* programm the RB_BASE for ring buffer */
> -	WREG32_SOC15(VCN, inst, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
> -		lower_32_bits(ring->gpu_addr));
> -	WREG32_SOC15(VCN, inst, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
> -		upper_32_bits(ring->gpu_addr));
> +		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
> +		fw_shared->multi_queue.decode_queue_mode |= cpu_to_le32(FW_QUEUE_RING_RESET);
>   
> -	/* Initialize the ring buffer's read and write pointers */
> -	WREG32_SOC15(VCN, inst, mmUVD_RBC_RB_RPTR, 0);
> +		/* programm the RB_BASE for ring buffer */
> +		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
> +			lower_32_bits(ring->gpu_addr));
> +		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
> +			upper_32_bits(ring->gpu_addr));
>   
> -	WREG32_SOC15(VCN, inst, mmUVD_SCRATCH2, 0);
> -	ring->wptr = RREG32_SOC15(VCN, inst, mmUVD_RBC_RB_RPTR);
> -	WREG32_SOC15(VCN, inst, mmUVD_RBC_RB_WPTR,
> -		lower_32_bits(ring->wptr));
> -	fw_shared->rb.wptr = lower_32_bits(ring->wptr);
> -	fw_shared->multi_queue.decode_queue_mode &= cpu_to_le32(~FW_QUEUE_RING_RESET);
> +		/* Initialize the ring buffer's read and write pointers */
> +		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR, 0);
>   
> -	if (amdgpu_ip_version(adev, UVD_HWIP, 0) !=
> -		IP_VERSION(3, 0, 33)) {
> -		fw_shared->multi_queue.encode_generalpurpose_queue_mode |= cpu_to_le32(FW_QUEUE_RING_RESET);
> -		ring = &adev->vcn.inst[inst].ring_enc[0];
> -		WREG32_SOC15(VCN, inst, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
> -		WREG32_SOC15(VCN, inst, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
> -		WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_LO, ring->gpu_addr);
> -		WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
> -		WREG32_SOC15(VCN, inst, mmUVD_RB_SIZE, ring->ring_size / 4);
> -		fw_shared->multi_queue.encode_generalpurpose_queue_mode &= cpu_to_le32(~FW_QUEUE_RING_RESET);
> -
> -		fw_shared->multi_queue.encode_lowlatency_queue_mode |= cpu_to_le32(FW_QUEUE_RING_RESET);
> -		ring = &adev->vcn.inst[inst].ring_enc[1];
> -		WREG32_SOC15(VCN, inst, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr));
> -		WREG32_SOC15(VCN, inst, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
> -		WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_LO2, ring->gpu_addr);
> -		WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
> -		WREG32_SOC15(VCN, inst, mmUVD_RB_SIZE2, ring->ring_size / 4);
> -		fw_shared->multi_queue.encode_lowlatency_queue_mode &= cpu_to_le32(~FW_QUEUE_RING_RESET);
> +		WREG32_SOC15(VCN, i, mmUVD_SCRATCH2, 0);
> +		ring->wptr = RREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR);
> +		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_WPTR,
> +			lower_32_bits(ring->wptr));
> +		fw_shared->rb.wptr = lower_32_bits(ring->wptr);
> +		fw_shared->multi_queue.decode_queue_mode &= cpu_to_le32(~FW_QUEUE_RING_RESET);
> +
> +		if (amdgpu_ip_version(adev, UVD_HWIP, 0) !=
> +		    IP_VERSION(3, 0, 33)) {
> +			fw_shared->multi_queue.encode_generalpurpose_queue_mode |= cpu_to_le32(FW_QUEUE_RING_RESET);
> +			ring = &adev->vcn.inst[i].ring_enc[0];
> +			WREG32_SOC15(VCN, i, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
> +			WREG32_SOC15(VCN, i, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
> +			WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO, ring->gpu_addr);
> +			WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
> +			WREG32_SOC15(VCN, i, mmUVD_RB_SIZE, ring->ring_size / 4);
> +			fw_shared->multi_queue.encode_generalpurpose_queue_mode &= cpu_to_le32(~FW_QUEUE_RING_RESET);
> +
> +			fw_shared->multi_queue.encode_lowlatency_queue_mode |= cpu_to_le32(FW_QUEUE_RING_RESET);
> +			ring = &adev->vcn.inst[i].ring_enc[1];
> +			WREG32_SOC15(VCN, i, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr));
> +			WREG32_SOC15(VCN, i, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
> +			WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO2, ring->gpu_addr);
> +			WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
> +			WREG32_SOC15(VCN, i, mmUVD_RB_SIZE2, ring->ring_size / 4);
> +			fw_shared->multi_queue.encode_lowlatency_queue_mode &= cpu_to_le32(~FW_QUEUE_RING_RESET);
> +		}
>   	}
>   
>   	return 0;
> @@ -1558,76 +1565,79 @@ static int vcn_v3_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
>   	return 0;
>   }
>   
> -static int vcn_v3_0_stop(struct amdgpu_device *adev, unsigned int inst)
> +static int vcn_v3_0_stop(struct amdgpu_device *adev)
>   {
>   	uint32_t tmp;
> -	int r = 0;
> +	int i, r = 0;
>   
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		goto done;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
>   
> -	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> -		r = vcn_v3_0_stop_dpg_mode(adev, inst);
> -		goto done;
> -	}
> +		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> +			r = vcn_v3_0_stop_dpg_mode(adev, i);
> +			continue;
> +		}
>   
> -	/* wait for vcn idle */
> -	r = SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7);
> -	if (r)
> -		return r;
> +		/* wait for vcn idle */
> +		r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7);
> +		if (r)
> +			return r;
>   
> -	tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
> -		UVD_LMI_STATUS__READ_CLEAN_MASK |
> -		UVD_LMI_STATUS__WRITE_CLEAN_MASK |
> -		UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
> -	r = SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_LMI_STATUS, tmp, tmp);
> -	if (r)
> -		return r;
> +		tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
> +			UVD_LMI_STATUS__READ_CLEAN_MASK |
> +			UVD_LMI_STATUS__WRITE_CLEAN_MASK |
> +			UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
> +		r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
> +		if (r)
> +			return r;
>   
> -	/* disable LMI UMC channel */
> -	tmp = RREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL2);
> -	tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
> -	WREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL2, tmp);
> -	tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK|
> -		UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
> -	r = SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_LMI_STATUS, tmp, tmp);
> -	if (r)
> -		return r;
> +		/* disable LMI UMC channel */
> +		tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2);
> +		tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
> +		WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2, tmp);
> +		tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK|
> +			UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
> +		r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
> +		if (r)
> +			return r;
>   
> -	/* block VCPU register access */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_RB_ARB_CTRL),
> -		UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
> -		~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> +		/* block VCPU register access */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL),
> +			UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
> +			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
>   
> -	/* reset VCPU */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL),
> -		UVD_VCPU_CNTL__BLK_RST_MASK,
> -		~UVD_VCPU_CNTL__BLK_RST_MASK);
> +		/* reset VCPU */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
> +			UVD_VCPU_CNTL__BLK_RST_MASK,
> +			~UVD_VCPU_CNTL__BLK_RST_MASK);
>   
> -	/* disable VCPU clock */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL), 0,
> -		~(UVD_VCPU_CNTL__CLK_EN_MASK));
> +		/* disable VCPU clock */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
> +			~(UVD_VCPU_CNTL__CLK_EN_MASK));
>   
> -	/* apply soft reset */
> -	tmp = RREG32_SOC15(VCN, inst, mmUVD_SOFT_RESET);
> -	tmp |= UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> -	WREG32_SOC15(VCN, inst, mmUVD_SOFT_RESET, tmp);
> -	tmp = RREG32_SOC15(VCN, inst, mmUVD_SOFT_RESET);
> -	tmp |= UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> -	WREG32_SOC15(VCN, inst, mmUVD_SOFT_RESET, tmp);
> +		/* apply soft reset */
> +		tmp = RREG32_SOC15(VCN, i, mmUVD_SOFT_RESET);
> +		tmp |= UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> +		WREG32_SOC15(VCN, i, mmUVD_SOFT_RESET, tmp);
> +		tmp = RREG32_SOC15(VCN, i, mmUVD_SOFT_RESET);
> +		tmp |= UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> +		WREG32_SOC15(VCN, i, mmUVD_SOFT_RESET, tmp);
>   
> -	/* clear status */
> -	WREG32_SOC15(VCN, inst, mmUVD_STATUS, 0);
> +		/* clear status */
> +		WREG32_SOC15(VCN, i, mmUVD_STATUS, 0);
>   
> -	/* apply HW clock gating */
> -	vcn_v3_0_enable_clock_gating(adev, inst);
> +		/* apply HW clock gating */
> +		vcn_v3_0_enable_clock_gating(adev, i);
>   
> -	/* enable VCN power gating */
> -	vcn_v3_0_enable_static_power_gating(adev, inst);
> +		/* enable VCN power gating */
> +		vcn_v3_0_enable_static_power_gating(adev, i);
> +	}
>   
> -done:
> -	if (adev->pm.dpm_enabled)
> -		amdgpu_dpm_enable_vcn(adev, false, inst);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->pm.dpm_enabled)
> +			amdgpu_dpm_enable_vcn(adev, false, i);
> +	}
>   
>   	return 0;
>   }
> @@ -2062,28 +2072,34 @@ static const struct amdgpu_ring_funcs vcn_v3_0_enc_ring_vm_funcs = {
>   	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
>   };
>   
> -static void vcn_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev, int inst)
> +static void vcn_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev)
>   {
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		return;
> +	int i;
>   
> -	if (!DEC_SW_RING_ENABLED)
> -		adev->vcn.inst[inst].ring_dec.funcs = &vcn_v3_0_dec_ring_vm_funcs;
> -	else
> -		adev->vcn.inst[inst].ring_dec.funcs = &vcn_v3_0_dec_sw_ring_vm_funcs;
> -	adev->vcn.inst[inst].ring_dec.me = inst;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
> +
> +		if (!DEC_SW_RING_ENABLED)
> +			adev->vcn.inst[i].ring_dec.funcs = &vcn_v3_0_dec_ring_vm_funcs;
> +		else
> +			adev->vcn.inst[i].ring_dec.funcs = &vcn_v3_0_dec_sw_ring_vm_funcs;
> +		adev->vcn.inst[i].ring_dec.me = i;
> +	}
>   }
>   
> -static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev, int inst)
> +static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev)
>   {
> -	int j;
> +	int i, j;
>   
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		return;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
>   
> -	for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
> -		adev->vcn.inst[inst].ring_enc[j].funcs = &vcn_v3_0_enc_ring_vm_funcs;
> -		adev->vcn.inst[inst].ring_enc[j].me = inst;
> +		for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
> +			adev->vcn.inst[i].ring_enc[j].funcs = &vcn_v3_0_enc_ring_vm_funcs;
> +			adev->vcn.inst[i].ring_enc[j].me = i;
> +		}
>   	}
>   }
>   
> @@ -2105,14 +2121,17 @@ static bool vcn_v3_0_is_idle(void *handle)
>   static int vcn_v3_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int inst = ip_block->instance;
> -	int ret;
> +	int i, ret = 0;
>   
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		return 0;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
>   
> -	ret = SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_STATUS, UVD_STATUS__IDLE,
> -		UVD_STATUS__IDLE);
> +		ret = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_STATUS, UVD_STATUS__IDLE,
> +			UVD_STATUS__IDLE);
> +		if (ret)
> +			return ret;
> +	}
>   
>   	return ret;
>   }
> @@ -2122,17 +2141,19 @@ static int vcn_v3_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
>   	bool enable = state == AMD_CG_STATE_GATE;
> -	int inst = ip_block->instance;
> +	int i;
>   
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		return 0;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
>   
> -	if (enable) {
> -		if (RREG32_SOC15(VCN, inst, mmUVD_STATUS) != UVD_STATUS__IDLE)
> -			return -EBUSY;
> -		vcn_v3_0_enable_clock_gating(adev, inst);
> -	} else {
> -		vcn_v3_0_disable_clock_gating(adev, inst);
> +		if (enable) {
> +			if (RREG32_SOC15(VCN, i, mmUVD_STATUS) != UVD_STATUS__IDLE)
> +				return -EBUSY;
> +			vcn_v3_0_enable_clock_gating(adev, i);
> +		} else {
> +			vcn_v3_0_disable_clock_gating(adev, i);
> +		}
>   	}
>   
>   	return 0;
> @@ -2142,7 +2163,6 @@ static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int inst = ip_block->instance;
>   	int ret;
>   
>   	/* for SRIOV, guest should not control VCN Power-gating
> @@ -2150,20 +2170,20 @@ static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   	 * guest should avoid touching CGC and PG
>   	 */
>   	if (amdgpu_sriov_vf(adev)) {
> -		adev->vcn.inst[inst].cur_state = AMD_PG_STATE_UNGATE;
> +		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
>   		return 0;
>   	}
>   
> -	if (state == adev->vcn.inst[inst].cur_state)
> +	if (state == adev->vcn.cur_state)
>   		return 0;
>   
>   	if (state == AMD_PG_STATE_GATE)
> -		ret = vcn_v3_0_stop(adev, inst);
> +		ret = vcn_v3_0_stop(adev);
>   	else
> -		ret = vcn_v3_0_start(adev, inst);
> +		ret = vcn_v3_0_start(adev);
>   
>   	if (!ret)
> -		adev->vcn.inst[inst].cur_state = state;
> +		adev->vcn.cur_state = state;
>   
>   	return ret;
>   }
> @@ -2220,69 +2240,78 @@ static const struct amdgpu_irq_src_funcs vcn_v3_0_irq_funcs = {
>   	.process = vcn_v3_0_process_interrupt,
>   };
>   
> -static void vcn_v3_0_set_irq_funcs(struct amdgpu_device *adev, int inst)
> +static void vcn_v3_0_set_irq_funcs(struct amdgpu_device *adev)
>   {
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		return;
> +	int i;
>   
> -	adev->vcn.inst[inst].irq.num_types = adev->vcn.num_enc_rings + 1;
> -	adev->vcn.inst[inst].irq.funcs = &vcn_v3_0_irq_funcs;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
> +
> +		adev->vcn.inst[i].irq.num_types = adev->vcn.num_enc_rings + 1;
> +		adev->vcn.inst[i].irq.funcs = &vcn_v3_0_irq_funcs;
> +	}
>   }
>   
>   static void vcn_v3_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int i;
> +	int i, j;
>   	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_3_0);
> +	uint32_t inst_off;
>   	bool is_powered;
> -	int inst = ip_block->instance;
>   
> -	if (!ip_block->ip_dump)
> +	if (!adev->vcn.ip_dump)
>   		return;
>   
> -	drm_printf(p, "Instance no:VCN%d\n", inst);
> -	if (adev->vcn.harvest_config & (1 << inst)) {
> -		drm_printf(p, "\nHarvested Instance:VCN%d Skipping dump\n", inst);
> -		return;
> -	}
> +	drm_printf(p, "num_instances:%d\n", adev->vcn.num_vcn_inst);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		if (adev->vcn.harvest_config & (1 << i)) {
> +			drm_printf(p, "\nHarvested Instance:VCN%d Skipping dump\n", i);
> +			continue;
> +		}
>   
> -	is_powered = (ip_block->ip_dump[0] &
> -		      UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
> +		inst_off = i * reg_count;
> +		is_powered = (adev->vcn.ip_dump[inst_off] &
> +			      UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
>   
> -	if (is_powered) {
> -		drm_printf(p, "\nActive Instance:VCN%d\n", inst);
> -		for (i = 0; i < reg_count; i++)
> -			drm_printf(p, "%-50s \t 0x%08x\n",
> -				   vcn_reg_list_3_0[i].reg_name,
> -				   ip_block->ip_dump[i]);
> -	} else {
> -		drm_printf(p, "\nInactive Instance:VCN%d\n", inst);
> +		if (is_powered) {
> +			drm_printf(p, "\nActive Instance:VCN%d\n", i);
> +			for (j = 0; j < reg_count; j++)
> +				drm_printf(p, "%-50s \t 0x%08x\n", vcn_reg_list_3_0[j].reg_name,
> +					   adev->vcn.ip_dump[inst_off + j]);
> +		} else {
> +			drm_printf(p, "\nInactive Instance:VCN%d\n", i);
> +		}
>   	}
>   }
>   
>   static void vcn_v3_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int i;
> +	int i, j;
>   	bool is_powered;
> +	uint32_t inst_off;
>   	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_3_0);
> -	int inst = ip_block->instance;
>   
> -	if (!ip_block->ip_dump)
> +	if (!adev->vcn.ip_dump)
>   		return;
>   
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		return;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
>   
> -	/* mmUVD_POWER_STATUS is always readable and is first element of the array */
> -	ip_block->ip_dump[0] = RREG32_SOC15(VCN, inst, mmUVD_POWER_STATUS);
> -	is_powered = (ip_block->ip_dump[0] &
> -		      UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
> +		inst_off = i * reg_count;
> +		/* mmUVD_POWER_STATUS is always readable and is first element of the array */
> +		adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, mmUVD_POWER_STATUS);
> +		is_powered = (adev->vcn.ip_dump[inst_off] &
> +			      UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
>   
> -	if (is_powered)
> -		for (i = 1; i < reg_count; i++)
> -			ip_block->ip_dump[i] =
> -				RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_3_0[i], inst));
> +		if (is_powered)
> +			for (j = 1; j < reg_count; j++)
> +				adev->vcn.ip_dump[inst_off + j] =
> +					RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_3_0[j], i));
> +	}
>   }
>   
>   static const struct amd_ip_funcs vcn_v3_0_ip_funcs = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index a8753bc5f66a..7aa6198e7733 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -94,8 +94,8 @@ static int amdgpu_ih_clientid_vcns[] = {
>   };
>   
>   static int vcn_v4_0_start_sriov(struct amdgpu_device *adev);
> -static void vcn_v4_0_set_unified_ring_funcs(struct amdgpu_device *adev, int inst);
> -static void vcn_v4_0_set_irq_funcs(struct amdgpu_device *adev, int inst);
> +static void vcn_v4_0_set_unified_ring_funcs(struct amdgpu_device *adev);
> +static void vcn_v4_0_set_irq_funcs(struct amdgpu_device *adev);
>   static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>           enum amd_powergating_state state);
>   static int vcn_v4_0_pause_dpg_mode(struct amdgpu_device *adev,
> @@ -114,24 +114,26 @@ static void vcn_v4_0_set_ras_funcs(struct amdgpu_device *adev);
>   static int vcn_v4_0_early_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int inst = ip_block->instance;
> +	int i;
>   
>   	if (amdgpu_sriov_vf(adev)) {
>   		adev->vcn.harvest_config = VCN_HARVEST_MMSCH;
> -		if (amdgpu_vcn_is_disabled_vcn(adev, VCN_ENCODE_RING, inst)) {
> -			adev->vcn.harvest_config |= 1 << inst;
> -			dev_info(adev->dev, "VCN%d is disabled by hypervisor\n", inst);
> +		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +			if (amdgpu_vcn_is_disabled_vcn(adev, VCN_ENCODE_RING, i)) {
> +				adev->vcn.harvest_config |= 1 << i;
> +				dev_info(adev->dev, "VCN%d is disabled by hypervisor\n", i);
> +			}
>   		}
>   	}
>   
>   	/* re-use enc ring as unified ring */
>   	adev->vcn.num_enc_rings = 1;
>   
> -	vcn_v4_0_set_unified_ring_funcs(adev, inst);
> -	vcn_v4_0_set_irq_funcs(adev, inst);
> +	vcn_v4_0_set_unified_ring_funcs(adev);
> +	vcn_v4_0_set_irq_funcs(adev);
>   	vcn_v4_0_set_ras_funcs(adev);
>   
> -	return amdgpu_vcn_early_init(adev, inst);
> +	return amdgpu_vcn_early_init(adev);
>   }
>   
>   static int vcn_v4_0_fw_shared_init(struct amdgpu_device *adev, int inst_idx)
> @@ -168,66 +170,61 @@ static int vcn_v4_0_fw_shared_init(struct amdgpu_device *adev, int inst_idx)
>    */
>   static int vcn_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = ip_block->adev;
> -	int inst = ip_block->instance;
>   	struct amdgpu_ring *ring;
> -	int r;
> -
> +	struct amdgpu_device *adev = ip_block->adev;
> +	int i, r;
>   	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0);
>   	uint32_t *ptr;
>   
> -	r = amdgpu_vcn_sw_init(adev, inst);
> +	r = amdgpu_vcn_sw_init(adev);
>   	if (r)
>   		return r;
>   
> -	amdgpu_vcn_setup_ucode(adev, inst);
> +	amdgpu_vcn_setup_ucode(adev);
>   
> -	r = amdgpu_vcn_resume(adev, inst);
> +	r = amdgpu_vcn_resume(adev);
>   	if (r)
>   		return r;
>   
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		goto done;
> -
> -	/* Init instance 0 sched_score to 1, so it's scheduled after other instances */
> -	if (inst == 0)
> -		atomic_set(&adev->vcn.inst[inst].sched_score, 1);
> -	else
> -		atomic_set(&adev->vcn.inst[inst].sched_score, 0);
> -
> -	/* VCN UNIFIED TRAP */
> -	r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
> -			VCN_4_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst[inst].irq);
> -	if (r)
> -		return r;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
>   
> -	/* VCN POISON TRAP */
> -	r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
> -			VCN_4_0__SRCID_UVD_POISON, &adev->vcn.inst[inst].ras_poison_irq);
> -	if (r)
> -		return r;
> +		/* Init instance 0 sched_score to 1, so it's scheduled after other instances */
> +		if (i == 0)
> +			atomic_set(&adev->vcn.inst[i].sched_score, 1);
> +		else
> +			atomic_set(&adev->vcn.inst[i].sched_score, 0);
>   
> -	ring = &adev->vcn.inst[inst].ring_enc[0];
> -	ring->use_doorbell = true;
> -	if (amdgpu_sriov_vf(adev))
> -		ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + inst * (adev->vcn.num_enc_rings + 1) + 1;
> -	else
> -		ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 2 + 8 * inst;
> -	ring->vm_hub = AMDGPU_MMHUB0(0);
> -	sprintf(ring->name, "vcn_unified_%d", inst);
> +		/* VCN UNIFIED TRAP */
> +		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[i],
> +				VCN_4_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst[i].irq);
> +		if (r)
> +			return r;
>   
> -	r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[inst].irq, 0,
> -					AMDGPU_RING_PRIO_0, &adev->vcn.inst[inst].sched_score);
> -	if (r)
> -		return r;
> +		/* VCN POISON TRAP */
> +		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[i],
> +				VCN_4_0__SRCID_UVD_POISON, &adev->vcn.inst[i].ras_poison_irq);
> +		if (r)
> +			return r;
>   
> -	vcn_v4_0_fw_shared_init(adev, inst);
> +		ring = &adev->vcn.inst[i].ring_enc[0];
> +		ring->use_doorbell = true;
> +		if (amdgpu_sriov_vf(adev))
> +			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + i * (adev->vcn.num_enc_rings + 1) + 1;
> +		else
> +			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 2 + 8 * i;
> +		ring->vm_hub = AMDGPU_MMHUB0(0);
> +		sprintf(ring->name, "vcn_unified_%d", i);
> +
> +		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[i].irq, 0,
> +						AMDGPU_RING_PRIO_0, &adev->vcn.inst[i].sched_score);
> +		if (r)
> +			return r;
>   
> -	/* TODO: Add queue reset mask when FW fully supports it */
> -	adev->sdma.supported_reset =
> -		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
> +		vcn_v4_0_fw_shared_init(adev, i);
> +	}
>   
> -done:
>   	if (amdgpu_sriov_vf(adev)) {
>   		r = amdgpu_virt_alloc_mm_table(adev);
>   		if (r)
> @@ -242,18 +239,12 @@ static int vcn_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
>   		return r;
>   
>   	/* Allocate memory for VCN IP Dump buffer */
> -	ptr = kcalloc(reg_count, sizeof(uint32_t), GFP_KERNEL);
> +	ptr = kcalloc(adev->vcn.num_vcn_inst * reg_count, sizeof(uint32_t), GFP_KERNEL);
>   	if (!ptr) {
>   		DRM_ERROR("Failed to allocate memory for VCN IP Dump\n");
> -		ip_block->ip_dump = NULL;
> +		adev->vcn.ip_dump = NULL;
>   	} else {
> -		ip_block->ip_dump = ptr;
> -	}
> -
> -	if (inst == 0) {
> -		r = amdgpu_vcn_sysfs_reset_mask_init(adev);
> -		if (r)
> -			return r;
> +		adev->vcn.ip_dump = ptr;
>   	}
>   
>   	return 0;
> @@ -269,33 +260,33 @@ static int vcn_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
>   static int vcn_v4_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int inst = ip_block->instance;
> -	int r, idx;
> +	int i, r, idx;
>   
>   	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> -		volatile struct amdgpu_vcn4_fw_shared *fw_shared;
> +		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +			volatile struct amdgpu_vcn4_fw_shared *fw_shared;
> +
> +			if (adev->vcn.harvest_config & (1 << i))
> +				continue;
>   
> -		if (adev->vcn.harvest_config & (1 << inst))
> -			goto done;
> +			fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
> +			fw_shared->present_flag_0 = 0;
> +			fw_shared->sq.is_enabled = 0;
> +		}
>   
> -		fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
> -		fw_shared->present_flag_0 = 0;
> -		fw_shared->sq.is_enabled = 0;
> -	done:
>   		drm_dev_exit(idx);
>   	}
>   
>   	if (amdgpu_sriov_vf(adev))
>   		amdgpu_virt_free_mm_table(adev);
>   
> -	r = amdgpu_vcn_suspend(adev, inst);
> +	r = amdgpu_vcn_suspend(adev);
>   	if (r)
>   		return r;
>   
> -	amdgpu_vcn_sysfs_reset_mask_fini(adev);
> -	r = amdgpu_vcn_sw_fini(adev, inst);
> +	r = amdgpu_vcn_sw_fini(adev);
>   
> -	kfree(ip_block->ip_dump);
> +	kfree(adev->vcn.ip_dump);
>   
>   	return r;
>   }
> @@ -311,34 +302,37 @@ static int vcn_v4_0_hw_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
>   	struct amdgpu_ring *ring;
> -	int inst = ip_block->instance;
> -	int r;
> +	int i, r;
>   
>   	if (amdgpu_sriov_vf(adev)) {
>   		r = vcn_v4_0_start_sriov(adev);
>   		if (r)
>   			return r;
>   
> -		if (adev->vcn.harvest_config & (1 << inst))
> -			return 0;
> +		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +			if (adev->vcn.harvest_config & (1 << i))
> +				continue;
>   
> -		ring = &adev->vcn.inst[inst].ring_enc[0];
> -		ring->wptr = 0;
> -		ring->wptr_old = 0;
> -		vcn_v4_0_unified_ring_set_wptr(ring);
> -		ring->sched.ready = true;
> +			ring = &adev->vcn.inst[i].ring_enc[0];
> +			ring->wptr = 0;
> +			ring->wptr_old = 0;
> +			vcn_v4_0_unified_ring_set_wptr(ring);
> +			ring->sched.ready = true;
> +		}
>   	} else {
> -		if (adev->vcn.harvest_config & (1 << inst))
> -			return 0;
> +		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +			if (adev->vcn.harvest_config & (1 << i))
> +				continue;
>   
> -		ring = &adev->vcn.inst[inst].ring_enc[0];
> +			ring = &adev->vcn.inst[i].ring_enc[0];
>   
> -		adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
> -				((adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 8 * inst), inst);
> +			adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
> +					((adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 8 * i), i);
>   
> -		r = amdgpu_ring_test_helper(ring);
> -		if (r)
> -			return r;
> +			r = amdgpu_ring_test_helper(ring);
> +			if (r)
> +				return r;
> +		}
>   	}
>   
>   	return 0;
> @@ -354,24 +348,24 @@ static int vcn_v4_0_hw_init(struct amdgpu_ip_block *ip_block)
>   static int vcn_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int inst = ip_block->instance;
> -
> -	cancel_delayed_work_sync(&adev->vcn.inst[inst].idle_work);
> +	int i;
>   
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		return 0;
> +	cancel_delayed_work_sync(&adev->vcn.idle_work);
>   
> -	if (!amdgpu_sriov_vf(adev)) {
> -		if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> -		    (adev->vcn.inst[inst].cur_state != AMD_PG_STATE_GATE &&
> -		     RREG32_SOC15(VCN, inst, regUVD_STATUS))) {
> -			vcn_v4_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
> +		if (!amdgpu_sriov_vf(adev)) {
> +			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> +				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> +				 RREG32_SOC15(VCN, i, regUVD_STATUS))) {
> +				vcn_v4_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
> +			}
>   		}
> +		if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
> +			amdgpu_irq_put(adev, &adev->vcn.inst[i].ras_poison_irq, 0);
>   	}
>   
> -	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
> -		amdgpu_irq_put(adev, &adev->vcn.inst[inst].ras_poison_irq, 0);
> -
>   	return 0;
>   }
>   
> @@ -384,15 +378,13 @@ static int vcn_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
>    */
>   static int vcn_v4_0_suspend(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = ip_block->adev;
> -	int inst = ip_block->instance;
>   	int r;
>   
>   	r = vcn_v4_0_hw_fini(ip_block);
>   	if (r)
>   		return r;
>   
> -	r = amdgpu_vcn_suspend(adev, inst);
> +	r = amdgpu_vcn_suspend(ip_block->adev);
>   
>   	return r;
>   }
> @@ -408,7 +400,7 @@ static int vcn_v4_0_resume(struct amdgpu_ip_block *ip_block)
>   {
>   	int r;
>   
> -	r = amdgpu_vcn_resume(ip_block->adev, ip_block->instance);
> +	r = amdgpu_vcn_resume(ip_block->adev);
>   	if (r)
>   		return r;
>   
> @@ -1086,179 +1078,182 @@ static int vcn_v4_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
>    * vcn_v4_0_start - VCN start
>    *
>    * @adev: amdgpu_device pointer
> - * @inst: VCN instance index to be started
>    *
>    * Start VCN block
>    */
> -static int vcn_v4_0_start(struct amdgpu_device *adev, unsigned int inst)
> +static int vcn_v4_0_start(struct amdgpu_device *adev)
>   {
>   	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
>   	struct amdgpu_ring *ring;
>   	uint32_t tmp;
> -	int j, k, r;
> +	int i, j, k, r;
>   
> -	if (adev->pm.dpm_enabled)
> -		amdgpu_dpm_enable_vcn(adev, true, inst);
> -
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		return 0;
> -
> -	fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
> -
> -	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> -		r = vcn_v4_0_start_dpg_mode(adev, inst, adev->vcn.indirect_sram);
> -		return r;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->pm.dpm_enabled)
> +			amdgpu_dpm_enable_vcn(adev, true, i);
>   	}
>   
> -	/* disable VCN power gating */
> -	vcn_v4_0_disable_static_power_gating(adev, inst);
> -
> -	/* set VCN status busy */
> -	tmp = RREG32_SOC15(VCN, inst, regUVD_STATUS) | UVD_STATUS__UVD_BUSY;
> -	WREG32_SOC15(VCN, inst, regUVD_STATUS, tmp);
> -
> -	/*SW clock gating */
> -	vcn_v4_0_disable_clock_gating(adev, inst);
> -
> -	/* enable VCPU clock */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_VCPU_CNTL),
> -			UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
> -
> -	/* disable master interrupt */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_MASTINT_EN), 0,
> -			~UVD_MASTINT_EN__VCPU_EN_MASK);
> -
> -	/* enable LMI MC and UMC channels */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_LMI_CTRL2), 0,
> -			~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
> -
> -	tmp = RREG32_SOC15(VCN, inst, regUVD_SOFT_RESET);
> -	tmp &= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> -	tmp &= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> -	WREG32_SOC15(VCN, inst, regUVD_SOFT_RESET, tmp);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
>   
> -	/* setup regUVD_LMI_CTRL */
> -	tmp = RREG32_SOC15(VCN, inst, regUVD_LMI_CTRL);
> -	WREG32_SOC15(VCN, inst, regUVD_LMI_CTRL, tmp |
> -			UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
> -			UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
> -			UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
> -			UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
> -
> -	/* setup regUVD_MPC_CNTL */
> -	tmp = RREG32_SOC15(VCN, inst, regUVD_MPC_CNTL);
> -	tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
> -	tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
> -	WREG32_SOC15(VCN, inst, regUVD_MPC_CNTL, tmp);
> -
> -	/* setup UVD_MPC_SET_MUXA0 */
> -	WREG32_SOC15(VCN, inst, regUVD_MPC_SET_MUXA0,
> -			((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
> -			 (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
> -			 (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
> -			 (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
> -
> -	/* setup UVD_MPC_SET_MUXB0 */
> -	WREG32_SOC15(VCN, inst, regUVD_MPC_SET_MUXB0,
> -			((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
> -			 (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
> -			 (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
> -			 (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
> -
> -	/* setup UVD_MPC_SET_MUX */
> -	WREG32_SOC15(VCN, inst, regUVD_MPC_SET_MUX,
> -			((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
> -			 (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
> -			 (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
> -
> -	vcn_v4_0_mc_resume(adev, inst);
> +		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
>   
> -	/* VCN global tiling registers */
> -	WREG32_SOC15(VCN, inst, regUVD_GFX10_ADDR_CONFIG,
> -			adev->gfx.config.gb_addr_config);
> -
> -	/* unblock VCPU register access */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_RB_ARB_CTRL), 0,
> -			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> -
> -	/* release VCPU reset to boot */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_VCPU_CNTL), 0,
> -			~UVD_VCPU_CNTL__BLK_RST_MASK);
> -
> -	for (j = 0; j < 10; ++j) {
> -		uint32_t status;
> -
> -		for (k = 0; k < 100; ++k) {
> -			status = RREG32_SOC15(VCN, inst, regUVD_STATUS);
> -			if (status & 2)
> -				break;
> -			mdelay(10);
> -			if (amdgpu_emu_mode == 1)
> -				msleep(1);
> +		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> +			r = vcn_v4_0_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
> +			continue;
>   		}
>   
> -		if (amdgpu_emu_mode == 1) {
> -			r = -1;
> -			if (status & 2) {
> -				r = 0;
> -				break;
> +		/* disable VCN power gating */
> +		vcn_v4_0_disable_static_power_gating(adev, i);
> +
> +		/* set VCN status busy */
> +		tmp = RREG32_SOC15(VCN, i, regUVD_STATUS) | UVD_STATUS__UVD_BUSY;
> +		WREG32_SOC15(VCN, i, regUVD_STATUS, tmp);
> +
> +		/*SW clock gating */
> +		vcn_v4_0_disable_clock_gating(adev, i);
> +
> +		/* enable VCPU clock */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
> +				UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
> +
> +		/* disable master interrupt */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_MASTINT_EN), 0,
> +				~UVD_MASTINT_EN__VCPU_EN_MASK);
> +
> +		/* enable LMI MC and UMC channels */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_LMI_CTRL2), 0,
> +				~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
> +
> +		tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
> +		tmp &= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> +		tmp &= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> +		WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
> +
> +		/* setup regUVD_LMI_CTRL */
> +		tmp = RREG32_SOC15(VCN, i, regUVD_LMI_CTRL);
> +		WREG32_SOC15(VCN, i, regUVD_LMI_CTRL, tmp |
> +				UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
> +				UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
> +				UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
> +				UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
> +
> +		/* setup regUVD_MPC_CNTL */
> +		tmp = RREG32_SOC15(VCN, i, regUVD_MPC_CNTL);
> +		tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
> +		tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
> +		WREG32_SOC15(VCN, i, regUVD_MPC_CNTL, tmp);
> +
> +		/* setup UVD_MPC_SET_MUXA0 */
> +		WREG32_SOC15(VCN, i, regUVD_MPC_SET_MUXA0,
> +				((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
> +				 (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
> +				 (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
> +				 (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
> +
> +		/* setup UVD_MPC_SET_MUXB0 */
> +		WREG32_SOC15(VCN, i, regUVD_MPC_SET_MUXB0,
> +				((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
> +				 (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
> +				 (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
> +				 (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
> +
> +		/* setup UVD_MPC_SET_MUX */
> +		WREG32_SOC15(VCN, i, regUVD_MPC_SET_MUX,
> +				((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
> +				 (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
> +				 (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
> +
> +		vcn_v4_0_mc_resume(adev, i);
> +
> +		/* VCN global tiling registers */
> +		WREG32_SOC15(VCN, i, regUVD_GFX10_ADDR_CONFIG,
> +				adev->gfx.config.gb_addr_config);
> +
> +		/* unblock VCPU register access */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_RB_ARB_CTRL), 0,
> +				~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> +
> +		/* release VCPU reset to boot */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
> +				~UVD_VCPU_CNTL__BLK_RST_MASK);
> +
> +		for (j = 0; j < 10; ++j) {
> +			uint32_t status;
> +
> +			for (k = 0; k < 100; ++k) {
> +				status = RREG32_SOC15(VCN, i, regUVD_STATUS);
> +				if (status & 2)
> +					break;
> +				mdelay(10);
> +				if (amdgpu_emu_mode == 1)
> +					msleep(1);
>   			}
> -		} else {
> -			r = 0;
> -			if (status & 2)
> -				break;
>   
> -			dev_err(adev->dev, "VCN[%d] is not responding, trying to reset the VCPU!!!\n", inst);
> -			WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_VCPU_CNTL),
> -						UVD_VCPU_CNTL__BLK_RST_MASK,
> +			if (amdgpu_emu_mode == 1) {
> +				r = -1;
> +				if (status & 2) {
> +					r = 0;
> +					break;
> +				}
> +			} else {
> +				r = 0;
> +				if (status & 2)
> +					break;
> +
> +				dev_err(adev->dev, "VCN[%d] is not responding, trying to reset the VCPU!!!\n", i);
> +				WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
> +							UVD_VCPU_CNTL__BLK_RST_MASK,
> +							~UVD_VCPU_CNTL__BLK_RST_MASK);
> +				mdelay(10);
> +				WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
>   						~UVD_VCPU_CNTL__BLK_RST_MASK);
> -			mdelay(10);
> -			WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_VCPU_CNTL), 0,
> -					~UVD_VCPU_CNTL__BLK_RST_MASK);
>   
> -			mdelay(10);
> -			r = -1;
> +				mdelay(10);
> +				r = -1;
> +			}
>   		}
> -	}
> -
> -	if (r) {
> -		dev_err(adev->dev, "VCN[%d] is not responding, giving up!!!\n", inst);
> -		return r;
> -	}
> -
> -	/* enable master interrupt */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_MASTINT_EN),
> -			UVD_MASTINT_EN__VCPU_EN_MASK,
> -			~UVD_MASTINT_EN__VCPU_EN_MASK);
> -
> -	/* clear the busy bit of VCN_STATUS */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_STATUS), 0,
> -			~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
>   
> -	ring = &adev->vcn.inst[inst].ring_enc[0];
> -	WREG32_SOC15(VCN, inst, regVCN_RB1_DB_CTRL,
> -			ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
> -			VCN_RB1_DB_CTRL__EN_MASK);
> -
> -	WREG32_SOC15(VCN, inst, regUVD_RB_BASE_LO, ring->gpu_addr);
> -	WREG32_SOC15(VCN, inst, regUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
> -	WREG32_SOC15(VCN, inst, regUVD_RB_SIZE, ring->ring_size / 4);
> -
> -	tmp = RREG32_SOC15(VCN, inst, regVCN_RB_ENABLE);
> -	tmp &= ~(VCN_RB_ENABLE__RB1_EN_MASK);
> -	WREG32_SOC15(VCN, inst, regVCN_RB_ENABLE, tmp);
> -	fw_shared->sq.queue_mode |= FW_QUEUE_RING_RESET;
> -	WREG32_SOC15(VCN, inst, regUVD_RB_RPTR, 0);
> -	WREG32_SOC15(VCN, inst, regUVD_RB_WPTR, 0);
> -
> -	tmp = RREG32_SOC15(VCN, inst, regUVD_RB_RPTR);
> -	WREG32_SOC15(VCN, inst, regUVD_RB_WPTR, tmp);
> -	ring->wptr = RREG32_SOC15(VCN, inst, regUVD_RB_WPTR);
> +		if (r) {
> +			dev_err(adev->dev, "VCN[%d] is not responding, giving up!!!\n", i);
> +			return r;
> +		}
>   
> -	tmp = RREG32_SOC15(VCN, inst, regVCN_RB_ENABLE);
> -	tmp |= VCN_RB_ENABLE__RB1_EN_MASK;
> -	WREG32_SOC15(VCN, inst, regVCN_RB_ENABLE, tmp);
> -	fw_shared->sq.queue_mode &= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
> +		/* enable master interrupt */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_MASTINT_EN),
> +				UVD_MASTINT_EN__VCPU_EN_MASK,
> +				~UVD_MASTINT_EN__VCPU_EN_MASK);
> +
> +		/* clear the busy bit of VCN_STATUS */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_STATUS), 0,
> +				~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
> +
> +		ring = &adev->vcn.inst[i].ring_enc[0];
> +		WREG32_SOC15(VCN, i, regVCN_RB1_DB_CTRL,
> +				ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
> +				VCN_RB1_DB_CTRL__EN_MASK);
> +
> +		WREG32_SOC15(VCN, i, regUVD_RB_BASE_LO, ring->gpu_addr);
> +		WREG32_SOC15(VCN, i, regUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
> +		WREG32_SOC15(VCN, i, regUVD_RB_SIZE, ring->ring_size / 4);
> +
> +		tmp = RREG32_SOC15(VCN, i, regVCN_RB_ENABLE);
> +		tmp &= ~(VCN_RB_ENABLE__RB1_EN_MASK);
> +		WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
> +		fw_shared->sq.queue_mode |= FW_QUEUE_RING_RESET;
> +		WREG32_SOC15(VCN, i, regUVD_RB_RPTR, 0);
> +		WREG32_SOC15(VCN, i, regUVD_RB_WPTR, 0);
> +
> +		tmp = RREG32_SOC15(VCN, i, regUVD_RB_RPTR);
> +		WREG32_SOC15(VCN, i, regUVD_RB_WPTR, tmp);
> +		ring->wptr = RREG32_SOC15(VCN, i, regUVD_RB_WPTR);
> +
> +		tmp = RREG32_SOC15(VCN, i, regVCN_RB_ENABLE);
> +		tmp |= VCN_RB_ENABLE__RB1_EN_MASK;
> +		WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
> +		fw_shared->sq.queue_mode &= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
> +	}
>   
>   	return 0;
>   }
> @@ -1545,83 +1540,86 @@ static void vcn_v4_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
>    * vcn_v4_0_stop - VCN stop
>    *
>    * @adev: amdgpu_device pointer
> - * @inst: VCN instance index to be stopped
>    *
>    * Stop VCN block
>    */
> -static int vcn_v4_0_stop(struct amdgpu_device *adev, unsigned int inst)
> +static int vcn_v4_0_stop(struct amdgpu_device *adev)
>   {
>   	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
>   	uint32_t tmp;
> -	int r = 0;
> +	int i, r = 0;
>   
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		goto done;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
>   
> -	fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
> -	fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
> +		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
> +		fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
>   
> -	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> -		vcn_v4_0_stop_dpg_mode(adev, inst);
> -		goto done;
> -	}
> +		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> +			vcn_v4_0_stop_dpg_mode(adev, i);
> +			continue;
> +		}
>   
> -	/* wait for vcn idle */
> -	r = SOC15_WAIT_ON_RREG(VCN, inst, regUVD_STATUS, UVD_STATUS__IDLE, 0x7);
> -	if (r)
> -		return r;
> +		/* wait for vcn idle */
> +		r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_STATUS, UVD_STATUS__IDLE, 0x7);
> +		if (r)
> +			return r;
>   
> -	tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
> -		UVD_LMI_STATUS__READ_CLEAN_MASK |
> -		UVD_LMI_STATUS__WRITE_CLEAN_MASK |
> -		UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
> -	r = SOC15_WAIT_ON_RREG(VCN, inst, regUVD_LMI_STATUS, tmp, tmp);
> -	if (r)
> -		return r;
> +		tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
> +			UVD_LMI_STATUS__READ_CLEAN_MASK |
> +			UVD_LMI_STATUS__WRITE_CLEAN_MASK |
> +			UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
> +		r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_LMI_STATUS, tmp, tmp);
> +		if (r)
> +			return r;
>   
> -	/* disable LMI UMC channel */
> -	tmp = RREG32_SOC15(VCN, inst, regUVD_LMI_CTRL2);
> -	tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
> -	WREG32_SOC15(VCN, inst, regUVD_LMI_CTRL2, tmp);
> -	tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK |
> -		UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
> -	r = SOC15_WAIT_ON_RREG(VCN, inst, regUVD_LMI_STATUS, tmp, tmp);
> -	if (r)
> -		return r;
> +		/* disable LMI UMC channel */
> +		tmp = RREG32_SOC15(VCN, i, regUVD_LMI_CTRL2);
> +		tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
> +		WREG32_SOC15(VCN, i, regUVD_LMI_CTRL2, tmp);
> +		tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK |
> +			UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
> +		r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_LMI_STATUS, tmp, tmp);
> +		if (r)
> +			return r;
>   
> -	/* block VCPU register access */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_RB_ARB_CTRL),
> -			UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
> -			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> +		/* block VCPU register access */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_RB_ARB_CTRL),
> +				UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
> +				~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
>   
> -	/* reset VCPU */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_VCPU_CNTL),
> -			UVD_VCPU_CNTL__BLK_RST_MASK,
> -			~UVD_VCPU_CNTL__BLK_RST_MASK);
> +		/* reset VCPU */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
> +				UVD_VCPU_CNTL__BLK_RST_MASK,
> +				~UVD_VCPU_CNTL__BLK_RST_MASK);
>   
> -	/* disable VCPU clock */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_VCPU_CNTL), 0,
> -			~(UVD_VCPU_CNTL__CLK_EN_MASK));
> +		/* disable VCPU clock */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
> +				~(UVD_VCPU_CNTL__CLK_EN_MASK));
>   
> -	/* apply soft reset */
> -	tmp = RREG32_SOC15(VCN, inst, regUVD_SOFT_RESET);
> -	tmp |= UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> -	WREG32_SOC15(VCN, inst, regUVD_SOFT_RESET, tmp);
> -	tmp = RREG32_SOC15(VCN, inst, regUVD_SOFT_RESET);
> -	tmp |= UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> -	WREG32_SOC15(VCN, inst, regUVD_SOFT_RESET, tmp);
> +		/* apply soft reset */
> +		tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
> +		tmp |= UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> +		WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
> +		tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
> +		tmp |= UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> +		WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
>   
> -	/* clear status */
> -	WREG32_SOC15(VCN, inst, regUVD_STATUS, 0);
> +		/* clear status */
> +		WREG32_SOC15(VCN, i, regUVD_STATUS, 0);
>   
> -	/* apply HW clock gating */
> -	vcn_v4_0_enable_clock_gating(adev, inst);
> +		/* apply HW clock gating */
> +		vcn_v4_0_enable_clock_gating(adev, i);
>   
> -	/* enable VCN power gating */
> -	vcn_v4_0_enable_static_power_gating(adev, inst);
> -done:
> -	if (adev->pm.dpm_enabled)
> -		amdgpu_dpm_enable_vcn(adev, false, inst);
> +		/* enable VCN power gating */
> +		vcn_v4_0_enable_static_power_gating(adev, i);
> +	}
> +
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->pm.dpm_enabled)
> +			amdgpu_dpm_enable_vcn(adev, false, i);
> +	}
>   
>   	return 0;
>   }
> @@ -1941,21 +1939,24 @@ static struct amdgpu_ring_funcs vcn_v4_0_unified_ring_vm_funcs = {
>    * vcn_v4_0_set_unified_ring_funcs - set unified ring functions
>    *
>    * @adev: amdgpu_device pointer
> - * @inst: instance of the VCN block for which to set the ring functions
>    *
>    * Set unified ring functions
>    */
> -static void vcn_v4_0_set_unified_ring_funcs(struct amdgpu_device *adev, int inst)
> +static void vcn_v4_0_set_unified_ring_funcs(struct amdgpu_device *adev)
>   {
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		return;
> +	int i;
>   
> -	if (amdgpu_ip_version(adev, VCN_HWIP, 0) == IP_VERSION(4, 0, 2))
> -		vcn_v4_0_unified_ring_vm_funcs.secure_submission_supported = true;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
>   
> -	adev->vcn.inst[inst].ring_enc[0].funcs =
> -		   (const struct amdgpu_ring_funcs *)&vcn_v4_0_unified_ring_vm_funcs;
> -	adev->vcn.inst[inst].ring_enc[0].me = inst;
> +		if (amdgpu_ip_version(adev, VCN_HWIP, 0) == IP_VERSION(4, 0, 2))
> +			vcn_v4_0_unified_ring_vm_funcs.secure_submission_supported = true;
> +
> +		adev->vcn.inst[i].ring_enc[0].funcs =
> +		       (const struct amdgpu_ring_funcs *)&vcn_v4_0_unified_ring_vm_funcs;
> +		adev->vcn.inst[i].ring_enc[0].me = i;
> +	}
>   }
>   
>   /**
> @@ -1990,14 +1991,17 @@ static bool vcn_v4_0_is_idle(void *handle)
>   static int vcn_v4_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int inst = ip_block->instance;
> -	int ret;
> +	int i, ret = 0;
>   
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		return 0;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
>   
> -	ret = SOC15_WAIT_ON_RREG(VCN, inst, regUVD_STATUS, UVD_STATUS__IDLE,
> -		UVD_STATUS__IDLE);
> +		ret = SOC15_WAIT_ON_RREG(VCN, i, regUVD_STATUS, UVD_STATUS__IDLE,
> +			UVD_STATUS__IDLE);
> +		if (ret)
> +			return ret;
> +	}
>   
>   	return ret;
>   }
> @@ -2005,7 +2009,7 @@ static int vcn_v4_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v4_0_set_clockgating_state - set VCN block clockgating state
>    *
> - * @ip_block: amdgpu_ip_block pointer
> + * @handle: amdgpu_device pointer
>    * @state: clock gating state
>    *
>    * Set VCN block clockgating state
> @@ -2015,17 +2019,19 @@ static int vcn_v4_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
>   	bool enable = state == AMD_CG_STATE_GATE;
> -	int inst = ip_block->instance;
> +	int i;
>   
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		return 0;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
>   
> -	if (enable) {
> -		if (RREG32_SOC15(VCN, inst, regUVD_STATUS) != UVD_STATUS__IDLE)
> -			return -EBUSY;
> -		vcn_v4_0_enable_clock_gating(adev, inst);
> -	} else {
> -		vcn_v4_0_disable_clock_gating(adev, inst);
> +		if (enable) {
> +			if (RREG32_SOC15(VCN, i, regUVD_STATUS) != UVD_STATUS__IDLE)
> +				return -EBUSY;
> +			vcn_v4_0_enable_clock_gating(adev, i);
> +		} else {
> +			vcn_v4_0_disable_clock_gating(adev, i);
> +		}
>   	}
>   
>   	return 0;
> @@ -2034,7 +2040,7 @@ static int vcn_v4_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   /**
>    * vcn_v4_0_set_powergating_state - set VCN block powergating state
>    *
> - * @ip_block: amdgpu_ip_block pointer
> + * @handle: amdgpu_device pointer
>    * @state: power gating state
>    *
>    * Set VCN block powergating state
> @@ -2043,7 +2049,6 @@ static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int inst = ip_block->instance;
>   	int ret;
>   
>   	/* for SRIOV, guest should not control VCN Power-gating
> @@ -2051,20 +2056,20 @@ static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   	 * guest should avoid touching CGC and PG
>   	 */
>   	if (amdgpu_sriov_vf(adev)) {
> -		adev->vcn.inst[inst].cur_state = AMD_PG_STATE_UNGATE;
> +		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
>   		return 0;
>   	}
>   
> -	if (state == adev->vcn.inst[inst].cur_state)
> +	if (state == adev->vcn.cur_state)
>   		return 0;
>   
>   	if (state == AMD_PG_STATE_GATE)
> -		ret = vcn_v4_0_stop(adev, inst);
> +		ret = vcn_v4_0_stop(adev);
>   	else
> -		ret = vcn_v4_0_start(adev, inst);
> +		ret = vcn_v4_0_start(adev);
>   
>   	if (!ret)
> -		adev->vcn.inst[inst].cur_state = state;
> +		adev->vcn.cur_state = state;
>   
>   	return ret;
>   }
> @@ -2145,77 +2150,84 @@ static const struct amdgpu_irq_src_funcs vcn_v4_0_ras_irq_funcs = {
>    * vcn_v4_0_set_irq_funcs - set VCN block interrupt irq functions
>    *
>    * @adev: amdgpu_device pointer
> - * @inst: instance of the VCN block for which to set the IRQ functions
>    *
>    * Set VCN block interrupt irq functions
>    */
> -static void vcn_v4_0_set_irq_funcs(struct amdgpu_device *adev, int inst)
> +static void vcn_v4_0_set_irq_funcs(struct amdgpu_device *adev)
>   {
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		return;
> +	int i;
>   
> -	adev->vcn.inst[inst].irq.num_types = adev->vcn.num_enc_rings + 1;
> -	adev->vcn.inst[inst].irq.funcs = &vcn_v4_0_irq_funcs;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
> +
> +		adev->vcn.inst[i].irq.num_types = adev->vcn.num_enc_rings + 1;
> +		adev->vcn.inst[i].irq.funcs = &vcn_v4_0_irq_funcs;
>   
> -	adev->vcn.inst[inst].ras_poison_irq.num_types = adev->vcn.num_enc_rings + 1;
> -	adev->vcn.inst[inst].ras_poison_irq.funcs = &vcn_v4_0_ras_irq_funcs;
> +		adev->vcn.inst[i].ras_poison_irq.num_types = adev->vcn.num_enc_rings + 1;
> +		adev->vcn.inst[i].ras_poison_irq.funcs = &vcn_v4_0_ras_irq_funcs;
> +	}
>   }
>   
>   static void vcn_v4_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int i;
> +	int i, j;
>   	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0);
> -	uint32_t is_powered;
> -	int inst = ip_block->instance;
> +	uint32_t inst_off, is_powered;
>   
> -	if (!ip_block->ip_dump)
> +	if (!adev->vcn.ip_dump)
>   		return;
>   
> -	drm_printf(p, "Instance no:VCN%d\n", inst);
> -
> -	if (adev->vcn.harvest_config & (1 << inst)) {
> -		drm_printf(p, "\nHarvested Instance:VCN%d Skipping dump\n", inst);
> -		return;
> -	}
> +	drm_printf(p, "num_instances:%d\n", adev->vcn.num_vcn_inst);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		if (adev->vcn.harvest_config & (1 << i)) {
> +			drm_printf(p, "\nHarvested Instance:VCN%d Skipping dump\n", i);
> +			continue;
> +		}
>   
> -	is_powered = (ip_block->ip_dump[0] &
> -		      UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
> +		inst_off = i * reg_count;
> +		is_powered = (adev->vcn.ip_dump[inst_off] &
> +				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
>   
> -	if (is_powered) {
> -		drm_printf(p, "\nActive Instance:VCN%d\n", inst);
> -		for (i = 0; i < reg_count; i++)
> -			drm_printf(p, "%-50s \t 0x%08x\n",
> -				   vcn_reg_list_4_0[i].reg_name,
> -				   ip_block->ip_dump[i]);
> -	} else {
> -		drm_printf(p, "\nInactive Instance:VCN%d\n", inst);
> +		if (is_powered) {
> +			drm_printf(p, "\nActive Instance:VCN%d\n", i);
> +			for (j = 0; j < reg_count; j++)
> +				drm_printf(p, "%-50s \t 0x%08x\n", vcn_reg_list_4_0[j].reg_name,
> +					   adev->vcn.ip_dump[inst_off + j]);
> +		} else {
> +			drm_printf(p, "\nInactive Instance:VCN%d\n", i);
> +		}
>   	}
>   }
>   
>   static void vcn_v4_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int i;
> +	int i, j;
>   	bool is_powered;
> +	uint32_t inst_off;
>   	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0);
> -	int inst = ip_block->instance;
> -
> -	if (!ip_block->ip_dump)
> -		return;
>   
> -	if (adev->vcn.harvest_config & (1 << inst))
> +	if (!adev->vcn.ip_dump)
>   		return;
>   
> -	/* mmUVD_POWER_STATUS is always readable and is first element of the array */
> -	ip_block->ip_dump[0] = RREG32_SOC15(VCN, inst, regUVD_POWER_STATUS);
> -	is_powered = (ip_block->ip_dump[0] &
> -		      UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
>   
> -	if (is_powered)
> -		for (i = 1; i < reg_count; i++)
> -			ip_block->ip_dump[i] =
> -				RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_4_0[i], inst));
> +		inst_off = i * reg_count;
> +		/* mmUVD_POWER_STATUS is always readable and is first element of the array */
> +		adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, regUVD_POWER_STATUS);
> +		is_powered = (adev->vcn.ip_dump[inst_off] &
> +				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
> +
> +		if (is_powered)
> +			for (j = 1; j < reg_count; j++)
> +				adev->vcn.ip_dump[inst_off + j] =
> +					RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_4_0[j],
> +									   i));
> +	}
>   }
>   
>   static const struct amd_ip_funcs vcn_v4_0_ip_funcs = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index 88cbf1a88a07..5edbd60c1675 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -85,8 +85,8 @@ static const struct amdgpu_hwip_reg_entry vcn_reg_list_4_0_3[] = {
>   		(offset & 0x1FFFF)
>   
>   static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev);
> -static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device *adev, int inst);
> -static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev, int inst);
> +static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device *adev);
> +static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev);
>   static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   		enum amd_powergating_state state);
>   static int vcn_v4_0_3_pause_dpg_mode(struct amdgpu_device *adev,
> @@ -112,16 +112,15 @@ static inline bool vcn_v4_0_3_normalizn_reqd(struct amdgpu_device *adev)
>   static int vcn_v4_0_3_early_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int inst = ip_block->instance;
>   
>   	/* re-use enc ring as unified ring */
>   	adev->vcn.num_enc_rings = 1;
>   
> -	vcn_v4_0_3_set_unified_ring_funcs(adev, inst);
> -	vcn_v4_0_3_set_irq_funcs(adev, inst);
> +	vcn_v4_0_3_set_unified_ring_funcs(adev);
> +	vcn_v4_0_3_set_irq_funcs(adev);
>   	vcn_v4_0_3_set_ras_funcs(adev);
>   
> -	return amdgpu_vcn_early_init(adev, inst);
> +	return amdgpu_vcn_early_init(adev);
>   }
>   
>   /**
> @@ -134,19 +133,18 @@ static int vcn_v4_0_3_early_init(struct amdgpu_ip_block *ip_block)
>   static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int inst = ip_block->instance;
>   	struct amdgpu_ring *ring;
> -	int r, vcn_inst;
> +	int i, r, vcn_inst;
>   	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_3);
>   	uint32_t *ptr;
>   
> -	r = amdgpu_vcn_sw_init(adev, inst);
> +	r = amdgpu_vcn_sw_init(adev);
>   	if (r)
>   		return r;
>   
> -	amdgpu_vcn_setup_ucode(adev, inst);
> +	amdgpu_vcn_setup_ucode(adev);
>   
> -	r = amdgpu_vcn_resume(adev, inst);
> +	r = amdgpu_vcn_resume(adev);
>   	if (r)
>   		return r;
>   
> @@ -156,40 +154,38 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
>   	if (r)
>   		return r;
>   
> -	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		volatile struct amdgpu_vcn4_fw_shared *fw_shared;
>   
> -	vcn_inst = GET_INST(VCN, inst);
> +		vcn_inst = GET_INST(VCN, i);
>   
> -	ring = &adev->vcn.inst[inst].ring_enc[0];
> -	ring->use_doorbell = true;
> +		ring = &adev->vcn.inst[i].ring_enc[0];
> +		ring->use_doorbell = true;
>   
> -	if (!amdgpu_sriov_vf(adev))
> -		ring->doorbell_index =
> -			(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
> -			9 * vcn_inst;
> -	else
> -		ring->doorbell_index =
> -			(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
> -			32 * vcn_inst;
> -
> -	ring->vm_hub = AMDGPU_MMHUB0(adev->vcn.inst[inst].aid_id);
> -	sprintf(ring->name, "vcn_unified_%d", adev->vcn.inst[inst].aid_id);
> -	r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0,
> -				 AMDGPU_RING_PRIO_DEFAULT,
> -				 &adev->vcn.inst[inst].sched_score);
> -	if (r)
> -		return r;
> +		if (!amdgpu_sriov_vf(adev))
> +			ring->doorbell_index =
> +				(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
> +				9 * vcn_inst;
> +		else
> +			ring->doorbell_index =
> +				(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
> +				32 * vcn_inst;
>   
> -	fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
> -	fw_shared->present_flag_0 = cpu_to_le32(AMDGPU_FW_SHARED_FLAG_0_UNIFIED_QUEUE);
> -	fw_shared->sq.is_enabled = true;
> +		ring->vm_hub = AMDGPU_MMHUB0(adev->vcn.inst[i].aid_id);
> +		sprintf(ring->name, "vcn_unified_%d", adev->vcn.inst[i].aid_id);
> +		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0,
> +				     AMDGPU_RING_PRIO_DEFAULT,
> +				     &adev->vcn.inst[i].sched_score);
> +		if (r)
> +			return r;
>   
> -	/* TODO: Add queue reset mask when FW fully supports it */
> -	adev->sdma.supported_reset =
> -		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
> +		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
> +		fw_shared->present_flag_0 = cpu_to_le32(AMDGPU_FW_SHARED_FLAG_0_UNIFIED_QUEUE);
> +		fw_shared->sq.is_enabled = true;
>   
> -	if (amdgpu_vcnfw_log)
> -		amdgpu_vcn_fwlog_init(&adev->vcn.inst[inst]);
> +		if (amdgpu_vcnfw_log)
> +			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
> +	}
>   
>   	if (amdgpu_sriov_vf(adev)) {
>   		r = amdgpu_virt_alloc_mm_table(adev);
> @@ -212,15 +208,11 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
>   	ptr = kcalloc(adev->vcn.num_vcn_inst * reg_count, sizeof(uint32_t), GFP_KERNEL);
>   	if (!ptr) {
>   		DRM_ERROR("Failed to allocate memory for VCN IP Dump\n");
> -		ip_block->ip_dump = NULL;
> +		adev->vcn.ip_dump = NULL;
>   	} else {
> -		ip_block->ip_dump = ptr;
> +		adev->vcn.ip_dump = ptr;
>   	}
>   
> -	r = amdgpu_vcn_sysfs_reset_mask_init(adev);
> -	if (r)
> -		return r;
> -
>   	return 0;
>   }
>   
> @@ -234,30 +226,29 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
>   static int vcn_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int inst = ip_block->instance;
> -	int r, idx;
> +	int i, r, idx;
>   
>   	if (drm_dev_enter(&adev->ddev, &idx)) {
> -		volatile struct amdgpu_vcn4_fw_shared *fw_shared;
> -
> -		fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
> -		fw_shared->present_flag_0 = 0;
> -		fw_shared->sq.is_enabled = cpu_to_le32(false);
> +		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +			volatile struct amdgpu_vcn4_fw_shared *fw_shared;
>   
> +			fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
> +			fw_shared->present_flag_0 = 0;
> +			fw_shared->sq.is_enabled = cpu_to_le32(false);
> +		}
>   		drm_dev_exit(idx);
>   	}
>   
>   	if (amdgpu_sriov_vf(adev))
>   		amdgpu_virt_free_mm_table(adev);
>   
> -	r = amdgpu_vcn_suspend(adev, inst);
> +	r = amdgpu_vcn_suspend(adev);
>   	if (r)
>   		return r;
>   
> -	amdgpu_vcn_sysfs_reset_mask_fini(adev);
> -	r = amdgpu_vcn_sw_fini(adev, inst);
> +	r = amdgpu_vcn_sw_fini(adev);
>   
> -	kfree(ip_block->ip_dump);
> +	kfree(adev->vcn.ip_dump);
>   
>   	return r;
>   }
> @@ -273,46 +264,49 @@ static int vcn_v4_0_3_hw_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
>   	struct amdgpu_ring *ring;
> -	int inst = ip_block->instance;
> -	int r = 0, vcn_inst;
> +	int i, r, vcn_inst;
>   
>   	if (amdgpu_sriov_vf(adev)) {
>   		r = vcn_v4_0_3_start_sriov(adev);
>   		if (r)
>   			return r;
>   
> -		ring = &adev->vcn.inst[inst].ring_enc[0];
> -		ring->wptr = 0;
> -		ring->wptr_old = 0;
> -		vcn_v4_0_3_unified_ring_set_wptr(ring);
> -		ring->sched.ready = true;
> +		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +			ring = &adev->vcn.inst[i].ring_enc[0];
> +			ring->wptr = 0;
> +			ring->wptr_old = 0;
> +			vcn_v4_0_3_unified_ring_set_wptr(ring);
> +			ring->sched.ready = true;
> +		}
>   	} else {
> -		vcn_inst = GET_INST(VCN, inst);
> -		ring = &adev->vcn.inst[inst].ring_enc[0];
> +		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +			vcn_inst = GET_INST(VCN, i);
> +			ring = &adev->vcn.inst[i].ring_enc[0];
> +
> +			if (ring->use_doorbell) {
> +				adev->nbio.funcs->vcn_doorbell_range(
> +					adev, ring->use_doorbell,
> +					(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
> +						9 * vcn_inst,
> +					adev->vcn.inst[i].aid_id);
> +
> +				WREG32_SOC15(
> +					VCN, GET_INST(VCN, ring->me),
> +					regVCN_RB1_DB_CTRL,
> +					ring->doorbell_index
> +							<< VCN_RB1_DB_CTRL__OFFSET__SHIFT |
> +						VCN_RB1_DB_CTRL__EN_MASK);
> +
> +				/* Read DB_CTRL to flush the write DB_CTRL command. */
> +				RREG32_SOC15(
> +					VCN, GET_INST(VCN, ring->me),
> +					regVCN_RB1_DB_CTRL);
> +			}
>   
> -		if (ring->use_doorbell) {
> -			adev->nbio.funcs->vcn_doorbell_range(
> -				adev, ring->use_doorbell,
> -				(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
> -					9 * vcn_inst,
> -				adev->vcn.inst[inst].aid_id);
> -
> -			WREG32_SOC15(
> -				VCN, GET_INST(VCN, ring->me),
> -				regVCN_RB1_DB_CTRL,
> -				ring->doorbell_index
> -						<< VCN_RB1_DB_CTRL__OFFSET__SHIFT |
> -					VCN_RB1_DB_CTRL__EN_MASK);
> -
> -			/* Read DB_CTRL to flush the write DB_CTRL command. */
> -			RREG32_SOC15(
> -				VCN, GET_INST(VCN, ring->me),
> -				regVCN_RB1_DB_CTRL);
> +			r = amdgpu_ring_test_helper(ring);
> +			if (r)
> +				return r;
>   		}
> -
> -		r = amdgpu_ring_test_helper(ring);
> -		if (r)
> -			return r;
>   	}
>   
>   	return r;
> @@ -328,11 +322,10 @@ static int vcn_v4_0_3_hw_init(struct amdgpu_ip_block *ip_block)
>   static int vcn_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int inst = ip_block->instance;
>   
> -	cancel_delayed_work_sync(&adev->vcn.inst[inst].idle_work);
> +	cancel_delayed_work_sync(&adev->vcn.idle_work);
>   
> -	if (adev->vcn.inst[inst].cur_state != AMD_PG_STATE_GATE)
> +	if (adev->vcn.cur_state != AMD_PG_STATE_GATE)
>   		vcn_v4_0_3_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
>   
>   	return 0;
> @@ -347,15 +340,13 @@ static int vcn_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
>    */
>   static int vcn_v4_0_3_suspend(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = ip_block->adev;
> -	int inst = ip_block->instance;
>   	int r;
>   
>   	r = vcn_v4_0_3_hw_fini(ip_block);
>   	if (r)
>   		return r;
>   
> -	r = amdgpu_vcn_suspend(adev, inst);
> +	r = amdgpu_vcn_suspend(ip_block->adev);
>   
>   	return r;
>   }
> @@ -371,7 +362,7 @@ static int vcn_v4_0_3_resume(struct amdgpu_ip_block *ip_block)
>   {
>   	int r;
>   
> -	r = amdgpu_vcn_resume(ip_block->adev, ip_block->instance);
> +	r = amdgpu_vcn_resume(ip_block->adev);
>   	if (r)
>   		return r;
>   
> @@ -1097,174 +1088,177 @@ static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev)
>    * vcn_v4_0_3_start - VCN start
>    *
>    * @adev: amdgpu_device pointer
> - * @inst: VCN instance index to be started
>    *
>    * Start VCN block
>    */
> -static int vcn_v4_0_3_start(struct amdgpu_device *adev, unsigned int inst)
> +static int vcn_v4_0_3_start(struct amdgpu_device *adev)
>   {
>   	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
>   	struct amdgpu_ring *ring;
> -	int j, k, r, vcn_inst;
> +	int i, j, k, r, vcn_inst;
>   	uint32_t tmp;
>   
> -	if (adev->pm.dpm_enabled)
> -		amdgpu_dpm_enable_vcn(adev, true, inst);
> -
> -	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> -		r = vcn_v4_0_3_start_dpg_mode(adev, inst, adev->vcn.indirect_sram);
> -		return r;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->pm.dpm_enabled)
> +			amdgpu_dpm_enable_vcn(adev, true, i);
>   	}
>   
> -	vcn_inst = GET_INST(VCN, inst);
> -	/* set VCN status busy */
> -	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS) |
> -		  UVD_STATUS__UVD_BUSY;
> -	WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, tmp);
> -
> -	/*SW clock gating */
> -	vcn_v4_0_3_disable_clock_gating(adev, inst);
> -
> -	/* enable VCPU clock */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL),
> -		 UVD_VCPU_CNTL__CLK_EN_MASK,
> -		 ~UVD_VCPU_CNTL__CLK_EN_MASK);
> -
> -	/* disable master interrupt */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_MASTINT_EN), 0,
> -		 ~UVD_MASTINT_EN__VCPU_EN_MASK);
> -
> -	/* enable LMI MC and UMC channels */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_LMI_CTRL2), 0,
> -		 ~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
> -
> -	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
> -	tmp &= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> -	tmp &= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> -	WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
> -
> -	/* setup regUVD_LMI_CTRL */
> -	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL);
> -	WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL,
> -			 tmp | UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
> -				 UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
> -				 UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
> -				 UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
> -
> -	/* setup regUVD_MPC_CNTL */
> -	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_MPC_CNTL);
> -	tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
> -	tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
> -	WREG32_SOC15(VCN, vcn_inst, regUVD_MPC_CNTL, tmp);
> -
> -	/* setup UVD_MPC_SET_MUXA0 */
> -	WREG32_SOC15(VCN, vcn_inst, regUVD_MPC_SET_MUXA0,
> -			 ((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
> -			  (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
> -			  (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
> -			  (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
> -
> -	/* setup UVD_MPC_SET_MUXB0 */
> -	WREG32_SOC15(VCN, vcn_inst, regUVD_MPC_SET_MUXB0,
> -			 ((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
> -			  (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
> -			  (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
> -			  (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
> -
> -	/* setup UVD_MPC_SET_MUX */
> -	WREG32_SOC15(VCN, vcn_inst, regUVD_MPC_SET_MUX,
> -			 ((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
> -			  (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
> -			  (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
> -
> -	vcn_v4_0_3_mc_resume(adev, inst);
> -
> -	/* VCN global tiling registers */
> -	WREG32_SOC15(VCN, vcn_inst, regUVD_GFX8_ADDR_CONFIG,
> -			 adev->gfx.config.gb_addr_config);
> -	WREG32_SOC15(VCN, vcn_inst, regUVD_GFX10_ADDR_CONFIG,
> -			 adev->gfx.config.gb_addr_config);
> -
> -	/* unblock VCPU register access */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_RB_ARB_CTRL), 0,
> -		 ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> +			r = vcn_v4_0_3_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
> +			continue;
> +		}
>   
> -	/* release VCPU reset to boot */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL), 0,
> -		 ~UVD_VCPU_CNTL__BLK_RST_MASK);
> +		vcn_inst = GET_INST(VCN, i);
> +		/* set VCN status busy */
> +		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS) |
> +		      UVD_STATUS__UVD_BUSY;
> +		WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, tmp);
> +
> +		/*SW clock gating */
> +		vcn_v4_0_3_disable_clock_gating(adev, i);
> +
> +		/* enable VCPU clock */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL),
> +			 UVD_VCPU_CNTL__CLK_EN_MASK,
> +			 ~UVD_VCPU_CNTL__CLK_EN_MASK);
> +
> +		/* disable master interrupt */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_MASTINT_EN), 0,
> +			 ~UVD_MASTINT_EN__VCPU_EN_MASK);
> +
> +		/* enable LMI MC and UMC channels */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_LMI_CTRL2), 0,
> +			 ~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
> +
> +		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
> +		tmp &= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> +		tmp &= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> +		WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
> +
> +		/* setup regUVD_LMI_CTRL */
> +		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL);
> +		WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL,
> +			     tmp | UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
> +				     UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
> +				     UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
> +				     UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
> +
> +		/* setup regUVD_MPC_CNTL */
> +		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_MPC_CNTL);
> +		tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
> +		tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
> +		WREG32_SOC15(VCN, vcn_inst, regUVD_MPC_CNTL, tmp);
> +
> +		/* setup UVD_MPC_SET_MUXA0 */
> +		WREG32_SOC15(VCN, vcn_inst, regUVD_MPC_SET_MUXA0,
> +			     ((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
> +			      (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
> +			      (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
> +			      (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
> +
> +		/* setup UVD_MPC_SET_MUXB0 */
> +		WREG32_SOC15(VCN, vcn_inst, regUVD_MPC_SET_MUXB0,
> +			     ((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
> +			      (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
> +			      (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
> +			      (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
> +
> +		/* setup UVD_MPC_SET_MUX */
> +		WREG32_SOC15(VCN, vcn_inst, regUVD_MPC_SET_MUX,
> +			     ((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
> +			      (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
> +			      (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
> +
> +		vcn_v4_0_3_mc_resume(adev, i);
> +
> +		/* VCN global tiling registers */
> +		WREG32_SOC15(VCN, vcn_inst, regUVD_GFX8_ADDR_CONFIG,
> +			     adev->gfx.config.gb_addr_config);
> +		WREG32_SOC15(VCN, vcn_inst, regUVD_GFX10_ADDR_CONFIG,
> +			     adev->gfx.config.gb_addr_config);
> +
> +		/* unblock VCPU register access */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_RB_ARB_CTRL), 0,
> +			 ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> +
> +		/* release VCPU reset to boot */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL), 0,
> +			 ~UVD_VCPU_CNTL__BLK_RST_MASK);
>   
> -	for (j = 0; j < 10; ++j) {
> -		uint32_t status;
> +		for (j = 0; j < 10; ++j) {
> +			uint32_t status;
>   
> -		for (k = 0; k < 100; ++k) {
> -			status = RREG32_SOC15(VCN, vcn_inst,
> -						  regUVD_STATUS);
> +			for (k = 0; k < 100; ++k) {
> +				status = RREG32_SOC15(VCN, vcn_inst,
> +						      regUVD_STATUS);
> +				if (status & 2)
> +					break;
> +				mdelay(10);
> +			}
> +			r = 0;
>   			if (status & 2)
>   				break;
> -			mdelay(10);
> -		}
> -		r = 0;
> -		if (status & 2)
> -			break;
>   
> -		DRM_DEV_ERROR(adev->dev,
> -			"VCN decode not responding, trying to reset the VCPU!!!\n");
> -		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst,
> -					  regUVD_VCPU_CNTL),
> -			 UVD_VCPU_CNTL__BLK_RST_MASK,
> -			 ~UVD_VCPU_CNTL__BLK_RST_MASK);
> -		mdelay(10);
> -		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst,
> -					  regUVD_VCPU_CNTL),
> -			 0, ~UVD_VCPU_CNTL__BLK_RST_MASK);
> +			DRM_DEV_ERROR(adev->dev,
> +				"VCN decode not responding, trying to reset the VCPU!!!\n");
> +			WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst,
> +						  regUVD_VCPU_CNTL),
> +				 UVD_VCPU_CNTL__BLK_RST_MASK,
> +				 ~UVD_VCPU_CNTL__BLK_RST_MASK);
> +			mdelay(10);
> +			WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst,
> +						  regUVD_VCPU_CNTL),
> +				 0, ~UVD_VCPU_CNTL__BLK_RST_MASK);
>   
> -		mdelay(10);
> -		r = -1;
> -	}
> +			mdelay(10);
> +			r = -1;
> +		}
>   
> -	if (r) {
> -		DRM_DEV_ERROR(adev->dev, "VCN decode not responding, giving up!!!\n");
> -		return r;
> -	}
> +		if (r) {
> +			DRM_DEV_ERROR(adev->dev, "VCN decode not responding, giving up!!!\n");
> +			return r;
> +		}
>   
> -	/* enable master interrupt */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_MASTINT_EN),
> -		 UVD_MASTINT_EN__VCPU_EN_MASK,
> -		 ~UVD_MASTINT_EN__VCPU_EN_MASK);
> +		/* enable master interrupt */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_MASTINT_EN),
> +			 UVD_MASTINT_EN__VCPU_EN_MASK,
> +			 ~UVD_MASTINT_EN__VCPU_EN_MASK);
>   
> -	/* clear the busy bit of VCN_STATUS */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_STATUS), 0,
> -		 ~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
> +		/* clear the busy bit of VCN_STATUS */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_STATUS), 0,
> +			 ~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
>   
> -	ring = &adev->vcn.inst[inst].ring_enc[0];
> -	fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
> +		ring = &adev->vcn.inst[i].ring_enc[0];
> +		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
>   
> -	/* program the RB_BASE for ring buffer */
> -	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_BASE_LO,
> -			 lower_32_bits(ring->gpu_addr));
> -	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_BASE_HI,
> -			 upper_32_bits(ring->gpu_addr));
> +		/* program the RB_BASE for ring buffer */
> +		WREG32_SOC15(VCN, vcn_inst, regUVD_RB_BASE_LO,
> +			     lower_32_bits(ring->gpu_addr));
> +		WREG32_SOC15(VCN, vcn_inst, regUVD_RB_BASE_HI,
> +			     upper_32_bits(ring->gpu_addr));
>   
> -	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_SIZE,
> -			 ring->ring_size / sizeof(uint32_t));
> +		WREG32_SOC15(VCN, vcn_inst, regUVD_RB_SIZE,
> +			     ring->ring_size / sizeof(uint32_t));
>   
> -	/* resetting ring, fw should not check RB ring */
> -	tmp = RREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE);
> -	tmp &= ~(VCN_RB_ENABLE__RB_EN_MASK);
> -	WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
> +		/* resetting ring, fw should not check RB ring */
> +		tmp = RREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE);
> +		tmp &= ~(VCN_RB_ENABLE__RB_EN_MASK);
> +		WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
>   
> -	/* Initialize the ring buffer's read and write pointers */
> -	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_RPTR, 0);
> -	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR, 0);
> +		/* Initialize the ring buffer's read and write pointers */
> +		WREG32_SOC15(VCN, vcn_inst, regUVD_RB_RPTR, 0);
> +		WREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR, 0);
>   
> -	tmp = RREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE);
> -	tmp |= VCN_RB_ENABLE__RB_EN_MASK;
> -	WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
> +		tmp = RREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE);
> +		tmp |= VCN_RB_ENABLE__RB_EN_MASK;
> +		WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
>   
> -	ring->wptr = RREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR);
> -	fw_shared->sq.queue_mode &=
> -		cpu_to_le32(~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF));
> +		ring->wptr = RREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR);
> +		fw_shared->sq.queue_mode &=
> +			cpu_to_le32(~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF));
>   
> +	}
>   	return 0;
>   }
>   
> @@ -1304,83 +1298,86 @@ static int vcn_v4_0_3_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
>    * vcn_v4_0_3_stop - VCN stop
>    *
>    * @adev: amdgpu_device pointer
> - * @inst: VCN instance index to be stopped
>    *
>    * Stop VCN block
>    */
> -static int vcn_v4_0_3_stop(struct amdgpu_device *adev, unsigned int inst)
> +static int vcn_v4_0_3_stop(struct amdgpu_device *adev)
>   {
>   	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
> -	int r = 0, vcn_inst;
> +	int i, r = 0, vcn_inst;
>   	uint32_t tmp;
>   
> -	vcn_inst = GET_INST(VCN, inst);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		vcn_inst = GET_INST(VCN, i);
>   
> -	fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
> -	fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
> +		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
> +		fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
>   
> -	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> -		vcn_v4_0_3_stop_dpg_mode(adev, inst);
> -		goto Done;
> -	}
> +		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> +			vcn_v4_0_3_stop_dpg_mode(adev, i);
> +			continue;
> +		}
>   
> -	/* wait for vcn idle */
> -	r = SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_STATUS,
> -				   UVD_STATUS__IDLE, 0x7);
> -	if (r)
> -		goto Done;
> -
> -	tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
> -		UVD_LMI_STATUS__READ_CLEAN_MASK |
> -		UVD_LMI_STATUS__WRITE_CLEAN_MASK |
> -		UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
> -	r = SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_LMI_STATUS, tmp,
> -				   tmp);
> -	if (r)
> -		goto Done;
> -
> -	/* stall UMC channel */
> -	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL2);
> -	tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
> -	WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL2, tmp);
> -	tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK |
> -		UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
> -	r = SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_LMI_STATUS, tmp,
> -				   tmp);
> -	if (r)
> -		goto Done;
> +		/* wait for vcn idle */
> +		r = SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_STATUS,
> +				       UVD_STATUS__IDLE, 0x7);
> +		if (r)
> +			goto Done;
> +
> +		tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
> +			UVD_LMI_STATUS__READ_CLEAN_MASK |
> +			UVD_LMI_STATUS__WRITE_CLEAN_MASK |
> +			UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
> +		r = SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_LMI_STATUS, tmp,
> +				       tmp);
> +		if (r)
> +			goto Done;
> +
> +		/* stall UMC channel */
> +		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL2);
> +		tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
> +		WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL2, tmp);
> +		tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK |
> +			UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
> +		r = SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_LMI_STATUS, tmp,
> +				       tmp);
> +		if (r)
> +			goto Done;
>   
> -	/* Unblock VCPU Register access */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_RB_ARB_CTRL),
> -		 UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
> -		 ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> +		/* Unblock VCPU Register access */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_RB_ARB_CTRL),
> +			 UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
> +			 ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
>   
> -	/* release VCPU reset to boot */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL),
> -		 UVD_VCPU_CNTL__BLK_RST_MASK,
> -		 ~UVD_VCPU_CNTL__BLK_RST_MASK);
> +		/* release VCPU reset to boot */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL),
> +			 UVD_VCPU_CNTL__BLK_RST_MASK,
> +			 ~UVD_VCPU_CNTL__BLK_RST_MASK);
>   
> -	/* disable VCPU clock */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL), 0,
> -		 ~(UVD_VCPU_CNTL__CLK_EN_MASK));
> +		/* disable VCPU clock */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL), 0,
> +			 ~(UVD_VCPU_CNTL__CLK_EN_MASK));
>   
> -	/* reset LMI UMC/LMI/VCPU */
> -	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
> -	tmp |= UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> -	WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
> +		/* reset LMI UMC/LMI/VCPU */
> +		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
> +		tmp |= UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> +		WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
>   
> -	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
> -	tmp |= UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> -	WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
> +		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
> +		tmp |= UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> +		WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
>   
> -	/* clear VCN status */
> -	WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, 0);
> +		/* clear VCN status */
> +		WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, 0);
>   
> -	/* apply HW clock gating */
> -	vcn_v4_0_3_enable_clock_gating(adev, inst);
> +		/* apply HW clock gating */
> +		vcn_v4_0_3_enable_clock_gating(adev, i);
> +	}
>   Done:
> -	if (adev->pm.dpm_enabled)
> -		amdgpu_dpm_enable_vcn(adev, false, inst);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->pm.dpm_enabled)
> +			amdgpu_dpm_enable_vcn(adev, false, i);
> +	}
>   
>   	return 0;
>   }
> @@ -1547,19 +1544,20 @@ static const struct amdgpu_ring_funcs vcn_v4_0_3_unified_ring_vm_funcs = {
>    * vcn_v4_0_3_set_unified_ring_funcs - set unified ring functions
>    *
>    * @adev: amdgpu_device pointer
> - * @inst: instance of the VCN block for which to set the ring functions
>    *
>    * Set unified ring functions
>    */
> -static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device *adev, int inst)
> +static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device *adev)
>   {
> -	int vcn_inst;
> +	int i, vcn_inst;
>   
> -	adev->vcn.inst[inst].ring_enc[0].funcs = &vcn_v4_0_3_unified_ring_vm_funcs;
> -	adev->vcn.inst[inst].ring_enc[0].me = inst;
> -	vcn_inst = GET_INST(VCN, inst);
> -	adev->vcn.inst[inst].aid_id =
> -		vcn_inst / adev->vcn.num_inst_per_aid;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		adev->vcn.inst[i].ring_enc[0].funcs = &vcn_v4_0_3_unified_ring_vm_funcs;
> +		adev->vcn.inst[i].ring_enc[0].me = i;
> +		vcn_inst = GET_INST(VCN, i);
> +		adev->vcn.inst[i].aid_id =
> +			vcn_inst / adev->vcn.num_inst_per_aid;
> +	}
>   }
>   
>   /**
> @@ -1592,18 +1590,21 @@ static bool vcn_v4_0_3_is_idle(void *handle)
>   static int vcn_v4_0_3_wait_for_idle(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int inst = ip_block->instance;
> -	int ret;
> +	int i, ret = 0;
>   
> -	ret = SOC15_WAIT_ON_RREG(VCN, GET_INST(VCN, inst), regUVD_STATUS,
> -				 UVD_STATUS__IDLE, UVD_STATUS__IDLE);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		ret = SOC15_WAIT_ON_RREG(VCN, GET_INST(VCN, i), regUVD_STATUS,
> +					 UVD_STATUS__IDLE, UVD_STATUS__IDLE);
> +		if (ret)
> +			return ret;
> +	}
>   
>   	return ret;
>   }
>   
>   /* vcn_v4_0_3_set_clockgating_state - set VCN block clockgating state
>    *
> - * @ip_block: amdgpu_ip_block pointer
> + * @handle: amdgpu_device pointer
>    * @state: clock gating state
>    *
>    * Set VCN block clockgating state
> @@ -1613,24 +1614,25 @@ static int vcn_v4_0_3_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
>   	bool enable = state == AMD_CG_STATE_GATE;
> -	int inst = ip_block->instance;
> +	int i;
>   
> -	if (enable) {
> -		if (RREG32_SOC15(VCN, GET_INST(VCN, inst),
> -				 regUVD_STATUS) != UVD_STATUS__IDLE)
> -			return -EBUSY;
> -		vcn_v4_0_3_enable_clock_gating(adev, inst);
> -	} else {
> -		vcn_v4_0_3_disable_clock_gating(adev, inst);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (enable) {
> +			if (RREG32_SOC15(VCN, GET_INST(VCN, i),
> +					 regUVD_STATUS) != UVD_STATUS__IDLE)
> +				return -EBUSY;
> +			vcn_v4_0_3_enable_clock_gating(adev, i);
> +		} else {
> +			vcn_v4_0_3_disable_clock_gating(adev, i);
> +		}
>   	}
> -
>   	return 0;
>   }
>   
>   /**
>    * vcn_v4_0_3_set_powergating_state - set VCN block powergating state
>    *
> - * @ip_block: amdgpu_ip_block pointer
> + * @handle: amdgpu_device pointer
>    * @state: power gating state
>    *
>    * Set VCN block powergating state
> @@ -1639,7 +1641,6 @@ static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int inst = ip_block->instance;
>   	int ret;
>   
>   	/* for SRIOV, guest should not control VCN Power-gating
> @@ -1647,20 +1648,20 @@ static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   	 * guest should avoid touching CGC and PG
>   	 */
>   	if (amdgpu_sriov_vf(adev)) {
> -		adev->vcn.inst[inst].cur_state = AMD_PG_STATE_UNGATE;
> +		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
>   		return 0;
>   	}
>   
> -	if (state == adev->vcn.inst[inst].cur_state)
> +	if (state == adev->vcn.cur_state)
>   		return 0;
>   
>   	if (state == AMD_PG_STATE_GATE)
> -		ret = vcn_v4_0_3_stop(adev, inst);
> +		ret = vcn_v4_0_3_stop(adev);
>   	else
> -		ret = vcn_v4_0_3_start(adev, inst);
> +		ret = vcn_v4_0_3_start(adev);
>   
>   	if (!ret)
> -		adev->vcn.inst[inst].cur_state = state;
> +		adev->vcn.cur_state = state;
>   
>   	return ret;
>   }
> @@ -1735,71 +1736,79 @@ static const struct amdgpu_irq_src_funcs vcn_v4_0_3_irq_funcs = {
>    * vcn_v4_0_3_set_irq_funcs - set VCN block interrupt irq functions
>    *
>    * @adev: amdgpu_device pointer
> - * @inst: instance of the VCN block for which to set the IRQ functions
>    *
>    * Set VCN block interrupt irq functions
>    */
> -static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev, int inst)
> +static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev)
>   {
> -	adev->vcn.inst->irq.num_types++;
> +	int i;
>   
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		adev->vcn.inst->irq.num_types++;
> +	}
>   	adev->vcn.inst->irq.funcs = &vcn_v4_0_3_irq_funcs;
>   }
>   
>   static void vcn_v4_0_3_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int i;
> +	int i, j;
>   	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_3);
> -	uint32_t is_powered;
> -	int inst = ip_block->instance;
> +	uint32_t inst_off, is_powered;
>   
> -	if (!ip_block->ip_dump)
> +	if (!adev->vcn.ip_dump)
>   		return;
>   
> -	drm_printf(p, "Instance no:VCN%d\n", inst);
> -	if (adev->vcn.harvest_config & (1 << inst)) {
> -		drm_printf(p, "\nHarvested Instance:VCN%d Skipping dump\n", inst);
> -		return;
> -	}
> +	drm_printf(p, "num_instances:%d\n", adev->vcn.num_vcn_inst);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		if (adev->vcn.harvest_config & (1 << i)) {
> +			drm_printf(p, "\nHarvested Instance:VCN%d Skipping dump\n", i);
> +			continue;
> +		}
>   
> -	is_powered = (ip_block->ip_dump[0] &
> -		      UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
> +		inst_off = i * reg_count;
> +		is_powered = (adev->vcn.ip_dump[inst_off] &
> +				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
>   
> -	if (is_powered) {
> -		drm_printf(p, "\nActive Instance:VCN%d\n", inst);
> -		for (i = 0; i < reg_count; i++)
> -			drm_printf(p, "%-50s \t 0x%08x\n",
> -				   vcn_reg_list_4_0_3[i].reg_name,
> -				   ip_block->ip_dump[i]);
> -	} else {
> -		drm_printf(p, "\nInactive Instance:VCN%d\n", inst);
> +		if (is_powered) {
> +			drm_printf(p, "\nActive Instance:VCN%d\n", i);
> +			for (j = 0; j < reg_count; j++)
> +				drm_printf(p, "%-50s \t 0x%08x\n", vcn_reg_list_4_0_3[j].reg_name,
> +					   adev->vcn.ip_dump[inst_off + j]);
> +		} else {
> +			drm_printf(p, "\nInactive Instance:VCN%d\n", i);
> +		}
>   	}
>   }
>   
>   static void vcn_v4_0_3_dump_ip_state(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int i;
> +	int i, j;
>   	bool is_powered;
> -	uint32_t inst = GET_INST(VCN, ip_block->instance);
> +	uint32_t inst_off, inst_id;
>   	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_3);
>   
> -	if (!ip_block->ip_dump)
> -		return;
> -
> -	if (adev->vcn.harvest_config & (1 << inst))
> +	if (!adev->vcn.ip_dump)
>   		return;
>   
> -	/* mmUVD_POWER_STATUS is always readable and is first element of the array */
> -	ip_block->ip_dump[0] = RREG32_SOC15(VCN, inst, regUVD_POWER_STATUS);
> -	is_powered = (ip_block->ip_dump[0] &
> -		      UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
> -
> -	if (is_powered)
> -		for (i = 1; i < reg_count; i++)
> -			ip_block->ip_dump[i] =
> -				RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_4_0_3[i], inst));
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
> +
> +		inst_id = GET_INST(VCN, i);
> +		inst_off = i * reg_count;
> +		/* mmUVD_POWER_STATUS is always readable and is first element of the array */
> +		adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, inst_id, regUVD_POWER_STATUS);
> +		is_powered = (adev->vcn.ip_dump[inst_off] &
> +				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
> +
> +		if (is_powered)
> +			for (j = 1; j < reg_count; j++)
> +				adev->vcn.ip_dump[inst_off + j] =
> +					RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_4_0_3[j],
> +									   inst_id));
> +	}
>   }
>   
>   static const struct amd_ip_funcs vcn_v4_0_3_ip_funcs = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index 88fee2e7e5e5..e49ba5bc7fa0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -93,8 +93,8 @@ static int amdgpu_ih_clientid_vcns[] = {
>   	SOC15_IH_CLIENTID_VCN1
>   };
>   
> -static void vcn_v4_0_5_set_unified_ring_funcs(struct amdgpu_device *adev, int inst);
> -static void vcn_v4_0_5_set_irq_funcs(struct amdgpu_device *adev, int inst);
> +static void vcn_v4_0_5_set_unified_ring_funcs(struct amdgpu_device *adev);
> +static void vcn_v4_0_5_set_irq_funcs(struct amdgpu_device *adev);
>   static int vcn_v4_0_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   		enum amd_powergating_state state);
>   static int vcn_v4_0_5_pause_dpg_mode(struct amdgpu_device *adev,
> @@ -112,14 +112,13 @@ static void vcn_v4_0_5_unified_ring_set_wptr(struct amdgpu_ring *ring);
>   static int vcn_v4_0_5_early_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int inst = ip_block->instance;
>   
>   	/* re-use enc ring as unified ring */
>   	adev->vcn.num_enc_rings = 1;
> -	vcn_v4_0_5_set_unified_ring_funcs(adev, inst);
> -	vcn_v4_0_5_set_irq_funcs(adev, inst);
> +	vcn_v4_0_5_set_unified_ring_funcs(adev);
> +	vcn_v4_0_5_set_irq_funcs(adev);
>   
> -	return amdgpu_vcn_early_init(adev, inst);
> +	return amdgpu_vcn_early_init(adev);
>   }
>   
>   /**
> @@ -131,72 +130,73 @@ static int vcn_v4_0_5_early_init(struct amdgpu_ip_block *ip_block)
>    */
>   static int vcn_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = ip_block->adev;
> -	int inst = ip_block->instance;
>   	struct amdgpu_ring *ring;
> +	struct amdgpu_device *adev = ip_block->adev;
> +	int i, r;
>   	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_5);
>   	uint32_t *ptr;
> -	int r;
>   
> -	r = amdgpu_vcn_sw_init(adev, inst);
> +	r = amdgpu_vcn_sw_init(adev);
>   	if (r)
>   		return r;
>   
> -	amdgpu_vcn_setup_ucode(adev, inst);
> +	amdgpu_vcn_setup_ucode(adev);
>   
> -	r = amdgpu_vcn_resume(adev, inst);
> +	r = amdgpu_vcn_resume(adev);
>   	if (r)
>   		return r;
>   
> -	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		volatile struct amdgpu_vcn4_fw_shared *fw_shared;
>   
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		goto done;
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
>   
> -	atomic_set(&adev->vcn.inst[inst].sched_score, 0);
> +		atomic_set(&adev->vcn.inst[i].sched_score, 0);
>   
> -	/* VCN UNIFIED TRAP */
> -	r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
> -			VCN_4_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst[inst].irq);
> -	if (r)
> -		return r;
> +		/* VCN UNIFIED TRAP */
> +		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[i],
> +				VCN_4_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst[i].irq);
> +		if (r)
> +			return r;
>   
> -	/* VCN POISON TRAP */
> -	r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
> -			VCN_4_0__SRCID_UVD_POISON, &adev->vcn.inst[inst].irq);
> -	if (r)
> -		return r;
> +		/* VCN POISON TRAP */
> +		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[i],
> +				VCN_4_0__SRCID_UVD_POISON, &adev->vcn.inst[i].irq);
> +		if (r)
> +			return r;
>   
> -	ring = &adev->vcn.inst[inst].ring_enc[0];
> -	ring->use_doorbell = true;
> -	if (amdgpu_sriov_vf(adev))
> -		ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
> -					inst * (adev->vcn.num_enc_rings + 1) + 1;
> -	else
> -		ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
> -					2 + 8 * inst;
> -	ring->vm_hub = AMDGPU_MMHUB0(0);
> -	sprintf(ring->name, "vcn_unified_%d", inst);
> +		ring = &adev->vcn.inst[i].ring_enc[0];
> +		ring->use_doorbell = true;
> +		if (amdgpu_sriov_vf(adev))
> +			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
> +						i * (adev->vcn.num_enc_rings + 1) + 1;
> +		else
> +			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
> +						2 + 8 * i;
> +		ring->vm_hub = AMDGPU_MMHUB0(0);
> +		sprintf(ring->name, "vcn_unified_%d", i);
> +
> +		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[i].irq, 0,
> +				AMDGPU_RING_PRIO_0, &adev->vcn.inst[i].sched_score);
> +		if (r)
> +			return r;
>   
> -	r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[inst].irq, 0,
> -			AMDGPU_RING_PRIO_0, &adev->vcn.inst[inst].sched_score);
> -	if (r)
> -		return r;
> +		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
> +		fw_shared->present_flag_0 = cpu_to_le32(AMDGPU_FW_SHARED_FLAG_0_UNIFIED_QUEUE);
> +		fw_shared->sq.is_enabled = 1;
>   
> -	fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
> -	fw_shared->present_flag_0 = cpu_to_le32(AMDGPU_FW_SHARED_FLAG_0_UNIFIED_QUEUE);
> -	fw_shared->sq.is_enabled = 1;
> +		fw_shared->present_flag_0 |= cpu_to_le32(AMDGPU_VCN_SMU_DPM_INTERFACE_FLAG);
> +		fw_shared->smu_dpm_interface.smu_interface_type = (adev->flags & AMD_IS_APU) ?
> +			AMDGPU_VCN_SMU_DPM_INTERFACE_APU : AMDGPU_VCN_SMU_DPM_INTERFACE_DGPU;
>   
> -	fw_shared->present_flag_0 |= cpu_to_le32(AMDGPU_VCN_SMU_DPM_INTERFACE_FLAG);
> -	fw_shared->smu_dpm_interface.smu_interface_type = (adev->flags & AMD_IS_APU) ?
> -		AMDGPU_VCN_SMU_DPM_INTERFACE_APU : AMDGPU_VCN_SMU_DPM_INTERFACE_DGPU;
> +		if (amdgpu_sriov_vf(adev))
> +			fw_shared->present_flag_0 |= cpu_to_le32(AMDGPU_VCN_VF_RB_SETUP_FLAG);
>   
> -	if (amdgpu_sriov_vf(adev))
> -		fw_shared->present_flag_0 |= cpu_to_le32(AMDGPU_VCN_VF_RB_SETUP_FLAG);
> +		if (amdgpu_vcnfw_log)
> +			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
> +	}
>   
> -	if (amdgpu_vcnfw_log)
> -		amdgpu_vcn_fwlog_init(&adev->vcn.inst[inst]);
> -done:
>   	if (amdgpu_sriov_vf(adev)) {
>   		r = amdgpu_virt_alloc_mm_table(adev);
>   		if (r)
> @@ -207,12 +207,12 @@ static int vcn_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
>   		adev->vcn.pause_dpg_mode = vcn_v4_0_5_pause_dpg_mode;
>   
>   	/* Allocate memory for VCN IP Dump buffer */
> -	ptr = kcalloc(reg_count, sizeof(uint32_t), GFP_KERNEL);
> +	ptr = kcalloc(adev->vcn.num_vcn_inst * reg_count, sizeof(uint32_t), GFP_KERNEL);
>   	if (!ptr) {
>   		DRM_ERROR("Failed to allocate memory for VCN IP Dump\n");
> -		ip_block->ip_dump = NULL;
> +		adev->vcn.ip_dump = NULL;
>   	} else {
> -		ip_block->ip_dump = ptr;
> +		adev->vcn.ip_dump = ptr;
>   	}
>   	return 0;
>   }
> @@ -227,32 +227,33 @@ static int vcn_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
>   static int vcn_v4_0_5_sw_fini(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int inst = ip_block->instance;
> -	int r, idx;
> +	int i, r, idx;
>   
>   	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> -		volatile struct amdgpu_vcn4_fw_shared *fw_shared;
> +		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +			volatile struct amdgpu_vcn4_fw_shared *fw_shared;
> +
> +			if (adev->vcn.harvest_config & (1 << i))
> +				continue;
>   
> -		if (adev->vcn.harvest_config & (1 << inst))
> -			goto done;
> +			fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
> +			fw_shared->present_flag_0 = 0;
> +			fw_shared->sq.is_enabled = 0;
> +		}
>   
> -		fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
> -		fw_shared->present_flag_0 = 0;
> -		fw_shared->sq.is_enabled = 0;
> -	done:
>   		drm_dev_exit(idx);
>   	}
>   
>   	if (amdgpu_sriov_vf(adev))
>   		amdgpu_virt_free_mm_table(adev);
>   
> -	r = amdgpu_vcn_suspend(adev, inst);
> +	r = amdgpu_vcn_suspend(adev);
>   	if (r)
>   		return r;
>   
> -	r = amdgpu_vcn_sw_fini(adev, inst);
> +	r = amdgpu_vcn_sw_fini(adev);
>   
> -	kfree(ip_block->ip_dump);
> +	kfree(adev->vcn.ip_dump);
>   
>   	return r;
>   }
> @@ -268,20 +269,21 @@ static int vcn_v4_0_5_hw_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
>   	struct amdgpu_ring *ring;
> -	int inst = ip_block->instance;
> -	int r;
> +	int i, r;
>   
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		return 0;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
>   
> -	ring = &adev->vcn.inst[inst].ring_enc[0];
> +		ring = &adev->vcn.inst[i].ring_enc[0];
>   
> -	adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
> -			((adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 8 * inst), inst);
> +		adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
> +				((adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 8 * i), i);
>   
> -	r = amdgpu_ring_test_helper(ring);
> -	if (r)
> -		return r;
> +		r = amdgpu_ring_test_helper(ring);
> +		if (r)
> +			return r;
> +	}
>   
>   	return 0;
>   }
> @@ -296,18 +298,19 @@ static int vcn_v4_0_5_hw_init(struct amdgpu_ip_block *ip_block)
>   static int vcn_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int inst = ip_block->instance;
> -
> -	cancel_delayed_work_sync(&adev->vcn.inst[inst].idle_work);
> +	int i;
>   
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		return 0;
> +	cancel_delayed_work_sync(&adev->vcn.idle_work);
>   
> -	if (!amdgpu_sriov_vf(adev)) {
> -		if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> -		    (adev->vcn.inst[inst].cur_state != AMD_PG_STATE_GATE &&
> -		     RREG32_SOC15(VCN, inst, regUVD_STATUS))) {
> -			vcn_v4_0_5_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
> +		if (!amdgpu_sriov_vf(adev)) {
> +			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> +				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> +				RREG32_SOC15(VCN, i, regUVD_STATUS))) {
> +				vcn_v4_0_5_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
> +			}
>   		}
>   	}
>   
> @@ -323,15 +326,13 @@ static int vcn_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
>    */
>   static int vcn_v4_0_5_suspend(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = ip_block->adev;
> -	int inst = ip_block->instance;
>   	int r;
>   
>   	r = vcn_v4_0_5_hw_fini(ip_block);
>   	if (r)
>   		return r;
>   
> -	r = amdgpu_vcn_suspend(adev, inst);
> +	r = amdgpu_vcn_suspend(ip_block->adev);
>   
>   	return r;
>   }
> @@ -347,7 +348,7 @@ static int vcn_v4_0_5_resume(struct amdgpu_ip_block *ip_block)
>   {
>   	int r;
>   
> -	r = amdgpu_vcn_resume(ip_block->adev, ip_block->instance);
> +	r = amdgpu_vcn_resume(ip_block->adev);
>   	if (r)
>   		return r;
>   
> @@ -989,180 +990,183 @@ static int vcn_v4_0_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
>    * vcn_v4_0_5_start - VCN start
>    *
>    * @adev: amdgpu_device pointer
> - * @inst: VCN instance index to be started
>    *
>    * Start VCN block
>    */
> -static int vcn_v4_0_5_start(struct amdgpu_device *adev, unsigned int inst)
> +static int vcn_v4_0_5_start(struct amdgpu_device *adev)
>   {
>   	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
>   	struct amdgpu_ring *ring;
>   	uint32_t tmp;
> -	int j, k, r;
> +	int i, j, k, r;
>   
> -	if (adev->pm.dpm_enabled)
> -		amdgpu_dpm_enable_vcn(adev, true, inst);
> -
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		return 0;
> -
> -	fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
> -
> -	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> -		r = vcn_v4_0_5_start_dpg_mode(adev, inst, adev->vcn.indirect_sram);
> -		return r;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->pm.dpm_enabled)
> +			amdgpu_dpm_enable_vcn(adev, true, i);
>   	}
>   
> -	/* disable VCN power gating */
> -	vcn_v4_0_5_disable_static_power_gating(adev, inst);
> -
> -	/* set VCN status busy */
> -	tmp = RREG32_SOC15(VCN, inst, regUVD_STATUS) | UVD_STATUS__UVD_BUSY;
> -	WREG32_SOC15(VCN, inst, regUVD_STATUS, tmp);
> -
> -	/*SW clock gating */
> -	vcn_v4_0_5_disable_clock_gating(adev, inst);
> -
> -	/* enable VCPU clock */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_VCPU_CNTL),
> -			UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
> -
> -	/* disable master interrupt */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_MASTINT_EN), 0,
> -			~UVD_MASTINT_EN__VCPU_EN_MASK);
> -
> -	/* enable LMI MC and UMC channels */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_LMI_CTRL2), 0,
> -			~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
> -
> -	tmp = RREG32_SOC15(VCN, inst, regUVD_SOFT_RESET);
> -	tmp &= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> -	tmp &= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> -	WREG32_SOC15(VCN, inst, regUVD_SOFT_RESET, tmp);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
>   
> -	/* setup regUVD_LMI_CTRL */
> -	tmp = RREG32_SOC15(VCN, inst, regUVD_LMI_CTRL);
> -	WREG32_SOC15(VCN, inst, regUVD_LMI_CTRL, tmp |
> -			UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
> -			UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
> -			UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
> -			UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
> -
> -	/* setup regUVD_MPC_CNTL */
> -	tmp = RREG32_SOC15(VCN, inst, regUVD_MPC_CNTL);
> -	tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
> -	tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
> -	WREG32_SOC15(VCN, inst, regUVD_MPC_CNTL, tmp);
> -
> -	/* setup UVD_MPC_SET_MUXA0 */
> -	WREG32_SOC15(VCN, inst, regUVD_MPC_SET_MUXA0,
> -			((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
> -			 (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
> -			 (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
> -			 (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
> -
> -	/* setup UVD_MPC_SET_MUXB0 */
> -	WREG32_SOC15(VCN, inst, regUVD_MPC_SET_MUXB0,
> -			((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
> -			 (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
> -			 (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
> -			 (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
> -
> -	/* setup UVD_MPC_SET_MUX */
> -	WREG32_SOC15(VCN, inst, regUVD_MPC_SET_MUX,
> -			((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
> -			 (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
> -			 (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
> -
> -	vcn_v4_0_5_mc_resume(adev, inst);
> +		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
>   
> -	/* VCN global tiling registers */
> -	WREG32_SOC15(VCN, inst, regUVD_GFX10_ADDR_CONFIG,
> -			adev->gfx.config.gb_addr_config);
> -
> -	/* unblock VCPU register access */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_RB_ARB_CTRL), 0,
> -			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> -
> -	/* release VCPU reset to boot */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_VCPU_CNTL), 0,
> -			~UVD_VCPU_CNTL__BLK_RST_MASK);
> -
> -	for (j = 0; j < 10; ++j) {
> -		uint32_t status;
> -
> -		for (k = 0; k < 100; ++k) {
> -			status = RREG32_SOC15(VCN, inst, regUVD_STATUS);
> -			if (status & 2)
> -				break;
> -			mdelay(10);
> -			if (amdgpu_emu_mode == 1)
> -				msleep(1);
> +		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> +			r = vcn_v4_0_5_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
> +			continue;
>   		}
>   
> -		if (amdgpu_emu_mode == 1) {
> -			r = -1;
> -			if (status & 2) {
> -				r = 0;
> -				break;
> +		/* disable VCN power gating */
> +		vcn_v4_0_5_disable_static_power_gating(adev, i);
> +
> +		/* set VCN status busy */
> +		tmp = RREG32_SOC15(VCN, i, regUVD_STATUS) | UVD_STATUS__UVD_BUSY;
> +		WREG32_SOC15(VCN, i, regUVD_STATUS, tmp);
> +
> +		/*SW clock gating */
> +		vcn_v4_0_5_disable_clock_gating(adev, i);
> +
> +		/* enable VCPU clock */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
> +				UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
> +
> +		/* disable master interrupt */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_MASTINT_EN), 0,
> +				~UVD_MASTINT_EN__VCPU_EN_MASK);
> +
> +		/* enable LMI MC and UMC channels */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_LMI_CTRL2), 0,
> +				~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
> +
> +		tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
> +		tmp &= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> +		tmp &= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> +		WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
> +
> +		/* setup regUVD_LMI_CTRL */
> +		tmp = RREG32_SOC15(VCN, i, regUVD_LMI_CTRL);
> +		WREG32_SOC15(VCN, i, regUVD_LMI_CTRL, tmp |
> +				UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
> +				UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
> +				UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
> +				UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
> +
> +		/* setup regUVD_MPC_CNTL */
> +		tmp = RREG32_SOC15(VCN, i, regUVD_MPC_CNTL);
> +		tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
> +		tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
> +		WREG32_SOC15(VCN, i, regUVD_MPC_CNTL, tmp);
> +
> +		/* setup UVD_MPC_SET_MUXA0 */
> +		WREG32_SOC15(VCN, i, regUVD_MPC_SET_MUXA0,
> +				((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
> +				 (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
> +				 (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
> +				 (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
> +
> +		/* setup UVD_MPC_SET_MUXB0 */
> +		WREG32_SOC15(VCN, i, regUVD_MPC_SET_MUXB0,
> +				((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
> +				 (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
> +				 (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
> +				 (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
> +
> +		/* setup UVD_MPC_SET_MUX */
> +		WREG32_SOC15(VCN, i, regUVD_MPC_SET_MUX,
> +				((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
> +				 (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
> +				 (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
> +
> +		vcn_v4_0_5_mc_resume(adev, i);
> +
> +		/* VCN global tiling registers */
> +		WREG32_SOC15(VCN, i, regUVD_GFX10_ADDR_CONFIG,
> +				adev->gfx.config.gb_addr_config);
> +
> +		/* unblock VCPU register access */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_RB_ARB_CTRL), 0,
> +				~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> +
> +		/* release VCPU reset to boot */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
> +				~UVD_VCPU_CNTL__BLK_RST_MASK);
> +
> +		for (j = 0; j < 10; ++j) {
> +			uint32_t status;
> +
> +			for (k = 0; k < 100; ++k) {
> +				status = RREG32_SOC15(VCN, i, regUVD_STATUS);
> +				if (status & 2)
> +					break;
> +				mdelay(10);
> +				if (amdgpu_emu_mode == 1)
> +					msleep(1);
>   			}
> -		} else {
> -			r = 0;
> -			if (status & 2)
> -				break;
> -
> -			dev_err(adev->dev,
> -				"VCN[%d] is not responding, trying to reset VCPU!!!\n", inst);
> -			WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_VCPU_CNTL),
> -						UVD_VCPU_CNTL__BLK_RST_MASK,
> +
> +			if (amdgpu_emu_mode == 1) {
> +				r = -1;
> +				if (status & 2) {
> +					r = 0;
> +					break;
> +				}
> +			} else {
> +				r = 0;
> +				if (status & 2)
> +					break;
> +
> +				dev_err(adev->dev,
> +					"VCN[%d] is not responding, trying to reset VCPU!!!\n", i);
> +				WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
> +							UVD_VCPU_CNTL__BLK_RST_MASK,
> +							~UVD_VCPU_CNTL__BLK_RST_MASK);
> +				mdelay(10);
> +				WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
>   						~UVD_VCPU_CNTL__BLK_RST_MASK);
> -			mdelay(10);
> -			WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_VCPU_CNTL), 0,
> -					~UVD_VCPU_CNTL__BLK_RST_MASK);
>   
> -			mdelay(10);
> -			r = -1;
> +				mdelay(10);
> +				r = -1;
> +			}
>   		}
> -	}
> -
> -	if (r) {
> -		dev_err(adev->dev, "VCN[%d] is not responding, giving up!!!\n", inst);
> -		return r;
> -	}
> -
> -	/* enable master interrupt */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_MASTINT_EN),
> -			UVD_MASTINT_EN__VCPU_EN_MASK,
> -			~UVD_MASTINT_EN__VCPU_EN_MASK);
> -
> -	/* clear the busy bit of VCN_STATUS */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_STATUS), 0,
> -			~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
> -
> -	ring = &adev->vcn.inst[inst].ring_enc[0];
> -	WREG32_SOC15(VCN, inst, regVCN_RB1_DB_CTRL,
> -			ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
> -			VCN_RB1_DB_CTRL__EN_MASK);
> -
> -	WREG32_SOC15(VCN, inst, regUVD_RB_BASE_LO, ring->gpu_addr);
> -	WREG32_SOC15(VCN, inst, regUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
> -	WREG32_SOC15(VCN, inst, regUVD_RB_SIZE, ring->ring_size / 4);
> -
> -	tmp = RREG32_SOC15(VCN, inst, regVCN_RB_ENABLE);
> -	tmp &= ~(VCN_RB_ENABLE__RB1_EN_MASK);
> -	WREG32_SOC15(VCN, inst, regVCN_RB_ENABLE, tmp);
> -	fw_shared->sq.queue_mode |= FW_QUEUE_RING_RESET;
> -	WREG32_SOC15(VCN, inst, regUVD_RB_RPTR, 0);
> -	WREG32_SOC15(VCN, inst, regUVD_RB_WPTR, 0);
>   
> -	tmp = RREG32_SOC15(VCN, inst, regUVD_RB_RPTR);
> -	WREG32_SOC15(VCN, inst, regUVD_RB_WPTR, tmp);
> -	ring->wptr = RREG32_SOC15(VCN, inst, regUVD_RB_WPTR);
> +		if (r) {
> +			dev_err(adev->dev, "VCN[%d] is not responding, giving up!!!\n", i);
> +			return r;
> +		}
>   
> -	tmp = RREG32_SOC15(VCN, inst, regVCN_RB_ENABLE);
> -	tmp |= VCN_RB_ENABLE__RB1_EN_MASK;
> -	WREG32_SOC15(VCN, inst, regVCN_RB_ENABLE, tmp);
> -	fw_shared->sq.queue_mode &= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
> +		/* enable master interrupt */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_MASTINT_EN),
> +				UVD_MASTINT_EN__VCPU_EN_MASK,
> +				~UVD_MASTINT_EN__VCPU_EN_MASK);
> +
> +		/* clear the busy bit of VCN_STATUS */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_STATUS), 0,
> +				~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
> +
> +		ring = &adev->vcn.inst[i].ring_enc[0];
> +		WREG32_SOC15(VCN, i, regVCN_RB1_DB_CTRL,
> +				ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
> +				VCN_RB1_DB_CTRL__EN_MASK);
> +
> +		WREG32_SOC15(VCN, i, regUVD_RB_BASE_LO, ring->gpu_addr);
> +		WREG32_SOC15(VCN, i, regUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
> +		WREG32_SOC15(VCN, i, regUVD_RB_SIZE, ring->ring_size / 4);
> +
> +		tmp = RREG32_SOC15(VCN, i, regVCN_RB_ENABLE);
> +		tmp &= ~(VCN_RB_ENABLE__RB1_EN_MASK);
> +		WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
> +		fw_shared->sq.queue_mode |= FW_QUEUE_RING_RESET;
> +		WREG32_SOC15(VCN, i, regUVD_RB_RPTR, 0);
> +		WREG32_SOC15(VCN, i, regUVD_RB_WPTR, 0);
> +
> +		tmp = RREG32_SOC15(VCN, i, regUVD_RB_RPTR);
> +		WREG32_SOC15(VCN, i, regUVD_RB_WPTR, tmp);
> +		ring->wptr = RREG32_SOC15(VCN, i, regUVD_RB_WPTR);
> +
> +		tmp = RREG32_SOC15(VCN, i, regVCN_RB_ENABLE);
> +		tmp |= VCN_RB_ENABLE__RB1_EN_MASK;
> +		WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
> +		fw_shared->sq.queue_mode &= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
> +	}
>   
>   	return 0;
>   }
> @@ -1199,83 +1203,86 @@ static void vcn_v4_0_5_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
>    * vcn_v4_0_5_stop - VCN stop
>    *
>    * @adev: amdgpu_device pointer
> - * @inst: VCN instance index to be stopped
>    *
>    * Stop VCN block
>    */
> -static int vcn_v4_0_5_stop(struct amdgpu_device *adev, unsigned int inst)
> +static int vcn_v4_0_5_stop(struct amdgpu_device *adev)
>   {
>   	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
>   	uint32_t tmp;
> -	int r = 0;
> +	int i, r = 0;
>   
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		goto done;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
>   
> -	fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
> -	fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
> +		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
> +		fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
>   
> -	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> -		vcn_v4_0_5_stop_dpg_mode(adev, inst);
> -		goto done;
> -	}
> +		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> +			vcn_v4_0_5_stop_dpg_mode(adev, i);
> +			continue;
> +		}
>   
> -	/* wait for vcn idle */
> -	r = SOC15_WAIT_ON_RREG(VCN, inst, regUVD_STATUS, UVD_STATUS__IDLE, 0x7);
> -	if (r)
> -		return r;
> +		/* wait for vcn idle */
> +		r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_STATUS, UVD_STATUS__IDLE, 0x7);
> +		if (r)
> +			return r;
>   
> -	tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
> -		UVD_LMI_STATUS__READ_CLEAN_MASK |
> -		UVD_LMI_STATUS__WRITE_CLEAN_MASK |
> -		UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
> -	r = SOC15_WAIT_ON_RREG(VCN, inst, regUVD_LMI_STATUS, tmp, tmp);
> -	if (r)
> -		return r;
> +		tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
> +			UVD_LMI_STATUS__READ_CLEAN_MASK |
> +			UVD_LMI_STATUS__WRITE_CLEAN_MASK |
> +			UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
> +		r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_LMI_STATUS, tmp, tmp);
> +		if (r)
> +			return r;
>   
> -	/* disable LMI UMC channel */
> -	tmp = RREG32_SOC15(VCN, inst, regUVD_LMI_CTRL2);
> -	tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
> -	WREG32_SOC15(VCN, inst, regUVD_LMI_CTRL2, tmp);
> -	tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK |
> -		UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
> -	r = SOC15_WAIT_ON_RREG(VCN, inst, regUVD_LMI_STATUS, tmp, tmp);
> -	if (r)
> -		return r;
> +		/* disable LMI UMC channel */
> +		tmp = RREG32_SOC15(VCN, i, regUVD_LMI_CTRL2);
> +		tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
> +		WREG32_SOC15(VCN, i, regUVD_LMI_CTRL2, tmp);
> +		tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK |
> +			UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
> +		r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_LMI_STATUS, tmp, tmp);
> +		if (r)
> +			return r;
>   
> -	/* block VCPU register access */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_RB_ARB_CTRL),
> -			UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
> -			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> +		/* block VCPU register access */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_RB_ARB_CTRL),
> +				UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
> +				~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
>   
> -	/* reset VCPU */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_VCPU_CNTL),
> -			UVD_VCPU_CNTL__BLK_RST_MASK,
> -			~UVD_VCPU_CNTL__BLK_RST_MASK);
> +		/* reset VCPU */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
> +				UVD_VCPU_CNTL__BLK_RST_MASK,
> +				~UVD_VCPU_CNTL__BLK_RST_MASK);
>   
> -	/* disable VCPU clock */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_VCPU_CNTL), 0,
> -			~(UVD_VCPU_CNTL__CLK_EN_MASK));
> +		/* disable VCPU clock */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
> +				~(UVD_VCPU_CNTL__CLK_EN_MASK));
>   
> -	/* apply soft reset */
> -	tmp = RREG32_SOC15(VCN, inst, regUVD_SOFT_RESET);
> -	tmp |= UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> -	WREG32_SOC15(VCN, inst, regUVD_SOFT_RESET, tmp);
> -	tmp = RREG32_SOC15(VCN, inst, regUVD_SOFT_RESET);
> -	tmp |= UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> -	WREG32_SOC15(VCN, inst, regUVD_SOFT_RESET, tmp);
> +		/* apply soft reset */
> +		tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
> +		tmp |= UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> +		WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
> +		tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
> +		tmp |= UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> +		WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
>   
> -	/* clear status */
> -	WREG32_SOC15(VCN, inst, regUVD_STATUS, 0);
> +		/* clear status */
> +		WREG32_SOC15(VCN, i, regUVD_STATUS, 0);
>   
> -	/* apply HW clock gating */
> -	vcn_v4_0_5_enable_clock_gating(adev, inst);
> +		/* apply HW clock gating */
> +		vcn_v4_0_5_enable_clock_gating(adev, i);
>   
> -	/* enable VCN power gating */
> -	vcn_v4_0_5_enable_static_power_gating(adev, inst);
> -done:
> -	if (adev->pm.dpm_enabled)
> -		amdgpu_dpm_enable_vcn(adev, false, inst);
> +		/* enable VCN power gating */
> +		vcn_v4_0_5_enable_static_power_gating(adev, i);
> +	}
> +
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->pm.dpm_enabled)
> +			amdgpu_dpm_enable_vcn(adev, false, i);
> +	}
>   
>   	return 0;
>   }
> @@ -1423,17 +1430,20 @@ static const struct amdgpu_ring_funcs vcn_v4_0_5_unified_ring_vm_funcs = {
>    * vcn_v4_0_5_set_unified_ring_funcs - set unified ring functions
>    *
>    * @adev: amdgpu_device pointer
> - * @inst: instance of the VCN block for which to set the ring functions
>    *
>    * Set unified ring functions
>    */
> -static void vcn_v4_0_5_set_unified_ring_funcs(struct amdgpu_device *adev, int inst)
> +static void vcn_v4_0_5_set_unified_ring_funcs(struct amdgpu_device *adev)
>   {
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		return;
> +	int i;
> +
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
>   
> -	adev->vcn.inst[inst].ring_enc[0].funcs = &vcn_v4_0_5_unified_ring_vm_funcs;
> -	adev->vcn.inst[inst].ring_enc[0].me = inst;
> +		adev->vcn.inst[i].ring_enc[0].funcs = &vcn_v4_0_5_unified_ring_vm_funcs;
> +		adev->vcn.inst[i].ring_enc[0].me = i;
> +	}
>   }
>   
>   /**
> @@ -1468,14 +1478,17 @@ static bool vcn_v4_0_5_is_idle(void *handle)
>   static int vcn_v4_0_5_wait_for_idle(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int inst = ip_block->instance;
> -	int ret;
> +	int i, ret = 0;
>   
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		return 0;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
>   
> -	ret = SOC15_WAIT_ON_RREG(VCN, inst, regUVD_STATUS, UVD_STATUS__IDLE,
> -		UVD_STATUS__IDLE);
> +		ret = SOC15_WAIT_ON_RREG(VCN, i, regUVD_STATUS, UVD_STATUS__IDLE,
> +			UVD_STATUS__IDLE);
> +		if (ret)
> +			return ret;
> +	}
>   
>   	return ret;
>   }
> @@ -1483,7 +1496,7 @@ static int vcn_v4_0_5_wait_for_idle(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v4_0_5_set_clockgating_state - set VCN block clockgating state
>    *
> - * @ip_block: amdgpu_ip_block pointer
> + * @handle: amdgpu_device pointer
>    * @state: clock gating state
>    *
>    * Set VCN block clockgating state
> @@ -1493,17 +1506,19 @@ static int vcn_v4_0_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
>   	bool enable = (state == AMD_CG_STATE_GATE) ? true : false;
> -	int inst = ip_block->instance;
> +	int i;
>   
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		return 0;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
>   
> -	if (enable) {
> -		if (RREG32_SOC15(VCN, inst, regUVD_STATUS) != UVD_STATUS__IDLE)
> -			return -EBUSY;
> -		vcn_v4_0_5_enable_clock_gating(adev, inst);
> -	} else {
> -		vcn_v4_0_5_disable_clock_gating(adev, inst);
> +		if (enable) {
> +			if (RREG32_SOC15(VCN, i, regUVD_STATUS) != UVD_STATUS__IDLE)
> +				return -EBUSY;
> +			vcn_v4_0_5_enable_clock_gating(adev, i);
> +		} else {
> +			vcn_v4_0_5_disable_clock_gating(adev, i);
> +		}
>   	}
>   
>   	return 0;
> @@ -1512,7 +1527,7 @@ static int vcn_v4_0_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   /**
>    * vcn_v4_0_5_set_powergating_state - set VCN block powergating state
>    *
> - * @ip_block: amdgpu_ip_block pointer
> + * @handle: amdgpu_device pointer
>    * @state: power gating state
>    *
>    * Set VCN block powergating state
> @@ -1521,19 +1536,18 @@ static int vcn_v4_0_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   		enum amd_powergating_state state)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int inst = ip_block->instance;
>   	int ret;
>   
> -	if (state == adev->vcn.inst[inst].cur_state)
> +	if (state == adev->vcn.cur_state)
>   		return 0;
>   
>   	if (state == AMD_PG_STATE_GATE)
> -		ret = vcn_v4_0_5_stop(adev, inst);
> +		ret = vcn_v4_0_5_stop(adev);
>   	else
> -		ret = vcn_v4_0_5_start(adev, inst);
> +		ret = vcn_v4_0_5_start(adev);
>   
>   	if (!ret)
> -		adev->vcn.inst[inst].cur_state = state;
> +		adev->vcn.cur_state = state;
>   
>   	return ret;
>   }
> @@ -1590,74 +1604,81 @@ static const struct amdgpu_irq_src_funcs vcn_v4_0_5_irq_funcs = {
>    * vcn_v4_0_5_set_irq_funcs - set VCN block interrupt irq functions
>    *
>    * @adev: amdgpu_device pointer
> - * @inst: instance of the VCN block for which to set the IRQ functions
>    *
>    * Set VCN block interrupt irq functions
>    */
> -static void vcn_v4_0_5_set_irq_funcs(struct amdgpu_device *adev, int inst)
> +static void vcn_v4_0_5_set_irq_funcs(struct amdgpu_device *adev)
>   {
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		return;
> +	int i;
>   
> -	adev->vcn.inst[inst].irq.num_types = adev->vcn.num_enc_rings + 1;
> -	adev->vcn.inst[inst].irq.funcs = &vcn_v4_0_5_irq_funcs;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
> +
> +		adev->vcn.inst[i].irq.num_types = adev->vcn.num_enc_rings + 1;
> +		adev->vcn.inst[i].irq.funcs = &vcn_v4_0_5_irq_funcs;
> +	}
>   }
>   
>   static void vcn_v4_0_5_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int i;
> +	int i, j;
>   	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_5);
> -	uint32_t is_powered;
> -	int inst = ip_block->instance;
> +	uint32_t inst_off, is_powered;
>   
> -	if (!ip_block->ip_dump)
> +	if (!adev->vcn.ip_dump)
>   		return;
>   
> -	drm_printf(p, "Instances no:VCN%d\n", inst);
> -
> -	if (adev->vcn.harvest_config & (1 << inst)) {
> -		drm_printf(p, "\nHarvested Instance:VCN%d Skipping dump\n", inst);
> -		return;
> -	}
> +	drm_printf(p, "num_instances:%d\n", adev->vcn.num_vcn_inst);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		if (adev->vcn.harvest_config & (1 << i)) {
> +			drm_printf(p, "\nHarvested Instance:VCN%d Skipping dump\n", i);
> +			continue;
> +		}
>   
> -	is_powered = (ip_block->ip_dump[0] &
> -		      UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
> +		inst_off = i * reg_count;
> +		is_powered = (adev->vcn.ip_dump[inst_off] &
> +				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
>   
> -	if (is_powered) {
> -		drm_printf(p, "\nActive Instance:VCN%d\n", inst);
> -		for (i = 0; i < reg_count; i++)
> -			drm_printf(p, "%-50s \t 0x%08x\n",
> -				   vcn_reg_list_4_0_5[i].reg_name,
> -				   ip_block->ip_dump[i]);
> -	} else {
> -		drm_printf(p, "\nInactive Instance:VCN%d\n", inst);
> +		if (is_powered) {
> +			drm_printf(p, "\nActive Instance:VCN%d\n", i);
> +			for (j = 0; j < reg_count; j++)
> +				drm_printf(p, "%-50s \t 0x%08x\n", vcn_reg_list_4_0_5[j].reg_name,
> +					   adev->vcn.ip_dump[inst_off + j]);
> +		} else {
> +			drm_printf(p, "\nInactive Instance:VCN%d\n", i);
> +		}
>   	}
>   }
>   
>   static void vcn_v4_0_5_dump_ip_state(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int i;
> +	int i, j;
>   	bool is_powered;
> -	uint32_t inst = GET_INST(VCN, ip_block->instance);
> +	uint32_t inst_off;
>   	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_5);
>   
> -	if (!ip_block->ip_dump)
> +	if (!adev->vcn.ip_dump)
>   		return;
>   
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		return;
> -
> -	/* mmUVD_POWER_STATUS is always readable and is first element of the array */
> -	ip_block->ip_dump[0] = RREG32_SOC15(VCN, inst, regUVD_POWER_STATUS);
> -	is_powered = (ip_block->ip_dump[0] &
> -		      UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
>   
> -	if (is_powered)
> -		for (i = 1; i < reg_count; i++)
> -			ip_block->ip_dump[i] =
> -				RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_4_0_5[i], inst));
> +		inst_off = i * reg_count;
> +		/* mmUVD_POWER_STATUS is always readable and is first element of the array */
> +		adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, regUVD_POWER_STATUS);
> +		is_powered = (adev->vcn.ip_dump[inst_off] &
> +				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
> +
> +		if (is_powered)
> +			for (j = 1; j < reg_count; j++)
> +				adev->vcn.ip_dump[inst_off + j] =
> +					RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_4_0_5[j],
> +									   i));
> +	}
>   }
>   
>   static const struct amd_ip_funcs vcn_v4_0_5_ip_funcs = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index 0de1f6651803..900ca8ababc1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -76,8 +76,8 @@ static int amdgpu_ih_clientid_vcns[] = {
>   	SOC15_IH_CLIENTID_VCN1
>   };
>   
> -static void vcn_v5_0_0_set_unified_ring_funcs(struct amdgpu_device *adev, int inst);
> -static void vcn_v5_0_0_set_irq_funcs(struct amdgpu_device *adev, int inst);
> +static void vcn_v5_0_0_set_unified_ring_funcs(struct amdgpu_device *adev);
> +static void vcn_v5_0_0_set_irq_funcs(struct amdgpu_device *adev);
>   static int vcn_v5_0_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   		enum amd_powergating_state state);
>   static int vcn_v5_0_0_pause_dpg_mode(struct amdgpu_device *adev,
> @@ -95,15 +95,14 @@ static void vcn_v5_0_0_unified_ring_set_wptr(struct amdgpu_ring *ring);
>   static int vcn_v5_0_0_early_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int inst = ip_block->instance;
>   
>   	/* re-use enc ring as unified ring */
>   	adev->vcn.num_enc_rings = 1;
>   
> -	vcn_v5_0_0_set_unified_ring_funcs(adev, inst);
> -	vcn_v5_0_0_set_irq_funcs(adev, inst);
> +	vcn_v5_0_0_set_unified_ring_funcs(adev);
> +	vcn_v5_0_0_set_irq_funcs(adev);
>   
> -	return amdgpu_vcn_early_init(adev, inst);
> +	return amdgpu_vcn_early_init(adev);
>   }
>   
>   /**
> @@ -115,81 +114,73 @@ static int vcn_v5_0_0_early_init(struct amdgpu_ip_block *ip_block)
>    */
>   static int vcn_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = ip_block->adev;
> -	int inst = ip_block->instance;
>   	struct amdgpu_ring *ring;
> +	struct amdgpu_device *adev = ip_block->adev;
> +	int i, r;
>   	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_5_0);
>   	uint32_t *ptr;
> -	int r;
>   
> -	r = amdgpu_vcn_sw_init(adev, inst);
> +	r = amdgpu_vcn_sw_init(adev);
>   	if (r)
>   		return r;
>   
> -	amdgpu_vcn_setup_ucode(adev, inst);
> +	amdgpu_vcn_setup_ucode(adev);
>   
> -	r = amdgpu_vcn_resume(adev, inst);
> +	r = amdgpu_vcn_resume(adev);
>   	if (r)
>   		return r;
>   
> -	volatile struct amdgpu_vcn5_fw_shared *fw_shared;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		volatile struct amdgpu_vcn5_fw_shared *fw_shared;
>   
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		goto done;
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
>   
> -	atomic_set(&adev->vcn.inst[inst].sched_score, 0);
> +		atomic_set(&adev->vcn.inst[i].sched_score, 0);
>   
> -	/* VCN UNIFIED TRAP */
> -	r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
> -			VCN_4_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst[inst].irq);
> -	if (r)
> -		return r;
> +		/* VCN UNIFIED TRAP */
> +		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[i],
> +				VCN_4_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst[i].irq);
> +		if (r)
> +			return r;
>   
> -	/* VCN POISON TRAP */
> -	r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
> -			VCN_4_0__SRCID_UVD_POISON, &adev->vcn.inst[inst].irq);
> -	if (r)
> -		return r;
> +		/* VCN POISON TRAP */
> +		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[i],
> +				VCN_4_0__SRCID_UVD_POISON, &adev->vcn.inst[i].irq);
> +		if (r)
> +			return r;
>   
> -	ring = &adev->vcn.inst[inst].ring_enc[0];
> -	ring->use_doorbell = true;
> -	ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 2 + 8 * inst;
> +		ring = &adev->vcn.inst[i].ring_enc[0];
> +		ring->use_doorbell = true;
> +		ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 2 + 8 * i;
>   
> -	ring->vm_hub = AMDGPU_MMHUB0(0);
> -	sprintf(ring->name, "vcn_unified_%d", inst);
> +		ring->vm_hub = AMDGPU_MMHUB0(0);
> +		sprintf(ring->name, "vcn_unified_%d", i);
>   
> -	r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[inst].irq, 0,
> -					AMDGPU_RING_PRIO_0, &adev->vcn.inst[inst].sched_score);
> -	if (r)
> -		return r;
> +		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[i].irq, 0,
> +						AMDGPU_RING_PRIO_0, &adev->vcn.inst[i].sched_score);
> +		if (r)
> +			return r;
>   
> -	fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
> -	fw_shared->present_flag_0 = cpu_to_le32(AMDGPU_FW_SHARED_FLAG_0_UNIFIED_QUEUE);
> -	fw_shared->sq.is_enabled = 1;
> +		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
> +		fw_shared->present_flag_0 = cpu_to_le32(AMDGPU_FW_SHARED_FLAG_0_UNIFIED_QUEUE);
> +		fw_shared->sq.is_enabled = 1;
>   
> -	/* TODO: Add queue reset mask when FW fully supports it */
> -	adev->sdma.supported_reset =
> -		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
> +		if (amdgpu_vcnfw_log)
> +			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
> +	}
>   
> -	if (amdgpu_vcnfw_log)
> -		amdgpu_vcn_fwlog_init(&adev->vcn.inst[inst]);
> -done:
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
>   		adev->vcn.pause_dpg_mode = vcn_v5_0_0_pause_dpg_mode;
>   
>   	/* Allocate memory for VCN IP Dump buffer */
> -	ptr = kcalloc(reg_count, sizeof(uint32_t), GFP_KERNEL);
> +	ptr = kcalloc(adev->vcn.num_vcn_inst * reg_count, sizeof(uint32_t), GFP_KERNEL);
>   	if (!ptr) {
>   		DRM_ERROR("Failed to allocate memory for VCN IP Dump\n");
> -		ip_block->ip_dump = NULL;
> +		adev->vcn.ip_dump = NULL;
>   	} else {
> -		ip_block->ip_dump = ptr;
> +		adev->vcn.ip_dump = ptr;
>   	}
> -
> -	r = amdgpu_vcn_sysfs_reset_mask_init(adev);
> -	if (r)
> -		return r;
> -
>   	return 0;
>   }
>   
> @@ -203,30 +194,30 @@ static int vcn_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
>   static int vcn_v5_0_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int inst = ip_block->instance;
> -	int r, idx;
> +	int i, r, idx;
>   
>   	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> -		volatile struct amdgpu_vcn5_fw_shared *fw_shared;
> +		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +			volatile struct amdgpu_vcn5_fw_shared *fw_shared;
> +
> +			if (adev->vcn.harvest_config & (1 << i))
> +				continue;
>   
> -		if (adev->vcn.harvest_config & (1 << inst))
> -			goto done;
> +			fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
> +			fw_shared->present_flag_0 = 0;
> +			fw_shared->sq.is_enabled = 0;
> +		}
>   
> -		fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
> -		fw_shared->present_flag_0 = 0;
> -		fw_shared->sq.is_enabled = 0;
> -	done:
>   		drm_dev_exit(idx);
>   	}
>   
> -	r = amdgpu_vcn_suspend(adev, inst);
> +	r = amdgpu_vcn_suspend(adev);
>   	if (r)
>   		return r;
>   
> -	amdgpu_vcn_sysfs_reset_mask_fini(adev);
> -	r = amdgpu_vcn_sw_fini(adev, inst);
> +	r = amdgpu_vcn_sw_fini(adev);
>   
> -	kfree(ip_block->ip_dump);
> +	kfree(adev->vcn.ip_dump);
>   
>   	return r;
>   }
> @@ -242,20 +233,21 @@ static int vcn_v5_0_0_hw_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
>   	struct amdgpu_ring *ring;
> -	int inst = ip_block->instance;
> -	int r;
> +	int i, r;
>   
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		return 0;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
>   
> -	ring = &adev->vcn.inst[inst].ring_enc[0];
> +		ring = &adev->vcn.inst[i].ring_enc[0];
>   
> -	adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
> -		((adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 8 * inst), inst);
> +		adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
> +			((adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 8 * i), i);
>   
> -	r = amdgpu_ring_test_helper(ring);
> -	if (r)
> -		return r;
> +		r = amdgpu_ring_test_helper(ring);
> +		if (r)
> +			return r;
> +	}
>   
>   	return 0;
>   }
> @@ -270,18 +262,19 @@ static int vcn_v5_0_0_hw_init(struct amdgpu_ip_block *ip_block)
>   static int vcn_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int inst = ip_block->instance;
> -
> -	cancel_delayed_work_sync(&adev->vcn.inst[inst].idle_work);
> +	int i;
>   
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		return 0;
> +	cancel_delayed_work_sync(&adev->vcn.idle_work);
>   
> -	if (!amdgpu_sriov_vf(adev)) {
> -		if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> -		    (adev->vcn.inst[inst].cur_state != AMD_PG_STATE_GATE &&
> -		     RREG32_SOC15(VCN, inst, regUVD_STATUS))) {
> -			vcn_v5_0_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
> +		if (!amdgpu_sriov_vf(adev)) {
> +			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> +				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> +				RREG32_SOC15(VCN, i, regUVD_STATUS))) {
> +				vcn_v5_0_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
> +			}
>   		}
>   	}
>   
> @@ -297,15 +290,13 @@ static int vcn_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
>    */
>   static int vcn_v5_0_0_suspend(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = ip_block->adev;
> -	int inst = ip_block->instance;
>   	int r;
>   
>   	r = vcn_v5_0_0_hw_fini(ip_block);
>   	if (r)
>   		return r;
>   
> -	r = amdgpu_vcn_suspend(adev, inst);
> +	r = amdgpu_vcn_suspend(ip_block->adev);
>   
>   	return r;
>   }
> @@ -321,7 +312,7 @@ static int vcn_v5_0_0_resume(struct amdgpu_ip_block *ip_block)
>   {
>   	int r;
>   
> -	r = amdgpu_vcn_resume(ip_block->adev, ip_block->instance);
> +	r = amdgpu_vcn_resume(ip_block->adev);
>   	if (r)
>   		return r;
>   
> @@ -760,151 +751,154 @@ static int vcn_v5_0_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
>    * vcn_v5_0_0_start - VCN start
>    *
>    * @adev: amdgpu_device pointer
> - * @inst: instance of the VCN block to start
>    *
>    * Start VCN block
>    */
> -static int vcn_v5_0_0_start(struct amdgpu_device *adev, unsigned int inst)
> +static int vcn_v5_0_0_start(struct amdgpu_device *adev)
>   {
>   	volatile struct amdgpu_vcn5_fw_shared *fw_shared;
>   	struct amdgpu_ring *ring;
>   	uint32_t tmp;
> -	int j, k, r;
> -
> -	if (adev->pm.dpm_enabled)
> -		amdgpu_dpm_enable_vcn(adev, true, inst);
> -
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		return 0;
> +	int i, j, k, r;
>   
> -	fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
> -
> -	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> -		r = vcn_v5_0_0_start_dpg_mode(adev, inst, adev->vcn.indirect_sram);
> -		return r;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->pm.dpm_enabled)
> +			amdgpu_dpm_enable_vcn(adev, true, i);
>   	}
>   
> -	/* disable VCN power gating */
> -	vcn_v5_0_0_disable_static_power_gating(adev, inst);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
>   
> -	/* set VCN status busy */
> -	tmp = RREG32_SOC15(VCN, inst, regUVD_STATUS) | UVD_STATUS__UVD_BUSY;
> -	WREG32_SOC15(VCN, inst, regUVD_STATUS, tmp);
> +		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
>   
> -	/* enable VCPU clock */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_VCPU_CNTL),
> -		UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
> +		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> +			r = vcn_v5_0_0_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
> +			continue;
> +		}
>   
> -	/* disable master interrupt */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_MASTINT_EN), 0,
> -		~UVD_MASTINT_EN__VCPU_EN_MASK);
> +		/* disable VCN power gating */
> +		vcn_v5_0_0_disable_static_power_gating(adev, i);
>   
> -	/* enable LMI MC and UMC channels */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_LMI_CTRL2), 0,
> -		~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
> +		/* set VCN status busy */
> +		tmp = RREG32_SOC15(VCN, i, regUVD_STATUS) | UVD_STATUS__UVD_BUSY;
> +		WREG32_SOC15(VCN, i, regUVD_STATUS, tmp);
>   
> -	tmp = RREG32_SOC15(VCN, inst, regUVD_SOFT_RESET);
> -	tmp &= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> -	tmp &= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> -	WREG32_SOC15(VCN, inst, regUVD_SOFT_RESET, tmp);
> +		/* enable VCPU clock */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
> +			UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
>   
> -	/* setup regUVD_LMI_CTRL */
> -	tmp = RREG32_SOC15(VCN, inst, regUVD_LMI_CTRL);
> -	WREG32_SOC15(VCN, inst, regUVD_LMI_CTRL, tmp |
> -		UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
> -		UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
> -		UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
> -		UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
> -
> -	vcn_v5_0_0_mc_resume(adev, inst);
> +		/* disable master interrupt */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_MASTINT_EN), 0,
> +			~UVD_MASTINT_EN__VCPU_EN_MASK);
>   
> -	/* VCN global tiling registers */
> -	WREG32_SOC15(VCN, inst, regUVD_GFX10_ADDR_CONFIG,
> -		adev->gfx.config.gb_addr_config);
> -
> -	/* unblock VCPU register access */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_RB_ARB_CTRL), 0,
> -		~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> -
> -	/* release VCPU reset to boot */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_VCPU_CNTL), 0,
> -		~UVD_VCPU_CNTL__BLK_RST_MASK);
> -
> -	for (j = 0; j < 10; ++j) {
> -		uint32_t status;
> -
> -		for (k = 0; k < 100; ++k) {
> -			status = RREG32_SOC15(VCN, inst, regUVD_STATUS);
> -			if (status & 2)
> -				break;
> -			mdelay(10);
> -			if (amdgpu_emu_mode == 1)
> -				msleep(1);
> -		}
> +		/* enable LMI MC and UMC channels */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_LMI_CTRL2), 0,
> +			~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
> +
> +		tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
> +		tmp &= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> +		tmp &= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> +		WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
> +
> +		/* setup regUVD_LMI_CTRL */
> +		tmp = RREG32_SOC15(VCN, i, regUVD_LMI_CTRL);
> +		WREG32_SOC15(VCN, i, regUVD_LMI_CTRL, tmp |
> +			UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
> +			UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
> +			UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
> +			UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
> +
> +		vcn_v5_0_0_mc_resume(adev, i);
> +
> +		/* VCN global tiling registers */
> +		WREG32_SOC15(VCN, i, regUVD_GFX10_ADDR_CONFIG,
> +			adev->gfx.config.gb_addr_config);
> +
> +		/* unblock VCPU register access */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_RB_ARB_CTRL), 0,
> +			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> +
> +		/* release VCPU reset to boot */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
> +			~UVD_VCPU_CNTL__BLK_RST_MASK);
> +
> +		for (j = 0; j < 10; ++j) {
> +			uint32_t status;
> +
> +			for (k = 0; k < 100; ++k) {
> +				status = RREG32_SOC15(VCN, i, regUVD_STATUS);
> +				if (status & 2)
> +					break;
> +				mdelay(10);
> +				if (amdgpu_emu_mode == 1)
> +					msleep(1);
> +			}
>   
> -		if (amdgpu_emu_mode == 1) {
> -			r = -1;
> -			if (status & 2) {
> +			if (amdgpu_emu_mode == 1) {
> +				r = -1;
> +				if (status & 2) {
> +					r = 0;
> +					break;
> +				}
> +			} else {
>   				r = 0;
> -				break;
> +				if (status & 2)
> +					break;
> +
> +				dev_err(adev->dev,
> +					"VCN[%d] is not responding, trying to reset the VCPU!!!\n", i);
> +				WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
> +							UVD_VCPU_CNTL__BLK_RST_MASK,
> +							~UVD_VCPU_CNTL__BLK_RST_MASK);
> +				mdelay(10);
> +				WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
> +							~UVD_VCPU_CNTL__BLK_RST_MASK);
> +
> +				mdelay(10);
> +				r = -1;
>   			}
> -		} else {
> -			r = 0;
> -			if (status & 2)
> -				break;
> -
> -			dev_err(adev->dev,
> -				"VCN[%d] is not responding, trying to reset the VCPU!!!\n", inst);
> -			WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_VCPU_CNTL),
> -						UVD_VCPU_CNTL__BLK_RST_MASK,
> -						~UVD_VCPU_CNTL__BLK_RST_MASK);
> -			mdelay(10);
> -			WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_VCPU_CNTL), 0,
> -						~UVD_VCPU_CNTL__BLK_RST_MASK);
> -
> -			mdelay(10);
> -			r = -1;
>   		}
> -	}
> -
> -	if (r) {
> -		dev_err(adev->dev, "VCN[%d] is not responding, giving up!!!\n", inst);
> -		return r;
> -	}
> -
> -	/* enable master interrupt */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_MASTINT_EN),
> -			UVD_MASTINT_EN__VCPU_EN_MASK,
> -			~UVD_MASTINT_EN__VCPU_EN_MASK);
> -
> -	/* clear the busy bit of VCN_STATUS */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_STATUS), 0,
> -		~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
> -
> -	ring = &adev->vcn.inst[inst].ring_enc[0];
> -	WREG32_SOC15(VCN, inst, regVCN_RB1_DB_CTRL,
> -		ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
> -		VCN_RB1_DB_CTRL__EN_MASK);
> -
> -	WREG32_SOC15(VCN, inst, regUVD_RB_BASE_LO, ring->gpu_addr);
> -	WREG32_SOC15(VCN, inst, regUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
> -	WREG32_SOC15(VCN, inst, regUVD_RB_SIZE, ring->ring_size / 4);
> -
> -	tmp = RREG32_SOC15(VCN, inst, regVCN_RB_ENABLE);
> -	tmp &= ~(VCN_RB_ENABLE__RB1_EN_MASK);
> -	WREG32_SOC15(VCN, inst, regVCN_RB_ENABLE, tmp);
> -	fw_shared->sq.queue_mode |= FW_QUEUE_RING_RESET;
> -	WREG32_SOC15(VCN, inst, regUVD_RB_RPTR, 0);
> -	WREG32_SOC15(VCN, inst, regUVD_RB_WPTR, 0);
>   
> -	tmp = RREG32_SOC15(VCN, inst, regUVD_RB_RPTR);
> -	WREG32_SOC15(VCN, inst, regUVD_RB_WPTR, tmp);
> -	ring->wptr = RREG32_SOC15(VCN, inst, regUVD_RB_WPTR);
> +		if (r) {
> +			dev_err(adev->dev, "VCN[%d] is not responding, giving up!!!\n", i);
> +			return r;
> +		}
>   
> -	tmp = RREG32_SOC15(VCN, inst, regVCN_RB_ENABLE);
> -	tmp |= VCN_RB_ENABLE__RB1_EN_MASK;
> -	WREG32_SOC15(VCN, inst, regVCN_RB_ENABLE, tmp);
> -	fw_shared->sq.queue_mode &= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
> +		/* enable master interrupt */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_MASTINT_EN),
> +				UVD_MASTINT_EN__VCPU_EN_MASK,
> +				~UVD_MASTINT_EN__VCPU_EN_MASK);
> +
> +		/* clear the busy bit of VCN_STATUS */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_STATUS), 0,
> +			~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
> +
> +		ring = &adev->vcn.inst[i].ring_enc[0];
> +		WREG32_SOC15(VCN, i, regVCN_RB1_DB_CTRL,
> +			ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
> +			VCN_RB1_DB_CTRL__EN_MASK);
> +
> +		WREG32_SOC15(VCN, i, regUVD_RB_BASE_LO, ring->gpu_addr);
> +		WREG32_SOC15(VCN, i, regUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
> +		WREG32_SOC15(VCN, i, regUVD_RB_SIZE, ring->ring_size / 4);
> +
> +		tmp = RREG32_SOC15(VCN, i, regVCN_RB_ENABLE);
> +		tmp &= ~(VCN_RB_ENABLE__RB1_EN_MASK);
> +		WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
> +		fw_shared->sq.queue_mode |= FW_QUEUE_RING_RESET;
> +		WREG32_SOC15(VCN, i, regUVD_RB_RPTR, 0);
> +		WREG32_SOC15(VCN, i, regUVD_RB_WPTR, 0);
> +
> +		tmp = RREG32_SOC15(VCN, i, regUVD_RB_RPTR);
> +		WREG32_SOC15(VCN, i, regUVD_RB_WPTR, tmp);
> +		ring->wptr = RREG32_SOC15(VCN, i, regUVD_RB_WPTR);
> +
> +		tmp = RREG32_SOC15(VCN, i, regVCN_RB_ENABLE);
> +		tmp |= VCN_RB_ENABLE__RB1_EN_MASK;
> +		WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
> +		fw_shared->sq.queue_mode &= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
> +	}
>   
>   	return 0;
>   }
> @@ -943,80 +937,83 @@ static void vcn_v5_0_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
>    * vcn_v5_0_0_stop - VCN stop
>    *
>    * @adev: amdgpu_device pointer
> - * @inst: instance of the VCN block to stop
>    *
>    * Stop VCN block
>    */
> -static int vcn_v5_0_0_stop(struct amdgpu_device *adev, unsigned int inst)
> +static int vcn_v5_0_0_stop(struct amdgpu_device *adev)
>   {
>   	volatile struct amdgpu_vcn5_fw_shared *fw_shared;
>   	uint32_t tmp;
> -	int r = 0;
> +	int i, r = 0;
>   
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		goto done;
> -
> -	fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
> -	fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
> -
> -	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> -		vcn_v5_0_0_stop_dpg_mode(adev, inst);
> -		goto done;
> -	}
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
>   
> -	/* wait for vcn idle */
> -	r = SOC15_WAIT_ON_RREG(VCN, inst, regUVD_STATUS, UVD_STATUS__IDLE, 0x7);
> -	if (r)
> -		return r;
> +		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
> +		fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
>   
> -	tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
> -		  UVD_LMI_STATUS__READ_CLEAN_MASK |
> -		  UVD_LMI_STATUS__WRITE_CLEAN_MASK |
> -		  UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
> -	r = SOC15_WAIT_ON_RREG(VCN, inst, regUVD_LMI_STATUS, tmp, tmp);
> -	if (r)
> -		return r;
> +		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> +			vcn_v5_0_0_stop_dpg_mode(adev, i);
> +			continue;
> +		}
>   
> -	/* disable LMI UMC channel */
> -	tmp = RREG32_SOC15(VCN, inst, regUVD_LMI_CTRL2);
> -	tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
> -	WREG32_SOC15(VCN, inst, regUVD_LMI_CTRL2, tmp);
> -	tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK |
> -		  UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
> -	r = SOC15_WAIT_ON_RREG(VCN, inst, regUVD_LMI_STATUS, tmp, tmp);
> -	if (r)
> -		return r;
> +		/* wait for vcn idle */
> +		r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_STATUS, UVD_STATUS__IDLE, 0x7);
> +		if (r)
> +			return r;
> +
> +		tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
> +		      UVD_LMI_STATUS__READ_CLEAN_MASK |
> +		      UVD_LMI_STATUS__WRITE_CLEAN_MASK |
> +		      UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
> +		r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_LMI_STATUS, tmp, tmp);
> +		if (r)
> +			return r;
> +
> +		/* disable LMI UMC channel */
> +		tmp = RREG32_SOC15(VCN, i, regUVD_LMI_CTRL2);
> +		tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
> +		WREG32_SOC15(VCN, i, regUVD_LMI_CTRL2, tmp);
> +		tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK |
> +		      UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
> +		r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_LMI_STATUS, tmp, tmp);
> +		if (r)
> +			return r;
> +
> +		/* block VCPU register access */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_RB_ARB_CTRL),
> +			UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
> +			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> +
> +		/* reset VCPU */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
> +			UVD_VCPU_CNTL__BLK_RST_MASK,
> +			~UVD_VCPU_CNTL__BLK_RST_MASK);
> +
> +		/* disable VCPU clock */
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
> +			~(UVD_VCPU_CNTL__CLK_EN_MASK));
> +
> +		/* apply soft reset */
> +		tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
> +		tmp |= UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> +		WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
> +		tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
> +		tmp |= UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> +		WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
> +
> +		/* clear status */
> +		WREG32_SOC15(VCN, i, regUVD_STATUS, 0);
> +
> +		/* enable VCN power gating */
> +		vcn_v5_0_0_enable_static_power_gating(adev, i);
> +	}
>   
> -	/* block VCPU register access */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_RB_ARB_CTRL),
> -		UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
> -		~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> -
> -	/* reset VCPU */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_VCPU_CNTL),
> -		UVD_VCPU_CNTL__BLK_RST_MASK,
> -		~UVD_VCPU_CNTL__BLK_RST_MASK);
> -
> -	/* disable VCPU clock */
> -	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_VCPU_CNTL), 0,
> -		~(UVD_VCPU_CNTL__CLK_EN_MASK));
> -
> -	/* apply soft reset */
> -	tmp = RREG32_SOC15(VCN, inst, regUVD_SOFT_RESET);
> -	tmp |= UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> -	WREG32_SOC15(VCN, inst, regUVD_SOFT_RESET, tmp);
> -	tmp = RREG32_SOC15(VCN, inst, regUVD_SOFT_RESET);
> -	tmp |= UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> -	WREG32_SOC15(VCN, inst, regUVD_SOFT_RESET, tmp);
> -
> -	/* clear status */
> -	WREG32_SOC15(VCN, inst, regUVD_STATUS, 0);
> -
> -	/* enable VCN power gating */
> -	vcn_v5_0_0_enable_static_power_gating(adev, inst);
> -done:
> -	if (adev->pm.dpm_enabled)
> -		amdgpu_dpm_enable_vcn(adev, false, inst);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->pm.dpm_enabled)
> +			amdgpu_dpm_enable_vcn(adev, false, i);
> +	}
>   
>   	return 0;
>   }
> @@ -1160,17 +1157,20 @@ static const struct amdgpu_ring_funcs vcn_v5_0_0_unified_ring_vm_funcs = {
>    * vcn_v5_0_0_set_unified_ring_funcs - set unified ring functions
>    *
>    * @adev: amdgpu_device pointer
> - * @inst: instance of the VCN block for which to set the ring functions
>    *
>    * Set unified ring functions
>    */
> -static void vcn_v5_0_0_set_unified_ring_funcs(struct amdgpu_device *adev, int inst)
> +static void vcn_v5_0_0_set_unified_ring_funcs(struct amdgpu_device *adev)
>   {
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		return;
> +	int i;
> +
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
>   
> -	adev->vcn.inst[inst].ring_enc[0].funcs = &vcn_v5_0_0_unified_ring_vm_funcs;
> -	adev->vcn.inst[inst].ring_enc[0].me = inst;
> +		adev->vcn.inst[i].ring_enc[0].funcs = &vcn_v5_0_0_unified_ring_vm_funcs;
> +		adev->vcn.inst[i].ring_enc[0].me = i;
> +	}
>   }
>   
>   /**
> @@ -1205,14 +1205,17 @@ static bool vcn_v5_0_0_is_idle(void *handle)
>   static int vcn_v5_0_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int inst = ip_block->instance;
> -	int ret;
> +	int i, ret = 0;
>   
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		return 0;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
>   
> -	ret = SOC15_WAIT_ON_RREG(VCN, inst, regUVD_STATUS, UVD_STATUS__IDLE,
> -		UVD_STATUS__IDLE);
> +		ret = SOC15_WAIT_ON_RREG(VCN, i, regUVD_STATUS, UVD_STATUS__IDLE,
> +			UVD_STATUS__IDLE);
> +		if (ret)
> +			return ret;
> +	}
>   
>   	return ret;
>   }
> @@ -1220,7 +1223,7 @@ static int vcn_v5_0_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v5_0_0_set_clockgating_state - set VCN block clockgating state
>    *
> - * @ip_block: amdgpu_ip_block pointer
> + * @handle: amdgpu_device pointer
>    * @state: clock gating state
>    *
>    * Set VCN block clockgating state
> @@ -1230,17 +1233,19 @@ static int vcn_v5_0_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
>   	bool enable = (state == AMD_CG_STATE_GATE) ? true : false;
> -	int inst = ip_block->instance;
> +	int i;
>   
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		return 0;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
>   
> -	if (enable) {
> -		if (RREG32_SOC15(VCN, inst, regUVD_STATUS) != UVD_STATUS__IDLE)
> -			return -EBUSY;
> -		vcn_v5_0_0_enable_clock_gating(adev, inst);
> -	} else {
> -		vcn_v5_0_0_disable_clock_gating(adev, inst);
> +		if (enable) {
> +			if (RREG32_SOC15(VCN, i, regUVD_STATUS) != UVD_STATUS__IDLE)
> +				return -EBUSY;
> +			vcn_v5_0_0_enable_clock_gating(adev, i);
> +		} else {
> +			vcn_v5_0_0_disable_clock_gating(adev, i);
> +		}
>   	}
>   
>   	return 0;
> @@ -1249,7 +1254,7 @@ static int vcn_v5_0_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   /**
>    * vcn_v5_0_0_set_powergating_state - set VCN block powergating state
>    *
> - * @ip_block: amdgpu_ip_block pointer
> + * @handle: amdgpu_device pointer
>    * @state: power gating state
>    *
>    * Set VCN block powergating state
> @@ -1258,19 +1263,18 @@ static int vcn_v5_0_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   		enum amd_powergating_state state)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int inst = ip_block->instance;
>   	int ret;
>   
> -	if (state == adev->vcn.inst[inst].cur_state)
> +	if (state == adev->vcn.cur_state)
>   		return 0;
>   
>   	if (state == AMD_PG_STATE_GATE)
> -		ret = vcn_v5_0_0_stop(adev, inst);
> +		ret = vcn_v5_0_0_stop(adev);
>   	else
> -		ret = vcn_v5_0_0_start(adev, inst);
> +		ret = vcn_v5_0_0_start(adev);
>   
>   	if (!ret)
> -		adev->vcn.inst[inst].cur_state = state;
> +		adev->vcn.cur_state = state;
>   
>   	return ret;
>   }
> @@ -1327,74 +1331,80 @@ static const struct amdgpu_irq_src_funcs vcn_v5_0_0_irq_funcs = {
>    * vcn_v5_0_0_set_irq_funcs - set VCN block interrupt irq functions
>    *
>    * @adev: amdgpu_device pointer
> - * @inst: instance of the VCN block for which to set the IRQ functions
>    *
>    * Set VCN block interrupt irq functions
>    */
> -static void vcn_v5_0_0_set_irq_funcs(struct amdgpu_device *adev, int inst)
> +static void vcn_v5_0_0_set_irq_funcs(struct amdgpu_device *adev)
>   {
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		return;
> +	int i;
>   
> -	adev->vcn.inst[inst].irq.num_types = adev->vcn.num_enc_rings + 1;
> -	adev->vcn.inst[inst].irq.funcs = &vcn_v5_0_0_irq_funcs;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
> +
> +		adev->vcn.inst[i].irq.num_types = adev->vcn.num_enc_rings + 1;
> +		adev->vcn.inst[i].irq.funcs = &vcn_v5_0_0_irq_funcs;
> +	}
>   }
>   
>   static void vcn_v5_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int i;
> +	int i, j;
>   	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_5_0);
> -	uint32_t is_powered;
> -	int inst = ip_block->instance;
> +	uint32_t inst_off, is_powered;
>   
> -	if (!ip_block->ip_dump)
> +	if (!adev->vcn.ip_dump)
>   		return;
>   
> -	drm_printf(p, "Instance no:VCN%d\n", inst);
> -
> -	if (adev->vcn.harvest_config & (1 << inst)) {
> -		drm_printf(p, "\nHarvested Instance:VCN%d Skipping dump\n", inst);
> -		return;
> -	}
> +	drm_printf(p, "num_instances:%d\n", adev->vcn.num_vcn_inst);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		if (adev->vcn.harvest_config & (1 << i)) {
> +			drm_printf(p, "\nHarvested Instance:VCN%d Skipping dump\n", i);
> +			continue;
> +		}
>   
> -	is_powered = (ip_block->ip_dump[0] &
> -		      UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
> +		inst_off = i * reg_count;
> +		is_powered = (adev->vcn.ip_dump[inst_off] &
> +				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
>   
> -	if (is_powered) {
> -		drm_printf(p, "\nActive Instance:VCN%d\n", inst);
> -		for (i = 0; i < reg_count; i++)
> -			drm_printf(p, "%-50s \t 0x%08x\n",
> -				   vcn_reg_list_5_0[i].reg_name,
> -				   ip_block->ip_dump[i]);
> -	} else {
> -		drm_printf(p, "\nInactive Instance:VCN%d\n", inst);
> +		if (is_powered) {
> +			drm_printf(p, "\nActive Instance:VCN%d\n", i);
> +			for (j = 0; j < reg_count; j++)
> +				drm_printf(p, "%-50s \t 0x%08x\n", vcn_reg_list_5_0[j].reg_name,
> +					   adev->vcn.ip_dump[inst_off + j]);
> +		} else {
> +			drm_printf(p, "\nInactive Instance:VCN%d\n", i);
> +		}
>   	}
>   }
>   
>   static void vcn_v5_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int i;
> +	int i, j;
>   	bool is_powered;
> +	uint32_t inst_off;
>   	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_5_0);
> -	int inst = ip_block->instance;
>   
> -	if (!ip_block->ip_dump)
> +	if (!adev->vcn.ip_dump)
>   		return;
>   
> -	if (adev->vcn.harvest_config & (1 << inst))
> -		return;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
>   
> -	/* mmUVD_POWER_STATUS is always readable and is first element of the array */
> -	ip_block->ip_dump[0] = RREG32_SOC15(VCN, inst, regUVD_POWER_STATUS);
> -	is_powered = (ip_block->ip_dump[0] &
> -		      UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
> +		inst_off = i * reg_count;
> +		/* mmUVD_POWER_STATUS is always readable and is first element of the array */
> +		adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, regUVD_POWER_STATUS);
> +		is_powered = (adev->vcn.ip_dump[inst_off] &
> +				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
>   
> -	if (is_powered)
> -		for (i = 1; i < reg_count; i++)
> -			ip_block->ip_dump[i] =
> -				RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_5_0[i], inst));
> +		if (is_powered)
> +			for (j = 1; j < reg_count; j++)
> +				adev->vcn.ip_dump[inst_off + j] =
> +					RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_5_0[j], i));
> +	}
>   }
>   
>   static const struct amd_ip_funcs vcn_v5_0_0_ip_funcs = {
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 0f7394a56821..14a4341d4f0f 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -1012,8 +1012,7 @@ int amdgpu_dpm_force_performance_level(struct amdgpu_device *adev,
>   		/* enter UMD Pstate */
>   		amdgpu_device_ip_set_powergating_state(adev,
>   						       AMD_IP_BLOCK_TYPE_GFX,
> -						       AMD_PG_STATE_UNGATE,
> -						       0);
> +						       AMD_PG_STATE_UNGATE);
>   		amdgpu_device_ip_set_clockgating_state(adev,
>   						       AMD_IP_BLOCK_TYPE_GFX,
>   						       AMD_CG_STATE_UNGATE);
> @@ -1025,8 +1024,7 @@ int amdgpu_dpm_force_performance_level(struct amdgpu_device *adev,
>   						       AMD_CG_STATE_GATE);
>   		amdgpu_device_ip_set_powergating_state(adev,
>   						       AMD_IP_BLOCK_TYPE_GFX,
> -						       AMD_PG_STATE_GATE,
> -						       0);
> +						       AMD_PG_STATE_GATE);
>   	}
>   
>   	mutex_lock(&adev->pm.mutex);
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> index e54be4b386f2..67a8e22b1126 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> @@ -1675,7 +1675,7 @@ static void kv_dpm_powergate_uvd(void *handle, bool gate)
>   	if (gate) {
>   		/* stop the UVD block */
>   		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
> -						       AMD_PG_STATE_GATE, 0);
> +						       AMD_PG_STATE_GATE);
>   		kv_update_uvd_dpm(adev, gate);
>   		if (pi->caps_uvd_pg)
>   			/* power off the UVD block */
> @@ -1688,7 +1688,7 @@ static void kv_dpm_powergate_uvd(void *handle, bool gate)
>   		kv_update_uvd_dpm(adev, gate);
>   
>   		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
> -						       AMD_PG_STATE_UNGATE, 0);
> +						       AMD_PG_STATE_UNGATE);
>   	}
>   }
>   
> @@ -1702,7 +1702,7 @@ static void kv_dpm_powergate_vce(void *handle, bool gate)
>   	if (gate) {
>   		/* stop the VCE block */
>   		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
> -						       AMD_PG_STATE_GATE, 0);
> +						       AMD_PG_STATE_GATE);
>   		kv_enable_vce_dpm(adev, false);
>   		if (pi->caps_vce_pg) /* power off the VCE block */
>   			amdgpu_kv_notify_message_to_smu(adev, PPSMC_MSG_VCEPowerOFF);
> @@ -1712,7 +1712,7 @@ static void kv_dpm_powergate_vce(void *handle, bool gate)
>   		kv_enable_vce_dpm(adev, true);
>   		/* re-init the VCE block */
>   		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
> -						       AMD_PG_STATE_UNGATE, 0);
> +						       AMD_PG_STATE_UNGATE);
>   	}
>   }
>   
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> index 41dbf043f59b..a8c732e07006 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> @@ -1407,8 +1407,7 @@ static void smu10_powergate_vcn(struct pp_hwmgr *hwmgr, bool bgate)
>   	if (bgate) {
>   		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
>   						AMD_IP_BLOCK_TYPE_VCN,
> -						AMD_PG_STATE_GATE,
> -						0);
> +						AMD_PG_STATE_GATE);
>   		smum_send_msg_to_smc_with_parameter(hwmgr,
>   					PPSMC_MSG_PowerDownVcn, 0, NULL);
>   		smu10_data->vcn_power_gated = true;
> @@ -1417,8 +1416,7 @@ static void smu10_powergate_vcn(struct pp_hwmgr *hwmgr, bool bgate)
>   						PPSMC_MSG_PowerUpVcn, 0, NULL);
>   		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
>   						AMD_IP_BLOCK_TYPE_VCN,
> -						AMD_PG_STATE_UNGATE,
> -						0);
> +						AMD_PG_STATE_UNGATE);
>   		smu10_data->vcn_power_gated = false;
>   	}
>   }
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.c
> index b496b77153e9..f2bda3bcbbde 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.c
> @@ -120,8 +120,7 @@ void smu7_powergate_uvd(struct pp_hwmgr *hwmgr, bool bgate)
>   	if (bgate) {
>   		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
>   						AMD_IP_BLOCK_TYPE_UVD,
> -						AMD_PG_STATE_GATE,
> -						0);
> +						AMD_PG_STATE_GATE);
>   		amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
>   				AMD_IP_BLOCK_TYPE_UVD,
>   				AMD_CG_STATE_GATE);
> @@ -134,8 +133,7 @@ void smu7_powergate_uvd(struct pp_hwmgr *hwmgr, bool bgate)
>   				AMD_CG_STATE_UNGATE);
>   		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
>   						AMD_IP_BLOCK_TYPE_UVD,
> -						AMD_PG_STATE_UNGATE,
> -						0);
> +						AMD_PG_STATE_UNGATE);
>   		smu7_update_uvd_dpm(hwmgr, false);
>   	}
>   
> @@ -150,8 +148,7 @@ void smu7_powergate_vce(struct pp_hwmgr *hwmgr, bool bgate)
>   	if (bgate) {
>   		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
>   						AMD_IP_BLOCK_TYPE_VCE,
> -						AMD_PG_STATE_GATE,
> -						0);
> +						AMD_PG_STATE_GATE);
>   		amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
>   				AMD_IP_BLOCK_TYPE_VCE,
>   				AMD_CG_STATE_GATE);
> @@ -164,8 +161,7 @@ void smu7_powergate_vce(struct pp_hwmgr *hwmgr, bool bgate)
>   				AMD_CG_STATE_UNGATE);
>   		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
>   						AMD_IP_BLOCK_TYPE_VCE,
> -						AMD_PG_STATE_UNGATE,
> -						0);
> +						AMD_PG_STATE_UNGATE);
>   		smu7_update_vce_dpm(hwmgr, false);
>   	}
>   }
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
> index 2ccce2bc3b4a..7e1197420873 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
> @@ -1985,8 +1985,7 @@ static void smu8_dpm_powergate_uvd(struct pp_hwmgr *hwmgr, bool bgate)
>   	if (bgate) {
>   		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
>   						AMD_IP_BLOCK_TYPE_UVD,
> -						AMD_PG_STATE_GATE,
> -						0);
> +						AMD_PG_STATE_GATE);
>   		amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
>   						AMD_IP_BLOCK_TYPE_UVD,
>   						AMD_CG_STATE_GATE);
> @@ -1999,8 +1998,7 @@ static void smu8_dpm_powergate_uvd(struct pp_hwmgr *hwmgr, bool bgate)
>   						AMD_CG_STATE_UNGATE);
>   		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
>   						AMD_IP_BLOCK_TYPE_UVD,
> -						AMD_PG_STATE_UNGATE,
> -						0);
> +						AMD_PG_STATE_UNGATE);
>   		smu8_dpm_update_uvd_dpm(hwmgr, false);
>   	}
>   
> @@ -2019,8 +2017,7 @@ static void smu8_dpm_powergate_vce(struct pp_hwmgr *hwmgr, bool bgate)
>   	if (bgate) {
>   		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
>   					AMD_IP_BLOCK_TYPE_VCE,
> -					AMD_PG_STATE_GATE,
> -					0);
> +					AMD_PG_STATE_GATE);
>   		amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
>   					AMD_IP_BLOCK_TYPE_VCE,
>   					AMD_CG_STATE_GATE);
> @@ -2035,8 +2032,7 @@ static void smu8_dpm_powergate_vce(struct pp_hwmgr *hwmgr, bool bgate)
>   					AMD_CG_STATE_UNGATE);
>   		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
>   					AMD_IP_BLOCK_TYPE_VCE,
> -					AMD_PG_STATE_UNGATE,
> -					0);
> +					AMD_PG_STATE_UNGATE);
>   		smu8_dpm_update_vce_dpm(hwmgr);
>   		smu8_enable_disable_vce_dpm(hwmgr, true);
>   	}
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
> index 64ef8c8398ff..baf251fe5d82 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
> @@ -3715,13 +3715,11 @@ static void vega20_power_gate_vce(struct pp_hwmgr *hwmgr, bool bgate)
>   		vega20_enable_disable_vce_dpm(hwmgr, !bgate);
>   		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
>   						AMD_IP_BLOCK_TYPE_VCE,
> -						AMD_PG_STATE_GATE,
> -						0);
> +						AMD_PG_STATE_GATE);
>   	} else {
>   		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
>   						AMD_IP_BLOCK_TYPE_VCE,
> -						AMD_PG_STATE_UNGATE,
> -						0);
> +						AMD_PG_STATE_UNGATE);
>   		vega20_enable_disable_vce_dpm(hwmgr, !bgate);
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 41b591ecfb64..2a9f041cf46d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -346,9 +346,8 @@ static int smu_set_mall_enable(struct smu_context *smu)
>    * smu_dpm_set_power_gate - power gate/ungate the specific IP block
>    *
>    * @handle:        smu_context pointer
> - * @block_type:    the IP block to power gate/ungate
> - * @gate:          to power gate if true, ungate otherwise
> - * @inst:          the instance of the IP block to power gate/ungate
> + * @block_type: the IP block to power gate/ungate
> + * @gate:       to power gate if true, ungate otherwise
>    *
>    * This API uses no smu->mutex lock protection due to:
>    * 1. It is either called by other IP block(gfx/sdma/vcn/uvd/vce).
> @@ -2038,8 +2037,7 @@ static int smu_hw_fini(struct amdgpu_ip_block *ip_block)
>   	smu_dpm_set_vpe_enable(smu, false);
>   	smu_dpm_set_umsch_mm_enable(smu, false);
>   
> -	for (int i = 0; i < adev->vcn.num_vcn_inst; ++i)
> -		adev->vcn.inst[i].cur_state = AMD_PG_STATE_GATE;
> +	adev->vcn.cur_state = AMD_PG_STATE_GATE;
>   	adev->jpeg.cur_state = AMD_PG_STATE_GATE;
>   
>   	if (!smu->pm_enabled)

