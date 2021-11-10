Return-Path: <SRS0=Yti/=P5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40024C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 10:15:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0483761168
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 10:15:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0483761168
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FF416EDEB;
	Wed, 10 Nov 2021 10:15:44 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 369856EDEB
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Nov 2021 10:15:43 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 b2-20020a1c8002000000b0032fb900951eso4163773wmd.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Nov 2021 02:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=7ADp5lLP8bLLKXwbn+K3zSZJ8ydw84Nw/EnGAMnbJB4=;
 b=i3CP8/3gFbPxp3GKHtIGK/eq+XHI+j5VQcttkOGS/YB0kqZQjTwdgp6qbg/JjRzjyR
 phZe9nM2+jx6kmKicyrITNXuXMnr/pJZHEb6QvCN04EZFu+Y1u9il2v0oAEo66iIOu3u
 FL4PcnPdvz+/F+fFM+sQwdyiI6+/OIhgE7/nfnIqyScEnJ0jr2uXvWD6XZoCeU6MS6RP
 o7U2aPFg568L2oJQnLIY5AF6hbZtJ3sRGZsW1PHxfaRJBB155aTmn9w4sR6C7SYaoNrB
 Kz01oMWjOSVUO3B99lSbRWStrnS8jSj9SEn+noFzNsoxcmg9lIIhcT7zKSA8zBALTWzd
 TEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=7ADp5lLP8bLLKXwbn+K3zSZJ8ydw84Nw/EnGAMnbJB4=;
 b=wAjCwE6YHXa/hLyc/90rV6R6iIDM+4YDiRQ0G9xHIKZ1uE6u4SREaSrZtm9o955LjP
 rNAHrTOAi2b49u+0mCiY2FV0GehYL9fkDy78M7Qc3uXdUYo0Jv+TvHGMHrs1b2ifin78
 X7Zrw0HDQSLeDNOnfjzGf5Aop5PFLMiu69XlwZNNrHll/rUaK6d9rmnr50x3mCcCTvmI
 AsljXKwKI1lNov+iLCwz5FvI0meWRWafVgwAcUFE8DFkTeWB1V8b+7rwfvtbjpU9PQDb
 on0I4f6aFFft1lLKdFsUKiQ/GTd2/vGpyJrwCccVoktgEGFXqnmv27DvFeT7p5BREKfb
 dOlg==
X-Gm-Message-State: AOAM530XTYHvgEa75G9cJE0n5BYbbPMA6clsB1dGNSVEerZj5xv1/sCO
 wTZqP+yE0YhPCr32xtlYGm7WcEUQDwI=
X-Google-Smtp-Source: ABdhPJwSMbkgBBmqH6s95uQNyeEbBMbJArCLn37gUxM/ICNNN3HpD8jIsRR9xQpElvTBrwtai07nWw==
X-Received: by 2002:a1c:4d8:: with SMTP id 207mr14957024wme.2.1636539341777;
 Wed, 10 Nov 2021 02:15:41 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:fa11:45ae:fadf:6269?
 ([2a02:908:1252:fb60:fa11:45ae:fadf:6269])
 by smtp.gmail.com with ESMTPSA id l26sm5285606wms.15.2021.11.10.02.15.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Nov 2021 02:15:41 -0800 (PST)
Subject: Re: [PATCH 1/5] drm/amdgpu: handle IH ring1 overflow
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211109230432.3947-1-Philip.Yang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <1862b795-3401-b89f-089b-4b544957d150@gmail.com>
Date: Wed, 10 Nov 2021 11:15:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211109230432.3947-1-Philip.Yang@amd.com>
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 10.11.21 um 00:04 schrieb Philip Yang:
> IH ring1 is used to process GPU retry fault, overflow is enabled to
> drain retry fault before unmapping the range, wptr may pass rptr,
> amdgpu_ih_process should check rptr equals to the latest wptr to exit,
> otherwise it will continue to recover outdatad retry fault after drain
> retry fault is done, and generate false GPU vm fault because range is
> unmapped from cpu.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> index f3d62e196901..d1ef61811169 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> @@ -223,7 +223,7 @@ int amdgpu_ih_wait_on_checkpoint_process(struct amdgpu_device *adev,
>    */
>   int amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih)
>   {
> -	unsigned int count = AMDGPU_IH_MAX_NUM_IVS;
> +	unsigned int count;
>   	u32 wptr;
>   
>   	if (!ih->enabled || adev->shutdown)
> @@ -232,6 +232,8 @@ int amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih)
>   	wptr = amdgpu_ih_get_wptr(adev, ih);
>   
>   restart_ih:
> +	count = AMDGPU_IH_MAX_NUM_IVS;
> +

This looks like a bugfix to me and should probably be in a separate 
patch with CC: stable.

>   	DRM_DEBUG("%s: rptr %d, wptr %d\n", __func__, ih->rptr, wptr);
>   
>   	/* Order reading of wptr vs. reading of IH ring data */
> @@ -240,6 +242,9 @@ int amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih)
>   	while (ih->rptr != wptr && --count) {
>   		amdgpu_irq_dispatch(adev, ih);
>   		ih->rptr &= ih->ptr_mask;
> +
> +		if (ih == &adev->irq.ih1)
> +			wptr = amdgpu_ih_get_wptr(adev, ih);

Well that handling does not really make much sense.

The AMDGPU_IH_MAX_NUM_IVS define controls how many IVs we can process 
before checking the wptr again.

We could of course parameterize that so that we check the wptr after 
each IV on IH1, but please not hard coded like this.

Regards,
Christian.

>   	}
>   
>   	amdgpu_ih_set_rptr(adev, ih);

