Return-Path: <SRS0=NRDG=IQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48CAC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 11:52:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34ABB64F38
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 11:52:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34ABB64F38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 867756E059;
	Thu, 18 Mar 2021 11:52:18 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 305856E059
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Mar 2021 11:52:17 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id b9so3459920ejc.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Mar 2021 04:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=aMgjlu73SCEbCZdi66p4w/kGYBKy3s+26IXYNQOy/gQ=;
 b=XA95bZ6sBJCdS3IyZ1nb03OLSw9mAEg6MBeQ7DTYw7JDbC933cJxd71QWiPm3XPKhr
 1cHnye1ZaN0XY6D1gyp3U4eGYmQpKIAIhIz4nGnMFSPFC1vl6Ri00vCIodH/PZiP9e3x
 0HpqGCgI7e+7NONUWu/odGZ0ifK2mwVuroAB/RrXcik1wvaEBLOJXfmFdMpCwWqEk6IN
 UNJHScS8cQyvVvXyAqrk/+KcUjqw/uiRrzRv1VRd+VO/XGIciXgqIFq41+Voy5CCLQup
 E9p2mr03LPX1FG/miKe6qHGCQnC0FfGa68Pd4TovzTQkMNLTUuuSDzmqp4wYsspQnR2y
 L6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=aMgjlu73SCEbCZdi66p4w/kGYBKy3s+26IXYNQOy/gQ=;
 b=SwW8caABYDAh8xZ4i5yec6qOgguEa9MD7h9JLGdYGyE50uV0vFgz5T6TvQKPrLAzMk
 7txPLYIo6QUPzghiFFsaXBqV8Ix3mTwtqZekbyHxmw/Rwn0qF8nKkK4uTYnLDVtj2REl
 13QvmDyY3//V5+rxZa42cO0VbPnNCjSjUvLzMV0ueXUMxZeqizaQ3HYcdiGi2yFPmojf
 rBYNaOH/gqV6ybwEHpP/qzx5vI3wRjoigrOXlPwkWzqABcd2JGt1xEtNntqeWtsmfTuI
 w81ojSqZgs0X7TkUyIhrSSCGDuvfh07yFlLHPh1e3I+KKLnG3RHAFp4NHhKoNHS8AiEG
 zUYA==
X-Gm-Message-State: AOAM532bSSn4rj26ggbKXDMCsdr3jltBg1xAwcsSq9ekCaoZlIKEBtJW
 yIFp3fKJBjr4vYYOmuIG7rliMtQS9ls=
X-Google-Smtp-Source: ABdhPJyQH/YNI4nuHK+vl9OODAzF+yUca3saAdI+WQ48Ng+6l7xWG60Mz0/hYz/xifEYj0XTBd9b3A==
X-Received: by 2002:a17:906:2dc1:: with SMTP id
 h1mr41206696eji.460.1616068335815; 
 Thu, 18 Mar 2021 04:52:15 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:c886:8ff9:f88f:26b8?
 ([2a02:908:1252:fb60:c886:8ff9:f88f:26b8])
 by smtp.gmail.com with ESMTPSA id cf4sm1899537edb.19.2021.03.18.04.52.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Mar 2021 04:52:15 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: Fix the page fault issue in amdgpu_irq_fini
To: Emily Deng <Emily.Deng@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210318114812.407295-1-Emily.Deng@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <173acde7-b3ed-9a3f-5191-60158af45895@gmail.com>
Date: Thu, 18 Mar 2021 12:52:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210318114812.407295-1-Emily.Deng@amd.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 18.03.21 um 12:48 schrieb Emily Deng:
> For some source, it will be shared by some client ID and source ID.
> To fix the page fault issue, set all those to null.
>
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 16 +++++++++++++---
>   1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index af026109421a..623b1ac6231d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -359,7 +359,7 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
>    */
>   void amdgpu_irq_fini(struct amdgpu_device *adev)
>   {
> -	unsigned i, j;
> +	unsigned i, j, m, n;
>   
>   	if (adev->irq.installed) {
>   		drm_irq_uninstall(adev_to_drm(adev));
> @@ -380,12 +380,22 @@ void amdgpu_irq_fini(struct amdgpu_device *adev)
>   			if (!src)
>   				continue;
>   
> -			kfree(src->enabled_types);
> +			if (src->enabled_types)
> +				kfree(src->enabled_types);

A NULL check before kfree() is unecessary and will be complained about 
by the static checkers.

> +
>   			src->enabled_types = NULL;
> +

Unrelated white space change.

>   			if (src->data) {
>   				kfree(src->data);
>   				kfree(src);
> -				adev->irq.client[i].sources[j] = NULL;
> +			}
> +
> +			for (m = 0; m < AMDGPU_IRQ_CLIENTID_MAX; ++m) {
> +				if (!adev->irq.client[m].sources)
> +					continue;
> +				for (n = 0; n < AMDGPU_MAX_IRQ_SRC_ID; ++n)
> +					if (adev->irq.client[m].sources[n] == src)
> +						adev->irq.client[m].sources[n] = NULL;

Hui what? The memory you set to NULL here is freed on the line below.

Accessing it after that would be illegal, so why do you want to set it 
to NULL?

Christian.

>   			}
>   		}
>   		kfree(adev->irq.client[i].sources);

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
