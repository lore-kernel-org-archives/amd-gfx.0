Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D852ACCF9E3
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Oct 2025 15:05:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A34110E9D9;
	Thu, 30 Oct 2025 15:05:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zi5R4j3F";
	dkim-atps=neutral
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com
 [209.85.160.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D2A810E9D6
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 15:05:43 +0000 (UTC)
Received: by mail-qt1-f174.google.com with SMTP id
 d75a77b69052e-4ecfc3f4a13so10204791cf.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 08:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761836742; x=1762441542; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tBS9RgnsnpRaEHPmIuolWSg7H246dI6nS1xElcRsrNo=;
 b=Zi5R4j3FPfDZsRrA/8KMg0O3kkIaDz7upKd2JXTAd4BcqzUx9yJH86hlxdeYRYi4Ox
 hF6ziCIRB73ZfWozzL+X4VPhmDe7akfSLWLgzYlXSaqvLNfw9MXeDwCLnGtvhDvSYnhp
 PA5ayZkLkNePHh6+FxRggh7/QQB7WFlulIu8zxScm5qBD2AClevY8IP+mJy1SRi4jOrI
 AIBqfKW6OW64BJePSW85+27OVSFSa+KtJC8PZrr8dEzjuQQiH2Xk5ftxAC0IHeVoi3+S
 QI8pScBPnuCBV9ss2lS0jPQnSW946SHIvB2ehs3UOFY6tZAZ4sIaqXe2xANgyQ2d06dZ
 cE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761836742; x=1762441542;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tBS9RgnsnpRaEHPmIuolWSg7H246dI6nS1xElcRsrNo=;
 b=iW6ndGARyS6G3lalF3tGdmAwVMzsgrLCR1yazNb4MeeuCCgIJaCh00wa5BQPsyFUSC
 GrVUVJhPG7Sr+jlnaYXi9wAPh4PUO7T9Fn+N/kvXRMexkSD9eoGhabKKyH1K8wW+bEHv
 WZ7Tps8fa/xrAaCSoGk0vzI0eyhs2aqK0sUMp3X1op66jbmSiKF2UjJdWAHMcV6rFGnQ
 LLbx7rq2sqXaXY7ub9T2gOt5Brmlz2sLhjqrqPGyHhEpE+FQD2DilKOR5dau8uDugc/u
 522RkfyAVdvnFF4o+JGi2tDclU3Av2jpb2X9aeyrs48GY+Ytdi96s9x65RraWTD0f+D9
 gWSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXStWTdBxs9cE7f2UYBycvWidxQ/Mrc7tG/zrRURPjMZUfQP2ef5I7uV74z90z1NnP0plS0n0c8@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyLa0raJtDBgtaIlj9NHJ04zrv7IfBlxPmU+2dvB5Hzlzvoa/dQ
 aqEDhPZThsXSJBAC5pyWUdyRktN8ECz8imUEy7nQs0bfpyPrODbWE4z8
X-Gm-Gg: ASbGncvplK1fZat7+QsbBLmA8Yr7vnIFnDXLWerJYrviHwX9KIFR83Fc6vn3SrbJP1f
 hqt/6wN4EjqTUPdS3KMjJoTH5IleWIogMl5qC+wS/GtKQ/0fHYu6+OM/0roB6YWOWmaGsmuCXvZ
 9uBdpXx0WT6Do1wslIdKYu+cWTJ4viKBjsw8JKwkn+r/RiCL2Kg1joLdFbsydLkUtNfz1kAsNWI
 k2FIIwyBUaON4We02QdYKfRrlNjfQhySUgNZZFxaZgto3whlesxQ/ijkabrYGt3l9yv5mOq1usW
 7MJlgbBwWgrunkZs9UbPTV59VINESO7VAIvV91TvDg5mRsH4hHLRW9+cs8jyFfaDuxBMR20/DVW
 KPc9q1ariIuc2UX229FpIHsOsjBSnmDgclkbPi+UknIh05df6yj6NOIHDFuZkvI7JRbOS3jChc3
 lzxG7euZysXONiXOzfsuzlbtjNzITE8cnTKf4Sx5rxNA==
X-Google-Smtp-Source: AGHT+IGKiOB1+rCktccqrf6rePLF+UtBi7EHCZIvo5UN0zh3qpUdgWZ7f8rHSzlonNRJyJeOLFBe5g==
X-Received: by 2002:a05:622a:198c:b0:4b5:ea1f:77f4 with SMTP id
 d75a77b69052e-4ed2213b260mr42641971cf.64.1761836742220; 
 Thu, 30 Oct 2025 08:05:42 -0700 (PDT)
Received: from [10.254.120.28] (mkmvpn.amd.com. [165.204.54.211])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f254abccbsm1263454585a.31.2025.10.30.08.05.40
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 30 Oct 2025 08:05:41 -0700 (PDT)
Message-ID: <45afa337-6b46-4119-abd6-f0d79a96c7fd@gmail.com>
Date: Thu, 30 Oct 2025 16:05:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/15] dma-buf: detach fence ops on signal
To: phasta@kernel.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch,
 tursulin@ursulin.net
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
References: <20251013143502.1655-1-christian.koenig@amd.com>
 <20251013143502.1655-5-christian.koenig@amd.com>
 <d4283e9220df6ce6cd9ec2ae0b011f4931f4acf5.camel@mailbox.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <d4283e9220df6ce6cd9ec2ae0b011f4931f4acf5.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8
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

