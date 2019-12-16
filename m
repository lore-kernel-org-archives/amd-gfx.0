Return-Path: <SRS0=GTlj=2G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4F1C43603
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2019 20:19:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E5B021739
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2019 20:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXKa/gJl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E5B021739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57FF06E87B;
	Mon, 16 Dec 2019 20:19:13 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AE226E87A
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2019 20:19:11 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id t2so8881992wrr.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2019 12:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=AjcR77FnA7cmAUlu3umIyU4YYEY7/G8KEUK0HMElKnA=;
 b=dXKa/gJlrK0/DVslAcnY7ycliPKR/EZDgZxndoNex0ioAlyxMRaM1Qt9IGp3BHwBmc
 G340QjNBrPrY875Lbu2ZxozdrLeovS65W1kTkXN0rpqWwBdc0SpFoQNV3P2mdLZt8tsg
 horZV47jSxU8uwCtmL3Z9BzDskW8qhkGLsIr2WGDUrWs8dlyhusw18T07EiG+4ahD0iq
 kUMy8ITcNWOkxx6JhEfcikhsLiQGxzbIFMWm6nXKtBC4kLaCNBIIylrHFrXzbZXl2hC4
 YvSsZmDtpx6McqxeJfTTqyheW6G/7kmwGX05QFZKNzo4F3gn2ccRf4I7e8Ww4WvjuFMe
 e0mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=AjcR77FnA7cmAUlu3umIyU4YYEY7/G8KEUK0HMElKnA=;
 b=pGV6MNn2IvgFM/C2MWOP4n8/nvhxjXOgMT94LgA7PNpap4vnOpKmu00oRyKwMEan9c
 aZsJxn3jm38jTXFdEv4piA52yEUQb6DS1CRrCxNlrQDwVIzZ4v+TUBoPwkomb98bfHtP
 mr0LQM5U9kfeNVp0Aanjw21Wu/gHl5OZkhsqKYnyd0WWX0Sw5S6WUWXrgrDHHlOH5jJZ
 GZdbbSvKYOgspNohE0hChDmCRPP+JfXJpnO5IgItcn+JbMgUu04oOsart641M/bEGuOE
 4IzbXJ0Q1FlS6L9236xXyXXQJcNoHjhbqM2E53s492wNKg47GojSQm0hRfFwUXzD2u/u
 j1pw==
X-Gm-Message-State: APjAAAWJsxW+2F/JTGZn8UDzYGqbfGMwN54uD6o1sFGigcNkwFzIza5W
 JPt2Rd/ecp7mZ5R9HHY13e0=
X-Google-Smtp-Source: APXvYqy6ebD4ldCDHBlMvIoeCGatzsybLvMNSAov5jpirx6uExlncGiEw6p40mXqC9taNhw3w1/b8w==
X-Received: by 2002:a5d:4b45:: with SMTP id w5mr34092494wrs.224.1576527550209; 
 Mon, 16 Dec 2019 12:19:10 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id r15sm501436wmh.21.2019.12.16.12.19.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Dec 2019 12:19:09 -0800 (PST)
Subject: Re: [PATCH 2/3] drm/amdgpu/pm_runtime: update usage count in fence
 handling
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20191216171834.217251-1-alexander.deucher@amd.com>
 <20191216171834.217251-2-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <d9b19564-79b4-6044-8b0d-5dba5adf6982@gmail.com>
Date: Mon, 16 Dec 2019 21:19:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191216171834.217251-2-alexander.deucher@amd.com>
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
Reply-To: christian.koenig@amd.com
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 16.12.19 um 18:18 schrieb Alex Deucher:
> Increment the usage count in emit fence, and decrement in
> process fence to make sure the GPU is always considered in
> use while there are fences outstanding.  We always wait for
> the engines to drain in runtime suspend, but in practice
> that only covers short lived jobs for gfx.  This should
> cover us for longer lived fences.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 377fe20bce23..e9efee04ca23 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -34,6 +34,7 @@
>   #include <linux/kref.h>
>   #include <linux/slab.h>
>   #include <linux/firmware.h>
> +#include <linux/pm_runtime.h>
>   
>   #include <drm/drm_debugfs.h>
>   
> @@ -154,7 +155,7 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
>   		       seq);
>   	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
>   			       seq, flags | AMDGPU_FENCE_FLAG_INT);
> -
> +	pm_runtime_get_noresume(adev->ddev->dev);
>   	ptr = &ring->fence_drv.fences[seq & ring->fence_drv.num_fences_mask];
>   	if (unlikely(rcu_dereference_protected(*ptr, 1))) {
>   		struct dma_fence *old;
> @@ -234,6 +235,7 @@ static void amdgpu_fence_schedule_fallback(struct amdgpu_ring *ring)
>   bool amdgpu_fence_process(struct amdgpu_ring *ring)
>   {
>   	struct amdgpu_fence_driver *drv = &ring->fence_drv;
> +	struct amdgpu_device *adev = ring->adev;
>   	uint32_t seq, last_seq;
>   	int r;
>   
> @@ -274,6 +276,8 @@ bool amdgpu_fence_process(struct amdgpu_ring *ring)
>   			BUG();
>   
>   		dma_fence_put(fence);
> +		pm_runtime_mark_last_busy(adev->ddev->dev);
> +		pm_runtime_put_autosuspend(adev->ddev->dev);

Are you sure this is ok? Keep in mind that this function is called in 
interrupt context.

Christian.

>   	} while (last_seq != seq);
>   
>   	return true;

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
