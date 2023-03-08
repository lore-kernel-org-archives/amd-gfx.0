Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D41C64EC4
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Mar 2023 16:20:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A38010E63A;
	Wed,  8 Mar 2023 16:20:40 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E98010E63A
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Mar 2023 16:20:39 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 j19-20020a05600c1c1300b003e9b564fae9so1707143wms.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Mar 2023 08:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1678292438;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oV/5Z4BZptFj6w41sgnnsoknw+IZkNVl07Nznvrhvww=;
 b=ZAx1eB4YJWfLjFZPjakZq7mkH0REzRtxbSm5X5IRM/B8HQPtncPLttm+3UVhV6LWv4
 b2jWZxGHH/cfsBLn2VfwvzrDPy1bGqk5Agw9dWDHg6H0HbBbXACSD31gUKApwyLaqRtO
 UnWOHrp0yK7rjHy+zzRzayb5tpm//vmQ4D+36zza8I0eHgtDuAQXOl0fuvTtxi7B8v0Y
 iddQkLpIyVGV3K8hh/bJMlVFa9LWd7fTkc3QP6HcNvd4zO1WZ14lanfncsZcy1EOO9P4
 ML5qXAZOuYXM0qcpfvQMoxKQBdVLrNBCYoVnxzJNyRjcPk81KXN1XUDg+q8YkRsNoKMk
 LgRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678292438;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oV/5Z4BZptFj6w41sgnnsoknw+IZkNVl07Nznvrhvww=;
 b=c7WFonjhRlKUmBiO5py4rRY5FT7PaAoyBLctcZmobLdQYEFSaFkYHf8hbd9u3+E5YG
 QjpIUoLXRWOizh7HGp9KzzSCX50q17PerXNbI9yNSDcsD35Cm6iPnpbFWvS8ogBg0GrD
 zF1VM8qjOL/tOww31heuNe1gReyQmJWABcTQPkZzdiHvAgEQ9Fw6zbiduWnuooDqs8hn
 NBTOkVZOK5qVsIr5qA1WlOT5WQXZ4iY/ibv5T6VsN4zXqUTSwaogOQdN6NGZ3N1d7hHK
 /xiajle871o+9s0cSyE6+IzHZf49V4lFrZ5tVsYjlFVBiBbh++TpmjFPQhLrEXfVhqsY
 XtNw==
X-Gm-Message-State: AO0yUKWQuRU1fdgOCBISOZlfF/tkRidvniYm0Ov/sfrc1QWEceyovRn7
 h2aypVvxyn0ujbb1+iJwLpkl7Hbvq2E=
X-Google-Smtp-Source: AK7set+2TioG98W/HHf1EIwK+ZQaQRrrnher/CARjFZ2UAq5zGx2+XqfGET3nsMCzKPrpyfYvFddPw==
X-Received: by 2002:a05:600c:3544:b0:3e8:35a2:6abf with SMTP id
 i4-20020a05600c354400b003e835a26abfmr16110600wmq.23.1678292437657; 
 Wed, 08 Mar 2023 08:20:37 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:423c:7396:17af:cdf?
 ([2a02:908:1256:79a0:423c:7396:17af:cdf])
 by smtp.gmail.com with ESMTPSA id
 e5-20020a5d5945000000b002c3f9404c45sm15509127wri.7.2023.03.08.08.20.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Mar 2023 08:20:37 -0800 (PST)
Message-ID: <2d7565f5-8ca2-feff-2619-3c7942fb653a@gmail.com>
Date: Wed, 8 Mar 2023 17:20:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] drm/amdkfd: Fixed kfd_process cleanup on module exit.
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>,
 "Belanger, David" <David.Belanger@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230306215808.2903387-1-david.belanger@amd.com>
 <92f89f03-dfa8-0f50-309c-69c7c22541d8@amd.com>
 <DM6PR12MB482867775D93C72A95ED5C3099B79@DM6PR12MB4828.namprd12.prod.outlook.com>
 <b38285d6-c7c5-3fa3-1cda-0fc8b430feb1@gmail.com>
 <2c36c501-652b-4535-8507-ca9b1f1045b7@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <2c36c501-652b-4535-8507-ca9b1f1045b7@amd.com>
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

