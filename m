Return-Path: <SRS0=XteM=PG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2D3C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 16:51:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35A0060FC2
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 16:51:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 35A0060FC2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 297FA6E0CB;
	Mon, 18 Oct 2021 16:51:07 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3490A6E0CB
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Oct 2021 16:51:06 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id m22so42772658wrb.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Oct 2021 09:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=Y6E4gcianXOve3YEWtop8KEA9qrKS8WlYN2jNMluCFA=;
 b=AQAnhdwUuvwswBssSA/C99NMqjrVHbnfhLSkUGnsoZOY7/GxUypyxfwCcOGUGdEZS0
 VRt4dkevmIB9K5QLkI08fA6wHGXUZX9k/k3s9KEvJFo7Zca3aCrobxZq6zlafbYc3bSS
 fr9wFVLcHh4PKzZVigNb3hBsu3uoLDn3f8kVc8sSYnoiG4x98FaurFtNVBzEtI3ph0BD
 0yaDh2kZX3YnShcOYmoH7ZMGTWrUMOTJ4Nu79yEwNgJVVIau1UKhzFDgctXHlcidebhB
 I9S7t141+hsjjQdUq6c3sfXgcWEp3e9hUJwKxE2qZ/q2Fp/dVC93AnlZaNTfk8uQXhon
 cD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Y6E4gcianXOve3YEWtop8KEA9qrKS8WlYN2jNMluCFA=;
 b=CjpZ98AmwALdmPMnu5wBj2cLvNzUVbJPvAd5amPhKBW7YxuCrVWI8gB5X4Xyt7kxAQ
 VrxyzaMGrPSK1SGwge6GwmW+uVf3K+Nq7/nskgF5qhT5+zSiLJkHgt7Re85XC7FAbzCE
 GPq6Tpa4Z35x8RJv+c5n/9UFXjl7dok5pli/vU+v8qJ7skGyGRHyUnNAe2muV6IHBMp+
 vOsIKnQbHlv9QACK5GrNXJhpu256J7rikHYEVC3/D6YhwXCjmFQsfJj+6IHQq4O0tlAt
 YvpmYlQgtqIBxuKIA602KozfdafAwqc11t68NZOxI3om/GerZDfFvqqWRmjOVp3eAoVs
 vxuQ==
X-Gm-Message-State: AOAM530sRbLBCGZC4u9KSLVWAOJZF4lVInmWey7Eww416i+Uh47RBZlQ
 20la7KrKhigpVW2IubS24tvSQACDyZc=
X-Google-Smtp-Source: ABdhPJxhv/hMuTDjLpcZh+jcMsVQLlh+9xgK0bvbhemSFo1wq2q3/Ea574sUimPxyxQXUCz1LZW9MA==
X-Received: by 2002:adf:9bd2:: with SMTP id e18mr36424582wrc.235.1634575864721; 
 Mon, 18 Oct 2021 09:51:04 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:bac0:61ed:f1d8:827b?
 ([2a02:908:1252:fb60:bac0:61ed:f1d8:827b])
 by smtp.gmail.com with ESMTPSA id h8sm14786001wrm.27.2021.10.18.09.51.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Oct 2021 09:51:04 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: fix the hang observed on Carrizo due to UVD
 suspend failure
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, bp@alien8.de, "Liu, Leo" <Leo.Liu@amd.com>
References: <20211018073432.1525697-1-evan.quan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <d3de1cb9-71a0-3f10-ede6-784e8c43a133@gmail.com>
Date: Mon, 18 Oct 2021 18:51:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211018073432.1525697-1-evan.quan@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Am 18.10.21 um 09:34 schrieb Evan Quan:
> It's confirmed that on some APUs the interaction with SMU(about DPM disablement)
> will power off the UVD. That will make the succeeding interactions with UVD on the
> suspend path impossible. And the system will hang due to that. To workaround the
> issue, we will skip the UVD(or VCE) power off during interaction with SMU for
> suspend scenario.

Please sync that up with Leo since he is the technical lead for the MM 
engines.

Apart from that it looks ok to me, but that is really not my field of 
expertise.

Regards,
Christian.