On 10/17/25 11:14, Philipp Stanner wrote:
> On Mon, 2025-10-13 at 15:48 +0200, Christian König wrote:
>> When neither a release nor a wait operation is specified it is possible
>> to let the dma_fence live on independent of the module who issued it.
>>
>> This makes it possible to unload drivers and only wait for all their
>> fences to signal.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>  drivers/dma-buf/dma-fence.c | 16 ++++++++++++----
>>  include/linux/dma-fence.h   |  4 ++--
>>  2 files changed, 14 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
>> index 982f2b2a62c0..39f73edf3a33 100644
>> --- a/drivers/dma-buf/dma-fence.c
>> +++ b/drivers/dma-buf/dma-fence.c
>> @@ -374,6 +374,14 @@ int dma_fence_signal_timestamp_locked(struct dma_fence *fence,
>>  				      &fence->flags)))
>>  		return -EINVAL;
>>  
>> +	/*
>> +	 * When neither a release nor a wait operation is specified set the ops
>> +	 * pointer to NULL to allow the fence structure to become independent
>> +	 * who originally issued it.
>> +	 */
>> +	if (!fence->ops->release && !fence->ops->wait)
>> +		RCU_INIT_POINTER(fence->ops, NULL);
> 
> OK, so the basic idea is that still living fences can't access driver
> data or driver code anymore after the driver is unloaded. Good and
> well, nice idea. We need something like that in Rust, too.
> 
> That's based on the rule that the driver, on unload, must signal all
> the fences. Also OK.
> 
> However, how can that possibly fly by relying on the release callback
> not being implemented? How many users don't need it, and could those
> who implement release() be ported to.. sth else?

As far as I can see the only one who really needs the ->release callback for technical reasons is the DRM scheduler fence and the dma_fence_array and dma_fence_chain containers. 

For the DRM scheduler fence it is just the finished fence which needs to drop the reference to the scheduled fence because we can now be sure that nobody can cast the fence any more.

For the dma_fence_array we could actually clean up the state on signaling, but that would need some more cleanup in the framework.

For the dma_fence_chain it is a must have to avoid potential kernel stack overrun.

Apart from that all drivers should be able to cleanup their internal state necessary for signaling when they actually signal.

Regards,
Christian.

> 
> 
> P.
> 
>> +
>>  	/* Stash the cb_list before replacing it with the timestamp */
>>  	list_replace(&fence->cb_list, &cb_list);
>>  
>> @@ -513,7 +521,7 @@ dma_fence_wait_timeout(struct dma_fence *fence, bool intr, signed long timeout)
>>  	rcu_read_lock();
>>  	ops = rcu_dereference(fence->ops);
>>  	trace_dma_fence_wait_start(fence);
>> -	if (ops->wait) {
>> +	if (ops && ops->wait) {
>>  		/*
>>  		 * Implementing the wait ops is deprecated and not supported for
>>  		 * issuer independent fences, so it is ok to use the ops outside
>> @@ -578,7 +586,7 @@ void dma_fence_release(struct kref *kref)
>>  	}
>>  
>>  	ops = rcu_dereference(fence->ops);
>> -	if (ops->release)
>> +	if (ops && ops->release)
>>  		ops->release(fence);
>>  	else
>>  		dma_fence_free(fence);
>> @@ -614,7 +622,7 @@ static bool __dma_fence_enable_signaling(struct dma_fence *fence)
>>  
>>  	rcu_read_lock();
>>  	ops = rcu_dereference(fence->ops);
>> -	if (!was_set && ops->enable_signaling) {
>> +	if (!was_set && ops && ops->enable_signaling) {
>>  		trace_dma_fence_enable_signal(fence);
>>  
>>  		if (!ops->enable_signaling(fence)) {
>> @@ -1000,7 +1008,7 @@ void dma_fence_set_deadline(struct dma_fence *fence, ktime_t deadline)
>>  
>>  	rcu_read_lock();
>>  	ops = rcu_dereference(fence->ops);
>> -	if (ops->set_deadline && !dma_fence_is_signaled(fence))
>> +	if (ops && ops->set_deadline && !dma_fence_is_signaled(fence))
>>  		ops->set_deadline(fence, deadline);
>>  	rcu_read_unlock();
>>  }
>> diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
>> index 38421a0c7c5b..e1ba1d53de88 100644
>> --- a/include/linux/dma-fence.h
>> +++ b/include/linux/dma-fence.h
>> @@ -425,7 +425,7 @@ dma_fence_is_signaled_locked(struct dma_fence *fence)
>>  
>>  	rcu_read_lock();
>>  	ops = rcu_dereference(fence->ops);
>> -	if (ops->signaled && ops->signaled(fence)) {
>> +	if (ops && ops->signaled && ops->signaled(fence)) {
>>  		rcu_read_unlock();
>>  		dma_fence_signal_locked(fence);
>>  		return true;
>> @@ -461,7 +461,7 @@ dma_fence_is_signaled(struct dma_fence *fence)
>>  
>>  	rcu_read_lock();
>>  	ops = rcu_dereference(fence->ops);
>> -	if (ops->signaled && ops->signaled(fence)) {
>> +	if (ops && ops->signaled && ops->signaled(fence)) {
>>  		rcu_read_unlock();
>>  		dma_fence_signal(fence);
>>  		return true;
> 

