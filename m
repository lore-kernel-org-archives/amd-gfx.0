Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34BDAC54F2E
	for <amd-gfx@archiver.kernel.org>; Fri, 23 May 2025 13:50:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCCB510E7EB;
	Fri, 23 May 2025 13:50:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="Lc5/j6H8";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED80110E7EB
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 May 2025 13:50:01 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-441d1ed82faso71149525e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 May 2025 06:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1748008200; x=1748613000;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CqbZlLxqudOElbnSUFWVJQWOSiHqoX5MUBKhQqTAI0I=;
 b=Lc5/j6H8CV9AyEyKWgABgpdIvRn/cHVqumikilNFz8isHg/ZrR0/oTScFrq7fQtzg2
 m0XWHhtjEDyoXRBA3FfkoUACAf5owrvizIbTClMdoPrkdS9qwIB96nNB5y/DP+bMhKvl
 IV9B+FlpI/4C+VkOSI2Kp38PxyLTrTaRlGqDxJupiOOvbuCauV32RZ5RFurK6AuwIoj8
 4drmPuEsb72/OOIZh3GyB7S20Bf5FpXXQ9xMy+5N/2EelBki7d1g7jbe6mzuUeNoIp6t
 rXkvmaJ/OeInO/SHbfsJ1n/hscWMDSjdnB8ioWrJcuYUkxorqVljbO/23zMo+BOp8EH1
 stXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748008200; x=1748613000;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CqbZlLxqudOElbnSUFWVJQWOSiHqoX5MUBKhQqTAI0I=;
 b=bEeTmrFdsAxbB+S6kVbK+J3Sj4q296/Fuik7YUzsk7/cHmoRPY0A3NaR0NZeJollu6
 sYlSVb2bDFJzJybiPvNGlhU6SCT6RHTTIpU7K2Sob/TJvI/w0nxhoQbJTH8VlOZ+yjRN
 UXKrh/W67z7y0I6MXUWlsiTg0UpCnIvWEW/V1+J+Ro0cJoFLfrkxc+VPZB+owa7cFGW3
 tPDfJc+soNjR+guDhM3rHm9naBwJ8bYss1m6tTxRxWXw6iHloTibGtLDfo4jkmG7SyXi
 1IuNJiEg2mUjS45LBXkmZIWGZe42LOnTPtMNz+Q++8oaZAb/f/espZuocvw5I9n9bosm
 IpcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsw4WA5z/wfVKbwULm/poVm97CQKAc0X4KPMBXvvE2zauwnUkFD8xMOFjQMmHM2Yqy6NBZdZ6y@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwYysLdluThWCeY70gqtShRPT6t+tb+P9RZhQK1RpO5DXRosMkb
 1BP8HskHXUSfu5Z5AXNm5Q5xt8f+VWoj/JC8SO29YbhQvdTtasEPuxnnCfFk0t2zPIA=
X-Gm-Gg: ASbGncvS6MJUnCoHhgr3djonrAHSyPl3L+NSkPjgCNSZ+IvX2Y39aHYx60aBEIDHUfz
 gU3irjdmYWGBgOMKh84nm7gngNuUsRXIz7MbyajZT+hhcV2r2/xqZ/RGgRx1v3jOCVAJZ+N3J7v
 1tTx6FNhWShIzhAlRMb8ImSNbQwTwXpk3aDwV3D1whiU3cXzdGNZ55lTioY1CzbrfEZ2cRyciE0
 PdBvyU+qHRVZrzXLNkDyuoVeMTK8t5XuZNnIDajLCVM+iEX5kzxzdUZpCccfeW7XZbULOvnCIXL
 XMLgWk2nfjZaT1F73lxnKG1MtAObeYZPPvFsBFTB7hNsGG+lgscIf39OcZiBPBKxpg==
X-Google-Smtp-Source: AGHT+IFyh7Lwlhi0eEaP5F0H0mD3Q7/UCKuKAqQ074eLg0qBEImHjvk33e02q6x4pQ5C37T/3ihwXw==
X-Received: by 2002:a5d:64ee:0:b0:3a2:12a:e631 with SMTP id
 ffacd0b85a97d-3a35fe7a46dmr26328780f8f.22.1748008200208; 
 Fri, 23 May 2025 06:50:00 -0700 (PDT)
