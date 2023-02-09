Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D969C05027
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Feb 2023 08:33:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD36510E94A;
	Thu,  9 Feb 2023 08:33:10 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48B9710E94A
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Feb 2023 08:33:08 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id h16so934273wrz.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Feb 2023 00:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oWKoBMS1MAVqNdhC9jZqFYKv5rwNfGU+ROiKo7GdRZY=;
 b=kNi/oCfE3UE6f+h4DmeVcYDDRObCnpjdqcpLo9sdglAJY7ZMwdNnsQqopbmsd6B2ZG
 haAwBTKrx6i3p7703qJ1RcSKGy5hem1qob9k66P4mnXO6GPXigPGPa5v2Kf/nWzajPIM
 Zc0JXbhC5xtDYHsYWIRSf8PtfB4d1Scy8Aq7wqDEGZQ8nHRafzGymneF++Wrj1pXZVYo
 9ckgfFsWeD+/OhvT15HTbYOzMYTcXIu02tXdbU/h/QJdNQwcYq8ko5cP+isGy+es4lp5
 0+/MljWp5GV7hapGKZWXbGeMic3Gj+DXZ/1a2/Dy5kziig9zdTmbBfcPxz9IXgH9Tn0W
 BZmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oWKoBMS1MAVqNdhC9jZqFYKv5rwNfGU+ROiKo7GdRZY=;
 b=O1OfJmim0fucksjk3fZqEoRnxbiID1dWBT6ZaxCM92t8xYVrikRFC2cy8Zp9pLhi41
 MB4TiqND6pF8ZFc5us2tKdoOQFJC+QXa0fJ7IMUHaQDfzz4fYHXckHSjLjb/DZT5unMn
 XuNV4UdWiX2keaIAmbu3MRFLws/BiQKvIqW0uqYVVnTcC4BAQb42sANJMy3/mgYP8/Bl
 tl+RajW7c+chGpHVZgoDsWw4AYhKgi3dUBHpprsRNsRP1PESUVy5JxcYGrCu6FehDMjM
 xXTxNbUwFv/pD5Ff0z3TKBaE3e3IHRu/zYyBB6AqQN9nt9l0JjBM4bFmhRRYK79oTVzO
 K8GA==
X-Gm-Message-State: AO0yUKX70hTa+/ElZ4IEsZ0mhi30/sPsCnFnRVd1L8LwNr4MWOSWgW7V
 6N8Eha1zAHYAhOz/WYJXHDw=
X-Google-Smtp-Source: AK7set+eAflHSSc1vDwI6C9u5ZgK5/SjlOrNYHhzR3f2Mfao4VcJffj9wcTkjZWLLhRAhwtdweIGkg==
X-Received: by 2002:a5d:4d45:0:b0:2c4:60d:41fa with SMTP id
 a5-20020a5d4d45000000b002c4060d41famr3800000wru.24.1675931586868; 
 Thu, 09 Feb 2023 00:33:06 -0800 (PST)
Received: from [192.168.178.21] (p5b0ea2e7.dip0.t-ipconnect.de.
 [91.14.162.231]) by smtp.gmail.com with ESMTPSA id
 s9-20020adfecc9000000b002c3e9cce04csm631709wro.111.2023.02.09.00.33.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Feb 2023 00:33:06 -0800 (PST)
Message-ID: <9fef9d86-6c77-8906-6ccf-b81c0f6e6665@gmail.com>
Date: Thu, 9 Feb 2023 09:33:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/2] drm/amd/display: minor cleanup of vm_setup
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230209044616.560657-1-alexander.deucher@amd.com>
 <20230209044616.560657-2-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230209044616.560657-2-alexander.deucher@amd.com>
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

Am 09.02.23 um 05:46 schrieb Alex Deucher:
> Use fb_start/end for consistency with gmc code for non-
> XGMI systems, they are equivalent to vram_start/end.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 8ba4a57d8e6f..bf06875e6a01 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1191,7 +1191,7 @@ static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_
>   
>   	/* AGP aperture is disabled */
>   	if (agp_bot == agp_top) {
> -		logical_addr_low  = adev->gmc.vram_start >> 18;
> +		logical_addr_low = adev->gmc.fb_start >> 18;
>   		if (adev->apu_flags & AMD_APU_IS_RAVEN2)
>   			/*
>   			 * Raven2 has a HW issue that it is unable to use the vram which
> @@ -1201,9 +1201,9 @@ static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_
>   			 */
>   			logical_addr_high = (adev->gmc.fb_end >> 18) + 0x1;
>   		else
> -			logical_addr_high = adev->gmc.vram_end >> 18;
> +			logical_addr_high = adev->gmc.fb_end >> 18;
>   	} else {
> -		logical_addr_low  = min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18;
> +		logical_addr_low = min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18;
>   		if (adev->apu_flags & AMD_APU_IS_RAVEN2)
>   			/*
>   			 * Raven2 has a HW issue that it is unable to use the vram which

