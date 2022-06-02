Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38CF2C43334
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jun 2022 18:52:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0C4E11361A;
	Thu,  2 Jun 2022 18:52:22 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7322011361A
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jun 2022 18:52:21 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id q1so11660666ejz.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 Jun 2022 11:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=MPhwZrQg9S84Wf6vg7uVPhlMm+f5CY8dqV/VLyAfuBw=;
 b=oq0Oj5WZrtVeCToBd1kuna2pDIG/OIcSP5sCE/a9nKTmq4UyBNAnFYgpUySZKQEOBN
 NPl0MIQUTZVafnBL5PEFuyr1VoqI7xYwlSQ1xGo32Vym/LoAVvR8SjxZYcb/euBs1i6A
 oYMB+9Kvwg8AjeNPcy3ML09vqcL/X9qMIi1ZqsvDOZtzyqjrDrPGZvo+p924KSX3LtDe
 b+/kflORVXp8V61UMV3QlocZtJia2KMWZt9yD270A/bP4fg1v3wTgz/PIaFBYwdFrqLK
 l7JHPM85wdhNlAo2ND6HJGU/bCV0Up62TjyqwXpAzHgO5c2/60r+UJJlxhlWXTAQTYpU
 GqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=MPhwZrQg9S84Wf6vg7uVPhlMm+f5CY8dqV/VLyAfuBw=;
 b=cTwRq3rM7Y08GgL48+PH7tsbPhZaib7x3amWMyp/m14Ie+fdygHxISxZhyuH1UAClE
 9uHuGSvrJh1lcL5ixUHD3nINfOIw34D+aaDFqby+iDAiP7IUM8LmwCi5U0yR/29GMMtL
 iWk5YCw2b2SWWHLiavJqsr6Uei00V7+tWAYyYTVRUaXDgdv4lBkDddxlXZS+t/RFmMLl
 pR40/Wr0aO1xqzk2CXXUDVT/avvBouSmYViMa+zLC2f2p0aPwMxQbUfkoemuMtXK3asl
 laKFXo+YxTaFP43emQacVKFzEoROVROc76IwUTK3bfO0rWaIWsQxjRPvizLxcdINsL3R
 4wiw==
X-Gm-Message-State: AOAM531Xz/2ZtI1CN5fZnjyWAajDDUQVZJWBnRL/6YRT/OGA3YAE+Y8p
 02PwVE4c2FFrdz4PDCskvmY=
X-Google-Smtp-Source: ABdhPJyf5gBogZIyln8GiCAO7vugc81ub5iuc53SRiQPxxUngbTe3nSBGMwX0iFW/ZAUd9imvkecRQ==
X-Received: by 2002:a17:907:720a:b0:6ff:2e1c:f22f with SMTP id
 dr10-20020a170907720a00b006ff2e1cf22fmr5610486ejc.16.1654195939812; 
 Thu, 02 Jun 2022 11:52:19 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:80:e84d:46c:65f5?
 ([2a02:908:1256:79a0:80:e84d:46c:65f5])
 by smtp.gmail.com with ESMTPSA id
 m9-20020a170906580900b006feb7b1379dsm1934465ejq.181.2022.06.02.11.52.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jun 2022 11:52:18 -0700 (PDT)
Message-ID: <f55b41ef-25d3-9839-29f0-d614ad5f1bda@gmail.com>
Date: Thu, 2 Jun 2022 20:52:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Explicit VM updates
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 "Olsak, Marek" <Marek.Olsak@amd.com>
References: <293d9f72-c3e5-913d-08d1-0a8591299c46@amd.com>
 <022d86d0-6301-70da-f320-b17c4859443b@amd.com>
 <412a23fc-eb92-8f3c-e339-0bc3918c0f18@amd.com>
 <4d563bf0-ade6-fc3e-9de1-cc2522c4a57f@amd.com>
 <743af352-bdce-a69c-7ecc-2fc99441c82b@amd.com>
 <58b622db-3a30-f6c5-cdda-0136d85b531a@amd.com>
 <14a39f90-4ba9-3dea-bc38-324d0ee34193@amd.com>
 <337ce13f-b852-f02b-b6e1-53c0b3bbff80@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <337ce13f-b852-f02b-b6e1-53c0b3bbff80@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 02.06.22 um 16:21 schrieb Felix Kuehling:
> [SNIP]
>>>>>>
>>>>>> In other words the free is not waiting for the unmap to complete, 
>>>>>> but causes command submissions through the kernel to depend on 
>>>>>> the unmap.
>>>>>
>>>>> I guess I don't understand that dependency. The next command 
>>>>> submission obviously cannot use the memory that was unmapped. But 
>>>>> why does it need to synchronize with the unmap operation?
>>>>
>>>> Because of the necessary TLB flush, only after that one is executed 
>>>> we can be sure that nobody has access to the memory any more and 
>>>> actually free it.
>>>
>>> So freeing the memory has to wait for the TLB flush. Why does the 
>>> next command submission need to wait?
>>
>> Because that's the one triggering the TLB flush. The issue is that 
>> flushing the TLB while the VMID is in use is really unreliable on 
>> most hardware generations.
>
> It's been working well enough with ROCm. With user mode command 
> submission there is no way to block GPU work while a TLB flush is in 
> progress.

