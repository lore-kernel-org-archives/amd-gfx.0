Return-Path: <SRS0=AiXT=JE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MIME_HTML_MOSTLY,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A5CC433ED
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Apr 2021 10:29:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 439BC61242
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Apr 2021 10:29:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 439BC61242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3ADC6E8F1;
	Wed,  7 Apr 2021 10:29:04 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93DDF6E903
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Apr 2021 10:29:02 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id hq27so26742023ejc.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Apr 2021 03:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language;
 bh=/o4xfQTYf26P7DssuavQTeEfVyuYjeFCxaER96foT9k=;
 b=daAN/iDho/cqLhfmzEP2GlVw7p4a8LF4JbtklDVM7NSxVQO2mT1jyAqiLm7jzkD1I3
 PSM815+n0H+D+phHv5DQZEF6ddRu1pkmXW2fFx+erllx/xZ78mQjOF3iKVIzJ8UAGZ5W
 3znt1wFQPf2ZqcS8g+bw1fu1EI5H1szTaQ6hYpXb1hxpFtf1ERaqGg/R82FMfeH0UaSJ
 ZKDyk9hhKKC4ddjl/ttBf1Flew9243BqGgkFER80TDry0SPp1OZGRgYlfLvY9wgKBvfQ
 wJiBy/gBaxw3UACDB4JlnvtA5Y4Tdha3ujotQmlRxd+e4848iJV6vl4QDMAU6CQ0H68j
 6Xbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language;
 bh=/o4xfQTYf26P7DssuavQTeEfVyuYjeFCxaER96foT9k=;
 b=dc6t9uD1ELBi+XXD1pgUkhwI1D5DShzemVsmqENdITW/k5TIGimG661XtQlEZGpc+T
 NAMAfmwe0fi891UwRDooW+N13ebxeJQUePWm3qKnpMeNPBcZCdkL9DL6x09LcRzebv62
 N7sXTP1qX+V4X8+JIvp0hfHyYsWgxDNVz5jVf7wsiVhfJby2O0iTnqNazxSUfuRKEXIW
 JW/ZWwnTg725jDQpjmqMRogjD71PuImqLeFQiwSORDsh/kVkLH6CYZU7jYXA7Pz/XzgQ
 QwEratUkNalQBhUGKuYlleYmudj2P9lvK7wobzLwjDc4ZKIZxAOianUjTNlcVVlwg3cL
 DBkA==
X-Gm-Message-State: AOAM533QnAKf5Dv7gsiXsTFOvyreeI3hqP67jumk+iVLMZgaCkeaiKDg
 N33kkoR/CtfOUUnu01ttss9Gx2VJpB8=
X-Google-Smtp-Source: ABdhPJxohaUjIlAyw8t1tS4mRk3COT/uJJWmHJm3l+6K7NESDHHP9/6nK8E2V9xZgTUsLbfXxA0KIg==
X-Received: by 2002:a17:906:f2c4:: with SMTP id
 gz4mr2934434ejb.369.1617791341143; 
 Wed, 07 Apr 2021 03:29:01 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:c8cb:bea6:b85a:47d0?
 ([2a02:908:1252:fb60:c8cb:bea6:b85a:47d0])
 by smtp.gmail.com with ESMTPSA id t14sm12349810ejc.121.2021.04.07.03.28.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Apr 2021 03:29:00 -0700 (PDT)
Subject: Re: [PATCH 0/4] Refine GPU recovery sequence to enhance its stability
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Li, Dennis" <Dennis.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
References: <20210318072339.28736-1-Dennis.Li@amd.com>
 <d40648ba-9948-5442-23ed-d352f824f8f9@amd.com>
 <DM5PR12MB25330F3CD92C587C2E921424ED699@DM5PR12MB2533.namprd12.prod.outlook.com>
 <MN2PR12MB3775531A74B886A207134B1583699@MN2PR12MB3775.namprd12.prod.outlook.com>
 <DM5PR12MB253379E8C89D8A20C8A0245AED699@DM5PR12MB2533.namprd12.prod.outlook.com>
 <378fdffb-99b5-2a14-736d-a06f310b040c@amd.com>
 <1e37bb4d-f54d-1b7e-4632-94cfcf749528@amd.com>
 <51d7873d-cf35-6be5-79c2-024937c67f6a@amd.com>
 <29ffe63b-9049-824f-84fc-a92fdb451e0d@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <e37bdceb-cdb2-a826-21cf-8cb88748be08@gmail.com>
Date: Wed, 7 Apr 2021 12:28:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <29ffe63b-9049-824f-84fc-a92fdb451e0d@amd.com>
Content-Language: en-US
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
Content-Type: multipart/mixed; boundary="===============0255588802=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============0255588802==
Content-Type: multipart/alternative;
 boundary="------------20DEFBBAF707723C1C40FFA2"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------20DEFBBAF707723C1C40FFA2
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Andrey,

Am 06.04.21 um 23:22 schrieb Andrey Grodzovsky:
>
> Hey Christian, Denis, see bellow -
>
> On 2021-04-06 6:34 a.m., Christian König wrote:
>> Hi Andrey,
>>
>> well good question. My job is to watch over the implementation and 
>> design and while I always help I can adjust anybodies schedule.
>>
>> Is the patch to print a warning when the hardware is accessed without 
>> holding the locks merged yet? If not then that would probably be a 
>> good starting point.
>
>
> It's merged into amd-staging-drm-next and since I work on 
> drm-misc-next I will cherry-pick it into there.
>

Ok good to know, I haven't tracked that one further.

>
>>
>> Then we would need to unify this with the SRCU to make sure that we 
>> have both the reset lock as well as block the hotplug code from 
>> reusing the MMIO space.
>
> In my understanding there is a significant difference between handling 
> of GPU reset and unplug - while GPU reset use case requires any HW 
> accessing code to block and wait for the reset to finish and then 
> proceed, hot-unplug
> is permanent and hence no need to wait and proceed but rather abort at 
> once.
>

