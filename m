Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C0DC6FA99
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Mar 2023 07:04:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90DAB10E023;
	Fri, 10 Mar 2023 07:04:55 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FEB010E023
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Mar 2023 07:04:53 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id k10so16491850edk.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Mar 2023 23:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1678431892;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8XdZ99YH53vA29KsCvrGICJgZorIYA6n4I9I5FivShY=;
 b=q72BsZOvXcOqb7rhdIc04sHwX+4gk3OVnk6Suf9JS1w9snlJYVqmvKihkgChhvN0Ww
 IdjtGzXUatlO1o9FYPhgc9w8NPVEk6KMrZlSY5Rg3D9Q7bI+YRqR+EPKAAgJ8WRLThaV
 0ZhnUWaqZ7iu8KZqJRhlMZAhfRfsOePOfKaphbfZcxP1iuelbTFMyIfF2gWkoaOz4zNy
 pZ/OBAlAi7tFJ9J+or2SZ6RHJYrvXDwK3V+1Dv42AVuqsUhCZ5StzQpmmRFSrw8YzQHY
 hornBJ/fsem9qdFxcm2ZaM1s1GhdcJC4UIHb00IZUpsL7aJLOzSTdwJfB8v7YBcTI1UV
 lp/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678431892;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8XdZ99YH53vA29KsCvrGICJgZorIYA6n4I9I5FivShY=;
 b=ukvTyZLFTlVisnNNPH2qkDz8LXKxmt3xpvzmwO9uFklVwHKugCqxf0pZn83mEztJg6
 bWA5i0BbShRjh8JmUi+aq/i6b2F/A8l1STho7/rD1lpO0tKiklp7JovP31ZsnAl0Sr0U
 9PG7nhdrnX9XftOyJOInfNiWWhUlFIkBQ0prkndNTyeUvRgzFC9rNRRK0Aki5Pls6FHc
 SNoIXuxzc/yQc8MgqkzY2nyrnbbrC1crB/jC13YxBRRF0lrrf9gjTqqIADU8Z56TGvG6
 xd/RFfZFAUO3UTSQIV4jssTwCukW6Yd9lQw0P/Jl/lhrrqwWx8/fqqXZvtwkdLhg3JiU
 GsNQ==
X-Gm-Message-State: AO0yUKUIV9VAQsXXwKWH6Ndy7CMCFyKdrL+XYKSxg4IOkUimzyUfjbic
 Tq7L1v4NIjWAve1OBoXCr15kTcUAyYWqTA==
X-Google-Smtp-Source: AK7set/rx2esqTb/rtGPk7SD0xJWYQs9SdUBW9ViheApyS5i6NZ2QOq2/NPbUJJ4OrPfwSPWlKpGwQ==
X-Received: by 2002:a05:6402:10cc:b0:4bf:5981:e59f with SMTP id
 p12-20020a05640210cc00b004bf5981e59fmr584944edu.6.1678431891731; 
 Thu, 09 Mar 2023 23:04:51 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:20f3:3be5:ee86:7e62?
 ([2a02:908:1256:79a0:20f3:3be5:ee86:7e62])
 by smtp.gmail.com with ESMTPSA id
 u19-20020a170906b11300b008d4b6f086c9sm558964ejy.185.2023.03.09.23.04.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Mar 2023 23:04:51 -0800 (PST)
Message-ID: <35906252-191b-ecf3-1a11-eb73e45f7834@gmail.com>
Date: Fri, 10 Mar 2023 08:04:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/2] drm/amdgpu: use drm_device pointer directly rather
 than convert again
Content-Language: en-US
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, hawking.zhang@amd.com, evan.quan@amd.com,
 christian.koenig@amd.com
References: <20230310050421.2903104-1-guchun.chen@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230310050421.2903104-1-guchun.chen@amd.com>
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

Am 10.03.23 um 06:04 schrieb Guchun Chen:
> The convert from adev is redundant.
>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 41ef3368556b..2937912b7757 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5575,7 +5575,7 @@ int amdgpu_device_baco_enter(struct drm_device *dev)
>   	struct amdgpu_device *adev = drm_to_adev(dev);
>   	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
>   
> -	if (!amdgpu_device_supports_baco(adev_to_drm(adev)))
> +	if (!amdgpu_device_supports_baco(dev))
>   		return -ENOTSUPP;
>   
>   	if (ras && adev->ras_enabled &&
> @@ -5591,7 +5591,7 @@ int amdgpu_device_baco_exit(struct drm_device *dev)
>   	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
>   	int ret = 0;
>   
> -	if (!amdgpu_device_supports_baco(adev_to_drm(adev)))
> +	if (!amdgpu_device_supports_baco(dev))
>   		return -ENOTSUPP;
>   
>   	ret = amdgpu_dpm_baco_exit(adev);

