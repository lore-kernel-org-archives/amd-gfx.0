Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B121CDDE53
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2024 10:00:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD71D10E7BA;
	Wed, 23 Oct 2024 10:00:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="YnlerEJI";
	dkim-atps=neutral
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 791C910E7BB
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2024 10:00:08 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4XYPfr6bJsz9t2T;
 Wed, 23 Oct 2024 12:00:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1729677604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7rj8ZVx/ouH9kdGv5H0MTx2AbW7YXsWAKsPeTr03asY=;
 b=YnlerEJIFSM3GvPp9CSylrJxTg3CxT16v03Z0AWVqox3xHFNisEMp3uYBauZfseWGBBBfk
 9OcT7aY8Sz78zuDCsJ1uLHh0XeRNbIj7cGE2HWhxJZIstDkgKy/FUiIT3KE89E+FxFmhhH
 fhK4HBbVOuIIoWcXwyh1OxtR7zYiADztDRez+lCdkfQMoHtj0Dz4aYeJpVeKyG9HyPP9wq
 L2mb64uwzbMAmIX97dAyy98C4GJTNwd6teVopfI1MA+n8yRrQTWMpuJpEGZIziNg9hGzPA
 XmG+qtmoqXauch5mTkppn3ntv8wPJNUuhLhAnAggKseusch38A55QEgrOu21HQ==
Message-ID: <49c0bb33-eba8-44b7-994d-ae1a579476da@mailbox.org>
Date: Wed, 23 Oct 2024 12:00:02 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] drm/amdgpu: handle default profile on on devices without
 fullscreen 3D
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Kenneth Feng <kenneth.feng@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
References: <20241022135043.2638637-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <20241022135043.2638637-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 76doj4bj7nyphbi3z4chrbx4d3rewwn8
X-MBO-RS-ID: 0d161d04db188afc8c3
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

On 2024-10-22 15:50, Alex Deucher wrote:
> Some devices do not support fullscreen 3D.
> 
> v2: Make the check generic.
> 
> Fixes: 336568de918e ("drm/amdgpu/swsmu: default to fullscreen 3D profile for dGPUs")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Kenneth Feng <kenneth.feng@amd.com>
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index accc96a03bd9..8d4aee4e2287 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1236,6 +1236,14 @@ static void smu_init_xgmi_plpd_mode(struct smu_context *smu)
>  	}
>  }
>  
> +static bool smu_is_workload_profile_available(struct smu_context *smu,
> +					      u32 profile)
> +{
> +	if (profile >= PP_SMC_POWER_PROFILE_COUNT)
> +		return false;
> +	return smu->workload_map && smu->workload_map[profile].valid_mapping;
> +}
> +
>  static int smu_sw_init(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
> @@ -1267,7 +1275,8 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
>  	smu->workload_prority[PP_SMC_POWER_PROFILE_COMPUTE] = 5;
>  	smu->workload_prority[PP_SMC_POWER_PROFILE_CUSTOM] = 6;
>  
> -	if (smu->is_apu)
> +	if (smu->is_apu ||
> +	    !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFILE_FULLSCREEN3D))
>  		smu->workload_mask = 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];
>  	else
>  		smu->workload_mask = 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D];

FWIW, PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT isn't really suitable for compositing with an APU either (certainly not while the machine is connected to AC, though I'm getting good battery life even forcing the compute profile).


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
