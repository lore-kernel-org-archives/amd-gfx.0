Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5055EC4332F
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Nov 2022 07:10:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2143E10E6E9;
	Fri,  4 Nov 2022 07:10:19 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E72710E6EA
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Nov 2022 07:10:14 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id bj12so10903994ejb.13
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Nov 2022 00:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ei6lh/GN2XQS6Vw7tlxjQlRnpFmDv7VT5d5Td/Gc6/s=;
 b=NDs2/NMWqcFKcoki4eXHbOfO6GKmUjQmdAB+pBJf1gVGfFTx6+CeMMtWSgCnnpFpCE
 pZXzerPOWMxrlUMdmUVjpG63GnMsW7s+yXpR8kSSbfRtHo1YEOmh9iZebZcPyjBGg/pT
 lB6D7mJwDXN6KXmlLxkW2tCb9BejWfqQA4gzIgFZgA31RVfORmmWOLRWzVeJ46TeFUYd
 7YrKhzl6L7Y99X/i+8x6rK0x0gB0SNSLmpn772gyVwREYHKae/dgpf5d0wT5HcArHriP
 QCHYrZ6ldNP6f8zzH5WJqzUIvazhEwTWXpyVJiw8Kn92ux93N7GnRxpknkeeUgKuMB7W
 IX0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ei6lh/GN2XQS6Vw7tlxjQlRnpFmDv7VT5d5Td/Gc6/s=;
 b=uBUDLz/ovP2AVnI7suP57cCpK5ePpGEcvlkJzE5BhRhAkVZVvYDI8RwpddZ82taSyH
 BvQJ2B1FsclO5AKrf49t+R8QzZCczy8S7adTcBlZP4Ektb6BICoq2UIbeVZkPFFauO5X
 n2CUn9jCjBtN+lyqYHkY8RWbL79L2b3oPaCz5bMvmavxESa+vOxBpIbdjkWPZQuIELd1
 +cotk7vY4+XMXbhj5ZOv+6ll9xCjE1Sy/qJWOTut05X2z3aXjdVUuppWEestkk/T0xKu
 cblqnwlRRr91DFzpMoG+iJ5NsrKcJUjuEgAxl2ZMw5SXitCzBhF31vCx7Bt19bteSM4a
 sg4A==
X-Gm-Message-State: ACrzQf3TrlOARhxBpHozbxDBXiLqTYy9/fG0cT2O5Qf4znKOOZRvJ8r8
 OsulBwVd8q/zPVhQnLkOhIo=
X-Google-Smtp-Source: AMsMyM6KZLFtZvN6GJlCav2SQTLLYW8rj8HO8oPMF/m7iH9JdKyTzsHleFXG1K1AT1+Hackn2tlD6A==
X-Received: by 2002:a17:907:2cea:b0:7a3:4ebe:5eb with SMTP id
 hz10-20020a1709072cea00b007a34ebe05ebmr32419328ejc.228.1667545812377; 
 Fri, 04 Nov 2022 00:10:12 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:13f7:f69a:a72b:6707?
 ([2a02:908:1256:79a0:13f7:f69a:a72b:6707])
 by smtp.gmail.com with ESMTPSA id
 gs18-20020a170906f19200b007306a4ecc9dsm1455549ejb.18.2022.11.04.00.10.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Nov 2022 00:10:11 -0700 (PDT)
Message-ID: <4a8e0373-779a-327e-4f98-a7f0a259688f@gmail.com>
Date: Fri, 4 Nov 2022 08:10:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] drm/amdgpu: workaround for TLB seq race
Content-Language: en-US
To: Philip Yang <yangp@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221102145811.17968-1-christian.koenig@amd.com>
 <7028da96-ca19-3ec5-b9a1-b2640157ba19@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <7028da96-ca19-3ec5-b9a1-b2640157ba19@amd.com>
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
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 03.11.22 um 22:18 schrieb Philip Yang:
>
> On 2022-11-02 10:58, Christian König wrote:
>> It can happen that we query the sequence value before the callback
>> had a chance to run.
>>
>> Work around that by grabbing the fence lock and releasing it again.
>> Should be replaced by hw handling soon.
>
> kfd_flush_tlb is always called after waiting for map/unmap to GPU 
> fence signalled, that means the callback is already executed

And exactly that's incorrect.

Waiting for the fence to signal means that the callback has started 
executing, but it doesn't mean that it is finished.

This can then result in one CPU racing with the callback handler and 
because of this you see the wrong TLB seq.

Regards,
Christian.

> and the sequence is increased if tlb flush is needed, so no such race 
> from KFD.
>
> I am not sure but seems the race does exist for amdgpu to grab vm and 
> schedule job.
>
> Acked-by: Philip Yang <Philip.Yang@amd.com>
>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index 9ecb7f663e19..e51a46c9582b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -485,6 +485,21 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm 
>> *vm, struct seq_file *m);
>>    */
>>   static inline uint64_t amdgpu_vm_tlb_seq(struct amdgpu_vm *vm)
>>   {
>> +    unsigned long flags;
>> +    spinlock_t *lock;
>> +
>> +    /*
>> +     * Work around to stop racing between the fence signaling and 
>> handling
>> +     * the cb. The lock is static after initially setting it up, 
>> just make
>> +     * sure that the dma_fence structure isn't freed up.
>> +     */
>> +    rcu_read_lock();
>> +    lock = vm->last_tlb_flush->lock;
>> +    rcu_read_unlock();
>> +
>> +    spin_lock_irqsave(lock, flags);
>> +    spin_unlock_irqrestore(lock, flags);
>> +
>>       return atomic64_read(&vm->tlb_seq);
>>   }