>
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: I7804d3835aadbc7cf4b686da4994e83333461748
> ---
>   .../powerplay/hwmgr/smu7_clockpowergating.c   | 20 +++++++++++++++++--
>   .../drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c   | 16 +++++++++++++--
>   drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c     |  4 ++--
>   3 files changed, 34 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.c
> index f2bda3bcbbde..d2c6fe8fe473 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.c
> @@ -57,7 +57,17 @@ static int smu7_update_vce_dpm(struct pp_hwmgr *hwmgr, bool bgate)
>   
>   int smu7_powerdown_uvd(struct pp_hwmgr *hwmgr)
>   {
> -	if (phm_cf_want_uvd_power_gating(hwmgr))
> +	struct amdgpu_device *adev = (struct amdgpu_device *)hwmgr->adev;
> +
> +	/*
> +	 * Further inactions with UVD are still needed on the suspend path. Thus
> +	 * the power off for UVD here should be avoided.
> +	 *
> +	 * TODO: a better solution is to reorg the action chains performed on suspend
> +	 * and make the action here the last one. But that will involve a lot and needs
> +	 * MM team's help.
> +	 */
> +	if (phm_cf_want_uvd_power_gating(hwmgr) && !adev->in_suspend)
>   		return smum_send_msg_to_smc(hwmgr,
>   				PPSMC_MSG_UVDPowerOFF,
>   				NULL);
> @@ -82,7 +92,13 @@ static int smu7_powerup_uvd(struct pp_hwmgr *hwmgr)
>   
>   static int smu7_powerdown_vce(struct pp_hwmgr *hwmgr)
>   {
> -	if (phm_cf_want_vce_power_gating(hwmgr))
> +	struct amdgpu_device *adev = (struct amdgpu_device *)hwmgr->adev;
> +
> +	/*
> +	 * Further inactions with VCE are still needed on the suspend path. Thus
> +	 * the power off for VCE here should be avoided.
> +	 */
> +	if (phm_cf_want_vce_power_gating(hwmgr) && !adev->in_suspend)
>   		return smum_send_msg_to_smc(hwmgr,
>   				PPSMC_MSG_VCEPowerOFF,
>   				NULL);
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
> index b94a77e4e714..09e755980c42 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
> @@ -1247,7 +1247,13 @@ static int smu8_dpm_force_dpm_level(struct pp_hwmgr *hwmgr,
>   
>   static int smu8_dpm_powerdown_uvd(struct pp_hwmgr *hwmgr)
>   {
> -	if (PP_CAP(PHM_PlatformCaps_UVDPowerGating))
> +	struct amdgpu_device *adev = (struct amdgpu_device *)hwmgr->adev;
> +
> +	/*
> +	 * Further inactions with UVD are still needed on the suspend path. Thus
> +	 * the power off for UVD here should be avoided.
> +	 */
> +	if (PP_CAP(PHM_PlatformCaps_UVDPowerGating) && !adev->in_suspend)
>   		return smum_send_msg_to_smc(hwmgr, PPSMC_MSG_UVDPowerOFF, NULL);
>   	return 0;
>   }
> @@ -1301,7 +1307,13 @@ static int  smu8_dpm_update_vce_dpm(struct pp_hwmgr *hwmgr)
>   
>   static int smu8_dpm_powerdown_vce(struct pp_hwmgr *hwmgr)
>   {
> -	if (PP_CAP(PHM_PlatformCaps_VCEPowerGating))
> +	struct amdgpu_device *adev = (struct amdgpu_device *)hwmgr->adev;
> +
> +	/*
> +	 * Further inactions with VCE are still needed on the suspend path. Thus
> +	 * the power off for VCE here should be avoided.
> +	 */
> +	if (PP_CAP(PHM_PlatformCaps_VCEPowerGating) && !adev->in_suspend)
>   		return smum_send_msg_to_smc(hwmgr,
>   					    PPSMC_MSG_VCEPowerOFF,
>   					    NULL);
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c b/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
> index bcae42cef374..4e9c9da255a7 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
> @@ -1683,7 +1683,7 @@ static void kv_dpm_powergate_uvd(void *handle, bool gate)
>   		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
>   						       AMD_PG_STATE_GATE);
>   		kv_update_uvd_dpm(adev, gate);
> -		if (pi->caps_uvd_pg)
> +		if (pi->caps_uvd_pg && !adev->in_suspend)
>   			/* power off the UVD block */
>   			amdgpu_kv_notify_message_to_smu(adev, PPSMC_MSG_UVDPowerOFF);
>   	} else {
> @@ -1710,7 +1710,7 @@ static void kv_dpm_powergate_vce(void *handle, bool gate)
>   		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
>   						       AMD_PG_STATE_GATE);
>   		kv_enable_vce_dpm(adev, false);
> -		if (pi->caps_vce_pg) /* power off the VCE block */
> +		if (pi->caps_vce_pg && !adev->in_suspend) /* power off the VCE block */
>   			amdgpu_kv_notify_message_to_smu(adev, PPSMC_MSG_VCEPowerOFF);
>   	} else {
>   		if (pi->caps_vce_pg) /* power on the VCE block */

