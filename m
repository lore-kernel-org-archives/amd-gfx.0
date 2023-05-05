Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85DEAC77B75
	for <amd-gfx@archiver.kernel.org>; Fri,  5 May 2023 08:24:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD4C310E59F;
	Fri,  5 May 2023 08:24:18 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63C4210E59F
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 May 2023 08:24:16 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-50bc3a2d333so2216357a12.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 May 2023 01:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1683275054; x=1685867054;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5urbXRiXfvxb/KP4mStds3yp9nqK+u/OMfebhcFr9K4=;
 b=PLzoOd3JEOcygwkXi/IhZQGZA1y1QIazJ2DkoYTKgyr5i9HkKN34QIWvlaHsOGvWNR
 G8ie9W/XOv7wTOQCkveiHMomoj1zOYrSs3XWaphgrALFNbAagPfyxwHVeiMSCGE56EaO
 M3J7snPkTwgu5gteN5IEzcgRE89YLa2Kgv8Yn2+8KorCYr87k8VXPa2Q/lUk4vqY9wX6
 /Bgm/O9LepUJipENAr7/H1gAZ2zQKm3CfKS2G2Uel/U792jLCvRk88+1xVMp2k5lZnWj
 ers2XqaYrFfTysj/uw7wObSS9A3Pk7m3+XthxvIS6H3oKqzRfsLteJqd0X5+LqD9fWFK
 8neA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683275054; x=1685867054;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5urbXRiXfvxb/KP4mStds3yp9nqK+u/OMfebhcFr9K4=;
 b=evAuADMAi2l1OM8cI4E04feLHcj0zz+hqqhqEew+gEYqPoZAPmXGdrE8YbX0ydVU+6
 X+CghqWVGdCo10sEWvQ4UxGVM499Em/siBzJ58pxZIkxxAPo2bMCGS5sSc12Wnd0N57k
 r3DgHe1xUrITm4tbsSf9balW+YiXg9FOj+fqAuYKG4JJLgAeyu+WBZ1c0aTgyy46DQ4O
 94pZwLY9CkLgYWznDB3WUwmWaKBG4GbrG5KLk7Yufh35mG++zml6BauLxaQRj9s3nTbr
 EKVO1P2eccJIXAsLEar2AO/cXdDfnhTz6ABKDtylAxNLUAvUpDGt/41ecRvumb0WUvyw
 rL/Q==
X-Gm-Message-State: AC+VfDyIKo5rX7H9jS0BgXAu7ZCJKPpZcA0nwNxqGdfopV/QdoyhRm3p
 ckXxnWGhl7y54lMPl/w3DFK1NvwPCzA=
X-Google-Smtp-Source: ACHHUZ4AYVVm/twvM+53+NiM5qtzIiPIsU7E5WmT2ApcgpSQA5NxC+UGYYAfmULSyxYvZUBS9YtYMg==
X-Received: by 2002:a05:6402:c:b0:50b:d668:f475 with SMTP id
 d12-20020a056402000c00b0050bd668f475mr706204edu.16.1683275053953; 
 Fri, 05 May 2023 01:24:13 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:e2f8:820b:7a40:97ca?
 ([2a02:908:1256:79a0:e2f8:820b:7a40:97ca])
 by smtp.gmail.com with ESMTPSA id
 u3-20020aa7d883000000b00504ecc4fa96sm2673425edq.95.2023.05.05.01.24.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 May 2023 01:24:13 -0700 (PDT)
Message-ID: <1cf2d2d9-7bb3-4dad-e276-7e72905effbb@gmail.com>
Date: Fri, 5 May 2023 10:24:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] drm/amdgpu: Fix vram recover doesn't work after whole GPU
 reset
Content-Language: en-US
To: "Lin.Cao" <lincao12@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230505034655.1077755-1-lincao12@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230505034655.1077755-1-lincao12@amd.com>
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
Cc: zhenguo.yin@amd.com, jingwen.chen2@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 05.05.23 um 05:46 schrieb Lin.Cao:
> v1: Vmbo->shadow is used to back vram bo up when vram lost. So that we
> should set shadow as vmbo->shadow to recover vmbo->bo
> v2: Modify if(vmbo->shadow) shadow = vmbo->shadow as if(!vmbo->shadow)
> continue;
>
> Fix: 'commit e18aaea733da ("drm/amdgpu: move shadow_list to amdgpu_bo_vm")'
> Signed-off-by: Lin.Cao <lincao12@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 750eaffa81ba..0581b4fec001 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4514,7 +4514,12 @@ static int amdgpu_device_recover_vram(struct amdgpu_device *adev)
>   	dev_info(adev->dev, "recover vram bo from shadow start\n");
>   	mutex_lock(&adev->shadow_list_lock);
>   	list_for_each_entry(vmbo, &adev->shadow_list, shadow_list) {
> -		shadow = &vmbo->bo;
> +
> +		/* If vm is compute context or adev is APU, shadow will be NULL */
> +		if (!vmbo->shadow)
> +			continue;
> +		shadow = vmbo->shadow;
> +
>   		/* No need to recover an evicted BO */
>   		if (shadow->tbo.resource->mem_type != TTM_PL_TT ||
>   		    shadow->tbo.resource->start == AMDGPU_BO_INVALID_OFFSET ||

