Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD544E95A91
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Oct 2023 08:46:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C8C110E230;
	Mon,  9 Oct 2023 08:46:55 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18DAE10E230
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Oct 2023 08:46:54 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-52bd9ddb741so7413981a12.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Oct 2023 01:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696841212; x=1697446012; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dOgx1CCC4CKxiQ5GCV0QcldKZP/Uk3tnXj4x7wXaha4=;
 b=k4UbuYVn+vXyFKHkmdwt7S0awetzMFbC/QNxlY6L3f4geUlpMNCKsqGObJhRowur70
 BtYNkFW7bPQV1P4mIx/RKSJydlULKk4VRKi/fOQriArSyWs9ebjNBgHjWjAbPmzEOtC/
 N5cnpfQmh8BvadgSyH7nB1rtxZtV/EK3zaVFZ8qQCpvyhfB/N9w1Xl7d/+TPHg8HO85+
 9K6MWxAKIARiD/5M8XRKCmmIiBArVRHODXu8fij2A4GYOq/Ma/o+xpTmMVNFDOkkZeDV
 cXWT4vgtn8Wg0uqIEZhn8GTWD7s3nZqHa0Z29YNP/NYk0soYwaePoXHY8zWqYcYKEi/s
 v0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696841212; x=1697446012;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dOgx1CCC4CKxiQ5GCV0QcldKZP/Uk3tnXj4x7wXaha4=;
 b=hsJk2br2ZqqnPZn/uZv5NDC5Y0gfQIBvvUtIdnG//Gzi2U4k8N2akx/gj/4HIwI7CX
 UzMYeJnAALt3aC4IIN4ZcGzZbLbWb5SoX+VwwQiMMyx31u3PkeMLuRD1SDVF3a7K6sBS
 B5v9ZPWZ3xdLgrFsxPdl6tcElGF+7B5T95gdZoxJqNxboSlDWKK+oF2Q1mSEK3dfFvHy
 05VHcKEXvWrdK+jQGSKeXwjj1+f9QvGlLRKx6C180Spu9Y1IUObtKg1qvONp7DR24K/X
 EsHICYjoN3u27llX90d0Qfe+DJmUpL6Kit20oLqQvKua/1C9vTzdk1O15xWKVoQpy0EC
 BK4g==
X-Gm-Message-State: AOJu0YzZYLo6+0gXjyrdoK8qxLKwbg41dkL9/O/luUqheuxulVwpG116
 FteiDaBqATrUtqWNDlr93Jc=
X-Google-Smtp-Source: AGHT+IHOm0v0S02aTvx+c8PN18HumEdt2F1dwvcSmifPqbyep7oQWfccU2ex9R17UOKxtsPsZEuxtA==
X-Received: by 2002:a17:907:7850:b0:9a2:474:4aa0 with SMTP id
 lb16-20020a170907785000b009a204744aa0mr14048550ejc.48.1696841212046; 
 Mon, 09 Oct 2023 01:46:52 -0700 (PDT)
Received: from [192.168.178.25] ([134.19.31.182])
 by smtp.gmail.com with ESMTPSA id
 r11-20020a170906364b00b009a1a5a7ebacsm6371558ejb.201.2023.10.09.01.46.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 01:46:51 -0700 (PDT)
Message-ID: <7cc4e389-7131-4763-9867-c1c8b9b96b2d@gmail.com>
Date: Mon, 9 Oct 2023 10:46:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/7] drm/amd: Add concept of running prepare() sequence
 for IP blocks
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20231006185026.5536-1-mario.limonciello@amd.com>
 <20231006185026.5536-3-mario.limonciello@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20231006185026.5536-3-mario.limonciello@amd.com>
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
Cc: Harry.Wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 06.10.23 um 20:50 schrieb Mario Limonciello:
> If any IP blocks allocate memory during their sw_fini() sequence

hw_fini instead of sw_fini? sw_fini should only be called on driver unload.

> this can cause the suspend to fail under memory pressure.  Introduce
> a new phase that IP blocks can use to allocate memory before suspend
> starts so that it can potentially be evicted into swap instead.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Apart from the commit message Reviewed-by: Christian König 
<christian.koenig@amd.com>.

Regards,
Christian.

> ---
> v4->v5:
>   * New patch
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 +++++++++++-
>   drivers/gpu/drm/amd/include/amd_shared.h   |  1 +
>   2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index cb334dc57c59..a362152cd0da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4348,7 +4348,7 @@ static int amdgpu_device_evict_resources(struct amdgpu_device *adev)
>   int amdgpu_device_prepare(struct drm_device *dev)
>   {
>   	struct amdgpu_device *adev = drm_to_adev(dev);
> -	int r;
> +	int i, r;
>   
>   	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
>   		return 0;
> @@ -4358,6 +4358,16 @@ int amdgpu_device_prepare(struct drm_device *dev)
>   	if (r)
>   		return r;
>   
> +	for (i = 0; i < adev->num_ip_blocks; i++) {
> +		if (!adev->ip_blocks[i].status.valid)
> +			continue;
> +		if (!adev->ip_blocks[i].version->funcs->prepare)
> +			continue;
> +		r = adev->ip_blocks[i].version->funcs->prepare((void *)adev);
> +		if (r)
> +			return r;
> +	}
> +
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index ce75351204bb..1f831cb747e0 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -299,6 +299,7 @@ struct amd_ip_funcs {
>   	int (*hw_init)(void *handle);
>   	int (*hw_fini)(void *handle);
>   	void (*late_fini)(void *handle);
> +	int (*prepare)(void *prepare);
>   	int (*suspend)(void *handle);
>   	int (*resume)(void *handle);
>   	bool (*is_idle)(void *handle);

