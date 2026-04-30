Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5CB3CD13DA
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2026 19:04:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 891BA10E463;
	Thu, 30 Apr 2026 19:04:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="sLjdhc6R";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51BC610E463
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2026 19:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=k9nuIkfOO2MqoiwSPLPXjWQ+wQjpO/CWTjkMlIqgQVI=; b=sLjdhc6R5jqDGyrPGbm1Lv3KiY
 YFmW4lDiKwcdQHNf55ikG/6xHnOn0mhmJFWIdfz0Rkj9I7tc9AiLWS+dJZA7ut6+eVWpNIydxCYNr
 AF3j0oQorcF9mXgPigM4K02NJJsbsWUzYgq9X/Ug+UOxw28nHdk7HKnSIUxuz+LF4DXyHmsFP9fA2
 wfR4N/+3JXBFU+aJl6xcuCNs82RMDyhPPe9cL7AnRfOWkhDdugGf8yhCEZM8umv788VveKy4vaSfd
 v7wQlSNXLzNSveUjKP8tSxLIeHB/ta2zXRn7co2tlTJcw391q7Dtt3KVAYElz0zugbfeLPYZxtX0O
 P5AIyX5A==;
Received: from [186.208.73.228] (helo=[192.168.18.14])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wIWgz-004YfB-65; Thu, 30 Apr 2026 21:04:56 +0200
Message-ID: <3a09587d-edec-40cc-b4f0-4098c49e0136@igalia.com>
Date: Thu, 30 Apr 2026 16:04:52 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/14] drm/amd/pm: Delete PP_DAL_POWERLEVEL
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Roman Li <Roman.Li@amd.com>, Leo Li <sunpeng.li@amd.com>,
 David Airlie <airlied@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>
References: <20260423191519.73127-1-timur.kristof@gmail.com>
 <20260423191519.73127-15-timur.kristof@gmail.com>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <20260423191519.73127-15-timur.kristof@gmail.com>
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
> Not used and not needed anymore.

Reviewed-by: Melissa Wen <mwen@igalia.com>

>
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>   drivers/gpu/drm/amd/include/dm_pp_interface.h | 18 ------------------
>   1 file changed, 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/include/dm_pp_interface.h b/drivers/gpu/drm/amd/include/dm_pp_interface.h
> index 10747a1ceda9a..e3d40fb371039 100644
> --- a/drivers/gpu/drm/amd/include/dm_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/dm_pp_interface.h
> @@ -115,23 +115,6 @@ struct amd_pp_simple_clock_info {
>   	uint32_t	memory_max_clock;
>   };
>   
> -enum PP_DAL_POWERLEVEL {
> -	PP_DAL_POWERLEVEL_INVALID = 0,
> -	PP_DAL_POWERLEVEL_ULTRALOW,
> -	PP_DAL_POWERLEVEL_LOW,
> -	PP_DAL_POWERLEVEL_NOMINAL,
> -	PP_DAL_POWERLEVEL_PERFORMANCE,
> -
> -	PP_DAL_POWERLEVEL_0 = PP_DAL_POWERLEVEL_ULTRALOW,
> -	PP_DAL_POWERLEVEL_1 = PP_DAL_POWERLEVEL_LOW,
> -	PP_DAL_POWERLEVEL_2 = PP_DAL_POWERLEVEL_NOMINAL,
> -	PP_DAL_POWERLEVEL_3 = PP_DAL_POWERLEVEL_PERFORMANCE,
> -	PP_DAL_POWERLEVEL_4 = PP_DAL_POWERLEVEL_3+1,
> -	PP_DAL_POWERLEVEL_5 = PP_DAL_POWERLEVEL_4+1,
> -	PP_DAL_POWERLEVEL_6 = PP_DAL_POWERLEVEL_5+1,
> -	PP_DAL_POWERLEVEL_7 = PP_DAL_POWERLEVEL_6+1,
> -};
> -
>   struct amd_pp_clock_info {
>   	uint32_t min_engine_clock;
>   	uint32_t max_engine_clock;
> @@ -141,7 +124,6 @@ struct amd_pp_clock_info {
>   	uint32_t max_bus_bandwidth;
>   	uint32_t max_engine_clock_in_sr;
>   	uint32_t min_engine_clock_in_sr;
> -	enum PP_DAL_POWERLEVEL max_clocks_state;
>   };
>   
>   enum amd_pp_clock_type {

