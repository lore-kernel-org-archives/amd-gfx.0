Return-Path: <SRS0=Yti/=P5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26ECC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 15:49:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 604D36112F
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 15:49:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 604D36112F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AD6C6E5C3;
	Wed, 10 Nov 2021 15:48:59 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D20F6E5C3
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Nov 2021 15:48:58 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id s13so4828032wrb.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Nov 2021 07:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=QDFtNElBdgQEqAveNlMXLiUBb4qNL8TowofxZiEbmLw=;
 b=PqjLC6d8OZNnyDm7KSVv+pqF0YlHdl8UVDuWQ/TfU8sBdEO2LdlSg3L4Cac3oHEugr
 HuY2/3eKXD3QstPsFhYnx/4374amfY9T/7/6bqppZr5TyDPHKrciz4exXdXzOaFz1AXR
 3F7YEJSLsGLZWIoelO6xo3yYGVOfmo5SXgRzRDviQYpf7u/zFa98OzJkZnsytCqRkQ0H
 fOkd6dpOqVGPqpg2j7Kkh1Cy3wP8atxDmHJmNTLz3Cy/nFIVRxJjDloF+vCbfj/y8Be8
 r6MprBYEjD5afaUKtFapCRITu+jL62BenYFHneVSAMfMD2vL2lJ8GceGdAO1kOGKd5QP
 S7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=QDFtNElBdgQEqAveNlMXLiUBb4qNL8TowofxZiEbmLw=;
 b=Lz1/g4eLFek0z9yHYAvuaJG0gf4STk14CUCJzD70zIexkYe1wzsjjd3hdjnMpoqH+L
 G+xB0i0e6RuXY0ngOSGcWQWiNMG2FEcVFniPdOkAre++DYKnXzZGznwZwEOPYZbvTOBf
 hVQwMLYZ4pztMgLfINJNIpJhYxgUXjmQKHxvivRo2w/f+uy7X8d35hJzH/tzuhcPLt/A
 RfkCG+0xH/VliIKzmPcnR8QtGh1wqi7WEGnn6mK0RpstB5a6Gz9GwmkuJMVbRUQ75YmT
 zvfo0u9TLQsYuId960L9SDyUDb3GsNpQy2T/4BRJmdTw2JkIOiHQlvGM9g5ir0/Hjub+
 kW7g==
X-Gm-Message-State: AOAM531anOsu0azlhv/lGXDmD2juy97Px57imYUBbU3evuETOXSki59t
 j7yXCg4h+Mv2rBmeuXxUdHo=
X-Google-Smtp-Source: ABdhPJzdxJqsIVWEFWDQdrJaMyfl19l74ah54W/F/W8m/qsZBGAifoAi/etB58Rf5ZW5CVAJAXG1ow==
X-Received: by 2002:adf:d1c2:: with SMTP id b2mr763072wrd.369.1636559336684;
 Wed, 10 Nov 2021 07:48:56 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:fa11:45ae:fadf:6269?
 ([2a02:908:1252:fb60:fa11:45ae:fadf:6269])
 by smtp.gmail.com with ESMTPSA id h2sm247126wrz.23.2021.11.10.07.48.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Nov 2021 07:48:56 -0800 (PST)
Subject: Re: [PATCH 1/5] drm/amdgpu: handle IH ring1 overflow
To: philip yang <yangp@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20211109230432.3947-1-Philip.Yang@amd.com>
 <1862b795-3401-b89f-089b-4b544957d150@gmail.com>
 <c5855126-de94-f2b4-c912-f386b6b47142@amd.com>
 <9e4e654f-8996-fc9a-0ec6-211a7c0ddf42@gmail.com>
 <8582ee1f-3327-2822-9385-38c2a283f89d@amd.com>
 <4130bde8-8184-4aed-4634-7d58f3e61d2f@gmail.com>
 <6e18ae5a-f4b5-2330-7168-6953f0c812a7@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <ad55b462-5aa9-1f7f-1284-acb45da8a509@gmail.com>
