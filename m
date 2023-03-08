Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6955DC678D5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Mar 2023 09:07:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCAE310E5BE;
	Wed,  8 Mar 2023 09:07:36 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F4B610E5B3
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Mar 2023 09:07:34 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id j11so43286891edq.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Mar 2023 01:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1678266453;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7p5V6Pnv+VZBdYZfY53QEB5DXtIK9qir6jbrOBEo5iw=;
 b=dXHw4Jp9rsUxKl5wr5LkVa5OzziHDOjveWSaUA7Wlg5ymT9jx/2+Ycfcigr1rB92vI
 MKLI2V9m3jbyW7Qz/hskkWYq42UKxSW3y6vCQ/v2j7xqvfhW+AdJ5pl4uBDJG8I5cezU
 w6QgVwzdMcsm9ZA0P319gyOGAKvy4tY8qdzeLDEGf8ygXzcqyLno7cA8Xi2tHTESfkzP
 hvplhjq871ynt6BpbO/F5I8DGd+iHWfhQBwOCrdiBvsa+5LLqd1sjp5W2acZ3Krnrj2Z
 CL8/M1gy7PHz2TONb3UW1VOm8bDbstd29NrCS5lZCYfHUipaZuJ2Icz+v1SkmufPkJe8
 z43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678266453;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7p5V6Pnv+VZBdYZfY53QEB5DXtIK9qir6jbrOBEo5iw=;
 b=qtzm/MwX8OvpjWSGYzZm9kBLB6ufJyq5urmEH78VB1fyBTpBeYhoeiVVHgBilPB7IP
 vWqdzIjYle0Jpo5Vbp4rij5ORB2hutKD1r/Ca3iUHa1xn8LboyEzLdnxHCi87r351dgs
 l64GlXPXXU9XBNe0jcx5P1ZJ6fQlWYXGmwngRxgResRDSqBWp74N5diZ8kGpkCj52OrT
 v/scTjCktiBZjoOcmf4dQozS2QeOvKnTqw+yMk1rz92FFsxDID2E4RVlNUOJGa4XB9LL
 8DlRC4P9sFHM27VAwmlufioPpYZBNPYcroaRJBthH991wMFI1gk6QeF48wOfVZJKHxbQ
 VufA==
X-Gm-Message-State: AO0yUKXYJMeU1BM+O/fRH9amfX7T1J9glFBYT3JkaMRETGxxUVVUVa/Y
 Yomj6CtfzuY0Cxjol6UV4UmuNAEMKwY=
X-Google-Smtp-Source: AK7set+u28Rx07PZ5SdjVqf77t7QqdpOdUQrIsSOSgm99QdAYT1934DDrZvna1Z6wnbLDf1wSmk+ag==
X-Received: by 2002:a17:907:a80f:b0:8b1:3a18:9daf with SMTP id
 vo15-20020a170907a80f00b008b13a189dafmr16207869ejc.74.1678266452890; 
 Wed, 08 Mar 2023 01:07:32 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:423c:7396:17af:cdf?
 ([2a02:908:1256:79a0:423c:7396:17af:cdf])
 by smtp.gmail.com with ESMTPSA id
 q2-20020a1709060e4200b009140707b475sm2976096eji.33.2023.03.08.01.07.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Mar 2023 01:07:32 -0800 (PST)
Message-ID: <b38285d6-c7c5-3fa3-1cda-0fc8b430feb1@gmail.com>
Date: Wed, 8 Mar 2023 10:07:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] drm/amdkfd: Fixed kfd_process cleanup on module exit.
Content-Language: en-US
To: "Belanger, David" <David.Belanger@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230306215808.2903387-1-david.belanger@amd.com>
 <92f89f03-dfa8-0f50-309c-69c7c22541d8@amd.com>
 <DM6PR12MB482867775D93C72A95ED5C3099B79@DM6PR12MB4828.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <DM6PR12MB482867775D93C72A95ED5C3099B79@DM6PR12MB4828.namprd12.prod.outlook.com>
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

Am 07.03.23 um 16:28 schrieb Belanger, David:
> [AMD Official Use Only - General]
>
>
> The test case is a python program that will load the driver, do some operations, then unload the driver.

What do you mean with unloading the driver? Removing the module? Or 
destroying the device?

> When the driver exists, there is still the python process space around holding on the address space.
> When the python process space exits, the mmu_notifier gets called but the driver has already been unloaded.
>
> The goal of the fix is to address case where there could be outstanding address space / worker threads for process
> cleanup that needs to be cleared/completed at exit time.

Yeah and when the module is unloaded this is a completely futile effort.

The general upstream approach is to take references on the struct device 
and module and prevent unloading as long as those references exists.