Received: from [192.168.0.101] ([81.79.92.254])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca88a13sm26402753f8f.74.2025.05.23.06.49.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 May 2025 06:49:59 -0700 (PDT)
Message-ID: <3c8aac1b-a220-4f80-8b10-9df1fa5ed63c@ursulin.net>
Date: Fri, 23 May 2025 14:49:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/sched: optimize drm_sched_job_add_dependency
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 phasta@mailbox.org, dakr@kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20250523125643.7540-1-christian.koenig@amd.com>
 <20250523125643.7540-2-christian.koenig@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20250523125643.7540-2-christian.koenig@amd.com>
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


On 23/05/2025 13:56, Christian König wrote:
> It turned out that we can actually massively optimize here.
> 
> The previous code was horrible inefficient since it constantly released
> and re-acquired the lock of the xarray and started each iteration from the
> base of the array to avoid concurrent modification which in our case
> doesn't exist.
> 
> Additional to that the xas_find() and xas_store() functions are explicitly
> made in a way so that you can efficiently check entries and if you don't
> find a match store a new one at the end or replace existing ones.
> 
> So use xas_for_each()/xa_store() instead of xa_for_each()/xa_alloc().
> It's a bit more code, but should be much faster in the end.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/scheduler/sched_main.c | 29 ++++++++++++++++++--------
>   1 file changed, 20 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index f7118497e47a..cf200b1b643e 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -871,10 +871,8 @@ EXPORT_SYMBOL(drm_sched_job_arm);
>   int drm_sched_job_add_dependency(struct drm_sched_job *job,
>   				 struct dma_fence *fence)
>   {
> +	XA_STATE(xas, &job->dependencies, 0);
>   	struct dma_fence *entry;
> -	unsigned long index;
> -	u32 id = 0;
> -	int ret;
>   
>   	if (!fence)
>   		return 0;
> @@ -883,24 +881,37 @@ int drm_sched_job_add_dependency(struct drm_sched_job *job,
>   	 * This lets the size of the array of deps scale with the number of
>   	 * engines involved, rather than the number of BOs.
>   	 */
> -	xa_for_each(&job->dependencies, index, entry) {
> +	xa_lock(&job->dependencies);
> +	xas_for_each(&xas, entry, ULONG_MAX) {
>   		if (entry->context != fence->context)
>   			continue;
>   
>   		if (dma_fence_is_later(fence, entry)) {
>   			dma_fence_put(entry);
> -			xa_store(&job->dependencies, index, fence, GFP_KERNEL);
> +			xas_store(&xas, fence);
>   		} else {
>   			dma_fence_put(fence);
>   		}
> -		return 0;
> +		xa_unlock(&job->dependencies);
> +		return xas_error(&xas);
>   	}
>   
> -	ret = xa_alloc(&job->dependencies, &id, fence, xa_limit_32b, GFP_KERNEL);
> -	if (ret != 0)
> +retry:
> +	entry = xas_store(&xas, fence);
> +	xa_unlock(&job->dependencies);
> +
> +	/* There shouldn't be any concurrent add, so no need to loop again */
> +	if (xas_nomem(&xas, GFP_KERNEL)) {
> +		xa_lock(&job->dependencies);
> +		goto retry;
> +	}
> +
> +	if (xas_error(&xas))
>   		dma_fence_put(fence);
> +	else
> +		WARN_ON(entry);

Looks good, I cannot spot a high level problem with this approach.

Maybe only tail end of this function could be improved with something 
like this:

...
if (xas_nomem(&xas, GFP_KERNEL)) {
	xa_lock(&job->dependencies);
	goto retry;
}

err = xas_error(&xas);
if (WARN_ON(!err && entry))
	dma_fence_put(entry);
else if (err)
	dma_fence_put(fence);

return err;

Thoughts?


>   
> -	return ret;
> +	return xas_error(&xas);
>   }
>   EXPORT_SYMBOL(drm_sched_job_add_dependency);
>   

