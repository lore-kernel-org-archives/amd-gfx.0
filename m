Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D229EE57D5
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Sep 2023 06:49:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4DA710E0E3;
	Fri,  8 Sep 2023 06:49:05 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E24110E0E3
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Sep 2023 06:49:03 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-401b3ea0656so17915425e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 Sep 2023 23:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694155741; x=1694760541; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qLvgfE3TS723QzDR9jZwZkKYsO44uux9n39XiHmuJz8=;
 b=s4cC6RrPwksQbSeHVkMh1oER2wU91u2JK3t/MDyFZdQBFiAW7CYeR2XOdYL2Iw+LcK
 amJ63/Ago19tkUvHp/CoRKiiG8UgH7ds3Jq60sfiG7YthlzomQ2ZfHU6cavg8jNJjo+s
 DWhCzSBLls1c77iZ2M4cnbkkccdDmNfn6pBy3DkuoNlhplDkMY9iXLE+70yv62jTBaQH
 l44q9cB+3gOQYJEsDVsM6CdBtd2xeUIiUS/J2GFAkZ0FAQrlrEICBVE75EIcReMzDdrJ
 IJt+5QjkFZB8zz4/d7kxtjvVll+KAKXbGJ0pjotCQNfnjx+tk3I+AVBhUKCrMnjqkGAe
 FKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694155741; x=1694760541;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qLvgfE3TS723QzDR9jZwZkKYsO44uux9n39XiHmuJz8=;
 b=MLYXYmRsGZWjhOa6twybDqzEKeQDz1odZYPt3Pm0hyD9XPiCYfylWZ3X1YvofsCrOT
 yNcT0sGy2lC4JdM89JyJzc110TWiMj7gb7KMRM1y15nOvD7kwJDWc3bzXJNR7J0k8H21
 NpXejdGV3kRzw6JqLSdgPYmworuPD0DkpTM4XuvddM3YAN2HQW0BK/97U1xGdlyJREq1
 UXEAfvu+m/fFs41HWtJVukZprnfb6AyxdokPGSZzy8kRY3H1nKULMPtfFHGpPSAmKJ8B
 dqb5SeKuQUXX66d6rWG0H5YsPcUFxUbwZ0aVqHYybFH9wQW8axDqlHL70TKzfT0LsW1P
 kqbA==
X-Gm-Message-State: AOJu0Yy4e3zSQNpZEN3YNwcRZfYqTm8NuZJhyOEhFab1cYX6EDiq+Ln7
 6ZSJp/VbPIszxLoGgEeiinQ=
X-Google-Smtp-Source: AGHT+IGEgVnCEAnieXRXxHgKw3/sPJIvG5eu4BsfFX1x/YkccwjGTEIDNCgsiKGGXdVlLL4XdCPxUw==
X-Received: by 2002:a1c:ed14:0:b0:401:b0f2:88c1 with SMTP id
 l20-20020a1ced14000000b00401b0f288c1mr1497897wmh.29.1694155741306; 
 Thu, 07 Sep 2023 23:49:01 -0700 (PDT)
Received: from [10.254.108.106] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 k22-20020a05600c0b5600b003fc0505be19sm1123788wmr.37.2023.09.07.23.49.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Sep 2023 23:49:00 -0700 (PDT)
Message-ID: <9ee0c0b2-dbe8-7e47-cd64-d35b974861e3@gmail.com>
Date: Fri, 8 Sep 2023 08:48:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] drm/amdgpu: Ignore first evction failure during suspend
Content-Language: en-US
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230908033952.41872-1-xinhui.pan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230908033952.41872-1-xinhui.pan@amd.com>
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, shikang.fan@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 08.09.23 um 05:39 schrieb xinhui pan:
> Some BOs might be pinned. So the first eviction's failure will abort the
> suspend sequence. These pinned BOs will be unpined afterwards during
> suspend.

That doesn't make much sense since pinned BOs don't cause eviction 
failure here.

What exactly is the error code you see?

Christian.

>
> Actaully it has evicted most BOs, so that should stil work fine in sriov
> full access mode.
>
> Fixes: 47ea20762bb7 ("drm/amdgpu: Add an extra evict_resource call during device_suspend.")
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 5c0e2b766026..39af526cdbbe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4148,10 +4148,11 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
>   
>   	adev->in_suspend = true;
>   
> -	/* Evict the majority of BOs before grabbing the full access */
> -	r = amdgpu_device_evict_resources(adev);
> -	if (r)
> -		return r;
> +	/* Try to evict the majority of BOs before grabbing the full access
> +	 * Ignore the ret val at first place as we will unpin some BOs if any
> +	 * afterwards.
> +	 */
> +	(void)amdgpu_device_evict_resources(adev);
>   
>   	if (amdgpu_sriov_vf(adev)) {
>   		amdgpu_virt_fini_data_exchange(adev);

