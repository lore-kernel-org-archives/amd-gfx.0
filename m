Return-Path: <SRS0=e+DK=KG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A69AC433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 06:55:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0101616EB
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 06:54:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0101616EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A9B46E9D2;
	Tue, 11 May 2021 06:54:59 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 304456E9D2;
 Tue, 11 May 2021 06:54:59 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id b25so28104984eju.5;
 Mon, 10 May 2021 23:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=waA0vA7ImjwNlWKbyTucsiUS1QU1A20aczJWgwdqypM=;
 b=Or/x8J+Trc3vk4FGAnkN2jkdqWbGCW6p+sJeVNL91D3DRU6T7pyL2yYQafEowX8n6q
 acx5VM2IER2bbqZiBLjxW4Sdw1THlxgqRViD1zoTdjkIUGW1tVdBPw5DMoDkxE13Xj3j
 4WYBut0L9kIFwc/rSPvbBtLbKn21OmWfbxxy/gtTWlfgRwTBhZAp24J22tbWOQr5Hpie
 KRHWl8ZrQoNyImugWFeq9aR1peSAhwaT+2CuQhBDfVMfY/19O/FDGDiuLnzEXDPDxVZe
 5ewchq7TgoP1cAn0WwBV4s+9iGjZ4m6qGCe51CdbxEf6U+/lQ/iDej+Lgvdfd67LWZdt
 k+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=waA0vA7ImjwNlWKbyTucsiUS1QU1A20aczJWgwdqypM=;
 b=m1jjYH+A4r4Vc5y0RaM8hzJ7iDpy0U7vUWjYGlQdSbv3eMkRdmN5AAaOlLuRN/y6nW
 tn14IbiZLfKAS4MAYiLDAi1eTTv3Dz9txNH2fQAuR5hnjw2L9rhxLP43Fj5zPv80WGnS
 c5lQ0smVLAyePQv3SfnzfrpN5Ad8baATdqBR9dfSa3eykErRdyFxNrrsy817mKqkRTnF
 CuUMe1aYuDYsRXAmp8HEN3Bl5tEznRYSD0mHdArTnoH0m/GeqoJOyaJ7MOAPKtU6TTBy
 bsNvYcvYoVeiQRJO9F4ul6Szykgno4fOYI2UmpNqTfYMVFg9lNh77kL6uiMLD7y6w2xr
 Gd4Q==
X-Gm-Message-State: AOAM530FS+3ftWkEjVgz2CCqhDrOggdZsO04tIM/anviUarnL6TZU5i2
 sBSaL7N1G4DNQp7gkWtJETE=
X-Google-Smtp-Source: ABdhPJwSQ3m3CsmdDqav2iZ3ID5dd0ZHCHRdW720vSmokH1GPExvOekTg1gQBfP5ZcbBESTqk6DCfQ==
X-Received: by 2002:a17:906:80cd:: with SMTP id
 a13mr29716576ejx.109.1620716097868; 
 Mon, 10 May 2021 23:54:57 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:c3ab:ee01:d547:2c4e?
 ([2a02:908:1252:fb60:c3ab:ee01:d547:2c4e])
 by smtp.gmail.com with ESMTPSA id c7sm13613328ede.37.2021.05.10.23.54.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 May 2021 23:54:57 -0700 (PDT)
Subject: Re: [PATCH v6 13/16] drm/amdgpu: Fix hang on device removal.
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-pci@vger.kernel.org, daniel.vetter@ffwll.ch, Harry.Wentland@amd.com
References: <20210510163625.407105-1-andrey.grodzovsky@amd.com>
 <20210510163625.407105-14-andrey.grodzovsky@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <fa76e577-b483-0ef4-57db-cea7b3a988c8@gmail.com>
Date: Tue, 11 May 2021 08:54:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210510163625.407105-14-andrey.grodzovsky@amd.com>
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
Cc: Alexander.Deucher@amd.com, gregkh@linuxfoundation.org, ppaalanen@gmail.com,
 helgaas@kernel.org, Felix.Kuehling@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 10.05.21 um 18:36 schrieb Andrey Grodzovsky:
> If removing while commands in flight you cannot wait to flush the
> HW fences on a ring since the device is gone.
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 16 ++++++++++------
>   1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 1ffb36bd0b19..fa03702ecbfb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -36,6 +36,7 @@
>   #include <linux/firmware.h>
>   #include <linux/pm_runtime.h>
>   
> +#include <drm/drm_drv.h>
>   #include "amdgpu.h"
>   #include "amdgpu_trace.h"
>   
> @@ -525,8 +526,7 @@ int amdgpu_fence_driver_init(struct amdgpu_device *adev)
>    */
>   void amdgpu_fence_driver_fini_hw(struct amdgpu_device *adev)
>   {
> -	unsigned i, j;
> -	int r;
> +	int i, r;

Is j not used here any more?

Christian.

>   
>   	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
>   		struct amdgpu_ring *ring = adev->rings[i];
> @@ -535,11 +535,15 @@ void amdgpu_fence_driver_fini_hw(struct amdgpu_device *adev)
>   			continue;
>   		if (!ring->no_scheduler)
>   			drm_sched_fini(&ring->sched);
> -		r = amdgpu_fence_wait_empty(ring);
> -		if (r) {
> -			/* no need to trigger GPU reset as we are unloading */
> +		/* You can't wait for HW to signal if it's gone */
> +		if (!drm_dev_is_unplugged(&adev->ddev))
> +			r = amdgpu_fence_wait_empty(ring);
> +		else
> +			r = -ENODEV;
> +		/* no need to trigger GPU reset as we are unloading */
> +		if (r)
>   			amdgpu_fence_driver_force_completion(ring);
> -		}
> +
>   		if (ring->fence_drv.irq_src)
>   			amdgpu_irq_put(adev, ring->fence_drv.irq_src,
>   				       ring->fence_drv.irq_type);

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