Date: Wed, 10 Nov 2021 16:48:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <6e18ae5a-f4b5-2330-7168-6953f0c812a7@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 10.11.21 um 16:45 schrieb philip yang:
>
> On 2021-11-10 9:54 a.m., Christian König wrote:
>
>> Am 10.11.21 um 15:44 schrieb philip yang:
>>>
>>> On 2021-11-10 9:31 a.m., Christian König wrote:
>>>
>>>> Am 10.11.21 um 14:59 schrieb philip yang:
>>>>>
>>>>> On 2021-11-10 5:15 a.m., Christian König wrote:
>>>>>
>>>>>> [SNIP]
>>>>>
>>>>> It is hard to understand, this debug log can explain more details, 
>>>>> with this debug message patch
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
>>>>> index ed6f8d24280b..8859f2bb11b1 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
>>>>> @@ -234,10 +235,12 @@ int amdgpu_ih_process(struct amdgpu_device 
>>>>> *adev, struct amdgpu_ih_ring *ih)
>>>>>                 return IRQ_NONE;
>>>>>
>>>>>         wptr = amdgpu_ih_get_wptr(adev, ih);
>>>>> +       if (ih == &adev->irq.ih1)
>>>>> +               pr_debug("entering rptr 0x%x, wptr 0x%x\n", 
>>>>> ih->rptr, wptr);
>>>>>
>>>>>  restart_ih:
>>>>> +       if (ih == &adev->irq.ih1)
>>>>> +               pr_debug("starting rptr 0x%x, wptr 0x%x\n", 
>>>>> ih->rptr, wptr);
>>>>>
>>>>>         /* Order reading of wptr vs. reading of IH ring data */
>>>>>         rmb();
>>>>> @@ -245,8 +248,12 @@ int amdgpu_ih_process(struct amdgpu_device 
>>>>> *adev, struct amdgpu_ih_ring *ih)
>>>>>         while (ih->rptr != wptr && --count) {
>>>>>                 amdgpu_irq_dispatch(adev, ih);
>>>>>                 ih->rptr &= ih->ptr_mask;
>>>>> +               if (ih == &adev->irq.ih1) {
>>>>> +                       pr_debug("rptr 0x%x, old wptr 0x%x, new 
>>>>> wptr 0x%x\n",
>>>>> +                               ih->rptr, wptr,
>>>>> +                               amdgpu_ih_get_wptr(adev, ih));
>>>>> +               }
>>>>>         }
>>>>>
>>>>>         amdgpu_ih_set_rptr(adev, ih);
>>>>> @@ -257,6 +264,8 @@ int amdgpu_ih_process(struct amdgpu_device 
>>>>> *adev, struct amdgpu_ih_ring *ih)
>>>>>         if (wptr != ih->rptr)
>>>>>                 goto restart_ih;
>>>>>
>>>>> +       if (ih == &adev->irq.ih1)
>>>>> +               pr_debug("exiting rptr 0x%x, wptr 0x%x\n", 
>>>>> ih->rptr, wptr);
>>>>>         return IRQ_HANDLED;
>>>>>  }
>>>>>
>>>>> This is log, timing 48.807028, ring1 drain is done, rptr == wptr, 
>>>>> ring1 is empty, but the loop continues, to handle outdated retry 
>>>>> fault.
>>>>>
>>>>
>>>> As far as I can see that is perfectly correct and expected behavior.
>>>>
>>>> See the ring buffer overflowed and because of that the loop 
>>>> continues, but that is correct because an overflow means that the 
>>>> ring was filled with new entries.
>>>>
>>>> So we are processing new entries here, not stale ones.
>>>
>>> wptr is 0x840, 0x860.....0xd20 is not new entries, it is stale retry 
>>> fault, the loop will continue handle stale fault to 0xd20 and then 
>>> exit loop, it is because wptr pass rptr after timing 48.806122.
>>>
>>
>> Yeah, but 0x840..0xd20 still contain perfectly valid IVs which you 
>> drop on the ground with your approach. That's not something we can do.
>
> We drain retry fault in unmap from cpu notifier, drain finish 
> condition is ring checkpoint is processed, or ring is empty rptr=wptr 
> (to fix another issue, IH ring1 do not setup ring wptr overflow flag 
> after wptr exceed rptr).
>
> After drain retry fault returns, we are not expecting retry fault on 
> the range as queue should not access the range, so we free range as it 
> is unmapped from cpu. From this point of view, 0x860..0xd20 are stale 
> retry fault.
>