The device might be non-functional any more (because for example of hot 
plug), but the driver should never be unloaded before the python program 
exits.

Regards,
Christian.

>
> Regards,
> David B.
>
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Tuesday, March 7, 2023 2:05 AM
>> To: Belanger, David <David.Belanger@amd.com>; amd-
>> gfx@lists.freedesktop.org
>> Subject: Re: [PATCH] drm/amdkfd: Fixed kfd_process cleanup on module
>> exit.
>>
>> Am 06.03.23 um 22:58 schrieb David Belanger:
>>> Handle case when module is unloaded (kfd_exit) before a process space
>>> (mm_struct) is released.
>> Well that should never ever happen in the first place. It sounds like we are
>> missing grabbing module references.
>>
>> Regards,
>> Christian.
>>
>>> Signed-off-by: David Belanger <david.belanger@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdkfd/kfd_module.c  |  4 ++
>>>    drivers/gpu/drm/amd/amdkfd/kfd_process.c | 57
>> ++++++++++++++++++++++++
>>>    2 files changed, 61 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_module.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_module.c
>>> index 09b966dc3768..8ef4bd9e4f7d 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_module.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_module.c
>>> @@ -26,6 +26,9 @@
>>>    #include "kfd_priv.h"
>>>    #include "amdgpu_amdkfd.h"
>>>
>>> +void kfd_cleanup_processes(void);
>>> +
>>> +
>>>    static int kfd_init(void)
>>>    {
>>>    	int err;
>>> @@ -77,6 +80,7 @@ static int kfd_init(void)
>>>
>>>    static void kfd_exit(void)
>>>    {
>>> +	kfd_cleanup_processes();
>>>    	kfd_debugfs_fini();
>>>    	kfd_process_destroy_wq();
>>>    	kfd_procfs_shutdown();
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> index ebabe92f7edb..b5b28a32639d 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> @@ -1181,6 +1181,17 @@ static void kfd_process_notifier_release(struct
>> mmu_notifier *mn,
>>>    		return;
>>>
>>>    	mutex_lock(&kfd_processes_mutex);
>>> +	/*
>>> +	 * Do early return if p is not in the table.
>>> +	 *
>>> +	 * This could potentially happen if this function is called concurrently
>>> +	 * by mmu_notifier and by kfd_cleanup_pocesses.
>>> +	 *
>>> +	 */
>>> +	if (!hash_hashed(&p->kfd_processes)) {
>>> +		mutex_unlock(&kfd_processes_mutex);
>>> +		return;
>>> +	}
>>>    	hash_del_rcu(&p->kfd_processes);
>>>    	mutex_unlock(&kfd_processes_mutex);
>>>    	synchronize_srcu(&kfd_processes_srcu);
>>> @@ -1200,6 +1211,52 @@ static const struct mmu_notifier_ops
>> kfd_process_mmu_notifier_ops = {
>>>    	.free_notifier = kfd_process_free_notifier,
>>>    };
>>>
>>> +
>>> +void kfd_cleanup_processes(void)
>>> +{
>>> +	struct kfd_process *p;
>>> +	unsigned int temp;
>>> +
>>> +	/*
>>> +	 * Iterate over remaining processes in table, calling notifier release
>>> +	 * to free up notifier and process resources.
>>> +	 *
>>> +	 * This code handles the case when driver is unloaded before all
>> mm_struct
>>> +	 * are released.
>>> +	 */
>>> +	int idx = srcu_read_lock(&kfd_processes_srcu);
>>> +
>>> +	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
>>> +		if (p) {
>>> +			/*
>>> +			 * Obtain a reference on p to avoid a late
>> mmu_notifier release
>>> +			 * call triggering freeing the process.
>>> +			 */
>>> +
>>> +			kref_get(&p->ref);
>>> +
>>> +			srcu_read_unlock(&kfd_processes_srcu, idx);
>>> +
>>> +			kfd_process_notifier_release(&p->mmu_notifier, p-
>>> mm);
>>> +
>>> +			kfd_unref_process(p);
>>> +
>>> +			idx = srcu_read_lock(&kfd_processes_srcu);
>>> +		}
>>> +	}
>>> +	srcu_read_unlock(&kfd_processes_srcu, idx);
>>> +
>>> +	/*
>>> +	 * Must be called after all mmu_notifier_put are done and before
>>> +	 * kfd_process_wq is released.
>>> +	 *
>>> +	 * Ensures that all outstanding free_notifier gets called, triggering the
>> release
>>> +	 * of the process.
>>> +	 */
>>> +	mmu_notifier_synchronize();
>>> +}
>>> +
>>> +
>>>    static int kfd_process_init_cwsr_apu(struct kfd_process *p, struct file
>> *filep)
>>>    {
>>>    	unsigned long  offset;

