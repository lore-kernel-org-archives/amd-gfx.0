Return-Path: <SRS0=ROs4=M4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C37C4338F
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Aug 2021 12:35:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C06B061131
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Aug 2021 12:35:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C06B061131
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A1DC6E83B;
	Thu,  5 Aug 2021 12:35:51 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07A256E83B
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Aug 2021 12:35:50 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id m19so3278971wms.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Aug 2021 05:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=KNEcswinoUCMTy4fAZ4rxSmbC5+S0OURZXTORqwEtqg=;
 b=YbtMT18n8wYlHzD08oARGmiTgkKqXfWAhqVAM0XK7Zw3wfGIXPeEDPNl6QXTZgcaVk
 tQZ8WGLidte+FvOPB5M2adS/HXHxpWzXq444PmXUo8dxlSMHyEaMMCPVB0OLj8UuF5AY
 qncIdj+XwQCnOnSpYO0Uh0Lf9hUolhcxKNAQndu99aU9fhE5D43xDd0w5Ko2Ej3clxPQ
 DZCeC5p3y91h9hYKEKAoZqMm2aFYVH393g9vhe0RNx9IsHYXmfzHdLWE0eZChfZRr7XZ
 TVjLe/tGFy5qjLkEFrCRMNFL661y/2oVRq5vuTwYFg+nFOjq1+U975M22kUEHiH0O70O
 FAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=KNEcswinoUCMTy4fAZ4rxSmbC5+S0OURZXTORqwEtqg=;
 b=ODXYTurW0qa3uNRRvHf8U6j7CMc8mpRQ3h4SQ9A4fhO9IO2bz0lHdXnIWSLAWBR7HW
 NyksKniKmMcDCIlWNzpeKjPDsp6+twadSNigDtY1wCUKCLuDgxYcCwsol45l6Qnvbzcw
 /m5IEhXpnWupjDmxD9UOyCEvMczGDW89MVFk+wxgRbpB1esxuyuzugCjWdnxsfUSzNGw
 6TSEbs0MfhmUWYtVNHKdMJ5yv7yOnS793cMlvKVkYf/4o+xafatZJTnGBLMMxGT7J5Fx
 YuI+cH8wwhgyx5NydYCaCfyy3rw6DOe15rIWWWnlN5b6X8Eg6e0CCHgjqDCvjMe8fLLe
 2QZg==
X-Gm-Message-State: AOAM531Y1z9+bgkxTEkkR9VU1S273RYtqoqBJ54iByNn6wQVOCDrHE4U
 UsO6kaJPeifHzw1bPPMEzc8=
X-Google-Smtp-Source: ABdhPJyiPSwzSh6Niiy/JKLRFddCI+dDskuck6xaNCenN5SbfDPnJjJwhqWYXCQ3UEpe/i2BWlZxyA==
X-Received: by 2002:a05:600c:3b15:: with SMTP id
 m21mr4861242wms.99.1628166948613; 
 Thu, 05 Aug 2021 05:35:48 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:ae89:49de:1628:3147?
 ([2a02:908:1252:fb60:ae89:49de:1628:3147])
 by smtp.gmail.com with ESMTPSA id l25sm6087789wrb.44.2021.08.05.05.35.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Aug 2021 05:35:48 -0700 (PDT)
Subject: Re: [PATCH] drm/amd/amdgpu: skip locking delayed work if not
 initialized.
To: YuBiao Wang <YuBiao.Wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Evan Quan <Evan.Quan@amd.com>, horace.chen@amd.com,
 Tuikov Luben <Luben.Tuikov@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Jack Xiao
 <Jack.Xiao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Kevin Wang <Kevin1.Wang@amd.com>
References: <20210805023736.699291-1-YuBiao.Wang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <834428df-0c3d-859b-7958-2c95a14c6750@gmail.com>
Date: Thu, 5 Aug 2021 14:35:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210805023736.699291-1-YuBiao.Wang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 05.08.21 um 04:37 schrieb YuBiao Wang:
> When init failed in early init stage, amdgpu_object has
> not been initialized, so hasn't the ttm delayed queue functions.
>
> Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 9e53ff851496..4c33985542ed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3825,7 +3825,8 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>   {
>   	dev_info(adev->dev, "amdgpu: finishing device.\n");
>   	flush_delayed_work(&adev->delayed_init_work);
> -	ttm_bo_lock_delayed_workqueue(&adev->mman.bdev);
> +	if (adev->mman.initialized)
> +		ttm_bo_lock_delayed_workqueue(&adev->mman.bdev);

I'm really wondering why we have that here in the first place.

This just disabled the delayed delete queue which is part of the sw 
stack and not related to hardware in any way possible.

I think it would be much cleaner to move this into amdgpu_ttm_fini().

Christian.

>   	adev->shutdown = true;
>   
>   	/* make sure IB test finished before entering exclusive mode