Am 08.03.23 um 17:17 schrieb Felix Kuehling:
> On 2023-03-08 04:07, Christian König wrote:
>> Am 07.03.23 um 16:28 schrieb Belanger, David:
>>> [AMD Official Use Only - General]
>>>
>>>
>>> The test case is a python program that will load the driver, do some 
>>> operations, then unload the driver.
>>
>> What do you mean with unloading the driver? Removing the module? Or 
>> destroying the device?
>>
>>> When the driver exists, there is still the python process space 
>>> around holding on the address space.
>>> When the python process space exits, the mmu_notifier gets called 
>>> but the driver has already been unloaded.
>>>
>>> The goal of the fix is to address case where there could be 
>>> outstanding address space / worker threads for process
>>> cleanup that needs to be cleared/completed at exit time.
>>
>> Yeah and when the module is unloaded this is a completely futile effort.
>>
>> The general upstream approach is to take references on the struct 
>> device and module and prevent unloading as long as those references 
>> exists.
>
> That's not how it always works. In case of RCU callbacks, the 
> documented strategy is to use rcu_barrier in the module exit function 
> to ensure the grace period and all callbacks have completed 
> (https://www.kernel.org/doc/html/latest/RCU/rcubarrier.html). 
> mmu_notifier_synchronize is meant to do something similar for pending 
> mmu_notifier_put work 
> (https://elixir.bootlin.com/linux/v6.2.2/source/mm/mmu_notifier.c#L1116).
>
> But this implies that we need to call mmu_notifier_put for all the MMU 
> notifiers registered by the module first. I think closing /dev/kfd 
> drops the module reference count, but the MMU notifiers we register 
> for process cleanup persist until the address space is destroyed. We 
> need to trigger that cleanup for any processes that still exist in 
> that state when the module is unloaded. Or we need to find a way to 
> increment the module refcount for every process that registers a KFD 
> cleanup MMU notifier.

The later is what I've meant. Cleaning up when the module unloads is 
certainly possible as well, but harder to get right.

And I don't really see an use case that we should do the cleanup way.

Regards,
Christian.

>
> Regards,
>   Felix
>
>
>>
>>
>> The device might be non-functional any more (because for example of 
>> hot plug), but the driver should never be unloaded before the python 
>> program exits.
>>
>> Regards,
>> Christian.
>>
>>>
>>> Regards,
>>> David B.
>>>
>>>> -----Original Message-----
>>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>>> Sent: Tuesday, March 7, 2023 2:05 AM
>>>> To: Belanger, David <David.Belanger@amd.com>; amd-
>>>> gfx@lists.freedesktop.org
>>>> Subject: Re: [PATCH] drm/amdkfd: Fixed kfd_process cleanup on module
>>>> exit.
>>>>
>>>> Am 06.03.23 um 22:58 schrieb David Belanger:
>>>>> Handle case when module is unloaded (kfd_exit) before a process space
>>>>> (mm_struct) is released.
>>>> Well that should never ever happen in the first place. It sounds 
>>>> like we are
>>>> missing grabbing module references.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> Signed-off-by: David Belanger <david.belanger@amd.com>
>>>>> ---
>>>>>    drivers/gpu/drm/amd/amdkfd/kfd_module.c  |  4 ++
>>>>>    drivers/gpu/drm/amd/amdkfd/kfd_process.c | 57
>>>> ++++++++++++++++++++++++
>>>>>    2 files changed, 61 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_module.c
>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_module.c
>>>>> index 09b966dc3768..8ef4bd9e4f7d 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_module.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_module.c
>>>>> @@ -26,6 +26,9 @@
>>>>>    #include "kfd_priv.h"
>>>>>    #include "amdgpu_amdkfd.h"
>>>>>
>>>>> +void kfd_cleanup_processes(void);
>>>>> +
>>>>> +
>>>>>    static int kfd_init(void)
>>>>>    {
>>>>>        int err;
>>>>> @@ -77,6 +80,7 @@ static int kfd_init(void)
>>>>>
>>>>>    static void kfd_exit(void)
>>>>>    {
>>>>> +    kfd_cleanup_processes();
>>>>>        kfd_debugfs_fini();
>>>>>        kfd_process_destroy_wq();
>>>>>        kfd_procfs_shutdown();
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>> index ebabe92f7edb..b5b28a32639d 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>> @@ -1181,6 +1181,17 @@ static void 
>>>>> kfd_process_notifier_release(struct
>>>> mmu_notifier *mn,
>>>>>            return;
>>>>>
>>>>>        mutex_lock(&kfd_processes_mutex);
>>>>> +    /*
>>>>> +     * Do early return if p is not in the table.
>>>>> +     *
>>>>> +     * This could potentially happen if this function is called 
>>>>> concurrently
>>>>> +     * by mmu_notifier and by kfd_cleanup_pocesses.
>>>>> +     *
>>>>> +     */
>>>>> +    if (!hash_hashed(&p->kfd_processes)) {
>>>>> +        mutex_unlock(&kfd_processes_mutex);
>>>>> +        return;
>>>>> +    }
>>>>>        hash_del_rcu(&p->kfd_processes);
>>>>>        mutex_unlock(&kfd_processes_mutex);
>>>>>        synchronize_srcu(&kfd_processes_srcu);
>>>>> @@ -1200,6 +1211,52 @@ static const struct mmu_notifier_ops
>>>> kfd_process_mmu_notifier_ops = {
>>>>>        .free_notifier = kfd_process_free_notifier,
>>>>>    };
>>>>>
>>>>> +
>>>>> +void kfd_cleanup_processes(void)
>>>>> +{
>>>>> +    struct kfd_process *p;
>>>>> +    unsigned int temp;
>>>>> +
>>>>> +    /*
>>>>> +     * Iterate over remaining processes in table, calling 
>>>>> notifier release
>>>>> +     * to free up notifier and process resources.
>>>>> +     *
>>>>> +     * This code handles the case when driver is unloaded before all
>>>> mm_struct
>>>>> +     * are released.
>>>>> +     */
>>>>> +    int idx = srcu_read_lock(&kfd_processes_srcu);
>>>>> +
>>>>> +    hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
>>>>> +        if (p) {
>>>>> +            /*
>>>>> +             * Obtain a reference on p to avoid a late
>>>> mmu_notifier release
>>>>> +             * call triggering freeing the process.
>>>>> +             */
>>>>> +
>>>>> +            kref_get(&p->ref);
>>>>> +
>>>>> +            srcu_read_unlock(&kfd_processes_srcu, idx);
>>>>> +
>>>>> + kfd_process_notifier_release(&p->mmu_notifier, p-
>>>>> mm);
>>>>> +
>>>>> +            kfd_unref_process(p);
>>>>> +
>>>>> +            idx = srcu_read_lock(&kfd_processes_srcu);
>>>>> +        }
>>>>> +    }
>>>>> +    srcu_read_unlock(&kfd_processes_srcu, idx);
>>>>> +
>>>>> +    /*
>>>>> +     * Must be called after all mmu_notifier_put are done and before
>>>>> +     * kfd_process_wq is released.
>>>>> +     *
>>>>> +     * Ensures that all outstanding free_notifier gets called, 
>>>>> triggering the
>>>> release
>>>>> +     * of the process.
>>>>> +     */
>>>>> +    mmu_notifier_synchronize();
>>>>> +}
>>>>> +
>>>>> +
>>>>>    static int kfd_process_init_cwsr_apu(struct kfd_process *p, 
>>>>> struct file
>>>> *filep)
>>>>>    {
>>>>>        unsigned long  offset;
>>

