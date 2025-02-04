Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7279C02194
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Feb 2025 11:05:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F47610E31C;
	Tue,  4 Feb 2025 11:05:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="WPTjLkoG";
	dkim-atps=neutral
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 474F810E31C
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Feb 2025 11:04:42 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4YnL9L5ybgz9t8K;
 Tue,  4 Feb 2025 12:04:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1738667078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HeBC0N10MZh9BmtKq9JI+4Ba57SJm8y1jGPYcacDK90=;
 b=WPTjLkoGH+pIMbvHUBEMrIoNTgKT5sdhSbmxVTdkSu7+t0upO6TJThf5DKIUdDuuOu5QHy
 fZe+RQnZ/c33QyNvYGIgQrOx/IdbeUciO3SAZ9e8gbZOCriKZmG1ZjVEewRS4hh0lk1qpl
 mEEXBOE0lJCyF+MEULB8cKOn/O19vkopzxFtze/s0/CPeVZSsFO1kJC3tc5E14/B9trsye
 Co0x3YGWVmrN1hWz0AHYTt4A3rrfyUcwOFjKWnEzg5bOoqlFluX3Aieff3ALJmuTKa+ew5
 CMshdYOD6BEltXJz8y2qN6YBrrLOKtBw2RpHMEw35rcj+I4nT7i6wCaqnOnUJw==
Message-ID: <ada62814-77b8-4e53-97b5-f8c41b17a9ea@mailbox.org>
Date: Tue, 4 Feb 2025 12:04:37 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/6] drm/amdgpu: grab an additional reference on the gang
 fence
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 srinivasan.shanmugam@amd.com, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20250203115846.13142-1-christian.koenig@amd.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: de-CH-frami, en-CA
In-Reply-To: <20250203115846.13142-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 4dtsoranqz3giorpchs6toupyob7hs93
X-MBO-RS-ID: c9bfe57b199c48000ac
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

On 2025-02-03 12:58, Christian König wrote:
> We keep the gang submission fence around in adev, make sure that it
> stays alive.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index d6b473217c8b..aaa8f9f7b6b2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6753,6 +6753,7 @@ struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
>  {
>  	struct dma_fence *old = NULL;
>  
> +	dma_fence_get(gang);
>  	do {
>  		dma_fence_put(old);
>  		old = amdgpu_device_get_gang(adev);
> @@ -6765,6 +6766,7 @@ struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
>  	} while (cmpxchg((struct dma_fence __force **)&adev->gang_submit,
>  			 old, gang) != old);
>  
> +	dma_fence_put(old);
>  	dma_fence_put(old);
>  	return NULL;
>  }

Should one of these be

	dma_fence_put(gang);

?


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
