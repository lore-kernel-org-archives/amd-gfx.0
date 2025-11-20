Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF41DCF8860
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Nov 2025 14:10:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50C5310E755;
	Thu, 20 Nov 2025 14:10:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="wUOaOX3x";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67C8D10E755
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 14:10:02 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4779adb38d3so7101595e9.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 06:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1763647801; x=1764252601; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eCHpy1o/ACTFMJgtD/aw3O86hM4JbHXhTf5b8jy+cHc=;
 b=wUOaOX3xgrsntnbtO2wbp3n7VULqo7ms0Umim59IGwdNncGMYZfE5hXaghROI96Tkj
 3uuA61A9MB5JN9zmqUROYlTl4hEgyQgnsndyJX+BESrLWsrp8MOGUNzJ5ABKQqgBwrOh
 3xd5kNnzkRF4p8QqL7Yxv777Zhhj2cSw2JhHcjdMVlYW3H4rvdP4Tj8iKZwI6Y0IfpIY
 BmxdWTHurJCykc0E4gOR5mcvYhGzh6S21HXqxP4JwvrqC4bJSuzjMrGhPclOSkuz3NH4
 7Lybk20WO4rFciMAGU8qpnbDv0O3TLXdHhLZ3XY5PXz71rZTb62TjOCuYdjWatImjRRi
 xTdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763647801; x=1764252601;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eCHpy1o/ACTFMJgtD/aw3O86hM4JbHXhTf5b8jy+cHc=;
 b=DV93KdvyPefple2nCVcR2xw0U4zXVL7x2MUxBOP0eZDsFeUlClLVyZUfF/379+v4qg
 jnRKwHSXNDHxHqb9rHbEAN1sw3+wu8N9DfdTex6Xri4G6mfBgqJM3WV+ROq7OGIrQkd0
 PjRnLOduU6mXLHH4xioLB/pxQCB2pXdqqQjjV1X4fBRWU+qCXAwtL31oodyxBAFVCHTC
 4y0nev+dVBkF8VUM4v7o+IWFTBJQlOGBhGRMXrASLgrPylhtg4TZY+ea69deupi4Wwy0
 t0h1B6+cAP9lZggfHKdWrpKfbmEVCyExlMfIhJUdowu5rbsadf6SA1oPGgGaSYS/VHxx
 FXLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAEpKRaSbFh+9SMmt2KKwlcZcmQH6nFpucoa1I0VKf30urAzYxBXefe9X534lO/MtXAPiHOuBc@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzbjz92ihSYFGbqBK6gRciieWIVRqjScX+N0WYmN6zowKLLC29f
 CwhPD6bl/AhiR32kulhxzGjvBQJP8IpvPaDWwuujeL1NjuIGJkqYhJhvfVT3aVBD5NA=
X-Gm-Gg: ASbGnctN8FKDWXpZVAa2/BSZLLLRCGNG/EA2aODUdbFdbJLavhY325zxGoLeHvx1YU2
 8uWhzgM84MisHX5oP7uh9z8JGk90wRY5w2TClVZf34QGN3f5PPRtZNi+D3iNsHjoHlthPbBfQZd
 7CuHaY8SRvR9mrAvk8zdmfNmrGlaKIgJkvB6+jy3lWiPRAt/AeQoh4P9rIy+M0WAWysf8mP0U/w
 3t0Gd6AJ8cST5ERekPNXfGpYMGlNq5754Rr8UBg2qc8hHJLVEJOIRsv4zpXmji5OtnsoY9P/bLv
 aEfgibW6fo0jvRDiLiJPp7n1/gjBj22AHnsnHGTzG3z68Mw8zk1LwB61uKxg647bR8bgtDgpyQu
 bL3u5q3KAHZw9+g5tKDPsryAtJ8uLuYotYWJ8ZezVHyVKVkm7v+nsYNOO5VWyhAfHKsMInY97a6
 9SKphRMWjC0+Wu4hKfS3sLxlQCI8Sl04kK6OotNNjNMIM=
X-Google-Smtp-Source: AGHT+IF3fFe6uHBbufSIu8dYBqLVhlYanBolrvml//L4SVgEuQ8hTozu3CVUaxX66a/P0gLZaYR88A==
X-Received: by 2002:a05:600c:1f0f:b0:46e:53cb:9e7f with SMTP id
 5b1f17b1804b1-477b8a8bd4fmr33404995e9.18.1763647800592; 
 Thu, 20 Nov 2025 06:10:00 -0800 (PST)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477b106a9b0sm111116985e9.11.2025.11.20.06.09.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Nov 2025 06:10:00 -0800 (PST)
Message-ID: <6f26a30f-7c66-4e88-a3bf-bfa41f7efa7b@ursulin.net>
Date: Thu, 20 Nov 2025 14:09:59 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/18] dma-buf: cleanup dma_fence_describe v3
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch,
 matthew.brost@intel.com, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 sumit.semwal@linaro.org
References: <20251113145332.16805-1-christian.koenig@amd.com>
 <20251113145332.16805-2-christian.koenig@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20251113145332.16805-2-christian.koenig@amd.com>
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


On 13/11/2025 14:51, Christian König wrote:
> The driver and timeline name are meaningless for signaled fences.
> 
> Drop them and also print the context number.
> 
> v2: avoid the calls when the BO is already signaled.
> v3: use same format as trace points for context and seqno.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/dma-buf/dma-fence.c | 20 +++++++++++---------
>   1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index c5d1478b28dd..b4f5c8635276 100644
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c
> @@ -997,19 +997,21 @@ EXPORT_SYMBOL(dma_fence_set_deadline);
>    */
>   void dma_fence_describe(struct dma_fence *fence, struct seq_file *seq)
>   {
> -	const char __rcu *timeline;
> -	const char __rcu *driver;
> +	const char __rcu *timeline = "";
> +	const char __rcu *driver = "";
> +	const char *signaled = "";
>   
>   	rcu_read_lock();
>   
> -	timeline = dma_fence_timeline_name(fence);
> -	driver = dma_fence_driver_name(fence);
> +	if (!dma_fence_is_signaled(fence)) {
> +		timeline = dma_fence_timeline_name(fence);
> +		driver = dma_fence_driver_name(fence);
> +		signaled = "un";
> +	}
>   
> -	seq_printf(seq, "%s %s seq %llu %ssignalled\n",
> -		   rcu_dereference(driver),
> -		   rcu_dereference(timeline),
> -		   fence->seqno,
> -		   dma_fence_is_signaled(fence) ? "" : "un");
> +	seq_printf(seq, "%llu:%llu %s %s %ssignalled\n",
> +		   fence->context, fence->seqno, timeline, driver,
> +		   signaled);
>   
>   	rcu_read_unlock();
>   }

I thought I r-b-ed this one but apparently not.

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