Yes, absolutely correct.

> This why I think that in any place we already check for device reset 
> we should also add a check for hot-unplug but the handling would be 
> different
> in that for hot-unplug we would abort instead of keep waiting.
>

Yes, that's the rough picture in my head as well.

Essentially Daniels patch of having an 
amdgpu_device_hwaccess_begin()/_end() was the right approach. You just 
can't do it in the top level IOCTL handler, but rather need it somewhere 
between front end and backend.

> Similar to handling device reset for unplug we obviously also need to 
> stop and block any MMIO accesses once device is unplugged and, as 
> Daniel Vetter mentioned - we have to do it before finishing pci_remove 
> (early device fini)
> and not later (when last device reference is dropped from user space) 
> in order to prevent reuse of MMIO space we still access by other hot 
> plugging devices. As in device reset case we need to cancel all delay 
> works, stop drm schedule, complete all unfinished fences(both HW and 
> scheduler fences). While you stated strong objection to force 
> signalling scheduler fences from GPU reset, quote:
>
> "you can't signal the dma_fence waiting. Waiting for a dma_fence also 
> means you wait for the GPU reset to finish. When we would signal the 
> dma_fence during the GPU reset then we would run into memory 
> corruption because the hardware jobs running after the GPU reset would 
> access memory which is already freed."
> To my understating this is a key difference with hot-unplug, the 
> device is gone, all those concerns are irrelevant and hence we can 
> actually force signal scheduler fences (setting and error to them 
> before) to force completion of any
> waiting clients such as possibly IOCTLs or async page flips e.t.c.
>

Yes, absolutely correct. That's what I also mentioned to Daniel. When we 
are able to nuke the device and any memory access it might do we can 
also signal the fences.

> Beyond blocking all delayed works and scheduler threads we also need 
> to guarantee no  IOCTL can access MMIO post device unplug OR in flight 
> IOCTLs are done before we finish pci_remove (amdgpu_pci_remove for us).
> For this I suggest we do something like what we worked on with Takashi 
> Iwai the ALSA maintainer recently when he helped implementing PCI BARs 
> move support for snd_hda_intel. Take a look at
> https://cgit.freedesktop.org/~agrodzov/linux/commit/?h=yadro/pcie_hotplug/movable_bars_v9.1&id=cbaa324799718e2b828a8c7b5b001dd896748497 
> and
> https://cgit.freedesktop.org/~agrodzov/linux/commit/?h=yadro/pcie_hotplug/movable_bars_v9.1&id=e36365d9ab5bbc30bdc221ab4b3437de34492440
> We also had same issue there, how to prevent MMIO accesses while the 
> BARs are migrating. What was done there is a refcount was added to 
> count all IOCTLs in flight, for any in flight  IOCTL the BAR migration 
> handler would
> block for the refcount to drop to 0 before it would proceed, for any 
> later IOCTL it stops and wait if device is in migration state. We even 
> don't need the wait part, nothing to wait for, we just return with 
> -ENODEV for this case.
>

This is essentially what the DRM SRCU is doing as well.

For the hotplug case we could do this in the toplevel since we can 
signal the fence and don't need to block memory management.

But I'm not sure, maybe we should handle it the same way as reset or 
maybe we should have it at the top level.

Regards,
Christian.

