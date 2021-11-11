Return-Path: <SRS0=G5aM=P6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2914FC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Nov 2021 08:58:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDE5B61260
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Nov 2021 08:58:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DDE5B61260
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66FD76E90B;
	Thu, 11 Nov 2021 08:58:53 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E4D46E90B
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Nov 2021 08:58:52 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 f7-20020a1c1f07000000b0032ee11917ceso3932524wmf.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Nov 2021 00:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:from:to:references:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=HdJ1YGH8aoFEWitQRImtClQIyNtSUn5k/+tMaUadFIg=;
 b=b27eSdFBBSliB3jrjlPRuAknqDL5W9Z+MhIp3huhyy1lC/41Hjrtk0hf/Ze6rjw0+/
 Yq+lofSdeoIGhDRnqOxgUQy8WzidzEty6CK3tCUz7c3YWesn51Qijb7uX1h/EKCb5LCU
 M8i+Ft/5+9O7nx5EowRC1QRhX4YFsNRNLPoa9BhVtSQ+LVt9Duxu5TLXqhZtI4nMqJ9i
 46jopA9L7M3Np9EsqUoNfFW28kKPO2+Ger9BQZoYaL2MKzPtafML1akXRWsMWk0Fgpuk
 orFlTeGjodDXlvO0MtF5IJEZKrAnv5TCy+6CYEHTOMFvVsc8GhFuwBxlFqd9pNHBrF0o
 O57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:from:to:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=HdJ1YGH8aoFEWitQRImtClQIyNtSUn5k/+tMaUadFIg=;
 b=ljnMDMJNGU5mkUcehy73Q7poDocpQIEqfqFkV6pJyFECPeuOntDiaAtmaKEUTn8w0u
 Dfpz9cXDikS1F3bM4tWnUguDpMnLUbhKScarK7pcboabcKTWF5ZYBXj+ii0S44JqqYCj
 tpkn2sQLNxASKH56S9Kos8jyOYzgA4p7HusduEOygVJJDd5bb/RIN8gVf1kHu9MoAm2y
 X3031KLlOhPnEBiiTeqjQ6zRsQfLQzf8M7xNyZagOShMw54j9xq24BJDDtJamdAD/zx3
 6R4uIrzXmZNKBjhlAY4maMPVuBcuar4+KNZlA9ywnxAl8E0zG7zE36aPF3+jvqBneQlK
 25Aw==
X-Gm-Message-State: AOAM532x+hmLkpxeFK8P7S6TqTZvXShfcmmD7ib8HgySucIX54IF4+M/
 lmUhmKVwcYalk+CjcdNVAHCymkl8xNk=
X-Google-Smtp-Source: ABdhPJzuSO682rgPU9f8/bVQR4svgxrlmGKpfwpqRTHnMBx/g3RLoJP+9d+MSirymWbt8sAzM1ydkQ==
X-Received: by 2002:a05:600c:3541:: with SMTP id
 i1mr6928806wmq.124.1636621131278; 
 Thu, 11 Nov 2021 00:58:51 -0800 (PST)
Received: from [192.168.178.21] (p4fc204a3.dip0.t-ipconnect.de. [79.194.4.163])
 by smtp.gmail.com with ESMTPSA id x4sm7716210wmi.3.2021.11.11.00.58.50
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Nov 2021 00:58:50 -0800 (PST)
Subject: Re: [PATCH 2/6] drm/amdgpu: stop getting excl fence separately
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
To: amd-gfx@lists.freedesktop.org
References: <20211028132630.2330-1-christian.koenig@amd.com>
 <20211028132630.2330-2-christian.koenig@amd.com>
Message-ID: <d82038f9-c1f5-2ede-f867-efe843cee1a6@gmail.com>
Date: Thu, 11 Nov 2021 09:58:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211028132630.2330-2-christian.koenig@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Just a ping to the amd-gfx list.

Trivial cleanup, can anybody give me an rb for that?

Thanks,
Christian.

Am 28.10.21 um 15:26 schrieb Christian König:
> Just grab all fences for the display flip in one go.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         | 1 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 6 +-----
>   2 files changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index d58e37fd01f4..4da7eb65e744 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -457,7 +457,6 @@ struct amdgpu_flip_work {
>   	uint64_t			base;
>   	struct drm_pending_vblank_event *event;
>   	struct amdgpu_bo		*old_abo;
> -	struct dma_fence		*excl;
>   	unsigned			shared_count;
>   	struct dma_fence		**shared;
>   	struct dma_fence_cb		cb;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> index dc50c05f23fc..68108f151dad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -83,9 +83,6 @@ static void amdgpu_display_flip_work_func(struct work_struct *__work)
>   	unsigned i;
>   	int vpos, hpos;
>   
> -	if (amdgpu_display_flip_handle_fence(work, &work->excl))
> -		return;
> -
>   	for (i = 0; i < work->shared_count; ++i)
>   		if (amdgpu_display_flip_handle_fence(work, &work->shared[i]))
>   			return;
> @@ -203,7 +200,7 @@ int amdgpu_display_crtc_page_flip_target(struct drm_crtc *crtc,
>   		goto unpin;
>   	}
>   
> -	r = dma_resv_get_fences(new_abo->tbo.base.resv, &work->excl,
> +	r = dma_resv_get_fences(new_abo->tbo.base.resv, NULL,
>   				&work->shared_count, &work->shared);
>   	if (unlikely(r != 0)) {
>   		DRM_ERROR("failed to get fences for buffer\n");
> @@ -253,7 +250,6 @@ int amdgpu_display_crtc_page_flip_target(struct drm_crtc *crtc,
>   
>   cleanup:
>   	amdgpu_bo_unref(&work->old_abo);
> -	dma_fence_put(work->excl);
>   	for (i = 0; i < work->shared_count; ++i)
>   		dma_fence_put(work->shared[i]);
>   	kfree(work->shared);

