Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3735C3A5A7
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Dec 2022 11:59:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 457C410E401;
	Thu,  8 Dec 2022 11:59:00 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00551892F2
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Dec 2022 11:58:56 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id d20so1807660edn.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 08 Dec 2022 03:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1YPWEgJ734PsCyh5TGdhMkDsyyJ1BYduLm3O9YHVNCs=;
 b=TdymhTvA0P/B/5A+/RGtJet5v7nIsRkwF99uIW2Y2COuWpGu+BAIezjmeBoEL4TmXb
 U9EScQKYpjuywWg9qiJY1BNKjr5mtHb3aZv4v0EojNqWDyZ8HHZloMFECGFiAtEEqBpd
 +/4qxlfK8WX1gqWfsyc9H4es2X7NHgeTcBPMxoGOtljdGYJ0QCECjenKICN4NyYzWbhd
 J2MlcGKw0uUR2KJDFl2QZT/E6rah8kVRF7TVE/Qhqi1P0sGrkIpM29FhNjb5suTSoRoP
 uFpVBcCMyq3aBmcKqGPoJKGjYTaogrMvBbFfUp1Xcf7+s83iDHBWkpuB5LFVwqAqGFmM
 LnrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1YPWEgJ734PsCyh5TGdhMkDsyyJ1BYduLm3O9YHVNCs=;
 b=bMaFomjCSqdJGRTKLxYlu2mFK/lRkMedkqOuAKo13Q6LBZ2f41rVk/0MPcCq/YWAFF
 /u5pf02k6l1ltfx0dk/i7kVMOADLWEI/DSPP7Uc7/6WHbVdH/70I4sujdwREakggp2vn
 wtolE/qtvqEZIOq4+gfGdCV+SK00NtGOpaSKNMC49MifIRJ+QAp7WgRozmjse/zgJVJd
 2jDrT4u3FE44fk+zace3jfzwRd8IBD7xub8ZiRd2NiWST4JZSeHYQw4F7+QCi1Rv7sGK
 +DJS0k7XZPr0HwCgwdbC2Y7MHwoA8gSVeCiqSbldyXMgyP22HTplrm4DRV5FQbEzmt0H
 kJbQ==
X-Gm-Message-State: ANoB5pnDeKvGH/guq/v1++5FbbiQY8hCRvZ2GDzLLKxbKswS/KmUcf+7
 EMNE2rCC9btLUWGh8Q8R55E=
X-Google-Smtp-Source: AA0mqf6uHB84SpoZ+gGYk1W0KJ3zuVTu3fs873sdka/SbO0UMMxSEtIj7e5BCyVGHZFuk16VnAgDQg==
X-Received: by 2002:a05:6402:1802:b0:461:72cb:e5d with SMTP id
 g2-20020a056402180200b0046172cb0e5dmr75626469edy.410.1670500735391; 
 Thu, 08 Dec 2022 03:58:55 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:172d:b6f5:d270:8dd2?
 ([2a02:908:1256:79a0:172d:b6f5:d270:8dd2])
 by smtp.gmail.com with ESMTPSA id
 bo7-20020a0564020b2700b00463597d2c25sm3310068edb.74.2022.12.08.03.58.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Dec 2022 03:58:54 -0800 (PST)
Message-ID: <92929b53-0064-5133-b2d3-c0a9afa027cf@gmail.com>
Date: Thu, 8 Dec 2022 12:58:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdgpu: Add an extra evict_resource call during
 device_suspend.
Content-Language: en-US
To: Shikang Fan <shikang.fan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221208115516.7280-1-shikang.fan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20221208115516.7280-1-shikang.fan@amd.com>
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

Am 08.12.22 um 12:55 schrieb Shikang Fan:
> - evict_resource is taking too long causing sriov full access mode timeout.
>    So, add an extra evict_resource in the beginning as an early evict.
>
> Signed-off-by: Shikang Fan <shikang.fan@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 818fa72c670d..b76e8fdfd266 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4111,6 +4111,11 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
>   
>   	adev->in_suspend = true;
>   
> +	/* Evict the majority of BOs before grabbing the full access */
> +	r = amdgpu_device_evict_resources(adev);
> +	if (r)
> +		return r;
> +
>   	if (amdgpu_sriov_vf(adev)) {
>   		amdgpu_virt_fini_data_exchange(adev);
>   		r = amdgpu_virt_request_full_gpu(adev, false);