> The above approach should allow us to wait for all the IOCTLs in 
> flight, together with stopping scheduler threads and cancelling and 
> flushing all in flight work items and timers i think It should give as 
> full solution for the hot-unplug case
> of preventing any MMIO accesses post device pci_remove.
>
> Let me know what you think guys.
>
> Andrey
>
>
>>
>> And then testing, testing, testing to see if we have missed something.
>>
>> Christian.
>>
>> Am 05.04.21 um 19:58 schrieb Andrey Grodzovsky:
>>>
>>> Denis, Christian, are there any updates in the plan on how to move 
>>> on with this ? As you know I need very similar code for my 
>>> up-streaming of device hot-unplug. My latest solution 
>>> (https://lists.freedesktop.org/archives/amd-gfx/2021-January/058606.html) 
>>> was not acceptable because of low level guards on the register 
>>> accessors level which was hurting performance. Basically I need a 
>>> way to prevent any MMIO write accesses from kernel driver after 
>>> device is removed (UMD accesses are taken care of by page faulting 
>>> dummy page). We are using now hot-unplug code for Freemont program 
>>> and so up-streaming became more of a priority then before. This MMIO 
>>> access issue is currently my main blocker from up-streaming. Is 
>>> there any way I can assist in pushing this on ?
>>>
>>> Andrey
>>>
>>> On 2021-03-18 5:51 a.m., Christian König wrote:
>>>> Am 18.03.21 um 10:30 schrieb Li, Dennis:
>>>>>
>>>>> >>> The GPU reset doesn't complete the fences we wait for. It only 
>>>>> completes the hardware fences as part of the reset.
>>>>>
>>>>> >>> So waiting for a fence while holding the reset lock is illegal 
>>>>> and needs to be avoided.
>>>>>
>>>>> I understood your concern. It is more complex for DRM GFX, 
>>>>> therefore I abandon adding lock protection for DRM ioctls now. 
>>>>> Maybe we can try to add all kernel  dma_fence waiting in a list, 
>>>>> and signal all in recovery threads. Do you have same concern for 
>>>>> compute cases?
>>>>>
>>>>
>>>> Yes, compute (KFD) is even harder to handle.
>>>>
>>>> See you can't signal the dma_fence waiting. Waiting for a dma_fence 
>>>> also means you wait for the GPU reset to finish.
>>>>
>>>> When we would signal the dma_fence during the GPU reset then we 
>>>> would run into memory corruption because the hardware jobs running 
>>>> after the GPU reset would access memory which is already freed.
>>>>
>>>>> >>> Lockdep also complains about this when it is used correctly. 
>>>>> The only reason it doesn't complain here is because you use an 
>>>>> atomic+wait_event instead of a locking primitive.
>>>>>
>>>>> Agree. This approach will escape the monitor of lockdep.  Its goal 
>>>>> is to block other threads when GPU recovery thread start. But I 
>>>>> couldn’t find a better method to solve this problem. Do you have 
>>>>> some suggestion?
>>>>>
>>>>
>>>> Well, completely abandon those change here.
>>>>
>>>> What we need to do is to identify where hardware access happens and 
>>>> then insert taking the read side of the GPU reset lock so that we 
>>>> don't wait for a dma_fence or allocate memory, but still protect 
>>>> the hardware from concurrent access and reset.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> Best Regards
>>>>>
>>>>> Dennis Li
>>>>>
>>>>> *From:* Koenig, Christian <Christian.Koenig@amd.com>
>>>>> *Sent:* Thursday, March 18, 2021 4:59 PM
>>>>> *To:* Li, Dennis <Dennis.Li@amd.com>; 
>>>>> amd-gfx@lists.freedesktop.org; Deucher, Alexander 
>>>>> <Alexander.Deucher@amd.com>; Kuehling, Felix 
>>>>> <Felix.Kuehling@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
>>>>> *Subject:* AW: [PATCH 0/4] Refine GPU recovery sequence to enhance 
>>>>> its stability
>>>>>
>>>>> Exactly that's what you don't seem to understand.
>>>>>
>>>>> The GPU reset doesn't complete the fences we wait for. It only 
>>>>> completes the hardware fences as part of the reset.
>>>>>
>>>>> So waiting for a fence while holding the reset lock is illegal and 
>>>>> needs to be avoided.
>>>>>
>>>>> Lockdep also complains about this when it is used correctly. The 
>>>>> only reason it doesn't complain here is because you use an 
>>>>> atomic+wait_event instead of a locking primitive.
>>>>>
>>>>> Regards,
>>>>>
>>>>> Christian.
>>>>>
>>>>> ------------------------------------------------------------------------
>>>>>
>>>>> *Von:*Li, Dennis <Dennis.Li@amd.com <mailto:Dennis.Li@amd.com>>
>>>>> *Gesendet:* Donnerstag, 18. März 2021 09:28
>>>>> *An:* Koenig, Christian <Christian.Koenig@amd.com 
>>>>> <mailto:Christian.Koenig@amd.com>>; amd-gfx@lists.freedesktop.org 
>>>>> <mailto:amd-gfx@lists.freedesktop.org> 
>>>>> <amd-gfx@lists.freedesktop.org 
>>>>> <mailto:amd-gfx@lists.freedesktop.org>>; Deucher, Alexander 
>>>>> <Alexander.Deucher@amd.com <mailto:Alexander.Deucher@amd.com>>; 
>>>>> Kuehling, Felix <Felix.Kuehling@amd.com 
>>>>> <mailto:Felix.Kuehling@amd.com>>; Zhang, Hawking 
>>>>> <Hawking.Zhang@amd.com <mailto:Hawking.Zhang@amd.com>>
>>>>> *Betreff:* RE: [PATCH 0/4] Refine GPU recovery sequence to enhance 
>>>>> its stability
>>>>>
>>>>> >>> Those two steps need to be exchanged or otherwise it is 
>>>>> possible that new delayed work items etc are started before the 
>>>>> lock is taken.
>>>>> What about adding check for adev->in_gpu_reset in work item? If 
>>>>> exchange the two steps, it maybe introduce the deadlock.  For 
>>>>> example, the user thread hold the read lock and waiting for the 
>>>>> fence, if recovery thread try to hold write lock and then complete 
>>>>> fences, in this case, recovery thread will always be blocked.
>>>>>
>>>>>
>>>>> Best Regards
>>>>> Dennis Li
>>>>> -----Original Message-----
>>>>> From: Koenig, Christian <Christian.Koenig@amd.com 
>>>>> <mailto:Christian.Koenig@amd.com>>
>>>>> Sent: Thursday, March 18, 2021 3:54 PM
>>>>> To: Li, Dennis <Dennis.Li@amd.com <mailto:Dennis.Li@amd.com>>; 
>>>>> amd-gfx@lists.freedesktop.org 
>>>>> <mailto:amd-gfx@lists.freedesktop.org>; Deucher, Alexander 
>>>>> <Alexander.Deucher@amd.com <mailto:Alexander.Deucher@amd.com>>; 
>>>>> Kuehling, Felix <Felix.Kuehling@amd.com 
>>>>> <mailto:Felix.Kuehling@amd.com>>; Zhang, Hawking 
>>>>> <Hawking.Zhang@amd.com <mailto:Hawking.Zhang@amd.com>>
>>>>> Subject: Re: [PATCH 0/4] Refine GPU recovery sequence to enhance 
>>>>> its stability
>>>>>
>>>>> Am 18.03.21 um 08:23 schrieb Dennis Li:
>>>>> > We have defined two variables in_gpu_reset and reset_sem in adev 
>>>>> object. The atomic type variable in_gpu_reset is used to avoid 
>>>>> recovery thread reenter and make lower functions return more 
>>>>> earlier when recovery start, but couldn't block recovery thread 
>>>>> when it access hardware. The r/w semaphore reset_sem is used to 
>>>>> solve these synchronization issues between recovery thread and 
>>>>> other threads.
>>>>> >
>>>>> > The original solution locked registers' access in lower 
>>>>> functions, which will introduce following issues:
>>>>> >
>>>>> > 1) many lower functions are used in both recovery thread and 
>>>>> others. Firstly we must harvest these functions, it is easy to 
>>>>> miss someones. Secondly these functions need select which lock 
>>>>> (read lock or write lock) will be used, according to the thread it 
>>>>> is running in. If the thread context isn't considered, the added 
>>>>> lock will easily introduce deadlock. Besides that, in most time, 
>>>>> developer easily forget to add locks for new functions.
>>>>> >
>>>>> > 2) performance drop. More lower functions are more frequently 
>>>>> called.
>>>>> >
>>>>> > 3) easily introduce false positive lockdep complaint, because 
>>>>> write lock has big range in recovery thread, but low level 
>>>>> functions will hold read lock may be protected by other locks in 
>>>>> other threads.
>>>>> >
>>>>> > Therefore the new solution will try to add lock protection for 
>>>>> ioctls of kfd. Its goal is that there are no threads except for 
>>>>> recovery thread or its children (for xgmi) to access hardware when 
>>>>> doing GPU reset and resume. So refine recovery thread as the 
>>>>> following:
>>>>> >
>>>>> > Step 0: atomic_cmpxchg(&adev->in_gpu_reset, 0, 1)
>>>>> >     1). if failed, it means system had a recovery thread 
>>>>> running, current thread exit directly;
>>>>> >     2). if success, enter recovery thread;
>>>>> >
>>>>> > Step 1: cancel all delay works, stop drm schedule, complete all 
>>>>> unreceived fences and so on. It try to stop or pause other threads.
>>>>> >
>>>>> > Step 2: call down_write(&adev->reset_sem) to hold write lock, 
>>>>> which will block recovery thread until other threads release read 
>>>>> locks.
>>>>>
>>>>> Those two steps need to be exchanged or otherwise it is possible 
>>>>> that new delayed work items etc are started before the lock is taken.
>>>>>
>>>>> Just to make it clear until this is fixed the whole patch set is a 
>>>>> NAK.
>>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>> >
>>>>> > Step 3: normally, there is only recovery threads running to 
>>>>> access hardware, it is safe to do gpu reset now.
>>>>> >
>>>>> > Step 4: do post gpu reset, such as call all ips' resume functions;
>>>>> >
>>>>> > Step 5: atomic set adev->in_gpu_reset as 0, wake up other 
>>>>> threads and release write lock. Recovery thread exit normally.
>>>>> >
>>>>> > Other threads call the amdgpu_read_lock to synchronize with 
>>>>> recovery thread. If it finds that in_gpu_reset is 1, it should 
>>>>> release read lock if it has holden one, and then blocks itself to 
>>>>> wait for recovery finished event. If thread successfully hold read 
>>>>> lock and in_gpu_reset is 0, it continues. It will exit normally or 
>>>>> be stopped by recovery thread in step 1.
>>>>> >
>>>>> > Dennis Li (4):
>>>>> >    drm/amdgpu: remove reset lock from low level functions
>>>>> >    drm/amdgpu: refine the GPU recovery sequence
>>>>> >    drm/amdgpu: instead of using down/up_read directly
>>>>> >    drm/amdkfd: add reset lock protection for kfd entry functions
>>>>> >
>>>>> > drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 6 +
>>>>> > drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   | 14 +-
>>>>> > drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 173 
>>>>> +++++++++++++-----
>>>>> > .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 8 -
>>>>> > drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        | 4 +-
>>>>> > drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         | 9 +-
>>>>> > drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c         | 5 +-
>>>>> > drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c         | 5 +-
>>>>> > drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 172 
>>>>> ++++++++++++++++-
>>>>> > drivers/gpu/drm/amd/amdkfd/kfd_priv.h         | 3 +-
>>>>> > drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 4 +
>>>>> > .../amd/amdkfd/kfd_process_queue_manager.c    | 17 ++
>>>>> >   12 files changed, 345 insertions(+), 75 deletions(-)
>>>>> >
>>>>>
>>>>
>>>>
>>>> _______________________________________________
>>>> amd-gfx mailing list
>>>> amd-gfx@lists.freedesktop.org
>>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------20DEFBBAF707723C1C40FFA2
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Hi Andrey,<br>
    <br>
    <div class="moz-cite-prefix">Am 06.04.21 um 23:22 schrieb Andrey
      Grodzovsky:<br>
    </div>
    <blockquote type="cite"
      cite="mid:29ffe63b-9049-824f-84fc-a92fdb451e0d@amd.com">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <p>Hey Christian, Denis, see bellow - <br>
      </p>
      <div class="moz-cite-prefix">On 2021-04-06 6:34 a.m., Christian
        König wrote:<br>
      </div>
      <blockquote type="cite"
        cite="mid:51d7873d-cf35-6be5-79c2-024937c67f6a@amd.com"> Hi
        Andrey,<br>
        <br>
        well good question. My job is to watch over the implementation
        and design and while I always help I can adjust anybodies
        schedule.<br>
        <br>
        Is the patch to print a warning when the hardware is accessed
        without holding the locks merged yet? If not then that would
        probably be a good starting point.<br>
      </blockquote>
      <p><br>
      </p>
      <p>It's merged into amd-staging-drm-next and since I work on
        drm-misc-next I will cherry-pick it into there.<br>
      </p>
    </blockquote>
    <br>
    Ok good to know, I haven't tracked that one further.<br>
    <br>
    <blockquote type="cite"
      cite="mid:29ffe63b-9049-824f-84fc-a92fdb451e0d@amd.com">
      <p> </p>
      <p><br>
      </p>
      <blockquote type="cite"
        cite="mid:51d7873d-cf35-6be5-79c2-024937c67f6a@amd.com"> <br>
        Then we would need to unify this with the SRCU to make sure that
        we have both the reset lock as well as block the hotplug code
        from reusing the MMIO space.<br>
      </blockquote>
      <br>
      <p>In my understanding there is a significant difference between
        handling of GPU reset and unplug - while GPU reset use case
        requires any HW accessing code to block and wait for the reset
        to finish and then proceed, hot-unplug<br>
        is permanent and hence no need to wait and proceed but rather
        abort at once.</p>
    </blockquote>
    <br>
    Yes, absolutely correct.<br>
    <br>
    <blockquote type="cite"
      cite="mid:29ffe63b-9049-824f-84fc-a92fdb451e0d@amd.com">
      <p> This why I think that in any place we already check for device
        reset we should also add a check for hot-unplug but the handling
        would be different<br>
        in that for hot-unplug we would abort instead of keep waiting.</p>
    </blockquote>
    <br>
    Yes, that's the rough picture in my head as well.<br>
    <br>
    Essentially Daniels patch of having an
    amdgpu_device_hwaccess_begin()/_end() was the right approach. You
    just can't do it in the top level IOCTL handler, but rather need it
    somewhere between front end and backend.<br>
    <br>
    <blockquote type="cite"
      cite="mid:29ffe63b-9049-824f-84fc-a92fdb451e0d@amd.com">
      <p>Similar to handling device reset for unplug we obviously also
        need to stop and block any MMIO accesses once device is
        unplugged and, as Daniel Vetter mentioned - we have to do it
        before finishing pci_remove (early device fini)<br>
        and not later (when last device reference is dropped from user
        space) in order to prevent reuse of MMIO space we still access
        by other hot plugging devices. As in device reset case we need
        to cancel all delay works, stop drm schedule, complete all
        unfinished fences(both HW and scheduler fences). While you
        stated strong objection to force signalling scheduler fences
        from GPU reset, quote: <br>
      </p>
      <p>"you can't signal the dma_fence waiting. Waiting for a
        dma_fence also means you wait for the GPU reset to finish. When
        we would signal the dma_fence during the GPU reset then we would
        run into memory corruption because the hardware jobs running
        after the GPU reset would access memory which is already freed."<br>
        To my understating this is a key difference with hot-unplug, the
        device is gone, all those concerns are irrelevant and hence we
        can actually force signal scheduler fences (setting and error to
        them before) to force completion of any<br>
        waiting clients such as possibly IOCTLs or async page flips
        e.t.c.<br>
      </p>
    </blockquote>
    <br>
    Yes, absolutely correct. That's what I also mentioned to Daniel.
    When we are able to nuke the device and any memory access it might
    do we can also signal the fences.<br>
    <br>
    <blockquote type="cite"
      cite="mid:29ffe63b-9049-824f-84fc-a92fdb451e0d@amd.com">
      <p> </p>
      <p>Beyond blocking all delayed works and scheduler threads we also
        need to guarantee no  IOCTL can access MMIO post device unplug
        OR in flight IOCTLs are done before we finish pci_remove
        (amdgpu_pci_remove for us).<br>
        For this I suggest we do something like what we worked on with
        Takashi Iwai the ALSA maintainer recently when he helped
        implementing PCI BARs move support for snd_hda_intel. Take a
        look at<br>
        <a class="moz-txt-link-freetext"
