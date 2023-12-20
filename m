Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF652C3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Dec 2023 14:10:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4802E10E598;
	Wed, 20 Dec 2023 14:10:43 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC61E10E598
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Dec 2023 14:10:41 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40c31f18274so72071835e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Dec 2023 06:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703081440; x=1703686240; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XkHP0OXR9/NkH0UJW0LEpBaw1BMEL00sdUol2sBJPyk=;
 b=XZR36TBHllSLKEY/ftntqFI+vkX+e/8BNHKnfOuAUJdNs3nN43VkY3KwqFOPz6wSQt
 mHxWYTAzQWAvFcWW/3tCaktt43qVwGMnlSHhQ0kugKYJ34roXuiqVpNGsPnYJRcoyD9P
 sDrpkYPSAnY30Qnz0ygG1F6ZZkspuqtK0BsLsxe9+Ok1ZrBGiHeu4Ew6X39dVg8jaVSP
 jJyY3vIkTvTqLLRikfKY7/5mU8VkCiIHQExMhtbUWq2wJ8KHzUSSjHY4Xfx+9nP1PSON
 xERLJAACrTAe95xf0/VlGGrjVPKqAPx73zNd/ptKJ4KIsaeA7Q8kQeajfv8J/DklCZ4q
 HWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703081440; x=1703686240;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XkHP0OXR9/NkH0UJW0LEpBaw1BMEL00sdUol2sBJPyk=;
 b=oobla0pYpZyaFUYRHY9bQMm0Thy1hxTySFJz+x5CnEI/aC0vP4M5EH4dTZ74Lz+Q1M
 LguCt/johjQSlibDQSgemoc46av6Ku2GWLDrHkJlgd8L5wWJLjjHvusMvJmNS5QCnS8j
 OXP7weRZ05vPabn6BLqwSfLn/IyC+QUxvhnQhz05HWg2TTZN6XyCA4NBfFSj6eM2wNpg
 fcNwlad66m4tQXpvT7+1arPdhmDSmQancdW2ZvfKujlCpe9XI4WwNkNGc++0lhvV+NiS
 R+/pO14puEJp0lRILEClcIFST+6uQhtLOUXp+72yVF7OTcioQnV8IAsmI86WFp/HjYYX
 A0DA==
X-Gm-Message-State: AOJu0YypoFIKF7PTZp9UXDjV+TnVtH8LcosxoUmgS6LWHqsP8jypc3N5
 IAqtUbu4mYTJsGxqoobIKIHGI6fiyaI=
X-Google-Smtp-Source: AGHT+IG/ezY0+grNcaz3jp69fB/PBU9cSiMnV9awng8O4kiu5DgST6F++E117gfTcyGB4m3ECdz/ug==
X-Received: by 2002:a05:600c:2d4c:b0:40c:a15:eeef with SMTP id
 a12-20020a05600c2d4c00b0040c0a15eeefmr9251757wmg.62.1703081439979; 
 Wed, 20 Dec 2023 06:10:39 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 bg5-20020a05600c3c8500b0040c4c9c52a3sm7612728wmb.12.2023.12.20.06.10.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Dec 2023 06:10:39 -0800 (PST)
Message-ID: <5c64d777-510d-4440-b1b6-aaccd7bb71a0@gmail.com>
Date: Wed, 20 Dec 2023 15:10:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Check resize bar register when system uses
 large bar
Content-Language: en-US
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231219055802.304678-1-Jun.Ma2@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20231219055802.304678-1-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: Alexander.Deucher@amd.com, mario.limonciello@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 19.12.23 um 06:58 schrieb Ma Jun:
> Print a warnning message if the system can't access
> the resize bar register when using large bar.

Well pretty clear NAK, we have embedded use cases where this would 
trigger an incorrect warning.

What should that be good for in the first place?

Regards,
Christian.

>
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 4b694696930e..e7aedb4bd66e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1417,6 +1417,12 @@ void amdgpu_device_wb_free(struct amdgpu_device *adev, u32 wb)
>   		__clear_bit(wb, adev->wb.used);
>   }
>   
> +static inline void amdgpu_find_rb_register(struct amdgpu_device *adev)
> +{
> +	if (!pci_find_ext_capability(adev->pdev, PCI_EXT_CAP_ID_REBAR))
> +		DRM_WARN("System can't access the resize bar register,please check!!\n");
> +}
> +
>   /**
>    * amdgpu_device_resize_fb_bar - try to resize FB BAR
>    *
> @@ -1444,8 +1450,10 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
>   
>   	/* skip if the bios has already enabled large BAR */
>   	if (adev->gmc.real_vram_size &&
> -	    (pci_resource_len(adev->pdev, 0) >= adev->gmc.real_vram_size))
> +	    (pci_resource_len(adev->pdev, 0) >= adev->gmc.real_vram_size)) {
> +		amdgpu_find_rb_register(adev);
>   		return 0;
> +	}
>   
>   	/* Check if the root BUS has 64bit memory resources */
>   	root = adev->pdev->bus;

