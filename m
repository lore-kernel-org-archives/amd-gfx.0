Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD65CCFA13
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Sep 2024 09:27:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62ACE10EB30;
	Thu, 26 Sep 2024 09:27:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HwwpAYvS";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10D8010EB2E
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 09:27:07 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-42cba6cdf32so7073655e9.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 02:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727342825; x=1727947625; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9I71L5Axw1xS2wjA5ESgMJMMMc1ovnX0oydojFwMydQ=;
 b=HwwpAYvSsYU67NrYd+zTxlTLg2kPD1M7/SFvuGhtxhIOm6qNlHpKn/B1rpF2Y/HNW8
 TwvQqlxBrSp/w5eMwoNvYUJwAyUSyGblqbdg2oFAyxNFWATAaxaTQ4Zoq2rjvmodaDIQ
 FyMb3SwYjDtcx2f9TZovJnH8KDYlCHaZimtHYRHt18ZxLCXHMSgFN+3ARBCmQoN2IyYS
 B8OC0sCxxM3j6tH38BGVBAa8FcLRDvBaDJneiOikljkQvwlCHoVUKnrolV8Wmv9GEUIv
 PGNNNIxMOPjj2DeHuIxNxie4ijH1/85XlkewYtYHMpNfX7kEmz/YhVnQ/hjpsffjBMfD
 nE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727342825; x=1727947625;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9I71L5Axw1xS2wjA5ESgMJMMMc1ovnX0oydojFwMydQ=;
 b=X87SaNss0d0umQA+y1AOwBIkAdVHYVYnPnVRXG+qq/34NuR4q2WzjSAgHtA+/TJqG8
 25JY/IlHN9p1IFQRPwQA7azXjQrnMq0ZVTCUWcnrNH1TkWEQ1KRQr08ziMgHW0dM8baC
 z5vdEdo6XNqhnGZc28A3nHAiY24tsMCABaAWBSv7InYSsGNWjahUm0EDhmy/67hQ2mOx
 KDrjYZThx/DVIohhpuuxCwfIQw6+M8VR6mmq3kBrUuZQ1ZTp2n2uVcHe0b51Du1WiYeL
 WuPjMquVY+cqvde2gFAJyK5r5PnsdhN/w6h6I3a7PtNWR4J8ZrAUmhwAEWqWxkMhiLw1
 nt2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXA6WO68F1jZjavEonHQ8Yk6YH+W4jPC7MPE74ueJI2AX6wMglcs8mhunm9QP9o59PPMzAjyE2G@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwE1qCYooaq3i+OEDRSq2WxXCYa7dEdiW6FjzlkoavBVVAar29Y
 +kwoU/8ueSMWzFzy3Y0kYGQwJeKaUJGAYOtkmeAKQaC/cv+8vACD
X-Google-Smtp-Source: AGHT+IEbFbOoEDzQC1Lwta/texQGigjE5cOkXz1xakwCDNvCHn4I89UQRE8w3ARXQwgP1gCJvp1OIw==
X-Received: by 2002:a05:600c:1d28:b0:42c:cd7c:a196 with SMTP id
 5b1f17b1804b1-42e9611d114mr45691385e9.17.1727342825113; 
 Thu, 26 Sep 2024 02:27:05 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e96a16582sm41605125e9.33.2024.09.26.02.27.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Sep 2024 02:27:04 -0700 (PDT)
Message-ID: <3fe2c80e-565f-448c-9b7c-9e69fe175ab8@gmail.com>
Date: Thu, 26 Sep 2024 11:27:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/08] drm/amdgpu: Implement userqueue signal/wait IOCTL
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, alexander.deucher@amd.com
References: <20240925195928.142001-1-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240925195928.142001-1-Arunpravin.PaneerSelvam@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 25.09.24 um 21:59 schrieb Arunpravin Paneer Selvam:
> [SNIP]
> +int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
> +			    struct drm_file *filp)
> +{
> +	struct drm_amdgpu_userq_fence_info *fence_info = NULL;
> +	struct drm_amdgpu_userq_wait *wait_info = data;
> +	u32 *syncobj_handles, *bo_handles;
> +	struct dma_fence **fences = NULL;
> +	u32 num_syncobj, num_bo_handles;
> +	struct drm_gem_object **gobj;
> +	struct drm_exec exec;
> +	int r, i, entry, cnt;
> +	u64 num_fences = 0;
> +
> +	num_bo_handles = wait_info->num_bo_handles;
> +	bo_handles = memdup_user(u64_to_user_ptr(wait_info->bo_handles_array),
> +				 sizeof(u32) * num_bo_handles);
> +	if (IS_ERR(bo_handles))
> +		return PTR_ERR(bo_handles);
> +
> +	num_syncobj = wait_info->num_syncobj_handles;
> +	syncobj_handles = memdup_user(u64_to_user_ptr(wait_info->syncobj_handles_array),
> +				      sizeof(u32) * num_syncobj);
> +	if (IS_ERR(syncobj_handles)) {
> +		r = PTR_ERR(syncobj_handles);
> +		goto free_bo_handles;
> +	}
> +
> +	/* Array of GEM object handles */
> +	gobj = kmalloc_array(num_bo_handles, sizeof(*gobj), GFP_KERNEL);
> +	if (!gobj) {
> +		r = -ENOMEM;
> +		goto free_syncobj_handles;
> +	}
> +
> +	for (entry = 0; entry < num_bo_handles; entry++) {
> +		gobj[entry] = drm_gem_object_lookup(filp, bo_handles[entry]);
> +		if (!gobj[entry]) {
> +			r = -ENOENT;
> +			goto put_gobj;
> +		}
> +	}
> +
> +	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
> +	drm_exec_until_all_locked(&exec) {
> +		r = drm_exec_prepare_array(&exec, gobj, num_bo_handles, 0);
> +		drm_exec_retry_on_contention(&exec);
> +		if (r) {
> +			drm_exec_fini(&exec);
> +			goto put_gobj;
> +		}
> +	}
> +
> +	if (!wait_info->num_fences) {
> +		/* Count syncobj's fence */
> +		for (i = 0; i < num_syncobj; i++) {
> +			struct dma_fence *fence;
> +
> +			r = drm_syncobj_find_fence(filp, syncobj_handles[i],
> +						   0, 0, &fence);
> +			dma_fence_put(fence);
> +
> +			if (r || !fence)
> +				continue;
> +
> +			num_fences++;
> +		}
> +
> +		/* Count GEM objects fence */
> +		for (i = 0; i < num_bo_handles; i++) {
> +			struct dma_resv_iter resv_cursor;
> +			struct dma_fence *fence;
> +
> +			dma_resv_for_each_fence(&resv_cursor, gobj[i]->resv,
> +						dma_resv_usage_rw(wait_info->bo_wait_flags &
> +						AMDGPU_USERQ_BO_WRITE), fence)
> +				num_fences++;

We should probably adjust the UAPI here once more.

The problem is that we only provide the AMDGPU_USERQ_BO_WRITE for the 
whole IOCTL instead of per BO.

So the best approach would probably be to drop the AMDGPU_USERQ_BO_WRITE 
flag and split up the array of BOs into readers and writers.

Can you work on that Arun? Shouldn't be more than a bit typing exercise.

Thanks,
Christian.