href="https://cgit.freedesktop.org/~agrodzov/linux/commit/?h=yadro/pcie_hotplug/movable_bars_v9.1&amp;id=cbaa324799718e2b828a8c7b5b001dd896748497"
          moz-do-not-send="true">https://cgit.freedesktop.org/~agrodzov/linux/commit/?h=yadro/pcie_hotplug/movable_bars_v9.1&amp;id=cbaa324799718e2b828a8c7b5b001dd896748497</a>
        and<br>
        <a class="moz-txt-link-freetext"
href="https://cgit.freedesktop.org/~agrodzov/linux/commit/?h=yadro/pcie_hotplug/movable_bars_v9.1&amp;id=e36365d9ab5bbc30bdc221ab4b3437de34492440"
          moz-do-not-send="true">https://cgit.freedesktop.org/~agrodzov/linux/commit/?h=yadro/pcie_hotplug/movable_bars_v9.1&amp;id=e36365d9ab5bbc30bdc221ab4b3437de34492440</a><br>
        We also had same issue there, how to prevent MMIO accesses while
        the BARs are migrating. What was done there is a refcount was
        added to count all IOCTLs in flight, for any in flight  IOCTL
        the BAR migration handler would <br>
        block for the refcount to drop to 0 before it would proceed, for
        any later IOCTL it stops and wait if device is in migration
        state. We even don't need the wait part, nothing to wait for, we
        just return with -ENODEV for this case.</p>
    </blockquote>
    <br>
    This is essentially what the DRM SRCU is doing as well.<br>
    <br>
    For the hotplug case we could do this in the toplevel since we can
    signal the fence and don't need to block memory management.<br>
    <br>
    But I'm not sure, maybe we should handle it the same way as reset or
    maybe we should have it at the top level.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite"
      cite="mid:29ffe63b-9049-824f-84fc-a92fdb451e0d@amd.com">
      <p>The above approach should allow us to wait for all the IOCTLs
        in flight, together with stopping scheduler threads and
        cancelling and flushing all in flight work items and timers i
        think It should give as full solution for the hot-unplug case<br>
        of preventing any MMIO accesses post device pci_remove.<br>
        <br>
        Let me know what you think guys.</p>
      <p>Andrey</p>
      <p><br>
      </p>
      <blockquote type="cite"
        cite="mid:51d7873d-cf35-6be5-79c2-024937c67f6a@amd.com"> <br>
        And then testing, testing, testing to see if we have missed
        something.<br>
        <br>
        Christian.<br>
        <br>
        <div class="moz-cite-prefix">Am 05.04.21 um 19:58 schrieb Andrey
          Grodzovsky:<br>
        </div>
        <blockquote type="cite"
          cite="mid:1e37bb4d-f54d-1b7e-4632-94cfcf749528@amd.com">
          <p>Denis, Christian, are there any updates in the plan on how
            to move on with this ? As you know I need very similar code
            for my up-streaming of device hot-unplug. My latest solution
            (<a class="moz-txt-link-freetext"
href="https://lists.freedesktop.org/archives/amd-gfx/2021-January/058606.html"
              moz-do-not-send="true">https://lists.freedesktop.org/archives/amd-gfx/2021-January/058606.html</a>)
            was not acceptable because of low level guards on the
            register accessors level which was hurting performance.
            Basically I need a way to prevent any MMIO write accesses
            from kernel driver after device is removed (UMD accesses are
            taken care of by page faulting dummy page). We are using now
            hot-unplug code for Freemont program and so up-streaming
            became more of a priority then before. This MMIO access
            issue is currently my main blocker from up-streaming. Is
            there any way I can assist in pushing this on ?</p>
          <p>Andrey  <br>
          </p>
          <div class="moz-cite-prefix">On 2021-03-18 5:51 a.m.,
            Christian König wrote:<br>
          </div>
          <blockquote type="cite"
            cite="mid:378fdffb-99b5-2a14-736d-a06f310b040c@amd.com"> Am
            18.03.21 um 10:30 schrieb Li, Dennis:<br>
            <blockquote type="cite"
cite="mid:DM5PR12MB253379E8C89D8A20C8A0245AED699@DM5PR12MB2533.namprd12.prod.outlook.com">
              <meta name="Generator" content="Microsoft Word 15
                (filtered medium)">
              <!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]-->
              <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:等线;
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:"\@等线";
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:"Segoe UI";
	panose-1:2 11 5 2 4 2 4 2 2 3;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
              <div class="WordSection1">
                <p class="MsoNormal">&gt;&gt;&gt; The GPU reset doesn't
                  complete the fences we wait for. It only completes the
                  hardware fences as part of the reset.<o:p></o:p></p>
                <p class="MsoNormal">&gt;&gt;&gt; So waiting for a fence
                  while holding the reset lock is illegal and needs to
                  be avoided.<o:p></o:p></p>
                <p class="MsoNormal">I understood your concern. It is
                  more complex for DRM GFX, therefore I abandon adding
                  lock protection for DRM ioctls now. Maybe we can try
                  to add all kernel  dma_fence waiting in a list, and
                  signal all in recovery threads. Do you have same
                  concern for compute cases? </p>
              </div>
            </blockquote>
            <br>
            Yes, compute (KFD) is even harder to handle.<br>
            <br>
            See you can't signal the dma_fence waiting. Waiting for a
            dma_fence also means you wait for the GPU reset to finish.<br>
            <br>
            When we would signal the dma_fence during the GPU reset then
            we would run into memory corruption because the hardware
            jobs running after the GPU reset would access memory which
            is already freed.<br>
            <br>
            <blockquote type="cite"
