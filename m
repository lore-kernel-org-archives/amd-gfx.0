Return-Path: <SRS0=uIzi=PX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03196C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 08:24:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B129360240
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 08:24:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B129360240
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5700E6EC05;
	Thu,  4 Nov 2021 08:24:08 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B4CB6EC05
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Nov 2021 08:24:07 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id c4so7289921wrd.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Nov 2021 01:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=G15OOHt2z9zqIJ/X77c2G+WNcLuFMB/Dl0uvjlvigqg=;
 b=N2MWM0M7lTFTv/bQGnXpJHk4sQce0gOqgPI2xWfH+hn5ZKq3CEeCzQhUWmRqxDYBri
 9Le2raAdM886GgRoa+YUQLBzod0CPAFRzrsc3yngcUfRNqJ9IG1TfR5ESojtxSz69klb
 Pye0ZjVg9267efb7l84BluoVgsSh4YdcvbgvVaJDtIwT7qrsjNKTrOCmBcQYRoYBqcUo
 WQQ0ZVHXWW0WgvPFkTbXA8lJeANJ27tBA2JMjRmckQCkh6WBdIlqN4FSwtIjbnkLgumi
 Iw4El5GJQKfhrgIDi5T7I4Yz629c861b/yqd9boSdRX0PvRi4mCPwfzYeg/MiGzhOXdr
 QQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=G15OOHt2z9zqIJ/X77c2G+WNcLuFMB/Dl0uvjlvigqg=;
 b=jhYe7iJohID3HlxtkBUdmeM/LNVw9CYycFyrERvphqhGK1iKMYOioeROEwFXxRRFBa
 QhzaQOBYwMJQjQygCj8v4wzPdpN0zIV0cTWGY5Qv4mJp0pXLWJUzdbu6Q9nkNeNPZr/k
 BZxi/yhVyx+XYExngQVDzRxYqalbIvycYzqy4dzNNAvUgVIJmteCOhHtGLr5iwFQMaim
 HSmiInD4tVQqIn6x25ZAe6CLfvq/xt5GcTSrnNqGNOIFtCDoImttgn4kHh0dY/u1osZD
 RmjT+7u2tQwi2eOrPC3VCdksew889DzPIyX5XBDdtILHIsZJ39VRw9y70vWYNquxR9Rb
 6ZxQ==
X-Gm-Message-State: AOAM5302bCVJIr/HoX1g/CHceQz/oyp18R2pMwoDa0tzCUseq1wdxiqL
 v4qZ50fcWHkT+s7bs5hWg4M=
X-Google-Smtp-Source: ABdhPJxGmROMvmqgZqwqwO/97SB+2uKcE4NI9APy1usXB0AsYgtR9Kdh1jedzYt6mROK0i07Xf41Rg==
X-Received: by 2002:adf:fc88:: with SMTP id g8mr33393877wrr.334.1636014246107; 
 Thu, 04 Nov 2021 01:24:06 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea1b5.dip0.t-ipconnect.de.
 [91.14.161.181])
 by smtp.gmail.com with ESMTPSA id j10sm4219501wru.15.2021.11.04.01.24.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Nov 2021 01:24:05 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: fix the Carrizo UVD hang on system reboot
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org,
 "Liu, Leo" <Leo.Liu@amd.com>
References: <20211104081931.467399-1-evan.quan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <77101538-4889-8665-448e-4177abb29d25@gmail.com>
Date: Thu, 4 Nov 2021 09:24:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211104081931.467399-1-evan.quan@amd.com>
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 04.11.21 um 09:19 schrieb Evan Quan:
> It's confirmed that on some APUs the interaction with SMU about DPM disablement
> will power off the UVD completely. Thus the succeeding interactions with UVD
> during the reboot will trigger hard hang. To workaround this issue, we will skip
> the dpm disablement on APUs.
>
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: I4340cc2fb0fd94f439cbac5d4963fe920866bc13

Acked-by: Christian König <christian.koenig@amd.com>

