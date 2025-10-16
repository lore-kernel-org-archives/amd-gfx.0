Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F5DDCCD194
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Oct 2025 08:56:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D990C10E2EC;
	Thu, 16 Oct 2025 08:56:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="Q+F60BvF";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28D6710E2E8
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Oct 2025 08:56:17 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-3ee12a63af1so316382f8f.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Oct 2025 01:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1760604976; x=1761209776;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ld4JaQdDubeY+xBbuBTlIAZgwZbmofY6qMW6Qv7PyXI=;
 b=Q+F60BvFuiE/1XxOiFcVHzMZRqOoiIXNd7WyTWEDKHezKTTDlKBJLAfKOfaFugz/4z
 fVzNu+7FDnbAMv185vlYzNvqZIJtmGeFkVJTGTciNN1RusDkZ+WwbELT0+/RoDbHgF34
 UAFaq1OAlBVzi6IlqKh+u4yTtWUUl84+k2ZMj6esX+TiCmUpzfWShCXYJKV2vszUSNVT
 gkYRJnreEJEX7ut4ooql04Aj2GT0GhnFwyHCGLjekljMrozJpg23qOw49bmOFQnBat64
 RUI7jfJv98J0fdj3Up+YlGXW6z0CEBSNbwJOKpQY81iWKNyy8xttIIu3TNDjjskcVU65
 BC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760604976; x=1761209776;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ld4JaQdDubeY+xBbuBTlIAZgwZbmofY6qMW6Qv7PyXI=;
 b=EyxfweqXpl1588JnzimpkzJ9b+T3JXpIZPVZCF/kSkVR3lYffKF4yG4NS9dgGnS4Ja
 4By7bFsZG/DKiY+oWtR4tjGLDJ8tiOd8bAxnXZ04T42LRxuwd5H9M6qDSld0GSITOcb9
 UnU601lMdDZbDogmDRzAdmF7QCd1Tr7qoRbFnyXQTgGtagzX8yOyMQwD8c8yfMb8R2SA
 lTUaks+/ymIkoPdHqWyo6iilHuaMKfHHszTqcvqA8sNgk5EExLklqbS/HB8GDLX35Vjo
 XCRldnegetlE3RxCvhHZOkDZoZt+QRCKDuMBSWfzWiJ2P2lF1h3vSNrmtZoF1ni+Qn4Y
 FjVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRQCvECt3aKRNU8le9JWwviJfQmYPBF0v0TEDLLLsYIIY/prX05BVDBNyqzcX2+CHX5WUeCVuB@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyPm1SD2xwr7+oPkHoQ45r7D+thrOt21jSj36XayN2BqVnPCvNK
 cW0CVeTwY5AsZK/MdPvktq/aDTSs5udCOW6Ak/O3iHXLrDLmpZOwB9m3SUqpzlgYjTtj4VwR+sv
 nnwxn
X-Gm-Gg: ASbGncutr5jyiXo9xu0vNMi+8NricDxaLXVDBD5FQjBQtYwaWQAx/fAC8llPHnXmmBP
 3jIdRbzA+QMidJ+CASnSymYOmo9vlmv4t2Yg7Xxp/DmX9Gj6PkFjTNjqlDV3z1BJbZc+683wz6w
 Hs3IhYvp6Wv4MxGyCzwd2/YhZVt6rTxQKlTXAPUIsMYPlvPmi0jBqY0v6n6401q2X53xI0g0HiD
 bxpbxB495fadO49kjWrHBhyck2dpzAvLBu4/sHN3SqVgQTLKlMGitPrBdNZm5Kq7Ilo0urs03Cf
 gZ9AP2/flo26Z8YS/vhzIw4liBkSMyvN0AG55FA6qgykZIjaZMywv6a47EF3hqO7hqSL1Meayfs
 FBarZfAQgIHSXfOB5MNMpS1uiwPyLgryPF25RoIcHtKlBRBS7xT1zg831LkTAwjbFlIwMAhMzYv
 +V27h73uMC/B0n6KoiR/JvjC8xXPdaSt4zXQOc
X-Google-Smtp-Source: AGHT+IHUVIApC2zyH00jn35B6TMEEcyyTBTdVThnf5X2UhcsFjmJvBt+pvinO2s3vyx4e99EGrePig==
X-Received: by 2002:a05:6000:603:b0:425:8bff:69fe with SMTP id
 ffacd0b85a97d-4266e8e6c55mr20181128f8f.57.1760604975502; 
 Thu, 16 Oct 2025 01:56:15 -0700 (PDT)