I think we should probably rethink that approach.

>>
>> What can happen is that the ring buffer overflows and we process the 
>> same IV twice, but that is also perfectly expected behavior when an 
>> overflow happens.
>
> After wptr exceed rptr, because no overflow flag, we just drain the 
> fault until rptr=wptr, yes, this drops many retry faults, it is ok as 
> real retry fault will come in again.
>

No, that is absolutely not ok.For the current hardware we are flooded 
with retry faults because of the hw design, but this here is supposed to 
work independent on the hardware design.

Dropping IVs is completely out of question. Processing the same IV twice 
is just the lesser evil here.

So from that point of view this patch is clearly a NAK.

Regards,
Christian.

> Regards,
>
> Philip
>
>>
>> Regards,
>> Christian.
>>
>>> Regards.
>>>
>>> Philip
>>>
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> [   48.802231] amdgpu_ih_process:243: amdgpu: starting rptr 0x520, 
>>>>> wptr 0xd20
>>>>> [   48.802235] amdgpu_ih_process:254: amdgpu: rptr 0x540, old wptr 
>>>>> 0xd20, new wptr 0xd20
>>>>> [   48.802256] amdgpu_ih_process:254: amdgpu: rptr 0x560, old wptr 
>>>>> 0xd20, new wptr 0xd20
>>>>> [   48.802260] amdgpu_ih_process:254: amdgpu: rptr 0x580, old wptr 
>>>>> 0xd20, new wptr 0xd20
>>>>> [   48.802281] amdgpu_ih_process:254: amdgpu: rptr 0x5a0, old wptr 
>>>>> 0xd20, new wptr 0xd20
>>>>> [   48.802314] amdgpu_ih_process:254: amdgpu: rptr 0x5c0, old wptr 
>>>>> 0xd20, new wptr 0xce0
>>>>> [   48.802335] amdgpu_ih_process:254: amdgpu: rptr 0x5e0, old wptr 
>>>>> 0xd20, new wptr 0xce0
>>>>> [   48.802356] amdgpu_ih_process:254: amdgpu: rptr 0x600, old wptr 
>>>>> 0xd20, new wptr 0xce0
>>>>> [   48.802376] amdgpu_ih_process:254: amdgpu: rptr 0x620, old wptr 
>>>>> 0xd20, new wptr 0xce0
>>>>> [   48.802396] amdgpu_ih_process:254: amdgpu: rptr 0x640, old wptr 
>>>>> 0xd20, new wptr 0xce0
>>>>> [   48.802401] amdgpu_ih_process:254: amdgpu: rptr 0x660, old wptr 
>>>>> 0xd20, new wptr 0xce0
>>>>> [   48.802421] amdgpu_ih_process:254: amdgpu: rptr 0x680, old wptr 
>>>>> 0xd20, new wptr 0xce0
>>>>> [   48.802442] amdgpu_ih_process:254: amdgpu: rptr 0x6a0, old wptr 
>>>>> 0xd20, new wptr 0xce0
>>>>> [   48.802463] amdgpu_ih_process:254: amdgpu: rptr 0x6c0, old wptr 
>>>>> 0xd20, new wptr 0xce0
>>>>> [   48.802483] amdgpu_ih_process:254: amdgpu: rptr 0x6e0, old wptr 
>>>>> 0xd20, new wptr 0xce0
>>>>> [   48.802503] amdgpu_ih_process:254: amdgpu: rptr 0x700, old wptr 
>>>>> 0xd20, new wptr 0xce0
>>>>> [   48.802523] amdgpu_ih_process:254: amdgpu: rptr 0x720, old wptr 
>>>>> 0xd20, new wptr 0xce0
>>>>> [   48.802544] amdgpu_ih_process:254: amdgpu: rptr 0x740, old wptr 
>>>>> 0xd20, new wptr 0xce0
>>>>> [   48.802565] amdgpu_ih_process:254: amdgpu: rptr 0x760, old wptr 
>>>>> 0xd20, new wptr 0xce0
>>>>> [   48.802569] amdgpu_ih_process:254: amdgpu: rptr 0x780, old wptr 
>>>>> 0xd20, new wptr 0xce0
>>>>> [   48.804392] amdgpu_ih_process:254: amdgpu: rptr 0x7a0, old wptr 
>>>>> 0xd20, new wptr 0xf00
>>>>> [   48.806122] amdgpu_ih_process:254: amdgpu: rptr 0x7c0, old wptr 
>>>>> 0xd20, new wptr 0x840
>>>>> [   48.806155] amdgpu_ih_process:254: amdgpu: rptr 0x7e0, old wptr 
>>>>> 0xd20, new wptr 0x840
>>>>> [   48.806965] amdgpu_ih_process:254: amdgpu: rptr 0x800, old wptr 
>>>>> 0xd20, new wptr 0x840
>>>>> [   48.806995] amdgpu_ih_process:254: amdgpu: rptr 0x820, old wptr 
>>>>> 0xd20, new wptr 0x840
>>>>> [   48.807028] amdgpu_ih_process:254: amdgpu: rptr 0x840, old wptr 
>>>>> 0xd20, new wptr 0x840
>>>>> [   48.807063] amdgpu_ih_process:254: amdgpu: rptr 0x860, old wptr 
>>>>> 0xd20, new wptr 0x840
>>>>> [   48.808421] amdgpu_ih_process:254: amdgpu: rptr 0x880, old wptr 
>>>>> 0xd20, new wptr 0x840
>>>>>
>>>>> Cause this gpu vm fault dump because address is unmapped from cpu.
>>>>>
>>>>> [   48.807071] svm_range_restore_pages:2617: amdgpu: restoring 
>>>>> svms 0x00000000733bf007 fault address 0x7f8a6991f
>>>>>
>>>>> [   48.807170] svm_range_restore_pages:2631: amdgpu: failed to 
>>>>> find prange svms 0x00000000733bf007 address [0x7f8a6991f]
>>>>> [   48.807179] svm_range_get_range_boundaries:2348: amdgpu: VMA 
>>>>> does not exist in address [0x7f8a6991f]
>>>>> [   48.807185] svm_range_restore_pages:2635: amdgpu: failed to 
>>>>> create unregistered range svms 0x00000000733bf007 address 
>>>>> [0x7f8a6991f]
>>>>>
>>>>> [   48.807929] amdgpu 0000:25:00.0: amdgpu: [mmhub0] retry page 
>>>>> fault (src_id:0 ring:0 vmid:8 pasid:32770, for process kfdtest pid 
>>>>> 3969 thread kfdtest pid 3969)
>>>>> [   48.808219] amdgpu 0000:25:00.0: amdgpu:   in page starting at 
>>>>> address 0x00007f8a6991f000 from IH client 0x12 (VMC)
>>>>> [   48.808230] amdgpu 0000:25:00.0: amdgpu: 
>>>>> VM_L2_PROTECTION_FAULT_STATUS:0x00800031
>>>>>
>>>>>> We could of course parameterize that so that we check the wptr 
>>>>>> after each IV on IH1, but please not hard coded like this.
>>>>>>
>>>>>> Regards,
>>>>>> Christian.
>>>>>>
>>>>>>>       }
>>>>>>>         amdgpu_ih_set_rptr(adev, ih);
>>>>>>
>>>>
>>