Yeah, but at least on Navi 1x that's so horrible broken that the SDMA 
could write anywhere when we would try this.

>>
>>>>>>
>>>>>> User mode submissions are completely unrelated to that.
>>>>>
>>>>> I mention user mode command submission because there is no way to 
>>>>> enforce the synchronization you describe here on a user mode 
>>>>> queue. So this approach is not very future proof.
>>>>
>>>> With user mode queues you need to wait for the work on the queue to 
>>>> finish anyway or otherwise you run into VM faults if you just unmap 
>>>> or free the memory.
>>>
>>> If the next command submission doesn't use the unmapped/freed 
>>> memory, why does it need to wait for the TLB flush?
>>
>> Because it could potentially use it. When userspace lies to the 
>> kernel and still accesses the mapping we would allow access to freed 
>> up memory and create a major security problem.
>
> I'm aware of the potential security problem. That's why I'm 
> recommending you don't actually free the memory until the TLB flush is 
> done. So a bogus access will either harmlessly access memory that's 
> not freed yet, or it will VM fault. It will never access memory that's 
> already freed and potentially allocated by someone else.

Yes, that's the idea. The question is just when we can do the TLB flush.

>>> If it is using the unmapped/freed memory, that's a user mode bug. 
>>> But waiting for the TLB flush won't fix that. It will only turn a 
>>> likely VM fault into a certain VM fault.
>>
>> Yeah, exactly that's the intention here.
>>
>>>
>>> The guarantee you need to give is, that the memory is not freed and 
>>> reused by anyone else until the TLB flush is done. This dependency 
>>> requires synchronization of the "free" operation with the TLB flush. 
>>> It does not require synchronization with any future command 
>>> submissions in the context that freed the memory.
>>
>> See above, the future command submission is what triggers the TLB 
>> flush because only then we can easily execute it without to much hassle.
>
> That seems to be a limitation of your current command submission 
> model. User mode command submission will not be able to trigger a TLB 
> flush. Unmapping or freeing memory should be the trigger in that case.
>
> That's how it works with KFD. That said, our TLB flushes aren't as 
> well pipelined (which could probably be improved), and your strategy 
> can probably batch more TLB flushes, so I see where you're coming from.

Well the mapping/unmapping IOCTL should certainly trigger the TLB 
flushes for the user mode queues, but as I said this is completely 
independent to this here.

The limitation is on the kernel CS IOCTL, not the VM IOCTL. So that is 
completely unrelated to this.

>>
>> For Vega and Navi 2x we could use async TLB flushes and on gfx6, gfx7 
>> and gfx8 we could use double TLB flushes with grace time, but Navi 1x 
>> is so horrible broken regarding this that I don't see how else we 
>> could do that.
>
> We're using heavy-weight TLB flushes on SOC15 GPUs. On Vega20 with 
> XGMI we need double flushes to be safe.
>
> I'm raising my concerns because I don't think making user mode wait is 
> a good strategy long-term. And I believe this explicit sync and 
> explicit VM update should be designed with an eye for future user-mode 
> command submission models.

Yeah, but as already discussed with Daniel and Jason that will never 
ever work correctly. IOCTLs can't depend on user mode queues in any way. 
So user space can only block or rather call the map, unmap, free 
functions at the right time.

> If you need short-term workarounds for broken hardware, that's another 
> issue. But it would be good if that could be kept out of the API.

Well as I said that is completely unrelated to user mode queues. The 
restriction is on the CS API, not the VM API.

Regards,
Christian.

>
>
> Regards,
>   Felix
>
>
>>
>> Regards,
>> Christian.
>>
>>>
>>> Regards,
>>>   Felix
>>>
>>>
>>>>
>>>> The signal that TLB flush is completed comes from the MES in this 
>>>> case.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>
>>>>> Regards,
>>>>>   Felix
>>>>>
>>>>>
>>>>>>
>>>>>> Regards,
>>>>>> Christian.
>>>>>>
>>>>>>>
>>>>>>> Regards,
>>>>>>>   Felix
>>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> 3. All VM operations requested by userspace will still be 
>>>>>>>> executed in order, e.g. we can't run unmap + map in parallel or 
>>>>>>>> something like this.
>>>>>>>>
>>>>>>>> Is that something you guys can live with? As far as I can see 
>>>>>>>> it should give you the maximum freedom possible, but is still 
>>>>>>>> doable.
>>>>>>>>
>>>>>>>> Regards,
>>>>>>>> Christian.
>>>>>>
>>>>
>>

