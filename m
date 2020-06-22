Return-Path: <SRS0=8rPh=AD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE0DC433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2020 09:55:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 635B4206F1
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2020 09:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="TocVquN1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 635B4206F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E7696E15A;
	Mon, 22 Jun 2020 09:55:30 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81F216E165
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2020 09:55:29 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id z13so4234995wrw.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2020 02:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=q5LJPqagiU0zu76gLT0Rc2+3L2QIPLyD8VTMU4dbCpQ=;
 b=TocVquN1kf64v6aUVsbHpKh0A/uqd0DqNFvgZCWUQKE1Ed5BbbrFqZWvDtdyI1RxQ6
 gNTwYorVyqD+DAlD6d4bdQBSGdJS2fP543utFjG0CxV9enJ41sD2hpE1BvXZYztkQktT
 midUMaOgoxNj5GpscEw0yHDL8+G0E8aFED6xA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=q5LJPqagiU0zu76gLT0Rc2+3L2QIPLyD8VTMU4dbCpQ=;
 b=JRV0bsJK5GAhcGjKwjixmQdaFwc1cYc5v1iUdKVdnpeZ+XpPGCd/o5lt+98TPVA7LR
 AbW6iekymnx5m38XABw+LIGqbkV5WBtGmF0by5cPufekPV0fkIzeuOS/kH5fcnQPPXfJ
 rtd4vNVvOcmtsztwQUB+til42H6JzkOeyl+aF1BvOoWZcqLpYqi7+H7s8+O+uJ3HevSg
 CQZF1DHlOp1W1QmIRQ77KHx588x8dVAMqeOeJTzznJeY39YrgAG5aCsnj6D/d0BVShnq
 2ZIqlYrZEwH4UIlwZOHWeZLfS7jHNfLxnXlQTtYC7hBhRe9bnSWh6cMYe9ViEtOeSeLW
 FYsA==
X-Gm-Message-State: AOAM532155GSye9bOqwoa2aKvR6O7RC2+T5ejMWAp8/oPwUWToagC+aQ
 gcdKIveAEh7iMcm30CziEceMHQ==
X-Google-Smtp-Source: ABdhPJypNAKJ1GDRaCqbxeL78reScNhAZ3tM2/L/jOlNdlYr7ZmIMMX3dHqk7j4Ru/+6mN6Cbh0paA==
X-Received: by 2002:a5d:4dc2:: with SMTP id f2mr18527719wru.399.1592819728141; 
 Mon, 22 Jun 2020 02:55:28 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id a22sm2958129wmb.4.2020.06.22.02.55.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2020 02:55:27 -0700 (PDT)
Date: Mon, 22 Jun 2020 11:55:25 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Subject: Re: [PATCH v2 7/8] drm/amdgpu: Fix sdma code crash post device unplug
Message-ID: <20200622095525.GG20149@phenom.ffwll.local>
References: <1592719388-13819-1-git-send-email-andrey.grodzovsky@amd.com>
 <1592719388-13819-8-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1592719388-13819-8-git-send-email-andrey.grodzovsky@amd.com>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
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
Cc: daniel.vetter@ffwll.ch, michel@daenzer.net, dri-devel@lists.freedesktop.org,
 ppaalanen@gmail.com, amd-gfx@lists.freedesktop.org,
 ckoenig.leichtzumerken@gmail.com, alexdeucher@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sun, Jun 21, 2020 at 02:03:07AM -0400, Andrey Grodzovsky wrote:
> entity->rq becomes null aftre device unplugged so just return early
> in that case.
> 
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

That looks very deep in amdgpu internals ... how do you even get in here
after the device is fully unplugged on the sw side?

Is this amdkfd doing something stupid because entirely unaware of what
amdgpu has done? Something else? Just feels like this is just duct-taping
over a more fundamental problem, after hotunplug no one should be able to
even submit anything new, or do bo moves, or well anything really.
-Daniel

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> index 8d9c6fe..d252427 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> @@ -24,6 +24,7 @@
>  #include "amdgpu_job.h"
>  #include "amdgpu_object.h"
>  #include "amdgpu_trace.h"
> +#include <drm/drm_drv.h>
>  
>  #define AMDGPU_VM_SDMA_MIN_NUM_DW	256u
>  #define AMDGPU_VM_SDMA_MAX_NUM_DW	(16u * 1024u)
> @@ -94,7 +95,12 @@ static int amdgpu_vm_sdma_commit(struct amdgpu_vm_update_params *p,
>  	struct drm_sched_entity *entity;
>  	struct amdgpu_ring *ring;
>  	struct dma_fence *f;
> -	int r;
> +	int r, idx;
> +
> +	if (!drm_dev_enter(p->adev->ddev, &idx)) {
> +		r = -ENODEV;
> +		goto nodev;
> +	}
>  
>  	entity = p->immediate ? &p->vm->immediate : &p->vm->delayed;
>  	ring = container_of(entity->rq->sched, struct amdgpu_ring, sched);
> @@ -104,7 +110,7 @@ static int amdgpu_vm_sdma_commit(struct amdgpu_vm_update_params *p,
>  	WARN_ON(ib->length_dw > p->num_dw_left);
>  	r = amdgpu_job_submit(p->job, entity, AMDGPU_FENCE_OWNER_VM, &f);
>  	if (r)
> -		goto error;
> +		goto job_fail;
>  
>  	if (p->unlocked) {
>  		struct dma_fence *tmp = dma_fence_get(f);
> @@ -118,10 +124,15 @@ static int amdgpu_vm_sdma_commit(struct amdgpu_vm_update_params *p,
>  	if (fence && !p->immediate)
>  		swap(*fence, f);
>  	dma_fence_put(f);
> -	return 0;
>  
> -error:
> -	amdgpu_job_free(p->job);
> +	r = 0;
> +
> +job_fail:
> +	drm_dev_exit(idx);
> +nodev:
> +	if (r)
> +		amdgpu_job_free(p->job);
> +
>  	return r;
>  }
>  
> -- 
> 2.7.4
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