But Leo should take a look as well, adding him on CC.

Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c | 20 ++++++++++--------
>   drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c | 30 +++++++++++++++++++--------
>   drivers/gpu/drm/amd/amdgpu/vce_v2_0.c | 18 +++++++++-------
>   drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 18 +++++++++-------
>   4 files changed, 52 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> index c108b8381795..67ec13622e51 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> @@ -238,15 +238,17 @@ static int uvd_v4_2_suspend(void *handle)
>   	 */
>   	cancel_delayed_work_sync(&adev->uvd.idle_work);
>   
> -	if (adev->pm.dpm_enabled) {
> -		amdgpu_dpm_enable_uvd(adev, false);
> -	} else {
> -		amdgpu_asic_set_uvd_clocks(adev, 0, 0);
> -		/* shutdown the UVD block */
> -		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
> -						       AMD_PG_STATE_GATE);
> -		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
> -						       AMD_CG_STATE_GATE);
> +	if (!(adev->flags & AMD_IS_APU)) {
> +		if (adev->pm.dpm_enabled) {
> +			amdgpu_dpm_enable_uvd(adev, false);
> +		} else {
> +			amdgpu_asic_set_uvd_clocks(adev, 0, 0);
> +			/* shutdown the UVD block */
> +			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
> +							       AMD_PG_STATE_GATE);
> +			amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
> +							       AMD_CG_STATE_GATE);
> +		}
>   	}
>   
>   	r = uvd_v4_2_hw_fini(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> index 2d558c2f417d..60d05ec8c953 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> @@ -560,15 +560,27 @@ static int uvd_v6_0_suspend(void *handle)
>   	 */
>   	cancel_delayed_work_sync(&adev->uvd.idle_work);
>   
> -	if (adev->pm.dpm_enabled) {
> -		amdgpu_dpm_enable_uvd(adev, false);
> -	} else {
> -		amdgpu_asic_set_uvd_clocks(adev, 0, 0);
> -		/* shutdown the UVD block */
> -		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
> -						       AMD_PG_STATE_GATE);
> -		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
> -						       AMD_CG_STATE_GATE);
> +	/*
> +	 * It's confirmed that on some APUs the interaction with SMU(about DPM disablement)
> +	 * will power off the UVD. That will make the succeeding interactions with UVD on the
> +	 * suspend path impossible. And the system will hang due to that. To workaround the
> +	 * issue, we will skip the dpm disablement on APUs.
> +	 *
> +	 * TODO: a better solution is to reorg the action chains performed on suspend and make
> +	 * the dpm disablement the last one. But that will involve a lot and needs MM team's
> +	 * help.
> +	 */
> +	if (!(adev->flags & AMD_IS_APU)) {
> +		if (adev->pm.dpm_enabled) {
> +			amdgpu_dpm_enable_uvd(adev, false);
> +		} else {
> +			amdgpu_asic_set_uvd_clocks(adev, 0, 0);
> +			/* shutdown the UVD block */
> +			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
> +							       AMD_PG_STATE_GATE);
> +			amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
> +							       AMD_CG_STATE_GATE);
> +		}
>   	}
>   
>   	r = uvd_v6_0_hw_fini(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> index 67eb01fef789..8aa9d8c07053 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> @@ -505,14 +505,16 @@ static int vce_v2_0_suspend(void *handle)
>   	 */
>   	cancel_delayed_work_sync(&adev->vce.idle_work);
>   
> -	if (adev->pm.dpm_enabled) {
> -		amdgpu_dpm_enable_vce(adev, false);
> -	} else {
> -		amdgpu_asic_set_vce_clocks(adev, 0, 0);
> -		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
> -						       AMD_PG_STATE_GATE);
> -		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
> -						       AMD_CG_STATE_GATE);
> +	if (!(adev->flags & AMD_IS_APU)) {
> +		if (adev->pm.dpm_enabled) {
> +			amdgpu_dpm_enable_vce(adev, false);
> +		} else {
> +			amdgpu_asic_set_vce_clocks(adev, 0, 0);
> +			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
> +							       AMD_PG_STATE_GATE);
> +			amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
> +							       AMD_CG_STATE_GATE);
> +		}
>   	}
>   
>   	r = vce_v2_0_hw_fini(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> index 142e291983b4..b177cd442838 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> @@ -520,14 +520,16 @@ static int vce_v3_0_suspend(void *handle)
>   	 */
>   	cancel_delayed_work_sync(&adev->vce.idle_work);
>   
> -	if (adev->pm.dpm_enabled) {
> -		amdgpu_dpm_enable_vce(adev, false);
> -	} else {
> -		amdgpu_asic_set_vce_clocks(adev, 0, 0);
> -		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
> -						       AMD_PG_STATE_GATE);
> -		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
> -						       AMD_CG_STATE_GATE);
> +	if (!(adev->flags & AMD_IS_APU)) {
> +		if (adev->pm.dpm_enabled) {
> +			amdgpu_dpm_enable_vce(adev, false);
> +		} else {
> +			amdgpu_asic_set_vce_clocks(adev, 0, 0);
> +			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
> +							       AMD_PG_STATE_GATE);
> +			amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
> +							       AMD_CG_STATE_GATE);
> +		}
>   	}
>   
>   	r = vce_v3_0_hw_fini(adev);