Received: from [192.168.0.101] ([90.242.12.242])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5cf790sm32280768f8f.28.2025.10.16.01.56.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Oct 2025 01:56:15 -0700 (PDT)
Message-ID: <d5ea9ed0-d599-4b9f-92c8-a2e711371017@ursulin.net>
Date: Thu, 16 Oct 2025 09:56:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/15] dma-buf: detach fence ops on signal
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
References: <20251013143502.1655-1-christian.koenig@amd.com>
 <20251013143502.1655-5-christian.koenig@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20251013143502.1655-5-christian.koenig@amd.com>
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


On 13/10/2025 14:48, Christian König wrote:
> When neither a release nor a wait operation is specified it is possible
> to let the dma_fence live on independent of the module who issued it.
> 
> This makes it possible to unload drivers and only wait for all their
> fences to signal.

Have you looked at whether the requirement to not have the release and 
wait callbacks will exclude some drivers from being able to benefit from 
this?

Regards,

Tvrtko
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/dma-buf/dma-fence.c | 16 ++++++++++++----
>   include/linux/dma-fence.h   |  4 ++--
>   2 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index 982f2b2a62c0..39f73edf3a33 100644
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c
> @@ -374,6 +374,14 @@ int dma_fence_signal_timestamp_locked(struct dma_fence *fence,
>   				      &fence->flags)))
>   		return -EINVAL;
>   
> +	/*
> +	 * When neither a release nor a wait operation is specified set the ops
> +	 * pointer to NULL to allow the fence structure to become independent
> +	 * who originally issued it.
> +	 */
> +	if (!fence->ops->release && !fence->ops->wait)
> +		RCU_INIT_POINTER(fence->ops, NULL);
> +
>   	/* Stash the cb_list before replacing it with the timestamp */
>   	list_replace(&fence->cb_list, &cb_list);
>   
> @@ -513,7 +521,7 @@ dma_fence_wait_timeout(struct dma_fence *fence, bool intr, signed long timeout)
>   	rcu_read_lock();
>   	ops = rcu_dereference(fence->ops);
>   	trace_dma_fence_wait_start(fence);
> -	if (ops->wait) {
> +	if (ops && ops->wait) {
>   		/*
>   		 * Implementing the wait ops is deprecated and not supported for
>   		 * issuer independent fences, so it is ok to use the ops outside
> @@ -578,7 +586,7 @@ void dma_fence_release(struct kref *kref)
>   	}
>   
>   	ops = rcu_dereference(fence->ops);
> -	if (ops->release)
> +	if (ops && ops->release)
>   		ops->release(fence);
>   	else
>   		dma_fence_free(fence);
> @@ -614,7 +622,7 @@ static bool __dma_fence_enable_signaling(struct dma_fence *fence)
>   
>   	rcu_read_lock();
>   	ops = rcu_dereference(fence->ops);
> -	if (!was_set && ops->enable_signaling) {
> +	if (!was_set && ops && ops->enable_signaling) {
>   		trace_dma_fence_enable_signal(fence);
>   
>   		if (!ops->enable_signaling(fence)) {
> @@ -1000,7 +1008,7 @@ void dma_fence_set_deadline(struct dma_fence *fence, ktime_t deadline)
>   
>   	rcu_read_lock();
>   	ops = rcu_dereference(fence->ops);
> -	if (ops->set_deadline && !dma_fence_is_signaled(fence))
> +	if (ops && ops->set_deadline && !dma_fence_is_signaled(fence))
>   		ops->set_deadline(fence, deadline);
>   	rcu_read_unlock();
>   }
> diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
> index 38421a0c7c5b..e1ba1d53de88 100644
> --- a/include/linux/dma-fence.h
> +++ b/include/linux/dma-fence.h
> @@ -425,7 +425,7 @@ dma_fence_is_signaled_locked(struct dma_fence *fence)
>   
>   	rcu_read_lock();
>   	ops = rcu_dereference(fence->ops);
> -	if (ops->signaled && ops->signaled(fence)) {
> +	if (ops && ops->signaled && ops->signaled(fence)) {
>   		rcu_read_unlock();
>   		dma_fence_signal_locked(fence);
>   		return true;
> @@ -461,7 +461,7 @@ dma_fence_is_signaled(struct dma_fence *fence)
>   
>   	rcu_read_lock();
>   	ops = rcu_dereference(fence->ops);
> -	if (ops->signaled && ops->signaled(fence)) {
> +	if (ops && ops->signaled && ops->signaled(fence)) {
>   		rcu_read_unlock();
>   		dma_fence_signal(fence);
>   		return true;