cite="mid:DM5PR12MB253379E8C89D8A20C8A0245AED699@DM5PR12MB2533.namprd12.prod.outlook.com">
              <div class="WordSection1">
                <p class="MsoNormal"><o:p></o:p></p>
                <p class="MsoNormal"><o:p> </o:p></p>
                <p class="MsoNormal">&gt;&gt;&gt; Lockdep also complains
                  about this when it is used correctly. The only reason
                  it doesn't complain here is because you use an
                  atomic+wait_event instead of a locking primitive.<o:p></o:p></p>
                <p class="MsoNormal">Agree. This approach will escape
                  the monitor of lockdep.  Its goal is to block other
                  threads when GPU recovery thread start. But I couldn’t
                  find a better method to solve this problem. Do you
                  have some suggestion? </p>
              </div>
            </blockquote>
            <br>
            Well, completely abandon those change here.<br>
            <br>
            What we need to do is to identify where hardware access
            happens and then insert taking the read side of the GPU
            reset lock so that we don't wait for a dma_fence or allocate
            memory, but still protect the hardware from concurrent
            access and reset.<br>
            <br>
            Regards,<br>
            Christian.<br>
            <br>
            <blockquote type="cite"
cite="mid:DM5PR12MB253379E8C89D8A20C8A0245AED699@DM5PR12MB2533.namprd12.prod.outlook.com">
              <div class="WordSection1">
                <p class="MsoNormal"><o:p></o:p></p>
                <p class="MsoNormal"><o:p> </o:p></p>
                <p class="MsoNormal">Best Regards<o:p></o:p></p>
                <p class="MsoNormal">Dennis Li<o:p></o:p></p>
                <p class="MsoNormal"><o:p> </o:p></p>
                <div>
                  <div style="border:none;border-top:solid #E1E1E1
                    1.0pt;padding:3.0pt 0in 0in 0in">
                    <p class="MsoNormal"><b>From:</b> Koenig, Christian
                      <a class="moz-txt-link-rfc2396E"
                        href="mailto:Christian.Koenig@amd.com"
                        moz-do-not-send="true">&lt;Christian.Koenig@amd.com&gt;</a>
                      <br>
                      <b>Sent:</b> Thursday, March 18, 2021 4:59 PM<br>
                      <b>To:</b> Li, Dennis <a
                        class="moz-txt-link-rfc2396E"
                        href="mailto:Dennis.Li@amd.com"
                        moz-do-not-send="true">&lt;Dennis.Li@amd.com&gt;</a>;
                      <a class="moz-txt-link-abbreviated"
                        href="mailto:amd-gfx@lists.freedesktop.org"
                        moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>;
                      Deucher, Alexander <a
                        class="moz-txt-link-rfc2396E"
                        href="mailto:Alexander.Deucher@amd.com"
                        moz-do-not-send="true">&lt;Alexander.Deucher@amd.com&gt;</a>;
                      Kuehling, Felix <a class="moz-txt-link-rfc2396E"
                        href="mailto:Felix.Kuehling@amd.com"
                        moz-do-not-send="true">&lt;Felix.Kuehling@amd.com&gt;</a>;
                      Zhang, Hawking <a class="moz-txt-link-rfc2396E"
                        href="mailto:Hawking.Zhang@amd.com"
                        moz-do-not-send="true">&lt;Hawking.Zhang@amd.com&gt;</a><br>
                      <b>Subject:</b> AW: [PATCH 0/4] Refine GPU
                      recovery sequence to enhance its stability<o:p></o:p></p>
                  </div>
                </div>
                <p class="MsoNormal"><o:p> </o:p></p>
                <div>
                  <p class="MsoNormal"><span
                      style="font-size:12.0pt;font-family:&quot;Segoe
                      UI&quot;,sans-serif;color:black">Exactly that's
                      what you don't seem to understand.<o:p></o:p></span></p>
                </div>
                <div>
                  <p class="MsoNormal"><span
                      style="font-size:12.0pt;font-family:&quot;Segoe
                      UI&quot;,sans-serif;color:black"><o:p> </o:p></span></p>
                </div>
                <div>
                  <p class="MsoNormal"><span
                      style="font-size:12.0pt;font-family:&quot;Segoe
                      UI&quot;,sans-serif;color:black">The GPU reset
                      doesn't complete the fences we wait for. It only
                      completes the hardware fences as part of the
                      reset.<o:p></o:p></span></p>
                </div>
                <div>
                  <p class="MsoNormal"><span
                      style="font-size:12.0pt;font-family:&quot;Segoe
                      UI&quot;,sans-serif;color:black"><o:p> </o:p></span></p>
                </div>
                <div>
                  <p class="MsoNormal"><span
                      style="font-size:12.0pt;font-family:&quot;Segoe
                      UI&quot;,sans-serif;color:black">So waiting for a
                      fence while holding the reset lock is illegal and
                      needs to be avoided.<o:p></o:p></span></p>
                </div>
                <div>
                  <p class="MsoNormal"><span
                      style="font-size:12.0pt;font-family:&quot;Segoe
                      UI&quot;,sans-serif;color:black"><o:p> </o:p></span></p>
                </div>
                <div>
                  <p class="MsoNormal"><span
                      style="font-size:12.0pt;font-family:&quot;Segoe
                      UI&quot;,sans-serif;color:black">Lockdep also
                      complains about this when it is used correctly.
                      The only reason it doesn't complain here is
                      because you use an atomic+wait_event instead of a
                      locking primitive.<o:p></o:p></span></p>
                </div>
                <div>
                  <p class="MsoNormal"><span
                      style="font-size:12.0pt;font-family:&quot;Segoe
                      UI&quot;,sans-serif;color:black"><o:p> </o:p></span></p>
                </div>
                <div>
                  <p class="MsoNormal"><span
                      style="font-size:12.0pt;font-family:&quot;Segoe
                      UI&quot;,sans-serif;color:black">Regards,<o:p></o:p></span></p>
                </div>
                <div>
                  <p class="MsoNormal"><span
                      style="font-size:12.0pt;font-family:&quot;Segoe
                      UI&quot;,sans-serif;color:black">Christian.<o:p></o:p></span></p>
                </div>
                <div>
                  <p class="MsoNormal"><o:p> </o:p></p>
                </div>
                <div class="MsoNormal" style="text-align:center"
                  align="center">
                  <hr width="98%" size="2" align="center"> </div>
                <div id="divRplyFwdMsg">
                  <p class="MsoNormal"><b><span style="color:black">Von:</span></b><span
                      style="color:black"> Li, Dennis &lt;<a
                        href="mailto:Dennis.Li@amd.com"
                        moz-do-not-send="true">Dennis.Li@amd.com</a>&gt;<br>
                      <b>Gesendet:</b> Donnerstag, 18. März 2021 09:28<br>
                      <b>An:</b> Koenig, Christian &lt;<a
                        href="mailto:Christian.Koenig@amd.com"
                        moz-do-not-send="true">Christian.Koenig@amd.com</a>&gt;;
                      <a href="mailto:amd-gfx@lists.freedesktop.org"
                        moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
                      &lt;<a href="mailto:amd-gfx@lists.freedesktop.org"
                        moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>&gt;;
                      Deucher, Alexander &lt;<a
                        href="mailto:Alexander.Deucher@amd.com"
                        moz-do-not-send="true">Alexander.Deucher@amd.com</a>&gt;;
                      Kuehling, Felix &lt;<a
                        href="mailto:Felix.Kuehling@amd.com"
                        moz-do-not-send="true">Felix.Kuehling@amd.com</a>&gt;;
                      Zhang, Hawking &lt;<a
                        href="mailto:Hawking.Zhang@amd.com"
                        moz-do-not-send="true">Hawking.Zhang@amd.com</a>&gt;<br>
                      <b>Betreff:</b> RE: [PATCH 0/4] Refine GPU
                      recovery sequence to enhance its stability</span>
                    <o:p></o:p></p>
                  <div>
                    <p class="MsoNormal"> <o:p></o:p></p>
                  </div>
                </div>
                <div>
                  <div>
                    <p class="MsoNormal">&gt;&gt;&gt; Those two steps
                      need to be exchanged or otherwise it is possible
                      that new delayed work items etc are started before
                      the lock is taken.<br>
                      What about adding check for adev-&gt;in_gpu_reset
                      in work item? If exchange the two steps, it maybe
                      introduce the deadlock.  For example, the user
                      thread hold the read lock and waiting for the
                      fence, if recovery thread try to hold write lock
                      and then complete fences, in this case, recovery
                      thread will always be blocked.<o:p></o:p></p>
                  </div>
                  <div>
                    <p class="MsoNormal" style="margin-bottom:12.0pt"><br>
                      Best Regards<br>
                      Dennis Li<br>
                      -----Original Message-----<br>
                      From: Koenig, Christian &lt;<a
                        href="mailto:Christian.Koenig@amd.com"
                        moz-do-not-send="true">Christian.Koenig@amd.com</a>&gt;
                      <br>
                      Sent: Thursday, March 18, 2021 3:54 PM<br>
                      To: Li, Dennis &lt;<a
                        href="mailto:Dennis.Li@amd.com"
                        moz-do-not-send="true">Dennis.Li@amd.com</a>&gt;;
                      <a href="mailto:amd-gfx@lists.freedesktop.org"
                        moz-do-not-send="true">
                        amd-gfx@lists.freedesktop.org</a>; Deucher,
                      Alexander &lt;<a
                        href="mailto:Alexander.Deucher@amd.com"
                        moz-do-not-send="true">Alexander.Deucher@amd.com</a>&gt;;
                      Kuehling, Felix &lt;<a
                        href="mailto:Felix.Kuehling@amd.com"
                        moz-do-not-send="true">Felix.Kuehling@amd.com</a>&gt;;
                      Zhang, Hawking &lt;<a
                        href="mailto:Hawking.Zhang@amd.com"
                        moz-do-not-send="true">Hawking.Zhang@amd.com</a>&gt;<br>
                      Subject: Re: [PATCH 0/4] Refine GPU recovery
                      sequence to enhance its stability<br>
                      <br>
                      Am 18.03.21 um 08:23 schrieb Dennis Li:<br>
                      &gt; We have defined two variables in_gpu_reset
                      and reset_sem in adev object. The atomic type
                      variable in_gpu_reset is used to avoid recovery
                      thread reenter and make lower functions return
                      more earlier when recovery start, but couldn't
                      block recovery thread when it access hardware. The
                      r/w semaphore reset_sem is used to solve these
                      synchronization issues between recovery thread and
                      other threads.<br>
                      &gt;<br>
                      &gt; The original solution locked registers'
                      access in lower functions, which will introduce
                      following issues:<br>
                      &gt;<br>
                      &gt; 1) many lower functions are used in both
                      recovery thread and others. Firstly we must
                      harvest these functions, it is easy to miss
                      someones. Secondly these functions need select
                      which lock (read lock or write lock) will be used,
                      according to the thread it is running in. If the
                      thread context isn't considered, the added lock
                      will easily introduce deadlock. Besides that, in
                      most time, developer easily forget to add locks
                      for new functions.<br>
                      &gt;<br>
                      &gt; 2) performance drop. More lower functions are
                      more frequently called.<br>
                      &gt;<br>
                      &gt; 3) easily introduce false positive lockdep
                      complaint, because write lock has big range in
                      recovery thread, but low level functions will hold
                      read lock may be protected by other locks in other
                      threads.<br>
                      &gt;<br>
                      &gt; Therefore the new solution will try to add
                      lock protection for ioctls of kfd. Its goal is
                      that there are no threads except for recovery
                      thread or its children (for xgmi) to access
                      hardware when doing GPU reset and resume. So
                      refine recovery thread as the following:<br>
                      &gt;<br>
                      &gt; Step 0:
                      atomic_cmpxchg(&amp;adev-&gt;in_gpu_reset, 0, 1)<br>
                      &gt;     1). if failed, it means system had a
                      recovery thread running, current thread exit
                      directly;<br>
                      &gt;     2). if success, enter recovery thread;<br>
                      &gt;<br>
                      &gt; Step 1: cancel all delay works, stop drm
                      schedule, complete all unreceived fences and so
                      on. It try to stop or pause other threads.<br>
                      &gt;<br>
                      &gt; Step 2: call
                      down_write(&amp;adev-&gt;reset_sem) to hold write
                      lock, which will block recovery thread until other
                      threads release read locks.<br>
                      <br>
                      Those two steps need to be exchanged or otherwise
                      it is possible that new delayed work items etc are
                      started before the lock is taken.<br>
                      <br>
                      Just to make it clear until this is fixed the
                      whole patch set is a NAK.<br>
                      <br>
                      Regards,<br>
                      Christian.<br>
                      <br>
                      &gt;<br>
                      &gt; Step 3: normally, there is only recovery
                      threads running to access hardware, it is safe to
                      do gpu reset now.<br>
                      &gt;<br>
                      &gt; Step 4: do post gpu reset, such as call all
                      ips' resume functions;<br>
                      &gt;<br>
                      &gt; Step 5: atomic set adev-&gt;in_gpu_reset as
                      0, wake up other threads and release write lock.
                      Recovery thread exit normally.<br>
                      &gt;<br>
                      &gt; Other threads call the amdgpu_read_lock to
                      synchronize with recovery thread. If it finds that
                      in_gpu_reset is 1, it should release read lock if
                      it has holden one, and then blocks itself to wait
                      for recovery finished event. If thread
                      successfully hold read lock and in_gpu_reset is 0,
                      it continues. It will exit normally or be stopped
                      by recovery thread in step 1.<br>
                      &gt;<br>
                      &gt; Dennis Li (4):<br>
                      &gt;    drm/amdgpu: remove reset lock from low
                      level functions<br>
                      &gt;    drm/amdgpu: refine the GPU recovery
                      sequence<br>
                      &gt;    drm/amdgpu: instead of using down/up_read
                      directly<br>
                      &gt;    drm/amdkfd: add reset lock protection for
                      kfd entry functions<br>
                      &gt;<br>
                      &gt;  
                      drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  
                      6 +<br>
                      &gt;  
                      drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   | 
                      14 +-<br>
                      &gt;  
                      drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |
                      173 +++++++++++++-----<br>
                      &gt;  
                      .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    |  
                      8 -<br>
                      &gt;  
                      drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |  
                      4 +-<br>
                      &gt;  
                      drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  
                      9 +-<br>
                      &gt;  
                      drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c         |  
                      5 +-<br>
                      &gt;  
                      drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c         |  
                      5 +-<br>
                      &gt;  
                      drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |
                      172 ++++++++++++++++-<br>
                      &gt;  
                      drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  
                      3 +-<br>
                      &gt;  
                      drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  
                      4 +<br>
                      &gt;  
                      .../amd/amdkfd/kfd_process_queue_manager.c    | 
                      17 ++<br>
                      &gt;   12 files changed, 345 insertions(+), 75
                      deletions(-)<br>
                      &gt;<o:p></o:p></p>
                  </div>
                </div>
              </div>
            </blockquote>
            <br>
            <br>
            <fieldset class="mimeAttachmentHeader"></fieldset>
            <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
          </blockquote>
        </blockquote>
        <br>
      </blockquote>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------20DEFBBAF707723C1C40FFA2--

--===============0255588802==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0255588802==--
