Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8841FF8873
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2026 17:56:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6434A10E24B;
	Thu, 30 Apr 2026 17:56:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="TX5TX64A";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6022310E24B
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2026 17:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=l4ECbjufxmHx1im11gDHsXdxI2u54dk2ebCqfhY4DB8=; b=TX5TX64A4Q3FSrBl3F5+b80Sr/
 tYP1gk7ataKzXKqc5GYoYFrPmXVLWuxuURZFZS863tvHZaRqG7CwIiWTpO6EPtj/DQdzDQujSud9a
 bIsCc0wvi8cqVzax0Jc95K2FgQOYpgT1tk9zCVRgmr9nwKoCnC1Eehg8wAaMxa/dopNIgfbcxqdNl
 dHXymN5rBDCOoArKBtA6uPw0rp8IUwAbQvPV97aMtXBQMlsdhkBobOH/l9iHWD4Xpl+iPR3Xh2WdL
 NzbTvTvhmMopghR8A5lPSUS/IkRjAQfQBkeJR1FN/t2qIoxRgc+QyG+u2Ev20zyIanNQiEZP7XvH9
 7UABHiZg==;
Received: from [186.208.73.228] (helo=[192.168.18.14])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wIVcX-004XRI-TX; Thu, 30 Apr 2026 19:56:17 +0200
Message-ID: <a7b0800b-ead1-4f90-a36b-ce82af501b93@igalia.com>
Date: Thu, 30 Apr 2026 14:56:12 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/14] drm/amd/pm: Delete unused get_display_power_level()
 function
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Roman Li <Roman.Li@amd.com>, Leo Li <sunpeng.li@amd.com>,
 David Airlie <airlied@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>
References: <20260423191519.73127-1-timur.kristof@gmail.com>
 <20260423191519.73127-10-timur.kristof@gmail.com>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <20260423191519.73127-10-timur.kristof@gmail.com>
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



On 23/04/2026 16:15, Timur Kristóf wrote:
> Was not called from anywhere.
LGTM.

Reviewed-by: Melissa Wen <mwen@igalia.com>
>
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>   drivers/gpu/drm/amd/include/kgd_pp_interface.h   |  2 --
>   drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c | 12 ------------
>   2 files changed, 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> index 1bbf531de5ed7..ac05a12e71bdf 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -476,8 +476,6 @@ struct amd_pm_funcs {
>   	u32 (*get_mclk)(void *handle, bool low);
>   	int (*display_configuration_change)(void *handle,
>   		const struct amd_pp_display_configuration *input);
> -	int (*get_display_power_level)(void *handle,
> -		struct amd_pp_simple_clock_info *output);
>   	int (*get_current_clocks)(void *handle,
>   		struct amd_pp_clock_info *clocks);
>   	int (*get_clock_by_type)(void *handle,
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> index 0bbb89788335e..4c2c40e8123bf 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> @@ -1020,17 +1020,6 @@ static int pp_display_configuration_change(void *handle,
>   	return 0;
>   }
>   
> -static int pp_get_display_power_level(void *handle,
> -		struct amd_pp_simple_clock_info *output)
> -{
> -	struct pp_hwmgr *hwmgr = handle;
> -
> -	if (!hwmgr || !hwmgr->pm_en || !output)
> -		return -EINVAL;
> -
> -	return phm_get_dal_power_level(hwmgr, output);
> -}
> -
>   static int pp_get_current_clocks(void *handle,
>   		struct amd_pp_clock_info *clocks)
>   {
> @@ -1588,7 +1577,6 @@ static const struct amd_pm_funcs pp_dpm_funcs = {
>   	.get_sclk = pp_dpm_get_sclk,
>   	.get_mclk = pp_dpm_get_mclk,
>   	.display_configuration_change = pp_display_configuration_change,
> -	.get_display_power_level = pp_get_display_power_level,
>   	.get_current_clocks = pp_get_current_clocks,
>   	.get_clock_by_type = pp_get_clock_by_type,
>   	.get_clock_by_type_with_latency = pp_get_clock_by_type_with_latency,

